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

declare i8* @sailfin_runtime_substring(i8*, i64, i64)
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

declare i64 @sailfin_runtime_string_length(i8*)

define %LoweredPythonResult @lower_to_python(%NativeModule %native_module) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca %NativeArtifact*
  %l2 = alloca %ParseNativeResult
  %l3 = alloca %PythonModuleEmission
  %l4 = alloca i8*
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* %t2, { i8**, i64 }** %l0
  %t5 = extractvalue %NativeModule %native_module, 0
  %t6 = bitcast { %NativeArtifact**, i64 }* %t5 to { %NativeArtifact*, i64 }*
  %t7 = call %NativeArtifact* @select_text_artifact({ %NativeArtifact*, i64 }* %t6)
  store %NativeArtifact* %t7, %NativeArtifact** %l1
  %t8 = load %NativeArtifact*, %NativeArtifact** %l1
  %t9 = icmp eq %NativeArtifact* %t8, null
  %t10 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t11 = load %NativeArtifact*, %NativeArtifact** %l1
  br i1 %t9, label %then0, label %merge1
then0:
  %t12 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s13 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.len39.h1262256381, i32 0, i32 0
  %t14 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t12, i8* %s13)
  store { i8**, i64 }* %t14, { i8**, i64 }** %l0
  %s15 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t16 = insertvalue %LoweredPythonResult undef, i8* %s15, 0
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = insertvalue %LoweredPythonResult %t16, { i8**, i64 }* %t17, 1
  ret %LoweredPythonResult %t18
merge1:
  %t19 = load %NativeArtifact*, %NativeArtifact** %l1
  %t20 = getelementptr %NativeArtifact, %NativeArtifact* %t19, i32 0, i32 2
  %t21 = load i8*, i8** %t20
  %t22 = call %ParseNativeResult @parse_native_artifact(i8* %t21)
  store %ParseNativeResult %t22, %ParseNativeResult* %l2
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t24 = load %ParseNativeResult, %ParseNativeResult* %l2
  %t25 = extractvalue %ParseNativeResult %t24, 6
  %t26 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t23, { i8**, i64 }* %t25)
  store { i8**, i64 }* %t26, { i8**, i64 }** %l0
  %t27 = load %ParseNativeResult, %ParseNativeResult* %l2
  %t28 = extractvalue %ParseNativeResult %t27, 0
  %t29 = load %ParseNativeResult, %ParseNativeResult* %l2
  %t30 = extractvalue %ParseNativeResult %t29, 1
  %t31 = load %ParseNativeResult, %ParseNativeResult* %l2
  %t32 = extractvalue %ParseNativeResult %t31, 2
  %t33 = load %ParseNativeResult, %ParseNativeResult* %l2
  %t34 = extractvalue %ParseNativeResult %t33, 4
  %t35 = load %ParseNativeResult, %ParseNativeResult* %l2
  %t36 = extractvalue %ParseNativeResult %t35, 5
  %t37 = bitcast { %NativeFunction**, i64 }* %t28 to { %NativeFunction*, i64 }*
  %t38 = bitcast { %NativeImport**, i64 }* %t30 to { %NativeImport*, i64 }*
  %t39 = bitcast { %NativeStruct**, i64 }* %t32 to { %NativeStruct*, i64 }*
  %t40 = bitcast { %NativeEnum**, i64 }* %t34 to { %NativeEnum*, i64 }*
  %t41 = bitcast { %NativeBinding**, i64 }* %t36 to { %NativeBinding*, i64 }*
  %t42 = call %PythonModuleEmission @emit_python_module({ %NativeFunction*, i64 }* %t37, { %NativeImport*, i64 }* %t38, { %NativeStruct*, i64 }* %t39, { %NativeEnum*, i64 }* %t40, { %NativeBinding*, i64 }* %t41)
  store %PythonModuleEmission %t42, %PythonModuleEmission* %l3
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t44 = load %PythonModuleEmission, %PythonModuleEmission* %l3
  %t45 = extractvalue %PythonModuleEmission %t44, 1
  %t46 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t43, { i8**, i64 }* %t45)
  store { i8**, i64 }* %t46, { i8**, i64 }** %l0
  %t47 = load %PythonModuleEmission, %PythonModuleEmission* %l3
  %t48 = extractvalue %PythonModuleEmission %t47, 0
  %t49 = call i8* @builder_to_string(%PythonBuilder %t48)
  store i8* %t49, i8** %l4
  %t50 = load i8*, i8** %l4
  %t51 = insertvalue %LoweredPythonResult undef, i8* %t50, 0
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t53 = insertvalue %LoweredPythonResult %t51, { i8**, i64 }* %t52, 1
  ret %LoweredPythonResult %t53
}

define %PythonModuleEmission @emit_python_module({ %NativeFunction*, i64 }* %functions, { %NativeImport*, i64 }* %imports, { %NativeStruct*, i64 }* %structs, { %NativeEnum*, i64 }* %enums, { %NativeBinding*, i64 }* %bindings) {
entry:
  %l0 = alloca %PythonBuilder
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca %PythonImportEmission
  %l4 = alloca %PythonStructEmission
  %l5 = alloca double
  %l6 = alloca %PythonFunctionEmission
  %t0 = call %PythonBuilder @builder_new()
  store %PythonBuilder %t0, %PythonBuilder* %l0
  %t1 = alloca [0 x i8*]
  %t2 = getelementptr [0 x i8*], [0 x i8*]* %t1, i32 0, i32 0
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t2, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { i8**, i64 }* %t3, { i8**, i64 }** %l1
  %t6 = load %PythonBuilder, %PythonBuilder* %l0
  %s7 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h165481004, i32 0, i32 0
  %t8 = call %PythonBuilder @builder_emit(%PythonBuilder %t6, i8* %s7)
  store %PythonBuilder %t8, %PythonBuilder* %l0
  %t9 = load %PythonBuilder, %PythonBuilder* %l0
  %s10 = getelementptr inbounds [47 x i8], [47 x i8]* @.str.len46.h744586798, i32 0, i32 0
  %t11 = call %PythonBuilder @builder_emit(%PythonBuilder %t9, i8* %s10)
  store %PythonBuilder %t11, %PythonBuilder* %l0
  %t12 = alloca [0 x i8*]
  %t13 = getelementptr [0 x i8*], [0 x i8*]* %t12, i32 0, i32 0
  %t14 = alloca { i8**, i64 }
  %t15 = getelementptr { i8**, i64 }, { i8**, i64 }* %t14, i32 0, i32 0
  store i8** %t13, i8*** %t15
  %t16 = getelementptr { i8**, i64 }, { i8**, i64 }* %t14, i32 0, i32 1
  store i64 0, i64* %t16
  store { i8**, i64 }* %t14, { i8**, i64 }** %l2
  %t17 = load { %NativeImport*, i64 }, { %NativeImport*, i64 }* %imports
  %t18 = extractvalue { %NativeImport*, i64 } %t17, 1
  %t19 = icmp sgt i64 %t18, 0
  %t20 = load %PythonBuilder, %PythonBuilder* %l0
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t19, label %then0, label %merge1
then0:
  %t23 = load %PythonBuilder, %PythonBuilder* %l0
  %t24 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t23)
  store %PythonBuilder %t24, %PythonBuilder* %l0
  %t25 = load %PythonBuilder, %PythonBuilder* %l0
  %t26 = call %PythonImportEmission @emit_python_imports(%PythonBuilder %t25, { %NativeImport*, i64 }* %imports)
  store %PythonImportEmission %t26, %PythonImportEmission* %l3
  %t27 = load %PythonImportEmission, %PythonImportEmission* %l3
  %t28 = extractvalue %PythonImportEmission %t27, 0
  store %PythonBuilder %t28, %PythonBuilder* %l0
  %t29 = load %PythonImportEmission, %PythonImportEmission* %l3
  %t30 = extractvalue %PythonImportEmission %t29, 1
  store { i8**, i64 }* %t30, { i8**, i64 }** %l2
  br label %merge1
merge1:
  %t31 = phi %PythonBuilder [ %t24, %then0 ], [ %t20, %entry ]
  %t32 = phi %PythonBuilder [ %t28, %then0 ], [ %t20, %entry ]
  %t33 = phi { i8**, i64 }* [ %t30, %then0 ], [ %t22, %entry ]
  store %PythonBuilder %t31, %PythonBuilder* %l0
  store %PythonBuilder %t32, %PythonBuilder* %l0
  store { i8**, i64 }* %t33, { i8**, i64 }** %l2
  %t34 = load %PythonBuilder, %PythonBuilder* %l0
  %t35 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t34)
  store %PythonBuilder %t35, %PythonBuilder* %l0
  %t36 = load %PythonBuilder, %PythonBuilder* %l0
  %t37 = call %PythonBuilder @emit_runtime_aliases(%PythonBuilder %t36)
  store %PythonBuilder %t37, %PythonBuilder* %l0
  %t38 = load { %NativeBinding*, i64 }, { %NativeBinding*, i64 }* %bindings
  %t39 = extractvalue { %NativeBinding*, i64 } %t38, 1
  %t40 = icmp sgt i64 %t39, 0
  %t41 = load %PythonBuilder, %PythonBuilder* %l0
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t40, label %then2, label %merge3
then2:
  %t44 = load %PythonBuilder, %PythonBuilder* %l0
  %t45 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t44)
  store %PythonBuilder %t45, %PythonBuilder* %l0
  %t46 = load %PythonBuilder, %PythonBuilder* %l0
  %t47 = call %PythonBuilder @emit_top_level_bindings(%PythonBuilder %t46, { %NativeBinding*, i64 }* %bindings)
  store %PythonBuilder %t47, %PythonBuilder* %l0
  br label %merge3
merge3:
  %t48 = phi %PythonBuilder [ %t45, %then2 ], [ %t41, %entry ]
  %t49 = phi %PythonBuilder [ %t47, %then2 ], [ %t41, %entry ]
  store %PythonBuilder %t48, %PythonBuilder* %l0
  store %PythonBuilder %t49, %PythonBuilder* %l0
  %t50 = load { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* %enums
  %t51 = extractvalue { %NativeEnum*, i64 } %t50, 1
  %t52 = icmp sgt i64 %t51, 0
  %t53 = load %PythonBuilder, %PythonBuilder* %l0
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t52, label %then4, label %merge5
then4:
  %t56 = load %PythonBuilder, %PythonBuilder* %l0
  %t57 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t56)
  store %PythonBuilder %t57, %PythonBuilder* %l0
  %t58 = load %PythonBuilder, %PythonBuilder* %l0
  %t59 = call %PythonBuilder @emit_enum_definitions(%PythonBuilder %t58, { %NativeEnum*, i64 }* %enums)
  store %PythonBuilder %t59, %PythonBuilder* %l0
  br label %merge5
merge5:
  %t60 = phi %PythonBuilder [ %t57, %then4 ], [ %t53, %entry ]
  %t61 = phi %PythonBuilder [ %t59, %then4 ], [ %t53, %entry ]
  store %PythonBuilder %t60, %PythonBuilder* %l0
  store %PythonBuilder %t61, %PythonBuilder* %l0
  %t62 = load { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* %structs
  %t63 = extractvalue { %NativeStruct*, i64 } %t62, 1
  %t64 = icmp sgt i64 %t63, 0
  %t65 = load %PythonBuilder, %PythonBuilder* %l0
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t64, label %then6, label %merge7
then6:
  %t68 = load %PythonBuilder, %PythonBuilder* %l0
  %t69 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t68)
  store %PythonBuilder %t69, %PythonBuilder* %l0
  %t70 = load %PythonBuilder, %PythonBuilder* %l0
  %t71 = call %PythonStructEmission @emit_struct_definitions(%PythonBuilder %t70, { %NativeStruct*, i64 }* %structs)
  store %PythonStructEmission %t71, %PythonStructEmission* %l4
  %t72 = load %PythonStructEmission, %PythonStructEmission* %l4
  %t73 = extractvalue %PythonStructEmission %t72, 0
  store %PythonBuilder %t73, %PythonBuilder* %l0
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t75 = load %PythonStructEmission, %PythonStructEmission* %l4
  %t76 = extractvalue %PythonStructEmission %t75, 1
  %t77 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t74, { i8**, i64 }* %t76)
  store { i8**, i64 }* %t77, { i8**, i64 }** %l1
  br label %merge7
merge7:
  %t78 = phi %PythonBuilder [ %t69, %then6 ], [ %t65, %entry ]
  %t79 = phi %PythonBuilder [ %t73, %then6 ], [ %t65, %entry ]
  %t80 = phi { i8**, i64 }* [ %t77, %then6 ], [ %t66, %entry ]
  store %PythonBuilder %t78, %PythonBuilder* %l0
  store %PythonBuilder %t79, %PythonBuilder* %l0
  store { i8**, i64 }* %t80, { i8**, i64 }** %l1
  %t81 = load %PythonBuilder, %PythonBuilder* %l0
  %t82 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t81)
  store %PythonBuilder %t82, %PythonBuilder* %l0
  %t83 = sitofp i64 0 to double
  store double %t83, double* %l5
  %t84 = load %PythonBuilder, %PythonBuilder* %l0
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t86 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t87 = load double, double* %l5
  br label %loop.header8
loop.header8:
  %t134 = phi %PythonBuilder [ %t84, %entry ], [ %t131, %loop.latch10 ]
  %t135 = phi { i8**, i64 }* [ %t85, %entry ], [ %t132, %loop.latch10 ]
  %t136 = phi double [ %t87, %entry ], [ %t133, %loop.latch10 ]
  store %PythonBuilder %t134, %PythonBuilder* %l0
  store { i8**, i64 }* %t135, { i8**, i64 }** %l1
  store double %t136, double* %l5
  br label %loop.body9
loop.body9:
  %t88 = load double, double* %l5
  %t89 = load { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %functions
  %t90 = extractvalue { %NativeFunction*, i64 } %t89, 1
  %t91 = sitofp i64 %t90 to double
  %t92 = fcmp oge double %t88, %t91
  %t93 = load %PythonBuilder, %PythonBuilder* %l0
  %t94 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t95 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t96 = load double, double* %l5
  br i1 %t92, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t97 = load %PythonBuilder, %PythonBuilder* %l0
  %t98 = load double, double* %l5
  %t99 = fptosi double %t98 to i64
  %t100 = load { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %functions
  %t101 = extractvalue { %NativeFunction*, i64 } %t100, 0
  %t102 = extractvalue { %NativeFunction*, i64 } %t100, 1
  %t103 = icmp uge i64 %t99, %t102
  ; bounds check: %t103 (if true, out of bounds)
  %t104 = getelementptr %NativeFunction, %NativeFunction* %t101, i64 %t99
  %t105 = load %NativeFunction, %NativeFunction* %t104
  %t106 = call %PythonFunctionEmission @emit_python_function(%PythonBuilder %t97, %NativeFunction %t105)
  store %PythonFunctionEmission %t106, %PythonFunctionEmission* %l6
  %t107 = load %PythonFunctionEmission, %PythonFunctionEmission* %l6
  %t108 = extractvalue %PythonFunctionEmission %t107, 0
  store %PythonBuilder %t108, %PythonBuilder* %l0
  %t109 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t110 = load %PythonFunctionEmission, %PythonFunctionEmission* %l6
  %t111 = extractvalue %PythonFunctionEmission %t110, 1
  %t112 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t109, { i8**, i64 }* %t111)
  store { i8**, i64 }* %t112, { i8**, i64 }** %l1
  %t113 = load double, double* %l5
  %t114 = sitofp i64 1 to double
  %t115 = fadd double %t113, %t114
  %t116 = load { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %functions
  %t117 = extractvalue { %NativeFunction*, i64 } %t116, 1
  %t118 = sitofp i64 %t117 to double
  %t119 = fcmp olt double %t115, %t118
  %t120 = load %PythonBuilder, %PythonBuilder* %l0
  %t121 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t122 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t123 = load double, double* %l5
  %t124 = load %PythonFunctionEmission, %PythonFunctionEmission* %l6
  br i1 %t119, label %then14, label %merge15
then14:
  %t125 = load %PythonBuilder, %PythonBuilder* %l0
  %t126 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t125)
  store %PythonBuilder %t126, %PythonBuilder* %l0
  br label %merge15
merge15:
  %t127 = phi %PythonBuilder [ %t126, %then14 ], [ %t120, %loop.body9 ]
  store %PythonBuilder %t127, %PythonBuilder* %l0
  %t128 = load double, double* %l5
  %t129 = sitofp i64 1 to double
  %t130 = fadd double %t128, %t129
  store double %t130, double* %l5
  br label %loop.latch10
loop.latch10:
  %t131 = load %PythonBuilder, %PythonBuilder* %l0
  %t132 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t133 = load double, double* %l5
  br label %loop.header8
afterloop11:
  %t137 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t138 = load { i8**, i64 }, { i8**, i64 }* %t137
  %t139 = extractvalue { i8**, i64 } %t138, 1
  %t140 = icmp sgt i64 %t139, 0
  %t141 = load %PythonBuilder, %PythonBuilder* %l0
  %t142 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t143 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t144 = load double, double* %l5
  br i1 %t140, label %then16, label %merge17
then16:
  %t145 = load %PythonBuilder, %PythonBuilder* %l0
  %t146 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t145)
  store %PythonBuilder %t146, %PythonBuilder* %l0
  %t147 = load %PythonBuilder, %PythonBuilder* %l0
  %t148 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t149 = call %PythonBuilder @emit_export_list(%PythonBuilder %t147, { i8**, i64 }* %t148)
  store %PythonBuilder %t149, %PythonBuilder* %l0
  br label %merge17
merge17:
  %t150 = phi %PythonBuilder [ %t146, %then16 ], [ %t141, %entry ]
  %t151 = phi %PythonBuilder [ %t149, %then16 ], [ %t141, %entry ]
  store %PythonBuilder %t150, %PythonBuilder* %l0
  store %PythonBuilder %t151, %PythonBuilder* %l0
  %t152 = load %PythonBuilder, %PythonBuilder* %l0
  %t153 = insertvalue %PythonModuleEmission undef, %PythonBuilder %t152, 0
  %t154 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t155 = insertvalue %PythonModuleEmission %t153, { i8**, i64 }* %t154, 1
  ret %PythonModuleEmission %t155
}

define %PythonBuilder @emit_runtime_aliases(%PythonBuilder %builder) {
entry:
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
entry:
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
  %t50 = phi %PythonBuilder [ %t1, %entry ], [ %t48, %loop.latch2 ]
  %t51 = phi double [ %t2, %entry ], [ %t49, %loop.latch2 ]
  store %PythonBuilder %t50, %PythonBuilder* %l0
  store double %t51, double* %l1
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
  br label %merge8
else7:
  %t38 = load i8*, i8** %l4
  %s39 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h230766299, i32 0, i32 0
  %t40 = call i8* @sailfin_runtime_string_concat(i8* %t38, i8* %s39)
  store i8* %t40, i8** %l4
  br label %merge8
merge8:
  %t41 = phi i8* [ %t37, %then6 ], [ %t40, %else7 ]
  store i8* %t41, i8** %l4
  %t42 = load %PythonBuilder, %PythonBuilder* %l0
  %t43 = load i8*, i8** %l4
  %t44 = call %PythonBuilder @builder_emit(%PythonBuilder %t42, i8* %t43)
  store %PythonBuilder %t44, %PythonBuilder* %l0
  %t45 = load double, double* %l1
  %t46 = sitofp i64 1 to double
  %t47 = fadd double %t45, %t46
  store double %t47, double* %l1
  br label %loop.latch2
loop.latch2:
  %t48 = load %PythonBuilder, %PythonBuilder* %l0
  %t49 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t52 = load %PythonBuilder, %PythonBuilder* %l0
  ret %PythonBuilder %t52
}

define %PythonImportEmission @emit_python_imports(%PythonBuilder %builder, { %NativeImport*, i64 }* %imports) {
entry:
  %l0 = alloca %PythonBuilder
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca %NativeImport
  %l4 = alloca i8*
  %l5 = alloca i8*
  store %PythonBuilder %builder, %PythonBuilder* %l0
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* %t2, { i8**, i64 }** %l1
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l2
  %t6 = load %PythonBuilder, %PythonBuilder* %l0
  %t7 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t8 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t74 = phi { i8**, i64 }* [ %t7, %entry ], [ %t71, %loop.latch2 ]
  %t75 = phi double [ %t8, %entry ], [ %t72, %loop.latch2 ]
  %t76 = phi %PythonBuilder [ %t6, %entry ], [ %t73, %loop.latch2 ]
  store { i8**, i64 }* %t74, { i8**, i64 }** %l1
  store double %t75, double* %l2
  store %PythonBuilder %t76, %PythonBuilder* %l0
  br label %loop.body1
loop.body1:
  %t9 = load double, double* %l2
  %t10 = load { %NativeImport*, i64 }, { %NativeImport*, i64 }* %imports
  %t11 = extractvalue { %NativeImport*, i64 } %t10, 1
  %t12 = sitofp i64 %t11 to double
  %t13 = fcmp oge double %t9, %t12
  %t14 = load %PythonBuilder, %PythonBuilder* %l0
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t16 = load double, double* %l2
  br i1 %t13, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t17 = load double, double* %l2
  %t18 = fptosi double %t17 to i64
  %t19 = load { %NativeImport*, i64 }, { %NativeImport*, i64 }* %imports
  %t20 = extractvalue { %NativeImport*, i64 } %t19, 0
  %t21 = extractvalue { %NativeImport*, i64 } %t19, 1
  %t22 = icmp uge i64 %t18, %t21
  ; bounds check: %t22 (if true, out of bounds)
  %t23 = getelementptr %NativeImport, %NativeImport* %t20, i64 %t18
  %t24 = load %NativeImport, %NativeImport* %t23
  store %NativeImport %t24, %NativeImport* %l3
  %t25 = load %NativeImport, %NativeImport* %l3
  %t26 = extractvalue %NativeImport %t25, 0
  %s27 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h42978514, i32 0, i32 0
  %t28 = icmp eq i8* %t26, %s27
  %t29 = load %PythonBuilder, %PythonBuilder* %l0
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t31 = load double, double* %l2
  %t32 = load %NativeImport, %NativeImport* %l3
  br i1 %t28, label %then6, label %merge7
then6:
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t34 = load %NativeImport, %NativeImport* %l3
  %t35 = extractvalue %NativeImport %t34, 2
  %t36 = bitcast { %NativeImportSpecifier**, i64 }* %t35 to { %NativeImportSpecifier*, i64 }*
  %t37 = call { i8**, i64 }* @collect_export_names({ i8**, i64 }* %t33, { %NativeImportSpecifier*, i64 }* %t36)
  store { i8**, i64 }* %t37, { i8**, i64 }** %l1
  %t38 = load %NativeImport, %NativeImport* %l3
  %t39 = extractvalue %NativeImport %t38, 1
  %t40 = call i8* @trim_text(i8* %t39)
  store i8* %t40, i8** %l4
  %t41 = load i8*, i8** %l4
  %t42 = call i64 @sailfin_runtime_string_length(i8* %t41)
  %t43 = icmp eq i64 %t42, 0
  %t44 = load %PythonBuilder, %PythonBuilder* %l0
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t46 = load double, double* %l2
  %t47 = load %NativeImport, %NativeImport* %l3
  %t48 = load i8*, i8** %l4
  br i1 %t43, label %then8, label %merge9
then8:
  %t49 = load double, double* %l2
  %t50 = sitofp i64 1 to double
  %t51 = fadd double %t49, %t50
  store double %t51, double* %l2
  br label %loop.latch2
merge9:
  br label %merge7
merge7:
  %t52 = phi { i8**, i64 }* [ %t37, %then6 ], [ %t30, %loop.body1 ]
  %t53 = phi double [ %t51, %then6 ], [ %t31, %loop.body1 ]
  store { i8**, i64 }* %t52, { i8**, i64 }** %l1
  store double %t53, double* %l2
  %t54 = load %NativeImport, %NativeImport* %l3
  %t55 = call i8* @render_python_import(%NativeImport %t54)
  store i8* %t55, i8** %l5
  %t56 = load i8*, i8** %l5
  %t57 = call i64 @sailfin_runtime_string_length(i8* %t56)
  %t58 = icmp sgt i64 %t57, 0
  %t59 = load %PythonBuilder, %PythonBuilder* %l0
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t61 = load double, double* %l2
  %t62 = load %NativeImport, %NativeImport* %l3
  %t63 = load i8*, i8** %l5
  br i1 %t58, label %then10, label %merge11
then10:
  %t64 = load %PythonBuilder, %PythonBuilder* %l0
  %t65 = load i8*, i8** %l5
  %t66 = call %PythonBuilder @builder_emit(%PythonBuilder %t64, i8* %t65)
  store %PythonBuilder %t66, %PythonBuilder* %l0
  br label %merge11
merge11:
  %t67 = phi %PythonBuilder [ %t66, %then10 ], [ %t59, %loop.body1 ]
  store %PythonBuilder %t67, %PythonBuilder* %l0
  %t68 = load double, double* %l2
  %t69 = sitofp i64 1 to double
  %t70 = fadd double %t68, %t69
  store double %t70, double* %l2
  br label %loop.latch2
loop.latch2:
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t72 = load double, double* %l2
  %t73 = load %PythonBuilder, %PythonBuilder* %l0
  br label %loop.header0
afterloop3:
  %t77 = load %PythonBuilder, %PythonBuilder* %l0
  %t78 = insertvalue %PythonImportEmission undef, %PythonBuilder %t77, 0
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t80 = insertvalue %PythonImportEmission %t78, { i8**, i64 }* %t79, 1
  ret %PythonImportEmission %t80
}

define %PythonBuilder @emit_enum_definitions(%PythonBuilder %builder, { %NativeEnum*, i64 }* %enums) {
entry:
  %l0 = alloca %PythonBuilder
  %l1 = alloca double
  store %PythonBuilder %builder, %PythonBuilder* %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load %PythonBuilder, %PythonBuilder* %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t37 = phi %PythonBuilder [ %t1, %entry ], [ %t35, %loop.latch2 ]
  %t38 = phi double [ %t2, %entry ], [ %t36, %loop.latch2 ]
  store %PythonBuilder %t37, %PythonBuilder* %l0
  store double %t38, double* %l1
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
  br label %merge7
merge7:
  %t31 = phi %PythonBuilder [ %t30, %then6 ], [ %t27, %loop.body1 ]
  store %PythonBuilder %t31, %PythonBuilder* %l0
  %t32 = load double, double* %l1
  %t33 = sitofp i64 1 to double
  %t34 = fadd double %t32, %t33
  store double %t34, double* %l1
  br label %loop.latch2
loop.latch2:
  %t35 = load %PythonBuilder, %PythonBuilder* %l0
  %t36 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t39 = load %PythonBuilder, %PythonBuilder* %l0
  ret %PythonBuilder %t39
}

define %PythonBuilder @emit_single_enum(%PythonBuilder %builder, %NativeEnum %definition) {
entry:
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
  %t63 = phi %PythonBuilder [ %t12, %entry ], [ %t61, %loop.latch2 ]
  %t64 = phi double [ %t13, %entry ], [ %t62, %loop.latch2 ]
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
  ret %PythonBuilder %t65
}

define i8* @render_enum_variant_fields({ %NativeEnumVariantField*, i64 }* %fields) {
entry:
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
  %t4 = alloca [0 x i8*]
  %t5 = getelementptr [0 x i8*], [0 x i8*]* %t4, i32 0, i32 0
  %t6 = alloca { i8**, i64 }
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %t6, i32 0, i32 0
  store i8** %t5, i8*** %t7
  %t8 = getelementptr { i8**, i64 }, { i8**, i64 }* %t6, i32 0, i32 1
  store i64 0, i64* %t8
  store { i8**, i64 }* %t6, { i8**, i64 }** %l0
  %t9 = sitofp i64 0 to double
  store double %t9, double* %l1
  %t10 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t11 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t43 = phi { i8**, i64 }* [ %t10, %entry ], [ %t41, %loop.latch4 ]
  %t44 = phi double [ %t11, %entry ], [ %t42, %loop.latch4 ]
  store { i8**, i64 }* %t43, { i8**, i64 }** %l0
  store double %t44, double* %l1
  br label %loop.body3
loop.body3:
  %t12 = load double, double* %l1
  %t13 = load { %NativeEnumVariantField*, i64 }, { %NativeEnumVariantField*, i64 }* %fields
  %t14 = extractvalue { %NativeEnumVariantField*, i64 } %t13, 1
  %t15 = sitofp i64 %t14 to double
  %t16 = fcmp oge double %t12, %t15
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = load double, double* %l1
  br i1 %t16, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t20 = load double, double* %l1
  %t21 = fptosi double %t20 to i64
  %t22 = load { %NativeEnumVariantField*, i64 }, { %NativeEnumVariantField*, i64 }* %fields
  %t23 = extractvalue { %NativeEnumVariantField*, i64 } %t22, 0
  %t24 = extractvalue { %NativeEnumVariantField*, i64 } %t22, 1
  %t25 = icmp uge i64 %t21, %t24
  ; bounds check: %t25 (if true, out of bounds)
  %t26 = getelementptr %NativeEnumVariantField, %NativeEnumVariantField* %t23, i64 %t21
  %t27 = load %NativeEnumVariantField, %NativeEnumVariantField* %t26
  %t28 = extractvalue %NativeEnumVariantField %t27, 0
  %t29 = call i8* @sanitize_identifier(i8* %t28)
  %t30 = load i8, i8* %t29
  %t31 = add i8 39, %t30
  %t32 = add i8 %t31, 39
  %t33 = alloca [2 x i8], align 1
  %t34 = getelementptr [2 x i8], [2 x i8]* %t33, i32 0, i32 0
  store i8 %t32, i8* %t34
  %t35 = getelementptr [2 x i8], [2 x i8]* %t33, i32 0, i32 1
  store i8 0, i8* %t35
  %t36 = getelementptr [2 x i8], [2 x i8]* %t33, i32 0, i32 0
  %t37 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t19, i8* %t36)
  store { i8**, i64 }* %t37, { i8**, i64 }** %l0
  %t38 = load double, double* %l1
  %t39 = sitofp i64 1 to double
  %t40 = fadd double %t38, %t39
  store double %t40, double* %l1
  br label %loop.latch4
loop.latch4:
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t42 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s46 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t47 = call i8* @join_with_separator({ i8**, i64 }* %t45, i8* %s46)
  ret i8* %t47
}

define i8* @render_python_import(%NativeImport %entry) {
entry:
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
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* %t2, { i8**, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t31 = phi { i8**, i64 }* [ %t6, %entry ], [ %t29, %loop.latch2 ]
  %t32 = phi double [ %t7, %entry ], [ %t30, %loop.latch2 ]
  store { i8**, i64 }* %t31, { i8**, i64 }** %l0
  store double %t32, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %specifiers
  %t10 = extractvalue { %NativeImportSpecifier*, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t16 = load double, double* %l1
  %t17 = fptosi double %t16 to i64
  %t18 = load { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %specifiers
  %t19 = extractvalue { %NativeImportSpecifier*, i64 } %t18, 0
  %t20 = extractvalue { %NativeImportSpecifier*, i64 } %t18, 1
  %t21 = icmp uge i64 %t17, %t20
  ; bounds check: %t21 (if true, out of bounds)
  %t22 = getelementptr %NativeImportSpecifier, %NativeImportSpecifier* %t19, i64 %t17
  %t23 = load %NativeImportSpecifier, %NativeImportSpecifier* %t22
  %t24 = call i8* @render_python_specifier(%NativeImportSpecifier %t23)
  %t25 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t15, i8* %t24)
  store { i8**, i64 }* %t25, { i8**, i64 }** %l0
  %t26 = load double, double* %l1
  %t27 = sitofp i64 1 to double
  %t28 = fadd double %t26, %t27
  store double %t28, double* %l1
  br label %loop.latch2
loop.latch2:
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t30 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s34 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t35 = call i8* @join_with_separator({ i8**, i64 }* %t33, i8* %s34)
  ret i8* %t35
}

define i8* @render_python_specifier(%NativeImportSpecifier %specifier) {
entry:
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
entry:
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
entry:
  %l0 = alloca %PythonBuilder
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca %PythonStructEmission
  store %PythonBuilder %builder, %PythonBuilder* %l0
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* %t2, { i8**, i64 }** %l1
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l2
  %t6 = load %PythonBuilder, %PythonBuilder* %l0
  %t7 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t8 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t53 = phi %PythonBuilder [ %t6, %entry ], [ %t50, %loop.latch2 ]
  %t54 = phi { i8**, i64 }* [ %t7, %entry ], [ %t51, %loop.latch2 ]
  %t55 = phi double [ %t8, %entry ], [ %t52, %loop.latch2 ]
  store %PythonBuilder %t53, %PythonBuilder* %l0
  store { i8**, i64 }* %t54, { i8**, i64 }** %l1
  store double %t55, double* %l2
  br label %loop.body1
loop.body1:
  %t9 = load double, double* %l2
  %t10 = load { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* %structs
  %t11 = extractvalue { %NativeStruct*, i64 } %t10, 1
  %t12 = sitofp i64 %t11 to double
  %t13 = fcmp oge double %t9, %t12
  %t14 = load %PythonBuilder, %PythonBuilder* %l0
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t16 = load double, double* %l2
  br i1 %t13, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t17 = load %PythonBuilder, %PythonBuilder* %l0
  %t18 = load double, double* %l2
  %t19 = fptosi double %t18 to i64
  %t20 = load { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* %structs
  %t21 = extractvalue { %NativeStruct*, i64 } %t20, 0
  %t22 = extractvalue { %NativeStruct*, i64 } %t20, 1
  %t23 = icmp uge i64 %t19, %t22
  ; bounds check: %t23 (if true, out of bounds)
  %t24 = getelementptr %NativeStruct, %NativeStruct* %t21, i64 %t19
  %t25 = load %NativeStruct, %NativeStruct* %t24
  %t26 = call %PythonStructEmission @emit_single_struct(%PythonBuilder %t17, %NativeStruct %t25)
  store %PythonStructEmission %t26, %PythonStructEmission* %l3
  %t27 = load %PythonStructEmission, %PythonStructEmission* %l3
  %t28 = extractvalue %PythonStructEmission %t27, 0
  store %PythonBuilder %t28, %PythonBuilder* %l0
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t30 = load %PythonStructEmission, %PythonStructEmission* %l3
  %t31 = extractvalue %PythonStructEmission %t30, 1
  %t32 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t29, { i8**, i64 }* %t31)
  store { i8**, i64 }* %t32, { i8**, i64 }** %l1
  %t33 = load double, double* %l2
  %t34 = sitofp i64 1 to double
  %t35 = fadd double %t33, %t34
  %t36 = load { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* %structs
  %t37 = extractvalue { %NativeStruct*, i64 } %t36, 1
  %t38 = sitofp i64 %t37 to double
  %t39 = fcmp olt double %t35, %t38
  %t40 = load %PythonBuilder, %PythonBuilder* %l0
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t42 = load double, double* %l2
  %t43 = load %PythonStructEmission, %PythonStructEmission* %l3
  br i1 %t39, label %then6, label %merge7
then6:
  %t44 = load %PythonBuilder, %PythonBuilder* %l0
  %t45 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t44)
  store %PythonBuilder %t45, %PythonBuilder* %l0
  br label %merge7
merge7:
  %t46 = phi %PythonBuilder [ %t45, %then6 ], [ %t40, %loop.body1 ]
  store %PythonBuilder %t46, %PythonBuilder* %l0
  %t47 = load double, double* %l2
  %t48 = sitofp i64 1 to double
  %t49 = fadd double %t47, %t48
  store double %t49, double* %l2
  br label %loop.latch2
loop.latch2:
  %t50 = load %PythonBuilder, %PythonBuilder* %l0
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t52 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t56 = load %PythonBuilder, %PythonBuilder* %l0
  %t57 = insertvalue %PythonStructEmission undef, %PythonBuilder %t56, 0
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t59 = insertvalue %PythonStructEmission %t57, { i8**, i64 }* %t58, 1
  ret %PythonStructEmission %t59
}

define %PythonBuilder @emit_export_list(%PythonBuilder %builder, { i8**, i64 }* %exports) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca i1
  %l4 = alloca double
  %l5 = alloca { i8**, i64 }*
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* %t2, { i8**, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t80 = phi { i8**, i64 }* [ %t6, %entry ], [ %t78, %loop.latch2 ]
  %t81 = phi double [ %t7, %entry ], [ %t79, %loop.latch2 ]
  store { i8**, i64 }* %t80, { i8**, i64 }** %l0
  store double %t81, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { i8**, i64 }, { i8**, i64 }* %exports
  %t10 = extractvalue { i8**, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l1
  %t16 = fptosi double %t15 to i64
  %t17 = load { i8**, i64 }, { i8**, i64 }* %exports
  %t18 = extractvalue { i8**, i64 } %t17, 0
  %t19 = extractvalue { i8**, i64 } %t17, 1
  %t20 = icmp uge i64 %t16, %t19
  ; bounds check: %t20 (if true, out of bounds)
  %t21 = getelementptr i8*, i8** %t18, i64 %t16
  %t22 = load i8*, i8** %t21
  %t23 = call i8* @sanitize_identifier(i8* %t22)
  store i8* %t23, i8** %l2
  store i1 0, i1* %l3
  %t24 = sitofp i64 0 to double
  store double %t24, double* %l4
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t26 = load double, double* %l1
  %t27 = load i8*, i8** %l2
  %t28 = load i1, i1* %l3
  %t29 = load double, double* %l4
  br label %loop.header6
loop.header6:
  %t62 = phi i1 [ %t28, %loop.body1 ], [ %t60, %loop.latch8 ]
  %t63 = phi double [ %t29, %loop.body1 ], [ %t61, %loop.latch8 ]
  store i1 %t62, i1* %l3
  store double %t63, double* %l4
  br label %loop.body7
loop.body7:
  %t30 = load double, double* %l4
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t32 = load { i8**, i64 }, { i8**, i64 }* %t31
  %t33 = extractvalue { i8**, i64 } %t32, 1
  %t34 = sitofp i64 %t33 to double
  %t35 = fcmp oge double %t30, %t34
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t37 = load double, double* %l1
  %t38 = load i8*, i8** %l2
  %t39 = load i1, i1* %l3
  %t40 = load double, double* %l4
  br i1 %t35, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t42 = load double, double* %l4
  %t43 = fptosi double %t42 to i64
  %t44 = load { i8**, i64 }, { i8**, i64 }* %t41
  %t45 = extractvalue { i8**, i64 } %t44, 0
  %t46 = extractvalue { i8**, i64 } %t44, 1
  %t47 = icmp uge i64 %t43, %t46
  ; bounds check: %t47 (if true, out of bounds)
  %t48 = getelementptr i8*, i8** %t45, i64 %t43
  %t49 = load i8*, i8** %t48
  %t50 = load i8*, i8** %l2
  %t51 = icmp eq i8* %t49, %t50
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t53 = load double, double* %l1
  %t54 = load i8*, i8** %l2
  %t55 = load i1, i1* %l3
  %t56 = load double, double* %l4
  br i1 %t51, label %then12, label %merge13
then12:
  store i1 1, i1* %l3
  br label %afterloop9
merge13:
  %t57 = load double, double* %l4
  %t58 = sitofp i64 1 to double
  %t59 = fadd double %t57, %t58
  store double %t59, double* %l4
  br label %loop.latch8
loop.latch8:
  %t60 = load i1, i1* %l3
  %t61 = load double, double* %l4
  br label %loop.header6
afterloop9:
  %t64 = load i1, i1* %l3
  %t65 = xor i1 %t64, 1
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t67 = load double, double* %l1
  %t68 = load i8*, i8** %l2
  %t69 = load i1, i1* %l3
  %t70 = load double, double* %l4
  br i1 %t65, label %then14, label %merge15
then14:
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t72 = load i8*, i8** %l2
  %t73 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t71, i8* %t72)
  store { i8**, i64 }* %t73, { i8**, i64 }** %l0
  br label %merge15
merge15:
  %t74 = phi { i8**, i64 }* [ %t73, %then14 ], [ %t66, %loop.body1 ]
  store { i8**, i64 }* %t74, { i8**, i64 }** %l0
  %t75 = load double, double* %l1
  %t76 = sitofp i64 1 to double
  %t77 = fadd double %t75, %t76
  store double %t77, double* %l1
  br label %loop.latch2
loop.latch2:
  %t78 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t79 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t82 = alloca [0 x i8*]
  %t83 = getelementptr [0 x i8*], [0 x i8*]* %t82, i32 0, i32 0
  %t84 = alloca { i8**, i64 }
  %t85 = getelementptr { i8**, i64 }, { i8**, i64 }* %t84, i32 0, i32 0
  store i8** %t83, i8*** %t85
  %t86 = getelementptr { i8**, i64 }, { i8**, i64 }* %t84, i32 0, i32 1
  store i64 0, i64* %t86
  store { i8**, i64 }* %t84, { i8**, i64 }** %l5
  %t87 = sitofp i64 0 to double
  store double %t87, double* %l1
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t89 = load double, double* %l1
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %l5
  br label %loop.header16
loop.header16:
  %t123 = phi { i8**, i64 }* [ %t90, %entry ], [ %t121, %loop.latch18 ]
  %t124 = phi double [ %t89, %entry ], [ %t122, %loop.latch18 ]
  store { i8**, i64 }* %t123, { i8**, i64 }** %l5
  store double %t124, double* %l1
  br label %loop.body17
loop.body17:
  %t91 = load double, double* %l1
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t93 = load { i8**, i64 }, { i8**, i64 }* %t92
  %t94 = extractvalue { i8**, i64 } %t93, 1
  %t95 = sitofp i64 %t94 to double
  %t96 = fcmp oge double %t91, %t95
  %t97 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t98 = load double, double* %l1
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l5
  br i1 %t96, label %then20, label %merge21
then20:
  br label %afterloop19
merge21:
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t101 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t102 = load double, double* %l1
  %t103 = fptosi double %t102 to i64
  %t104 = load { i8**, i64 }, { i8**, i64 }* %t101
  %t105 = extractvalue { i8**, i64 } %t104, 0
  %t106 = extractvalue { i8**, i64 } %t104, 1
  %t107 = icmp uge i64 %t103, %t106
  ; bounds check: %t107 (if true, out of bounds)
  %t108 = getelementptr i8*, i8** %t105, i64 %t103
  %t109 = load i8*, i8** %t108
  %t110 = load i8, i8* %t109
  %t111 = add i8 34, %t110
  %t112 = add i8 %t111, 34
  %t113 = alloca [2 x i8], align 1
  %t114 = getelementptr [2 x i8], [2 x i8]* %t113, i32 0, i32 0
  store i8 %t112, i8* %t114
  %t115 = getelementptr [2 x i8], [2 x i8]* %t113, i32 0, i32 1
  store i8 0, i8* %t115
  %t116 = getelementptr [2 x i8], [2 x i8]* %t113, i32 0, i32 0
  %t117 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t100, i8* %t116)
  store { i8**, i64 }* %t117, { i8**, i64 }** %l5
  %t118 = load double, double* %l1
  %t119 = sitofp i64 1 to double
  %t120 = fadd double %t118, %t119
  store double %t120, double* %l1
  br label %loop.latch18
loop.latch18:
  %t121 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t122 = load double, double* %l1
  br label %loop.header16
afterloop19:
  %s125 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1657754115, i32 0, i32 0
  %t126 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %s127 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t128 = call i8* @join_with_separator({ i8**, i64 }* %t126, i8* %s127)
  %t129 = call i8* @sailfin_runtime_string_concat(i8* %s125, i8* %t128)
  %t130 = load i8, i8* %t129
  %t131 = add i8 %t130, 93
  %t132 = alloca [2 x i8], align 1
  %t133 = getelementptr [2 x i8], [2 x i8]* %t132, i32 0, i32 0
  store i8 %t131, i8* %t133
  %t134 = getelementptr [2 x i8], [2 x i8]* %t132, i32 0, i32 1
  store i8 0, i8* %t134
  %t135 = getelementptr [2 x i8], [2 x i8]* %t132, i32 0, i32 0
  %t136 = call %PythonBuilder @builder_emit(%PythonBuilder %builder, i8* %t135)
  ret %PythonBuilder %t136
}

define { i8**, i64 }* @collect_export_names({ i8**, i64 }* %existing, { %NativeImportSpecifier*, i64 }* %specifiers) {
entry:
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
  %t36 = phi { i8**, i64 }* [ %t1, %entry ], [ %t34, %loop.latch2 ]
  %t37 = phi double [ %t2, %entry ], [ %t35, %loop.latch2 ]
  store { i8**, i64 }* %t36, { i8**, i64 }** %l0
  store double %t37, double* %l1
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
  br label %merge7
merge7:
  %t30 = phi { i8**, i64 }* [ %t29, %then6 ], [ %t23, %loop.body1 ]
  store { i8**, i64 }* %t30, { i8**, i64 }** %l0
  %t31 = load double, double* %l1
  %t32 = sitofp i64 1 to double
  %t33 = fadd double %t31, %t32
  store double %t33, double* %l1
  br label %loop.latch2
loop.latch2:
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t35 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t38
}

define i8* @select_export_name(%NativeImportSpecifier %specifier) {
entry:
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
entry:
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
  %t5 = load i8, i8* %t4
  %t6 = add i8 %t5, 58
  %t7 = alloca [2 x i8], align 1
  %t8 = getelementptr [2 x i8], [2 x i8]* %t7, i32 0, i32 0
  store i8 %t6, i8* %t8
  %t9 = getelementptr [2 x i8], [2 x i8]* %t7, i32 0, i32 1
  store i8 0, i8* %t9
  %t10 = getelementptr [2 x i8], [2 x i8]* %t7, i32 0, i32 0
  %t11 = call %PythonBuilder @builder_emit(%PythonBuilder %builder, i8* %t10)
  store %PythonBuilder %t11, %PythonBuilder* %l1
  %t12 = load %PythonBuilder, %PythonBuilder* %l1
  %t13 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t12)
  store %PythonBuilder %t13, %PythonBuilder* %l1
  %t14 = alloca [0 x i8*]
  %t15 = getelementptr [0 x i8*], [0 x i8*]* %t14, i32 0, i32 0
  %t16 = alloca { i8**, i64 }
  %t17 = getelementptr { i8**, i64 }, { i8**, i64 }* %t16, i32 0, i32 0
  store i8** %t15, i8*** %t17
  %t18 = getelementptr { i8**, i64 }, { i8**, i64 }* %t16, i32 0, i32 1
  store i64 0, i64* %t18
  store { i8**, i64 }* %t16, { i8**, i64 }** %l2
  %t19 = extractvalue %NativeStruct %definition, 1
  %t20 = bitcast { %NativeStructField**, i64 }* %t19 to { %NativeStructField*, i64 }*
  %t21 = call { i8**, i64 }* @render_struct_parameters({ %NativeStructField*, i64 }* %t20)
  store { i8**, i64 }* %t21, { i8**, i64 }** %l3
  %s22 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h215787497, i32 0, i32 0
  store i8* %s22, i8** %l4
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t24 = load { i8**, i64 }, { i8**, i64 }* %t23
  %t25 = extractvalue { i8**, i64 } %t24, 1
  %t26 = icmp sgt i64 %t25, 0
  %t27 = load i8*, i8** %l0
  %t28 = load %PythonBuilder, %PythonBuilder* %l1
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t31 = load i8*, i8** %l4
  br i1 %t26, label %then0, label %merge1
then0:
  %t32 = load i8*, i8** %l4
  %s33 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t34 = call i8* @sailfin_runtime_string_concat(i8* %t32, i8* %s33)
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %s36 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t37 = call i8* @join_with_separator({ i8**, i64 }* %t35, i8* %s36)
  %t38 = call i8* @sailfin_runtime_string_concat(i8* %t34, i8* %t37)
  store i8* %t38, i8** %l4
  br label %merge1
merge1:
  %t39 = phi i8* [ %t38, %then0 ], [ %t31, %entry ]
  store i8* %t39, i8** %l4
  %t40 = load i8*, i8** %l4
  %t41 = load i8, i8* %t40
  %t42 = add i8 %t41, 41
  %t43 = alloca [2 x i8], align 1
  %t44 = getelementptr [2 x i8], [2 x i8]* %t43, i32 0, i32 0
  store i8 %t42, i8* %t44
  %t45 = getelementptr [2 x i8], [2 x i8]* %t43, i32 0, i32 1
  store i8 0, i8* %t45
  %t46 = getelementptr [2 x i8], [2 x i8]* %t43, i32 0, i32 0
  store i8* %t46, i8** %l4
  %t47 = load %PythonBuilder, %PythonBuilder* %l1
  %t48 = load i8*, i8** %l4
  %t49 = load i8, i8* %t48
  %t50 = add i8 %t49, 58
  %t51 = alloca [2 x i8], align 1
  %t52 = getelementptr [2 x i8], [2 x i8]* %t51, i32 0, i32 0
  store i8 %t50, i8* %t52
  %t53 = getelementptr [2 x i8], [2 x i8]* %t51, i32 0, i32 1
  store i8 0, i8* %t53
  %t54 = getelementptr [2 x i8], [2 x i8]* %t51, i32 0, i32 0
  %t55 = call %PythonBuilder @builder_emit(%PythonBuilder %t47, i8* %t54)
  store %PythonBuilder %t55, %PythonBuilder* %l1
  %t56 = load %PythonBuilder, %PythonBuilder* %l1
  %t57 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t56)
  store %PythonBuilder %t57, %PythonBuilder* %l1
  %t58 = extractvalue %NativeStruct %definition, 1
  %t59 = load { %NativeStructField**, i64 }, { %NativeStructField**, i64 }* %t58
  %t60 = extractvalue { %NativeStructField**, i64 } %t59, 1
  %t61 = icmp eq i64 %t60, 0
  %t62 = load i8*, i8** %l0
  %t63 = load %PythonBuilder, %PythonBuilder* %l1
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t66 = load i8*, i8** %l4
  br i1 %t61, label %then2, label %else3
then2:
  %t67 = load %PythonBuilder, %PythonBuilder* %l1
  %s68 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h270590402, i32 0, i32 0
  %t69 = call %PythonBuilder @builder_emit(%PythonBuilder %t67, i8* %s68)
  store %PythonBuilder %t69, %PythonBuilder* %l1
  br label %merge4
else3:
  %t70 = sitofp i64 0 to double
  store double %t70, double* %l5
  %t71 = load i8*, i8** %l0
  %t72 = load %PythonBuilder, %PythonBuilder* %l1
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t75 = load i8*, i8** %l4
  %t76 = load double, double* %l5
  br label %loop.header5
loop.header5:
  %t116 = phi %PythonBuilder [ %t72, %else3 ], [ %t114, %loop.latch7 ]
  %t117 = phi double [ %t76, %else3 ], [ %t115, %loop.latch7 ]
  store %PythonBuilder %t116, %PythonBuilder* %l1
  store double %t117, double* %l5
  br label %loop.body6
loop.body6:
  %t77 = load double, double* %l5
  %t78 = extractvalue %NativeStruct %definition, 1
  %t79 = load { %NativeStructField**, i64 }, { %NativeStructField**, i64 }* %t78
  %t80 = extractvalue { %NativeStructField**, i64 } %t79, 1
  %t81 = sitofp i64 %t80 to double
  %t82 = fcmp oge double %t77, %t81
  %t83 = load i8*, i8** %l0
  %t84 = load %PythonBuilder, %PythonBuilder* %l1
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t86 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t87 = load i8*, i8** %l4
  %t88 = load double, double* %l5
  br i1 %t82, label %then9, label %merge10
then9:
  br label %afterloop8
merge10:
  %t89 = extractvalue %NativeStruct %definition, 1
  %t90 = load double, double* %l5
  %t91 = fptosi double %t90 to i64
  %t92 = load { %NativeStructField**, i64 }, { %NativeStructField**, i64 }* %t89
  %t93 = extractvalue { %NativeStructField**, i64 } %t92, 0
  %t94 = extractvalue { %NativeStructField**, i64 } %t92, 1
  %t95 = icmp uge i64 %t91, %t94
  ; bounds check: %t95 (if true, out of bounds)
  %t96 = getelementptr %NativeStructField*, %NativeStructField** %t93, i64 %t91
  %t97 = load %NativeStructField*, %NativeStructField** %t96
  store %NativeStructField* %t97, %NativeStructField** %l6
  %t98 = load %NativeStructField*, %NativeStructField** %l6
  %t99 = getelementptr %NativeStructField, %NativeStructField* %t98, i32 0, i32 0
  %t100 = load i8*, i8** %t99
  %t101 = call i8* @sanitize_identifier(i8* %t100)
  store i8* %t101, i8** %l7
  %t102 = load %PythonBuilder, %PythonBuilder* %l1
  %s103 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h461434216, i32 0, i32 0
  %t104 = load i8*, i8** %l7
  %t105 = call i8* @sailfin_runtime_string_concat(i8* %s103, i8* %t104)
  %s106 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087691079, i32 0, i32 0
  %t107 = call i8* @sailfin_runtime_string_concat(i8* %t105, i8* %s106)
  %t108 = load i8*, i8** %l7
  %t109 = call i8* @sailfin_runtime_string_concat(i8* %t107, i8* %t108)
  %t110 = call %PythonBuilder @builder_emit(%PythonBuilder %t102, i8* %t109)
  store %PythonBuilder %t110, %PythonBuilder* %l1
  %t111 = load double, double* %l5
  %t112 = sitofp i64 1 to double
  %t113 = fadd double %t111, %t112
  store double %t113, double* %l5
  br label %loop.latch7
loop.latch7:
  %t114 = load %PythonBuilder, %PythonBuilder* %l1
  %t115 = load double, double* %l5
  br label %loop.header5
afterloop8:
  br label %merge4
merge4:
  %t118 = phi %PythonBuilder [ %t69, %then2 ], [ %t110, %else3 ]
  store %PythonBuilder %t118, %PythonBuilder* %l1
  %t119 = load %PythonBuilder, %PythonBuilder* %l1
  %t120 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t119)
  store %PythonBuilder %t120, %PythonBuilder* %l1
  %t121 = load %PythonBuilder, %PythonBuilder* %l1
  %t122 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t121)
  store %PythonBuilder %t122, %PythonBuilder* %l1
  %t123 = load %PythonBuilder, %PythonBuilder* %l1
  %s124 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h1806641125, i32 0, i32 0
  %t125 = call %PythonBuilder @builder_emit(%PythonBuilder %t123, i8* %s124)
  store %PythonBuilder %t125, %PythonBuilder* %l1
  %t126 = load %PythonBuilder, %PythonBuilder* %l1
  %t127 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t126)
  store %PythonBuilder %t127, %PythonBuilder* %l1
  %t128 = load i8*, i8** %l0
  %t129 = extractvalue %NativeStruct %definition, 1
  %t130 = bitcast { %NativeStructField**, i64 }* %t129 to { %NativeStructField*, i64 }*
  %t131 = call i8* @render_struct_repr_fields(i8* %t128, { %NativeStructField*, i64 }* %t130)
  store i8* %t131, i8** %l8
  %t132 = load %PythonBuilder, %PythonBuilder* %l1
  %t133 = load i8*, i8** %l8
  %t134 = call %PythonBuilder @builder_emit(%PythonBuilder %t132, i8* %t133)
  store %PythonBuilder %t134, %PythonBuilder* %l1
  %t135 = load %PythonBuilder, %PythonBuilder* %l1
  %t136 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t135)
  store %PythonBuilder %t136, %PythonBuilder* %l1
  %t137 = load i8*, i8** %l0
  %s138 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h300877395, i32 0, i32 0
  %t139 = icmp eq i8* %t137, %s138
  %t140 = load i8*, i8** %l0
  %t141 = load %PythonBuilder, %PythonBuilder* %l1
  %t142 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t143 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t144 = load i8*, i8** %l4
  %t145 = load i8*, i8** %l8
  br i1 %t139, label %then11, label %merge12
then11:
  %t146 = load %PythonBuilder, %PythonBuilder* %l1
  %t147 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t146)
  store %PythonBuilder %t147, %PythonBuilder* %l1
  %t148 = load %PythonBuilder, %PythonBuilder* %l1
  %s149 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.len28.h430828782, i32 0, i32 0
  %t150 = call %PythonBuilder @builder_emit(%PythonBuilder %t148, i8* %s149)
  store %PythonBuilder %t150, %PythonBuilder* %l1
  %t151 = load %PythonBuilder, %PythonBuilder* %l1
  %t152 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t151)
  store %PythonBuilder %t152, %PythonBuilder* %l1
  %t153 = load %PythonBuilder, %PythonBuilder* %l1
  %s154 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h320851598, i32 0, i32 0
  %t155 = call %PythonBuilder @builder_emit(%PythonBuilder %t153, i8* %s154)
  store %PythonBuilder %t155, %PythonBuilder* %l1
  %t156 = load %PythonBuilder, %PythonBuilder* %l1
  %s157 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1898426375, i32 0, i32 0
  %t158 = call %PythonBuilder @builder_emit(%PythonBuilder %t156, i8* %s157)
  store %PythonBuilder %t158, %PythonBuilder* %l1
  %t159 = load %PythonBuilder, %PythonBuilder* %l1
  %t160 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t159)
  store %PythonBuilder %t160, %PythonBuilder* %l1
  %t161 = load %PythonBuilder, %PythonBuilder* %l1
  %s162 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.len29.h610920064, i32 0, i32 0
  %t163 = call %PythonBuilder @builder_emit(%PythonBuilder %t161, i8* %s162)
  store %PythonBuilder %t163, %PythonBuilder* %l1
  %t164 = load %PythonBuilder, %PythonBuilder* %l1
  %t165 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t164)
  store %PythonBuilder %t165, %PythonBuilder* %l1
  %t166 = load %PythonBuilder, %PythonBuilder* %l1
  %s167 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1958778164, i32 0, i32 0
  %t168 = call %PythonBuilder @builder_emit(%PythonBuilder %t166, i8* %s167)
  store %PythonBuilder %t168, %PythonBuilder* %l1
  %t169 = load %PythonBuilder, %PythonBuilder* %l1
  %t170 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t169)
  store %PythonBuilder %t170, %PythonBuilder* %l1
  %t171 = load %PythonBuilder, %PythonBuilder* %l1
  %s172 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.len26.h1088202076, i32 0, i32 0
  %t173 = call %PythonBuilder @builder_emit(%PythonBuilder %t171, i8* %s172)
  store %PythonBuilder %t173, %PythonBuilder* %l1
  %t174 = load %PythonBuilder, %PythonBuilder* %l1
  %s175 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h983476432, i32 0, i32 0
  %t176 = call %PythonBuilder @builder_emit(%PythonBuilder %t174, i8* %s175)
  store %PythonBuilder %t176, %PythonBuilder* %l1
  %t177 = load %PythonBuilder, %PythonBuilder* %l1
  %t178 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t177)
  store %PythonBuilder %t178, %PythonBuilder* %l1
  %t179 = load %PythonBuilder, %PythonBuilder* %l1
  %s180 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.len18.h1456282769, i32 0, i32 0
  %t181 = call %PythonBuilder @builder_emit(%PythonBuilder %t179, i8* %s180)
  store %PythonBuilder %t181, %PythonBuilder* %l1
  %t182 = load %PythonBuilder, %PythonBuilder* %l1
  %t183 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t182)
  store %PythonBuilder %t183, %PythonBuilder* %l1
  %t184 = load %PythonBuilder, %PythonBuilder* %l1
  %s185 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h1977847647, i32 0, i32 0
  %t186 = call %PythonBuilder @builder_emit(%PythonBuilder %t184, i8* %s185)
  store %PythonBuilder %t186, %PythonBuilder* %l1
  %t187 = load %PythonBuilder, %PythonBuilder* %l1
  %t188 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t187)
  store %PythonBuilder %t188, %PythonBuilder* %l1
  %t189 = load %PythonBuilder, %PythonBuilder* %l1
  %s190 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.len26.h1984174475, i32 0, i32 0
  %t191 = call %PythonBuilder @builder_emit(%PythonBuilder %t189, i8* %s190)
  store %PythonBuilder %t191, %PythonBuilder* %l1
  %t192 = load %PythonBuilder, %PythonBuilder* %l1
  %t193 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t192)
  store %PythonBuilder %t193, %PythonBuilder* %l1
  br label %merge12
merge12:
  %t194 = phi %PythonBuilder [ %t147, %then11 ], [ %t141, %entry ]
  %t195 = phi %PythonBuilder [ %t150, %then11 ], [ %t141, %entry ]
  %t196 = phi %PythonBuilder [ %t152, %then11 ], [ %t141, %entry ]
  %t197 = phi %PythonBuilder [ %t155, %then11 ], [ %t141, %entry ]
  %t198 = phi %PythonBuilder [ %t158, %then11 ], [ %t141, %entry ]
  %t199 = phi %PythonBuilder [ %t160, %then11 ], [ %t141, %entry ]
  %t200 = phi %PythonBuilder [ %t163, %then11 ], [ %t141, %entry ]
  %t201 = phi %PythonBuilder [ %t165, %then11 ], [ %t141, %entry ]
  %t202 = phi %PythonBuilder [ %t168, %then11 ], [ %t141, %entry ]
  %t203 = phi %PythonBuilder [ %t170, %then11 ], [ %t141, %entry ]
  %t204 = phi %PythonBuilder [ %t173, %then11 ], [ %t141, %entry ]
  %t205 = phi %PythonBuilder [ %t176, %then11 ], [ %t141, %entry ]
  %t206 = phi %PythonBuilder [ %t178, %then11 ], [ %t141, %entry ]
  %t207 = phi %PythonBuilder [ %t181, %then11 ], [ %t141, %entry ]
  %t208 = phi %PythonBuilder [ %t183, %then11 ], [ %t141, %entry ]
  %t209 = phi %PythonBuilder [ %t186, %then11 ], [ %t141, %entry ]
  %t210 = phi %PythonBuilder [ %t188, %then11 ], [ %t141, %entry ]
  %t211 = phi %PythonBuilder [ %t191, %then11 ], [ %t141, %entry ]
  %t212 = phi %PythonBuilder [ %t193, %then11 ], [ %t141, %entry ]
  store %PythonBuilder %t194, %PythonBuilder* %l1
  store %PythonBuilder %t195, %PythonBuilder* %l1
  store %PythonBuilder %t196, %PythonBuilder* %l1
  store %PythonBuilder %t197, %PythonBuilder* %l1
  store %PythonBuilder %t198, %PythonBuilder* %l1
  store %PythonBuilder %t199, %PythonBuilder* %l1
  store %PythonBuilder %t200, %PythonBuilder* %l1
  store %PythonBuilder %t201, %PythonBuilder* %l1
  store %PythonBuilder %t202, %PythonBuilder* %l1
  store %PythonBuilder %t203, %PythonBuilder* %l1
  store %PythonBuilder %t204, %PythonBuilder* %l1
  store %PythonBuilder %t205, %PythonBuilder* %l1
  store %PythonBuilder %t206, %PythonBuilder* %l1
  store %PythonBuilder %t207, %PythonBuilder* %l1
  store %PythonBuilder %t208, %PythonBuilder* %l1
  store %PythonBuilder %t209, %PythonBuilder* %l1
  store %PythonBuilder %t210, %PythonBuilder* %l1
  store %PythonBuilder %t211, %PythonBuilder* %l1
  store %PythonBuilder %t212, %PythonBuilder* %l1
  %t213 = extractvalue %NativeStruct %definition, 2
  %t214 = load { %NativeFunction**, i64 }, { %NativeFunction**, i64 }* %t213
  %t215 = extractvalue { %NativeFunction**, i64 } %t214, 1
  %t216 = icmp sgt i64 %t215, 0
  %t217 = load i8*, i8** %l0
  %t218 = load %PythonBuilder, %PythonBuilder* %l1
  %t219 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t220 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t221 = load i8*, i8** %l4
  %t222 = load i8*, i8** %l8
  br i1 %t216, label %then13, label %merge14
then13:
  %t223 = load %PythonBuilder, %PythonBuilder* %l1
  %t224 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t223)
  store %PythonBuilder %t224, %PythonBuilder* %l1
  %t225 = sitofp i64 0 to double
  store double %t225, double* %l9
  %t226 = load i8*, i8** %l0
  %t227 = load %PythonBuilder, %PythonBuilder* %l1
  %t228 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t229 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t230 = load i8*, i8** %l4
  %t231 = load i8*, i8** %l8
  %t232 = load double, double* %l9
  br label %loop.header15
loop.header15:
  %t291 = phi %PythonBuilder [ %t227, %then13 ], [ %t288, %loop.latch17 ]
  %t292 = phi { i8**, i64 }* [ %t228, %then13 ], [ %t289, %loop.latch17 ]
  %t293 = phi double [ %t232, %then13 ], [ %t290, %loop.latch17 ]
  store %PythonBuilder %t291, %PythonBuilder* %l1
  store { i8**, i64 }* %t292, { i8**, i64 }** %l2
  store double %t293, double* %l9
  br label %loop.body16
loop.body16:
  %t233 = load double, double* %l9
  %t234 = extractvalue %NativeStruct %definition, 2
  %t235 = load { %NativeFunction**, i64 }, { %NativeFunction**, i64 }* %t234
  %t236 = extractvalue { %NativeFunction**, i64 } %t235, 1
  %t237 = sitofp i64 %t236 to double
  %t238 = fcmp oge double %t233, %t237
  %t239 = load i8*, i8** %l0
  %t240 = load %PythonBuilder, %PythonBuilder* %l1
  %t241 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t242 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t243 = load i8*, i8** %l4
  %t244 = load i8*, i8** %l8
  %t245 = load double, double* %l9
  br i1 %t238, label %then19, label %merge20
then19:
  br label %afterloop18
merge20:
  %t246 = extractvalue %NativeStruct %definition, 2
  %t247 = load double, double* %l9
  %t248 = fptosi double %t247 to i64
  %t249 = load { %NativeFunction**, i64 }, { %NativeFunction**, i64 }* %t246
  %t250 = extractvalue { %NativeFunction**, i64 } %t249, 0
  %t251 = extractvalue { %NativeFunction**, i64 } %t249, 1
  %t252 = icmp uge i64 %t248, %t251
  ; bounds check: %t252 (if true, out of bounds)
  %t253 = getelementptr %NativeFunction*, %NativeFunction** %t250, i64 %t248
  %t254 = load %NativeFunction*, %NativeFunction** %t253
  store %NativeFunction* %t254, %NativeFunction** %l10
  %t255 = load %PythonBuilder, %PythonBuilder* %l1
  %t256 = load %NativeFunction*, %NativeFunction** %l10
  %t257 = load %NativeFunction, %NativeFunction* %t256
  %t258 = call %PythonFunctionEmission @emit_python_function(%PythonBuilder %t255, %NativeFunction %t257)
  store %PythonFunctionEmission %t258, %PythonFunctionEmission* %l11
  %t259 = load %PythonFunctionEmission, %PythonFunctionEmission* %l11
  %t260 = extractvalue %PythonFunctionEmission %t259, 0
  store %PythonBuilder %t260, %PythonBuilder* %l1
  %t261 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t262 = load %PythonFunctionEmission, %PythonFunctionEmission* %l11
  %t263 = extractvalue %PythonFunctionEmission %t262, 1
  %t264 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t261, { i8**, i64 }* %t263)
  store { i8**, i64 }* %t264, { i8**, i64 }** %l2
  %t265 = load double, double* %l9
  %t266 = sitofp i64 1 to double
  %t267 = fadd double %t265, %t266
  %t268 = extractvalue %NativeStruct %definition, 2
  %t269 = load { %NativeFunction**, i64 }, { %NativeFunction**, i64 }* %t268
  %t270 = extractvalue { %NativeFunction**, i64 } %t269, 1
  %t271 = sitofp i64 %t270 to double
  %t272 = fcmp olt double %t267, %t271
  %t273 = load i8*, i8** %l0
  %t274 = load %PythonBuilder, %PythonBuilder* %l1
  %t275 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t276 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t277 = load i8*, i8** %l4
  %t278 = load i8*, i8** %l8
  %t279 = load double, double* %l9
  %t280 = load %NativeFunction*, %NativeFunction** %l10
  %t281 = load %PythonFunctionEmission, %PythonFunctionEmission* %l11
  br i1 %t272, label %then21, label %merge22
then21:
  %t282 = load %PythonBuilder, %PythonBuilder* %l1
  %t283 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t282)
  store %PythonBuilder %t283, %PythonBuilder* %l1
  br label %merge22
merge22:
  %t284 = phi %PythonBuilder [ %t283, %then21 ], [ %t274, %loop.body16 ]
  store %PythonBuilder %t284, %PythonBuilder* %l1
  %t285 = load double, double* %l9
  %t286 = sitofp i64 1 to double
  %t287 = fadd double %t285, %t286
  store double %t287, double* %l9
  br label %loop.latch17
loop.latch17:
  %t288 = load %PythonBuilder, %PythonBuilder* %l1
  %t289 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t290 = load double, double* %l9
  br label %loop.header15
afterloop18:
  br label %merge14
merge14:
  %t294 = phi %PythonBuilder [ %t224, %then13 ], [ %t218, %entry ]
  %t295 = phi %PythonBuilder [ %t260, %then13 ], [ %t218, %entry ]
  %t296 = phi { i8**, i64 }* [ %t264, %then13 ], [ %t219, %entry ]
  %t297 = phi %PythonBuilder [ %t283, %then13 ], [ %t218, %entry ]
  store %PythonBuilder %t294, %PythonBuilder* %l1
  store %PythonBuilder %t295, %PythonBuilder* %l1
  store { i8**, i64 }* %t296, { i8**, i64 }** %l2
  store %PythonBuilder %t297, %PythonBuilder* %l1
  %t298 = load %PythonBuilder, %PythonBuilder* %l1
  %t299 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t298)
  store %PythonBuilder %t299, %PythonBuilder* %l1
  %t300 = load %PythonBuilder, %PythonBuilder* %l1
  %t301 = insertvalue %PythonStructEmission undef, %PythonBuilder %t300, 0
  %t302 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t303 = insertvalue %PythonStructEmission %t301, { i8**, i64 }* %t302, 1
  ret %PythonStructEmission %t303
}

define { i8**, i64 }* @render_struct_parameters({ %NativeStructField*, i64 }* %fields) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca %NativeStructField
  %l4 = alloca i8*
  %l5 = alloca i8*
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* %t2, { i8**, i64 }** %l0
  %t5 = alloca [0 x i8*]
  %t6 = getelementptr [0 x i8*], [0 x i8*]* %t5, i32 0, i32 0
  %t7 = alloca { i8**, i64 }
  %t8 = getelementptr { i8**, i64 }, { i8**, i64 }* %t7, i32 0, i32 0
  store i8** %t6, i8*** %t8
  %t9 = getelementptr { i8**, i64 }, { i8**, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  store { i8**, i64 }* %t7, { i8**, i64 }** %l1
  %t10 = sitofp i64 0 to double
  store double %t10, double* %l2
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t12 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t13 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t61 = phi { i8**, i64 }* [ %t12, %entry ], [ %t58, %loop.latch2 ]
  %t62 = phi { i8**, i64 }* [ %t11, %entry ], [ %t59, %loop.latch2 ]
  %t63 = phi double [ %t13, %entry ], [ %t60, %loop.latch2 ]
  store { i8**, i64 }* %t61, { i8**, i64 }** %l1
  store { i8**, i64 }* %t62, { i8**, i64 }** %l0
  store double %t63, double* %l2
  br label %loop.body1
loop.body1:
  %t14 = load double, double* %l2
  %t15 = load { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %fields
  %t16 = extractvalue { %NativeStructField*, i64 } %t15, 1
  %t17 = sitofp i64 %t16 to double
  %t18 = fcmp oge double %t14, %t17
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t21 = load double, double* %l2
  br i1 %t18, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t22 = load double, double* %l2
  %t23 = fptosi double %t22 to i64
  %t24 = load { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %fields
  %t25 = extractvalue { %NativeStructField*, i64 } %t24, 0
  %t26 = extractvalue { %NativeStructField*, i64 } %t24, 1
  %t27 = icmp uge i64 %t23, %t26
  ; bounds check: %t27 (if true, out of bounds)
  %t28 = getelementptr %NativeStructField, %NativeStructField* %t25, i64 %t23
  %t29 = load %NativeStructField, %NativeStructField* %t28
  store %NativeStructField %t29, %NativeStructField* %l3
  %t30 = load %NativeStructField, %NativeStructField* %l3
  %t31 = extractvalue %NativeStructField %t30, 0
  %t32 = call i8* @sanitize_identifier(i8* %t31)
  store i8* %t32, i8** %l4
  %t33 = load i8*, i8** %l4
  store i8* %t33, i8** %l5
  %t34 = load %NativeStructField, %NativeStructField* %l3
  %t35 = extractvalue %NativeStructField %t34, 1
  %t36 = call i1 @is_optional_type(i8* %t35)
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t39 = load double, double* %l2
  %t40 = load %NativeStructField, %NativeStructField* %l3
  %t41 = load i8*, i8** %l4
  %t42 = load i8*, i8** %l5
  br i1 %t36, label %then6, label %else7
then6:
  %t43 = load i8*, i8** %l5
  %s44 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h468448796, i32 0, i32 0
  %t45 = call i8* @sailfin_runtime_string_concat(i8* %t43, i8* %s44)
  store i8* %t45, i8** %l5
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t47 = load i8*, i8** %l5
  %t48 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t46, i8* %t47)
  store { i8**, i64 }* %t48, { i8**, i64 }** %l1
  br label %merge8
else7:
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t50 = load i8*, i8** %l5
  %t51 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t49, i8* %t50)
  store { i8**, i64 }* %t51, { i8**, i64 }** %l0
  br label %merge8
merge8:
  %t52 = phi i8* [ %t45, %then6 ], [ %t42, %else7 ]
  %t53 = phi { i8**, i64 }* [ %t48, %then6 ], [ %t38, %else7 ]
  %t54 = phi { i8**, i64 }* [ %t37, %then6 ], [ %t51, %else7 ]
  store i8* %t52, i8** %l5
  store { i8**, i64 }* %t53, { i8**, i64 }** %l1
  store { i8**, i64 }* %t54, { i8**, i64 }** %l0
  %t55 = load double, double* %l2
  %t56 = sitofp i64 1 to double
  %t57 = fadd double %t55, %t56
  store double %t57, double* %l2
  br label %loop.latch2
loop.latch2:
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t60 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t66 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t64, { i8**, i64 }* %t65)
  ret { i8**, i64 }* %t66
}

define i8* @render_struct_repr_fields(i8* %class_name, { %NativeStructField*, i64 }* %fields) {
entry:
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
  %t7 = alloca [0 x i8*]
  %t8 = getelementptr [0 x i8*], [0 x i8*]* %t7, i32 0, i32 0
  %t9 = alloca { i8**, i64 }
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 0
  store i8** %t8, i8*** %t10
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { i8**, i64 }* %t9, { i8**, i64 }** %l0
  %t12 = sitofp i64 0 to double
  store double %t12, double* %l1
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t53 = phi { i8**, i64 }* [ %t13, %entry ], [ %t51, %loop.latch4 ]
  %t54 = phi double [ %t14, %entry ], [ %t52, %loop.latch4 ]
  store { i8**, i64 }* %t53, { i8**, i64 }** %l0
  store double %t54, double* %l1
  br label %loop.body3
loop.body3:
  %t15 = load double, double* %l1
  %t16 = load { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %fields
  %t17 = extractvalue { %NativeStructField*, i64 } %t16, 1
  %t18 = sitofp i64 %t17 to double
  %t19 = fcmp oge double %t15, %t18
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t21 = load double, double* %l1
  br i1 %t19, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t22 = load double, double* %l1
  %t23 = fptosi double %t22 to i64
  %t24 = load { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %fields
  %t25 = extractvalue { %NativeStructField*, i64 } %t24, 0
  %t26 = extractvalue { %NativeStructField*, i64 } %t24, 1
  %t27 = icmp uge i64 %t23, %t26
  ; bounds check: %t27 (if true, out of bounds)
  %t28 = getelementptr %NativeStructField, %NativeStructField* %t25, i64 %t23
  %t29 = load %NativeStructField, %NativeStructField* %t28
  store %NativeStructField %t29, %NativeStructField* %l2
  %t30 = load %NativeStructField, %NativeStructField* %l2
  %t31 = extractvalue %NativeStructField %t30, 0
  %t32 = call i8* @sanitize_identifier(i8* %t31)
  store i8* %t32, i8** %l3
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s34 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h1038501153, i32 0, i32 0
  %t35 = load i8*, i8** %l3
  %t36 = call i8* @sailfin_runtime_string_concat(i8* %s34, i8* %t35)
  %s37 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h104511138, i32 0, i32 0
  %t38 = call i8* @sailfin_runtime_string_concat(i8* %t36, i8* %s37)
  %t39 = load i8*, i8** %l3
  %t40 = call i8* @sailfin_runtime_string_concat(i8* %t38, i8* %t39)
  %t41 = load i8, i8* %t40
  %t42 = add i8 %t41, 41
  %t43 = alloca [2 x i8], align 1
  %t44 = getelementptr [2 x i8], [2 x i8]* %t43, i32 0, i32 0
  store i8 %t42, i8* %t44
  %t45 = getelementptr [2 x i8], [2 x i8]* %t43, i32 0, i32 1
  store i8 0, i8* %t45
  %t46 = getelementptr [2 x i8], [2 x i8]* %t43, i32 0, i32 0
  %t47 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t33, i8* %t46)
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
  %s55 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.len28.h1179318158, i32 0, i32 0
  %t56 = call i8* @sailfin_runtime_string_concat(i8* %s55, i8* %class_name)
  %s57 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h182022329, i32 0, i32 0
  %t58 = call i8* @sailfin_runtime_string_concat(i8* %t56, i8* %s57)
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s60 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t61 = call i8* @join_with_separator({ i8**, i64 }* %t59, i8* %s60)
  %t62 = call i8* @sailfin_runtime_string_concat(i8* %t58, i8* %t61)
  %s63 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193479629, i32 0, i32 0
  %t64 = call i8* @sailfin_runtime_string_concat(i8* %t62, i8* %s63)
  ret i8* %t64
}

define i1 @is_optional_type(i8* %type_annotation) {
entry:
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
entry:
  %t0 = sitofp i64 0 to double
  %t1 = call i8* @lower_expression_with_depth(i8* %expression, double %t0)
  ret i8* %t1
}

define i8* @lower_expression_with_depth(i8* %expression, double %depth) {
entry:
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
entry:
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
  %l12 = alloca i8
  %l13 = alloca i8
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
  %t18 = alloca [0 x i8*]
  %t19 = getelementptr [0 x i8*], [0 x i8*]* %t18, i32 0, i32 0
  %t20 = alloca { i8**, i64 }
  %t21 = getelementptr { i8**, i64 }, { i8**, i64 }* %t20, i32 0, i32 0
  store i8** %t19, i8*** %t21
  %t22 = getelementptr { i8**, i64 }, { i8**, i64 }* %t20, i32 0, i32 1
  store i64 0, i64* %t22
  store { i8**, i64 }* %t20, { i8**, i64 }** %l1
  %t23 = alloca [0 x i8*]
  %t24 = getelementptr [0 x i8*], [0 x i8*]* %t23, i32 0, i32 0
  %t25 = alloca { i8**, i64 }
  %t26 = getelementptr { i8**, i64 }, { i8**, i64 }* %t25, i32 0, i32 0
  store i8** %t24, i8*** %t26
  %t27 = getelementptr { i8**, i64 }, { i8**, i64 }* %t25, i32 0, i32 1
  store i64 0, i64* %t27
  store { i8**, i64 }* %t25, { i8**, i64 }** %l2
  store i64 0, i64* %l3
  %t28 = load i8*, i8** %l0
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t31 = load i64, i64* %l3
  br label %loop.header8
loop.header8:
  %t115 = phi { i8**, i64 }* [ %t29, %entry ], [ %t112, %loop.latch10 ]
  %t116 = phi { i8**, i64 }* [ %t30, %entry ], [ %t113, %loop.latch10 ]
  %t117 = phi i64 [ %t31, %entry ], [ %t114, %loop.latch10 ]
  store { i8**, i64 }* %t115, { i8**, i64 }** %l1
  store { i8**, i64 }* %t116, { i8**, i64 }** %l2
  store i64 %t117, i64* %l3
  br label %loop.body9
loop.body9:
  %t32 = load i64, i64* %l3
  %t33 = load i8*, i8** %l0
  %t34 = call i64 @sailfin_runtime_string_length(i8* %t33)
  %t35 = icmp sgt i64 %t32, %t34
  %t36 = load i8*, i8** %l0
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t39 = load i64, i64* %l3
  br i1 %t35, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t40 = load i8*, i8** %l0
  %s41 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193515005, i32 0, i32 0
  %t42 = load i64, i64* %l3
  %t43 = sitofp i64 %t42 to double
  %t44 = call double @find_substring_from(i8* %t40, i8* %s41, double %t43)
  store double %t44, double* %l4
  %t45 = load double, double* %l4
  %t46 = sitofp i64 0 to double
  %t47 = fcmp olt double %t45, %t46
  %t48 = load i8*, i8** %l0
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t51 = load i64, i64* %l3
  %t52 = load double, double* %l4
  br i1 %t47, label %then14, label %merge15
then14:
  %t53 = load i8*, i8** %l0
  %t54 = load i64, i64* %l3
  %t55 = load i8*, i8** %l0
  %t56 = call i64 @sailfin_runtime_string_length(i8* %t55)
  %t57 = call i8* @sailfin_runtime_substring(i8* %t53, i64 %t54, i64 %t56)
  store i8* %t57, i8** %l5
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t59 = load i8*, i8** %l5
  %t60 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t58, i8* %t59)
  store { i8**, i64 }* %t60, { i8**, i64 }** %l1
  br label %afterloop11
merge15:
  %t61 = load i8*, i8** %l0
  %t62 = load i64, i64* %l3
  %t63 = load double, double* %l4
  %t64 = fptosi double %t63 to i64
  %t65 = call i8* @sailfin_runtime_substring(i8* %t61, i64 %t62, i64 %t64)
  store i8* %t65, i8** %l6
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t67 = load i8*, i8** %l6
  %t68 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t66, i8* %t67)
  store { i8**, i64 }* %t68, { i8**, i64 }** %l1
  %t69 = load i8*, i8** %l0
  %s70 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193517249, i32 0, i32 0
  %t71 = load double, double* %l4
  %t72 = sitofp i64 2 to double
  %t73 = fadd double %t71, %t72
  %t74 = call double @find_substring_from(i8* %t69, i8* %s70, double %t73)
  store double %t74, double* %l7
  %t75 = load double, double* %l7
  %t76 = sitofp i64 0 to double
  %t77 = fcmp olt double %t75, %t76
  %t78 = load i8*, i8** %l0
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t80 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t81 = load i64, i64* %l3
  %t82 = load double, double* %l4
  %t83 = load i8*, i8** %l6
  %t84 = load double, double* %l7
  br i1 %t77, label %then16, label %merge17
then16:
  ret i8* null
merge17:
  %t85 = load i8*, i8** %l0
  %t86 = load double, double* %l4
  %t87 = sitofp i64 2 to double
  %t88 = fadd double %t86, %t87
  %t89 = load double, double* %l7
  %t90 = fptosi double %t88 to i64
  %t91 = fptosi double %t89 to i64
  %t92 = call i8* @sailfin_runtime_substring(i8* %t85, i64 %t90, i64 %t91)
  %t93 = call i8* @trim_text(i8* %t92)
  store i8* %t93, i8** %l8
  %t94 = load i8*, i8** %l8
  %t95 = call i64 @sailfin_runtime_string_length(i8* %t94)
  %t96 = icmp eq i64 %t95, 0
  %t97 = load i8*, i8** %l0
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t100 = load i64, i64* %l3
  %t101 = load double, double* %l4
  %t102 = load i8*, i8** %l6
  %t103 = load double, double* %l7
  %t104 = load i8*, i8** %l8
  br i1 %t96, label %then18, label %merge19
then18:
  ret i8* null
merge19:
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t106 = load i8*, i8** %l8
  %t107 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t105, i8* %t106)
  store { i8**, i64 }* %t107, { i8**, i64 }** %l2
  %t108 = load double, double* %l7
  %t109 = sitofp i64 2 to double
  %t110 = fadd double %t108, %t109
  %t111 = fptosi double %t110 to i64
  store i64 %t111, i64* %l3
  br label %loop.latch10
loop.latch10:
  %t112 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t113 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t114 = load i64, i64* %l3
  br label %loop.header8
afterloop11:
  %t118 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t119 = load { i8**, i64 }, { i8**, i64 }* %t118
  %t120 = extractvalue { i8**, i64 } %t119, 1
  %t121 = icmp eq i64 %t120, 0
  %t122 = load i8*, i8** %l0
  %t123 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t124 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t125 = load i64, i64* %l3
  br i1 %t121, label %then20, label %merge21
then20:
  ret i8* null
merge21:
  %t126 = alloca [0 x i8*]
  %t127 = getelementptr [0 x i8*], [0 x i8*]* %t126, i32 0, i32 0
  %t128 = alloca { i8**, i64 }
  %t129 = getelementptr { i8**, i64 }, { i8**, i64 }* %t128, i32 0, i32 0
  store i8** %t127, i8*** %t129
  %t130 = getelementptr { i8**, i64 }, { i8**, i64 }* %t128, i32 0, i32 1
  store i64 0, i64* %t130
  store { i8**, i64 }* %t128, { i8**, i64 }** %l9
  %t131 = sitofp i64 0 to double
  store double %t131, double* %l10
  %t132 = load i8*, i8** %l0
  %t133 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t134 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t135 = load i64, i64* %l3
  %t136 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t137 = load double, double* %l10
  br label %loop.header22
loop.header22:
  %t167 = phi { i8**, i64 }* [ %t136, %entry ], [ %t165, %loop.latch24 ]
  %t168 = phi double [ %t137, %entry ], [ %t166, %loop.latch24 ]
  store { i8**, i64 }* %t167, { i8**, i64 }** %l9
  store double %t168, double* %l10
  br label %loop.body23
loop.body23:
  %t138 = load double, double* %l10
  %t139 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t140 = load { i8**, i64 }, { i8**, i64 }* %t139
  %t141 = extractvalue { i8**, i64 } %t140, 1
  %t142 = sitofp i64 %t141 to double
  %t143 = fcmp oge double %t138, %t142
  %t144 = load i8*, i8** %l0
  %t145 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t146 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t147 = load i64, i64* %l3
  %t148 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t149 = load double, double* %l10
  br i1 %t143, label %then26, label %merge27
then26:
  br label %afterloop25
merge27:
  %t150 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t151 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t152 = load double, double* %l10
  %t153 = fptosi double %t152 to i64
  %t154 = load { i8**, i64 }, { i8**, i64 }* %t151
  %t155 = extractvalue { i8**, i64 } %t154, 0
  %t156 = extractvalue { i8**, i64 } %t154, 1
  %t157 = icmp uge i64 %t153, %t156
  ; bounds check: %t157 (if true, out of bounds)
  %t158 = getelementptr i8*, i8** %t155, i64 %t153
  %t159 = load i8*, i8** %t158
  %t160 = call i8* @python_string_literal(i8* %t159)
  %t161 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t150, i8* %t160)
  store { i8**, i64 }* %t161, { i8**, i64 }** %l9
  %t162 = load double, double* %l10
  %t163 = sitofp i64 1 to double
  %t164 = fadd double %t162, %t163
  store double %t164, double* %l10
  br label %loop.latch24
loop.latch24:
  %t165 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t166 = load double, double* %l10
  br label %loop.header22
afterloop25:
  %t169 = alloca [0 x i8*]
  %t170 = getelementptr [0 x i8*], [0 x i8*]* %t169, i32 0, i32 0
  %t171 = alloca { i8**, i64 }
  %t172 = getelementptr { i8**, i64 }, { i8**, i64 }* %t171, i32 0, i32 0
  store i8** %t170, i8*** %t172
  %t173 = getelementptr { i8**, i64 }, { i8**, i64 }* %t171, i32 0, i32 1
  store i64 0, i64* %t173
  store { i8**, i64 }* %t171, { i8**, i64 }** %l11
  %t174 = sitofp i64 0 to double
  store double %t174, double* %l10
  %t175 = load i8*, i8** %l0
  %t176 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t177 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t178 = load i64, i64* %l3
  %t179 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t180 = load double, double* %l10
  %t181 = load { i8**, i64 }*, { i8**, i64 }** %l11
  br label %loop.header28
loop.header28:
  %t218 = phi { i8**, i64 }* [ %t181, %entry ], [ %t216, %loop.latch30 ]
  %t219 = phi double [ %t180, %entry ], [ %t217, %loop.latch30 ]
  store { i8**, i64 }* %t218, { i8**, i64 }** %l11
  store double %t219, double* %l10
  br label %loop.body29
loop.body29:
  %t182 = load double, double* %l10
  %t183 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t184 = load { i8**, i64 }, { i8**, i64 }* %t183
  %t185 = extractvalue { i8**, i64 } %t184, 1
  %t186 = sitofp i64 %t185 to double
  %t187 = fcmp oge double %t182, %t186
  %t188 = load i8*, i8** %l0
  %t189 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t190 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t191 = load i64, i64* %l3
  %t192 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t193 = load double, double* %l10
  %t194 = load { i8**, i64 }*, { i8**, i64 }** %l11
  br i1 %t187, label %then32, label %merge33
then32:
  br label %afterloop31
merge33:
  %t195 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %t196 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t197 = load double, double* %l10
  %t198 = fptosi double %t197 to i64
  %t199 = load { i8**, i64 }, { i8**, i64 }* %t196
  %t200 = extractvalue { i8**, i64 } %t199, 0
  %t201 = extractvalue { i8**, i64 } %t199, 1
  %t202 = icmp uge i64 %t198, %t201
  ; bounds check: %t202 (if true, out of bounds)
  %t203 = getelementptr i8*, i8** %t200, i64 %t198
  %t204 = load i8*, i8** %t203
  %t205 = load i8, i8* %t204
  %t206 = add i8 40, %t205
  %t207 = add i8 %t206, 41
  %t208 = alloca [2 x i8], align 1
  %t209 = getelementptr [2 x i8], [2 x i8]* %t208, i32 0, i32 0
  store i8 %t207, i8* %t209
  %t210 = getelementptr [2 x i8], [2 x i8]* %t208, i32 0, i32 1
  store i8 0, i8* %t210
  %t211 = getelementptr [2 x i8], [2 x i8]* %t208, i32 0, i32 0
  %t212 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t195, i8* %t211)
  store { i8**, i64 }* %t212, { i8**, i64 }** %l11
  %t213 = load double, double* %l10
  %t214 = sitofp i64 1 to double
  %t215 = fadd double %t213, %t214
  store double %t215, double* %l10
  br label %loop.latch30
loop.latch30:
  %t216 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %t217 = load double, double* %l10
  br label %loop.header28
afterloop31:
  %t220 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %s221 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t222 = call i8* @join_with_separator({ i8**, i64 }* %t220, i8* %s221)
  %t223 = load i8, i8* %t222
  %t224 = add i8 91, %t223
  %t225 = add i8 %t224, 93
  store i8 %t225, i8* %l12
  %t226 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %s227 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t228 = call i8* @join_with_separator({ i8**, i64 }* %t226, i8* %s227)
  %t229 = load i8, i8* %t228
  %t230 = add i8 91, %t229
  %t231 = add i8 %t230, 93
  store i8 %t231, i8* %l13
  %s232 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.len28.h583209964, i32 0, i32 0
  %t233 = load i8, i8* %l12
  %t234 = load i8, i8* %s232
  %t235 = add i8 %t234, %t233
  %s236 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t237 = load i8, i8* %s236
  %t238 = add i8 %t235, %t237
  %t239 = load i8, i8* %l13
  %t240 = add i8 %t238, %t239
  %t241 = add i8 %t240, 41
  %t242 = alloca [2 x i8], align 1
  %t243 = getelementptr [2 x i8], [2 x i8]* %t242, i32 0, i32 0
  store i8 %t241, i8* %t243
  %t244 = getelementptr [2 x i8], [2 x i8]* %t242, i32 0, i32 1
  store i8 0, i8* %t244
  %t245 = getelementptr [2 x i8], [2 x i8]* %t242, i32 0, i32 0
  ret i8* %t245
}

define i8* @decode_string_literal(i8* %expression) {
entry:
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
  %t78 = phi i64 [ %t21, %entry ], [ %t76, %loop.latch8 ]
  %t79 = phi i8* [ %t20, %entry ], [ %t77, %loop.latch8 ]
  store i64 %t78, i64* %l2
  store i8* %t79, i8** %l1
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
  %t68 = load i8, i8* %t66
  %t69 = add i8 %t68, %t67
  %t70 = alloca [2 x i8], align 1
  %t71 = getelementptr [2 x i8], [2 x i8]* %t70, i32 0, i32 0
  store i8 %t69, i8* %t71
  %t72 = getelementptr [2 x i8], [2 x i8]* %t70, i32 0, i32 1
  store i8 0, i8* %t72
  %t73 = getelementptr [2 x i8], [2 x i8]* %t70, i32 0, i32 0
  store i8* %t73, i8** %l1
  %t74 = load i64, i64* %l2
  %t75 = add i64 %t74, 1
  store i64 %t75, i64* %l2
  br label %loop.latch8
loop.latch8:
  %t76 = load i64, i64* %l2
  %t77 = load i8*, i8** %l1
  br label %loop.header6
afterloop9:
  %t80 = load i8*, i8** %l1
  ret i8* %t80
}

define i8* @decode_escape_sequence(i8* %escape, i8* %quote) {
entry:
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
entry:
  %l0 = alloca i8
  %l1 = alloca i64
  %l2 = alloca i8
  store i8 39, i8* %l0
  store i64 0, i64* %l1
  %t0 = load i8, i8* %l0
  %t1 = load i64, i64* %l1
  br label %loop.header0
loop.header0:
  %t67 = phi i8 [ %t0, %entry ], [ %t65, %loop.latch2 ]
  %t68 = phi i64 [ %t1, %entry ], [ %t66, %loop.latch2 ]
  store i8 %t67, i8* %l0
  store i64 %t68, i64* %l1
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
  %t17 = load i8, i8* %s16
  %t18 = add i8 %t15, %t17
  store i8 %t18, i8* %l0
  br label %merge8
else7:
  %t19 = load i8, i8* %l2
  %t20 = icmp eq i8 %t19, 39
  %t21 = load i8, i8* %l0
  %t22 = load i64, i64* %l1
  %t23 = load i8, i8* %l2
  br i1 %t20, label %then9, label %else10
then9:
  %t24 = load i8, i8* %l0
  %s25 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193478474, i32 0, i32 0
  %t26 = load i8, i8* %s25
  %t27 = add i8 %t24, %t26
  store i8 %t27, i8* %l0
  br label %merge11
else10:
  %t28 = load i8, i8* %l2
  %t29 = icmp eq i8 %t28, 10
  %t30 = load i8, i8* %l0
  %t31 = load i64, i64* %l1
  %t32 = load i8, i8* %l2
  br i1 %t29, label %then12, label %else13
then12:
  %t33 = load i8, i8* %l0
  %s34 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193480817, i32 0, i32 0
  %t35 = load i8, i8* %s34
  %t36 = add i8 %t33, %t35
  store i8 %t36, i8* %l0
  br label %merge14
else13:
  %t37 = load i8, i8* %l2
  %t38 = icmp eq i8 %t37, 13
  %t39 = load i8, i8* %l0
  %t40 = load i64, i64* %l1
  %t41 = load i8, i8* %l2
  br i1 %t38, label %then15, label %else16
then15:
  %t42 = load i8, i8* %l0
  %s43 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193480949, i32 0, i32 0
  %t44 = load i8, i8* %s43
  %t45 = add i8 %t42, %t44
  store i8 %t45, i8* %l0
  br label %merge17
else16:
  %t46 = load i8, i8* %l2
  %t47 = icmp eq i8 %t46, 9
  %t48 = load i8, i8* %l0
  %t49 = load i64, i64* %l1
  %t50 = load i8, i8* %l2
  br i1 %t47, label %then18, label %else19
then18:
  %t51 = load i8, i8* %l0
  %s52 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193481015, i32 0, i32 0
  %t53 = load i8, i8* %s52
  %t54 = add i8 %t51, %t53
  store i8 %t54, i8* %l0
  br label %merge20
else19:
  %t55 = load i8, i8* %l0
  %t56 = load i8, i8* %l2
  %t57 = add i8 %t55, %t56
  store i8 %t57, i8* %l0
  br label %merge20
merge20:
  %t58 = phi i8 [ %t54, %then18 ], [ %t57, %else19 ]
  store i8 %t58, i8* %l0
  br label %merge17
merge17:
  %t59 = phi i8 [ %t45, %then15 ], [ %t54, %else16 ]
  store i8 %t59, i8* %l0
  br label %merge14
merge14:
  %t60 = phi i8 [ %t36, %then12 ], [ %t45, %else13 ]
  store i8 %t60, i8* %l0
  br label %merge11
merge11:
  %t61 = phi i8 [ %t27, %then9 ], [ %t36, %else10 ]
  store i8 %t61, i8* %l0
  br label %merge8
merge8:
  %t62 = phi i8 [ %t18, %then6 ], [ %t27, %else7 ]
  store i8 %t62, i8* %l0
  %t63 = load i64, i64* %l1
  %t64 = add i64 %t63, 1
  store i64 %t64, i64* %l1
  br label %loop.latch2
loop.latch2:
  %t65 = load i8, i8* %l0
  %t66 = load i64, i64* %l1
  br label %loop.header0
afterloop3:
  %t69 = load i8, i8* %l0
  %t70 = add i8 %t69, 39
  store i8 %t70, i8* %l0
  %t71 = load i8, i8* %l0
  %t72 = alloca [2 x i8], align 1
  %t73 = getelementptr [2 x i8], [2 x i8]* %t72, i32 0, i32 0
  store i8 %t71, i8* %t73
  %t74 = getelementptr [2 x i8], [2 x i8]* %t72, i32 0, i32 1
  store i8 0, i8* %t74
  %t75 = getelementptr [2 x i8], [2 x i8]* %t72, i32 0, i32 0
  ret i8* %t75
}

define double @find_substring(i8* %value, i8* %pattern) {
entry:
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
  %t50 = phi i64 [ %t7, %entry ], [ %t49, %loop.latch6 ]
  store i64 %t50, i64* %l0
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
  %t39 = phi i1 [ %t15, %loop.body5 ], [ %t37, %loop.latch12 ]
  %t40 = phi i64 [ %t16, %loop.body5 ], [ %t38, %loop.latch12 ]
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
  %t42 = load i64, i64* %l0
  %t43 = load i1, i1* %l1
  %t44 = load i64, i64* %l2
  br i1 %t41, label %then18, label %merge19
then18:
  %t45 = load i64, i64* %l0
  %t46 = sitofp i64 %t45 to double
  ret double %t46
merge19:
  %t47 = load i64, i64* %l0
  %t48 = add i64 %t47, 1
  store i64 %t48, i64* %l0
  br label %loop.latch6
loop.latch6:
  %t49 = load i64, i64* %l0
  br label %loop.header4
afterloop7:
  %t51 = sitofp i64 -1 to double
  ret double %t51
}

define i8* @lower_struct_literal_expression(i8* %expression, double %depth) {
entry:
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
  %l18 = alloca i8
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
  %t41 = alloca [0 x i8*]
  %t42 = getelementptr [0 x i8*], [0 x i8*]* %t41, i32 0, i32 0
  %t43 = alloca { i8**, i64 }
  %t44 = getelementptr { i8**, i64 }, { i8**, i64 }* %t43, i32 0, i32 0
  store i8** %t42, i8*** %t44
  %t45 = getelementptr { i8**, i64 }, { i8**, i64 }* %t43, i32 0, i32 1
  store i64 0, i64* %t45
  store { i8**, i64 }* %t43, { i8**, i64 }** %l5
  %t46 = alloca [0 x i8*]
  %t47 = getelementptr [0 x i8*], [0 x i8*]* %t46, i32 0, i32 0
  %t48 = alloca { i8**, i64 }
  %t49 = getelementptr { i8**, i64 }, { i8**, i64 }* %t48, i32 0, i32 0
  store i8** %t47, i8*** %t49
  %t50 = getelementptr { i8**, i64 }, { i8**, i64 }* %t48, i32 0, i32 1
  store i64 0, i64* %t50
  store { i8**, i64 }* %t48, { i8**, i64 }** %l6
  %t51 = sitofp i64 0 to double
  store double %t51, double* %l7
  %t52 = load double, double* %l0
  %t53 = load double, double* %l1
  %t54 = load i8*, i8** %l2
  %t55 = load i8*, i8** %l3
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t59 = load double, double* %l7
  br label %loop.header8
loop.header8:
  %t193 = phi double [ %t59, %entry ], [ %t190, %loop.latch10 ]
  %t194 = phi { i8**, i64 }* [ %t57, %entry ], [ %t191, %loop.latch10 ]
  %t195 = phi { i8**, i64 }* [ %t58, %entry ], [ %t192, %loop.latch10 ]
  store double %t193, double* %l7
  store { i8**, i64 }* %t194, { i8**, i64 }** %l5
  store { i8**, i64 }* %t195, { i8**, i64 }** %l6
  br label %loop.body9
loop.body9:
  %t60 = load double, double* %l7
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t62 = load { i8**, i64 }, { i8**, i64 }* %t61
  %t63 = extractvalue { i8**, i64 } %t62, 1
  %t64 = sitofp i64 %t63 to double
  %t65 = fcmp oge double %t60, %t64
  %t66 = load double, double* %l0
  %t67 = load double, double* %l1
  %t68 = load i8*, i8** %l2
  %t69 = load i8*, i8** %l3
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t73 = load double, double* %l7
  br i1 %t65, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t75 = load double, double* %l7
  %t76 = fptosi double %t75 to i64
  %t77 = load { i8**, i64 }, { i8**, i64 }* %t74
  %t78 = extractvalue { i8**, i64 } %t77, 0
  %t79 = extractvalue { i8**, i64 } %t77, 1
  %t80 = icmp uge i64 %t76, %t79
  ; bounds check: %t80 (if true, out of bounds)
  %t81 = getelementptr i8*, i8** %t78, i64 %t76
  %t82 = load i8*, i8** %t81
  %t83 = call i8* @trim_text(i8* %t82)
  %t84 = call i8* @trim_trailing_delimiters(i8* %t83)
  store i8* %t84, i8** %l8
  %t85 = load i8*, i8** %l8
  %t86 = call i64 @sailfin_runtime_string_length(i8* %t85)
  %t87 = icmp eq i64 %t86, 0
  %t88 = load double, double* %l0
  %t89 = load double, double* %l1
  %t90 = load i8*, i8** %l2
  %t91 = load i8*, i8** %l3
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t94 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t95 = load double, double* %l7
  %t96 = load i8*, i8** %l8
  br i1 %t87, label %then14, label %merge15
then14:
  %t97 = load double, double* %l7
  %t98 = sitofp i64 1 to double
  %t99 = fadd double %t97, %t98
  store double %t99, double* %l7
  br label %loop.latch10
merge15:
  %t100 = load i8*, i8** %l8
  %t101 = alloca [2 x i8], align 1
  %t102 = getelementptr [2 x i8], [2 x i8]* %t101, i32 0, i32 0
  store i8 58, i8* %t102
  %t103 = getelementptr [2 x i8], [2 x i8]* %t101, i32 0, i32 1
  store i8 0, i8* %t103
  %t104 = getelementptr [2 x i8], [2 x i8]* %t101, i32 0, i32 0
  %t105 = call double @index_of(i8* %t100, i8* %t104)
  store double %t105, double* %l9
  %t106 = load double, double* %l9
  %t107 = sitofp i64 0 to double
  %t108 = fcmp olt double %t106, %t107
  %t109 = load double, double* %l0
  %t110 = load double, double* %l1
  %t111 = load i8*, i8** %l2
  %t112 = load i8*, i8** %l3
  %t113 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t114 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t115 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t116 = load double, double* %l7
  %t117 = load i8*, i8** %l8
  %t118 = load double, double* %l9
  br i1 %t108, label %then16, label %merge17
then16:
  %t119 = load double, double* %l7
  %t120 = sitofp i64 1 to double
  %t121 = fadd double %t119, %t120
  store double %t121, double* %l7
  br label %loop.latch10
merge17:
  %t122 = load i8*, i8** %l8
  %t123 = load double, double* %l9
  %t124 = fptosi double %t123 to i64
  %t125 = call i8* @sailfin_runtime_substring(i8* %t122, i64 0, i64 %t124)
  %t126 = call i8* @trim_text(i8* %t125)
  store i8* %t126, i8** %l10
  %t127 = load i8*, i8** %l8
  %t128 = load double, double* %l9
  %t129 = sitofp i64 1 to double
  %t130 = fadd double %t128, %t129
  %t131 = load i8*, i8** %l8
  %t132 = call i64 @sailfin_runtime_string_length(i8* %t131)
  %t133 = fptosi double %t130 to i64
  %t134 = call i8* @sailfin_runtime_substring(i8* %t127, i64 %t133, i64 %t132)
  %t135 = call i8* @trim_text(i8* %t134)
  store i8* %t135, i8** %l11
  %t136 = load i8*, i8** %l10
  %t137 = call i64 @sailfin_runtime_string_length(i8* %t136)
  %t138 = icmp eq i64 %t137, 0
  %t139 = load double, double* %l0
  %t140 = load double, double* %l1
  %t141 = load i8*, i8** %l2
  %t142 = load i8*, i8** %l3
  %t143 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t144 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t145 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t146 = load double, double* %l7
  %t147 = load i8*, i8** %l8
  %t148 = load double, double* %l9
  %t149 = load i8*, i8** %l10
  %t150 = load i8*, i8** %l11
  br i1 %t138, label %then18, label %merge19
then18:
  %t151 = load double, double* %l7
  %t152 = sitofp i64 1 to double
  %t153 = fadd double %t151, %t152
  store double %t153, double* %l7
  br label %loop.latch10
merge19:
  %t154 = load i8*, i8** %l11
  %t155 = sitofp i64 1 to double
  %t156 = fadd double %depth, %t155
  %t157 = call i8* @lower_expression_with_depth(i8* %t154, double %t156)
  store i8* %t157, i8** %l12
  %t158 = load i8*, i8** %l10
  %t159 = call i8* @sanitize_identifier(i8* %t158)
  store i8* %t159, i8** %l13
  %t160 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t161 = load i8*, i8** %l13
  %t162 = load i8, i8* %t161
  %t163 = add i8 %t162, 61
  %t164 = load i8*, i8** %l12
  %t165 = load i8, i8* %t164
  %t166 = add i8 %t163, %t165
  %t167 = alloca [2 x i8], align 1
  %t168 = getelementptr [2 x i8], [2 x i8]* %t167, i32 0, i32 0
  store i8 %t166, i8* %t168
  %t169 = getelementptr [2 x i8], [2 x i8]* %t167, i32 0, i32 1
  store i8 0, i8* %t169
  %t170 = getelementptr [2 x i8], [2 x i8]* %t167, i32 0, i32 0
  %t171 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t160, i8* %t170)
  store { i8**, i64 }* %t171, { i8**, i64 }** %l5
  %t172 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %s173 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h728584192, i32 0, i32 0
  %t174 = load i8*, i8** %l13
  %t175 = call i8* @sailfin_runtime_string_concat(i8* %s173, i8* %t174)
  %s176 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087924125, i32 0, i32 0
  %t177 = call i8* @sailfin_runtime_string_concat(i8* %t175, i8* %s176)
  %t178 = load i8*, i8** %l12
  %t179 = call i8* @sailfin_runtime_string_concat(i8* %t177, i8* %t178)
  %t180 = load i8, i8* %t179
  %t181 = add i8 %t180, 41
  %t182 = alloca [2 x i8], align 1
  %t183 = getelementptr [2 x i8], [2 x i8]* %t182, i32 0, i32 0
  store i8 %t181, i8* %t183
  %t184 = getelementptr [2 x i8], [2 x i8]* %t182, i32 0, i32 1
  store i8 0, i8* %t184
  %t185 = getelementptr [2 x i8], [2 x i8]* %t182, i32 0, i32 0
  %t186 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t172, i8* %t185)
  store { i8**, i64 }* %t186, { i8**, i64 }** %l6
  %t187 = load double, double* %l7
  %t188 = sitofp i64 1 to double
  %t189 = fadd double %t187, %t188
  store double %t189, double* %l7
  br label %loop.latch10
loop.latch10:
  %t190 = load double, double* %l7
  %t191 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t192 = load { i8**, i64 }*, { i8**, i64 }** %l6
  br label %loop.header8
afterloop11:
  %t196 = load i8*, i8** %l2
  %t197 = call i8* @sanitize_qualified_identifier(i8* %t196)
  store i8* %t197, i8** %l14
  %t198 = sitofp i64 -1 to double
  store double %t198, double* %l15
  %t199 = sitofp i64 0 to double
  store double %t199, double* %l7
  %t200 = load double, double* %l0
  %t201 = load double, double* %l1
  %t202 = load i8*, i8** %l2
  %t203 = load i8*, i8** %l3
  %t204 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t205 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t206 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t207 = load double, double* %l7
  %t208 = load i8*, i8** %l14
  %t209 = load double, double* %l15
  br label %loop.header20
loop.header20:
  %t247 = phi double [ %t209, %entry ], [ %t245, %loop.latch22 ]
  %t248 = phi double [ %t207, %entry ], [ %t246, %loop.latch22 ]
  store double %t247, double* %l15
  store double %t248, double* %l7
  br label %loop.body21
loop.body21:
  %t210 = load double, double* %l7
  %t211 = load i8*, i8** %l14
  %t212 = call i64 @sailfin_runtime_string_length(i8* %t211)
  %t213 = sitofp i64 %t212 to double
  %t214 = fcmp oge double %t210, %t213
  %t215 = load double, double* %l0
  %t216 = load double, double* %l1
  %t217 = load i8*, i8** %l2
  %t218 = load i8*, i8** %l3
  %t219 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t220 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t221 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t222 = load double, double* %l7
  %t223 = load i8*, i8** %l14
  %t224 = load double, double* %l15
  br i1 %t214, label %then24, label %merge25
then24:
  br label %afterloop23
merge25:
  %t225 = load i8*, i8** %l14
  %t226 = load double, double* %l7
  %t227 = call i8* @char_at(i8* %t225, double %t226)
  %t228 = load i8, i8* %t227
  %t229 = icmp eq i8 %t228, 46
  %t230 = load double, double* %l0
  %t231 = load double, double* %l1
  %t232 = load i8*, i8** %l2
  %t233 = load i8*, i8** %l3
  %t234 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t235 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t236 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t237 = load double, double* %l7
  %t238 = load i8*, i8** %l14
  %t239 = load double, double* %l15
  br i1 %t229, label %then26, label %merge27
then26:
  %t240 = load double, double* %l7
  store double %t240, double* %l15
  br label %merge27
merge27:
  %t241 = phi double [ %t240, %then26 ], [ %t239, %loop.body21 ]
  store double %t241, double* %l15
  %t242 = load double, double* %l7
  %t243 = sitofp i64 1 to double
  %t244 = fadd double %t242, %t243
  store double %t244, double* %l7
  br label %loop.latch22
loop.latch22:
  %t245 = load double, double* %l15
  %t246 = load double, double* %l7
  br label %loop.header20
afterloop23:
  %t249 = load double, double* %l15
  %t250 = sitofp i64 0 to double
  %t251 = fcmp oge double %t249, %t250
  %t252 = load double, double* %l0
  %t253 = load double, double* %l1
  %t254 = load i8*, i8** %l2
  %t255 = load i8*, i8** %l3
  %t256 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t257 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t258 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t259 = load double, double* %l7
  %t260 = load i8*, i8** %l14
  %t261 = load double, double* %l15
  br i1 %t251, label %then28, label %merge29
then28:
  %t262 = load i8*, i8** %l14
  %t263 = load double, double* %l15
  %t264 = fptosi double %t263 to i64
  %t265 = call i8* @sailfin_runtime_substring(i8* %t262, i64 0, i64 %t264)
  store i8* %t265, i8** %l16
  %t266 = load i8*, i8** %l14
  %t267 = load double, double* %l15
  %t268 = sitofp i64 1 to double
  %t269 = fadd double %t267, %t268
  %t270 = load i8*, i8** %l14
  %t271 = call i64 @sailfin_runtime_string_length(i8* %t270)
  %t272 = fptosi double %t269 to i64
  %t273 = call i8* @sailfin_runtime_substring(i8* %t266, i64 %t272, i64 %t271)
  store i8* %t273, i8** %l17
  %t274 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %s275 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t276 = call i8* @join_with_separator({ i8**, i64 }* %t274, i8* %s275)
  %t277 = load i8, i8* %t276
  %t278 = add i8 91, %t277
  %t279 = add i8 %t278, 93
  store i8 %t279, i8* %l18
  %s280 = getelementptr inbounds [26 x i8], [26 x i8]* @.str.len25.h117462910, i32 0, i32 0
  %t281 = load i8*, i8** %l16
  %t282 = call i8* @sailfin_runtime_string_concat(i8* %s280, i8* %t281)
  %s283 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2088090973, i32 0, i32 0
  %t284 = call i8* @sailfin_runtime_string_concat(i8* %t282, i8* %s283)
  %t285 = load i8*, i8** %l17
  %t286 = call i8* @sailfin_runtime_string_concat(i8* %t284, i8* %t285)
  %s287 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087924125, i32 0, i32 0
  %t288 = call i8* @sailfin_runtime_string_concat(i8* %t286, i8* %s287)
  %t289 = load i8, i8* %l18
  %t290 = load i8, i8* %t288
  %t291 = add i8 %t290, %t289
  %t292 = add i8 %t291, 41
  %t293 = alloca [2 x i8], align 1
  %t294 = getelementptr [2 x i8], [2 x i8]* %t293, i32 0, i32 0
  store i8 %t292, i8* %t294
  %t295 = getelementptr [2 x i8], [2 x i8]* %t293, i32 0, i32 1
  store i8 0, i8* %t295
  %t296 = getelementptr [2 x i8], [2 x i8]* %t293, i32 0, i32 0
  ret i8* %t296
merge29:
  %t297 = load i8*, i8** %l14
  %t298 = load i8, i8* %t297
  %t299 = add i8 %t298, 40
  %t300 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %s301 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t302 = call i8* @join_with_separator({ i8**, i64 }* %t300, i8* %s301)
  %t303 = load i8, i8* %t302
  %t304 = add i8 %t299, %t303
  %t305 = add i8 %t304, 41
  %t306 = alloca [2 x i8], align 1
  %t307 = getelementptr [2 x i8], [2 x i8]* %t306, i32 0, i32 0
  store i8 %t305, i8* %t307
  %t308 = getelementptr [2 x i8], [2 x i8]* %t306, i32 0, i32 1
  store i8 0, i8* %t308
  %t309 = getelementptr [2 x i8], [2 x i8]* %t306, i32 0, i32 0
  ret i8* %t309
}

define i1 @is_struct_literal_type_candidate(i8* %text) {
entry:
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
  %t32 = phi double [ %t3, %entry ], [ %t31, %loop.latch4 ]
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
  ret i1 1
}

define i8* @lower_array_literal_expression(i8* %expression, double %depth) {
entry:
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
  %t29 = alloca [0 x i8*]
  %t30 = getelementptr [0 x i8*], [0 x i8*]* %t29, i32 0, i32 0
  %t31 = alloca { i8**, i64 }
  %t32 = getelementptr { i8**, i64 }, { i8**, i64 }* %t31, i32 0, i32 0
  store i8** %t30, i8*** %t32
  %t33 = getelementptr { i8**, i64 }, { i8**, i64 }* %t31, i32 0, i32 1
  store i64 0, i64* %t33
  store { i8**, i64 }* %t31, { i8**, i64 }** %l4
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t35 = call double @array_literal_start_index({ i8**, i64 }* %t34)
  store double %t35, double* %l5
  %t36 = load i8*, i8** %l0
  %t37 = load i64, i64* %l1
  %t38 = load i8*, i8** %l2
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t41 = load double, double* %l5
  br label %loop.header6
loop.header6:
  %t87 = phi { i8**, i64 }* [ %t40, %entry ], [ %t85, %loop.latch8 ]
  %t88 = phi double [ %t41, %entry ], [ %t86, %loop.latch8 ]
  store { i8**, i64 }* %t87, { i8**, i64 }** %l4
  store double %t88, double* %l5
  br label %loop.body7
loop.body7:
  %t42 = load double, double* %l5
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t44 = load { i8**, i64 }, { i8**, i64 }* %t43
  %t45 = extractvalue { i8**, i64 } %t44, 1
  %t46 = sitofp i64 %t45 to double
  %t47 = fcmp oge double %t42, %t46
  %t48 = load i8*, i8** %l0
  %t49 = load i64, i64* %l1
  %t50 = load i8*, i8** %l2
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t53 = load double, double* %l5
  br i1 %t47, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t55 = load double, double* %l5
  %t56 = fptosi double %t55 to i64
  %t57 = load { i8**, i64 }, { i8**, i64 }* %t54
  %t58 = extractvalue { i8**, i64 } %t57, 0
  %t59 = extractvalue { i8**, i64 } %t57, 1
  %t60 = icmp uge i64 %t56, %t59
  ; bounds check: %t60 (if true, out of bounds)
  %t61 = getelementptr i8*, i8** %t58, i64 %t56
  %t62 = load i8*, i8** %t61
  %t63 = call i8* @trim_text(i8* %t62)
  %t64 = call i8* @trim_trailing_delimiters(i8* %t63)
  store i8* %t64, i8** %l6
  %t65 = load i8*, i8** %l6
  %t66 = call i64 @sailfin_runtime_string_length(i8* %t65)
  %t67 = icmp sgt i64 %t66, 0
  %t68 = load i8*, i8** %l0
  %t69 = load i64, i64* %l1
  %t70 = load i8*, i8** %l2
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t73 = load double, double* %l5
  %t74 = load i8*, i8** %l6
  br i1 %t67, label %then12, label %merge13
then12:
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t76 = load i8*, i8** %l6
  %t77 = sitofp i64 1 to double
  %t78 = fadd double %depth, %t77
  %t79 = call i8* @lower_expression_with_depth(i8* %t76, double %t78)
  %t80 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t75, i8* %t79)
  store { i8**, i64 }* %t80, { i8**, i64 }** %l4
  br label %merge13
merge13:
  %t81 = phi { i8**, i64 }* [ %t80, %then12 ], [ %t72, %loop.body7 ]
  store { i8**, i64 }* %t81, { i8**, i64 }** %l4
  %t82 = load double, double* %l5
  %t83 = sitofp i64 1 to double
  %t84 = fadd double %t82, %t83
  store double %t84, double* %l5
  br label %loop.latch8
loop.latch8:
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t86 = load double, double* %l5
  br label %loop.header6
afterloop9:
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t90 = load { i8**, i64 }, { i8**, i64 }* %t89
  %t91 = extractvalue { i8**, i64 } %t90, 1
  %t92 = icmp eq i64 %t91, 0
  %t93 = load i8*, i8** %l0
  %t94 = load i64, i64* %l1
  %t95 = load i8*, i8** %l2
  %t96 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t97 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t98 = load double, double* %l5
  br i1 %t92, label %then14, label %merge15
then14:
  %s99 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193479167, i32 0, i32 0
  ret i8* %s99
merge15:
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %s101 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t102 = call i8* @join_with_separator({ i8**, i64 }* %t100, i8* %s101)
  store i8* %t102, i8** %l7
  %t103 = load i8*, i8** %l7
  %t104 = load i8, i8* %t103
  %t105 = add i8 91, %t104
  %t106 = add i8 %t105, 93
  %t107 = alloca [2 x i8], align 1
  %t108 = getelementptr [2 x i8], [2 x i8]* %t107, i32 0, i32 0
  store i8 %t106, i8* %t108
  %t109 = getelementptr [2 x i8], [2 x i8]* %t107, i32 0, i32 1
  store i8 0, i8* %t109
  %t110 = getelementptr [2 x i8], [2 x i8]* %t107, i32 0, i32 0
  ret i8* %t110
}

define double @array_literal_start_index({ i8**, i64 }* %entries) {
entry:
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
entry:
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
entry:
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
  %t78 = phi double [ %t4, %entry ], [ %t76, %loop.latch4 ]
  %t79 = phi i8* [ %t3, %entry ], [ %t77, %loop.latch4 ]
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
  %t80 = load i8*, i8** %l0
  ret i8* %t80
}

define i8* @rewrite_struct_literals_inline(i8* %expression, double %depth) {
entry:
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
  %t231 = phi double [ %t4, %entry ], [ %t229, %loop.latch4 ]
  %t232 = phi i8* [ %t3, %entry ], [ %t230, %loop.latch4 ]
  store double %t231, double* %l1
  store i8* %t232, i8** %l0
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
  %t56 = phi double [ %t29, %loop.body3 ], [ %t55, %loop.latch12 ]
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
  store double %t57, double* %l5
  %t58 = load i8*, i8** %l0
  %t59 = load double, double* %l1
  %t60 = load double, double* %l2
  %t61 = load double, double* %l3
  %t62 = load double, double* %l5
  br label %loop.header18
loop.header18:
  %t103 = phi double [ %t62, %loop.body3 ], [ %t102, %loop.latch20 ]
  store double %t103, double* %l5
  br label %loop.body19
loop.body19:
  %t63 = load double, double* %l5
  %t64 = sitofp i64 0 to double
  %t65 = fcmp ole double %t63, %t64
  %t66 = load i8*, i8** %l0
  %t67 = load double, double* %l1
  %t68 = load double, double* %l2
  %t69 = load double, double* %l3
  %t70 = load double, double* %l5
  br i1 %t65, label %then22, label %merge23
then22:
  br label %afterloop21
merge23:
  %t71 = load i8*, i8** %l0
  %t72 = load double, double* %l5
  %t73 = sitofp i64 1 to double
  %t74 = fsub double %t72, %t73
  %t75 = load double, double* %l5
  %t76 = fptosi double %t74 to i64
  %t77 = fptosi double %t75 to i64
  %t78 = call i8* @sailfin_runtime_substring(i8* %t71, i64 %t76, i64 %t77)
  store i8* %t78, i8** %l6
  %t79 = load i8*, i8** %l6
  %t80 = load i8, i8* %t79
  %t81 = icmp eq i8 %t80, 46
  %t82 = load i8*, i8** %l0
  %t83 = load double, double* %l1
  %t84 = load double, double* %l2
  %t85 = load double, double* %l3
  %t86 = load double, double* %l5
  %t87 = load i8*, i8** %l6
  br i1 %t81, label %then24, label %merge25
then24:
  %t88 = load double, double* %l5
  %t89 = sitofp i64 1 to double
  %t90 = fsub double %t88, %t89
  store double %t90, double* %l5
  br label %loop.latch20
merge25:
  %t91 = load i8*, i8** %l6
  %t92 = call i1 @is_identifier_char(i8* %t91)
  %t93 = load i8*, i8** %l0
  %t94 = load double, double* %l1
  %t95 = load double, double* %l2
  %t96 = load double, double* %l3
  %t97 = load double, double* %l5
  %t98 = load i8*, i8** %l6
  br i1 %t92, label %then26, label %merge27
then26:
  %t99 = load double, double* %l5
  %t100 = sitofp i64 1 to double
  %t101 = fsub double %t99, %t100
  store double %t101, double* %l5
  br label %loop.latch20
merge27:
  br label %afterloop21
loop.latch20:
  %t102 = load double, double* %l5
  br label %loop.header18
afterloop21:
  %t104 = load double, double* %l5
  %t105 = load double, double* %l3
  %t106 = fcmp oeq double %t104, %t105
  %t107 = load i8*, i8** %l0
  %t108 = load double, double* %l1
  %t109 = load double, double* %l2
  %t110 = load double, double* %l3
  %t111 = load double, double* %l5
  br i1 %t106, label %then28, label %merge29
then28:
  %t112 = load double, double* %l2
  %t113 = sitofp i64 1 to double
  %t114 = fadd double %t112, %t113
  store double %t114, double* %l1
  br label %loop.latch4
merge29:
  %t115 = load i8*, i8** %l0
  %t116 = load double, double* %l5
  %t117 = load double, double* %l3
  %t118 = fptosi double %t116 to i64
  %t119 = fptosi double %t117 to i64
  %t120 = call i8* @sailfin_runtime_substring(i8* %t115, i64 %t118, i64 %t119)
  store i8* %t120, i8** %l7
  %t121 = load i8*, i8** %l7
  %t122 = call i1 @is_struct_literal_type_candidate(i8* %t121)
  %t123 = xor i1 %t122, 1
  %t124 = load i8*, i8** %l0
  %t125 = load double, double* %l1
  %t126 = load double, double* %l2
  %t127 = load double, double* %l3
  %t128 = load double, double* %l5
  %t129 = load i8*, i8** %l7
  br i1 %t123, label %then30, label %merge31
then30:
  %t130 = load double, double* %l2
  %t131 = sitofp i64 1 to double
  %t132 = fadd double %t130, %t131
  store double %t132, double* %l1
  br label %loop.latch4
merge31:
  %t133 = load double, double* %l5
  %t134 = sitofp i64 0 to double
  %t135 = fcmp ogt double %t133, %t134
  %t136 = load i8*, i8** %l0
  %t137 = load double, double* %l1
  %t138 = load double, double* %l2
  %t139 = load double, double* %l3
  %t140 = load double, double* %l5
  %t141 = load i8*, i8** %l7
  br i1 %t135, label %then32, label %merge33
then32:
  %t142 = load i8*, i8** %l0
  %t143 = load double, double* %l5
  %t144 = sitofp i64 1 to double
  %t145 = fsub double %t143, %t144
  %t146 = load double, double* %l5
  %t147 = fptosi double %t145 to i64
  %t148 = fptosi double %t146 to i64
  %t149 = call i8* @sailfin_runtime_substring(i8* %t142, i64 %t147, i64 %t148)
  store i8* %t149, i8** %l8
  %t151 = load i8*, i8** %l8
  %t152 = call i1 @is_identifier_char(i8* %t151)
  br label %logical_or_entry_150

logical_or_entry_150:
  br i1 %t152, label %logical_or_merge_150, label %logical_or_right_150

logical_or_right_150:
  %t153 = load i8*, i8** %l8
  %t154 = load i8, i8* %t153
  %t155 = icmp eq i8 %t154, 46
  br label %logical_or_right_end_150

logical_or_right_end_150:
  br label %logical_or_merge_150

logical_or_merge_150:
  %t156 = phi i1 [ true, %logical_or_entry_150 ], [ %t155, %logical_or_right_end_150 ]
  %t157 = load i8*, i8** %l0
  %t158 = load double, double* %l1
  %t159 = load double, double* %l2
  %t160 = load double, double* %l3
  %t161 = load double, double* %l5
  %t162 = load i8*, i8** %l7
  %t163 = load i8*, i8** %l8
  br i1 %t156, label %then34, label %merge35
then34:
  %t164 = load double, double* %l2
  %t165 = sitofp i64 1 to double
  %t166 = fadd double %t164, %t165
  store double %t166, double* %l1
  br label %loop.latch4
merge35:
  br label %merge33
merge33:
  %t167 = phi double [ %t166, %then32 ], [ %t137, %loop.body3 ]
  store double %t167, double* %l1
  %t168 = load i8*, i8** %l0
  %t169 = load double, double* %l2
  %t170 = call double @find_matching_brace(i8* %t168, double %t169)
  store double %t170, double* %l9
  %t171 = load double, double* %l9
  %t172 = sitofp i64 0 to double
  %t173 = fcmp olt double %t171, %t172
  %t174 = load i8*, i8** %l0
  %t175 = load double, double* %l1
  %t176 = load double, double* %l2
  %t177 = load double, double* %l3
  %t178 = load double, double* %l5
  %t179 = load i8*, i8** %l7
  %t180 = load double, double* %l9
  br i1 %t173, label %then36, label %merge37
then36:
  br label %afterloop5
merge37:
  %t181 = load i8*, i8** %l0
  %t182 = load double, double* %l5
  %t183 = load double, double* %l9
  %t184 = sitofp i64 1 to double
  %t185 = fadd double %t183, %t184
  %t186 = fptosi double %t182 to i64
  %t187 = fptosi double %t185 to i64
  %t188 = call i8* @sailfin_runtime_substring(i8* %t181, i64 %t186, i64 %t187)
  store i8* %t188, i8** %l10
  %t189 = load i8*, i8** %l10
  %t190 = sitofp i64 1 to double
  %t191 = fadd double %depth, %t190
  %t192 = call i8* @lower_struct_literal_expression(i8* %t189, double %t191)
  store i8* %t192, i8** %l11
  %t193 = load i8*, i8** %l11
  %t194 = icmp eq i8* %t193, null
  %t195 = load i8*, i8** %l0
  %t196 = load double, double* %l1
  %t197 = load double, double* %l2
  %t198 = load double, double* %l3
  %t199 = load double, double* %l5
  %t200 = load i8*, i8** %l7
  %t201 = load double, double* %l9
  %t202 = load i8*, i8** %l10
  %t203 = load i8*, i8** %l11
  br i1 %t194, label %then38, label %merge39
then38:
  %t204 = load double, double* %l9
  %t205 = sitofp i64 1 to double
  %t206 = fadd double %t204, %t205
  store double %t206, double* %l1
  br label %loop.latch4
merge39:
  %t207 = load i8*, i8** %l0
  %t208 = load double, double* %l5
  %t209 = fptosi double %t208 to i64
  %t210 = call i8* @sailfin_runtime_substring(i8* %t207, i64 0, i64 %t209)
  store i8* %t210, i8** %l12
  %t211 = load i8*, i8** %l0
  %t212 = load double, double* %l9
  %t213 = sitofp i64 1 to double
  %t214 = fadd double %t212, %t213
  %t215 = load i8*, i8** %l0
  %t216 = call i64 @sailfin_runtime_string_length(i8* %t215)
  %t217 = fptosi double %t214 to i64
  %t218 = call i8* @sailfin_runtime_substring(i8* %t211, i64 %t217, i64 %t216)
  store i8* %t218, i8** %l13
  %t219 = load i8*, i8** %l12
  %t220 = load i8*, i8** %l11
  %t221 = call i8* @sailfin_runtime_string_concat(i8* %t219, i8* %t220)
  %t222 = load i8*, i8** %l13
  %t223 = call i8* @sailfin_runtime_string_concat(i8* %t221, i8* %t222)
  store i8* %t223, i8** %l0
  %t224 = load double, double* %l5
  %t225 = load i8*, i8** %l11
  %t226 = call i64 @sailfin_runtime_string_length(i8* %t225)
  %t227 = sitofp i64 %t226 to double
  %t228 = fadd double %t224, %t227
  store double %t228, double* %l1
  br label %loop.latch4
loop.latch4:
  %t229 = load double, double* %l1
  %t230 = load i8*, i8** %l0
  br label %loop.header2
afterloop5:
  %t233 = load i8*, i8** %l0
  ret i8* %t233
}

define %StructLiteralCapture @capture_struct_literal_expression(i8* %initial, { %NativeInstruction*, i64 }* %instructions, double %start_index) {
entry:
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
  %t171 = phi i8* [ %t32, %entry ], [ %t167, %loop.latch6 ]
  %t172 = phi double [ %t35, %entry ], [ %t168, %loop.latch6 ]
  %t173 = phi double [ %t34, %entry ], [ %t169, %loop.latch6 ]
  %t174 = phi double [ %t33, %entry ], [ %t170, %loop.latch6 ]
  store i8* %t171, i8** %l1
  store double %t172, double* %l4
  store double %t173, double* %l3
  store double %t174, double* %l2
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
  %t137 = load i8, i8* %t136
  %t138 = add i8 %t137, 32
  %t139 = load i8*, i8** %l6
  %t140 = load i8, i8* %t139
  %t141 = add i8 %t138, %t140
  %t142 = alloca [2 x i8], align 1
  %t143 = getelementptr [2 x i8], [2 x i8]* %t142, i32 0, i32 0
  store i8 %t141, i8* %t143
  %t144 = getelementptr [2 x i8], [2 x i8]* %t142, i32 0, i32 1
  store i8 0, i8* %t144
  %t145 = getelementptr [2 x i8], [2 x i8]* %t142, i32 0, i32 0
  store i8* %t145, i8** %l1
  br label %merge13
merge13:
  %t146 = phi i8* [ %t145, %then12 ], [ %t130, %loop.body5 ]
  store i8* %t146, i8** %l1
  %t147 = load double, double* %l4
  %t148 = load i8*, i8** %l6
  %t149 = call double @compute_brace_balance(i8* %t148)
  %t150 = fadd double %t147, %t149
  store double %t150, double* %l4
  %t151 = load double, double* %l3
  %t152 = sitofp i64 1 to double
  %t153 = fadd double %t151, %t152
  store double %t153, double* %l3
  %t154 = load double, double* %l2
  %t155 = sitofp i64 1 to double
  %t156 = fadd double %t154, %t155
  store double %t156, double* %l2
  %t157 = load double, double* %l4
  %t158 = sitofp i64 0 to double
  %t159 = fcmp ole double %t157, %t158
  %t160 = load i8*, i8** %l0
  %t161 = load i8*, i8** %l1
  %t162 = load double, double* %l2
  %t163 = load double, double* %l3
  %t164 = load double, double* %l4
  %t165 = load %NativeInstruction, %NativeInstruction* %l5
  %t166 = load i8*, i8** %l6
  br i1 %t159, label %then14, label %merge15
then14:
  br label %afterloop7
merge15:
  br label %loop.latch6
loop.latch6:
  %t167 = load i8*, i8** %l1
  %t168 = load double, double* %l4
  %t169 = load double, double* %l3
  %t170 = load double, double* %l2
  br label %loop.header4
afterloop7:
  %t175 = load double, double* %l4
  %t176 = sitofp i64 0 to double
  %t177 = fcmp une double %t175, %t176
  %t178 = load i8*, i8** %l0
  %t179 = load i8*, i8** %l1
  %t180 = load double, double* %l2
  %t181 = load double, double* %l3
  %t182 = load double, double* %l4
  br i1 %t177, label %then16, label %merge17
then16:
  %t183 = load i8*, i8** %l0
  %t184 = insertvalue %StructLiteralCapture undef, i8* %t183, 0
  %t185 = sitofp i64 0 to double
  %t186 = insertvalue %StructLiteralCapture %t184, double %t185, 1
  %t187 = insertvalue %StructLiteralCapture %t186, i1 0, 2
  ret %StructLiteralCapture %t187
merge17:
  %t188 = load double, double* %l3
  %t189 = sitofp i64 0 to double
  %t190 = fcmp oeq double %t188, %t189
  %t191 = load i8*, i8** %l0
  %t192 = load i8*, i8** %l1
  %t193 = load double, double* %l2
  %t194 = load double, double* %l3
  %t195 = load double, double* %l4
  br i1 %t190, label %then18, label %merge19
then18:
  %t196 = load i8*, i8** %l0
  %t197 = insertvalue %StructLiteralCapture undef, i8* %t196, 0
  %t198 = sitofp i64 0 to double
  %t199 = insertvalue %StructLiteralCapture %t197, double %t198, 1
  %t200 = insertvalue %StructLiteralCapture %t199, i1 0, 2
  ret %StructLiteralCapture %t200
merge19:
  %t201 = load i8*, i8** %l1
  %t202 = call i8* @trim_text(i8* %t201)
  %t203 = call i8* @trim_trailing_delimiters(i8* %t202)
  store i8* %t203, i8** %l7
  %t204 = load i8*, i8** %l7
  %t205 = alloca [2 x i8], align 1
  %t206 = getelementptr [2 x i8], [2 x i8]* %t205, i32 0, i32 0
  store i8 125, i8* %t206
  %t207 = getelementptr [2 x i8], [2 x i8]* %t205, i32 0, i32 1
  store i8 0, i8* %t207
  %t208 = getelementptr [2 x i8], [2 x i8]* %t205, i32 0, i32 0
  %t209 = call i1 @ends_with(i8* %t204, i8* %t208)
  %t210 = xor i1 %t209, 1
  %t211 = load i8*, i8** %l0
  %t212 = load i8*, i8** %l1
  %t213 = load double, double* %l2
  %t214 = load double, double* %l3
  %t215 = load double, double* %l4
  %t216 = load i8*, i8** %l7
  br i1 %t210, label %then20, label %merge21
then20:
  %t217 = load i8*, i8** %l0
  %t218 = insertvalue %StructLiteralCapture undef, i8* %t217, 0
  %t219 = sitofp i64 0 to double
  %t220 = insertvalue %StructLiteralCapture %t218, double %t219, 1
  %t221 = insertvalue %StructLiteralCapture %t220, i1 0, 2
  ret %StructLiteralCapture %t221
merge21:
  %t222 = load i8*, i8** %l7
  %t223 = insertvalue %StructLiteralCapture undef, i8* %t222, 0
  %t224 = load double, double* %l3
  %t225 = insertvalue %StructLiteralCapture %t223, double %t224, 1
  %t226 = insertvalue %StructLiteralCapture %t225, i1 1, 2
  ret %StructLiteralCapture %t226
}

define i8* @rewrite_expression_intrinsics(i8* %expression) {
entry:
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
entry:
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
  %t175 = phi i8* [ %t4, %entry ], [ %t173, %loop.latch4 ]
  %t176 = phi double [ %t5, %entry ], [ %t174, %loop.latch4 ]
  store i8* %t175, i8** %l0
  store double %t176, double* %l1
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
  br label %merge13
merge13:
  %t77 = phi i8* [ %t73, %then12 ], [ %t52, %then10 ]
  %t78 = phi double [ %t76, %then12 ], [ %t53, %then10 ]
  store i8* %t77, i8** %l0
  store double %t78, double* %l1
  br label %merge11
merge11:
  %t79 = phi i8* [ %t73, %then10 ], [ %t43, %loop.body3 ]
  %t80 = phi double [ %t76, %then10 ], [ %t44, %loop.body3 ]
  store i8* %t79, i8** %l0
  store double %t80, double* %l1
  %t81 = load i8*, i8** %l2
  %t82 = load i8, i8* %t81
  %t83 = icmp eq i8 %t82, 124
  %t84 = load i8*, i8** %l0
  %t85 = load double, double* %l1
  %t86 = load i8*, i8** %l2
  br i1 %t83, label %then16, label %merge17
then16:
  %t87 = load double, double* %l1
  %t88 = sitofp i64 1 to double
  %t89 = fadd double %t87, %t88
  %t90 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t91 = sitofp i64 %t90 to double
  %t92 = fcmp olt double %t89, %t91
  %t93 = load i8*, i8** %l0
  %t94 = load double, double* %l1
  %t95 = load i8*, i8** %l2
  br i1 %t92, label %then18, label %merge19
then18:
  %t96 = load double, double* %l1
  %t97 = sitofp i64 1 to double
  %t98 = fadd double %t96, %t97
  %t99 = load double, double* %l1
  %t100 = sitofp i64 2 to double
  %t101 = fadd double %t99, %t100
  %t102 = fptosi double %t98 to i64
  %t103 = fptosi double %t101 to i64
  %t104 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t102, i64 %t103)
  store i8* %t104, i8** %l5
  %t105 = load i8*, i8** %l5
  %t106 = load i8, i8* %t105
  %t107 = icmp eq i8 %t106, 124
  %t108 = load i8*, i8** %l0
  %t109 = load double, double* %l1
  %t110 = load i8*, i8** %l2
  %t111 = load i8*, i8** %l5
  br i1 %t107, label %then20, label %merge21
then20:
  %t112 = load i8*, i8** %l0
  %s113 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h176216012, i32 0, i32 0
  %t114 = call i8* @sailfin_runtime_string_concat(i8* %t112, i8* %s113)
  store i8* %t114, i8** %l0
  %t115 = load double, double* %l1
  %t116 = sitofp i64 2 to double
  %t117 = fadd double %t115, %t116
  store double %t117, double* %l1
  br label %loop.latch4
merge21:
  br label %merge19
merge19:
  %t118 = phi i8* [ %t114, %then18 ], [ %t93, %then16 ]
  %t119 = phi double [ %t117, %then18 ], [ %t94, %then16 ]
  store i8* %t118, i8** %l0
  store double %t119, double* %l1
  br label %merge17
merge17:
  %t120 = phi i8* [ %t114, %then16 ], [ %t84, %loop.body3 ]
  %t121 = phi double [ %t117, %then16 ], [ %t85, %loop.body3 ]
  store i8* %t120, i8** %l0
  store double %t121, double* %l1
  %t122 = load i8*, i8** %l2
  %t123 = load i8, i8* %t122
  %t124 = icmp eq i8 %t123, 33
  %t125 = load i8*, i8** %l0
  %t126 = load double, double* %l1
  %t127 = load i8*, i8** %l2
  br i1 %t124, label %then22, label %merge23
then22:
  %t128 = load double, double* %l1
  %t129 = sitofp i64 1 to double
  %t130 = fadd double %t128, %t129
  %t131 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t132 = sitofp i64 %t131 to double
  %t133 = fcmp olt double %t130, %t132
  %t134 = load i8*, i8** %l0
  %t135 = load double, double* %l1
  %t136 = load i8*, i8** %l2
  br i1 %t133, label %then24, label %merge25
then24:
  %t137 = load double, double* %l1
  %t138 = sitofp i64 1 to double
  %t139 = fadd double %t137, %t138
  %t140 = load double, double* %l1
  %t141 = sitofp i64 2 to double
  %t142 = fadd double %t140, %t141
  %t143 = fptosi double %t139 to i64
  %t144 = fptosi double %t142 to i64
  %t145 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t143, i64 %t144)
  store i8* %t145, i8** %l6
  %t146 = load i8*, i8** %l6
  %t147 = load i8, i8* %t146
  %t148 = icmp eq i8 %t147, 61
  %t149 = load i8*, i8** %l0
  %t150 = load double, double* %l1
  %t151 = load i8*, i8** %l2
  %t152 = load i8*, i8** %l6
  br i1 %t148, label %then26, label %merge27
then26:
  %t153 = load i8*, i8** %l0
  %s154 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193414949, i32 0, i32 0
  %t155 = call i8* @sailfin_runtime_string_concat(i8* %t153, i8* %s154)
  store i8* %t155, i8** %l0
  %t156 = load double, double* %l1
  %t157 = sitofp i64 2 to double
  %t158 = fadd double %t156, %t157
  store double %t158, double* %l1
  br label %loop.latch4
merge27:
  br label %merge25
merge25:
  %t159 = phi i8* [ %t155, %then24 ], [ %t134, %then22 ]
  %t160 = phi double [ %t158, %then24 ], [ %t135, %then22 ]
  store i8* %t159, i8** %l0
  store double %t160, double* %l1
  %t161 = load i8*, i8** %l0
  %s162 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h268720028, i32 0, i32 0
  %t163 = call i8* @sailfin_runtime_string_concat(i8* %t161, i8* %s162)
  store i8* %t163, i8** %l0
  %t164 = load double, double* %l1
  %t165 = sitofp i64 1 to double
  %t166 = fadd double %t164, %t165
  store double %t166, double* %l1
  br label %loop.latch4
merge23:
  %t167 = load i8*, i8** %l0
  %t168 = load i8*, i8** %l2
  %t169 = call i8* @sailfin_runtime_string_concat(i8* %t167, i8* %t168)
  store i8* %t169, i8** %l0
  %t170 = load double, double* %l1
  %t171 = sitofp i64 1 to double
  %t172 = fadd double %t170, %t171
  store double %t172, double* %l1
  br label %loop.latch4
loop.latch4:
  %t173 = load i8*, i8** %l0
  %t174 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t177 = load i8*, i8** %l0
  ret i8* %t177
}

define i8* @rewrite_literal_tokens(i8* %expression) {
entry:
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
  %t130 = phi i8* [ %t4, %entry ], [ %t128, %loop.latch4 ]
  %t131 = phi double [ %t5, %entry ], [ %t129, %loop.latch4 ]
  store i8* %t130, i8** %l0
  store double %t131, double* %l1
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
  %t78 = load double, double* %l4
  %t79 = load double, double* %l1
  %t80 = fptosi double %t78 to i64
  %t81 = fptosi double %t79 to i64
  %t82 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t80, i64 %t81)
  store i8* %t82, i8** %l6
  %t83 = load i8*, i8** %l6
  %s84 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h268929446, i32 0, i32 0
  %t85 = icmp eq i8* %t83, %s84
  %t86 = load i8*, i8** %l0
  %t87 = load double, double* %l1
  %t88 = load i8*, i8** %l2
  %t89 = load double, double* %l4
  %t90 = load i8*, i8** %l6
  br i1 %t85, label %then20, label %else21
then20:
  %t91 = load i8*, i8** %l0
  %s92 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h230766299, i32 0, i32 0
  %t93 = call i8* @sailfin_runtime_string_concat(i8* %t91, i8* %s92)
  store i8* %t93, i8** %l0
  br label %merge22
else21:
  %t94 = load i8*, i8** %l6
  %s95 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h275946731, i32 0, i32 0
  %t96 = icmp eq i8* %t94, %s95
  %t97 = load i8*, i8** %l0
  %t98 = load double, double* %l1
  %t99 = load i8*, i8** %l2
  %t100 = load double, double* %l4
  %t101 = load i8*, i8** %l6
  br i1 %t96, label %then23, label %else24
then23:
  %t102 = load i8*, i8** %l0
  %s103 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h237997259, i32 0, i32 0
  %t104 = call i8* @sailfin_runtime_string_concat(i8* %t102, i8* %s103)
  store i8* %t104, i8** %l0
  br label %merge25
else24:
  %t105 = load i8*, i8** %l6
  %s106 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2095430042, i32 0, i32 0
  %t107 = icmp eq i8* %t105, %s106
  %t108 = load i8*, i8** %l0
  %t109 = load double, double* %l1
  %t110 = load i8*, i8** %l2
  %t111 = load double, double* %l4
  %t112 = load i8*, i8** %l6
  br i1 %t107, label %then26, label %else27
then26:
  %t113 = load i8*, i8** %l0
  %s114 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h843097466, i32 0, i32 0
  %t115 = call i8* @sailfin_runtime_string_concat(i8* %t113, i8* %s114)
  store i8* %t115, i8** %l0
  br label %merge28
else27:
  %t116 = load i8*, i8** %l0
  %t117 = load i8*, i8** %l6
  %t118 = call i8* @sailfin_runtime_string_concat(i8* %t116, i8* %t117)
  store i8* %t118, i8** %l0
  br label %merge28
merge28:
  %t119 = phi i8* [ %t115, %then26 ], [ %t118, %else27 ]
  store i8* %t119, i8** %l0
  br label %merge25
merge25:
  %t120 = phi i8* [ %t104, %then23 ], [ %t115, %else24 ]
  store i8* %t120, i8** %l0
  br label %merge22
merge22:
  %t121 = phi i8* [ %t93, %then20 ], [ %t104, %else21 ]
  store i8* %t121, i8** %l0
  br label %loop.latch4
merge11:
  %t122 = load i8*, i8** %l0
  %t123 = load i8*, i8** %l2
  %t124 = call i8* @sailfin_runtime_string_concat(i8* %t122, i8* %t123)
  store i8* %t124, i8** %l0
  %t125 = load double, double* %l1
  %t126 = sitofp i64 1 to double
  %t127 = fadd double %t125, %t126
  store double %t127, double* %l1
  br label %loop.latch4
loop.latch4:
  %t128 = load i8*, i8** %l0
  %t129 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t132 = load i8*, i8** %l0
  ret i8* %t132
}

define i8* @rewrite_push_calls(i8* %expression) {
entry:
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
  %t97 = phi i8* [ %t8, %entry ], [ %t95, %loop.latch4 ]
  %t98 = phi double [ %t9, %entry ], [ %t96, %loop.latch4 ]
  store i8* %t97, i8** %l2
  store double %t98, double* %l3
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
  br label %merge11
merge11:
  %t87 = phi i8* [ %t81, %then10 ], [ %t58, %loop.body3 ]
  %t88 = phi double [ %t86, %then10 ], [ %t59, %loop.body3 ]
  store i8* %t87, i8** %l2
  store double %t88, double* %l3
  %t89 = load i8*, i8** %l2
  %t90 = load i8*, i8** %l4
  %t91 = call i8* @sailfin_runtime_string_concat(i8* %t89, i8* %t90)
  store i8* %t91, i8** %l2
  %t92 = load double, double* %l3
  %t93 = sitofp i64 1 to double
  %t94 = fadd double %t92, %t93
  store double %t94, double* %l3
  br label %loop.latch4
loop.latch4:
  %t95 = load i8*, i8** %l2
  %t96 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t99 = load i8*, i8** %l2
  ret i8* %t99
}

define i8* @rewrite_concat_calls(i8* %expression) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca %ExtractedSpan
  %l3 = alloca double
  %l4 = alloca %ExtractedSpan
  %l5 = alloca i8*
  %l6 = alloca i8*
  %l7 = alloca i8*
  %l8 = alloca i8*
  %l9 = alloca i8
  store i8* %expression, i8** %l0
  %t0 = load i8*, i8** %l0
  br label %loop.header0
loop.header0:
  %t72 = phi i8* [ %t0, %entry ], [ %t71, %loop.latch2 ]
  store i8* %t72, i8** %l0
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
  %t51 = load i8, i8* %t50
  %t52 = add i8 40, %t51
  %s53 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1776141546, i32 0, i32 0
  %t54 = load i8, i8* %s53
  %t55 = add i8 %t52, %t54
  %t56 = load i8*, i8** %l8
  %t57 = load i8, i8* %t56
  %t58 = add i8 %t55, %t57
  %t59 = add i8 %t58, 41
  store i8 %t59, i8* %l9
  %t60 = load i8*, i8** %l5
  %t61 = load i8, i8* %l9
  %t62 = load i8, i8* %t60
  %t63 = add i8 %t62, %t61
  %t64 = load i8*, i8** %l6
  %t65 = load i8, i8* %t64
  %t66 = add i8 %t63, %t65
  %t67 = alloca [2 x i8], align 1
  %t68 = getelementptr [2 x i8], [2 x i8]* %t67, i32 0, i32 0
  store i8 %t66, i8* %t68
  %t69 = getelementptr [2 x i8], [2 x i8]* %t67, i32 0, i32 1
  store i8 0, i8* %t69
  %t70 = getelementptr [2 x i8], [2 x i8]* %t67, i32 0, i32 0
  store i8* %t70, i8** %l0
  br label %loop.latch2
loop.latch2:
  %t71 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t73 = load i8*, i8** %l0
  ret i8* %t73
}

define i8* @rewrite_length_accesses(i8* %expression) {
entry:
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
  %t58 = phi i8* [ %t0, %entry ], [ %t57, %loop.latch2 ]
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
  %t48 = load i8, i8* %t47
  %t49 = add i8 %t48, 41
  %t50 = load i8*, i8** %l4
  %t51 = load i8, i8* %t50
  %t52 = add i8 %t49, %t51
  %t53 = alloca [2 x i8], align 1
  %t54 = getelementptr [2 x i8], [2 x i8]* %t53, i32 0, i32 0
  store i8 %t52, i8* %t54
  %t55 = getelementptr [2 x i8], [2 x i8]* %t53, i32 0, i32 1
  store i8 0, i8* %t55
  %t56 = getelementptr [2 x i8], [2 x i8]* %t53, i32 0, i32 0
  store i8* %t56, i8** %l0
  br label %loop.latch2
loop.latch2:
  %t57 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t59 = load i8*, i8** %l0
  ret i8* %t59
}

define %ExtractedSpan @extract_object_span(i8* %text, double %dot_index) {
entry:
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
  %t127 = phi double [ %t14, %entry ], [ %t124, %loop.latch4 ]
  %t128 = phi double [ %t13, %entry ], [ %t125, %loop.latch4 ]
  %t129 = phi double [ %t15, %entry ], [ %t126, %loop.latch4 ]
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
  %t130 = load double, double* %l0
  %t131 = sitofp i64 1 to double
  %t132 = fadd double %t130, %t131
  store double %t132, double* %l4
  %t133 = load double, double* %l4
  %t134 = fcmp oge double %t133, %dot_index
  %t135 = load double, double* %l0
  %t136 = load double, double* %l1
  %t137 = load double, double* %l2
  %t138 = load double, double* %l4
  br i1 %t134, label %then24, label %merge25
then24:
  %s139 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t140 = insertvalue %ExtractedSpan undef, i8* %s139, 0
  %t141 = load double, double* %l4
  %t142 = insertvalue %ExtractedSpan %t140, double %t141, 1
  %t143 = insertvalue %ExtractedSpan %t142, double %dot_index, 2
  %t144 = insertvalue %ExtractedSpan %t143, i1 0, 3
  ret %ExtractedSpan %t144
merge25:
  %t145 = load double, double* %l4
  %t146 = fptosi double %t145 to i64
  %t147 = fptosi double %dot_index to i64
  %t148 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t146, i64 %t147)
  store i8* %t148, i8** %l5
  %t149 = load i8*, i8** %l5
  %t150 = insertvalue %ExtractedSpan undef, i8* %t149, 0
  %t151 = load double, double* %l4
  %t152 = insertvalue %ExtractedSpan %t150, double %t151, 1
  %t153 = insertvalue %ExtractedSpan %t152, double %dot_index, 2
  %t154 = insertvalue %ExtractedSpan %t153, i1 1, 3
  ret %ExtractedSpan %t154
}

define %ExtractedSpan @extract_parenthesized_span(i8* %text, double %open_index) {
entry:
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
  %t100 = phi double [ %t24, %entry ], [ %t98, %loop.latch6 ]
  %t101 = phi double [ %t23, %entry ], [ %t99, %loop.latch6 ]
  store double %t100, double* %l1
  store double %t101, double* %l0
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
  br label %merge12
else11:
  %t47 = load i8*, i8** %l2
  %t48 = load i8, i8* %t47
  %t49 = icmp eq i8 %t48, 41
  %t50 = load double, double* %l0
  %t51 = load double, double* %l1
  %t52 = load i8*, i8** %l2
  br i1 %t49, label %then13, label %else14
then13:
  %t53 = load double, double* %l1
  %t54 = sitofp i64 1 to double
  %t55 = fsub double %t53, %t54
  store double %t55, double* %l1
  %t56 = load double, double* %l1
  %t57 = sitofp i64 0 to double
  %t58 = fcmp oeq double %t56, %t57
  %t59 = load double, double* %l0
  %t60 = load double, double* %l1
  %t61 = load i8*, i8** %l2
  br i1 %t58, label %then16, label %merge17
then16:
  %t62 = sitofp i64 1 to double
  %t63 = fadd double %open_index, %t62
  %t64 = load double, double* %l0
  %t65 = fptosi double %t63 to i64
  %t66 = fptosi double %t64 to i64
  %t67 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t65, i64 %t66)
  store i8* %t67, i8** %l3
  %t68 = load i8*, i8** %l3
  %t69 = insertvalue %ExtractedSpan undef, i8* %t68, 0
  %t70 = sitofp i64 1 to double
  %t71 = fadd double %open_index, %t70
  %t72 = insertvalue %ExtractedSpan %t69, double %t71, 1
  %t73 = load double, double* %l0
  %t74 = sitofp i64 1 to double
  %t75 = fadd double %t73, %t74
  %t76 = insertvalue %ExtractedSpan %t72, double %t75, 2
  %t77 = insertvalue %ExtractedSpan %t76, i1 1, 3
  ret %ExtractedSpan %t77
merge17:
  br label %merge15
else14:
  %t79 = load i8*, i8** %l2
  %t80 = load i8, i8* %t79
  %t81 = icmp eq i8 %t80, 34
  br label %logical_or_entry_78

logical_or_entry_78:
  br i1 %t81, label %logical_or_merge_78, label %logical_or_right_78

logical_or_right_78:
  %t82 = load i8*, i8** %l2
  %t83 = load i8, i8* %t82
  %t84 = icmp eq i8 %t83, 39
  br label %logical_or_right_end_78

logical_or_right_end_78:
  br label %logical_or_merge_78

logical_or_merge_78:
  %t85 = phi i1 [ true, %logical_or_entry_78 ], [ %t84, %logical_or_right_end_78 ]
  %t86 = load double, double* %l0
  %t87 = load double, double* %l1
  %t88 = load i8*, i8** %l2
  br i1 %t85, label %then18, label %merge19
then18:
  %t89 = load double, double* %l0
  %t90 = call double @skip_string_literal(i8* %text, double %t89)
  store double %t90, double* %l0
  br label %loop.latch6
merge19:
  br label %merge15
merge15:
  %t91 = phi double [ %t55, %then13 ], [ %t51, %else14 ]
  %t92 = phi double [ %t50, %then13 ], [ %t90, %else14 ]
  store double %t91, double* %l1
  store double %t92, double* %l0
  br label %merge12
merge12:
  %t93 = phi double [ %t46, %then10 ], [ %t55, %else11 ]
  %t94 = phi double [ %t41, %then10 ], [ %t90, %else11 ]
  store double %t93, double* %l1
  store double %t94, double* %l0
  %t95 = load double, double* %l0
  %t96 = sitofp i64 1 to double
  %t97 = fadd double %t95, %t96
  store double %t97, double* %l0
  br label %loop.latch6
loop.latch6:
  %t98 = load double, double* %l1
  %t99 = load double, double* %l0
  br label %loop.header4
afterloop7:
  %s102 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t103 = insertvalue %ExtractedSpan undef, i8* %s102, 0
  %t104 = insertvalue %ExtractedSpan %t103, double %open_index, 1
  %t105 = insertvalue %ExtractedSpan %t104, double %open_index, 2
  %t106 = insertvalue %ExtractedSpan %t105, i1 0, 3
  ret %ExtractedSpan %t106
}

define double @skip_string_literal(i8* %text, double %quote_index) {
entry:
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
  %t44 = phi double [ %t8, %entry ], [ %t43, %loop.latch2 ]
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
  ret double %t45
}

define %ExpressionContinuationCapture @capture_expression_continuation(i8* %initial, { %NativeInstruction*, i64 }* %instructions, double %start_index) {
entry:
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
  %t295 = phi double [ %t36, %entry ], [ %t288, %loop.latch4 ]
  %t296 = phi double [ %t37, %entry ], [ %t289, %loop.latch4 ]
  %t297 = phi i1 [ %t38, %entry ], [ %t290, %loop.latch4 ]
  %t298 = phi i8* [ %t35, %entry ], [ %t291, %loop.latch4 ]
  %t299 = phi double [ %t32, %entry ], [ %t292, %loop.latch4 ]
  %t300 = phi double [ %t33, %entry ], [ %t293, %loop.latch4 ]
  %t301 = phi double [ %t34, %entry ], [ %t294, %loop.latch4 ]
  store double %t295, double* %l5
  store double %t296, double* %l6
  store i1 %t297, i1* %l7
  store i8* %t298, i8** %l4
  store double %t299, double* %l1
  store double %t300, double* %l2
  store double %t301, double* %l3
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
  br label %merge13
merge13:
  %t118 = phi i1 [ 1, %then12 ], [ %t102, %loop.body3 ]
  store i1 %t118, i1* %l7
  %t119 = load i8*, i8** %l4
  %t120 = load i8, i8* %t119
  %t121 = add i8 %t120, 32
  %t122 = load i8*, i8** %l9
  %t123 = load i8, i8* %t122
  %t124 = add i8 %t121, %t123
  %t125 = alloca [2 x i8], align 1
  %t126 = getelementptr [2 x i8], [2 x i8]* %t125, i32 0, i32 0
  store i8 %t124, i8* %t126
  %t127 = getelementptr [2 x i8], [2 x i8]* %t125, i32 0, i32 1
  store i8 0, i8* %t127
  %t128 = getelementptr [2 x i8], [2 x i8]* %t125, i32 0, i32 0
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
  %t265 = phi double [ %t182, %then16 ], [ %t263, %loop.latch20 ]
  %t266 = phi i1 [ %t181, %then16 ], [ %t264, %loop.latch20 ]
  store double %t265, double* %l11
  store i1 %t266, i1* %l10
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
  %t201 = fptosi double %t200 to i64
  %t202 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %instructions
  %t203 = extractvalue { %NativeInstruction*, i64 } %t202, 0
  %t204 = extractvalue { %NativeInstruction*, i64 } %t202, 1
  %t205 = icmp uge i64 %t201, %t204
  ; bounds check: %t205 (if true, out of bounds)
  %t206 = getelementptr %NativeInstruction, %NativeInstruction* %t203, i64 %t201
  %t207 = load %NativeInstruction, %NativeInstruction* %t206
  %t208 = call i8* @continuation_segment_text(%NativeInstruction %t207)
  store i8* %t208, i8** %l12
  %t209 = load i8*, i8** %l12
  %t210 = icmp eq i8* %t209, null
  %t211 = load i8*, i8** %l0
  %t212 = load double, double* %l1
  %t213 = load double, double* %l2
  %t214 = load double, double* %l3
  %t215 = load i8*, i8** %l4
  %t216 = load double, double* %l5
  %t217 = load double, double* %l6
  %t218 = load i1, i1* %l7
  %t219 = load i8*, i8** %l8
  %t220 = load i8*, i8** %l9
  %t221 = load i1, i1* %l10
  %t222 = load double, double* %l11
  %t223 = load i8*, i8** %l12
  br i1 %t210, label %then24, label %merge25
then24:
  br label %afterloop21
merge25:
  %t224 = load i8*, i8** %l12
  %t225 = call i8* @trim_text(i8* %t224)
  store i8* %t225, i8** %l13
  %t226 = load i8*, i8** %l13
  %t227 = call i64 @sailfin_runtime_string_length(i8* %t226)
  %t228 = icmp eq i64 %t227, 0
  %t229 = load i8*, i8** %l0
  %t230 = load double, double* %l1
  %t231 = load double, double* %l2
  %t232 = load double, double* %l3
  %t233 = load i8*, i8** %l4
  %t234 = load double, double* %l5
  %t235 = load double, double* %l6
  %t236 = load i1, i1* %l7
  %t237 = load i8*, i8** %l8
  %t238 = load i8*, i8** %l9
  %t239 = load i1, i1* %l10
  %t240 = load double, double* %l11
  %t241 = load i8*, i8** %l12
  %t242 = load i8*, i8** %l13
  br i1 %t228, label %then26, label %merge27
then26:
  %t243 = load double, double* %l11
  %t244 = sitofp i64 1 to double
  %t245 = fadd double %t243, %t244
  store double %t245, double* %l11
  br label %loop.latch20
merge27:
  %t246 = load i8*, i8** %l13
  %t247 = call i1 @segment_signals_expression_continuation(i8* %t246)
  %t248 = load i8*, i8** %l0
  %t249 = load double, double* %l1
  %t250 = load double, double* %l2
  %t251 = load double, double* %l3
  %t252 = load i8*, i8** %l4
  %t253 = load double, double* %l5
  %t254 = load double, double* %l6
  %t255 = load i1, i1* %l7
  %t256 = load i8*, i8** %l8
  %t257 = load i8*, i8** %l9
  %t258 = load i1, i1* %l10
  %t259 = load double, double* %l11
  %t260 = load i8*, i8** %l12
  %t261 = load i8*, i8** %l13
  br i1 %t247, label %then28, label %merge29
then28:
  store i1 0, i1* %l10
  br label %merge29
merge29:
  %t262 = phi i1 [ 0, %then28 ], [ %t258, %loop.body19 ]
  store i1 %t262, i1* %l10
  br label %afterloop21
loop.latch20:
  %t263 = load double, double* %l11
  %t264 = load i1, i1* %l10
  br label %loop.header18
afterloop21:
  %t267 = load i1, i1* %l10
  %t268 = load i8*, i8** %l0
  %t269 = load double, double* %l1
  %t270 = load double, double* %l2
  %t271 = load double, double* %l3
  %t272 = load i8*, i8** %l4
  %t273 = load double, double* %l5
  %t274 = load double, double* %l6
  %t275 = load i1, i1* %l7
  %t276 = load i8*, i8** %l8
  %t277 = load i8*, i8** %l9
  %t278 = load i1, i1* %l10
  %t279 = load double, double* %l11
  br i1 %t267, label %then30, label %merge31
then30:
  %t280 = load i8*, i8** %l4
  %t281 = call i8* @trim_text(i8* %t280)
  %t282 = call i8* @trim_trailing_delimiters(i8* %t281)
  store i8* %t282, i8** %l14
  %t283 = load i8*, i8** %l14
  %t284 = insertvalue %ExpressionContinuationCapture undef, i8* %t283, 0
  %t285 = load double, double* %l6
  %t286 = insertvalue %ExpressionContinuationCapture %t284, double %t285, 1
  %t287 = insertvalue %ExpressionContinuationCapture %t286, i1 1, 2
  ret %ExpressionContinuationCapture %t287
merge31:
  br label %merge17
merge17:
  br label %loop.latch4
loop.latch4:
  %t288 = load double, double* %l5
  %t289 = load double, double* %l6
  %t290 = load i1, i1* %l7
  %t291 = load i8*, i8** %l4
  %t292 = load double, double* %l1
  %t293 = load double, double* %l2
  %t294 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t303 = load i1, i1* %l7
  br label %logical_or_entry_302

logical_or_entry_302:
  br i1 %t303, label %logical_or_merge_302, label %logical_or_right_302

logical_or_right_302:
  %t304 = load double, double* %l6
  %t305 = sitofp i64 0 to double
  %t306 = fcmp oeq double %t304, %t305
  br label %logical_or_right_end_302

logical_or_right_end_302:
  br label %logical_or_merge_302

logical_or_merge_302:
  %t307 = phi i1 [ true, %logical_or_entry_302 ], [ %t306, %logical_or_right_end_302 ]
  %t308 = xor i1 %t307, 1
  %t309 = load i8*, i8** %l0
  %t310 = load double, double* %l1
  %t311 = load double, double* %l2
  %t312 = load double, double* %l3
  %t313 = load i8*, i8** %l4
  %t314 = load double, double* %l5
  %t315 = load double, double* %l6
  %t316 = load i1, i1* %l7
  br i1 %t308, label %then32, label %merge33
then32:
  %t317 = load i8*, i8** %l0
  %t318 = insertvalue %ExpressionContinuationCapture undef, i8* %t317, 0
  %t319 = sitofp i64 0 to double
  %t320 = insertvalue %ExpressionContinuationCapture %t318, double %t319, 1
  %t321 = insertvalue %ExpressionContinuationCapture %t320, i1 0, 2
  ret %ExpressionContinuationCapture %t321
merge33:
  %t323 = load double, double* %l1
  %t324 = sitofp i64 0 to double
  %t325 = fcmp ole double %t323, %t324
  br label %logical_and_entry_322

logical_and_entry_322:
  br i1 %t325, label %logical_and_right_322, label %logical_and_merge_322

logical_and_right_322:
  %t327 = load double, double* %l2
  %t328 = sitofp i64 0 to double
  %t329 = fcmp ole double %t327, %t328
  br label %logical_and_entry_326

logical_and_entry_326:
  br i1 %t329, label %logical_and_right_326, label %logical_and_merge_326

logical_and_right_326:
  %t330 = load double, double* %l3
  %t331 = sitofp i64 0 to double
  %t332 = fcmp ole double %t330, %t331
  br label %logical_and_right_end_326

logical_and_right_end_326:
  br label %logical_and_merge_326

logical_and_merge_326:
  %t333 = phi i1 [ false, %logical_and_entry_326 ], [ %t332, %logical_and_right_end_326 ]
  br label %logical_and_right_end_322

logical_and_right_end_322:
  br label %logical_and_merge_322

logical_and_merge_322:
  %t334 = phi i1 [ false, %logical_and_entry_322 ], [ %t333, %logical_and_right_end_322 ]
  %t335 = load i8*, i8** %l0
  %t336 = load double, double* %l1
  %t337 = load double, double* %l2
  %t338 = load double, double* %l3
  %t339 = load i8*, i8** %l4
  %t340 = load double, double* %l5
  %t341 = load double, double* %l6
  %t342 = load i1, i1* %l7
  br i1 %t334, label %then34, label %merge35
then34:
  %t343 = load i8*, i8** %l4
  %t344 = call i8* @trim_text(i8* %t343)
  %t345 = call i8* @trim_trailing_delimiters(i8* %t344)
  store i8* %t345, i8** %l15
  %t346 = load i8*, i8** %l15
  %t347 = insertvalue %ExpressionContinuationCapture undef, i8* %t346, 0
  %t348 = load double, double* %l6
  %t349 = insertvalue %ExpressionContinuationCapture %t347, double %t348, 1
  %t350 = insertvalue %ExpressionContinuationCapture %t349, i1 1, 2
  ret %ExpressionContinuationCapture %t350
merge35:
  %t351 = load i8*, i8** %l0
  %t352 = insertvalue %ExpressionContinuationCapture undef, i8* %t351, 0
  %t353 = sitofp i64 0 to double
  %t354 = insertvalue %ExpressionContinuationCapture %t352, double %t353, 1
  %t355 = insertvalue %ExpressionContinuationCapture %t354, i1 0, 2
  ret %ExpressionContinuationCapture %t355
}

define i8* @continuation_segment_text(%NativeInstruction %instruction) {
entry:
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
entry:
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
entry:
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
  %t40 = phi double [ %t5, %entry ], [ %t38, %loop.latch4 ]
  %t41 = phi double [ %t6, %entry ], [ %t39, %loop.latch4 ]
  store double %t40, double* %l0
  store double %t41, double* %l1
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
  br label %merge10
else9:
  %t24 = load i8*, i8** %l2
  %t25 = load i8, i8* %t24
  %t26 = icmp eq i8 %t25, 125
  %t27 = load double, double* %l0
  %t28 = load double, double* %l1
  %t29 = load i8*, i8** %l2
  br i1 %t26, label %then11, label %merge12
then11:
  %t30 = load double, double* %l0
  %t31 = sitofp i64 1 to double
  %t32 = fsub double %t30, %t31
  store double %t32, double* %l0
  br label %merge12
merge12:
  %t33 = phi double [ %t32, %then11 ], [ %t27, %else9 ]
  store double %t33, double* %l0
  br label %merge10
merge10:
  %t34 = phi double [ %t23, %then8 ], [ %t32, %else9 ]
  store double %t34, double* %l0
  %t35 = load double, double* %l1
  %t36 = sitofp i64 1 to double
  %t37 = fadd double %t35, %t36
  store double %t37, double* %l1
  br label %loop.latch4
loop.latch4:
  %t38 = load double, double* %l0
  %t39 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t42 = load double, double* %l0
  ret double %t42
}

define double @compute_parenthesis_balance(i8* %text) {
entry:
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
entry:
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
entry:
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
  %t38 = phi double [ %t5, %entry ], [ %t36, %loop.latch4 ]
  %t39 = phi double [ %t6, %entry ], [ %t37, %loop.latch4 ]
  store double %t38, double* %l0
  store double %t39, double* %l1
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
  br label %merge10
else9:
  %t23 = load i8*, i8** %l2
  %t24 = icmp eq i8* %t23, %close
  %t25 = load double, double* %l0
  %t26 = load double, double* %l1
  %t27 = load i8*, i8** %l2
  br i1 %t24, label %then11, label %merge12
then11:
  %t28 = load double, double* %l0
  %t29 = sitofp i64 1 to double
  %t30 = fsub double %t28, %t29
  store double %t30, double* %l0
  br label %merge12
merge12:
  %t31 = phi double [ %t30, %then11 ], [ %t25, %else9 ]
  store double %t31, double* %l0
  br label %merge10
merge10:
  %t32 = phi double [ %t22, %then8 ], [ %t30, %else9 ]
  store double %t32, double* %l0
  %t33 = load double, double* %l1
  %t34 = sitofp i64 1 to double
  %t35 = fadd double %t33, %t34
  store double %t35, double* %l1
  br label %loop.latch4
loop.latch4:
  %t36 = load double, double* %l0
  %t37 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t40 = load double, double* %l0
  ret double %t40
}

define { i8**, i64 }* @split_struct_field_entries(i8* %text) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i1
  %l5 = alloca i8*
  %l6 = alloca i8*
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* %t2, { i8**, i64 }** %l0
  %s5 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s5, i8** %l1
  %t6 = sitofp i64 0 to double
  store double %t6, double* %l2
  %t7 = sitofp i64 0 to double
  store double %t7, double* %l3
  store i1 0, i1* %l4
  %s8 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s8, i8** %l5
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t10 = load i8*, i8** %l1
  %t11 = load double, double* %l2
  %t12 = load double, double* %l3
  %t13 = load i1, i1* %l4
  %t14 = load i8*, i8** %l5
  br label %loop.header0
loop.header0:
  %t198 = phi i8* [ %t10, %entry ], [ %t192, %loop.latch2 ]
  %t199 = phi double [ %t12, %entry ], [ %t193, %loop.latch2 ]
  %t200 = phi i1 [ %t13, %entry ], [ %t194, %loop.latch2 ]
  %t201 = phi i8* [ %t14, %entry ], [ %t195, %loop.latch2 ]
  %t202 = phi double [ %t11, %entry ], [ %t196, %loop.latch2 ]
  %t203 = phi { i8**, i64 }* [ %t9, %entry ], [ %t197, %loop.latch2 ]
  store i8* %t198, i8** %l1
  store double %t199, double* %l3
  store i1 %t200, i1* %l4
  store i8* %t201, i8** %l5
  store double %t202, double* %l2
  store { i8**, i64 }* %t203, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t15 = load double, double* %l3
  %t16 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t17 = sitofp i64 %t16 to double
  %t18 = fcmp oge double %t15, %t17
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t20 = load i8*, i8** %l1
  %t21 = load double, double* %l2
  %t22 = load double, double* %l3
  %t23 = load i1, i1* %l4
  %t24 = load i8*, i8** %l5
  br i1 %t18, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t25 = load double, double* %l3
  %t26 = call i8* @char_at(i8* %text, double %t25)
  store i8* %t26, i8** %l6
  %t27 = load i1, i1* %l4
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t29 = load i8*, i8** %l1
  %t30 = load double, double* %l2
  %t31 = load double, double* %l3
  %t32 = load i1, i1* %l4
  %t33 = load i8*, i8** %l5
  %t34 = load i8*, i8** %l6
  br i1 %t27, label %then6, label %merge7
then6:
  %t35 = load i8*, i8** %l1
  %t36 = load i8*, i8** %l6
  %t37 = call i8* @sailfin_runtime_string_concat(i8* %t35, i8* %t36)
  store i8* %t37, i8** %l1
  %t38 = load i8*, i8** %l6
  %t39 = load i8, i8* %t38
  %t40 = icmp eq i8 %t39, 92
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t42 = load i8*, i8** %l1
  %t43 = load double, double* %l2
  %t44 = load double, double* %l3
  %t45 = load i1, i1* %l4
  %t46 = load i8*, i8** %l5
  %t47 = load i8*, i8** %l6
  br i1 %t40, label %then8, label %else9
then8:
  %t48 = load double, double* %l3
  %t49 = sitofp i64 1 to double
  %t50 = fadd double %t48, %t49
  store double %t50, double* %l3
  %t51 = load double, double* %l3
  %t52 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t53 = sitofp i64 %t52 to double
  %t54 = fcmp olt double %t51, %t53
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t56 = load i8*, i8** %l1
  %t57 = load double, double* %l2
  %t58 = load double, double* %l3
  %t59 = load i1, i1* %l4
  %t60 = load i8*, i8** %l5
  %t61 = load i8*, i8** %l6
  br i1 %t54, label %then11, label %merge12
then11:
  %t62 = load i8*, i8** %l1
  %t63 = load double, double* %l3
  %t64 = call i8* @char_at(i8* %text, double %t63)
  %t65 = call i8* @sailfin_runtime_string_concat(i8* %t62, i8* %t64)
  store i8* %t65, i8** %l1
  br label %merge12
merge12:
  %t66 = phi i8* [ %t65, %then11 ], [ %t56, %then8 ]
  store i8* %t66, i8** %l1
  br label %merge10
else9:
  %t67 = load i8*, i8** %l6
  %t68 = load i8*, i8** %l5
  %t69 = icmp eq i8* %t67, %t68
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t71 = load i8*, i8** %l1
  %t72 = load double, double* %l2
  %t73 = load double, double* %l3
  %t74 = load i1, i1* %l4
  %t75 = load i8*, i8** %l5
  %t76 = load i8*, i8** %l6
  br i1 %t69, label %then13, label %merge14
then13:
  store i1 0, i1* %l4
  br label %merge14
merge14:
  %t77 = phi i1 [ 0, %then13 ], [ %t74, %else9 ]
  store i1 %t77, i1* %l4
  br label %merge10
merge10:
  %t78 = phi double [ %t50, %then8 ], [ %t44, %else9 ]
  %t79 = phi i8* [ %t65, %then8 ], [ %t42, %else9 ]
  %t80 = phi i1 [ %t45, %then8 ], [ 0, %else9 ]
  store double %t78, double* %l3
  store i8* %t79, i8** %l1
  store i1 %t80, i1* %l4
  %t81 = load double, double* %l3
  %t82 = sitofp i64 1 to double
  %t83 = fadd double %t81, %t82
  store double %t83, double* %l3
  br label %loop.latch2
merge7:
  %t85 = load i8*, i8** %l6
  %t86 = load i8, i8* %t85
  %t87 = icmp eq i8 %t86, 34
  br label %logical_or_entry_84

logical_or_entry_84:
  br i1 %t87, label %logical_or_merge_84, label %logical_or_right_84

logical_or_right_84:
  %t88 = load i8*, i8** %l6
  %t89 = load i8, i8* %t88
  %t90 = icmp eq i8 %t89, 39
  br label %logical_or_right_end_84

logical_or_right_end_84:
  br label %logical_or_merge_84

logical_or_merge_84:
  %t91 = phi i1 [ true, %logical_or_entry_84 ], [ %t90, %logical_or_right_end_84 ]
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t93 = load i8*, i8** %l1
  %t94 = load double, double* %l2
  %t95 = load double, double* %l3
  %t96 = load i1, i1* %l4
  %t97 = load i8*, i8** %l5
  %t98 = load i8*, i8** %l6
  br i1 %t91, label %then15, label %merge16
then15:
  store i1 1, i1* %l4
  %t99 = load i8*, i8** %l6
  store i8* %t99, i8** %l5
  %t100 = load i8*, i8** %l1
  %t101 = load i8*, i8** %l6
  %t102 = call i8* @sailfin_runtime_string_concat(i8* %t100, i8* %t101)
  store i8* %t102, i8** %l1
  %t103 = load double, double* %l3
  %t104 = sitofp i64 1 to double
  %t105 = fadd double %t103, %t104
  store double %t105, double* %l3
  br label %loop.latch2
merge16:
  %t107 = load i8*, i8** %l6
  %t108 = load i8, i8* %t107
  %t109 = icmp eq i8 %t108, 123
  br label %logical_or_entry_106

logical_or_entry_106:
  br i1 %t109, label %logical_or_merge_106, label %logical_or_right_106

logical_or_right_106:
  %t111 = load i8*, i8** %l6
  %t112 = load i8, i8* %t111
  %t113 = icmp eq i8 %t112, 91
  br label %logical_or_entry_110

logical_or_entry_110:
  br i1 %t113, label %logical_or_merge_110, label %logical_or_right_110

logical_or_right_110:
  %t114 = load i8*, i8** %l6
  %t115 = load i8, i8* %t114
  %t116 = icmp eq i8 %t115, 40
  br label %logical_or_right_end_110

logical_or_right_end_110:
  br label %logical_or_merge_110

logical_or_merge_110:
  %t117 = phi i1 [ true, %logical_or_entry_110 ], [ %t116, %logical_or_right_end_110 ]
  br label %logical_or_right_end_106

logical_or_right_end_106:
  br label %logical_or_merge_106

logical_or_merge_106:
  %t118 = phi i1 [ true, %logical_or_entry_106 ], [ %t117, %logical_or_right_end_106 ]
  %t119 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t120 = load i8*, i8** %l1
  %t121 = load double, double* %l2
  %t122 = load double, double* %l3
  %t123 = load i1, i1* %l4
  %t124 = load i8*, i8** %l5
  %t125 = load i8*, i8** %l6
  br i1 %t118, label %then17, label %else18
then17:
  %t126 = load double, double* %l2
  %t127 = sitofp i64 1 to double
  %t128 = fadd double %t126, %t127
  store double %t128, double* %l2
  br label %merge19
else18:
  %t130 = load i8*, i8** %l6
  %t131 = load i8, i8* %t130
  %t132 = icmp eq i8 %t131, 125
  br label %logical_or_entry_129

logical_or_entry_129:
  br i1 %t132, label %logical_or_merge_129, label %logical_or_right_129

logical_or_right_129:
  %t134 = load i8*, i8** %l6
  %t135 = load i8, i8* %t134
  %t136 = icmp eq i8 %t135, 93
  br label %logical_or_entry_133

logical_or_entry_133:
  br i1 %t136, label %logical_or_merge_133, label %logical_or_right_133

logical_or_right_133:
  %t137 = load i8*, i8** %l6
  %t138 = load i8, i8* %t137
  %t139 = icmp eq i8 %t138, 41
  br label %logical_or_right_end_133

logical_or_right_end_133:
  br label %logical_or_merge_133

logical_or_merge_133:
  %t140 = phi i1 [ true, %logical_or_entry_133 ], [ %t139, %logical_or_right_end_133 ]
  br label %logical_or_right_end_129

logical_or_right_end_129:
  br label %logical_or_merge_129

logical_or_merge_129:
  %t141 = phi i1 [ true, %logical_or_entry_129 ], [ %t140, %logical_or_right_end_129 ]
  %t142 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t143 = load i8*, i8** %l1
  %t144 = load double, double* %l2
  %t145 = load double, double* %l3
  %t146 = load i1, i1* %l4
  %t147 = load i8*, i8** %l5
  %t148 = load i8*, i8** %l6
  br i1 %t141, label %then20, label %merge21
then20:
  %t149 = load double, double* %l2
  %t150 = sitofp i64 0 to double
  %t151 = fcmp ogt double %t149, %t150
  %t152 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t153 = load i8*, i8** %l1
  %t154 = load double, double* %l2
  %t155 = load double, double* %l3
  %t156 = load i1, i1* %l4
  %t157 = load i8*, i8** %l5
  %t158 = load i8*, i8** %l6
  br i1 %t151, label %then22, label %merge23
then22:
  %t159 = load double, double* %l2
  %t160 = sitofp i64 1 to double
  %t161 = fsub double %t159, %t160
  store double %t161, double* %l2
  br label %merge23
merge23:
  %t162 = phi double [ %t161, %then22 ], [ %t154, %then20 ]
  store double %t162, double* %l2
  br label %merge21
merge21:
  %t163 = phi double [ %t161, %then20 ], [ %t144, %else18 ]
  store double %t163, double* %l2
  br label %merge19
merge19:
  %t164 = phi double [ %t128, %then17 ], [ %t161, %else18 ]
  store double %t164, double* %l2
  %t166 = load i8*, i8** %l6
  %t167 = load i8, i8* %t166
  %t168 = icmp eq i8 %t167, 44
  br label %logical_and_entry_165

logical_and_entry_165:
  br i1 %t168, label %logical_and_right_165, label %logical_and_merge_165

logical_and_right_165:
  %t169 = load double, double* %l2
  %t170 = sitofp i64 0 to double
  %t171 = fcmp oeq double %t169, %t170
  br label %logical_and_right_end_165

logical_and_right_end_165:
  br label %logical_and_merge_165

logical_and_merge_165:
  %t172 = phi i1 [ false, %logical_and_entry_165 ], [ %t171, %logical_and_right_end_165 ]
  %t173 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t174 = load i8*, i8** %l1
  %t175 = load double, double* %l2
  %t176 = load double, double* %l3
  %t177 = load i1, i1* %l4
  %t178 = load i8*, i8** %l5
  %t179 = load i8*, i8** %l6
  br i1 %t172, label %then24, label %else25
then24:
  %t180 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t181 = load i8*, i8** %l1
  %t182 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t180, i8* %t181)
  store { i8**, i64 }* %t182, { i8**, i64 }** %l0
  %s183 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s183, i8** %l1
  br label %merge26
else25:
  %t184 = load i8*, i8** %l1
  %t185 = load i8*, i8** %l6
  %t186 = call i8* @sailfin_runtime_string_concat(i8* %t184, i8* %t185)
  store i8* %t186, i8** %l1
  br label %merge26
merge26:
  %t187 = phi { i8**, i64 }* [ %t182, %then24 ], [ %t173, %else25 ]
  %t188 = phi i8* [ %s183, %then24 ], [ %t186, %else25 ]
  store { i8**, i64 }* %t187, { i8**, i64 }** %l0
  store i8* %t188, i8** %l1
  %t189 = load double, double* %l3
  %t190 = sitofp i64 1 to double
  %t191 = fadd double %t189, %t190
  store double %t191, double* %l3
  br label %loop.latch2
loop.latch2:
  %t192 = load i8*, i8** %l1
  %t193 = load double, double* %l3
  %t194 = load i1, i1* %l4
  %t195 = load i8*, i8** %l5
  %t196 = load double, double* %l2
  %t197 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t204 = load i8*, i8** %l1
  %t205 = call i64 @sailfin_runtime_string_length(i8* %t204)
  %t206 = icmp sgt i64 %t205, 0
  %t207 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t208 = load i8*, i8** %l1
  %t209 = load double, double* %l2
  %t210 = load double, double* %l3
  %t211 = load i1, i1* %l4
  %t212 = load i8*, i8** %l5
  br i1 %t206, label %then27, label %merge28
then27:
  %t213 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t214 = load i8*, i8** %l1
  %t215 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t213, i8* %t214)
  store { i8**, i64 }* %t215, { i8**, i64 }** %l0
  br label %merge28
merge28:
  %t216 = phi { i8**, i64 }* [ %t215, %then27 ], [ %t207, %entry ]
  store { i8**, i64 }* %t216, { i8**, i64 }** %l0
  %t217 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t217
}

define { i8**, i64 }* @split_array_entries(i8* %text) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i1
  %l5 = alloca i8*
  %l6 = alloca i8*
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* %t2, { i8**, i64 }** %l0
  %s5 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s5, i8** %l1
  %t6 = sitofp i64 0 to double
  store double %t6, double* %l2
  %t7 = sitofp i64 0 to double
  store double %t7, double* %l3
  store i1 0, i1* %l4
  %s8 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s8, i8** %l5
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t10 = load i8*, i8** %l1
  %t11 = load double, double* %l2
  %t12 = load double, double* %l3
  %t13 = load i1, i1* %l4
  %t14 = load i8*, i8** %l5
  br label %loop.header0
loop.header0:
  %t198 = phi i8* [ %t10, %entry ], [ %t192, %loop.latch2 ]
  %t199 = phi double [ %t12, %entry ], [ %t193, %loop.latch2 ]
  %t200 = phi i1 [ %t13, %entry ], [ %t194, %loop.latch2 ]
  %t201 = phi i8* [ %t14, %entry ], [ %t195, %loop.latch2 ]
  %t202 = phi double [ %t11, %entry ], [ %t196, %loop.latch2 ]
  %t203 = phi { i8**, i64 }* [ %t9, %entry ], [ %t197, %loop.latch2 ]
  store i8* %t198, i8** %l1
  store double %t199, double* %l3
  store i1 %t200, i1* %l4
  store i8* %t201, i8** %l5
  store double %t202, double* %l2
  store { i8**, i64 }* %t203, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t15 = load double, double* %l3
  %t16 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t17 = sitofp i64 %t16 to double
  %t18 = fcmp oge double %t15, %t17
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t20 = load i8*, i8** %l1
  %t21 = load double, double* %l2
  %t22 = load double, double* %l3
  %t23 = load i1, i1* %l4
  %t24 = load i8*, i8** %l5
  br i1 %t18, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t25 = load double, double* %l3
  %t26 = call i8* @char_at(i8* %text, double %t25)
  store i8* %t26, i8** %l6
  %t27 = load i1, i1* %l4
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t29 = load i8*, i8** %l1
  %t30 = load double, double* %l2
  %t31 = load double, double* %l3
  %t32 = load i1, i1* %l4
  %t33 = load i8*, i8** %l5
  %t34 = load i8*, i8** %l6
  br i1 %t27, label %then6, label %merge7
then6:
  %t35 = load i8*, i8** %l1
  %t36 = load i8*, i8** %l6
  %t37 = call i8* @sailfin_runtime_string_concat(i8* %t35, i8* %t36)
  store i8* %t37, i8** %l1
  %t38 = load i8*, i8** %l6
  %t39 = load i8, i8* %t38
  %t40 = icmp eq i8 %t39, 92
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t42 = load i8*, i8** %l1
  %t43 = load double, double* %l2
  %t44 = load double, double* %l3
  %t45 = load i1, i1* %l4
  %t46 = load i8*, i8** %l5
  %t47 = load i8*, i8** %l6
  br i1 %t40, label %then8, label %else9
then8:
  %t48 = load double, double* %l3
  %t49 = sitofp i64 1 to double
  %t50 = fadd double %t48, %t49
  store double %t50, double* %l3
  %t51 = load double, double* %l3
  %t52 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t53 = sitofp i64 %t52 to double
  %t54 = fcmp olt double %t51, %t53
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t56 = load i8*, i8** %l1
  %t57 = load double, double* %l2
  %t58 = load double, double* %l3
  %t59 = load i1, i1* %l4
  %t60 = load i8*, i8** %l5
  %t61 = load i8*, i8** %l6
  br i1 %t54, label %then11, label %merge12
then11:
  %t62 = load i8*, i8** %l1
  %t63 = load double, double* %l3
  %t64 = call i8* @char_at(i8* %text, double %t63)
  %t65 = call i8* @sailfin_runtime_string_concat(i8* %t62, i8* %t64)
  store i8* %t65, i8** %l1
  br label %merge12
merge12:
  %t66 = phi i8* [ %t65, %then11 ], [ %t56, %then8 ]
  store i8* %t66, i8** %l1
  br label %merge10
else9:
  %t67 = load i8*, i8** %l6
  %t68 = load i8*, i8** %l5
  %t69 = icmp eq i8* %t67, %t68
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t71 = load i8*, i8** %l1
  %t72 = load double, double* %l2
  %t73 = load double, double* %l3
  %t74 = load i1, i1* %l4
  %t75 = load i8*, i8** %l5
  %t76 = load i8*, i8** %l6
  br i1 %t69, label %then13, label %merge14
then13:
  store i1 0, i1* %l4
  br label %merge14
merge14:
  %t77 = phi i1 [ 0, %then13 ], [ %t74, %else9 ]
  store i1 %t77, i1* %l4
  br label %merge10
merge10:
  %t78 = phi double [ %t50, %then8 ], [ %t44, %else9 ]
  %t79 = phi i8* [ %t65, %then8 ], [ %t42, %else9 ]
  %t80 = phi i1 [ %t45, %then8 ], [ 0, %else9 ]
  store double %t78, double* %l3
  store i8* %t79, i8** %l1
  store i1 %t80, i1* %l4
  %t81 = load double, double* %l3
  %t82 = sitofp i64 1 to double
  %t83 = fadd double %t81, %t82
  store double %t83, double* %l3
  br label %loop.latch2
merge7:
  %t85 = load i8*, i8** %l6
  %t86 = load i8, i8* %t85
  %t87 = icmp eq i8 %t86, 34
  br label %logical_or_entry_84

logical_or_entry_84:
  br i1 %t87, label %logical_or_merge_84, label %logical_or_right_84

logical_or_right_84:
  %t88 = load i8*, i8** %l6
  %t89 = load i8, i8* %t88
  %t90 = icmp eq i8 %t89, 39
  br label %logical_or_right_end_84

logical_or_right_end_84:
  br label %logical_or_merge_84

logical_or_merge_84:
  %t91 = phi i1 [ true, %logical_or_entry_84 ], [ %t90, %logical_or_right_end_84 ]
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t93 = load i8*, i8** %l1
  %t94 = load double, double* %l2
  %t95 = load double, double* %l3
  %t96 = load i1, i1* %l4
  %t97 = load i8*, i8** %l5
  %t98 = load i8*, i8** %l6
  br i1 %t91, label %then15, label %merge16
then15:
  store i1 1, i1* %l4
  %t99 = load i8*, i8** %l6
  store i8* %t99, i8** %l5
  %t100 = load i8*, i8** %l1
  %t101 = load i8*, i8** %l6
  %t102 = call i8* @sailfin_runtime_string_concat(i8* %t100, i8* %t101)
  store i8* %t102, i8** %l1
  %t103 = load double, double* %l3
  %t104 = sitofp i64 1 to double
  %t105 = fadd double %t103, %t104
  store double %t105, double* %l3
  br label %loop.latch2
merge16:
  %t107 = load i8*, i8** %l6
  %t108 = load i8, i8* %t107
  %t109 = icmp eq i8 %t108, 123
  br label %logical_or_entry_106

logical_or_entry_106:
  br i1 %t109, label %logical_or_merge_106, label %logical_or_right_106

logical_or_right_106:
  %t111 = load i8*, i8** %l6
  %t112 = load i8, i8* %t111
  %t113 = icmp eq i8 %t112, 91
  br label %logical_or_entry_110

logical_or_entry_110:
  br i1 %t113, label %logical_or_merge_110, label %logical_or_right_110

logical_or_right_110:
  %t114 = load i8*, i8** %l6
  %t115 = load i8, i8* %t114
  %t116 = icmp eq i8 %t115, 40
  br label %logical_or_right_end_110

logical_or_right_end_110:
  br label %logical_or_merge_110

logical_or_merge_110:
  %t117 = phi i1 [ true, %logical_or_entry_110 ], [ %t116, %logical_or_right_end_110 ]
  br label %logical_or_right_end_106

logical_or_right_end_106:
  br label %logical_or_merge_106

logical_or_merge_106:
  %t118 = phi i1 [ true, %logical_or_entry_106 ], [ %t117, %logical_or_right_end_106 ]
  %t119 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t120 = load i8*, i8** %l1
  %t121 = load double, double* %l2
  %t122 = load double, double* %l3
  %t123 = load i1, i1* %l4
  %t124 = load i8*, i8** %l5
  %t125 = load i8*, i8** %l6
  br i1 %t118, label %then17, label %else18
then17:
  %t126 = load double, double* %l2
  %t127 = sitofp i64 1 to double
  %t128 = fadd double %t126, %t127
  store double %t128, double* %l2
  br label %merge19
else18:
  %t130 = load i8*, i8** %l6
  %t131 = load i8, i8* %t130
  %t132 = icmp eq i8 %t131, 125
  br label %logical_or_entry_129

logical_or_entry_129:
  br i1 %t132, label %logical_or_merge_129, label %logical_or_right_129

logical_or_right_129:
  %t134 = load i8*, i8** %l6
  %t135 = load i8, i8* %t134
  %t136 = icmp eq i8 %t135, 93
  br label %logical_or_entry_133

logical_or_entry_133:
  br i1 %t136, label %logical_or_merge_133, label %logical_or_right_133

logical_or_right_133:
  %t137 = load i8*, i8** %l6
  %t138 = load i8, i8* %t137
  %t139 = icmp eq i8 %t138, 41
  br label %logical_or_right_end_133

logical_or_right_end_133:
  br label %logical_or_merge_133

logical_or_merge_133:
  %t140 = phi i1 [ true, %logical_or_entry_133 ], [ %t139, %logical_or_right_end_133 ]
  br label %logical_or_right_end_129

logical_or_right_end_129:
  br label %logical_or_merge_129

logical_or_merge_129:
  %t141 = phi i1 [ true, %logical_or_entry_129 ], [ %t140, %logical_or_right_end_129 ]
  %t142 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t143 = load i8*, i8** %l1
  %t144 = load double, double* %l2
  %t145 = load double, double* %l3
  %t146 = load i1, i1* %l4
  %t147 = load i8*, i8** %l5
  %t148 = load i8*, i8** %l6
  br i1 %t141, label %then20, label %merge21
then20:
  %t149 = load double, double* %l2
  %t150 = sitofp i64 0 to double
  %t151 = fcmp ogt double %t149, %t150
  %t152 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t153 = load i8*, i8** %l1
  %t154 = load double, double* %l2
  %t155 = load double, double* %l3
  %t156 = load i1, i1* %l4
  %t157 = load i8*, i8** %l5
  %t158 = load i8*, i8** %l6
  br i1 %t151, label %then22, label %merge23
then22:
  %t159 = load double, double* %l2
  %t160 = sitofp i64 1 to double
  %t161 = fsub double %t159, %t160
  store double %t161, double* %l2
  br label %merge23
merge23:
  %t162 = phi double [ %t161, %then22 ], [ %t154, %then20 ]
  store double %t162, double* %l2
  br label %merge21
merge21:
  %t163 = phi double [ %t161, %then20 ], [ %t144, %else18 ]
  store double %t163, double* %l2
  br label %merge19
merge19:
  %t164 = phi double [ %t128, %then17 ], [ %t161, %else18 ]
  store double %t164, double* %l2
  %t166 = load i8*, i8** %l6
  %t167 = load i8, i8* %t166
  %t168 = icmp eq i8 %t167, 44
  br label %logical_and_entry_165

logical_and_entry_165:
  br i1 %t168, label %logical_and_right_165, label %logical_and_merge_165

logical_and_right_165:
  %t169 = load double, double* %l2
  %t170 = sitofp i64 0 to double
  %t171 = fcmp oeq double %t169, %t170
  br label %logical_and_right_end_165

logical_and_right_end_165:
  br label %logical_and_merge_165

logical_and_merge_165:
  %t172 = phi i1 [ false, %logical_and_entry_165 ], [ %t171, %logical_and_right_end_165 ]
  %t173 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t174 = load i8*, i8** %l1
  %t175 = load double, double* %l2
  %t176 = load double, double* %l3
  %t177 = load i1, i1* %l4
  %t178 = load i8*, i8** %l5
  %t179 = load i8*, i8** %l6
  br i1 %t172, label %then24, label %else25
then24:
  %t180 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t181 = load i8*, i8** %l1
  %t182 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t180, i8* %t181)
  store { i8**, i64 }* %t182, { i8**, i64 }** %l0
  %s183 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s183, i8** %l1
  br label %merge26
else25:
  %t184 = load i8*, i8** %l1
  %t185 = load i8*, i8** %l6
  %t186 = call i8* @sailfin_runtime_string_concat(i8* %t184, i8* %t185)
  store i8* %t186, i8** %l1
  br label %merge26
merge26:
  %t187 = phi { i8**, i64 }* [ %t182, %then24 ], [ %t173, %else25 ]
  %t188 = phi i8* [ %s183, %then24 ], [ %t186, %else25 ]
  store { i8**, i64 }* %t187, { i8**, i64 }** %l0
  store i8* %t188, i8** %l1
  %t189 = load double, double* %l3
  %t190 = sitofp i64 1 to double
  %t191 = fadd double %t189, %t190
  store double %t191, double* %l3
  br label %loop.latch2
loop.latch2:
  %t192 = load i8*, i8** %l1
  %t193 = load double, double* %l3
  %t194 = load i1, i1* %l4
  %t195 = load i8*, i8** %l5
  %t196 = load double, double* %l2
  %t197 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t204 = load i8*, i8** %l1
  %t205 = call i64 @sailfin_runtime_string_length(i8* %t204)
  %t206 = icmp sgt i64 %t205, 0
  %t207 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t208 = load i8*, i8** %l1
  %t209 = load double, double* %l2
  %t210 = load double, double* %l3
  %t211 = load i1, i1* %l4
  %t212 = load i8*, i8** %l5
  br i1 %t206, label %then27, label %merge28
then27:
  %t213 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t214 = load i8*, i8** %l1
  %t215 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t213, i8* %t214)
  store { i8**, i64 }* %t215, { i8**, i64 }** %l0
  br label %merge28
merge28:
  %t216 = phi { i8**, i64 }* [ %t215, %then27 ], [ %t207, %entry ]
  store { i8**, i64 }* %t216, { i8**, i64 }** %l0
  %t217 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t217
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

define double @index_of(i8* %value, i8* %target) {
entry:
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

define double @find_matching_brace(i8* %text, double %open_index) {
entry:
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
  br label %merge8
else7:
  %t20 = load i8*, i8** %l2
  %t21 = load i8, i8* %t20
  %t22 = icmp eq i8 %t21, 125
  %t23 = load double, double* %l0
  %t24 = load double, double* %l1
  %t25 = load i8*, i8** %l2
  br i1 %t22, label %then9, label %merge10
then9:
  %t26 = load double, double* %l0
  %t27 = sitofp i64 0 to double
  %t28 = fcmp ole double %t26, %t27
  %t29 = load double, double* %l0
  %t30 = load double, double* %l1
  %t31 = load i8*, i8** %l2
  br i1 %t28, label %then11, label %merge12
then11:
  %t32 = sitofp i64 -1 to double
  ret double %t32
merge12:
  %t33 = load double, double* %l0
  %t34 = sitofp i64 1 to double
  %t35 = fsub double %t33, %t34
  store double %t35, double* %l0
  %t36 = load double, double* %l0
  %t37 = sitofp i64 0 to double
  %t38 = fcmp oeq double %t36, %t37
  %t39 = load double, double* %l0
  %t40 = load double, double* %l1
  %t41 = load i8*, i8** %l2
  br i1 %t38, label %then13, label %merge14
then13:
  %t42 = load double, double* %l1
  ret double %t42
merge14:
  br label %merge10
merge10:
  %t43 = phi double [ %t35, %then9 ], [ %t23, %else7 ]
  store double %t43, double* %l0
  br label %merge8
merge8:
  %t44 = phi double [ %t19, %then6 ], [ %t35, %else7 ]
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

define i1 @is_escaped_quote(i8* %text, double %position) {
entry:
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
  %t26 = phi double [ %t5, %entry ], [ %t24, %loop.latch4 ]
  %t27 = phi double [ %t6, %entry ], [ %t25, %loop.latch4 ]
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
  %t29 = sitofp i64 2 to double
  %t30 = frem double %t28, %t29
  %t31 = sitofp i64 1 to double
  %t32 = fcmp oeq double %t30, %t31
  %t33 = load double, double* %l0
  %t34 = load double, double* %l1
  br i1 %t32, label %then10, label %merge11
then10:
  ret i1 1
merge11:
  ret i1 0
}

define double @find_next_square_open(i8* %text, double %start) {
entry:
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
  %t92 = phi i1 [ %t1, %entry ], [ %t89, %loop.latch2 ]
  %t93 = phi double [ %t0, %entry ], [ %t90, %loop.latch2 ]
  %t94 = phi i1 [ %t2, %entry ], [ %t91, %loop.latch2 ]
  store i1 %t92, i1* %l1
  store double %t93, double* %l0
  store i1 %t94, i1* %l2
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
  br label %merge9
merge9:
  %t32 = phi i1 [ %t31, %then8 ], [ %t27, %then6 ]
  store i1 %t32, i1* %l1
  %t33 = load double, double* %l0
  %t34 = sitofp i64 1 to double
  %t35 = fadd double %t33, %t34
  store double %t35, double* %l0
  br label %loop.latch2
merge7:
  %t36 = load i8*, i8** %l3
  %t37 = load i8, i8* %t36
  %t38 = icmp eq i8 %t37, 34
  %t39 = load double, double* %l0
  %t40 = load i1, i1* %l1
  %t41 = load i1, i1* %l2
  %t42 = load i8*, i8** %l3
  br i1 %t38, label %then10, label %merge11
then10:
  %t44 = load i1, i1* %l1
  br label %logical_and_entry_43

logical_and_entry_43:
  br i1 %t44, label %logical_and_right_43, label %logical_and_merge_43

logical_and_right_43:
  %t45 = load double, double* %l0
  %t46 = call i1 @is_escaped_quote(i8* %text, double %t45)
  %t47 = xor i1 %t46, 1
  br label %logical_and_right_end_43

logical_and_right_end_43:
  br label %logical_and_merge_43

logical_and_merge_43:
  %t48 = phi i1 [ false, %logical_and_entry_43 ], [ %t47, %logical_and_right_end_43 ]
  %t49 = xor i1 %t48, 1
  %t50 = load double, double* %l0
  %t51 = load i1, i1* %l1
  %t52 = load i1, i1* %l2
  %t53 = load i8*, i8** %l3
  br i1 %t49, label %then12, label %merge13
then12:
  %t54 = load i1, i1* %l2
  %t55 = xor i1 %t54, 1
  store i1 %t55, i1* %l2
  br label %merge13
merge13:
  %t56 = phi i1 [ %t55, %then12 ], [ %t52, %then10 ]
  store i1 %t56, i1* %l2
  %t57 = load double, double* %l0
  %t58 = sitofp i64 1 to double
  %t59 = fadd double %t57, %t58
  store double %t59, double* %l0
  br label %loop.latch2
merge11:
  %t61 = load i1, i1* %l1
  br label %logical_and_entry_60

logical_and_entry_60:
  br i1 %t61, label %logical_and_right_60, label %logical_and_merge_60

logical_and_right_60:
  %t62 = load i1, i1* %l2
  %t63 = xor i1 %t62, 1
  br label %logical_and_right_end_60

logical_and_right_end_60:
  br label %logical_and_merge_60

logical_and_merge_60:
  %t64 = phi i1 [ false, %logical_and_entry_60 ], [ %t63, %logical_and_right_end_60 ]
  %t65 = xor i1 %t64, 1
  %t66 = load double, double* %l0
  %t67 = load i1, i1* %l1
  %t68 = load i1, i1* %l2
  %t69 = load i8*, i8** %l3
  br i1 %t65, label %then14, label %merge15
then14:
  %t70 = load i8*, i8** %l3
  %t71 = load i8, i8* %t70
  %t72 = icmp eq i8 %t71, 91
  %t73 = load double, double* %l0
  %t74 = load i1, i1* %l1
  %t75 = load i1, i1* %l2
  %t76 = load i8*, i8** %l3
  br i1 %t72, label %then16, label %merge17
then16:
  %t77 = load double, double* %l0
  ret double %t77
merge17:
  %t78 = load i8*, i8** %l3
  %t79 = load i8, i8* %t78
  %t80 = icmp eq i8 %t79, 93
  %t81 = load double, double* %l0
  %t82 = load i1, i1* %l1
  %t83 = load i1, i1* %l2
  %t84 = load i8*, i8** %l3
  br i1 %t80, label %then18, label %merge19
then18:
  %t85 = sitofp i64 -1 to double
  ret double %t85
merge19:
  br label %merge15
merge15:
  %t86 = load double, double* %l0
  %t87 = sitofp i64 1 to double
  %t88 = fadd double %t86, %t87
  store double %t88, double* %l0
  br label %loop.latch2
loop.latch2:
  %t89 = load i1, i1* %l1
  %t90 = load double, double* %l0
  %t91 = load i1, i1* %l2
  br label %loop.header0
afterloop3:
  %t95 = sitofp i64 -1 to double
  ret double %t95
}

define double @find_matching_square(i8* %text, double %open_index) {
entry:
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
  %t127 = phi i1 [ %t3, %entry ], [ %t123, %loop.latch2 ]
  %t128 = phi double [ %t2, %entry ], [ %t124, %loop.latch2 ]
  %t129 = phi i1 [ %t4, %entry ], [ %t125, %loop.latch2 ]
  %t130 = phi double [ %t1, %entry ], [ %t126, %loop.latch2 ]
  store i1 %t127, i1* %l2
  store double %t128, double* %l1
  store i1 %t129, i1* %l3
  store double %t130, double* %l0
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
  br label %merge9
merge9:
  %t38 = phi i1 [ %t37, %then8 ], [ %t33, %then6 ]
  store i1 %t38, i1* %l2
  %t39 = load double, double* %l1
  %t40 = sitofp i64 1 to double
  %t41 = fadd double %t39, %t40
  store double %t41, double* %l1
  br label %loop.latch2
merge7:
  %t42 = load i8, i8* %l4
  %t43 = icmp eq i8 %t42, 34
  %t44 = load double, double* %l0
  %t45 = load double, double* %l1
  %t46 = load i1, i1* %l2
  %t47 = load i1, i1* %l3
  %t48 = load i8, i8* %l4
  br i1 %t43, label %then10, label %merge11
then10:
  %t50 = load i1, i1* %l2
  br label %logical_and_entry_49

logical_and_entry_49:
  br i1 %t50, label %logical_and_right_49, label %logical_and_merge_49

logical_and_right_49:
  %t51 = load double, double* %l1
  %t52 = call i1 @is_escaped_quote(i8* %text, double %t51)
  %t53 = xor i1 %t52, 1
  br label %logical_and_right_end_49

logical_and_right_end_49:
  br label %logical_and_merge_49

logical_and_merge_49:
  %t54 = phi i1 [ false, %logical_and_entry_49 ], [ %t53, %logical_and_right_end_49 ]
  %t55 = xor i1 %t54, 1
  %t56 = load double, double* %l0
  %t57 = load double, double* %l1
  %t58 = load i1, i1* %l2
  %t59 = load i1, i1* %l3
  %t60 = load i8, i8* %l4
  br i1 %t55, label %then12, label %merge13
then12:
  %t61 = load i1, i1* %l3
  %t62 = xor i1 %t61, 1
  store i1 %t62, i1* %l3
  br label %merge13
merge13:
  %t63 = phi i1 [ %t62, %then12 ], [ %t59, %then10 ]
  store i1 %t63, i1* %l3
  %t64 = load double, double* %l1
  %t65 = sitofp i64 1 to double
  %t66 = fadd double %t64, %t65
  store double %t66, double* %l1
  br label %loop.latch2
merge11:
  %t68 = load i1, i1* %l2
  br label %logical_and_entry_67

logical_and_entry_67:
  br i1 %t68, label %logical_and_right_67, label %logical_and_merge_67

logical_and_right_67:
  %t69 = load i1, i1* %l3
  %t70 = xor i1 %t69, 1
  br label %logical_and_right_end_67

logical_and_right_end_67:
  br label %logical_and_merge_67

logical_and_merge_67:
  %t71 = phi i1 [ false, %logical_and_entry_67 ], [ %t70, %logical_and_right_end_67 ]
  %t72 = xor i1 %t71, 1
  %t73 = load double, double* %l0
  %t74 = load double, double* %l1
  %t75 = load i1, i1* %l2
  %t76 = load i1, i1* %l3
  %t77 = load i8, i8* %l4
  br i1 %t72, label %then14, label %merge15
then14:
  %t78 = load i8, i8* %l4
  %t79 = icmp eq i8 %t78, 91
  %t80 = load double, double* %l0
  %t81 = load double, double* %l1
  %t82 = load i1, i1* %l2
  %t83 = load i1, i1* %l3
  %t84 = load i8, i8* %l4
  br i1 %t79, label %then16, label %else17
then16:
  %t85 = load double, double* %l0
  %t86 = sitofp i64 1 to double
  %t87 = fadd double %t85, %t86
  store double %t87, double* %l0
  br label %merge18
else17:
  %t88 = load i8, i8* %l4
  %t89 = icmp eq i8 %t88, 93
  %t90 = load double, double* %l0
  %t91 = load double, double* %l1
  %t92 = load i1, i1* %l2
  %t93 = load i1, i1* %l3
  %t94 = load i8, i8* %l4
  br i1 %t89, label %then19, label %merge20
then19:
  %t95 = load double, double* %l0
  %t96 = sitofp i64 0 to double
  %t97 = fcmp ole double %t95, %t96
  %t98 = load double, double* %l0
  %t99 = load double, double* %l1
  %t100 = load i1, i1* %l2
  %t101 = load i1, i1* %l3
  %t102 = load i8, i8* %l4
  br i1 %t97, label %then21, label %merge22
then21:
  %t103 = sitofp i64 -1 to double
  ret double %t103
merge22:
  %t104 = load double, double* %l0
  %t105 = sitofp i64 1 to double
  %t106 = fsub double %t104, %t105
  store double %t106, double* %l0
  %t107 = load double, double* %l0
  %t108 = sitofp i64 0 to double
  %t109 = fcmp oeq double %t107, %t108
  %t110 = load double, double* %l0
  %t111 = load double, double* %l1
  %t112 = load i1, i1* %l2
  %t113 = load i1, i1* %l3
  %t114 = load i8, i8* %l4
  br i1 %t109, label %then23, label %merge24
then23:
  %t115 = load double, double* %l1
  ret double %t115
merge24:
  br label %merge20
merge20:
  %t116 = phi double [ %t106, %then19 ], [ %t90, %else17 ]
  store double %t116, double* %l0
  br label %merge18
merge18:
  %t117 = phi double [ %t87, %then16 ], [ %t106, %else17 ]
  store double %t117, double* %l0
  br label %merge15
merge15:
  %t118 = phi double [ %t87, %then14 ], [ %t73, %loop.body1 ]
  %t119 = phi double [ %t106, %then14 ], [ %t73, %loop.body1 ]
  store double %t118, double* %l0
  store double %t119, double* %l0
  %t120 = load double, double* %l1
  %t121 = sitofp i64 1 to double
  %t122 = fadd double %t120, %t121
  store double %t122, double* %l1
  br label %loop.latch2
loop.latch2:
  %t123 = load i1, i1* %l2
  %t124 = load double, double* %l1
  %t125 = load i1, i1* %l3
  %t126 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t131 = sitofp i64 -1 to double
  ret double %t131
}

define double @find_substring_from(i8* %value, i8* %pattern, double %start) {
entry:
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
  br label %merge7
merge7:
  %t15 = phi double [ %t14, %then6 ], [ %t13, %entry ]
  store double %t15, double* %l0
  %t16 = load double, double* %l0
  br label %loop.header8
loop.header8:
  %t66 = phi double [ %t16, %entry ], [ %t65, %loop.latch10 ]
  store double %t66, double* %l0
  br label %loop.body9
loop.body9:
  %t17 = load double, double* %l0
  %t18 = call i64 @sailfin_runtime_string_length(i8* %pattern)
  %t19 = sitofp i64 %t18 to double
  %t20 = fadd double %t17, %t19
  %t21 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t22 = sitofp i64 %t21 to double
  %t23 = fcmp ogt double %t20, %t22
  %t24 = load double, double* %l0
  br i1 %t23, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  store i1 1, i1* %l1
  %t25 = sitofp i64 0 to double
  store double %t25, double* %l2
  %t26 = load double, double* %l0
  %t27 = load i1, i1* %l1
  %t28 = load double, double* %l2
  br label %loop.header14
loop.header14:
  %t55 = phi i1 [ %t27, %loop.body9 ], [ %t53, %loop.latch16 ]
  %t56 = phi double [ %t28, %loop.body9 ], [ %t54, %loop.latch16 ]
  store i1 %t55, i1* %l1
  store double %t56, double* %l2
  br label %loop.body15
loop.body15:
  %t29 = load double, double* %l2
  %t30 = call i64 @sailfin_runtime_string_length(i8* %pattern)
  %t31 = sitofp i64 %t30 to double
  %t32 = fcmp oge double %t29, %t31
  %t33 = load double, double* %l0
  %t34 = load i1, i1* %l1
  %t35 = load double, double* %l2
  br i1 %t32, label %then18, label %merge19
then18:
  br label %afterloop17
merge19:
  %t36 = load double, double* %l0
  %t37 = load double, double* %l2
  %t38 = fadd double %t36, %t37
  %t39 = fptosi double %t38 to i64
  %t40 = getelementptr i8, i8* %value, i64 %t39
  %t41 = load i8, i8* %t40
  %t42 = load double, double* %l2
  %t43 = fptosi double %t42 to i64
  %t44 = getelementptr i8, i8* %pattern, i64 %t43
  %t45 = load i8, i8* %t44
  %t46 = icmp ne i8 %t41, %t45
  %t47 = load double, double* %l0
  %t48 = load i1, i1* %l1
  %t49 = load double, double* %l2
  br i1 %t46, label %then20, label %merge21
then20:
  store i1 0, i1* %l1
  br label %afterloop17
merge21:
  %t50 = load double, double* %l2
  %t51 = sitofp i64 1 to double
  %t52 = fadd double %t50, %t51
  store double %t52, double* %l2
  br label %loop.latch16
loop.latch16:
  %t53 = load i1, i1* %l1
  %t54 = load double, double* %l2
  br label %loop.header14
afterloop17:
  %t57 = load i1, i1* %l1
  %t58 = load double, double* %l0
  %t59 = load i1, i1* %l1
  %t60 = load double, double* %l2
  br i1 %t57, label %then22, label %merge23
then22:
  %t61 = load double, double* %l0
  ret double %t61
merge23:
  %t62 = load double, double* %l0
  %t63 = sitofp i64 1 to double
  %t64 = fadd double %t62, %t63
  store double %t64, double* %l0
  br label %loop.latch10
loop.latch10:
  %t65 = load double, double* %l0
  br label %loop.header8
afterloop11:
  %t67 = sitofp i64 -1 to double
  ret double %t67
}

define %PythonFunctionEmission @emit_python_function(%PythonBuilder %builder, %NativeFunction %function) {
entry:
  %l0 = alloca %PythonBuilder
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca i8
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
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* %t2, { i8**, i64 }** %l1
  %t5 = extractvalue %NativeFunction %function, 1
  %t6 = bitcast { %NativeParameter**, i64 }* %t5 to { %NativeParameter*, i64 }*
  %t7 = call { i8**, i64 }* @render_python_parameters({ %NativeParameter*, i64 }* %t6)
  store { i8**, i64 }* %t7, { i8**, i64 }** %l2
  %s8 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h256486202, i32 0, i32 0
  %t9 = extractvalue %NativeFunction %function, 0
  %t10 = call i8* @sanitize_identifier(i8* %t9)
  %t11 = call i8* @sailfin_runtime_string_concat(i8* %s8, i8* %t10)
  %t12 = load i8, i8* %t11
  %t13 = add i8 %t12, 40
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %s15 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t16 = call i8* @join_with_separator({ i8**, i64 }* %t14, i8* %s15)
  %t17 = load i8, i8* %t16
  %t18 = add i8 %t13, %t17
  %s19 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193423562, i32 0, i32 0
  %t20 = load i8, i8* %s19
  %t21 = add i8 %t18, %t20
  store i8 %t21, i8* %l3
  %t22 = load %PythonBuilder, %PythonBuilder* %l0
  %t23 = load i8, i8* %l3
  %t24 = alloca [2 x i8], align 1
  %t25 = getelementptr [2 x i8], [2 x i8]* %t24, i32 0, i32 0
  store i8 %t23, i8* %t25
  %t26 = getelementptr [2 x i8], [2 x i8]* %t24, i32 0, i32 1
  store i8 0, i8* %t26
  %t27 = getelementptr [2 x i8], [2 x i8]* %t24, i32 0, i32 0
  %t28 = call %PythonBuilder @builder_emit(%PythonBuilder %t22, i8* %t27)
  store %PythonBuilder %t28, %PythonBuilder* %l0
  %t29 = load %PythonBuilder, %PythonBuilder* %l0
  %t30 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t29)
  store %PythonBuilder %t30, %PythonBuilder* %l0
  %t31 = extractvalue %NativeFunction %function, 3
  %t32 = load { i8**, i64 }, { i8**, i64 }* %t31
  %t33 = extractvalue { i8**, i64 } %t32, 1
  %t34 = icmp sgt i64 %t33, 0
  %t35 = load %PythonBuilder, %PythonBuilder* %l0
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t38 = load i8, i8* %l3
  br i1 %t34, label %then0, label %merge1
then0:
  %t39 = load %PythonBuilder, %PythonBuilder* %l0
  %s40 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1779553665, i32 0, i32 0
  %t41 = extractvalue %NativeFunction %function, 3
  %s42 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t43 = call i8* @join_with_separator({ i8**, i64 }* %t41, i8* %s42)
  %t44 = call i8* @sailfin_runtime_string_concat(i8* %s40, i8* %t43)
  %t45 = call %PythonBuilder @builder_emit(%PythonBuilder %t39, i8* %t44)
  store %PythonBuilder %t45, %PythonBuilder* %l0
  br label %merge1
merge1:
  %t46 = phi %PythonBuilder [ %t45, %then0 ], [ %t35, %entry ]
  store %PythonBuilder %t46, %PythonBuilder* %l0
  %t47 = extractvalue %NativeFunction %function, 4
  %t48 = load { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t47
  %t49 = extractvalue { %NativeInstruction**, i64 } %t48, 1
  %t50 = icmp eq i64 %t49, 0
  %t51 = load %PythonBuilder, %PythonBuilder* %l0
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t54 = load i8, i8* %l3
  br i1 %t50, label %then2, label %merge3
then2:
  %t55 = load %PythonBuilder, %PythonBuilder* %l0
  %s56 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h270590402, i32 0, i32 0
  %t57 = call %PythonBuilder @builder_emit(%PythonBuilder %t55, i8* %s56)
  store %PythonBuilder %t57, %PythonBuilder* %l0
  %t58 = load %PythonBuilder, %PythonBuilder* %l0
  %t59 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t58)
  store %PythonBuilder %t59, %PythonBuilder* %l0
  %t60 = load %PythonBuilder, %PythonBuilder* %l0
  %t61 = insertvalue %PythonFunctionEmission undef, %PythonBuilder %t60, 0
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t63 = insertvalue %PythonFunctionEmission %t61, { i8**, i64 }* %t62, 1
  ret %PythonFunctionEmission %t63
merge3:
  %t64 = sitofp i64 0 to double
  store double %t64, double* %l4
  %t65 = alloca [0 x %MatchContext]
  %t66 = getelementptr [0 x %MatchContext], [0 x %MatchContext]* %t65, i32 0, i32 0
  %t67 = alloca { %MatchContext*, i64 }
  %t68 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t67, i32 0, i32 0
  store %MatchContext* %t66, %MatchContext** %t68
  %t69 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t67, i32 0, i32 1
  store i64 0, i64* %t69
  store { %MatchContext*, i64 }* %t67, { %MatchContext*, i64 }** %l5
  %t70 = sitofp i64 0 to double
  store double %t70, double* %l6
  %t71 = sitofp i64 0 to double
  store double %t71, double* %l7
  %t72 = load %PythonBuilder, %PythonBuilder* %l0
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t75 = load i8, i8* %l3
  %t76 = load double, double* %l4
  %t77 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t78 = load double, double* %l6
  %t79 = load double, double* %l7
  br label %loop.header4
loop.header4:
  %t2084 = phi %PythonBuilder [ %t72, %entry ], [ %t2078, %loop.latch6 ]
  %t2085 = phi double [ %t79, %entry ], [ %t2079, %loop.latch6 ]
  %t2086 = phi double [ %t76, %entry ], [ %t2080, %loop.latch6 ]
  %t2087 = phi { i8**, i64 }* [ %t73, %entry ], [ %t2081, %loop.latch6 ]
  %t2088 = phi double [ %t78, %entry ], [ %t2082, %loop.latch6 ]
  %t2089 = phi { %MatchContext*, i64 }* [ %t77, %entry ], [ %t2083, %loop.latch6 ]
  store %PythonBuilder %t2084, %PythonBuilder* %l0
  store double %t2085, double* %l7
  store double %t2086, double* %l4
  store { i8**, i64 }* %t2087, { i8**, i64 }** %l1
  store double %t2088, double* %l6
  store { %MatchContext*, i64 }* %t2089, { %MatchContext*, i64 }** %l5
  br label %loop.body5
loop.body5:
  %t80 = load double, double* %l7
  %t81 = extractvalue %NativeFunction %function, 4
  %t82 = load { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t81
  %t83 = extractvalue { %NativeInstruction**, i64 } %t82, 1
  %t84 = sitofp i64 %t83 to double
  %t85 = fcmp oge double %t80, %t84
  %t86 = load %PythonBuilder, %PythonBuilder* %l0
  %t87 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t89 = load i8, i8* %l3
  %t90 = load double, double* %l4
  %t91 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t92 = load double, double* %l6
  %t93 = load double, double* %l7
  br i1 %t85, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t94 = extractvalue %NativeFunction %function, 4
  %t95 = load double, double* %l7
  %t96 = fptosi double %t95 to i64
  %t97 = load { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t94
  %t98 = extractvalue { %NativeInstruction**, i64 } %t97, 0
  %t99 = extractvalue { %NativeInstruction**, i64 } %t97, 1
  %t100 = icmp uge i64 %t96, %t99
  ; bounds check: %t100 (if true, out of bounds)
  %t101 = getelementptr %NativeInstruction*, %NativeInstruction** %t98, i64 %t96
  %t102 = load %NativeInstruction*, %NativeInstruction** %t101
  store %NativeInstruction* %t102, %NativeInstruction** %l8
  %t103 = load %NativeInstruction*, %NativeInstruction** %l8
  %t104 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t103, i32 0, i32 0
  %t105 = load i32, i32* %t104
  %t106 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t107 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t108 = icmp eq i32 %t105, 0
  %t109 = select i1 %t108, i8* %t107, i8* %t106
  %t110 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t111 = icmp eq i32 %t105, 1
  %t112 = select i1 %t111, i8* %t110, i8* %t109
  %t113 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t114 = icmp eq i32 %t105, 2
  %t115 = select i1 %t114, i8* %t113, i8* %t112
  %t116 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t117 = icmp eq i32 %t105, 3
  %t118 = select i1 %t117, i8* %t116, i8* %t115
  %t119 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t120 = icmp eq i32 %t105, 4
  %t121 = select i1 %t120, i8* %t119, i8* %t118
  %t122 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t123 = icmp eq i32 %t105, 5
  %t124 = select i1 %t123, i8* %t122, i8* %t121
  %t125 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t126 = icmp eq i32 %t105, 6
  %t127 = select i1 %t126, i8* %t125, i8* %t124
  %t128 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t129 = icmp eq i32 %t105, 7
  %t130 = select i1 %t129, i8* %t128, i8* %t127
  %t131 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t132 = icmp eq i32 %t105, 8
  %t133 = select i1 %t132, i8* %t131, i8* %t130
  %t134 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t135 = icmp eq i32 %t105, 9
  %t136 = select i1 %t135, i8* %t134, i8* %t133
  %t137 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t138 = icmp eq i32 %t105, 10
  %t139 = select i1 %t138, i8* %t137, i8* %t136
  %t140 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t141 = icmp eq i32 %t105, 11
  %t142 = select i1 %t141, i8* %t140, i8* %t139
  %t143 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t144 = icmp eq i32 %t105, 12
  %t145 = select i1 %t144, i8* %t143, i8* %t142
  %t146 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t147 = icmp eq i32 %t105, 13
  %t148 = select i1 %t147, i8* %t146, i8* %t145
  %t149 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t150 = icmp eq i32 %t105, 14
  %t151 = select i1 %t150, i8* %t149, i8* %t148
  %t152 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t153 = icmp eq i32 %t105, 15
  %t154 = select i1 %t153, i8* %t152, i8* %t151
  %t155 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t156 = icmp eq i32 %t105, 16
  %t157 = select i1 %t156, i8* %t155, i8* %t154
  %s158 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h536277508, i32 0, i32 0
  %t159 = icmp eq i8* %t157, %s158
  %t160 = load %PythonBuilder, %PythonBuilder* %l0
  %t161 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t162 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t163 = load i8, i8* %l3
  %t164 = load double, double* %l4
  %t165 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t166 = load double, double* %l6
  %t167 = load double, double* %l7
  %t168 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t159, label %then10, label %else11
then10:
  %t169 = load %NativeInstruction*, %NativeInstruction** %l8
  %t170 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t169, i32 0, i32 0
  %t171 = load i32, i32* %t170
  %t172 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t169, i32 0, i32 1
  %t173 = bitcast [16 x i8]* %t172 to i8*
  %t174 = bitcast i8* %t173 to i8**
  %t175 = load i8*, i8** %t174
  %t176 = icmp eq i32 %t171, 0
  %t177 = select i1 %t176, i8* %t175, i8* null
  %t178 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t169, i32 0, i32 1
  %t179 = bitcast [16 x i8]* %t178 to i8*
  %t180 = bitcast i8* %t179 to i8**
  %t181 = load i8*, i8** %t180
  %t182 = icmp eq i32 %t171, 1
  %t183 = select i1 %t182, i8* %t181, i8* %t177
  %t184 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t169, i32 0, i32 1
  %t185 = bitcast [8 x i8]* %t184 to i8*
  %t186 = bitcast i8* %t185 to i8**
  %t187 = load i8*, i8** %t186
  %t188 = icmp eq i32 %t171, 12
  %t189 = select i1 %t188, i8* %t187, i8* %t183
  %t190 = call i64 @sailfin_runtime_string_length(i8* %t189)
  %t191 = icmp eq i64 %t190, 0
  %t192 = load %PythonBuilder, %PythonBuilder* %l0
  %t193 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t194 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t195 = load i8, i8* %l3
  %t196 = load double, double* %l4
  %t197 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t198 = load double, double* %l6
  %t199 = load double, double* %l7
  %t200 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t191, label %then13, label %else14
then13:
  %t201 = load %PythonBuilder, %PythonBuilder* %l0
  %s202 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1061063223, i32 0, i32 0
  %t203 = call %PythonBuilder @builder_emit(%PythonBuilder %t201, i8* %s202)
  store %PythonBuilder %t203, %PythonBuilder* %l0
  br label %merge15
else14:
  %t204 = load %NativeInstruction*, %NativeInstruction** %l8
  %t205 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t204, i32 0, i32 0
  %t206 = load i32, i32* %t205
  %t207 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t204, i32 0, i32 1
  %t208 = bitcast [16 x i8]* %t207 to i8*
  %t209 = bitcast i8* %t208 to i8**
  %t210 = load i8*, i8** %t209
  %t211 = icmp eq i32 %t206, 0
  %t212 = select i1 %t211, i8* %t210, i8* null
  %t213 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t204, i32 0, i32 1
  %t214 = bitcast [16 x i8]* %t213 to i8*
  %t215 = bitcast i8* %t214 to i8**
  %t216 = load i8*, i8** %t215
  %t217 = icmp eq i32 %t206, 1
  %t218 = select i1 %t217, i8* %t216, i8* %t212
  %t219 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t204, i32 0, i32 1
  %t220 = bitcast [8 x i8]* %t219 to i8*
  %t221 = bitcast i8* %t220 to i8**
  %t222 = load i8*, i8** %t221
  %t223 = icmp eq i32 %t206, 12
  %t224 = select i1 %t223, i8* %t222, i8* %t218
  store i8* %t224, i8** %l9
  %t225 = load i8*, i8** %l9
  %t226 = extractvalue %NativeFunction %function, 4
  %t227 = load double, double* %l7
  %t228 = sitofp i64 1 to double
  %t229 = fadd double %t227, %t228
  %t230 = bitcast { %NativeInstruction**, i64 }* %t226 to { %NativeInstruction*, i64 }*
  %t231 = call %StructLiteralCapture @capture_struct_literal_expression(i8* %t225, { %NativeInstruction*, i64 }* %t230, double %t229)
  store %StructLiteralCapture %t231, %StructLiteralCapture* %l10
  %t232 = sitofp i64 0 to double
  store double %t232, double* %l11
  %t233 = load %StructLiteralCapture, %StructLiteralCapture* %l10
  %t234 = extractvalue %StructLiteralCapture %t233, 2
  %t235 = load %PythonBuilder, %PythonBuilder* %l0
  %t236 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t237 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t238 = load i8, i8* %l3
  %t239 = load double, double* %l4
  %t240 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t241 = load double, double* %l6
  %t242 = load double, double* %l7
  %t243 = load %NativeInstruction*, %NativeInstruction** %l8
  %t244 = load i8*, i8** %l9
  %t245 = load %StructLiteralCapture, %StructLiteralCapture* %l10
  %t246 = load double, double* %l11
  br i1 %t234, label %then16, label %else17
then16:
  %t247 = load %StructLiteralCapture, %StructLiteralCapture* %l10
  %t248 = extractvalue %StructLiteralCapture %t247, 0
  store i8* %t248, i8** %l9
  %t249 = load %StructLiteralCapture, %StructLiteralCapture* %l10
  %t250 = extractvalue %StructLiteralCapture %t249, 1
  store double %t250, double* %l11
  br label %merge18
else17:
  %t251 = load i8*, i8** %l9
  %t252 = extractvalue %NativeFunction %function, 4
  %t253 = load double, double* %l7
  %t254 = sitofp i64 1 to double
  %t255 = fadd double %t253, %t254
  %t256 = bitcast { %NativeInstruction**, i64 }* %t252 to { %NativeInstruction*, i64 }*
  %t257 = call %ExpressionContinuationCapture @capture_expression_continuation(i8* %t251, { %NativeInstruction*, i64 }* %t256, double %t255)
  store %ExpressionContinuationCapture %t257, %ExpressionContinuationCapture* %l12
  %t258 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l12
  %t259 = extractvalue %ExpressionContinuationCapture %t258, 2
  %t260 = load %PythonBuilder, %PythonBuilder* %l0
  %t261 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t262 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t263 = load i8, i8* %l3
  %t264 = load double, double* %l4
  %t265 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t266 = load double, double* %l6
  %t267 = load double, double* %l7
  %t268 = load %NativeInstruction*, %NativeInstruction** %l8
  %t269 = load i8*, i8** %l9
  %t270 = load %StructLiteralCapture, %StructLiteralCapture* %l10
  %t271 = load double, double* %l11
  %t272 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l12
  br i1 %t259, label %then19, label %merge20
then19:
  %t273 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l12
  %t274 = extractvalue %ExpressionContinuationCapture %t273, 0
  store i8* %t274, i8** %l9
  %t275 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l12
  %t276 = extractvalue %ExpressionContinuationCapture %t275, 1
  store double %t276, double* %l11
  br label %merge20
merge20:
  %t277 = phi i8* [ %t274, %then19 ], [ %t269, %else17 ]
  %t278 = phi double [ %t276, %then19 ], [ %t271, %else17 ]
  store i8* %t277, i8** %l9
  store double %t278, double* %l11
  br label %merge18
merge18:
  %t279 = phi i8* [ %t248, %then16 ], [ %t274, %else17 ]
  %t280 = phi double [ %t250, %then16 ], [ %t276, %else17 ]
  store i8* %t279, i8** %l9
  store double %t280, double* %l11
  %t281 = load %PythonBuilder, %PythonBuilder* %l0
  %s282 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h655348872, i32 0, i32 0
  %t283 = load i8*, i8** %l9
  %t284 = call i8* @lower_expression(i8* %t283)
  %t285 = call i8* @sailfin_runtime_string_concat(i8* %s282, i8* %t284)
  %t286 = call %PythonBuilder @builder_emit(%PythonBuilder %t281, i8* %t285)
  store %PythonBuilder %t286, %PythonBuilder* %l0
  %t287 = load double, double* %l7
  %t288 = load double, double* %l11
  %t289 = fadd double %t287, %t288
  store double %t289, double* %l7
  br label %merge15
merge15:
  %t290 = phi %PythonBuilder [ %t203, %then13 ], [ %t286, %else14 ]
  %t291 = phi double [ %t199, %then13 ], [ %t289, %else14 ]
  store %PythonBuilder %t290, %PythonBuilder* %l0
  store double %t291, double* %l7
  br label %merge12
else11:
  %t292 = load %NativeInstruction*, %NativeInstruction** %l8
  %t293 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t292, i32 0, i32 0
  %t294 = load i32, i32* %t293
  %t295 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t296 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t297 = icmp eq i32 %t294, 0
  %t298 = select i1 %t297, i8* %t296, i8* %t295
  %t299 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t300 = icmp eq i32 %t294, 1
  %t301 = select i1 %t300, i8* %t299, i8* %t298
  %t302 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t303 = icmp eq i32 %t294, 2
  %t304 = select i1 %t303, i8* %t302, i8* %t301
  %t305 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t306 = icmp eq i32 %t294, 3
  %t307 = select i1 %t306, i8* %t305, i8* %t304
  %t308 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t309 = icmp eq i32 %t294, 4
  %t310 = select i1 %t309, i8* %t308, i8* %t307
  %t311 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t312 = icmp eq i32 %t294, 5
  %t313 = select i1 %t312, i8* %t311, i8* %t310
  %t314 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t315 = icmp eq i32 %t294, 6
  %t316 = select i1 %t315, i8* %t314, i8* %t313
  %t317 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t318 = icmp eq i32 %t294, 7
  %t319 = select i1 %t318, i8* %t317, i8* %t316
  %t320 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t321 = icmp eq i32 %t294, 8
  %t322 = select i1 %t321, i8* %t320, i8* %t319
  %t323 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t324 = icmp eq i32 %t294, 9
  %t325 = select i1 %t324, i8* %t323, i8* %t322
  %t326 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t327 = icmp eq i32 %t294, 10
  %t328 = select i1 %t327, i8* %t326, i8* %t325
  %t329 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t330 = icmp eq i32 %t294, 11
  %t331 = select i1 %t330, i8* %t329, i8* %t328
  %t332 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t333 = icmp eq i32 %t294, 12
  %t334 = select i1 %t333, i8* %t332, i8* %t331
  %t335 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t336 = icmp eq i32 %t294, 13
  %t337 = select i1 %t336, i8* %t335, i8* %t334
  %t338 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t339 = icmp eq i32 %t294, 14
  %t340 = select i1 %t339, i8* %t338, i8* %t337
  %t341 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t342 = icmp eq i32 %t294, 15
  %t343 = select i1 %t342, i8* %t341, i8* %t340
  %t344 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t345 = icmp eq i32 %t294, 16
  %t346 = select i1 %t345, i8* %t344, i8* %t343
  %s347 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h1629914700, i32 0, i32 0
  %t348 = icmp eq i8* %t346, %s347
  %t349 = load %PythonBuilder, %PythonBuilder* %l0
  %t350 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t351 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t352 = load i8, i8* %l3
  %t353 = load double, double* %l4
  %t354 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t355 = load double, double* %l6
  %t356 = load double, double* %l7
  %t357 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t348, label %then21, label %else22
then21:
  %t358 = load %NativeInstruction*, %NativeInstruction** %l8
  %t359 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t358, i32 0, i32 0
  %t360 = load i32, i32* %t359
  %t361 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t358, i32 0, i32 1
  %t362 = bitcast [16 x i8]* %t361 to i8*
  %t363 = bitcast i8* %t362 to i8**
  %t364 = load i8*, i8** %t363
  %t365 = icmp eq i32 %t360, 0
  %t366 = select i1 %t365, i8* %t364, i8* null
  %t367 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t358, i32 0, i32 1
  %t368 = bitcast [16 x i8]* %t367 to i8*
  %t369 = bitcast i8* %t368 to i8**
  %t370 = load i8*, i8** %t369
  %t371 = icmp eq i32 %t360, 1
  %t372 = select i1 %t371, i8* %t370, i8* %t366
  %t373 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t358, i32 0, i32 1
  %t374 = bitcast [8 x i8]* %t373 to i8*
  %t375 = bitcast i8* %t374 to i8**
  %t376 = load i8*, i8** %t375
  %t377 = icmp eq i32 %t360, 12
  %t378 = select i1 %t377, i8* %t376, i8* %t372
  store i8* %t378, i8** %l13
  %t379 = load i8*, i8** %l13
  %t380 = extractvalue %NativeFunction %function, 4
  %t381 = load double, double* %l7
  %t382 = sitofp i64 1 to double
  %t383 = fadd double %t381, %t382
  %t384 = bitcast { %NativeInstruction**, i64 }* %t380 to { %NativeInstruction*, i64 }*
  %t385 = call %StructLiteralCapture @capture_struct_literal_expression(i8* %t379, { %NativeInstruction*, i64 }* %t384, double %t383)
  store %StructLiteralCapture %t385, %StructLiteralCapture* %l14
  %t386 = sitofp i64 0 to double
  store double %t386, double* %l15
  %t387 = load %StructLiteralCapture, %StructLiteralCapture* %l14
  %t388 = extractvalue %StructLiteralCapture %t387, 2
  %t389 = load %PythonBuilder, %PythonBuilder* %l0
  %t390 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t391 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t392 = load i8, i8* %l3
  %t393 = load double, double* %l4
  %t394 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t395 = load double, double* %l6
  %t396 = load double, double* %l7
  %t397 = load %NativeInstruction*, %NativeInstruction** %l8
  %t398 = load i8*, i8** %l13
  %t399 = load %StructLiteralCapture, %StructLiteralCapture* %l14
  %t400 = load double, double* %l15
  br i1 %t388, label %then24, label %else25
then24:
  %t401 = load %StructLiteralCapture, %StructLiteralCapture* %l14
  %t402 = extractvalue %StructLiteralCapture %t401, 0
  store i8* %t402, i8** %l13
  %t403 = load %StructLiteralCapture, %StructLiteralCapture* %l14
  %t404 = extractvalue %StructLiteralCapture %t403, 1
  store double %t404, double* %l15
  br label %merge26
else25:
  %t405 = load i8*, i8** %l13
  %t406 = extractvalue %NativeFunction %function, 4
  %t407 = load double, double* %l7
  %t408 = sitofp i64 1 to double
  %t409 = fadd double %t407, %t408
  %t410 = bitcast { %NativeInstruction**, i64 }* %t406 to { %NativeInstruction*, i64 }*
  %t411 = call %ExpressionContinuationCapture @capture_expression_continuation(i8* %t405, { %NativeInstruction*, i64 }* %t410, double %t409)
  store %ExpressionContinuationCapture %t411, %ExpressionContinuationCapture* %l16
  %t412 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l16
  %t413 = extractvalue %ExpressionContinuationCapture %t412, 2
  %t414 = load %PythonBuilder, %PythonBuilder* %l0
  %t415 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t416 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t417 = load i8, i8* %l3
  %t418 = load double, double* %l4
  %t419 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t420 = load double, double* %l6
  %t421 = load double, double* %l7
  %t422 = load %NativeInstruction*, %NativeInstruction** %l8
  %t423 = load i8*, i8** %l13
  %t424 = load %StructLiteralCapture, %StructLiteralCapture* %l14
  %t425 = load double, double* %l15
  %t426 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l16
  br i1 %t413, label %then27, label %merge28
then27:
  %t427 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l16
  %t428 = extractvalue %ExpressionContinuationCapture %t427, 0
  store i8* %t428, i8** %l13
  %t429 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l16
  %t430 = extractvalue %ExpressionContinuationCapture %t429, 1
  store double %t430, double* %l15
  br label %merge28
merge28:
  %t431 = phi i8* [ %t428, %then27 ], [ %t423, %else25 ]
  %t432 = phi double [ %t430, %then27 ], [ %t425, %else25 ]
  store i8* %t431, i8** %l13
  store double %t432, double* %l15
  br label %merge26
merge26:
  %t433 = phi i8* [ %t402, %then24 ], [ %t428, %else25 ]
  %t434 = phi double [ %t404, %then24 ], [ %t430, %else25 ]
  store i8* %t433, i8** %l13
  store double %t434, double* %l15
  %t435 = load %PythonBuilder, %PythonBuilder* %l0
  %t436 = load i8*, i8** %l13
  %t437 = call i8* @lower_expression(i8* %t436)
  %t438 = call %PythonBuilder @builder_emit(%PythonBuilder %t435, i8* %t437)
  store %PythonBuilder %t438, %PythonBuilder* %l0
  %t439 = load double, double* %l7
  %t440 = load double, double* %l15
  %t441 = fadd double %t439, %t440
  store double %t441, double* %l7
  br label %merge23
else22:
  %t442 = load %NativeInstruction*, %NativeInstruction** %l8
  %t443 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t442, i32 0, i32 0
  %t444 = load i32, i32* %t443
  %t445 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t446 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t447 = icmp eq i32 %t444, 0
  %t448 = select i1 %t447, i8* %t446, i8* %t445
  %t449 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t450 = icmp eq i32 %t444, 1
  %t451 = select i1 %t450, i8* %t449, i8* %t448
  %t452 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t453 = icmp eq i32 %t444, 2
  %t454 = select i1 %t453, i8* %t452, i8* %t451
  %t455 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t456 = icmp eq i32 %t444, 3
  %t457 = select i1 %t456, i8* %t455, i8* %t454
  %t458 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t459 = icmp eq i32 %t444, 4
  %t460 = select i1 %t459, i8* %t458, i8* %t457
  %t461 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t462 = icmp eq i32 %t444, 5
  %t463 = select i1 %t462, i8* %t461, i8* %t460
  %t464 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t465 = icmp eq i32 %t444, 6
  %t466 = select i1 %t465, i8* %t464, i8* %t463
  %t467 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t468 = icmp eq i32 %t444, 7
  %t469 = select i1 %t468, i8* %t467, i8* %t466
  %t470 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t471 = icmp eq i32 %t444, 8
  %t472 = select i1 %t471, i8* %t470, i8* %t469
  %t473 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t474 = icmp eq i32 %t444, 9
  %t475 = select i1 %t474, i8* %t473, i8* %t472
  %t476 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t477 = icmp eq i32 %t444, 10
  %t478 = select i1 %t477, i8* %t476, i8* %t475
  %t479 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t480 = icmp eq i32 %t444, 11
  %t481 = select i1 %t480, i8* %t479, i8* %t478
  %t482 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t483 = icmp eq i32 %t444, 12
  %t484 = select i1 %t483, i8* %t482, i8* %t481
  %t485 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t486 = icmp eq i32 %t444, 13
  %t487 = select i1 %t486, i8* %t485, i8* %t484
  %t488 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t489 = icmp eq i32 %t444, 14
  %t490 = select i1 %t489, i8* %t488, i8* %t487
  %t491 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t492 = icmp eq i32 %t444, 15
  %t493 = select i1 %t492, i8* %t491, i8* %t490
  %t494 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t495 = icmp eq i32 %t444, 16
  %t496 = select i1 %t495, i8* %t494, i8* %t493
  %s497 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2089318639, i32 0, i32 0
  %t498 = icmp eq i8* %t496, %s497
  %t499 = load %PythonBuilder, %PythonBuilder* %l0
  %t500 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t501 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t502 = load i8, i8* %l3
  %t503 = load double, double* %l4
  %t504 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t505 = load double, double* %l6
  %t506 = load double, double* %l7
  %t507 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t498, label %then29, label %else30
then29:
  %t508 = load %NativeInstruction*, %NativeInstruction** %l8
  %t509 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t508, i32 0, i32 0
  %t510 = load i32, i32* %t509
  %t511 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t508, i32 0, i32 1
  %t512 = bitcast [48 x i8]* %t511 to i8*
  %t513 = bitcast i8* %t512 to i8**
  %t514 = load i8*, i8** %t513
  %t515 = icmp eq i32 %t510, 2
  %t516 = select i1 %t515, i8* %t514, i8* null
  %t517 = call i8* @sanitize_identifier(i8* %t516)
  store i8* %t517, i8** %l17
  %t518 = load i8*, i8** %l17
  %s519 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087691079, i32 0, i32 0
  %t520 = call i8* @sailfin_runtime_string_concat(i8* %t518, i8* %s519)
  store i8* %t520, i8** %l18
  %t521 = load %NativeInstruction*, %NativeInstruction** %l8
  %t522 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t521, i32 0, i32 0
  %t523 = load i32, i32* %t522
  %t524 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t521, i32 0, i32 1
  %t525 = bitcast [48 x i8]* %t524 to i8*
  %t526 = getelementptr inbounds i8, i8* %t525, i64 24
  %t527 = bitcast i8* %t526 to i8**
  %t528 = load i8*, i8** %t527
  %t529 = icmp eq i32 %t523, 2
  %t530 = select i1 %t529, i8* %t528, i8* null
  %t531 = icmp ne i8* %t530, null
  %t532 = load %PythonBuilder, %PythonBuilder* %l0
  %t533 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t534 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t535 = load i8, i8* %l3
  %t536 = load double, double* %l4
  %t537 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t538 = load double, double* %l6
  %t539 = load double, double* %l7
  %t540 = load %NativeInstruction*, %NativeInstruction** %l8
  %t541 = load i8*, i8** %l17
  %t542 = load i8*, i8** %l18
  br i1 %t531, label %then32, label %else33
then32:
  %t543 = load %NativeInstruction*, %NativeInstruction** %l8
  %t544 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t543, i32 0, i32 0
  %t545 = load i32, i32* %t544
  %t546 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t543, i32 0, i32 1
  %t547 = bitcast [48 x i8]* %t546 to i8*
  %t548 = getelementptr inbounds i8, i8* %t547, i64 24
  %t549 = bitcast i8* %t548 to i8**
  %t550 = load i8*, i8** %t549
  %t551 = icmp eq i32 %t545, 2
  %t552 = select i1 %t551, i8* %t550, i8* null
  store i8* %t552, i8** %l19
  %t553 = load i8*, i8** %l19
  %t554 = extractvalue %NativeFunction %function, 4
  %t555 = load double, double* %l7
  %t556 = sitofp i64 1 to double
  %t557 = fadd double %t555, %t556
  %t558 = bitcast { %NativeInstruction**, i64 }* %t554 to { %NativeInstruction*, i64 }*
  %t559 = call %StructLiteralCapture @capture_struct_literal_expression(i8* %t553, { %NativeInstruction*, i64 }* %t558, double %t557)
  store %StructLiteralCapture %t559, %StructLiteralCapture* %l20
  %t560 = sitofp i64 0 to double
  store double %t560, double* %l21
  %t561 = load %StructLiteralCapture, %StructLiteralCapture* %l20
  %t562 = extractvalue %StructLiteralCapture %t561, 2
  %t563 = load %PythonBuilder, %PythonBuilder* %l0
  %t564 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t565 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t566 = load i8, i8* %l3
  %t567 = load double, double* %l4
  %t568 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t569 = load double, double* %l6
  %t570 = load double, double* %l7
  %t571 = load %NativeInstruction*, %NativeInstruction** %l8
  %t572 = load i8*, i8** %l17
  %t573 = load i8*, i8** %l18
  %t574 = load i8*, i8** %l19
  %t575 = load %StructLiteralCapture, %StructLiteralCapture* %l20
  %t576 = load double, double* %l21
  br i1 %t562, label %then35, label %else36
then35:
  %t577 = load %StructLiteralCapture, %StructLiteralCapture* %l20
  %t578 = extractvalue %StructLiteralCapture %t577, 0
  store i8* %t578, i8** %l19
  %t579 = load %StructLiteralCapture, %StructLiteralCapture* %l20
  %t580 = extractvalue %StructLiteralCapture %t579, 1
  store double %t580, double* %l21
  br label %merge37
else36:
  %t581 = load i8*, i8** %l19
  %t582 = extractvalue %NativeFunction %function, 4
  %t583 = load double, double* %l7
  %t584 = sitofp i64 1 to double
  %t585 = fadd double %t583, %t584
  %t586 = bitcast { %NativeInstruction**, i64 }* %t582 to { %NativeInstruction*, i64 }*
  %t587 = call %ExpressionContinuationCapture @capture_expression_continuation(i8* %t581, { %NativeInstruction*, i64 }* %t586, double %t585)
  store %ExpressionContinuationCapture %t587, %ExpressionContinuationCapture* %l22
  %t588 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l22
  %t589 = extractvalue %ExpressionContinuationCapture %t588, 2
  %t590 = load %PythonBuilder, %PythonBuilder* %l0
  %t591 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t592 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t593 = load i8, i8* %l3
  %t594 = load double, double* %l4
  %t595 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t596 = load double, double* %l6
  %t597 = load double, double* %l7
  %t598 = load %NativeInstruction*, %NativeInstruction** %l8
  %t599 = load i8*, i8** %l17
  %t600 = load i8*, i8** %l18
  %t601 = load i8*, i8** %l19
  %t602 = load %StructLiteralCapture, %StructLiteralCapture* %l20
  %t603 = load double, double* %l21
  %t604 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l22
  br i1 %t589, label %then38, label %merge39
then38:
  %t605 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l22
  %t606 = extractvalue %ExpressionContinuationCapture %t605, 0
  store i8* %t606, i8** %l19
  %t607 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l22
  %t608 = extractvalue %ExpressionContinuationCapture %t607, 1
  store double %t608, double* %l21
  br label %merge39
merge39:
  %t609 = phi i8* [ %t606, %then38 ], [ %t601, %else36 ]
  %t610 = phi double [ %t608, %then38 ], [ %t603, %else36 ]
  store i8* %t609, i8** %l19
  store double %t610, double* %l21
  br label %merge37
merge37:
  %t611 = phi i8* [ %t578, %then35 ], [ %t606, %else36 ]
  %t612 = phi double [ %t580, %then35 ], [ %t608, %else36 ]
  store i8* %t611, i8** %l19
  store double %t612, double* %l21
  %t613 = load i8*, i8** %l18
  %t614 = load i8*, i8** %l19
  %t615 = call i8* @lower_expression(i8* %t614)
  %t616 = call i8* @sailfin_runtime_string_concat(i8* %t613, i8* %t615)
  store i8* %t616, i8** %l18
  %t617 = load double, double* %l7
  %t618 = load double, double* %l21
  %t619 = fadd double %t617, %t618
  store double %t619, double* %l7
  br label %merge34
else33:
  %t620 = load i8*, i8** %l18
  %s621 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h230766299, i32 0, i32 0
  %t622 = call i8* @sailfin_runtime_string_concat(i8* %t620, i8* %s621)
  store i8* %t622, i8** %l18
  br label %merge34
merge34:
  %t623 = phi i8* [ %t616, %then32 ], [ %t622, %else33 ]
  %t624 = phi double [ %t619, %then32 ], [ %t539, %else33 ]
  store i8* %t623, i8** %l18
  store double %t624, double* %l7
  %t625 = load %PythonBuilder, %PythonBuilder* %l0
  %t626 = load i8*, i8** %l18
  %t627 = call %PythonBuilder @builder_emit(%PythonBuilder %t625, i8* %t626)
  store %PythonBuilder %t627, %PythonBuilder* %l0
  br label %merge31
else30:
  %t628 = load %NativeInstruction*, %NativeInstruction** %l8
  %t629 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t628, i32 0, i32 0
  %t630 = load i32, i32* %t629
  %t631 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t632 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t633 = icmp eq i32 %t630, 0
  %t634 = select i1 %t633, i8* %t632, i8* %t631
  %t635 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t636 = icmp eq i32 %t630, 1
  %t637 = select i1 %t636, i8* %t635, i8* %t634
  %t638 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t639 = icmp eq i32 %t630, 2
  %t640 = select i1 %t639, i8* %t638, i8* %t637
  %t641 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t642 = icmp eq i32 %t630, 3
  %t643 = select i1 %t642, i8* %t641, i8* %t640
  %t644 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t645 = icmp eq i32 %t630, 4
  %t646 = select i1 %t645, i8* %t644, i8* %t643
  %t647 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t648 = icmp eq i32 %t630, 5
  %t649 = select i1 %t648, i8* %t647, i8* %t646
  %t650 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t651 = icmp eq i32 %t630, 6
  %t652 = select i1 %t651, i8* %t650, i8* %t649
  %t653 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t654 = icmp eq i32 %t630, 7
  %t655 = select i1 %t654, i8* %t653, i8* %t652
  %t656 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t657 = icmp eq i32 %t630, 8
  %t658 = select i1 %t657, i8* %t656, i8* %t655
  %t659 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t660 = icmp eq i32 %t630, 9
  %t661 = select i1 %t660, i8* %t659, i8* %t658
  %t662 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t663 = icmp eq i32 %t630, 10
  %t664 = select i1 %t663, i8* %t662, i8* %t661
  %t665 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t666 = icmp eq i32 %t630, 11
  %t667 = select i1 %t666, i8* %t665, i8* %t664
  %t668 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t669 = icmp eq i32 %t630, 12
  %t670 = select i1 %t669, i8* %t668, i8* %t667
  %t671 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t672 = icmp eq i32 %t630, 13
  %t673 = select i1 %t672, i8* %t671, i8* %t670
  %t674 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t675 = icmp eq i32 %t630, 14
  %t676 = select i1 %t675, i8* %t674, i8* %t673
  %t677 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t678 = icmp eq i32 %t630, 15
  %t679 = select i1 %t678, i8* %t677, i8* %t676
  %t680 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t681 = icmp eq i32 %t630, 16
  %t682 = select i1 %t681, i8* %t680, i8* %t679
  %s683 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193459862, i32 0, i32 0
  %t684 = icmp eq i8* %t682, %s683
  %t685 = load %PythonBuilder, %PythonBuilder* %l0
  %t686 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t687 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t688 = load i8, i8* %l3
  %t689 = load double, double* %l4
  %t690 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t691 = load double, double* %l6
  %t692 = load double, double* %l7
  %t693 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t684, label %then40, label %else41
then40:
  %t694 = load %NativeInstruction*, %NativeInstruction** %l8
  %t695 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t694, i32 0, i32 0
  %t696 = load i32, i32* %t695
  %t697 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t694, i32 0, i32 1
  %t698 = bitcast [8 x i8]* %t697 to i8*
  %t699 = bitcast i8* %t698 to i8**
  %t700 = load i8*, i8** %t699
  %t701 = icmp eq i32 %t696, 3
  %t702 = select i1 %t701, i8* %t700, i8* null
  %t703 = call i8* @trim_text(i8* %t702)
  %t704 = call i8* @rewrite_expression_intrinsics(i8* %t703)
  store i8* %t704, i8** %l23
  %t705 = load %PythonBuilder, %PythonBuilder* %l0
  %s706 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2090359129, i32 0, i32 0
  %t707 = load i8*, i8** %l23
  %t708 = call i8* @sailfin_runtime_string_concat(i8* %s706, i8* %t707)
  %t709 = load i8, i8* %t708
  %t710 = add i8 %t709, 58
  %t711 = alloca [2 x i8], align 1
  %t712 = getelementptr [2 x i8], [2 x i8]* %t711, i32 0, i32 0
  store i8 %t710, i8* %t712
  %t713 = getelementptr [2 x i8], [2 x i8]* %t711, i32 0, i32 1
  store i8 0, i8* %t713
  %t714 = getelementptr [2 x i8], [2 x i8]* %t711, i32 0, i32 0
  %t715 = call %PythonBuilder @builder_emit(%PythonBuilder %t705, i8* %t714)
  store %PythonBuilder %t715, %PythonBuilder* %l0
  %t716 = load %PythonBuilder, %PythonBuilder* %l0
  %t717 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t716)
  store %PythonBuilder %t717, %PythonBuilder* %l0
  %t718 = load double, double* %l4
  %t719 = sitofp i64 1 to double
  %t720 = fadd double %t718, %t719
  store double %t720, double* %l4
  br label %merge42
else41:
  %t721 = load %NativeInstruction*, %NativeInstruction** %l8
  %t722 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t721, i32 0, i32 0
  %t723 = load i32, i32* %t722
  %t724 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t725 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t726 = icmp eq i32 %t723, 0
  %t727 = select i1 %t726, i8* %t725, i8* %t724
  %t728 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t729 = icmp eq i32 %t723, 1
  %t730 = select i1 %t729, i8* %t728, i8* %t727
  %t731 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t732 = icmp eq i32 %t723, 2
  %t733 = select i1 %t732, i8* %t731, i8* %t730
  %t734 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t735 = icmp eq i32 %t723, 3
  %t736 = select i1 %t735, i8* %t734, i8* %t733
  %t737 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t738 = icmp eq i32 %t723, 4
  %t739 = select i1 %t738, i8* %t737, i8* %t736
  %t740 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t741 = icmp eq i32 %t723, 5
  %t742 = select i1 %t741, i8* %t740, i8* %t739
  %t743 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t744 = icmp eq i32 %t723, 6
  %t745 = select i1 %t744, i8* %t743, i8* %t742
  %t746 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t747 = icmp eq i32 %t723, 7
  %t748 = select i1 %t747, i8* %t746, i8* %t745
  %t749 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t750 = icmp eq i32 %t723, 8
  %t751 = select i1 %t750, i8* %t749, i8* %t748
  %t752 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t753 = icmp eq i32 %t723, 9
  %t754 = select i1 %t753, i8* %t752, i8* %t751
  %t755 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t756 = icmp eq i32 %t723, 10
  %t757 = select i1 %t756, i8* %t755, i8* %t754
  %t758 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t759 = icmp eq i32 %t723, 11
  %t760 = select i1 %t759, i8* %t758, i8* %t757
  %t761 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t762 = icmp eq i32 %t723, 12
  %t763 = select i1 %t762, i8* %t761, i8* %t760
  %t764 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t765 = icmp eq i32 %t723, 13
  %t766 = select i1 %t765, i8* %t764, i8* %t763
  %t767 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t768 = icmp eq i32 %t723, 14
  %t769 = select i1 %t768, i8* %t767, i8* %t766
  %t770 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t771 = icmp eq i32 %t723, 15
  %t772 = select i1 %t771, i8* %t770, i8* %t769
  %t773 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t774 = icmp eq i32 %t723, 16
  %t775 = select i1 %t774, i8* %t773, i8* %t772
  %s776 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h219990644, i32 0, i32 0
  %t777 = icmp eq i8* %t775, %s776
  %t778 = load %PythonBuilder, %PythonBuilder* %l0
  %t779 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t780 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t781 = load i8, i8* %l3
  %t782 = load double, double* %l4
  %t783 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t784 = load double, double* %l6
  %t785 = load double, double* %l7
  %t786 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t777, label %then43, label %else44
then43:
  %t787 = load double, double* %l4
  %t788 = sitofp i64 0 to double
  %t789 = fcmp ogt double %t787, %t788
  %t790 = load %PythonBuilder, %PythonBuilder* %l0
  %t791 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t792 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t793 = load i8, i8* %l3
  %t794 = load double, double* %l4
  %t795 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t796 = load double, double* %l6
  %t797 = load double, double* %l7
  %t798 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t789, label %then46, label %else47
then46:
  %t799 = load %PythonBuilder, %PythonBuilder* %l0
  %t800 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t799)
  store %PythonBuilder %t800, %PythonBuilder* %l0
  br label %merge48
else47:
  %t801 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t802 = extractvalue %NativeFunction %function, 0
  %s803 = getelementptr inbounds [25 x i8], [25 x i8]* @.str.len24.h2028465620, i32 0, i32 0
  %t804 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t801, i8* %t802, i8* %s803)
  store { i8**, i64 }* %t804, { i8**, i64 }** %l1
  br label %merge48
merge48:
  %t805 = phi %PythonBuilder [ %t800, %then46 ], [ %t790, %else47 ]
  %t806 = phi { i8**, i64 }* [ %t791, %then46 ], [ %t804, %else47 ]
  store %PythonBuilder %t805, %PythonBuilder* %l0
  store { i8**, i64 }* %t806, { i8**, i64 }** %l1
  %t807 = load %PythonBuilder, %PythonBuilder* %l0
  %s808 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2069574674, i32 0, i32 0
  %t809 = call %PythonBuilder @builder_emit(%PythonBuilder %t807, i8* %s808)
  store %PythonBuilder %t809, %PythonBuilder* %l0
  %t810 = load %PythonBuilder, %PythonBuilder* %l0
  %t811 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t810)
  store %PythonBuilder %t811, %PythonBuilder* %l0
  br label %merge45
else44:
  %t812 = load %NativeInstruction*, %NativeInstruction** %l8
  %t813 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t812, i32 0, i32 0
  %t814 = load i32, i32* %t813
  %t815 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t816 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t817 = icmp eq i32 %t814, 0
  %t818 = select i1 %t817, i8* %t816, i8* %t815
  %t819 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t820 = icmp eq i32 %t814, 1
  %t821 = select i1 %t820, i8* %t819, i8* %t818
  %t822 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t823 = icmp eq i32 %t814, 2
  %t824 = select i1 %t823, i8* %t822, i8* %t821
  %t825 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t826 = icmp eq i32 %t814, 3
  %t827 = select i1 %t826, i8* %t825, i8* %t824
  %t828 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t829 = icmp eq i32 %t814, 4
  %t830 = select i1 %t829, i8* %t828, i8* %t827
  %t831 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t832 = icmp eq i32 %t814, 5
  %t833 = select i1 %t832, i8* %t831, i8* %t830
  %t834 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t835 = icmp eq i32 %t814, 6
  %t836 = select i1 %t835, i8* %t834, i8* %t833
  %t837 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t838 = icmp eq i32 %t814, 7
  %t839 = select i1 %t838, i8* %t837, i8* %t836
  %t840 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t841 = icmp eq i32 %t814, 8
  %t842 = select i1 %t841, i8* %t840, i8* %t839
  %t843 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t844 = icmp eq i32 %t814, 9
  %t845 = select i1 %t844, i8* %t843, i8* %t842
  %t846 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t847 = icmp eq i32 %t814, 10
  %t848 = select i1 %t847, i8* %t846, i8* %t845
  %t849 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t850 = icmp eq i32 %t814, 11
  %t851 = select i1 %t850, i8* %t849, i8* %t848
  %t852 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t853 = icmp eq i32 %t814, 12
  %t854 = select i1 %t853, i8* %t852, i8* %t851
  %t855 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t856 = icmp eq i32 %t814, 13
  %t857 = select i1 %t856, i8* %t855, i8* %t854
  %t858 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t859 = icmp eq i32 %t814, 14
  %t860 = select i1 %t859, i8* %t858, i8* %t857
  %t861 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t862 = icmp eq i32 %t814, 15
  %t863 = select i1 %t862, i8* %t861, i8* %t860
  %t864 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t865 = icmp eq i32 %t814, 16
  %t866 = select i1 %t865, i8* %t864, i8* %t863
  %s867 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h819045845, i32 0, i32 0
  %t868 = icmp eq i8* %t866, %s867
  %t869 = load %PythonBuilder, %PythonBuilder* %l0
  %t870 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t871 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t872 = load i8, i8* %l3
  %t873 = load double, double* %l4
  %t874 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t875 = load double, double* %l6
  %t876 = load double, double* %l7
  %t877 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t868, label %then49, label %else50
then49:
  %t878 = load double, double* %l4
  %t879 = sitofp i64 0 to double
  %t880 = fcmp ogt double %t878, %t879
  %t881 = load %PythonBuilder, %PythonBuilder* %l0
  %t882 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t883 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t884 = load i8, i8* %l3
  %t885 = load double, double* %l4
  %t886 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t887 = load double, double* %l6
  %t888 = load double, double* %l7
  %t889 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t880, label %then52, label %else53
then52:
  %t890 = load %PythonBuilder, %PythonBuilder* %l0
  %t891 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t890)
  store %PythonBuilder %t891, %PythonBuilder* %l0
  %t892 = load double, double* %l4
  %t893 = sitofp i64 1 to double
  %t894 = fsub double %t892, %t893
  store double %t894, double* %l4
  br label %merge54
else53:
  %t895 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t896 = extractvalue %NativeFunction %function, 0
  %s897 = getelementptr inbounds [26 x i8], [26 x i8]* @.str.len25.h458257002, i32 0, i32 0
  %t898 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t895, i8* %t896, i8* %s897)
  store { i8**, i64 }* %t898, { i8**, i64 }** %l1
  br label %merge54
merge54:
  %t899 = phi %PythonBuilder [ %t891, %then52 ], [ %t881, %else53 ]
  %t900 = phi double [ %t894, %then52 ], [ %t885, %else53 ]
  %t901 = phi { i8**, i64 }* [ %t882, %then52 ], [ %t898, %else53 ]
  store %PythonBuilder %t899, %PythonBuilder* %l0
  store double %t900, double* %l4
  store { i8**, i64 }* %t901, { i8**, i64 }** %l1
  br label %merge51
else50:
  %t902 = load %NativeInstruction*, %NativeInstruction** %l8
  %t903 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t902, i32 0, i32 0
  %t904 = load i32, i32* %t903
  %t905 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t906 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t907 = icmp eq i32 %t904, 0
  %t908 = select i1 %t907, i8* %t906, i8* %t905
  %t909 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t910 = icmp eq i32 %t904, 1
  %t911 = select i1 %t910, i8* %t909, i8* %t908
  %t912 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t913 = icmp eq i32 %t904, 2
  %t914 = select i1 %t913, i8* %t912, i8* %t911
  %t915 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t916 = icmp eq i32 %t904, 3
  %t917 = select i1 %t916, i8* %t915, i8* %t914
  %t918 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t919 = icmp eq i32 %t904, 4
  %t920 = select i1 %t919, i8* %t918, i8* %t917
  %t921 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t922 = icmp eq i32 %t904, 5
  %t923 = select i1 %t922, i8* %t921, i8* %t920
  %t924 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t925 = icmp eq i32 %t904, 6
  %t926 = select i1 %t925, i8* %t924, i8* %t923
  %t927 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t928 = icmp eq i32 %t904, 7
  %t929 = select i1 %t928, i8* %t927, i8* %t926
  %t930 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t931 = icmp eq i32 %t904, 8
  %t932 = select i1 %t931, i8* %t930, i8* %t929
  %t933 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t934 = icmp eq i32 %t904, 9
  %t935 = select i1 %t934, i8* %t933, i8* %t932
  %t936 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t937 = icmp eq i32 %t904, 10
  %t938 = select i1 %t937, i8* %t936, i8* %t935
  %t939 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t940 = icmp eq i32 %t904, 11
  %t941 = select i1 %t940, i8* %t939, i8* %t938
  %t942 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t943 = icmp eq i32 %t904, 12
  %t944 = select i1 %t943, i8* %t942, i8* %t941
  %t945 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t946 = icmp eq i32 %t904, 13
  %t947 = select i1 %t946, i8* %t945, i8* %t944
  %t948 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t949 = icmp eq i32 %t904, 14
  %t950 = select i1 %t949, i8* %t948, i8* %t947
  %t951 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t952 = icmp eq i32 %t904, 15
  %t953 = select i1 %t952, i8* %t951, i8* %t950
  %t954 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t955 = icmp eq i32 %t904, 16
  %t956 = select i1 %t955, i8* %t954, i8* %t953
  %s957 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2089113841, i32 0, i32 0
  %t958 = icmp eq i8* %t956, %s957
  %t959 = load %PythonBuilder, %PythonBuilder* %l0
  %t960 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t961 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t962 = load i8, i8* %l3
  %t963 = load double, double* %l4
  %t964 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t965 = load double, double* %l6
  %t966 = load double, double* %l7
  %t967 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t958, label %then55, label %else56
then55:
  %t968 = load %NativeInstruction*, %NativeInstruction** %l8
  %t969 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t968, i32 0, i32 0
  %t970 = load i32, i32* %t969
  %t971 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t968, i32 0, i32 1
  %t972 = bitcast [16 x i8]* %t971 to i8*
  %t973 = getelementptr inbounds i8, i8* %t972, i64 8
  %t974 = bitcast i8* %t973 to i8**
  %t975 = load i8*, i8** %t974
  %t976 = icmp eq i32 %t970, 6
  %t977 = select i1 %t976, i8* %t975, i8* null
  %t978 = call i8* @trim_text(i8* %t977)
  %t979 = call i8* @rewrite_expression_intrinsics(i8* %t978)
  store i8* %t979, i8** %l24
  %t980 = load %PythonBuilder, %PythonBuilder* %l0
  %s981 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h259230482, i32 0, i32 0
  %t982 = load %NativeInstruction*, %NativeInstruction** %l8
  %t983 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t982, i32 0, i32 0
  %t984 = load i32, i32* %t983
  %t985 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t982, i32 0, i32 1
  %t986 = bitcast [16 x i8]* %t985 to i8*
  %t987 = bitcast i8* %t986 to i8**
  %t988 = load i8*, i8** %t987
  %t989 = icmp eq i32 %t984, 6
  %t990 = select i1 %t989, i8* %t988, i8* null
  %t991 = call i8* @sailfin_runtime_string_concat(i8* %s981, i8* %t990)
  %s992 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h175996034, i32 0, i32 0
  %t993 = call i8* @sailfin_runtime_string_concat(i8* %t991, i8* %s992)
  %t994 = load i8*, i8** %l24
  %t995 = call i8* @sailfin_runtime_string_concat(i8* %t993, i8* %t994)
  %t996 = load i8, i8* %t995
  %t997 = add i8 %t996, 58
  %t998 = alloca [2 x i8], align 1
  %t999 = getelementptr [2 x i8], [2 x i8]* %t998, i32 0, i32 0
  store i8 %t997, i8* %t999
  %t1000 = getelementptr [2 x i8], [2 x i8]* %t998, i32 0, i32 1
  store i8 0, i8* %t1000
  %t1001 = getelementptr [2 x i8], [2 x i8]* %t998, i32 0, i32 0
  %t1002 = call %PythonBuilder @builder_emit(%PythonBuilder %t980, i8* %t1001)
  store %PythonBuilder %t1002, %PythonBuilder* %l0
  %t1003 = load %PythonBuilder, %PythonBuilder* %l0
  %t1004 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t1003)
  store %PythonBuilder %t1004, %PythonBuilder* %l0
  %t1005 = load double, double* %l4
  %t1006 = sitofp i64 1 to double
  %t1007 = fadd double %t1005, %t1006
  store double %t1007, double* %l4
  br label %merge57
else56:
  %t1008 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1009 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1008, i32 0, i32 0
  %t1010 = load i32, i32* %t1009
  %t1011 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1012 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1013 = icmp eq i32 %t1010, 0
  %t1014 = select i1 %t1013, i8* %t1012, i8* %t1011
  %t1015 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1016 = icmp eq i32 %t1010, 1
  %t1017 = select i1 %t1016, i8* %t1015, i8* %t1014
  %t1018 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1019 = icmp eq i32 %t1010, 2
  %t1020 = select i1 %t1019, i8* %t1018, i8* %t1017
  %t1021 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1022 = icmp eq i32 %t1010, 3
  %t1023 = select i1 %t1022, i8* %t1021, i8* %t1020
  %t1024 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1025 = icmp eq i32 %t1010, 4
  %t1026 = select i1 %t1025, i8* %t1024, i8* %t1023
  %t1027 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1028 = icmp eq i32 %t1010, 5
  %t1029 = select i1 %t1028, i8* %t1027, i8* %t1026
  %t1030 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1031 = icmp eq i32 %t1010, 6
  %t1032 = select i1 %t1031, i8* %t1030, i8* %t1029
  %t1033 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1034 = icmp eq i32 %t1010, 7
  %t1035 = select i1 %t1034, i8* %t1033, i8* %t1032
  %t1036 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1037 = icmp eq i32 %t1010, 8
  %t1038 = select i1 %t1037, i8* %t1036, i8* %t1035
  %t1039 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1040 = icmp eq i32 %t1010, 9
  %t1041 = select i1 %t1040, i8* %t1039, i8* %t1038
  %t1042 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1043 = icmp eq i32 %t1010, 10
  %t1044 = select i1 %t1043, i8* %t1042, i8* %t1041
  %t1045 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1046 = icmp eq i32 %t1010, 11
  %t1047 = select i1 %t1046, i8* %t1045, i8* %t1044
  %t1048 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1049 = icmp eq i32 %t1010, 12
  %t1050 = select i1 %t1049, i8* %t1048, i8* %t1047
  %t1051 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1052 = icmp eq i32 %t1010, 13
  %t1053 = select i1 %t1052, i8* %t1051, i8* %t1050
  %t1054 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1055 = icmp eq i32 %t1010, 14
  %t1056 = select i1 %t1055, i8* %t1054, i8* %t1053
  %t1057 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1058 = icmp eq i32 %t1010, 15
  %t1059 = select i1 %t1058, i8* %t1057, i8* %t1056
  %t1060 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1061 = icmp eq i32 %t1010, 16
  %t1062 = select i1 %t1061, i8* %t1060, i8* %t1059
  %s1063 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1258614714, i32 0, i32 0
  %t1064 = icmp eq i8* %t1062, %s1063
  %t1065 = load %PythonBuilder, %PythonBuilder* %l0
  %t1066 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1067 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1068 = load i8, i8* %l3
  %t1069 = load double, double* %l4
  %t1070 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1071 = load double, double* %l6
  %t1072 = load double, double* %l7
  %t1073 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1064, label %then58, label %else59
then58:
  %t1074 = load double, double* %l4
  %t1075 = sitofp i64 0 to double
  %t1076 = fcmp ogt double %t1074, %t1075
  %t1077 = load %PythonBuilder, %PythonBuilder* %l0
  %t1078 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1079 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1080 = load i8, i8* %l3
  %t1081 = load double, double* %l4
  %t1082 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1083 = load double, double* %l6
  %t1084 = load double, double* %l7
  %t1085 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1076, label %then61, label %else62
then61:
  %t1086 = load %PythonBuilder, %PythonBuilder* %l0
  %t1087 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t1086)
  store %PythonBuilder %t1087, %PythonBuilder* %l0
  %t1088 = load double, double* %l4
  %t1089 = sitofp i64 1 to double
  %t1090 = fsub double %t1088, %t1089
  store double %t1090, double* %l4
  br label %merge63
else62:
  %t1091 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1092 = extractvalue %NativeFunction %function, 0
  %s1093 = getelementptr inbounds [33 x i8], [33 x i8]* @.str.len32.h1370567591, i32 0, i32 0
  %t1094 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t1091, i8* %t1092, i8* %s1093)
  store { i8**, i64 }* %t1094, { i8**, i64 }** %l1
  br label %merge63
merge63:
  %t1095 = phi %PythonBuilder [ %t1087, %then61 ], [ %t1077, %else62 ]
  %t1096 = phi double [ %t1090, %then61 ], [ %t1081, %else62 ]
  %t1097 = phi { i8**, i64 }* [ %t1078, %then61 ], [ %t1094, %else62 ]
  store %PythonBuilder %t1095, %PythonBuilder* %l0
  store double %t1096, double* %l4
  store { i8**, i64 }* %t1097, { i8**, i64 }** %l1
  br label %merge60
else59:
  %t1098 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1099 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1098, i32 0, i32 0
  %t1100 = load i32, i32* %t1099
  %t1101 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1102 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1103 = icmp eq i32 %t1100, 0
  %t1104 = select i1 %t1103, i8* %t1102, i8* %t1101
  %t1105 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1106 = icmp eq i32 %t1100, 1
  %t1107 = select i1 %t1106, i8* %t1105, i8* %t1104
  %t1108 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1109 = icmp eq i32 %t1100, 2
  %t1110 = select i1 %t1109, i8* %t1108, i8* %t1107
  %t1111 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1112 = icmp eq i32 %t1100, 3
  %t1113 = select i1 %t1112, i8* %t1111, i8* %t1110
  %t1114 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1115 = icmp eq i32 %t1100, 4
  %t1116 = select i1 %t1115, i8* %t1114, i8* %t1113
  %t1117 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1118 = icmp eq i32 %t1100, 5
  %t1119 = select i1 %t1118, i8* %t1117, i8* %t1116
  %t1120 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1121 = icmp eq i32 %t1100, 6
  %t1122 = select i1 %t1121, i8* %t1120, i8* %t1119
  %t1123 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1124 = icmp eq i32 %t1100, 7
  %t1125 = select i1 %t1124, i8* %t1123, i8* %t1122
  %t1126 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1127 = icmp eq i32 %t1100, 8
  %t1128 = select i1 %t1127, i8* %t1126, i8* %t1125
  %t1129 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1130 = icmp eq i32 %t1100, 9
  %t1131 = select i1 %t1130, i8* %t1129, i8* %t1128
  %t1132 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1133 = icmp eq i32 %t1100, 10
  %t1134 = select i1 %t1133, i8* %t1132, i8* %t1131
  %t1135 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1136 = icmp eq i32 %t1100, 11
  %t1137 = select i1 %t1136, i8* %t1135, i8* %t1134
  %t1138 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1139 = icmp eq i32 %t1100, 12
  %t1140 = select i1 %t1139, i8* %t1138, i8* %t1137
  %t1141 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1142 = icmp eq i32 %t1100, 13
  %t1143 = select i1 %t1142, i8* %t1141, i8* %t1140
  %t1144 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1145 = icmp eq i32 %t1100, 14
  %t1146 = select i1 %t1145, i8* %t1144, i8* %t1143
  %t1147 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1148 = icmp eq i32 %t1100, 15
  %t1149 = select i1 %t1148, i8* %t1147, i8* %t1146
  %t1150 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1151 = icmp eq i32 %t1100, 16
  %t1152 = select i1 %t1151, i8* %t1150, i8* %t1149
  %s1153 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h228395909, i32 0, i32 0
  %t1154 = icmp eq i8* %t1152, %s1153
  %t1155 = load %PythonBuilder, %PythonBuilder* %l0
  %t1156 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1157 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1158 = load i8, i8* %l3
  %t1159 = load double, double* %l4
  %t1160 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1161 = load double, double* %l6
  %t1162 = load double, double* %l7
  %t1163 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1154, label %then64, label %else65
then64:
  %t1164 = load %PythonBuilder, %PythonBuilder* %l0
  %s1165 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1898426375, i32 0, i32 0
  %t1166 = call %PythonBuilder @builder_emit(%PythonBuilder %t1164, i8* %s1165)
  store %PythonBuilder %t1166, %PythonBuilder* %l0
  %t1167 = load %PythonBuilder, %PythonBuilder* %l0
  %t1168 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t1167)
  store %PythonBuilder %t1168, %PythonBuilder* %l0
  %t1169 = load double, double* %l4
  %t1170 = sitofp i64 1 to double
  %t1171 = fadd double %t1169, %t1170
  store double %t1171, double* %l4
  br label %merge66
else65:
  %t1172 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1173 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1172, i32 0, i32 0
  %t1174 = load i32, i32* %t1173
  %t1175 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1176 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1177 = icmp eq i32 %t1174, 0
  %t1178 = select i1 %t1177, i8* %t1176, i8* %t1175
  %t1179 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1180 = icmp eq i32 %t1174, 1
  %t1181 = select i1 %t1180, i8* %t1179, i8* %t1178
  %t1182 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1183 = icmp eq i32 %t1174, 2
  %t1184 = select i1 %t1183, i8* %t1182, i8* %t1181
  %t1185 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1186 = icmp eq i32 %t1174, 3
  %t1187 = select i1 %t1186, i8* %t1185, i8* %t1184
  %t1188 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1189 = icmp eq i32 %t1174, 4
  %t1190 = select i1 %t1189, i8* %t1188, i8* %t1187
  %t1191 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1192 = icmp eq i32 %t1174, 5
  %t1193 = select i1 %t1192, i8* %t1191, i8* %t1190
  %t1194 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1195 = icmp eq i32 %t1174, 6
  %t1196 = select i1 %t1195, i8* %t1194, i8* %t1193
  %t1197 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1198 = icmp eq i32 %t1174, 7
  %t1199 = select i1 %t1198, i8* %t1197, i8* %t1196
  %t1200 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1201 = icmp eq i32 %t1174, 8
  %t1202 = select i1 %t1201, i8* %t1200, i8* %t1199
  %t1203 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1204 = icmp eq i32 %t1174, 9
  %t1205 = select i1 %t1204, i8* %t1203, i8* %t1202
  %t1206 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1207 = icmp eq i32 %t1174, 10
  %t1208 = select i1 %t1207, i8* %t1206, i8* %t1205
  %t1209 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1210 = icmp eq i32 %t1174, 11
  %t1211 = select i1 %t1210, i8* %t1209, i8* %t1208
  %t1212 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1213 = icmp eq i32 %t1174, 12
  %t1214 = select i1 %t1213, i8* %t1212, i8* %t1211
  %t1215 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1216 = icmp eq i32 %t1174, 13
  %t1217 = select i1 %t1216, i8* %t1215, i8* %t1214
  %t1218 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1219 = icmp eq i32 %t1174, 14
  %t1220 = select i1 %t1219, i8* %t1218, i8* %t1217
  %t1221 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1222 = icmp eq i32 %t1174, 15
  %t1223 = select i1 %t1222, i8* %t1221, i8* %t1220
  %t1224 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1225 = icmp eq i32 %t1174, 16
  %t1226 = select i1 %t1225, i8* %t1224, i8* %t1223
  %s1227 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h739212033, i32 0, i32 0
  %t1228 = icmp eq i8* %t1226, %s1227
  %t1229 = load %PythonBuilder, %PythonBuilder* %l0
  %t1230 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1231 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1232 = load i8, i8* %l3
  %t1233 = load double, double* %l4
  %t1234 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1235 = load double, double* %l6
  %t1236 = load double, double* %l7
  %t1237 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1228, label %then67, label %else68
then67:
  %t1238 = load double, double* %l4
  %t1239 = sitofp i64 0 to double
  %t1240 = fcmp ogt double %t1238, %t1239
  %t1241 = load %PythonBuilder, %PythonBuilder* %l0
  %t1242 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1243 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1244 = load i8, i8* %l3
  %t1245 = load double, double* %l4
  %t1246 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1247 = load double, double* %l6
  %t1248 = load double, double* %l7
  %t1249 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1240, label %then70, label %else71
then70:
  %t1250 = load %PythonBuilder, %PythonBuilder* %l0
  %t1251 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t1250)
  store %PythonBuilder %t1251, %PythonBuilder* %l0
  %t1252 = load double, double* %l4
  %t1253 = sitofp i64 1 to double
  %t1254 = fsub double %t1252, %t1253
  store double %t1254, double* %l4
  br label %merge72
else71:
  %t1255 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1256 = extractvalue %NativeFunction %function, 0
  %s1257 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.len29.h1122035900, i32 0, i32 0
  %t1258 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t1255, i8* %t1256, i8* %s1257)
  store { i8**, i64 }* %t1258, { i8**, i64 }** %l1
  br label %merge72
merge72:
  %t1259 = phi %PythonBuilder [ %t1251, %then70 ], [ %t1241, %else71 ]
  %t1260 = phi double [ %t1254, %then70 ], [ %t1245, %else71 ]
  %t1261 = phi { i8**, i64 }* [ %t1242, %then70 ], [ %t1258, %else71 ]
  store %PythonBuilder %t1259, %PythonBuilder* %l0
  store double %t1260, double* %l4
  store { i8**, i64 }* %t1261, { i8**, i64 }** %l1
  br label %merge69
else68:
  %t1262 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1263 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1262, i32 0, i32 0
  %t1264 = load i32, i32* %t1263
  %t1265 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1266 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1267 = icmp eq i32 %t1264, 0
  %t1268 = select i1 %t1267, i8* %t1266, i8* %t1265
  %t1269 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1270 = icmp eq i32 %t1264, 1
  %t1271 = select i1 %t1270, i8* %t1269, i8* %t1268
  %t1272 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1273 = icmp eq i32 %t1264, 2
  %t1274 = select i1 %t1273, i8* %t1272, i8* %t1271
  %t1275 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1276 = icmp eq i32 %t1264, 3
  %t1277 = select i1 %t1276, i8* %t1275, i8* %t1274
  %t1278 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1279 = icmp eq i32 %t1264, 4
  %t1280 = select i1 %t1279, i8* %t1278, i8* %t1277
  %t1281 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1282 = icmp eq i32 %t1264, 5
  %t1283 = select i1 %t1282, i8* %t1281, i8* %t1280
  %t1284 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1285 = icmp eq i32 %t1264, 6
  %t1286 = select i1 %t1285, i8* %t1284, i8* %t1283
  %t1287 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1288 = icmp eq i32 %t1264, 7
  %t1289 = select i1 %t1288, i8* %t1287, i8* %t1286
  %t1290 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1291 = icmp eq i32 %t1264, 8
  %t1292 = select i1 %t1291, i8* %t1290, i8* %t1289
  %t1293 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1294 = icmp eq i32 %t1264, 9
  %t1295 = select i1 %t1294, i8* %t1293, i8* %t1292
  %t1296 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1297 = icmp eq i32 %t1264, 10
  %t1298 = select i1 %t1297, i8* %t1296, i8* %t1295
  %t1299 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1300 = icmp eq i32 %t1264, 11
  %t1301 = select i1 %t1300, i8* %t1299, i8* %t1298
  %t1302 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1303 = icmp eq i32 %t1264, 12
  %t1304 = select i1 %t1303, i8* %t1302, i8* %t1301
  %t1305 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1306 = icmp eq i32 %t1264, 13
  %t1307 = select i1 %t1306, i8* %t1305, i8* %t1304
  %t1308 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1309 = icmp eq i32 %t1264, 14
  %t1310 = select i1 %t1309, i8* %t1308, i8* %t1307
  %t1311 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1312 = icmp eq i32 %t1264, 15
  %t1313 = select i1 %t1312, i8* %t1311, i8* %t1310
  %t1314 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1315 = icmp eq i32 %t1264, 16
  %t1316 = select i1 %t1315, i8* %t1314, i8* %t1313
  %s1317 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h706445588, i32 0, i32 0
  %t1318 = icmp eq i8* %t1316, %s1317
  %t1319 = load %PythonBuilder, %PythonBuilder* %l0
  %t1320 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1321 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1322 = load i8, i8* %l3
  %t1323 = load double, double* %l4
  %t1324 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1325 = load double, double* %l6
  %t1326 = load double, double* %l7
  %t1327 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1318, label %then73, label %else74
then73:
  %t1328 = load %PythonBuilder, %PythonBuilder* %l0
  %s1329 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1958778164, i32 0, i32 0
  %t1330 = call %PythonBuilder @builder_emit(%PythonBuilder %t1328, i8* %s1329)
  store %PythonBuilder %t1330, %PythonBuilder* %l0
  br label %merge75
else74:
  %t1331 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1332 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1331, i32 0, i32 0
  %t1333 = load i32, i32* %t1332
  %t1334 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1335 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1336 = icmp eq i32 %t1333, 0
  %t1337 = select i1 %t1336, i8* %t1335, i8* %t1334
  %t1338 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1339 = icmp eq i32 %t1333, 1
  %t1340 = select i1 %t1339, i8* %t1338, i8* %t1337
  %t1341 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1342 = icmp eq i32 %t1333, 2
  %t1343 = select i1 %t1342, i8* %t1341, i8* %t1340
  %t1344 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1345 = icmp eq i32 %t1333, 3
  %t1346 = select i1 %t1345, i8* %t1344, i8* %t1343
  %t1347 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1348 = icmp eq i32 %t1333, 4
  %t1349 = select i1 %t1348, i8* %t1347, i8* %t1346
  %t1350 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1351 = icmp eq i32 %t1333, 5
  %t1352 = select i1 %t1351, i8* %t1350, i8* %t1349
  %t1353 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1354 = icmp eq i32 %t1333, 6
  %t1355 = select i1 %t1354, i8* %t1353, i8* %t1352
  %t1356 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1357 = icmp eq i32 %t1333, 7
  %t1358 = select i1 %t1357, i8* %t1356, i8* %t1355
  %t1359 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1360 = icmp eq i32 %t1333, 8
  %t1361 = select i1 %t1360, i8* %t1359, i8* %t1358
  %t1362 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1363 = icmp eq i32 %t1333, 9
  %t1364 = select i1 %t1363, i8* %t1362, i8* %t1361
  %t1365 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1366 = icmp eq i32 %t1333, 10
  %t1367 = select i1 %t1366, i8* %t1365, i8* %t1364
  %t1368 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1369 = icmp eq i32 %t1333, 11
  %t1370 = select i1 %t1369, i8* %t1368, i8* %t1367
  %t1371 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1372 = icmp eq i32 %t1333, 12
  %t1373 = select i1 %t1372, i8* %t1371, i8* %t1370
  %t1374 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1375 = icmp eq i32 %t1333, 13
  %t1376 = select i1 %t1375, i8* %t1374, i8* %t1373
  %t1377 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1378 = icmp eq i32 %t1333, 14
  %t1379 = select i1 %t1378, i8* %t1377, i8* %t1376
  %t1380 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1381 = icmp eq i32 %t1333, 15
  %t1382 = select i1 %t1381, i8* %t1380, i8* %t1379
  %t1383 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1384 = icmp eq i32 %t1333, 16
  %t1385 = select i1 %t1384, i8* %t1383, i8* %t1382
  %s1386 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h267355070, i32 0, i32 0
  %t1387 = icmp eq i8* %t1385, %s1386
  %t1388 = load %PythonBuilder, %PythonBuilder* %l0
  %t1389 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1390 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1391 = load i8, i8* %l3
  %t1392 = load double, double* %l4
  %t1393 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1394 = load double, double* %l6
  %t1395 = load double, double* %l7
  %t1396 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1387, label %then76, label %else77
then76:
  %t1397 = load %PythonBuilder, %PythonBuilder* %l0
  %s1398 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h528348603, i32 0, i32 0
  %t1399 = call %PythonBuilder @builder_emit(%PythonBuilder %t1397, i8* %s1398)
  store %PythonBuilder %t1399, %PythonBuilder* %l0
  br label %merge78
else77:
  %t1400 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1401 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1400, i32 0, i32 0
  %t1402 = load i32, i32* %t1401
  %t1403 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1404 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1405 = icmp eq i32 %t1402, 0
  %t1406 = select i1 %t1405, i8* %t1404, i8* %t1403
  %t1407 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1408 = icmp eq i32 %t1402, 1
  %t1409 = select i1 %t1408, i8* %t1407, i8* %t1406
  %t1410 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1411 = icmp eq i32 %t1402, 2
  %t1412 = select i1 %t1411, i8* %t1410, i8* %t1409
  %t1413 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1414 = icmp eq i32 %t1402, 3
  %t1415 = select i1 %t1414, i8* %t1413, i8* %t1412
  %t1416 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1417 = icmp eq i32 %t1402, 4
  %t1418 = select i1 %t1417, i8* %t1416, i8* %t1415
  %t1419 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1420 = icmp eq i32 %t1402, 5
  %t1421 = select i1 %t1420, i8* %t1419, i8* %t1418
  %t1422 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1423 = icmp eq i32 %t1402, 6
  %t1424 = select i1 %t1423, i8* %t1422, i8* %t1421
  %t1425 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1426 = icmp eq i32 %t1402, 7
  %t1427 = select i1 %t1426, i8* %t1425, i8* %t1424
  %t1428 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1429 = icmp eq i32 %t1402, 8
  %t1430 = select i1 %t1429, i8* %t1428, i8* %t1427
  %t1431 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1432 = icmp eq i32 %t1402, 9
  %t1433 = select i1 %t1432, i8* %t1431, i8* %t1430
  %t1434 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1435 = icmp eq i32 %t1402, 10
  %t1436 = select i1 %t1435, i8* %t1434, i8* %t1433
  %t1437 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1438 = icmp eq i32 %t1402, 11
  %t1439 = select i1 %t1438, i8* %t1437, i8* %t1436
  %t1440 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1441 = icmp eq i32 %t1402, 12
  %t1442 = select i1 %t1441, i8* %t1440, i8* %t1439
  %t1443 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1444 = icmp eq i32 %t1402, 13
  %t1445 = select i1 %t1444, i8* %t1443, i8* %t1442
  %t1446 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1447 = icmp eq i32 %t1402, 14
  %t1448 = select i1 %t1447, i8* %t1446, i8* %t1445
  %t1449 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1450 = icmp eq i32 %t1402, 15
  %t1451 = select i1 %t1450, i8* %t1449, i8* %t1448
  %t1452 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1453 = icmp eq i32 %t1402, 16
  %t1454 = select i1 %t1453, i8* %t1452, i8* %t1451
  %s1455 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1117315388, i32 0, i32 0
  %t1456 = icmp eq i8* %t1454, %s1455
  %t1457 = load %PythonBuilder, %PythonBuilder* %l0
  %t1458 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1459 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1460 = load i8, i8* %l3
  %t1461 = load double, double* %l4
  %t1462 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1463 = load double, double* %l6
  %t1464 = load double, double* %l7
  %t1465 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1456, label %then79, label %else80
then79:
  %t1466 = load double, double* %l6
  %t1467 = call i8* @generate_match_subject_name(double %t1466)
  store i8* %t1467, i8** %l25
  %t1468 = load double, double* %l6
  %t1469 = sitofp i64 1 to double
  %t1470 = fadd double %t1468, %t1469
  store double %t1470, double* %l6
  %t1471 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1472 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1471, i32 0, i32 0
  %t1473 = load i32, i32* %t1472
  %t1474 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1471, i32 0, i32 1
  %t1475 = bitcast [16 x i8]* %t1474 to i8*
  %t1476 = bitcast i8* %t1475 to i8**
  %t1477 = load i8*, i8** %t1476
  %t1478 = icmp eq i32 %t1473, 0
  %t1479 = select i1 %t1478, i8* %t1477, i8* null
  %t1480 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1471, i32 0, i32 1
  %t1481 = bitcast [16 x i8]* %t1480 to i8*
  %t1482 = bitcast i8* %t1481 to i8**
  %t1483 = load i8*, i8** %t1482
  %t1484 = icmp eq i32 %t1473, 1
  %t1485 = select i1 %t1484, i8* %t1483, i8* %t1479
  %t1486 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1471, i32 0, i32 1
  %t1487 = bitcast [8 x i8]* %t1486 to i8*
  %t1488 = bitcast i8* %t1487 to i8**
  %t1489 = load i8*, i8** %t1488
  %t1490 = icmp eq i32 %t1473, 12
  %t1491 = select i1 %t1490, i8* %t1489, i8* %t1485
  %t1492 = call i8* @lower_expression(i8* %t1491)
  store i8* %t1492, i8** %l26
  %t1493 = load %PythonBuilder, %PythonBuilder* %l0
  %t1494 = load i8*, i8** %l25
  %s1495 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087691079, i32 0, i32 0
  %t1496 = call i8* @sailfin_runtime_string_concat(i8* %t1494, i8* %s1495)
  %t1497 = load i8*, i8** %l26
  %t1498 = call i8* @sailfin_runtime_string_concat(i8* %t1496, i8* %t1497)
  %t1499 = call %PythonBuilder @builder_emit(%PythonBuilder %t1493, i8* %t1498)
  store %PythonBuilder %t1499, %PythonBuilder* %l0
  %t1500 = load i8*, i8** %l25
  %t1501 = insertvalue %MatchContext undef, i8* %t1500, 0
  %t1502 = sitofp i64 0 to double
  %t1503 = insertvalue %MatchContext %t1501, double %t1502, 1
  %t1504 = insertvalue %MatchContext %t1503, i1 0, 2
  store %MatchContext %t1504, %MatchContext* %l27
  %t1505 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1506 = load %MatchContext, %MatchContext* %l27
  %t1507 = call { %MatchContext*, i64 }* @append_match_context({ %MatchContext*, i64 }* %t1505, %MatchContext %t1506)
  store { %MatchContext*, i64 }* %t1507, { %MatchContext*, i64 }** %l5
  br label %merge81
else80:
  %t1508 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1509 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1508, i32 0, i32 0
  %t1510 = load i32, i32* %t1509
  %t1511 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1512 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1513 = icmp eq i32 %t1510, 0
  %t1514 = select i1 %t1513, i8* %t1512, i8* %t1511
  %t1515 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1516 = icmp eq i32 %t1510, 1
  %t1517 = select i1 %t1516, i8* %t1515, i8* %t1514
  %t1518 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1519 = icmp eq i32 %t1510, 2
  %t1520 = select i1 %t1519, i8* %t1518, i8* %t1517
  %t1521 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1522 = icmp eq i32 %t1510, 3
  %t1523 = select i1 %t1522, i8* %t1521, i8* %t1520
  %t1524 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1525 = icmp eq i32 %t1510, 4
  %t1526 = select i1 %t1525, i8* %t1524, i8* %t1523
  %t1527 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1528 = icmp eq i32 %t1510, 5
  %t1529 = select i1 %t1528, i8* %t1527, i8* %t1526
  %t1530 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1531 = icmp eq i32 %t1510, 6
  %t1532 = select i1 %t1531, i8* %t1530, i8* %t1529
  %t1533 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1534 = icmp eq i32 %t1510, 7
  %t1535 = select i1 %t1534, i8* %t1533, i8* %t1532
  %t1536 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1537 = icmp eq i32 %t1510, 8
  %t1538 = select i1 %t1537, i8* %t1536, i8* %t1535
  %t1539 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1540 = icmp eq i32 %t1510, 9
  %t1541 = select i1 %t1540, i8* %t1539, i8* %t1538
  %t1542 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1543 = icmp eq i32 %t1510, 10
  %t1544 = select i1 %t1543, i8* %t1542, i8* %t1541
  %t1545 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1546 = icmp eq i32 %t1510, 11
  %t1547 = select i1 %t1546, i8* %t1545, i8* %t1544
  %t1548 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1549 = icmp eq i32 %t1510, 12
  %t1550 = select i1 %t1549, i8* %t1548, i8* %t1547
  %t1551 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1552 = icmp eq i32 %t1510, 13
  %t1553 = select i1 %t1552, i8* %t1551, i8* %t1550
  %t1554 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1555 = icmp eq i32 %t1510, 14
  %t1556 = select i1 %t1555, i8* %t1554, i8* %t1553
  %t1557 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1558 = icmp eq i32 %t1510, 15
  %t1559 = select i1 %t1558, i8* %t1557, i8* %t1556
  %t1560 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1561 = icmp eq i32 %t1510, 16
  %t1562 = select i1 %t1561, i8* %t1560, i8* %t1559
  %s1563 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h217223495, i32 0, i32 0
  %t1564 = icmp eq i8* %t1562, %s1563
  %t1565 = load %PythonBuilder, %PythonBuilder* %l0
  %t1566 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1567 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1568 = load i8, i8* %l3
  %t1569 = load double, double* %l4
  %t1570 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1571 = load double, double* %l6
  %t1572 = load double, double* %l7
  %t1573 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1564, label %then82, label %else83
then82:
  %t1574 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1575 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t1574
  %t1576 = extractvalue { %MatchContext*, i64 } %t1575, 1
  %t1577 = icmp eq i64 %t1576, 0
  %t1578 = load %PythonBuilder, %PythonBuilder* %l0
  %t1579 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1580 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1581 = load i8, i8* %l3
  %t1582 = load double, double* %l4
  %t1583 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1584 = load double, double* %l6
  %t1585 = load double, double* %l7
  %t1586 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1577, label %then85, label %else86
then85:
  %t1587 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1588 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1587, i32 0, i32 0
  %t1589 = load i32, i32* %t1588
  %t1590 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1587, i32 0, i32 1
  %t1591 = bitcast [16 x i8]* %t1590 to i8*
  %t1592 = bitcast i8* %t1591 to i8**
  %t1593 = load i8*, i8** %t1592
  %t1594 = icmp eq i32 %t1589, 13
  %t1595 = select i1 %t1594, i8* %t1593, i8* null
  %t1596 = call i8* @trim_text(i8* %t1595)
  store i8* %t1596, i8** %l28
  %s1597 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.len39.h2079567388, i32 0, i32 0
  store i8* %s1597, i8** %l29
  %t1598 = load i8*, i8** %l28
  %t1599 = call i64 @sailfin_runtime_string_length(i8* %t1598)
  %t1600 = icmp sgt i64 %t1599, 0
  %t1601 = load %PythonBuilder, %PythonBuilder* %l0
  %t1602 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1603 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1604 = load i8, i8* %l3
  %t1605 = load double, double* %l4
  %t1606 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1607 = load double, double* %l6
  %t1608 = load double, double* %l7
  %t1609 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1610 = load i8*, i8** %l28
  %t1611 = load i8*, i8** %l29
  br i1 %t1600, label %then88, label %merge89
then88:
  %t1612 = load i8*, i8** %l29
  %s1613 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1460619898, i32 0, i32 0
  %t1614 = call i8* @sailfin_runtime_string_concat(i8* %t1612, i8* %s1613)
  %t1615 = load i8*, i8** %l28
  %t1616 = call i8* @sailfin_runtime_string_concat(i8* %t1614, i8* %t1615)
  %t1617 = load i8, i8* %t1616
  %t1618 = add i8 %t1617, 41
  %t1619 = alloca [2 x i8], align 1
  %t1620 = getelementptr [2 x i8], [2 x i8]* %t1619, i32 0, i32 0
  store i8 %t1618, i8* %t1620
  %t1621 = getelementptr [2 x i8], [2 x i8]* %t1619, i32 0, i32 1
  store i8 0, i8* %t1621
  %t1622 = getelementptr [2 x i8], [2 x i8]* %t1619, i32 0, i32 0
  store i8* %t1622, i8** %l29
  br label %merge89
merge89:
  %t1623 = phi i8* [ %t1622, %then88 ], [ %t1611, %then85 ]
  store i8* %t1623, i8** %l29
  %t1624 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1625 = extractvalue %NativeFunction %function, 0
  %t1626 = load i8*, i8** %l29
  %t1627 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t1624, i8* %t1625, i8* %t1626)
  store { i8**, i64 }* %t1627, { i8**, i64 }** %l1
  %t1628 = load %PythonBuilder, %PythonBuilder* %l0
  %s1629 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.len41.h1804821690, i32 0, i32 0
  %t1630 = call %PythonBuilder @builder_emit(%PythonBuilder %t1628, i8* %s1629)
  store %PythonBuilder %t1630, %PythonBuilder* %l0
  br label %merge87
else86:
  %t1631 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1632 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t1631
  %t1633 = extractvalue { %MatchContext*, i64 } %t1632, 1
  %t1634 = sub i64 %t1633, 1
  store i64 %t1634, i64* %l30
  %t1635 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1636 = load i64, i64* %l30
  %t1637 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t1635
  %t1638 = extractvalue { %MatchContext*, i64 } %t1637, 0
  %t1639 = extractvalue { %MatchContext*, i64 } %t1637, 1
  %t1640 = icmp uge i64 %t1636, %t1639
  ; bounds check: %t1640 (if true, out of bounds)
  %t1641 = getelementptr %MatchContext, %MatchContext* %t1638, i64 %t1636
  %t1642 = load %MatchContext, %MatchContext* %t1641
  store %MatchContext %t1642, %MatchContext* %l31
  %t1643 = load %MatchContext, %MatchContext* %l31
  %t1644 = extractvalue %MatchContext %t1643, 2
  %t1645 = load %PythonBuilder, %PythonBuilder* %l0
  %t1646 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1647 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1648 = load i8, i8* %l3
  %t1649 = load double, double* %l4
  %t1650 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1651 = load double, double* %l6
  %t1652 = load double, double* %l7
  %t1653 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1654 = load i64, i64* %l30
  %t1655 = load %MatchContext, %MatchContext* %l31
  br i1 %t1644, label %then90, label %merge91
then90:
  %t1656 = load %PythonBuilder, %PythonBuilder* %l0
  %t1657 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t1656)
  store %PythonBuilder %t1657, %PythonBuilder* %l0
  br label %merge91
merge91:
  %t1658 = phi %PythonBuilder [ %t1657, %then90 ], [ %t1645, %else86 ]
  store %PythonBuilder %t1658, %PythonBuilder* %l0
  %t1659 = load %MatchContext, %MatchContext* %l31
  %t1660 = extractvalue %MatchContext %t1659, 0
  %t1661 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1662 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1661, i32 0, i32 0
  %t1663 = load i32, i32* %t1662
  %t1664 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1661, i32 0, i32 1
  %t1665 = bitcast [16 x i8]* %t1664 to i8*
  %t1666 = bitcast i8* %t1665 to i8**
  %t1667 = load i8*, i8** %t1666
  %t1668 = icmp eq i32 %t1663, 13
  %t1669 = select i1 %t1668, i8* %t1667, i8* null
  %t1670 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1671 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1670, i32 0, i32 0
  %t1672 = load i32, i32* %t1671
  %t1673 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1670, i32 0, i32 1
  %t1674 = bitcast [16 x i8]* %t1673 to i8*
  %t1675 = getelementptr inbounds i8, i8* %t1674, i64 8
  %t1676 = bitcast i8* %t1675 to i8**
  %t1677 = load i8*, i8** %t1676
  %t1678 = icmp eq i32 %t1672, 13
  %t1679 = select i1 %t1678, i8* %t1677, i8* null
  %t1680 = call %LoweredCaseCondition @lower_match_case_condition(i8* %t1660, i8* %t1669, i8* %t1679)
  store %LoweredCaseCondition %t1680, %LoweredCaseCondition* %l32
  %t1681 = load %MatchContext, %MatchContext* %l31
  %t1682 = extractvalue %MatchContext %t1681, 1
  %t1683 = sitofp i64 0 to double
  %t1684 = fcmp oeq double %t1682, %t1683
  %t1685 = load %PythonBuilder, %PythonBuilder* %l0
  %t1686 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1687 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1688 = load i8, i8* %l3
  %t1689 = load double, double* %l4
  %t1690 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1691 = load double, double* %l6
  %t1692 = load double, double* %l7
  %t1693 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1694 = load i64, i64* %l30
  %t1695 = load %MatchContext, %MatchContext* %l31
  %t1696 = load %LoweredCaseCondition, %LoweredCaseCondition* %l32
  br i1 %t1684, label %then92, label %else93
then92:
  %t1697 = load %PythonBuilder, %PythonBuilder* %l0
  %s1698 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2090359129, i32 0, i32 0
  %t1699 = load %LoweredCaseCondition, %LoweredCaseCondition* %l32
  %t1700 = extractvalue %LoweredCaseCondition %t1699, 0
  %t1701 = call i8* @sailfin_runtime_string_concat(i8* %s1698, i8* %t1700)
  %t1702 = load i8, i8* %t1701
  %t1703 = add i8 %t1702, 58
  %t1704 = alloca [2 x i8], align 1
  %t1705 = getelementptr [2 x i8], [2 x i8]* %t1704, i32 0, i32 0
  store i8 %t1703, i8* %t1705
  %t1706 = getelementptr [2 x i8], [2 x i8]* %t1704, i32 0, i32 1
  store i8 0, i8* %t1706
  %t1707 = getelementptr [2 x i8], [2 x i8]* %t1704, i32 0, i32 0
  %t1708 = call %PythonBuilder @builder_emit(%PythonBuilder %t1697, i8* %t1707)
  store %PythonBuilder %t1708, %PythonBuilder* %l0
  br label %merge94
else93:
  %t1710 = load %LoweredCaseCondition, %LoweredCaseCondition* %l32
  %t1711 = extractvalue %LoweredCaseCondition %t1710, 1
  br label %logical_and_entry_1709

logical_and_entry_1709:
  br i1 %t1711, label %logical_and_right_1709, label %logical_and_merge_1709

logical_and_right_1709:
  %t1712 = load %LoweredCaseCondition, %LoweredCaseCondition* %l32
  %t1713 = extractvalue %LoweredCaseCondition %t1712, 2
  %t1714 = xor i1 %t1713, 1
  br label %logical_and_right_end_1709

logical_and_right_end_1709:
  br label %logical_and_merge_1709

logical_and_merge_1709:
  %t1715 = phi i1 [ false, %logical_and_entry_1709 ], [ %t1714, %logical_and_right_end_1709 ]
  %t1716 = load %PythonBuilder, %PythonBuilder* %l0
  %t1717 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1718 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1719 = load i8, i8* %l3
  %t1720 = load double, double* %l4
  %t1721 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1722 = load double, double* %l6
  %t1723 = load double, double* %l7
  %t1724 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1725 = load i64, i64* %l30
  %t1726 = load %MatchContext, %MatchContext* %l31
  %t1727 = load %LoweredCaseCondition, %LoweredCaseCondition* %l32
  br i1 %t1715, label %then95, label %else96
then95:
  %t1728 = load %PythonBuilder, %PythonBuilder* %l0
  %s1729 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2069574674, i32 0, i32 0
  %t1730 = call %PythonBuilder @builder_emit(%PythonBuilder %t1728, i8* %s1729)
  store %PythonBuilder %t1730, %PythonBuilder* %l0
  br label %merge97
else96:
  %t1731 = load %PythonBuilder, %PythonBuilder* %l0
  %s1732 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2069215535, i32 0, i32 0
  %t1733 = load %LoweredCaseCondition, %LoweredCaseCondition* %l32
  %t1734 = extractvalue %LoweredCaseCondition %t1733, 0
  %t1735 = call i8* @sailfin_runtime_string_concat(i8* %s1732, i8* %t1734)
  %t1736 = load i8, i8* %t1735
  %t1737 = add i8 %t1736, 58
  %t1738 = alloca [2 x i8], align 1
  %t1739 = getelementptr [2 x i8], [2 x i8]* %t1738, i32 0, i32 0
  store i8 %t1737, i8* %t1739
  %t1740 = getelementptr [2 x i8], [2 x i8]* %t1738, i32 0, i32 1
  store i8 0, i8* %t1740
  %t1741 = getelementptr [2 x i8], [2 x i8]* %t1738, i32 0, i32 0
  %t1742 = call %PythonBuilder @builder_emit(%PythonBuilder %t1731, i8* %t1741)
  store %PythonBuilder %t1742, %PythonBuilder* %l0
  br label %merge97
merge97:
  %t1743 = phi %PythonBuilder [ %t1730, %then95 ], [ %t1742, %else96 ]
  store %PythonBuilder %t1743, %PythonBuilder* %l0
  br label %merge94
merge94:
  %t1744 = phi %PythonBuilder [ %t1708, %then92 ], [ %t1730, %else93 ]
  store %PythonBuilder %t1744, %PythonBuilder* %l0
  %t1745 = load %PythonBuilder, %PythonBuilder* %l0
  %t1746 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t1745)
  store %PythonBuilder %t1746, %PythonBuilder* %l0
  %t1747 = load %MatchContext, %MatchContext* %l31
  %t1748 = extractvalue %MatchContext %t1747, 0
  %t1749 = insertvalue %MatchContext undef, i8* %t1748, 0
  %t1750 = load %MatchContext, %MatchContext* %l31
  %t1751 = extractvalue %MatchContext %t1750, 1
  %t1752 = sitofp i64 1 to double
  %t1753 = fadd double %t1751, %t1752
  %t1754 = insertvalue %MatchContext %t1749, double %t1753, 1
  %t1755 = insertvalue %MatchContext %t1754, i1 1, 2
  store %MatchContext %t1755, %MatchContext* %l33
  %t1756 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1757 = load i64, i64* %l30
  %t1758 = load %MatchContext, %MatchContext* %l33
  %t1759 = sitofp i64 %t1757 to double
  %t1760 = call { %MatchContext*, i64 }* @replace_match_context({ %MatchContext*, i64 }* %t1756, double %t1759, %MatchContext %t1758)
  store { %MatchContext*, i64 }* %t1760, { %MatchContext*, i64 }** %l5
  br label %merge87
merge87:
  %t1761 = phi { i8**, i64 }* [ %t1627, %then85 ], [ %t1579, %else86 ]
  %t1762 = phi %PythonBuilder [ %t1630, %then85 ], [ %t1657, %else86 ]
  %t1763 = phi { %MatchContext*, i64 }* [ %t1583, %then85 ], [ %t1760, %else86 ]
  store { i8**, i64 }* %t1761, { i8**, i64 }** %l1
  store %PythonBuilder %t1762, %PythonBuilder* %l0
  store { %MatchContext*, i64 }* %t1763, { %MatchContext*, i64 }** %l5
  br label %merge84
else83:
  %t1764 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1765 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1764, i32 0, i32 0
  %t1766 = load i32, i32* %t1765
  %t1767 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1768 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1769 = icmp eq i32 %t1766, 0
  %t1770 = select i1 %t1769, i8* %t1768, i8* %t1767
  %t1771 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1772 = icmp eq i32 %t1766, 1
  %t1773 = select i1 %t1772, i8* %t1771, i8* %t1770
  %t1774 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1775 = icmp eq i32 %t1766, 2
  %t1776 = select i1 %t1775, i8* %t1774, i8* %t1773
  %t1777 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1778 = icmp eq i32 %t1766, 3
  %t1779 = select i1 %t1778, i8* %t1777, i8* %t1776
  %t1780 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1781 = icmp eq i32 %t1766, 4
  %t1782 = select i1 %t1781, i8* %t1780, i8* %t1779
  %t1783 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1784 = icmp eq i32 %t1766, 5
  %t1785 = select i1 %t1784, i8* %t1783, i8* %t1782
  %t1786 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1787 = icmp eq i32 %t1766, 6
  %t1788 = select i1 %t1787, i8* %t1786, i8* %t1785
  %t1789 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1790 = icmp eq i32 %t1766, 7
  %t1791 = select i1 %t1790, i8* %t1789, i8* %t1788
  %t1792 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1793 = icmp eq i32 %t1766, 8
  %t1794 = select i1 %t1793, i8* %t1792, i8* %t1791
  %t1795 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1796 = icmp eq i32 %t1766, 9
  %t1797 = select i1 %t1796, i8* %t1795, i8* %t1794
  %t1798 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1799 = icmp eq i32 %t1766, 10
  %t1800 = select i1 %t1799, i8* %t1798, i8* %t1797
  %t1801 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1802 = icmp eq i32 %t1766, 11
  %t1803 = select i1 %t1802, i8* %t1801, i8* %t1800
  %t1804 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1805 = icmp eq i32 %t1766, 12
  %t1806 = select i1 %t1805, i8* %t1804, i8* %t1803
  %t1807 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1808 = icmp eq i32 %t1766, 13
  %t1809 = select i1 %t1808, i8* %t1807, i8* %t1806
  %t1810 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1811 = icmp eq i32 %t1766, 14
  %t1812 = select i1 %t1811, i8* %t1810, i8* %t1809
  %t1813 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1814 = icmp eq i32 %t1766, 15
  %t1815 = select i1 %t1814, i8* %t1813, i8* %t1812
  %t1816 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1817 = icmp eq i32 %t1766, 16
  %t1818 = select i1 %t1817, i8* %t1816, i8* %t1815
  %s1819 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h794378208, i32 0, i32 0
  %t1820 = icmp eq i8* %t1818, %s1819
  %t1821 = load %PythonBuilder, %PythonBuilder* %l0
  %t1822 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1823 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1824 = load i8, i8* %l3
  %t1825 = load double, double* %l4
  %t1826 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1827 = load double, double* %l6
  %t1828 = load double, double* %l7
  %t1829 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1820, label %then98, label %else99
then98:
  %t1830 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1831 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t1830
  %t1832 = extractvalue { %MatchContext*, i64 } %t1831, 1
  %t1833 = icmp eq i64 %t1832, 0
  %t1834 = load %PythonBuilder, %PythonBuilder* %l0
  %t1835 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1836 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1837 = load i8, i8* %l3
  %t1838 = load double, double* %l4
  %t1839 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1840 = load double, double* %l6
  %t1841 = load double, double* %l7
  %t1842 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1833, label %then101, label %else102
then101:
  %t1843 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1844 = extractvalue %NativeFunction %function, 0
  %s1845 = getelementptr inbounds [38 x i8], [38 x i8]* @.str.len37.h314404344, i32 0, i32 0
  %t1846 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t1843, i8* %t1844, i8* %s1845)
  store { i8**, i64 }* %t1846, { i8**, i64 }** %l1
  %t1847 = load %PythonBuilder, %PythonBuilder* %l0
  %s1848 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.len39.h198700275, i32 0, i32 0
  %t1849 = call %PythonBuilder @builder_emit(%PythonBuilder %t1847, i8* %s1848)
  store %PythonBuilder %t1849, %PythonBuilder* %l0
  br label %merge103
else102:
  %t1850 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1851 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t1850
  %t1852 = extractvalue { %MatchContext*, i64 } %t1851, 1
  %t1853 = sub i64 %t1852, 1
  store i64 %t1853, i64* %l34
  %t1854 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1855 = load i64, i64* %l34
  %t1856 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t1854
  %t1857 = extractvalue { %MatchContext*, i64 } %t1856, 0
  %t1858 = extractvalue { %MatchContext*, i64 } %t1856, 1
  %t1859 = icmp uge i64 %t1855, %t1858
  ; bounds check: %t1859 (if true, out of bounds)
  %t1860 = getelementptr %MatchContext, %MatchContext* %t1857, i64 %t1855
  %t1861 = load %MatchContext, %MatchContext* %t1860
  store %MatchContext %t1861, %MatchContext* %l35
  %t1862 = load %MatchContext, %MatchContext* %l35
  %t1863 = extractvalue %MatchContext %t1862, 2
  %t1864 = load %PythonBuilder, %PythonBuilder* %l0
  %t1865 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1866 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1867 = load i8, i8* %l3
  %t1868 = load double, double* %l4
  %t1869 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1870 = load double, double* %l6
  %t1871 = load double, double* %l7
  %t1872 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1873 = load i64, i64* %l34
  %t1874 = load %MatchContext, %MatchContext* %l35
  br i1 %t1863, label %then104, label %merge105
then104:
  %t1875 = load %PythonBuilder, %PythonBuilder* %l0
  %t1876 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t1875)
  store %PythonBuilder %t1876, %PythonBuilder* %l0
  br label %merge105
merge105:
  %t1877 = phi %PythonBuilder [ %t1876, %then104 ], [ %t1864, %else102 ]
  store %PythonBuilder %t1877, %PythonBuilder* %l0
  %t1878 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1879 = load i64, i64* %l34
  %t1880 = sitofp i64 %t1879 to double
  %t1881 = call { %MatchContext*, i64 }* @truncate_match_contexts({ %MatchContext*, i64 }* %t1878, double %t1880)
  store { %MatchContext*, i64 }* %t1881, { %MatchContext*, i64 }** %l5
  br label %merge103
merge103:
  %t1882 = phi { i8**, i64 }* [ %t1846, %then101 ], [ %t1835, %else102 ]
  %t1883 = phi %PythonBuilder [ %t1849, %then101 ], [ %t1876, %else102 ]
  %t1884 = phi { %MatchContext*, i64 }* [ %t1839, %then101 ], [ %t1881, %else102 ]
  store { i8**, i64 }* %t1882, { i8**, i64 }** %l1
  store %PythonBuilder %t1883, %PythonBuilder* %l0
  store { %MatchContext*, i64 }* %t1884, { %MatchContext*, i64 }** %l5
  br label %merge100
else99:
  %t1885 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1886 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1885, i32 0, i32 0
  %t1887 = load i32, i32* %t1886
  %t1888 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1889 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1890 = icmp eq i32 %t1887, 0
  %t1891 = select i1 %t1890, i8* %t1889, i8* %t1888
  %t1892 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1893 = icmp eq i32 %t1887, 1
  %t1894 = select i1 %t1893, i8* %t1892, i8* %t1891
  %t1895 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1896 = icmp eq i32 %t1887, 2
  %t1897 = select i1 %t1896, i8* %t1895, i8* %t1894
  %t1898 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1899 = icmp eq i32 %t1887, 3
  %t1900 = select i1 %t1899, i8* %t1898, i8* %t1897
  %t1901 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1902 = icmp eq i32 %t1887, 4
  %t1903 = select i1 %t1902, i8* %t1901, i8* %t1900
  %t1904 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1905 = icmp eq i32 %t1887, 5
  %t1906 = select i1 %t1905, i8* %t1904, i8* %t1903
  %t1907 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1908 = icmp eq i32 %t1887, 6
  %t1909 = select i1 %t1908, i8* %t1907, i8* %t1906
  %t1910 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1911 = icmp eq i32 %t1887, 7
  %t1912 = select i1 %t1911, i8* %t1910, i8* %t1909
  %t1913 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1914 = icmp eq i32 %t1887, 8
  %t1915 = select i1 %t1914, i8* %t1913, i8* %t1912
  %t1916 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1917 = icmp eq i32 %t1887, 9
  %t1918 = select i1 %t1917, i8* %t1916, i8* %t1915
  %t1919 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1920 = icmp eq i32 %t1887, 10
  %t1921 = select i1 %t1920, i8* %t1919, i8* %t1918
  %t1922 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1923 = icmp eq i32 %t1887, 11
  %t1924 = select i1 %t1923, i8* %t1922, i8* %t1921
  %t1925 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1926 = icmp eq i32 %t1887, 12
  %t1927 = select i1 %t1926, i8* %t1925, i8* %t1924
  %t1928 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1929 = icmp eq i32 %t1887, 13
  %t1930 = select i1 %t1929, i8* %t1928, i8* %t1927
  %t1931 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1932 = icmp eq i32 %t1887, 14
  %t1933 = select i1 %t1932, i8* %t1931, i8* %t1930
  %t1934 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1935 = icmp eq i32 %t1887, 15
  %t1936 = select i1 %t1935, i8* %t1934, i8* %t1933
  %t1937 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1938 = icmp eq i32 %t1887, 16
  %t1939 = select i1 %t1938, i8* %t1937, i8* %t1936
  %s1940 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h230767751, i32 0, i32 0
  %t1941 = icmp eq i8* %t1939, %s1940
  %t1942 = load %PythonBuilder, %PythonBuilder* %l0
  %t1943 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1944 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1945 = load i8, i8* %l3
  %t1946 = load double, double* %l4
  %t1947 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1948 = load double, double* %l6
  %t1949 = load double, double* %l7
  %t1950 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1941, label %then106, label %else107
then106:
  %t1951 = load %PythonBuilder, %PythonBuilder* %l0
  %s1952 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h270590402, i32 0, i32 0
  %t1953 = call %PythonBuilder @builder_emit(%PythonBuilder %t1951, i8* %s1952)
  store %PythonBuilder %t1953, %PythonBuilder* %l0
  br label %merge108
else107:
  %t1954 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1955 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1954, i32 0, i32 0
  %t1956 = load i32, i32* %t1955
  %t1957 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1954, i32 0, i32 1
  %t1958 = bitcast [8 x i8]* %t1957 to i8*
  %t1959 = bitcast i8* %t1958 to i8**
  %t1960 = load i8*, i8** %t1959
  %t1961 = icmp eq i32 %t1956, 16
  %t1962 = select i1 %t1961, i8* %t1960, i8* null
  %t1963 = call i8* @trim_text(i8* %t1962)
  store i8* %t1963, i8** %l36
  %s1964 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.len42.h9444846, i32 0, i32 0
  store i8* %s1964, i8** %l37
  %t1965 = load i8*, i8** %l36
  %t1966 = call i64 @sailfin_runtime_string_length(i8* %t1965)
  %t1967 = icmp sgt i64 %t1966, 0
  %t1968 = load %PythonBuilder, %PythonBuilder* %l0
  %t1969 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1970 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1971 = load i8, i8* %l3
  %t1972 = load double, double* %l4
  %t1973 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1974 = load double, double* %l6
  %t1975 = load double, double* %l7
  %t1976 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1977 = load i8*, i8** %l36
  %t1978 = load i8*, i8** %l37
  br i1 %t1967, label %then109, label %merge110
then109:
  %t1979 = load i8*, i8** %l37
  %s1980 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193441217, i32 0, i32 0
  %t1981 = call i8* @sailfin_runtime_string_concat(i8* %t1979, i8* %s1980)
  %t1982 = load i8*, i8** %l36
  %t1983 = call i8* @sailfin_runtime_string_concat(i8* %t1981, i8* %t1982)
  store i8* %t1983, i8** %l37
  br label %merge110
merge110:
  %t1984 = phi i8* [ %t1983, %then109 ], [ %t1978, %else107 ]
  store i8* %t1984, i8** %l37
  %t1985 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1986 = extractvalue %NativeFunction %function, 0
  %t1987 = load i8*, i8** %l37
  %t1988 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t1985, i8* %t1986, i8* %t1987)
  store { i8**, i64 }* %t1988, { i8**, i64 }** %l1
  %t1989 = load %PythonBuilder, %PythonBuilder* %l0
  %s1990 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h1983072220, i32 0, i32 0
  %t1991 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1992 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1991, i32 0, i32 0
  %t1993 = load i32, i32* %t1992
  %t1994 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1991, i32 0, i32 1
  %t1995 = bitcast [8 x i8]* %t1994 to i8*
  %t1996 = bitcast i8* %t1995 to i8**
  %t1997 = load i8*, i8** %t1996
  %t1998 = icmp eq i32 %t1993, 16
  %t1999 = select i1 %t1998, i8* %t1997, i8* null
  %t2000 = call i8* @sailfin_runtime_string_concat(i8* %s1990, i8* %t1999)
  %t2001 = call %PythonBuilder @builder_emit(%PythonBuilder %t1989, i8* %t2000)
  store %PythonBuilder %t2001, %PythonBuilder* %l0
  br label %merge108
merge108:
  %t2002 = phi %PythonBuilder [ %t1953, %then106 ], [ %t2001, %else107 ]
  %t2003 = phi { i8**, i64 }* [ %t1943, %then106 ], [ %t1988, %else107 ]
  store %PythonBuilder %t2002, %PythonBuilder* %l0
  store { i8**, i64 }* %t2003, { i8**, i64 }** %l1
  br label %merge100
merge100:
  %t2004 = phi { i8**, i64 }* [ %t1846, %then98 ], [ %t1988, %else99 ]
  %t2005 = phi %PythonBuilder [ %t1849, %then98 ], [ %t1953, %else99 ]
  %t2006 = phi { %MatchContext*, i64 }* [ %t1881, %then98 ], [ %t1826, %else99 ]
  store { i8**, i64 }* %t2004, { i8**, i64 }** %l1
  store %PythonBuilder %t2005, %PythonBuilder* %l0
  store { %MatchContext*, i64 }* %t2006, { %MatchContext*, i64 }** %l5
  br label %merge84
merge84:
  %t2007 = phi { i8**, i64 }* [ %t1627, %then82 ], [ %t1846, %else83 ]
  %t2008 = phi %PythonBuilder [ %t1630, %then82 ], [ %t1849, %else83 ]
  %t2009 = phi { %MatchContext*, i64 }* [ %t1760, %then82 ], [ %t1881, %else83 ]
  store { i8**, i64 }* %t2007, { i8**, i64 }** %l1
  store %PythonBuilder %t2008, %PythonBuilder* %l0
  store { %MatchContext*, i64 }* %t2009, { %MatchContext*, i64 }** %l5
  br label %merge81
merge81:
  %t2010 = phi double [ %t1470, %then79 ], [ %t1463, %else80 ]
  %t2011 = phi %PythonBuilder [ %t1499, %then79 ], [ %t1630, %else80 ]
  %t2012 = phi { %MatchContext*, i64 }* [ %t1507, %then79 ], [ %t1760, %else80 ]
  %t2013 = phi { i8**, i64 }* [ %t1458, %then79 ], [ %t1627, %else80 ]
  store double %t2010, double* %l6
  store %PythonBuilder %t2011, %PythonBuilder* %l0
  store { %MatchContext*, i64 }* %t2012, { %MatchContext*, i64 }** %l5
  store { i8**, i64 }* %t2013, { i8**, i64 }** %l1
  br label %merge78
merge78:
  %t2014 = phi %PythonBuilder [ %t1399, %then76 ], [ %t1499, %else77 ]
  %t2015 = phi double [ %t1394, %then76 ], [ %t1470, %else77 ]
  %t2016 = phi { %MatchContext*, i64 }* [ %t1393, %then76 ], [ %t1507, %else77 ]
  %t2017 = phi { i8**, i64 }* [ %t1389, %then76 ], [ %t1627, %else77 ]
  store %PythonBuilder %t2014, %PythonBuilder* %l0
  store double %t2015, double* %l6
  store { %MatchContext*, i64 }* %t2016, { %MatchContext*, i64 }** %l5
  store { i8**, i64 }* %t2017, { i8**, i64 }** %l1
  br label %merge75
merge75:
  %t2018 = phi %PythonBuilder [ %t1330, %then73 ], [ %t1399, %else74 ]
  %t2019 = phi double [ %t1325, %then73 ], [ %t1470, %else74 ]
  %t2020 = phi { %MatchContext*, i64 }* [ %t1324, %then73 ], [ %t1507, %else74 ]
  %t2021 = phi { i8**, i64 }* [ %t1320, %then73 ], [ %t1627, %else74 ]
  store %PythonBuilder %t2018, %PythonBuilder* %l0
  store double %t2019, double* %l6
  store { %MatchContext*, i64 }* %t2020, { %MatchContext*, i64 }** %l5
  store { i8**, i64 }* %t2021, { i8**, i64 }** %l1
  br label %merge69
merge69:
  %t2022 = phi %PythonBuilder [ %t1251, %then67 ], [ %t1330, %else68 ]
  %t2023 = phi double [ %t1254, %then67 ], [ %t1233, %else68 ]
  %t2024 = phi { i8**, i64 }* [ %t1258, %then67 ], [ %t1627, %else68 ]
  %t2025 = phi double [ %t1235, %then67 ], [ %t1470, %else68 ]
  %t2026 = phi { %MatchContext*, i64 }* [ %t1234, %then67 ], [ %t1507, %else68 ]
  store %PythonBuilder %t2022, %PythonBuilder* %l0
  store double %t2023, double* %l4
  store { i8**, i64 }* %t2024, { i8**, i64 }** %l1
  store double %t2025, double* %l6
  store { %MatchContext*, i64 }* %t2026, { %MatchContext*, i64 }** %l5
  br label %merge66
merge66:
  %t2027 = phi %PythonBuilder [ %t1166, %then64 ], [ %t1251, %else65 ]
  %t2028 = phi double [ %t1171, %then64 ], [ %t1254, %else65 ]
  %t2029 = phi { i8**, i64 }* [ %t1156, %then64 ], [ %t1258, %else65 ]
  %t2030 = phi double [ %t1161, %then64 ], [ %t1470, %else65 ]
  %t2031 = phi { %MatchContext*, i64 }* [ %t1160, %then64 ], [ %t1507, %else65 ]
  store %PythonBuilder %t2027, %PythonBuilder* %l0
  store double %t2028, double* %l4
  store { i8**, i64 }* %t2029, { i8**, i64 }** %l1
  store double %t2030, double* %l6
  store { %MatchContext*, i64 }* %t2031, { %MatchContext*, i64 }** %l5
  br label %merge60
merge60:
  %t2032 = phi %PythonBuilder [ %t1087, %then58 ], [ %t1166, %else59 ]
  %t2033 = phi double [ %t1090, %then58 ], [ %t1171, %else59 ]
  %t2034 = phi { i8**, i64 }* [ %t1094, %then58 ], [ %t1258, %else59 ]
  %t2035 = phi double [ %t1071, %then58 ], [ %t1470, %else59 ]
  %t2036 = phi { %MatchContext*, i64 }* [ %t1070, %then58 ], [ %t1507, %else59 ]
  store %PythonBuilder %t2032, %PythonBuilder* %l0
  store double %t2033, double* %l4
  store { i8**, i64 }* %t2034, { i8**, i64 }** %l1
  store double %t2035, double* %l6
  store { %MatchContext*, i64 }* %t2036, { %MatchContext*, i64 }** %l5
  br label %merge57
merge57:
  %t2037 = phi %PythonBuilder [ %t1002, %then55 ], [ %t1087, %else56 ]
  %t2038 = phi double [ %t1007, %then55 ], [ %t1090, %else56 ]
  %t2039 = phi { i8**, i64 }* [ %t960, %then55 ], [ %t1094, %else56 ]
  %t2040 = phi double [ %t965, %then55 ], [ %t1470, %else56 ]
  %t2041 = phi { %MatchContext*, i64 }* [ %t964, %then55 ], [ %t1507, %else56 ]
  store %PythonBuilder %t2037, %PythonBuilder* %l0
  store double %t2038, double* %l4
  store { i8**, i64 }* %t2039, { i8**, i64 }** %l1
  store double %t2040, double* %l6
  store { %MatchContext*, i64 }* %t2041, { %MatchContext*, i64 }** %l5
  br label %merge51
merge51:
  %t2042 = phi %PythonBuilder [ %t891, %then49 ], [ %t1002, %else50 ]
  %t2043 = phi double [ %t894, %then49 ], [ %t1007, %else50 ]
  %t2044 = phi { i8**, i64 }* [ %t898, %then49 ], [ %t1094, %else50 ]
  %t2045 = phi double [ %t875, %then49 ], [ %t1470, %else50 ]
  %t2046 = phi { %MatchContext*, i64 }* [ %t874, %then49 ], [ %t1507, %else50 ]
  store %PythonBuilder %t2042, %PythonBuilder* %l0
  store double %t2043, double* %l4
  store { i8**, i64 }* %t2044, { i8**, i64 }** %l1
  store double %t2045, double* %l6
  store { %MatchContext*, i64 }* %t2046, { %MatchContext*, i64 }** %l5
  br label %merge45
merge45:
  %t2047 = phi %PythonBuilder [ %t800, %then43 ], [ %t891, %else44 ]
  %t2048 = phi { i8**, i64 }* [ %t804, %then43 ], [ %t898, %else44 ]
  %t2049 = phi double [ %t782, %then43 ], [ %t894, %else44 ]
  %t2050 = phi double [ %t784, %then43 ], [ %t1470, %else44 ]
  %t2051 = phi { %MatchContext*, i64 }* [ %t783, %then43 ], [ %t1507, %else44 ]
  store %PythonBuilder %t2047, %PythonBuilder* %l0
  store { i8**, i64 }* %t2048, { i8**, i64 }** %l1
  store double %t2049, double* %l4
  store double %t2050, double* %l6
  store { %MatchContext*, i64 }* %t2051, { %MatchContext*, i64 }** %l5
  br label %merge42
merge42:
  %t2052 = phi %PythonBuilder [ %t715, %then40 ], [ %t800, %else41 ]
  %t2053 = phi double [ %t720, %then40 ], [ %t894, %else41 ]
  %t2054 = phi { i8**, i64 }* [ %t686, %then40 ], [ %t804, %else41 ]
  %t2055 = phi double [ %t691, %then40 ], [ %t1470, %else41 ]
  %t2056 = phi { %MatchContext*, i64 }* [ %t690, %then40 ], [ %t1507, %else41 ]
  store %PythonBuilder %t2052, %PythonBuilder* %l0
  store double %t2053, double* %l4
  store { i8**, i64 }* %t2054, { i8**, i64 }** %l1
  store double %t2055, double* %l6
  store { %MatchContext*, i64 }* %t2056, { %MatchContext*, i64 }** %l5
  br label %merge31
merge31:
  %t2057 = phi double [ %t619, %then29 ], [ %t506, %else30 ]
  %t2058 = phi %PythonBuilder [ %t627, %then29 ], [ %t715, %else30 ]
  %t2059 = phi double [ %t503, %then29 ], [ %t720, %else30 ]
  %t2060 = phi { i8**, i64 }* [ %t500, %then29 ], [ %t804, %else30 ]
  %t2061 = phi double [ %t505, %then29 ], [ %t1470, %else30 ]
  %t2062 = phi { %MatchContext*, i64 }* [ %t504, %then29 ], [ %t1507, %else30 ]
  store double %t2057, double* %l7
  store %PythonBuilder %t2058, %PythonBuilder* %l0
  store double %t2059, double* %l4
  store { i8**, i64 }* %t2060, { i8**, i64 }** %l1
  store double %t2061, double* %l6
  store { %MatchContext*, i64 }* %t2062, { %MatchContext*, i64 }** %l5
  br label %merge23
merge23:
  %t2063 = phi %PythonBuilder [ %t438, %then21 ], [ %t627, %else22 ]
  %t2064 = phi double [ %t441, %then21 ], [ %t619, %else22 ]
  %t2065 = phi double [ %t353, %then21 ], [ %t720, %else22 ]
  %t2066 = phi { i8**, i64 }* [ %t350, %then21 ], [ %t804, %else22 ]
  %t2067 = phi double [ %t355, %then21 ], [ %t1470, %else22 ]
  %t2068 = phi { %MatchContext*, i64 }* [ %t354, %then21 ], [ %t1507, %else22 ]
  store %PythonBuilder %t2063, %PythonBuilder* %l0
  store double %t2064, double* %l7
  store double %t2065, double* %l4
  store { i8**, i64 }* %t2066, { i8**, i64 }** %l1
  store double %t2067, double* %l6
  store { %MatchContext*, i64 }* %t2068, { %MatchContext*, i64 }** %l5
  br label %merge12
merge12:
  %t2069 = phi %PythonBuilder [ %t203, %then10 ], [ %t438, %else11 ]
  %t2070 = phi double [ %t289, %then10 ], [ %t441, %else11 ]
  %t2071 = phi double [ %t164, %then10 ], [ %t720, %else11 ]
  %t2072 = phi { i8**, i64 }* [ %t161, %then10 ], [ %t804, %else11 ]
  %t2073 = phi double [ %t166, %then10 ], [ %t1470, %else11 ]
  %t2074 = phi { %MatchContext*, i64 }* [ %t165, %then10 ], [ %t1507, %else11 ]
  store %PythonBuilder %t2069, %PythonBuilder* %l0
  store double %t2070, double* %l7
  store double %t2071, double* %l4
  store { i8**, i64 }* %t2072, { i8**, i64 }** %l1
  store double %t2073, double* %l6
  store { %MatchContext*, i64 }* %t2074, { %MatchContext*, i64 }** %l5
  %t2075 = load double, double* %l7
  %t2076 = sitofp i64 1 to double
  %t2077 = fadd double %t2075, %t2076
  store double %t2077, double* %l7
  br label %loop.latch6
loop.latch6:
  %t2078 = load %PythonBuilder, %PythonBuilder* %l0
  %t2079 = load double, double* %l7
  %t2080 = load double, double* %l4
  %t2081 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2082 = load double, double* %l6
  %t2083 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  br label %loop.header4
afterloop7:
  %t2090 = load %PythonBuilder, %PythonBuilder* %l0
  %t2091 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2092 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2093 = load i8, i8* %l3
  %t2094 = load double, double* %l4
  %t2095 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2096 = load double, double* %l6
  %t2097 = load double, double* %l7
  br label %loop.header111
loop.header111:
  %t2148 = phi %PythonBuilder [ %t2090, %entry ], [ %t2145, %loop.latch113 ]
  %t2149 = phi { i8**, i64 }* [ %t2091, %entry ], [ %t2146, %loop.latch113 ]
  %t2150 = phi { %MatchContext*, i64 }* [ %t2095, %entry ], [ %t2147, %loop.latch113 ]
  store %PythonBuilder %t2148, %PythonBuilder* %l0
  store { i8**, i64 }* %t2149, { i8**, i64 }** %l1
  store { %MatchContext*, i64 }* %t2150, { %MatchContext*, i64 }** %l5
  br label %loop.body112
loop.body112:
  %t2098 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2099 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t2098
  %t2100 = extractvalue { %MatchContext*, i64 } %t2099, 1
  %t2101 = icmp eq i64 %t2100, 0
  %t2102 = load %PythonBuilder, %PythonBuilder* %l0
  %t2103 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2104 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2105 = load i8, i8* %l3
  %t2106 = load double, double* %l4
  %t2107 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2108 = load double, double* %l6
  %t2109 = load double, double* %l7
  br i1 %t2101, label %then115, label %merge116
then115:
  br label %afterloop114
merge116:
  %t2110 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2111 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t2110
  %t2112 = extractvalue { %MatchContext*, i64 } %t2111, 1
  %t2113 = sub i64 %t2112, 1
  store i64 %t2113, i64* %l38
  %t2114 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2115 = load i64, i64* %l38
  %t2116 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t2114
  %t2117 = extractvalue { %MatchContext*, i64 } %t2116, 0
  %t2118 = extractvalue { %MatchContext*, i64 } %t2116, 1
  %t2119 = icmp uge i64 %t2115, %t2118
  ; bounds check: %t2119 (if true, out of bounds)
  %t2120 = getelementptr %MatchContext, %MatchContext* %t2117, i64 %t2115
  %t2121 = load %MatchContext, %MatchContext* %t2120
  store %MatchContext %t2121, %MatchContext* %l39
  %t2122 = load %MatchContext, %MatchContext* %l39
  %t2123 = extractvalue %MatchContext %t2122, 2
  %t2124 = load %PythonBuilder, %PythonBuilder* %l0
  %t2125 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2126 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2127 = load i8, i8* %l3
  %t2128 = load double, double* %l4
  %t2129 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2130 = load double, double* %l6
  %t2131 = load double, double* %l7
  %t2132 = load i64, i64* %l38
  %t2133 = load %MatchContext, %MatchContext* %l39
  br i1 %t2123, label %then117, label %merge118
then117:
  %t2134 = load %PythonBuilder, %PythonBuilder* %l0
  %t2135 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t2134)
  store %PythonBuilder %t2135, %PythonBuilder* %l0
  br label %merge118
merge118:
  %t2136 = phi %PythonBuilder [ %t2135, %then117 ], [ %t2124, %loop.body112 ]
  store %PythonBuilder %t2136, %PythonBuilder* %l0
  %t2137 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2138 = extractvalue %NativeFunction %function, 0
  %s2139 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.len29.h1409903806, i32 0, i32 0
  %t2140 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t2137, i8* %t2138, i8* %s2139)
  store { i8**, i64 }* %t2140, { i8**, i64 }** %l1
  %t2141 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2142 = load i64, i64* %l38
  %t2143 = sitofp i64 %t2142 to double
  %t2144 = call { %MatchContext*, i64 }* @truncate_match_contexts({ %MatchContext*, i64 }* %t2141, double %t2143)
  store { %MatchContext*, i64 }* %t2144, { %MatchContext*, i64 }** %l5
  br label %loop.latch113
loop.latch113:
  %t2145 = load %PythonBuilder, %PythonBuilder* %l0
  %t2146 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2147 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  br label %loop.header111
afterloop114:
  %t2151 = load %PythonBuilder, %PythonBuilder* %l0
  %t2152 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2153 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2154 = load i8, i8* %l3
  %t2155 = load double, double* %l4
  %t2156 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2157 = load double, double* %l6
  %t2158 = load double, double* %l7
  br label %loop.header119
loop.header119:
  %t2182 = phi %PythonBuilder [ %t2151, %entry ], [ %t2179, %loop.latch121 ]
  %t2183 = phi double [ %t2155, %entry ], [ %t2180, %loop.latch121 ]
  %t2184 = phi { i8**, i64 }* [ %t2152, %entry ], [ %t2181, %loop.latch121 ]
  store %PythonBuilder %t2182, %PythonBuilder* %l0
  store double %t2183, double* %l4
  store { i8**, i64 }* %t2184, { i8**, i64 }** %l1
  br label %loop.body120
loop.body120:
  %t2159 = load double, double* %l4
  %t2160 = sitofp i64 0 to double
  %t2161 = fcmp ole double %t2159, %t2160
  %t2162 = load %PythonBuilder, %PythonBuilder* %l0
  %t2163 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2164 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2165 = load i8, i8* %l3
  %t2166 = load double, double* %l4
  %t2167 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2168 = load double, double* %l6
  %t2169 = load double, double* %l7
  br i1 %t2161, label %then123, label %merge124
then123:
  br label %afterloop122
merge124:
  %t2170 = load %PythonBuilder, %PythonBuilder* %l0
  %t2171 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t2170)
  store %PythonBuilder %t2171, %PythonBuilder* %l0
  %t2172 = load double, double* %l4
  %t2173 = sitofp i64 1 to double
  %t2174 = fsub double %t2172, %t2173
  store double %t2174, double* %l4
  %t2175 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2176 = extractvalue %NativeFunction %function, 0
  %s2177 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.len31.h1736570074, i32 0, i32 0
  %t2178 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t2175, i8* %t2176, i8* %s2177)
  store { i8**, i64 }* %t2178, { i8**, i64 }** %l1
  br label %loop.latch121
loop.latch121:
  %t2179 = load %PythonBuilder, %PythonBuilder* %l0
  %t2180 = load double, double* %l4
  %t2181 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %loop.header119
afterloop122:
  %t2185 = load %PythonBuilder, %PythonBuilder* %l0
  %t2186 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t2185)
  store %PythonBuilder %t2186, %PythonBuilder* %l0
  %t2187 = load %PythonBuilder, %PythonBuilder* %l0
  %t2188 = insertvalue %PythonFunctionEmission undef, %PythonBuilder %t2187, 0
  %t2189 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2190 = insertvalue %PythonFunctionEmission %t2188, { i8**, i64 }* %t2189, 1
  ret %PythonFunctionEmission %t2190
}

define { %MatchContext*, i64 }* @append_match_context({ %MatchContext*, i64 }* %values, %MatchContext %value) {
entry:
  %t0 = call noalias i8* @malloc(i64 24)
  %t1 = bitcast i8* %t0 to %MatchContext*
  store %MatchContext %value, %MatchContext* %t1
  %t2 = alloca [1 x i8*]
  %t3 = getelementptr [1 x i8*], [1 x i8*]* %t2, i32 0, i32 0
  %t4 = getelementptr i8*, i8** %t3, i64 0
  store i8* %t0, i8** %t4
  %t5 = alloca { i8**, i64 }
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 0
  store i8** %t3, i8*** %t6
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 1
  store i64 1, i64* %t7
  %t8 = bitcast { %MatchContext*, i64 }* %values to { i8**, i64 }*
  %t9 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t8, { i8**, i64 }* %t5)
  %t10 = bitcast { i8**, i64 }* %t9 to { %MatchContext*, i64 }*
  ret { %MatchContext*, i64 }* %t10
}

define { %MatchContext*, i64 }* @replace_match_context({ %MatchContext*, i64 }* %values, double %index, %MatchContext %replacement) {
entry:
  %l0 = alloca { %MatchContext*, i64 }*
  %l1 = alloca double
  %t0 = alloca [0 x %MatchContext]
  %t1 = getelementptr [0 x %MatchContext], [0 x %MatchContext]* %t0, i32 0, i32 0
  %t2 = alloca { %MatchContext*, i64 }
  %t3 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t2, i32 0, i32 0
  store %MatchContext* %t1, %MatchContext** %t3
  %t4 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %MatchContext*, i64 }* %t2, { %MatchContext*, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t37 = phi { %MatchContext*, i64 }* [ %t6, %entry ], [ %t35, %loop.latch2 ]
  %t38 = phi double [ %t7, %entry ], [ %t36, %loop.latch2 ]
  store { %MatchContext*, i64 }* %t37, { %MatchContext*, i64 }** %l0
  store double %t38, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %values
  %t10 = extractvalue { %MatchContext*, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l1
  %t16 = fcmp oeq double %t15, %index
  %t17 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t18 = load double, double* %l1
  br i1 %t16, label %then6, label %else7
then6:
  %t19 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t20 = call { %MatchContext*, i64 }* @append_match_context({ %MatchContext*, i64 }* %t19, %MatchContext %replacement)
  store { %MatchContext*, i64 }* %t20, { %MatchContext*, i64 }** %l0
  br label %merge8
else7:
  %t21 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t22 = load double, double* %l1
  %t23 = fptosi double %t22 to i64
  %t24 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %values
  %t25 = extractvalue { %MatchContext*, i64 } %t24, 0
  %t26 = extractvalue { %MatchContext*, i64 } %t24, 1
  %t27 = icmp uge i64 %t23, %t26
  ; bounds check: %t27 (if true, out of bounds)
  %t28 = getelementptr %MatchContext, %MatchContext* %t25, i64 %t23
  %t29 = load %MatchContext, %MatchContext* %t28
  %t30 = call { %MatchContext*, i64 }* @append_match_context({ %MatchContext*, i64 }* %t21, %MatchContext %t29)
  store { %MatchContext*, i64 }* %t30, { %MatchContext*, i64 }** %l0
  br label %merge8
merge8:
  %t31 = phi { %MatchContext*, i64 }* [ %t20, %then6 ], [ %t30, %else7 ]
  store { %MatchContext*, i64 }* %t31, { %MatchContext*, i64 }** %l0
  %t32 = load double, double* %l1
  %t33 = sitofp i64 1 to double
  %t34 = fadd double %t32, %t33
  store double %t34, double* %l1
  br label %loop.latch2
loop.latch2:
  %t35 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t36 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t39 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  ret { %MatchContext*, i64 }* %t39
}

define { %MatchContext*, i64 }* @truncate_match_contexts({ %MatchContext*, i64 }* %values, double %end_index) {
entry:
  %l0 = alloca { %MatchContext*, i64 }*
  %l1 = alloca double
  %t0 = sitofp i64 0 to double
  %t1 = fcmp ole double %end_index, %t0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = alloca [0 x %MatchContext]
  %t3 = getelementptr [0 x %MatchContext], [0 x %MatchContext]* %t2, i32 0, i32 0
  %t4 = alloca { %MatchContext*, i64 }
  %t5 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t4, i32 0, i32 0
  store %MatchContext* %t3, %MatchContext** %t5
  %t6 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t4, i32 0, i32 1
  store i64 0, i64* %t6
  ret { %MatchContext*, i64 }* %t4
merge1:
  %t7 = alloca [0 x %MatchContext]
  %t8 = getelementptr [0 x %MatchContext], [0 x %MatchContext]* %t7, i32 0, i32 0
  %t9 = alloca { %MatchContext*, i64 }
  %t10 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t9, i32 0, i32 0
  store %MatchContext* %t8, %MatchContext** %t10
  %t11 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { %MatchContext*, i64 }* %t9, { %MatchContext*, i64 }** %l0
  %t12 = sitofp i64 0 to double
  store double %t12, double* %l1
  %t13 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t14 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t34 = phi { %MatchContext*, i64 }* [ %t13, %entry ], [ %t32, %loop.latch4 ]
  %t35 = phi double [ %t14, %entry ], [ %t33, %loop.latch4 ]
  store { %MatchContext*, i64 }* %t34, { %MatchContext*, i64 }** %l0
  store double %t35, double* %l1
  br label %loop.body3
loop.body3:
  %t15 = load double, double* %l1
  %t16 = fcmp oge double %t15, %end_index
  %t17 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t18 = load double, double* %l1
  br i1 %t16, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t19 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t20 = load double, double* %l1
  %t21 = fptosi double %t20 to i64
  %t22 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %values
  %t23 = extractvalue { %MatchContext*, i64 } %t22, 0
  %t24 = extractvalue { %MatchContext*, i64 } %t22, 1
  %t25 = icmp uge i64 %t21, %t24
  ; bounds check: %t25 (if true, out of bounds)
  %t26 = getelementptr %MatchContext, %MatchContext* %t23, i64 %t21
  %t27 = load %MatchContext, %MatchContext* %t26
  %t28 = call { %MatchContext*, i64 }* @append_match_context({ %MatchContext*, i64 }* %t19, %MatchContext %t27)
  store { %MatchContext*, i64 }* %t28, { %MatchContext*, i64 }** %l0
  %t29 = load double, double* %l1
  %t30 = sitofp i64 1 to double
  %t31 = fadd double %t29, %t30
  store double %t31, double* %l1
  br label %loop.latch4
loop.latch4:
  %t32 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t33 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t36 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  ret { %MatchContext*, i64 }* %t36
}

define i8* @generate_match_subject_name(double %counter) {
entry:
  %s0 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h1077944870, i32 0, i32 0
  %t1 = call i8* @number_to_string(double %counter)
  %t2 = call i8* @sailfin_runtime_string_concat(i8* %s0, i8* %t1)
  ret i8* %t2
}

define %LoweredCaseCondition @lower_match_case_condition(i8* %subject_name, i8* %pattern, i8* %guard) {
entry:
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
  br label %merge3
merge3:
  %t12 = phi i8* [ %t11, %then2 ], [ %t9, %then0 ]
  store i8* %t12, i8** %l1
  br label %merge1
merge1:
  %t13 = phi i8* [ %t11, %then0 ], [ %t3, %entry ]
  store i8* %t13, i8** %l1
  %t15 = load i8*, i8** %l0
  %t16 = call i64 @sailfin_runtime_string_length(i8* %t15)
  %t17 = icmp eq i64 %t16, 0
  br label %logical_or_entry_14

logical_or_entry_14:
  br i1 %t17, label %logical_or_merge_14, label %logical_or_right_14

logical_or_right_14:
  %t18 = load i8*, i8** %l0
  %t19 = load i8, i8* %t18
  %t20 = icmp eq i8 %t19, 95
  br label %logical_or_right_end_14

logical_or_right_end_14:
  br label %logical_or_merge_14

logical_or_merge_14:
  %t21 = phi i1 [ true, %logical_or_entry_14 ], [ %t20, %logical_or_right_end_14 ]
  %t22 = load i8*, i8** %l0
  %t23 = load i8*, i8** %l1
  br i1 %t21, label %then4, label %merge5
then4:
  %t24 = load i8*, i8** %l1
  %t25 = icmp eq i8* %t24, null
  %t26 = load i8*, i8** %l0
  %t27 = load i8*, i8** %l1
  br i1 %t25, label %then6, label %merge7
then6:
  %s28 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h237997259, i32 0, i32 0
  %t29 = insertvalue %LoweredCaseCondition undef, i8* %s28, 0
  %t30 = insertvalue %LoweredCaseCondition %t29, i1 1, 1
  %t31 = insertvalue %LoweredCaseCondition %t30, i1 0, 2
  ret %LoweredCaseCondition %t31
merge7:
  %t32 = load i8*, i8** %l1
  %t33 = call i8* @lower_expression(i8* %t32)
  store i8* %t33, i8** %l3
  %t34 = load i8*, i8** %l3
  %t35 = insertvalue %LoweredCaseCondition undef, i8* %t34, 0
  %t36 = insertvalue %LoweredCaseCondition %t35, i1 0, 1
  %t37 = insertvalue %LoweredCaseCondition %t36, i1 1, 2
  ret %LoweredCaseCondition %t37
merge5:
  %t38 = load i8*, i8** %l0
  %t39 = call i8* @lower_expression(i8* %t38)
  store i8* %t39, i8** %l4
  %s40 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h174361445, i32 0, i32 0
  %t41 = call i8* @sailfin_runtime_string_concat(i8* %subject_name, i8* %s40)
  %t42 = load i8*, i8** %l4
  %t43 = call i8* @sailfin_runtime_string_concat(i8* %t41, i8* %t42)
  store i8* %t43, i8** %l5
  store i1 0, i1* %l6
  %t44 = load i8*, i8** %l1
  %t45 = icmp ne i8* %t44, null
  %t46 = load i8*, i8** %l0
  %t47 = load i8*, i8** %l1
  %t48 = load i8*, i8** %l4
  %t49 = load i8*, i8** %l5
  %t50 = load i1, i1* %l6
  br i1 %t45, label %then8, label %merge9
then8:
  %t51 = load i8*, i8** %l1
  %t52 = call i8* @lower_expression(i8* %t51)
  store i8* %t52, i8** %l7
  %t53 = load i8*, i8** %l5
  %t54 = load i8, i8* %t53
  %t55 = add i8 40, %t54
  %s56 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h1543377657, i32 0, i32 0
  %t57 = load i8, i8* %s56
  %t58 = add i8 %t55, %t57
  %t59 = load i8*, i8** %l7
  %t60 = load i8, i8* %t59
  %t61 = add i8 %t58, %t60
  %t62 = add i8 %t61, 41
  %t63 = alloca [2 x i8], align 1
  %t64 = getelementptr [2 x i8], [2 x i8]* %t63, i32 0, i32 0
  store i8 %t62, i8* %t64
  %t65 = getelementptr [2 x i8], [2 x i8]* %t63, i32 0, i32 1
  store i8 0, i8* %t65
  %t66 = getelementptr [2 x i8], [2 x i8]* %t63, i32 0, i32 0
  store i8* %t66, i8** %l5
  store i1 1, i1* %l6
  br label %merge9
merge9:
  %t67 = phi i8* [ %t66, %then8 ], [ %t49, %entry ]
  %t68 = phi i1 [ 1, %then8 ], [ %t50, %entry ]
  store i8* %t67, i8** %l5
  store i1 %t68, i1* %l6
  %t69 = load i8*, i8** %l5
  %t70 = insertvalue %LoweredCaseCondition undef, i8* %t69, 0
  %t71 = insertvalue %LoweredCaseCondition %t70, i1 0, 1
  %t72 = load i1, i1* %l6
  %t73 = insertvalue %LoweredCaseCondition %t71, i1 %t72, 2
  ret %LoweredCaseCondition %t73
}

define i8* @number_to_string(double %value) {
entry:
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
  %t57 = phi i8* [ %t10, %entry ], [ %t55, %loop.latch4 ]
  %t58 = phi double [ %t9, %entry ], [ %t56, %loop.latch4 ]
  store i8* %t57, i8** %l2
  store double %t58, double* %l1
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
  %t40 = phi double [ %t22, %loop.body3 ], [ %t38, %loop.latch10 ]
  %t41 = phi double [ %t23, %loop.body3 ], [ %t39, %loop.latch10 ]
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
  store double %t42, double* %l5
  %t43 = load i8*, i8** %l0
  %t44 = load double, double* %l5
  %t45 = load double, double* %l5
  %t46 = sitofp i64 1 to double
  %t47 = fadd double %t45, %t46
  %t48 = fptosi double %t44 to i64
  %t49 = fptosi double %t47 to i64
  %t50 = call i8* @sailfin_runtime_substring(i8* %t43, i64 %t48, i64 %t49)
  store i8* %t50, i8** %l6
  %t51 = load i8*, i8** %l6
  %t52 = load i8*, i8** %l2
  %t53 = call i8* @sailfin_runtime_string_concat(i8* %t51, i8* %t52)
  store i8* %t53, i8** %l2
  %t54 = load double, double* %l4
  store double %t54, double* %l1
  br label %loop.latch4
loop.latch4:
  %t55 = load i8*, i8** %l2
  %t56 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t59 = load i8*, i8** %l2
  ret i8* %t59
}

define { i8**, i64 }* @render_python_parameters({ %NativeParameter*, i64 }* %parameters) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca %NativeParameter
  %l3 = alloca i8*
  %t0 = load { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %parameters
  %t1 = extractvalue { %NativeParameter*, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  %t3 = alloca [0 x i8*]
  %t4 = getelementptr [0 x i8*], [0 x i8*]* %t3, i32 0, i32 0
  %t5 = alloca { i8**, i64 }
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 0
  store i8** %t4, i8*** %t6
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 1
  store i64 0, i64* %t7
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
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t15 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t55 = phi { i8**, i64 }* [ %t14, %entry ], [ %t53, %loop.latch4 ]
  %t56 = phi double [ %t15, %entry ], [ %t54, %loop.latch4 ]
  store { i8**, i64 }* %t55, { i8**, i64 }** %l0
  store double %t56, double* %l1
  br label %loop.body3
loop.body3:
  %t16 = load double, double* %l1
  %t17 = load { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %parameters
  %t18 = extractvalue { %NativeParameter*, i64 } %t17, 1
  %t19 = sitofp i64 %t18 to double
  %t20 = fcmp oge double %t16, %t19
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t22 = load double, double* %l1
  br i1 %t20, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t23 = load double, double* %l1
  %t24 = fptosi double %t23 to i64
  %t25 = load { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %parameters
  %t26 = extractvalue { %NativeParameter*, i64 } %t25, 0
  %t27 = extractvalue { %NativeParameter*, i64 } %t25, 1
  %t28 = icmp uge i64 %t24, %t27
  ; bounds check: %t28 (if true, out of bounds)
  %t29 = getelementptr %NativeParameter, %NativeParameter* %t26, i64 %t24
  %t30 = load %NativeParameter, %NativeParameter* %t29
  store %NativeParameter %t30, %NativeParameter* %l2
  %t31 = load %NativeParameter, %NativeParameter* %l2
  %t32 = extractvalue %NativeParameter %t31, 0
  store i8* %t32, i8** %l3
  %t33 = load %NativeParameter, %NativeParameter* %l2
  %t34 = extractvalue %NativeParameter %t33, 3
  %t35 = icmp ne i8* %t34, null
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t37 = load double, double* %l1
  %t38 = load %NativeParameter, %NativeParameter* %l2
  %t39 = load i8*, i8** %l3
  br i1 %t35, label %then8, label %merge9
then8:
  %t40 = load i8*, i8** %l3
  %s41 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087691079, i32 0, i32 0
  %t42 = call i8* @sailfin_runtime_string_concat(i8* %t40, i8* %s41)
  %t43 = load %NativeParameter, %NativeParameter* %l2
  %t44 = extractvalue %NativeParameter %t43, 3
  %t45 = call i8* @sailfin_runtime_string_concat(i8* %t42, i8* %t44)
  store i8* %t45, i8** %l3
  br label %merge9
merge9:
  %t46 = phi i8* [ %t45, %then8 ], [ %t39, %loop.body3 ]
  store i8* %t46, i8** %l3
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t48 = load i8*, i8** %l3
  %t49 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t47, i8* %t48)
  store { i8**, i64 }* %t49, { i8**, i64 }** %l0
  %t50 = load double, double* %l1
  %t51 = sitofp i64 1 to double
  %t52 = fadd double %t50, %t51
  store double %t52, double* %l1
  br label %loop.latch4
loop.latch4:
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t54 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t57
}

define %PythonBuilder @builder_new() {
entry:
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  %t5 = insertvalue %PythonBuilder undef, { i8**, i64 }* %t2, 0
  %t6 = sitofp i64 0 to double
  %t7 = insertvalue %PythonBuilder %t5, double %t6, 1
  ret %PythonBuilder %t7
}

define %PythonBuilder @builder_emit(%PythonBuilder %builder, i8* %line) {
entry:
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
  %t20 = phi i8* [ %t5, %entry ], [ %t18, %loop.latch4 ]
  %t21 = phi double [ %t6, %entry ], [ %t19, %loop.latch4 ]
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
  %t23 = call i8* @sailfin_runtime_string_concat(i8* %t22, i8* %line)
  store i8* %t23, i8** %l2
  %t24 = extractvalue %PythonBuilder %builder, 0
  %t25 = load i8*, i8** %l2
  %t26 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t24, i8* %t25)
  store { i8**, i64 }* %t26, { i8**, i64 }** %l3
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t28 = insertvalue %PythonBuilder undef, { i8**, i64 }* %t27, 0
  %t29 = extractvalue %PythonBuilder %builder, 1
  %t30 = insertvalue %PythonBuilder %t28, double %t29, 1
  ret %PythonBuilder %t30
}

define %PythonBuilder @builder_emit_blank(%PythonBuilder %builder) {
entry:
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
entry:
  %t0 = extractvalue %PythonBuilder %builder, 0
  %t1 = insertvalue %PythonBuilder undef, { i8**, i64 }* %t0, 0
  %t2 = extractvalue %PythonBuilder %builder, 1
  %t3 = sitofp i64 1 to double
  %t4 = fadd double %t2, %t3
  %t5 = insertvalue %PythonBuilder %t1, double %t4, 1
  ret %PythonBuilder %t5
}

define %PythonBuilder @builder_pop_indent(%PythonBuilder %builder) {
entry:
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
  br label %merge1
merge1:
  %t8 = phi double [ %t7, %then0 ], [ %t4, %entry ]
  store double %t8, double* %l0
  %t9 = extractvalue %PythonBuilder %builder, 0
  %t10 = insertvalue %PythonBuilder undef, { i8**, i64 }* %t9, 0
  %t11 = load double, double* %l0
  %t12 = insertvalue %PythonBuilder %t10, double %t11, 1
  ret %PythonBuilder %t12
}

define i8* @builder_to_string(%PythonBuilder %builder) {
entry:
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
  %t12 = load i8, i8* %t11
  %t13 = add i8 %t12, 10
  %t14 = alloca [2 x i8], align 1
  %t15 = getelementptr [2 x i8], [2 x i8]* %t14, i32 0, i32 0
  store i8 %t13, i8* %t15
  %t16 = getelementptr [2 x i8], [2 x i8]* %t14, i32 0, i32 1
  store i8 0, i8* %t16
  %t17 = getelementptr [2 x i8], [2 x i8]* %t14, i32 0, i32 0
  ret i8* %t17
}

define i8* @sanitize_identifier(i8* %name) {
entry:
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
  %t50 = phi i8* [ %t2, %entry ], [ %t48, %loop.latch2 ]
  %t51 = phi double [ %t3, %entry ], [ %t49, %loop.latch2 ]
  store i8* %t50, i8** %l0
  store double %t51, double* %l1
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
  %t25 = load i8, i8* %t23
  %t26 = add i8 %t25, %t24
  %t27 = alloca [2 x i8], align 1
  %t28 = getelementptr [2 x i8], [2 x i8]* %t27, i32 0, i32 0
  store i8 %t26, i8* %t28
  %t29 = getelementptr [2 x i8], [2 x i8]* %t27, i32 0, i32 1
  store i8 0, i8* %t29
  %t30 = getelementptr [2 x i8], [2 x i8]* %t27, i32 0, i32 0
  store i8* %t30, i8** %l0
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
  %t37 = load i8, i8* %t36
  %t38 = add i8 %t37, 95
  %t39 = alloca [2 x i8], align 1
  %t40 = getelementptr [2 x i8], [2 x i8]* %t39, i32 0, i32 0
  store i8 %t38, i8* %t40
  %t41 = getelementptr [2 x i8], [2 x i8]* %t39, i32 0, i32 1
  store i8 0, i8* %t41
  %t42 = getelementptr [2 x i8], [2 x i8]* %t39, i32 0, i32 0
  store i8* %t42, i8** %l0
  br label %merge10
merge10:
  %t43 = phi i8* [ %t42, %then9 ], [ %t33, %else7 ]
  store i8* %t43, i8** %l0
  br label %merge8
merge8:
  %t44 = phi i8* [ %t30, %then6 ], [ %t42, %else7 ]
  store i8* %t44, i8** %l0
  %t45 = load double, double* %l1
  %t46 = sitofp i64 1 to double
  %t47 = fadd double %t45, %t46
  store double %t47, double* %l1
  br label %loop.latch2
loop.latch2:
  %t48 = load i8*, i8** %l0
  %t49 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t52 = load i8*, i8** %l0
  %t53 = call i64 @sailfin_runtime_string_length(i8* %t52)
  %t54 = icmp eq i64 %t53, 0
  %t55 = load i8*, i8** %l0
  %t56 = load double, double* %l1
  br i1 %t54, label %then11, label %merge12
then11:
  %s57 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.len18.h1387621460, i32 0, i32 0
  ret i8* %s57
merge12:
  %t58 = load i8*, i8** %l0
  ret i8* %t58
}

define i8* @sanitize_qualified_identifier(i8* %name) {
entry:
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
  %t8 = alloca [0 x i8*]
  %t9 = getelementptr [0 x i8*], [0 x i8*]* %t8, i32 0, i32 0
  %t10 = alloca { i8**, i64 }
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 0
  store i8** %t9, i8*** %t11
  %t12 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 1
  store i64 0, i64* %t12
  store { i8**, i64 }* %t10, { i8**, i64 }** %l2
  %t13 = sitofp i64 0 to double
  store double %t13, double* %l3
  %t14 = load i8*, i8** %l0
  %t15 = load i8*, i8** %l1
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t17 = load double, double* %l3
  br label %loop.header2
loop.header2:
  %t70 = phi { i8**, i64 }* [ %t16, %entry ], [ %t67, %loop.latch4 ]
  %t71 = phi i8* [ %t15, %entry ], [ %t68, %loop.latch4 ]
  %t72 = phi double [ %t17, %entry ], [ %t69, %loop.latch4 ]
  store { i8**, i64 }* %t70, { i8**, i64 }** %l2
  store i8* %t71, i8** %l1
  store double %t72, double* %l3
  br label %loop.body3
loop.body3:
  %t18 = load double, double* %l3
  %t19 = load i8*, i8** %l0
  %t20 = call i64 @sailfin_runtime_string_length(i8* %t19)
  %t21 = sitofp i64 %t20 to double
  %t22 = fcmp oge double %t18, %t21
  %t23 = load i8*, i8** %l0
  %t24 = load i8*, i8** %l1
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t26 = load double, double* %l3
  br i1 %t22, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t27 = load i8*, i8** %l0
  %t28 = load double, double* %l3
  %t29 = fptosi double %t28 to i64
  %t30 = getelementptr i8, i8* %t27, i64 %t29
  %t31 = load i8, i8* %t30
  store i8 %t31, i8* %l4
  %t32 = load i8, i8* %l4
  %t33 = icmp eq i8 %t32, 46
  %t34 = load i8*, i8** %l0
  %t35 = load i8*, i8** %l1
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t37 = load double, double* %l3
  %t38 = load i8, i8* %l4
  br i1 %t33, label %then8, label %else9
then8:
  %t39 = load i8*, i8** %l1
  %t40 = call i64 @sailfin_runtime_string_length(i8* %t39)
  %t41 = icmp sgt i64 %t40, 0
  %t42 = load i8*, i8** %l0
  %t43 = load i8*, i8** %l1
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t45 = load double, double* %l3
  %t46 = load i8, i8* %l4
  br i1 %t41, label %then11, label %merge12
then11:
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t48 = load i8*, i8** %l1
  %t49 = call i8* @sanitize_identifier(i8* %t48)
  %t50 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t47, i8* %t49)
  store { i8**, i64 }* %t50, { i8**, i64 }** %l2
  %s51 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s51, i8** %l1
  br label %merge12
merge12:
  %t52 = phi { i8**, i64 }* [ %t50, %then11 ], [ %t44, %then8 ]
  %t53 = phi i8* [ %s51, %then11 ], [ %t43, %then8 ]
  store { i8**, i64 }* %t52, { i8**, i64 }** %l2
  store i8* %t53, i8** %l1
  br label %merge10
else9:
  %t54 = load i8*, i8** %l1
  %t55 = load i8, i8* %l4
  %t56 = load i8, i8* %t54
  %t57 = add i8 %t56, %t55
  %t58 = alloca [2 x i8], align 1
  %t59 = getelementptr [2 x i8], [2 x i8]* %t58, i32 0, i32 0
  store i8 %t57, i8* %t59
  %t60 = getelementptr [2 x i8], [2 x i8]* %t58, i32 0, i32 1
  store i8 0, i8* %t60
  %t61 = getelementptr [2 x i8], [2 x i8]* %t58, i32 0, i32 0
  store i8* %t61, i8** %l1
  br label %merge10
merge10:
  %t62 = phi { i8**, i64 }* [ %t50, %then8 ], [ %t36, %else9 ]
  %t63 = phi i8* [ %s51, %then8 ], [ %t61, %else9 ]
  store { i8**, i64 }* %t62, { i8**, i64 }** %l2
  store i8* %t63, i8** %l1
  %t64 = load double, double* %l3
  %t65 = sitofp i64 1 to double
  %t66 = fadd double %t64, %t65
  store double %t66, double* %l3
  br label %loop.latch4
loop.latch4:
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t68 = load i8*, i8** %l1
  %t69 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t73 = load i8*, i8** %l1
  %t74 = call i64 @sailfin_runtime_string_length(i8* %t73)
  %t75 = icmp sgt i64 %t74, 0
  %t76 = load i8*, i8** %l0
  %t77 = load i8*, i8** %l1
  %t78 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t79 = load double, double* %l3
  br i1 %t75, label %then13, label %merge14
then13:
  %t80 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t81 = load i8*, i8** %l1
  %t82 = call i8* @sanitize_identifier(i8* %t81)
  %t83 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t80, i8* %t82)
  store { i8**, i64 }* %t83, { i8**, i64 }** %l2
  br label %merge14
merge14:
  %t84 = phi { i8**, i64 }* [ %t83, %then13 ], [ %t78, %entry ]
  store { i8**, i64 }* %t84, { i8**, i64 }** %l2
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t86 = load { i8**, i64 }, { i8**, i64 }* %t85
  %t87 = extractvalue { i8**, i64 } %t86, 1
  %t88 = icmp eq i64 %t87, 0
  %t89 = load i8*, i8** %l0
  %t90 = load i8*, i8** %l1
  %t91 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t92 = load double, double* %l3
  br i1 %t88, label %then15, label %merge16
then15:
  %t93 = load i8*, i8** %l0
  %t94 = call i8* @sanitize_identifier(i8* %t93)
  ret i8* %t94
merge16:
  %t95 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t96 = alloca [2 x i8], align 1
  %t97 = getelementptr [2 x i8], [2 x i8]* %t96, i32 0, i32 0
  store i8 46, i8* %t97
  %t98 = getelementptr [2 x i8], [2 x i8]* %t96, i32 0, i32 1
  store i8 0, i8* %t98
  %t99 = getelementptr [2 x i8], [2 x i8]* %t96, i32 0, i32 0
  %t100 = call i8* @join_with_separator({ i8**, i64 }* %t95, i8* %t99)
  ret i8* %t100
}

define i1 @is_identifier_char(i8* %ch) {
entry:
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
entry:
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
entry:
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
  %t42 = phi double [ %t3, %entry ], [ %t41, %loop.latch2 ]
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
  %t44 = load double, double* %l1
  br label %loop.header8
loop.header8:
  %t86 = phi double [ %t44, %entry ], [ %t85, %loop.latch10 ]
  store double %t86, double* %l1
  br label %loop.body9
loop.body9:
  %t45 = load double, double* %l1
  %t46 = load double, double* %l0
  %t47 = fcmp ole double %t45, %t46
  %t48 = load double, double* %l0
  %t49 = load double, double* %l1
  br i1 %t47, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t50 = load double, double* %l1
  %t51 = sitofp i64 1 to double
  %t52 = fsub double %t50, %t51
  store double %t52, double* %l3
  %t53 = load double, double* %l3
  %t54 = load double, double* %l3
  %t55 = sitofp i64 1 to double
  %t56 = fadd double %t54, %t55
  %t57 = fptosi double %t53 to i64
  %t58 = fptosi double %t56 to i64
  %t59 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t57, i64 %t58)
  store i8* %t59, i8** %l4
  %t61 = load i8*, i8** %l4
  %t62 = load i8, i8* %t61
  %t63 = icmp eq i8 %t62, 32
  br label %logical_or_entry_60

logical_or_entry_60:
  br i1 %t63, label %logical_or_merge_60, label %logical_or_right_60

logical_or_right_60:
  %t65 = load i8*, i8** %l4
  %t66 = load i8, i8* %t65
  %t67 = icmp eq i8 %t66, 10
  br label %logical_or_entry_64

logical_or_entry_64:
  br i1 %t67, label %logical_or_merge_64, label %logical_or_right_64

logical_or_right_64:
  %t69 = load i8*, i8** %l4
  %t70 = load i8, i8* %t69
  %t71 = icmp eq i8 %t70, 13
  br label %logical_or_entry_68

logical_or_entry_68:
  br i1 %t71, label %logical_or_merge_68, label %logical_or_right_68

logical_or_right_68:
  %t72 = load i8*, i8** %l4
  %t73 = load i8, i8* %t72
  %t74 = icmp eq i8 %t73, 9
  br label %logical_or_right_end_68

logical_or_right_end_68:
  br label %logical_or_merge_68

logical_or_merge_68:
  %t75 = phi i1 [ true, %logical_or_entry_68 ], [ %t74, %logical_or_right_end_68 ]
  br label %logical_or_right_end_64

logical_or_right_end_64:
  br label %logical_or_merge_64

logical_or_merge_64:
  %t76 = phi i1 [ true, %logical_or_entry_64 ], [ %t75, %logical_or_right_end_64 ]
  br label %logical_or_right_end_60

logical_or_right_end_60:
  br label %logical_or_merge_60

logical_or_merge_60:
  %t77 = phi i1 [ true, %logical_or_entry_60 ], [ %t76, %logical_or_right_end_60 ]
  %t78 = load double, double* %l0
  %t79 = load double, double* %l1
  %t80 = load double, double* %l3
  %t81 = load i8*, i8** %l4
  br i1 %t77, label %then14, label %merge15
then14:
  %t82 = load double, double* %l1
  %t83 = sitofp i64 1 to double
  %t84 = fsub double %t82, %t83
  store double %t84, double* %l1
  br label %loop.latch10
merge15:
  br label %afterloop11
loop.latch10:
  %t85 = load double, double* %l1
  br label %loop.header8
afterloop11:
  %t88 = load double, double* %l0
  %t89 = sitofp i64 0 to double
  %t90 = fcmp oeq double %t88, %t89
  br label %logical_and_entry_87

logical_and_entry_87:
  br i1 %t90, label %logical_and_right_87, label %logical_and_merge_87

logical_and_right_87:
  %t91 = load double, double* %l1
  %t92 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t93 = sitofp i64 %t92 to double
  %t94 = fcmp oeq double %t91, %t93
  br label %logical_and_right_end_87

logical_and_right_end_87:
  br label %logical_and_merge_87

logical_and_merge_87:
  %t95 = phi i1 [ false, %logical_and_entry_87 ], [ %t94, %logical_and_right_end_87 ]
  %t96 = load double, double* %l0
  %t97 = load double, double* %l1
  br i1 %t95, label %then16, label %merge17
then16:
  ret i8* %value
merge17:
  %t98 = load double, double* %l0
  %t99 = load double, double* %l1
  %t100 = fptosi double %t98 to i64
  %t101 = fptosi double %t99 to i64
  %t102 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t100, i64 %t101)
  ret i8* %t102
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

define i1 @ends_with(i8* %value, i8* %suffix) {
entry:
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
  %t31 = phi double [ %t6, %entry ], [ %t30, %loop.latch6 ]
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
  ret i1 1
}

define i8* @replace_all(i8* %value, i8* %target, i8* %replacement) {
entry:
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
  %t78 = phi i8* [ %t4, %entry ], [ %t76, %loop.latch4 ]
  %t79 = phi double [ %t5, %entry ], [ %t77, %loop.latch4 ]
  store i8* %t78, i8** %l0
  store double %t79, double* %l1
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
  %t57 = load i8*, i8** %l0
  %t58 = load double, double* %l1
  %t59 = load i1, i1* %l2
  %t60 = load double, double* %l3
  br i1 %t56, label %then18, label %merge19
then18:
  %t61 = load i8*, i8** %l0
  %t62 = call i8* @sailfin_runtime_string_concat(i8* %t61, i8* %replacement)
  store i8* %t62, i8** %l0
  %t63 = load double, double* %l1
  %t64 = call i64 @sailfin_runtime_string_length(i8* %target)
  %t65 = sitofp i64 %t64 to double
  %t66 = fadd double %t63, %t65
  store double %t66, double* %l1
  br label %loop.latch4
merge19:
  br label %merge9
merge9:
  %t67 = phi i8* [ %t62, %then8 ], [ %t19, %loop.body3 ]
  %t68 = phi double [ %t66, %then8 ], [ %t20, %loop.body3 ]
  store i8* %t67, i8** %l0
  store double %t68, double* %l1
  %t69 = load i8*, i8** %l0
  %t70 = load double, double* %l1
  %t71 = call i8* @char_at(i8* %value, double %t70)
  %t72 = call i8* @sailfin_runtime_string_concat(i8* %t69, i8* %t71)
  store i8* %t72, i8** %l0
  %t73 = load double, double* %l1
  %t74 = sitofp i64 1 to double
  %t75 = fadd double %t73, %t74
  store double %t75, double* %l1
  br label %loop.latch4
loop.latch4:
  %t76 = load i8*, i8** %l0
  %t77 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t80 = load i8*, i8** %l0
  ret i8* %t80
}

define i8* @join_with_separator({ i8**, i64 }* %values, i8* %separator) {
entry:
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
  %t8 = getelementptr i8*, i8** %t5, i64 0
  %t9 = load i8*, i8** %t8
  store i8* %t9, i8** %l0
  %t10 = sitofp i64 1 to double
  store double %t10, double* %l1
  %t11 = load i8*, i8** %l0
  %t12 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t36 = phi i8* [ %t11, %entry ], [ %t34, %loop.latch4 ]
  %t37 = phi double [ %t12, %entry ], [ %t35, %loop.latch4 ]
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
  ret i8* %t38
}

define { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %diagnostics, i8* %function_name, i8* %detail) {
entry:
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
  br label %merge2
else1:
  %t9 = load i8*, i8** %l1
  %t10 = load i8*, i8** %l0
  %t11 = call i8* @sailfin_runtime_string_concat(i8* %t9, i8* %t10)
  %s12 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193441217, i32 0, i32 0
  %t13 = call i8* @sailfin_runtime_string_concat(i8* %t11, i8* %s12)
  %t14 = call i8* @sailfin_runtime_string_concat(i8* %t13, i8* %detail)
  store i8* %t14, i8** %l1
  br label %merge2
merge2:
  %t15 = phi i8* [ %t8, %then0 ], [ %t14, %else1 ]
  store i8* %t15, i8** %l1
  %t16 = load i8*, i8** %l1
  %t17 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %diagnostics, i8* %t16)
  ret { i8**, i64 }* %t17
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

define i8* @char_at(i8* %value, double %index) {
entry:
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