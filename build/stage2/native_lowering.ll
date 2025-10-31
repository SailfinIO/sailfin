; ModuleID = 'sailfin'
source_filename = "sailfin"

%LoweredPythonResult = type { i8*, { i8**, i64 }* }
%MatchContext = type { i8*, double, i1 }
%LoweredCaseCondition = type { i8*, i1, i1 }
%PythonModuleEmission = type { %PythonBuilder, { i8**, i64 }* }
%PythonFunctionEmission = type { %PythonBuilder, { i8**, i64 }* }
%PythonImportEmission = type { %PythonBuilder, { i8**, i64 }* }
%PythonStructEmission = type { %PythonBuilder, { i8**, i64 }* }
%StructLiteralCapture = type { i8*, double, i1 }
%ExpressionContinuationCapture = type { i8*, double, i1 }
%ExtractedSpan = type { i8*, double, double, i1 }
%PythonBuilder = type { { i8**, i64 }*, double }
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

%NativeInstruction = type { i32, [48 x i8] }

declare void @sailfin_runtime_bounds_check(i64, i64)
declare i8* @sailfin_runtime_substring(i8*, i64, i64)
declare i64 @sailfin_runtime_string_length(i8*)
declare i8* @sailfin_runtime_string_concat(i8*, i8*)
declare double @char_code(i8*)
declare i1 @sailfin_runtime_is_whitespace_char(i8)
declare { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }*, i8*)
declare { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }*, { i8**, i64 }*)
declare i8* @sailfin_runtime_get_field(i8*, i8*)

declare noalias i8* @malloc(i64)

@runtime = external global i8**

@.str.len14.h165481004 = private unnamed_addr constant [15 x i8] c"import asyncio\00"
@.str.len46.h744586798 = private unnamed_addr constant [47 x i8] c"from runtime import runtime_support as runtime\00"
@.str.len23.h225115061 = private unnamed_addr constant [24 x i8] c"print = runtime.console\00"
@.str.len21.h464873829 = private unnamed_addr constant [22 x i8] c"sleep = runtime.sleep\00"
@.str.len25.h1882901628 = private unnamed_addr constant [26 x i8] c"channel = runtime.channel\00"
@.str.len27.h1230134945 = private unnamed_addr constant [28 x i8] c"parallel = runtime.parallel\00"
@.str.len21.h1480982861 = private unnamed_addr constant [22 x i8] c"spawn = runtime.spawn\00"
@.str.len15.h2008919863 = private unnamed_addr constant [16 x i8] c"fs = runtime.fs\00"
@.str.len21.h949071414 = private unnamed_addr constant [22 x i8] c"serve = runtime.serve\00"
@.str.len19.h190885179 = private unnamed_addr constant [20 x i8] c"http = runtime.http\00"
@.str.len29.h1075519908 = private unnamed_addr constant [30 x i8] c"websocket = runtime.websocket\00"
@.str.len35.h207688710 = private unnamed_addr constant [36 x i8] c"logExecution = runtime.logExecution\00"
@.str.len29.h1468169 = private unnamed_addr constant [30 x i8] c"array_map = runtime.array_map\00"
@.str.len35.h129830246 = private unnamed_addr constant [36 x i8] c"array_filter = runtime.array_filter\00"
@.str.len35.h1076062162 = private unnamed_addr constant [36 x i8] c"array_reduce = runtime.array_reduce\00"
@.str.len29.h29541381 = private unnamed_addr constant [30 x i8] c"globals()['t' + 'rue'] = True\00"
@.str.len31.h1408297199 = private unnamed_addr constant [32 x i8] c"globals()['f' + 'alse'] = False\00"
@.str.len22.h1699428905 = private unnamed_addr constant [23 x i8] c" = runtime.enum_type('\00"
@.str.len2.h193420823 = private unnamed_addr constant [3 x i8] c"')\00"
@.str.len2.h193425971 = private unnamed_addr constant [3 x i8] c", \00"
@.str.len5.h2115689699 = private unnamed_addr constant [6 x i8] c"from \00"
@.str.len8.h1132499314 = private unnamed_addr constant [9 x i8] c" import \00"
@.str.len4.h175713983 = private unnamed_addr constant [5 x i8] c" as \00"
@.str.len11.h1657754115 = private unnamed_addr constant [12 x i8] c"__all__ = [\00"
@.str.len6.h1267738404 = private unnamed_addr constant [7 x i8] c"class \00"
@.str.len17.h215787497 = private unnamed_addr constant [18 x i8] c"def __init__(self\00"
@.str.len19.h1806641125 = private unnamed_addr constant [20 x i8] c"def __repr__(self):\00"
@.str.len28.h1179318158 = private unnamed_addr constant [29 x i8] c"return runtime.struct_repr('\00"
@.str.len4.h182022329 = private unnamed_addr constant [5 x i8] c"', [\00"
@.str.len2.h193479629 = private unnamed_addr constant [3 x i8] c"])\00"
@.str.len28.h583209964 = private unnamed_addr constant [29 x i8] c"runtime.format_interpolated(\00"
@.str.len0.h177573 = private unnamed_addr constant [1 x i8] c"\00"
@.str.len6.h1719661028 = private unnamed_addr constant [7 x i8] c".push(\00"
@.str.len8.h645367897 = private unnamed_addr constant [9 x i8] c".append(\00"
@.str.len4.h256486202 = private unnamed_addr constant [5 x i8] c"def \00"
@.str.len2.h193423562 = private unnamed_addr constant [3 x i8] c"):\00"
@.str.len14.h1077944870 = private unnamed_addr constant [15 x i8] c"__match_value_\00"
@.str.len4.h174361445 = private unnamed_addr constant [5 x i8] c" == \00"
@.str.len10.h626550212 = private unnamed_addr constant [11 x i8] c"0123456789\00"
@.str.len11.h2001621394 = private unnamed_addr constant [12 x i8] c"[lowering] \00"

define %LoweredPythonResult @lower_to_python(%NativeModule %native_module) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca %NativeArtifact*
  %l2 = alloca %ParseNativeResult
  %l3 = alloca %PythonModuleEmission
  %l4 = alloca i8*
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
  %t12 = extractvalue %NativeModule %native_module, 0
  %t13 = bitcast { %NativeArtifact**, i64 }* %t12 to { %NativeArtifact*, i64 }*
  %t14 = call %NativeArtifact* @select_text_artifact({ %NativeArtifact*, i64 }* %t13)
  store %NativeArtifact* %t14, %NativeArtifact** %l1
  %t15 = load %NativeArtifact*, %NativeArtifact** %l1
  %t16 = icmp eq %NativeArtifact* %t15, null
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = load %NativeArtifact*, %NativeArtifact** %l1
  br i1 %t16, label %then0, label %merge1
then0:
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s20 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.len39.h1262256381, i32 0, i32 0
  %t21 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t19, i8* %s20)
  store { i8**, i64 }* %t21, { i8**, i64 }** %l0
  %s22 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t23 = insertvalue %LoweredPythonResult undef, i8* %s22, 0
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t25 = insertvalue %LoweredPythonResult %t23, { i8**, i64 }* %t24, 1
  ret %LoweredPythonResult %t25
merge1:
  %t26 = load %NativeArtifact*, %NativeArtifact** %l1
  %t27 = getelementptr %NativeArtifact, %NativeArtifact* %t26, i32 0, i32 2
  %t28 = load i8*, i8** %t27
  %t29 = call %ParseNativeResult @parse_native_artifact(i8* %t28)
  store %ParseNativeResult %t29, %ParseNativeResult* %l2
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t31 = load %ParseNativeResult, %ParseNativeResult* %l2
  %t32 = extractvalue %ParseNativeResult %t31, 6
  %t33 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t30, { i8**, i64 }* %t32)
  store { i8**, i64 }* %t33, { i8**, i64 }** %l0
  %t34 = load %ParseNativeResult, %ParseNativeResult* %l2
  %t35 = extractvalue %ParseNativeResult %t34, 0
  %t36 = load %ParseNativeResult, %ParseNativeResult* %l2
  %t37 = extractvalue %ParseNativeResult %t36, 1
  %t38 = load %ParseNativeResult, %ParseNativeResult* %l2
  %t39 = extractvalue %ParseNativeResult %t38, 2
  %t40 = load %ParseNativeResult, %ParseNativeResult* %l2
  %t41 = extractvalue %ParseNativeResult %t40, 4
  %t42 = load %ParseNativeResult, %ParseNativeResult* %l2
  %t43 = extractvalue %ParseNativeResult %t42, 5
  %t44 = bitcast { %NativeFunction**, i64 }* %t35 to { %NativeFunction*, i64 }*
  %t45 = bitcast { %NativeImport**, i64 }* %t37 to { %NativeImport*, i64 }*
  %t46 = bitcast { %NativeStruct**, i64 }* %t39 to { %NativeStruct*, i64 }*
  %t47 = bitcast { %NativeEnum**, i64 }* %t41 to { %NativeEnum*, i64 }*
  %t48 = bitcast { %NativeBinding**, i64 }* %t43 to { %NativeBinding*, i64 }*
  %t49 = call %PythonModuleEmission @emit_python_module({ %NativeFunction*, i64 }* %t44, { %NativeImport*, i64 }* %t45, { %NativeStruct*, i64 }* %t46, { %NativeEnum*, i64 }* %t47, { %NativeBinding*, i64 }* %t48)
  store %PythonModuleEmission %t49, %PythonModuleEmission* %l3
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t51 = load %PythonModuleEmission, %PythonModuleEmission* %l3
  %t52 = extractvalue %PythonModuleEmission %t51, 1
  %t53 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t50, { i8**, i64 }* %t52)
  store { i8**, i64 }* %t53, { i8**, i64 }** %l0
  %t54 = load %PythonModuleEmission, %PythonModuleEmission* %l3
  %t55 = extractvalue %PythonModuleEmission %t54, 0
  %t56 = call i8* @builder_to_string(%PythonBuilder %t55)
  store i8* %t56, i8** %l4
  %t57 = load i8*, i8** %l4
  %t58 = insertvalue %LoweredPythonResult undef, i8* %t57, 0
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t60 = insertvalue %LoweredPythonResult %t58, { i8**, i64 }* %t59, 1
  ret %LoweredPythonResult %t60
}

define %PythonModuleEmission @emit_python_module({ %NativeFunction*, i64 }* %functions, { %NativeImport*, i64 }* %imports, { %NativeStruct*, i64 }* %structs, { %NativeEnum*, i64 }* %enums, { %NativeBinding*, i64 }* %bindings) {
block.entry:
  %l0 = alloca %PythonBuilder
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca %PythonImportEmission
  %l4 = alloca %PythonStructEmission
  %l5 = alloca double
  %l6 = alloca %PythonFunctionEmission
  %t0 = call %PythonBuilder @builder_new()
  store %PythonBuilder %t0, %PythonBuilder* %l0
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
  %t13 = load %PythonBuilder, %PythonBuilder* %l0
  %s14 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h165481004, i32 0, i32 0
  %t15 = call %PythonBuilder @builder_emit(%PythonBuilder %t13, i8* %s14)
  store %PythonBuilder %t15, %PythonBuilder* %l0
  %t16 = load %PythonBuilder, %PythonBuilder* %l0
  %s17 = getelementptr inbounds [47 x i8], [47 x i8]* @.str.len46.h744586798, i32 0, i32 0
  %t18 = call %PythonBuilder @builder_emit(%PythonBuilder %t16, i8* %s17)
  store %PythonBuilder %t18, %PythonBuilder* %l0
  %t19 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t20 = ptrtoint [0 x i8*]* %t19 to i64
  %t21 = icmp eq i64 %t20, 0
  %t22 = select i1 %t21, i64 1, i64 %t20
  %t23 = call i8* @malloc(i64 %t22)
  %t24 = bitcast i8* %t23 to i8**
  %t25 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t26 = ptrtoint { i8**, i64 }* %t25 to i64
  %t27 = call i8* @malloc(i64 %t26)
  %t28 = bitcast i8* %t27 to { i8**, i64 }*
  %t29 = getelementptr { i8**, i64 }, { i8**, i64 }* %t28, i32 0, i32 0
  store i8** %t24, i8*** %t29
  %t30 = getelementptr { i8**, i64 }, { i8**, i64 }* %t28, i32 0, i32 1
  store i64 0, i64* %t30
  store { i8**, i64 }* %t28, { i8**, i64 }** %l2
  %t31 = load { %NativeImport*, i64 }, { %NativeImport*, i64 }* %imports
  %t32 = extractvalue { %NativeImport*, i64 } %t31, 1
  %t33 = icmp sgt i64 %t32, 0
  %t34 = load %PythonBuilder, %PythonBuilder* %l0
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t33, label %then0, label %merge1
then0:
  %t37 = load %PythonBuilder, %PythonBuilder* %l0
  %t38 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t37)
  store %PythonBuilder %t38, %PythonBuilder* %l0
  %t39 = load %PythonBuilder, %PythonBuilder* %l0
  %t40 = call %PythonImportEmission @emit_python_imports(%PythonBuilder %t39, { %NativeImport*, i64 }* %imports)
  store %PythonImportEmission %t40, %PythonImportEmission* %l3
  %t41 = load %PythonImportEmission, %PythonImportEmission* %l3
  %t42 = extractvalue %PythonImportEmission %t41, 0
  store %PythonBuilder %t42, %PythonBuilder* %l0
  %t43 = load %PythonImportEmission, %PythonImportEmission* %l3
  %t44 = extractvalue %PythonImportEmission %t43, 1
  store { i8**, i64 }* %t44, { i8**, i64 }** %l2
  %t45 = load %PythonBuilder, %PythonBuilder* %l0
  %t46 = load %PythonBuilder, %PythonBuilder* %l0
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br label %merge1
merge1:
  %t48 = phi %PythonBuilder [ %t45, %then0 ], [ %t34, %block.entry ]
  %t49 = phi %PythonBuilder [ %t46, %then0 ], [ %t34, %block.entry ]
  %t50 = phi { i8**, i64 }* [ %t47, %then0 ], [ %t36, %block.entry ]
  store %PythonBuilder %t48, %PythonBuilder* %l0
  store %PythonBuilder %t49, %PythonBuilder* %l0
  store { i8**, i64 }* %t50, { i8**, i64 }** %l2
  %t51 = load %PythonBuilder, %PythonBuilder* %l0
  %t52 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t51)
  store %PythonBuilder %t52, %PythonBuilder* %l0
  %t53 = load %PythonBuilder, %PythonBuilder* %l0
  %t54 = call %PythonBuilder @emit_runtime_aliases(%PythonBuilder %t53)
  store %PythonBuilder %t54, %PythonBuilder* %l0
  %t55 = load { %NativeBinding*, i64 }, { %NativeBinding*, i64 }* %bindings
  %t56 = extractvalue { %NativeBinding*, i64 } %t55, 1
  %t57 = icmp sgt i64 %t56, 0
  %t58 = load %PythonBuilder, %PythonBuilder* %l0
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t57, label %then2, label %merge3
then2:
  %t61 = load %PythonBuilder, %PythonBuilder* %l0
  %t62 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t61)
  store %PythonBuilder %t62, %PythonBuilder* %l0
  %t63 = load %PythonBuilder, %PythonBuilder* %l0
  %t64 = call %PythonBuilder @emit_top_level_bindings(%PythonBuilder %t63, { %NativeBinding*, i64 }* %bindings)
  store %PythonBuilder %t64, %PythonBuilder* %l0
  %t65 = load %PythonBuilder, %PythonBuilder* %l0
  %t66 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge3
merge3:
  %t67 = phi %PythonBuilder [ %t65, %then2 ], [ %t58, %merge1 ]
  %t68 = phi %PythonBuilder [ %t66, %then2 ], [ %t58, %merge1 ]
  store %PythonBuilder %t67, %PythonBuilder* %l0
  store %PythonBuilder %t68, %PythonBuilder* %l0
  %t69 = load { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* %enums
  %t70 = extractvalue { %NativeEnum*, i64 } %t69, 1
  %t71 = icmp sgt i64 %t70, 0
  %t72 = load %PythonBuilder, %PythonBuilder* %l0
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t71, label %then4, label %merge5
then4:
  %t75 = load %PythonBuilder, %PythonBuilder* %l0
  %t76 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t75)
  store %PythonBuilder %t76, %PythonBuilder* %l0
  %t77 = load %PythonBuilder, %PythonBuilder* %l0
  %t78 = call %PythonBuilder @emit_enum_definitions(%PythonBuilder %t77, { %NativeEnum*, i64 }* %enums)
  store %PythonBuilder %t78, %PythonBuilder* %l0
  %t79 = load %PythonBuilder, %PythonBuilder* %l0
  %t80 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge5
merge5:
  %t81 = phi %PythonBuilder [ %t79, %then4 ], [ %t72, %merge3 ]
  %t82 = phi %PythonBuilder [ %t80, %then4 ], [ %t72, %merge3 ]
  store %PythonBuilder %t81, %PythonBuilder* %l0
  store %PythonBuilder %t82, %PythonBuilder* %l0
  %t83 = load { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* %structs
  %t84 = extractvalue { %NativeStruct*, i64 } %t83, 1
  %t85 = icmp sgt i64 %t84, 0
  %t86 = load %PythonBuilder, %PythonBuilder* %l0
  %t87 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t85, label %then6, label %merge7
then6:
  %t89 = load %PythonBuilder, %PythonBuilder* %l0
  %t90 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t89)
  store %PythonBuilder %t90, %PythonBuilder* %l0
  %t91 = load %PythonBuilder, %PythonBuilder* %l0
  %t92 = call %PythonStructEmission @emit_struct_definitions(%PythonBuilder %t91, { %NativeStruct*, i64 }* %structs)
  store %PythonStructEmission %t92, %PythonStructEmission* %l4
  %t93 = load %PythonStructEmission, %PythonStructEmission* %l4
  %t94 = extractvalue %PythonStructEmission %t93, 0
  store %PythonBuilder %t94, %PythonBuilder* %l0
  %t95 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t96 = load %PythonStructEmission, %PythonStructEmission* %l4
  %t97 = extractvalue %PythonStructEmission %t96, 1
  %t98 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t95, { i8**, i64 }* %t97)
  store { i8**, i64 }* %t98, { i8**, i64 }** %l1
  %t99 = load %PythonBuilder, %PythonBuilder* %l0
  %t100 = load %PythonBuilder, %PythonBuilder* %l0
  %t101 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge7
merge7:
  %t102 = phi %PythonBuilder [ %t99, %then6 ], [ %t86, %merge5 ]
  %t103 = phi %PythonBuilder [ %t100, %then6 ], [ %t86, %merge5 ]
  %t104 = phi { i8**, i64 }* [ %t101, %then6 ], [ %t87, %merge5 ]
  store %PythonBuilder %t102, %PythonBuilder* %l0
  store %PythonBuilder %t103, %PythonBuilder* %l0
  store { i8**, i64 }* %t104, { i8**, i64 }** %l1
  %t105 = load %PythonBuilder, %PythonBuilder* %l0
  %t106 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t105)
  store %PythonBuilder %t106, %PythonBuilder* %l0
  %t107 = sitofp i64 0 to double
  store double %t107, double* %l5
  %t108 = load %PythonBuilder, %PythonBuilder* %l0
  %t109 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t110 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t111 = load double, double* %l5
  br label %loop.header8
loop.header8:
  %t159 = phi %PythonBuilder [ %t108, %merge7 ], [ %t156, %loop.latch10 ]
  %t160 = phi { i8**, i64 }* [ %t109, %merge7 ], [ %t157, %loop.latch10 ]
  %t161 = phi double [ %t111, %merge7 ], [ %t158, %loop.latch10 ]
  store %PythonBuilder %t159, %PythonBuilder* %l0
  store { i8**, i64 }* %t160, { i8**, i64 }** %l1
  store double %t161, double* %l5
  br label %loop.body9
loop.body9:
  %t112 = load double, double* %l5
  %t113 = load { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %functions
  %t114 = extractvalue { %NativeFunction*, i64 } %t113, 1
  %t115 = sitofp i64 %t114 to double
  %t116 = fcmp oge double %t112, %t115
  %t117 = load %PythonBuilder, %PythonBuilder* %l0
  %t118 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t119 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t120 = load double, double* %l5
  br i1 %t116, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t121 = load %PythonBuilder, %PythonBuilder* %l0
  %t122 = load double, double* %l5
  %t123 = fptosi double %t122 to i64
  %t124 = load { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %functions
  %t125 = extractvalue { %NativeFunction*, i64 } %t124, 0
  %t126 = extractvalue { %NativeFunction*, i64 } %t124, 1
  %t127 = icmp uge i64 %t123, %t126
  ; bounds check: %t127 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t123, i64 %t126)
  %t128 = getelementptr %NativeFunction, %NativeFunction* %t125, i64 %t123
  %t129 = load %NativeFunction, %NativeFunction* %t128
  %t130 = call %PythonFunctionEmission @emit_python_function(%PythonBuilder %t121, %NativeFunction %t129)
  store %PythonFunctionEmission %t130, %PythonFunctionEmission* %l6
  %t131 = load %PythonFunctionEmission, %PythonFunctionEmission* %l6
  %t132 = extractvalue %PythonFunctionEmission %t131, 0
  store %PythonBuilder %t132, %PythonBuilder* %l0
  %t133 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t134 = load %PythonFunctionEmission, %PythonFunctionEmission* %l6
  %t135 = extractvalue %PythonFunctionEmission %t134, 1
  %t136 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t133, { i8**, i64 }* %t135)
  store { i8**, i64 }* %t136, { i8**, i64 }** %l1
  %t137 = load double, double* %l5
  %t138 = sitofp i64 1 to double
  %t139 = fadd double %t137, %t138
  %t140 = load { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %functions
  %t141 = extractvalue { %NativeFunction*, i64 } %t140, 1
  %t142 = sitofp i64 %t141 to double
  %t143 = fcmp olt double %t139, %t142
  %t144 = load %PythonBuilder, %PythonBuilder* %l0
  %t145 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t146 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t147 = load double, double* %l5
  %t148 = load %PythonFunctionEmission, %PythonFunctionEmission* %l6
  br i1 %t143, label %then14, label %merge15
then14:
  %t149 = load %PythonBuilder, %PythonBuilder* %l0
  %t150 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t149)
  store %PythonBuilder %t150, %PythonBuilder* %l0
  %t151 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge15
merge15:
  %t152 = phi %PythonBuilder [ %t151, %then14 ], [ %t144, %merge13 ]
  store %PythonBuilder %t152, %PythonBuilder* %l0
  %t153 = load double, double* %l5
  %t154 = sitofp i64 1 to double
  %t155 = fadd double %t153, %t154
  store double %t155, double* %l5
  br label %loop.latch10
loop.latch10:
  %t156 = load %PythonBuilder, %PythonBuilder* %l0
  %t157 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t158 = load double, double* %l5
  br label %loop.header8
afterloop11:
  %t162 = load %PythonBuilder, %PythonBuilder* %l0
  %t163 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t164 = load double, double* %l5
  %t165 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t166 = load { i8**, i64 }, { i8**, i64 }* %t165
  %t167 = extractvalue { i8**, i64 } %t166, 1
  %t168 = icmp sgt i64 %t167, 0
  %t169 = load %PythonBuilder, %PythonBuilder* %l0
  %t170 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t171 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t172 = load double, double* %l5
  br i1 %t168, label %then16, label %merge17
then16:
  %t173 = load %PythonBuilder, %PythonBuilder* %l0
  %t174 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t173)
  store %PythonBuilder %t174, %PythonBuilder* %l0
  %t175 = load %PythonBuilder, %PythonBuilder* %l0
  %t176 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t177 = call %PythonBuilder @emit_export_list(%PythonBuilder %t175, { i8**, i64 }* %t176)
  store %PythonBuilder %t177, %PythonBuilder* %l0
  %t178 = load %PythonBuilder, %PythonBuilder* %l0
  %t179 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge17
merge17:
  %t180 = phi %PythonBuilder [ %t178, %then16 ], [ %t169, %afterloop11 ]
  %t181 = phi %PythonBuilder [ %t179, %then16 ], [ %t169, %afterloop11 ]
  store %PythonBuilder %t180, %PythonBuilder* %l0
  store %PythonBuilder %t181, %PythonBuilder* %l0
  %t182 = load %PythonBuilder, %PythonBuilder* %l0
  %t183 = insertvalue %PythonModuleEmission undef, %PythonBuilder %t182, 0
  %t184 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t185 = insertvalue %PythonModuleEmission %t183, { i8**, i64 }* %t184, 1
  ret %PythonModuleEmission %t185
}

define %PythonBuilder @emit_runtime_aliases(%PythonBuilder %builder) {
block.entry:
  %l0 = alloca %PythonBuilder
  store %PythonBuilder %builder, %PythonBuilder* %l0
  %t0 = load %PythonBuilder, %PythonBuilder* %l0
  %s1 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.len23.h225115061, i32 0, i32 0
  %t2 = call %PythonBuilder @builder_emit(%PythonBuilder %t0, i8* %s1)
  store %PythonBuilder %t2, %PythonBuilder* %l0
  %t3 = load %PythonBuilder, %PythonBuilder* %l0
  %s4 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.len21.h464873829, i32 0, i32 0
  %t5 = call %PythonBuilder @builder_emit(%PythonBuilder %t3, i8* %s4)
  store %PythonBuilder %t5, %PythonBuilder* %l0
  %t6 = load %PythonBuilder, %PythonBuilder* %l0
  %s7 = getelementptr inbounds [26 x i8], [26 x i8]* @.str.len25.h1882901628, i32 0, i32 0
  %t8 = call %PythonBuilder @builder_emit(%PythonBuilder %t6, i8* %s7)
  store %PythonBuilder %t8, %PythonBuilder* %l0
  %t9 = load %PythonBuilder, %PythonBuilder* %l0
  %s10 = getelementptr inbounds [28 x i8], [28 x i8]* @.str.len27.h1230134945, i32 0, i32 0
  %t11 = call %PythonBuilder @builder_emit(%PythonBuilder %t9, i8* %s10)
  store %PythonBuilder %t11, %PythonBuilder* %l0
  %t12 = load %PythonBuilder, %PythonBuilder* %l0
  %s13 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.len21.h1480982861, i32 0, i32 0
  %t14 = call %PythonBuilder @builder_emit(%PythonBuilder %t12, i8* %s13)
  store %PythonBuilder %t14, %PythonBuilder* %l0
  %t15 = load %PythonBuilder, %PythonBuilder* %l0
  %s16 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h2008919863, i32 0, i32 0
  %t17 = call %PythonBuilder @builder_emit(%PythonBuilder %t15, i8* %s16)
  store %PythonBuilder %t17, %PythonBuilder* %l0
  %t18 = load %PythonBuilder, %PythonBuilder* %l0
  %s19 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.len21.h949071414, i32 0, i32 0
  %t20 = call %PythonBuilder @builder_emit(%PythonBuilder %t18, i8* %s19)
  store %PythonBuilder %t20, %PythonBuilder* %l0
  %t21 = load %PythonBuilder, %PythonBuilder* %l0
  %s22 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h190885179, i32 0, i32 0
  %t23 = call %PythonBuilder @builder_emit(%PythonBuilder %t21, i8* %s22)
  store %PythonBuilder %t23, %PythonBuilder* %l0
  %t24 = load %PythonBuilder, %PythonBuilder* %l0
  %s25 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.len29.h1075519908, i32 0, i32 0
  %t26 = call %PythonBuilder @builder_emit(%PythonBuilder %t24, i8* %s25)
  store %PythonBuilder %t26, %PythonBuilder* %l0
  %t27 = load %PythonBuilder, %PythonBuilder* %l0
  %s28 = getelementptr inbounds [36 x i8], [36 x i8]* @.str.len35.h207688710, i32 0, i32 0
  %t29 = call %PythonBuilder @builder_emit(%PythonBuilder %t27, i8* %s28)
  store %PythonBuilder %t29, %PythonBuilder* %l0
  %t30 = load %PythonBuilder, %PythonBuilder* %l0
  %s31 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.len29.h1468169, i32 0, i32 0
  %t32 = call %PythonBuilder @builder_emit(%PythonBuilder %t30, i8* %s31)
  store %PythonBuilder %t32, %PythonBuilder* %l0
  %t33 = load %PythonBuilder, %PythonBuilder* %l0
  %s34 = getelementptr inbounds [36 x i8], [36 x i8]* @.str.len35.h129830246, i32 0, i32 0
  %t35 = call %PythonBuilder @builder_emit(%PythonBuilder %t33, i8* %s34)
  store %PythonBuilder %t35, %PythonBuilder* %l0
  %t36 = load %PythonBuilder, %PythonBuilder* %l0
  %s37 = getelementptr inbounds [36 x i8], [36 x i8]* @.str.len35.h1076062162, i32 0, i32 0
  %t38 = call %PythonBuilder @builder_emit(%PythonBuilder %t36, i8* %s37)
  store %PythonBuilder %t38, %PythonBuilder* %l0
  %t39 = load %PythonBuilder, %PythonBuilder* %l0
  %s40 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.len29.h29541381, i32 0, i32 0
  %t41 = call %PythonBuilder @builder_emit(%PythonBuilder %t39, i8* %s40)
  store %PythonBuilder %t41, %PythonBuilder* %l0
  %t42 = load %PythonBuilder, %PythonBuilder* %l0
  %s43 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.len31.h1408297199, i32 0, i32 0
  %t44 = call %PythonBuilder @builder_emit(%PythonBuilder %t42, i8* %s43)
  store %PythonBuilder %t44, %PythonBuilder* %l0
  %t45 = load %PythonBuilder, %PythonBuilder* %l0
  ret %PythonBuilder %t45
}

define %PythonBuilder @emit_top_level_bindings(%PythonBuilder %builder, { %NativeBinding*, i64 }* %bindings) {
block.entry:
  %l0 = alloca %PythonBuilder
  %l1 = alloca double
  %l2 = alloca %NativeBinding
  %l3 = alloca i8*
  %l4 = alloca i8*
  %l5 = alloca i8*
  store %PythonBuilder %builder, %PythonBuilder* %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load %PythonBuilder, %PythonBuilder* %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t52 = phi %PythonBuilder [ %t1, %block.entry ], [ %t50, %loop.latch2 ]
  %t53 = phi double [ %t2, %block.entry ], [ %t51, %loop.latch2 ]
  store %PythonBuilder %t52, %PythonBuilder* %l0
  store double %t53, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load { %NativeBinding*, i64 }, { %NativeBinding*, i64 }* %bindings
  %t5 = extractvalue { %NativeBinding*, i64 } %t4, 1
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp oge double %t3, %t6
  %t8 = load %PythonBuilder, %PythonBuilder* %l0
  %t9 = load double, double* %l1
  br i1 %t7, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t10 = load double, double* %l1
  %t11 = fptosi double %t10 to i64
  %t12 = load { %NativeBinding*, i64 }, { %NativeBinding*, i64 }* %bindings
  %t13 = extractvalue { %NativeBinding*, i64 } %t12, 0
  %t14 = extractvalue { %NativeBinding*, i64 } %t12, 1
  %t15 = icmp uge i64 %t11, %t14
  ; bounds check: %t15 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t11, i64 %t14)
  %t16 = getelementptr %NativeBinding, %NativeBinding* %t13, i64 %t11
  %t17 = load %NativeBinding, %NativeBinding* %t16
  store %NativeBinding %t17, %NativeBinding* %l2
  %t18 = load %NativeBinding, %NativeBinding* %l2
  %t19 = extractvalue %NativeBinding %t18, 0
  %t20 = call i8* @sanitize_identifier(i8* %t19)
  store i8* %t20, i8** %l3
  %t21 = load i8*, i8** %l3
  %s22 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087691079, i32 0, i32 0
  %t23 = call i8* @sailfin_runtime_string_concat(i8* %t21, i8* %s22)
  store i8* %t23, i8** %l4
  %t24 = load %NativeBinding, %NativeBinding* %l2
  %t25 = extractvalue %NativeBinding %t24, 3
  %t26 = icmp ne i8* %t25, null
  %t27 = load %PythonBuilder, %PythonBuilder* %l0
  %t28 = load double, double* %l1
  %t29 = load %NativeBinding, %NativeBinding* %l2
  %t30 = load i8*, i8** %l3
  %t31 = load i8*, i8** %l4
  br i1 %t26, label %then6, label %else7
then6:
  %t32 = load %NativeBinding, %NativeBinding* %l2
  %t33 = extractvalue %NativeBinding %t32, 3
  store i8* %t33, i8** %l5
  %t34 = load i8*, i8** %l4
  %t35 = load i8*, i8** %l5
  %t36 = call i8* @lower_expression(i8* %t35)
  %t37 = call i8* @sailfin_runtime_string_concat(i8* %t34, i8* %t36)
  store i8* %t37, i8** %l4
  %t38 = load i8*, i8** %l4
  br label %merge8
else7:
  %t39 = load i8*, i8** %l4
  %s40 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h230766299, i32 0, i32 0
  %t41 = call i8* @sailfin_runtime_string_concat(i8* %t39, i8* %s40)
  store i8* %t41, i8** %l4
  %t42 = load i8*, i8** %l4
  br label %merge8
merge8:
  %t43 = phi i8* [ %t38, %then6 ], [ %t42, %else7 ]
  store i8* %t43, i8** %l4
  %t44 = load %PythonBuilder, %PythonBuilder* %l0
  %t45 = load i8*, i8** %l4
  %t46 = call %PythonBuilder @builder_emit(%PythonBuilder %t44, i8* %t45)
  store %PythonBuilder %t46, %PythonBuilder* %l0
  %t47 = load double, double* %l1
  %t48 = sitofp i64 1 to double
  %t49 = fadd double %t47, %t48
  store double %t49, double* %l1
  br label %loop.latch2
loop.latch2:
  %t50 = load %PythonBuilder, %PythonBuilder* %l0
  %t51 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t54 = load %PythonBuilder, %PythonBuilder* %l0
  %t55 = load double, double* %l1
  %t56 = load %PythonBuilder, %PythonBuilder* %l0
  ret %PythonBuilder %t56
}

define %PythonImportEmission @emit_python_imports(%PythonBuilder %builder, { %NativeImport*, i64 }* %imports) {
block.entry:
  %l0 = alloca %PythonBuilder
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca %NativeImport
  %l4 = alloca i8*
  %l5 = alloca i8*
  store %PythonBuilder %builder, %PythonBuilder* %l0
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
  store { i8**, i64 }* %t9, { i8**, i64 }** %l1
  %t12 = sitofp i64 0 to double
  store double %t12, double* %l2
  %t13 = load %PythonBuilder, %PythonBuilder* %l0
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t15 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t84 = phi { i8**, i64 }* [ %t14, %block.entry ], [ %t81, %loop.latch2 ]
  %t85 = phi double [ %t15, %block.entry ], [ %t82, %loop.latch2 ]
  %t86 = phi %PythonBuilder [ %t13, %block.entry ], [ %t83, %loop.latch2 ]
  store { i8**, i64 }* %t84, { i8**, i64 }** %l1
  store double %t85, double* %l2
  store %PythonBuilder %t86, %PythonBuilder* %l0
  br label %loop.body1
loop.body1:
  %t16 = load double, double* %l2
  %t17 = load { %NativeImport*, i64 }, { %NativeImport*, i64 }* %imports
  %t18 = extractvalue { %NativeImport*, i64 } %t17, 1
  %t19 = sitofp i64 %t18 to double
  %t20 = fcmp oge double %t16, %t19
  %t21 = load %PythonBuilder, %PythonBuilder* %l0
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t23 = load double, double* %l2
  br i1 %t20, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t24 = load double, double* %l2
  %t25 = fptosi double %t24 to i64
  %t26 = load { %NativeImport*, i64 }, { %NativeImport*, i64 }* %imports
  %t27 = extractvalue { %NativeImport*, i64 } %t26, 0
  %t28 = extractvalue { %NativeImport*, i64 } %t26, 1
  %t29 = icmp uge i64 %t25, %t28
  ; bounds check: %t29 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t25, i64 %t28)
  %t30 = getelementptr %NativeImport, %NativeImport* %t27, i64 %t25
  %t31 = load %NativeImport, %NativeImport* %t30
  store %NativeImport %t31, %NativeImport* %l3
  %t32 = load %NativeImport, %NativeImport* %l3
  %t33 = extractvalue %NativeImport %t32, 0
  %s34 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h42978514, i32 0, i32 0
  %t35 = icmp eq i8* %t33, %s34
  %t36 = load %PythonBuilder, %PythonBuilder* %l0
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t38 = load double, double* %l2
  %t39 = load %NativeImport, %NativeImport* %l3
  br i1 %t35, label %then6, label %merge7
then6:
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t41 = load %NativeImport, %NativeImport* %l3
  %t42 = extractvalue %NativeImport %t41, 2
  %t43 = bitcast { %NativeImportSpecifier**, i64 }* %t42 to { %NativeImportSpecifier*, i64 }*
  %t44 = call { i8**, i64 }* @collect_export_names({ i8**, i64 }* %t40, { %NativeImportSpecifier*, i64 }* %t43)
  store { i8**, i64 }* %t44, { i8**, i64 }** %l1
  %t45 = load %NativeImport, %NativeImport* %l3
  %t46 = extractvalue %NativeImport %t45, 1
  %t47 = call i8* @trim_text(i8* %t46)
  store i8* %t47, i8** %l4
  %t48 = load i8*, i8** %l4
  %t49 = call i64 @sailfin_runtime_string_length(i8* %t48)
  %t50 = icmp eq i64 %t49, 0
  %t51 = load %PythonBuilder, %PythonBuilder* %l0
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t53 = load double, double* %l2
  %t54 = load %NativeImport, %NativeImport* %l3
  %t55 = load i8*, i8** %l4
  br i1 %t50, label %then8, label %merge9
then8:
  %t56 = load double, double* %l2
  %t57 = sitofp i64 1 to double
  %t58 = fadd double %t56, %t57
  store double %t58, double* %l2
  br label %loop.latch2
merge9:
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t60 = load double, double* %l2
  br label %merge7
merge7:
  %t61 = phi { i8**, i64 }* [ %t59, %merge9 ], [ %t37, %merge5 ]
  %t62 = phi double [ %t60, %merge9 ], [ %t38, %merge5 ]
  store { i8**, i64 }* %t61, { i8**, i64 }** %l1
  store double %t62, double* %l2
  %t63 = load %NativeImport, %NativeImport* %l3
  %t64 = call i8* @render_python_import(%NativeImport %t63)
  store i8* %t64, i8** %l5
  %t65 = load i8*, i8** %l5
  %t66 = call i64 @sailfin_runtime_string_length(i8* %t65)
  %t67 = icmp sgt i64 %t66, 0
  %t68 = load %PythonBuilder, %PythonBuilder* %l0
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t70 = load double, double* %l2
  %t71 = load %NativeImport, %NativeImport* %l3
  %t72 = load i8*, i8** %l5
  br i1 %t67, label %then10, label %merge11
then10:
  %t73 = load %PythonBuilder, %PythonBuilder* %l0
  %t74 = load i8*, i8** %l5
  %t75 = call %PythonBuilder @builder_emit(%PythonBuilder %t73, i8* %t74)
  store %PythonBuilder %t75, %PythonBuilder* %l0
  %t76 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge11
merge11:
  %t77 = phi %PythonBuilder [ %t76, %then10 ], [ %t68, %merge7 ]
  store %PythonBuilder %t77, %PythonBuilder* %l0
  %t78 = load double, double* %l2
  %t79 = sitofp i64 1 to double
  %t80 = fadd double %t78, %t79
  store double %t80, double* %l2
  br label %loop.latch2
loop.latch2:
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t82 = load double, double* %l2
  %t83 = load %PythonBuilder, %PythonBuilder* %l0
  br label %loop.header0
afterloop3:
  %t87 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t88 = load double, double* %l2
  %t89 = load %PythonBuilder, %PythonBuilder* %l0
  %t90 = load %PythonBuilder, %PythonBuilder* %l0
  %t91 = insertvalue %PythonImportEmission undef, %PythonBuilder %t90, 0
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t93 = insertvalue %PythonImportEmission %t91, { i8**, i64 }* %t92, 1
  ret %PythonImportEmission %t93
}

define %PythonBuilder @emit_enum_definitions(%PythonBuilder %builder, { %NativeEnum*, i64 }* %enums) {
block.entry:
  %l0 = alloca %PythonBuilder
  %l1 = alloca double
  store %PythonBuilder %builder, %PythonBuilder* %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load %PythonBuilder, %PythonBuilder* %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t38 = phi %PythonBuilder [ %t1, %block.entry ], [ %t36, %loop.latch2 ]
  %t39 = phi double [ %t2, %block.entry ], [ %t37, %loop.latch2 ]
  store %PythonBuilder %t38, %PythonBuilder* %l0
  store double %t39, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* %enums
  %t5 = extractvalue { %NativeEnum*, i64 } %t4, 1
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp oge double %t3, %t6
  %t8 = load %PythonBuilder, %PythonBuilder* %l0
  %t9 = load double, double* %l1
  br i1 %t7, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t10 = load %PythonBuilder, %PythonBuilder* %l0
  %t11 = load double, double* %l1
  %t12 = fptosi double %t11 to i64
  %t13 = load { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* %enums
  %t14 = extractvalue { %NativeEnum*, i64 } %t13, 0
  %t15 = extractvalue { %NativeEnum*, i64 } %t13, 1
  %t16 = icmp uge i64 %t12, %t15
  ; bounds check: %t16 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t12, i64 %t15)
  %t17 = getelementptr %NativeEnum, %NativeEnum* %t14, i64 %t12
  %t18 = load %NativeEnum, %NativeEnum* %t17
  %t19 = call %PythonBuilder @emit_single_enum(%PythonBuilder %t10, %NativeEnum %t18)
  store %PythonBuilder %t19, %PythonBuilder* %l0
  %t20 = load double, double* %l1
  %t21 = sitofp i64 1 to double
  %t22 = fadd double %t20, %t21
  %t23 = load { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* %enums
  %t24 = extractvalue { %NativeEnum*, i64 } %t23, 1
  %t25 = sitofp i64 %t24 to double
  %t26 = fcmp olt double %t22, %t25
  %t27 = load %PythonBuilder, %PythonBuilder* %l0
  %t28 = load double, double* %l1
  br i1 %t26, label %then6, label %merge7
then6:
  %t29 = load %PythonBuilder, %PythonBuilder* %l0
  %t30 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t29)
  store %PythonBuilder %t30, %PythonBuilder* %l0
  %t31 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge7
merge7:
  %t32 = phi %PythonBuilder [ %t31, %then6 ], [ %t27, %merge5 ]
  store %PythonBuilder %t32, %PythonBuilder* %l0
  %t33 = load double, double* %l1
  %t34 = sitofp i64 1 to double
  %t35 = fadd double %t33, %t34
  store double %t35, double* %l1
  br label %loop.latch2
loop.latch2:
  %t36 = load %PythonBuilder, %PythonBuilder* %l0
  %t37 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t40 = load %PythonBuilder, %PythonBuilder* %l0
  %t41 = load double, double* %l1
  %t42 = load %PythonBuilder, %PythonBuilder* %l0
  ret %PythonBuilder %t42
}

define %PythonBuilder @emit_single_enum(%PythonBuilder %builder, %NativeEnum %definition) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca %PythonBuilder
  %l2 = alloca double
  %l3 = alloca %NativeEnumVariant*
  %l4 = alloca i8*
  %l5 = alloca i8*
  %t0 = extractvalue %NativeEnum %definition, 0
  %t1 = call i8* @sanitize_identifier(i8* %t0)
  store i8* %t1, i8** %l0
  %t2 = load i8*, i8** %l0
  %s3 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h1699428905, i32 0, i32 0
  %t4 = call i8* @sailfin_runtime_string_concat(i8* %t2, i8* %s3)
  %t5 = load i8*, i8** %l0
  %t6 = call i8* @sailfin_runtime_string_concat(i8* %t4, i8* %t5)
  %s7 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193420823, i32 0, i32 0
  %t8 = call i8* @sailfin_runtime_string_concat(i8* %t6, i8* %s7)
  %t9 = call %PythonBuilder @builder_emit(%PythonBuilder %builder, i8* %t8)
  store %PythonBuilder %t9, %PythonBuilder* %l1
  %t10 = sitofp i64 0 to double
  store double %t10, double* %l2
  %t11 = load i8*, i8** %l0
  %t12 = load %PythonBuilder, %PythonBuilder* %l1
  %t13 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t63 = phi %PythonBuilder [ %t12, %block.entry ], [ %t61, %loop.latch2 ]
  %t64 = phi double [ %t13, %block.entry ], [ %t62, %loop.latch2 ]
  store %PythonBuilder %t63, %PythonBuilder* %l1
  store double %t64, double* %l2
  br label %loop.body1
loop.body1:
  %t14 = load double, double* %l2
  %t15 = extractvalue %NativeEnum %definition, 1
  %t16 = load { %NativeEnumVariant**, i64 }, { %NativeEnumVariant**, i64 }* %t15
  %t17 = extractvalue { %NativeEnumVariant**, i64 } %t16, 1
  %t18 = sitofp i64 %t17 to double
  %t19 = fcmp oge double %t14, %t18
  %t20 = load i8*, i8** %l0
  %t21 = load %PythonBuilder, %PythonBuilder* %l1
  %t22 = load double, double* %l2
  br i1 %t19, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t23 = extractvalue %NativeEnum %definition, 1
  %t24 = load double, double* %l2
  %t25 = fptosi double %t24 to i64
  %t26 = load { %NativeEnumVariant**, i64 }, { %NativeEnumVariant**, i64 }* %t23
  %t27 = extractvalue { %NativeEnumVariant**, i64 } %t26, 0
  %t28 = extractvalue { %NativeEnumVariant**, i64 } %t26, 1
  %t29 = icmp uge i64 %t25, %t28
  ; bounds check: %t29 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t25, i64 %t28)
  %t30 = getelementptr %NativeEnumVariant*, %NativeEnumVariant** %t27, i64 %t25
  %t31 = load %NativeEnumVariant*, %NativeEnumVariant** %t30
  store %NativeEnumVariant* %t31, %NativeEnumVariant** %l3
  %t32 = load %NativeEnumVariant*, %NativeEnumVariant** %l3
  %t33 = getelementptr %NativeEnumVariant, %NativeEnumVariant* %t32, i32 0, i32 0
  %t34 = load i8*, i8** %t33
  %t35 = call i8* @sanitize_identifier(i8* %t34)
  store i8* %t35, i8** %l4
  %t36 = load i8*, i8** %l0
  %s37 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.len31.h568140000, i32 0, i32 0
  %t38 = call i8* @sailfin_runtime_string_concat(i8* %t36, i8* %s37)
  %t39 = load i8*, i8** %l0
  %t40 = call i8* @sailfin_runtime_string_concat(i8* %t38, i8* %t39)
  %s41 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2088090973, i32 0, i32 0
  %t42 = call i8* @sailfin_runtime_string_concat(i8* %t40, i8* %s41)
  %t43 = load i8*, i8** %l4
  %t44 = call i8* @sailfin_runtime_string_concat(i8* %t42, i8* %t43)
  %s45 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h182022329, i32 0, i32 0
  %t46 = call i8* @sailfin_runtime_string_concat(i8* %t44, i8* %s45)
  %t47 = load %NativeEnumVariant*, %NativeEnumVariant** %l3
  %t48 = getelementptr %NativeEnumVariant, %NativeEnumVariant* %t47, i32 0, i32 1
  %t49 = load { %NativeEnumVariantField**, i64 }*, { %NativeEnumVariantField**, i64 }** %t48
  %t50 = bitcast { %NativeEnumVariantField**, i64 }* %t49 to { %NativeEnumVariantField*, i64 }*
  %t51 = call i8* @render_enum_variant_fields({ %NativeEnumVariantField*, i64 }* %t50)
  %t52 = call i8* @sailfin_runtime_string_concat(i8* %t46, i8* %t51)
  %s53 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193479629, i32 0, i32 0
  %t54 = call i8* @sailfin_runtime_string_concat(i8* %t52, i8* %s53)
  store i8* %t54, i8** %l5
  %t55 = load %PythonBuilder, %PythonBuilder* %l1
  %t56 = load i8*, i8** %l5
  %t57 = call %PythonBuilder @builder_emit(%PythonBuilder %t55, i8* %t56)
  store %PythonBuilder %t57, %PythonBuilder* %l1
  %t58 = load double, double* %l2
  %t59 = sitofp i64 1 to double
  %t60 = fadd double %t58, %t59
  store double %t60, double* %l2
  br label %loop.latch2
loop.latch2:
  %t61 = load %PythonBuilder, %PythonBuilder* %l1
  %t62 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t65 = load %PythonBuilder, %PythonBuilder* %l1
  %t66 = load double, double* %l2
  %t67 = load %PythonBuilder, %PythonBuilder* %l1
  ret %PythonBuilder %t67
}

define i8* @render_enum_variant_fields({ %NativeEnumVariantField*, i64 }* %fields) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %t0 = load { %NativeEnumVariantField*, i64 }, { %NativeEnumVariantField*, i64 }* %fields
  %t1 = extractvalue { %NativeEnumVariantField*, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  ret i8* %s3
merge1:
  %t4 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t5 = ptrtoint [0 x i8*]* %t4 to i64
  %t6 = icmp eq i64 %t5, 0
  %t7 = select i1 %t6, i64 1, i64 %t5
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to i8**
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t11 = ptrtoint { i8**, i64 }* %t10 to i64
  %t12 = call i8* @malloc(i64 %t11)
  %t13 = bitcast i8* %t12 to { i8**, i64 }*
  %t14 = getelementptr { i8**, i64 }, { i8**, i64 }* %t13, i32 0, i32 0
  store i8** %t9, i8*** %t14
  %t15 = getelementptr { i8**, i64 }, { i8**, i64 }* %t13, i32 0, i32 1
  store i64 0, i64* %t15
  store { i8**, i64 }* %t13, { i8**, i64 }** %l0
  %t16 = sitofp i64 0 to double
  store double %t16, double* %l1
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t53 = phi { i8**, i64 }* [ %t17, %merge1 ], [ %t51, %loop.latch4 ]
  %t54 = phi double [ %t18, %merge1 ], [ %t52, %loop.latch4 ]
  store { i8**, i64 }* %t53, { i8**, i64 }** %l0
  store double %t54, double* %l1
  br label %loop.body3
loop.body3:
  %t19 = load double, double* %l1
  %t20 = load { %NativeEnumVariantField*, i64 }, { %NativeEnumVariantField*, i64 }* %fields
  %t21 = extractvalue { %NativeEnumVariantField*, i64 } %t20, 1
  %t22 = sitofp i64 %t21 to double
  %t23 = fcmp oge double %t19, %t22
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t25 = load double, double* %l1
  br i1 %t23, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t27 = load double, double* %l1
  %t28 = fptosi double %t27 to i64
  %t29 = load { %NativeEnumVariantField*, i64 }, { %NativeEnumVariantField*, i64 }* %fields
  %t30 = extractvalue { %NativeEnumVariantField*, i64 } %t29, 0
  %t31 = extractvalue { %NativeEnumVariantField*, i64 } %t29, 1
  %t32 = icmp uge i64 %t28, %t31
  ; bounds check: %t32 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t28, i64 %t31)
  %t33 = getelementptr %NativeEnumVariantField, %NativeEnumVariantField* %t30, i64 %t28
  %t34 = load %NativeEnumVariantField, %NativeEnumVariantField* %t33
  %t35 = extractvalue %NativeEnumVariantField %t34, 0
  %t36 = call i8* @sanitize_identifier(i8* %t35)
  %t37 = alloca [2 x i8], align 1
  %t38 = getelementptr [2 x i8], [2 x i8]* %t37, i32 0, i32 0
  store i8 39, i8* %t38
  %t39 = getelementptr [2 x i8], [2 x i8]* %t37, i32 0, i32 1
  store i8 0, i8* %t39
  %t40 = getelementptr [2 x i8], [2 x i8]* %t37, i32 0, i32 0
  %t41 = call i8* @sailfin_runtime_string_concat(i8* %t40, i8* %t36)
  %t42 = alloca [2 x i8], align 1
  %t43 = getelementptr [2 x i8], [2 x i8]* %t42, i32 0, i32 0
  store i8 39, i8* %t43
  %t44 = getelementptr [2 x i8], [2 x i8]* %t42, i32 0, i32 1
  store i8 0, i8* %t44
  %t45 = getelementptr [2 x i8], [2 x i8]* %t42, i32 0, i32 0
  %t46 = call i8* @sailfin_runtime_string_concat(i8* %t41, i8* %t45)
  %t47 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t26, i8* %t46)
  store { i8**, i64 }* %t47, { i8**, i64 }** %l0
  %t48 = load double, double* %l1
  %t49 = sitofp i64 1 to double
  %t50 = fadd double %t48, %t49
  store double %t50, double* %l1
  br label %loop.latch4
loop.latch4:
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t52 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t56 = load double, double* %l1
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s58 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t59 = call i8* @join_with_separator({ i8**, i64 }* %t57, i8* %s58)
  ret i8* %t59
}

define i8* @render_python_import(%NativeImport %entry) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %t0 = extractvalue %NativeImport %entry, 1
  %t1 = call i8* @normalize_import_module(i8* %t0)
  store i8* %t1, i8** %l0
  %t2 = load i8*, i8** %l0
  %t3 = call i64 @sailfin_runtime_string_length(i8* %t2)
  %t4 = icmp eq i64 %t3, 0
  %t5 = load i8*, i8** %l0
  br i1 %t4, label %then0, label %merge1
then0:
  %s6 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  ret i8* %s6
merge1:
  %t7 = extractvalue %NativeImport %entry, 2
  %t8 = load { %NativeImportSpecifier**, i64 }, { %NativeImportSpecifier**, i64 }* %t7
  %t9 = extractvalue { %NativeImportSpecifier**, i64 } %t8, 1
  %t10 = icmp eq i64 %t9, 0
  %t11 = load i8*, i8** %l0
  br i1 %t10, label %then2, label %merge3
then2:
  %s12 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h919609845, i32 0, i32 0
  %t13 = load i8*, i8** %l0
  %t14 = call i8* @sailfin_runtime_string_concat(i8* %s12, i8* %t13)
  ret i8* %t14
merge3:
  %t15 = extractvalue %NativeImport %entry, 2
  %t16 = bitcast { %NativeImportSpecifier**, i64 }* %t15 to { %NativeImportSpecifier*, i64 }*
  %t17 = call i8* @render_python_specifiers({ %NativeImportSpecifier*, i64 }* %t16)
  store i8* %t17, i8** %l1
  %s18 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2115689699, i32 0, i32 0
  %t19 = load i8*, i8** %l0
  %t20 = call i8* @sailfin_runtime_string_concat(i8* %s18, i8* %t19)
  %s21 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1132499314, i32 0, i32 0
  %t22 = call i8* @sailfin_runtime_string_concat(i8* %t20, i8* %s21)
  %t23 = load i8*, i8** %l1
  %t24 = call i8* @sailfin_runtime_string_concat(i8* %t22, i8* %t23)
  ret i8* %t24
}

define i8* @render_python_specifiers({ %NativeImportSpecifier*, i64 }* %specifiers) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
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
  %t12 = sitofp i64 0 to double
  store double %t12, double* %l1
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t38 = phi { i8**, i64 }* [ %t13, %block.entry ], [ %t36, %loop.latch2 ]
  %t39 = phi double [ %t14, %block.entry ], [ %t37, %loop.latch2 ]
  store { i8**, i64 }* %t38, { i8**, i64 }** %l0
  store double %t39, double* %l1
  br label %loop.body1
loop.body1:
  %t15 = load double, double* %l1
  %t16 = load { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %specifiers
  %t17 = extractvalue { %NativeImportSpecifier*, i64 } %t16, 1
  %t18 = sitofp i64 %t17 to double
  %t19 = fcmp oge double %t15, %t18
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t21 = load double, double* %l1
  br i1 %t19, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t23 = load double, double* %l1
  %t24 = fptosi double %t23 to i64
  %t25 = load { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %specifiers
  %t26 = extractvalue { %NativeImportSpecifier*, i64 } %t25, 0
  %t27 = extractvalue { %NativeImportSpecifier*, i64 } %t25, 1
  %t28 = icmp uge i64 %t24, %t27
  ; bounds check: %t28 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t24, i64 %t27)
  %t29 = getelementptr %NativeImportSpecifier, %NativeImportSpecifier* %t26, i64 %t24
  %t30 = load %NativeImportSpecifier, %NativeImportSpecifier* %t29
  %t31 = call i8* @render_python_specifier(%NativeImportSpecifier %t30)
  %t32 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t22, i8* %t31)
  store { i8**, i64 }* %t32, { i8**, i64 }** %l0
  %t33 = load double, double* %l1
  %t34 = sitofp i64 1 to double
  %t35 = fadd double %t33, %t34
  store double %t35, double* %l1
  br label %loop.latch2
loop.latch2:
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t37 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t41 = load double, double* %l1
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s43 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t44 = call i8* @join_with_separator({ i8**, i64 }* %t42, i8* %s43)
  ret i8* %t44
}

define i8* @render_python_specifier(%NativeImportSpecifier %specifier) {
block.entry:
  %l0 = alloca i8*
  %t0 = extractvalue %NativeImportSpecifier %specifier, 0
  %t1 = call i8* @sanitize_identifier(i8* %t0)
  store i8* %t1, i8** %l0
  %t3 = extractvalue %NativeImportSpecifier %specifier, 1
  %t4 = icmp eq i8* %t3, null
  br label %logical_or_entry_2

logical_or_entry_2:
  br i1 %t4, label %logical_or_merge_2, label %logical_or_right_2

logical_or_right_2:
  %t5 = extractvalue %NativeImportSpecifier %specifier, 1
  %t6 = call i64 @sailfin_runtime_string_length(i8* %t5)
  %t7 = icmp eq i64 %t6, 0
  br label %logical_or_right_end_2

logical_or_right_end_2:
  br label %logical_or_merge_2

logical_or_merge_2:
  %t8 = phi i1 [ true, %logical_or_entry_2 ], [ %t7, %logical_or_right_end_2 ]
  %t9 = load i8*, i8** %l0
  br i1 %t8, label %then0, label %merge1
then0:
  %t10 = load i8*, i8** %l0
  ret i8* %t10
merge1:
  %t11 = load i8*, i8** %l0
  %s12 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h175713983, i32 0, i32 0
  %t13 = call i8* @sailfin_runtime_string_concat(i8* %t11, i8* %s12)
  %t14 = extractvalue %NativeImportSpecifier %specifier, 1
  %t15 = call i8* @sanitize_identifier(i8* %t14)
  %t16 = call i8* @sailfin_runtime_string_concat(i8* %t13, i8* %t15)
  ret i8* %t16
}

define i8* @normalize_import_module(i8* %path) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %t0 = call i8* @trim_text(i8* %path)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = load i8*, i8** %l0
  ret i8* %t5
merge1:
  %t6 = load i8*, i8** %l0
  %s7 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h2085806463, i32 0, i32 0
  %t8 = call i1 @starts_with(i8* %t6, i8* %s7)
  %t9 = load i8*, i8** %l0
  br i1 %t8, label %then2, label %merge3
then2:
  %t10 = load i8*, i8** %l0
  %t11 = alloca [2 x i8], align 1
  %t12 = getelementptr [2 x i8], [2 x i8]* %t11, i32 0, i32 0
  store i8 47, i8* %t12
  %t13 = getelementptr [2 x i8], [2 x i8]* %t11, i32 0, i32 1
  store i8 0, i8* %t13
  %t14 = getelementptr [2 x i8], [2 x i8]* %t11, i32 0, i32 0
  %t15 = alloca [2 x i8], align 1
  %t16 = getelementptr [2 x i8], [2 x i8]* %t15, i32 0, i32 0
  store i8 46, i8* %t16
  %t17 = getelementptr [2 x i8], [2 x i8]* %t15, i32 0, i32 1
  store i8 0, i8* %t17
  %t18 = getelementptr [2 x i8], [2 x i8]* %t15, i32 0, i32 0
  %t19 = call i8* @replace_all(i8* %t10, i8* %t14, i8* %t18)
  store i8* %t19, i8** %l1
  %s20 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h1309566598, i32 0, i32 0
  %t21 = load i8*, i8** %l1
  %t22 = call i8* @sailfin_runtime_string_concat(i8* %s20, i8* %t21)
  ret i8* %t22
merge3:
  %t23 = load i8*, i8** %l0
  %s24 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193428644, i32 0, i32 0
  %t25 = call i1 @starts_with(i8* %t23, i8* %s24)
  %t26 = load i8*, i8** %l0
  br i1 %t25, label %then4, label %merge5
then4:
  %t27 = load i8*, i8** %l0
  %t28 = load i8*, i8** %l0
  %t29 = call i64 @sailfin_runtime_string_length(i8* %t28)
  %t30 = call i8* @sailfin_runtime_substring(i8* %t27, i64 2, i64 %t29)
  store i8* %t30, i8** %l2
  %t31 = load i8*, i8** %l2
  %t32 = alloca [2 x i8], align 1
  %t33 = getelementptr [2 x i8], [2 x i8]* %t32, i32 0, i32 0
  store i8 47, i8* %t33
  %t34 = getelementptr [2 x i8], [2 x i8]* %t32, i32 0, i32 1
  store i8 0, i8* %t34
  %t35 = getelementptr [2 x i8], [2 x i8]* %t32, i32 0, i32 0
  %t36 = alloca [2 x i8], align 1
  %t37 = getelementptr [2 x i8], [2 x i8]* %t36, i32 0, i32 0
  store i8 46, i8* %t37
  %t38 = getelementptr [2 x i8], [2 x i8]* %t36, i32 0, i32 1
  store i8 0, i8* %t38
  %t39 = getelementptr [2 x i8], [2 x i8]* %t36, i32 0, i32 0
  %t40 = call i8* @replace_all(i8* %t31, i8* %t35, i8* %t39)
  store i8* %t40, i8** %l2
  %s41 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h1309566598, i32 0, i32 0
  %t42 = load i8*, i8** %l2
  %t43 = call i8* @sailfin_runtime_string_concat(i8* %s41, i8* %t42)
  ret i8* %t43
merge5:
  %t44 = load i8*, i8** %l0
  %t45 = alloca [2 x i8], align 1
  %t46 = getelementptr [2 x i8], [2 x i8]* %t45, i32 0, i32 0
  store i8 47, i8* %t46
  %t47 = getelementptr [2 x i8], [2 x i8]* %t45, i32 0, i32 1
  store i8 0, i8* %t47
  %t48 = getelementptr [2 x i8], [2 x i8]* %t45, i32 0, i32 0
  %t49 = alloca [2 x i8], align 1
  %t50 = getelementptr [2 x i8], [2 x i8]* %t49, i32 0, i32 0
  store i8 46, i8* %t50
  %t51 = getelementptr [2 x i8], [2 x i8]* %t49, i32 0, i32 1
  store i8 0, i8* %t51
  %t52 = getelementptr [2 x i8], [2 x i8]* %t49, i32 0, i32 0
  %t53 = call i8* @replace_all(i8* %t44, i8* %t48, i8* %t52)
  ret i8* %t53
}

define %PythonStructEmission @emit_struct_definitions(%PythonBuilder %builder, { %NativeStruct*, i64 }* %structs) {
block.entry:
  %l0 = alloca %PythonBuilder
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca %PythonStructEmission
  store %PythonBuilder %builder, %PythonBuilder* %l0
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
  store { i8**, i64 }* %t9, { i8**, i64 }** %l1
  %t12 = sitofp i64 0 to double
  store double %t12, double* %l2
  %t13 = load %PythonBuilder, %PythonBuilder* %l0
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t15 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t61 = phi %PythonBuilder [ %t13, %block.entry ], [ %t58, %loop.latch2 ]
  %t62 = phi { i8**, i64 }* [ %t14, %block.entry ], [ %t59, %loop.latch2 ]
  %t63 = phi double [ %t15, %block.entry ], [ %t60, %loop.latch2 ]
  store %PythonBuilder %t61, %PythonBuilder* %l0
  store { i8**, i64 }* %t62, { i8**, i64 }** %l1
  store double %t63, double* %l2
  br label %loop.body1
loop.body1:
  %t16 = load double, double* %l2
  %t17 = load { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* %structs
  %t18 = extractvalue { %NativeStruct*, i64 } %t17, 1
  %t19 = sitofp i64 %t18 to double
  %t20 = fcmp oge double %t16, %t19
  %t21 = load %PythonBuilder, %PythonBuilder* %l0
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t23 = load double, double* %l2
  br i1 %t20, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t24 = load %PythonBuilder, %PythonBuilder* %l0
  %t25 = load double, double* %l2
  %t26 = fptosi double %t25 to i64
  %t27 = load { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* %structs
  %t28 = extractvalue { %NativeStruct*, i64 } %t27, 0
  %t29 = extractvalue { %NativeStruct*, i64 } %t27, 1
  %t30 = icmp uge i64 %t26, %t29
  ; bounds check: %t30 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t26, i64 %t29)
  %t31 = getelementptr %NativeStruct, %NativeStruct* %t28, i64 %t26
  %t32 = load %NativeStruct, %NativeStruct* %t31
  %t33 = call %PythonStructEmission @emit_single_struct(%PythonBuilder %t24, %NativeStruct %t32)
  store %PythonStructEmission %t33, %PythonStructEmission* %l3
  %t34 = load %PythonStructEmission, %PythonStructEmission* %l3
  %t35 = extractvalue %PythonStructEmission %t34, 0
  store %PythonBuilder %t35, %PythonBuilder* %l0
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t37 = load %PythonStructEmission, %PythonStructEmission* %l3
  %t38 = extractvalue %PythonStructEmission %t37, 1
  %t39 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t36, { i8**, i64 }* %t38)
  store { i8**, i64 }* %t39, { i8**, i64 }** %l1
  %t40 = load double, double* %l2
  %t41 = sitofp i64 1 to double
  %t42 = fadd double %t40, %t41
  %t43 = load { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* %structs
  %t44 = extractvalue { %NativeStruct*, i64 } %t43, 1
  %t45 = sitofp i64 %t44 to double
  %t46 = fcmp olt double %t42, %t45
  %t47 = load %PythonBuilder, %PythonBuilder* %l0
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t49 = load double, double* %l2
  %t50 = load %PythonStructEmission, %PythonStructEmission* %l3
  br i1 %t46, label %then6, label %merge7
then6:
  %t51 = load %PythonBuilder, %PythonBuilder* %l0
  %t52 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t51)
  store %PythonBuilder %t52, %PythonBuilder* %l0
  %t53 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge7
merge7:
  %t54 = phi %PythonBuilder [ %t53, %then6 ], [ %t47, %merge5 ]
  store %PythonBuilder %t54, %PythonBuilder* %l0
  %t55 = load double, double* %l2
  %t56 = sitofp i64 1 to double
  %t57 = fadd double %t55, %t56
  store double %t57, double* %l2
  br label %loop.latch2
loop.latch2:
  %t58 = load %PythonBuilder, %PythonBuilder* %l0
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t60 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t64 = load %PythonBuilder, %PythonBuilder* %l0
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t66 = load double, double* %l2
  %t67 = load %PythonBuilder, %PythonBuilder* %l0
  %t68 = insertvalue %PythonStructEmission undef, %PythonBuilder %t67, 0
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t70 = insertvalue %PythonStructEmission %t68, { i8**, i64 }* %t69, 1
  ret %PythonStructEmission %t70
}

define %PythonBuilder @emit_export_list(%PythonBuilder %builder, { i8**, i64 }* %exports) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca i1
  %l4 = alloca double
  %l5 = alloca { i8**, i64 }*
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
  %t12 = sitofp i64 0 to double
  store double %t12, double* %l1
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t90 = phi { i8**, i64 }* [ %t13, %block.entry ], [ %t88, %loop.latch2 ]
  %t91 = phi double [ %t14, %block.entry ], [ %t89, %loop.latch2 ]
  store { i8**, i64 }* %t90, { i8**, i64 }** %l0
  store double %t91, double* %l1
  br label %loop.body1
loop.body1:
  %t15 = load double, double* %l1
  %t16 = load { i8**, i64 }, { i8**, i64 }* %exports
  %t17 = extractvalue { i8**, i64 } %t16, 1
  %t18 = sitofp i64 %t17 to double
  %t19 = fcmp oge double %t15, %t18
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t21 = load double, double* %l1
  br i1 %t19, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t22 = load double, double* %l1
  %t23 = fptosi double %t22 to i64
  %t24 = load { i8**, i64 }, { i8**, i64 }* %exports
  %t25 = extractvalue { i8**, i64 } %t24, 0
  %t26 = extractvalue { i8**, i64 } %t24, 1
  %t27 = icmp uge i64 %t23, %t26
  ; bounds check: %t27 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t23, i64 %t26)
  %t28 = getelementptr i8*, i8** %t25, i64 %t23
  %t29 = load i8*, i8** %t28
  %t30 = call i8* @sanitize_identifier(i8* %t29)
  store i8* %t30, i8** %l2
  store i1 0, i1* %l3
  %t31 = sitofp i64 0 to double
  store double %t31, double* %l4
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t33 = load double, double* %l1
  %t34 = load i8*, i8** %l2
  %t35 = load i1, i1* %l3
  %t36 = load double, double* %l4
  br label %loop.header6
loop.header6:
  %t69 = phi i1 [ %t35, %merge5 ], [ %t67, %loop.latch8 ]
  %t70 = phi double [ %t36, %merge5 ], [ %t68, %loop.latch8 ]
  store i1 %t69, i1* %l3
  store double %t70, double* %l4
  br label %loop.body7
loop.body7:
  %t37 = load double, double* %l4
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t39 = load { i8**, i64 }, { i8**, i64 }* %t38
  %t40 = extractvalue { i8**, i64 } %t39, 1
  %t41 = sitofp i64 %t40 to double
  %t42 = fcmp oge double %t37, %t41
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t44 = load double, double* %l1
  %t45 = load i8*, i8** %l2
  %t46 = load i1, i1* %l3
  %t47 = load double, double* %l4
  br i1 %t42, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t49 = load double, double* %l4
  %t50 = fptosi double %t49 to i64
  %t51 = load { i8**, i64 }, { i8**, i64 }* %t48
  %t52 = extractvalue { i8**, i64 } %t51, 0
  %t53 = extractvalue { i8**, i64 } %t51, 1
  %t54 = icmp uge i64 %t50, %t53
  ; bounds check: %t54 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t50, i64 %t53)
  %t55 = getelementptr i8*, i8** %t52, i64 %t50
  %t56 = load i8*, i8** %t55
  %t57 = load i8*, i8** %l2
  %t58 = icmp eq i8* %t56, %t57
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t60 = load double, double* %l1
  %t61 = load i8*, i8** %l2
  %t62 = load i1, i1* %l3
  %t63 = load double, double* %l4
  br i1 %t58, label %then12, label %merge13
then12:
  store i1 1, i1* %l3
  br label %afterloop9
merge13:
  %t64 = load double, double* %l4
  %t65 = sitofp i64 1 to double
  %t66 = fadd double %t64, %t65
  store double %t66, double* %l4
  br label %loop.latch8
loop.latch8:
  %t67 = load i1, i1* %l3
  %t68 = load double, double* %l4
  br label %loop.header6
afterloop9:
  %t71 = load i1, i1* %l3
  %t72 = load double, double* %l4
  %t73 = load i1, i1* %l3
  %t74 = xor i1 %t73, 1
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t76 = load double, double* %l1
  %t77 = load i8*, i8** %l2
  %t78 = load i1, i1* %l3
  %t79 = load double, double* %l4
  br i1 %t74, label %then14, label %merge15
then14:
  %t80 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t81 = load i8*, i8** %l2
  %t82 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t80, i8* %t81)
  store { i8**, i64 }* %t82, { i8**, i64 }** %l0
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge15
merge15:
  %t84 = phi { i8**, i64 }* [ %t83, %then14 ], [ %t75, %afterloop9 ]
  store { i8**, i64 }* %t84, { i8**, i64 }** %l0
  %t85 = load double, double* %l1
  %t86 = sitofp i64 1 to double
  %t87 = fadd double %t85, %t86
  store double %t87, double* %l1
  br label %loop.latch2
loop.latch2:
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t89 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t93 = load double, double* %l1
  %t94 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t95 = ptrtoint [0 x i8*]* %t94 to i64
  %t96 = icmp eq i64 %t95, 0
  %t97 = select i1 %t96, i64 1, i64 %t95
  %t98 = call i8* @malloc(i64 %t97)
  %t99 = bitcast i8* %t98 to i8**
  %t100 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t101 = ptrtoint { i8**, i64 }* %t100 to i64
  %t102 = call i8* @malloc(i64 %t101)
  %t103 = bitcast i8* %t102 to { i8**, i64 }*
  %t104 = getelementptr { i8**, i64 }, { i8**, i64 }* %t103, i32 0, i32 0
  store i8** %t99, i8*** %t104
  %t105 = getelementptr { i8**, i64 }, { i8**, i64 }* %t103, i32 0, i32 1
  store i64 0, i64* %t105
  store { i8**, i64 }* %t103, { i8**, i64 }** %l5
  %t106 = sitofp i64 0 to double
  store double %t106, double* %l1
  %t107 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t108 = load double, double* %l1
  %t109 = load { i8**, i64 }*, { i8**, i64 }** %l5
  br label %loop.header16
loop.header16:
  %t145 = phi { i8**, i64 }* [ %t109, %afterloop3 ], [ %t143, %loop.latch18 ]
  %t146 = phi double [ %t108, %afterloop3 ], [ %t144, %loop.latch18 ]
  store { i8**, i64 }* %t145, { i8**, i64 }** %l5
  store double %t146, double* %l1
  br label %loop.body17
loop.body17:
  %t110 = load double, double* %l1
  %t111 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t112 = load { i8**, i64 }, { i8**, i64 }* %t111
  %t113 = extractvalue { i8**, i64 } %t112, 1
  %t114 = sitofp i64 %t113 to double
  %t115 = fcmp oge double %t110, %t114
  %t116 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t117 = load double, double* %l1
  %t118 = load { i8**, i64 }*, { i8**, i64 }** %l5
  br i1 %t115, label %then20, label %merge21
then20:
  br label %afterloop19
merge21:
  %t119 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t120 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t121 = load double, double* %l1
  %t122 = fptosi double %t121 to i64
  %t123 = load { i8**, i64 }, { i8**, i64 }* %t120
  %t124 = extractvalue { i8**, i64 } %t123, 0
  %t125 = extractvalue { i8**, i64 } %t123, 1
  %t126 = icmp uge i64 %t122, %t125
  ; bounds check: %t126 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t122, i64 %t125)
  %t127 = getelementptr i8*, i8** %t124, i64 %t122
  %t128 = load i8*, i8** %t127
  %t129 = alloca [2 x i8], align 1
  %t130 = getelementptr [2 x i8], [2 x i8]* %t129, i32 0, i32 0
  store i8 34, i8* %t130
  %t131 = getelementptr [2 x i8], [2 x i8]* %t129, i32 0, i32 1
  store i8 0, i8* %t131
  %t132 = getelementptr [2 x i8], [2 x i8]* %t129, i32 0, i32 0
  %t133 = call i8* @sailfin_runtime_string_concat(i8* %t132, i8* %t128)
  %t134 = alloca [2 x i8], align 1
  %t135 = getelementptr [2 x i8], [2 x i8]* %t134, i32 0, i32 0
  store i8 34, i8* %t135
  %t136 = getelementptr [2 x i8], [2 x i8]* %t134, i32 0, i32 1
  store i8 0, i8* %t136
  %t137 = getelementptr [2 x i8], [2 x i8]* %t134, i32 0, i32 0
  %t138 = call i8* @sailfin_runtime_string_concat(i8* %t133, i8* %t137)
  %t139 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t119, i8* %t138)
  store { i8**, i64 }* %t139, { i8**, i64 }** %l5
  %t140 = load double, double* %l1
  %t141 = sitofp i64 1 to double
  %t142 = fadd double %t140, %t141
  store double %t142, double* %l1
  br label %loop.latch18
loop.latch18:
  %t143 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t144 = load double, double* %l1
  br label %loop.header16
afterloop19:
  %t147 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t148 = load double, double* %l1
  %s149 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1657754115, i32 0, i32 0
  %t150 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %s151 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t152 = call i8* @join_with_separator({ i8**, i64 }* %t150, i8* %s151)
  %t153 = call i8* @sailfin_runtime_string_concat(i8* %s149, i8* %t152)
  %t154 = alloca [2 x i8], align 1
  %t155 = getelementptr [2 x i8], [2 x i8]* %t154, i32 0, i32 0
  store i8 93, i8* %t155
  %t156 = getelementptr [2 x i8], [2 x i8]* %t154, i32 0, i32 1
  store i8 0, i8* %t156
  %t157 = getelementptr [2 x i8], [2 x i8]* %t154, i32 0, i32 0
  %t158 = call i8* @sailfin_runtime_string_concat(i8* %t153, i8* %t157)
  %t159 = call %PythonBuilder @builder_emit(%PythonBuilder %builder, i8* %t158)
  ret %PythonBuilder %t159
}

define { i8**, i64 }* @collect_export_names({ i8**, i64 }* %existing, { %NativeImportSpecifier*, i64 }* %specifiers) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca %NativeImportSpecifier
  %l3 = alloca i8*
  store { i8**, i64 }* %existing, { i8**, i64 }** %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t37 = phi { i8**, i64 }* [ %t1, %block.entry ], [ %t35, %loop.latch2 ]
  %t38 = phi double [ %t2, %block.entry ], [ %t36, %loop.latch2 ]
  store { i8**, i64 }* %t37, { i8**, i64 }** %l0
  store double %t38, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %specifiers
  %t5 = extractvalue { %NativeImportSpecifier*, i64 } %t4, 1
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp oge double %t3, %t6
  %t8 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t9 = load double, double* %l1
  br i1 %t7, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t10 = load double, double* %l1
  %t11 = fptosi double %t10 to i64
  %t12 = load { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %specifiers
  %t13 = extractvalue { %NativeImportSpecifier*, i64 } %t12, 0
  %t14 = extractvalue { %NativeImportSpecifier*, i64 } %t12, 1
  %t15 = icmp uge i64 %t11, %t14
  ; bounds check: %t15 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t11, i64 %t14)
  %t16 = getelementptr %NativeImportSpecifier, %NativeImportSpecifier* %t13, i64 %t11
  %t17 = load %NativeImportSpecifier, %NativeImportSpecifier* %t16
  store %NativeImportSpecifier %t17, %NativeImportSpecifier* %l2
  %t18 = load %NativeImportSpecifier, %NativeImportSpecifier* %l2
  %t19 = call i8* @select_export_name(%NativeImportSpecifier %t18)
  store i8* %t19, i8** %l3
  %t20 = load i8*, i8** %l3
  %t21 = call i64 @sailfin_runtime_string_length(i8* %t20)
  %t22 = icmp sgt i64 %t21, 0
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t24 = load double, double* %l1
  %t25 = load %NativeImportSpecifier, %NativeImportSpecifier* %l2
  %t26 = load i8*, i8** %l3
  br i1 %t22, label %then6, label %merge7
then6:
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t28 = load i8*, i8** %l3
  %t29 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t27, i8* %t28)
  store { i8**, i64 }* %t29, { i8**, i64 }** %l0
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge7
merge7:
  %t31 = phi { i8**, i64 }* [ %t30, %then6 ], [ %t23, %merge5 ]
  store { i8**, i64 }* %t31, { i8**, i64 }** %l0
  %t32 = load double, double* %l1
  %t33 = sitofp i64 1 to double
  %t34 = fadd double %t32, %t33
  store double %t34, double* %l1
  br label %loop.latch2
loop.latch2:
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t36 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t40 = load double, double* %l1
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t41
}

define i8* @select_export_name(%NativeImportSpecifier %specifier) {
block.entry:
  %t1 = extractvalue %NativeImportSpecifier %specifier, 1
  %t2 = icmp ne i8* %t1, null
  br label %logical_and_entry_0

logical_and_entry_0:
  br i1 %t2, label %logical_and_right_0, label %logical_and_merge_0

logical_and_right_0:
  %t3 = extractvalue %NativeImportSpecifier %specifier, 1
  %t4 = call i64 @sailfin_runtime_string_length(i8* %t3)
  %t5 = icmp sgt i64 %t4, 0
  br label %logical_and_right_end_0

logical_and_right_end_0:
  br label %logical_and_merge_0

logical_and_merge_0:
  %t6 = phi i1 [ false, %logical_and_entry_0 ], [ %t5, %logical_and_right_end_0 ]
  br i1 %t6, label %then0, label %merge1
then0:
  %t7 = extractvalue %NativeImportSpecifier %specifier, 1
  ret i8* %t7
merge1:
  %t8 = extractvalue %NativeImportSpecifier %specifier, 0
  ret i8* %t8
}

define %PythonStructEmission @emit_single_struct(%PythonBuilder %builder, %NativeStruct %definition) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca %PythonBuilder
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca { i8**, i64 }*
  %l4 = alloca i8*
  %l5 = alloca double
  %l6 = alloca %NativeStructField*
  %l7 = alloca i8*
  %l8 = alloca i8*
  %l9 = alloca double
  %l10 = alloca %NativeFunction*
  %l11 = alloca %PythonFunctionEmission
  %t0 = extractvalue %NativeStruct %definition, 0
  %t1 = call i8* @sanitize_identifier(i8* %t0)
  store i8* %t1, i8** %l0
  %s2 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1267738404, i32 0, i32 0
  %t3 = load i8*, i8** %l0
  %t4 = call i8* @sailfin_runtime_string_concat(i8* %s2, i8* %t3)
  %t5 = alloca [2 x i8], align 1
  %t6 = getelementptr [2 x i8], [2 x i8]* %t5, i32 0, i32 0
  store i8 58, i8* %t6
  %t7 = getelementptr [2 x i8], [2 x i8]* %t5, i32 0, i32 1
  store i8 0, i8* %t7
  %t8 = getelementptr [2 x i8], [2 x i8]* %t5, i32 0, i32 0
  %t9 = call i8* @sailfin_runtime_string_concat(i8* %t4, i8* %t8)
  %t10 = call %PythonBuilder @builder_emit(%PythonBuilder %builder, i8* %t9)
  store %PythonBuilder %t10, %PythonBuilder* %l1
  %t11 = load %PythonBuilder, %PythonBuilder* %l1
  %t12 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t11)
  store %PythonBuilder %t12, %PythonBuilder* %l1
  %t13 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t14 = ptrtoint [0 x i8*]* %t13 to i64
  %t15 = icmp eq i64 %t14, 0
  %t16 = select i1 %t15, i64 1, i64 %t14
  %t17 = call i8* @malloc(i64 %t16)
  %t18 = bitcast i8* %t17 to i8**
  %t19 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t20 = ptrtoint { i8**, i64 }* %t19 to i64
  %t21 = call i8* @malloc(i64 %t20)
  %t22 = bitcast i8* %t21 to { i8**, i64 }*
  %t23 = getelementptr { i8**, i64 }, { i8**, i64 }* %t22, i32 0, i32 0
  store i8** %t18, i8*** %t23
  %t24 = getelementptr { i8**, i64 }, { i8**, i64 }* %t22, i32 0, i32 1
  store i64 0, i64* %t24
  store { i8**, i64 }* %t22, { i8**, i64 }** %l2
  %t25 = extractvalue %NativeStruct %definition, 1
  %t26 = bitcast { %NativeStructField**, i64 }* %t25 to { %NativeStructField*, i64 }*
  %t27 = call { i8**, i64 }* @render_struct_parameters({ %NativeStructField*, i64 }* %t26)
  store { i8**, i64 }* %t27, { i8**, i64 }** %l3
  %s28 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h215787497, i32 0, i32 0
  store i8* %s28, i8** %l4
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t30 = load { i8**, i64 }, { i8**, i64 }* %t29
  %t31 = extractvalue { i8**, i64 } %t30, 1
  %t32 = icmp sgt i64 %t31, 0
  %t33 = load i8*, i8** %l0
  %t34 = load %PythonBuilder, %PythonBuilder* %l1
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t37 = load i8*, i8** %l4
  br i1 %t32, label %then0, label %merge1
then0:
  %t38 = load i8*, i8** %l4
  %s39 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t40 = call i8* @sailfin_runtime_string_concat(i8* %t38, i8* %s39)
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %s42 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t43 = call i8* @join_with_separator({ i8**, i64 }* %t41, i8* %s42)
  %t44 = call i8* @sailfin_runtime_string_concat(i8* %t40, i8* %t43)
  store i8* %t44, i8** %l4
  %t45 = load i8*, i8** %l4
  br label %merge1
merge1:
  %t46 = phi i8* [ %t45, %then0 ], [ %t37, %block.entry ]
  store i8* %t46, i8** %l4
  %t47 = load i8*, i8** %l4
  %t48 = alloca [2 x i8], align 1
  %t49 = getelementptr [2 x i8], [2 x i8]* %t48, i32 0, i32 0
  store i8 41, i8* %t49
  %t50 = getelementptr [2 x i8], [2 x i8]* %t48, i32 0, i32 1
  store i8 0, i8* %t50
  %t51 = getelementptr [2 x i8], [2 x i8]* %t48, i32 0, i32 0
  %t52 = call i8* @sailfin_runtime_string_concat(i8* %t47, i8* %t51)
  store i8* %t52, i8** %l4
  %t53 = load %PythonBuilder, %PythonBuilder* %l1
  %t54 = load i8*, i8** %l4
  %t55 = alloca [2 x i8], align 1
  %t56 = getelementptr [2 x i8], [2 x i8]* %t55, i32 0, i32 0
  store i8 58, i8* %t56
  %t57 = getelementptr [2 x i8], [2 x i8]* %t55, i32 0, i32 1
  store i8 0, i8* %t57
  %t58 = getelementptr [2 x i8], [2 x i8]* %t55, i32 0, i32 0
  %t59 = call i8* @sailfin_runtime_string_concat(i8* %t54, i8* %t58)
  %t60 = call %PythonBuilder @builder_emit(%PythonBuilder %t53, i8* %t59)
  store %PythonBuilder %t60, %PythonBuilder* %l1
  %t61 = load %PythonBuilder, %PythonBuilder* %l1
  %t62 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t61)
  store %PythonBuilder %t62, %PythonBuilder* %l1
  %t63 = extractvalue %NativeStruct %definition, 1
  %t64 = load { %NativeStructField**, i64 }, { %NativeStructField**, i64 }* %t63
  %t65 = extractvalue { %NativeStructField**, i64 } %t64, 1
  %t66 = icmp eq i64 %t65, 0
  %t67 = load i8*, i8** %l0
  %t68 = load %PythonBuilder, %PythonBuilder* %l1
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t71 = load i8*, i8** %l4
  br i1 %t66, label %then2, label %else3
then2:
  %t72 = load %PythonBuilder, %PythonBuilder* %l1
  %s73 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h270590402, i32 0, i32 0
  %t74 = call %PythonBuilder @builder_emit(%PythonBuilder %t72, i8* %s73)
  store %PythonBuilder %t74, %PythonBuilder* %l1
  %t75 = load %PythonBuilder, %PythonBuilder* %l1
  br label %merge4
else3:
  %t76 = sitofp i64 0 to double
  store double %t76, double* %l5
  %t77 = load i8*, i8** %l0
  %t78 = load %PythonBuilder, %PythonBuilder* %l1
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t80 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t81 = load i8*, i8** %l4
  %t82 = load double, double* %l5
  br label %loop.header5
loop.header5:
  %t122 = phi %PythonBuilder [ %t78, %else3 ], [ %t120, %loop.latch7 ]
  %t123 = phi double [ %t82, %else3 ], [ %t121, %loop.latch7 ]
  store %PythonBuilder %t122, %PythonBuilder* %l1
  store double %t123, double* %l5
  br label %loop.body6
loop.body6:
  %t83 = load double, double* %l5
  %t84 = extractvalue %NativeStruct %definition, 1
  %t85 = load { %NativeStructField**, i64 }, { %NativeStructField**, i64 }* %t84
  %t86 = extractvalue { %NativeStructField**, i64 } %t85, 1
  %t87 = sitofp i64 %t86 to double
  %t88 = fcmp oge double %t83, %t87
  %t89 = load i8*, i8** %l0
  %t90 = load %PythonBuilder, %PythonBuilder* %l1
  %t91 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t93 = load i8*, i8** %l4
  %t94 = load double, double* %l5
  br i1 %t88, label %then9, label %merge10
then9:
  br label %afterloop8
merge10:
  %t95 = extractvalue %NativeStruct %definition, 1
  %t96 = load double, double* %l5
  %t97 = fptosi double %t96 to i64
  %t98 = load { %NativeStructField**, i64 }, { %NativeStructField**, i64 }* %t95
  %t99 = extractvalue { %NativeStructField**, i64 } %t98, 0
  %t100 = extractvalue { %NativeStructField**, i64 } %t98, 1
  %t101 = icmp uge i64 %t97, %t100
  ; bounds check: %t101 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t97, i64 %t100)
  %t102 = getelementptr %NativeStructField*, %NativeStructField** %t99, i64 %t97
  %t103 = load %NativeStructField*, %NativeStructField** %t102
  store %NativeStructField* %t103, %NativeStructField** %l6
  %t104 = load %NativeStructField*, %NativeStructField** %l6
  %t105 = getelementptr %NativeStructField, %NativeStructField* %t104, i32 0, i32 0
  %t106 = load i8*, i8** %t105
  %t107 = call i8* @sanitize_identifier(i8* %t106)
  store i8* %t107, i8** %l7
  %t108 = load %PythonBuilder, %PythonBuilder* %l1
  %s109 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h461434216, i32 0, i32 0
  %t110 = load i8*, i8** %l7
  %t111 = call i8* @sailfin_runtime_string_concat(i8* %s109, i8* %t110)
  %s112 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087691079, i32 0, i32 0
  %t113 = call i8* @sailfin_runtime_string_concat(i8* %t111, i8* %s112)
  %t114 = load i8*, i8** %l7
  %t115 = call i8* @sailfin_runtime_string_concat(i8* %t113, i8* %t114)
  %t116 = call %PythonBuilder @builder_emit(%PythonBuilder %t108, i8* %t115)
  store %PythonBuilder %t116, %PythonBuilder* %l1
  %t117 = load double, double* %l5
  %t118 = sitofp i64 1 to double
  %t119 = fadd double %t117, %t118
  store double %t119, double* %l5
  br label %loop.latch7
loop.latch7:
  %t120 = load %PythonBuilder, %PythonBuilder* %l1
  %t121 = load double, double* %l5
  br label %loop.header5
afterloop8:
  %t124 = load %PythonBuilder, %PythonBuilder* %l1
  %t125 = load double, double* %l5
  %t126 = load %PythonBuilder, %PythonBuilder* %l1
  br label %merge4
merge4:
  %t127 = phi %PythonBuilder [ %t75, %then2 ], [ %t126, %afterloop8 ]
  store %PythonBuilder %t127, %PythonBuilder* %l1
  %t128 = load %PythonBuilder, %PythonBuilder* %l1
  %t129 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t128)
  store %PythonBuilder %t129, %PythonBuilder* %l1
  %t130 = load %PythonBuilder, %PythonBuilder* %l1
  %t131 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t130)
  store %PythonBuilder %t131, %PythonBuilder* %l1
  %t132 = load %PythonBuilder, %PythonBuilder* %l1
  %s133 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h1806641125, i32 0, i32 0
  %t134 = call %PythonBuilder @builder_emit(%PythonBuilder %t132, i8* %s133)
  store %PythonBuilder %t134, %PythonBuilder* %l1
  %t135 = load %PythonBuilder, %PythonBuilder* %l1
  %t136 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t135)
  store %PythonBuilder %t136, %PythonBuilder* %l1
  %t137 = load i8*, i8** %l0
  %t138 = extractvalue %NativeStruct %definition, 1
  %t139 = bitcast { %NativeStructField**, i64 }* %t138 to { %NativeStructField*, i64 }*
  %t140 = call i8* @render_struct_repr_fields(i8* %t137, { %NativeStructField*, i64 }* %t139)
  store i8* %t140, i8** %l8
  %t141 = load %PythonBuilder, %PythonBuilder* %l1
  %t142 = load i8*, i8** %l8
  %t143 = call %PythonBuilder @builder_emit(%PythonBuilder %t141, i8* %t142)
  store %PythonBuilder %t143, %PythonBuilder* %l1
  %t144 = load %PythonBuilder, %PythonBuilder* %l1
  %t145 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t144)
  store %PythonBuilder %t145, %PythonBuilder* %l1
  %t146 = load i8*, i8** %l0
  %s147 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h300877395, i32 0, i32 0
  %t148 = icmp eq i8* %t146, %s147
  %t149 = load i8*, i8** %l0
  %t150 = load %PythonBuilder, %PythonBuilder* %l1
  %t151 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t152 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t153 = load i8*, i8** %l4
  %t154 = load i8*, i8** %l8
  br i1 %t148, label %then11, label %merge12
then11:
  %t155 = load %PythonBuilder, %PythonBuilder* %l1
  %t156 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t155)
  store %PythonBuilder %t156, %PythonBuilder* %l1
  %t157 = load %PythonBuilder, %PythonBuilder* %l1
  %s158 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.len28.h430828782, i32 0, i32 0
  %t159 = call %PythonBuilder @builder_emit(%PythonBuilder %t157, i8* %s158)
  store %PythonBuilder %t159, %PythonBuilder* %l1
  %t160 = load %PythonBuilder, %PythonBuilder* %l1
  %t161 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t160)
  store %PythonBuilder %t161, %PythonBuilder* %l1
  %t162 = load %PythonBuilder, %PythonBuilder* %l1
  %s163 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h320851598, i32 0, i32 0
  %t164 = call %PythonBuilder @builder_emit(%PythonBuilder %t162, i8* %s163)
  store %PythonBuilder %t164, %PythonBuilder* %l1
  %t165 = load %PythonBuilder, %PythonBuilder* %l1
  %s166 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1898426375, i32 0, i32 0
  %t167 = call %PythonBuilder @builder_emit(%PythonBuilder %t165, i8* %s166)
  store %PythonBuilder %t167, %PythonBuilder* %l1
  %t168 = load %PythonBuilder, %PythonBuilder* %l1
  %t169 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t168)
  store %PythonBuilder %t169, %PythonBuilder* %l1
  %t170 = load %PythonBuilder, %PythonBuilder* %l1
  %s171 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.len29.h610920064, i32 0, i32 0
  %t172 = call %PythonBuilder @builder_emit(%PythonBuilder %t170, i8* %s171)
  store %PythonBuilder %t172, %PythonBuilder* %l1
  %t173 = load %PythonBuilder, %PythonBuilder* %l1
  %t174 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t173)
  store %PythonBuilder %t174, %PythonBuilder* %l1
  %t175 = load %PythonBuilder, %PythonBuilder* %l1
  %s176 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1958778164, i32 0, i32 0
  %t177 = call %PythonBuilder @builder_emit(%PythonBuilder %t175, i8* %s176)
  store %PythonBuilder %t177, %PythonBuilder* %l1
  %t178 = load %PythonBuilder, %PythonBuilder* %l1
  %t179 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t178)
  store %PythonBuilder %t179, %PythonBuilder* %l1
  %t180 = load %PythonBuilder, %PythonBuilder* %l1
  %s181 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.len26.h1088202076, i32 0, i32 0
  %t182 = call %PythonBuilder @builder_emit(%PythonBuilder %t180, i8* %s181)
  store %PythonBuilder %t182, %PythonBuilder* %l1
  %t183 = load %PythonBuilder, %PythonBuilder* %l1
  %s184 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h983476432, i32 0, i32 0
  %t185 = call %PythonBuilder @builder_emit(%PythonBuilder %t183, i8* %s184)
  store %PythonBuilder %t185, %PythonBuilder* %l1
  %t186 = load %PythonBuilder, %PythonBuilder* %l1
  %t187 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t186)
  store %PythonBuilder %t187, %PythonBuilder* %l1
  %t188 = load %PythonBuilder, %PythonBuilder* %l1
  %s189 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.len18.h1456282769, i32 0, i32 0
  %t190 = call %PythonBuilder @builder_emit(%PythonBuilder %t188, i8* %s189)
  store %PythonBuilder %t190, %PythonBuilder* %l1
  %t191 = load %PythonBuilder, %PythonBuilder* %l1
  %t192 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t191)
  store %PythonBuilder %t192, %PythonBuilder* %l1
  %t193 = load %PythonBuilder, %PythonBuilder* %l1
  %s194 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h1977847647, i32 0, i32 0
  %t195 = call %PythonBuilder @builder_emit(%PythonBuilder %t193, i8* %s194)
  store %PythonBuilder %t195, %PythonBuilder* %l1
  %t196 = load %PythonBuilder, %PythonBuilder* %l1
  %t197 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t196)
  store %PythonBuilder %t197, %PythonBuilder* %l1
  %t198 = load %PythonBuilder, %PythonBuilder* %l1
  %s199 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.len26.h1984174475, i32 0, i32 0
  %t200 = call %PythonBuilder @builder_emit(%PythonBuilder %t198, i8* %s199)
  store %PythonBuilder %t200, %PythonBuilder* %l1
  %t201 = load %PythonBuilder, %PythonBuilder* %l1
  %t202 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t201)
  store %PythonBuilder %t202, %PythonBuilder* %l1
  %t203 = load %PythonBuilder, %PythonBuilder* %l1
  %t204 = load %PythonBuilder, %PythonBuilder* %l1
  %t205 = load %PythonBuilder, %PythonBuilder* %l1
  %t206 = load %PythonBuilder, %PythonBuilder* %l1
  %t207 = load %PythonBuilder, %PythonBuilder* %l1
  %t208 = load %PythonBuilder, %PythonBuilder* %l1
  %t209 = load %PythonBuilder, %PythonBuilder* %l1
  %t210 = load %PythonBuilder, %PythonBuilder* %l1
  %t211 = load %PythonBuilder, %PythonBuilder* %l1
  %t212 = load %PythonBuilder, %PythonBuilder* %l1
  %t213 = load %PythonBuilder, %PythonBuilder* %l1
  %t214 = load %PythonBuilder, %PythonBuilder* %l1
  %t215 = load %PythonBuilder, %PythonBuilder* %l1
  %t216 = load %PythonBuilder, %PythonBuilder* %l1
  %t217 = load %PythonBuilder, %PythonBuilder* %l1
  %t218 = load %PythonBuilder, %PythonBuilder* %l1
  %t219 = load %PythonBuilder, %PythonBuilder* %l1
  %t220 = load %PythonBuilder, %PythonBuilder* %l1
  %t221 = load %PythonBuilder, %PythonBuilder* %l1
  br label %merge12
merge12:
  %t222 = phi %PythonBuilder [ %t203, %then11 ], [ %t150, %merge4 ]
  %t223 = phi %PythonBuilder [ %t204, %then11 ], [ %t150, %merge4 ]
  %t224 = phi %PythonBuilder [ %t205, %then11 ], [ %t150, %merge4 ]
  %t225 = phi %PythonBuilder [ %t206, %then11 ], [ %t150, %merge4 ]
  %t226 = phi %PythonBuilder [ %t207, %then11 ], [ %t150, %merge4 ]
  %t227 = phi %PythonBuilder [ %t208, %then11 ], [ %t150, %merge4 ]
  %t228 = phi %PythonBuilder [ %t209, %then11 ], [ %t150, %merge4 ]
  %t229 = phi %PythonBuilder [ %t210, %then11 ], [ %t150, %merge4 ]
  %t230 = phi %PythonBuilder [ %t211, %then11 ], [ %t150, %merge4 ]
  %t231 = phi %PythonBuilder [ %t212, %then11 ], [ %t150, %merge4 ]
  %t232 = phi %PythonBuilder [ %t213, %then11 ], [ %t150, %merge4 ]
  %t233 = phi %PythonBuilder [ %t214, %then11 ], [ %t150, %merge4 ]
  %t234 = phi %PythonBuilder [ %t215, %then11 ], [ %t150, %merge4 ]
  %t235 = phi %PythonBuilder [ %t216, %then11 ], [ %t150, %merge4 ]
  %t236 = phi %PythonBuilder [ %t217, %then11 ], [ %t150, %merge4 ]
  %t237 = phi %PythonBuilder [ %t218, %then11 ], [ %t150, %merge4 ]
  %t238 = phi %PythonBuilder [ %t219, %then11 ], [ %t150, %merge4 ]
  %t239 = phi %PythonBuilder [ %t220, %then11 ], [ %t150, %merge4 ]
  %t240 = phi %PythonBuilder [ %t221, %then11 ], [ %t150, %merge4 ]
  store %PythonBuilder %t222, %PythonBuilder* %l1
  store %PythonBuilder %t223, %PythonBuilder* %l1
  store %PythonBuilder %t224, %PythonBuilder* %l1
  store %PythonBuilder %t225, %PythonBuilder* %l1
  store %PythonBuilder %t226, %PythonBuilder* %l1
  store %PythonBuilder %t227, %PythonBuilder* %l1
  store %PythonBuilder %t228, %PythonBuilder* %l1
  store %PythonBuilder %t229, %PythonBuilder* %l1
  store %PythonBuilder %t230, %PythonBuilder* %l1
  store %PythonBuilder %t231, %PythonBuilder* %l1
  store %PythonBuilder %t232, %PythonBuilder* %l1
  store %PythonBuilder %t233, %PythonBuilder* %l1
  store %PythonBuilder %t234, %PythonBuilder* %l1
  store %PythonBuilder %t235, %PythonBuilder* %l1
  store %PythonBuilder %t236, %PythonBuilder* %l1
  store %PythonBuilder %t237, %PythonBuilder* %l1
  store %PythonBuilder %t238, %PythonBuilder* %l1
  store %PythonBuilder %t239, %PythonBuilder* %l1
  store %PythonBuilder %t240, %PythonBuilder* %l1
  %t241 = extractvalue %NativeStruct %definition, 2
  %t242 = load { %NativeFunction**, i64 }, { %NativeFunction**, i64 }* %t241
  %t243 = extractvalue { %NativeFunction**, i64 } %t242, 1
  %t244 = icmp sgt i64 %t243, 0
  %t245 = load i8*, i8** %l0
  %t246 = load %PythonBuilder, %PythonBuilder* %l1
  %t247 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t248 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t249 = load i8*, i8** %l4
  %t250 = load i8*, i8** %l8
  br i1 %t244, label %then13, label %merge14
then13:
  %t251 = load %PythonBuilder, %PythonBuilder* %l1
  %t252 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t251)
  store %PythonBuilder %t252, %PythonBuilder* %l1
  %t253 = sitofp i64 0 to double
  store double %t253, double* %l9
  %t254 = load i8*, i8** %l0
  %t255 = load %PythonBuilder, %PythonBuilder* %l1
  %t256 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t257 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t258 = load i8*, i8** %l4
  %t259 = load i8*, i8** %l8
  %t260 = load double, double* %l9
  br label %loop.header15
loop.header15:
  %t320 = phi %PythonBuilder [ %t255, %then13 ], [ %t317, %loop.latch17 ]
  %t321 = phi { i8**, i64 }* [ %t256, %then13 ], [ %t318, %loop.latch17 ]
  %t322 = phi double [ %t260, %then13 ], [ %t319, %loop.latch17 ]
  store %PythonBuilder %t320, %PythonBuilder* %l1
  store { i8**, i64 }* %t321, { i8**, i64 }** %l2
  store double %t322, double* %l9
  br label %loop.body16
loop.body16:
  %t261 = load double, double* %l9
  %t262 = extractvalue %NativeStruct %definition, 2
  %t263 = load { %NativeFunction**, i64 }, { %NativeFunction**, i64 }* %t262
  %t264 = extractvalue { %NativeFunction**, i64 } %t263, 1
  %t265 = sitofp i64 %t264 to double
  %t266 = fcmp oge double %t261, %t265
  %t267 = load i8*, i8** %l0
  %t268 = load %PythonBuilder, %PythonBuilder* %l1
  %t269 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t270 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t271 = load i8*, i8** %l4
  %t272 = load i8*, i8** %l8
  %t273 = load double, double* %l9
  br i1 %t266, label %then19, label %merge20
then19:
  br label %afterloop18
merge20:
  %t274 = extractvalue %NativeStruct %definition, 2
  %t275 = load double, double* %l9
  %t276 = fptosi double %t275 to i64
  %t277 = load { %NativeFunction**, i64 }, { %NativeFunction**, i64 }* %t274
  %t278 = extractvalue { %NativeFunction**, i64 } %t277, 0
  %t279 = extractvalue { %NativeFunction**, i64 } %t277, 1
  %t280 = icmp uge i64 %t276, %t279
  ; bounds check: %t280 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t276, i64 %t279)
  %t281 = getelementptr %NativeFunction*, %NativeFunction** %t278, i64 %t276
  %t282 = load %NativeFunction*, %NativeFunction** %t281
  store %NativeFunction* %t282, %NativeFunction** %l10
  %t283 = load %PythonBuilder, %PythonBuilder* %l1
  %t284 = load %NativeFunction*, %NativeFunction** %l10
  %t285 = load %NativeFunction, %NativeFunction* %t284
  %t286 = call %PythonFunctionEmission @emit_python_function(%PythonBuilder %t283, %NativeFunction %t285)
  store %PythonFunctionEmission %t286, %PythonFunctionEmission* %l11
  %t287 = load %PythonFunctionEmission, %PythonFunctionEmission* %l11
  %t288 = extractvalue %PythonFunctionEmission %t287, 0
  store %PythonBuilder %t288, %PythonBuilder* %l1
  %t289 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t290 = load %PythonFunctionEmission, %PythonFunctionEmission* %l11
  %t291 = extractvalue %PythonFunctionEmission %t290, 1
  %t292 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t289, { i8**, i64 }* %t291)
  store { i8**, i64 }* %t292, { i8**, i64 }** %l2
  %t293 = load double, double* %l9
  %t294 = sitofp i64 1 to double
  %t295 = fadd double %t293, %t294
  %t296 = extractvalue %NativeStruct %definition, 2
  %t297 = load { %NativeFunction**, i64 }, { %NativeFunction**, i64 }* %t296
  %t298 = extractvalue { %NativeFunction**, i64 } %t297, 1
  %t299 = sitofp i64 %t298 to double
  %t300 = fcmp olt double %t295, %t299
  %t301 = load i8*, i8** %l0
  %t302 = load %PythonBuilder, %PythonBuilder* %l1
  %t303 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t304 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t305 = load i8*, i8** %l4
  %t306 = load i8*, i8** %l8
  %t307 = load double, double* %l9
  %t308 = load %NativeFunction*, %NativeFunction** %l10
  %t309 = load %PythonFunctionEmission, %PythonFunctionEmission* %l11
  br i1 %t300, label %then21, label %merge22
then21:
  %t310 = load %PythonBuilder, %PythonBuilder* %l1
  %t311 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t310)
  store %PythonBuilder %t311, %PythonBuilder* %l1
  %t312 = load %PythonBuilder, %PythonBuilder* %l1
  br label %merge22
merge22:
  %t313 = phi %PythonBuilder [ %t312, %then21 ], [ %t302, %merge20 ]
  store %PythonBuilder %t313, %PythonBuilder* %l1
  %t314 = load double, double* %l9
  %t315 = sitofp i64 1 to double
  %t316 = fadd double %t314, %t315
  store double %t316, double* %l9
  br label %loop.latch17
loop.latch17:
  %t317 = load %PythonBuilder, %PythonBuilder* %l1
  %t318 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t319 = load double, double* %l9
  br label %loop.header15
afterloop18:
  %t323 = load %PythonBuilder, %PythonBuilder* %l1
  %t324 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t325 = load double, double* %l9
  %t326 = load %PythonBuilder, %PythonBuilder* %l1
  %t327 = load %PythonBuilder, %PythonBuilder* %l1
  %t328 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br label %merge14
merge14:
  %t329 = phi %PythonBuilder [ %t326, %afterloop18 ], [ %t246, %merge12 ]
  %t330 = phi %PythonBuilder [ %t327, %afterloop18 ], [ %t246, %merge12 ]
  %t331 = phi { i8**, i64 }* [ %t328, %afterloop18 ], [ %t247, %merge12 ]
  store %PythonBuilder %t329, %PythonBuilder* %l1
  store %PythonBuilder %t330, %PythonBuilder* %l1
  store { i8**, i64 }* %t331, { i8**, i64 }** %l2
  %t332 = load %PythonBuilder, %PythonBuilder* %l1
  %t333 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t332)
  store %PythonBuilder %t333, %PythonBuilder* %l1
  %t334 = load %PythonBuilder, %PythonBuilder* %l1
  %t335 = insertvalue %PythonStructEmission undef, %PythonBuilder %t334, 0
  %t336 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t337 = insertvalue %PythonStructEmission %t335, { i8**, i64 }* %t336, 1
  ret %PythonStructEmission %t337
}

define { i8**, i64 }* @render_struct_parameters({ %NativeStructField*, i64 }* %fields) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca %NativeStructField
  %l4 = alloca i8*
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
  %t12 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t13 = ptrtoint [0 x i8*]* %t12 to i64
  %t14 = icmp eq i64 %t13, 0
  %t15 = select i1 %t14, i64 1, i64 %t13
  %t16 = call i8* @malloc(i64 %t15)
  %t17 = bitcast i8* %t16 to i8**
  %t18 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t19 = ptrtoint { i8**, i64 }* %t18 to i64
  %t20 = call i8* @malloc(i64 %t19)
  %t21 = bitcast i8* %t20 to { i8**, i64 }*
  %t22 = getelementptr { i8**, i64 }, { i8**, i64 }* %t21, i32 0, i32 0
  store i8** %t17, i8*** %t22
  %t23 = getelementptr { i8**, i64 }, { i8**, i64 }* %t21, i32 0, i32 1
  store i64 0, i64* %t23
  store { i8**, i64 }* %t21, { i8**, i64 }** %l1
  %t24 = sitofp i64 0 to double
  store double %t24, double* %l2
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t27 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t78 = phi { i8**, i64 }* [ %t26, %block.entry ], [ %t75, %loop.latch2 ]
  %t79 = phi { i8**, i64 }* [ %t25, %block.entry ], [ %t76, %loop.latch2 ]
  %t80 = phi double [ %t27, %block.entry ], [ %t77, %loop.latch2 ]
  store { i8**, i64 }* %t78, { i8**, i64 }** %l1
  store { i8**, i64 }* %t79, { i8**, i64 }** %l0
  store double %t80, double* %l2
  br label %loop.body1
loop.body1:
  %t28 = load double, double* %l2
  %t29 = load { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %fields
  %t30 = extractvalue { %NativeStructField*, i64 } %t29, 1
  %t31 = sitofp i64 %t30 to double
  %t32 = fcmp oge double %t28, %t31
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t35 = load double, double* %l2
  br i1 %t32, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t36 = load double, double* %l2
  %t37 = fptosi double %t36 to i64
  %t38 = load { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %fields
  %t39 = extractvalue { %NativeStructField*, i64 } %t38, 0
  %t40 = extractvalue { %NativeStructField*, i64 } %t38, 1
  %t41 = icmp uge i64 %t37, %t40
  ; bounds check: %t41 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t37, i64 %t40)
  %t42 = getelementptr %NativeStructField, %NativeStructField* %t39, i64 %t37
  %t43 = load %NativeStructField, %NativeStructField* %t42
  store %NativeStructField %t43, %NativeStructField* %l3
  %t44 = load %NativeStructField, %NativeStructField* %l3
  %t45 = extractvalue %NativeStructField %t44, 0
  %t46 = call i8* @sanitize_identifier(i8* %t45)
  store i8* %t46, i8** %l4
  %t47 = load i8*, i8** %l4
  store i8* %t47, i8** %l5
  %t48 = load %NativeStructField, %NativeStructField* %l3
  %t49 = extractvalue %NativeStructField %t48, 1
  %t50 = call i1 @is_optional_type(i8* %t49)
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t53 = load double, double* %l2
  %t54 = load %NativeStructField, %NativeStructField* %l3
  %t55 = load i8*, i8** %l4
  %t56 = load i8*, i8** %l5
  br i1 %t50, label %then6, label %else7
then6:
  %t57 = load i8*, i8** %l5
  %s58 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h468448796, i32 0, i32 0
  %t59 = call i8* @sailfin_runtime_string_concat(i8* %t57, i8* %s58)
  store i8* %t59, i8** %l5
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t61 = load i8*, i8** %l5
  %t62 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t60, i8* %t61)
  store { i8**, i64 }* %t62, { i8**, i64 }** %l1
  %t63 = load i8*, i8** %l5
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge8
else7:
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t66 = load i8*, i8** %l5
  %t67 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t65, i8* %t66)
  store { i8**, i64 }* %t67, { i8**, i64 }** %l0
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge8
merge8:
  %t69 = phi i8* [ %t63, %then6 ], [ %t56, %else7 ]
  %t70 = phi { i8**, i64 }* [ %t64, %then6 ], [ %t52, %else7 ]
  %t71 = phi { i8**, i64 }* [ %t51, %then6 ], [ %t68, %else7 ]
  store i8* %t69, i8** %l5
  store { i8**, i64 }* %t70, { i8**, i64 }** %l1
  store { i8**, i64 }* %t71, { i8**, i64 }** %l0
  %t72 = load double, double* %l2
  %t73 = sitofp i64 1 to double
  %t74 = fadd double %t72, %t73
  store double %t74, double* %l2
  br label %loop.latch2
loop.latch2:
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t77 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t82 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t83 = load double, double* %l2
  %t84 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t86 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t84, { i8**, i64 }* %t85)
  ret { i8**, i64 }* %t86
}

define i8* @render_struct_repr_fields(i8* %class_name, { %NativeStructField*, i64 }* %fields) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca %NativeStructField
  %l3 = alloca i8*
  %t0 = load { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %fields
  %t1 = extractvalue { %NativeStructField*, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  %s3 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.len28.h1179318158, i32 0, i32 0
  %t4 = call i8* @sailfin_runtime_string_concat(i8* %s3, i8* %class_name)
  %s5 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h653919037, i32 0, i32 0
  %t6 = call i8* @sailfin_runtime_string_concat(i8* %t4, i8* %s5)
  ret i8* %t6
merge1:
  %t7 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t8 = ptrtoint [0 x i8*]* %t7 to i64
  %t9 = icmp eq i64 %t8, 0
  %t10 = select i1 %t9, i64 1, i64 %t8
  %t11 = call i8* @malloc(i64 %t10)
  %t12 = bitcast i8* %t11 to i8**
  %t13 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t14 = ptrtoint { i8**, i64 }* %t13 to i64
  %t15 = call i8* @malloc(i64 %t14)
  %t16 = bitcast i8* %t15 to { i8**, i64 }*
  %t17 = getelementptr { i8**, i64 }, { i8**, i64 }* %t16, i32 0, i32 0
  store i8** %t12, i8*** %t17
  %t18 = getelementptr { i8**, i64 }, { i8**, i64 }* %t16, i32 0, i32 1
  store i64 0, i64* %t18
  store { i8**, i64 }* %t16, { i8**, i64 }** %l0
  %t19 = sitofp i64 0 to double
  store double %t19, double* %l1
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t21 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t59 = phi { i8**, i64 }* [ %t20, %merge1 ], [ %t57, %loop.latch4 ]
  %t60 = phi double [ %t21, %merge1 ], [ %t58, %loop.latch4 ]
  store { i8**, i64 }* %t59, { i8**, i64 }** %l0
  store double %t60, double* %l1
  br label %loop.body3
loop.body3:
  %t22 = load double, double* %l1
  %t23 = load { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %fields
  %t24 = extractvalue { %NativeStructField*, i64 } %t23, 1
  %t25 = sitofp i64 %t24 to double
  %t26 = fcmp oge double %t22, %t25
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t28 = load double, double* %l1
  br i1 %t26, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t29 = load double, double* %l1
  %t30 = fptosi double %t29 to i64
  %t31 = load { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %fields
  %t32 = extractvalue { %NativeStructField*, i64 } %t31, 0
  %t33 = extractvalue { %NativeStructField*, i64 } %t31, 1
  %t34 = icmp uge i64 %t30, %t33
  ; bounds check: %t34 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t30, i64 %t33)
  %t35 = getelementptr %NativeStructField, %NativeStructField* %t32, i64 %t30
  %t36 = load %NativeStructField, %NativeStructField* %t35
  store %NativeStructField %t36, %NativeStructField* %l2
  %t37 = load %NativeStructField, %NativeStructField* %l2
  %t38 = extractvalue %NativeStructField %t37, 0
  %t39 = call i8* @sanitize_identifier(i8* %t38)
  store i8* %t39, i8** %l3
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s41 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h1038501153, i32 0, i32 0
  %t42 = load i8*, i8** %l3
  %t43 = call i8* @sailfin_runtime_string_concat(i8* %s41, i8* %t42)
  %s44 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h104511138, i32 0, i32 0
  %t45 = call i8* @sailfin_runtime_string_concat(i8* %t43, i8* %s44)
  %t46 = load i8*, i8** %l3
  %t47 = call i8* @sailfin_runtime_string_concat(i8* %t45, i8* %t46)
  %t48 = alloca [2 x i8], align 1
  %t49 = getelementptr [2 x i8], [2 x i8]* %t48, i32 0, i32 0
  store i8 41, i8* %t49
  %t50 = getelementptr [2 x i8], [2 x i8]* %t48, i32 0, i32 1
  store i8 0, i8* %t50
  %t51 = getelementptr [2 x i8], [2 x i8]* %t48, i32 0, i32 0
  %t52 = call i8* @sailfin_runtime_string_concat(i8* %t47, i8* %t51)
  %t53 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t40, i8* %t52)
  store { i8**, i64 }* %t53, { i8**, i64 }** %l0
  %t54 = load double, double* %l1
  %t55 = sitofp i64 1 to double
  %t56 = fadd double %t54, %t55
  store double %t56, double* %l1
  br label %loop.latch4
loop.latch4:
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t58 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t62 = load double, double* %l1
  %s63 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.len28.h1179318158, i32 0, i32 0
  %t64 = call i8* @sailfin_runtime_string_concat(i8* %s63, i8* %class_name)
  %s65 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h182022329, i32 0, i32 0
  %t66 = call i8* @sailfin_runtime_string_concat(i8* %t64, i8* %s65)
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s68 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t69 = call i8* @join_with_separator({ i8**, i64 }* %t67, i8* %s68)
  %t70 = call i8* @sailfin_runtime_string_concat(i8* %t66, i8* %t69)
  %s71 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193479629, i32 0, i32 0
  %t72 = call i8* @sailfin_runtime_string_concat(i8* %t70, i8* %s71)
  ret i8* %t72
}

define i1 @is_optional_type(i8* %type_annotation) {
block.entry:
  %l0 = alloca i8*
  %t0 = call i8* @trim_text(i8* %type_annotation)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %t5 = load i8*, i8** %l0
  %t6 = alloca [2 x i8], align 1
  %t7 = getelementptr [2 x i8], [2 x i8]* %t6, i32 0, i32 0
  store i8 63, i8* %t7
  %t8 = getelementptr [2 x i8], [2 x i8]* %t6, i32 0, i32 1
  store i8 0, i8* %t8
  %t9 = getelementptr [2 x i8], [2 x i8]* %t6, i32 0, i32 0
  %t10 = call i1 @ends_with(i8* %t5, i8* %t9)
  ret i1 %t10
}

define i8* @lower_expression(i8* %expression) {
block.entry:
  %t0 = sitofp i64 0 to double
  %t1 = call i8* @lower_expression_with_depth(i8* %expression, double %t0)
  ret i8* %t1
}

define i8* @lower_expression_with_depth(i8* %expression, double %depth) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca i8*
  %l4 = alloca i8*
  %l5 = alloca i8*
  %t0 = sitofp i64 8 to double
  %t1 = fcmp ogt double %depth, %t0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = call i8* @trim_text(i8* %expression)
  ret i8* %t2
merge1:
  %t3 = call i8* @trim_text(i8* %expression)
  store i8* %t3, i8** %l0
  %t4 = load i8*, i8** %l0
  %t5 = call i64 @sailfin_runtime_string_length(i8* %t4)
  %t6 = icmp eq i64 %t5, 0
  %t7 = load i8*, i8** %l0
  br i1 %t6, label %then2, label %merge3
then2:
  %t8 = load i8*, i8** %l0
  ret i8* %t8
merge3:
  %t9 = load i8*, i8** %l0
  %t10 = call i8* @rewrite_interpolated_string_literal(i8* %t9)
  store i8* %t10, i8** %l1
  %t11 = load i8*, i8** %l1
  %t12 = icmp ne i8* %t11, null
  %t13 = load i8*, i8** %l0
  %t14 = load i8*, i8** %l1
  br i1 %t12, label %then4, label %merge5
then4:
  %t15 = load i8*, i8** %l1
  ret i8* %t15
merge5:
  %t16 = load i8*, i8** %l0
  %t17 = call i8* @lower_struct_literal_expression(i8* %t16, double %depth)
  store i8* %t17, i8** %l2
  %t18 = load i8*, i8** %l2
  %t19 = icmp ne i8* %t18, null
  %t20 = load i8*, i8** %l0
  %t21 = load i8*, i8** %l1
  %t22 = load i8*, i8** %l2
  br i1 %t19, label %then6, label %merge7
then6:
  %t23 = load i8*, i8** %l2
  ret i8* %t23
merge7:
  %t24 = load i8*, i8** %l0
  %t25 = call i8* @lower_array_literal_expression(i8* %t24, double %depth)
  store i8* %t25, i8** %l3
  %t26 = load i8*, i8** %l3
  %t27 = icmp ne i8* %t26, null
  %t28 = load i8*, i8** %l0
  %t29 = load i8*, i8** %l1
  %t30 = load i8*, i8** %l2
  %t31 = load i8*, i8** %l3
  br i1 %t27, label %then8, label %merge9
then8:
  %t32 = load i8*, i8** %l3
  ret i8* %t32
merge9:
  %t33 = load i8*, i8** %l0
  %t34 = call i8* @rewrite_expression_intrinsics(i8* %t33)
  store i8* %t34, i8** %l4
  %t35 = load i8*, i8** %l4
  %t36 = call i8* @rewrite_array_literals_inline(i8* %t35, double %depth)
  store i8* %t36, i8** %l5
  %t37 = load i8*, i8** %l5
  %t38 = call i8* @rewrite_struct_literals_inline(i8* %t37, double %depth)
  ret i8* %t38
}

define i8* @rewrite_interpolated_string_literal(i8* %expression) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca i64
  %l4 = alloca double
  %l5 = alloca i8*
  %l6 = alloca i8*
  %l7 = alloca double
  %l8 = alloca i8*
  %l9 = alloca { i8**, i64 }*
  %l10 = alloca double
  %l11 = alloca { i8**, i64 }*
  %l12 = alloca i8*
  %l13 = alloca i8*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t1 = icmp slt i64 %t0, 2
  br i1 %t1, label %then0, label %merge1
then0:
  ret i8* null
merge1:
  %t2 = call i8* @decode_string_literal(i8* %expression)
  store i8* %t2, i8** %l0
  %t3 = load i8*, i8** %l0
  %t4 = icmp eq i8* %t3, null
  %t5 = load i8*, i8** %l0
  br i1 %t4, label %then2, label %merge3
then2:
  ret i8* null
merge3:
  %t6 = load i8*, i8** %l0
  %s7 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193515005, i32 0, i32 0
  %t8 = call double @find_substring(i8* %t6, i8* %s7)
  %t9 = sitofp i64 0 to double
  %t10 = fcmp olt double %t8, %t9
  %t11 = load i8*, i8** %l0
  br i1 %t10, label %then4, label %merge5
then4:
  ret i8* null
merge5:
  %t12 = load i8*, i8** %l0
  %s13 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193517249, i32 0, i32 0
  %t14 = call double @find_substring(i8* %t12, i8* %s13)
  %t15 = sitofp i64 0 to double
  %t16 = fcmp olt double %t14, %t15
  %t17 = load i8*, i8** %l0
  br i1 %t16, label %then6, label %merge7
then6:
  ret i8* null
merge7:
  %t18 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t19 = ptrtoint [0 x i8*]* %t18 to i64
  %t20 = icmp eq i64 %t19, 0
  %t21 = select i1 %t20, i64 1, i64 %t19
  %t22 = call i8* @malloc(i64 %t21)
  %t23 = bitcast i8* %t22 to i8**
  %t24 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t25 = ptrtoint { i8**, i64 }* %t24 to i64
  %t26 = call i8* @malloc(i64 %t25)
  %t27 = bitcast i8* %t26 to { i8**, i64 }*
  %t28 = getelementptr { i8**, i64 }, { i8**, i64 }* %t27, i32 0, i32 0
  store i8** %t23, i8*** %t28
  %t29 = getelementptr { i8**, i64 }, { i8**, i64 }* %t27, i32 0, i32 1
  store i64 0, i64* %t29
  store { i8**, i64 }* %t27, { i8**, i64 }** %l1
  %t30 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t31 = ptrtoint [0 x i8*]* %t30 to i64
  %t32 = icmp eq i64 %t31, 0
  %t33 = select i1 %t32, i64 1, i64 %t31
  %t34 = call i8* @malloc(i64 %t33)
  %t35 = bitcast i8* %t34 to i8**
  %t36 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t37 = ptrtoint { i8**, i64 }* %t36 to i64
  %t38 = call i8* @malloc(i64 %t37)
  %t39 = bitcast i8* %t38 to { i8**, i64 }*
  %t40 = getelementptr { i8**, i64 }, { i8**, i64 }* %t39, i32 0, i32 0
  store i8** %t35, i8*** %t40
  %t41 = getelementptr { i8**, i64 }, { i8**, i64 }* %t39, i32 0, i32 1
  store i64 0, i64* %t41
  store { i8**, i64 }* %t39, { i8**, i64 }** %l2
  store i64 0, i64* %l3
  %t42 = load i8*, i8** %l0
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t45 = load i64, i64* %l3
  br label %loop.header8
loop.header8:
  %t129 = phi { i8**, i64 }* [ %t43, %merge7 ], [ %t126, %loop.latch10 ]
  %t130 = phi { i8**, i64 }* [ %t44, %merge7 ], [ %t127, %loop.latch10 ]
  %t131 = phi i64 [ %t45, %merge7 ], [ %t128, %loop.latch10 ]
  store { i8**, i64 }* %t129, { i8**, i64 }** %l1
  store { i8**, i64 }* %t130, { i8**, i64 }** %l2
  store i64 %t131, i64* %l3
  br label %loop.body9
loop.body9:
  %t46 = load i64, i64* %l3
  %t47 = load i8*, i8** %l0
  %t48 = call i64 @sailfin_runtime_string_length(i8* %t47)
  %t49 = icmp sgt i64 %t46, %t48
  %t50 = load i8*, i8** %l0
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t53 = load i64, i64* %l3
  br i1 %t49, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t54 = load i8*, i8** %l0
  %s55 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193515005, i32 0, i32 0
  %t56 = load i64, i64* %l3
  %t57 = sitofp i64 %t56 to double
  %t58 = call double @find_substring_from(i8* %t54, i8* %s55, double %t57)
  store double %t58, double* %l4
  %t59 = load double, double* %l4
  %t60 = sitofp i64 0 to double
  %t61 = fcmp olt double %t59, %t60
  %t62 = load i8*, i8** %l0
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t65 = load i64, i64* %l3
  %t66 = load double, double* %l4
  br i1 %t61, label %then14, label %merge15
then14:
  %t67 = load i8*, i8** %l0
  %t68 = load i64, i64* %l3
  %t69 = load i8*, i8** %l0
  %t70 = call i64 @sailfin_runtime_string_length(i8* %t69)
  %t71 = call i8* @sailfin_runtime_substring(i8* %t67, i64 %t68, i64 %t70)
  store i8* %t71, i8** %l5
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t73 = load i8*, i8** %l5
  %t74 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t72, i8* %t73)
  store { i8**, i64 }* %t74, { i8**, i64 }** %l1
  br label %afterloop11
merge15:
  %t75 = load i8*, i8** %l0
  %t76 = load i64, i64* %l3
  %t77 = load double, double* %l4
  %t78 = fptosi double %t77 to i64
  %t79 = call i8* @sailfin_runtime_substring(i8* %t75, i64 %t76, i64 %t78)
  store i8* %t79, i8** %l6
  %t80 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t81 = load i8*, i8** %l6
  %t82 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t80, i8* %t81)
  store { i8**, i64 }* %t82, { i8**, i64 }** %l1
  %t83 = load i8*, i8** %l0
  %s84 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193517249, i32 0, i32 0
  %t85 = load double, double* %l4
  %t86 = sitofp i64 2 to double
  %t87 = fadd double %t85, %t86
  %t88 = call double @find_substring_from(i8* %t83, i8* %s84, double %t87)
  store double %t88, double* %l7
  %t89 = load double, double* %l7
  %t90 = sitofp i64 0 to double
  %t91 = fcmp olt double %t89, %t90
  %t92 = load i8*, i8** %l0
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t94 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t95 = load i64, i64* %l3
  %t96 = load double, double* %l4
  %t97 = load i8*, i8** %l6
  %t98 = load double, double* %l7
  br i1 %t91, label %then16, label %merge17
then16:
  ret i8* null
merge17:
  %t99 = load i8*, i8** %l0
  %t100 = load double, double* %l4
  %t101 = sitofp i64 2 to double
  %t102 = fadd double %t100, %t101
  %t103 = load double, double* %l7
  %t104 = fptosi double %t102 to i64
  %t105 = fptosi double %t103 to i64
  %t106 = call i8* @sailfin_runtime_substring(i8* %t99, i64 %t104, i64 %t105)
  %t107 = call i8* @trim_text(i8* %t106)
  store i8* %t107, i8** %l8
  %t108 = load i8*, i8** %l8
  %t109 = call i64 @sailfin_runtime_string_length(i8* %t108)
  %t110 = icmp eq i64 %t109, 0
  %t111 = load i8*, i8** %l0
  %t112 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t113 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t114 = load i64, i64* %l3
  %t115 = load double, double* %l4
  %t116 = load i8*, i8** %l6
  %t117 = load double, double* %l7
  %t118 = load i8*, i8** %l8
  br i1 %t110, label %then18, label %merge19
then18:
  ret i8* null
merge19:
  %t119 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t120 = load i8*, i8** %l8
  %t121 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t119, i8* %t120)
  store { i8**, i64 }* %t121, { i8**, i64 }** %l2
  %t122 = load double, double* %l7
  %t123 = sitofp i64 2 to double
  %t124 = fadd double %t122, %t123
  %t125 = fptosi double %t124 to i64
  store i64 %t125, i64* %l3
  br label %loop.latch10
loop.latch10:
  %t126 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t127 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t128 = load i64, i64* %l3
  br label %loop.header8
afterloop11:
  %t132 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t133 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t134 = load i64, i64* %l3
  %t135 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t136 = load { i8**, i64 }, { i8**, i64 }* %t135
  %t137 = extractvalue { i8**, i64 } %t136, 1
  %t138 = icmp eq i64 %t137, 0
  %t139 = load i8*, i8** %l0
  %t140 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t141 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t142 = load i64, i64* %l3
  br i1 %t138, label %then20, label %merge21
then20:
  ret i8* null
merge21:
  %t143 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t144 = ptrtoint [0 x i8*]* %t143 to i64
  %t145 = icmp eq i64 %t144, 0
  %t146 = select i1 %t145, i64 1, i64 %t144
  %t147 = call i8* @malloc(i64 %t146)
  %t148 = bitcast i8* %t147 to i8**
  %t149 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t150 = ptrtoint { i8**, i64 }* %t149 to i64
  %t151 = call i8* @malloc(i64 %t150)
  %t152 = bitcast i8* %t151 to { i8**, i64 }*
  %t153 = getelementptr { i8**, i64 }, { i8**, i64 }* %t152, i32 0, i32 0
  store i8** %t148, i8*** %t153
  %t154 = getelementptr { i8**, i64 }, { i8**, i64 }* %t152, i32 0, i32 1
  store i64 0, i64* %t154
  store { i8**, i64 }* %t152, { i8**, i64 }** %l9
  %t155 = sitofp i64 0 to double
  store double %t155, double* %l10
  %t156 = load i8*, i8** %l0
  %t157 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t158 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t159 = load i64, i64* %l3
  %t160 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t161 = load double, double* %l10
  br label %loop.header22
loop.header22:
  %t191 = phi { i8**, i64 }* [ %t160, %merge21 ], [ %t189, %loop.latch24 ]
  %t192 = phi double [ %t161, %merge21 ], [ %t190, %loop.latch24 ]
  store { i8**, i64 }* %t191, { i8**, i64 }** %l9
  store double %t192, double* %l10
  br label %loop.body23
loop.body23:
  %t162 = load double, double* %l10
  %t163 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t164 = load { i8**, i64 }, { i8**, i64 }* %t163
  %t165 = extractvalue { i8**, i64 } %t164, 1
  %t166 = sitofp i64 %t165 to double
  %t167 = fcmp oge double %t162, %t166
  %t168 = load i8*, i8** %l0
  %t169 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t170 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t171 = load i64, i64* %l3
  %t172 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t173 = load double, double* %l10
  br i1 %t167, label %then26, label %merge27
then26:
  br label %afterloop25
merge27:
  %t174 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t175 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t176 = load double, double* %l10
  %t177 = fptosi double %t176 to i64
  %t178 = load { i8**, i64 }, { i8**, i64 }* %t175
  %t179 = extractvalue { i8**, i64 } %t178, 0
  %t180 = extractvalue { i8**, i64 } %t178, 1
  %t181 = icmp uge i64 %t177, %t180
  ; bounds check: %t181 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t177, i64 %t180)
  %t182 = getelementptr i8*, i8** %t179, i64 %t177
  %t183 = load i8*, i8** %t182
  %t184 = call i8* @python_string_literal(i8* %t183)
  %t185 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t174, i8* %t184)
  store { i8**, i64 }* %t185, { i8**, i64 }** %l9
  %t186 = load double, double* %l10
  %t187 = sitofp i64 1 to double
  %t188 = fadd double %t186, %t187
  store double %t188, double* %l10
  br label %loop.latch24
loop.latch24:
  %t189 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t190 = load double, double* %l10
  br label %loop.header22
afterloop25:
  %t193 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t194 = load double, double* %l10
  %t195 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t196 = ptrtoint [0 x i8*]* %t195 to i64
  %t197 = icmp eq i64 %t196, 0
  %t198 = select i1 %t197, i64 1, i64 %t196
  %t199 = call i8* @malloc(i64 %t198)
  %t200 = bitcast i8* %t199 to i8**
  %t201 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t202 = ptrtoint { i8**, i64 }* %t201 to i64
  %t203 = call i8* @malloc(i64 %t202)
  %t204 = bitcast i8* %t203 to { i8**, i64 }*
  %t205 = getelementptr { i8**, i64 }, { i8**, i64 }* %t204, i32 0, i32 0
  store i8** %t200, i8*** %t205
  %t206 = getelementptr { i8**, i64 }, { i8**, i64 }* %t204, i32 0, i32 1
  store i64 0, i64* %t206
  store { i8**, i64 }* %t204, { i8**, i64 }** %l11
  %t207 = sitofp i64 0 to double
  store double %t207, double* %l10
  %t208 = load i8*, i8** %l0
  %t209 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t210 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t211 = load i64, i64* %l3
  %t212 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t213 = load double, double* %l10
  %t214 = load { i8**, i64 }*, { i8**, i64 }** %l11
  br label %loop.header28
loop.header28:
  %t254 = phi { i8**, i64 }* [ %t214, %afterloop25 ], [ %t252, %loop.latch30 ]
  %t255 = phi double [ %t213, %afterloop25 ], [ %t253, %loop.latch30 ]
  store { i8**, i64 }* %t254, { i8**, i64 }** %l11
  store double %t255, double* %l10
  br label %loop.body29
loop.body29:
  %t215 = load double, double* %l10
  %t216 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t217 = load { i8**, i64 }, { i8**, i64 }* %t216
  %t218 = extractvalue { i8**, i64 } %t217, 1
  %t219 = sitofp i64 %t218 to double
  %t220 = fcmp oge double %t215, %t219
  %t221 = load i8*, i8** %l0
  %t222 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t223 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t224 = load i64, i64* %l3
  %t225 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t226 = load double, double* %l10
  %t227 = load { i8**, i64 }*, { i8**, i64 }** %l11
  br i1 %t220, label %then32, label %merge33
then32:
  br label %afterloop31
merge33:
  %t228 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %t229 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t230 = load double, double* %l10
  %t231 = fptosi double %t230 to i64
  %t232 = load { i8**, i64 }, { i8**, i64 }* %t229
  %t233 = extractvalue { i8**, i64 } %t232, 0
  %t234 = extractvalue { i8**, i64 } %t232, 1
  %t235 = icmp uge i64 %t231, %t234
  ; bounds check: %t235 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t231, i64 %t234)
  %t236 = getelementptr i8*, i8** %t233, i64 %t231
  %t237 = load i8*, i8** %t236
  %t238 = alloca [2 x i8], align 1
  %t239 = getelementptr [2 x i8], [2 x i8]* %t238, i32 0, i32 0
  store i8 40, i8* %t239
  %t240 = getelementptr [2 x i8], [2 x i8]* %t238, i32 0, i32 1
  store i8 0, i8* %t240
  %t241 = getelementptr [2 x i8], [2 x i8]* %t238, i32 0, i32 0
  %t242 = call i8* @sailfin_runtime_string_concat(i8* %t241, i8* %t237)
  %t243 = alloca [2 x i8], align 1
  %t244 = getelementptr [2 x i8], [2 x i8]* %t243, i32 0, i32 0
  store i8 41, i8* %t244
  %t245 = getelementptr [2 x i8], [2 x i8]* %t243, i32 0, i32 1
  store i8 0, i8* %t245
  %t246 = getelementptr [2 x i8], [2 x i8]* %t243, i32 0, i32 0
  %t247 = call i8* @sailfin_runtime_string_concat(i8* %t242, i8* %t246)
  %t248 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t228, i8* %t247)
  store { i8**, i64 }* %t248, { i8**, i64 }** %l11
  %t249 = load double, double* %l10
  %t250 = sitofp i64 1 to double
  %t251 = fadd double %t249, %t250
  store double %t251, double* %l10
  br label %loop.latch30
loop.latch30:
  %t252 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %t253 = load double, double* %l10
  br label %loop.header28
afterloop31:
  %t256 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %t257 = load double, double* %l10
  %t258 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %s259 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t260 = call i8* @join_with_separator({ i8**, i64 }* %t258, i8* %s259)
  %t261 = alloca [2 x i8], align 1
  %t262 = getelementptr [2 x i8], [2 x i8]* %t261, i32 0, i32 0
  store i8 91, i8* %t262
  %t263 = getelementptr [2 x i8], [2 x i8]* %t261, i32 0, i32 1
  store i8 0, i8* %t263
  %t264 = getelementptr [2 x i8], [2 x i8]* %t261, i32 0, i32 0
  %t265 = call i8* @sailfin_runtime_string_concat(i8* %t264, i8* %t260)
  %t266 = alloca [2 x i8], align 1
  %t267 = getelementptr [2 x i8], [2 x i8]* %t266, i32 0, i32 0
  store i8 93, i8* %t267
  %t268 = getelementptr [2 x i8], [2 x i8]* %t266, i32 0, i32 1
  store i8 0, i8* %t268
  %t269 = getelementptr [2 x i8], [2 x i8]* %t266, i32 0, i32 0
  %t270 = call i8* @sailfin_runtime_string_concat(i8* %t265, i8* %t269)
  store i8* %t270, i8** %l12
  %t271 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %s272 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t273 = call i8* @join_with_separator({ i8**, i64 }* %t271, i8* %s272)
  %t274 = alloca [2 x i8], align 1
  %t275 = getelementptr [2 x i8], [2 x i8]* %t274, i32 0, i32 0
  store i8 91, i8* %t275
  %t276 = getelementptr [2 x i8], [2 x i8]* %t274, i32 0, i32 1
  store i8 0, i8* %t276
  %t277 = getelementptr [2 x i8], [2 x i8]* %t274, i32 0, i32 0
  %t278 = call i8* @sailfin_runtime_string_concat(i8* %t277, i8* %t273)
  %t279 = alloca [2 x i8], align 1
  %t280 = getelementptr [2 x i8], [2 x i8]* %t279, i32 0, i32 0
  store i8 93, i8* %t280
  %t281 = getelementptr [2 x i8], [2 x i8]* %t279, i32 0, i32 1
  store i8 0, i8* %t281
  %t282 = getelementptr [2 x i8], [2 x i8]* %t279, i32 0, i32 0
  %t283 = call i8* @sailfin_runtime_string_concat(i8* %t278, i8* %t282)
  store i8* %t283, i8** %l13
  %s284 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.len28.h583209964, i32 0, i32 0
  %t285 = load i8*, i8** %l12
  %t286 = call i8* @sailfin_runtime_string_concat(i8* %s284, i8* %t285)
  %s287 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t288 = call i8* @sailfin_runtime_string_concat(i8* %t286, i8* %s287)
  %t289 = load i8*, i8** %l13
  %t290 = call i8* @sailfin_runtime_string_concat(i8* %t288, i8* %t289)
  %t291 = alloca [2 x i8], align 1
  %t292 = getelementptr [2 x i8], [2 x i8]* %t291, i32 0, i32 0
  store i8 41, i8* %t292
  %t293 = getelementptr [2 x i8], [2 x i8]* %t291, i32 0, i32 1
  store i8 0, i8* %t293
  %t294 = getelementptr [2 x i8], [2 x i8]* %t291, i32 0, i32 0
  %t295 = call i8* @sailfin_runtime_string_concat(i8* %t290, i8* %t294)
  ret i8* %t295
}

define i8* @decode_string_literal(i8* %expression) {
block.entry:
  %l0 = alloca i8
  %l1 = alloca i8*
  %l2 = alloca i64
  %l3 = alloca i8
  %l4 = alloca i8
  %t0 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t1 = icmp slt i64 %t0, 2
  br i1 %t1, label %then0, label %merge1
then0:
  ret i8* null
merge1:
  %t2 = getelementptr i8, i8* %expression, i64 0
  %t3 = load i8, i8* %t2
  store i8 %t3, i8* %l0
  %t5 = load i8, i8* %l0
  %t6 = icmp ne i8 %t5, 34
  br label %logical_and_entry_4

logical_and_entry_4:
  br i1 %t6, label %logical_and_right_4, label %logical_and_merge_4

logical_and_right_4:
  %t7 = load i8, i8* %l0
  %t8 = icmp ne i8 %t7, 39
  br label %logical_and_right_end_4

logical_and_right_end_4:
  br label %logical_and_merge_4

logical_and_merge_4:
  %t9 = phi i1 [ false, %logical_and_entry_4 ], [ %t8, %logical_and_right_end_4 ]
  %t10 = load i8, i8* %l0
  br i1 %t9, label %then2, label %merge3
then2:
  ret i8* null
merge3:
  %t11 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t12 = sub i64 %t11, 1
  %t13 = getelementptr i8, i8* %expression, i64 %t12
  %t14 = load i8, i8* %t13
  %t15 = load i8, i8* %l0
  %t16 = icmp ne i8 %t14, %t15
  %t17 = load i8, i8* %l0
  br i1 %t16, label %then4, label %merge5
then4:
  ret i8* null
merge5:
  %s18 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s18, i8** %l1
  store i64 1, i64* %l2
  %t19 = load i8, i8* %l0
  %t20 = load i8*, i8** %l1
  %t21 = load i64, i64* %l2
  br label %loop.header6
loop.header6:
  %t77 = phi i64 [ %t21, %merge5 ], [ %t75, %loop.latch8 ]
  %t78 = phi i8* [ %t20, %merge5 ], [ %t76, %loop.latch8 ]
  store i64 %t77, i64* %l2
  store i8* %t78, i8** %l1
  br label %loop.body7
loop.body7:
  %t22 = load i64, i64* %l2
  %t23 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t24 = sub i64 %t23, 1
  %t25 = icmp sge i64 %t22, %t24
  %t26 = load i8, i8* %l0
  %t27 = load i8*, i8** %l1
  %t28 = load i64, i64* %l2
  br i1 %t25, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t29 = load i64, i64* %l2
  %t30 = getelementptr i8, i8* %expression, i64 %t29
  %t31 = load i8, i8* %t30
  store i8 %t31, i8* %l3
  %t32 = load i8, i8* %l3
  %t33 = icmp eq i8 %t32, 92
  %t34 = load i8, i8* %l0
  %t35 = load i8*, i8** %l1
  %t36 = load i64, i64* %l2
  %t37 = load i8, i8* %l3
  br i1 %t33, label %then12, label %merge13
then12:
  %t38 = load i64, i64* %l2
  %t39 = add i64 %t38, 1
  store i64 %t39, i64* %l2
  %t40 = load i64, i64* %l2
  %t41 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t42 = sub i64 %t41, 1
  %t43 = icmp sge i64 %t40, %t42
  %t44 = load i8, i8* %l0
  %t45 = load i8*, i8** %l1
  %t46 = load i64, i64* %l2
  %t47 = load i8, i8* %l3
  br i1 %t43, label %then14, label %merge15
then14:
  ret i8* null
merge15:
  %t48 = load i64, i64* %l2
  %t49 = getelementptr i8, i8* %expression, i64 %t48
  %t50 = load i8, i8* %t49
  store i8 %t50, i8* %l4
  %t51 = load i8*, i8** %l1
  %t52 = load i8, i8* %l4
  %t53 = load i8, i8* %l0
  %t54 = alloca [2 x i8], align 1
  %t55 = getelementptr [2 x i8], [2 x i8]* %t54, i32 0, i32 0
  store i8 %t52, i8* %t55
  %t56 = getelementptr [2 x i8], [2 x i8]* %t54, i32 0, i32 1
  store i8 0, i8* %t56
  %t57 = getelementptr [2 x i8], [2 x i8]* %t54, i32 0, i32 0
  %t58 = alloca [2 x i8], align 1
  %t59 = getelementptr [2 x i8], [2 x i8]* %t58, i32 0, i32 0
  store i8 %t53, i8* %t59
  %t60 = getelementptr [2 x i8], [2 x i8]* %t58, i32 0, i32 1
  store i8 0, i8* %t60
  %t61 = getelementptr [2 x i8], [2 x i8]* %t58, i32 0, i32 0
  %t62 = call i8* @decode_escape_sequence(i8* %t57, i8* %t61)
  %t63 = call i8* @sailfin_runtime_string_concat(i8* %t51, i8* %t62)
  store i8* %t63, i8** %l1
  %t64 = load i64, i64* %l2
  %t65 = add i64 %t64, 1
  store i64 %t65, i64* %l2
  br label %loop.latch8
merge13:
  %t66 = load i8*, i8** %l1
  %t67 = load i8, i8* %l3
  %t68 = alloca [2 x i8], align 1
  %t69 = getelementptr [2 x i8], [2 x i8]* %t68, i32 0, i32 0
  store i8 %t67, i8* %t69
  %t70 = getelementptr [2 x i8], [2 x i8]* %t68, i32 0, i32 1
  store i8 0, i8* %t70
  %t71 = getelementptr [2 x i8], [2 x i8]* %t68, i32 0, i32 0
  %t72 = call i8* @sailfin_runtime_string_concat(i8* %t66, i8* %t71)
  store i8* %t72, i8** %l1
  %t73 = load i64, i64* %l2
  %t74 = add i64 %t73, 1
  store i64 %t74, i64* %l2
  br label %loop.latch8
loop.latch8:
  %t75 = load i64, i64* %l2
  %t76 = load i8*, i8** %l1
  br label %loop.header6
afterloop9:
  %t79 = load i64, i64* %l2
  %t80 = load i8*, i8** %l1
  %t81 = load i8*, i8** %l1
  ret i8* %t81
}

define i8* @decode_escape_sequence(i8* %escape, i8* %quote) {
block.entry:
  %t0 = load i8, i8* %escape
  %t1 = icmp eq i8 %t0, 110
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = alloca [2 x i8], align 1
  %t3 = getelementptr [2 x i8], [2 x i8]* %t2, i32 0, i32 0
  store i8 10, i8* %t3
  %t4 = getelementptr [2 x i8], [2 x i8]* %t2, i32 0, i32 1
  store i8 0, i8* %t4
  %t5 = getelementptr [2 x i8], [2 x i8]* %t2, i32 0, i32 0
  ret i8* %t5
merge1:
  %t6 = load i8, i8* %escape
  %t7 = icmp eq i8 %t6, 114
  br i1 %t7, label %then2, label %merge3
then2:
  %t8 = alloca [2 x i8], align 1
  %t9 = getelementptr [2 x i8], [2 x i8]* %t8, i32 0, i32 0
  store i8 13, i8* %t9
  %t10 = getelementptr [2 x i8], [2 x i8]* %t8, i32 0, i32 1
  store i8 0, i8* %t10
  %t11 = getelementptr [2 x i8], [2 x i8]* %t8, i32 0, i32 0
  ret i8* %t11
merge3:
  %t12 = load i8, i8* %escape
  %t13 = icmp eq i8 %t12, 116
  br i1 %t13, label %then4, label %merge5
then4:
  %t14 = alloca [2 x i8], align 1
  %t15 = getelementptr [2 x i8], [2 x i8]* %t14, i32 0, i32 0
  store i8 9, i8* %t15
  %t16 = getelementptr [2 x i8], [2 x i8]* %t14, i32 0, i32 1
  store i8 0, i8* %t16
  %t17 = getelementptr [2 x i8], [2 x i8]* %t14, i32 0, i32 0
  ret i8* %t17
merge5:
  %t18 = load i8, i8* %escape
  %t19 = icmp eq i8 %t18, 92
  br i1 %t19, label %then6, label %merge7
then6:
  %t20 = alloca [2 x i8], align 1
  %t21 = getelementptr [2 x i8], [2 x i8]* %t20, i32 0, i32 0
  store i8 92, i8* %t21
  %t22 = getelementptr [2 x i8], [2 x i8]* %t20, i32 0, i32 1
  store i8 0, i8* %t22
  %t23 = getelementptr [2 x i8], [2 x i8]* %t20, i32 0, i32 0
  ret i8* %t23
merge7:
  %t24 = icmp eq i8* %escape, %quote
  br i1 %t24, label %then8, label %merge9
then8:
  ret i8* %quote
merge9:
  ret i8* %escape
}

define i8* @python_string_literal(i8* %value) {
block.entry:
  %l0 = alloca i8
  %l1 = alloca i64
  %l2 = alloca i8
  store i8 39, i8* %l0
  store i64 0, i64* %l1
  %t0 = load i8, i8* %l0
  %t1 = load i64, i64* %l1
  br label %loop.header0
loop.header0:
  %t107 = phi i8 [ %t0, %block.entry ], [ %t105, %loop.latch2 ]
  %t108 = phi i64 [ %t1, %block.entry ], [ %t106, %loop.latch2 ]
  store i8 %t107, i8* %l0
  store i64 %t108, i64* %l1
  br label %loop.body1
loop.body1:
  %t2 = load i64, i64* %l1
  %t3 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t4 = icmp sge i64 %t2, %t3
  %t5 = load i8, i8* %l0
  %t6 = load i64, i64* %l1
  br i1 %t4, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t7 = load i64, i64* %l1
  %t8 = getelementptr i8, i8* %value, i64 %t7
  %t9 = load i8, i8* %t8
  store i8 %t9, i8* %l2
  %t10 = load i8, i8* %l2
  %t11 = icmp eq i8 %t10, 92
  %t12 = load i8, i8* %l0
  %t13 = load i64, i64* %l1
  %t14 = load i8, i8* %l2
  br i1 %t11, label %then6, label %else7
then6:
  %t15 = load i8, i8* %l0
  %s16 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193480223, i32 0, i32 0
  %t17 = alloca [2 x i8], align 1
  %t18 = getelementptr [2 x i8], [2 x i8]* %t17, i32 0, i32 0
  store i8 %t15, i8* %t18
  %t19 = getelementptr [2 x i8], [2 x i8]* %t17, i32 0, i32 1
  store i8 0, i8* %t19
  %t20 = getelementptr [2 x i8], [2 x i8]* %t17, i32 0, i32 0
  %t21 = call i8* @sailfin_runtime_string_concat(i8* %t20, i8* %s16)
  %t22 = load i8, i8* %t21
  store i8 %t22, i8* %l0
  %t23 = load i8, i8* %l0
  br label %merge8
else7:
  %t24 = load i8, i8* %l2
  %t25 = icmp eq i8 %t24, 39
  %t26 = load i8, i8* %l0
  %t27 = load i64, i64* %l1
  %t28 = load i8, i8* %l2
  br i1 %t25, label %then9, label %else10
then9:
  %t29 = load i8, i8* %l0
  %s30 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193478474, i32 0, i32 0
  %t31 = alloca [2 x i8], align 1
  %t32 = getelementptr [2 x i8], [2 x i8]* %t31, i32 0, i32 0
  store i8 %t29, i8* %t32
  %t33 = getelementptr [2 x i8], [2 x i8]* %t31, i32 0, i32 1
  store i8 0, i8* %t33
  %t34 = getelementptr [2 x i8], [2 x i8]* %t31, i32 0, i32 0
  %t35 = call i8* @sailfin_runtime_string_concat(i8* %t34, i8* %s30)
  %t36 = load i8, i8* %t35
  store i8 %t36, i8* %l0
  %t37 = load i8, i8* %l0
  br label %merge11
else10:
  %t38 = load i8, i8* %l2
  %t39 = icmp eq i8 %t38, 10
  %t40 = load i8, i8* %l0
  %t41 = load i64, i64* %l1
  %t42 = load i8, i8* %l2
  br i1 %t39, label %then12, label %else13
then12:
  %t43 = load i8, i8* %l0
  %s44 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193480817, i32 0, i32 0
  %t45 = alloca [2 x i8], align 1
  %t46 = getelementptr [2 x i8], [2 x i8]* %t45, i32 0, i32 0
  store i8 %t43, i8* %t46
  %t47 = getelementptr [2 x i8], [2 x i8]* %t45, i32 0, i32 1
  store i8 0, i8* %t47
  %t48 = getelementptr [2 x i8], [2 x i8]* %t45, i32 0, i32 0
  %t49 = call i8* @sailfin_runtime_string_concat(i8* %t48, i8* %s44)
  %t50 = load i8, i8* %t49
  store i8 %t50, i8* %l0
  %t51 = load i8, i8* %l0
  br label %merge14
else13:
  %t52 = load i8, i8* %l2
  %t53 = icmp eq i8 %t52, 13
  %t54 = load i8, i8* %l0
  %t55 = load i64, i64* %l1
  %t56 = load i8, i8* %l2
  br i1 %t53, label %then15, label %else16
then15:
  %t57 = load i8, i8* %l0
  %s58 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193480949, i32 0, i32 0
  %t59 = alloca [2 x i8], align 1
  %t60 = getelementptr [2 x i8], [2 x i8]* %t59, i32 0, i32 0
  store i8 %t57, i8* %t60
  %t61 = getelementptr [2 x i8], [2 x i8]* %t59, i32 0, i32 1
  store i8 0, i8* %t61
  %t62 = getelementptr [2 x i8], [2 x i8]* %t59, i32 0, i32 0
  %t63 = call i8* @sailfin_runtime_string_concat(i8* %t62, i8* %s58)
  %t64 = load i8, i8* %t63
  store i8 %t64, i8* %l0
  %t65 = load i8, i8* %l0
  br label %merge17
else16:
  %t66 = load i8, i8* %l2
  %t67 = icmp eq i8 %t66, 9
  %t68 = load i8, i8* %l0
  %t69 = load i64, i64* %l1
  %t70 = load i8, i8* %l2
  br i1 %t67, label %then18, label %else19
then18:
  %t71 = load i8, i8* %l0
  %s72 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193481015, i32 0, i32 0
  %t73 = alloca [2 x i8], align 1
  %t74 = getelementptr [2 x i8], [2 x i8]* %t73, i32 0, i32 0
  store i8 %t71, i8* %t74
  %t75 = getelementptr [2 x i8], [2 x i8]* %t73, i32 0, i32 1
  store i8 0, i8* %t75
  %t76 = getelementptr [2 x i8], [2 x i8]* %t73, i32 0, i32 0
  %t77 = call i8* @sailfin_runtime_string_concat(i8* %t76, i8* %s72)
  %t78 = load i8, i8* %t77
  store i8 %t78, i8* %l0
  %t79 = load i8, i8* %l0
  br label %merge20
else19:
  %t80 = load i8, i8* %l0
  %t81 = load i8, i8* %l2
  %t82 = add i8 %t80, %t81
  store i8 %t82, i8* %l0
  %t83 = load i8, i8* %l0
  br label %merge20
merge20:
  %t84 = phi i8 [ %t79, %then18 ], [ %t83, %else19 ]
  store i8 %t84, i8* %l0
  %t85 = load i8, i8* %l0
  %t86 = load i8, i8* %l0
  br label %merge17
merge17:
  %t87 = phi i8 [ %t65, %then15 ], [ %t85, %merge20 ]
  store i8 %t87, i8* %l0
  %t88 = load i8, i8* %l0
  %t89 = load i8, i8* %l0
  %t90 = load i8, i8* %l0
  br label %merge14
merge14:
  %t91 = phi i8 [ %t51, %then12 ], [ %t88, %merge17 ]
  store i8 %t91, i8* %l0
  %t92 = load i8, i8* %l0
  %t93 = load i8, i8* %l0
  %t94 = load i8, i8* %l0
  %t95 = load i8, i8* %l0
  br label %merge11
merge11:
  %t96 = phi i8 [ %t37, %then9 ], [ %t92, %merge14 ]
  store i8 %t96, i8* %l0
  %t97 = load i8, i8* %l0
  %t98 = load i8, i8* %l0
  %t99 = load i8, i8* %l0
  %t100 = load i8, i8* %l0
  %t101 = load i8, i8* %l0
  br label %merge8
merge8:
  %t102 = phi i8 [ %t23, %then6 ], [ %t97, %merge11 ]
  store i8 %t102, i8* %l0
  %t103 = load i64, i64* %l1
  %t104 = add i64 %t103, 1
  store i64 %t104, i64* %l1
  br label %loop.latch2
loop.latch2:
  %t105 = load i8, i8* %l0
  %t106 = load i64, i64* %l1
  br label %loop.header0
afterloop3:
  %t109 = load i8, i8* %l0
  %t110 = load i64, i64* %l1
  %t111 = load i8, i8* %l0
  %t112 = add i8 %t111, 39
  store i8 %t112, i8* %l0
  %t113 = load i8, i8* %l0
  %t114 = alloca [2 x i8], align 1
  %t115 = getelementptr [2 x i8], [2 x i8]* %t114, i32 0, i32 0
  store i8 %t113, i8* %t115
  %t116 = getelementptr [2 x i8], [2 x i8]* %t114, i32 0, i32 1
  store i8 0, i8* %t116
  %t117 = getelementptr [2 x i8], [2 x i8]* %t114, i32 0, i32 0
  ret i8* %t117
}

define double @find_substring(i8* %value, i8* %pattern) {
block.entry:
  %l0 = alloca i64
  %l1 = alloca i1
  %l2 = alloca i64
  %t0 = call i64 @sailfin_runtime_string_length(i8* %pattern)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = sitofp i64 0 to double
  ret double %t2
merge1:
  %t3 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t4 = call i64 @sailfin_runtime_string_length(i8* %pattern)
  %t5 = icmp slt i64 %t3, %t4
  br i1 %t5, label %then2, label %merge3
then2:
  %t6 = sitofp i64 -1 to double
  ret double %t6
merge3:
  store i64 0, i64* %l0
  %t7 = load i64, i64* %l0
  br label %loop.header4
loop.header4:
  %t52 = phi i64 [ %t7, %merge3 ], [ %t51, %loop.latch6 ]
  store i64 %t52, i64* %l0
  br label %loop.body5
loop.body5:
  %t8 = load i64, i64* %l0
  %t9 = call i64 @sailfin_runtime_string_length(i8* %pattern)
  %t10 = add i64 %t8, %t9
  %t11 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t12 = icmp sgt i64 %t10, %t11
  %t13 = load i64, i64* %l0
  br i1 %t12, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  store i1 1, i1* %l1
  store i64 0, i64* %l2
  %t14 = load i64, i64* %l0
  %t15 = load i1, i1* %l1
  %t16 = load i64, i64* %l2
  br label %loop.header10
loop.header10:
  %t39 = phi i1 [ %t15, %merge9 ], [ %t37, %loop.latch12 ]
  %t40 = phi i64 [ %t16, %merge9 ], [ %t38, %loop.latch12 ]
  store i1 %t39, i1* %l1
  store i64 %t40, i64* %l2
  br label %loop.body11
loop.body11:
  %t17 = load i64, i64* %l2
  %t18 = call i64 @sailfin_runtime_string_length(i8* %pattern)
  %t19 = icmp sge i64 %t17, %t18
  %t20 = load i64, i64* %l0
  %t21 = load i1, i1* %l1
  %t22 = load i64, i64* %l2
  br i1 %t19, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t23 = load i64, i64* %l0
  %t24 = load i64, i64* %l2
  %t25 = add i64 %t23, %t24
  %t26 = getelementptr i8, i8* %value, i64 %t25
  %t27 = load i8, i8* %t26
  %t28 = load i64, i64* %l2
  %t29 = getelementptr i8, i8* %pattern, i64 %t28
  %t30 = load i8, i8* %t29
  %t31 = icmp ne i8 %t27, %t30
  %t32 = load i64, i64* %l0
  %t33 = load i1, i1* %l1
  %t34 = load i64, i64* %l2
  br i1 %t31, label %then16, label %merge17
then16:
  store i1 0, i1* %l1
  br label %afterloop13
merge17:
  %t35 = load i64, i64* %l2
  %t36 = add i64 %t35, 1
  store i64 %t36, i64* %l2
  br label %loop.latch12
loop.latch12:
  %t37 = load i1, i1* %l1
  %t38 = load i64, i64* %l2
  br label %loop.header10
afterloop13:
  %t41 = load i1, i1* %l1
  %t42 = load i64, i64* %l2
  %t43 = load i1, i1* %l1
  %t44 = load i64, i64* %l0
  %t45 = load i1, i1* %l1
  %t46 = load i64, i64* %l2
  br i1 %t43, label %then18, label %merge19
then18:
  %t47 = load i64, i64* %l0
  %t48 = sitofp i64 %t47 to double
  ret double %t48
merge19:
  %t49 = load i64, i64* %l0
  %t50 = add i64 %t49, 1
  store i64 %t50, i64* %l0
  br label %loop.latch6
loop.latch6:
  %t51 = load i64, i64* %l0
  br label %loop.header4
afterloop7:
  %t53 = load i64, i64* %l0
  %t54 = sitofp i64 -1 to double
  ret double %t54
}

define i8* @lower_struct_literal_expression(i8* %expression, double %depth) {
block.entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca i8*
  %l4 = alloca { i8**, i64 }*
  %l5 = alloca { i8**, i64 }*
  %l6 = alloca { i8**, i64 }*
  %l7 = alloca double
  %l8 = alloca i8*
  %l9 = alloca double
  %l10 = alloca i8*
  %l11 = alloca i8*
  %l12 = alloca i8*
  %l13 = alloca i8*
  %l14 = alloca i8*
  %l15 = alloca double
  %l16 = alloca i8*
  %l17 = alloca i8*
  %l18 = alloca i8*
  %t0 = alloca [2 x i8], align 1
  %t1 = getelementptr [2 x i8], [2 x i8]* %t0, i32 0, i32 0
  store i8 123, i8* %t1
  %t2 = getelementptr [2 x i8], [2 x i8]* %t0, i32 0, i32 1
  store i8 0, i8* %t2
  %t3 = getelementptr [2 x i8], [2 x i8]* %t0, i32 0, i32 0
  %t4 = call double @index_of(i8* %expression, i8* %t3)
  store double %t4, double* %l0
  %t5 = load double, double* %l0
  %t6 = sitofp i64 0 to double
  %t7 = fcmp olt double %t5, %t6
  %t8 = load double, double* %l0
  br i1 %t7, label %then0, label %merge1
then0:
  ret i8* null
merge1:
  %t9 = load double, double* %l0
  %t10 = call double @find_matching_brace(i8* %expression, double %t9)
  store double %t10, double* %l1
  %t11 = load double, double* %l1
  %t12 = sitofp i64 0 to double
  %t13 = fcmp olt double %t11, %t12
  %t14 = load double, double* %l0
  %t15 = load double, double* %l1
  br i1 %t13, label %then2, label %merge3
then2:
  ret i8* null
merge3:
  %t16 = load double, double* %l0
  %t17 = fptosi double %t16 to i64
  %t18 = call i8* @sailfin_runtime_substring(i8* %expression, i64 0, i64 %t17)
  %t19 = call i8* @trim_text(i8* %t18)
  store i8* %t19, i8** %l2
  %t20 = load i8*, i8** %l2
  %t21 = call i64 @sailfin_runtime_string_length(i8* %t20)
  %t22 = icmp eq i64 %t21, 0
  %t23 = load double, double* %l0
  %t24 = load double, double* %l1
  %t25 = load i8*, i8** %l2
  br i1 %t22, label %then4, label %merge5
then4:
  ret i8* null
merge5:
  %t26 = load i8*, i8** %l2
  %t27 = call i1 @is_struct_literal_type_candidate(i8* %t26)
  %t28 = xor i1 %t27, 1
  %t29 = load double, double* %l0
  %t30 = load double, double* %l1
  %t31 = load i8*, i8** %l2
  br i1 %t28, label %then6, label %merge7
then6:
  ret i8* null
merge7:
  %t32 = load double, double* %l0
  %t33 = sitofp i64 1 to double
  %t34 = fadd double %t32, %t33
  %t35 = load double, double* %l1
  %t36 = fptosi double %t34 to i64
  %t37 = fptosi double %t35 to i64
  %t38 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t36, i64 %t37)
  store i8* %t38, i8** %l3
  %t39 = load i8*, i8** %l3
  %t40 = call { i8**, i64 }* @split_struct_field_entries(i8* %t39)
  store { i8**, i64 }* %t40, { i8**, i64 }** %l4
  %t41 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t42 = ptrtoint [0 x i8*]* %t41 to i64
  %t43 = icmp eq i64 %t42, 0
  %t44 = select i1 %t43, i64 1, i64 %t42
  %t45 = call i8* @malloc(i64 %t44)
  %t46 = bitcast i8* %t45 to i8**
  %t47 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t48 = ptrtoint { i8**, i64 }* %t47 to i64
  %t49 = call i8* @malloc(i64 %t48)
  %t50 = bitcast i8* %t49 to { i8**, i64 }*
  %t51 = getelementptr { i8**, i64 }, { i8**, i64 }* %t50, i32 0, i32 0
  store i8** %t46, i8*** %t51
  %t52 = getelementptr { i8**, i64 }, { i8**, i64 }* %t50, i32 0, i32 1
  store i64 0, i64* %t52
  store { i8**, i64 }* %t50, { i8**, i64 }** %l5
  %t53 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t54 = ptrtoint [0 x i8*]* %t53 to i64
  %t55 = icmp eq i64 %t54, 0
  %t56 = select i1 %t55, i64 1, i64 %t54
  %t57 = call i8* @malloc(i64 %t56)
  %t58 = bitcast i8* %t57 to i8**
  %t59 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t60 = ptrtoint { i8**, i64 }* %t59 to i64
  %t61 = call i8* @malloc(i64 %t60)
  %t62 = bitcast i8* %t61 to { i8**, i64 }*
  %t63 = getelementptr { i8**, i64 }, { i8**, i64 }* %t62, i32 0, i32 0
  store i8** %t58, i8*** %t63
  %t64 = getelementptr { i8**, i64 }, { i8**, i64 }* %t62, i32 0, i32 1
  store i64 0, i64* %t64
  store { i8**, i64 }* %t62, { i8**, i64 }** %l6
  %t65 = sitofp i64 0 to double
  store double %t65, double* %l7
  %t66 = load double, double* %l0
  %t67 = load double, double* %l1
  %t68 = load i8*, i8** %l2
  %t69 = load i8*, i8** %l3
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t73 = load double, double* %l7
  br label %loop.header8
loop.header8:
  %t204 = phi double [ %t73, %merge7 ], [ %t201, %loop.latch10 ]
  %t205 = phi { i8**, i64 }* [ %t71, %merge7 ], [ %t202, %loop.latch10 ]
  %t206 = phi { i8**, i64 }* [ %t72, %merge7 ], [ %t203, %loop.latch10 ]
  store double %t204, double* %l7
  store { i8**, i64 }* %t205, { i8**, i64 }** %l5
  store { i8**, i64 }* %t206, { i8**, i64 }** %l6
  br label %loop.body9
loop.body9:
  %t74 = load double, double* %l7
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t76 = load { i8**, i64 }, { i8**, i64 }* %t75
  %t77 = extractvalue { i8**, i64 } %t76, 1
  %t78 = sitofp i64 %t77 to double
  %t79 = fcmp oge double %t74, %t78
  %t80 = load double, double* %l0
  %t81 = load double, double* %l1
  %t82 = load i8*, i8** %l2
  %t83 = load i8*, i8** %l3
  %t84 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t86 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t87 = load double, double* %l7
  br i1 %t79, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t89 = load double, double* %l7
  %t90 = fptosi double %t89 to i64
  %t91 = load { i8**, i64 }, { i8**, i64 }* %t88
  %t92 = extractvalue { i8**, i64 } %t91, 0
  %t93 = extractvalue { i8**, i64 } %t91, 1
  %t94 = icmp uge i64 %t90, %t93
  ; bounds check: %t94 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t90, i64 %t93)
  %t95 = getelementptr i8*, i8** %t92, i64 %t90
  %t96 = load i8*, i8** %t95
  %t97 = call i8* @trim_text(i8* %t96)
  %t98 = call i8* @trim_trailing_delimiters(i8* %t97)
  store i8* %t98, i8** %l8
  %t99 = load i8*, i8** %l8
  %t100 = call i64 @sailfin_runtime_string_length(i8* %t99)
  %t101 = icmp eq i64 %t100, 0
  %t102 = load double, double* %l0
  %t103 = load double, double* %l1
  %t104 = load i8*, i8** %l2
  %t105 = load i8*, i8** %l3
  %t106 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t107 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t108 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t109 = load double, double* %l7
  %t110 = load i8*, i8** %l8
  br i1 %t101, label %then14, label %merge15
then14:
  %t111 = load double, double* %l7
  %t112 = sitofp i64 1 to double
  %t113 = fadd double %t111, %t112
  store double %t113, double* %l7
  br label %loop.latch10
merge15:
  %t114 = load i8*, i8** %l8
  %t115 = alloca [2 x i8], align 1
  %t116 = getelementptr [2 x i8], [2 x i8]* %t115, i32 0, i32 0
  store i8 58, i8* %t116
  %t117 = getelementptr [2 x i8], [2 x i8]* %t115, i32 0, i32 1
  store i8 0, i8* %t117
  %t118 = getelementptr [2 x i8], [2 x i8]* %t115, i32 0, i32 0
  %t119 = call double @index_of(i8* %t114, i8* %t118)
  store double %t119, double* %l9
  %t120 = load double, double* %l9
  %t121 = sitofp i64 0 to double
  %t122 = fcmp olt double %t120, %t121
  %t123 = load double, double* %l0
  %t124 = load double, double* %l1
  %t125 = load i8*, i8** %l2
  %t126 = load i8*, i8** %l3
  %t127 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t128 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t129 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t130 = load double, double* %l7
  %t131 = load i8*, i8** %l8
  %t132 = load double, double* %l9
  br i1 %t122, label %then16, label %merge17
then16:
  %t133 = load double, double* %l7
  %t134 = sitofp i64 1 to double
  %t135 = fadd double %t133, %t134
  store double %t135, double* %l7
  br label %loop.latch10
merge17:
  %t136 = load i8*, i8** %l8
  %t137 = load double, double* %l9
  %t138 = fptosi double %t137 to i64
  %t139 = call i8* @sailfin_runtime_substring(i8* %t136, i64 0, i64 %t138)
  %t140 = call i8* @trim_text(i8* %t139)
  store i8* %t140, i8** %l10
  %t141 = load i8*, i8** %l8
  %t142 = load double, double* %l9
  %t143 = sitofp i64 1 to double
  %t144 = fadd double %t142, %t143
  %t145 = load i8*, i8** %l8
  %t146 = call i64 @sailfin_runtime_string_length(i8* %t145)
  %t147 = fptosi double %t144 to i64
  %t148 = call i8* @sailfin_runtime_substring(i8* %t141, i64 %t147, i64 %t146)
  %t149 = call i8* @trim_text(i8* %t148)
  store i8* %t149, i8** %l11
  %t150 = load i8*, i8** %l10
  %t151 = call i64 @sailfin_runtime_string_length(i8* %t150)
  %t152 = icmp eq i64 %t151, 0
  %t153 = load double, double* %l0
  %t154 = load double, double* %l1
  %t155 = load i8*, i8** %l2
  %t156 = load i8*, i8** %l3
  %t157 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t158 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t159 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t160 = load double, double* %l7
  %t161 = load i8*, i8** %l8
  %t162 = load double, double* %l9
  %t163 = load i8*, i8** %l10
  %t164 = load i8*, i8** %l11
  br i1 %t152, label %then18, label %merge19
then18:
  %t165 = load double, double* %l7
  %t166 = sitofp i64 1 to double
  %t167 = fadd double %t165, %t166
  store double %t167, double* %l7
  br label %loop.latch10
merge19:
  %t168 = load i8*, i8** %l11
  %t169 = sitofp i64 1 to double
  %t170 = fadd double %depth, %t169
  %t171 = call i8* @lower_expression_with_depth(i8* %t168, double %t170)
  store i8* %t171, i8** %l12
  %t172 = load i8*, i8** %l10
  %t173 = call i8* @sanitize_identifier(i8* %t172)
  store i8* %t173, i8** %l13
  %t174 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t175 = load i8*, i8** %l13
  %t176 = alloca [2 x i8], align 1
  %t177 = getelementptr [2 x i8], [2 x i8]* %t176, i32 0, i32 0
  store i8 61, i8* %t177
  %t178 = getelementptr [2 x i8], [2 x i8]* %t176, i32 0, i32 1
  store i8 0, i8* %t178
  %t179 = getelementptr [2 x i8], [2 x i8]* %t176, i32 0, i32 0
  %t180 = call i8* @sailfin_runtime_string_concat(i8* %t175, i8* %t179)
  %t181 = load i8*, i8** %l12
  %t182 = call i8* @sailfin_runtime_string_concat(i8* %t180, i8* %t181)
  %t183 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t174, i8* %t182)
  store { i8**, i64 }* %t183, { i8**, i64 }** %l5
  %t184 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %s185 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h728584192, i32 0, i32 0
  %t186 = load i8*, i8** %l13
  %t187 = call i8* @sailfin_runtime_string_concat(i8* %s185, i8* %t186)
  %s188 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087924125, i32 0, i32 0
  %t189 = call i8* @sailfin_runtime_string_concat(i8* %t187, i8* %s188)
  %t190 = load i8*, i8** %l12
  %t191 = call i8* @sailfin_runtime_string_concat(i8* %t189, i8* %t190)
  %t192 = alloca [2 x i8], align 1
  %t193 = getelementptr [2 x i8], [2 x i8]* %t192, i32 0, i32 0
  store i8 41, i8* %t193
  %t194 = getelementptr [2 x i8], [2 x i8]* %t192, i32 0, i32 1
  store i8 0, i8* %t194
  %t195 = getelementptr [2 x i8], [2 x i8]* %t192, i32 0, i32 0
  %t196 = call i8* @sailfin_runtime_string_concat(i8* %t191, i8* %t195)
  %t197 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t184, i8* %t196)
  store { i8**, i64 }* %t197, { i8**, i64 }** %l6
  %t198 = load double, double* %l7
  %t199 = sitofp i64 1 to double
  %t200 = fadd double %t198, %t199
  store double %t200, double* %l7
  br label %loop.latch10
loop.latch10:
  %t201 = load double, double* %l7
  %t202 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t203 = load { i8**, i64 }*, { i8**, i64 }** %l6
  br label %loop.header8
afterloop11:
  %t207 = load double, double* %l7
  %t208 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t209 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t210 = load i8*, i8** %l2
  %t211 = call i8* @sanitize_qualified_identifier(i8* %t210)
  store i8* %t211, i8** %l14
  %t212 = sitofp i64 -1 to double
  store double %t212, double* %l15
  %t213 = sitofp i64 0 to double
  store double %t213, double* %l7
  %t214 = load double, double* %l0
  %t215 = load double, double* %l1
  %t216 = load i8*, i8** %l2
  %t217 = load i8*, i8** %l3
  %t218 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t219 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t220 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t221 = load double, double* %l7
  %t222 = load i8*, i8** %l14
  %t223 = load double, double* %l15
  br label %loop.header20
loop.header20:
  %t262 = phi double [ %t223, %afterloop11 ], [ %t260, %loop.latch22 ]
  %t263 = phi double [ %t221, %afterloop11 ], [ %t261, %loop.latch22 ]
  store double %t262, double* %l15
  store double %t263, double* %l7
  br label %loop.body21
loop.body21:
  %t224 = load double, double* %l7
  %t225 = load i8*, i8** %l14
  %t226 = call i64 @sailfin_runtime_string_length(i8* %t225)
  %t227 = sitofp i64 %t226 to double
  %t228 = fcmp oge double %t224, %t227
  %t229 = load double, double* %l0
  %t230 = load double, double* %l1
  %t231 = load i8*, i8** %l2
  %t232 = load i8*, i8** %l3
  %t233 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t234 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t235 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t236 = load double, double* %l7
  %t237 = load i8*, i8** %l14
  %t238 = load double, double* %l15
  br i1 %t228, label %then24, label %merge25
then24:
  br label %afterloop23
merge25:
  %t239 = load i8*, i8** %l14
  %t240 = load double, double* %l7
  %t241 = call i8* @char_at(i8* %t239, double %t240)
  %t242 = load i8, i8* %t241
  %t243 = icmp eq i8 %t242, 46
  %t244 = load double, double* %l0
  %t245 = load double, double* %l1
  %t246 = load i8*, i8** %l2
  %t247 = load i8*, i8** %l3
  %t248 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t249 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t250 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t251 = load double, double* %l7
  %t252 = load i8*, i8** %l14
  %t253 = load double, double* %l15
  br i1 %t243, label %then26, label %merge27
then26:
  %t254 = load double, double* %l7
  store double %t254, double* %l15
  %t255 = load double, double* %l15
  br label %merge27
merge27:
  %t256 = phi double [ %t255, %then26 ], [ %t253, %merge25 ]
  store double %t256, double* %l15
  %t257 = load double, double* %l7
  %t258 = sitofp i64 1 to double
  %t259 = fadd double %t257, %t258
  store double %t259, double* %l7
  br label %loop.latch22
loop.latch22:
  %t260 = load double, double* %l15
  %t261 = load double, double* %l7
  br label %loop.header20
afterloop23:
  %t264 = load double, double* %l15
  %t265 = load double, double* %l7
  %t266 = load double, double* %l15
  %t267 = sitofp i64 0 to double
  %t268 = fcmp oge double %t266, %t267
  %t269 = load double, double* %l0
  %t270 = load double, double* %l1
  %t271 = load i8*, i8** %l2
  %t272 = load i8*, i8** %l3
  %t273 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t274 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t275 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t276 = load double, double* %l7
  %t277 = load i8*, i8** %l14
  %t278 = load double, double* %l15
  br i1 %t268, label %then28, label %merge29
then28:
  %t279 = load i8*, i8** %l14
  %t280 = load double, double* %l15
  %t281 = fptosi double %t280 to i64
  %t282 = call i8* @sailfin_runtime_substring(i8* %t279, i64 0, i64 %t281)
  store i8* %t282, i8** %l16
  %t283 = load i8*, i8** %l14
  %t284 = load double, double* %l15
  %t285 = sitofp i64 1 to double
  %t286 = fadd double %t284, %t285
  %t287 = load i8*, i8** %l14
  %t288 = call i64 @sailfin_runtime_string_length(i8* %t287)
  %t289 = fptosi double %t286 to i64
  %t290 = call i8* @sailfin_runtime_substring(i8* %t283, i64 %t289, i64 %t288)
  store i8* %t290, i8** %l17
  %t291 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %s292 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t293 = call i8* @join_with_separator({ i8**, i64 }* %t291, i8* %s292)
  %t294 = alloca [2 x i8], align 1
  %t295 = getelementptr [2 x i8], [2 x i8]* %t294, i32 0, i32 0
  store i8 91, i8* %t295
  %t296 = getelementptr [2 x i8], [2 x i8]* %t294, i32 0, i32 1
  store i8 0, i8* %t296
  %t297 = getelementptr [2 x i8], [2 x i8]* %t294, i32 0, i32 0
  %t298 = call i8* @sailfin_runtime_string_concat(i8* %t297, i8* %t293)
  %t299 = alloca [2 x i8], align 1
  %t300 = getelementptr [2 x i8], [2 x i8]* %t299, i32 0, i32 0
  store i8 93, i8* %t300
  %t301 = getelementptr [2 x i8], [2 x i8]* %t299, i32 0, i32 1
  store i8 0, i8* %t301
  %t302 = getelementptr [2 x i8], [2 x i8]* %t299, i32 0, i32 0
  %t303 = call i8* @sailfin_runtime_string_concat(i8* %t298, i8* %t302)
  store i8* %t303, i8** %l18
  %s304 = getelementptr inbounds [26 x i8], [26 x i8]* @.str.len25.h117462910, i32 0, i32 0
  %t305 = load i8*, i8** %l16
  %t306 = call i8* @sailfin_runtime_string_concat(i8* %s304, i8* %t305)
  %s307 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2088090973, i32 0, i32 0
  %t308 = call i8* @sailfin_runtime_string_concat(i8* %t306, i8* %s307)
  %t309 = load i8*, i8** %l17
  %t310 = call i8* @sailfin_runtime_string_concat(i8* %t308, i8* %t309)
  %s311 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087924125, i32 0, i32 0
  %t312 = call i8* @sailfin_runtime_string_concat(i8* %t310, i8* %s311)
  %t313 = load i8*, i8** %l18
  %t314 = call i8* @sailfin_runtime_string_concat(i8* %t312, i8* %t313)
  %t315 = alloca [2 x i8], align 1
  %t316 = getelementptr [2 x i8], [2 x i8]* %t315, i32 0, i32 0
  store i8 41, i8* %t316
  %t317 = getelementptr [2 x i8], [2 x i8]* %t315, i32 0, i32 1
  store i8 0, i8* %t317
  %t318 = getelementptr [2 x i8], [2 x i8]* %t315, i32 0, i32 0
  %t319 = call i8* @sailfin_runtime_string_concat(i8* %t314, i8* %t318)
  ret i8* %t319
merge29:
  %t320 = load i8*, i8** %l14
  %t321 = alloca [2 x i8], align 1
  %t322 = getelementptr [2 x i8], [2 x i8]* %t321, i32 0, i32 0
  store i8 40, i8* %t322
  %t323 = getelementptr [2 x i8], [2 x i8]* %t321, i32 0, i32 1
  store i8 0, i8* %t323
  %t324 = getelementptr [2 x i8], [2 x i8]* %t321, i32 0, i32 0
  %t325 = call i8* @sailfin_runtime_string_concat(i8* %t320, i8* %t324)
  %t326 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %s327 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t328 = call i8* @join_with_separator({ i8**, i64 }* %t326, i8* %s327)
  %t329 = call i8* @sailfin_runtime_string_concat(i8* %t325, i8* %t328)
  %t330 = alloca [2 x i8], align 1
  %t331 = getelementptr [2 x i8], [2 x i8]* %t330, i32 0, i32 0
  store i8 41, i8* %t331
  %t332 = getelementptr [2 x i8], [2 x i8]* %t330, i32 0, i32 1
  store i8 0, i8* %t332
  %t333 = getelementptr [2 x i8], [2 x i8]* %t330, i32 0, i32 0
  %t334 = call i8* @sailfin_runtime_string_concat(i8* %t329, i8* %t333)
  ret i8* %t334
}

define i1 @is_struct_literal_type_candidate(i8* %text) {
block.entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  ret i1 0
merge1:
  %t2 = sitofp i64 0 to double
  store double %t2, double* %l0
  %t3 = load double, double* %l0
  br label %loop.header2
loop.header2:
  %t32 = phi double [ %t3, %merge1 ], [ %t31, %loop.latch4 ]
  store double %t32, double* %l0
  br label %loop.body3
loop.body3:
  %t4 = load double, double* %l0
  %t5 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp oge double %t4, %t6
  %t8 = load double, double* %l0
  br i1 %t7, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t9 = load double, double* %l0
  %t10 = load double, double* %l0
  %t11 = sitofp i64 1 to double
  %t12 = fadd double %t10, %t11
  %t13 = fptosi double %t9 to i64
  %t14 = fptosi double %t12 to i64
  %t15 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t13, i64 %t14)
  store i8* %t15, i8** %l1
  %t16 = load i8*, i8** %l1
  %t17 = load i8, i8* %t16
  %t18 = icmp eq i8 %t17, 46
  %t19 = load double, double* %l0
  %t20 = load i8*, i8** %l1
  br i1 %t18, label %then8, label %merge9
then8:
  %t21 = load double, double* %l0
  %t22 = sitofp i64 1 to double
  %t23 = fadd double %t21, %t22
  store double %t23, double* %l0
  br label %loop.latch4
merge9:
  %t24 = load i8*, i8** %l1
  %t25 = call i1 @is_identifier_char(i8* %t24)
  %t26 = load double, double* %l0
  %t27 = load i8*, i8** %l1
  br i1 %t25, label %then10, label %merge11
then10:
  %t28 = load double, double* %l0
  %t29 = sitofp i64 1 to double
  %t30 = fadd double %t28, %t29
  store double %t30, double* %l0
  br label %loop.latch4
merge11:
  ret i1 0
loop.latch4:
  %t31 = load double, double* %l0
  br label %loop.header2
afterloop5:
  %t33 = load double, double* %l0
  ret i1 1
}

define i8* @lower_array_literal_expression(i8* %expression, double %depth) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i64
  %l2 = alloca i8*
  %l3 = alloca { i8**, i64 }*
  %l4 = alloca { i8**, i64 }*
  %l5 = alloca double
  %l6 = alloca i8*
  %l7 = alloca i8*
  %t0 = call i8* @trim_text(i8* %expression)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp slt i64 %t2, 2
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  ret i8* null
merge1:
  %t5 = load i8*, i8** %l0
  %t6 = call i8* @sailfin_runtime_substring(i8* %t5, i64 0, i64 1)
  %t7 = load i8, i8* %t6
  %t8 = icmp ne i8 %t7, 91
  %t9 = load i8*, i8** %l0
  br i1 %t8, label %then2, label %merge3
then2:
  ret i8* null
merge3:
  %t10 = load i8*, i8** %l0
  %t11 = call i64 @sailfin_runtime_string_length(i8* %t10)
  %t12 = sub i64 %t11, 1
  store i64 %t12, i64* %l1
  %t13 = load i8*, i8** %l0
  %t14 = load i64, i64* %l1
  %t15 = load i64, i64* %l1
  %t16 = add i64 %t15, 1
  %t17 = call i8* @sailfin_runtime_substring(i8* %t13, i64 %t14, i64 %t16)
  %t18 = load i8, i8* %t17
  %t19 = icmp ne i8 %t18, 93
  %t20 = load i8*, i8** %l0
  %t21 = load i64, i64* %l1
  br i1 %t19, label %then4, label %merge5
then4:
  ret i8* null
merge5:
  %t22 = load i8*, i8** %l0
  %t23 = load i8*, i8** %l0
  %t24 = call i64 @sailfin_runtime_string_length(i8* %t23)
  %t25 = sub i64 %t24, 1
  %t26 = call i8* @sailfin_runtime_substring(i8* %t22, i64 1, i64 %t25)
  store i8* %t26, i8** %l2
  %t27 = load i8*, i8** %l2
  %t28 = call { i8**, i64 }* @split_array_entries(i8* %t27)
  store { i8**, i64 }* %t28, { i8**, i64 }** %l3
  %t29 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t30 = ptrtoint [0 x i8*]* %t29 to i64
  %t31 = icmp eq i64 %t30, 0
  %t32 = select i1 %t31, i64 1, i64 %t30
  %t33 = call i8* @malloc(i64 %t32)
  %t34 = bitcast i8* %t33 to i8**
  %t35 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t36 = ptrtoint { i8**, i64 }* %t35 to i64
  %t37 = call i8* @malloc(i64 %t36)
  %t38 = bitcast i8* %t37 to { i8**, i64 }*
  %t39 = getelementptr { i8**, i64 }, { i8**, i64 }* %t38, i32 0, i32 0
  store i8** %t34, i8*** %t39
  %t40 = getelementptr { i8**, i64 }, { i8**, i64 }* %t38, i32 0, i32 1
  store i64 0, i64* %t40
  store { i8**, i64 }* %t38, { i8**, i64 }** %l4
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t42 = call double @array_literal_start_index({ i8**, i64 }* %t41)
  store double %t42, double* %l5
  %t43 = load i8*, i8** %l0
  %t44 = load i64, i64* %l1
  %t45 = load i8*, i8** %l2
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t48 = load double, double* %l5
  br label %loop.header6
loop.header6:
  %t95 = phi { i8**, i64 }* [ %t47, %merge5 ], [ %t93, %loop.latch8 ]
  %t96 = phi double [ %t48, %merge5 ], [ %t94, %loop.latch8 ]
  store { i8**, i64 }* %t95, { i8**, i64 }** %l4
  store double %t96, double* %l5
  br label %loop.body7
loop.body7:
  %t49 = load double, double* %l5
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t51 = load { i8**, i64 }, { i8**, i64 }* %t50
  %t52 = extractvalue { i8**, i64 } %t51, 1
  %t53 = sitofp i64 %t52 to double
  %t54 = fcmp oge double %t49, %t53
  %t55 = load i8*, i8** %l0
  %t56 = load i64, i64* %l1
  %t57 = load i8*, i8** %l2
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t60 = load double, double* %l5
  br i1 %t54, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t62 = load double, double* %l5
  %t63 = fptosi double %t62 to i64
  %t64 = load { i8**, i64 }, { i8**, i64 }* %t61
  %t65 = extractvalue { i8**, i64 } %t64, 0
  %t66 = extractvalue { i8**, i64 } %t64, 1
  %t67 = icmp uge i64 %t63, %t66
  ; bounds check: %t67 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t63, i64 %t66)
  %t68 = getelementptr i8*, i8** %t65, i64 %t63
  %t69 = load i8*, i8** %t68
  %t70 = call i8* @trim_text(i8* %t69)
  %t71 = call i8* @trim_trailing_delimiters(i8* %t70)
  store i8* %t71, i8** %l6
  %t72 = load i8*, i8** %l6
  %t73 = call i64 @sailfin_runtime_string_length(i8* %t72)
  %t74 = icmp sgt i64 %t73, 0
  %t75 = load i8*, i8** %l0
  %t76 = load i64, i64* %l1
  %t77 = load i8*, i8** %l2
  %t78 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t80 = load double, double* %l5
  %t81 = load i8*, i8** %l6
  br i1 %t74, label %then12, label %merge13
then12:
  %t82 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t83 = load i8*, i8** %l6
  %t84 = sitofp i64 1 to double
  %t85 = fadd double %depth, %t84
  %t86 = call i8* @lower_expression_with_depth(i8* %t83, double %t85)
  %t87 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t82, i8* %t86)
  store { i8**, i64 }* %t87, { i8**, i64 }** %l4
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l4
  br label %merge13
merge13:
  %t89 = phi { i8**, i64 }* [ %t88, %then12 ], [ %t79, %merge11 ]
  store { i8**, i64 }* %t89, { i8**, i64 }** %l4
  %t90 = load double, double* %l5
  %t91 = sitofp i64 1 to double
  %t92 = fadd double %t90, %t91
  store double %t92, double* %l5
  br label %loop.latch8
loop.latch8:
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t94 = load double, double* %l5
  br label %loop.header6
afterloop9:
  %t97 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t98 = load double, double* %l5
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t100 = load { i8**, i64 }, { i8**, i64 }* %t99
  %t101 = extractvalue { i8**, i64 } %t100, 1
  %t102 = icmp eq i64 %t101, 0
  %t103 = load i8*, i8** %l0
  %t104 = load i64, i64* %l1
  %t105 = load i8*, i8** %l2
  %t106 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t107 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t108 = load double, double* %l5
  br i1 %t102, label %then14, label %merge15
then14:
  %s109 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193479167, i32 0, i32 0
  ret i8* %s109
merge15:
  %t110 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %s111 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t112 = call i8* @join_with_separator({ i8**, i64 }* %t110, i8* %s111)
  store i8* %t112, i8** %l7
  %t113 = load i8*, i8** %l7
  %t114 = alloca [2 x i8], align 1
  %t115 = getelementptr [2 x i8], [2 x i8]* %t114, i32 0, i32 0
  store i8 91, i8* %t115
  %t116 = getelementptr [2 x i8], [2 x i8]* %t114, i32 0, i32 1
  store i8 0, i8* %t116
  %t117 = getelementptr [2 x i8], [2 x i8]* %t114, i32 0, i32 0
  %t118 = call i8* @sailfin_runtime_string_concat(i8* %t117, i8* %t113)
  %t119 = alloca [2 x i8], align 1
  %t120 = getelementptr [2 x i8], [2 x i8]* %t119, i32 0, i32 0
  store i8 93, i8* %t120
  %t121 = getelementptr [2 x i8], [2 x i8]* %t119, i32 0, i32 1
  store i8 0, i8* %t121
  %t122 = getelementptr [2 x i8], [2 x i8]* %t119, i32 0, i32 0
  %t123 = call i8* @sailfin_runtime_string_concat(i8* %t118, i8* %t122)
  ret i8* %t123
}

define double @array_literal_start_index({ i8**, i64 }* %entries) {
block.entry:
  %l0 = alloca i8*
  %t0 = load { i8**, i64 }, { i8**, i64 }* %entries
  %t1 = extractvalue { i8**, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  %t3 = sitofp i64 0 to double
  ret double %t3
merge1:
  %t4 = load { i8**, i64 }, { i8**, i64 }* %entries
  %t5 = extractvalue { i8**, i64 } %t4, 0
  %t6 = extractvalue { i8**, i64 } %t4, 1
  %t7 = icmp uge i64 0, %t6
  ; bounds check: %t7 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 0, i64 %t6)
  %t8 = getelementptr i8*, i8** %t5, i64 0
  %t9 = load i8*, i8** %t8
  %t10 = call i8* @trim_text(i8* %t9)
  %t11 = call i8* @trim_trailing_delimiters(i8* %t10)
  store i8* %t11, i8** %l0
  %t12 = load i8*, i8** %l0
  %t13 = call i1 @is_array_metadata_entry(i8* %t12)
  %t14 = load i8*, i8** %l0
  br i1 %t13, label %then2, label %merge3
then2:
  %t15 = sitofp i64 1 to double
  ret double %t15
merge3:
  %t16 = sitofp i64 0 to double
  ret double %t16
}

define i1 @is_array_metadata_entry(i8* %entry) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %t0 = call i8* @trim_text(i8* %entry)
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
  %s6 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h757580446, i32 0, i32 0
  %t7 = call i1 @starts_with(i8* %t5, i8* %s6)
  %t8 = xor i1 %t7, 1
  %t9 = load i8*, i8** %l0
  br i1 %t8, label %then2, label %merge3
then2:
  ret i1 0
merge3:
  %t10 = load i8*, i8** %l0
  %t11 = load i8*, i8** %l0
  %t12 = call i64 @sailfin_runtime_string_length(i8* %t11)
  %t13 = call i8* @sailfin_runtime_substring(i8* %t10, i64 9, i64 %t12)
  %t14 = call i8* @trim_text(i8* %t13)
  store i8* %t14, i8** %l1
  %t15 = load i8*, i8** %l1
  %t16 = call i64 @sailfin_runtime_string_length(i8* %t15)
  %t17 = icmp sgt i64 %t16, 0
  ret i1 %t17
}

define i8* @rewrite_array_literals_inline(i8* %expression, double %depth) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca i8*
  %l6 = alloca i8*
  %l7 = alloca i8*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  ret i8* %expression
merge1:
  store i8* %expression, i8** %l0
  %t2 = sitofp i64 0 to double
  store double %t2, double* %l1
  %t3 = load i8*, i8** %l0
  %t4 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t78 = phi double [ %t4, %merge1 ], [ %t76, %loop.latch4 ]
  %t79 = phi i8* [ %t3, %merge1 ], [ %t77, %loop.latch4 ]
  store double %t78, double* %l1
  store i8* %t79, i8** %l0
  br label %loop.body3
loop.body3:
  %t5 = load double, double* %l1
  %t6 = load i8*, i8** %l0
  %t7 = call i64 @sailfin_runtime_string_length(i8* %t6)
  %t8 = sitofp i64 %t7 to double
  %t9 = fcmp oge double %t5, %t8
  %t10 = load i8*, i8** %l0
  %t11 = load double, double* %l1
  br i1 %t9, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t12 = load i8*, i8** %l0
  %t13 = load double, double* %l1
  %t14 = call double @find_next_square_open(i8* %t12, double %t13)
  store double %t14, double* %l2
  %t15 = load double, double* %l2
  %t16 = sitofp i64 0 to double
  %t17 = fcmp olt double %t15, %t16
  %t18 = load i8*, i8** %l0
  %t19 = load double, double* %l1
  %t20 = load double, double* %l2
  br i1 %t17, label %then8, label %merge9
then8:
  br label %afterloop5
merge9:
  %t21 = load i8*, i8** %l0
  %t22 = load double, double* %l2
  %t23 = call double @find_matching_square(i8* %t21, double %t22)
  store double %t23, double* %l3
  %t24 = load double, double* %l3
  %t25 = sitofp i64 0 to double
  %t26 = fcmp olt double %t24, %t25
  %t27 = load i8*, i8** %l0
  %t28 = load double, double* %l1
  %t29 = load double, double* %l2
  %t30 = load double, double* %l3
  br i1 %t26, label %then10, label %merge11
then10:
  br label %afterloop5
merge11:
  %t31 = load i8*, i8** %l0
  %t32 = load double, double* %l2
  %t33 = load double, double* %l3
  %t34 = sitofp i64 1 to double
  %t35 = fadd double %t33, %t34
  %t36 = fptosi double %t32 to i64
  %t37 = fptosi double %t35 to i64
  %t38 = call i8* @sailfin_runtime_substring(i8* %t31, i64 %t36, i64 %t37)
  store i8* %t38, i8** %l4
  %t39 = load i8*, i8** %l4
  %t40 = sitofp i64 1 to double
  %t41 = fadd double %depth, %t40
  %t42 = call i8* @lower_array_literal_expression(i8* %t39, double %t41)
  store i8* %t42, i8** %l5
  %t43 = load i8*, i8** %l5
  %t44 = icmp eq i8* %t43, null
  %t45 = load i8*, i8** %l0
  %t46 = load double, double* %l1
  %t47 = load double, double* %l2
  %t48 = load double, double* %l3
  %t49 = load i8*, i8** %l4
  %t50 = load i8*, i8** %l5
  br i1 %t44, label %then12, label %merge13
then12:
  %t51 = load double, double* %l2
  %t52 = sitofp i64 1 to double
  %t53 = fadd double %t51, %t52
  store double %t53, double* %l1
  br label %loop.latch4
merge13:
  %t54 = load i8*, i8** %l0
  %t55 = load double, double* %l2
  %t56 = fptosi double %t55 to i64
  %t57 = call i8* @sailfin_runtime_substring(i8* %t54, i64 0, i64 %t56)
  store i8* %t57, i8** %l6
  %t58 = load i8*, i8** %l0
  %t59 = load double, double* %l3
  %t60 = sitofp i64 1 to double
  %t61 = fadd double %t59, %t60
  %t62 = load i8*, i8** %l0
  %t63 = call i64 @sailfin_runtime_string_length(i8* %t62)
  %t64 = fptosi double %t61 to i64
  %t65 = call i8* @sailfin_runtime_substring(i8* %t58, i64 %t64, i64 %t63)
  store i8* %t65, i8** %l7
  %t66 = load i8*, i8** %l6
  %t67 = load i8*, i8** %l5
  %t68 = call i8* @sailfin_runtime_string_concat(i8* %t66, i8* %t67)
  %t69 = load i8*, i8** %l7
  %t70 = call i8* @sailfin_runtime_string_concat(i8* %t68, i8* %t69)
  store i8* %t70, i8** %l0
  %t71 = load double, double* %l2
  %t72 = load i8*, i8** %l5
  %t73 = call i64 @sailfin_runtime_string_length(i8* %t72)
  %t74 = sitofp i64 %t73 to double
  %t75 = fadd double %t71, %t74
  store double %t75, double* %l1
  br label %loop.latch4
loop.latch4:
  %t76 = load double, double* %l1
  %t77 = load i8*, i8** %l0
  br label %loop.header2
afterloop5:
  %t80 = load double, double* %l1
  %t81 = load i8*, i8** %l0
  %t82 = load i8*, i8** %l0
  ret i8* %t82
}

define i8* @rewrite_struct_literals_inline(i8* %expression, double %depth) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca double
  %l6 = alloca i8*
  %l7 = alloca i8*
  %l8 = alloca i8*
  %l9 = alloca double
  %l10 = alloca i8*
  %l11 = alloca i8*
  %l12 = alloca i8*
  %l13 = alloca i8*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  ret i8* %expression
merge1:
  store i8* %expression, i8** %l0
  %t2 = sitofp i64 0 to double
  store double %t2, double* %l1
  %t3 = load i8*, i8** %l0
  %t4 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t234 = phi double [ %t4, %merge1 ], [ %t232, %loop.latch4 ]
  %t235 = phi i8* [ %t3, %merge1 ], [ %t233, %loop.latch4 ]
  store double %t234, double* %l1
  store i8* %t235, i8** %l0
  br label %loop.body3
loop.body3:
  %t5 = load double, double* %l1
  %t6 = load i8*, i8** %l0
  %t7 = call i64 @sailfin_runtime_string_length(i8* %t6)
  %t8 = sitofp i64 %t7 to double
  %t9 = fcmp oge double %t5, %t8
  %t10 = load i8*, i8** %l0
  %t11 = load double, double* %l1
  br i1 %t9, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t12 = load i8*, i8** %l0
  %t13 = load double, double* %l1
  %t14 = alloca [2 x i8], align 1
  %t15 = getelementptr [2 x i8], [2 x i8]* %t14, i32 0, i32 0
  store i8 123, i8* %t15
  %t16 = getelementptr [2 x i8], [2 x i8]* %t14, i32 0, i32 1
  store i8 0, i8* %t16
  %t17 = getelementptr [2 x i8], [2 x i8]* %t14, i32 0, i32 0
  %t18 = call double @find_substring_from(i8* %t12, i8* %t17, double %t13)
  store double %t18, double* %l2
  %t19 = load double, double* %l2
  %t20 = sitofp i64 0 to double
  %t21 = fcmp olt double %t19, %t20
  %t22 = load i8*, i8** %l0
  %t23 = load double, double* %l1
  %t24 = load double, double* %l2
  br i1 %t21, label %then8, label %merge9
then8:
  br label %afterloop5
merge9:
  %t25 = load double, double* %l2
  store double %t25, double* %l3
  %t26 = load i8*, i8** %l0
  %t27 = load double, double* %l1
  %t28 = load double, double* %l2
  %t29 = load double, double* %l3
  br label %loop.header10
loop.header10:
  %t56 = phi double [ %t29, %merge9 ], [ %t55, %loop.latch12 ]
  store double %t56, double* %l3
  br label %loop.body11
loop.body11:
  %t30 = load double, double* %l3
  %t31 = sitofp i64 0 to double
  %t32 = fcmp ole double %t30, %t31
  %t33 = load i8*, i8** %l0
  %t34 = load double, double* %l1
  %t35 = load double, double* %l2
  %t36 = load double, double* %l3
  br i1 %t32, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t37 = load i8*, i8** %l0
  %t38 = load double, double* %l3
  %t39 = sitofp i64 1 to double
  %t40 = fsub double %t38, %t39
  %t41 = load double, double* %l3
  %t42 = fptosi double %t40 to i64
  %t43 = fptosi double %t41 to i64
  %t44 = call i8* @sailfin_runtime_substring(i8* %t37, i64 %t42, i64 %t43)
  store i8* %t44, i8** %l4
  %t45 = load i8*, i8** %l4
  %t46 = call i1 @sailfin_runtime_is_whitespace_char(i8* %t45)
  %t47 = load i8*, i8** %l0
  %t48 = load double, double* %l1
  %t49 = load double, double* %l2
  %t50 = load double, double* %l3
  %t51 = load i8*, i8** %l4
  br i1 %t46, label %then16, label %merge17
then16:
  %t52 = load double, double* %l3
  %t53 = sitofp i64 1 to double
  %t54 = fsub double %t52, %t53
  store double %t54, double* %l3
  br label %loop.latch12
merge17:
  br label %afterloop13
loop.latch12:
  %t55 = load double, double* %l3
  br label %loop.header10
afterloop13:
  %t57 = load double, double* %l3
  %t58 = load double, double* %l3
  store double %t58, double* %l5
  %t59 = load i8*, i8** %l0
  %t60 = load double, double* %l1
  %t61 = load double, double* %l2
  %t62 = load double, double* %l3
  %t63 = load double, double* %l5
  br label %loop.header18
loop.header18:
  %t104 = phi double [ %t63, %afterloop13 ], [ %t103, %loop.latch20 ]
  store double %t104, double* %l5
  br label %loop.body19
loop.body19:
  %t64 = load double, double* %l5
  %t65 = sitofp i64 0 to double
  %t66 = fcmp ole double %t64, %t65
  %t67 = load i8*, i8** %l0
  %t68 = load double, double* %l1
  %t69 = load double, double* %l2
  %t70 = load double, double* %l3
  %t71 = load double, double* %l5
  br i1 %t66, label %then22, label %merge23
then22:
  br label %afterloop21
merge23:
  %t72 = load i8*, i8** %l0
  %t73 = load double, double* %l5
  %t74 = sitofp i64 1 to double
  %t75 = fsub double %t73, %t74
  %t76 = load double, double* %l5
  %t77 = fptosi double %t75 to i64
  %t78 = fptosi double %t76 to i64
  %t79 = call i8* @sailfin_runtime_substring(i8* %t72, i64 %t77, i64 %t78)
  store i8* %t79, i8** %l6
  %t80 = load i8*, i8** %l6
  %t81 = load i8, i8* %t80
  %t82 = icmp eq i8 %t81, 46
  %t83 = load i8*, i8** %l0
  %t84 = load double, double* %l1
  %t85 = load double, double* %l2
  %t86 = load double, double* %l3
  %t87 = load double, double* %l5
  %t88 = load i8*, i8** %l6
  br i1 %t82, label %then24, label %merge25
then24:
  %t89 = load double, double* %l5
  %t90 = sitofp i64 1 to double
  %t91 = fsub double %t89, %t90
  store double %t91, double* %l5
  br label %loop.latch20
merge25:
  %t92 = load i8*, i8** %l6
  %t93 = call i1 @is_identifier_char(i8* %t92)
  %t94 = load i8*, i8** %l0
  %t95 = load double, double* %l1
  %t96 = load double, double* %l2
  %t97 = load double, double* %l3
  %t98 = load double, double* %l5
  %t99 = load i8*, i8** %l6
  br i1 %t93, label %then26, label %merge27
then26:
  %t100 = load double, double* %l5
  %t101 = sitofp i64 1 to double
  %t102 = fsub double %t100, %t101
  store double %t102, double* %l5
  br label %loop.latch20
merge27:
  br label %afterloop21
loop.latch20:
  %t103 = load double, double* %l5
  br label %loop.header18
afterloop21:
  %t105 = load double, double* %l5
  %t106 = load double, double* %l5
  %t107 = load double, double* %l3
  %t108 = fcmp oeq double %t106, %t107
  %t109 = load i8*, i8** %l0
  %t110 = load double, double* %l1
  %t111 = load double, double* %l2
  %t112 = load double, double* %l3
  %t113 = load double, double* %l5
  br i1 %t108, label %then28, label %merge29
then28:
  %t114 = load double, double* %l2
  %t115 = sitofp i64 1 to double
  %t116 = fadd double %t114, %t115
  store double %t116, double* %l1
  br label %loop.latch4
merge29:
  %t117 = load i8*, i8** %l0
  %t118 = load double, double* %l5
  %t119 = load double, double* %l3
  %t120 = fptosi double %t118 to i64
  %t121 = fptosi double %t119 to i64
  %t122 = call i8* @sailfin_runtime_substring(i8* %t117, i64 %t120, i64 %t121)
  store i8* %t122, i8** %l7
  %t123 = load i8*, i8** %l7
  %t124 = call i1 @is_struct_literal_type_candidate(i8* %t123)
  %t125 = xor i1 %t124, 1
  %t126 = load i8*, i8** %l0
  %t127 = load double, double* %l1
  %t128 = load double, double* %l2
  %t129 = load double, double* %l3
  %t130 = load double, double* %l5
  %t131 = load i8*, i8** %l7
  br i1 %t125, label %then30, label %merge31
then30:
  %t132 = load double, double* %l2
  %t133 = sitofp i64 1 to double
  %t134 = fadd double %t132, %t133
  store double %t134, double* %l1
  br label %loop.latch4
merge31:
  %t135 = load double, double* %l5
  %t136 = sitofp i64 0 to double
  %t137 = fcmp ogt double %t135, %t136
  %t138 = load i8*, i8** %l0
  %t139 = load double, double* %l1
  %t140 = load double, double* %l2
  %t141 = load double, double* %l3
  %t142 = load double, double* %l5
  %t143 = load i8*, i8** %l7
  br i1 %t137, label %then32, label %merge33
then32:
  %t144 = load i8*, i8** %l0
  %t145 = load double, double* %l5
  %t146 = sitofp i64 1 to double
  %t147 = fsub double %t145, %t146
  %t148 = load double, double* %l5
  %t149 = fptosi double %t147 to i64
  %t150 = fptosi double %t148 to i64
  %t151 = call i8* @sailfin_runtime_substring(i8* %t144, i64 %t149, i64 %t150)
  store i8* %t151, i8** %l8
  %t153 = load i8*, i8** %l8
  %t154 = call i1 @is_identifier_char(i8* %t153)
  br label %logical_or_entry_152

logical_or_entry_152:
  br i1 %t154, label %logical_or_merge_152, label %logical_or_right_152

logical_or_right_152:
  %t155 = load i8*, i8** %l8
  %t156 = load i8, i8* %t155
  %t157 = icmp eq i8 %t156, 46
  br label %logical_or_right_end_152

logical_or_right_end_152:
  br label %logical_or_merge_152

logical_or_merge_152:
  %t158 = phi i1 [ true, %logical_or_entry_152 ], [ %t157, %logical_or_right_end_152 ]
  %t159 = load i8*, i8** %l0
  %t160 = load double, double* %l1
  %t161 = load double, double* %l2
  %t162 = load double, double* %l3
  %t163 = load double, double* %l5
  %t164 = load i8*, i8** %l7
  %t165 = load i8*, i8** %l8
  br i1 %t158, label %then34, label %merge35
then34:
  %t166 = load double, double* %l2
  %t167 = sitofp i64 1 to double
  %t168 = fadd double %t166, %t167
  store double %t168, double* %l1
  br label %loop.latch4
merge35:
  %t169 = load double, double* %l1
  br label %merge33
merge33:
  %t170 = phi double [ %t169, %merge35 ], [ %t139, %merge31 ]
  store double %t170, double* %l1
  %t171 = load i8*, i8** %l0
  %t172 = load double, double* %l2
  %t173 = call double @find_matching_brace(i8* %t171, double %t172)
  store double %t173, double* %l9
  %t174 = load double, double* %l9
  %t175 = sitofp i64 0 to double
  %t176 = fcmp olt double %t174, %t175
  %t177 = load i8*, i8** %l0
  %t178 = load double, double* %l1
  %t179 = load double, double* %l2
  %t180 = load double, double* %l3
  %t181 = load double, double* %l5
  %t182 = load i8*, i8** %l7
  %t183 = load double, double* %l9
  br i1 %t176, label %then36, label %merge37
then36:
  br label %afterloop5
merge37:
  %t184 = load i8*, i8** %l0
  %t185 = load double, double* %l5
  %t186 = load double, double* %l9
  %t187 = sitofp i64 1 to double
  %t188 = fadd double %t186, %t187
  %t189 = fptosi double %t185 to i64
  %t190 = fptosi double %t188 to i64
  %t191 = call i8* @sailfin_runtime_substring(i8* %t184, i64 %t189, i64 %t190)
  store i8* %t191, i8** %l10
  %t192 = load i8*, i8** %l10
  %t193 = sitofp i64 1 to double
  %t194 = fadd double %depth, %t193
  %t195 = call i8* @lower_struct_literal_expression(i8* %t192, double %t194)
  store i8* %t195, i8** %l11
  %t196 = load i8*, i8** %l11
  %t197 = icmp eq i8* %t196, null
  %t198 = load i8*, i8** %l0
  %t199 = load double, double* %l1
  %t200 = load double, double* %l2
  %t201 = load double, double* %l3
  %t202 = load double, double* %l5
  %t203 = load i8*, i8** %l7
  %t204 = load double, double* %l9
  %t205 = load i8*, i8** %l10
  %t206 = load i8*, i8** %l11
  br i1 %t197, label %then38, label %merge39
then38:
  %t207 = load double, double* %l9
  %t208 = sitofp i64 1 to double
  %t209 = fadd double %t207, %t208
  store double %t209, double* %l1
  br label %loop.latch4
merge39:
  %t210 = load i8*, i8** %l0
  %t211 = load double, double* %l5
  %t212 = fptosi double %t211 to i64
  %t213 = call i8* @sailfin_runtime_substring(i8* %t210, i64 0, i64 %t212)
  store i8* %t213, i8** %l12
  %t214 = load i8*, i8** %l0
  %t215 = load double, double* %l9
  %t216 = sitofp i64 1 to double
  %t217 = fadd double %t215, %t216
  %t218 = load i8*, i8** %l0
  %t219 = call i64 @sailfin_runtime_string_length(i8* %t218)
  %t220 = fptosi double %t217 to i64
  %t221 = call i8* @sailfin_runtime_substring(i8* %t214, i64 %t220, i64 %t219)
  store i8* %t221, i8** %l13
  %t222 = load i8*, i8** %l12
  %t223 = load i8*, i8** %l11
  %t224 = call i8* @sailfin_runtime_string_concat(i8* %t222, i8* %t223)
  %t225 = load i8*, i8** %l13
  %t226 = call i8* @sailfin_runtime_string_concat(i8* %t224, i8* %t225)
  store i8* %t226, i8** %l0
  %t227 = load double, double* %l5
  %t228 = load i8*, i8** %l11
  %t229 = call i64 @sailfin_runtime_string_length(i8* %t228)
  %t230 = sitofp i64 %t229 to double
  %t231 = fadd double %t227, %t230
  store double %t231, double* %l1
  br label %loop.latch4
loop.latch4:
  %t232 = load double, double* %l1
  %t233 = load i8*, i8** %l0
  br label %loop.header2
afterloop5:
  %t236 = load double, double* %l1
  %t237 = load i8*, i8** %l0
  %t238 = load i8*, i8** %l0
  ret i8* %t238
}

define %StructLiteralCapture @capture_struct_literal_expression(i8* %initial, { %NativeInstruction*, i64 }* %instructions, double %start_index) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca %NativeInstruction
  %l6 = alloca i8*
  %l7 = alloca i8*
  %t0 = call i8* @trim_text(i8* %initial)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = alloca [2 x i8], align 1
  %t3 = getelementptr [2 x i8], [2 x i8]* %t2, i32 0, i32 0
  store i8 123, i8* %t3
  %t4 = getelementptr [2 x i8], [2 x i8]* %t2, i32 0, i32 1
  store i8 0, i8* %t4
  %t5 = getelementptr [2 x i8], [2 x i8]* %t2, i32 0, i32 0
  %t6 = call i1 @ends_with(i8* %t1, i8* %t5)
  %t7 = xor i1 %t6, 1
  %t8 = load i8*, i8** %l0
  br i1 %t7, label %then0, label %merge1
then0:
  %t9 = load i8*, i8** %l0
  %t10 = insertvalue %StructLiteralCapture undef, i8* %t9, 0
  %t11 = sitofp i64 0 to double
  %t12 = insertvalue %StructLiteralCapture %t10, double %t11, 1
  %t13 = insertvalue %StructLiteralCapture %t12, i1 0, 2
  ret %StructLiteralCapture %t13
merge1:
  %t14 = load i8*, i8** %l0
  store i8* %t14, i8** %l1
  store double %start_index, double* %l2
  %t15 = sitofp i64 0 to double
  store double %t15, double* %l3
  %t16 = load i8*, i8** %l0
  %t17 = call double @compute_brace_balance(i8* %t16)
  store double %t17, double* %l4
  %t18 = load double, double* %l4
  %t19 = sitofp i64 0 to double
  %t20 = fcmp ole double %t18, %t19
  %t21 = load i8*, i8** %l0
  %t22 = load i8*, i8** %l1
  %t23 = load double, double* %l2
  %t24 = load double, double* %l3
  %t25 = load double, double* %l4
  br i1 %t20, label %then2, label %merge3
then2:
  %t26 = load i8*, i8** %l0
  %t27 = insertvalue %StructLiteralCapture undef, i8* %t26, 0
  %t28 = sitofp i64 0 to double
  %t29 = insertvalue %StructLiteralCapture %t27, double %t28, 1
  %t30 = insertvalue %StructLiteralCapture %t29, i1 0, 2
  ret %StructLiteralCapture %t30
merge3:
  %t31 = load i8*, i8** %l0
  %t32 = load i8*, i8** %l1
  %t33 = load double, double* %l2
  %t34 = load double, double* %l3
  %t35 = load double, double* %l4
  br label %loop.header4
loop.header4:
  %t170 = phi i8* [ %t32, %merge3 ], [ %t166, %loop.latch6 ]
  %t171 = phi double [ %t35, %merge3 ], [ %t167, %loop.latch6 ]
  %t172 = phi double [ %t34, %merge3 ], [ %t168, %loop.latch6 ]
  %t173 = phi double [ %t33, %merge3 ], [ %t169, %loop.latch6 ]
  store i8* %t170, i8** %l1
  store double %t171, double* %l4
  store double %t172, double* %l3
  store double %t173, double* %l2
  br label %loop.body5
loop.body5:
  %t36 = load double, double* %l2
  %t37 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %instructions
  %t38 = extractvalue { %NativeInstruction*, i64 } %t37, 1
  %t39 = sitofp i64 %t38 to double
  %t40 = fcmp oge double %t36, %t39
  %t41 = load i8*, i8** %l0
  %t42 = load i8*, i8** %l1
  %t43 = load double, double* %l2
  %t44 = load double, double* %l3
  %t45 = load double, double* %l4
  br i1 %t40, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t46 = load double, double* %l2
  %t47 = fptosi double %t46 to i64
  %t48 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %instructions
  %t49 = extractvalue { %NativeInstruction*, i64 } %t48, 0
  %t50 = extractvalue { %NativeInstruction*, i64 } %t48, 1
  %t51 = icmp uge i64 %t47, %t50
  ; bounds check: %t51 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t47, i64 %t50)
  %t52 = getelementptr %NativeInstruction, %NativeInstruction* %t49, i64 %t47
  %t53 = load %NativeInstruction, %NativeInstruction* %t52
  store %NativeInstruction %t53, %NativeInstruction* %l5
  %t54 = load %NativeInstruction, %NativeInstruction* %l5
  %t55 = extractvalue %NativeInstruction %t54, 0
  %t56 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t57 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t58 = icmp eq i32 %t55, 0
  %t59 = select i1 %t58, i8* %t57, i8* %t56
  %t60 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t61 = icmp eq i32 %t55, 1
  %t62 = select i1 %t61, i8* %t60, i8* %t59
  %t63 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t64 = icmp eq i32 %t55, 2
  %t65 = select i1 %t64, i8* %t63, i8* %t62
  %t66 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t67 = icmp eq i32 %t55, 3
  %t68 = select i1 %t67, i8* %t66, i8* %t65
  %t69 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t70 = icmp eq i32 %t55, 4
  %t71 = select i1 %t70, i8* %t69, i8* %t68
  %t72 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t73 = icmp eq i32 %t55, 5
  %t74 = select i1 %t73, i8* %t72, i8* %t71
  %t75 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t76 = icmp eq i32 %t55, 6
  %t77 = select i1 %t76, i8* %t75, i8* %t74
  %t78 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t79 = icmp eq i32 %t55, 7
  %t80 = select i1 %t79, i8* %t78, i8* %t77
  %t81 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t82 = icmp eq i32 %t55, 8
  %t83 = select i1 %t82, i8* %t81, i8* %t80
  %t84 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t85 = icmp eq i32 %t55, 9
  %t86 = select i1 %t85, i8* %t84, i8* %t83
  %t87 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t88 = icmp eq i32 %t55, 10
  %t89 = select i1 %t88, i8* %t87, i8* %t86
  %t90 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t91 = icmp eq i32 %t55, 11
  %t92 = select i1 %t91, i8* %t90, i8* %t89
  %t93 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t94 = icmp eq i32 %t55, 12
  %t95 = select i1 %t94, i8* %t93, i8* %t92
  %t96 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t97 = icmp eq i32 %t55, 13
  %t98 = select i1 %t97, i8* %t96, i8* %t95
  %t99 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t100 = icmp eq i32 %t55, 14
  %t101 = select i1 %t100, i8* %t99, i8* %t98
  %t102 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t103 = icmp eq i32 %t55, 15
  %t104 = select i1 %t103, i8* %t102, i8* %t101
  %t105 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t106 = icmp eq i32 %t55, 16
  %t107 = select i1 %t106, i8* %t105, i8* %t104
  %s108 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h48777630, i32 0, i32 0
  %t109 = icmp ne i8* %t107, %s108
  %t110 = load i8*, i8** %l0
  %t111 = load i8*, i8** %l1
  %t112 = load double, double* %l2
  %t113 = load double, double* %l3
  %t114 = load double, double* %l4
  %t115 = load %NativeInstruction, %NativeInstruction* %l5
  br i1 %t109, label %then10, label %merge11
then10:
  br label %afterloop7
merge11:
  %t116 = load %NativeInstruction, %NativeInstruction* %l5
  %t117 = extractvalue %NativeInstruction %t116, 0
  %t118 = alloca %NativeInstruction
  store %NativeInstruction %t116, %NativeInstruction* %t118
  %t119 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t118, i32 0, i32 1
  %t120 = bitcast [8 x i8]* %t119 to i8*
  %t121 = bitcast i8* %t120 to i8**
  %t122 = load i8*, i8** %t121
  %t123 = icmp eq i32 %t117, 16
  %t124 = select i1 %t123, i8* %t122, i8* null
  %t125 = call i8* @trim_text(i8* %t124)
  store i8* %t125, i8** %l6
  %t126 = load i8*, i8** %l6
  %t127 = call i64 @sailfin_runtime_string_length(i8* %t126)
  %t128 = icmp sgt i64 %t127, 0
  %t129 = load i8*, i8** %l0
  %t130 = load i8*, i8** %l1
  %t131 = load double, double* %l2
  %t132 = load double, double* %l3
  %t133 = load double, double* %l4
  %t134 = load %NativeInstruction, %NativeInstruction* %l5
  %t135 = load i8*, i8** %l6
  br i1 %t128, label %then12, label %merge13
then12:
  %t136 = load i8*, i8** %l1
  %t137 = alloca [2 x i8], align 1
  %t138 = getelementptr [2 x i8], [2 x i8]* %t137, i32 0, i32 0
  store i8 32, i8* %t138
  %t139 = getelementptr [2 x i8], [2 x i8]* %t137, i32 0, i32 1
  store i8 0, i8* %t139
  %t140 = getelementptr [2 x i8], [2 x i8]* %t137, i32 0, i32 0
  %t141 = call i8* @sailfin_runtime_string_concat(i8* %t136, i8* %t140)
  %t142 = load i8*, i8** %l6
  %t143 = call i8* @sailfin_runtime_string_concat(i8* %t141, i8* %t142)
  store i8* %t143, i8** %l1
  %t144 = load i8*, i8** %l1
  br label %merge13
merge13:
  %t145 = phi i8* [ %t144, %then12 ], [ %t130, %merge11 ]
  store i8* %t145, i8** %l1
  %t146 = load double, double* %l4
  %t147 = load i8*, i8** %l6
  %t148 = call double @compute_brace_balance(i8* %t147)
  %t149 = fadd double %t146, %t148
  store double %t149, double* %l4
  %t150 = load double, double* %l3
  %t151 = sitofp i64 1 to double
  %t152 = fadd double %t150, %t151
  store double %t152, double* %l3
  %t153 = load double, double* %l2
  %t154 = sitofp i64 1 to double
  %t155 = fadd double %t153, %t154
  store double %t155, double* %l2
  %t156 = load double, double* %l4
  %t157 = sitofp i64 0 to double
  %t158 = fcmp ole double %t156, %t157
  %t159 = load i8*, i8** %l0
  %t160 = load i8*, i8** %l1
  %t161 = load double, double* %l2
  %t162 = load double, double* %l3
  %t163 = load double, double* %l4
  %t164 = load %NativeInstruction, %NativeInstruction* %l5
  %t165 = load i8*, i8** %l6
  br i1 %t158, label %then14, label %merge15
then14:
  br label %afterloop7
merge15:
  br label %loop.latch6
loop.latch6:
  %t166 = load i8*, i8** %l1
  %t167 = load double, double* %l4
  %t168 = load double, double* %l3
  %t169 = load double, double* %l2
  br label %loop.header4
afterloop7:
  %t174 = load i8*, i8** %l1
  %t175 = load double, double* %l4
  %t176 = load double, double* %l3
  %t177 = load double, double* %l2
  %t178 = load double, double* %l4
  %t179 = sitofp i64 0 to double
  %t180 = fcmp une double %t178, %t179
  %t181 = load i8*, i8** %l0
  %t182 = load i8*, i8** %l1
  %t183 = load double, double* %l2
  %t184 = load double, double* %l3
  %t185 = load double, double* %l4
  br i1 %t180, label %then16, label %merge17
then16:
  %t186 = load i8*, i8** %l0
  %t187 = insertvalue %StructLiteralCapture undef, i8* %t186, 0
  %t188 = sitofp i64 0 to double
  %t189 = insertvalue %StructLiteralCapture %t187, double %t188, 1
  %t190 = insertvalue %StructLiteralCapture %t189, i1 0, 2
  ret %StructLiteralCapture %t190
merge17:
  %t191 = load double, double* %l3
  %t192 = sitofp i64 0 to double
  %t193 = fcmp oeq double %t191, %t192
  %t194 = load i8*, i8** %l0
  %t195 = load i8*, i8** %l1
  %t196 = load double, double* %l2
  %t197 = load double, double* %l3
  %t198 = load double, double* %l4
  br i1 %t193, label %then18, label %merge19
then18:
  %t199 = load i8*, i8** %l0
  %t200 = insertvalue %StructLiteralCapture undef, i8* %t199, 0
  %t201 = sitofp i64 0 to double
  %t202 = insertvalue %StructLiteralCapture %t200, double %t201, 1
  %t203 = insertvalue %StructLiteralCapture %t202, i1 0, 2
  ret %StructLiteralCapture %t203
merge19:
  %t204 = load i8*, i8** %l1
  %t205 = call i8* @trim_text(i8* %t204)
  %t206 = call i8* @trim_trailing_delimiters(i8* %t205)
  store i8* %t206, i8** %l7
  %t207 = load i8*, i8** %l7
  %t208 = alloca [2 x i8], align 1
  %t209 = getelementptr [2 x i8], [2 x i8]* %t208, i32 0, i32 0
  store i8 125, i8* %t209
  %t210 = getelementptr [2 x i8], [2 x i8]* %t208, i32 0, i32 1
  store i8 0, i8* %t210
  %t211 = getelementptr [2 x i8], [2 x i8]* %t208, i32 0, i32 0
  %t212 = call i1 @ends_with(i8* %t207, i8* %t211)
  %t213 = xor i1 %t212, 1
  %t214 = load i8*, i8** %l0
  %t215 = load i8*, i8** %l1
  %t216 = load double, double* %l2
  %t217 = load double, double* %l3
  %t218 = load double, double* %l4
  %t219 = load i8*, i8** %l7
  br i1 %t213, label %then20, label %merge21
then20:
  %t220 = load i8*, i8** %l0
  %t221 = insertvalue %StructLiteralCapture undef, i8* %t220, 0
  %t222 = sitofp i64 0 to double
  %t223 = insertvalue %StructLiteralCapture %t221, double %t222, 1
  %t224 = insertvalue %StructLiteralCapture %t223, i1 0, 2
  ret %StructLiteralCapture %t224
merge21:
  %t225 = load i8*, i8** %l7
  %t226 = insertvalue %StructLiteralCapture undef, i8* %t225, 0
  %t227 = load double, double* %l3
  %t228 = insertvalue %StructLiteralCapture %t226, double %t227, 1
  %t229 = insertvalue %StructLiteralCapture %t228, i1 1, 2
  ret %StructLiteralCapture %t229
}

define i8* @rewrite_expression_intrinsics(i8* %expression) {
block.entry:
  %l0 = alloca i8*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  ret i8* %expression
merge1:
  store i8* %expression, i8** %l0
  %t2 = load i8*, i8** %l0
  %t3 = call i8* @rewrite_literal_tokens(i8* %t2)
  store i8* %t3, i8** %l0
  %t4 = load i8*, i8** %l0
  %t5 = call i8* @rewrite_logical_operators(i8* %t4)
  store i8* %t5, i8** %l0
  %t6 = load i8*, i8** %l0
  %t7 = call i8* @rewrite_push_calls(i8* %t6)
  store i8* %t7, i8** %l0
  %t8 = load i8*, i8** %l0
  %t9 = call i8* @rewrite_concat_calls(i8* %t8)
  store i8* %t9, i8** %l0
  %t10 = load i8*, i8** %l0
  %t11 = call i8* @rewrite_length_accesses(i8* %t10)
  store i8* %t11, i8** %l0
  %t12 = load i8*, i8** %l0
  ret i8* %t12
}

define i8* @rewrite_logical_operators(i8* %expression) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca i8*
  %l6 = alloca i8*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  ret i8* %expression
merge1:
  %s2 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s2, i8** %l0
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l1
  %t4 = load i8*, i8** %l0
  %t5 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t185 = phi i8* [ %t4, %merge1 ], [ %t183, %loop.latch4 ]
  %t186 = phi double [ %t5, %merge1 ], [ %t184, %loop.latch4 ]
  store i8* %t185, i8** %l0
  store double %t186, double* %l1
  br label %loop.body3
loop.body3:
  %t6 = load double, double* %l1
  %t7 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t8 = sitofp i64 %t7 to double
  %t9 = fcmp oge double %t6, %t8
  %t10 = load i8*, i8** %l0
  %t11 = load double, double* %l1
  br i1 %t9, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t12 = load double, double* %l1
  %t13 = load double, double* %l1
  %t14 = sitofp i64 1 to double
  %t15 = fadd double %t13, %t14
  %t16 = fptosi double %t12 to i64
  %t17 = fptosi double %t15 to i64
  %t18 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t16, i64 %t17)
  store i8* %t18, i8** %l2
  %t20 = load i8*, i8** %l2
  %t21 = load i8, i8* %t20
  %t22 = icmp eq i8 %t21, 39
  br label %logical_or_entry_19

logical_or_entry_19:
  br i1 %t22, label %logical_or_merge_19, label %logical_or_right_19

logical_or_right_19:
  %t23 = load i8*, i8** %l2
  %t24 = load i8, i8* %t23
  %t25 = icmp eq i8 %t24, 34
  br label %logical_or_right_end_19

logical_or_right_end_19:
  br label %logical_or_merge_19

logical_or_merge_19:
  %t26 = phi i1 [ true, %logical_or_entry_19 ], [ %t25, %logical_or_right_end_19 ]
  %t27 = load i8*, i8** %l0
  %t28 = load double, double* %l1
  %t29 = load i8*, i8** %l2
  br i1 %t26, label %then8, label %merge9
then8:
  %t30 = load double, double* %l1
  %t31 = call double @skip_string_literal(i8* %expression, double %t30)
  store double %t31, double* %l3
  %t32 = load i8*, i8** %l0
  %t33 = load double, double* %l1
  %t34 = load double, double* %l3
  %t35 = fptosi double %t33 to i64
  %t36 = fptosi double %t34 to i64
  %t37 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t35, i64 %t36)
  %t38 = call i8* @sailfin_runtime_string_concat(i8* %t32, i8* %t37)
  store i8* %t38, i8** %l0
  %t39 = load double, double* %l3
  store double %t39, double* %l1
  br label %loop.latch4
merge9:
  %t40 = load i8*, i8** %l2
  %t41 = load i8, i8* %t40
  %t42 = icmp eq i8 %t41, 38
  %t43 = load i8*, i8** %l0
  %t44 = load double, double* %l1
  %t45 = load i8*, i8** %l2
  br i1 %t42, label %then10, label %merge11
then10:
  %t46 = load double, double* %l1
  %t47 = sitofp i64 1 to double
  %t48 = fadd double %t46, %t47
  %t49 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t50 = sitofp i64 %t49 to double
  %t51 = fcmp olt double %t48, %t50
  %t52 = load i8*, i8** %l0
  %t53 = load double, double* %l1
  %t54 = load i8*, i8** %l2
  br i1 %t51, label %then12, label %merge13
then12:
  %t55 = load double, double* %l1
  %t56 = sitofp i64 1 to double
  %t57 = fadd double %t55, %t56
  %t58 = load double, double* %l1
  %t59 = sitofp i64 2 to double
  %t60 = fadd double %t58, %t59
  %t61 = fptosi double %t57 to i64
  %t62 = fptosi double %t60 to i64
  %t63 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t61, i64 %t62)
  store i8* %t63, i8** %l4
  %t64 = load i8*, i8** %l4
  %t65 = load i8, i8* %t64
  %t66 = icmp eq i8 %t65, 38
  %t67 = load i8*, i8** %l0
  %t68 = load double, double* %l1
  %t69 = load i8*, i8** %l2
  %t70 = load i8*, i8** %l4
  br i1 %t66, label %then14, label %merge15
then14:
  %t71 = load i8*, i8** %l0
  %s72 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1503489441, i32 0, i32 0
  %t73 = call i8* @sailfin_runtime_string_concat(i8* %t71, i8* %s72)
  store i8* %t73, i8** %l0
  %t74 = load double, double* %l1
  %t75 = sitofp i64 2 to double
  %t76 = fadd double %t74, %t75
  store double %t76, double* %l1
  br label %loop.latch4
merge15:
  %t77 = load i8*, i8** %l0
  %t78 = load double, double* %l1
  br label %merge13
merge13:
  %t79 = phi i8* [ %t77, %merge15 ], [ %t52, %then10 ]
  %t80 = phi double [ %t78, %merge15 ], [ %t53, %then10 ]
  store i8* %t79, i8** %l0
  store double %t80, double* %l1
  %t81 = load i8*, i8** %l0
  %t82 = load double, double* %l1
  br label %merge11
merge11:
  %t83 = phi i8* [ %t81, %merge13 ], [ %t43, %merge9 ]
  %t84 = phi double [ %t82, %merge13 ], [ %t44, %merge9 ]
  store i8* %t83, i8** %l0
  store double %t84, double* %l1
  %t85 = load i8*, i8** %l2
  %t86 = load i8, i8* %t85
  %t87 = icmp eq i8 %t86, 124
  %t88 = load i8*, i8** %l0
  %t89 = load double, double* %l1
  %t90 = load i8*, i8** %l2
  br i1 %t87, label %then16, label %merge17
then16:
  %t91 = load double, double* %l1
  %t92 = sitofp i64 1 to double
  %t93 = fadd double %t91, %t92
  %t94 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t95 = sitofp i64 %t94 to double
  %t96 = fcmp olt double %t93, %t95
  %t97 = load i8*, i8** %l0
  %t98 = load double, double* %l1
  %t99 = load i8*, i8** %l2
  br i1 %t96, label %then18, label %merge19
then18:
  %t100 = load double, double* %l1
  %t101 = sitofp i64 1 to double
  %t102 = fadd double %t100, %t101
  %t103 = load double, double* %l1
  %t104 = sitofp i64 2 to double
  %t105 = fadd double %t103, %t104
  %t106 = fptosi double %t102 to i64
  %t107 = fptosi double %t105 to i64
  %t108 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t106, i64 %t107)
  store i8* %t108, i8** %l5
  %t109 = load i8*, i8** %l5
  %t110 = load i8, i8* %t109
  %t111 = icmp eq i8 %t110, 124
  %t112 = load i8*, i8** %l0
  %t113 = load double, double* %l1
  %t114 = load i8*, i8** %l2
  %t115 = load i8*, i8** %l5
  br i1 %t111, label %then20, label %merge21
then20:
  %t116 = load i8*, i8** %l0
  %s117 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h176216012, i32 0, i32 0
  %t118 = call i8* @sailfin_runtime_string_concat(i8* %t116, i8* %s117)
  store i8* %t118, i8** %l0
  %t119 = load double, double* %l1
  %t120 = sitofp i64 2 to double
  %t121 = fadd double %t119, %t120
  store double %t121, double* %l1
  br label %loop.latch4
merge21:
  %t122 = load i8*, i8** %l0
  %t123 = load double, double* %l1
  br label %merge19
merge19:
  %t124 = phi i8* [ %t122, %merge21 ], [ %t97, %then16 ]
  %t125 = phi double [ %t123, %merge21 ], [ %t98, %then16 ]
  store i8* %t124, i8** %l0
  store double %t125, double* %l1
  %t126 = load i8*, i8** %l0
  %t127 = load double, double* %l1
  br label %merge17
merge17:
  %t128 = phi i8* [ %t126, %merge19 ], [ %t88, %merge11 ]
  %t129 = phi double [ %t127, %merge19 ], [ %t89, %merge11 ]
  store i8* %t128, i8** %l0
  store double %t129, double* %l1
  %t130 = load i8*, i8** %l2
  %t131 = load i8, i8* %t130
  %t132 = icmp eq i8 %t131, 33
  %t133 = load i8*, i8** %l0
  %t134 = load double, double* %l1
  %t135 = load i8*, i8** %l2
  br i1 %t132, label %then22, label %merge23
then22:
  %t136 = load double, double* %l1
  %t137 = sitofp i64 1 to double
  %t138 = fadd double %t136, %t137
  %t139 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t140 = sitofp i64 %t139 to double
  %t141 = fcmp olt double %t138, %t140
  %t142 = load i8*, i8** %l0
  %t143 = load double, double* %l1
  %t144 = load i8*, i8** %l2
  br i1 %t141, label %then24, label %merge25
then24:
  %t145 = load double, double* %l1
  %t146 = sitofp i64 1 to double
  %t147 = fadd double %t145, %t146
  %t148 = load double, double* %l1
  %t149 = sitofp i64 2 to double
  %t150 = fadd double %t148, %t149
  %t151 = fptosi double %t147 to i64
  %t152 = fptosi double %t150 to i64
  %t153 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t151, i64 %t152)
  store i8* %t153, i8** %l6
  %t154 = load i8*, i8** %l6
  %t155 = load i8, i8* %t154
  %t156 = icmp eq i8 %t155, 61
  %t157 = load i8*, i8** %l0
  %t158 = load double, double* %l1
  %t159 = load i8*, i8** %l2
  %t160 = load i8*, i8** %l6
  br i1 %t156, label %then26, label %merge27
then26:
  %t161 = load i8*, i8** %l0
  %s162 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193414949, i32 0, i32 0
  %t163 = call i8* @sailfin_runtime_string_concat(i8* %t161, i8* %s162)
  store i8* %t163, i8** %l0
  %t164 = load double, double* %l1
  %t165 = sitofp i64 2 to double
  %t166 = fadd double %t164, %t165
  store double %t166, double* %l1
  br label %loop.latch4
merge27:
  %t167 = load i8*, i8** %l0
  %t168 = load double, double* %l1
  br label %merge25
merge25:
  %t169 = phi i8* [ %t167, %merge27 ], [ %t142, %then22 ]
  %t170 = phi double [ %t168, %merge27 ], [ %t143, %then22 ]
  store i8* %t169, i8** %l0
  store double %t170, double* %l1
  %t171 = load i8*, i8** %l0
  %s172 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h268720028, i32 0, i32 0
  %t173 = call i8* @sailfin_runtime_string_concat(i8* %t171, i8* %s172)
  store i8* %t173, i8** %l0
  %t174 = load double, double* %l1
  %t175 = sitofp i64 1 to double
  %t176 = fadd double %t174, %t175
  store double %t176, double* %l1
  br label %loop.latch4
merge23:
  %t177 = load i8*, i8** %l0
  %t178 = load i8*, i8** %l2
  %t179 = call i8* @sailfin_runtime_string_concat(i8* %t177, i8* %t178)
  store i8* %t179, i8** %l0
  %t180 = load double, double* %l1
  %t181 = sitofp i64 1 to double
  %t182 = fadd double %t180, %t181
  store double %t182, double* %l1
  br label %loop.latch4
loop.latch4:
  %t183 = load i8*, i8** %l0
  %t184 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t187 = load i8*, i8** %l0
  %t188 = load double, double* %l1
  %t189 = load i8*, i8** %l0
  ret i8* %t189
}

define i8* @rewrite_literal_tokens(i8* %expression) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca i8*
  %l6 = alloca i8*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  ret i8* %expression
merge1:
  %s2 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s2, i8** %l0
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l1
  %t4 = load i8*, i8** %l0
  %t5 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t140 = phi i8* [ %t4, %merge1 ], [ %t138, %loop.latch4 ]
  %t141 = phi double [ %t5, %merge1 ], [ %t139, %loop.latch4 ]
  store i8* %t140, i8** %l0
  store double %t141, double* %l1
  br label %loop.body3
loop.body3:
  %t6 = load double, double* %l1
  %t7 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t8 = sitofp i64 %t7 to double
  %t9 = fcmp oge double %t6, %t8
  %t10 = load i8*, i8** %l0
  %t11 = load double, double* %l1
  br i1 %t9, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t12 = load double, double* %l1
  %t13 = load double, double* %l1
  %t14 = sitofp i64 1 to double
  %t15 = fadd double %t13, %t14
  %t16 = fptosi double %t12 to i64
  %t17 = fptosi double %t15 to i64
  %t18 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t16, i64 %t17)
  store i8* %t18, i8** %l2
  %t20 = load i8*, i8** %l2
  %t21 = load i8, i8* %t20
  %t22 = icmp eq i8 %t21, 39
  br label %logical_or_entry_19

logical_or_entry_19:
  br i1 %t22, label %logical_or_merge_19, label %logical_or_right_19

logical_or_right_19:
  %t23 = load i8*, i8** %l2
  %t24 = load i8, i8* %t23
  %t25 = icmp eq i8 %t24, 34
  br label %logical_or_right_end_19

logical_or_right_end_19:
  br label %logical_or_merge_19

logical_or_merge_19:
  %t26 = phi i1 [ true, %logical_or_entry_19 ], [ %t25, %logical_or_right_end_19 ]
  %t27 = load i8*, i8** %l0
  %t28 = load double, double* %l1
  %t29 = load i8*, i8** %l2
  br i1 %t26, label %then8, label %merge9
then8:
  %t30 = load double, double* %l1
  %t31 = call double @skip_string_literal(i8* %expression, double %t30)
  store double %t31, double* %l3
  %t32 = load i8*, i8** %l0
  %t33 = load double, double* %l1
  %t34 = load double, double* %l3
  %t35 = fptosi double %t33 to i64
  %t36 = fptosi double %t34 to i64
  %t37 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t35, i64 %t36)
  %t38 = call i8* @sailfin_runtime_string_concat(i8* %t32, i8* %t37)
  store i8* %t38, i8** %l0
  %t39 = load double, double* %l3
  store double %t39, double* %l1
  br label %loop.latch4
merge9:
  %t40 = load i8*, i8** %l2
  %t41 = call i1 @is_identifier_char(i8* %t40)
  %t42 = load i8*, i8** %l0
  %t43 = load double, double* %l1
  %t44 = load i8*, i8** %l2
  br i1 %t41, label %then10, label %merge11
then10:
  %t45 = load double, double* %l1
  store double %t45, double* %l4
  %t46 = load i8*, i8** %l0
  %t47 = load double, double* %l1
  %t48 = load i8*, i8** %l2
  %t49 = load double, double* %l4
  br label %loop.header12
loop.header12:
  %t77 = phi double [ %t47, %then10 ], [ %t76, %loop.latch14 ]
  store double %t77, double* %l1
  br label %loop.body13
loop.body13:
  %t50 = load double, double* %l1
  %t51 = sitofp i64 1 to double
  %t52 = fadd double %t50, %t51
  store double %t52, double* %l1
  %t53 = load double, double* %l1
  %t54 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t55 = sitofp i64 %t54 to double
  %t56 = fcmp oge double %t53, %t55
  %t57 = load i8*, i8** %l0
  %t58 = load double, double* %l1
  %t59 = load i8*, i8** %l2
  %t60 = load double, double* %l4
  br i1 %t56, label %then16, label %merge17
then16:
  br label %afterloop15
merge17:
  %t61 = load double, double* %l1
  %t62 = load double, double* %l1
  %t63 = sitofp i64 1 to double
  %t64 = fadd double %t62, %t63
  %t65 = fptosi double %t61 to i64
  %t66 = fptosi double %t64 to i64
  %t67 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t65, i64 %t66)
  store i8* %t67, i8** %l5
  %t68 = load i8*, i8** %l5
  %t69 = call i1 @is_identifier_char(i8* %t68)
  %t70 = xor i1 %t69, 1
  %t71 = load i8*, i8** %l0
  %t72 = load double, double* %l1
  %t73 = load i8*, i8** %l2
  %t74 = load double, double* %l4
  %t75 = load i8*, i8** %l5
  br i1 %t70, label %then18, label %merge19
then18:
  br label %afterloop15
merge19:
  br label %loop.latch14
loop.latch14:
  %t76 = load double, double* %l1
  br label %loop.header12
afterloop15:
  %t78 = load double, double* %l1
  %t79 = load double, double* %l4
  %t80 = load double, double* %l1
  %t81 = fptosi double %t79 to i64
  %t82 = fptosi double %t80 to i64
  %t83 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t81, i64 %t82)
  store i8* %t83, i8** %l6
  %t84 = load i8*, i8** %l6
  %s85 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h268929446, i32 0, i32 0
  %t86 = icmp eq i8* %t84, %s85
  %t87 = load i8*, i8** %l0
  %t88 = load double, double* %l1
  %t89 = load i8*, i8** %l2
  %t90 = load double, double* %l4
  %t91 = load i8*, i8** %l6
  br i1 %t86, label %then20, label %else21
then20:
  %t92 = load i8*, i8** %l0
  %s93 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h230766299, i32 0, i32 0
  %t94 = call i8* @sailfin_runtime_string_concat(i8* %t92, i8* %s93)
  store i8* %t94, i8** %l0
  %t95 = load i8*, i8** %l0
  br label %merge22
else21:
  %t96 = load i8*, i8** %l6
  %s97 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h275946731, i32 0, i32 0
  %t98 = icmp eq i8* %t96, %s97
  %t99 = load i8*, i8** %l0
  %t100 = load double, double* %l1
  %t101 = load i8*, i8** %l2
  %t102 = load double, double* %l4
  %t103 = load i8*, i8** %l6
  br i1 %t98, label %then23, label %else24
then23:
  %t104 = load i8*, i8** %l0
  %s105 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h237997259, i32 0, i32 0
  %t106 = call i8* @sailfin_runtime_string_concat(i8* %t104, i8* %s105)
  store i8* %t106, i8** %l0
  %t107 = load i8*, i8** %l0
  br label %merge25
else24:
  %t108 = load i8*, i8** %l6
  %s109 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2095430042, i32 0, i32 0
  %t110 = icmp eq i8* %t108, %s109
  %t111 = load i8*, i8** %l0
  %t112 = load double, double* %l1
  %t113 = load i8*, i8** %l2
  %t114 = load double, double* %l4
  %t115 = load i8*, i8** %l6
  br i1 %t110, label %then26, label %else27
then26:
  %t116 = load i8*, i8** %l0
  %s117 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h843097466, i32 0, i32 0
  %t118 = call i8* @sailfin_runtime_string_concat(i8* %t116, i8* %s117)
  store i8* %t118, i8** %l0
  %t119 = load i8*, i8** %l0
  br label %merge28
else27:
  %t120 = load i8*, i8** %l0
  %t121 = load i8*, i8** %l6
  %t122 = call i8* @sailfin_runtime_string_concat(i8* %t120, i8* %t121)
  store i8* %t122, i8** %l0
  %t123 = load i8*, i8** %l0
  br label %merge28
merge28:
  %t124 = phi i8* [ %t119, %then26 ], [ %t123, %else27 ]
  store i8* %t124, i8** %l0
  %t125 = load i8*, i8** %l0
  %t126 = load i8*, i8** %l0
  br label %merge25
merge25:
  %t127 = phi i8* [ %t107, %then23 ], [ %t125, %merge28 ]
  store i8* %t127, i8** %l0
  %t128 = load i8*, i8** %l0
  %t129 = load i8*, i8** %l0
  %t130 = load i8*, i8** %l0
  br label %merge22
merge22:
  %t131 = phi i8* [ %t95, %then20 ], [ %t128, %merge25 ]
  store i8* %t131, i8** %l0
  br label %loop.latch4
merge11:
  %t132 = load i8*, i8** %l0
  %t133 = load i8*, i8** %l2
  %t134 = call i8* @sailfin_runtime_string_concat(i8* %t132, i8* %t133)
  store i8* %t134, i8** %l0
  %t135 = load double, double* %l1
  %t136 = sitofp i64 1 to double
  %t137 = fadd double %t135, %t136
  store double %t137, double* %l1
  br label %loop.latch4
loop.latch4:
  %t138 = load i8*, i8** %l0
  %t139 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t142 = load i8*, i8** %l0
  %t143 = load double, double* %l1
  %t144 = load i8*, i8** %l0
  ret i8* %t144
}

define i8* @rewrite_push_calls(i8* %expression) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca double
  %l6 = alloca i8*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  ret i8* %expression
merge1:
  %s2 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1719661028, i32 0, i32 0
  store i8* %s2, i8** %l0
  %s3 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h645367897, i32 0, i32 0
  store i8* %s3, i8** %l1
  %s4 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s4, i8** %l2
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l3
  %t6 = load i8*, i8** %l0
  %t7 = load i8*, i8** %l1
  %t8 = load i8*, i8** %l2
  %t9 = load double, double* %l3
  br label %loop.header2
loop.header2:
  %t99 = phi i8* [ %t8, %merge1 ], [ %t97, %loop.latch4 ]
  %t100 = phi double [ %t9, %merge1 ], [ %t98, %loop.latch4 ]
  store i8* %t99, i8** %l2
  store double %t100, double* %l3
  br label %loop.body3
loop.body3:
  %t10 = load double, double* %l3
  %t11 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t12 = sitofp i64 %t11 to double
  %t13 = fcmp oge double %t10, %t12
  %t14 = load i8*, i8** %l0
  %t15 = load i8*, i8** %l1
  %t16 = load i8*, i8** %l2
  %t17 = load double, double* %l3
  br i1 %t13, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t18 = load double, double* %l3
  %t19 = load double, double* %l3
  %t20 = sitofp i64 1 to double
  %t21 = fadd double %t19, %t20
  %t22 = fptosi double %t18 to i64
  %t23 = fptosi double %t21 to i64
  %t24 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t22, i64 %t23)
  store i8* %t24, i8** %l4
  %t26 = load i8*, i8** %l4
  %t27 = load i8, i8* %t26
  %t28 = icmp eq i8 %t27, 39
  br label %logical_or_entry_25

logical_or_entry_25:
  br i1 %t28, label %logical_or_merge_25, label %logical_or_right_25

logical_or_right_25:
  %t29 = load i8*, i8** %l4
  %t30 = load i8, i8* %t29
  %t31 = icmp eq i8 %t30, 34
  br label %logical_or_right_end_25

logical_or_right_end_25:
  br label %logical_or_merge_25

logical_or_merge_25:
  %t32 = phi i1 [ true, %logical_or_entry_25 ], [ %t31, %logical_or_right_end_25 ]
  %t33 = load i8*, i8** %l0
  %t34 = load i8*, i8** %l1
  %t35 = load i8*, i8** %l2
  %t36 = load double, double* %l3
  %t37 = load i8*, i8** %l4
  br i1 %t32, label %then8, label %merge9
then8:
  %t38 = load double, double* %l3
  %t39 = call double @skip_string_literal(i8* %expression, double %t38)
  store double %t39, double* %l5
  %t40 = load i8*, i8** %l2
  %t41 = load double, double* %l3
  %t42 = load double, double* %l5
  %t43 = fptosi double %t41 to i64
  %t44 = fptosi double %t42 to i64
  %t45 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t43, i64 %t44)
  %t46 = call i8* @sailfin_runtime_string_concat(i8* %t40, i8* %t45)
  store i8* %t46, i8** %l2
  %t47 = load double, double* %l5
  store double %t47, double* %l3
  br label %loop.latch4
merge9:
  %t48 = load double, double* %l3
  %t49 = load i8*, i8** %l0
  %t50 = call i64 @sailfin_runtime_string_length(i8* %t49)
  %t51 = sitofp i64 %t50 to double
  %t52 = fadd double %t48, %t51
  %t53 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t54 = sitofp i64 %t53 to double
  %t55 = fcmp ole double %t52, %t54
  %t56 = load i8*, i8** %l0
  %t57 = load i8*, i8** %l1
  %t58 = load i8*, i8** %l2
  %t59 = load double, double* %l3
  %t60 = load i8*, i8** %l4
  br i1 %t55, label %then10, label %merge11
then10:
  %t61 = load double, double* %l3
  %t62 = load double, double* %l3
  %t63 = load i8*, i8** %l0
  %t64 = call i64 @sailfin_runtime_string_length(i8* %t63)
  %t65 = sitofp i64 %t64 to double
  %t66 = fadd double %t62, %t65
  %t67 = fptosi double %t61 to i64
  %t68 = fptosi double %t66 to i64
  %t69 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t67, i64 %t68)
  store i8* %t69, i8** %l6
  %t70 = load i8*, i8** %l6
  %t71 = load i8*, i8** %l0
  %t72 = icmp eq i8* %t70, %t71
  %t73 = load i8*, i8** %l0
  %t74 = load i8*, i8** %l1
  %t75 = load i8*, i8** %l2
  %t76 = load double, double* %l3
  %t77 = load i8*, i8** %l4
  %t78 = load i8*, i8** %l6
  br i1 %t72, label %then12, label %merge13
then12:
  %t79 = load i8*, i8** %l2
  %t80 = load i8*, i8** %l1
  %t81 = call i8* @sailfin_runtime_string_concat(i8* %t79, i8* %t80)
  store i8* %t81, i8** %l2
  %t82 = load double, double* %l3
  %t83 = load i8*, i8** %l0
  %t84 = call i64 @sailfin_runtime_string_length(i8* %t83)
  %t85 = sitofp i64 %t84 to double
  %t86 = fadd double %t82, %t85
  store double %t86, double* %l3
  br label %loop.latch4
merge13:
  %t87 = load i8*, i8** %l2
  %t88 = load double, double* %l3
  br label %merge11
merge11:
  %t89 = phi i8* [ %t87, %merge13 ], [ %t58, %merge9 ]
  %t90 = phi double [ %t88, %merge13 ], [ %t59, %merge9 ]
  store i8* %t89, i8** %l2
  store double %t90, double* %l3
  %t91 = load i8*, i8** %l2
  %t92 = load i8*, i8** %l4
  %t93 = call i8* @sailfin_runtime_string_concat(i8* %t91, i8* %t92)
  store i8* %t93, i8** %l2
  %t94 = load double, double* %l3
  %t95 = sitofp i64 1 to double
  %t96 = fadd double %t94, %t95
  store double %t96, double* %l3
  br label %loop.latch4
loop.latch4:
  %t97 = load i8*, i8** %l2
  %t98 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t101 = load i8*, i8** %l2
  %t102 = load double, double* %l3
  %t103 = load i8*, i8** %l2
  ret i8* %t103
}

define i8* @rewrite_concat_calls(i8* %expression) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca %ExtractedSpan
  %l3 = alloca double
  %l4 = alloca %ExtractedSpan
  %l5 = alloca i8*
  %l6 = alloca i8*
  %l7 = alloca i8*
  %l8 = alloca i8*
  %l9 = alloca i8*
  store i8* %expression, i8** %l0
  %t0 = load i8*, i8** %l0
  br label %loop.header0
loop.header0:
  %t71 = phi i8* [ %t0, %block.entry ], [ %t70, %loop.latch2 ]
  store i8* %t71, i8** %l0
  br label %loop.body1
loop.body1:
  %t1 = load i8*, i8** %l0
  %s2 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h757831264, i32 0, i32 0
  %t3 = call double @index_of(i8* %t1, i8* %s2)
  store double %t3, double* %l1
  %t4 = load double, double* %l1
  %t5 = sitofp i64 0 to double
  %t6 = fcmp olt double %t4, %t5
  %t7 = load i8*, i8** %l0
  %t8 = load double, double* %l1
  br i1 %t6, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t9 = load i8*, i8** %l0
  %t10 = load double, double* %l1
  %t11 = call %ExtractedSpan @extract_object_span(i8* %t9, double %t10)
  store %ExtractedSpan %t11, %ExtractedSpan* %l2
  %t12 = load %ExtractedSpan, %ExtractedSpan* %l2
  %t13 = extractvalue %ExtractedSpan %t12, 3
  %t14 = xor i1 %t13, 1
  %t15 = load i8*, i8** %l0
  %t16 = load double, double* %l1
  %t17 = load %ExtractedSpan, %ExtractedSpan* %l2
  br i1 %t14, label %then6, label %merge7
then6:
  br label %afterloop3
merge7:
  %t18 = load double, double* %l1
  %t19 = sitofp i64 7 to double
  %t20 = fadd double %t18, %t19
  store double %t20, double* %l3
  %t21 = load i8*, i8** %l0
  %t22 = load double, double* %l3
  %t23 = call %ExtractedSpan @extract_parenthesized_span(i8* %t21, double %t22)
  store %ExtractedSpan %t23, %ExtractedSpan* %l4
  %t24 = load %ExtractedSpan, %ExtractedSpan* %l4
  %t25 = extractvalue %ExtractedSpan %t24, 3
  %t26 = xor i1 %t25, 1
  %t27 = load i8*, i8** %l0
  %t28 = load double, double* %l1
  %t29 = load %ExtractedSpan, %ExtractedSpan* %l2
  %t30 = load double, double* %l3
  %t31 = load %ExtractedSpan, %ExtractedSpan* %l4
  br i1 %t26, label %then8, label %merge9
then8:
  br label %afterloop3
merge9:
  %t32 = load i8*, i8** %l0
  %t33 = load %ExtractedSpan, %ExtractedSpan* %l2
  %t34 = extractvalue %ExtractedSpan %t33, 1
  %t35 = fptosi double %t34 to i64
  %t36 = call i8* @sailfin_runtime_substring(i8* %t32, i64 0, i64 %t35)
  store i8* %t36, i8** %l5
  %t37 = load i8*, i8** %l0
  %t38 = load %ExtractedSpan, %ExtractedSpan* %l4
  %t39 = extractvalue %ExtractedSpan %t38, 2
  %t40 = load i8*, i8** %l0
  %t41 = call i64 @sailfin_runtime_string_length(i8* %t40)
  %t42 = fptosi double %t39 to i64
  %t43 = call i8* @sailfin_runtime_substring(i8* %t37, i64 %t42, i64 %t41)
  store i8* %t43, i8** %l6
  %t44 = load %ExtractedSpan, %ExtractedSpan* %l2
  %t45 = extractvalue %ExtractedSpan %t44, 0
  %t46 = call i8* @trim_text(i8* %t45)
  store i8* %t46, i8** %l7
  %t47 = load %ExtractedSpan, %ExtractedSpan* %l4
  %t48 = extractvalue %ExtractedSpan %t47, 0
  %t49 = call i8* @trim_text(i8* %t48)
  store i8* %t49, i8** %l8
  %t50 = load i8*, i8** %l7
  %t51 = alloca [2 x i8], align 1
  %t52 = getelementptr [2 x i8], [2 x i8]* %t51, i32 0, i32 0
  store i8 40, i8* %t52
  %t53 = getelementptr [2 x i8], [2 x i8]* %t51, i32 0, i32 1
  store i8 0, i8* %t53
  %t54 = getelementptr [2 x i8], [2 x i8]* %t51, i32 0, i32 0
  %t55 = call i8* @sailfin_runtime_string_concat(i8* %t54, i8* %t50)
  %s56 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1776141546, i32 0, i32 0
  %t57 = call i8* @sailfin_runtime_string_concat(i8* %t55, i8* %s56)
  %t58 = load i8*, i8** %l8
  %t59 = call i8* @sailfin_runtime_string_concat(i8* %t57, i8* %t58)
  %t60 = alloca [2 x i8], align 1
  %t61 = getelementptr [2 x i8], [2 x i8]* %t60, i32 0, i32 0
  store i8 41, i8* %t61
  %t62 = getelementptr [2 x i8], [2 x i8]* %t60, i32 0, i32 1
  store i8 0, i8* %t62
  %t63 = getelementptr [2 x i8], [2 x i8]* %t60, i32 0, i32 0
  %t64 = call i8* @sailfin_runtime_string_concat(i8* %t59, i8* %t63)
  store i8* %t64, i8** %l9
  %t65 = load i8*, i8** %l5
  %t66 = load i8*, i8** %l9
  %t67 = call i8* @sailfin_runtime_string_concat(i8* %t65, i8* %t66)
  %t68 = load i8*, i8** %l6
  %t69 = call i8* @sailfin_runtime_string_concat(i8* %t67, i8* %t68)
  store i8* %t69, i8** %l0
  br label %loop.latch2
loop.latch2:
  %t70 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t72 = load i8*, i8** %l0
  %t73 = load i8*, i8** %l0
  ret i8* %t73
}

define i8* @rewrite_length_accesses(i8* %expression) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca %ExtractedSpan
  %l3 = alloca i8*
  %l4 = alloca i8*
  %l5 = alloca i8*
  store i8* %expression, i8** %l0
  %t0 = load i8*, i8** %l0
  br label %loop.header0
loop.header0:
  %t56 = phi i8* [ %t0, %block.entry ], [ %t55, %loop.latch2 ]
  store i8* %t56, i8** %l0
  br label %loop.body1
loop.body1:
  %t1 = load i8*, i8** %l0
  %s2 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h1558772342, i32 0, i32 0
  %t3 = call double @index_of(i8* %t1, i8* %s2)
  store double %t3, double* %l1
  %t4 = load double, double* %l1
  %t5 = sitofp i64 0 to double
  %t6 = fcmp olt double %t4, %t5
  %t7 = load i8*, i8** %l0
  %t8 = load double, double* %l1
  br i1 %t6, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t9 = load i8*, i8** %l0
  %t10 = load double, double* %l1
  %t11 = call %ExtractedSpan @extract_object_span(i8* %t9, double %t10)
  store %ExtractedSpan %t11, %ExtractedSpan* %l2
  %t12 = load %ExtractedSpan, %ExtractedSpan* %l2
  %t13 = extractvalue %ExtractedSpan %t12, 3
  %t14 = xor i1 %t13, 1
  %t15 = load i8*, i8** %l0
  %t16 = load double, double* %l1
  %t17 = load %ExtractedSpan, %ExtractedSpan* %l2
  br i1 %t14, label %then6, label %merge7
then6:
  br label %afterloop3
merge7:
  %t18 = load i8*, i8** %l0
  %t19 = load %ExtractedSpan, %ExtractedSpan* %l2
  %t20 = extractvalue %ExtractedSpan %t19, 1
  %t21 = fptosi double %t20 to i64
  %t22 = call i8* @sailfin_runtime_substring(i8* %t18, i64 0, i64 %t21)
  store i8* %t22, i8** %l3
  %t23 = load i8*, i8** %l0
  %t24 = load double, double* %l1
  %t25 = sitofp i64 7 to double
  %t26 = fadd double %t24, %t25
  %t27 = load i8*, i8** %l0
  %t28 = call i64 @sailfin_runtime_string_length(i8* %t27)
  %t29 = fptosi double %t26 to i64
  %t30 = call i8* @sailfin_runtime_substring(i8* %t23, i64 %t29, i64 %t28)
  store i8* %t30, i8** %l4
  %t31 = load %ExtractedSpan, %ExtractedSpan* %l2
  %t32 = extractvalue %ExtractedSpan %t31, 0
  %t33 = call i8* @trim_text(i8* %t32)
  store i8* %t33, i8** %l5
  %t34 = load i8*, i8** %l5
  %t35 = call i64 @sailfin_runtime_string_length(i8* %t34)
  %t36 = icmp eq i64 %t35, 0
  %t37 = load i8*, i8** %l0
  %t38 = load double, double* %l1
  %t39 = load %ExtractedSpan, %ExtractedSpan* %l2
  %t40 = load i8*, i8** %l3
  %t41 = load i8*, i8** %l4
  %t42 = load i8*, i8** %l5
  br i1 %t36, label %then8, label %merge9
then8:
  br label %afterloop3
merge9:
  %t43 = load i8*, i8** %l3
  %s44 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h265982546, i32 0, i32 0
  %t45 = call i8* @sailfin_runtime_string_concat(i8* %t43, i8* %s44)
  %t46 = load i8*, i8** %l5
  %t47 = call i8* @sailfin_runtime_string_concat(i8* %t45, i8* %t46)
  %t48 = alloca [2 x i8], align 1
  %t49 = getelementptr [2 x i8], [2 x i8]* %t48, i32 0, i32 0
  store i8 41, i8* %t49
  %t50 = getelementptr [2 x i8], [2 x i8]* %t48, i32 0, i32 1
  store i8 0, i8* %t50
  %t51 = getelementptr [2 x i8], [2 x i8]* %t48, i32 0, i32 0
  %t52 = call i8* @sailfin_runtime_string_concat(i8* %t47, i8* %t51)
  %t53 = load i8*, i8** %l4
  %t54 = call i8* @sailfin_runtime_string_concat(i8* %t52, i8* %t53)
  store i8* %t54, i8** %l0
  br label %loop.latch2
loop.latch2:
  %t55 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t57 = load i8*, i8** %l0
  %t58 = load i8*, i8** %l0
  ret i8* %t58
}

define %ExtractedSpan @extract_object_span(i8* %text, double %dot_index) {
block.entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca i8*
  %l4 = alloca double
  %l5 = alloca i8*
  %t0 = sitofp i64 0 to double
  %t1 = fcmp ole double %dot_index, %t0
  br i1 %t1, label %then0, label %merge1
then0:
  %s2 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t3 = insertvalue %ExtractedSpan undef, i8* %s2, 0
  %t4 = sitofp i64 0 to double
  %t5 = insertvalue %ExtractedSpan %t3, double %t4, 1
  %t6 = sitofp i64 0 to double
  %t7 = insertvalue %ExtractedSpan %t5, double %t6, 2
  %t8 = insertvalue %ExtractedSpan %t7, i1 0, 3
  ret %ExtractedSpan %t8
merge1:
  %t9 = sitofp i64 1 to double
  %t10 = fsub double %dot_index, %t9
  store double %t10, double* %l0
  %t11 = sitofp i64 0 to double
  store double %t11, double* %l1
  %t12 = sitofp i64 0 to double
  store double %t12, double* %l2
  %t13 = load double, double* %l0
  %t14 = load double, double* %l1
  %t15 = load double, double* %l2
  br label %loop.header2
loop.header2:
  %t127 = phi double [ %t14, %merge1 ], [ %t124, %loop.latch4 ]
  %t128 = phi double [ %t13, %merge1 ], [ %t125, %loop.latch4 ]
  %t129 = phi double [ %t15, %merge1 ], [ %t126, %loop.latch4 ]
  store double %t127, double* %l1
  store double %t128, double* %l0
  store double %t129, double* %l2
  br label %loop.body3
loop.body3:
  %t16 = load double, double* %l0
  %t17 = sitofp i64 0 to double
  %t18 = fcmp olt double %t16, %t17
  %t19 = load double, double* %l0
  %t20 = load double, double* %l1
  %t21 = load double, double* %l2
  br i1 %t18, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t22 = load double, double* %l0
  %t23 = load double, double* %l0
  %t24 = sitofp i64 1 to double
  %t25 = fadd double %t23, %t24
  %t26 = fptosi double %t22 to i64
  %t27 = fptosi double %t25 to i64
  %t28 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t26, i64 %t27)
  store i8* %t28, i8** %l3
  %t29 = load i8*, i8** %l3
  %t30 = load i8, i8* %t29
  %t31 = icmp eq i8 %t30, 93
  %t32 = load double, double* %l0
  %t33 = load double, double* %l1
  %t34 = load double, double* %l2
  %t35 = load i8*, i8** %l3
  br i1 %t31, label %then8, label %merge9
then8:
  %t36 = load double, double* %l1
  %t37 = sitofp i64 1 to double
  %t38 = fadd double %t36, %t37
  store double %t38, double* %l1
  %t39 = load double, double* %l0
  %t40 = sitofp i64 1 to double
  %t41 = fsub double %t39, %t40
  store double %t41, double* %l0
  br label %loop.latch4
merge9:
  %t42 = load i8*, i8** %l3
  %t43 = load i8, i8* %t42
  %t44 = icmp eq i8 %t43, 91
  %t45 = load double, double* %l0
  %t46 = load double, double* %l1
  %t47 = load double, double* %l2
  %t48 = load i8*, i8** %l3
  br i1 %t44, label %then10, label %merge11
then10:
  %t49 = load double, double* %l1
  %t50 = sitofp i64 0 to double
  %t51 = fcmp ogt double %t49, %t50
  %t52 = load double, double* %l0
  %t53 = load double, double* %l1
  %t54 = load double, double* %l2
  %t55 = load i8*, i8** %l3
  br i1 %t51, label %then12, label %merge13
then12:
  %t56 = load double, double* %l1
  %t57 = sitofp i64 1 to double
  %t58 = fsub double %t56, %t57
  store double %t58, double* %l1
  %t59 = load double, double* %l0
  %t60 = sitofp i64 1 to double
  %t61 = fsub double %t59, %t60
  store double %t61, double* %l0
  br label %loop.latch4
merge13:
  br label %afterloop5
merge11:
  %t62 = load i8*, i8** %l3
  %t63 = load i8, i8* %t62
  %t64 = icmp eq i8 %t63, 41
  %t65 = load double, double* %l0
  %t66 = load double, double* %l1
  %t67 = load double, double* %l2
  %t68 = load i8*, i8** %l3
  br i1 %t64, label %then14, label %merge15
then14:
  %t69 = load double, double* %l2
  %t70 = sitofp i64 1 to double
  %t71 = fadd double %t69, %t70
  store double %t71, double* %l2
  %t72 = load double, double* %l0
  %t73 = sitofp i64 1 to double
  %t74 = fsub double %t72, %t73
  store double %t74, double* %l0
  br label %loop.latch4
merge15:
  %t75 = load i8*, i8** %l3
  %t76 = load i8, i8* %t75
  %t77 = icmp eq i8 %t76, 40
  %t78 = load double, double* %l0
  %t79 = load double, double* %l1
  %t80 = load double, double* %l2
  %t81 = load i8*, i8** %l3
  br i1 %t77, label %then16, label %merge17
then16:
  %t82 = load double, double* %l2
  %t83 = sitofp i64 0 to double
  %t84 = fcmp ogt double %t82, %t83
  %t85 = load double, double* %l0
  %t86 = load double, double* %l1
  %t87 = load double, double* %l2
  %t88 = load i8*, i8** %l3
  br i1 %t84, label %then18, label %merge19
then18:
  %t89 = load double, double* %l2
  %t90 = sitofp i64 1 to double
  %t91 = fsub double %t89, %t90
  store double %t91, double* %l2
  %t92 = load double, double* %l0
  %t93 = sitofp i64 1 to double
  %t94 = fsub double %t92, %t93
  store double %t94, double* %l0
  br label %loop.latch4
merge19:
  br label %afterloop5
merge17:
  %t96 = load double, double* %l1
  %t97 = sitofp i64 0 to double
  %t98 = fcmp ogt double %t96, %t97
  br label %logical_or_entry_95

logical_or_entry_95:
  br i1 %t98, label %logical_or_merge_95, label %logical_or_right_95

logical_or_right_95:
  %t99 = load double, double* %l2
  %t100 = sitofp i64 0 to double
  %t101 = fcmp ogt double %t99, %t100
  br label %logical_or_right_end_95

logical_or_right_end_95:
  br label %logical_or_merge_95

logical_or_merge_95:
  %t102 = phi i1 [ true, %logical_or_entry_95 ], [ %t101, %logical_or_right_end_95 ]
  %t103 = load double, double* %l0
  %t104 = load double, double* %l1
  %t105 = load double, double* %l2
  %t106 = load i8*, i8** %l3
  br i1 %t102, label %then20, label %merge21
then20:
  %t107 = load double, double* %l0
  %t108 = sitofp i64 1 to double
  %t109 = fsub double %t107, %t108
  store double %t109, double* %l0
  br label %loop.latch4
merge21:
  %t111 = load i8*, i8** %l3
  %t112 = call i1 @is_identifier_char(i8* %t111)
  br label %logical_or_entry_110

logical_or_entry_110:
  br i1 %t112, label %logical_or_merge_110, label %logical_or_right_110

logical_or_right_110:
  %t113 = load i8*, i8** %l3
  %t114 = load i8, i8* %t113
  %t115 = icmp eq i8 %t114, 46
  br label %logical_or_right_end_110

logical_or_right_end_110:
  br label %logical_or_merge_110

logical_or_merge_110:
  %t116 = phi i1 [ true, %logical_or_entry_110 ], [ %t115, %logical_or_right_end_110 ]
  %t117 = load double, double* %l0
  %t118 = load double, double* %l1
  %t119 = load double, double* %l2
  %t120 = load i8*, i8** %l3
  br i1 %t116, label %then22, label %merge23
then22:
  %t121 = load double, double* %l0
  %t122 = sitofp i64 1 to double
  %t123 = fsub double %t121, %t122
  store double %t123, double* %l0
  br label %loop.latch4
merge23:
  br label %afterloop5
loop.latch4:
  %t124 = load double, double* %l1
  %t125 = load double, double* %l0
  %t126 = load double, double* %l2
  br label %loop.header2
afterloop5:
  %t130 = load double, double* %l1
  %t131 = load double, double* %l0
  %t132 = load double, double* %l2
  %t133 = load double, double* %l0
  %t134 = sitofp i64 1 to double
  %t135 = fadd double %t133, %t134
  store double %t135, double* %l4
  %t136 = load double, double* %l4
  %t137 = fcmp oge double %t136, %dot_index
  %t138 = load double, double* %l0
  %t139 = load double, double* %l1
  %t140 = load double, double* %l2
  %t141 = load double, double* %l4
  br i1 %t137, label %then24, label %merge25
then24:
  %s142 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t143 = insertvalue %ExtractedSpan undef, i8* %s142, 0
  %t144 = load double, double* %l4
  %t145 = insertvalue %ExtractedSpan %t143, double %t144, 1
  %t146 = insertvalue %ExtractedSpan %t145, double %dot_index, 2
  %t147 = insertvalue %ExtractedSpan %t146, i1 0, 3
  ret %ExtractedSpan %t147
merge25:
  %t148 = load double, double* %l4
  %t149 = fptosi double %t148 to i64
  %t150 = fptosi double %dot_index to i64
  %t151 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t149, i64 %t150)
  store i8* %t151, i8** %l5
  %t152 = load i8*, i8** %l5
  %t153 = insertvalue %ExtractedSpan undef, i8* %t152, 0
  %t154 = load double, double* %l4
  %t155 = insertvalue %ExtractedSpan %t153, double %t154, 1
  %t156 = insertvalue %ExtractedSpan %t155, double %dot_index, 2
  %t157 = insertvalue %ExtractedSpan %t156, i1 1, 3
  ret %ExtractedSpan %t157
}

define %ExtractedSpan @extract_parenthesized_span(i8* %text, double %open_index) {
block.entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca i8*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t1 = sitofp i64 %t0 to double
  %t2 = fcmp oge double %open_index, %t1
  br i1 %t2, label %then0, label %merge1
then0:
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t4 = insertvalue %ExtractedSpan undef, i8* %s3, 0
  %t5 = insertvalue %ExtractedSpan %t4, double %open_index, 1
  %t6 = insertvalue %ExtractedSpan %t5, double %open_index, 2
  %t7 = insertvalue %ExtractedSpan %t6, i1 0, 3
  ret %ExtractedSpan %t7
merge1:
  %t8 = sitofp i64 1 to double
  %t9 = fadd double %open_index, %t8
  %t10 = fptosi double %open_index to i64
  %t11 = fptosi double %t9 to i64
  %t12 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t10, i64 %t11)
  %t13 = load i8, i8* %t12
  %t14 = icmp ne i8 %t13, 40
  br i1 %t14, label %then2, label %merge3
then2:
  %s15 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t16 = insertvalue %ExtractedSpan undef, i8* %s15, 0
  %t17 = insertvalue %ExtractedSpan %t16, double %open_index, 1
  %t18 = insertvalue %ExtractedSpan %t17, double %open_index, 2
  %t19 = insertvalue %ExtractedSpan %t18, i1 0, 3
  ret %ExtractedSpan %t19
merge3:
  %t20 = sitofp i64 1 to double
  %t21 = fadd double %open_index, %t20
  store double %t21, double* %l0
  %t22 = sitofp i64 1 to double
  store double %t22, double* %l1
  %t23 = load double, double* %l0
  %t24 = load double, double* %l1
  br label %loop.header4
loop.header4:
  %t105 = phi double [ %t24, %merge3 ], [ %t103, %loop.latch6 ]
  %t106 = phi double [ %t23, %merge3 ], [ %t104, %loop.latch6 ]
  store double %t105, double* %l1
  store double %t106, double* %l0
  br label %loop.body5
loop.body5:
  %t25 = load double, double* %l0
  %t26 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t27 = sitofp i64 %t26 to double
  %t28 = fcmp oge double %t25, %t27
  %t29 = load double, double* %l0
  %t30 = load double, double* %l1
  br i1 %t28, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t31 = load double, double* %l0
  %t32 = load double, double* %l0
  %t33 = sitofp i64 1 to double
  %t34 = fadd double %t32, %t33
  %t35 = fptosi double %t31 to i64
  %t36 = fptosi double %t34 to i64
  %t37 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t35, i64 %t36)
  store i8* %t37, i8** %l2
  %t38 = load i8*, i8** %l2
  %t39 = load i8, i8* %t38
  %t40 = icmp eq i8 %t39, 40
  %t41 = load double, double* %l0
  %t42 = load double, double* %l1
  %t43 = load i8*, i8** %l2
  br i1 %t40, label %then10, label %else11
then10:
  %t44 = load double, double* %l1
  %t45 = sitofp i64 1 to double
  %t46 = fadd double %t44, %t45
  store double %t46, double* %l1
  %t47 = load double, double* %l1
  br label %merge12
else11:
  %t48 = load i8*, i8** %l2
  %t49 = load i8, i8* %t48
  %t50 = icmp eq i8 %t49, 41
  %t51 = load double, double* %l0
  %t52 = load double, double* %l1
  %t53 = load i8*, i8** %l2
  br i1 %t50, label %then13, label %else14
then13:
  %t54 = load double, double* %l1
  %t55 = sitofp i64 1 to double
  %t56 = fsub double %t54, %t55
  store double %t56, double* %l1
  %t57 = load double, double* %l1
  %t58 = sitofp i64 0 to double
  %t59 = fcmp oeq double %t57, %t58
  %t60 = load double, double* %l0
  %t61 = load double, double* %l1
  %t62 = load i8*, i8** %l2
  br i1 %t59, label %then16, label %merge17
then16:
  %t63 = sitofp i64 1 to double
  %t64 = fadd double %open_index, %t63
  %t65 = load double, double* %l0
  %t66 = fptosi double %t64 to i64
  %t67 = fptosi double %t65 to i64
  %t68 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t66, i64 %t67)
  store i8* %t68, i8** %l3
  %t69 = load i8*, i8** %l3
  %t70 = insertvalue %ExtractedSpan undef, i8* %t69, 0
  %t71 = sitofp i64 1 to double
  %t72 = fadd double %open_index, %t71
  %t73 = insertvalue %ExtractedSpan %t70, double %t72, 1
  %t74 = load double, double* %l0
  %t75 = sitofp i64 1 to double
  %t76 = fadd double %t74, %t75
  %t77 = insertvalue %ExtractedSpan %t73, double %t76, 2
  %t78 = insertvalue %ExtractedSpan %t77, i1 1, 3
  ret %ExtractedSpan %t78
merge17:
  %t79 = load double, double* %l1
  br label %merge15
else14:
  %t81 = load i8*, i8** %l2
  %t82 = load i8, i8* %t81
  %t83 = icmp eq i8 %t82, 34
  br label %logical_or_entry_80

logical_or_entry_80:
  br i1 %t83, label %logical_or_merge_80, label %logical_or_right_80

logical_or_right_80:
  %t84 = load i8*, i8** %l2
  %t85 = load i8, i8* %t84
  %t86 = icmp eq i8 %t85, 39
  br label %logical_or_right_end_80

logical_or_right_end_80:
  br label %logical_or_merge_80

logical_or_merge_80:
  %t87 = phi i1 [ true, %logical_or_entry_80 ], [ %t86, %logical_or_right_end_80 ]
  %t88 = load double, double* %l0
  %t89 = load double, double* %l1
  %t90 = load i8*, i8** %l2
  br i1 %t87, label %then18, label %merge19
then18:
  %t91 = load double, double* %l0
  %t92 = call double @skip_string_literal(i8* %text, double %t91)
  store double %t92, double* %l0
  br label %loop.latch6
merge19:
  %t93 = load double, double* %l0
  br label %merge15
merge15:
  %t94 = phi double [ %t79, %merge17 ], [ %t52, %merge19 ]
  %t95 = phi double [ %t51, %merge17 ], [ %t93, %merge19 ]
  store double %t94, double* %l1
  store double %t95, double* %l0
  %t96 = load double, double* %l1
  %t97 = load double, double* %l0
  br label %merge12
merge12:
  %t98 = phi double [ %t47, %then10 ], [ %t96, %merge15 ]
  %t99 = phi double [ %t41, %then10 ], [ %t97, %merge15 ]
  store double %t98, double* %l1
  store double %t99, double* %l0
  %t100 = load double, double* %l0
  %t101 = sitofp i64 1 to double
  %t102 = fadd double %t100, %t101
  store double %t102, double* %l0
  br label %loop.latch6
loop.latch6:
  %t103 = load double, double* %l1
  %t104 = load double, double* %l0
  br label %loop.header4
afterloop7:
  %t107 = load double, double* %l1
  %t108 = load double, double* %l0
  %s109 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t110 = insertvalue %ExtractedSpan undef, i8* %s109, 0
  %t111 = insertvalue %ExtractedSpan %t110, double %open_index, 1
  %t112 = insertvalue %ExtractedSpan %t111, double %open_index, 2
  %t113 = insertvalue %ExtractedSpan %t112, i1 0, 3
  ret %ExtractedSpan %t113
}

define double @skip_string_literal(i8* %text, double %quote_index) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8*
  %t0 = sitofp i64 1 to double
  %t1 = fadd double %quote_index, %t0
  %t2 = fptosi double %quote_index to i64
  %t3 = fptosi double %t1 to i64
  %t4 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t2, i64 %t3)
  store i8* %t4, i8** %l0
  %t5 = sitofp i64 1 to double
  %t6 = fadd double %quote_index, %t5
  store double %t6, double* %l1
  %t7 = load i8*, i8** %l0
  %t8 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t44 = phi double [ %t8, %block.entry ], [ %t43, %loop.latch2 ]
  store double %t44, double* %l1
  br label %loop.body1
loop.body1:
  %t9 = load double, double* %l1
  %t10 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t9, %t11
  %t13 = load i8*, i8** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l1
  %t16 = load double, double* %l1
  %t17 = sitofp i64 1 to double
  %t18 = fadd double %t16, %t17
  %t19 = fptosi double %t15 to i64
  %t20 = fptosi double %t18 to i64
  %t21 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t19, i64 %t20)
  store i8* %t21, i8** %l2
  %t22 = load i8*, i8** %l2
  %t23 = load i8, i8* %t22
  %t24 = icmp eq i8 %t23, 92
  %t25 = load i8*, i8** %l0
  %t26 = load double, double* %l1
  %t27 = load i8*, i8** %l2
  br i1 %t24, label %then6, label %merge7
then6:
  %t28 = load double, double* %l1
  %t29 = sitofp i64 2 to double
  %t30 = fadd double %t28, %t29
  store double %t30, double* %l1
  br label %loop.latch2
merge7:
  %t31 = load i8*, i8** %l2
  %t32 = load i8*, i8** %l0
  %t33 = icmp eq i8* %t31, %t32
  %t34 = load i8*, i8** %l0
  %t35 = load double, double* %l1
  %t36 = load i8*, i8** %l2
  br i1 %t33, label %then8, label %merge9
then8:
  %t37 = load double, double* %l1
  %t38 = sitofp i64 1 to double
  %t39 = fadd double %t37, %t38
  store double %t39, double* %l1
  br label %afterloop3
merge9:
  %t40 = load double, double* %l1
  %t41 = sitofp i64 1 to double
  %t42 = fadd double %t40, %t41
  store double %t42, double* %l1
  br label %loop.latch2
loop.latch2:
  %t43 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t45 = load double, double* %l1
  %t46 = load double, double* %l1
  ret double %t46
}

define %ExpressionContinuationCapture @capture_expression_continuation(i8* %initial, { %NativeInstruction*, i64 }* %instructions, double %start_index) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca i1
  %l8 = alloca i8*
  %l9 = alloca i8*
  %l10 = alloca i1
  %l11 = alloca double
  %l12 = alloca i8*
  %l13 = alloca i8*
  %l14 = alloca i8*
  %l15 = alloca i8*
  %t0 = call i8* @trim_text(i8* %initial)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = load i8*, i8** %l0
  %t6 = insertvalue %ExpressionContinuationCapture undef, i8* %t5, 0
  %t7 = sitofp i64 0 to double
  %t8 = insertvalue %ExpressionContinuationCapture %t6, double %t7, 1
  %t9 = insertvalue %ExpressionContinuationCapture %t8, i1 0, 2
  ret %ExpressionContinuationCapture %t9
merge1:
  %t10 = load i8*, i8** %l0
  %t11 = call double @compute_parenthesis_balance(i8* %t10)
  store double %t11, double* %l1
  %t12 = load i8*, i8** %l0
  %t13 = call double @compute_brace_balance(i8* %t12)
  store double %t13, double* %l2
  %t14 = load i8*, i8** %l0
  %t15 = call double @compute_bracket_balance(i8* %t14)
  store double %t15, double* %l3
  %t16 = load i8*, i8** %l0
  store i8* %t16, i8** %l4
  store double %start_index, double* %l5
  %t17 = sitofp i64 0 to double
  store double %t17, double* %l6
  %t19 = load double, double* %l1
  %t20 = sitofp i64 0 to double
  %t21 = fcmp ogt double %t19, %t20
  br label %logical_or_entry_18

logical_or_entry_18:
  br i1 %t21, label %logical_or_merge_18, label %logical_or_right_18

logical_or_right_18:
  %t23 = load double, double* %l2
  %t24 = sitofp i64 0 to double
  %t25 = fcmp ogt double %t23, %t24
  br label %logical_or_entry_22

logical_or_entry_22:
  br i1 %t25, label %logical_or_merge_22, label %logical_or_right_22

logical_or_right_22:
  %t26 = load double, double* %l3
  %t27 = sitofp i64 0 to double
  %t28 = fcmp ogt double %t26, %t27
  br label %logical_or_right_end_22

logical_or_right_end_22:
  br label %logical_or_merge_22

logical_or_merge_22:
  %t29 = phi i1 [ true, %logical_or_entry_22 ], [ %t28, %logical_or_right_end_22 ]
  br label %logical_or_right_end_18

logical_or_right_end_18:
  br label %logical_or_merge_18

logical_or_merge_18:
  %t30 = phi i1 [ true, %logical_or_entry_18 ], [ %t29, %logical_or_right_end_18 ]
  store i1 %t30, i1* %l7
  %t31 = load i8*, i8** %l0
  %t32 = load double, double* %l1
  %t33 = load double, double* %l2
  %t34 = load double, double* %l3
  %t35 = load i8*, i8** %l4
  %t36 = load double, double* %l5
  %t37 = load double, double* %l6
  %t38 = load i1, i1* %l7
  br label %loop.header2
loop.header2:
  %t297 = phi double [ %t36, %logical_or_merge_18 ], [ %t290, %loop.latch4 ]
  %t298 = phi double [ %t37, %logical_or_merge_18 ], [ %t291, %loop.latch4 ]
  %t299 = phi i1 [ %t38, %logical_or_merge_18 ], [ %t292, %loop.latch4 ]
  %t300 = phi i8* [ %t35, %logical_or_merge_18 ], [ %t293, %loop.latch4 ]
  %t301 = phi double [ %t32, %logical_or_merge_18 ], [ %t294, %loop.latch4 ]
  %t302 = phi double [ %t33, %logical_or_merge_18 ], [ %t295, %loop.latch4 ]
  %t303 = phi double [ %t34, %logical_or_merge_18 ], [ %t296, %loop.latch4 ]
  store double %t297, double* %l5
  store double %t298, double* %l6
  store i1 %t299, i1* %l7
  store i8* %t300, i8** %l4
  store double %t301, double* %l1
  store double %t302, double* %l2
  store double %t303, double* %l3
  br label %loop.body3
loop.body3:
  %t39 = load double, double* %l5
  %t40 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %instructions
  %t41 = extractvalue { %NativeInstruction*, i64 } %t40, 1
  %t42 = sitofp i64 %t41 to double
  %t43 = fcmp oge double %t39, %t42
  %t44 = load i8*, i8** %l0
  %t45 = load double, double* %l1
  %t46 = load double, double* %l2
  %t47 = load double, double* %l3
  %t48 = load i8*, i8** %l4
  %t49 = load double, double* %l5
  %t50 = load double, double* %l6
  %t51 = load i1, i1* %l7
  br i1 %t43, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t52 = load double, double* %l5
  %t53 = fptosi double %t52 to i64
  %t54 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %instructions
  %t55 = extractvalue { %NativeInstruction*, i64 } %t54, 0
  %t56 = extractvalue { %NativeInstruction*, i64 } %t54, 1
  %t57 = icmp uge i64 %t53, %t56
  ; bounds check: %t57 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t53, i64 %t56)
  %t58 = getelementptr %NativeInstruction, %NativeInstruction* %t55, i64 %t53
  %t59 = load %NativeInstruction, %NativeInstruction* %t58
  %t60 = call i8* @continuation_segment_text(%NativeInstruction %t59)
  store i8* %t60, i8** %l8
  %t61 = load i8*, i8** %l8
  %t62 = icmp eq i8* %t61, null
  %t63 = load i8*, i8** %l0
  %t64 = load double, double* %l1
  %t65 = load double, double* %l2
  %t66 = load double, double* %l3
  %t67 = load i8*, i8** %l4
  %t68 = load double, double* %l5
  %t69 = load double, double* %l6
  %t70 = load i1, i1* %l7
  %t71 = load i8*, i8** %l8
  br i1 %t62, label %then8, label %merge9
then8:
  br label %afterloop5
merge9:
  %t72 = load i8*, i8** %l8
  %t73 = call i8* @trim_text(i8* %t72)
  store i8* %t73, i8** %l9
  %t74 = load i8*, i8** %l9
  %t75 = call i64 @sailfin_runtime_string_length(i8* %t74)
  %t76 = icmp eq i64 %t75, 0
  %t77 = load i8*, i8** %l0
  %t78 = load double, double* %l1
  %t79 = load double, double* %l2
  %t80 = load double, double* %l3
  %t81 = load i8*, i8** %l4
  %t82 = load double, double* %l5
  %t83 = load double, double* %l6
  %t84 = load i1, i1* %l7
  %t85 = load i8*, i8** %l8
  %t86 = load i8*, i8** %l9
  br i1 %t76, label %then10, label %merge11
then10:
  %t87 = load double, double* %l5
  %t88 = sitofp i64 1 to double
  %t89 = fadd double %t87, %t88
  store double %t89, double* %l5
  %t90 = load double, double* %l6
  %t91 = sitofp i64 1 to double
  %t92 = fadd double %t90, %t91
  store double %t92, double* %l6
  br label %loop.latch4
merge11:
  %t93 = load i1, i1* %l7
  %t94 = xor i1 %t93, 1
  %t95 = load i8*, i8** %l0
  %t96 = load double, double* %l1
  %t97 = load double, double* %l2
  %t98 = load double, double* %l3
  %t99 = load i8*, i8** %l4
  %t100 = load double, double* %l5
  %t101 = load double, double* %l6
  %t102 = load i1, i1* %l7
  %t103 = load i8*, i8** %l8
  %t104 = load i8*, i8** %l9
  br i1 %t94, label %then12, label %merge13
then12:
  %t105 = load i8*, i8** %l9
  %t106 = call i1 @segment_signals_expression_continuation(i8* %t105)
  %t107 = xor i1 %t106, 1
  %t108 = load i8*, i8** %l0
  %t109 = load double, double* %l1
  %t110 = load double, double* %l2
  %t111 = load double, double* %l3
  %t112 = load i8*, i8** %l4
  %t113 = load double, double* %l5
  %t114 = load double, double* %l6
  %t115 = load i1, i1* %l7
  %t116 = load i8*, i8** %l8
  %t117 = load i8*, i8** %l9
  br i1 %t107, label %then14, label %merge15
then14:
  br label %afterloop5
merge15:
  store i1 1, i1* %l7
  %t118 = load i1, i1* %l7
  br label %merge13
merge13:
  %t119 = phi i1 [ %t118, %merge15 ], [ %t102, %merge11 ]
  store i1 %t119, i1* %l7
  %t120 = load i8*, i8** %l4
  %t121 = alloca [2 x i8], align 1
  %t122 = getelementptr [2 x i8], [2 x i8]* %t121, i32 0, i32 0
  store i8 32, i8* %t122
  %t123 = getelementptr [2 x i8], [2 x i8]* %t121, i32 0, i32 1
  store i8 0, i8* %t123
  %t124 = getelementptr [2 x i8], [2 x i8]* %t121, i32 0, i32 0
  %t125 = call i8* @sailfin_runtime_string_concat(i8* %t120, i8* %t124)
  %t126 = load i8*, i8** %l9
  %t127 = call i8* @sailfin_runtime_string_concat(i8* %t125, i8* %t126)
  store i8* %t127, i8** %l4
  %t128 = load double, double* %l1
  %t129 = load i8*, i8** %l9
  %t130 = call double @compute_parenthesis_balance(i8* %t129)
  %t131 = fadd double %t128, %t130
  store double %t131, double* %l1
  %t132 = load double, double* %l2
  %t133 = load i8*, i8** %l9
  %t134 = call double @compute_brace_balance(i8* %t133)
  %t135 = fadd double %t132, %t134
  store double %t135, double* %l2
  %t136 = load double, double* %l3
  %t137 = load i8*, i8** %l9
  %t138 = call double @compute_bracket_balance(i8* %t137)
  %t139 = fadd double %t136, %t138
  store double %t139, double* %l3
  %t140 = load double, double* %l6
  %t141 = sitofp i64 1 to double
  %t142 = fadd double %t140, %t141
  store double %t142, double* %l6
  %t143 = load double, double* %l5
  %t144 = sitofp i64 1 to double
  %t145 = fadd double %t143, %t144
  store double %t145, double* %l5
  %t147 = load double, double* %l1
  %t148 = sitofp i64 0 to double
  %t149 = fcmp ole double %t147, %t148
  br label %logical_and_entry_146

logical_and_entry_146:
  br i1 %t149, label %logical_and_right_146, label %logical_and_merge_146

logical_and_right_146:
  %t151 = load double, double* %l2
  %t152 = sitofp i64 0 to double
  %t153 = fcmp ole double %t151, %t152
  br label %logical_and_entry_150

logical_and_entry_150:
  br i1 %t153, label %logical_and_right_150, label %logical_and_merge_150

logical_and_right_150:
  %t154 = load double, double* %l3
  %t155 = sitofp i64 0 to double
  %t156 = fcmp ole double %t154, %t155
  br label %logical_and_right_end_150

logical_and_right_end_150:
  br label %logical_and_merge_150

logical_and_merge_150:
  %t157 = phi i1 [ false, %logical_and_entry_150 ], [ %t156, %logical_and_right_end_150 ]
  br label %logical_and_right_end_146

logical_and_right_end_146:
  br label %logical_and_merge_146

logical_and_merge_146:
  %t158 = phi i1 [ false, %logical_and_entry_146 ], [ %t157, %logical_and_right_end_146 ]
  %t159 = load i8*, i8** %l0
  %t160 = load double, double* %l1
  %t161 = load double, double* %l2
  %t162 = load double, double* %l3
  %t163 = load i8*, i8** %l4
  %t164 = load double, double* %l5
  %t165 = load double, double* %l6
  %t166 = load i1, i1* %l7
  %t167 = load i8*, i8** %l8
  %t168 = load i8*, i8** %l9
  br i1 %t158, label %then16, label %merge17
then16:
  store i1 1, i1* %l10
  %t169 = load double, double* %l5
  store double %t169, double* %l11
  %t170 = load i8*, i8** %l0
  %t171 = load double, double* %l1
  %t172 = load double, double* %l2
  %t173 = load double, double* %l3
  %t174 = load i8*, i8** %l4
  %t175 = load double, double* %l5
  %t176 = load double, double* %l6
  %t177 = load i1, i1* %l7
  %t178 = load i8*, i8** %l8
  %t179 = load i8*, i8** %l9
  %t180 = load i1, i1* %l10
  %t181 = load double, double* %l11
  br label %loop.header18
loop.header18:
  %t265 = phi double [ %t181, %then16 ], [ %t263, %loop.latch20 ]
  %t266 = phi i1 [ %t180, %then16 ], [ %t264, %loop.latch20 ]
  store double %t265, double* %l11
  store i1 %t266, i1* %l10
  br label %loop.body19
loop.body19:
  %t182 = load double, double* %l11
  %t183 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %instructions
  %t184 = extractvalue { %NativeInstruction*, i64 } %t183, 1
  %t185 = sitofp i64 %t184 to double
  %t186 = fcmp oge double %t182, %t185
  %t187 = load i8*, i8** %l0
  %t188 = load double, double* %l1
  %t189 = load double, double* %l2
  %t190 = load double, double* %l3
  %t191 = load i8*, i8** %l4
  %t192 = load double, double* %l5
  %t193 = load double, double* %l6
  %t194 = load i1, i1* %l7
  %t195 = load i8*, i8** %l8
  %t196 = load i8*, i8** %l9
  %t197 = load i1, i1* %l10
  %t198 = load double, double* %l11
  br i1 %t186, label %then22, label %merge23
then22:
  br label %afterloop21
merge23:
  %t199 = load double, double* %l11
  %t200 = fptosi double %t199 to i64
  %t201 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %instructions
  %t202 = extractvalue { %NativeInstruction*, i64 } %t201, 0
  %t203 = extractvalue { %NativeInstruction*, i64 } %t201, 1
  %t204 = icmp uge i64 %t200, %t203
  ; bounds check: %t204 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t200, i64 %t203)
  %t205 = getelementptr %NativeInstruction, %NativeInstruction* %t202, i64 %t200
  %t206 = load %NativeInstruction, %NativeInstruction* %t205
  %t207 = call i8* @continuation_segment_text(%NativeInstruction %t206)
  store i8* %t207, i8** %l12
  %t208 = load i8*, i8** %l12
  %t209 = icmp eq i8* %t208, null
  %t210 = load i8*, i8** %l0
  %t211 = load double, double* %l1
  %t212 = load double, double* %l2
  %t213 = load double, double* %l3
  %t214 = load i8*, i8** %l4
  %t215 = load double, double* %l5
  %t216 = load double, double* %l6
  %t217 = load i1, i1* %l7
  %t218 = load i8*, i8** %l8
  %t219 = load i8*, i8** %l9
  %t220 = load i1, i1* %l10
  %t221 = load double, double* %l11
  %t222 = load i8*, i8** %l12
  br i1 %t209, label %then24, label %merge25
then24:
  br label %afterloop21
merge25:
  %t223 = load i8*, i8** %l12
  %t224 = call i8* @trim_text(i8* %t223)
  store i8* %t224, i8** %l13
  %t225 = load i8*, i8** %l13
  %t226 = call i64 @sailfin_runtime_string_length(i8* %t225)
  %t227 = icmp eq i64 %t226, 0
  %t228 = load i8*, i8** %l0
  %t229 = load double, double* %l1
  %t230 = load double, double* %l2
  %t231 = load double, double* %l3
  %t232 = load i8*, i8** %l4
  %t233 = load double, double* %l5
  %t234 = load double, double* %l6
  %t235 = load i1, i1* %l7
  %t236 = load i8*, i8** %l8
  %t237 = load i8*, i8** %l9
  %t238 = load i1, i1* %l10
  %t239 = load double, double* %l11
  %t240 = load i8*, i8** %l12
  %t241 = load i8*, i8** %l13
  br i1 %t227, label %then26, label %merge27
then26:
  %t242 = load double, double* %l11
  %t243 = sitofp i64 1 to double
  %t244 = fadd double %t242, %t243
  store double %t244, double* %l11
  br label %loop.latch20
merge27:
  %t245 = load i8*, i8** %l13
  %t246 = call i1 @segment_signals_expression_continuation(i8* %t245)
  %t247 = load i8*, i8** %l0
  %t248 = load double, double* %l1
  %t249 = load double, double* %l2
  %t250 = load double, double* %l3
  %t251 = load i8*, i8** %l4
  %t252 = load double, double* %l5
  %t253 = load double, double* %l6
  %t254 = load i1, i1* %l7
  %t255 = load i8*, i8** %l8
  %t256 = load i8*, i8** %l9
  %t257 = load i1, i1* %l10
  %t258 = load double, double* %l11
  %t259 = load i8*, i8** %l12
  %t260 = load i8*, i8** %l13
  br i1 %t246, label %then28, label %merge29
then28:
  store i1 0, i1* %l10
  %t261 = load i1, i1* %l10
  br label %merge29
merge29:
  %t262 = phi i1 [ %t261, %then28 ], [ %t257, %merge27 ]
  store i1 %t262, i1* %l10
  br label %afterloop21
loop.latch20:
  %t263 = load double, double* %l11
  %t264 = load i1, i1* %l10
  br label %loop.header18
afterloop21:
  %t267 = load double, double* %l11
  %t268 = load i1, i1* %l10
  %t269 = load i1, i1* %l10
  %t270 = load i8*, i8** %l0
  %t271 = load double, double* %l1
  %t272 = load double, double* %l2
  %t273 = load double, double* %l3
  %t274 = load i8*, i8** %l4
  %t275 = load double, double* %l5
  %t276 = load double, double* %l6
  %t277 = load i1, i1* %l7
  %t278 = load i8*, i8** %l8
  %t279 = load i8*, i8** %l9
  %t280 = load i1, i1* %l10
  %t281 = load double, double* %l11
  br i1 %t269, label %then30, label %merge31
then30:
  %t282 = load i8*, i8** %l4
  %t283 = call i8* @trim_text(i8* %t282)
  %t284 = call i8* @trim_trailing_delimiters(i8* %t283)
  store i8* %t284, i8** %l14
  %t285 = load i8*, i8** %l14
  %t286 = insertvalue %ExpressionContinuationCapture undef, i8* %t285, 0
  %t287 = load double, double* %l6
  %t288 = insertvalue %ExpressionContinuationCapture %t286, double %t287, 1
  %t289 = insertvalue %ExpressionContinuationCapture %t288, i1 1, 2
  ret %ExpressionContinuationCapture %t289
merge31:
  br label %merge17
merge17:
  br label %loop.latch4
loop.latch4:
  %t290 = load double, double* %l5
  %t291 = load double, double* %l6
  %t292 = load i1, i1* %l7
  %t293 = load i8*, i8** %l4
  %t294 = load double, double* %l1
  %t295 = load double, double* %l2
  %t296 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t304 = load double, double* %l5
  %t305 = load double, double* %l6
  %t306 = load i1, i1* %l7
  %t307 = load i8*, i8** %l4
  %t308 = load double, double* %l1
  %t309 = load double, double* %l2
  %t310 = load double, double* %l3
  %t312 = load i1, i1* %l7
  br label %logical_or_entry_311

logical_or_entry_311:
  br i1 %t312, label %logical_or_merge_311, label %logical_or_right_311

logical_or_right_311:
  %t313 = load double, double* %l6
  %t314 = sitofp i64 0 to double
  %t315 = fcmp oeq double %t313, %t314
  br label %logical_or_right_end_311

logical_or_right_end_311:
  br label %logical_or_merge_311

logical_or_merge_311:
  %t316 = phi i1 [ true, %logical_or_entry_311 ], [ %t315, %logical_or_right_end_311 ]
  %t317 = xor i1 %t316, 1
  %t318 = load i8*, i8** %l0
  %t319 = load double, double* %l1
  %t320 = load double, double* %l2
  %t321 = load double, double* %l3
  %t322 = load i8*, i8** %l4
  %t323 = load double, double* %l5
  %t324 = load double, double* %l6
  %t325 = load i1, i1* %l7
  br i1 %t317, label %then32, label %merge33
then32:
  %t326 = load i8*, i8** %l0
  %t327 = insertvalue %ExpressionContinuationCapture undef, i8* %t326, 0
  %t328 = sitofp i64 0 to double
  %t329 = insertvalue %ExpressionContinuationCapture %t327, double %t328, 1
  %t330 = insertvalue %ExpressionContinuationCapture %t329, i1 0, 2
  ret %ExpressionContinuationCapture %t330
merge33:
  %t332 = load double, double* %l1
  %t333 = sitofp i64 0 to double
  %t334 = fcmp ole double %t332, %t333
  br label %logical_and_entry_331

logical_and_entry_331:
  br i1 %t334, label %logical_and_right_331, label %logical_and_merge_331

logical_and_right_331:
  %t336 = load double, double* %l2
  %t337 = sitofp i64 0 to double
  %t338 = fcmp ole double %t336, %t337
  br label %logical_and_entry_335

logical_and_entry_335:
  br i1 %t338, label %logical_and_right_335, label %logical_and_merge_335

logical_and_right_335:
  %t339 = load double, double* %l3
  %t340 = sitofp i64 0 to double
  %t341 = fcmp ole double %t339, %t340
  br label %logical_and_right_end_335

logical_and_right_end_335:
  br label %logical_and_merge_335

logical_and_merge_335:
  %t342 = phi i1 [ false, %logical_and_entry_335 ], [ %t341, %logical_and_right_end_335 ]
  br label %logical_and_right_end_331

logical_and_right_end_331:
  br label %logical_and_merge_331

logical_and_merge_331:
  %t343 = phi i1 [ false, %logical_and_entry_331 ], [ %t342, %logical_and_right_end_331 ]
  %t344 = load i8*, i8** %l0
  %t345 = load double, double* %l1
  %t346 = load double, double* %l2
  %t347 = load double, double* %l3
  %t348 = load i8*, i8** %l4
  %t349 = load double, double* %l5
  %t350 = load double, double* %l6
  %t351 = load i1, i1* %l7
  br i1 %t343, label %then34, label %merge35
then34:
  %t352 = load i8*, i8** %l4
  %t353 = call i8* @trim_text(i8* %t352)
  %t354 = call i8* @trim_trailing_delimiters(i8* %t353)
  store i8* %t354, i8** %l15
  %t355 = load i8*, i8** %l15
  %t356 = insertvalue %ExpressionContinuationCapture undef, i8* %t355, 0
  %t357 = load double, double* %l6
  %t358 = insertvalue %ExpressionContinuationCapture %t356, double %t357, 1
  %t359 = insertvalue %ExpressionContinuationCapture %t358, i1 1, 2
  ret %ExpressionContinuationCapture %t359
merge35:
  %t360 = load i8*, i8** %l0
  %t361 = insertvalue %ExpressionContinuationCapture undef, i8* %t360, 0
  %t362 = sitofp i64 0 to double
  %t363 = insertvalue %ExpressionContinuationCapture %t361, double %t362, 1
  %t364 = insertvalue %ExpressionContinuationCapture %t363, i1 0, 2
  ret %ExpressionContinuationCapture %t364
}

define i8* @continuation_segment_text(%NativeInstruction %instruction) {
block.entry:
  %t0 = extractvalue %NativeInstruction %instruction, 0
  %t1 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t2 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t3 = icmp eq i32 %t0, 0
  %t4 = select i1 %t3, i8* %t2, i8* %t1
  %t5 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t6 = icmp eq i32 %t0, 1
  %t7 = select i1 %t6, i8* %t5, i8* %t4
  %t8 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t9 = icmp eq i32 %t0, 2
  %t10 = select i1 %t9, i8* %t8, i8* %t7
  %t11 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t12 = icmp eq i32 %t0, 3
  %t13 = select i1 %t12, i8* %t11, i8* %t10
  %t14 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t15 = icmp eq i32 %t0, 4
  %t16 = select i1 %t15, i8* %t14, i8* %t13
  %t17 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t18 = icmp eq i32 %t0, 5
  %t19 = select i1 %t18, i8* %t17, i8* %t16
  %t20 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t21 = icmp eq i32 %t0, 6
  %t22 = select i1 %t21, i8* %t20, i8* %t19
  %t23 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t24 = icmp eq i32 %t0, 7
  %t25 = select i1 %t24, i8* %t23, i8* %t22
  %t26 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t27 = icmp eq i32 %t0, 8
  %t28 = select i1 %t27, i8* %t26, i8* %t25
  %t29 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t30 = icmp eq i32 %t0, 9
  %t31 = select i1 %t30, i8* %t29, i8* %t28
  %t32 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t33 = icmp eq i32 %t0, 10
  %t34 = select i1 %t33, i8* %t32, i8* %t31
  %t35 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t36 = icmp eq i32 %t0, 11
  %t37 = select i1 %t36, i8* %t35, i8* %t34
  %t38 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t39 = icmp eq i32 %t0, 12
  %t40 = select i1 %t39, i8* %t38, i8* %t37
  %t41 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t42 = icmp eq i32 %t0, 13
  %t43 = select i1 %t42, i8* %t41, i8* %t40
  %t44 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t45 = icmp eq i32 %t0, 14
  %t46 = select i1 %t45, i8* %t44, i8* %t43
  %t47 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t48 = icmp eq i32 %t0, 15
  %t49 = select i1 %t48, i8* %t47, i8* %t46
  %t50 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t51 = icmp eq i32 %t0, 16
  %t52 = select i1 %t51, i8* %t50, i8* %t49
  %s53 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h48777630, i32 0, i32 0
  %t54 = icmp eq i8* %t52, %s53
  br i1 %t54, label %then0, label %merge1
then0:
  %t55 = extractvalue %NativeInstruction %instruction, 0
  %t56 = alloca %NativeInstruction
  store %NativeInstruction %instruction, %NativeInstruction* %t56
  %t57 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t56, i32 0, i32 1
  %t58 = bitcast [8 x i8]* %t57 to i8*
  %t59 = bitcast i8* %t58 to i8**
  %t60 = load i8*, i8** %t59
  %t61 = icmp eq i32 %t55, 16
  %t62 = select i1 %t61, i8* %t60, i8* null
  ret i8* %t62
merge1:
  %t63 = extractvalue %NativeInstruction %instruction, 0
  %t64 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t65 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t66 = icmp eq i32 %t63, 0
  %t67 = select i1 %t66, i8* %t65, i8* %t64
  %t68 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t69 = icmp eq i32 %t63, 1
  %t70 = select i1 %t69, i8* %t68, i8* %t67
  %t71 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t72 = icmp eq i32 %t63, 2
  %t73 = select i1 %t72, i8* %t71, i8* %t70
  %t74 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t75 = icmp eq i32 %t63, 3
  %t76 = select i1 %t75, i8* %t74, i8* %t73
  %t77 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t78 = icmp eq i32 %t63, 4
  %t79 = select i1 %t78, i8* %t77, i8* %t76
  %t80 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t81 = icmp eq i32 %t63, 5
  %t82 = select i1 %t81, i8* %t80, i8* %t79
  %t83 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t84 = icmp eq i32 %t63, 6
  %t85 = select i1 %t84, i8* %t83, i8* %t82
  %t86 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t87 = icmp eq i32 %t63, 7
  %t88 = select i1 %t87, i8* %t86, i8* %t85
  %t89 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t90 = icmp eq i32 %t63, 8
  %t91 = select i1 %t90, i8* %t89, i8* %t88
  %t92 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t93 = icmp eq i32 %t63, 9
  %t94 = select i1 %t93, i8* %t92, i8* %t91
  %t95 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t96 = icmp eq i32 %t63, 10
  %t97 = select i1 %t96, i8* %t95, i8* %t94
  %t98 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t99 = icmp eq i32 %t63, 11
  %t100 = select i1 %t99, i8* %t98, i8* %t97
  %t101 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t102 = icmp eq i32 %t63, 12
  %t103 = select i1 %t102, i8* %t101, i8* %t100
  %t104 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t105 = icmp eq i32 %t63, 13
  %t106 = select i1 %t105, i8* %t104, i8* %t103
  %t107 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t108 = icmp eq i32 %t63, 14
  %t109 = select i1 %t108, i8* %t107, i8* %t106
  %t110 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t111 = icmp eq i32 %t63, 15
  %t112 = select i1 %t111, i8* %t110, i8* %t109
  %t113 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t114 = icmp eq i32 %t63, 16
  %t115 = select i1 %t114, i8* %t113, i8* %t112
  %s116 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h1629914700, i32 0, i32 0
  %t117 = icmp eq i8* %t115, %s116
  br i1 %t117, label %then2, label %merge3
then2:
  %t118 = extractvalue %NativeInstruction %instruction, 0
  %t119 = alloca %NativeInstruction
  store %NativeInstruction %instruction, %NativeInstruction* %t119
  %t120 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t119, i32 0, i32 1
  %t121 = bitcast [16 x i8]* %t120 to i8*
  %t122 = bitcast i8* %t121 to i8**
  %t123 = load i8*, i8** %t122
  %t124 = icmp eq i32 %t118, 0
  %t125 = select i1 %t124, i8* %t123, i8* null
  %t126 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t119, i32 0, i32 1
  %t127 = bitcast [16 x i8]* %t126 to i8*
  %t128 = bitcast i8* %t127 to i8**
  %t129 = load i8*, i8** %t128
  %t130 = icmp eq i32 %t118, 1
  %t131 = select i1 %t130, i8* %t129, i8* %t125
  %t132 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t119, i32 0, i32 1
  %t133 = bitcast [8 x i8]* %t132 to i8*
  %t134 = bitcast i8* %t133 to i8**
  %t135 = load i8*, i8** %t134
  %t136 = icmp eq i32 %t118, 12
  %t137 = select i1 %t136, i8* %t135, i8* %t131
  ret i8* %t137
merge3:
  ret i8* null
}

define i1 @segment_signals_expression_continuation(i8* %segment) {
block.entry:
  %l0 = alloca i8*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %segment)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  ret i1 0
merge1:
  %s2 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193419635, i32 0, i32 0
  %t3 = call i1 @starts_with(i8* %segment, i8* %s2)
  br i1 %t3, label %then2, label %merge3
then2:
  ret i1 1
merge3:
  %s4 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193516127, i32 0, i32 0
  %t5 = call i1 @starts_with(i8* %segment, i8* %s4)
  br i1 %t5, label %then4, label %merge5
then4:
  ret i1 1
merge5:
  %t6 = sitofp i64 0 to double
  %t7 = call i8* @char_at(i8* %segment, double %t6)
  store i8* %t7, i8** %l0
  %t9 = load i8*, i8** %l0
  %t10 = load i8, i8* %t9
  %t11 = icmp eq i8 %t10, 46
  br label %logical_or_entry_8

logical_or_entry_8:
  br i1 %t11, label %logical_or_merge_8, label %logical_or_right_8

logical_or_right_8:
  %t13 = load i8*, i8** %l0
  %t14 = load i8, i8* %t13
  %t15 = icmp eq i8 %t14, 41
  br label %logical_or_entry_12

logical_or_entry_12:
  br i1 %t15, label %logical_or_merge_12, label %logical_or_right_12

logical_or_right_12:
  %t17 = load i8*, i8** %l0
  %t18 = load i8, i8* %t17
  %t19 = icmp eq i8 %t18, 93
  br label %logical_or_entry_16

logical_or_entry_16:
  br i1 %t19, label %logical_or_merge_16, label %logical_or_right_16

logical_or_right_16:
  %t20 = load i8*, i8** %l0
  %t21 = load i8, i8* %t20
  %t22 = icmp eq i8 %t21, 125
  br label %logical_or_right_end_16

logical_or_right_end_16:
  br label %logical_or_merge_16

logical_or_merge_16:
  %t23 = phi i1 [ true, %logical_or_entry_16 ], [ %t22, %logical_or_right_end_16 ]
  br label %logical_or_right_end_12

logical_or_right_end_12:
  br label %logical_or_merge_12

logical_or_merge_12:
  %t24 = phi i1 [ true, %logical_or_entry_12 ], [ %t23, %logical_or_right_end_12 ]
  br label %logical_or_right_end_8

logical_or_right_end_8:
  br label %logical_or_merge_8

logical_or_merge_8:
  %t25 = phi i1 [ true, %logical_or_entry_8 ], [ %t24, %logical_or_right_end_8 ]
  %t26 = load i8*, i8** %l0
  br i1 %t25, label %then6, label %merge7
then6:
  ret i1 1
merge7:
  ret i1 0
}

define double @compute_brace_balance(i8* %text) {
block.entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i8*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = sitofp i64 0 to double
  ret double %t2
merge1:
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l0
  %t4 = sitofp i64 0 to double
  store double %t4, double* %l1
  %t5 = load double, double* %l0
  %t6 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t43 = phi double [ %t5, %merge1 ], [ %t41, %loop.latch4 ]
  %t44 = phi double [ %t6, %merge1 ], [ %t42, %loop.latch4 ]
  store double %t43, double* %l0
  store double %t44, double* %l1
  br label %loop.body3
loop.body3:
  %t7 = load double, double* %l1
  %t8 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t9 = sitofp i64 %t8 to double
  %t10 = fcmp oge double %t7, %t9
  %t11 = load double, double* %l0
  %t12 = load double, double* %l1
  br i1 %t10, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t13 = load double, double* %l1
  %t14 = call i8* @char_at(i8* %text, double %t13)
  store i8* %t14, i8** %l2
  %t15 = load i8*, i8** %l2
  %t16 = load i8, i8* %t15
  %t17 = icmp eq i8 %t16, 123
  %t18 = load double, double* %l0
  %t19 = load double, double* %l1
  %t20 = load i8*, i8** %l2
  br i1 %t17, label %then8, label %else9
then8:
  %t21 = load double, double* %l0
  %t22 = sitofp i64 1 to double
  %t23 = fadd double %t21, %t22
  store double %t23, double* %l0
  %t24 = load double, double* %l0
  br label %merge10
else9:
  %t25 = load i8*, i8** %l2
  %t26 = load i8, i8* %t25
  %t27 = icmp eq i8 %t26, 125
  %t28 = load double, double* %l0
  %t29 = load double, double* %l1
  %t30 = load i8*, i8** %l2
  br i1 %t27, label %then11, label %merge12
then11:
  %t31 = load double, double* %l0
  %t32 = sitofp i64 1 to double
  %t33 = fsub double %t31, %t32
  store double %t33, double* %l0
  %t34 = load double, double* %l0
  br label %merge12
merge12:
  %t35 = phi double [ %t34, %then11 ], [ %t28, %else9 ]
  store double %t35, double* %l0
  %t36 = load double, double* %l0
  br label %merge10
merge10:
  %t37 = phi double [ %t24, %then8 ], [ %t36, %merge12 ]
  store double %t37, double* %l0
  %t38 = load double, double* %l1
  %t39 = sitofp i64 1 to double
  %t40 = fadd double %t38, %t39
  store double %t40, double* %l1
  br label %loop.latch4
loop.latch4:
  %t41 = load double, double* %l0
  %t42 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t45 = load double, double* %l0
  %t46 = load double, double* %l1
  %t47 = load double, double* %l0
  ret double %t47
}

define double @compute_parenthesis_balance(i8* %text) {
block.entry:
  %t0 = alloca [2 x i8], align 1
  %t1 = getelementptr [2 x i8], [2 x i8]* %t0, i32 0, i32 0
  store i8 40, i8* %t1
  %t2 = getelementptr [2 x i8], [2 x i8]* %t0, i32 0, i32 1
  store i8 0, i8* %t2
  %t3 = getelementptr [2 x i8], [2 x i8]* %t0, i32 0, i32 0
  %t4 = alloca [2 x i8], align 1
  %t5 = getelementptr [2 x i8], [2 x i8]* %t4, i32 0, i32 0
  store i8 41, i8* %t5
  %t6 = getelementptr [2 x i8], [2 x i8]* %t4, i32 0, i32 1
  store i8 0, i8* %t6
  %t7 = getelementptr [2 x i8], [2 x i8]* %t4, i32 0, i32 0
  %t8 = call double @compute_symbol_balance(i8* %text, i8* %t3, i8* %t7)
  ret double %t8
}

define double @compute_bracket_balance(i8* %text) {
block.entry:
  %t0 = alloca [2 x i8], align 1
  %t1 = getelementptr [2 x i8], [2 x i8]* %t0, i32 0, i32 0
  store i8 91, i8* %t1
  %t2 = getelementptr [2 x i8], [2 x i8]* %t0, i32 0, i32 1
  store i8 0, i8* %t2
  %t3 = getelementptr [2 x i8], [2 x i8]* %t0, i32 0, i32 0
  %t4 = alloca [2 x i8], align 1
  %t5 = getelementptr [2 x i8], [2 x i8]* %t4, i32 0, i32 0
  store i8 93, i8* %t5
  %t6 = getelementptr [2 x i8], [2 x i8]* %t4, i32 0, i32 1
  store i8 0, i8* %t6
  %t7 = getelementptr [2 x i8], [2 x i8]* %t4, i32 0, i32 0
  %t8 = call double @compute_symbol_balance(i8* %text, i8* %t3, i8* %t7)
  ret double %t8
}

define double @compute_symbol_balance(i8* %text, i8* %open, i8* %close) {
block.entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i8*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = sitofp i64 0 to double
  ret double %t2
merge1:
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l0
  %t4 = sitofp i64 0 to double
  store double %t4, double* %l1
  %t5 = load double, double* %l0
  %t6 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t41 = phi double [ %t5, %merge1 ], [ %t39, %loop.latch4 ]
  %t42 = phi double [ %t6, %merge1 ], [ %t40, %loop.latch4 ]
  store double %t41, double* %l0
  store double %t42, double* %l1
  br label %loop.body3
loop.body3:
  %t7 = load double, double* %l1
  %t8 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t9 = sitofp i64 %t8 to double
  %t10 = fcmp oge double %t7, %t9
  %t11 = load double, double* %l0
  %t12 = load double, double* %l1
  br i1 %t10, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t13 = load double, double* %l1
  %t14 = call i8* @char_at(i8* %text, double %t13)
  store i8* %t14, i8** %l2
  %t15 = load i8*, i8** %l2
  %t16 = icmp eq i8* %t15, %open
  %t17 = load double, double* %l0
  %t18 = load double, double* %l1
  %t19 = load i8*, i8** %l2
  br i1 %t16, label %then8, label %else9
then8:
  %t20 = load double, double* %l0
  %t21 = sitofp i64 1 to double
  %t22 = fadd double %t20, %t21
  store double %t22, double* %l0
  %t23 = load double, double* %l0
  br label %merge10
else9:
  %t24 = load i8*, i8** %l2
  %t25 = icmp eq i8* %t24, %close
  %t26 = load double, double* %l0
  %t27 = load double, double* %l1
  %t28 = load i8*, i8** %l2
  br i1 %t25, label %then11, label %merge12
then11:
  %t29 = load double, double* %l0
  %t30 = sitofp i64 1 to double
  %t31 = fsub double %t29, %t30
  store double %t31, double* %l0
  %t32 = load double, double* %l0
  br label %merge12
merge12:
  %t33 = phi double [ %t32, %then11 ], [ %t26, %else9 ]
  store double %t33, double* %l0
  %t34 = load double, double* %l0
  br label %merge10
merge10:
  %t35 = phi double [ %t23, %then8 ], [ %t34, %merge12 ]
  store double %t35, double* %l0
  %t36 = load double, double* %l1
  %t37 = sitofp i64 1 to double
  %t38 = fadd double %t36, %t37
  store double %t38, double* %l1
  br label %loop.latch4
loop.latch4:
  %t39 = load double, double* %l0
  %t40 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t43 = load double, double* %l0
  %t44 = load double, double* %l1
  %t45 = load double, double* %l0
  ret double %t45
}

define { i8**, i64 }* @split_struct_field_entries(i8* %text) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i1
  %l5 = alloca i8*
  %l6 = alloca i8*
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
  store i1 0, i1* %l4
  %s15 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s15, i8** %l5
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t17 = load i8*, i8** %l1
  %t18 = load double, double* %l2
  %t19 = load double, double* %l3
  %t20 = load i1, i1* %l4
  %t21 = load i8*, i8** %l5
  br label %loop.header0
loop.header0:
  %t217 = phi i8* [ %t17, %block.entry ], [ %t211, %loop.latch2 ]
  %t218 = phi double [ %t19, %block.entry ], [ %t212, %loop.latch2 ]
  %t219 = phi i1 [ %t20, %block.entry ], [ %t213, %loop.latch2 ]
  %t220 = phi i8* [ %t21, %block.entry ], [ %t214, %loop.latch2 ]
  %t221 = phi double [ %t18, %block.entry ], [ %t215, %loop.latch2 ]
  %t222 = phi { i8**, i64 }* [ %t16, %block.entry ], [ %t216, %loop.latch2 ]
  store i8* %t217, i8** %l1
  store double %t218, double* %l3
  store i1 %t219, i1* %l4
  store i8* %t220, i8** %l5
  store double %t221, double* %l2
  store { i8**, i64 }* %t222, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t22 = load double, double* %l3
  %t23 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t24 = sitofp i64 %t23 to double
  %t25 = fcmp oge double %t22, %t24
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t27 = load i8*, i8** %l1
  %t28 = load double, double* %l2
  %t29 = load double, double* %l3
  %t30 = load i1, i1* %l4
  %t31 = load i8*, i8** %l5
  br i1 %t25, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t32 = load double, double* %l3
  %t33 = call i8* @char_at(i8* %text, double %t32)
  store i8* %t33, i8** %l6
  %t34 = load i1, i1* %l4
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t36 = load i8*, i8** %l1
  %t37 = load double, double* %l2
  %t38 = load double, double* %l3
  %t39 = load i1, i1* %l4
  %t40 = load i8*, i8** %l5
  %t41 = load i8*, i8** %l6
  br i1 %t34, label %then6, label %merge7
then6:
  %t42 = load i8*, i8** %l1
  %t43 = load i8*, i8** %l6
  %t44 = call i8* @sailfin_runtime_string_concat(i8* %t42, i8* %t43)
  store i8* %t44, i8** %l1
  %t45 = load i8*, i8** %l6
  %t46 = load i8, i8* %t45
  %t47 = icmp eq i8 %t46, 92
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t49 = load i8*, i8** %l1
  %t50 = load double, double* %l2
  %t51 = load double, double* %l3
  %t52 = load i1, i1* %l4
  %t53 = load i8*, i8** %l5
  %t54 = load i8*, i8** %l6
  br i1 %t47, label %then8, label %else9
then8:
  %t55 = load double, double* %l3
  %t56 = sitofp i64 1 to double
  %t57 = fadd double %t55, %t56
  store double %t57, double* %l3
  %t58 = load double, double* %l3
  %t59 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t60 = sitofp i64 %t59 to double
  %t61 = fcmp olt double %t58, %t60
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t63 = load i8*, i8** %l1
  %t64 = load double, double* %l2
  %t65 = load double, double* %l3
  %t66 = load i1, i1* %l4
  %t67 = load i8*, i8** %l5
  %t68 = load i8*, i8** %l6
  br i1 %t61, label %then11, label %merge12
then11:
  %t69 = load i8*, i8** %l1
  %t70 = load double, double* %l3
  %t71 = call i8* @char_at(i8* %text, double %t70)
  %t72 = call i8* @sailfin_runtime_string_concat(i8* %t69, i8* %t71)
  store i8* %t72, i8** %l1
  %t73 = load i8*, i8** %l1
  br label %merge12
merge12:
  %t74 = phi i8* [ %t73, %then11 ], [ %t63, %then8 ]
  store i8* %t74, i8** %l1
  %t75 = load double, double* %l3
  %t76 = load i8*, i8** %l1
  br label %merge10
else9:
  %t77 = load i8*, i8** %l6
  %t78 = load i8*, i8** %l5
  %t79 = icmp eq i8* %t77, %t78
  %t80 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t81 = load i8*, i8** %l1
  %t82 = load double, double* %l2
  %t83 = load double, double* %l3
  %t84 = load i1, i1* %l4
  %t85 = load i8*, i8** %l5
  %t86 = load i8*, i8** %l6
  br i1 %t79, label %then13, label %merge14
then13:
  store i1 0, i1* %l4
  %t87 = load i1, i1* %l4
  br label %merge14
merge14:
  %t88 = phi i1 [ %t87, %then13 ], [ %t84, %else9 ]
  store i1 %t88, i1* %l4
  %t89 = load i1, i1* %l4
  br label %merge10
merge10:
  %t90 = phi double [ %t75, %merge12 ], [ %t51, %merge14 ]
  %t91 = phi i8* [ %t76, %merge12 ], [ %t49, %merge14 ]
  %t92 = phi i1 [ %t52, %merge12 ], [ %t89, %merge14 ]
  store double %t90, double* %l3
  store i8* %t91, i8** %l1
  store i1 %t92, i1* %l4
  %t93 = load double, double* %l3
  %t94 = sitofp i64 1 to double
  %t95 = fadd double %t93, %t94
  store double %t95, double* %l3
  br label %loop.latch2
merge7:
  %t97 = load i8*, i8** %l6
  %t98 = load i8, i8* %t97
  %t99 = icmp eq i8 %t98, 34
  br label %logical_or_entry_96

logical_or_entry_96:
  br i1 %t99, label %logical_or_merge_96, label %logical_or_right_96

logical_or_right_96:
  %t100 = load i8*, i8** %l6
  %t101 = load i8, i8* %t100
  %t102 = icmp eq i8 %t101, 39
  br label %logical_or_right_end_96

logical_or_right_end_96:
  br label %logical_or_merge_96

logical_or_merge_96:
  %t103 = phi i1 [ true, %logical_or_entry_96 ], [ %t102, %logical_or_right_end_96 ]
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t105 = load i8*, i8** %l1
  %t106 = load double, double* %l2
  %t107 = load double, double* %l3
  %t108 = load i1, i1* %l4
  %t109 = load i8*, i8** %l5
  %t110 = load i8*, i8** %l6
  br i1 %t103, label %then15, label %merge16
then15:
  store i1 1, i1* %l4
  %t111 = load i8*, i8** %l6
  store i8* %t111, i8** %l5
  %t112 = load i8*, i8** %l1
  %t113 = load i8*, i8** %l6
  %t114 = call i8* @sailfin_runtime_string_concat(i8* %t112, i8* %t113)
  store i8* %t114, i8** %l1
  %t115 = load double, double* %l3
  %t116 = sitofp i64 1 to double
  %t117 = fadd double %t115, %t116
  store double %t117, double* %l3
  br label %loop.latch2
merge16:
  %t119 = load i8*, i8** %l6
  %t120 = load i8, i8* %t119
  %t121 = icmp eq i8 %t120, 123
  br label %logical_or_entry_118

logical_or_entry_118:
  br i1 %t121, label %logical_or_merge_118, label %logical_or_right_118

logical_or_right_118:
  %t123 = load i8*, i8** %l6
  %t124 = load i8, i8* %t123
  %t125 = icmp eq i8 %t124, 91
  br label %logical_or_entry_122

logical_or_entry_122:
  br i1 %t125, label %logical_or_merge_122, label %logical_or_right_122

logical_or_right_122:
  %t126 = load i8*, i8** %l6
  %t127 = load i8, i8* %t126
  %t128 = icmp eq i8 %t127, 40
  br label %logical_or_right_end_122

logical_or_right_end_122:
  br label %logical_or_merge_122

logical_or_merge_122:
  %t129 = phi i1 [ true, %logical_or_entry_122 ], [ %t128, %logical_or_right_end_122 ]
  br label %logical_or_right_end_118

logical_or_right_end_118:
  br label %logical_or_merge_118

logical_or_merge_118:
  %t130 = phi i1 [ true, %logical_or_entry_118 ], [ %t129, %logical_or_right_end_118 ]
  %t131 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t132 = load i8*, i8** %l1
  %t133 = load double, double* %l2
  %t134 = load double, double* %l3
  %t135 = load i1, i1* %l4
  %t136 = load i8*, i8** %l5
  %t137 = load i8*, i8** %l6
  br i1 %t130, label %then17, label %else18
then17:
  %t138 = load double, double* %l2
  %t139 = sitofp i64 1 to double
  %t140 = fadd double %t138, %t139
  store double %t140, double* %l2
  %t141 = load double, double* %l2
  br label %merge19
else18:
  %t143 = load i8*, i8** %l6
  %t144 = load i8, i8* %t143
  %t145 = icmp eq i8 %t144, 125
  br label %logical_or_entry_142

logical_or_entry_142:
  br i1 %t145, label %logical_or_merge_142, label %logical_or_right_142

logical_or_right_142:
  %t147 = load i8*, i8** %l6
  %t148 = load i8, i8* %t147
  %t149 = icmp eq i8 %t148, 93
  br label %logical_or_entry_146

logical_or_entry_146:
  br i1 %t149, label %logical_or_merge_146, label %logical_or_right_146

logical_or_right_146:
  %t150 = load i8*, i8** %l6
  %t151 = load i8, i8* %t150
  %t152 = icmp eq i8 %t151, 41
  br label %logical_or_right_end_146

logical_or_right_end_146:
  br label %logical_or_merge_146

logical_or_merge_146:
  %t153 = phi i1 [ true, %logical_or_entry_146 ], [ %t152, %logical_or_right_end_146 ]
  br label %logical_or_right_end_142

logical_or_right_end_142:
  br label %logical_or_merge_142

logical_or_merge_142:
  %t154 = phi i1 [ true, %logical_or_entry_142 ], [ %t153, %logical_or_right_end_142 ]
  %t155 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t156 = load i8*, i8** %l1
  %t157 = load double, double* %l2
  %t158 = load double, double* %l3
  %t159 = load i1, i1* %l4
  %t160 = load i8*, i8** %l5
  %t161 = load i8*, i8** %l6
  br i1 %t154, label %then20, label %merge21
then20:
  %t162 = load double, double* %l2
  %t163 = sitofp i64 0 to double
  %t164 = fcmp ogt double %t162, %t163
  %t165 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t166 = load i8*, i8** %l1
  %t167 = load double, double* %l2
  %t168 = load double, double* %l3
  %t169 = load i1, i1* %l4
  %t170 = load i8*, i8** %l5
  %t171 = load i8*, i8** %l6
  br i1 %t164, label %then22, label %merge23
then22:
  %t172 = load double, double* %l2
  %t173 = sitofp i64 1 to double
  %t174 = fsub double %t172, %t173
  store double %t174, double* %l2
  %t175 = load double, double* %l2
  br label %merge23
merge23:
  %t176 = phi double [ %t175, %then22 ], [ %t167, %then20 ]
  store double %t176, double* %l2
  %t177 = load double, double* %l2
  br label %merge21
merge21:
  %t178 = phi double [ %t177, %merge23 ], [ %t157, %logical_or_merge_142 ]
  store double %t178, double* %l2
  %t179 = load double, double* %l2
  br label %merge19
merge19:
  %t180 = phi double [ %t141, %then17 ], [ %t179, %merge21 ]
  store double %t180, double* %l2
  %t182 = load i8*, i8** %l6
  %t183 = load i8, i8* %t182
  %t184 = icmp eq i8 %t183, 44
  br label %logical_and_entry_181

logical_and_entry_181:
  br i1 %t184, label %logical_and_right_181, label %logical_and_merge_181

logical_and_right_181:
  %t185 = load double, double* %l2
  %t186 = sitofp i64 0 to double
  %t187 = fcmp oeq double %t185, %t186
  br label %logical_and_right_end_181

logical_and_right_end_181:
  br label %logical_and_merge_181

logical_and_merge_181:
  %t188 = phi i1 [ false, %logical_and_entry_181 ], [ %t187, %logical_and_right_end_181 ]
  %t189 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t190 = load i8*, i8** %l1
  %t191 = load double, double* %l2
  %t192 = load double, double* %l3
  %t193 = load i1, i1* %l4
  %t194 = load i8*, i8** %l5
  %t195 = load i8*, i8** %l6
  br i1 %t188, label %then24, label %else25
then24:
  %t196 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t197 = load i8*, i8** %l1
  %t198 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t196, i8* %t197)
  store { i8**, i64 }* %t198, { i8**, i64 }** %l0
  %s199 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s199, i8** %l1
  %t200 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t201 = load i8*, i8** %l1
  br label %merge26
else25:
  %t202 = load i8*, i8** %l1
  %t203 = load i8*, i8** %l6
  %t204 = call i8* @sailfin_runtime_string_concat(i8* %t202, i8* %t203)
  store i8* %t204, i8** %l1
  %t205 = load i8*, i8** %l1
  br label %merge26
merge26:
  %t206 = phi { i8**, i64 }* [ %t200, %then24 ], [ %t189, %else25 ]
  %t207 = phi i8* [ %t201, %then24 ], [ %t205, %else25 ]
  store { i8**, i64 }* %t206, { i8**, i64 }** %l0
  store i8* %t207, i8** %l1
  %t208 = load double, double* %l3
  %t209 = sitofp i64 1 to double
  %t210 = fadd double %t208, %t209
  store double %t210, double* %l3
  br label %loop.latch2
loop.latch2:
  %t211 = load i8*, i8** %l1
  %t212 = load double, double* %l3
  %t213 = load i1, i1* %l4
  %t214 = load i8*, i8** %l5
  %t215 = load double, double* %l2
  %t216 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t223 = load i8*, i8** %l1
  %t224 = load double, double* %l3
  %t225 = load i1, i1* %l4
  %t226 = load i8*, i8** %l5
  %t227 = load double, double* %l2
  %t228 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t229 = load i8*, i8** %l1
  %t230 = call i64 @sailfin_runtime_string_length(i8* %t229)
  %t231 = icmp sgt i64 %t230, 0
  %t232 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t233 = load i8*, i8** %l1
  %t234 = load double, double* %l2
  %t235 = load double, double* %l3
  %t236 = load i1, i1* %l4
  %t237 = load i8*, i8** %l5
  br i1 %t231, label %then27, label %merge28
then27:
  %t238 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t239 = load i8*, i8** %l1
  %t240 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t238, i8* %t239)
  store { i8**, i64 }* %t240, { i8**, i64 }** %l0
  %t241 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge28
merge28:
  %t242 = phi { i8**, i64 }* [ %t241, %then27 ], [ %t232, %afterloop3 ]
  store { i8**, i64 }* %t242, { i8**, i64 }** %l0
  %t243 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t243
}

define { i8**, i64 }* @split_array_entries(i8* %text) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i1
  %l5 = alloca i8*
  %l6 = alloca i8*
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
  store i1 0, i1* %l4
  %s15 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s15, i8** %l5
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t17 = load i8*, i8** %l1
  %t18 = load double, double* %l2
  %t19 = load double, double* %l3
  %t20 = load i1, i1* %l4
  %t21 = load i8*, i8** %l5
  br label %loop.header0
loop.header0:
  %t217 = phi i8* [ %t17, %block.entry ], [ %t211, %loop.latch2 ]
  %t218 = phi double [ %t19, %block.entry ], [ %t212, %loop.latch2 ]
  %t219 = phi i1 [ %t20, %block.entry ], [ %t213, %loop.latch2 ]
  %t220 = phi i8* [ %t21, %block.entry ], [ %t214, %loop.latch2 ]
  %t221 = phi double [ %t18, %block.entry ], [ %t215, %loop.latch2 ]
  %t222 = phi { i8**, i64 }* [ %t16, %block.entry ], [ %t216, %loop.latch2 ]
  store i8* %t217, i8** %l1
  store double %t218, double* %l3
  store i1 %t219, i1* %l4
  store i8* %t220, i8** %l5
  store double %t221, double* %l2
  store { i8**, i64 }* %t222, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t22 = load double, double* %l3
  %t23 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t24 = sitofp i64 %t23 to double
  %t25 = fcmp oge double %t22, %t24
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t27 = load i8*, i8** %l1
  %t28 = load double, double* %l2
  %t29 = load double, double* %l3
  %t30 = load i1, i1* %l4
  %t31 = load i8*, i8** %l5
  br i1 %t25, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t32 = load double, double* %l3
  %t33 = call i8* @char_at(i8* %text, double %t32)
  store i8* %t33, i8** %l6
  %t34 = load i1, i1* %l4
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t36 = load i8*, i8** %l1
  %t37 = load double, double* %l2
  %t38 = load double, double* %l3
  %t39 = load i1, i1* %l4
  %t40 = load i8*, i8** %l5
  %t41 = load i8*, i8** %l6
  br i1 %t34, label %then6, label %merge7
then6:
  %t42 = load i8*, i8** %l1
  %t43 = load i8*, i8** %l6
  %t44 = call i8* @sailfin_runtime_string_concat(i8* %t42, i8* %t43)
  store i8* %t44, i8** %l1
  %t45 = load i8*, i8** %l6
  %t46 = load i8, i8* %t45
  %t47 = icmp eq i8 %t46, 92
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t49 = load i8*, i8** %l1
  %t50 = load double, double* %l2
  %t51 = load double, double* %l3
  %t52 = load i1, i1* %l4
  %t53 = load i8*, i8** %l5
  %t54 = load i8*, i8** %l6
  br i1 %t47, label %then8, label %else9
then8:
  %t55 = load double, double* %l3
  %t56 = sitofp i64 1 to double
  %t57 = fadd double %t55, %t56
  store double %t57, double* %l3
  %t58 = load double, double* %l3
  %t59 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t60 = sitofp i64 %t59 to double
  %t61 = fcmp olt double %t58, %t60
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t63 = load i8*, i8** %l1
  %t64 = load double, double* %l2
  %t65 = load double, double* %l3
  %t66 = load i1, i1* %l4
  %t67 = load i8*, i8** %l5
  %t68 = load i8*, i8** %l6
  br i1 %t61, label %then11, label %merge12
then11:
  %t69 = load i8*, i8** %l1
  %t70 = load double, double* %l3
  %t71 = call i8* @char_at(i8* %text, double %t70)
  %t72 = call i8* @sailfin_runtime_string_concat(i8* %t69, i8* %t71)
  store i8* %t72, i8** %l1
  %t73 = load i8*, i8** %l1
  br label %merge12
merge12:
  %t74 = phi i8* [ %t73, %then11 ], [ %t63, %then8 ]
  store i8* %t74, i8** %l1
  %t75 = load double, double* %l3
  %t76 = load i8*, i8** %l1
  br label %merge10
else9:
  %t77 = load i8*, i8** %l6
  %t78 = load i8*, i8** %l5
  %t79 = icmp eq i8* %t77, %t78
  %t80 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t81 = load i8*, i8** %l1
  %t82 = load double, double* %l2
  %t83 = load double, double* %l3
  %t84 = load i1, i1* %l4
  %t85 = load i8*, i8** %l5
  %t86 = load i8*, i8** %l6
  br i1 %t79, label %then13, label %merge14
then13:
  store i1 0, i1* %l4
  %t87 = load i1, i1* %l4
  br label %merge14
merge14:
  %t88 = phi i1 [ %t87, %then13 ], [ %t84, %else9 ]
  store i1 %t88, i1* %l4
  %t89 = load i1, i1* %l4
  br label %merge10
merge10:
  %t90 = phi double [ %t75, %merge12 ], [ %t51, %merge14 ]
  %t91 = phi i8* [ %t76, %merge12 ], [ %t49, %merge14 ]
  %t92 = phi i1 [ %t52, %merge12 ], [ %t89, %merge14 ]
  store double %t90, double* %l3
  store i8* %t91, i8** %l1
  store i1 %t92, i1* %l4
  %t93 = load double, double* %l3
  %t94 = sitofp i64 1 to double
  %t95 = fadd double %t93, %t94
  store double %t95, double* %l3
  br label %loop.latch2
merge7:
  %t97 = load i8*, i8** %l6
  %t98 = load i8, i8* %t97
  %t99 = icmp eq i8 %t98, 34
  br label %logical_or_entry_96

logical_or_entry_96:
  br i1 %t99, label %logical_or_merge_96, label %logical_or_right_96

logical_or_right_96:
  %t100 = load i8*, i8** %l6
  %t101 = load i8, i8* %t100
  %t102 = icmp eq i8 %t101, 39
  br label %logical_or_right_end_96

logical_or_right_end_96:
  br label %logical_or_merge_96

logical_or_merge_96:
  %t103 = phi i1 [ true, %logical_or_entry_96 ], [ %t102, %logical_or_right_end_96 ]
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t105 = load i8*, i8** %l1
  %t106 = load double, double* %l2
  %t107 = load double, double* %l3
  %t108 = load i1, i1* %l4
  %t109 = load i8*, i8** %l5
  %t110 = load i8*, i8** %l6
  br i1 %t103, label %then15, label %merge16
then15:
  store i1 1, i1* %l4
  %t111 = load i8*, i8** %l6
  store i8* %t111, i8** %l5
  %t112 = load i8*, i8** %l1
  %t113 = load i8*, i8** %l6
  %t114 = call i8* @sailfin_runtime_string_concat(i8* %t112, i8* %t113)
  store i8* %t114, i8** %l1
  %t115 = load double, double* %l3
  %t116 = sitofp i64 1 to double
  %t117 = fadd double %t115, %t116
  store double %t117, double* %l3
  br label %loop.latch2
merge16:
  %t119 = load i8*, i8** %l6
  %t120 = load i8, i8* %t119
  %t121 = icmp eq i8 %t120, 123
  br label %logical_or_entry_118

logical_or_entry_118:
  br i1 %t121, label %logical_or_merge_118, label %logical_or_right_118

logical_or_right_118:
  %t123 = load i8*, i8** %l6
  %t124 = load i8, i8* %t123
  %t125 = icmp eq i8 %t124, 91
  br label %logical_or_entry_122

logical_or_entry_122:
  br i1 %t125, label %logical_or_merge_122, label %logical_or_right_122

logical_or_right_122:
  %t126 = load i8*, i8** %l6
  %t127 = load i8, i8* %t126
  %t128 = icmp eq i8 %t127, 40
  br label %logical_or_right_end_122

logical_or_right_end_122:
  br label %logical_or_merge_122

logical_or_merge_122:
  %t129 = phi i1 [ true, %logical_or_entry_122 ], [ %t128, %logical_or_right_end_122 ]
  br label %logical_or_right_end_118

logical_or_right_end_118:
  br label %logical_or_merge_118

logical_or_merge_118:
  %t130 = phi i1 [ true, %logical_or_entry_118 ], [ %t129, %logical_or_right_end_118 ]
  %t131 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t132 = load i8*, i8** %l1
  %t133 = load double, double* %l2
  %t134 = load double, double* %l3
  %t135 = load i1, i1* %l4
  %t136 = load i8*, i8** %l5
  %t137 = load i8*, i8** %l6
  br i1 %t130, label %then17, label %else18
then17:
  %t138 = load double, double* %l2
  %t139 = sitofp i64 1 to double
  %t140 = fadd double %t138, %t139
  store double %t140, double* %l2
  %t141 = load double, double* %l2
  br label %merge19
else18:
  %t143 = load i8*, i8** %l6
  %t144 = load i8, i8* %t143
  %t145 = icmp eq i8 %t144, 125
  br label %logical_or_entry_142

logical_or_entry_142:
  br i1 %t145, label %logical_or_merge_142, label %logical_or_right_142

logical_or_right_142:
  %t147 = load i8*, i8** %l6
  %t148 = load i8, i8* %t147
  %t149 = icmp eq i8 %t148, 93
  br label %logical_or_entry_146

logical_or_entry_146:
  br i1 %t149, label %logical_or_merge_146, label %logical_or_right_146

logical_or_right_146:
  %t150 = load i8*, i8** %l6
  %t151 = load i8, i8* %t150
  %t152 = icmp eq i8 %t151, 41
  br label %logical_or_right_end_146

logical_or_right_end_146:
  br label %logical_or_merge_146

logical_or_merge_146:
  %t153 = phi i1 [ true, %logical_or_entry_146 ], [ %t152, %logical_or_right_end_146 ]
  br label %logical_or_right_end_142

logical_or_right_end_142:
  br label %logical_or_merge_142

logical_or_merge_142:
  %t154 = phi i1 [ true, %logical_or_entry_142 ], [ %t153, %logical_or_right_end_142 ]
  %t155 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t156 = load i8*, i8** %l1
  %t157 = load double, double* %l2
  %t158 = load double, double* %l3
  %t159 = load i1, i1* %l4
  %t160 = load i8*, i8** %l5
  %t161 = load i8*, i8** %l6
  br i1 %t154, label %then20, label %merge21
then20:
  %t162 = load double, double* %l2
  %t163 = sitofp i64 0 to double
  %t164 = fcmp ogt double %t162, %t163
  %t165 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t166 = load i8*, i8** %l1
  %t167 = load double, double* %l2
  %t168 = load double, double* %l3
  %t169 = load i1, i1* %l4
  %t170 = load i8*, i8** %l5
  %t171 = load i8*, i8** %l6
  br i1 %t164, label %then22, label %merge23
then22:
  %t172 = load double, double* %l2
  %t173 = sitofp i64 1 to double
  %t174 = fsub double %t172, %t173
  store double %t174, double* %l2
  %t175 = load double, double* %l2
  br label %merge23
merge23:
  %t176 = phi double [ %t175, %then22 ], [ %t167, %then20 ]
  store double %t176, double* %l2
  %t177 = load double, double* %l2
  br label %merge21
merge21:
  %t178 = phi double [ %t177, %merge23 ], [ %t157, %logical_or_merge_142 ]
  store double %t178, double* %l2
  %t179 = load double, double* %l2
  br label %merge19
merge19:
  %t180 = phi double [ %t141, %then17 ], [ %t179, %merge21 ]
  store double %t180, double* %l2
  %t182 = load i8*, i8** %l6
  %t183 = load i8, i8* %t182
  %t184 = icmp eq i8 %t183, 44
  br label %logical_and_entry_181

logical_and_entry_181:
  br i1 %t184, label %logical_and_right_181, label %logical_and_merge_181

logical_and_right_181:
  %t185 = load double, double* %l2
  %t186 = sitofp i64 0 to double
  %t187 = fcmp oeq double %t185, %t186
  br label %logical_and_right_end_181

logical_and_right_end_181:
  br label %logical_and_merge_181

logical_and_merge_181:
  %t188 = phi i1 [ false, %logical_and_entry_181 ], [ %t187, %logical_and_right_end_181 ]
  %t189 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t190 = load i8*, i8** %l1
  %t191 = load double, double* %l2
  %t192 = load double, double* %l3
  %t193 = load i1, i1* %l4
  %t194 = load i8*, i8** %l5
  %t195 = load i8*, i8** %l6
  br i1 %t188, label %then24, label %else25
then24:
  %t196 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t197 = load i8*, i8** %l1
  %t198 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t196, i8* %t197)
  store { i8**, i64 }* %t198, { i8**, i64 }** %l0
  %s199 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s199, i8** %l1
  %t200 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t201 = load i8*, i8** %l1
  br label %merge26
else25:
  %t202 = load i8*, i8** %l1
  %t203 = load i8*, i8** %l6
  %t204 = call i8* @sailfin_runtime_string_concat(i8* %t202, i8* %t203)
  store i8* %t204, i8** %l1
  %t205 = load i8*, i8** %l1
  br label %merge26
merge26:
  %t206 = phi { i8**, i64 }* [ %t200, %then24 ], [ %t189, %else25 ]
  %t207 = phi i8* [ %t201, %then24 ], [ %t205, %else25 ]
  store { i8**, i64 }* %t206, { i8**, i64 }** %l0
  store i8* %t207, i8** %l1
  %t208 = load double, double* %l3
  %t209 = sitofp i64 1 to double
  %t210 = fadd double %t208, %t209
  store double %t210, double* %l3
  br label %loop.latch2
loop.latch2:
  %t211 = load i8*, i8** %l1
  %t212 = load double, double* %l3
  %t213 = load i1, i1* %l4
  %t214 = load i8*, i8** %l5
  %t215 = load double, double* %l2
  %t216 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t223 = load i8*, i8** %l1
  %t224 = load double, double* %l3
  %t225 = load i1, i1* %l4
  %t226 = load i8*, i8** %l5
  %t227 = load double, double* %l2
  %t228 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t229 = load i8*, i8** %l1
  %t230 = call i64 @sailfin_runtime_string_length(i8* %t229)
  %t231 = icmp sgt i64 %t230, 0
  %t232 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t233 = load i8*, i8** %l1
  %t234 = load double, double* %l2
  %t235 = load double, double* %l3
  %t236 = load i1, i1* %l4
  %t237 = load i8*, i8** %l5
  br i1 %t231, label %then27, label %merge28
then27:
  %t238 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t239 = load i8*, i8** %l1
  %t240 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t238, i8* %t239)
  store { i8**, i64 }* %t240, { i8**, i64 }** %l0
  %t241 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge28
merge28:
  %t242 = phi { i8**, i64 }* [ %t241, %then27 ], [ %t232, %afterloop3 ]
  store { i8**, i64 }* %t242, { i8**, i64 }** %l0
  %t243 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t243
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
  %t10 = call i8* @char_at(i8* %text, double %t9)
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

define double @index_of(i8* %value, i8* %target) {
block.entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i1
  %l3 = alloca i8*
  %l4 = alloca i8*
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
  %t27 = call i8* @char_at(i8* %value, double %t26)
  store i8* %t27, i8** %l3
  %t28 = load double, double* %l1
  %t29 = call i8* @char_at(i8* %target, double %t28)
  store i8* %t29, i8** %l4
  %t30 = load i8*, i8** %l3
  %t31 = load i8*, i8** %l4
  %t32 = icmp ne i8* %t30, %t31
  %t33 = load double, double* %l0
  %t34 = load double, double* %l1
  %t35 = load i1, i1* %l2
  %t36 = load i8*, i8** %l3
  %t37 = load i8*, i8** %l4
  br i1 %t32, label %then14, label %merge15
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

define double @find_matching_brace(i8* %text, double %open_index) {
block.entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i8*
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  store double %open_index, double* %l1
  %t1 = load double, double* %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t53 = phi double [ %t1, %block.entry ], [ %t51, %loop.latch2 ]
  %t54 = phi double [ %t2, %block.entry ], [ %t52, %loop.latch2 ]
  store double %t53, double* %l0
  store double %t54, double* %l1
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
  %t10 = call i8* @char_at(i8* %text, double %t9)
  store i8* %t10, i8** %l2
  %t11 = load i8*, i8** %l2
  %t12 = load i8, i8* %t11
  %t13 = icmp eq i8 %t12, 123
  %t14 = load double, double* %l0
  %t15 = load double, double* %l1
  %t16 = load i8*, i8** %l2
  br i1 %t13, label %then6, label %else7
then6:
  %t17 = load double, double* %l0
  %t18 = sitofp i64 1 to double
  %t19 = fadd double %t17, %t18
  store double %t19, double* %l0
  %t20 = load double, double* %l0
  br label %merge8
else7:
  %t21 = load i8*, i8** %l2
  %t22 = load i8, i8* %t21
  %t23 = icmp eq i8 %t22, 125
  %t24 = load double, double* %l0
  %t25 = load double, double* %l1
  %t26 = load i8*, i8** %l2
  br i1 %t23, label %then9, label %merge10
then9:
  %t27 = load double, double* %l0
  %t28 = sitofp i64 0 to double
  %t29 = fcmp ole double %t27, %t28
  %t30 = load double, double* %l0
  %t31 = load double, double* %l1
  %t32 = load i8*, i8** %l2
  br i1 %t29, label %then11, label %merge12
then11:
  %t33 = sitofp i64 -1 to double
  ret double %t33
merge12:
  %t34 = load double, double* %l0
  %t35 = sitofp i64 1 to double
  %t36 = fsub double %t34, %t35
  store double %t36, double* %l0
  %t37 = load double, double* %l0
  %t38 = sitofp i64 0 to double
  %t39 = fcmp oeq double %t37, %t38
  %t40 = load double, double* %l0
  %t41 = load double, double* %l1
  %t42 = load i8*, i8** %l2
  br i1 %t39, label %then13, label %merge14
then13:
  %t43 = load double, double* %l1
  ret double %t43
merge14:
  %t44 = load double, double* %l0
  br label %merge10
merge10:
  %t45 = phi double [ %t44, %merge14 ], [ %t24, %else7 ]
  store double %t45, double* %l0
  %t46 = load double, double* %l0
  br label %merge8
merge8:
  %t47 = phi double [ %t20, %then6 ], [ %t46, %merge10 ]
  store double %t47, double* %l0
  %t48 = load double, double* %l1
  %t49 = sitofp i64 1 to double
  %t50 = fadd double %t48, %t49
  store double %t50, double* %l1
  br label %loop.latch2
loop.latch2:
  %t51 = load double, double* %l0
  %t52 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t55 = load double, double* %l0
  %t56 = load double, double* %l1
  %t57 = sitofp i64 -1 to double
  ret double %t57
}

define i1 @is_escaped_quote(i8* %text, double %position) {
block.entry:
  %l0 = alloca double
  %l1 = alloca double
  %t0 = sitofp i64 0 to double
  %t1 = fcmp ole double %position, %t0
  br i1 %t1, label %then0, label %merge1
then0:
  ret i1 0
merge1:
  %t2 = sitofp i64 0 to double
  store double %t2, double* %l0
  %t3 = sitofp i64 1 to double
  %t4 = fsub double %position, %t3
  store double %t4, double* %l1
  %t5 = load double, double* %l0
  %t6 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t26 = phi double [ %t5, %merge1 ], [ %t24, %loop.latch4 ]
  %t27 = phi double [ %t6, %merge1 ], [ %t25, %loop.latch4 ]
  store double %t26, double* %l0
  store double %t27, double* %l1
  br label %loop.body3
loop.body3:
  %t7 = load double, double* %l1
  %t8 = sitofp i64 0 to double
  %t9 = fcmp olt double %t7, %t8
  %t10 = load double, double* %l0
  %t11 = load double, double* %l1
  br i1 %t9, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t12 = load double, double* %l1
  %t13 = call i8* @char_at(i8* %text, double %t12)
  %t14 = load i8, i8* %t13
  %t15 = icmp ne i8 %t14, 92
  %t16 = load double, double* %l0
  %t17 = load double, double* %l1
  br i1 %t15, label %then8, label %merge9
then8:
  br label %afterloop5
merge9:
  %t18 = load double, double* %l0
  %t19 = sitofp i64 1 to double
  %t20 = fadd double %t18, %t19
  store double %t20, double* %l0
  %t21 = load double, double* %l1
  %t22 = sitofp i64 1 to double
  %t23 = fsub double %t21, %t22
  store double %t23, double* %l1
  br label %loop.latch4
loop.latch4:
  %t24 = load double, double* %l0
  %t25 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t28 = load double, double* %l0
  %t29 = load double, double* %l1
  %t30 = load double, double* %l0
  %t31 = sitofp i64 2 to double
  %t32 = frem double %t30, %t31
  %t33 = sitofp i64 1 to double
  %t34 = fcmp oeq double %t32, %t33
  %t35 = load double, double* %l0
  %t36 = load double, double* %l1
  br i1 %t34, label %then10, label %merge11
then10:
  ret i1 1
merge11:
  ret i1 0
}

define double @find_next_square_open(i8* %text, double %start) {
block.entry:
  %l0 = alloca double
  %l1 = alloca i1
  %l2 = alloca i1
  %l3 = alloca i8*
  store double %start, double* %l0
  store i1 0, i1* %l1
  store i1 0, i1* %l2
  %t0 = load double, double* %l0
  %t1 = load i1, i1* %l1
  %t2 = load i1, i1* %l2
  br label %loop.header0
loop.header0:
  %t94 = phi i1 [ %t1, %block.entry ], [ %t91, %loop.latch2 ]
  %t95 = phi double [ %t0, %block.entry ], [ %t92, %loop.latch2 ]
  %t96 = phi i1 [ %t2, %block.entry ], [ %t93, %loop.latch2 ]
  store i1 %t94, i1* %l1
  store double %t95, double* %l0
  store i1 %t96, i1* %l2
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l0
  %t4 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t5 = sitofp i64 %t4 to double
  %t6 = fcmp oge double %t3, %t5
  %t7 = load double, double* %l0
  %t8 = load i1, i1* %l1
  %t9 = load i1, i1* %l2
  br i1 %t6, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t10 = load double, double* %l0
  %t11 = call i8* @char_at(i8* %text, double %t10)
  store i8* %t11, i8** %l3
  %t12 = load i8*, i8** %l3
  %t13 = load i8, i8* %t12
  %t14 = icmp eq i8 %t13, 39
  %t15 = load double, double* %l0
  %t16 = load i1, i1* %l1
  %t17 = load i1, i1* %l2
  %t18 = load i8*, i8** %l3
  br i1 %t14, label %then6, label %merge7
then6:
  %t20 = load i1, i1* %l2
  br label %logical_and_entry_19

logical_and_entry_19:
  br i1 %t20, label %logical_and_right_19, label %logical_and_merge_19

logical_and_right_19:
  %t21 = load double, double* %l0
  %t22 = call i1 @is_escaped_quote(i8* %text, double %t21)
  %t23 = xor i1 %t22, 1
  br label %logical_and_right_end_19

logical_and_right_end_19:
  br label %logical_and_merge_19

logical_and_merge_19:
  %t24 = phi i1 [ false, %logical_and_entry_19 ], [ %t23, %logical_and_right_end_19 ]
  %t25 = xor i1 %t24, 1
  %t26 = load double, double* %l0
  %t27 = load i1, i1* %l1
  %t28 = load i1, i1* %l2
  %t29 = load i8*, i8** %l3
  br i1 %t25, label %then8, label %merge9
then8:
  %t30 = load i1, i1* %l1
  %t31 = xor i1 %t30, 1
  store i1 %t31, i1* %l1
  %t32 = load i1, i1* %l1
  br label %merge9
merge9:
  %t33 = phi i1 [ %t32, %then8 ], [ %t27, %logical_and_merge_19 ]
  store i1 %t33, i1* %l1
  %t34 = load double, double* %l0
  %t35 = sitofp i64 1 to double
  %t36 = fadd double %t34, %t35
  store double %t36, double* %l0
  br label %loop.latch2
merge7:
  %t37 = load i8*, i8** %l3
  %t38 = load i8, i8* %t37
  %t39 = icmp eq i8 %t38, 34
  %t40 = load double, double* %l0
  %t41 = load i1, i1* %l1
  %t42 = load i1, i1* %l2
  %t43 = load i8*, i8** %l3
  br i1 %t39, label %then10, label %merge11
then10:
  %t45 = load i1, i1* %l1
  br label %logical_and_entry_44

logical_and_entry_44:
  br i1 %t45, label %logical_and_right_44, label %logical_and_merge_44

logical_and_right_44:
  %t46 = load double, double* %l0
  %t47 = call i1 @is_escaped_quote(i8* %text, double %t46)
  %t48 = xor i1 %t47, 1
  br label %logical_and_right_end_44

logical_and_right_end_44:
  br label %logical_and_merge_44

logical_and_merge_44:
  %t49 = phi i1 [ false, %logical_and_entry_44 ], [ %t48, %logical_and_right_end_44 ]
  %t50 = xor i1 %t49, 1
  %t51 = load double, double* %l0
  %t52 = load i1, i1* %l1
  %t53 = load i1, i1* %l2
  %t54 = load i8*, i8** %l3
  br i1 %t50, label %then12, label %merge13
then12:
  %t55 = load i1, i1* %l2
  %t56 = xor i1 %t55, 1
  store i1 %t56, i1* %l2
  %t57 = load i1, i1* %l2
  br label %merge13
merge13:
  %t58 = phi i1 [ %t57, %then12 ], [ %t53, %logical_and_merge_44 ]
  store i1 %t58, i1* %l2
  %t59 = load double, double* %l0
  %t60 = sitofp i64 1 to double
  %t61 = fadd double %t59, %t60
  store double %t61, double* %l0
  br label %loop.latch2
merge11:
  %t63 = load i1, i1* %l1
  br label %logical_and_entry_62

logical_and_entry_62:
  br i1 %t63, label %logical_and_right_62, label %logical_and_merge_62

logical_and_right_62:
  %t64 = load i1, i1* %l2
  %t65 = xor i1 %t64, 1
  br label %logical_and_right_end_62

logical_and_right_end_62:
  br label %logical_and_merge_62

logical_and_merge_62:
  %t66 = phi i1 [ false, %logical_and_entry_62 ], [ %t65, %logical_and_right_end_62 ]
  %t67 = xor i1 %t66, 1
  %t68 = load double, double* %l0
  %t69 = load i1, i1* %l1
  %t70 = load i1, i1* %l2
  %t71 = load i8*, i8** %l3
  br i1 %t67, label %then14, label %merge15
then14:
  %t72 = load i8*, i8** %l3
  %t73 = load i8, i8* %t72
  %t74 = icmp eq i8 %t73, 91
  %t75 = load double, double* %l0
  %t76 = load i1, i1* %l1
  %t77 = load i1, i1* %l2
  %t78 = load i8*, i8** %l3
  br i1 %t74, label %then16, label %merge17
then16:
  %t79 = load double, double* %l0
  ret double %t79
merge17:
  %t80 = load i8*, i8** %l3
  %t81 = load i8, i8* %t80
  %t82 = icmp eq i8 %t81, 93
  %t83 = load double, double* %l0
  %t84 = load i1, i1* %l1
  %t85 = load i1, i1* %l2
  %t86 = load i8*, i8** %l3
  br i1 %t82, label %then18, label %merge19
then18:
  %t87 = sitofp i64 -1 to double
  ret double %t87
merge19:
  br label %merge15
merge15:
  %t88 = load double, double* %l0
  %t89 = sitofp i64 1 to double
  %t90 = fadd double %t88, %t89
  store double %t90, double* %l0
  br label %loop.latch2
loop.latch2:
  %t91 = load i1, i1* %l1
  %t92 = load double, double* %l0
  %t93 = load i1, i1* %l2
  br label %loop.header0
afterloop3:
  %t97 = load i1, i1* %l1
  %t98 = load double, double* %l0
  %t99 = load i1, i1* %l2
  %t100 = sitofp i64 -1 to double
  ret double %t100
}

define double @find_matching_square(i8* %text, double %open_index) {
block.entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i1
  %l3 = alloca i1
  %l4 = alloca i8
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  store double %open_index, double* %l1
  store i1 0, i1* %l2
  store i1 0, i1* %l3
  %t1 = load double, double* %l0
  %t2 = load double, double* %l1
  %t3 = load i1, i1* %l2
  %t4 = load i1, i1* %l3
  br label %loop.header0
loop.header0:
  %t134 = phi i1 [ %t3, %block.entry ], [ %t130, %loop.latch2 ]
  %t135 = phi double [ %t2, %block.entry ], [ %t131, %loop.latch2 ]
  %t136 = phi i1 [ %t4, %block.entry ], [ %t132, %loop.latch2 ]
  %t137 = phi double [ %t1, %block.entry ], [ %t133, %loop.latch2 ]
  store i1 %t134, i1* %l2
  store double %t135, double* %l1
  store i1 %t136, i1* %l3
  store double %t137, double* %l0
  br label %loop.body1
loop.body1:
  %t5 = load double, double* %l1
  %t6 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t7 = sitofp i64 %t6 to double
  %t8 = fcmp oge double %t5, %t7
  %t9 = load double, double* %l0
  %t10 = load double, double* %l1
  %t11 = load i1, i1* %l2
  %t12 = load i1, i1* %l3
  br i1 %t8, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t13 = load double, double* %l1
  %t14 = fptosi double %t13 to i64
  %t15 = getelementptr i8, i8* %text, i64 %t14
  %t16 = load i8, i8* %t15
  store i8 %t16, i8* %l4
  %t17 = load i8, i8* %l4
  %t18 = icmp eq i8 %t17, 39
  %t19 = load double, double* %l0
  %t20 = load double, double* %l1
  %t21 = load i1, i1* %l2
  %t22 = load i1, i1* %l3
  %t23 = load i8, i8* %l4
  br i1 %t18, label %then6, label %merge7
then6:
  %t25 = load i1, i1* %l3
  br label %logical_and_entry_24

logical_and_entry_24:
  br i1 %t25, label %logical_and_right_24, label %logical_and_merge_24

logical_and_right_24:
  %t26 = load double, double* %l1
  %t27 = call i1 @is_escaped_quote(i8* %text, double %t26)
  %t28 = xor i1 %t27, 1
  br label %logical_and_right_end_24

logical_and_right_end_24:
  br label %logical_and_merge_24

logical_and_merge_24:
  %t29 = phi i1 [ false, %logical_and_entry_24 ], [ %t28, %logical_and_right_end_24 ]
  %t30 = xor i1 %t29, 1
  %t31 = load double, double* %l0
  %t32 = load double, double* %l1
  %t33 = load i1, i1* %l2
  %t34 = load i1, i1* %l3
  %t35 = load i8, i8* %l4
  br i1 %t30, label %then8, label %merge9
then8:
  %t36 = load i1, i1* %l2
  %t37 = xor i1 %t36, 1
  store i1 %t37, i1* %l2
  %t38 = load i1, i1* %l2
  br label %merge9
merge9:
  %t39 = phi i1 [ %t38, %then8 ], [ %t33, %logical_and_merge_24 ]
  store i1 %t39, i1* %l2
  %t40 = load double, double* %l1
  %t41 = sitofp i64 1 to double
  %t42 = fadd double %t40, %t41
  store double %t42, double* %l1
  br label %loop.latch2
merge7:
  %t43 = load i8, i8* %l4
  %t44 = icmp eq i8 %t43, 34
  %t45 = load double, double* %l0
  %t46 = load double, double* %l1
  %t47 = load i1, i1* %l2
  %t48 = load i1, i1* %l3
  %t49 = load i8, i8* %l4
  br i1 %t44, label %then10, label %merge11
then10:
  %t51 = load i1, i1* %l2
  br label %logical_and_entry_50

logical_and_entry_50:
  br i1 %t51, label %logical_and_right_50, label %logical_and_merge_50

logical_and_right_50:
  %t52 = load double, double* %l1
  %t53 = call i1 @is_escaped_quote(i8* %text, double %t52)
  %t54 = xor i1 %t53, 1
  br label %logical_and_right_end_50

logical_and_right_end_50:
  br label %logical_and_merge_50

logical_and_merge_50:
  %t55 = phi i1 [ false, %logical_and_entry_50 ], [ %t54, %logical_and_right_end_50 ]
  %t56 = xor i1 %t55, 1
  %t57 = load double, double* %l0
  %t58 = load double, double* %l1
  %t59 = load i1, i1* %l2
  %t60 = load i1, i1* %l3
  %t61 = load i8, i8* %l4
  br i1 %t56, label %then12, label %merge13
then12:
  %t62 = load i1, i1* %l3
  %t63 = xor i1 %t62, 1
  store i1 %t63, i1* %l3
  %t64 = load i1, i1* %l3
  br label %merge13
merge13:
  %t65 = phi i1 [ %t64, %then12 ], [ %t60, %logical_and_merge_50 ]
  store i1 %t65, i1* %l3
  %t66 = load double, double* %l1
  %t67 = sitofp i64 1 to double
  %t68 = fadd double %t66, %t67
  store double %t68, double* %l1
  br label %loop.latch2
merge11:
  %t70 = load i1, i1* %l2
  br label %logical_and_entry_69

logical_and_entry_69:
  br i1 %t70, label %logical_and_right_69, label %logical_and_merge_69

logical_and_right_69:
  %t71 = load i1, i1* %l3
  %t72 = xor i1 %t71, 1
  br label %logical_and_right_end_69

logical_and_right_end_69:
  br label %logical_and_merge_69

logical_and_merge_69:
  %t73 = phi i1 [ false, %logical_and_entry_69 ], [ %t72, %logical_and_right_end_69 ]
  %t74 = xor i1 %t73, 1
  %t75 = load double, double* %l0
  %t76 = load double, double* %l1
  %t77 = load i1, i1* %l2
  %t78 = load i1, i1* %l3
  %t79 = load i8, i8* %l4
  br i1 %t74, label %then14, label %merge15
then14:
  %t80 = load i8, i8* %l4
  %t81 = icmp eq i8 %t80, 91
  %t82 = load double, double* %l0
  %t83 = load double, double* %l1
  %t84 = load i1, i1* %l2
  %t85 = load i1, i1* %l3
  %t86 = load i8, i8* %l4
  br i1 %t81, label %then16, label %else17
then16:
  %t87 = load double, double* %l0
  %t88 = sitofp i64 1 to double
  %t89 = fadd double %t87, %t88
  store double %t89, double* %l0
  %t90 = load double, double* %l0
  br label %merge18
else17:
  %t91 = load i8, i8* %l4
  %t92 = icmp eq i8 %t91, 93
  %t93 = load double, double* %l0
  %t94 = load double, double* %l1
  %t95 = load i1, i1* %l2
  %t96 = load i1, i1* %l3
  %t97 = load i8, i8* %l4
  br i1 %t92, label %then19, label %merge20
then19:
  %t98 = load double, double* %l0
  %t99 = sitofp i64 0 to double
  %t100 = fcmp ole double %t98, %t99
  %t101 = load double, double* %l0
  %t102 = load double, double* %l1
  %t103 = load i1, i1* %l2
  %t104 = load i1, i1* %l3
  %t105 = load i8, i8* %l4
  br i1 %t100, label %then21, label %merge22
then21:
  %t106 = sitofp i64 -1 to double
  ret double %t106
merge22:
  %t107 = load double, double* %l0
  %t108 = sitofp i64 1 to double
  %t109 = fsub double %t107, %t108
  store double %t109, double* %l0
  %t110 = load double, double* %l0
  %t111 = sitofp i64 0 to double
  %t112 = fcmp oeq double %t110, %t111
  %t113 = load double, double* %l0
  %t114 = load double, double* %l1
  %t115 = load i1, i1* %l2
  %t116 = load i1, i1* %l3
  %t117 = load i8, i8* %l4
  br i1 %t112, label %then23, label %merge24
then23:
  %t118 = load double, double* %l1
  ret double %t118
merge24:
  %t119 = load double, double* %l0
  br label %merge20
merge20:
  %t120 = phi double [ %t119, %merge24 ], [ %t93, %else17 ]
  store double %t120, double* %l0
  %t121 = load double, double* %l0
  br label %merge18
merge18:
  %t122 = phi double [ %t90, %then16 ], [ %t121, %merge20 ]
  store double %t122, double* %l0
  %t123 = load double, double* %l0
  %t124 = load double, double* %l0
  br label %merge15
merge15:
  %t125 = phi double [ %t123, %merge18 ], [ %t75, %logical_and_merge_69 ]
  %t126 = phi double [ %t124, %merge18 ], [ %t75, %logical_and_merge_69 ]
  store double %t125, double* %l0
  store double %t126, double* %l0
  %t127 = load double, double* %l1
  %t128 = sitofp i64 1 to double
  %t129 = fadd double %t127, %t128
  store double %t129, double* %l1
  br label %loop.latch2
loop.latch2:
  %t130 = load i1, i1* %l2
  %t131 = load double, double* %l1
  %t132 = load i1, i1* %l3
  %t133 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t138 = load i1, i1* %l2
  %t139 = load double, double* %l1
  %t140 = load i1, i1* %l3
  %t141 = load double, double* %l0
  %t142 = sitofp i64 -1 to double
  ret double %t142
}

define double @find_substring_from(i8* %value, i8* %pattern, double %start) {
block.entry:
  %l0 = alloca double
  %l1 = alloca i1
  %l2 = alloca double
  %t0 = call i64 @sailfin_runtime_string_length(i8* %pattern)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = sitofp i64 0 to double
  %t3 = fcmp olt double %start, %t2
  br i1 %t3, label %then2, label %merge3
then2:
  %t4 = sitofp i64 0 to double
  ret double %t4
merge3:
  %t5 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp ogt double %start, %t6
  br i1 %t7, label %then4, label %merge5
then4:
  %t8 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t9 = sitofp i64 %t8 to double
  ret double %t9
merge5:
  ret double %start
merge1:
  store double %start, double* %l0
  %t10 = load double, double* %l0
  %t11 = sitofp i64 0 to double
  %t12 = fcmp olt double %t10, %t11
  %t13 = load double, double* %l0
  br i1 %t12, label %then6, label %merge7
then6:
  %t14 = sitofp i64 0 to double
  store double %t14, double* %l0
  %t15 = load double, double* %l0
  br label %merge7
merge7:
  %t16 = phi double [ %t15, %then6 ], [ %t13, %merge1 ]
  store double %t16, double* %l0
  %t17 = load double, double* %l0
  br label %loop.header8
loop.header8:
  %t69 = phi double [ %t17, %merge7 ], [ %t68, %loop.latch10 ]
  store double %t69, double* %l0
  br label %loop.body9
loop.body9:
  %t18 = load double, double* %l0
  %t19 = call i64 @sailfin_runtime_string_length(i8* %pattern)
  %t20 = sitofp i64 %t19 to double
  %t21 = fadd double %t18, %t20
  %t22 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t23 = sitofp i64 %t22 to double
  %t24 = fcmp ogt double %t21, %t23
  %t25 = load double, double* %l0
  br i1 %t24, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  store i1 1, i1* %l1
  %t26 = sitofp i64 0 to double
  store double %t26, double* %l2
  %t27 = load double, double* %l0
  %t28 = load i1, i1* %l1
  %t29 = load double, double* %l2
  br label %loop.header14
loop.header14:
  %t56 = phi i1 [ %t28, %merge13 ], [ %t54, %loop.latch16 ]
  %t57 = phi double [ %t29, %merge13 ], [ %t55, %loop.latch16 ]
  store i1 %t56, i1* %l1
  store double %t57, double* %l2
  br label %loop.body15
loop.body15:
  %t30 = load double, double* %l2
  %t31 = call i64 @sailfin_runtime_string_length(i8* %pattern)
  %t32 = sitofp i64 %t31 to double
  %t33 = fcmp oge double %t30, %t32
  %t34 = load double, double* %l0
  %t35 = load i1, i1* %l1
  %t36 = load double, double* %l2
  br i1 %t33, label %then18, label %merge19
then18:
  br label %afterloop17
merge19:
  %t37 = load double, double* %l0
  %t38 = load double, double* %l2
  %t39 = fadd double %t37, %t38
  %t40 = fptosi double %t39 to i64
  %t41 = getelementptr i8, i8* %value, i64 %t40
  %t42 = load i8, i8* %t41
  %t43 = load double, double* %l2
  %t44 = fptosi double %t43 to i64
  %t45 = getelementptr i8, i8* %pattern, i64 %t44
  %t46 = load i8, i8* %t45
  %t47 = icmp ne i8 %t42, %t46
  %t48 = load double, double* %l0
  %t49 = load i1, i1* %l1
  %t50 = load double, double* %l2
  br i1 %t47, label %then20, label %merge21
then20:
  store i1 0, i1* %l1
  br label %afterloop17
merge21:
  %t51 = load double, double* %l2
  %t52 = sitofp i64 1 to double
  %t53 = fadd double %t51, %t52
  store double %t53, double* %l2
  br label %loop.latch16
loop.latch16:
  %t54 = load i1, i1* %l1
  %t55 = load double, double* %l2
  br label %loop.header14
afterloop17:
  %t58 = load i1, i1* %l1
  %t59 = load double, double* %l2
  %t60 = load i1, i1* %l1
  %t61 = load double, double* %l0
  %t62 = load i1, i1* %l1
  %t63 = load double, double* %l2
  br i1 %t60, label %then22, label %merge23
then22:
  %t64 = load double, double* %l0
  ret double %t64
merge23:
  %t65 = load double, double* %l0
  %t66 = sitofp i64 1 to double
  %t67 = fadd double %t65, %t66
  store double %t67, double* %l0
  br label %loop.latch10
loop.latch10:
  %t68 = load double, double* %l0
  br label %loop.header8
afterloop11:
  %t70 = load double, double* %l0
  %t71 = sitofp i64 -1 to double
  ret double %t71
}

define %PythonFunctionEmission @emit_python_function(%PythonBuilder %builder, %NativeFunction %function) {
block.entry:
  %l0 = alloca %PythonBuilder
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca i8*
  %l4 = alloca double
  %l5 = alloca { %MatchContext*, i64 }*
  %l6 = alloca double
  %l7 = alloca double
  %l8 = alloca %NativeInstruction*
  %l9 = alloca i8*
  %l10 = alloca %StructLiteralCapture
  %l11 = alloca double
  %l12 = alloca %ExpressionContinuationCapture
  %l13 = alloca i8*
  %l14 = alloca %StructLiteralCapture
  %l15 = alloca double
  %l16 = alloca %ExpressionContinuationCapture
  %l17 = alloca i8*
  %l18 = alloca i8*
  %l19 = alloca i8*
  %l20 = alloca %StructLiteralCapture
  %l21 = alloca double
  %l22 = alloca %ExpressionContinuationCapture
  %l23 = alloca i8*
  %l24 = alloca i8*
  %l25 = alloca i8*
  %l26 = alloca i8*
  %l27 = alloca %MatchContext
  %l28 = alloca i8*
  %l29 = alloca i8*
  %l30 = alloca i64
  %l31 = alloca %MatchContext
  %l32 = alloca %LoweredCaseCondition
  %l33 = alloca %MatchContext
  %l34 = alloca i64
  %l35 = alloca %MatchContext
  %l36 = alloca i8*
  %l37 = alloca i8*
  %l38 = alloca i64
  %l39 = alloca %MatchContext
  store %PythonBuilder %builder, %PythonBuilder* %l0
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
  store { i8**, i64 }* %t9, { i8**, i64 }** %l1
  %t12 = extractvalue %NativeFunction %function, 1
  %t13 = bitcast { %NativeParameter**, i64 }* %t12 to { %NativeParameter*, i64 }*
  %t14 = call { i8**, i64 }* @render_python_parameters({ %NativeParameter*, i64 }* %t13)
  store { i8**, i64 }* %t14, { i8**, i64 }** %l2
  %s15 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h256486202, i32 0, i32 0
  %t16 = extractvalue %NativeFunction %function, 0
  %t17 = call i8* @sanitize_identifier(i8* %t16)
  %t18 = call i8* @sailfin_runtime_string_concat(i8* %s15, i8* %t17)
  %t19 = alloca [2 x i8], align 1
  %t20 = getelementptr [2 x i8], [2 x i8]* %t19, i32 0, i32 0
  store i8 40, i8* %t20
  %t21 = getelementptr [2 x i8], [2 x i8]* %t19, i32 0, i32 1
  store i8 0, i8* %t21
  %t22 = getelementptr [2 x i8], [2 x i8]* %t19, i32 0, i32 0
  %t23 = call i8* @sailfin_runtime_string_concat(i8* %t18, i8* %t22)
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %s25 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t26 = call i8* @join_with_separator({ i8**, i64 }* %t24, i8* %s25)
  %t27 = call i8* @sailfin_runtime_string_concat(i8* %t23, i8* %t26)
  %s28 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193423562, i32 0, i32 0
  %t29 = call i8* @sailfin_runtime_string_concat(i8* %t27, i8* %s28)
  store i8* %t29, i8** %l3
  %t30 = load %PythonBuilder, %PythonBuilder* %l0
  %t31 = load i8*, i8** %l3
  %t32 = call %PythonBuilder @builder_emit(%PythonBuilder %t30, i8* %t31)
  store %PythonBuilder %t32, %PythonBuilder* %l0
  %t33 = load %PythonBuilder, %PythonBuilder* %l0
  %t34 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t33)
  store %PythonBuilder %t34, %PythonBuilder* %l0
  %t35 = extractvalue %NativeFunction %function, 3
  %t36 = load { i8**, i64 }, { i8**, i64 }* %t35
  %t37 = extractvalue { i8**, i64 } %t36, 1
  %t38 = icmp sgt i64 %t37, 0
  %t39 = load %PythonBuilder, %PythonBuilder* %l0
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t42 = load i8*, i8** %l3
  br i1 %t38, label %then0, label %merge1
then0:
  %t43 = load %PythonBuilder, %PythonBuilder* %l0
  %s44 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1779553665, i32 0, i32 0
  %t45 = extractvalue %NativeFunction %function, 3
  %s46 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t47 = call i8* @join_with_separator({ i8**, i64 }* %t45, i8* %s46)
  %t48 = call i8* @sailfin_runtime_string_concat(i8* %s44, i8* %t47)
  %t49 = call %PythonBuilder @builder_emit(%PythonBuilder %t43, i8* %t48)
  store %PythonBuilder %t49, %PythonBuilder* %l0
  %t50 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge1
merge1:
  %t51 = phi %PythonBuilder [ %t50, %then0 ], [ %t39, %block.entry ]
  store %PythonBuilder %t51, %PythonBuilder* %l0
  %t52 = extractvalue %NativeFunction %function, 4
  %t53 = load { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t52
  %t54 = extractvalue { %NativeInstruction**, i64 } %t53, 1
  %t55 = icmp eq i64 %t54, 0
  %t56 = load %PythonBuilder, %PythonBuilder* %l0
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t59 = load i8*, i8** %l3
  br i1 %t55, label %then2, label %merge3
then2:
  %t60 = load %PythonBuilder, %PythonBuilder* %l0
  %s61 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h270590402, i32 0, i32 0
  %t62 = call %PythonBuilder @builder_emit(%PythonBuilder %t60, i8* %s61)
  store %PythonBuilder %t62, %PythonBuilder* %l0
  %t63 = load %PythonBuilder, %PythonBuilder* %l0
  %t64 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t63)
  store %PythonBuilder %t64, %PythonBuilder* %l0
  %t65 = load %PythonBuilder, %PythonBuilder* %l0
  %t66 = insertvalue %PythonFunctionEmission undef, %PythonBuilder %t65, 0
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t68 = insertvalue %PythonFunctionEmission %t66, { i8**, i64 }* %t67, 1
  ret %PythonFunctionEmission %t68
merge3:
  %t69 = sitofp i64 0 to double
  store double %t69, double* %l4
  %t70 = getelementptr [0 x %MatchContext], [0 x %MatchContext]* null, i32 1
  %t71 = ptrtoint [0 x %MatchContext]* %t70 to i64
  %t72 = icmp eq i64 %t71, 0
  %t73 = select i1 %t72, i64 1, i64 %t71
  %t74 = call i8* @malloc(i64 %t73)
  %t75 = bitcast i8* %t74 to %MatchContext*
  %t76 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* null, i32 1
  %t77 = ptrtoint { %MatchContext*, i64 }* %t76 to i64
  %t78 = call i8* @malloc(i64 %t77)
  %t79 = bitcast i8* %t78 to { %MatchContext*, i64 }*
  %t80 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t79, i32 0, i32 0
  store %MatchContext* %t75, %MatchContext** %t80
  %t81 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t79, i32 0, i32 1
  store i64 0, i64* %t81
  store { %MatchContext*, i64 }* %t79, { %MatchContext*, i64 }** %l5
  %t82 = sitofp i64 0 to double
  store double %t82, double* %l6
  %t83 = sitofp i64 0 to double
  store double %t83, double* %l7
  %t84 = load %PythonBuilder, %PythonBuilder* %l0
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t86 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t87 = load i8*, i8** %l3
  %t88 = load double, double* %l4
  %t89 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t90 = load double, double* %l6
  %t91 = load double, double* %l7
  br label %loop.header4
loop.header4:
  %t2594 = phi %PythonBuilder [ %t84, %merge3 ], [ %t2588, %loop.latch6 ]
  %t2595 = phi double [ %t91, %merge3 ], [ %t2589, %loop.latch6 ]
  %t2596 = phi double [ %t88, %merge3 ], [ %t2590, %loop.latch6 ]
  %t2597 = phi { i8**, i64 }* [ %t85, %merge3 ], [ %t2591, %loop.latch6 ]
  %t2598 = phi double [ %t90, %merge3 ], [ %t2592, %loop.latch6 ]
  %t2599 = phi { %MatchContext*, i64 }* [ %t89, %merge3 ], [ %t2593, %loop.latch6 ]
  store %PythonBuilder %t2594, %PythonBuilder* %l0
  store double %t2595, double* %l7
  store double %t2596, double* %l4
  store { i8**, i64 }* %t2597, { i8**, i64 }** %l1
  store double %t2598, double* %l6
  store { %MatchContext*, i64 }* %t2599, { %MatchContext*, i64 }** %l5
  br label %loop.body5
loop.body5:
  %t92 = load double, double* %l7
  %t93 = extractvalue %NativeFunction %function, 4
  %t94 = load { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t93
  %t95 = extractvalue { %NativeInstruction**, i64 } %t94, 1
  %t96 = sitofp i64 %t95 to double
  %t97 = fcmp oge double %t92, %t96
  %t98 = load %PythonBuilder, %PythonBuilder* %l0
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t101 = load i8*, i8** %l3
  %t102 = load double, double* %l4
  %t103 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t104 = load double, double* %l6
  %t105 = load double, double* %l7
  br i1 %t97, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t106 = extractvalue %NativeFunction %function, 4
  %t107 = load double, double* %l7
  %t108 = fptosi double %t107 to i64
  %t109 = load { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t106
  %t110 = extractvalue { %NativeInstruction**, i64 } %t109, 0
  %t111 = extractvalue { %NativeInstruction**, i64 } %t109, 1
  %t112 = icmp uge i64 %t108, %t111
  ; bounds check: %t112 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t108, i64 %t111)
  %t113 = getelementptr %NativeInstruction*, %NativeInstruction** %t110, i64 %t108
  %t114 = load %NativeInstruction*, %NativeInstruction** %t113
  store %NativeInstruction* %t114, %NativeInstruction** %l8
  %t115 = load %NativeInstruction*, %NativeInstruction** %l8
  %t116 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t115, i32 0, i32 0
  %t117 = load i32, i32* %t116
  %t118 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t119 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t120 = icmp eq i32 %t117, 0
  %t121 = select i1 %t120, i8* %t119, i8* %t118
  %t122 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t123 = icmp eq i32 %t117, 1
  %t124 = select i1 %t123, i8* %t122, i8* %t121
  %t125 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t126 = icmp eq i32 %t117, 2
  %t127 = select i1 %t126, i8* %t125, i8* %t124
  %t128 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t129 = icmp eq i32 %t117, 3
  %t130 = select i1 %t129, i8* %t128, i8* %t127
  %t131 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t132 = icmp eq i32 %t117, 4
  %t133 = select i1 %t132, i8* %t131, i8* %t130
  %t134 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t135 = icmp eq i32 %t117, 5
  %t136 = select i1 %t135, i8* %t134, i8* %t133
  %t137 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t138 = icmp eq i32 %t117, 6
  %t139 = select i1 %t138, i8* %t137, i8* %t136
  %t140 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t141 = icmp eq i32 %t117, 7
  %t142 = select i1 %t141, i8* %t140, i8* %t139
  %t143 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t144 = icmp eq i32 %t117, 8
  %t145 = select i1 %t144, i8* %t143, i8* %t142
  %t146 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t147 = icmp eq i32 %t117, 9
  %t148 = select i1 %t147, i8* %t146, i8* %t145
  %t149 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t150 = icmp eq i32 %t117, 10
  %t151 = select i1 %t150, i8* %t149, i8* %t148
  %t152 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t153 = icmp eq i32 %t117, 11
  %t154 = select i1 %t153, i8* %t152, i8* %t151
  %t155 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t156 = icmp eq i32 %t117, 12
  %t157 = select i1 %t156, i8* %t155, i8* %t154
  %t158 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t159 = icmp eq i32 %t117, 13
  %t160 = select i1 %t159, i8* %t158, i8* %t157
  %t161 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t162 = icmp eq i32 %t117, 14
  %t163 = select i1 %t162, i8* %t161, i8* %t160
  %t164 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t165 = icmp eq i32 %t117, 15
  %t166 = select i1 %t165, i8* %t164, i8* %t163
  %t167 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t168 = icmp eq i32 %t117, 16
  %t169 = select i1 %t168, i8* %t167, i8* %t166
  %s170 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h536277508, i32 0, i32 0
  %t171 = icmp eq i8* %t169, %s170
  %t172 = load %PythonBuilder, %PythonBuilder* %l0
  %t173 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t174 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t175 = load i8*, i8** %l3
  %t176 = load double, double* %l4
  %t177 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t178 = load double, double* %l6
  %t179 = load double, double* %l7
  %t180 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t171, label %then10, label %else11
then10:
  %t181 = load %NativeInstruction*, %NativeInstruction** %l8
  %t182 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t181, i32 0, i32 0
  %t183 = load i32, i32* %t182
  %t184 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t181, i32 0, i32 1
  %t185 = bitcast [16 x i8]* %t184 to i8*
  %t186 = bitcast i8* %t185 to i8**
  %t187 = load i8*, i8** %t186
  %t188 = icmp eq i32 %t183, 0
  %t189 = select i1 %t188, i8* %t187, i8* null
  %t190 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t181, i32 0, i32 1
  %t191 = bitcast [16 x i8]* %t190 to i8*
  %t192 = bitcast i8* %t191 to i8**
  %t193 = load i8*, i8** %t192
  %t194 = icmp eq i32 %t183, 1
  %t195 = select i1 %t194, i8* %t193, i8* %t189
  %t196 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t181, i32 0, i32 1
  %t197 = bitcast [8 x i8]* %t196 to i8*
  %t198 = bitcast i8* %t197 to i8**
  %t199 = load i8*, i8** %t198
  %t200 = icmp eq i32 %t183, 12
  %t201 = select i1 %t200, i8* %t199, i8* %t195
  %t202 = call i64 @sailfin_runtime_string_length(i8* %t201)
  %t203 = icmp eq i64 %t202, 0
  %t204 = load %PythonBuilder, %PythonBuilder* %l0
  %t205 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t206 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t207 = load i8*, i8** %l3
  %t208 = load double, double* %l4
  %t209 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t210 = load double, double* %l6
  %t211 = load double, double* %l7
  %t212 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t203, label %then13, label %else14
then13:
  %t213 = load %PythonBuilder, %PythonBuilder* %l0
  %s214 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1061063223, i32 0, i32 0
  %t215 = call %PythonBuilder @builder_emit(%PythonBuilder %t213, i8* %s214)
  store %PythonBuilder %t215, %PythonBuilder* %l0
  %t216 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge15
else14:
  %t217 = load %NativeInstruction*, %NativeInstruction** %l8
  %t218 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t217, i32 0, i32 0
  %t219 = load i32, i32* %t218
  %t220 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t217, i32 0, i32 1
  %t221 = bitcast [16 x i8]* %t220 to i8*
  %t222 = bitcast i8* %t221 to i8**
  %t223 = load i8*, i8** %t222
  %t224 = icmp eq i32 %t219, 0
  %t225 = select i1 %t224, i8* %t223, i8* null
  %t226 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t217, i32 0, i32 1
  %t227 = bitcast [16 x i8]* %t226 to i8*
  %t228 = bitcast i8* %t227 to i8**
  %t229 = load i8*, i8** %t228
  %t230 = icmp eq i32 %t219, 1
  %t231 = select i1 %t230, i8* %t229, i8* %t225
  %t232 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t217, i32 0, i32 1
  %t233 = bitcast [8 x i8]* %t232 to i8*
  %t234 = bitcast i8* %t233 to i8**
  %t235 = load i8*, i8** %t234
  %t236 = icmp eq i32 %t219, 12
  %t237 = select i1 %t236, i8* %t235, i8* %t231
  store i8* %t237, i8** %l9
  %t238 = load i8*, i8** %l9
  %t239 = extractvalue %NativeFunction %function, 4
  %t240 = load double, double* %l7
  %t241 = sitofp i64 1 to double
  %t242 = fadd double %t240, %t241
  %t243 = bitcast { %NativeInstruction**, i64 }* %t239 to { %NativeInstruction*, i64 }*
  %t244 = call %StructLiteralCapture @capture_struct_literal_expression(i8* %t238, { %NativeInstruction*, i64 }* %t243, double %t242)
  store %StructLiteralCapture %t244, %StructLiteralCapture* %l10
  %t245 = sitofp i64 0 to double
  store double %t245, double* %l11
  %t246 = load %StructLiteralCapture, %StructLiteralCapture* %l10
  %t247 = extractvalue %StructLiteralCapture %t246, 2
  %t248 = load %PythonBuilder, %PythonBuilder* %l0
  %t249 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t250 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t251 = load i8*, i8** %l3
  %t252 = load double, double* %l4
  %t253 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t254 = load double, double* %l6
  %t255 = load double, double* %l7
  %t256 = load %NativeInstruction*, %NativeInstruction** %l8
  %t257 = load i8*, i8** %l9
  %t258 = load %StructLiteralCapture, %StructLiteralCapture* %l10
  %t259 = load double, double* %l11
  br i1 %t247, label %then16, label %else17
then16:
  %t260 = load %StructLiteralCapture, %StructLiteralCapture* %l10
  %t261 = extractvalue %StructLiteralCapture %t260, 0
  store i8* %t261, i8** %l9
  %t262 = load %StructLiteralCapture, %StructLiteralCapture* %l10
  %t263 = extractvalue %StructLiteralCapture %t262, 1
  store double %t263, double* %l11
  %t264 = load i8*, i8** %l9
  %t265 = load double, double* %l11
  br label %merge18
else17:
  %t266 = load i8*, i8** %l9
  %t267 = extractvalue %NativeFunction %function, 4
  %t268 = load double, double* %l7
  %t269 = sitofp i64 1 to double
  %t270 = fadd double %t268, %t269
  %t271 = bitcast { %NativeInstruction**, i64 }* %t267 to { %NativeInstruction*, i64 }*
  %t272 = call %ExpressionContinuationCapture @capture_expression_continuation(i8* %t266, { %NativeInstruction*, i64 }* %t271, double %t270)
  store %ExpressionContinuationCapture %t272, %ExpressionContinuationCapture* %l12
  %t273 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l12
  %t274 = extractvalue %ExpressionContinuationCapture %t273, 2
  %t275 = load %PythonBuilder, %PythonBuilder* %l0
  %t276 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t277 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t278 = load i8*, i8** %l3
  %t279 = load double, double* %l4
  %t280 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t281 = load double, double* %l6
  %t282 = load double, double* %l7
  %t283 = load %NativeInstruction*, %NativeInstruction** %l8
  %t284 = load i8*, i8** %l9
  %t285 = load %StructLiteralCapture, %StructLiteralCapture* %l10
  %t286 = load double, double* %l11
  %t287 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l12
  br i1 %t274, label %then19, label %merge20
then19:
  %t288 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l12
  %t289 = extractvalue %ExpressionContinuationCapture %t288, 0
  store i8* %t289, i8** %l9
  %t290 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l12
  %t291 = extractvalue %ExpressionContinuationCapture %t290, 1
  store double %t291, double* %l11
  %t292 = load i8*, i8** %l9
  %t293 = load double, double* %l11
  br label %merge20
merge20:
  %t294 = phi i8* [ %t292, %then19 ], [ %t284, %else17 ]
  %t295 = phi double [ %t293, %then19 ], [ %t286, %else17 ]
  store i8* %t294, i8** %l9
  store double %t295, double* %l11
  %t296 = load i8*, i8** %l9
  %t297 = load double, double* %l11
  br label %merge18
merge18:
  %t298 = phi i8* [ %t264, %then16 ], [ %t296, %merge20 ]
  %t299 = phi double [ %t265, %then16 ], [ %t297, %merge20 ]
  store i8* %t298, i8** %l9
  store double %t299, double* %l11
  %t300 = load %PythonBuilder, %PythonBuilder* %l0
  %s301 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h655348872, i32 0, i32 0
  %t302 = load i8*, i8** %l9
  %t303 = call i8* @lower_expression(i8* %t302)
  %t304 = call i8* @sailfin_runtime_string_concat(i8* %s301, i8* %t303)
  %t305 = call %PythonBuilder @builder_emit(%PythonBuilder %t300, i8* %t304)
  store %PythonBuilder %t305, %PythonBuilder* %l0
  %t306 = load double, double* %l7
  %t307 = load double, double* %l11
  %t308 = fadd double %t306, %t307
  store double %t308, double* %l7
  %t309 = load %PythonBuilder, %PythonBuilder* %l0
  %t310 = load double, double* %l7
  br label %merge15
merge15:
  %t311 = phi %PythonBuilder [ %t216, %then13 ], [ %t309, %merge18 ]
  %t312 = phi double [ %t211, %then13 ], [ %t310, %merge18 ]
  store %PythonBuilder %t311, %PythonBuilder* %l0
  store double %t312, double* %l7
  %t313 = load %PythonBuilder, %PythonBuilder* %l0
  %t314 = load %PythonBuilder, %PythonBuilder* %l0
  %t315 = load double, double* %l7
  br label %merge12
else11:
  %t316 = load %NativeInstruction*, %NativeInstruction** %l8
  %t317 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t316, i32 0, i32 0
  %t318 = load i32, i32* %t317
  %t319 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t320 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t321 = icmp eq i32 %t318, 0
  %t322 = select i1 %t321, i8* %t320, i8* %t319
  %t323 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t324 = icmp eq i32 %t318, 1
  %t325 = select i1 %t324, i8* %t323, i8* %t322
  %t326 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t327 = icmp eq i32 %t318, 2
  %t328 = select i1 %t327, i8* %t326, i8* %t325
  %t329 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t330 = icmp eq i32 %t318, 3
  %t331 = select i1 %t330, i8* %t329, i8* %t328
  %t332 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t333 = icmp eq i32 %t318, 4
  %t334 = select i1 %t333, i8* %t332, i8* %t331
  %t335 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t336 = icmp eq i32 %t318, 5
  %t337 = select i1 %t336, i8* %t335, i8* %t334
  %t338 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t339 = icmp eq i32 %t318, 6
  %t340 = select i1 %t339, i8* %t338, i8* %t337
  %t341 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t342 = icmp eq i32 %t318, 7
  %t343 = select i1 %t342, i8* %t341, i8* %t340
  %t344 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t345 = icmp eq i32 %t318, 8
  %t346 = select i1 %t345, i8* %t344, i8* %t343
  %t347 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t348 = icmp eq i32 %t318, 9
  %t349 = select i1 %t348, i8* %t347, i8* %t346
  %t350 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t351 = icmp eq i32 %t318, 10
  %t352 = select i1 %t351, i8* %t350, i8* %t349
  %t353 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t354 = icmp eq i32 %t318, 11
  %t355 = select i1 %t354, i8* %t353, i8* %t352
  %t356 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t357 = icmp eq i32 %t318, 12
  %t358 = select i1 %t357, i8* %t356, i8* %t355
  %t359 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t360 = icmp eq i32 %t318, 13
  %t361 = select i1 %t360, i8* %t359, i8* %t358
  %t362 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t363 = icmp eq i32 %t318, 14
  %t364 = select i1 %t363, i8* %t362, i8* %t361
  %t365 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t366 = icmp eq i32 %t318, 15
  %t367 = select i1 %t366, i8* %t365, i8* %t364
  %t368 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t369 = icmp eq i32 %t318, 16
  %t370 = select i1 %t369, i8* %t368, i8* %t367
  %s371 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h1629914700, i32 0, i32 0
  %t372 = icmp eq i8* %t370, %s371
  %t373 = load %PythonBuilder, %PythonBuilder* %l0
  %t374 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t375 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t376 = load i8*, i8** %l3
  %t377 = load double, double* %l4
  %t378 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t379 = load double, double* %l6
  %t380 = load double, double* %l7
  %t381 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t372, label %then21, label %else22
then21:
  %t382 = load %NativeInstruction*, %NativeInstruction** %l8
  %t383 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t382, i32 0, i32 0
  %t384 = load i32, i32* %t383
  %t385 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t382, i32 0, i32 1
  %t386 = bitcast [16 x i8]* %t385 to i8*
  %t387 = bitcast i8* %t386 to i8**
  %t388 = load i8*, i8** %t387
  %t389 = icmp eq i32 %t384, 0
  %t390 = select i1 %t389, i8* %t388, i8* null
  %t391 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t382, i32 0, i32 1
  %t392 = bitcast [16 x i8]* %t391 to i8*
  %t393 = bitcast i8* %t392 to i8**
  %t394 = load i8*, i8** %t393
  %t395 = icmp eq i32 %t384, 1
  %t396 = select i1 %t395, i8* %t394, i8* %t390
  %t397 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t382, i32 0, i32 1
  %t398 = bitcast [8 x i8]* %t397 to i8*
  %t399 = bitcast i8* %t398 to i8**
  %t400 = load i8*, i8** %t399
  %t401 = icmp eq i32 %t384, 12
  %t402 = select i1 %t401, i8* %t400, i8* %t396
  store i8* %t402, i8** %l13
  %t403 = load i8*, i8** %l13
  %t404 = extractvalue %NativeFunction %function, 4
  %t405 = load double, double* %l7
  %t406 = sitofp i64 1 to double
  %t407 = fadd double %t405, %t406
  %t408 = bitcast { %NativeInstruction**, i64 }* %t404 to { %NativeInstruction*, i64 }*
  %t409 = call %StructLiteralCapture @capture_struct_literal_expression(i8* %t403, { %NativeInstruction*, i64 }* %t408, double %t407)
  store %StructLiteralCapture %t409, %StructLiteralCapture* %l14
  %t410 = sitofp i64 0 to double
  store double %t410, double* %l15
  %t411 = load %StructLiteralCapture, %StructLiteralCapture* %l14
  %t412 = extractvalue %StructLiteralCapture %t411, 2
  %t413 = load %PythonBuilder, %PythonBuilder* %l0
  %t414 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t415 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t416 = load i8*, i8** %l3
  %t417 = load double, double* %l4
  %t418 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t419 = load double, double* %l6
  %t420 = load double, double* %l7
  %t421 = load %NativeInstruction*, %NativeInstruction** %l8
  %t422 = load i8*, i8** %l13
  %t423 = load %StructLiteralCapture, %StructLiteralCapture* %l14
  %t424 = load double, double* %l15
  br i1 %t412, label %then24, label %else25
then24:
  %t425 = load %StructLiteralCapture, %StructLiteralCapture* %l14
  %t426 = extractvalue %StructLiteralCapture %t425, 0
  store i8* %t426, i8** %l13
  %t427 = load %StructLiteralCapture, %StructLiteralCapture* %l14
  %t428 = extractvalue %StructLiteralCapture %t427, 1
  store double %t428, double* %l15
  %t429 = load i8*, i8** %l13
  %t430 = load double, double* %l15
  br label %merge26
else25:
  %t431 = load i8*, i8** %l13
  %t432 = extractvalue %NativeFunction %function, 4
  %t433 = load double, double* %l7
  %t434 = sitofp i64 1 to double
  %t435 = fadd double %t433, %t434
  %t436 = bitcast { %NativeInstruction**, i64 }* %t432 to { %NativeInstruction*, i64 }*
  %t437 = call %ExpressionContinuationCapture @capture_expression_continuation(i8* %t431, { %NativeInstruction*, i64 }* %t436, double %t435)
  store %ExpressionContinuationCapture %t437, %ExpressionContinuationCapture* %l16
  %t438 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l16
  %t439 = extractvalue %ExpressionContinuationCapture %t438, 2
  %t440 = load %PythonBuilder, %PythonBuilder* %l0
  %t441 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t442 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t443 = load i8*, i8** %l3
  %t444 = load double, double* %l4
  %t445 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t446 = load double, double* %l6
  %t447 = load double, double* %l7
  %t448 = load %NativeInstruction*, %NativeInstruction** %l8
  %t449 = load i8*, i8** %l13
  %t450 = load %StructLiteralCapture, %StructLiteralCapture* %l14
  %t451 = load double, double* %l15
  %t452 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l16
  br i1 %t439, label %then27, label %merge28
then27:
  %t453 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l16
  %t454 = extractvalue %ExpressionContinuationCapture %t453, 0
  store i8* %t454, i8** %l13
  %t455 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l16
  %t456 = extractvalue %ExpressionContinuationCapture %t455, 1
  store double %t456, double* %l15
  %t457 = load i8*, i8** %l13
  %t458 = load double, double* %l15
  br label %merge28
merge28:
  %t459 = phi i8* [ %t457, %then27 ], [ %t449, %else25 ]
  %t460 = phi double [ %t458, %then27 ], [ %t451, %else25 ]
  store i8* %t459, i8** %l13
  store double %t460, double* %l15
  %t461 = load i8*, i8** %l13
  %t462 = load double, double* %l15
  br label %merge26
merge26:
  %t463 = phi i8* [ %t429, %then24 ], [ %t461, %merge28 ]
  %t464 = phi double [ %t430, %then24 ], [ %t462, %merge28 ]
  store i8* %t463, i8** %l13
  store double %t464, double* %l15
  %t465 = load %PythonBuilder, %PythonBuilder* %l0
  %t466 = load i8*, i8** %l13
  %t467 = call i8* @lower_expression(i8* %t466)
  %t468 = call %PythonBuilder @builder_emit(%PythonBuilder %t465, i8* %t467)
  store %PythonBuilder %t468, %PythonBuilder* %l0
  %t469 = load double, double* %l7
  %t470 = load double, double* %l15
  %t471 = fadd double %t469, %t470
  store double %t471, double* %l7
  %t472 = load %PythonBuilder, %PythonBuilder* %l0
  %t473 = load double, double* %l7
  br label %merge23
else22:
  %t474 = load %NativeInstruction*, %NativeInstruction** %l8
  %t475 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t474, i32 0, i32 0
  %t476 = load i32, i32* %t475
  %t477 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t478 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t479 = icmp eq i32 %t476, 0
  %t480 = select i1 %t479, i8* %t478, i8* %t477
  %t481 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t482 = icmp eq i32 %t476, 1
  %t483 = select i1 %t482, i8* %t481, i8* %t480
  %t484 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t485 = icmp eq i32 %t476, 2
  %t486 = select i1 %t485, i8* %t484, i8* %t483
  %t487 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t488 = icmp eq i32 %t476, 3
  %t489 = select i1 %t488, i8* %t487, i8* %t486
  %t490 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t491 = icmp eq i32 %t476, 4
  %t492 = select i1 %t491, i8* %t490, i8* %t489
  %t493 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t494 = icmp eq i32 %t476, 5
  %t495 = select i1 %t494, i8* %t493, i8* %t492
  %t496 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t497 = icmp eq i32 %t476, 6
  %t498 = select i1 %t497, i8* %t496, i8* %t495
  %t499 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t500 = icmp eq i32 %t476, 7
  %t501 = select i1 %t500, i8* %t499, i8* %t498
  %t502 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t503 = icmp eq i32 %t476, 8
  %t504 = select i1 %t503, i8* %t502, i8* %t501
  %t505 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t506 = icmp eq i32 %t476, 9
  %t507 = select i1 %t506, i8* %t505, i8* %t504
  %t508 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t509 = icmp eq i32 %t476, 10
  %t510 = select i1 %t509, i8* %t508, i8* %t507
  %t511 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t512 = icmp eq i32 %t476, 11
  %t513 = select i1 %t512, i8* %t511, i8* %t510
  %t514 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t515 = icmp eq i32 %t476, 12
  %t516 = select i1 %t515, i8* %t514, i8* %t513
  %t517 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t518 = icmp eq i32 %t476, 13
  %t519 = select i1 %t518, i8* %t517, i8* %t516
  %t520 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t521 = icmp eq i32 %t476, 14
  %t522 = select i1 %t521, i8* %t520, i8* %t519
  %t523 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t524 = icmp eq i32 %t476, 15
  %t525 = select i1 %t524, i8* %t523, i8* %t522
  %t526 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t527 = icmp eq i32 %t476, 16
  %t528 = select i1 %t527, i8* %t526, i8* %t525
  %s529 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2089318639, i32 0, i32 0
  %t530 = icmp eq i8* %t528, %s529
  %t531 = load %PythonBuilder, %PythonBuilder* %l0
  %t532 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t533 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t534 = load i8*, i8** %l3
  %t535 = load double, double* %l4
  %t536 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t537 = load double, double* %l6
  %t538 = load double, double* %l7
  %t539 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t530, label %then29, label %else30
then29:
  %t540 = load %NativeInstruction*, %NativeInstruction** %l8
  %t541 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t540, i32 0, i32 0
  %t542 = load i32, i32* %t541
  %t543 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t540, i32 0, i32 1
  %t544 = bitcast [48 x i8]* %t543 to i8*
  %t545 = bitcast i8* %t544 to i8**
  %t546 = load i8*, i8** %t545
  %t547 = icmp eq i32 %t542, 2
  %t548 = select i1 %t547, i8* %t546, i8* null
  %t549 = call i8* @sanitize_identifier(i8* %t548)
  store i8* %t549, i8** %l17
  %t550 = load i8*, i8** %l17
  %s551 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087691079, i32 0, i32 0
  %t552 = call i8* @sailfin_runtime_string_concat(i8* %t550, i8* %s551)
  store i8* %t552, i8** %l18
  %t553 = load %NativeInstruction*, %NativeInstruction** %l8
  %t554 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t553, i32 0, i32 0
  %t555 = load i32, i32* %t554
  %t556 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t553, i32 0, i32 1
  %t557 = bitcast [48 x i8]* %t556 to i8*
  %t558 = getelementptr inbounds i8, i8* %t557, i64 24
  %t559 = bitcast i8* %t558 to i8**
  %t560 = load i8*, i8** %t559
  %t561 = icmp eq i32 %t555, 2
  %t562 = select i1 %t561, i8* %t560, i8* null
  %t563 = icmp ne i8* %t562, null
  %t564 = load %PythonBuilder, %PythonBuilder* %l0
  %t565 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t566 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t567 = load i8*, i8** %l3
  %t568 = load double, double* %l4
  %t569 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t570 = load double, double* %l6
  %t571 = load double, double* %l7
  %t572 = load %NativeInstruction*, %NativeInstruction** %l8
  %t573 = load i8*, i8** %l17
  %t574 = load i8*, i8** %l18
  br i1 %t563, label %then32, label %else33
then32:
  %t575 = load %NativeInstruction*, %NativeInstruction** %l8
  %t576 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t575, i32 0, i32 0
  %t577 = load i32, i32* %t576
  %t578 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t575, i32 0, i32 1
  %t579 = bitcast [48 x i8]* %t578 to i8*
  %t580 = getelementptr inbounds i8, i8* %t579, i64 24
  %t581 = bitcast i8* %t580 to i8**
  %t582 = load i8*, i8** %t581
  %t583 = icmp eq i32 %t577, 2
  %t584 = select i1 %t583, i8* %t582, i8* null
  store i8* %t584, i8** %l19
  %t585 = load i8*, i8** %l19
  %t586 = extractvalue %NativeFunction %function, 4
  %t587 = load double, double* %l7
  %t588 = sitofp i64 1 to double
  %t589 = fadd double %t587, %t588
  %t590 = bitcast { %NativeInstruction**, i64 }* %t586 to { %NativeInstruction*, i64 }*
  %t591 = call %StructLiteralCapture @capture_struct_literal_expression(i8* %t585, { %NativeInstruction*, i64 }* %t590, double %t589)
  store %StructLiteralCapture %t591, %StructLiteralCapture* %l20
  %t592 = sitofp i64 0 to double
  store double %t592, double* %l21
  %t593 = load %StructLiteralCapture, %StructLiteralCapture* %l20
  %t594 = extractvalue %StructLiteralCapture %t593, 2
  %t595 = load %PythonBuilder, %PythonBuilder* %l0
  %t596 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t597 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t598 = load i8*, i8** %l3
  %t599 = load double, double* %l4
  %t600 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t601 = load double, double* %l6
  %t602 = load double, double* %l7
  %t603 = load %NativeInstruction*, %NativeInstruction** %l8
  %t604 = load i8*, i8** %l17
  %t605 = load i8*, i8** %l18
  %t606 = load i8*, i8** %l19
  %t607 = load %StructLiteralCapture, %StructLiteralCapture* %l20
  %t608 = load double, double* %l21
  br i1 %t594, label %then35, label %else36
then35:
  %t609 = load %StructLiteralCapture, %StructLiteralCapture* %l20
  %t610 = extractvalue %StructLiteralCapture %t609, 0
  store i8* %t610, i8** %l19
  %t611 = load %StructLiteralCapture, %StructLiteralCapture* %l20
  %t612 = extractvalue %StructLiteralCapture %t611, 1
  store double %t612, double* %l21
  %t613 = load i8*, i8** %l19
  %t614 = load double, double* %l21
  br label %merge37
else36:
  %t615 = load i8*, i8** %l19
  %t616 = extractvalue %NativeFunction %function, 4
  %t617 = load double, double* %l7
  %t618 = sitofp i64 1 to double
  %t619 = fadd double %t617, %t618
  %t620 = bitcast { %NativeInstruction**, i64 }* %t616 to { %NativeInstruction*, i64 }*
  %t621 = call %ExpressionContinuationCapture @capture_expression_continuation(i8* %t615, { %NativeInstruction*, i64 }* %t620, double %t619)
  store %ExpressionContinuationCapture %t621, %ExpressionContinuationCapture* %l22
  %t622 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l22
  %t623 = extractvalue %ExpressionContinuationCapture %t622, 2
  %t624 = load %PythonBuilder, %PythonBuilder* %l0
  %t625 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t626 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t627 = load i8*, i8** %l3
  %t628 = load double, double* %l4
  %t629 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t630 = load double, double* %l6
  %t631 = load double, double* %l7
  %t632 = load %NativeInstruction*, %NativeInstruction** %l8
  %t633 = load i8*, i8** %l17
  %t634 = load i8*, i8** %l18
  %t635 = load i8*, i8** %l19
  %t636 = load %StructLiteralCapture, %StructLiteralCapture* %l20
  %t637 = load double, double* %l21
  %t638 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l22
  br i1 %t623, label %then38, label %merge39
then38:
  %t639 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l22
  %t640 = extractvalue %ExpressionContinuationCapture %t639, 0
  store i8* %t640, i8** %l19
  %t641 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l22
  %t642 = extractvalue %ExpressionContinuationCapture %t641, 1
  store double %t642, double* %l21
  %t643 = load i8*, i8** %l19
  %t644 = load double, double* %l21
  br label %merge39
merge39:
  %t645 = phi i8* [ %t643, %then38 ], [ %t635, %else36 ]
  %t646 = phi double [ %t644, %then38 ], [ %t637, %else36 ]
  store i8* %t645, i8** %l19
  store double %t646, double* %l21
  %t647 = load i8*, i8** %l19
  %t648 = load double, double* %l21
  br label %merge37
merge37:
  %t649 = phi i8* [ %t613, %then35 ], [ %t647, %merge39 ]
  %t650 = phi double [ %t614, %then35 ], [ %t648, %merge39 ]
  store i8* %t649, i8** %l19
  store double %t650, double* %l21
  %t651 = load i8*, i8** %l18
  %t652 = load i8*, i8** %l19
  %t653 = call i8* @lower_expression(i8* %t652)
  %t654 = call i8* @sailfin_runtime_string_concat(i8* %t651, i8* %t653)
  store i8* %t654, i8** %l18
  %t655 = load double, double* %l7
  %t656 = load double, double* %l21
  %t657 = fadd double %t655, %t656
  store double %t657, double* %l7
  %t658 = load i8*, i8** %l18
  %t659 = load double, double* %l7
  br label %merge34
else33:
  %t660 = load i8*, i8** %l18
  %s661 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h230766299, i32 0, i32 0
  %t662 = call i8* @sailfin_runtime_string_concat(i8* %t660, i8* %s661)
  store i8* %t662, i8** %l18
  %t663 = load i8*, i8** %l18
  br label %merge34
merge34:
  %t664 = phi i8* [ %t658, %merge37 ], [ %t663, %else33 ]
  %t665 = phi double [ %t659, %merge37 ], [ %t571, %else33 ]
  store i8* %t664, i8** %l18
  store double %t665, double* %l7
  %t666 = load %PythonBuilder, %PythonBuilder* %l0
  %t667 = load i8*, i8** %l18
  %t668 = call %PythonBuilder @builder_emit(%PythonBuilder %t666, i8* %t667)
  store %PythonBuilder %t668, %PythonBuilder* %l0
  %t669 = load double, double* %l7
  %t670 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge31
else30:
  %t671 = load %NativeInstruction*, %NativeInstruction** %l8
  %t672 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t671, i32 0, i32 0
  %t673 = load i32, i32* %t672
  %t674 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t675 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t676 = icmp eq i32 %t673, 0
  %t677 = select i1 %t676, i8* %t675, i8* %t674
  %t678 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t679 = icmp eq i32 %t673, 1
  %t680 = select i1 %t679, i8* %t678, i8* %t677
  %t681 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t682 = icmp eq i32 %t673, 2
  %t683 = select i1 %t682, i8* %t681, i8* %t680
  %t684 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t685 = icmp eq i32 %t673, 3
  %t686 = select i1 %t685, i8* %t684, i8* %t683
  %t687 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t688 = icmp eq i32 %t673, 4
  %t689 = select i1 %t688, i8* %t687, i8* %t686
  %t690 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t691 = icmp eq i32 %t673, 5
  %t692 = select i1 %t691, i8* %t690, i8* %t689
  %t693 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t694 = icmp eq i32 %t673, 6
  %t695 = select i1 %t694, i8* %t693, i8* %t692
  %t696 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t697 = icmp eq i32 %t673, 7
  %t698 = select i1 %t697, i8* %t696, i8* %t695
  %t699 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t700 = icmp eq i32 %t673, 8
  %t701 = select i1 %t700, i8* %t699, i8* %t698
  %t702 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t703 = icmp eq i32 %t673, 9
  %t704 = select i1 %t703, i8* %t702, i8* %t701
  %t705 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t706 = icmp eq i32 %t673, 10
  %t707 = select i1 %t706, i8* %t705, i8* %t704
  %t708 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t709 = icmp eq i32 %t673, 11
  %t710 = select i1 %t709, i8* %t708, i8* %t707
  %t711 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t712 = icmp eq i32 %t673, 12
  %t713 = select i1 %t712, i8* %t711, i8* %t710
  %t714 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t715 = icmp eq i32 %t673, 13
  %t716 = select i1 %t715, i8* %t714, i8* %t713
  %t717 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t718 = icmp eq i32 %t673, 14
  %t719 = select i1 %t718, i8* %t717, i8* %t716
  %t720 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t721 = icmp eq i32 %t673, 15
  %t722 = select i1 %t721, i8* %t720, i8* %t719
  %t723 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t724 = icmp eq i32 %t673, 16
  %t725 = select i1 %t724, i8* %t723, i8* %t722
  %s726 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193459862, i32 0, i32 0
  %t727 = icmp eq i8* %t725, %s726
  %t728 = load %PythonBuilder, %PythonBuilder* %l0
  %t729 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t730 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t731 = load i8*, i8** %l3
  %t732 = load double, double* %l4
  %t733 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t734 = load double, double* %l6
  %t735 = load double, double* %l7
  %t736 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t727, label %then40, label %else41
then40:
  %t737 = load %NativeInstruction*, %NativeInstruction** %l8
  %t738 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t737, i32 0, i32 0
  %t739 = load i32, i32* %t738
  %t740 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t737, i32 0, i32 1
  %t741 = bitcast [8 x i8]* %t740 to i8*
  %t742 = bitcast i8* %t741 to i8**
  %t743 = load i8*, i8** %t742
  %t744 = icmp eq i32 %t739, 3
  %t745 = select i1 %t744, i8* %t743, i8* null
  %t746 = call i8* @trim_text(i8* %t745)
  %t747 = call i8* @rewrite_expression_intrinsics(i8* %t746)
  store i8* %t747, i8** %l23
  %t748 = load %PythonBuilder, %PythonBuilder* %l0
  %s749 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2090359129, i32 0, i32 0
  %t750 = load i8*, i8** %l23
  %t751 = call i8* @sailfin_runtime_string_concat(i8* %s749, i8* %t750)
  %t752 = alloca [2 x i8], align 1
  %t753 = getelementptr [2 x i8], [2 x i8]* %t752, i32 0, i32 0
  store i8 58, i8* %t753
  %t754 = getelementptr [2 x i8], [2 x i8]* %t752, i32 0, i32 1
  store i8 0, i8* %t754
  %t755 = getelementptr [2 x i8], [2 x i8]* %t752, i32 0, i32 0
  %t756 = call i8* @sailfin_runtime_string_concat(i8* %t751, i8* %t755)
  %t757 = call %PythonBuilder @builder_emit(%PythonBuilder %t748, i8* %t756)
  store %PythonBuilder %t757, %PythonBuilder* %l0
  %t758 = load %PythonBuilder, %PythonBuilder* %l0
  %t759 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t758)
  store %PythonBuilder %t759, %PythonBuilder* %l0
  %t760 = load double, double* %l4
  %t761 = sitofp i64 1 to double
  %t762 = fadd double %t760, %t761
  store double %t762, double* %l4
  %t763 = load %PythonBuilder, %PythonBuilder* %l0
  %t764 = load %PythonBuilder, %PythonBuilder* %l0
  %t765 = load double, double* %l4
  br label %merge42
else41:
  %t766 = load %NativeInstruction*, %NativeInstruction** %l8
  %t767 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t766, i32 0, i32 0
  %t768 = load i32, i32* %t767
  %t769 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t770 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t771 = icmp eq i32 %t768, 0
  %t772 = select i1 %t771, i8* %t770, i8* %t769
  %t773 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t774 = icmp eq i32 %t768, 1
  %t775 = select i1 %t774, i8* %t773, i8* %t772
  %t776 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t777 = icmp eq i32 %t768, 2
  %t778 = select i1 %t777, i8* %t776, i8* %t775
  %t779 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t780 = icmp eq i32 %t768, 3
  %t781 = select i1 %t780, i8* %t779, i8* %t778
  %t782 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t783 = icmp eq i32 %t768, 4
  %t784 = select i1 %t783, i8* %t782, i8* %t781
  %t785 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t786 = icmp eq i32 %t768, 5
  %t787 = select i1 %t786, i8* %t785, i8* %t784
  %t788 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t789 = icmp eq i32 %t768, 6
  %t790 = select i1 %t789, i8* %t788, i8* %t787
  %t791 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t792 = icmp eq i32 %t768, 7
  %t793 = select i1 %t792, i8* %t791, i8* %t790
  %t794 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t795 = icmp eq i32 %t768, 8
  %t796 = select i1 %t795, i8* %t794, i8* %t793
  %t797 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t798 = icmp eq i32 %t768, 9
  %t799 = select i1 %t798, i8* %t797, i8* %t796
  %t800 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t801 = icmp eq i32 %t768, 10
  %t802 = select i1 %t801, i8* %t800, i8* %t799
  %t803 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t804 = icmp eq i32 %t768, 11
  %t805 = select i1 %t804, i8* %t803, i8* %t802
  %t806 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t807 = icmp eq i32 %t768, 12
  %t808 = select i1 %t807, i8* %t806, i8* %t805
  %t809 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t810 = icmp eq i32 %t768, 13
  %t811 = select i1 %t810, i8* %t809, i8* %t808
  %t812 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t813 = icmp eq i32 %t768, 14
  %t814 = select i1 %t813, i8* %t812, i8* %t811
  %t815 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t816 = icmp eq i32 %t768, 15
  %t817 = select i1 %t816, i8* %t815, i8* %t814
  %t818 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t819 = icmp eq i32 %t768, 16
  %t820 = select i1 %t819, i8* %t818, i8* %t817
  %s821 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h219990644, i32 0, i32 0
  %t822 = icmp eq i8* %t820, %s821
  %t823 = load %PythonBuilder, %PythonBuilder* %l0
  %t824 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t825 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t826 = load i8*, i8** %l3
  %t827 = load double, double* %l4
  %t828 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t829 = load double, double* %l6
  %t830 = load double, double* %l7
  %t831 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t822, label %then43, label %else44
then43:
  %t832 = load double, double* %l4
  %t833 = sitofp i64 0 to double
  %t834 = fcmp ogt double %t832, %t833
  %t835 = load %PythonBuilder, %PythonBuilder* %l0
  %t836 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t837 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t838 = load i8*, i8** %l3
  %t839 = load double, double* %l4
  %t840 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t841 = load double, double* %l6
  %t842 = load double, double* %l7
  %t843 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t834, label %then46, label %else47
then46:
  %t844 = load %PythonBuilder, %PythonBuilder* %l0
  %t845 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t844)
  store %PythonBuilder %t845, %PythonBuilder* %l0
  %t846 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge48
else47:
  %t847 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t848 = extractvalue %NativeFunction %function, 0
  %s849 = getelementptr inbounds [25 x i8], [25 x i8]* @.str.len24.h2028465620, i32 0, i32 0
  %t850 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t847, i8* %t848, i8* %s849)
  store { i8**, i64 }* %t850, { i8**, i64 }** %l1
  %t851 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge48
merge48:
  %t852 = phi %PythonBuilder [ %t846, %then46 ], [ %t835, %else47 ]
  %t853 = phi { i8**, i64 }* [ %t836, %then46 ], [ %t851, %else47 ]
  store %PythonBuilder %t852, %PythonBuilder* %l0
  store { i8**, i64 }* %t853, { i8**, i64 }** %l1
  %t854 = load %PythonBuilder, %PythonBuilder* %l0
  %s855 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2069574674, i32 0, i32 0
  %t856 = call %PythonBuilder @builder_emit(%PythonBuilder %t854, i8* %s855)
  store %PythonBuilder %t856, %PythonBuilder* %l0
  %t857 = load %PythonBuilder, %PythonBuilder* %l0
  %t858 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t857)
  store %PythonBuilder %t858, %PythonBuilder* %l0
  %t859 = load %PythonBuilder, %PythonBuilder* %l0
  %t860 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t861 = load %PythonBuilder, %PythonBuilder* %l0
  %t862 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge45
else44:
  %t863 = load %NativeInstruction*, %NativeInstruction** %l8
  %t864 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t863, i32 0, i32 0
  %t865 = load i32, i32* %t864
  %t866 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t867 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t868 = icmp eq i32 %t865, 0
  %t869 = select i1 %t868, i8* %t867, i8* %t866
  %t870 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t871 = icmp eq i32 %t865, 1
  %t872 = select i1 %t871, i8* %t870, i8* %t869
  %t873 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t874 = icmp eq i32 %t865, 2
  %t875 = select i1 %t874, i8* %t873, i8* %t872
  %t876 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t877 = icmp eq i32 %t865, 3
  %t878 = select i1 %t877, i8* %t876, i8* %t875
  %t879 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t880 = icmp eq i32 %t865, 4
  %t881 = select i1 %t880, i8* %t879, i8* %t878
  %t882 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t883 = icmp eq i32 %t865, 5
  %t884 = select i1 %t883, i8* %t882, i8* %t881
  %t885 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t886 = icmp eq i32 %t865, 6
  %t887 = select i1 %t886, i8* %t885, i8* %t884
  %t888 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t889 = icmp eq i32 %t865, 7
  %t890 = select i1 %t889, i8* %t888, i8* %t887
  %t891 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t892 = icmp eq i32 %t865, 8
  %t893 = select i1 %t892, i8* %t891, i8* %t890
  %t894 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t895 = icmp eq i32 %t865, 9
  %t896 = select i1 %t895, i8* %t894, i8* %t893
  %t897 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t898 = icmp eq i32 %t865, 10
  %t899 = select i1 %t898, i8* %t897, i8* %t896
  %t900 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t901 = icmp eq i32 %t865, 11
  %t902 = select i1 %t901, i8* %t900, i8* %t899
  %t903 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t904 = icmp eq i32 %t865, 12
  %t905 = select i1 %t904, i8* %t903, i8* %t902
  %t906 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t907 = icmp eq i32 %t865, 13
  %t908 = select i1 %t907, i8* %t906, i8* %t905
  %t909 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t910 = icmp eq i32 %t865, 14
  %t911 = select i1 %t910, i8* %t909, i8* %t908
  %t912 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t913 = icmp eq i32 %t865, 15
  %t914 = select i1 %t913, i8* %t912, i8* %t911
  %t915 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t916 = icmp eq i32 %t865, 16
  %t917 = select i1 %t916, i8* %t915, i8* %t914
  %s918 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h819045845, i32 0, i32 0
  %t919 = icmp eq i8* %t917, %s918
  %t920 = load %PythonBuilder, %PythonBuilder* %l0
  %t921 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t922 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t923 = load i8*, i8** %l3
  %t924 = load double, double* %l4
  %t925 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t926 = load double, double* %l6
  %t927 = load double, double* %l7
  %t928 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t919, label %then49, label %else50
then49:
  %t929 = load double, double* %l4
  %t930 = sitofp i64 0 to double
  %t931 = fcmp ogt double %t929, %t930
  %t932 = load %PythonBuilder, %PythonBuilder* %l0
  %t933 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t934 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t935 = load i8*, i8** %l3
  %t936 = load double, double* %l4
  %t937 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t938 = load double, double* %l6
  %t939 = load double, double* %l7
  %t940 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t931, label %then52, label %else53
then52:
  %t941 = load %PythonBuilder, %PythonBuilder* %l0
  %t942 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t941)
  store %PythonBuilder %t942, %PythonBuilder* %l0
  %t943 = load double, double* %l4
  %t944 = sitofp i64 1 to double
  %t945 = fsub double %t943, %t944
  store double %t945, double* %l4
  %t946 = load %PythonBuilder, %PythonBuilder* %l0
  %t947 = load double, double* %l4
  br label %merge54
else53:
  %t948 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t949 = extractvalue %NativeFunction %function, 0
  %s950 = getelementptr inbounds [26 x i8], [26 x i8]* @.str.len25.h458257002, i32 0, i32 0
  %t951 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t948, i8* %t949, i8* %s950)
  store { i8**, i64 }* %t951, { i8**, i64 }** %l1
  %t952 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge54
merge54:
  %t953 = phi %PythonBuilder [ %t946, %then52 ], [ %t932, %else53 ]
  %t954 = phi double [ %t947, %then52 ], [ %t936, %else53 ]
  %t955 = phi { i8**, i64 }* [ %t933, %then52 ], [ %t952, %else53 ]
  store %PythonBuilder %t953, %PythonBuilder* %l0
  store double %t954, double* %l4
  store { i8**, i64 }* %t955, { i8**, i64 }** %l1
  %t956 = load %PythonBuilder, %PythonBuilder* %l0
  %t957 = load double, double* %l4
  %t958 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge51
else50:
  %t959 = load %NativeInstruction*, %NativeInstruction** %l8
  %t960 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t959, i32 0, i32 0
  %t961 = load i32, i32* %t960
  %t962 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t963 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t964 = icmp eq i32 %t961, 0
  %t965 = select i1 %t964, i8* %t963, i8* %t962
  %t966 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t967 = icmp eq i32 %t961, 1
  %t968 = select i1 %t967, i8* %t966, i8* %t965
  %t969 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t970 = icmp eq i32 %t961, 2
  %t971 = select i1 %t970, i8* %t969, i8* %t968
  %t972 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t973 = icmp eq i32 %t961, 3
  %t974 = select i1 %t973, i8* %t972, i8* %t971
  %t975 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t976 = icmp eq i32 %t961, 4
  %t977 = select i1 %t976, i8* %t975, i8* %t974
  %t978 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t979 = icmp eq i32 %t961, 5
  %t980 = select i1 %t979, i8* %t978, i8* %t977
  %t981 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t982 = icmp eq i32 %t961, 6
  %t983 = select i1 %t982, i8* %t981, i8* %t980
  %t984 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t985 = icmp eq i32 %t961, 7
  %t986 = select i1 %t985, i8* %t984, i8* %t983
  %t987 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t988 = icmp eq i32 %t961, 8
  %t989 = select i1 %t988, i8* %t987, i8* %t986
  %t990 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t991 = icmp eq i32 %t961, 9
  %t992 = select i1 %t991, i8* %t990, i8* %t989
  %t993 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t994 = icmp eq i32 %t961, 10
  %t995 = select i1 %t994, i8* %t993, i8* %t992
  %t996 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t997 = icmp eq i32 %t961, 11
  %t998 = select i1 %t997, i8* %t996, i8* %t995
  %t999 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1000 = icmp eq i32 %t961, 12
  %t1001 = select i1 %t1000, i8* %t999, i8* %t998
  %t1002 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1003 = icmp eq i32 %t961, 13
  %t1004 = select i1 %t1003, i8* %t1002, i8* %t1001
  %t1005 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1006 = icmp eq i32 %t961, 14
  %t1007 = select i1 %t1006, i8* %t1005, i8* %t1004
  %t1008 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1009 = icmp eq i32 %t961, 15
  %t1010 = select i1 %t1009, i8* %t1008, i8* %t1007
  %t1011 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1012 = icmp eq i32 %t961, 16
  %t1013 = select i1 %t1012, i8* %t1011, i8* %t1010
  %s1014 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2089113841, i32 0, i32 0
  %t1015 = icmp eq i8* %t1013, %s1014
  %t1016 = load %PythonBuilder, %PythonBuilder* %l0
  %t1017 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1018 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1019 = load i8*, i8** %l3
  %t1020 = load double, double* %l4
  %t1021 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1022 = load double, double* %l6
  %t1023 = load double, double* %l7
  %t1024 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1015, label %then55, label %else56
then55:
  %t1025 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1026 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1025, i32 0, i32 0
  %t1027 = load i32, i32* %t1026
  %t1028 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1025, i32 0, i32 1
  %t1029 = bitcast [16 x i8]* %t1028 to i8*
  %t1030 = getelementptr inbounds i8, i8* %t1029, i64 8
  %t1031 = bitcast i8* %t1030 to i8**
  %t1032 = load i8*, i8** %t1031
  %t1033 = icmp eq i32 %t1027, 6
  %t1034 = select i1 %t1033, i8* %t1032, i8* null
  %t1035 = call i8* @trim_text(i8* %t1034)
  %t1036 = call i8* @rewrite_expression_intrinsics(i8* %t1035)
  store i8* %t1036, i8** %l24
  %t1037 = load %PythonBuilder, %PythonBuilder* %l0
  %s1038 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h259230482, i32 0, i32 0
  %t1039 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1040 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1039, i32 0, i32 0
  %t1041 = load i32, i32* %t1040
  %t1042 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1039, i32 0, i32 1
  %t1043 = bitcast [16 x i8]* %t1042 to i8*
  %t1044 = bitcast i8* %t1043 to i8**
  %t1045 = load i8*, i8** %t1044
  %t1046 = icmp eq i32 %t1041, 6
  %t1047 = select i1 %t1046, i8* %t1045, i8* null
  %t1048 = call i8* @sailfin_runtime_string_concat(i8* %s1038, i8* %t1047)
  %s1049 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h175996034, i32 0, i32 0
  %t1050 = call i8* @sailfin_runtime_string_concat(i8* %t1048, i8* %s1049)
  %t1051 = load i8*, i8** %l24
  %t1052 = call i8* @sailfin_runtime_string_concat(i8* %t1050, i8* %t1051)
  %t1053 = alloca [2 x i8], align 1
  %t1054 = getelementptr [2 x i8], [2 x i8]* %t1053, i32 0, i32 0
  store i8 58, i8* %t1054
  %t1055 = getelementptr [2 x i8], [2 x i8]* %t1053, i32 0, i32 1
  store i8 0, i8* %t1055
  %t1056 = getelementptr [2 x i8], [2 x i8]* %t1053, i32 0, i32 0
  %t1057 = call i8* @sailfin_runtime_string_concat(i8* %t1052, i8* %t1056)
  %t1058 = call %PythonBuilder @builder_emit(%PythonBuilder %t1037, i8* %t1057)
  store %PythonBuilder %t1058, %PythonBuilder* %l0
  %t1059 = load %PythonBuilder, %PythonBuilder* %l0
  %t1060 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t1059)
  store %PythonBuilder %t1060, %PythonBuilder* %l0
  %t1061 = load double, double* %l4
  %t1062 = sitofp i64 1 to double
  %t1063 = fadd double %t1061, %t1062
  store double %t1063, double* %l4
  %t1064 = load %PythonBuilder, %PythonBuilder* %l0
  %t1065 = load %PythonBuilder, %PythonBuilder* %l0
  %t1066 = load double, double* %l4
  br label %merge57
else56:
  %t1067 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1068 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1067, i32 0, i32 0
  %t1069 = load i32, i32* %t1068
  %t1070 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1071 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1072 = icmp eq i32 %t1069, 0
  %t1073 = select i1 %t1072, i8* %t1071, i8* %t1070
  %t1074 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1075 = icmp eq i32 %t1069, 1
  %t1076 = select i1 %t1075, i8* %t1074, i8* %t1073
  %t1077 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1078 = icmp eq i32 %t1069, 2
  %t1079 = select i1 %t1078, i8* %t1077, i8* %t1076
  %t1080 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1081 = icmp eq i32 %t1069, 3
  %t1082 = select i1 %t1081, i8* %t1080, i8* %t1079
  %t1083 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1084 = icmp eq i32 %t1069, 4
  %t1085 = select i1 %t1084, i8* %t1083, i8* %t1082
  %t1086 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1087 = icmp eq i32 %t1069, 5
  %t1088 = select i1 %t1087, i8* %t1086, i8* %t1085
  %t1089 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1090 = icmp eq i32 %t1069, 6
  %t1091 = select i1 %t1090, i8* %t1089, i8* %t1088
  %t1092 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1093 = icmp eq i32 %t1069, 7
  %t1094 = select i1 %t1093, i8* %t1092, i8* %t1091
  %t1095 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1096 = icmp eq i32 %t1069, 8
  %t1097 = select i1 %t1096, i8* %t1095, i8* %t1094
  %t1098 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1099 = icmp eq i32 %t1069, 9
  %t1100 = select i1 %t1099, i8* %t1098, i8* %t1097
  %t1101 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1102 = icmp eq i32 %t1069, 10
  %t1103 = select i1 %t1102, i8* %t1101, i8* %t1100
  %t1104 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1105 = icmp eq i32 %t1069, 11
  %t1106 = select i1 %t1105, i8* %t1104, i8* %t1103
  %t1107 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1108 = icmp eq i32 %t1069, 12
  %t1109 = select i1 %t1108, i8* %t1107, i8* %t1106
  %t1110 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1111 = icmp eq i32 %t1069, 13
  %t1112 = select i1 %t1111, i8* %t1110, i8* %t1109
  %t1113 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1114 = icmp eq i32 %t1069, 14
  %t1115 = select i1 %t1114, i8* %t1113, i8* %t1112
  %t1116 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1117 = icmp eq i32 %t1069, 15
  %t1118 = select i1 %t1117, i8* %t1116, i8* %t1115
  %t1119 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1120 = icmp eq i32 %t1069, 16
  %t1121 = select i1 %t1120, i8* %t1119, i8* %t1118
  %s1122 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1258614714, i32 0, i32 0
  %t1123 = icmp eq i8* %t1121, %s1122
  %t1124 = load %PythonBuilder, %PythonBuilder* %l0
  %t1125 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1126 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1127 = load i8*, i8** %l3
  %t1128 = load double, double* %l4
  %t1129 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1130 = load double, double* %l6
  %t1131 = load double, double* %l7
  %t1132 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1123, label %then58, label %else59
then58:
  %t1133 = load double, double* %l4
  %t1134 = sitofp i64 0 to double
  %t1135 = fcmp ogt double %t1133, %t1134
  %t1136 = load %PythonBuilder, %PythonBuilder* %l0
  %t1137 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1138 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1139 = load i8*, i8** %l3
  %t1140 = load double, double* %l4
  %t1141 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1142 = load double, double* %l6
  %t1143 = load double, double* %l7
  %t1144 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1135, label %then61, label %else62
then61:
  %t1145 = load %PythonBuilder, %PythonBuilder* %l0
  %t1146 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t1145)
  store %PythonBuilder %t1146, %PythonBuilder* %l0
  %t1147 = load double, double* %l4
  %t1148 = sitofp i64 1 to double
  %t1149 = fsub double %t1147, %t1148
  store double %t1149, double* %l4
  %t1150 = load %PythonBuilder, %PythonBuilder* %l0
  %t1151 = load double, double* %l4
  br label %merge63
else62:
  %t1152 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1153 = extractvalue %NativeFunction %function, 0
  %s1154 = getelementptr inbounds [33 x i8], [33 x i8]* @.str.len32.h1370567591, i32 0, i32 0
  %t1155 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t1152, i8* %t1153, i8* %s1154)
  store { i8**, i64 }* %t1155, { i8**, i64 }** %l1
  %t1156 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge63
merge63:
  %t1157 = phi %PythonBuilder [ %t1150, %then61 ], [ %t1136, %else62 ]
  %t1158 = phi double [ %t1151, %then61 ], [ %t1140, %else62 ]
  %t1159 = phi { i8**, i64 }* [ %t1137, %then61 ], [ %t1156, %else62 ]
  store %PythonBuilder %t1157, %PythonBuilder* %l0
  store double %t1158, double* %l4
  store { i8**, i64 }* %t1159, { i8**, i64 }** %l1
  %t1160 = load %PythonBuilder, %PythonBuilder* %l0
  %t1161 = load double, double* %l4
  %t1162 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge60
else59:
  %t1163 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1164 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1163, i32 0, i32 0
  %t1165 = load i32, i32* %t1164
  %t1166 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1167 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1168 = icmp eq i32 %t1165, 0
  %t1169 = select i1 %t1168, i8* %t1167, i8* %t1166
  %t1170 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1171 = icmp eq i32 %t1165, 1
  %t1172 = select i1 %t1171, i8* %t1170, i8* %t1169
  %t1173 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1174 = icmp eq i32 %t1165, 2
  %t1175 = select i1 %t1174, i8* %t1173, i8* %t1172
  %t1176 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1177 = icmp eq i32 %t1165, 3
  %t1178 = select i1 %t1177, i8* %t1176, i8* %t1175
  %t1179 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1180 = icmp eq i32 %t1165, 4
  %t1181 = select i1 %t1180, i8* %t1179, i8* %t1178
  %t1182 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1183 = icmp eq i32 %t1165, 5
  %t1184 = select i1 %t1183, i8* %t1182, i8* %t1181
  %t1185 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1186 = icmp eq i32 %t1165, 6
  %t1187 = select i1 %t1186, i8* %t1185, i8* %t1184
  %t1188 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1189 = icmp eq i32 %t1165, 7
  %t1190 = select i1 %t1189, i8* %t1188, i8* %t1187
  %t1191 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1192 = icmp eq i32 %t1165, 8
  %t1193 = select i1 %t1192, i8* %t1191, i8* %t1190
  %t1194 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1195 = icmp eq i32 %t1165, 9
  %t1196 = select i1 %t1195, i8* %t1194, i8* %t1193
  %t1197 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1198 = icmp eq i32 %t1165, 10
  %t1199 = select i1 %t1198, i8* %t1197, i8* %t1196
  %t1200 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1201 = icmp eq i32 %t1165, 11
  %t1202 = select i1 %t1201, i8* %t1200, i8* %t1199
  %t1203 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1204 = icmp eq i32 %t1165, 12
  %t1205 = select i1 %t1204, i8* %t1203, i8* %t1202
  %t1206 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1207 = icmp eq i32 %t1165, 13
  %t1208 = select i1 %t1207, i8* %t1206, i8* %t1205
  %t1209 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1210 = icmp eq i32 %t1165, 14
  %t1211 = select i1 %t1210, i8* %t1209, i8* %t1208
  %t1212 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1213 = icmp eq i32 %t1165, 15
  %t1214 = select i1 %t1213, i8* %t1212, i8* %t1211
  %t1215 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1216 = icmp eq i32 %t1165, 16
  %t1217 = select i1 %t1216, i8* %t1215, i8* %t1214
  %s1218 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h228395909, i32 0, i32 0
  %t1219 = icmp eq i8* %t1217, %s1218
  %t1220 = load %PythonBuilder, %PythonBuilder* %l0
  %t1221 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1222 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1223 = load i8*, i8** %l3
  %t1224 = load double, double* %l4
  %t1225 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1226 = load double, double* %l6
  %t1227 = load double, double* %l7
  %t1228 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1219, label %then64, label %else65
then64:
  %t1229 = load %PythonBuilder, %PythonBuilder* %l0
  %s1230 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1898426375, i32 0, i32 0
  %t1231 = call %PythonBuilder @builder_emit(%PythonBuilder %t1229, i8* %s1230)
  store %PythonBuilder %t1231, %PythonBuilder* %l0
  %t1232 = load %PythonBuilder, %PythonBuilder* %l0
  %t1233 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t1232)
  store %PythonBuilder %t1233, %PythonBuilder* %l0
  %t1234 = load double, double* %l4
  %t1235 = sitofp i64 1 to double
  %t1236 = fadd double %t1234, %t1235
  store double %t1236, double* %l4
  %t1237 = load %PythonBuilder, %PythonBuilder* %l0
  %t1238 = load %PythonBuilder, %PythonBuilder* %l0
  %t1239 = load double, double* %l4
  br label %merge66
else65:
  %t1240 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1241 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1240, i32 0, i32 0
  %t1242 = load i32, i32* %t1241
  %t1243 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1244 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1245 = icmp eq i32 %t1242, 0
  %t1246 = select i1 %t1245, i8* %t1244, i8* %t1243
  %t1247 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1248 = icmp eq i32 %t1242, 1
  %t1249 = select i1 %t1248, i8* %t1247, i8* %t1246
  %t1250 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1251 = icmp eq i32 %t1242, 2
  %t1252 = select i1 %t1251, i8* %t1250, i8* %t1249
  %t1253 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1254 = icmp eq i32 %t1242, 3
  %t1255 = select i1 %t1254, i8* %t1253, i8* %t1252
  %t1256 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1257 = icmp eq i32 %t1242, 4
  %t1258 = select i1 %t1257, i8* %t1256, i8* %t1255
  %t1259 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1260 = icmp eq i32 %t1242, 5
  %t1261 = select i1 %t1260, i8* %t1259, i8* %t1258
  %t1262 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1263 = icmp eq i32 %t1242, 6
  %t1264 = select i1 %t1263, i8* %t1262, i8* %t1261
  %t1265 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1266 = icmp eq i32 %t1242, 7
  %t1267 = select i1 %t1266, i8* %t1265, i8* %t1264
  %t1268 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1269 = icmp eq i32 %t1242, 8
  %t1270 = select i1 %t1269, i8* %t1268, i8* %t1267
  %t1271 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1272 = icmp eq i32 %t1242, 9
  %t1273 = select i1 %t1272, i8* %t1271, i8* %t1270
  %t1274 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1275 = icmp eq i32 %t1242, 10
  %t1276 = select i1 %t1275, i8* %t1274, i8* %t1273
  %t1277 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1278 = icmp eq i32 %t1242, 11
  %t1279 = select i1 %t1278, i8* %t1277, i8* %t1276
  %t1280 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1281 = icmp eq i32 %t1242, 12
  %t1282 = select i1 %t1281, i8* %t1280, i8* %t1279
  %t1283 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1284 = icmp eq i32 %t1242, 13
  %t1285 = select i1 %t1284, i8* %t1283, i8* %t1282
  %t1286 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1287 = icmp eq i32 %t1242, 14
  %t1288 = select i1 %t1287, i8* %t1286, i8* %t1285
  %t1289 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1290 = icmp eq i32 %t1242, 15
  %t1291 = select i1 %t1290, i8* %t1289, i8* %t1288
  %t1292 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1293 = icmp eq i32 %t1242, 16
  %t1294 = select i1 %t1293, i8* %t1292, i8* %t1291
  %s1295 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h739212033, i32 0, i32 0
  %t1296 = icmp eq i8* %t1294, %s1295
  %t1297 = load %PythonBuilder, %PythonBuilder* %l0
  %t1298 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1299 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1300 = load i8*, i8** %l3
  %t1301 = load double, double* %l4
  %t1302 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1303 = load double, double* %l6
  %t1304 = load double, double* %l7
  %t1305 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1296, label %then67, label %else68
then67:
  %t1306 = load double, double* %l4
  %t1307 = sitofp i64 0 to double
  %t1308 = fcmp ogt double %t1306, %t1307
  %t1309 = load %PythonBuilder, %PythonBuilder* %l0
  %t1310 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1311 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1312 = load i8*, i8** %l3
  %t1313 = load double, double* %l4
  %t1314 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1315 = load double, double* %l6
  %t1316 = load double, double* %l7
  %t1317 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1308, label %then70, label %else71
then70:
  %t1318 = load %PythonBuilder, %PythonBuilder* %l0
  %t1319 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t1318)
  store %PythonBuilder %t1319, %PythonBuilder* %l0
  %t1320 = load double, double* %l4
  %t1321 = sitofp i64 1 to double
  %t1322 = fsub double %t1320, %t1321
  store double %t1322, double* %l4
  %t1323 = load %PythonBuilder, %PythonBuilder* %l0
  %t1324 = load double, double* %l4
  br label %merge72
else71:
  %t1325 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1326 = extractvalue %NativeFunction %function, 0
  %s1327 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.len29.h1122035900, i32 0, i32 0
  %t1328 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t1325, i8* %t1326, i8* %s1327)
  store { i8**, i64 }* %t1328, { i8**, i64 }** %l1
  %t1329 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge72
merge72:
  %t1330 = phi %PythonBuilder [ %t1323, %then70 ], [ %t1309, %else71 ]
  %t1331 = phi double [ %t1324, %then70 ], [ %t1313, %else71 ]
  %t1332 = phi { i8**, i64 }* [ %t1310, %then70 ], [ %t1329, %else71 ]
  store %PythonBuilder %t1330, %PythonBuilder* %l0
  store double %t1331, double* %l4
  store { i8**, i64 }* %t1332, { i8**, i64 }** %l1
  %t1333 = load %PythonBuilder, %PythonBuilder* %l0
  %t1334 = load double, double* %l4
  %t1335 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge69
else68:
  %t1336 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1337 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1336, i32 0, i32 0
  %t1338 = load i32, i32* %t1337
  %t1339 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1340 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1341 = icmp eq i32 %t1338, 0
  %t1342 = select i1 %t1341, i8* %t1340, i8* %t1339
  %t1343 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1344 = icmp eq i32 %t1338, 1
  %t1345 = select i1 %t1344, i8* %t1343, i8* %t1342
  %t1346 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1347 = icmp eq i32 %t1338, 2
  %t1348 = select i1 %t1347, i8* %t1346, i8* %t1345
  %t1349 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1350 = icmp eq i32 %t1338, 3
  %t1351 = select i1 %t1350, i8* %t1349, i8* %t1348
  %t1352 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1353 = icmp eq i32 %t1338, 4
  %t1354 = select i1 %t1353, i8* %t1352, i8* %t1351
  %t1355 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1356 = icmp eq i32 %t1338, 5
  %t1357 = select i1 %t1356, i8* %t1355, i8* %t1354
  %t1358 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1359 = icmp eq i32 %t1338, 6
  %t1360 = select i1 %t1359, i8* %t1358, i8* %t1357
  %t1361 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1362 = icmp eq i32 %t1338, 7
  %t1363 = select i1 %t1362, i8* %t1361, i8* %t1360
  %t1364 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1365 = icmp eq i32 %t1338, 8
  %t1366 = select i1 %t1365, i8* %t1364, i8* %t1363
  %t1367 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1368 = icmp eq i32 %t1338, 9
  %t1369 = select i1 %t1368, i8* %t1367, i8* %t1366
  %t1370 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1371 = icmp eq i32 %t1338, 10
  %t1372 = select i1 %t1371, i8* %t1370, i8* %t1369
  %t1373 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1374 = icmp eq i32 %t1338, 11
  %t1375 = select i1 %t1374, i8* %t1373, i8* %t1372
  %t1376 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1377 = icmp eq i32 %t1338, 12
  %t1378 = select i1 %t1377, i8* %t1376, i8* %t1375
  %t1379 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1380 = icmp eq i32 %t1338, 13
  %t1381 = select i1 %t1380, i8* %t1379, i8* %t1378
  %t1382 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1383 = icmp eq i32 %t1338, 14
  %t1384 = select i1 %t1383, i8* %t1382, i8* %t1381
  %t1385 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1386 = icmp eq i32 %t1338, 15
  %t1387 = select i1 %t1386, i8* %t1385, i8* %t1384
  %t1388 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1389 = icmp eq i32 %t1338, 16
  %t1390 = select i1 %t1389, i8* %t1388, i8* %t1387
  %s1391 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h706445588, i32 0, i32 0
  %t1392 = icmp eq i8* %t1390, %s1391
  %t1393 = load %PythonBuilder, %PythonBuilder* %l0
  %t1394 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1395 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1396 = load i8*, i8** %l3
  %t1397 = load double, double* %l4
  %t1398 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1399 = load double, double* %l6
  %t1400 = load double, double* %l7
  %t1401 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1392, label %then73, label %else74
then73:
  %t1402 = load %PythonBuilder, %PythonBuilder* %l0
  %s1403 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1958778164, i32 0, i32 0
  %t1404 = call %PythonBuilder @builder_emit(%PythonBuilder %t1402, i8* %s1403)
  store %PythonBuilder %t1404, %PythonBuilder* %l0
  %t1405 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge75
else74:
  %t1406 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1407 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1406, i32 0, i32 0
  %t1408 = load i32, i32* %t1407
  %t1409 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1410 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1411 = icmp eq i32 %t1408, 0
  %t1412 = select i1 %t1411, i8* %t1410, i8* %t1409
  %t1413 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1414 = icmp eq i32 %t1408, 1
  %t1415 = select i1 %t1414, i8* %t1413, i8* %t1412
  %t1416 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1417 = icmp eq i32 %t1408, 2
  %t1418 = select i1 %t1417, i8* %t1416, i8* %t1415
  %t1419 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1420 = icmp eq i32 %t1408, 3
  %t1421 = select i1 %t1420, i8* %t1419, i8* %t1418
  %t1422 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1423 = icmp eq i32 %t1408, 4
  %t1424 = select i1 %t1423, i8* %t1422, i8* %t1421
  %t1425 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1426 = icmp eq i32 %t1408, 5
  %t1427 = select i1 %t1426, i8* %t1425, i8* %t1424
  %t1428 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1429 = icmp eq i32 %t1408, 6
  %t1430 = select i1 %t1429, i8* %t1428, i8* %t1427
  %t1431 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1432 = icmp eq i32 %t1408, 7
  %t1433 = select i1 %t1432, i8* %t1431, i8* %t1430
  %t1434 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1435 = icmp eq i32 %t1408, 8
  %t1436 = select i1 %t1435, i8* %t1434, i8* %t1433
  %t1437 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1438 = icmp eq i32 %t1408, 9
  %t1439 = select i1 %t1438, i8* %t1437, i8* %t1436
  %t1440 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1441 = icmp eq i32 %t1408, 10
  %t1442 = select i1 %t1441, i8* %t1440, i8* %t1439
  %t1443 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1444 = icmp eq i32 %t1408, 11
  %t1445 = select i1 %t1444, i8* %t1443, i8* %t1442
  %t1446 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1447 = icmp eq i32 %t1408, 12
  %t1448 = select i1 %t1447, i8* %t1446, i8* %t1445
  %t1449 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1450 = icmp eq i32 %t1408, 13
  %t1451 = select i1 %t1450, i8* %t1449, i8* %t1448
  %t1452 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1453 = icmp eq i32 %t1408, 14
  %t1454 = select i1 %t1453, i8* %t1452, i8* %t1451
  %t1455 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1456 = icmp eq i32 %t1408, 15
  %t1457 = select i1 %t1456, i8* %t1455, i8* %t1454
  %t1458 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1459 = icmp eq i32 %t1408, 16
  %t1460 = select i1 %t1459, i8* %t1458, i8* %t1457
  %s1461 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h267355070, i32 0, i32 0
  %t1462 = icmp eq i8* %t1460, %s1461
  %t1463 = load %PythonBuilder, %PythonBuilder* %l0
  %t1464 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1465 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1466 = load i8*, i8** %l3
  %t1467 = load double, double* %l4
  %t1468 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1469 = load double, double* %l6
  %t1470 = load double, double* %l7
  %t1471 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1462, label %then76, label %else77
then76:
  %t1472 = load %PythonBuilder, %PythonBuilder* %l0
  %s1473 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h528348603, i32 0, i32 0
  %t1474 = call %PythonBuilder @builder_emit(%PythonBuilder %t1472, i8* %s1473)
  store %PythonBuilder %t1474, %PythonBuilder* %l0
  %t1475 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge78
else77:
  %t1476 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1477 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1476, i32 0, i32 0
  %t1478 = load i32, i32* %t1477
  %t1479 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1480 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1481 = icmp eq i32 %t1478, 0
  %t1482 = select i1 %t1481, i8* %t1480, i8* %t1479
  %t1483 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1484 = icmp eq i32 %t1478, 1
  %t1485 = select i1 %t1484, i8* %t1483, i8* %t1482
  %t1486 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1487 = icmp eq i32 %t1478, 2
  %t1488 = select i1 %t1487, i8* %t1486, i8* %t1485
  %t1489 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1490 = icmp eq i32 %t1478, 3
  %t1491 = select i1 %t1490, i8* %t1489, i8* %t1488
  %t1492 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1493 = icmp eq i32 %t1478, 4
  %t1494 = select i1 %t1493, i8* %t1492, i8* %t1491
  %t1495 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1496 = icmp eq i32 %t1478, 5
  %t1497 = select i1 %t1496, i8* %t1495, i8* %t1494
  %t1498 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1499 = icmp eq i32 %t1478, 6
  %t1500 = select i1 %t1499, i8* %t1498, i8* %t1497
  %t1501 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1502 = icmp eq i32 %t1478, 7
  %t1503 = select i1 %t1502, i8* %t1501, i8* %t1500
  %t1504 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1505 = icmp eq i32 %t1478, 8
  %t1506 = select i1 %t1505, i8* %t1504, i8* %t1503
  %t1507 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1508 = icmp eq i32 %t1478, 9
  %t1509 = select i1 %t1508, i8* %t1507, i8* %t1506
  %t1510 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1511 = icmp eq i32 %t1478, 10
  %t1512 = select i1 %t1511, i8* %t1510, i8* %t1509
  %t1513 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1514 = icmp eq i32 %t1478, 11
  %t1515 = select i1 %t1514, i8* %t1513, i8* %t1512
  %t1516 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1517 = icmp eq i32 %t1478, 12
  %t1518 = select i1 %t1517, i8* %t1516, i8* %t1515
  %t1519 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1520 = icmp eq i32 %t1478, 13
  %t1521 = select i1 %t1520, i8* %t1519, i8* %t1518
  %t1522 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1523 = icmp eq i32 %t1478, 14
  %t1524 = select i1 %t1523, i8* %t1522, i8* %t1521
  %t1525 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1526 = icmp eq i32 %t1478, 15
  %t1527 = select i1 %t1526, i8* %t1525, i8* %t1524
  %t1528 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1529 = icmp eq i32 %t1478, 16
  %t1530 = select i1 %t1529, i8* %t1528, i8* %t1527
  %s1531 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1117315388, i32 0, i32 0
  %t1532 = icmp eq i8* %t1530, %s1531
  %t1533 = load %PythonBuilder, %PythonBuilder* %l0
  %t1534 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1535 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1536 = load i8*, i8** %l3
  %t1537 = load double, double* %l4
  %t1538 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1539 = load double, double* %l6
  %t1540 = load double, double* %l7
  %t1541 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1532, label %then79, label %else80
then79:
  %t1542 = load double, double* %l6
  %t1543 = call i8* @generate_match_subject_name(double %t1542)
  store i8* %t1543, i8** %l25
  %t1544 = load double, double* %l6
  %t1545 = sitofp i64 1 to double
  %t1546 = fadd double %t1544, %t1545
  store double %t1546, double* %l6
  %t1547 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1548 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1547, i32 0, i32 0
  %t1549 = load i32, i32* %t1548
  %t1550 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1547, i32 0, i32 1
  %t1551 = bitcast [16 x i8]* %t1550 to i8*
  %t1552 = bitcast i8* %t1551 to i8**
  %t1553 = load i8*, i8** %t1552
  %t1554 = icmp eq i32 %t1549, 0
  %t1555 = select i1 %t1554, i8* %t1553, i8* null
  %t1556 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1547, i32 0, i32 1
  %t1557 = bitcast [16 x i8]* %t1556 to i8*
  %t1558 = bitcast i8* %t1557 to i8**
  %t1559 = load i8*, i8** %t1558
  %t1560 = icmp eq i32 %t1549, 1
  %t1561 = select i1 %t1560, i8* %t1559, i8* %t1555
  %t1562 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1547, i32 0, i32 1
  %t1563 = bitcast [8 x i8]* %t1562 to i8*
  %t1564 = bitcast i8* %t1563 to i8**
  %t1565 = load i8*, i8** %t1564
  %t1566 = icmp eq i32 %t1549, 12
  %t1567 = select i1 %t1566, i8* %t1565, i8* %t1561
  %t1568 = call i8* @lower_expression(i8* %t1567)
  store i8* %t1568, i8** %l26
  %t1569 = load %PythonBuilder, %PythonBuilder* %l0
  %t1570 = load i8*, i8** %l25
  %s1571 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087691079, i32 0, i32 0
  %t1572 = call i8* @sailfin_runtime_string_concat(i8* %t1570, i8* %s1571)
  %t1573 = load i8*, i8** %l26
  %t1574 = call i8* @sailfin_runtime_string_concat(i8* %t1572, i8* %t1573)
  %t1575 = call %PythonBuilder @builder_emit(%PythonBuilder %t1569, i8* %t1574)
  store %PythonBuilder %t1575, %PythonBuilder* %l0
  %t1576 = load i8*, i8** %l25
  %t1577 = insertvalue %MatchContext undef, i8* %t1576, 0
  %t1578 = sitofp i64 0 to double
  %t1579 = insertvalue %MatchContext %t1577, double %t1578, 1
  %t1580 = insertvalue %MatchContext %t1579, i1 0, 2
  store %MatchContext %t1580, %MatchContext* %l27
  %t1581 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1582 = load %MatchContext, %MatchContext* %l27
  %t1583 = call { %MatchContext*, i64 }* @append_match_context({ %MatchContext*, i64 }* %t1581, %MatchContext %t1582)
  store { %MatchContext*, i64 }* %t1583, { %MatchContext*, i64 }** %l5
  %t1584 = load double, double* %l6
  %t1585 = load %PythonBuilder, %PythonBuilder* %l0
  %t1586 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  br label %merge81
else80:
  %t1587 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1588 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1587, i32 0, i32 0
  %t1589 = load i32, i32* %t1588
  %t1590 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1591 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1592 = icmp eq i32 %t1589, 0
  %t1593 = select i1 %t1592, i8* %t1591, i8* %t1590
  %t1594 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1595 = icmp eq i32 %t1589, 1
  %t1596 = select i1 %t1595, i8* %t1594, i8* %t1593
  %t1597 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1598 = icmp eq i32 %t1589, 2
  %t1599 = select i1 %t1598, i8* %t1597, i8* %t1596
  %t1600 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1601 = icmp eq i32 %t1589, 3
  %t1602 = select i1 %t1601, i8* %t1600, i8* %t1599
  %t1603 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1604 = icmp eq i32 %t1589, 4
  %t1605 = select i1 %t1604, i8* %t1603, i8* %t1602
  %t1606 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1607 = icmp eq i32 %t1589, 5
  %t1608 = select i1 %t1607, i8* %t1606, i8* %t1605
  %t1609 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1610 = icmp eq i32 %t1589, 6
  %t1611 = select i1 %t1610, i8* %t1609, i8* %t1608
  %t1612 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1613 = icmp eq i32 %t1589, 7
  %t1614 = select i1 %t1613, i8* %t1612, i8* %t1611
  %t1615 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1616 = icmp eq i32 %t1589, 8
  %t1617 = select i1 %t1616, i8* %t1615, i8* %t1614
  %t1618 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1619 = icmp eq i32 %t1589, 9
  %t1620 = select i1 %t1619, i8* %t1618, i8* %t1617
  %t1621 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1622 = icmp eq i32 %t1589, 10
  %t1623 = select i1 %t1622, i8* %t1621, i8* %t1620
  %t1624 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1625 = icmp eq i32 %t1589, 11
  %t1626 = select i1 %t1625, i8* %t1624, i8* %t1623
  %t1627 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1628 = icmp eq i32 %t1589, 12
  %t1629 = select i1 %t1628, i8* %t1627, i8* %t1626
  %t1630 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1631 = icmp eq i32 %t1589, 13
  %t1632 = select i1 %t1631, i8* %t1630, i8* %t1629
  %t1633 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1634 = icmp eq i32 %t1589, 14
  %t1635 = select i1 %t1634, i8* %t1633, i8* %t1632
  %t1636 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1637 = icmp eq i32 %t1589, 15
  %t1638 = select i1 %t1637, i8* %t1636, i8* %t1635
  %t1639 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1640 = icmp eq i32 %t1589, 16
  %t1641 = select i1 %t1640, i8* %t1639, i8* %t1638
  %s1642 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h217223495, i32 0, i32 0
  %t1643 = icmp eq i8* %t1641, %s1642
  %t1644 = load %PythonBuilder, %PythonBuilder* %l0
  %t1645 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1646 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1647 = load i8*, i8** %l3
  %t1648 = load double, double* %l4
  %t1649 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1650 = load double, double* %l6
  %t1651 = load double, double* %l7
  %t1652 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1643, label %then82, label %else83
then82:
  %t1653 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1654 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t1653
  %t1655 = extractvalue { %MatchContext*, i64 } %t1654, 1
  %t1656 = icmp eq i64 %t1655, 0
  %t1657 = load %PythonBuilder, %PythonBuilder* %l0
  %t1658 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1659 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1660 = load i8*, i8** %l3
  %t1661 = load double, double* %l4
  %t1662 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1663 = load double, double* %l6
  %t1664 = load double, double* %l7
  %t1665 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1656, label %then85, label %else86
then85:
  %t1666 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1667 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1666, i32 0, i32 0
  %t1668 = load i32, i32* %t1667
  %t1669 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1666, i32 0, i32 1
  %t1670 = bitcast [16 x i8]* %t1669 to i8*
  %t1671 = bitcast i8* %t1670 to i8**
  %t1672 = load i8*, i8** %t1671
  %t1673 = icmp eq i32 %t1668, 13
  %t1674 = select i1 %t1673, i8* %t1672, i8* null
  %t1675 = call i8* @trim_text(i8* %t1674)
  store i8* %t1675, i8** %l28
  %s1676 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.len39.h2079567388, i32 0, i32 0
  store i8* %s1676, i8** %l29
  %t1677 = load i8*, i8** %l28
  %t1678 = call i64 @sailfin_runtime_string_length(i8* %t1677)
  %t1679 = icmp sgt i64 %t1678, 0
  %t1680 = load %PythonBuilder, %PythonBuilder* %l0
  %t1681 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1682 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1683 = load i8*, i8** %l3
  %t1684 = load double, double* %l4
  %t1685 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1686 = load double, double* %l6
  %t1687 = load double, double* %l7
  %t1688 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1689 = load i8*, i8** %l28
  %t1690 = load i8*, i8** %l29
  br i1 %t1679, label %then88, label %merge89
then88:
  %t1691 = load i8*, i8** %l29
  %s1692 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1460619898, i32 0, i32 0
  %t1693 = call i8* @sailfin_runtime_string_concat(i8* %t1691, i8* %s1692)
  %t1694 = load i8*, i8** %l28
  %t1695 = call i8* @sailfin_runtime_string_concat(i8* %t1693, i8* %t1694)
  %t1696 = alloca [2 x i8], align 1
  %t1697 = getelementptr [2 x i8], [2 x i8]* %t1696, i32 0, i32 0
  store i8 41, i8* %t1697
  %t1698 = getelementptr [2 x i8], [2 x i8]* %t1696, i32 0, i32 1
  store i8 0, i8* %t1698
  %t1699 = getelementptr [2 x i8], [2 x i8]* %t1696, i32 0, i32 0
  %t1700 = call i8* @sailfin_runtime_string_concat(i8* %t1695, i8* %t1699)
  store i8* %t1700, i8** %l29
  %t1701 = load i8*, i8** %l29
  br label %merge89
merge89:
  %t1702 = phi i8* [ %t1701, %then88 ], [ %t1690, %then85 ]
  store i8* %t1702, i8** %l29
  %t1703 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1704 = extractvalue %NativeFunction %function, 0
  %t1705 = load i8*, i8** %l29
  %t1706 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t1703, i8* %t1704, i8* %t1705)
  store { i8**, i64 }* %t1706, { i8**, i64 }** %l1
  %t1707 = load %PythonBuilder, %PythonBuilder* %l0
  %s1708 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.len41.h1804821690, i32 0, i32 0
  %t1709 = call %PythonBuilder @builder_emit(%PythonBuilder %t1707, i8* %s1708)
  store %PythonBuilder %t1709, %PythonBuilder* %l0
  %t1710 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1711 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge87
else86:
  %t1712 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1713 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t1712
  %t1714 = extractvalue { %MatchContext*, i64 } %t1713, 1
  %t1715 = sub i64 %t1714, 1
  store i64 %t1715, i64* %l30
  %t1716 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1717 = load i64, i64* %l30
  %t1718 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t1716
  %t1719 = extractvalue { %MatchContext*, i64 } %t1718, 0
  %t1720 = extractvalue { %MatchContext*, i64 } %t1718, 1
  %t1721 = icmp uge i64 %t1717, %t1720
  ; bounds check: %t1721 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t1717, i64 %t1720)
  %t1722 = getelementptr %MatchContext, %MatchContext* %t1719, i64 %t1717
  %t1723 = load %MatchContext, %MatchContext* %t1722
  store %MatchContext %t1723, %MatchContext* %l31
  %t1724 = load %MatchContext, %MatchContext* %l31
  %t1725 = extractvalue %MatchContext %t1724, 2
  %t1726 = load %PythonBuilder, %PythonBuilder* %l0
  %t1727 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1728 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1729 = load i8*, i8** %l3
  %t1730 = load double, double* %l4
  %t1731 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1732 = load double, double* %l6
  %t1733 = load double, double* %l7
  %t1734 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1735 = load i64, i64* %l30
  %t1736 = load %MatchContext, %MatchContext* %l31
  br i1 %t1725, label %then90, label %merge91
then90:
  %t1737 = load %PythonBuilder, %PythonBuilder* %l0
  %t1738 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t1737)
  store %PythonBuilder %t1738, %PythonBuilder* %l0
  %t1739 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge91
merge91:
  %t1740 = phi %PythonBuilder [ %t1739, %then90 ], [ %t1726, %else86 ]
  store %PythonBuilder %t1740, %PythonBuilder* %l0
  %t1741 = load %MatchContext, %MatchContext* %l31
  %t1742 = extractvalue %MatchContext %t1741, 0
  %t1743 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1744 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1743, i32 0, i32 0
  %t1745 = load i32, i32* %t1744
  %t1746 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1743, i32 0, i32 1
  %t1747 = bitcast [16 x i8]* %t1746 to i8*
  %t1748 = bitcast i8* %t1747 to i8**
  %t1749 = load i8*, i8** %t1748
  %t1750 = icmp eq i32 %t1745, 13
  %t1751 = select i1 %t1750, i8* %t1749, i8* null
  %t1752 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1753 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1752, i32 0, i32 0
  %t1754 = load i32, i32* %t1753
  %t1755 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1752, i32 0, i32 1
  %t1756 = bitcast [16 x i8]* %t1755 to i8*
  %t1757 = getelementptr inbounds i8, i8* %t1756, i64 8
  %t1758 = bitcast i8* %t1757 to i8**
  %t1759 = load i8*, i8** %t1758
  %t1760 = icmp eq i32 %t1754, 13
  %t1761 = select i1 %t1760, i8* %t1759, i8* null
  %t1762 = call %LoweredCaseCondition @lower_match_case_condition(i8* %t1742, i8* %t1751, i8* %t1761)
  store %LoweredCaseCondition %t1762, %LoweredCaseCondition* %l32
  %t1763 = load %MatchContext, %MatchContext* %l31
  %t1764 = extractvalue %MatchContext %t1763, 1
  %t1765 = sitofp i64 0 to double
  %t1766 = fcmp oeq double %t1764, %t1765
  %t1767 = load %PythonBuilder, %PythonBuilder* %l0
  %t1768 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1769 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1770 = load i8*, i8** %l3
  %t1771 = load double, double* %l4
  %t1772 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1773 = load double, double* %l6
  %t1774 = load double, double* %l7
  %t1775 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1776 = load i64, i64* %l30
  %t1777 = load %MatchContext, %MatchContext* %l31
  %t1778 = load %LoweredCaseCondition, %LoweredCaseCondition* %l32
  br i1 %t1766, label %then92, label %else93
then92:
  %t1779 = load %PythonBuilder, %PythonBuilder* %l0
  %s1780 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2090359129, i32 0, i32 0
  %t1781 = load %LoweredCaseCondition, %LoweredCaseCondition* %l32
  %t1782 = extractvalue %LoweredCaseCondition %t1781, 0
  %t1783 = call i8* @sailfin_runtime_string_concat(i8* %s1780, i8* %t1782)
  %t1784 = alloca [2 x i8], align 1
  %t1785 = getelementptr [2 x i8], [2 x i8]* %t1784, i32 0, i32 0
  store i8 58, i8* %t1785
  %t1786 = getelementptr [2 x i8], [2 x i8]* %t1784, i32 0, i32 1
  store i8 0, i8* %t1786
  %t1787 = getelementptr [2 x i8], [2 x i8]* %t1784, i32 0, i32 0
  %t1788 = call i8* @sailfin_runtime_string_concat(i8* %t1783, i8* %t1787)
  %t1789 = call %PythonBuilder @builder_emit(%PythonBuilder %t1779, i8* %t1788)
  store %PythonBuilder %t1789, %PythonBuilder* %l0
  %t1790 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge94
else93:
  %t1792 = load %LoweredCaseCondition, %LoweredCaseCondition* %l32
  %t1793 = extractvalue %LoweredCaseCondition %t1792, 1
  br label %logical_and_entry_1791

logical_and_entry_1791:
  br i1 %t1793, label %logical_and_right_1791, label %logical_and_merge_1791

logical_and_right_1791:
  %t1794 = load %LoweredCaseCondition, %LoweredCaseCondition* %l32
  %t1795 = extractvalue %LoweredCaseCondition %t1794, 2
  %t1796 = xor i1 %t1795, 1
  br label %logical_and_right_end_1791

logical_and_right_end_1791:
  br label %logical_and_merge_1791

logical_and_merge_1791:
  %t1797 = phi i1 [ false, %logical_and_entry_1791 ], [ %t1796, %logical_and_right_end_1791 ]
  %t1798 = load %PythonBuilder, %PythonBuilder* %l0
  %t1799 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1800 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1801 = load i8*, i8** %l3
  %t1802 = load double, double* %l4
  %t1803 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1804 = load double, double* %l6
  %t1805 = load double, double* %l7
  %t1806 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1807 = load i64, i64* %l30
  %t1808 = load %MatchContext, %MatchContext* %l31
  %t1809 = load %LoweredCaseCondition, %LoweredCaseCondition* %l32
  br i1 %t1797, label %then95, label %else96
then95:
  %t1810 = load %PythonBuilder, %PythonBuilder* %l0
  %s1811 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2069574674, i32 0, i32 0
  %t1812 = call %PythonBuilder @builder_emit(%PythonBuilder %t1810, i8* %s1811)
  store %PythonBuilder %t1812, %PythonBuilder* %l0
  %t1813 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge97
else96:
  %t1814 = load %PythonBuilder, %PythonBuilder* %l0
  %s1815 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2069215535, i32 0, i32 0
  %t1816 = load %LoweredCaseCondition, %LoweredCaseCondition* %l32
  %t1817 = extractvalue %LoweredCaseCondition %t1816, 0
  %t1818 = call i8* @sailfin_runtime_string_concat(i8* %s1815, i8* %t1817)
  %t1819 = alloca [2 x i8], align 1
  %t1820 = getelementptr [2 x i8], [2 x i8]* %t1819, i32 0, i32 0
  store i8 58, i8* %t1820
  %t1821 = getelementptr [2 x i8], [2 x i8]* %t1819, i32 0, i32 1
  store i8 0, i8* %t1821
  %t1822 = getelementptr [2 x i8], [2 x i8]* %t1819, i32 0, i32 0
  %t1823 = call i8* @sailfin_runtime_string_concat(i8* %t1818, i8* %t1822)
  %t1824 = call %PythonBuilder @builder_emit(%PythonBuilder %t1814, i8* %t1823)
  store %PythonBuilder %t1824, %PythonBuilder* %l0
  %t1825 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge97
merge97:
  %t1826 = phi %PythonBuilder [ %t1813, %then95 ], [ %t1825, %else96 ]
  store %PythonBuilder %t1826, %PythonBuilder* %l0
  %t1827 = load %PythonBuilder, %PythonBuilder* %l0
  %t1828 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge94
merge94:
  %t1829 = phi %PythonBuilder [ %t1790, %then92 ], [ %t1827, %merge97 ]
  store %PythonBuilder %t1829, %PythonBuilder* %l0
  %t1830 = load %PythonBuilder, %PythonBuilder* %l0
  %t1831 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t1830)
  store %PythonBuilder %t1831, %PythonBuilder* %l0
  %t1832 = load %MatchContext, %MatchContext* %l31
  %t1833 = extractvalue %MatchContext %t1832, 0
  %t1834 = insertvalue %MatchContext undef, i8* %t1833, 0
  %t1835 = load %MatchContext, %MatchContext* %l31
  %t1836 = extractvalue %MatchContext %t1835, 1
  %t1837 = sitofp i64 1 to double
  %t1838 = fadd double %t1836, %t1837
  %t1839 = insertvalue %MatchContext %t1834, double %t1838, 1
  %t1840 = insertvalue %MatchContext %t1839, i1 1, 2
  store %MatchContext %t1840, %MatchContext* %l33
  %t1841 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1842 = load i64, i64* %l30
  %t1843 = load %MatchContext, %MatchContext* %l33
  %t1844 = sitofp i64 %t1842 to double
  %t1845 = call { %MatchContext*, i64 }* @replace_match_context({ %MatchContext*, i64 }* %t1841, double %t1844, %MatchContext %t1843)
  store { %MatchContext*, i64 }* %t1845, { %MatchContext*, i64 }** %l5
  %t1846 = load %PythonBuilder, %PythonBuilder* %l0
  %t1847 = load %PythonBuilder, %PythonBuilder* %l0
  %t1848 = load %PythonBuilder, %PythonBuilder* %l0
  %t1849 = load %PythonBuilder, %PythonBuilder* %l0
  %t1850 = load %PythonBuilder, %PythonBuilder* %l0
  %t1851 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  br label %merge87
merge87:
  %t1852 = phi { i8**, i64 }* [ %t1710, %merge89 ], [ %t1658, %merge94 ]
  %t1853 = phi %PythonBuilder [ %t1711, %merge89 ], [ %t1846, %merge94 ]
  %t1854 = phi { %MatchContext*, i64 }* [ %t1662, %merge89 ], [ %t1851, %merge94 ]
  store { i8**, i64 }* %t1852, { i8**, i64 }** %l1
  store %PythonBuilder %t1853, %PythonBuilder* %l0
  store { %MatchContext*, i64 }* %t1854, { %MatchContext*, i64 }** %l5
  %t1855 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1856 = load %PythonBuilder, %PythonBuilder* %l0
  %t1857 = load %PythonBuilder, %PythonBuilder* %l0
  %t1858 = load %PythonBuilder, %PythonBuilder* %l0
  %t1859 = load %PythonBuilder, %PythonBuilder* %l0
  %t1860 = load %PythonBuilder, %PythonBuilder* %l0
  %t1861 = load %PythonBuilder, %PythonBuilder* %l0
  %t1862 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  br label %merge84
else83:
  %t1863 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1864 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1863, i32 0, i32 0
  %t1865 = load i32, i32* %t1864
  %t1866 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1867 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1868 = icmp eq i32 %t1865, 0
  %t1869 = select i1 %t1868, i8* %t1867, i8* %t1866
  %t1870 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1871 = icmp eq i32 %t1865, 1
  %t1872 = select i1 %t1871, i8* %t1870, i8* %t1869
  %t1873 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1874 = icmp eq i32 %t1865, 2
  %t1875 = select i1 %t1874, i8* %t1873, i8* %t1872
  %t1876 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1877 = icmp eq i32 %t1865, 3
  %t1878 = select i1 %t1877, i8* %t1876, i8* %t1875
  %t1879 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1880 = icmp eq i32 %t1865, 4
  %t1881 = select i1 %t1880, i8* %t1879, i8* %t1878
  %t1882 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1883 = icmp eq i32 %t1865, 5
  %t1884 = select i1 %t1883, i8* %t1882, i8* %t1881
  %t1885 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1886 = icmp eq i32 %t1865, 6
  %t1887 = select i1 %t1886, i8* %t1885, i8* %t1884
  %t1888 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1889 = icmp eq i32 %t1865, 7
  %t1890 = select i1 %t1889, i8* %t1888, i8* %t1887
  %t1891 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1892 = icmp eq i32 %t1865, 8
  %t1893 = select i1 %t1892, i8* %t1891, i8* %t1890
  %t1894 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1895 = icmp eq i32 %t1865, 9
  %t1896 = select i1 %t1895, i8* %t1894, i8* %t1893
  %t1897 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1898 = icmp eq i32 %t1865, 10
  %t1899 = select i1 %t1898, i8* %t1897, i8* %t1896
  %t1900 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1901 = icmp eq i32 %t1865, 11
  %t1902 = select i1 %t1901, i8* %t1900, i8* %t1899
  %t1903 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1904 = icmp eq i32 %t1865, 12
  %t1905 = select i1 %t1904, i8* %t1903, i8* %t1902
  %t1906 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1907 = icmp eq i32 %t1865, 13
  %t1908 = select i1 %t1907, i8* %t1906, i8* %t1905
  %t1909 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1910 = icmp eq i32 %t1865, 14
  %t1911 = select i1 %t1910, i8* %t1909, i8* %t1908
  %t1912 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1913 = icmp eq i32 %t1865, 15
  %t1914 = select i1 %t1913, i8* %t1912, i8* %t1911
  %t1915 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1916 = icmp eq i32 %t1865, 16
  %t1917 = select i1 %t1916, i8* %t1915, i8* %t1914
  %s1918 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h794378208, i32 0, i32 0
  %t1919 = icmp eq i8* %t1917, %s1918
  %t1920 = load %PythonBuilder, %PythonBuilder* %l0
  %t1921 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1922 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1923 = load i8*, i8** %l3
  %t1924 = load double, double* %l4
  %t1925 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1926 = load double, double* %l6
  %t1927 = load double, double* %l7
  %t1928 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1919, label %then98, label %else99
then98:
  %t1929 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1930 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t1929
  %t1931 = extractvalue { %MatchContext*, i64 } %t1930, 1
  %t1932 = icmp eq i64 %t1931, 0
  %t1933 = load %PythonBuilder, %PythonBuilder* %l0
  %t1934 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1935 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1936 = load i8*, i8** %l3
  %t1937 = load double, double* %l4
  %t1938 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1939 = load double, double* %l6
  %t1940 = load double, double* %l7
  %t1941 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1932, label %then101, label %else102
then101:
  %t1942 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1943 = extractvalue %NativeFunction %function, 0
  %s1944 = getelementptr inbounds [38 x i8], [38 x i8]* @.str.len37.h314404344, i32 0, i32 0
  %t1945 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t1942, i8* %t1943, i8* %s1944)
  store { i8**, i64 }* %t1945, { i8**, i64 }** %l1
  %t1946 = load %PythonBuilder, %PythonBuilder* %l0
  %s1947 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.len39.h198700275, i32 0, i32 0
  %t1948 = call %PythonBuilder @builder_emit(%PythonBuilder %t1946, i8* %s1947)
  store %PythonBuilder %t1948, %PythonBuilder* %l0
  %t1949 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1950 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge103
else102:
  %t1951 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1952 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t1951
  %t1953 = extractvalue { %MatchContext*, i64 } %t1952, 1
  %t1954 = sub i64 %t1953, 1
  store i64 %t1954, i64* %l34
  %t1955 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1956 = load i64, i64* %l34
  %t1957 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t1955
  %t1958 = extractvalue { %MatchContext*, i64 } %t1957, 0
  %t1959 = extractvalue { %MatchContext*, i64 } %t1957, 1
  %t1960 = icmp uge i64 %t1956, %t1959
  ; bounds check: %t1960 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t1956, i64 %t1959)
  %t1961 = getelementptr %MatchContext, %MatchContext* %t1958, i64 %t1956
  %t1962 = load %MatchContext, %MatchContext* %t1961
  store %MatchContext %t1962, %MatchContext* %l35
  %t1963 = load %MatchContext, %MatchContext* %l35
  %t1964 = extractvalue %MatchContext %t1963, 2
  %t1965 = load %PythonBuilder, %PythonBuilder* %l0
  %t1966 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1967 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1968 = load i8*, i8** %l3
  %t1969 = load double, double* %l4
  %t1970 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1971 = load double, double* %l6
  %t1972 = load double, double* %l7
  %t1973 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1974 = load i64, i64* %l34
  %t1975 = load %MatchContext, %MatchContext* %l35
  br i1 %t1964, label %then104, label %merge105
then104:
  %t1976 = load %PythonBuilder, %PythonBuilder* %l0
  %t1977 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t1976)
  store %PythonBuilder %t1977, %PythonBuilder* %l0
  %t1978 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge105
merge105:
  %t1979 = phi %PythonBuilder [ %t1978, %then104 ], [ %t1965, %else102 ]
  store %PythonBuilder %t1979, %PythonBuilder* %l0
  %t1980 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1981 = load i64, i64* %l34
  %t1982 = sitofp i64 %t1981 to double
  %t1983 = call { %MatchContext*, i64 }* @truncate_match_contexts({ %MatchContext*, i64 }* %t1980, double %t1982)
  store { %MatchContext*, i64 }* %t1983, { %MatchContext*, i64 }** %l5
  %t1984 = load %PythonBuilder, %PythonBuilder* %l0
  %t1985 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  br label %merge103
merge103:
  %t1986 = phi { i8**, i64 }* [ %t1949, %then101 ], [ %t1934, %merge105 ]
  %t1987 = phi %PythonBuilder [ %t1950, %then101 ], [ %t1984, %merge105 ]
  %t1988 = phi { %MatchContext*, i64 }* [ %t1938, %then101 ], [ %t1985, %merge105 ]
  store { i8**, i64 }* %t1986, { i8**, i64 }** %l1
  store %PythonBuilder %t1987, %PythonBuilder* %l0
  store { %MatchContext*, i64 }* %t1988, { %MatchContext*, i64 }** %l5
  %t1989 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1990 = load %PythonBuilder, %PythonBuilder* %l0
  %t1991 = load %PythonBuilder, %PythonBuilder* %l0
  %t1992 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  br label %merge100
else99:
  %t1993 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1994 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1993, i32 0, i32 0
  %t1995 = load i32, i32* %t1994
  %t1996 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1997 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1998 = icmp eq i32 %t1995, 0
  %t1999 = select i1 %t1998, i8* %t1997, i8* %t1996
  %t2000 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t2001 = icmp eq i32 %t1995, 1
  %t2002 = select i1 %t2001, i8* %t2000, i8* %t1999
  %t2003 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t2004 = icmp eq i32 %t1995, 2
  %t2005 = select i1 %t2004, i8* %t2003, i8* %t2002
  %t2006 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t2007 = icmp eq i32 %t1995, 3
  %t2008 = select i1 %t2007, i8* %t2006, i8* %t2005
  %t2009 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t2010 = icmp eq i32 %t1995, 4
  %t2011 = select i1 %t2010, i8* %t2009, i8* %t2008
  %t2012 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t2013 = icmp eq i32 %t1995, 5
  %t2014 = select i1 %t2013, i8* %t2012, i8* %t2011
  %t2015 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t2016 = icmp eq i32 %t1995, 6
  %t2017 = select i1 %t2016, i8* %t2015, i8* %t2014
  %t2018 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t2019 = icmp eq i32 %t1995, 7
  %t2020 = select i1 %t2019, i8* %t2018, i8* %t2017
  %t2021 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t2022 = icmp eq i32 %t1995, 8
  %t2023 = select i1 %t2022, i8* %t2021, i8* %t2020
  %t2024 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t2025 = icmp eq i32 %t1995, 9
  %t2026 = select i1 %t2025, i8* %t2024, i8* %t2023
  %t2027 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t2028 = icmp eq i32 %t1995, 10
  %t2029 = select i1 %t2028, i8* %t2027, i8* %t2026
  %t2030 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t2031 = icmp eq i32 %t1995, 11
  %t2032 = select i1 %t2031, i8* %t2030, i8* %t2029
  %t2033 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t2034 = icmp eq i32 %t1995, 12
  %t2035 = select i1 %t2034, i8* %t2033, i8* %t2032
  %t2036 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t2037 = icmp eq i32 %t1995, 13
  %t2038 = select i1 %t2037, i8* %t2036, i8* %t2035
  %t2039 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t2040 = icmp eq i32 %t1995, 14
  %t2041 = select i1 %t2040, i8* %t2039, i8* %t2038
  %t2042 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t2043 = icmp eq i32 %t1995, 15
  %t2044 = select i1 %t2043, i8* %t2042, i8* %t2041
  %t2045 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t2046 = icmp eq i32 %t1995, 16
  %t2047 = select i1 %t2046, i8* %t2045, i8* %t2044
  %s2048 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h230767751, i32 0, i32 0
  %t2049 = icmp eq i8* %t2047, %s2048
  %t2050 = load %PythonBuilder, %PythonBuilder* %l0
  %t2051 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2052 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2053 = load i8*, i8** %l3
  %t2054 = load double, double* %l4
  %t2055 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2056 = load double, double* %l6
  %t2057 = load double, double* %l7
  %t2058 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t2049, label %then106, label %else107
then106:
  %t2059 = load %PythonBuilder, %PythonBuilder* %l0
  %s2060 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h270590402, i32 0, i32 0
  %t2061 = call %PythonBuilder @builder_emit(%PythonBuilder %t2059, i8* %s2060)
  store %PythonBuilder %t2061, %PythonBuilder* %l0
  %t2062 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge108
else107:
  %t2063 = load %NativeInstruction*, %NativeInstruction** %l8
  %t2064 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t2063, i32 0, i32 0
  %t2065 = load i32, i32* %t2064
  %t2066 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t2063, i32 0, i32 1
  %t2067 = bitcast [8 x i8]* %t2066 to i8*
  %t2068 = bitcast i8* %t2067 to i8**
  %t2069 = load i8*, i8** %t2068
  %t2070 = icmp eq i32 %t2065, 16
  %t2071 = select i1 %t2070, i8* %t2069, i8* null
  %t2072 = call i8* @trim_text(i8* %t2071)
  store i8* %t2072, i8** %l36
  %s2073 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.len42.h9444846, i32 0, i32 0
  store i8* %s2073, i8** %l37
  %t2074 = load i8*, i8** %l36
  %t2075 = call i64 @sailfin_runtime_string_length(i8* %t2074)
  %t2076 = icmp sgt i64 %t2075, 0
  %t2077 = load %PythonBuilder, %PythonBuilder* %l0
  %t2078 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2079 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2080 = load i8*, i8** %l3
  %t2081 = load double, double* %l4
  %t2082 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2083 = load double, double* %l6
  %t2084 = load double, double* %l7
  %t2085 = load %NativeInstruction*, %NativeInstruction** %l8
  %t2086 = load i8*, i8** %l36
  %t2087 = load i8*, i8** %l37
  br i1 %t2076, label %then109, label %merge110
then109:
  %t2088 = load i8*, i8** %l37
  %s2089 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193441217, i32 0, i32 0
  %t2090 = call i8* @sailfin_runtime_string_concat(i8* %t2088, i8* %s2089)
  %t2091 = load i8*, i8** %l36
  %t2092 = call i8* @sailfin_runtime_string_concat(i8* %t2090, i8* %t2091)
  store i8* %t2092, i8** %l37
  %t2093 = load i8*, i8** %l37
  br label %merge110
merge110:
  %t2094 = phi i8* [ %t2093, %then109 ], [ %t2087, %else107 ]
  store i8* %t2094, i8** %l37
  %t2095 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2096 = extractvalue %NativeFunction %function, 0
  %t2097 = load i8*, i8** %l37
  %t2098 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t2095, i8* %t2096, i8* %t2097)
  store { i8**, i64 }* %t2098, { i8**, i64 }** %l1
  %t2099 = load %PythonBuilder, %PythonBuilder* %l0
  %s2100 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h1983072220, i32 0, i32 0
  %t2101 = load %NativeInstruction*, %NativeInstruction** %l8
  %t2102 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t2101, i32 0, i32 0
  %t2103 = load i32, i32* %t2102
  %t2104 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t2101, i32 0, i32 1
  %t2105 = bitcast [8 x i8]* %t2104 to i8*
  %t2106 = bitcast i8* %t2105 to i8**
  %t2107 = load i8*, i8** %t2106
  %t2108 = icmp eq i32 %t2103, 16
  %t2109 = select i1 %t2108, i8* %t2107, i8* null
  %t2110 = call i8* @sailfin_runtime_string_concat(i8* %s2100, i8* %t2109)
  %t2111 = call %PythonBuilder @builder_emit(%PythonBuilder %t2099, i8* %t2110)
  store %PythonBuilder %t2111, %PythonBuilder* %l0
  %t2112 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2113 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge108
merge108:
  %t2114 = phi %PythonBuilder [ %t2062, %then106 ], [ %t2113, %merge110 ]
  %t2115 = phi { i8**, i64 }* [ %t2051, %then106 ], [ %t2112, %merge110 ]
  store %PythonBuilder %t2114, %PythonBuilder* %l0
  store { i8**, i64 }* %t2115, { i8**, i64 }** %l1
  %t2116 = load %PythonBuilder, %PythonBuilder* %l0
  %t2117 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2118 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge100
merge100:
  %t2119 = phi { i8**, i64 }* [ %t1989, %merge103 ], [ %t2117, %merge108 ]
  %t2120 = phi %PythonBuilder [ %t1990, %merge103 ], [ %t2116, %merge108 ]
  %t2121 = phi { %MatchContext*, i64 }* [ %t1992, %merge103 ], [ %t1925, %merge108 ]
  store { i8**, i64 }* %t2119, { i8**, i64 }** %l1
  store %PythonBuilder %t2120, %PythonBuilder* %l0
  store { %MatchContext*, i64 }* %t2121, { %MatchContext*, i64 }** %l5
  %t2122 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2123 = load %PythonBuilder, %PythonBuilder* %l0
  %t2124 = load %PythonBuilder, %PythonBuilder* %l0
  %t2125 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2126 = load %PythonBuilder, %PythonBuilder* %l0
  %t2127 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2128 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge84
merge84:
  %t2129 = phi { i8**, i64 }* [ %t1855, %merge87 ], [ %t2122, %merge100 ]
  %t2130 = phi %PythonBuilder [ %t1856, %merge87 ], [ %t2123, %merge100 ]
  %t2131 = phi { %MatchContext*, i64 }* [ %t1862, %merge87 ], [ %t2125, %merge100 ]
  store { i8**, i64 }* %t2129, { i8**, i64 }** %l1
  store %PythonBuilder %t2130, %PythonBuilder* %l0
  store { %MatchContext*, i64 }* %t2131, { %MatchContext*, i64 }** %l5
  %t2132 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2133 = load %PythonBuilder, %PythonBuilder* %l0
  %t2134 = load %PythonBuilder, %PythonBuilder* %l0
  %t2135 = load %PythonBuilder, %PythonBuilder* %l0
  %t2136 = load %PythonBuilder, %PythonBuilder* %l0
  %t2137 = load %PythonBuilder, %PythonBuilder* %l0
  %t2138 = load %PythonBuilder, %PythonBuilder* %l0
  %t2139 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2140 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2141 = load %PythonBuilder, %PythonBuilder* %l0
  %t2142 = load %PythonBuilder, %PythonBuilder* %l0
  %t2143 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2144 = load %PythonBuilder, %PythonBuilder* %l0
  %t2145 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2146 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge81
merge81:
  %t2147 = phi double [ %t1584, %then79 ], [ %t1539, %merge84 ]
  %t2148 = phi %PythonBuilder [ %t1585, %then79 ], [ %t2133, %merge84 ]
  %t2149 = phi { %MatchContext*, i64 }* [ %t1586, %then79 ], [ %t2139, %merge84 ]
  %t2150 = phi { i8**, i64 }* [ %t1534, %then79 ], [ %t2132, %merge84 ]
  store double %t2147, double* %l6
  store %PythonBuilder %t2148, %PythonBuilder* %l0
  store { %MatchContext*, i64 }* %t2149, { %MatchContext*, i64 }** %l5
  store { i8**, i64 }* %t2150, { i8**, i64 }** %l1
  %t2151 = load double, double* %l6
  %t2152 = load %PythonBuilder, %PythonBuilder* %l0
  %t2153 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2154 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2155 = load %PythonBuilder, %PythonBuilder* %l0
  %t2156 = load %PythonBuilder, %PythonBuilder* %l0
  %t2157 = load %PythonBuilder, %PythonBuilder* %l0
  %t2158 = load %PythonBuilder, %PythonBuilder* %l0
  %t2159 = load %PythonBuilder, %PythonBuilder* %l0
  %t2160 = load %PythonBuilder, %PythonBuilder* %l0
  %t2161 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2162 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2163 = load %PythonBuilder, %PythonBuilder* %l0
  %t2164 = load %PythonBuilder, %PythonBuilder* %l0
  %t2165 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2166 = load %PythonBuilder, %PythonBuilder* %l0
  %t2167 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2168 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge78
merge78:
  %t2169 = phi %PythonBuilder [ %t1475, %then76 ], [ %t2152, %merge81 ]
  %t2170 = phi double [ %t1469, %then76 ], [ %t2151, %merge81 ]
  %t2171 = phi { %MatchContext*, i64 }* [ %t1468, %then76 ], [ %t2153, %merge81 ]
  %t2172 = phi { i8**, i64 }* [ %t1464, %then76 ], [ %t2154, %merge81 ]
  store %PythonBuilder %t2169, %PythonBuilder* %l0
  store double %t2170, double* %l6
  store { %MatchContext*, i64 }* %t2171, { %MatchContext*, i64 }** %l5
  store { i8**, i64 }* %t2172, { i8**, i64 }** %l1
  %t2173 = load %PythonBuilder, %PythonBuilder* %l0
  %t2174 = load double, double* %l6
  %t2175 = load %PythonBuilder, %PythonBuilder* %l0
  %t2176 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2177 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2178 = load %PythonBuilder, %PythonBuilder* %l0
  %t2179 = load %PythonBuilder, %PythonBuilder* %l0
  %t2180 = load %PythonBuilder, %PythonBuilder* %l0
  %t2181 = load %PythonBuilder, %PythonBuilder* %l0
  %t2182 = load %PythonBuilder, %PythonBuilder* %l0
  %t2183 = load %PythonBuilder, %PythonBuilder* %l0
  %t2184 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2185 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2186 = load %PythonBuilder, %PythonBuilder* %l0
  %t2187 = load %PythonBuilder, %PythonBuilder* %l0
  %t2188 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2189 = load %PythonBuilder, %PythonBuilder* %l0
  %t2190 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2191 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge75
merge75:
  %t2192 = phi %PythonBuilder [ %t1405, %then73 ], [ %t2173, %merge78 ]
  %t2193 = phi double [ %t1399, %then73 ], [ %t2174, %merge78 ]
  %t2194 = phi { %MatchContext*, i64 }* [ %t1398, %then73 ], [ %t2176, %merge78 ]
  %t2195 = phi { i8**, i64 }* [ %t1394, %then73 ], [ %t2177, %merge78 ]
  store %PythonBuilder %t2192, %PythonBuilder* %l0
  store double %t2193, double* %l6
  store { %MatchContext*, i64 }* %t2194, { %MatchContext*, i64 }** %l5
  store { i8**, i64 }* %t2195, { i8**, i64 }** %l1
  %t2196 = load %PythonBuilder, %PythonBuilder* %l0
  %t2197 = load %PythonBuilder, %PythonBuilder* %l0
  %t2198 = load double, double* %l6
  %t2199 = load %PythonBuilder, %PythonBuilder* %l0
  %t2200 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2201 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2202 = load %PythonBuilder, %PythonBuilder* %l0
  %t2203 = load %PythonBuilder, %PythonBuilder* %l0
  %t2204 = load %PythonBuilder, %PythonBuilder* %l0
  %t2205 = load %PythonBuilder, %PythonBuilder* %l0
  %t2206 = load %PythonBuilder, %PythonBuilder* %l0
  %t2207 = load %PythonBuilder, %PythonBuilder* %l0
  %t2208 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2209 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2210 = load %PythonBuilder, %PythonBuilder* %l0
  %t2211 = load %PythonBuilder, %PythonBuilder* %l0
  %t2212 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2213 = load %PythonBuilder, %PythonBuilder* %l0
  %t2214 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2215 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge69
merge69:
  %t2216 = phi %PythonBuilder [ %t1333, %merge72 ], [ %t2196, %merge75 ]
  %t2217 = phi double [ %t1334, %merge72 ], [ %t1301, %merge75 ]
  %t2218 = phi { i8**, i64 }* [ %t1335, %merge72 ], [ %t2201, %merge75 ]
  %t2219 = phi double [ %t1303, %merge72 ], [ %t2198, %merge75 ]
  %t2220 = phi { %MatchContext*, i64 }* [ %t1302, %merge72 ], [ %t2200, %merge75 ]
  store %PythonBuilder %t2216, %PythonBuilder* %l0
  store double %t2217, double* %l4
  store { i8**, i64 }* %t2218, { i8**, i64 }** %l1
  store double %t2219, double* %l6
  store { %MatchContext*, i64 }* %t2220, { %MatchContext*, i64 }** %l5
  %t2221 = load %PythonBuilder, %PythonBuilder* %l0
  %t2222 = load double, double* %l4
  %t2223 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2224 = load %PythonBuilder, %PythonBuilder* %l0
  %t2225 = load %PythonBuilder, %PythonBuilder* %l0
  %t2226 = load double, double* %l6
  %t2227 = load %PythonBuilder, %PythonBuilder* %l0
  %t2228 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2229 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2230 = load %PythonBuilder, %PythonBuilder* %l0
  %t2231 = load %PythonBuilder, %PythonBuilder* %l0
  %t2232 = load %PythonBuilder, %PythonBuilder* %l0
  %t2233 = load %PythonBuilder, %PythonBuilder* %l0
  %t2234 = load %PythonBuilder, %PythonBuilder* %l0
  %t2235 = load %PythonBuilder, %PythonBuilder* %l0
  %t2236 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2237 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2238 = load %PythonBuilder, %PythonBuilder* %l0
  %t2239 = load %PythonBuilder, %PythonBuilder* %l0
  %t2240 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2241 = load %PythonBuilder, %PythonBuilder* %l0
  %t2242 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2243 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge66
merge66:
  %t2244 = phi %PythonBuilder [ %t1237, %then64 ], [ %t2221, %merge69 ]
  %t2245 = phi double [ %t1239, %then64 ], [ %t2222, %merge69 ]
  %t2246 = phi { i8**, i64 }* [ %t1221, %then64 ], [ %t2223, %merge69 ]
  %t2247 = phi double [ %t1226, %then64 ], [ %t2226, %merge69 ]
  %t2248 = phi { %MatchContext*, i64 }* [ %t1225, %then64 ], [ %t2228, %merge69 ]
  store %PythonBuilder %t2244, %PythonBuilder* %l0
  store double %t2245, double* %l4
  store { i8**, i64 }* %t2246, { i8**, i64 }** %l1
  store double %t2247, double* %l6
  store { %MatchContext*, i64 }* %t2248, { %MatchContext*, i64 }** %l5
  %t2249 = load %PythonBuilder, %PythonBuilder* %l0
  %t2250 = load %PythonBuilder, %PythonBuilder* %l0
  %t2251 = load double, double* %l4
  %t2252 = load %PythonBuilder, %PythonBuilder* %l0
  %t2253 = load double, double* %l4
  %t2254 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2255 = load %PythonBuilder, %PythonBuilder* %l0
  %t2256 = load %PythonBuilder, %PythonBuilder* %l0
  %t2257 = load double, double* %l6
  %t2258 = load %PythonBuilder, %PythonBuilder* %l0
  %t2259 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2260 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2261 = load %PythonBuilder, %PythonBuilder* %l0
  %t2262 = load %PythonBuilder, %PythonBuilder* %l0
  %t2263 = load %PythonBuilder, %PythonBuilder* %l0
  %t2264 = load %PythonBuilder, %PythonBuilder* %l0
  %t2265 = load %PythonBuilder, %PythonBuilder* %l0
  %t2266 = load %PythonBuilder, %PythonBuilder* %l0
  %t2267 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2268 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2269 = load %PythonBuilder, %PythonBuilder* %l0
  %t2270 = load %PythonBuilder, %PythonBuilder* %l0
  %t2271 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2272 = load %PythonBuilder, %PythonBuilder* %l0
  %t2273 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2274 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge60
merge60:
  %t2275 = phi %PythonBuilder [ %t1160, %merge63 ], [ %t2249, %merge66 ]
  %t2276 = phi double [ %t1161, %merge63 ], [ %t2251, %merge66 ]
  %t2277 = phi { i8**, i64 }* [ %t1162, %merge63 ], [ %t2254, %merge66 ]
  %t2278 = phi double [ %t1130, %merge63 ], [ %t2257, %merge66 ]
  %t2279 = phi { %MatchContext*, i64 }* [ %t1129, %merge63 ], [ %t2259, %merge66 ]
  store %PythonBuilder %t2275, %PythonBuilder* %l0
  store double %t2276, double* %l4
  store { i8**, i64 }* %t2277, { i8**, i64 }** %l1
  store double %t2278, double* %l6
  store { %MatchContext*, i64 }* %t2279, { %MatchContext*, i64 }** %l5
  %t2280 = load %PythonBuilder, %PythonBuilder* %l0
  %t2281 = load double, double* %l4
  %t2282 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2283 = load %PythonBuilder, %PythonBuilder* %l0
  %t2284 = load %PythonBuilder, %PythonBuilder* %l0
  %t2285 = load double, double* %l4
  %t2286 = load %PythonBuilder, %PythonBuilder* %l0
  %t2287 = load double, double* %l4
  %t2288 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2289 = load %PythonBuilder, %PythonBuilder* %l0
  %t2290 = load %PythonBuilder, %PythonBuilder* %l0
  %t2291 = load double, double* %l6
  %t2292 = load %PythonBuilder, %PythonBuilder* %l0
  %t2293 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2294 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2295 = load %PythonBuilder, %PythonBuilder* %l0
  %t2296 = load %PythonBuilder, %PythonBuilder* %l0
  %t2297 = load %PythonBuilder, %PythonBuilder* %l0
  %t2298 = load %PythonBuilder, %PythonBuilder* %l0
  %t2299 = load %PythonBuilder, %PythonBuilder* %l0
  %t2300 = load %PythonBuilder, %PythonBuilder* %l0
  %t2301 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2302 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2303 = load %PythonBuilder, %PythonBuilder* %l0
  %t2304 = load %PythonBuilder, %PythonBuilder* %l0
  %t2305 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2306 = load %PythonBuilder, %PythonBuilder* %l0
  %t2307 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2308 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge57
merge57:
  %t2309 = phi %PythonBuilder [ %t1064, %then55 ], [ %t2280, %merge60 ]
  %t2310 = phi double [ %t1066, %then55 ], [ %t2281, %merge60 ]
  %t2311 = phi { i8**, i64 }* [ %t1017, %then55 ], [ %t2282, %merge60 ]
  %t2312 = phi double [ %t1022, %then55 ], [ %t2291, %merge60 ]
  %t2313 = phi { %MatchContext*, i64 }* [ %t1021, %then55 ], [ %t2293, %merge60 ]
  store %PythonBuilder %t2309, %PythonBuilder* %l0
  store double %t2310, double* %l4
  store { i8**, i64 }* %t2311, { i8**, i64 }** %l1
  store double %t2312, double* %l6
  store { %MatchContext*, i64 }* %t2313, { %MatchContext*, i64 }** %l5
  %t2314 = load %PythonBuilder, %PythonBuilder* %l0
  %t2315 = load %PythonBuilder, %PythonBuilder* %l0
  %t2316 = load double, double* %l4
  %t2317 = load %PythonBuilder, %PythonBuilder* %l0
  %t2318 = load double, double* %l4
  %t2319 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2320 = load %PythonBuilder, %PythonBuilder* %l0
  %t2321 = load %PythonBuilder, %PythonBuilder* %l0
  %t2322 = load double, double* %l4
  %t2323 = load %PythonBuilder, %PythonBuilder* %l0
  %t2324 = load double, double* %l4
  %t2325 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2326 = load %PythonBuilder, %PythonBuilder* %l0
  %t2327 = load %PythonBuilder, %PythonBuilder* %l0
  %t2328 = load double, double* %l6
  %t2329 = load %PythonBuilder, %PythonBuilder* %l0
  %t2330 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2331 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2332 = load %PythonBuilder, %PythonBuilder* %l0
  %t2333 = load %PythonBuilder, %PythonBuilder* %l0
  %t2334 = load %PythonBuilder, %PythonBuilder* %l0
  %t2335 = load %PythonBuilder, %PythonBuilder* %l0
  %t2336 = load %PythonBuilder, %PythonBuilder* %l0
  %t2337 = load %PythonBuilder, %PythonBuilder* %l0
  %t2338 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2339 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2340 = load %PythonBuilder, %PythonBuilder* %l0
  %t2341 = load %PythonBuilder, %PythonBuilder* %l0
  %t2342 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2343 = load %PythonBuilder, %PythonBuilder* %l0
  %t2344 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2345 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge51
merge51:
  %t2346 = phi %PythonBuilder [ %t956, %merge54 ], [ %t2314, %merge57 ]
  %t2347 = phi double [ %t957, %merge54 ], [ %t2316, %merge57 ]
  %t2348 = phi { i8**, i64 }* [ %t958, %merge54 ], [ %t2319, %merge57 ]
  %t2349 = phi double [ %t926, %merge54 ], [ %t2328, %merge57 ]
  %t2350 = phi { %MatchContext*, i64 }* [ %t925, %merge54 ], [ %t2330, %merge57 ]
  store %PythonBuilder %t2346, %PythonBuilder* %l0
  store double %t2347, double* %l4
  store { i8**, i64 }* %t2348, { i8**, i64 }** %l1
  store double %t2349, double* %l6
  store { %MatchContext*, i64 }* %t2350, { %MatchContext*, i64 }** %l5
  %t2351 = load %PythonBuilder, %PythonBuilder* %l0
  %t2352 = load double, double* %l4
  %t2353 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2354 = load %PythonBuilder, %PythonBuilder* %l0
  %t2355 = load %PythonBuilder, %PythonBuilder* %l0
  %t2356 = load double, double* %l4
  %t2357 = load %PythonBuilder, %PythonBuilder* %l0
  %t2358 = load double, double* %l4
  %t2359 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2360 = load %PythonBuilder, %PythonBuilder* %l0
  %t2361 = load %PythonBuilder, %PythonBuilder* %l0
  %t2362 = load double, double* %l4
  %t2363 = load %PythonBuilder, %PythonBuilder* %l0
  %t2364 = load double, double* %l4
  %t2365 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2366 = load %PythonBuilder, %PythonBuilder* %l0
  %t2367 = load %PythonBuilder, %PythonBuilder* %l0
  %t2368 = load double, double* %l6
  %t2369 = load %PythonBuilder, %PythonBuilder* %l0
  %t2370 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2371 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2372 = load %PythonBuilder, %PythonBuilder* %l0
  %t2373 = load %PythonBuilder, %PythonBuilder* %l0
  %t2374 = load %PythonBuilder, %PythonBuilder* %l0
  %t2375 = load %PythonBuilder, %PythonBuilder* %l0
  %t2376 = load %PythonBuilder, %PythonBuilder* %l0
  %t2377 = load %PythonBuilder, %PythonBuilder* %l0
  %t2378 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2379 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2380 = load %PythonBuilder, %PythonBuilder* %l0
  %t2381 = load %PythonBuilder, %PythonBuilder* %l0
  %t2382 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2383 = load %PythonBuilder, %PythonBuilder* %l0
  %t2384 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2385 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge45
merge45:
  %t2386 = phi %PythonBuilder [ %t859, %merge48 ], [ %t2351, %merge51 ]
  %t2387 = phi { i8**, i64 }* [ %t860, %merge48 ], [ %t2353, %merge51 ]
  %t2388 = phi double [ %t827, %merge48 ], [ %t2352, %merge51 ]
  %t2389 = phi double [ %t829, %merge48 ], [ %t2368, %merge51 ]
  %t2390 = phi { %MatchContext*, i64 }* [ %t828, %merge48 ], [ %t2370, %merge51 ]
  store %PythonBuilder %t2386, %PythonBuilder* %l0
  store { i8**, i64 }* %t2387, { i8**, i64 }** %l1
  store double %t2388, double* %l4
  store double %t2389, double* %l6
  store { %MatchContext*, i64 }* %t2390, { %MatchContext*, i64 }** %l5
  %t2391 = load %PythonBuilder, %PythonBuilder* %l0
  %t2392 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2393 = load %PythonBuilder, %PythonBuilder* %l0
  %t2394 = load %PythonBuilder, %PythonBuilder* %l0
  %t2395 = load %PythonBuilder, %PythonBuilder* %l0
  %t2396 = load double, double* %l4
  %t2397 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2398 = load %PythonBuilder, %PythonBuilder* %l0
  %t2399 = load %PythonBuilder, %PythonBuilder* %l0
  %t2400 = load double, double* %l4
  %t2401 = load %PythonBuilder, %PythonBuilder* %l0
  %t2402 = load double, double* %l4
  %t2403 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2404 = load %PythonBuilder, %PythonBuilder* %l0
  %t2405 = load %PythonBuilder, %PythonBuilder* %l0
  %t2406 = load double, double* %l4
  %t2407 = load %PythonBuilder, %PythonBuilder* %l0
  %t2408 = load double, double* %l4
  %t2409 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2410 = load %PythonBuilder, %PythonBuilder* %l0
  %t2411 = load %PythonBuilder, %PythonBuilder* %l0
  %t2412 = load double, double* %l6
  %t2413 = load %PythonBuilder, %PythonBuilder* %l0
  %t2414 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2415 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2416 = load %PythonBuilder, %PythonBuilder* %l0
  %t2417 = load %PythonBuilder, %PythonBuilder* %l0
  %t2418 = load %PythonBuilder, %PythonBuilder* %l0
  %t2419 = load %PythonBuilder, %PythonBuilder* %l0
  %t2420 = load %PythonBuilder, %PythonBuilder* %l0
  %t2421 = load %PythonBuilder, %PythonBuilder* %l0
  %t2422 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2423 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2424 = load %PythonBuilder, %PythonBuilder* %l0
  %t2425 = load %PythonBuilder, %PythonBuilder* %l0
  %t2426 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2427 = load %PythonBuilder, %PythonBuilder* %l0
  %t2428 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2429 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge42
merge42:
  %t2430 = phi %PythonBuilder [ %t763, %then40 ], [ %t2391, %merge45 ]
  %t2431 = phi double [ %t765, %then40 ], [ %t2396, %merge45 ]
  %t2432 = phi { i8**, i64 }* [ %t729, %then40 ], [ %t2392, %merge45 ]
  %t2433 = phi double [ %t734, %then40 ], [ %t2412, %merge45 ]
  %t2434 = phi { %MatchContext*, i64 }* [ %t733, %then40 ], [ %t2414, %merge45 ]
  store %PythonBuilder %t2430, %PythonBuilder* %l0
  store double %t2431, double* %l4
  store { i8**, i64 }* %t2432, { i8**, i64 }** %l1
  store double %t2433, double* %l6
  store { %MatchContext*, i64 }* %t2434, { %MatchContext*, i64 }** %l5
  %t2435 = load %PythonBuilder, %PythonBuilder* %l0
  %t2436 = load %PythonBuilder, %PythonBuilder* %l0
  %t2437 = load double, double* %l4
  %t2438 = load %PythonBuilder, %PythonBuilder* %l0
  %t2439 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2440 = load %PythonBuilder, %PythonBuilder* %l0
  %t2441 = load %PythonBuilder, %PythonBuilder* %l0
  %t2442 = load %PythonBuilder, %PythonBuilder* %l0
  %t2443 = load double, double* %l4
  %t2444 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2445 = load %PythonBuilder, %PythonBuilder* %l0
  %t2446 = load %PythonBuilder, %PythonBuilder* %l0
  %t2447 = load double, double* %l4
  %t2448 = load %PythonBuilder, %PythonBuilder* %l0
  %t2449 = load double, double* %l4
  %t2450 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2451 = load %PythonBuilder, %PythonBuilder* %l0
  %t2452 = load %PythonBuilder, %PythonBuilder* %l0
  %t2453 = load double, double* %l4
  %t2454 = load %PythonBuilder, %PythonBuilder* %l0
  %t2455 = load double, double* %l4
  %t2456 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2457 = load %PythonBuilder, %PythonBuilder* %l0
  %t2458 = load %PythonBuilder, %PythonBuilder* %l0
  %t2459 = load double, double* %l6
  %t2460 = load %PythonBuilder, %PythonBuilder* %l0
  %t2461 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2462 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2463 = load %PythonBuilder, %PythonBuilder* %l0
  %t2464 = load %PythonBuilder, %PythonBuilder* %l0
  %t2465 = load %PythonBuilder, %PythonBuilder* %l0
  %t2466 = load %PythonBuilder, %PythonBuilder* %l0
  %t2467 = load %PythonBuilder, %PythonBuilder* %l0
  %t2468 = load %PythonBuilder, %PythonBuilder* %l0
  %t2469 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2470 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2471 = load %PythonBuilder, %PythonBuilder* %l0
  %t2472 = load %PythonBuilder, %PythonBuilder* %l0
  %t2473 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2474 = load %PythonBuilder, %PythonBuilder* %l0
  %t2475 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2476 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge31
merge31:
  %t2477 = phi double [ %t669, %merge34 ], [ %t538, %merge42 ]
  %t2478 = phi %PythonBuilder [ %t670, %merge34 ], [ %t2435, %merge42 ]
  %t2479 = phi double [ %t535, %merge34 ], [ %t2437, %merge42 ]
  %t2480 = phi { i8**, i64 }* [ %t532, %merge34 ], [ %t2439, %merge42 ]
  %t2481 = phi double [ %t537, %merge34 ], [ %t2459, %merge42 ]
  %t2482 = phi { %MatchContext*, i64 }* [ %t536, %merge34 ], [ %t2461, %merge42 ]
  store double %t2477, double* %l7
  store %PythonBuilder %t2478, %PythonBuilder* %l0
  store double %t2479, double* %l4
  store { i8**, i64 }* %t2480, { i8**, i64 }** %l1
  store double %t2481, double* %l6
  store { %MatchContext*, i64 }* %t2482, { %MatchContext*, i64 }** %l5
  %t2483 = load double, double* %l7
  %t2484 = load %PythonBuilder, %PythonBuilder* %l0
  %t2485 = load %PythonBuilder, %PythonBuilder* %l0
  %t2486 = load %PythonBuilder, %PythonBuilder* %l0
  %t2487 = load double, double* %l4
  %t2488 = load %PythonBuilder, %PythonBuilder* %l0
  %t2489 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2490 = load %PythonBuilder, %PythonBuilder* %l0
  %t2491 = load %PythonBuilder, %PythonBuilder* %l0
  %t2492 = load %PythonBuilder, %PythonBuilder* %l0
  %t2493 = load double, double* %l4
  %t2494 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2495 = load %PythonBuilder, %PythonBuilder* %l0
  %t2496 = load %PythonBuilder, %PythonBuilder* %l0
  %t2497 = load double, double* %l4
  %t2498 = load %PythonBuilder, %PythonBuilder* %l0
  %t2499 = load double, double* %l4
  %t2500 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2501 = load %PythonBuilder, %PythonBuilder* %l0
  %t2502 = load %PythonBuilder, %PythonBuilder* %l0
  %t2503 = load double, double* %l4
  %t2504 = load %PythonBuilder, %PythonBuilder* %l0
  %t2505 = load double, double* %l4
  %t2506 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2507 = load %PythonBuilder, %PythonBuilder* %l0
  %t2508 = load %PythonBuilder, %PythonBuilder* %l0
  %t2509 = load double, double* %l6
  %t2510 = load %PythonBuilder, %PythonBuilder* %l0
  %t2511 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2512 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2513 = load %PythonBuilder, %PythonBuilder* %l0
  %t2514 = load %PythonBuilder, %PythonBuilder* %l0
  %t2515 = load %PythonBuilder, %PythonBuilder* %l0
  %t2516 = load %PythonBuilder, %PythonBuilder* %l0
  %t2517 = load %PythonBuilder, %PythonBuilder* %l0
  %t2518 = load %PythonBuilder, %PythonBuilder* %l0
  %t2519 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2520 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2521 = load %PythonBuilder, %PythonBuilder* %l0
  %t2522 = load %PythonBuilder, %PythonBuilder* %l0
  %t2523 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2524 = load %PythonBuilder, %PythonBuilder* %l0
  %t2525 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2526 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge23
merge23:
  %t2527 = phi %PythonBuilder [ %t472, %merge26 ], [ %t2484, %merge31 ]
  %t2528 = phi double [ %t473, %merge26 ], [ %t2483, %merge31 ]
  %t2529 = phi double [ %t377, %merge26 ], [ %t2487, %merge31 ]
  %t2530 = phi { i8**, i64 }* [ %t374, %merge26 ], [ %t2489, %merge31 ]
  %t2531 = phi double [ %t379, %merge26 ], [ %t2509, %merge31 ]
  %t2532 = phi { %MatchContext*, i64 }* [ %t378, %merge26 ], [ %t2511, %merge31 ]
  store %PythonBuilder %t2527, %PythonBuilder* %l0
  store double %t2528, double* %l7
  store double %t2529, double* %l4
  store { i8**, i64 }* %t2530, { i8**, i64 }** %l1
  store double %t2531, double* %l6
  store { %MatchContext*, i64 }* %t2532, { %MatchContext*, i64 }** %l5
  %t2533 = load %PythonBuilder, %PythonBuilder* %l0
  %t2534 = load double, double* %l7
  %t2535 = load double, double* %l7
  %t2536 = load %PythonBuilder, %PythonBuilder* %l0
  %t2537 = load %PythonBuilder, %PythonBuilder* %l0
  %t2538 = load %PythonBuilder, %PythonBuilder* %l0
  %t2539 = load double, double* %l4
  %t2540 = load %PythonBuilder, %PythonBuilder* %l0
  %t2541 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2542 = load %PythonBuilder, %PythonBuilder* %l0
  %t2543 = load %PythonBuilder, %PythonBuilder* %l0
  %t2544 = load %PythonBuilder, %PythonBuilder* %l0
  %t2545 = load double, double* %l4
  %t2546 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2547 = load %PythonBuilder, %PythonBuilder* %l0
  %t2548 = load %PythonBuilder, %PythonBuilder* %l0
  %t2549 = load double, double* %l4
  %t2550 = load %PythonBuilder, %PythonBuilder* %l0
  %t2551 = load double, double* %l4
  %t2552 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2553 = load %PythonBuilder, %PythonBuilder* %l0
  %t2554 = load %PythonBuilder, %PythonBuilder* %l0
  %t2555 = load double, double* %l4
  %t2556 = load %PythonBuilder, %PythonBuilder* %l0
  %t2557 = load double, double* %l4
  %t2558 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2559 = load %PythonBuilder, %PythonBuilder* %l0
  %t2560 = load %PythonBuilder, %PythonBuilder* %l0
  %t2561 = load double, double* %l6
  %t2562 = load %PythonBuilder, %PythonBuilder* %l0
  %t2563 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2564 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2565 = load %PythonBuilder, %PythonBuilder* %l0
  %t2566 = load %PythonBuilder, %PythonBuilder* %l0
  %t2567 = load %PythonBuilder, %PythonBuilder* %l0
  %t2568 = load %PythonBuilder, %PythonBuilder* %l0
  %t2569 = load %PythonBuilder, %PythonBuilder* %l0
  %t2570 = load %PythonBuilder, %PythonBuilder* %l0
  %t2571 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2572 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2573 = load %PythonBuilder, %PythonBuilder* %l0
  %t2574 = load %PythonBuilder, %PythonBuilder* %l0
  %t2575 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2576 = load %PythonBuilder, %PythonBuilder* %l0
  %t2577 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2578 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge12
merge12:
  %t2579 = phi %PythonBuilder [ %t313, %merge15 ], [ %t2533, %merge23 ]
  %t2580 = phi double [ %t315, %merge15 ], [ %t2534, %merge23 ]
  %t2581 = phi double [ %t176, %merge15 ], [ %t2539, %merge23 ]
  %t2582 = phi { i8**, i64 }* [ %t173, %merge15 ], [ %t2541, %merge23 ]
  %t2583 = phi double [ %t178, %merge15 ], [ %t2561, %merge23 ]
  %t2584 = phi { %MatchContext*, i64 }* [ %t177, %merge15 ], [ %t2563, %merge23 ]
  store %PythonBuilder %t2579, %PythonBuilder* %l0
  store double %t2580, double* %l7
  store double %t2581, double* %l4
  store { i8**, i64 }* %t2582, { i8**, i64 }** %l1
  store double %t2583, double* %l6
  store { %MatchContext*, i64 }* %t2584, { %MatchContext*, i64 }** %l5
  %t2585 = load double, double* %l7
  %t2586 = sitofp i64 1 to double
  %t2587 = fadd double %t2585, %t2586
  store double %t2587, double* %l7
  br label %loop.latch6
loop.latch6:
  %t2588 = load %PythonBuilder, %PythonBuilder* %l0
  %t2589 = load double, double* %l7
  %t2590 = load double, double* %l4
  %t2591 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2592 = load double, double* %l6
  %t2593 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  br label %loop.header4
afterloop7:
  %t2600 = load %PythonBuilder, %PythonBuilder* %l0
  %t2601 = load double, double* %l7
  %t2602 = load double, double* %l4
  %t2603 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2604 = load double, double* %l6
  %t2605 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2606 = load %PythonBuilder, %PythonBuilder* %l0
  %t2607 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2608 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2609 = load i8*, i8** %l3
  %t2610 = load double, double* %l4
  %t2611 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2612 = load double, double* %l6
  %t2613 = load double, double* %l7
  br label %loop.header111
loop.header111:
  %t2665 = phi %PythonBuilder [ %t2606, %afterloop7 ], [ %t2662, %loop.latch113 ]
  %t2666 = phi { i8**, i64 }* [ %t2607, %afterloop7 ], [ %t2663, %loop.latch113 ]
  %t2667 = phi { %MatchContext*, i64 }* [ %t2611, %afterloop7 ], [ %t2664, %loop.latch113 ]
  store %PythonBuilder %t2665, %PythonBuilder* %l0
  store { i8**, i64 }* %t2666, { i8**, i64 }** %l1
  store { %MatchContext*, i64 }* %t2667, { %MatchContext*, i64 }** %l5
  br label %loop.body112
loop.body112:
  %t2614 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2615 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t2614
  %t2616 = extractvalue { %MatchContext*, i64 } %t2615, 1
  %t2617 = icmp eq i64 %t2616, 0
  %t2618 = load %PythonBuilder, %PythonBuilder* %l0
  %t2619 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2620 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2621 = load i8*, i8** %l3
  %t2622 = load double, double* %l4
  %t2623 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2624 = load double, double* %l6
  %t2625 = load double, double* %l7
  br i1 %t2617, label %then115, label %merge116
then115:
  br label %afterloop114
merge116:
  %t2626 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2627 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t2626
  %t2628 = extractvalue { %MatchContext*, i64 } %t2627, 1
  %t2629 = sub i64 %t2628, 1
  store i64 %t2629, i64* %l38
  %t2630 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2631 = load i64, i64* %l38
  %t2632 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t2630
  %t2633 = extractvalue { %MatchContext*, i64 } %t2632, 0
  %t2634 = extractvalue { %MatchContext*, i64 } %t2632, 1
  %t2635 = icmp uge i64 %t2631, %t2634
  ; bounds check: %t2635 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t2631, i64 %t2634)
  %t2636 = getelementptr %MatchContext, %MatchContext* %t2633, i64 %t2631
  %t2637 = load %MatchContext, %MatchContext* %t2636
  store %MatchContext %t2637, %MatchContext* %l39
  %t2638 = load %MatchContext, %MatchContext* %l39
  %t2639 = extractvalue %MatchContext %t2638, 2
  %t2640 = load %PythonBuilder, %PythonBuilder* %l0
  %t2641 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2642 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2643 = load i8*, i8** %l3
  %t2644 = load double, double* %l4
  %t2645 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2646 = load double, double* %l6
  %t2647 = load double, double* %l7
  %t2648 = load i64, i64* %l38
  %t2649 = load %MatchContext, %MatchContext* %l39
  br i1 %t2639, label %then117, label %merge118
then117:
  %t2650 = load %PythonBuilder, %PythonBuilder* %l0
  %t2651 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t2650)
  store %PythonBuilder %t2651, %PythonBuilder* %l0
  %t2652 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge118
merge118:
  %t2653 = phi %PythonBuilder [ %t2652, %then117 ], [ %t2640, %merge116 ]
  store %PythonBuilder %t2653, %PythonBuilder* %l0
  %t2654 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2655 = extractvalue %NativeFunction %function, 0
  %s2656 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.len29.h1409903806, i32 0, i32 0
  %t2657 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t2654, i8* %t2655, i8* %s2656)
  store { i8**, i64 }* %t2657, { i8**, i64 }** %l1
  %t2658 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2659 = load i64, i64* %l38
  %t2660 = sitofp i64 %t2659 to double
  %t2661 = call { %MatchContext*, i64 }* @truncate_match_contexts({ %MatchContext*, i64 }* %t2658, double %t2660)
  store { %MatchContext*, i64 }* %t2661, { %MatchContext*, i64 }** %l5
  br label %loop.latch113
loop.latch113:
  %t2662 = load %PythonBuilder, %PythonBuilder* %l0
  %t2663 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2664 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  br label %loop.header111
afterloop114:
  %t2668 = load %PythonBuilder, %PythonBuilder* %l0
  %t2669 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2670 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2671 = load %PythonBuilder, %PythonBuilder* %l0
  %t2672 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2673 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2674 = load i8*, i8** %l3
  %t2675 = load double, double* %l4
  %t2676 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2677 = load double, double* %l6
  %t2678 = load double, double* %l7
  br label %loop.header119
loop.header119:
  %t2702 = phi %PythonBuilder [ %t2671, %afterloop114 ], [ %t2699, %loop.latch121 ]
  %t2703 = phi double [ %t2675, %afterloop114 ], [ %t2700, %loop.latch121 ]
  %t2704 = phi { i8**, i64 }* [ %t2672, %afterloop114 ], [ %t2701, %loop.latch121 ]
  store %PythonBuilder %t2702, %PythonBuilder* %l0
  store double %t2703, double* %l4
  store { i8**, i64 }* %t2704, { i8**, i64 }** %l1
  br label %loop.body120
loop.body120:
  %t2679 = load double, double* %l4
  %t2680 = sitofp i64 0 to double
  %t2681 = fcmp ole double %t2679, %t2680
  %t2682 = load %PythonBuilder, %PythonBuilder* %l0
  %t2683 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2684 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2685 = load i8*, i8** %l3
  %t2686 = load double, double* %l4
  %t2687 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2688 = load double, double* %l6
  %t2689 = load double, double* %l7
  br i1 %t2681, label %then123, label %merge124
then123:
  br label %afterloop122
merge124:
  %t2690 = load %PythonBuilder, %PythonBuilder* %l0
  %t2691 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t2690)
  store %PythonBuilder %t2691, %PythonBuilder* %l0
  %t2692 = load double, double* %l4
  %t2693 = sitofp i64 1 to double
  %t2694 = fsub double %t2692, %t2693
  store double %t2694, double* %l4
  %t2695 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2696 = extractvalue %NativeFunction %function, 0
  %s2697 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.len31.h1736570074, i32 0, i32 0
  %t2698 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t2695, i8* %t2696, i8* %s2697)
  store { i8**, i64 }* %t2698, { i8**, i64 }** %l1
  br label %loop.latch121
loop.latch121:
  %t2699 = load %PythonBuilder, %PythonBuilder* %l0
  %t2700 = load double, double* %l4
  %t2701 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %loop.header119
afterloop122:
  %t2705 = load %PythonBuilder, %PythonBuilder* %l0
  %t2706 = load double, double* %l4
  %t2707 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2708 = load %PythonBuilder, %PythonBuilder* %l0
  %t2709 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t2708)
  store %PythonBuilder %t2709, %PythonBuilder* %l0
  %t2710 = load %PythonBuilder, %PythonBuilder* %l0
  %t2711 = insertvalue %PythonFunctionEmission undef, %PythonBuilder %t2710, 0
  %t2712 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2713 = insertvalue %PythonFunctionEmission %t2711, { i8**, i64 }* %t2712, 1
  ret %PythonFunctionEmission %t2713
}

define { %MatchContext*, i64 }* @append_match_context({ %MatchContext*, i64 }* %values, %MatchContext %value) {
block.entry:
  %t0 = call noalias i8* @malloc(i64 24)
  %t1 = bitcast i8* %t0 to %MatchContext*
  store %MatchContext %value, %MatchContext* %t1
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
  %t15 = bitcast { %MatchContext*, i64 }* %values to { i8**, i64 }*
  %t16 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t15, { i8**, i64 }* %t12)
  %t17 = bitcast { i8**, i64 }* %t16 to { %MatchContext*, i64 }*
  ret { %MatchContext*, i64 }* %t17
}

define { %MatchContext*, i64 }* @replace_match_context({ %MatchContext*, i64 }* %values, double %index, %MatchContext %replacement) {
block.entry:
  %l0 = alloca { %MatchContext*, i64 }*
  %l1 = alloca double
  %t0 = getelementptr [0 x %MatchContext], [0 x %MatchContext]* null, i32 1
  %t1 = ptrtoint [0 x %MatchContext]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %MatchContext*
  %t6 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* null, i32 1
  %t7 = ptrtoint { %MatchContext*, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { %MatchContext*, i64 }*
  %t10 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t9, i32 0, i32 0
  store %MatchContext* %t5, %MatchContext** %t10
  %t11 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { %MatchContext*, i64 }* %t9, { %MatchContext*, i64 }** %l0
  %t12 = sitofp i64 0 to double
  store double %t12, double* %l1
  %t13 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t14 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t46 = phi { %MatchContext*, i64 }* [ %t13, %block.entry ], [ %t44, %loop.latch2 ]
  %t47 = phi double [ %t14, %block.entry ], [ %t45, %loop.latch2 ]
  store { %MatchContext*, i64 }* %t46, { %MatchContext*, i64 }** %l0
  store double %t47, double* %l1
  br label %loop.body1
loop.body1:
  %t15 = load double, double* %l1
  %t16 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %values
  %t17 = extractvalue { %MatchContext*, i64 } %t16, 1
  %t18 = sitofp i64 %t17 to double
  %t19 = fcmp oge double %t15, %t18
  %t20 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t21 = load double, double* %l1
  br i1 %t19, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t22 = load double, double* %l1
  %t23 = fcmp oeq double %t22, %index
  %t24 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t25 = load double, double* %l1
  br i1 %t23, label %then6, label %else7
then6:
  %t26 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t27 = call { %MatchContext*, i64 }* @append_match_context({ %MatchContext*, i64 }* %t26, %MatchContext %replacement)
  store { %MatchContext*, i64 }* %t27, { %MatchContext*, i64 }** %l0
  %t28 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  br label %merge8
else7:
  %t29 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t30 = load double, double* %l1
  %t31 = fptosi double %t30 to i64
  %t32 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %values
  %t33 = extractvalue { %MatchContext*, i64 } %t32, 0
  %t34 = extractvalue { %MatchContext*, i64 } %t32, 1
  %t35 = icmp uge i64 %t31, %t34
  ; bounds check: %t35 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t31, i64 %t34)
  %t36 = getelementptr %MatchContext, %MatchContext* %t33, i64 %t31
  %t37 = load %MatchContext, %MatchContext* %t36
  %t38 = call { %MatchContext*, i64 }* @append_match_context({ %MatchContext*, i64 }* %t29, %MatchContext %t37)
  store { %MatchContext*, i64 }* %t38, { %MatchContext*, i64 }** %l0
  %t39 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  br label %merge8
merge8:
  %t40 = phi { %MatchContext*, i64 }* [ %t28, %then6 ], [ %t39, %else7 ]
  store { %MatchContext*, i64 }* %t40, { %MatchContext*, i64 }** %l0
  %t41 = load double, double* %l1
  %t42 = sitofp i64 1 to double
  %t43 = fadd double %t41, %t42
  store double %t43, double* %l1
  br label %loop.latch2
loop.latch2:
  %t44 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t45 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t48 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t49 = load double, double* %l1
  %t50 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  ret { %MatchContext*, i64 }* %t50
}

define { %MatchContext*, i64 }* @truncate_match_contexts({ %MatchContext*, i64 }* %values, double %end_index) {
block.entry:
  %l0 = alloca { %MatchContext*, i64 }*
  %l1 = alloca double
  %t0 = sitofp i64 0 to double
  %t1 = fcmp ole double %end_index, %t0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = getelementptr [0 x %MatchContext], [0 x %MatchContext]* null, i32 1
  %t3 = ptrtoint [0 x %MatchContext]* %t2 to i64
  %t4 = icmp eq i64 %t3, 0
  %t5 = select i1 %t4, i64 1, i64 %t3
  %t6 = call i8* @malloc(i64 %t5)
  %t7 = bitcast i8* %t6 to %MatchContext*
  %t8 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* null, i32 1
  %t9 = ptrtoint { %MatchContext*, i64 }* %t8 to i64
  %t10 = call i8* @malloc(i64 %t9)
  %t11 = bitcast i8* %t10 to { %MatchContext*, i64 }*
  %t12 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t11, i32 0, i32 0
  store %MatchContext* %t7, %MatchContext** %t12
  %t13 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t11, i32 0, i32 1
  store i64 0, i64* %t13
  ret { %MatchContext*, i64 }* %t11
merge1:
  %t14 = getelementptr [0 x %MatchContext], [0 x %MatchContext]* null, i32 1
  %t15 = ptrtoint [0 x %MatchContext]* %t14 to i64
  %t16 = icmp eq i64 %t15, 0
  %t17 = select i1 %t16, i64 1, i64 %t15
  %t18 = call i8* @malloc(i64 %t17)
  %t19 = bitcast i8* %t18 to %MatchContext*
  %t20 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* null, i32 1
  %t21 = ptrtoint { %MatchContext*, i64 }* %t20 to i64
  %t22 = call i8* @malloc(i64 %t21)
  %t23 = bitcast i8* %t22 to { %MatchContext*, i64 }*
  %t24 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t23, i32 0, i32 0
  store %MatchContext* %t19, %MatchContext** %t24
  %t25 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t23, i32 0, i32 1
  store i64 0, i64* %t25
  store { %MatchContext*, i64 }* %t23, { %MatchContext*, i64 }** %l0
  %t26 = sitofp i64 0 to double
  store double %t26, double* %l1
  %t27 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t28 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t48 = phi { %MatchContext*, i64 }* [ %t27, %merge1 ], [ %t46, %loop.latch4 ]
  %t49 = phi double [ %t28, %merge1 ], [ %t47, %loop.latch4 ]
  store { %MatchContext*, i64 }* %t48, { %MatchContext*, i64 }** %l0
  store double %t49, double* %l1
  br label %loop.body3
loop.body3:
  %t29 = load double, double* %l1
  %t30 = fcmp oge double %t29, %end_index
  %t31 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t32 = load double, double* %l1
  br i1 %t30, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t33 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t34 = load double, double* %l1
  %t35 = fptosi double %t34 to i64
  %t36 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %values
  %t37 = extractvalue { %MatchContext*, i64 } %t36, 0
  %t38 = extractvalue { %MatchContext*, i64 } %t36, 1
  %t39 = icmp uge i64 %t35, %t38
  ; bounds check: %t39 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t35, i64 %t38)
  %t40 = getelementptr %MatchContext, %MatchContext* %t37, i64 %t35
  %t41 = load %MatchContext, %MatchContext* %t40
  %t42 = call { %MatchContext*, i64 }* @append_match_context({ %MatchContext*, i64 }* %t33, %MatchContext %t41)
  store { %MatchContext*, i64 }* %t42, { %MatchContext*, i64 }** %l0
  %t43 = load double, double* %l1
  %t44 = sitofp i64 1 to double
  %t45 = fadd double %t43, %t44
  store double %t45, double* %l1
  br label %loop.latch4
loop.latch4:
  %t46 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t47 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t50 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t51 = load double, double* %l1
  %t52 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  ret { %MatchContext*, i64 }* %t52
}

define i8* @generate_match_subject_name(double %counter) {
block.entry:
  %s0 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h1077944870, i32 0, i32 0
  %t1 = call i8* @number_to_string(double %counter)
  %t2 = call i8* @sailfin_runtime_string_concat(i8* %s0, i8* %t1)
  ret i8* %t2
}

define %LoweredCaseCondition @lower_match_case_condition(i8* %subject_name, i8* %pattern, i8* %guard) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca i8*
  %l4 = alloca i8*
  %l5 = alloca i8*
  %l6 = alloca i1
  %l7 = alloca i8*
  %t0 = call i8* @trim_text(i8* %pattern)
  store i8* %t0, i8** %l0
  store i8* null, i8** %l1
  %t1 = icmp ne i8* %guard, null
  %t2 = load i8*, i8** %l0
  %t3 = load i8*, i8** %l1
  br i1 %t1, label %then0, label %merge1
then0:
  %t4 = call i8* @trim_text(i8* %guard)
  store i8* %t4, i8** %l2
  %t5 = load i8*, i8** %l2
  %t6 = call i64 @sailfin_runtime_string_length(i8* %t5)
  %t7 = icmp sgt i64 %t6, 0
  %t8 = load i8*, i8** %l0
  %t9 = load i8*, i8** %l1
  %t10 = load i8*, i8** %l2
  br i1 %t7, label %then2, label %merge3
then2:
  %t11 = load i8*, i8** %l2
  store i8* %t11, i8** %l1
  %t12 = load i8*, i8** %l1
  br label %merge3
merge3:
  %t13 = phi i8* [ %t12, %then2 ], [ %t9, %then0 ]
  store i8* %t13, i8** %l1
  %t14 = load i8*, i8** %l1
  br label %merge1
merge1:
  %t15 = phi i8* [ %t14, %merge3 ], [ %t3, %block.entry ]
  store i8* %t15, i8** %l1
  %t17 = load i8*, i8** %l0
  %t18 = call i64 @sailfin_runtime_string_length(i8* %t17)
  %t19 = icmp eq i64 %t18, 0
  br label %logical_or_entry_16

logical_or_entry_16:
  br i1 %t19, label %logical_or_merge_16, label %logical_or_right_16

logical_or_right_16:
  %t20 = load i8*, i8** %l0
  %t21 = load i8, i8* %t20
  %t22 = icmp eq i8 %t21, 95
  br label %logical_or_right_end_16

logical_or_right_end_16:
  br label %logical_or_merge_16

logical_or_merge_16:
  %t23 = phi i1 [ true, %logical_or_entry_16 ], [ %t22, %logical_or_right_end_16 ]
  %t24 = load i8*, i8** %l0
  %t25 = load i8*, i8** %l1
  br i1 %t23, label %then4, label %merge5
then4:
  %t26 = load i8*, i8** %l1
  %t27 = icmp eq i8* %t26, null
  %t28 = load i8*, i8** %l0
  %t29 = load i8*, i8** %l1
  br i1 %t27, label %then6, label %merge7
then6:
  %s30 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h237997259, i32 0, i32 0
  %t31 = insertvalue %LoweredCaseCondition undef, i8* %s30, 0
  %t32 = insertvalue %LoweredCaseCondition %t31, i1 1, 1
  %t33 = insertvalue %LoweredCaseCondition %t32, i1 0, 2
  ret %LoweredCaseCondition %t33
merge7:
  %t34 = load i8*, i8** %l1
  %t35 = call i8* @lower_expression(i8* %t34)
  store i8* %t35, i8** %l3
  %t36 = load i8*, i8** %l3
  %t37 = insertvalue %LoweredCaseCondition undef, i8* %t36, 0
  %t38 = insertvalue %LoweredCaseCondition %t37, i1 0, 1
  %t39 = insertvalue %LoweredCaseCondition %t38, i1 1, 2
  ret %LoweredCaseCondition %t39
merge5:
  %t40 = load i8*, i8** %l0
  %t41 = call i8* @lower_expression(i8* %t40)
  store i8* %t41, i8** %l4
  %s42 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h174361445, i32 0, i32 0
  %t43 = call i8* @sailfin_runtime_string_concat(i8* %subject_name, i8* %s42)
  %t44 = load i8*, i8** %l4
  %t45 = call i8* @sailfin_runtime_string_concat(i8* %t43, i8* %t44)
  store i8* %t45, i8** %l5
  store i1 0, i1* %l6
  %t46 = load i8*, i8** %l1
  %t47 = icmp ne i8* %t46, null
  %t48 = load i8*, i8** %l0
  %t49 = load i8*, i8** %l1
  %t50 = load i8*, i8** %l4
  %t51 = load i8*, i8** %l5
  %t52 = load i1, i1* %l6
  br i1 %t47, label %then8, label %merge9
then8:
  %t53 = load i8*, i8** %l1
  %t54 = call i8* @lower_expression(i8* %t53)
  store i8* %t54, i8** %l7
  %t55 = load i8*, i8** %l5
  %t56 = alloca [2 x i8], align 1
  %t57 = getelementptr [2 x i8], [2 x i8]* %t56, i32 0, i32 0
  store i8 40, i8* %t57
  %t58 = getelementptr [2 x i8], [2 x i8]* %t56, i32 0, i32 1
  store i8 0, i8* %t58
  %t59 = getelementptr [2 x i8], [2 x i8]* %t56, i32 0, i32 0
  %t60 = call i8* @sailfin_runtime_string_concat(i8* %t59, i8* %t55)
  %s61 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h1543377657, i32 0, i32 0
  %t62 = call i8* @sailfin_runtime_string_concat(i8* %t60, i8* %s61)
  %t63 = load i8*, i8** %l7
  %t64 = call i8* @sailfin_runtime_string_concat(i8* %t62, i8* %t63)
  %t65 = alloca [2 x i8], align 1
  %t66 = getelementptr [2 x i8], [2 x i8]* %t65, i32 0, i32 0
  store i8 41, i8* %t66
  %t67 = getelementptr [2 x i8], [2 x i8]* %t65, i32 0, i32 1
  store i8 0, i8* %t67
  %t68 = getelementptr [2 x i8], [2 x i8]* %t65, i32 0, i32 0
  %t69 = call i8* @sailfin_runtime_string_concat(i8* %t64, i8* %t68)
  store i8* %t69, i8** %l5
  store i1 1, i1* %l6
  %t70 = load i8*, i8** %l5
  %t71 = load i1, i1* %l6
  br label %merge9
merge9:
  %t72 = phi i8* [ %t70, %then8 ], [ %t51, %merge5 ]
  %t73 = phi i1 [ %t71, %then8 ], [ %t52, %merge5 ]
  store i8* %t72, i8** %l5
  store i1 %t73, i1* %l6
  %t74 = load i8*, i8** %l5
  %t75 = insertvalue %LoweredCaseCondition undef, i8* %t74, 0
  %t76 = insertvalue %LoweredCaseCondition %t75, i1 0, 1
  %t77 = load i1, i1* %l6
  %t78 = insertvalue %LoweredCaseCondition %t76, i1 %t77, 2
  ret %LoweredCaseCondition %t78
}

define i8* @number_to_string(double %value) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca i8*
  %t0 = sitofp i64 0 to double
  %t1 = fcmp oeq double %value, %t0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = alloca [2 x i8], align 1
  %t3 = getelementptr [2 x i8], [2 x i8]* %t2, i32 0, i32 0
  store i8 48, i8* %t3
  %t4 = getelementptr [2 x i8], [2 x i8]* %t2, i32 0, i32 1
  store i8 0, i8* %t4
  %t5 = getelementptr [2 x i8], [2 x i8]* %t2, i32 0, i32 0
  ret i8* %t5
merge1:
  %s6 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h626550212, i32 0, i32 0
  store i8* %s6, i8** %l0
  store double %value, double* %l1
  %s7 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s7, i8** %l2
  %t8 = load i8*, i8** %l0
  %t9 = load double, double* %l1
  %t10 = load i8*, i8** %l2
  br label %loop.header2
loop.header2:
  %t59 = phi i8* [ %t10, %merge1 ], [ %t57, %loop.latch4 ]
  %t60 = phi double [ %t9, %merge1 ], [ %t58, %loop.latch4 ]
  store i8* %t59, i8** %l2
  store double %t60, double* %l1
  br label %loop.body3
loop.body3:
  %t11 = load double, double* %l1
  %t12 = sitofp i64 0 to double
  %t13 = fcmp ole double %t11, %t12
  %t14 = load i8*, i8** %l0
  %t15 = load double, double* %l1
  %t16 = load i8*, i8** %l2
  br i1 %t13, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t17 = load double, double* %l1
  store double %t17, double* %l3
  %t18 = sitofp i64 0 to double
  store double %t18, double* %l4
  %t19 = load i8*, i8** %l0
  %t20 = load double, double* %l1
  %t21 = load i8*, i8** %l2
  %t22 = load double, double* %l3
  %t23 = load double, double* %l4
  br label %loop.header8
loop.header8:
  %t40 = phi double [ %t22, %merge7 ], [ %t38, %loop.latch10 ]
  %t41 = phi double [ %t23, %merge7 ], [ %t39, %loop.latch10 ]
  store double %t40, double* %l3
  store double %t41, double* %l4
  br label %loop.body9
loop.body9:
  %t24 = load double, double* %l3
  %t25 = sitofp i64 10 to double
  %t26 = fcmp olt double %t24, %t25
  %t27 = load i8*, i8** %l0
  %t28 = load double, double* %l1
  %t29 = load i8*, i8** %l2
  %t30 = load double, double* %l3
  %t31 = load double, double* %l4
  br i1 %t26, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t32 = load double, double* %l3
  %t33 = sitofp i64 10 to double
  %t34 = fsub double %t32, %t33
  store double %t34, double* %l3
  %t35 = load double, double* %l4
  %t36 = sitofp i64 1 to double
  %t37 = fadd double %t35, %t36
  store double %t37, double* %l4
  br label %loop.latch10
loop.latch10:
  %t38 = load double, double* %l3
  %t39 = load double, double* %l4
  br label %loop.header8
afterloop11:
  %t42 = load double, double* %l3
  %t43 = load double, double* %l4
  %t44 = load double, double* %l3
  store double %t44, double* %l5
  %t45 = load i8*, i8** %l0
  %t46 = load double, double* %l5
  %t47 = load double, double* %l5
  %t48 = sitofp i64 1 to double
  %t49 = fadd double %t47, %t48
  %t50 = fptosi double %t46 to i64
  %t51 = fptosi double %t49 to i64
  %t52 = call i8* @sailfin_runtime_substring(i8* %t45, i64 %t50, i64 %t51)
  store i8* %t52, i8** %l6
  %t53 = load i8*, i8** %l6
  %t54 = load i8*, i8** %l2
  %t55 = call i8* @sailfin_runtime_string_concat(i8* %t53, i8* %t54)
  store i8* %t55, i8** %l2
  %t56 = load double, double* %l4
  store double %t56, double* %l1
  br label %loop.latch4
loop.latch4:
  %t57 = load i8*, i8** %l2
  %t58 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t61 = load i8*, i8** %l2
  %t62 = load double, double* %l1
  %t63 = load i8*, i8** %l2
  ret i8* %t63
}

define { i8**, i64 }* @render_python_parameters({ %NativeParameter*, i64 }* %parameters) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca %NativeParameter
  %l3 = alloca i8*
  %t0 = load { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %parameters
  %t1 = extractvalue { %NativeParameter*, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
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
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t29 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t70 = phi { i8**, i64 }* [ %t28, %merge1 ], [ %t68, %loop.latch4 ]
  %t71 = phi double [ %t29, %merge1 ], [ %t69, %loop.latch4 ]
  store { i8**, i64 }* %t70, { i8**, i64 }** %l0
  store double %t71, double* %l1
  br label %loop.body3
loop.body3:
  %t30 = load double, double* %l1
  %t31 = load { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %parameters
  %t32 = extractvalue { %NativeParameter*, i64 } %t31, 1
  %t33 = sitofp i64 %t32 to double
  %t34 = fcmp oge double %t30, %t33
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t36 = load double, double* %l1
  br i1 %t34, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t37 = load double, double* %l1
  %t38 = fptosi double %t37 to i64
  %t39 = load { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %parameters
  %t40 = extractvalue { %NativeParameter*, i64 } %t39, 0
  %t41 = extractvalue { %NativeParameter*, i64 } %t39, 1
  %t42 = icmp uge i64 %t38, %t41
  ; bounds check: %t42 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t38, i64 %t41)
  %t43 = getelementptr %NativeParameter, %NativeParameter* %t40, i64 %t38
  %t44 = load %NativeParameter, %NativeParameter* %t43
  store %NativeParameter %t44, %NativeParameter* %l2
  %t45 = load %NativeParameter, %NativeParameter* %l2
  %t46 = extractvalue %NativeParameter %t45, 0
  store i8* %t46, i8** %l3
  %t47 = load %NativeParameter, %NativeParameter* %l2
  %t48 = extractvalue %NativeParameter %t47, 3
  %t49 = icmp ne i8* %t48, null
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t51 = load double, double* %l1
  %t52 = load %NativeParameter, %NativeParameter* %l2
  %t53 = load i8*, i8** %l3
  br i1 %t49, label %then8, label %merge9
then8:
  %t54 = load i8*, i8** %l3
  %s55 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087691079, i32 0, i32 0
  %t56 = call i8* @sailfin_runtime_string_concat(i8* %t54, i8* %s55)
  %t57 = load %NativeParameter, %NativeParameter* %l2
  %t58 = extractvalue %NativeParameter %t57, 3
  %t59 = call i8* @sailfin_runtime_string_concat(i8* %t56, i8* %t58)
  store i8* %t59, i8** %l3
  %t60 = load i8*, i8** %l3
  br label %merge9
merge9:
  %t61 = phi i8* [ %t60, %then8 ], [ %t53, %merge7 ]
  store i8* %t61, i8** %l3
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t63 = load i8*, i8** %l3
  %t64 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t62, i8* %t63)
  store { i8**, i64 }* %t64, { i8**, i64 }** %l0
  %t65 = load double, double* %l1
  %t66 = sitofp i64 1 to double
  %t67 = fadd double %t65, %t66
  store double %t67, double* %l1
  br label %loop.latch4
loop.latch4:
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t69 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t73 = load double, double* %l1
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t74
}

define %PythonBuilder @builder_new() {
block.entry:
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
  %t12 = insertvalue %PythonBuilder undef, { i8**, i64 }* %t9, 0
  %t13 = sitofp i64 0 to double
  %t14 = insertvalue %PythonBuilder %t12, double %t13, 1
  ret %PythonBuilder %t14
}

define %PythonBuilder @builder_emit(%PythonBuilder %builder, i8* %line) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca { i8**, i64 }*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %line)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %builder)
  ret %PythonBuilder %t2
merge1:
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s3, i8** %l0
  %t4 = sitofp i64 0 to double
  store double %t4, double* %l1
  %t5 = load i8*, i8** %l0
  %t6 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t20 = phi i8* [ %t5, %merge1 ], [ %t18, %loop.latch4 ]
  %t21 = phi double [ %t6, %merge1 ], [ %t19, %loop.latch4 ]
  store i8* %t20, i8** %l0
  store double %t21, double* %l1
  br label %loop.body3
loop.body3:
  %t7 = load double, double* %l1
  %t8 = extractvalue %PythonBuilder %builder, 1
  %t9 = fcmp oge double %t7, %t8
  %t10 = load i8*, i8** %l0
  %t11 = load double, double* %l1
  br i1 %t9, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t12 = load i8*, i8** %l0
  %s13 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h173287691, i32 0, i32 0
  %t14 = call i8* @sailfin_runtime_string_concat(i8* %t12, i8* %s13)
  store i8* %t14, i8** %l0
  %t15 = load double, double* %l1
  %t16 = sitofp i64 1 to double
  %t17 = fadd double %t15, %t16
  store double %t17, double* %l1
  br label %loop.latch4
loop.latch4:
  %t18 = load i8*, i8** %l0
  %t19 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t22 = load i8*, i8** %l0
  %t23 = load double, double* %l1
  %t24 = load i8*, i8** %l0
  %t25 = call i8* @sailfin_runtime_string_concat(i8* %t24, i8* %line)
  store i8* %t25, i8** %l2
  %t26 = extractvalue %PythonBuilder %builder, 0
  %t27 = load i8*, i8** %l2
  %t28 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t26, i8* %t27)
  store { i8**, i64 }* %t28, { i8**, i64 }** %l3
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t30 = insertvalue %PythonBuilder undef, { i8**, i64 }* %t29, 0
  %t31 = extractvalue %PythonBuilder %builder, 1
  %t32 = insertvalue %PythonBuilder %t30, double %t31, 1
  ret %PythonBuilder %t32
}

define %PythonBuilder @builder_emit_blank(%PythonBuilder %builder) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %t0 = extractvalue %PythonBuilder %builder, 0
  %s1 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t2 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t0, i8* %s1)
  store { i8**, i64 }* %t2, { i8**, i64 }** %l0
  %t3 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t4 = insertvalue %PythonBuilder undef, { i8**, i64 }* %t3, 0
  %t5 = extractvalue %PythonBuilder %builder, 1
  %t6 = insertvalue %PythonBuilder %t4, double %t5, 1
  ret %PythonBuilder %t6
}

define %PythonBuilder @builder_push_indent(%PythonBuilder %builder) {
block.entry:
  %t0 = extractvalue %PythonBuilder %builder, 0
  %t1 = insertvalue %PythonBuilder undef, { i8**, i64 }* %t0, 0
  %t2 = extractvalue %PythonBuilder %builder, 1
  %t3 = sitofp i64 1 to double
  %t4 = fadd double %t2, %t3
  %t5 = insertvalue %PythonBuilder %t1, double %t4, 1
  ret %PythonBuilder %t5
}

define %PythonBuilder @builder_pop_indent(%PythonBuilder %builder) {
block.entry:
  %l0 = alloca double
  %t0 = extractvalue %PythonBuilder %builder, 1
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  %t2 = sitofp i64 0 to double
  %t3 = fcmp ogt double %t1, %t2
  %t4 = load double, double* %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = load double, double* %l0
  %t6 = sitofp i64 1 to double
  %t7 = fsub double %t5, %t6
  store double %t7, double* %l0
  %t8 = load double, double* %l0
  br label %merge1
merge1:
  %t9 = phi double [ %t8, %then0 ], [ %t4, %block.entry ]
  store double %t9, double* %l0
  %t10 = extractvalue %PythonBuilder %builder, 0
  %t11 = insertvalue %PythonBuilder undef, { i8**, i64 }* %t10, 0
  %t12 = load double, double* %l0
  %t13 = insertvalue %PythonBuilder %t11, double %t12, 1
  ret %PythonBuilder %t13
}

define i8* @builder_to_string(%PythonBuilder %builder) {
block.entry:
  %l0 = alloca i8*
  %t0 = extractvalue %PythonBuilder %builder, 0
  %t1 = alloca [2 x i8], align 1
  %t2 = getelementptr [2 x i8], [2 x i8]* %t1, i32 0, i32 0
  store i8 10, i8* %t2
  %t3 = getelementptr [2 x i8], [2 x i8]* %t1, i32 0, i32 1
  store i8 0, i8* %t3
  %t4 = getelementptr [2 x i8], [2 x i8]* %t1, i32 0, i32 0
  %t5 = call i8* @join_with_separator({ i8**, i64 }* %t0, i8* %t4)
  store i8* %t5, i8** %l0
  %t6 = load i8*, i8** %l0
  %t7 = call i64 @sailfin_runtime_string_length(i8* %t6)
  %t8 = icmp eq i64 %t7, 0
  %t9 = load i8*, i8** %l0
  br i1 %t8, label %then0, label %merge1
then0:
  %s10 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  ret i8* %s10
merge1:
  %t11 = load i8*, i8** %l0
  %t12 = alloca [2 x i8], align 1
  %t13 = getelementptr [2 x i8], [2 x i8]* %t12, i32 0, i32 0
  store i8 10, i8* %t13
  %t14 = getelementptr [2 x i8], [2 x i8]* %t12, i32 0, i32 1
  store i8 0, i8* %t14
  %t15 = getelementptr [2 x i8], [2 x i8]* %t12, i32 0, i32 0
  %t16 = call i8* @sailfin_runtime_string_concat(i8* %t11, i8* %t15)
  ret i8* %t16
}

define i8* @sanitize_identifier(i8* %name) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = load i8*, i8** %l0
  %t3 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t51 = phi i8* [ %t2, %block.entry ], [ %t49, %loop.latch2 ]
  %t52 = phi double [ %t3, %block.entry ], [ %t50, %loop.latch2 ]
  store i8* %t51, i8** %l0
  store double %t52, double* %l1
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  %t5 = call i64 @sailfin_runtime_string_length(i8* %name)
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
  %t12 = getelementptr i8, i8* %name, i64 %t11
  %t13 = load i8, i8* %t12
  store i8 %t13, i8* %l2
  %t14 = load i8, i8* %l2
  %t15 = alloca [2 x i8], align 1
  %t16 = getelementptr [2 x i8], [2 x i8]* %t15, i32 0, i32 0
  store i8 %t14, i8* %t16
  %t17 = getelementptr [2 x i8], [2 x i8]* %t15, i32 0, i32 1
  store i8 0, i8* %t17
  %t18 = getelementptr [2 x i8], [2 x i8]* %t15, i32 0, i32 0
  %t19 = call i1 @is_identifier_char(i8* %t18)
  %t20 = load i8*, i8** %l0
  %t21 = load double, double* %l1
  %t22 = load i8, i8* %l2
  br i1 %t19, label %then6, label %else7
then6:
  %t23 = load i8*, i8** %l0
  %t24 = load i8, i8* %l2
  %t25 = alloca [2 x i8], align 1
  %t26 = getelementptr [2 x i8], [2 x i8]* %t25, i32 0, i32 0
  store i8 %t24, i8* %t26
  %t27 = getelementptr [2 x i8], [2 x i8]* %t25, i32 0, i32 1
  store i8 0, i8* %t27
  %t28 = getelementptr [2 x i8], [2 x i8]* %t25, i32 0, i32 0
  %t29 = call i8* @sailfin_runtime_string_concat(i8* %t23, i8* %t28)
  store i8* %t29, i8** %l0
  %t30 = load i8*, i8** %l0
  br label %merge8
else7:
  %t31 = load i8, i8* %l2
  %t32 = icmp eq i8 %t31, 32
  %t33 = load i8*, i8** %l0
  %t34 = load double, double* %l1
  %t35 = load i8, i8* %l2
  br i1 %t32, label %then9, label %merge10
then9:
  %t36 = load i8*, i8** %l0
  %t37 = alloca [2 x i8], align 1
  %t38 = getelementptr [2 x i8], [2 x i8]* %t37, i32 0, i32 0
  store i8 95, i8* %t38
  %t39 = getelementptr [2 x i8], [2 x i8]* %t37, i32 0, i32 1
  store i8 0, i8* %t39
  %t40 = getelementptr [2 x i8], [2 x i8]* %t37, i32 0, i32 0
  %t41 = call i8* @sailfin_runtime_string_concat(i8* %t36, i8* %t40)
  store i8* %t41, i8** %l0
  %t42 = load i8*, i8** %l0
  br label %merge10
merge10:
  %t43 = phi i8* [ %t42, %then9 ], [ %t33, %else7 ]
  store i8* %t43, i8** %l0
  %t44 = load i8*, i8** %l0
  br label %merge8
merge8:
  %t45 = phi i8* [ %t30, %then6 ], [ %t44, %merge10 ]
  store i8* %t45, i8** %l0
  %t46 = load double, double* %l1
  %t47 = sitofp i64 1 to double
  %t48 = fadd double %t46, %t47
  store double %t48, double* %l1
  br label %loop.latch2
loop.latch2:
  %t49 = load i8*, i8** %l0
  %t50 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t53 = load i8*, i8** %l0
  %t54 = load double, double* %l1
  %t55 = load i8*, i8** %l0
  %t56 = call i64 @sailfin_runtime_string_length(i8* %t55)
  %t57 = icmp eq i64 %t56, 0
  %t58 = load i8*, i8** %l0
  %t59 = load double, double* %l1
  br i1 %t57, label %then11, label %merge12
then11:
  %s60 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.len18.h1387621460, i32 0, i32 0
  ret i8* %s60
merge12:
  %t61 = load i8*, i8** %l0
  ret i8* %t61
}

define i8* @sanitize_qualified_identifier(i8* %name) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca double
  %l4 = alloca i8
  %t0 = call i8* @trim_text(i8* %name)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = load i8*, i8** %l0
  %t6 = call i8* @sanitize_identifier(i8* %t5)
  ret i8* %t6
merge1:
  %s7 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s7, i8** %l1
  %t8 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t9 = ptrtoint [0 x i8*]* %t8 to i64
  %t10 = icmp eq i64 %t9, 0
  %t11 = select i1 %t10, i64 1, i64 %t9
  %t12 = call i8* @malloc(i64 %t11)
  %t13 = bitcast i8* %t12 to i8**
  %t14 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t15 = ptrtoint { i8**, i64 }* %t14 to i64
  %t16 = call i8* @malloc(i64 %t15)
  %t17 = bitcast i8* %t16 to { i8**, i64 }*
  %t18 = getelementptr { i8**, i64 }, { i8**, i64 }* %t17, i32 0, i32 0
  store i8** %t13, i8*** %t18
  %t19 = getelementptr { i8**, i64 }, { i8**, i64 }* %t17, i32 0, i32 1
  store i64 0, i64* %t19
  store { i8**, i64 }* %t17, { i8**, i64 }** %l2
  %t20 = sitofp i64 0 to double
  store double %t20, double* %l3
  %t21 = load i8*, i8** %l0
  %t22 = load i8*, i8** %l1
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t24 = load double, double* %l3
  br label %loop.header2
loop.header2:
  %t81 = phi { i8**, i64 }* [ %t23, %merge1 ], [ %t78, %loop.latch4 ]
  %t82 = phi i8* [ %t22, %merge1 ], [ %t79, %loop.latch4 ]
  %t83 = phi double [ %t24, %merge1 ], [ %t80, %loop.latch4 ]
  store { i8**, i64 }* %t81, { i8**, i64 }** %l2
  store i8* %t82, i8** %l1
  store double %t83, double* %l3
  br label %loop.body3
loop.body3:
  %t25 = load double, double* %l3
  %t26 = load i8*, i8** %l0
  %t27 = call i64 @sailfin_runtime_string_length(i8* %t26)
  %t28 = sitofp i64 %t27 to double
  %t29 = fcmp oge double %t25, %t28
  %t30 = load i8*, i8** %l0
  %t31 = load i8*, i8** %l1
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t33 = load double, double* %l3
  br i1 %t29, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t34 = load i8*, i8** %l0
  %t35 = load double, double* %l3
  %t36 = fptosi double %t35 to i64
  %t37 = getelementptr i8, i8* %t34, i64 %t36
  %t38 = load i8, i8* %t37
  store i8 %t38, i8* %l4
  %t39 = load i8, i8* %l4
  %t40 = icmp eq i8 %t39, 46
  %t41 = load i8*, i8** %l0
  %t42 = load i8*, i8** %l1
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t44 = load double, double* %l3
  %t45 = load i8, i8* %l4
  br i1 %t40, label %then8, label %else9
then8:
  %t46 = load i8*, i8** %l1
  %t47 = call i64 @sailfin_runtime_string_length(i8* %t46)
  %t48 = icmp sgt i64 %t47, 0
  %t49 = load i8*, i8** %l0
  %t50 = load i8*, i8** %l1
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t52 = load double, double* %l3
  %t53 = load i8, i8* %l4
  br i1 %t48, label %then11, label %merge12
then11:
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t55 = load i8*, i8** %l1
  %t56 = call i8* @sanitize_identifier(i8* %t55)
  %t57 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t54, i8* %t56)
  store { i8**, i64 }* %t57, { i8**, i64 }** %l2
  %s58 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s58, i8** %l1
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t60 = load i8*, i8** %l1
  br label %merge12
merge12:
  %t61 = phi { i8**, i64 }* [ %t59, %then11 ], [ %t51, %then8 ]
  %t62 = phi i8* [ %t60, %then11 ], [ %t50, %then8 ]
  store { i8**, i64 }* %t61, { i8**, i64 }** %l2
  store i8* %t62, i8** %l1
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t64 = load i8*, i8** %l1
  br label %merge10
else9:
  %t65 = load i8*, i8** %l1
  %t66 = load i8, i8* %l4
  %t67 = alloca [2 x i8], align 1
  %t68 = getelementptr [2 x i8], [2 x i8]* %t67, i32 0, i32 0
  store i8 %t66, i8* %t68
  %t69 = getelementptr [2 x i8], [2 x i8]* %t67, i32 0, i32 1
  store i8 0, i8* %t69
  %t70 = getelementptr [2 x i8], [2 x i8]* %t67, i32 0, i32 0
  %t71 = call i8* @sailfin_runtime_string_concat(i8* %t65, i8* %t70)
  store i8* %t71, i8** %l1
  %t72 = load i8*, i8** %l1
  br label %merge10
merge10:
  %t73 = phi { i8**, i64 }* [ %t63, %merge12 ], [ %t43, %else9 ]
  %t74 = phi i8* [ %t64, %merge12 ], [ %t72, %else9 ]
  store { i8**, i64 }* %t73, { i8**, i64 }** %l2
  store i8* %t74, i8** %l1
  %t75 = load double, double* %l3
  %t76 = sitofp i64 1 to double
  %t77 = fadd double %t75, %t76
  store double %t77, double* %l3
  br label %loop.latch4
loop.latch4:
  %t78 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t79 = load i8*, i8** %l1
  %t80 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t84 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t85 = load i8*, i8** %l1
  %t86 = load double, double* %l3
  %t87 = load i8*, i8** %l1
  %t88 = call i64 @sailfin_runtime_string_length(i8* %t87)
  %t89 = icmp sgt i64 %t88, 0
  %t90 = load i8*, i8** %l0
  %t91 = load i8*, i8** %l1
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t93 = load double, double* %l3
  br i1 %t89, label %then13, label %merge14
then13:
  %t94 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t95 = load i8*, i8** %l1
  %t96 = call i8* @sanitize_identifier(i8* %t95)
  %t97 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t94, i8* %t96)
  store { i8**, i64 }* %t97, { i8**, i64 }** %l2
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br label %merge14
merge14:
  %t99 = phi { i8**, i64 }* [ %t98, %then13 ], [ %t92, %afterloop5 ]
  store { i8**, i64 }* %t99, { i8**, i64 }** %l2
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t101 = load { i8**, i64 }, { i8**, i64 }* %t100
  %t102 = extractvalue { i8**, i64 } %t101, 1
  %t103 = icmp eq i64 %t102, 0
  %t104 = load i8*, i8** %l0
  %t105 = load i8*, i8** %l1
  %t106 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t107 = load double, double* %l3
  br i1 %t103, label %then15, label %merge16
then15:
  %t108 = load i8*, i8** %l0
  %t109 = call i8* @sanitize_identifier(i8* %t108)
  ret i8* %t109
merge16:
  %t110 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t111 = alloca [2 x i8], align 1
  %t112 = getelementptr [2 x i8], [2 x i8]* %t111, i32 0, i32 0
  store i8 46, i8* %t112
  %t113 = getelementptr [2 x i8], [2 x i8]* %t111, i32 0, i32 1
  store i8 0, i8* %t113
  %t114 = getelementptr [2 x i8], [2 x i8]* %t111, i32 0, i32 0
  %t115 = call i8* @join_with_separator({ i8**, i64 }* %t110, i8* %t114)
  ret i8* %t115
}

define i1 @is_identifier_char(i8* %ch) {
block.entry:
  %l0 = alloca double
  %t0 = load i8, i8* %ch
  %t1 = icmp eq i8 %t0, 95
  br i1 %t1, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %t2 = call double @char_code(i8* %ch)
  store double %t2, double* %l0
  %t4 = load double, double* %l0
  %t5 = alloca [2 x i8], align 1
  %t6 = getelementptr [2 x i8], [2 x i8]* %t5, i32 0, i32 0
  store i8 97, i8* %t6
  %t7 = getelementptr [2 x i8], [2 x i8]* %t5, i32 0, i32 1
  store i8 0, i8* %t7
  %t8 = getelementptr [2 x i8], [2 x i8]* %t5, i32 0, i32 0
  %t9 = call double @char_code(i8* %t8)
  %t10 = fcmp oge double %t4, %t9
  br label %logical_and_entry_3

logical_and_entry_3:
  br i1 %t10, label %logical_and_right_3, label %logical_and_merge_3

logical_and_right_3:
  %t11 = load double, double* %l0
  %t12 = alloca [2 x i8], align 1
  %t13 = getelementptr [2 x i8], [2 x i8]* %t12, i32 0, i32 0
  store i8 122, i8* %t13
  %t14 = getelementptr [2 x i8], [2 x i8]* %t12, i32 0, i32 1
  store i8 0, i8* %t14
  %t15 = getelementptr [2 x i8], [2 x i8]* %t12, i32 0, i32 0
  %t16 = call double @char_code(i8* %t15)
  %t17 = fcmp ole double %t11, %t16
  br label %logical_and_right_end_3

logical_and_right_end_3:
  br label %logical_and_merge_3

logical_and_merge_3:
  %t18 = phi i1 [ false, %logical_and_entry_3 ], [ %t17, %logical_and_right_end_3 ]
  %t19 = load double, double* %l0
  br i1 %t18, label %then2, label %merge3
then2:
  ret i1 1
merge3:
  %t21 = load double, double* %l0
  %t22 = alloca [2 x i8], align 1
  %t23 = getelementptr [2 x i8], [2 x i8]* %t22, i32 0, i32 0
  store i8 65, i8* %t23
  %t24 = getelementptr [2 x i8], [2 x i8]* %t22, i32 0, i32 1
  store i8 0, i8* %t24
  %t25 = getelementptr [2 x i8], [2 x i8]* %t22, i32 0, i32 0
  %t26 = call double @char_code(i8* %t25)
  %t27 = fcmp oge double %t21, %t26
  br label %logical_and_entry_20

logical_and_entry_20:
  br i1 %t27, label %logical_and_right_20, label %logical_and_merge_20

logical_and_right_20:
  %t28 = load double, double* %l0
  %t29 = alloca [2 x i8], align 1
  %t30 = getelementptr [2 x i8], [2 x i8]* %t29, i32 0, i32 0
  store i8 90, i8* %t30
  %t31 = getelementptr [2 x i8], [2 x i8]* %t29, i32 0, i32 1
  store i8 0, i8* %t31
  %t32 = getelementptr [2 x i8], [2 x i8]* %t29, i32 0, i32 0
  %t33 = call double @char_code(i8* %t32)
  %t34 = fcmp ole double %t28, %t33
  br label %logical_and_right_end_20

logical_and_right_end_20:
  br label %logical_and_merge_20

logical_and_merge_20:
  %t35 = phi i1 [ false, %logical_and_entry_20 ], [ %t34, %logical_and_right_end_20 ]
  %t36 = load double, double* %l0
  br i1 %t35, label %then4, label %merge5
then4:
  ret i1 1
merge5:
  %t38 = load double, double* %l0
  %t39 = alloca [2 x i8], align 1
  %t40 = getelementptr [2 x i8], [2 x i8]* %t39, i32 0, i32 0
  store i8 48, i8* %t40
  %t41 = getelementptr [2 x i8], [2 x i8]* %t39, i32 0, i32 1
  store i8 0, i8* %t41
  %t42 = getelementptr [2 x i8], [2 x i8]* %t39, i32 0, i32 0
  %t43 = call double @char_code(i8* %t42)
  %t44 = fcmp oge double %t38, %t43
  br label %logical_and_entry_37

logical_and_entry_37:
  br i1 %t44, label %logical_and_right_37, label %logical_and_merge_37

logical_and_right_37:
  %t45 = load double, double* %l0
  %t46 = alloca [2 x i8], align 1
  %t47 = getelementptr [2 x i8], [2 x i8]* %t46, i32 0, i32 0
  store i8 57, i8* %t47
  %t48 = getelementptr [2 x i8], [2 x i8]* %t46, i32 0, i32 1
  store i8 0, i8* %t48
  %t49 = getelementptr [2 x i8], [2 x i8]* %t46, i32 0, i32 0
  %t50 = call double @char_code(i8* %t49)
  %t51 = fcmp ole double %t45, %t50
  br label %logical_and_right_end_37

logical_and_right_end_37:
  br label %logical_and_merge_37

logical_and_merge_37:
  %t52 = phi i1 [ false, %logical_and_entry_37 ], [ %t51, %logical_and_right_end_37 ]
  %t53 = load double, double* %l0
  br i1 %t52, label %then6, label %merge7
then6:
  ret i1 1
merge7:
  ret i1 0
}

define i1 @is_whitespace_char(i8* %ch) {
block.entry:
  %t0 = load i8, i8* %ch
  %t1 = icmp eq i8 %t0, 32
  br i1 %t1, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %t2 = load i8, i8* %ch
  %t3 = icmp eq i8 %t2, 10
  br i1 %t3, label %then2, label %merge3
then2:
  ret i1 1
merge3:
  %t4 = load i8, i8* %ch
  %t5 = icmp eq i8 %t4, 13
  br i1 %t5, label %then4, label %merge5
then4:
  ret i1 1
merge5:
  %t6 = load i8, i8* %ch
  %t7 = icmp eq i8 %t6, 9
  br i1 %t7, label %then6, label %merge7
then6:
  ret i1 1
merge7:
  ret i1 0
}

define i8* @trim_text(i8* %value) {
block.entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca i8*
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t2 = sitofp i64 %t1 to double
  store double %t2, double* %l1
  %t3 = load double, double* %l0
  %t4 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t42 = phi double [ %t3, %block.entry ], [ %t41, %loop.latch2 ]
  store double %t42, double* %l0
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
  %t11 = load double, double* %l0
  %t12 = sitofp i64 1 to double
  %t13 = fadd double %t11, %t12
  %t14 = fptosi double %t10 to i64
  %t15 = fptosi double %t13 to i64
  %t16 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t14, i64 %t15)
  store i8* %t16, i8** %l2
  %t18 = load i8*, i8** %l2
  %t19 = load i8, i8* %t18
  %t20 = icmp eq i8 %t19, 32
  br label %logical_or_entry_17

logical_or_entry_17:
  br i1 %t20, label %logical_or_merge_17, label %logical_or_right_17

logical_or_right_17:
  %t22 = load i8*, i8** %l2
  %t23 = load i8, i8* %t22
  %t24 = icmp eq i8 %t23, 10
  br label %logical_or_entry_21

logical_or_entry_21:
  br i1 %t24, label %logical_or_merge_21, label %logical_or_right_21

logical_or_right_21:
  %t26 = load i8*, i8** %l2
  %t27 = load i8, i8* %t26
  %t28 = icmp eq i8 %t27, 13
  br label %logical_or_entry_25

logical_or_entry_25:
  br i1 %t28, label %logical_or_merge_25, label %logical_or_right_25

logical_or_right_25:
  %t29 = load i8*, i8** %l2
  %t30 = load i8, i8* %t29
  %t31 = icmp eq i8 %t30, 9
  br label %logical_or_right_end_25

logical_or_right_end_25:
  br label %logical_or_merge_25

logical_or_merge_25:
  %t32 = phi i1 [ true, %logical_or_entry_25 ], [ %t31, %logical_or_right_end_25 ]
  br label %logical_or_right_end_21

logical_or_right_end_21:
  br label %logical_or_merge_21

logical_or_merge_21:
  %t33 = phi i1 [ true, %logical_or_entry_21 ], [ %t32, %logical_or_right_end_21 ]
  br label %logical_or_right_end_17

logical_or_right_end_17:
  br label %logical_or_merge_17

logical_or_merge_17:
  %t34 = phi i1 [ true, %logical_or_entry_17 ], [ %t33, %logical_or_right_end_17 ]
  %t35 = load double, double* %l0
  %t36 = load double, double* %l1
  %t37 = load i8*, i8** %l2
  br i1 %t34, label %then6, label %merge7
then6:
  %t38 = load double, double* %l0
  %t39 = sitofp i64 1 to double
  %t40 = fadd double %t38, %t39
  store double %t40, double* %l0
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  %t41 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t43 = load double, double* %l0
  %t44 = load double, double* %l0
  %t45 = load double, double* %l1
  br label %loop.header8
loop.header8:
  %t87 = phi double [ %t45, %afterloop3 ], [ %t86, %loop.latch10 ]
  store double %t87, double* %l1
  br label %loop.body9
loop.body9:
  %t46 = load double, double* %l1
  %t47 = load double, double* %l0
  %t48 = fcmp ole double %t46, %t47
  %t49 = load double, double* %l0
  %t50 = load double, double* %l1
  br i1 %t48, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t51 = load double, double* %l1
  %t52 = sitofp i64 1 to double
  %t53 = fsub double %t51, %t52
  store double %t53, double* %l3
  %t54 = load double, double* %l3
  %t55 = load double, double* %l3
  %t56 = sitofp i64 1 to double
  %t57 = fadd double %t55, %t56
  %t58 = fptosi double %t54 to i64
  %t59 = fptosi double %t57 to i64
  %t60 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t58, i64 %t59)
  store i8* %t60, i8** %l4
  %t62 = load i8*, i8** %l4
  %t63 = load i8, i8* %t62
  %t64 = icmp eq i8 %t63, 32
  br label %logical_or_entry_61

logical_or_entry_61:
  br i1 %t64, label %logical_or_merge_61, label %logical_or_right_61

logical_or_right_61:
  %t66 = load i8*, i8** %l4
  %t67 = load i8, i8* %t66
  %t68 = icmp eq i8 %t67, 10
  br label %logical_or_entry_65

logical_or_entry_65:
  br i1 %t68, label %logical_or_merge_65, label %logical_or_right_65

logical_or_right_65:
  %t70 = load i8*, i8** %l4
  %t71 = load i8, i8* %t70
  %t72 = icmp eq i8 %t71, 13
  br label %logical_or_entry_69

logical_or_entry_69:
  br i1 %t72, label %logical_or_merge_69, label %logical_or_right_69

logical_or_right_69:
  %t73 = load i8*, i8** %l4
  %t74 = load i8, i8* %t73
  %t75 = icmp eq i8 %t74, 9
  br label %logical_or_right_end_69

logical_or_right_end_69:
  br label %logical_or_merge_69

logical_or_merge_69:
  %t76 = phi i1 [ true, %logical_or_entry_69 ], [ %t75, %logical_or_right_end_69 ]
  br label %logical_or_right_end_65

logical_or_right_end_65:
  br label %logical_or_merge_65

logical_or_merge_65:
  %t77 = phi i1 [ true, %logical_or_entry_65 ], [ %t76, %logical_or_right_end_65 ]
  br label %logical_or_right_end_61

logical_or_right_end_61:
  br label %logical_or_merge_61

logical_or_merge_61:
  %t78 = phi i1 [ true, %logical_or_entry_61 ], [ %t77, %logical_or_right_end_61 ]
  %t79 = load double, double* %l0
  %t80 = load double, double* %l1
  %t81 = load double, double* %l3
  %t82 = load i8*, i8** %l4
  br i1 %t78, label %then14, label %merge15
then14:
  %t83 = load double, double* %l1
  %t84 = sitofp i64 1 to double
  %t85 = fsub double %t83, %t84
  store double %t85, double* %l1
  br label %loop.latch10
merge15:
  br label %afterloop11
loop.latch10:
  %t86 = load double, double* %l1
  br label %loop.header8
afterloop11:
  %t88 = load double, double* %l1
  %t90 = load double, double* %l0
  %t91 = sitofp i64 0 to double
  %t92 = fcmp oeq double %t90, %t91
  br label %logical_and_entry_89

logical_and_entry_89:
  br i1 %t92, label %logical_and_right_89, label %logical_and_merge_89

logical_and_right_89:
  %t93 = load double, double* %l1
  %t94 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t95 = sitofp i64 %t94 to double
  %t96 = fcmp oeq double %t93, %t95
  br label %logical_and_right_end_89

logical_and_right_end_89:
  br label %logical_and_merge_89

logical_and_merge_89:
  %t97 = phi i1 [ false, %logical_and_entry_89 ], [ %t96, %logical_and_right_end_89 ]
  %t98 = load double, double* %l0
  %t99 = load double, double* %l1
  br i1 %t97, label %then16, label %merge17
then16:
  ret i8* %value
merge17:
  %t100 = load double, double* %l0
  %t101 = load double, double* %l1
  %t102 = fptosi double %t100 to i64
  %t103 = fptosi double %t101 to i64
  %t104 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t102, i64 %t103)
  ret i8* %t104
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

define i1 @ends_with(i8* %value, i8* %suffix) {
block.entry:
  %l0 = alloca double
  %t0 = call i64 @sailfin_runtime_string_length(i8* %suffix)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %t2 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t3 = call i64 @sailfin_runtime_string_length(i8* %suffix)
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
  %t31 = phi double [ %t6, %merge3 ], [ %t30, %loop.latch6 ]
  store double %t31, double* %l0
  br label %loop.body5
loop.body5:
  %t7 = load double, double* %l0
  %t8 = call i64 @sailfin_runtime_string_length(i8* %suffix)
  %t9 = sitofp i64 %t8 to double
  %t10 = fcmp oge double %t7, %t9
  %t11 = load double, double* %l0
  br i1 %t10, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t12 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t13 = call i64 @sailfin_runtime_string_length(i8* %suffix)
  %t14 = sub i64 %t12, %t13
  %t15 = load double, double* %l0
  %t16 = sitofp i64 %t14 to double
  %t17 = fadd double %t16, %t15
  %t18 = fptosi double %t17 to i64
  %t19 = getelementptr i8, i8* %value, i64 %t18
  %t20 = load i8, i8* %t19
  %t21 = load double, double* %l0
  %t22 = fptosi double %t21 to i64
  %t23 = getelementptr i8, i8* %suffix, i64 %t22
  %t24 = load i8, i8* %t23
  %t25 = icmp ne i8 %t20, %t24
  %t26 = load double, double* %l0
  br i1 %t25, label %then10, label %merge11
then10:
  ret i1 0
merge11:
  %t27 = load double, double* %l0
  %t28 = sitofp i64 1 to double
  %t29 = fadd double %t27, %t28
  store double %t29, double* %l0
  br label %loop.latch6
loop.latch6:
  %t30 = load double, double* %l0
  br label %loop.header4
afterloop7:
  %t32 = load double, double* %l0
  ret i1 1
}

define i8* @replace_all(i8* %value, i8* %target, i8* %replacement) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i1
  %l3 = alloca double
  %t0 = call i64 @sailfin_runtime_string_length(i8* %target)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  ret i8* %value
merge1:
  %s2 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s2, i8** %l0
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l1
  %t4 = load i8*, i8** %l0
  %t5 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t82 = phi i8* [ %t4, %merge1 ], [ %t80, %loop.latch4 ]
  %t83 = phi double [ %t5, %merge1 ], [ %t81, %loop.latch4 ]
  store i8* %t82, i8** %l0
  store double %t83, double* %l1
  br label %loop.body3
loop.body3:
  %t6 = load double, double* %l1
  %t7 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t8 = sitofp i64 %t7 to double
  %t9 = fcmp oge double %t6, %t8
  %t10 = load i8*, i8** %l0
  %t11 = load double, double* %l1
  br i1 %t9, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t12 = load double, double* %l1
  %t13 = call i64 @sailfin_runtime_string_length(i8* %target)
  %t14 = sitofp i64 %t13 to double
  %t15 = fadd double %t12, %t14
  %t16 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t17 = sitofp i64 %t16 to double
  %t18 = fcmp ole double %t15, %t17
  %t19 = load i8*, i8** %l0
  %t20 = load double, double* %l1
  br i1 %t18, label %then8, label %merge9
then8:
  store i1 1, i1* %l2
  %t21 = sitofp i64 0 to double
  store double %t21, double* %l3
  %t22 = load i8*, i8** %l0
  %t23 = load double, double* %l1
  %t24 = load i1, i1* %l2
  %t25 = load double, double* %l3
  br label %loop.header10
loop.header10:
  %t54 = phi i1 [ %t24, %then8 ], [ %t52, %loop.latch12 ]
  %t55 = phi double [ %t25, %then8 ], [ %t53, %loop.latch12 ]
  store i1 %t54, i1* %l2
  store double %t55, double* %l3
  br label %loop.body11
loop.body11:
  %t26 = load double, double* %l3
  %t27 = call i64 @sailfin_runtime_string_length(i8* %target)
  %t28 = sitofp i64 %t27 to double
  %t29 = fcmp oge double %t26, %t28
  %t30 = load i8*, i8** %l0
  %t31 = load double, double* %l1
  %t32 = load i1, i1* %l2
  %t33 = load double, double* %l3
  br i1 %t29, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t34 = load double, double* %l1
  %t35 = load double, double* %l3
  %t36 = fadd double %t34, %t35
  %t37 = fptosi double %t36 to i64
  %t38 = getelementptr i8, i8* %value, i64 %t37
  %t39 = load i8, i8* %t38
  %t40 = load double, double* %l3
  %t41 = fptosi double %t40 to i64
  %t42 = getelementptr i8, i8* %target, i64 %t41
  %t43 = load i8, i8* %t42
  %t44 = icmp ne i8 %t39, %t43
  %t45 = load i8*, i8** %l0
  %t46 = load double, double* %l1
  %t47 = load i1, i1* %l2
  %t48 = load double, double* %l3
  br i1 %t44, label %then16, label %merge17
then16:
  store i1 0, i1* %l2
  br label %afterloop13
merge17:
  %t49 = load double, double* %l3
  %t50 = sitofp i64 1 to double
  %t51 = fadd double %t49, %t50
  store double %t51, double* %l3
  br label %loop.latch12
loop.latch12:
  %t52 = load i1, i1* %l2
  %t53 = load double, double* %l3
  br label %loop.header10
afterloop13:
  %t56 = load i1, i1* %l2
  %t57 = load double, double* %l3
  %t58 = load i1, i1* %l2
  %t59 = load i8*, i8** %l0
  %t60 = load double, double* %l1
  %t61 = load i1, i1* %l2
  %t62 = load double, double* %l3
  br i1 %t58, label %then18, label %merge19
then18:
  %t63 = load i8*, i8** %l0
  %t64 = call i8* @sailfin_runtime_string_concat(i8* %t63, i8* %replacement)
  store i8* %t64, i8** %l0
  %t65 = load double, double* %l1
  %t66 = call i64 @sailfin_runtime_string_length(i8* %target)
  %t67 = sitofp i64 %t66 to double
  %t68 = fadd double %t65, %t67
  store double %t68, double* %l1
  br label %loop.latch4
merge19:
  %t69 = load i8*, i8** %l0
  %t70 = load double, double* %l1
  br label %merge9
merge9:
  %t71 = phi i8* [ %t69, %merge19 ], [ %t19, %merge7 ]
  %t72 = phi double [ %t70, %merge19 ], [ %t20, %merge7 ]
  store i8* %t71, i8** %l0
  store double %t72, double* %l1
  %t73 = load i8*, i8** %l0
  %t74 = load double, double* %l1
  %t75 = call i8* @char_at(i8* %value, double %t74)
  %t76 = call i8* @sailfin_runtime_string_concat(i8* %t73, i8* %t75)
  store i8* %t76, i8** %l0
  %t77 = load double, double* %l1
  %t78 = sitofp i64 1 to double
  %t79 = fadd double %t77, %t78
  store double %t79, double* %l1
  br label %loop.latch4
loop.latch4:
  %t80 = load i8*, i8** %l0
  %t81 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t84 = load i8*, i8** %l0
  %t85 = load double, double* %l1
  %t86 = load i8*, i8** %l0
  ret i8* %t86
}

define i8* @join_with_separator({ i8**, i64 }* %values, i8* %separator) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %t0 = load { i8**, i64 }, { i8**, i64 }* %values
  %t1 = extractvalue { i8**, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  ret i8* %s3
merge1:
  %t4 = load { i8**, i64 }, { i8**, i64 }* %values
  %t5 = extractvalue { i8**, i64 } %t4, 0
  %t6 = extractvalue { i8**, i64 } %t4, 1
  %t7 = icmp uge i64 0, %t6
  ; bounds check: %t7 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 0, i64 %t6)
  %t8 = getelementptr i8*, i8** %t5, i64 0
  %t9 = load i8*, i8** %t8
  store i8* %t9, i8** %l0
  %t10 = sitofp i64 1 to double
  store double %t10, double* %l1
  %t11 = load i8*, i8** %l0
  %t12 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t36 = phi i8* [ %t11, %merge1 ], [ %t34, %loop.latch4 ]
  %t37 = phi double [ %t12, %merge1 ], [ %t35, %loop.latch4 ]
  store i8* %t36, i8** %l0
  store double %t37, double* %l1
  br label %loop.body3
loop.body3:
  %t13 = load double, double* %l1
  %t14 = load { i8**, i64 }, { i8**, i64 }* %values
  %t15 = extractvalue { i8**, i64 } %t14, 1
  %t16 = sitofp i64 %t15 to double
  %t17 = fcmp oge double %t13, %t16
  %t18 = load i8*, i8** %l0
  %t19 = load double, double* %l1
  br i1 %t17, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t20 = load i8*, i8** %l0
  %t21 = call i8* @sailfin_runtime_string_concat(i8* %t20, i8* %separator)
  %t22 = load double, double* %l1
  %t23 = fptosi double %t22 to i64
  %t24 = load { i8**, i64 }, { i8**, i64 }* %values
  %t25 = extractvalue { i8**, i64 } %t24, 0
  %t26 = extractvalue { i8**, i64 } %t24, 1
  %t27 = icmp uge i64 %t23, %t26
  ; bounds check: %t27 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t23, i64 %t26)
  %t28 = getelementptr i8*, i8** %t25, i64 %t23
  %t29 = load i8*, i8** %t28
  %t30 = call i8* @sailfin_runtime_string_concat(i8* %t21, i8* %t29)
  store i8* %t30, i8** %l0
  %t31 = load double, double* %l1
  %t32 = sitofp i64 1 to double
  %t33 = fadd double %t31, %t32
  store double %t33, double* %l1
  br label %loop.latch4
loop.latch4:
  %t34 = load i8*, i8** %l0
  %t35 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t38 = load i8*, i8** %l0
  %t39 = load double, double* %l1
  %t40 = load i8*, i8** %l0
  ret i8* %t40
}

define { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %diagnostics, i8* %function_name, i8* %detail) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %t0 = call i8* @trim_text(i8* %function_name)
  store i8* %t0, i8** %l0
  %s1 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h2001621394, i32 0, i32 0
  store i8* %s1, i8** %l1
  %t2 = load i8*, i8** %l0
  %t3 = call i64 @sailfin_runtime_string_length(i8* %t2)
  %t4 = icmp eq i64 %t3, 0
  %t5 = load i8*, i8** %l0
  %t6 = load i8*, i8** %l1
  br i1 %t4, label %then0, label %else1
then0:
  %t7 = load i8*, i8** %l1
  %t8 = call i8* @sailfin_runtime_string_concat(i8* %t7, i8* %detail)
  store i8* %t8, i8** %l1
  %t9 = load i8*, i8** %l1
  br label %merge2
else1:
  %t10 = load i8*, i8** %l1
  %t11 = load i8*, i8** %l0
  %t12 = call i8* @sailfin_runtime_string_concat(i8* %t10, i8* %t11)
  %s13 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193441217, i32 0, i32 0
  %t14 = call i8* @sailfin_runtime_string_concat(i8* %t12, i8* %s13)
  %t15 = call i8* @sailfin_runtime_string_concat(i8* %t14, i8* %detail)
  store i8* %t15, i8** %l1
  %t16 = load i8*, i8** %l1
  br label %merge2
merge2:
  %t17 = phi i8* [ %t9, %then0 ], [ %t16, %else1 ]
  store i8* %t17, i8** %l1
  %t18 = load i8*, i8** %l1
  %t19 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %diagnostics, i8* %t18)
  ret { i8**, i64 }* %t19
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

define i8* @char_at(i8* %value, double %index) {
block.entry:
  %t0 = sitofp i64 1 to double
  %t1 = fadd double %index, %t0
  %t2 = fptosi double %index to i64
  %t3 = fptosi double %t1 to i64
  %t4 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t2, i64 %t3)
  ret i8* %t4
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
@.enum.NativeInstruction.Else.variant = private unnamed_addr constant [5 x i8] c"Else\00"
@.str.len7.h655348872 = private unnamed_addr constant [8 x i8] c"return \00"
@.str.len8.h2085806463 = private unnamed_addr constant [9 x i8] c"runtime/\00"
@.str.len6.h536277508 = private unnamed_addr constant [7 x i8] c"Return\00"
@.str.len12.h300877395 = private unnamed_addr constant [13 x i8] c"EnumInstance\00"
@.str.len25.h458257002 = private unnamed_addr constant [26 x i8] c"endif without matching if\00"
@.str.len11.h1779553665 = private unnamed_addr constant [12 x i8] c"# effects: \00"
@.str.len20.h728584192 = private unnamed_addr constant [21 x i8] c"runtime.enum_field('\00"
@.str.len31.h1736570074 = private unnamed_addr constant [32 x i8] c"unterminated control-flow block\00"
@.str.len4.h230766299 = private unnamed_addr constant [5 x i8] c"None\00"
@.str.len4.h173287691 = private unnamed_addr constant [5 x i8] c"    \00"
@.str.len32.h1370567591 = private unnamed_addr constant [33 x i8] c"endfor without matching for loop\00"
@.str.len26.h1088202076 = private unnamed_addr constant [27 x i8] c"field = self.fields[index]\00"
@.str.len8.h757831264 = private unnamed_addr constant [9 x i8] c".concat(\00"
@.str.len8.h528348603 = private unnamed_addr constant [9 x i8] c"continue\00"
@.str.len18.h1387621460 = private unnamed_addr constant [19 x i8] c"generated_function\00"
@.str.len5.h706445588 = private unnamed_addr constant [6 x i8] c"Break\00"
@.str.len4.h176216012 = private unnamed_addr constant [5 x i8] c" or \00"
@.str.len42.h9444846 = private unnamed_addr constant [43 x i8] c"unsupported instruction emitted as comment\00"
@.str.len4.h270590402 = private unnamed_addr constant [5 x i8] c"pass\00"
@.str.len4.h259230482 = private unnamed_addr constant [5 x i8] c"for \00"
@.str.len5.h1117315388 = private unnamed_addr constant [6 x i8] c"Match\00"
@.enum.NativeInstruction.variant.default = private unnamed_addr constant [1 x i8] c"\00"
@.str.len6.h653919037 = private unnamed_addr constant [7 x i8] c"', [])\00"
@.str.len7.h48777630 = private unnamed_addr constant [8 x i8] c"Unknown\00"
@.str.len4.h175996034 = private unnamed_addr constant [5 x i8] c" in \00"
@.str.len4.h228395909 = private unnamed_addr constant [5 x i8] c"Loop\00"
@.str.len7.h1543377657 = private unnamed_addr constant [8 x i8] c") and (\00"
@.str.len4.h219990644 = private unnamed_addr constant [5 x i8] c"Else\00"
@.str.len5.h468448796 = private unnamed_addr constant [6 x i8] c"=None\00"
@.str.len7.h739212033 = private unnamed_addr constant [8 x i8] c"EndLoop\00"
@.str.len28.h430828782 = private unnamed_addr constant [29 x i8] c"def __getattr__(self, item):\00"
@.str.len5.h1958778164 = private unnamed_addr constant [6 x i8] c"break\00"
@.str.len10.h1629914700 = private unnamed_addr constant [11 x i8] c"Expression\00"
@.enum.NativeInstruction.Break.variant = private unnamed_addr constant [6 x i8] c"Break\00"
@.str.len2.h193480223 = private unnamed_addr constant [3 x i8] c"\5C\5C\00"
@.str.len2.h193480817 = private unnamed_addr constant [3 x i8] c"\5Cn\00"
@.str.len25.h117462910 = private unnamed_addr constant [26 x i8] c"runtime.enum_instantiate(\00"
@.str.len3.h2090359129 = private unnamed_addr constant [4 x i8] c"if \00"
@.str.len2.h193516127 = private unnamed_addr constant [3 x i8] c"||\00"
@.enum.NativeInstruction.Match.variant = private unnamed_addr constant [6 x i8] c"Match\00"
@.str.len2.h193479167 = private unnamed_addr constant [3 x i8] c"[]\00"
@.str.len5.h1503489441 = private unnamed_addr constant [6 x i8] c" and \00"
@.str.len10.h1977847647 = private unnamed_addr constant [11 x i8] c"index += 1\00"
@.str.len5.h2069574674 = private unnamed_addr constant [6 x i8] c"else:\00"
@.str.len29.h1409903806 = private unnamed_addr constant [30 x i8] c"unterminated match expression\00"
@.str.len7.h1558772342 = private unnamed_addr constant [8 x i8] c".length\00"
@.str.len3.h2088090973 = private unnamed_addr constant [4 x i8] c", '\00"
@.enum.NativeInstruction.For.variant = private unnamed_addr constant [4 x i8] c"For\00"
@.enum.NativeInstruction.Let.variant = private unnamed_addr constant [4 x i8] c"Let\00"
@.str.len24.h2028465620 = private unnamed_addr constant [25 x i8] c"else without matching if\00"
@.enum.NativeInstruction.Loop.variant = private unnamed_addr constant [5 x i8] c"Loop\00"
@.str.len4.h237997259 = private unnamed_addr constant [5 x i8] c"True\00"
@.enum.NativeInstruction.Noop.variant = private unnamed_addr constant [5 x i8] c"Noop\00"
@.str.len9.h320851598 = private unnamed_addr constant [10 x i8] c"index = 0\00"
@.str.len6.h1061063223 = private unnamed_addr constant [7 x i8] c"return\00"
@.str.len22.h1038501153 = private unnamed_addr constant [23 x i8] c"runtime.struct_field('\00"
@.str.len8.h104511138 = private unnamed_addr constant [9 x i8] c"', self.\00"
@.str.len26.h1984174475 = private unnamed_addr constant [27 x i8] c"raise AttributeError(item)\00"
@.str.len15.h1309566598 = private unnamed_addr constant [16 x i8] c"compiler.build.\00"
@.enum.NativeInstruction.EndMatch.variant = private unnamed_addr constant [9 x i8] c"EndMatch\00"
@.enum.NativeInstruction.EndIf.variant = private unnamed_addr constant [6 x i8] c"EndIf\00"
@.str.len3.h2089113841 = private unnamed_addr constant [4 x i8] c"For\00"
@.str.len29.h1122035900 = private unnamed_addr constant [30 x i8] c"endloop without matching loop\00"
@.str.len29.h610920064 = private unnamed_addr constant [30 x i8] c"if index >= len(self.fields):\00"
@.str.len39.h1262256381 = private unnamed_addr constant [40 x i8] c"no sailfin-native-text artifact present\00"
@.str.len18.h1456282769 = private unnamed_addr constant [19 x i8] c"return field.value\00"
@.str.len4.h275946731 = private unnamed_addr constant [5 x i8] c"true\00"
@.str.len5.h1776141546 = private unnamed_addr constant [6 x i8] c") + (\00"
@.str.len6.h1258614714 = private unnamed_addr constant [7 x i8] c"EndFor\00"
@.str.len37.h314404344 = private unnamed_addr constant [38 x i8] c"endmatch without active match context\00"
@.str.len2.h193517249 = private unnamed_addr constant [3 x i8] c"}}\00"
@.str.len2.h193480949 = private unnamed_addr constant [3 x i8] c"\5Cr\00"
@.str.len3.h2089318639 = private unnamed_addr constant [4 x i8] c"Let\00"
@.str.len8.h267355070 = private unnamed_addr constant [9 x i8] c"Continue\00"
@.str.len4.h265982546 = private unnamed_addr constant [5 x i8] c"len(\00"
@.str.len3.h2087691079 = private unnamed_addr constant [4 x i8] c" = \00"
@.str.len11.h1898426375 = private unnamed_addr constant [12 x i8] c"while True:\00"
@.str.len31.h568140000 = private unnamed_addr constant [32 x i8] c" = runtime.enum_define_variant(\00"
@.enum.NativeInstruction.EndLoop.variant = private unnamed_addr constant [8 x i8] c"EndLoop\00"
@.str.len5.h843097466 = private unnamed_addr constant [6 x i8] c"False\00"
@.str.len8.h794378208 = private unnamed_addr constant [9 x i8] c"EndMatch\00"
@.str.len2.h193441217 = private unnamed_addr constant [3 x i8] c": \00"
@.str.len39.h198700275 = private unnamed_addr constant [40 x i8] c"# unsupported: endmatch without context\00"
@.str.len2.h193428644 = private unnamed_addr constant [3 x i8] c"./\00"
@.str.len5.h2095430042 = private unnamed_addr constant [6 x i8] c"false\00"
@.str.len11.h1460619898 = private unnamed_addr constant [12 x i8] c" (pattern: \00"
@.enum.NativeInstruction.Continue.variant = private unnamed_addr constant [9 x i8] c"Continue\00"
@.str.len15.h1983072220 = private unnamed_addr constant [16 x i8] c"# unsupported: \00"
@.enum.NativeInstruction.Case.variant = private unnamed_addr constant [5 x i8] c"Case\00"
@.str.len2.h193481015 = private unnamed_addr constant [3 x i8] c"\5Ct\00"
@.str.len4.h230767751 = private unnamed_addr constant [5 x i8] c"Noop\00"
@.str.len2.h193478474 = private unnamed_addr constant [3 x i8] c"\5C'\00"
@.str.len3.h2087924125 = private unnamed_addr constant [4 x i8] c"', \00"
@.str.len9.h757580446 = private unnamed_addr constant [10 x i8] c"#element:\00"
@.str.len5.h461434216 = private unnamed_addr constant [6 x i8] c"self.\00"
@.enum.NativeInstruction.Return.variant = private unnamed_addr constant [7 x i8] c"Return\00"
@.str.len5.h2069215535 = private unnamed_addr constant [6 x i8] c"elif \00"
@.str.len41.h1804821690 = private unnamed_addr constant [42 x i8] c"# unsupported: match case without context\00"
@.str.len4.h268720028 = private unnamed_addr constant [5 x i8] c"not \00"
@.enum.NativeInstruction.If.variant = private unnamed_addr constant [3 x i8] c"If\00"
@.str.len22.h983476432 = private unnamed_addr constant [23 x i8] c"if field.name == item:\00"
@.str.len2.h193459862 = private unnamed_addr constant [3 x i8] c"If\00"
@.str.len6.h42978514 = private unnamed_addr constant [7 x i8] c"export\00"
@.str.len2.h193419635 = private unnamed_addr constant [3 x i8] c"&&\00"
@.str.len7.h919609845 = private unnamed_addr constant [8 x i8] c"import \00"
@.str.len2.h193414949 = private unnamed_addr constant [3 x i8] c"!=\00"
@.str.len5.h819045845 = private unnamed_addr constant [6 x i8] c"EndIf\00"
@.enum.NativeInstruction.EndFor.variant = private unnamed_addr constant [7 x i8] c"EndFor\00"
@.str.len4.h217223495 = private unnamed_addr constant [5 x i8] c"Case\00"
@.enum.NativeInstruction.Unknown.variant = private unnamed_addr constant [8 x i8] c"Unknown\00"
@.str.len4.h268929446 = private unnamed_addr constant [5 x i8] c"null\00"
@.str.len39.h2079567388 = private unnamed_addr constant [40 x i8] c"match case without active match context\00"
@.enum.NativeInstruction.Expression.variant = private unnamed_addr constant [11 x i8] c"Expression\00"
@.str.len2.h193515005 = private unnamed_addr constant [3 x i8] c"{{\00"
