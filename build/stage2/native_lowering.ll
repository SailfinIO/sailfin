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
declare i1 @strings_equal(i8*, i8*)
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
  %t160 = phi %PythonBuilder [ %t108, %merge7 ], [ %t157, %loop.latch10 ]
  %t161 = phi { i8**, i64 }* [ %t109, %merge7 ], [ %t158, %loop.latch10 ]
  %t162 = phi double [ %t111, %merge7 ], [ %t159, %loop.latch10 ]
  store %PythonBuilder %t160, %PythonBuilder* %l0
  store { i8**, i64 }* %t161, { i8**, i64 }** %l1
  store double %t162, double* %l5
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
  %t123 = call double @llvm.round.f64(double %t122)
  %t124 = fptosi double %t123 to i64
  %t125 = load { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %functions
  %t126 = extractvalue { %NativeFunction*, i64 } %t125, 0
  %t127 = extractvalue { %NativeFunction*, i64 } %t125, 1
  %t128 = icmp uge i64 %t124, %t127
  ; bounds check: %t128 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t124, i64 %t127)
  %t129 = getelementptr %NativeFunction, %NativeFunction* %t126, i64 %t124
  %t130 = load %NativeFunction, %NativeFunction* %t129
  %t131 = call %PythonFunctionEmission @emit_python_function(%PythonBuilder %t121, %NativeFunction %t130)
  store %PythonFunctionEmission %t131, %PythonFunctionEmission* %l6
  %t132 = load %PythonFunctionEmission, %PythonFunctionEmission* %l6
  %t133 = extractvalue %PythonFunctionEmission %t132, 0
  store %PythonBuilder %t133, %PythonBuilder* %l0
  %t134 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t135 = load %PythonFunctionEmission, %PythonFunctionEmission* %l6
  %t136 = extractvalue %PythonFunctionEmission %t135, 1
  %t137 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t134, { i8**, i64 }* %t136)
  store { i8**, i64 }* %t137, { i8**, i64 }** %l1
  %t138 = load double, double* %l5
  %t139 = sitofp i64 1 to double
  %t140 = fadd double %t138, %t139
  %t141 = load { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %functions
  %t142 = extractvalue { %NativeFunction*, i64 } %t141, 1
  %t143 = sitofp i64 %t142 to double
  %t144 = fcmp olt double %t140, %t143
  %t145 = load %PythonBuilder, %PythonBuilder* %l0
  %t146 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t147 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t148 = load double, double* %l5
  %t149 = load %PythonFunctionEmission, %PythonFunctionEmission* %l6
  br i1 %t144, label %then14, label %merge15
then14:
  %t150 = load %PythonBuilder, %PythonBuilder* %l0
  %t151 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t150)
  store %PythonBuilder %t151, %PythonBuilder* %l0
  %t152 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge15
merge15:
  %t153 = phi %PythonBuilder [ %t152, %then14 ], [ %t145, %merge13 ]
  store %PythonBuilder %t153, %PythonBuilder* %l0
  %t154 = load double, double* %l5
  %t155 = sitofp i64 1 to double
  %t156 = fadd double %t154, %t155
  store double %t156, double* %l5
  br label %loop.latch10
loop.latch10:
  %t157 = load %PythonBuilder, %PythonBuilder* %l0
  %t158 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t159 = load double, double* %l5
  br label %loop.header8
afterloop11:
  %t163 = load %PythonBuilder, %PythonBuilder* %l0
  %t164 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t165 = load double, double* %l5
  %t166 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t167 = load { i8**, i64 }, { i8**, i64 }* %t166
  %t168 = extractvalue { i8**, i64 } %t167, 1
  %t169 = icmp sgt i64 %t168, 0
  %t170 = load %PythonBuilder, %PythonBuilder* %l0
  %t171 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t172 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t173 = load double, double* %l5
  br i1 %t169, label %then16, label %merge17
then16:
  %t174 = load %PythonBuilder, %PythonBuilder* %l0
  %t175 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t174)
  store %PythonBuilder %t175, %PythonBuilder* %l0
  %t176 = load %PythonBuilder, %PythonBuilder* %l0
  %t177 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t178 = call %PythonBuilder @emit_export_list(%PythonBuilder %t176, { i8**, i64 }* %t177)
  store %PythonBuilder %t178, %PythonBuilder* %l0
  %t179 = load %PythonBuilder, %PythonBuilder* %l0
  %t180 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge17
merge17:
  %t181 = phi %PythonBuilder [ %t179, %then16 ], [ %t170, %afterloop11 ]
  %t182 = phi %PythonBuilder [ %t180, %then16 ], [ %t170, %afterloop11 ]
  store %PythonBuilder %t181, %PythonBuilder* %l0
  store %PythonBuilder %t182, %PythonBuilder* %l0
  %t183 = load %PythonBuilder, %PythonBuilder* %l0
  %t184 = insertvalue %PythonModuleEmission undef, %PythonBuilder %t183, 0
  %t185 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t186 = insertvalue %PythonModuleEmission %t184, { i8**, i64 }* %t185, 1
  ret %PythonModuleEmission %t186
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
  %t53 = phi %PythonBuilder [ %t1, %block.entry ], [ %t51, %loop.latch2 ]
  %t54 = phi double [ %t2, %block.entry ], [ %t52, %loop.latch2 ]
  store %PythonBuilder %t53, %PythonBuilder* %l0
  store double %t54, double* %l1
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
  %t11 = call double @llvm.round.f64(double %t10)
  %t12 = fptosi double %t11 to i64
  %t13 = load { %NativeBinding*, i64 }, { %NativeBinding*, i64 }* %bindings
  %t14 = extractvalue { %NativeBinding*, i64 } %t13, 0
  %t15 = extractvalue { %NativeBinding*, i64 } %t13, 1
  %t16 = icmp uge i64 %t12, %t15
  ; bounds check: %t16 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t12, i64 %t15)
  %t17 = getelementptr %NativeBinding, %NativeBinding* %t14, i64 %t12
  %t18 = load %NativeBinding, %NativeBinding* %t17
  store %NativeBinding %t18, %NativeBinding* %l2
  %t19 = load %NativeBinding, %NativeBinding* %l2
  %t20 = extractvalue %NativeBinding %t19, 0
  %t21 = call i8* @sanitize_identifier(i8* %t20)
  store i8* %t21, i8** %l3
  %t22 = load i8*, i8** %l3
  %s23 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087691079, i32 0, i32 0
  %t24 = call i8* @sailfin_runtime_string_concat(i8* %t22, i8* %s23)
  store i8* %t24, i8** %l4
  %t25 = load %NativeBinding, %NativeBinding* %l2
  %t26 = extractvalue %NativeBinding %t25, 3
  %t27 = icmp ne i8* %t26, null
  %t28 = load %PythonBuilder, %PythonBuilder* %l0
  %t29 = load double, double* %l1
  %t30 = load %NativeBinding, %NativeBinding* %l2
  %t31 = load i8*, i8** %l3
  %t32 = load i8*, i8** %l4
  br i1 %t27, label %then6, label %else7
then6:
  %t33 = load %NativeBinding, %NativeBinding* %l2
  %t34 = extractvalue %NativeBinding %t33, 3
  store i8* %t34, i8** %l5
  %t35 = load i8*, i8** %l4
  %t36 = load i8*, i8** %l5
  %t37 = call i8* @lower_expression(i8* %t36)
  %t38 = call i8* @sailfin_runtime_string_concat(i8* %t35, i8* %t37)
  store i8* %t38, i8** %l4
  %t39 = load i8*, i8** %l4
  br label %merge8
else7:
  %t40 = load i8*, i8** %l4
  %s41 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h230766299, i32 0, i32 0
  %t42 = call i8* @sailfin_runtime_string_concat(i8* %t40, i8* %s41)
  store i8* %t42, i8** %l4
  %t43 = load i8*, i8** %l4
  br label %merge8
merge8:
  %t44 = phi i8* [ %t39, %then6 ], [ %t43, %else7 ]
  store i8* %t44, i8** %l4
  %t45 = load %PythonBuilder, %PythonBuilder* %l0
  %t46 = load i8*, i8** %l4
  %t47 = call %PythonBuilder @builder_emit(%PythonBuilder %t45, i8* %t46)
  store %PythonBuilder %t47, %PythonBuilder* %l0
  %t48 = load double, double* %l1
  %t49 = sitofp i64 1 to double
  %t50 = fadd double %t48, %t49
  store double %t50, double* %l1
  br label %loop.latch2
loop.latch2:
  %t51 = load %PythonBuilder, %PythonBuilder* %l0
  %t52 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t55 = load %PythonBuilder, %PythonBuilder* %l0
  %t56 = load double, double* %l1
  %t57 = load %PythonBuilder, %PythonBuilder* %l0
  ret %PythonBuilder %t57
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
  %t85 = phi { i8**, i64 }* [ %t14, %block.entry ], [ %t82, %loop.latch2 ]
  %t86 = phi double [ %t15, %block.entry ], [ %t83, %loop.latch2 ]
  %t87 = phi %PythonBuilder [ %t13, %block.entry ], [ %t84, %loop.latch2 ]
  store { i8**, i64 }* %t85, { i8**, i64 }** %l1
  store double %t86, double* %l2
  store %PythonBuilder %t87, %PythonBuilder* %l0
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
  %t25 = call double @llvm.round.f64(double %t24)
  %t26 = fptosi double %t25 to i64
  %t27 = load { %NativeImport*, i64 }, { %NativeImport*, i64 }* %imports
  %t28 = extractvalue { %NativeImport*, i64 } %t27, 0
  %t29 = extractvalue { %NativeImport*, i64 } %t27, 1
  %t30 = icmp uge i64 %t26, %t29
  ; bounds check: %t30 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t26, i64 %t29)
  %t31 = getelementptr %NativeImport, %NativeImport* %t28, i64 %t26
  %t32 = load %NativeImport, %NativeImport* %t31
  store %NativeImport %t32, %NativeImport* %l3
  %t33 = load %NativeImport, %NativeImport* %l3
  %t34 = extractvalue %NativeImport %t33, 0
  %s35 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h42978514, i32 0, i32 0
  %t36 = call i1 @strings_equal(i8* %t34, i8* %s35)
  %t37 = load %PythonBuilder, %PythonBuilder* %l0
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t39 = load double, double* %l2
  %t40 = load %NativeImport, %NativeImport* %l3
  br i1 %t36, label %then6, label %merge7
then6:
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t42 = load %NativeImport, %NativeImport* %l3
  %t43 = extractvalue %NativeImport %t42, 2
  %t44 = bitcast { %NativeImportSpecifier**, i64 }* %t43 to { %NativeImportSpecifier*, i64 }*
  %t45 = call { i8**, i64 }* @collect_export_names({ i8**, i64 }* %t41, { %NativeImportSpecifier*, i64 }* %t44)
  store { i8**, i64 }* %t45, { i8**, i64 }** %l1
  %t46 = load %NativeImport, %NativeImport* %l3
  %t47 = extractvalue %NativeImport %t46, 1
  %t48 = call i8* @trim_text(i8* %t47)
  store i8* %t48, i8** %l4
  %t49 = load i8*, i8** %l4
  %t50 = call i64 @sailfin_runtime_string_length(i8* %t49)
  %t51 = icmp eq i64 %t50, 0
  %t52 = load %PythonBuilder, %PythonBuilder* %l0
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t54 = load double, double* %l2
  %t55 = load %NativeImport, %NativeImport* %l3
  %t56 = load i8*, i8** %l4
  br i1 %t51, label %then8, label %merge9
then8:
  %t57 = load double, double* %l2
  %t58 = sitofp i64 1 to double
  %t59 = fadd double %t57, %t58
  store double %t59, double* %l2
  br label %loop.latch2
merge9:
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t61 = load double, double* %l2
  br label %merge7
merge7:
  %t62 = phi { i8**, i64 }* [ %t60, %merge9 ], [ %t38, %merge5 ]
  %t63 = phi double [ %t61, %merge9 ], [ %t39, %merge5 ]
  store { i8**, i64 }* %t62, { i8**, i64 }** %l1
  store double %t63, double* %l2
  %t64 = load %NativeImport, %NativeImport* %l3
  %t65 = call i8* @render_python_import(%NativeImport %t64)
  store i8* %t65, i8** %l5
  %t66 = load i8*, i8** %l5
  %t67 = call i64 @sailfin_runtime_string_length(i8* %t66)
  %t68 = icmp sgt i64 %t67, 0
  %t69 = load %PythonBuilder, %PythonBuilder* %l0
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t71 = load double, double* %l2
  %t72 = load %NativeImport, %NativeImport* %l3
  %t73 = load i8*, i8** %l5
  br i1 %t68, label %then10, label %merge11
then10:
  %t74 = load %PythonBuilder, %PythonBuilder* %l0
  %t75 = load i8*, i8** %l5
  %t76 = call %PythonBuilder @builder_emit(%PythonBuilder %t74, i8* %t75)
  store %PythonBuilder %t76, %PythonBuilder* %l0
  %t77 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge11
merge11:
  %t78 = phi %PythonBuilder [ %t77, %then10 ], [ %t69, %merge7 ]
  store %PythonBuilder %t78, %PythonBuilder* %l0
  %t79 = load double, double* %l2
  %t80 = sitofp i64 1 to double
  %t81 = fadd double %t79, %t80
  store double %t81, double* %l2
  br label %loop.latch2
loop.latch2:
  %t82 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t83 = load double, double* %l2
  %t84 = load %PythonBuilder, %PythonBuilder* %l0
  br label %loop.header0
afterloop3:
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t89 = load double, double* %l2
  %t90 = load %PythonBuilder, %PythonBuilder* %l0
  %t91 = load %PythonBuilder, %PythonBuilder* %l0
  %t92 = insertvalue %PythonImportEmission undef, %PythonBuilder %t91, 0
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t94 = insertvalue %PythonImportEmission %t92, { i8**, i64 }* %t93, 1
  ret %PythonImportEmission %t94
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
  %t39 = phi %PythonBuilder [ %t1, %block.entry ], [ %t37, %loop.latch2 ]
  %t40 = phi double [ %t2, %block.entry ], [ %t38, %loop.latch2 ]
  store %PythonBuilder %t39, %PythonBuilder* %l0
  store double %t40, double* %l1
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
  %t12 = call double @llvm.round.f64(double %t11)
  %t13 = fptosi double %t12 to i64
  %t14 = load { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* %enums
  %t15 = extractvalue { %NativeEnum*, i64 } %t14, 0
  %t16 = extractvalue { %NativeEnum*, i64 } %t14, 1
  %t17 = icmp uge i64 %t13, %t16
  ; bounds check: %t17 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t13, i64 %t16)
  %t18 = getelementptr %NativeEnum, %NativeEnum* %t15, i64 %t13
  %t19 = load %NativeEnum, %NativeEnum* %t18
  %t20 = call %PythonBuilder @emit_single_enum(%PythonBuilder %t10, %NativeEnum %t19)
  store %PythonBuilder %t20, %PythonBuilder* %l0
  %t21 = load double, double* %l1
  %t22 = sitofp i64 1 to double
  %t23 = fadd double %t21, %t22
  %t24 = load { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* %enums
  %t25 = extractvalue { %NativeEnum*, i64 } %t24, 1
  %t26 = sitofp i64 %t25 to double
  %t27 = fcmp olt double %t23, %t26
  %t28 = load %PythonBuilder, %PythonBuilder* %l0
  %t29 = load double, double* %l1
  br i1 %t27, label %then6, label %merge7
then6:
  %t30 = load %PythonBuilder, %PythonBuilder* %l0
  %t31 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t30)
  store %PythonBuilder %t31, %PythonBuilder* %l0
  %t32 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge7
merge7:
  %t33 = phi %PythonBuilder [ %t32, %then6 ], [ %t28, %merge5 ]
  store %PythonBuilder %t33, %PythonBuilder* %l0
  %t34 = load double, double* %l1
  %t35 = sitofp i64 1 to double
  %t36 = fadd double %t34, %t35
  store double %t36, double* %l1
  br label %loop.latch2
loop.latch2:
  %t37 = load %PythonBuilder, %PythonBuilder* %l0
  %t38 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t41 = load %PythonBuilder, %PythonBuilder* %l0
  %t42 = load double, double* %l1
  %t43 = load %PythonBuilder, %PythonBuilder* %l0
  ret %PythonBuilder %t43
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
  %t64 = phi %PythonBuilder [ %t12, %block.entry ], [ %t62, %loop.latch2 ]
  %t65 = phi double [ %t13, %block.entry ], [ %t63, %loop.latch2 ]
  store %PythonBuilder %t64, %PythonBuilder* %l1
  store double %t65, double* %l2
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
  %t25 = call double @llvm.round.f64(double %t24)
  %t26 = fptosi double %t25 to i64
  %t27 = load { %NativeEnumVariant**, i64 }, { %NativeEnumVariant**, i64 }* %t23
  %t28 = extractvalue { %NativeEnumVariant**, i64 } %t27, 0
  %t29 = extractvalue { %NativeEnumVariant**, i64 } %t27, 1
  %t30 = icmp uge i64 %t26, %t29
  ; bounds check: %t30 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t26, i64 %t29)
  %t31 = getelementptr %NativeEnumVariant*, %NativeEnumVariant** %t28, i64 %t26
  %t32 = load %NativeEnumVariant*, %NativeEnumVariant** %t31
  store %NativeEnumVariant* %t32, %NativeEnumVariant** %l3
  %t33 = load %NativeEnumVariant*, %NativeEnumVariant** %l3
  %t34 = getelementptr %NativeEnumVariant, %NativeEnumVariant* %t33, i32 0, i32 0
  %t35 = load i8*, i8** %t34
  %t36 = call i8* @sanitize_identifier(i8* %t35)
  store i8* %t36, i8** %l4
  %t37 = load i8*, i8** %l0
  %s38 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.len31.h568140000, i32 0, i32 0
  %t39 = call i8* @sailfin_runtime_string_concat(i8* %t37, i8* %s38)
  %t40 = load i8*, i8** %l0
  %t41 = call i8* @sailfin_runtime_string_concat(i8* %t39, i8* %t40)
  %s42 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2088090973, i32 0, i32 0
  %t43 = call i8* @sailfin_runtime_string_concat(i8* %t41, i8* %s42)
  %t44 = load i8*, i8** %l4
  %t45 = call i8* @sailfin_runtime_string_concat(i8* %t43, i8* %t44)
  %s46 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h182022329, i32 0, i32 0
  %t47 = call i8* @sailfin_runtime_string_concat(i8* %t45, i8* %s46)
  %t48 = load %NativeEnumVariant*, %NativeEnumVariant** %l3
  %t49 = getelementptr %NativeEnumVariant, %NativeEnumVariant* %t48, i32 0, i32 1
  %t50 = load { %NativeEnumVariantField**, i64 }*, { %NativeEnumVariantField**, i64 }** %t49
  %t51 = bitcast { %NativeEnumVariantField**, i64 }* %t50 to { %NativeEnumVariantField*, i64 }*
  %t52 = call i8* @render_enum_variant_fields({ %NativeEnumVariantField*, i64 }* %t51)
  %t53 = call i8* @sailfin_runtime_string_concat(i8* %t47, i8* %t52)
  %s54 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193479629, i32 0, i32 0
  %t55 = call i8* @sailfin_runtime_string_concat(i8* %t53, i8* %s54)
  store i8* %t55, i8** %l5
  %t56 = load %PythonBuilder, %PythonBuilder* %l1
  %t57 = load i8*, i8** %l5
  %t58 = call %PythonBuilder @builder_emit(%PythonBuilder %t56, i8* %t57)
  store %PythonBuilder %t58, %PythonBuilder* %l1
  %t59 = load double, double* %l2
  %t60 = sitofp i64 1 to double
  %t61 = fadd double %t59, %t60
  store double %t61, double* %l2
  br label %loop.latch2
loop.latch2:
  %t62 = load %PythonBuilder, %PythonBuilder* %l1
  %t63 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t66 = load %PythonBuilder, %PythonBuilder* %l1
  %t67 = load double, double* %l2
  %t68 = load %PythonBuilder, %PythonBuilder* %l1
  ret %PythonBuilder %t68
}

; NOTE: Returns string via output parameter %out_result
define void @render_enum_variant_fields({ %NativeEnumVariantField*, i64 }* %fields, i8** %out_result) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %t0 = load { %NativeEnumVariantField*, i64 }, { %NativeEnumVariantField*, i64 }* %fields
  %t1 = extractvalue { %NativeEnumVariantField*, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s3, i8** %out_result
  ret void
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
  %t54 = phi { i8**, i64 }* [ %t17, %merge1 ], [ %t52, %loop.latch4 ]
  %t55 = phi double [ %t18, %merge1 ], [ %t53, %loop.latch4 ]
  store { i8**, i64 }* %t54, { i8**, i64 }** %l0
  store double %t55, double* %l1
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
  %t28 = call double @llvm.round.f64(double %t27)
  %t29 = fptosi double %t28 to i64
  %t30 = load { %NativeEnumVariantField*, i64 }, { %NativeEnumVariantField*, i64 }* %fields
  %t31 = extractvalue { %NativeEnumVariantField*, i64 } %t30, 0
  %t32 = extractvalue { %NativeEnumVariantField*, i64 } %t30, 1
  %t33 = icmp uge i64 %t29, %t32
  ; bounds check: %t33 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t29, i64 %t32)
  %t34 = getelementptr %NativeEnumVariantField, %NativeEnumVariantField* %t31, i64 %t29
  %t35 = load %NativeEnumVariantField, %NativeEnumVariantField* %t34
  %t36 = extractvalue %NativeEnumVariantField %t35, 0
  %t37 = call i8* @sanitize_identifier(i8* %t36)
  %t38 = alloca [2 x i8], align 1
  %t39 = getelementptr [2 x i8], [2 x i8]* %t38, i32 0, i32 0
  store i8 39, i8* %t39
  %t40 = getelementptr [2 x i8], [2 x i8]* %t38, i32 0, i32 1
  store i8 0, i8* %t40
  %t41 = getelementptr [2 x i8], [2 x i8]* %t38, i32 0, i32 0
  %t42 = call i8* @sailfin_runtime_string_concat(i8* %t41, i8* %t37)
  %t43 = alloca [2 x i8], align 1
  %t44 = getelementptr [2 x i8], [2 x i8]* %t43, i32 0, i32 0
  store i8 39, i8* %t44
  %t45 = getelementptr [2 x i8], [2 x i8]* %t43, i32 0, i32 1
  store i8 0, i8* %t45
  %t46 = getelementptr [2 x i8], [2 x i8]* %t43, i32 0, i32 0
  %t47 = call i8* @sailfin_runtime_string_concat(i8* %t42, i8* %t46)
  %t48 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t26, i8* %t47)
  store { i8**, i64 }* %t48, { i8**, i64 }** %l0
  %t49 = load double, double* %l1
  %t50 = sitofp i64 1 to double
  %t51 = fadd double %t49, %t50
  store double %t51, double* %l1
  br label %loop.latch4
loop.latch4:
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t53 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t57 = load double, double* %l1
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s59 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t60 = call i8* @join_with_separator({ i8**, i64 }* %t58, i8* %s59)
  store i8* %t60, i8** %out_result
  ret void
}

; NOTE: Returns string via output parameter %out_result
define void @render_python_import(%NativeImport %entry, i8** %out_result) {
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
  store i8* %s6, i8** %out_result
  ret void
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
  store i8* %t14, i8** %out_result
  ret void
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
  store i8* %t24, i8** %out_result
  ret void
}

; NOTE: Returns string via output parameter %out_result
define void @render_python_specifiers({ %NativeImportSpecifier*, i64 }* %specifiers, i8** %out_result) {
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
  %t39 = phi { i8**, i64 }* [ %t13, %block.entry ], [ %t37, %loop.latch2 ]
  %t40 = phi double [ %t14, %block.entry ], [ %t38, %loop.latch2 ]
  store { i8**, i64 }* %t39, { i8**, i64 }** %l0
  store double %t40, double* %l1
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
  %t24 = call double @llvm.round.f64(double %t23)
  %t25 = fptosi double %t24 to i64
  %t26 = load { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %specifiers
  %t27 = extractvalue { %NativeImportSpecifier*, i64 } %t26, 0
  %t28 = extractvalue { %NativeImportSpecifier*, i64 } %t26, 1
  %t29 = icmp uge i64 %t25, %t28
  ; bounds check: %t29 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t25, i64 %t28)
  %t30 = getelementptr %NativeImportSpecifier, %NativeImportSpecifier* %t27, i64 %t25
  %t31 = load %NativeImportSpecifier, %NativeImportSpecifier* %t30
  %t32 = call i8* @render_python_specifier(%NativeImportSpecifier %t31)
  %t33 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t22, i8* %t32)
  store { i8**, i64 }* %t33, { i8**, i64 }** %l0
  %t34 = load double, double* %l1
  %t35 = sitofp i64 1 to double
  %t36 = fadd double %t34, %t35
  store double %t36, double* %l1
  br label %loop.latch2
loop.latch2:
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t38 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t42 = load double, double* %l1
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s44 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t45 = call i8* @join_with_separator({ i8**, i64 }* %t43, i8* %s44)
  store i8* %t45, i8** %out_result
  ret void
}

; NOTE: Returns string via output parameter %out_result
define void @render_python_specifier(%NativeImportSpecifier %specifier, i8** %out_result) {
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
  store i8* %t10, i8** %out_result
  ret void
merge1:
  %t11 = load i8*, i8** %l0
  %s12 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h175713983, i32 0, i32 0
  %t13 = call i8* @sailfin_runtime_string_concat(i8* %t11, i8* %s12)
  %t14 = extractvalue %NativeImportSpecifier %specifier, 1
  %t15 = call i8* @sanitize_identifier(i8* %t14)
  %t16 = call i8* @sailfin_runtime_string_concat(i8* %t13, i8* %t15)
  store i8* %t16, i8** %out_result
  ret void
}

; NOTE: Returns string via output parameter %out_result
define void @normalize_import_module(i8* %path, i8** %out_result) {
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
  store i8* %t5, i8** %out_result
  ret void
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
  store i8* %t22, i8** %out_result
  ret void
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
  store i8* %t43, i8** %out_result
  ret void
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
  store i8* %t53, i8** %out_result
  ret void
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
  %t62 = phi %PythonBuilder [ %t13, %block.entry ], [ %t59, %loop.latch2 ]
  %t63 = phi { i8**, i64 }* [ %t14, %block.entry ], [ %t60, %loop.latch2 ]
  %t64 = phi double [ %t15, %block.entry ], [ %t61, %loop.latch2 ]
  store %PythonBuilder %t62, %PythonBuilder* %l0
  store { i8**, i64 }* %t63, { i8**, i64 }** %l1
  store double %t64, double* %l2
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
  %t26 = call double @llvm.round.f64(double %t25)
  %t27 = fptosi double %t26 to i64
  %t28 = load { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* %structs
  %t29 = extractvalue { %NativeStruct*, i64 } %t28, 0
  %t30 = extractvalue { %NativeStruct*, i64 } %t28, 1
  %t31 = icmp uge i64 %t27, %t30
  ; bounds check: %t31 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t27, i64 %t30)
  %t32 = getelementptr %NativeStruct, %NativeStruct* %t29, i64 %t27
  %t33 = load %NativeStruct, %NativeStruct* %t32
  %t34 = call %PythonStructEmission @emit_single_struct(%PythonBuilder %t24, %NativeStruct %t33)
  store %PythonStructEmission %t34, %PythonStructEmission* %l3
  %t35 = load %PythonStructEmission, %PythonStructEmission* %l3
  %t36 = extractvalue %PythonStructEmission %t35, 0
  store %PythonBuilder %t36, %PythonBuilder* %l0
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t38 = load %PythonStructEmission, %PythonStructEmission* %l3
  %t39 = extractvalue %PythonStructEmission %t38, 1
  %t40 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t37, { i8**, i64 }* %t39)
  store { i8**, i64 }* %t40, { i8**, i64 }** %l1
  %t41 = load double, double* %l2
  %t42 = sitofp i64 1 to double
  %t43 = fadd double %t41, %t42
  %t44 = load { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* %structs
  %t45 = extractvalue { %NativeStruct*, i64 } %t44, 1
  %t46 = sitofp i64 %t45 to double
  %t47 = fcmp olt double %t43, %t46
  %t48 = load %PythonBuilder, %PythonBuilder* %l0
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t50 = load double, double* %l2
  %t51 = load %PythonStructEmission, %PythonStructEmission* %l3
  br i1 %t47, label %then6, label %merge7
then6:
  %t52 = load %PythonBuilder, %PythonBuilder* %l0
  %t53 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t52)
  store %PythonBuilder %t53, %PythonBuilder* %l0
  %t54 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge7
merge7:
  %t55 = phi %PythonBuilder [ %t54, %then6 ], [ %t48, %merge5 ]
  store %PythonBuilder %t55, %PythonBuilder* %l0
  %t56 = load double, double* %l2
  %t57 = sitofp i64 1 to double
  %t58 = fadd double %t56, %t57
  store double %t58, double* %l2
  br label %loop.latch2
loop.latch2:
  %t59 = load %PythonBuilder, %PythonBuilder* %l0
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t61 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t65 = load %PythonBuilder, %PythonBuilder* %l0
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t67 = load double, double* %l2
  %t68 = load %PythonBuilder, %PythonBuilder* %l0
  %t69 = insertvalue %PythonStructEmission undef, %PythonBuilder %t68, 0
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t71 = insertvalue %PythonStructEmission %t69, { i8**, i64 }* %t70, 1
  ret %PythonStructEmission %t71
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
  %t92 = phi { i8**, i64 }* [ %t13, %block.entry ], [ %t90, %loop.latch2 ]
  %t93 = phi double [ %t14, %block.entry ], [ %t91, %loop.latch2 ]
  store { i8**, i64 }* %t92, { i8**, i64 }** %l0
  store double %t93, double* %l1
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
  %t23 = call double @llvm.round.f64(double %t22)
  %t24 = fptosi double %t23 to i64
  %t25 = load { i8**, i64 }, { i8**, i64 }* %exports
  %t26 = extractvalue { i8**, i64 } %t25, 0
  %t27 = extractvalue { i8**, i64 } %t25, 1
  %t28 = icmp uge i64 %t24, %t27
  ; bounds check: %t28 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t24, i64 %t27)
  %t29 = getelementptr i8*, i8** %t26, i64 %t24
  %t30 = load i8*, i8** %t29
  %t31 = call i8* @sanitize_identifier(i8* %t30)
  store i8* %t31, i8** %l2
  store i1 0, i1* %l3
  %t32 = sitofp i64 0 to double
  store double %t32, double* %l4
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t34 = load double, double* %l1
  %t35 = load i8*, i8** %l2
  %t36 = load i1, i1* %l3
  %t37 = load double, double* %l4
  br label %loop.header6
loop.header6:
  %t71 = phi i1 [ %t36, %merge5 ], [ %t69, %loop.latch8 ]
  %t72 = phi double [ %t37, %merge5 ], [ %t70, %loop.latch8 ]
  store i1 %t71, i1* %l3
  store double %t72, double* %l4
  br label %loop.body7
loop.body7:
  %t38 = load double, double* %l4
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t40 = load { i8**, i64 }, { i8**, i64 }* %t39
  %t41 = extractvalue { i8**, i64 } %t40, 1
  %t42 = sitofp i64 %t41 to double
  %t43 = fcmp oge double %t38, %t42
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t45 = load double, double* %l1
  %t46 = load i8*, i8** %l2
  %t47 = load i1, i1* %l3
  %t48 = load double, double* %l4
  br i1 %t43, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t50 = load double, double* %l4
  %t51 = call double @llvm.round.f64(double %t50)
  %t52 = fptosi double %t51 to i64
  %t53 = load { i8**, i64 }, { i8**, i64 }* %t49
  %t54 = extractvalue { i8**, i64 } %t53, 0
  %t55 = extractvalue { i8**, i64 } %t53, 1
  %t56 = icmp uge i64 %t52, %t55
  ; bounds check: %t56 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t52, i64 %t55)
  %t57 = getelementptr i8*, i8** %t54, i64 %t52
  %t58 = load i8*, i8** %t57
  %t59 = load i8*, i8** %l2
  %t60 = call i1 @strings_equal(i8* %t58, i8* %t59)
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t62 = load double, double* %l1
  %t63 = load i8*, i8** %l2
  %t64 = load i1, i1* %l3
  %t65 = load double, double* %l4
  br i1 %t60, label %then12, label %merge13
then12:
  store i1 1, i1* %l3
  br label %afterloop9
merge13:
  %t66 = load double, double* %l4
  %t67 = sitofp i64 1 to double
  %t68 = fadd double %t66, %t67
  store double %t68, double* %l4
  br label %loop.latch8
loop.latch8:
  %t69 = load i1, i1* %l3
  %t70 = load double, double* %l4
  br label %loop.header6
afterloop9:
  %t73 = load i1, i1* %l3
  %t74 = load double, double* %l4
  %t75 = load i1, i1* %l3
  %t76 = xor i1 %t75, 1
  %t77 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t78 = load double, double* %l1
  %t79 = load i8*, i8** %l2
  %t80 = load i1, i1* %l3
  %t81 = load double, double* %l4
  br i1 %t76, label %then14, label %merge15
then14:
  %t82 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t83 = load i8*, i8** %l2
  %t84 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t82, i8* %t83)
  store { i8**, i64 }* %t84, { i8**, i64 }** %l0
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge15
merge15:
  %t86 = phi { i8**, i64 }* [ %t85, %then14 ], [ %t77, %afterloop9 ]
  store { i8**, i64 }* %t86, { i8**, i64 }** %l0
  %t87 = load double, double* %l1
  %t88 = sitofp i64 1 to double
  %t89 = fadd double %t87, %t88
  store double %t89, double* %l1
  br label %loop.latch2
loop.latch2:
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t91 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t94 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t95 = load double, double* %l1
  %t96 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t97 = ptrtoint [0 x i8*]* %t96 to i64
  %t98 = icmp eq i64 %t97, 0
  %t99 = select i1 %t98, i64 1, i64 %t97
  %t100 = call i8* @malloc(i64 %t99)
  %t101 = bitcast i8* %t100 to i8**
  %t102 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t103 = ptrtoint { i8**, i64 }* %t102 to i64
  %t104 = call i8* @malloc(i64 %t103)
  %t105 = bitcast i8* %t104 to { i8**, i64 }*
  %t106 = getelementptr { i8**, i64 }, { i8**, i64 }* %t105, i32 0, i32 0
  store i8** %t101, i8*** %t106
  %t107 = getelementptr { i8**, i64 }, { i8**, i64 }* %t105, i32 0, i32 1
  store i64 0, i64* %t107
  store { i8**, i64 }* %t105, { i8**, i64 }** %l5
  %t108 = sitofp i64 0 to double
  store double %t108, double* %l1
  %t109 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t110 = load double, double* %l1
  %t111 = load { i8**, i64 }*, { i8**, i64 }** %l5
  br label %loop.header16
loop.header16:
  %t148 = phi { i8**, i64 }* [ %t111, %afterloop3 ], [ %t146, %loop.latch18 ]
  %t149 = phi double [ %t110, %afterloop3 ], [ %t147, %loop.latch18 ]
  store { i8**, i64 }* %t148, { i8**, i64 }** %l5
  store double %t149, double* %l1
  br label %loop.body17
loop.body17:
  %t112 = load double, double* %l1
  %t113 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t114 = load { i8**, i64 }, { i8**, i64 }* %t113
  %t115 = extractvalue { i8**, i64 } %t114, 1
  %t116 = sitofp i64 %t115 to double
  %t117 = fcmp oge double %t112, %t116
  %t118 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t119 = load double, double* %l1
  %t120 = load { i8**, i64 }*, { i8**, i64 }** %l5
  br i1 %t117, label %then20, label %merge21
then20:
  br label %afterloop19
merge21:
  %t121 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t122 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t123 = load double, double* %l1
  %t124 = call double @llvm.round.f64(double %t123)
  %t125 = fptosi double %t124 to i64
  %t126 = load { i8**, i64 }, { i8**, i64 }* %t122
  %t127 = extractvalue { i8**, i64 } %t126, 0
  %t128 = extractvalue { i8**, i64 } %t126, 1
  %t129 = icmp uge i64 %t125, %t128
  ; bounds check: %t129 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t125, i64 %t128)
  %t130 = getelementptr i8*, i8** %t127, i64 %t125
  %t131 = load i8*, i8** %t130
  %t132 = alloca [2 x i8], align 1
  %t133 = getelementptr [2 x i8], [2 x i8]* %t132, i32 0, i32 0
  store i8 34, i8* %t133
  %t134 = getelementptr [2 x i8], [2 x i8]* %t132, i32 0, i32 1
  store i8 0, i8* %t134
  %t135 = getelementptr [2 x i8], [2 x i8]* %t132, i32 0, i32 0
  %t136 = call i8* @sailfin_runtime_string_concat(i8* %t135, i8* %t131)
  %t137 = alloca [2 x i8], align 1
  %t138 = getelementptr [2 x i8], [2 x i8]* %t137, i32 0, i32 0
  store i8 34, i8* %t138
  %t139 = getelementptr [2 x i8], [2 x i8]* %t137, i32 0, i32 1
  store i8 0, i8* %t139
  %t140 = getelementptr [2 x i8], [2 x i8]* %t137, i32 0, i32 0
  %t141 = call i8* @sailfin_runtime_string_concat(i8* %t136, i8* %t140)
  %t142 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t121, i8* %t141)
  store { i8**, i64 }* %t142, { i8**, i64 }** %l5
  %t143 = load double, double* %l1
  %t144 = sitofp i64 1 to double
  %t145 = fadd double %t143, %t144
  store double %t145, double* %l1
  br label %loop.latch18
loop.latch18:
  %t146 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t147 = load double, double* %l1
  br label %loop.header16
afterloop19:
  %t150 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t151 = load double, double* %l1
  %s152 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1657754115, i32 0, i32 0
  %t153 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %s154 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t155 = call i8* @join_with_separator({ i8**, i64 }* %t153, i8* %s154)
  %t156 = call i8* @sailfin_runtime_string_concat(i8* %s152, i8* %t155)
  %t157 = alloca [2 x i8], align 1
  %t158 = getelementptr [2 x i8], [2 x i8]* %t157, i32 0, i32 0
  store i8 93, i8* %t158
  %t159 = getelementptr [2 x i8], [2 x i8]* %t157, i32 0, i32 1
  store i8 0, i8* %t159
  %t160 = getelementptr [2 x i8], [2 x i8]* %t157, i32 0, i32 0
  %t161 = call i8* @sailfin_runtime_string_concat(i8* %t156, i8* %t160)
  %t162 = call %PythonBuilder @builder_emit(%PythonBuilder %builder, i8* %t161)
  ret %PythonBuilder %t162
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
  %t38 = phi { i8**, i64 }* [ %t1, %block.entry ], [ %t36, %loop.latch2 ]
  %t39 = phi double [ %t2, %block.entry ], [ %t37, %loop.latch2 ]
  store { i8**, i64 }* %t38, { i8**, i64 }** %l0
  store double %t39, double* %l1
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
  %t11 = call double @llvm.round.f64(double %t10)
  %t12 = fptosi double %t11 to i64
  %t13 = load { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %specifiers
  %t14 = extractvalue { %NativeImportSpecifier*, i64 } %t13, 0
  %t15 = extractvalue { %NativeImportSpecifier*, i64 } %t13, 1
  %t16 = icmp uge i64 %t12, %t15
  ; bounds check: %t16 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t12, i64 %t15)
  %t17 = getelementptr %NativeImportSpecifier, %NativeImportSpecifier* %t14, i64 %t12
  %t18 = load %NativeImportSpecifier, %NativeImportSpecifier* %t17
  store %NativeImportSpecifier %t18, %NativeImportSpecifier* %l2
  %t19 = load %NativeImportSpecifier, %NativeImportSpecifier* %l2
  %t20 = call i8* @select_export_name(%NativeImportSpecifier %t19)
  store i8* %t20, i8** %l3
  %t21 = load i8*, i8** %l3
  %t22 = call i64 @sailfin_runtime_string_length(i8* %t21)
  %t23 = icmp sgt i64 %t22, 0
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t25 = load double, double* %l1
  %t26 = load %NativeImportSpecifier, %NativeImportSpecifier* %l2
  %t27 = load i8*, i8** %l3
  br i1 %t23, label %then6, label %merge7
then6:
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t29 = load i8*, i8** %l3
  %t30 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t28, i8* %t29)
  store { i8**, i64 }* %t30, { i8**, i64 }** %l0
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge7
merge7:
  %t32 = phi { i8**, i64 }* [ %t31, %then6 ], [ %t24, %merge5 ]
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
  ret { i8**, i64 }* %t42
}

; NOTE: Returns string via output parameter %out_result
define void @select_export_name(%NativeImportSpecifier %specifier, i8** %out_result) {
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
  store i8* %t7, i8** %out_result
  ret void
merge1:
  %t8 = extractvalue %NativeImportSpecifier %specifier, 0
  store i8* %t8, i8** %out_result
  ret void
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
  %t123 = phi %PythonBuilder [ %t78, %else3 ], [ %t121, %loop.latch7 ]
  %t124 = phi double [ %t82, %else3 ], [ %t122, %loop.latch7 ]
  store %PythonBuilder %t123, %PythonBuilder* %l1
  store double %t124, double* %l5
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
  %t97 = call double @llvm.round.f64(double %t96)
  %t98 = fptosi double %t97 to i64
  %t99 = load { %NativeStructField**, i64 }, { %NativeStructField**, i64 }* %t95
  %t100 = extractvalue { %NativeStructField**, i64 } %t99, 0
  %t101 = extractvalue { %NativeStructField**, i64 } %t99, 1
  %t102 = icmp uge i64 %t98, %t101
  ; bounds check: %t102 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t98, i64 %t101)
  %t103 = getelementptr %NativeStructField*, %NativeStructField** %t100, i64 %t98
  %t104 = load %NativeStructField*, %NativeStructField** %t103
  store %NativeStructField* %t104, %NativeStructField** %l6
  %t105 = load %NativeStructField*, %NativeStructField** %l6
  %t106 = getelementptr %NativeStructField, %NativeStructField* %t105, i32 0, i32 0
  %t107 = load i8*, i8** %t106
  %t108 = call i8* @sanitize_identifier(i8* %t107)
  store i8* %t108, i8** %l7
  %t109 = load %PythonBuilder, %PythonBuilder* %l1
  %s110 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h461434216, i32 0, i32 0
  %t111 = load i8*, i8** %l7
  %t112 = call i8* @sailfin_runtime_string_concat(i8* %s110, i8* %t111)
  %s113 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087691079, i32 0, i32 0
  %t114 = call i8* @sailfin_runtime_string_concat(i8* %t112, i8* %s113)
  %t115 = load i8*, i8** %l7
  %t116 = call i8* @sailfin_runtime_string_concat(i8* %t114, i8* %t115)
  %t117 = call %PythonBuilder @builder_emit(%PythonBuilder %t109, i8* %t116)
  store %PythonBuilder %t117, %PythonBuilder* %l1
  %t118 = load double, double* %l5
  %t119 = sitofp i64 1 to double
  %t120 = fadd double %t118, %t119
  store double %t120, double* %l5
  br label %loop.latch7
loop.latch7:
  %t121 = load %PythonBuilder, %PythonBuilder* %l1
  %t122 = load double, double* %l5
  br label %loop.header5
afterloop8:
  %t125 = load %PythonBuilder, %PythonBuilder* %l1
  %t126 = load double, double* %l5
  %t127 = load %PythonBuilder, %PythonBuilder* %l1
  br label %merge4
merge4:
  %t128 = phi %PythonBuilder [ %t75, %then2 ], [ %t127, %afterloop8 ]
  store %PythonBuilder %t128, %PythonBuilder* %l1
  %t129 = load %PythonBuilder, %PythonBuilder* %l1
  %t130 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t129)
  store %PythonBuilder %t130, %PythonBuilder* %l1
  %t131 = load %PythonBuilder, %PythonBuilder* %l1
  %t132 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t131)
  store %PythonBuilder %t132, %PythonBuilder* %l1
  %t133 = load %PythonBuilder, %PythonBuilder* %l1
  %s134 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h1806641125, i32 0, i32 0
  %t135 = call %PythonBuilder @builder_emit(%PythonBuilder %t133, i8* %s134)
  store %PythonBuilder %t135, %PythonBuilder* %l1
  %t136 = load %PythonBuilder, %PythonBuilder* %l1
  %t137 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t136)
  store %PythonBuilder %t137, %PythonBuilder* %l1
  %t138 = load i8*, i8** %l0
  %t139 = extractvalue %NativeStruct %definition, 1
  %t140 = bitcast { %NativeStructField**, i64 }* %t139 to { %NativeStructField*, i64 }*
  %t141 = call i8* @render_struct_repr_fields(i8* %t138, { %NativeStructField*, i64 }* %t140)
  store i8* %t141, i8** %l8
  %t142 = load %PythonBuilder, %PythonBuilder* %l1
  %t143 = load i8*, i8** %l8
  %t144 = call %PythonBuilder @builder_emit(%PythonBuilder %t142, i8* %t143)
  store %PythonBuilder %t144, %PythonBuilder* %l1
  %t145 = load %PythonBuilder, %PythonBuilder* %l1
  %t146 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t145)
  store %PythonBuilder %t146, %PythonBuilder* %l1
  %t147 = load i8*, i8** %l0
  %s148 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h300877395, i32 0, i32 0
  %t149 = call i1 @strings_equal(i8* %t147, i8* %s148)
  %t150 = load i8*, i8** %l0
  %t151 = load %PythonBuilder, %PythonBuilder* %l1
  %t152 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t153 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t154 = load i8*, i8** %l4
  %t155 = load i8*, i8** %l8
  br i1 %t149, label %then11, label %merge12
then11:
  %t156 = load %PythonBuilder, %PythonBuilder* %l1
  %t157 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t156)
  store %PythonBuilder %t157, %PythonBuilder* %l1
  %t158 = load %PythonBuilder, %PythonBuilder* %l1
  %s159 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.len28.h430828782, i32 0, i32 0
  %t160 = call %PythonBuilder @builder_emit(%PythonBuilder %t158, i8* %s159)
  store %PythonBuilder %t160, %PythonBuilder* %l1
  %t161 = load %PythonBuilder, %PythonBuilder* %l1
  %t162 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t161)
  store %PythonBuilder %t162, %PythonBuilder* %l1
  %t163 = load %PythonBuilder, %PythonBuilder* %l1
  %s164 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h320851598, i32 0, i32 0
  %t165 = call %PythonBuilder @builder_emit(%PythonBuilder %t163, i8* %s164)
  store %PythonBuilder %t165, %PythonBuilder* %l1
  %t166 = load %PythonBuilder, %PythonBuilder* %l1
  %s167 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1898426375, i32 0, i32 0
  %t168 = call %PythonBuilder @builder_emit(%PythonBuilder %t166, i8* %s167)
  store %PythonBuilder %t168, %PythonBuilder* %l1
  %t169 = load %PythonBuilder, %PythonBuilder* %l1
  %t170 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t169)
  store %PythonBuilder %t170, %PythonBuilder* %l1
  %t171 = load %PythonBuilder, %PythonBuilder* %l1
  %s172 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.len29.h610920064, i32 0, i32 0
  %t173 = call %PythonBuilder @builder_emit(%PythonBuilder %t171, i8* %s172)
  store %PythonBuilder %t173, %PythonBuilder* %l1
  %t174 = load %PythonBuilder, %PythonBuilder* %l1
  %t175 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t174)
  store %PythonBuilder %t175, %PythonBuilder* %l1
  %t176 = load %PythonBuilder, %PythonBuilder* %l1
  %s177 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1958778164, i32 0, i32 0
  %t178 = call %PythonBuilder @builder_emit(%PythonBuilder %t176, i8* %s177)
  store %PythonBuilder %t178, %PythonBuilder* %l1
  %t179 = load %PythonBuilder, %PythonBuilder* %l1
  %t180 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t179)
  store %PythonBuilder %t180, %PythonBuilder* %l1
  %t181 = load %PythonBuilder, %PythonBuilder* %l1
  %s182 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.len26.h1088202076, i32 0, i32 0
  %t183 = call %PythonBuilder @builder_emit(%PythonBuilder %t181, i8* %s182)
  store %PythonBuilder %t183, %PythonBuilder* %l1
  %t184 = load %PythonBuilder, %PythonBuilder* %l1
  %s185 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h983476432, i32 0, i32 0
  %t186 = call %PythonBuilder @builder_emit(%PythonBuilder %t184, i8* %s185)
  store %PythonBuilder %t186, %PythonBuilder* %l1
  %t187 = load %PythonBuilder, %PythonBuilder* %l1
  %t188 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t187)
  store %PythonBuilder %t188, %PythonBuilder* %l1
  %t189 = load %PythonBuilder, %PythonBuilder* %l1
  %s190 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.len18.h1456282769, i32 0, i32 0
  %t191 = call %PythonBuilder @builder_emit(%PythonBuilder %t189, i8* %s190)
  store %PythonBuilder %t191, %PythonBuilder* %l1
  %t192 = load %PythonBuilder, %PythonBuilder* %l1
  %t193 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t192)
  store %PythonBuilder %t193, %PythonBuilder* %l1
  %t194 = load %PythonBuilder, %PythonBuilder* %l1
  %s195 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h1977847647, i32 0, i32 0
  %t196 = call %PythonBuilder @builder_emit(%PythonBuilder %t194, i8* %s195)
  store %PythonBuilder %t196, %PythonBuilder* %l1
  %t197 = load %PythonBuilder, %PythonBuilder* %l1
  %t198 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t197)
  store %PythonBuilder %t198, %PythonBuilder* %l1
  %t199 = load %PythonBuilder, %PythonBuilder* %l1
  %s200 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.len26.h1984174475, i32 0, i32 0
  %t201 = call %PythonBuilder @builder_emit(%PythonBuilder %t199, i8* %s200)
  store %PythonBuilder %t201, %PythonBuilder* %l1
  %t202 = load %PythonBuilder, %PythonBuilder* %l1
  %t203 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t202)
  store %PythonBuilder %t203, %PythonBuilder* %l1
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
  %t222 = load %PythonBuilder, %PythonBuilder* %l1
  br label %merge12
merge12:
  %t223 = phi %PythonBuilder [ %t204, %then11 ], [ %t151, %merge4 ]
  %t224 = phi %PythonBuilder [ %t205, %then11 ], [ %t151, %merge4 ]
  %t225 = phi %PythonBuilder [ %t206, %then11 ], [ %t151, %merge4 ]
  %t226 = phi %PythonBuilder [ %t207, %then11 ], [ %t151, %merge4 ]
  %t227 = phi %PythonBuilder [ %t208, %then11 ], [ %t151, %merge4 ]
  %t228 = phi %PythonBuilder [ %t209, %then11 ], [ %t151, %merge4 ]
  %t229 = phi %PythonBuilder [ %t210, %then11 ], [ %t151, %merge4 ]
  %t230 = phi %PythonBuilder [ %t211, %then11 ], [ %t151, %merge4 ]
  %t231 = phi %PythonBuilder [ %t212, %then11 ], [ %t151, %merge4 ]
  %t232 = phi %PythonBuilder [ %t213, %then11 ], [ %t151, %merge4 ]
  %t233 = phi %PythonBuilder [ %t214, %then11 ], [ %t151, %merge4 ]
  %t234 = phi %PythonBuilder [ %t215, %then11 ], [ %t151, %merge4 ]
  %t235 = phi %PythonBuilder [ %t216, %then11 ], [ %t151, %merge4 ]
  %t236 = phi %PythonBuilder [ %t217, %then11 ], [ %t151, %merge4 ]
  %t237 = phi %PythonBuilder [ %t218, %then11 ], [ %t151, %merge4 ]
  %t238 = phi %PythonBuilder [ %t219, %then11 ], [ %t151, %merge4 ]
  %t239 = phi %PythonBuilder [ %t220, %then11 ], [ %t151, %merge4 ]
  %t240 = phi %PythonBuilder [ %t221, %then11 ], [ %t151, %merge4 ]
  %t241 = phi %PythonBuilder [ %t222, %then11 ], [ %t151, %merge4 ]
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
  store %PythonBuilder %t241, %PythonBuilder* %l1
  %t242 = extractvalue %NativeStruct %definition, 2
  %t243 = load { %NativeFunction**, i64 }, { %NativeFunction**, i64 }* %t242
  %t244 = extractvalue { %NativeFunction**, i64 } %t243, 1
  %t245 = icmp sgt i64 %t244, 0
  %t246 = load i8*, i8** %l0
  %t247 = load %PythonBuilder, %PythonBuilder* %l1
  %t248 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t249 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t250 = load i8*, i8** %l4
  %t251 = load i8*, i8** %l8
  br i1 %t245, label %then13, label %merge14
then13:
  %t252 = load %PythonBuilder, %PythonBuilder* %l1
  %t253 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t252)
  store %PythonBuilder %t253, %PythonBuilder* %l1
  %t254 = sitofp i64 0 to double
  store double %t254, double* %l9
  %t255 = load i8*, i8** %l0
  %t256 = load %PythonBuilder, %PythonBuilder* %l1
  %t257 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t258 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t259 = load i8*, i8** %l4
  %t260 = load i8*, i8** %l8
  %t261 = load double, double* %l9
  br label %loop.header15
loop.header15:
  %t322 = phi %PythonBuilder [ %t256, %then13 ], [ %t319, %loop.latch17 ]
  %t323 = phi { i8**, i64 }* [ %t257, %then13 ], [ %t320, %loop.latch17 ]
  %t324 = phi double [ %t261, %then13 ], [ %t321, %loop.latch17 ]
  store %PythonBuilder %t322, %PythonBuilder* %l1
  store { i8**, i64 }* %t323, { i8**, i64 }** %l2
  store double %t324, double* %l9
  br label %loop.body16
loop.body16:
  %t262 = load double, double* %l9
  %t263 = extractvalue %NativeStruct %definition, 2
  %t264 = load { %NativeFunction**, i64 }, { %NativeFunction**, i64 }* %t263
  %t265 = extractvalue { %NativeFunction**, i64 } %t264, 1
  %t266 = sitofp i64 %t265 to double
  %t267 = fcmp oge double %t262, %t266
  %t268 = load i8*, i8** %l0
  %t269 = load %PythonBuilder, %PythonBuilder* %l1
  %t270 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t271 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t272 = load i8*, i8** %l4
  %t273 = load i8*, i8** %l8
  %t274 = load double, double* %l9
  br i1 %t267, label %then19, label %merge20
then19:
  br label %afterloop18
merge20:
  %t275 = extractvalue %NativeStruct %definition, 2
  %t276 = load double, double* %l9
  %t277 = call double @llvm.round.f64(double %t276)
  %t278 = fptosi double %t277 to i64
  %t279 = load { %NativeFunction**, i64 }, { %NativeFunction**, i64 }* %t275
  %t280 = extractvalue { %NativeFunction**, i64 } %t279, 0
  %t281 = extractvalue { %NativeFunction**, i64 } %t279, 1
  %t282 = icmp uge i64 %t278, %t281
  ; bounds check: %t282 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t278, i64 %t281)
  %t283 = getelementptr %NativeFunction*, %NativeFunction** %t280, i64 %t278
  %t284 = load %NativeFunction*, %NativeFunction** %t283
  store %NativeFunction* %t284, %NativeFunction** %l10
  %t285 = load %PythonBuilder, %PythonBuilder* %l1
  %t286 = load %NativeFunction*, %NativeFunction** %l10
  %t287 = load %NativeFunction, %NativeFunction* %t286
  %t288 = call %PythonFunctionEmission @emit_python_function(%PythonBuilder %t285, %NativeFunction %t287)
  store %PythonFunctionEmission %t288, %PythonFunctionEmission* %l11
  %t289 = load %PythonFunctionEmission, %PythonFunctionEmission* %l11
  %t290 = extractvalue %PythonFunctionEmission %t289, 0
  store %PythonBuilder %t290, %PythonBuilder* %l1
  %t291 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t292 = load %PythonFunctionEmission, %PythonFunctionEmission* %l11
  %t293 = extractvalue %PythonFunctionEmission %t292, 1
  %t294 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t291, { i8**, i64 }* %t293)
  store { i8**, i64 }* %t294, { i8**, i64 }** %l2
  %t295 = load double, double* %l9
  %t296 = sitofp i64 1 to double
  %t297 = fadd double %t295, %t296
  %t298 = extractvalue %NativeStruct %definition, 2
  %t299 = load { %NativeFunction**, i64 }, { %NativeFunction**, i64 }* %t298
  %t300 = extractvalue { %NativeFunction**, i64 } %t299, 1
  %t301 = sitofp i64 %t300 to double
  %t302 = fcmp olt double %t297, %t301
  %t303 = load i8*, i8** %l0
  %t304 = load %PythonBuilder, %PythonBuilder* %l1
  %t305 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t306 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t307 = load i8*, i8** %l4
  %t308 = load i8*, i8** %l8
  %t309 = load double, double* %l9
  %t310 = load %NativeFunction*, %NativeFunction** %l10
  %t311 = load %PythonFunctionEmission, %PythonFunctionEmission* %l11
  br i1 %t302, label %then21, label %merge22
then21:
  %t312 = load %PythonBuilder, %PythonBuilder* %l1
  %t313 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t312)
  store %PythonBuilder %t313, %PythonBuilder* %l1
  %t314 = load %PythonBuilder, %PythonBuilder* %l1
  br label %merge22
merge22:
  %t315 = phi %PythonBuilder [ %t314, %then21 ], [ %t304, %merge20 ]
  store %PythonBuilder %t315, %PythonBuilder* %l1
  %t316 = load double, double* %l9
  %t317 = sitofp i64 1 to double
  %t318 = fadd double %t316, %t317
  store double %t318, double* %l9
  br label %loop.latch17
loop.latch17:
  %t319 = load %PythonBuilder, %PythonBuilder* %l1
  %t320 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t321 = load double, double* %l9
  br label %loop.header15
afterloop18:
  %t325 = load %PythonBuilder, %PythonBuilder* %l1
  %t326 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t327 = load double, double* %l9
  %t328 = load %PythonBuilder, %PythonBuilder* %l1
  %t329 = load %PythonBuilder, %PythonBuilder* %l1
  %t330 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br label %merge14
merge14:
  %t331 = phi %PythonBuilder [ %t328, %afterloop18 ], [ %t247, %merge12 ]
  %t332 = phi %PythonBuilder [ %t329, %afterloop18 ], [ %t247, %merge12 ]
  %t333 = phi { i8**, i64 }* [ %t330, %afterloop18 ], [ %t248, %merge12 ]
  store %PythonBuilder %t331, %PythonBuilder* %l1
  store %PythonBuilder %t332, %PythonBuilder* %l1
  store { i8**, i64 }* %t333, { i8**, i64 }** %l2
  %t334 = load %PythonBuilder, %PythonBuilder* %l1
  %t335 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t334)
  store %PythonBuilder %t335, %PythonBuilder* %l1
  %t336 = load %PythonBuilder, %PythonBuilder* %l1
  %t337 = insertvalue %PythonStructEmission undef, %PythonBuilder %t336, 0
  %t338 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t339 = insertvalue %PythonStructEmission %t337, { i8**, i64 }* %t338, 1
  ret %PythonStructEmission %t339
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
  %t79 = phi { i8**, i64 }* [ %t26, %block.entry ], [ %t76, %loop.latch2 ]
  %t80 = phi { i8**, i64 }* [ %t25, %block.entry ], [ %t77, %loop.latch2 ]
  %t81 = phi double [ %t27, %block.entry ], [ %t78, %loop.latch2 ]
  store { i8**, i64 }* %t79, { i8**, i64 }** %l1
  store { i8**, i64 }* %t80, { i8**, i64 }** %l0
  store double %t81, double* %l2
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
  %t37 = call double @llvm.round.f64(double %t36)
  %t38 = fptosi double %t37 to i64
  %t39 = load { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %fields
  %t40 = extractvalue { %NativeStructField*, i64 } %t39, 0
  %t41 = extractvalue { %NativeStructField*, i64 } %t39, 1
  %t42 = icmp uge i64 %t38, %t41
  ; bounds check: %t42 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t38, i64 %t41)
  %t43 = getelementptr %NativeStructField, %NativeStructField* %t40, i64 %t38
  %t44 = load %NativeStructField, %NativeStructField* %t43
  store %NativeStructField %t44, %NativeStructField* %l3
  %t45 = load %NativeStructField, %NativeStructField* %l3
  %t46 = extractvalue %NativeStructField %t45, 0
  %t47 = call i8* @sanitize_identifier(i8* %t46)
  store i8* %t47, i8** %l4
  %t48 = load i8*, i8** %l4
  store i8* %t48, i8** %l5
  %t49 = load %NativeStructField, %NativeStructField* %l3
  %t50 = extractvalue %NativeStructField %t49, 1
  %t51 = call i1 @is_optional_type(i8* %t50)
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t54 = load double, double* %l2
  %t55 = load %NativeStructField, %NativeStructField* %l3
  %t56 = load i8*, i8** %l4
  %t57 = load i8*, i8** %l5
  br i1 %t51, label %then6, label %else7
then6:
  %t58 = load i8*, i8** %l5
  %s59 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h468448796, i32 0, i32 0
  %t60 = call i8* @sailfin_runtime_string_concat(i8* %t58, i8* %s59)
  store i8* %t60, i8** %l5
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t62 = load i8*, i8** %l5
  %t63 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t61, i8* %t62)
  store { i8**, i64 }* %t63, { i8**, i64 }** %l1
  %t64 = load i8*, i8** %l5
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge8
else7:
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t67 = load i8*, i8** %l5
  %t68 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t66, i8* %t67)
  store { i8**, i64 }* %t68, { i8**, i64 }** %l0
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge8
merge8:
  %t70 = phi i8* [ %t64, %then6 ], [ %t57, %else7 ]
  %t71 = phi { i8**, i64 }* [ %t65, %then6 ], [ %t53, %else7 ]
  %t72 = phi { i8**, i64 }* [ %t52, %then6 ], [ %t69, %else7 ]
  store i8* %t70, i8** %l5
  store { i8**, i64 }* %t71, { i8**, i64 }** %l1
  store { i8**, i64 }* %t72, { i8**, i64 }** %l0
  %t73 = load double, double* %l2
  %t74 = sitofp i64 1 to double
  %t75 = fadd double %t73, %t74
  store double %t75, double* %l2
  br label %loop.latch2
loop.latch2:
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t77 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t78 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t82 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t84 = load double, double* %l2
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t86 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t87 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t85, { i8**, i64 }* %t86)
  ret { i8**, i64 }* %t87
}

; NOTE: Returns string via output parameter %out_result
define void @render_struct_repr_fields(i8* %class_name, { %NativeStructField*, i64 }* %fields, i8** %out_result) {
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
  store i8* %t6, i8** %out_result
  ret void
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
  %t60 = phi { i8**, i64 }* [ %t20, %merge1 ], [ %t58, %loop.latch4 ]
  %t61 = phi double [ %t21, %merge1 ], [ %t59, %loop.latch4 ]
  store { i8**, i64 }* %t60, { i8**, i64 }** %l0
  store double %t61, double* %l1
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
  %t30 = call double @llvm.round.f64(double %t29)
  %t31 = fptosi double %t30 to i64
  %t32 = load { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %fields
  %t33 = extractvalue { %NativeStructField*, i64 } %t32, 0
  %t34 = extractvalue { %NativeStructField*, i64 } %t32, 1
  %t35 = icmp uge i64 %t31, %t34
  ; bounds check: %t35 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t31, i64 %t34)
  %t36 = getelementptr %NativeStructField, %NativeStructField* %t33, i64 %t31
  %t37 = load %NativeStructField, %NativeStructField* %t36
  store %NativeStructField %t37, %NativeStructField* %l2
  %t38 = load %NativeStructField, %NativeStructField* %l2
  %t39 = extractvalue %NativeStructField %t38, 0
  %t40 = call i8* @sanitize_identifier(i8* %t39)
  store i8* %t40, i8** %l3
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s42 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h1038501153, i32 0, i32 0
  %t43 = load i8*, i8** %l3
  %t44 = call i8* @sailfin_runtime_string_concat(i8* %s42, i8* %t43)
  %s45 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h104511138, i32 0, i32 0
  %t46 = call i8* @sailfin_runtime_string_concat(i8* %t44, i8* %s45)
  %t47 = load i8*, i8** %l3
  %t48 = call i8* @sailfin_runtime_string_concat(i8* %t46, i8* %t47)
  %t49 = alloca [2 x i8], align 1
  %t50 = getelementptr [2 x i8], [2 x i8]* %t49, i32 0, i32 0
  store i8 41, i8* %t50
  %t51 = getelementptr [2 x i8], [2 x i8]* %t49, i32 0, i32 1
  store i8 0, i8* %t51
  %t52 = getelementptr [2 x i8], [2 x i8]* %t49, i32 0, i32 0
  %t53 = call i8* @sailfin_runtime_string_concat(i8* %t48, i8* %t52)
  %t54 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t41, i8* %t53)
  store { i8**, i64 }* %t54, { i8**, i64 }** %l0
  %t55 = load double, double* %l1
  %t56 = sitofp i64 1 to double
  %t57 = fadd double %t55, %t56
  store double %t57, double* %l1
  br label %loop.latch4
loop.latch4:
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t59 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t63 = load double, double* %l1
  %s64 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.len28.h1179318158, i32 0, i32 0
  %t65 = call i8* @sailfin_runtime_string_concat(i8* %s64, i8* %class_name)
  %s66 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h182022329, i32 0, i32 0
  %t67 = call i8* @sailfin_runtime_string_concat(i8* %t65, i8* %s66)
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s69 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t70 = call i8* @join_with_separator({ i8**, i64 }* %t68, i8* %s69)
  %t71 = call i8* @sailfin_runtime_string_concat(i8* %t67, i8* %t70)
  %s72 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193479629, i32 0, i32 0
  %t73 = call i8* @sailfin_runtime_string_concat(i8* %t71, i8* %s72)
  store i8* %t73, i8** %out_result
  ret void
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

; NOTE: Returns string via output parameter %out_result
define void @lower_expression(i8* %expression, i8** %out_result) {
block.entry:
  %t0 = sitofp i64 0 to double
  %t1 = call i8* @lower_expression_with_depth(i8* %expression, double %t0)
  store i8* %t1, i8** %out_result
  ret void
}

; NOTE: Returns string via output parameter %out_result
define void @lower_expression_with_depth(i8* %expression, double %depth, i8** %out_result) {
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
  store i8* %t2, i8** %out_result
  ret void
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
  store i8* %t8, i8** %out_result
  ret void
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
  store i8* %t15, i8** %out_result
  ret void
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
  store i8* %t23, i8** %out_result
  ret void
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
  store i8* %t32, i8** %out_result
  ret void
merge9:
  %t33 = load i8*, i8** %l0
  %t34 = call i8* @rewrite_expression_intrinsics(i8* %t33)
  store i8* %t34, i8** %l4
  %t35 = load i8*, i8** %l4
  %t36 = call i8* @rewrite_array_literals_inline(i8* %t35, double %depth)
  store i8* %t36, i8** %l5
  %t37 = load i8*, i8** %l5
  %t38 = call i8* @rewrite_struct_literals_inline(i8* %t37, double %depth)
  store i8* %t38, i8** %out_result
  ret void
}

; NOTE: Returns string via output parameter %out_result
define void @rewrite_interpolated_string_literal(i8* %expression, i8** %out_result) {
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
  store i8* null, i8** %out_result
  ret void
merge1:
  %t2 = call i8* @decode_string_literal(i8* %expression)
  store i8* %t2, i8** %l0
  %t3 = load i8*, i8** %l0
  %t4 = icmp eq i8* %t3, null
  %t5 = load i8*, i8** %l0
  br i1 %t4, label %then2, label %merge3
then2:
  store i8* null, i8** %out_result
  ret void
merge3:
  %t6 = load i8*, i8** %l0
  %s7 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193515005, i32 0, i32 0
  %t8 = call double @find_substring(i8* %t6, i8* %s7)
  %t9 = sitofp i64 0 to double
  %t10 = fcmp olt double %t8, %t9
  %t11 = load i8*, i8** %l0
  br i1 %t10, label %then4, label %merge5
then4:
  store i8* null, i8** %out_result
  ret void
merge5:
  %t12 = load i8*, i8** %l0
  %s13 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193517249, i32 0, i32 0
  %t14 = call double @find_substring(i8* %t12, i8* %s13)
  %t15 = sitofp i64 0 to double
  %t16 = fcmp olt double %t14, %t15
  %t17 = load i8*, i8** %l0
  br i1 %t16, label %then6, label %merge7
then6:
  store i8* null, i8** %out_result
  ret void
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
  %t133 = phi { i8**, i64 }* [ %t43, %merge7 ], [ %t130, %loop.latch10 ]
  %t134 = phi { i8**, i64 }* [ %t44, %merge7 ], [ %t131, %loop.latch10 ]
  %t135 = phi i64 [ %t45, %merge7 ], [ %t132, %loop.latch10 ]
  store { i8**, i64 }* %t133, { i8**, i64 }** %l1
  store { i8**, i64 }* %t134, { i8**, i64 }** %l2
  store i64 %t135, i64* %l3
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
  %t78 = call double @llvm.round.f64(double %t77)
  %t79 = fptosi double %t78 to i64
  %t80 = call i8* @sailfin_runtime_substring(i8* %t75, i64 %t76, i64 %t79)
  store i8* %t80, i8** %l6
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t82 = load i8*, i8** %l6
  %t83 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t81, i8* %t82)
  store { i8**, i64 }* %t83, { i8**, i64 }** %l1
  %t84 = load i8*, i8** %l0
  %s85 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193517249, i32 0, i32 0
  %t86 = load double, double* %l4
  %t87 = sitofp i64 2 to double
  %t88 = fadd double %t86, %t87
  %t89 = call double @find_substring_from(i8* %t84, i8* %s85, double %t88)
  store double %t89, double* %l7
  %t90 = load double, double* %l7
  %t91 = sitofp i64 0 to double
  %t92 = fcmp olt double %t90, %t91
  %t93 = load i8*, i8** %l0
  %t94 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t95 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t96 = load i64, i64* %l3
  %t97 = load double, double* %l4
  %t98 = load i8*, i8** %l6
  %t99 = load double, double* %l7
  br i1 %t92, label %then16, label %merge17
then16:
  store i8* null, i8** %out_result
  ret void
merge17:
  %t100 = load i8*, i8** %l0
  %t101 = load double, double* %l4
  %t102 = sitofp i64 2 to double
  %t103 = fadd double %t101, %t102
  %t104 = load double, double* %l7
  %t105 = call double @llvm.round.f64(double %t103)
  %t106 = fptosi double %t105 to i64
  %t107 = call double @llvm.round.f64(double %t104)
  %t108 = fptosi double %t107 to i64
  %t109 = call i8* @sailfin_runtime_substring(i8* %t100, i64 %t106, i64 %t108)
  %t110 = call i8* @trim_text(i8* %t109)
  store i8* %t110, i8** %l8
  %t111 = load i8*, i8** %l8
  %t112 = call i64 @sailfin_runtime_string_length(i8* %t111)
  %t113 = icmp eq i64 %t112, 0
  %t114 = load i8*, i8** %l0
  %t115 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t116 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t117 = load i64, i64* %l3
  %t118 = load double, double* %l4
  %t119 = load i8*, i8** %l6
  %t120 = load double, double* %l7
  %t121 = load i8*, i8** %l8
  br i1 %t113, label %then18, label %merge19
then18:
  store i8* null, i8** %out_result
  ret void
merge19:
  %t122 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t123 = load i8*, i8** %l8
  %t124 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t122, i8* %t123)
  store { i8**, i64 }* %t124, { i8**, i64 }** %l2
  %t125 = load double, double* %l7
  %t126 = sitofp i64 2 to double
  %t127 = fadd double %t125, %t126
  %t128 = call double @llvm.round.f64(double %t127)
  %t129 = fptosi double %t128 to i64
  store i64 %t129, i64* %l3
  br label %loop.latch10
loop.latch10:
  %t130 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t131 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t132 = load i64, i64* %l3
  br label %loop.header8
afterloop11:
  %t136 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t137 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t138 = load i64, i64* %l3
  %t139 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t140 = load { i8**, i64 }, { i8**, i64 }* %t139
  %t141 = extractvalue { i8**, i64 } %t140, 1
  %t142 = icmp eq i64 %t141, 0
  %t143 = load i8*, i8** %l0
  %t144 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t145 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t146 = load i64, i64* %l3
  br i1 %t142, label %then20, label %merge21
then20:
  store i8* null, i8** %out_result
  ret void
merge21:
  %t147 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t148 = ptrtoint [0 x i8*]* %t147 to i64
  %t149 = icmp eq i64 %t148, 0
  %t150 = select i1 %t149, i64 1, i64 %t148
  %t151 = call i8* @malloc(i64 %t150)
  %t152 = bitcast i8* %t151 to i8**
  %t153 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t154 = ptrtoint { i8**, i64 }* %t153 to i64
  %t155 = call i8* @malloc(i64 %t154)
  %t156 = bitcast i8* %t155 to { i8**, i64 }*
  %t157 = getelementptr { i8**, i64 }, { i8**, i64 }* %t156, i32 0, i32 0
  store i8** %t152, i8*** %t157
  %t158 = getelementptr { i8**, i64 }, { i8**, i64 }* %t156, i32 0, i32 1
  store i64 0, i64* %t158
  store { i8**, i64 }* %t156, { i8**, i64 }** %l9
  %t159 = sitofp i64 0 to double
  store double %t159, double* %l10
  %t160 = load i8*, i8** %l0
  %t161 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t162 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t163 = load i64, i64* %l3
  %t164 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t165 = load double, double* %l10
  br label %loop.header22
loop.header22:
  %t196 = phi { i8**, i64 }* [ %t164, %merge21 ], [ %t194, %loop.latch24 ]
  %t197 = phi double [ %t165, %merge21 ], [ %t195, %loop.latch24 ]
  store { i8**, i64 }* %t196, { i8**, i64 }** %l9
  store double %t197, double* %l10
  br label %loop.body23
loop.body23:
  %t166 = load double, double* %l10
  %t167 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t168 = load { i8**, i64 }, { i8**, i64 }* %t167
  %t169 = extractvalue { i8**, i64 } %t168, 1
  %t170 = sitofp i64 %t169 to double
  %t171 = fcmp oge double %t166, %t170
  %t172 = load i8*, i8** %l0
  %t173 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t174 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t175 = load i64, i64* %l3
  %t176 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t177 = load double, double* %l10
  br i1 %t171, label %then26, label %merge27
then26:
  br label %afterloop25
merge27:
  %t178 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t179 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t180 = load double, double* %l10
  %t181 = call double @llvm.round.f64(double %t180)
  %t182 = fptosi double %t181 to i64
  %t183 = load { i8**, i64 }, { i8**, i64 }* %t179
  %t184 = extractvalue { i8**, i64 } %t183, 0
  %t185 = extractvalue { i8**, i64 } %t183, 1
  %t186 = icmp uge i64 %t182, %t185
  ; bounds check: %t186 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t182, i64 %t185)
  %t187 = getelementptr i8*, i8** %t184, i64 %t182
  %t188 = load i8*, i8** %t187
  %t189 = call i8* @python_string_literal(i8* %t188)
  %t190 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t178, i8* %t189)
  store { i8**, i64 }* %t190, { i8**, i64 }** %l9
  %t191 = load double, double* %l10
  %t192 = sitofp i64 1 to double
  %t193 = fadd double %t191, %t192
  store double %t193, double* %l10
  br label %loop.latch24
loop.latch24:
  %t194 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t195 = load double, double* %l10
  br label %loop.header22
afterloop25:
  %t198 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t199 = load double, double* %l10
  %t200 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t201 = ptrtoint [0 x i8*]* %t200 to i64
  %t202 = icmp eq i64 %t201, 0
  %t203 = select i1 %t202, i64 1, i64 %t201
  %t204 = call i8* @malloc(i64 %t203)
  %t205 = bitcast i8* %t204 to i8**
  %t206 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t207 = ptrtoint { i8**, i64 }* %t206 to i64
  %t208 = call i8* @malloc(i64 %t207)
  %t209 = bitcast i8* %t208 to { i8**, i64 }*
  %t210 = getelementptr { i8**, i64 }, { i8**, i64 }* %t209, i32 0, i32 0
  store i8** %t205, i8*** %t210
  %t211 = getelementptr { i8**, i64 }, { i8**, i64 }* %t209, i32 0, i32 1
  store i64 0, i64* %t211
  store { i8**, i64 }* %t209, { i8**, i64 }** %l11
  %t212 = sitofp i64 0 to double
  store double %t212, double* %l10
  %t213 = load i8*, i8** %l0
  %t214 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t215 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t216 = load i64, i64* %l3
  %t217 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t218 = load double, double* %l10
  %t219 = load { i8**, i64 }*, { i8**, i64 }** %l11
  br label %loop.header28
loop.header28:
  %t260 = phi { i8**, i64 }* [ %t219, %afterloop25 ], [ %t258, %loop.latch30 ]
  %t261 = phi double [ %t218, %afterloop25 ], [ %t259, %loop.latch30 ]
  store { i8**, i64 }* %t260, { i8**, i64 }** %l11
  store double %t261, double* %l10
  br label %loop.body29
loop.body29:
  %t220 = load double, double* %l10
  %t221 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t222 = load { i8**, i64 }, { i8**, i64 }* %t221
  %t223 = extractvalue { i8**, i64 } %t222, 1
  %t224 = sitofp i64 %t223 to double
  %t225 = fcmp oge double %t220, %t224
  %t226 = load i8*, i8** %l0
  %t227 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t228 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t229 = load i64, i64* %l3
  %t230 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t231 = load double, double* %l10
  %t232 = load { i8**, i64 }*, { i8**, i64 }** %l11
  br i1 %t225, label %then32, label %merge33
then32:
  br label %afterloop31
merge33:
  %t233 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %t234 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t235 = load double, double* %l10
  %t236 = call double @llvm.round.f64(double %t235)
  %t237 = fptosi double %t236 to i64
  %t238 = load { i8**, i64 }, { i8**, i64 }* %t234
  %t239 = extractvalue { i8**, i64 } %t238, 0
  %t240 = extractvalue { i8**, i64 } %t238, 1
  %t241 = icmp uge i64 %t237, %t240
  ; bounds check: %t241 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t237, i64 %t240)
  %t242 = getelementptr i8*, i8** %t239, i64 %t237
  %t243 = load i8*, i8** %t242
  %t244 = alloca [2 x i8], align 1
  %t245 = getelementptr [2 x i8], [2 x i8]* %t244, i32 0, i32 0
  store i8 40, i8* %t245
  %t246 = getelementptr [2 x i8], [2 x i8]* %t244, i32 0, i32 1
  store i8 0, i8* %t246
  %t247 = getelementptr [2 x i8], [2 x i8]* %t244, i32 0, i32 0
  %t248 = call i8* @sailfin_runtime_string_concat(i8* %t247, i8* %t243)
  %t249 = alloca [2 x i8], align 1
  %t250 = getelementptr [2 x i8], [2 x i8]* %t249, i32 0, i32 0
  store i8 41, i8* %t250
  %t251 = getelementptr [2 x i8], [2 x i8]* %t249, i32 0, i32 1
  store i8 0, i8* %t251
  %t252 = getelementptr [2 x i8], [2 x i8]* %t249, i32 0, i32 0
  %t253 = call i8* @sailfin_runtime_string_concat(i8* %t248, i8* %t252)
  %t254 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t233, i8* %t253)
  store { i8**, i64 }* %t254, { i8**, i64 }** %l11
  %t255 = load double, double* %l10
  %t256 = sitofp i64 1 to double
  %t257 = fadd double %t255, %t256
  store double %t257, double* %l10
  br label %loop.latch30
loop.latch30:
  %t258 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %t259 = load double, double* %l10
  br label %loop.header28
afterloop31:
  %t262 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %t263 = load double, double* %l10
  %t264 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %s265 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t266 = call i8* @join_with_separator({ i8**, i64 }* %t264, i8* %s265)
  %t267 = alloca [2 x i8], align 1
  %t268 = getelementptr [2 x i8], [2 x i8]* %t267, i32 0, i32 0
  store i8 91, i8* %t268
  %t269 = getelementptr [2 x i8], [2 x i8]* %t267, i32 0, i32 1
  store i8 0, i8* %t269
  %t270 = getelementptr [2 x i8], [2 x i8]* %t267, i32 0, i32 0
  %t271 = call i8* @sailfin_runtime_string_concat(i8* %t270, i8* %t266)
  %t272 = alloca [2 x i8], align 1
  %t273 = getelementptr [2 x i8], [2 x i8]* %t272, i32 0, i32 0
  store i8 93, i8* %t273
  %t274 = getelementptr [2 x i8], [2 x i8]* %t272, i32 0, i32 1
  store i8 0, i8* %t274
  %t275 = getelementptr [2 x i8], [2 x i8]* %t272, i32 0, i32 0
  %t276 = call i8* @sailfin_runtime_string_concat(i8* %t271, i8* %t275)
  store i8* %t276, i8** %l12
  %t277 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %s278 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t279 = call i8* @join_with_separator({ i8**, i64 }* %t277, i8* %s278)
  %t280 = alloca [2 x i8], align 1
  %t281 = getelementptr [2 x i8], [2 x i8]* %t280, i32 0, i32 0
  store i8 91, i8* %t281
  %t282 = getelementptr [2 x i8], [2 x i8]* %t280, i32 0, i32 1
  store i8 0, i8* %t282
  %t283 = getelementptr [2 x i8], [2 x i8]* %t280, i32 0, i32 0
  %t284 = call i8* @sailfin_runtime_string_concat(i8* %t283, i8* %t279)
  %t285 = alloca [2 x i8], align 1
  %t286 = getelementptr [2 x i8], [2 x i8]* %t285, i32 0, i32 0
  store i8 93, i8* %t286
  %t287 = getelementptr [2 x i8], [2 x i8]* %t285, i32 0, i32 1
  store i8 0, i8* %t287
  %t288 = getelementptr [2 x i8], [2 x i8]* %t285, i32 0, i32 0
  %t289 = call i8* @sailfin_runtime_string_concat(i8* %t284, i8* %t288)
  store i8* %t289, i8** %l13
  %s290 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.len28.h583209964, i32 0, i32 0
  %t291 = load i8*, i8** %l12
  %t292 = call i8* @sailfin_runtime_string_concat(i8* %s290, i8* %t291)
  %s293 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t294 = call i8* @sailfin_runtime_string_concat(i8* %t292, i8* %s293)
  %t295 = load i8*, i8** %l13
  %t296 = call i8* @sailfin_runtime_string_concat(i8* %t294, i8* %t295)
  %t297 = alloca [2 x i8], align 1
  %t298 = getelementptr [2 x i8], [2 x i8]* %t297, i32 0, i32 0
  store i8 41, i8* %t298
  %t299 = getelementptr [2 x i8], [2 x i8]* %t297, i32 0, i32 1
  store i8 0, i8* %t299
  %t300 = getelementptr [2 x i8], [2 x i8]* %t297, i32 0, i32 0
  %t301 = call i8* @sailfin_runtime_string_concat(i8* %t296, i8* %t300)
  store i8* %t301, i8** %out_result
  ret void
}

; NOTE: Returns string via output parameter %out_result
define void @decode_string_literal(i8* %expression, i8** %out_result) {
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
  store i8* null, i8** %out_result
  ret void
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
  store i8* null, i8** %out_result
  ret void
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
  store i8* null, i8** %out_result
  ret void
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
  store i8* null, i8** %out_result
  ret void
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
  store i8* %t81, i8** %out_result
  ret void
}

; NOTE: Returns string via output parameter %out_result
define void @decode_escape_sequence(i8* %escape, i8* %quote, i8** %out_result) {
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
  store i8* %t5, i8** %out_result
  ret void
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
  store i8* %t11, i8** %out_result
  ret void
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
  store i8* %t17, i8** %out_result
  ret void
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
  store i8* %t23, i8** %out_result
  ret void
merge7:
  %t24 = call i1 @strings_equal(i8* %escape, i8* %quote)
  br i1 %t24, label %then8, label %merge9
then8:
  store i8* %quote, i8** %out_result
  ret void
merge9:
  store i8* %escape, i8** %out_result
  ret void
}

; NOTE: Returns string via output parameter %out_result
define void @python_string_literal(i8* %value, i8** %out_result) {
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
  store i8* %t117, i8** %out_result
  ret void
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

; NOTE: Returns string via output parameter %out_result
define void @lower_struct_literal_expression(i8* %expression, double %depth, i8** %out_result) {
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
  store i8* null, i8** %out_result
  ret void
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
  store i8* null, i8** %out_result
  ret void
merge3:
  %t16 = load double, double* %l0
  %t17 = call double @llvm.round.f64(double %t16)
  %t18 = fptosi double %t17 to i64
  %t19 = call i8* @sailfin_runtime_substring(i8* %expression, i64 0, i64 %t18)
  %t20 = call i8* @trim_text(i8* %t19)
  store i8* %t20, i8** %l2
  %t21 = load i8*, i8** %l2
  %t22 = call i64 @sailfin_runtime_string_length(i8* %t21)
  %t23 = icmp eq i64 %t22, 0
  %t24 = load double, double* %l0
  %t25 = load double, double* %l1
  %t26 = load i8*, i8** %l2
  br i1 %t23, label %then4, label %merge5
then4:
  store i8* null, i8** %out_result
  ret void
merge5:
  %t27 = load i8*, i8** %l2
  %t28 = call i1 @is_struct_literal_type_candidate(i8* %t27)
  %t29 = xor i1 %t28, 1
  %t30 = load double, double* %l0
  %t31 = load double, double* %l1
  %t32 = load i8*, i8** %l2
  br i1 %t29, label %then6, label %merge7
then6:
  store i8* null, i8** %out_result
  ret void
merge7:
  %t33 = load double, double* %l0
  %t34 = sitofp i64 1 to double
  %t35 = fadd double %t33, %t34
  %t36 = load double, double* %l1
  %t37 = call double @llvm.round.f64(double %t35)
  %t38 = fptosi double %t37 to i64
  %t39 = call double @llvm.round.f64(double %t36)
  %t40 = fptosi double %t39 to i64
  %t41 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t38, i64 %t40)
  store i8* %t41, i8** %l3
  %t42 = load i8*, i8** %l3
  %t43 = call { i8**, i64 }* @split_struct_field_entries(i8* %t42)
  store { i8**, i64 }* %t43, { i8**, i64 }** %l4
  %t44 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t45 = ptrtoint [0 x i8*]* %t44 to i64
  %t46 = icmp eq i64 %t45, 0
  %t47 = select i1 %t46, i64 1, i64 %t45
  %t48 = call i8* @malloc(i64 %t47)
  %t49 = bitcast i8* %t48 to i8**
  %t50 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t51 = ptrtoint { i8**, i64 }* %t50 to i64
  %t52 = call i8* @malloc(i64 %t51)
  %t53 = bitcast i8* %t52 to { i8**, i64 }*
  %t54 = getelementptr { i8**, i64 }, { i8**, i64 }* %t53, i32 0, i32 0
  store i8** %t49, i8*** %t54
  %t55 = getelementptr { i8**, i64 }, { i8**, i64 }* %t53, i32 0, i32 1
  store i64 0, i64* %t55
  store { i8**, i64 }* %t53, { i8**, i64 }** %l5
  %t56 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t57 = ptrtoint [0 x i8*]* %t56 to i64
  %t58 = icmp eq i64 %t57, 0
  %t59 = select i1 %t58, i64 1, i64 %t57
  %t60 = call i8* @malloc(i64 %t59)
  %t61 = bitcast i8* %t60 to i8**
  %t62 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t63 = ptrtoint { i8**, i64 }* %t62 to i64
  %t64 = call i8* @malloc(i64 %t63)
  %t65 = bitcast i8* %t64 to { i8**, i64 }*
  %t66 = getelementptr { i8**, i64 }, { i8**, i64 }* %t65, i32 0, i32 0
  store i8** %t61, i8*** %t66
  %t67 = getelementptr { i8**, i64 }, { i8**, i64 }* %t65, i32 0, i32 1
  store i64 0, i64* %t67
  store { i8**, i64 }* %t65, { i8**, i64 }** %l6
  %t68 = sitofp i64 0 to double
  store double %t68, double* %l7
  %t69 = load double, double* %l0
  %t70 = load double, double* %l1
  %t71 = load i8*, i8** %l2
  %t72 = load i8*, i8** %l3
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t76 = load double, double* %l7
  br label %loop.header8
loop.header8:
  %t210 = phi double [ %t76, %merge7 ], [ %t207, %loop.latch10 ]
  %t211 = phi { i8**, i64 }* [ %t74, %merge7 ], [ %t208, %loop.latch10 ]
  %t212 = phi { i8**, i64 }* [ %t75, %merge7 ], [ %t209, %loop.latch10 ]
  store double %t210, double* %l7
  store { i8**, i64 }* %t211, { i8**, i64 }** %l5
  store { i8**, i64 }* %t212, { i8**, i64 }** %l6
  br label %loop.body9
loop.body9:
  %t77 = load double, double* %l7
  %t78 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t79 = load { i8**, i64 }, { i8**, i64 }* %t78
  %t80 = extractvalue { i8**, i64 } %t79, 1
  %t81 = sitofp i64 %t80 to double
  %t82 = fcmp oge double %t77, %t81
  %t83 = load double, double* %l0
  %t84 = load double, double* %l1
  %t85 = load i8*, i8** %l2
  %t86 = load i8*, i8** %l3
  %t87 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t90 = load double, double* %l7
  br i1 %t82, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t91 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t92 = load double, double* %l7
  %t93 = call double @llvm.round.f64(double %t92)
  %t94 = fptosi double %t93 to i64
  %t95 = load { i8**, i64 }, { i8**, i64 }* %t91
  %t96 = extractvalue { i8**, i64 } %t95, 0
  %t97 = extractvalue { i8**, i64 } %t95, 1
  %t98 = icmp uge i64 %t94, %t97
  ; bounds check: %t98 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t94, i64 %t97)
  %t99 = getelementptr i8*, i8** %t96, i64 %t94
  %t100 = load i8*, i8** %t99
  %t101 = call i8* @trim_text(i8* %t100)
  %t102 = call i8* @trim_trailing_delimiters(i8* %t101)
  store i8* %t102, i8** %l8
  %t103 = load i8*, i8** %l8
  %t104 = call i64 @sailfin_runtime_string_length(i8* %t103)
  %t105 = icmp eq i64 %t104, 0
  %t106 = load double, double* %l0
  %t107 = load double, double* %l1
  %t108 = load i8*, i8** %l2
  %t109 = load i8*, i8** %l3
  %t110 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t111 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t112 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t113 = load double, double* %l7
  %t114 = load i8*, i8** %l8
  br i1 %t105, label %then14, label %merge15
then14:
  %t115 = load double, double* %l7
  %t116 = sitofp i64 1 to double
  %t117 = fadd double %t115, %t116
  store double %t117, double* %l7
  br label %loop.latch10
merge15:
  %t118 = load i8*, i8** %l8
  %t119 = alloca [2 x i8], align 1
  %t120 = getelementptr [2 x i8], [2 x i8]* %t119, i32 0, i32 0
  store i8 58, i8* %t120
  %t121 = getelementptr [2 x i8], [2 x i8]* %t119, i32 0, i32 1
  store i8 0, i8* %t121
  %t122 = getelementptr [2 x i8], [2 x i8]* %t119, i32 0, i32 0
  %t123 = call double @index_of(i8* %t118, i8* %t122)
  store double %t123, double* %l9
  %t124 = load double, double* %l9
  %t125 = sitofp i64 0 to double
  %t126 = fcmp olt double %t124, %t125
  %t127 = load double, double* %l0
  %t128 = load double, double* %l1
  %t129 = load i8*, i8** %l2
  %t130 = load i8*, i8** %l3
  %t131 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t132 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t133 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t134 = load double, double* %l7
  %t135 = load i8*, i8** %l8
  %t136 = load double, double* %l9
  br i1 %t126, label %then16, label %merge17
then16:
  %t137 = load double, double* %l7
  %t138 = sitofp i64 1 to double
  %t139 = fadd double %t137, %t138
  store double %t139, double* %l7
  br label %loop.latch10
merge17:
  %t140 = load i8*, i8** %l8
  %t141 = load double, double* %l9
  %t142 = call double @llvm.round.f64(double %t141)
  %t143 = fptosi double %t142 to i64
  %t144 = call i8* @sailfin_runtime_substring(i8* %t140, i64 0, i64 %t143)
  %t145 = call i8* @trim_text(i8* %t144)
  store i8* %t145, i8** %l10
  %t146 = load i8*, i8** %l8
  %t147 = load double, double* %l9
  %t148 = sitofp i64 1 to double
  %t149 = fadd double %t147, %t148
  %t150 = load i8*, i8** %l8
  %t151 = call i64 @sailfin_runtime_string_length(i8* %t150)
  %t152 = call double @llvm.round.f64(double %t149)
  %t153 = fptosi double %t152 to i64
  %t154 = call i8* @sailfin_runtime_substring(i8* %t146, i64 %t153, i64 %t151)
  %t155 = call i8* @trim_text(i8* %t154)
  store i8* %t155, i8** %l11
  %t156 = load i8*, i8** %l10
  %t157 = call i64 @sailfin_runtime_string_length(i8* %t156)
  %t158 = icmp eq i64 %t157, 0
  %t159 = load double, double* %l0
  %t160 = load double, double* %l1
  %t161 = load i8*, i8** %l2
  %t162 = load i8*, i8** %l3
  %t163 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t164 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t165 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t166 = load double, double* %l7
  %t167 = load i8*, i8** %l8
  %t168 = load double, double* %l9
  %t169 = load i8*, i8** %l10
  %t170 = load i8*, i8** %l11
  br i1 %t158, label %then18, label %merge19
then18:
  %t171 = load double, double* %l7
  %t172 = sitofp i64 1 to double
  %t173 = fadd double %t171, %t172
  store double %t173, double* %l7
  br label %loop.latch10
merge19:
  %t174 = load i8*, i8** %l11
  %t175 = sitofp i64 1 to double
  %t176 = fadd double %depth, %t175
  %t177 = call i8* @lower_expression_with_depth(i8* %t174, double %t176)
  store i8* %t177, i8** %l12
  %t178 = load i8*, i8** %l10
  %t179 = call i8* @sanitize_identifier(i8* %t178)
  store i8* %t179, i8** %l13
  %t180 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t181 = load i8*, i8** %l13
  %t182 = alloca [2 x i8], align 1
  %t183 = getelementptr [2 x i8], [2 x i8]* %t182, i32 0, i32 0
  store i8 61, i8* %t183
  %t184 = getelementptr [2 x i8], [2 x i8]* %t182, i32 0, i32 1
  store i8 0, i8* %t184
  %t185 = getelementptr [2 x i8], [2 x i8]* %t182, i32 0, i32 0
  %t186 = call i8* @sailfin_runtime_string_concat(i8* %t181, i8* %t185)
  %t187 = load i8*, i8** %l12
  %t188 = call i8* @sailfin_runtime_string_concat(i8* %t186, i8* %t187)
  %t189 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t180, i8* %t188)
  store { i8**, i64 }* %t189, { i8**, i64 }** %l5
  %t190 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %s191 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h728584192, i32 0, i32 0
  %t192 = load i8*, i8** %l13
  %t193 = call i8* @sailfin_runtime_string_concat(i8* %s191, i8* %t192)
  %s194 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087924125, i32 0, i32 0
  %t195 = call i8* @sailfin_runtime_string_concat(i8* %t193, i8* %s194)
  %t196 = load i8*, i8** %l12
  %t197 = call i8* @sailfin_runtime_string_concat(i8* %t195, i8* %t196)
  %t198 = alloca [2 x i8], align 1
  %t199 = getelementptr [2 x i8], [2 x i8]* %t198, i32 0, i32 0
  store i8 41, i8* %t199
  %t200 = getelementptr [2 x i8], [2 x i8]* %t198, i32 0, i32 1
  store i8 0, i8* %t200
  %t201 = getelementptr [2 x i8], [2 x i8]* %t198, i32 0, i32 0
  %t202 = call i8* @sailfin_runtime_string_concat(i8* %t197, i8* %t201)
  %t203 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t190, i8* %t202)
  store { i8**, i64 }* %t203, { i8**, i64 }** %l6
  %t204 = load double, double* %l7
  %t205 = sitofp i64 1 to double
  %t206 = fadd double %t204, %t205
  store double %t206, double* %l7
  br label %loop.latch10
loop.latch10:
  %t207 = load double, double* %l7
  %t208 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t209 = load { i8**, i64 }*, { i8**, i64 }** %l6
  br label %loop.header8
afterloop11:
  %t213 = load double, double* %l7
  %t214 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t215 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t216 = load i8*, i8** %l2
  %t217 = call i8* @sanitize_qualified_identifier(i8* %t216)
  store i8* %t217, i8** %l14
  %t218 = sitofp i64 -1 to double
  store double %t218, double* %l15
  %t219 = sitofp i64 0 to double
  store double %t219, double* %l7
  %t220 = load double, double* %l0
  %t221 = load double, double* %l1
  %t222 = load i8*, i8** %l2
  %t223 = load i8*, i8** %l3
  %t224 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t225 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t226 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t227 = load double, double* %l7
  %t228 = load i8*, i8** %l14
  %t229 = load double, double* %l15
  br label %loop.header20
loop.header20:
  %t268 = phi double [ %t229, %afterloop11 ], [ %t266, %loop.latch22 ]
  %t269 = phi double [ %t227, %afterloop11 ], [ %t267, %loop.latch22 ]
  store double %t268, double* %l15
  store double %t269, double* %l7
  br label %loop.body21
loop.body21:
  %t230 = load double, double* %l7
  %t231 = load i8*, i8** %l14
  %t232 = call i64 @sailfin_runtime_string_length(i8* %t231)
  %t233 = sitofp i64 %t232 to double
  %t234 = fcmp oge double %t230, %t233
  %t235 = load double, double* %l0
  %t236 = load double, double* %l1
  %t237 = load i8*, i8** %l2
  %t238 = load i8*, i8** %l3
  %t239 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t240 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t241 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t242 = load double, double* %l7
  %t243 = load i8*, i8** %l14
  %t244 = load double, double* %l15
  br i1 %t234, label %then24, label %merge25
then24:
  br label %afterloop23
merge25:
  %t245 = load i8*, i8** %l14
  %t246 = load double, double* %l7
  %t247 = call i8* @char_at(i8* %t245, double %t246)
  %t248 = load i8, i8* %t247
  %t249 = icmp eq i8 %t248, 46
  %t250 = load double, double* %l0
  %t251 = load double, double* %l1
  %t252 = load i8*, i8** %l2
  %t253 = load i8*, i8** %l3
  %t254 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t255 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t256 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t257 = load double, double* %l7
  %t258 = load i8*, i8** %l14
  %t259 = load double, double* %l15
  br i1 %t249, label %then26, label %merge27
then26:
  %t260 = load double, double* %l7
  store double %t260, double* %l15
  %t261 = load double, double* %l15
  br label %merge27
merge27:
  %t262 = phi double [ %t261, %then26 ], [ %t259, %merge25 ]
  store double %t262, double* %l15
  %t263 = load double, double* %l7
  %t264 = sitofp i64 1 to double
  %t265 = fadd double %t263, %t264
  store double %t265, double* %l7
  br label %loop.latch22
loop.latch22:
  %t266 = load double, double* %l15
  %t267 = load double, double* %l7
  br label %loop.header20
afterloop23:
  %t270 = load double, double* %l15
  %t271 = load double, double* %l7
  %t272 = load double, double* %l15
  %t273 = sitofp i64 0 to double
  %t274 = fcmp oge double %t272, %t273
  %t275 = load double, double* %l0
  %t276 = load double, double* %l1
  %t277 = load i8*, i8** %l2
  %t278 = load i8*, i8** %l3
  %t279 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t280 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t281 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t282 = load double, double* %l7
  %t283 = load i8*, i8** %l14
  %t284 = load double, double* %l15
  br i1 %t274, label %then28, label %merge29
then28:
  %t285 = load i8*, i8** %l14
  %t286 = load double, double* %l15
  %t287 = call double @llvm.round.f64(double %t286)
  %t288 = fptosi double %t287 to i64
  %t289 = call i8* @sailfin_runtime_substring(i8* %t285, i64 0, i64 %t288)
  store i8* %t289, i8** %l16
  %t290 = load i8*, i8** %l14
  %t291 = load double, double* %l15
  %t292 = sitofp i64 1 to double
  %t293 = fadd double %t291, %t292
  %t294 = load i8*, i8** %l14
  %t295 = call i64 @sailfin_runtime_string_length(i8* %t294)
  %t296 = call double @llvm.round.f64(double %t293)
  %t297 = fptosi double %t296 to i64
  %t298 = call i8* @sailfin_runtime_substring(i8* %t290, i64 %t297, i64 %t295)
  store i8* %t298, i8** %l17
  %t299 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %s300 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t301 = call i8* @join_with_separator({ i8**, i64 }* %t299, i8* %s300)
  %t302 = alloca [2 x i8], align 1
  %t303 = getelementptr [2 x i8], [2 x i8]* %t302, i32 0, i32 0
  store i8 91, i8* %t303
  %t304 = getelementptr [2 x i8], [2 x i8]* %t302, i32 0, i32 1
  store i8 0, i8* %t304
  %t305 = getelementptr [2 x i8], [2 x i8]* %t302, i32 0, i32 0
  %t306 = call i8* @sailfin_runtime_string_concat(i8* %t305, i8* %t301)
  %t307 = alloca [2 x i8], align 1
  %t308 = getelementptr [2 x i8], [2 x i8]* %t307, i32 0, i32 0
  store i8 93, i8* %t308
  %t309 = getelementptr [2 x i8], [2 x i8]* %t307, i32 0, i32 1
  store i8 0, i8* %t309
  %t310 = getelementptr [2 x i8], [2 x i8]* %t307, i32 0, i32 0
  %t311 = call i8* @sailfin_runtime_string_concat(i8* %t306, i8* %t310)
  store i8* %t311, i8** %l18
  %s312 = getelementptr inbounds [26 x i8], [26 x i8]* @.str.len25.h117462910, i32 0, i32 0
  %t313 = load i8*, i8** %l16
  %t314 = call i8* @sailfin_runtime_string_concat(i8* %s312, i8* %t313)
  %s315 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2088090973, i32 0, i32 0
  %t316 = call i8* @sailfin_runtime_string_concat(i8* %t314, i8* %s315)
  %t317 = load i8*, i8** %l17
  %t318 = call i8* @sailfin_runtime_string_concat(i8* %t316, i8* %t317)
  %s319 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087924125, i32 0, i32 0
  %t320 = call i8* @sailfin_runtime_string_concat(i8* %t318, i8* %s319)
  %t321 = load i8*, i8** %l18
  %t322 = call i8* @sailfin_runtime_string_concat(i8* %t320, i8* %t321)
  %t323 = alloca [2 x i8], align 1
  %t324 = getelementptr [2 x i8], [2 x i8]* %t323, i32 0, i32 0
  store i8 41, i8* %t324
  %t325 = getelementptr [2 x i8], [2 x i8]* %t323, i32 0, i32 1
  store i8 0, i8* %t325
  %t326 = getelementptr [2 x i8], [2 x i8]* %t323, i32 0, i32 0
  %t327 = call i8* @sailfin_runtime_string_concat(i8* %t322, i8* %t326)
  store i8* %t327, i8** %out_result
  ret void
merge29:
  %t328 = load i8*, i8** %l14
  %t329 = alloca [2 x i8], align 1
  %t330 = getelementptr [2 x i8], [2 x i8]* %t329, i32 0, i32 0
  store i8 40, i8* %t330
  %t331 = getelementptr [2 x i8], [2 x i8]* %t329, i32 0, i32 1
  store i8 0, i8* %t331
  %t332 = getelementptr [2 x i8], [2 x i8]* %t329, i32 0, i32 0
  %t333 = call i8* @sailfin_runtime_string_concat(i8* %t328, i8* %t332)
  %t334 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %s335 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t336 = call i8* @join_with_separator({ i8**, i64 }* %t334, i8* %s335)
  %t337 = call i8* @sailfin_runtime_string_concat(i8* %t333, i8* %t336)
  %t338 = alloca [2 x i8], align 1
  %t339 = getelementptr [2 x i8], [2 x i8]* %t338, i32 0, i32 0
  store i8 41, i8* %t339
  %t340 = getelementptr [2 x i8], [2 x i8]* %t338, i32 0, i32 1
  store i8 0, i8* %t340
  %t341 = getelementptr [2 x i8], [2 x i8]* %t338, i32 0, i32 0
  %t342 = call i8* @sailfin_runtime_string_concat(i8* %t337, i8* %t341)
  store i8* %t342, i8** %out_result
  ret void
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
  %t34 = phi double [ %t3, %merge1 ], [ %t33, %loop.latch4 ]
  store double %t34, double* %l0
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
  %t13 = call double @llvm.round.f64(double %t9)
  %t14 = fptosi double %t13 to i64
  %t15 = call double @llvm.round.f64(double %t12)
  %t16 = fptosi double %t15 to i64
  %t17 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t14, i64 %t16)
  store i8* %t17, i8** %l1
  %t18 = load i8*, i8** %l1
  %t19 = load i8, i8* %t18
  %t20 = icmp eq i8 %t19, 46
  %t21 = load double, double* %l0
  %t22 = load i8*, i8** %l1
  br i1 %t20, label %then8, label %merge9
then8:
  %t23 = load double, double* %l0
  %t24 = sitofp i64 1 to double
  %t25 = fadd double %t23, %t24
  store double %t25, double* %l0
  br label %loop.latch4
merge9:
  %t26 = load i8*, i8** %l1
  %t27 = call i1 @is_identifier_char(i8* %t26)
  %t28 = load double, double* %l0
  %t29 = load i8*, i8** %l1
  br i1 %t27, label %then10, label %merge11
then10:
  %t30 = load double, double* %l0
  %t31 = sitofp i64 1 to double
  %t32 = fadd double %t30, %t31
  store double %t32, double* %l0
  br label %loop.latch4
merge11:
  ret i1 0
loop.latch4:
  %t33 = load double, double* %l0
  br label %loop.header2
afterloop5:
  %t35 = load double, double* %l0
  ret i1 1
}

; NOTE: Returns string via output parameter %out_result
define void @lower_array_literal_expression(i8* %expression, double %depth, i8** %out_result) {
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
  store i8* null, i8** %out_result
  ret void
merge1:
  %t5 = load i8*, i8** %l0
  %t6 = call i8* @sailfin_runtime_substring(i8* %t5, i64 0, i64 1)
  %t7 = load i8, i8* %t6
  %t8 = icmp ne i8 %t7, 91
  %t9 = load i8*, i8** %l0
  br i1 %t8, label %then2, label %merge3
then2:
  store i8* null, i8** %out_result
  ret void
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
  store i8* null, i8** %out_result
  ret void
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
  %t96 = phi { i8**, i64 }* [ %t47, %merge5 ], [ %t94, %loop.latch8 ]
  %t97 = phi double [ %t48, %merge5 ], [ %t95, %loop.latch8 ]
  store { i8**, i64 }* %t96, { i8**, i64 }** %l4
  store double %t97, double* %l5
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
  %t63 = call double @llvm.round.f64(double %t62)
  %t64 = fptosi double %t63 to i64
  %t65 = load { i8**, i64 }, { i8**, i64 }* %t61
  %t66 = extractvalue { i8**, i64 } %t65, 0
  %t67 = extractvalue { i8**, i64 } %t65, 1
  %t68 = icmp uge i64 %t64, %t67
  ; bounds check: %t68 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t64, i64 %t67)
  %t69 = getelementptr i8*, i8** %t66, i64 %t64
  %t70 = load i8*, i8** %t69
  %t71 = call i8* @trim_text(i8* %t70)
  %t72 = call i8* @trim_trailing_delimiters(i8* %t71)
  store i8* %t72, i8** %l6
  %t73 = load i8*, i8** %l6
  %t74 = call i64 @sailfin_runtime_string_length(i8* %t73)
  %t75 = icmp sgt i64 %t74, 0
  %t76 = load i8*, i8** %l0
  %t77 = load i64, i64* %l1
  %t78 = load i8*, i8** %l2
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t80 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t81 = load double, double* %l5
  %t82 = load i8*, i8** %l6
  br i1 %t75, label %then12, label %merge13
then12:
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t84 = load i8*, i8** %l6
  %t85 = sitofp i64 1 to double
  %t86 = fadd double %depth, %t85
  %t87 = call i8* @lower_expression_with_depth(i8* %t84, double %t86)
  %t88 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t83, i8* %t87)
  store { i8**, i64 }* %t88, { i8**, i64 }** %l4
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l4
  br label %merge13
merge13:
  %t90 = phi { i8**, i64 }* [ %t89, %then12 ], [ %t80, %merge11 ]
  store { i8**, i64 }* %t90, { i8**, i64 }** %l4
  %t91 = load double, double* %l5
  %t92 = sitofp i64 1 to double
  %t93 = fadd double %t91, %t92
  store double %t93, double* %l5
  br label %loop.latch8
loop.latch8:
  %t94 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t95 = load double, double* %l5
  br label %loop.header6
afterloop9:
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t99 = load double, double* %l5
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t101 = load { i8**, i64 }, { i8**, i64 }* %t100
  %t102 = extractvalue { i8**, i64 } %t101, 1
  %t103 = icmp eq i64 %t102, 0
  %t104 = load i8*, i8** %l0
  %t105 = load i64, i64* %l1
  %t106 = load i8*, i8** %l2
  %t107 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t108 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t109 = load double, double* %l5
  br i1 %t103, label %then14, label %merge15
then14:
  %s110 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193479167, i32 0, i32 0
  store i8* %s110, i8** %out_result
  ret void
merge15:
  %t111 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %s112 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t113 = call i8* @join_with_separator({ i8**, i64 }* %t111, i8* %s112)
  store i8* %t113, i8** %l7
  %t114 = load i8*, i8** %l7
  %t115 = alloca [2 x i8], align 1
  %t116 = getelementptr [2 x i8], [2 x i8]* %t115, i32 0, i32 0
  store i8 91, i8* %t116
  %t117 = getelementptr [2 x i8], [2 x i8]* %t115, i32 0, i32 1
  store i8 0, i8* %t117
  %t118 = getelementptr [2 x i8], [2 x i8]* %t115, i32 0, i32 0
  %t119 = call i8* @sailfin_runtime_string_concat(i8* %t118, i8* %t114)
  %t120 = alloca [2 x i8], align 1
  %t121 = getelementptr [2 x i8], [2 x i8]* %t120, i32 0, i32 0
  store i8 93, i8* %t121
  %t122 = getelementptr [2 x i8], [2 x i8]* %t120, i32 0, i32 1
  store i8 0, i8* %t122
  %t123 = getelementptr [2 x i8], [2 x i8]* %t120, i32 0, i32 0
  %t124 = call i8* @sailfin_runtime_string_concat(i8* %t119, i8* %t123)
  store i8* %t124, i8** %out_result
  ret void
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

; NOTE: Returns string via output parameter %out_result
define void @rewrite_array_literals_inline(i8* %expression, double %depth, i8** %out_result) {
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
  store i8* %expression, i8** %out_result
  ret void
merge1:
  store i8* %expression, i8** %l0
  %t2 = sitofp i64 0 to double
  store double %t2, double* %l1
  %t3 = load i8*, i8** %l0
  %t4 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t82 = phi double [ %t4, %merge1 ], [ %t80, %loop.latch4 ]
  %t83 = phi i8* [ %t3, %merge1 ], [ %t81, %loop.latch4 ]
  store double %t82, double* %l1
  store i8* %t83, i8** %l0
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
  %t36 = call double @llvm.round.f64(double %t32)
  %t37 = fptosi double %t36 to i64
  %t38 = call double @llvm.round.f64(double %t35)
  %t39 = fptosi double %t38 to i64
  %t40 = call i8* @sailfin_runtime_substring(i8* %t31, i64 %t37, i64 %t39)
  store i8* %t40, i8** %l4
  %t41 = load i8*, i8** %l4
  %t42 = sitofp i64 1 to double
  %t43 = fadd double %depth, %t42
  %t44 = call i8* @lower_array_literal_expression(i8* %t41, double %t43)
  store i8* %t44, i8** %l5
  %t45 = load i8*, i8** %l5
  %t46 = icmp eq i8* %t45, null
  %t47 = load i8*, i8** %l0
  %t48 = load double, double* %l1
  %t49 = load double, double* %l2
  %t50 = load double, double* %l3
  %t51 = load i8*, i8** %l4
  %t52 = load i8*, i8** %l5
  br i1 %t46, label %then12, label %merge13
then12:
  %t53 = load double, double* %l2
  %t54 = sitofp i64 1 to double
  %t55 = fadd double %t53, %t54
  store double %t55, double* %l1
  br label %loop.latch4
merge13:
  %t56 = load i8*, i8** %l0
  %t57 = load double, double* %l2
  %t58 = call double @llvm.round.f64(double %t57)
  %t59 = fptosi double %t58 to i64
  %t60 = call i8* @sailfin_runtime_substring(i8* %t56, i64 0, i64 %t59)
  store i8* %t60, i8** %l6
  %t61 = load i8*, i8** %l0
  %t62 = load double, double* %l3
  %t63 = sitofp i64 1 to double
  %t64 = fadd double %t62, %t63
  %t65 = load i8*, i8** %l0
  %t66 = call i64 @sailfin_runtime_string_length(i8* %t65)
  %t67 = call double @llvm.round.f64(double %t64)
  %t68 = fptosi double %t67 to i64
  %t69 = call i8* @sailfin_runtime_substring(i8* %t61, i64 %t68, i64 %t66)
  store i8* %t69, i8** %l7
  %t70 = load i8*, i8** %l6
  %t71 = load i8*, i8** %l5
  %t72 = call i8* @sailfin_runtime_string_concat(i8* %t70, i8* %t71)
  %t73 = load i8*, i8** %l7
  %t74 = call i8* @sailfin_runtime_string_concat(i8* %t72, i8* %t73)
  store i8* %t74, i8** %l0
  %t75 = load double, double* %l2
  %t76 = load i8*, i8** %l5
  %t77 = call i64 @sailfin_runtime_string_length(i8* %t76)
  %t78 = sitofp i64 %t77 to double
  %t79 = fadd double %t75, %t78
  store double %t79, double* %l1
  br label %loop.latch4
loop.latch4:
  %t80 = load double, double* %l1
  %t81 = load i8*, i8** %l0
  br label %loop.header2
afterloop5:
  %t84 = load double, double* %l1
  %t85 = load i8*, i8** %l0
  %t86 = load i8*, i8** %l0
  store i8* %t86, i8** %out_result
  ret void
}

; NOTE: Returns string via output parameter %out_result
define void @rewrite_struct_literals_inline(i8* %expression, double %depth, i8** %out_result) {
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
  store i8* %expression, i8** %out_result
  ret void
merge1:
  store i8* %expression, i8** %l0
  %t2 = sitofp i64 0 to double
  store double %t2, double* %l1
  %t3 = load i8*, i8** %l0
  %t4 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t246 = phi double [ %t4, %merge1 ], [ %t244, %loop.latch4 ]
  %t247 = phi i8* [ %t3, %merge1 ], [ %t245, %loop.latch4 ]
  store double %t246, double* %l1
  store i8* %t247, i8** %l0
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
  %t58 = phi double [ %t29, %merge9 ], [ %t57, %loop.latch12 ]
  store double %t58, double* %l3
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
  %t42 = call double @llvm.round.f64(double %t40)
  %t43 = fptosi double %t42 to i64
  %t44 = call double @llvm.round.f64(double %t41)
  %t45 = fptosi double %t44 to i64
  %t46 = call i8* @sailfin_runtime_substring(i8* %t37, i64 %t43, i64 %t45)
  store i8* %t46, i8** %l4
  %t47 = load i8*, i8** %l4
  %t48 = call i1 @sailfin_runtime_is_whitespace_char(i8* %t47)
  %t49 = load i8*, i8** %l0
  %t50 = load double, double* %l1
  %t51 = load double, double* %l2
  %t52 = load double, double* %l3
  %t53 = load i8*, i8** %l4
  br i1 %t48, label %then16, label %merge17
then16:
  %t54 = load double, double* %l3
  %t55 = sitofp i64 1 to double
  %t56 = fsub double %t54, %t55
  store double %t56, double* %l3
  br label %loop.latch12
merge17:
  br label %afterloop13
loop.latch12:
  %t57 = load double, double* %l3
  br label %loop.header10
afterloop13:
  %t59 = load double, double* %l3
  %t60 = load double, double* %l3
  store double %t60, double* %l5
  %t61 = load i8*, i8** %l0
  %t62 = load double, double* %l1
  %t63 = load double, double* %l2
  %t64 = load double, double* %l3
  %t65 = load double, double* %l5
  br label %loop.header18
loop.header18:
  %t108 = phi double [ %t65, %afterloop13 ], [ %t107, %loop.latch20 ]
  store double %t108, double* %l5
  br label %loop.body19
loop.body19:
  %t66 = load double, double* %l5
  %t67 = sitofp i64 0 to double
  %t68 = fcmp ole double %t66, %t67
  %t69 = load i8*, i8** %l0
  %t70 = load double, double* %l1
  %t71 = load double, double* %l2
  %t72 = load double, double* %l3
  %t73 = load double, double* %l5
  br i1 %t68, label %then22, label %merge23
then22:
  br label %afterloop21
merge23:
  %t74 = load i8*, i8** %l0
  %t75 = load double, double* %l5
  %t76 = sitofp i64 1 to double
  %t77 = fsub double %t75, %t76
  %t78 = load double, double* %l5
  %t79 = call double @llvm.round.f64(double %t77)
  %t80 = fptosi double %t79 to i64
  %t81 = call double @llvm.round.f64(double %t78)
  %t82 = fptosi double %t81 to i64
  %t83 = call i8* @sailfin_runtime_substring(i8* %t74, i64 %t80, i64 %t82)
  store i8* %t83, i8** %l6
  %t84 = load i8*, i8** %l6
  %t85 = load i8, i8* %t84
  %t86 = icmp eq i8 %t85, 46
  %t87 = load i8*, i8** %l0
  %t88 = load double, double* %l1
  %t89 = load double, double* %l2
  %t90 = load double, double* %l3
  %t91 = load double, double* %l5
  %t92 = load i8*, i8** %l6
  br i1 %t86, label %then24, label %merge25
then24:
  %t93 = load double, double* %l5
  %t94 = sitofp i64 1 to double
  %t95 = fsub double %t93, %t94
  store double %t95, double* %l5
  br label %loop.latch20
merge25:
  %t96 = load i8*, i8** %l6
  %t97 = call i1 @is_identifier_char(i8* %t96)
  %t98 = load i8*, i8** %l0
  %t99 = load double, double* %l1
  %t100 = load double, double* %l2
  %t101 = load double, double* %l3
  %t102 = load double, double* %l5
  %t103 = load i8*, i8** %l6
  br i1 %t97, label %then26, label %merge27
then26:
  %t104 = load double, double* %l5
  %t105 = sitofp i64 1 to double
  %t106 = fsub double %t104, %t105
  store double %t106, double* %l5
  br label %loop.latch20
merge27:
  br label %afterloop21
loop.latch20:
  %t107 = load double, double* %l5
  br label %loop.header18
afterloop21:
  %t109 = load double, double* %l5
  %t110 = load double, double* %l5
  %t111 = load double, double* %l3
  %t112 = fcmp oeq double %t110, %t111
  %t113 = load i8*, i8** %l0
  %t114 = load double, double* %l1
  %t115 = load double, double* %l2
  %t116 = load double, double* %l3
  %t117 = load double, double* %l5
  br i1 %t112, label %then28, label %merge29
then28:
  %t118 = load double, double* %l2
  %t119 = sitofp i64 1 to double
  %t120 = fadd double %t118, %t119
  store double %t120, double* %l1
  br label %loop.latch4
merge29:
  %t121 = load i8*, i8** %l0
  %t122 = load double, double* %l5
  %t123 = load double, double* %l3
  %t124 = call double @llvm.round.f64(double %t122)
  %t125 = fptosi double %t124 to i64
  %t126 = call double @llvm.round.f64(double %t123)
  %t127 = fptosi double %t126 to i64
  %t128 = call i8* @sailfin_runtime_substring(i8* %t121, i64 %t125, i64 %t127)
  store i8* %t128, i8** %l7
  %t129 = load i8*, i8** %l7
  %t130 = call i1 @is_struct_literal_type_candidate(i8* %t129)
  %t131 = xor i1 %t130, 1
  %t132 = load i8*, i8** %l0
  %t133 = load double, double* %l1
  %t134 = load double, double* %l2
  %t135 = load double, double* %l3
  %t136 = load double, double* %l5
  %t137 = load i8*, i8** %l7
  br i1 %t131, label %then30, label %merge31
then30:
  %t138 = load double, double* %l2
  %t139 = sitofp i64 1 to double
  %t140 = fadd double %t138, %t139
  store double %t140, double* %l1
  br label %loop.latch4
merge31:
  %t141 = load double, double* %l5
  %t142 = sitofp i64 0 to double
  %t143 = fcmp ogt double %t141, %t142
  %t144 = load i8*, i8** %l0
  %t145 = load double, double* %l1
  %t146 = load double, double* %l2
  %t147 = load double, double* %l3
  %t148 = load double, double* %l5
  %t149 = load i8*, i8** %l7
  br i1 %t143, label %then32, label %merge33
then32:
  %t150 = load i8*, i8** %l0
  %t151 = load double, double* %l5
  %t152 = sitofp i64 1 to double
  %t153 = fsub double %t151, %t152
  %t154 = load double, double* %l5
  %t155 = call double @llvm.round.f64(double %t153)
  %t156 = fptosi double %t155 to i64
  %t157 = call double @llvm.round.f64(double %t154)
  %t158 = fptosi double %t157 to i64
  %t159 = call i8* @sailfin_runtime_substring(i8* %t150, i64 %t156, i64 %t158)
  store i8* %t159, i8** %l8
  %t161 = load i8*, i8** %l8
  %t162 = call i1 @is_identifier_char(i8* %t161)
  br label %logical_or_entry_160

logical_or_entry_160:
  br i1 %t162, label %logical_or_merge_160, label %logical_or_right_160

logical_or_right_160:
  %t163 = load i8*, i8** %l8
  %t164 = load i8, i8* %t163
  %t165 = icmp eq i8 %t164, 46
  br label %logical_or_right_end_160

logical_or_right_end_160:
  br label %logical_or_merge_160

logical_or_merge_160:
  %t166 = phi i1 [ true, %logical_or_entry_160 ], [ %t165, %logical_or_right_end_160 ]
  %t167 = load i8*, i8** %l0
  %t168 = load double, double* %l1
  %t169 = load double, double* %l2
  %t170 = load double, double* %l3
  %t171 = load double, double* %l5
  %t172 = load i8*, i8** %l7
  %t173 = load i8*, i8** %l8
  br i1 %t166, label %then34, label %merge35
then34:
  %t174 = load double, double* %l2
  %t175 = sitofp i64 1 to double
  %t176 = fadd double %t174, %t175
  store double %t176, double* %l1
  br label %loop.latch4
merge35:
  %t177 = load double, double* %l1
  br label %merge33
merge33:
  %t178 = phi double [ %t177, %merge35 ], [ %t145, %merge31 ]
  store double %t178, double* %l1
  %t179 = load i8*, i8** %l0
  %t180 = load double, double* %l2
  %t181 = call double @find_matching_brace(i8* %t179, double %t180)
  store double %t181, double* %l9
  %t182 = load double, double* %l9
  %t183 = sitofp i64 0 to double
  %t184 = fcmp olt double %t182, %t183
  %t185 = load i8*, i8** %l0
  %t186 = load double, double* %l1
  %t187 = load double, double* %l2
  %t188 = load double, double* %l3
  %t189 = load double, double* %l5
  %t190 = load i8*, i8** %l7
  %t191 = load double, double* %l9
  br i1 %t184, label %then36, label %merge37
then36:
  br label %afterloop5
merge37:
  %t192 = load i8*, i8** %l0
  %t193 = load double, double* %l5
  %t194 = load double, double* %l9
  %t195 = sitofp i64 1 to double
  %t196 = fadd double %t194, %t195
  %t197 = call double @llvm.round.f64(double %t193)
  %t198 = fptosi double %t197 to i64
  %t199 = call double @llvm.round.f64(double %t196)
  %t200 = fptosi double %t199 to i64
  %t201 = call i8* @sailfin_runtime_substring(i8* %t192, i64 %t198, i64 %t200)
  store i8* %t201, i8** %l10
  %t202 = load i8*, i8** %l10
  %t203 = sitofp i64 1 to double
  %t204 = fadd double %depth, %t203
  %t205 = call i8* @lower_struct_literal_expression(i8* %t202, double %t204)
  store i8* %t205, i8** %l11
  %t206 = load i8*, i8** %l11
  %t207 = icmp eq i8* %t206, null
  %t208 = load i8*, i8** %l0
  %t209 = load double, double* %l1
  %t210 = load double, double* %l2
  %t211 = load double, double* %l3
  %t212 = load double, double* %l5
  %t213 = load i8*, i8** %l7
  %t214 = load double, double* %l9
  %t215 = load i8*, i8** %l10
  %t216 = load i8*, i8** %l11
  br i1 %t207, label %then38, label %merge39
then38:
  %t217 = load double, double* %l9
  %t218 = sitofp i64 1 to double
  %t219 = fadd double %t217, %t218
  store double %t219, double* %l1
  br label %loop.latch4
merge39:
  %t220 = load i8*, i8** %l0
  %t221 = load double, double* %l5
  %t222 = call double @llvm.round.f64(double %t221)
  %t223 = fptosi double %t222 to i64
  %t224 = call i8* @sailfin_runtime_substring(i8* %t220, i64 0, i64 %t223)
  store i8* %t224, i8** %l12
  %t225 = load i8*, i8** %l0
  %t226 = load double, double* %l9
  %t227 = sitofp i64 1 to double
  %t228 = fadd double %t226, %t227
  %t229 = load i8*, i8** %l0
  %t230 = call i64 @sailfin_runtime_string_length(i8* %t229)
  %t231 = call double @llvm.round.f64(double %t228)
  %t232 = fptosi double %t231 to i64
  %t233 = call i8* @sailfin_runtime_substring(i8* %t225, i64 %t232, i64 %t230)
  store i8* %t233, i8** %l13
  %t234 = load i8*, i8** %l12
  %t235 = load i8*, i8** %l11
  %t236 = call i8* @sailfin_runtime_string_concat(i8* %t234, i8* %t235)
  %t237 = load i8*, i8** %l13
  %t238 = call i8* @sailfin_runtime_string_concat(i8* %t236, i8* %t237)
  store i8* %t238, i8** %l0
  %t239 = load double, double* %l5
  %t240 = load i8*, i8** %l11
  %t241 = call i64 @sailfin_runtime_string_length(i8* %t240)
  %t242 = sitofp i64 %t241 to double
  %t243 = fadd double %t239, %t242
  store double %t243, double* %l1
  br label %loop.latch4
loop.latch4:
  %t244 = load double, double* %l1
  %t245 = load i8*, i8** %l0
  br label %loop.header2
afterloop5:
  %t248 = load double, double* %l1
  %t249 = load i8*, i8** %l0
  %t250 = load i8*, i8** %l0
  store i8* %t250, i8** %out_result
  ret void
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
  %t172 = phi i8* [ %t32, %merge3 ], [ %t168, %loop.latch6 ]
  %t173 = phi double [ %t35, %merge3 ], [ %t169, %loop.latch6 ]
  %t174 = phi double [ %t34, %merge3 ], [ %t170, %loop.latch6 ]
  %t175 = phi double [ %t33, %merge3 ], [ %t171, %loop.latch6 ]
  store i8* %t172, i8** %l1
  store double %t173, double* %l4
  store double %t174, double* %l3
  store double %t175, double* %l2
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
  %t47 = call double @llvm.round.f64(double %t46)
  %t48 = fptosi double %t47 to i64
  %t49 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %instructions
  %t50 = extractvalue { %NativeInstruction*, i64 } %t49, 0
  %t51 = extractvalue { %NativeInstruction*, i64 } %t49, 1
  %t52 = icmp uge i64 %t48, %t51
  ; bounds check: %t52 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t48, i64 %t51)
  %t53 = getelementptr %NativeInstruction, %NativeInstruction* %t50, i64 %t48
  %t54 = load %NativeInstruction, %NativeInstruction* %t53
  store %NativeInstruction %t54, %NativeInstruction* %l5
  %t55 = load %NativeInstruction, %NativeInstruction* %l5
  %t56 = extractvalue %NativeInstruction %t55, 0
  %t57 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t58 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t59 = icmp eq i32 %t56, 0
  %t60 = select i1 %t59, i8* %t58, i8* %t57
  %t61 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t62 = icmp eq i32 %t56, 1
  %t63 = select i1 %t62, i8* %t61, i8* %t60
  %t64 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t65 = icmp eq i32 %t56, 2
  %t66 = select i1 %t65, i8* %t64, i8* %t63
  %t67 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t68 = icmp eq i32 %t56, 3
  %t69 = select i1 %t68, i8* %t67, i8* %t66
  %t70 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t71 = icmp eq i32 %t56, 4
  %t72 = select i1 %t71, i8* %t70, i8* %t69
  %t73 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t74 = icmp eq i32 %t56, 5
  %t75 = select i1 %t74, i8* %t73, i8* %t72
  %t76 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t77 = icmp eq i32 %t56, 6
  %t78 = select i1 %t77, i8* %t76, i8* %t75
  %t79 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t80 = icmp eq i32 %t56, 7
  %t81 = select i1 %t80, i8* %t79, i8* %t78
  %t82 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t83 = icmp eq i32 %t56, 8
  %t84 = select i1 %t83, i8* %t82, i8* %t81
  %t85 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t86 = icmp eq i32 %t56, 9
  %t87 = select i1 %t86, i8* %t85, i8* %t84
  %t88 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t89 = icmp eq i32 %t56, 10
  %t90 = select i1 %t89, i8* %t88, i8* %t87
  %t91 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t92 = icmp eq i32 %t56, 11
  %t93 = select i1 %t92, i8* %t91, i8* %t90
  %t94 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t95 = icmp eq i32 %t56, 12
  %t96 = select i1 %t95, i8* %t94, i8* %t93
  %t97 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t98 = icmp eq i32 %t56, 13
  %t99 = select i1 %t98, i8* %t97, i8* %t96
  %t100 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t101 = icmp eq i32 %t56, 14
  %t102 = select i1 %t101, i8* %t100, i8* %t99
  %t103 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t104 = icmp eq i32 %t56, 15
  %t105 = select i1 %t104, i8* %t103, i8* %t102
  %t106 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t107 = icmp eq i32 %t56, 16
  %t108 = select i1 %t107, i8* %t106, i8* %t105
  %s109 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h48777630, i32 0, i32 0
  %t110 = call i1 @strings_equal(i8* %t108, i8* %s109)
  %t111 = xor i1 %t110, true
  %t112 = load i8*, i8** %l0
  %t113 = load i8*, i8** %l1
  %t114 = load double, double* %l2
  %t115 = load double, double* %l3
  %t116 = load double, double* %l4
  %t117 = load %NativeInstruction, %NativeInstruction* %l5
  br i1 %t111, label %then10, label %merge11
then10:
  br label %afterloop7
merge11:
  %t118 = load %NativeInstruction, %NativeInstruction* %l5
  %t119 = extractvalue %NativeInstruction %t118, 0
  %t120 = alloca %NativeInstruction
  store %NativeInstruction %t118, %NativeInstruction* %t120
  %t121 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t120, i32 0, i32 1
  %t122 = bitcast [8 x i8]* %t121 to i8*
  %t123 = bitcast i8* %t122 to i8**
  %t124 = load i8*, i8** %t123
  %t125 = icmp eq i32 %t119, 16
  %t126 = select i1 %t125, i8* %t124, i8* null
  %t127 = call i8* @trim_text(i8* %t126)
  store i8* %t127, i8** %l6
  %t128 = load i8*, i8** %l6
  %t129 = call i64 @sailfin_runtime_string_length(i8* %t128)
  %t130 = icmp sgt i64 %t129, 0
  %t131 = load i8*, i8** %l0
  %t132 = load i8*, i8** %l1
  %t133 = load double, double* %l2
  %t134 = load double, double* %l3
  %t135 = load double, double* %l4
  %t136 = load %NativeInstruction, %NativeInstruction* %l5
  %t137 = load i8*, i8** %l6
  br i1 %t130, label %then12, label %merge13
then12:
  %t138 = load i8*, i8** %l1
  %t139 = alloca [2 x i8], align 1
  %t140 = getelementptr [2 x i8], [2 x i8]* %t139, i32 0, i32 0
  store i8 32, i8* %t140
  %t141 = getelementptr [2 x i8], [2 x i8]* %t139, i32 0, i32 1
  store i8 0, i8* %t141
  %t142 = getelementptr [2 x i8], [2 x i8]* %t139, i32 0, i32 0
  %t143 = call i8* @sailfin_runtime_string_concat(i8* %t138, i8* %t142)
  %t144 = load i8*, i8** %l6
  %t145 = call i8* @sailfin_runtime_string_concat(i8* %t143, i8* %t144)
  store i8* %t145, i8** %l1
  %t146 = load i8*, i8** %l1
  br label %merge13
merge13:
  %t147 = phi i8* [ %t146, %then12 ], [ %t132, %merge11 ]
  store i8* %t147, i8** %l1
  %t148 = load double, double* %l4
  %t149 = load i8*, i8** %l6
  %t150 = call double @compute_brace_balance(i8* %t149)
  %t151 = fadd double %t148, %t150
  store double %t151, double* %l4
  %t152 = load double, double* %l3
  %t153 = sitofp i64 1 to double
  %t154 = fadd double %t152, %t153
  store double %t154, double* %l3
  %t155 = load double, double* %l2
  %t156 = sitofp i64 1 to double
  %t157 = fadd double %t155, %t156
  store double %t157, double* %l2
  %t158 = load double, double* %l4
  %t159 = sitofp i64 0 to double
  %t160 = fcmp ole double %t158, %t159
  %t161 = load i8*, i8** %l0
  %t162 = load i8*, i8** %l1
  %t163 = load double, double* %l2
  %t164 = load double, double* %l3
  %t165 = load double, double* %l4
  %t166 = load %NativeInstruction, %NativeInstruction* %l5
  %t167 = load i8*, i8** %l6
  br i1 %t160, label %then14, label %merge15
then14:
  br label %afterloop7
merge15:
  br label %loop.latch6
loop.latch6:
  %t168 = load i8*, i8** %l1
  %t169 = load double, double* %l4
  %t170 = load double, double* %l3
  %t171 = load double, double* %l2
  br label %loop.header4
afterloop7:
  %t176 = load i8*, i8** %l1
  %t177 = load double, double* %l4
  %t178 = load double, double* %l3
  %t179 = load double, double* %l2
  %t180 = load double, double* %l4
  %t181 = sitofp i64 0 to double
  %t182 = fcmp une double %t180, %t181
  %t183 = load i8*, i8** %l0
  %t184 = load i8*, i8** %l1
  %t185 = load double, double* %l2
  %t186 = load double, double* %l3
  %t187 = load double, double* %l4
  br i1 %t182, label %then16, label %merge17
then16:
  %t188 = load i8*, i8** %l0
  %t189 = insertvalue %StructLiteralCapture undef, i8* %t188, 0
  %t190 = sitofp i64 0 to double
  %t191 = insertvalue %StructLiteralCapture %t189, double %t190, 1
  %t192 = insertvalue %StructLiteralCapture %t191, i1 0, 2
  ret %StructLiteralCapture %t192
merge17:
  %t193 = load double, double* %l3
  %t194 = sitofp i64 0 to double
  %t195 = fcmp oeq double %t193, %t194
  %t196 = load i8*, i8** %l0
  %t197 = load i8*, i8** %l1
  %t198 = load double, double* %l2
  %t199 = load double, double* %l3
  %t200 = load double, double* %l4
  br i1 %t195, label %then18, label %merge19
then18:
  %t201 = load i8*, i8** %l0
  %t202 = insertvalue %StructLiteralCapture undef, i8* %t201, 0
  %t203 = sitofp i64 0 to double
  %t204 = insertvalue %StructLiteralCapture %t202, double %t203, 1
  %t205 = insertvalue %StructLiteralCapture %t204, i1 0, 2
  ret %StructLiteralCapture %t205
merge19:
  %t206 = load i8*, i8** %l1
  %t207 = call i8* @trim_text(i8* %t206)
  %t208 = call i8* @trim_trailing_delimiters(i8* %t207)
  store i8* %t208, i8** %l7
  %t209 = load i8*, i8** %l7
  %t210 = alloca [2 x i8], align 1
  %t211 = getelementptr [2 x i8], [2 x i8]* %t210, i32 0, i32 0
  store i8 125, i8* %t211
  %t212 = getelementptr [2 x i8], [2 x i8]* %t210, i32 0, i32 1
  store i8 0, i8* %t212
  %t213 = getelementptr [2 x i8], [2 x i8]* %t210, i32 0, i32 0
  %t214 = call i1 @ends_with(i8* %t209, i8* %t213)
  %t215 = xor i1 %t214, 1
  %t216 = load i8*, i8** %l0
  %t217 = load i8*, i8** %l1
  %t218 = load double, double* %l2
  %t219 = load double, double* %l3
  %t220 = load double, double* %l4
  %t221 = load i8*, i8** %l7
  br i1 %t215, label %then20, label %merge21
then20:
  %t222 = load i8*, i8** %l0
  %t223 = insertvalue %StructLiteralCapture undef, i8* %t222, 0
  %t224 = sitofp i64 0 to double
  %t225 = insertvalue %StructLiteralCapture %t223, double %t224, 1
  %t226 = insertvalue %StructLiteralCapture %t225, i1 0, 2
  ret %StructLiteralCapture %t226
merge21:
  %t227 = load i8*, i8** %l7
  %t228 = insertvalue %StructLiteralCapture undef, i8* %t227, 0
  %t229 = load double, double* %l3
  %t230 = insertvalue %StructLiteralCapture %t228, double %t229, 1
  %t231 = insertvalue %StructLiteralCapture %t230, i1 1, 2
  ret %StructLiteralCapture %t231
}

; NOTE: Returns string via output parameter %out_result
define void @rewrite_expression_intrinsics(i8* %expression, i8** %out_result) {
block.entry:
  %l0 = alloca i8*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  store i8* %expression, i8** %out_result
  ret void
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
  store i8* %t12, i8** %out_result
  ret void
}

; NOTE: Returns string via output parameter %out_result
define void @rewrite_logical_operators(i8* %expression, i8** %out_result) {
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
  store i8* %expression, i8** %out_result
  ret void
merge1:
  %s2 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s2, i8** %l0
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l1
  %t4 = load i8*, i8** %l0
  %t5 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t195 = phi i8* [ %t4, %merge1 ], [ %t193, %loop.latch4 ]
  %t196 = phi double [ %t5, %merge1 ], [ %t194, %loop.latch4 ]
  store i8* %t195, i8** %l0
  store double %t196, double* %l1
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
  %t16 = call double @llvm.round.f64(double %t12)
  %t17 = fptosi double %t16 to i64
  %t18 = call double @llvm.round.f64(double %t15)
  %t19 = fptosi double %t18 to i64
  %t20 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t17, i64 %t19)
  store i8* %t20, i8** %l2
  %t22 = load i8*, i8** %l2
  %t23 = load i8, i8* %t22
  %t24 = icmp eq i8 %t23, 39
  br label %logical_or_entry_21

logical_or_entry_21:
  br i1 %t24, label %logical_or_merge_21, label %logical_or_right_21

logical_or_right_21:
  %t25 = load i8*, i8** %l2
  %t26 = load i8, i8* %t25
  %t27 = icmp eq i8 %t26, 34
  br label %logical_or_right_end_21

logical_or_right_end_21:
  br label %logical_or_merge_21

logical_or_merge_21:
  %t28 = phi i1 [ true, %logical_or_entry_21 ], [ %t27, %logical_or_right_end_21 ]
  %t29 = load i8*, i8** %l0
  %t30 = load double, double* %l1
  %t31 = load i8*, i8** %l2
  br i1 %t28, label %then8, label %merge9
then8:
  %t32 = load double, double* %l1
  %t33 = call double @skip_string_literal(i8* %expression, double %t32)
  store double %t33, double* %l3
  %t34 = load i8*, i8** %l0
  %t35 = load double, double* %l1
  %t36 = load double, double* %l3
  %t37 = call double @llvm.round.f64(double %t35)
  %t38 = fptosi double %t37 to i64
  %t39 = call double @llvm.round.f64(double %t36)
  %t40 = fptosi double %t39 to i64
  %t41 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t38, i64 %t40)
  %t42 = call i8* @sailfin_runtime_string_concat(i8* %t34, i8* %t41)
  store i8* %t42, i8** %l0
  %t43 = load double, double* %l3
  store double %t43, double* %l1
  br label %loop.latch4
merge9:
  %t44 = load i8*, i8** %l2
  %t45 = load i8, i8* %t44
  %t46 = icmp eq i8 %t45, 38
  %t47 = load i8*, i8** %l0
  %t48 = load double, double* %l1
  %t49 = load i8*, i8** %l2
  br i1 %t46, label %then10, label %merge11
then10:
  %t50 = load double, double* %l1
  %t51 = sitofp i64 1 to double
  %t52 = fadd double %t50, %t51
  %t53 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t54 = sitofp i64 %t53 to double
  %t55 = fcmp olt double %t52, %t54
  %t56 = load i8*, i8** %l0
  %t57 = load double, double* %l1
  %t58 = load i8*, i8** %l2
  br i1 %t55, label %then12, label %merge13
then12:
  %t59 = load double, double* %l1
  %t60 = sitofp i64 1 to double
  %t61 = fadd double %t59, %t60
  %t62 = load double, double* %l1
  %t63 = sitofp i64 2 to double
  %t64 = fadd double %t62, %t63
  %t65 = call double @llvm.round.f64(double %t61)
  %t66 = fptosi double %t65 to i64
  %t67 = call double @llvm.round.f64(double %t64)
  %t68 = fptosi double %t67 to i64
  %t69 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t66, i64 %t68)
  store i8* %t69, i8** %l4
  %t70 = load i8*, i8** %l4
  %t71 = load i8, i8* %t70
  %t72 = icmp eq i8 %t71, 38
  %t73 = load i8*, i8** %l0
  %t74 = load double, double* %l1
  %t75 = load i8*, i8** %l2
  %t76 = load i8*, i8** %l4
  br i1 %t72, label %then14, label %merge15
then14:
  %t77 = load i8*, i8** %l0
  %s78 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1503489441, i32 0, i32 0
  %t79 = call i8* @sailfin_runtime_string_concat(i8* %t77, i8* %s78)
  store i8* %t79, i8** %l0
  %t80 = load double, double* %l1
  %t81 = sitofp i64 2 to double
  %t82 = fadd double %t80, %t81
  store double %t82, double* %l1
  br label %loop.latch4
merge15:
  %t83 = load i8*, i8** %l0
  %t84 = load double, double* %l1
  br label %merge13
merge13:
  %t85 = phi i8* [ %t83, %merge15 ], [ %t56, %then10 ]
  %t86 = phi double [ %t84, %merge15 ], [ %t57, %then10 ]
  store i8* %t85, i8** %l0
  store double %t86, double* %l1
  %t87 = load i8*, i8** %l0
  %t88 = load double, double* %l1
  br label %merge11
merge11:
  %t89 = phi i8* [ %t87, %merge13 ], [ %t47, %merge9 ]
  %t90 = phi double [ %t88, %merge13 ], [ %t48, %merge9 ]
  store i8* %t89, i8** %l0
  store double %t90, double* %l1
  %t91 = load i8*, i8** %l2
  %t92 = load i8, i8* %t91
  %t93 = icmp eq i8 %t92, 124
  %t94 = load i8*, i8** %l0
  %t95 = load double, double* %l1
  %t96 = load i8*, i8** %l2
  br i1 %t93, label %then16, label %merge17
then16:
  %t97 = load double, double* %l1
  %t98 = sitofp i64 1 to double
  %t99 = fadd double %t97, %t98
  %t100 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t101 = sitofp i64 %t100 to double
  %t102 = fcmp olt double %t99, %t101
  %t103 = load i8*, i8** %l0
  %t104 = load double, double* %l1
  %t105 = load i8*, i8** %l2
  br i1 %t102, label %then18, label %merge19
then18:
  %t106 = load double, double* %l1
  %t107 = sitofp i64 1 to double
  %t108 = fadd double %t106, %t107
  %t109 = load double, double* %l1
  %t110 = sitofp i64 2 to double
  %t111 = fadd double %t109, %t110
  %t112 = call double @llvm.round.f64(double %t108)
  %t113 = fptosi double %t112 to i64
  %t114 = call double @llvm.round.f64(double %t111)
  %t115 = fptosi double %t114 to i64
  %t116 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t113, i64 %t115)
  store i8* %t116, i8** %l5
  %t117 = load i8*, i8** %l5
  %t118 = load i8, i8* %t117
  %t119 = icmp eq i8 %t118, 124
  %t120 = load i8*, i8** %l0
  %t121 = load double, double* %l1
  %t122 = load i8*, i8** %l2
  %t123 = load i8*, i8** %l5
  br i1 %t119, label %then20, label %merge21
then20:
  %t124 = load i8*, i8** %l0
  %s125 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h176216012, i32 0, i32 0
  %t126 = call i8* @sailfin_runtime_string_concat(i8* %t124, i8* %s125)
  store i8* %t126, i8** %l0
  %t127 = load double, double* %l1
  %t128 = sitofp i64 2 to double
  %t129 = fadd double %t127, %t128
  store double %t129, double* %l1
  br label %loop.latch4
merge21:
  %t130 = load i8*, i8** %l0
  %t131 = load double, double* %l1
  br label %merge19
merge19:
  %t132 = phi i8* [ %t130, %merge21 ], [ %t103, %then16 ]
  %t133 = phi double [ %t131, %merge21 ], [ %t104, %then16 ]
  store i8* %t132, i8** %l0
  store double %t133, double* %l1
  %t134 = load i8*, i8** %l0
  %t135 = load double, double* %l1
  br label %merge17
merge17:
  %t136 = phi i8* [ %t134, %merge19 ], [ %t94, %merge11 ]
  %t137 = phi double [ %t135, %merge19 ], [ %t95, %merge11 ]
  store i8* %t136, i8** %l0
  store double %t137, double* %l1
  %t138 = load i8*, i8** %l2
  %t139 = load i8, i8* %t138
  %t140 = icmp eq i8 %t139, 33
  %t141 = load i8*, i8** %l0
  %t142 = load double, double* %l1
  %t143 = load i8*, i8** %l2
  br i1 %t140, label %then22, label %merge23
then22:
  %t144 = load double, double* %l1
  %t145 = sitofp i64 1 to double
  %t146 = fadd double %t144, %t145
  %t147 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t148 = sitofp i64 %t147 to double
  %t149 = fcmp olt double %t146, %t148
  %t150 = load i8*, i8** %l0
  %t151 = load double, double* %l1
  %t152 = load i8*, i8** %l2
  br i1 %t149, label %then24, label %merge25
then24:
  %t153 = load double, double* %l1
  %t154 = sitofp i64 1 to double
  %t155 = fadd double %t153, %t154
  %t156 = load double, double* %l1
  %t157 = sitofp i64 2 to double
  %t158 = fadd double %t156, %t157
  %t159 = call double @llvm.round.f64(double %t155)
  %t160 = fptosi double %t159 to i64
  %t161 = call double @llvm.round.f64(double %t158)
  %t162 = fptosi double %t161 to i64
  %t163 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t160, i64 %t162)
  store i8* %t163, i8** %l6
  %t164 = load i8*, i8** %l6
  %t165 = load i8, i8* %t164
  %t166 = icmp eq i8 %t165, 61
  %t167 = load i8*, i8** %l0
  %t168 = load double, double* %l1
  %t169 = load i8*, i8** %l2
  %t170 = load i8*, i8** %l6
  br i1 %t166, label %then26, label %merge27
then26:
  %t171 = load i8*, i8** %l0
  %s172 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193414949, i32 0, i32 0
  %t173 = call i8* @sailfin_runtime_string_concat(i8* %t171, i8* %s172)
  store i8* %t173, i8** %l0
  %t174 = load double, double* %l1
  %t175 = sitofp i64 2 to double
  %t176 = fadd double %t174, %t175
  store double %t176, double* %l1
  br label %loop.latch4
merge27:
  %t177 = load i8*, i8** %l0
  %t178 = load double, double* %l1
  br label %merge25
merge25:
  %t179 = phi i8* [ %t177, %merge27 ], [ %t150, %then22 ]
  %t180 = phi double [ %t178, %merge27 ], [ %t151, %then22 ]
  store i8* %t179, i8** %l0
  store double %t180, double* %l1
  %t181 = load i8*, i8** %l0
  %s182 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h268720028, i32 0, i32 0
  %t183 = call i8* @sailfin_runtime_string_concat(i8* %t181, i8* %s182)
  store i8* %t183, i8** %l0
  %t184 = load double, double* %l1
  %t185 = sitofp i64 1 to double
  %t186 = fadd double %t184, %t185
  store double %t186, double* %l1
  br label %loop.latch4
merge23:
  %t187 = load i8*, i8** %l0
  %t188 = load i8*, i8** %l2
  %t189 = call i8* @sailfin_runtime_string_concat(i8* %t187, i8* %t188)
  store i8* %t189, i8** %l0
  %t190 = load double, double* %l1
  %t191 = sitofp i64 1 to double
  %t192 = fadd double %t190, %t191
  store double %t192, double* %l1
  br label %loop.latch4
loop.latch4:
  %t193 = load i8*, i8** %l0
  %t194 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t197 = load i8*, i8** %l0
  %t198 = load double, double* %l1
  %t199 = load i8*, i8** %l0
  store i8* %t199, i8** %out_result
  ret void
}

; NOTE: Returns string via output parameter %out_result
define void @rewrite_literal_tokens(i8* %expression, i8** %out_result) {
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
  store i8* %expression, i8** %out_result
  ret void
merge1:
  %s2 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s2, i8** %l0
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l1
  %t4 = load i8*, i8** %l0
  %t5 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t148 = phi i8* [ %t4, %merge1 ], [ %t146, %loop.latch4 ]
  %t149 = phi double [ %t5, %merge1 ], [ %t147, %loop.latch4 ]
  store i8* %t148, i8** %l0
  store double %t149, double* %l1
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
  %t16 = call double @llvm.round.f64(double %t12)
  %t17 = fptosi double %t16 to i64
  %t18 = call double @llvm.round.f64(double %t15)
  %t19 = fptosi double %t18 to i64
  %t20 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t17, i64 %t19)
  store i8* %t20, i8** %l2
  %t22 = load i8*, i8** %l2
  %t23 = load i8, i8* %t22
  %t24 = icmp eq i8 %t23, 39
  br label %logical_or_entry_21

logical_or_entry_21:
  br i1 %t24, label %logical_or_merge_21, label %logical_or_right_21

logical_or_right_21:
  %t25 = load i8*, i8** %l2
  %t26 = load i8, i8* %t25
  %t27 = icmp eq i8 %t26, 34
  br label %logical_or_right_end_21

logical_or_right_end_21:
  br label %logical_or_merge_21

logical_or_merge_21:
  %t28 = phi i1 [ true, %logical_or_entry_21 ], [ %t27, %logical_or_right_end_21 ]
  %t29 = load i8*, i8** %l0
  %t30 = load double, double* %l1
  %t31 = load i8*, i8** %l2
  br i1 %t28, label %then8, label %merge9
then8:
  %t32 = load double, double* %l1
  %t33 = call double @skip_string_literal(i8* %expression, double %t32)
  store double %t33, double* %l3
  %t34 = load i8*, i8** %l0
  %t35 = load double, double* %l1
  %t36 = load double, double* %l3
  %t37 = call double @llvm.round.f64(double %t35)
  %t38 = fptosi double %t37 to i64
  %t39 = call double @llvm.round.f64(double %t36)
  %t40 = fptosi double %t39 to i64
  %t41 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t38, i64 %t40)
  %t42 = call i8* @sailfin_runtime_string_concat(i8* %t34, i8* %t41)
  store i8* %t42, i8** %l0
  %t43 = load double, double* %l3
  store double %t43, double* %l1
  br label %loop.latch4
merge9:
  %t44 = load i8*, i8** %l2
  %t45 = call i1 @is_identifier_char(i8* %t44)
  %t46 = load i8*, i8** %l0
  %t47 = load double, double* %l1
  %t48 = load i8*, i8** %l2
  br i1 %t45, label %then10, label %merge11
then10:
  %t49 = load double, double* %l1
  store double %t49, double* %l4
  %t50 = load i8*, i8** %l0
  %t51 = load double, double* %l1
  %t52 = load i8*, i8** %l2
  %t53 = load double, double* %l4
  br label %loop.header12
loop.header12:
  %t83 = phi double [ %t51, %then10 ], [ %t82, %loop.latch14 ]
  store double %t83, double* %l1
  br label %loop.body13
loop.body13:
  %t54 = load double, double* %l1
  %t55 = sitofp i64 1 to double
  %t56 = fadd double %t54, %t55
  store double %t56, double* %l1
  %t57 = load double, double* %l1
  %t58 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t59 = sitofp i64 %t58 to double
  %t60 = fcmp oge double %t57, %t59
  %t61 = load i8*, i8** %l0
  %t62 = load double, double* %l1
  %t63 = load i8*, i8** %l2
  %t64 = load double, double* %l4
  br i1 %t60, label %then16, label %merge17
then16:
  br label %afterloop15
merge17:
  %t65 = load double, double* %l1
  %t66 = load double, double* %l1
  %t67 = sitofp i64 1 to double
  %t68 = fadd double %t66, %t67
  %t69 = call double @llvm.round.f64(double %t65)
  %t70 = fptosi double %t69 to i64
  %t71 = call double @llvm.round.f64(double %t68)
  %t72 = fptosi double %t71 to i64
  %t73 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t70, i64 %t72)
  store i8* %t73, i8** %l5
  %t74 = load i8*, i8** %l5
  %t75 = call i1 @is_identifier_char(i8* %t74)
  %t76 = xor i1 %t75, 1
  %t77 = load i8*, i8** %l0
  %t78 = load double, double* %l1
  %t79 = load i8*, i8** %l2
  %t80 = load double, double* %l4
  %t81 = load i8*, i8** %l5
  br i1 %t76, label %then18, label %merge19
then18:
  br label %afterloop15
merge19:
  br label %loop.latch14
loop.latch14:
  %t82 = load double, double* %l1
  br label %loop.header12
afterloop15:
  %t84 = load double, double* %l1
  %t85 = load double, double* %l4
  %t86 = load double, double* %l1
  %t87 = call double @llvm.round.f64(double %t85)
  %t88 = fptosi double %t87 to i64
  %t89 = call double @llvm.round.f64(double %t86)
  %t90 = fptosi double %t89 to i64
  %t91 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t88, i64 %t90)
  store i8* %t91, i8** %l6
  %t92 = load i8*, i8** %l6
  %s93 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h268929446, i32 0, i32 0
  %t94 = call i1 @strings_equal(i8* %t92, i8* %s93)
  %t95 = load i8*, i8** %l0
  %t96 = load double, double* %l1
  %t97 = load i8*, i8** %l2
  %t98 = load double, double* %l4
  %t99 = load i8*, i8** %l6
  br i1 %t94, label %then20, label %else21
then20:
  %t100 = load i8*, i8** %l0
  %s101 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h230766299, i32 0, i32 0
  %t102 = call i8* @sailfin_runtime_string_concat(i8* %t100, i8* %s101)
  store i8* %t102, i8** %l0
  %t103 = load i8*, i8** %l0
  br label %merge22
else21:
  %t104 = load i8*, i8** %l6
  %s105 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h275946731, i32 0, i32 0
  %t106 = call i1 @strings_equal(i8* %t104, i8* %s105)
  %t107 = load i8*, i8** %l0
  %t108 = load double, double* %l1
  %t109 = load i8*, i8** %l2
  %t110 = load double, double* %l4
  %t111 = load i8*, i8** %l6
  br i1 %t106, label %then23, label %else24
then23:
  %t112 = load i8*, i8** %l0
  %s113 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h237997259, i32 0, i32 0
  %t114 = call i8* @sailfin_runtime_string_concat(i8* %t112, i8* %s113)
  store i8* %t114, i8** %l0
  %t115 = load i8*, i8** %l0
  br label %merge25
else24:
  %t116 = load i8*, i8** %l6
  %s117 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2095430042, i32 0, i32 0
  %t118 = call i1 @strings_equal(i8* %t116, i8* %s117)
  %t119 = load i8*, i8** %l0
  %t120 = load double, double* %l1
  %t121 = load i8*, i8** %l2
  %t122 = load double, double* %l4
  %t123 = load i8*, i8** %l6
  br i1 %t118, label %then26, label %else27
then26:
  %t124 = load i8*, i8** %l0
  %s125 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h843097466, i32 0, i32 0
  %t126 = call i8* @sailfin_runtime_string_concat(i8* %t124, i8* %s125)
  store i8* %t126, i8** %l0
  %t127 = load i8*, i8** %l0
  br label %merge28
else27:
  %t128 = load i8*, i8** %l0
  %t129 = load i8*, i8** %l6
  %t130 = call i8* @sailfin_runtime_string_concat(i8* %t128, i8* %t129)
  store i8* %t130, i8** %l0
  %t131 = load i8*, i8** %l0
  br label %merge28
merge28:
  %t132 = phi i8* [ %t127, %then26 ], [ %t131, %else27 ]
  store i8* %t132, i8** %l0
  %t133 = load i8*, i8** %l0
  %t134 = load i8*, i8** %l0
  br label %merge25
merge25:
  %t135 = phi i8* [ %t115, %then23 ], [ %t133, %merge28 ]
  store i8* %t135, i8** %l0
  %t136 = load i8*, i8** %l0
  %t137 = load i8*, i8** %l0
  %t138 = load i8*, i8** %l0
  br label %merge22
merge22:
  %t139 = phi i8* [ %t103, %then20 ], [ %t136, %merge25 ]
  store i8* %t139, i8** %l0
  br label %loop.latch4
merge11:
  %t140 = load i8*, i8** %l0
  %t141 = load i8*, i8** %l2
  %t142 = call i8* @sailfin_runtime_string_concat(i8* %t140, i8* %t141)
  store i8* %t142, i8** %l0
  %t143 = load double, double* %l1
  %t144 = sitofp i64 1 to double
  %t145 = fadd double %t143, %t144
  store double %t145, double* %l1
  br label %loop.latch4
loop.latch4:
  %t146 = load i8*, i8** %l0
  %t147 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t150 = load i8*, i8** %l0
  %t151 = load double, double* %l1
  %t152 = load i8*, i8** %l0
  store i8* %t152, i8** %out_result
  ret void
}

; NOTE: Returns string via output parameter %out_result
define void @rewrite_push_calls(i8* %expression, i8** %out_result) {
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
  store i8* %expression, i8** %out_result
  ret void
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
  %t105 = phi i8* [ %t8, %merge1 ], [ %t103, %loop.latch4 ]
  %t106 = phi double [ %t9, %merge1 ], [ %t104, %loop.latch4 ]
  store i8* %t105, i8** %l2
  store double %t106, double* %l3
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
  %t22 = call double @llvm.round.f64(double %t18)
  %t23 = fptosi double %t22 to i64
  %t24 = call double @llvm.round.f64(double %t21)
  %t25 = fptosi double %t24 to i64
  %t26 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t23, i64 %t25)
  store i8* %t26, i8** %l4
  %t28 = load i8*, i8** %l4
  %t29 = load i8, i8* %t28
  %t30 = icmp eq i8 %t29, 39
  br label %logical_or_entry_27

logical_or_entry_27:
  br i1 %t30, label %logical_or_merge_27, label %logical_or_right_27

logical_or_right_27:
  %t31 = load i8*, i8** %l4
  %t32 = load i8, i8* %t31
  %t33 = icmp eq i8 %t32, 34
  br label %logical_or_right_end_27

logical_or_right_end_27:
  br label %logical_or_merge_27

logical_or_merge_27:
  %t34 = phi i1 [ true, %logical_or_entry_27 ], [ %t33, %logical_or_right_end_27 ]
  %t35 = load i8*, i8** %l0
  %t36 = load i8*, i8** %l1
  %t37 = load i8*, i8** %l2
  %t38 = load double, double* %l3
  %t39 = load i8*, i8** %l4
  br i1 %t34, label %then8, label %merge9
then8:
  %t40 = load double, double* %l3
  %t41 = call double @skip_string_literal(i8* %expression, double %t40)
  store double %t41, double* %l5
  %t42 = load i8*, i8** %l2
  %t43 = load double, double* %l3
  %t44 = load double, double* %l5
  %t45 = call double @llvm.round.f64(double %t43)
  %t46 = fptosi double %t45 to i64
  %t47 = call double @llvm.round.f64(double %t44)
  %t48 = fptosi double %t47 to i64
  %t49 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t46, i64 %t48)
  %t50 = call i8* @sailfin_runtime_string_concat(i8* %t42, i8* %t49)
  store i8* %t50, i8** %l2
  %t51 = load double, double* %l5
  store double %t51, double* %l3
  br label %loop.latch4
merge9:
  %t52 = load double, double* %l3
  %t53 = load i8*, i8** %l0
  %t54 = call i64 @sailfin_runtime_string_length(i8* %t53)
  %t55 = sitofp i64 %t54 to double
  %t56 = fadd double %t52, %t55
  %t57 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t58 = sitofp i64 %t57 to double
  %t59 = fcmp ole double %t56, %t58
  %t60 = load i8*, i8** %l0
  %t61 = load i8*, i8** %l1
  %t62 = load i8*, i8** %l2
  %t63 = load double, double* %l3
  %t64 = load i8*, i8** %l4
  br i1 %t59, label %then10, label %merge11
then10:
  %t65 = load double, double* %l3
  %t66 = load double, double* %l3
  %t67 = load i8*, i8** %l0
  %t68 = call i64 @sailfin_runtime_string_length(i8* %t67)
  %t69 = sitofp i64 %t68 to double
  %t70 = fadd double %t66, %t69
  %t71 = call double @llvm.round.f64(double %t65)
  %t72 = fptosi double %t71 to i64
  %t73 = call double @llvm.round.f64(double %t70)
  %t74 = fptosi double %t73 to i64
  %t75 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t72, i64 %t74)
  store i8* %t75, i8** %l6
  %t76 = load i8*, i8** %l6
  %t77 = load i8*, i8** %l0
  %t78 = call i1 @strings_equal(i8* %t76, i8* %t77)
  %t79 = load i8*, i8** %l0
  %t80 = load i8*, i8** %l1
  %t81 = load i8*, i8** %l2
  %t82 = load double, double* %l3
  %t83 = load i8*, i8** %l4
  %t84 = load i8*, i8** %l6
  br i1 %t78, label %then12, label %merge13
then12:
  %t85 = load i8*, i8** %l2
  %t86 = load i8*, i8** %l1
  %t87 = call i8* @sailfin_runtime_string_concat(i8* %t85, i8* %t86)
  store i8* %t87, i8** %l2
  %t88 = load double, double* %l3
  %t89 = load i8*, i8** %l0
  %t90 = call i64 @sailfin_runtime_string_length(i8* %t89)
  %t91 = sitofp i64 %t90 to double
  %t92 = fadd double %t88, %t91
  store double %t92, double* %l3
  br label %loop.latch4
merge13:
  %t93 = load i8*, i8** %l2
  %t94 = load double, double* %l3
  br label %merge11
merge11:
  %t95 = phi i8* [ %t93, %merge13 ], [ %t62, %merge9 ]
  %t96 = phi double [ %t94, %merge13 ], [ %t63, %merge9 ]
  store i8* %t95, i8** %l2
  store double %t96, double* %l3
  %t97 = load i8*, i8** %l2
  %t98 = load i8*, i8** %l4
  %t99 = call i8* @sailfin_runtime_string_concat(i8* %t97, i8* %t98)
  store i8* %t99, i8** %l2
  %t100 = load double, double* %l3
  %t101 = sitofp i64 1 to double
  %t102 = fadd double %t100, %t101
  store double %t102, double* %l3
  br label %loop.latch4
loop.latch4:
  %t103 = load i8*, i8** %l2
  %t104 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t107 = load i8*, i8** %l2
  %t108 = load double, double* %l3
  %t109 = load i8*, i8** %l2
  store i8* %t109, i8** %out_result
  ret void
}

; NOTE: Returns string via output parameter %out_result
define void @rewrite_concat_calls(i8* %expression, i8** %out_result) {
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
  %t73 = phi i8* [ %t0, %block.entry ], [ %t72, %loop.latch2 ]
  store i8* %t73, i8** %l0
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
  %t35 = call double @llvm.round.f64(double %t34)
  %t36 = fptosi double %t35 to i64
  %t37 = call i8* @sailfin_runtime_substring(i8* %t32, i64 0, i64 %t36)
  store i8* %t37, i8** %l5
  %t38 = load i8*, i8** %l0
  %t39 = load %ExtractedSpan, %ExtractedSpan* %l4
  %t40 = extractvalue %ExtractedSpan %t39, 2
  %t41 = load i8*, i8** %l0
  %t42 = call i64 @sailfin_runtime_string_length(i8* %t41)
  %t43 = call double @llvm.round.f64(double %t40)
  %t44 = fptosi double %t43 to i64
  %t45 = call i8* @sailfin_runtime_substring(i8* %t38, i64 %t44, i64 %t42)
  store i8* %t45, i8** %l6
  %t46 = load %ExtractedSpan, %ExtractedSpan* %l2
  %t47 = extractvalue %ExtractedSpan %t46, 0
  %t48 = call i8* @trim_text(i8* %t47)
  store i8* %t48, i8** %l7
  %t49 = load %ExtractedSpan, %ExtractedSpan* %l4
  %t50 = extractvalue %ExtractedSpan %t49, 0
  %t51 = call i8* @trim_text(i8* %t50)
  store i8* %t51, i8** %l8
  %t52 = load i8*, i8** %l7
  %t53 = alloca [2 x i8], align 1
  %t54 = getelementptr [2 x i8], [2 x i8]* %t53, i32 0, i32 0
  store i8 40, i8* %t54
  %t55 = getelementptr [2 x i8], [2 x i8]* %t53, i32 0, i32 1
  store i8 0, i8* %t55
  %t56 = getelementptr [2 x i8], [2 x i8]* %t53, i32 0, i32 0
  %t57 = call i8* @sailfin_runtime_string_concat(i8* %t56, i8* %t52)
  %s58 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1776141546, i32 0, i32 0
  %t59 = call i8* @sailfin_runtime_string_concat(i8* %t57, i8* %s58)
  %t60 = load i8*, i8** %l8
  %t61 = call i8* @sailfin_runtime_string_concat(i8* %t59, i8* %t60)
  %t62 = alloca [2 x i8], align 1
  %t63 = getelementptr [2 x i8], [2 x i8]* %t62, i32 0, i32 0
  store i8 41, i8* %t63
  %t64 = getelementptr [2 x i8], [2 x i8]* %t62, i32 0, i32 1
  store i8 0, i8* %t64
  %t65 = getelementptr [2 x i8], [2 x i8]* %t62, i32 0, i32 0
  %t66 = call i8* @sailfin_runtime_string_concat(i8* %t61, i8* %t65)
  store i8* %t66, i8** %l9
  %t67 = load i8*, i8** %l5
  %t68 = load i8*, i8** %l9
  %t69 = call i8* @sailfin_runtime_string_concat(i8* %t67, i8* %t68)
  %t70 = load i8*, i8** %l6
  %t71 = call i8* @sailfin_runtime_string_concat(i8* %t69, i8* %t70)
  store i8* %t71, i8** %l0
  br label %loop.latch2
loop.latch2:
  %t72 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t74 = load i8*, i8** %l0
  %t75 = load i8*, i8** %l0
  store i8* %t75, i8** %out_result
  ret void
}

; NOTE: Returns string via output parameter %out_result
define void @rewrite_length_accesses(i8* %expression, i8** %out_result) {
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
  %t58 = phi i8* [ %t0, %block.entry ], [ %t57, %loop.latch2 ]
  store i8* %t58, i8** %l0
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
  %t21 = call double @llvm.round.f64(double %t20)
  %t22 = fptosi double %t21 to i64
  %t23 = call i8* @sailfin_runtime_substring(i8* %t18, i64 0, i64 %t22)
  store i8* %t23, i8** %l3
  %t24 = load i8*, i8** %l0
  %t25 = load double, double* %l1
  %t26 = sitofp i64 7 to double
  %t27 = fadd double %t25, %t26
  %t28 = load i8*, i8** %l0
  %t29 = call i64 @sailfin_runtime_string_length(i8* %t28)
  %t30 = call double @llvm.round.f64(double %t27)
  %t31 = fptosi double %t30 to i64
  %t32 = call i8* @sailfin_runtime_substring(i8* %t24, i64 %t31, i64 %t29)
  store i8* %t32, i8** %l4
  %t33 = load %ExtractedSpan, %ExtractedSpan* %l2
  %t34 = extractvalue %ExtractedSpan %t33, 0
  %t35 = call i8* @trim_text(i8* %t34)
  store i8* %t35, i8** %l5
  %t36 = load i8*, i8** %l5
  %t37 = call i64 @sailfin_runtime_string_length(i8* %t36)
  %t38 = icmp eq i64 %t37, 0
  %t39 = load i8*, i8** %l0
  %t40 = load double, double* %l1
  %t41 = load %ExtractedSpan, %ExtractedSpan* %l2
  %t42 = load i8*, i8** %l3
  %t43 = load i8*, i8** %l4
  %t44 = load i8*, i8** %l5
  br i1 %t38, label %then8, label %merge9
then8:
  br label %afterloop3
merge9:
  %t45 = load i8*, i8** %l3
  %s46 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h265982546, i32 0, i32 0
  %t47 = call i8* @sailfin_runtime_string_concat(i8* %t45, i8* %s46)
  %t48 = load i8*, i8** %l5
  %t49 = call i8* @sailfin_runtime_string_concat(i8* %t47, i8* %t48)
  %t50 = alloca [2 x i8], align 1
  %t51 = getelementptr [2 x i8], [2 x i8]* %t50, i32 0, i32 0
  store i8 41, i8* %t51
  %t52 = getelementptr [2 x i8], [2 x i8]* %t50, i32 0, i32 1
  store i8 0, i8* %t52
  %t53 = getelementptr [2 x i8], [2 x i8]* %t50, i32 0, i32 0
  %t54 = call i8* @sailfin_runtime_string_concat(i8* %t49, i8* %t53)
  %t55 = load i8*, i8** %l4
  %t56 = call i8* @sailfin_runtime_string_concat(i8* %t54, i8* %t55)
  store i8* %t56, i8** %l0
  br label %loop.latch2
loop.latch2:
  %t57 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t59 = load i8*, i8** %l0
  %t60 = load i8*, i8** %l0
  store i8* %t60, i8** %out_result
  ret void
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
  %t129 = phi double [ %t14, %merge1 ], [ %t126, %loop.latch4 ]
  %t130 = phi double [ %t13, %merge1 ], [ %t127, %loop.latch4 ]
  %t131 = phi double [ %t15, %merge1 ], [ %t128, %loop.latch4 ]
  store double %t129, double* %l1
  store double %t130, double* %l0
  store double %t131, double* %l2
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
  %t26 = call double @llvm.round.f64(double %t22)
  %t27 = fptosi double %t26 to i64
  %t28 = call double @llvm.round.f64(double %t25)
  %t29 = fptosi double %t28 to i64
  %t30 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t27, i64 %t29)
  store i8* %t30, i8** %l3
  %t31 = load i8*, i8** %l3
  %t32 = load i8, i8* %t31
  %t33 = icmp eq i8 %t32, 93
  %t34 = load double, double* %l0
  %t35 = load double, double* %l1
  %t36 = load double, double* %l2
  %t37 = load i8*, i8** %l3
  br i1 %t33, label %then8, label %merge9
then8:
  %t38 = load double, double* %l1
  %t39 = sitofp i64 1 to double
  %t40 = fadd double %t38, %t39
  store double %t40, double* %l1
  %t41 = load double, double* %l0
  %t42 = sitofp i64 1 to double
  %t43 = fsub double %t41, %t42
  store double %t43, double* %l0
  br label %loop.latch4
merge9:
  %t44 = load i8*, i8** %l3
  %t45 = load i8, i8* %t44
  %t46 = icmp eq i8 %t45, 91
  %t47 = load double, double* %l0
  %t48 = load double, double* %l1
  %t49 = load double, double* %l2
  %t50 = load i8*, i8** %l3
  br i1 %t46, label %then10, label %merge11
then10:
  %t51 = load double, double* %l1
  %t52 = sitofp i64 0 to double
  %t53 = fcmp ogt double %t51, %t52
  %t54 = load double, double* %l0
  %t55 = load double, double* %l1
  %t56 = load double, double* %l2
  %t57 = load i8*, i8** %l3
  br i1 %t53, label %then12, label %merge13
then12:
  %t58 = load double, double* %l1
  %t59 = sitofp i64 1 to double
  %t60 = fsub double %t58, %t59
  store double %t60, double* %l1
  %t61 = load double, double* %l0
  %t62 = sitofp i64 1 to double
  %t63 = fsub double %t61, %t62
  store double %t63, double* %l0
  br label %loop.latch4
merge13:
  br label %afterloop5
merge11:
  %t64 = load i8*, i8** %l3
  %t65 = load i8, i8* %t64
  %t66 = icmp eq i8 %t65, 41
  %t67 = load double, double* %l0
  %t68 = load double, double* %l1
  %t69 = load double, double* %l2
  %t70 = load i8*, i8** %l3
  br i1 %t66, label %then14, label %merge15
then14:
  %t71 = load double, double* %l2
  %t72 = sitofp i64 1 to double
  %t73 = fadd double %t71, %t72
  store double %t73, double* %l2
  %t74 = load double, double* %l0
  %t75 = sitofp i64 1 to double
  %t76 = fsub double %t74, %t75
  store double %t76, double* %l0
  br label %loop.latch4
merge15:
  %t77 = load i8*, i8** %l3
  %t78 = load i8, i8* %t77
  %t79 = icmp eq i8 %t78, 40
  %t80 = load double, double* %l0
  %t81 = load double, double* %l1
  %t82 = load double, double* %l2
  %t83 = load i8*, i8** %l3
  br i1 %t79, label %then16, label %merge17
then16:
  %t84 = load double, double* %l2
  %t85 = sitofp i64 0 to double
  %t86 = fcmp ogt double %t84, %t85
  %t87 = load double, double* %l0
  %t88 = load double, double* %l1
  %t89 = load double, double* %l2
  %t90 = load i8*, i8** %l3
  br i1 %t86, label %then18, label %merge19
then18:
  %t91 = load double, double* %l2
  %t92 = sitofp i64 1 to double
  %t93 = fsub double %t91, %t92
  store double %t93, double* %l2
  %t94 = load double, double* %l0
  %t95 = sitofp i64 1 to double
  %t96 = fsub double %t94, %t95
  store double %t96, double* %l0
  br label %loop.latch4
merge19:
  br label %afterloop5
merge17:
  %t98 = load double, double* %l1
  %t99 = sitofp i64 0 to double
  %t100 = fcmp ogt double %t98, %t99
  br label %logical_or_entry_97

logical_or_entry_97:
  br i1 %t100, label %logical_or_merge_97, label %logical_or_right_97

logical_or_right_97:
  %t101 = load double, double* %l2
  %t102 = sitofp i64 0 to double
  %t103 = fcmp ogt double %t101, %t102
  br label %logical_or_right_end_97

logical_or_right_end_97:
  br label %logical_or_merge_97

logical_or_merge_97:
  %t104 = phi i1 [ true, %logical_or_entry_97 ], [ %t103, %logical_or_right_end_97 ]
  %t105 = load double, double* %l0
  %t106 = load double, double* %l1
  %t107 = load double, double* %l2
  %t108 = load i8*, i8** %l3
  br i1 %t104, label %then20, label %merge21
then20:
  %t109 = load double, double* %l0
  %t110 = sitofp i64 1 to double
  %t111 = fsub double %t109, %t110
  store double %t111, double* %l0
  br label %loop.latch4
merge21:
  %t113 = load i8*, i8** %l3
  %t114 = call i1 @is_identifier_char(i8* %t113)
  br label %logical_or_entry_112

logical_or_entry_112:
  br i1 %t114, label %logical_or_merge_112, label %logical_or_right_112

logical_or_right_112:
  %t115 = load i8*, i8** %l3
  %t116 = load i8, i8* %t115
  %t117 = icmp eq i8 %t116, 46
  br label %logical_or_right_end_112

logical_or_right_end_112:
  br label %logical_or_merge_112

logical_or_merge_112:
  %t118 = phi i1 [ true, %logical_or_entry_112 ], [ %t117, %logical_or_right_end_112 ]
  %t119 = load double, double* %l0
  %t120 = load double, double* %l1
  %t121 = load double, double* %l2
  %t122 = load i8*, i8** %l3
  br i1 %t118, label %then22, label %merge23
then22:
  %t123 = load double, double* %l0
  %t124 = sitofp i64 1 to double
  %t125 = fsub double %t123, %t124
  store double %t125, double* %l0
  br label %loop.latch4
merge23:
  br label %afterloop5
loop.latch4:
  %t126 = load double, double* %l1
  %t127 = load double, double* %l0
  %t128 = load double, double* %l2
  br label %loop.header2
afterloop5:
  %t132 = load double, double* %l1
  %t133 = load double, double* %l0
  %t134 = load double, double* %l2
  %t135 = load double, double* %l0
  %t136 = sitofp i64 1 to double
  %t137 = fadd double %t135, %t136
  store double %t137, double* %l4
  %t138 = load double, double* %l4
  %t139 = fcmp oge double %t138, %dot_index
  %t140 = load double, double* %l0
  %t141 = load double, double* %l1
  %t142 = load double, double* %l2
  %t143 = load double, double* %l4
  br i1 %t139, label %then24, label %merge25
then24:
  %s144 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t145 = insertvalue %ExtractedSpan undef, i8* %s144, 0
  %t146 = load double, double* %l4
  %t147 = insertvalue %ExtractedSpan %t145, double %t146, 1
  %t148 = insertvalue %ExtractedSpan %t147, double %dot_index, 2
  %t149 = insertvalue %ExtractedSpan %t148, i1 0, 3
  ret %ExtractedSpan %t149
merge25:
  %t150 = load double, double* %l4
  %t151 = call double @llvm.round.f64(double %t150)
  %t152 = fptosi double %t151 to i64
  %t153 = call double @llvm.round.f64(double %dot_index)
  %t154 = fptosi double %t153 to i64
  %t155 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t152, i64 %t154)
  store i8* %t155, i8** %l5
  %t156 = load i8*, i8** %l5
  %t157 = insertvalue %ExtractedSpan undef, i8* %t156, 0
  %t158 = load double, double* %l4
  %t159 = insertvalue %ExtractedSpan %t157, double %t158, 1
  %t160 = insertvalue %ExtractedSpan %t159, double %dot_index, 2
  %t161 = insertvalue %ExtractedSpan %t160, i1 1, 3
  ret %ExtractedSpan %t161
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
  %t10 = call double @llvm.round.f64(double %open_index)
  %t11 = fptosi double %t10 to i64
  %t12 = call double @llvm.round.f64(double %t9)
  %t13 = fptosi double %t12 to i64
  %t14 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t11, i64 %t13)
  %t15 = load i8, i8* %t14
  %t16 = icmp ne i8 %t15, 40
  br i1 %t16, label %then2, label %merge3
then2:
  %s17 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t18 = insertvalue %ExtractedSpan undef, i8* %s17, 0
  %t19 = insertvalue %ExtractedSpan %t18, double %open_index, 1
  %t20 = insertvalue %ExtractedSpan %t19, double %open_index, 2
  %t21 = insertvalue %ExtractedSpan %t20, i1 0, 3
  ret %ExtractedSpan %t21
merge3:
  %t22 = sitofp i64 1 to double
  %t23 = fadd double %open_index, %t22
  store double %t23, double* %l0
  %t24 = sitofp i64 1 to double
  store double %t24, double* %l1
  %t25 = load double, double* %l0
  %t26 = load double, double* %l1
  br label %loop.header4
loop.header4:
  %t111 = phi double [ %t26, %merge3 ], [ %t109, %loop.latch6 ]
  %t112 = phi double [ %t25, %merge3 ], [ %t110, %loop.latch6 ]
  store double %t111, double* %l1
  store double %t112, double* %l0
  br label %loop.body5
loop.body5:
  %t27 = load double, double* %l0
  %t28 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t29 = sitofp i64 %t28 to double
  %t30 = fcmp oge double %t27, %t29
  %t31 = load double, double* %l0
  %t32 = load double, double* %l1
  br i1 %t30, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t33 = load double, double* %l0
  %t34 = load double, double* %l0
  %t35 = sitofp i64 1 to double
  %t36 = fadd double %t34, %t35
  %t37 = call double @llvm.round.f64(double %t33)
  %t38 = fptosi double %t37 to i64
  %t39 = call double @llvm.round.f64(double %t36)
  %t40 = fptosi double %t39 to i64
  %t41 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t38, i64 %t40)
  store i8* %t41, i8** %l2
  %t42 = load i8*, i8** %l2
  %t43 = load i8, i8* %t42
  %t44 = icmp eq i8 %t43, 40
  %t45 = load double, double* %l0
  %t46 = load double, double* %l1
  %t47 = load i8*, i8** %l2
  br i1 %t44, label %then10, label %else11
then10:
  %t48 = load double, double* %l1
  %t49 = sitofp i64 1 to double
  %t50 = fadd double %t48, %t49
  store double %t50, double* %l1
  %t51 = load double, double* %l1
  br label %merge12
else11:
  %t52 = load i8*, i8** %l2
  %t53 = load i8, i8* %t52
  %t54 = icmp eq i8 %t53, 41
  %t55 = load double, double* %l0
  %t56 = load double, double* %l1
  %t57 = load i8*, i8** %l2
  br i1 %t54, label %then13, label %else14
then13:
  %t58 = load double, double* %l1
  %t59 = sitofp i64 1 to double
  %t60 = fsub double %t58, %t59
  store double %t60, double* %l1
  %t61 = load double, double* %l1
  %t62 = sitofp i64 0 to double
  %t63 = fcmp oeq double %t61, %t62
  %t64 = load double, double* %l0
  %t65 = load double, double* %l1
  %t66 = load i8*, i8** %l2
  br i1 %t63, label %then16, label %merge17
then16:
  %t67 = sitofp i64 1 to double
  %t68 = fadd double %open_index, %t67
  %t69 = load double, double* %l0
  %t70 = call double @llvm.round.f64(double %t68)
  %t71 = fptosi double %t70 to i64
  %t72 = call double @llvm.round.f64(double %t69)
  %t73 = fptosi double %t72 to i64
  %t74 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t71, i64 %t73)
  store i8* %t74, i8** %l3
  %t75 = load i8*, i8** %l3
  %t76 = insertvalue %ExtractedSpan undef, i8* %t75, 0
  %t77 = sitofp i64 1 to double
  %t78 = fadd double %open_index, %t77
  %t79 = insertvalue %ExtractedSpan %t76, double %t78, 1
  %t80 = load double, double* %l0
  %t81 = sitofp i64 1 to double
  %t82 = fadd double %t80, %t81
  %t83 = insertvalue %ExtractedSpan %t79, double %t82, 2
  %t84 = insertvalue %ExtractedSpan %t83, i1 1, 3
  ret %ExtractedSpan %t84
merge17:
  %t85 = load double, double* %l1
  br label %merge15
else14:
  %t87 = load i8*, i8** %l2
  %t88 = load i8, i8* %t87
  %t89 = icmp eq i8 %t88, 34
  br label %logical_or_entry_86

logical_or_entry_86:
  br i1 %t89, label %logical_or_merge_86, label %logical_or_right_86

logical_or_right_86:
  %t90 = load i8*, i8** %l2
  %t91 = load i8, i8* %t90
  %t92 = icmp eq i8 %t91, 39
  br label %logical_or_right_end_86

logical_or_right_end_86:
  br label %logical_or_merge_86

logical_or_merge_86:
  %t93 = phi i1 [ true, %logical_or_entry_86 ], [ %t92, %logical_or_right_end_86 ]
  %t94 = load double, double* %l0
  %t95 = load double, double* %l1
  %t96 = load i8*, i8** %l2
  br i1 %t93, label %then18, label %merge19
then18:
  %t97 = load double, double* %l0
  %t98 = call double @skip_string_literal(i8* %text, double %t97)
  store double %t98, double* %l0
  br label %loop.latch6
merge19:
  %t99 = load double, double* %l0
  br label %merge15
merge15:
  %t100 = phi double [ %t85, %merge17 ], [ %t56, %merge19 ]
  %t101 = phi double [ %t55, %merge17 ], [ %t99, %merge19 ]
  store double %t100, double* %l1
  store double %t101, double* %l0
  %t102 = load double, double* %l1
  %t103 = load double, double* %l0
  br label %merge12
merge12:
  %t104 = phi double [ %t51, %then10 ], [ %t102, %merge15 ]
  %t105 = phi double [ %t45, %then10 ], [ %t103, %merge15 ]
  store double %t104, double* %l1
  store double %t105, double* %l0
  %t106 = load double, double* %l0
  %t107 = sitofp i64 1 to double
  %t108 = fadd double %t106, %t107
  store double %t108, double* %l0
  br label %loop.latch6
loop.latch6:
  %t109 = load double, double* %l1
  %t110 = load double, double* %l0
  br label %loop.header4
afterloop7:
  %t113 = load double, double* %l1
  %t114 = load double, double* %l0
  %s115 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t116 = insertvalue %ExtractedSpan undef, i8* %s115, 0
  %t117 = insertvalue %ExtractedSpan %t116, double %open_index, 1
  %t118 = insertvalue %ExtractedSpan %t117, double %open_index, 2
  %t119 = insertvalue %ExtractedSpan %t118, i1 0, 3
  ret %ExtractedSpan %t119
}

define double @skip_string_literal(i8* %text, double %quote_index) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8*
  %t0 = sitofp i64 1 to double
  %t1 = fadd double %quote_index, %t0
  %t2 = call double @llvm.round.f64(double %quote_index)
  %t3 = fptosi double %t2 to i64
  %t4 = call double @llvm.round.f64(double %t1)
  %t5 = fptosi double %t4 to i64
  %t6 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t3, i64 %t5)
  store i8* %t6, i8** %l0
  %t7 = sitofp i64 1 to double
  %t8 = fadd double %quote_index, %t7
  store double %t8, double* %l1
  %t9 = load i8*, i8** %l0
  %t10 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t48 = phi double [ %t10, %block.entry ], [ %t47, %loop.latch2 ]
  store double %t48, double* %l1
  br label %loop.body1
loop.body1:
  %t11 = load double, double* %l1
  %t12 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t13 = sitofp i64 %t12 to double
  %t14 = fcmp oge double %t11, %t13
  %t15 = load i8*, i8** %l0
  %t16 = load double, double* %l1
  br i1 %t14, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t17 = load double, double* %l1
  %t18 = load double, double* %l1
  %t19 = sitofp i64 1 to double
  %t20 = fadd double %t18, %t19
  %t21 = call double @llvm.round.f64(double %t17)
  %t22 = fptosi double %t21 to i64
  %t23 = call double @llvm.round.f64(double %t20)
  %t24 = fptosi double %t23 to i64
  %t25 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t22, i64 %t24)
  store i8* %t25, i8** %l2
  %t26 = load i8*, i8** %l2
  %t27 = load i8, i8* %t26
  %t28 = icmp eq i8 %t27, 92
  %t29 = load i8*, i8** %l0
  %t30 = load double, double* %l1
  %t31 = load i8*, i8** %l2
  br i1 %t28, label %then6, label %merge7
then6:
  %t32 = load double, double* %l1
  %t33 = sitofp i64 2 to double
  %t34 = fadd double %t32, %t33
  store double %t34, double* %l1
  br label %loop.latch2
merge7:
  %t35 = load i8*, i8** %l2
  %t36 = load i8*, i8** %l0
  %t37 = call i1 @strings_equal(i8* %t35, i8* %t36)
  %t38 = load i8*, i8** %l0
  %t39 = load double, double* %l1
  %t40 = load i8*, i8** %l2
  br i1 %t37, label %then8, label %merge9
then8:
  %t41 = load double, double* %l1
  %t42 = sitofp i64 1 to double
  %t43 = fadd double %t41, %t42
  store double %t43, double* %l1
  br label %afterloop3
merge9:
  %t44 = load double, double* %l1
  %t45 = sitofp i64 1 to double
  %t46 = fadd double %t44, %t45
  store double %t46, double* %l1
  br label %loop.latch2
loop.latch2:
  %t47 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t49 = load double, double* %l1
  %t50 = load double, double* %l1
  ret double %t50
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
  %t299 = phi double [ %t36, %logical_or_merge_18 ], [ %t292, %loop.latch4 ]
  %t300 = phi double [ %t37, %logical_or_merge_18 ], [ %t293, %loop.latch4 ]
  %t301 = phi i1 [ %t38, %logical_or_merge_18 ], [ %t294, %loop.latch4 ]
  %t302 = phi i8* [ %t35, %logical_or_merge_18 ], [ %t295, %loop.latch4 ]
  %t303 = phi double [ %t32, %logical_or_merge_18 ], [ %t296, %loop.latch4 ]
  %t304 = phi double [ %t33, %logical_or_merge_18 ], [ %t297, %loop.latch4 ]
  %t305 = phi double [ %t34, %logical_or_merge_18 ], [ %t298, %loop.latch4 ]
  store double %t299, double* %l5
  store double %t300, double* %l6
  store i1 %t301, i1* %l7
  store i8* %t302, i8** %l4
  store double %t303, double* %l1
  store double %t304, double* %l2
  store double %t305, double* %l3
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
  %t53 = call double @llvm.round.f64(double %t52)
  %t54 = fptosi double %t53 to i64
  %t55 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %instructions
  %t56 = extractvalue { %NativeInstruction*, i64 } %t55, 0
  %t57 = extractvalue { %NativeInstruction*, i64 } %t55, 1
  %t58 = icmp uge i64 %t54, %t57
  ; bounds check: %t58 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t54, i64 %t57)
  %t59 = getelementptr %NativeInstruction, %NativeInstruction* %t56, i64 %t54
  %t60 = load %NativeInstruction, %NativeInstruction* %t59
  %t61 = call i8* @continuation_segment_text(%NativeInstruction %t60)
  store i8* %t61, i8** %l8
  %t62 = load i8*, i8** %l8
  %t63 = icmp eq i8* %t62, null
  %t64 = load i8*, i8** %l0
  %t65 = load double, double* %l1
  %t66 = load double, double* %l2
  %t67 = load double, double* %l3
  %t68 = load i8*, i8** %l4
  %t69 = load double, double* %l5
  %t70 = load double, double* %l6
  %t71 = load i1, i1* %l7
  %t72 = load i8*, i8** %l8
  br i1 %t63, label %then8, label %merge9
then8:
  br label %afterloop5
merge9:
  %t73 = load i8*, i8** %l8
  %t74 = call i8* @trim_text(i8* %t73)
  store i8* %t74, i8** %l9
  %t75 = load i8*, i8** %l9
  %t76 = call i64 @sailfin_runtime_string_length(i8* %t75)
  %t77 = icmp eq i64 %t76, 0
  %t78 = load i8*, i8** %l0
  %t79 = load double, double* %l1
  %t80 = load double, double* %l2
  %t81 = load double, double* %l3
  %t82 = load i8*, i8** %l4
  %t83 = load double, double* %l5
  %t84 = load double, double* %l6
  %t85 = load i1, i1* %l7
  %t86 = load i8*, i8** %l8
  %t87 = load i8*, i8** %l9
  br i1 %t77, label %then10, label %merge11
then10:
  %t88 = load double, double* %l5
  %t89 = sitofp i64 1 to double
  %t90 = fadd double %t88, %t89
  store double %t90, double* %l5
  %t91 = load double, double* %l6
  %t92 = sitofp i64 1 to double
  %t93 = fadd double %t91, %t92
  store double %t93, double* %l6
  br label %loop.latch4
merge11:
  %t94 = load i1, i1* %l7
  %t95 = xor i1 %t94, 1
  %t96 = load i8*, i8** %l0
  %t97 = load double, double* %l1
  %t98 = load double, double* %l2
  %t99 = load double, double* %l3
  %t100 = load i8*, i8** %l4
  %t101 = load double, double* %l5
  %t102 = load double, double* %l6
  %t103 = load i1, i1* %l7
  %t104 = load i8*, i8** %l8
  %t105 = load i8*, i8** %l9
  br i1 %t95, label %then12, label %merge13
then12:
  %t106 = load i8*, i8** %l9
  %t107 = call i1 @segment_signals_expression_continuation(i8* %t106)
  %t108 = xor i1 %t107, 1
  %t109 = load i8*, i8** %l0
  %t110 = load double, double* %l1
  %t111 = load double, double* %l2
  %t112 = load double, double* %l3
  %t113 = load i8*, i8** %l4
  %t114 = load double, double* %l5
  %t115 = load double, double* %l6
  %t116 = load i1, i1* %l7
  %t117 = load i8*, i8** %l8
  %t118 = load i8*, i8** %l9
  br i1 %t108, label %then14, label %merge15
then14:
  br label %afterloop5
merge15:
  store i1 1, i1* %l7
  %t119 = load i1, i1* %l7
  br label %merge13
merge13:
  %t120 = phi i1 [ %t119, %merge15 ], [ %t103, %merge11 ]
  store i1 %t120, i1* %l7
  %t121 = load i8*, i8** %l4
  %t122 = alloca [2 x i8], align 1
  %t123 = getelementptr [2 x i8], [2 x i8]* %t122, i32 0, i32 0
  store i8 32, i8* %t123
  %t124 = getelementptr [2 x i8], [2 x i8]* %t122, i32 0, i32 1
  store i8 0, i8* %t124
  %t125 = getelementptr [2 x i8], [2 x i8]* %t122, i32 0, i32 0
  %t126 = call i8* @sailfin_runtime_string_concat(i8* %t121, i8* %t125)
  %t127 = load i8*, i8** %l9
  %t128 = call i8* @sailfin_runtime_string_concat(i8* %t126, i8* %t127)
  store i8* %t128, i8** %l4
  %t129 = load double, double* %l1
  %t130 = load i8*, i8** %l9
  %t131 = call double @compute_parenthesis_balance(i8* %t130)
  %t132 = fadd double %t129, %t131
  store double %t132, double* %l1
  %t133 = load double, double* %l2
  %t134 = load i8*, i8** %l9
  %t135 = call double @compute_brace_balance(i8* %t134)
  %t136 = fadd double %t133, %t135
  store double %t136, double* %l2
  %t137 = load double, double* %l3
  %t138 = load i8*, i8** %l9
  %t139 = call double @compute_bracket_balance(i8* %t138)
  %t140 = fadd double %t137, %t139
  store double %t140, double* %l3
  %t141 = load double, double* %l6
  %t142 = sitofp i64 1 to double
  %t143 = fadd double %t141, %t142
  store double %t143, double* %l6
  %t144 = load double, double* %l5
  %t145 = sitofp i64 1 to double
  %t146 = fadd double %t144, %t145
  store double %t146, double* %l5
  %t148 = load double, double* %l1
  %t149 = sitofp i64 0 to double
  %t150 = fcmp ole double %t148, %t149
  br label %logical_and_entry_147

logical_and_entry_147:
  br i1 %t150, label %logical_and_right_147, label %logical_and_merge_147

logical_and_right_147:
  %t152 = load double, double* %l2
  %t153 = sitofp i64 0 to double
  %t154 = fcmp ole double %t152, %t153
  br label %logical_and_entry_151

logical_and_entry_151:
  br i1 %t154, label %logical_and_right_151, label %logical_and_merge_151

logical_and_right_151:
  %t155 = load double, double* %l3
  %t156 = sitofp i64 0 to double
  %t157 = fcmp ole double %t155, %t156
  br label %logical_and_right_end_151

logical_and_right_end_151:
  br label %logical_and_merge_151

logical_and_merge_151:
  %t158 = phi i1 [ false, %logical_and_entry_151 ], [ %t157, %logical_and_right_end_151 ]
  br label %logical_and_right_end_147

logical_and_right_end_147:
  br label %logical_and_merge_147

logical_and_merge_147:
  %t159 = phi i1 [ false, %logical_and_entry_147 ], [ %t158, %logical_and_right_end_147 ]
  %t160 = load i8*, i8** %l0
  %t161 = load double, double* %l1
  %t162 = load double, double* %l2
  %t163 = load double, double* %l3
  %t164 = load i8*, i8** %l4
  %t165 = load double, double* %l5
  %t166 = load double, double* %l6
  %t167 = load i1, i1* %l7
  %t168 = load i8*, i8** %l8
  %t169 = load i8*, i8** %l9
  br i1 %t159, label %then16, label %merge17
then16:
  store i1 1, i1* %l10
  %t170 = load double, double* %l5
  store double %t170, double* %l11
  %t171 = load i8*, i8** %l0
  %t172 = load double, double* %l1
  %t173 = load double, double* %l2
  %t174 = load double, double* %l3
  %t175 = load i8*, i8** %l4
  %t176 = load double, double* %l5
  %t177 = load double, double* %l6
  %t178 = load i1, i1* %l7
  %t179 = load i8*, i8** %l8
  %t180 = load i8*, i8** %l9
  %t181 = load i1, i1* %l10
  %t182 = load double, double* %l11
  br label %loop.header18
loop.header18:
  %t267 = phi double [ %t182, %then16 ], [ %t265, %loop.latch20 ]
  %t268 = phi i1 [ %t181, %then16 ], [ %t266, %loop.latch20 ]
  store double %t267, double* %l11
  store i1 %t268, i1* %l10
  br label %loop.body19
loop.body19:
  %t183 = load double, double* %l11
  %t184 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %instructions
  %t185 = extractvalue { %NativeInstruction*, i64 } %t184, 1
  %t186 = sitofp i64 %t185 to double
  %t187 = fcmp oge double %t183, %t186
  %t188 = load i8*, i8** %l0
  %t189 = load double, double* %l1
  %t190 = load double, double* %l2
  %t191 = load double, double* %l3
  %t192 = load i8*, i8** %l4
  %t193 = load double, double* %l5
  %t194 = load double, double* %l6
  %t195 = load i1, i1* %l7
  %t196 = load i8*, i8** %l8
  %t197 = load i8*, i8** %l9
  %t198 = load i1, i1* %l10
  %t199 = load double, double* %l11
  br i1 %t187, label %then22, label %merge23
then22:
  br label %afterloop21
merge23:
  %t200 = load double, double* %l11
  %t201 = call double @llvm.round.f64(double %t200)
  %t202 = fptosi double %t201 to i64
  %t203 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %instructions
  %t204 = extractvalue { %NativeInstruction*, i64 } %t203, 0
  %t205 = extractvalue { %NativeInstruction*, i64 } %t203, 1
  %t206 = icmp uge i64 %t202, %t205
  ; bounds check: %t206 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t202, i64 %t205)
  %t207 = getelementptr %NativeInstruction, %NativeInstruction* %t204, i64 %t202
  %t208 = load %NativeInstruction, %NativeInstruction* %t207
  %t209 = call i8* @continuation_segment_text(%NativeInstruction %t208)
  store i8* %t209, i8** %l12
  %t210 = load i8*, i8** %l12
  %t211 = icmp eq i8* %t210, null
  %t212 = load i8*, i8** %l0
  %t213 = load double, double* %l1
  %t214 = load double, double* %l2
  %t215 = load double, double* %l3
  %t216 = load i8*, i8** %l4
  %t217 = load double, double* %l5
  %t218 = load double, double* %l6
  %t219 = load i1, i1* %l7
  %t220 = load i8*, i8** %l8
  %t221 = load i8*, i8** %l9
  %t222 = load i1, i1* %l10
  %t223 = load double, double* %l11
  %t224 = load i8*, i8** %l12
  br i1 %t211, label %then24, label %merge25
then24:
  br label %afterloop21
merge25:
  %t225 = load i8*, i8** %l12
  %t226 = call i8* @trim_text(i8* %t225)
  store i8* %t226, i8** %l13
  %t227 = load i8*, i8** %l13
  %t228 = call i64 @sailfin_runtime_string_length(i8* %t227)
  %t229 = icmp eq i64 %t228, 0
  %t230 = load i8*, i8** %l0
  %t231 = load double, double* %l1
  %t232 = load double, double* %l2
  %t233 = load double, double* %l3
  %t234 = load i8*, i8** %l4
  %t235 = load double, double* %l5
  %t236 = load double, double* %l6
  %t237 = load i1, i1* %l7
  %t238 = load i8*, i8** %l8
  %t239 = load i8*, i8** %l9
  %t240 = load i1, i1* %l10
  %t241 = load double, double* %l11
  %t242 = load i8*, i8** %l12
  %t243 = load i8*, i8** %l13
  br i1 %t229, label %then26, label %merge27
then26:
  %t244 = load double, double* %l11
  %t245 = sitofp i64 1 to double
  %t246 = fadd double %t244, %t245
  store double %t246, double* %l11
  br label %loop.latch20
merge27:
  %t247 = load i8*, i8** %l13
  %t248 = call i1 @segment_signals_expression_continuation(i8* %t247)
  %t249 = load i8*, i8** %l0
  %t250 = load double, double* %l1
  %t251 = load double, double* %l2
  %t252 = load double, double* %l3
  %t253 = load i8*, i8** %l4
  %t254 = load double, double* %l5
  %t255 = load double, double* %l6
  %t256 = load i1, i1* %l7
  %t257 = load i8*, i8** %l8
  %t258 = load i8*, i8** %l9
  %t259 = load i1, i1* %l10
  %t260 = load double, double* %l11
  %t261 = load i8*, i8** %l12
  %t262 = load i8*, i8** %l13
  br i1 %t248, label %then28, label %merge29
then28:
  store i1 0, i1* %l10
  %t263 = load i1, i1* %l10
  br label %merge29
merge29:
  %t264 = phi i1 [ %t263, %then28 ], [ %t259, %merge27 ]
  store i1 %t264, i1* %l10
  br label %afterloop21
loop.latch20:
  %t265 = load double, double* %l11
  %t266 = load i1, i1* %l10
  br label %loop.header18
afterloop21:
  %t269 = load double, double* %l11
  %t270 = load i1, i1* %l10
  %t271 = load i1, i1* %l10
  %t272 = load i8*, i8** %l0
  %t273 = load double, double* %l1
  %t274 = load double, double* %l2
  %t275 = load double, double* %l3
  %t276 = load i8*, i8** %l4
  %t277 = load double, double* %l5
  %t278 = load double, double* %l6
  %t279 = load i1, i1* %l7
  %t280 = load i8*, i8** %l8
  %t281 = load i8*, i8** %l9
  %t282 = load i1, i1* %l10
  %t283 = load double, double* %l11
  br i1 %t271, label %then30, label %merge31
then30:
  %t284 = load i8*, i8** %l4
  %t285 = call i8* @trim_text(i8* %t284)
  %t286 = call i8* @trim_trailing_delimiters(i8* %t285)
  store i8* %t286, i8** %l14
  %t287 = load i8*, i8** %l14
  %t288 = insertvalue %ExpressionContinuationCapture undef, i8* %t287, 0
  %t289 = load double, double* %l6
  %t290 = insertvalue %ExpressionContinuationCapture %t288, double %t289, 1
  %t291 = insertvalue %ExpressionContinuationCapture %t290, i1 1, 2
  ret %ExpressionContinuationCapture %t291
merge31:
  br label %merge17
merge17:
  br label %loop.latch4
loop.latch4:
  %t292 = load double, double* %l5
  %t293 = load double, double* %l6
  %t294 = load i1, i1* %l7
  %t295 = load i8*, i8** %l4
  %t296 = load double, double* %l1
  %t297 = load double, double* %l2
  %t298 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t306 = load double, double* %l5
  %t307 = load double, double* %l6
  %t308 = load i1, i1* %l7
  %t309 = load i8*, i8** %l4
  %t310 = load double, double* %l1
  %t311 = load double, double* %l2
  %t312 = load double, double* %l3
  %t314 = load i1, i1* %l7
  br label %logical_or_entry_313

logical_or_entry_313:
  br i1 %t314, label %logical_or_merge_313, label %logical_or_right_313

logical_or_right_313:
  %t315 = load double, double* %l6
  %t316 = sitofp i64 0 to double
  %t317 = fcmp oeq double %t315, %t316
  br label %logical_or_right_end_313

logical_or_right_end_313:
  br label %logical_or_merge_313

logical_or_merge_313:
  %t318 = phi i1 [ true, %logical_or_entry_313 ], [ %t317, %logical_or_right_end_313 ]
  %t319 = xor i1 %t318, 1
  %t320 = load i8*, i8** %l0
  %t321 = load double, double* %l1
  %t322 = load double, double* %l2
  %t323 = load double, double* %l3
  %t324 = load i8*, i8** %l4
  %t325 = load double, double* %l5
  %t326 = load double, double* %l6
  %t327 = load i1, i1* %l7
  br i1 %t319, label %then32, label %merge33
then32:
  %t328 = load i8*, i8** %l0
  %t329 = insertvalue %ExpressionContinuationCapture undef, i8* %t328, 0
  %t330 = sitofp i64 0 to double
  %t331 = insertvalue %ExpressionContinuationCapture %t329, double %t330, 1
  %t332 = insertvalue %ExpressionContinuationCapture %t331, i1 0, 2
  ret %ExpressionContinuationCapture %t332
merge33:
  %t334 = load double, double* %l1
  %t335 = sitofp i64 0 to double
  %t336 = fcmp ole double %t334, %t335
  br label %logical_and_entry_333

logical_and_entry_333:
  br i1 %t336, label %logical_and_right_333, label %logical_and_merge_333

logical_and_right_333:
  %t338 = load double, double* %l2
  %t339 = sitofp i64 0 to double
  %t340 = fcmp ole double %t338, %t339
  br label %logical_and_entry_337

logical_and_entry_337:
  br i1 %t340, label %logical_and_right_337, label %logical_and_merge_337

logical_and_right_337:
  %t341 = load double, double* %l3
  %t342 = sitofp i64 0 to double
  %t343 = fcmp ole double %t341, %t342
  br label %logical_and_right_end_337

logical_and_right_end_337:
  br label %logical_and_merge_337

logical_and_merge_337:
  %t344 = phi i1 [ false, %logical_and_entry_337 ], [ %t343, %logical_and_right_end_337 ]
  br label %logical_and_right_end_333

logical_and_right_end_333:
  br label %logical_and_merge_333

logical_and_merge_333:
  %t345 = phi i1 [ false, %logical_and_entry_333 ], [ %t344, %logical_and_right_end_333 ]
  %t346 = load i8*, i8** %l0
  %t347 = load double, double* %l1
  %t348 = load double, double* %l2
  %t349 = load double, double* %l3
  %t350 = load i8*, i8** %l4
  %t351 = load double, double* %l5
  %t352 = load double, double* %l6
  %t353 = load i1, i1* %l7
  br i1 %t345, label %then34, label %merge35
then34:
  %t354 = load i8*, i8** %l4
  %t355 = call i8* @trim_text(i8* %t354)
  %t356 = call i8* @trim_trailing_delimiters(i8* %t355)
  store i8* %t356, i8** %l15
  %t357 = load i8*, i8** %l15
  %t358 = insertvalue %ExpressionContinuationCapture undef, i8* %t357, 0
  %t359 = load double, double* %l6
  %t360 = insertvalue %ExpressionContinuationCapture %t358, double %t359, 1
  %t361 = insertvalue %ExpressionContinuationCapture %t360, i1 1, 2
  ret %ExpressionContinuationCapture %t361
merge35:
  %t362 = load i8*, i8** %l0
  %t363 = insertvalue %ExpressionContinuationCapture undef, i8* %t362, 0
  %t364 = sitofp i64 0 to double
  %t365 = insertvalue %ExpressionContinuationCapture %t363, double %t364, 1
  %t366 = insertvalue %ExpressionContinuationCapture %t365, i1 0, 2
  ret %ExpressionContinuationCapture %t366
}

; NOTE: Returns string via output parameter %out_result
define void @continuation_segment_text(%NativeInstruction %instruction, i8** %out_result) {
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
  %t54 = call i1 @strings_equal(i8* %t52, i8* %s53)
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
  store i8* %t62, i8** %out_result
  ret void
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
  %t117 = call i1 @strings_equal(i8* %t115, i8* %s116)
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
  store i8* %t137, i8** %out_result
  ret void
merge3:
  store i8* null, i8** %out_result
  ret void
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
  %t16 = call i1 @strings_equal(i8* %t15, i8* %open)
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
  %t25 = call i1 @strings_equal(i8* %t24, i8* %close)
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
  %t79 = call i1 @strings_equal(i8* %t77, i8* %t78)
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
  %t79 = call i1 @strings_equal(i8* %t77, i8* %t78)
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

; NOTE: Returns string via output parameter %out_result
define void @trim_trailing_delimiters(i8* %text, i8** %out_result) {
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
  store i8* %text, i8** %out_result
  ret void
merge9:
  %t32 = load double, double* %l0
  %t33 = call double @llvm.round.f64(double %t32)
  %t34 = fptosi double %t33 to i64
  %t35 = call i8* @sailfin_runtime_substring(i8* %text, i64 0, i64 %t34)
  store i8* %t35, i8** %out_result
  ret void
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
  %t57 = phi double [ %t4, %merge1 ], [ %t56, %loop.latch4 ]
  store double %t57, double* %l0
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
  %t44 = phi i1 [ %t16, %merge7 ], [ %t42, %loop.latch10 ]
  %t45 = phi double [ %t15, %merge7 ], [ %t43, %loop.latch10 ]
  store i1 %t44, i1* %l2
  store double %t45, double* %l1
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
  %t32 = call i1 @strings_equal(i8* %t30, i8* %t31)
  %t33 = xor i1 %t32, true
  %t34 = load double, double* %l0
  %t35 = load double, double* %l1
  %t36 = load i1, i1* %l2
  %t37 = load i8*, i8** %l3
  %t38 = load i8*, i8** %l4
  br i1 %t33, label %then14, label %merge15
then14:
  store i1 0, i1* %l2
  br label %afterloop11
merge15:
  %t39 = load double, double* %l1
  %t40 = sitofp i64 1 to double
  %t41 = fadd double %t39, %t40
  store double %t41, double* %l1
  br label %loop.latch10
loop.latch10:
  %t42 = load i1, i1* %l2
  %t43 = load double, double* %l1
  br label %loop.header8
afterloop11:
  %t46 = load i1, i1* %l2
  %t47 = load double, double* %l1
  %t48 = load i1, i1* %l2
  %t49 = load double, double* %l0
  %t50 = load double, double* %l1
  %t51 = load i1, i1* %l2
  br i1 %t48, label %then16, label %merge17
then16:
  %t52 = load double, double* %l0
  ret double %t52
merge17:
  %t53 = load double, double* %l0
  %t54 = sitofp i64 1 to double
  %t55 = fadd double %t53, %t54
  store double %t55, double* %l0
  br label %loop.latch4
loop.latch4:
  %t56 = load double, double* %l0
  br label %loop.header2
afterloop5:
  %t58 = load double, double* %l0
  %t59 = sitofp i64 -1 to double
  ret double %t59
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
  %t135 = phi i1 [ %t3, %block.entry ], [ %t131, %loop.latch2 ]
  %t136 = phi double [ %t2, %block.entry ], [ %t132, %loop.latch2 ]
  %t137 = phi i1 [ %t4, %block.entry ], [ %t133, %loop.latch2 ]
  %t138 = phi double [ %t1, %block.entry ], [ %t134, %loop.latch2 ]
  store i1 %t135, i1* %l2
  store double %t136, double* %l1
  store i1 %t137, i1* %l3
  store double %t138, double* %l0
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
  %t14 = call double @llvm.round.f64(double %t13)
  %t15 = fptosi double %t14 to i64
  %t16 = getelementptr i8, i8* %text, i64 %t15
  %t17 = load i8, i8* %t16
  store i8 %t17, i8* %l4
  %t18 = load i8, i8* %l4
  %t19 = icmp eq i8 %t18, 39
  %t20 = load double, double* %l0
  %t21 = load double, double* %l1
  %t22 = load i1, i1* %l2
  %t23 = load i1, i1* %l3
  %t24 = load i8, i8* %l4
  br i1 %t19, label %then6, label %merge7
then6:
  %t26 = load i1, i1* %l3
  br label %logical_and_entry_25

logical_and_entry_25:
  br i1 %t26, label %logical_and_right_25, label %logical_and_merge_25

logical_and_right_25:
  %t27 = load double, double* %l1
  %t28 = call i1 @is_escaped_quote(i8* %text, double %t27)
  %t29 = xor i1 %t28, 1
  br label %logical_and_right_end_25

logical_and_right_end_25:
  br label %logical_and_merge_25

logical_and_merge_25:
  %t30 = phi i1 [ false, %logical_and_entry_25 ], [ %t29, %logical_and_right_end_25 ]
  %t31 = xor i1 %t30, 1
  %t32 = load double, double* %l0
  %t33 = load double, double* %l1
  %t34 = load i1, i1* %l2
  %t35 = load i1, i1* %l3
  %t36 = load i8, i8* %l4
  br i1 %t31, label %then8, label %merge9
then8:
  %t37 = load i1, i1* %l2
  %t38 = xor i1 %t37, 1
  store i1 %t38, i1* %l2
  %t39 = load i1, i1* %l2
  br label %merge9
merge9:
  %t40 = phi i1 [ %t39, %then8 ], [ %t34, %logical_and_merge_25 ]
  store i1 %t40, i1* %l2
  %t41 = load double, double* %l1
  %t42 = sitofp i64 1 to double
  %t43 = fadd double %t41, %t42
  store double %t43, double* %l1
  br label %loop.latch2
merge7:
  %t44 = load i8, i8* %l4
  %t45 = icmp eq i8 %t44, 34
  %t46 = load double, double* %l0
  %t47 = load double, double* %l1
  %t48 = load i1, i1* %l2
  %t49 = load i1, i1* %l3
  %t50 = load i8, i8* %l4
  br i1 %t45, label %then10, label %merge11
then10:
  %t52 = load i1, i1* %l2
  br label %logical_and_entry_51

logical_and_entry_51:
  br i1 %t52, label %logical_and_right_51, label %logical_and_merge_51

logical_and_right_51:
  %t53 = load double, double* %l1
  %t54 = call i1 @is_escaped_quote(i8* %text, double %t53)
  %t55 = xor i1 %t54, 1
  br label %logical_and_right_end_51

logical_and_right_end_51:
  br label %logical_and_merge_51

logical_and_merge_51:
  %t56 = phi i1 [ false, %logical_and_entry_51 ], [ %t55, %logical_and_right_end_51 ]
  %t57 = xor i1 %t56, 1
  %t58 = load double, double* %l0
  %t59 = load double, double* %l1
  %t60 = load i1, i1* %l2
  %t61 = load i1, i1* %l3
  %t62 = load i8, i8* %l4
  br i1 %t57, label %then12, label %merge13
then12:
  %t63 = load i1, i1* %l3
  %t64 = xor i1 %t63, 1
  store i1 %t64, i1* %l3
  %t65 = load i1, i1* %l3
  br label %merge13
merge13:
  %t66 = phi i1 [ %t65, %then12 ], [ %t61, %logical_and_merge_51 ]
  store i1 %t66, i1* %l3
  %t67 = load double, double* %l1
  %t68 = sitofp i64 1 to double
  %t69 = fadd double %t67, %t68
  store double %t69, double* %l1
  br label %loop.latch2
merge11:
  %t71 = load i1, i1* %l2
  br label %logical_and_entry_70

logical_and_entry_70:
  br i1 %t71, label %logical_and_right_70, label %logical_and_merge_70

logical_and_right_70:
  %t72 = load i1, i1* %l3
  %t73 = xor i1 %t72, 1
  br label %logical_and_right_end_70

logical_and_right_end_70:
  br label %logical_and_merge_70

logical_and_merge_70:
  %t74 = phi i1 [ false, %logical_and_entry_70 ], [ %t73, %logical_and_right_end_70 ]
  %t75 = xor i1 %t74, 1
  %t76 = load double, double* %l0
  %t77 = load double, double* %l1
  %t78 = load i1, i1* %l2
  %t79 = load i1, i1* %l3
  %t80 = load i8, i8* %l4
  br i1 %t75, label %then14, label %merge15
then14:
  %t81 = load i8, i8* %l4
  %t82 = icmp eq i8 %t81, 91
  %t83 = load double, double* %l0
  %t84 = load double, double* %l1
  %t85 = load i1, i1* %l2
  %t86 = load i1, i1* %l3
  %t87 = load i8, i8* %l4
  br i1 %t82, label %then16, label %else17
then16:
  %t88 = load double, double* %l0
  %t89 = sitofp i64 1 to double
  %t90 = fadd double %t88, %t89
  store double %t90, double* %l0
  %t91 = load double, double* %l0
  br label %merge18
else17:
  %t92 = load i8, i8* %l4
  %t93 = icmp eq i8 %t92, 93
  %t94 = load double, double* %l0
  %t95 = load double, double* %l1
  %t96 = load i1, i1* %l2
  %t97 = load i1, i1* %l3
  %t98 = load i8, i8* %l4
  br i1 %t93, label %then19, label %merge20
then19:
  %t99 = load double, double* %l0
  %t100 = sitofp i64 0 to double
  %t101 = fcmp ole double %t99, %t100
  %t102 = load double, double* %l0
  %t103 = load double, double* %l1
  %t104 = load i1, i1* %l2
  %t105 = load i1, i1* %l3
  %t106 = load i8, i8* %l4
  br i1 %t101, label %then21, label %merge22
then21:
  %t107 = sitofp i64 -1 to double
  ret double %t107
merge22:
  %t108 = load double, double* %l0
  %t109 = sitofp i64 1 to double
  %t110 = fsub double %t108, %t109
  store double %t110, double* %l0
  %t111 = load double, double* %l0
  %t112 = sitofp i64 0 to double
  %t113 = fcmp oeq double %t111, %t112
  %t114 = load double, double* %l0
  %t115 = load double, double* %l1
  %t116 = load i1, i1* %l2
  %t117 = load i1, i1* %l3
  %t118 = load i8, i8* %l4
  br i1 %t113, label %then23, label %merge24
then23:
  %t119 = load double, double* %l1
  ret double %t119
merge24:
  %t120 = load double, double* %l0
  br label %merge20
merge20:
  %t121 = phi double [ %t120, %merge24 ], [ %t94, %else17 ]
  store double %t121, double* %l0
  %t122 = load double, double* %l0
  br label %merge18
merge18:
  %t123 = phi double [ %t91, %then16 ], [ %t122, %merge20 ]
  store double %t123, double* %l0
  %t124 = load double, double* %l0
  %t125 = load double, double* %l0
  br label %merge15
merge15:
  %t126 = phi double [ %t124, %merge18 ], [ %t76, %logical_and_merge_70 ]
  %t127 = phi double [ %t125, %merge18 ], [ %t76, %logical_and_merge_70 ]
  store double %t126, double* %l0
  store double %t127, double* %l0
  %t128 = load double, double* %l1
  %t129 = sitofp i64 1 to double
  %t130 = fadd double %t128, %t129
  store double %t130, double* %l1
  br label %loop.latch2
loop.latch2:
  %t131 = load i1, i1* %l2
  %t132 = load double, double* %l1
  %t133 = load i1, i1* %l3
  %t134 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t139 = load i1, i1* %l2
  %t140 = load double, double* %l1
  %t141 = load i1, i1* %l3
  %t142 = load double, double* %l0
  %t143 = sitofp i64 -1 to double
  ret double %t143
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
  %t71 = phi double [ %t17, %merge7 ], [ %t70, %loop.latch10 ]
  store double %t71, double* %l0
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
  %t58 = phi i1 [ %t28, %merge13 ], [ %t56, %loop.latch16 ]
  %t59 = phi double [ %t29, %merge13 ], [ %t57, %loop.latch16 ]
  store i1 %t58, i1* %l1
  store double %t59, double* %l2
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
  %t40 = call double @llvm.round.f64(double %t39)
  %t41 = fptosi double %t40 to i64
  %t42 = getelementptr i8, i8* %value, i64 %t41
  %t43 = load i8, i8* %t42
  %t44 = load double, double* %l2
  %t45 = call double @llvm.round.f64(double %t44)
  %t46 = fptosi double %t45 to i64
  %t47 = getelementptr i8, i8* %pattern, i64 %t46
  %t48 = load i8, i8* %t47
  %t49 = icmp ne i8 %t43, %t48
  %t50 = load double, double* %l0
  %t51 = load i1, i1* %l1
  %t52 = load double, double* %l2
  br i1 %t49, label %then20, label %merge21
then20:
  store i1 0, i1* %l1
  br label %afterloop17
merge21:
  %t53 = load double, double* %l2
  %t54 = sitofp i64 1 to double
  %t55 = fadd double %t53, %t54
  store double %t55, double* %l2
  br label %loop.latch16
loop.latch16:
  %t56 = load i1, i1* %l1
  %t57 = load double, double* %l2
  br label %loop.header14
afterloop17:
  %t60 = load i1, i1* %l1
  %t61 = load double, double* %l2
  %t62 = load i1, i1* %l1
  %t63 = load double, double* %l0
  %t64 = load i1, i1* %l1
  %t65 = load double, double* %l2
  br i1 %t62, label %then22, label %merge23
then22:
  %t66 = load double, double* %l0
  ret double %t66
merge23:
  %t67 = load double, double* %l0
  %t68 = sitofp i64 1 to double
  %t69 = fadd double %t67, %t68
  store double %t69, double* %l0
  br label %loop.latch10
loop.latch10:
  %t70 = load double, double* %l0
  br label %loop.header8
afterloop11:
  %t72 = load double, double* %l0
  %t73 = sitofp i64 -1 to double
  ret double %t73
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
  %t2595 = phi %PythonBuilder [ %t84, %merge3 ], [ %t2589, %loop.latch6 ]
  %t2596 = phi double [ %t91, %merge3 ], [ %t2590, %loop.latch6 ]
  %t2597 = phi double [ %t88, %merge3 ], [ %t2591, %loop.latch6 ]
  %t2598 = phi { i8**, i64 }* [ %t85, %merge3 ], [ %t2592, %loop.latch6 ]
  %t2599 = phi double [ %t90, %merge3 ], [ %t2593, %loop.latch6 ]
  %t2600 = phi { %MatchContext*, i64 }* [ %t89, %merge3 ], [ %t2594, %loop.latch6 ]
  store %PythonBuilder %t2595, %PythonBuilder* %l0
  store double %t2596, double* %l7
  store double %t2597, double* %l4
  store { i8**, i64 }* %t2598, { i8**, i64 }** %l1
  store double %t2599, double* %l6
  store { %MatchContext*, i64 }* %t2600, { %MatchContext*, i64 }** %l5
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
  %t108 = call double @llvm.round.f64(double %t107)
  %t109 = fptosi double %t108 to i64
  %t110 = load { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t106
  %t111 = extractvalue { %NativeInstruction**, i64 } %t110, 0
  %t112 = extractvalue { %NativeInstruction**, i64 } %t110, 1
  %t113 = icmp uge i64 %t109, %t112
  ; bounds check: %t113 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t109, i64 %t112)
  %t114 = getelementptr %NativeInstruction*, %NativeInstruction** %t111, i64 %t109
  %t115 = load %NativeInstruction*, %NativeInstruction** %t114
  store %NativeInstruction* %t115, %NativeInstruction** %l8
  %t116 = load %NativeInstruction*, %NativeInstruction** %l8
  %t117 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t116, i32 0, i32 0
  %t118 = load i32, i32* %t117
  %t119 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t120 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t121 = icmp eq i32 %t118, 0
  %t122 = select i1 %t121, i8* %t120, i8* %t119
  %t123 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t124 = icmp eq i32 %t118, 1
  %t125 = select i1 %t124, i8* %t123, i8* %t122
  %t126 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t127 = icmp eq i32 %t118, 2
  %t128 = select i1 %t127, i8* %t126, i8* %t125
  %t129 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t130 = icmp eq i32 %t118, 3
  %t131 = select i1 %t130, i8* %t129, i8* %t128
  %t132 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t133 = icmp eq i32 %t118, 4
  %t134 = select i1 %t133, i8* %t132, i8* %t131
  %t135 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t136 = icmp eq i32 %t118, 5
  %t137 = select i1 %t136, i8* %t135, i8* %t134
  %t138 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t139 = icmp eq i32 %t118, 6
  %t140 = select i1 %t139, i8* %t138, i8* %t137
  %t141 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t142 = icmp eq i32 %t118, 7
  %t143 = select i1 %t142, i8* %t141, i8* %t140
  %t144 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t145 = icmp eq i32 %t118, 8
  %t146 = select i1 %t145, i8* %t144, i8* %t143
  %t147 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t148 = icmp eq i32 %t118, 9
  %t149 = select i1 %t148, i8* %t147, i8* %t146
  %t150 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t151 = icmp eq i32 %t118, 10
  %t152 = select i1 %t151, i8* %t150, i8* %t149
  %t153 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t154 = icmp eq i32 %t118, 11
  %t155 = select i1 %t154, i8* %t153, i8* %t152
  %t156 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t157 = icmp eq i32 %t118, 12
  %t158 = select i1 %t157, i8* %t156, i8* %t155
  %t159 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t160 = icmp eq i32 %t118, 13
  %t161 = select i1 %t160, i8* %t159, i8* %t158
  %t162 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t163 = icmp eq i32 %t118, 14
  %t164 = select i1 %t163, i8* %t162, i8* %t161
  %t165 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t166 = icmp eq i32 %t118, 15
  %t167 = select i1 %t166, i8* %t165, i8* %t164
  %t168 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t169 = icmp eq i32 %t118, 16
  %t170 = select i1 %t169, i8* %t168, i8* %t167
  %s171 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h536277508, i32 0, i32 0
  %t172 = call i1 @strings_equal(i8* %t170, i8* %s171)
  %t173 = load %PythonBuilder, %PythonBuilder* %l0
  %t174 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t175 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t176 = load i8*, i8** %l3
  %t177 = load double, double* %l4
  %t178 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t179 = load double, double* %l6
  %t180 = load double, double* %l7
  %t181 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t172, label %then10, label %else11
then10:
  %t182 = load %NativeInstruction*, %NativeInstruction** %l8
  %t183 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t182, i32 0, i32 0
  %t184 = load i32, i32* %t183
  %t185 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t182, i32 0, i32 1
  %t186 = bitcast [16 x i8]* %t185 to i8*
  %t187 = bitcast i8* %t186 to i8**
  %t188 = load i8*, i8** %t187
  %t189 = icmp eq i32 %t184, 0
  %t190 = select i1 %t189, i8* %t188, i8* null
  %t191 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t182, i32 0, i32 1
  %t192 = bitcast [16 x i8]* %t191 to i8*
  %t193 = bitcast i8* %t192 to i8**
  %t194 = load i8*, i8** %t193
  %t195 = icmp eq i32 %t184, 1
  %t196 = select i1 %t195, i8* %t194, i8* %t190
  %t197 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t182, i32 0, i32 1
  %t198 = bitcast [8 x i8]* %t197 to i8*
  %t199 = bitcast i8* %t198 to i8**
  %t200 = load i8*, i8** %t199
  %t201 = icmp eq i32 %t184, 12
  %t202 = select i1 %t201, i8* %t200, i8* %t196
  %t203 = call i64 @sailfin_runtime_string_length(i8* %t202)
  %t204 = icmp eq i64 %t203, 0
  %t205 = load %PythonBuilder, %PythonBuilder* %l0
  %t206 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t207 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t208 = load i8*, i8** %l3
  %t209 = load double, double* %l4
  %t210 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t211 = load double, double* %l6
  %t212 = load double, double* %l7
  %t213 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t204, label %then13, label %else14
then13:
  %t214 = load %PythonBuilder, %PythonBuilder* %l0
  %s215 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1061063223, i32 0, i32 0
  %t216 = call %PythonBuilder @builder_emit(%PythonBuilder %t214, i8* %s215)
  store %PythonBuilder %t216, %PythonBuilder* %l0
  %t217 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge15
else14:
  %t218 = load %NativeInstruction*, %NativeInstruction** %l8
  %t219 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t218, i32 0, i32 0
  %t220 = load i32, i32* %t219
  %t221 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t218, i32 0, i32 1
  %t222 = bitcast [16 x i8]* %t221 to i8*
  %t223 = bitcast i8* %t222 to i8**
  %t224 = load i8*, i8** %t223
  %t225 = icmp eq i32 %t220, 0
  %t226 = select i1 %t225, i8* %t224, i8* null
  %t227 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t218, i32 0, i32 1
  %t228 = bitcast [16 x i8]* %t227 to i8*
  %t229 = bitcast i8* %t228 to i8**
  %t230 = load i8*, i8** %t229
  %t231 = icmp eq i32 %t220, 1
  %t232 = select i1 %t231, i8* %t230, i8* %t226
  %t233 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t218, i32 0, i32 1
  %t234 = bitcast [8 x i8]* %t233 to i8*
  %t235 = bitcast i8* %t234 to i8**
  %t236 = load i8*, i8** %t235
  %t237 = icmp eq i32 %t220, 12
  %t238 = select i1 %t237, i8* %t236, i8* %t232
  store i8* %t238, i8** %l9
  %t239 = load i8*, i8** %l9
  %t240 = extractvalue %NativeFunction %function, 4
  %t241 = load double, double* %l7
  %t242 = sitofp i64 1 to double
  %t243 = fadd double %t241, %t242
  %t244 = bitcast { %NativeInstruction**, i64 }* %t240 to { %NativeInstruction*, i64 }*
  %t245 = call %StructLiteralCapture @capture_struct_literal_expression(i8* %t239, { %NativeInstruction*, i64 }* %t244, double %t243)
  store %StructLiteralCapture %t245, %StructLiteralCapture* %l10
  %t246 = sitofp i64 0 to double
  store double %t246, double* %l11
  %t247 = load %StructLiteralCapture, %StructLiteralCapture* %l10
  %t248 = extractvalue %StructLiteralCapture %t247, 2
  %t249 = load %PythonBuilder, %PythonBuilder* %l0
  %t250 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t251 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t252 = load i8*, i8** %l3
  %t253 = load double, double* %l4
  %t254 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t255 = load double, double* %l6
  %t256 = load double, double* %l7
  %t257 = load %NativeInstruction*, %NativeInstruction** %l8
  %t258 = load i8*, i8** %l9
  %t259 = load %StructLiteralCapture, %StructLiteralCapture* %l10
  %t260 = load double, double* %l11
  br i1 %t248, label %then16, label %else17
then16:
  %t261 = load %StructLiteralCapture, %StructLiteralCapture* %l10
  %t262 = extractvalue %StructLiteralCapture %t261, 0
  store i8* %t262, i8** %l9
  %t263 = load %StructLiteralCapture, %StructLiteralCapture* %l10
  %t264 = extractvalue %StructLiteralCapture %t263, 1
  store double %t264, double* %l11
  %t265 = load i8*, i8** %l9
  %t266 = load double, double* %l11
  br label %merge18
else17:
  %t267 = load i8*, i8** %l9
  %t268 = extractvalue %NativeFunction %function, 4
  %t269 = load double, double* %l7
  %t270 = sitofp i64 1 to double
  %t271 = fadd double %t269, %t270
  %t272 = bitcast { %NativeInstruction**, i64 }* %t268 to { %NativeInstruction*, i64 }*
  %t273 = call %ExpressionContinuationCapture @capture_expression_continuation(i8* %t267, { %NativeInstruction*, i64 }* %t272, double %t271)
  store %ExpressionContinuationCapture %t273, %ExpressionContinuationCapture* %l12
  %t274 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l12
  %t275 = extractvalue %ExpressionContinuationCapture %t274, 2
  %t276 = load %PythonBuilder, %PythonBuilder* %l0
  %t277 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t278 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t279 = load i8*, i8** %l3
  %t280 = load double, double* %l4
  %t281 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t282 = load double, double* %l6
  %t283 = load double, double* %l7
  %t284 = load %NativeInstruction*, %NativeInstruction** %l8
  %t285 = load i8*, i8** %l9
  %t286 = load %StructLiteralCapture, %StructLiteralCapture* %l10
  %t287 = load double, double* %l11
  %t288 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l12
  br i1 %t275, label %then19, label %merge20
then19:
  %t289 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l12
  %t290 = extractvalue %ExpressionContinuationCapture %t289, 0
  store i8* %t290, i8** %l9
  %t291 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l12
  %t292 = extractvalue %ExpressionContinuationCapture %t291, 1
  store double %t292, double* %l11
  %t293 = load i8*, i8** %l9
  %t294 = load double, double* %l11
  br label %merge20
merge20:
  %t295 = phi i8* [ %t293, %then19 ], [ %t285, %else17 ]
  %t296 = phi double [ %t294, %then19 ], [ %t287, %else17 ]
  store i8* %t295, i8** %l9
  store double %t296, double* %l11
  %t297 = load i8*, i8** %l9
  %t298 = load double, double* %l11
  br label %merge18
merge18:
  %t299 = phi i8* [ %t265, %then16 ], [ %t297, %merge20 ]
  %t300 = phi double [ %t266, %then16 ], [ %t298, %merge20 ]
  store i8* %t299, i8** %l9
  store double %t300, double* %l11
  %t301 = load %PythonBuilder, %PythonBuilder* %l0
  %s302 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h655348872, i32 0, i32 0
  %t303 = load i8*, i8** %l9
  %t304 = call i8* @lower_expression(i8* %t303)
  %t305 = call i8* @sailfin_runtime_string_concat(i8* %s302, i8* %t304)
  %t306 = call %PythonBuilder @builder_emit(%PythonBuilder %t301, i8* %t305)
  store %PythonBuilder %t306, %PythonBuilder* %l0
  %t307 = load double, double* %l7
  %t308 = load double, double* %l11
  %t309 = fadd double %t307, %t308
  store double %t309, double* %l7
  %t310 = load %PythonBuilder, %PythonBuilder* %l0
  %t311 = load double, double* %l7
  br label %merge15
merge15:
  %t312 = phi %PythonBuilder [ %t217, %then13 ], [ %t310, %merge18 ]
  %t313 = phi double [ %t212, %then13 ], [ %t311, %merge18 ]
  store %PythonBuilder %t312, %PythonBuilder* %l0
  store double %t313, double* %l7
  %t314 = load %PythonBuilder, %PythonBuilder* %l0
  %t315 = load %PythonBuilder, %PythonBuilder* %l0
  %t316 = load double, double* %l7
  br label %merge12
else11:
  %t317 = load %NativeInstruction*, %NativeInstruction** %l8
  %t318 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t317, i32 0, i32 0
  %t319 = load i32, i32* %t318
  %t320 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t321 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t322 = icmp eq i32 %t319, 0
  %t323 = select i1 %t322, i8* %t321, i8* %t320
  %t324 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t325 = icmp eq i32 %t319, 1
  %t326 = select i1 %t325, i8* %t324, i8* %t323
  %t327 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t328 = icmp eq i32 %t319, 2
  %t329 = select i1 %t328, i8* %t327, i8* %t326
  %t330 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t331 = icmp eq i32 %t319, 3
  %t332 = select i1 %t331, i8* %t330, i8* %t329
  %t333 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t334 = icmp eq i32 %t319, 4
  %t335 = select i1 %t334, i8* %t333, i8* %t332
  %t336 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t337 = icmp eq i32 %t319, 5
  %t338 = select i1 %t337, i8* %t336, i8* %t335
  %t339 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t340 = icmp eq i32 %t319, 6
  %t341 = select i1 %t340, i8* %t339, i8* %t338
  %t342 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t343 = icmp eq i32 %t319, 7
  %t344 = select i1 %t343, i8* %t342, i8* %t341
  %t345 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t346 = icmp eq i32 %t319, 8
  %t347 = select i1 %t346, i8* %t345, i8* %t344
  %t348 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t349 = icmp eq i32 %t319, 9
  %t350 = select i1 %t349, i8* %t348, i8* %t347
  %t351 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t352 = icmp eq i32 %t319, 10
  %t353 = select i1 %t352, i8* %t351, i8* %t350
  %t354 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t355 = icmp eq i32 %t319, 11
  %t356 = select i1 %t355, i8* %t354, i8* %t353
  %t357 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t358 = icmp eq i32 %t319, 12
  %t359 = select i1 %t358, i8* %t357, i8* %t356
  %t360 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t361 = icmp eq i32 %t319, 13
  %t362 = select i1 %t361, i8* %t360, i8* %t359
  %t363 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t364 = icmp eq i32 %t319, 14
  %t365 = select i1 %t364, i8* %t363, i8* %t362
  %t366 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t367 = icmp eq i32 %t319, 15
  %t368 = select i1 %t367, i8* %t366, i8* %t365
  %t369 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t370 = icmp eq i32 %t319, 16
  %t371 = select i1 %t370, i8* %t369, i8* %t368
  %s372 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h1629914700, i32 0, i32 0
  %t373 = call i1 @strings_equal(i8* %t371, i8* %s372)
  %t374 = load %PythonBuilder, %PythonBuilder* %l0
  %t375 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t376 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t377 = load i8*, i8** %l3
  %t378 = load double, double* %l4
  %t379 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t380 = load double, double* %l6
  %t381 = load double, double* %l7
  %t382 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t373, label %then21, label %else22
then21:
  %t383 = load %NativeInstruction*, %NativeInstruction** %l8
  %t384 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t383, i32 0, i32 0
  %t385 = load i32, i32* %t384
  %t386 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t383, i32 0, i32 1
  %t387 = bitcast [16 x i8]* %t386 to i8*
  %t388 = bitcast i8* %t387 to i8**
  %t389 = load i8*, i8** %t388
  %t390 = icmp eq i32 %t385, 0
  %t391 = select i1 %t390, i8* %t389, i8* null
  %t392 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t383, i32 0, i32 1
  %t393 = bitcast [16 x i8]* %t392 to i8*
  %t394 = bitcast i8* %t393 to i8**
  %t395 = load i8*, i8** %t394
  %t396 = icmp eq i32 %t385, 1
  %t397 = select i1 %t396, i8* %t395, i8* %t391
  %t398 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t383, i32 0, i32 1
  %t399 = bitcast [8 x i8]* %t398 to i8*
  %t400 = bitcast i8* %t399 to i8**
  %t401 = load i8*, i8** %t400
  %t402 = icmp eq i32 %t385, 12
  %t403 = select i1 %t402, i8* %t401, i8* %t397
  store i8* %t403, i8** %l13
  %t404 = load i8*, i8** %l13
  %t405 = extractvalue %NativeFunction %function, 4
  %t406 = load double, double* %l7
  %t407 = sitofp i64 1 to double
  %t408 = fadd double %t406, %t407
  %t409 = bitcast { %NativeInstruction**, i64 }* %t405 to { %NativeInstruction*, i64 }*
  %t410 = call %StructLiteralCapture @capture_struct_literal_expression(i8* %t404, { %NativeInstruction*, i64 }* %t409, double %t408)
  store %StructLiteralCapture %t410, %StructLiteralCapture* %l14
  %t411 = sitofp i64 0 to double
  store double %t411, double* %l15
  %t412 = load %StructLiteralCapture, %StructLiteralCapture* %l14
  %t413 = extractvalue %StructLiteralCapture %t412, 2
  %t414 = load %PythonBuilder, %PythonBuilder* %l0
  %t415 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t416 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t417 = load i8*, i8** %l3
  %t418 = load double, double* %l4
  %t419 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t420 = load double, double* %l6
  %t421 = load double, double* %l7
  %t422 = load %NativeInstruction*, %NativeInstruction** %l8
  %t423 = load i8*, i8** %l13
  %t424 = load %StructLiteralCapture, %StructLiteralCapture* %l14
  %t425 = load double, double* %l15
  br i1 %t413, label %then24, label %else25
then24:
  %t426 = load %StructLiteralCapture, %StructLiteralCapture* %l14
  %t427 = extractvalue %StructLiteralCapture %t426, 0
  store i8* %t427, i8** %l13
  %t428 = load %StructLiteralCapture, %StructLiteralCapture* %l14
  %t429 = extractvalue %StructLiteralCapture %t428, 1
  store double %t429, double* %l15
  %t430 = load i8*, i8** %l13
  %t431 = load double, double* %l15
  br label %merge26
else25:
  %t432 = load i8*, i8** %l13
  %t433 = extractvalue %NativeFunction %function, 4
  %t434 = load double, double* %l7
  %t435 = sitofp i64 1 to double
  %t436 = fadd double %t434, %t435
  %t437 = bitcast { %NativeInstruction**, i64 }* %t433 to { %NativeInstruction*, i64 }*
  %t438 = call %ExpressionContinuationCapture @capture_expression_continuation(i8* %t432, { %NativeInstruction*, i64 }* %t437, double %t436)
  store %ExpressionContinuationCapture %t438, %ExpressionContinuationCapture* %l16
  %t439 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l16
  %t440 = extractvalue %ExpressionContinuationCapture %t439, 2
  %t441 = load %PythonBuilder, %PythonBuilder* %l0
  %t442 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t443 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t444 = load i8*, i8** %l3
  %t445 = load double, double* %l4
  %t446 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t447 = load double, double* %l6
  %t448 = load double, double* %l7
  %t449 = load %NativeInstruction*, %NativeInstruction** %l8
  %t450 = load i8*, i8** %l13
  %t451 = load %StructLiteralCapture, %StructLiteralCapture* %l14
  %t452 = load double, double* %l15
  %t453 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l16
  br i1 %t440, label %then27, label %merge28
then27:
  %t454 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l16
  %t455 = extractvalue %ExpressionContinuationCapture %t454, 0
  store i8* %t455, i8** %l13
  %t456 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l16
  %t457 = extractvalue %ExpressionContinuationCapture %t456, 1
  store double %t457, double* %l15
  %t458 = load i8*, i8** %l13
  %t459 = load double, double* %l15
  br label %merge28
merge28:
  %t460 = phi i8* [ %t458, %then27 ], [ %t450, %else25 ]
  %t461 = phi double [ %t459, %then27 ], [ %t452, %else25 ]
  store i8* %t460, i8** %l13
  store double %t461, double* %l15
  %t462 = load i8*, i8** %l13
  %t463 = load double, double* %l15
  br label %merge26
merge26:
  %t464 = phi i8* [ %t430, %then24 ], [ %t462, %merge28 ]
  %t465 = phi double [ %t431, %then24 ], [ %t463, %merge28 ]
  store i8* %t464, i8** %l13
  store double %t465, double* %l15
  %t466 = load %PythonBuilder, %PythonBuilder* %l0
  %t467 = load i8*, i8** %l13
  %t468 = call i8* @lower_expression(i8* %t467)
  %t469 = call %PythonBuilder @builder_emit(%PythonBuilder %t466, i8* %t468)
  store %PythonBuilder %t469, %PythonBuilder* %l0
  %t470 = load double, double* %l7
  %t471 = load double, double* %l15
  %t472 = fadd double %t470, %t471
  store double %t472, double* %l7
  %t473 = load %PythonBuilder, %PythonBuilder* %l0
  %t474 = load double, double* %l7
  br label %merge23
else22:
  %t475 = load %NativeInstruction*, %NativeInstruction** %l8
  %t476 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t475, i32 0, i32 0
  %t477 = load i32, i32* %t476
  %t478 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t479 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t480 = icmp eq i32 %t477, 0
  %t481 = select i1 %t480, i8* %t479, i8* %t478
  %t482 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t483 = icmp eq i32 %t477, 1
  %t484 = select i1 %t483, i8* %t482, i8* %t481
  %t485 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t486 = icmp eq i32 %t477, 2
  %t487 = select i1 %t486, i8* %t485, i8* %t484
  %t488 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t489 = icmp eq i32 %t477, 3
  %t490 = select i1 %t489, i8* %t488, i8* %t487
  %t491 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t492 = icmp eq i32 %t477, 4
  %t493 = select i1 %t492, i8* %t491, i8* %t490
  %t494 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t495 = icmp eq i32 %t477, 5
  %t496 = select i1 %t495, i8* %t494, i8* %t493
  %t497 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t498 = icmp eq i32 %t477, 6
  %t499 = select i1 %t498, i8* %t497, i8* %t496
  %t500 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t501 = icmp eq i32 %t477, 7
  %t502 = select i1 %t501, i8* %t500, i8* %t499
  %t503 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t504 = icmp eq i32 %t477, 8
  %t505 = select i1 %t504, i8* %t503, i8* %t502
  %t506 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t507 = icmp eq i32 %t477, 9
  %t508 = select i1 %t507, i8* %t506, i8* %t505
  %t509 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t510 = icmp eq i32 %t477, 10
  %t511 = select i1 %t510, i8* %t509, i8* %t508
  %t512 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t513 = icmp eq i32 %t477, 11
  %t514 = select i1 %t513, i8* %t512, i8* %t511
  %t515 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t516 = icmp eq i32 %t477, 12
  %t517 = select i1 %t516, i8* %t515, i8* %t514
  %t518 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t519 = icmp eq i32 %t477, 13
  %t520 = select i1 %t519, i8* %t518, i8* %t517
  %t521 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t522 = icmp eq i32 %t477, 14
  %t523 = select i1 %t522, i8* %t521, i8* %t520
  %t524 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t525 = icmp eq i32 %t477, 15
  %t526 = select i1 %t525, i8* %t524, i8* %t523
  %t527 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t528 = icmp eq i32 %t477, 16
  %t529 = select i1 %t528, i8* %t527, i8* %t526
  %s530 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2089318639, i32 0, i32 0
  %t531 = call i1 @strings_equal(i8* %t529, i8* %s530)
  %t532 = load %PythonBuilder, %PythonBuilder* %l0
  %t533 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t534 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t535 = load i8*, i8** %l3
  %t536 = load double, double* %l4
  %t537 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t538 = load double, double* %l6
  %t539 = load double, double* %l7
  %t540 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t531, label %then29, label %else30
then29:
  %t541 = load %NativeInstruction*, %NativeInstruction** %l8
  %t542 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t541, i32 0, i32 0
  %t543 = load i32, i32* %t542
  %t544 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t541, i32 0, i32 1
  %t545 = bitcast [48 x i8]* %t544 to i8*
  %t546 = bitcast i8* %t545 to i8**
  %t547 = load i8*, i8** %t546
  %t548 = icmp eq i32 %t543, 2
  %t549 = select i1 %t548, i8* %t547, i8* null
  %t550 = call i8* @sanitize_identifier(i8* %t549)
  store i8* %t550, i8** %l17
  %t551 = load i8*, i8** %l17
  %s552 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087691079, i32 0, i32 0
  %t553 = call i8* @sailfin_runtime_string_concat(i8* %t551, i8* %s552)
  store i8* %t553, i8** %l18
  %t554 = load %NativeInstruction*, %NativeInstruction** %l8
  %t555 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t554, i32 0, i32 0
  %t556 = load i32, i32* %t555
  %t557 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t554, i32 0, i32 1
  %t558 = bitcast [48 x i8]* %t557 to i8*
  %t559 = getelementptr inbounds i8, i8* %t558, i64 24
  %t560 = bitcast i8* %t559 to i8**
  %t561 = load i8*, i8** %t560
  %t562 = icmp eq i32 %t556, 2
  %t563 = select i1 %t562, i8* %t561, i8* null
  %t564 = icmp ne i8* %t563, null
  %t565 = load %PythonBuilder, %PythonBuilder* %l0
  %t566 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t567 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t568 = load i8*, i8** %l3
  %t569 = load double, double* %l4
  %t570 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t571 = load double, double* %l6
  %t572 = load double, double* %l7
  %t573 = load %NativeInstruction*, %NativeInstruction** %l8
  %t574 = load i8*, i8** %l17
  %t575 = load i8*, i8** %l18
  br i1 %t564, label %then32, label %else33
then32:
  %t576 = load %NativeInstruction*, %NativeInstruction** %l8
  %t577 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t576, i32 0, i32 0
  %t578 = load i32, i32* %t577
  %t579 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t576, i32 0, i32 1
  %t580 = bitcast [48 x i8]* %t579 to i8*
  %t581 = getelementptr inbounds i8, i8* %t580, i64 24
  %t582 = bitcast i8* %t581 to i8**
  %t583 = load i8*, i8** %t582
  %t584 = icmp eq i32 %t578, 2
  %t585 = select i1 %t584, i8* %t583, i8* null
  store i8* %t585, i8** %l19
  %t586 = load i8*, i8** %l19
  %t587 = extractvalue %NativeFunction %function, 4
  %t588 = load double, double* %l7
  %t589 = sitofp i64 1 to double
  %t590 = fadd double %t588, %t589
  %t591 = bitcast { %NativeInstruction**, i64 }* %t587 to { %NativeInstruction*, i64 }*
  %t592 = call %StructLiteralCapture @capture_struct_literal_expression(i8* %t586, { %NativeInstruction*, i64 }* %t591, double %t590)
  store %StructLiteralCapture %t592, %StructLiteralCapture* %l20
  %t593 = sitofp i64 0 to double
  store double %t593, double* %l21
  %t594 = load %StructLiteralCapture, %StructLiteralCapture* %l20
  %t595 = extractvalue %StructLiteralCapture %t594, 2
  %t596 = load %PythonBuilder, %PythonBuilder* %l0
  %t597 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t598 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t599 = load i8*, i8** %l3
  %t600 = load double, double* %l4
  %t601 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t602 = load double, double* %l6
  %t603 = load double, double* %l7
  %t604 = load %NativeInstruction*, %NativeInstruction** %l8
  %t605 = load i8*, i8** %l17
  %t606 = load i8*, i8** %l18
  %t607 = load i8*, i8** %l19
  %t608 = load %StructLiteralCapture, %StructLiteralCapture* %l20
  %t609 = load double, double* %l21
  br i1 %t595, label %then35, label %else36
then35:
  %t610 = load %StructLiteralCapture, %StructLiteralCapture* %l20
  %t611 = extractvalue %StructLiteralCapture %t610, 0
  store i8* %t611, i8** %l19
  %t612 = load %StructLiteralCapture, %StructLiteralCapture* %l20
  %t613 = extractvalue %StructLiteralCapture %t612, 1
  store double %t613, double* %l21
  %t614 = load i8*, i8** %l19
  %t615 = load double, double* %l21
  br label %merge37
else36:
  %t616 = load i8*, i8** %l19
  %t617 = extractvalue %NativeFunction %function, 4
  %t618 = load double, double* %l7
  %t619 = sitofp i64 1 to double
  %t620 = fadd double %t618, %t619
  %t621 = bitcast { %NativeInstruction**, i64 }* %t617 to { %NativeInstruction*, i64 }*
  %t622 = call %ExpressionContinuationCapture @capture_expression_continuation(i8* %t616, { %NativeInstruction*, i64 }* %t621, double %t620)
  store %ExpressionContinuationCapture %t622, %ExpressionContinuationCapture* %l22
  %t623 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l22
  %t624 = extractvalue %ExpressionContinuationCapture %t623, 2
  %t625 = load %PythonBuilder, %PythonBuilder* %l0
  %t626 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t627 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t628 = load i8*, i8** %l3
  %t629 = load double, double* %l4
  %t630 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t631 = load double, double* %l6
  %t632 = load double, double* %l7
  %t633 = load %NativeInstruction*, %NativeInstruction** %l8
  %t634 = load i8*, i8** %l17
  %t635 = load i8*, i8** %l18
  %t636 = load i8*, i8** %l19
  %t637 = load %StructLiteralCapture, %StructLiteralCapture* %l20
  %t638 = load double, double* %l21
  %t639 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l22
  br i1 %t624, label %then38, label %merge39
then38:
  %t640 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l22
  %t641 = extractvalue %ExpressionContinuationCapture %t640, 0
  store i8* %t641, i8** %l19
  %t642 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l22
  %t643 = extractvalue %ExpressionContinuationCapture %t642, 1
  store double %t643, double* %l21
  %t644 = load i8*, i8** %l19
  %t645 = load double, double* %l21
  br label %merge39
merge39:
  %t646 = phi i8* [ %t644, %then38 ], [ %t636, %else36 ]
  %t647 = phi double [ %t645, %then38 ], [ %t638, %else36 ]
  store i8* %t646, i8** %l19
  store double %t647, double* %l21
  %t648 = load i8*, i8** %l19
  %t649 = load double, double* %l21
  br label %merge37
merge37:
  %t650 = phi i8* [ %t614, %then35 ], [ %t648, %merge39 ]
  %t651 = phi double [ %t615, %then35 ], [ %t649, %merge39 ]
  store i8* %t650, i8** %l19
  store double %t651, double* %l21
  %t652 = load i8*, i8** %l18
  %t653 = load i8*, i8** %l19
  %t654 = call i8* @lower_expression(i8* %t653)
  %t655 = call i8* @sailfin_runtime_string_concat(i8* %t652, i8* %t654)
  store i8* %t655, i8** %l18
  %t656 = load double, double* %l7
  %t657 = load double, double* %l21
  %t658 = fadd double %t656, %t657
  store double %t658, double* %l7
  %t659 = load i8*, i8** %l18
  %t660 = load double, double* %l7
  br label %merge34
else33:
  %t661 = load i8*, i8** %l18
  %s662 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h230766299, i32 0, i32 0
  %t663 = call i8* @sailfin_runtime_string_concat(i8* %t661, i8* %s662)
  store i8* %t663, i8** %l18
  %t664 = load i8*, i8** %l18
  br label %merge34
merge34:
  %t665 = phi i8* [ %t659, %merge37 ], [ %t664, %else33 ]
  %t666 = phi double [ %t660, %merge37 ], [ %t572, %else33 ]
  store i8* %t665, i8** %l18
  store double %t666, double* %l7
  %t667 = load %PythonBuilder, %PythonBuilder* %l0
  %t668 = load i8*, i8** %l18
  %t669 = call %PythonBuilder @builder_emit(%PythonBuilder %t667, i8* %t668)
  store %PythonBuilder %t669, %PythonBuilder* %l0
  %t670 = load double, double* %l7
  %t671 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge31
else30:
  %t672 = load %NativeInstruction*, %NativeInstruction** %l8
  %t673 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t672, i32 0, i32 0
  %t674 = load i32, i32* %t673
  %t675 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t676 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t677 = icmp eq i32 %t674, 0
  %t678 = select i1 %t677, i8* %t676, i8* %t675
  %t679 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t680 = icmp eq i32 %t674, 1
  %t681 = select i1 %t680, i8* %t679, i8* %t678
  %t682 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t683 = icmp eq i32 %t674, 2
  %t684 = select i1 %t683, i8* %t682, i8* %t681
  %t685 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t686 = icmp eq i32 %t674, 3
  %t687 = select i1 %t686, i8* %t685, i8* %t684
  %t688 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t689 = icmp eq i32 %t674, 4
  %t690 = select i1 %t689, i8* %t688, i8* %t687
  %t691 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t692 = icmp eq i32 %t674, 5
  %t693 = select i1 %t692, i8* %t691, i8* %t690
  %t694 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t695 = icmp eq i32 %t674, 6
  %t696 = select i1 %t695, i8* %t694, i8* %t693
  %t697 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t698 = icmp eq i32 %t674, 7
  %t699 = select i1 %t698, i8* %t697, i8* %t696
  %t700 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t701 = icmp eq i32 %t674, 8
  %t702 = select i1 %t701, i8* %t700, i8* %t699
  %t703 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t704 = icmp eq i32 %t674, 9
  %t705 = select i1 %t704, i8* %t703, i8* %t702
  %t706 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t707 = icmp eq i32 %t674, 10
  %t708 = select i1 %t707, i8* %t706, i8* %t705
  %t709 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t710 = icmp eq i32 %t674, 11
  %t711 = select i1 %t710, i8* %t709, i8* %t708
  %t712 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t713 = icmp eq i32 %t674, 12
  %t714 = select i1 %t713, i8* %t712, i8* %t711
  %t715 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t716 = icmp eq i32 %t674, 13
  %t717 = select i1 %t716, i8* %t715, i8* %t714
  %t718 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t719 = icmp eq i32 %t674, 14
  %t720 = select i1 %t719, i8* %t718, i8* %t717
  %t721 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t722 = icmp eq i32 %t674, 15
  %t723 = select i1 %t722, i8* %t721, i8* %t720
  %t724 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t725 = icmp eq i32 %t674, 16
  %t726 = select i1 %t725, i8* %t724, i8* %t723
  %s727 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193459862, i32 0, i32 0
  %t728 = call i1 @strings_equal(i8* %t726, i8* %s727)
  %t729 = load %PythonBuilder, %PythonBuilder* %l0
  %t730 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t731 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t732 = load i8*, i8** %l3
  %t733 = load double, double* %l4
  %t734 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t735 = load double, double* %l6
  %t736 = load double, double* %l7
  %t737 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t728, label %then40, label %else41
then40:
  %t738 = load %NativeInstruction*, %NativeInstruction** %l8
  %t739 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t738, i32 0, i32 0
  %t740 = load i32, i32* %t739
  %t741 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t738, i32 0, i32 1
  %t742 = bitcast [8 x i8]* %t741 to i8*
  %t743 = bitcast i8* %t742 to i8**
  %t744 = load i8*, i8** %t743
  %t745 = icmp eq i32 %t740, 3
  %t746 = select i1 %t745, i8* %t744, i8* null
  %t747 = call i8* @trim_text(i8* %t746)
  %t748 = call i8* @rewrite_expression_intrinsics(i8* %t747)
  store i8* %t748, i8** %l23
  %t749 = load %PythonBuilder, %PythonBuilder* %l0
  %s750 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2090359129, i32 0, i32 0
  %t751 = load i8*, i8** %l23
  %t752 = call i8* @sailfin_runtime_string_concat(i8* %s750, i8* %t751)
  %t753 = alloca [2 x i8], align 1
  %t754 = getelementptr [2 x i8], [2 x i8]* %t753, i32 0, i32 0
  store i8 58, i8* %t754
  %t755 = getelementptr [2 x i8], [2 x i8]* %t753, i32 0, i32 1
  store i8 0, i8* %t755
  %t756 = getelementptr [2 x i8], [2 x i8]* %t753, i32 0, i32 0
  %t757 = call i8* @sailfin_runtime_string_concat(i8* %t752, i8* %t756)
  %t758 = call %PythonBuilder @builder_emit(%PythonBuilder %t749, i8* %t757)
  store %PythonBuilder %t758, %PythonBuilder* %l0
  %t759 = load %PythonBuilder, %PythonBuilder* %l0
  %t760 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t759)
  store %PythonBuilder %t760, %PythonBuilder* %l0
  %t761 = load double, double* %l4
  %t762 = sitofp i64 1 to double
  %t763 = fadd double %t761, %t762
  store double %t763, double* %l4
  %t764 = load %PythonBuilder, %PythonBuilder* %l0
  %t765 = load %PythonBuilder, %PythonBuilder* %l0
  %t766 = load double, double* %l4
  br label %merge42
else41:
  %t767 = load %NativeInstruction*, %NativeInstruction** %l8
  %t768 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t767, i32 0, i32 0
  %t769 = load i32, i32* %t768
  %t770 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t771 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t772 = icmp eq i32 %t769, 0
  %t773 = select i1 %t772, i8* %t771, i8* %t770
  %t774 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t775 = icmp eq i32 %t769, 1
  %t776 = select i1 %t775, i8* %t774, i8* %t773
  %t777 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t778 = icmp eq i32 %t769, 2
  %t779 = select i1 %t778, i8* %t777, i8* %t776
  %t780 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t781 = icmp eq i32 %t769, 3
  %t782 = select i1 %t781, i8* %t780, i8* %t779
  %t783 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t784 = icmp eq i32 %t769, 4
  %t785 = select i1 %t784, i8* %t783, i8* %t782
  %t786 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t787 = icmp eq i32 %t769, 5
  %t788 = select i1 %t787, i8* %t786, i8* %t785
  %t789 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t790 = icmp eq i32 %t769, 6
  %t791 = select i1 %t790, i8* %t789, i8* %t788
  %t792 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t793 = icmp eq i32 %t769, 7
  %t794 = select i1 %t793, i8* %t792, i8* %t791
  %t795 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t796 = icmp eq i32 %t769, 8
  %t797 = select i1 %t796, i8* %t795, i8* %t794
  %t798 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t799 = icmp eq i32 %t769, 9
  %t800 = select i1 %t799, i8* %t798, i8* %t797
  %t801 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t802 = icmp eq i32 %t769, 10
  %t803 = select i1 %t802, i8* %t801, i8* %t800
  %t804 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t805 = icmp eq i32 %t769, 11
  %t806 = select i1 %t805, i8* %t804, i8* %t803
  %t807 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t808 = icmp eq i32 %t769, 12
  %t809 = select i1 %t808, i8* %t807, i8* %t806
  %t810 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t811 = icmp eq i32 %t769, 13
  %t812 = select i1 %t811, i8* %t810, i8* %t809
  %t813 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t814 = icmp eq i32 %t769, 14
  %t815 = select i1 %t814, i8* %t813, i8* %t812
  %t816 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t817 = icmp eq i32 %t769, 15
  %t818 = select i1 %t817, i8* %t816, i8* %t815
  %t819 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t820 = icmp eq i32 %t769, 16
  %t821 = select i1 %t820, i8* %t819, i8* %t818
  %s822 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h219990644, i32 0, i32 0
  %t823 = call i1 @strings_equal(i8* %t821, i8* %s822)
  %t824 = load %PythonBuilder, %PythonBuilder* %l0
  %t825 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t826 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t827 = load i8*, i8** %l3
  %t828 = load double, double* %l4
  %t829 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t830 = load double, double* %l6
  %t831 = load double, double* %l7
  %t832 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t823, label %then43, label %else44
then43:
  %t833 = load double, double* %l4
  %t834 = sitofp i64 0 to double
  %t835 = fcmp ogt double %t833, %t834
  %t836 = load %PythonBuilder, %PythonBuilder* %l0
  %t837 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t838 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t839 = load i8*, i8** %l3
  %t840 = load double, double* %l4
  %t841 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t842 = load double, double* %l6
  %t843 = load double, double* %l7
  %t844 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t835, label %then46, label %else47
then46:
  %t845 = load %PythonBuilder, %PythonBuilder* %l0
  %t846 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t845)
  store %PythonBuilder %t846, %PythonBuilder* %l0
  %t847 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge48
else47:
  %t848 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t849 = extractvalue %NativeFunction %function, 0
  %s850 = getelementptr inbounds [25 x i8], [25 x i8]* @.str.len24.h2028465620, i32 0, i32 0
  %t851 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t848, i8* %t849, i8* %s850)
  store { i8**, i64 }* %t851, { i8**, i64 }** %l1
  %t852 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge48
merge48:
  %t853 = phi %PythonBuilder [ %t847, %then46 ], [ %t836, %else47 ]
  %t854 = phi { i8**, i64 }* [ %t837, %then46 ], [ %t852, %else47 ]
  store %PythonBuilder %t853, %PythonBuilder* %l0
  store { i8**, i64 }* %t854, { i8**, i64 }** %l1
  %t855 = load %PythonBuilder, %PythonBuilder* %l0
  %s856 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2069574674, i32 0, i32 0
  %t857 = call %PythonBuilder @builder_emit(%PythonBuilder %t855, i8* %s856)
  store %PythonBuilder %t857, %PythonBuilder* %l0
  %t858 = load %PythonBuilder, %PythonBuilder* %l0
  %t859 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t858)
  store %PythonBuilder %t859, %PythonBuilder* %l0
  %t860 = load %PythonBuilder, %PythonBuilder* %l0
  %t861 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t862 = load %PythonBuilder, %PythonBuilder* %l0
  %t863 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge45
else44:
  %t864 = load %NativeInstruction*, %NativeInstruction** %l8
  %t865 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t864, i32 0, i32 0
  %t866 = load i32, i32* %t865
  %t867 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t868 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t869 = icmp eq i32 %t866, 0
  %t870 = select i1 %t869, i8* %t868, i8* %t867
  %t871 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t872 = icmp eq i32 %t866, 1
  %t873 = select i1 %t872, i8* %t871, i8* %t870
  %t874 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t875 = icmp eq i32 %t866, 2
  %t876 = select i1 %t875, i8* %t874, i8* %t873
  %t877 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t878 = icmp eq i32 %t866, 3
  %t879 = select i1 %t878, i8* %t877, i8* %t876
  %t880 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t881 = icmp eq i32 %t866, 4
  %t882 = select i1 %t881, i8* %t880, i8* %t879
  %t883 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t884 = icmp eq i32 %t866, 5
  %t885 = select i1 %t884, i8* %t883, i8* %t882
  %t886 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t887 = icmp eq i32 %t866, 6
  %t888 = select i1 %t887, i8* %t886, i8* %t885
  %t889 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t890 = icmp eq i32 %t866, 7
  %t891 = select i1 %t890, i8* %t889, i8* %t888
  %t892 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t893 = icmp eq i32 %t866, 8
  %t894 = select i1 %t893, i8* %t892, i8* %t891
  %t895 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t896 = icmp eq i32 %t866, 9
  %t897 = select i1 %t896, i8* %t895, i8* %t894
  %t898 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t899 = icmp eq i32 %t866, 10
  %t900 = select i1 %t899, i8* %t898, i8* %t897
  %t901 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t902 = icmp eq i32 %t866, 11
  %t903 = select i1 %t902, i8* %t901, i8* %t900
  %t904 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t905 = icmp eq i32 %t866, 12
  %t906 = select i1 %t905, i8* %t904, i8* %t903
  %t907 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t908 = icmp eq i32 %t866, 13
  %t909 = select i1 %t908, i8* %t907, i8* %t906
  %t910 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t911 = icmp eq i32 %t866, 14
  %t912 = select i1 %t911, i8* %t910, i8* %t909
  %t913 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t914 = icmp eq i32 %t866, 15
  %t915 = select i1 %t914, i8* %t913, i8* %t912
  %t916 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t917 = icmp eq i32 %t866, 16
  %t918 = select i1 %t917, i8* %t916, i8* %t915
  %s919 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h819045845, i32 0, i32 0
  %t920 = call i1 @strings_equal(i8* %t918, i8* %s919)
  %t921 = load %PythonBuilder, %PythonBuilder* %l0
  %t922 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t923 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t924 = load i8*, i8** %l3
  %t925 = load double, double* %l4
  %t926 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t927 = load double, double* %l6
  %t928 = load double, double* %l7
  %t929 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t920, label %then49, label %else50
then49:
  %t930 = load double, double* %l4
  %t931 = sitofp i64 0 to double
  %t932 = fcmp ogt double %t930, %t931
  %t933 = load %PythonBuilder, %PythonBuilder* %l0
  %t934 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t935 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t936 = load i8*, i8** %l3
  %t937 = load double, double* %l4
  %t938 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t939 = load double, double* %l6
  %t940 = load double, double* %l7
  %t941 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t932, label %then52, label %else53
then52:
  %t942 = load %PythonBuilder, %PythonBuilder* %l0
  %t943 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t942)
  store %PythonBuilder %t943, %PythonBuilder* %l0
  %t944 = load double, double* %l4
  %t945 = sitofp i64 1 to double
  %t946 = fsub double %t944, %t945
  store double %t946, double* %l4
  %t947 = load %PythonBuilder, %PythonBuilder* %l0
  %t948 = load double, double* %l4
  br label %merge54
else53:
  %t949 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t950 = extractvalue %NativeFunction %function, 0
  %s951 = getelementptr inbounds [26 x i8], [26 x i8]* @.str.len25.h458257002, i32 0, i32 0
  %t952 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t949, i8* %t950, i8* %s951)
  store { i8**, i64 }* %t952, { i8**, i64 }** %l1
  %t953 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge54
merge54:
  %t954 = phi %PythonBuilder [ %t947, %then52 ], [ %t933, %else53 ]
  %t955 = phi double [ %t948, %then52 ], [ %t937, %else53 ]
  %t956 = phi { i8**, i64 }* [ %t934, %then52 ], [ %t953, %else53 ]
  store %PythonBuilder %t954, %PythonBuilder* %l0
  store double %t955, double* %l4
  store { i8**, i64 }* %t956, { i8**, i64 }** %l1
  %t957 = load %PythonBuilder, %PythonBuilder* %l0
  %t958 = load double, double* %l4
  %t959 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge51
else50:
  %t960 = load %NativeInstruction*, %NativeInstruction** %l8
  %t961 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t960, i32 0, i32 0
  %t962 = load i32, i32* %t961
  %t963 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t964 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t965 = icmp eq i32 %t962, 0
  %t966 = select i1 %t965, i8* %t964, i8* %t963
  %t967 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t968 = icmp eq i32 %t962, 1
  %t969 = select i1 %t968, i8* %t967, i8* %t966
  %t970 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t971 = icmp eq i32 %t962, 2
  %t972 = select i1 %t971, i8* %t970, i8* %t969
  %t973 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t974 = icmp eq i32 %t962, 3
  %t975 = select i1 %t974, i8* %t973, i8* %t972
  %t976 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t977 = icmp eq i32 %t962, 4
  %t978 = select i1 %t977, i8* %t976, i8* %t975
  %t979 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t980 = icmp eq i32 %t962, 5
  %t981 = select i1 %t980, i8* %t979, i8* %t978
  %t982 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t983 = icmp eq i32 %t962, 6
  %t984 = select i1 %t983, i8* %t982, i8* %t981
  %t985 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t986 = icmp eq i32 %t962, 7
  %t987 = select i1 %t986, i8* %t985, i8* %t984
  %t988 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t989 = icmp eq i32 %t962, 8
  %t990 = select i1 %t989, i8* %t988, i8* %t987
  %t991 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t992 = icmp eq i32 %t962, 9
  %t993 = select i1 %t992, i8* %t991, i8* %t990
  %t994 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t995 = icmp eq i32 %t962, 10
  %t996 = select i1 %t995, i8* %t994, i8* %t993
  %t997 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t998 = icmp eq i32 %t962, 11
  %t999 = select i1 %t998, i8* %t997, i8* %t996
  %t1000 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1001 = icmp eq i32 %t962, 12
  %t1002 = select i1 %t1001, i8* %t1000, i8* %t999
  %t1003 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1004 = icmp eq i32 %t962, 13
  %t1005 = select i1 %t1004, i8* %t1003, i8* %t1002
  %t1006 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1007 = icmp eq i32 %t962, 14
  %t1008 = select i1 %t1007, i8* %t1006, i8* %t1005
  %t1009 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1010 = icmp eq i32 %t962, 15
  %t1011 = select i1 %t1010, i8* %t1009, i8* %t1008
  %t1012 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1013 = icmp eq i32 %t962, 16
  %t1014 = select i1 %t1013, i8* %t1012, i8* %t1011
  %s1015 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2089113841, i32 0, i32 0
  %t1016 = call i1 @strings_equal(i8* %t1014, i8* %s1015)
  %t1017 = load %PythonBuilder, %PythonBuilder* %l0
  %t1018 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1019 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1020 = load i8*, i8** %l3
  %t1021 = load double, double* %l4
  %t1022 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1023 = load double, double* %l6
  %t1024 = load double, double* %l7
  %t1025 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1016, label %then55, label %else56
then55:
  %t1026 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1027 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1026, i32 0, i32 0
  %t1028 = load i32, i32* %t1027
  %t1029 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1026, i32 0, i32 1
  %t1030 = bitcast [16 x i8]* %t1029 to i8*
  %t1031 = getelementptr inbounds i8, i8* %t1030, i64 8
  %t1032 = bitcast i8* %t1031 to i8**
  %t1033 = load i8*, i8** %t1032
  %t1034 = icmp eq i32 %t1028, 6
  %t1035 = select i1 %t1034, i8* %t1033, i8* null
  %t1036 = call i8* @trim_text(i8* %t1035)
  %t1037 = call i8* @rewrite_expression_intrinsics(i8* %t1036)
  store i8* %t1037, i8** %l24
  %t1038 = load %PythonBuilder, %PythonBuilder* %l0
  %s1039 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h259230482, i32 0, i32 0
  %t1040 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1041 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1040, i32 0, i32 0
  %t1042 = load i32, i32* %t1041
  %t1043 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1040, i32 0, i32 1
  %t1044 = bitcast [16 x i8]* %t1043 to i8*
  %t1045 = bitcast i8* %t1044 to i8**
  %t1046 = load i8*, i8** %t1045
  %t1047 = icmp eq i32 %t1042, 6
  %t1048 = select i1 %t1047, i8* %t1046, i8* null
  %t1049 = call i8* @sailfin_runtime_string_concat(i8* %s1039, i8* %t1048)
  %s1050 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h175996034, i32 0, i32 0
  %t1051 = call i8* @sailfin_runtime_string_concat(i8* %t1049, i8* %s1050)
  %t1052 = load i8*, i8** %l24
  %t1053 = call i8* @sailfin_runtime_string_concat(i8* %t1051, i8* %t1052)
  %t1054 = alloca [2 x i8], align 1
  %t1055 = getelementptr [2 x i8], [2 x i8]* %t1054, i32 0, i32 0
  store i8 58, i8* %t1055
  %t1056 = getelementptr [2 x i8], [2 x i8]* %t1054, i32 0, i32 1
  store i8 0, i8* %t1056
  %t1057 = getelementptr [2 x i8], [2 x i8]* %t1054, i32 0, i32 0
  %t1058 = call i8* @sailfin_runtime_string_concat(i8* %t1053, i8* %t1057)
  %t1059 = call %PythonBuilder @builder_emit(%PythonBuilder %t1038, i8* %t1058)
  store %PythonBuilder %t1059, %PythonBuilder* %l0
  %t1060 = load %PythonBuilder, %PythonBuilder* %l0
  %t1061 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t1060)
  store %PythonBuilder %t1061, %PythonBuilder* %l0
  %t1062 = load double, double* %l4
  %t1063 = sitofp i64 1 to double
  %t1064 = fadd double %t1062, %t1063
  store double %t1064, double* %l4
  %t1065 = load %PythonBuilder, %PythonBuilder* %l0
  %t1066 = load %PythonBuilder, %PythonBuilder* %l0
  %t1067 = load double, double* %l4
  br label %merge57
else56:
  %t1068 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1069 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1068, i32 0, i32 0
  %t1070 = load i32, i32* %t1069
  %t1071 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1072 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1073 = icmp eq i32 %t1070, 0
  %t1074 = select i1 %t1073, i8* %t1072, i8* %t1071
  %t1075 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1076 = icmp eq i32 %t1070, 1
  %t1077 = select i1 %t1076, i8* %t1075, i8* %t1074
  %t1078 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1079 = icmp eq i32 %t1070, 2
  %t1080 = select i1 %t1079, i8* %t1078, i8* %t1077
  %t1081 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1082 = icmp eq i32 %t1070, 3
  %t1083 = select i1 %t1082, i8* %t1081, i8* %t1080
  %t1084 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1085 = icmp eq i32 %t1070, 4
  %t1086 = select i1 %t1085, i8* %t1084, i8* %t1083
  %t1087 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1088 = icmp eq i32 %t1070, 5
  %t1089 = select i1 %t1088, i8* %t1087, i8* %t1086
  %t1090 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1091 = icmp eq i32 %t1070, 6
  %t1092 = select i1 %t1091, i8* %t1090, i8* %t1089
  %t1093 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1094 = icmp eq i32 %t1070, 7
  %t1095 = select i1 %t1094, i8* %t1093, i8* %t1092
  %t1096 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1097 = icmp eq i32 %t1070, 8
  %t1098 = select i1 %t1097, i8* %t1096, i8* %t1095
  %t1099 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1100 = icmp eq i32 %t1070, 9
  %t1101 = select i1 %t1100, i8* %t1099, i8* %t1098
  %t1102 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1103 = icmp eq i32 %t1070, 10
  %t1104 = select i1 %t1103, i8* %t1102, i8* %t1101
  %t1105 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1106 = icmp eq i32 %t1070, 11
  %t1107 = select i1 %t1106, i8* %t1105, i8* %t1104
  %t1108 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1109 = icmp eq i32 %t1070, 12
  %t1110 = select i1 %t1109, i8* %t1108, i8* %t1107
  %t1111 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1112 = icmp eq i32 %t1070, 13
  %t1113 = select i1 %t1112, i8* %t1111, i8* %t1110
  %t1114 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1115 = icmp eq i32 %t1070, 14
  %t1116 = select i1 %t1115, i8* %t1114, i8* %t1113
  %t1117 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1118 = icmp eq i32 %t1070, 15
  %t1119 = select i1 %t1118, i8* %t1117, i8* %t1116
  %t1120 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1121 = icmp eq i32 %t1070, 16
  %t1122 = select i1 %t1121, i8* %t1120, i8* %t1119
  %s1123 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1258614714, i32 0, i32 0
  %t1124 = call i1 @strings_equal(i8* %t1122, i8* %s1123)
  %t1125 = load %PythonBuilder, %PythonBuilder* %l0
  %t1126 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1127 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1128 = load i8*, i8** %l3
  %t1129 = load double, double* %l4
  %t1130 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1131 = load double, double* %l6
  %t1132 = load double, double* %l7
  %t1133 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1124, label %then58, label %else59
then58:
  %t1134 = load double, double* %l4
  %t1135 = sitofp i64 0 to double
  %t1136 = fcmp ogt double %t1134, %t1135
  %t1137 = load %PythonBuilder, %PythonBuilder* %l0
  %t1138 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1139 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1140 = load i8*, i8** %l3
  %t1141 = load double, double* %l4
  %t1142 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1143 = load double, double* %l6
  %t1144 = load double, double* %l7
  %t1145 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1136, label %then61, label %else62
then61:
  %t1146 = load %PythonBuilder, %PythonBuilder* %l0
  %t1147 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t1146)
  store %PythonBuilder %t1147, %PythonBuilder* %l0
  %t1148 = load double, double* %l4
  %t1149 = sitofp i64 1 to double
  %t1150 = fsub double %t1148, %t1149
  store double %t1150, double* %l4
  %t1151 = load %PythonBuilder, %PythonBuilder* %l0
  %t1152 = load double, double* %l4
  br label %merge63
else62:
  %t1153 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1154 = extractvalue %NativeFunction %function, 0
  %s1155 = getelementptr inbounds [33 x i8], [33 x i8]* @.str.len32.h1370567591, i32 0, i32 0
  %t1156 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t1153, i8* %t1154, i8* %s1155)
  store { i8**, i64 }* %t1156, { i8**, i64 }** %l1
  %t1157 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge63
merge63:
  %t1158 = phi %PythonBuilder [ %t1151, %then61 ], [ %t1137, %else62 ]
  %t1159 = phi double [ %t1152, %then61 ], [ %t1141, %else62 ]
  %t1160 = phi { i8**, i64 }* [ %t1138, %then61 ], [ %t1157, %else62 ]
  store %PythonBuilder %t1158, %PythonBuilder* %l0
  store double %t1159, double* %l4
  store { i8**, i64 }* %t1160, { i8**, i64 }** %l1
  %t1161 = load %PythonBuilder, %PythonBuilder* %l0
  %t1162 = load double, double* %l4
  %t1163 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge60
else59:
  %t1164 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1165 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1164, i32 0, i32 0
  %t1166 = load i32, i32* %t1165
  %t1167 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1168 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1169 = icmp eq i32 %t1166, 0
  %t1170 = select i1 %t1169, i8* %t1168, i8* %t1167
  %t1171 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1172 = icmp eq i32 %t1166, 1
  %t1173 = select i1 %t1172, i8* %t1171, i8* %t1170
  %t1174 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1175 = icmp eq i32 %t1166, 2
  %t1176 = select i1 %t1175, i8* %t1174, i8* %t1173
  %t1177 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1178 = icmp eq i32 %t1166, 3
  %t1179 = select i1 %t1178, i8* %t1177, i8* %t1176
  %t1180 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1181 = icmp eq i32 %t1166, 4
  %t1182 = select i1 %t1181, i8* %t1180, i8* %t1179
  %t1183 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1184 = icmp eq i32 %t1166, 5
  %t1185 = select i1 %t1184, i8* %t1183, i8* %t1182
  %t1186 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1187 = icmp eq i32 %t1166, 6
  %t1188 = select i1 %t1187, i8* %t1186, i8* %t1185
  %t1189 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1190 = icmp eq i32 %t1166, 7
  %t1191 = select i1 %t1190, i8* %t1189, i8* %t1188
  %t1192 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1193 = icmp eq i32 %t1166, 8
  %t1194 = select i1 %t1193, i8* %t1192, i8* %t1191
  %t1195 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1196 = icmp eq i32 %t1166, 9
  %t1197 = select i1 %t1196, i8* %t1195, i8* %t1194
  %t1198 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1199 = icmp eq i32 %t1166, 10
  %t1200 = select i1 %t1199, i8* %t1198, i8* %t1197
  %t1201 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1202 = icmp eq i32 %t1166, 11
  %t1203 = select i1 %t1202, i8* %t1201, i8* %t1200
  %t1204 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1205 = icmp eq i32 %t1166, 12
  %t1206 = select i1 %t1205, i8* %t1204, i8* %t1203
  %t1207 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1208 = icmp eq i32 %t1166, 13
  %t1209 = select i1 %t1208, i8* %t1207, i8* %t1206
  %t1210 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1211 = icmp eq i32 %t1166, 14
  %t1212 = select i1 %t1211, i8* %t1210, i8* %t1209
  %t1213 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1214 = icmp eq i32 %t1166, 15
  %t1215 = select i1 %t1214, i8* %t1213, i8* %t1212
  %t1216 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1217 = icmp eq i32 %t1166, 16
  %t1218 = select i1 %t1217, i8* %t1216, i8* %t1215
  %s1219 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h228395909, i32 0, i32 0
  %t1220 = call i1 @strings_equal(i8* %t1218, i8* %s1219)
  %t1221 = load %PythonBuilder, %PythonBuilder* %l0
  %t1222 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1223 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1224 = load i8*, i8** %l3
  %t1225 = load double, double* %l4
  %t1226 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1227 = load double, double* %l6
  %t1228 = load double, double* %l7
  %t1229 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1220, label %then64, label %else65
then64:
  %t1230 = load %PythonBuilder, %PythonBuilder* %l0
  %s1231 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1898426375, i32 0, i32 0
  %t1232 = call %PythonBuilder @builder_emit(%PythonBuilder %t1230, i8* %s1231)
  store %PythonBuilder %t1232, %PythonBuilder* %l0
  %t1233 = load %PythonBuilder, %PythonBuilder* %l0
  %t1234 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t1233)
  store %PythonBuilder %t1234, %PythonBuilder* %l0
  %t1235 = load double, double* %l4
  %t1236 = sitofp i64 1 to double
  %t1237 = fadd double %t1235, %t1236
  store double %t1237, double* %l4
  %t1238 = load %PythonBuilder, %PythonBuilder* %l0
  %t1239 = load %PythonBuilder, %PythonBuilder* %l0
  %t1240 = load double, double* %l4
  br label %merge66
else65:
  %t1241 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1242 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1241, i32 0, i32 0
  %t1243 = load i32, i32* %t1242
  %t1244 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1245 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1246 = icmp eq i32 %t1243, 0
  %t1247 = select i1 %t1246, i8* %t1245, i8* %t1244
  %t1248 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1249 = icmp eq i32 %t1243, 1
  %t1250 = select i1 %t1249, i8* %t1248, i8* %t1247
  %t1251 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1252 = icmp eq i32 %t1243, 2
  %t1253 = select i1 %t1252, i8* %t1251, i8* %t1250
  %t1254 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1255 = icmp eq i32 %t1243, 3
  %t1256 = select i1 %t1255, i8* %t1254, i8* %t1253
  %t1257 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1258 = icmp eq i32 %t1243, 4
  %t1259 = select i1 %t1258, i8* %t1257, i8* %t1256
  %t1260 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1261 = icmp eq i32 %t1243, 5
  %t1262 = select i1 %t1261, i8* %t1260, i8* %t1259
  %t1263 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1264 = icmp eq i32 %t1243, 6
  %t1265 = select i1 %t1264, i8* %t1263, i8* %t1262
  %t1266 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1267 = icmp eq i32 %t1243, 7
  %t1268 = select i1 %t1267, i8* %t1266, i8* %t1265
  %t1269 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1270 = icmp eq i32 %t1243, 8
  %t1271 = select i1 %t1270, i8* %t1269, i8* %t1268
  %t1272 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1273 = icmp eq i32 %t1243, 9
  %t1274 = select i1 %t1273, i8* %t1272, i8* %t1271
  %t1275 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1276 = icmp eq i32 %t1243, 10
  %t1277 = select i1 %t1276, i8* %t1275, i8* %t1274
  %t1278 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1279 = icmp eq i32 %t1243, 11
  %t1280 = select i1 %t1279, i8* %t1278, i8* %t1277
  %t1281 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1282 = icmp eq i32 %t1243, 12
  %t1283 = select i1 %t1282, i8* %t1281, i8* %t1280
  %t1284 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1285 = icmp eq i32 %t1243, 13
  %t1286 = select i1 %t1285, i8* %t1284, i8* %t1283
  %t1287 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1288 = icmp eq i32 %t1243, 14
  %t1289 = select i1 %t1288, i8* %t1287, i8* %t1286
  %t1290 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1291 = icmp eq i32 %t1243, 15
  %t1292 = select i1 %t1291, i8* %t1290, i8* %t1289
  %t1293 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1294 = icmp eq i32 %t1243, 16
  %t1295 = select i1 %t1294, i8* %t1293, i8* %t1292
  %s1296 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h739212033, i32 0, i32 0
  %t1297 = call i1 @strings_equal(i8* %t1295, i8* %s1296)
  %t1298 = load %PythonBuilder, %PythonBuilder* %l0
  %t1299 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1300 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1301 = load i8*, i8** %l3
  %t1302 = load double, double* %l4
  %t1303 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1304 = load double, double* %l6
  %t1305 = load double, double* %l7
  %t1306 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1297, label %then67, label %else68
then67:
  %t1307 = load double, double* %l4
  %t1308 = sitofp i64 0 to double
  %t1309 = fcmp ogt double %t1307, %t1308
  %t1310 = load %PythonBuilder, %PythonBuilder* %l0
  %t1311 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1312 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1313 = load i8*, i8** %l3
  %t1314 = load double, double* %l4
  %t1315 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1316 = load double, double* %l6
  %t1317 = load double, double* %l7
  %t1318 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1309, label %then70, label %else71
then70:
  %t1319 = load %PythonBuilder, %PythonBuilder* %l0
  %t1320 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t1319)
  store %PythonBuilder %t1320, %PythonBuilder* %l0
  %t1321 = load double, double* %l4
  %t1322 = sitofp i64 1 to double
  %t1323 = fsub double %t1321, %t1322
  store double %t1323, double* %l4
  %t1324 = load %PythonBuilder, %PythonBuilder* %l0
  %t1325 = load double, double* %l4
  br label %merge72
else71:
  %t1326 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1327 = extractvalue %NativeFunction %function, 0
  %s1328 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.len29.h1122035900, i32 0, i32 0
  %t1329 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t1326, i8* %t1327, i8* %s1328)
  store { i8**, i64 }* %t1329, { i8**, i64 }** %l1
  %t1330 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge72
merge72:
  %t1331 = phi %PythonBuilder [ %t1324, %then70 ], [ %t1310, %else71 ]
  %t1332 = phi double [ %t1325, %then70 ], [ %t1314, %else71 ]
  %t1333 = phi { i8**, i64 }* [ %t1311, %then70 ], [ %t1330, %else71 ]
  store %PythonBuilder %t1331, %PythonBuilder* %l0
  store double %t1332, double* %l4
  store { i8**, i64 }* %t1333, { i8**, i64 }** %l1
  %t1334 = load %PythonBuilder, %PythonBuilder* %l0
  %t1335 = load double, double* %l4
  %t1336 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge69
else68:
  %t1337 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1338 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1337, i32 0, i32 0
  %t1339 = load i32, i32* %t1338
  %t1340 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1341 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1342 = icmp eq i32 %t1339, 0
  %t1343 = select i1 %t1342, i8* %t1341, i8* %t1340
  %t1344 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1345 = icmp eq i32 %t1339, 1
  %t1346 = select i1 %t1345, i8* %t1344, i8* %t1343
  %t1347 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1348 = icmp eq i32 %t1339, 2
  %t1349 = select i1 %t1348, i8* %t1347, i8* %t1346
  %t1350 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1351 = icmp eq i32 %t1339, 3
  %t1352 = select i1 %t1351, i8* %t1350, i8* %t1349
  %t1353 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1354 = icmp eq i32 %t1339, 4
  %t1355 = select i1 %t1354, i8* %t1353, i8* %t1352
  %t1356 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1357 = icmp eq i32 %t1339, 5
  %t1358 = select i1 %t1357, i8* %t1356, i8* %t1355
  %t1359 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1360 = icmp eq i32 %t1339, 6
  %t1361 = select i1 %t1360, i8* %t1359, i8* %t1358
  %t1362 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1363 = icmp eq i32 %t1339, 7
  %t1364 = select i1 %t1363, i8* %t1362, i8* %t1361
  %t1365 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1366 = icmp eq i32 %t1339, 8
  %t1367 = select i1 %t1366, i8* %t1365, i8* %t1364
  %t1368 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1369 = icmp eq i32 %t1339, 9
  %t1370 = select i1 %t1369, i8* %t1368, i8* %t1367
  %t1371 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1372 = icmp eq i32 %t1339, 10
  %t1373 = select i1 %t1372, i8* %t1371, i8* %t1370
  %t1374 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1375 = icmp eq i32 %t1339, 11
  %t1376 = select i1 %t1375, i8* %t1374, i8* %t1373
  %t1377 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1378 = icmp eq i32 %t1339, 12
  %t1379 = select i1 %t1378, i8* %t1377, i8* %t1376
  %t1380 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1381 = icmp eq i32 %t1339, 13
  %t1382 = select i1 %t1381, i8* %t1380, i8* %t1379
  %t1383 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1384 = icmp eq i32 %t1339, 14
  %t1385 = select i1 %t1384, i8* %t1383, i8* %t1382
  %t1386 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1387 = icmp eq i32 %t1339, 15
  %t1388 = select i1 %t1387, i8* %t1386, i8* %t1385
  %t1389 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1390 = icmp eq i32 %t1339, 16
  %t1391 = select i1 %t1390, i8* %t1389, i8* %t1388
  %s1392 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h706445588, i32 0, i32 0
  %t1393 = call i1 @strings_equal(i8* %t1391, i8* %s1392)
  %t1394 = load %PythonBuilder, %PythonBuilder* %l0
  %t1395 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1396 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1397 = load i8*, i8** %l3
  %t1398 = load double, double* %l4
  %t1399 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1400 = load double, double* %l6
  %t1401 = load double, double* %l7
  %t1402 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1393, label %then73, label %else74
then73:
  %t1403 = load %PythonBuilder, %PythonBuilder* %l0
  %s1404 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1958778164, i32 0, i32 0
  %t1405 = call %PythonBuilder @builder_emit(%PythonBuilder %t1403, i8* %s1404)
  store %PythonBuilder %t1405, %PythonBuilder* %l0
  %t1406 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge75
else74:
  %t1407 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1408 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1407, i32 0, i32 0
  %t1409 = load i32, i32* %t1408
  %t1410 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1411 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1412 = icmp eq i32 %t1409, 0
  %t1413 = select i1 %t1412, i8* %t1411, i8* %t1410
  %t1414 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1415 = icmp eq i32 %t1409, 1
  %t1416 = select i1 %t1415, i8* %t1414, i8* %t1413
  %t1417 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1418 = icmp eq i32 %t1409, 2
  %t1419 = select i1 %t1418, i8* %t1417, i8* %t1416
  %t1420 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1421 = icmp eq i32 %t1409, 3
  %t1422 = select i1 %t1421, i8* %t1420, i8* %t1419
  %t1423 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1424 = icmp eq i32 %t1409, 4
  %t1425 = select i1 %t1424, i8* %t1423, i8* %t1422
  %t1426 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1427 = icmp eq i32 %t1409, 5
  %t1428 = select i1 %t1427, i8* %t1426, i8* %t1425
  %t1429 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1430 = icmp eq i32 %t1409, 6
  %t1431 = select i1 %t1430, i8* %t1429, i8* %t1428
  %t1432 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1433 = icmp eq i32 %t1409, 7
  %t1434 = select i1 %t1433, i8* %t1432, i8* %t1431
  %t1435 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1436 = icmp eq i32 %t1409, 8
  %t1437 = select i1 %t1436, i8* %t1435, i8* %t1434
  %t1438 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1439 = icmp eq i32 %t1409, 9
  %t1440 = select i1 %t1439, i8* %t1438, i8* %t1437
  %t1441 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1442 = icmp eq i32 %t1409, 10
  %t1443 = select i1 %t1442, i8* %t1441, i8* %t1440
  %t1444 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1445 = icmp eq i32 %t1409, 11
  %t1446 = select i1 %t1445, i8* %t1444, i8* %t1443
  %t1447 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1448 = icmp eq i32 %t1409, 12
  %t1449 = select i1 %t1448, i8* %t1447, i8* %t1446
  %t1450 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1451 = icmp eq i32 %t1409, 13
  %t1452 = select i1 %t1451, i8* %t1450, i8* %t1449
  %t1453 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1454 = icmp eq i32 %t1409, 14
  %t1455 = select i1 %t1454, i8* %t1453, i8* %t1452
  %t1456 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1457 = icmp eq i32 %t1409, 15
  %t1458 = select i1 %t1457, i8* %t1456, i8* %t1455
  %t1459 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1460 = icmp eq i32 %t1409, 16
  %t1461 = select i1 %t1460, i8* %t1459, i8* %t1458
  %s1462 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h267355070, i32 0, i32 0
  %t1463 = call i1 @strings_equal(i8* %t1461, i8* %s1462)
  %t1464 = load %PythonBuilder, %PythonBuilder* %l0
  %t1465 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1466 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1467 = load i8*, i8** %l3
  %t1468 = load double, double* %l4
  %t1469 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1470 = load double, double* %l6
  %t1471 = load double, double* %l7
  %t1472 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1463, label %then76, label %else77
then76:
  %t1473 = load %PythonBuilder, %PythonBuilder* %l0
  %s1474 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h528348603, i32 0, i32 0
  %t1475 = call %PythonBuilder @builder_emit(%PythonBuilder %t1473, i8* %s1474)
  store %PythonBuilder %t1475, %PythonBuilder* %l0
  %t1476 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge78
else77:
  %t1477 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1478 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1477, i32 0, i32 0
  %t1479 = load i32, i32* %t1478
  %t1480 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1481 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1482 = icmp eq i32 %t1479, 0
  %t1483 = select i1 %t1482, i8* %t1481, i8* %t1480
  %t1484 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1485 = icmp eq i32 %t1479, 1
  %t1486 = select i1 %t1485, i8* %t1484, i8* %t1483
  %t1487 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1488 = icmp eq i32 %t1479, 2
  %t1489 = select i1 %t1488, i8* %t1487, i8* %t1486
  %t1490 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1491 = icmp eq i32 %t1479, 3
  %t1492 = select i1 %t1491, i8* %t1490, i8* %t1489
  %t1493 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1494 = icmp eq i32 %t1479, 4
  %t1495 = select i1 %t1494, i8* %t1493, i8* %t1492
  %t1496 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1497 = icmp eq i32 %t1479, 5
  %t1498 = select i1 %t1497, i8* %t1496, i8* %t1495
  %t1499 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1500 = icmp eq i32 %t1479, 6
  %t1501 = select i1 %t1500, i8* %t1499, i8* %t1498
  %t1502 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1503 = icmp eq i32 %t1479, 7
  %t1504 = select i1 %t1503, i8* %t1502, i8* %t1501
  %t1505 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1506 = icmp eq i32 %t1479, 8
  %t1507 = select i1 %t1506, i8* %t1505, i8* %t1504
  %t1508 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1509 = icmp eq i32 %t1479, 9
  %t1510 = select i1 %t1509, i8* %t1508, i8* %t1507
  %t1511 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1512 = icmp eq i32 %t1479, 10
  %t1513 = select i1 %t1512, i8* %t1511, i8* %t1510
  %t1514 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1515 = icmp eq i32 %t1479, 11
  %t1516 = select i1 %t1515, i8* %t1514, i8* %t1513
  %t1517 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1518 = icmp eq i32 %t1479, 12
  %t1519 = select i1 %t1518, i8* %t1517, i8* %t1516
  %t1520 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1521 = icmp eq i32 %t1479, 13
  %t1522 = select i1 %t1521, i8* %t1520, i8* %t1519
  %t1523 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1524 = icmp eq i32 %t1479, 14
  %t1525 = select i1 %t1524, i8* %t1523, i8* %t1522
  %t1526 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1527 = icmp eq i32 %t1479, 15
  %t1528 = select i1 %t1527, i8* %t1526, i8* %t1525
  %t1529 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1530 = icmp eq i32 %t1479, 16
  %t1531 = select i1 %t1530, i8* %t1529, i8* %t1528
  %s1532 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1117315388, i32 0, i32 0
  %t1533 = call i1 @strings_equal(i8* %t1531, i8* %s1532)
  %t1534 = load %PythonBuilder, %PythonBuilder* %l0
  %t1535 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1536 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1537 = load i8*, i8** %l3
  %t1538 = load double, double* %l4
  %t1539 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1540 = load double, double* %l6
  %t1541 = load double, double* %l7
  %t1542 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1533, label %then79, label %else80
then79:
  %t1543 = load double, double* %l6
  %t1544 = call i8* @generate_match_subject_name(double %t1543)
  store i8* %t1544, i8** %l25
  %t1545 = load double, double* %l6
  %t1546 = sitofp i64 1 to double
  %t1547 = fadd double %t1545, %t1546
  store double %t1547, double* %l6
  %t1548 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1549 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1548, i32 0, i32 0
  %t1550 = load i32, i32* %t1549
  %t1551 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1548, i32 0, i32 1
  %t1552 = bitcast [16 x i8]* %t1551 to i8*
  %t1553 = bitcast i8* %t1552 to i8**
  %t1554 = load i8*, i8** %t1553
  %t1555 = icmp eq i32 %t1550, 0
  %t1556 = select i1 %t1555, i8* %t1554, i8* null
  %t1557 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1548, i32 0, i32 1
  %t1558 = bitcast [16 x i8]* %t1557 to i8*
  %t1559 = bitcast i8* %t1558 to i8**
  %t1560 = load i8*, i8** %t1559
  %t1561 = icmp eq i32 %t1550, 1
  %t1562 = select i1 %t1561, i8* %t1560, i8* %t1556
  %t1563 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1548, i32 0, i32 1
  %t1564 = bitcast [8 x i8]* %t1563 to i8*
  %t1565 = bitcast i8* %t1564 to i8**
  %t1566 = load i8*, i8** %t1565
  %t1567 = icmp eq i32 %t1550, 12
  %t1568 = select i1 %t1567, i8* %t1566, i8* %t1562
  %t1569 = call i8* @lower_expression(i8* %t1568)
  store i8* %t1569, i8** %l26
  %t1570 = load %PythonBuilder, %PythonBuilder* %l0
  %t1571 = load i8*, i8** %l25
  %s1572 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087691079, i32 0, i32 0
  %t1573 = call i8* @sailfin_runtime_string_concat(i8* %t1571, i8* %s1572)
  %t1574 = load i8*, i8** %l26
  %t1575 = call i8* @sailfin_runtime_string_concat(i8* %t1573, i8* %t1574)
  %t1576 = call %PythonBuilder @builder_emit(%PythonBuilder %t1570, i8* %t1575)
  store %PythonBuilder %t1576, %PythonBuilder* %l0
  %t1577 = load i8*, i8** %l25
  %t1578 = insertvalue %MatchContext undef, i8* %t1577, 0
  %t1579 = sitofp i64 0 to double
  %t1580 = insertvalue %MatchContext %t1578, double %t1579, 1
  %t1581 = insertvalue %MatchContext %t1580, i1 0, 2
  store %MatchContext %t1581, %MatchContext* %l27
  %t1582 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1583 = load %MatchContext, %MatchContext* %l27
  %t1584 = call { %MatchContext*, i64 }* @append_match_context({ %MatchContext*, i64 }* %t1582, %MatchContext %t1583)
  store { %MatchContext*, i64 }* %t1584, { %MatchContext*, i64 }** %l5
  %t1585 = load double, double* %l6
  %t1586 = load %PythonBuilder, %PythonBuilder* %l0
  %t1587 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  br label %merge81
else80:
  %t1588 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1589 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1588, i32 0, i32 0
  %t1590 = load i32, i32* %t1589
  %t1591 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1592 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1593 = icmp eq i32 %t1590, 0
  %t1594 = select i1 %t1593, i8* %t1592, i8* %t1591
  %t1595 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1596 = icmp eq i32 %t1590, 1
  %t1597 = select i1 %t1596, i8* %t1595, i8* %t1594
  %t1598 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1599 = icmp eq i32 %t1590, 2
  %t1600 = select i1 %t1599, i8* %t1598, i8* %t1597
  %t1601 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1602 = icmp eq i32 %t1590, 3
  %t1603 = select i1 %t1602, i8* %t1601, i8* %t1600
  %t1604 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1605 = icmp eq i32 %t1590, 4
  %t1606 = select i1 %t1605, i8* %t1604, i8* %t1603
  %t1607 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1608 = icmp eq i32 %t1590, 5
  %t1609 = select i1 %t1608, i8* %t1607, i8* %t1606
  %t1610 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1611 = icmp eq i32 %t1590, 6
  %t1612 = select i1 %t1611, i8* %t1610, i8* %t1609
  %t1613 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1614 = icmp eq i32 %t1590, 7
  %t1615 = select i1 %t1614, i8* %t1613, i8* %t1612
  %t1616 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1617 = icmp eq i32 %t1590, 8
  %t1618 = select i1 %t1617, i8* %t1616, i8* %t1615
  %t1619 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1620 = icmp eq i32 %t1590, 9
  %t1621 = select i1 %t1620, i8* %t1619, i8* %t1618
  %t1622 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1623 = icmp eq i32 %t1590, 10
  %t1624 = select i1 %t1623, i8* %t1622, i8* %t1621
  %t1625 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1626 = icmp eq i32 %t1590, 11
  %t1627 = select i1 %t1626, i8* %t1625, i8* %t1624
  %t1628 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1629 = icmp eq i32 %t1590, 12
  %t1630 = select i1 %t1629, i8* %t1628, i8* %t1627
  %t1631 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1632 = icmp eq i32 %t1590, 13
  %t1633 = select i1 %t1632, i8* %t1631, i8* %t1630
  %t1634 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1635 = icmp eq i32 %t1590, 14
  %t1636 = select i1 %t1635, i8* %t1634, i8* %t1633
  %t1637 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1638 = icmp eq i32 %t1590, 15
  %t1639 = select i1 %t1638, i8* %t1637, i8* %t1636
  %t1640 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1641 = icmp eq i32 %t1590, 16
  %t1642 = select i1 %t1641, i8* %t1640, i8* %t1639
  %s1643 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h217223495, i32 0, i32 0
  %t1644 = call i1 @strings_equal(i8* %t1642, i8* %s1643)
  %t1645 = load %PythonBuilder, %PythonBuilder* %l0
  %t1646 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1647 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1648 = load i8*, i8** %l3
  %t1649 = load double, double* %l4
  %t1650 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1651 = load double, double* %l6
  %t1652 = load double, double* %l7
  %t1653 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1644, label %then82, label %else83
then82:
  %t1654 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1655 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t1654
  %t1656 = extractvalue { %MatchContext*, i64 } %t1655, 1
  %t1657 = icmp eq i64 %t1656, 0
  %t1658 = load %PythonBuilder, %PythonBuilder* %l0
  %t1659 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1660 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1661 = load i8*, i8** %l3
  %t1662 = load double, double* %l4
  %t1663 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1664 = load double, double* %l6
  %t1665 = load double, double* %l7
  %t1666 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1657, label %then85, label %else86
then85:
  %t1667 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1668 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1667, i32 0, i32 0
  %t1669 = load i32, i32* %t1668
  %t1670 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1667, i32 0, i32 1
  %t1671 = bitcast [16 x i8]* %t1670 to i8*
  %t1672 = bitcast i8* %t1671 to i8**
  %t1673 = load i8*, i8** %t1672
  %t1674 = icmp eq i32 %t1669, 13
  %t1675 = select i1 %t1674, i8* %t1673, i8* null
  %t1676 = call i8* @trim_text(i8* %t1675)
  store i8* %t1676, i8** %l28
  %s1677 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.len39.h2079567388, i32 0, i32 0
  store i8* %s1677, i8** %l29
  %t1678 = load i8*, i8** %l28
  %t1679 = call i64 @sailfin_runtime_string_length(i8* %t1678)
  %t1680 = icmp sgt i64 %t1679, 0
  %t1681 = load %PythonBuilder, %PythonBuilder* %l0
  %t1682 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1683 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1684 = load i8*, i8** %l3
  %t1685 = load double, double* %l4
  %t1686 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1687 = load double, double* %l6
  %t1688 = load double, double* %l7
  %t1689 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1690 = load i8*, i8** %l28
  %t1691 = load i8*, i8** %l29
  br i1 %t1680, label %then88, label %merge89
then88:
  %t1692 = load i8*, i8** %l29
  %s1693 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1460619898, i32 0, i32 0
  %t1694 = call i8* @sailfin_runtime_string_concat(i8* %t1692, i8* %s1693)
  %t1695 = load i8*, i8** %l28
  %t1696 = call i8* @sailfin_runtime_string_concat(i8* %t1694, i8* %t1695)
  %t1697 = alloca [2 x i8], align 1
  %t1698 = getelementptr [2 x i8], [2 x i8]* %t1697, i32 0, i32 0
  store i8 41, i8* %t1698
  %t1699 = getelementptr [2 x i8], [2 x i8]* %t1697, i32 0, i32 1
  store i8 0, i8* %t1699
  %t1700 = getelementptr [2 x i8], [2 x i8]* %t1697, i32 0, i32 0
  %t1701 = call i8* @sailfin_runtime_string_concat(i8* %t1696, i8* %t1700)
  store i8* %t1701, i8** %l29
  %t1702 = load i8*, i8** %l29
  br label %merge89
merge89:
  %t1703 = phi i8* [ %t1702, %then88 ], [ %t1691, %then85 ]
  store i8* %t1703, i8** %l29
  %t1704 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1705 = extractvalue %NativeFunction %function, 0
  %t1706 = load i8*, i8** %l29
  %t1707 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t1704, i8* %t1705, i8* %t1706)
  store { i8**, i64 }* %t1707, { i8**, i64 }** %l1
  %t1708 = load %PythonBuilder, %PythonBuilder* %l0
  %s1709 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.len41.h1804821690, i32 0, i32 0
  %t1710 = call %PythonBuilder @builder_emit(%PythonBuilder %t1708, i8* %s1709)
  store %PythonBuilder %t1710, %PythonBuilder* %l0
  %t1711 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1712 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge87
else86:
  %t1713 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1714 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t1713
  %t1715 = extractvalue { %MatchContext*, i64 } %t1714, 1
  %t1716 = sub i64 %t1715, 1
  store i64 %t1716, i64* %l30
  %t1717 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1718 = load i64, i64* %l30
  %t1719 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t1717
  %t1720 = extractvalue { %MatchContext*, i64 } %t1719, 0
  %t1721 = extractvalue { %MatchContext*, i64 } %t1719, 1
  %t1722 = icmp uge i64 %t1718, %t1721
  ; bounds check: %t1722 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t1718, i64 %t1721)
  %t1723 = getelementptr %MatchContext, %MatchContext* %t1720, i64 %t1718
  %t1724 = load %MatchContext, %MatchContext* %t1723
  store %MatchContext %t1724, %MatchContext* %l31
  %t1725 = load %MatchContext, %MatchContext* %l31
  %t1726 = extractvalue %MatchContext %t1725, 2
  %t1727 = load %PythonBuilder, %PythonBuilder* %l0
  %t1728 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1729 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1730 = load i8*, i8** %l3
  %t1731 = load double, double* %l4
  %t1732 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1733 = load double, double* %l6
  %t1734 = load double, double* %l7
  %t1735 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1736 = load i64, i64* %l30
  %t1737 = load %MatchContext, %MatchContext* %l31
  br i1 %t1726, label %then90, label %merge91
then90:
  %t1738 = load %PythonBuilder, %PythonBuilder* %l0
  %t1739 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t1738)
  store %PythonBuilder %t1739, %PythonBuilder* %l0
  %t1740 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge91
merge91:
  %t1741 = phi %PythonBuilder [ %t1740, %then90 ], [ %t1727, %else86 ]
  store %PythonBuilder %t1741, %PythonBuilder* %l0
  %t1742 = load %MatchContext, %MatchContext* %l31
  %t1743 = extractvalue %MatchContext %t1742, 0
  %t1744 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1745 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1744, i32 0, i32 0
  %t1746 = load i32, i32* %t1745
  %t1747 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1744, i32 0, i32 1
  %t1748 = bitcast [16 x i8]* %t1747 to i8*
  %t1749 = bitcast i8* %t1748 to i8**
  %t1750 = load i8*, i8** %t1749
  %t1751 = icmp eq i32 %t1746, 13
  %t1752 = select i1 %t1751, i8* %t1750, i8* null
  %t1753 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1754 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1753, i32 0, i32 0
  %t1755 = load i32, i32* %t1754
  %t1756 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1753, i32 0, i32 1
  %t1757 = bitcast [16 x i8]* %t1756 to i8*
  %t1758 = getelementptr inbounds i8, i8* %t1757, i64 8
  %t1759 = bitcast i8* %t1758 to i8**
  %t1760 = load i8*, i8** %t1759
  %t1761 = icmp eq i32 %t1755, 13
  %t1762 = select i1 %t1761, i8* %t1760, i8* null
  %t1763 = call %LoweredCaseCondition @lower_match_case_condition(i8* %t1743, i8* %t1752, i8* %t1762)
  store %LoweredCaseCondition %t1763, %LoweredCaseCondition* %l32
  %t1764 = load %MatchContext, %MatchContext* %l31
  %t1765 = extractvalue %MatchContext %t1764, 1
  %t1766 = sitofp i64 0 to double
  %t1767 = fcmp oeq double %t1765, %t1766
  %t1768 = load %PythonBuilder, %PythonBuilder* %l0
  %t1769 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1770 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1771 = load i8*, i8** %l3
  %t1772 = load double, double* %l4
  %t1773 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1774 = load double, double* %l6
  %t1775 = load double, double* %l7
  %t1776 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1777 = load i64, i64* %l30
  %t1778 = load %MatchContext, %MatchContext* %l31
  %t1779 = load %LoweredCaseCondition, %LoweredCaseCondition* %l32
  br i1 %t1767, label %then92, label %else93
then92:
  %t1780 = load %PythonBuilder, %PythonBuilder* %l0
  %s1781 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2090359129, i32 0, i32 0
  %t1782 = load %LoweredCaseCondition, %LoweredCaseCondition* %l32
  %t1783 = extractvalue %LoweredCaseCondition %t1782, 0
  %t1784 = call i8* @sailfin_runtime_string_concat(i8* %s1781, i8* %t1783)
  %t1785 = alloca [2 x i8], align 1
  %t1786 = getelementptr [2 x i8], [2 x i8]* %t1785, i32 0, i32 0
  store i8 58, i8* %t1786
  %t1787 = getelementptr [2 x i8], [2 x i8]* %t1785, i32 0, i32 1
  store i8 0, i8* %t1787
  %t1788 = getelementptr [2 x i8], [2 x i8]* %t1785, i32 0, i32 0
  %t1789 = call i8* @sailfin_runtime_string_concat(i8* %t1784, i8* %t1788)
  %t1790 = call %PythonBuilder @builder_emit(%PythonBuilder %t1780, i8* %t1789)
  store %PythonBuilder %t1790, %PythonBuilder* %l0
  %t1791 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge94
else93:
  %t1793 = load %LoweredCaseCondition, %LoweredCaseCondition* %l32
  %t1794 = extractvalue %LoweredCaseCondition %t1793, 1
  br label %logical_and_entry_1792

logical_and_entry_1792:
  br i1 %t1794, label %logical_and_right_1792, label %logical_and_merge_1792

logical_and_right_1792:
  %t1795 = load %LoweredCaseCondition, %LoweredCaseCondition* %l32
  %t1796 = extractvalue %LoweredCaseCondition %t1795, 2
  %t1797 = xor i1 %t1796, 1
  br label %logical_and_right_end_1792

logical_and_right_end_1792:
  br label %logical_and_merge_1792

logical_and_merge_1792:
  %t1798 = phi i1 [ false, %logical_and_entry_1792 ], [ %t1797, %logical_and_right_end_1792 ]
  %t1799 = load %PythonBuilder, %PythonBuilder* %l0
  %t1800 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1801 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1802 = load i8*, i8** %l3
  %t1803 = load double, double* %l4
  %t1804 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1805 = load double, double* %l6
  %t1806 = load double, double* %l7
  %t1807 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1808 = load i64, i64* %l30
  %t1809 = load %MatchContext, %MatchContext* %l31
  %t1810 = load %LoweredCaseCondition, %LoweredCaseCondition* %l32
  br i1 %t1798, label %then95, label %else96
then95:
  %t1811 = load %PythonBuilder, %PythonBuilder* %l0
  %s1812 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2069574674, i32 0, i32 0
  %t1813 = call %PythonBuilder @builder_emit(%PythonBuilder %t1811, i8* %s1812)
  store %PythonBuilder %t1813, %PythonBuilder* %l0
  %t1814 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge97
else96:
  %t1815 = load %PythonBuilder, %PythonBuilder* %l0
  %s1816 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2069215535, i32 0, i32 0
  %t1817 = load %LoweredCaseCondition, %LoweredCaseCondition* %l32
  %t1818 = extractvalue %LoweredCaseCondition %t1817, 0
  %t1819 = call i8* @sailfin_runtime_string_concat(i8* %s1816, i8* %t1818)
  %t1820 = alloca [2 x i8], align 1
  %t1821 = getelementptr [2 x i8], [2 x i8]* %t1820, i32 0, i32 0
  store i8 58, i8* %t1821
  %t1822 = getelementptr [2 x i8], [2 x i8]* %t1820, i32 0, i32 1
  store i8 0, i8* %t1822
  %t1823 = getelementptr [2 x i8], [2 x i8]* %t1820, i32 0, i32 0
  %t1824 = call i8* @sailfin_runtime_string_concat(i8* %t1819, i8* %t1823)
  %t1825 = call %PythonBuilder @builder_emit(%PythonBuilder %t1815, i8* %t1824)
  store %PythonBuilder %t1825, %PythonBuilder* %l0
  %t1826 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge97
merge97:
  %t1827 = phi %PythonBuilder [ %t1814, %then95 ], [ %t1826, %else96 ]
  store %PythonBuilder %t1827, %PythonBuilder* %l0
  %t1828 = load %PythonBuilder, %PythonBuilder* %l0
  %t1829 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge94
merge94:
  %t1830 = phi %PythonBuilder [ %t1791, %then92 ], [ %t1828, %merge97 ]
  store %PythonBuilder %t1830, %PythonBuilder* %l0
  %t1831 = load %PythonBuilder, %PythonBuilder* %l0
  %t1832 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t1831)
  store %PythonBuilder %t1832, %PythonBuilder* %l0
  %t1833 = load %MatchContext, %MatchContext* %l31
  %t1834 = extractvalue %MatchContext %t1833, 0
  %t1835 = insertvalue %MatchContext undef, i8* %t1834, 0
  %t1836 = load %MatchContext, %MatchContext* %l31
  %t1837 = extractvalue %MatchContext %t1836, 1
  %t1838 = sitofp i64 1 to double
  %t1839 = fadd double %t1837, %t1838
  %t1840 = insertvalue %MatchContext %t1835, double %t1839, 1
  %t1841 = insertvalue %MatchContext %t1840, i1 1, 2
  store %MatchContext %t1841, %MatchContext* %l33
  %t1842 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1843 = load i64, i64* %l30
  %t1844 = load %MatchContext, %MatchContext* %l33
  %t1845 = sitofp i64 %t1843 to double
  %t1846 = call { %MatchContext*, i64 }* @replace_match_context({ %MatchContext*, i64 }* %t1842, double %t1845, %MatchContext %t1844)
  store { %MatchContext*, i64 }* %t1846, { %MatchContext*, i64 }** %l5
  %t1847 = load %PythonBuilder, %PythonBuilder* %l0
  %t1848 = load %PythonBuilder, %PythonBuilder* %l0
  %t1849 = load %PythonBuilder, %PythonBuilder* %l0
  %t1850 = load %PythonBuilder, %PythonBuilder* %l0
  %t1851 = load %PythonBuilder, %PythonBuilder* %l0
  %t1852 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  br label %merge87
merge87:
  %t1853 = phi { i8**, i64 }* [ %t1711, %merge89 ], [ %t1659, %merge94 ]
  %t1854 = phi %PythonBuilder [ %t1712, %merge89 ], [ %t1847, %merge94 ]
  %t1855 = phi { %MatchContext*, i64 }* [ %t1663, %merge89 ], [ %t1852, %merge94 ]
  store { i8**, i64 }* %t1853, { i8**, i64 }** %l1
  store %PythonBuilder %t1854, %PythonBuilder* %l0
  store { %MatchContext*, i64 }* %t1855, { %MatchContext*, i64 }** %l5
  %t1856 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1857 = load %PythonBuilder, %PythonBuilder* %l0
  %t1858 = load %PythonBuilder, %PythonBuilder* %l0
  %t1859 = load %PythonBuilder, %PythonBuilder* %l0
  %t1860 = load %PythonBuilder, %PythonBuilder* %l0
  %t1861 = load %PythonBuilder, %PythonBuilder* %l0
  %t1862 = load %PythonBuilder, %PythonBuilder* %l0
  %t1863 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  br label %merge84
else83:
  %t1864 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1865 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1864, i32 0, i32 0
  %t1866 = load i32, i32* %t1865
  %t1867 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1868 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1869 = icmp eq i32 %t1866, 0
  %t1870 = select i1 %t1869, i8* %t1868, i8* %t1867
  %t1871 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1872 = icmp eq i32 %t1866, 1
  %t1873 = select i1 %t1872, i8* %t1871, i8* %t1870
  %t1874 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1875 = icmp eq i32 %t1866, 2
  %t1876 = select i1 %t1875, i8* %t1874, i8* %t1873
  %t1877 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1878 = icmp eq i32 %t1866, 3
  %t1879 = select i1 %t1878, i8* %t1877, i8* %t1876
  %t1880 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1881 = icmp eq i32 %t1866, 4
  %t1882 = select i1 %t1881, i8* %t1880, i8* %t1879
  %t1883 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1884 = icmp eq i32 %t1866, 5
  %t1885 = select i1 %t1884, i8* %t1883, i8* %t1882
  %t1886 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1887 = icmp eq i32 %t1866, 6
  %t1888 = select i1 %t1887, i8* %t1886, i8* %t1885
  %t1889 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1890 = icmp eq i32 %t1866, 7
  %t1891 = select i1 %t1890, i8* %t1889, i8* %t1888
  %t1892 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1893 = icmp eq i32 %t1866, 8
  %t1894 = select i1 %t1893, i8* %t1892, i8* %t1891
  %t1895 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1896 = icmp eq i32 %t1866, 9
  %t1897 = select i1 %t1896, i8* %t1895, i8* %t1894
  %t1898 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1899 = icmp eq i32 %t1866, 10
  %t1900 = select i1 %t1899, i8* %t1898, i8* %t1897
  %t1901 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1902 = icmp eq i32 %t1866, 11
  %t1903 = select i1 %t1902, i8* %t1901, i8* %t1900
  %t1904 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1905 = icmp eq i32 %t1866, 12
  %t1906 = select i1 %t1905, i8* %t1904, i8* %t1903
  %t1907 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1908 = icmp eq i32 %t1866, 13
  %t1909 = select i1 %t1908, i8* %t1907, i8* %t1906
  %t1910 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1911 = icmp eq i32 %t1866, 14
  %t1912 = select i1 %t1911, i8* %t1910, i8* %t1909
  %t1913 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1914 = icmp eq i32 %t1866, 15
  %t1915 = select i1 %t1914, i8* %t1913, i8* %t1912
  %t1916 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1917 = icmp eq i32 %t1866, 16
  %t1918 = select i1 %t1917, i8* %t1916, i8* %t1915
  %s1919 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h794378208, i32 0, i32 0
  %t1920 = call i1 @strings_equal(i8* %t1918, i8* %s1919)
  %t1921 = load %PythonBuilder, %PythonBuilder* %l0
  %t1922 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1923 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1924 = load i8*, i8** %l3
  %t1925 = load double, double* %l4
  %t1926 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1927 = load double, double* %l6
  %t1928 = load double, double* %l7
  %t1929 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1920, label %then98, label %else99
then98:
  %t1930 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1931 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t1930
  %t1932 = extractvalue { %MatchContext*, i64 } %t1931, 1
  %t1933 = icmp eq i64 %t1932, 0
  %t1934 = load %PythonBuilder, %PythonBuilder* %l0
  %t1935 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1936 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1937 = load i8*, i8** %l3
  %t1938 = load double, double* %l4
  %t1939 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1940 = load double, double* %l6
  %t1941 = load double, double* %l7
  %t1942 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1933, label %then101, label %else102
then101:
  %t1943 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1944 = extractvalue %NativeFunction %function, 0
  %s1945 = getelementptr inbounds [38 x i8], [38 x i8]* @.str.len37.h314404344, i32 0, i32 0
  %t1946 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t1943, i8* %t1944, i8* %s1945)
  store { i8**, i64 }* %t1946, { i8**, i64 }** %l1
  %t1947 = load %PythonBuilder, %PythonBuilder* %l0
  %s1948 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.len39.h198700275, i32 0, i32 0
  %t1949 = call %PythonBuilder @builder_emit(%PythonBuilder %t1947, i8* %s1948)
  store %PythonBuilder %t1949, %PythonBuilder* %l0
  %t1950 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1951 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge103
else102:
  %t1952 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1953 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t1952
  %t1954 = extractvalue { %MatchContext*, i64 } %t1953, 1
  %t1955 = sub i64 %t1954, 1
  store i64 %t1955, i64* %l34
  %t1956 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1957 = load i64, i64* %l34
  %t1958 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t1956
  %t1959 = extractvalue { %MatchContext*, i64 } %t1958, 0
  %t1960 = extractvalue { %MatchContext*, i64 } %t1958, 1
  %t1961 = icmp uge i64 %t1957, %t1960
  ; bounds check: %t1961 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t1957, i64 %t1960)
  %t1962 = getelementptr %MatchContext, %MatchContext* %t1959, i64 %t1957
  %t1963 = load %MatchContext, %MatchContext* %t1962
  store %MatchContext %t1963, %MatchContext* %l35
  %t1964 = load %MatchContext, %MatchContext* %l35
  %t1965 = extractvalue %MatchContext %t1964, 2
  %t1966 = load %PythonBuilder, %PythonBuilder* %l0
  %t1967 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1968 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1969 = load i8*, i8** %l3
  %t1970 = load double, double* %l4
  %t1971 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1972 = load double, double* %l6
  %t1973 = load double, double* %l7
  %t1974 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1975 = load i64, i64* %l34
  %t1976 = load %MatchContext, %MatchContext* %l35
  br i1 %t1965, label %then104, label %merge105
then104:
  %t1977 = load %PythonBuilder, %PythonBuilder* %l0
  %t1978 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t1977)
  store %PythonBuilder %t1978, %PythonBuilder* %l0
  %t1979 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge105
merge105:
  %t1980 = phi %PythonBuilder [ %t1979, %then104 ], [ %t1966, %else102 ]
  store %PythonBuilder %t1980, %PythonBuilder* %l0
  %t1981 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1982 = load i64, i64* %l34
  %t1983 = sitofp i64 %t1982 to double
  %t1984 = call { %MatchContext*, i64 }* @truncate_match_contexts({ %MatchContext*, i64 }* %t1981, double %t1983)
  store { %MatchContext*, i64 }* %t1984, { %MatchContext*, i64 }** %l5
  %t1985 = load %PythonBuilder, %PythonBuilder* %l0
  %t1986 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  br label %merge103
merge103:
  %t1987 = phi { i8**, i64 }* [ %t1950, %then101 ], [ %t1935, %merge105 ]
  %t1988 = phi %PythonBuilder [ %t1951, %then101 ], [ %t1985, %merge105 ]
  %t1989 = phi { %MatchContext*, i64 }* [ %t1939, %then101 ], [ %t1986, %merge105 ]
  store { i8**, i64 }* %t1987, { i8**, i64 }** %l1
  store %PythonBuilder %t1988, %PythonBuilder* %l0
  store { %MatchContext*, i64 }* %t1989, { %MatchContext*, i64 }** %l5
  %t1990 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1991 = load %PythonBuilder, %PythonBuilder* %l0
  %t1992 = load %PythonBuilder, %PythonBuilder* %l0
  %t1993 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  br label %merge100
else99:
  %t1994 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1995 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1994, i32 0, i32 0
  %t1996 = load i32, i32* %t1995
  %t1997 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1998 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1999 = icmp eq i32 %t1996, 0
  %t2000 = select i1 %t1999, i8* %t1998, i8* %t1997
  %t2001 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t2002 = icmp eq i32 %t1996, 1
  %t2003 = select i1 %t2002, i8* %t2001, i8* %t2000
  %t2004 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t2005 = icmp eq i32 %t1996, 2
  %t2006 = select i1 %t2005, i8* %t2004, i8* %t2003
  %t2007 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t2008 = icmp eq i32 %t1996, 3
  %t2009 = select i1 %t2008, i8* %t2007, i8* %t2006
  %t2010 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t2011 = icmp eq i32 %t1996, 4
  %t2012 = select i1 %t2011, i8* %t2010, i8* %t2009
  %t2013 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t2014 = icmp eq i32 %t1996, 5
  %t2015 = select i1 %t2014, i8* %t2013, i8* %t2012
  %t2016 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t2017 = icmp eq i32 %t1996, 6
  %t2018 = select i1 %t2017, i8* %t2016, i8* %t2015
  %t2019 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t2020 = icmp eq i32 %t1996, 7
  %t2021 = select i1 %t2020, i8* %t2019, i8* %t2018
  %t2022 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t2023 = icmp eq i32 %t1996, 8
  %t2024 = select i1 %t2023, i8* %t2022, i8* %t2021
  %t2025 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t2026 = icmp eq i32 %t1996, 9
  %t2027 = select i1 %t2026, i8* %t2025, i8* %t2024
  %t2028 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t2029 = icmp eq i32 %t1996, 10
  %t2030 = select i1 %t2029, i8* %t2028, i8* %t2027
  %t2031 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t2032 = icmp eq i32 %t1996, 11
  %t2033 = select i1 %t2032, i8* %t2031, i8* %t2030
  %t2034 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t2035 = icmp eq i32 %t1996, 12
  %t2036 = select i1 %t2035, i8* %t2034, i8* %t2033
  %t2037 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t2038 = icmp eq i32 %t1996, 13
  %t2039 = select i1 %t2038, i8* %t2037, i8* %t2036
  %t2040 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t2041 = icmp eq i32 %t1996, 14
  %t2042 = select i1 %t2041, i8* %t2040, i8* %t2039
  %t2043 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t2044 = icmp eq i32 %t1996, 15
  %t2045 = select i1 %t2044, i8* %t2043, i8* %t2042
  %t2046 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t2047 = icmp eq i32 %t1996, 16
  %t2048 = select i1 %t2047, i8* %t2046, i8* %t2045
  %s2049 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h230767751, i32 0, i32 0
  %t2050 = call i1 @strings_equal(i8* %t2048, i8* %s2049)
  %t2051 = load %PythonBuilder, %PythonBuilder* %l0
  %t2052 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2053 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2054 = load i8*, i8** %l3
  %t2055 = load double, double* %l4
  %t2056 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2057 = load double, double* %l6
  %t2058 = load double, double* %l7
  %t2059 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t2050, label %then106, label %else107
then106:
  %t2060 = load %PythonBuilder, %PythonBuilder* %l0
  %s2061 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h270590402, i32 0, i32 0
  %t2062 = call %PythonBuilder @builder_emit(%PythonBuilder %t2060, i8* %s2061)
  store %PythonBuilder %t2062, %PythonBuilder* %l0
  %t2063 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge108
else107:
  %t2064 = load %NativeInstruction*, %NativeInstruction** %l8
  %t2065 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t2064, i32 0, i32 0
  %t2066 = load i32, i32* %t2065
  %t2067 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t2064, i32 0, i32 1
  %t2068 = bitcast [8 x i8]* %t2067 to i8*
  %t2069 = bitcast i8* %t2068 to i8**
  %t2070 = load i8*, i8** %t2069
  %t2071 = icmp eq i32 %t2066, 16
  %t2072 = select i1 %t2071, i8* %t2070, i8* null
  %t2073 = call i8* @trim_text(i8* %t2072)
  store i8* %t2073, i8** %l36
  %s2074 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.len42.h9444846, i32 0, i32 0
  store i8* %s2074, i8** %l37
  %t2075 = load i8*, i8** %l36
  %t2076 = call i64 @sailfin_runtime_string_length(i8* %t2075)
  %t2077 = icmp sgt i64 %t2076, 0
  %t2078 = load %PythonBuilder, %PythonBuilder* %l0
  %t2079 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2080 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2081 = load i8*, i8** %l3
  %t2082 = load double, double* %l4
  %t2083 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2084 = load double, double* %l6
  %t2085 = load double, double* %l7
  %t2086 = load %NativeInstruction*, %NativeInstruction** %l8
  %t2087 = load i8*, i8** %l36
  %t2088 = load i8*, i8** %l37
  br i1 %t2077, label %then109, label %merge110
then109:
  %t2089 = load i8*, i8** %l37
  %s2090 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193441217, i32 0, i32 0
  %t2091 = call i8* @sailfin_runtime_string_concat(i8* %t2089, i8* %s2090)
  %t2092 = load i8*, i8** %l36
  %t2093 = call i8* @sailfin_runtime_string_concat(i8* %t2091, i8* %t2092)
  store i8* %t2093, i8** %l37
  %t2094 = load i8*, i8** %l37
  br label %merge110
merge110:
  %t2095 = phi i8* [ %t2094, %then109 ], [ %t2088, %else107 ]
  store i8* %t2095, i8** %l37
  %t2096 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2097 = extractvalue %NativeFunction %function, 0
  %t2098 = load i8*, i8** %l37
  %t2099 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t2096, i8* %t2097, i8* %t2098)
  store { i8**, i64 }* %t2099, { i8**, i64 }** %l1
  %t2100 = load %PythonBuilder, %PythonBuilder* %l0
  %s2101 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h1983072220, i32 0, i32 0
  %t2102 = load %NativeInstruction*, %NativeInstruction** %l8
  %t2103 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t2102, i32 0, i32 0
  %t2104 = load i32, i32* %t2103
  %t2105 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t2102, i32 0, i32 1
  %t2106 = bitcast [8 x i8]* %t2105 to i8*
  %t2107 = bitcast i8* %t2106 to i8**
  %t2108 = load i8*, i8** %t2107
  %t2109 = icmp eq i32 %t2104, 16
  %t2110 = select i1 %t2109, i8* %t2108, i8* null
  %t2111 = call i8* @sailfin_runtime_string_concat(i8* %s2101, i8* %t2110)
  %t2112 = call %PythonBuilder @builder_emit(%PythonBuilder %t2100, i8* %t2111)
  store %PythonBuilder %t2112, %PythonBuilder* %l0
  %t2113 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2114 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge108
merge108:
  %t2115 = phi %PythonBuilder [ %t2063, %then106 ], [ %t2114, %merge110 ]
  %t2116 = phi { i8**, i64 }* [ %t2052, %then106 ], [ %t2113, %merge110 ]
  store %PythonBuilder %t2115, %PythonBuilder* %l0
  store { i8**, i64 }* %t2116, { i8**, i64 }** %l1
  %t2117 = load %PythonBuilder, %PythonBuilder* %l0
  %t2118 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2119 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge100
merge100:
  %t2120 = phi { i8**, i64 }* [ %t1990, %merge103 ], [ %t2118, %merge108 ]
  %t2121 = phi %PythonBuilder [ %t1991, %merge103 ], [ %t2117, %merge108 ]
  %t2122 = phi { %MatchContext*, i64 }* [ %t1993, %merge103 ], [ %t1926, %merge108 ]
  store { i8**, i64 }* %t2120, { i8**, i64 }** %l1
  store %PythonBuilder %t2121, %PythonBuilder* %l0
  store { %MatchContext*, i64 }* %t2122, { %MatchContext*, i64 }** %l5
  %t2123 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2124 = load %PythonBuilder, %PythonBuilder* %l0
  %t2125 = load %PythonBuilder, %PythonBuilder* %l0
  %t2126 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2127 = load %PythonBuilder, %PythonBuilder* %l0
  %t2128 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2129 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge84
merge84:
  %t2130 = phi { i8**, i64 }* [ %t1856, %merge87 ], [ %t2123, %merge100 ]
  %t2131 = phi %PythonBuilder [ %t1857, %merge87 ], [ %t2124, %merge100 ]
  %t2132 = phi { %MatchContext*, i64 }* [ %t1863, %merge87 ], [ %t2126, %merge100 ]
  store { i8**, i64 }* %t2130, { i8**, i64 }** %l1
  store %PythonBuilder %t2131, %PythonBuilder* %l0
  store { %MatchContext*, i64 }* %t2132, { %MatchContext*, i64 }** %l5
  %t2133 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2134 = load %PythonBuilder, %PythonBuilder* %l0
  %t2135 = load %PythonBuilder, %PythonBuilder* %l0
  %t2136 = load %PythonBuilder, %PythonBuilder* %l0
  %t2137 = load %PythonBuilder, %PythonBuilder* %l0
  %t2138 = load %PythonBuilder, %PythonBuilder* %l0
  %t2139 = load %PythonBuilder, %PythonBuilder* %l0
  %t2140 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2141 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2142 = load %PythonBuilder, %PythonBuilder* %l0
  %t2143 = load %PythonBuilder, %PythonBuilder* %l0
  %t2144 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2145 = load %PythonBuilder, %PythonBuilder* %l0
  %t2146 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2147 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge81
merge81:
  %t2148 = phi double [ %t1585, %then79 ], [ %t1540, %merge84 ]
  %t2149 = phi %PythonBuilder [ %t1586, %then79 ], [ %t2134, %merge84 ]
  %t2150 = phi { %MatchContext*, i64 }* [ %t1587, %then79 ], [ %t2140, %merge84 ]
  %t2151 = phi { i8**, i64 }* [ %t1535, %then79 ], [ %t2133, %merge84 ]
  store double %t2148, double* %l6
  store %PythonBuilder %t2149, %PythonBuilder* %l0
  store { %MatchContext*, i64 }* %t2150, { %MatchContext*, i64 }** %l5
  store { i8**, i64 }* %t2151, { i8**, i64 }** %l1
  %t2152 = load double, double* %l6
  %t2153 = load %PythonBuilder, %PythonBuilder* %l0
  %t2154 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2155 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2156 = load %PythonBuilder, %PythonBuilder* %l0
  %t2157 = load %PythonBuilder, %PythonBuilder* %l0
  %t2158 = load %PythonBuilder, %PythonBuilder* %l0
  %t2159 = load %PythonBuilder, %PythonBuilder* %l0
  %t2160 = load %PythonBuilder, %PythonBuilder* %l0
  %t2161 = load %PythonBuilder, %PythonBuilder* %l0
  %t2162 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2163 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2164 = load %PythonBuilder, %PythonBuilder* %l0
  %t2165 = load %PythonBuilder, %PythonBuilder* %l0
  %t2166 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2167 = load %PythonBuilder, %PythonBuilder* %l0
  %t2168 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2169 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge78
merge78:
  %t2170 = phi %PythonBuilder [ %t1476, %then76 ], [ %t2153, %merge81 ]
  %t2171 = phi double [ %t1470, %then76 ], [ %t2152, %merge81 ]
  %t2172 = phi { %MatchContext*, i64 }* [ %t1469, %then76 ], [ %t2154, %merge81 ]
  %t2173 = phi { i8**, i64 }* [ %t1465, %then76 ], [ %t2155, %merge81 ]
  store %PythonBuilder %t2170, %PythonBuilder* %l0
  store double %t2171, double* %l6
  store { %MatchContext*, i64 }* %t2172, { %MatchContext*, i64 }** %l5
  store { i8**, i64 }* %t2173, { i8**, i64 }** %l1
  %t2174 = load %PythonBuilder, %PythonBuilder* %l0
  %t2175 = load double, double* %l6
  %t2176 = load %PythonBuilder, %PythonBuilder* %l0
  %t2177 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2178 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2179 = load %PythonBuilder, %PythonBuilder* %l0
  %t2180 = load %PythonBuilder, %PythonBuilder* %l0
  %t2181 = load %PythonBuilder, %PythonBuilder* %l0
  %t2182 = load %PythonBuilder, %PythonBuilder* %l0
  %t2183 = load %PythonBuilder, %PythonBuilder* %l0
  %t2184 = load %PythonBuilder, %PythonBuilder* %l0
  %t2185 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2186 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2187 = load %PythonBuilder, %PythonBuilder* %l0
  %t2188 = load %PythonBuilder, %PythonBuilder* %l0
  %t2189 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2190 = load %PythonBuilder, %PythonBuilder* %l0
  %t2191 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2192 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge75
merge75:
  %t2193 = phi %PythonBuilder [ %t1406, %then73 ], [ %t2174, %merge78 ]
  %t2194 = phi double [ %t1400, %then73 ], [ %t2175, %merge78 ]
  %t2195 = phi { %MatchContext*, i64 }* [ %t1399, %then73 ], [ %t2177, %merge78 ]
  %t2196 = phi { i8**, i64 }* [ %t1395, %then73 ], [ %t2178, %merge78 ]
  store %PythonBuilder %t2193, %PythonBuilder* %l0
  store double %t2194, double* %l6
  store { %MatchContext*, i64 }* %t2195, { %MatchContext*, i64 }** %l5
  store { i8**, i64 }* %t2196, { i8**, i64 }** %l1
  %t2197 = load %PythonBuilder, %PythonBuilder* %l0
  %t2198 = load %PythonBuilder, %PythonBuilder* %l0
  %t2199 = load double, double* %l6
  %t2200 = load %PythonBuilder, %PythonBuilder* %l0
  %t2201 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2202 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2203 = load %PythonBuilder, %PythonBuilder* %l0
  %t2204 = load %PythonBuilder, %PythonBuilder* %l0
  %t2205 = load %PythonBuilder, %PythonBuilder* %l0
  %t2206 = load %PythonBuilder, %PythonBuilder* %l0
  %t2207 = load %PythonBuilder, %PythonBuilder* %l0
  %t2208 = load %PythonBuilder, %PythonBuilder* %l0
  %t2209 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2210 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2211 = load %PythonBuilder, %PythonBuilder* %l0
  %t2212 = load %PythonBuilder, %PythonBuilder* %l0
  %t2213 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2214 = load %PythonBuilder, %PythonBuilder* %l0
  %t2215 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2216 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge69
merge69:
  %t2217 = phi %PythonBuilder [ %t1334, %merge72 ], [ %t2197, %merge75 ]
  %t2218 = phi double [ %t1335, %merge72 ], [ %t1302, %merge75 ]
  %t2219 = phi { i8**, i64 }* [ %t1336, %merge72 ], [ %t2202, %merge75 ]
  %t2220 = phi double [ %t1304, %merge72 ], [ %t2199, %merge75 ]
  %t2221 = phi { %MatchContext*, i64 }* [ %t1303, %merge72 ], [ %t2201, %merge75 ]
  store %PythonBuilder %t2217, %PythonBuilder* %l0
  store double %t2218, double* %l4
  store { i8**, i64 }* %t2219, { i8**, i64 }** %l1
  store double %t2220, double* %l6
  store { %MatchContext*, i64 }* %t2221, { %MatchContext*, i64 }** %l5
  %t2222 = load %PythonBuilder, %PythonBuilder* %l0
  %t2223 = load double, double* %l4
  %t2224 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2225 = load %PythonBuilder, %PythonBuilder* %l0
  %t2226 = load %PythonBuilder, %PythonBuilder* %l0
  %t2227 = load double, double* %l6
  %t2228 = load %PythonBuilder, %PythonBuilder* %l0
  %t2229 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2230 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2231 = load %PythonBuilder, %PythonBuilder* %l0
  %t2232 = load %PythonBuilder, %PythonBuilder* %l0
  %t2233 = load %PythonBuilder, %PythonBuilder* %l0
  %t2234 = load %PythonBuilder, %PythonBuilder* %l0
  %t2235 = load %PythonBuilder, %PythonBuilder* %l0
  %t2236 = load %PythonBuilder, %PythonBuilder* %l0
  %t2237 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2238 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2239 = load %PythonBuilder, %PythonBuilder* %l0
  %t2240 = load %PythonBuilder, %PythonBuilder* %l0
  %t2241 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2242 = load %PythonBuilder, %PythonBuilder* %l0
  %t2243 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2244 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge66
merge66:
  %t2245 = phi %PythonBuilder [ %t1238, %then64 ], [ %t2222, %merge69 ]
  %t2246 = phi double [ %t1240, %then64 ], [ %t2223, %merge69 ]
  %t2247 = phi { i8**, i64 }* [ %t1222, %then64 ], [ %t2224, %merge69 ]
  %t2248 = phi double [ %t1227, %then64 ], [ %t2227, %merge69 ]
  %t2249 = phi { %MatchContext*, i64 }* [ %t1226, %then64 ], [ %t2229, %merge69 ]
  store %PythonBuilder %t2245, %PythonBuilder* %l0
  store double %t2246, double* %l4
  store { i8**, i64 }* %t2247, { i8**, i64 }** %l1
  store double %t2248, double* %l6
  store { %MatchContext*, i64 }* %t2249, { %MatchContext*, i64 }** %l5
  %t2250 = load %PythonBuilder, %PythonBuilder* %l0
  %t2251 = load %PythonBuilder, %PythonBuilder* %l0
  %t2252 = load double, double* %l4
  %t2253 = load %PythonBuilder, %PythonBuilder* %l0
  %t2254 = load double, double* %l4
  %t2255 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2256 = load %PythonBuilder, %PythonBuilder* %l0
  %t2257 = load %PythonBuilder, %PythonBuilder* %l0
  %t2258 = load double, double* %l6
  %t2259 = load %PythonBuilder, %PythonBuilder* %l0
  %t2260 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2261 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2262 = load %PythonBuilder, %PythonBuilder* %l0
  %t2263 = load %PythonBuilder, %PythonBuilder* %l0
  %t2264 = load %PythonBuilder, %PythonBuilder* %l0
  %t2265 = load %PythonBuilder, %PythonBuilder* %l0
  %t2266 = load %PythonBuilder, %PythonBuilder* %l0
  %t2267 = load %PythonBuilder, %PythonBuilder* %l0
  %t2268 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2269 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2270 = load %PythonBuilder, %PythonBuilder* %l0
  %t2271 = load %PythonBuilder, %PythonBuilder* %l0
  %t2272 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2273 = load %PythonBuilder, %PythonBuilder* %l0
  %t2274 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2275 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge60
merge60:
  %t2276 = phi %PythonBuilder [ %t1161, %merge63 ], [ %t2250, %merge66 ]
  %t2277 = phi double [ %t1162, %merge63 ], [ %t2252, %merge66 ]
  %t2278 = phi { i8**, i64 }* [ %t1163, %merge63 ], [ %t2255, %merge66 ]
  %t2279 = phi double [ %t1131, %merge63 ], [ %t2258, %merge66 ]
  %t2280 = phi { %MatchContext*, i64 }* [ %t1130, %merge63 ], [ %t2260, %merge66 ]
  store %PythonBuilder %t2276, %PythonBuilder* %l0
  store double %t2277, double* %l4
  store { i8**, i64 }* %t2278, { i8**, i64 }** %l1
  store double %t2279, double* %l6
  store { %MatchContext*, i64 }* %t2280, { %MatchContext*, i64 }** %l5
  %t2281 = load %PythonBuilder, %PythonBuilder* %l0
  %t2282 = load double, double* %l4
  %t2283 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2284 = load %PythonBuilder, %PythonBuilder* %l0
  %t2285 = load %PythonBuilder, %PythonBuilder* %l0
  %t2286 = load double, double* %l4
  %t2287 = load %PythonBuilder, %PythonBuilder* %l0
  %t2288 = load double, double* %l4
  %t2289 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2290 = load %PythonBuilder, %PythonBuilder* %l0
  %t2291 = load %PythonBuilder, %PythonBuilder* %l0
  %t2292 = load double, double* %l6
  %t2293 = load %PythonBuilder, %PythonBuilder* %l0
  %t2294 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2295 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2296 = load %PythonBuilder, %PythonBuilder* %l0
  %t2297 = load %PythonBuilder, %PythonBuilder* %l0
  %t2298 = load %PythonBuilder, %PythonBuilder* %l0
  %t2299 = load %PythonBuilder, %PythonBuilder* %l0
  %t2300 = load %PythonBuilder, %PythonBuilder* %l0
  %t2301 = load %PythonBuilder, %PythonBuilder* %l0
  %t2302 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2303 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2304 = load %PythonBuilder, %PythonBuilder* %l0
  %t2305 = load %PythonBuilder, %PythonBuilder* %l0
  %t2306 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2307 = load %PythonBuilder, %PythonBuilder* %l0
  %t2308 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2309 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge57
merge57:
  %t2310 = phi %PythonBuilder [ %t1065, %then55 ], [ %t2281, %merge60 ]
  %t2311 = phi double [ %t1067, %then55 ], [ %t2282, %merge60 ]
  %t2312 = phi { i8**, i64 }* [ %t1018, %then55 ], [ %t2283, %merge60 ]
  %t2313 = phi double [ %t1023, %then55 ], [ %t2292, %merge60 ]
  %t2314 = phi { %MatchContext*, i64 }* [ %t1022, %then55 ], [ %t2294, %merge60 ]
  store %PythonBuilder %t2310, %PythonBuilder* %l0
  store double %t2311, double* %l4
  store { i8**, i64 }* %t2312, { i8**, i64 }** %l1
  store double %t2313, double* %l6
  store { %MatchContext*, i64 }* %t2314, { %MatchContext*, i64 }** %l5
  %t2315 = load %PythonBuilder, %PythonBuilder* %l0
  %t2316 = load %PythonBuilder, %PythonBuilder* %l0
  %t2317 = load double, double* %l4
  %t2318 = load %PythonBuilder, %PythonBuilder* %l0
  %t2319 = load double, double* %l4
  %t2320 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2321 = load %PythonBuilder, %PythonBuilder* %l0
  %t2322 = load %PythonBuilder, %PythonBuilder* %l0
  %t2323 = load double, double* %l4
  %t2324 = load %PythonBuilder, %PythonBuilder* %l0
  %t2325 = load double, double* %l4
  %t2326 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2327 = load %PythonBuilder, %PythonBuilder* %l0
  %t2328 = load %PythonBuilder, %PythonBuilder* %l0
  %t2329 = load double, double* %l6
  %t2330 = load %PythonBuilder, %PythonBuilder* %l0
  %t2331 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2332 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2333 = load %PythonBuilder, %PythonBuilder* %l0
  %t2334 = load %PythonBuilder, %PythonBuilder* %l0
  %t2335 = load %PythonBuilder, %PythonBuilder* %l0
  %t2336 = load %PythonBuilder, %PythonBuilder* %l0
  %t2337 = load %PythonBuilder, %PythonBuilder* %l0
  %t2338 = load %PythonBuilder, %PythonBuilder* %l0
  %t2339 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2340 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2341 = load %PythonBuilder, %PythonBuilder* %l0
  %t2342 = load %PythonBuilder, %PythonBuilder* %l0
  %t2343 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2344 = load %PythonBuilder, %PythonBuilder* %l0
  %t2345 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2346 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge51
merge51:
  %t2347 = phi %PythonBuilder [ %t957, %merge54 ], [ %t2315, %merge57 ]
  %t2348 = phi double [ %t958, %merge54 ], [ %t2317, %merge57 ]
  %t2349 = phi { i8**, i64 }* [ %t959, %merge54 ], [ %t2320, %merge57 ]
  %t2350 = phi double [ %t927, %merge54 ], [ %t2329, %merge57 ]
  %t2351 = phi { %MatchContext*, i64 }* [ %t926, %merge54 ], [ %t2331, %merge57 ]
  store %PythonBuilder %t2347, %PythonBuilder* %l0
  store double %t2348, double* %l4
  store { i8**, i64 }* %t2349, { i8**, i64 }** %l1
  store double %t2350, double* %l6
  store { %MatchContext*, i64 }* %t2351, { %MatchContext*, i64 }** %l5
  %t2352 = load %PythonBuilder, %PythonBuilder* %l0
  %t2353 = load double, double* %l4
  %t2354 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2355 = load %PythonBuilder, %PythonBuilder* %l0
  %t2356 = load %PythonBuilder, %PythonBuilder* %l0
  %t2357 = load double, double* %l4
  %t2358 = load %PythonBuilder, %PythonBuilder* %l0
  %t2359 = load double, double* %l4
  %t2360 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2361 = load %PythonBuilder, %PythonBuilder* %l0
  %t2362 = load %PythonBuilder, %PythonBuilder* %l0
  %t2363 = load double, double* %l4
  %t2364 = load %PythonBuilder, %PythonBuilder* %l0
  %t2365 = load double, double* %l4
  %t2366 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2367 = load %PythonBuilder, %PythonBuilder* %l0
  %t2368 = load %PythonBuilder, %PythonBuilder* %l0
  %t2369 = load double, double* %l6
  %t2370 = load %PythonBuilder, %PythonBuilder* %l0
  %t2371 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2372 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2373 = load %PythonBuilder, %PythonBuilder* %l0
  %t2374 = load %PythonBuilder, %PythonBuilder* %l0
  %t2375 = load %PythonBuilder, %PythonBuilder* %l0
  %t2376 = load %PythonBuilder, %PythonBuilder* %l0
  %t2377 = load %PythonBuilder, %PythonBuilder* %l0
  %t2378 = load %PythonBuilder, %PythonBuilder* %l0
  %t2379 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2380 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2381 = load %PythonBuilder, %PythonBuilder* %l0
  %t2382 = load %PythonBuilder, %PythonBuilder* %l0
  %t2383 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2384 = load %PythonBuilder, %PythonBuilder* %l0
  %t2385 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2386 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge45
merge45:
  %t2387 = phi %PythonBuilder [ %t860, %merge48 ], [ %t2352, %merge51 ]
  %t2388 = phi { i8**, i64 }* [ %t861, %merge48 ], [ %t2354, %merge51 ]
  %t2389 = phi double [ %t828, %merge48 ], [ %t2353, %merge51 ]
  %t2390 = phi double [ %t830, %merge48 ], [ %t2369, %merge51 ]
  %t2391 = phi { %MatchContext*, i64 }* [ %t829, %merge48 ], [ %t2371, %merge51 ]
  store %PythonBuilder %t2387, %PythonBuilder* %l0
  store { i8**, i64 }* %t2388, { i8**, i64 }** %l1
  store double %t2389, double* %l4
  store double %t2390, double* %l6
  store { %MatchContext*, i64 }* %t2391, { %MatchContext*, i64 }** %l5
  %t2392 = load %PythonBuilder, %PythonBuilder* %l0
  %t2393 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2394 = load %PythonBuilder, %PythonBuilder* %l0
  %t2395 = load %PythonBuilder, %PythonBuilder* %l0
  %t2396 = load %PythonBuilder, %PythonBuilder* %l0
  %t2397 = load double, double* %l4
  %t2398 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2399 = load %PythonBuilder, %PythonBuilder* %l0
  %t2400 = load %PythonBuilder, %PythonBuilder* %l0
  %t2401 = load double, double* %l4
  %t2402 = load %PythonBuilder, %PythonBuilder* %l0
  %t2403 = load double, double* %l4
  %t2404 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2405 = load %PythonBuilder, %PythonBuilder* %l0
  %t2406 = load %PythonBuilder, %PythonBuilder* %l0
  %t2407 = load double, double* %l4
  %t2408 = load %PythonBuilder, %PythonBuilder* %l0
  %t2409 = load double, double* %l4
  %t2410 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2411 = load %PythonBuilder, %PythonBuilder* %l0
  %t2412 = load %PythonBuilder, %PythonBuilder* %l0
  %t2413 = load double, double* %l6
  %t2414 = load %PythonBuilder, %PythonBuilder* %l0
  %t2415 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2416 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2417 = load %PythonBuilder, %PythonBuilder* %l0
  %t2418 = load %PythonBuilder, %PythonBuilder* %l0
  %t2419 = load %PythonBuilder, %PythonBuilder* %l0
  %t2420 = load %PythonBuilder, %PythonBuilder* %l0
  %t2421 = load %PythonBuilder, %PythonBuilder* %l0
  %t2422 = load %PythonBuilder, %PythonBuilder* %l0
  %t2423 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2424 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2425 = load %PythonBuilder, %PythonBuilder* %l0
  %t2426 = load %PythonBuilder, %PythonBuilder* %l0
  %t2427 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2428 = load %PythonBuilder, %PythonBuilder* %l0
  %t2429 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2430 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge42
merge42:
  %t2431 = phi %PythonBuilder [ %t764, %then40 ], [ %t2392, %merge45 ]
  %t2432 = phi double [ %t766, %then40 ], [ %t2397, %merge45 ]
  %t2433 = phi { i8**, i64 }* [ %t730, %then40 ], [ %t2393, %merge45 ]
  %t2434 = phi double [ %t735, %then40 ], [ %t2413, %merge45 ]
  %t2435 = phi { %MatchContext*, i64 }* [ %t734, %then40 ], [ %t2415, %merge45 ]
  store %PythonBuilder %t2431, %PythonBuilder* %l0
  store double %t2432, double* %l4
  store { i8**, i64 }* %t2433, { i8**, i64 }** %l1
  store double %t2434, double* %l6
  store { %MatchContext*, i64 }* %t2435, { %MatchContext*, i64 }** %l5
  %t2436 = load %PythonBuilder, %PythonBuilder* %l0
  %t2437 = load %PythonBuilder, %PythonBuilder* %l0
  %t2438 = load double, double* %l4
  %t2439 = load %PythonBuilder, %PythonBuilder* %l0
  %t2440 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2441 = load %PythonBuilder, %PythonBuilder* %l0
  %t2442 = load %PythonBuilder, %PythonBuilder* %l0
  %t2443 = load %PythonBuilder, %PythonBuilder* %l0
  %t2444 = load double, double* %l4
  %t2445 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2446 = load %PythonBuilder, %PythonBuilder* %l0
  %t2447 = load %PythonBuilder, %PythonBuilder* %l0
  %t2448 = load double, double* %l4
  %t2449 = load %PythonBuilder, %PythonBuilder* %l0
  %t2450 = load double, double* %l4
  %t2451 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2452 = load %PythonBuilder, %PythonBuilder* %l0
  %t2453 = load %PythonBuilder, %PythonBuilder* %l0
  %t2454 = load double, double* %l4
  %t2455 = load %PythonBuilder, %PythonBuilder* %l0
  %t2456 = load double, double* %l4
  %t2457 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2458 = load %PythonBuilder, %PythonBuilder* %l0
  %t2459 = load %PythonBuilder, %PythonBuilder* %l0
  %t2460 = load double, double* %l6
  %t2461 = load %PythonBuilder, %PythonBuilder* %l0
  %t2462 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2463 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2464 = load %PythonBuilder, %PythonBuilder* %l0
  %t2465 = load %PythonBuilder, %PythonBuilder* %l0
  %t2466 = load %PythonBuilder, %PythonBuilder* %l0
  %t2467 = load %PythonBuilder, %PythonBuilder* %l0
  %t2468 = load %PythonBuilder, %PythonBuilder* %l0
  %t2469 = load %PythonBuilder, %PythonBuilder* %l0
  %t2470 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2471 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2472 = load %PythonBuilder, %PythonBuilder* %l0
  %t2473 = load %PythonBuilder, %PythonBuilder* %l0
  %t2474 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2475 = load %PythonBuilder, %PythonBuilder* %l0
  %t2476 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2477 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge31
merge31:
  %t2478 = phi double [ %t670, %merge34 ], [ %t539, %merge42 ]
  %t2479 = phi %PythonBuilder [ %t671, %merge34 ], [ %t2436, %merge42 ]
  %t2480 = phi double [ %t536, %merge34 ], [ %t2438, %merge42 ]
  %t2481 = phi { i8**, i64 }* [ %t533, %merge34 ], [ %t2440, %merge42 ]
  %t2482 = phi double [ %t538, %merge34 ], [ %t2460, %merge42 ]
  %t2483 = phi { %MatchContext*, i64 }* [ %t537, %merge34 ], [ %t2462, %merge42 ]
  store double %t2478, double* %l7
  store %PythonBuilder %t2479, %PythonBuilder* %l0
  store double %t2480, double* %l4
  store { i8**, i64 }* %t2481, { i8**, i64 }** %l1
  store double %t2482, double* %l6
  store { %MatchContext*, i64 }* %t2483, { %MatchContext*, i64 }** %l5
  %t2484 = load double, double* %l7
  %t2485 = load %PythonBuilder, %PythonBuilder* %l0
  %t2486 = load %PythonBuilder, %PythonBuilder* %l0
  %t2487 = load %PythonBuilder, %PythonBuilder* %l0
  %t2488 = load double, double* %l4
  %t2489 = load %PythonBuilder, %PythonBuilder* %l0
  %t2490 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2491 = load %PythonBuilder, %PythonBuilder* %l0
  %t2492 = load %PythonBuilder, %PythonBuilder* %l0
  %t2493 = load %PythonBuilder, %PythonBuilder* %l0
  %t2494 = load double, double* %l4
  %t2495 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2496 = load %PythonBuilder, %PythonBuilder* %l0
  %t2497 = load %PythonBuilder, %PythonBuilder* %l0
  %t2498 = load double, double* %l4
  %t2499 = load %PythonBuilder, %PythonBuilder* %l0
  %t2500 = load double, double* %l4
  %t2501 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2502 = load %PythonBuilder, %PythonBuilder* %l0
  %t2503 = load %PythonBuilder, %PythonBuilder* %l0
  %t2504 = load double, double* %l4
  %t2505 = load %PythonBuilder, %PythonBuilder* %l0
  %t2506 = load double, double* %l4
  %t2507 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2508 = load %PythonBuilder, %PythonBuilder* %l0
  %t2509 = load %PythonBuilder, %PythonBuilder* %l0
  %t2510 = load double, double* %l6
  %t2511 = load %PythonBuilder, %PythonBuilder* %l0
  %t2512 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2513 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2514 = load %PythonBuilder, %PythonBuilder* %l0
  %t2515 = load %PythonBuilder, %PythonBuilder* %l0
  %t2516 = load %PythonBuilder, %PythonBuilder* %l0
  %t2517 = load %PythonBuilder, %PythonBuilder* %l0
  %t2518 = load %PythonBuilder, %PythonBuilder* %l0
  %t2519 = load %PythonBuilder, %PythonBuilder* %l0
  %t2520 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2521 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2522 = load %PythonBuilder, %PythonBuilder* %l0
  %t2523 = load %PythonBuilder, %PythonBuilder* %l0
  %t2524 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2525 = load %PythonBuilder, %PythonBuilder* %l0
  %t2526 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2527 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge23
merge23:
  %t2528 = phi %PythonBuilder [ %t473, %merge26 ], [ %t2485, %merge31 ]
  %t2529 = phi double [ %t474, %merge26 ], [ %t2484, %merge31 ]
  %t2530 = phi double [ %t378, %merge26 ], [ %t2488, %merge31 ]
  %t2531 = phi { i8**, i64 }* [ %t375, %merge26 ], [ %t2490, %merge31 ]
  %t2532 = phi double [ %t380, %merge26 ], [ %t2510, %merge31 ]
  %t2533 = phi { %MatchContext*, i64 }* [ %t379, %merge26 ], [ %t2512, %merge31 ]
  store %PythonBuilder %t2528, %PythonBuilder* %l0
  store double %t2529, double* %l7
  store double %t2530, double* %l4
  store { i8**, i64 }* %t2531, { i8**, i64 }** %l1
  store double %t2532, double* %l6
  store { %MatchContext*, i64 }* %t2533, { %MatchContext*, i64 }** %l5
  %t2534 = load %PythonBuilder, %PythonBuilder* %l0
  %t2535 = load double, double* %l7
  %t2536 = load double, double* %l7
  %t2537 = load %PythonBuilder, %PythonBuilder* %l0
  %t2538 = load %PythonBuilder, %PythonBuilder* %l0
  %t2539 = load %PythonBuilder, %PythonBuilder* %l0
  %t2540 = load double, double* %l4
  %t2541 = load %PythonBuilder, %PythonBuilder* %l0
  %t2542 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2543 = load %PythonBuilder, %PythonBuilder* %l0
  %t2544 = load %PythonBuilder, %PythonBuilder* %l0
  %t2545 = load %PythonBuilder, %PythonBuilder* %l0
  %t2546 = load double, double* %l4
  %t2547 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2548 = load %PythonBuilder, %PythonBuilder* %l0
  %t2549 = load %PythonBuilder, %PythonBuilder* %l0
  %t2550 = load double, double* %l4
  %t2551 = load %PythonBuilder, %PythonBuilder* %l0
  %t2552 = load double, double* %l4
  %t2553 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2554 = load %PythonBuilder, %PythonBuilder* %l0
  %t2555 = load %PythonBuilder, %PythonBuilder* %l0
  %t2556 = load double, double* %l4
  %t2557 = load %PythonBuilder, %PythonBuilder* %l0
  %t2558 = load double, double* %l4
  %t2559 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2560 = load %PythonBuilder, %PythonBuilder* %l0
  %t2561 = load %PythonBuilder, %PythonBuilder* %l0
  %t2562 = load double, double* %l6
  %t2563 = load %PythonBuilder, %PythonBuilder* %l0
  %t2564 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2565 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2566 = load %PythonBuilder, %PythonBuilder* %l0
  %t2567 = load %PythonBuilder, %PythonBuilder* %l0
  %t2568 = load %PythonBuilder, %PythonBuilder* %l0
  %t2569 = load %PythonBuilder, %PythonBuilder* %l0
  %t2570 = load %PythonBuilder, %PythonBuilder* %l0
  %t2571 = load %PythonBuilder, %PythonBuilder* %l0
  %t2572 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2573 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2574 = load %PythonBuilder, %PythonBuilder* %l0
  %t2575 = load %PythonBuilder, %PythonBuilder* %l0
  %t2576 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2577 = load %PythonBuilder, %PythonBuilder* %l0
  %t2578 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2579 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge12
merge12:
  %t2580 = phi %PythonBuilder [ %t314, %merge15 ], [ %t2534, %merge23 ]
  %t2581 = phi double [ %t316, %merge15 ], [ %t2535, %merge23 ]
  %t2582 = phi double [ %t177, %merge15 ], [ %t2540, %merge23 ]
  %t2583 = phi { i8**, i64 }* [ %t174, %merge15 ], [ %t2542, %merge23 ]
  %t2584 = phi double [ %t179, %merge15 ], [ %t2562, %merge23 ]
  %t2585 = phi { %MatchContext*, i64 }* [ %t178, %merge15 ], [ %t2564, %merge23 ]
  store %PythonBuilder %t2580, %PythonBuilder* %l0
  store double %t2581, double* %l7
  store double %t2582, double* %l4
  store { i8**, i64 }* %t2583, { i8**, i64 }** %l1
  store double %t2584, double* %l6
  store { %MatchContext*, i64 }* %t2585, { %MatchContext*, i64 }** %l5
  %t2586 = load double, double* %l7
  %t2587 = sitofp i64 1 to double
  %t2588 = fadd double %t2586, %t2587
  store double %t2588, double* %l7
  br label %loop.latch6
loop.latch6:
  %t2589 = load %PythonBuilder, %PythonBuilder* %l0
  %t2590 = load double, double* %l7
  %t2591 = load double, double* %l4
  %t2592 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2593 = load double, double* %l6
  %t2594 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  br label %loop.header4
afterloop7:
  %t2601 = load %PythonBuilder, %PythonBuilder* %l0
  %t2602 = load double, double* %l7
  %t2603 = load double, double* %l4
  %t2604 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2605 = load double, double* %l6
  %t2606 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2607 = load %PythonBuilder, %PythonBuilder* %l0
  %t2608 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2609 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2610 = load i8*, i8** %l3
  %t2611 = load double, double* %l4
  %t2612 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2613 = load double, double* %l6
  %t2614 = load double, double* %l7
  br label %loop.header111
loop.header111:
  %t2666 = phi %PythonBuilder [ %t2607, %afterloop7 ], [ %t2663, %loop.latch113 ]
  %t2667 = phi { i8**, i64 }* [ %t2608, %afterloop7 ], [ %t2664, %loop.latch113 ]
  %t2668 = phi { %MatchContext*, i64 }* [ %t2612, %afterloop7 ], [ %t2665, %loop.latch113 ]
  store %PythonBuilder %t2666, %PythonBuilder* %l0
  store { i8**, i64 }* %t2667, { i8**, i64 }** %l1
  store { %MatchContext*, i64 }* %t2668, { %MatchContext*, i64 }** %l5
  br label %loop.body112
loop.body112:
  %t2615 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2616 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t2615
  %t2617 = extractvalue { %MatchContext*, i64 } %t2616, 1
  %t2618 = icmp eq i64 %t2617, 0
  %t2619 = load %PythonBuilder, %PythonBuilder* %l0
  %t2620 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2621 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2622 = load i8*, i8** %l3
  %t2623 = load double, double* %l4
  %t2624 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2625 = load double, double* %l6
  %t2626 = load double, double* %l7
  br i1 %t2618, label %then115, label %merge116
then115:
  br label %afterloop114
merge116:
  %t2627 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2628 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t2627
  %t2629 = extractvalue { %MatchContext*, i64 } %t2628, 1
  %t2630 = sub i64 %t2629, 1
  store i64 %t2630, i64* %l38
  %t2631 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2632 = load i64, i64* %l38
  %t2633 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t2631
  %t2634 = extractvalue { %MatchContext*, i64 } %t2633, 0
  %t2635 = extractvalue { %MatchContext*, i64 } %t2633, 1
  %t2636 = icmp uge i64 %t2632, %t2635
  ; bounds check: %t2636 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t2632, i64 %t2635)
  %t2637 = getelementptr %MatchContext, %MatchContext* %t2634, i64 %t2632
  %t2638 = load %MatchContext, %MatchContext* %t2637
  store %MatchContext %t2638, %MatchContext* %l39
  %t2639 = load %MatchContext, %MatchContext* %l39
  %t2640 = extractvalue %MatchContext %t2639, 2
  %t2641 = load %PythonBuilder, %PythonBuilder* %l0
  %t2642 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2643 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2644 = load i8*, i8** %l3
  %t2645 = load double, double* %l4
  %t2646 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2647 = load double, double* %l6
  %t2648 = load double, double* %l7
  %t2649 = load i64, i64* %l38
  %t2650 = load %MatchContext, %MatchContext* %l39
  br i1 %t2640, label %then117, label %merge118
then117:
  %t2651 = load %PythonBuilder, %PythonBuilder* %l0
  %t2652 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t2651)
  store %PythonBuilder %t2652, %PythonBuilder* %l0
  %t2653 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge118
merge118:
  %t2654 = phi %PythonBuilder [ %t2653, %then117 ], [ %t2641, %merge116 ]
  store %PythonBuilder %t2654, %PythonBuilder* %l0
  %t2655 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2656 = extractvalue %NativeFunction %function, 0
  %s2657 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.len29.h1409903806, i32 0, i32 0
  %t2658 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t2655, i8* %t2656, i8* %s2657)
  store { i8**, i64 }* %t2658, { i8**, i64 }** %l1
  %t2659 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2660 = load i64, i64* %l38
  %t2661 = sitofp i64 %t2660 to double
  %t2662 = call { %MatchContext*, i64 }* @truncate_match_contexts({ %MatchContext*, i64 }* %t2659, double %t2661)
  store { %MatchContext*, i64 }* %t2662, { %MatchContext*, i64 }** %l5
  br label %loop.latch113
loop.latch113:
  %t2663 = load %PythonBuilder, %PythonBuilder* %l0
  %t2664 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2665 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  br label %loop.header111
afterloop114:
  %t2669 = load %PythonBuilder, %PythonBuilder* %l0
  %t2670 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2671 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2672 = load %PythonBuilder, %PythonBuilder* %l0
  %t2673 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2674 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2675 = load i8*, i8** %l3
  %t2676 = load double, double* %l4
  %t2677 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2678 = load double, double* %l6
  %t2679 = load double, double* %l7
  br label %loop.header119
loop.header119:
  %t2703 = phi %PythonBuilder [ %t2672, %afterloop114 ], [ %t2700, %loop.latch121 ]
  %t2704 = phi double [ %t2676, %afterloop114 ], [ %t2701, %loop.latch121 ]
  %t2705 = phi { i8**, i64 }* [ %t2673, %afterloop114 ], [ %t2702, %loop.latch121 ]
  store %PythonBuilder %t2703, %PythonBuilder* %l0
  store double %t2704, double* %l4
  store { i8**, i64 }* %t2705, { i8**, i64 }** %l1
  br label %loop.body120
loop.body120:
  %t2680 = load double, double* %l4
  %t2681 = sitofp i64 0 to double
  %t2682 = fcmp ole double %t2680, %t2681
  %t2683 = load %PythonBuilder, %PythonBuilder* %l0
  %t2684 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2685 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2686 = load i8*, i8** %l3
  %t2687 = load double, double* %l4
  %t2688 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2689 = load double, double* %l6
  %t2690 = load double, double* %l7
  br i1 %t2682, label %then123, label %merge124
then123:
  br label %afterloop122
merge124:
  %t2691 = load %PythonBuilder, %PythonBuilder* %l0
  %t2692 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t2691)
  store %PythonBuilder %t2692, %PythonBuilder* %l0
  %t2693 = load double, double* %l4
  %t2694 = sitofp i64 1 to double
  %t2695 = fsub double %t2693, %t2694
  store double %t2695, double* %l4
  %t2696 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2697 = extractvalue %NativeFunction %function, 0
  %s2698 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.len31.h1736570074, i32 0, i32 0
  %t2699 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t2696, i8* %t2697, i8* %s2698)
  store { i8**, i64 }* %t2699, { i8**, i64 }** %l1
  br label %loop.latch121
loop.latch121:
  %t2700 = load %PythonBuilder, %PythonBuilder* %l0
  %t2701 = load double, double* %l4
  %t2702 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %loop.header119
afterloop122:
  %t2706 = load %PythonBuilder, %PythonBuilder* %l0
  %t2707 = load double, double* %l4
  %t2708 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2709 = load %PythonBuilder, %PythonBuilder* %l0
  %t2710 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t2709)
  store %PythonBuilder %t2710, %PythonBuilder* %l0
  %t2711 = load %PythonBuilder, %PythonBuilder* %l0
  %t2712 = insertvalue %PythonFunctionEmission undef, %PythonBuilder %t2711, 0
  %t2713 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2714 = insertvalue %PythonFunctionEmission %t2712, { i8**, i64 }* %t2713, 1
  ret %PythonFunctionEmission %t2714
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
  %t47 = phi { %MatchContext*, i64 }* [ %t13, %block.entry ], [ %t45, %loop.latch2 ]
  %t48 = phi double [ %t14, %block.entry ], [ %t46, %loop.latch2 ]
  store { %MatchContext*, i64 }* %t47, { %MatchContext*, i64 }** %l0
  store double %t48, double* %l1
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
  %t31 = call double @llvm.round.f64(double %t30)
  %t32 = fptosi double %t31 to i64
  %t33 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %values
  %t34 = extractvalue { %MatchContext*, i64 } %t33, 0
  %t35 = extractvalue { %MatchContext*, i64 } %t33, 1
  %t36 = icmp uge i64 %t32, %t35
  ; bounds check: %t36 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t32, i64 %t35)
  %t37 = getelementptr %MatchContext, %MatchContext* %t34, i64 %t32
  %t38 = load %MatchContext, %MatchContext* %t37
  %t39 = call { %MatchContext*, i64 }* @append_match_context({ %MatchContext*, i64 }* %t29, %MatchContext %t38)
  store { %MatchContext*, i64 }* %t39, { %MatchContext*, i64 }** %l0
  %t40 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  br label %merge8
merge8:
  %t41 = phi { %MatchContext*, i64 }* [ %t28, %then6 ], [ %t40, %else7 ]
  store { %MatchContext*, i64 }* %t41, { %MatchContext*, i64 }** %l0
  %t42 = load double, double* %l1
  %t43 = sitofp i64 1 to double
  %t44 = fadd double %t42, %t43
  store double %t44, double* %l1
  br label %loop.latch2
loop.latch2:
  %t45 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t46 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t49 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t50 = load double, double* %l1
  %t51 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  ret { %MatchContext*, i64 }* %t51
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
  %t49 = phi { %MatchContext*, i64 }* [ %t27, %merge1 ], [ %t47, %loop.latch4 ]
  %t50 = phi double [ %t28, %merge1 ], [ %t48, %loop.latch4 ]
  store { %MatchContext*, i64 }* %t49, { %MatchContext*, i64 }** %l0
  store double %t50, double* %l1
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
  %t35 = call double @llvm.round.f64(double %t34)
  %t36 = fptosi double %t35 to i64
  %t37 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %values
  %t38 = extractvalue { %MatchContext*, i64 } %t37, 0
  %t39 = extractvalue { %MatchContext*, i64 } %t37, 1
  %t40 = icmp uge i64 %t36, %t39
  ; bounds check: %t40 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t36, i64 %t39)
  %t41 = getelementptr %MatchContext, %MatchContext* %t38, i64 %t36
  %t42 = load %MatchContext, %MatchContext* %t41
  %t43 = call { %MatchContext*, i64 }* @append_match_context({ %MatchContext*, i64 }* %t33, %MatchContext %t42)
  store { %MatchContext*, i64 }* %t43, { %MatchContext*, i64 }** %l0
  %t44 = load double, double* %l1
  %t45 = sitofp i64 1 to double
  %t46 = fadd double %t44, %t45
  store double %t46, double* %l1
  br label %loop.latch4
loop.latch4:
  %t47 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t48 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t51 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t52 = load double, double* %l1
  %t53 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  ret { %MatchContext*, i64 }* %t53
}

; NOTE: Returns string via output parameter %out_result
define void @generate_match_subject_name(double %counter, i8** %out_result) {
block.entry:
  %s0 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h1077944870, i32 0, i32 0
  %t1 = call i8* @number_to_string(double %counter)
  %t2 = call i8* @sailfin_runtime_string_concat(i8* %s0, i8* %t1)
  store i8* %t2, i8** %out_result
  ret void
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

; NOTE: Returns string via output parameter %out_result
define void @number_to_string(double %value, i8** %out_result) {
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
  store i8* %t5, i8** %out_result
  ret void
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
  %t61 = phi i8* [ %t10, %merge1 ], [ %t59, %loop.latch4 ]
  %t62 = phi double [ %t9, %merge1 ], [ %t60, %loop.latch4 ]
  store i8* %t61, i8** %l2
  store double %t62, double* %l1
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
  %t50 = call double @llvm.round.f64(double %t46)
  %t51 = fptosi double %t50 to i64
  %t52 = call double @llvm.round.f64(double %t49)
  %t53 = fptosi double %t52 to i64
  %t54 = call i8* @sailfin_runtime_substring(i8* %t45, i64 %t51, i64 %t53)
  store i8* %t54, i8** %l6
  %t55 = load i8*, i8** %l6
  %t56 = load i8*, i8** %l2
  %t57 = call i8* @sailfin_runtime_string_concat(i8* %t55, i8* %t56)
  store i8* %t57, i8** %l2
  %t58 = load double, double* %l4
  store double %t58, double* %l1
  br label %loop.latch4
loop.latch4:
  %t59 = load i8*, i8** %l2
  %t60 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t63 = load i8*, i8** %l2
  %t64 = load double, double* %l1
  %t65 = load i8*, i8** %l2
  store i8* %t65, i8** %out_result
  ret void
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
  %t71 = phi { i8**, i64 }* [ %t28, %merge1 ], [ %t69, %loop.latch4 ]
  %t72 = phi double [ %t29, %merge1 ], [ %t70, %loop.latch4 ]
  store { i8**, i64 }* %t71, { i8**, i64 }** %l0
  store double %t72, double* %l1
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
  %t38 = call double @llvm.round.f64(double %t37)
  %t39 = fptosi double %t38 to i64
  %t40 = load { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %parameters
  %t41 = extractvalue { %NativeParameter*, i64 } %t40, 0
  %t42 = extractvalue { %NativeParameter*, i64 } %t40, 1
  %t43 = icmp uge i64 %t39, %t42
  ; bounds check: %t43 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t39, i64 %t42)
  %t44 = getelementptr %NativeParameter, %NativeParameter* %t41, i64 %t39
  %t45 = load %NativeParameter, %NativeParameter* %t44
  store %NativeParameter %t45, %NativeParameter* %l2
  %t46 = load %NativeParameter, %NativeParameter* %l2
  %t47 = extractvalue %NativeParameter %t46, 0
  store i8* %t47, i8** %l3
  %t48 = load %NativeParameter, %NativeParameter* %l2
  %t49 = extractvalue %NativeParameter %t48, 3
  %t50 = icmp ne i8* %t49, null
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t52 = load double, double* %l1
  %t53 = load %NativeParameter, %NativeParameter* %l2
  %t54 = load i8*, i8** %l3
  br i1 %t50, label %then8, label %merge9
then8:
  %t55 = load i8*, i8** %l3
  %s56 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087691079, i32 0, i32 0
  %t57 = call i8* @sailfin_runtime_string_concat(i8* %t55, i8* %s56)
  %t58 = load %NativeParameter, %NativeParameter* %l2
  %t59 = extractvalue %NativeParameter %t58, 3
  %t60 = call i8* @sailfin_runtime_string_concat(i8* %t57, i8* %t59)
  store i8* %t60, i8** %l3
  %t61 = load i8*, i8** %l3
  br label %merge9
merge9:
  %t62 = phi i8* [ %t61, %then8 ], [ %t54, %merge7 ]
  store i8* %t62, i8** %l3
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t64 = load i8*, i8** %l3
  %t65 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t63, i8* %t64)
  store { i8**, i64 }* %t65, { i8**, i64 }** %l0
  %t66 = load double, double* %l1
  %t67 = sitofp i64 1 to double
  %t68 = fadd double %t66, %t67
  store double %t68, double* %l1
  br label %loop.latch4
loop.latch4:
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t70 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t74 = load double, double* %l1
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t75
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

; NOTE: Returns string via output parameter %out_result
define void @builder_to_string(%PythonBuilder %builder, i8** %out_result) {
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
  store i8* %s10, i8** %out_result
  ret void
merge1:
  %t11 = load i8*, i8** %l0
  %t12 = alloca [2 x i8], align 1
  %t13 = getelementptr [2 x i8], [2 x i8]* %t12, i32 0, i32 0
  store i8 10, i8* %t13
  %t14 = getelementptr [2 x i8], [2 x i8]* %t12, i32 0, i32 1
  store i8 0, i8* %t14
  %t15 = getelementptr [2 x i8], [2 x i8]* %t12, i32 0, i32 0
  %t16 = call i8* @sailfin_runtime_string_concat(i8* %t11, i8* %t15)
  store i8* %t16, i8** %out_result
  ret void
}

; NOTE: Returns string via output parameter %out_result
define void @sanitize_identifier(i8* %name, i8** %out_result) {
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
  %t52 = phi i8* [ %t2, %block.entry ], [ %t50, %loop.latch2 ]
  %t53 = phi double [ %t3, %block.entry ], [ %t51, %loop.latch2 ]
  store i8* %t52, i8** %l0
  store double %t53, double* %l1
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
  %t11 = call double @llvm.round.f64(double %t10)
  %t12 = fptosi double %t11 to i64
  %t13 = getelementptr i8, i8* %name, i64 %t12
  %t14 = load i8, i8* %t13
  store i8 %t14, i8* %l2
  %t15 = load i8, i8* %l2
  %t16 = alloca [2 x i8], align 1
  %t17 = getelementptr [2 x i8], [2 x i8]* %t16, i32 0, i32 0
  store i8 %t15, i8* %t17
  %t18 = getelementptr [2 x i8], [2 x i8]* %t16, i32 0, i32 1
  store i8 0, i8* %t18
  %t19 = getelementptr [2 x i8], [2 x i8]* %t16, i32 0, i32 0
  %t20 = call i1 @is_identifier_char(i8* %t19)
  %t21 = load i8*, i8** %l0
  %t22 = load double, double* %l1
  %t23 = load i8, i8* %l2
  br i1 %t20, label %then6, label %else7
then6:
  %t24 = load i8*, i8** %l0
  %t25 = load i8, i8* %l2
  %t26 = alloca [2 x i8], align 1
  %t27 = getelementptr [2 x i8], [2 x i8]* %t26, i32 0, i32 0
  store i8 %t25, i8* %t27
  %t28 = getelementptr [2 x i8], [2 x i8]* %t26, i32 0, i32 1
  store i8 0, i8* %t28
  %t29 = getelementptr [2 x i8], [2 x i8]* %t26, i32 0, i32 0
  %t30 = call i8* @sailfin_runtime_string_concat(i8* %t24, i8* %t29)
  store i8* %t30, i8** %l0
  %t31 = load i8*, i8** %l0
  br label %merge8
else7:
  %t32 = load i8, i8* %l2
  %t33 = icmp eq i8 %t32, 32
  %t34 = load i8*, i8** %l0
  %t35 = load double, double* %l1
  %t36 = load i8, i8* %l2
  br i1 %t33, label %then9, label %merge10
then9:
  %t37 = load i8*, i8** %l0
  %t38 = alloca [2 x i8], align 1
  %t39 = getelementptr [2 x i8], [2 x i8]* %t38, i32 0, i32 0
  store i8 95, i8* %t39
  %t40 = getelementptr [2 x i8], [2 x i8]* %t38, i32 0, i32 1
  store i8 0, i8* %t40
  %t41 = getelementptr [2 x i8], [2 x i8]* %t38, i32 0, i32 0
  %t42 = call i8* @sailfin_runtime_string_concat(i8* %t37, i8* %t41)
  store i8* %t42, i8** %l0
  %t43 = load i8*, i8** %l0
  br label %merge10
merge10:
  %t44 = phi i8* [ %t43, %then9 ], [ %t34, %else7 ]
  store i8* %t44, i8** %l0
  %t45 = load i8*, i8** %l0
  br label %merge8
merge8:
  %t46 = phi i8* [ %t31, %then6 ], [ %t45, %merge10 ]
  store i8* %t46, i8** %l0
  %t47 = load double, double* %l1
  %t48 = sitofp i64 1 to double
  %t49 = fadd double %t47, %t48
  store double %t49, double* %l1
  br label %loop.latch2
loop.latch2:
  %t50 = load i8*, i8** %l0
  %t51 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t54 = load i8*, i8** %l0
  %t55 = load double, double* %l1
  %t56 = load i8*, i8** %l0
  %t57 = call i64 @sailfin_runtime_string_length(i8* %t56)
  %t58 = icmp eq i64 %t57, 0
  %t59 = load i8*, i8** %l0
  %t60 = load double, double* %l1
  br i1 %t58, label %then11, label %merge12
then11:
  %s61 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.len18.h1387621460, i32 0, i32 0
  store i8* %s61, i8** %out_result
  ret void
merge12:
  %t62 = load i8*, i8** %l0
  store i8* %t62, i8** %out_result
  ret void
}

; NOTE: Returns string via output parameter %out_result
define void @sanitize_qualified_identifier(i8* %name, i8** %out_result) {
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
  store i8* %t6, i8** %out_result
  ret void
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
  %t82 = phi { i8**, i64 }* [ %t23, %merge1 ], [ %t79, %loop.latch4 ]
  %t83 = phi i8* [ %t22, %merge1 ], [ %t80, %loop.latch4 ]
  %t84 = phi double [ %t24, %merge1 ], [ %t81, %loop.latch4 ]
  store { i8**, i64 }* %t82, { i8**, i64 }** %l2
  store i8* %t83, i8** %l1
  store double %t84, double* %l3
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
  %t36 = call double @llvm.round.f64(double %t35)
  %t37 = fptosi double %t36 to i64
  %t38 = getelementptr i8, i8* %t34, i64 %t37
  %t39 = load i8, i8* %t38
  store i8 %t39, i8* %l4
  %t40 = load i8, i8* %l4
  %t41 = icmp eq i8 %t40, 46
  %t42 = load i8*, i8** %l0
  %t43 = load i8*, i8** %l1
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t45 = load double, double* %l3
  %t46 = load i8, i8* %l4
  br i1 %t41, label %then8, label %else9
then8:
  %t47 = load i8*, i8** %l1
  %t48 = call i64 @sailfin_runtime_string_length(i8* %t47)
  %t49 = icmp sgt i64 %t48, 0
  %t50 = load i8*, i8** %l0
  %t51 = load i8*, i8** %l1
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t53 = load double, double* %l3
  %t54 = load i8, i8* %l4
  br i1 %t49, label %then11, label %merge12
then11:
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t56 = load i8*, i8** %l1
  %t57 = call i8* @sanitize_identifier(i8* %t56)
  %t58 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t55, i8* %t57)
  store { i8**, i64 }* %t58, { i8**, i64 }** %l2
  %s59 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s59, i8** %l1
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t61 = load i8*, i8** %l1
  br label %merge12
merge12:
  %t62 = phi { i8**, i64 }* [ %t60, %then11 ], [ %t52, %then8 ]
  %t63 = phi i8* [ %t61, %then11 ], [ %t51, %then8 ]
  store { i8**, i64 }* %t62, { i8**, i64 }** %l2
  store i8* %t63, i8** %l1
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t65 = load i8*, i8** %l1
  br label %merge10
else9:
  %t66 = load i8*, i8** %l1
  %t67 = load i8, i8* %l4
  %t68 = alloca [2 x i8], align 1
  %t69 = getelementptr [2 x i8], [2 x i8]* %t68, i32 0, i32 0
  store i8 %t67, i8* %t69
  %t70 = getelementptr [2 x i8], [2 x i8]* %t68, i32 0, i32 1
  store i8 0, i8* %t70
  %t71 = getelementptr [2 x i8], [2 x i8]* %t68, i32 0, i32 0
  %t72 = call i8* @sailfin_runtime_string_concat(i8* %t66, i8* %t71)
  store i8* %t72, i8** %l1
  %t73 = load i8*, i8** %l1
  br label %merge10
merge10:
  %t74 = phi { i8**, i64 }* [ %t64, %merge12 ], [ %t44, %else9 ]
  %t75 = phi i8* [ %t65, %merge12 ], [ %t73, %else9 ]
  store { i8**, i64 }* %t74, { i8**, i64 }** %l2
  store i8* %t75, i8** %l1
  %t76 = load double, double* %l3
  %t77 = sitofp i64 1 to double
  %t78 = fadd double %t76, %t77
  store double %t78, double* %l3
  br label %loop.latch4
loop.latch4:
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t80 = load i8*, i8** %l1
  %t81 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t86 = load i8*, i8** %l1
  %t87 = load double, double* %l3
  %t88 = load i8*, i8** %l1
  %t89 = call i64 @sailfin_runtime_string_length(i8* %t88)
  %t90 = icmp sgt i64 %t89, 0
  %t91 = load i8*, i8** %l0
  %t92 = load i8*, i8** %l1
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t94 = load double, double* %l3
  br i1 %t90, label %then13, label %merge14
then13:
  %t95 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t96 = load i8*, i8** %l1
  %t97 = call i8* @sanitize_identifier(i8* %t96)
  %t98 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t95, i8* %t97)
  store { i8**, i64 }* %t98, { i8**, i64 }** %l2
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br label %merge14
merge14:
  %t100 = phi { i8**, i64 }* [ %t99, %then13 ], [ %t93, %afterloop5 ]
  store { i8**, i64 }* %t100, { i8**, i64 }** %l2
  %t101 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t102 = load { i8**, i64 }, { i8**, i64 }* %t101
  %t103 = extractvalue { i8**, i64 } %t102, 1
  %t104 = icmp eq i64 %t103, 0
  %t105 = load i8*, i8** %l0
  %t106 = load i8*, i8** %l1
  %t107 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t108 = load double, double* %l3
  br i1 %t104, label %then15, label %merge16
then15:
  %t109 = load i8*, i8** %l0
  %t110 = call i8* @sanitize_identifier(i8* %t109)
  store i8* %t110, i8** %out_result
  ret void
merge16:
  %t111 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t112 = alloca [2 x i8], align 1
  %t113 = getelementptr [2 x i8], [2 x i8]* %t112, i32 0, i32 0
  store i8 46, i8* %t113
  %t114 = getelementptr [2 x i8], [2 x i8]* %t112, i32 0, i32 1
  store i8 0, i8* %t114
  %t115 = getelementptr [2 x i8], [2 x i8]* %t112, i32 0, i32 0
  %t116 = call i8* @join_with_separator({ i8**, i64 }* %t111, i8* %t115)
  store i8* %t116, i8** %out_result
  ret void
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

; NOTE: Returns string via output parameter %out_result
define void @trim_text(i8* %value, i8** %out_result) {
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
  %t44 = phi double [ %t3, %block.entry ], [ %t43, %loop.latch2 ]
  store double %t44, double* %l0
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
  %t14 = call double @llvm.round.f64(double %t10)
  %t15 = fptosi double %t14 to i64
  %t16 = call double @llvm.round.f64(double %t13)
  %t17 = fptosi double %t16 to i64
  %t18 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t15, i64 %t17)
  store i8* %t18, i8** %l2
  %t20 = load i8*, i8** %l2
  %t21 = load i8, i8* %t20
  %t22 = icmp eq i8 %t21, 32
  br label %logical_or_entry_19

logical_or_entry_19:
  br i1 %t22, label %logical_or_merge_19, label %logical_or_right_19

logical_or_right_19:
  %t24 = load i8*, i8** %l2
  %t25 = load i8, i8* %t24
  %t26 = icmp eq i8 %t25, 10
  br label %logical_or_entry_23

logical_or_entry_23:
  br i1 %t26, label %logical_or_merge_23, label %logical_or_right_23

logical_or_right_23:
  %t28 = load i8*, i8** %l2
  %t29 = load i8, i8* %t28
  %t30 = icmp eq i8 %t29, 13
  br label %logical_or_entry_27

logical_or_entry_27:
  br i1 %t30, label %logical_or_merge_27, label %logical_or_right_27

logical_or_right_27:
  %t31 = load i8*, i8** %l2
  %t32 = load i8, i8* %t31
  %t33 = icmp eq i8 %t32, 9
  br label %logical_or_right_end_27

logical_or_right_end_27:
  br label %logical_or_merge_27

logical_or_merge_27:
  %t34 = phi i1 [ true, %logical_or_entry_27 ], [ %t33, %logical_or_right_end_27 ]
  br label %logical_or_right_end_23

logical_or_right_end_23:
  br label %logical_or_merge_23

logical_or_merge_23:
  %t35 = phi i1 [ true, %logical_or_entry_23 ], [ %t34, %logical_or_right_end_23 ]
  br label %logical_or_right_end_19

logical_or_right_end_19:
  br label %logical_or_merge_19

logical_or_merge_19:
  %t36 = phi i1 [ true, %logical_or_entry_19 ], [ %t35, %logical_or_right_end_19 ]
  %t37 = load double, double* %l0
  %t38 = load double, double* %l1
  %t39 = load i8*, i8** %l2
  br i1 %t36, label %then6, label %merge7
then6:
  %t40 = load double, double* %l0
  %t41 = sitofp i64 1 to double
  %t42 = fadd double %t40, %t41
  store double %t42, double* %l0
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  %t43 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t45 = load double, double* %l0
  %t46 = load double, double* %l0
  %t47 = load double, double* %l1
  br label %loop.header8
loop.header8:
  %t91 = phi double [ %t47, %afterloop3 ], [ %t90, %loop.latch10 ]
  store double %t91, double* %l1
  br label %loop.body9
loop.body9:
  %t48 = load double, double* %l1
  %t49 = load double, double* %l0
  %t50 = fcmp ole double %t48, %t49
  %t51 = load double, double* %l0
  %t52 = load double, double* %l1
  br i1 %t50, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t53 = load double, double* %l1
  %t54 = sitofp i64 1 to double
  %t55 = fsub double %t53, %t54
  store double %t55, double* %l3
  %t56 = load double, double* %l3
  %t57 = load double, double* %l3
  %t58 = sitofp i64 1 to double
  %t59 = fadd double %t57, %t58
  %t60 = call double @llvm.round.f64(double %t56)
  %t61 = fptosi double %t60 to i64
  %t62 = call double @llvm.round.f64(double %t59)
  %t63 = fptosi double %t62 to i64
  %t64 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t61, i64 %t63)
  store i8* %t64, i8** %l4
  %t66 = load i8*, i8** %l4
  %t67 = load i8, i8* %t66
  %t68 = icmp eq i8 %t67, 32
  br label %logical_or_entry_65

logical_or_entry_65:
  br i1 %t68, label %logical_or_merge_65, label %logical_or_right_65

logical_or_right_65:
  %t70 = load i8*, i8** %l4
  %t71 = load i8, i8* %t70
  %t72 = icmp eq i8 %t71, 10
  br label %logical_or_entry_69

logical_or_entry_69:
  br i1 %t72, label %logical_or_merge_69, label %logical_or_right_69

logical_or_right_69:
  %t74 = load i8*, i8** %l4
  %t75 = load i8, i8* %t74
  %t76 = icmp eq i8 %t75, 13
  br label %logical_or_entry_73

logical_or_entry_73:
  br i1 %t76, label %logical_or_merge_73, label %logical_or_right_73

logical_or_right_73:
  %t77 = load i8*, i8** %l4
  %t78 = load i8, i8* %t77
  %t79 = icmp eq i8 %t78, 9
  br label %logical_or_right_end_73

logical_or_right_end_73:
  br label %logical_or_merge_73

logical_or_merge_73:
  %t80 = phi i1 [ true, %logical_or_entry_73 ], [ %t79, %logical_or_right_end_73 ]
  br label %logical_or_right_end_69

logical_or_right_end_69:
  br label %logical_or_merge_69

logical_or_merge_69:
  %t81 = phi i1 [ true, %logical_or_entry_69 ], [ %t80, %logical_or_right_end_69 ]
  br label %logical_or_right_end_65

logical_or_right_end_65:
  br label %logical_or_merge_65

logical_or_merge_65:
  %t82 = phi i1 [ true, %logical_or_entry_65 ], [ %t81, %logical_or_right_end_65 ]
  %t83 = load double, double* %l0
  %t84 = load double, double* %l1
  %t85 = load double, double* %l3
  %t86 = load i8*, i8** %l4
  br i1 %t82, label %then14, label %merge15
then14:
  %t87 = load double, double* %l1
  %t88 = sitofp i64 1 to double
  %t89 = fsub double %t87, %t88
  store double %t89, double* %l1
  br label %loop.latch10
merge15:
  br label %afterloop11
loop.latch10:
  %t90 = load double, double* %l1
  br label %loop.header8
afterloop11:
  %t92 = load double, double* %l1
  %t94 = load double, double* %l0
  %t95 = sitofp i64 0 to double
  %t96 = fcmp oeq double %t94, %t95
  br label %logical_and_entry_93

logical_and_entry_93:
  br i1 %t96, label %logical_and_right_93, label %logical_and_merge_93

logical_and_right_93:
  %t97 = load double, double* %l1
  %t98 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t99 = sitofp i64 %t98 to double
  %t100 = fcmp oeq double %t97, %t99
  br label %logical_and_right_end_93

logical_and_right_end_93:
  br label %logical_and_merge_93

logical_and_merge_93:
  %t101 = phi i1 [ false, %logical_and_entry_93 ], [ %t100, %logical_and_right_end_93 ]
  %t102 = load double, double* %l0
  %t103 = load double, double* %l1
  br i1 %t101, label %then16, label %merge17
then16:
  store i8* %value, i8** %out_result
  ret void
merge17:
  %t104 = load double, double* %l0
  %t105 = load double, double* %l1
  %t106 = call double @llvm.round.f64(double %t104)
  %t107 = fptosi double %t106 to i64
  %t108 = call double @llvm.round.f64(double %t105)
  %t109 = fptosi double %t108 to i64
  %t110 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t107, i64 %t109)
  store i8* %t110, i8** %out_result
  ret void
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
  %t28 = phi double [ %t6, %merge3 ], [ %t27, %loop.latch6 ]
  store double %t28, double* %l0
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
  %t13 = call double @llvm.round.f64(double %t12)
  %t14 = fptosi double %t13 to i64
  %t15 = getelementptr i8, i8* %value, i64 %t14
  %t16 = load i8, i8* %t15
  %t17 = load double, double* %l0
  %t18 = call double @llvm.round.f64(double %t17)
  %t19 = fptosi double %t18 to i64
  %t20 = getelementptr i8, i8* %prefix, i64 %t19
  %t21 = load i8, i8* %t20
  %t22 = icmp ne i8 %t16, %t21
  %t23 = load double, double* %l0
  br i1 %t22, label %then10, label %merge11
then10:
  ret i1 0
merge11:
  %t24 = load double, double* %l0
  %t25 = sitofp i64 1 to double
  %t26 = fadd double %t24, %t25
  store double %t26, double* %l0
  br label %loop.latch6
loop.latch6:
  %t27 = load double, double* %l0
  br label %loop.header4
afterloop7:
  %t29 = load double, double* %l0
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
  %t33 = phi double [ %t6, %merge3 ], [ %t32, %loop.latch6 ]
  store double %t33, double* %l0
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
  %t18 = call double @llvm.round.f64(double %t17)
  %t19 = fptosi double %t18 to i64
  %t20 = getelementptr i8, i8* %value, i64 %t19
  %t21 = load i8, i8* %t20
  %t22 = load double, double* %l0
  %t23 = call double @llvm.round.f64(double %t22)
  %t24 = fptosi double %t23 to i64
  %t25 = getelementptr i8, i8* %suffix, i64 %t24
  %t26 = load i8, i8* %t25
  %t27 = icmp ne i8 %t21, %t26
  %t28 = load double, double* %l0
  br i1 %t27, label %then10, label %merge11
then10:
  ret i1 0
merge11:
  %t29 = load double, double* %l0
  %t30 = sitofp i64 1 to double
  %t31 = fadd double %t29, %t30
  store double %t31, double* %l0
  br label %loop.latch6
loop.latch6:
  %t32 = load double, double* %l0
  br label %loop.header4
afterloop7:
  %t34 = load double, double* %l0
  ret i1 1
}

; NOTE: Returns string via output parameter %out_result
define void @replace_all(i8* %value, i8* %target, i8* %replacement, i8** %out_result) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i1
  %l3 = alloca double
  %t0 = call i64 @sailfin_runtime_string_length(i8* %target)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  store i8* %value, i8** %out_result
  ret void
merge1:
  %s2 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s2, i8** %l0
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l1
  %t4 = load i8*, i8** %l0
  %t5 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t84 = phi i8* [ %t4, %merge1 ], [ %t82, %loop.latch4 ]
  %t85 = phi double [ %t5, %merge1 ], [ %t83, %loop.latch4 ]
  store i8* %t84, i8** %l0
  store double %t85, double* %l1
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
  %t56 = phi i1 [ %t24, %then8 ], [ %t54, %loop.latch12 ]
  %t57 = phi double [ %t25, %then8 ], [ %t55, %loop.latch12 ]
  store i1 %t56, i1* %l2
  store double %t57, double* %l3
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
  %t37 = call double @llvm.round.f64(double %t36)
  %t38 = fptosi double %t37 to i64
  %t39 = getelementptr i8, i8* %value, i64 %t38
  %t40 = load i8, i8* %t39
  %t41 = load double, double* %l3
  %t42 = call double @llvm.round.f64(double %t41)
  %t43 = fptosi double %t42 to i64
  %t44 = getelementptr i8, i8* %target, i64 %t43
  %t45 = load i8, i8* %t44
  %t46 = icmp ne i8 %t40, %t45
  %t47 = load i8*, i8** %l0
  %t48 = load double, double* %l1
  %t49 = load i1, i1* %l2
  %t50 = load double, double* %l3
  br i1 %t46, label %then16, label %merge17
then16:
  store i1 0, i1* %l2
  br label %afterloop13
merge17:
  %t51 = load double, double* %l3
  %t52 = sitofp i64 1 to double
  %t53 = fadd double %t51, %t52
  store double %t53, double* %l3
  br label %loop.latch12
loop.latch12:
  %t54 = load i1, i1* %l2
  %t55 = load double, double* %l3
  br label %loop.header10
afterloop13:
  %t58 = load i1, i1* %l2
  %t59 = load double, double* %l3
  %t60 = load i1, i1* %l2
  %t61 = load i8*, i8** %l0
  %t62 = load double, double* %l1
  %t63 = load i1, i1* %l2
  %t64 = load double, double* %l3
  br i1 %t60, label %then18, label %merge19
then18:
  %t65 = load i8*, i8** %l0
  %t66 = call i8* @sailfin_runtime_string_concat(i8* %t65, i8* %replacement)
  store i8* %t66, i8** %l0
  %t67 = load double, double* %l1
  %t68 = call i64 @sailfin_runtime_string_length(i8* %target)
  %t69 = sitofp i64 %t68 to double
  %t70 = fadd double %t67, %t69
  store double %t70, double* %l1
  br label %loop.latch4
merge19:
  %t71 = load i8*, i8** %l0
  %t72 = load double, double* %l1
  br label %merge9
merge9:
  %t73 = phi i8* [ %t71, %merge19 ], [ %t19, %merge7 ]
  %t74 = phi double [ %t72, %merge19 ], [ %t20, %merge7 ]
  store i8* %t73, i8** %l0
  store double %t74, double* %l1
  %t75 = load i8*, i8** %l0
  %t76 = load double, double* %l1
  %t77 = call i8* @char_at(i8* %value, double %t76)
  %t78 = call i8* @sailfin_runtime_string_concat(i8* %t75, i8* %t77)
  store i8* %t78, i8** %l0
  %t79 = load double, double* %l1
  %t80 = sitofp i64 1 to double
  %t81 = fadd double %t79, %t80
  store double %t81, double* %l1
  br label %loop.latch4
loop.latch4:
  %t82 = load i8*, i8** %l0
  %t83 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t86 = load i8*, i8** %l0
  %t87 = load double, double* %l1
  %t88 = load i8*, i8** %l0
  store i8* %t88, i8** %out_result
  ret void
}

; NOTE: Returns string via output parameter %out_result
define void @join_with_separator({ i8**, i64 }* %values, i8* %separator, i8** %out_result) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %t0 = load { i8**, i64 }, { i8**, i64 }* %values
  %t1 = extractvalue { i8**, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s3, i8** %out_result
  ret void
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
  %t37 = phi i8* [ %t11, %merge1 ], [ %t35, %loop.latch4 ]
  %t38 = phi double [ %t12, %merge1 ], [ %t36, %loop.latch4 ]
  store i8* %t37, i8** %l0
  store double %t38, double* %l1
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
  %t23 = call double @llvm.round.f64(double %t22)
  %t24 = fptosi double %t23 to i64
  %t25 = load { i8**, i64 }, { i8**, i64 }* %values
  %t26 = extractvalue { i8**, i64 } %t25, 0
  %t27 = extractvalue { i8**, i64 } %t25, 1
  %t28 = icmp uge i64 %t24, %t27
  ; bounds check: %t28 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t24, i64 %t27)
  %t29 = getelementptr i8*, i8** %t26, i64 %t24
  %t30 = load i8*, i8** %t29
  %t31 = call i8* @sailfin_runtime_string_concat(i8* %t21, i8* %t30)
  store i8* %t31, i8** %l0
  %t32 = load double, double* %l1
  %t33 = sitofp i64 1 to double
  %t34 = fadd double %t32, %t33
  store double %t34, double* %l1
  br label %loop.latch4
loop.latch4:
  %t35 = load i8*, i8** %l0
  %t36 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t39 = load i8*, i8** %l0
  %t40 = load double, double* %l1
  %t41 = load i8*, i8** %l0
  store i8* %t41, i8** %out_result
  ret void
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

; NOTE: Returns string via output parameter %out_result
define void @char_at(i8* %value, double %index, i8** %out_result) {
block.entry:
  %t0 = sitofp i64 1 to double
  %t1 = fadd double %index, %t0
  %t2 = call double @llvm.round.f64(double %index)
  %t3 = fptosi double %t2 to i64
  %t4 = call double @llvm.round.f64(double %t1)
  %t5 = fptosi double %t4 to i64
  %t6 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t3, i64 %t5)
  store i8* %t6, i8** %out_result
  ret void
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
@.str.len5.h2095430042 = private unnamed_addr constant [6 x i8] c"false\00"
@.str.len3.h2089318639 = private unnamed_addr constant [4 x i8] c"Let\00"
@.str.len32.h1370567591 = private unnamed_addr constant [33 x i8] c"endfor without matching for loop\00"
@.str.len2.h193441217 = private unnamed_addr constant [3 x i8] c": \00"
@.str.len7.h739212033 = private unnamed_addr constant [8 x i8] c"EndLoop\00"
@.str.len2.h193414949 = private unnamed_addr constant [3 x i8] c"!=\00"
@.str.len10.h1629914700 = private unnamed_addr constant [11 x i8] c"Expression\00"
@.str.len22.h983476432 = private unnamed_addr constant [23 x i8] c"if field.name == item:\00"
@.str.len31.h568140000 = private unnamed_addr constant [32 x i8] c" = runtime.enum_define_variant(\00"
@.str.len2.h193515005 = private unnamed_addr constant [3 x i8] c"{{\00"
@.str.len31.h1736570074 = private unnamed_addr constant [32 x i8] c"unterminated control-flow block\00"
@.str.len2.h193481015 = private unnamed_addr constant [3 x i8] c"\5Ct\00"
@.str.len9.h320851598 = private unnamed_addr constant [10 x i8] c"index = 0\00"
@.str.len28.h430828782 = private unnamed_addr constant [29 x i8] c"def __getattr__(self, item):\00"
@.str.len4.h173287691 = private unnamed_addr constant [5 x i8] c"    \00"
@.str.len5.h2069215535 = private unnamed_addr constant [6 x i8] c"elif \00"
@.enum.NativeInstruction.EndFor.variant = private unnamed_addr constant [7 x i8] c"EndFor\00"
@.enum.NativeInstruction.EndIf.variant = private unnamed_addr constant [6 x i8] c"EndIf\00"
@.str.len7.h48777630 = private unnamed_addr constant [8 x i8] c"Unknown\00"
@.str.len29.h1122035900 = private unnamed_addr constant [30 x i8] c"endloop without matching loop\00"
@.str.len3.h2088090973 = private unnamed_addr constant [4 x i8] c", '\00"
@.str.len4.h237997259 = private unnamed_addr constant [5 x i8] c"True\00"
@.str.len5.h461434216 = private unnamed_addr constant [6 x i8] c"self.\00"
@.str.len3.h2087691079 = private unnamed_addr constant [4 x i8] c" = \00"
@.str.len6.h1258614714 = private unnamed_addr constant [7 x i8] c"EndFor\00"
@.str.len3.h2090359129 = private unnamed_addr constant [4 x i8] c"if \00"
@.str.len7.h919609845 = private unnamed_addr constant [8 x i8] c"import \00"
@.str.len2.h193459862 = private unnamed_addr constant [3 x i8] c"If\00"
@.str.len4.h228395909 = private unnamed_addr constant [5 x i8] c"Loop\00"
@.str.len7.h1558772342 = private unnamed_addr constant [8 x i8] c".length\00"
@.str.len5.h468448796 = private unnamed_addr constant [6 x i8] c"=None\00"
@.enum.NativeInstruction.EndLoop.variant = private unnamed_addr constant [8 x i8] c"EndLoop\00"
@.str.len3.h2087924125 = private unnamed_addr constant [4 x i8] c"', \00"
@.str.len18.h1456282769 = private unnamed_addr constant [19 x i8] c"return field.value\00"
@.enum.NativeInstruction.Else.variant = private unnamed_addr constant [5 x i8] c"Else\00"
@.str.len4.h270590402 = private unnamed_addr constant [5 x i8] c"pass\00"
@.str.len37.h314404344 = private unnamed_addr constant [38 x i8] c"endmatch without active match context\00"
@.str.len4.h268929446 = private unnamed_addr constant [5 x i8] c"null\00"
@.str.len2.h193478474 = private unnamed_addr constant [3 x i8] c"\5C'\00"
@.str.len8.h267355070 = private unnamed_addr constant [9 x i8] c"Continue\00"
@.str.len7.h1543377657 = private unnamed_addr constant [8 x i8] c") and (\00"
@.str.len4.h175996034 = private unnamed_addr constant [5 x i8] c" in \00"
@.str.len11.h1779553665 = private unnamed_addr constant [12 x i8] c"# effects: \00"
@.str.len4.h230767751 = private unnamed_addr constant [5 x i8] c"Noop\00"
@.str.len4.h217223495 = private unnamed_addr constant [5 x i8] c"Case\00"
@.str.len5.h1117315388 = private unnamed_addr constant [6 x i8] c"Match\00"
@.str.len12.h300877395 = private unnamed_addr constant [13 x i8] c"EnumInstance\00"
@.str.len11.h1460619898 = private unnamed_addr constant [12 x i8] c" (pattern: \00"
@.enum.NativeInstruction.Case.variant = private unnamed_addr constant [5 x i8] c"Case\00"
@.str.len22.h1038501153 = private unnamed_addr constant [23 x i8] c"runtime.struct_field('\00"
@.str.len25.h117462910 = private unnamed_addr constant [26 x i8] c"runtime.enum_instantiate(\00"
@.str.len4.h275946731 = private unnamed_addr constant [5 x i8] c"true\00"
@.str.len4.h265982546 = private unnamed_addr constant [5 x i8] c"len(\00"
@.str.len2.h193480817 = private unnamed_addr constant [3 x i8] c"\5Cn\00"
@.str.len6.h42978514 = private unnamed_addr constant [7 x i8] c"export\00"
@.enum.NativeInstruction.Unknown.variant = private unnamed_addr constant [8 x i8] c"Unknown\00"
@.str.len15.h1309566598 = private unnamed_addr constant [16 x i8] c"compiler.build.\00"
@.enum.NativeInstruction.Break.variant = private unnamed_addr constant [6 x i8] c"Break\00"
@.enum.NativeInstruction.EndMatch.variant = private unnamed_addr constant [9 x i8] c"EndMatch\00"
@.str.len39.h198700275 = private unnamed_addr constant [40 x i8] c"# unsupported: endmatch without context\00"
@.str.len8.h757831264 = private unnamed_addr constant [9 x i8] c".concat(\00"
@.str.len10.h1977847647 = private unnamed_addr constant [11 x i8] c"index += 1\00"
@.str.len4.h268720028 = private unnamed_addr constant [5 x i8] c"not \00"
@.enum.NativeInstruction.Continue.variant = private unnamed_addr constant [9 x i8] c"Continue\00"
@.enum.NativeInstruction.Match.variant = private unnamed_addr constant [6 x i8] c"Match\00"
@.str.len8.h2085806463 = private unnamed_addr constant [9 x i8] c"runtime/\00"
@.str.len5.h1776141546 = private unnamed_addr constant [6 x i8] c") + (\00"
@.str.len20.h728584192 = private unnamed_addr constant [21 x i8] c"runtime.enum_field('\00"
@.str.len8.h528348603 = private unnamed_addr constant [9 x i8] c"continue\00"
@.str.len4.h259230482 = private unnamed_addr constant [5 x i8] c"for \00"
@.str.len15.h1983072220 = private unnamed_addr constant [16 x i8] c"# unsupported: \00"
@.enum.NativeInstruction.variant.default = private unnamed_addr constant [1 x i8] c"\00"
@.enum.NativeInstruction.For.variant = private unnamed_addr constant [4 x i8] c"For\00"
@.str.len5.h2069574674 = private unnamed_addr constant [6 x i8] c"else:\00"
@.str.len41.h1804821690 = private unnamed_addr constant [42 x i8] c"# unsupported: match case without context\00"
@.str.len29.h610920064 = private unnamed_addr constant [30 x i8] c"if index >= len(self.fields):\00"
@.str.len11.h1898426375 = private unnamed_addr constant [12 x i8] c"while True:\00"
@.str.len6.h1061063223 = private unnamed_addr constant [7 x i8] c"return\00"
@.str.len7.h655348872 = private unnamed_addr constant [8 x i8] c"return \00"
@.str.len26.h1088202076 = private unnamed_addr constant [27 x i8] c"field = self.fields[index]\00"
@.enum.NativeInstruction.Loop.variant = private unnamed_addr constant [5 x i8] c"Loop\00"
@.str.len5.h819045845 = private unnamed_addr constant [6 x i8] c"EndIf\00"
@.str.len5.h843097466 = private unnamed_addr constant [6 x i8] c"False\00"
@.str.len8.h104511138 = private unnamed_addr constant [9 x i8] c"', self.\00"
@.str.len6.h653919037 = private unnamed_addr constant [7 x i8] c"', [])\00"
@.str.len2.h193517249 = private unnamed_addr constant [3 x i8] c"}}\00"
@.enum.NativeInstruction.If.variant = private unnamed_addr constant [3 x i8] c"If\00"
@.str.len5.h1958778164 = private unnamed_addr constant [6 x i8] c"break\00"
@.str.len2.h193480223 = private unnamed_addr constant [3 x i8] c"\5C\5C\00"
@.str.len6.h536277508 = private unnamed_addr constant [7 x i8] c"Return\00"
@.str.len5.h1503489441 = private unnamed_addr constant [6 x i8] c" and \00"
@.str.len4.h176216012 = private unnamed_addr constant [5 x i8] c" or \00"
@.str.len39.h2079567388 = private unnamed_addr constant [40 x i8] c"match case without active match context\00"
@.str.len4.h219990644 = private unnamed_addr constant [5 x i8] c"Else\00"
@.str.len2.h193428644 = private unnamed_addr constant [3 x i8] c"./\00"
@.enum.NativeInstruction.Return.variant = private unnamed_addr constant [7 x i8] c"Return\00"
@.str.len24.h2028465620 = private unnamed_addr constant [25 x i8] c"else without matching if\00"
@.str.len3.h2089113841 = private unnamed_addr constant [4 x i8] c"For\00"
@.str.len18.h1387621460 = private unnamed_addr constant [19 x i8] c"generated_function\00"
@.str.len2.h193479167 = private unnamed_addr constant [3 x i8] c"[]\00"
@.enum.NativeInstruction.Let.variant = private unnamed_addr constant [4 x i8] c"Let\00"
@.str.len26.h1984174475 = private unnamed_addr constant [27 x i8] c"raise AttributeError(item)\00"
@.str.len8.h794378208 = private unnamed_addr constant [9 x i8] c"EndMatch\00"
@.str.len2.h193516127 = private unnamed_addr constant [3 x i8] c"||\00"
@.str.len25.h458257002 = private unnamed_addr constant [26 x i8] c"endif without matching if\00"
@.str.len29.h1409903806 = private unnamed_addr constant [30 x i8] c"unterminated match expression\00"
@.enum.NativeInstruction.Noop.variant = private unnamed_addr constant [5 x i8] c"Noop\00"
@.str.len2.h193480949 = private unnamed_addr constant [3 x i8] c"\5Cr\00"
@.str.len4.h230766299 = private unnamed_addr constant [5 x i8] c"None\00"
@.str.len39.h1262256381 = private unnamed_addr constant [40 x i8] c"no sailfin-native-text artifact present\00"
@.str.len9.h757580446 = private unnamed_addr constant [10 x i8] c"#element:\00"
@.str.len5.h706445588 = private unnamed_addr constant [6 x i8] c"Break\00"
@.str.len42.h9444846 = private unnamed_addr constant [43 x i8] c"unsupported instruction emitted as comment\00"
@.enum.NativeInstruction.Expression.variant = private unnamed_addr constant [11 x i8] c"Expression\00"
@.str.len2.h193419635 = private unnamed_addr constant [3 x i8] c"&&\00"
