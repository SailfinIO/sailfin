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

declare void @sailfin_runtime_bounds_check(i64, i64)
declare i8* @sailfin_runtime_substring(i8*, i64, i64)
declare i64 @sailfin_runtime_string_length(i8*)
declare i8* @sailfin_runtime_string_concat(i8*, i8*)
declare double @char_code(i8*)
declare { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }*, i8*)
declare { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }*, { i8**, i64 }*)
declare i8* @sailfin_runtime_get_field(i8*, i8*)

declare noalias i8* @malloc(i64)

@runtime = external global i8**

@.str.len6.h1187178968 = private unnamed_addr constant [7 x i8] c".case \00"
@.str.len2.h193445474 = private unnamed_addr constant [3 x i8] c"=>\00"
@.str.len4.h175987322 = private unnamed_addr constant [5 x i8] c" if \00"
@.str.len4.h175713983 = private unnamed_addr constant [5 x i8] c" as \00"
@.str.len8.h2093451461 = private unnamed_addr constant [9 x i8] c".struct \00"
@.str.len11.h599952843 = private unnamed_addr constant [12 x i8] c".interface \00"
@.str.len0.h177573 = private unnamed_addr constant [1 x i8] c"\00"
@.str.len4.h278197661 = private unnamed_addr constant [5 x i8] c"void\00"
@.str.len6.h1280947313 = private unnamed_addr constant [7 x i8] c".enum \00"
@.str.len2.h193428050 = private unnamed_addr constant [3 x i8] c"->\00"
@.str.len5.h2064124065 = private unnamed_addr constant [6 x i8] c".let \00"

define %NativeArtifact* @select_text_artifact({ %NativeArtifact*, i64 }* %artifacts) {
block.entry:
  %l0 = alloca double
  %l1 = alloca %NativeArtifact
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t28 = phi double [ %t1, %block.entry ], [ %t27, %loop.latch2 ]
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
  call void @sailfin_runtime_bounds_check(i64 %t9, i64 %t12)
  %t14 = getelementptr %NativeArtifact, %NativeArtifact* %t11, i64 %t9
  %t15 = load %NativeArtifact, %NativeArtifact* %t14
  store %NativeArtifact %t15, %NativeArtifact* %l1
  %t16 = load %NativeArtifact, %NativeArtifact* %l1
  %t17 = extractvalue %NativeArtifact %t16, 1
  %s18 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h1782433603, i32 0, i32 0
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
  %t29 = load double, double* %l0
  %t30 = bitcast i8* null to %NativeArtifact*
  ret %NativeArtifact* %t30
}

define %NativeArtifact* @select_layout_manifest_artifact({ %NativeArtifact*, i64 }* %artifacts) {
block.entry:
  %l0 = alloca double
  %l1 = alloca %NativeArtifact
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t28 = phi double [ %t1, %block.entry ], [ %t27, %loop.latch2 ]
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
  call void @sailfin_runtime_bounds_check(i64 %t9, i64 %t12)
  %t14 = getelementptr %NativeArtifact, %NativeArtifact* %t11, i64 %t9
  %t15 = load %NativeArtifact, %NativeArtifact* %t14
  store %NativeArtifact %t15, %NativeArtifact* %l1
  %t16 = load %NativeArtifact, %NativeArtifact* %l1
  %t17 = extractvalue %NativeArtifact %t16, 1
  %s18 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.len23.h668778749, i32 0, i32 0
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
  %t29 = load double, double* %l0
  %t30 = bitcast i8* null to %NativeArtifact*
  ret %NativeArtifact* %t30
}

define %ParseNativeResult @parse_native_artifact(i8* %text) {
block.entry:
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
  %t1 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t2 = ptrtoint [0 x i8*]* %t1 to i64
  %t3 = icmp eq i64 %t2, 0
  %t4 = select i1 %t3, i64 1, i64 %t2
  %t5 = call i8* @malloc(i64 %t4)
  %t6 = bitcast i8* %t5 to i8**
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t8 = ptrtoint { i8**, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { i8**, i64 }*
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 0
  store i8** %t6, i8*** %t11
  %t12 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 1
  store i64 0, i64* %t12
  store { i8**, i64 }* %t10, { i8**, i64 }** %l1
  %t13 = getelementptr [0 x %NativeFunction], [0 x %NativeFunction]* null, i32 1
  %t14 = ptrtoint [0 x %NativeFunction]* %t13 to i64
  %t15 = icmp eq i64 %t14, 0
  %t16 = select i1 %t15, i64 1, i64 %t14
  %t17 = call i8* @malloc(i64 %t16)
  %t18 = bitcast i8* %t17 to %NativeFunction*
  %t19 = getelementptr { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* null, i32 1
  %t20 = ptrtoint { %NativeFunction*, i64 }* %t19 to i64
  %t21 = call i8* @malloc(i64 %t20)
  %t22 = bitcast i8* %t21 to { %NativeFunction*, i64 }*
  %t23 = getelementptr { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %t22, i32 0, i32 0
  store %NativeFunction* %t18, %NativeFunction** %t23
  %t24 = getelementptr { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %t22, i32 0, i32 1
  store i64 0, i64* %t24
  store { %NativeFunction*, i64 }* %t22, { %NativeFunction*, i64 }** %l2
  %t25 = getelementptr [0 x %NativeImport], [0 x %NativeImport]* null, i32 1
  %t26 = ptrtoint [0 x %NativeImport]* %t25 to i64
  %t27 = icmp eq i64 %t26, 0
  %t28 = select i1 %t27, i64 1, i64 %t26
  %t29 = call i8* @malloc(i64 %t28)
  %t30 = bitcast i8* %t29 to %NativeImport*
  %t31 = getelementptr { %NativeImport*, i64 }, { %NativeImport*, i64 }* null, i32 1
  %t32 = ptrtoint { %NativeImport*, i64 }* %t31 to i64
  %t33 = call i8* @malloc(i64 %t32)
  %t34 = bitcast i8* %t33 to { %NativeImport*, i64 }*
  %t35 = getelementptr { %NativeImport*, i64 }, { %NativeImport*, i64 }* %t34, i32 0, i32 0
  store %NativeImport* %t30, %NativeImport** %t35
  %t36 = getelementptr { %NativeImport*, i64 }, { %NativeImport*, i64 }* %t34, i32 0, i32 1
  store i64 0, i64* %t36
  store { %NativeImport*, i64 }* %t34, { %NativeImport*, i64 }** %l3
  %t37 = getelementptr [0 x %NativeStruct], [0 x %NativeStruct]* null, i32 1
  %t38 = ptrtoint [0 x %NativeStruct]* %t37 to i64
  %t39 = icmp eq i64 %t38, 0
  %t40 = select i1 %t39, i64 1, i64 %t38
  %t41 = call i8* @malloc(i64 %t40)
  %t42 = bitcast i8* %t41 to %NativeStruct*
  %t43 = getelementptr { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* null, i32 1
  %t44 = ptrtoint { %NativeStruct*, i64 }* %t43 to i64
  %t45 = call i8* @malloc(i64 %t44)
  %t46 = bitcast i8* %t45 to { %NativeStruct*, i64 }*
  %t47 = getelementptr { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* %t46, i32 0, i32 0
  store %NativeStruct* %t42, %NativeStruct** %t47
  %t48 = getelementptr { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* %t46, i32 0, i32 1
  store i64 0, i64* %t48
  store { %NativeStruct*, i64 }* %t46, { %NativeStruct*, i64 }** %l4
  %t49 = getelementptr [0 x %NativeInterface], [0 x %NativeInterface]* null, i32 1
  %t50 = ptrtoint [0 x %NativeInterface]* %t49 to i64
  %t51 = icmp eq i64 %t50, 0
  %t52 = select i1 %t51, i64 1, i64 %t50
  %t53 = call i8* @malloc(i64 %t52)
  %t54 = bitcast i8* %t53 to %NativeInterface*
  %t55 = getelementptr { %NativeInterface*, i64 }, { %NativeInterface*, i64 }* null, i32 1
  %t56 = ptrtoint { %NativeInterface*, i64 }* %t55 to i64
  %t57 = call i8* @malloc(i64 %t56)
  %t58 = bitcast i8* %t57 to { %NativeInterface*, i64 }*
  %t59 = getelementptr { %NativeInterface*, i64 }, { %NativeInterface*, i64 }* %t58, i32 0, i32 0
  store %NativeInterface* %t54, %NativeInterface** %t59
  %t60 = getelementptr { %NativeInterface*, i64 }, { %NativeInterface*, i64 }* %t58, i32 0, i32 1
  store i64 0, i64* %t60
  store { %NativeInterface*, i64 }* %t58, { %NativeInterface*, i64 }** %l5
  %t61 = getelementptr [0 x %NativeEnum], [0 x %NativeEnum]* null, i32 1
  %t62 = ptrtoint [0 x %NativeEnum]* %t61 to i64
  %t63 = icmp eq i64 %t62, 0
  %t64 = select i1 %t63, i64 1, i64 %t62
  %t65 = call i8* @malloc(i64 %t64)
  %t66 = bitcast i8* %t65 to %NativeEnum*
  %t67 = getelementptr { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* null, i32 1
  %t68 = ptrtoint { %NativeEnum*, i64 }* %t67 to i64
  %t69 = call i8* @malloc(i64 %t68)
  %t70 = bitcast i8* %t69 to { %NativeEnum*, i64 }*
  %t71 = getelementptr { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* %t70, i32 0, i32 0
  store %NativeEnum* %t66, %NativeEnum** %t71
  %t72 = getelementptr { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* %t70, i32 0, i32 1
  store i64 0, i64* %t72
  store { %NativeEnum*, i64 }* %t70, { %NativeEnum*, i64 }** %l6
  %t73 = getelementptr [0 x %NativeBinding], [0 x %NativeBinding]* null, i32 1
  %t74 = ptrtoint [0 x %NativeBinding]* %t73 to i64
  %t75 = icmp eq i64 %t74, 0
  %t76 = select i1 %t75, i64 1, i64 %t74
  %t77 = call i8* @malloc(i64 %t76)
  %t78 = bitcast i8* %t77 to %NativeBinding*
  %t79 = getelementptr { %NativeBinding*, i64 }, { %NativeBinding*, i64 }* null, i32 1
  %t80 = ptrtoint { %NativeBinding*, i64 }* %t79 to i64
  %t81 = call i8* @malloc(i64 %t80)
  %t82 = bitcast i8* %t81 to { %NativeBinding*, i64 }*
  %t83 = getelementptr { %NativeBinding*, i64 }, { %NativeBinding*, i64 }* %t82, i32 0, i32 0
  store %NativeBinding* %t78, %NativeBinding** %t83
  %t84 = getelementptr { %NativeBinding*, i64 }, { %NativeBinding*, i64 }* %t82, i32 0, i32 1
  store i64 0, i64* %t84
  store { %NativeBinding*, i64 }* %t82, { %NativeBinding*, i64 }** %l7
  %t85 = bitcast i8* null to %NativeFunction*
  store %NativeFunction* %t85, %NativeFunction** %l8
  %t86 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t86, %NativeSourceSpan** %l9
  %t87 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t87, %NativeSourceSpan** %l10
  %t88 = sitofp i64 0 to double
  store double %t88, double* %l11
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t91 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t92 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t93 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t94 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t95 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t96 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t97 = load %NativeFunction*, %NativeFunction** %l8
  %t98 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t99 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t100 = load double, double* %l11
  br label %loop.header0
loop.header0:
  %t1476 = phi double [ %t100, %block.entry ], [ %t1465, %loop.latch2 ]
  %t1477 = phi { i8**, i64 }* [ %t90, %block.entry ], [ %t1466, %loop.latch2 ]
  %t1478 = phi { %NativeImport*, i64 }* [ %t92, %block.entry ], [ %t1467, %loop.latch2 ]
  %t1479 = phi %NativeSourceSpan* [ %t98, %block.entry ], [ %t1468, %loop.latch2 ]
  %t1480 = phi %NativeSourceSpan* [ %t99, %block.entry ], [ %t1469, %loop.latch2 ]
  %t1481 = phi { %NativeStruct*, i64 }* [ %t93, %block.entry ], [ %t1470, %loop.latch2 ]
  %t1482 = phi { %NativeInterface*, i64 }* [ %t94, %block.entry ], [ %t1471, %loop.latch2 ]
  %t1483 = phi { %NativeEnum*, i64 }* [ %t95, %block.entry ], [ %t1472, %loop.latch2 ]
  %t1484 = phi %NativeFunction* [ %t97, %block.entry ], [ %t1473, %loop.latch2 ]
  %t1485 = phi { %NativeFunction*, i64 }* [ %t91, %block.entry ], [ %t1474, %loop.latch2 ]
  %t1486 = phi { %NativeBinding*, i64 }* [ %t96, %block.entry ], [ %t1475, %loop.latch2 ]
  store double %t1476, double* %l11
  store { i8**, i64 }* %t1477, { i8**, i64 }** %l1
  store { %NativeImport*, i64 }* %t1478, { %NativeImport*, i64 }** %l3
  store %NativeSourceSpan* %t1479, %NativeSourceSpan** %l9
  store %NativeSourceSpan* %t1480, %NativeSourceSpan** %l10
  store { %NativeStruct*, i64 }* %t1481, { %NativeStruct*, i64 }** %l4
  store { %NativeInterface*, i64 }* %t1482, { %NativeInterface*, i64 }** %l5
  store { %NativeEnum*, i64 }* %t1483, { %NativeEnum*, i64 }** %l6
  store %NativeFunction* %t1484, %NativeFunction** %l8
  store { %NativeFunction*, i64 }* %t1485, { %NativeFunction*, i64 }** %l2
  store { %NativeBinding*, i64 }* %t1486, { %NativeBinding*, i64 }** %l7
  br label %loop.body1
loop.body1:
  %t101 = load double, double* %l11
  %t102 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t103 = load { i8**, i64 }, { i8**, i64 }* %t102
  %t104 = extractvalue { i8**, i64 } %t103, 1
  %t105 = sitofp i64 %t104 to double
  %t106 = fcmp oge double %t101, %t105
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
  br i1 %t106, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t119 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t120 = load double, double* %l11
  %t121 = fptosi double %t120 to i64
  %t122 = load { i8**, i64 }, { i8**, i64 }* %t119
  %t123 = extractvalue { i8**, i64 } %t122, 0
  %t124 = extractvalue { i8**, i64 } %t122, 1
  %t125 = icmp uge i64 %t121, %t124
  ; bounds check: %t125 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t121, i64 %t124)
  %t126 = getelementptr i8*, i8** %t123, i64 %t121
  %t127 = load i8*, i8** %t126
  store i8* %t127, i8** %l12
  %t128 = load i8*, i8** %l12
  %t129 = call i8* @trim_text(i8* %t128)
  store i8* %t129, i8** %l13
  %t130 = load i8*, i8** %l13
  %t131 = call i64 @sailfin_runtime_string_length(i8* %t130)
  %t132 = icmp eq i64 %t131, 0
  %t133 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t134 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t135 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t136 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t137 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t138 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t139 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t140 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t141 = load %NativeFunction*, %NativeFunction** %l8
  %t142 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t143 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t144 = load double, double* %l11
  %t145 = load i8*, i8** %l12
  %t146 = load i8*, i8** %l13
  br i1 %t132, label %then6, label %merge7
then6:
  %t147 = load double, double* %l11
  %t148 = sitofp i64 1 to double
  %t149 = fadd double %t147, %t148
  store double %t149, double* %l11
  br label %loop.latch2
merge7:
  %t150 = load i8*, i8** %l13
  %t151 = alloca [2 x i8], align 1
  %t152 = getelementptr [2 x i8], [2 x i8]* %t151, i32 0, i32 0
  store i8 59, i8* %t152
  %t153 = getelementptr [2 x i8], [2 x i8]* %t151, i32 0, i32 1
  store i8 0, i8* %t153
  %t154 = getelementptr [2 x i8], [2 x i8]* %t151, i32 0, i32 0
  %t155 = call i1 @starts_with(i8* %t150, i8* %t154)
  %t156 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t157 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t158 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t159 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t160 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t161 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t162 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t163 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t164 = load %NativeFunction*, %NativeFunction** %l8
  %t165 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t166 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t167 = load double, double* %l11
  %t168 = load i8*, i8** %l12
  %t169 = load i8*, i8** %l13
  br i1 %t155, label %then8, label %merge9
then8:
  %t170 = load double, double* %l11
  %t171 = sitofp i64 1 to double
  %t172 = fadd double %t170, %t171
  store double %t172, double* %l11
  br label %loop.latch2
merge9:
  %t173 = load i8*, i8** %l13
  %s174 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1370870284, i32 0, i32 0
  %t175 = call i1 @starts_with(i8* %t173, i8* %s174)
  %t176 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t177 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t178 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t179 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t180 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t181 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t182 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t183 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t184 = load %NativeFunction*, %NativeFunction** %l8
  %t185 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t186 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t187 = load double, double* %l11
  %t188 = load i8*, i8** %l12
  %t189 = load i8*, i8** %l13
  br i1 %t175, label %then10, label %merge11
then10:
  %t190 = load double, double* %l11
  %t191 = sitofp i64 1 to double
  %t192 = fadd double %t190, %t191
  store double %t192, double* %l11
  br label %loop.latch2
merge11:
  %t193 = load i8*, i8** %l13
  %s194 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h575595345, i32 0, i32 0
  %t195 = call i1 @starts_with(i8* %t193, i8* %s194)
  %t196 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t197 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t198 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t199 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t200 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t201 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t202 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t203 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t204 = load %NativeFunction*, %NativeFunction** %l8
  %t205 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t206 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t207 = load double, double* %l11
  %t208 = load i8*, i8** %l12
  %t209 = load i8*, i8** %l13
  br i1 %t195, label %then12, label %merge13
then12:
  %s210 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h483393773, i32 0, i32 0
  %t211 = load i8*, i8** %l13
  %s212 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h575595345, i32 0, i32 0
  %t213 = call i8* @strip_prefix(i8* %t211, i8* %s212)
  %t214 = call %NativeImport* @parse_import_entry(i8* %s210, i8* %t213)
  store %NativeImport* %t214, %NativeImport** %l14
  %t215 = load %NativeImport*, %NativeImport** %l14
  %t216 = icmp eq %NativeImport* %t215, null
  %t217 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t218 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t219 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t220 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t221 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t222 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t223 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t224 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t225 = load %NativeFunction*, %NativeFunction** %l8
  %t226 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t227 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t228 = load double, double* %l11
  %t229 = load i8*, i8** %l12
  %t230 = load i8*, i8** %l13
  %t231 = load %NativeImport*, %NativeImport** %l14
  br i1 %t216, label %then14, label %else15
then14:
  %t232 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s233 = getelementptr inbounds [25 x i8], [25 x i8]* @.str.len24.h457168017, i32 0, i32 0
  %t234 = load i8*, i8** %l13
  %t235 = call i8* @sailfin_runtime_string_concat(i8* %s233, i8* %t234)
  %t236 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t232, i8* %t235)
  store { i8**, i64 }* %t236, { i8**, i64 }** %l1
  %t237 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge16
else15:
  %t238 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t239 = load %NativeImport*, %NativeImport** %l14
  %t240 = load %NativeImport, %NativeImport* %t239
  %t241 = call { %NativeImport*, i64 }* @append_import({ %NativeImport*, i64 }* %t238, %NativeImport %t240)
  store { %NativeImport*, i64 }* %t241, { %NativeImport*, i64 }** %l3
  %t242 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  br label %merge16
merge16:
  %t243 = phi { i8**, i64 }* [ %t237, %then14 ], [ %t218, %else15 ]
  %t244 = phi { %NativeImport*, i64 }* [ %t220, %then14 ], [ %t242, %else15 ]
  store { i8**, i64 }* %t243, { i8**, i64 }** %l1
  store { %NativeImport*, i64 }* %t244, { %NativeImport*, i64 }** %l3
  %t245 = load double, double* %l11
  %t246 = sitofp i64 1 to double
  %t247 = fadd double %t245, %t246
  store double %t247, double* %l11
  br label %loop.latch2
merge13:
  %t248 = load i8*, i8** %l13
  %s249 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1074277327, i32 0, i32 0
  %t250 = call i1 @starts_with(i8* %t248, i8* %s249)
  %t251 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t252 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t253 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t254 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t255 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t256 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t257 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t258 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t259 = load %NativeFunction*, %NativeFunction** %l8
  %t260 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t261 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t262 = load double, double* %l11
  %t263 = load i8*, i8** %l12
  %t264 = load i8*, i8** %l13
  br i1 %t250, label %then17, label %merge18
then17:
  %s265 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h42978514, i32 0, i32 0
  %t266 = load i8*, i8** %l13
  %s267 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1074277327, i32 0, i32 0
  %t268 = call i8* @strip_prefix(i8* %t266, i8* %s267)
  %t269 = call %NativeImport* @parse_import_entry(i8* %s265, i8* %t268)
  store %NativeImport* %t269, %NativeImport** %l15
  %t270 = load %NativeImport*, %NativeImport** %l15
  %t271 = icmp eq %NativeImport* %t270, null
  %t272 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t273 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t274 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t275 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t276 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t277 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t278 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t279 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t280 = load %NativeFunction*, %NativeFunction** %l8
  %t281 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t282 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t283 = load double, double* %l11
  %t284 = load i8*, i8** %l12
  %t285 = load i8*, i8** %l13
  %t286 = load %NativeImport*, %NativeImport** %l15
  br i1 %t271, label %then19, label %else20
then19:
  %t287 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s288 = getelementptr inbounds [25 x i8], [25 x i8]* @.str.len24.h1881287894, i32 0, i32 0
  %t289 = load i8*, i8** %l13
  %t290 = call i8* @sailfin_runtime_string_concat(i8* %s288, i8* %t289)
  %t291 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t287, i8* %t290)
  store { i8**, i64 }* %t291, { i8**, i64 }** %l1
  %t292 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge21
else20:
  %t293 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t294 = load %NativeImport*, %NativeImport** %l15
  %t295 = load %NativeImport, %NativeImport* %t294
  %t296 = call { %NativeImport*, i64 }* @append_import({ %NativeImport*, i64 }* %t293, %NativeImport %t295)
  store { %NativeImport*, i64 }* %t296, { %NativeImport*, i64 }** %l3
  %t297 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  br label %merge21
merge21:
  %t298 = phi { i8**, i64 }* [ %t292, %then19 ], [ %t273, %else20 ]
  %t299 = phi { %NativeImport*, i64 }* [ %t275, %then19 ], [ %t297, %else20 ]
  store { i8**, i64 }* %t298, { i8**, i64 }** %l1
  store { %NativeImport*, i64 }* %t299, { %NativeImport*, i64 }** %l3
  %t300 = load double, double* %l11
  %t301 = sitofp i64 1 to double
  %t302 = fadd double %t300, %t301
  store double %t302, double* %l11
  br label %loop.latch2
merge18:
  %t303 = load i8*, i8** %l13
  %s304 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1830497006, i32 0, i32 0
  %t305 = call i1 @starts_with(i8* %t303, i8* %s304)
  %t306 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t307 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t308 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t309 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t310 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t311 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t312 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t313 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t314 = load %NativeFunction*, %NativeFunction** %l8
  %t315 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t316 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t317 = load double, double* %l11
  %t318 = load i8*, i8** %l12
  %t319 = load i8*, i8** %l13
  br i1 %t305, label %then22, label %merge23
then22:
  %t320 = load i8*, i8** %l13
  %s321 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1830497006, i32 0, i32 0
  %t322 = call i8* @strip_prefix(i8* %t320, i8* %s321)
  %t323 = call %NativeSourceSpan* @parse_source_span(i8* %t322)
  store %NativeSourceSpan* %t323, %NativeSourceSpan** %l16
  %t324 = load %NativeSourceSpan*, %NativeSourceSpan** %l16
  %t325 = icmp eq %NativeSourceSpan* %t324, null
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
  %t340 = load %NativeSourceSpan*, %NativeSourceSpan** %l16
  br i1 %t325, label %then24, label %else25
then24:
  %t341 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s342 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.len31.h762677253, i32 0, i32 0
  %t343 = load i8*, i8** %l13
  %t344 = call i8* @sailfin_runtime_string_concat(i8* %s342, i8* %t343)
  %t345 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t341, i8* %t344)
  store { i8**, i64 }* %t345, { i8**, i64 }** %l1
  %t346 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge26
else25:
  %t347 = load %NativeSourceSpan*, %NativeSourceSpan** %l16
  store %NativeSourceSpan* %t347, %NativeSourceSpan** %l9
  %t348 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge26
merge26:
  %t349 = phi { i8**, i64 }* [ %t346, %then24 ], [ %t327, %else25 ]
  %t350 = phi %NativeSourceSpan* [ %t335, %then24 ], [ %t348, %else25 ]
  store { i8**, i64 }* %t349, { i8**, i64 }** %l1
  store %NativeSourceSpan* %t350, %NativeSourceSpan** %l9
  %t351 = load double, double* %l11
  %t352 = sitofp i64 1 to double
  %t353 = fadd double %t351, %t352
  store double %t353, double* %l11
  br label %loop.latch2
merge23:
  %t354 = load i8*, i8** %l13
  %s355 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1513373193, i32 0, i32 0
  %t356 = call i1 @starts_with(i8* %t354, i8* %s355)
  %t357 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t358 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t359 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t360 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t361 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t362 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t363 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t364 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t365 = load %NativeFunction*, %NativeFunction** %l8
  %t366 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t367 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t368 = load double, double* %l11
  %t369 = load i8*, i8** %l12
  %t370 = load i8*, i8** %l13
  br i1 %t356, label %then27, label %merge28
then27:
  %t371 = load i8*, i8** %l13
  %s372 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1513373193, i32 0, i32 0
  %t373 = call i8* @strip_prefix(i8* %t371, i8* %s372)
  %t374 = call %NativeSourceSpan* @parse_source_span(i8* %t373)
  store %NativeSourceSpan* %t374, %NativeSourceSpan** %l17
  %t375 = load %NativeSourceSpan*, %NativeSourceSpan** %l17
  %t376 = icmp eq %NativeSourceSpan* %t375, null
  %t377 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t378 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t379 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t380 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t381 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t382 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t383 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t384 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t385 = load %NativeFunction*, %NativeFunction** %l8
  %t386 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t387 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t388 = load double, double* %l11
  %t389 = load i8*, i8** %l12
  %t390 = load i8*, i8** %l13
  %t391 = load %NativeSourceSpan*, %NativeSourceSpan** %l17
  br i1 %t376, label %then29, label %else30
then29:
  %t392 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s393 = getelementptr inbounds [44 x i8], [44 x i8]* @.str.len43.h1714227133, i32 0, i32 0
  %t394 = load i8*, i8** %l13
  %t395 = call i8* @sailfin_runtime_string_concat(i8* %s393, i8* %t394)
  %t396 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t392, i8* %t395)
  store { i8**, i64 }* %t396, { i8**, i64 }** %l1
  %t397 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge31
else30:
  %t398 = load %NativeSourceSpan*, %NativeSourceSpan** %l17
  store %NativeSourceSpan* %t398, %NativeSourceSpan** %l10
  %t399 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge31
merge31:
  %t400 = phi { i8**, i64 }* [ %t397, %then29 ], [ %t378, %else30 ]
  %t401 = phi %NativeSourceSpan* [ %t387, %then29 ], [ %t399, %else30 ]
  store { i8**, i64 }* %t400, { i8**, i64 }** %l1
  store %NativeSourceSpan* %t401, %NativeSourceSpan** %l10
  %t402 = load double, double* %l11
  %t403 = sitofp i64 1 to double
  %t404 = fadd double %t402, %t403
  store double %t404, double* %l11
  br label %loop.latch2
merge28:
  %t405 = load i8*, i8** %l13
  %s406 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h2093451461, i32 0, i32 0
  %t407 = call i1 @starts_with(i8* %t405, i8* %s406)
  %t408 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t409 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t410 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t411 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t412 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t413 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t414 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t415 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t416 = load %NativeFunction*, %NativeFunction** %l8
  %t417 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t418 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t419 = load double, double* %l11
  %t420 = load i8*, i8** %l12
  %t421 = load i8*, i8** %l13
  br i1 %t407, label %then32, label %merge33
then32:
  %t422 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t423 = load double, double* %l11
  %t424 = call %StructParseResult @parse_struct_definition({ i8**, i64 }* %t422, double %t423)
  store %StructParseResult %t424, %StructParseResult* %l18
  %t425 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t426 = load %StructParseResult, %StructParseResult* %l18
  %t427 = extractvalue %StructParseResult %t426, 2
  %t428 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t425, { i8**, i64 }* %t427)
  store { i8**, i64 }* %t428, { i8**, i64 }** %l1
  %t429 = load %StructParseResult, %StructParseResult* %l18
  %t430 = extractvalue %StructParseResult %t429, 0
  %t431 = icmp ne %NativeStruct* %t430, null
  %t432 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t433 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t434 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t435 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t436 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t437 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t438 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t439 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t440 = load %NativeFunction*, %NativeFunction** %l8
  %t441 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t442 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t443 = load double, double* %l11
  %t444 = load i8*, i8** %l12
  %t445 = load i8*, i8** %l13
  %t446 = load %StructParseResult, %StructParseResult* %l18
  br i1 %t431, label %then34, label %merge35
then34:
  %t447 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t448 = load %StructParseResult, %StructParseResult* %l18
  %t449 = extractvalue %StructParseResult %t448, 0
  %t450 = load %NativeStruct, %NativeStruct* %t449
  %t451 = call { %NativeStruct*, i64 }* @append_struct({ %NativeStruct*, i64 }* %t447, %NativeStruct %t450)
  store { %NativeStruct*, i64 }* %t451, { %NativeStruct*, i64 }** %l4
  %t452 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  br label %merge35
merge35:
  %t453 = phi { %NativeStruct*, i64 }* [ %t452, %then34 ], [ %t436, %then32 ]
  store { %NativeStruct*, i64 }* %t453, { %NativeStruct*, i64 }** %l4
  %t454 = load %StructParseResult, %StructParseResult* %l18
  %t455 = extractvalue %StructParseResult %t454, 1
  store double %t455, double* %l11
  br label %loop.latch2
merge33:
  %t456 = load i8*, i8** %l13
  %s457 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h599952843, i32 0, i32 0
  %t458 = call i1 @starts_with(i8* %t456, i8* %s457)
  %t459 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t460 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t461 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t462 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t463 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t464 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t465 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t466 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t467 = load %NativeFunction*, %NativeFunction** %l8
  %t468 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t469 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t470 = load double, double* %l11
  %t471 = load i8*, i8** %l12
  %t472 = load i8*, i8** %l13
  br i1 %t458, label %then36, label %merge37
then36:
  %t473 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t474 = load double, double* %l11
  %t475 = call %InterfaceParseResult @parse_interface_definition({ i8**, i64 }* %t473, double %t474)
  store %InterfaceParseResult %t475, %InterfaceParseResult* %l19
  %t476 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t477 = load %InterfaceParseResult, %InterfaceParseResult* %l19
  %t478 = extractvalue %InterfaceParseResult %t477, 2
  %t479 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t476, { i8**, i64 }* %t478)
  store { i8**, i64 }* %t479, { i8**, i64 }** %l1
  %t480 = load %InterfaceParseResult, %InterfaceParseResult* %l19
  %t481 = extractvalue %InterfaceParseResult %t480, 0
  %t482 = icmp ne %NativeInterface* %t481, null
  %t483 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t484 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t485 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t486 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t487 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t488 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t489 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t490 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t491 = load %NativeFunction*, %NativeFunction** %l8
  %t492 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t493 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t494 = load double, double* %l11
  %t495 = load i8*, i8** %l12
  %t496 = load i8*, i8** %l13
  %t497 = load %InterfaceParseResult, %InterfaceParseResult* %l19
  br i1 %t482, label %then38, label %merge39
then38:
  %t498 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t499 = load %InterfaceParseResult, %InterfaceParseResult* %l19
  %t500 = extractvalue %InterfaceParseResult %t499, 0
  %t501 = load %NativeInterface, %NativeInterface* %t500
  %t502 = call { %NativeInterface*, i64 }* @append_interface({ %NativeInterface*, i64 }* %t498, %NativeInterface %t501)
  store { %NativeInterface*, i64 }* %t502, { %NativeInterface*, i64 }** %l5
  %t503 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  br label %merge39
merge39:
  %t504 = phi { %NativeInterface*, i64 }* [ %t503, %then38 ], [ %t488, %then36 ]
  store { %NativeInterface*, i64 }* %t504, { %NativeInterface*, i64 }** %l5
  %t505 = load %InterfaceParseResult, %InterfaceParseResult* %l19
  %t506 = extractvalue %InterfaceParseResult %t505, 1
  store double %t506, double* %l11
  br label %loop.latch2
merge37:
  %t507 = load i8*, i8** %l13
  %s508 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1280947313, i32 0, i32 0
  %t509 = call i1 @starts_with(i8* %t507, i8* %s508)
  %t510 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t511 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t512 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t513 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t514 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t515 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t516 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t517 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t518 = load %NativeFunction*, %NativeFunction** %l8
  %t519 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t520 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t521 = load double, double* %l11
  %t522 = load i8*, i8** %l12
  %t523 = load i8*, i8** %l13
  br i1 %t509, label %then40, label %merge41
then40:
  %t524 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t525 = load double, double* %l11
  %t526 = call %EnumParseResult @parse_enum_definition({ i8**, i64 }* %t524, double %t525)
  store %EnumParseResult %t526, %EnumParseResult* %l20
  %t527 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t528 = load %EnumParseResult, %EnumParseResult* %l20
  %t529 = extractvalue %EnumParseResult %t528, 2
  %t530 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t527, { i8**, i64 }* %t529)
  store { i8**, i64 }* %t530, { i8**, i64 }** %l1
  %t531 = load %EnumParseResult, %EnumParseResult* %l20
  %t532 = extractvalue %EnumParseResult %t531, 0
  %t533 = icmp ne %NativeEnum* %t532, null
  %t534 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t535 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t536 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t537 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t538 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t539 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t540 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t541 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t542 = load %NativeFunction*, %NativeFunction** %l8
  %t543 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t544 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t545 = load double, double* %l11
  %t546 = load i8*, i8** %l12
  %t547 = load i8*, i8** %l13
  %t548 = load %EnumParseResult, %EnumParseResult* %l20
  br i1 %t533, label %then42, label %merge43
then42:
  %t549 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t550 = load %EnumParseResult, %EnumParseResult* %l20
  %t551 = extractvalue %EnumParseResult %t550, 0
  %t552 = load %NativeEnum, %NativeEnum* %t551
  %t553 = call { %NativeEnum*, i64 }* @append_enum({ %NativeEnum*, i64 }* %t549, %NativeEnum %t552)
  store { %NativeEnum*, i64 }* %t553, { %NativeEnum*, i64 }** %l6
  %t554 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  br label %merge43
merge43:
  %t555 = phi { %NativeEnum*, i64 }* [ %t554, %then42 ], [ %t540, %then40 ]
  store { %NativeEnum*, i64 }* %t555, { %NativeEnum*, i64 }** %l6
  %t556 = load %EnumParseResult, %EnumParseResult* %l20
  %t557 = extractvalue %EnumParseResult %t556, 1
  store double %t557, double* %l11
  br label %loop.latch2
merge41:
  %t558 = load i8*, i8** %l13
  %s559 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h192491117, i32 0, i32 0
  %t560 = call i1 @starts_with(i8* %t558, i8* %s559)
  %t561 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t562 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t563 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t564 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t565 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t566 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t567 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t568 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t569 = load %NativeFunction*, %NativeFunction** %l8
  %t570 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t571 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t572 = load double, double* %l11
  %t573 = load i8*, i8** %l12
  %t574 = load i8*, i8** %l13
  br i1 %t560, label %then44, label %merge45
then44:
  %t575 = load %NativeFunction*, %NativeFunction** %l8
  %t576 = icmp ne %NativeFunction* %t575, null
  %t577 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t578 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t579 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t580 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t581 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t582 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t583 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t584 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t585 = load %NativeFunction*, %NativeFunction** %l8
  %t586 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t587 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t588 = load double, double* %l11
  %t589 = load i8*, i8** %l12
  %t590 = load i8*, i8** %l13
  br i1 %t576, label %then46, label %merge47
then46:
  %t591 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s592 = getelementptr inbounds [58 x i8], [58 x i8]* @.str.len57.h1118233133, i32 0, i32 0
  %t593 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t591, i8* %s592)
  store { i8**, i64 }* %t593, { i8**, i64 }** %l1
  %t594 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge47
merge47:
  %t595 = phi { i8**, i64 }* [ %t594, %then46 ], [ %t578, %then44 ]
  store { i8**, i64 }* %t595, { i8**, i64 }** %l1
  %t596 = load i8*, i8** %l13
  %s597 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h192491117, i32 0, i32 0
  %t598 = call i8* @strip_prefix(i8* %t596, i8* %s597)
  %t599 = call i8* @parse_function_name(i8* %t598)
  %t600 = insertvalue %NativeFunction undef, i8* %t599, 0
  %t601 = getelementptr [0 x %NativeParameter*], [0 x %NativeParameter*]* null, i32 1
  %t602 = ptrtoint [0 x %NativeParameter*]* %t601 to i64
  %t603 = icmp eq i64 %t602, 0
  %t604 = select i1 %t603, i64 1, i64 %t602
  %t605 = call i8* @malloc(i64 %t604)
  %t606 = bitcast i8* %t605 to %NativeParameter**
  %t607 = getelementptr { %NativeParameter**, i64 }, { %NativeParameter**, i64 }* null, i32 1
  %t608 = ptrtoint { %NativeParameter**, i64 }* %t607 to i64
  %t609 = call i8* @malloc(i64 %t608)
  %t610 = bitcast i8* %t609 to { %NativeParameter**, i64 }*
  %t611 = getelementptr { %NativeParameter**, i64 }, { %NativeParameter**, i64 }* %t610, i32 0, i32 0
  store %NativeParameter** %t606, %NativeParameter*** %t611
  %t612 = getelementptr { %NativeParameter**, i64 }, { %NativeParameter**, i64 }* %t610, i32 0, i32 1
  store i64 0, i64* %t612
  %t613 = insertvalue %NativeFunction %t600, { %NativeParameter**, i64 }* %t610, 1
  %s614 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h278197661, i32 0, i32 0
  %t615 = insertvalue %NativeFunction %t613, i8* %s614, 2
  %t616 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t617 = ptrtoint [0 x i8*]* %t616 to i64
  %t618 = icmp eq i64 %t617, 0
  %t619 = select i1 %t618, i64 1, i64 %t617
  %t620 = call i8* @malloc(i64 %t619)
  %t621 = bitcast i8* %t620 to i8**
  %t622 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t623 = ptrtoint { i8**, i64 }* %t622 to i64
  %t624 = call i8* @malloc(i64 %t623)
  %t625 = bitcast i8* %t624 to { i8**, i64 }*
  %t626 = getelementptr { i8**, i64 }, { i8**, i64 }* %t625, i32 0, i32 0
  store i8** %t621, i8*** %t626
  %t627 = getelementptr { i8**, i64 }, { i8**, i64 }* %t625, i32 0, i32 1
  store i64 0, i64* %t627
  %t628 = insertvalue %NativeFunction %t615, { i8**, i64 }* %t625, 3
  %t629 = getelementptr [0 x %NativeInstruction*], [0 x %NativeInstruction*]* null, i32 1
  %t630 = ptrtoint [0 x %NativeInstruction*]* %t629 to i64
  %t631 = icmp eq i64 %t630, 0
  %t632 = select i1 %t631, i64 1, i64 %t630
  %t633 = call i8* @malloc(i64 %t632)
  %t634 = bitcast i8* %t633 to %NativeInstruction**
  %t635 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* null, i32 1
  %t636 = ptrtoint { %NativeInstruction**, i64 }* %t635 to i64
  %t637 = call i8* @malloc(i64 %t636)
  %t638 = bitcast i8* %t637 to { %NativeInstruction**, i64 }*
  %t639 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t638, i32 0, i32 0
  store %NativeInstruction** %t634, %NativeInstruction*** %t639
  %t640 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t638, i32 0, i32 1
  store i64 0, i64* %t640
  %t641 = insertvalue %NativeFunction %t628, { %NativeInstruction**, i64 }* %t638, 4
  %t642 = alloca %NativeFunction
  store %NativeFunction %t641, %NativeFunction* %t642
  store %NativeFunction* %t642, %NativeFunction** %l8
  %t643 = load double, double* %l11
  %t644 = sitofp i64 1 to double
  %t645 = fadd double %t643, %t644
  store double %t645, double* %l11
  br label %loop.latch2
merge45:
  %t646 = load i8*, i8** %l13
  %s647 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1280331335, i32 0, i32 0
  %t648 = call i1 @starts_with(i8* %t646, i8* %s647)
  %t649 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t650 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t651 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t652 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t653 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t654 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t655 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t656 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t657 = load %NativeFunction*, %NativeFunction** %l8
  %t658 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t659 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t660 = load double, double* %l11
  %t661 = load i8*, i8** %l12
  %t662 = load i8*, i8** %l13
  br i1 %t648, label %then48, label %merge49
then48:
  %t663 = load %NativeFunction*, %NativeFunction** %l8
  %t664 = icmp eq %NativeFunction* %t663, null
  %t665 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t666 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t667 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t668 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t669 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t670 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t671 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t672 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t673 = load %NativeFunction*, %NativeFunction** %l8
  %t674 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t675 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t676 = load double, double* %l11
  %t677 = load i8*, i8** %l12
  %t678 = load i8*, i8** %l13
  br i1 %t664, label %then50, label %else51
then50:
  %t679 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s680 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.len42.h1518215675, i32 0, i32 0
  %t681 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t679, i8* %s680)
  store { i8**, i64 }* %t681, { i8**, i64 }** %l1
  %t682 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge52
else51:
  %t683 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t684 = load %NativeFunction*, %NativeFunction** %l8
  %t685 = load %NativeFunction, %NativeFunction* %t684
  %t686 = call { %NativeFunction*, i64 }* @append_function({ %NativeFunction*, i64 }* %t683, %NativeFunction %t685)
  store { %NativeFunction*, i64 }* %t686, { %NativeFunction*, i64 }** %l2
  %t687 = bitcast i8* null to %NativeFunction*
  store %NativeFunction* %t687, %NativeFunction** %l8
  %t688 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t689 = load %NativeFunction*, %NativeFunction** %l8
  br label %merge52
merge52:
  %t690 = phi { i8**, i64 }* [ %t682, %then50 ], [ %t666, %else51 ]
  %t691 = phi { %NativeFunction*, i64 }* [ %t667, %then50 ], [ %t688, %else51 ]
  %t692 = phi %NativeFunction* [ %t673, %then50 ], [ %t689, %else51 ]
  store { i8**, i64 }* %t690, { i8**, i64 }** %l1
  store { %NativeFunction*, i64 }* %t691, { %NativeFunction*, i64 }** %l2
  store %NativeFunction* %t692, %NativeFunction** %l8
  %t693 = load double, double* %l11
  %t694 = sitofp i64 1 to double
  %t695 = fadd double %t693, %t694
  store double %t695, double* %l11
  br label %loop.latch2
merge49:
  %t696 = load i8*, i8** %l13
  %s697 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1583308163, i32 0, i32 0
  %t698 = call i1 @starts_with(i8* %t696, i8* %s697)
  %t699 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t700 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t701 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t702 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t703 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t704 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t705 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t706 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t707 = load %NativeFunction*, %NativeFunction** %l8
  %t708 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t709 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t710 = load double, double* %l11
  %t711 = load i8*, i8** %l12
  %t712 = load i8*, i8** %l13
  br i1 %t698, label %then53, label %merge54
then53:
  %t713 = load %NativeFunction*, %NativeFunction** %l8
  %t714 = icmp ne %NativeFunction* %t713, null
  %t715 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t716 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t717 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t718 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t719 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t720 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t721 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t722 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t723 = load %NativeFunction*, %NativeFunction** %l8
  %t724 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t725 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t726 = load double, double* %l11
  %t727 = load i8*, i8** %l12
  %t728 = load i8*, i8** %l13
  br i1 %t714, label %then55, label %else56
then55:
  %t729 = load %NativeFunction*, %NativeFunction** %l8
  %t730 = load i8*, i8** %l13
  %s731 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1583308163, i32 0, i32 0
  %t732 = call i8* @strip_prefix(i8* %t730, i8* %s731)
  %t733 = load %NativeFunction, %NativeFunction* %t729
  %t734 = call %NativeFunction @apply_meta(%NativeFunction %t733, i8* %t732)
  %t735 = alloca %NativeFunction
  store %NativeFunction %t734, %NativeFunction* %t735
  store %NativeFunction* %t735, %NativeFunction** %l8
  %t736 = load %NativeFunction*, %NativeFunction** %l8
  br label %merge57
else56:
  %t737 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s738 = getelementptr inbounds [33 x i8], [33 x i8]* @.str.len32.h1767333123, i32 0, i32 0
  %t739 = load i8*, i8** %l13
  %t740 = call i8* @sailfin_runtime_string_concat(i8* %s738, i8* %t739)
  %t741 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t737, i8* %t740)
  store { i8**, i64 }* %t741, { i8**, i64 }** %l1
  %t742 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge57
merge57:
  %t743 = phi %NativeFunction* [ %t736, %then55 ], [ %t723, %else56 ]
  %t744 = phi { i8**, i64 }* [ %t716, %then55 ], [ %t742, %else56 ]
  store %NativeFunction* %t743, %NativeFunction** %l8
  store { i8**, i64 }* %t744, { i8**, i64 }** %l1
  %t745 = load double, double* %l11
  %t746 = sitofp i64 1 to double
  %t747 = fadd double %t745, %t746
  store double %t747, double* %l11
  br label %loop.latch2
merge54:
  %t748 = load i8*, i8** %l13
  %s749 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h130169768, i32 0, i32 0
  %t750 = call i1 @starts_with(i8* %t748, i8* %s749)
  %t751 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t752 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t753 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t754 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t755 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t756 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t757 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t758 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t759 = load %NativeFunction*, %NativeFunction** %l8
  %t760 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t761 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t762 = load double, double* %l11
  %t763 = load i8*, i8** %l12
  %t764 = load i8*, i8** %l13
  br i1 %t750, label %then58, label %merge59
then58:
  %t765 = load %NativeFunction*, %NativeFunction** %l8
  %t766 = icmp ne %NativeFunction* %t765, null
  %t767 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t768 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t769 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t770 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t771 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t772 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t773 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t774 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t775 = load %NativeFunction*, %NativeFunction** %l8
  %t776 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t777 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t778 = load double, double* %l11
  %t779 = load i8*, i8** %l12
  %t780 = load i8*, i8** %l13
  br i1 %t766, label %then60, label %else61
then60:
  %t781 = load i8*, i8** %l13
  %s782 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h130169768, i32 0, i32 0
  %t783 = call i8* @strip_prefix(i8* %t781, i8* %s782)
  store i8* %t783, i8** %l21
  %t784 = load double, double* %l11
  %t785 = sitofp i64 1 to double
  %t786 = fadd double %t784, %t785
  store double %t786, double* %l22
  %t787 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t788 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t789 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t790 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t791 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t792 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t793 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t794 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t795 = load %NativeFunction*, %NativeFunction** %l8
  %t796 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t797 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t798 = load double, double* %l11
  %t799 = load i8*, i8** %l12
  %t800 = load i8*, i8** %l13
  %t801 = load i8*, i8** %l21
  %t802 = load double, double* %l22
  br label %loop.header63
loop.header63:
  %t914 = phi double [ %t802, %then60 ], [ %t912, %loop.latch65 ]
  %t915 = phi i8* [ %t801, %then60 ], [ %t913, %loop.latch65 ]
  store double %t914, double* %l22
  store i8* %t915, i8** %l21
  br label %loop.body64
loop.body64:
  %t803 = load double, double* %l22
  %t804 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t805 = load { i8**, i64 }, { i8**, i64 }* %t804
  %t806 = extractvalue { i8**, i64 } %t805, 1
  %t807 = sitofp i64 %t806 to double
  %t808 = fcmp oge double %t803, %t807
  %t809 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t810 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t811 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t812 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t813 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t814 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t815 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t816 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t817 = load %NativeFunction*, %NativeFunction** %l8
  %t818 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t819 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t820 = load double, double* %l11
  %t821 = load i8*, i8** %l12
  %t822 = load i8*, i8** %l13
  %t823 = load i8*, i8** %l21
  %t824 = load double, double* %l22
  br i1 %t808, label %then67, label %merge68
then67:
  br label %afterloop66
merge68:
  %t825 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t826 = load double, double* %l22
  %t827 = fptosi double %t826 to i64
  %t828 = load { i8**, i64 }, { i8**, i64 }* %t825
  %t829 = extractvalue { i8**, i64 } %t828, 0
  %t830 = extractvalue { i8**, i64 } %t828, 1
  %t831 = icmp uge i64 %t827, %t830
  ; bounds check: %t831 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t827, i64 %t830)
  %t832 = getelementptr i8*, i8** %t829, i64 %t827
  %t833 = load i8*, i8** %t832
  store i8* %t833, i8** %l23
  %t834 = load i8*, i8** %l23
  %t835 = call i64 @sailfin_runtime_string_length(i8* %t834)
  %t836 = icmp eq i64 %t835, 0
  %t837 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t838 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t839 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t840 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t841 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t842 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t843 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t844 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t845 = load %NativeFunction*, %NativeFunction** %l8
  %t846 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t847 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t848 = load double, double* %l11
  %t849 = load i8*, i8** %l12
  %t850 = load i8*, i8** %l13
  %t851 = load i8*, i8** %l21
  %t852 = load double, double* %l22
  %t853 = load i8*, i8** %l23
  br i1 %t836, label %then69, label %merge70
then69:
  br label %afterloop66
merge70:
  %t854 = load i8*, i8** %l23
  %t855 = call i8* @trim_text(i8* %t854)
  store i8* %t855, i8** %l24
  %t856 = load i8*, i8** %l24
  %t857 = call i64 @sailfin_runtime_string_length(i8* %t856)
  %t858 = icmp eq i64 %t857, 0
  %t859 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t860 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t861 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t862 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t863 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t864 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t865 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t866 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t867 = load %NativeFunction*, %NativeFunction** %l8
  %t868 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t869 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t870 = load double, double* %l11
  %t871 = load i8*, i8** %l12
  %t872 = load i8*, i8** %l13
  %t873 = load i8*, i8** %l21
  %t874 = load double, double* %l22
  %t875 = load i8*, i8** %l23
  %t876 = load i8*, i8** %l24
  br i1 %t858, label %then71, label %merge72
then71:
  %t877 = load double, double* %l22
  %t878 = sitofp i64 1 to double
  %t879 = fadd double %t877, %t878
  store double %t879, double* %l22
  br label %loop.latch65
merge72:
  %t880 = load i8*, i8** %l24
  %t881 = call i1 @line_looks_like_parameter_entry(i8* %t880)
  %t882 = xor i1 %t881, 1
  %t883 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t884 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t885 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t886 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t887 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t888 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t889 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t890 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t891 = load %NativeFunction*, %NativeFunction** %l8
  %t892 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t893 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t894 = load double, double* %l11
  %t895 = load i8*, i8** %l12
  %t896 = load i8*, i8** %l13
  %t897 = load i8*, i8** %l21
  %t898 = load double, double* %l22
  %t899 = load i8*, i8** %l23
  %t900 = load i8*, i8** %l24
  br i1 %t882, label %then73, label %merge74
then73:
  br label %afterloop66
merge74:
  %t901 = load i8*, i8** %l21
  %t902 = alloca [2 x i8], align 1
  %t903 = getelementptr [2 x i8], [2 x i8]* %t902, i32 0, i32 0
  store i8 32, i8* %t903
  %t904 = getelementptr [2 x i8], [2 x i8]* %t902, i32 0, i32 1
  store i8 0, i8* %t904
  %t905 = getelementptr [2 x i8], [2 x i8]* %t902, i32 0, i32 0
  %t906 = call i8* @sailfin_runtime_string_concat(i8* %t901, i8* %t905)
  %t907 = load i8*, i8** %l24
  %t908 = call i8* @sailfin_runtime_string_concat(i8* %t906, i8* %t907)
  store i8* %t908, i8** %l21
  %t909 = load double, double* %l22
  %t910 = sitofp i64 1 to double
  %t911 = fadd double %t909, %t910
  store double %t911, double* %l22
  br label %loop.latch65
loop.latch65:
  %t912 = load double, double* %l22
  %t913 = load i8*, i8** %l21
  br label %loop.header63
afterloop66:
  %t916 = load double, double* %l22
  %t917 = load i8*, i8** %l21
  %t918 = load i8*, i8** %l21
  %t919 = call { i8**, i64 }* @split_parameter_entries(i8* %t918)
  store { i8**, i64 }* %t919, { i8**, i64 }** %l25
  %t920 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t921 = load { i8**, i64 }, { i8**, i64 }* %t920
  %t922 = extractvalue { i8**, i64 } %t921, 1
  %t923 = icmp eq i64 %t922, 0
  %t924 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t925 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t926 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t927 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t928 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t929 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t930 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t931 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t932 = load %NativeFunction*, %NativeFunction** %l8
  %t933 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t934 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t935 = load double, double* %l11
  %t936 = load i8*, i8** %l12
  %t937 = load i8*, i8** %l13
  %t938 = load i8*, i8** %l21
  %t939 = load double, double* %l22
  %t940 = load { i8**, i64 }*, { i8**, i64 }** %l25
  br i1 %t923, label %then75, label %else76
then75:
  %t941 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s942 = getelementptr inbounds [33 x i8], [33 x i8]* @.str.len32.h1189086491, i32 0, i32 0
  %t943 = load i8*, i8** %l13
  %t944 = call i8* @sailfin_runtime_string_concat(i8* %s942, i8* %t943)
  %t945 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t941, i8* %t944)
  store { i8**, i64 }* %t945, { i8**, i64 }** %l1
  %t946 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t946, %NativeSourceSpan** %l9
  %t947 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t948 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge77
else76:
  %t949 = sitofp i64 0 to double
  store double %t949, double* %l26
  store i1 0, i1* %l27
  %t950 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t951 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t952 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t953 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t954 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t955 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t956 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t957 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t958 = load %NativeFunction*, %NativeFunction** %l8
  %t959 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t960 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t961 = load double, double* %l11
  %t962 = load i8*, i8** %l12
  %t963 = load i8*, i8** %l13
  %t964 = load i8*, i8** %l21
  %t965 = load double, double* %l22
  %t966 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t967 = load double, double* %l26
  %t968 = load i1, i1* %l27
  br label %loop.header78
loop.header78:
  %t1108 = phi { i8**, i64 }* [ %t951, %else76 ], [ %t1104, %loop.latch80 ]
  %t1109 = phi %NativeFunction* [ %t958, %else76 ], [ %t1105, %loop.latch80 ]
  %t1110 = phi i1 [ %t968, %else76 ], [ %t1106, %loop.latch80 ]
  %t1111 = phi double [ %t967, %else76 ], [ %t1107, %loop.latch80 ]
  store { i8**, i64 }* %t1108, { i8**, i64 }** %l1
  store %NativeFunction* %t1109, %NativeFunction** %l8
  store i1 %t1110, i1* %l27
  store double %t1111, double* %l26
  br label %loop.body79
loop.body79:
  %t969 = load double, double* %l26
  %t970 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t971 = load { i8**, i64 }, { i8**, i64 }* %t970
  %t972 = extractvalue { i8**, i64 } %t971, 1
  %t973 = sitofp i64 %t972 to double
  %t974 = fcmp oge double %t969, %t973
  %t975 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t976 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t977 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t978 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t979 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t980 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t981 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t982 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t983 = load %NativeFunction*, %NativeFunction** %l8
  %t984 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t985 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t986 = load double, double* %l11
  %t987 = load i8*, i8** %l12
  %t988 = load i8*, i8** %l13
  %t989 = load i8*, i8** %l21
  %t990 = load double, double* %l22
  %t991 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t992 = load double, double* %l26
  %t993 = load i1, i1* %l27
  br i1 %t974, label %then82, label %merge83
then82:
  br label %afterloop81
merge83:
  %t994 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t995 = load double, double* %l26
  %t996 = fptosi double %t995 to i64
  %t997 = load { i8**, i64 }, { i8**, i64 }* %t994
  %t998 = extractvalue { i8**, i64 } %t997, 0
  %t999 = extractvalue { i8**, i64 } %t997, 1
  %t1000 = icmp uge i64 %t996, %t999
  ; bounds check: %t1000 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t996, i64 %t999)
  %t1001 = getelementptr i8*, i8** %t998, i64 %t996
  %t1002 = load i8*, i8** %t1001
  store i8* %t1002, i8** %l28
  %t1003 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  store %NativeSourceSpan* %t1003, %NativeSourceSpan** %l29
  %t1004 = load i1, i1* %l27
  %t1005 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1006 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1007 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1008 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1009 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1010 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1011 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1012 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1013 = load %NativeFunction*, %NativeFunction** %l8
  %t1014 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1015 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1016 = load double, double* %l11
  %t1017 = load i8*, i8** %l12
  %t1018 = load i8*, i8** %l13
  %t1019 = load i8*, i8** %l21
  %t1020 = load double, double* %l22
  %t1021 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t1022 = load double, double* %l26
  %t1023 = load i1, i1* %l27
  %t1024 = load i8*, i8** %l28
  %t1025 = load %NativeSourceSpan*, %NativeSourceSpan** %l29
  br i1 %t1004, label %then84, label %merge85
then84:
  %t1026 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1026, %NativeSourceSpan** %l29
  %t1027 = load %NativeSourceSpan*, %NativeSourceSpan** %l29
  br label %merge85
merge85:
  %t1028 = phi %NativeSourceSpan* [ %t1027, %then84 ], [ %t1025, %merge83 ]
  store %NativeSourceSpan* %t1028, %NativeSourceSpan** %l29
  %t1029 = load i8*, i8** %l28
  %t1030 = load %NativeSourceSpan*, %NativeSourceSpan** %l29
  %t1031 = call %NativeParameter* @parse_parameter_entry(i8* %t1029, %NativeSourceSpan* %t1030)
  store %NativeParameter* %t1031, %NativeParameter** %l30
  %t1032 = load %NativeParameter*, %NativeParameter** %l30
  %t1033 = icmp eq %NativeParameter* %t1032, null
  %t1034 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1035 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1036 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1037 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1038 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1039 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1040 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1041 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1042 = load %NativeFunction*, %NativeFunction** %l8
  %t1043 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1044 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1045 = load double, double* %l11
  %t1046 = load i8*, i8** %l12
  %t1047 = load i8*, i8** %l13
  %t1048 = load i8*, i8** %l21
  %t1049 = load double, double* %l22
  %t1050 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t1051 = load double, double* %l26
  %t1052 = load i1, i1* %l27
  %t1053 = load i8*, i8** %l28
  %t1054 = load %NativeSourceSpan*, %NativeSourceSpan** %l29
  %t1055 = load %NativeParameter*, %NativeParameter** %l30
  br i1 %t1033, label %then86, label %else87
then86:
  %t1056 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s1057 = getelementptr inbounds [34 x i8], [34 x i8]* @.str.len33.h1023685264, i32 0, i32 0
  %t1058 = load i8*, i8** %l28
  %t1059 = call i8* @sailfin_runtime_string_concat(i8* %s1057, i8* %t1058)
  %t1060 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1056, i8* %t1059)
  store { i8**, i64 }* %t1060, { i8**, i64 }** %l1
  %t1061 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge88
else87:
  %t1062 = load %NativeFunction*, %NativeFunction** %l8
  %t1063 = load %NativeParameter*, %NativeParameter** %l30
  %t1064 = load %NativeFunction, %NativeFunction* %t1062
  %t1065 = load %NativeParameter, %NativeParameter* %t1063
  %t1066 = call %NativeFunction @append_parameter(%NativeFunction %t1064, %NativeParameter %t1065)
  %t1067 = alloca %NativeFunction
  store %NativeFunction %t1066, %NativeFunction* %t1067
  store %NativeFunction* %t1067, %NativeFunction** %l8
  %t1068 = load %NativeParameter*, %NativeParameter** %l30
  %t1069 = getelementptr %NativeParameter, %NativeParameter* %t1068, i32 0, i32 4
  %t1070 = load %NativeSourceSpan*, %NativeSourceSpan** %t1069
  %t1071 = icmp ne %NativeSourceSpan* %t1070, null
  %t1072 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1073 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1074 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1075 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1076 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1077 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1078 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1079 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1080 = load %NativeFunction*, %NativeFunction** %l8
  %t1081 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1082 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1083 = load double, double* %l11
  %t1084 = load i8*, i8** %l12
  %t1085 = load i8*, i8** %l13
  %t1086 = load i8*, i8** %l21
  %t1087 = load double, double* %l22
  %t1088 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t1089 = load double, double* %l26
  %t1090 = load i1, i1* %l27
  %t1091 = load i8*, i8** %l28
  %t1092 = load %NativeSourceSpan*, %NativeSourceSpan** %l29
  %t1093 = load %NativeParameter*, %NativeParameter** %l30
  br i1 %t1071, label %then89, label %merge90
then89:
  store i1 1, i1* %l27
  %t1094 = load i1, i1* %l27
  br label %merge90
merge90:
  %t1095 = phi i1 [ %t1094, %then89 ], [ %t1090, %else87 ]
  store i1 %t1095, i1* %l27
  %t1096 = load %NativeFunction*, %NativeFunction** %l8
  %t1097 = load i1, i1* %l27
  br label %merge88
merge88:
  %t1098 = phi { i8**, i64 }* [ %t1061, %then86 ], [ %t1035, %merge90 ]
  %t1099 = phi %NativeFunction* [ %t1042, %then86 ], [ %t1096, %merge90 ]
  %t1100 = phi i1 [ %t1052, %then86 ], [ %t1097, %merge90 ]
  store { i8**, i64 }* %t1098, { i8**, i64 }** %l1
  store %NativeFunction* %t1099, %NativeFunction** %l8
  store i1 %t1100, i1* %l27
  %t1101 = load double, double* %l26
  %t1102 = sitofp i64 1 to double
  %t1103 = fadd double %t1101, %t1102
  store double %t1103, double* %l26
  br label %loop.latch80
loop.latch80:
  %t1104 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1105 = load %NativeFunction*, %NativeFunction** %l8
  %t1106 = load i1, i1* %l27
  %t1107 = load double, double* %l26
  br label %loop.header78
afterloop81:
  %t1112 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1113 = load %NativeFunction*, %NativeFunction** %l8
  %t1114 = load i1, i1* %l27
  %t1115 = load double, double* %l26
  %t1116 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1116, %NativeSourceSpan** %l9
  %t1117 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1118 = load %NativeFunction*, %NativeFunction** %l8
  %t1119 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge77
merge77:
  %t1120 = phi { i8**, i64 }* [ %t947, %then75 ], [ %t1117, %afterloop81 ]
  %t1121 = phi %NativeSourceSpan* [ %t948, %then75 ], [ %t1119, %afterloop81 ]
  %t1122 = phi %NativeFunction* [ %t932, %then75 ], [ %t1118, %afterloop81 ]
  store { i8**, i64 }* %t1120, { i8**, i64 }** %l1
  store %NativeSourceSpan* %t1121, %NativeSourceSpan** %l9
  store %NativeFunction* %t1122, %NativeFunction** %l8
  %t1123 = load double, double* %l22
  %t1124 = sitofp i64 1 to double
  %t1125 = fsub double %t1123, %t1124
  store double %t1125, double* %l11
  %t1126 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1127 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1128 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1129 = load %NativeFunction*, %NativeFunction** %l8
  %t1130 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1131 = load double, double* %l11
  br label %merge62
else61:
  %t1132 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s1133 = getelementptr inbounds [34 x i8], [34 x i8]* @.str.len33.h712498791, i32 0, i32 0
  %t1134 = load i8*, i8** %l13
  %t1135 = call i8* @sailfin_runtime_string_concat(i8* %s1133, i8* %t1134)
  %t1136 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1132, i8* %t1135)
  store { i8**, i64 }* %t1136, { i8**, i64 }** %l1
  %t1137 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge62
merge62:
  %t1138 = phi { i8**, i64 }* [ %t1126, %merge77 ], [ %t1137, %else61 ]
  %t1139 = phi %NativeSourceSpan* [ %t1127, %merge77 ], [ %t776, %else61 ]
  %t1140 = phi %NativeFunction* [ %t1129, %merge77 ], [ %t775, %else61 ]
  %t1141 = phi double [ %t1131, %merge77 ], [ %t778, %else61 ]
  store { i8**, i64 }* %t1138, { i8**, i64 }** %l1
  store %NativeSourceSpan* %t1139, %NativeSourceSpan** %l9
  store %NativeFunction* %t1140, %NativeFunction** %l8
  store double %t1141, double* %l11
  %t1142 = load double, double* %l11
  %t1143 = sitofp i64 1 to double
  %t1144 = fadd double %t1142, %t1143
  store double %t1144, double* %l11
  br label %loop.latch2
merge59:
  %t1145 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1146 = load double, double* %l11
  %t1147 = call %InstructionGatherResult @gather_instruction({ i8**, i64 }* %t1145, double %t1146)
  store %InstructionGatherResult %t1147, %InstructionGatherResult* %l31
  %t1148 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1149 = extractvalue %InstructionGatherResult %t1148, 0
  store i8* %t1149, i8** %l13
  %t1150 = load double, double* %l11
  %t1151 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1152 = extractvalue %InstructionGatherResult %t1151, 1
  %t1153 = fadd double %t1150, %t1152
  store double %t1153, double* %l11
  %t1154 = load i8*, i8** %l13
  %t1155 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1156 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1157 = call %InstructionParseResult @parse_instruction(i8* %t1154, %NativeSourceSpan* %t1155, %NativeSourceSpan* %t1156)
  store %InstructionParseResult %t1157, %InstructionParseResult* %l32
  %t1158 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1159 = extractvalue %InstructionParseResult %t1158, 0
  store { %NativeInstruction**, i64 }* %t1159, { %NativeInstruction**, i64 }** %l33
  %t1160 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1161 = extractvalue %InstructionParseResult %t1160, 1
  %t1162 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1163 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1164 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1165 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1166 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1167 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1168 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1169 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1170 = load %NativeFunction*, %NativeFunction** %l8
  %t1171 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1172 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1173 = load double, double* %l11
  %t1174 = load i8*, i8** %l12
  %t1175 = load i8*, i8** %l13
  %t1176 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1177 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1178 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  br i1 %t1161, label %then91, label %else92
then91:
  %t1179 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1179, %NativeSourceSpan** %l9
  %t1180 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge93
else92:
  %t1181 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1182 = icmp ne %NativeSourceSpan* %t1181, null
  %t1183 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1184 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1185 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1186 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1187 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1188 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1189 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1190 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1191 = load %NativeFunction*, %NativeFunction** %l8
  %t1192 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1193 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1194 = load double, double* %l11
  %t1195 = load i8*, i8** %l12
  %t1196 = load i8*, i8** %l13
  %t1197 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1198 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1199 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  br i1 %t1182, label %then94, label %merge95
then94:
  %t1200 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s1201 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.len29.h1601547567, i32 0, i32 0
  %t1202 = load i8*, i8** %l13
  %t1203 = call i8* @sailfin_runtime_string_concat(i8* %s1201, i8* %t1202)
  %t1204 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1200, i8* %t1203)
  store { i8**, i64 }* %t1204, { i8**, i64 }** %l1
  %t1205 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1205, %NativeSourceSpan** %l9
  %t1206 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1207 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge95
merge95:
  %t1208 = phi { i8**, i64 }* [ %t1206, %then94 ], [ %t1184, %else92 ]
  %t1209 = phi %NativeSourceSpan* [ %t1207, %then94 ], [ %t1192, %else92 ]
  store { i8**, i64 }* %t1208, { i8**, i64 }** %l1
  store %NativeSourceSpan* %t1209, %NativeSourceSpan** %l9
  %t1210 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1211 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge93
merge93:
  %t1212 = phi %NativeSourceSpan* [ %t1180, %then91 ], [ %t1211, %merge95 ]
  %t1213 = phi { i8**, i64 }* [ %t1163, %then91 ], [ %t1210, %merge95 ]
  store %NativeSourceSpan* %t1212, %NativeSourceSpan** %l9
  store { i8**, i64 }* %t1213, { i8**, i64 }** %l1
  %t1214 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1215 = extractvalue %InstructionParseResult %t1214, 2
  %t1216 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1217 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1218 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1219 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1220 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1221 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1222 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1223 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1224 = load %NativeFunction*, %NativeFunction** %l8
  %t1225 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1226 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1227 = load double, double* %l11
  %t1228 = load i8*, i8** %l12
  %t1229 = load i8*, i8** %l13
  %t1230 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1231 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1232 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  br i1 %t1215, label %then96, label %else97
then96:
  %t1233 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1233, %NativeSourceSpan** %l10
  %t1234 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge98
else97:
  %t1235 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1236 = icmp ne %NativeSourceSpan* %t1235, null
  %t1237 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1238 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1239 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1240 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1241 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1242 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1243 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1244 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1245 = load %NativeFunction*, %NativeFunction** %l8
  %t1246 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1247 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1248 = load double, double* %l11
  %t1249 = load i8*, i8** %l12
  %t1250 = load i8*, i8** %l13
  %t1251 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1252 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1253 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  br i1 %t1236, label %then99, label %merge100
then99:
  %t1254 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s1255 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.len41.h35508704, i32 0, i32 0
  %t1256 = load i8*, i8** %l13
  %t1257 = call i8* @sailfin_runtime_string_concat(i8* %s1255, i8* %t1256)
  %t1258 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1254, i8* %t1257)
  store { i8**, i64 }* %t1258, { i8**, i64 }** %l1
  %t1259 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1259, %NativeSourceSpan** %l10
  %t1260 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1261 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge100
merge100:
  %t1262 = phi { i8**, i64 }* [ %t1260, %then99 ], [ %t1238, %else97 ]
  %t1263 = phi %NativeSourceSpan* [ %t1261, %then99 ], [ %t1247, %else97 ]
  store { i8**, i64 }* %t1262, { i8**, i64 }** %l1
  store %NativeSourceSpan* %t1263, %NativeSourceSpan** %l10
  %t1264 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1265 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge98
merge98:
  %t1266 = phi %NativeSourceSpan* [ %t1234, %then96 ], [ %t1265, %merge100 ]
  %t1267 = phi { i8**, i64 }* [ %t1217, %then96 ], [ %t1264, %merge100 ]
  store %NativeSourceSpan* %t1266, %NativeSourceSpan** %l10
  store { i8**, i64 }* %t1267, { i8**, i64 }** %l1
  %t1268 = load %NativeFunction*, %NativeFunction** %l8
  %t1269 = icmp eq %NativeFunction* %t1268, null
  %t1270 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1271 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1272 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1273 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1274 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1275 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1276 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1277 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1278 = load %NativeFunction*, %NativeFunction** %l8
  %t1279 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1280 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1281 = load double, double* %l11
  %t1282 = load i8*, i8** %l12
  %t1283 = load i8*, i8** %l13
  %t1284 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1285 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1286 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  br i1 %t1269, label %then101, label %merge102
then101:
  %t1288 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  %t1289 = load { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t1288
  %t1290 = extractvalue { %NativeInstruction**, i64 } %t1289, 1
  %t1291 = icmp eq i64 %t1290, 1
  br label %logical_and_entry_1287

logical_and_entry_1287:
  br i1 %t1291, label %logical_and_right_1287, label %logical_and_merge_1287

logical_and_right_1287:
  %t1292 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  %t1293 = load { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t1292
  %t1294 = extractvalue { %NativeInstruction**, i64 } %t1293, 0
  %t1295 = extractvalue { %NativeInstruction**, i64 } %t1293, 1
  %t1296 = icmp uge i64 0, %t1295
  ; bounds check: %t1296 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 0, i64 %t1295)
  %t1297 = getelementptr %NativeInstruction*, %NativeInstruction** %t1294, i64 0
  %t1298 = load %NativeInstruction*, %NativeInstruction** %t1297
  %t1299 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1298, i32 0, i32 0
  %t1300 = load i32, i32* %t1299
  %t1301 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1302 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1303 = icmp eq i32 %t1300, 0
  %t1304 = select i1 %t1303, i8* %t1302, i8* %t1301
  %t1305 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1306 = icmp eq i32 %t1300, 1
  %t1307 = select i1 %t1306, i8* %t1305, i8* %t1304
  %t1308 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1309 = icmp eq i32 %t1300, 2
  %t1310 = select i1 %t1309, i8* %t1308, i8* %t1307
  %t1311 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1312 = icmp eq i32 %t1300, 3
  %t1313 = select i1 %t1312, i8* %t1311, i8* %t1310
  %t1314 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1315 = icmp eq i32 %t1300, 4
  %t1316 = select i1 %t1315, i8* %t1314, i8* %t1313
  %t1317 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1318 = icmp eq i32 %t1300, 5
  %t1319 = select i1 %t1318, i8* %t1317, i8* %t1316
  %t1320 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1321 = icmp eq i32 %t1300, 6
  %t1322 = select i1 %t1321, i8* %t1320, i8* %t1319
  %t1323 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1324 = icmp eq i32 %t1300, 7
  %t1325 = select i1 %t1324, i8* %t1323, i8* %t1322
  %t1326 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1327 = icmp eq i32 %t1300, 8
  %t1328 = select i1 %t1327, i8* %t1326, i8* %t1325
  %t1329 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1330 = icmp eq i32 %t1300, 9
  %t1331 = select i1 %t1330, i8* %t1329, i8* %t1328
  %t1332 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1333 = icmp eq i32 %t1300, 10
  %t1334 = select i1 %t1333, i8* %t1332, i8* %t1331
  %t1335 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1336 = icmp eq i32 %t1300, 11
  %t1337 = select i1 %t1336, i8* %t1335, i8* %t1334
  %t1338 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1339 = icmp eq i32 %t1300, 12
  %t1340 = select i1 %t1339, i8* %t1338, i8* %t1337
  %t1341 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1342 = icmp eq i32 %t1300, 13
  %t1343 = select i1 %t1342, i8* %t1341, i8* %t1340
  %t1344 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1345 = icmp eq i32 %t1300, 14
  %t1346 = select i1 %t1345, i8* %t1344, i8* %t1343
  %t1347 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1348 = icmp eq i32 %t1300, 15
  %t1349 = select i1 %t1348, i8* %t1347, i8* %t1346
  %t1350 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1351 = icmp eq i32 %t1300, 16
  %t1352 = select i1 %t1351, i8* %t1350, i8* %t1349
  %s1353 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2089318639, i32 0, i32 0
  %t1354 = icmp eq i8* %t1352, %s1353
  br label %logical_and_right_end_1287

logical_and_right_end_1287:
  br label %logical_and_merge_1287

logical_and_merge_1287:
  %t1355 = phi i1 [ false, %logical_and_entry_1287 ], [ %t1354, %logical_and_right_end_1287 ]
  %t1356 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1357 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1358 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1359 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1360 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1361 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1362 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1363 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1364 = load %NativeFunction*, %NativeFunction** %l8
  %t1365 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1366 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1367 = load double, double* %l11
  %t1368 = load i8*, i8** %l12
  %t1369 = load i8*, i8** %l13
  %t1370 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1371 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1372 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  br i1 %t1355, label %then103, label %else104
then103:
  %t1373 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1374 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  %t1375 = load { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t1374
  %t1376 = extractvalue { %NativeInstruction**, i64 } %t1375, 0
  %t1377 = extractvalue { %NativeInstruction**, i64 } %t1375, 1
  %t1378 = icmp uge i64 0, %t1377
  ; bounds check: %t1378 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 0, i64 %t1377)
  %t1379 = getelementptr %NativeInstruction*, %NativeInstruction** %t1376, i64 0
  %t1380 = load %NativeInstruction*, %NativeInstruction** %t1379
  %t1381 = load %NativeInstruction, %NativeInstruction* %t1380
  %t1382 = call %NativeBinding @binding_from_instruction(%NativeInstruction %t1381)
  %t1383 = call { %NativeBinding*, i64 }* @append_binding({ %NativeBinding*, i64 }* %t1373, %NativeBinding %t1382)
  store { %NativeBinding*, i64 }* %t1383, { %NativeBinding*, i64 }** %l7
  %t1384 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  br label %merge105
else104:
  %t1385 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s1386 = getelementptr inbounds [48 x i8], [48 x i8]* @.str.len47.h1886628617, i32 0, i32 0
  %t1387 = load i8*, i8** %l13
  %t1388 = call i8* @sailfin_runtime_string_concat(i8* %s1386, i8* %t1387)
  %t1389 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1385, i8* %t1388)
  store { i8**, i64 }* %t1389, { i8**, i64 }** %l1
  %t1390 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge105
merge105:
  %t1391 = phi { %NativeBinding*, i64 }* [ %t1384, %then103 ], [ %t1363, %else104 ]
  %t1392 = phi { i8**, i64 }* [ %t1357, %then103 ], [ %t1390, %else104 ]
  store { %NativeBinding*, i64 }* %t1391, { %NativeBinding*, i64 }** %l7
  store { i8**, i64 }* %t1392, { i8**, i64 }** %l1
  %t1393 = load double, double* %l11
  %t1394 = sitofp i64 1 to double
  %t1395 = fadd double %t1393, %t1394
  store double %t1395, double* %l11
  br label %loop.latch2
merge102:
  %t1396 = sitofp i64 0 to double
  store double %t1396, double* %l34
  %t1397 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1398 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1399 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1400 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1401 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1402 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1403 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1404 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1405 = load %NativeFunction*, %NativeFunction** %l8
  %t1406 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1407 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1408 = load double, double* %l11
  %t1409 = load i8*, i8** %l12
  %t1410 = load i8*, i8** %l13
  %t1411 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1412 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1413 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  %t1414 = load double, double* %l34
  br label %loop.header106
loop.header106:
  %t1458 = phi %NativeFunction* [ %t1405, %merge102 ], [ %t1456, %loop.latch108 ]
  %t1459 = phi double [ %t1414, %merge102 ], [ %t1457, %loop.latch108 ]
  store %NativeFunction* %t1458, %NativeFunction** %l8
  store double %t1459, double* %l34
  br label %loop.body107
loop.body107:
  %t1415 = load double, double* %l34
  %t1416 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  %t1417 = load { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t1416
  %t1418 = extractvalue { %NativeInstruction**, i64 } %t1417, 1
  %t1419 = sitofp i64 %t1418 to double
  %t1420 = fcmp oge double %t1415, %t1419
  %t1421 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1422 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1423 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1424 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1425 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1426 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1427 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1428 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1429 = load %NativeFunction*, %NativeFunction** %l8
  %t1430 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1431 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1432 = load double, double* %l11
  %t1433 = load i8*, i8** %l12
  %t1434 = load i8*, i8** %l13
  %t1435 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1436 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1437 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  %t1438 = load double, double* %l34
  br i1 %t1420, label %then110, label %merge111
then110:
  br label %afterloop109
merge111:
  %t1439 = load %NativeFunction*, %NativeFunction** %l8
  %t1440 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  %t1441 = load double, double* %l34
  %t1442 = fptosi double %t1441 to i64
  %t1443 = load { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t1440
  %t1444 = extractvalue { %NativeInstruction**, i64 } %t1443, 0
  %t1445 = extractvalue { %NativeInstruction**, i64 } %t1443, 1
  %t1446 = icmp uge i64 %t1442, %t1445
  ; bounds check: %t1446 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t1442, i64 %t1445)
  %t1447 = getelementptr %NativeInstruction*, %NativeInstruction** %t1444, i64 %t1442
  %t1448 = load %NativeInstruction*, %NativeInstruction** %t1447
  %t1449 = load %NativeFunction, %NativeFunction* %t1439
  %t1450 = load %NativeInstruction, %NativeInstruction* %t1448
  %t1451 = call %NativeFunction @append_instruction(%NativeFunction %t1449, %NativeInstruction %t1450)
  %t1452 = alloca %NativeFunction
  store %NativeFunction %t1451, %NativeFunction* %t1452
  store %NativeFunction* %t1452, %NativeFunction** %l8
  %t1453 = load double, double* %l34
  %t1454 = sitofp i64 1 to double
  %t1455 = fadd double %t1453, %t1454
  store double %t1455, double* %l34
  br label %loop.latch108
loop.latch108:
  %t1456 = load %NativeFunction*, %NativeFunction** %l8
  %t1457 = load double, double* %l34
  br label %loop.header106
afterloop109:
  %t1460 = load %NativeFunction*, %NativeFunction** %l8
  %t1461 = load double, double* %l34
  %t1462 = load double, double* %l11
  %t1463 = sitofp i64 1 to double
  %t1464 = fadd double %t1462, %t1463
  store double %t1464, double* %l11
  br label %loop.latch2
loop.latch2:
  %t1465 = load double, double* %l11
  %t1466 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1467 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1468 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1469 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1470 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1471 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1472 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1473 = load %NativeFunction*, %NativeFunction** %l8
  %t1474 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1475 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  br label %loop.header0
afterloop3:
  %t1487 = load double, double* %l11
  %t1488 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1489 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1490 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1491 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1492 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1493 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1494 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1495 = load %NativeFunction*, %NativeFunction** %l8
  %t1496 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1497 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1498 = load %NativeFunction*, %NativeFunction** %l8
  %t1499 = icmp ne %NativeFunction* %t1498, null
  %t1500 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1501 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1502 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1503 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1504 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1505 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1506 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1507 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1508 = load %NativeFunction*, %NativeFunction** %l8
  %t1509 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1510 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1511 = load double, double* %l11
  br i1 %t1499, label %then112, label %merge113
then112:
  %t1512 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s1513 = getelementptr inbounds [41 x i8], [41 x i8]* @.str.len40.h1512965366, i32 0, i32 0
  %t1514 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1512, i8* %s1513)
  store { i8**, i64 }* %t1514, { i8**, i64 }** %l1
  %t1515 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge113
merge113:
  %t1516 = phi { i8**, i64 }* [ %t1515, %then112 ], [ %t1501, %afterloop3 ]
  store { i8**, i64 }* %t1516, { i8**, i64 }** %l1
  %t1517 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1518 = bitcast { %NativeFunction*, i64 }* %t1517 to { %NativeFunction**, i64 }*
  %t1519 = insertvalue %ParseNativeResult undef, { %NativeFunction**, i64 }* %t1518, 0
  %t1520 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1521 = bitcast { %NativeImport*, i64 }* %t1520 to { %NativeImport**, i64 }*
  %t1522 = insertvalue %ParseNativeResult %t1519, { %NativeImport**, i64 }* %t1521, 1
  %t1523 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1524 = bitcast { %NativeStruct*, i64 }* %t1523 to { %NativeStruct**, i64 }*
  %t1525 = insertvalue %ParseNativeResult %t1522, { %NativeStruct**, i64 }* %t1524, 2
  %t1526 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1527 = bitcast { %NativeInterface*, i64 }* %t1526 to { %NativeInterface**, i64 }*
  %t1528 = insertvalue %ParseNativeResult %t1525, { %NativeInterface**, i64 }* %t1527, 3
  %t1529 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1530 = bitcast { %NativeEnum*, i64 }* %t1529 to { %NativeEnum**, i64 }*
  %t1531 = insertvalue %ParseNativeResult %t1528, { %NativeEnum**, i64 }* %t1530, 4
  %t1532 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1533 = bitcast { %NativeBinding*, i64 }* %t1532 to { %NativeBinding**, i64 }*
  %t1534 = insertvalue %ParseNativeResult %t1531, { %NativeBinding**, i64 }* %t1533, 5
  %t1535 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1536 = insertvalue %ParseNativeResult %t1534, { i8**, i64 }* %t1535, 6
  ret %ParseNativeResult %t1536
}

define %NativeSourceSpan* @parse_source_span(i8* %text) {
block.entry:
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
  call void @sailfin_runtime_bounds_check(i64 0, i64 %t18)
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
  call void @sailfin_runtime_bounds_check(i64 1, i64 %t33)
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
  call void @sailfin_runtime_bounds_check(i64 2, i64 %t49)
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
  call void @sailfin_runtime_bounds_check(i64 3, i64 %t66)
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
block.entry:
  %t0 = call noalias i8* @malloc(i64 40)
  %t1 = bitcast i8* %t0 to %NativeFunction*
  store %NativeFunction %value, %NativeFunction* %t1
  %t2 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t3 = ptrtoint [1 x i8*]* %t2 to i64
  %t4 = icmp eq i64 %t3, 0
  %t5 = select i1 %t4, i64 1, i64 %t3
  %t6 = call i8* @malloc(i64 %t5)
  %t7 = bitcast i8* %t6 to i8**
  %t8 = getelementptr i8*, i8** %t7, i64 0
  store i8* %t0, i8** %t8
  %t9 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t10 = ptrtoint { i8**, i64 }* %t9 to i64
  %t11 = call i8* @malloc(i64 %t10)
  %t12 = bitcast i8* %t11 to { i8**, i64 }*
  %t13 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 0
  store i8** %t7, i8*** %t13
  %t14 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 1
  store i64 1, i64* %t14
  %t15 = bitcast { %NativeFunction*, i64 }* %functions to { i8**, i64 }*
  %t16 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t15, { i8**, i64 }* %t12)
  %t17 = bitcast { i8**, i64 }* %t16 to { %NativeFunction*, i64 }*
  ret { %NativeFunction*, i64 }* %t17
}

define { %NativeBinding*, i64 }* @append_binding({ %NativeBinding*, i64 }* %bindings, %NativeBinding %value) {
block.entry:
  %t0 = call noalias i8* @malloc(i64 32)
  %t1 = bitcast i8* %t0 to %NativeBinding*
  store %NativeBinding %value, %NativeBinding* %t1
  %t2 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t3 = ptrtoint [1 x i8*]* %t2 to i64
  %t4 = icmp eq i64 %t3, 0
  %t5 = select i1 %t4, i64 1, i64 %t3
  %t6 = call i8* @malloc(i64 %t5)
  %t7 = bitcast i8* %t6 to i8**
  %t8 = getelementptr i8*, i8** %t7, i64 0
  store i8* %t0, i8** %t8
  %t9 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t10 = ptrtoint { i8**, i64 }* %t9 to i64
  %t11 = call i8* @malloc(i64 %t10)
  %t12 = bitcast i8* %t11 to { i8**, i64 }*
  %t13 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 0
  store i8** %t7, i8*** %t13
  %t14 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 1
  store i64 1, i64* %t14
  %t15 = bitcast { %NativeBinding*, i64 }* %bindings to { i8**, i64 }*
  %t16 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t15, { i8**, i64 }* %t12)
  %t17 = bitcast { i8**, i64 }* %t16 to { %NativeBinding*, i64 }*
  ret { %NativeBinding*, i64 }* %t17
}

define { %NativeImport*, i64 }* @append_import({ %NativeImport*, i64 }* %imports, %NativeImport %value) {
block.entry:
  %t0 = call noalias i8* @malloc(i64 24)
  %t1 = bitcast i8* %t0 to %NativeImport*
  store %NativeImport %value, %NativeImport* %t1
  %t2 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t3 = ptrtoint [1 x i8*]* %t2 to i64
  %t4 = icmp eq i64 %t3, 0
  %t5 = select i1 %t4, i64 1, i64 %t3
  %t6 = call i8* @malloc(i64 %t5)
  %t7 = bitcast i8* %t6 to i8**
  %t8 = getelementptr i8*, i8** %t7, i64 0
  store i8* %t0, i8** %t8
  %t9 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t10 = ptrtoint { i8**, i64 }* %t9 to i64
  %t11 = call i8* @malloc(i64 %t10)
  %t12 = bitcast i8* %t11 to { i8**, i64 }*
  %t13 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 0
  store i8** %t7, i8*** %t13
  %t14 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 1
  store i64 1, i64* %t14
  %t15 = bitcast { %NativeImport*, i64 }* %imports to { i8**, i64 }*
  %t16 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t15, { i8**, i64 }* %t12)
  %t17 = bitcast { i8**, i64 }* %t16 to { %NativeImport*, i64 }*
  ret { %NativeImport*, i64 }* %t17
}

define { %NativeStruct*, i64 }* @append_struct({ %NativeStruct*, i64 }* %structs, %NativeStruct %value) {
block.entry:
  %t0 = call noalias i8* @malloc(i64 40)
  %t1 = bitcast i8* %t0 to %NativeStruct*
  store %NativeStruct %value, %NativeStruct* %t1
  %t2 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t3 = ptrtoint [1 x i8*]* %t2 to i64
  %t4 = icmp eq i64 %t3, 0
  %t5 = select i1 %t4, i64 1, i64 %t3
  %t6 = call i8* @malloc(i64 %t5)
  %t7 = bitcast i8* %t6 to i8**
  %t8 = getelementptr i8*, i8** %t7, i64 0
  store i8* %t0, i8** %t8
  %t9 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t10 = ptrtoint { i8**, i64 }* %t9 to i64
  %t11 = call i8* @malloc(i64 %t10)
  %t12 = bitcast i8* %t11 to { i8**, i64 }*
  %t13 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 0
  store i8** %t7, i8*** %t13
  %t14 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 1
  store i64 1, i64* %t14
  %t15 = bitcast { %NativeStruct*, i64 }* %structs to { i8**, i64 }*
  %t16 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t15, { i8**, i64 }* %t12)
  %t17 = bitcast { i8**, i64 }* %t16 to { %NativeStruct*, i64 }*
  ret { %NativeStruct*, i64 }* %t17
}

define { %NativeInterface*, i64 }* @append_interface({ %NativeInterface*, i64 }* %interfaces, %NativeInterface %value) {
block.entry:
  %t0 = call noalias i8* @malloc(i64 24)
  %t1 = bitcast i8* %t0 to %NativeInterface*
  store %NativeInterface %value, %NativeInterface* %t1
  %t2 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t3 = ptrtoint [1 x i8*]* %t2 to i64
  %t4 = icmp eq i64 %t3, 0
  %t5 = select i1 %t4, i64 1, i64 %t3
  %t6 = call i8* @malloc(i64 %t5)
  %t7 = bitcast i8* %t6 to i8**
  %t8 = getelementptr i8*, i8** %t7, i64 0
  store i8* %t0, i8** %t8
  %t9 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t10 = ptrtoint { i8**, i64 }* %t9 to i64
  %t11 = call i8* @malloc(i64 %t10)
  %t12 = bitcast i8* %t11 to { i8**, i64 }*
  %t13 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 0
  store i8** %t7, i8*** %t13
  %t14 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 1
  store i64 1, i64* %t14
  %t15 = bitcast { %NativeInterface*, i64 }* %interfaces to { i8**, i64 }*
  %t16 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t15, { i8**, i64 }* %t12)
  %t17 = bitcast { i8**, i64 }* %t16 to { %NativeInterface*, i64 }*
  ret { %NativeInterface*, i64 }* %t17
}

define { %NativeEnum*, i64 }* @append_enum({ %NativeEnum*, i64 }* %enums, %NativeEnum %value) {
block.entry:
  %t0 = call noalias i8* @malloc(i64 24)
  %t1 = bitcast i8* %t0 to %NativeEnum*
  store %NativeEnum %value, %NativeEnum* %t1
  %t2 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t3 = ptrtoint [1 x i8*]* %t2 to i64
  %t4 = icmp eq i64 %t3, 0
  %t5 = select i1 %t4, i64 1, i64 %t3
  %t6 = call i8* @malloc(i64 %t5)
  %t7 = bitcast i8* %t6 to i8**
  %t8 = getelementptr i8*, i8** %t7, i64 0
  store i8* %t0, i8** %t8
  %t9 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t10 = ptrtoint { i8**, i64 }* %t9 to i64
  %t11 = call i8* @malloc(i64 %t10)
  %t12 = bitcast i8* %t11 to { i8**, i64 }*
  %t13 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 0
  store i8** %t7, i8*** %t13
  %t14 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 1
  store i64 1, i64* %t14
  %t15 = bitcast { %NativeEnum*, i64 }* %enums to { i8**, i64 }*
  %t16 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t15, { i8**, i64 }* %t12)
  %t17 = bitcast { i8**, i64 }* %t16 to { %NativeEnum*, i64 }*
  ret { %NativeEnum*, i64 }* %t17
}

define { %NativeEnumVariant*, i64 }* @append_enum_variant({ %NativeEnumVariant*, i64 }* %variants, %NativeEnumVariant %value) {
block.entry:
  %t0 = call noalias i8* @malloc(i64 16)
  %t1 = bitcast i8* %t0 to %NativeEnumVariant*
  store %NativeEnumVariant %value, %NativeEnumVariant* %t1
  %t2 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t3 = ptrtoint [1 x i8*]* %t2 to i64
  %t4 = icmp eq i64 %t3, 0
  %t5 = select i1 %t4, i64 1, i64 %t3
  %t6 = call i8* @malloc(i64 %t5)
  %t7 = bitcast i8* %t6 to i8**
  %t8 = getelementptr i8*, i8** %t7, i64 0
  store i8* %t0, i8** %t8
  %t9 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t10 = ptrtoint { i8**, i64 }* %t9 to i64
  %t11 = call i8* @malloc(i64 %t10)
  %t12 = bitcast i8* %t11 to { i8**, i64 }*
  %t13 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 0
  store i8** %t7, i8*** %t13
  %t14 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 1
  store i64 1, i64* %t14
  %t15 = bitcast { %NativeEnumVariant*, i64 }* %variants to { i8**, i64 }*
  %t16 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t15, { i8**, i64 }* %t12)
  %t17 = bitcast { i8**, i64 }* %t16 to { %NativeEnumVariant*, i64 }*
  ret { %NativeEnumVariant*, i64 }* %t17
}

define { %NativeEnumVariantField*, i64 }* @append_enum_variant_field({ %NativeEnumVariantField*, i64 }* %fields, %NativeEnumVariantField %value) {
block.entry:
  %t0 = call noalias i8* @malloc(i64 24)
  %t1 = bitcast i8* %t0 to %NativeEnumVariantField*
  store %NativeEnumVariantField %value, %NativeEnumVariantField* %t1
  %t2 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t3 = ptrtoint [1 x i8*]* %t2 to i64
  %t4 = icmp eq i64 %t3, 0
  %t5 = select i1 %t4, i64 1, i64 %t3
  %t6 = call i8* @malloc(i64 %t5)
  %t7 = bitcast i8* %t6 to i8**
  %t8 = getelementptr i8*, i8** %t7, i64 0
  store i8* %t0, i8** %t8
  %t9 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t10 = ptrtoint { i8**, i64 }* %t9 to i64
  %t11 = call i8* @malloc(i64 %t10)
  %t12 = bitcast i8* %t11 to { i8**, i64 }*
  %t13 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 0
  store i8** %t7, i8*** %t13
  %t14 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 1
  store i64 1, i64* %t14
  %t15 = bitcast { %NativeEnumVariantField*, i64 }* %fields to { i8**, i64 }*
  %t16 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t15, { i8**, i64 }* %t12)
  %t17 = bitcast { i8**, i64 }* %t16 to { %NativeEnumVariantField*, i64 }*
  ret { %NativeEnumVariantField*, i64 }* %t17
}

define { %NativeStructField*, i64 }* @append_struct_field({ %NativeStructField*, i64 }* %fields, %NativeStructField %field) {
block.entry:
  %t0 = call noalias i8* @malloc(i64 24)
  %t1 = bitcast i8* %t0 to %NativeStructField*
  store %NativeStructField %field, %NativeStructField* %t1
  %t2 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t3 = ptrtoint [1 x i8*]* %t2 to i64
  %t4 = icmp eq i64 %t3, 0
  %t5 = select i1 %t4, i64 1, i64 %t3
  %t6 = call i8* @malloc(i64 %t5)
  %t7 = bitcast i8* %t6 to i8**
  %t8 = getelementptr i8*, i8** %t7, i64 0
  store i8* %t0, i8** %t8
  %t9 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t10 = ptrtoint { i8**, i64 }* %t9 to i64
  %t11 = call i8* @malloc(i64 %t10)
  %t12 = bitcast i8* %t11 to { i8**, i64 }*
  %t13 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 0
  store i8** %t7, i8*** %t13
  %t14 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 1
  store i64 1, i64* %t14
  %t15 = bitcast { %NativeStructField*, i64 }* %fields to { i8**, i64 }*
  %t16 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t15, { i8**, i64 }* %t12)
  %t17 = bitcast { i8**, i64 }* %t16 to { %NativeStructField*, i64 }*
  ret { %NativeStructField*, i64 }* %t17
}

define { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %fields, %NativeStructLayoutField %field) {
block.entry:
  %t0 = call noalias i8* @malloc(i64 40)
  %t1 = bitcast i8* %t0 to %NativeStructLayoutField*
  store %NativeStructLayoutField %field, %NativeStructLayoutField* %t1
  %t2 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t3 = ptrtoint [1 x i8*]* %t2 to i64
  %t4 = icmp eq i64 %t3, 0
  %t5 = select i1 %t4, i64 1, i64 %t3
  %t6 = call i8* @malloc(i64 %t5)
  %t7 = bitcast i8* %t6 to i8**
  %t8 = getelementptr i8*, i8** %t7, i64 0
  store i8* %t0, i8** %t8
  %t9 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t10 = ptrtoint { i8**, i64 }* %t9 to i64
  %t11 = call i8* @malloc(i64 %t10)
  %t12 = bitcast i8* %t11 to { i8**, i64 }*
  %t13 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 0
  store i8** %t7, i8*** %t13
  %t14 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 1
  store i64 1, i64* %t14
  %t15 = bitcast { %NativeStructLayoutField*, i64 }* %fields to { i8**, i64 }*
  %t16 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t15, { i8**, i64 }* %t12)
  %t17 = bitcast { i8**, i64 }* %t16 to { %NativeStructLayoutField*, i64 }*
  ret { %NativeStructLayoutField*, i64 }* %t17
}

define { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %variants, %NativeEnumVariantLayout %value) {
block.entry:
  %t0 = call noalias i8* @malloc(i64 48)
  %t1 = bitcast i8* %t0 to %NativeEnumVariantLayout*
  store %NativeEnumVariantLayout %value, %NativeEnumVariantLayout* %t1
  %t2 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t3 = ptrtoint [1 x i8*]* %t2 to i64
  %t4 = icmp eq i64 %t3, 0
  %t5 = select i1 %t4, i64 1, i64 %t3
  %t6 = call i8* @malloc(i64 %t5)
  %t7 = bitcast i8* %t6 to i8**
  %t8 = getelementptr i8*, i8** %t7, i64 0
  store i8* %t0, i8** %t8
  %t9 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t10 = ptrtoint { i8**, i64 }* %t9 to i64
  %t11 = call i8* @malloc(i64 %t10)
  %t12 = bitcast i8* %t11 to { i8**, i64 }*
  %t13 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 0
  store i8** %t7, i8*** %t13
  %t14 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 1
  store i64 1, i64* %t14
  %t15 = bitcast { %NativeEnumVariantLayout*, i64 }* %variants to { i8**, i64 }*
  %t16 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t15, { i8**, i64 }* %t12)
  %t17 = bitcast { i8**, i64 }* %t16 to { %NativeEnumVariantLayout*, i64 }*
  ret { %NativeEnumVariantLayout*, i64 }* %t17
}

define double @find_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %variants, i8* %name) {
block.entry:
  %l0 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t24 = phi double [ %t1, %block.entry ], [ %t23, %loop.latch2 ]
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
  call void @sailfin_runtime_bounds_check(i64 %t9, i64 %t12)
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
  %t25 = load double, double* %l0
  %t26 = sitofp i64 -1 to double
  ret double %t26
}

define { %NativeEnumVariantLayout*, i64 }* @update_enum_variant_fields({ %NativeEnumVariantLayout*, i64 }* %variants, double %index, %NativeStructLayoutField %field) {
block.entry:
  %l0 = alloca { %NativeEnumVariantLayout*, i64 }*
  %l1 = alloca double
  %l2 = alloca %NativeEnumVariantLayout
  %l3 = alloca %NativeEnumVariantLayout
  %t0 = getelementptr [0 x %NativeEnumVariantLayout], [0 x %NativeEnumVariantLayout]* null, i32 1
  %t1 = ptrtoint [0 x %NativeEnumVariantLayout]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %NativeEnumVariantLayout*
  %t6 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* null, i32 1
  %t7 = ptrtoint { %NativeEnumVariantLayout*, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { %NativeEnumVariantLayout*, i64 }*
  %t10 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t9, i32 0, i32 0
  store %NativeEnumVariantLayout* %t5, %NativeEnumVariantLayout** %t10
  %t11 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { %NativeEnumVariantLayout*, i64 }* %t9, { %NativeEnumVariantLayout*, i64 }** %l0
  %t12 = sitofp i64 0 to double
  store double %t12, double* %l1
  %t13 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  %t14 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t76 = phi { %NativeEnumVariantLayout*, i64 }* [ %t13, %block.entry ], [ %t74, %loop.latch2 ]
  %t77 = phi double [ %t14, %block.entry ], [ %t75, %loop.latch2 ]
  store { %NativeEnumVariantLayout*, i64 }* %t76, { %NativeEnumVariantLayout*, i64 }** %l0
  store double %t77, double* %l1
  br label %loop.body1
loop.body1:
  %t15 = load double, double* %l1
  %t16 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %variants
  %t17 = extractvalue { %NativeEnumVariantLayout*, i64 } %t16, 1
  %t18 = sitofp i64 %t17 to double
  %t19 = fcmp oge double %t15, %t18
  %t20 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  %t21 = load double, double* %l1
  br i1 %t19, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t22 = load double, double* %l1
  %t23 = fcmp oeq double %t22, %index
  %t24 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  %t25 = load double, double* %l1
  br i1 %t23, label %then6, label %else7
then6:
  %t26 = load double, double* %l1
  %t27 = fptosi double %t26 to i64
  %t28 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %variants
  %t29 = extractvalue { %NativeEnumVariantLayout*, i64 } %t28, 0
  %t30 = extractvalue { %NativeEnumVariantLayout*, i64 } %t28, 1
  %t31 = icmp uge i64 %t27, %t30
  ; bounds check: %t31 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t27, i64 %t30)
  %t32 = getelementptr %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t29, i64 %t27
  %t33 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t32
  store %NativeEnumVariantLayout %t33, %NativeEnumVariantLayout* %l2
  %t34 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t35 = extractvalue %NativeEnumVariantLayout %t34, 0
  %t36 = insertvalue %NativeEnumVariantLayout undef, i8* %t35, 0
  %t37 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t38 = extractvalue %NativeEnumVariantLayout %t37, 1
  %t39 = insertvalue %NativeEnumVariantLayout %t36, double %t38, 1
  %t40 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t41 = extractvalue %NativeEnumVariantLayout %t40, 2
  %t42 = insertvalue %NativeEnumVariantLayout %t39, double %t41, 2
  %t43 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t44 = extractvalue %NativeEnumVariantLayout %t43, 3
  %t45 = insertvalue %NativeEnumVariantLayout %t42, double %t44, 3
  %t46 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t47 = extractvalue %NativeEnumVariantLayout %t46, 4
  %t48 = insertvalue %NativeEnumVariantLayout %t45, double %t47, 4
  %t49 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t50 = extractvalue %NativeEnumVariantLayout %t49, 5
  %t51 = bitcast { %NativeStructLayoutField**, i64 }* %t50 to { %NativeStructLayoutField*, i64 }*
  %t52 = call { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %t51, %NativeStructLayoutField %field)
  %t53 = bitcast { %NativeStructLayoutField*, i64 }* %t52 to { %NativeStructLayoutField**, i64 }*
  %t54 = insertvalue %NativeEnumVariantLayout %t48, { %NativeStructLayoutField**, i64 }* %t53, 5
  store %NativeEnumVariantLayout %t54, %NativeEnumVariantLayout* %l3
  %t55 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  %t56 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l3
  %t57 = call { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t55, %NativeEnumVariantLayout %t56)
  store { %NativeEnumVariantLayout*, i64 }* %t57, { %NativeEnumVariantLayout*, i64 }** %l0
  %t58 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  br label %merge8
else7:
  %t59 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  %t60 = load double, double* %l1
  %t61 = fptosi double %t60 to i64
  %t62 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %variants
  %t63 = extractvalue { %NativeEnumVariantLayout*, i64 } %t62, 0
  %t64 = extractvalue { %NativeEnumVariantLayout*, i64 } %t62, 1
  %t65 = icmp uge i64 %t61, %t64
  ; bounds check: %t65 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t61, i64 %t64)
  %t66 = getelementptr %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t63, i64 %t61
  %t67 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t66
  %t68 = call { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t59, %NativeEnumVariantLayout %t67)
  store { %NativeEnumVariantLayout*, i64 }* %t68, { %NativeEnumVariantLayout*, i64 }** %l0
  %t69 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  br label %merge8
merge8:
  %t70 = phi { %NativeEnumVariantLayout*, i64 }* [ %t58, %then6 ], [ %t69, %else7 ]
  store { %NativeEnumVariantLayout*, i64 }* %t70, { %NativeEnumVariantLayout*, i64 }** %l0
  %t71 = load double, double* %l1
  %t72 = sitofp i64 1 to double
  %t73 = fadd double %t71, %t72
  store double %t73, double* %l1
  br label %loop.latch2
loop.latch2:
  %t74 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  %t75 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t78 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  %t79 = load double, double* %l1
  %t80 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  ret { %NativeEnumVariantLayout*, i64 }* %t80
}

define %NativeFunction @append_parameter(%NativeFunction %function, %NativeParameter %parameter) {
block.entry:
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
block.entry:
  %l0 = alloca { i8**, i64 }*
  %t0 = extractvalue %NativeFunction %function, 4
  %t1 = call noalias i8* @malloc(i64 56)
  %t2 = bitcast i8* %t1 to %NativeInstruction*
  store %NativeInstruction %instruction, %NativeInstruction* %t2
  %t3 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t4 = ptrtoint [1 x i8*]* %t3 to i64
  %t5 = icmp eq i64 %t4, 0
  %t6 = select i1 %t5, i64 1, i64 %t4
  %t7 = call i8* @malloc(i64 %t6)
  %t8 = bitcast i8* %t7 to i8**
  %t9 = getelementptr i8*, i8** %t8, i64 0
  store i8* %t1, i8** %t9
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t11 = ptrtoint { i8**, i64 }* %t10 to i64
  %t12 = call i8* @malloc(i64 %t11)
  %t13 = bitcast i8* %t12 to { i8**, i64 }*
  %t14 = getelementptr { i8**, i64 }, { i8**, i64 }* %t13, i32 0, i32 0
  store i8** %t8, i8*** %t14
  %t15 = getelementptr { i8**, i64 }, { i8**, i64 }* %t13, i32 0, i32 1
  store i64 1, i64* %t15
  %t16 = bitcast { %NativeInstruction**, i64 }* %t0 to { i8**, i64 }*
  %t17 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t16, { i8**, i64 }* %t13)
  store { i8**, i64 }* %t17, { i8**, i64 }** %l0
  %t18 = extractvalue %NativeFunction %function, 0
  %t19 = insertvalue %NativeFunction undef, i8* %t18, 0
  %t20 = extractvalue %NativeFunction %function, 1
  %t21 = insertvalue %NativeFunction %t19, { %NativeParameter**, i64 }* %t20, 1
  %t22 = extractvalue %NativeFunction %function, 2
  %t23 = insertvalue %NativeFunction %t21, i8* %t22, 2
  %t24 = extractvalue %NativeFunction %function, 3
  %t25 = insertvalue %NativeFunction %t23, { i8**, i64 }* %t24, 3
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t27 = bitcast { i8**, i64 }* %t26 to { %NativeInstruction**, i64 }*
  %t28 = insertvalue %NativeFunction %t25, { %NativeInstruction**, i64 }* %t27, 4
  ret %NativeFunction %t28
}

define %NativeBinding @binding_from_instruction(%NativeInstruction %instruction) {
block.entry:
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
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca { i8**, i64 }*
  %t0 = call i8* @trim_text(i8* %entry)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %s2 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h655348872, i32 0, i32 0
  %t3 = call i1 @starts_with(i8* %t1, i8* %s2)
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = load i8*, i8** %l0
  %s6 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h655348872, i32 0, i32 0
  %t7 = call i8* @strip_prefix(i8* %t5, i8* %s6)
  %t8 = call i8* @trim_text(i8* %t7)
  store i8* %t8, i8** %l1
  %t9 = load i8*, i8** %l1
  %t10 = extractvalue %NativeFunction %function, 3
  %t11 = call %NativeFunction @update_function_meta(%NativeFunction %function, i8* %t9, { i8**, i64 }* %t10)
  ret %NativeFunction %t11
merge1:
  %t12 = load i8*, i8** %l0
  %s13 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h787332764, i32 0, i32 0
  %t14 = call i1 @starts_with(i8* %t12, i8* %s13)
  %t15 = load i8*, i8** %l0
  br i1 %t14, label %then2, label %merge3
then2:
  %t16 = load i8*, i8** %l0
  %s17 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h787332764, i32 0, i32 0
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
block.entry:
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
block.entry:
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
  %s4 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
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
  call void @sailfin_runtime_bounds_check(i64 %t8, i64 %t11)
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
  %t122 = phi i8* [ %t50, %merge7 ], [ %t118, %loop.latch10 ]
  %t123 = phi %InstructionDepthState [ %t49, %merge7 ], [ %t119, %loop.latch10 ]
  %t124 = phi double [ %t51, %merge7 ], [ %t120, %loop.latch10 ]
  %t125 = phi double [ %t52, %merge7 ], [ %t121, %loop.latch10 ]
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
  call void @sailfin_runtime_bounds_check(i64 %t64, i64 %t67)
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
  %t82 = alloca [2 x i8], align 1
  %t83 = getelementptr [2 x i8], [2 x i8]* %t82, i32 0, i32 0
  store i8 10, i8* %t83
  %t84 = getelementptr [2 x i8], [2 x i8]* %t82, i32 0, i32 1
  store i8 0, i8* %t84
  %t85 = getelementptr [2 x i8], [2 x i8]* %t82, i32 0, i32 0
  %t86 = call i8* @sailfin_runtime_string_concat(i8* %t81, i8* %t85)
  store i8* %t86, i8** %l2
  %t87 = load i8*, i8** %l2
  br label %merge16
else15:
  %t88 = load i8*, i8** %l2
  %t89 = alloca [2 x i8], align 1
  %t90 = getelementptr [2 x i8], [2 x i8]* %t89, i32 0, i32 0
  store i8 10, i8* %t90
  %t91 = getelementptr [2 x i8], [2 x i8]* %t89, i32 0, i32 1
  store i8 0, i8* %t91
  %t92 = getelementptr [2 x i8], [2 x i8]* %t89, i32 0, i32 0
  %t93 = call i8* @sailfin_runtime_string_concat(i8* %t88, i8* %t92)
  %t94 = load i8*, i8** %l5
  %t95 = call i8* @sailfin_runtime_string_concat(i8* %t93, i8* %t94)
  store i8* %t95, i8** %l2
  %t96 = load %InstructionDepthState, %InstructionDepthState* %l1
  %t97 = load i8*, i8** %l5
  %t98 = call %InstructionDepthState @update_instruction_depth_state(%InstructionDepthState %t96, i8* %t97)
  store %InstructionDepthState %t98, %InstructionDepthState* %l1
  %t99 = load i8*, i8** %l2
  %t100 = load %InstructionDepthState, %InstructionDepthState* %l1
  br label %merge16
merge16:
  %t101 = phi i8* [ %t87, %then14 ], [ %t99, %else15 ]
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
  %t127 = load %InstructionDepthState, %InstructionDepthState* %l1
  %t128 = load double, double* %l3
  %t129 = load double, double* %l4
  %t130 = load i8*, i8** %l2
  %t131 = call i8* @trim_text(i8* %t130)
  store i8* %t131, i8** %l6
  %t132 = load i8*, i8** %l6
  %t133 = insertvalue %InstructionGatherResult undef, i8* %t132, 0
  %t134 = load double, double* %l3
  %t135 = insertvalue %InstructionGatherResult %t133, double %t134, 1
  ret %InstructionGatherResult %t135
}

define i1 @instruction_supports_multiline(i8* %line) {
block.entry:
  %s0 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2080793783, i32 0, i32 0
  %t1 = call i1 @starts_with(i8* %line, i8* %s0)
  br i1 %t1, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %s2 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h273104342, i32 0, i32 0
  %t3 = call i1 @starts_with(i8* %line, i8* %s2)
  br i1 %t3, label %then2, label %merge3
then2:
  ret i1 1
merge3:
  ret i1 0
}

define i1 @instruction_requires_continuation(%InstructionDepthState %state) {
block.entry:
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
block.entry:
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
block.entry:
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
  %t218 = phi i1 [ %t10, %block.entry ], [ %t212, %loop.latch2 ]
  %t219 = phi double [ %t11, %block.entry ], [ %t213, %loop.latch2 ]
  %t220 = phi i1 [ %t9, %block.entry ], [ %t214, %loop.latch2 ]
  %t221 = phi double [ %t6, %block.entry ], [ %t215, %loop.latch2 ]
  %t222 = phi double [ %t7, %block.entry ], [ %t216, %loop.latch2 ]
  %t223 = phi double [ %t8, %block.entry ], [ %t217, %loop.latch2 ]
  store i1 %t218, i1* %l4
  store double %t219, double* %l5
  store i1 %t220, i1* %l3
  store double %t221, double* %l0
  store double %t222, double* %l1
  store double %t223, double* %l2
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
  %t66 = load i1, i1* %l3
  br label %merge13
merge13:
  %t67 = phi i1 [ %t66, %then12 ], [ %t62, %merge11 ]
  store i1 %t67, i1* %l3
  %t68 = load double, double* %l5
  %t69 = sitofp i64 1 to double
  %t70 = fadd double %t68, %t69
  store double %t70, double* %l5
  br label %loop.latch2
merge7:
  %t71 = load i8, i8* %l6
  %t72 = icmp eq i8 %t71, 34
  %t73 = load double, double* %l0
  %t74 = load double, double* %l1
  %t75 = load double, double* %l2
  %t76 = load i1, i1* %l3
  %t77 = load i1, i1* %l4
  %t78 = load double, double* %l5
  %t79 = load i8, i8* %l6
  br i1 %t72, label %then14, label %merge15
then14:
  store i1 1, i1* %l3
  %t80 = load double, double* %l5
  %t81 = sitofp i64 1 to double
  %t82 = fadd double %t80, %t81
  store double %t82, double* %l5
  br label %loop.latch2
merge15:
  %t83 = load i8, i8* %l6
  %t84 = icmp eq i8 %t83, 40
  %t85 = load double, double* %l0
  %t86 = load double, double* %l1
  %t87 = load double, double* %l2
  %t88 = load i1, i1* %l3
  %t89 = load i1, i1* %l4
  %t90 = load double, double* %l5
  %t91 = load i8, i8* %l6
  br i1 %t84, label %then16, label %merge17
then16:
  %t92 = load double, double* %l0
  %t93 = sitofp i64 1 to double
  %t94 = fadd double %t92, %t93
  store double %t94, double* %l0
  %t95 = load double, double* %l5
  %t96 = sitofp i64 1 to double
  %t97 = fadd double %t95, %t96
  store double %t97, double* %l5
  br label %loop.latch2
merge17:
  %t98 = load i8, i8* %l6
  %t99 = icmp eq i8 %t98, 41
  %t100 = load double, double* %l0
  %t101 = load double, double* %l1
  %t102 = load double, double* %l2
  %t103 = load i1, i1* %l3
  %t104 = load i1, i1* %l4
  %t105 = load double, double* %l5
  %t106 = load i8, i8* %l6
  br i1 %t99, label %then18, label %merge19
then18:
  %t107 = load double, double* %l0
  %t108 = sitofp i64 0 to double
  %t109 = fcmp ogt double %t107, %t108
  %t110 = load double, double* %l0
  %t111 = load double, double* %l1
  %t112 = load double, double* %l2
  %t113 = load i1, i1* %l3
  %t114 = load i1, i1* %l4
  %t115 = load double, double* %l5
  %t116 = load i8, i8* %l6
  br i1 %t109, label %then20, label %merge21
then20:
  %t117 = load double, double* %l0
  %t118 = sitofp i64 1 to double
  %t119 = fsub double %t117, %t118
  store double %t119, double* %l0
  %t120 = load double, double* %l0
  br label %merge21
merge21:
  %t121 = phi double [ %t120, %then20 ], [ %t110, %then18 ]
  store double %t121, double* %l0
  %t122 = load double, double* %l5
  %t123 = sitofp i64 1 to double
  %t124 = fadd double %t122, %t123
  store double %t124, double* %l5
  br label %loop.latch2
merge19:
  %t125 = load i8, i8* %l6
  %t126 = icmp eq i8 %t125, 91
  %t127 = load double, double* %l0
  %t128 = load double, double* %l1
  %t129 = load double, double* %l2
  %t130 = load i1, i1* %l3
  %t131 = load i1, i1* %l4
  %t132 = load double, double* %l5
  %t133 = load i8, i8* %l6
  br i1 %t126, label %then22, label %merge23
then22:
  %t134 = load double, double* %l1
  %t135 = sitofp i64 1 to double
  %t136 = fadd double %t134, %t135
  store double %t136, double* %l1
  %t137 = load double, double* %l5
  %t138 = sitofp i64 1 to double
  %t139 = fadd double %t137, %t138
  store double %t139, double* %l5
  br label %loop.latch2
merge23:
  %t140 = load i8, i8* %l6
  %t141 = icmp eq i8 %t140, 93
  %t142 = load double, double* %l0
  %t143 = load double, double* %l1
  %t144 = load double, double* %l2
  %t145 = load i1, i1* %l3
  %t146 = load i1, i1* %l4
  %t147 = load double, double* %l5
  %t148 = load i8, i8* %l6
  br i1 %t141, label %then24, label %merge25
then24:
  %t149 = load double, double* %l1
  %t150 = sitofp i64 0 to double
  %t151 = fcmp ogt double %t149, %t150
  %t152 = load double, double* %l0
  %t153 = load double, double* %l1
  %t154 = load double, double* %l2
  %t155 = load i1, i1* %l3
  %t156 = load i1, i1* %l4
  %t157 = load double, double* %l5
  %t158 = load i8, i8* %l6
  br i1 %t151, label %then26, label %merge27
then26:
  %t159 = load double, double* %l1
  %t160 = sitofp i64 1 to double
  %t161 = fsub double %t159, %t160
  store double %t161, double* %l1
  %t162 = load double, double* %l1
  br label %merge27
merge27:
  %t163 = phi double [ %t162, %then26 ], [ %t153, %then24 ]
  store double %t163, double* %l1
  %t164 = load double, double* %l5
  %t165 = sitofp i64 1 to double
  %t166 = fadd double %t164, %t165
  store double %t166, double* %l5
  br label %loop.latch2
merge25:
  %t167 = load i8, i8* %l6
  %t168 = icmp eq i8 %t167, 123
  %t169 = load double, double* %l0
  %t170 = load double, double* %l1
  %t171 = load double, double* %l2
  %t172 = load i1, i1* %l3
  %t173 = load i1, i1* %l4
  %t174 = load double, double* %l5
  %t175 = load i8, i8* %l6
  br i1 %t168, label %then28, label %merge29
then28:
  %t176 = load double, double* %l2
  %t177 = sitofp i64 1 to double
  %t178 = fadd double %t176, %t177
  store double %t178, double* %l2
  %t179 = load double, double* %l5
  %t180 = sitofp i64 1 to double
  %t181 = fadd double %t179, %t180
  store double %t181, double* %l5
  br label %loop.latch2
merge29:
  %t182 = load i8, i8* %l6
  %t183 = icmp eq i8 %t182, 125
  %t184 = load double, double* %l0
  %t185 = load double, double* %l1
  %t186 = load double, double* %l2
  %t187 = load i1, i1* %l3
  %t188 = load i1, i1* %l4
  %t189 = load double, double* %l5
  %t190 = load i8, i8* %l6
  br i1 %t183, label %then30, label %merge31
then30:
  %t191 = load double, double* %l2
  %t192 = sitofp i64 0 to double
  %t193 = fcmp ogt double %t191, %t192
  %t194 = load double, double* %l0
  %t195 = load double, double* %l1
  %t196 = load double, double* %l2
  %t197 = load i1, i1* %l3
  %t198 = load i1, i1* %l4
  %t199 = load double, double* %l5
  %t200 = load i8, i8* %l6
  br i1 %t193, label %then32, label %merge33
then32:
  %t201 = load double, double* %l2
  %t202 = sitofp i64 1 to double
  %t203 = fsub double %t201, %t202
  store double %t203, double* %l2
  %t204 = load double, double* %l2
  br label %merge33
merge33:
  %t205 = phi double [ %t204, %then32 ], [ %t196, %then30 ]
  store double %t205, double* %l2
  %t206 = load double, double* %l5
  %t207 = sitofp i64 1 to double
  %t208 = fadd double %t206, %t207
  store double %t208, double* %l5
  br label %loop.latch2
merge31:
  %t209 = load double, double* %l5
  %t210 = sitofp i64 1 to double
  %t211 = fadd double %t209, %t210
  store double %t211, double* %l5
  br label %loop.latch2
loop.latch2:
  %t212 = load i1, i1* %l4
  %t213 = load double, double* %l5
  %t214 = load i1, i1* %l3
  %t215 = load double, double* %l0
  %t216 = load double, double* %l1
  %t217 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t224 = load i1, i1* %l4
  %t225 = load double, double* %l5
  %t226 = load i1, i1* %l3
  %t227 = load double, double* %l0
  %t228 = load double, double* %l1
  %t229 = load double, double* %l2
  %t230 = load double, double* %l0
  %t231 = insertvalue %InstructionDepthState undef, double %t230, 0
  %t232 = load double, double* %l1
  %t233 = insertvalue %InstructionDepthState %t231, double %t232, 1
  %t234 = load double, double* %l2
  %t235 = insertvalue %InstructionDepthState %t233, double %t234, 2
  %t236 = load i1, i1* %l3
  %t237 = insertvalue %InstructionDepthState %t235, i1 %t236, 3
  %t238 = load i1, i1* %l4
  %t239 = insertvalue %InstructionDepthState %t237, i1 %t238, 4
  ret %InstructionDepthState %t239
}

define %InstructionParseResult @parse_instruction(i8* %line, %NativeSourceSpan* %span, %NativeSourceSpan* %value_span) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca i8*
  %l6 = alloca i8*
  %l7 = alloca i8*
  %l8 = alloca i8*
  %l9 = alloca i8
  %l10 = alloca i8*
  %l11 = alloca i8*
  %l12 = alloca i1
  %l13 = alloca %BindingComponents
  %s0 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h268717223, i32 0, i32 0
  %t1 = icmp eq i8* %line, %s0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = insertvalue %NativeInstruction undef, i32 15, 0
  %t3 = call noalias i8* @malloc(i64 56)
  %t4 = bitcast i8* %t3 to %NativeInstruction*
  store %NativeInstruction %t2, %NativeInstruction* %t4
  %t5 = bitcast i8* %t3 to %NativeInstruction*
  %t6 = getelementptr [1 x %NativeInstruction*], [1 x %NativeInstruction*]* null, i32 1
  %t7 = ptrtoint [1 x %NativeInstruction*]* %t6 to i64
  %t8 = icmp eq i64 %t7, 0
  %t9 = select i1 %t8, i64 1, i64 %t7
  %t10 = call i8* @malloc(i64 %t9)
  %t11 = bitcast i8* %t10 to %NativeInstruction**
  %t12 = getelementptr %NativeInstruction*, %NativeInstruction** %t11, i64 0
  store %NativeInstruction* %t5, %NativeInstruction** %t12
  %t13 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* null, i32 1
  %t14 = ptrtoint { %NativeInstruction**, i64 }* %t13 to i64
  %t15 = call i8* @malloc(i64 %t14)
  %t16 = bitcast i8* %t15 to { %NativeInstruction**, i64 }*
  %t17 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t16, i32 0, i32 0
  store %NativeInstruction** %t11, %NativeInstruction*** %t17
  %t18 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t16, i32 0, i32 1
  store i64 1, i64* %t18
  %t19 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t16, 0
  %t20 = insertvalue %InstructionParseResult %t19, i1 0, 1
  %t21 = insertvalue %InstructionParseResult %t20, i1 0, 2
  ret %InstructionParseResult %t21
merge1:
  %s22 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h192590216, i32 0, i32 0
  %t23 = call i1 @starts_with(i8* %line, i8* %s22)
  br i1 %t23, label %then2, label %merge3
then2:
  %s24 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h192590216, i32 0, i32 0
  %t25 = call i8* @strip_prefix(i8* %line, i8* %s24)
  %t26 = call i8* @trim_text(i8* %t25)
  store i8* %t26, i8** %l0
  %t27 = alloca %NativeInstruction
  %t28 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t27, i32 0, i32 0
  store i32 3, i32* %t28
  %t29 = load i8*, i8** %l0
  %t30 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t27, i32 0, i32 1
  %t31 = bitcast [8 x i8]* %t30 to i8*
  %t32 = bitcast i8* %t31 to i8**
  store i8* %t29, i8** %t32
  %t33 = load %NativeInstruction, %NativeInstruction* %t27
  %t34 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t35 = ptrtoint [1 x %NativeInstruction]* %t34 to i64
  %t36 = icmp eq i64 %t35, 0
  %t37 = select i1 %t36, i64 1, i64 %t35
  %t38 = call i8* @malloc(i64 %t37)
  %t39 = bitcast i8* %t38 to %NativeInstruction*
  %t40 = getelementptr %NativeInstruction, %NativeInstruction* %t39, i64 0
  store %NativeInstruction %t33, %NativeInstruction* %t40
  %t41 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t42 = ptrtoint { %NativeInstruction*, i64 }* %t41 to i64
  %t43 = call i8* @malloc(i64 %t42)
  %t44 = bitcast i8* %t43 to { %NativeInstruction*, i64 }*
  %t45 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t44, i32 0, i32 0
  store %NativeInstruction* %t39, %NativeInstruction** %t45
  %t46 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t44, i32 0, i32 1
  store i64 1, i64* %t46
  %t47 = bitcast { %NativeInstruction*, i64 }* %t44 to { %NativeInstruction**, i64 }*
  %t48 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t47, 0
  %t49 = insertvalue %InstructionParseResult %t48, i1 0, 1
  %t50 = insertvalue %InstructionParseResult %t49, i1 0, 2
  ret %InstructionParseResult %t50
merge3:
  %s51 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2056075365, i32 0, i32 0
  %t52 = icmp eq i8* %line, %s51
  br i1 %t52, label %then4, label %merge5
then4:
  %t53 = insertvalue %NativeInstruction undef, i32 4, 0
  %t54 = call noalias i8* @malloc(i64 56)
  %t55 = bitcast i8* %t54 to %NativeInstruction*
  store %NativeInstruction %t53, %NativeInstruction* %t55
  %t56 = bitcast i8* %t54 to %NativeInstruction*
  %t57 = getelementptr [1 x %NativeInstruction*], [1 x %NativeInstruction*]* null, i32 1
  %t58 = ptrtoint [1 x %NativeInstruction*]* %t57 to i64
  %t59 = icmp eq i64 %t58, 0
  %t60 = select i1 %t59, i64 1, i64 %t58
  %t61 = call i8* @malloc(i64 %t60)
  %t62 = bitcast i8* %t61 to %NativeInstruction**
  %t63 = getelementptr %NativeInstruction*, %NativeInstruction** %t62, i64 0
  store %NativeInstruction* %t56, %NativeInstruction** %t63
  %t64 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* null, i32 1
  %t65 = ptrtoint { %NativeInstruction**, i64 }* %t64 to i64
  %t66 = call i8* @malloc(i64 %t65)
  %t67 = bitcast i8* %t66 to { %NativeInstruction**, i64 }*
  %t68 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t67, i32 0, i32 0
  store %NativeInstruction** %t62, %NativeInstruction*** %t68
  %t69 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t67, i32 0, i32 1
  store i64 1, i64* %t69
  %t70 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t67, 0
  %t71 = insertvalue %InstructionParseResult %t70, i1 0, 1
  %t72 = insertvalue %InstructionParseResult %t71, i1 0, 2
  ret %InstructionParseResult %t72
merge5:
  %s73 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1280334338, i32 0, i32 0
  %t74 = icmp eq i8* %line, %s73
  br i1 %t74, label %then6, label %merge7
then6:
  %t75 = insertvalue %NativeInstruction undef, i32 5, 0
  %t76 = call noalias i8* @malloc(i64 56)
  %t77 = bitcast i8* %t76 to %NativeInstruction*
  store %NativeInstruction %t75, %NativeInstruction* %t77
  %t78 = bitcast i8* %t76 to %NativeInstruction*
  %t79 = getelementptr [1 x %NativeInstruction*], [1 x %NativeInstruction*]* null, i32 1
  %t80 = ptrtoint [1 x %NativeInstruction*]* %t79 to i64
  %t81 = icmp eq i64 %t80, 0
  %t82 = select i1 %t81, i64 1, i64 %t80
  %t83 = call i8* @malloc(i64 %t82)
  %t84 = bitcast i8* %t83 to %NativeInstruction**
  %t85 = getelementptr %NativeInstruction*, %NativeInstruction** %t84, i64 0
  store %NativeInstruction* %t78, %NativeInstruction** %t85
  %t86 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* null, i32 1
  %t87 = ptrtoint { %NativeInstruction**, i64 }* %t86 to i64
  %t88 = call i8* @malloc(i64 %t87)
  %t89 = bitcast i8* %t88 to { %NativeInstruction**, i64 }*
  %t90 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t89, i32 0, i32 0
  store %NativeInstruction** %t84, %NativeInstruction*** %t90
  %t91 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t89, i32 0, i32 1
  store i64 1, i64* %t91
  %t92 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t89, 0
  %t93 = insertvalue %InstructionParseResult %t92, i1 0, 1
  %t94 = insertvalue %InstructionParseResult %t93, i1 0, 2
  ret %InstructionParseResult %t94
merge7:
  %s95 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2057365731, i32 0, i32 0
  %t96 = call i1 @starts_with(i8* %line, i8* %s95)
  br i1 %t96, label %then8, label %merge9
then8:
  %s97 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2057365731, i32 0, i32 0
  %t98 = call i8* @strip_prefix(i8* %line, i8* %s97)
  %t99 = call i8* @trim_text(i8* %t98)
  store i8* %t99, i8** %l1
  %s100 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h175996034, i32 0, i32 0
  store i8* %s100, i8** %l2
  %t101 = load i8*, i8** %l1
  %t102 = load i8*, i8** %l2
  %t103 = call double @index_of(i8* %t101, i8* %t102)
  store double %t103, double* %l3
  %t104 = load double, double* %l3
  %t105 = sitofp i64 0 to double
  %t106 = fcmp oge double %t104, %t105
  %t107 = load i8*, i8** %l1
  %t108 = load i8*, i8** %l2
  %t109 = load double, double* %l3
  br i1 %t106, label %then10, label %merge11
then10:
  %t110 = load i8*, i8** %l1
  %t111 = load double, double* %l3
  %t112 = fptosi double %t111 to i64
  %t113 = call i8* @sailfin_runtime_substring(i8* %t110, i64 0, i64 %t112)
  %t114 = call i8* @trim_text(i8* %t113)
  store i8* %t114, i8** %l4
  %t115 = load i8*, i8** %l1
  %t116 = load double, double* %l3
  %t117 = load i8*, i8** %l2
  %t118 = call i64 @sailfin_runtime_string_length(i8* %t117)
  %t119 = sitofp i64 %t118 to double
  %t120 = fadd double %t116, %t119
  %t121 = load i8*, i8** %l1
  %t122 = call i64 @sailfin_runtime_string_length(i8* %t121)
  %t123 = fptosi double %t120 to i64
  %t124 = call i8* @sailfin_runtime_substring(i8* %t115, i64 %t123, i64 %t122)
  %t125 = call i8* @trim_text(i8* %t124)
  store i8* %t125, i8** %l5
  %t126 = alloca %NativeInstruction
  %t127 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t126, i32 0, i32 0
  store i32 6, i32* %t127
  %t128 = load i8*, i8** %l4
  %t129 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t126, i32 0, i32 1
  %t130 = bitcast [16 x i8]* %t129 to i8*
  %t131 = bitcast i8* %t130 to i8**
  store i8* %t128, i8** %t131
  %t132 = load i8*, i8** %l5
  %t133 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t126, i32 0, i32 1
  %t134 = bitcast [16 x i8]* %t133 to i8*
  %t135 = getelementptr inbounds i8, i8* %t134, i64 8
  %t136 = bitcast i8* %t135 to i8**
  store i8* %t132, i8** %t136
  %t137 = load %NativeInstruction, %NativeInstruction* %t126
  %t138 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t139 = ptrtoint [1 x %NativeInstruction]* %t138 to i64
  %t140 = icmp eq i64 %t139, 0
  %t141 = select i1 %t140, i64 1, i64 %t139
  %t142 = call i8* @malloc(i64 %t141)
  %t143 = bitcast i8* %t142 to %NativeInstruction*
  %t144 = getelementptr %NativeInstruction, %NativeInstruction* %t143, i64 0
  store %NativeInstruction %t137, %NativeInstruction* %t144
  %t145 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t146 = ptrtoint { %NativeInstruction*, i64 }* %t145 to i64
  %t147 = call i8* @malloc(i64 %t146)
  %t148 = bitcast i8* %t147 to { %NativeInstruction*, i64 }*
  %t149 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t148, i32 0, i32 0
  store %NativeInstruction* %t143, %NativeInstruction** %t149
  %t150 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t148, i32 0, i32 1
  store i64 1, i64* %t150
  %t151 = bitcast { %NativeInstruction*, i64 }* %t148 to { %NativeInstruction**, i64 }*
  %t152 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t151, 0
  %t153 = insertvalue %InstructionParseResult %t152, i1 0, 1
  %t154 = insertvalue %InstructionParseResult %t153, i1 0, 2
  ret %InstructionParseResult %t154
merge11:
  br label %merge9
merge9:
  %s155 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h1448749422, i32 0, i32 0
  %t156 = icmp eq i8* %line, %s155
  br i1 %t156, label %then12, label %merge13
then12:
  %t157 = insertvalue %NativeInstruction undef, i32 7, 0
  %t158 = call noalias i8* @malloc(i64 56)
  %t159 = bitcast i8* %t158 to %NativeInstruction*
  store %NativeInstruction %t157, %NativeInstruction* %t159
  %t160 = bitcast i8* %t158 to %NativeInstruction*
  %t161 = getelementptr [1 x %NativeInstruction*], [1 x %NativeInstruction*]* null, i32 1
  %t162 = ptrtoint [1 x %NativeInstruction*]* %t161 to i64
  %t163 = icmp eq i64 %t162, 0
  %t164 = select i1 %t163, i64 1, i64 %t162
  %t165 = call i8* @malloc(i64 %t164)
  %t166 = bitcast i8* %t165 to %NativeInstruction**
  %t167 = getelementptr %NativeInstruction*, %NativeInstruction** %t166, i64 0
  store %NativeInstruction* %t160, %NativeInstruction** %t167
  %t168 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* null, i32 1
  %t169 = ptrtoint { %NativeInstruction**, i64 }* %t168 to i64
  %t170 = call i8* @malloc(i64 %t169)
  %t171 = bitcast i8* %t170 to { %NativeInstruction**, i64 }*
  %t172 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t171, i32 0, i32 0
  store %NativeInstruction** %t166, %NativeInstruction*** %t172
  %t173 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t171, i32 0, i32 1
  store i64 1, i64* %t173
  %t174 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t171, 0
  %t175 = insertvalue %InstructionParseResult %t174, i1 0, 1
  %t176 = insertvalue %InstructionParseResult %t175, i1 0, 2
  ret %InstructionParseResult %t176
merge13:
  %s177 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2064480630, i32 0, i32 0
  %t178 = icmp eq i8* %line, %s177
  br i1 %t178, label %then14, label %merge15
then14:
  %t179 = insertvalue %NativeInstruction undef, i32 8, 0
  %t180 = call noalias i8* @malloc(i64 56)
  %t181 = bitcast i8* %t180 to %NativeInstruction*
  store %NativeInstruction %t179, %NativeInstruction* %t181
  %t182 = bitcast i8* %t180 to %NativeInstruction*
  %t183 = getelementptr [1 x %NativeInstruction*], [1 x %NativeInstruction*]* null, i32 1
  %t184 = ptrtoint [1 x %NativeInstruction*]* %t183 to i64
  %t185 = icmp eq i64 %t184, 0
  %t186 = select i1 %t185, i64 1, i64 %t184
  %t187 = call i8* @malloc(i64 %t186)
  %t188 = bitcast i8* %t187 to %NativeInstruction**
  %t189 = getelementptr %NativeInstruction*, %NativeInstruction** %t188, i64 0
  store %NativeInstruction* %t182, %NativeInstruction** %t189
  %t190 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* null, i32 1
  %t191 = ptrtoint { %NativeInstruction**, i64 }* %t190 to i64
  %t192 = call i8* @malloc(i64 %t191)
  %t193 = bitcast i8* %t192 to { %NativeInstruction**, i64 }*
  %t194 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t193, i32 0, i32 0
  store %NativeInstruction** %t188, %NativeInstruction*** %t194
  %t195 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t193, i32 0, i32 1
  store i64 1, i64* %t195
  %t196 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t193, 0
  %t197 = insertvalue %InstructionParseResult %t196, i1 0, 1
  %t198 = insertvalue %InstructionParseResult %t197, i1 0, 2
  ret %InstructionParseResult %t198
merge15:
  %s199 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h571206424, i32 0, i32 0
  %t200 = icmp eq i8* %line, %s199
  br i1 %t200, label %then16, label %merge17
then16:
  %t201 = insertvalue %NativeInstruction undef, i32 9, 0
  %t202 = call noalias i8* @malloc(i64 56)
  %t203 = bitcast i8* %t202 to %NativeInstruction*
  store %NativeInstruction %t201, %NativeInstruction* %t203
  %t204 = bitcast i8* %t202 to %NativeInstruction*
  %t205 = getelementptr [1 x %NativeInstruction*], [1 x %NativeInstruction*]* null, i32 1
  %t206 = ptrtoint [1 x %NativeInstruction*]* %t205 to i64
  %t207 = icmp eq i64 %t206, 0
  %t208 = select i1 %t207, i64 1, i64 %t206
  %t209 = call i8* @malloc(i64 %t208)
  %t210 = bitcast i8* %t209 to %NativeInstruction**
  %t211 = getelementptr %NativeInstruction*, %NativeInstruction** %t210, i64 0
  store %NativeInstruction* %t204, %NativeInstruction** %t211
  %t212 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* null, i32 1
  %t213 = ptrtoint { %NativeInstruction**, i64 }* %t212 to i64
  %t214 = call i8* @malloc(i64 %t213)
  %t215 = bitcast i8* %t214 to { %NativeInstruction**, i64 }*
  %t216 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t215, i32 0, i32 0
  store %NativeInstruction** %t210, %NativeInstruction*** %t216
  %t217 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t215, i32 0, i32 1
  store i64 1, i64* %t217
  %t218 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t215, 0
  %t219 = insertvalue %InstructionParseResult %t218, i1 0, 1
  %t220 = insertvalue %InstructionParseResult %t219, i1 0, 2
  ret %InstructionParseResult %t220
merge17:
  %s221 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1958778164, i32 0, i32 0
  %t222 = icmp eq i8* %line, %s221
  br i1 %t222, label %then18, label %merge19
then18:
  %t223 = insertvalue %NativeInstruction undef, i32 10, 0
  %t224 = call noalias i8* @malloc(i64 56)
  %t225 = bitcast i8* %t224 to %NativeInstruction*
  store %NativeInstruction %t223, %NativeInstruction* %t225
  %t226 = bitcast i8* %t224 to %NativeInstruction*
  %t227 = getelementptr [1 x %NativeInstruction*], [1 x %NativeInstruction*]* null, i32 1
  %t228 = ptrtoint [1 x %NativeInstruction*]* %t227 to i64
  %t229 = icmp eq i64 %t228, 0
  %t230 = select i1 %t229, i64 1, i64 %t228
  %t231 = call i8* @malloc(i64 %t230)
  %t232 = bitcast i8* %t231 to %NativeInstruction**
  %t233 = getelementptr %NativeInstruction*, %NativeInstruction** %t232, i64 0
  store %NativeInstruction* %t226, %NativeInstruction** %t233
  %t234 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* null, i32 1
  %t235 = ptrtoint { %NativeInstruction**, i64 }* %t234 to i64
  %t236 = call i8* @malloc(i64 %t235)
  %t237 = bitcast i8* %t236 to { %NativeInstruction**, i64 }*
  %t238 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t237, i32 0, i32 0
  store %NativeInstruction** %t232, %NativeInstruction*** %t238
  %t239 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t237, i32 0, i32 1
  store i64 1, i64* %t239
  %t240 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t237, 0
  %t241 = insertvalue %InstructionParseResult %t240, i1 0, 1
  %t242 = insertvalue %InstructionParseResult %t241, i1 0, 2
  ret %InstructionParseResult %t242
merge19:
  %s243 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h528348603, i32 0, i32 0
  %t244 = icmp eq i8* %line, %s243
  br i1 %t244, label %then20, label %merge21
then20:
  %t245 = insertvalue %NativeInstruction undef, i32 11, 0
  %t246 = call noalias i8* @malloc(i64 56)
  %t247 = bitcast i8* %t246 to %NativeInstruction*
  store %NativeInstruction %t245, %NativeInstruction* %t247
  %t248 = bitcast i8* %t246 to %NativeInstruction*
  %t249 = getelementptr [1 x %NativeInstruction*], [1 x %NativeInstruction*]* null, i32 1
  %t250 = ptrtoint [1 x %NativeInstruction*]* %t249 to i64
  %t251 = icmp eq i64 %t250, 0
  %t252 = select i1 %t251, i64 1, i64 %t250
  %t253 = call i8* @malloc(i64 %t252)
  %t254 = bitcast i8* %t253 to %NativeInstruction**
  %t255 = getelementptr %NativeInstruction*, %NativeInstruction** %t254, i64 0
  store %NativeInstruction* %t248, %NativeInstruction** %t255
  %t256 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* null, i32 1
  %t257 = ptrtoint { %NativeInstruction**, i64 }* %t256 to i64
  %t258 = call i8* @malloc(i64 %t257)
  %t259 = bitcast i8* %t258 to { %NativeInstruction**, i64 }*
  %t260 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t259, i32 0, i32 0
  store %NativeInstruction** %t254, %NativeInstruction*** %t260
  %t261 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t259, i32 0, i32 1
  store i64 1, i64* %t261
  %t262 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t259, 0
  %t263 = insertvalue %InstructionParseResult %t262, i1 0, 1
  %t264 = insertvalue %InstructionParseResult %t263, i1 0, 2
  ret %InstructionParseResult %t264
merge21:
  %s265 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h553171426, i32 0, i32 0
  %t266 = call i1 @starts_with(i8* %line, i8* %s265)
  br i1 %t266, label %then22, label %merge23
then22:
  %s267 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h553171426, i32 0, i32 0
  %t268 = call i8* @strip_prefix(i8* %line, i8* %s267)
  %t269 = call i8* @trim_text(i8* %t268)
  store i8* %t269, i8** %l6
  %t270 = alloca %NativeInstruction
  %t271 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t270, i32 0, i32 0
  store i32 12, i32* %t271
  %t272 = load i8*, i8** %l6
  %t273 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t270, i32 0, i32 1
  %t274 = bitcast [8 x i8]* %t273 to i8*
  %t275 = bitcast i8* %t274 to i8**
  store i8* %t272, i8** %t275
  %t276 = load %NativeInstruction, %NativeInstruction* %t270
  %t277 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t278 = ptrtoint [1 x %NativeInstruction]* %t277 to i64
  %t279 = icmp eq i64 %t278, 0
  %t280 = select i1 %t279, i64 1, i64 %t278
  %t281 = call i8* @malloc(i64 %t280)
  %t282 = bitcast i8* %t281 to %NativeInstruction*
  %t283 = getelementptr %NativeInstruction, %NativeInstruction* %t282, i64 0
  store %NativeInstruction %t276, %NativeInstruction* %t283
  %t284 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t285 = ptrtoint { %NativeInstruction*, i64 }* %t284 to i64
  %t286 = call i8* @malloc(i64 %t285)
  %t287 = bitcast i8* %t286 to { %NativeInstruction*, i64 }*
  %t288 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t287, i32 0, i32 0
  store %NativeInstruction* %t282, %NativeInstruction** %t288
  %t289 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t287, i32 0, i32 1
  store i64 1, i64* %t289
  %t290 = bitcast { %NativeInstruction*, i64 }* %t287 to { %NativeInstruction**, i64 }*
  %t291 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t290, 0
  %t292 = insertvalue %InstructionParseResult %t291, i1 0, 1
  %t293 = insertvalue %InstructionParseResult %t292, i1 0, 2
  ret %InstructionParseResult %t293
merge23:
  %s294 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1187178968, i32 0, i32 0
  %t295 = call i1 @starts_with(i8* %line, i8* %s294)
  br i1 %t295, label %then24, label %merge25
then24:
  %t296 = call %NativeInstruction @parse_case_instruction(i8* %line)
  %t297 = call noalias i8* @malloc(i64 56)
  %t298 = bitcast i8* %t297 to %NativeInstruction*
  store %NativeInstruction %t296, %NativeInstruction* %t298
  %t299 = bitcast i8* %t297 to %NativeInstruction*
  %t300 = getelementptr [1 x %NativeInstruction*], [1 x %NativeInstruction*]* null, i32 1
  %t301 = ptrtoint [1 x %NativeInstruction*]* %t300 to i64
  %t302 = icmp eq i64 %t301, 0
  %t303 = select i1 %t302, i64 1, i64 %t301
  %t304 = call i8* @malloc(i64 %t303)
  %t305 = bitcast i8* %t304 to %NativeInstruction**
  %t306 = getelementptr %NativeInstruction*, %NativeInstruction** %t305, i64 0
  store %NativeInstruction* %t299, %NativeInstruction** %t306
  %t307 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* null, i32 1
  %t308 = ptrtoint { %NativeInstruction**, i64 }* %t307 to i64
  %t309 = call i8* @malloc(i64 %t308)
  %t310 = bitcast i8* %t309 to { %NativeInstruction**, i64 }*
  %t311 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t310, i32 0, i32 0
  store %NativeInstruction** %t305, %NativeInstruction*** %t311
  %t312 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t310, i32 0, i32 1
  store i64 1, i64* %t312
  %t313 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t310, 0
  %t314 = insertvalue %InstructionParseResult %t313, i1 0, 1
  %t315 = insertvalue %InstructionParseResult %t314, i1 0, 2
  ret %InstructionParseResult %t315
merge25:
  %s316 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1692644020, i32 0, i32 0
  %t317 = icmp eq i8* %line, %s316
  br i1 %t317, label %then26, label %merge27
then26:
  %t318 = insertvalue %NativeInstruction undef, i32 14, 0
  %t319 = call noalias i8* @malloc(i64 56)
  %t320 = bitcast i8* %t319 to %NativeInstruction*
  store %NativeInstruction %t318, %NativeInstruction* %t320
  %t321 = bitcast i8* %t319 to %NativeInstruction*
  %t322 = getelementptr [1 x %NativeInstruction*], [1 x %NativeInstruction*]* null, i32 1
  %t323 = ptrtoint [1 x %NativeInstruction*]* %t322 to i64
  %t324 = icmp eq i64 %t323, 0
  %t325 = select i1 %t324, i64 1, i64 %t323
  %t326 = call i8* @malloc(i64 %t325)
  %t327 = bitcast i8* %t326 to %NativeInstruction**
  %t328 = getelementptr %NativeInstruction*, %NativeInstruction** %t327, i64 0
  store %NativeInstruction* %t321, %NativeInstruction** %t328
  %t329 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* null, i32 1
  %t330 = ptrtoint { %NativeInstruction**, i64 }* %t329 to i64
  %t331 = call i8* @malloc(i64 %t330)
  %t332 = bitcast i8* %t331 to { %NativeInstruction**, i64 }*
  %t333 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t332, i32 0, i32 0
  store %NativeInstruction** %t327, %NativeInstruction*** %t333
  %t334 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t332, i32 0, i32 1
  store i64 1, i64* %t334
  %t335 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t332, 0
  %t336 = insertvalue %InstructionParseResult %t335, i1 0, 1
  %t337 = insertvalue %InstructionParseResult %t336, i1 0, 2
  ret %InstructionParseResult %t337
merge27:
  %s338 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2064124065, i32 0, i32 0
  %t339 = call i1 @starts_with(i8* %line, i8* %s338)
  br i1 %t339, label %then28, label %merge29
then28:
  %t340 = call %NativeInstruction @parse_let_instruction(i8* %line, %NativeSourceSpan* %span, %NativeSourceSpan* %value_span)
  %t341 = call noalias i8* @malloc(i64 56)
  %t342 = bitcast i8* %t341 to %NativeInstruction*
  store %NativeInstruction %t340, %NativeInstruction* %t342
  %t343 = bitcast i8* %t341 to %NativeInstruction*
  %t344 = getelementptr [1 x %NativeInstruction*], [1 x %NativeInstruction*]* null, i32 1
  %t345 = ptrtoint [1 x %NativeInstruction*]* %t344 to i64
  %t346 = icmp eq i64 %t345, 0
  %t347 = select i1 %t346, i64 1, i64 %t345
  %t348 = call i8* @malloc(i64 %t347)
  %t349 = bitcast i8* %t348 to %NativeInstruction**
  %t350 = getelementptr %NativeInstruction*, %NativeInstruction** %t349, i64 0
  store %NativeInstruction* %t343, %NativeInstruction** %t350
  %t351 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* null, i32 1
  %t352 = ptrtoint { %NativeInstruction**, i64 }* %t351 to i64
  %t353 = call i8* @malloc(i64 %t352)
  %t354 = bitcast i8* %t353 to { %NativeInstruction**, i64 }*
  %t355 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t354, i32 0, i32 0
  store %NativeInstruction** %t349, %NativeInstruction*** %t355
  %t356 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t354, i32 0, i32 1
  store i64 1, i64* %t356
  %t357 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t354, 0
  %t358 = insertvalue %InstructionParseResult %t357, i1 1, 1
  %t359 = insertvalue %InstructionParseResult %t358, i1 1, 2
  ret %InstructionParseResult %t359
merge29:
  %s360 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h725262232, i32 0, i32 0
  %t361 = call i1 @starts_with(i8* %line, i8* %s360)
  br i1 %t361, label %then30, label %merge31
then30:
  %s362 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h725262232, i32 0, i32 0
  %t363 = call i8* @strip_prefix(i8* %line, i8* %s362)
  %t364 = call i8* @trim_text(i8* %t363)
  store i8* %t364, i8** %l7
  %s365 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s365, i8** %l8
  %t366 = load i8*, i8** %l7
  %t367 = call i64 @sailfin_runtime_string_length(i8* %t366)
  %t368 = icmp sgt i64 %t367, 0
  %t369 = load i8*, i8** %l7
  %t370 = load i8*, i8** %l8
  br i1 %t368, label %then32, label %merge33
then32:
  %t371 = load i8*, i8** %l7
  %t372 = call i8* @trim_trailing_delimiters(i8* %t371)
  store i8* %t372, i8** %l8
  %t373 = load i8*, i8** %l8
  br label %merge33
merge33:
  %t374 = phi i8* [ %t373, %then32 ], [ %t370, %then30 ]
  store i8* %t374, i8** %l8
  %t375 = alloca %NativeInstruction
  %t376 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t375, i32 0, i32 0
  store i32 0, i32* %t376
  %t377 = load i8*, i8** %l8
  %t378 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t375, i32 0, i32 1
  %t379 = bitcast [16 x i8]* %t378 to i8*
  %t380 = bitcast i8* %t379 to i8**
  store i8* %t377, i8** %t380
  %t381 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t375, i32 0, i32 1
  %t382 = bitcast [16 x i8]* %t381 to i8*
  %t383 = getelementptr inbounds i8, i8* %t382, i64 8
  %t384 = bitcast i8* %t383 to %NativeSourceSpan**
  store %NativeSourceSpan* %span, %NativeSourceSpan** %t384
  %t385 = load %NativeInstruction, %NativeInstruction* %t375
  %t386 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t387 = ptrtoint [1 x %NativeInstruction]* %t386 to i64
  %t388 = icmp eq i64 %t387, 0
  %t389 = select i1 %t388, i64 1, i64 %t387
  %t390 = call i8* @malloc(i64 %t389)
  %t391 = bitcast i8* %t390 to %NativeInstruction*
  %t392 = getelementptr %NativeInstruction, %NativeInstruction* %t391, i64 0
  store %NativeInstruction %t385, %NativeInstruction* %t392
  %t393 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t394 = ptrtoint { %NativeInstruction*, i64 }* %t393 to i64
  %t395 = call i8* @malloc(i64 %t394)
  %t396 = bitcast i8* %t395 to { %NativeInstruction*, i64 }*
  %t397 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t396, i32 0, i32 0
  store %NativeInstruction* %t391, %NativeInstruction** %t397
  %t398 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t396, i32 0, i32 1
  store i64 1, i64* %t398
  %t399 = bitcast { %NativeInstruction*, i64 }* %t396 to { %NativeInstruction**, i64 }*
  %t400 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t399, 0
  %t401 = insertvalue %InstructionParseResult %t400, i1 1, 1
  %t402 = insertvalue %InstructionParseResult %t401, i1 0, 2
  ret %InstructionParseResult %t402
merge31:
  %s403 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2090684245, i32 0, i32 0
  %t404 = call i1 @starts_with(i8* %line, i8* %s403)
  br i1 %t404, label %then34, label %merge35
then34:
  %t405 = call i64 @sailfin_runtime_string_length(i8* %line)
  %t406 = icmp eq i64 %t405, 3
  br i1 %t406, label %then36, label %merge37
then36:
  %t407 = alloca %NativeInstruction
  %t408 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t407, i32 0, i32 0
  store i32 0, i32* %t408
  %s409 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t410 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t407, i32 0, i32 1
  %t411 = bitcast [16 x i8]* %t410 to i8*
  %t412 = bitcast i8* %t411 to i8**
  store i8* %s409, i8** %t412
  %t413 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t407, i32 0, i32 1
  %t414 = bitcast [16 x i8]* %t413 to i8*
  %t415 = getelementptr inbounds i8, i8* %t414, i64 8
  %t416 = bitcast i8* %t415 to %NativeSourceSpan**
  store %NativeSourceSpan* %span, %NativeSourceSpan** %t416
  %t417 = load %NativeInstruction, %NativeInstruction* %t407
  %t418 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t419 = ptrtoint [1 x %NativeInstruction]* %t418 to i64
  %t420 = icmp eq i64 %t419, 0
  %t421 = select i1 %t420, i64 1, i64 %t419
  %t422 = call i8* @malloc(i64 %t421)
  %t423 = bitcast i8* %t422 to %NativeInstruction*
  %t424 = getelementptr %NativeInstruction, %NativeInstruction* %t423, i64 0
  store %NativeInstruction %t417, %NativeInstruction* %t424
  %t425 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t426 = ptrtoint { %NativeInstruction*, i64 }* %t425 to i64
  %t427 = call i8* @malloc(i64 %t426)
  %t428 = bitcast i8* %t427 to { %NativeInstruction*, i64 }*
  %t429 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t428, i32 0, i32 0
  store %NativeInstruction* %t423, %NativeInstruction** %t429
  %t430 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t428, i32 0, i32 1
  store i64 1, i64* %t430
  %t431 = bitcast { %NativeInstruction*, i64 }* %t428 to { %NativeInstruction**, i64 }*
  %t432 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t431, 0
  %t433 = insertvalue %InstructionParseResult %t432, i1 1, 1
  %t434 = insertvalue %InstructionParseResult %t433, i1 0, 2
  ret %InstructionParseResult %t434
merge37:
  %t435 = getelementptr i8, i8* %line, i64 3
  %t436 = load i8, i8* %t435
  store i8 %t436, i8* %l9
  %t438 = load i8, i8* %l9
  %t439 = icmp eq i8 %t438, 32
  br label %logical_or_entry_437

logical_or_entry_437:
  br i1 %t439, label %logical_or_merge_437, label %logical_or_right_437

logical_or_right_437:
  %t440 = load i8, i8* %l9
  %t441 = icmp eq i8 %t440, 9
  br label %logical_or_right_end_437

logical_or_right_end_437:
  br label %logical_or_merge_437

logical_or_merge_437:
  %t442 = phi i1 [ true, %logical_or_entry_437 ], [ %t441, %logical_or_right_end_437 ]
  %t443 = load i8, i8* %l9
  br i1 %t442, label %then38, label %merge39
then38:
  %t444 = call i64 @sailfin_runtime_string_length(i8* %line)
  %t445 = call i8* @sailfin_runtime_substring(i8* %line, i64 3, i64 %t444)
  %t446 = call i8* @trim_text(i8* %t445)
  store i8* %t446, i8** %l10
  %t447 = load i8*, i8** %l10
  %t448 = call i64 @sailfin_runtime_string_length(i8* %t447)
  %t449 = icmp eq i64 %t448, 0
  %t450 = load i8, i8* %l9
  %t451 = load i8*, i8** %l10
  br i1 %t449, label %then40, label %merge41
then40:
  %t452 = alloca %NativeInstruction
  %t453 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t452, i32 0, i32 0
  store i32 0, i32* %t453
  %s454 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t455 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t452, i32 0, i32 1
  %t456 = bitcast [16 x i8]* %t455 to i8*
  %t457 = bitcast i8* %t456 to i8**
  store i8* %s454, i8** %t457
  %t458 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t452, i32 0, i32 1
  %t459 = bitcast [16 x i8]* %t458 to i8*
  %t460 = getelementptr inbounds i8, i8* %t459, i64 8
  %t461 = bitcast i8* %t460 to %NativeSourceSpan**
  store %NativeSourceSpan* %span, %NativeSourceSpan** %t461
  %t462 = load %NativeInstruction, %NativeInstruction* %t452
  %t463 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t464 = ptrtoint [1 x %NativeInstruction]* %t463 to i64
  %t465 = icmp eq i64 %t464, 0
  %t466 = select i1 %t465, i64 1, i64 %t464
  %t467 = call i8* @malloc(i64 %t466)
  %t468 = bitcast i8* %t467 to %NativeInstruction*
  %t469 = getelementptr %NativeInstruction, %NativeInstruction* %t468, i64 0
  store %NativeInstruction %t462, %NativeInstruction* %t469
  %t470 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t471 = ptrtoint { %NativeInstruction*, i64 }* %t470 to i64
  %t472 = call i8* @malloc(i64 %t471)
  %t473 = bitcast i8* %t472 to { %NativeInstruction*, i64 }*
  %t474 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t473, i32 0, i32 0
  store %NativeInstruction* %t468, %NativeInstruction** %t474
  %t475 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t473, i32 0, i32 1
  store i64 1, i64* %t475
  %t476 = bitcast { %NativeInstruction*, i64 }* %t473 to { %NativeInstruction**, i64 }*
  %t477 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t476, 0
  %t478 = insertvalue %InstructionParseResult %t477, i1 1, 1
  %t479 = insertvalue %InstructionParseResult %t478, i1 0, 2
  ret %InstructionParseResult %t479
merge41:
  %t480 = alloca %NativeInstruction
  %t481 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t480, i32 0, i32 0
  store i32 0, i32* %t481
  %t482 = load i8*, i8** %l10
  %t483 = call i8* @trim_trailing_delimiters(i8* %t482)
  %t484 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t480, i32 0, i32 1
  %t485 = bitcast [16 x i8]* %t484 to i8*
  %t486 = bitcast i8* %t485 to i8**
  store i8* %t483, i8** %t486
  %t487 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t480, i32 0, i32 1
  %t488 = bitcast [16 x i8]* %t487 to i8*
  %t489 = getelementptr inbounds i8, i8* %t488, i64 8
  %t490 = bitcast i8* %t489 to %NativeSourceSpan**
  store %NativeSourceSpan* %span, %NativeSourceSpan** %t490
  %t491 = load %NativeInstruction, %NativeInstruction* %t480
  %t492 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t493 = ptrtoint [1 x %NativeInstruction]* %t492 to i64
  %t494 = icmp eq i64 %t493, 0
  %t495 = select i1 %t494, i64 1, i64 %t493
  %t496 = call i8* @malloc(i64 %t495)
  %t497 = bitcast i8* %t496 to %NativeInstruction*
  %t498 = getelementptr %NativeInstruction, %NativeInstruction* %t497, i64 0
  store %NativeInstruction %t491, %NativeInstruction* %t498
  %t499 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t500 = ptrtoint { %NativeInstruction*, i64 }* %t499 to i64
  %t501 = call i8* @malloc(i64 %t500)
  %t502 = bitcast i8* %t501 to { %NativeInstruction*, i64 }*
  %t503 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t502, i32 0, i32 0
  store %NativeInstruction* %t497, %NativeInstruction** %t503
  %t504 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t502, i32 0, i32 1
  store i64 1, i64* %t504
  %t505 = bitcast { %NativeInstruction*, i64 }* %t502 to { %NativeInstruction**, i64 }*
  %t506 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t505, 0
  %t507 = insertvalue %InstructionParseResult %t506, i1 1, 1
  %t508 = insertvalue %InstructionParseResult %t507, i1 0, 2
  ret %InstructionParseResult %t508
merge39:
  br label %merge35
merge35:
  %s509 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h890937508, i32 0, i32 0
  %t510 = call i1 @starts_with(i8* %line, i8* %s509)
  br i1 %t510, label %then42, label %merge43
then42:
  %s511 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h890937508, i32 0, i32 0
  %t512 = call i8* @strip_prefix(i8* %line, i8* %s511)
  %t513 = call i8* @trim_text(i8* %t512)
  store i8* %t513, i8** %l11
  store i1 0, i1* %l12
  %t514 = load i8*, i8** %l11
  %s515 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t516 = call i1 @starts_with(i8* %t514, i8* %s515)
  %t517 = load i8*, i8** %l11
  %t518 = load i1, i1* %l12
  br i1 %t516, label %then44, label %merge45
then44:
  store i1 1, i1* %l12
  %t519 = load i8*, i8** %l11
  %s520 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t521 = call i8* @strip_prefix(i8* %t519, i8* %s520)
  %t522 = call i8* @trim_text(i8* %t521)
  store i8* %t522, i8** %l11
  %t523 = load i1, i1* %l12
  %t524 = load i8*, i8** %l11
  br label %merge45
merge45:
  %t525 = phi i1 [ %t523, %then44 ], [ %t518, %then42 ]
  %t526 = phi i8* [ %t524, %then44 ], [ %t517, %then42 ]
  store i1 %t525, i1* %l12
  store i8* %t526, i8** %l11
  %t527 = load i8*, i8** %l11
  %t528 = call %BindingComponents @parse_binding_components(i8* %t527)
  store %BindingComponents %t528, %BindingComponents* %l13
  %t529 = alloca %NativeInstruction
  %t530 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t529, i32 0, i32 0
  store i32 2, i32* %t530
  %t531 = load %BindingComponents, %BindingComponents* %l13
  %t532 = extractvalue %BindingComponents %t531, 0
  %t533 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t529, i32 0, i32 1
  %t534 = bitcast [48 x i8]* %t533 to i8*
  %t535 = bitcast i8* %t534 to i8**
  store i8* %t532, i8** %t535
  %t536 = load i1, i1* %l12
  %t537 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t529, i32 0, i32 1
  %t538 = bitcast [48 x i8]* %t537 to i8*
  %t539 = getelementptr inbounds i8, i8* %t538, i64 8
  %t540 = bitcast i8* %t539 to i1*
  store i1 %t536, i1* %t540
  %t541 = load %BindingComponents, %BindingComponents* %l13
  %t542 = extractvalue %BindingComponents %t541, 1
  %t543 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t529, i32 0, i32 1
  %t544 = bitcast [48 x i8]* %t543 to i8*
  %t545 = getelementptr inbounds i8, i8* %t544, i64 16
  %t546 = bitcast i8* %t545 to i8**
  store i8* %t542, i8** %t546
  %t547 = load %BindingComponents, %BindingComponents* %l13
  %t548 = extractvalue %BindingComponents %t547, 2
  %t549 = call i8* @maybe_trim_trailing(i8* %t548)
  %t550 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t529, i32 0, i32 1
  %t551 = bitcast [48 x i8]* %t550 to i8*
  %t552 = getelementptr inbounds i8, i8* %t551, i64 24
  %t553 = bitcast i8* %t552 to i8**
  store i8* %t549, i8** %t553
  %t554 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t529, i32 0, i32 1
  %t555 = bitcast [48 x i8]* %t554 to i8*
  %t556 = getelementptr inbounds i8, i8* %t555, i64 32
  %t557 = bitcast i8* %t556 to %NativeSourceSpan**
  store %NativeSourceSpan* %span, %NativeSourceSpan** %t557
  %t558 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t529, i32 0, i32 1
  %t559 = bitcast [48 x i8]* %t558 to i8*
  %t560 = getelementptr inbounds i8, i8* %t559, i64 40
  %t561 = bitcast i8* %t560 to %NativeSourceSpan**
  store %NativeSourceSpan* %value_span, %NativeSourceSpan** %t561
  %t562 = load %NativeInstruction, %NativeInstruction* %t529
  %t563 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t564 = ptrtoint [1 x %NativeInstruction]* %t563 to i64
  %t565 = icmp eq i64 %t564, 0
  %t566 = select i1 %t565, i64 1, i64 %t564
  %t567 = call i8* @malloc(i64 %t566)
  %t568 = bitcast i8* %t567 to %NativeInstruction*
  %t569 = getelementptr %NativeInstruction, %NativeInstruction* %t568, i64 0
  store %NativeInstruction %t562, %NativeInstruction* %t569
  %t570 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t571 = ptrtoint { %NativeInstruction*, i64 }* %t570 to i64
  %t572 = call i8* @malloc(i64 %t571)
  %t573 = bitcast i8* %t572 to { %NativeInstruction*, i64 }*
  %t574 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t573, i32 0, i32 0
  store %NativeInstruction* %t568, %NativeInstruction** %t574
  %t575 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t573, i32 0, i32 1
  store i64 1, i64* %t575
  %t576 = bitcast { %NativeInstruction*, i64 }* %t573 to { %NativeInstruction**, i64 }*
  %t577 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t576, 0
  %t578 = insertvalue %InstructionParseResult %t577, i1 1, 1
  %t579 = insertvalue %InstructionParseResult %t578, i1 1, 2
  ret %InstructionParseResult %t579
merge43:
  %s580 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2080793783, i32 0, i32 0
  %t581 = call i1 @starts_with(i8* %line, i8* %s580)
  br i1 %t581, label %then46, label %merge47
then46:
  %t582 = alloca %NativeInstruction
  %t583 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t582, i32 0, i32 0
  store i32 1, i32* %t583
  %s584 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2080793783, i32 0, i32 0
  %t585 = call i8* @strip_prefix(i8* %line, i8* %s584)
  %t586 = call i8* @trim_text(i8* %t585)
  %t587 = call i8* @trim_trailing_delimiters(i8* %t586)
  %t588 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t582, i32 0, i32 1
  %t589 = bitcast [16 x i8]* %t588 to i8*
  %t590 = bitcast i8* %t589 to i8**
  store i8* %t587, i8** %t590
  %t591 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t582, i32 0, i32 1
  %t592 = bitcast [16 x i8]* %t591 to i8*
  %t593 = getelementptr inbounds i8, i8* %t592, i64 8
  %t594 = bitcast i8* %t593 to %NativeSourceSpan**
  store %NativeSourceSpan* %span, %NativeSourceSpan** %t594
  %t595 = load %NativeInstruction, %NativeInstruction* %t582
  %t596 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t597 = ptrtoint [1 x %NativeInstruction]* %t596 to i64
  %t598 = icmp eq i64 %t597, 0
  %t599 = select i1 %t598, i64 1, i64 %t597
  %t600 = call i8* @malloc(i64 %t599)
  %t601 = bitcast i8* %t600 to %NativeInstruction*
  %t602 = getelementptr %NativeInstruction, %NativeInstruction* %t601, i64 0
  store %NativeInstruction %t595, %NativeInstruction* %t602
  %t603 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t604 = ptrtoint { %NativeInstruction*, i64 }* %t603 to i64
  %t605 = call i8* @malloc(i64 %t604)
  %t606 = bitcast i8* %t605 to { %NativeInstruction*, i64 }*
  %t607 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t606, i32 0, i32 0
  store %NativeInstruction* %t601, %NativeInstruction** %t607
  %t608 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t606, i32 0, i32 1
  store i64 1, i64* %t608
  %t609 = bitcast { %NativeInstruction*, i64 }* %t606 to { %NativeInstruction**, i64 }*
  %t610 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t609, 0
  %t611 = insertvalue %InstructionParseResult %t610, i1 1, 1
  %t612 = insertvalue %InstructionParseResult %t611, i1 0, 2
  ret %InstructionParseResult %t612
merge47:
  %s613 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193445474, i32 0, i32 0
  %t614 = call double @index_of(i8* %line, i8* %s613)
  %t615 = sitofp i64 0 to double
  %t616 = fcmp oge double %t614, %t615
  br i1 %t616, label %then48, label %merge49
then48:
  %t617 = call { %NativeInstruction*, i64 }* @parse_inline_case_instruction(i8* %line)
  %t618 = bitcast { %NativeInstruction*, i64 }* %t617 to { %NativeInstruction**, i64 }*
  %t619 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t618, 0
  %t620 = insertvalue %InstructionParseResult %t619, i1 0, 1
  %t621 = insertvalue %InstructionParseResult %t620, i1 0, 2
  ret %InstructionParseResult %t621
merge49:
  %t622 = alloca %NativeInstruction
  %t623 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t622, i32 0, i32 0
  store i32 16, i32* %t623
  %t624 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t622, i32 0, i32 1
  %t625 = bitcast [8 x i8]* %t624 to i8*
  %t626 = bitcast i8* %t625 to i8**
  store i8* %line, i8** %t626
  %t627 = load %NativeInstruction, %NativeInstruction* %t622
  %t628 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t629 = ptrtoint [1 x %NativeInstruction]* %t628 to i64
  %t630 = icmp eq i64 %t629, 0
  %t631 = select i1 %t630, i64 1, i64 %t629
  %t632 = call i8* @malloc(i64 %t631)
  %t633 = bitcast i8* %t632 to %NativeInstruction*
  %t634 = getelementptr %NativeInstruction, %NativeInstruction* %t633, i64 0
  store %NativeInstruction %t627, %NativeInstruction* %t634
  %t635 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t636 = ptrtoint { %NativeInstruction*, i64 }* %t635 to i64
  %t637 = call i8* @malloc(i64 %t636)
  %t638 = bitcast i8* %t637 to { %NativeInstruction*, i64 }*
  %t639 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t638, i32 0, i32 0
  store %NativeInstruction* %t633, %NativeInstruction** %t639
  %t640 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t638, i32 0, i32 1
  store i64 1, i64* %t640
  %t641 = bitcast { %NativeInstruction*, i64 }* %t638 to { %NativeInstruction**, i64 }*
  %t642 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t641, 0
  %t643 = insertvalue %InstructionParseResult %t642, i1 0, 1
  %t644 = insertvalue %InstructionParseResult %t643, i1 0, 2
  ret %InstructionParseResult %t644
}

define %NativeInstruction @parse_case_instruction(i8* %line) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca %CaseComponents
  %s0 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1187178968, i32 0, i32 0
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
block.entry:
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
  %s3 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193445474, i32 0, i32 0
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
  %t16 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t17 = ptrtoint [1 x %NativeInstruction]* %t16 to i64
  %t18 = icmp eq i64 %t17, 0
  %t19 = select i1 %t18, i64 1, i64 %t17
  %t20 = call i8* @malloc(i64 %t19)
  %t21 = bitcast i8* %t20 to %NativeInstruction*
  %t22 = getelementptr %NativeInstruction, %NativeInstruction* %t21, i64 0
  store %NativeInstruction %t15, %NativeInstruction* %t22
  %t23 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t24 = ptrtoint { %NativeInstruction*, i64 }* %t23 to i64
  %t25 = call i8* @malloc(i64 %t24)
  %t26 = bitcast i8* %t25 to { %NativeInstruction*, i64 }*
  %t27 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t26, i32 0, i32 0
  store %NativeInstruction* %t21, %NativeInstruction** %t27
  %t28 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t26, i32 0, i32 1
  store i64 1, i64* %t28
  ret { %NativeInstruction*, i64 }* %t26
merge1:
  %t29 = load i8*, i8** %l0
  %t30 = load double, double* %l1
  %t31 = fptosi double %t30 to i64
  %t32 = call i8* @sailfin_runtime_substring(i8* %t29, i64 0, i64 %t31)
  %t33 = call i8* @trim_text(i8* %t32)
  store i8* %t33, i8** %l2
  %t34 = load i8*, i8** %l0
  %t35 = load double, double* %l1
  %t36 = sitofp i64 2 to double
  %t37 = fadd double %t35, %t36
  %t38 = load i8*, i8** %l0
  %t39 = call i64 @sailfin_runtime_string_length(i8* %t38)
  %t40 = fptosi double %t37 to i64
  %t41 = call i8* @sailfin_runtime_substring(i8* %t34, i64 %t40, i64 %t39)
  %t42 = call i8* @trim_text(i8* %t41)
  %t43 = call i8* @trim_trailing_delimiters(i8* %t42)
  store i8* %t43, i8** %l3
  %t44 = load i8*, i8** %l2
  %t45 = call %CaseComponents @split_case_components(i8* %t44)
  store %CaseComponents %t45, %CaseComponents* %l4
  %t46 = getelementptr [0 x %NativeInstruction], [0 x %NativeInstruction]* null, i32 1
  %t47 = ptrtoint [0 x %NativeInstruction]* %t46 to i64
  %t48 = icmp eq i64 %t47, 0
  %t49 = select i1 %t48, i64 1, i64 %t47
  %t50 = call i8* @malloc(i64 %t49)
  %t51 = bitcast i8* %t50 to %NativeInstruction*
  %t52 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t53 = ptrtoint { %NativeInstruction*, i64 }* %t52 to i64
  %t54 = call i8* @malloc(i64 %t53)
  %t55 = bitcast i8* %t54 to { %NativeInstruction*, i64 }*
  %t56 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t55, i32 0, i32 0
  store %NativeInstruction* %t51, %NativeInstruction** %t56
  %t57 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t55, i32 0, i32 1
  store i64 0, i64* %t57
  store { %NativeInstruction*, i64 }* %t55, { %NativeInstruction*, i64 }** %l5
  %t58 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l5
  %t59 = alloca %NativeInstruction
  %t60 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t59, i32 0, i32 0
  store i32 13, i32* %t60
  %t61 = load %CaseComponents, %CaseComponents* %l4
  %t62 = extractvalue %CaseComponents %t61, 0
  %t63 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t59, i32 0, i32 1
  %t64 = bitcast [16 x i8]* %t63 to i8*
  %t65 = bitcast i8* %t64 to i8**
  store i8* %t62, i8** %t65
  %t66 = load %CaseComponents, %CaseComponents* %l4
  %t67 = extractvalue %CaseComponents %t66, 1
  %t68 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t59, i32 0, i32 1
  %t69 = bitcast [16 x i8]* %t68 to i8*
  %t70 = getelementptr inbounds i8, i8* %t69, i64 8
  %t71 = bitcast i8* %t70 to i8**
  store i8* %t67, i8** %t71
  %t72 = load %NativeInstruction, %NativeInstruction* %t59
  %t73 = call noalias i8* @malloc(i64 56)
  %t74 = bitcast i8* %t73 to %NativeInstruction*
  store %NativeInstruction %t72, %NativeInstruction* %t74
  %t75 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t76 = ptrtoint [1 x i8*]* %t75 to i64
  %t77 = icmp eq i64 %t76, 0
  %t78 = select i1 %t77, i64 1, i64 %t76
  %t79 = call i8* @malloc(i64 %t78)
  %t80 = bitcast i8* %t79 to i8**
  %t81 = getelementptr i8*, i8** %t80, i64 0
  store i8* %t73, i8** %t81
  %t82 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t83 = ptrtoint { i8**, i64 }* %t82 to i64
  %t84 = call i8* @malloc(i64 %t83)
  %t85 = bitcast i8* %t84 to { i8**, i64 }*
  %t86 = getelementptr { i8**, i64 }, { i8**, i64 }* %t85, i32 0, i32 0
  store i8** %t80, i8*** %t86
  %t87 = getelementptr { i8**, i64 }, { i8**, i64 }* %t85, i32 0, i32 1
  store i64 1, i64* %t87
  %t88 = bitcast { %NativeInstruction*, i64 }* %t58 to { i8**, i64 }*
  %t89 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t88, { i8**, i64 }* %t85)
  %t90 = bitcast { i8**, i64 }* %t89 to { %NativeInstruction*, i64 }*
  store { %NativeInstruction*, i64 }* %t90, { %NativeInstruction*, i64 }** %l5
  %t91 = load i8*, i8** %l3
  %t92 = call i64 @sailfin_runtime_string_length(i8* %t91)
  %t93 = icmp eq i64 %t92, 0
  %t94 = load i8*, i8** %l0
  %t95 = load double, double* %l1
  %t96 = load i8*, i8** %l2
  %t97 = load i8*, i8** %l3
  %t98 = load %CaseComponents, %CaseComponents* %l4
  %t99 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l5
  br i1 %t93, label %then2, label %merge3
then2:
  %t100 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l5
  %t101 = insertvalue %NativeInstruction undef, i32 15, 0
  %t102 = call noalias i8* @malloc(i64 56)
  %t103 = bitcast i8* %t102 to %NativeInstruction*
  store %NativeInstruction %t101, %NativeInstruction* %t103
  %t104 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t105 = ptrtoint [1 x i8*]* %t104 to i64
  %t106 = icmp eq i64 %t105, 0
  %t107 = select i1 %t106, i64 1, i64 %t105
  %t108 = call i8* @malloc(i64 %t107)
  %t109 = bitcast i8* %t108 to i8**
  %t110 = getelementptr i8*, i8** %t109, i64 0
  store i8* %t102, i8** %t110
  %t111 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t112 = ptrtoint { i8**, i64 }* %t111 to i64
  %t113 = call i8* @malloc(i64 %t112)
  %t114 = bitcast i8* %t113 to { i8**, i64 }*
  %t115 = getelementptr { i8**, i64 }, { i8**, i64 }* %t114, i32 0, i32 0
  store i8** %t109, i8*** %t115
  %t116 = getelementptr { i8**, i64 }, { i8**, i64 }* %t114, i32 0, i32 1
  store i64 1, i64* %t116
  %t117 = bitcast { %NativeInstruction*, i64 }* %t100 to { i8**, i64 }*
  %t118 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t117, { i8**, i64 }* %t114)
  %t119 = bitcast { i8**, i64 }* %t118 to { %NativeInstruction*, i64 }*
  store { %NativeInstruction*, i64 }* %t119, { %NativeInstruction*, i64 }** %l5
  %t120 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l5
  ret { %NativeInstruction*, i64 }* %t120
merge3:
  %t121 = load i8*, i8** %l3
  %t122 = call %NativeInstruction @parse_inline_case_body_instruction(i8* %t121)
  store %NativeInstruction %t122, %NativeInstruction* %l6
  %t123 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l5
  %t124 = load %NativeInstruction, %NativeInstruction* %l6
  %t125 = call noalias i8* @malloc(i64 56)
  %t126 = bitcast i8* %t125 to %NativeInstruction*
  store %NativeInstruction %t124, %NativeInstruction* %t126
  %t127 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t128 = ptrtoint [1 x i8*]* %t127 to i64
  %t129 = icmp eq i64 %t128, 0
  %t130 = select i1 %t129, i64 1, i64 %t128
  %t131 = call i8* @malloc(i64 %t130)
  %t132 = bitcast i8* %t131 to i8**
  %t133 = getelementptr i8*, i8** %t132, i64 0
  store i8* %t125, i8** %t133
  %t134 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t135 = ptrtoint { i8**, i64 }* %t134 to i64
  %t136 = call i8* @malloc(i64 %t135)
  %t137 = bitcast i8* %t136 to { i8**, i64 }*
  %t138 = getelementptr { i8**, i64 }, { i8**, i64 }* %t137, i32 0, i32 0
  store i8** %t132, i8*** %t138
  %t139 = getelementptr { i8**, i64 }, { i8**, i64 }* %t137, i32 0, i32 1
  store i64 1, i64* %t139
  %t140 = bitcast { %NativeInstruction*, i64 }* %t123 to { i8**, i64 }*
  %t141 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t140, { i8**, i64 }* %t137)
  %t142 = bitcast { i8**, i64 }* %t141 to { %NativeInstruction*, i64 }*
  store { %NativeInstruction*, i64 }* %t142, { %NativeInstruction*, i64 }** %l5
  %t143 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l5
  ret { %NativeInstruction*, i64 }* %t143
}

define %NativeInstruction @parse_inline_case_body_instruction(i8* %body) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %t0 = call i8* @trim_trailing_delimiters(i8* %body)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %s2 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h655348872, i32 0, i32 0
  %t3 = call i1 @starts_with(i8* %t1, i8* %s2)
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = load i8*, i8** %l0
  %s6 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h655348872, i32 0, i32 0
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
  %s23 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2080793783, i32 0, i32 0
  %t24 = call i1 @starts_with(i8* %t22, i8* %s23)
  %t25 = load i8*, i8** %l0
  br i1 %t24, label %then2, label %merge3
then2:
  %t26 = alloca %NativeInstruction
  %t27 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t26, i32 0, i32 0
  store i32 1, i32* %t27
  %t28 = load i8*, i8** %l0
  %s29 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2080793783, i32 0, i32 0
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
block.entry:
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
  %s8 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h175987322, i32 0, i32 0
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
block.entry:
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
  %t7 = getelementptr [0 x %NativeImportSpecifier], [0 x %NativeImportSpecifier]* null, i32 1
  %t8 = ptrtoint [0 x %NativeImportSpecifier]* %t7 to i64
  %t9 = icmp eq i64 %t8, 0
  %t10 = select i1 %t9, i64 1, i64 %t8
  %t11 = call i8* @malloc(i64 %t10)
  %t12 = bitcast i8* %t11 to %NativeImportSpecifier*
  %t13 = getelementptr { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* null, i32 1
  %t14 = ptrtoint { %NativeImportSpecifier*, i64 }* %t13 to i64
  %t15 = call i8* @malloc(i64 %t14)
  %t16 = bitcast i8* %t15 to { %NativeImportSpecifier*, i64 }*
  %t17 = getelementptr { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %t16, i32 0, i32 0
  store %NativeImportSpecifier* %t12, %NativeImportSpecifier** %t17
  %t18 = getelementptr { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %t16, i32 0, i32 1
  store i64 0, i64* %t18
  store { %NativeImportSpecifier*, i64 }* %t16, { %NativeImportSpecifier*, i64 }** %l2
  %t19 = load i8*, i8** %l0
  %t20 = alloca [2 x i8], align 1
  %t21 = getelementptr [2 x i8], [2 x i8]* %t20, i32 0, i32 0
  store i8 123, i8* %t21
  %t22 = getelementptr [2 x i8], [2 x i8]* %t20, i32 0, i32 1
  store i8 0, i8* %t22
  %t23 = getelementptr [2 x i8], [2 x i8]* %t20, i32 0, i32 0
  %t24 = call double @index_of(i8* %t19, i8* %t23)
  store double %t24, double* %l3
  %t25 = load double, double* %l3
  %t26 = sitofp i64 0 to double
  %t27 = fcmp oge double %t25, %t26
  %t28 = load i8*, i8** %l0
  %t29 = load i8*, i8** %l1
  %t30 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  %t31 = load double, double* %l3
  br i1 %t27, label %then2, label %merge3
then2:
  %t32 = load i8*, i8** %l0
  %t33 = alloca [2 x i8], align 1
  %t34 = getelementptr [2 x i8], [2 x i8]* %t33, i32 0, i32 0
  store i8 125, i8* %t34
  %t35 = getelementptr [2 x i8], [2 x i8]* %t33, i32 0, i32 1
  store i8 0, i8* %t35
  %t36 = getelementptr [2 x i8], [2 x i8]* %t33, i32 0, i32 0
  %t37 = call double @last_index_of(i8* %t32, i8* %t36)
  store double %t37, double* %l4
  %t39 = load double, double* %l4
  %t40 = sitofp i64 0 to double
  %t41 = fcmp olt double %t39, %t40
  br label %logical_or_entry_38

logical_or_entry_38:
  br i1 %t41, label %logical_or_merge_38, label %logical_or_right_38

logical_or_right_38:
  %t42 = load double, double* %l4
  %t43 = load double, double* %l3
  %t44 = fcmp ole double %t42, %t43
  br label %logical_or_right_end_38

logical_or_right_end_38:
  br label %logical_or_merge_38

logical_or_merge_38:
  %t45 = phi i1 [ true, %logical_or_entry_38 ], [ %t44, %logical_or_right_end_38 ]
  %t46 = load i8*, i8** %l0
  %t47 = load i8*, i8** %l1
  %t48 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  %t49 = load double, double* %l3
  %t50 = load double, double* %l4
  br i1 %t45, label %then4, label %merge5
then4:
  %t51 = bitcast i8* null to %NativeImport*
  ret %NativeImport* %t51
merge5:
  %t52 = load i8*, i8** %l0
  %t53 = load double, double* %l3
  %t54 = fptosi double %t53 to i64
  %t55 = call i8* @sailfin_runtime_substring(i8* %t52, i64 0, i64 %t54)
  %t56 = call i8* @trim_text(i8* %t55)
  store i8* %t56, i8** %l1
  %t57 = load i8*, i8** %l0
  %t58 = load double, double* %l3
  %t59 = sitofp i64 1 to double
  %t60 = fadd double %t58, %t59
  %t61 = load double, double* %l4
  %t62 = fptosi double %t60 to i64
  %t63 = fptosi double %t61 to i64
  %t64 = call i8* @sailfin_runtime_substring(i8* %t57, i64 %t62, i64 %t63)
  store i8* %t64, i8** %l5
  %t65 = load i8*, i8** %l5
  %t66 = call { %NativeImportSpecifier*, i64 }* @parse_import_specifiers(i8* %t65)
  store { %NativeImportSpecifier*, i64 }* %t66, { %NativeImportSpecifier*, i64 }** %l2
  %t67 = load i8*, i8** %l1
  %t68 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  br label %merge3
merge3:
  %t69 = phi i8* [ %t67, %merge5 ], [ %t29, %merge1 ]
  %t70 = phi { %NativeImportSpecifier*, i64 }* [ %t68, %merge5 ], [ %t30, %merge1 ]
  store i8* %t69, i8** %l1
  store { %NativeImportSpecifier*, i64 }* %t70, { %NativeImportSpecifier*, i64 }** %l2
  %t71 = load i8*, i8** %l1
  %t72 = call i8* @trim_text(i8* %t71)
  %t73 = call i8* @strip_quotes(i8* %t72)
  store i8* %t73, i8** %l1
  %t74 = insertvalue %NativeImport undef, i8* %kind, 0
  %t75 = load i8*, i8** %l1
  %t76 = insertvalue %NativeImport %t74, i8* %t75, 1
  %t77 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  %t78 = bitcast { %NativeImportSpecifier*, i64 }* %t77 to { %NativeImportSpecifier**, i64 }*
  %t79 = insertvalue %NativeImport %t76, { %NativeImportSpecifier**, i64 }* %t78, 2
  %t80 = alloca %NativeImport
  store %NativeImport %t79, %NativeImport* %t80
  ret %NativeImport* %t80
}

define { %NativeImportSpecifier*, i64 }* @parse_import_specifiers(i8* %text) {
block.entry:
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
  %t5 = getelementptr [0 x %NativeImportSpecifier], [0 x %NativeImportSpecifier]* null, i32 1
  %t6 = ptrtoint [0 x %NativeImportSpecifier]* %t5 to i64
  %t7 = icmp eq i64 %t6, 0
  %t8 = select i1 %t7, i64 1, i64 %t6
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to %NativeImportSpecifier*
  %t11 = getelementptr { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* null, i32 1
  %t12 = ptrtoint { %NativeImportSpecifier*, i64 }* %t11 to i64
  %t13 = call i8* @malloc(i64 %t12)
  %t14 = bitcast i8* %t13 to { %NativeImportSpecifier*, i64 }*
  %t15 = getelementptr { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %t14, i32 0, i32 0
  store %NativeImportSpecifier* %t10, %NativeImportSpecifier** %t15
  %t16 = getelementptr { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %t14, i32 0, i32 1
  store i64 0, i64* %t16
  ret { %NativeImportSpecifier*, i64 }* %t14
merge1:
  %t17 = load i8*, i8** %l0
  %t18 = call { i8**, i64 }* @split_comma_separated(i8* %t17)
  store { i8**, i64 }* %t18, { i8**, i64 }** %l1
  %t19 = getelementptr [0 x %NativeImportSpecifier], [0 x %NativeImportSpecifier]* null, i32 1
  %t20 = ptrtoint [0 x %NativeImportSpecifier]* %t19 to i64
  %t21 = icmp eq i64 %t20, 0
  %t22 = select i1 %t21, i64 1, i64 %t20
  %t23 = call i8* @malloc(i64 %t22)
  %t24 = bitcast i8* %t23 to %NativeImportSpecifier*
  %t25 = getelementptr { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* null, i32 1
  %t26 = ptrtoint { %NativeImportSpecifier*, i64 }* %t25 to i64
  %t27 = call i8* @malloc(i64 %t26)
  %t28 = bitcast i8* %t27 to { %NativeImportSpecifier*, i64 }*
  %t29 = getelementptr { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %t28, i32 0, i32 0
  store %NativeImportSpecifier* %t24, %NativeImportSpecifier** %t29
  %t30 = getelementptr { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %t28, i32 0, i32 1
  store i64 0, i64* %t30
  store { %NativeImportSpecifier*, i64 }* %t28, { %NativeImportSpecifier*, i64 }** %l2
  %t31 = sitofp i64 0 to double
  store double %t31, double* %l3
  %t32 = load i8*, i8** %l0
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t34 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  %t35 = load double, double* %l3
  br label %loop.header2
loop.header2:
  %t92 = phi { %NativeImportSpecifier*, i64 }* [ %t34, %merge1 ], [ %t90, %loop.latch4 ]
  %t93 = phi double [ %t35, %merge1 ], [ %t91, %loop.latch4 ]
  store { %NativeImportSpecifier*, i64 }* %t92, { %NativeImportSpecifier*, i64 }** %l2
  store double %t93, double* %l3
  br label %loop.body3
loop.body3:
  %t36 = load double, double* %l3
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t38 = load { i8**, i64 }, { i8**, i64 }* %t37
  %t39 = extractvalue { i8**, i64 } %t38, 1
  %t40 = sitofp i64 %t39 to double
  %t41 = fcmp oge double %t36, %t40
  %t42 = load i8*, i8** %l0
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t44 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  %t45 = load double, double* %l3
  br i1 %t41, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t47 = load double, double* %l3
  %t48 = fptosi double %t47 to i64
  %t49 = load { i8**, i64 }, { i8**, i64 }* %t46
  %t50 = extractvalue { i8**, i64 } %t49, 0
  %t51 = extractvalue { i8**, i64 } %t49, 1
  %t52 = icmp uge i64 %t48, %t51
  ; bounds check: %t52 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t48, i64 %t51)
  %t53 = getelementptr i8*, i8** %t50, i64 %t48
  %t54 = load i8*, i8** %t53
  %t55 = call %NativeImportSpecifier @parse_single_specifier(i8* %t54)
  store %NativeImportSpecifier %t55, %NativeImportSpecifier* %l4
  %t56 = load %NativeImportSpecifier, %NativeImportSpecifier* %l4
  %t57 = extractvalue %NativeImportSpecifier %t56, 0
  %t58 = call i64 @sailfin_runtime_string_length(i8* %t57)
  %t59 = icmp sgt i64 %t58, 0
  %t60 = load i8*, i8** %l0
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t62 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  %t63 = load double, double* %l3
  %t64 = load %NativeImportSpecifier, %NativeImportSpecifier* %l4
  br i1 %t59, label %then8, label %merge9
then8:
  %t65 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  %t66 = load %NativeImportSpecifier, %NativeImportSpecifier* %l4
  %t67 = call noalias i8* @malloc(i64 16)
  %t68 = bitcast i8* %t67 to %NativeImportSpecifier*
  store %NativeImportSpecifier %t66, %NativeImportSpecifier* %t68
  %t69 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t70 = ptrtoint [1 x i8*]* %t69 to i64
  %t71 = icmp eq i64 %t70, 0
  %t72 = select i1 %t71, i64 1, i64 %t70
  %t73 = call i8* @malloc(i64 %t72)
  %t74 = bitcast i8* %t73 to i8**
  %t75 = getelementptr i8*, i8** %t74, i64 0
  store i8* %t67, i8** %t75
  %t76 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t77 = ptrtoint { i8**, i64 }* %t76 to i64
  %t78 = call i8* @malloc(i64 %t77)
  %t79 = bitcast i8* %t78 to { i8**, i64 }*
  %t80 = getelementptr { i8**, i64 }, { i8**, i64 }* %t79, i32 0, i32 0
  store i8** %t74, i8*** %t80
  %t81 = getelementptr { i8**, i64 }, { i8**, i64 }* %t79, i32 0, i32 1
  store i64 1, i64* %t81
  %t82 = bitcast { %NativeImportSpecifier*, i64 }* %t65 to { i8**, i64 }*
  %t83 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t82, { i8**, i64 }* %t79)
  %t84 = bitcast { i8**, i64 }* %t83 to { %NativeImportSpecifier*, i64 }*
  store { %NativeImportSpecifier*, i64 }* %t84, { %NativeImportSpecifier*, i64 }** %l2
  %t85 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  br label %merge9
merge9:
  %t86 = phi { %NativeImportSpecifier*, i64 }* [ %t85, %then8 ], [ %t62, %merge7 ]
  store { %NativeImportSpecifier*, i64 }* %t86, { %NativeImportSpecifier*, i64 }** %l2
  %t87 = load double, double* %l3
  %t88 = sitofp i64 1 to double
  %t89 = fadd double %t87, %t88
  store double %t89, double* %l3
  br label %loop.latch4
loop.latch4:
  %t90 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  %t91 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t94 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  %t95 = load double, double* %l3
  %t96 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  ret { %NativeImportSpecifier*, i64 }* %t96
}

define %NativeImportSpecifier @parse_single_specifier(i8* %entry) {
block.entry:
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
  %s5 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t6 = insertvalue %NativeImportSpecifier undef, i8* %s5, 0
  %t7 = insertvalue %NativeImportSpecifier %t6, i8* null, 1
  ret %NativeImportSpecifier %t7
merge1:
  %s8 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h175713983, i32 0, i32 0
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
block.entry:
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
  %t0 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t1 = ptrtoint [0 x i8*]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to i8**
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t7 = ptrtoint { i8**, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { i8**, i64 }*
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 0
  store i8** %t5, i8*** %t10
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { i8**, i64 }* %t9, { i8**, i64 }** %l0
  %t12 = fptosi double %start_index to i64
  %t13 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t14 = extractvalue { i8**, i64 } %t13, 0
  %t15 = extractvalue { i8**, i64 } %t13, 1
  %t16 = icmp uge i64 %t12, %t15
  ; bounds check: %t16 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t12, i64 %t15)
  %t17 = getelementptr i8*, i8** %t14, i64 %t12
  %t18 = load i8*, i8** %t17
  %t19 = call i8* @trim_text(i8* %t18)
  store i8* %t19, i8** %l1
  %t20 = load i8*, i8** %l1
  %s21 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h2093451461, i32 0, i32 0
  %t22 = call i8* @strip_prefix(i8* %t20, i8* %s21)
  %t23 = call i8* @trim_text(i8* %t22)
  store i8* %t23, i8** %l2
  %t24 = load i8*, i8** %l2
  %t25 = call %StructHeaderParse @parse_struct_header(i8* %t24)
  store %StructHeaderParse %t25, %StructHeaderParse* %l3
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t27 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t28 = extractvalue %StructHeaderParse %t27, 2
  %t29 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t26, { i8**, i64 }* %t28)
  store { i8**, i64 }* %t29, { i8**, i64 }** %l0
  %t30 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t31 = extractvalue %StructHeaderParse %t30, 0
  store i8* %t31, i8** %l4
  %t32 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t33 = extractvalue %StructHeaderParse %t32, 1
  store { i8**, i64 }* %t33, { i8**, i64 }** %l5
  %t34 = load i8*, i8** %l4
  %t35 = call i64 @sailfin_runtime_string_length(i8* %t34)
  %t36 = icmp eq i64 %t35, 0
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t38 = load i8*, i8** %l1
  %t39 = load i8*, i8** %l2
  %t40 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t41 = load i8*, i8** %l4
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l5
  br i1 %t36, label %then0, label %merge1
then0:
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s44 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.len31.h1478667446, i32 0, i32 0
  %t45 = load i8*, i8** %l1
  %t46 = call i8* @sailfin_runtime_string_concat(i8* %s44, i8* %t45)
  %t47 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t43, i8* %t46)
  store { i8**, i64 }* %t47, { i8**, i64 }** %l0
  %t48 = bitcast i8* null to %NativeStruct*
  %t49 = insertvalue %StructParseResult undef, %NativeStruct* %t48, 0
  %t50 = sitofp i64 1 to double
  %t51 = fadd double %start_index, %t50
  %t52 = insertvalue %StructParseResult %t49, double %t51, 1
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t54 = insertvalue %StructParseResult %t52, { i8**, i64 }* %t53, 2
  ret %StructParseResult %t54
merge1:
  %t55 = getelementptr [0 x %NativeStructField], [0 x %NativeStructField]* null, i32 1
  %t56 = ptrtoint [0 x %NativeStructField]* %t55 to i64
  %t57 = icmp eq i64 %t56, 0
  %t58 = select i1 %t57, i64 1, i64 %t56
  %t59 = call i8* @malloc(i64 %t58)
  %t60 = bitcast i8* %t59 to %NativeStructField*
  %t61 = getelementptr { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* null, i32 1
  %t62 = ptrtoint { %NativeStructField*, i64 }* %t61 to i64
  %t63 = call i8* @malloc(i64 %t62)
  %t64 = bitcast i8* %t63 to { %NativeStructField*, i64 }*
  %t65 = getelementptr { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %t64, i32 0, i32 0
  store %NativeStructField* %t60, %NativeStructField** %t65
  %t66 = getelementptr { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %t64, i32 0, i32 1
  store i64 0, i64* %t66
  store { %NativeStructField*, i64 }* %t64, { %NativeStructField*, i64 }** %l6
  %t67 = getelementptr [0 x %NativeFunction], [0 x %NativeFunction]* null, i32 1
  %t68 = ptrtoint [0 x %NativeFunction]* %t67 to i64
  %t69 = icmp eq i64 %t68, 0
  %t70 = select i1 %t69, i64 1, i64 %t68
  %t71 = call i8* @malloc(i64 %t70)
  %t72 = bitcast i8* %t71 to %NativeFunction*
  %t73 = getelementptr { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* null, i32 1
  %t74 = ptrtoint { %NativeFunction*, i64 }* %t73 to i64
  %t75 = call i8* @malloc(i64 %t74)
  %t76 = bitcast i8* %t75 to { %NativeFunction*, i64 }*
  %t77 = getelementptr { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %t76, i32 0, i32 0
  store %NativeFunction* %t72, %NativeFunction** %t77
  %t78 = getelementptr { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %t76, i32 0, i32 1
  store i64 0, i64* %t78
  store { %NativeFunction*, i64 }* %t76, { %NativeFunction*, i64 }** %l7
  %t79 = bitcast i8* null to %NativeFunction*
  store %NativeFunction* %t79, %NativeFunction** %l8
  %t80 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t80, %NativeSourceSpan** %l9
  %t81 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t81, %NativeSourceSpan** %l10
  %t82 = getelementptr [0 x %NativeStructLayoutField], [0 x %NativeStructLayoutField]* null, i32 1
  %t83 = ptrtoint [0 x %NativeStructLayoutField]* %t82 to i64
  %t84 = icmp eq i64 %t83, 0
  %t85 = select i1 %t84, i64 1, i64 %t83
  %t86 = call i8* @malloc(i64 %t85)
  %t87 = bitcast i8* %t86 to %NativeStructLayoutField*
  %t88 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* null, i32 1
  %t89 = ptrtoint { %NativeStructLayoutField*, i64 }* %t88 to i64
  %t90 = call i8* @malloc(i64 %t89)
  %t91 = bitcast i8* %t90 to { %NativeStructLayoutField*, i64 }*
  %t92 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t91, i32 0, i32 0
  store %NativeStructLayoutField* %t87, %NativeStructLayoutField** %t92
  %t93 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t91, i32 0, i32 1
  store i64 0, i64* %t93
  store { %NativeStructLayoutField*, i64 }* %t91, { %NativeStructLayoutField*, i64 }** %l11
  %t94 = sitofp i64 0 to double
  store double %t94, double* %l12
  %t95 = sitofp i64 0 to double
  store double %t95, double* %l13
  store i1 0, i1* %l14
  store i1 0, i1* %l15
  %t96 = sitofp i64 1 to double
  %t97 = fadd double %start_index, %t96
  store double %t97, double* %l16
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t99 = load i8*, i8** %l1
  %t100 = load i8*, i8** %l2
  %t101 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t102 = load i8*, i8** %l4
  %t103 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t104 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t105 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t106 = load %NativeFunction*, %NativeFunction** %l8
  %t107 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t108 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t109 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t110 = load double, double* %l12
  %t111 = load double, double* %l13
  %t112 = load i1, i1* %l14
  %t113 = load i1, i1* %l15
  %t114 = load double, double* %l16
  br label %loop.header2
loop.header2:
  %t1252 = phi { i8**, i64 }* [ %t98, %merge1 ], [ %t1240, %loop.latch4 ]
  %t1253 = phi double [ %t114, %merge1 ], [ %t1241, %loop.latch4 ]
  %t1254 = phi { %NativeFunction*, i64 }* [ %t105, %merge1 ], [ %t1242, %loop.latch4 ]
  %t1255 = phi %NativeFunction* [ %t106, %merge1 ], [ %t1243, %loop.latch4 ]
  %t1256 = phi %NativeSourceSpan* [ %t107, %merge1 ], [ %t1244, %loop.latch4 ]
  %t1257 = phi %NativeSourceSpan* [ %t108, %merge1 ], [ %t1245, %loop.latch4 ]
  %t1258 = phi double [ %t110, %merge1 ], [ %t1246, %loop.latch4 ]
  %t1259 = phi double [ %t111, %merge1 ], [ %t1247, %loop.latch4 ]
  %t1260 = phi i1 [ %t112, %merge1 ], [ %t1248, %loop.latch4 ]
  %t1261 = phi { %NativeStructLayoutField*, i64 }* [ %t109, %merge1 ], [ %t1249, %loop.latch4 ]
  %t1262 = phi i1 [ %t113, %merge1 ], [ %t1250, %loop.latch4 ]
  %t1263 = phi { %NativeStructField*, i64 }* [ %t104, %merge1 ], [ %t1251, %loop.latch4 ]
  store { i8**, i64 }* %t1252, { i8**, i64 }** %l0
  store double %t1253, double* %l16
  store { %NativeFunction*, i64 }* %t1254, { %NativeFunction*, i64 }** %l7
  store %NativeFunction* %t1255, %NativeFunction** %l8
  store %NativeSourceSpan* %t1256, %NativeSourceSpan** %l9
  store %NativeSourceSpan* %t1257, %NativeSourceSpan** %l10
  store double %t1258, double* %l12
  store double %t1259, double* %l13
  store i1 %t1260, i1* %l14
  store { %NativeStructLayoutField*, i64 }* %t1261, { %NativeStructLayoutField*, i64 }** %l11
  store i1 %t1262, i1* %l15
  store { %NativeStructField*, i64 }* %t1263, { %NativeStructField*, i64 }** %l6
  br label %loop.body3
loop.body3:
  %t115 = load double, double* %l16
  %t116 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t117 = extractvalue { i8**, i64 } %t116, 1
  %t118 = sitofp i64 %t117 to double
  %t119 = fcmp oge double %t115, %t118
  %t120 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t121 = load i8*, i8** %l1
  %t122 = load i8*, i8** %l2
  %t123 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t124 = load i8*, i8** %l4
  %t125 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t126 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t127 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t128 = load %NativeFunction*, %NativeFunction** %l8
  %t129 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t130 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t131 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t132 = load double, double* %l12
  %t133 = load double, double* %l13
  %t134 = load i1, i1* %l14
  %t135 = load i1, i1* %l15
  %t136 = load double, double* %l16
  br i1 %t119, label %then6, label %merge7
then6:
  %t137 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s138 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h1216366549, i32 0, i32 0
  %t139 = load i8*, i8** %l4
  %t140 = call i8* @sailfin_runtime_string_concat(i8* %s138, i8* %t139)
  %t141 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t137, i8* %t140)
  store { i8**, i64 }* %t141, { i8**, i64 }** %l0
  %t142 = bitcast i8* null to %NativeStructLayout*
  store %NativeStructLayout* %t142, %NativeStructLayout** %l17
  %t143 = load i1, i1* %l14
  %t144 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t145 = load i8*, i8** %l1
  %t146 = load i8*, i8** %l2
  %t147 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t148 = load i8*, i8** %l4
  %t149 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t150 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t151 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t152 = load %NativeFunction*, %NativeFunction** %l8
  %t153 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t154 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t155 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t156 = load double, double* %l12
  %t157 = load double, double* %l13
  %t158 = load i1, i1* %l14
  %t159 = load i1, i1* %l15
  %t160 = load double, double* %l16
  %t161 = load %NativeStructLayout*, %NativeStructLayout** %l17
  br i1 %t143, label %then8, label %merge9
then8:
  %t162 = load double, double* %l12
  %t163 = insertvalue %NativeStructLayout undef, double %t162, 0
  %t164 = load double, double* %l13
  %t165 = insertvalue %NativeStructLayout %t163, double %t164, 1
  %t166 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t167 = bitcast { %NativeStructLayoutField*, i64 }* %t166 to { %NativeStructLayoutField**, i64 }*
  %t168 = insertvalue %NativeStructLayout %t165, { %NativeStructLayoutField**, i64 }* %t167, 2
  %t169 = alloca %NativeStructLayout
  store %NativeStructLayout %t168, %NativeStructLayout* %t169
  store %NativeStructLayout* %t169, %NativeStructLayout** %l17
  %t170 = load %NativeStructLayout*, %NativeStructLayout** %l17
  br label %merge9
merge9:
  %t171 = phi %NativeStructLayout* [ %t170, %then8 ], [ %t161, %then6 ]
  store %NativeStructLayout* %t171, %NativeStructLayout** %l17
  %t172 = load i8*, i8** %l4
  %t173 = insertvalue %NativeStruct undef, i8* %t172, 0
  %t174 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t175 = bitcast { %NativeStructField*, i64 }* %t174 to { %NativeStructField**, i64 }*
  %t176 = insertvalue %NativeStruct %t173, { %NativeStructField**, i64 }* %t175, 1
  %t177 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t178 = bitcast { %NativeFunction*, i64 }* %t177 to { %NativeFunction**, i64 }*
  %t179 = insertvalue %NativeStruct %t176, { %NativeFunction**, i64 }* %t178, 2
  %t180 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t181 = insertvalue %NativeStruct %t179, { i8**, i64 }* %t180, 3
  %t182 = load %NativeStructLayout*, %NativeStructLayout** %l17
  %t183 = insertvalue %NativeStruct %t181, %NativeStructLayout* %t182, 4
  %t184 = alloca %NativeStruct
  store %NativeStruct %t183, %NativeStruct* %t184
  %t185 = insertvalue %StructParseResult undef, %NativeStruct* %t184, 0
  %t186 = load double, double* %l16
  %t187 = insertvalue %StructParseResult %t185, double %t186, 1
  %t188 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t189 = insertvalue %StructParseResult %t187, { i8**, i64 }* %t188, 2
  ret %StructParseResult %t189
merge7:
  %t190 = load double, double* %l16
  %t191 = fptosi double %t190 to i64
  %t192 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t193 = extractvalue { i8**, i64 } %t192, 0
  %t194 = extractvalue { i8**, i64 } %t192, 1
  %t195 = icmp uge i64 %t191, %t194
  ; bounds check: %t195 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t191, i64 %t194)
  %t196 = getelementptr i8*, i8** %t193, i64 %t191
  %t197 = load i8*, i8** %t196
  %t198 = call i8* @trim_text(i8* %t197)
  store i8* %t198, i8** %l18
  %t200 = load i8*, i8** %l18
  %t201 = call i64 @sailfin_runtime_string_length(i8* %t200)
  %t202 = icmp eq i64 %t201, 0
  br label %logical_or_entry_199

logical_or_entry_199:
  br i1 %t202, label %logical_or_merge_199, label %logical_or_right_199

logical_or_right_199:
  %t203 = load i8*, i8** %l18
  %t204 = alloca [2 x i8], align 1
  %t205 = getelementptr [2 x i8], [2 x i8]* %t204, i32 0, i32 0
  store i8 59, i8* %t205
  %t206 = getelementptr [2 x i8], [2 x i8]* %t204, i32 0, i32 1
  store i8 0, i8* %t206
  %t207 = getelementptr [2 x i8], [2 x i8]* %t204, i32 0, i32 0
  %t208 = call i1 @starts_with(i8* %t203, i8* %t207)
  br label %logical_or_right_end_199

logical_or_right_end_199:
  br label %logical_or_merge_199

logical_or_merge_199:
  %t209 = phi i1 [ true, %logical_or_entry_199 ], [ %t208, %logical_or_right_end_199 ]
  %t210 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t211 = load i8*, i8** %l1
  %t212 = load i8*, i8** %l2
  %t213 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t214 = load i8*, i8** %l4
  %t215 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t216 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t217 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t218 = load %NativeFunction*, %NativeFunction** %l8
  %t219 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t220 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t221 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t222 = load double, double* %l12
  %t223 = load double, double* %l13
  %t224 = load i1, i1* %l14
  %t225 = load i1, i1* %l15
  %t226 = load double, double* %l16
  %t227 = load i8*, i8** %l18
  br i1 %t209, label %then10, label %merge11
then10:
  %t228 = load double, double* %l16
  %t229 = sitofp i64 1 to double
  %t230 = fadd double %t228, %t229
  store double %t230, double* %l16
  br label %loop.latch4
merge11:
  %t231 = load i8*, i8** %l18
  %s232 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h2070880298, i32 0, i32 0
  %t233 = icmp eq i8* %t231, %s232
  %t234 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t235 = load i8*, i8** %l1
  %t236 = load i8*, i8** %l2
  %t237 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t238 = load i8*, i8** %l4
  %t239 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t240 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t241 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t242 = load %NativeFunction*, %NativeFunction** %l8
  %t243 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t244 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t245 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t246 = load double, double* %l12
  %t247 = load double, double* %l13
  %t248 = load i1, i1* %l14
  %t249 = load i1, i1* %l15
  %t250 = load double, double* %l16
  %t251 = load i8*, i8** %l18
  br i1 %t233, label %then12, label %merge13
then12:
  %t252 = load %NativeFunction*, %NativeFunction** %l8
  %t253 = icmp ne %NativeFunction* %t252, null
  %t254 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t255 = load i8*, i8** %l1
  %t256 = load i8*, i8** %l2
  %t257 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t258 = load i8*, i8** %l4
  %t259 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t260 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t261 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t262 = load %NativeFunction*, %NativeFunction** %l8
  %t263 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t264 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t265 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t266 = load double, double* %l12
  %t267 = load double, double* %l13
  %t268 = load i1, i1* %l14
  %t269 = load i1, i1* %l15
  %t270 = load double, double* %l16
  %t271 = load i8*, i8** %l18
  br i1 %t253, label %then14, label %merge15
then14:
  %t272 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s273 = getelementptr inbounds [31 x i8], [31 x i8]* @.str.len30.h208276320, i32 0, i32 0
  %t274 = load i8*, i8** %l4
  %t275 = call i8* @sailfin_runtime_string_concat(i8* %s273, i8* %t274)
  %t276 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t272, i8* %t275)
  store { i8**, i64 }* %t276, { i8**, i64 }** %l0
  %t277 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t278 = load %NativeFunction*, %NativeFunction** %l8
  %t279 = load %NativeFunction, %NativeFunction* %t278
  %t280 = call { %NativeFunction*, i64 }* @append_function({ %NativeFunction*, i64 }* %t277, %NativeFunction %t279)
  store { %NativeFunction*, i64 }* %t280, { %NativeFunction*, i64 }** %l7
  %t281 = bitcast i8* null to %NativeFunction*
  store %NativeFunction* %t281, %NativeFunction** %l8
  %t282 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t282, %NativeSourceSpan** %l9
  %t283 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t283, %NativeSourceSpan** %l10
  %t284 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t285 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t286 = load %NativeFunction*, %NativeFunction** %l8
  %t287 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t288 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge15
merge15:
  %t289 = phi { i8**, i64 }* [ %t284, %then14 ], [ %t254, %then12 ]
  %t290 = phi { %NativeFunction*, i64 }* [ %t285, %then14 ], [ %t261, %then12 ]
  %t291 = phi %NativeFunction* [ %t286, %then14 ], [ %t262, %then12 ]
  %t292 = phi %NativeSourceSpan* [ %t287, %then14 ], [ %t263, %then12 ]
  %t293 = phi %NativeSourceSpan* [ %t288, %then14 ], [ %t264, %then12 ]
  store { i8**, i64 }* %t289, { i8**, i64 }** %l0
  store { %NativeFunction*, i64 }* %t290, { %NativeFunction*, i64 }** %l7
  store %NativeFunction* %t291, %NativeFunction** %l8
  store %NativeSourceSpan* %t292, %NativeSourceSpan** %l9
  store %NativeSourceSpan* %t293, %NativeSourceSpan** %l10
  %t294 = load double, double* %l16
  %t295 = sitofp i64 1 to double
  %t296 = fadd double %t294, %t295
  store double %t296, double* %l16
  br label %afterloop5
merge13:
  %t297 = load %NativeFunction*, %NativeFunction** %l8
  %t298 = icmp ne %NativeFunction* %t297, null
  %t299 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t300 = load i8*, i8** %l1
  %t301 = load i8*, i8** %l2
  %t302 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t303 = load i8*, i8** %l4
  %t304 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t305 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t306 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t307 = load %NativeFunction*, %NativeFunction** %l8
  %t308 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t309 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t310 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t311 = load double, double* %l12
  %t312 = load double, double* %l13
  %t313 = load i1, i1* %l14
  %t314 = load i1, i1* %l15
  %t315 = load double, double* %l16
  %t316 = load i8*, i8** %l18
  br i1 %t298, label %then16, label %merge17
then16:
  %t317 = load i8*, i8** %l18
  %s318 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h179409731, i32 0, i32 0
  %t319 = icmp eq i8* %t317, %s318
  %t320 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t321 = load i8*, i8** %l1
  %t322 = load i8*, i8** %l2
  %t323 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t324 = load i8*, i8** %l4
  %t325 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t326 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t327 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t328 = load %NativeFunction*, %NativeFunction** %l8
  %t329 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t330 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t331 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t332 = load double, double* %l12
  %t333 = load double, double* %l13
  %t334 = load i1, i1* %l14
  %t335 = load i1, i1* %l15
  %t336 = load double, double* %l16
  %t337 = load i8*, i8** %l18
  br i1 %t319, label %then18, label %merge19
then18:
  %t338 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t339 = load %NativeFunction*, %NativeFunction** %l8
  %t340 = load %NativeFunction, %NativeFunction* %t339
  %t341 = call { %NativeFunction*, i64 }* @append_function({ %NativeFunction*, i64 }* %t338, %NativeFunction %t340)
  store { %NativeFunction*, i64 }* %t341, { %NativeFunction*, i64 }** %l7
  %t342 = bitcast i8* null to %NativeFunction*
  store %NativeFunction* %t342, %NativeFunction** %l8
  %t343 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t343, %NativeSourceSpan** %l9
  %t344 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t344, %NativeSourceSpan** %l10
  %t345 = load double, double* %l16
  %t346 = sitofp i64 1 to double
  %t347 = fadd double %t345, %t346
  store double %t347, double* %l16
  br label %loop.latch4
merge19:
  %t348 = load i8*, i8** %l18
  %s349 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1583308163, i32 0, i32 0
  %t350 = call i1 @starts_with(i8* %t348, i8* %s349)
  %t351 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t352 = load i8*, i8** %l1
  %t353 = load i8*, i8** %l2
  %t354 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t355 = load i8*, i8** %l4
  %t356 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t357 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t358 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t359 = load %NativeFunction*, %NativeFunction** %l8
  %t360 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t361 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t362 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t363 = load double, double* %l12
  %t364 = load double, double* %l13
  %t365 = load i1, i1* %l14
  %t366 = load i1, i1* %l15
  %t367 = load double, double* %l16
  %t368 = load i8*, i8** %l18
  br i1 %t350, label %then20, label %merge21
then20:
  %t369 = load %NativeFunction*, %NativeFunction** %l8
  %t370 = load i8*, i8** %l18
  %s371 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1583308163, i32 0, i32 0
  %t372 = call i8* @strip_prefix(i8* %t370, i8* %s371)
  %t373 = load %NativeFunction, %NativeFunction* %t369
  %t374 = call %NativeFunction @apply_meta(%NativeFunction %t373, i8* %t372)
  %t375 = alloca %NativeFunction
  store %NativeFunction %t374, %NativeFunction* %t375
  store %NativeFunction* %t375, %NativeFunction** %l8
  %t376 = load double, double* %l16
  %t377 = sitofp i64 1 to double
  %t378 = fadd double %t376, %t377
  store double %t378, double* %l16
  br label %loop.latch4
merge21:
  %t379 = load i8*, i8** %l18
  %s380 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h130169768, i32 0, i32 0
  %t381 = call i1 @starts_with(i8* %t379, i8* %s380)
  %t382 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t383 = load i8*, i8** %l1
  %t384 = load i8*, i8** %l2
  %t385 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t386 = load i8*, i8** %l4
  %t387 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t388 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t389 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t390 = load %NativeFunction*, %NativeFunction** %l8
  %t391 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t392 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t393 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t394 = load double, double* %l12
  %t395 = load double, double* %l13
  %t396 = load i1, i1* %l14
  %t397 = load i1, i1* %l15
  %t398 = load double, double* %l16
  %t399 = load i8*, i8** %l18
  br i1 %t381, label %then22, label %merge23
then22:
  %t400 = load i8*, i8** %l18
  %s401 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h130169768, i32 0, i32 0
  %t402 = call i8* @strip_prefix(i8* %t400, i8* %s401)
  %t403 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t404 = call %NativeParameter* @parse_parameter_entry(i8* %t402, %NativeSourceSpan* %t403)
  store %NativeParameter* %t404, %NativeParameter** %l19
  %t405 = load %NativeParameter*, %NativeParameter** %l19
  %t406 = icmp eq %NativeParameter* %t405, null
  %t407 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t408 = load i8*, i8** %l1
  %t409 = load i8*, i8** %l2
  %t410 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t411 = load i8*, i8** %l4
  %t412 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t413 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t414 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t415 = load %NativeFunction*, %NativeFunction** %l8
  %t416 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t417 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t418 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t419 = load double, double* %l12
  %t420 = load double, double* %l13
  %t421 = load i1, i1* %l14
  %t422 = load i1, i1* %l15
  %t423 = load double, double* %l16
  %t424 = load i8*, i8** %l18
  %t425 = load %NativeParameter*, %NativeParameter** %l19
  br i1 %t406, label %then24, label %else25
then24:
  %t426 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s427 = getelementptr inbounds [35 x i8], [35 x i8]* @.str.len34.h1211676914, i32 0, i32 0
  %t428 = load i8*, i8** %l18
  %t429 = call i8* @sailfin_runtime_string_concat(i8* %s427, i8* %t428)
  %t430 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t426, i8* %t429)
  store { i8**, i64 }* %t430, { i8**, i64 }** %l0
  %t431 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge26
else25:
  %t432 = load %NativeFunction*, %NativeFunction** %l8
  %t433 = load %NativeParameter*, %NativeParameter** %l19
  %t434 = load %NativeFunction, %NativeFunction* %t432
  %t435 = load %NativeParameter, %NativeParameter* %t433
  %t436 = call %NativeFunction @append_parameter(%NativeFunction %t434, %NativeParameter %t435)
  %t437 = alloca %NativeFunction
  store %NativeFunction %t436, %NativeFunction* %t437
  store %NativeFunction* %t437, %NativeFunction** %l8
  %t438 = load %NativeFunction*, %NativeFunction** %l8
  br label %merge26
merge26:
  %t439 = phi { i8**, i64 }* [ %t431, %then24 ], [ %t407, %else25 ]
  %t440 = phi %NativeFunction* [ %t415, %then24 ], [ %t438, %else25 ]
  store { i8**, i64 }* %t439, { i8**, i64 }** %l0
  store %NativeFunction* %t440, %NativeFunction** %l8
  %t441 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t441, %NativeSourceSpan** %l9
  %t442 = load double, double* %l16
  %t443 = sitofp i64 1 to double
  %t444 = fadd double %t442, %t443
  store double %t444, double* %l16
  br label %loop.latch4
merge23:
  %t445 = load i8*, i8** %l18
  %s446 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1951948513, i32 0, i32 0
  %t447 = call i1 @starts_with(i8* %t445, i8* %s446)
  %t448 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t449 = load i8*, i8** %l1
  %t450 = load i8*, i8** %l2
  %t451 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t452 = load i8*, i8** %l4
  %t453 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t454 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t455 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t456 = load %NativeFunction*, %NativeFunction** %l8
  %t457 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t458 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t459 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t460 = load double, double* %l12
  %t461 = load double, double* %l13
  %t462 = load i1, i1* %l14
  %t463 = load i1, i1* %l15
  %t464 = load double, double* %l16
  %t465 = load i8*, i8** %l18
  br i1 %t447, label %then27, label %merge28
then27:
  %t466 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s467 = getelementptr inbounds [37 x i8], [37 x i8]* @.str.len36.h736848621, i32 0, i32 0
  %t468 = load i8*, i8** %l4
  %t469 = call i8* @sailfin_runtime_string_concat(i8* %s467, i8* %t468)
  %t470 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t466, i8* %t469)
  store { i8**, i64 }* %t470, { i8**, i64 }** %l0
  %t471 = load double, double* %l16
  %t472 = sitofp i64 1 to double
  %t473 = fadd double %t471, %t472
  store double %t473, double* %l16
  br label %loop.latch4
merge28:
  %t474 = load i8*, i8** %l18
  %s475 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1830497006, i32 0, i32 0
  %t476 = call i1 @starts_with(i8* %t474, i8* %s475)
  %t477 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t478 = load i8*, i8** %l1
  %t479 = load i8*, i8** %l2
  %t480 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t481 = load i8*, i8** %l4
  %t482 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t483 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t484 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t485 = load %NativeFunction*, %NativeFunction** %l8
  %t486 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t487 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t488 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t489 = load double, double* %l12
  %t490 = load double, double* %l13
  %t491 = load i1, i1* %l14
  %t492 = load i1, i1* %l15
  %t493 = load double, double* %l16
  %t494 = load i8*, i8** %l18
  br i1 %t476, label %then29, label %merge30
then29:
  %t495 = load i8*, i8** %l18
  %s496 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1830497006, i32 0, i32 0
  %t497 = call i8* @strip_prefix(i8* %t495, i8* %s496)
  %t498 = call %NativeSourceSpan* @parse_source_span(i8* %t497)
  store %NativeSourceSpan* %t498, %NativeSourceSpan** %l20
  %t499 = load %NativeSourceSpan*, %NativeSourceSpan** %l20
  %t500 = icmp eq %NativeSourceSpan* %t499, null
  %t501 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t502 = load i8*, i8** %l1
  %t503 = load i8*, i8** %l2
  %t504 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t505 = load i8*, i8** %l4
  %t506 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t507 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t508 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t509 = load %NativeFunction*, %NativeFunction** %l8
  %t510 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t511 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t512 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t513 = load double, double* %l12
  %t514 = load double, double* %l13
  %t515 = load i1, i1* %l14
  %t516 = load i1, i1* %l15
  %t517 = load double, double* %l16
  %t518 = load i8*, i8** %l18
  %t519 = load %NativeSourceSpan*, %NativeSourceSpan** %l20
  br i1 %t500, label %then31, label %else32
then31:
  %t520 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s521 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.len31.h762677253, i32 0, i32 0
  %t522 = load i8*, i8** %l18
  %t523 = call i8* @sailfin_runtime_string_concat(i8* %s521, i8* %t522)
  %t524 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t520, i8* %t523)
  store { i8**, i64 }* %t524, { i8**, i64 }** %l0
  %t525 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge33
else32:
  %t526 = load %NativeSourceSpan*, %NativeSourceSpan** %l20
  store %NativeSourceSpan* %t526, %NativeSourceSpan** %l9
  %t527 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge33
merge33:
  %t528 = phi { i8**, i64 }* [ %t525, %then31 ], [ %t501, %else32 ]
  %t529 = phi %NativeSourceSpan* [ %t510, %then31 ], [ %t527, %else32 ]
  store { i8**, i64 }* %t528, { i8**, i64 }** %l0
  store %NativeSourceSpan* %t529, %NativeSourceSpan** %l9
  %t530 = load double, double* %l16
  %t531 = sitofp i64 1 to double
  %t532 = fadd double %t530, %t531
  store double %t532, double* %l16
  br label %loop.latch4
merge30:
  %t533 = load i8*, i8** %l18
  %s534 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1513373193, i32 0, i32 0
  %t535 = call i1 @starts_with(i8* %t533, i8* %s534)
  %t536 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t537 = load i8*, i8** %l1
  %t538 = load i8*, i8** %l2
  %t539 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t540 = load i8*, i8** %l4
  %t541 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t542 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t543 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t544 = load %NativeFunction*, %NativeFunction** %l8
  %t545 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t546 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t547 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t548 = load double, double* %l12
  %t549 = load double, double* %l13
  %t550 = load i1, i1* %l14
  %t551 = load i1, i1* %l15
  %t552 = load double, double* %l16
  %t553 = load i8*, i8** %l18
  br i1 %t535, label %then34, label %merge35
then34:
  %t554 = load i8*, i8** %l18
  %s555 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1513373193, i32 0, i32 0
  %t556 = call i8* @strip_prefix(i8* %t554, i8* %s555)
  %t557 = call %NativeSourceSpan* @parse_source_span(i8* %t556)
  store %NativeSourceSpan* %t557, %NativeSourceSpan** %l21
  %t558 = load %NativeSourceSpan*, %NativeSourceSpan** %l21
  %t559 = icmp eq %NativeSourceSpan* %t558, null
  %t560 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t561 = load i8*, i8** %l1
  %t562 = load i8*, i8** %l2
  %t563 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t564 = load i8*, i8** %l4
  %t565 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t566 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t567 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t568 = load %NativeFunction*, %NativeFunction** %l8
  %t569 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t570 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t571 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t572 = load double, double* %l12
  %t573 = load double, double* %l13
  %t574 = load i1, i1* %l14
  %t575 = load i1, i1* %l15
  %t576 = load double, double* %l16
  %t577 = load i8*, i8** %l18
  %t578 = load %NativeSourceSpan*, %NativeSourceSpan** %l21
  br i1 %t559, label %then36, label %else37
then36:
  %t579 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s580 = getelementptr inbounds [44 x i8], [44 x i8]* @.str.len43.h1714227133, i32 0, i32 0
  %t581 = load i8*, i8** %l18
  %t582 = call i8* @sailfin_runtime_string_concat(i8* %s580, i8* %t581)
  %t583 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t579, i8* %t582)
  store { i8**, i64 }* %t583, { i8**, i64 }** %l0
  %t584 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge38
else37:
  %t585 = load %NativeSourceSpan*, %NativeSourceSpan** %l21
  store %NativeSourceSpan* %t585, %NativeSourceSpan** %l10
  %t586 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge38
merge38:
  %t587 = phi { i8**, i64 }* [ %t584, %then36 ], [ %t560, %else37 ]
  %t588 = phi %NativeSourceSpan* [ %t570, %then36 ], [ %t586, %else37 ]
  store { i8**, i64 }* %t587, { i8**, i64 }** %l0
  store %NativeSourceSpan* %t588, %NativeSourceSpan** %l10
  %t589 = load double, double* %l16
  %t590 = sitofp i64 1 to double
  %t591 = fadd double %t589, %t590
  store double %t591, double* %l16
  br label %loop.latch4
merge35:
  %t592 = load i8*, i8** %l18
  %t593 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t594 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t595 = call %InstructionParseResult @parse_instruction(i8* %t592, %NativeSourceSpan* %t593, %NativeSourceSpan* %t594)
  store %InstructionParseResult %t595, %InstructionParseResult* %l22
  %t596 = load %InstructionParseResult, %InstructionParseResult* %l22
  %t597 = extractvalue %InstructionParseResult %t596, 1
  %t598 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t599 = load i8*, i8** %l1
  %t600 = load i8*, i8** %l2
  %t601 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t602 = load i8*, i8** %l4
  %t603 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t604 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t605 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t606 = load %NativeFunction*, %NativeFunction** %l8
  %t607 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t608 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t609 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t610 = load double, double* %l12
  %t611 = load double, double* %l13
  %t612 = load i1, i1* %l14
  %t613 = load i1, i1* %l15
  %t614 = load double, double* %l16
  %t615 = load i8*, i8** %l18
  %t616 = load %InstructionParseResult, %InstructionParseResult* %l22
  br i1 %t597, label %then39, label %else40
then39:
  %t617 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t617, %NativeSourceSpan** %l9
  %t618 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge41
else40:
  %t619 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t620 = icmp ne %NativeSourceSpan* %t619, null
  %t621 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t622 = load i8*, i8** %l1
  %t623 = load i8*, i8** %l2
  %t624 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t625 = load i8*, i8** %l4
  %t626 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t627 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t628 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t629 = load %NativeFunction*, %NativeFunction** %l8
  %t630 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t631 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t632 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t633 = load double, double* %l12
  %t634 = load double, double* %l13
  %t635 = load i1, i1* %l14
  %t636 = load i1, i1* %l15
  %t637 = load double, double* %l16
  %t638 = load i8*, i8** %l18
  %t639 = load %InstructionParseResult, %InstructionParseResult* %l22
  br i1 %t620, label %then42, label %merge43
then42:
  %t640 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s641 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.len29.h1601547567, i32 0, i32 0
  %t642 = load i8*, i8** %l18
  %t643 = call i8* @sailfin_runtime_string_concat(i8* %s641, i8* %t642)
  %t644 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t640, i8* %t643)
  store { i8**, i64 }* %t644, { i8**, i64 }** %l0
  %t645 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t645, %NativeSourceSpan** %l9
  %t646 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t647 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge43
merge43:
  %t648 = phi { i8**, i64 }* [ %t646, %then42 ], [ %t621, %else40 ]
  %t649 = phi %NativeSourceSpan* [ %t647, %then42 ], [ %t630, %else40 ]
  store { i8**, i64 }* %t648, { i8**, i64 }** %l0
  store %NativeSourceSpan* %t649, %NativeSourceSpan** %l9
  %t650 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t651 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge41
merge41:
  %t652 = phi %NativeSourceSpan* [ %t618, %then39 ], [ %t651, %merge43 ]
  %t653 = phi { i8**, i64 }* [ %t598, %then39 ], [ %t650, %merge43 ]
  store %NativeSourceSpan* %t652, %NativeSourceSpan** %l9
  store { i8**, i64 }* %t653, { i8**, i64 }** %l0
  %t654 = load %InstructionParseResult, %InstructionParseResult* %l22
  %t655 = extractvalue %InstructionParseResult %t654, 2
  %t656 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t657 = load i8*, i8** %l1
  %t658 = load i8*, i8** %l2
  %t659 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t660 = load i8*, i8** %l4
  %t661 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t662 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t663 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t664 = load %NativeFunction*, %NativeFunction** %l8
  %t665 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t666 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t667 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t668 = load double, double* %l12
  %t669 = load double, double* %l13
  %t670 = load i1, i1* %l14
  %t671 = load i1, i1* %l15
  %t672 = load double, double* %l16
  %t673 = load i8*, i8** %l18
  %t674 = load %InstructionParseResult, %InstructionParseResult* %l22
  br i1 %t655, label %then44, label %else45
then44:
  %t675 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t675, %NativeSourceSpan** %l10
  %t676 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge46
else45:
  %t677 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t678 = icmp ne %NativeSourceSpan* %t677, null
  %t679 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t680 = load i8*, i8** %l1
  %t681 = load i8*, i8** %l2
  %t682 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t683 = load i8*, i8** %l4
  %t684 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t685 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t686 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t687 = load %NativeFunction*, %NativeFunction** %l8
  %t688 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t689 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t690 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t691 = load double, double* %l12
  %t692 = load double, double* %l13
  %t693 = load i1, i1* %l14
  %t694 = load i1, i1* %l15
  %t695 = load double, double* %l16
  %t696 = load i8*, i8** %l18
  %t697 = load %InstructionParseResult, %InstructionParseResult* %l22
  br i1 %t678, label %then47, label %merge48
then47:
  %t698 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s699 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.len41.h35508704, i32 0, i32 0
  %t700 = load i8*, i8** %l18
  %t701 = call i8* @sailfin_runtime_string_concat(i8* %s699, i8* %t700)
  %t702 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t698, i8* %t701)
  store { i8**, i64 }* %t702, { i8**, i64 }** %l0
  %t703 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t703, %NativeSourceSpan** %l10
  %t704 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t705 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge48
merge48:
  %t706 = phi { i8**, i64 }* [ %t704, %then47 ], [ %t679, %else45 ]
  %t707 = phi %NativeSourceSpan* [ %t705, %then47 ], [ %t689, %else45 ]
  store { i8**, i64 }* %t706, { i8**, i64 }** %l0
  store %NativeSourceSpan* %t707, %NativeSourceSpan** %l10
  %t708 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t709 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge46
merge46:
  %t710 = phi %NativeSourceSpan* [ %t676, %then44 ], [ %t709, %merge48 ]
  %t711 = phi { i8**, i64 }* [ %t656, %then44 ], [ %t708, %merge48 ]
  store %NativeSourceSpan* %t710, %NativeSourceSpan** %l10
  store { i8**, i64 }* %t711, { i8**, i64 }** %l0
  %t712 = sitofp i64 0 to double
  store double %t712, double* %l23
  %t713 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t714 = load i8*, i8** %l1
  %t715 = load i8*, i8** %l2
  %t716 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t717 = load i8*, i8** %l4
  %t718 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t719 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t720 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t721 = load %NativeFunction*, %NativeFunction** %l8
  %t722 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t723 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t724 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t725 = load double, double* %l12
  %t726 = load double, double* %l13
  %t727 = load i1, i1* %l14
  %t728 = load i1, i1* %l15
  %t729 = load double, double* %l16
  %t730 = load i8*, i8** %l18
  %t731 = load %InstructionParseResult, %InstructionParseResult* %l22
  %t732 = load double, double* %l23
  br label %loop.header49
loop.header49:
  %t780 = phi %NativeFunction* [ %t721, %merge46 ], [ %t778, %loop.latch51 ]
  %t781 = phi double [ %t732, %merge46 ], [ %t779, %loop.latch51 ]
  store %NativeFunction* %t780, %NativeFunction** %l8
  store double %t781, double* %l23
  br label %loop.body50
loop.body50:
  %t733 = load double, double* %l23
  %t734 = load %InstructionParseResult, %InstructionParseResult* %l22
  %t735 = extractvalue %InstructionParseResult %t734, 0
  %t736 = load { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t735
  %t737 = extractvalue { %NativeInstruction**, i64 } %t736, 1
  %t738 = sitofp i64 %t737 to double
  %t739 = fcmp oge double %t733, %t738
  %t740 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t741 = load i8*, i8** %l1
  %t742 = load i8*, i8** %l2
  %t743 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t744 = load i8*, i8** %l4
  %t745 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t746 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t747 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t748 = load %NativeFunction*, %NativeFunction** %l8
  %t749 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t750 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t751 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t752 = load double, double* %l12
  %t753 = load double, double* %l13
  %t754 = load i1, i1* %l14
  %t755 = load i1, i1* %l15
  %t756 = load double, double* %l16
  %t757 = load i8*, i8** %l18
  %t758 = load %InstructionParseResult, %InstructionParseResult* %l22
  %t759 = load double, double* %l23
  br i1 %t739, label %then53, label %merge54
then53:
  br label %afterloop52
merge54:
  %t760 = load %NativeFunction*, %NativeFunction** %l8
  %t761 = load %InstructionParseResult, %InstructionParseResult* %l22
  %t762 = extractvalue %InstructionParseResult %t761, 0
  %t763 = load double, double* %l23
  %t764 = fptosi double %t763 to i64
  %t765 = load { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t762
  %t766 = extractvalue { %NativeInstruction**, i64 } %t765, 0
  %t767 = extractvalue { %NativeInstruction**, i64 } %t765, 1
  %t768 = icmp uge i64 %t764, %t767
  ; bounds check: %t768 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t764, i64 %t767)
  %t769 = getelementptr %NativeInstruction*, %NativeInstruction** %t766, i64 %t764
  %t770 = load %NativeInstruction*, %NativeInstruction** %t769
  %t771 = load %NativeFunction, %NativeFunction* %t760
  %t772 = load %NativeInstruction, %NativeInstruction* %t770
  %t773 = call %NativeFunction @append_instruction(%NativeFunction %t771, %NativeInstruction %t772)
  %t774 = alloca %NativeFunction
  store %NativeFunction %t773, %NativeFunction* %t774
  store %NativeFunction* %t774, %NativeFunction** %l8
  %t775 = load double, double* %l23
  %t776 = sitofp i64 1 to double
  %t777 = fadd double %t775, %t776
  store double %t777, double* %l23
  br label %loop.latch51
loop.latch51:
  %t778 = load %NativeFunction*, %NativeFunction** %l8
  %t779 = load double, double* %l23
  br label %loop.header49
afterloop52:
  %t782 = load %NativeFunction*, %NativeFunction** %l8
  %t783 = load double, double* %l23
  %t784 = load double, double* %l16
  %t785 = sitofp i64 1 to double
  %t786 = fadd double %t784, %t785
  store double %t786, double* %l16
  br label %loop.latch4
merge17:
  %t787 = load i8*, i8** %l18
  %s788 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1616485352, i32 0, i32 0
  %t789 = call i1 @starts_with(i8* %t787, i8* %s788)
  %t790 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t791 = load i8*, i8** %l1
  %t792 = load i8*, i8** %l2
  %t793 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t794 = load i8*, i8** %l4
  %t795 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t796 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t797 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t798 = load %NativeFunction*, %NativeFunction** %l8
  %t799 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t800 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t801 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t802 = load double, double* %l12
  %t803 = load double, double* %l13
  %t804 = load i1, i1* %l14
  %t805 = load i1, i1* %l15
  %t806 = load double, double* %l16
  %t807 = load i8*, i8** %l18
  br i1 %t789, label %then55, label %merge56
then55:
  %t808 = load i8*, i8** %l18
  %s809 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1616485352, i32 0, i32 0
  %t810 = call i8* @strip_prefix(i8* %t808, i8* %s809)
  store i8* %t810, i8** %l24
  %t811 = load i8*, i8** %l24
  %s812 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t813 = call i1 @starts_with(i8* %t811, i8* %s812)
  %t814 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t815 = load i8*, i8** %l1
  %t816 = load i8*, i8** %l2
  %t817 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t818 = load i8*, i8** %l4
  %t819 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t820 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t821 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t822 = load %NativeFunction*, %NativeFunction** %l8
  %t823 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t824 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t825 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t826 = load double, double* %l12
  %t827 = load double, double* %l13
  %t828 = load i1, i1* %l14
  %t829 = load i1, i1* %l15
  %t830 = load double, double* %l16
  %t831 = load i8*, i8** %l18
  %t832 = load i8*, i8** %l24
  br i1 %t813, label %then57, label %merge58
then57:
  %t833 = load i8*, i8** %l24
  %s834 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t835 = call i8* @strip_prefix(i8* %t833, i8* %s834)
  %t836 = call %StructLayoutHeaderParse @parse_struct_layout_header(i8* %t835)
  store %StructLayoutHeaderParse %t836, %StructLayoutHeaderParse* %l25
  %t837 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t838 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l25
  %t839 = extractvalue %StructLayoutHeaderParse %t838, 4
  %t840 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t837, { i8**, i64 }* %t839)
  store { i8**, i64 }* %t840, { i8**, i64 }** %l0
  %t841 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l25
  %t842 = extractvalue %StructLayoutHeaderParse %t841, 0
  %t843 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t844 = load i8*, i8** %l1
  %t845 = load i8*, i8** %l2
  %t846 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t847 = load i8*, i8** %l4
  %t848 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t849 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t850 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t851 = load %NativeFunction*, %NativeFunction** %l8
  %t852 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t853 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t854 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t855 = load double, double* %l12
  %t856 = load double, double* %l13
  %t857 = load i1, i1* %l14
  %t858 = load i1, i1* %l15
  %t859 = load double, double* %l16
  %t860 = load i8*, i8** %l18
  %t861 = load i8*, i8** %l24
  %t862 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l25
  br i1 %t842, label %then59, label %merge60
then59:
  %t863 = load i1, i1* %l14
  %t864 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t865 = load i8*, i8** %l1
  %t866 = load i8*, i8** %l2
  %t867 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t868 = load i8*, i8** %l4
  %t869 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t870 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t871 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t872 = load %NativeFunction*, %NativeFunction** %l8
  %t873 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t874 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t875 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t876 = load double, double* %l12
  %t877 = load double, double* %l13
  %t878 = load i1, i1* %l14
  %t879 = load i1, i1* %l15
  %t880 = load double, double* %l16
  %t881 = load i8*, i8** %l18
  %t882 = load i8*, i8** %l24
  %t883 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l25
  br i1 %t863, label %then61, label %else62
then61:
  %t884 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s885 = getelementptr inbounds [35 x i8], [35 x i8]* @.str.len34.h654371835, i32 0, i32 0
  %t886 = load i8*, i8** %l4
  %t887 = call i8* @sailfin_runtime_string_concat(i8* %s885, i8* %t886)
  %t888 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t884, i8* %t887)
  store { i8**, i64 }* %t888, { i8**, i64 }** %l0
  %t889 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge63
else62:
  %t890 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l25
  %t891 = extractvalue %StructLayoutHeaderParse %t890, 2
  store double %t891, double* %l12
  %t892 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l25
  %t893 = extractvalue %StructLayoutHeaderParse %t892, 3
  store double %t893, double* %l13
  store i1 1, i1* %l14
  %t894 = load double, double* %l12
  %t895 = load double, double* %l13
  %t896 = load i1, i1* %l14
  br label %merge63
merge63:
  %t897 = phi { i8**, i64 }* [ %t889, %then61 ], [ %t864, %else62 ]
  %t898 = phi double [ %t876, %then61 ], [ %t894, %else62 ]
  %t899 = phi double [ %t877, %then61 ], [ %t895, %else62 ]
  %t900 = phi i1 [ %t878, %then61 ], [ %t896, %else62 ]
  store { i8**, i64 }* %t897, { i8**, i64 }** %l0
  store double %t898, double* %l12
  store double %t899, double* %l13
  store i1 %t900, i1* %l14
  %t901 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t902 = load double, double* %l12
  %t903 = load double, double* %l13
  %t904 = load i1, i1* %l14
  br label %merge60
merge60:
  %t905 = phi { i8**, i64 }* [ %t901, %merge63 ], [ %t843, %then57 ]
  %t906 = phi double [ %t902, %merge63 ], [ %t855, %then57 ]
  %t907 = phi double [ %t903, %merge63 ], [ %t856, %then57 ]
  %t908 = phi i1 [ %t904, %merge63 ], [ %t857, %then57 ]
  store { i8**, i64 }* %t905, { i8**, i64 }** %l0
  store double %t906, double* %l12
  store double %t907, double* %l13
  store i1 %t908, i1* %l14
  %t909 = load double, double* %l16
  %t910 = sitofp i64 1 to double
  %t911 = fadd double %t909, %t910
  store double %t911, double* %l16
  br label %loop.latch4
merge58:
  %t912 = load i8*, i8** %l24
  %s913 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h734244628, i32 0, i32 0
  %t914 = call i1 @starts_with(i8* %t912, i8* %s913)
  %t915 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t916 = load i8*, i8** %l1
  %t917 = load i8*, i8** %l2
  %t918 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t919 = load i8*, i8** %l4
  %t920 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t921 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t922 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t923 = load %NativeFunction*, %NativeFunction** %l8
  %t924 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t925 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t926 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t927 = load double, double* %l12
  %t928 = load double, double* %l13
  %t929 = load i1, i1* %l14
  %t930 = load i1, i1* %l15
  %t931 = load double, double* %l16
  %t932 = load i8*, i8** %l18
  %t933 = load i8*, i8** %l24
  br i1 %t914, label %then64, label %merge65
then64:
  %t934 = load i8*, i8** %l24
  %s935 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h734244628, i32 0, i32 0
  %t936 = call i8* @strip_prefix(i8* %t934, i8* %s935)
  %t937 = load i8*, i8** %l4
  %t938 = call %StructLayoutFieldParse @parse_struct_layout_field(i8* %t936, i8* %t937)
  store %StructLayoutFieldParse %t938, %StructLayoutFieldParse* %l26
  %t939 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t940 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l26
  %t941 = extractvalue %StructLayoutFieldParse %t940, 2
  %t942 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t939, { i8**, i64 }* %t941)
  store { i8**, i64 }* %t942, { i8**, i64 }** %l0
  %t943 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l26
  %t944 = extractvalue %StructLayoutFieldParse %t943, 0
  %t945 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t946 = load i8*, i8** %l1
  %t947 = load i8*, i8** %l2
  %t948 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t949 = load i8*, i8** %l4
  %t950 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t951 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t952 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t953 = load %NativeFunction*, %NativeFunction** %l8
  %t954 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t955 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t956 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t957 = load double, double* %l12
  %t958 = load double, double* %l13
  %t959 = load i1, i1* %l14
  %t960 = load i1, i1* %l15
  %t961 = load double, double* %l16
  %t962 = load i8*, i8** %l18
  %t963 = load i8*, i8** %l24
  %t964 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l26
  br i1 %t944, label %then66, label %merge67
then66:
  %t965 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t966 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l26
  %t967 = extractvalue %StructLayoutFieldParse %t966, 1
  %t968 = call { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %t965, %NativeStructLayoutField %t967)
  store { %NativeStructLayoutField*, i64 }* %t968, { %NativeStructLayoutField*, i64 }** %l11
  %t969 = load i1, i1* %l14
  %t970 = xor i1 %t969, 1
  %t971 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t972 = load i8*, i8** %l1
  %t973 = load i8*, i8** %l2
  %t974 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t975 = load i8*, i8** %l4
  %t976 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t977 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t978 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t979 = load %NativeFunction*, %NativeFunction** %l8
  %t980 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t981 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t982 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t983 = load double, double* %l12
  %t984 = load double, double* %l13
  %t985 = load i1, i1* %l14
  %t986 = load i1, i1* %l15
  %t987 = load double, double* %l16
  %t988 = load i8*, i8** %l18
  %t989 = load i8*, i8** %l24
  %t990 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l26
  br i1 %t970, label %then68, label %merge69
then68:
  %t991 = load i1, i1* %l15
  %t992 = xor i1 %t991, 1
  %t993 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t994 = load i8*, i8** %l1
  %t995 = load i8*, i8** %l2
  %t996 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t997 = load i8*, i8** %l4
  %t998 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t999 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1000 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1001 = load %NativeFunction*, %NativeFunction** %l8
  %t1002 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1003 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1004 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1005 = load double, double* %l12
  %t1006 = load double, double* %l13
  %t1007 = load i1, i1* %l14
  %t1008 = load i1, i1* %l15
  %t1009 = load double, double* %l16
  %t1010 = load i8*, i8** %l18
  %t1011 = load i8*, i8** %l24
  %t1012 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l26
  br i1 %t992, label %then70, label %merge71
then70:
  %t1013 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s1014 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t1015 = load i8*, i8** %l4
  %t1016 = call i8* @sailfin_runtime_string_concat(i8* %s1014, i8* %t1015)
  %s1017 = getelementptr inbounds [47 x i8], [47 x i8]* @.str.len46.h1830585629, i32 0, i32 0
  %t1018 = call i8* @sailfin_runtime_string_concat(i8* %t1016, i8* %s1017)
  %t1019 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1013, i8* %t1018)
  store { i8**, i64 }* %t1019, { i8**, i64 }** %l0
  store i1 1, i1* %l15
  %t1020 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1021 = load i1, i1* %l15
  br label %merge71
merge71:
  %t1022 = phi { i8**, i64 }* [ %t1020, %then70 ], [ %t993, %then68 ]
  %t1023 = phi i1 [ %t1021, %then70 ], [ %t1008, %then68 ]
  store { i8**, i64 }* %t1022, { i8**, i64 }** %l0
  store i1 %t1023, i1* %l15
  %t1024 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1025 = load i1, i1* %l15
  br label %merge69
merge69:
  %t1026 = phi { i8**, i64 }* [ %t1024, %merge71 ], [ %t971, %then66 ]
  %t1027 = phi i1 [ %t1025, %merge71 ], [ %t986, %then66 ]
  store { i8**, i64 }* %t1026, { i8**, i64 }** %l0
  store i1 %t1027, i1* %l15
  %t1028 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1029 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1030 = load i1, i1* %l15
  br label %merge67
merge67:
  %t1031 = phi { %NativeStructLayoutField*, i64 }* [ %t1028, %merge69 ], [ %t956, %then64 ]
  %t1032 = phi { i8**, i64 }* [ %t1029, %merge69 ], [ %t945, %then64 ]
  %t1033 = phi i1 [ %t1030, %merge69 ], [ %t960, %then64 ]
  store { %NativeStructLayoutField*, i64 }* %t1031, { %NativeStructLayoutField*, i64 }** %l11
  store { i8**, i64 }* %t1032, { i8**, i64 }** %l0
  store i1 %t1033, i1* %l15
  %t1034 = load double, double* %l16
  %t1035 = sitofp i64 1 to double
  %t1036 = fadd double %t1034, %t1035
  store double %t1036, double* %l16
  br label %loop.latch4
merge65:
  %t1037 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s1038 = getelementptr inbounds [38 x i8], [38 x i8]* @.str.len37.h1152036459, i32 0, i32 0
  %t1039 = load i8*, i8** %l18
  %t1040 = call i8* @sailfin_runtime_string_concat(i8* %s1038, i8* %t1039)
  %t1041 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1037, i8* %t1040)
  store { i8**, i64 }* %t1041, { i8**, i64 }** %l0
  %t1042 = load double, double* %l16
  %t1043 = sitofp i64 1 to double
  %t1044 = fadd double %t1042, %t1043
  store double %t1044, double* %l16
  br label %loop.latch4
merge56:
  %t1045 = load i8*, i8** %l18
  %s1046 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h268717223, i32 0, i32 0
  %t1047 = icmp eq i8* %t1045, %s1046
  %t1048 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1049 = load i8*, i8** %l1
  %t1050 = load i8*, i8** %l2
  %t1051 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t1052 = load i8*, i8** %l4
  %t1053 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1054 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1055 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1056 = load %NativeFunction*, %NativeFunction** %l8
  %t1057 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1058 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1059 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1060 = load double, double* %l12
  %t1061 = load double, double* %l13
  %t1062 = load i1, i1* %l14
  %t1063 = load i1, i1* %l15
  %t1064 = load double, double* %l16
  %t1065 = load i8*, i8** %l18
  br i1 %t1047, label %then72, label %merge73
then72:
  %t1066 = load double, double* %l16
  %t1067 = sitofp i64 1 to double
  %t1068 = fadd double %t1066, %t1067
  store double %t1068, double* %l16
  br label %loop.latch4
merge73:
  %t1069 = load i8*, i8** %l18
  %s1070 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h398443637, i32 0, i32 0
  %t1071 = call i1 @starts_with(i8* %t1069, i8* %s1070)
  %t1072 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1073 = load i8*, i8** %l1
  %t1074 = load i8*, i8** %l2
  %t1075 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t1076 = load i8*, i8** %l4
  %t1077 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1078 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1079 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1080 = load %NativeFunction*, %NativeFunction** %l8
  %t1081 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1082 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1083 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1084 = load double, double* %l12
  %t1085 = load double, double* %l13
  %t1086 = load i1, i1* %l14
  %t1087 = load i1, i1* %l15
  %t1088 = load double, double* %l16
  %t1089 = load i8*, i8** %l18
  br i1 %t1071, label %then74, label %merge75
then74:
  %t1090 = load i8*, i8** %l18
  %s1091 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h398443637, i32 0, i32 0
  %t1092 = call i8* @strip_prefix(i8* %t1090, i8* %s1091)
  %t1093 = call %NativeStructField* @parse_struct_field_line(i8* %t1092)
  store %NativeStructField* %t1093, %NativeStructField** %l27
  %t1094 = load %NativeStructField*, %NativeStructField** %l27
  %t1095 = icmp eq %NativeStructField* %t1094, null
  %t1096 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1097 = load i8*, i8** %l1
  %t1098 = load i8*, i8** %l2
  %t1099 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t1100 = load i8*, i8** %l4
  %t1101 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1102 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1103 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1104 = load %NativeFunction*, %NativeFunction** %l8
  %t1105 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1106 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1107 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1108 = load double, double* %l12
  %t1109 = load double, double* %l13
  %t1110 = load i1, i1* %l14
  %t1111 = load i1, i1* %l15
  %t1112 = load double, double* %l16
  %t1113 = load i8*, i8** %l18
  %t1114 = load %NativeStructField*, %NativeStructField** %l27
  br i1 %t1095, label %then76, label %else77
then76:
  %t1115 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s1116 = getelementptr inbounds [31 x i8], [31 x i8]* @.str.len30.h702899578, i32 0, i32 0
  %t1117 = load i8*, i8** %l18
  %t1118 = call i8* @sailfin_runtime_string_concat(i8* %s1116, i8* %t1117)
  %t1119 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1115, i8* %t1118)
  store { i8**, i64 }* %t1119, { i8**, i64 }** %l0
  %t1120 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge78
else77:
  %t1121 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1122 = load %NativeStructField*, %NativeStructField** %l27
  %t1123 = load %NativeStructField, %NativeStructField* %t1122
  %t1124 = call { %NativeStructField*, i64 }* @append_struct_field({ %NativeStructField*, i64 }* %t1121, %NativeStructField %t1123)
  store { %NativeStructField*, i64 }* %t1124, { %NativeStructField*, i64 }** %l6
  %t1125 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  br label %merge78
merge78:
  %t1126 = phi { i8**, i64 }* [ %t1120, %then76 ], [ %t1096, %else77 ]
  %t1127 = phi { %NativeStructField*, i64 }* [ %t1102, %then76 ], [ %t1125, %else77 ]
  store { i8**, i64 }* %t1126, { i8**, i64 }** %l0
  store { %NativeStructField*, i64 }* %t1127, { %NativeStructField*, i64 }** %l6
  %t1128 = load double, double* %l16
  %t1129 = sitofp i64 1 to double
  %t1130 = fadd double %t1128, %t1129
  store double %t1130, double* %l16
  br label %loop.latch4
merge75:
  %t1131 = load i8*, i8** %l18
  %s1132 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1951948513, i32 0, i32 0
  %t1133 = call i1 @starts_with(i8* %t1131, i8* %s1132)
  %t1134 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1135 = load i8*, i8** %l1
  %t1136 = load i8*, i8** %l2
  %t1137 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t1138 = load i8*, i8** %l4
  %t1139 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1140 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1141 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1142 = load %NativeFunction*, %NativeFunction** %l8
  %t1143 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1144 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1145 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1146 = load double, double* %l12
  %t1147 = load double, double* %l13
  %t1148 = load i1, i1* %l14
  %t1149 = load i1, i1* %l15
  %t1150 = load double, double* %l16
  %t1151 = load i8*, i8** %l18
  br i1 %t1133, label %then79, label %merge80
then79:
  %t1152 = load %NativeFunction*, %NativeFunction** %l8
  %t1153 = icmp ne %NativeFunction* %t1152, null
  %t1154 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1155 = load i8*, i8** %l1
  %t1156 = load i8*, i8** %l2
  %t1157 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t1158 = load i8*, i8** %l4
  %t1159 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1160 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1161 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1162 = load %NativeFunction*, %NativeFunction** %l8
  %t1163 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1164 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1165 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1166 = load double, double* %l12
  %t1167 = load double, double* %l13
  %t1168 = load i1, i1* %l14
  %t1169 = load i1, i1* %l15
  %t1170 = load double, double* %l16
  %t1171 = load i8*, i8** %l18
  br i1 %t1153, label %then81, label %merge82
then81:
  %t1172 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s1173 = getelementptr inbounds [37 x i8], [37 x i8]* @.str.len36.h736848621, i32 0, i32 0
  %t1174 = load i8*, i8** %l4
  %t1175 = call i8* @sailfin_runtime_string_concat(i8* %s1173, i8* %t1174)
  %t1176 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1172, i8* %t1175)
  store { i8**, i64 }* %t1176, { i8**, i64 }** %l0
  %t1177 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge82
merge82:
  %t1178 = phi { i8**, i64 }* [ %t1177, %then81 ], [ %t1154, %then79 ]
  store { i8**, i64 }* %t1178, { i8**, i64 }** %l0
  %t1179 = load i8*, i8** %l18
  %s1180 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1951948513, i32 0, i32 0
  %t1181 = call i8* @strip_prefix(i8* %t1179, i8* %s1180)
  %t1182 = call i8* @parse_function_name(i8* %t1181)
  store i8* %t1182, i8** %l28
  %t1183 = load i8*, i8** %l28
  %t1184 = insertvalue %NativeFunction undef, i8* %t1183, 0
  %t1185 = getelementptr [0 x %NativeParameter*], [0 x %NativeParameter*]* null, i32 1
  %t1186 = ptrtoint [0 x %NativeParameter*]* %t1185 to i64
  %t1187 = icmp eq i64 %t1186, 0
  %t1188 = select i1 %t1187, i64 1, i64 %t1186
  %t1189 = call i8* @malloc(i64 %t1188)
  %t1190 = bitcast i8* %t1189 to %NativeParameter**
  %t1191 = getelementptr { %NativeParameter**, i64 }, { %NativeParameter**, i64 }* null, i32 1
  %t1192 = ptrtoint { %NativeParameter**, i64 }* %t1191 to i64
  %t1193 = call i8* @malloc(i64 %t1192)
  %t1194 = bitcast i8* %t1193 to { %NativeParameter**, i64 }*
  %t1195 = getelementptr { %NativeParameter**, i64 }, { %NativeParameter**, i64 }* %t1194, i32 0, i32 0
  store %NativeParameter** %t1190, %NativeParameter*** %t1195
  %t1196 = getelementptr { %NativeParameter**, i64 }, { %NativeParameter**, i64 }* %t1194, i32 0, i32 1
  store i64 0, i64* %t1196
  %t1197 = insertvalue %NativeFunction %t1184, { %NativeParameter**, i64 }* %t1194, 1
  %s1198 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h278197661, i32 0, i32 0
  %t1199 = insertvalue %NativeFunction %t1197, i8* %s1198, 2
  %t1200 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t1201 = ptrtoint [0 x i8*]* %t1200 to i64
  %t1202 = icmp eq i64 %t1201, 0
  %t1203 = select i1 %t1202, i64 1, i64 %t1201
  %t1204 = call i8* @malloc(i64 %t1203)
  %t1205 = bitcast i8* %t1204 to i8**
  %t1206 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t1207 = ptrtoint { i8**, i64 }* %t1206 to i64
  %t1208 = call i8* @malloc(i64 %t1207)
  %t1209 = bitcast i8* %t1208 to { i8**, i64 }*
  %t1210 = getelementptr { i8**, i64 }, { i8**, i64 }* %t1209, i32 0, i32 0
  store i8** %t1205, i8*** %t1210
  %t1211 = getelementptr { i8**, i64 }, { i8**, i64 }* %t1209, i32 0, i32 1
  store i64 0, i64* %t1211
  %t1212 = insertvalue %NativeFunction %t1199, { i8**, i64 }* %t1209, 3
  %t1213 = getelementptr [0 x %NativeInstruction*], [0 x %NativeInstruction*]* null, i32 1
  %t1214 = ptrtoint [0 x %NativeInstruction*]* %t1213 to i64
  %t1215 = icmp eq i64 %t1214, 0
  %t1216 = select i1 %t1215, i64 1, i64 %t1214
  %t1217 = call i8* @malloc(i64 %t1216)
  %t1218 = bitcast i8* %t1217 to %NativeInstruction**
  %t1219 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* null, i32 1
  %t1220 = ptrtoint { %NativeInstruction**, i64 }* %t1219 to i64
  %t1221 = call i8* @malloc(i64 %t1220)
  %t1222 = bitcast i8* %t1221 to { %NativeInstruction**, i64 }*
  %t1223 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t1222, i32 0, i32 0
  store %NativeInstruction** %t1218, %NativeInstruction*** %t1223
  %t1224 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t1222, i32 0, i32 1
  store i64 0, i64* %t1224
  %t1225 = insertvalue %NativeFunction %t1212, { %NativeInstruction**, i64 }* %t1222, 4
  %t1226 = alloca %NativeFunction
  store %NativeFunction %t1225, %NativeFunction* %t1226
  store %NativeFunction* %t1226, %NativeFunction** %l8
  %t1227 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1227, %NativeSourceSpan** %l9
  %t1228 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1228, %NativeSourceSpan** %l10
  %t1229 = load double, double* %l16
  %t1230 = sitofp i64 1 to double
  %t1231 = fadd double %t1229, %t1230
  store double %t1231, double* %l16
  br label %loop.latch4
merge80:
  %t1232 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s1233 = getelementptr inbounds [31 x i8], [31 x i8]* @.str.len30.h211710404, i32 0, i32 0
  %t1234 = load i8*, i8** %l18
  %t1235 = call i8* @sailfin_runtime_string_concat(i8* %s1233, i8* %t1234)
  %t1236 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1232, i8* %t1235)
  store { i8**, i64 }* %t1236, { i8**, i64 }** %l0
  %t1237 = load double, double* %l16
  %t1238 = sitofp i64 1 to double
  %t1239 = fadd double %t1237, %t1238
  store double %t1239, double* %l16
  br label %loop.latch4
loop.latch4:
  %t1240 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1241 = load double, double* %l16
  %t1242 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1243 = load %NativeFunction*, %NativeFunction** %l8
  %t1244 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1245 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1246 = load double, double* %l12
  %t1247 = load double, double* %l13
  %t1248 = load i1, i1* %l14
  %t1249 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1250 = load i1, i1* %l15
  %t1251 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  br label %loop.header2
afterloop5:
  %t1264 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1265 = load double, double* %l16
  %t1266 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1267 = load %NativeFunction*, %NativeFunction** %l8
  %t1268 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1269 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1270 = load double, double* %l12
  %t1271 = load double, double* %l13
  %t1272 = load i1, i1* %l14
  %t1273 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1274 = load i1, i1* %l15
  %t1275 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1276 = bitcast i8* null to %NativeStructLayout*
  store %NativeStructLayout* %t1276, %NativeStructLayout** %l29
  %t1277 = load i1, i1* %l14
  %t1278 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1279 = load i8*, i8** %l1
  %t1280 = load i8*, i8** %l2
  %t1281 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t1282 = load i8*, i8** %l4
  %t1283 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1284 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1285 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1286 = load %NativeFunction*, %NativeFunction** %l8
  %t1287 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1288 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1289 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1290 = load double, double* %l12
  %t1291 = load double, double* %l13
  %t1292 = load i1, i1* %l14
  %t1293 = load i1, i1* %l15
  %t1294 = load double, double* %l16
  %t1295 = load %NativeStructLayout*, %NativeStructLayout** %l29
  br i1 %t1277, label %then83, label %merge84
then83:
  %t1296 = load double, double* %l12
  %t1297 = insertvalue %NativeStructLayout undef, double %t1296, 0
  %t1298 = load double, double* %l13
  %t1299 = insertvalue %NativeStructLayout %t1297, double %t1298, 1
  %t1300 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1301 = bitcast { %NativeStructLayoutField*, i64 }* %t1300 to { %NativeStructLayoutField**, i64 }*
  %t1302 = insertvalue %NativeStructLayout %t1299, { %NativeStructLayoutField**, i64 }* %t1301, 2
  %t1303 = alloca %NativeStructLayout
  store %NativeStructLayout %t1302, %NativeStructLayout* %t1303
  store %NativeStructLayout* %t1303, %NativeStructLayout** %l29
  %t1304 = load %NativeStructLayout*, %NativeStructLayout** %l29
  br label %merge84
merge84:
  %t1305 = phi %NativeStructLayout* [ %t1304, %then83 ], [ %t1295, %afterloop5 ]
  store %NativeStructLayout* %t1305, %NativeStructLayout** %l29
  %t1306 = load i8*, i8** %l4
  %t1307 = insertvalue %NativeStruct undef, i8* %t1306, 0
  %t1308 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1309 = bitcast { %NativeStructField*, i64 }* %t1308 to { %NativeStructField**, i64 }*
  %t1310 = insertvalue %NativeStruct %t1307, { %NativeStructField**, i64 }* %t1309, 1
  %t1311 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1312 = bitcast { %NativeFunction*, i64 }* %t1311 to { %NativeFunction**, i64 }*
  %t1313 = insertvalue %NativeStruct %t1310, { %NativeFunction**, i64 }* %t1312, 2
  %t1314 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1315 = insertvalue %NativeStruct %t1313, { i8**, i64 }* %t1314, 3
  %t1316 = load %NativeStructLayout*, %NativeStructLayout** %l29
  %t1317 = insertvalue %NativeStruct %t1315, %NativeStructLayout* %t1316, 4
  %t1318 = alloca %NativeStruct
  store %NativeStruct %t1317, %NativeStruct* %t1318
  %t1319 = insertvalue %StructParseResult undef, %NativeStruct* %t1318, 0
  %t1320 = load double, double* %l16
  %t1321 = insertvalue %StructParseResult %t1319, double %t1320, 1
  %t1322 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1323 = insertvalue %StructParseResult %t1321, { i8**, i64 }* %t1322, 2
  ret %StructParseResult %t1323
}

define %InterfaceParseResult @parse_interface_definition({ i8**, i64 }* %lines, double %start_index) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca %InterfaceHeaderParse
  %l4 = alloca i8*
  %l5 = alloca { %NativeInterfaceSignature*, i64 }*
  %l6 = alloca double
  %l7 = alloca i8*
  %l8 = alloca %InterfaceSignatureParse
  %t0 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t1 = ptrtoint [0 x i8*]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to i8**
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t7 = ptrtoint { i8**, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { i8**, i64 }*
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 0
  store i8** %t5, i8*** %t10
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { i8**, i64 }* %t9, { i8**, i64 }** %l0
  %t12 = fptosi double %start_index to i64
  %t13 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t14 = extractvalue { i8**, i64 } %t13, 0
  %t15 = extractvalue { i8**, i64 } %t13, 1
  %t16 = icmp uge i64 %t12, %t15
  ; bounds check: %t16 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t12, i64 %t15)
  %t17 = getelementptr i8*, i8** %t14, i64 %t12
  %t18 = load i8*, i8** %t17
  %t19 = call i8* @trim_text(i8* %t18)
  store i8* %t19, i8** %l1
  %t20 = load i8*, i8** %l1
  %s21 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h599952843, i32 0, i32 0
  %t22 = call i8* @strip_prefix(i8* %t20, i8* %s21)
  %t23 = call i8* @trim_text(i8* %t22)
  store i8* %t23, i8** %l2
  %t24 = load i8*, i8** %l2
  %t25 = call %InterfaceHeaderParse @parse_interface_header(i8* %t24)
  store %InterfaceHeaderParse %t25, %InterfaceHeaderParse* %l3
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t27 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t28 = extractvalue %InterfaceHeaderParse %t27, 2
  %t29 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t26, { i8**, i64 }* %t28)
  store { i8**, i64 }* %t29, { i8**, i64 }** %l0
  %t30 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t31 = extractvalue %InterfaceHeaderParse %t30, 0
  store i8* %t31, i8** %l4
  %t32 = load i8*, i8** %l4
  %t33 = call i64 @sailfin_runtime_string_length(i8* %t32)
  %t34 = icmp eq i64 %t33, 0
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t36 = load i8*, i8** %l1
  %t37 = load i8*, i8** %l2
  %t38 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t39 = load i8*, i8** %l4
  br i1 %t34, label %then0, label %merge1
then0:
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s41 = getelementptr inbounds [35 x i8], [35 x i8]* @.str.len34.h805939531, i32 0, i32 0
  %t42 = load i8*, i8** %l1
  %t43 = call i8* @sailfin_runtime_string_concat(i8* %s41, i8* %t42)
  %t44 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t40, i8* %t43)
  store { i8**, i64 }* %t44, { i8**, i64 }** %l0
  %t45 = bitcast i8* null to %NativeInterface*
  %t46 = insertvalue %InterfaceParseResult undef, %NativeInterface* %t45, 0
  %t47 = sitofp i64 1 to double
  %t48 = fadd double %start_index, %t47
  %t49 = insertvalue %InterfaceParseResult %t46, double %t48, 1
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t51 = insertvalue %InterfaceParseResult %t49, { i8**, i64 }* %t50, 2
  ret %InterfaceParseResult %t51
merge1:
  %t52 = getelementptr [0 x %NativeInterfaceSignature], [0 x %NativeInterfaceSignature]* null, i32 1
  %t53 = ptrtoint [0 x %NativeInterfaceSignature]* %t52 to i64
  %t54 = icmp eq i64 %t53, 0
  %t55 = select i1 %t54, i64 1, i64 %t53
  %t56 = call i8* @malloc(i64 %t55)
  %t57 = bitcast i8* %t56 to %NativeInterfaceSignature*
  %t58 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* null, i32 1
  %t59 = ptrtoint { %NativeInterfaceSignature*, i64 }* %t58 to i64
  %t60 = call i8* @malloc(i64 %t59)
  %t61 = bitcast i8* %t60 to { %NativeInterfaceSignature*, i64 }*
  %t62 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* %t61, i32 0, i32 0
  store %NativeInterfaceSignature* %t57, %NativeInterfaceSignature** %t62
  %t63 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* %t61, i32 0, i32 1
  store i64 0, i64* %t63
  store { %NativeInterfaceSignature*, i64 }* %t61, { %NativeInterfaceSignature*, i64 }** %l5
  %t64 = sitofp i64 1 to double
  %t65 = fadd double %start_index, %t64
  store double %t65, double* %l6
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t67 = load i8*, i8** %l1
  %t68 = load i8*, i8** %l2
  %t69 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t70 = load i8*, i8** %l4
  %t71 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t72 = load double, double* %l6
  br label %loop.header2
loop.header2:
  %t231 = phi { i8**, i64 }* [ %t66, %merge1 ], [ %t228, %loop.latch4 ]
  %t232 = phi double [ %t72, %merge1 ], [ %t229, %loop.latch4 ]
  %t233 = phi { %NativeInterfaceSignature*, i64 }* [ %t71, %merge1 ], [ %t230, %loop.latch4 ]
  store { i8**, i64 }* %t231, { i8**, i64 }** %l0
  store double %t232, double* %l6
  store { %NativeInterfaceSignature*, i64 }* %t233, { %NativeInterfaceSignature*, i64 }** %l5
  br label %loop.body3
loop.body3:
  %t73 = load double, double* %l6
  %t74 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t75 = extractvalue { i8**, i64 } %t74, 1
  %t76 = sitofp i64 %t75 to double
  %t77 = fcmp oge double %t73, %t76
  %t78 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t79 = load i8*, i8** %l1
  %t80 = load i8*, i8** %l2
  %t81 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t82 = load i8*, i8** %l4
  %t83 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t84 = load double, double* %l6
  br i1 %t77, label %then6, label %merge7
then6:
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s86 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.len23.h1564009733, i32 0, i32 0
  %t87 = load i8*, i8** %l4
  %t88 = call i8* @sailfin_runtime_string_concat(i8* %s86, i8* %t87)
  %t89 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t85, i8* %t88)
  store { i8**, i64 }* %t89, { i8**, i64 }** %l0
  %t90 = load i8*, i8** %l4
  %t91 = insertvalue %NativeInterface undef, i8* %t90, 0
  %t92 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t93 = extractvalue %InterfaceHeaderParse %t92, 1
  %t94 = insertvalue %NativeInterface %t91, { i8**, i64 }* %t93, 1
  %t95 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t96 = bitcast { %NativeInterfaceSignature*, i64 }* %t95 to { %NativeInterfaceSignature**, i64 }*
  %t97 = insertvalue %NativeInterface %t94, { %NativeInterfaceSignature**, i64 }* %t96, 2
  %t98 = alloca %NativeInterface
  store %NativeInterface %t97, %NativeInterface* %t98
  %t99 = insertvalue %InterfaceParseResult undef, %NativeInterface* %t98, 0
  %t100 = load double, double* %l6
  %t101 = insertvalue %InterfaceParseResult %t99, double %t100, 1
  %t102 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t103 = insertvalue %InterfaceParseResult %t101, { i8**, i64 }* %t102, 2
  ret %InterfaceParseResult %t103
merge7:
  %t104 = load double, double* %l6
  %t105 = fptosi double %t104 to i64
  %t106 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t107 = extractvalue { i8**, i64 } %t106, 0
  %t108 = extractvalue { i8**, i64 } %t106, 1
  %t109 = icmp uge i64 %t105, %t108
  ; bounds check: %t109 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t105, i64 %t108)
  %t110 = getelementptr i8*, i8** %t107, i64 %t105
  %t111 = load i8*, i8** %t110
  %t112 = call i8* @trim_text(i8* %t111)
  store i8* %t112, i8** %l7
  %t114 = load i8*, i8** %l7
  %t115 = call i64 @sailfin_runtime_string_length(i8* %t114)
  %t116 = icmp eq i64 %t115, 0
  br label %logical_or_entry_113

logical_or_entry_113:
  br i1 %t116, label %logical_or_merge_113, label %logical_or_right_113

logical_or_right_113:
  %t117 = load i8*, i8** %l7
  %t118 = alloca [2 x i8], align 1
  %t119 = getelementptr [2 x i8], [2 x i8]* %t118, i32 0, i32 0
  store i8 59, i8* %t119
  %t120 = getelementptr [2 x i8], [2 x i8]* %t118, i32 0, i32 1
  store i8 0, i8* %t120
  %t121 = getelementptr [2 x i8], [2 x i8]* %t118, i32 0, i32 0
  %t122 = call i1 @starts_with(i8* %t117, i8* %t121)
  br label %logical_or_right_end_113

logical_or_right_end_113:
  br label %logical_or_merge_113

logical_or_merge_113:
  %t123 = phi i1 [ true, %logical_or_entry_113 ], [ %t122, %logical_or_right_end_113 ]
  %t124 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t125 = load i8*, i8** %l1
  %t126 = load i8*, i8** %l2
  %t127 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t128 = load i8*, i8** %l4
  %t129 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t130 = load double, double* %l6
  %t131 = load i8*, i8** %l7
  br i1 %t123, label %then8, label %merge9
then8:
  %t132 = load double, double* %l6
  %t133 = sitofp i64 1 to double
  %t134 = fadd double %t132, %t133
  store double %t134, double* %l6
  br label %loop.latch4
merge9:
  %t135 = load i8*, i8** %l7
  %s136 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.len13.h1382830532, i32 0, i32 0
  %t137 = icmp eq i8* %t135, %s136
  %t138 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t139 = load i8*, i8** %l1
  %t140 = load i8*, i8** %l2
  %t141 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t142 = load i8*, i8** %l4
  %t143 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t144 = load double, double* %l6
  %t145 = load i8*, i8** %l7
  br i1 %t137, label %then10, label %merge11
then10:
  %t146 = load double, double* %l6
  %t147 = sitofp i64 1 to double
  %t148 = fadd double %t146, %t147
  store double %t148, double* %l6
  br label %afterloop5
merge11:
  %t149 = load i8*, i8** %l7
  %s150 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h268717223, i32 0, i32 0
  %t151 = icmp eq i8* %t149, %s150
  %t152 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t153 = load i8*, i8** %l1
  %t154 = load i8*, i8** %l2
  %t155 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t156 = load i8*, i8** %l4
  %t157 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t158 = load double, double* %l6
  %t159 = load i8*, i8** %l7
  br i1 %t151, label %then12, label %merge13
then12:
  %t160 = load double, double* %l6
  %t161 = sitofp i64 1 to double
  %t162 = fadd double %t160, %t161
  store double %t162, double* %l6
  br label %loop.latch4
merge13:
  %t163 = load i8*, i8** %l7
  %s164 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072555103, i32 0, i32 0
  %t165 = call i1 @starts_with(i8* %t163, i8* %s164)
  %t166 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t167 = load i8*, i8** %l1
  %t168 = load i8*, i8** %l2
  %t169 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t170 = load i8*, i8** %l4
  %t171 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t172 = load double, double* %l6
  %t173 = load i8*, i8** %l7
  br i1 %t165, label %then14, label %merge15
then14:
  %t174 = load i8*, i8** %l7
  %s175 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072555103, i32 0, i32 0
  %t176 = call i8* @strip_prefix(i8* %t174, i8* %s175)
  %t177 = load i8*, i8** %l4
  %t178 = call %InterfaceSignatureParse @parse_interface_signature(i8* %t176, i8* %t177)
  store %InterfaceSignatureParse %t178, %InterfaceSignatureParse* %l8
  %t179 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t180 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  %t181 = extractvalue %InterfaceSignatureParse %t180, 2
  %t182 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t179, { i8**, i64 }* %t181)
  store { i8**, i64 }* %t182, { i8**, i64 }** %l0
  %t183 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  %t184 = extractvalue %InterfaceSignatureParse %t183, 0
  %t185 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t186 = load i8*, i8** %l1
  %t187 = load i8*, i8** %l2
  %t188 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t189 = load i8*, i8** %l4
  %t190 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t191 = load double, double* %l6
  %t192 = load i8*, i8** %l7
  %t193 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  br i1 %t184, label %then16, label %merge17
then16:
  %t194 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t195 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  %t196 = extractvalue %InterfaceSignatureParse %t195, 1
  %t197 = call noalias i8* @malloc(i64 48)
  %t198 = bitcast i8* %t197 to %NativeInterfaceSignature*
  store %NativeInterfaceSignature %t196, %NativeInterfaceSignature* %t198
  %t199 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t200 = ptrtoint [1 x i8*]* %t199 to i64
  %t201 = icmp eq i64 %t200, 0
  %t202 = select i1 %t201, i64 1, i64 %t200
  %t203 = call i8* @malloc(i64 %t202)
  %t204 = bitcast i8* %t203 to i8**
  %t205 = getelementptr i8*, i8** %t204, i64 0
  store i8* %t197, i8** %t205
  %t206 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t207 = ptrtoint { i8**, i64 }* %t206 to i64
  %t208 = call i8* @malloc(i64 %t207)
  %t209 = bitcast i8* %t208 to { i8**, i64 }*
  %t210 = getelementptr { i8**, i64 }, { i8**, i64 }* %t209, i32 0, i32 0
  store i8** %t204, i8*** %t210
  %t211 = getelementptr { i8**, i64 }, { i8**, i64 }* %t209, i32 0, i32 1
  store i64 1, i64* %t211
  %t212 = bitcast { %NativeInterfaceSignature*, i64 }* %t194 to { i8**, i64 }*
  %t213 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t212, { i8**, i64 }* %t209)
  %t214 = bitcast { i8**, i64 }* %t213 to { %NativeInterfaceSignature*, i64 }*
  store { %NativeInterfaceSignature*, i64 }* %t214, { %NativeInterfaceSignature*, i64 }** %l5
  %t215 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  br label %merge17
merge17:
  %t216 = phi { %NativeInterfaceSignature*, i64 }* [ %t215, %then16 ], [ %t190, %then14 ]
  store { %NativeInterfaceSignature*, i64 }* %t216, { %NativeInterfaceSignature*, i64 }** %l5
  %t217 = load double, double* %l6
  %t218 = sitofp i64 1 to double
  %t219 = fadd double %t217, %t218
  store double %t219, double* %l6
  br label %loop.latch4
merge15:
  %t220 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s221 = getelementptr inbounds [34 x i8], [34 x i8]* @.str.len33.h1134984829, i32 0, i32 0
  %t222 = load i8*, i8** %l7
  %t223 = call i8* @sailfin_runtime_string_concat(i8* %s221, i8* %t222)
  %t224 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t220, i8* %t223)
  store { i8**, i64 }* %t224, { i8**, i64 }** %l0
  %t225 = load double, double* %l6
  %t226 = sitofp i64 1 to double
  %t227 = fadd double %t225, %t226
  store double %t227, double* %l6
  br label %loop.latch4
loop.latch4:
  %t228 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t229 = load double, double* %l6
  %t230 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  br label %loop.header2
afterloop5:
  %t234 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t235 = load double, double* %l6
  %t236 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t237 = load i8*, i8** %l4
  %t238 = insertvalue %NativeInterface undef, i8* %t237, 0
  %t239 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t240 = extractvalue %InterfaceHeaderParse %t239, 1
  %t241 = insertvalue %NativeInterface %t238, { i8**, i64 }* %t240, 1
  %t242 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t243 = bitcast { %NativeInterfaceSignature*, i64 }* %t242 to { %NativeInterfaceSignature**, i64 }*
  %t244 = insertvalue %NativeInterface %t241, { %NativeInterfaceSignature**, i64 }* %t243, 2
  %t245 = alloca %NativeInterface
  store %NativeInterface %t244, %NativeInterface* %t245
  %t246 = insertvalue %InterfaceParseResult undef, %NativeInterface* %t245, 0
  %t247 = load double, double* %l6
  %t248 = insertvalue %InterfaceParseResult %t246, double %t247, 1
  %t249 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t250 = insertvalue %InterfaceParseResult %t248, { i8**, i64 }* %t249, 2
  ret %InterfaceParseResult %t250
}

define %StructHeaderParse @parse_struct_header(i8* %text) {
block.entry:
  %l0 = alloca %HeaderNameParse
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca i8*
  %t0 = call %HeaderNameParse @parse_header_name_and_remainder(i8* %text)
  store %HeaderNameParse %t0, %HeaderNameParse* %l0
  %t1 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t2 = extractvalue %HeaderNameParse %t1, 3
  store { i8**, i64 }* %t2, { i8**, i64 }** %l1
  %t3 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t4 = ptrtoint [0 x i8*]* %t3 to i64
  %t5 = icmp eq i64 %t4, 0
  %t6 = select i1 %t5, i64 1, i64 %t4
  %t7 = call i8* @malloc(i64 %t6)
  %t8 = bitcast i8* %t7 to i8**
  %t9 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t10 = ptrtoint { i8**, i64 }* %t9 to i64
  %t11 = call i8* @malloc(i64 %t10)
  %t12 = bitcast i8* %t11 to { i8**, i64 }*
  %t13 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 0
  store i8** %t8, i8*** %t13
  %t14 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 1
  store i64 0, i64* %t14
  store { i8**, i64 }* %t12, { i8**, i64 }** %l2
  %t15 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t16 = extractvalue %HeaderNameParse %t15, 2
  %t17 = call i64 @sailfin_runtime_string_length(i8* %t16)
  %t18 = icmp sgt i64 %t17, 0
  %t19 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t18, label %then0, label %merge1
then0:
  %t22 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t23 = extractvalue %HeaderNameParse %t22, 2
  %s24 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h908744813, i32 0, i32 0
  %t25 = call i1 @starts_with(i8* %t23, i8* %s24)
  %t26 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t25, label %then2, label %else3
then2:
  %t29 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t30 = extractvalue %HeaderNameParse %t29, 2
  %s31 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h908744813, i32 0, i32 0
  %t32 = call i8* @strip_prefix(i8* %t30, i8* %s31)
  %t33 = call i8* @trim_text(i8* %t32)
  store i8* %t33, i8** %l3
  %t34 = load i8*, i8** %l3
  %t35 = call i64 @sailfin_runtime_string_length(i8* %t34)
  %t36 = icmp eq i64 %t35, 0
  %t37 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t40 = load i8*, i8** %l3
  br i1 %t36, label %then5, label %else6
then5:
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s42 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t43 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t44 = extractvalue %HeaderNameParse %t43, 0
  %t45 = call i8* @sailfin_runtime_string_concat(i8* %s42, i8* %t44)
  %s46 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.len31.h1868156648, i32 0, i32 0
  %t47 = call i8* @sailfin_runtime_string_concat(i8* %t45, i8* %s46)
  %t48 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t41, i8* %t47)
  store { i8**, i64 }* %t48, { i8**, i64 }** %l1
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge7
else6:
  %t50 = load i8*, i8** %l3
  %t51 = call { i8**, i64 }* @parse_implements_list(i8* %t50)
  store { i8**, i64 }* %t51, { i8**, i64 }** %l2
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br label %merge7
merge7:
  %t53 = phi { i8**, i64 }* [ %t49, %then5 ], [ %t38, %else6 ]
  %t54 = phi { i8**, i64 }* [ %t39, %then5 ], [ %t52, %else6 ]
  store { i8**, i64 }* %t53, { i8**, i64 }** %l1
  store { i8**, i64 }* %t54, { i8**, i64 }** %l2
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br label %merge4
else3:
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s58 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t59 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t60 = extractvalue %HeaderNameParse %t59, 0
  %t61 = call i8* @sailfin_runtime_string_concat(i8* %s58, i8* %t60)
  %s62 = getelementptr inbounds [34 x i8], [34 x i8]* @.str.len33.h1132321576, i32 0, i32 0
  %t63 = call i8* @sailfin_runtime_string_concat(i8* %t61, i8* %s62)
  %t64 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t65 = extractvalue %HeaderNameParse %t64, 2
  %t66 = call i8* @sailfin_runtime_string_concat(i8* %t63, i8* %t65)
  %t67 = alloca [2 x i8], align 1
  %t68 = getelementptr [2 x i8], [2 x i8]* %t67, i32 0, i32 0
  store i8 96, i8* %t68
  %t69 = getelementptr [2 x i8], [2 x i8]* %t67, i32 0, i32 1
  store i8 0, i8* %t69
  %t70 = getelementptr [2 x i8], [2 x i8]* %t67, i32 0, i32 0
  %t71 = call i8* @sailfin_runtime_string_concat(i8* %t66, i8* %t70)
  %t72 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t57, i8* %t71)
  store { i8**, i64 }* %t72, { i8**, i64 }** %l1
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge4
merge4:
  %t74 = phi { i8**, i64 }* [ %t55, %merge7 ], [ %t73, %else3 ]
  %t75 = phi { i8**, i64 }* [ %t56, %merge7 ], [ %t28, %else3 ]
  store { i8**, i64 }* %t74, { i8**, i64 }** %l1
  store { i8**, i64 }* %t75, { i8**, i64 }** %l2
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t77 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t78 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge1
merge1:
  %t79 = phi { i8**, i64 }* [ %t76, %merge4 ], [ %t20, %block.entry ]
  %t80 = phi { i8**, i64 }* [ %t77, %merge4 ], [ %t21, %block.entry ]
  %t81 = phi { i8**, i64 }* [ %t78, %merge4 ], [ %t20, %block.entry ]
  store { i8**, i64 }* %t79, { i8**, i64 }** %l1
  store { i8**, i64 }* %t80, { i8**, i64 }** %l2
  store { i8**, i64 }* %t81, { i8**, i64 }** %l1
  %t82 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t83 = extractvalue %HeaderNameParse %t82, 0
  %t84 = insertvalue %StructHeaderParse undef, i8* %t83, 0
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t86 = insertvalue %StructHeaderParse %t84, { i8**, i64 }* %t85, 1
  %t87 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t88 = insertvalue %StructHeaderParse %t86, { i8**, i64 }* %t87, 2
  ret %StructHeaderParse %t88
}

define %InterfaceHeaderParse @parse_interface_header(i8* %text) {
block.entry:
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
  %s10 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h385719500, i32 0, i32 0
  %t11 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t12 = extractvalue %HeaderNameParse %t11, 0
  %t13 = call i8* @sailfin_runtime_string_concat(i8* %s10, i8* %t12)
  %s14 = getelementptr inbounds [34 x i8], [34 x i8]* @.str.len33.h1132321576, i32 0, i32 0
  %t15 = call i8* @sailfin_runtime_string_concat(i8* %t13, i8* %s14)
  %t16 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t17 = extractvalue %HeaderNameParse %t16, 2
  %t18 = call i8* @sailfin_runtime_string_concat(i8* %t15, i8* %t17)
  %t19 = alloca [2 x i8], align 1
  %t20 = getelementptr [2 x i8], [2 x i8]* %t19, i32 0, i32 0
  store i8 96, i8* %t20
  %t21 = getelementptr [2 x i8], [2 x i8]* %t19, i32 0, i32 1
  store i8 0, i8* %t21
  %t22 = getelementptr [2 x i8], [2 x i8]* %t19, i32 0, i32 0
  %t23 = call i8* @sailfin_runtime_string_concat(i8* %t18, i8* %t22)
  %t24 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t9, i8* %t23)
  store { i8**, i64 }* %t24, { i8**, i64 }** %l1
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge1
merge1:
  %t26 = phi { i8**, i64 }* [ %t25, %then0 ], [ %t8, %block.entry ]
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
block.entry:
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
  %t0 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t1 = ptrtoint [0 x i8*]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to i8**
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t7 = ptrtoint { i8**, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { i8**, i64 }*
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 0
  store i8** %t5, i8*** %t10
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { i8**, i64 }* %t9, { i8**, i64 }** %l0
  %s12 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t13 = insertvalue %NativeInterfaceSignature undef, i8* %s12, 0
  %t14 = insertvalue %NativeInterfaceSignature %t13, i1 0, 1
  %t15 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t16 = ptrtoint [0 x i8*]* %t15 to i64
  %t17 = icmp eq i64 %t16, 0
  %t18 = select i1 %t17, i64 1, i64 %t16
  %t19 = call i8* @malloc(i64 %t18)
  %t20 = bitcast i8* %t19 to i8**
  %t21 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t22 = ptrtoint { i8**, i64 }* %t21 to i64
  %t23 = call i8* @malloc(i64 %t22)
  %t24 = bitcast i8* %t23 to { i8**, i64 }*
  %t25 = getelementptr { i8**, i64 }, { i8**, i64 }* %t24, i32 0, i32 0
  store i8** %t20, i8*** %t25
  %t26 = getelementptr { i8**, i64 }, { i8**, i64 }* %t24, i32 0, i32 1
  store i64 0, i64* %t26
  %t27 = insertvalue %NativeInterfaceSignature %t14, { i8**, i64 }* %t24, 2
  %t28 = getelementptr [0 x %NativeParameter*], [0 x %NativeParameter*]* null, i32 1
  %t29 = ptrtoint [0 x %NativeParameter*]* %t28 to i64
  %t30 = icmp eq i64 %t29, 0
  %t31 = select i1 %t30, i64 1, i64 %t29
  %t32 = call i8* @malloc(i64 %t31)
  %t33 = bitcast i8* %t32 to %NativeParameter**
  %t34 = getelementptr { %NativeParameter**, i64 }, { %NativeParameter**, i64 }* null, i32 1
  %t35 = ptrtoint { %NativeParameter**, i64 }* %t34 to i64
  %t36 = call i8* @malloc(i64 %t35)
  %t37 = bitcast i8* %t36 to { %NativeParameter**, i64 }*
  %t38 = getelementptr { %NativeParameter**, i64 }, { %NativeParameter**, i64 }* %t37, i32 0, i32 0
  store %NativeParameter** %t33, %NativeParameter*** %t38
  %t39 = getelementptr { %NativeParameter**, i64 }, { %NativeParameter**, i64 }* %t37, i32 0, i32 1
  store i64 0, i64* %t39
  %t40 = insertvalue %NativeInterfaceSignature %t27, { %NativeParameter**, i64 }* %t37, 3
  %s41 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h278197661, i32 0, i32 0
  %t42 = insertvalue %NativeInterfaceSignature %t40, i8* %s41, 4
  %t43 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t44 = ptrtoint [0 x i8*]* %t43 to i64
  %t45 = icmp eq i64 %t44, 0
  %t46 = select i1 %t45, i64 1, i64 %t44
  %t47 = call i8* @malloc(i64 %t46)
  %t48 = bitcast i8* %t47 to i8**
  %t49 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t50 = ptrtoint { i8**, i64 }* %t49 to i64
  %t51 = call i8* @malloc(i64 %t50)
  %t52 = bitcast i8* %t51 to { i8**, i64 }*
  %t53 = getelementptr { i8**, i64 }, { i8**, i64 }* %t52, i32 0, i32 0
  store i8** %t48, i8*** %t53
  %t54 = getelementptr { i8**, i64 }, { i8**, i64 }* %t52, i32 0, i32 1
  store i64 0, i64* %t54
  %t55 = insertvalue %NativeInterfaceSignature %t42, { i8**, i64 }* %t52, 5
  store %NativeInterfaceSignature %t55, %NativeInterfaceSignature* %l1
  %t56 = call i8* @trim_text(i8* %text)
  %t57 = call i8* @trim_trailing_delimiters(i8* %t56)
  store i8* %t57, i8** %l2
  %t58 = load i8*, i8** %l2
  %t59 = call i64 @sailfin_runtime_string_length(i8* %t58)
  %t60 = icmp eq i64 %t59, 0
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t62 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t63 = load i8*, i8** %l2
  br i1 %t60, label %then0, label %merge1
then0:
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s65 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h385719500, i32 0, i32 0
  %t66 = call i8* @sailfin_runtime_string_concat(i8* %s65, i8* %interface_name)
  %s67 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.len26.h1834305347, i32 0, i32 0
  %t68 = call i8* @sailfin_runtime_string_concat(i8* %t66, i8* %s67)
  %t69 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t64, i8* %t68)
  store { i8**, i64 }* %t69, { i8**, i64 }** %l0
  %t70 = insertvalue %InterfaceSignatureParse undef, i1 0, 0
  %t71 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t72 = insertvalue %InterfaceSignatureParse %t70, %NativeInterfaceSignature %t71, 1
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t74 = insertvalue %InterfaceSignatureParse %t72, { i8**, i64 }* %t73, 2
  ret %InterfaceSignatureParse %t74
merge1:
  %t75 = load i8*, i8** %l2
  store i8* %t75, i8** %l3
  store i1 0, i1* %l4
  %t76 = load i8*, i8** %l3
  %s77 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1134498859, i32 0, i32 0
  %t78 = call i1 @starts_with(i8* %t76, i8* %s77)
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t80 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t81 = load i8*, i8** %l2
  %t82 = load i8*, i8** %l3
  %t83 = load i1, i1* %l4
  br i1 %t78, label %then2, label %merge3
then2:
  store i1 1, i1* %l4
  %t84 = load i8*, i8** %l3
  %s85 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1134498859, i32 0, i32 0
  %t86 = call i8* @strip_prefix(i8* %t84, i8* %s85)
  %t87 = call i8* @trim_text(i8* %t86)
  store i8* %t87, i8** %l3
  %t88 = load i1, i1* %l4
  %t89 = load i8*, i8** %l3
  br label %merge3
merge3:
  %t90 = phi i1 [ %t88, %then2 ], [ %t83, %merge1 ]
  %t91 = phi i8* [ %t89, %then2 ], [ %t82, %merge1 ]
  store i1 %t90, i1* %l4
  store i8* %t91, i8** %l3
  %t92 = load i8*, i8** %l3
  %t93 = alloca [2 x i8], align 1
  %t94 = getelementptr [2 x i8], [2 x i8]* %t93, i32 0, i32 0
  store i8 40, i8* %t94
  %t95 = getelementptr [2 x i8], [2 x i8]* %t93, i32 0, i32 1
  store i8 0, i8* %t95
  %t96 = getelementptr [2 x i8], [2 x i8]* %t93, i32 0, i32 0
  %t97 = call double @index_of(i8* %t92, i8* %t96)
  store double %t97, double* %l5
  %t98 = load double, double* %l5
  %t99 = sitofp i64 0 to double
  %t100 = fcmp olt double %t98, %t99
  %t101 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t102 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t103 = load i8*, i8** %l2
  %t104 = load i8*, i8** %l3
  %t105 = load i1, i1* %l4
  %t106 = load double, double* %l5
  br i1 %t100, label %then4, label %merge5
then4:
  %t107 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s108 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h385719500, i32 0, i32 0
  %t109 = call i8* @sailfin_runtime_string_concat(i8* %s108, i8* %interface_name)
  %s110 = getelementptr inbounds [36 x i8], [36 x i8]* @.str.len35.h546841458, i32 0, i32 0
  %t111 = call i8* @sailfin_runtime_string_concat(i8* %t109, i8* %s110)
  %t112 = load i8*, i8** %l2
  %t113 = call i8* @sailfin_runtime_string_concat(i8* %t111, i8* %t112)
  %t114 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t107, i8* %t113)
  store { i8**, i64 }* %t114, { i8**, i64 }** %l0
  %t115 = insertvalue %InterfaceSignatureParse undef, i1 0, 0
  %t116 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t117 = insertvalue %InterfaceSignatureParse %t115, %NativeInterfaceSignature %t116, 1
  %t118 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t119 = insertvalue %InterfaceSignatureParse %t117, { i8**, i64 }* %t118, 2
  ret %InterfaceSignatureParse %t119
merge5:
  %t120 = load i8*, i8** %l3
  %t121 = load double, double* %l5
  %t122 = call double @find_matching_paren(i8* %t120, double %t121)
  store double %t122, double* %l6
  %t123 = load double, double* %l6
  %t124 = sitofp i64 0 to double
  %t125 = fcmp olt double %t123, %t124
  %t126 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t127 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t128 = load i8*, i8** %l2
  %t129 = load i8*, i8** %l3
  %t130 = load i1, i1* %l4
  %t131 = load double, double* %l5
  %t132 = load double, double* %l6
  br i1 %t125, label %then6, label %merge7
then6:
  %t133 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s134 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h385719500, i32 0, i32 0
  %t135 = call i8* @sailfin_runtime_string_concat(i8* %s134, i8* %interface_name)
  %s136 = getelementptr inbounds [45 x i8], [45 x i8]* @.str.len44.h1730891783, i32 0, i32 0
  %t137 = call i8* @sailfin_runtime_string_concat(i8* %t135, i8* %s136)
  %t138 = load i8*, i8** %l2
  %t139 = call i8* @sailfin_runtime_string_concat(i8* %t137, i8* %t138)
  %t140 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t133, i8* %t139)
  store { i8**, i64 }* %t140, { i8**, i64 }** %l0
  %t141 = insertvalue %InterfaceSignatureParse undef, i1 0, 0
  %t142 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t143 = insertvalue %InterfaceSignatureParse %t141, %NativeInterfaceSignature %t142, 1
  %t144 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t145 = insertvalue %InterfaceSignatureParse %t143, { i8**, i64 }* %t144, 2
  ret %InterfaceSignatureParse %t145
merge7:
  %t146 = load i8*, i8** %l3
  %t147 = load double, double* %l5
  %t148 = fptosi double %t147 to i64
  %t149 = call i8* @sailfin_runtime_substring(i8* %t146, i64 0, i64 %t148)
  %t150 = call i8* @trim_text(i8* %t149)
  store i8* %t150, i8** %l7
  %t151 = load i8*, i8** %l7
  %t152 = call %HeaderNameParse @parse_header_name_and_remainder(i8* %t151)
  store %HeaderNameParse %t152, %HeaderNameParse* %l8
  %t153 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t154 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t155 = extractvalue %HeaderNameParse %t154, 3
  %t156 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t153, { i8**, i64 }* %t155)
  store { i8**, i64 }* %t156, { i8**, i64 }** %l0
  %t157 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t158 = extractvalue %HeaderNameParse %t157, 2
  %t159 = call i64 @sailfin_runtime_string_length(i8* %t158)
  %t160 = icmp sgt i64 %t159, 0
  %t161 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t162 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t163 = load i8*, i8** %l2
  %t164 = load i8*, i8** %l3
  %t165 = load i1, i1* %l4
  %t166 = load double, double* %l5
  %t167 = load double, double* %l6
  %t168 = load i8*, i8** %l7
  %t169 = load %HeaderNameParse, %HeaderNameParse* %l8
  br i1 %t160, label %then8, label %merge9
then8:
  %t170 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s171 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h385719500, i32 0, i32 0
  %t172 = call i8* @sailfin_runtime_string_concat(i8* %s171, i8* %interface_name)
  %s173 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h841153022, i32 0, i32 0
  %t174 = call i8* @sailfin_runtime_string_concat(i8* %t172, i8* %s173)
  %t175 = load i8*, i8** %l2
  %t176 = call i8* @sailfin_runtime_string_concat(i8* %t174, i8* %t175)
  %s177 = getelementptr inbounds [28 x i8], [28 x i8]* @.str.len27.h237652301, i32 0, i32 0
  %t178 = call i8* @sailfin_runtime_string_concat(i8* %t176, i8* %s177)
  %t179 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t180 = extractvalue %HeaderNameParse %t179, 2
  %t181 = call i8* @sailfin_runtime_string_concat(i8* %t178, i8* %t180)
  %t182 = alloca [2 x i8], align 1
  %t183 = getelementptr [2 x i8], [2 x i8]* %t182, i32 0, i32 0
  store i8 96, i8* %t183
  %t184 = getelementptr [2 x i8], [2 x i8]* %t182, i32 0, i32 1
  store i8 0, i8* %t184
  %t185 = getelementptr [2 x i8], [2 x i8]* %t182, i32 0, i32 0
  %t186 = call i8* @sailfin_runtime_string_concat(i8* %t181, i8* %t185)
  %t187 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t170, i8* %t186)
  store { i8**, i64 }* %t187, { i8**, i64 }** %l0
  %t188 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge9
merge9:
  %t189 = phi { i8**, i64 }* [ %t188, %then8 ], [ %t161, %merge7 ]
  store { i8**, i64 }* %t189, { i8**, i64 }** %l0
  %t190 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t191 = extractvalue %HeaderNameParse %t190, 0
  store i8* %t191, i8** %l9
  %t192 = load i8*, i8** %l9
  %t193 = call i64 @sailfin_runtime_string_length(i8* %t192)
  %t194 = icmp eq i64 %t193, 0
  %t195 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t196 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t197 = load i8*, i8** %l2
  %t198 = load i8*, i8** %l3
  %t199 = load i1, i1* %l4
  %t200 = load double, double* %l5
  %t201 = load double, double* %l6
  %t202 = load i8*, i8** %l7
  %t203 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t204 = load i8*, i8** %l9
  br i1 %t194, label %then10, label %merge11
then10:
  %t205 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s206 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h385719500, i32 0, i32 0
  %t207 = call i8* @sailfin_runtime_string_concat(i8* %s206, i8* %interface_name)
  %s208 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h841153022, i32 0, i32 0
  %t209 = call i8* @sailfin_runtime_string_concat(i8* %t207, i8* %s208)
  %t210 = load i8*, i8** %l2
  %t211 = call i8* @sailfin_runtime_string_concat(i8* %t209, i8* %t210)
  %s212 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h1219450488, i32 0, i32 0
  %t213 = call i8* @sailfin_runtime_string_concat(i8* %t211, i8* %s212)
  %t214 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t205, i8* %t213)
  store { i8**, i64 }* %t214, { i8**, i64 }** %l0
  %t215 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge11
merge11:
  %t216 = phi { i8**, i64 }* [ %t215, %then10 ], [ %t195, %merge9 ]
  store { i8**, i64 }* %t216, { i8**, i64 }** %l0
  %t217 = load i8*, i8** %l3
  %t218 = load double, double* %l5
  %t219 = sitofp i64 1 to double
  %t220 = fadd double %t218, %t219
  %t221 = load double, double* %l6
  %t222 = fptosi double %t220 to i64
  %t223 = fptosi double %t221 to i64
  %t224 = call i8* @sailfin_runtime_substring(i8* %t217, i64 %t222, i64 %t223)
  store i8* %t224, i8** %l10
  %t225 = getelementptr [0 x %NativeParameter], [0 x %NativeParameter]* null, i32 1
  %t226 = ptrtoint [0 x %NativeParameter]* %t225 to i64
  %t227 = icmp eq i64 %t226, 0
  %t228 = select i1 %t227, i64 1, i64 %t226
  %t229 = call i8* @malloc(i64 %t228)
  %t230 = bitcast i8* %t229 to %NativeParameter*
  %t231 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* null, i32 1
  %t232 = ptrtoint { %NativeParameter*, i64 }* %t231 to i64
  %t233 = call i8* @malloc(i64 %t232)
  %t234 = bitcast i8* %t233 to { %NativeParameter*, i64 }*
  %t235 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %t234, i32 0, i32 0
  store %NativeParameter* %t230, %NativeParameter** %t235
  %t236 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %t234, i32 0, i32 1
  store i64 0, i64* %t236
  store { %NativeParameter*, i64 }* %t234, { %NativeParameter*, i64 }** %l11
  %t237 = load i8*, i8** %l10
  %t238 = call i8* @trim_text(i8* %t237)
  store i8* %t238, i8** %l12
  %t239 = load i8*, i8** %l12
  %t240 = call i64 @sailfin_runtime_string_length(i8* %t239)
  %t241 = icmp sgt i64 %t240, 0
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
  br i1 %t241, label %then12, label %merge13
then12:
  %t255 = load i8*, i8** %l12
  %t256 = call { i8**, i64 }* @split_parameter_entries(i8* %t255)
  store { i8**, i64 }* %t256, { i8**, i64 }** %l13
  %t257 = sitofp i64 0 to double
  store double %t257, double* %l14
  %t258 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t259 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t260 = load i8*, i8** %l2
  %t261 = load i8*, i8** %l3
  %t262 = load i1, i1* %l4
  %t263 = load double, double* %l5
  %t264 = load double, double* %l6
  %t265 = load i8*, i8** %l7
  %t266 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t267 = load i8*, i8** %l9
  %t268 = load i8*, i8** %l10
  %t269 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t270 = load i8*, i8** %l12
  %t271 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t272 = load double, double* %l14
  br label %loop.header14
loop.header14:
  %t362 = phi { i8**, i64 }* [ %t258, %then12 ], [ %t359, %loop.latch16 ]
  %t363 = phi { %NativeParameter*, i64 }* [ %t269, %then12 ], [ %t360, %loop.latch16 ]
  %t364 = phi double [ %t272, %then12 ], [ %t361, %loop.latch16 ]
  store { i8**, i64 }* %t362, { i8**, i64 }** %l0
  store { %NativeParameter*, i64 }* %t363, { %NativeParameter*, i64 }** %l11
  store double %t364, double* %l14
  br label %loop.body15
loop.body15:
  %t273 = load double, double* %l14
  %t274 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t275 = load { i8**, i64 }, { i8**, i64 }* %t274
  %t276 = extractvalue { i8**, i64 } %t275, 1
  %t277 = sitofp i64 %t276 to double
  %t278 = fcmp oge double %t273, %t277
  %t279 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t280 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t281 = load i8*, i8** %l2
  %t282 = load i8*, i8** %l3
  %t283 = load i1, i1* %l4
  %t284 = load double, double* %l5
  %t285 = load double, double* %l6
  %t286 = load i8*, i8** %l7
  %t287 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t288 = load i8*, i8** %l9
  %t289 = load i8*, i8** %l10
  %t290 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t291 = load i8*, i8** %l12
  %t292 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t293 = load double, double* %l14
  br i1 %t278, label %then18, label %merge19
then18:
  br label %afterloop17
merge19:
  %t294 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t295 = load double, double* %l14
  %t296 = fptosi double %t295 to i64
  %t297 = load { i8**, i64 }, { i8**, i64 }* %t294
  %t298 = extractvalue { i8**, i64 } %t297, 0
  %t299 = extractvalue { i8**, i64 } %t297, 1
  %t300 = icmp uge i64 %t296, %t299
  ; bounds check: %t300 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t296, i64 %t299)
  %t301 = getelementptr i8*, i8** %t298, i64 %t296
  %t302 = load i8*, i8** %t301
  %t303 = bitcast i8* null to %NativeSourceSpan*
  %t304 = call %NativeParameter* @parse_parameter_entry(i8* %t302, %NativeSourceSpan* %t303)
  store %NativeParameter* %t304, %NativeParameter** %l15
  %t305 = load %NativeParameter*, %NativeParameter** %l15
  %t306 = icmp eq %NativeParameter* %t305, null
  %t307 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t308 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t309 = load i8*, i8** %l2
  %t310 = load i8*, i8** %l3
  %t311 = load i1, i1* %l4
  %t312 = load double, double* %l5
  %t313 = load double, double* %l6
  %t314 = load i8*, i8** %l7
  %t315 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t316 = load i8*, i8** %l9
  %t317 = load i8*, i8** %l10
  %t318 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t319 = load i8*, i8** %l12
  %t320 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t321 = load double, double* %l14
  %t322 = load %NativeParameter*, %NativeParameter** %l15
  br i1 %t306, label %then20, label %else21
then20:
  %t323 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s324 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h385719500, i32 0, i32 0
  %t325 = call i8* @sailfin_runtime_string_concat(i8* %s324, i8* %interface_name)
  %s326 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h841153022, i32 0, i32 0
  %t327 = call i8* @sailfin_runtime_string_concat(i8* %t325, i8* %s326)
  %t328 = load i8*, i8** %l9
  %t329 = call i8* @sailfin_runtime_string_concat(i8* %t327, i8* %t328)
  %s330 = getelementptr inbounds [26 x i8], [26 x i8]* @.str.len25.h378946335, i32 0, i32 0
  %t331 = call i8* @sailfin_runtime_string_concat(i8* %t329, i8* %s330)
  %t332 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t333 = load double, double* %l14
  %t334 = fptosi double %t333 to i64
  %t335 = load { i8**, i64 }, { i8**, i64 }* %t332
  %t336 = extractvalue { i8**, i64 } %t335, 0
  %t337 = extractvalue { i8**, i64 } %t335, 1
  %t338 = icmp uge i64 %t334, %t337
  ; bounds check: %t338 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t334, i64 %t337)
  %t339 = getelementptr i8*, i8** %t336, i64 %t334
  %t340 = load i8*, i8** %t339
  %t341 = call i8* @sailfin_runtime_string_concat(i8* %t331, i8* %t340)
  %t342 = alloca [2 x i8], align 1
  %t343 = getelementptr [2 x i8], [2 x i8]* %t342, i32 0, i32 0
  store i8 96, i8* %t343
  %t344 = getelementptr [2 x i8], [2 x i8]* %t342, i32 0, i32 1
  store i8 0, i8* %t344
  %t345 = getelementptr [2 x i8], [2 x i8]* %t342, i32 0, i32 0
  %t346 = call i8* @sailfin_runtime_string_concat(i8* %t341, i8* %t345)
  %t347 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t323, i8* %t346)
  store { i8**, i64 }* %t347, { i8**, i64 }** %l0
  %t348 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge22
else21:
  %t349 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t350 = load %NativeParameter*, %NativeParameter** %l15
  %t351 = load %NativeParameter, %NativeParameter* %t350
  %t352 = call { %NativeParameter*, i64 }* @append_parameter_array({ %NativeParameter*, i64 }* %t349, %NativeParameter %t351)
  store { %NativeParameter*, i64 }* %t352, { %NativeParameter*, i64 }** %l11
  %t353 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  br label %merge22
merge22:
  %t354 = phi { i8**, i64 }* [ %t348, %then20 ], [ %t307, %else21 ]
  %t355 = phi { %NativeParameter*, i64 }* [ %t318, %then20 ], [ %t353, %else21 ]
  store { i8**, i64 }* %t354, { i8**, i64 }** %l0
  store { %NativeParameter*, i64 }* %t355, { %NativeParameter*, i64 }** %l11
  %t356 = load double, double* %l14
  %t357 = sitofp i64 1 to double
  %t358 = fadd double %t356, %t357
  store double %t358, double* %l14
  br label %loop.latch16
loop.latch16:
  %t359 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t360 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t361 = load double, double* %l14
  br label %loop.header14
afterloop17:
  %t365 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t366 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t367 = load double, double* %l14
  %t368 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t369 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  br label %merge13
merge13:
  %t370 = phi { i8**, i64 }* [ %t368, %afterloop17 ], [ %t242, %merge11 ]
  %t371 = phi { %NativeParameter*, i64 }* [ %t369, %afterloop17 ], [ %t253, %merge11 ]
  store { i8**, i64 }* %t370, { i8**, i64 }** %l0
  store { %NativeParameter*, i64 }* %t371, { %NativeParameter*, i64 }** %l11
  %s372 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h278197661, i32 0, i32 0
  store i8* %s372, i8** %l16
  %t373 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t374 = ptrtoint [0 x i8*]* %t373 to i64
  %t375 = icmp eq i64 %t374, 0
  %t376 = select i1 %t375, i64 1, i64 %t374
  %t377 = call i8* @malloc(i64 %t376)
  %t378 = bitcast i8* %t377 to i8**
  %t379 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t380 = ptrtoint { i8**, i64 }* %t379 to i64
  %t381 = call i8* @malloc(i64 %t380)
  %t382 = bitcast i8* %t381 to { i8**, i64 }*
  %t383 = getelementptr { i8**, i64 }, { i8**, i64 }* %t382, i32 0, i32 0
  store i8** %t378, i8*** %t383
  %t384 = getelementptr { i8**, i64 }, { i8**, i64 }* %t382, i32 0, i32 1
  store i64 0, i64* %t384
  store { i8**, i64 }* %t382, { i8**, i64 }** %l17
  %t385 = load i8*, i8** %l3
  %t386 = load double, double* %l6
  %t387 = sitofp i64 1 to double
  %t388 = fadd double %t386, %t387
  %t389 = load i8*, i8** %l3
  %t390 = call i64 @sailfin_runtime_string_length(i8* %t389)
  %t391 = fptosi double %t388 to i64
  %t392 = call i8* @sailfin_runtime_substring(i8* %t385, i64 %t391, i64 %t390)
  %t393 = call i8* @trim_text(i8* %t392)
  store i8* %t393, i8** %l18
  %t394 = load i8*, i8** %l18
  %t395 = call i64 @sailfin_runtime_string_length(i8* %t394)
  %t396 = icmp sgt i64 %t395, 0
  %t397 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t398 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t399 = load i8*, i8** %l2
  %t400 = load i8*, i8** %l3
  %t401 = load i1, i1* %l4
  %t402 = load double, double* %l5
  %t403 = load double, double* %l6
  %t404 = load i8*, i8** %l7
  %t405 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t406 = load i8*, i8** %l9
  %t407 = load i8*, i8** %l10
  %t408 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t409 = load i8*, i8** %l12
  %t410 = load i8*, i8** %l16
  %t411 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t412 = load i8*, i8** %l18
  br i1 %t396, label %then23, label %merge24
then23:
  %t413 = load i8*, i8** %l18
  %s414 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193415939, i32 0, i32 0
  %t415 = call double @index_of(i8* %t413, i8* %s414)
  store double %t415, double* %l19
  %s416 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s416, i8** %l20
  %t417 = load double, double* %l19
  %t418 = sitofp i64 0 to double
  %t419 = fcmp oge double %t417, %t418
  %t420 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t421 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t422 = load i8*, i8** %l2
  %t423 = load i8*, i8** %l3
  %t424 = load i1, i1* %l4
  %t425 = load double, double* %l5
  %t426 = load double, double* %l6
  %t427 = load i8*, i8** %l7
  %t428 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t429 = load i8*, i8** %l9
  %t430 = load i8*, i8** %l10
  %t431 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t432 = load i8*, i8** %l12
  %t433 = load i8*, i8** %l16
  %t434 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t435 = load i8*, i8** %l18
  %t436 = load double, double* %l19
  %t437 = load i8*, i8** %l20
  br i1 %t419, label %then25, label %merge26
then25:
  %t438 = load i8*, i8** %l18
  %t439 = load double, double* %l19
  %t440 = load i8*, i8** %l18
  %t441 = call i64 @sailfin_runtime_string_length(i8* %t440)
  %t442 = fptosi double %t439 to i64
  %t443 = call i8* @sailfin_runtime_substring(i8* %t438, i64 %t442, i64 %t441)
  %t444 = call i8* @trim_text(i8* %t443)
  store i8* %t444, i8** %l20
  %t445 = load i8*, i8** %l18
  %t446 = load double, double* %l19
  %t447 = fptosi double %t446 to i64
  %t448 = call i8* @sailfin_runtime_substring(i8* %t445, i64 0, i64 %t447)
  %t449 = call i8* @trim_text(i8* %t448)
  store i8* %t449, i8** %l18
  %t450 = load i8*, i8** %l20
  %t451 = load i8*, i8** %l18
  br label %merge26
merge26:
  %t452 = phi i8* [ %t450, %then25 ], [ %t437, %then23 ]
  %t453 = phi i8* [ %t451, %then25 ], [ %t435, %then23 ]
  store i8* %t452, i8** %l20
  store i8* %t453, i8** %l18
  %t454 = load i8*, i8** %l18
  %t455 = call i64 @sailfin_runtime_string_length(i8* %t454)
  %t456 = icmp sgt i64 %t455, 0
  %t457 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t458 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t459 = load i8*, i8** %l2
  %t460 = load i8*, i8** %l3
  %t461 = load i1, i1* %l4
  %t462 = load double, double* %l5
  %t463 = load double, double* %l6
  %t464 = load i8*, i8** %l7
  %t465 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t466 = load i8*, i8** %l9
  %t467 = load i8*, i8** %l10
  %t468 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t469 = load i8*, i8** %l12
  %t470 = load i8*, i8** %l16
  %t471 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t472 = load i8*, i8** %l18
  %t473 = load double, double* %l19
  %t474 = load i8*, i8** %l20
  br i1 %t456, label %then27, label %merge28
then27:
  %t475 = load i8*, i8** %l18
  %s476 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193428050, i32 0, i32 0
  %t477 = call i1 @starts_with(i8* %t475, i8* %s476)
  %t478 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t479 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t480 = load i8*, i8** %l2
  %t481 = load i8*, i8** %l3
  %t482 = load i1, i1* %l4
  %t483 = load double, double* %l5
  %t484 = load double, double* %l6
  %t485 = load i8*, i8** %l7
  %t486 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t487 = load i8*, i8** %l9
  %t488 = load i8*, i8** %l10
  %t489 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t490 = load i8*, i8** %l12
  %t491 = load i8*, i8** %l16
  %t492 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t493 = load i8*, i8** %l18
  %t494 = load double, double* %l19
  %t495 = load i8*, i8** %l20
  br i1 %t477, label %then29, label %else30
then29:
  %t496 = load i8*, i8** %l18
  %s497 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193428050, i32 0, i32 0
  %t498 = call i8* @strip_prefix(i8* %t496, i8* %s497)
  %t499 = call i8* @trim_text(i8* %t498)
  store i8* %t499, i8** %l21
  %t500 = load i8*, i8** %l21
  %t501 = call i64 @sailfin_runtime_string_length(i8* %t500)
  %t502 = icmp sgt i64 %t501, 0
  %t503 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t504 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t505 = load i8*, i8** %l2
  %t506 = load i8*, i8** %l3
  %t507 = load i1, i1* %l4
  %t508 = load double, double* %l5
  %t509 = load double, double* %l6
  %t510 = load i8*, i8** %l7
  %t511 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t512 = load i8*, i8** %l9
  %t513 = load i8*, i8** %l10
  %t514 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t515 = load i8*, i8** %l12
  %t516 = load i8*, i8** %l16
  %t517 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t518 = load i8*, i8** %l18
  %t519 = load double, double* %l19
  %t520 = load i8*, i8** %l20
  %t521 = load i8*, i8** %l21
  br i1 %t502, label %then32, label %merge33
then32:
  %t522 = load i8*, i8** %l21
  store i8* %t522, i8** %l16
  %t523 = load i8*, i8** %l16
  br label %merge33
merge33:
  %t524 = phi i8* [ %t523, %then32 ], [ %t516, %then29 ]
  store i8* %t524, i8** %l16
  %t525 = load i8*, i8** %l16
  br label %merge31
else30:
  %t526 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s527 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h385719500, i32 0, i32 0
  %t528 = call i8* @sailfin_runtime_string_concat(i8* %s527, i8* %interface_name)
  %s529 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h841153022, i32 0, i32 0
  %t530 = call i8* @sailfin_runtime_string_concat(i8* %t528, i8* %s529)
  %t531 = load i8*, i8** %l9
  %t532 = call i8* @sailfin_runtime_string_concat(i8* %t530, i8* %t531)
  %s533 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.len26.h1606904140, i32 0, i32 0
  %t534 = call i8* @sailfin_runtime_string_concat(i8* %t532, i8* %s533)
  %t535 = load i8*, i8** %l18
  %t536 = call i8* @sailfin_runtime_string_concat(i8* %t534, i8* %t535)
  %t537 = alloca [2 x i8], align 1
  %t538 = getelementptr [2 x i8], [2 x i8]* %t537, i32 0, i32 0
  store i8 96, i8* %t538
  %t539 = getelementptr [2 x i8], [2 x i8]* %t537, i32 0, i32 1
  store i8 0, i8* %t539
  %t540 = getelementptr [2 x i8], [2 x i8]* %t537, i32 0, i32 0
  %t541 = call i8* @sailfin_runtime_string_concat(i8* %t536, i8* %t540)
  %t542 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t526, i8* %t541)
  store { i8**, i64 }* %t542, { i8**, i64 }** %l0
  %t543 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge31
merge31:
  %t544 = phi i8* [ %t525, %merge33 ], [ %t491, %else30 ]
  %t545 = phi { i8**, i64 }* [ %t478, %merge33 ], [ %t543, %else30 ]
  store i8* %t544, i8** %l16
  store { i8**, i64 }* %t545, { i8**, i64 }** %l0
  %t546 = load i8*, i8** %l16
  %t547 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge28
merge28:
  %t548 = phi i8* [ %t546, %merge31 ], [ %t470, %merge26 ]
  %t549 = phi { i8**, i64 }* [ %t547, %merge31 ], [ %t457, %merge26 ]
  store i8* %t548, i8** %l16
  store { i8**, i64 }* %t549, { i8**, i64 }** %l0
  %t550 = load i8*, i8** %l20
  %t551 = call i64 @sailfin_runtime_string_length(i8* %t550)
  %t552 = icmp sgt i64 %t551, 0
  %t553 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t554 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t555 = load i8*, i8** %l2
  %t556 = load i8*, i8** %l3
  %t557 = load i1, i1* %l4
  %t558 = load double, double* %l5
  %t559 = load double, double* %l6
  %t560 = load i8*, i8** %l7
  %t561 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t562 = load i8*, i8** %l9
  %t563 = load i8*, i8** %l10
  %t564 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t565 = load i8*, i8** %l12
  %t566 = load i8*, i8** %l16
  %t567 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t568 = load i8*, i8** %l18
  %t569 = load double, double* %l19
  %t570 = load i8*, i8** %l20
  br i1 %t552, label %then34, label %merge35
then34:
  %t572 = load i8*, i8** %l20
  %s573 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193415939, i32 0, i32 0
  %t574 = call i1 @starts_with(i8* %t572, i8* %s573)
  br label %logical_and_entry_571

logical_and_entry_571:
  br i1 %t574, label %logical_and_right_571, label %logical_and_merge_571

logical_and_right_571:
  %t575 = load i8*, i8** %l20
  %t576 = load i8*, i8** %l20
  %t577 = call i64 @sailfin_runtime_string_length(i8* %t576)
  %t578 = sub i64 %t577, 1
  %t579 = getelementptr i8, i8* %t575, i64 %t578
  %t580 = load i8, i8* %t579
  %t581 = icmp eq i8 %t580, 93
  br label %logical_and_right_end_571

logical_and_right_end_571:
  br label %logical_and_merge_571

logical_and_merge_571:
  %t582 = phi i1 [ false, %logical_and_entry_571 ], [ %t581, %logical_and_right_end_571 ]
  %t583 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t584 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t585 = load i8*, i8** %l2
  %t586 = load i8*, i8** %l3
  %t587 = load i1, i1* %l4
  %t588 = load double, double* %l5
  %t589 = load double, double* %l6
  %t590 = load i8*, i8** %l7
  %t591 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t592 = load i8*, i8** %l9
  %t593 = load i8*, i8** %l10
  %t594 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t595 = load i8*, i8** %l12
  %t596 = load i8*, i8** %l16
  %t597 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t598 = load i8*, i8** %l18
  %t599 = load double, double* %l19
  %t600 = load i8*, i8** %l20
  br i1 %t582, label %then36, label %else37
then36:
  %t601 = load i8*, i8** %l20
  %t602 = load i8*, i8** %l20
  %t603 = call i64 @sailfin_runtime_string_length(i8* %t602)
  %t604 = sub i64 %t603, 1
  %t605 = call i8* @sailfin_runtime_substring(i8* %t601, i64 2, i64 %t604)
  store i8* %t605, i8** %l22
  %t606 = load i8*, i8** %l22
  %t607 = call { i8**, i64 }* @parse_effect_list(i8* %t606)
  store { i8**, i64 }* %t607, { i8**, i64 }** %l17
  %t608 = load { i8**, i64 }*, { i8**, i64 }** %l17
  br label %merge38
else37:
  %t609 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s610 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h385719500, i32 0, i32 0
  %t611 = call i8* @sailfin_runtime_string_concat(i8* %s610, i8* %interface_name)
  %s612 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h841153022, i32 0, i32 0
  %t613 = call i8* @sailfin_runtime_string_concat(i8* %t611, i8* %s612)
  %t614 = load i8*, i8** %l9
  %t615 = call i8* @sailfin_runtime_string_concat(i8* %t613, i8* %t614)
  %s616 = getelementptr inbounds [35 x i8], [35 x i8]* @.str.len34.h1377481172, i32 0, i32 0
  %t617 = call i8* @sailfin_runtime_string_concat(i8* %t615, i8* %s616)
  %t618 = load i8*, i8** %l20
  %t619 = call i8* @sailfin_runtime_string_concat(i8* %t617, i8* %t618)
  %t620 = alloca [2 x i8], align 1
  %t621 = getelementptr [2 x i8], [2 x i8]* %t620, i32 0, i32 0
  store i8 96, i8* %t621
  %t622 = getelementptr [2 x i8], [2 x i8]* %t620, i32 0, i32 1
  store i8 0, i8* %t622
  %t623 = getelementptr [2 x i8], [2 x i8]* %t620, i32 0, i32 0
  %t624 = call i8* @sailfin_runtime_string_concat(i8* %t619, i8* %t623)
  %t625 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t609, i8* %t624)
  store { i8**, i64 }* %t625, { i8**, i64 }** %l0
  %t626 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge38
merge38:
  %t627 = phi { i8**, i64 }* [ %t608, %then36 ], [ %t597, %else37 ]
  %t628 = phi { i8**, i64 }* [ %t583, %then36 ], [ %t626, %else37 ]
  store { i8**, i64 }* %t627, { i8**, i64 }** %l17
  store { i8**, i64 }* %t628, { i8**, i64 }** %l0
  %t629 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t630 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge35
merge35:
  %t631 = phi { i8**, i64 }* [ %t629, %merge38 ], [ %t567, %merge28 ]
  %t632 = phi { i8**, i64 }* [ %t630, %merge38 ], [ %t553, %merge28 ]
  store { i8**, i64 }* %t631, { i8**, i64 }** %l17
  store { i8**, i64 }* %t632, { i8**, i64 }** %l0
  %t633 = load i8*, i8** %l18
  %t634 = load i8*, i8** %l16
  %t635 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t636 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t637 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge24
merge24:
  %t638 = phi i8* [ %t633, %merge35 ], [ %t412, %merge13 ]
  %t639 = phi i8* [ %t634, %merge35 ], [ %t410, %merge13 ]
  %t640 = phi { i8**, i64 }* [ %t635, %merge35 ], [ %t397, %merge13 ]
  %t641 = phi { i8**, i64 }* [ %t636, %merge35 ], [ %t411, %merge13 ]
  %t642 = phi { i8**, i64 }* [ %t637, %merge35 ], [ %t397, %merge13 ]
  store i8* %t638, i8** %l18
  store i8* %t639, i8** %l16
  store { i8**, i64 }* %t640, { i8**, i64 }** %l0
  store { i8**, i64 }* %t641, { i8**, i64 }** %l17
  store { i8**, i64 }* %t642, { i8**, i64 }** %l0
  %t643 = load i8*, i8** %l9
  %t644 = insertvalue %NativeInterfaceSignature undef, i8* %t643, 0
  %t645 = load i1, i1* %l4
  %t646 = insertvalue %NativeInterfaceSignature %t644, i1 %t645, 1
  %t647 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t648 = extractvalue %HeaderNameParse %t647, 1
  %t649 = insertvalue %NativeInterfaceSignature %t646, { i8**, i64 }* %t648, 2
  %t650 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t651 = bitcast { %NativeParameter*, i64 }* %t650 to { %NativeParameter**, i64 }*
  %t652 = insertvalue %NativeInterfaceSignature %t649, { %NativeParameter**, i64 }* %t651, 3
  %t653 = load i8*, i8** %l16
  %t654 = insertvalue %NativeInterfaceSignature %t652, i8* %t653, 4
  %t655 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t656 = insertvalue %NativeInterfaceSignature %t654, { i8**, i64 }* %t655, 5
  store %NativeInterfaceSignature %t656, %NativeInterfaceSignature* %l23
  %t658 = load i8*, i8** %l9
  %t659 = call i64 @sailfin_runtime_string_length(i8* %t658)
  %t660 = icmp sgt i64 %t659, 0
  br label %logical_and_entry_657

logical_and_entry_657:
  br i1 %t660, label %logical_and_right_657, label %logical_and_merge_657

logical_and_right_657:
  %t661 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t662 = load { i8**, i64 }, { i8**, i64 }* %t661
  %t663 = extractvalue { i8**, i64 } %t662, 1
  %t664 = icmp eq i64 %t663, 0
  br label %logical_and_right_end_657

logical_and_right_end_657:
  br label %logical_and_merge_657

logical_and_merge_657:
  %t665 = phi i1 [ false, %logical_and_entry_657 ], [ %t664, %logical_and_right_end_657 ]
  store i1 %t665, i1* %l24
  %t666 = load i1, i1* %l24
  %t667 = insertvalue %InterfaceSignatureParse undef, i1 %t666, 0
  %t668 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l23
  %t669 = insertvalue %InterfaceSignatureParse %t667, %NativeInterfaceSignature %t668, 1
  %t670 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t671 = insertvalue %InterfaceSignatureParse %t669, { i8**, i64 }* %t670, 2
  ret %InterfaceSignatureParse %t671
}

define %HeaderNameParse @parse_header_name_and_remainder(i8* %text) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca i8*
  %l4 = alloca { i8**, i64 }*
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca i8*
  %l8 = alloca double
  %t0 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t1 = ptrtoint [0 x i8*]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to i8**
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t7 = ptrtoint { i8**, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { i8**, i64 }*
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 0
  store i8** %t5, i8*** %t10
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { i8**, i64 }* %t9, { i8**, i64 }** %l0
  %t12 = call i8* @trim_text(i8* %text)
  store i8* %t12, i8** %l1
  %t13 = load i8*, i8** %l1
  %t14 = call i64 @sailfin_runtime_string_length(i8* %t13)
  %t15 = icmp eq i64 %t14, 0
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t17 = load i8*, i8** %l1
  br i1 %t15, label %then0, label %merge1
then0:
  %s18 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t19 = insertvalue %HeaderNameParse undef, i8* %s18, 0
  %t20 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t21 = ptrtoint [0 x i8*]* %t20 to i64
  %t22 = icmp eq i64 %t21, 0
  %t23 = select i1 %t22, i64 1, i64 %t21
  %t24 = call i8* @malloc(i64 %t23)
  %t25 = bitcast i8* %t24 to i8**
  %t26 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t27 = ptrtoint { i8**, i64 }* %t26 to i64
  %t28 = call i8* @malloc(i64 %t27)
  %t29 = bitcast i8* %t28 to { i8**, i64 }*
  %t30 = getelementptr { i8**, i64 }, { i8**, i64 }* %t29, i32 0, i32 0
  store i8** %t25, i8*** %t30
  %t31 = getelementptr { i8**, i64 }, { i8**, i64 }* %t29, i32 0, i32 1
  store i64 0, i64* %t31
  %t32 = insertvalue %HeaderNameParse %t19, { i8**, i64 }* %t29, 1
  %s33 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t34 = insertvalue %HeaderNameParse %t32, i8* %s33, 2
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t36 = insertvalue %HeaderNameParse %t34, { i8**, i64 }* %t35, 3
  ret %HeaderNameParse %t36
merge1:
  %t37 = load i8*, i8** %l1
  store i8* %t37, i8** %l2
  %s38 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s38, i8** %l3
  %t39 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t40 = ptrtoint [0 x i8*]* %t39 to i64
  %t41 = icmp eq i64 %t40, 0
  %t42 = select i1 %t41, i64 1, i64 %t40
  %t43 = call i8* @malloc(i64 %t42)
  %t44 = bitcast i8* %t43 to i8**
  %t45 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t46 = ptrtoint { i8**, i64 }* %t45 to i64
  %t47 = call i8* @malloc(i64 %t46)
  %t48 = bitcast i8* %t47 to { i8**, i64 }*
  %t49 = getelementptr { i8**, i64 }, { i8**, i64 }* %t48, i32 0, i32 0
  store i8** %t44, i8*** %t49
  %t50 = getelementptr { i8**, i64 }, { i8**, i64 }* %t48, i32 0, i32 1
  store i64 0, i64* %t50
  store { i8**, i64 }* %t48, { i8**, i64 }** %l4
  %t51 = load i8*, i8** %l1
  %t52 = alloca [2 x i8], align 1
  %t53 = getelementptr [2 x i8], [2 x i8]* %t52, i32 0, i32 0
  store i8 60, i8* %t53
  %t54 = getelementptr [2 x i8], [2 x i8]* %t52, i32 0, i32 1
  store i8 0, i8* %t54
  %t55 = getelementptr [2 x i8], [2 x i8]* %t52, i32 0, i32 0
  %t56 = call double @index_of(i8* %t51, i8* %t55)
  store double %t56, double* %l5
  %t57 = load double, double* %l5
  %t58 = sitofp i64 0 to double
  %t59 = fcmp oge double %t57, %t58
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t61 = load i8*, i8** %l1
  %t62 = load i8*, i8** %l2
  %t63 = load i8*, i8** %l3
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t65 = load double, double* %l5
  br i1 %t59, label %then2, label %else3
then2:
  %t66 = load i8*, i8** %l1
  %t67 = load double, double* %l5
  %t68 = call double @find_matching_angle(i8* %t66, double %t67)
  store double %t68, double* %l6
  %t69 = load double, double* %l6
  %t70 = sitofp i64 0 to double
  %t71 = fcmp olt double %t69, %t70
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t73 = load i8*, i8** %l1
  %t74 = load i8*, i8** %l2
  %t75 = load i8*, i8** %l3
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t77 = load double, double* %l5
  %t78 = load double, double* %l6
  br i1 %t71, label %then5, label %merge6
then5:
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s80 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h487238491, i32 0, i32 0
  %t81 = call i8* @sailfin_runtime_string_concat(i8* %s80, i8* %text)
  %s82 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.len21.h1187531435, i32 0, i32 0
  %t83 = call i8* @sailfin_runtime_string_concat(i8* %t81, i8* %s82)
  %t84 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t79, i8* %t83)
  store { i8**, i64 }* %t84, { i8**, i64 }** %l0
  %t85 = load i8*, i8** %l1
  %t86 = call i8* @strip_generics(i8* %t85)
  store i8* %t86, i8** %l2
  %t87 = load i8*, i8** %l2
  %t88 = insertvalue %HeaderNameParse undef, i8* %t87, 0
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t90 = insertvalue %HeaderNameParse %t88, { i8**, i64 }* %t89, 1
  %t91 = load i8*, i8** %l3
  %t92 = insertvalue %HeaderNameParse %t90, i8* %t91, 2
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t94 = insertvalue %HeaderNameParse %t92, { i8**, i64 }* %t93, 3
  ret %HeaderNameParse %t94
merge6:
  %t95 = load i8*, i8** %l1
  %t96 = load double, double* %l5
  %t97 = fptosi double %t96 to i64
  %t98 = call i8* @sailfin_runtime_substring(i8* %t95, i64 0, i64 %t97)
  %t99 = call i8* @trim_text(i8* %t98)
  store i8* %t99, i8** %l2
  %t100 = load i8*, i8** %l1
  %t101 = load double, double* %l5
  %t102 = sitofp i64 1 to double
  %t103 = fadd double %t101, %t102
  %t104 = load double, double* %l6
  %t105 = fptosi double %t103 to i64
  %t106 = fptosi double %t104 to i64
  %t107 = call i8* @sailfin_runtime_substring(i8* %t100, i64 %t105, i64 %t106)
  store i8* %t107, i8** %l7
  %t108 = load i8*, i8** %l7
  %t109 = call { i8**, i64 }* @parse_type_parameter_entries(i8* %t108)
  store { i8**, i64 }* %t109, { i8**, i64 }** %l4
  %t110 = load i8*, i8** %l1
  %t111 = load double, double* %l6
  %t112 = sitofp i64 1 to double
  %t113 = fadd double %t111, %t112
  %t114 = load i8*, i8** %l1
  %t115 = call i64 @sailfin_runtime_string_length(i8* %t114)
  %t116 = fptosi double %t113 to i64
  %t117 = call i8* @sailfin_runtime_substring(i8* %t110, i64 %t116, i64 %t115)
  %t118 = call i8* @trim_text(i8* %t117)
  store i8* %t118, i8** %l3
  %t119 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t120 = load i8*, i8** %l2
  %t121 = load i8*, i8** %l2
  %t122 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t123 = load i8*, i8** %l3
  br label %merge4
else3:
  %t124 = load i8*, i8** %l1
  %t125 = alloca [2 x i8], align 1
  %t126 = getelementptr [2 x i8], [2 x i8]* %t125, i32 0, i32 0
  store i8 32, i8* %t126
  %t127 = getelementptr [2 x i8], [2 x i8]* %t125, i32 0, i32 1
  store i8 0, i8* %t127
  %t128 = getelementptr [2 x i8], [2 x i8]* %t125, i32 0, i32 0
  %t129 = call double @index_of(i8* %t124, i8* %t128)
  store double %t129, double* %l8
  %t130 = load double, double* %l8
  %t131 = sitofp i64 0 to double
  %t132 = fcmp oge double %t130, %t131
  %t133 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t134 = load i8*, i8** %l1
  %t135 = load i8*, i8** %l2
  %t136 = load i8*, i8** %l3
  %t137 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t138 = load double, double* %l5
  %t139 = load double, double* %l8
  br i1 %t132, label %then7, label %merge8
then7:
  %t140 = load i8*, i8** %l1
  %t141 = load double, double* %l8
  %t142 = fptosi double %t141 to i64
  %t143 = call i8* @sailfin_runtime_substring(i8* %t140, i64 0, i64 %t142)
  %t144 = call i8* @trim_text(i8* %t143)
  store i8* %t144, i8** %l2
  %t145 = load i8*, i8** %l1
  %t146 = load double, double* %l8
  %t147 = sitofp i64 1 to double
  %t148 = fadd double %t146, %t147
  %t149 = load i8*, i8** %l1
  %t150 = call i64 @sailfin_runtime_string_length(i8* %t149)
  %t151 = fptosi double %t148 to i64
  %t152 = call i8* @sailfin_runtime_substring(i8* %t145, i64 %t151, i64 %t150)
  %t153 = call i8* @trim_text(i8* %t152)
  store i8* %t153, i8** %l3
  %t154 = load i8*, i8** %l2
  %t155 = load i8*, i8** %l3
  br label %merge8
merge8:
  %t156 = phi i8* [ %t154, %then7 ], [ %t135, %else3 ]
  %t157 = phi i8* [ %t155, %then7 ], [ %t136, %else3 ]
  store i8* %t156, i8** %l2
  store i8* %t157, i8** %l3
  %t158 = load i8*, i8** %l2
  %t159 = load i8*, i8** %l3
  br label %merge4
merge4:
  %t160 = phi { i8**, i64 }* [ %t119, %merge6 ], [ %t60, %merge8 ]
  %t161 = phi i8* [ %t120, %merge6 ], [ %t158, %merge8 ]
  %t162 = phi { i8**, i64 }* [ %t122, %merge6 ], [ %t64, %merge8 ]
  %t163 = phi i8* [ %t123, %merge6 ], [ %t159, %merge8 ]
  store { i8**, i64 }* %t160, { i8**, i64 }** %l0
  store i8* %t161, i8** %l2
  store { i8**, i64 }* %t162, { i8**, i64 }** %l4
  store i8* %t163, i8** %l3
  %t164 = load i8*, i8** %l2
  %t165 = call i8* @strip_generics(i8* %t164)
  store i8* %t165, i8** %l2
  %t166 = load i8*, i8** %l2
  %t167 = insertvalue %HeaderNameParse undef, i8* %t166, 0
  %t168 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t169 = insertvalue %HeaderNameParse %t167, { i8**, i64 }* %t168, 1
  %t170 = load i8*, i8** %l3
  %t171 = insertvalue %HeaderNameParse %t169, i8* %t170, 2
  %t172 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t173 = insertvalue %HeaderNameParse %t171, { i8**, i64 }* %t172, 3
  ret %HeaderNameParse %t173
}

define { i8**, i64 }* @parse_type_parameter_entries(i8* %text) {
block.entry:
  %l0 = alloca i8*
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t6 = ptrtoint [0 x i8*]* %t5 to i64
  %t7 = icmp eq i64 %t6, 0
  %t8 = select i1 %t7, i64 1, i64 %t6
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to i8**
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t12 = ptrtoint { i8**, i64 }* %t11 to i64
  %t13 = call i8* @malloc(i64 %t12)
  %t14 = bitcast i8* %t13 to { i8**, i64 }*
  %t15 = getelementptr { i8**, i64 }, { i8**, i64 }* %t14, i32 0, i32 0
  store i8** %t10, i8*** %t15
  %t16 = getelementptr { i8**, i64 }, { i8**, i64 }* %t14, i32 0, i32 1
  store i64 0, i64* %t16
  ret { i8**, i64 }* %t14
merge1:
  %t17 = load i8*, i8** %l0
  %t18 = call { i8**, i64 }* @split_top_level_commas(i8* %t17)
  ret { i8**, i64 }* %t18
}

define { i8**, i64 }* @parse_implements_list(i8* %text) {
block.entry:
  %l0 = alloca i8*
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t6 = ptrtoint [0 x i8*]* %t5 to i64
  %t7 = icmp eq i64 %t6, 0
  %t8 = select i1 %t7, i64 1, i64 %t6
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to i8**
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t12 = ptrtoint { i8**, i64 }* %t11 to i64
  %t13 = call i8* @malloc(i64 %t12)
  %t14 = bitcast i8* %t13 to { i8**, i64 }*
  %t15 = getelementptr { i8**, i64 }, { i8**, i64 }* %t14, i32 0, i32 0
  store i8** %t10, i8*** %t15
  %t16 = getelementptr { i8**, i64 }, { i8**, i64 }* %t14, i32 0, i32 1
  store i64 0, i64* %t16
  ret { i8**, i64 }* %t14
merge1:
  %t17 = load i8*, i8** %l0
  %t18 = call { i8**, i64 }* @split_top_level_commas(i8* %t17)
  ret { i8**, i64 }* %t18
}

define { i8**, i64 }* @split_top_level_commas(i8* %text) {
block.entry:
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
  %t0 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t1 = ptrtoint [0 x i8*]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to i8**
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t7 = ptrtoint { i8**, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { i8**, i64 }*
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 0
  store i8** %t5, i8*** %t10
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { i8**, i64 }* %t9, { i8**, i64 }** %l0
  %s12 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s12, i8** %l1
  %t13 = sitofp i64 0 to double
  store double %t13, double* %l2
  %s14 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s14, i8** %l3
  %t15 = sitofp i64 0 to double
  store double %t15, double* %l4
  %t16 = sitofp i64 0 to double
  store double %t16, double* %l5
  %t17 = sitofp i64 0 to double
  store double %t17, double* %l6
  %t18 = sitofp i64 0 to double
  store double %t18, double* %l7
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t20 = load i8*, i8** %l1
  %t21 = load double, double* %l2
  %t22 = load i8*, i8** %l3
  %t23 = load double, double* %l4
  %t24 = load double, double* %l5
  %t25 = load double, double* %l6
  %t26 = load double, double* %l7
  br label %loop.header0
loop.header0:
  %t490 = phi i8* [ %t20, %block.entry ], [ %t482, %loop.latch2 ]
  %t491 = phi double [ %t21, %block.entry ], [ %t483, %loop.latch2 ]
  %t492 = phi i8* [ %t22, %block.entry ], [ %t484, %loop.latch2 ]
  %t493 = phi double [ %t23, %block.entry ], [ %t485, %loop.latch2 ]
  %t494 = phi double [ %t24, %block.entry ], [ %t486, %loop.latch2 ]
  %t495 = phi double [ %t25, %block.entry ], [ %t487, %loop.latch2 ]
  %t496 = phi double [ %t26, %block.entry ], [ %t488, %loop.latch2 ]
  %t497 = phi { i8**, i64 }* [ %t19, %block.entry ], [ %t489, %loop.latch2 ]
  store i8* %t490, i8** %l1
  store double %t491, double* %l2
  store i8* %t492, i8** %l3
  store double %t493, double* %l4
  store double %t494, double* %l5
  store double %t495, double* %l6
  store double %t496, double* %l7
  store { i8**, i64 }* %t497, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t27 = load double, double* %l2
  %t28 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t29 = sitofp i64 %t28 to double
  %t30 = fcmp oge double %t27, %t29
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t32 = load i8*, i8** %l1
  %t33 = load double, double* %l2
  %t34 = load i8*, i8** %l3
  %t35 = load double, double* %l4
  %t36 = load double, double* %l5
  %t37 = load double, double* %l6
  %t38 = load double, double* %l7
  br i1 %t30, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t39 = load double, double* %l2
  %t40 = fptosi double %t39 to i64
  %t41 = getelementptr i8, i8* %text, i64 %t40
  %t42 = load i8, i8* %t41
  store i8 %t42, i8* %l8
  %t43 = load i8*, i8** %l3
  %t44 = call i64 @sailfin_runtime_string_length(i8* %t43)
  %t45 = icmp sgt i64 %t44, 0
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t47 = load i8*, i8** %l1
  %t48 = load double, double* %l2
  %t49 = load i8*, i8** %l3
  %t50 = load double, double* %l4
  %t51 = load double, double* %l5
  %t52 = load double, double* %l6
  %t53 = load double, double* %l7
  %t54 = load i8, i8* %l8
  br i1 %t45, label %then6, label %merge7
then6:
  %t55 = load i8*, i8** %l1
  %t56 = load i8, i8* %l8
  %t57 = alloca [2 x i8], align 1
  %t58 = getelementptr [2 x i8], [2 x i8]* %t57, i32 0, i32 0
  store i8 %t56, i8* %t58
  %t59 = getelementptr [2 x i8], [2 x i8]* %t57, i32 0, i32 1
  store i8 0, i8* %t59
  %t60 = getelementptr [2 x i8], [2 x i8]* %t57, i32 0, i32 0
  %t61 = call i8* @sailfin_runtime_string_concat(i8* %t55, i8* %t60)
  store i8* %t61, i8** %l1
  %t62 = load i8, i8* %l8
  %t63 = icmp eq i8 %t62, 92
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t65 = load i8*, i8** %l1
  %t66 = load double, double* %l2
  %t67 = load i8*, i8** %l3
  %t68 = load double, double* %l4
  %t69 = load double, double* %l5
  %t70 = load double, double* %l6
  %t71 = load double, double* %l7
  %t72 = load i8, i8* %l8
  br i1 %t63, label %then8, label %merge9
then8:
  %t73 = load double, double* %l2
  %t74 = sitofp i64 1 to double
  %t75 = fadd double %t73, %t74
  %t76 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t77 = sitofp i64 %t76 to double
  %t78 = fcmp olt double %t75, %t77
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t80 = load i8*, i8** %l1
  %t81 = load double, double* %l2
  %t82 = load i8*, i8** %l3
  %t83 = load double, double* %l4
  %t84 = load double, double* %l5
  %t85 = load double, double* %l6
  %t86 = load double, double* %l7
  %t87 = load i8, i8* %l8
  br i1 %t78, label %then10, label %merge11
then10:
  %t88 = load i8*, i8** %l1
  %t89 = load double, double* %l2
  %t90 = sitofp i64 1 to double
  %t91 = fadd double %t89, %t90
  %t92 = fptosi double %t91 to i64
  %t93 = getelementptr i8, i8* %text, i64 %t92
  %t94 = load i8, i8* %t93
  %t95 = alloca [2 x i8], align 1
  %t96 = getelementptr [2 x i8], [2 x i8]* %t95, i32 0, i32 0
  store i8 %t94, i8* %t96
  %t97 = getelementptr [2 x i8], [2 x i8]* %t95, i32 0, i32 1
  store i8 0, i8* %t97
  %t98 = getelementptr [2 x i8], [2 x i8]* %t95, i32 0, i32 0
  %t99 = call i8* @sailfin_runtime_string_concat(i8* %t88, i8* %t98)
  store i8* %t99, i8** %l1
  %t100 = load double, double* %l2
  %t101 = sitofp i64 2 to double
  %t102 = fadd double %t100, %t101
  store double %t102, double* %l2
  br label %loop.latch2
merge11:
  %t103 = load i8*, i8** %l1
  %t104 = load double, double* %l2
  br label %merge9
merge9:
  %t105 = phi i8* [ %t103, %merge11 ], [ %t65, %then6 ]
  %t106 = phi double [ %t104, %merge11 ], [ %t66, %then6 ]
  store i8* %t105, i8** %l1
  store double %t106, double* %l2
  %t107 = load i8, i8* %l8
  %t108 = load i8*, i8** %l3
  %t109 = load i8, i8* %t108
  %t110 = icmp eq i8 %t107, %t109
  %t111 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t112 = load i8*, i8** %l1
  %t113 = load double, double* %l2
  %t114 = load i8*, i8** %l3
  %t115 = load double, double* %l4
  %t116 = load double, double* %l5
  %t117 = load double, double* %l6
  %t118 = load double, double* %l7
  %t119 = load i8, i8* %l8
  br i1 %t110, label %then12, label %merge13
then12:
  %s120 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s120, i8** %l3
  %t121 = load i8*, i8** %l3
  br label %merge13
merge13:
  %t122 = phi i8* [ %t121, %then12 ], [ %t114, %merge9 ]
  store i8* %t122, i8** %l3
  %t123 = load double, double* %l2
  %t124 = sitofp i64 1 to double
  %t125 = fadd double %t123, %t124
  store double %t125, double* %l2
  br label %loop.latch2
merge7:
  %t127 = load i8, i8* %l8
  %t128 = icmp eq i8 %t127, 34
  br label %logical_or_entry_126

logical_or_entry_126:
  br i1 %t128, label %logical_or_merge_126, label %logical_or_right_126

logical_or_right_126:
  %t129 = load i8, i8* %l8
  %t130 = icmp eq i8 %t129, 39
  br label %logical_or_right_end_126

logical_or_right_end_126:
  br label %logical_or_merge_126

logical_or_merge_126:
  %t131 = phi i1 [ true, %logical_or_entry_126 ], [ %t130, %logical_or_right_end_126 ]
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
  %t141 = load i8, i8* %l8
  %t142 = alloca [2 x i8], align 1
  %t143 = getelementptr [2 x i8], [2 x i8]* %t142, i32 0, i32 0
  store i8 %t141, i8* %t143
  %t144 = getelementptr [2 x i8], [2 x i8]* %t142, i32 0, i32 1
  store i8 0, i8* %t144
  %t145 = getelementptr [2 x i8], [2 x i8]* %t142, i32 0, i32 0
  store i8* %t145, i8** %l3
  %t146 = load i8*, i8** %l1
  %t147 = load i8, i8* %l8
  %t148 = alloca [2 x i8], align 1
  %t149 = getelementptr [2 x i8], [2 x i8]* %t148, i32 0, i32 0
  store i8 %t147, i8* %t149
  %t150 = getelementptr [2 x i8], [2 x i8]* %t148, i32 0, i32 1
  store i8 0, i8* %t150
  %t151 = getelementptr [2 x i8], [2 x i8]* %t148, i32 0, i32 0
  %t152 = call i8* @sailfin_runtime_string_concat(i8* %t146, i8* %t151)
  store i8* %t152, i8** %l1
  %t153 = load double, double* %l2
  %t154 = sitofp i64 1 to double
  %t155 = fadd double %t153, %t154
  store double %t155, double* %l2
  br label %loop.latch2
merge15:
  %t156 = load i8, i8* %l8
  %t157 = icmp eq i8 %t156, 60
  %t158 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t159 = load i8*, i8** %l1
  %t160 = load double, double* %l2
  %t161 = load i8*, i8** %l3
  %t162 = load double, double* %l4
  %t163 = load double, double* %l5
  %t164 = load double, double* %l6
  %t165 = load double, double* %l7
  %t166 = load i8, i8* %l8
  br i1 %t157, label %then16, label %merge17
then16:
  %t167 = load double, double* %l4
  %t168 = sitofp i64 1 to double
  %t169 = fadd double %t167, %t168
  store double %t169, double* %l4
  %t170 = load i8*, i8** %l1
  %t171 = load i8, i8* %l8
  %t172 = alloca [2 x i8], align 1
  %t173 = getelementptr [2 x i8], [2 x i8]* %t172, i32 0, i32 0
  store i8 %t171, i8* %t173
  %t174 = getelementptr [2 x i8], [2 x i8]* %t172, i32 0, i32 1
  store i8 0, i8* %t174
  %t175 = getelementptr [2 x i8], [2 x i8]* %t172, i32 0, i32 0
  %t176 = call i8* @sailfin_runtime_string_concat(i8* %t170, i8* %t175)
  store i8* %t176, i8** %l1
  %t177 = load double, double* %l2
  %t178 = sitofp i64 1 to double
  %t179 = fadd double %t177, %t178
  store double %t179, double* %l2
  br label %loop.latch2
merge17:
  %t180 = load i8, i8* %l8
  %t181 = icmp eq i8 %t180, 62
  %t182 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t183 = load i8*, i8** %l1
  %t184 = load double, double* %l2
  %t185 = load i8*, i8** %l3
  %t186 = load double, double* %l4
  %t187 = load double, double* %l5
  %t188 = load double, double* %l6
  %t189 = load double, double* %l7
  %t190 = load i8, i8* %l8
  br i1 %t181, label %then18, label %merge19
then18:
  %t191 = load double, double* %l4
  %t192 = sitofp i64 0 to double
  %t193 = fcmp ogt double %t191, %t192
  %t194 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t195 = load i8*, i8** %l1
  %t196 = load double, double* %l2
  %t197 = load i8*, i8** %l3
  %t198 = load double, double* %l4
  %t199 = load double, double* %l5
  %t200 = load double, double* %l6
  %t201 = load double, double* %l7
  %t202 = load i8, i8* %l8
  br i1 %t193, label %then20, label %merge21
then20:
  %t203 = load double, double* %l4
  %t204 = sitofp i64 1 to double
  %t205 = fsub double %t203, %t204
  store double %t205, double* %l4
  %t206 = load double, double* %l4
  br label %merge21
merge21:
  %t207 = phi double [ %t206, %then20 ], [ %t198, %then18 ]
  store double %t207, double* %l4
  %t208 = load i8*, i8** %l1
  %t209 = load i8, i8* %l8
  %t210 = alloca [2 x i8], align 1
  %t211 = getelementptr [2 x i8], [2 x i8]* %t210, i32 0, i32 0
  store i8 %t209, i8* %t211
  %t212 = getelementptr [2 x i8], [2 x i8]* %t210, i32 0, i32 1
  store i8 0, i8* %t212
  %t213 = getelementptr [2 x i8], [2 x i8]* %t210, i32 0, i32 0
  %t214 = call i8* @sailfin_runtime_string_concat(i8* %t208, i8* %t213)
  store i8* %t214, i8** %l1
  %t215 = load double, double* %l2
  %t216 = sitofp i64 1 to double
  %t217 = fadd double %t215, %t216
  store double %t217, double* %l2
  br label %loop.latch2
merge19:
  %t218 = load i8, i8* %l8
  %t219 = icmp eq i8 %t218, 40
  %t220 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t221 = load i8*, i8** %l1
  %t222 = load double, double* %l2
  %t223 = load i8*, i8** %l3
  %t224 = load double, double* %l4
  %t225 = load double, double* %l5
  %t226 = load double, double* %l6
  %t227 = load double, double* %l7
  %t228 = load i8, i8* %l8
  br i1 %t219, label %then22, label %merge23
then22:
  %t229 = load double, double* %l5
  %t230 = sitofp i64 1 to double
  %t231 = fadd double %t229, %t230
  store double %t231, double* %l5
  %t232 = load i8*, i8** %l1
  %t233 = load i8, i8* %l8
  %t234 = alloca [2 x i8], align 1
  %t235 = getelementptr [2 x i8], [2 x i8]* %t234, i32 0, i32 0
  store i8 %t233, i8* %t235
  %t236 = getelementptr [2 x i8], [2 x i8]* %t234, i32 0, i32 1
  store i8 0, i8* %t236
  %t237 = getelementptr [2 x i8], [2 x i8]* %t234, i32 0, i32 0
  %t238 = call i8* @sailfin_runtime_string_concat(i8* %t232, i8* %t237)
  store i8* %t238, i8** %l1
  %t239 = load double, double* %l2
  %t240 = sitofp i64 1 to double
  %t241 = fadd double %t239, %t240
  store double %t241, double* %l2
  br label %loop.latch2
merge23:
  %t242 = load i8, i8* %l8
  %t243 = icmp eq i8 %t242, 41
  %t244 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t245 = load i8*, i8** %l1
  %t246 = load double, double* %l2
  %t247 = load i8*, i8** %l3
  %t248 = load double, double* %l4
  %t249 = load double, double* %l5
  %t250 = load double, double* %l6
  %t251 = load double, double* %l7
  %t252 = load i8, i8* %l8
  br i1 %t243, label %then24, label %merge25
then24:
  %t253 = load double, double* %l5
  %t254 = sitofp i64 0 to double
  %t255 = fcmp ogt double %t253, %t254
  %t256 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t257 = load i8*, i8** %l1
  %t258 = load double, double* %l2
  %t259 = load i8*, i8** %l3
  %t260 = load double, double* %l4
  %t261 = load double, double* %l5
  %t262 = load double, double* %l6
  %t263 = load double, double* %l7
  %t264 = load i8, i8* %l8
  br i1 %t255, label %then26, label %merge27
then26:
  %t265 = load double, double* %l5
  %t266 = sitofp i64 1 to double
  %t267 = fsub double %t265, %t266
  store double %t267, double* %l5
  %t268 = load double, double* %l5
  br label %merge27
merge27:
  %t269 = phi double [ %t268, %then26 ], [ %t261, %then24 ]
  store double %t269, double* %l5
  %t270 = load i8*, i8** %l1
  %t271 = load i8, i8* %l8
  %t272 = alloca [2 x i8], align 1
  %t273 = getelementptr [2 x i8], [2 x i8]* %t272, i32 0, i32 0
  store i8 %t271, i8* %t273
  %t274 = getelementptr [2 x i8], [2 x i8]* %t272, i32 0, i32 1
  store i8 0, i8* %t274
  %t275 = getelementptr [2 x i8], [2 x i8]* %t272, i32 0, i32 0
  %t276 = call i8* @sailfin_runtime_string_concat(i8* %t270, i8* %t275)
  store i8* %t276, i8** %l1
  %t277 = load double, double* %l2
  %t278 = sitofp i64 1 to double
  %t279 = fadd double %t277, %t278
  store double %t279, double* %l2
  br label %loop.latch2
merge25:
  %t280 = load i8, i8* %l8
  %t281 = icmp eq i8 %t280, 91
  %t282 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t283 = load i8*, i8** %l1
  %t284 = load double, double* %l2
  %t285 = load i8*, i8** %l3
  %t286 = load double, double* %l4
  %t287 = load double, double* %l5
  %t288 = load double, double* %l6
  %t289 = load double, double* %l7
  %t290 = load i8, i8* %l8
  br i1 %t281, label %then28, label %merge29
then28:
  %t291 = load double, double* %l6
  %t292 = sitofp i64 1 to double
  %t293 = fadd double %t291, %t292
  store double %t293, double* %l6
  %t294 = load i8*, i8** %l1
  %t295 = load i8, i8* %l8
  %t296 = alloca [2 x i8], align 1
  %t297 = getelementptr [2 x i8], [2 x i8]* %t296, i32 0, i32 0
  store i8 %t295, i8* %t297
  %t298 = getelementptr [2 x i8], [2 x i8]* %t296, i32 0, i32 1
  store i8 0, i8* %t298
  %t299 = getelementptr [2 x i8], [2 x i8]* %t296, i32 0, i32 0
  %t300 = call i8* @sailfin_runtime_string_concat(i8* %t294, i8* %t299)
  store i8* %t300, i8** %l1
  %t301 = load double, double* %l2
  %t302 = sitofp i64 1 to double
  %t303 = fadd double %t301, %t302
  store double %t303, double* %l2
  br label %loop.latch2
merge29:
  %t304 = load i8, i8* %l8
  %t305 = icmp eq i8 %t304, 93
  %t306 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t307 = load i8*, i8** %l1
  %t308 = load double, double* %l2
  %t309 = load i8*, i8** %l3
  %t310 = load double, double* %l4
  %t311 = load double, double* %l5
  %t312 = load double, double* %l6
  %t313 = load double, double* %l7
  %t314 = load i8, i8* %l8
  br i1 %t305, label %then30, label %merge31
then30:
  %t315 = load double, double* %l6
  %t316 = sitofp i64 0 to double
  %t317 = fcmp ogt double %t315, %t316
  %t318 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t319 = load i8*, i8** %l1
  %t320 = load double, double* %l2
  %t321 = load i8*, i8** %l3
  %t322 = load double, double* %l4
  %t323 = load double, double* %l5
  %t324 = load double, double* %l6
  %t325 = load double, double* %l7
  %t326 = load i8, i8* %l8
  br i1 %t317, label %then32, label %merge33
then32:
  %t327 = load double, double* %l6
  %t328 = sitofp i64 1 to double
  %t329 = fsub double %t327, %t328
  store double %t329, double* %l6
  %t330 = load double, double* %l6
  br label %merge33
merge33:
  %t331 = phi double [ %t330, %then32 ], [ %t324, %then30 ]
  store double %t331, double* %l6
  %t332 = load i8*, i8** %l1
  %t333 = load i8, i8* %l8
  %t334 = alloca [2 x i8], align 1
  %t335 = getelementptr [2 x i8], [2 x i8]* %t334, i32 0, i32 0
  store i8 %t333, i8* %t335
  %t336 = getelementptr [2 x i8], [2 x i8]* %t334, i32 0, i32 1
  store i8 0, i8* %t336
  %t337 = getelementptr [2 x i8], [2 x i8]* %t334, i32 0, i32 0
  %t338 = call i8* @sailfin_runtime_string_concat(i8* %t332, i8* %t337)
  store i8* %t338, i8** %l1
  %t339 = load double, double* %l2
  %t340 = sitofp i64 1 to double
  %t341 = fadd double %t339, %t340
  store double %t341, double* %l2
  br label %loop.latch2
merge31:
  %t342 = load i8, i8* %l8
  %t343 = icmp eq i8 %t342, 123
  %t344 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t345 = load i8*, i8** %l1
  %t346 = load double, double* %l2
  %t347 = load i8*, i8** %l3
  %t348 = load double, double* %l4
  %t349 = load double, double* %l5
  %t350 = load double, double* %l6
  %t351 = load double, double* %l7
  %t352 = load i8, i8* %l8
  br i1 %t343, label %then34, label %merge35
then34:
  %t353 = load double, double* %l7
  %t354 = sitofp i64 1 to double
  %t355 = fadd double %t353, %t354
  store double %t355, double* %l7
  %t356 = load i8*, i8** %l1
  %t357 = load i8, i8* %l8
  %t358 = alloca [2 x i8], align 1
  %t359 = getelementptr [2 x i8], [2 x i8]* %t358, i32 0, i32 0
  store i8 %t357, i8* %t359
  %t360 = getelementptr [2 x i8], [2 x i8]* %t358, i32 0, i32 1
  store i8 0, i8* %t360
  %t361 = getelementptr [2 x i8], [2 x i8]* %t358, i32 0, i32 0
  %t362 = call i8* @sailfin_runtime_string_concat(i8* %t356, i8* %t361)
  store i8* %t362, i8** %l1
  %t363 = load double, double* %l2
  %t364 = sitofp i64 1 to double
  %t365 = fadd double %t363, %t364
  store double %t365, double* %l2
  br label %loop.latch2
merge35:
  %t366 = load i8, i8* %l8
  %t367 = icmp eq i8 %t366, 125
  %t368 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t369 = load i8*, i8** %l1
  %t370 = load double, double* %l2
  %t371 = load i8*, i8** %l3
  %t372 = load double, double* %l4
  %t373 = load double, double* %l5
  %t374 = load double, double* %l6
  %t375 = load double, double* %l7
  %t376 = load i8, i8* %l8
  br i1 %t367, label %then36, label %merge37
then36:
  %t377 = load double, double* %l7
  %t378 = sitofp i64 0 to double
  %t379 = fcmp ogt double %t377, %t378
  %t380 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t381 = load i8*, i8** %l1
  %t382 = load double, double* %l2
  %t383 = load i8*, i8** %l3
  %t384 = load double, double* %l4
  %t385 = load double, double* %l5
  %t386 = load double, double* %l6
  %t387 = load double, double* %l7
  %t388 = load i8, i8* %l8
  br i1 %t379, label %then38, label %merge39
then38:
  %t389 = load double, double* %l7
  %t390 = sitofp i64 1 to double
  %t391 = fsub double %t389, %t390
  store double %t391, double* %l7
  %t392 = load double, double* %l7
  br label %merge39
merge39:
  %t393 = phi double [ %t392, %then38 ], [ %t387, %then36 ]
  store double %t393, double* %l7
  %t394 = load i8*, i8** %l1
  %t395 = load i8, i8* %l8
  %t396 = alloca [2 x i8], align 1
  %t397 = getelementptr [2 x i8], [2 x i8]* %t396, i32 0, i32 0
  store i8 %t395, i8* %t397
  %t398 = getelementptr [2 x i8], [2 x i8]* %t396, i32 0, i32 1
  store i8 0, i8* %t398
  %t399 = getelementptr [2 x i8], [2 x i8]* %t396, i32 0, i32 0
  %t400 = call i8* @sailfin_runtime_string_concat(i8* %t394, i8* %t399)
  store i8* %t400, i8** %l1
  %t401 = load double, double* %l2
  %t402 = sitofp i64 1 to double
  %t403 = fadd double %t401, %t402
  store double %t403, double* %l2
  br label %loop.latch2
merge37:
  %t404 = load i8, i8* %l8
  %t405 = icmp eq i8 %t404, 44
  %t406 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t407 = load i8*, i8** %l1
  %t408 = load double, double* %l2
  %t409 = load i8*, i8** %l3
  %t410 = load double, double* %l4
  %t411 = load double, double* %l5
  %t412 = load double, double* %l6
  %t413 = load double, double* %l7
  %t414 = load i8, i8* %l8
  br i1 %t405, label %then40, label %merge41
then40:
  %t416 = load double, double* %l4
  %t417 = sitofp i64 0 to double
  %t418 = fcmp oeq double %t416, %t417
  br label %logical_and_entry_415

logical_and_entry_415:
  br i1 %t418, label %logical_and_right_415, label %logical_and_merge_415

logical_and_right_415:
  %t420 = load double, double* %l5
  %t421 = sitofp i64 0 to double
  %t422 = fcmp oeq double %t420, %t421
  br label %logical_and_entry_419

logical_and_entry_419:
  br i1 %t422, label %logical_and_right_419, label %logical_and_merge_419

logical_and_right_419:
  %t424 = load double, double* %l6
  %t425 = sitofp i64 0 to double
  %t426 = fcmp oeq double %t424, %t425
  br label %logical_and_entry_423

logical_and_entry_423:
  br i1 %t426, label %logical_and_right_423, label %logical_and_merge_423

logical_and_right_423:
  %t427 = load double, double* %l7
  %t428 = sitofp i64 0 to double
  %t429 = fcmp oeq double %t427, %t428
  br label %logical_and_right_end_423

logical_and_right_end_423:
  br label %logical_and_merge_423

logical_and_merge_423:
  %t430 = phi i1 [ false, %logical_and_entry_423 ], [ %t429, %logical_and_right_end_423 ]
  br label %logical_and_right_end_419

logical_and_right_end_419:
  br label %logical_and_merge_419

logical_and_merge_419:
  %t431 = phi i1 [ false, %logical_and_entry_419 ], [ %t430, %logical_and_right_end_419 ]
  br label %logical_and_right_end_415

logical_and_right_end_415:
  br label %logical_and_merge_415

logical_and_merge_415:
  %t432 = phi i1 [ false, %logical_and_entry_415 ], [ %t431, %logical_and_right_end_415 ]
  %t433 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t434 = load i8*, i8** %l1
  %t435 = load double, double* %l2
  %t436 = load i8*, i8** %l3
  %t437 = load double, double* %l4
  %t438 = load double, double* %l5
  %t439 = load double, double* %l6
  %t440 = load double, double* %l7
  %t441 = load i8, i8* %l8
  br i1 %t432, label %then42, label %merge43
then42:
  %t442 = load i8*, i8** %l1
  %t443 = call i8* @trim_text(i8* %t442)
  store i8* %t443, i8** %l9
  %t444 = load i8*, i8** %l9
  %t445 = call i64 @sailfin_runtime_string_length(i8* %t444)
  %t446 = icmp sgt i64 %t445, 0
  %t447 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t448 = load i8*, i8** %l1
  %t449 = load double, double* %l2
  %t450 = load i8*, i8** %l3
  %t451 = load double, double* %l4
  %t452 = load double, double* %l5
  %t453 = load double, double* %l6
  %t454 = load double, double* %l7
  %t455 = load i8, i8* %l8
  %t456 = load i8*, i8** %l9
  br i1 %t446, label %then44, label %merge45
then44:
  %t457 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t458 = load i8*, i8** %l9
  %t459 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t457, i8* %t458)
  store { i8**, i64 }* %t459, { i8**, i64 }** %l0
  %t460 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge45
merge45:
  %t461 = phi { i8**, i64 }* [ %t460, %then44 ], [ %t447, %then42 ]
  store { i8**, i64 }* %t461, { i8**, i64 }** %l0
  %s462 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s462, i8** %l1
  %t463 = load double, double* %l2
  %t464 = sitofp i64 1 to double
  %t465 = fadd double %t463, %t464
  store double %t465, double* %l2
  br label %loop.latch2
merge43:
  %t466 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t467 = load i8*, i8** %l1
  %t468 = load double, double* %l2
  br label %merge41
merge41:
  %t469 = phi { i8**, i64 }* [ %t466, %merge43 ], [ %t406, %merge37 ]
  %t470 = phi i8* [ %t467, %merge43 ], [ %t407, %merge37 ]
  %t471 = phi double [ %t468, %merge43 ], [ %t408, %merge37 ]
  store { i8**, i64 }* %t469, { i8**, i64 }** %l0
  store i8* %t470, i8** %l1
  store double %t471, double* %l2
  %t472 = load i8*, i8** %l1
  %t473 = load i8, i8* %l8
  %t474 = alloca [2 x i8], align 1
  %t475 = getelementptr [2 x i8], [2 x i8]* %t474, i32 0, i32 0
  store i8 %t473, i8* %t475
  %t476 = getelementptr [2 x i8], [2 x i8]* %t474, i32 0, i32 1
  store i8 0, i8* %t476
  %t477 = getelementptr [2 x i8], [2 x i8]* %t474, i32 0, i32 0
  %t478 = call i8* @sailfin_runtime_string_concat(i8* %t472, i8* %t477)
  store i8* %t478, i8** %l1
  %t479 = load double, double* %l2
  %t480 = sitofp i64 1 to double
  %t481 = fadd double %t479, %t480
  store double %t481, double* %l2
  br label %loop.latch2
loop.latch2:
  %t482 = load i8*, i8** %l1
  %t483 = load double, double* %l2
  %t484 = load i8*, i8** %l3
  %t485 = load double, double* %l4
  %t486 = load double, double* %l5
  %t487 = load double, double* %l6
  %t488 = load double, double* %l7
  %t489 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t498 = load i8*, i8** %l1
  %t499 = load double, double* %l2
  %t500 = load i8*, i8** %l3
  %t501 = load double, double* %l4
  %t502 = load double, double* %l5
  %t503 = load double, double* %l6
  %t504 = load double, double* %l7
  %t505 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t506 = load i8*, i8** %l1
  %t507 = call i8* @trim_text(i8* %t506)
  store i8* %t507, i8** %l10
  %t508 = load i8*, i8** %l10
  %t509 = call i64 @sailfin_runtime_string_length(i8* %t508)
  %t510 = icmp sgt i64 %t509, 0
  %t511 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t512 = load i8*, i8** %l1
  %t513 = load double, double* %l2
  %t514 = load i8*, i8** %l3
  %t515 = load double, double* %l4
  %t516 = load double, double* %l5
  %t517 = load double, double* %l6
  %t518 = load double, double* %l7
  %t519 = load i8*, i8** %l10
  br i1 %t510, label %then46, label %merge47
then46:
  %t520 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t521 = load i8*, i8** %l10
  %t522 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t520, i8* %t521)
  store { i8**, i64 }* %t522, { i8**, i64 }** %l0
  %t523 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge47
merge47:
  %t524 = phi { i8**, i64 }* [ %t523, %then46 ], [ %t511, %afterloop3 ]
  store { i8**, i64 }* %t524, { i8**, i64 }** %l0
  %t525 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t525
}

define double @find_matching_angle(i8* %text, double %start_index) {
block.entry:
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
  %t54 = phi double [ %t1, %block.entry ], [ %t52, %loop.latch2 ]
  %t55 = phi double [ %t2, %block.entry ], [ %t53, %loop.latch2 ]
  store double %t54, double* %l0
  store double %t55, double* %l1
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
  %t21 = load double, double* %l0
  br label %merge8
else7:
  %t22 = load i8, i8* %l2
  %t23 = icmp eq i8 %t22, 62
  %t24 = load double, double* %l0
  %t25 = load double, double* %l1
  %t26 = load i8, i8* %l2
  br i1 %t23, label %then9, label %merge10
then9:
  %t27 = load double, double* %l0
  %t28 = sitofp i64 0 to double
  %t29 = fcmp ogt double %t27, %t28
  %t30 = load double, double* %l0
  %t31 = load double, double* %l1
  %t32 = load i8, i8* %l2
  br i1 %t29, label %then11, label %else12
then11:
  %t33 = load double, double* %l0
  %t34 = sitofp i64 1 to double
  %t35 = fsub double %t33, %t34
  store double %t35, double* %l0
  %t36 = load double, double* %l0
  %t37 = sitofp i64 0 to double
  %t38 = fcmp oeq double %t36, %t37
  %t39 = load double, double* %l0
  %t40 = load double, double* %l1
  %t41 = load i8, i8* %l2
  br i1 %t38, label %then14, label %merge15
then14:
  %t42 = load double, double* %l1
  ret double %t42
merge15:
  %t43 = load double, double* %l0
  br label %merge13
else12:
  %t44 = load double, double* %l1
  ret double %t44
merge13:
  %t45 = load double, double* %l0
  br label %merge10
merge10:
  %t46 = phi double [ %t45, %merge13 ], [ %t24, %else7 ]
  store double %t46, double* %l0
  %t47 = load double, double* %l0
  br label %merge8
merge8:
  %t48 = phi double [ %t21, %then6 ], [ %t47, %merge10 ]
  store double %t48, double* %l0
  %t49 = load double, double* %l1
  %t50 = sitofp i64 1 to double
  %t51 = fadd double %t49, %t50
  store double %t51, double* %l1
  br label %loop.latch2
loop.latch2:
  %t52 = load double, double* %l0
  %t53 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t56 = load double, double* %l0
  %t57 = load double, double* %l1
  %t58 = sitofp i64 -1 to double
  ret double %t58
}

define double @find_matching_paren(i8* %text, double %start_index) {
block.entry:
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
  %t116 = phi double [ %t2, %block.entry ], [ %t114, %loop.latch2 ]
  %t117 = phi double [ %t1, %block.entry ], [ %t115, %loop.latch2 ]
  store double %t116, double* %l1
  store double %t117, double* %l0
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
  %t68 = load double, double* %l3
  %t69 = load double, double* %l1
  %t70 = load double, double* %l1
  br label %merge8
else7:
  %t71 = load i8, i8* %l2
  %t72 = icmp eq i8 %t71, 40
  %t73 = load double, double* %l0
  %t74 = load double, double* %l1
  %t75 = load i8, i8* %l2
  br i1 %t72, label %then19, label %else20
then19:
  %t76 = load double, double* %l0
  %t77 = sitofp i64 1 to double
  %t78 = fadd double %t76, %t77
  store double %t78, double* %l0
  %t79 = load double, double* %l0
  br label %merge21
else20:
  %t80 = load i8, i8* %l2
  %t81 = icmp eq i8 %t80, 41
  %t82 = load double, double* %l0
  %t83 = load double, double* %l1
  %t84 = load i8, i8* %l2
  br i1 %t81, label %then22, label %merge23
then22:
  %t85 = load double, double* %l0
  %t86 = sitofp i64 0 to double
  %t87 = fcmp ogt double %t85, %t86
  %t88 = load double, double* %l0
  %t89 = load double, double* %l1
  %t90 = load i8, i8* %l2
  br i1 %t87, label %then24, label %else25
then24:
  %t91 = load double, double* %l0
  %t92 = sitofp i64 1 to double
  %t93 = fsub double %t91, %t92
  store double %t93, double* %l0
  %t94 = load double, double* %l0
  %t95 = sitofp i64 0 to double
  %t96 = fcmp oeq double %t94, %t95
  %t97 = load double, double* %l0
  %t98 = load double, double* %l1
  %t99 = load i8, i8* %l2
  br i1 %t96, label %then27, label %merge28
then27:
  %t100 = load double, double* %l1
  ret double %t100
merge28:
  %t101 = load double, double* %l0
  br label %merge26
else25:
  %t102 = sitofp i64 -1 to double
  ret double %t102
merge26:
  %t103 = load double, double* %l0
  br label %merge23
merge23:
  %t104 = phi double [ %t103, %merge26 ], [ %t82, %else20 ]
  store double %t104, double* %l0
  %t105 = load double, double* %l0
  br label %merge21
merge21:
  %t106 = phi double [ %t79, %then19 ], [ %t105, %merge23 ]
  store double %t106, double* %l0
  %t107 = load double, double* %l0
  %t108 = load double, double* %l0
  br label %merge8
merge8:
  %t109 = phi double [ %t70, %afterloop12 ], [ %t20, %merge21 ]
  %t110 = phi double [ %t19, %afterloop12 ], [ %t107, %merge21 ]
  store double %t109, double* %l1
  store double %t110, double* %l0
  %t111 = load double, double* %l1
  %t112 = sitofp i64 1 to double
  %t113 = fadd double %t111, %t112
  store double %t113, double* %l1
  br label %loop.latch2
loop.latch2:
  %t114 = load double, double* %l1
  %t115 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t118 = load double, double* %l1
  %t119 = load double, double* %l0
  %t120 = sitofp i64 -1 to double
  ret double %t120
}

define %EnumParseResult @parse_enum_definition({ i8**, i64 }* %lines, double %start_index) {
block.entry:
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
  %t0 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t1 = ptrtoint [0 x i8*]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to i8**
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t7 = ptrtoint { i8**, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { i8**, i64 }*
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 0
  store i8** %t5, i8*** %t10
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { i8**, i64 }* %t9, { i8**, i64 }** %l0
  %t12 = fptosi double %start_index to i64
  %t13 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t14 = extractvalue { i8**, i64 } %t13, 0
  %t15 = extractvalue { i8**, i64 } %t13, 1
  %t16 = icmp uge i64 %t12, %t15
  ; bounds check: %t16 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t12, i64 %t15)
  %t17 = getelementptr i8*, i8** %t14, i64 %t12
  %t18 = load i8*, i8** %t17
  %t19 = call i8* @trim_text(i8* %t18)
  store i8* %t19, i8** %l1
  %t20 = load i8*, i8** %l1
  %s21 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1280947313, i32 0, i32 0
  %t22 = call i8* @strip_prefix(i8* %t20, i8* %s21)
  %t23 = call i8* @trim_text(i8* %t22)
  store i8* %t23, i8** %l2
  %t24 = load i8*, i8** %l2
  store i8* %t24, i8** %l3
  %t25 = load i8*, i8** %l3
  %t26 = alloca [2 x i8], align 1
  %t27 = getelementptr [2 x i8], [2 x i8]* %t26, i32 0, i32 0
  store i8 32, i8* %t27
  %t28 = getelementptr [2 x i8], [2 x i8]* %t26, i32 0, i32 1
  store i8 0, i8* %t28
  %t29 = getelementptr [2 x i8], [2 x i8]* %t26, i32 0, i32 0
  %t30 = call double @index_of(i8* %t25, i8* %t29)
  store double %t30, double* %l4
  %t31 = load double, double* %l4
  %t32 = sitofp i64 0 to double
  %t33 = fcmp oge double %t31, %t32
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t35 = load i8*, i8** %l1
  %t36 = load i8*, i8** %l2
  %t37 = load i8*, i8** %l3
  %t38 = load double, double* %l4
  br i1 %t33, label %then0, label %merge1
then0:
  %t39 = load i8*, i8** %l3
  %t40 = load double, double* %l4
  %t41 = fptosi double %t40 to i64
  %t42 = call i8* @sailfin_runtime_substring(i8* %t39, i64 0, i64 %t41)
  %t43 = call i8* @trim_text(i8* %t42)
  store i8* %t43, i8** %l3
  %t44 = load i8*, i8** %l3
  br label %merge1
merge1:
  %t45 = phi i8* [ %t44, %then0 ], [ %t37, %block.entry ]
  store i8* %t45, i8** %l3
  %t46 = load i8*, i8** %l3
  %t47 = call i8* @strip_generics(i8* %t46)
  store i8* %t47, i8** %l3
  %t48 = load i8*, i8** %l3
  %t49 = call i64 @sailfin_runtime_string_length(i8* %t48)
  %t50 = icmp eq i64 %t49, 0
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t52 = load i8*, i8** %l1
  %t53 = load i8*, i8** %l2
  %t54 = load i8*, i8** %l3
  %t55 = load double, double* %l4
  br i1 %t50, label %then2, label %merge3
then2:
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s57 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.len29.h668562564, i32 0, i32 0
  %t58 = load i8*, i8** %l1
  %t59 = call i8* @sailfin_runtime_string_concat(i8* %s57, i8* %t58)
  %t60 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t56, i8* %t59)
  store { i8**, i64 }* %t60, { i8**, i64 }** %l0
  %t61 = bitcast i8* null to %NativeEnum*
  %t62 = insertvalue %EnumParseResult undef, %NativeEnum* %t61, 0
  %t63 = sitofp i64 1 to double
  %t64 = fadd double %start_index, %t63
  %t65 = insertvalue %EnumParseResult %t62, double %t64, 1
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t67 = insertvalue %EnumParseResult %t65, { i8**, i64 }* %t66, 2
  ret %EnumParseResult %t67
merge3:
  %t68 = getelementptr [0 x %NativeEnumVariant], [0 x %NativeEnumVariant]* null, i32 1
  %t69 = ptrtoint [0 x %NativeEnumVariant]* %t68 to i64
  %t70 = icmp eq i64 %t69, 0
  %t71 = select i1 %t70, i64 1, i64 %t69
  %t72 = call i8* @malloc(i64 %t71)
  %t73 = bitcast i8* %t72 to %NativeEnumVariant*
  %t74 = getelementptr { %NativeEnumVariant*, i64 }, { %NativeEnumVariant*, i64 }* null, i32 1
  %t75 = ptrtoint { %NativeEnumVariant*, i64 }* %t74 to i64
  %t76 = call i8* @malloc(i64 %t75)
  %t77 = bitcast i8* %t76 to { %NativeEnumVariant*, i64 }*
  %t78 = getelementptr { %NativeEnumVariant*, i64 }, { %NativeEnumVariant*, i64 }* %t77, i32 0, i32 0
  store %NativeEnumVariant* %t73, %NativeEnumVariant** %t78
  %t79 = getelementptr { %NativeEnumVariant*, i64 }, { %NativeEnumVariant*, i64 }* %t77, i32 0, i32 1
  store i64 0, i64* %t79
  store { %NativeEnumVariant*, i64 }* %t77, { %NativeEnumVariant*, i64 }** %l5
  %t80 = getelementptr [0 x %NativeEnumVariantLayout], [0 x %NativeEnumVariantLayout]* null, i32 1
  %t81 = ptrtoint [0 x %NativeEnumVariantLayout]* %t80 to i64
  %t82 = icmp eq i64 %t81, 0
  %t83 = select i1 %t82, i64 1, i64 %t81
  %t84 = call i8* @malloc(i64 %t83)
  %t85 = bitcast i8* %t84 to %NativeEnumVariantLayout*
  %t86 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* null, i32 1
  %t87 = ptrtoint { %NativeEnumVariantLayout*, i64 }* %t86 to i64
  %t88 = call i8* @malloc(i64 %t87)
  %t89 = bitcast i8* %t88 to { %NativeEnumVariantLayout*, i64 }*
  %t90 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t89, i32 0, i32 0
  store %NativeEnumVariantLayout* %t85, %NativeEnumVariantLayout** %t90
  %t91 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t89, i32 0, i32 1
  store i64 0, i64* %t91
  store { %NativeEnumVariantLayout*, i64 }* %t89, { %NativeEnumVariantLayout*, i64 }** %l6
  %t92 = sitofp i64 0 to double
  store double %t92, double* %l7
  %t93 = sitofp i64 0 to double
  store double %t93, double* %l8
  %s94 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s94, i8** %l9
  %t95 = sitofp i64 0 to double
  store double %t95, double* %l10
  %t96 = sitofp i64 0 to double
  store double %t96, double* %l11
  store i1 0, i1* %l12
  store i1 0, i1* %l13
  %t97 = sitofp i64 1 to double
  %t98 = fadd double %start_index, %t97
  store double %t98, double* %l14
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t100 = load i8*, i8** %l1
  %t101 = load i8*, i8** %l2
  %t102 = load i8*, i8** %l3
  %t103 = load double, double* %l4
  %t104 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t105 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t106 = load double, double* %l7
  %t107 = load double, double* %l8
  %t108 = load i8*, i8** %l9
  %t109 = load double, double* %l10
  %t110 = load double, double* %l11
  %t111 = load i1, i1* %l12
  %t112 = load i1, i1* %l13
  %t113 = load double, double* %l14
  br label %loop.header4
loop.header4:
  %t819 = phi { i8**, i64 }* [ %t99, %merge3 ], [ %t808, %loop.latch6 ]
  %t820 = phi double [ %t113, %merge3 ], [ %t809, %loop.latch6 ]
  %t821 = phi double [ %t106, %merge3 ], [ %t810, %loop.latch6 ]
  %t822 = phi double [ %t107, %merge3 ], [ %t811, %loop.latch6 ]
  %t823 = phi i8* [ %t108, %merge3 ], [ %t812, %loop.latch6 ]
  %t824 = phi double [ %t109, %merge3 ], [ %t813, %loop.latch6 ]
  %t825 = phi double [ %t110, %merge3 ], [ %t814, %loop.latch6 ]
  %t826 = phi i1 [ %t111, %merge3 ], [ %t815, %loop.latch6 ]
  %t827 = phi { %NativeEnumVariantLayout*, i64 }* [ %t105, %merge3 ], [ %t816, %loop.latch6 ]
  %t828 = phi i1 [ %t112, %merge3 ], [ %t817, %loop.latch6 ]
  %t829 = phi { %NativeEnumVariant*, i64 }* [ %t104, %merge3 ], [ %t818, %loop.latch6 ]
  store { i8**, i64 }* %t819, { i8**, i64 }** %l0
  store double %t820, double* %l14
  store double %t821, double* %l7
  store double %t822, double* %l8
  store i8* %t823, i8** %l9
  store double %t824, double* %l10
  store double %t825, double* %l11
  store i1 %t826, i1* %l12
  store { %NativeEnumVariantLayout*, i64 }* %t827, { %NativeEnumVariantLayout*, i64 }** %l6
  store i1 %t828, i1* %l13
  store { %NativeEnumVariant*, i64 }* %t829, { %NativeEnumVariant*, i64 }** %l5
  br label %loop.body5
loop.body5:
  %t114 = load double, double* %l14
  %t115 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t116 = extractvalue { i8**, i64 } %t115, 1
  %t117 = sitofp i64 %t116 to double
  %t118 = fcmp oge double %t114, %t117
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
  br i1 %t118, label %then8, label %merge9
then8:
  %t134 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s135 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.len18.h1997941781, i32 0, i32 0
  %t136 = load i8*, i8** %l3
  %t137 = call i8* @sailfin_runtime_string_concat(i8* %s135, i8* %t136)
  %t138 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t134, i8* %t137)
  store { i8**, i64 }* %t138, { i8**, i64 }** %l0
  %t139 = bitcast i8* null to %NativeEnumLayout*
  store %NativeEnumLayout* %t139, %NativeEnumLayout** %l15
  %t140 = load i1, i1* %l12
  %t141 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t142 = load i8*, i8** %l1
  %t143 = load i8*, i8** %l2
  %t144 = load i8*, i8** %l3
  %t145 = load double, double* %l4
  %t146 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t147 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t148 = load double, double* %l7
  %t149 = load double, double* %l8
  %t150 = load i8*, i8** %l9
  %t151 = load double, double* %l10
  %t152 = load double, double* %l11
  %t153 = load i1, i1* %l12
  %t154 = load i1, i1* %l13
  %t155 = load double, double* %l14
  %t156 = load %NativeEnumLayout*, %NativeEnumLayout** %l15
  br i1 %t140, label %then10, label %merge11
then10:
  %t157 = load double, double* %l7
  %t158 = insertvalue %NativeEnumLayout undef, double %t157, 0
  %t159 = load double, double* %l8
  %t160 = insertvalue %NativeEnumLayout %t158, double %t159, 1
  %t161 = load i8*, i8** %l9
  %t162 = insertvalue %NativeEnumLayout %t160, i8* %t161, 2
  %t163 = load double, double* %l10
  %t164 = insertvalue %NativeEnumLayout %t162, double %t163, 3
  %t165 = load double, double* %l11
  %t166 = insertvalue %NativeEnumLayout %t164, double %t165, 4
  %t167 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t168 = bitcast { %NativeEnumVariantLayout*, i64 }* %t167 to { %NativeEnumVariantLayout**, i64 }*
  %t169 = insertvalue %NativeEnumLayout %t166, { %NativeEnumVariantLayout**, i64 }* %t168, 5
  %t170 = alloca %NativeEnumLayout
  store %NativeEnumLayout %t169, %NativeEnumLayout* %t170
  store %NativeEnumLayout* %t170, %NativeEnumLayout** %l15
  %t171 = load %NativeEnumLayout*, %NativeEnumLayout** %l15
  br label %merge11
merge11:
  %t172 = phi %NativeEnumLayout* [ %t171, %then10 ], [ %t156, %then8 ]
  store %NativeEnumLayout* %t172, %NativeEnumLayout** %l15
  %t173 = load i8*, i8** %l3
  %t174 = insertvalue %NativeEnum undef, i8* %t173, 0
  %t175 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t176 = bitcast { %NativeEnumVariant*, i64 }* %t175 to { %NativeEnumVariant**, i64 }*
  %t177 = insertvalue %NativeEnum %t174, { %NativeEnumVariant**, i64 }* %t176, 1
  %t178 = load %NativeEnumLayout*, %NativeEnumLayout** %l15
  %t179 = insertvalue %NativeEnum %t177, %NativeEnumLayout* %t178, 2
  %t180 = alloca %NativeEnum
  store %NativeEnum %t179, %NativeEnum* %t180
  %t181 = insertvalue %EnumParseResult undef, %NativeEnum* %t180, 0
  %t182 = load double, double* %l14
  %t183 = insertvalue %EnumParseResult %t181, double %t182, 1
  %t184 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t185 = insertvalue %EnumParseResult %t183, { i8**, i64 }* %t184, 2
  ret %EnumParseResult %t185
merge9:
  %t186 = load double, double* %l14
  %t187 = fptosi double %t186 to i64
  %t188 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t189 = extractvalue { i8**, i64 } %t188, 0
  %t190 = extractvalue { i8**, i64 } %t188, 1
  %t191 = icmp uge i64 %t187, %t190
  ; bounds check: %t191 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t187, i64 %t190)
  %t192 = getelementptr i8*, i8** %t189, i64 %t187
  %t193 = load i8*, i8** %t192
  %t194 = call i8* @trim_text(i8* %t193)
  store i8* %t194, i8** %l16
  %t196 = load i8*, i8** %l16
  %t197 = call i64 @sailfin_runtime_string_length(i8* %t196)
  %t198 = icmp eq i64 %t197, 0
  br label %logical_or_entry_195

logical_or_entry_195:
  br i1 %t198, label %logical_or_merge_195, label %logical_or_right_195

logical_or_right_195:
  %t199 = load i8*, i8** %l16
  %t200 = alloca [2 x i8], align 1
  %t201 = getelementptr [2 x i8], [2 x i8]* %t200, i32 0, i32 0
  store i8 59, i8* %t201
  %t202 = getelementptr [2 x i8], [2 x i8]* %t200, i32 0, i32 1
  store i8 0, i8* %t202
  %t203 = getelementptr [2 x i8], [2 x i8]* %t200, i32 0, i32 0
  %t204 = call i1 @starts_with(i8* %t199, i8* %t203)
  br label %logical_or_right_end_195

logical_or_right_end_195:
  br label %logical_or_merge_195

logical_or_merge_195:
  %t205 = phi i1 [ true, %logical_or_entry_195 ], [ %t204, %logical_or_right_end_195 ]
  %t206 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t207 = load i8*, i8** %l1
  %t208 = load i8*, i8** %l2
  %t209 = load i8*, i8** %l3
  %t210 = load double, double* %l4
  %t211 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t212 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t213 = load double, double* %l7
  %t214 = load double, double* %l8
  %t215 = load i8*, i8** %l9
  %t216 = load double, double* %l10
  %t217 = load double, double* %l11
  %t218 = load i1, i1* %l12
  %t219 = load i1, i1* %l13
  %t220 = load double, double* %l14
  %t221 = load i8*, i8** %l16
  br i1 %t205, label %then12, label %merge13
then12:
  %t222 = load double, double* %l14
  %t223 = sitofp i64 1 to double
  %t224 = fadd double %t222, %t223
  store double %t224, double* %l14
  br label %loop.latch6
merge13:
  %t225 = load i8*, i8** %l16
  %s226 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h268717223, i32 0, i32 0
  %t227 = icmp eq i8* %t225, %s226
  %t228 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t229 = load i8*, i8** %l1
  %t230 = load i8*, i8** %l2
  %t231 = load i8*, i8** %l3
  %t232 = load double, double* %l4
  %t233 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t234 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t235 = load double, double* %l7
  %t236 = load double, double* %l8
  %t237 = load i8*, i8** %l9
  %t238 = load double, double* %l10
  %t239 = load double, double* %l11
  %t240 = load i1, i1* %l12
  %t241 = load i1, i1* %l13
  %t242 = load double, double* %l14
  %t243 = load i8*, i8** %l16
  br i1 %t227, label %then14, label %merge15
then14:
  %t244 = load double, double* %l14
  %t245 = sitofp i64 1 to double
  %t246 = fadd double %t244, %t245
  store double %t246, double* %l14
  br label %loop.latch6
merge15:
  %t247 = load i8*, i8** %l16
  %s248 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1616485352, i32 0, i32 0
  %t249 = call i1 @starts_with(i8* %t247, i8* %s248)
  %t250 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t251 = load i8*, i8** %l1
  %t252 = load i8*, i8** %l2
  %t253 = load i8*, i8** %l3
  %t254 = load double, double* %l4
  %t255 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t256 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t257 = load double, double* %l7
  %t258 = load double, double* %l8
  %t259 = load i8*, i8** %l9
  %t260 = load double, double* %l10
  %t261 = load double, double* %l11
  %t262 = load i1, i1* %l12
  %t263 = load i1, i1* %l13
  %t264 = load double, double* %l14
  %t265 = load i8*, i8** %l16
  br i1 %t249, label %then16, label %merge17
then16:
  %t266 = load i8*, i8** %l16
  %s267 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1616485352, i32 0, i32 0
  %t268 = call i8* @strip_prefix(i8* %t266, i8* %s267)
  store i8* %t268, i8** %l17
  %t269 = load i8*, i8** %l17
  %s270 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t271 = call i1 @starts_with(i8* %t269, i8* %s270)
  %t272 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t273 = load i8*, i8** %l1
  %t274 = load i8*, i8** %l2
  %t275 = load i8*, i8** %l3
  %t276 = load double, double* %l4
  %t277 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t278 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t279 = load double, double* %l7
  %t280 = load double, double* %l8
  %t281 = load i8*, i8** %l9
  %t282 = load double, double* %l10
  %t283 = load double, double* %l11
  %t284 = load i1, i1* %l12
  %t285 = load i1, i1* %l13
  %t286 = load double, double* %l14
  %t287 = load i8*, i8** %l16
  %t288 = load i8*, i8** %l17
  br i1 %t271, label %then18, label %merge19
then18:
  %t289 = load i8*, i8** %l17
  %s290 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t291 = call i8* @strip_prefix(i8* %t289, i8* %s290)
  %t292 = call %EnumLayoutHeaderParse @parse_enum_layout_header(i8* %t291)
  store %EnumLayoutHeaderParse %t292, %EnumLayoutHeaderParse* %l18
  %t293 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t294 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t295 = extractvalue %EnumLayoutHeaderParse %t294, 7
  %t296 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t293, { i8**, i64 }* %t295)
  store { i8**, i64 }* %t296, { i8**, i64 }** %l0
  %t297 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t298 = extractvalue %EnumLayoutHeaderParse %t297, 0
  %t299 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t300 = load i8*, i8** %l1
  %t301 = load i8*, i8** %l2
  %t302 = load i8*, i8** %l3
  %t303 = load double, double* %l4
  %t304 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t305 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t306 = load double, double* %l7
  %t307 = load double, double* %l8
  %t308 = load i8*, i8** %l9
  %t309 = load double, double* %l10
  %t310 = load double, double* %l11
  %t311 = load i1, i1* %l12
  %t312 = load i1, i1* %l13
  %t313 = load double, double* %l14
  %t314 = load i8*, i8** %l16
  %t315 = load i8*, i8** %l17
  %t316 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  br i1 %t298, label %then20, label %merge21
then20:
  %t317 = load i1, i1* %l12
  %t318 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t319 = load i8*, i8** %l1
  %t320 = load i8*, i8** %l2
  %t321 = load i8*, i8** %l3
  %t322 = load double, double* %l4
  %t323 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t324 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t325 = load double, double* %l7
  %t326 = load double, double* %l8
  %t327 = load i8*, i8** %l9
  %t328 = load double, double* %l10
  %t329 = load double, double* %l11
  %t330 = load i1, i1* %l12
  %t331 = load i1, i1* %l13
  %t332 = load double, double* %l14
  %t333 = load i8*, i8** %l16
  %t334 = load i8*, i8** %l17
  %t335 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  br i1 %t317, label %then22, label %else23
then22:
  %t336 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s337 = getelementptr inbounds [33 x i8], [33 x i8]* @.str.len32.h1822658020, i32 0, i32 0
  %t338 = load i8*, i8** %l3
  %t339 = call i8* @sailfin_runtime_string_concat(i8* %s337, i8* %t338)
  %t340 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t336, i8* %t339)
  store { i8**, i64 }* %t340, { i8**, i64 }** %l0
  %t341 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge24
else23:
  %t342 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t343 = extractvalue %EnumLayoutHeaderParse %t342, 2
  store double %t343, double* %l7
  %t344 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t345 = extractvalue %EnumLayoutHeaderParse %t344, 3
  store double %t345, double* %l8
  %t346 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t347 = extractvalue %EnumLayoutHeaderParse %t346, 4
  store i8* %t347, i8** %l9
  %t348 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t349 = extractvalue %EnumLayoutHeaderParse %t348, 5
  store double %t349, double* %l10
  %t350 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t351 = extractvalue %EnumLayoutHeaderParse %t350, 6
  store double %t351, double* %l11
  store i1 1, i1* %l12
  %t352 = load double, double* %l7
  %t353 = load double, double* %l8
  %t354 = load i8*, i8** %l9
  %t355 = load double, double* %l10
  %t356 = load double, double* %l11
  %t357 = load i1, i1* %l12
  br label %merge24
merge24:
  %t358 = phi { i8**, i64 }* [ %t341, %then22 ], [ %t318, %else23 ]
  %t359 = phi double [ %t325, %then22 ], [ %t352, %else23 ]
  %t360 = phi double [ %t326, %then22 ], [ %t353, %else23 ]
  %t361 = phi i8* [ %t327, %then22 ], [ %t354, %else23 ]
  %t362 = phi double [ %t328, %then22 ], [ %t355, %else23 ]
  %t363 = phi double [ %t329, %then22 ], [ %t356, %else23 ]
  %t364 = phi i1 [ %t330, %then22 ], [ %t357, %else23 ]
  store { i8**, i64 }* %t358, { i8**, i64 }** %l0
  store double %t359, double* %l7
  store double %t360, double* %l8
  store i8* %t361, i8** %l9
  store double %t362, double* %l10
  store double %t363, double* %l11
  store i1 %t364, i1* %l12
  %t365 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t366 = load double, double* %l7
  %t367 = load double, double* %l8
  %t368 = load i8*, i8** %l9
  %t369 = load double, double* %l10
  %t370 = load double, double* %l11
  %t371 = load i1, i1* %l12
  br label %merge21
merge21:
  %t372 = phi { i8**, i64 }* [ %t365, %merge24 ], [ %t299, %then18 ]
  %t373 = phi double [ %t366, %merge24 ], [ %t306, %then18 ]
  %t374 = phi double [ %t367, %merge24 ], [ %t307, %then18 ]
  %t375 = phi i8* [ %t368, %merge24 ], [ %t308, %then18 ]
  %t376 = phi double [ %t369, %merge24 ], [ %t309, %then18 ]
  %t377 = phi double [ %t370, %merge24 ], [ %t310, %then18 ]
  %t378 = phi i1 [ %t371, %merge24 ], [ %t311, %then18 ]
  store { i8**, i64 }* %t372, { i8**, i64 }** %l0
  store double %t373, double* %l7
  store double %t374, double* %l8
  store i8* %t375, i8** %l9
  store double %t376, double* %l10
  store double %t377, double* %l11
  store i1 %t378, i1* %l12
  %t379 = load double, double* %l14
  %t380 = sitofp i64 1 to double
  %t381 = fadd double %t379, %t380
  store double %t381, double* %l14
  br label %loop.latch6
merge19:
  %t382 = load i8*, i8** %l17
  %s383 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1926252274, i32 0, i32 0
  %t384 = call i1 @starts_with(i8* %t382, i8* %s383)
  %t385 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t386 = load i8*, i8** %l1
  %t387 = load i8*, i8** %l2
  %t388 = load i8*, i8** %l3
  %t389 = load double, double* %l4
  %t390 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t391 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t392 = load double, double* %l7
  %t393 = load double, double* %l8
  %t394 = load i8*, i8** %l9
  %t395 = load double, double* %l10
  %t396 = load double, double* %l11
  %t397 = load i1, i1* %l12
  %t398 = load i1, i1* %l13
  %t399 = load double, double* %l14
  %t400 = load i8*, i8** %l16
  %t401 = load i8*, i8** %l17
  br i1 %t384, label %then25, label %merge26
then25:
  %t402 = load i8*, i8** %l17
  %s403 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1926252274, i32 0, i32 0
  %t404 = call i8* @strip_prefix(i8* %t402, i8* %s403)
  %t405 = load i8*, i8** %l3
  %t406 = call %EnumLayoutVariantParse @parse_enum_variant_layout(i8* %t404, i8* %t405)
  store %EnumLayoutVariantParse %t406, %EnumLayoutVariantParse* %l19
  %t407 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t408 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t409 = extractvalue %EnumLayoutVariantParse %t408, 2
  %t410 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t407, { i8**, i64 }* %t409)
  store { i8**, i64 }* %t410, { i8**, i64 }** %l0
  %t411 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t412 = extractvalue %EnumLayoutVariantParse %t411, 0
  %t413 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t414 = load i8*, i8** %l1
  %t415 = load i8*, i8** %l2
  %t416 = load i8*, i8** %l3
  %t417 = load double, double* %l4
  %t418 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t419 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t420 = load double, double* %l7
  %t421 = load double, double* %l8
  %t422 = load i8*, i8** %l9
  %t423 = load double, double* %l10
  %t424 = load double, double* %l11
  %t425 = load i1, i1* %l12
  %t426 = load i1, i1* %l13
  %t427 = load double, double* %l14
  %t428 = load i8*, i8** %l16
  %t429 = load i8*, i8** %l17
  %t430 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  br i1 %t412, label %then27, label %merge28
then27:
  %t431 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t432 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t433 = extractvalue %EnumLayoutVariantParse %t432, 1
  %t434 = extractvalue %NativeEnumVariantLayout %t433, 0
  %t435 = call double @find_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t431, i8* %t434)
  store double %t435, double* %l20
  %t436 = load double, double* %l20
  %t437 = sitofp i64 0 to double
  %t438 = fcmp oge double %t436, %t437
  %t439 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t440 = load i8*, i8** %l1
  %t441 = load i8*, i8** %l2
  %t442 = load i8*, i8** %l3
  %t443 = load double, double* %l4
  %t444 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t445 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t446 = load double, double* %l7
  %t447 = load double, double* %l8
  %t448 = load i8*, i8** %l9
  %t449 = load double, double* %l10
  %t450 = load double, double* %l11
  %t451 = load i1, i1* %l12
  %t452 = load i1, i1* %l13
  %t453 = load double, double* %l14
  %t454 = load i8*, i8** %l16
  %t455 = load i8*, i8** %l17
  %t456 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t457 = load double, double* %l20
  br i1 %t438, label %then29, label %else30
then29:
  %t458 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s459 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.len31.h1924917952, i32 0, i32 0
  %t460 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t461 = extractvalue %EnumLayoutVariantParse %t460, 1
  %t462 = extractvalue %NativeEnumVariantLayout %t461, 0
  %t463 = call i8* @sailfin_runtime_string_concat(i8* %s459, i8* %t462)
  %s464 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1783417286, i32 0, i32 0
  %t465 = call i8* @sailfin_runtime_string_concat(i8* %t463, i8* %s464)
  %t466 = load i8*, i8** %l3
  %t467 = call i8* @sailfin_runtime_string_concat(i8* %t465, i8* %t466)
  %t468 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t458, i8* %t467)
  store { i8**, i64 }* %t468, { i8**, i64 }** %l0
  %t469 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge31
else30:
  %t470 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t471 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t472 = extractvalue %EnumLayoutVariantParse %t471, 1
  %t473 = call { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t470, %NativeEnumVariantLayout %t472)
  store { %NativeEnumVariantLayout*, i64 }* %t473, { %NativeEnumVariantLayout*, i64 }** %l6
  %t474 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  br label %merge31
merge31:
  %t475 = phi { i8**, i64 }* [ %t469, %then29 ], [ %t439, %else30 ]
  %t476 = phi { %NativeEnumVariantLayout*, i64 }* [ %t445, %then29 ], [ %t474, %else30 ]
  store { i8**, i64 }* %t475, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t476, { %NativeEnumVariantLayout*, i64 }** %l6
  %t477 = load i1, i1* %l12
  %t478 = xor i1 %t477, 1
  %t479 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t480 = load i8*, i8** %l1
  %t481 = load i8*, i8** %l2
  %t482 = load i8*, i8** %l3
  %t483 = load double, double* %l4
  %t484 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t485 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t486 = load double, double* %l7
  %t487 = load double, double* %l8
  %t488 = load i8*, i8** %l9
  %t489 = load double, double* %l10
  %t490 = load double, double* %l11
  %t491 = load i1, i1* %l12
  %t492 = load i1, i1* %l13
  %t493 = load double, double* %l14
  %t494 = load i8*, i8** %l16
  %t495 = load i8*, i8** %l17
  %t496 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t497 = load double, double* %l20
  br i1 %t478, label %then32, label %merge33
then32:
  %t498 = load i1, i1* %l13
  %t499 = xor i1 %t498, 1
  %t500 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t501 = load i8*, i8** %l1
  %t502 = load i8*, i8** %l2
  %t503 = load i8*, i8** %l3
  %t504 = load double, double* %l4
  %t505 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t506 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t507 = load double, double* %l7
  %t508 = load double, double* %l8
  %t509 = load i8*, i8** %l9
  %t510 = load double, double* %l10
  %t511 = load double, double* %l11
  %t512 = load i1, i1* %l12
  %t513 = load i1, i1* %l13
  %t514 = load double, double* %l14
  %t515 = load i8*, i8** %l16
  %t516 = load i8*, i8** %l17
  %t517 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t518 = load double, double* %l20
  br i1 %t499, label %then34, label %merge35
then34:
  %t519 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s520 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t521 = load i8*, i8** %l3
  %t522 = call i8* @sailfin_runtime_string_concat(i8* %s520, i8* %t521)
  %s523 = getelementptr inbounds [49 x i8], [49 x i8]* @.str.len48.h235936117, i32 0, i32 0
  %t524 = call i8* @sailfin_runtime_string_concat(i8* %t522, i8* %s523)
  %t525 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t519, i8* %t524)
  store { i8**, i64 }* %t525, { i8**, i64 }** %l0
  store i1 1, i1* %l13
  %t526 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t527 = load i1, i1* %l13
  br label %merge35
merge35:
  %t528 = phi { i8**, i64 }* [ %t526, %then34 ], [ %t500, %then32 ]
  %t529 = phi i1 [ %t527, %then34 ], [ %t513, %then32 ]
  store { i8**, i64 }* %t528, { i8**, i64 }** %l0
  store i1 %t529, i1* %l13
  %t530 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t531 = load i1, i1* %l13
  br label %merge33
merge33:
  %t532 = phi { i8**, i64 }* [ %t530, %merge35 ], [ %t479, %merge31 ]
  %t533 = phi i1 [ %t531, %merge35 ], [ %t492, %merge31 ]
  store { i8**, i64 }* %t532, { i8**, i64 }** %l0
  store i1 %t533, i1* %l13
  %t534 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t535 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t536 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t537 = load i1, i1* %l13
  br label %merge28
merge28:
  %t538 = phi { i8**, i64 }* [ %t534, %merge33 ], [ %t413, %then25 ]
  %t539 = phi { %NativeEnumVariantLayout*, i64 }* [ %t535, %merge33 ], [ %t419, %then25 ]
  %t540 = phi { i8**, i64 }* [ %t536, %merge33 ], [ %t413, %then25 ]
  %t541 = phi i1 [ %t537, %merge33 ], [ %t426, %then25 ]
  store { i8**, i64 }* %t538, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t539, { %NativeEnumVariantLayout*, i64 }** %l6
  store { i8**, i64 }* %t540, { i8**, i64 }** %l0
  store i1 %t541, i1* %l13
  %t542 = load double, double* %l14
  %t543 = sitofp i64 1 to double
  %t544 = fadd double %t542, %t543
  store double %t544, double* %l14
  br label %loop.latch6
merge26:
  %t545 = load i8*, i8** %l17
  %s546 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1521657554, i32 0, i32 0
  %t547 = call i1 @starts_with(i8* %t545, i8* %s546)
  %t548 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t549 = load i8*, i8** %l1
  %t550 = load i8*, i8** %l2
  %t551 = load i8*, i8** %l3
  %t552 = load double, double* %l4
  %t553 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t554 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t555 = load double, double* %l7
  %t556 = load double, double* %l8
  %t557 = load i8*, i8** %l9
  %t558 = load double, double* %l10
  %t559 = load double, double* %l11
  %t560 = load i1, i1* %l12
  %t561 = load i1, i1* %l13
  %t562 = load double, double* %l14
  %t563 = load i8*, i8** %l16
  %t564 = load i8*, i8** %l17
  br i1 %t547, label %then36, label %merge37
then36:
  %t565 = load i8*, i8** %l17
  %s566 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1521657554, i32 0, i32 0
  %t567 = call i8* @strip_prefix(i8* %t565, i8* %s566)
  %t568 = load i8*, i8** %l3
  %t569 = call %EnumLayoutPayloadParse @parse_enum_payload_layout(i8* %t567, i8* %t568)
  store %EnumLayoutPayloadParse %t569, %EnumLayoutPayloadParse* %l21
  %t570 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t571 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t572 = extractvalue %EnumLayoutPayloadParse %t571, 3
  %t573 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t570, { i8**, i64 }* %t572)
  store { i8**, i64 }* %t573, { i8**, i64 }** %l0
  %t574 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t575 = extractvalue %EnumLayoutPayloadParse %t574, 0
  %t576 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t577 = load i8*, i8** %l1
  %t578 = load i8*, i8** %l2
  %t579 = load i8*, i8** %l3
  %t580 = load double, double* %l4
  %t581 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t582 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t583 = load double, double* %l7
  %t584 = load double, double* %l8
  %t585 = load i8*, i8** %l9
  %t586 = load double, double* %l10
  %t587 = load double, double* %l11
  %t588 = load i1, i1* %l12
  %t589 = load i1, i1* %l13
  %t590 = load double, double* %l14
  %t591 = load i8*, i8** %l16
  %t592 = load i8*, i8** %l17
  %t593 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  br i1 %t575, label %then38, label %merge39
then38:
  %t594 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t595 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t596 = extractvalue %EnumLayoutPayloadParse %t595, 1
  %t597 = call double @find_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t594, i8* %t596)
  store double %t597, double* %l22
  %t598 = load double, double* %l22
  %t599 = sitofp i64 0 to double
  %t600 = fcmp olt double %t598, %t599
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
  br i1 %t600, label %then40, label %else41
then40:
  %t620 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s621 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t622 = load i8*, i8** %l3
  %t623 = call i8* @sailfin_runtime_string_concat(i8* %s621, i8* %t622)
  %s624 = getelementptr inbounds [45 x i8], [45 x i8]* @.str.len44.h1623843, i32 0, i32 0
  %t625 = call i8* @sailfin_runtime_string_concat(i8* %t623, i8* %s624)
  %t626 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t627 = extractvalue %EnumLayoutPayloadParse %t626, 1
  %t628 = call i8* @sailfin_runtime_string_concat(i8* %t625, i8* %t627)
  %t629 = alloca [2 x i8], align 1
  %t630 = getelementptr [2 x i8], [2 x i8]* %t629, i32 0, i32 0
  store i8 96, i8* %t630
  %t631 = getelementptr [2 x i8], [2 x i8]* %t629, i32 0, i32 1
  store i8 0, i8* %t631
  %t632 = getelementptr [2 x i8], [2 x i8]* %t629, i32 0, i32 0
  %t633 = call i8* @sailfin_runtime_string_concat(i8* %t628, i8* %t632)
  %t634 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t620, i8* %t633)
  store { i8**, i64 }* %t634, { i8**, i64 }** %l0
  %t635 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge42
else41:
  %t636 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t637 = load double, double* %l22
  %t638 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t639 = extractvalue %EnumLayoutPayloadParse %t638, 2
  %t640 = call { %NativeEnumVariantLayout*, i64 }* @update_enum_variant_fields({ %NativeEnumVariantLayout*, i64 }* %t636, double %t637, %NativeStructLayoutField %t639)
  store { %NativeEnumVariantLayout*, i64 }* %t640, { %NativeEnumVariantLayout*, i64 }** %l6
  %t641 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  br label %merge42
merge42:
  %t642 = phi { i8**, i64 }* [ %t635, %then40 ], [ %t601, %else41 ]
  %t643 = phi { %NativeEnumVariantLayout*, i64 }* [ %t607, %then40 ], [ %t641, %else41 ]
  store { i8**, i64 }* %t642, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t643, { %NativeEnumVariantLayout*, i64 }** %l6
  %t644 = load i1, i1* %l12
  %t645 = xor i1 %t644, 1
  %t646 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t647 = load i8*, i8** %l1
  %t648 = load i8*, i8** %l2
  %t649 = load i8*, i8** %l3
  %t650 = load double, double* %l4
  %t651 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t652 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t653 = load double, double* %l7
  %t654 = load double, double* %l8
  %t655 = load i8*, i8** %l9
  %t656 = load double, double* %l10
  %t657 = load double, double* %l11
  %t658 = load i1, i1* %l12
  %t659 = load i1, i1* %l13
  %t660 = load double, double* %l14
  %t661 = load i8*, i8** %l16
  %t662 = load i8*, i8** %l17
  %t663 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t664 = load double, double* %l22
  br i1 %t645, label %then43, label %merge44
then43:
  %t665 = load i1, i1* %l13
  %t666 = xor i1 %t665, 1
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
  %t683 = load i8*, i8** %l17
  %t684 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t685 = load double, double* %l22
  br i1 %t666, label %then45, label %merge46
then45:
  %t686 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s687 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t688 = load i8*, i8** %l3
  %t689 = call i8* @sailfin_runtime_string_concat(i8* %s687, i8* %t688)
  %s690 = getelementptr inbounds [49 x i8], [49 x i8]* @.str.len48.h807033739, i32 0, i32 0
  %t691 = call i8* @sailfin_runtime_string_concat(i8* %t689, i8* %s690)
  %t692 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t686, i8* %t691)
  store { i8**, i64 }* %t692, { i8**, i64 }** %l0
  store i1 1, i1* %l13
  %t693 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t694 = load i1, i1* %l13
  br label %merge46
merge46:
  %t695 = phi { i8**, i64 }* [ %t693, %then45 ], [ %t667, %then43 ]
  %t696 = phi i1 [ %t694, %then45 ], [ %t680, %then43 ]
  store { i8**, i64 }* %t695, { i8**, i64 }** %l0
  store i1 %t696, i1* %l13
  %t697 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t698 = load i1, i1* %l13
  br label %merge44
merge44:
  %t699 = phi { i8**, i64 }* [ %t697, %merge46 ], [ %t646, %merge42 ]
  %t700 = phi i1 [ %t698, %merge46 ], [ %t659, %merge42 ]
  store { i8**, i64 }* %t699, { i8**, i64 }** %l0
  store i1 %t700, i1* %l13
  %t701 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t702 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t703 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t704 = load i1, i1* %l13
  br label %merge39
merge39:
  %t705 = phi { i8**, i64 }* [ %t701, %merge44 ], [ %t576, %then36 ]
  %t706 = phi { %NativeEnumVariantLayout*, i64 }* [ %t702, %merge44 ], [ %t582, %then36 ]
  %t707 = phi { i8**, i64 }* [ %t703, %merge44 ], [ %t576, %then36 ]
  %t708 = phi i1 [ %t704, %merge44 ], [ %t589, %then36 ]
  store { i8**, i64 }* %t705, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t706, { %NativeEnumVariantLayout*, i64 }** %l6
  store { i8**, i64 }* %t707, { i8**, i64 }** %l0
  store i1 %t708, i1* %l13
  %t709 = load double, double* %l14
  %t710 = sitofp i64 1 to double
  %t711 = fadd double %t709, %t710
  store double %t711, double* %l14
  br label %loop.latch6
merge37:
  %t712 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s713 = getelementptr inbounds [36 x i8], [36 x i8]* @.str.len35.h2058816325, i32 0, i32 0
  %t714 = load i8*, i8** %l16
  %t715 = call i8* @sailfin_runtime_string_concat(i8* %s713, i8* %t714)
  %t716 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t712, i8* %t715)
  store { i8**, i64 }* %t716, { i8**, i64 }** %l0
  %t717 = load double, double* %l14
  %t718 = sitofp i64 1 to double
  %t719 = fadd double %t717, %t718
  store double %t719, double* %l14
  br label %loop.latch6
merge17:
  %t720 = load i8*, i8** %l16
  %s721 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h562875475, i32 0, i32 0
  %t722 = icmp eq i8* %t720, %s721
  %t723 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t724 = load i8*, i8** %l1
  %t725 = load i8*, i8** %l2
  %t726 = load i8*, i8** %l3
  %t727 = load double, double* %l4
  %t728 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t729 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t730 = load double, double* %l7
  %t731 = load double, double* %l8
  %t732 = load i8*, i8** %l9
  %t733 = load double, double* %l10
  %t734 = load double, double* %l11
  %t735 = load i1, i1* %l12
  %t736 = load i1, i1* %l13
  %t737 = load double, double* %l14
  %t738 = load i8*, i8** %l16
  br i1 %t722, label %then47, label %merge48
then47:
  %t739 = load double, double* %l14
  %t740 = sitofp i64 1 to double
  %t741 = fadd double %t739, %t740
  store double %t741, double* %l14
  br label %afterloop7
merge48:
  %t742 = load i8*, i8** %l16
  %s743 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1311191977, i32 0, i32 0
  %t744 = call i1 @starts_with(i8* %t742, i8* %s743)
  %t745 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t746 = load i8*, i8** %l1
  %t747 = load i8*, i8** %l2
  %t748 = load i8*, i8** %l3
  %t749 = load double, double* %l4
  %t750 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t751 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t752 = load double, double* %l7
  %t753 = load double, double* %l8
  %t754 = load i8*, i8** %l9
  %t755 = load double, double* %l10
  %t756 = load double, double* %l11
  %t757 = load i1, i1* %l12
  %t758 = load i1, i1* %l13
  %t759 = load double, double* %l14
  %t760 = load i8*, i8** %l16
  br i1 %t744, label %then49, label %merge50
then49:
  %t761 = load i8*, i8** %l16
  %s762 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1311191977, i32 0, i32 0
  %t763 = call i8* @strip_prefix(i8* %t761, i8* %s762)
  %t764 = call %NativeEnumVariant* @parse_enum_variant_line(i8* %t763)
  store %NativeEnumVariant* %t764, %NativeEnumVariant** %l23
  %t765 = load %NativeEnumVariant*, %NativeEnumVariant** %l23
  %t766 = icmp eq %NativeEnumVariant* %t765, null
  %t767 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t768 = load i8*, i8** %l1
  %t769 = load i8*, i8** %l2
  %t770 = load i8*, i8** %l3
  %t771 = load double, double* %l4
  %t772 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t773 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t774 = load double, double* %l7
  %t775 = load double, double* %l8
  %t776 = load i8*, i8** %l9
  %t777 = load double, double* %l10
  %t778 = load double, double* %l11
  %t779 = load i1, i1* %l12
  %t780 = load i1, i1* %l13
  %t781 = load double, double* %l14
  %t782 = load i8*, i8** %l16
  %t783 = load %NativeEnumVariant*, %NativeEnumVariant** %l23
  br i1 %t766, label %then51, label %else52
then51:
  %t784 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s785 = getelementptr inbounds [31 x i8], [31 x i8]* @.str.len30.h829706524, i32 0, i32 0
  %t786 = load i8*, i8** %l16
  %t787 = call i8* @sailfin_runtime_string_concat(i8* %s785, i8* %t786)
  %t788 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t784, i8* %t787)
  store { i8**, i64 }* %t788, { i8**, i64 }** %l0
  %t789 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge53
else52:
  %t790 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t791 = load %NativeEnumVariant*, %NativeEnumVariant** %l23
  %t792 = load %NativeEnumVariant, %NativeEnumVariant* %t791
  %t793 = call { %NativeEnumVariant*, i64 }* @append_enum_variant({ %NativeEnumVariant*, i64 }* %t790, %NativeEnumVariant %t792)
  store { %NativeEnumVariant*, i64 }* %t793, { %NativeEnumVariant*, i64 }** %l5
  %t794 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  br label %merge53
merge53:
  %t795 = phi { i8**, i64 }* [ %t789, %then51 ], [ %t767, %else52 ]
  %t796 = phi { %NativeEnumVariant*, i64 }* [ %t772, %then51 ], [ %t794, %else52 ]
  store { i8**, i64 }* %t795, { i8**, i64 }** %l0
  store { %NativeEnumVariant*, i64 }* %t796, { %NativeEnumVariant*, i64 }** %l5
  %t797 = load double, double* %l14
  %t798 = sitofp i64 1 to double
  %t799 = fadd double %t797, %t798
  store double %t799, double* %l14
  br label %loop.latch6
merge50:
  %t800 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s801 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.len28.h1471254674, i32 0, i32 0
  %t802 = load i8*, i8** %l16
  %t803 = call i8* @sailfin_runtime_string_concat(i8* %s801, i8* %t802)
  %t804 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t800, i8* %t803)
  store { i8**, i64 }* %t804, { i8**, i64 }** %l0
  %t805 = load double, double* %l14
  %t806 = sitofp i64 1 to double
  %t807 = fadd double %t805, %t806
  store double %t807, double* %l14
  br label %loop.latch6
loop.latch6:
  %t808 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t809 = load double, double* %l14
  %t810 = load double, double* %l7
  %t811 = load double, double* %l8
  %t812 = load i8*, i8** %l9
  %t813 = load double, double* %l10
  %t814 = load double, double* %l11
  %t815 = load i1, i1* %l12
  %t816 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t817 = load i1, i1* %l13
  %t818 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  br label %loop.header4
afterloop7:
  %t830 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t831 = load double, double* %l14
  %t832 = load double, double* %l7
  %t833 = load double, double* %l8
  %t834 = load i8*, i8** %l9
  %t835 = load double, double* %l10
  %t836 = load double, double* %l11
  %t837 = load i1, i1* %l12
  %t838 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t839 = load i1, i1* %l13
  %t840 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t841 = bitcast i8* null to %NativeEnumLayout*
  store %NativeEnumLayout* %t841, %NativeEnumLayout** %l24
  %t842 = load i1, i1* %l12
  %t843 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t844 = load i8*, i8** %l1
  %t845 = load i8*, i8** %l2
  %t846 = load i8*, i8** %l3
  %t847 = load double, double* %l4
  %t848 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t849 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t850 = load double, double* %l7
  %t851 = load double, double* %l8
  %t852 = load i8*, i8** %l9
  %t853 = load double, double* %l10
  %t854 = load double, double* %l11
  %t855 = load i1, i1* %l12
  %t856 = load i1, i1* %l13
  %t857 = load double, double* %l14
  %t858 = load %NativeEnumLayout*, %NativeEnumLayout** %l24
  br i1 %t842, label %then54, label %merge55
then54:
  %t859 = load double, double* %l7
  %t860 = insertvalue %NativeEnumLayout undef, double %t859, 0
  %t861 = load double, double* %l8
  %t862 = insertvalue %NativeEnumLayout %t860, double %t861, 1
  %t863 = load i8*, i8** %l9
  %t864 = insertvalue %NativeEnumLayout %t862, i8* %t863, 2
  %t865 = load double, double* %l10
  %t866 = insertvalue %NativeEnumLayout %t864, double %t865, 3
  %t867 = load double, double* %l11
  %t868 = insertvalue %NativeEnumLayout %t866, double %t867, 4
  %t869 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t870 = bitcast { %NativeEnumVariantLayout*, i64 }* %t869 to { %NativeEnumVariantLayout**, i64 }*
  %t871 = insertvalue %NativeEnumLayout %t868, { %NativeEnumVariantLayout**, i64 }* %t870, 5
  %t872 = alloca %NativeEnumLayout
  store %NativeEnumLayout %t871, %NativeEnumLayout* %t872
  store %NativeEnumLayout* %t872, %NativeEnumLayout** %l24
  %t873 = load %NativeEnumLayout*, %NativeEnumLayout** %l24
  br label %merge55
merge55:
  %t874 = phi %NativeEnumLayout* [ %t873, %then54 ], [ %t858, %afterloop7 ]
  store %NativeEnumLayout* %t874, %NativeEnumLayout** %l24
  %t875 = load i8*, i8** %l3
  %t876 = insertvalue %NativeEnum undef, i8* %t875, 0
  %t877 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t878 = bitcast { %NativeEnumVariant*, i64 }* %t877 to { %NativeEnumVariant**, i64 }*
  %t879 = insertvalue %NativeEnum %t876, { %NativeEnumVariant**, i64 }* %t878, 1
  %t880 = load %NativeEnumLayout*, %NativeEnumLayout** %l24
  %t881 = insertvalue %NativeEnum %t879, %NativeEnumLayout* %t880, 2
  %t882 = alloca %NativeEnum
  store %NativeEnum %t881, %NativeEnum* %t882
  %t883 = insertvalue %EnumParseResult undef, %NativeEnum* %t882, 0
  %t884 = load double, double* %l14
  %t885 = insertvalue %EnumParseResult %t883, double %t884, 1
  %t886 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t887 = insertvalue %EnumParseResult %t885, { i8**, i64 }* %t886, 2
  ret %EnumParseResult %t887
}

define %NativeEnumVariant* @parse_enum_variant_line(i8* %text) {
block.entry:
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
  %t21 = getelementptr [0 x %NativeEnumVariantField*], [0 x %NativeEnumVariantField*]* null, i32 1
  %t22 = ptrtoint [0 x %NativeEnumVariantField*]* %t21 to i64
  %t23 = icmp eq i64 %t22, 0
  %t24 = select i1 %t23, i64 1, i64 %t22
  %t25 = call i8* @malloc(i64 %t24)
  %t26 = bitcast i8* %t25 to %NativeEnumVariantField**
  %t27 = getelementptr { %NativeEnumVariantField**, i64 }, { %NativeEnumVariantField**, i64 }* null, i32 1
  %t28 = ptrtoint { %NativeEnumVariantField**, i64 }* %t27 to i64
  %t29 = call i8* @malloc(i64 %t28)
  %t30 = bitcast i8* %t29 to { %NativeEnumVariantField**, i64 }*
  %t31 = getelementptr { %NativeEnumVariantField**, i64 }, { %NativeEnumVariantField**, i64 }* %t30, i32 0, i32 0
  store %NativeEnumVariantField** %t26, %NativeEnumVariantField*** %t31
  %t32 = getelementptr { %NativeEnumVariantField**, i64 }, { %NativeEnumVariantField**, i64 }* %t30, i32 0, i32 1
  store i64 0, i64* %t32
  %t33 = insertvalue %NativeEnumVariant %t20, { %NativeEnumVariantField**, i64 }* %t30, 1
  %t34 = alloca %NativeEnumVariant
  store %NativeEnumVariant %t33, %NativeEnumVariant* %t34
  ret %NativeEnumVariant* %t34
merge3:
  %t35 = load i8*, i8** %l0
  %t36 = alloca [2 x i8], align 1
  %t37 = getelementptr [2 x i8], [2 x i8]* %t36, i32 0, i32 0
  store i8 125, i8* %t37
  %t38 = getelementptr [2 x i8], [2 x i8]* %t36, i32 0, i32 1
  store i8 0, i8* %t38
  %t39 = getelementptr [2 x i8], [2 x i8]* %t36, i32 0, i32 0
  %t40 = call double @last_index_of(i8* %t35, i8* %t39)
  store double %t40, double* %l2
  %t42 = load double, double* %l2
  %t43 = sitofp i64 0 to double
  %t44 = fcmp olt double %t42, %t43
  br label %logical_or_entry_41

logical_or_entry_41:
  br i1 %t44, label %logical_or_merge_41, label %logical_or_right_41

logical_or_right_41:
  %t45 = load double, double* %l2
  %t46 = load double, double* %l1
  %t47 = fcmp ole double %t45, %t46
  br label %logical_or_right_end_41

logical_or_right_end_41:
  br label %logical_or_merge_41

logical_or_merge_41:
  %t48 = phi i1 [ true, %logical_or_entry_41 ], [ %t47, %logical_or_right_end_41 ]
  %t49 = load i8*, i8** %l0
  %t50 = load double, double* %l1
  %t51 = load double, double* %l2
  br i1 %t48, label %then4, label %merge5
then4:
  %t52 = bitcast i8* null to %NativeEnumVariant*
  ret %NativeEnumVariant* %t52
merge5:
  %t53 = load i8*, i8** %l0
  %t54 = load double, double* %l1
  %t55 = fptosi double %t54 to i64
  %t56 = call i8* @sailfin_runtime_substring(i8* %t53, i64 0, i64 %t55)
  %t57 = call i8* @trim_text(i8* %t56)
  %t58 = call i8* @strip_generics(i8* %t57)
  store i8* %t58, i8** %l3
  %t59 = load i8*, i8** %l3
  %t60 = call i64 @sailfin_runtime_string_length(i8* %t59)
  %t61 = icmp eq i64 %t60, 0
  %t62 = load i8*, i8** %l0
  %t63 = load double, double* %l1
  %t64 = load double, double* %l2
  %t65 = load i8*, i8** %l3
  br i1 %t61, label %then6, label %merge7
then6:
  %t66 = bitcast i8* null to %NativeEnumVariant*
  ret %NativeEnumVariant* %t66
merge7:
  %t67 = load i8*, i8** %l0
  %t68 = load double, double* %l1
  %t69 = sitofp i64 1 to double
  %t70 = fadd double %t68, %t69
  %t71 = load double, double* %l2
  %t72 = fptosi double %t70 to i64
  %t73 = fptosi double %t71 to i64
  %t74 = call i8* @sailfin_runtime_substring(i8* %t67, i64 %t72, i64 %t73)
  store i8* %t74, i8** %l4
  %t75 = load i8*, i8** %l4
  %t76 = call { i8**, i64 }* @split_enum_field_entries(i8* %t75)
  store { i8**, i64 }* %t76, { i8**, i64 }** %l5
  %t77 = getelementptr [0 x %NativeEnumVariantField], [0 x %NativeEnumVariantField]* null, i32 1
  %t78 = ptrtoint [0 x %NativeEnumVariantField]* %t77 to i64
  %t79 = icmp eq i64 %t78, 0
  %t80 = select i1 %t79, i64 1, i64 %t78
  %t81 = call i8* @malloc(i64 %t80)
  %t82 = bitcast i8* %t81 to %NativeEnumVariantField*
  %t83 = getelementptr { %NativeEnumVariantField*, i64 }, { %NativeEnumVariantField*, i64 }* null, i32 1
  %t84 = ptrtoint { %NativeEnumVariantField*, i64 }* %t83 to i64
  %t85 = call i8* @malloc(i64 %t84)
  %t86 = bitcast i8* %t85 to { %NativeEnumVariantField*, i64 }*
  %t87 = getelementptr { %NativeEnumVariantField*, i64 }, { %NativeEnumVariantField*, i64 }* %t86, i32 0, i32 0
  store %NativeEnumVariantField* %t82, %NativeEnumVariantField** %t87
  %t88 = getelementptr { %NativeEnumVariantField*, i64 }, { %NativeEnumVariantField*, i64 }* %t86, i32 0, i32 1
  store i64 0, i64* %t88
  store { %NativeEnumVariantField*, i64 }* %t86, { %NativeEnumVariantField*, i64 }** %l6
  %t89 = sitofp i64 0 to double
  store double %t89, double* %l7
  %t90 = load i8*, i8** %l0
  %t91 = load double, double* %l1
  %t92 = load double, double* %l2
  %t93 = load i8*, i8** %l3
  %t94 = load i8*, i8** %l4
  %t95 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t96 = load { %NativeEnumVariantField*, i64 }*, { %NativeEnumVariantField*, i64 }** %l6
  %t97 = load double, double* %l7
  br label %loop.header8
loop.header8:
  %t162 = phi double [ %t97, %merge7 ], [ %t160, %loop.latch10 ]
  %t163 = phi { %NativeEnumVariantField*, i64 }* [ %t96, %merge7 ], [ %t161, %loop.latch10 ]
  store double %t162, double* %l7
  store { %NativeEnumVariantField*, i64 }* %t163, { %NativeEnumVariantField*, i64 }** %l6
  br label %loop.body9
loop.body9:
  %t98 = load double, double* %l7
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t100 = load { i8**, i64 }, { i8**, i64 }* %t99
  %t101 = extractvalue { i8**, i64 } %t100, 1
  %t102 = sitofp i64 %t101 to double
  %t103 = fcmp oge double %t98, %t102
  %t104 = load i8*, i8** %l0
  %t105 = load double, double* %l1
  %t106 = load double, double* %l2
  %t107 = load i8*, i8** %l3
  %t108 = load i8*, i8** %l4
  %t109 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t110 = load { %NativeEnumVariantField*, i64 }*, { %NativeEnumVariantField*, i64 }** %l6
  %t111 = load double, double* %l7
  br i1 %t103, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t112 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t113 = load double, double* %l7
  %t114 = fptosi double %t113 to i64
  %t115 = load { i8**, i64 }, { i8**, i64 }* %t112
  %t116 = extractvalue { i8**, i64 } %t115, 0
  %t117 = extractvalue { i8**, i64 } %t115, 1
  %t118 = icmp uge i64 %t114, %t117
  ; bounds check: %t118 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t114, i64 %t117)
  %t119 = getelementptr i8*, i8** %t116, i64 %t114
  %t120 = load i8*, i8** %t119
  %t121 = call i8* @trim_text(i8* %t120)
  %t122 = call i8* @trim_trailing_delimiters(i8* %t121)
  store i8* %t122, i8** %l8
  %t123 = load i8*, i8** %l8
  %t124 = call i64 @sailfin_runtime_string_length(i8* %t123)
  %t125 = icmp eq i64 %t124, 0
  %t126 = load i8*, i8** %l0
  %t127 = load double, double* %l1
  %t128 = load double, double* %l2
  %t129 = load i8*, i8** %l3
  %t130 = load i8*, i8** %l4
  %t131 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t132 = load { %NativeEnumVariantField*, i64 }*, { %NativeEnumVariantField*, i64 }** %l6
  %t133 = load double, double* %l7
  %t134 = load i8*, i8** %l8
  br i1 %t125, label %then14, label %merge15
then14:
  %t135 = load double, double* %l7
  %t136 = sitofp i64 1 to double
  %t137 = fadd double %t135, %t136
  store double %t137, double* %l7
  br label %loop.latch10
merge15:
  %t138 = load i8*, i8** %l8
  %t139 = call %NativeEnumVariantField* @parse_enum_variant_field(i8* %t138)
  store %NativeEnumVariantField* %t139, %NativeEnumVariantField** %l9
  %t140 = load %NativeEnumVariantField*, %NativeEnumVariantField** %l9
  %t141 = icmp eq %NativeEnumVariantField* %t140, null
  %t142 = load i8*, i8** %l0
  %t143 = load double, double* %l1
  %t144 = load double, double* %l2
  %t145 = load i8*, i8** %l3
  %t146 = load i8*, i8** %l4
  %t147 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t148 = load { %NativeEnumVariantField*, i64 }*, { %NativeEnumVariantField*, i64 }** %l6
  %t149 = load double, double* %l7
  %t150 = load i8*, i8** %l8
  %t151 = load %NativeEnumVariantField*, %NativeEnumVariantField** %l9
  br i1 %t141, label %then16, label %merge17
then16:
  %t152 = bitcast i8* null to %NativeEnumVariant*
  ret %NativeEnumVariant* %t152
merge17:
  %t153 = load { %NativeEnumVariantField*, i64 }*, { %NativeEnumVariantField*, i64 }** %l6
  %t154 = load %NativeEnumVariantField*, %NativeEnumVariantField** %l9
  %t155 = load %NativeEnumVariantField, %NativeEnumVariantField* %t154
  %t156 = call { %NativeEnumVariantField*, i64 }* @append_enum_variant_field({ %NativeEnumVariantField*, i64 }* %t153, %NativeEnumVariantField %t155)
  store { %NativeEnumVariantField*, i64 }* %t156, { %NativeEnumVariantField*, i64 }** %l6
  %t157 = load double, double* %l7
  %t158 = sitofp i64 1 to double
  %t159 = fadd double %t157, %t158
  store double %t159, double* %l7
  br label %loop.latch10
loop.latch10:
  %t160 = load double, double* %l7
  %t161 = load { %NativeEnumVariantField*, i64 }*, { %NativeEnumVariantField*, i64 }** %l6
  br label %loop.header8
afterloop11:
  %t164 = load double, double* %l7
  %t165 = load { %NativeEnumVariantField*, i64 }*, { %NativeEnumVariantField*, i64 }** %l6
  %t166 = load i8*, i8** %l3
  %t167 = insertvalue %NativeEnumVariant undef, i8* %t166, 0
  %t168 = load { %NativeEnumVariantField*, i64 }*, { %NativeEnumVariantField*, i64 }** %l6
  %t169 = bitcast { %NativeEnumVariantField*, i64 }* %t168 to { %NativeEnumVariantField**, i64 }*
  %t170 = insertvalue %NativeEnumVariant %t167, { %NativeEnumVariantField**, i64 }* %t169, 1
  %t171 = alloca %NativeEnumVariant
  store %NativeEnumVariant %t170, %NativeEnumVariant* %t171
  ret %NativeEnumVariant* %t171
}

define { i8**, i64 }* @split_enum_field_entries(i8* %text) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i8
  %t0 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t1 = ptrtoint [0 x i8*]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to i8**
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t7 = ptrtoint { i8**, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { i8**, i64 }*
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 0
  store i8** %t5, i8*** %t10
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { i8**, i64 }* %t9, { i8**, i64 }** %l0
  %s12 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s12, i8** %l1
  %t13 = sitofp i64 0 to double
  store double %t13, double* %l2
  %t14 = sitofp i64 0 to double
  store double %t14, double* %l3
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t16 = load i8*, i8** %l1
  %t17 = load double, double* %l2
  %t18 = load double, double* %l3
  br label %loop.header0
loop.header0:
  %t117 = phi double [ %t17, %block.entry ], [ %t113, %loop.latch2 ]
  %t118 = phi { i8**, i64 }* [ %t15, %block.entry ], [ %t114, %loop.latch2 ]
  %t119 = phi i8* [ %t16, %block.entry ], [ %t115, %loop.latch2 ]
  %t120 = phi double [ %t18, %block.entry ], [ %t116, %loop.latch2 ]
  store double %t117, double* %l2
  store { i8**, i64 }* %t118, { i8**, i64 }** %l0
  store i8* %t119, i8** %l1
  store double %t120, double* %l3
  br label %loop.body1
loop.body1:
  %t19 = load double, double* %l3
  %t20 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t21 = sitofp i64 %t20 to double
  %t22 = fcmp oge double %t19, %t21
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t24 = load i8*, i8** %l1
  %t25 = load double, double* %l2
  %t26 = load double, double* %l3
  br i1 %t22, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t27 = load double, double* %l3
  %t28 = fptosi double %t27 to i64
  %t29 = getelementptr i8, i8* %text, i64 %t28
  %t30 = load i8, i8* %t29
  store i8 %t30, i8* %l4
  %t32 = load i8, i8* %l4
  %t33 = icmp eq i8 %t32, 123
  br label %logical_or_entry_31

logical_or_entry_31:
  br i1 %t33, label %logical_or_merge_31, label %logical_or_right_31

logical_or_right_31:
  %t35 = load i8, i8* %l4
  %t36 = icmp eq i8 %t35, 91
  br label %logical_or_entry_34

logical_or_entry_34:
  br i1 %t36, label %logical_or_merge_34, label %logical_or_right_34

logical_or_right_34:
  %t37 = load i8, i8* %l4
  %t38 = icmp eq i8 %t37, 40
  br label %logical_or_right_end_34

logical_or_right_end_34:
  br label %logical_or_merge_34

logical_or_merge_34:
  %t39 = phi i1 [ true, %logical_or_entry_34 ], [ %t38, %logical_or_right_end_34 ]
  br label %logical_or_right_end_31

logical_or_right_end_31:
  br label %logical_or_merge_31

logical_or_merge_31:
  %t40 = phi i1 [ true, %logical_or_entry_31 ], [ %t39, %logical_or_right_end_31 ]
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t42 = load i8*, i8** %l1
  %t43 = load double, double* %l2
  %t44 = load double, double* %l3
  %t45 = load i8, i8* %l4
  br i1 %t40, label %then6, label %else7
then6:
  %t46 = load double, double* %l2
  %t47 = sitofp i64 1 to double
  %t48 = fadd double %t46, %t47
  store double %t48, double* %l2
  %t49 = load double, double* %l2
  br label %merge8
else7:
  %t51 = load i8, i8* %l4
  %t52 = icmp eq i8 %t51, 125
  br label %logical_or_entry_50

logical_or_entry_50:
  br i1 %t52, label %logical_or_merge_50, label %logical_or_right_50

logical_or_right_50:
  %t54 = load i8, i8* %l4
  %t55 = icmp eq i8 %t54, 93
  br label %logical_or_entry_53

logical_or_entry_53:
  br i1 %t55, label %logical_or_merge_53, label %logical_or_right_53

logical_or_right_53:
  %t56 = load i8, i8* %l4
  %t57 = icmp eq i8 %t56, 41
  br label %logical_or_right_end_53

logical_or_right_end_53:
  br label %logical_or_merge_53

logical_or_merge_53:
  %t58 = phi i1 [ true, %logical_or_entry_53 ], [ %t57, %logical_or_right_end_53 ]
  br label %logical_or_right_end_50

logical_or_right_end_50:
  br label %logical_or_merge_50

logical_or_merge_50:
  %t59 = phi i1 [ true, %logical_or_entry_50 ], [ %t58, %logical_or_right_end_50 ]
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t61 = load i8*, i8** %l1
  %t62 = load double, double* %l2
  %t63 = load double, double* %l3
  %t64 = load i8, i8* %l4
  br i1 %t59, label %then9, label %merge10
then9:
  %t65 = load double, double* %l2
  %t66 = sitofp i64 0 to double
  %t67 = fcmp ogt double %t65, %t66
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t69 = load i8*, i8** %l1
  %t70 = load double, double* %l2
  %t71 = load double, double* %l3
  %t72 = load i8, i8* %l4
  br i1 %t67, label %then11, label %merge12
then11:
  %t73 = load double, double* %l2
  %t74 = sitofp i64 1 to double
  %t75 = fsub double %t73, %t74
  store double %t75, double* %l2
  %t76 = load double, double* %l2
  br label %merge12
merge12:
  %t77 = phi double [ %t76, %then11 ], [ %t70, %then9 ]
  store double %t77, double* %l2
  %t78 = load double, double* %l2
  br label %merge10
merge10:
  %t79 = phi double [ %t78, %merge12 ], [ %t62, %logical_or_merge_50 ]
  store double %t79, double* %l2
  %t80 = load double, double* %l2
  br label %merge8
merge8:
  %t81 = phi double [ %t49, %then6 ], [ %t80, %merge10 ]
  store double %t81, double* %l2
  %t83 = load i8, i8* %l4
  %t84 = icmp eq i8 %t83, 59
  br label %logical_and_entry_82

logical_and_entry_82:
  br i1 %t84, label %logical_and_right_82, label %logical_and_merge_82

logical_and_right_82:
  %t85 = load double, double* %l2
  %t86 = sitofp i64 0 to double
  %t87 = fcmp oeq double %t85, %t86
  br label %logical_and_right_end_82

logical_and_right_end_82:
  br label %logical_and_merge_82

logical_and_merge_82:
  %t88 = phi i1 [ false, %logical_and_entry_82 ], [ %t87, %logical_and_right_end_82 ]
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t90 = load i8*, i8** %l1
  %t91 = load double, double* %l2
  %t92 = load double, double* %l3
  %t93 = load i8, i8* %l4
  br i1 %t88, label %then13, label %else14
then13:
  %t94 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t95 = load i8*, i8** %l1
  %t96 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t94, i8* %t95)
  store { i8**, i64 }* %t96, { i8**, i64 }** %l0
  %s97 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s97, i8** %l1
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t99 = load i8*, i8** %l1
  br label %merge15
else14:
  %t100 = load i8*, i8** %l1
  %t101 = load i8, i8* %l4
  %t102 = alloca [2 x i8], align 1
  %t103 = getelementptr [2 x i8], [2 x i8]* %t102, i32 0, i32 0
  store i8 %t101, i8* %t103
  %t104 = getelementptr [2 x i8], [2 x i8]* %t102, i32 0, i32 1
  store i8 0, i8* %t104
  %t105 = getelementptr [2 x i8], [2 x i8]* %t102, i32 0, i32 0
  %t106 = call i8* @sailfin_runtime_string_concat(i8* %t100, i8* %t105)
  store i8* %t106, i8** %l1
  %t107 = load i8*, i8** %l1
  br label %merge15
merge15:
  %t108 = phi { i8**, i64 }* [ %t98, %then13 ], [ %t89, %else14 ]
  %t109 = phi i8* [ %t99, %then13 ], [ %t107, %else14 ]
  store { i8**, i64 }* %t108, { i8**, i64 }** %l0
  store i8* %t109, i8** %l1
  %t110 = load double, double* %l3
  %t111 = sitofp i64 1 to double
  %t112 = fadd double %t110, %t111
  store double %t112, double* %l3
  br label %loop.latch2
loop.latch2:
  %t113 = load double, double* %l2
  %t114 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t115 = load i8*, i8** %l1
  %t116 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t121 = load double, double* %l2
  %t122 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t123 = load i8*, i8** %l1
  %t124 = load double, double* %l3
  %t125 = load i8*, i8** %l1
  %t126 = call i64 @sailfin_runtime_string_length(i8* %t125)
  %t127 = icmp sgt i64 %t126, 0
  %t128 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t129 = load i8*, i8** %l1
  %t130 = load double, double* %l2
  %t131 = load double, double* %l3
  br i1 %t127, label %then16, label %merge17
then16:
  %t132 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t133 = load i8*, i8** %l1
  %t134 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t132, i8* %t133)
  store { i8**, i64 }* %t134, { i8**, i64 }** %l0
  %t135 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge17
merge17:
  %t136 = phi { i8**, i64 }* [ %t135, %then16 ], [ %t128, %afterloop3 ]
  store { i8**, i64 }* %t136, { i8**, i64 }** %l0
  %t137 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t137
}

define %NativeEnumVariantField* @parse_enum_variant_field(i8* %text) {
block.entry:
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
  %s7 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t8 = call i1 @starts_with(i8* %t6, i8* %s7)
  %t9 = load i8*, i8** %l0
  %t10 = load i1, i1* %l1
  br i1 %t8, label %then2, label %merge3
then2:
  store i1 1, i1* %l1
  %t11 = load i8*, i8** %l0
  %s12 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t13 = call i8* @strip_prefix(i8* %t11, i8* %s12)
  %t14 = call i8* @trim_text(i8* %t13)
  store i8* %t14, i8** %l0
  %t15 = load i1, i1* %l1
  %t16 = load i8*, i8** %l0
  br label %merge3
merge3:
  %t17 = phi i1 [ %t15, %then2 ], [ %t10, %merge1 ]
  %t18 = phi i8* [ %t16, %then2 ], [ %t9, %merge1 ]
  store i1 %t17, i1* %l1
  store i8* %t18, i8** %l0
  %t19 = load i8*, i8** %l0
  %s20 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193428050, i32 0, i32 0
  %t21 = call double @index_of(i8* %t19, i8* %s20)
  store double %t21, double* %l2
  %t22 = load double, double* %l2
  %t23 = sitofp i64 0 to double
  %t24 = fcmp olt double %t22, %t23
  %t25 = load i8*, i8** %l0
  %t26 = load i1, i1* %l1
  %t27 = load double, double* %l2
  br i1 %t24, label %then4, label %merge5
then4:
  %t28 = bitcast i8* null to %NativeEnumVariantField*
  ret %NativeEnumVariantField* %t28
merge5:
  %t29 = load i8*, i8** %l0
  %t30 = load double, double* %l2
  %t31 = fptosi double %t30 to i64
  %t32 = call i8* @sailfin_runtime_substring(i8* %t29, i64 0, i64 %t31)
  %t33 = call i8* @trim_text(i8* %t32)
  store i8* %t33, i8** %l3
  %t34 = load i8*, i8** %l3
  %t35 = call i64 @sailfin_runtime_string_length(i8* %t34)
  %t36 = icmp eq i64 %t35, 0
  %t37 = load i8*, i8** %l0
  %t38 = load i1, i1* %l1
  %t39 = load double, double* %l2
  %t40 = load i8*, i8** %l3
  br i1 %t36, label %then6, label %merge7
then6:
  %t41 = bitcast i8* null to %NativeEnumVariantField*
  ret %NativeEnumVariantField* %t41
merge7:
  %t42 = load i8*, i8** %l0
  %t43 = load double, double* %l2
  %t44 = sitofp i64 2 to double
  %t45 = fadd double %t43, %t44
  %t46 = load i8*, i8** %l0
  %t47 = call i64 @sailfin_runtime_string_length(i8* %t46)
  %t48 = fptosi double %t45 to i64
  %t49 = call i8* @sailfin_runtime_substring(i8* %t42, i64 %t48, i64 %t47)
  %t50 = call i8* @trim_text(i8* %t49)
  store i8* %t50, i8** %l4
  %t51 = load i8*, i8** %l3
  %t52 = insertvalue %NativeEnumVariantField undef, i8* %t51, 0
  %t53 = load i8*, i8** %l4
  %t54 = insertvalue %NativeEnumVariantField %t52, i8* %t53, 1
  %t55 = load i1, i1* %l1
  %t56 = insertvalue %NativeEnumVariantField %t54, i1 %t55, 2
  %t57 = alloca %NativeEnumVariantField
  store %NativeEnumVariantField %t56, %NativeEnumVariantField* %t57
  ret %NativeEnumVariantField* %t57
}

define i8* @text_char_at(i8* %value, double %index) {
block.entry:
  %t0 = sitofp i64 0 to double
  %t1 = fcmp olt double %index, %t0
  br i1 %t1, label %then0, label %merge1
then0:
  %s2 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  ret i8* %s2
merge1:
  %t3 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t4 = sitofp i64 %t3 to double
  %t5 = fcmp oge double %index, %t4
  br i1 %t5, label %then2, label %merge3
then2:
  %s6 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
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
block.entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t1 = sitofp i64 %t0 to double
  store double %t1, double* %l0
  %t2 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t25 = phi double [ %t2, %block.entry ], [ %t24, %loop.latch2 ]
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
  %t27 = load double, double* %l0
  %t28 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t29 = sitofp i64 %t28 to double
  %t30 = fcmp oeq double %t27, %t29
  %t31 = load double, double* %l0
  br i1 %t30, label %then8, label %merge9
then8:
  ret i8* %text
merge9:
  %t32 = load double, double* %l0
  %t33 = fptosi double %t32 to i64
  %t34 = call i8* @sailfin_runtime_substring(i8* %text, i64 0, i64 %t33)
  ret i8* %t34
}

define i8* @maybe_trim_trailing(i8* %value) {
block.entry:
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
block.entry:
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
  %s7 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t8 = call i1 @starts_with(i8* %t6, i8* %s7)
  %t9 = load i8*, i8** %l0
  %t10 = load i1, i1* %l1
  br i1 %t8, label %then2, label %merge3
then2:
  store i1 1, i1* %l1
  %t11 = load i8*, i8** %l0
  %s12 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t13 = call i8* @strip_prefix(i8* %t11, i8* %s12)
  %t14 = call i8* @trim_text(i8* %t13)
  store i8* %t14, i8** %l0
  %t15 = load i1, i1* %l1
  %t16 = load i8*, i8** %l0
  br label %merge3
merge3:
  %t17 = phi i1 [ %t15, %then2 ], [ %t10, %merge1 ]
  %t18 = phi i8* [ %t16, %then2 ], [ %t9, %merge1 ]
  store i1 %t17, i1* %l1
  store i8* %t18, i8** %l0
  %t19 = load i8*, i8** %l0
  %s20 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193428050, i32 0, i32 0
  %t21 = call double @index_of(i8* %t19, i8* %s20)
  store double %t21, double* %l2
  %t22 = load double, double* %l2
  %t23 = sitofp i64 0 to double
  %t24 = fcmp olt double %t22, %t23
  %t25 = load i8*, i8** %l0
  %t26 = load i1, i1* %l1
  %t27 = load double, double* %l2
  br i1 %t24, label %then4, label %merge5
then4:
  %t28 = bitcast i8* null to %NativeStructField*
  ret %NativeStructField* %t28
merge5:
  %t29 = load i8*, i8** %l0
  %t30 = load double, double* %l2
  %t31 = fptosi double %t30 to i64
  %t32 = call i8* @sailfin_runtime_substring(i8* %t29, i64 0, i64 %t31)
  %t33 = call i8* @trim_text(i8* %t32)
  store i8* %t33, i8** %l3
  %t34 = load i8*, i8** %l3
  %t35 = call i64 @sailfin_runtime_string_length(i8* %t34)
  %t36 = icmp eq i64 %t35, 0
  %t37 = load i8*, i8** %l0
  %t38 = load i1, i1* %l1
  %t39 = load double, double* %l2
  %t40 = load i8*, i8** %l3
  br i1 %t36, label %then6, label %merge7
then6:
  %t41 = bitcast i8* null to %NativeStructField*
  ret %NativeStructField* %t41
merge7:
  %t42 = load i8*, i8** %l0
  %t43 = load double, double* %l2
  %t44 = sitofp i64 2 to double
  %t45 = fadd double %t43, %t44
  %t46 = load i8*, i8** %l0
  %t47 = call i64 @sailfin_runtime_string_length(i8* %t46)
  %t48 = fptosi double %t45 to i64
  %t49 = call i8* @sailfin_runtime_substring(i8* %t42, i64 %t48, i64 %t47)
  %t50 = call i8* @trim_text(i8* %t49)
  store i8* %t50, i8** %l4
  %t51 = load i8*, i8** %l3
  %t52 = insertvalue %NativeStructField undef, i8* %t51, 0
  %t53 = load i8*, i8** %l4
  %t54 = insertvalue %NativeStructField %t52, i8* %t53, 1
  %t55 = load i1, i1* %l1
  %t56 = insertvalue %NativeStructField %t54, i1 %t55, 2
  %t57 = alloca %NativeStructField
  store %NativeStructField %t56, %NativeStructField* %t57
  ret %NativeStructField* %t57
}

define %StructLayoutHeaderParse @parse_struct_layout_header(i8* %text) {
block.entry:
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
  %t2 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t3 = ptrtoint [0 x i8*]* %t2 to i64
  %t4 = icmp eq i64 %t3, 0
  %t5 = select i1 %t4, i64 1, i64 %t3
  %t6 = call i8* @malloc(i64 %t5)
  %t7 = bitcast i8* %t6 to i8**
  %t8 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t9 = ptrtoint { i8**, i64 }* %t8 to i64
  %t10 = call i8* @malloc(i64 %t9)
  %t11 = bitcast i8* %t10 to { i8**, i64 }*
  %t12 = getelementptr { i8**, i64 }, { i8**, i64 }* %t11, i32 0, i32 0
  store i8** %t7, i8*** %t12
  %t13 = getelementptr { i8**, i64 }, { i8**, i64 }* %t11, i32 0, i32 1
  store i64 0, i64* %t13
  store { i8**, i64 }* %t11, { i8**, i64 }** %l1
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t15 = load { i8**, i64 }, { i8**, i64 }* %t14
  %t16 = extractvalue { i8**, i64 } %t15, 1
  %t17 = icmp eq i64 %t16, 0
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t17, label %then0, label %merge1
then0:
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s21 = getelementptr inbounds [37 x i8], [37 x i8]* @.str.len36.h414094739, i32 0, i32 0
  %t22 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t20, i8* %s21)
  store { i8**, i64 }* %t22, { i8**, i64 }** %l1
  %t23 = insertvalue %StructLayoutHeaderParse undef, i1 0, 0
  %s24 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t25 = insertvalue %StructLayoutHeaderParse %t23, i8* %s24, 1
  %t26 = sitofp i64 0 to double
  %t27 = insertvalue %StructLayoutHeaderParse %t25, double %t26, 2
  %t28 = sitofp i64 0 to double
  %t29 = insertvalue %StructLayoutHeaderParse %t27, double %t28, 3
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t31 = insertvalue %StructLayoutHeaderParse %t29, { i8**, i64 }* %t30, 4
  ret %StructLayoutHeaderParse %t31
merge1:
  store i1 0, i1* %l2
  store i1 0, i1* %l3
  store i1 0, i1* %l4
  %s32 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s32, i8** %l5
  %t33 = sitofp i64 0 to double
  store double %t33, double* %l6
  %t34 = sitofp i64 0 to double
  store double %t34, double* %l7
  %t35 = sitofp i64 0 to double
  store double %t35, double* %l8
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t38 = load i1, i1* %l2
  %t39 = load i1, i1* %l3
  %t40 = load i1, i1* %l4
  %t41 = load i8*, i8** %l5
  %t42 = load double, double* %l6
  %t43 = load double, double* %l7
  %t44 = load double, double* %l8
  br label %loop.header2
loop.header2:
  %t244 = phi i8* [ %t41, %merge1 ], [ %t236, %loop.latch4 ]
  %t245 = phi i1 [ %t38, %merge1 ], [ %t237, %loop.latch4 ]
  %t246 = phi i1 [ %t39, %merge1 ], [ %t238, %loop.latch4 ]
  %t247 = phi double [ %t42, %merge1 ], [ %t239, %loop.latch4 ]
  %t248 = phi { i8**, i64 }* [ %t37, %merge1 ], [ %t240, %loop.latch4 ]
  %t249 = phi i1 [ %t40, %merge1 ], [ %t241, %loop.latch4 ]
  %t250 = phi double [ %t43, %merge1 ], [ %t242, %loop.latch4 ]
  %t251 = phi double [ %t44, %merge1 ], [ %t243, %loop.latch4 ]
  store i8* %t244, i8** %l5
  store i1 %t245, i1* %l2
  store i1 %t246, i1* %l3
  store double %t247, double* %l6
  store { i8**, i64 }* %t248, { i8**, i64 }** %l1
  store i1 %t249, i1* %l4
  store double %t250, double* %l7
  store double %t251, double* %l8
  br label %loop.body3
loop.body3:
  %t45 = load double, double* %l8
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t47 = load { i8**, i64 }, { i8**, i64 }* %t46
  %t48 = extractvalue { i8**, i64 } %t47, 1
  %t49 = sitofp i64 %t48 to double
  %t50 = fcmp oge double %t45, %t49
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t53 = load i1, i1* %l2
  %t54 = load i1, i1* %l3
  %t55 = load i1, i1* %l4
  %t56 = load i8*, i8** %l5
  %t57 = load double, double* %l6
  %t58 = load double, double* %l7
  %t59 = load double, double* %l8
  br i1 %t50, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t61 = load double, double* %l8
  %t62 = fptosi double %t61 to i64
  %t63 = load { i8**, i64 }, { i8**, i64 }* %t60
  %t64 = extractvalue { i8**, i64 } %t63, 0
  %t65 = extractvalue { i8**, i64 } %t63, 1
  %t66 = icmp uge i64 %t62, %t65
  ; bounds check: %t66 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t62, i64 %t65)
  %t67 = getelementptr i8*, i8** %t64, i64 %t62
  %t68 = load i8*, i8** %t67
  store i8* %t68, i8** %l9
  %t69 = load i8*, i8** %l9
  %s70 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h261048910, i32 0, i32 0
  %t71 = call i1 @starts_with(i8* %t69, i8* %s70)
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t74 = load i1, i1* %l2
  %t75 = load i1, i1* %l3
  %t76 = load i1, i1* %l4
  %t77 = load i8*, i8** %l5
  %t78 = load double, double* %l6
  %t79 = load double, double* %l7
  %t80 = load double, double* %l8
  %t81 = load i8*, i8** %l9
  br i1 %t71, label %then8, label %else9
then8:
  %t82 = load i8*, i8** %l9
  %t83 = load i8*, i8** %l9
  %t84 = call i64 @sailfin_runtime_string_length(i8* %t83)
  %t85 = call i8* @sailfin_runtime_substring(i8* %t82, i64 5, i64 %t84)
  store i8* %t85, i8** %l5
  store i1 1, i1* %l2
  %t86 = load i8*, i8** %l5
  %t87 = load i1, i1* %l2
  br label %merge10
else9:
  %t88 = load i8*, i8** %l9
  %s89 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h466680424, i32 0, i32 0
  %t90 = call i1 @starts_with(i8* %t88, i8* %s89)
  %t91 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t93 = load i1, i1* %l2
  %t94 = load i1, i1* %l3
  %t95 = load i1, i1* %l4
  %t96 = load i8*, i8** %l5
  %t97 = load double, double* %l6
  %t98 = load double, double* %l7
  %t99 = load double, double* %l8
  %t100 = load i8*, i8** %l9
  br i1 %t90, label %then11, label %else12
then11:
  %t101 = load i8*, i8** %l9
  %t102 = load i8*, i8** %l9
  %t103 = call i64 @sailfin_runtime_string_length(i8* %t102)
  %t104 = call i8* @sailfin_runtime_substring(i8* %t101, i64 5, i64 %t103)
  store i8* %t104, i8** %l10
  %t105 = load i8*, i8** %l10
  %t106 = call %NumberParseResult @parse_decimal_number(i8* %t105)
  store %NumberParseResult %t106, %NumberParseResult* %l11
  %t107 = load %NumberParseResult, %NumberParseResult* %l11
  %t108 = extractvalue %NumberParseResult %t107, 0
  %t109 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t110 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t111 = load i1, i1* %l2
  %t112 = load i1, i1* %l3
  %t113 = load i1, i1* %l4
  %t114 = load i8*, i8** %l5
  %t115 = load double, double* %l6
  %t116 = load double, double* %l7
  %t117 = load double, double* %l8
  %t118 = load i8*, i8** %l9
  %t119 = load i8*, i8** %l10
  %t120 = load %NumberParseResult, %NumberParseResult* %l11
  br i1 %t108, label %then14, label %else15
then14:
  store i1 1, i1* %l3
  %t121 = load %NumberParseResult, %NumberParseResult* %l11
  %t122 = extractvalue %NumberParseResult %t121, 1
  store double %t122, double* %l6
  %t123 = load i1, i1* %l3
  %t124 = load double, double* %l6
  br label %merge16
else15:
  %t125 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s126 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.len39.h943297157, i32 0, i32 0
  %t127 = load i8*, i8** %l10
  %t128 = call i8* @sailfin_runtime_string_concat(i8* %s126, i8* %t127)
  %t129 = alloca [2 x i8], align 1
  %t130 = getelementptr [2 x i8], [2 x i8]* %t129, i32 0, i32 0
  store i8 96, i8* %t130
  %t131 = getelementptr [2 x i8], [2 x i8]* %t129, i32 0, i32 1
  store i8 0, i8* %t131
  %t132 = getelementptr [2 x i8], [2 x i8]* %t129, i32 0, i32 0
  %t133 = call i8* @sailfin_runtime_string_concat(i8* %t128, i8* %t132)
  %t134 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t125, i8* %t133)
  store { i8**, i64 }* %t134, { i8**, i64 }** %l1
  %t135 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge16
merge16:
  %t136 = phi i1 [ %t123, %then14 ], [ %t112, %else15 ]
  %t137 = phi double [ %t124, %then14 ], [ %t115, %else15 ]
  %t138 = phi { i8**, i64 }* [ %t110, %then14 ], [ %t135, %else15 ]
  store i1 %t136, i1* %l3
  store double %t137, double* %l6
  store { i8**, i64 }* %t138, { i8**, i64 }** %l1
  %t139 = load i1, i1* %l3
  %t140 = load double, double* %l6
  %t141 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge13
else12:
  %t142 = load i8*, i8** %l9
  %s143 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h841337749, i32 0, i32 0
  %t144 = call i1 @starts_with(i8* %t142, i8* %s143)
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
  br i1 %t144, label %then17, label %else18
then17:
  %t155 = load i8*, i8** %l9
  %t156 = load i8*, i8** %l9
  %t157 = call i64 @sailfin_runtime_string_length(i8* %t156)
  %t158 = call i8* @sailfin_runtime_substring(i8* %t155, i64 6, i64 %t157)
  store i8* %t158, i8** %l12
  %t159 = load i8*, i8** %l12
  %t160 = call %NumberParseResult @parse_decimal_number(i8* %t159)
  store %NumberParseResult %t160, %NumberParseResult* %l13
  %t161 = load %NumberParseResult, %NumberParseResult* %l13
  %t162 = extractvalue %NumberParseResult %t161, 0
  %t163 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t164 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t165 = load i1, i1* %l2
  %t166 = load i1, i1* %l3
  %t167 = load i1, i1* %l4
  %t168 = load i8*, i8** %l5
  %t169 = load double, double* %l6
  %t170 = load double, double* %l7
  %t171 = load double, double* %l8
  %t172 = load i8*, i8** %l9
  %t173 = load i8*, i8** %l12
  %t174 = load %NumberParseResult, %NumberParseResult* %l13
  br i1 %t162, label %then20, label %else21
then20:
  store i1 1, i1* %l4
  %t175 = load %NumberParseResult, %NumberParseResult* %l13
  %t176 = extractvalue %NumberParseResult %t175, 1
  store double %t176, double* %l7
  %t177 = load i1, i1* %l4
  %t178 = load double, double* %l7
  br label %merge22
else21:
  %t179 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s180 = getelementptr inbounds [41 x i8], [41 x i8]* @.str.len40.h1650449248, i32 0, i32 0
  %t181 = load i8*, i8** %l12
  %t182 = call i8* @sailfin_runtime_string_concat(i8* %s180, i8* %t181)
  %t183 = alloca [2 x i8], align 1
  %t184 = getelementptr [2 x i8], [2 x i8]* %t183, i32 0, i32 0
  store i8 96, i8* %t184
  %t185 = getelementptr [2 x i8], [2 x i8]* %t183, i32 0, i32 1
  store i8 0, i8* %t185
  %t186 = getelementptr [2 x i8], [2 x i8]* %t183, i32 0, i32 0
  %t187 = call i8* @sailfin_runtime_string_concat(i8* %t182, i8* %t186)
  %t188 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t179, i8* %t187)
  store { i8**, i64 }* %t188, { i8**, i64 }** %l1
  %t189 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge22
merge22:
  %t190 = phi i1 [ %t177, %then20 ], [ %t167, %else21 ]
  %t191 = phi double [ %t178, %then20 ], [ %t170, %else21 ]
  %t192 = phi { i8**, i64 }* [ %t164, %then20 ], [ %t189, %else21 ]
  store i1 %t190, i1* %l4
  store double %t191, double* %l7
  store { i8**, i64 }* %t192, { i8**, i64 }** %l1
  %t193 = load i1, i1* %l4
  %t194 = load double, double* %l7
  %t195 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge19
else18:
  %t196 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s197 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.len41.h1415177535, i32 0, i32 0
  %t198 = load i8*, i8** %l9
  %t199 = call i8* @sailfin_runtime_string_concat(i8* %s197, i8* %t198)
  %t200 = alloca [2 x i8], align 1
  %t201 = getelementptr [2 x i8], [2 x i8]* %t200, i32 0, i32 0
  store i8 96, i8* %t201
  %t202 = getelementptr [2 x i8], [2 x i8]* %t200, i32 0, i32 1
  store i8 0, i8* %t202
  %t203 = getelementptr [2 x i8], [2 x i8]* %t200, i32 0, i32 0
  %t204 = call i8* @sailfin_runtime_string_concat(i8* %t199, i8* %t203)
  %t205 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t196, i8* %t204)
  store { i8**, i64 }* %t205, { i8**, i64 }** %l1
  %t206 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge19
merge19:
  %t207 = phi i1 [ %t193, %merge22 ], [ %t149, %else18 ]
  %t208 = phi double [ %t194, %merge22 ], [ %t152, %else18 ]
  %t209 = phi { i8**, i64 }* [ %t195, %merge22 ], [ %t206, %else18 ]
  store i1 %t207, i1* %l4
  store double %t208, double* %l7
  store { i8**, i64 }* %t209, { i8**, i64 }** %l1
  %t210 = load i1, i1* %l4
  %t211 = load double, double* %l7
  %t212 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t213 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge13
merge13:
  %t214 = phi i1 [ %t139, %merge16 ], [ %t94, %merge19 ]
  %t215 = phi double [ %t140, %merge16 ], [ %t97, %merge19 ]
  %t216 = phi { i8**, i64 }* [ %t141, %merge16 ], [ %t212, %merge19 ]
  %t217 = phi i1 [ %t95, %merge16 ], [ %t210, %merge19 ]
  %t218 = phi double [ %t98, %merge16 ], [ %t211, %merge19 ]
  store i1 %t214, i1* %l3
  store double %t215, double* %l6
  store { i8**, i64 }* %t216, { i8**, i64 }** %l1
  store i1 %t217, i1* %l4
  store double %t218, double* %l7
  %t219 = load i1, i1* %l3
  %t220 = load double, double* %l6
  %t221 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t222 = load i1, i1* %l4
  %t223 = load double, double* %l7
  %t224 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t225 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge10
merge10:
  %t226 = phi i8* [ %t86, %then8 ], [ %t77, %merge13 ]
  %t227 = phi i1 [ %t87, %then8 ], [ %t74, %merge13 ]
  %t228 = phi i1 [ %t75, %then8 ], [ %t219, %merge13 ]
  %t229 = phi double [ %t78, %then8 ], [ %t220, %merge13 ]
  %t230 = phi { i8**, i64 }* [ %t73, %then8 ], [ %t221, %merge13 ]
  %t231 = phi i1 [ %t76, %then8 ], [ %t222, %merge13 ]
  %t232 = phi double [ %t79, %then8 ], [ %t223, %merge13 ]
  store i8* %t226, i8** %l5
  store i1 %t227, i1* %l2
  store i1 %t228, i1* %l3
  store double %t229, double* %l6
  store { i8**, i64 }* %t230, { i8**, i64 }** %l1
  store i1 %t231, i1* %l4
  store double %t232, double* %l7
  %t233 = load double, double* %l8
  %t234 = sitofp i64 1 to double
  %t235 = fadd double %t233, %t234
  store double %t235, double* %l8
  br label %loop.latch4
loop.latch4:
  %t236 = load i8*, i8** %l5
  %t237 = load i1, i1* %l2
  %t238 = load i1, i1* %l3
  %t239 = load double, double* %l6
  %t240 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t241 = load i1, i1* %l4
  %t242 = load double, double* %l7
  %t243 = load double, double* %l8
  br label %loop.header2
afterloop5:
  %t252 = load i8*, i8** %l5
  %t253 = load i1, i1* %l2
  %t254 = load i1, i1* %l3
  %t255 = load double, double* %l6
  %t256 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t257 = load i1, i1* %l4
  %t258 = load double, double* %l7
  %t259 = load double, double* %l8
  %t260 = load i1, i1* %l3
  %t261 = xor i1 %t260, 1
  %t262 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t263 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t264 = load i1, i1* %l2
  %t265 = load i1, i1* %l3
  %t266 = load i1, i1* %l4
  %t267 = load i8*, i8** %l5
  %t268 = load double, double* %l6
  %t269 = load double, double* %l7
  %t270 = load double, double* %l8
  br i1 %t261, label %then23, label %merge24
then23:
  %t271 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s272 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.len39.h1399971520, i32 0, i32 0
  %t273 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t271, i8* %s272)
  store { i8**, i64 }* %t273, { i8**, i64 }** %l1
  %t274 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge24
merge24:
  %t275 = phi { i8**, i64 }* [ %t274, %then23 ], [ %t263, %afterloop5 ]
  store { i8**, i64 }* %t275, { i8**, i64 }** %l1
  %t276 = load i1, i1* %l4
  %t277 = xor i1 %t276, 1
  %t278 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t279 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t280 = load i1, i1* %l2
  %t281 = load i1, i1* %l3
  %t282 = load i1, i1* %l4
  %t283 = load i8*, i8** %l5
  %t284 = load double, double* %l6
  %t285 = load double, double* %l7
  %t286 = load double, double* %l8
  br i1 %t277, label %then25, label %merge26
then25:
  %t287 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s288 = getelementptr inbounds [41 x i8], [41 x i8]* @.str.len40.h318366654, i32 0, i32 0
  %t289 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t287, i8* %s288)
  store { i8**, i64 }* %t289, { i8**, i64 }** %l1
  %t290 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge26
merge26:
  %t291 = phi { i8**, i64 }* [ %t290, %then25 ], [ %t279, %merge24 ]
  store { i8**, i64 }* %t291, { i8**, i64 }** %l1
  %t293 = load i1, i1* %l3
  br label %logical_and_entry_292

logical_and_entry_292:
  br i1 %t293, label %logical_and_right_292, label %logical_and_merge_292

logical_and_right_292:
  %t295 = load i1, i1* %l4
  br label %logical_and_entry_294

logical_and_entry_294:
  br i1 %t295, label %logical_and_right_294, label %logical_and_merge_294

logical_and_right_294:
  %t296 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t297 = load { i8**, i64 }, { i8**, i64 }* %t296
  %t298 = extractvalue { i8**, i64 } %t297, 1
  %t299 = icmp eq i64 %t298, 0
  br label %logical_and_right_end_294

logical_and_right_end_294:
  br label %logical_and_merge_294

logical_and_merge_294:
  %t300 = phi i1 [ false, %logical_and_entry_294 ], [ %t299, %logical_and_right_end_294 ]
  br label %logical_and_right_end_292

logical_and_right_end_292:
  br label %logical_and_merge_292

logical_and_merge_292:
  %t301 = phi i1 [ false, %logical_and_entry_292 ], [ %t300, %logical_and_right_end_292 ]
  store i1 %t301, i1* %l14
  %t302 = load i1, i1* %l14
  %t303 = insertvalue %StructLayoutHeaderParse undef, i1 %t302, 0
  %t304 = load i8*, i8** %l5
  %t305 = insertvalue %StructLayoutHeaderParse %t303, i8* %t304, 1
  %t306 = load double, double* %l6
  %t307 = insertvalue %StructLayoutHeaderParse %t305, double %t306, 2
  %t308 = load double, double* %l7
  %t309 = insertvalue %StructLayoutHeaderParse %t307, double %t308, 3
  %t310 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t311 = insertvalue %StructLayoutHeaderParse %t309, { i8**, i64 }* %t310, 4
  ret %StructLayoutHeaderParse %t311
}

define %StructLayoutFieldParse @parse_struct_layout_field(i8* %text, i8* %struct_name) {
block.entry:
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
  %t1 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t2 = ptrtoint [0 x i8*]* %t1 to i64
  %t3 = icmp eq i64 %t2, 0
  %t4 = select i1 %t3, i64 1, i64 %t2
  %t5 = call i8* @malloc(i64 %t4)
  %t6 = bitcast i8* %t5 to i8**
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t8 = ptrtoint { i8**, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { i8**, i64 }*
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 0
  store i8** %t6, i8*** %t11
  %t12 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 1
  store i64 0, i64* %t12
  store { i8**, i64 }* %t10, { i8**, i64 }** %l1
  %s13 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t14 = insertvalue %NativeStructLayoutField undef, i8* %s13, 0
  %s15 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t16 = insertvalue %NativeStructLayoutField %t14, i8* %s15, 1
  %t17 = sitofp i64 0 to double
  %t18 = insertvalue %NativeStructLayoutField %t16, double %t17, 2
  %t19 = sitofp i64 0 to double
  %t20 = insertvalue %NativeStructLayoutField %t18, double %t19, 3
  %t21 = sitofp i64 0 to double
  %t22 = insertvalue %NativeStructLayoutField %t20, double %t21, 4
  store %NativeStructLayoutField %t22, %NativeStructLayoutField* %l2
  %t23 = load i8*, i8** %l0
  %t24 = call i64 @sailfin_runtime_string_length(i8* %t23)
  %t25 = icmp eq i64 %t24, 0
  %t26 = load i8*, i8** %l0
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t28 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  br i1 %t25, label %then0, label %merge1
then0:
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s30 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t31 = call i8* @sailfin_runtime_string_concat(i8* %s30, i8* %struct_name)
  %s32 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.len29.h128952257, i32 0, i32 0
  %t33 = call i8* @sailfin_runtime_string_concat(i8* %t31, i8* %s32)
  %t34 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t29, i8* %t33)
  store { i8**, i64 }* %t34, { i8**, i64 }** %l1
  %t35 = insertvalue %StructLayoutFieldParse undef, i1 0, 0
  %t36 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t37 = insertvalue %StructLayoutFieldParse %t35, %NativeStructLayoutField %t36, 1
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t39 = insertvalue %StructLayoutFieldParse %t37, { i8**, i64 }* %t38, 2
  ret %StructLayoutFieldParse %t39
merge1:
  %t40 = load i8*, i8** %l0
  %t41 = call { i8**, i64 }* @split_whitespace(i8* %t40)
  store { i8**, i64 }* %t41, { i8**, i64 }** %l3
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t43 = load { i8**, i64 }, { i8**, i64 }* %t42
  %t44 = extractvalue { i8**, i64 } %t43, 1
  %t45 = icmp eq i64 %t44, 0
  %t46 = load i8*, i8** %l0
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t48 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l3
  br i1 %t45, label %then2, label %merge3
then2:
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s51 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t52 = call i8* @sailfin_runtime_string_concat(i8* %s51, i8* %struct_name)
  %s53 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.len29.h555082439, i32 0, i32 0
  %t54 = call i8* @sailfin_runtime_string_concat(i8* %t52, i8* %s53)
  %t55 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t50, i8* %t54)
  store { i8**, i64 }* %t55, { i8**, i64 }** %l1
  %t56 = insertvalue %StructLayoutFieldParse undef, i1 0, 0
  %t57 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t58 = insertvalue %StructLayoutFieldParse %t56, %NativeStructLayoutField %t57, 1
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t60 = insertvalue %StructLayoutFieldParse %t58, { i8**, i64 }* %t59, 2
  ret %StructLayoutFieldParse %t60
merge3:
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t62 = load { i8**, i64 }, { i8**, i64 }* %t61
  %t63 = extractvalue { i8**, i64 } %t62, 0
  %t64 = extractvalue { i8**, i64 } %t62, 1
  %t65 = icmp uge i64 0, %t64
  ; bounds check: %t65 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 0, i64 %t64)
  %t66 = getelementptr i8*, i8** %t63, i64 0
  %t67 = load i8*, i8** %t66
  store i8* %t67, i8** %l4
  %t68 = load i8*, i8** %l4
  %t69 = call i64 @sailfin_runtime_string_length(i8* %t68)
  %t70 = icmp eq i64 %t69, 0
  %t71 = load i8*, i8** %l0
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t73 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t75 = load i8*, i8** %l4
  br i1 %t70, label %then4, label %merge5
then4:
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s77 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t78 = call i8* @sailfin_runtime_string_concat(i8* %s77, i8* %struct_name)
  %s79 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.len26.h130324785, i32 0, i32 0
  %t80 = call i8* @sailfin_runtime_string_concat(i8* %t78, i8* %s79)
  %t81 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t76, i8* %t80)
  store { i8**, i64 }* %t81, { i8**, i64 }** %l1
  %t82 = insertvalue %StructLayoutFieldParse undef, i1 0, 0
  %t83 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t84 = insertvalue %StructLayoutFieldParse %t82, %NativeStructLayoutField %t83, 1
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t86 = insertvalue %StructLayoutFieldParse %t84, { i8**, i64 }* %t85, 2
  ret %StructLayoutFieldParse %t86
merge5:
  %s87 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s87, i8** %l5
  store i1 0, i1* %l6
  store i1 0, i1* %l7
  store i1 0, i1* %l8
  %t88 = sitofp i64 0 to double
  store double %t88, double* %l9
  %t89 = sitofp i64 0 to double
  store double %t89, double* %l10
  %t90 = sitofp i64 0 to double
  store double %t90, double* %l11
  %t91 = sitofp i64 1 to double
  store double %t91, double* %l12
  %t92 = load i8*, i8** %l0
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t94 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t95 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t96 = load i8*, i8** %l4
  %t97 = load i8*, i8** %l5
  %t98 = load i1, i1* %l6
  %t99 = load i1, i1* %l7
  %t100 = load i1, i1* %l8
  %t101 = load double, double* %l9
  %t102 = load double, double* %l10
  %t103 = load double, double* %l11
  %t104 = load double, double* %l12
  br label %loop.header6
loop.header6:
  %t436 = phi i8* [ %t97, %merge5 ], [ %t427, %loop.latch8 ]
  %t437 = phi i1 [ %t98, %merge5 ], [ %t428, %loop.latch8 ]
  %t438 = phi double [ %t101, %merge5 ], [ %t429, %loop.latch8 ]
  %t439 = phi { i8**, i64 }* [ %t93, %merge5 ], [ %t430, %loop.latch8 ]
  %t440 = phi i1 [ %t99, %merge5 ], [ %t431, %loop.latch8 ]
  %t441 = phi double [ %t102, %merge5 ], [ %t432, %loop.latch8 ]
  %t442 = phi i1 [ %t100, %merge5 ], [ %t433, %loop.latch8 ]
  %t443 = phi double [ %t103, %merge5 ], [ %t434, %loop.latch8 ]
  %t444 = phi double [ %t104, %merge5 ], [ %t435, %loop.latch8 ]
  store i8* %t436, i8** %l5
  store i1 %t437, i1* %l6
  store double %t438, double* %l9
  store { i8**, i64 }* %t439, { i8**, i64 }** %l1
  store i1 %t440, i1* %l7
  store double %t441, double* %l10
  store i1 %t442, i1* %l8
  store double %t443, double* %l11
  store double %t444, double* %l12
  br label %loop.body7
loop.body7:
  %t105 = load double, double* %l12
  %t106 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t107 = load { i8**, i64 }, { i8**, i64 }* %t106
  %t108 = extractvalue { i8**, i64 } %t107, 1
  %t109 = sitofp i64 %t108 to double
  %t110 = fcmp oge double %t105, %t109
  %t111 = load i8*, i8** %l0
  %t112 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t113 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t114 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t115 = load i8*, i8** %l4
  %t116 = load i8*, i8** %l5
  %t117 = load i1, i1* %l6
  %t118 = load i1, i1* %l7
  %t119 = load i1, i1* %l8
  %t120 = load double, double* %l9
  %t121 = load double, double* %l10
  %t122 = load double, double* %l11
  %t123 = load double, double* %l12
  br i1 %t110, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t124 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t125 = load double, double* %l12
  %t126 = fptosi double %t125 to i64
  %t127 = load { i8**, i64 }, { i8**, i64 }* %t124
  %t128 = extractvalue { i8**, i64 } %t127, 0
  %t129 = extractvalue { i8**, i64 } %t127, 1
  %t130 = icmp uge i64 %t126, %t129
  ; bounds check: %t130 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t126, i64 %t129)
  %t131 = getelementptr i8*, i8** %t128, i64 %t126
  %t132 = load i8*, i8** %t131
  store i8* %t132, i8** %l13
  %t133 = load i8*, i8** %l13
  %s134 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h524431183, i32 0, i32 0
  %t135 = call i1 @starts_with(i8* %t133, i8* %s134)
  %t136 = load i8*, i8** %l0
  %t137 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t138 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t139 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t140 = load i8*, i8** %l4
  %t141 = load i8*, i8** %l5
  %t142 = load i1, i1* %l6
  %t143 = load i1, i1* %l7
  %t144 = load i1, i1* %l8
  %t145 = load double, double* %l9
  %t146 = load double, double* %l10
  %t147 = load double, double* %l11
  %t148 = load double, double* %l12
  %t149 = load i8*, i8** %l13
  br i1 %t135, label %then12, label %else13
then12:
  %t150 = load i8*, i8** %l13
  %t151 = load i8*, i8** %l13
  %t152 = call i64 @sailfin_runtime_string_length(i8* %t151)
  %t153 = call i8* @sailfin_runtime_substring(i8* %t150, i64 5, i64 %t152)
  store i8* %t153, i8** %l5
  %t154 = load i8*, i8** %l5
  br label %merge14
else13:
  %t155 = load i8*, i8** %l13
  %s156 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h242296049, i32 0, i32 0
  %t157 = call i1 @starts_with(i8* %t155, i8* %s156)
  %t158 = load i8*, i8** %l0
  %t159 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t160 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t161 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t162 = load i8*, i8** %l4
  %t163 = load i8*, i8** %l5
  %t164 = load i1, i1* %l6
  %t165 = load i1, i1* %l7
  %t166 = load i1, i1* %l8
  %t167 = load double, double* %l9
  %t168 = load double, double* %l10
  %t169 = load double, double* %l11
  %t170 = load double, double* %l12
  %t171 = load i8*, i8** %l13
  br i1 %t157, label %then15, label %else16
then15:
  %t172 = load i8*, i8** %l13
  %t173 = load i8*, i8** %l13
  %t174 = call i64 @sailfin_runtime_string_length(i8* %t173)
  %t175 = call i8* @sailfin_runtime_substring(i8* %t172, i64 7, i64 %t174)
  store i8* %t175, i8** %l14
  %t176 = load i8*, i8** %l14
  %t177 = call %NumberParseResult @parse_decimal_number(i8* %t176)
  store %NumberParseResult %t177, %NumberParseResult* %l15
  %t178 = load %NumberParseResult, %NumberParseResult* %l15
  %t179 = extractvalue %NumberParseResult %t178, 0
  %t180 = load i8*, i8** %l0
  %t181 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t182 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t183 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t184 = load i8*, i8** %l4
  %t185 = load i8*, i8** %l5
  %t186 = load i1, i1* %l6
  %t187 = load i1, i1* %l7
  %t188 = load i1, i1* %l8
  %t189 = load double, double* %l9
  %t190 = load double, double* %l10
  %t191 = load double, double* %l11
  %t192 = load double, double* %l12
  %t193 = load i8*, i8** %l13
  %t194 = load i8*, i8** %l14
  %t195 = load %NumberParseResult, %NumberParseResult* %l15
  br i1 %t179, label %then18, label %else19
then18:
  store i1 1, i1* %l6
  %t196 = load %NumberParseResult, %NumberParseResult* %l15
  %t197 = extractvalue %NumberParseResult %t196, 1
  store double %t197, double* %l9
  %t198 = load i1, i1* %l6
  %t199 = load double, double* %l9
  br label %merge20
else19:
  %t200 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s201 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t202 = call i8* @sailfin_runtime_string_concat(i8* %s201, i8* %struct_name)
  %s203 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h506269955, i32 0, i32 0
  %t204 = call i8* @sailfin_runtime_string_concat(i8* %t202, i8* %s203)
  %t205 = load i8*, i8** %l4
  %t206 = call i8* @sailfin_runtime_string_concat(i8* %t204, i8* %t205)
  %s207 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h24304067, i32 0, i32 0
  %t208 = call i8* @sailfin_runtime_string_concat(i8* %t206, i8* %s207)
  %t209 = load i8*, i8** %l14
  %t210 = call i8* @sailfin_runtime_string_concat(i8* %t208, i8* %t209)
  %t211 = alloca [2 x i8], align 1
  %t212 = getelementptr [2 x i8], [2 x i8]* %t211, i32 0, i32 0
  store i8 96, i8* %t212
  %t213 = getelementptr [2 x i8], [2 x i8]* %t211, i32 0, i32 1
  store i8 0, i8* %t213
  %t214 = getelementptr [2 x i8], [2 x i8]* %t211, i32 0, i32 0
  %t215 = call i8* @sailfin_runtime_string_concat(i8* %t210, i8* %t214)
  %t216 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t200, i8* %t215)
  store { i8**, i64 }* %t216, { i8**, i64 }** %l1
  %t217 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge20
merge20:
  %t218 = phi i1 [ %t198, %then18 ], [ %t186, %else19 ]
  %t219 = phi double [ %t199, %then18 ], [ %t189, %else19 ]
  %t220 = phi { i8**, i64 }* [ %t181, %then18 ], [ %t217, %else19 ]
  store i1 %t218, i1* %l6
  store double %t219, double* %l9
  store { i8**, i64 }* %t220, { i8**, i64 }** %l1
  %t221 = load i1, i1* %l6
  %t222 = load double, double* %l9
  %t223 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge17
else16:
  %t224 = load i8*, i8** %l13
  %s225 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h466680424, i32 0, i32 0
  %t226 = call i1 @starts_with(i8* %t224, i8* %s225)
  %t227 = load i8*, i8** %l0
  %t228 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t229 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t230 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t231 = load i8*, i8** %l4
  %t232 = load i8*, i8** %l5
  %t233 = load i1, i1* %l6
  %t234 = load i1, i1* %l7
  %t235 = load i1, i1* %l8
  %t236 = load double, double* %l9
  %t237 = load double, double* %l10
  %t238 = load double, double* %l11
  %t239 = load double, double* %l12
  %t240 = load i8*, i8** %l13
  br i1 %t226, label %then21, label %else22
then21:
  %t241 = load i8*, i8** %l13
  %t242 = load i8*, i8** %l13
  %t243 = call i64 @sailfin_runtime_string_length(i8* %t242)
  %t244 = call i8* @sailfin_runtime_substring(i8* %t241, i64 5, i64 %t243)
  store i8* %t244, i8** %l16
  %t245 = load i8*, i8** %l16
  %t246 = call %NumberParseResult @parse_decimal_number(i8* %t245)
  store %NumberParseResult %t246, %NumberParseResult* %l17
  %t247 = load %NumberParseResult, %NumberParseResult* %l17
  %t248 = extractvalue %NumberParseResult %t247, 0
  %t249 = load i8*, i8** %l0
  %t250 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t251 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t252 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t253 = load i8*, i8** %l4
  %t254 = load i8*, i8** %l5
  %t255 = load i1, i1* %l6
  %t256 = load i1, i1* %l7
  %t257 = load i1, i1* %l8
  %t258 = load double, double* %l9
  %t259 = load double, double* %l10
  %t260 = load double, double* %l11
  %t261 = load double, double* %l12
  %t262 = load i8*, i8** %l13
  %t263 = load i8*, i8** %l16
  %t264 = load %NumberParseResult, %NumberParseResult* %l17
  br i1 %t248, label %then24, label %else25
then24:
  store i1 1, i1* %l7
  %t265 = load %NumberParseResult, %NumberParseResult* %l17
  %t266 = extractvalue %NumberParseResult %t265, 1
  store double %t266, double* %l10
  %t267 = load i1, i1* %l7
  %t268 = load double, double* %l10
  br label %merge26
else25:
  %t269 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s270 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t271 = call i8* @sailfin_runtime_string_concat(i8* %s270, i8* %struct_name)
  %s272 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h506269955, i32 0, i32 0
  %t273 = call i8* @sailfin_runtime_string_concat(i8* %t271, i8* %s272)
  %t274 = load i8*, i8** %l4
  %t275 = call i8* @sailfin_runtime_string_concat(i8* %t273, i8* %t274)
  %s276 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h151690315, i32 0, i32 0
  %t277 = call i8* @sailfin_runtime_string_concat(i8* %t275, i8* %s276)
  %t278 = load i8*, i8** %l16
  %t279 = call i8* @sailfin_runtime_string_concat(i8* %t277, i8* %t278)
  %t280 = alloca [2 x i8], align 1
  %t281 = getelementptr [2 x i8], [2 x i8]* %t280, i32 0, i32 0
  store i8 96, i8* %t281
  %t282 = getelementptr [2 x i8], [2 x i8]* %t280, i32 0, i32 1
  store i8 0, i8* %t282
  %t283 = getelementptr [2 x i8], [2 x i8]* %t280, i32 0, i32 0
  %t284 = call i8* @sailfin_runtime_string_concat(i8* %t279, i8* %t283)
  %t285 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t269, i8* %t284)
  store { i8**, i64 }* %t285, { i8**, i64 }** %l1
  %t286 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge26
merge26:
  %t287 = phi i1 [ %t267, %then24 ], [ %t256, %else25 ]
  %t288 = phi double [ %t268, %then24 ], [ %t259, %else25 ]
  %t289 = phi { i8**, i64 }* [ %t250, %then24 ], [ %t286, %else25 ]
  store i1 %t287, i1* %l7
  store double %t288, double* %l10
  store { i8**, i64 }* %t289, { i8**, i64 }** %l1
  %t290 = load i1, i1* %l7
  %t291 = load double, double* %l10
  %t292 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge23
else22:
  %t293 = load i8*, i8** %l13
  %s294 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h841337749, i32 0, i32 0
  %t295 = call i1 @starts_with(i8* %t293, i8* %s294)
  %t296 = load i8*, i8** %l0
  %t297 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t298 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t299 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t300 = load i8*, i8** %l4
  %t301 = load i8*, i8** %l5
  %t302 = load i1, i1* %l6
  %t303 = load i1, i1* %l7
  %t304 = load i1, i1* %l8
  %t305 = load double, double* %l9
  %t306 = load double, double* %l10
  %t307 = load double, double* %l11
  %t308 = load double, double* %l12
  %t309 = load i8*, i8** %l13
  br i1 %t295, label %then27, label %else28
then27:
  %t310 = load i8*, i8** %l13
  %t311 = load i8*, i8** %l13
  %t312 = call i64 @sailfin_runtime_string_length(i8* %t311)
  %t313 = call i8* @sailfin_runtime_substring(i8* %t310, i64 6, i64 %t312)
  store i8* %t313, i8** %l18
  %t314 = load i8*, i8** %l18
  %t315 = call %NumberParseResult @parse_decimal_number(i8* %t314)
  store %NumberParseResult %t315, %NumberParseResult* %l19
  %t316 = load %NumberParseResult, %NumberParseResult* %l19
  %t317 = extractvalue %NumberParseResult %t316, 0
  %t318 = load i8*, i8** %l0
  %t319 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t320 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t321 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t322 = load i8*, i8** %l4
  %t323 = load i8*, i8** %l5
  %t324 = load i1, i1* %l6
  %t325 = load i1, i1* %l7
  %t326 = load i1, i1* %l8
  %t327 = load double, double* %l9
  %t328 = load double, double* %l10
  %t329 = load double, double* %l11
  %t330 = load double, double* %l12
  %t331 = load i8*, i8** %l13
  %t332 = load i8*, i8** %l18
  %t333 = load %NumberParseResult, %NumberParseResult* %l19
  br i1 %t317, label %then30, label %else31
then30:
  store i1 1, i1* %l8
  %t334 = load %NumberParseResult, %NumberParseResult* %l19
  %t335 = extractvalue %NumberParseResult %t334, 1
  store double %t335, double* %l11
  %t336 = load i1, i1* %l8
  %t337 = load double, double* %l11
  br label %merge32
else31:
  %t338 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s339 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t340 = call i8* @sailfin_runtime_string_concat(i8* %s339, i8* %struct_name)
  %s341 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h506269955, i32 0, i32 0
  %t342 = call i8* @sailfin_runtime_string_concat(i8* %t340, i8* %s341)
  %t343 = load i8*, i8** %l4
  %t344 = call i8* @sailfin_runtime_string_concat(i8* %t342, i8* %t343)
  %s345 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.len21.h1297227834, i32 0, i32 0
  %t346 = call i8* @sailfin_runtime_string_concat(i8* %t344, i8* %s345)
  %t347 = load i8*, i8** %l18
  %t348 = call i8* @sailfin_runtime_string_concat(i8* %t346, i8* %t347)
  %t349 = alloca [2 x i8], align 1
  %t350 = getelementptr [2 x i8], [2 x i8]* %t349, i32 0, i32 0
  store i8 96, i8* %t350
  %t351 = getelementptr [2 x i8], [2 x i8]* %t349, i32 0, i32 1
  store i8 0, i8* %t351
  %t352 = getelementptr [2 x i8], [2 x i8]* %t349, i32 0, i32 0
  %t353 = call i8* @sailfin_runtime_string_concat(i8* %t348, i8* %t352)
  %t354 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t338, i8* %t353)
  store { i8**, i64 }* %t354, { i8**, i64 }** %l1
  %t355 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge32
merge32:
  %t356 = phi i1 [ %t336, %then30 ], [ %t326, %else31 ]
  %t357 = phi double [ %t337, %then30 ], [ %t329, %else31 ]
  %t358 = phi { i8**, i64 }* [ %t319, %then30 ], [ %t355, %else31 ]
  store i1 %t356, i1* %l8
  store double %t357, double* %l11
  store { i8**, i64 }* %t358, { i8**, i64 }** %l1
  %t359 = load i1, i1* %l8
  %t360 = load double, double* %l11
  %t361 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge29
else28:
  %t362 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s363 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t364 = call i8* @sailfin_runtime_string_concat(i8* %s363, i8* %struct_name)
  %s365 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h506269955, i32 0, i32 0
  %t366 = call i8* @sailfin_runtime_string_concat(i8* %t364, i8* %s365)
  %t367 = load i8*, i8** %l4
  %t368 = call i8* @sailfin_runtime_string_concat(i8* %t366, i8* %t367)
  %s369 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h496289716, i32 0, i32 0
  %t370 = call i8* @sailfin_runtime_string_concat(i8* %t368, i8* %s369)
  %t371 = load i8*, i8** %l13
  %t372 = call i8* @sailfin_runtime_string_concat(i8* %t370, i8* %t371)
  %t373 = alloca [2 x i8], align 1
  %t374 = getelementptr [2 x i8], [2 x i8]* %t373, i32 0, i32 0
  store i8 96, i8* %t374
  %t375 = getelementptr [2 x i8], [2 x i8]* %t373, i32 0, i32 1
  store i8 0, i8* %t375
  %t376 = getelementptr [2 x i8], [2 x i8]* %t373, i32 0, i32 0
  %t377 = call i8* @sailfin_runtime_string_concat(i8* %t372, i8* %t376)
  %t378 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t362, i8* %t377)
  store { i8**, i64 }* %t378, { i8**, i64 }** %l1
  %t379 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge29
merge29:
  %t380 = phi i1 [ %t359, %merge32 ], [ %t304, %else28 ]
  %t381 = phi double [ %t360, %merge32 ], [ %t307, %else28 ]
  %t382 = phi { i8**, i64 }* [ %t361, %merge32 ], [ %t379, %else28 ]
  store i1 %t380, i1* %l8
  store double %t381, double* %l11
  store { i8**, i64 }* %t382, { i8**, i64 }** %l1
  %t383 = load i1, i1* %l8
  %t384 = load double, double* %l11
  %t385 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t386 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge23
merge23:
  %t387 = phi i1 [ %t290, %merge26 ], [ %t234, %merge29 ]
  %t388 = phi double [ %t291, %merge26 ], [ %t237, %merge29 ]
  %t389 = phi { i8**, i64 }* [ %t292, %merge26 ], [ %t385, %merge29 ]
  %t390 = phi i1 [ %t235, %merge26 ], [ %t383, %merge29 ]
  %t391 = phi double [ %t238, %merge26 ], [ %t384, %merge29 ]
  store i1 %t387, i1* %l7
  store double %t388, double* %l10
  store { i8**, i64 }* %t389, { i8**, i64 }** %l1
  store i1 %t390, i1* %l8
  store double %t391, double* %l11
  %t392 = load i1, i1* %l7
  %t393 = load double, double* %l10
  %t394 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t395 = load i1, i1* %l8
  %t396 = load double, double* %l11
  %t397 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t398 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge17
merge17:
  %t399 = phi i1 [ %t221, %merge20 ], [ %t164, %merge23 ]
  %t400 = phi double [ %t222, %merge20 ], [ %t167, %merge23 ]
  %t401 = phi { i8**, i64 }* [ %t223, %merge20 ], [ %t394, %merge23 ]
  %t402 = phi i1 [ %t165, %merge20 ], [ %t392, %merge23 ]
  %t403 = phi double [ %t168, %merge20 ], [ %t393, %merge23 ]
  %t404 = phi i1 [ %t166, %merge20 ], [ %t395, %merge23 ]
  %t405 = phi double [ %t169, %merge20 ], [ %t396, %merge23 ]
  store i1 %t399, i1* %l6
  store double %t400, double* %l9
  store { i8**, i64 }* %t401, { i8**, i64 }** %l1
  store i1 %t402, i1* %l7
  store double %t403, double* %l10
  store i1 %t404, i1* %l8
  store double %t405, double* %l11
  %t406 = load i1, i1* %l6
  %t407 = load double, double* %l9
  %t408 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t409 = load i1, i1* %l7
  %t410 = load double, double* %l10
  %t411 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t412 = load i1, i1* %l8
  %t413 = load double, double* %l11
  %t414 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t415 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge14
merge14:
  %t416 = phi i8* [ %t154, %then12 ], [ %t141, %merge17 ]
  %t417 = phi i1 [ %t142, %then12 ], [ %t406, %merge17 ]
  %t418 = phi double [ %t145, %then12 ], [ %t407, %merge17 ]
  %t419 = phi { i8**, i64 }* [ %t137, %then12 ], [ %t408, %merge17 ]
  %t420 = phi i1 [ %t143, %then12 ], [ %t409, %merge17 ]
  %t421 = phi double [ %t146, %then12 ], [ %t410, %merge17 ]
  %t422 = phi i1 [ %t144, %then12 ], [ %t412, %merge17 ]
  %t423 = phi double [ %t147, %then12 ], [ %t413, %merge17 ]
  store i8* %t416, i8** %l5
  store i1 %t417, i1* %l6
  store double %t418, double* %l9
  store { i8**, i64 }* %t419, { i8**, i64 }** %l1
  store i1 %t420, i1* %l7
  store double %t421, double* %l10
  store i1 %t422, i1* %l8
  store double %t423, double* %l11
  %t424 = load double, double* %l12
  %t425 = sitofp i64 1 to double
  %t426 = fadd double %t424, %t425
  store double %t426, double* %l12
  br label %loop.latch8
loop.latch8:
  %t427 = load i8*, i8** %l5
  %t428 = load i1, i1* %l6
  %t429 = load double, double* %l9
  %t430 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t431 = load i1, i1* %l7
  %t432 = load double, double* %l10
  %t433 = load i1, i1* %l8
  %t434 = load double, double* %l11
  %t435 = load double, double* %l12
  br label %loop.header6
afterloop9:
  %t445 = load i8*, i8** %l5
  %t446 = load i1, i1* %l6
  %t447 = load double, double* %l9
  %t448 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t449 = load i1, i1* %l7
  %t450 = load double, double* %l10
  %t451 = load i1, i1* %l8
  %t452 = load double, double* %l11
  %t453 = load double, double* %l12
  %t454 = load i8*, i8** %l5
  %t455 = call i64 @sailfin_runtime_string_length(i8* %t454)
  %t456 = icmp eq i64 %t455, 0
  %t457 = load i8*, i8** %l0
  %t458 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t459 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t460 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t461 = load i8*, i8** %l4
  %t462 = load i8*, i8** %l5
  %t463 = load i1, i1* %l6
  %t464 = load i1, i1* %l7
  %t465 = load i1, i1* %l8
  %t466 = load double, double* %l9
  %t467 = load double, double* %l10
  %t468 = load double, double* %l11
  %t469 = load double, double* %l12
  br i1 %t456, label %then33, label %merge34
then33:
  %t470 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s471 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t472 = call i8* @sailfin_runtime_string_concat(i8* %s471, i8* %struct_name)
  %s473 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h506269955, i32 0, i32 0
  %t474 = call i8* @sailfin_runtime_string_concat(i8* %t472, i8* %s473)
  %t475 = load i8*, i8** %l4
  %t476 = call i8* @sailfin_runtime_string_concat(i8* %t474, i8* %t475)
  %s477 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h1568429285, i32 0, i32 0
  %t478 = call i8* @sailfin_runtime_string_concat(i8* %t476, i8* %s477)
  %t479 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t470, i8* %t478)
  store { i8**, i64 }* %t479, { i8**, i64 }** %l1
  %t480 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge34
merge34:
  %t481 = phi { i8**, i64 }* [ %t480, %then33 ], [ %t458, %afterloop9 ]
  store { i8**, i64 }* %t481, { i8**, i64 }** %l1
  %t482 = load i1, i1* %l6
  %t483 = xor i1 %t482, 1
  %t484 = load i8*, i8** %l0
  %t485 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t486 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t487 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t488 = load i8*, i8** %l4
  %t489 = load i8*, i8** %l5
  %t490 = load i1, i1* %l6
  %t491 = load i1, i1* %l7
  %t492 = load i1, i1* %l8
  %t493 = load double, double* %l9
  %t494 = load double, double* %l10
  %t495 = load double, double* %l11
  %t496 = load double, double* %l12
  br i1 %t483, label %then35, label %merge36
then35:
  %t497 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s498 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t499 = call i8* @sailfin_runtime_string_concat(i8* %s498, i8* %struct_name)
  %s500 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h506269955, i32 0, i32 0
  %t501 = call i8* @sailfin_runtime_string_concat(i8* %t499, i8* %s500)
  %t502 = load i8*, i8** %l4
  %t503 = call i8* @sailfin_runtime_string_concat(i8* %t501, i8* %t502)
  %s504 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h625556084, i32 0, i32 0
  %t505 = call i8* @sailfin_runtime_string_concat(i8* %t503, i8* %s504)
  %t506 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t497, i8* %t505)
  store { i8**, i64 }* %t506, { i8**, i64 }** %l1
  %t507 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge36
merge36:
  %t508 = phi { i8**, i64 }* [ %t507, %then35 ], [ %t485, %merge34 ]
  store { i8**, i64 }* %t508, { i8**, i64 }** %l1
  %t509 = load i1, i1* %l7
  %t510 = xor i1 %t509, 1
  %t511 = load i8*, i8** %l0
  %t512 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t513 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t514 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t515 = load i8*, i8** %l4
  %t516 = load i8*, i8** %l5
  %t517 = load i1, i1* %l6
  %t518 = load i1, i1* %l7
  %t519 = load i1, i1* %l8
  %t520 = load double, double* %l9
  %t521 = load double, double* %l10
  %t522 = load double, double* %l11
  %t523 = load double, double* %l12
  br i1 %t510, label %then37, label %merge38
then37:
  %t524 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s525 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t526 = call i8* @sailfin_runtime_string_concat(i8* %s525, i8* %struct_name)
  %s527 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h506269955, i32 0, i32 0
  %t528 = call i8* @sailfin_runtime_string_concat(i8* %t526, i8* %s527)
  %t529 = load i8*, i8** %l4
  %t530 = call i8* @sailfin_runtime_string_concat(i8* %t528, i8* %t529)
  %s531 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h608364678, i32 0, i32 0
  %t532 = call i8* @sailfin_runtime_string_concat(i8* %t530, i8* %s531)
  %t533 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t524, i8* %t532)
  store { i8**, i64 }* %t533, { i8**, i64 }** %l1
  %t534 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge38
merge38:
  %t535 = phi { i8**, i64 }* [ %t534, %then37 ], [ %t512, %merge36 ]
  store { i8**, i64 }* %t535, { i8**, i64 }** %l1
  %t536 = load i1, i1* %l8
  %t537 = xor i1 %t536, 1
  %t538 = load i8*, i8** %l0
  %t539 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t540 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t541 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t542 = load i8*, i8** %l4
  %t543 = load i8*, i8** %l5
  %t544 = load i1, i1* %l6
  %t545 = load i1, i1* %l7
  %t546 = load i1, i1* %l8
  %t547 = load double, double* %l9
  %t548 = load double, double* %l10
  %t549 = load double, double* %l11
  %t550 = load double, double* %l12
  br i1 %t537, label %then39, label %merge40
then39:
  %t551 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s552 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t553 = call i8* @sailfin_runtime_string_concat(i8* %s552, i8* %struct_name)
  %s554 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h506269955, i32 0, i32 0
  %t555 = call i8* @sailfin_runtime_string_concat(i8* %t553, i8* %s554)
  %t556 = load i8*, i8** %l4
  %t557 = call i8* @sailfin_runtime_string_concat(i8* %t555, i8* %t556)
  %s558 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.len21.h2112628887, i32 0, i32 0
  %t559 = call i8* @sailfin_runtime_string_concat(i8* %t557, i8* %s558)
  %t560 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t551, i8* %t559)
  store { i8**, i64 }* %t560, { i8**, i64 }** %l1
  %t561 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge40
merge40:
  %t562 = phi { i8**, i64 }* [ %t561, %then39 ], [ %t539, %merge38 ]
  store { i8**, i64 }* %t562, { i8**, i64 }** %l1
  %t564 = load i8*, i8** %l5
  %t565 = call i64 @sailfin_runtime_string_length(i8* %t564)
  %t566 = icmp sgt i64 %t565, 0
  br label %logical_and_entry_563

logical_and_entry_563:
  br i1 %t566, label %logical_and_right_563, label %logical_and_merge_563

logical_and_right_563:
  %t568 = load i1, i1* %l6
  br label %logical_and_entry_567

logical_and_entry_567:
  br i1 %t568, label %logical_and_right_567, label %logical_and_merge_567

logical_and_right_567:
  %t570 = load i1, i1* %l7
  br label %logical_and_entry_569

logical_and_entry_569:
  br i1 %t570, label %logical_and_right_569, label %logical_and_merge_569

logical_and_right_569:
  %t572 = load i1, i1* %l8
  br label %logical_and_entry_571

logical_and_entry_571:
  br i1 %t572, label %logical_and_right_571, label %logical_and_merge_571

logical_and_right_571:
  %t573 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t574 = load { i8**, i64 }, { i8**, i64 }* %t573
  %t575 = extractvalue { i8**, i64 } %t574, 1
  %t576 = icmp eq i64 %t575, 0
  br label %logical_and_right_end_571

logical_and_right_end_571:
  br label %logical_and_merge_571

logical_and_merge_571:
  %t577 = phi i1 [ false, %logical_and_entry_571 ], [ %t576, %logical_and_right_end_571 ]
  br label %logical_and_right_end_569

logical_and_right_end_569:
  br label %logical_and_merge_569

logical_and_merge_569:
  %t578 = phi i1 [ false, %logical_and_entry_569 ], [ %t577, %logical_and_right_end_569 ]
  br label %logical_and_right_end_567

logical_and_right_end_567:
  br label %logical_and_merge_567

logical_and_merge_567:
  %t579 = phi i1 [ false, %logical_and_entry_567 ], [ %t578, %logical_and_right_end_567 ]
  br label %logical_and_right_end_563

logical_and_right_end_563:
  br label %logical_and_merge_563

logical_and_merge_563:
  %t580 = phi i1 [ false, %logical_and_entry_563 ], [ %t579, %logical_and_right_end_563 ]
  store i1 %t580, i1* %l20
  %t581 = load i8*, i8** %l4
  %t582 = insertvalue %NativeStructLayoutField undef, i8* %t581, 0
  %t583 = load i8*, i8** %l5
  %t584 = insertvalue %NativeStructLayoutField %t582, i8* %t583, 1
  %t585 = load double, double* %l9
  %t586 = insertvalue %NativeStructLayoutField %t584, double %t585, 2
  %t587 = load double, double* %l10
  %t588 = insertvalue %NativeStructLayoutField %t586, double %t587, 3
  %t589 = load double, double* %l11
  %t590 = insertvalue %NativeStructLayoutField %t588, double %t589, 4
  store %NativeStructLayoutField %t590, %NativeStructLayoutField* %l21
  %t591 = load i1, i1* %l20
  %t592 = insertvalue %StructLayoutFieldParse undef, i1 %t591, 0
  %t593 = load %NativeStructLayoutField, %NativeStructLayoutField* %l21
  %t594 = insertvalue %StructLayoutFieldParse %t592, %NativeStructLayoutField %t593, 1
  %t595 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t596 = insertvalue %StructLayoutFieldParse %t594, { i8**, i64 }* %t595, 2
  ret %StructLayoutFieldParse %t596
}

define %EnumLayoutHeaderParse @parse_enum_layout_header(i8* %text) {
block.entry:
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
  %t2 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t3 = ptrtoint [0 x i8*]* %t2 to i64
  %t4 = icmp eq i64 %t3, 0
  %t5 = select i1 %t4, i64 1, i64 %t3
  %t6 = call i8* @malloc(i64 %t5)
  %t7 = bitcast i8* %t6 to i8**
  %t8 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t9 = ptrtoint { i8**, i64 }* %t8 to i64
  %t10 = call i8* @malloc(i64 %t9)
  %t11 = bitcast i8* %t10 to { i8**, i64 }*
  %t12 = getelementptr { i8**, i64 }, { i8**, i64 }* %t11, i32 0, i32 0
  store i8** %t7, i8*** %t12
  %t13 = getelementptr { i8**, i64 }, { i8**, i64 }* %t11, i32 0, i32 1
  store i64 0, i64* %t13
  store { i8**, i64 }* %t11, { i8**, i64 }** %l1
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t15 = load { i8**, i64 }, { i8**, i64 }* %t14
  %t16 = extractvalue { i8**, i64 } %t15, 1
  %t17 = icmp eq i64 %t16, 0
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t17, label %then0, label %merge1
then0:
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s21 = getelementptr inbounds [35 x i8], [35 x i8]* @.str.len34.h183092327, i32 0, i32 0
  %t22 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t20, i8* %s21)
  store { i8**, i64 }* %t22, { i8**, i64 }** %l1
  %t23 = insertvalue %EnumLayoutHeaderParse undef, i1 0, 0
  %s24 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t25 = insertvalue %EnumLayoutHeaderParse %t23, i8* %s24, 1
  %t26 = sitofp i64 0 to double
  %t27 = insertvalue %EnumLayoutHeaderParse %t25, double %t26, 2
  %t28 = sitofp i64 0 to double
  %t29 = insertvalue %EnumLayoutHeaderParse %t27, double %t28, 3
  %s30 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t31 = insertvalue %EnumLayoutHeaderParse %t29, i8* %s30, 4
  %t32 = sitofp i64 0 to double
  %t33 = insertvalue %EnumLayoutHeaderParse %t31, double %t32, 5
  %t34 = sitofp i64 0 to double
  %t35 = insertvalue %EnumLayoutHeaderParse %t33, double %t34, 6
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t37 = insertvalue %EnumLayoutHeaderParse %t35, { i8**, i64 }* %t36, 7
  ret %EnumLayoutHeaderParse %t37
merge1:
  store i1 0, i1* %l2
  store i1 0, i1* %l3
  store i1 0, i1* %l4
  %s38 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s38, i8** %l5
  %s39 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s39, i8** %l6
  store i1 0, i1* %l7
  store i1 0, i1* %l8
  %t40 = sitofp i64 0 to double
  store double %t40, double* %l9
  %t41 = sitofp i64 0 to double
  store double %t41, double* %l10
  %t42 = sitofp i64 0 to double
  store double %t42, double* %l11
  %t43 = sitofp i64 0 to double
  store double %t43, double* %l12
  %t44 = sitofp i64 0 to double
  store double %t44, double* %l13
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t47 = load i1, i1* %l2
  %t48 = load i1, i1* %l3
  %t49 = load i1, i1* %l4
  %t50 = load i8*, i8** %l5
  %t51 = load i8*, i8** %l6
  %t52 = load i1, i1* %l7
  %t53 = load i1, i1* %l8
  %t54 = load double, double* %l9
  %t55 = load double, double* %l10
  %t56 = load double, double* %l11
  %t57 = load double, double* %l12
  %t58 = load double, double* %l13
  br label %loop.header2
loop.header2:
  %t506 = phi i8* [ %t50, %merge1 ], [ %t493, %loop.latch4 ]
  %t507 = phi i1 [ %t47, %merge1 ], [ %t494, %loop.latch4 ]
  %t508 = phi i1 [ %t48, %merge1 ], [ %t495, %loop.latch4 ]
  %t509 = phi double [ %t54, %merge1 ], [ %t496, %loop.latch4 ]
  %t510 = phi { i8**, i64 }* [ %t46, %merge1 ], [ %t497, %loop.latch4 ]
  %t511 = phi i1 [ %t49, %merge1 ], [ %t498, %loop.latch4 ]
  %t512 = phi double [ %t55, %merge1 ], [ %t499, %loop.latch4 ]
  %t513 = phi i8* [ %t51, %merge1 ], [ %t500, %loop.latch4 ]
  %t514 = phi i1 [ %t52, %merge1 ], [ %t501, %loop.latch4 ]
  %t515 = phi double [ %t56, %merge1 ], [ %t502, %loop.latch4 ]
  %t516 = phi i1 [ %t53, %merge1 ], [ %t503, %loop.latch4 ]
  %t517 = phi double [ %t57, %merge1 ], [ %t504, %loop.latch4 ]
  %t518 = phi double [ %t58, %merge1 ], [ %t505, %loop.latch4 ]
  store i8* %t506, i8** %l5
  store i1 %t507, i1* %l2
  store i1 %t508, i1* %l3
  store double %t509, double* %l9
  store { i8**, i64 }* %t510, { i8**, i64 }** %l1
  store i1 %t511, i1* %l4
  store double %t512, double* %l10
  store i8* %t513, i8** %l6
  store i1 %t514, i1* %l7
  store double %t515, double* %l11
  store i1 %t516, i1* %l8
  store double %t517, double* %l12
  store double %t518, double* %l13
  br label %loop.body3
loop.body3:
  %t59 = load double, double* %l13
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t61 = load { i8**, i64 }, { i8**, i64 }* %t60
  %t62 = extractvalue { i8**, i64 } %t61, 1
  %t63 = sitofp i64 %t62 to double
  %t64 = fcmp oge double %t59, %t63
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t67 = load i1, i1* %l2
  %t68 = load i1, i1* %l3
  %t69 = load i1, i1* %l4
  %t70 = load i8*, i8** %l5
  %t71 = load i8*, i8** %l6
  %t72 = load i1, i1* %l7
  %t73 = load i1, i1* %l8
  %t74 = load double, double* %l9
  %t75 = load double, double* %l10
  %t76 = load double, double* %l11
  %t77 = load double, double* %l12
  %t78 = load double, double* %l13
  br i1 %t64, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t80 = load double, double* %l13
  %t81 = fptosi double %t80 to i64
  %t82 = load { i8**, i64 }, { i8**, i64 }* %t79
  %t83 = extractvalue { i8**, i64 } %t82, 0
  %t84 = extractvalue { i8**, i64 } %t82, 1
  %t85 = icmp uge i64 %t81, %t84
  ; bounds check: %t85 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t81, i64 %t84)
  %t86 = getelementptr i8*, i8** %t83, i64 %t81
  %t87 = load i8*, i8** %t86
  store i8* %t87, i8** %l14
  %t88 = load i8*, i8** %l14
  %s89 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h261048910, i32 0, i32 0
  %t90 = call i1 @starts_with(i8* %t88, i8* %s89)
  %t91 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t93 = load i1, i1* %l2
  %t94 = load i1, i1* %l3
  %t95 = load i1, i1* %l4
  %t96 = load i8*, i8** %l5
  %t97 = load i8*, i8** %l6
  %t98 = load i1, i1* %l7
  %t99 = load i1, i1* %l8
  %t100 = load double, double* %l9
  %t101 = load double, double* %l10
  %t102 = load double, double* %l11
  %t103 = load double, double* %l12
  %t104 = load double, double* %l13
  %t105 = load i8*, i8** %l14
  br i1 %t90, label %then8, label %else9
then8:
  %t106 = load i8*, i8** %l14
  %t107 = load i8*, i8** %l14
  %t108 = call i64 @sailfin_runtime_string_length(i8* %t107)
  %t109 = call i8* @sailfin_runtime_substring(i8* %t106, i64 5, i64 %t108)
  store i8* %t109, i8** %l5
  store i1 1, i1* %l2
  %t110 = load i8*, i8** %l5
  %t111 = load i1, i1* %l2
  br label %merge10
else9:
  %t112 = load i8*, i8** %l14
  %s113 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h466680424, i32 0, i32 0
  %t114 = call i1 @starts_with(i8* %t112, i8* %s113)
  %t115 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t116 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t117 = load i1, i1* %l2
  %t118 = load i1, i1* %l3
  %t119 = load i1, i1* %l4
  %t120 = load i8*, i8** %l5
  %t121 = load i8*, i8** %l6
  %t122 = load i1, i1* %l7
  %t123 = load i1, i1* %l8
  %t124 = load double, double* %l9
  %t125 = load double, double* %l10
  %t126 = load double, double* %l11
  %t127 = load double, double* %l12
  %t128 = load double, double* %l13
  %t129 = load i8*, i8** %l14
  br i1 %t114, label %then11, label %else12
then11:
  %t130 = load i8*, i8** %l14
  %t131 = load i8*, i8** %l14
  %t132 = call i64 @sailfin_runtime_string_length(i8* %t131)
  %t133 = call i8* @sailfin_runtime_substring(i8* %t130, i64 5, i64 %t132)
  store i8* %t133, i8** %l15
  %t134 = load i8*, i8** %l15
  %t135 = call %NumberParseResult @parse_decimal_number(i8* %t134)
  store %NumberParseResult %t135, %NumberParseResult* %l16
  %t136 = load %NumberParseResult, %NumberParseResult* %l16
  %t137 = extractvalue %NumberParseResult %t136, 0
  %t138 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t139 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t140 = load i1, i1* %l2
  %t141 = load i1, i1* %l3
  %t142 = load i1, i1* %l4
  %t143 = load i8*, i8** %l5
  %t144 = load i8*, i8** %l6
  %t145 = load i1, i1* %l7
  %t146 = load i1, i1* %l8
  %t147 = load double, double* %l9
  %t148 = load double, double* %l10
  %t149 = load double, double* %l11
  %t150 = load double, double* %l12
  %t151 = load double, double* %l13
  %t152 = load i8*, i8** %l14
  %t153 = load i8*, i8** %l15
  %t154 = load %NumberParseResult, %NumberParseResult* %l16
  br i1 %t137, label %then14, label %else15
then14:
  store i1 1, i1* %l3
  %t155 = load %NumberParseResult, %NumberParseResult* %l16
  %t156 = extractvalue %NumberParseResult %t155, 1
  store double %t156, double* %l9
  %t157 = load i1, i1* %l3
  %t158 = load double, double* %l9
  br label %merge16
else15:
  %t159 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s160 = getelementptr inbounds [38 x i8], [38 x i8]* @.str.len37.h1581468287, i32 0, i32 0
  %t161 = load i8*, i8** %l15
  %t162 = call i8* @sailfin_runtime_string_concat(i8* %s160, i8* %t161)
  %t163 = alloca [2 x i8], align 1
  %t164 = getelementptr [2 x i8], [2 x i8]* %t163, i32 0, i32 0
  store i8 96, i8* %t164
  %t165 = getelementptr [2 x i8], [2 x i8]* %t163, i32 0, i32 1
  store i8 0, i8* %t165
  %t166 = getelementptr [2 x i8], [2 x i8]* %t163, i32 0, i32 0
  %t167 = call i8* @sailfin_runtime_string_concat(i8* %t162, i8* %t166)
  %t168 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t159, i8* %t167)
  store { i8**, i64 }* %t168, { i8**, i64 }** %l1
  %t169 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge16
merge16:
  %t170 = phi i1 [ %t157, %then14 ], [ %t141, %else15 ]
  %t171 = phi double [ %t158, %then14 ], [ %t147, %else15 ]
  %t172 = phi { i8**, i64 }* [ %t139, %then14 ], [ %t169, %else15 ]
  store i1 %t170, i1* %l3
  store double %t171, double* %l9
  store { i8**, i64 }* %t172, { i8**, i64 }** %l1
  %t173 = load i1, i1* %l3
  %t174 = load double, double* %l9
  %t175 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge13
else12:
  %t176 = load i8*, i8** %l14
  %s177 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h841337749, i32 0, i32 0
  %t178 = call i1 @starts_with(i8* %t176, i8* %s177)
  %t179 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t180 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t181 = load i1, i1* %l2
  %t182 = load i1, i1* %l3
  %t183 = load i1, i1* %l4
  %t184 = load i8*, i8** %l5
  %t185 = load i8*, i8** %l6
  %t186 = load i1, i1* %l7
  %t187 = load i1, i1* %l8
  %t188 = load double, double* %l9
  %t189 = load double, double* %l10
  %t190 = load double, double* %l11
  %t191 = load double, double* %l12
  %t192 = load double, double* %l13
  %t193 = load i8*, i8** %l14
  br i1 %t178, label %then17, label %else18
then17:
  %t194 = load i8*, i8** %l14
  %t195 = load i8*, i8** %l14
  %t196 = call i64 @sailfin_runtime_string_length(i8* %t195)
  %t197 = call i8* @sailfin_runtime_substring(i8* %t194, i64 6, i64 %t196)
  store i8* %t197, i8** %l17
  %t198 = load i8*, i8** %l17
  %t199 = call %NumberParseResult @parse_decimal_number(i8* %t198)
  store %NumberParseResult %t199, %NumberParseResult* %l18
  %t200 = load %NumberParseResult, %NumberParseResult* %l18
  %t201 = extractvalue %NumberParseResult %t200, 0
  %t202 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t203 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t204 = load i1, i1* %l2
  %t205 = load i1, i1* %l3
  %t206 = load i1, i1* %l4
  %t207 = load i8*, i8** %l5
  %t208 = load i8*, i8** %l6
  %t209 = load i1, i1* %l7
  %t210 = load i1, i1* %l8
  %t211 = load double, double* %l9
  %t212 = load double, double* %l10
  %t213 = load double, double* %l11
  %t214 = load double, double* %l12
  %t215 = load double, double* %l13
  %t216 = load i8*, i8** %l14
  %t217 = load i8*, i8** %l17
  %t218 = load %NumberParseResult, %NumberParseResult* %l18
  br i1 %t201, label %then20, label %else21
then20:
  store i1 1, i1* %l4
  %t219 = load %NumberParseResult, %NumberParseResult* %l18
  %t220 = extractvalue %NumberParseResult %t219, 1
  store double %t220, double* %l10
  %t221 = load i1, i1* %l4
  %t222 = load double, double* %l10
  br label %merge22
else21:
  %t223 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s224 = getelementptr inbounds [39 x i8], [39 x i8]* @.str.len38.h1235260132, i32 0, i32 0
  %t225 = load i8*, i8** %l17
  %t226 = call i8* @sailfin_runtime_string_concat(i8* %s224, i8* %t225)
  %t227 = alloca [2 x i8], align 1
  %t228 = getelementptr [2 x i8], [2 x i8]* %t227, i32 0, i32 0
  store i8 96, i8* %t228
  %t229 = getelementptr [2 x i8], [2 x i8]* %t227, i32 0, i32 1
  store i8 0, i8* %t229
  %t230 = getelementptr [2 x i8], [2 x i8]* %t227, i32 0, i32 0
  %t231 = call i8* @sailfin_runtime_string_concat(i8* %t226, i8* %t230)
  %t232 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t223, i8* %t231)
  store { i8**, i64 }* %t232, { i8**, i64 }** %l1
  %t233 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge22
merge22:
  %t234 = phi i1 [ %t221, %then20 ], [ %t206, %else21 ]
  %t235 = phi double [ %t222, %then20 ], [ %t212, %else21 ]
  %t236 = phi { i8**, i64 }* [ %t203, %then20 ], [ %t233, %else21 ]
  store i1 %t234, i1* %l4
  store double %t235, double* %l10
  store { i8**, i64 }* %t236, { i8**, i64 }** %l1
  %t237 = load i1, i1* %l4
  %t238 = load double, double* %l10
  %t239 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge19
else18:
  %t240 = load i8*, i8** %l14
  %s241 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1228988541, i32 0, i32 0
  %t242 = call i1 @starts_with(i8* %t240, i8* %s241)
  %t243 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t244 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t245 = load i1, i1* %l2
  %t246 = load i1, i1* %l3
  %t247 = load i1, i1* %l4
  %t248 = load i8*, i8** %l5
  %t249 = load i8*, i8** %l6
  %t250 = load i1, i1* %l7
  %t251 = load i1, i1* %l8
  %t252 = load double, double* %l9
  %t253 = load double, double* %l10
  %t254 = load double, double* %l11
  %t255 = load double, double* %l12
  %t256 = load double, double* %l13
  %t257 = load i8*, i8** %l14
  br i1 %t242, label %then23, label %else24
then23:
  %t258 = load i8*, i8** %l14
  %t259 = load i8*, i8** %l14
  %t260 = call i64 @sailfin_runtime_string_length(i8* %t259)
  %t261 = call i8* @sailfin_runtime_substring(i8* %t258, i64 9, i64 %t260)
  store i8* %t261, i8** %l6
  %t262 = load i8*, i8** %l6
  br label %merge25
else24:
  %t263 = load i8*, i8** %l14
  %s264 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1171237782, i32 0, i32 0
  %t265 = call i1 @starts_with(i8* %t263, i8* %s264)
  %t266 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t267 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t268 = load i1, i1* %l2
  %t269 = load i1, i1* %l3
  %t270 = load i1, i1* %l4
  %t271 = load i8*, i8** %l5
  %t272 = load i8*, i8** %l6
  %t273 = load i1, i1* %l7
  %t274 = load i1, i1* %l8
  %t275 = load double, double* %l9
  %t276 = load double, double* %l10
  %t277 = load double, double* %l11
  %t278 = load double, double* %l12
  %t279 = load double, double* %l13
  %t280 = load i8*, i8** %l14
  br i1 %t265, label %then26, label %else27
then26:
  %t281 = load i8*, i8** %l14
  %t282 = load i8*, i8** %l14
  %t283 = call i64 @sailfin_runtime_string_length(i8* %t282)
  %t284 = call i8* @sailfin_runtime_substring(i8* %t281, i64 9, i64 %t283)
  store i8* %t284, i8** %l19
  %t285 = load i8*, i8** %l19
  %t286 = call %NumberParseResult @parse_decimal_number(i8* %t285)
  store %NumberParseResult %t286, %NumberParseResult* %l20
  %t287 = load %NumberParseResult, %NumberParseResult* %l20
  %t288 = extractvalue %NumberParseResult %t287, 0
  %t289 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t290 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t291 = load i1, i1* %l2
  %t292 = load i1, i1* %l3
  %t293 = load i1, i1* %l4
  %t294 = load i8*, i8** %l5
  %t295 = load i8*, i8** %l6
  %t296 = load i1, i1* %l7
  %t297 = load i1, i1* %l8
  %t298 = load double, double* %l9
  %t299 = load double, double* %l10
  %t300 = load double, double* %l11
  %t301 = load double, double* %l12
  %t302 = load double, double* %l13
  %t303 = load i8*, i8** %l14
  %t304 = load i8*, i8** %l19
  %t305 = load %NumberParseResult, %NumberParseResult* %l20
  br i1 %t288, label %then29, label %else30
then29:
  store i1 1, i1* %l7
  %t306 = load %NumberParseResult, %NumberParseResult* %l20
  %t307 = extractvalue %NumberParseResult %t306, 1
  store double %t307, double* %l11
  %t308 = load i1, i1* %l7
  %t309 = load double, double* %l11
  br label %merge31
else30:
  %t310 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s311 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.len41.h1384306956, i32 0, i32 0
  %t312 = load i8*, i8** %l19
  %t313 = call i8* @sailfin_runtime_string_concat(i8* %s311, i8* %t312)
  %t314 = alloca [2 x i8], align 1
  %t315 = getelementptr [2 x i8], [2 x i8]* %t314, i32 0, i32 0
  store i8 96, i8* %t315
  %t316 = getelementptr [2 x i8], [2 x i8]* %t314, i32 0, i32 1
  store i8 0, i8* %t316
  %t317 = getelementptr [2 x i8], [2 x i8]* %t314, i32 0, i32 0
  %t318 = call i8* @sailfin_runtime_string_concat(i8* %t313, i8* %t317)
  %t319 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t310, i8* %t318)
  store { i8**, i64 }* %t319, { i8**, i64 }** %l1
  %t320 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge31
merge31:
  %t321 = phi i1 [ %t308, %then29 ], [ %t296, %else30 ]
  %t322 = phi double [ %t309, %then29 ], [ %t300, %else30 ]
  %t323 = phi { i8**, i64 }* [ %t290, %then29 ], [ %t320, %else30 ]
  store i1 %t321, i1* %l7
  store double %t322, double* %l11
  store { i8**, i64 }* %t323, { i8**, i64 }** %l1
  %t324 = load i1, i1* %l7
  %t325 = load double, double* %l11
  %t326 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge28
else27:
  %t327 = load i8*, i8** %l14
  %s328 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h469410318, i32 0, i32 0
  %t329 = call i1 @starts_with(i8* %t327, i8* %s328)
  %t330 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t331 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t332 = load i1, i1* %l2
  %t333 = load i1, i1* %l3
  %t334 = load i1, i1* %l4
  %t335 = load i8*, i8** %l5
  %t336 = load i8*, i8** %l6
  %t337 = load i1, i1* %l7
  %t338 = load i1, i1* %l8
  %t339 = load double, double* %l9
  %t340 = load double, double* %l10
  %t341 = load double, double* %l11
  %t342 = load double, double* %l12
  %t343 = load double, double* %l13
  %t344 = load i8*, i8** %l14
  br i1 %t329, label %then32, label %else33
then32:
  %t345 = load i8*, i8** %l14
  %t346 = load i8*, i8** %l14
  %t347 = call i64 @sailfin_runtime_string_length(i8* %t346)
  %t348 = call i8* @sailfin_runtime_substring(i8* %t345, i64 10, i64 %t347)
  store i8* %t348, i8** %l21
  %t349 = load i8*, i8** %l21
  %t350 = call %NumberParseResult @parse_decimal_number(i8* %t349)
  store %NumberParseResult %t350, %NumberParseResult* %l22
  %t351 = load %NumberParseResult, %NumberParseResult* %l22
  %t352 = extractvalue %NumberParseResult %t351, 0
  %t353 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t354 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t355 = load i1, i1* %l2
  %t356 = load i1, i1* %l3
  %t357 = load i1, i1* %l4
  %t358 = load i8*, i8** %l5
  %t359 = load i8*, i8** %l6
  %t360 = load i1, i1* %l7
  %t361 = load i1, i1* %l8
  %t362 = load double, double* %l9
  %t363 = load double, double* %l10
  %t364 = load double, double* %l11
  %t365 = load double, double* %l12
  %t366 = load double, double* %l13
  %t367 = load i8*, i8** %l14
  %t368 = load i8*, i8** %l21
  %t369 = load %NumberParseResult, %NumberParseResult* %l22
  br i1 %t352, label %then35, label %else36
then35:
  store i1 1, i1* %l8
  %t370 = load %NumberParseResult, %NumberParseResult* %l22
  %t371 = extractvalue %NumberParseResult %t370, 1
  store double %t371, double* %l12
  %t372 = load i1, i1* %l8
  %t373 = load double, double* %l12
  br label %merge37
else36:
  %t374 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s375 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.len42.h1171387022, i32 0, i32 0
  %t376 = load i8*, i8** %l21
  %t377 = call i8* @sailfin_runtime_string_concat(i8* %s375, i8* %t376)
  %t378 = alloca [2 x i8], align 1
  %t379 = getelementptr [2 x i8], [2 x i8]* %t378, i32 0, i32 0
  store i8 96, i8* %t379
  %t380 = getelementptr [2 x i8], [2 x i8]* %t378, i32 0, i32 1
  store i8 0, i8* %t380
  %t381 = getelementptr [2 x i8], [2 x i8]* %t378, i32 0, i32 0
  %t382 = call i8* @sailfin_runtime_string_concat(i8* %t377, i8* %t381)
  %t383 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t374, i8* %t382)
  store { i8**, i64 }* %t383, { i8**, i64 }** %l1
  %t384 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge37
merge37:
  %t385 = phi i1 [ %t372, %then35 ], [ %t361, %else36 ]
  %t386 = phi double [ %t373, %then35 ], [ %t365, %else36 ]
  %t387 = phi { i8**, i64 }* [ %t354, %then35 ], [ %t384, %else36 ]
  store i1 %t385, i1* %l8
  store double %t386, double* %l12
  store { i8**, i64 }* %t387, { i8**, i64 }** %l1
  %t388 = load i1, i1* %l8
  %t389 = load double, double* %l12
  %t390 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge34
else33:
  %t391 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s392 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.len39.h598838653, i32 0, i32 0
  %t393 = load i8*, i8** %l14
  %t394 = call i8* @sailfin_runtime_string_concat(i8* %s392, i8* %t393)
  %t395 = alloca [2 x i8], align 1
  %t396 = getelementptr [2 x i8], [2 x i8]* %t395, i32 0, i32 0
  store i8 96, i8* %t396
  %t397 = getelementptr [2 x i8], [2 x i8]* %t395, i32 0, i32 1
  store i8 0, i8* %t397
  %t398 = getelementptr [2 x i8], [2 x i8]* %t395, i32 0, i32 0
  %t399 = call i8* @sailfin_runtime_string_concat(i8* %t394, i8* %t398)
  %t400 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t391, i8* %t399)
  store { i8**, i64 }* %t400, { i8**, i64 }** %l1
  %t401 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge34
merge34:
  %t402 = phi i1 [ %t388, %merge37 ], [ %t338, %else33 ]
  %t403 = phi double [ %t389, %merge37 ], [ %t342, %else33 ]
  %t404 = phi { i8**, i64 }* [ %t390, %merge37 ], [ %t401, %else33 ]
  store i1 %t402, i1* %l8
  store double %t403, double* %l12
  store { i8**, i64 }* %t404, { i8**, i64 }** %l1
  %t405 = load i1, i1* %l8
  %t406 = load double, double* %l12
  %t407 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t408 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge28
merge28:
  %t409 = phi i1 [ %t324, %merge31 ], [ %t273, %merge34 ]
  %t410 = phi double [ %t325, %merge31 ], [ %t277, %merge34 ]
  %t411 = phi { i8**, i64 }* [ %t326, %merge31 ], [ %t407, %merge34 ]
  %t412 = phi i1 [ %t274, %merge31 ], [ %t405, %merge34 ]
  %t413 = phi double [ %t278, %merge31 ], [ %t406, %merge34 ]
  store i1 %t409, i1* %l7
  store double %t410, double* %l11
  store { i8**, i64 }* %t411, { i8**, i64 }** %l1
  store i1 %t412, i1* %l8
  store double %t413, double* %l12
  %t414 = load i1, i1* %l7
  %t415 = load double, double* %l11
  %t416 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t417 = load i1, i1* %l8
  %t418 = load double, double* %l12
  %t419 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t420 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge25
merge25:
  %t421 = phi i8* [ %t262, %then23 ], [ %t249, %merge28 ]
  %t422 = phi i1 [ %t250, %then23 ], [ %t414, %merge28 ]
  %t423 = phi double [ %t254, %then23 ], [ %t415, %merge28 ]
  %t424 = phi { i8**, i64 }* [ %t244, %then23 ], [ %t416, %merge28 ]
  %t425 = phi i1 [ %t251, %then23 ], [ %t417, %merge28 ]
  %t426 = phi double [ %t255, %then23 ], [ %t418, %merge28 ]
  store i8* %t421, i8** %l6
  store i1 %t422, i1* %l7
  store double %t423, double* %l11
  store { i8**, i64 }* %t424, { i8**, i64 }** %l1
  store i1 %t425, i1* %l8
  store double %t426, double* %l12
  %t427 = load i8*, i8** %l6
  %t428 = load i1, i1* %l7
  %t429 = load double, double* %l11
  %t430 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t431 = load i1, i1* %l8
  %t432 = load double, double* %l12
  %t433 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t434 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge19
merge19:
  %t435 = phi i1 [ %t237, %merge22 ], [ %t183, %merge25 ]
  %t436 = phi double [ %t238, %merge22 ], [ %t189, %merge25 ]
  %t437 = phi { i8**, i64 }* [ %t239, %merge22 ], [ %t430, %merge25 ]
  %t438 = phi i8* [ %t185, %merge22 ], [ %t427, %merge25 ]
  %t439 = phi i1 [ %t186, %merge22 ], [ %t428, %merge25 ]
  %t440 = phi double [ %t190, %merge22 ], [ %t429, %merge25 ]
  %t441 = phi i1 [ %t187, %merge22 ], [ %t431, %merge25 ]
  %t442 = phi double [ %t191, %merge22 ], [ %t432, %merge25 ]
  store i1 %t435, i1* %l4
  store double %t436, double* %l10
  store { i8**, i64 }* %t437, { i8**, i64 }** %l1
  store i8* %t438, i8** %l6
  store i1 %t439, i1* %l7
  store double %t440, double* %l11
  store i1 %t441, i1* %l8
  store double %t442, double* %l12
  %t443 = load i1, i1* %l4
  %t444 = load double, double* %l10
  %t445 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t446 = load i8*, i8** %l6
  %t447 = load i1, i1* %l7
  %t448 = load double, double* %l11
  %t449 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t450 = load i1, i1* %l8
  %t451 = load double, double* %l12
  %t452 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t453 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge13
merge13:
  %t454 = phi i1 [ %t173, %merge16 ], [ %t118, %merge19 ]
  %t455 = phi double [ %t174, %merge16 ], [ %t124, %merge19 ]
  %t456 = phi { i8**, i64 }* [ %t175, %merge16 ], [ %t445, %merge19 ]
  %t457 = phi i1 [ %t119, %merge16 ], [ %t443, %merge19 ]
  %t458 = phi double [ %t125, %merge16 ], [ %t444, %merge19 ]
  %t459 = phi i8* [ %t121, %merge16 ], [ %t446, %merge19 ]
  %t460 = phi i1 [ %t122, %merge16 ], [ %t447, %merge19 ]
  %t461 = phi double [ %t126, %merge16 ], [ %t448, %merge19 ]
  %t462 = phi i1 [ %t123, %merge16 ], [ %t450, %merge19 ]
  %t463 = phi double [ %t127, %merge16 ], [ %t451, %merge19 ]
  store i1 %t454, i1* %l3
  store double %t455, double* %l9
  store { i8**, i64 }* %t456, { i8**, i64 }** %l1
  store i1 %t457, i1* %l4
  store double %t458, double* %l10
  store i8* %t459, i8** %l6
  store i1 %t460, i1* %l7
  store double %t461, double* %l11
  store i1 %t462, i1* %l8
  store double %t463, double* %l12
  %t464 = load i1, i1* %l3
  %t465 = load double, double* %l9
  %t466 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t467 = load i1, i1* %l4
  %t468 = load double, double* %l10
  %t469 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t470 = load i8*, i8** %l6
  %t471 = load i1, i1* %l7
  %t472 = load double, double* %l11
  %t473 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t474 = load i1, i1* %l8
  %t475 = load double, double* %l12
  %t476 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t477 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge10
merge10:
  %t478 = phi i8* [ %t110, %then8 ], [ %t96, %merge13 ]
  %t479 = phi i1 [ %t111, %then8 ], [ %t93, %merge13 ]
  %t480 = phi i1 [ %t94, %then8 ], [ %t464, %merge13 ]
  %t481 = phi double [ %t100, %then8 ], [ %t465, %merge13 ]
  %t482 = phi { i8**, i64 }* [ %t92, %then8 ], [ %t466, %merge13 ]
  %t483 = phi i1 [ %t95, %then8 ], [ %t467, %merge13 ]
  %t484 = phi double [ %t101, %then8 ], [ %t468, %merge13 ]
  %t485 = phi i8* [ %t97, %then8 ], [ %t470, %merge13 ]
  %t486 = phi i1 [ %t98, %then8 ], [ %t471, %merge13 ]
  %t487 = phi double [ %t102, %then8 ], [ %t472, %merge13 ]
  %t488 = phi i1 [ %t99, %then8 ], [ %t474, %merge13 ]
  %t489 = phi double [ %t103, %then8 ], [ %t475, %merge13 ]
  store i8* %t478, i8** %l5
  store i1 %t479, i1* %l2
  store i1 %t480, i1* %l3
  store double %t481, double* %l9
  store { i8**, i64 }* %t482, { i8**, i64 }** %l1
  store i1 %t483, i1* %l4
  store double %t484, double* %l10
  store i8* %t485, i8** %l6
  store i1 %t486, i1* %l7
  store double %t487, double* %l11
  store i1 %t488, i1* %l8
  store double %t489, double* %l12
  %t490 = load double, double* %l13
  %t491 = sitofp i64 1 to double
  %t492 = fadd double %t490, %t491
  store double %t492, double* %l13
  br label %loop.latch4
loop.latch4:
  %t493 = load i8*, i8** %l5
  %t494 = load i1, i1* %l2
  %t495 = load i1, i1* %l3
  %t496 = load double, double* %l9
  %t497 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t498 = load i1, i1* %l4
  %t499 = load double, double* %l10
  %t500 = load i8*, i8** %l6
  %t501 = load i1, i1* %l7
  %t502 = load double, double* %l11
  %t503 = load i1, i1* %l8
  %t504 = load double, double* %l12
  %t505 = load double, double* %l13
  br label %loop.header2
afterloop5:
  %t519 = load i8*, i8** %l5
  %t520 = load i1, i1* %l2
  %t521 = load i1, i1* %l3
  %t522 = load double, double* %l9
  %t523 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t524 = load i1, i1* %l4
  %t525 = load double, double* %l10
  %t526 = load i8*, i8** %l6
  %t527 = load i1, i1* %l7
  %t528 = load double, double* %l11
  %t529 = load i1, i1* %l8
  %t530 = load double, double* %l12
  %t531 = load double, double* %l13
  %t532 = load i1, i1* %l3
  %t533 = xor i1 %t532, 1
  %t534 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t535 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t536 = load i1, i1* %l2
  %t537 = load i1, i1* %l3
  %t538 = load i1, i1* %l4
  %t539 = load i8*, i8** %l5
  %t540 = load i8*, i8** %l6
  %t541 = load i1, i1* %l7
  %t542 = load i1, i1* %l8
  %t543 = load double, double* %l9
  %t544 = load double, double* %l10
  %t545 = load double, double* %l11
  %t546 = load double, double* %l12
  %t547 = load double, double* %l13
  br i1 %t533, label %then38, label %merge39
then38:
  %t548 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s549 = getelementptr inbounds [38 x i8], [38 x i8]* @.str.len37.h2038142650, i32 0, i32 0
  %t550 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t548, i8* %s549)
  store { i8**, i64 }* %t550, { i8**, i64 }** %l1
  %t551 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge39
merge39:
  %t552 = phi { i8**, i64 }* [ %t551, %then38 ], [ %t535, %afterloop5 ]
  store { i8**, i64 }* %t552, { i8**, i64 }** %l1
  %t553 = load i1, i1* %l4
  %t554 = xor i1 %t553, 1
  %t555 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t556 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t557 = load i1, i1* %l2
  %t558 = load i1, i1* %l3
  %t559 = load i1, i1* %l4
  %t560 = load i8*, i8** %l5
  %t561 = load i8*, i8** %l6
  %t562 = load i1, i1* %l7
  %t563 = load i1, i1* %l8
  %t564 = load double, double* %l9
  %t565 = load double, double* %l10
  %t566 = load double, double* %l11
  %t567 = load double, double* %l12
  %t568 = load double, double* %l13
  br i1 %t554, label %then40, label %merge41
then40:
  %t569 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s570 = getelementptr inbounds [39 x i8], [39 x i8]* @.str.len38.h2050661185, i32 0, i32 0
  %t571 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t569, i8* %s570)
  store { i8**, i64 }* %t571, { i8**, i64 }** %l1
  %t572 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge41
merge41:
  %t573 = phi { i8**, i64 }* [ %t572, %then40 ], [ %t556, %merge39 ]
  store { i8**, i64 }* %t573, { i8**, i64 }** %l1
  %t574 = load i8*, i8** %l6
  %t575 = call i64 @sailfin_runtime_string_length(i8* %t574)
  %t576 = icmp eq i64 %t575, 0
  %t577 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t578 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t579 = load i1, i1* %l2
  %t580 = load i1, i1* %l3
  %t581 = load i1, i1* %l4
  %t582 = load i8*, i8** %l5
  %t583 = load i8*, i8** %l6
  %t584 = load i1, i1* %l7
  %t585 = load i1, i1* %l8
  %t586 = load double, double* %l9
  %t587 = load double, double* %l10
  %t588 = load double, double* %l11
  %t589 = load double, double* %l12
  %t590 = load double, double* %l13
  br i1 %t576, label %then42, label %merge43
then42:
  %t591 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s592 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.len41.h881857818, i32 0, i32 0
  %t593 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t591, i8* %s592)
  store { i8**, i64 }* %t593, { i8**, i64 }** %l1
  %t594 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge43
merge43:
  %t595 = phi { i8**, i64 }* [ %t594, %then42 ], [ %t578, %merge41 ]
  store { i8**, i64 }* %t595, { i8**, i64 }** %l1
  %t596 = load i1, i1* %l7
  %t597 = xor i1 %t596, 1
  %t598 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t599 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t600 = load i1, i1* %l2
  %t601 = load i1, i1* %l3
  %t602 = load i1, i1* %l4
  %t603 = load i8*, i8** %l5
  %t604 = load i8*, i8** %l6
  %t605 = load i1, i1* %l7
  %t606 = load i1, i1* %l8
  %t607 = load double, double* %l9
  %t608 = load double, double* %l10
  %t609 = load double, double* %l11
  %t610 = load double, double* %l12
  %t611 = load double, double* %l13
  br i1 %t597, label %then44, label %merge45
then44:
  %t612 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s613 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.len41.h2069276858, i32 0, i32 0
  %t614 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t612, i8* %s613)
  store { i8**, i64 }* %t614, { i8**, i64 }** %l1
  %t615 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge45
merge45:
  %t616 = phi { i8**, i64 }* [ %t615, %then44 ], [ %t599, %merge43 ]
  store { i8**, i64 }* %t616, { i8**, i64 }** %l1
  %t617 = load i1, i1* %l8
  %t618 = xor i1 %t617, 1
  %t619 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t620 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t621 = load i1, i1* %l2
  %t622 = load i1, i1* %l3
  %t623 = load i1, i1* %l4
  %t624 = load i8*, i8** %l5
  %t625 = load i8*, i8** %l6
  %t626 = load i1, i1* %l7
  %t627 = load i1, i1* %l8
  %t628 = load double, double* %l9
  %t629 = load double, double* %l10
  %t630 = load double, double* %l11
  %t631 = load double, double* %l12
  %t632 = load double, double* %l13
  br i1 %t618, label %then46, label %merge47
then46:
  %t633 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s634 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.len42.h930606274, i32 0, i32 0
  %t635 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t633, i8* %s634)
  store { i8**, i64 }* %t635, { i8**, i64 }** %l1
  %t636 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge47
merge47:
  %t637 = phi { i8**, i64 }* [ %t636, %then46 ], [ %t620, %merge45 ]
  store { i8**, i64 }* %t637, { i8**, i64 }** %l1
  %t639 = load i1, i1* %l3
  br label %logical_and_entry_638

logical_and_entry_638:
  br i1 %t639, label %logical_and_right_638, label %logical_and_merge_638

logical_and_right_638:
  %t641 = load i1, i1* %l4
  br label %logical_and_entry_640

logical_and_entry_640:
  br i1 %t641, label %logical_and_right_640, label %logical_and_merge_640

logical_and_right_640:
  %t643 = load i8*, i8** %l6
  %t644 = call i64 @sailfin_runtime_string_length(i8* %t643)
  %t645 = icmp sgt i64 %t644, 0
  br label %logical_and_entry_642

logical_and_entry_642:
  br i1 %t645, label %logical_and_right_642, label %logical_and_merge_642

logical_and_right_642:
  %t647 = load i1, i1* %l7
  br label %logical_and_entry_646

logical_and_entry_646:
  br i1 %t647, label %logical_and_right_646, label %logical_and_merge_646

logical_and_right_646:
  %t649 = load i1, i1* %l8
  br label %logical_and_entry_648

logical_and_entry_648:
  br i1 %t649, label %logical_and_right_648, label %logical_and_merge_648

logical_and_right_648:
  %t650 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t651 = load { i8**, i64 }, { i8**, i64 }* %t650
  %t652 = extractvalue { i8**, i64 } %t651, 1
  %t653 = icmp eq i64 %t652, 0
  br label %logical_and_right_end_648

logical_and_right_end_648:
  br label %logical_and_merge_648

logical_and_merge_648:
  %t654 = phi i1 [ false, %logical_and_entry_648 ], [ %t653, %logical_and_right_end_648 ]
  br label %logical_and_right_end_646

logical_and_right_end_646:
  br label %logical_and_merge_646

logical_and_merge_646:
  %t655 = phi i1 [ false, %logical_and_entry_646 ], [ %t654, %logical_and_right_end_646 ]
  br label %logical_and_right_end_642

logical_and_right_end_642:
  br label %logical_and_merge_642

logical_and_merge_642:
  %t656 = phi i1 [ false, %logical_and_entry_642 ], [ %t655, %logical_and_right_end_642 ]
  br label %logical_and_right_end_640

logical_and_right_end_640:
  br label %logical_and_merge_640

logical_and_merge_640:
  %t657 = phi i1 [ false, %logical_and_entry_640 ], [ %t656, %logical_and_right_end_640 ]
  br label %logical_and_right_end_638

logical_and_right_end_638:
  br label %logical_and_merge_638

logical_and_merge_638:
  %t658 = phi i1 [ false, %logical_and_entry_638 ], [ %t657, %logical_and_right_end_638 ]
  store i1 %t658, i1* %l23
  %t659 = load i1, i1* %l23
  %t660 = insertvalue %EnumLayoutHeaderParse undef, i1 %t659, 0
  %t661 = load i8*, i8** %l5
  %t662 = insertvalue %EnumLayoutHeaderParse %t660, i8* %t661, 1
  %t663 = load double, double* %l9
  %t664 = insertvalue %EnumLayoutHeaderParse %t662, double %t663, 2
  %t665 = load double, double* %l10
  %t666 = insertvalue %EnumLayoutHeaderParse %t664, double %t665, 3
  %t667 = load i8*, i8** %l6
  %t668 = insertvalue %EnumLayoutHeaderParse %t666, i8* %t667, 4
  %t669 = load double, double* %l11
  %t670 = insertvalue %EnumLayoutHeaderParse %t668, double %t669, 5
  %t671 = load double, double* %l12
  %t672 = insertvalue %EnumLayoutHeaderParse %t670, double %t671, 6
  %t673 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t674 = insertvalue %EnumLayoutHeaderParse %t672, { i8**, i64 }* %t673, 7
  ret %EnumLayoutHeaderParse %t674
}

define %EnumLayoutVariantParse @parse_enum_variant_layout(i8* %text, i8* %enum_name) {
block.entry:
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
  %t1 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t2 = ptrtoint [0 x i8*]* %t1 to i64
  %t3 = icmp eq i64 %t2, 0
  %t4 = select i1 %t3, i64 1, i64 %t2
  %t5 = call i8* @malloc(i64 %t4)
  %t6 = bitcast i8* %t5 to i8**
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t8 = ptrtoint { i8**, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { i8**, i64 }*
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 0
  store i8** %t6, i8*** %t11
  %t12 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 1
  store i64 0, i64* %t12
  store { i8**, i64 }* %t10, { i8**, i64 }** %l1
  %s13 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t14 = insertvalue %NativeEnumVariantLayout undef, i8* %s13, 0
  %t15 = sitofp i64 0 to double
  %t16 = insertvalue %NativeEnumVariantLayout %t14, double %t15, 1
  %t17 = sitofp i64 0 to double
  %t18 = insertvalue %NativeEnumVariantLayout %t16, double %t17, 2
  %t19 = sitofp i64 0 to double
  %t20 = insertvalue %NativeEnumVariantLayout %t18, double %t19, 3
  %t21 = sitofp i64 0 to double
  %t22 = insertvalue %NativeEnumVariantLayout %t20, double %t21, 4
  %t23 = getelementptr [0 x %NativeStructLayoutField*], [0 x %NativeStructLayoutField*]* null, i32 1
  %t24 = ptrtoint [0 x %NativeStructLayoutField*]* %t23 to i64
  %t25 = icmp eq i64 %t24, 0
  %t26 = select i1 %t25, i64 1, i64 %t24
  %t27 = call i8* @malloc(i64 %t26)
  %t28 = bitcast i8* %t27 to %NativeStructLayoutField**
  %t29 = getelementptr { %NativeStructLayoutField**, i64 }, { %NativeStructLayoutField**, i64 }* null, i32 1
  %t30 = ptrtoint { %NativeStructLayoutField**, i64 }* %t29 to i64
  %t31 = call i8* @malloc(i64 %t30)
  %t32 = bitcast i8* %t31 to { %NativeStructLayoutField**, i64 }*
  %t33 = getelementptr { %NativeStructLayoutField**, i64 }, { %NativeStructLayoutField**, i64 }* %t32, i32 0, i32 0
  store %NativeStructLayoutField** %t28, %NativeStructLayoutField*** %t33
  %t34 = getelementptr { %NativeStructLayoutField**, i64 }, { %NativeStructLayoutField**, i64 }* %t32, i32 0, i32 1
  store i64 0, i64* %t34
  %t35 = insertvalue %NativeEnumVariantLayout %t22, { %NativeStructLayoutField**, i64 }* %t32, 5
  store %NativeEnumVariantLayout %t35, %NativeEnumVariantLayout* %l2
  %t36 = load i8*, i8** %l0
  %t37 = call i64 @sailfin_runtime_string_length(i8* %t36)
  %t38 = icmp eq i64 %t37, 0
  %t39 = load i8*, i8** %l0
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t41 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  br i1 %t38, label %then0, label %merge1
then0:
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s43 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t44 = call i8* @sailfin_runtime_string_concat(i8* %s43, i8* %enum_name)
  %s45 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.len31.h1960327680, i32 0, i32 0
  %t46 = call i8* @sailfin_runtime_string_concat(i8* %t44, i8* %s45)
  %t47 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t42, i8* %t46)
  store { i8**, i64 }* %t47, { i8**, i64 }** %l1
  %t48 = insertvalue %EnumLayoutVariantParse undef, i1 0, 0
  %t49 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t50 = insertvalue %EnumLayoutVariantParse %t48, %NativeEnumVariantLayout %t49, 1
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t52 = insertvalue %EnumLayoutVariantParse %t50, { i8**, i64 }* %t51, 2
  ret %EnumLayoutVariantParse %t52
merge1:
  %t53 = load i8*, i8** %l0
  %t54 = call { i8**, i64 }* @split_whitespace(i8* %t53)
  store { i8**, i64 }* %t54, { i8**, i64 }** %l3
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t56 = load { i8**, i64 }, { i8**, i64 }* %t55
  %t57 = extractvalue { i8**, i64 } %t56, 1
  %t58 = icmp eq i64 %t57, 0
  %t59 = load i8*, i8** %l0
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t61 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l3
  br i1 %t58, label %then2, label %merge3
then2:
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s64 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t65 = call i8* @sailfin_runtime_string_concat(i8* %s64, i8* %enum_name)
  %s66 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.len31.h238974215, i32 0, i32 0
  %t67 = call i8* @sailfin_runtime_string_concat(i8* %t65, i8* %s66)
  %t68 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t63, i8* %t67)
  store { i8**, i64 }* %t68, { i8**, i64 }** %l1
  %t69 = insertvalue %EnumLayoutVariantParse undef, i1 0, 0
  %t70 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t71 = insertvalue %EnumLayoutVariantParse %t69, %NativeEnumVariantLayout %t70, 1
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t73 = insertvalue %EnumLayoutVariantParse %t71, { i8**, i64 }* %t72, 2
  ret %EnumLayoutVariantParse %t73
merge3:
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t75 = load { i8**, i64 }, { i8**, i64 }* %t74
  %t76 = extractvalue { i8**, i64 } %t75, 0
  %t77 = extractvalue { i8**, i64 } %t75, 1
  %t78 = icmp uge i64 0, %t77
  ; bounds check: %t78 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 0, i64 %t77)
  %t79 = getelementptr i8*, i8** %t76, i64 0
  %t80 = load i8*, i8** %t79
  store i8* %t80, i8** %l4
  %t81 = load i8*, i8** %l4
  %t82 = call i64 @sailfin_runtime_string_length(i8* %t81)
  %t83 = icmp eq i64 %t82, 0
  %t84 = load i8*, i8** %l0
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t86 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t87 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t88 = load i8*, i8** %l4
  br i1 %t83, label %then4, label %merge5
then4:
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s90 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t91 = call i8* @sailfin_runtime_string_concat(i8* %s90, i8* %enum_name)
  %s92 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.len28.h1605654048, i32 0, i32 0
  %t93 = call i8* @sailfin_runtime_string_concat(i8* %t91, i8* %s92)
  %t94 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t89, i8* %t93)
  store { i8**, i64 }* %t94, { i8**, i64 }** %l1
  %t95 = insertvalue %EnumLayoutVariantParse undef, i1 0, 0
  %t96 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t97 = insertvalue %EnumLayoutVariantParse %t95, %NativeEnumVariantLayout %t96, 1
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t99 = insertvalue %EnumLayoutVariantParse %t97, { i8**, i64 }* %t98, 2
  ret %EnumLayoutVariantParse %t99
merge5:
  store i1 0, i1* %l5
  store i1 0, i1* %l6
  store i1 0, i1* %l7
  store i1 0, i1* %l8
  %t100 = sitofp i64 0 to double
  store double %t100, double* %l9
  %t101 = sitofp i64 0 to double
  store double %t101, double* %l10
  %t102 = sitofp i64 0 to double
  store double %t102, double* %l11
  %t103 = sitofp i64 0 to double
  store double %t103, double* %l12
  %t104 = sitofp i64 1 to double
  store double %t104, double* %l13
  %t105 = load i8*, i8** %l0
  %t106 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t107 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t108 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t109 = load i8*, i8** %l4
  %t110 = load i1, i1* %l5
  %t111 = load i1, i1* %l6
  %t112 = load i1, i1* %l7
  %t113 = load i1, i1* %l8
  %t114 = load double, double* %l9
  %t115 = load double, double* %l10
  %t116 = load double, double* %l11
  %t117 = load double, double* %l12
  %t118 = load double, double* %l13
  br label %loop.header6
loop.header6:
  %t508 = phi i1 [ %t110, %merge5 ], [ %t498, %loop.latch8 ]
  %t509 = phi double [ %t114, %merge5 ], [ %t499, %loop.latch8 ]
  %t510 = phi { i8**, i64 }* [ %t106, %merge5 ], [ %t500, %loop.latch8 ]
  %t511 = phi i1 [ %t111, %merge5 ], [ %t501, %loop.latch8 ]
  %t512 = phi double [ %t115, %merge5 ], [ %t502, %loop.latch8 ]
  %t513 = phi i1 [ %t112, %merge5 ], [ %t503, %loop.latch8 ]
  %t514 = phi double [ %t116, %merge5 ], [ %t504, %loop.latch8 ]
  %t515 = phi i1 [ %t113, %merge5 ], [ %t505, %loop.latch8 ]
  %t516 = phi double [ %t117, %merge5 ], [ %t506, %loop.latch8 ]
  %t517 = phi double [ %t118, %merge5 ], [ %t507, %loop.latch8 ]
  store i1 %t508, i1* %l5
  store double %t509, double* %l9
  store { i8**, i64 }* %t510, { i8**, i64 }** %l1
  store i1 %t511, i1* %l6
  store double %t512, double* %l10
  store i1 %t513, i1* %l7
  store double %t514, double* %l11
  store i1 %t515, i1* %l8
  store double %t516, double* %l12
  store double %t517, double* %l13
  br label %loop.body7
loop.body7:
  %t119 = load double, double* %l13
  %t120 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t121 = load { i8**, i64 }, { i8**, i64 }* %t120
  %t122 = extractvalue { i8**, i64 } %t121, 1
  %t123 = sitofp i64 %t122 to double
  %t124 = fcmp oge double %t119, %t123
  %t125 = load i8*, i8** %l0
  %t126 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t127 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t128 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t129 = load i8*, i8** %l4
  %t130 = load i1, i1* %l5
  %t131 = load i1, i1* %l6
  %t132 = load i1, i1* %l7
  %t133 = load i1, i1* %l8
  %t134 = load double, double* %l9
  %t135 = load double, double* %l10
  %t136 = load double, double* %l11
  %t137 = load double, double* %l12
  %t138 = load double, double* %l13
  br i1 %t124, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t139 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t140 = load double, double* %l13
  %t141 = fptosi double %t140 to i64
  %t142 = load { i8**, i64 }, { i8**, i64 }* %t139
  %t143 = extractvalue { i8**, i64 } %t142, 0
  %t144 = extractvalue { i8**, i64 } %t142, 1
  %t145 = icmp uge i64 %t141, %t144
  ; bounds check: %t145 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t141, i64 %t144)
  %t146 = getelementptr i8*, i8** %t143, i64 %t141
  %t147 = load i8*, i8** %t146
  store i8* %t147, i8** %l14
  %t148 = load i8*, i8** %l14
  %s149 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h275319236, i32 0, i32 0
  %t150 = call i1 @starts_with(i8* %t148, i8* %s149)
  %t151 = load i8*, i8** %l0
  %t152 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t153 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t154 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t155 = load i8*, i8** %l4
  %t156 = load i1, i1* %l5
  %t157 = load i1, i1* %l6
  %t158 = load i1, i1* %l7
  %t159 = load i1, i1* %l8
  %t160 = load double, double* %l9
  %t161 = load double, double* %l10
  %t162 = load double, double* %l11
  %t163 = load double, double* %l12
  %t164 = load double, double* %l13
  %t165 = load i8*, i8** %l14
  br i1 %t150, label %then12, label %else13
then12:
  %t166 = load i8*, i8** %l14
  %t167 = load i8*, i8** %l14
  %t168 = call i64 @sailfin_runtime_string_length(i8* %t167)
  %t169 = call i8* @sailfin_runtime_substring(i8* %t166, i64 4, i64 %t168)
  store i8* %t169, i8** %l15
  %t170 = load i8*, i8** %l15
  %t171 = call %NumberParseResult @parse_decimal_number(i8* %t170)
  store %NumberParseResult %t171, %NumberParseResult* %l16
  %t172 = load %NumberParseResult, %NumberParseResult* %l16
  %t173 = extractvalue %NumberParseResult %t172, 0
  %t174 = load i8*, i8** %l0
  %t175 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t176 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t177 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t178 = load i8*, i8** %l4
  %t179 = load i1, i1* %l5
  %t180 = load i1, i1* %l6
  %t181 = load i1, i1* %l7
  %t182 = load i1, i1* %l8
  %t183 = load double, double* %l9
  %t184 = load double, double* %l10
  %t185 = load double, double* %l11
  %t186 = load double, double* %l12
  %t187 = load double, double* %l13
  %t188 = load i8*, i8** %l14
  %t189 = load i8*, i8** %l15
  %t190 = load %NumberParseResult, %NumberParseResult* %l16
  br i1 %t173, label %then15, label %else16
then15:
  store i1 1, i1* %l5
  %t191 = load %NumberParseResult, %NumberParseResult* %l16
  %t192 = extractvalue %NumberParseResult %t191, 1
  store double %t192, double* %l9
  %t193 = load i1, i1* %l5
  %t194 = load double, double* %l9
  br label %merge17
else16:
  %t195 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s196 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t197 = call i8* @sailfin_runtime_string_concat(i8* %s196, i8* %enum_name)
  %s198 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h293109504, i32 0, i32 0
  %t199 = call i8* @sailfin_runtime_string_concat(i8* %t197, i8* %s198)
  %t200 = load i8*, i8** %l4
  %t201 = call i8* @sailfin_runtime_string_concat(i8* %t199, i8* %t200)
  %s202 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h879467198, i32 0, i32 0
  %t203 = call i8* @sailfin_runtime_string_concat(i8* %t201, i8* %s202)
  %t204 = load i8*, i8** %l15
  %t205 = call i8* @sailfin_runtime_string_concat(i8* %t203, i8* %t204)
  %t206 = alloca [2 x i8], align 1
  %t207 = getelementptr [2 x i8], [2 x i8]* %t206, i32 0, i32 0
  store i8 96, i8* %t207
  %t208 = getelementptr [2 x i8], [2 x i8]* %t206, i32 0, i32 1
  store i8 0, i8* %t208
  %t209 = getelementptr [2 x i8], [2 x i8]* %t206, i32 0, i32 0
  %t210 = call i8* @sailfin_runtime_string_concat(i8* %t205, i8* %t209)
  %t211 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t195, i8* %t210)
  store { i8**, i64 }* %t211, { i8**, i64 }** %l1
  %t212 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge17
merge17:
  %t213 = phi i1 [ %t193, %then15 ], [ %t179, %else16 ]
  %t214 = phi double [ %t194, %then15 ], [ %t183, %else16 ]
  %t215 = phi { i8**, i64 }* [ %t175, %then15 ], [ %t212, %else16 ]
  store i1 %t213, i1* %l5
  store double %t214, double* %l9
  store { i8**, i64 }* %t215, { i8**, i64 }** %l1
  %t216 = load i1, i1* %l5
  %t217 = load double, double* %l9
  %t218 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge14
else13:
  %t219 = load i8*, i8** %l14
  %s220 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h242296049, i32 0, i32 0
  %t221 = call i1 @starts_with(i8* %t219, i8* %s220)
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
  br i1 %t221, label %then18, label %else19
then18:
  %t237 = load i8*, i8** %l14
  %t238 = load i8*, i8** %l14
  %t239 = call i64 @sailfin_runtime_string_length(i8* %t238)
  %t240 = call i8* @sailfin_runtime_substring(i8* %t237, i64 7, i64 %t239)
  store i8* %t240, i8** %l17
  %t241 = load i8*, i8** %l17
  %t242 = call %NumberParseResult @parse_decimal_number(i8* %t241)
  store %NumberParseResult %t242, %NumberParseResult* %l18
  %t243 = load %NumberParseResult, %NumberParseResult* %l18
  %t244 = extractvalue %NumberParseResult %t243, 0
  %t245 = load i8*, i8** %l0
  %t246 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t247 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t248 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t249 = load i8*, i8** %l4
  %t250 = load i1, i1* %l5
  %t251 = load i1, i1* %l6
  %t252 = load i1, i1* %l7
  %t253 = load i1, i1* %l8
  %t254 = load double, double* %l9
  %t255 = load double, double* %l10
  %t256 = load double, double* %l11
  %t257 = load double, double* %l12
  %t258 = load double, double* %l13
  %t259 = load i8*, i8** %l14
  %t260 = load i8*, i8** %l17
  %t261 = load %NumberParseResult, %NumberParseResult* %l18
  br i1 %t244, label %then21, label %else22
then21:
  store i1 1, i1* %l6
  %t262 = load %NumberParseResult, %NumberParseResult* %l18
  %t263 = extractvalue %NumberParseResult %t262, 1
  store double %t263, double* %l10
  %t264 = load i1, i1* %l6
  %t265 = load double, double* %l10
  br label %merge23
else22:
  %t266 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s267 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t268 = call i8* @sailfin_runtime_string_concat(i8* %s267, i8* %enum_name)
  %s269 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h293109504, i32 0, i32 0
  %t270 = call i8* @sailfin_runtime_string_concat(i8* %t268, i8* %s269)
  %t271 = load i8*, i8** %l4
  %t272 = call i8* @sailfin_runtime_string_concat(i8* %t270, i8* %t271)
  %s273 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h24304067, i32 0, i32 0
  %t274 = call i8* @sailfin_runtime_string_concat(i8* %t272, i8* %s273)
  %t275 = load i8*, i8** %l17
  %t276 = call i8* @sailfin_runtime_string_concat(i8* %t274, i8* %t275)
  %t277 = alloca [2 x i8], align 1
  %t278 = getelementptr [2 x i8], [2 x i8]* %t277, i32 0, i32 0
  store i8 96, i8* %t278
  %t279 = getelementptr [2 x i8], [2 x i8]* %t277, i32 0, i32 1
  store i8 0, i8* %t279
  %t280 = getelementptr [2 x i8], [2 x i8]* %t277, i32 0, i32 0
  %t281 = call i8* @sailfin_runtime_string_concat(i8* %t276, i8* %t280)
  %t282 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t266, i8* %t281)
  store { i8**, i64 }* %t282, { i8**, i64 }** %l1
  %t283 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge23
merge23:
  %t284 = phi i1 [ %t264, %then21 ], [ %t251, %else22 ]
  %t285 = phi double [ %t265, %then21 ], [ %t255, %else22 ]
  %t286 = phi { i8**, i64 }* [ %t246, %then21 ], [ %t283, %else22 ]
  store i1 %t284, i1* %l6
  store double %t285, double* %l10
  store { i8**, i64 }* %t286, { i8**, i64 }** %l1
  %t287 = load i1, i1* %l6
  %t288 = load double, double* %l10
  %t289 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge20
else19:
  %t290 = load i8*, i8** %l14
  %s291 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h466680424, i32 0, i32 0
  %t292 = call i1 @starts_with(i8* %t290, i8* %s291)
  %t293 = load i8*, i8** %l0
  %t294 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t295 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t296 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t297 = load i8*, i8** %l4
  %t298 = load i1, i1* %l5
  %t299 = load i1, i1* %l6
  %t300 = load i1, i1* %l7
  %t301 = load i1, i1* %l8
  %t302 = load double, double* %l9
  %t303 = load double, double* %l10
  %t304 = load double, double* %l11
  %t305 = load double, double* %l12
  %t306 = load double, double* %l13
  %t307 = load i8*, i8** %l14
  br i1 %t292, label %then24, label %else25
then24:
  %t308 = load i8*, i8** %l14
  %t309 = load i8*, i8** %l14
  %t310 = call i64 @sailfin_runtime_string_length(i8* %t309)
  %t311 = call i8* @sailfin_runtime_substring(i8* %t308, i64 5, i64 %t310)
  store i8* %t311, i8** %l19
  %t312 = load i8*, i8** %l19
  %t313 = call %NumberParseResult @parse_decimal_number(i8* %t312)
  store %NumberParseResult %t313, %NumberParseResult* %l20
  %t314 = load %NumberParseResult, %NumberParseResult* %l20
  %t315 = extractvalue %NumberParseResult %t314, 0
  %t316 = load i8*, i8** %l0
  %t317 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t318 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t319 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t320 = load i8*, i8** %l4
  %t321 = load i1, i1* %l5
  %t322 = load i1, i1* %l6
  %t323 = load i1, i1* %l7
  %t324 = load i1, i1* %l8
  %t325 = load double, double* %l9
  %t326 = load double, double* %l10
  %t327 = load double, double* %l11
  %t328 = load double, double* %l12
  %t329 = load double, double* %l13
  %t330 = load i8*, i8** %l14
  %t331 = load i8*, i8** %l19
  %t332 = load %NumberParseResult, %NumberParseResult* %l20
  br i1 %t315, label %then27, label %else28
then27:
  store i1 1, i1* %l7
  %t333 = load %NumberParseResult, %NumberParseResult* %l20
  %t334 = extractvalue %NumberParseResult %t333, 1
  store double %t334, double* %l11
  %t335 = load i1, i1* %l7
  %t336 = load double, double* %l11
  br label %merge29
else28:
  %t337 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s338 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t339 = call i8* @sailfin_runtime_string_concat(i8* %s338, i8* %enum_name)
  %s340 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h293109504, i32 0, i32 0
  %t341 = call i8* @sailfin_runtime_string_concat(i8* %t339, i8* %s340)
  %t342 = load i8*, i8** %l4
  %t343 = call i8* @sailfin_runtime_string_concat(i8* %t341, i8* %t342)
  %s344 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h151690315, i32 0, i32 0
  %t345 = call i8* @sailfin_runtime_string_concat(i8* %t343, i8* %s344)
  %t346 = load i8*, i8** %l19
  %t347 = call i8* @sailfin_runtime_string_concat(i8* %t345, i8* %t346)
  %t348 = alloca [2 x i8], align 1
  %t349 = getelementptr [2 x i8], [2 x i8]* %t348, i32 0, i32 0
  store i8 96, i8* %t349
  %t350 = getelementptr [2 x i8], [2 x i8]* %t348, i32 0, i32 1
  store i8 0, i8* %t350
  %t351 = getelementptr [2 x i8], [2 x i8]* %t348, i32 0, i32 0
  %t352 = call i8* @sailfin_runtime_string_concat(i8* %t347, i8* %t351)
  %t353 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t337, i8* %t352)
  store { i8**, i64 }* %t353, { i8**, i64 }** %l1
  %t354 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge29
merge29:
  %t355 = phi i1 [ %t335, %then27 ], [ %t323, %else28 ]
  %t356 = phi double [ %t336, %then27 ], [ %t327, %else28 ]
  %t357 = phi { i8**, i64 }* [ %t317, %then27 ], [ %t354, %else28 ]
  store i1 %t355, i1* %l7
  store double %t356, double* %l11
  store { i8**, i64 }* %t357, { i8**, i64 }** %l1
  %t358 = load i1, i1* %l7
  %t359 = load double, double* %l11
  %t360 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge26
else25:
  %t361 = load i8*, i8** %l14
  %s362 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h841337749, i32 0, i32 0
  %t363 = call i1 @starts_with(i8* %t361, i8* %s362)
  %t364 = load i8*, i8** %l0
  %t365 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t366 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t367 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t368 = load i8*, i8** %l4
  %t369 = load i1, i1* %l5
  %t370 = load i1, i1* %l6
  %t371 = load i1, i1* %l7
  %t372 = load i1, i1* %l8
  %t373 = load double, double* %l9
  %t374 = load double, double* %l10
  %t375 = load double, double* %l11
  %t376 = load double, double* %l12
  %t377 = load double, double* %l13
  %t378 = load i8*, i8** %l14
  br i1 %t363, label %then30, label %else31
then30:
  %t379 = load i8*, i8** %l14
  %t380 = load i8*, i8** %l14
  %t381 = call i64 @sailfin_runtime_string_length(i8* %t380)
  %t382 = call i8* @sailfin_runtime_substring(i8* %t379, i64 6, i64 %t381)
  store i8* %t382, i8** %l21
  %t383 = load i8*, i8** %l21
  %t384 = call %NumberParseResult @parse_decimal_number(i8* %t383)
  store %NumberParseResult %t384, %NumberParseResult* %l22
  %t385 = load %NumberParseResult, %NumberParseResult* %l22
  %t386 = extractvalue %NumberParseResult %t385, 0
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
  %t401 = load i8*, i8** %l14
  %t402 = load i8*, i8** %l21
  %t403 = load %NumberParseResult, %NumberParseResult* %l22
  br i1 %t386, label %then33, label %else34
then33:
  store i1 1, i1* %l8
  %t404 = load %NumberParseResult, %NumberParseResult* %l22
  %t405 = extractvalue %NumberParseResult %t404, 1
  store double %t405, double* %l12
  %t406 = load i1, i1* %l8
  %t407 = load double, double* %l12
  br label %merge35
else34:
  %t408 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s409 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t410 = call i8* @sailfin_runtime_string_concat(i8* %s409, i8* %enum_name)
  %s411 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h293109504, i32 0, i32 0
  %t412 = call i8* @sailfin_runtime_string_concat(i8* %t410, i8* %s411)
  %t413 = load i8*, i8** %l4
  %t414 = call i8* @sailfin_runtime_string_concat(i8* %t412, i8* %t413)
  %s415 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.len21.h1297227834, i32 0, i32 0
  %t416 = call i8* @sailfin_runtime_string_concat(i8* %t414, i8* %s415)
  %t417 = load i8*, i8** %l21
  %t418 = call i8* @sailfin_runtime_string_concat(i8* %t416, i8* %t417)
  %t419 = alloca [2 x i8], align 1
  %t420 = getelementptr [2 x i8], [2 x i8]* %t419, i32 0, i32 0
  store i8 96, i8* %t420
  %t421 = getelementptr [2 x i8], [2 x i8]* %t419, i32 0, i32 1
  store i8 0, i8* %t421
  %t422 = getelementptr [2 x i8], [2 x i8]* %t419, i32 0, i32 0
  %t423 = call i8* @sailfin_runtime_string_concat(i8* %t418, i8* %t422)
  %t424 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t408, i8* %t423)
  store { i8**, i64 }* %t424, { i8**, i64 }** %l1
  %t425 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge35
merge35:
  %t426 = phi i1 [ %t406, %then33 ], [ %t395, %else34 ]
  %t427 = phi double [ %t407, %then33 ], [ %t399, %else34 ]
  %t428 = phi { i8**, i64 }* [ %t388, %then33 ], [ %t425, %else34 ]
  store i1 %t426, i1* %l8
  store double %t427, double* %l12
  store { i8**, i64 }* %t428, { i8**, i64 }** %l1
  %t429 = load i1, i1* %l8
  %t430 = load double, double* %l12
  %t431 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge32
else31:
  %t432 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s433 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t434 = call i8* @sailfin_runtime_string_concat(i8* %s433, i8* %enum_name)
  %s435 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h293109504, i32 0, i32 0
  %t436 = call i8* @sailfin_runtime_string_concat(i8* %t434, i8* %s435)
  %t437 = load i8*, i8** %l4
  %t438 = call i8* @sailfin_runtime_string_concat(i8* %t436, i8* %t437)
  %s439 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h496289716, i32 0, i32 0
  %t440 = call i8* @sailfin_runtime_string_concat(i8* %t438, i8* %s439)
  %t441 = load i8*, i8** %l14
  %t442 = call i8* @sailfin_runtime_string_concat(i8* %t440, i8* %t441)
  %t443 = alloca [2 x i8], align 1
  %t444 = getelementptr [2 x i8], [2 x i8]* %t443, i32 0, i32 0
  store i8 96, i8* %t444
  %t445 = getelementptr [2 x i8], [2 x i8]* %t443, i32 0, i32 1
  store i8 0, i8* %t445
  %t446 = getelementptr [2 x i8], [2 x i8]* %t443, i32 0, i32 0
  %t447 = call i8* @sailfin_runtime_string_concat(i8* %t442, i8* %t446)
  %t448 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t432, i8* %t447)
  store { i8**, i64 }* %t448, { i8**, i64 }** %l1
  %t449 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge32
merge32:
  %t450 = phi i1 [ %t429, %merge35 ], [ %t372, %else31 ]
  %t451 = phi double [ %t430, %merge35 ], [ %t376, %else31 ]
  %t452 = phi { i8**, i64 }* [ %t431, %merge35 ], [ %t449, %else31 ]
  store i1 %t450, i1* %l8
  store double %t451, double* %l12
  store { i8**, i64 }* %t452, { i8**, i64 }** %l1
  %t453 = load i1, i1* %l8
  %t454 = load double, double* %l12
  %t455 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t456 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge26
merge26:
  %t457 = phi i1 [ %t358, %merge29 ], [ %t300, %merge32 ]
  %t458 = phi double [ %t359, %merge29 ], [ %t304, %merge32 ]
  %t459 = phi { i8**, i64 }* [ %t360, %merge29 ], [ %t455, %merge32 ]
  %t460 = phi i1 [ %t301, %merge29 ], [ %t453, %merge32 ]
  %t461 = phi double [ %t305, %merge29 ], [ %t454, %merge32 ]
  store i1 %t457, i1* %l7
  store double %t458, double* %l11
  store { i8**, i64 }* %t459, { i8**, i64 }** %l1
  store i1 %t460, i1* %l8
  store double %t461, double* %l12
  %t462 = load i1, i1* %l7
  %t463 = load double, double* %l11
  %t464 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t465 = load i1, i1* %l8
  %t466 = load double, double* %l12
  %t467 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t468 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge20
merge20:
  %t469 = phi i1 [ %t287, %merge23 ], [ %t228, %merge26 ]
  %t470 = phi double [ %t288, %merge23 ], [ %t232, %merge26 ]
  %t471 = phi { i8**, i64 }* [ %t289, %merge23 ], [ %t464, %merge26 ]
  %t472 = phi i1 [ %t229, %merge23 ], [ %t462, %merge26 ]
  %t473 = phi double [ %t233, %merge23 ], [ %t463, %merge26 ]
  %t474 = phi i1 [ %t230, %merge23 ], [ %t465, %merge26 ]
  %t475 = phi double [ %t234, %merge23 ], [ %t466, %merge26 ]
  store i1 %t469, i1* %l6
  store double %t470, double* %l10
  store { i8**, i64 }* %t471, { i8**, i64 }** %l1
  store i1 %t472, i1* %l7
  store double %t473, double* %l11
  store i1 %t474, i1* %l8
  store double %t475, double* %l12
  %t476 = load i1, i1* %l6
  %t477 = load double, double* %l10
  %t478 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t479 = load i1, i1* %l7
  %t480 = load double, double* %l11
  %t481 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t482 = load i1, i1* %l8
  %t483 = load double, double* %l12
  %t484 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t485 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge14
merge14:
  %t486 = phi i1 [ %t216, %merge17 ], [ %t156, %merge20 ]
  %t487 = phi double [ %t217, %merge17 ], [ %t160, %merge20 ]
  %t488 = phi { i8**, i64 }* [ %t218, %merge17 ], [ %t478, %merge20 ]
  %t489 = phi i1 [ %t157, %merge17 ], [ %t476, %merge20 ]
  %t490 = phi double [ %t161, %merge17 ], [ %t477, %merge20 ]
  %t491 = phi i1 [ %t158, %merge17 ], [ %t479, %merge20 ]
  %t492 = phi double [ %t162, %merge17 ], [ %t480, %merge20 ]
  %t493 = phi i1 [ %t159, %merge17 ], [ %t482, %merge20 ]
  %t494 = phi double [ %t163, %merge17 ], [ %t483, %merge20 ]
  store i1 %t486, i1* %l5
  store double %t487, double* %l9
  store { i8**, i64 }* %t488, { i8**, i64 }** %l1
  store i1 %t489, i1* %l6
  store double %t490, double* %l10
  store i1 %t491, i1* %l7
  store double %t492, double* %l11
  store i1 %t493, i1* %l8
  store double %t494, double* %l12
  %t495 = load double, double* %l13
  %t496 = sitofp i64 1 to double
  %t497 = fadd double %t495, %t496
  store double %t497, double* %l13
  br label %loop.latch8
loop.latch8:
  %t498 = load i1, i1* %l5
  %t499 = load double, double* %l9
  %t500 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t501 = load i1, i1* %l6
  %t502 = load double, double* %l10
  %t503 = load i1, i1* %l7
  %t504 = load double, double* %l11
  %t505 = load i1, i1* %l8
  %t506 = load double, double* %l12
  %t507 = load double, double* %l13
  br label %loop.header6
afterloop9:
  %t518 = load i1, i1* %l5
  %t519 = load double, double* %l9
  %t520 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t521 = load i1, i1* %l6
  %t522 = load double, double* %l10
  %t523 = load i1, i1* %l7
  %t524 = load double, double* %l11
  %t525 = load i1, i1* %l8
  %t526 = load double, double* %l12
  %t527 = load double, double* %l13
  %t528 = load i1, i1* %l5
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
  br i1 %t529, label %then36, label %merge37
then36:
  %t544 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s545 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t546 = call i8* @sailfin_runtime_string_concat(i8* %s545, i8* %enum_name)
  %s547 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h293109504, i32 0, i32 0
  %t548 = call i8* @sailfin_runtime_string_concat(i8* %t546, i8* %s547)
  %t549 = load i8*, i8** %l4
  %t550 = call i8* @sailfin_runtime_string_concat(i8* %t548, i8* %t549)
  %s551 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h1697653870, i32 0, i32 0
  %t552 = call i8* @sailfin_runtime_string_concat(i8* %t550, i8* %s551)
  %t553 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t544, i8* %t552)
  store { i8**, i64 }* %t553, { i8**, i64 }** %l1
  %t554 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge37
merge37:
  %t555 = phi { i8**, i64 }* [ %t554, %then36 ], [ %t531, %afterloop9 ]
  store { i8**, i64 }* %t555, { i8**, i64 }** %l1
  %t556 = load i1, i1* %l6
  %t557 = xor i1 %t556, 1
  %t558 = load i8*, i8** %l0
  %t559 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t560 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t561 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t562 = load i8*, i8** %l4
  %t563 = load i1, i1* %l5
  %t564 = load i1, i1* %l6
  %t565 = load i1, i1* %l7
  %t566 = load i1, i1* %l8
  %t567 = load double, double* %l9
  %t568 = load double, double* %l10
  %t569 = load double, double* %l11
  %t570 = load double, double* %l12
  %t571 = load double, double* %l13
  br i1 %t557, label %then38, label %merge39
then38:
  %t572 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s573 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t574 = call i8* @sailfin_runtime_string_concat(i8* %s573, i8* %enum_name)
  %s575 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h293109504, i32 0, i32 0
  %t576 = call i8* @sailfin_runtime_string_concat(i8* %t574, i8* %s575)
  %t577 = load i8*, i8** %l4
  %t578 = call i8* @sailfin_runtime_string_concat(i8* %t576, i8* %t577)
  %s579 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h625556084, i32 0, i32 0
  %t580 = call i8* @sailfin_runtime_string_concat(i8* %t578, i8* %s579)
  %t581 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t572, i8* %t580)
  store { i8**, i64 }* %t581, { i8**, i64 }** %l1
  %t582 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge39
merge39:
  %t583 = phi { i8**, i64 }* [ %t582, %then38 ], [ %t559, %merge37 ]
  store { i8**, i64 }* %t583, { i8**, i64 }** %l1
  %t584 = load i1, i1* %l7
  %t585 = xor i1 %t584, 1
  %t586 = load i8*, i8** %l0
  %t587 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t588 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t589 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t590 = load i8*, i8** %l4
  %t591 = load i1, i1* %l5
  %t592 = load i1, i1* %l6
  %t593 = load i1, i1* %l7
  %t594 = load i1, i1* %l8
  %t595 = load double, double* %l9
  %t596 = load double, double* %l10
  %t597 = load double, double* %l11
  %t598 = load double, double* %l12
  %t599 = load double, double* %l13
  br i1 %t585, label %then40, label %merge41
then40:
  %t600 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s601 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t602 = call i8* @sailfin_runtime_string_concat(i8* %s601, i8* %enum_name)
  %s603 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h293109504, i32 0, i32 0
  %t604 = call i8* @sailfin_runtime_string_concat(i8* %t602, i8* %s603)
  %t605 = load i8*, i8** %l4
  %t606 = call i8* @sailfin_runtime_string_concat(i8* %t604, i8* %t605)
  %s607 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h608364678, i32 0, i32 0
  %t608 = call i8* @sailfin_runtime_string_concat(i8* %t606, i8* %s607)
  %t609 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t600, i8* %t608)
  store { i8**, i64 }* %t609, { i8**, i64 }** %l1
  %t610 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge41
merge41:
  %t611 = phi { i8**, i64 }* [ %t610, %then40 ], [ %t587, %merge39 ]
  store { i8**, i64 }* %t611, { i8**, i64 }** %l1
  %t612 = load i1, i1* %l8
  %t613 = xor i1 %t612, 1
  %t614 = load i8*, i8** %l0
  %t615 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t616 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t617 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t618 = load i8*, i8** %l4
  %t619 = load i1, i1* %l5
  %t620 = load i1, i1* %l6
  %t621 = load i1, i1* %l7
  %t622 = load i1, i1* %l8
  %t623 = load double, double* %l9
  %t624 = load double, double* %l10
  %t625 = load double, double* %l11
  %t626 = load double, double* %l12
  %t627 = load double, double* %l13
  br i1 %t613, label %then42, label %merge43
then42:
  %t628 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s629 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t630 = call i8* @sailfin_runtime_string_concat(i8* %s629, i8* %enum_name)
  %s631 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h293109504, i32 0, i32 0
  %t632 = call i8* @sailfin_runtime_string_concat(i8* %t630, i8* %s631)
  %t633 = load i8*, i8** %l4
  %t634 = call i8* @sailfin_runtime_string_concat(i8* %t632, i8* %t633)
  %s635 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.len21.h2112628887, i32 0, i32 0
  %t636 = call i8* @sailfin_runtime_string_concat(i8* %t634, i8* %s635)
  %t637 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t628, i8* %t636)
  store { i8**, i64 }* %t637, { i8**, i64 }** %l1
  %t638 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge43
merge43:
  %t639 = phi { i8**, i64 }* [ %t638, %then42 ], [ %t615, %merge41 ]
  store { i8**, i64 }* %t639, { i8**, i64 }** %l1
  %t641 = load i1, i1* %l5
  br label %logical_and_entry_640

logical_and_entry_640:
  br i1 %t641, label %logical_and_right_640, label %logical_and_merge_640

logical_and_right_640:
  %t643 = load i1, i1* %l6
  br label %logical_and_entry_642

logical_and_entry_642:
  br i1 %t643, label %logical_and_right_642, label %logical_and_merge_642

logical_and_right_642:
  %t645 = load i1, i1* %l7
  br label %logical_and_entry_644

logical_and_entry_644:
  br i1 %t645, label %logical_and_right_644, label %logical_and_merge_644

logical_and_right_644:
  %t647 = load i1, i1* %l8
  br label %logical_and_entry_646

logical_and_entry_646:
  br i1 %t647, label %logical_and_right_646, label %logical_and_merge_646

logical_and_right_646:
  %t648 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t649 = load { i8**, i64 }, { i8**, i64 }* %t648
  %t650 = extractvalue { i8**, i64 } %t649, 1
  %t651 = icmp eq i64 %t650, 0
  br label %logical_and_right_end_646

logical_and_right_end_646:
  br label %logical_and_merge_646

logical_and_merge_646:
  %t652 = phi i1 [ false, %logical_and_entry_646 ], [ %t651, %logical_and_right_end_646 ]
  br label %logical_and_right_end_644

logical_and_right_end_644:
  br label %logical_and_merge_644

logical_and_merge_644:
  %t653 = phi i1 [ false, %logical_and_entry_644 ], [ %t652, %logical_and_right_end_644 ]
  br label %logical_and_right_end_642

logical_and_right_end_642:
  br label %logical_and_merge_642

logical_and_merge_642:
  %t654 = phi i1 [ false, %logical_and_entry_642 ], [ %t653, %logical_and_right_end_642 ]
  br label %logical_and_right_end_640

logical_and_right_end_640:
  br label %logical_and_merge_640

logical_and_merge_640:
  %t655 = phi i1 [ false, %logical_and_entry_640 ], [ %t654, %logical_and_right_end_640 ]
  store i1 %t655, i1* %l23
  %t656 = load i8*, i8** %l4
  %t657 = insertvalue %NativeEnumVariantLayout undef, i8* %t656, 0
  %t658 = load double, double* %l9
  %t659 = insertvalue %NativeEnumVariantLayout %t657, double %t658, 1
  %t660 = load double, double* %l10
  %t661 = insertvalue %NativeEnumVariantLayout %t659, double %t660, 2
  %t662 = load double, double* %l11
  %t663 = insertvalue %NativeEnumVariantLayout %t661, double %t662, 3
  %t664 = load double, double* %l12
  %t665 = insertvalue %NativeEnumVariantLayout %t663, double %t664, 4
  %t666 = getelementptr [0 x %NativeStructLayoutField*], [0 x %NativeStructLayoutField*]* null, i32 1
  %t667 = ptrtoint [0 x %NativeStructLayoutField*]* %t666 to i64
  %t668 = icmp eq i64 %t667, 0
  %t669 = select i1 %t668, i64 1, i64 %t667
  %t670 = call i8* @malloc(i64 %t669)
  %t671 = bitcast i8* %t670 to %NativeStructLayoutField**
  %t672 = getelementptr { %NativeStructLayoutField**, i64 }, { %NativeStructLayoutField**, i64 }* null, i32 1
  %t673 = ptrtoint { %NativeStructLayoutField**, i64 }* %t672 to i64
  %t674 = call i8* @malloc(i64 %t673)
  %t675 = bitcast i8* %t674 to { %NativeStructLayoutField**, i64 }*
  %t676 = getelementptr { %NativeStructLayoutField**, i64 }, { %NativeStructLayoutField**, i64 }* %t675, i32 0, i32 0
  store %NativeStructLayoutField** %t671, %NativeStructLayoutField*** %t676
  %t677 = getelementptr { %NativeStructLayoutField**, i64 }, { %NativeStructLayoutField**, i64 }* %t675, i32 0, i32 1
  store i64 0, i64* %t677
  %t678 = insertvalue %NativeEnumVariantLayout %t665, { %NativeStructLayoutField**, i64 }* %t675, 5
  store %NativeEnumVariantLayout %t678, %NativeEnumVariantLayout* %l24
  %t679 = load i1, i1* %l23
  %t680 = insertvalue %EnumLayoutVariantParse undef, i1 %t679, 0
  %t681 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l24
  %t682 = insertvalue %EnumLayoutVariantParse %t680, %NativeEnumVariantLayout %t681, 1
  %t683 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t684 = insertvalue %EnumLayoutVariantParse %t682, { i8**, i64 }* %t683, 2
  ret %EnumLayoutVariantParse %t684
}

define %EnumLayoutPayloadParse @parse_enum_payload_layout(i8* %text, i8* %enum_name) {
block.entry:
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
  %t1 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t2 = ptrtoint [0 x i8*]* %t1 to i64
  %t3 = icmp eq i64 %t2, 0
  %t4 = select i1 %t3, i64 1, i64 %t2
  %t5 = call i8* @malloc(i64 %t4)
  %t6 = bitcast i8* %t5 to i8**
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t8 = ptrtoint { i8**, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { i8**, i64 }*
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 0
  store i8** %t6, i8*** %t11
  %t12 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 1
  store i64 0, i64* %t12
  store { i8**, i64 }* %t10, { i8**, i64 }** %l1
  %s13 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t14 = insertvalue %NativeStructLayoutField undef, i8* %s13, 0
  %s15 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t16 = insertvalue %NativeStructLayoutField %t14, i8* %s15, 1
  %t17 = sitofp i64 0 to double
  %t18 = insertvalue %NativeStructLayoutField %t16, double %t17, 2
  %t19 = sitofp i64 0 to double
  %t20 = insertvalue %NativeStructLayoutField %t18, double %t19, 3
  %t21 = sitofp i64 0 to double
  %t22 = insertvalue %NativeStructLayoutField %t20, double %t21, 4
  store %NativeStructLayoutField %t22, %NativeStructLayoutField* %l2
  %t23 = load i8*, i8** %l0
  %t24 = call i64 @sailfin_runtime_string_length(i8* %t23)
  %t25 = icmp eq i64 %t24, 0
  %t26 = load i8*, i8** %l0
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t28 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  br i1 %t25, label %then0, label %merge1
then0:
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s30 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t31 = call i8* @sailfin_runtime_string_concat(i8* %s30, i8* %enum_name)
  %s32 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.len31.h329133056, i32 0, i32 0
  %t33 = call i8* @sailfin_runtime_string_concat(i8* %t31, i8* %s32)
  %t34 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t29, i8* %t33)
  store { i8**, i64 }* %t34, { i8**, i64 }** %l1
  %t35 = insertvalue %EnumLayoutPayloadParse undef, i1 0, 0
  %s36 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t37 = insertvalue %EnumLayoutPayloadParse %t35, i8* %s36, 1
  %t38 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t39 = insertvalue %EnumLayoutPayloadParse %t37, %NativeStructLayoutField %t38, 2
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t41 = insertvalue %EnumLayoutPayloadParse %t39, { i8**, i64 }* %t40, 3
  ret %EnumLayoutPayloadParse %t41
merge1:
  %t42 = load i8*, i8** %l0
  %t43 = call { i8**, i64 }* @split_whitespace(i8* %t42)
  store { i8**, i64 }* %t43, { i8**, i64 }** %l3
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t45 = load { i8**, i64 }, { i8**, i64 }* %t44
  %t46 = extractvalue { i8**, i64 } %t45, 1
  %t47 = icmp eq i64 %t46, 0
  %t48 = load i8*, i8** %l0
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t50 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l3
  br i1 %t47, label %then2, label %merge3
then2:
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s53 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t54 = call i8* @sailfin_runtime_string_concat(i8* %s53, i8* %enum_name)
  %s55 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.len31.h755263238, i32 0, i32 0
  %t56 = call i8* @sailfin_runtime_string_concat(i8* %t54, i8* %s55)
  %t57 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t52, i8* %t56)
  store { i8**, i64 }* %t57, { i8**, i64 }** %l1
  %t58 = insertvalue %EnumLayoutPayloadParse undef, i1 0, 0
  %s59 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t60 = insertvalue %EnumLayoutPayloadParse %t58, i8* %s59, 1
  %t61 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t62 = insertvalue %EnumLayoutPayloadParse %t60, %NativeStructLayoutField %t61, 2
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t64 = insertvalue %EnumLayoutPayloadParse %t62, { i8**, i64 }* %t63, 3
  ret %EnumLayoutPayloadParse %t64
merge3:
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t66 = load { i8**, i64 }, { i8**, i64 }* %t65
  %t67 = extractvalue { i8**, i64 } %t66, 0
  %t68 = extractvalue { i8**, i64 } %t66, 1
  %t69 = icmp uge i64 0, %t68
  ; bounds check: %t69 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 0, i64 %t68)
  %t70 = getelementptr i8*, i8** %t67, i64 0
  %t71 = load i8*, i8** %t70
  store i8* %t71, i8** %l4
  %t72 = load i8*, i8** %l4
  %t73 = alloca [2 x i8], align 1
  %t74 = getelementptr [2 x i8], [2 x i8]* %t73, i32 0, i32 0
  store i8 46, i8* %t74
  %t75 = getelementptr [2 x i8], [2 x i8]* %t73, i32 0, i32 1
  store i8 0, i8* %t75
  %t76 = getelementptr [2 x i8], [2 x i8]* %t73, i32 0, i32 0
  %t77 = call double @index_of(i8* %t72, i8* %t76)
  store double %t77, double* %l5
  %t79 = load double, double* %l5
  %t80 = sitofp i64 0 to double
  %t81 = fcmp ole double %t79, %t80
  br label %logical_or_entry_78

logical_or_entry_78:
  br i1 %t81, label %logical_or_merge_78, label %logical_or_right_78

logical_or_right_78:
  %t82 = load double, double* %l5
  %t83 = sitofp i64 1 to double
  %t84 = fadd double %t82, %t83
  %t85 = load i8*, i8** %l4
  %t86 = call i64 @sailfin_runtime_string_length(i8* %t85)
  %t87 = sitofp i64 %t86 to double
  %t88 = fcmp oge double %t84, %t87
  br label %logical_or_right_end_78

logical_or_right_end_78:
  br label %logical_or_merge_78

logical_or_merge_78:
  %t89 = phi i1 [ true, %logical_or_entry_78 ], [ %t88, %logical_or_right_end_78 ]
  %t90 = load i8*, i8** %l0
  %t91 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t92 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t94 = load i8*, i8** %l4
  %t95 = load double, double* %l5
  br i1 %t89, label %then4, label %merge5
then4:
  %t96 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s97 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t98 = call i8* @sailfin_runtime_string_concat(i8* %s97, i8* %enum_name)
  %s99 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.len28.h497146076, i32 0, i32 0
  %t100 = call i8* @sailfin_runtime_string_concat(i8* %t98, i8* %s99)
  %t101 = load i8*, i8** %l4
  %t102 = call i8* @sailfin_runtime_string_concat(i8* %t100, i8* %t101)
  %s103 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1123073249, i32 0, i32 0
  %t104 = call i8* @sailfin_runtime_string_concat(i8* %t102, i8* %s103)
  %t105 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t96, i8* %t104)
  store { i8**, i64 }* %t105, { i8**, i64 }** %l1
  %t106 = insertvalue %EnumLayoutPayloadParse undef, i1 0, 0
  %s107 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t108 = insertvalue %EnumLayoutPayloadParse %t106, i8* %s107, 1
  %t109 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t110 = insertvalue %EnumLayoutPayloadParse %t108, %NativeStructLayoutField %t109, 2
  %t111 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t112 = insertvalue %EnumLayoutPayloadParse %t110, { i8**, i64 }* %t111, 3
  ret %EnumLayoutPayloadParse %t112
merge5:
  %t113 = load i8*, i8** %l4
  %t114 = load double, double* %l5
  %t115 = fptosi double %t114 to i64
  %t116 = call i8* @sailfin_runtime_substring(i8* %t113, i64 0, i64 %t115)
  store i8* %t116, i8** %l6
  %t117 = load i8*, i8** %l4
  %t118 = load double, double* %l5
  %t119 = sitofp i64 1 to double
  %t120 = fadd double %t118, %t119
  %t121 = load i8*, i8** %l4
  %t122 = call i64 @sailfin_runtime_string_length(i8* %t121)
  %t123 = fptosi double %t120 to i64
  %t124 = call i8* @sailfin_runtime_substring(i8* %t117, i64 %t123, i64 %t122)
  store i8* %t124, i8** %l7
  %s125 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s125, i8** %l8
  store i1 0, i1* %l9
  store i1 0, i1* %l10
  store i1 0, i1* %l11
  %t126 = sitofp i64 0 to double
  store double %t126, double* %l12
  %t127 = sitofp i64 0 to double
  store double %t127, double* %l13
  %t128 = sitofp i64 0 to double
  store double %t128, double* %l14
  %t129 = sitofp i64 1 to double
  store double %t129, double* %l15
  %t130 = load i8*, i8** %l0
  %t131 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t132 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t133 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t134 = load i8*, i8** %l4
  %t135 = load double, double* %l5
  %t136 = load i8*, i8** %l6
  %t137 = load i8*, i8** %l7
  %t138 = load i8*, i8** %l8
  %t139 = load i1, i1* %l9
  %t140 = load i1, i1* %l10
  %t141 = load i1, i1* %l11
  %t142 = load double, double* %l12
  %t143 = load double, double* %l13
  %t144 = load double, double* %l14
  %t145 = load double, double* %l15
  br label %loop.header6
loop.header6:
  %t501 = phi i8* [ %t138, %merge5 ], [ %t492, %loop.latch8 ]
  %t502 = phi i1 [ %t139, %merge5 ], [ %t493, %loop.latch8 ]
  %t503 = phi double [ %t142, %merge5 ], [ %t494, %loop.latch8 ]
  %t504 = phi { i8**, i64 }* [ %t131, %merge5 ], [ %t495, %loop.latch8 ]
  %t505 = phi i1 [ %t140, %merge5 ], [ %t496, %loop.latch8 ]
  %t506 = phi double [ %t143, %merge5 ], [ %t497, %loop.latch8 ]
  %t507 = phi i1 [ %t141, %merge5 ], [ %t498, %loop.latch8 ]
  %t508 = phi double [ %t144, %merge5 ], [ %t499, %loop.latch8 ]
  %t509 = phi double [ %t145, %merge5 ], [ %t500, %loop.latch8 ]
  store i8* %t501, i8** %l8
  store i1 %t502, i1* %l9
  store double %t503, double* %l12
  store { i8**, i64 }* %t504, { i8**, i64 }** %l1
  store i1 %t505, i1* %l10
  store double %t506, double* %l13
  store i1 %t507, i1* %l11
  store double %t508, double* %l14
  store double %t509, double* %l15
  br label %loop.body7
loop.body7:
  %t146 = load double, double* %l15
  %t147 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t148 = load { i8**, i64 }, { i8**, i64 }* %t147
  %t149 = extractvalue { i8**, i64 } %t148, 1
  %t150 = sitofp i64 %t149 to double
  %t151 = fcmp oge double %t146, %t150
  %t152 = load i8*, i8** %l0
  %t153 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t154 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t155 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t156 = load i8*, i8** %l4
  %t157 = load double, double* %l5
  %t158 = load i8*, i8** %l6
  %t159 = load i8*, i8** %l7
  %t160 = load i8*, i8** %l8
  %t161 = load i1, i1* %l9
  %t162 = load i1, i1* %l10
  %t163 = load i1, i1* %l11
  %t164 = load double, double* %l12
  %t165 = load double, double* %l13
  %t166 = load double, double* %l14
  %t167 = load double, double* %l15
  br i1 %t151, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t168 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t169 = load double, double* %l15
  %t170 = fptosi double %t169 to i64
  %t171 = load { i8**, i64 }, { i8**, i64 }* %t168
  %t172 = extractvalue { i8**, i64 } %t171, 0
  %t173 = extractvalue { i8**, i64 } %t171, 1
  %t174 = icmp uge i64 %t170, %t173
  ; bounds check: %t174 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t170, i64 %t173)
  %t175 = getelementptr i8*, i8** %t172, i64 %t170
  %t176 = load i8*, i8** %t175
  store i8* %t176, i8** %l16
  %t177 = load i8*, i8** %l16
  %s178 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h524431183, i32 0, i32 0
  %t179 = call i1 @starts_with(i8* %t177, i8* %s178)
  %t180 = load i8*, i8** %l0
  %t181 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t182 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t183 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t184 = load i8*, i8** %l4
  %t185 = load double, double* %l5
  %t186 = load i8*, i8** %l6
  %t187 = load i8*, i8** %l7
  %t188 = load i8*, i8** %l8
  %t189 = load i1, i1* %l9
  %t190 = load i1, i1* %l10
  %t191 = load i1, i1* %l11
  %t192 = load double, double* %l12
  %t193 = load double, double* %l13
  %t194 = load double, double* %l14
  %t195 = load double, double* %l15
  %t196 = load i8*, i8** %l16
  br i1 %t179, label %then12, label %else13
then12:
  %t197 = load i8*, i8** %l16
  %t198 = load i8*, i8** %l16
  %t199 = call i64 @sailfin_runtime_string_length(i8* %t198)
  %t200 = call i8* @sailfin_runtime_substring(i8* %t197, i64 5, i64 %t199)
  store i8* %t200, i8** %l8
  %t201 = load i8*, i8** %l8
  br label %merge14
else13:
  %t202 = load i8*, i8** %l16
  %s203 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h242296049, i32 0, i32 0
  %t204 = call i1 @starts_with(i8* %t202, i8* %s203)
  %t205 = load i8*, i8** %l0
  %t206 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t207 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t208 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t209 = load i8*, i8** %l4
  %t210 = load double, double* %l5
  %t211 = load i8*, i8** %l6
  %t212 = load i8*, i8** %l7
  %t213 = load i8*, i8** %l8
  %t214 = load i1, i1* %l9
  %t215 = load i1, i1* %l10
  %t216 = load i1, i1* %l11
  %t217 = load double, double* %l12
  %t218 = load double, double* %l13
  %t219 = load double, double* %l14
  %t220 = load double, double* %l15
  %t221 = load i8*, i8** %l16
  br i1 %t204, label %then15, label %else16
then15:
  %t222 = load i8*, i8** %l16
  %t223 = load i8*, i8** %l16
  %t224 = call i64 @sailfin_runtime_string_length(i8* %t223)
  %t225 = call i8* @sailfin_runtime_substring(i8* %t222, i64 7, i64 %t224)
  store i8* %t225, i8** %l17
  %t226 = load i8*, i8** %l17
  %t227 = call %NumberParseResult @parse_decimal_number(i8* %t226)
  store %NumberParseResult %t227, %NumberParseResult* %l18
  %t228 = load %NumberParseResult, %NumberParseResult* %l18
  %t229 = extractvalue %NumberParseResult %t228, 0
  %t230 = load i8*, i8** %l0
  %t231 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t232 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t233 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t234 = load i8*, i8** %l4
  %t235 = load double, double* %l5
  %t236 = load i8*, i8** %l6
  %t237 = load i8*, i8** %l7
  %t238 = load i8*, i8** %l8
  %t239 = load i1, i1* %l9
  %t240 = load i1, i1* %l10
  %t241 = load i1, i1* %l11
  %t242 = load double, double* %l12
  %t243 = load double, double* %l13
  %t244 = load double, double* %l14
  %t245 = load double, double* %l15
  %t246 = load i8*, i8** %l16
  %t247 = load i8*, i8** %l17
  %t248 = load %NumberParseResult, %NumberParseResult* %l18
  br i1 %t229, label %then18, label %else19
then18:
  store i1 1, i1* %l9
  %t249 = load %NumberParseResult, %NumberParseResult* %l18
  %t250 = extractvalue %NumberParseResult %t249, 1
  store double %t250, double* %l12
  %t251 = load i1, i1* %l9
  %t252 = load double, double* %l12
  br label %merge20
else19:
  %t253 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s254 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t255 = call i8* @sailfin_runtime_string_concat(i8* %s254, i8* %enum_name)
  %s256 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1973869273, i32 0, i32 0
  %t257 = call i8* @sailfin_runtime_string_concat(i8* %t255, i8* %s256)
  %t258 = load i8*, i8** %l4
  %t259 = call i8* @sailfin_runtime_string_concat(i8* %t257, i8* %t258)
  %s260 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h24304067, i32 0, i32 0
  %t261 = call i8* @sailfin_runtime_string_concat(i8* %t259, i8* %s260)
  %t262 = load i8*, i8** %l17
  %t263 = call i8* @sailfin_runtime_string_concat(i8* %t261, i8* %t262)
  %t264 = alloca [2 x i8], align 1
  %t265 = getelementptr [2 x i8], [2 x i8]* %t264, i32 0, i32 0
  store i8 96, i8* %t265
  %t266 = getelementptr [2 x i8], [2 x i8]* %t264, i32 0, i32 1
  store i8 0, i8* %t266
  %t267 = getelementptr [2 x i8], [2 x i8]* %t264, i32 0, i32 0
  %t268 = call i8* @sailfin_runtime_string_concat(i8* %t263, i8* %t267)
  %t269 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t253, i8* %t268)
  store { i8**, i64 }* %t269, { i8**, i64 }** %l1
  %t270 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge20
merge20:
  %t271 = phi i1 [ %t251, %then18 ], [ %t239, %else19 ]
  %t272 = phi double [ %t252, %then18 ], [ %t242, %else19 ]
  %t273 = phi { i8**, i64 }* [ %t231, %then18 ], [ %t270, %else19 ]
  store i1 %t271, i1* %l9
  store double %t272, double* %l12
  store { i8**, i64 }* %t273, { i8**, i64 }** %l1
  %t274 = load i1, i1* %l9
  %t275 = load double, double* %l12
  %t276 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge17
else16:
  %t277 = load i8*, i8** %l16
  %s278 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h466680424, i32 0, i32 0
  %t279 = call i1 @starts_with(i8* %t277, i8* %s278)
  %t280 = load i8*, i8** %l0
  %t281 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t282 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t283 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t284 = load i8*, i8** %l4
  %t285 = load double, double* %l5
  %t286 = load i8*, i8** %l6
  %t287 = load i8*, i8** %l7
  %t288 = load i8*, i8** %l8
  %t289 = load i1, i1* %l9
  %t290 = load i1, i1* %l10
  %t291 = load i1, i1* %l11
  %t292 = load double, double* %l12
  %t293 = load double, double* %l13
  %t294 = load double, double* %l14
  %t295 = load double, double* %l15
  %t296 = load i8*, i8** %l16
  br i1 %t279, label %then21, label %else22
then21:
  %t297 = load i8*, i8** %l16
  %t298 = load i8*, i8** %l16
  %t299 = call i64 @sailfin_runtime_string_length(i8* %t298)
  %t300 = call i8* @sailfin_runtime_substring(i8* %t297, i64 5, i64 %t299)
  store i8* %t300, i8** %l19
  %t301 = load i8*, i8** %l19
  %t302 = call %NumberParseResult @parse_decimal_number(i8* %t301)
  store %NumberParseResult %t302, %NumberParseResult* %l20
  %t303 = load %NumberParseResult, %NumberParseResult* %l20
  %t304 = extractvalue %NumberParseResult %t303, 0
  %t305 = load i8*, i8** %l0
  %t306 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t307 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t308 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t309 = load i8*, i8** %l4
  %t310 = load double, double* %l5
  %t311 = load i8*, i8** %l6
  %t312 = load i8*, i8** %l7
  %t313 = load i8*, i8** %l8
  %t314 = load i1, i1* %l9
  %t315 = load i1, i1* %l10
  %t316 = load i1, i1* %l11
  %t317 = load double, double* %l12
  %t318 = load double, double* %l13
  %t319 = load double, double* %l14
  %t320 = load double, double* %l15
  %t321 = load i8*, i8** %l16
  %t322 = load i8*, i8** %l19
  %t323 = load %NumberParseResult, %NumberParseResult* %l20
  br i1 %t304, label %then24, label %else25
then24:
  store i1 1, i1* %l10
  %t324 = load %NumberParseResult, %NumberParseResult* %l20
  %t325 = extractvalue %NumberParseResult %t324, 1
  store double %t325, double* %l13
  %t326 = load i1, i1* %l10
  %t327 = load double, double* %l13
  br label %merge26
else25:
  %t328 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s329 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t330 = call i8* @sailfin_runtime_string_concat(i8* %s329, i8* %enum_name)
  %s331 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1973869273, i32 0, i32 0
  %t332 = call i8* @sailfin_runtime_string_concat(i8* %t330, i8* %s331)
  %t333 = load i8*, i8** %l4
  %t334 = call i8* @sailfin_runtime_string_concat(i8* %t332, i8* %t333)
  %s335 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h151690315, i32 0, i32 0
  %t336 = call i8* @sailfin_runtime_string_concat(i8* %t334, i8* %s335)
  %t337 = load i8*, i8** %l19
  %t338 = call i8* @sailfin_runtime_string_concat(i8* %t336, i8* %t337)
  %t339 = alloca [2 x i8], align 1
  %t340 = getelementptr [2 x i8], [2 x i8]* %t339, i32 0, i32 0
  store i8 96, i8* %t340
  %t341 = getelementptr [2 x i8], [2 x i8]* %t339, i32 0, i32 1
  store i8 0, i8* %t341
  %t342 = getelementptr [2 x i8], [2 x i8]* %t339, i32 0, i32 0
  %t343 = call i8* @sailfin_runtime_string_concat(i8* %t338, i8* %t342)
  %t344 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t328, i8* %t343)
  store { i8**, i64 }* %t344, { i8**, i64 }** %l1
  %t345 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge26
merge26:
  %t346 = phi i1 [ %t326, %then24 ], [ %t315, %else25 ]
  %t347 = phi double [ %t327, %then24 ], [ %t318, %else25 ]
  %t348 = phi { i8**, i64 }* [ %t306, %then24 ], [ %t345, %else25 ]
  store i1 %t346, i1* %l10
  store double %t347, double* %l13
  store { i8**, i64 }* %t348, { i8**, i64 }** %l1
  %t349 = load i1, i1* %l10
  %t350 = load double, double* %l13
  %t351 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge23
else22:
  %t352 = load i8*, i8** %l16
  %s353 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h841337749, i32 0, i32 0
  %t354 = call i1 @starts_with(i8* %t352, i8* %s353)
  %t355 = load i8*, i8** %l0
  %t356 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t357 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t358 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t359 = load i8*, i8** %l4
  %t360 = load double, double* %l5
  %t361 = load i8*, i8** %l6
  %t362 = load i8*, i8** %l7
  %t363 = load i8*, i8** %l8
  %t364 = load i1, i1* %l9
  %t365 = load i1, i1* %l10
  %t366 = load i1, i1* %l11
  %t367 = load double, double* %l12
  %t368 = load double, double* %l13
  %t369 = load double, double* %l14
  %t370 = load double, double* %l15
  %t371 = load i8*, i8** %l16
  br i1 %t354, label %then27, label %else28
then27:
  %t372 = load i8*, i8** %l16
  %t373 = load i8*, i8** %l16
  %t374 = call i64 @sailfin_runtime_string_length(i8* %t373)
  %t375 = call i8* @sailfin_runtime_substring(i8* %t372, i64 6, i64 %t374)
  store i8* %t375, i8** %l21
  %t376 = load i8*, i8** %l21
  %t377 = call %NumberParseResult @parse_decimal_number(i8* %t376)
  store %NumberParseResult %t377, %NumberParseResult* %l22
  %t378 = load %NumberParseResult, %NumberParseResult* %l22
  %t379 = extractvalue %NumberParseResult %t378, 0
  %t380 = load i8*, i8** %l0
  %t381 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t382 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t383 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t384 = load i8*, i8** %l4
  %t385 = load double, double* %l5
  %t386 = load i8*, i8** %l6
  %t387 = load i8*, i8** %l7
  %t388 = load i8*, i8** %l8
  %t389 = load i1, i1* %l9
  %t390 = load i1, i1* %l10
  %t391 = load i1, i1* %l11
  %t392 = load double, double* %l12
  %t393 = load double, double* %l13
  %t394 = load double, double* %l14
  %t395 = load double, double* %l15
  %t396 = load i8*, i8** %l16
  %t397 = load i8*, i8** %l21
  %t398 = load %NumberParseResult, %NumberParseResult* %l22
  br i1 %t379, label %then30, label %else31
then30:
  store i1 1, i1* %l11
  %t399 = load %NumberParseResult, %NumberParseResult* %l22
  %t400 = extractvalue %NumberParseResult %t399, 1
  store double %t400, double* %l14
  %t401 = load i1, i1* %l11
  %t402 = load double, double* %l14
  br label %merge32
else31:
  %t403 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s404 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t405 = call i8* @sailfin_runtime_string_concat(i8* %s404, i8* %enum_name)
  %s406 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1973869273, i32 0, i32 0
  %t407 = call i8* @sailfin_runtime_string_concat(i8* %t405, i8* %s406)
  %t408 = load i8*, i8** %l4
  %t409 = call i8* @sailfin_runtime_string_concat(i8* %t407, i8* %t408)
  %s410 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.len21.h1297227834, i32 0, i32 0
  %t411 = call i8* @sailfin_runtime_string_concat(i8* %t409, i8* %s410)
  %t412 = load i8*, i8** %l21
  %t413 = call i8* @sailfin_runtime_string_concat(i8* %t411, i8* %t412)
  %t414 = alloca [2 x i8], align 1
  %t415 = getelementptr [2 x i8], [2 x i8]* %t414, i32 0, i32 0
  store i8 96, i8* %t415
  %t416 = getelementptr [2 x i8], [2 x i8]* %t414, i32 0, i32 1
  store i8 0, i8* %t416
  %t417 = getelementptr [2 x i8], [2 x i8]* %t414, i32 0, i32 0
  %t418 = call i8* @sailfin_runtime_string_concat(i8* %t413, i8* %t417)
  %t419 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t403, i8* %t418)
  store { i8**, i64 }* %t419, { i8**, i64 }** %l1
  %t420 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge32
merge32:
  %t421 = phi i1 [ %t401, %then30 ], [ %t391, %else31 ]
  %t422 = phi double [ %t402, %then30 ], [ %t394, %else31 ]
  %t423 = phi { i8**, i64 }* [ %t381, %then30 ], [ %t420, %else31 ]
  store i1 %t421, i1* %l11
  store double %t422, double* %l14
  store { i8**, i64 }* %t423, { i8**, i64 }** %l1
  %t424 = load i1, i1* %l11
  %t425 = load double, double* %l14
  %t426 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge29
else28:
  %t427 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s428 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t429 = call i8* @sailfin_runtime_string_concat(i8* %s428, i8* %enum_name)
  %s430 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1973869273, i32 0, i32 0
  %t431 = call i8* @sailfin_runtime_string_concat(i8* %t429, i8* %s430)
  %t432 = load i8*, i8** %l4
  %t433 = call i8* @sailfin_runtime_string_concat(i8* %t431, i8* %t432)
  %s434 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h496289716, i32 0, i32 0
  %t435 = call i8* @sailfin_runtime_string_concat(i8* %t433, i8* %s434)
  %t436 = load i8*, i8** %l16
  %t437 = call i8* @sailfin_runtime_string_concat(i8* %t435, i8* %t436)
  %t438 = alloca [2 x i8], align 1
  %t439 = getelementptr [2 x i8], [2 x i8]* %t438, i32 0, i32 0
  store i8 96, i8* %t439
  %t440 = getelementptr [2 x i8], [2 x i8]* %t438, i32 0, i32 1
  store i8 0, i8* %t440
  %t441 = getelementptr [2 x i8], [2 x i8]* %t438, i32 0, i32 0
  %t442 = call i8* @sailfin_runtime_string_concat(i8* %t437, i8* %t441)
  %t443 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t427, i8* %t442)
  store { i8**, i64 }* %t443, { i8**, i64 }** %l1
  %t444 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge29
merge29:
  %t445 = phi i1 [ %t424, %merge32 ], [ %t366, %else28 ]
  %t446 = phi double [ %t425, %merge32 ], [ %t369, %else28 ]
  %t447 = phi { i8**, i64 }* [ %t426, %merge32 ], [ %t444, %else28 ]
  store i1 %t445, i1* %l11
  store double %t446, double* %l14
  store { i8**, i64 }* %t447, { i8**, i64 }** %l1
  %t448 = load i1, i1* %l11
  %t449 = load double, double* %l14
  %t450 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t451 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge23
merge23:
  %t452 = phi i1 [ %t349, %merge26 ], [ %t290, %merge29 ]
  %t453 = phi double [ %t350, %merge26 ], [ %t293, %merge29 ]
  %t454 = phi { i8**, i64 }* [ %t351, %merge26 ], [ %t450, %merge29 ]
  %t455 = phi i1 [ %t291, %merge26 ], [ %t448, %merge29 ]
  %t456 = phi double [ %t294, %merge26 ], [ %t449, %merge29 ]
  store i1 %t452, i1* %l10
  store double %t453, double* %l13
  store { i8**, i64 }* %t454, { i8**, i64 }** %l1
  store i1 %t455, i1* %l11
  store double %t456, double* %l14
  %t457 = load i1, i1* %l10
  %t458 = load double, double* %l13
  %t459 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t460 = load i1, i1* %l11
  %t461 = load double, double* %l14
  %t462 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t463 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge17
merge17:
  %t464 = phi i1 [ %t274, %merge20 ], [ %t214, %merge23 ]
  %t465 = phi double [ %t275, %merge20 ], [ %t217, %merge23 ]
  %t466 = phi { i8**, i64 }* [ %t276, %merge20 ], [ %t459, %merge23 ]
  %t467 = phi i1 [ %t215, %merge20 ], [ %t457, %merge23 ]
  %t468 = phi double [ %t218, %merge20 ], [ %t458, %merge23 ]
  %t469 = phi i1 [ %t216, %merge20 ], [ %t460, %merge23 ]
  %t470 = phi double [ %t219, %merge20 ], [ %t461, %merge23 ]
  store i1 %t464, i1* %l9
  store double %t465, double* %l12
  store { i8**, i64 }* %t466, { i8**, i64 }** %l1
  store i1 %t467, i1* %l10
  store double %t468, double* %l13
  store i1 %t469, i1* %l11
  store double %t470, double* %l14
  %t471 = load i1, i1* %l9
  %t472 = load double, double* %l12
  %t473 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t474 = load i1, i1* %l10
  %t475 = load double, double* %l13
  %t476 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t477 = load i1, i1* %l11
  %t478 = load double, double* %l14
  %t479 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t480 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge14
merge14:
  %t481 = phi i8* [ %t201, %then12 ], [ %t188, %merge17 ]
  %t482 = phi i1 [ %t189, %then12 ], [ %t471, %merge17 ]
  %t483 = phi double [ %t192, %then12 ], [ %t472, %merge17 ]
  %t484 = phi { i8**, i64 }* [ %t181, %then12 ], [ %t473, %merge17 ]
  %t485 = phi i1 [ %t190, %then12 ], [ %t474, %merge17 ]
  %t486 = phi double [ %t193, %then12 ], [ %t475, %merge17 ]
  %t487 = phi i1 [ %t191, %then12 ], [ %t477, %merge17 ]
  %t488 = phi double [ %t194, %then12 ], [ %t478, %merge17 ]
  store i8* %t481, i8** %l8
  store i1 %t482, i1* %l9
  store double %t483, double* %l12
  store { i8**, i64 }* %t484, { i8**, i64 }** %l1
  store i1 %t485, i1* %l10
  store double %t486, double* %l13
  store i1 %t487, i1* %l11
  store double %t488, double* %l14
  %t489 = load double, double* %l15
  %t490 = sitofp i64 1 to double
  %t491 = fadd double %t489, %t490
  store double %t491, double* %l15
  br label %loop.latch8
loop.latch8:
  %t492 = load i8*, i8** %l8
  %t493 = load i1, i1* %l9
  %t494 = load double, double* %l12
  %t495 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t496 = load i1, i1* %l10
  %t497 = load double, double* %l13
  %t498 = load i1, i1* %l11
  %t499 = load double, double* %l14
  %t500 = load double, double* %l15
  br label %loop.header6
afterloop9:
  %t510 = load i8*, i8** %l8
  %t511 = load i1, i1* %l9
  %t512 = load double, double* %l12
  %t513 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t514 = load i1, i1* %l10
  %t515 = load double, double* %l13
  %t516 = load i1, i1* %l11
  %t517 = load double, double* %l14
  %t518 = load double, double* %l15
  %t519 = load i8*, i8** %l8
  %t520 = call i64 @sailfin_runtime_string_length(i8* %t519)
  %t521 = icmp eq i64 %t520, 0
  %t522 = load i8*, i8** %l0
  %t523 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t524 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t525 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t526 = load i8*, i8** %l4
  %t527 = load double, double* %l5
  %t528 = load i8*, i8** %l6
  %t529 = load i8*, i8** %l7
  %t530 = load i8*, i8** %l8
  %t531 = load i1, i1* %l9
  %t532 = load i1, i1* %l10
  %t533 = load i1, i1* %l11
  %t534 = load double, double* %l12
  %t535 = load double, double* %l13
  %t536 = load double, double* %l14
  %t537 = load double, double* %l15
  br i1 %t521, label %then33, label %merge34
then33:
  %t538 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s539 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t540 = call i8* @sailfin_runtime_string_concat(i8* %s539, i8* %enum_name)
  %s541 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1973869273, i32 0, i32 0
  %t542 = call i8* @sailfin_runtime_string_concat(i8* %t540, i8* %s541)
  %t543 = load i8*, i8** %l4
  %t544 = call i8* @sailfin_runtime_string_concat(i8* %t542, i8* %t543)
  %s545 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h1568429285, i32 0, i32 0
  %t546 = call i8* @sailfin_runtime_string_concat(i8* %t544, i8* %s545)
  %t547 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t538, i8* %t546)
  store { i8**, i64 }* %t547, { i8**, i64 }** %l1
  %t548 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge34
merge34:
  %t549 = phi { i8**, i64 }* [ %t548, %then33 ], [ %t523, %afterloop9 ]
  store { i8**, i64 }* %t549, { i8**, i64 }** %l1
  %t550 = load i1, i1* %l9
  %t551 = xor i1 %t550, 1
  %t552 = load i8*, i8** %l0
  %t553 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t554 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t555 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t556 = load i8*, i8** %l4
  %t557 = load double, double* %l5
  %t558 = load i8*, i8** %l6
  %t559 = load i8*, i8** %l7
  %t560 = load i8*, i8** %l8
  %t561 = load i1, i1* %l9
  %t562 = load i1, i1* %l10
  %t563 = load i1, i1* %l11
  %t564 = load double, double* %l12
  %t565 = load double, double* %l13
  %t566 = load double, double* %l14
  %t567 = load double, double* %l15
  br i1 %t551, label %then35, label %merge36
then35:
  %t568 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s569 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t570 = call i8* @sailfin_runtime_string_concat(i8* %s569, i8* %enum_name)
  %s571 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1973869273, i32 0, i32 0
  %t572 = call i8* @sailfin_runtime_string_concat(i8* %t570, i8* %s571)
  %t573 = load i8*, i8** %l4
  %t574 = call i8* @sailfin_runtime_string_concat(i8* %t572, i8* %t573)
  %s575 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h625556084, i32 0, i32 0
  %t576 = call i8* @sailfin_runtime_string_concat(i8* %t574, i8* %s575)
  %t577 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t568, i8* %t576)
  store { i8**, i64 }* %t577, { i8**, i64 }** %l1
  %t578 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge36
merge36:
  %t579 = phi { i8**, i64 }* [ %t578, %then35 ], [ %t553, %merge34 ]
  store { i8**, i64 }* %t579, { i8**, i64 }** %l1
  %t580 = load i1, i1* %l10
  %t581 = xor i1 %t580, 1
  %t582 = load i8*, i8** %l0
  %t583 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t584 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t585 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t586 = load i8*, i8** %l4
  %t587 = load double, double* %l5
  %t588 = load i8*, i8** %l6
  %t589 = load i8*, i8** %l7
  %t590 = load i8*, i8** %l8
  %t591 = load i1, i1* %l9
  %t592 = load i1, i1* %l10
  %t593 = load i1, i1* %l11
  %t594 = load double, double* %l12
  %t595 = load double, double* %l13
  %t596 = load double, double* %l14
  %t597 = load double, double* %l15
  br i1 %t581, label %then37, label %merge38
then37:
  %t598 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s599 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t600 = call i8* @sailfin_runtime_string_concat(i8* %s599, i8* %enum_name)
  %s601 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1973869273, i32 0, i32 0
  %t602 = call i8* @sailfin_runtime_string_concat(i8* %t600, i8* %s601)
  %t603 = load i8*, i8** %l4
  %t604 = call i8* @sailfin_runtime_string_concat(i8* %t602, i8* %t603)
  %s605 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h608364678, i32 0, i32 0
  %t606 = call i8* @sailfin_runtime_string_concat(i8* %t604, i8* %s605)
  %t607 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t598, i8* %t606)
  store { i8**, i64 }* %t607, { i8**, i64 }** %l1
  %t608 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge38
merge38:
  %t609 = phi { i8**, i64 }* [ %t608, %then37 ], [ %t583, %merge36 ]
  store { i8**, i64 }* %t609, { i8**, i64 }** %l1
  %t610 = load i1, i1* %l11
  %t611 = xor i1 %t610, 1
  %t612 = load i8*, i8** %l0
  %t613 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t614 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t615 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t616 = load i8*, i8** %l4
  %t617 = load double, double* %l5
  %t618 = load i8*, i8** %l6
  %t619 = load i8*, i8** %l7
  %t620 = load i8*, i8** %l8
  %t621 = load i1, i1* %l9
  %t622 = load i1, i1* %l10
  %t623 = load i1, i1* %l11
  %t624 = load double, double* %l12
  %t625 = load double, double* %l13
  %t626 = load double, double* %l14
  %t627 = load double, double* %l15
  br i1 %t611, label %then39, label %merge40
then39:
  %t628 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s629 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t630 = call i8* @sailfin_runtime_string_concat(i8* %s629, i8* %enum_name)
  %s631 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1973869273, i32 0, i32 0
  %t632 = call i8* @sailfin_runtime_string_concat(i8* %t630, i8* %s631)
  %t633 = load i8*, i8** %l4
  %t634 = call i8* @sailfin_runtime_string_concat(i8* %t632, i8* %t633)
  %s635 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.len21.h2112628887, i32 0, i32 0
  %t636 = call i8* @sailfin_runtime_string_concat(i8* %t634, i8* %s635)
  %t637 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t628, i8* %t636)
  store { i8**, i64 }* %t637, { i8**, i64 }** %l1
  %t638 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge40
merge40:
  %t639 = phi { i8**, i64 }* [ %t638, %then39 ], [ %t613, %merge38 ]
  store { i8**, i64 }* %t639, { i8**, i64 }** %l1
  %t641 = load i8*, i8** %l8
  %t642 = call i64 @sailfin_runtime_string_length(i8* %t641)
  %t643 = icmp sgt i64 %t642, 0
  br label %logical_and_entry_640

logical_and_entry_640:
  br i1 %t643, label %logical_and_right_640, label %logical_and_merge_640

logical_and_right_640:
  %t645 = load i1, i1* %l9
  br label %logical_and_entry_644

logical_and_entry_644:
  br i1 %t645, label %logical_and_right_644, label %logical_and_merge_644

logical_and_right_644:
  %t647 = load i1, i1* %l10
  br label %logical_and_entry_646

logical_and_entry_646:
  br i1 %t647, label %logical_and_right_646, label %logical_and_merge_646

logical_and_right_646:
  %t649 = load i1, i1* %l11
  br label %logical_and_entry_648

logical_and_entry_648:
  br i1 %t649, label %logical_and_right_648, label %logical_and_merge_648

logical_and_right_648:
  %t650 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t651 = load { i8**, i64 }, { i8**, i64 }* %t650
  %t652 = extractvalue { i8**, i64 } %t651, 1
  %t653 = icmp eq i64 %t652, 0
  br label %logical_and_right_end_648

logical_and_right_end_648:
  br label %logical_and_merge_648

logical_and_merge_648:
  %t654 = phi i1 [ false, %logical_and_entry_648 ], [ %t653, %logical_and_right_end_648 ]
  br label %logical_and_right_end_646

logical_and_right_end_646:
  br label %logical_and_merge_646

logical_and_merge_646:
  %t655 = phi i1 [ false, %logical_and_entry_646 ], [ %t654, %logical_and_right_end_646 ]
  br label %logical_and_right_end_644

logical_and_right_end_644:
  br label %logical_and_merge_644

logical_and_merge_644:
  %t656 = phi i1 [ false, %logical_and_entry_644 ], [ %t655, %logical_and_right_end_644 ]
  br label %logical_and_right_end_640

logical_and_right_end_640:
  br label %logical_and_merge_640

logical_and_merge_640:
  %t657 = phi i1 [ false, %logical_and_entry_640 ], [ %t656, %logical_and_right_end_640 ]
  store i1 %t657, i1* %l23
  %t658 = load i8*, i8** %l7
  %t659 = insertvalue %NativeStructLayoutField undef, i8* %t658, 0
  %t660 = load i8*, i8** %l8
  %t661 = insertvalue %NativeStructLayoutField %t659, i8* %t660, 1
  %t662 = load double, double* %l12
  %t663 = insertvalue %NativeStructLayoutField %t661, double %t662, 2
  %t664 = load double, double* %l13
  %t665 = insertvalue %NativeStructLayoutField %t663, double %t664, 3
  %t666 = load double, double* %l14
  %t667 = insertvalue %NativeStructLayoutField %t665, double %t666, 4
  store %NativeStructLayoutField %t667, %NativeStructLayoutField* %l24
  %t668 = load i1, i1* %l23
  %t669 = insertvalue %EnumLayoutPayloadParse undef, i1 %t668, 0
  %t670 = load i8*, i8** %l6
  %t671 = insertvalue %EnumLayoutPayloadParse %t669, i8* %t670, 1
  %t672 = load %NativeStructLayoutField, %NativeStructLayoutField* %l24
  %t673 = insertvalue %EnumLayoutPayloadParse %t671, %NativeStructLayoutField %t672, 2
  %t674 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t675 = insertvalue %EnumLayoutPayloadParse %t673, { i8**, i64 }* %t674, 3
  ret %EnumLayoutPayloadParse %t675
}

define %NativeInstruction @parse_let_instruction(i8* %line, %NativeSourceSpan* %span, %NativeSourceSpan* %value_span) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i1
  %l2 = alloca i8*
  %l3 = alloca %BindingComponents
  %s0 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2064124065, i32 0, i32 0
  %t1 = call i8* @strip_prefix(i8* %line, i8* %s0)
  %t2 = call i8* @trim_text(i8* %t1)
  store i8* %t2, i8** %l0
  store i1 0, i1* %l1
  %t3 = load i8*, i8** %l0
  store i8* %t3, i8** %l2
  %t4 = load i8*, i8** %l2
  %s5 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t6 = call i1 @starts_with(i8* %t4, i8* %s5)
  %t7 = load i8*, i8** %l0
  %t8 = load i1, i1* %l1
  %t9 = load i8*, i8** %l2
  br i1 %t6, label %then0, label %merge1
then0:
  store i1 1, i1* %l1
  %t10 = load i8*, i8** %l2
  %s11 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t12 = call i8* @strip_prefix(i8* %t10, i8* %s11)
  %t13 = call i8* @trim_text(i8* %t12)
  store i8* %t13, i8** %l2
  %t14 = load i1, i1* %l1
  %t15 = load i8*, i8** %l2
  br label %merge1
merge1:
  %t16 = phi i1 [ %t14, %then0 ], [ %t8, %block.entry ]
  %t17 = phi i8* [ %t15, %then0 ], [ %t9, %block.entry ]
  store i1 %t16, i1* %l1
  store i8* %t17, i8** %l2
  %t18 = load i8*, i8** %l2
  %t19 = call %BindingComponents @parse_binding_components(i8* %t18)
  store %BindingComponents %t19, %BindingComponents* %l3
  %t20 = alloca %NativeInstruction
  %t21 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t20, i32 0, i32 0
  store i32 2, i32* %t21
  %t22 = load %BindingComponents, %BindingComponents* %l3
  %t23 = extractvalue %BindingComponents %t22, 0
  %t24 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t20, i32 0, i32 1
  %t25 = bitcast [48 x i8]* %t24 to i8*
  %t26 = bitcast i8* %t25 to i8**
  store i8* %t23, i8** %t26
  %t27 = load i1, i1* %l1
  %t28 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t20, i32 0, i32 1
  %t29 = bitcast [48 x i8]* %t28 to i8*
  %t30 = getelementptr inbounds i8, i8* %t29, i64 8
  %t31 = bitcast i8* %t30 to i1*
  store i1 %t27, i1* %t31
  %t32 = load %BindingComponents, %BindingComponents* %l3
  %t33 = extractvalue %BindingComponents %t32, 1
  %t34 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t20, i32 0, i32 1
  %t35 = bitcast [48 x i8]* %t34 to i8*
  %t36 = getelementptr inbounds i8, i8* %t35, i64 16
  %t37 = bitcast i8* %t36 to i8**
  store i8* %t33, i8** %t37
  %t38 = load %BindingComponents, %BindingComponents* %l3
  %t39 = extractvalue %BindingComponents %t38, 2
  %t40 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t20, i32 0, i32 1
  %t41 = bitcast [48 x i8]* %t40 to i8*
  %t42 = getelementptr inbounds i8, i8* %t41, i64 24
  %t43 = bitcast i8* %t42 to i8**
  store i8* %t39, i8** %t43
  %t44 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t20, i32 0, i32 1
  %t45 = bitcast [48 x i8]* %t44 to i8*
  %t46 = getelementptr inbounds i8, i8* %t45, i64 32
  %t47 = bitcast i8* %t46 to %NativeSourceSpan**
  store %NativeSourceSpan* %span, %NativeSourceSpan** %t47
  %t48 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t20, i32 0, i32 1
  %t49 = bitcast [48 x i8]* %t48 to i8*
  %t50 = getelementptr inbounds i8, i8* %t49, i64 40
  %t51 = bitcast i8* %t50 to %NativeSourceSpan**
  store %NativeSourceSpan* %value_span, %NativeSourceSpan** %t51
  %t52 = load %NativeInstruction, %NativeInstruction* %t20
  ret %NativeInstruction %t52
}

define %BindingComponents @parse_binding_components(i8* %text) {
block.entry:
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
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = load i8*, i8** %l0
  %t3 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t39 = phi i8* [ %t2, %block.entry ], [ %t37, %loop.latch2 ]
  %t40 = phi double [ %t3, %block.entry ], [ %t38, %loop.latch2 ]
  store i8* %t39, i8** %l0
  store double %t40, double* %l1
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
  %t29 = alloca [2 x i8], align 1
  %t30 = getelementptr [2 x i8], [2 x i8]* %t29, i32 0, i32 0
  store i8 %t28, i8* %t30
  %t31 = getelementptr [2 x i8], [2 x i8]* %t29, i32 0, i32 1
  store i8 0, i8* %t31
  %t32 = getelementptr [2 x i8], [2 x i8]* %t29, i32 0, i32 0
  %t33 = call i8* @sailfin_runtime_string_concat(i8* %t27, i8* %t32)
  store i8* %t33, i8** %l0
  %t34 = load double, double* %l1
  %t35 = sitofp i64 1 to double
  %t36 = fadd double %t34, %t35
  store double %t36, double* %l1
  br label %loop.latch2
loop.latch2:
  %t37 = load i8*, i8** %l0
  %t38 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t41 = load i8*, i8** %l0
  %t42 = load double, double* %l1
  %t43 = load i8*, i8** %l0
  %t44 = call i8* @trim_text(i8* %t43)
  store i8* %t44, i8** %l0
  %s45 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
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
  %s60 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193428050, i32 0, i32 0
  %t61 = call i1 @starts_with(i8* %t59, i8* %s60)
  %t62 = load i8*, i8** %l0
  %t63 = load double, double* %l1
  %t64 = load i8*, i8** %l3
  %t65 = load i8*, i8** %l4
  %t66 = load i8*, i8** %l5
  br i1 %t61, label %then10, label %else11
then10:
  %t67 = load i8*, i8** %l5
  %s68 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193428050, i32 0, i32 0
  %t69 = call i8* @strip_prefix(i8* %t67, i8* %s68)
  %t70 = call i8* @trim_text(i8* %t69)
  store i8* %t70, i8** %l5
  %t71 = load i8*, i8** %l5
  %t72 = alloca [2 x i8], align 1
  %t73 = getelementptr [2 x i8], [2 x i8]* %t72, i32 0, i32 0
  store i8 61, i8* %t73
  %t74 = getelementptr [2 x i8], [2 x i8]* %t72, i32 0, i32 1
  store i8 0, i8* %t74
  %t75 = getelementptr [2 x i8], [2 x i8]* %t72, i32 0, i32 0
  %t76 = call double @index_of(i8* %t71, i8* %t75)
  store double %t76, double* %l6
  %t77 = load double, double* %l6
  %t78 = sitofp i64 0 to double
  %t79 = fcmp oge double %t77, %t78
  %t80 = load i8*, i8** %l0
  %t81 = load double, double* %l1
  %t82 = load i8*, i8** %l3
  %t83 = load i8*, i8** %l4
  %t84 = load i8*, i8** %l5
  %t85 = load double, double* %l6
  br i1 %t79, label %then13, label %else14
then13:
  %t86 = load i8*, i8** %l5
  %t87 = load double, double* %l6
  %t88 = fptosi double %t87 to i64
  %t89 = call i8* @sailfin_runtime_substring(i8* %t86, i64 0, i64 %t88)
  %t90 = call i8* @trim_text(i8* %t89)
  store i8* %t90, i8** %l3
  %t91 = load i8*, i8** %l5
  %t92 = load double, double* %l6
  %t93 = sitofp i64 1 to double
  %t94 = fadd double %t92, %t93
  %t95 = load i8*, i8** %l5
  %t96 = call i64 @sailfin_runtime_string_length(i8* %t95)
  %t97 = fptosi double %t94 to i64
  %t98 = call i8* @sailfin_runtime_substring(i8* %t91, i64 %t97, i64 %t96)
  %t99 = call i8* @trim_text(i8* %t98)
  store i8* %t99, i8** %l7
  %t100 = load i8*, i8** %l7
  %t101 = call i64 @sailfin_runtime_string_length(i8* %t100)
  %t102 = icmp sgt i64 %t101, 0
  %t103 = load i8*, i8** %l0
  %t104 = load double, double* %l1
  %t105 = load i8*, i8** %l3
  %t106 = load i8*, i8** %l4
  %t107 = load i8*, i8** %l5
  %t108 = load double, double* %l6
  %t109 = load i8*, i8** %l7
  br i1 %t102, label %then16, label %merge17
then16:
  %t110 = load i8*, i8** %l7
  store i8* %t110, i8** %l4
  %t111 = load i8*, i8** %l4
  br label %merge17
merge17:
  %t112 = phi i8* [ %t111, %then16 ], [ %t106, %then13 ]
  store i8* %t112, i8** %l4
  %t113 = load i8*, i8** %l3
  %t114 = load i8*, i8** %l4
  br label %merge15
else14:
  %t115 = load i8*, i8** %l5
  %t116 = call i8* @trim_text(i8* %t115)
  store i8* %t116, i8** %l3
  %t117 = load i8*, i8** %l3
  br label %merge15
merge15:
  %t118 = phi i8* [ %t113, %merge17 ], [ %t117, %else14 ]
  %t119 = phi i8* [ %t114, %merge17 ], [ %t83, %else14 ]
  store i8* %t118, i8** %l3
  store i8* %t119, i8** %l4
  %t120 = load i8*, i8** %l5
  %t121 = load i8*, i8** %l3
  %t122 = load i8*, i8** %l4
  %t123 = load i8*, i8** %l3
  br label %merge12
else11:
  %t124 = load i8*, i8** %l5
  %t125 = alloca [2 x i8], align 1
  %t126 = getelementptr [2 x i8], [2 x i8]* %t125, i32 0, i32 0
  store i8 58, i8* %t126
  %t127 = getelementptr [2 x i8], [2 x i8]* %t125, i32 0, i32 1
  store i8 0, i8* %t127
  %t128 = getelementptr [2 x i8], [2 x i8]* %t125, i32 0, i32 0
  %t129 = call i1 @starts_with(i8* %t124, i8* %t128)
  %t130 = load i8*, i8** %l0
  %t131 = load double, double* %l1
  %t132 = load i8*, i8** %l3
  %t133 = load i8*, i8** %l4
  %t134 = load i8*, i8** %l5
  br i1 %t129, label %then18, label %else19
then18:
  %t135 = load i8*, i8** %l5
  %t136 = alloca [2 x i8], align 1
  %t137 = getelementptr [2 x i8], [2 x i8]* %t136, i32 0, i32 0
  store i8 58, i8* %t137
  %t138 = getelementptr [2 x i8], [2 x i8]* %t136, i32 0, i32 1
  store i8 0, i8* %t138
  %t139 = getelementptr [2 x i8], [2 x i8]* %t136, i32 0, i32 0
  %t140 = call i8* @strip_prefix(i8* %t135, i8* %t139)
  %t141 = call i8* @trim_text(i8* %t140)
  store i8* %t141, i8** %l5
  %t142 = load i8*, i8** %l5
  %t143 = alloca [2 x i8], align 1
  %t144 = getelementptr [2 x i8], [2 x i8]* %t143, i32 0, i32 0
  store i8 61, i8* %t144
  %t145 = getelementptr [2 x i8], [2 x i8]* %t143, i32 0, i32 1
  store i8 0, i8* %t145
  %t146 = getelementptr [2 x i8], [2 x i8]* %t143, i32 0, i32 0
  %t147 = call double @index_of(i8* %t142, i8* %t146)
  store double %t147, double* %l8
  %t148 = load double, double* %l8
  %t149 = sitofp i64 0 to double
  %t150 = fcmp oge double %t148, %t149
  %t151 = load i8*, i8** %l0
  %t152 = load double, double* %l1
  %t153 = load i8*, i8** %l3
  %t154 = load i8*, i8** %l4
  %t155 = load i8*, i8** %l5
  %t156 = load double, double* %l8
  br i1 %t150, label %then21, label %else22
then21:
  %t157 = load i8*, i8** %l5
  %t158 = load double, double* %l8
  %t159 = fptosi double %t158 to i64
  %t160 = call i8* @sailfin_runtime_substring(i8* %t157, i64 0, i64 %t159)
  %t161 = call i8* @trim_text(i8* %t160)
  store i8* %t161, i8** %l3
  %t162 = load i8*, i8** %l5
  %t163 = load double, double* %l8
  %t164 = sitofp i64 1 to double
  %t165 = fadd double %t163, %t164
  %t166 = load i8*, i8** %l5
  %t167 = call i64 @sailfin_runtime_string_length(i8* %t166)
  %t168 = fptosi double %t165 to i64
  %t169 = call i8* @sailfin_runtime_substring(i8* %t162, i64 %t168, i64 %t167)
  %t170 = call i8* @trim_text(i8* %t169)
  store i8* %t170, i8** %l9
  %t171 = load i8*, i8** %l9
  %t172 = call i64 @sailfin_runtime_string_length(i8* %t171)
  %t173 = icmp sgt i64 %t172, 0
  %t174 = load i8*, i8** %l0
  %t175 = load double, double* %l1
  %t176 = load i8*, i8** %l3
  %t177 = load i8*, i8** %l4
  %t178 = load i8*, i8** %l5
  %t179 = load double, double* %l8
  %t180 = load i8*, i8** %l9
  br i1 %t173, label %then24, label %merge25
then24:
  %t181 = load i8*, i8** %l9
  store i8* %t181, i8** %l4
  %t182 = load i8*, i8** %l4
  br label %merge25
merge25:
  %t183 = phi i8* [ %t182, %then24 ], [ %t177, %then21 ]
  store i8* %t183, i8** %l4
  %t184 = load i8*, i8** %l3
  %t185 = load i8*, i8** %l4
  br label %merge23
else22:
  %t186 = load i8*, i8** %l5
  %t187 = call i8* @trim_text(i8* %t186)
  store i8* %t187, i8** %l3
  %t188 = load i8*, i8** %l3
  br label %merge23
merge23:
  %t189 = phi i8* [ %t184, %merge25 ], [ %t188, %else22 ]
  %t190 = phi i8* [ %t185, %merge25 ], [ %t154, %else22 ]
  store i8* %t189, i8** %l3
  store i8* %t190, i8** %l4
  %t191 = load i8*, i8** %l5
  %t192 = load i8*, i8** %l3
  %t193 = load i8*, i8** %l4
  %t194 = load i8*, i8** %l3
  br label %merge20
else19:
  %t195 = load i8*, i8** %l5
  %t196 = alloca [2 x i8], align 1
  %t197 = getelementptr [2 x i8], [2 x i8]* %t196, i32 0, i32 0
  store i8 61, i8* %t197
  %t198 = getelementptr [2 x i8], [2 x i8]* %t196, i32 0, i32 1
  store i8 0, i8* %t198
  %t199 = getelementptr [2 x i8], [2 x i8]* %t196, i32 0, i32 0
  %t200 = call i1 @starts_with(i8* %t195, i8* %t199)
  %t201 = load i8*, i8** %l0
  %t202 = load double, double* %l1
  %t203 = load i8*, i8** %l3
  %t204 = load i8*, i8** %l4
  %t205 = load i8*, i8** %l5
  br i1 %t200, label %then26, label %else27
then26:
  %t206 = load i8*, i8** %l5
  %t207 = alloca [2 x i8], align 1
  %t208 = getelementptr [2 x i8], [2 x i8]* %t207, i32 0, i32 0
  store i8 61, i8* %t208
  %t209 = getelementptr [2 x i8], [2 x i8]* %t207, i32 0, i32 1
  store i8 0, i8* %t209
  %t210 = getelementptr [2 x i8], [2 x i8]* %t207, i32 0, i32 0
  %t211 = call i8* @strip_prefix(i8* %t206, i8* %t210)
  %t212 = call i8* @trim_text(i8* %t211)
  store i8* %t212, i8** %l10
  %t213 = load i8*, i8** %l10
  %t214 = call i64 @sailfin_runtime_string_length(i8* %t213)
  %t215 = icmp sgt i64 %t214, 0
  %t216 = load i8*, i8** %l0
  %t217 = load double, double* %l1
  %t218 = load i8*, i8** %l3
  %t219 = load i8*, i8** %l4
  %t220 = load i8*, i8** %l5
  %t221 = load i8*, i8** %l10
  br i1 %t215, label %then29, label %merge30
then29:
  %t222 = load i8*, i8** %l10
  store i8* %t222, i8** %l4
  %t223 = load i8*, i8** %l4
  br label %merge30
merge30:
  %t224 = phi i8* [ %t223, %then29 ], [ %t219, %then26 ]
  store i8* %t224, i8** %l4
  %t225 = load i8*, i8** %l4
  br label %merge28
else27:
  %t226 = load i8*, i8** %l5
  store i8* %t226, i8** %l4
  %t227 = load i8*, i8** %l4
  br label %merge28
merge28:
  %t228 = phi i8* [ %t225, %merge30 ], [ %t227, %else27 ]
  store i8* %t228, i8** %l4
  %t229 = load i8*, i8** %l4
  %t230 = load i8*, i8** %l4
  br label %merge20
merge20:
  %t231 = phi i8* [ %t191, %merge23 ], [ %t134, %merge28 ]
  %t232 = phi i8* [ %t192, %merge23 ], [ %t132, %merge28 ]
  %t233 = phi i8* [ %t193, %merge23 ], [ %t229, %merge28 ]
  store i8* %t231, i8** %l5
  store i8* %t232, i8** %l3
  store i8* %t233, i8** %l4
  %t234 = load i8*, i8** %l5
  %t235 = load i8*, i8** %l3
  %t236 = load i8*, i8** %l4
  %t237 = load i8*, i8** %l3
  %t238 = load i8*, i8** %l4
  %t239 = load i8*, i8** %l4
  br label %merge12
merge12:
  %t240 = phi i8* [ %t120, %merge15 ], [ %t234, %merge20 ]
  %t241 = phi i8* [ %t121, %merge15 ], [ %t235, %merge20 ]
  %t242 = phi i8* [ %t122, %merge15 ], [ %t236, %merge20 ]
  store i8* %t240, i8** %l5
  store i8* %t241, i8** %l3
  store i8* %t242, i8** %l4
  %t243 = load i8*, i8** %l5
  %t244 = load i8*, i8** %l3
  %t245 = load i8*, i8** %l4
  %t246 = load i8*, i8** %l3
  %t247 = load i8*, i8** %l5
  %t248 = load i8*, i8** %l3
  %t249 = load i8*, i8** %l4
  %t250 = load i8*, i8** %l3
  %t251 = load i8*, i8** %l4
  %t252 = load i8*, i8** %l4
  br label %merge9
merge9:
  %t253 = phi i8* [ %t243, %merge12 ], [ %t58, %afterloop3 ]
  %t254 = phi i8* [ %t244, %merge12 ], [ %t56, %afterloop3 ]
  %t255 = phi i8* [ %t245, %merge12 ], [ %t57, %afterloop3 ]
  %t256 = phi i8* [ %t246, %merge12 ], [ %t56, %afterloop3 ]
  %t257 = phi i8* [ %t247, %merge12 ], [ %t58, %afterloop3 ]
  %t258 = phi i8* [ %t248, %merge12 ], [ %t56, %afterloop3 ]
  %t259 = phi i8* [ %t249, %merge12 ], [ %t57, %afterloop3 ]
  %t260 = phi i8* [ %t250, %merge12 ], [ %t56, %afterloop3 ]
  %t261 = phi i8* [ %t251, %merge12 ], [ %t57, %afterloop3 ]
  %t262 = phi i8* [ %t252, %merge12 ], [ %t57, %afterloop3 ]
  store i8* %t253, i8** %l5
  store i8* %t254, i8** %l3
  store i8* %t255, i8** %l4
  store i8* %t256, i8** %l3
  store i8* %t257, i8** %l5
  store i8* %t258, i8** %l3
  store i8* %t259, i8** %l4
  store i8* %t260, i8** %l3
  store i8* %t261, i8** %l4
  store i8* %t262, i8** %l4
  %t263 = load i8*, i8** %l0
  %t264 = insertvalue %BindingComponents undef, i8* %t263, 0
  %t265 = load i8*, i8** %l3
  %t266 = insertvalue %BindingComponents %t264, i8* %t265, 1
  %t267 = load i8*, i8** %l4
  %t268 = insertvalue %BindingComponents %t266, i8* %t267, 2
  ret %BindingComponents %t268
}

define i8* @parse_function_name(i8* %header) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
  %t0 = call i8* @trim_text(i8* %header)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %s2 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1134498859, i32 0, i32 0
  %t3 = call i1 @starts_with(i8* %t1, i8* %s2)
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = load i8*, i8** %l0
  %s6 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1134498859, i32 0, i32 0
  %t7 = call i8* @strip_prefix(i8* %t5, i8* %s6)
  %t8 = call i8* @trim_text(i8* %t7)
  store i8* %t8, i8** %l0
  %t9 = load i8*, i8** %l0
  br label %merge1
merge1:
  %t10 = phi i8* [ %t9, %then0 ], [ %t4, %block.entry ]
  store i8* %t10, i8** %l0
  %t11 = load i8*, i8** %l0
  %t12 = alloca [2 x i8], align 1
  %t13 = getelementptr [2 x i8], [2 x i8]* %t12, i32 0, i32 0
  store i8 40, i8* %t13
  %t14 = getelementptr [2 x i8], [2 x i8]* %t12, i32 0, i32 1
  store i8 0, i8* %t14
  %t15 = getelementptr [2 x i8], [2 x i8]* %t12, i32 0, i32 0
  %t16 = call double @index_of(i8* %t11, i8* %t15)
  store double %t16, double* %l1
  %t17 = load i8*, i8** %l0
  store i8* %t17, i8** %l2
  %t18 = load double, double* %l1
  %t19 = sitofp i64 0 to double
  %t20 = fcmp oge double %t18, %t19
  %t21 = load i8*, i8** %l0
  %t22 = load double, double* %l1
  %t23 = load i8*, i8** %l2
  br i1 %t20, label %then2, label %merge3
then2:
  %t24 = load i8*, i8** %l0
  %t25 = load double, double* %l1
  %t26 = fptosi double %t25 to i64
  %t27 = call i8* @sailfin_runtime_substring(i8* %t24, i64 0, i64 %t26)
  %t28 = call i8* @trim_text(i8* %t27)
  store i8* %t28, i8** %l2
  %t29 = load i8*, i8** %l2
  br label %merge3
merge3:
  %t30 = phi i8* [ %t29, %then2 ], [ %t23, %merge1 ]
  store i8* %t30, i8** %l2
  %t31 = load i8*, i8** %l2
  %t32 = alloca [2 x i8], align 1
  %t33 = getelementptr [2 x i8], [2 x i8]* %t32, i32 0, i32 0
  store i8 46, i8* %t33
  %t34 = getelementptr [2 x i8], [2 x i8]* %t32, i32 0, i32 1
  store i8 0, i8* %t34
  %t35 = getelementptr [2 x i8], [2 x i8]* %t32, i32 0, i32 0
  %t36 = call double @last_index_of(i8* %t31, i8* %t35)
  store double %t36, double* %l3
  %t37 = load double, double* %l3
  %t38 = sitofp i64 0 to double
  %t39 = fcmp oge double %t37, %t38
  %t40 = load i8*, i8** %l0
  %t41 = load double, double* %l1
  %t42 = load i8*, i8** %l2
  %t43 = load double, double* %l3
  br i1 %t39, label %then4, label %merge5
then4:
  %t44 = load i8*, i8** %l2
  %t45 = load double, double* %l3
  %t46 = sitofp i64 1 to double
  %t47 = fadd double %t45, %t46
  %t48 = load i8*, i8** %l2
  %t49 = call i64 @sailfin_runtime_string_length(i8* %t48)
  %t50 = fptosi double %t47 to i64
  %t51 = call i8* @sailfin_runtime_substring(i8* %t44, i64 %t50, i64 %t49)
  %t52 = call i8* @trim_text(i8* %t51)
  store i8* %t52, i8** %l2
  %t53 = load i8*, i8** %l2
  br label %merge5
merge5:
  %t54 = phi i8* [ %t53, %then4 ], [ %t42, %merge3 ]
  store i8* %t54, i8** %l2
  %t55 = load i8*, i8** %l2
  %t56 = call i8* @strip_generics(i8* %t55)
  ret i8* %t56
}

define %NativeParameter* @parse_parameter_entry(i8* %body, %NativeSourceSpan* %span) {
block.entry:
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
  %s7 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t8 = call i1 @starts_with(i8* %t6, i8* %s7)
  %t9 = load i8*, i8** %l0
  %t10 = load i1, i1* %l1
  br i1 %t8, label %then2, label %merge3
then2:
  store i1 1, i1* %l1
  %t11 = load i8*, i8** %l0
  %s12 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t13 = call i8* @strip_prefix(i8* %t11, i8* %s12)
  %t14 = call i8* @trim_text(i8* %t13)
  store i8* %t14, i8** %l0
  %t15 = load i1, i1* %l1
  %t16 = load i8*, i8** %l0
  br label %merge3
merge3:
  %t17 = phi i1 [ %t15, %then2 ], [ %t10, %merge1 ]
  %t18 = phi i8* [ %t16, %then2 ], [ %t9, %merge1 ]
  store i1 %t17, i1* %l1
  store i8* %t18, i8** %l0
  %s19 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s19, i8** %l2
  %t20 = sitofp i64 0 to double
  store double %t20, double* %l3
  %t21 = load i8*, i8** %l0
  %t22 = load i1, i1* %l1
  %t23 = load i8*, i8** %l2
  %t24 = load double, double* %l3
  br label %loop.header4
loop.header4:
  %t66 = phi i8* [ %t23, %merge3 ], [ %t64, %loop.latch6 ]
  %t67 = phi double [ %t24, %merge3 ], [ %t65, %loop.latch6 ]
  store i8* %t66, i8** %l2
  store double %t67, double* %l3
  br label %loop.body5
loop.body5:
  %t25 = load double, double* %l3
  %t26 = load i8*, i8** %l0
  %t27 = call i64 @sailfin_runtime_string_length(i8* %t26)
  %t28 = sitofp i64 %t27 to double
  %t29 = fcmp oge double %t25, %t28
  %t30 = load i8*, i8** %l0
  %t31 = load i1, i1* %l1
  %t32 = load i8*, i8** %l2
  %t33 = load double, double* %l3
  br i1 %t29, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t34 = load i8*, i8** %l0
  %t35 = load double, double* %l3
  %t36 = fptosi double %t35 to i64
  %t37 = getelementptr i8, i8* %t34, i64 %t36
  %t38 = load i8, i8* %t37
  store i8 %t38, i8* %l4
  %t40 = load i8, i8* %l4
  %t41 = icmp eq i8 %t40, 32
  br label %logical_or_entry_39

logical_or_entry_39:
  br i1 %t41, label %logical_or_merge_39, label %logical_or_right_39

logical_or_right_39:
  %t43 = load i8, i8* %l4
  %t44 = icmp eq i8 %t43, 45
  br label %logical_or_entry_42

logical_or_entry_42:
  br i1 %t44, label %logical_or_merge_42, label %logical_or_right_42

logical_or_right_42:
  %t45 = load i8, i8* %l4
  %t46 = icmp eq i8 %t45, 61
  br label %logical_or_right_end_42

logical_or_right_end_42:
  br label %logical_or_merge_42

logical_or_merge_42:
  %t47 = phi i1 [ true, %logical_or_entry_42 ], [ %t46, %logical_or_right_end_42 ]
  br label %logical_or_right_end_39

logical_or_right_end_39:
  br label %logical_or_merge_39

logical_or_merge_39:
  %t48 = phi i1 [ true, %logical_or_entry_39 ], [ %t47, %logical_or_right_end_39 ]
  %t49 = load i8*, i8** %l0
  %t50 = load i1, i1* %l1
  %t51 = load i8*, i8** %l2
  %t52 = load double, double* %l3
  %t53 = load i8, i8* %l4
  br i1 %t48, label %then10, label %merge11
then10:
  br label %afterloop7
merge11:
  %t54 = load i8*, i8** %l2
  %t55 = load i8, i8* %l4
  %t56 = alloca [2 x i8], align 1
  %t57 = getelementptr [2 x i8], [2 x i8]* %t56, i32 0, i32 0
  store i8 %t55, i8* %t57
  %t58 = getelementptr [2 x i8], [2 x i8]* %t56, i32 0, i32 1
  store i8 0, i8* %t58
  %t59 = getelementptr [2 x i8], [2 x i8]* %t56, i32 0, i32 0
  %t60 = call i8* @sailfin_runtime_string_concat(i8* %t54, i8* %t59)
  store i8* %t60, i8** %l2
  %t61 = load double, double* %l3
  %t62 = sitofp i64 1 to double
  %t63 = fadd double %t61, %t62
  store double %t63, double* %l3
  br label %loop.latch6
loop.latch6:
  %t64 = load i8*, i8** %l2
  %t65 = load double, double* %l3
  br label %loop.header4
afterloop7:
  %t68 = load i8*, i8** %l2
  %t69 = load double, double* %l3
  %t70 = load i8*, i8** %l2
  %t71 = call i8* @trim_text(i8* %t70)
  store i8* %t71, i8** %l2
  %t72 = load i8*, i8** %l2
  %t73 = call i64 @sailfin_runtime_string_length(i8* %t72)
  %t74 = icmp eq i64 %t73, 0
  %t75 = load i8*, i8** %l0
  %t76 = load i1, i1* %l1
  %t77 = load i8*, i8** %l2
  %t78 = load double, double* %l3
  br i1 %t74, label %then12, label %merge13
then12:
  %t79 = bitcast i8* null to %NativeParameter*
  ret %NativeParameter* %t79
merge13:
  %s80 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s80, i8** %l5
  store i8* null, i8** %l6
  %t81 = load i8*, i8** %l0
  %t82 = load double, double* %l3
  %t83 = load i8*, i8** %l0
  %t84 = call i64 @sailfin_runtime_string_length(i8* %t83)
  %t85 = fptosi double %t82 to i64
  %t86 = call i8* @sailfin_runtime_substring(i8* %t81, i64 %t85, i64 %t84)
  %t87 = call i8* @trim_text(i8* %t86)
  store i8* %t87, i8** %l7
  %t88 = load i8*, i8** %l7
  %t89 = call i64 @sailfin_runtime_string_length(i8* %t88)
  %t90 = icmp sgt i64 %t89, 0
  %t91 = load i8*, i8** %l0
  %t92 = load i1, i1* %l1
  %t93 = load i8*, i8** %l2
  %t94 = load double, double* %l3
  %t95 = load i8*, i8** %l5
  %t96 = load i8*, i8** %l6
  %t97 = load i8*, i8** %l7
  br i1 %t90, label %then14, label %merge15
then14:
  %t98 = load i8*, i8** %l7
  %s99 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193428050, i32 0, i32 0
  %t100 = call i1 @starts_with(i8* %t98, i8* %s99)
  %t101 = load i8*, i8** %l0
  %t102 = load i1, i1* %l1
  %t103 = load i8*, i8** %l2
  %t104 = load double, double* %l3
  %t105 = load i8*, i8** %l5
  %t106 = load i8*, i8** %l6
  %t107 = load i8*, i8** %l7
  br i1 %t100, label %then16, label %else17
then16:
  %t108 = load i8*, i8** %l7
  %s109 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193428050, i32 0, i32 0
  %t110 = call i8* @strip_prefix(i8* %t108, i8* %s109)
  %t111 = call i8* @trim_text(i8* %t110)
  store i8* %t111, i8** %l7
  %t112 = load i8*, i8** %l7
  %t113 = alloca [2 x i8], align 1
  %t114 = getelementptr [2 x i8], [2 x i8]* %t113, i32 0, i32 0
  store i8 61, i8* %t114
  %t115 = getelementptr [2 x i8], [2 x i8]* %t113, i32 0, i32 1
  store i8 0, i8* %t115
  %t116 = getelementptr [2 x i8], [2 x i8]* %t113, i32 0, i32 0
  %t117 = call double @index_of(i8* %t112, i8* %t116)
  store double %t117, double* %l8
  %t118 = load double, double* %l8
  %t119 = sitofp i64 0 to double
  %t120 = fcmp oge double %t118, %t119
  %t121 = load i8*, i8** %l0
  %t122 = load i1, i1* %l1
  %t123 = load i8*, i8** %l2
  %t124 = load double, double* %l3
  %t125 = load i8*, i8** %l5
  %t126 = load i8*, i8** %l6
  %t127 = load i8*, i8** %l7
  %t128 = load double, double* %l8
  br i1 %t120, label %then19, label %else20
then19:
  %t129 = load i8*, i8** %l7
  %t130 = load double, double* %l8
  %t131 = fptosi double %t130 to i64
  %t132 = call i8* @sailfin_runtime_substring(i8* %t129, i64 0, i64 %t131)
  %t133 = call i8* @trim_text(i8* %t132)
  store i8* %t133, i8** %l5
  %t134 = load i8*, i8** %l7
  %t135 = load double, double* %l8
  %t136 = sitofp i64 1 to double
  %t137 = fadd double %t135, %t136
  %t138 = load i8*, i8** %l7
  %t139 = call i64 @sailfin_runtime_string_length(i8* %t138)
  %t140 = fptosi double %t137 to i64
  %t141 = call i8* @sailfin_runtime_substring(i8* %t134, i64 %t140, i64 %t139)
  %t142 = call i8* @trim_text(i8* %t141)
  store i8* %t142, i8** %l9
  %t143 = load i8*, i8** %l9
  %t144 = call i64 @sailfin_runtime_string_length(i8* %t143)
  %t145 = icmp sgt i64 %t144, 0
  %t146 = load i8*, i8** %l0
  %t147 = load i1, i1* %l1
  %t148 = load i8*, i8** %l2
  %t149 = load double, double* %l3
  %t150 = load i8*, i8** %l5
  %t151 = load i8*, i8** %l6
  %t152 = load i8*, i8** %l7
  %t153 = load double, double* %l8
  %t154 = load i8*, i8** %l9
  br i1 %t145, label %then22, label %merge23
then22:
  %t155 = load i8*, i8** %l9
  store i8* %t155, i8** %l6
  %t156 = load i8*, i8** %l6
  br label %merge23
merge23:
  %t157 = phi i8* [ %t156, %then22 ], [ %t151, %then19 ]
  store i8* %t157, i8** %l6
  %t158 = load i8*, i8** %l5
  %t159 = load i8*, i8** %l6
  br label %merge21
else20:
  %t160 = load i8*, i8** %l7
  %t161 = call i8* @trim_text(i8* %t160)
  store i8* %t161, i8** %l5
  %t162 = load i8*, i8** %l5
  br label %merge21
merge21:
  %t163 = phi i8* [ %t158, %merge23 ], [ %t162, %else20 ]
  %t164 = phi i8* [ %t159, %merge23 ], [ %t126, %else20 ]
  store i8* %t163, i8** %l5
  store i8* %t164, i8** %l6
  %t165 = load i8*, i8** %l7
  %t166 = load i8*, i8** %l5
  %t167 = load i8*, i8** %l6
  %t168 = load i8*, i8** %l5
  br label %merge18
else17:
  %t169 = load i8*, i8** %l7
  %t170 = alloca [2 x i8], align 1
  %t171 = getelementptr [2 x i8], [2 x i8]* %t170, i32 0, i32 0
  store i8 61, i8* %t171
  %t172 = getelementptr [2 x i8], [2 x i8]* %t170, i32 0, i32 1
  store i8 0, i8* %t172
  %t173 = getelementptr [2 x i8], [2 x i8]* %t170, i32 0, i32 0
  %t174 = call i1 @starts_with(i8* %t169, i8* %t173)
  %t175 = load i8*, i8** %l0
  %t176 = load i1, i1* %l1
  %t177 = load i8*, i8** %l2
  %t178 = load double, double* %l3
  %t179 = load i8*, i8** %l5
  %t180 = load i8*, i8** %l6
  %t181 = load i8*, i8** %l7
  br i1 %t174, label %then24, label %merge25
then24:
  %t182 = load i8*, i8** %l7
  %t183 = alloca [2 x i8], align 1
  %t184 = getelementptr [2 x i8], [2 x i8]* %t183, i32 0, i32 0
  store i8 61, i8* %t184
  %t185 = getelementptr [2 x i8], [2 x i8]* %t183, i32 0, i32 1
  store i8 0, i8* %t185
  %t186 = getelementptr [2 x i8], [2 x i8]* %t183, i32 0, i32 0
  %t187 = call i8* @strip_prefix(i8* %t182, i8* %t186)
  %t188 = call i8* @trim_text(i8* %t187)
  store i8* %t188, i8** %l10
  %t189 = load i8*, i8** %l10
  %t190 = call i64 @sailfin_runtime_string_length(i8* %t189)
  %t191 = icmp sgt i64 %t190, 0
  %t192 = load i8*, i8** %l0
  %t193 = load i1, i1* %l1
  %t194 = load i8*, i8** %l2
  %t195 = load double, double* %l3
  %t196 = load i8*, i8** %l5
  %t197 = load i8*, i8** %l6
  %t198 = load i8*, i8** %l7
  %t199 = load i8*, i8** %l10
  br i1 %t191, label %then26, label %merge27
then26:
  %t200 = load i8*, i8** %l10
  store i8* %t200, i8** %l6
  %t201 = load i8*, i8** %l6
  br label %merge27
merge27:
  %t202 = phi i8* [ %t201, %then26 ], [ %t197, %then24 ]
  store i8* %t202, i8** %l6
  %t203 = load i8*, i8** %l6
  br label %merge25
merge25:
  %t204 = phi i8* [ %t203, %merge27 ], [ %t180, %else17 ]
  store i8* %t204, i8** %l6
  %t205 = load i8*, i8** %l6
  br label %merge18
merge18:
  %t206 = phi i8* [ %t165, %merge21 ], [ %t107, %merge25 ]
  %t207 = phi i8* [ %t166, %merge21 ], [ %t105, %merge25 ]
  %t208 = phi i8* [ %t167, %merge21 ], [ %t205, %merge25 ]
  store i8* %t206, i8** %l7
  store i8* %t207, i8** %l5
  store i8* %t208, i8** %l6
  %t209 = load i8*, i8** %l7
  %t210 = load i8*, i8** %l5
  %t211 = load i8*, i8** %l6
  %t212 = load i8*, i8** %l5
  %t213 = load i8*, i8** %l6
  br label %merge15
merge15:
  %t214 = phi i8* [ %t209, %merge18 ], [ %t97, %merge13 ]
  %t215 = phi i8* [ %t210, %merge18 ], [ %t95, %merge13 ]
  %t216 = phi i8* [ %t211, %merge18 ], [ %t96, %merge13 ]
  %t217 = phi i8* [ %t212, %merge18 ], [ %t95, %merge13 ]
  %t218 = phi i8* [ %t213, %merge18 ], [ %t96, %merge13 ]
  store i8* %t214, i8** %l7
  store i8* %t215, i8** %l5
  store i8* %t216, i8** %l6
  store i8* %t217, i8** %l5
  store i8* %t218, i8** %l6
  %t219 = load i8*, i8** %l2
  %t220 = insertvalue %NativeParameter undef, i8* %t219, 0
  %t221 = load i8*, i8** %l5
  %t222 = insertvalue %NativeParameter %t220, i8* %t221, 1
  %t223 = load i1, i1* %l1
  %t224 = insertvalue %NativeParameter %t222, i1 %t223, 2
  %t225 = load i8*, i8** %l6
  %t226 = insertvalue %NativeParameter %t224, i8* %t225, 3
  %t227 = insertvalue %NativeParameter %t226, %NativeSourceSpan* %span, 4
  %t228 = alloca %NativeParameter
  store %NativeParameter %t227, %NativeParameter* %t228
  ret %NativeParameter* %t228
}

define i1 @line_looks_like_parameter_entry(i8* %text) {
block.entry:
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
  %s20 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193428050, i32 0, i32 0
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
  %s39 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t40 = call i1 @starts_with(i8* %t38, i8* %s39)
  %t41 = load i8*, i8** %l0
  %t42 = load double, double* %l1
  %t43 = load i8*, i8** %l2
  br i1 %t40, label %then10, label %merge11
then10:
  %t44 = load i8*, i8** %l2
  %s45 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t46 = call i8* @strip_prefix(i8* %t44, i8* %s45)
  %t47 = call i8* @trim_text(i8* %t46)
  store i8* %t47, i8** %l2
  %t48 = load i8*, i8** %l2
  br label %merge11
merge11:
  %t49 = phi i8* [ %t48, %then10 ], [ %t43, %merge9 ]
  store i8* %t49, i8** %l2
  %t50 = load i8*, i8** %l2
  %t51 = call i64 @sailfin_runtime_string_length(i8* %t50)
  %t52 = icmp eq i64 %t51, 0
  %t53 = load i8*, i8** %l0
  %t54 = load double, double* %l1
  %t55 = load i8*, i8** %l2
  br i1 %t52, label %then12, label %merge13
then12:
  ret i1 0
merge13:
  %t56 = load i8*, i8** %l2
  %t57 = alloca [2 x i8], align 1
  %t58 = getelementptr [2 x i8], [2 x i8]* %t57, i32 0, i32 0
  store i8 32, i8* %t58
  %t59 = getelementptr [2 x i8], [2 x i8]* %t57, i32 0, i32 1
  store i8 0, i8* %t59
  %t60 = getelementptr [2 x i8], [2 x i8]* %t57, i32 0, i32 0
  %t61 = call double @index_of(i8* %t56, i8* %t60)
  %t62 = sitofp i64 0 to double
  %t63 = fcmp oge double %t61, %t62
  %t64 = load i8*, i8** %l0
  %t65 = load double, double* %l1
  %t66 = load i8*, i8** %l2
  br i1 %t63, label %then14, label %merge15
then14:
  ret i1 0
merge15:
  %t67 = load i8*, i8** %l2
  %t68 = alloca [2 x i8], align 1
  %t69 = getelementptr [2 x i8], [2 x i8]* %t68, i32 0, i32 0
  store i8 9, i8* %t69
  %t70 = getelementptr [2 x i8], [2 x i8]* %t68, i32 0, i32 1
  store i8 0, i8* %t70
  %t71 = getelementptr [2 x i8], [2 x i8]* %t68, i32 0, i32 0
  %t72 = call double @index_of(i8* %t67, i8* %t71)
  %t73 = sitofp i64 0 to double
  %t74 = fcmp oge double %t72, %t73
  %t75 = load i8*, i8** %l0
  %t76 = load double, double* %l1
  %t77 = load i8*, i8** %l2
  br i1 %t74, label %then16, label %merge17
then16:
  ret i1 0
merge17:
  ret i1 1
merge7:
  %t78 = load i8*, i8** %l0
  %t79 = alloca [2 x i8], align 1
  %t80 = getelementptr [2 x i8], [2 x i8]* %t79, i32 0, i32 0
  store i8 61, i8* %t80
  %t81 = getelementptr [2 x i8], [2 x i8]* %t79, i32 0, i32 1
  store i8 0, i8* %t81
  %t82 = getelementptr [2 x i8], [2 x i8]* %t79, i32 0, i32 0
  %t83 = call double @index_of(i8* %t78, i8* %t82)
  store double %t83, double* %l3
  %t84 = load double, double* %l3
  %t85 = sitofp i64 0 to double
  %t86 = fcmp oge double %t84, %t85
  %t87 = load i8*, i8** %l0
  %t88 = load double, double* %l1
  %t89 = load double, double* %l3
  br i1 %t86, label %then18, label %merge19
then18:
  %t90 = load i8*, i8** %l0
  %t91 = load double, double* %l3
  %t92 = fptosi double %t91 to i64
  %t93 = call i8* @sailfin_runtime_substring(i8* %t90, i64 0, i64 %t92)
  %t94 = call i8* @trim_text(i8* %t93)
  store i8* %t94, i8** %l4
  %t95 = load i8*, i8** %l4
  %t96 = call i64 @sailfin_runtime_string_length(i8* %t95)
  %t97 = icmp eq i64 %t96, 0
  %t98 = load i8*, i8** %l0
  %t99 = load double, double* %l1
  %t100 = load double, double* %l3
  %t101 = load i8*, i8** %l4
  br i1 %t97, label %then20, label %merge21
then20:
  ret i1 0
merge21:
  %t102 = load i8*, i8** %l4
  %s103 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t104 = call i1 @starts_with(i8* %t102, i8* %s103)
  %t105 = load i8*, i8** %l0
  %t106 = load double, double* %l1
  %t107 = load double, double* %l3
  %t108 = load i8*, i8** %l4
  br i1 %t104, label %then22, label %merge23
then22:
  %t109 = load i8*, i8** %l4
  %s110 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t111 = call i8* @strip_prefix(i8* %t109, i8* %s110)
  %t112 = call i8* @trim_text(i8* %t111)
  store i8* %t112, i8** %l4
  %t113 = load i8*, i8** %l4
  br label %merge23
merge23:
  %t114 = phi i8* [ %t113, %then22 ], [ %t108, %merge21 ]
  store i8* %t114, i8** %l4
  %t115 = load i8*, i8** %l4
  %t116 = call i64 @sailfin_runtime_string_length(i8* %t115)
  %t117 = icmp eq i64 %t116, 0
  %t118 = load i8*, i8** %l0
  %t119 = load double, double* %l1
  %t120 = load double, double* %l3
  %t121 = load i8*, i8** %l4
  br i1 %t117, label %then24, label %merge25
then24:
  ret i1 0
merge25:
  %t122 = load i8*, i8** %l4
  %t123 = alloca [2 x i8], align 1
  %t124 = getelementptr [2 x i8], [2 x i8]* %t123, i32 0, i32 0
  store i8 32, i8* %t124
  %t125 = getelementptr [2 x i8], [2 x i8]* %t123, i32 0, i32 1
  store i8 0, i8* %t125
  %t126 = getelementptr [2 x i8], [2 x i8]* %t123, i32 0, i32 0
  %t127 = call double @index_of(i8* %t122, i8* %t126)
  %t128 = sitofp i64 0 to double
  %t129 = fcmp oge double %t127, %t128
  %t130 = load i8*, i8** %l0
  %t131 = load double, double* %l1
  %t132 = load double, double* %l3
  %t133 = load i8*, i8** %l4
  br i1 %t129, label %then26, label %merge27
then26:
  ret i1 0
merge27:
  %t134 = load i8*, i8** %l4
  %t135 = alloca [2 x i8], align 1
  %t136 = getelementptr [2 x i8], [2 x i8]* %t135, i32 0, i32 0
  store i8 9, i8* %t136
  %t137 = getelementptr [2 x i8], [2 x i8]* %t135, i32 0, i32 1
  store i8 0, i8* %t137
  %t138 = getelementptr [2 x i8], [2 x i8]* %t135, i32 0, i32 0
  %t139 = call double @index_of(i8* %t134, i8* %t138)
  %t140 = sitofp i64 0 to double
  %t141 = fcmp oge double %t139, %t140
  %t142 = load i8*, i8** %l0
  %t143 = load double, double* %l1
  %t144 = load double, double* %l3
  %t145 = load i8*, i8** %l4
  br i1 %t141, label %then28, label %merge29
then28:
  ret i1 0
merge29:
  ret i1 1
merge19:
  ret i1 0
}

define { i8**, i64 }* @split_parameter_entries(i8* %body) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca i8
  %l6 = alloca i8*
  %l7 = alloca i8*
  %t0 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t1 = ptrtoint [0 x i8*]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to i8**
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t7 = ptrtoint { i8**, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { i8**, i64 }*
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 0
  store i8** %t5, i8*** %t10
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { i8**, i64 }* %t9, { i8**, i64 }** %l0
  %s12 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s12, i8** %l1
  %t13 = sitofp i64 0 to double
  store double %t13, double* %l2
  %t14 = sitofp i64 0 to double
  store double %t14, double* %l3
  %s15 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s15, i8** %l4
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t17 = load i8*, i8** %l1
  %t18 = load double, double* %l2
  %t19 = load double, double* %l3
  %t20 = load i8*, i8** %l4
  br label %loop.header0
loop.header0:
  %t260 = phi i8* [ %t17, %block.entry ], [ %t255, %loop.latch2 ]
  %t261 = phi double [ %t18, %block.entry ], [ %t256, %loop.latch2 ]
  %t262 = phi i8* [ %t20, %block.entry ], [ %t257, %loop.latch2 ]
  %t263 = phi double [ %t19, %block.entry ], [ %t258, %loop.latch2 ]
  %t264 = phi { i8**, i64 }* [ %t16, %block.entry ], [ %t259, %loop.latch2 ]
  store i8* %t260, i8** %l1
  store double %t261, double* %l2
  store i8* %t262, i8** %l4
  store double %t263, double* %l3
  store { i8**, i64 }* %t264, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t21 = load double, double* %l2
  %t22 = call i64 @sailfin_runtime_string_length(i8* %body)
  %t23 = sitofp i64 %t22 to double
  %t24 = fcmp oge double %t21, %t23
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t26 = load i8*, i8** %l1
  %t27 = load double, double* %l2
  %t28 = load double, double* %l3
  %t29 = load i8*, i8** %l4
  br i1 %t24, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t30 = load double, double* %l2
  %t31 = fptosi double %t30 to i64
  %t32 = getelementptr i8, i8* %body, i64 %t31
  %t33 = load i8, i8* %t32
  store i8 %t33, i8* %l5
  %t34 = load i8*, i8** %l4
  %t35 = call i64 @sailfin_runtime_string_length(i8* %t34)
  %t36 = icmp sgt i64 %t35, 0
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t38 = load i8*, i8** %l1
  %t39 = load double, double* %l2
  %t40 = load double, double* %l3
  %t41 = load i8*, i8** %l4
  %t42 = load i8, i8* %l5
  br i1 %t36, label %then6, label %merge7
then6:
  %t43 = load i8*, i8** %l1
  %t44 = load i8, i8* %l5
  %t45 = alloca [2 x i8], align 1
  %t46 = getelementptr [2 x i8], [2 x i8]* %t45, i32 0, i32 0
  store i8 %t44, i8* %t46
  %t47 = getelementptr [2 x i8], [2 x i8]* %t45, i32 0, i32 1
  store i8 0, i8* %t47
  %t48 = getelementptr [2 x i8], [2 x i8]* %t45, i32 0, i32 0
  %t49 = call i8* @sailfin_runtime_string_concat(i8* %t43, i8* %t48)
  store i8* %t49, i8** %l1
  %t50 = load i8, i8* %l5
  %t51 = icmp eq i8 %t50, 92
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t53 = load i8*, i8** %l1
  %t54 = load double, double* %l2
  %t55 = load double, double* %l3
  %t56 = load i8*, i8** %l4
  %t57 = load i8, i8* %l5
  br i1 %t51, label %then8, label %merge9
then8:
  %t58 = load double, double* %l2
  %t59 = sitofp i64 1 to double
  %t60 = fadd double %t58, %t59
  %t61 = call i64 @sailfin_runtime_string_length(i8* %body)
  %t62 = sitofp i64 %t61 to double
  %t63 = fcmp olt double %t60, %t62
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t65 = load i8*, i8** %l1
  %t66 = load double, double* %l2
  %t67 = load double, double* %l3
  %t68 = load i8*, i8** %l4
  %t69 = load i8, i8* %l5
  br i1 %t63, label %then10, label %merge11
then10:
  %t70 = load i8*, i8** %l1
  %t71 = load double, double* %l2
  %t72 = sitofp i64 1 to double
  %t73 = fadd double %t71, %t72
  %t74 = fptosi double %t73 to i64
  %t75 = getelementptr i8, i8* %body, i64 %t74
  %t76 = load i8, i8* %t75
  %t77 = alloca [2 x i8], align 1
  %t78 = getelementptr [2 x i8], [2 x i8]* %t77, i32 0, i32 0
  store i8 %t76, i8* %t78
  %t79 = getelementptr [2 x i8], [2 x i8]* %t77, i32 0, i32 1
  store i8 0, i8* %t79
  %t80 = getelementptr [2 x i8], [2 x i8]* %t77, i32 0, i32 0
  %t81 = call i8* @sailfin_runtime_string_concat(i8* %t70, i8* %t80)
  store i8* %t81, i8** %l1
  %t82 = load double, double* %l2
  %t83 = sitofp i64 2 to double
  %t84 = fadd double %t82, %t83
  store double %t84, double* %l2
  br label %loop.latch2
merge11:
  %t85 = load i8*, i8** %l1
  %t86 = load double, double* %l2
  br label %merge9
merge9:
  %t87 = phi i8* [ %t85, %merge11 ], [ %t53, %then6 ]
  %t88 = phi double [ %t86, %merge11 ], [ %t54, %then6 ]
  store i8* %t87, i8** %l1
  store double %t88, double* %l2
  %t89 = load i8, i8* %l5
  %t90 = load i8*, i8** %l4
  %t91 = load i8, i8* %t90
  %t92 = icmp eq i8 %t89, %t91
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t94 = load i8*, i8** %l1
  %t95 = load double, double* %l2
  %t96 = load double, double* %l3
  %t97 = load i8*, i8** %l4
  %t98 = load i8, i8* %l5
  br i1 %t92, label %then12, label %merge13
then12:
  %s99 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s99, i8** %l4
  %t100 = load i8*, i8** %l4
  br label %merge13
merge13:
  %t101 = phi i8* [ %t100, %then12 ], [ %t97, %merge9 ]
  store i8* %t101, i8** %l4
  %t102 = load double, double* %l2
  %t103 = sitofp i64 1 to double
  %t104 = fadd double %t102, %t103
  store double %t104, double* %l2
  br label %loop.latch2
merge7:
  %t106 = load i8, i8* %l5
  %t107 = icmp eq i8 %t106, 34
  br label %logical_or_entry_105

logical_or_entry_105:
  br i1 %t107, label %logical_or_merge_105, label %logical_or_right_105

logical_or_right_105:
  %t108 = load i8, i8* %l5
  %t109 = icmp eq i8 %t108, 39
  br label %logical_or_right_end_105

logical_or_right_end_105:
  br label %logical_or_merge_105

logical_or_merge_105:
  %t110 = phi i1 [ true, %logical_or_entry_105 ], [ %t109, %logical_or_right_end_105 ]
  %t111 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t112 = load i8*, i8** %l1
  %t113 = load double, double* %l2
  %t114 = load double, double* %l3
  %t115 = load i8*, i8** %l4
  %t116 = load i8, i8* %l5
  br i1 %t110, label %then14, label %merge15
then14:
  %t117 = load i8, i8* %l5
  %t118 = alloca [2 x i8], align 1
  %t119 = getelementptr [2 x i8], [2 x i8]* %t118, i32 0, i32 0
  store i8 %t117, i8* %t119
  %t120 = getelementptr [2 x i8], [2 x i8]* %t118, i32 0, i32 1
  store i8 0, i8* %t120
  %t121 = getelementptr [2 x i8], [2 x i8]* %t118, i32 0, i32 0
  store i8* %t121, i8** %l4
  %t122 = load i8*, i8** %l1
  %t123 = load i8, i8* %l5
  %t124 = alloca [2 x i8], align 1
  %t125 = getelementptr [2 x i8], [2 x i8]* %t124, i32 0, i32 0
  store i8 %t123, i8* %t125
  %t126 = getelementptr [2 x i8], [2 x i8]* %t124, i32 0, i32 1
  store i8 0, i8* %t126
  %t127 = getelementptr [2 x i8], [2 x i8]* %t124, i32 0, i32 0
  %t128 = call i8* @sailfin_runtime_string_concat(i8* %t122, i8* %t127)
  store i8* %t128, i8** %l1
  %t129 = load double, double* %l2
  %t130 = sitofp i64 1 to double
  %t131 = fadd double %t129, %t130
  store double %t131, double* %l2
  br label %loop.latch2
merge15:
  %t133 = load i8, i8* %l5
  %t134 = icmp eq i8 %t133, 40
  br label %logical_or_entry_132

logical_or_entry_132:
  br i1 %t134, label %logical_or_merge_132, label %logical_or_right_132

logical_or_right_132:
  %t136 = load i8, i8* %l5
  %t137 = icmp eq i8 %t136, 91
  br label %logical_or_entry_135

logical_or_entry_135:
  br i1 %t137, label %logical_or_merge_135, label %logical_or_right_135

logical_or_right_135:
  %t138 = load i8, i8* %l5
  %t139 = icmp eq i8 %t138, 123
  br label %logical_or_right_end_135

logical_or_right_end_135:
  br label %logical_or_merge_135

logical_or_merge_135:
  %t140 = phi i1 [ true, %logical_or_entry_135 ], [ %t139, %logical_or_right_end_135 ]
  br label %logical_or_right_end_132

logical_or_right_end_132:
  br label %logical_or_merge_132

logical_or_merge_132:
  %t141 = phi i1 [ true, %logical_or_entry_132 ], [ %t140, %logical_or_right_end_132 ]
  %t142 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t143 = load i8*, i8** %l1
  %t144 = load double, double* %l2
  %t145 = load double, double* %l3
  %t146 = load i8*, i8** %l4
  %t147 = load i8, i8* %l5
  br i1 %t141, label %then16, label %merge17
then16:
  %t148 = load double, double* %l3
  %t149 = sitofp i64 1 to double
  %t150 = fadd double %t148, %t149
  store double %t150, double* %l3
  %t151 = load i8*, i8** %l1
  %t152 = load i8, i8* %l5
  %t153 = alloca [2 x i8], align 1
  %t154 = getelementptr [2 x i8], [2 x i8]* %t153, i32 0, i32 0
  store i8 %t152, i8* %t154
  %t155 = getelementptr [2 x i8], [2 x i8]* %t153, i32 0, i32 1
  store i8 0, i8* %t155
  %t156 = getelementptr [2 x i8], [2 x i8]* %t153, i32 0, i32 0
  %t157 = call i8* @sailfin_runtime_string_concat(i8* %t151, i8* %t156)
  store i8* %t157, i8** %l1
  %t158 = load double, double* %l2
  %t159 = sitofp i64 1 to double
  %t160 = fadd double %t158, %t159
  store double %t160, double* %l2
  br label %loop.latch2
merge17:
  %t162 = load i8, i8* %l5
  %t163 = icmp eq i8 %t162, 41
  br label %logical_or_entry_161

logical_or_entry_161:
  br i1 %t163, label %logical_or_merge_161, label %logical_or_right_161

logical_or_right_161:
  %t165 = load i8, i8* %l5
  %t166 = icmp eq i8 %t165, 93
  br label %logical_or_entry_164

logical_or_entry_164:
  br i1 %t166, label %logical_or_merge_164, label %logical_or_right_164

logical_or_right_164:
  %t167 = load i8, i8* %l5
  %t168 = icmp eq i8 %t167, 125
  br label %logical_or_right_end_164

logical_or_right_end_164:
  br label %logical_or_merge_164

logical_or_merge_164:
  %t169 = phi i1 [ true, %logical_or_entry_164 ], [ %t168, %logical_or_right_end_164 ]
  br label %logical_or_right_end_161

logical_or_right_end_161:
  br label %logical_or_merge_161

logical_or_merge_161:
  %t170 = phi i1 [ true, %logical_or_entry_161 ], [ %t169, %logical_or_right_end_161 ]
  %t171 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t172 = load i8*, i8** %l1
  %t173 = load double, double* %l2
  %t174 = load double, double* %l3
  %t175 = load i8*, i8** %l4
  %t176 = load i8, i8* %l5
  br i1 %t170, label %then18, label %merge19
then18:
  %t177 = load double, double* %l3
  %t178 = sitofp i64 0 to double
  %t179 = fcmp ogt double %t177, %t178
  %t180 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t181 = load i8*, i8** %l1
  %t182 = load double, double* %l2
  %t183 = load double, double* %l3
  %t184 = load i8*, i8** %l4
  %t185 = load i8, i8* %l5
  br i1 %t179, label %then20, label %merge21
then20:
  %t186 = load double, double* %l3
  %t187 = sitofp i64 1 to double
  %t188 = fsub double %t186, %t187
  store double %t188, double* %l3
  %t189 = load double, double* %l3
  br label %merge21
merge21:
  %t190 = phi double [ %t189, %then20 ], [ %t183, %then18 ]
  store double %t190, double* %l3
  %t191 = load i8*, i8** %l1
  %t192 = load i8, i8* %l5
  %t193 = alloca [2 x i8], align 1
  %t194 = getelementptr [2 x i8], [2 x i8]* %t193, i32 0, i32 0
  store i8 %t192, i8* %t194
  %t195 = getelementptr [2 x i8], [2 x i8]* %t193, i32 0, i32 1
  store i8 0, i8* %t195
  %t196 = getelementptr [2 x i8], [2 x i8]* %t193, i32 0, i32 0
  %t197 = call i8* @sailfin_runtime_string_concat(i8* %t191, i8* %t196)
  store i8* %t197, i8** %l1
  %t198 = load double, double* %l2
  %t199 = sitofp i64 1 to double
  %t200 = fadd double %t198, %t199
  store double %t200, double* %l2
  br label %loop.latch2
merge19:
  %t201 = load i8, i8* %l5
  %t202 = icmp eq i8 %t201, 44
  %t203 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t204 = load i8*, i8** %l1
  %t205 = load double, double* %l2
  %t206 = load double, double* %l3
  %t207 = load i8*, i8** %l4
  %t208 = load i8, i8* %l5
  br i1 %t202, label %then22, label %merge23
then22:
  %t209 = load double, double* %l3
  %t210 = sitofp i64 0 to double
  %t211 = fcmp oeq double %t209, %t210
  %t212 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t213 = load i8*, i8** %l1
  %t214 = load double, double* %l2
  %t215 = load double, double* %l3
  %t216 = load i8*, i8** %l4
  %t217 = load i8, i8* %l5
  br i1 %t211, label %then24, label %merge25
then24:
  %t218 = load i8*, i8** %l1
  %t219 = call i8* @trim_text(i8* %t218)
  store i8* %t219, i8** %l6
  %t220 = load i8*, i8** %l6
  %t221 = call i64 @sailfin_runtime_string_length(i8* %t220)
  %t222 = icmp sgt i64 %t221, 0
  %t223 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t224 = load i8*, i8** %l1
  %t225 = load double, double* %l2
  %t226 = load double, double* %l3
  %t227 = load i8*, i8** %l4
  %t228 = load i8, i8* %l5
  %t229 = load i8*, i8** %l6
  br i1 %t222, label %then26, label %merge27
then26:
  %t230 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t231 = load i8*, i8** %l6
  %t232 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t230, i8* %t231)
  store { i8**, i64 }* %t232, { i8**, i64 }** %l0
  %t233 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge27
merge27:
  %t234 = phi { i8**, i64 }* [ %t233, %then26 ], [ %t223, %then24 ]
  store { i8**, i64 }* %t234, { i8**, i64 }** %l0
  %s235 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s235, i8** %l1
  %t236 = load double, double* %l2
  %t237 = sitofp i64 1 to double
  %t238 = fadd double %t236, %t237
  store double %t238, double* %l2
  br label %loop.latch2
merge25:
  %t239 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t240 = load i8*, i8** %l1
  %t241 = load double, double* %l2
  br label %merge23
merge23:
  %t242 = phi { i8**, i64 }* [ %t239, %merge25 ], [ %t203, %merge19 ]
  %t243 = phi i8* [ %t240, %merge25 ], [ %t204, %merge19 ]
  %t244 = phi double [ %t241, %merge25 ], [ %t205, %merge19 ]
  store { i8**, i64 }* %t242, { i8**, i64 }** %l0
  store i8* %t243, i8** %l1
  store double %t244, double* %l2
  %t245 = load i8*, i8** %l1
  %t246 = load i8, i8* %l5
  %t247 = alloca [2 x i8], align 1
  %t248 = getelementptr [2 x i8], [2 x i8]* %t247, i32 0, i32 0
  store i8 %t246, i8* %t248
  %t249 = getelementptr [2 x i8], [2 x i8]* %t247, i32 0, i32 1
  store i8 0, i8* %t249
  %t250 = getelementptr [2 x i8], [2 x i8]* %t247, i32 0, i32 0
  %t251 = call i8* @sailfin_runtime_string_concat(i8* %t245, i8* %t250)
  store i8* %t251, i8** %l1
  %t252 = load double, double* %l2
  %t253 = sitofp i64 1 to double
  %t254 = fadd double %t252, %t253
  store double %t254, double* %l2
  br label %loop.latch2
loop.latch2:
  %t255 = load i8*, i8** %l1
  %t256 = load double, double* %l2
  %t257 = load i8*, i8** %l4
  %t258 = load double, double* %l3
  %t259 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t265 = load i8*, i8** %l1
  %t266 = load double, double* %l2
  %t267 = load i8*, i8** %l4
  %t268 = load double, double* %l3
  %t269 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t270 = load i8*, i8** %l1
  %t271 = call i8* @trim_text(i8* %t270)
  store i8* %t271, i8** %l7
  %t272 = load i8*, i8** %l7
  %t273 = call i64 @sailfin_runtime_string_length(i8* %t272)
  %t274 = icmp sgt i64 %t273, 0
  %t275 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t276 = load i8*, i8** %l1
  %t277 = load double, double* %l2
  %t278 = load double, double* %l3
  %t279 = load i8*, i8** %l4
  %t280 = load i8*, i8** %l7
  br i1 %t274, label %then28, label %merge29
then28:
  %t281 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t282 = load i8*, i8** %l7
  %t283 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t281, i8* %t282)
  store { i8**, i64 }* %t283, { i8**, i64 }** %l0
  %t284 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge29
merge29:
  %t285 = phi { i8**, i64 }* [ %t284, %then28 ], [ %t275, %afterloop3 ]
  store { i8**, i64 }* %t285, { i8**, i64 }** %l0
  %t286 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t286
}

define { i8**, i64 }* @parse_effect_list(i8* %text) {
block.entry:
  %l0 = alloca i8*
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %s2 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h268715771, i32 0, i32 0
  %t3 = icmp eq i8* %t1, %s2
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t6 = ptrtoint [0 x i8*]* %t5 to i64
  %t7 = icmp eq i64 %t6, 0
  %t8 = select i1 %t7, i64 1, i64 %t6
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to i8**
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t12 = ptrtoint { i8**, i64 }* %t11 to i64
  %t13 = call i8* @malloc(i64 %t12)
  %t14 = bitcast i8* %t13 to { i8**, i64 }*
  %t15 = getelementptr { i8**, i64 }, { i8**, i64 }* %t14, i32 0, i32 0
  store i8** %t10, i8*** %t15
  %t16 = getelementptr { i8**, i64 }, { i8**, i64 }* %t14, i32 0, i32 1
  store i64 0, i64* %t16
  ret { i8**, i64 }* %t14
merge1:
  %t17 = load i8*, i8** %l0
  %t18 = call { i8**, i64 }* @split_comma_separated(i8* %t17)
  ret { i8**, i64 }* %t18
}

define { i8**, i64 }* @split_whitespace(i8* %value) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca i8*
  %l4 = alloca i1
  %t0 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t1 = ptrtoint [0 x i8*]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to i8**
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t7 = ptrtoint { i8**, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { i8**, i64 }*
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 0
  store i8** %t5, i8*** %t10
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { i8**, i64 }* %t9, { i8**, i64 }** %l0
  %t12 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t13 = icmp eq i64 %t12, 0
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br i1 %t13, label %then0, label %merge1
then0:
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t15
merge1:
  %t16 = sitofp i64 -1 to double
  store double %t16, double* %l1
  %t17 = sitofp i64 0 to double
  store double %t17, double* %l2
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t19 = load double, double* %l1
  %t20 = load double, double* %l2
  br label %loop.header2
loop.header2:
  %t96 = phi { i8**, i64 }* [ %t18, %merge1 ], [ %t93, %loop.latch4 ]
  %t97 = phi double [ %t19, %merge1 ], [ %t94, %loop.latch4 ]
  %t98 = phi double [ %t20, %merge1 ], [ %t95, %loop.latch4 ]
  store { i8**, i64 }* %t96, { i8**, i64 }** %l0
  store double %t97, double* %l1
  store double %t98, double* %l2
  br label %loop.body3
loop.body3:
  %t21 = load double, double* %l2
  %t22 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t23 = sitofp i64 %t22 to double
  %t24 = fcmp oge double %t21, %t23
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t26 = load double, double* %l1
  %t27 = load double, double* %l2
  br i1 %t24, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t28 = load double, double* %l2
  %t29 = call i8* @text_char_at(i8* %value, double %t28)
  store i8* %t29, i8** %l3
  %t31 = load i8*, i8** %l3
  %t32 = load i8, i8* %t31
  %t33 = icmp eq i8 %t32, 32
  br label %logical_or_entry_30

logical_or_entry_30:
  br i1 %t33, label %logical_or_merge_30, label %logical_or_right_30

logical_or_right_30:
  %t35 = load i8*, i8** %l3
  %t36 = load i8, i8* %t35
  %t37 = icmp eq i8 %t36, 9
  br label %logical_or_entry_34

logical_or_entry_34:
  br i1 %t37, label %logical_or_merge_34, label %logical_or_right_34

logical_or_right_34:
  %t39 = load i8*, i8** %l3
  %t40 = load i8, i8* %t39
  %t41 = icmp eq i8 %t40, 10
  br label %logical_or_entry_38

logical_or_entry_38:
  br i1 %t41, label %logical_or_merge_38, label %logical_or_right_38

logical_or_right_38:
  %t42 = load i8*, i8** %l3
  %t43 = load i8, i8* %t42
  %t44 = icmp eq i8 %t43, 13
  br label %logical_or_right_end_38

logical_or_right_end_38:
  br label %logical_or_merge_38

logical_or_merge_38:
  %t45 = phi i1 [ true, %logical_or_entry_38 ], [ %t44, %logical_or_right_end_38 ]
  br label %logical_or_right_end_34

logical_or_right_end_34:
  br label %logical_or_merge_34

logical_or_merge_34:
  %t46 = phi i1 [ true, %logical_or_entry_34 ], [ %t45, %logical_or_right_end_34 ]
  br label %logical_or_right_end_30

logical_or_right_end_30:
  br label %logical_or_merge_30

logical_or_merge_30:
  %t47 = phi i1 [ true, %logical_or_entry_30 ], [ %t46, %logical_or_right_end_30 ]
  store i1 %t47, i1* %l4
  %t48 = load i1, i1* %l4
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t50 = load double, double* %l1
  %t51 = load double, double* %l2
  %t52 = load i8*, i8** %l3
  %t53 = load i1, i1* %l4
  br i1 %t48, label %then8, label %else9
then8:
  %t54 = load double, double* %l1
  %t55 = sitofp i64 0 to double
  %t56 = fcmp oge double %t54, %t55
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t58 = load double, double* %l1
  %t59 = load double, double* %l2
  %t60 = load i8*, i8** %l3
  %t61 = load i1, i1* %l4
  br i1 %t56, label %then11, label %merge12
then11:
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t63 = load double, double* %l1
  %t64 = load double, double* %l2
  %t65 = fptosi double %t63 to i64
  %t66 = fptosi double %t64 to i64
  %t67 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t65, i64 %t66)
  %t68 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t62, i8* %t67)
  store { i8**, i64 }* %t68, { i8**, i64 }** %l0
  %t69 = sitofp i64 -1 to double
  store double %t69, double* %l1
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t71 = load double, double* %l1
  br label %merge12
merge12:
  %t72 = phi { i8**, i64 }* [ %t70, %then11 ], [ %t57, %then8 ]
  %t73 = phi double [ %t71, %then11 ], [ %t58, %then8 ]
  store { i8**, i64 }* %t72, { i8**, i64 }** %l0
  store double %t73, double* %l1
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t75 = load double, double* %l1
  br label %merge10
else9:
  %t76 = load double, double* %l1
  %t77 = sitofp i64 0 to double
  %t78 = fcmp olt double %t76, %t77
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t80 = load double, double* %l1
  %t81 = load double, double* %l2
  %t82 = load i8*, i8** %l3
  %t83 = load i1, i1* %l4
  br i1 %t78, label %then13, label %merge14
then13:
  %t84 = load double, double* %l2
  store double %t84, double* %l1
  %t85 = load double, double* %l1
  br label %merge14
merge14:
  %t86 = phi double [ %t85, %then13 ], [ %t80, %else9 ]
  store double %t86, double* %l1
  %t87 = load double, double* %l1
  br label %merge10
merge10:
  %t88 = phi { i8**, i64 }* [ %t74, %merge12 ], [ %t49, %merge14 ]
  %t89 = phi double [ %t75, %merge12 ], [ %t87, %merge14 ]
  store { i8**, i64 }* %t88, { i8**, i64 }** %l0
  store double %t89, double* %l1
  %t90 = load double, double* %l2
  %t91 = sitofp i64 1 to double
  %t92 = fadd double %t90, %t91
  store double %t92, double* %l2
  br label %loop.latch4
loop.latch4:
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t94 = load double, double* %l1
  %t95 = load double, double* %l2
  br label %loop.header2
afterloop5:
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t100 = load double, double* %l1
  %t101 = load double, double* %l2
  %t102 = load double, double* %l1
  %t103 = sitofp i64 0 to double
  %t104 = fcmp oge double %t102, %t103
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t106 = load double, double* %l1
  %t107 = load double, double* %l2
  br i1 %t104, label %then15, label %merge16
then15:
  %t108 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t109 = load double, double* %l1
  %t110 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t111 = fptosi double %t109 to i64
  %t112 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t111, i64 %t110)
  %t113 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t108, i8* %t112)
  store { i8**, i64 }* %t113, { i8**, i64 }** %l0
  %t114 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge16
merge16:
  %t115 = phi { i8**, i64 }* [ %t114, %then15 ], [ %t105, %afterloop5 ]
  store { i8**, i64 }* %t115, { i8**, i64 }** %l0
  %t116 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t116
}

define %NumberParseResult @parse_decimal_number(i8* %text) {
block.entry:
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
  %t77 = phi double [ %t24, %merge1 ], [ %t75, %loop.latch4 ]
  %t78 = phi double [ %t23, %merge1 ], [ %t76, %loop.latch4 ]
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
  %t79 = load double, double* %l4
  %t80 = load double, double* %l3
  %t81 = insertvalue %NumberParseResult undef, i1 1, 0
  %t82 = load double, double* %l4
  %t83 = insertvalue %NumberParseResult %t81, double %t82, 1
  ret %NumberParseResult %t83
}

define { i8**, i64 }* @split_lines(i8* %value) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca i8
  %t0 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t1 = ptrtoint [0 x i8*]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to i8**
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t7 = ptrtoint { i8**, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { i8**, i64 }*
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 0
  store i8** %t5, i8*** %t10
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { i8**, i64 }* %t9, { i8**, i64 }** %l0
  %s12 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s12, i8** %l1
  %t13 = sitofp i64 0 to double
  store double %t13, double* %l2
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t15 = load i8*, i8** %l1
  %t16 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t56 = phi { i8**, i64 }* [ %t14, %block.entry ], [ %t53, %loop.latch2 ]
  %t57 = phi i8* [ %t15, %block.entry ], [ %t54, %loop.latch2 ]
  %t58 = phi double [ %t16, %block.entry ], [ %t55, %loop.latch2 ]
  store { i8**, i64 }* %t56, { i8**, i64 }** %l0
  store i8* %t57, i8** %l1
  store double %t58, double* %l2
  br label %loop.body1
loop.body1:
  %t17 = load double, double* %l2
  %t18 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t19 = sitofp i64 %t18 to double
  %t20 = fcmp oge double %t17, %t19
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t22 = load i8*, i8** %l1
  %t23 = load double, double* %l2
  br i1 %t20, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t24 = load double, double* %l2
  %t25 = fptosi double %t24 to i64
  %t26 = getelementptr i8, i8* %value, i64 %t25
  %t27 = load i8, i8* %t26
  store i8 %t27, i8* %l3
  %t28 = load i8, i8* %l3
  %t29 = icmp eq i8 %t28, 10
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t31 = load i8*, i8** %l1
  %t32 = load double, double* %l2
  %t33 = load i8, i8* %l3
  br i1 %t29, label %then6, label %else7
then6:
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t35 = load i8*, i8** %l1
  %t36 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t34, i8* %t35)
  store { i8**, i64 }* %t36, { i8**, i64 }** %l0
  %s37 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s37, i8** %l1
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t39 = load i8*, i8** %l1
  br label %merge8
else7:
  %t40 = load i8*, i8** %l1
  %t41 = load i8, i8* %l3
  %t42 = alloca [2 x i8], align 1
  %t43 = getelementptr [2 x i8], [2 x i8]* %t42, i32 0, i32 0
  store i8 %t41, i8* %t43
  %t44 = getelementptr [2 x i8], [2 x i8]* %t42, i32 0, i32 1
  store i8 0, i8* %t44
  %t45 = getelementptr [2 x i8], [2 x i8]* %t42, i32 0, i32 0
  %t46 = call i8* @sailfin_runtime_string_concat(i8* %t40, i8* %t45)
  store i8* %t46, i8** %l1
  %t47 = load i8*, i8** %l1
  br label %merge8
merge8:
  %t48 = phi { i8**, i64 }* [ %t38, %then6 ], [ %t30, %else7 ]
  %t49 = phi i8* [ %t39, %then6 ], [ %t47, %else7 ]
  store { i8**, i64 }* %t48, { i8**, i64 }** %l0
  store i8* %t49, i8** %l1
  %t50 = load double, double* %l2
  %t51 = sitofp i64 1 to double
  %t52 = fadd double %t50, %t51
  store double %t52, double* %l2
  br label %loop.latch2
loop.latch2:
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t54 = load i8*, i8** %l1
  %t55 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t60 = load i8*, i8** %l1
  %t61 = load double, double* %l2
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t63 = load i8*, i8** %l1
  %t64 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t62, i8* %t63)
  store { i8**, i64 }* %t64, { i8**, i64 }** %l0
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t65
}

define { i8**, i64 }* @split_comma_separated(i8* %value) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca i8
  %l4 = alloca { i8**, i64 }*
  %l5 = alloca i8*
  %t0 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t1 = ptrtoint [0 x i8*]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to i8**
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t7 = ptrtoint { i8**, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { i8**, i64 }*
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 0
  store i8** %t5, i8*** %t10
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { i8**, i64 }* %t9, { i8**, i64 }** %l0
  %s12 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s12, i8** %l1
  %t13 = sitofp i64 0 to double
  store double %t13, double* %l2
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t15 = load i8*, i8** %l1
  %t16 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t57 = phi { i8**, i64 }* [ %t14, %block.entry ], [ %t54, %loop.latch2 ]
  %t58 = phi i8* [ %t15, %block.entry ], [ %t55, %loop.latch2 ]
  %t59 = phi double [ %t16, %block.entry ], [ %t56, %loop.latch2 ]
  store { i8**, i64 }* %t57, { i8**, i64 }** %l0
  store i8* %t58, i8** %l1
  store double %t59, double* %l2
  br label %loop.body1
loop.body1:
  %t17 = load double, double* %l2
  %t18 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t19 = sitofp i64 %t18 to double
  %t20 = fcmp oge double %t17, %t19
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t22 = load i8*, i8** %l1
  %t23 = load double, double* %l2
  br i1 %t20, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t24 = load double, double* %l2
  %t25 = fptosi double %t24 to i64
  %t26 = getelementptr i8, i8* %value, i64 %t25
  %t27 = load i8, i8* %t26
  store i8 %t27, i8* %l3
  %t28 = load i8, i8* %l3
  %t29 = icmp eq i8 %t28, 44
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t31 = load i8*, i8** %l1
  %t32 = load double, double* %l2
  %t33 = load i8, i8* %l3
  br i1 %t29, label %then6, label %else7
then6:
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t35 = load i8*, i8** %l1
  %t36 = call i8* @trim_text(i8* %t35)
  %t37 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t34, i8* %t36)
  store { i8**, i64 }* %t37, { i8**, i64 }** %l0
  %s38 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s38, i8** %l1
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t40 = load i8*, i8** %l1
  br label %merge8
else7:
  %t41 = load i8*, i8** %l1
  %t42 = load i8, i8* %l3
  %t43 = alloca [2 x i8], align 1
  %t44 = getelementptr [2 x i8], [2 x i8]* %t43, i32 0, i32 0
  store i8 %t42, i8* %t44
  %t45 = getelementptr [2 x i8], [2 x i8]* %t43, i32 0, i32 1
  store i8 0, i8* %t45
  %t46 = getelementptr [2 x i8], [2 x i8]* %t43, i32 0, i32 0
  %t47 = call i8* @sailfin_runtime_string_concat(i8* %t41, i8* %t46)
  store i8* %t47, i8** %l1
  %t48 = load i8*, i8** %l1
  br label %merge8
merge8:
  %t49 = phi { i8**, i64 }* [ %t39, %then6 ], [ %t30, %else7 ]
  %t50 = phi i8* [ %t40, %then6 ], [ %t48, %else7 ]
  store { i8**, i64 }* %t49, { i8**, i64 }** %l0
  store i8* %t50, i8** %l1
  %t51 = load double, double* %l2
  %t52 = sitofp i64 1 to double
  %t53 = fadd double %t51, %t52
  store double %t53, double* %l2
  br label %loop.latch2
loop.latch2:
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t55 = load i8*, i8** %l1
  %t56 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t61 = load i8*, i8** %l1
  %t62 = load double, double* %l2
  %t63 = load i8*, i8** %l1
  %t64 = call i64 @sailfin_runtime_string_length(i8* %t63)
  %t65 = icmp sgt i64 %t64, 0
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t67 = load i8*, i8** %l1
  %t68 = load double, double* %l2
  br i1 %t65, label %then9, label %merge10
then9:
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t70 = load i8*, i8** %l1
  %t71 = call i8* @trim_text(i8* %t70)
  %t72 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t69, i8* %t71)
  store { i8**, i64 }* %t72, { i8**, i64 }** %l0
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge10
merge10:
  %t74 = phi { i8**, i64 }* [ %t73, %then9 ], [ %t66, %afterloop3 ]
  store { i8**, i64 }* %t74, { i8**, i64 }** %l0
  %t75 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t76 = ptrtoint [0 x i8*]* %t75 to i64
  %t77 = icmp eq i64 %t76, 0
  %t78 = select i1 %t77, i64 1, i64 %t76
  %t79 = call i8* @malloc(i64 %t78)
  %t80 = bitcast i8* %t79 to i8**
  %t81 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t82 = ptrtoint { i8**, i64 }* %t81 to i64
  %t83 = call i8* @malloc(i64 %t82)
  %t84 = bitcast i8* %t83 to { i8**, i64 }*
  %t85 = getelementptr { i8**, i64 }, { i8**, i64 }* %t84, i32 0, i32 0
  store i8** %t80, i8*** %t85
  %t86 = getelementptr { i8**, i64 }, { i8**, i64 }* %t84, i32 0, i32 1
  store i64 0, i64* %t86
  store { i8**, i64 }* %t84, { i8**, i64 }** %l4
  %t87 = sitofp i64 0 to double
  store double %t87, double* %l2
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t89 = load i8*, i8** %l1
  %t90 = load double, double* %l2
  %t91 = load { i8**, i64 }*, { i8**, i64 }** %l4
  br label %loop.header11
loop.header11:
  %t129 = phi { i8**, i64 }* [ %t91, %merge10 ], [ %t127, %loop.latch13 ]
  %t130 = phi double [ %t90, %merge10 ], [ %t128, %loop.latch13 ]
  store { i8**, i64 }* %t129, { i8**, i64 }** %l4
  store double %t130, double* %l2
  br label %loop.body12
loop.body12:
  %t92 = load double, double* %l2
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t94 = load { i8**, i64 }, { i8**, i64 }* %t93
  %t95 = extractvalue { i8**, i64 } %t94, 1
  %t96 = sitofp i64 %t95 to double
  %t97 = fcmp oge double %t92, %t96
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t99 = load i8*, i8** %l1
  %t100 = load double, double* %l2
  %t101 = load { i8**, i64 }*, { i8**, i64 }** %l4
  br i1 %t97, label %then15, label %merge16
then15:
  br label %afterloop14
merge16:
  %t102 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t103 = load double, double* %l2
  %t104 = fptosi double %t103 to i64
  %t105 = load { i8**, i64 }, { i8**, i64 }* %t102
  %t106 = extractvalue { i8**, i64 } %t105, 0
  %t107 = extractvalue { i8**, i64 } %t105, 1
  %t108 = icmp uge i64 %t104, %t107
  ; bounds check: %t108 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t104, i64 %t107)
  %t109 = getelementptr i8*, i8** %t106, i64 %t104
  %t110 = load i8*, i8** %t109
  store i8* %t110, i8** %l5
  %t111 = load i8*, i8** %l5
  %t112 = call i64 @sailfin_runtime_string_length(i8* %t111)
  %t113 = icmp sgt i64 %t112, 0
  %t114 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t115 = load i8*, i8** %l1
  %t116 = load double, double* %l2
  %t117 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t118 = load i8*, i8** %l5
  br i1 %t113, label %then17, label %merge18
then17:
  %t119 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t120 = load i8*, i8** %l5
  %t121 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t119, i8* %t120)
  store { i8**, i64 }* %t121, { i8**, i64 }** %l4
  %t122 = load { i8**, i64 }*, { i8**, i64 }** %l4
  br label %merge18
merge18:
  %t123 = phi { i8**, i64 }* [ %t122, %then17 ], [ %t117, %merge16 ]
  store { i8**, i64 }* %t123, { i8**, i64 }** %l4
  %t124 = load double, double* %l2
  %t125 = sitofp i64 1 to double
  %t126 = fadd double %t124, %t125
  store double %t126, double* %l2
  br label %loop.latch13
loop.latch13:
  %t127 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t128 = load double, double* %l2
  br label %loop.header11
afterloop14:
  %t131 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t132 = load double, double* %l2
  %t133 = load { i8**, i64 }*, { i8**, i64 }** %l4
  ret { i8**, i64 }* %t133
}

define i8* @strip_generics(i8* %name) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca i8
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
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
  %t72 = phi double [ %t4, %block.entry ], [ %t69, %loop.latch2 ]
  %t73 = phi double [ %t5, %block.entry ], [ %t70, %loop.latch2 ]
  %t74 = phi i8* [ %t3, %block.entry ], [ %t71, %loop.latch2 ]
  store double %t72, double* %l1
  store double %t73, double* %l2
  store i8* %t74, i8** %l0
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
  %t45 = load double, double* %l1
  br label %merge11
merge11:
  %t46 = phi double [ %t45, %then10 ], [ %t39, %then8 ]
  store double %t46, double* %l1
  %t47 = load double, double* %l2
  %t48 = sitofp i64 1 to double
  %t49 = fadd double %t47, %t48
  store double %t49, double* %l2
  br label %loop.latch2
merge9:
  %t50 = load double, double* %l1
  %t51 = sitofp i64 0 to double
  %t52 = fcmp oeq double %t50, %t51
  %t53 = load i8*, i8** %l0
  %t54 = load double, double* %l1
  %t55 = load double, double* %l2
  %t56 = load i8, i8* %l3
  br i1 %t52, label %then12, label %merge13
then12:
  %t57 = load i8*, i8** %l0
  %t58 = load i8, i8* %l3
  %t59 = alloca [2 x i8], align 1
  %t60 = getelementptr [2 x i8], [2 x i8]* %t59, i32 0, i32 0
  store i8 %t58, i8* %t60
  %t61 = getelementptr [2 x i8], [2 x i8]* %t59, i32 0, i32 1
  store i8 0, i8* %t61
  %t62 = getelementptr [2 x i8], [2 x i8]* %t59, i32 0, i32 0
  %t63 = call i8* @sailfin_runtime_string_concat(i8* %t57, i8* %t62)
  store i8* %t63, i8** %l0
  %t64 = load i8*, i8** %l0
  br label %merge13
merge13:
  %t65 = phi i8* [ %t64, %then12 ], [ %t53, %merge9 ]
  store i8* %t65, i8** %l0
  %t66 = load double, double* %l2
  %t67 = sitofp i64 1 to double
  %t68 = fadd double %t66, %t67
  store double %t68, double* %l2
  br label %loop.latch2
loop.latch2:
  %t69 = load double, double* %l1
  %t70 = load double, double* %l2
  %t71 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t75 = load double, double* %l1
  %t76 = load double, double* %l2
  %t77 = load i8*, i8** %l0
  %t78 = load i8*, i8** %l0
  %t79 = call i8* @trim_text(i8* %t78)
  ret i8* %t79
}

define i8* @trim_text(i8* %value) {
block.entry:
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
  %t27 = phi double [ %t3, %block.entry ], [ %t26, %loop.latch2 ]
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
  %t29 = load double, double* %l0
  %t30 = load double, double* %l1
  br label %loop.header8
loop.header8:
  %t55 = phi double [ %t30, %afterloop3 ], [ %t54, %loop.latch10 ]
  store double %t55, double* %l1
  br label %loop.body9
loop.body9:
  %t31 = load double, double* %l1
  %t32 = load double, double* %l0
  %t33 = fcmp ole double %t31, %t32
  %t34 = load double, double* %l0
  %t35 = load double, double* %l1
  br i1 %t33, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t36 = load double, double* %l1
  %t37 = sitofp i64 1 to double
  %t38 = fsub double %t36, %t37
  %t39 = fptosi double %t38 to i64
  %t40 = getelementptr i8, i8* %value, i64 %t39
  %t41 = load i8, i8* %t40
  store i8 %t41, i8* %l3
  %t42 = load i8, i8* %l3
  %t43 = alloca [2 x i8], align 1
  %t44 = getelementptr [2 x i8], [2 x i8]* %t43, i32 0, i32 0
  store i8 %t42, i8* %t44
  %t45 = getelementptr [2 x i8], [2 x i8]* %t43, i32 0, i32 1
  store i8 0, i8* %t45
  %t46 = getelementptr [2 x i8], [2 x i8]* %t43, i32 0, i32 0
  %t47 = call i1 @is_trim_char(i8* %t46)
  %t48 = load double, double* %l0
  %t49 = load double, double* %l1
  %t50 = load i8, i8* %l3
  br i1 %t47, label %then14, label %merge15
then14:
  %t51 = load double, double* %l1
  %t52 = sitofp i64 1 to double
  %t53 = fsub double %t51, %t52
  store double %t53, double* %l1
  br label %loop.latch10
merge15:
  br label %afterloop11
loop.latch10:
  %t54 = load double, double* %l1
  br label %loop.header8
afterloop11:
  %t56 = load double, double* %l1
  %t58 = load double, double* %l0
  %t59 = sitofp i64 0 to double
  %t60 = fcmp oeq double %t58, %t59
  br label %logical_and_entry_57

logical_and_entry_57:
  br i1 %t60, label %logical_and_right_57, label %logical_and_merge_57

logical_and_right_57:
  %t61 = load double, double* %l1
  %t62 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t63 = sitofp i64 %t62 to double
  %t64 = fcmp oeq double %t61, %t63
  br label %logical_and_right_end_57

logical_and_right_end_57:
  br label %logical_and_merge_57

logical_and_merge_57:
  %t65 = phi i1 [ false, %logical_and_entry_57 ], [ %t64, %logical_and_right_end_57 ]
  %t66 = load double, double* %l0
  %t67 = load double, double* %l1
  br i1 %t65, label %then16, label %merge17
then16:
  ret i8* %value
merge17:
  %t68 = load double, double* %l0
  %t69 = load double, double* %l1
  %t70 = fptosi double %t68 to i64
  %t71 = fptosi double %t69 to i64
  %t72 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t70, i64 %t71)
  ret i8* %t72
}

define %LayoutManifest @parse_layout_manifest(i8* %text) {
block.entry:
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
  %t1 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t2 = ptrtoint [0 x i8*]* %t1 to i64
  %t3 = icmp eq i64 %t2, 0
  %t4 = select i1 %t3, i64 1, i64 %t2
  %t5 = call i8* @malloc(i64 %t4)
  %t6 = bitcast i8* %t5 to i8**
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t8 = ptrtoint { i8**, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { i8**, i64 }*
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 0
  store i8** %t6, i8*** %t11
  %t12 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 1
  store i64 0, i64* %t12
  store { i8**, i64 }* %t10, { i8**, i64 }** %l1
  %t13 = getelementptr [0 x %NativeStruct], [0 x %NativeStruct]* null, i32 1
  %t14 = ptrtoint [0 x %NativeStruct]* %t13 to i64
  %t15 = icmp eq i64 %t14, 0
  %t16 = select i1 %t15, i64 1, i64 %t14
  %t17 = call i8* @malloc(i64 %t16)
  %t18 = bitcast i8* %t17 to %NativeStruct*
  %t19 = getelementptr { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* null, i32 1
  %t20 = ptrtoint { %NativeStruct*, i64 }* %t19 to i64
  %t21 = call i8* @malloc(i64 %t20)
  %t22 = bitcast i8* %t21 to { %NativeStruct*, i64 }*
  %t23 = getelementptr { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* %t22, i32 0, i32 0
  store %NativeStruct* %t18, %NativeStruct** %t23
  %t24 = getelementptr { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* %t22, i32 0, i32 1
  store i64 0, i64* %t24
  store { %NativeStruct*, i64 }* %t22, { %NativeStruct*, i64 }** %l2
  %t25 = getelementptr [0 x %NativeEnum], [0 x %NativeEnum]* null, i32 1
  %t26 = ptrtoint [0 x %NativeEnum]* %t25 to i64
  %t27 = icmp eq i64 %t26, 0
  %t28 = select i1 %t27, i64 1, i64 %t26
  %t29 = call i8* @malloc(i64 %t28)
  %t30 = bitcast i8* %t29 to %NativeEnum*
  %t31 = getelementptr { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* null, i32 1
  %t32 = ptrtoint { %NativeEnum*, i64 }* %t31 to i64
  %t33 = call i8* @malloc(i64 %t32)
  %t34 = bitcast i8* %t33 to { %NativeEnum*, i64 }*
  %t35 = getelementptr { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* %t34, i32 0, i32 0
  store %NativeEnum* %t30, %NativeEnum** %t35
  %t36 = getelementptr { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* %t34, i32 0, i32 1
  store i64 0, i64* %t36
  store { %NativeEnum*, i64 }* %t34, { %NativeEnum*, i64 }** %l3
  %t37 = sitofp i64 0 to double
  store double %t37, double* %l4
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t40 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t41 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t42 = load double, double* %l4
  br label %loop.header0
loop.header0:
  %t716 = phi double [ %t42, %block.entry ], [ %t712, %loop.latch2 ]
  %t717 = phi { i8**, i64 }* [ %t39, %block.entry ], [ %t713, %loop.latch2 ]
  %t718 = phi { %NativeStruct*, i64 }* [ %t40, %block.entry ], [ %t714, %loop.latch2 ]
  %t719 = phi { %NativeEnum*, i64 }* [ %t41, %block.entry ], [ %t715, %loop.latch2 ]
  store double %t716, double* %l4
  store { i8**, i64 }* %t717, { i8**, i64 }** %l1
  store { %NativeStruct*, i64 }* %t718, { %NativeStruct*, i64 }** %l2
  store { %NativeEnum*, i64 }* %t719, { %NativeEnum*, i64 }** %l3
  br label %loop.body1
loop.body1:
  %t43 = load double, double* %l4
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t45 = load { i8**, i64 }, { i8**, i64 }* %t44
  %t46 = extractvalue { i8**, i64 } %t45, 1
  %t47 = sitofp i64 %t46 to double
  %t48 = fcmp oge double %t43, %t47
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t51 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t52 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t53 = load double, double* %l4
  br i1 %t48, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t55 = load double, double* %l4
  %t56 = fptosi double %t55 to i64
  %t57 = load { i8**, i64 }, { i8**, i64 }* %t54
  %t58 = extractvalue { i8**, i64 } %t57, 0
  %t59 = extractvalue { i8**, i64 } %t57, 1
  %t60 = icmp uge i64 %t56, %t59
  ; bounds check: %t60 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t56, i64 %t59)
  %t61 = getelementptr i8*, i8** %t58, i64 %t56
  %t62 = load i8*, i8** %t61
  store i8* %t62, i8** %l5
  %t63 = load i8*, i8** %l5
  %t64 = call i8* @trim_text(i8* %t63)
  store i8* %t64, i8** %l6
  %t65 = load i8*, i8** %l6
  %t66 = call i64 @sailfin_runtime_string_length(i8* %t65)
  %t67 = icmp eq i64 %t66, 0
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t70 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t71 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t72 = load double, double* %l4
  %t73 = load i8*, i8** %l5
  %t74 = load i8*, i8** %l6
  br i1 %t67, label %then6, label %merge7
then6:
  %t75 = load double, double* %l4
  %t76 = sitofp i64 1 to double
  %t77 = fadd double %t75, %t76
  store double %t77, double* %l4
  br label %loop.latch2
merge7:
  %t78 = load i8*, i8** %l6
  %t79 = alloca [2 x i8], align 1
  %t80 = getelementptr [2 x i8], [2 x i8]* %t79, i32 0, i32 0
  store i8 59, i8* %t80
  %t81 = getelementptr [2 x i8], [2 x i8]* %t79, i32 0, i32 1
  store i8 0, i8* %t81
  %t82 = getelementptr [2 x i8], [2 x i8]* %t79, i32 0, i32 0
  %t83 = call i1 @starts_with(i8* %t78, i8* %t82)
  %t84 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t86 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t87 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t88 = load double, double* %l4
  %t89 = load i8*, i8** %l5
  %t90 = load i8*, i8** %l6
  br i1 %t83, label %then8, label %merge9
then8:
  %t91 = load double, double* %l4
  %t92 = sitofp i64 1 to double
  %t93 = fadd double %t91, %t92
  store double %t93, double* %l4
  br label %loop.latch2
merge9:
  %t94 = load i8*, i8** %l6
  %s95 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h1219235236, i32 0, i32 0
  %t96 = call i1 @starts_with(i8* %t94, i8* %s95)
  %t97 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t99 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t100 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t101 = load double, double* %l4
  %t102 = load i8*, i8** %l5
  %t103 = load i8*, i8** %l6
  br i1 %t96, label %then10, label %merge11
then10:
  %t104 = load double, double* %l4
  %t105 = sitofp i64 1 to double
  %t106 = fadd double %t104, %t105
  store double %t106, double* %l4
  br label %loop.latch2
merge11:
  %t107 = load i8*, i8** %l6
  %s108 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h87749209, i32 0, i32 0
  %t109 = call i1 @starts_with(i8* %t107, i8* %s108)
  %t110 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t111 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t112 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t113 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t114 = load double, double* %l4
  %t115 = load i8*, i8** %l5
  %t116 = load i8*, i8** %l6
  br i1 %t109, label %then12, label %merge13
then12:
  %t117 = load i8*, i8** %l6
  %s118 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1616485352, i32 0, i32 0
  %t119 = call i8* @strip_prefix(i8* %t117, i8* %s118)
  store i8* %t119, i8** %l7
  %t120 = load i8*, i8** %l7
  %s121 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t122 = call i8* @strip_prefix(i8* %t120, i8* %s121)
  store i8* %t122, i8** %l8
  %t123 = load i8*, i8** %l8
  %t124 = call %StructLayoutHeaderParse @parse_struct_layout_header(i8* %t123)
  store %StructLayoutHeaderParse %t124, %StructLayoutHeaderParse* %l9
  %t125 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t126 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t127 = extractvalue %StructLayoutHeaderParse %t126, 4
  %t128 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t125, { i8**, i64 }* %t127)
  store { i8**, i64 }* %t128, { i8**, i64 }** %l1
  %t129 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t130 = extractvalue %StructLayoutHeaderParse %t129, 0
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
  br i1 %t130, label %then14, label %merge15
then14:
  %t141 = getelementptr [0 x %NativeStructLayoutField], [0 x %NativeStructLayoutField]* null, i32 1
  %t142 = ptrtoint [0 x %NativeStructLayoutField]* %t141 to i64
  %t143 = icmp eq i64 %t142, 0
  %t144 = select i1 %t143, i64 1, i64 %t142
  %t145 = call i8* @malloc(i64 %t144)
  %t146 = bitcast i8* %t145 to %NativeStructLayoutField*
  %t147 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* null, i32 1
  %t148 = ptrtoint { %NativeStructLayoutField*, i64 }* %t147 to i64
  %t149 = call i8* @malloc(i64 %t148)
  %t150 = bitcast i8* %t149 to { %NativeStructLayoutField*, i64 }*
  %t151 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t150, i32 0, i32 0
  store %NativeStructLayoutField* %t146, %NativeStructLayoutField** %t151
  %t152 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t150, i32 0, i32 1
  store i64 0, i64* %t152
  store { %NativeStructLayoutField*, i64 }* %t150, { %NativeStructLayoutField*, i64 }** %l10
  %t153 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t154 = extractvalue %StructLayoutHeaderParse %t153, 1
  store i8* %t154, i8** %l11
  %t155 = load double, double* %l4
  %t156 = sitofp i64 1 to double
  %t157 = fadd double %t155, %t156
  store double %t157, double* %l4
  %t158 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t159 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t160 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t161 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t162 = load double, double* %l4
  %t163 = load i8*, i8** %l5
  %t164 = load i8*, i8** %l6
  %t165 = load i8*, i8** %l7
  %t166 = load i8*, i8** %l8
  %t167 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t168 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t169 = load i8*, i8** %l11
  br label %loop.header16
loop.header16:
  %t275 = phi i8* [ %t165, %then14 ], [ %t271, %loop.latch18 ]
  %t276 = phi { i8**, i64 }* [ %t159, %then14 ], [ %t272, %loop.latch18 ]
  %t277 = phi { %NativeStructLayoutField*, i64 }* [ %t168, %then14 ], [ %t273, %loop.latch18 ]
  %t278 = phi double [ %t162, %then14 ], [ %t274, %loop.latch18 ]
  store i8* %t275, i8** %l7
  store { i8**, i64 }* %t276, { i8**, i64 }** %l1
  store { %NativeStructLayoutField*, i64 }* %t277, { %NativeStructLayoutField*, i64 }** %l10
  store double %t278, double* %l4
  br label %loop.body17
loop.body17:
  %t170 = load double, double* %l4
  %t171 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t172 = load { i8**, i64 }, { i8**, i64 }* %t171
  %t173 = extractvalue { i8**, i64 } %t172, 1
  %t174 = sitofp i64 %t173 to double
  %t175 = fcmp oge double %t170, %t174
  %t176 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t177 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t178 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t179 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t180 = load double, double* %l4
  %t181 = load i8*, i8** %l5
  %t182 = load i8*, i8** %l6
  %t183 = load i8*, i8** %l7
  %t184 = load i8*, i8** %l8
  %t185 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t186 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t187 = load i8*, i8** %l11
  br i1 %t175, label %then20, label %merge21
then20:
  br label %afterloop19
merge21:
  %t188 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t189 = load double, double* %l4
  %t190 = fptosi double %t189 to i64
  %t191 = load { i8**, i64 }, { i8**, i64 }* %t188
  %t192 = extractvalue { i8**, i64 } %t191, 0
  %t193 = extractvalue { i8**, i64 } %t191, 1
  %t194 = icmp uge i64 %t190, %t193
  ; bounds check: %t194 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t190, i64 %t193)
  %t195 = getelementptr i8*, i8** %t192, i64 %t190
  %t196 = load i8*, i8** %t195
  %t197 = call i8* @trim_text(i8* %t196)
  store i8* %t197, i8** %l12
  %t198 = load i8*, i8** %l12
  %t199 = call i64 @sailfin_runtime_string_length(i8* %t198)
  %t200 = icmp eq i64 %t199, 0
  %t201 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t202 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t203 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t204 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t205 = load double, double* %l4
  %t206 = load i8*, i8** %l5
  %t207 = load i8*, i8** %l6
  %t208 = load i8*, i8** %l7
  %t209 = load i8*, i8** %l8
  %t210 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t211 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t212 = load i8*, i8** %l11
  %t213 = load i8*, i8** %l12
  br i1 %t200, label %then22, label %merge23
then22:
  br label %afterloop19
merge23:
  %t214 = load i8*, i8** %l12
  %s215 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h1053492670, i32 0, i32 0
  %t216 = call i1 @starts_with(i8* %t214, i8* %s215)
  %t217 = xor i1 %t216, 1
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
  br i1 %t217, label %then24, label %merge25
then24:
  br label %afterloop19
merge25:
  %t231 = load i8*, i8** %l12
  %s232 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1616485352, i32 0, i32 0
  %t233 = call i8* @strip_prefix(i8* %t231, i8* %s232)
  store i8* %t233, i8** %l13
  %t234 = load i8*, i8** %l7
  %s235 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h734244628, i32 0, i32 0
  %t236 = call i8* @strip_prefix(i8* %t234, i8* %s235)
  store i8* %t236, i8** %l14
  %t237 = load i8*, i8** %l14
  %t238 = load i8*, i8** %l11
  %t239 = call %StructLayoutFieldParse @parse_struct_layout_field(i8* %t237, i8* %t238)
  store %StructLayoutFieldParse %t239, %StructLayoutFieldParse* %l15
  %t240 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t241 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  %t242 = extractvalue %StructLayoutFieldParse %t241, 2
  %t243 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t240, { i8**, i64 }* %t242)
  store { i8**, i64 }* %t243, { i8**, i64 }** %l1
  %t244 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  %t245 = extractvalue %StructLayoutFieldParse %t244, 0
  %t246 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t247 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t248 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t249 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t250 = load double, double* %l4
  %t251 = load i8*, i8** %l5
  %t252 = load i8*, i8** %l6
  %t253 = load i8*, i8** %l7
  %t254 = load i8*, i8** %l8
  %t255 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t256 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t257 = load i8*, i8** %l11
  %t258 = load i8*, i8** %l12
  %t259 = load i8*, i8** %l13
  %t260 = load i8*, i8** %l14
  %t261 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  br i1 %t245, label %then26, label %merge27
then26:
  %t262 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t263 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  %t264 = extractvalue %StructLayoutFieldParse %t263, 1
  %t265 = call { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %t262, %NativeStructLayoutField %t264)
  store { %NativeStructLayoutField*, i64 }* %t265, { %NativeStructLayoutField*, i64 }** %l10
  %t266 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  br label %merge27
merge27:
  %t267 = phi { %NativeStructLayoutField*, i64 }* [ %t266, %then26 ], [ %t256, %merge25 ]
  store { %NativeStructLayoutField*, i64 }* %t267, { %NativeStructLayoutField*, i64 }** %l10
  %t268 = load double, double* %l4
  %t269 = sitofp i64 1 to double
  %t270 = fadd double %t268, %t269
  store double %t270, double* %l4
  br label %loop.latch18
loop.latch18:
  %t271 = load i8*, i8** %l7
  %t272 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t273 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t274 = load double, double* %l4
  br label %loop.header16
afterloop19:
  %t279 = load i8*, i8** %l7
  %t280 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t281 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t282 = load double, double* %l4
  %t283 = load i8*, i8** %l11
  %t284 = insertvalue %NativeStruct undef, i8* %t283, 0
  %t285 = getelementptr [0 x %NativeStructField*], [0 x %NativeStructField*]* null, i32 1
  %t286 = ptrtoint [0 x %NativeStructField*]* %t285 to i64
  %t287 = icmp eq i64 %t286, 0
  %t288 = select i1 %t287, i64 1, i64 %t286
  %t289 = call i8* @malloc(i64 %t288)
  %t290 = bitcast i8* %t289 to %NativeStructField**
  %t291 = getelementptr { %NativeStructField**, i64 }, { %NativeStructField**, i64 }* null, i32 1
  %t292 = ptrtoint { %NativeStructField**, i64 }* %t291 to i64
  %t293 = call i8* @malloc(i64 %t292)
  %t294 = bitcast i8* %t293 to { %NativeStructField**, i64 }*
  %t295 = getelementptr { %NativeStructField**, i64 }, { %NativeStructField**, i64 }* %t294, i32 0, i32 0
  store %NativeStructField** %t290, %NativeStructField*** %t295
  %t296 = getelementptr { %NativeStructField**, i64 }, { %NativeStructField**, i64 }* %t294, i32 0, i32 1
  store i64 0, i64* %t296
  %t297 = insertvalue %NativeStruct %t284, { %NativeStructField**, i64 }* %t294, 1
  %t298 = getelementptr [0 x %NativeFunction*], [0 x %NativeFunction*]* null, i32 1
  %t299 = ptrtoint [0 x %NativeFunction*]* %t298 to i64
  %t300 = icmp eq i64 %t299, 0
  %t301 = select i1 %t300, i64 1, i64 %t299
  %t302 = call i8* @malloc(i64 %t301)
  %t303 = bitcast i8* %t302 to %NativeFunction**
  %t304 = getelementptr { %NativeFunction**, i64 }, { %NativeFunction**, i64 }* null, i32 1
  %t305 = ptrtoint { %NativeFunction**, i64 }* %t304 to i64
  %t306 = call i8* @malloc(i64 %t305)
  %t307 = bitcast i8* %t306 to { %NativeFunction**, i64 }*
  %t308 = getelementptr { %NativeFunction**, i64 }, { %NativeFunction**, i64 }* %t307, i32 0, i32 0
  store %NativeFunction** %t303, %NativeFunction*** %t308
  %t309 = getelementptr { %NativeFunction**, i64 }, { %NativeFunction**, i64 }* %t307, i32 0, i32 1
  store i64 0, i64* %t309
  %t310 = insertvalue %NativeStruct %t297, { %NativeFunction**, i64 }* %t307, 2
  %t311 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t312 = ptrtoint [0 x i8*]* %t311 to i64
  %t313 = icmp eq i64 %t312, 0
  %t314 = select i1 %t313, i64 1, i64 %t312
  %t315 = call i8* @malloc(i64 %t314)
  %t316 = bitcast i8* %t315 to i8**
  %t317 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t318 = ptrtoint { i8**, i64 }* %t317 to i64
  %t319 = call i8* @malloc(i64 %t318)
  %t320 = bitcast i8* %t319 to { i8**, i64 }*
  %t321 = getelementptr { i8**, i64 }, { i8**, i64 }* %t320, i32 0, i32 0
  store i8** %t316, i8*** %t321
  %t322 = getelementptr { i8**, i64 }, { i8**, i64 }* %t320, i32 0, i32 1
  store i64 0, i64* %t322
  %t323 = insertvalue %NativeStruct %t310, { i8**, i64 }* %t320, 3
  %t324 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t325 = extractvalue %StructLayoutHeaderParse %t324, 2
  %t326 = insertvalue %NativeStructLayout undef, double %t325, 0
  %t327 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t328 = extractvalue %StructLayoutHeaderParse %t327, 3
  %t329 = insertvalue %NativeStructLayout %t326, double %t328, 1
  %t330 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t331 = bitcast { %NativeStructLayoutField*, i64 }* %t330 to { %NativeStructLayoutField**, i64 }*
  %t332 = insertvalue %NativeStructLayout %t329, { %NativeStructLayoutField**, i64 }* %t331, 2
  %t333 = alloca %NativeStructLayout
  store %NativeStructLayout %t332, %NativeStructLayout* %t333
  %t334 = insertvalue %NativeStruct %t323, %NativeStructLayout* %t333, 4
  store %NativeStruct %t334, %NativeStruct* %l16
  %t335 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t336 = load %NativeStruct, %NativeStruct* %l16
  %t337 = call { %NativeStruct*, i64 }* @append_struct({ %NativeStruct*, i64 }* %t335, %NativeStruct %t336)
  store { %NativeStruct*, i64 }* %t337, { %NativeStruct*, i64 }** %l2
  %t338 = load double, double* %l4
  %t339 = load i8*, i8** %l7
  %t340 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t341 = load double, double* %l4
  %t342 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  br label %merge15
merge15:
  %t343 = phi double [ %t338, %afterloop19 ], [ %t135, %then12 ]
  %t344 = phi i8* [ %t339, %afterloop19 ], [ %t138, %then12 ]
  %t345 = phi { i8**, i64 }* [ %t340, %afterloop19 ], [ %t132, %then12 ]
  %t346 = phi double [ %t341, %afterloop19 ], [ %t135, %then12 ]
  %t347 = phi { %NativeStruct*, i64 }* [ %t342, %afterloop19 ], [ %t133, %then12 ]
  store double %t343, double* %l4
  store i8* %t344, i8** %l7
  store { i8**, i64 }* %t345, { i8**, i64 }** %l1
  store double %t346, double* %l4
  store { %NativeStruct*, i64 }* %t347, { %NativeStruct*, i64 }** %l2
  %t348 = load double, double* %l4
  %t349 = sitofp i64 1 to double
  %t350 = fadd double %t348, %t349
  store double %t350, double* %l4
  br label %loop.latch2
merge13:
  %t351 = load i8*, i8** %l6
  %s352 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.len13.h259593098, i32 0, i32 0
  %t353 = call i1 @starts_with(i8* %t351, i8* %s352)
  %t354 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t355 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t356 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t357 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t358 = load double, double* %l4
  %t359 = load i8*, i8** %l5
  %t360 = load i8*, i8** %l6
  br i1 %t353, label %then28, label %merge29
then28:
  %t361 = load i8*, i8** %l6
  %s362 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1616485352, i32 0, i32 0
  %t363 = call i8* @strip_prefix(i8* %t361, i8* %s362)
  store i8* %t363, i8** %l17
  %t364 = load i8*, i8** %l17
  %s365 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t366 = call i8* @strip_prefix(i8* %t364, i8* %s365)
  store i8* %t366, i8** %l18
  %t367 = load i8*, i8** %l18
  %t368 = call %EnumLayoutHeaderParse @parse_enum_layout_header(i8* %t367)
  store %EnumLayoutHeaderParse %t368, %EnumLayoutHeaderParse* %l19
  %t369 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t370 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t371 = extractvalue %EnumLayoutHeaderParse %t370, 7
  %t372 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t369, { i8**, i64 }* %t371)
  store { i8**, i64 }* %t372, { i8**, i64 }** %l1
  %t373 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t374 = extractvalue %EnumLayoutHeaderParse %t373, 0
  %t375 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t376 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t377 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t378 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t379 = load double, double* %l4
  %t380 = load i8*, i8** %l5
  %t381 = load i8*, i8** %l6
  %t382 = load i8*, i8** %l17
  %t383 = load i8*, i8** %l18
  %t384 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  br i1 %t374, label %then30, label %else31
then30:
  %t385 = getelementptr [0 x %NativeEnumVariantLayout], [0 x %NativeEnumVariantLayout]* null, i32 1
  %t386 = ptrtoint [0 x %NativeEnumVariantLayout]* %t385 to i64
  %t387 = icmp eq i64 %t386, 0
  %t388 = select i1 %t387, i64 1, i64 %t386
  %t389 = call i8* @malloc(i64 %t388)
  %t390 = bitcast i8* %t389 to %NativeEnumVariantLayout*
  %t391 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* null, i32 1
  %t392 = ptrtoint { %NativeEnumVariantLayout*, i64 }* %t391 to i64
  %t393 = call i8* @malloc(i64 %t392)
  %t394 = bitcast i8* %t393 to { %NativeEnumVariantLayout*, i64 }*
  %t395 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t394, i32 0, i32 0
  store %NativeEnumVariantLayout* %t390, %NativeEnumVariantLayout** %t395
  %t396 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t394, i32 0, i32 1
  store i64 0, i64* %t396
  store { %NativeEnumVariantLayout*, i64 }* %t394, { %NativeEnumVariantLayout*, i64 }** %l20
  %t397 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t398 = extractvalue %EnumLayoutHeaderParse %t397, 1
  store i8* %t398, i8** %l21
  %t399 = load double, double* %l4
  %t400 = sitofp i64 1 to double
  %t401 = fadd double %t399, %t400
  store double %t401, double* %l4
  %t402 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t403 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t404 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t405 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t406 = load double, double* %l4
  %t407 = load i8*, i8** %l5
  %t408 = load i8*, i8** %l6
  %t409 = load i8*, i8** %l17
  %t410 = load i8*, i8** %l18
  %t411 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t412 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t413 = load i8*, i8** %l21
  br label %loop.header33
loop.header33:
  %t650 = phi double [ %t406, %then30 ], [ %t646, %loop.latch35 ]
  %t651 = phi i8* [ %t409, %then30 ], [ %t647, %loop.latch35 ]
  %t652 = phi { i8**, i64 }* [ %t403, %then30 ], [ %t648, %loop.latch35 ]
  %t653 = phi { %NativeEnumVariantLayout*, i64 }* [ %t412, %then30 ], [ %t649, %loop.latch35 ]
  store double %t650, double* %l4
  store i8* %t651, i8** %l17
  store { i8**, i64 }* %t652, { i8**, i64 }** %l1
  store { %NativeEnumVariantLayout*, i64 }* %t653, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %loop.body34
loop.body34:
  %t414 = load double, double* %l4
  %t415 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t416 = load { i8**, i64 }, { i8**, i64 }* %t415
  %t417 = extractvalue { i8**, i64 } %t416, 1
  %t418 = sitofp i64 %t417 to double
  %t419 = fcmp oge double %t414, %t418
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
  br i1 %t419, label %then37, label %merge38
then37:
  br label %afterloop36
merge38:
  %t432 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t433 = load double, double* %l4
  %t434 = fptosi double %t433 to i64
  %t435 = load { i8**, i64 }, { i8**, i64 }* %t432
  %t436 = extractvalue { i8**, i64 } %t435, 0
  %t437 = extractvalue { i8**, i64 } %t435, 1
  %t438 = icmp uge i64 %t434, %t437
  ; bounds check: %t438 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t434, i64 %t437)
  %t439 = getelementptr i8*, i8** %t436, i64 %t434
  %t440 = load i8*, i8** %t439
  %t441 = call i8* @trim_text(i8* %t440)
  store i8* %t441, i8** %l22
  %t442 = load i8*, i8** %l22
  %t443 = call i64 @sailfin_runtime_string_length(i8* %t442)
  %t444 = icmp eq i64 %t443, 0
  %t445 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t446 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t447 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t448 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t449 = load double, double* %l4
  %t450 = load i8*, i8** %l5
  %t451 = load i8*, i8** %l6
  %t452 = load i8*, i8** %l17
  %t453 = load i8*, i8** %l18
  %t454 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t455 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t456 = load i8*, i8** %l21
  %t457 = load i8*, i8** %l22
  br i1 %t444, label %then39, label %merge40
then39:
  %t458 = load double, double* %l4
  %t459 = sitofp i64 1 to double
  %t460 = fadd double %t458, %t459
  store double %t460, double* %l4
  br label %afterloop36
merge40:
  %t462 = load i8*, i8** %l22
  %s463 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.len16.h1695010494, i32 0, i32 0
  %t464 = call i1 @starts_with(i8* %t462, i8* %s463)
  br label %logical_and_entry_461

logical_and_entry_461:
  br i1 %t464, label %logical_and_right_461, label %logical_and_merge_461

logical_and_right_461:
  %t465 = load i8*, i8** %l22
  %s466 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.len16.h1290415774, i32 0, i32 0
  %t467 = call i1 @starts_with(i8* %t465, i8* %s466)
  %t468 = xor i1 %t467, 1
  br label %logical_and_right_end_461

logical_and_right_end_461:
  br label %logical_and_merge_461

logical_and_merge_461:
  %t469 = phi i1 [ false, %logical_and_entry_461 ], [ %t468, %logical_and_right_end_461 ]
  %t470 = xor i1 %t469, 1
  %t471 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t472 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t473 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t474 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t475 = load double, double* %l4
  %t476 = load i8*, i8** %l5
  %t477 = load i8*, i8** %l6
  %t478 = load i8*, i8** %l17
  %t479 = load i8*, i8** %l18
  %t480 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t481 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t482 = load i8*, i8** %l21
  %t483 = load i8*, i8** %l22
  br i1 %t470, label %then41, label %merge42
then41:
  br label %afterloop36
merge42:
  %t484 = load i8*, i8** %l22
  %s485 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.len16.h1695010494, i32 0, i32 0
  %t486 = call i1 @starts_with(i8* %t484, i8* %s485)
  %t487 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t488 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t489 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t490 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t491 = load double, double* %l4
  %t492 = load i8*, i8** %l5
  %t493 = load i8*, i8** %l6
  %t494 = load i8*, i8** %l17
  %t495 = load i8*, i8** %l18
  %t496 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t497 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t498 = load i8*, i8** %l21
  %t499 = load i8*, i8** %l22
  br i1 %t486, label %then43, label %else44
then43:
  %t500 = load i8*, i8** %l22
  %s501 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1616485352, i32 0, i32 0
  %t502 = call i8* @strip_prefix(i8* %t500, i8* %s501)
  store i8* %t502, i8** %l23
  %t503 = load i8*, i8** %l17
  %s504 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1926252274, i32 0, i32 0
  %t505 = call i8* @strip_prefix(i8* %t503, i8* %s504)
  store i8* %t505, i8** %l24
  %t506 = load i8*, i8** %l24
  %t507 = load i8*, i8** %l21
  %t508 = call %EnumLayoutVariantParse @parse_enum_variant_layout(i8* %t506, i8* %t507)
  store %EnumLayoutVariantParse %t508, %EnumLayoutVariantParse* %l25
  %t509 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t510 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  %t511 = extractvalue %EnumLayoutVariantParse %t510, 2
  %t512 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t509, { i8**, i64 }* %t511)
  store { i8**, i64 }* %t512, { i8**, i64 }** %l1
  %t513 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  %t514 = extractvalue %EnumLayoutVariantParse %t513, 0
  %t515 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t516 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t517 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t518 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t519 = load double, double* %l4
  %t520 = load i8*, i8** %l5
  %t521 = load i8*, i8** %l6
  %t522 = load i8*, i8** %l17
  %t523 = load i8*, i8** %l18
  %t524 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t525 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t526 = load i8*, i8** %l21
  %t527 = load i8*, i8** %l22
  %t528 = load i8*, i8** %l23
  %t529 = load i8*, i8** %l24
  %t530 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  br i1 %t514, label %then46, label %merge47
then46:
  %t531 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t532 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  %t533 = extractvalue %EnumLayoutVariantParse %t532, 1
  %t534 = call { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t531, %NativeEnumVariantLayout %t533)
  store { %NativeEnumVariantLayout*, i64 }* %t534, { %NativeEnumVariantLayout*, i64 }** %l20
  %t535 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %merge47
merge47:
  %t536 = phi { %NativeEnumVariantLayout*, i64 }* [ %t535, %then46 ], [ %t525, %then43 ]
  store { %NativeEnumVariantLayout*, i64 }* %t536, { %NativeEnumVariantLayout*, i64 }** %l20
  %t537 = load i8*, i8** %l17
  %t538 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t539 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %merge45
else44:
  %t540 = load i8*, i8** %l22
  %s541 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.len16.h1290415774, i32 0, i32 0
  %t542 = call i1 @starts_with(i8* %t540, i8* %s541)
  %t543 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t544 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t545 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t546 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t547 = load double, double* %l4
  %t548 = load i8*, i8** %l5
  %t549 = load i8*, i8** %l6
  %t550 = load i8*, i8** %l17
  %t551 = load i8*, i8** %l18
  %t552 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t553 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t554 = load i8*, i8** %l21
  %t555 = load i8*, i8** %l22
  br i1 %t542, label %then48, label %merge49
then48:
  %t556 = load i8*, i8** %l22
  %s557 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1616485352, i32 0, i32 0
  %t558 = call i8* @strip_prefix(i8* %t556, i8* %s557)
  store i8* %t558, i8** %l26
  %t559 = load i8*, i8** %l17
  %s560 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1521657554, i32 0, i32 0
  %t561 = call i8* @strip_prefix(i8* %t559, i8* %s560)
  store i8* %t561, i8** %l27
  %t562 = load i8*, i8** %l27
  %t563 = load i8*, i8** %l21
  %t564 = call %EnumLayoutPayloadParse @parse_enum_payload_layout(i8* %t562, i8* %t563)
  store %EnumLayoutPayloadParse %t564, %EnumLayoutPayloadParse* %l28
  %t565 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t566 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  %t567 = extractvalue %EnumLayoutPayloadParse %t566, 3
  %t568 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t565, { i8**, i64 }* %t567)
  store { i8**, i64 }* %t568, { i8**, i64 }** %l1
  %t570 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  %t571 = extractvalue %EnumLayoutPayloadParse %t570, 0
  br label %logical_and_entry_569

logical_and_entry_569:
  br i1 %t571, label %logical_and_right_569, label %logical_and_merge_569

logical_and_right_569:
  %t572 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t573 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t572
  %t574 = extractvalue { %NativeEnumVariantLayout*, i64 } %t573, 1
  %t575 = icmp sgt i64 %t574, 0
  br label %logical_and_right_end_569

logical_and_right_end_569:
  br label %logical_and_merge_569

logical_and_merge_569:
  %t576 = phi i1 [ false, %logical_and_entry_569 ], [ %t575, %logical_and_right_end_569 ]
  %t577 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t578 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t579 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t580 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t581 = load double, double* %l4
  %t582 = load i8*, i8** %l5
  %t583 = load i8*, i8** %l6
  %t584 = load i8*, i8** %l17
  %t585 = load i8*, i8** %l18
  %t586 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t587 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t588 = load i8*, i8** %l21
  %t589 = load i8*, i8** %l22
  %t590 = load i8*, i8** %l26
  %t591 = load i8*, i8** %l27
  %t592 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  br i1 %t576, label %then50, label %merge51
then50:
  %t593 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t594 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t593
  %t595 = extractvalue { %NativeEnumVariantLayout*, i64 } %t594, 1
  %t596 = sub i64 %t595, 1
  store i64 %t596, i64* %l29
  %t597 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t598 = load i64, i64* %l29
  %t599 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t597
  %t600 = extractvalue { %NativeEnumVariantLayout*, i64 } %t599, 0
  %t601 = extractvalue { %NativeEnumVariantLayout*, i64 } %t599, 1
  %t602 = icmp uge i64 %t598, %t601
  ; bounds check: %t602 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t598, i64 %t601)
  %t603 = getelementptr %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t600, i64 %t598
  %t604 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t603
  store %NativeEnumVariantLayout %t604, %NativeEnumVariantLayout* %l30
  %t605 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l30
  %t606 = extractvalue %NativeEnumVariantLayout %t605, 5
  %t607 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  %t608 = extractvalue %EnumLayoutPayloadParse %t607, 2
  %t609 = bitcast { %NativeStructLayoutField**, i64 }* %t606 to { %NativeStructLayoutField*, i64 }*
  %t610 = call { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %t609, %NativeStructLayoutField %t608)
  store { %NativeStructLayoutField*, i64 }* %t610, { %NativeStructLayoutField*, i64 }** %l31
  %t611 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l30
  %t612 = extractvalue %NativeEnumVariantLayout %t611, 0
  %t613 = insertvalue %NativeEnumVariantLayout undef, i8* %t612, 0
  %t614 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l30
  %t615 = extractvalue %NativeEnumVariantLayout %t614, 1
  %t616 = insertvalue %NativeEnumVariantLayout %t613, double %t615, 1
  %t617 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l30
  %t618 = extractvalue %NativeEnumVariantLayout %t617, 2
  %t619 = insertvalue %NativeEnumVariantLayout %t616, double %t618, 2
  %t620 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l30
  %t621 = extractvalue %NativeEnumVariantLayout %t620, 3
  %t622 = insertvalue %NativeEnumVariantLayout %t619, double %t621, 3
  %t623 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l30
  %t624 = extractvalue %NativeEnumVariantLayout %t623, 4
  %t625 = insertvalue %NativeEnumVariantLayout %t622, double %t624, 4
  %t626 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l31
  %t627 = bitcast { %NativeStructLayoutField*, i64 }* %t626 to { %NativeStructLayoutField**, i64 }*
  %t628 = insertvalue %NativeEnumVariantLayout %t625, { %NativeStructLayoutField**, i64 }* %t627, 5
  %t629 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t630 = load i64, i64* %l29
  %t631 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t629, i32 0, i32 0
  %t633 = load %NativeEnumVariantLayout*, %NativeEnumVariantLayout** %t631
  %t632 = getelementptr %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t633, i64 %t630
  store %NativeEnumVariantLayout %t628, %NativeEnumVariantLayout* %t632
  br label %merge51
merge51:
  %t634 = load i8*, i8** %l17
  %t635 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge49
merge49:
  %t636 = phi i8* [ %t634, %merge51 ], [ %t550, %else44 ]
  %t637 = phi { i8**, i64 }* [ %t635, %merge51 ], [ %t544, %else44 ]
  store i8* %t636, i8** %l17
  store { i8**, i64 }* %t637, { i8**, i64 }** %l1
  %t638 = load i8*, i8** %l17
  %t639 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge45
merge45:
  %t640 = phi i8* [ %t537, %merge47 ], [ %t638, %merge49 ]
  %t641 = phi { i8**, i64 }* [ %t538, %merge47 ], [ %t639, %merge49 ]
  %t642 = phi { %NativeEnumVariantLayout*, i64 }* [ %t539, %merge47 ], [ %t497, %merge49 ]
  store i8* %t640, i8** %l17
  store { i8**, i64 }* %t641, { i8**, i64 }** %l1
  store { %NativeEnumVariantLayout*, i64 }* %t642, { %NativeEnumVariantLayout*, i64 }** %l20
  %t643 = load double, double* %l4
  %t644 = sitofp i64 1 to double
  %t645 = fadd double %t643, %t644
  store double %t645, double* %l4
  br label %loop.latch35
loop.latch35:
  %t646 = load double, double* %l4
  %t647 = load i8*, i8** %l17
  %t648 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t649 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %loop.header33
afterloop36:
  %t654 = load double, double* %l4
  %t655 = load i8*, i8** %l17
  %t656 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t657 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t658 = load i8*, i8** %l21
  %t659 = insertvalue %NativeEnum undef, i8* %t658, 0
  %t660 = getelementptr [0 x %NativeEnumVariant*], [0 x %NativeEnumVariant*]* null, i32 1
  %t661 = ptrtoint [0 x %NativeEnumVariant*]* %t660 to i64
  %t662 = icmp eq i64 %t661, 0
  %t663 = select i1 %t662, i64 1, i64 %t661
  %t664 = call i8* @malloc(i64 %t663)
  %t665 = bitcast i8* %t664 to %NativeEnumVariant**
  %t666 = getelementptr { %NativeEnumVariant**, i64 }, { %NativeEnumVariant**, i64 }* null, i32 1
  %t667 = ptrtoint { %NativeEnumVariant**, i64 }* %t666 to i64
  %t668 = call i8* @malloc(i64 %t667)
  %t669 = bitcast i8* %t668 to { %NativeEnumVariant**, i64 }*
  %t670 = getelementptr { %NativeEnumVariant**, i64 }, { %NativeEnumVariant**, i64 }* %t669, i32 0, i32 0
  store %NativeEnumVariant** %t665, %NativeEnumVariant*** %t670
  %t671 = getelementptr { %NativeEnumVariant**, i64 }, { %NativeEnumVariant**, i64 }* %t669, i32 0, i32 1
  store i64 0, i64* %t671
  %t672 = insertvalue %NativeEnum %t659, { %NativeEnumVariant**, i64 }* %t669, 1
  %t673 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t674 = extractvalue %EnumLayoutHeaderParse %t673, 2
  %t675 = insertvalue %NativeEnumLayout undef, double %t674, 0
  %t676 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t677 = extractvalue %EnumLayoutHeaderParse %t676, 3
  %t678 = insertvalue %NativeEnumLayout %t675, double %t677, 1
  %t679 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t680 = extractvalue %EnumLayoutHeaderParse %t679, 4
  %t681 = insertvalue %NativeEnumLayout %t678, i8* %t680, 2
  %t682 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t683 = extractvalue %EnumLayoutHeaderParse %t682, 5
  %t684 = insertvalue %NativeEnumLayout %t681, double %t683, 3
  %t685 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t686 = extractvalue %EnumLayoutHeaderParse %t685, 6
  %t687 = insertvalue %NativeEnumLayout %t684, double %t686, 4
  %t688 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t689 = bitcast { %NativeEnumVariantLayout*, i64 }* %t688 to { %NativeEnumVariantLayout**, i64 }*
  %t690 = insertvalue %NativeEnumLayout %t687, { %NativeEnumVariantLayout**, i64 }* %t689, 5
  %t691 = alloca %NativeEnumLayout
  store %NativeEnumLayout %t690, %NativeEnumLayout* %t691
  %t692 = insertvalue %NativeEnum %t672, %NativeEnumLayout* %t691, 2
  store %NativeEnum %t692, %NativeEnum* %l32
  %t693 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t694 = load %NativeEnum, %NativeEnum* %l32
  %t695 = call { %NativeEnum*, i64 }* @append_enum({ %NativeEnum*, i64 }* %t693, %NativeEnum %t694)
  store { %NativeEnum*, i64 }* %t695, { %NativeEnum*, i64 }** %l3
  %t696 = load double, double* %l4
  %t697 = load double, double* %l4
  %t698 = load i8*, i8** %l17
  %t699 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t700 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  br label %merge32
else31:
  %t701 = load double, double* %l4
  %t702 = sitofp i64 1 to double
  %t703 = fadd double %t701, %t702
  store double %t703, double* %l4
  %t704 = load double, double* %l4
  br label %merge32
merge32:
  %t705 = phi double [ %t696, %afterloop36 ], [ %t704, %else31 ]
  %t706 = phi i8* [ %t698, %afterloop36 ], [ %t382, %else31 ]
  %t707 = phi { i8**, i64 }* [ %t699, %afterloop36 ], [ %t376, %else31 ]
  %t708 = phi { %NativeEnum*, i64 }* [ %t700, %afterloop36 ], [ %t378, %else31 ]
  store double %t705, double* %l4
  store i8* %t706, i8** %l17
  store { i8**, i64 }* %t707, { i8**, i64 }** %l1
  store { %NativeEnum*, i64 }* %t708, { %NativeEnum*, i64 }** %l3
  br label %loop.latch2
merge29:
  %t709 = load double, double* %l4
  %t710 = sitofp i64 1 to double
  %t711 = fadd double %t709, %t710
  store double %t711, double* %l4
  br label %loop.latch2
loop.latch2:
  %t712 = load double, double* %l4
  %t713 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t714 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t715 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  br label %loop.header0
afterloop3:
  %t720 = load double, double* %l4
  %t721 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t722 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t723 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t724 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t725 = bitcast { %NativeStruct*, i64 }* %t724 to { %NativeStruct**, i64 }*
  %t726 = insertvalue %LayoutManifest undef, { %NativeStruct**, i64 }* %t725, 0
  %t727 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t728 = bitcast { %NativeEnum*, i64 }* %t727 to { %NativeEnum**, i64 }*
  %t729 = insertvalue %LayoutManifest %t726, { %NativeEnum**, i64 }* %t728, 1
  %t730 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t731 = insertvalue %LayoutManifest %t729, { i8**, i64 }* %t730, 2
  ret %LayoutManifest %t731
}

define i1 @is_trim_char(i8* %ch) {
block.entry:
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
block.entry:
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
  %t26 = phi double [ %t6, %merge3 ], [ %t25, %loop.latch6 ]
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
  %t27 = load double, double* %l0
  ret i1 1
}

define i8* @strip_prefix(i8* %value, i8* %prefix) {
block.entry:
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
block.entry:
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
  %t56 = phi double [ %t4, %merge1 ], [ %t55, %loop.latch4 ]
  store double %t56, double* %l0
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
  %t43 = phi i1 [ %t16, %merge7 ], [ %t41, %loop.latch10 ]
  %t44 = phi double [ %t15, %merge7 ], [ %t42, %loop.latch10 ]
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
  %t46 = load double, double* %l1
  %t47 = load i1, i1* %l2
  %t48 = load double, double* %l0
  %t49 = load double, double* %l1
  %t50 = load i1, i1* %l2
  br i1 %t47, label %then16, label %merge17
then16:
  %t51 = load double, double* %l0
  ret double %t51
merge17:
  %t52 = load double, double* %l0
  %t53 = sitofp i64 1 to double
  %t54 = fadd double %t52, %t53
  store double %t54, double* %l0
  br label %loop.latch4
loop.latch4:
  %t55 = load double, double* %l0
  br label %loop.header2
afterloop5:
  %t57 = load double, double* %l0
  %t58 = sitofp i64 -1 to double
  ret double %t58
}

define double @last_index_of(i8* %value, i8* %target) {
block.entry:
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
  %t56 = phi double [ %t8, %merge1 ], [ %t55, %loop.latch4 ]
  store double %t56, double* %l0
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
  %t43 = phi i1 [ %t16, %merge7 ], [ %t41, %loop.latch10 ]
  %t44 = phi double [ %t15, %merge7 ], [ %t42, %loop.latch10 ]
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
  %t46 = load double, double* %l1
  %t47 = load i1, i1* %l2
  %t48 = load double, double* %l0
  %t49 = load double, double* %l1
  %t50 = load i1, i1* %l2
  br i1 %t47, label %then16, label %merge17
then16:
  %t51 = load double, double* %l0
  ret double %t51
merge17:
  %t52 = load double, double* %l0
  %t53 = sitofp i64 1 to double
  %t54 = fsub double %t52, %t53
  store double %t54, double* %l0
  br label %loop.latch4
loop.latch4:
  %t55 = load double, double* %l0
  br label %loop.header2
afterloop5:
  %t57 = load double, double* %l0
  %t58 = sitofp i64 -1 to double
  ret double %t58
}

define i8* @strip_quotes(i8* %value) {
block.entry:
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
block.entry:
  %t0 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t1 = ptrtoint [1 x i8*]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to i8**
  %t6 = getelementptr i8*, i8** %t5, i64 0
  store i8* %value, i8** %t6
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t8 = ptrtoint { i8**, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { i8**, i64 }*
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 0
  store i8** %t5, i8*** %t11
  %t12 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 1
  store i64 1, i64* %t12
  %t13 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %values, { i8**, i64 }* %t10)
  ret { i8**, i64 }* %t13
}

define { i8**, i64 }* @split_text(i8* %value, i8* %delimiter) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %t0 = call i64 @sailfin_runtime_string_length(i8* %delimiter)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t3 = ptrtoint [1 x i8*]* %t2 to i64
  %t4 = icmp eq i64 %t3, 0
  %t5 = select i1 %t4, i64 1, i64 %t3
  %t6 = call i8* @malloc(i64 %t5)
  %t7 = bitcast i8* %t6 to i8**
  %t8 = getelementptr i8*, i8** %t7, i64 0
  store i8* %value, i8** %t8
  %t9 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t10 = ptrtoint { i8**, i64 }* %t9 to i64
  %t11 = call i8* @malloc(i64 %t10)
  %t12 = bitcast i8* %t11 to { i8**, i64 }*
  %t13 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 0
  store i8** %t7, i8*** %t13
  %t14 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 1
  store i64 1, i64* %t14
  ret { i8**, i64 }* %t12
merge1:
  %t15 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t16 = ptrtoint [0 x i8*]* %t15 to i64
  %t17 = icmp eq i64 %t16, 0
  %t18 = select i1 %t17, i64 1, i64 %t16
  %t19 = call i8* @malloc(i64 %t18)
  %t20 = bitcast i8* %t19 to i8**
  %t21 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t22 = ptrtoint { i8**, i64 }* %t21 to i64
  %t23 = call i8* @malloc(i64 %t22)
  %t24 = bitcast i8* %t23 to { i8**, i64 }*
  %t25 = getelementptr { i8**, i64 }, { i8**, i64 }* %t24, i32 0, i32 0
  store i8** %t20, i8*** %t25
  %t26 = getelementptr { i8**, i64 }, { i8**, i64 }* %t24, i32 0, i32 1
  store i64 0, i64* %t26
  store { i8**, i64 }* %t24, { i8**, i64 }** %l0
  %t27 = sitofp i64 0 to double
  store double %t27, double* %l1
  %t28 = sitofp i64 0 to double
  store double %t28, double* %l2
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t30 = load double, double* %l1
  %t31 = load double, double* %l2
  br label %loop.header2
loop.header2:
  %t69 = phi { i8**, i64 }* [ %t29, %merge1 ], [ %t66, %loop.latch4 ]
  %t70 = phi double [ %t30, %merge1 ], [ %t67, %loop.latch4 ]
  %t71 = phi double [ %t31, %merge1 ], [ %t68, %loop.latch4 ]
  store { i8**, i64 }* %t69, { i8**, i64 }** %l0
  store double %t70, double* %l1
  store double %t71, double* %l2
  br label %loop.body3
loop.body3:
  %t32 = load double, double* %l2
  %t33 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t34 = sitofp i64 %t33 to double
  %t35 = fcmp oge double %t32, %t34
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t37 = load double, double* %l1
  %t38 = load double, double* %l2
  br i1 %t35, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t39 = load double, double* %l2
  %t40 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t41 = fptosi double %t39 to i64
  %t42 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t41, i64 %t40)
  %t43 = call double @index_of(i8* %t42, i8* %delimiter)
  store double %t43, double* %l3
  %t44 = load double, double* %l3
  %t45 = sitofp i64 0 to double
  %t46 = fcmp olt double %t44, %t45
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t48 = load double, double* %l1
  %t49 = load double, double* %l2
  %t50 = load double, double* %l3
  br i1 %t46, label %then8, label %merge9
then8:
  br label %afterloop5
merge9:
  %t51 = load double, double* %l2
  %t52 = load double, double* %l3
  %t53 = fadd double %t51, %t52
  store double %t53, double* %l4
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t55 = load double, double* %l1
  %t56 = load double, double* %l4
  %t57 = fptosi double %t55 to i64
  %t58 = fptosi double %t56 to i64
  %t59 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t57, i64 %t58)
  %t60 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t54, i8* %t59)
  store { i8**, i64 }* %t60, { i8**, i64 }** %l0
  %t61 = load double, double* %l4
  %t62 = call i64 @sailfin_runtime_string_length(i8* %delimiter)
  %t63 = sitofp i64 %t62 to double
  %t64 = fadd double %t61, %t63
  store double %t64, double* %l1
  %t65 = load double, double* %l1
  store double %t65, double* %l2
  br label %loop.latch4
loop.latch4:
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t67 = load double, double* %l1
  %t68 = load double, double* %l2
  br label %loop.header2
afterloop5:
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t73 = load double, double* %l1
  %t74 = load double, double* %l2
  %t75 = load double, double* %l1
  %t76 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t77 = sitofp i64 %t76 to double
  %t78 = fcmp olt double %t75, %t77
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t80 = load double, double* %l1
  %t81 = load double, double* %l2
  br i1 %t78, label %then10, label %else11
then10:
  %t82 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t83 = load double, double* %l1
  %t84 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t85 = fptosi double %t83 to i64
  %t86 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t85, i64 %t84)
  %t87 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t82, i8* %t86)
  store { i8**, i64 }* %t87, { i8**, i64 }** %l0
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge12
else11:
  %t89 = load double, double* %l1
  %t90 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t91 = sitofp i64 %t90 to double
  %t92 = fcmp oeq double %t89, %t91
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t94 = load double, double* %l1
  %t95 = load double, double* %l2
  br i1 %t92, label %then13, label %merge14
then13:
  %t96 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s97 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t98 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t96, i8* %s97)
  store { i8**, i64 }* %t98, { i8**, i64 }** %l0
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge14
merge14:
  %t100 = phi { i8**, i64 }* [ %t99, %then13 ], [ %t93, %else11 ]
  store { i8**, i64 }* %t100, { i8**, i64 }** %l0
  %t101 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge12
merge12:
  %t102 = phi { i8**, i64 }* [ %t88, %then10 ], [ %t101, %merge14 ]
  store { i8**, i64 }* %t102, { i8**, i64 }** %l0
  %t103 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t103
}

define { %NativeParameter*, i64 }* @append_parameter_array({ %NativeParameter*, i64 }* %values, %NativeParameter %parameter) {
block.entry:
  %t0 = call noalias i8* @malloc(i64 40)
  %t1 = bitcast i8* %t0 to %NativeParameter*
  store %NativeParameter %parameter, %NativeParameter* %t1
  %t2 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t3 = ptrtoint [1 x i8*]* %t2 to i64
  %t4 = icmp eq i64 %t3, 0
  %t5 = select i1 %t4, i64 1, i64 %t3
  %t6 = call i8* @malloc(i64 %t5)
  %t7 = bitcast i8* %t6 to i8**
  %t8 = getelementptr i8*, i8** %t7, i64 0
  store i8* %t0, i8** %t8
  %t9 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t10 = ptrtoint { i8**, i64 }* %t9 to i64
  %t11 = call i8* @malloc(i64 %t10)
  %t12 = bitcast i8* %t11 to { i8**, i64 }*
  %t13 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 0
  store i8** %t7, i8*** %t13
  %t14 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 1
  store i64 1, i64* %t14
  %t15 = bitcast { %NativeParameter*, i64 }* %values to { i8**, i64 }*
  %t16 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t15, { i8**, i64 }* %t12)
  %t17 = bitcast { i8**, i64 }* %t16 to { %NativeParameter*, i64 }*
  ret { %NativeParameter*, i64 }* %t17
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
@.str.len37.h1581468287 = private unnamed_addr constant [38 x i8] c"enum layout header has invalid size `\00"
@.str.len5.h2080793783 = private unnamed_addr constant [6 x i8] c"eval \00"
@.str.len7.h1448749422 = private unnamed_addr constant [8 x i8] c".endfor\00"
@.enum.NativeInstruction.Return.variant = private unnamed_addr constant [7 x i8] c"Return\00"
@.str.len29.h1601547567 = private unnamed_addr constant [30 x i8] c"unused span metadata before: \00"
@.str.len6.h1134498859 = private unnamed_addr constant [7 x i8] c"async \00"
@.str.len13.h259593098 = private unnamed_addr constant [14 x i8] c".layout enum \00"
@.str.len48.h807033739 = private unnamed_addr constant [49 x i8] c" layout payload encountered before layout header\00"
@.str.len13.h1382830532 = private unnamed_addr constant [14 x i8] c".endinterface\00"
@.str.len7.h130169768 = private unnamed_addr constant [8 x i8] c".param \00"
@.str.len37.h2038142650 = private unnamed_addr constant [38 x i8] c"enum layout header missing size entry\00"
@.str.len5.h1783417286 = private unnamed_addr constant [6 x i8] c"` in \00"
@.str.len9.h1692644020 = private unnamed_addr constant [10 x i8] c".endmatch\00"
@.str.len8.h1521657554 = private unnamed_addr constant [9 x i8] c"payload \00"
@.str.len31.h329133056 = private unnamed_addr constant [32 x i8] c" layout payload missing content\00"
@.enum.NativeInstruction.Unknown.variant = private unnamed_addr constant [8 x i8] c"Unknown\00"
@.str.len41.h881857818 = private unnamed_addr constant [42 x i8] c"enum layout header missing tag_type entry\00"
@.str.len11.h1513373193 = private unnamed_addr constant [12 x i8] c".init-span \00"
@.str.len4.h192491117 = private unnamed_addr constant [5 x i8] c".fn \00"
@.str.len17.h1973869273 = private unnamed_addr constant [18 x i8] c" layout payload `\00"
@.str.len28.h1471254674 = private unnamed_addr constant [29 x i8] c"unsupported enum directive: \00"
@.str.len4.h175996034 = private unnamed_addr constant [5 x i8] c" in \00"
@.str.len34.h1211676914 = private unnamed_addr constant [35 x i8] c"unable to parse method parameter: \00"
@.str.len5.h1958778164 = private unnamed_addr constant [6 x i8] c"break\00"
@.str.len33.h1132321576 = private unnamed_addr constant [34 x i8] c" header has unsupported segment `\00"
@.str.len20.h151690315 = private unnamed_addr constant [21 x i8] c"` has invalid size `\00"
@.str.len16.h1290415774 = private unnamed_addr constant [17 x i8] c".layout payload \00"
@.str.len7.h242296049 = private unnamed_addr constant [8 x i8] c"offset=\00"
@.enum.NativeInstruction.Noop.variant = private unnamed_addr constant [5 x i8] c"Noop\00"
@.str.len9.h1123073249 = private unnamed_addr constant [10 x i8] c"` invalid\00"
@.str.len8.h1370870284 = private unnamed_addr constant [9 x i8] c".module \00"
@.str.len40.h1512965366 = private unnamed_addr constant [41 x i8] c"unterminated function at end of artifact\00"
@.str.len5.h466680424 = private unnamed_addr constant [6 x i8] c"size=\00"
@.enum.NativeInstruction.If.variant = private unnamed_addr constant [3 x i8] c"If\00"
@.str.len29.h668562564 = private unnamed_addr constant [30 x i8] c"unable to parse enum header: \00"
@.str.len10.h385719500 = private unnamed_addr constant [11 x i8] c"interface \00"
@.str.len21.h2112628887 = private unnamed_addr constant [22 x i8] c"` missing align entry\00"
@.str.len24.h1881287894 = private unnamed_addr constant [25 x i8] c"unable to parse export: \00"
@.str.len10.h469410318 = private unnamed_addr constant [11 x i8] c"tag_align=\00"
@.str.len5.h2072026244 = private unnamed_addr constant [6 x i8] c"enum \00"
@.str.len5.h2064480630 = private unnamed_addr constant [6 x i8] c".loop\00"
@.str.len26.h1834305347 = private unnamed_addr constant [27 x i8] c" signature missing content\00"
@.str.len18.h1997941781 = private unnamed_addr constant [19 x i8] c"unterminated enum \00"
@.str.len40.h1650449248 = private unnamed_addr constant [41 x i8] c"struct layout header has invalid align `\00"
@.str.len8.h575595345 = private unnamed_addr constant [9 x i8] c".import \00"
@.str.len20.h608364678 = private unnamed_addr constant [21 x i8] c"` missing size entry\00"
@.str.len10.h1219235236 = private unnamed_addr constant [11 x i8] c".manifest \00"
@.str.len9.h1228988541 = private unnamed_addr constant [10 x i8] c"tag_type=\00"
@.enum.NativeInstruction.Case.variant = private unnamed_addr constant [5 x i8] c"Case\00"
@.str.len9.h890937508 = private unnamed_addr constant [10 x i8] c"eval let \00"
@.str.len20.h1216366549 = private unnamed_addr constant [21 x i8] c"unterminated struct \00"
@.str.len39.h1399971520 = private unnamed_addr constant [40 x i8] c"struct layout header missing size entry\00"
@.str.len6.h1280334338 = private unnamed_addr constant [7 x i8] c".endif\00"
@.str.len26.h1606904140 = private unnamed_addr constant [27 x i8] c"` has unsupported suffix `\00"
@.str.len39.h598838653 = private unnamed_addr constant [40 x i8] c"enum layout header unrecognized token `\00"
@.str.len31.h1960327680 = private unnamed_addr constant [32 x i8] c" layout variant missing content\00"
@.str.len22.h496289716 = private unnamed_addr constant [23 x i8] c"` unrecognized token `\00"
@.str.len4.h273104342 = private unnamed_addr constant [5 x i8] c"ret \00"
@.str.len19.h1782433603 = private unnamed_addr constant [20 x i8] c"sailfin-native-text\00"
@.str.len40.h318366654 = private unnamed_addr constant [41 x i8] c"struct layout header missing align entry\00"
@.enum.NativeInstruction.EndFor.variant = private unnamed_addr constant [7 x i8] c"EndFor\00"
@.str.len8.h1616485352 = private unnamed_addr constant [9 x i8] c".layout \00"
@.str.len8.h1926252274 = private unnamed_addr constant [9 x i8] c"variant \00"
@.str.len2.h193415939 = private unnamed_addr constant [3 x i8] c"![\00"
@.str.len14.h1219450488 = private unnamed_addr constant [15 x i8] c"` missing name\00"
@.str.len29.h128952257 = private unnamed_addr constant [30 x i8] c" layout field missing content\00"
@.str.len23.h1564009733 = private unnamed_addr constant [24 x i8] c"unterminated interface \00"
@.str.len7.h398443637 = private unnamed_addr constant [8 x i8] c".field \00"
@.str.len23.h668778749 = private unnamed_addr constant [24 x i8] c"sailfin-layout-manifest\00"
@.str.len32.h1767333123 = private unnamed_addr constant [33 x i8] c"metadata outside function body: \00"
@.str.len9.h1311191977 = private unnamed_addr constant [10 x i8] c".variant \00"
@.str.len32.h1189086491 = private unnamed_addr constant [33 x i8] c"unable to parse parameter line: \00"
@.str.len4.h192590216 = private unnamed_addr constant [5 x i8] c".if \00"
@.str.len31.h1868156648 = private unnamed_addr constant [32 x i8] c" header missing implements list\00"
@.str.len30.h829706524 = private unnamed_addr constant [31 x i8] c"unable to parse enum variant: \00"
@.str.len28.h497146076 = private unnamed_addr constant [29 x i8] c" layout payload identifier `\00"
@.enum.NativeInstruction.Expression.variant = private unnamed_addr constant [11 x i8] c"Expression\00"
@.str.len5.h2072555103 = private unnamed_addr constant [6 x i8] c".sig \00"
@.str.len31.h1924917952 = private unnamed_addr constant [32 x i8] c"duplicate enum layout variant `\00"
@.str.len8.h528348603 = private unnamed_addr constant [9 x i8] c"continue\00"
@.str.len8.h487238491 = private unnamed_addr constant [9 x i8] c"header `\00"
@.str.len6.h734244628 = private unnamed_addr constant [7 x i8] c"field \00"
@.str.len14.h1053492670 = private unnamed_addr constant [15 x i8] c".layout field \00"
@.str.len5.h524431183 = private unnamed_addr constant [6 x i8] c"type=\00"
@.str.len7.h655348872 = private unnamed_addr constant [8 x i8] c"return \00"
@.str.len41.h2069276858 = private unnamed_addr constant [42 x i8] c"enum layout header missing tag_size entry\00"
@.str.len33.h712498791 = private unnamed_addr constant [34 x i8] c"parameter outside function body: \00"
@.str.len8.h1951948513 = private unnamed_addr constant [9 x i8] c".method \00"
@.str.len5.h261048910 = private unnamed_addr constant [6 x i8] c"name=\00"
@.str.len32.h1822658020 = private unnamed_addr constant [33 x i8] c"duplicate enum layout header in \00"
@.enum.NativeInstruction.EndIf.variant = private unnamed_addr constant [6 x i8] c"EndIf\00"
@.str.len37.h1152036459 = private unnamed_addr constant [38 x i8] c"unsupported struct layout directive: \00"
@.enum.NativeInstruction.EndMatch.variant = private unnamed_addr constant [9 x i8] c"EndMatch\00"
@.str.len44.h1623843 = private unnamed_addr constant [45 x i8] c" layout payload references unknown variant `\00"
@.str.len10.h179409731 = private unnamed_addr constant [11 x i8] c".endmethod\00"
@.str.len57.h1118233133 = private unnamed_addr constant [58 x i8] c"encountered nested .fn while previous function still open\00"
@.str.len4.h268715771 = private unnamed_addr constant [5 x i8] c"none\00"
@.enum.NativeInstruction.Loop.variant = private unnamed_addr constant [5 x i8] c"Loop\00"
@.str.len22.h24304067 = private unnamed_addr constant [23 x i8] c"` has invalid offset `\00"
@.str.len30.h208276320 = private unnamed_addr constant [31 x i8] c"unterminated method in struct \00"
@.str.len3.h2090684245 = private unnamed_addr constant [4 x i8] c"ret\00"
@.str.len21.h1187531435 = private unnamed_addr constant [22 x i8] c"` missing closing `>`\00"
@.str.len35.h2058816325 = private unnamed_addr constant [36 x i8] c"unsupported enum layout directive: \00"
@.str.len8.h1074277327 = private unnamed_addr constant [9 x i8] c".export \00"
@.enum.NativeInstruction.Break.variant = private unnamed_addr constant [6 x i8] c"Break\00"
@.str.len8.h571206424 = private unnamed_addr constant [9 x i8] c".endloop\00"
@.str.len6.h42978514 = private unnamed_addr constant [7 x i8] c"export\00"
@.enum.NativeInstruction.Match.variant = private unnamed_addr constant [6 x i8] c"Match\00"
@.enum.NativeInstruction.Let.variant = private unnamed_addr constant [4 x i8] c"Let\00"
@.str.len30.h702899578 = private unnamed_addr constant [31 x i8] c"unable to parse struct field: \00"
@.str.len41.h1415177535 = private unnamed_addr constant [42 x i8] c"struct layout header unrecognized token `\00"
@.str.len31.h238974215 = private unnamed_addr constant [32 x i8] c" layout variant missing entries\00"
@.str.len47.h1886628617 = private unnamed_addr constant [48 x i8] c"top-level directive not supported in lowering: \00"
@.str.len28.h1605654048 = private unnamed_addr constant [29 x i8] c" layout variant missing name\00"
@.str.len10.h2070880298 = private unnamed_addr constant [11 x i8] c".endstruct\00"
@.str.len4.h275319236 = private unnamed_addr constant [5 x i8] c"tag=\00"
@.str.len6.h483393773 = private unnamed_addr constant [7 x i8] c"import\00"
@.str.len29.h555082439 = private unnamed_addr constant [30 x i8] c" layout field missing entries\00"
@.str.len20.h1568429285 = private unnamed_addr constant [21 x i8] c"` missing type entry\00"
@.str.len38.h2050661185 = private unnamed_addr constant [39 x i8] c"enum layout header missing align entry\00"
@.str.len5.h2057365731 = private unnamed_addr constant [6 x i8] c".for \00"
@.str.len5.h2056075365 = private unnamed_addr constant [6 x i8] c".else\00"
@.str.len33.h1134984829 = private unnamed_addr constant [34 x i8] c"unsupported interface directive: \00"
@.str.len30.h211710404 = private unnamed_addr constant [31 x i8] c"unsupported struct directive: \00"
@.str.len34.h183092327 = private unnamed_addr constant [35 x i8] c"enum layout header missing entries\00"
@.str.len46.h1830585629 = private unnamed_addr constant [47 x i8] c" layout field encountered before layout header\00"
@.str.len38.h1235260132 = private unnamed_addr constant [39 x i8] c"enum layout header has invalid align `\00"
@.str.len39.h943297157 = private unnamed_addr constant [40 x i8] c"struct layout header has invalid size `\00"
@.str.len22.h625556084 = private unnamed_addr constant [23 x i8] c"` missing offset entry\00"
@.str.len8.h562875475 = private unnamed_addr constant [9 x i8] c".endenum\00"
@.str.len17.h293109504 = private unnamed_addr constant [18 x i8] c" layout variant `\00"
@.str.len44.h1730891783 = private unnamed_addr constant [45 x i8] c" signature has unterminated parameter list: \00"
@.str.len31.h755263238 = private unnamed_addr constant [32 x i8] c" layout payload missing entries\00"
@.str.len15.h506269955 = private unnamed_addr constant [16 x i8] c" layout field `\00"
@.str.len12.h841153022 = private unnamed_addr constant [13 x i8] c" signature `\00"
@.enum.NativeInstruction.EndLoop.variant = private unnamed_addr constant [8 x i8] c"EndLoop\00"
@.str.len35.h546841458 = private unnamed_addr constant [36 x i8] c" signature missing parameter list: \00"
@.enum.NativeInstruction.Continue.variant = private unnamed_addr constant [9 x i8] c"Continue\00"
@.str.len7.h289982314 = private unnamed_addr constant [8 x i8] c"struct \00"
@.str.len41.h35508704 = private unnamed_addr constant [42 x i8] c"unused initializer span metadata before: \00"
@.str.len15.h87749209 = private unnamed_addr constant [16 x i8] c".layout struct \00"
@.str.len6.h1583308163 = private unnamed_addr constant [7 x i8] c".meta \00"
@.str.len26.h130324785 = private unnamed_addr constant [27 x i8] c" layout field missing name\00"
@.str.len11.h908744813 = private unnamed_addr constant [12 x i8] c"implements \00"
@.str.len21.h1297227834 = private unnamed_addr constant [22 x i8] c"` has invalid align `\00"
@.str.len19.h1697653870 = private unnamed_addr constant [20 x i8] c"` missing tag entry\00"
@.str.len31.h1478667446 = private unnamed_addr constant [32 x i8] c"unable to parse struct header: \00"
@.str.len42.h1518215675 = private unnamed_addr constant [43 x i8] c"encountered .endfn without active function\00"
@.str.len36.h414094739 = private unnamed_addr constant [37 x i8] c"struct layout header missing entries\00"
@.str.len34.h1377481172 = private unnamed_addr constant [35 x i8] c"` has invalid effects annotation `\00"
@.str.len16.h1695010494 = private unnamed_addr constant [17 x i8] c".layout variant \00"
@.str.len6.h1830497006 = private unnamed_addr constant [7 x i8] c".span \00"
@.str.len36.h736848621 = private unnamed_addr constant [37 x i8] c"nested method declaration in struct \00"
@.str.len6.h1280331335 = private unnamed_addr constant [7 x i8] c".endfn\00"
@.str.len34.h805939531 = private unnamed_addr constant [35 x i8] c"unable to parse interface header: \00"
@.str.len42.h1171387022 = private unnamed_addr constant [43 x i8] c"enum layout header has invalid tag_align `\00"
@.str.len41.h1384306956 = private unnamed_addr constant [42 x i8] c"enum layout header has invalid tag_size `\00"
@.str.len6.h841337749 = private unnamed_addr constant [7 x i8] c"align=\00"
@.enum.NativeInstruction.variant.default = private unnamed_addr constant [1 x i8] c"\00"
@.str.len48.h235936117 = private unnamed_addr constant [49 x i8] c" layout variant encountered before layout header\00"
@.enum.NativeInstruction.For.variant = private unnamed_addr constant [4 x i8] c"For\00"
@.str.len31.h762677253 = private unnamed_addr constant [32 x i8] c"unable to parse span metadata: \00"
@.str.len24.h457168017 = private unnamed_addr constant [25 x i8] c"unable to parse import: \00"
@.enum.NativeInstruction.Else.variant = private unnamed_addr constant [5 x i8] c"Else\00"
@.str.len19.h879467198 = private unnamed_addr constant [20 x i8] c"` has invalid tag `\00"
@.str.len4.h268717223 = private unnamed_addr constant [5 x i8] c"noop\00"
@.str.len8.h787332764 = private unnamed_addr constant [9 x i8] c"effects \00"
@.str.len27.h237652301 = private unnamed_addr constant [28 x i8] c"` has unsupported segment `\00"
@.str.len4.h267749729 = private unnamed_addr constant [5 x i8] c"mut \00"
@.str.len7.h553171426 = private unnamed_addr constant [8 x i8] c".match \00"
@.str.len43.h1714227133 = private unnamed_addr constant [44 x i8] c"unable to parse initializer span metadata: \00"
@.str.len34.h654371835 = private unnamed_addr constant [35 x i8] c"duplicate struct layout header in \00"
@.str.len7.h725262232 = private unnamed_addr constant [8 x i8] c".return\00"
@.str.len33.h1023685264 = private unnamed_addr constant [34 x i8] c"unable to parse parameter entry: \00"
@.str.len42.h930606274 = private unnamed_addr constant [43 x i8] c"enum layout header missing tag_align entry\00"
@.str.len25.h378946335 = private unnamed_addr constant [26 x i8] c"` has invalid parameter `\00"
@.str.len9.h1171237782 = private unnamed_addr constant [10 x i8] c"tag_size=\00"
@.str.len3.h2089318639 = private unnamed_addr constant [4 x i8] c"Let\00"
