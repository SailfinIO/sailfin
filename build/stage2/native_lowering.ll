; ModuleID = 'sailfin'
source_filename = "sailfin"

%LoweredPythonResult = type { i8*, { i8**, i64 }* }
%MatchContext = type { i8*, double, i1 }
%LoweredCaseCondition = type { i8*, i1, i1 }
%PythonModuleEmission = type { %PythonBuilder*, { i8**, i64 }* }
%PythonFunctionEmission = type { %PythonBuilder*, { i8**, i64 }* }
%PythonImportEmission = type { %PythonBuilder*, { i8**, i64 }* }
%PythonStructEmission = type { %PythonBuilder*, { i8**, i64 }* }
%StructLiteralCapture = type { i8*, double, i1 }
%ExpressionContinuationCapture = type { i8*, double, i1 }
%ExtractedSpan = type { i8*, double, double, i1 }
%PythonBuilder = type { { i8**, i64 }*, double }
%NativeArtifact = type { i8*, i8*, i8* }
%NativeModule = type { { %NativeArtifact**, i64 }*, { i8**, i64 }*, double }
%EmitNativeResult = type { %NativeModule*, { i8**, i64 }* }
%TextBuilder = type { { i8**, i64 }*, double }
%NativeState = type { %TextBuilder*, { i8**, i64 }*, %LayoutContext* }
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
%InterfaceSignatureParse = type { i1, %NativeInterfaceSignature*, { i8**, i64 }* }
%StructHeaderParse = type { i8*, { i8**, i64 }*, { i8**, i64 }* }
%InterfaceHeaderParse = type { i8*, { i8**, i64 }*, { i8**, i64 }* }
%HeaderNameParse = type { i8*, { i8**, i64 }*, i8*, { i8**, i64 }* }
%StructLayoutHeaderParse = type { i1, i8*, double, double, { i8**, i64 }* }
%StructLayoutFieldParse = type { i1, %NativeStructLayoutField*, { i8**, i64 }* }
%ParseNativeResult = type { { %NativeFunction**, i64 }*, { %NativeImport**, i64 }*, { %NativeStruct**, i64 }*, { %NativeInterface**, i64 }*, { %NativeEnum**, i64 }*, { %NativeBinding**, i64 }*, { i8**, i64 }* }
%EnumLayoutHeaderParse = type { i1, i8*, double, double, i8*, double, double, { i8**, i64 }* }
%EnumLayoutVariantParse = type { i1, %NativeEnumVariantLayout*, { i8**, i64 }* }
%EnumLayoutPayloadParse = type { i1, i8*, %NativeStructLayoutField*, { i8**, i64 }* }
%NumberParseResult = type { i1, double }
%LayoutManifest = type { { %NativeStruct**, i64 }*, { %NativeEnum**, i64 }*, { i8**, i64 }* }
%BindingComponents = type { i8*, i8*, i8* }

%NativeInstruction = type { i32, [48 x i8] }

declare i8* @sailfin_runtime_substring(i8*, i64, i64)
declare i1 @sailfin_runtime_is_whitespace_char(i8)
declare { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }*, i8*)

declare noalias i8* @malloc(i64)

@.str.7 = private unnamed_addr constant [15 x i8] c"import asyncio\00"
@.str.10 = private unnamed_addr constant [47 x i8] c"from runtime import runtime_support as runtime\00"
@.str.1 = private unnamed_addr constant [24 x i8] c"print = runtime.console\00"
@.str.4 = private unnamed_addr constant [22 x i8] c"sleep = runtime.sleep\00"
@.str.13 = private unnamed_addr constant [22 x i8] c"spawn = runtime.spawn\00"
@.str.16 = private unnamed_addr constant [16 x i8] c"fs = runtime.fs\00"
@.str.19 = private unnamed_addr constant [22 x i8] c"serve = runtime.serve\00"
@.str.22 = private unnamed_addr constant [20 x i8] c"http = runtime.http\00"
@.str.25 = private unnamed_addr constant [30 x i8] c"websocket = runtime.websocket\00"
@.str.28 = private unnamed_addr constant [36 x i8] c"logExecution = runtime.logExecution\00"
@.str.31 = private unnamed_addr constant [30 x i8] c"array_map = runtime.array_map\00"
@.str.34 = private unnamed_addr constant [36 x i8] c"array_filter = runtime.array_filter\00"
@.str.37 = private unnamed_addr constant [36 x i8] c"array_reduce = runtime.array_reduce\00"
@.str.40 = private unnamed_addr constant [30 x i8] c"globals()['t' + 'rue'] = True\00"
@.str.43 = private unnamed_addr constant [32 x i8] c"globals()['f' + 'alse'] = False\00"
@.str.3 = private unnamed_addr constant [23 x i8] c" = runtime.enum_type('\00"
@.str.47 = private unnamed_addr constant [3 x i8] c", \00"
@.str.18 = private unnamed_addr constant [6 x i8] c"from \00"
@.str.21 = private unnamed_addr constant [9 x i8] c" import \00"
@.str.12 = private unnamed_addr constant [5 x i8] c" as \00"
@.str.126 = private unnamed_addr constant [12 x i8] c"__all__ = [\00"
@.str.128 = private unnamed_addr constant [3 x i8] c", \00"
@.str.2 = private unnamed_addr constant [7 x i8] c"class \00"
@.str.23 = private unnamed_addr constant [18 x i8] c"def __init__(self\00"
@.str.127 = private unnamed_addr constant [20 x i8] c"def __repr__(self):\00"
@.str.56 = private unnamed_addr constant [29 x i8] c"return runtime.struct_repr('\00"
@.str.58 = private unnamed_addr constant [5 x i8] c"', [\00"
@.str.61 = private unnamed_addr constant [3 x i8] c", \00"
@.str.64 = private unnamed_addr constant [3 x i8] c"])\00"
@.str.97 = private unnamed_addr constant [1 x i8] c"\00"
@.str.5 = private unnamed_addr constant [1 x i8] c"\00"
@.str.8 = private unnamed_addr constant [1 x i8] c"\00"
@.str.0 = private unnamed_addr constant [15 x i8] c"__match_value_\00"
@.str.41 = private unnamed_addr constant [5 x i8] c" == \00"
@.str.6 = private unnamed_addr constant [11 x i8] c"0123456789\00"

define %LoweredPythonResult @lower_to_python(%NativeModule %native_module) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* %t2, { i8**, i64 }** %l0
  %t5 = extractvalue %NativeModule %native_module, 0
  %t6 = call double @select_text_artifact({ %NativeArtifact**, i64 }* %t5)
  store double %t6, double* %l1
  %t7 = load double, double* %l1
  %t8 = load double, double* %l1
  store double 0.0, double* %l2
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t10 = load double, double* %l2
  %t11 = load double, double* %l2
  %t12 = load double, double* %l2
  %t13 = load double, double* %l2
  %t14 = load double, double* %l2
  %t15 = load double, double* %l2
  store double 0.0, double* %l3
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t17 = load double, double* %l3
  %t18 = load double, double* %l3
  store double 0.0, double* %l4
  %t19 = load double, double* %l4
  %t20 = insertvalue %LoweredPythonResult undef, i8* null, 0
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t22 = insertvalue %LoweredPythonResult %t20, { i8**, i64 }* %t21, 1
  ret %LoweredPythonResult %t22
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
  %s7 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.7, i32 0, i32 0
  %t8 = call %PythonBuilder @builder_emit(%PythonBuilder %t6, i8* %s7)
  store %PythonBuilder %t8, %PythonBuilder* %l0
  %t9 = load %PythonBuilder, %PythonBuilder* %l0
  %s10 = getelementptr inbounds [47 x i8], [47 x i8]* @.str.10, i32 0, i32 0
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
  store %PythonBuilder zeroinitializer, %PythonBuilder* %l0
  %t29 = load %PythonImportEmission, %PythonImportEmission* %l3
  %t30 = extractvalue %PythonImportEmission %t29, 1
  store { i8**, i64 }* %t30, { i8**, i64 }** %l2
  br label %merge1
merge1:
  %t31 = phi %PythonBuilder [ %t24, %then0 ], [ %t20, %entry ]
  %t32 = phi %PythonBuilder [ zeroinitializer, %then0 ], [ %t20, %entry ]
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
  store %PythonBuilder zeroinitializer, %PythonBuilder* %l0
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t75 = load %PythonStructEmission, %PythonStructEmission* %l4
  %t76 = extractvalue %PythonStructEmission %t75, 1
  %t77 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t74, { i8**, i64 }* %t76)
  store { i8**, i64 }* %t77, { i8**, i64 }** %l1
  br label %merge7
merge7:
  %t78 = phi %PythonBuilder [ %t69, %then6 ], [ %t65, %entry ]
  %t79 = phi %PythonBuilder [ zeroinitializer, %then6 ], [ %t65, %entry ]
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
  store %PythonBuilder zeroinitializer, %PythonBuilder* %l0
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
  %t153 = insertvalue %PythonModuleEmission undef, %PythonBuilder* null, 0
  %t154 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t155 = insertvalue %PythonModuleEmission %t153, { i8**, i64 }* %t154, 1
  ret %PythonModuleEmission %t155
}

define %PythonBuilder @emit_runtime_aliases(%PythonBuilder %builder) {
entry:
  %l0 = alloca %PythonBuilder
  store %PythonBuilder %builder, %PythonBuilder* %l0
  %t0 = load %PythonBuilder, %PythonBuilder* %l0
  %s1 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.1, i32 0, i32 0
  %t2 = call %PythonBuilder @builder_emit(%PythonBuilder %t0, i8* %s1)
  store %PythonBuilder %t2, %PythonBuilder* %l0
  %t3 = load %PythonBuilder, %PythonBuilder* %l0
  %s4 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.4, i32 0, i32 0
  %t5 = call %PythonBuilder @builder_emit(%PythonBuilder %t3, i8* %s4)
  store %PythonBuilder %t5, %PythonBuilder* %l0
  %t6 = load %PythonBuilder, %PythonBuilder* %l0
  %s7 = getelementptr inbounds [26 x i8], [26 x i8]* @.str.7, i32 0, i32 0
  %t8 = call %PythonBuilder @builder_emit(%PythonBuilder %t6, i8* %s7)
  store %PythonBuilder %t8, %PythonBuilder* %l0
  %t9 = load %PythonBuilder, %PythonBuilder* %l0
  %s10 = getelementptr inbounds [28 x i8], [28 x i8]* @.str.10, i32 0, i32 0
  %t11 = call %PythonBuilder @builder_emit(%PythonBuilder %t9, i8* %s10)
  store %PythonBuilder %t11, %PythonBuilder* %l0
  %t12 = load %PythonBuilder, %PythonBuilder* %l0
  %s13 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.13, i32 0, i32 0
  %t14 = call %PythonBuilder @builder_emit(%PythonBuilder %t12, i8* %s13)
  store %PythonBuilder %t14, %PythonBuilder* %l0
  %t15 = load %PythonBuilder, %PythonBuilder* %l0
  %s16 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.16, i32 0, i32 0
  %t17 = call %PythonBuilder @builder_emit(%PythonBuilder %t15, i8* %s16)
  store %PythonBuilder %t17, %PythonBuilder* %l0
  %t18 = load %PythonBuilder, %PythonBuilder* %l0
  %s19 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.19, i32 0, i32 0
  %t20 = call %PythonBuilder @builder_emit(%PythonBuilder %t18, i8* %s19)
  store %PythonBuilder %t20, %PythonBuilder* %l0
  %t21 = load %PythonBuilder, %PythonBuilder* %l0
  %s22 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.22, i32 0, i32 0
  %t23 = call %PythonBuilder @builder_emit(%PythonBuilder %t21, i8* %s22)
  store %PythonBuilder %t23, %PythonBuilder* %l0
  %t24 = load %PythonBuilder, %PythonBuilder* %l0
  %s25 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.25, i32 0, i32 0
  %t26 = call %PythonBuilder @builder_emit(%PythonBuilder %t24, i8* %s25)
  store %PythonBuilder %t26, %PythonBuilder* %l0
  %t27 = load %PythonBuilder, %PythonBuilder* %l0
  %s28 = getelementptr inbounds [36 x i8], [36 x i8]* @.str.28, i32 0, i32 0
  %t29 = call %PythonBuilder @builder_emit(%PythonBuilder %t27, i8* %s28)
  store %PythonBuilder %t29, %PythonBuilder* %l0
  %t30 = load %PythonBuilder, %PythonBuilder* %l0
  %s31 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.31, i32 0, i32 0
  %t32 = call %PythonBuilder @builder_emit(%PythonBuilder %t30, i8* %s31)
  store %PythonBuilder %t32, %PythonBuilder* %l0
  %t33 = load %PythonBuilder, %PythonBuilder* %l0
  %s34 = getelementptr inbounds [36 x i8], [36 x i8]* @.str.34, i32 0, i32 0
  %t35 = call %PythonBuilder @builder_emit(%PythonBuilder %t33, i8* %s34)
  store %PythonBuilder %t35, %PythonBuilder* %l0
  %t36 = load %PythonBuilder, %PythonBuilder* %l0
  %s37 = getelementptr inbounds [36 x i8], [36 x i8]* @.str.37, i32 0, i32 0
  %t38 = call %PythonBuilder @builder_emit(%PythonBuilder %t36, i8* %s37)
  store %PythonBuilder %t38, %PythonBuilder* %l0
  %t39 = load %PythonBuilder, %PythonBuilder* %l0
  %s40 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.40, i32 0, i32 0
  %t41 = call %PythonBuilder @builder_emit(%PythonBuilder %t39, i8* %s40)
  store %PythonBuilder %t41, %PythonBuilder* %l0
  %t42 = load %PythonBuilder, %PythonBuilder* %l0
  %s43 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.43, i32 0, i32 0
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
  %s22 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.22, i32 0, i32 0
  %t23 = add i8* %t21, %s22
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
  %t37 = add i8* %t34, %t36
  store i8* %t37, i8** %l4
  br label %merge8
else7:
  %t38 = load i8*, i8** %l4
  %s39 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.39, i32 0, i32 0
  %t40 = add i8* %t38, %s39
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
  %s27 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.27, i32 0, i32 0
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
  %t78 = insertvalue %PythonImportEmission undef, %PythonBuilder* null, 0
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
  %s3 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.3, i32 0, i32 0
  %t4 = add i8* %t2, %s3
  %t5 = load i8*, i8** %l0
  %t6 = add i8* %t4, %t5
  %s7 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.7, i32 0, i32 0
  %t8 = add i8* %t6, %s7
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
  %s37 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.37, i32 0, i32 0
  %t38 = add i8* %t36, %s37
  %t39 = load i8*, i8** %l0
  %t40 = add i8* %t38, %t39
  %s41 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.41, i32 0, i32 0
  %t42 = add i8* %t40, %s41
  %t43 = load i8*, i8** %l4
  %t44 = add i8* %t42, %t43
  %s45 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.45, i32 0, i32 0
  %t46 = add i8* %t44, %s45
  %t47 = load %NativeEnumVariant*, %NativeEnumVariant** %l3
  %t48 = getelementptr %NativeEnumVariant, %NativeEnumVariant* %t47, i32 0, i32 1
  %t49 = load { %NativeEnumVariantField**, i64 }*, { %NativeEnumVariantField**, i64 }** %t48
  %t50 = bitcast { %NativeEnumVariantField**, i64 }* %t49 to { %NativeEnumVariantField*, i64 }*
  %t51 = call i8* @render_enum_variant_fields({ %NativeEnumVariantField*, i64 }* %t50)
  %t52 = add i8* %t46, %t51
  %s53 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.53, i32 0, i32 0
  %t54 = add i8* %t52, %s53
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
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.3, i32 0, i32 0
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
  %t44 = phi { i8**, i64 }* [ %t10, %entry ], [ %t42, %loop.latch4 ]
  %t45 = phi double [ %t11, %entry ], [ %t43, %loop.latch4 ]
  store { i8**, i64 }* %t44, { i8**, i64 }** %l0
  store double %t45, double* %l1
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
  %t30 = getelementptr i8, i8* %t29, i64 0
  %t31 = load i8, i8* %t30
  %t32 = add i8 39, %t31
  %t33 = add i8 %t32, 39
  %t34 = alloca [2 x i8], align 1
  %t35 = getelementptr [2 x i8], [2 x i8]* %t34, i32 0, i32 0
  store i8 %t33, i8* %t35
  %t36 = getelementptr [2 x i8], [2 x i8]* %t34, i32 0, i32 1
  store i8 0, i8* %t36
  %t37 = getelementptr [2 x i8], [2 x i8]* %t34, i32 0, i32 0
  %t38 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t19, i8* %t37)
  store { i8**, i64 }* %t38, { i8**, i64 }** %l0
  %t39 = load double, double* %l1
  %t40 = sitofp i64 1 to double
  %t41 = fadd double %t39, %t40
  store double %t41, double* %l1
  br label %loop.latch4
loop.latch4:
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t43 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s47 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.47, i32 0, i32 0
  %t48 = call i8* @join_with_separator({ i8**, i64 }* %t46, i8* %s47)
  ret i8* %t48
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
  %s6 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.6, i32 0, i32 0
  ret i8* %s6
merge1:
  %t7 = extractvalue %NativeImport %entry, 2
  %t8 = load { %NativeImportSpecifier**, i64 }, { %NativeImportSpecifier**, i64 }* %t7
  %t9 = extractvalue { %NativeImportSpecifier**, i64 } %t8, 1
  %t10 = icmp eq i64 %t9, 0
  %t11 = load i8*, i8** %l0
  br i1 %t10, label %then2, label %merge3
then2:
  %s12 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.12, i32 0, i32 0
  %t13 = load i8*, i8** %l0
  %t14 = add i8* %s12, %t13
  ret i8* %t14
merge3:
  %t15 = extractvalue %NativeImport %entry, 2
  %t16 = bitcast { %NativeImportSpecifier**, i64 }* %t15 to { %NativeImportSpecifier*, i64 }*
  %t17 = call i8* @render_python_specifiers({ %NativeImportSpecifier*, i64 }* %t16)
  store i8* %t17, i8** %l1
  %s18 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.18, i32 0, i32 0
  %t19 = load i8*, i8** %l0
  %t20 = add i8* %s18, %t19
  %s21 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.21, i32 0, i32 0
  %t22 = add i8* %t20, %s21
  %t23 = load i8*, i8** %l1
  %t24 = add i8* %t22, %t23
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
  %s34 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.34, i32 0, i32 0
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
  %s12 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.12, i32 0, i32 0
  %t13 = add i8* %t11, %s12
  %t14 = extractvalue %NativeImportSpecifier %specifier, 1
  %t15 = call i8* @sanitize_identifier(i8* %t14)
  %t16 = add i8* %t13, %t15
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
  %s7 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.7, i32 0, i32 0
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
  %s20 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.20, i32 0, i32 0
  %t21 = load i8*, i8** %l1
  %t22 = add i8* %s20, %t21
  ret i8* %t22
merge3:
  %t23 = load i8*, i8** %l0
  %s24 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.24, i32 0, i32 0
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
  %s41 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.41, i32 0, i32 0
  %t42 = load i8*, i8** %l2
  %t43 = add i8* %s41, %t42
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
  store %PythonBuilder zeroinitializer, %PythonBuilder* %l0
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
  %t57 = insertvalue %PythonStructEmission undef, %PythonBuilder* null, 0
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
  %t124 = phi { i8**, i64 }* [ %t90, %entry ], [ %t122, %loop.latch18 ]
  %t125 = phi double [ %t89, %entry ], [ %t123, %loop.latch18 ]
  store { i8**, i64 }* %t124, { i8**, i64 }** %l5
  store double %t125, double* %l1
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
  %t110 = getelementptr i8, i8* %t109, i64 0
  %t111 = load i8, i8* %t110
  %t112 = add i8 34, %t111
  %t113 = add i8 %t112, 34
  %t114 = alloca [2 x i8], align 1
  %t115 = getelementptr [2 x i8], [2 x i8]* %t114, i32 0, i32 0
  store i8 %t113, i8* %t115
  %t116 = getelementptr [2 x i8], [2 x i8]* %t114, i32 0, i32 1
  store i8 0, i8* %t116
  %t117 = getelementptr [2 x i8], [2 x i8]* %t114, i32 0, i32 0
  %t118 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t100, i8* %t117)
  store { i8**, i64 }* %t118, { i8**, i64 }** %l5
  %t119 = load double, double* %l1
  %t120 = sitofp i64 1 to double
  %t121 = fadd double %t119, %t120
  store double %t121, double* %l1
  br label %loop.latch18
loop.latch18:
  %t122 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t123 = load double, double* %l1
  br label %loop.header16
afterloop19:
  %s126 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.126, i32 0, i32 0
  %t127 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %s128 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.128, i32 0, i32 0
  %t129 = call i8* @join_with_separator({ i8**, i64 }* %t127, i8* %s128)
  %t130 = add i8* %s126, %t129
  %t131 = getelementptr i8, i8* %t130, i64 0
  %t132 = load i8, i8* %t131
  %t133 = add i8 %t132, 93
  %t134 = alloca [2 x i8], align 1
  %t135 = getelementptr [2 x i8], [2 x i8]* %t134, i32 0, i32 0
  store i8 %t133, i8* %t135
  %t136 = getelementptr [2 x i8], [2 x i8]* %t134, i32 0, i32 1
  store i8 0, i8* %t136
  %t137 = getelementptr [2 x i8], [2 x i8]* %t134, i32 0, i32 0
  %t138 = call %PythonBuilder @builder_emit(%PythonBuilder %builder, i8* %t137)
  ret %PythonBuilder %t138
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
  %s2 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.2, i32 0, i32 0
  %t3 = load i8*, i8** %l0
  %t4 = add i8* %s2, %t3
  %t5 = getelementptr i8, i8* %t4, i64 0
  %t6 = load i8, i8* %t5
  %t7 = add i8 %t6, 58
  %t8 = alloca [2 x i8], align 1
  %t9 = getelementptr [2 x i8], [2 x i8]* %t8, i32 0, i32 0
  store i8 %t7, i8* %t9
  %t10 = getelementptr [2 x i8], [2 x i8]* %t8, i32 0, i32 1
  store i8 0, i8* %t10
  %t11 = getelementptr [2 x i8], [2 x i8]* %t8, i32 0, i32 0
  %t12 = call %PythonBuilder @builder_emit(%PythonBuilder %builder, i8* %t11)
  store %PythonBuilder %t12, %PythonBuilder* %l1
  %t13 = load %PythonBuilder, %PythonBuilder* %l1
  %t14 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t13)
  store %PythonBuilder %t14, %PythonBuilder* %l1
  %t15 = alloca [0 x i8*]
  %t16 = getelementptr [0 x i8*], [0 x i8*]* %t15, i32 0, i32 0
  %t17 = alloca { i8**, i64 }
  %t18 = getelementptr { i8**, i64 }, { i8**, i64 }* %t17, i32 0, i32 0
  store i8** %t16, i8*** %t18
  %t19 = getelementptr { i8**, i64 }, { i8**, i64 }* %t17, i32 0, i32 1
  store i64 0, i64* %t19
  store { i8**, i64 }* %t17, { i8**, i64 }** %l2
  %t20 = extractvalue %NativeStruct %definition, 1
  %t21 = bitcast { %NativeStructField**, i64 }* %t20 to { %NativeStructField*, i64 }*
  %t22 = call { i8**, i64 }* @render_struct_parameters({ %NativeStructField*, i64 }* %t21)
  store { i8**, i64 }* %t22, { i8**, i64 }** %l3
  %s23 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.23, i32 0, i32 0
  store i8* %s23, i8** %l4
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t25 = load { i8**, i64 }, { i8**, i64 }* %t24
  %t26 = extractvalue { i8**, i64 } %t25, 1
  %t27 = icmp sgt i64 %t26, 0
  %t28 = load i8*, i8** %l0
  %t29 = load %PythonBuilder, %PythonBuilder* %l1
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t32 = load i8*, i8** %l4
  br i1 %t27, label %then0, label %merge1
then0:
  %t33 = load i8*, i8** %l4
  %s34 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.34, i32 0, i32 0
  %t35 = add i8* %t33, %s34
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %s37 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.37, i32 0, i32 0
  %t38 = call i8* @join_with_separator({ i8**, i64 }* %t36, i8* %s37)
  %t39 = add i8* %t35, %t38
  store i8* %t39, i8** %l4
  br label %merge1
merge1:
  %t40 = phi i8* [ %t39, %then0 ], [ %t32, %entry ]
  store i8* %t40, i8** %l4
  %t41 = load i8*, i8** %l4
  %t42 = getelementptr i8, i8* %t41, i64 0
  %t43 = load i8, i8* %t42
  %t44 = add i8 %t43, 41
  %t45 = alloca [2 x i8], align 1
  %t46 = getelementptr [2 x i8], [2 x i8]* %t45, i32 0, i32 0
  store i8 %t44, i8* %t46
  %t47 = getelementptr [2 x i8], [2 x i8]* %t45, i32 0, i32 1
  store i8 0, i8* %t47
  %t48 = getelementptr [2 x i8], [2 x i8]* %t45, i32 0, i32 0
  store i8* %t48, i8** %l4
  %t49 = load %PythonBuilder, %PythonBuilder* %l1
  %t50 = load i8*, i8** %l4
  %t51 = getelementptr i8, i8* %t50, i64 0
  %t52 = load i8, i8* %t51
  %t53 = add i8 %t52, 58
  %t54 = alloca [2 x i8], align 1
  %t55 = getelementptr [2 x i8], [2 x i8]* %t54, i32 0, i32 0
  store i8 %t53, i8* %t55
  %t56 = getelementptr [2 x i8], [2 x i8]* %t54, i32 0, i32 1
  store i8 0, i8* %t56
  %t57 = getelementptr [2 x i8], [2 x i8]* %t54, i32 0, i32 0
  %t58 = call %PythonBuilder @builder_emit(%PythonBuilder %t49, i8* %t57)
  store %PythonBuilder %t58, %PythonBuilder* %l1
  %t59 = load %PythonBuilder, %PythonBuilder* %l1
  %t60 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t59)
  store %PythonBuilder %t60, %PythonBuilder* %l1
  %t61 = extractvalue %NativeStruct %definition, 1
  %t62 = load { %NativeStructField**, i64 }, { %NativeStructField**, i64 }* %t61
  %t63 = extractvalue { %NativeStructField**, i64 } %t62, 1
  %t64 = icmp eq i64 %t63, 0
  %t65 = load i8*, i8** %l0
  %t66 = load %PythonBuilder, %PythonBuilder* %l1
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t69 = load i8*, i8** %l4
  br i1 %t64, label %then2, label %else3
then2:
  %t70 = load %PythonBuilder, %PythonBuilder* %l1
  %s71 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.71, i32 0, i32 0
  %t72 = call %PythonBuilder @builder_emit(%PythonBuilder %t70, i8* %s71)
  store %PythonBuilder %t72, %PythonBuilder* %l1
  br label %merge4
else3:
  %t73 = sitofp i64 0 to double
  store double %t73, double* %l5
  %t74 = load i8*, i8** %l0
  %t75 = load %PythonBuilder, %PythonBuilder* %l1
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t77 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t78 = load i8*, i8** %l4
  %t79 = load double, double* %l5
  br label %loop.header5
loop.header5:
  %t119 = phi %PythonBuilder [ %t75, %else3 ], [ %t117, %loop.latch7 ]
  %t120 = phi double [ %t79, %else3 ], [ %t118, %loop.latch7 ]
  store %PythonBuilder %t119, %PythonBuilder* %l1
  store double %t120, double* %l5
  br label %loop.body6
loop.body6:
  %t80 = load double, double* %l5
  %t81 = extractvalue %NativeStruct %definition, 1
  %t82 = load { %NativeStructField**, i64 }, { %NativeStructField**, i64 }* %t81
  %t83 = extractvalue { %NativeStructField**, i64 } %t82, 1
  %t84 = sitofp i64 %t83 to double
  %t85 = fcmp oge double %t80, %t84
  %t86 = load i8*, i8** %l0
  %t87 = load %PythonBuilder, %PythonBuilder* %l1
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t90 = load i8*, i8** %l4
  %t91 = load double, double* %l5
  br i1 %t85, label %then9, label %merge10
then9:
  br label %afterloop8
merge10:
  %t92 = extractvalue %NativeStruct %definition, 1
  %t93 = load double, double* %l5
  %t94 = fptosi double %t93 to i64
  %t95 = load { %NativeStructField**, i64 }, { %NativeStructField**, i64 }* %t92
  %t96 = extractvalue { %NativeStructField**, i64 } %t95, 0
  %t97 = extractvalue { %NativeStructField**, i64 } %t95, 1
  %t98 = icmp uge i64 %t94, %t97
  ; bounds check: %t98 (if true, out of bounds)
  %t99 = getelementptr %NativeStructField*, %NativeStructField** %t96, i64 %t94
  %t100 = load %NativeStructField*, %NativeStructField** %t99
  store %NativeStructField* %t100, %NativeStructField** %l6
  %t101 = load %NativeStructField*, %NativeStructField** %l6
  %t102 = getelementptr %NativeStructField, %NativeStructField* %t101, i32 0, i32 0
  %t103 = load i8*, i8** %t102
  %t104 = call i8* @sanitize_identifier(i8* %t103)
  store i8* %t104, i8** %l7
  %t105 = load %PythonBuilder, %PythonBuilder* %l1
  %s106 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.106, i32 0, i32 0
  %t107 = load i8*, i8** %l7
  %t108 = add i8* %s106, %t107
  %s109 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.109, i32 0, i32 0
  %t110 = add i8* %t108, %s109
  %t111 = load i8*, i8** %l7
  %t112 = add i8* %t110, %t111
  %t113 = call %PythonBuilder @builder_emit(%PythonBuilder %t105, i8* %t112)
  store %PythonBuilder %t113, %PythonBuilder* %l1
  %t114 = load double, double* %l5
  %t115 = sitofp i64 1 to double
  %t116 = fadd double %t114, %t115
  store double %t116, double* %l5
  br label %loop.latch7
loop.latch7:
  %t117 = load %PythonBuilder, %PythonBuilder* %l1
  %t118 = load double, double* %l5
  br label %loop.header5
afterloop8:
  br label %merge4
merge4:
  %t121 = phi %PythonBuilder [ %t72, %then2 ], [ %t113, %else3 ]
  store %PythonBuilder %t121, %PythonBuilder* %l1
  %t122 = load %PythonBuilder, %PythonBuilder* %l1
  %t123 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t122)
  store %PythonBuilder %t123, %PythonBuilder* %l1
  %t124 = load %PythonBuilder, %PythonBuilder* %l1
  %t125 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t124)
  store %PythonBuilder %t125, %PythonBuilder* %l1
  %t126 = load %PythonBuilder, %PythonBuilder* %l1
  %s127 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.127, i32 0, i32 0
  %t128 = call %PythonBuilder @builder_emit(%PythonBuilder %t126, i8* %s127)
  store %PythonBuilder %t128, %PythonBuilder* %l1
  %t129 = load %PythonBuilder, %PythonBuilder* %l1
  %t130 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t129)
  store %PythonBuilder %t130, %PythonBuilder* %l1
  %t131 = load i8*, i8** %l0
  %t132 = extractvalue %NativeStruct %definition, 1
  %t133 = bitcast { %NativeStructField**, i64 }* %t132 to { %NativeStructField*, i64 }*
  %t134 = call i8* @render_struct_repr_fields(i8* %t131, { %NativeStructField*, i64 }* %t133)
  store i8* %t134, i8** %l8
  %t135 = load %PythonBuilder, %PythonBuilder* %l1
  %t136 = load i8*, i8** %l8
  %t137 = call %PythonBuilder @builder_emit(%PythonBuilder %t135, i8* %t136)
  store %PythonBuilder %t137, %PythonBuilder* %l1
  %t138 = load %PythonBuilder, %PythonBuilder* %l1
  %t139 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t138)
  store %PythonBuilder %t139, %PythonBuilder* %l1
  %t140 = load i8*, i8** %l0
  %s141 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.141, i32 0, i32 0
  %t142 = icmp eq i8* %t140, %s141
  %t143 = load i8*, i8** %l0
  %t144 = load %PythonBuilder, %PythonBuilder* %l1
  %t145 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t146 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t147 = load i8*, i8** %l4
  %t148 = load i8*, i8** %l8
  br i1 %t142, label %then11, label %merge12
then11:
  %t149 = load %PythonBuilder, %PythonBuilder* %l1
  %t150 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t149)
  store %PythonBuilder %t150, %PythonBuilder* %l1
  %t151 = load %PythonBuilder, %PythonBuilder* %l1
  %s152 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.152, i32 0, i32 0
  %t153 = call %PythonBuilder @builder_emit(%PythonBuilder %t151, i8* %s152)
  store %PythonBuilder %t153, %PythonBuilder* %l1
  %t154 = load %PythonBuilder, %PythonBuilder* %l1
  %t155 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t154)
  store %PythonBuilder %t155, %PythonBuilder* %l1
  %t156 = load %PythonBuilder, %PythonBuilder* %l1
  %s157 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.157, i32 0, i32 0
  %t158 = call %PythonBuilder @builder_emit(%PythonBuilder %t156, i8* %s157)
  store %PythonBuilder %t158, %PythonBuilder* %l1
  %t159 = load %PythonBuilder, %PythonBuilder* %l1
  %s160 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.160, i32 0, i32 0
  %t161 = call %PythonBuilder @builder_emit(%PythonBuilder %t159, i8* %s160)
  store %PythonBuilder %t161, %PythonBuilder* %l1
  %t162 = load %PythonBuilder, %PythonBuilder* %l1
  %t163 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t162)
  store %PythonBuilder %t163, %PythonBuilder* %l1
  %t164 = load %PythonBuilder, %PythonBuilder* %l1
  %s165 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.165, i32 0, i32 0
  %t166 = call %PythonBuilder @builder_emit(%PythonBuilder %t164, i8* %s165)
  store %PythonBuilder %t166, %PythonBuilder* %l1
  %t167 = load %PythonBuilder, %PythonBuilder* %l1
  %t168 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t167)
  store %PythonBuilder %t168, %PythonBuilder* %l1
  %t169 = load %PythonBuilder, %PythonBuilder* %l1
  %s170 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.170, i32 0, i32 0
  %t171 = call %PythonBuilder @builder_emit(%PythonBuilder %t169, i8* %s170)
  store %PythonBuilder %t171, %PythonBuilder* %l1
  %t172 = load %PythonBuilder, %PythonBuilder* %l1
  %t173 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t172)
  store %PythonBuilder %t173, %PythonBuilder* %l1
  %t174 = load %PythonBuilder, %PythonBuilder* %l1
  %s175 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.175, i32 0, i32 0
  %t176 = call %PythonBuilder @builder_emit(%PythonBuilder %t174, i8* %s175)
  store %PythonBuilder %t176, %PythonBuilder* %l1
  %t177 = load %PythonBuilder, %PythonBuilder* %l1
  %s178 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.178, i32 0, i32 0
  %t179 = call %PythonBuilder @builder_emit(%PythonBuilder %t177, i8* %s178)
  store %PythonBuilder %t179, %PythonBuilder* %l1
  %t180 = load %PythonBuilder, %PythonBuilder* %l1
  %t181 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t180)
  store %PythonBuilder %t181, %PythonBuilder* %l1
  %t182 = load %PythonBuilder, %PythonBuilder* %l1
  %s183 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.183, i32 0, i32 0
  %t184 = call %PythonBuilder @builder_emit(%PythonBuilder %t182, i8* %s183)
  store %PythonBuilder %t184, %PythonBuilder* %l1
  %t185 = load %PythonBuilder, %PythonBuilder* %l1
  %t186 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t185)
  store %PythonBuilder %t186, %PythonBuilder* %l1
  %t187 = load %PythonBuilder, %PythonBuilder* %l1
  %s188 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.188, i32 0, i32 0
  %t189 = call %PythonBuilder @builder_emit(%PythonBuilder %t187, i8* %s188)
  store %PythonBuilder %t189, %PythonBuilder* %l1
  %t190 = load %PythonBuilder, %PythonBuilder* %l1
  %t191 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t190)
  store %PythonBuilder %t191, %PythonBuilder* %l1
  %t192 = load %PythonBuilder, %PythonBuilder* %l1
  %s193 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.193, i32 0, i32 0
  %t194 = call %PythonBuilder @builder_emit(%PythonBuilder %t192, i8* %s193)
  store %PythonBuilder %t194, %PythonBuilder* %l1
  %t195 = load %PythonBuilder, %PythonBuilder* %l1
  %t196 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t195)
  store %PythonBuilder %t196, %PythonBuilder* %l1
  br label %merge12
merge12:
  %t197 = phi %PythonBuilder [ %t150, %then11 ], [ %t144, %entry ]
  %t198 = phi %PythonBuilder [ %t153, %then11 ], [ %t144, %entry ]
  %t199 = phi %PythonBuilder [ %t155, %then11 ], [ %t144, %entry ]
  %t200 = phi %PythonBuilder [ %t158, %then11 ], [ %t144, %entry ]
  %t201 = phi %PythonBuilder [ %t161, %then11 ], [ %t144, %entry ]
  %t202 = phi %PythonBuilder [ %t163, %then11 ], [ %t144, %entry ]
  %t203 = phi %PythonBuilder [ %t166, %then11 ], [ %t144, %entry ]
  %t204 = phi %PythonBuilder [ %t168, %then11 ], [ %t144, %entry ]
  %t205 = phi %PythonBuilder [ %t171, %then11 ], [ %t144, %entry ]
  %t206 = phi %PythonBuilder [ %t173, %then11 ], [ %t144, %entry ]
  %t207 = phi %PythonBuilder [ %t176, %then11 ], [ %t144, %entry ]
  %t208 = phi %PythonBuilder [ %t179, %then11 ], [ %t144, %entry ]
  %t209 = phi %PythonBuilder [ %t181, %then11 ], [ %t144, %entry ]
  %t210 = phi %PythonBuilder [ %t184, %then11 ], [ %t144, %entry ]
  %t211 = phi %PythonBuilder [ %t186, %then11 ], [ %t144, %entry ]
  %t212 = phi %PythonBuilder [ %t189, %then11 ], [ %t144, %entry ]
  %t213 = phi %PythonBuilder [ %t191, %then11 ], [ %t144, %entry ]
  %t214 = phi %PythonBuilder [ %t194, %then11 ], [ %t144, %entry ]
  %t215 = phi %PythonBuilder [ %t196, %then11 ], [ %t144, %entry ]
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
  store %PythonBuilder %t213, %PythonBuilder* %l1
  store %PythonBuilder %t214, %PythonBuilder* %l1
  store %PythonBuilder %t215, %PythonBuilder* %l1
  %t216 = extractvalue %NativeStruct %definition, 2
  %t217 = load { %NativeFunction**, i64 }, { %NativeFunction**, i64 }* %t216
  %t218 = extractvalue { %NativeFunction**, i64 } %t217, 1
  %t219 = icmp sgt i64 %t218, 0
  %t220 = load i8*, i8** %l0
  %t221 = load %PythonBuilder, %PythonBuilder* %l1
  %t222 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t223 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t224 = load i8*, i8** %l4
  %t225 = load i8*, i8** %l8
  br i1 %t219, label %then13, label %merge14
then13:
  %t226 = load %PythonBuilder, %PythonBuilder* %l1
  %t227 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t226)
  store %PythonBuilder %t227, %PythonBuilder* %l1
  %t228 = sitofp i64 0 to double
  store double %t228, double* %l9
  %t229 = load i8*, i8** %l0
  %t230 = load %PythonBuilder, %PythonBuilder* %l1
  %t231 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t232 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t233 = load i8*, i8** %l4
  %t234 = load i8*, i8** %l8
  %t235 = load double, double* %l9
  br label %loop.header15
loop.header15:
  %t293 = phi %PythonBuilder [ %t230, %then13 ], [ %t290, %loop.latch17 ]
  %t294 = phi { i8**, i64 }* [ %t231, %then13 ], [ %t291, %loop.latch17 ]
  %t295 = phi double [ %t235, %then13 ], [ %t292, %loop.latch17 ]
  store %PythonBuilder %t293, %PythonBuilder* %l1
  store { i8**, i64 }* %t294, { i8**, i64 }** %l2
  store double %t295, double* %l9
  br label %loop.body16
loop.body16:
  %t236 = load double, double* %l9
  %t237 = extractvalue %NativeStruct %definition, 2
  %t238 = load { %NativeFunction**, i64 }, { %NativeFunction**, i64 }* %t237
  %t239 = extractvalue { %NativeFunction**, i64 } %t238, 1
  %t240 = sitofp i64 %t239 to double
  %t241 = fcmp oge double %t236, %t240
  %t242 = load i8*, i8** %l0
  %t243 = load %PythonBuilder, %PythonBuilder* %l1
  %t244 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t245 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t246 = load i8*, i8** %l4
  %t247 = load i8*, i8** %l8
  %t248 = load double, double* %l9
  br i1 %t241, label %then19, label %merge20
then19:
  br label %afterloop18
merge20:
  %t249 = extractvalue %NativeStruct %definition, 2
  %t250 = load double, double* %l9
  %t251 = fptosi double %t250 to i64
  %t252 = load { %NativeFunction**, i64 }, { %NativeFunction**, i64 }* %t249
  %t253 = extractvalue { %NativeFunction**, i64 } %t252, 0
  %t254 = extractvalue { %NativeFunction**, i64 } %t252, 1
  %t255 = icmp uge i64 %t251, %t254
  ; bounds check: %t255 (if true, out of bounds)
  %t256 = getelementptr %NativeFunction*, %NativeFunction** %t253, i64 %t251
  %t257 = load %NativeFunction*, %NativeFunction** %t256
  store %NativeFunction* %t257, %NativeFunction** %l10
  %t258 = load %PythonBuilder, %PythonBuilder* %l1
  %t259 = load %NativeFunction*, %NativeFunction** %l10
  %t260 = call %PythonFunctionEmission @emit_python_function(%PythonBuilder %t258, %NativeFunction zeroinitializer)
  store %PythonFunctionEmission %t260, %PythonFunctionEmission* %l11
  %t261 = load %PythonFunctionEmission, %PythonFunctionEmission* %l11
  %t262 = extractvalue %PythonFunctionEmission %t261, 0
  store %PythonBuilder zeroinitializer, %PythonBuilder* %l1
  %t263 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t264 = load %PythonFunctionEmission, %PythonFunctionEmission* %l11
  %t265 = extractvalue %PythonFunctionEmission %t264, 1
  %t266 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t263, { i8**, i64 }* %t265)
  store { i8**, i64 }* %t266, { i8**, i64 }** %l2
  %t267 = load double, double* %l9
  %t268 = sitofp i64 1 to double
  %t269 = fadd double %t267, %t268
  %t270 = extractvalue %NativeStruct %definition, 2
  %t271 = load { %NativeFunction**, i64 }, { %NativeFunction**, i64 }* %t270
  %t272 = extractvalue { %NativeFunction**, i64 } %t271, 1
  %t273 = sitofp i64 %t272 to double
  %t274 = fcmp olt double %t269, %t273
  %t275 = load i8*, i8** %l0
  %t276 = load %PythonBuilder, %PythonBuilder* %l1
  %t277 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t278 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t279 = load i8*, i8** %l4
  %t280 = load i8*, i8** %l8
  %t281 = load double, double* %l9
  %t282 = load %NativeFunction*, %NativeFunction** %l10
  %t283 = load %PythonFunctionEmission, %PythonFunctionEmission* %l11
  br i1 %t274, label %then21, label %merge22
then21:
  %t284 = load %PythonBuilder, %PythonBuilder* %l1
  %t285 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t284)
  store %PythonBuilder %t285, %PythonBuilder* %l1
  br label %merge22
merge22:
  %t286 = phi %PythonBuilder [ %t285, %then21 ], [ %t276, %loop.body16 ]
  store %PythonBuilder %t286, %PythonBuilder* %l1
  %t287 = load double, double* %l9
  %t288 = sitofp i64 1 to double
  %t289 = fadd double %t287, %t288
  store double %t289, double* %l9
  br label %loop.latch17
loop.latch17:
  %t290 = load %PythonBuilder, %PythonBuilder* %l1
  %t291 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t292 = load double, double* %l9
  br label %loop.header15
afterloop18:
  br label %merge14
merge14:
  %t296 = phi %PythonBuilder [ %t227, %then13 ], [ %t221, %entry ]
  %t297 = phi %PythonBuilder [ zeroinitializer, %then13 ], [ %t221, %entry ]
  %t298 = phi { i8**, i64 }* [ %t266, %then13 ], [ %t222, %entry ]
  %t299 = phi %PythonBuilder [ %t285, %then13 ], [ %t221, %entry ]
  store %PythonBuilder %t296, %PythonBuilder* %l1
  store %PythonBuilder %t297, %PythonBuilder* %l1
  store { i8**, i64 }* %t298, { i8**, i64 }** %l2
  store %PythonBuilder %t299, %PythonBuilder* %l1
  %t300 = load %PythonBuilder, %PythonBuilder* %l1
  %t301 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t300)
  store %PythonBuilder %t301, %PythonBuilder* %l1
  %t302 = load %PythonBuilder, %PythonBuilder* %l1
  %t303 = insertvalue %PythonStructEmission undef, %PythonBuilder* null, 0
  %t304 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t305 = insertvalue %PythonStructEmission %t303, { i8**, i64 }* %t304, 1
  ret %PythonStructEmission %t305
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
  %s44 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.44, i32 0, i32 0
  %t45 = add i8* %t43, %s44
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
  %s3 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.3, i32 0, i32 0
  %t4 = add i8* %s3, %class_name
  %s5 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.5, i32 0, i32 0
  %t6 = add i8* %t4, %s5
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
  %t54 = phi { i8**, i64 }* [ %t13, %entry ], [ %t52, %loop.latch4 ]
  %t55 = phi double [ %t14, %entry ], [ %t53, %loop.latch4 ]
  store { i8**, i64 }* %t54, { i8**, i64 }** %l0
  store double %t55, double* %l1
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
  %s34 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.34, i32 0, i32 0
  %t35 = load i8*, i8** %l3
  %t36 = add i8* %s34, %t35
  %s37 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.37, i32 0, i32 0
  %t38 = add i8* %t36, %s37
  %t39 = load i8*, i8** %l3
  %t40 = add i8* %t38, %t39
  %t41 = getelementptr i8, i8* %t40, i64 0
  %t42 = load i8, i8* %t41
  %t43 = add i8 %t42, 41
  %t44 = alloca [2 x i8], align 1
  %t45 = getelementptr [2 x i8], [2 x i8]* %t44, i32 0, i32 0
  store i8 %t43, i8* %t45
  %t46 = getelementptr [2 x i8], [2 x i8]* %t44, i32 0, i32 1
  store i8 0, i8* %t46
  %t47 = getelementptr [2 x i8], [2 x i8]* %t44, i32 0, i32 0
  %t48 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t33, i8* %t47)
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
  %s56 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.56, i32 0, i32 0
  %t57 = add i8* %s56, %class_name
  %s58 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.58, i32 0, i32 0
  %t59 = add i8* %t57, %s58
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s61 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.61, i32 0, i32 0
  %t62 = call i8* @join_with_separator({ i8**, i64 }* %t60, i8* %s61)
  %t63 = add i8* %t59, %t62
  %s64 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.64, i32 0, i32 0
  %t65 = add i8* %t63, %s64
  ret i8* %t65
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
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
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
  %t10 = call double @rewrite_interpolated_string_literal(i8* %t9)
  store double %t10, double* %l1
  %t11 = load double, double* %l1
  %t12 = load i8*, i8** %l0
  %t13 = call double @lower_struct_literal_expression(i8* %t12, double %depth)
  store double %t13, double* %l2
  %t14 = load double, double* %l2
  %t15 = load i8*, i8** %l0
  %t16 = call double @lower_array_literal_expression(i8* %t15, double %depth)
  store double %t16, double* %l3
  %t17 = load double, double* %l3
  %t18 = load i8*, i8** %l0
  %t19 = call i8* @rewrite_expression_intrinsics(i8* %t18)
  store i8* %t19, i8** %l4
  %t20 = load i8*, i8** %l4
  %t21 = call i8* @rewrite_array_literals_inline(i8* %t20, double %depth)
  store i8* %t21, i8** %l5
  %t22 = load i8*, i8** %l5
  %t23 = call i8* @rewrite_struct_literals_inline(i8* %t22, double %depth)
  ret i8* %t23
}

define i8* @decode_escape_sequence(i8* %escape, i8* %quote) {
entry:
  %t0 = getelementptr i8, i8* %escape, i64 0
  %t1 = load i8, i8* %t0
  %t2 = icmp eq i8 %t1, 110
  br i1 %t2, label %then0, label %merge1
then0:
  %t3 = alloca [2 x i8], align 1
  %t4 = getelementptr [2 x i8], [2 x i8]* %t3, i32 0, i32 0
  store i8 10, i8* %t4
  %t5 = getelementptr [2 x i8], [2 x i8]* %t3, i32 0, i32 1
  store i8 0, i8* %t5
  %t6 = getelementptr [2 x i8], [2 x i8]* %t3, i32 0, i32 0
  ret i8* %t6
merge1:
  %t7 = getelementptr i8, i8* %escape, i64 0
  %t8 = load i8, i8* %t7
  %t9 = icmp eq i8 %t8, 114
  br i1 %t9, label %then2, label %merge3
then2:
  %t10 = alloca [2 x i8], align 1
  %t11 = getelementptr [2 x i8], [2 x i8]* %t10, i32 0, i32 0
  store i8 13, i8* %t11
  %t12 = getelementptr [2 x i8], [2 x i8]* %t10, i32 0, i32 1
  store i8 0, i8* %t12
  %t13 = getelementptr [2 x i8], [2 x i8]* %t10, i32 0, i32 0
  ret i8* %t13
merge3:
  %t14 = getelementptr i8, i8* %escape, i64 0
  %t15 = load i8, i8* %t14
  %t16 = icmp eq i8 %t15, 116
  br i1 %t16, label %then4, label %merge5
then4:
  %t17 = alloca [2 x i8], align 1
  %t18 = getelementptr [2 x i8], [2 x i8]* %t17, i32 0, i32 0
  store i8 9, i8* %t18
  %t19 = getelementptr [2 x i8], [2 x i8]* %t17, i32 0, i32 1
  store i8 0, i8* %t19
  %t20 = getelementptr [2 x i8], [2 x i8]* %t17, i32 0, i32 0
  ret i8* %t20
merge5:
  %t21 = getelementptr i8, i8* %escape, i64 0
  %t22 = load i8, i8* %t21
  %t23 = icmp eq i8 %t22, 92
  br i1 %t23, label %then6, label %merge7
then6:
  %t24 = alloca [2 x i8], align 1
  %t25 = getelementptr [2 x i8], [2 x i8]* %t24, i32 0, i32 0
  store i8 92, i8* %t25
  %t26 = getelementptr [2 x i8], [2 x i8]* %t24, i32 0, i32 1
  store i8 0, i8* %t26
  %t27 = getelementptr [2 x i8], [2 x i8]* %t24, i32 0, i32 0
  ret i8* %t27
merge7:
  %t28 = icmp eq i8* %escape, %quote
  br i1 %t28, label %then8, label %merge9
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
  %t72 = phi i8 [ %t0, %entry ], [ %t70, %loop.latch2 ]
  %t73 = phi i64 [ %t1, %entry ], [ %t71, %loop.latch2 ]
  store i8 %t72, i8* %l0
  store i64 %t73, i64* %l1
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
  %s16 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.16, i32 0, i32 0
  %t17 = getelementptr i8, i8* %s16, i64 0
  %t18 = load i8, i8* %t17
  %t19 = add i8 %t15, %t18
  store i8 %t19, i8* %l0
  br label %merge8
else7:
  %t20 = load i8, i8* %l2
  %t21 = icmp eq i8 %t20, 39
  %t22 = load i8, i8* %l0
  %t23 = load i64, i64* %l1
  %t24 = load i8, i8* %l2
  br i1 %t21, label %then9, label %else10
then9:
  %t25 = load i8, i8* %l0
  %s26 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.26, i32 0, i32 0
  %t27 = getelementptr i8, i8* %s26, i64 0
  %t28 = load i8, i8* %t27
  %t29 = add i8 %t25, %t28
  store i8 %t29, i8* %l0
  br label %merge11
else10:
  %t30 = load i8, i8* %l2
  %t31 = icmp eq i8 %t30, 10
  %t32 = load i8, i8* %l0
  %t33 = load i64, i64* %l1
  %t34 = load i8, i8* %l2
  br i1 %t31, label %then12, label %else13
then12:
  %t35 = load i8, i8* %l0
  %s36 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.36, i32 0, i32 0
  %t37 = getelementptr i8, i8* %s36, i64 0
  %t38 = load i8, i8* %t37
  %t39 = add i8 %t35, %t38
  store i8 %t39, i8* %l0
  br label %merge14
else13:
  %t40 = load i8, i8* %l2
  %t41 = icmp eq i8 %t40, 13
  %t42 = load i8, i8* %l0
  %t43 = load i64, i64* %l1
  %t44 = load i8, i8* %l2
  br i1 %t41, label %then15, label %else16
then15:
  %t45 = load i8, i8* %l0
  %s46 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.46, i32 0, i32 0
  %t47 = getelementptr i8, i8* %s46, i64 0
  %t48 = load i8, i8* %t47
  %t49 = add i8 %t45, %t48
  store i8 %t49, i8* %l0
  br label %merge17
else16:
  %t50 = load i8, i8* %l2
  %t51 = icmp eq i8 %t50, 9
  %t52 = load i8, i8* %l0
  %t53 = load i64, i64* %l1
  %t54 = load i8, i8* %l2
  br i1 %t51, label %then18, label %else19
then18:
  %t55 = load i8, i8* %l0
  %s56 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.56, i32 0, i32 0
  %t57 = getelementptr i8, i8* %s56, i64 0
  %t58 = load i8, i8* %t57
  %t59 = add i8 %t55, %t58
  store i8 %t59, i8* %l0
  br label %merge20
else19:
  %t60 = load i8, i8* %l0
  %t61 = load i8, i8* %l2
  %t62 = add i8 %t60, %t61
  store i8 %t62, i8* %l0
  br label %merge20
merge20:
  %t63 = phi i8 [ %t59, %then18 ], [ %t62, %else19 ]
  store i8 %t63, i8* %l0
  br label %merge17
merge17:
  %t64 = phi i8 [ %t49, %then15 ], [ %t59, %else16 ]
  store i8 %t64, i8* %l0
  br label %merge14
merge14:
  %t65 = phi i8 [ %t39, %then12 ], [ %t49, %else13 ]
  store i8 %t65, i8* %l0
  br label %merge11
merge11:
  %t66 = phi i8 [ %t29, %then9 ], [ %t39, %else10 ]
  store i8 %t66, i8* %l0
  br label %merge8
merge8:
  %t67 = phi i8 [ %t19, %then6 ], [ %t29, %else7 ]
  store i8 %t67, i8* %l0
  %t68 = load i64, i64* %l1
  %t69 = add i64 %t68, 1
  store i64 %t69, i64* %l1
  br label %loop.latch2
loop.latch2:
  %t70 = load i8, i8* %l0
  %t71 = load i64, i64* %l1
  br label %loop.header0
afterloop3:
  %t74 = load i8, i8* %l0
  %t75 = add i8 %t74, 39
  store i8 %t75, i8* %l0
  %t76 = load i8, i8* %l0
  %t77 = alloca [2 x i8], align 1
  %t78 = getelementptr [2 x i8], [2 x i8]* %t77, i32 0, i32 0
  store i8 %t76, i8* %t78
  %t79 = getelementptr [2 x i8], [2 x i8]* %t77, i32 0, i32 1
  store i8 0, i8* %t79
  %t80 = getelementptr [2 x i8], [2 x i8]* %t77, i32 0, i32 0
  ret i8* %t80
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
  %t36 = phi i64 [ %t7, %entry ], [ %t35, %loop.latch6 ]
  store i64 %t36, i64* %l0
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
  %t26 = phi i64 [ %t16, %loop.body5 ], [ %t25, %loop.latch12 ]
  store i64 %t26, i64* %l2
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
  %t23 = load i64, i64* %l2
  %t24 = add i64 %t23, 1
  store i64 %t24, i64* %l2
  br label %loop.latch12
loop.latch12:
  %t25 = load i64, i64* %l2
  br label %loop.header10
afterloop13:
  %t27 = load i1, i1* %l1
  %t28 = load i64, i64* %l0
  %t29 = load i1, i1* %l1
  %t30 = load i64, i64* %l2
  br i1 %t27, label %then16, label %merge17
then16:
  %t31 = load i64, i64* %l0
  %t32 = sitofp i64 %t31 to double
  ret double %t32
merge17:
  %t33 = load i64, i64* %l0
  %t34 = add i64 %t33, 1
  store i64 %t34, i64* %l0
  br label %loop.latch6
loop.latch6:
  %t35 = load i64, i64* %l0
  br label %loop.header4
afterloop7:
  %t37 = sitofp i64 -1 to double
  ret double %t37
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
  %t33 = phi double [ %t3, %entry ], [ %t32, %loop.latch4 ]
  store double %t33, double* %l0
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
  %t17 = getelementptr i8, i8* %t16, i64 0
  %t18 = load i8, i8* %t17
  %t19 = icmp eq i8 %t18, 46
  %t20 = load double, double* %l0
  %t21 = load i8*, i8** %l1
  br i1 %t19, label %then8, label %merge9
then8:
  %t22 = load double, double* %l0
  %t23 = sitofp i64 1 to double
  %t24 = fadd double %t22, %t23
  store double %t24, double* %l0
  br label %loop.latch4
merge9:
  %t25 = load i8*, i8** %l1
  %t26 = call i1 @is_identifier_char(i8* %t25)
  %t27 = load double, double* %l0
  %t28 = load i8*, i8** %l1
  br i1 %t26, label %then10, label %merge11
then10:
  %t29 = load double, double* %l0
  %t30 = sitofp i64 1 to double
  %t31 = fadd double %t29, %t30
  store double %t31, double* %l0
  br label %loop.latch4
merge11:
  ret i1 0
loop.latch4:
  %t32 = load double, double* %l0
  br label %loop.header2
afterloop5:
  ret i1 1
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
  %s6 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.6, i32 0, i32 0
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
  %l5 = alloca double
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
  %t62 = phi i8* [ %t3, %entry ], [ %t60, %loop.latch4 ]
  %t63 = phi double [ %t4, %entry ], [ %t61, %loop.latch4 ]
  store i8* %t62, i8** %l0
  store double %t63, double* %l1
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
  %t42 = call double @lower_array_literal_expression(i8* %t39, double %t41)
  store double %t42, double* %l5
  %t43 = load double, double* %l5
  %t44 = load i8*, i8** %l0
  %t45 = load double, double* %l2
  %t46 = fptosi double %t45 to i64
  %t47 = call i8* @sailfin_runtime_substring(i8* %t44, i64 0, i64 %t46)
  store i8* %t47, i8** %l6
  %t48 = load i8*, i8** %l0
  %t49 = load double, double* %l3
  %t50 = sitofp i64 1 to double
  %t51 = fadd double %t49, %t50
  %t52 = load i8*, i8** %l0
  %t53 = call i64 @sailfin_runtime_string_length(i8* %t52)
  %t54 = fptosi double %t51 to i64
  %t55 = call i8* @sailfin_runtime_substring(i8* %t48, i64 %t54, i64 %t53)
  store i8* %t55, i8** %l7
  %t56 = load i8*, i8** %l6
  %t57 = load double, double* %l5
  %t58 = load double, double* %l2
  %t59 = load double, double* %l5
  br label %loop.latch4
loop.latch4:
  %t60 = load i8*, i8** %l0
  %t61 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t64 = load i8*, i8** %l0
  ret i8* %t64
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
  %l11 = alloca double
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
  %t214 = phi double [ %t4, %entry ], [ %t212, %loop.latch4 ]
  %t215 = phi i8* [ %t3, %entry ], [ %t213, %loop.latch4 ]
  store double %t214, double* %l1
  store i8* %t215, i8** %l0
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
  %t104 = phi double [ %t62, %loop.body3 ], [ %t103, %loop.latch20 ]
  store double %t104, double* %l5
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
  %t80 = getelementptr i8, i8* %t79, i64 0
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
  %t106 = load double, double* %l3
  %t107 = fcmp oeq double %t105, %t106
  %t108 = load i8*, i8** %l0
  %t109 = load double, double* %l1
  %t110 = load double, double* %l2
  %t111 = load double, double* %l3
  %t112 = load double, double* %l5
  br i1 %t107, label %then28, label %merge29
then28:
  %t113 = load double, double* %l2
  %t114 = sitofp i64 1 to double
  %t115 = fadd double %t113, %t114
  store double %t115, double* %l1
  br label %loop.latch4
merge29:
  %t116 = load i8*, i8** %l0
  %t117 = load double, double* %l5
  %t118 = load double, double* %l3
  %t119 = fptosi double %t117 to i64
  %t120 = fptosi double %t118 to i64
  %t121 = call i8* @sailfin_runtime_substring(i8* %t116, i64 %t119, i64 %t120)
  store i8* %t121, i8** %l7
  %t122 = load i8*, i8** %l7
  %t123 = call i1 @is_struct_literal_type_candidate(i8* %t122)
  %t124 = xor i1 %t123, 1
  %t125 = load i8*, i8** %l0
  %t126 = load double, double* %l1
  %t127 = load double, double* %l2
  %t128 = load double, double* %l3
  %t129 = load double, double* %l5
  %t130 = load i8*, i8** %l7
  br i1 %t124, label %then30, label %merge31
then30:
  %t131 = load double, double* %l2
  %t132 = sitofp i64 1 to double
  %t133 = fadd double %t131, %t132
  store double %t133, double* %l1
  br label %loop.latch4
merge31:
  %t134 = load double, double* %l5
  %t135 = sitofp i64 0 to double
  %t136 = fcmp ogt double %t134, %t135
  %t137 = load i8*, i8** %l0
  %t138 = load double, double* %l1
  %t139 = load double, double* %l2
  %t140 = load double, double* %l3
  %t141 = load double, double* %l5
  %t142 = load i8*, i8** %l7
  br i1 %t136, label %then32, label %merge33
then32:
  %t143 = load i8*, i8** %l0
  %t144 = load double, double* %l5
  %t145 = sitofp i64 1 to double
  %t146 = fsub double %t144, %t145
  %t147 = load double, double* %l5
  %t148 = fptosi double %t146 to i64
  %t149 = fptosi double %t147 to i64
  %t150 = call i8* @sailfin_runtime_substring(i8* %t143, i64 %t148, i64 %t149)
  store i8* %t150, i8** %l8
  %t152 = load i8*, i8** %l8
  %t153 = call i1 @is_identifier_char(i8* %t152)
  br label %logical_or_entry_151

logical_or_entry_151:
  br i1 %t153, label %logical_or_merge_151, label %logical_or_right_151

logical_or_right_151:
  %t154 = load i8*, i8** %l8
  %t155 = getelementptr i8, i8* %t154, i64 0
  %t156 = load i8, i8* %t155
  %t157 = icmp eq i8 %t156, 46
  br label %logical_or_right_end_151

logical_or_right_end_151:
  br label %logical_or_merge_151

logical_or_merge_151:
  %t158 = phi i1 [ true, %logical_or_entry_151 ], [ %t157, %logical_or_right_end_151 ]
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
  br label %merge33
merge33:
  %t169 = phi double [ %t168, %then32 ], [ %t138, %loop.body3 ]
  store double %t169, double* %l1
  %t170 = load i8*, i8** %l0
  %t171 = load double, double* %l2
  %t172 = call double @find_matching_brace(i8* %t170, double %t171)
  store double %t172, double* %l9
  %t173 = load double, double* %l9
  %t174 = sitofp i64 0 to double
  %t175 = fcmp olt double %t173, %t174
  %t176 = load i8*, i8** %l0
  %t177 = load double, double* %l1
  %t178 = load double, double* %l2
  %t179 = load double, double* %l3
  %t180 = load double, double* %l5
  %t181 = load i8*, i8** %l7
  %t182 = load double, double* %l9
  br i1 %t175, label %then36, label %merge37
then36:
  br label %afterloop5
merge37:
  %t183 = load i8*, i8** %l0
  %t184 = load double, double* %l5
  %t185 = load double, double* %l9
  %t186 = sitofp i64 1 to double
  %t187 = fadd double %t185, %t186
  %t188 = fptosi double %t184 to i64
  %t189 = fptosi double %t187 to i64
  %t190 = call i8* @sailfin_runtime_substring(i8* %t183, i64 %t188, i64 %t189)
  store i8* %t190, i8** %l10
  %t191 = load i8*, i8** %l10
  %t192 = sitofp i64 1 to double
  %t193 = fadd double %depth, %t192
  %t194 = call double @lower_struct_literal_expression(i8* %t191, double %t193)
  store double %t194, double* %l11
  %t195 = load double, double* %l11
  %t196 = load i8*, i8** %l0
  %t197 = load double, double* %l5
  %t198 = fptosi double %t197 to i64
  %t199 = call i8* @sailfin_runtime_substring(i8* %t196, i64 0, i64 %t198)
  store i8* %t199, i8** %l12
  %t200 = load i8*, i8** %l0
  %t201 = load double, double* %l9
  %t202 = sitofp i64 1 to double
  %t203 = fadd double %t201, %t202
  %t204 = load i8*, i8** %l0
  %t205 = call i64 @sailfin_runtime_string_length(i8* %t204)
  %t206 = fptosi double %t203 to i64
  %t207 = call i8* @sailfin_runtime_substring(i8* %t200, i64 %t206, i64 %t205)
  store i8* %t207, i8** %l13
  %t208 = load i8*, i8** %l12
  %t209 = load double, double* %l11
  %t210 = load double, double* %l5
  %t211 = load double, double* %l11
  br label %loop.latch4
loop.latch4:
  %t212 = load double, double* %l1
  %t213 = load i8*, i8** %l0
  br label %loop.header2
afterloop5:
  %t216 = load i8*, i8** %l0
  ret i8* %t216
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
  %t173 = phi i8* [ %t32, %entry ], [ %t169, %loop.latch6 ]
  %t174 = phi double [ %t35, %entry ], [ %t170, %loop.latch6 ]
  %t175 = phi double [ %t34, %entry ], [ %t171, %loop.latch6 ]
  %t176 = phi double [ %t33, %entry ], [ %t172, %loop.latch6 ]
  store i8* %t173, i8** %l1
  store double %t174, double* %l4
  store double %t175, double* %l3
  store double %t176, double* %l2
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
  %s108 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.108, i32 0, i32 0
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
  %t137 = getelementptr i8, i8* %t136, i64 0
  %t138 = load i8, i8* %t137
  %t139 = add i8 %t138, 32
  %t140 = load i8*, i8** %l6
  %t141 = getelementptr i8, i8* %t140, i64 0
  %t142 = load i8, i8* %t141
  %t143 = add i8 %t139, %t142
  %t144 = alloca [2 x i8], align 1
  %t145 = getelementptr [2 x i8], [2 x i8]* %t144, i32 0, i32 0
  store i8 %t143, i8* %t145
  %t146 = getelementptr [2 x i8], [2 x i8]* %t144, i32 0, i32 1
  store i8 0, i8* %t146
  %t147 = getelementptr [2 x i8], [2 x i8]* %t144, i32 0, i32 0
  store i8* %t147, i8** %l1
  br label %merge13
merge13:
  %t148 = phi i8* [ %t147, %then12 ], [ %t130, %loop.body5 ]
  store i8* %t148, i8** %l1
  %t149 = load double, double* %l4
  %t150 = load i8*, i8** %l6
  %t151 = call double @compute_brace_balance(i8* %t150)
  %t152 = fadd double %t149, %t151
  store double %t152, double* %l4
  %t153 = load double, double* %l3
  %t154 = sitofp i64 1 to double
  %t155 = fadd double %t153, %t154
  store double %t155, double* %l3
  %t156 = load double, double* %l2
  %t157 = sitofp i64 1 to double
  %t158 = fadd double %t156, %t157
  store double %t158, double* %l2
  %t159 = load double, double* %l4
  %t160 = sitofp i64 0 to double
  %t161 = fcmp ole double %t159, %t160
  %t162 = load i8*, i8** %l0
  %t163 = load i8*, i8** %l1
  %t164 = load double, double* %l2
  %t165 = load double, double* %l3
  %t166 = load double, double* %l4
  %t167 = load %NativeInstruction, %NativeInstruction* %l5
  %t168 = load i8*, i8** %l6
  br i1 %t161, label %then14, label %merge15
then14:
  br label %afterloop7
merge15:
  br label %loop.latch6
loop.latch6:
  %t169 = load i8*, i8** %l1
  %t170 = load double, double* %l4
  %t171 = load double, double* %l3
  %t172 = load double, double* %l2
  br label %loop.header4
afterloop7:
  %t177 = load double, double* %l4
  %t178 = sitofp i64 0 to double
  %t179 = fcmp une double %t177, %t178
  %t180 = load i8*, i8** %l0
  %t181 = load i8*, i8** %l1
  %t182 = load double, double* %l2
  %t183 = load double, double* %l3
  %t184 = load double, double* %l4
  br i1 %t179, label %then16, label %merge17
then16:
  %t185 = load i8*, i8** %l0
  %t186 = insertvalue %StructLiteralCapture undef, i8* %t185, 0
  %t187 = sitofp i64 0 to double
  %t188 = insertvalue %StructLiteralCapture %t186, double %t187, 1
  %t189 = insertvalue %StructLiteralCapture %t188, i1 0, 2
  ret %StructLiteralCapture %t189
merge17:
  %t190 = load double, double* %l3
  %t191 = sitofp i64 0 to double
  %t192 = fcmp oeq double %t190, %t191
  %t193 = load i8*, i8** %l0
  %t194 = load i8*, i8** %l1
  %t195 = load double, double* %l2
  %t196 = load double, double* %l3
  %t197 = load double, double* %l4
  br i1 %t192, label %then18, label %merge19
then18:
  %t198 = load i8*, i8** %l0
  %t199 = insertvalue %StructLiteralCapture undef, i8* %t198, 0
  %t200 = sitofp i64 0 to double
  %t201 = insertvalue %StructLiteralCapture %t199, double %t200, 1
  %t202 = insertvalue %StructLiteralCapture %t201, i1 0, 2
  ret %StructLiteralCapture %t202
merge19:
  %t203 = load i8*, i8** %l1
  %t204 = call i8* @trim_text(i8* %t203)
  %t205 = call i8* @trim_trailing_delimiters(i8* %t204)
  store i8* %t205, i8** %l7
  %t206 = load i8*, i8** %l7
  %t207 = alloca [2 x i8], align 1
  %t208 = getelementptr [2 x i8], [2 x i8]* %t207, i32 0, i32 0
  store i8 125, i8* %t208
  %t209 = getelementptr [2 x i8], [2 x i8]* %t207, i32 0, i32 1
  store i8 0, i8* %t209
  %t210 = getelementptr [2 x i8], [2 x i8]* %t207, i32 0, i32 0
  %t211 = call i1 @ends_with(i8* %t206, i8* %t210)
  %t212 = xor i1 %t211, 1
  %t213 = load i8*, i8** %l0
  %t214 = load i8*, i8** %l1
  %t215 = load double, double* %l2
  %t216 = load double, double* %l3
  %t217 = load double, double* %l4
  %t218 = load i8*, i8** %l7
  br i1 %t212, label %then20, label %merge21
then20:
  %t219 = load i8*, i8** %l0
  %t220 = insertvalue %StructLiteralCapture undef, i8* %t219, 0
  %t221 = sitofp i64 0 to double
  %t222 = insertvalue %StructLiteralCapture %t220, double %t221, 1
  %t223 = insertvalue %StructLiteralCapture %t222, i1 0, 2
  ret %StructLiteralCapture %t223
merge21:
  %t224 = load i8*, i8** %l7
  %t225 = insertvalue %StructLiteralCapture undef, i8* %t224, 0
  %t226 = load double, double* %l3
  %t227 = insertvalue %StructLiteralCapture %t225, double %t226, 1
  %t228 = insertvalue %StructLiteralCapture %t227, i1 1, 2
  ret %StructLiteralCapture %t228
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
  %s2 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.2, i32 0, i32 0
  store i8* %s2, i8** %l0
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l1
  %t4 = load i8*, i8** %l0
  %t5 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t183 = phi i8* [ %t4, %entry ], [ %t181, %loop.latch4 ]
  %t184 = phi double [ %t5, %entry ], [ %t182, %loop.latch4 ]
  store i8* %t183, i8** %l0
  store double %t184, double* %l1
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
  %t21 = getelementptr i8, i8* %t20, i64 0
  %t22 = load i8, i8* %t21
  %t23 = icmp eq i8 %t22, 39
  br label %logical_or_entry_19

logical_or_entry_19:
  br i1 %t23, label %logical_or_merge_19, label %logical_or_right_19

logical_or_right_19:
  %t24 = load i8*, i8** %l2
  %t25 = getelementptr i8, i8* %t24, i64 0
  %t26 = load i8, i8* %t25
  %t27 = icmp eq i8 %t26, 34
  br label %logical_or_right_end_19

logical_or_right_end_19:
  br label %logical_or_merge_19

logical_or_merge_19:
  %t28 = phi i1 [ true, %logical_or_entry_19 ], [ %t27, %logical_or_right_end_19 ]
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
  %t37 = fptosi double %t35 to i64
  %t38 = fptosi double %t36 to i64
  %t39 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t37, i64 %t38)
  %t40 = add i8* %t34, %t39
  store i8* %t40, i8** %l0
  %t41 = load double, double* %l3
  store double %t41, double* %l1
  br label %loop.latch4
merge9:
  %t42 = load i8*, i8** %l2
  %t43 = getelementptr i8, i8* %t42, i64 0
  %t44 = load i8, i8* %t43
  %t45 = icmp eq i8 %t44, 38
  %t46 = load i8*, i8** %l0
  %t47 = load double, double* %l1
  %t48 = load i8*, i8** %l2
  br i1 %t45, label %then10, label %merge11
then10:
  %t49 = load double, double* %l1
  %t50 = sitofp i64 1 to double
  %t51 = fadd double %t49, %t50
  %t52 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t53 = sitofp i64 %t52 to double
  %t54 = fcmp olt double %t51, %t53
  %t55 = load i8*, i8** %l0
  %t56 = load double, double* %l1
  %t57 = load i8*, i8** %l2
  br i1 %t54, label %then12, label %merge13
then12:
  %t58 = load double, double* %l1
  %t59 = sitofp i64 1 to double
  %t60 = fadd double %t58, %t59
  %t61 = load double, double* %l1
  %t62 = sitofp i64 2 to double
  %t63 = fadd double %t61, %t62
  %t64 = fptosi double %t60 to i64
  %t65 = fptosi double %t63 to i64
  %t66 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t64, i64 %t65)
  store i8* %t66, i8** %l4
  %t67 = load i8*, i8** %l4
  %t68 = getelementptr i8, i8* %t67, i64 0
  %t69 = load i8, i8* %t68
  %t70 = icmp eq i8 %t69, 38
  %t71 = load i8*, i8** %l0
  %t72 = load double, double* %l1
  %t73 = load i8*, i8** %l2
  %t74 = load i8*, i8** %l4
  br i1 %t70, label %then14, label %merge15
then14:
  %t75 = load i8*, i8** %l0
  %s76 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.76, i32 0, i32 0
  %t77 = add i8* %t75, %s76
  store i8* %t77, i8** %l0
  %t78 = load double, double* %l1
  %t79 = sitofp i64 2 to double
  %t80 = fadd double %t78, %t79
  store double %t80, double* %l1
  br label %loop.latch4
merge15:
  br label %merge13
merge13:
  %t81 = phi i8* [ %t77, %then12 ], [ %t55, %then10 ]
  %t82 = phi double [ %t80, %then12 ], [ %t56, %then10 ]
  store i8* %t81, i8** %l0
  store double %t82, double* %l1
  br label %merge11
merge11:
  %t83 = phi i8* [ %t77, %then10 ], [ %t46, %loop.body3 ]
  %t84 = phi double [ %t80, %then10 ], [ %t47, %loop.body3 ]
  store i8* %t83, i8** %l0
  store double %t84, double* %l1
  %t85 = load i8*, i8** %l2
  %t86 = getelementptr i8, i8* %t85, i64 0
  %t87 = load i8, i8* %t86
  %t88 = icmp eq i8 %t87, 124
  %t89 = load i8*, i8** %l0
  %t90 = load double, double* %l1
  %t91 = load i8*, i8** %l2
  br i1 %t88, label %then16, label %merge17
then16:
  %t92 = load double, double* %l1
  %t93 = sitofp i64 1 to double
  %t94 = fadd double %t92, %t93
  %t95 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t96 = sitofp i64 %t95 to double
  %t97 = fcmp olt double %t94, %t96
  %t98 = load i8*, i8** %l0
  %t99 = load double, double* %l1
  %t100 = load i8*, i8** %l2
  br i1 %t97, label %then18, label %merge19
then18:
  %t101 = load double, double* %l1
  %t102 = sitofp i64 1 to double
  %t103 = fadd double %t101, %t102
  %t104 = load double, double* %l1
  %t105 = sitofp i64 2 to double
  %t106 = fadd double %t104, %t105
  %t107 = fptosi double %t103 to i64
  %t108 = fptosi double %t106 to i64
  %t109 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t107, i64 %t108)
  store i8* %t109, i8** %l5
  %t110 = load i8*, i8** %l5
  %t111 = getelementptr i8, i8* %t110, i64 0
  %t112 = load i8, i8* %t111
  %t113 = icmp eq i8 %t112, 124
  %t114 = load i8*, i8** %l0
  %t115 = load double, double* %l1
  %t116 = load i8*, i8** %l2
  %t117 = load i8*, i8** %l5
  br i1 %t113, label %then20, label %merge21
then20:
  %t118 = load i8*, i8** %l0
  %s119 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.119, i32 0, i32 0
  %t120 = add i8* %t118, %s119
  store i8* %t120, i8** %l0
  %t121 = load double, double* %l1
  %t122 = sitofp i64 2 to double
  %t123 = fadd double %t121, %t122
  store double %t123, double* %l1
  br label %loop.latch4
merge21:
  br label %merge19
merge19:
  %t124 = phi i8* [ %t120, %then18 ], [ %t98, %then16 ]
  %t125 = phi double [ %t123, %then18 ], [ %t99, %then16 ]
  store i8* %t124, i8** %l0
  store double %t125, double* %l1
  br label %merge17
merge17:
  %t126 = phi i8* [ %t120, %then16 ], [ %t89, %loop.body3 ]
  %t127 = phi double [ %t123, %then16 ], [ %t90, %loop.body3 ]
  store i8* %t126, i8** %l0
  store double %t127, double* %l1
  %t128 = load i8*, i8** %l2
  %t129 = getelementptr i8, i8* %t128, i64 0
  %t130 = load i8, i8* %t129
  %t131 = icmp eq i8 %t130, 33
  %t132 = load i8*, i8** %l0
  %t133 = load double, double* %l1
  %t134 = load i8*, i8** %l2
  br i1 %t131, label %then22, label %merge23
then22:
  %t135 = load double, double* %l1
  %t136 = sitofp i64 1 to double
  %t137 = fadd double %t135, %t136
  %t138 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t139 = sitofp i64 %t138 to double
  %t140 = fcmp olt double %t137, %t139
  %t141 = load i8*, i8** %l0
  %t142 = load double, double* %l1
  %t143 = load i8*, i8** %l2
  br i1 %t140, label %then24, label %merge25
then24:
  %t144 = load double, double* %l1
  %t145 = sitofp i64 1 to double
  %t146 = fadd double %t144, %t145
  %t147 = load double, double* %l1
  %t148 = sitofp i64 2 to double
  %t149 = fadd double %t147, %t148
  %t150 = fptosi double %t146 to i64
  %t151 = fptosi double %t149 to i64
  %t152 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t150, i64 %t151)
  store i8* %t152, i8** %l6
  %t153 = load i8*, i8** %l6
  %t154 = getelementptr i8, i8* %t153, i64 0
  %t155 = load i8, i8* %t154
  %t156 = icmp eq i8 %t155, 61
  %t157 = load i8*, i8** %l0
  %t158 = load double, double* %l1
  %t159 = load i8*, i8** %l2
  %t160 = load i8*, i8** %l6
  br i1 %t156, label %then26, label %merge27
then26:
  %t161 = load i8*, i8** %l0
  %s162 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.162, i32 0, i32 0
  %t163 = add i8* %t161, %s162
  store i8* %t163, i8** %l0
  %t164 = load double, double* %l1
  %t165 = sitofp i64 2 to double
  %t166 = fadd double %t164, %t165
  store double %t166, double* %l1
  br label %loop.latch4
merge27:
  br label %merge25
merge25:
  %t167 = phi i8* [ %t163, %then24 ], [ %t141, %then22 ]
  %t168 = phi double [ %t166, %then24 ], [ %t142, %then22 ]
  store i8* %t167, i8** %l0
  store double %t168, double* %l1
  %t169 = load i8*, i8** %l0
  %s170 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.170, i32 0, i32 0
  %t171 = add i8* %t169, %s170
  store i8* %t171, i8** %l0
  %t172 = load double, double* %l1
  %t173 = sitofp i64 1 to double
  %t174 = fadd double %t172, %t173
  store double %t174, double* %l1
  br label %loop.latch4
merge23:
  %t175 = load i8*, i8** %l0
  %t176 = load i8*, i8** %l2
  %t177 = add i8* %t175, %t176
  store i8* %t177, i8** %l0
  %t178 = load double, double* %l1
  %t179 = sitofp i64 1 to double
  %t180 = fadd double %t178, %t179
  store double %t180, double* %l1
  br label %loop.latch4
loop.latch4:
  %t181 = load i8*, i8** %l0
  %t182 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t185 = load i8*, i8** %l0
  ret i8* %t185
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
  %s2 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.2, i32 0, i32 0
  store i8* %s2, i8** %l0
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l1
  %t4 = load i8*, i8** %l0
  %t5 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t132 = phi i8* [ %t4, %entry ], [ %t130, %loop.latch4 ]
  %t133 = phi double [ %t5, %entry ], [ %t131, %loop.latch4 ]
  store i8* %t132, i8** %l0
  store double %t133, double* %l1
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
  %t21 = getelementptr i8, i8* %t20, i64 0
  %t22 = load i8, i8* %t21
  %t23 = icmp eq i8 %t22, 39
  br label %logical_or_entry_19

logical_or_entry_19:
  br i1 %t23, label %logical_or_merge_19, label %logical_or_right_19

logical_or_right_19:
  %t24 = load i8*, i8** %l2
  %t25 = getelementptr i8, i8* %t24, i64 0
  %t26 = load i8, i8* %t25
  %t27 = icmp eq i8 %t26, 34
  br label %logical_or_right_end_19

logical_or_right_end_19:
  br label %logical_or_merge_19

logical_or_merge_19:
  %t28 = phi i1 [ true, %logical_or_entry_19 ], [ %t27, %logical_or_right_end_19 ]
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
  %t37 = fptosi double %t35 to i64
  %t38 = fptosi double %t36 to i64
  %t39 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t37, i64 %t38)
  %t40 = add i8* %t34, %t39
  store i8* %t40, i8** %l0
  %t41 = load double, double* %l3
  store double %t41, double* %l1
  br label %loop.latch4
merge9:
  %t42 = load i8*, i8** %l2
  %t43 = call i1 @is_identifier_char(i8* %t42)
  %t44 = load i8*, i8** %l0
  %t45 = load double, double* %l1
  %t46 = load i8*, i8** %l2
  br i1 %t43, label %then10, label %merge11
then10:
  %t47 = load double, double* %l1
  store double %t47, double* %l4
  %t48 = load i8*, i8** %l0
  %t49 = load double, double* %l1
  %t50 = load i8*, i8** %l2
  %t51 = load double, double* %l4
  br label %loop.header12
loop.header12:
  %t79 = phi double [ %t49, %then10 ], [ %t78, %loop.latch14 ]
  store double %t79, double* %l1
  br label %loop.body13
loop.body13:
  %t52 = load double, double* %l1
  %t53 = sitofp i64 1 to double
  %t54 = fadd double %t52, %t53
  store double %t54, double* %l1
  %t55 = load double, double* %l1
  %t56 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t57 = sitofp i64 %t56 to double
  %t58 = fcmp oge double %t55, %t57
  %t59 = load i8*, i8** %l0
  %t60 = load double, double* %l1
  %t61 = load i8*, i8** %l2
  %t62 = load double, double* %l4
  br i1 %t58, label %then16, label %merge17
then16:
  br label %afterloop15
merge17:
  %t63 = load double, double* %l1
  %t64 = load double, double* %l1
  %t65 = sitofp i64 1 to double
  %t66 = fadd double %t64, %t65
  %t67 = fptosi double %t63 to i64
  %t68 = fptosi double %t66 to i64
  %t69 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t67, i64 %t68)
  store i8* %t69, i8** %l5
  %t70 = load i8*, i8** %l5
  %t71 = call i1 @is_identifier_char(i8* %t70)
  %t72 = xor i1 %t71, 1
  %t73 = load i8*, i8** %l0
  %t74 = load double, double* %l1
  %t75 = load i8*, i8** %l2
  %t76 = load double, double* %l4
  %t77 = load i8*, i8** %l5
  br i1 %t72, label %then18, label %merge19
then18:
  br label %afterloop15
merge19:
  br label %loop.latch14
loop.latch14:
  %t78 = load double, double* %l1
  br label %loop.header12
afterloop15:
  %t80 = load double, double* %l4
  %t81 = load double, double* %l1
  %t82 = fptosi double %t80 to i64
  %t83 = fptosi double %t81 to i64
  %t84 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t82, i64 %t83)
  store i8* %t84, i8** %l6
  %t85 = load i8*, i8** %l6
  %s86 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.86, i32 0, i32 0
  %t87 = icmp eq i8* %t85, %s86
  %t88 = load i8*, i8** %l0
  %t89 = load double, double* %l1
  %t90 = load i8*, i8** %l2
  %t91 = load double, double* %l4
  %t92 = load i8*, i8** %l6
  br i1 %t87, label %then20, label %else21
then20:
  %t93 = load i8*, i8** %l0
  %s94 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.94, i32 0, i32 0
  %t95 = add i8* %t93, %s94
  store i8* %t95, i8** %l0
  br label %merge22
else21:
  %t96 = load i8*, i8** %l6
  %s97 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.97, i32 0, i32 0
  %t98 = icmp eq i8* %t96, %s97
  %t99 = load i8*, i8** %l0
  %t100 = load double, double* %l1
  %t101 = load i8*, i8** %l2
  %t102 = load double, double* %l4
  %t103 = load i8*, i8** %l6
  br i1 %t98, label %then23, label %else24
then23:
  %t104 = load i8*, i8** %l0
  %s105 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.105, i32 0, i32 0
  %t106 = add i8* %t104, %s105
  store i8* %t106, i8** %l0
  br label %merge25
else24:
  %t107 = load i8*, i8** %l6
  %s108 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.108, i32 0, i32 0
  %t109 = icmp eq i8* %t107, %s108
  %t110 = load i8*, i8** %l0
  %t111 = load double, double* %l1
  %t112 = load i8*, i8** %l2
  %t113 = load double, double* %l4
  %t114 = load i8*, i8** %l6
  br i1 %t109, label %then26, label %else27
then26:
  %t115 = load i8*, i8** %l0
  %s116 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.116, i32 0, i32 0
  %t117 = add i8* %t115, %s116
  store i8* %t117, i8** %l0
  br label %merge28
else27:
  %t118 = load i8*, i8** %l0
  %t119 = load i8*, i8** %l6
  %t120 = add i8* %t118, %t119
  store i8* %t120, i8** %l0
  br label %merge28
merge28:
  %t121 = phi i8* [ %t117, %then26 ], [ %t120, %else27 ]
  store i8* %t121, i8** %l0
  br label %merge25
merge25:
  %t122 = phi i8* [ %t106, %then23 ], [ %t117, %else24 ]
  store i8* %t122, i8** %l0
  br label %merge22
merge22:
  %t123 = phi i8* [ %t95, %then20 ], [ %t106, %else21 ]
  store i8* %t123, i8** %l0
  br label %loop.latch4
merge11:
  %t124 = load i8*, i8** %l0
  %t125 = load i8*, i8** %l2
  %t126 = add i8* %t124, %t125
  store i8* %t126, i8** %l0
  %t127 = load double, double* %l1
  %t128 = sitofp i64 1 to double
  %t129 = fadd double %t127, %t128
  store double %t129, double* %l1
  br label %loop.latch4
loop.latch4:
  %t130 = load i8*, i8** %l0
  %t131 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t134 = load i8*, i8** %l0
  ret i8* %t134
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
  %s2 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.2, i32 0, i32 0
  store i8* %s2, i8** %l0
  %s3 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.3, i32 0, i32 0
  store i8* %s3, i8** %l1
  %s4 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.4, i32 0, i32 0
  store i8* %s4, i8** %l2
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l3
  %t6 = load i8*, i8** %l0
  %t7 = load i8*, i8** %l1
  %t8 = load i8*, i8** %l2
  %t9 = load double, double* %l3
  br label %loop.header2
loop.header2:
  %t99 = phi i8* [ %t8, %entry ], [ %t97, %loop.latch4 ]
  %t100 = phi double [ %t9, %entry ], [ %t98, %loop.latch4 ]
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
  %t27 = getelementptr i8, i8* %t26, i64 0
  %t28 = load i8, i8* %t27
  %t29 = icmp eq i8 %t28, 39
  br label %logical_or_entry_25

logical_or_entry_25:
  br i1 %t29, label %logical_or_merge_25, label %logical_or_right_25

logical_or_right_25:
  %t30 = load i8*, i8** %l4
  %t31 = getelementptr i8, i8* %t30, i64 0
  %t32 = load i8, i8* %t31
  %t33 = icmp eq i8 %t32, 34
  br label %logical_or_right_end_25

logical_or_right_end_25:
  br label %logical_or_merge_25

logical_or_merge_25:
  %t34 = phi i1 [ true, %logical_or_entry_25 ], [ %t33, %logical_or_right_end_25 ]
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
  %t45 = fptosi double %t43 to i64
  %t46 = fptosi double %t44 to i64
  %t47 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t45, i64 %t46)
  %t48 = add i8* %t42, %t47
  store i8* %t48, i8** %l2
  %t49 = load double, double* %l5
  store double %t49, double* %l3
  br label %loop.latch4
merge9:
  %t50 = load double, double* %l3
  %t51 = load i8*, i8** %l0
  %t52 = call i64 @sailfin_runtime_string_length(i8* %t51)
  %t53 = sitofp i64 %t52 to double
  %t54 = fadd double %t50, %t53
  %t55 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t56 = sitofp i64 %t55 to double
  %t57 = fcmp ole double %t54, %t56
  %t58 = load i8*, i8** %l0
  %t59 = load i8*, i8** %l1
  %t60 = load i8*, i8** %l2
  %t61 = load double, double* %l3
  %t62 = load i8*, i8** %l4
  br i1 %t57, label %then10, label %merge11
then10:
  %t63 = load double, double* %l3
  %t64 = load double, double* %l3
  %t65 = load i8*, i8** %l0
  %t66 = call i64 @sailfin_runtime_string_length(i8* %t65)
  %t67 = sitofp i64 %t66 to double
  %t68 = fadd double %t64, %t67
  %t69 = fptosi double %t63 to i64
  %t70 = fptosi double %t68 to i64
  %t71 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t69, i64 %t70)
  store i8* %t71, i8** %l6
  %t72 = load i8*, i8** %l6
  %t73 = load i8*, i8** %l0
  %t74 = icmp eq i8* %t72, %t73
  %t75 = load i8*, i8** %l0
  %t76 = load i8*, i8** %l1
  %t77 = load i8*, i8** %l2
  %t78 = load double, double* %l3
  %t79 = load i8*, i8** %l4
  %t80 = load i8*, i8** %l6
  br i1 %t74, label %then12, label %merge13
then12:
  %t81 = load i8*, i8** %l2
  %t82 = load i8*, i8** %l1
  %t83 = add i8* %t81, %t82
  store i8* %t83, i8** %l2
  %t84 = load double, double* %l3
  %t85 = load i8*, i8** %l0
  %t86 = call i64 @sailfin_runtime_string_length(i8* %t85)
  %t87 = sitofp i64 %t86 to double
  %t88 = fadd double %t84, %t87
  store double %t88, double* %l3
  br label %loop.latch4
merge13:
  br label %merge11
merge11:
  %t89 = phi i8* [ %t83, %then10 ], [ %t60, %loop.body3 ]
  %t90 = phi double [ %t88, %then10 ], [ %t61, %loop.body3 ]
  store i8* %t89, i8** %l2
  store double %t90, double* %l3
  %t91 = load i8*, i8** %l2
  %t92 = load i8*, i8** %l4
  %t93 = add i8* %t91, %t92
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
  ret i8* %t101
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
  %t77 = phi i8* [ %t0, %entry ], [ %t76, %loop.latch2 ]
  store i8* %t77, i8** %l0
  br label %loop.body1
loop.body1:
  %t1 = load i8*, i8** %l0
  %s2 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.2, i32 0, i32 0
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
  %t51 = getelementptr i8, i8* %t50, i64 0
  %t52 = load i8, i8* %t51
  %t53 = add i8 40, %t52
  %s54 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.54, i32 0, i32 0
  %t55 = getelementptr i8, i8* %s54, i64 0
  %t56 = load i8, i8* %t55
  %t57 = add i8 %t53, %t56
  %t58 = load i8*, i8** %l8
  %t59 = getelementptr i8, i8* %t58, i64 0
  %t60 = load i8, i8* %t59
  %t61 = add i8 %t57, %t60
  %t62 = add i8 %t61, 41
  store i8 %t62, i8* %l9
  %t63 = load i8*, i8** %l5
  %t64 = load i8, i8* %l9
  %t65 = getelementptr i8, i8* %t63, i64 0
  %t66 = load i8, i8* %t65
  %t67 = add i8 %t66, %t64
  %t68 = load i8*, i8** %l6
  %t69 = getelementptr i8, i8* %t68, i64 0
  %t70 = load i8, i8* %t69
  %t71 = add i8 %t67, %t70
  %t72 = alloca [2 x i8], align 1
  %t73 = getelementptr [2 x i8], [2 x i8]* %t72, i32 0, i32 0
  store i8 %t71, i8* %t73
  %t74 = getelementptr [2 x i8], [2 x i8]* %t72, i32 0, i32 1
  store i8 0, i8* %t74
  %t75 = getelementptr [2 x i8], [2 x i8]* %t72, i32 0, i32 0
  store i8* %t75, i8** %l0
  br label %loop.latch2
loop.latch2:
  %t76 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t78 = load i8*, i8** %l0
  ret i8* %t78
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
  %t60 = phi i8* [ %t0, %entry ], [ %t59, %loop.latch2 ]
  store i8* %t60, i8** %l0
  br label %loop.body1
loop.body1:
  %t1 = load i8*, i8** %l0
  %s2 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.2, i32 0, i32 0
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
  %s44 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.44, i32 0, i32 0
  %t45 = add i8* %t43, %s44
  %t46 = load i8*, i8** %l5
  %t47 = add i8* %t45, %t46
  %t48 = getelementptr i8, i8* %t47, i64 0
  %t49 = load i8, i8* %t48
  %t50 = add i8 %t49, 41
  %t51 = load i8*, i8** %l4
  %t52 = getelementptr i8, i8* %t51, i64 0
  %t53 = load i8, i8* %t52
  %t54 = add i8 %t50, %t53
  %t55 = alloca [2 x i8], align 1
  %t56 = getelementptr [2 x i8], [2 x i8]* %t55, i32 0, i32 0
  store i8 %t54, i8* %t56
  %t57 = getelementptr [2 x i8], [2 x i8]* %t55, i32 0, i32 1
  store i8 0, i8* %t57
  %t58 = getelementptr [2 x i8], [2 x i8]* %t55, i32 0, i32 0
  store i8* %t58, i8** %l0
  br label %loop.latch2
loop.latch2:
  %t59 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t61 = load i8*, i8** %l0
  ret i8* %t61
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
  %s2 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.2, i32 0, i32 0
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
  %t132 = phi double [ %t14, %entry ], [ %t129, %loop.latch4 ]
  %t133 = phi double [ %t13, %entry ], [ %t130, %loop.latch4 ]
  %t134 = phi double [ %t15, %entry ], [ %t131, %loop.latch4 ]
  store double %t132, double* %l1
  store double %t133, double* %l0
  store double %t134, double* %l2
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
  %t30 = getelementptr i8, i8* %t29, i64 0
  %t31 = load i8, i8* %t30
  %t32 = icmp eq i8 %t31, 93
  %t33 = load double, double* %l0
  %t34 = load double, double* %l1
  %t35 = load double, double* %l2
  %t36 = load i8*, i8** %l3
  br i1 %t32, label %then8, label %merge9
then8:
  %t37 = load double, double* %l1
  %t38 = sitofp i64 1 to double
  %t39 = fadd double %t37, %t38
  store double %t39, double* %l1
  %t40 = load double, double* %l0
  %t41 = sitofp i64 1 to double
  %t42 = fsub double %t40, %t41
  store double %t42, double* %l0
  br label %loop.latch4
merge9:
  %t43 = load i8*, i8** %l3
  %t44 = getelementptr i8, i8* %t43, i64 0
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
  %t65 = getelementptr i8, i8* %t64, i64 0
  %t66 = load i8, i8* %t65
  %t67 = icmp eq i8 %t66, 41
  %t68 = load double, double* %l0
  %t69 = load double, double* %l1
  %t70 = load double, double* %l2
  %t71 = load i8*, i8** %l3
  br i1 %t67, label %then14, label %merge15
then14:
  %t72 = load double, double* %l2
  %t73 = sitofp i64 1 to double
  %t74 = fadd double %t72, %t73
  store double %t74, double* %l2
  %t75 = load double, double* %l0
  %t76 = sitofp i64 1 to double
  %t77 = fsub double %t75, %t76
  store double %t77, double* %l0
  br label %loop.latch4
merge15:
  %t78 = load i8*, i8** %l3
  %t79 = getelementptr i8, i8* %t78, i64 0
  %t80 = load i8, i8* %t79
  %t81 = icmp eq i8 %t80, 40
  %t82 = load double, double* %l0
  %t83 = load double, double* %l1
  %t84 = load double, double* %l2
  %t85 = load i8*, i8** %l3
  br i1 %t81, label %then16, label %merge17
then16:
  %t86 = load double, double* %l2
  %t87 = sitofp i64 0 to double
  %t88 = fcmp ogt double %t86, %t87
  %t89 = load double, double* %l0
  %t90 = load double, double* %l1
  %t91 = load double, double* %l2
  %t92 = load i8*, i8** %l3
  br i1 %t88, label %then18, label %merge19
then18:
  %t93 = load double, double* %l2
  %t94 = sitofp i64 1 to double
  %t95 = fsub double %t93, %t94
  store double %t95, double* %l2
  %t96 = load double, double* %l0
  %t97 = sitofp i64 1 to double
  %t98 = fsub double %t96, %t97
  store double %t98, double* %l0
  br label %loop.latch4
merge19:
  br label %afterloop5
merge17:
  %t100 = load double, double* %l1
  %t101 = sitofp i64 0 to double
  %t102 = fcmp ogt double %t100, %t101
  br label %logical_or_entry_99

logical_or_entry_99:
  br i1 %t102, label %logical_or_merge_99, label %logical_or_right_99

logical_or_right_99:
  %t103 = load double, double* %l2
  %t104 = sitofp i64 0 to double
  %t105 = fcmp ogt double %t103, %t104
  br label %logical_or_right_end_99

logical_or_right_end_99:
  br label %logical_or_merge_99

logical_or_merge_99:
  %t106 = phi i1 [ true, %logical_or_entry_99 ], [ %t105, %logical_or_right_end_99 ]
  %t107 = load double, double* %l0
  %t108 = load double, double* %l1
  %t109 = load double, double* %l2
  %t110 = load i8*, i8** %l3
  br i1 %t106, label %then20, label %merge21
then20:
  %t111 = load double, double* %l0
  %t112 = sitofp i64 1 to double
  %t113 = fsub double %t111, %t112
  store double %t113, double* %l0
  br label %loop.latch4
merge21:
  %t115 = load i8*, i8** %l3
  %t116 = call i1 @is_identifier_char(i8* %t115)
  br label %logical_or_entry_114

logical_or_entry_114:
  br i1 %t116, label %logical_or_merge_114, label %logical_or_right_114

logical_or_right_114:
  %t117 = load i8*, i8** %l3
  %t118 = getelementptr i8, i8* %t117, i64 0
  %t119 = load i8, i8* %t118
  %t120 = icmp eq i8 %t119, 46
  br label %logical_or_right_end_114

logical_or_right_end_114:
  br label %logical_or_merge_114

logical_or_merge_114:
  %t121 = phi i1 [ true, %logical_or_entry_114 ], [ %t120, %logical_or_right_end_114 ]
  %t122 = load double, double* %l0
  %t123 = load double, double* %l1
  %t124 = load double, double* %l2
  %t125 = load i8*, i8** %l3
  br i1 %t121, label %then22, label %merge23
then22:
  %t126 = load double, double* %l0
  %t127 = sitofp i64 1 to double
  %t128 = fsub double %t126, %t127
  store double %t128, double* %l0
  br label %loop.latch4
merge23:
  br label %afterloop5
loop.latch4:
  %t129 = load double, double* %l1
  %t130 = load double, double* %l0
  %t131 = load double, double* %l2
  br label %loop.header2
afterloop5:
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
  %s144 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.144, i32 0, i32 0
  %t145 = insertvalue %ExtractedSpan undef, i8* %s144, 0
  %t146 = load double, double* %l4
  %t147 = insertvalue %ExtractedSpan %t145, double %t146, 1
  %t148 = insertvalue %ExtractedSpan %t147, double %dot_index, 2
  %t149 = insertvalue %ExtractedSpan %t148, i1 0, 3
  ret %ExtractedSpan %t149
merge25:
  %t150 = load double, double* %l4
  %t151 = fptosi double %t150 to i64
  %t152 = fptosi double %dot_index to i64
  %t153 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t151, i64 %t152)
  store i8* %t153, i8** %l5
  %t154 = load i8*, i8** %l5
  %t155 = insertvalue %ExtractedSpan undef, i8* %t154, 0
  %t156 = load double, double* %l4
  %t157 = insertvalue %ExtractedSpan %t155, double %t156, 1
  %t158 = insertvalue %ExtractedSpan %t157, double %dot_index, 2
  %t159 = insertvalue %ExtractedSpan %t158, i1 1, 3
  ret %ExtractedSpan %t159
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
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.3, i32 0, i32 0
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
  %t13 = getelementptr i8, i8* %t12, i64 0
  %t14 = load i8, i8* %t13
  %t15 = icmp ne i8 %t14, 40
  br i1 %t15, label %then2, label %merge3
then2:
  %s16 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.16, i32 0, i32 0
  %t17 = insertvalue %ExtractedSpan undef, i8* %s16, 0
  %t18 = insertvalue %ExtractedSpan %t17, double %open_index, 1
  %t19 = insertvalue %ExtractedSpan %t18, double %open_index, 2
  %t20 = insertvalue %ExtractedSpan %t19, i1 0, 3
  ret %ExtractedSpan %t20
merge3:
  %t21 = sitofp i64 1 to double
  %t22 = fadd double %open_index, %t21
  store double %t22, double* %l0
  %t23 = sitofp i64 1 to double
  store double %t23, double* %l1
  %t24 = load double, double* %l0
  %t25 = load double, double* %l1
  br label %loop.header4
loop.header4:
  %t95 = phi double [ %t25, %entry ], [ %t93, %loop.latch6 ]
  %t96 = phi double [ %t24, %entry ], [ %t94, %loop.latch6 ]
  store double %t95, double* %l1
  store double %t96, double* %l0
  br label %loop.body5
loop.body5:
  %t26 = load double, double* %l0
  %t27 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t28 = sitofp i64 %t27 to double
  %t29 = fcmp oge double %t26, %t28
  %t30 = load double, double* %l0
  %t31 = load double, double* %l1
  br i1 %t29, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t32 = load double, double* %l0
  %t33 = load double, double* %l0
  %t34 = sitofp i64 1 to double
  %t35 = fadd double %t33, %t34
  %t36 = fptosi double %t32 to i64
  %t37 = fptosi double %t35 to i64
  %t38 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t36, i64 %t37)
  store i8* %t38, i8** %l2
  %t39 = load i8*, i8** %l2
  %t40 = getelementptr i8, i8* %t39, i64 0
  %t41 = load i8, i8* %t40
  %t42 = icmp eq i8 %t41, 40
  %t43 = load double, double* %l0
  %t44 = load double, double* %l1
  %t45 = load i8*, i8** %l2
  br i1 %t42, label %then10, label %else11
then10:
  %t46 = load double, double* %l1
  %t47 = sitofp i64 1 to double
  %t48 = fadd double %t46, %t47
  store double %t48, double* %l1
  br label %merge12
else11:
  %t49 = load i8*, i8** %l2
  %t50 = getelementptr i8, i8* %t49, i64 0
  %t51 = load i8, i8* %t50
  %t52 = icmp eq i8 %t51, 41
  %t53 = load double, double* %l0
  %t54 = load double, double* %l1
  %t55 = load i8*, i8** %l2
  br i1 %t52, label %then13, label %else14
then13:
  %t56 = load double, double* %l1
  %t57 = sitofp i64 1 to double
  %t58 = fsub double %t56, %t57
  store double %t58, double* %l1
  %t59 = load double, double* %l1
  %t60 = sitofp i64 0 to double
  %t61 = fcmp oeq double %t59, %t60
  %t62 = load double, double* %l0
  %t63 = load double, double* %l1
  %t64 = load i8*, i8** %l2
  br i1 %t61, label %then16, label %merge17
then16:
  %t65 = sitofp i64 1 to double
  %t66 = fadd double %open_index, %t65
  %t67 = load double, double* %l0
  %t68 = fptosi double %t66 to i64
  %t69 = fptosi double %t67 to i64
  %t70 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t68, i64 %t69)
  store i8* %t70, i8** %l3
  ret %ExtractedSpan zeroinitializer
merge17:
  br label %merge15
else14:
  %t72 = load i8*, i8** %l2
  %t73 = getelementptr i8, i8* %t72, i64 0
  %t74 = load i8, i8* %t73
  %t75 = icmp eq i8 %t74, 34
  br label %logical_or_entry_71

logical_or_entry_71:
  br i1 %t75, label %logical_or_merge_71, label %logical_or_right_71

logical_or_right_71:
  %t76 = load i8*, i8** %l2
  %t77 = getelementptr i8, i8* %t76, i64 0
  %t78 = load i8, i8* %t77
  %t79 = icmp eq i8 %t78, 39
  br label %logical_or_right_end_71

logical_or_right_end_71:
  br label %logical_or_merge_71

logical_or_merge_71:
  %t80 = phi i1 [ true, %logical_or_entry_71 ], [ %t79, %logical_or_right_end_71 ]
  %t81 = load double, double* %l0
  %t82 = load double, double* %l1
  %t83 = load i8*, i8** %l2
  br i1 %t80, label %then18, label %merge19
then18:
  %t84 = load double, double* %l0
  %t85 = call double @skip_string_literal(i8* %text, double %t84)
  store double %t85, double* %l0
  br label %loop.latch6
merge19:
  br label %merge15
merge15:
  %t86 = phi double [ %t58, %then13 ], [ %t54, %else14 ]
  %t87 = phi double [ %t53, %then13 ], [ %t85, %else14 ]
  store double %t86, double* %l1
  store double %t87, double* %l0
  br label %merge12
merge12:
  %t88 = phi double [ %t48, %then10 ], [ %t58, %else11 ]
  %t89 = phi double [ %t43, %then10 ], [ %t85, %else11 ]
  store double %t88, double* %l1
  store double %t89, double* %l0
  %t90 = load double, double* %l0
  %t91 = sitofp i64 1 to double
  %t92 = fadd double %t90, %t91
  store double %t92, double* %l0
  br label %loop.latch6
loop.latch6:
  %t93 = load double, double* %l1
  %t94 = load double, double* %l0
  br label %loop.header4
afterloop7:
  %s97 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.97, i32 0, i32 0
  %t98 = insertvalue %ExtractedSpan undef, i8* %s97, 0
  %t99 = insertvalue %ExtractedSpan %t98, double %open_index, 1
  %t100 = insertvalue %ExtractedSpan %t99, double %open_index, 2
  %t101 = insertvalue %ExtractedSpan %t100, i1 0, 3
  ret %ExtractedSpan %t101
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
  %t45 = phi double [ %t8, %entry ], [ %t44, %loop.latch2 ]
  store double %t45, double* %l1
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
  %t23 = getelementptr i8, i8* %t22, i64 0
  %t24 = load i8, i8* %t23
  %t25 = icmp eq i8 %t24, 92
  %t26 = load i8*, i8** %l0
  %t27 = load double, double* %l1
  %t28 = load i8*, i8** %l2
  br i1 %t25, label %then6, label %merge7
then6:
  %t29 = load double, double* %l1
  %t30 = sitofp i64 2 to double
  %t31 = fadd double %t29, %t30
  store double %t31, double* %l1
  br label %loop.latch2
merge7:
  %t32 = load i8*, i8** %l2
  %t33 = load i8*, i8** %l0
  %t34 = icmp eq i8* %t32, %t33
  %t35 = load i8*, i8** %l0
  %t36 = load double, double* %l1
  %t37 = load i8*, i8** %l2
  br i1 %t34, label %then8, label %merge9
then8:
  %t38 = load double, double* %l1
  %t39 = sitofp i64 1 to double
  %t40 = fadd double %t38, %t39
  store double %t40, double* %l1
  br label %afterloop3
merge9:
  %t41 = load double, double* %l1
  %t42 = sitofp i64 1 to double
  %t43 = fadd double %t41, %t42
  store double %t43, double* %l1
  br label %loop.latch2
loop.latch2:
  %t44 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t46 = load double, double* %l1
  ret double %t46
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
  %l8 = alloca double
  %l9 = alloca i8*
  %l10 = alloca i1
  %l11 = alloca double
  %l12 = alloca double
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
  %t273 = phi double [ %t36, %entry ], [ %t266, %loop.latch4 ]
  %t274 = phi double [ %t37, %entry ], [ %t267, %loop.latch4 ]
  %t275 = phi i1 [ %t38, %entry ], [ %t268, %loop.latch4 ]
  %t276 = phi i8* [ %t35, %entry ], [ %t269, %loop.latch4 ]
  %t277 = phi double [ %t32, %entry ], [ %t270, %loop.latch4 ]
  %t278 = phi double [ %t33, %entry ], [ %t271, %loop.latch4 ]
  %t279 = phi double [ %t34, %entry ], [ %t272, %loop.latch4 ]
  store double %t273, double* %l5
  store double %t274, double* %l6
  store i1 %t275, i1* %l7
  store i8* %t276, i8** %l4
  store double %t277, double* %l1
  store double %t278, double* %l2
  store double %t279, double* %l3
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
  %t60 = call double @continuation_segment_text(%NativeInstruction %t59)
  store double %t60, double* %l8
  %t61 = load double, double* %l8
  %t62 = load double, double* %l8
  %t63 = call i8* @trim_text(i8* null)
  store i8* %t63, i8** %l9
  %t64 = load i8*, i8** %l9
  %t65 = call i64 @sailfin_runtime_string_length(i8* %t64)
  %t66 = icmp eq i64 %t65, 0
  %t67 = load i8*, i8** %l0
  %t68 = load double, double* %l1
  %t69 = load double, double* %l2
  %t70 = load double, double* %l3
  %t71 = load i8*, i8** %l4
  %t72 = load double, double* %l5
  %t73 = load double, double* %l6
  %t74 = load i1, i1* %l7
  %t75 = load double, double* %l8
  %t76 = load i8*, i8** %l9
  br i1 %t66, label %then8, label %merge9
then8:
  %t77 = load double, double* %l5
  %t78 = sitofp i64 1 to double
  %t79 = fadd double %t77, %t78
  store double %t79, double* %l5
  %t80 = load double, double* %l6
  %t81 = sitofp i64 1 to double
  %t82 = fadd double %t80, %t81
  store double %t82, double* %l6
  br label %loop.latch4
merge9:
  %t83 = load i1, i1* %l7
  %t84 = xor i1 %t83, 1
  %t85 = load i8*, i8** %l0
  %t86 = load double, double* %l1
  %t87 = load double, double* %l2
  %t88 = load double, double* %l3
  %t89 = load i8*, i8** %l4
  %t90 = load double, double* %l5
  %t91 = load double, double* %l6
  %t92 = load i1, i1* %l7
  %t93 = load double, double* %l8
  %t94 = load i8*, i8** %l9
  br i1 %t84, label %then10, label %merge11
then10:
  %t95 = load i8*, i8** %l9
  %t96 = call i1 @segment_signals_expression_continuation(i8* %t95)
  %t97 = xor i1 %t96, 1
  %t98 = load i8*, i8** %l0
  %t99 = load double, double* %l1
  %t100 = load double, double* %l2
  %t101 = load double, double* %l3
  %t102 = load i8*, i8** %l4
  %t103 = load double, double* %l5
  %t104 = load double, double* %l6
  %t105 = load i1, i1* %l7
  %t106 = load double, double* %l8
  %t107 = load i8*, i8** %l9
  br i1 %t97, label %then12, label %merge13
then12:
  br label %afterloop5
merge13:
  store i1 1, i1* %l7
  br label %merge11
merge11:
  %t108 = phi i1 [ 1, %then10 ], [ %t92, %loop.body3 ]
  store i1 %t108, i1* %l7
  %t109 = load i8*, i8** %l4
  %t110 = getelementptr i8, i8* %t109, i64 0
  %t111 = load i8, i8* %t110
  %t112 = add i8 %t111, 32
  %t113 = load i8*, i8** %l9
  %t114 = getelementptr i8, i8* %t113, i64 0
  %t115 = load i8, i8* %t114
  %t116 = add i8 %t112, %t115
  %t117 = alloca [2 x i8], align 1
  %t118 = getelementptr [2 x i8], [2 x i8]* %t117, i32 0, i32 0
  store i8 %t116, i8* %t118
  %t119 = getelementptr [2 x i8], [2 x i8]* %t117, i32 0, i32 1
  store i8 0, i8* %t119
  %t120 = getelementptr [2 x i8], [2 x i8]* %t117, i32 0, i32 0
  store i8* %t120, i8** %l4
  %t121 = load double, double* %l1
  %t122 = load i8*, i8** %l9
  %t123 = call double @compute_parenthesis_balance(i8* %t122)
  %t124 = fadd double %t121, %t123
  store double %t124, double* %l1
  %t125 = load double, double* %l2
  %t126 = load i8*, i8** %l9
  %t127 = call double @compute_brace_balance(i8* %t126)
  %t128 = fadd double %t125, %t127
  store double %t128, double* %l2
  %t129 = load double, double* %l3
  %t130 = load i8*, i8** %l9
  %t131 = call double @compute_bracket_balance(i8* %t130)
  %t132 = fadd double %t129, %t131
  store double %t132, double* %l3
  %t133 = load double, double* %l6
  %t134 = sitofp i64 1 to double
  %t135 = fadd double %t133, %t134
  store double %t135, double* %l6
  %t136 = load double, double* %l5
  %t137 = sitofp i64 1 to double
  %t138 = fadd double %t136, %t137
  store double %t138, double* %l5
  %t140 = load double, double* %l1
  %t141 = sitofp i64 0 to double
  %t142 = fcmp ole double %t140, %t141
  br label %logical_and_entry_139

logical_and_entry_139:
  br i1 %t142, label %logical_and_right_139, label %logical_and_merge_139

logical_and_right_139:
  %t144 = load double, double* %l2
  %t145 = sitofp i64 0 to double
  %t146 = fcmp ole double %t144, %t145
  br label %logical_and_entry_143

logical_and_entry_143:
  br i1 %t146, label %logical_and_right_143, label %logical_and_merge_143

logical_and_right_143:
  %t147 = load double, double* %l3
  %t148 = sitofp i64 0 to double
  %t149 = fcmp ole double %t147, %t148
  br label %logical_and_right_end_143

logical_and_right_end_143:
  br label %logical_and_merge_143

logical_and_merge_143:
  %t150 = phi i1 [ false, %logical_and_entry_143 ], [ %t149, %logical_and_right_end_143 ]
  br label %logical_and_right_end_139

logical_and_right_end_139:
  br label %logical_and_merge_139

logical_and_merge_139:
  %t151 = phi i1 [ false, %logical_and_entry_139 ], [ %t150, %logical_and_right_end_139 ]
  %t152 = load i8*, i8** %l0
  %t153 = load double, double* %l1
  %t154 = load double, double* %l2
  %t155 = load double, double* %l3
  %t156 = load i8*, i8** %l4
  %t157 = load double, double* %l5
  %t158 = load double, double* %l6
  %t159 = load i1, i1* %l7
  %t160 = load double, double* %l8
  %t161 = load i8*, i8** %l9
  br i1 %t151, label %then14, label %merge15
then14:
  store i1 1, i1* %l10
  %t162 = load double, double* %l5
  store double %t162, double* %l11
  %t163 = load i8*, i8** %l0
  %t164 = load double, double* %l1
  %t165 = load double, double* %l2
  %t166 = load double, double* %l3
  %t167 = load i8*, i8** %l4
  %t168 = load double, double* %l5
  %t169 = load double, double* %l6
  %t170 = load i1, i1* %l7
  %t171 = load double, double* %l8
  %t172 = load i8*, i8** %l9
  %t173 = load i1, i1* %l10
  %t174 = load double, double* %l11
  br label %loop.header16
loop.header16:
  %t243 = phi double [ %t174, %then14 ], [ %t241, %loop.latch18 ]
  %t244 = phi i1 [ %t173, %then14 ], [ %t242, %loop.latch18 ]
  store double %t243, double* %l11
  store i1 %t244, i1* %l10
  br label %loop.body17
loop.body17:
  %t175 = load double, double* %l11
  %t176 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %instructions
  %t177 = extractvalue { %NativeInstruction*, i64 } %t176, 1
  %t178 = sitofp i64 %t177 to double
  %t179 = fcmp oge double %t175, %t178
  %t180 = load i8*, i8** %l0
  %t181 = load double, double* %l1
  %t182 = load double, double* %l2
  %t183 = load double, double* %l3
  %t184 = load i8*, i8** %l4
  %t185 = load double, double* %l5
  %t186 = load double, double* %l6
  %t187 = load i1, i1* %l7
  %t188 = load double, double* %l8
  %t189 = load i8*, i8** %l9
  %t190 = load i1, i1* %l10
  %t191 = load double, double* %l11
  br i1 %t179, label %then20, label %merge21
then20:
  br label %afterloop19
merge21:
  %t192 = load double, double* %l11
  %t193 = fptosi double %t192 to i64
  %t194 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %instructions
  %t195 = extractvalue { %NativeInstruction*, i64 } %t194, 0
  %t196 = extractvalue { %NativeInstruction*, i64 } %t194, 1
  %t197 = icmp uge i64 %t193, %t196
  ; bounds check: %t197 (if true, out of bounds)
  %t198 = getelementptr %NativeInstruction, %NativeInstruction* %t195, i64 %t193
  %t199 = load %NativeInstruction, %NativeInstruction* %t198
  %t200 = call double @continuation_segment_text(%NativeInstruction %t199)
  store double %t200, double* %l12
  %t201 = load double, double* %l12
  %t202 = load double, double* %l12
  %t203 = call i8* @trim_text(i8* null)
  store i8* %t203, i8** %l13
  %t204 = load i8*, i8** %l13
  %t205 = call i64 @sailfin_runtime_string_length(i8* %t204)
  %t206 = icmp eq i64 %t205, 0
  %t207 = load i8*, i8** %l0
  %t208 = load double, double* %l1
  %t209 = load double, double* %l2
  %t210 = load double, double* %l3
  %t211 = load i8*, i8** %l4
  %t212 = load double, double* %l5
  %t213 = load double, double* %l6
  %t214 = load i1, i1* %l7
  %t215 = load double, double* %l8
  %t216 = load i8*, i8** %l9
  %t217 = load i1, i1* %l10
  %t218 = load double, double* %l11
  %t219 = load double, double* %l12
  %t220 = load i8*, i8** %l13
  br i1 %t206, label %then22, label %merge23
then22:
  %t221 = load double, double* %l11
  %t222 = sitofp i64 1 to double
  %t223 = fadd double %t221, %t222
  store double %t223, double* %l11
  br label %loop.latch18
merge23:
  %t224 = load i8*, i8** %l13
  %t225 = call i1 @segment_signals_expression_continuation(i8* %t224)
  %t226 = load i8*, i8** %l0
  %t227 = load double, double* %l1
  %t228 = load double, double* %l2
  %t229 = load double, double* %l3
  %t230 = load i8*, i8** %l4
  %t231 = load double, double* %l5
  %t232 = load double, double* %l6
  %t233 = load i1, i1* %l7
  %t234 = load double, double* %l8
  %t235 = load i8*, i8** %l9
  %t236 = load i1, i1* %l10
  %t237 = load double, double* %l11
  %t238 = load double, double* %l12
  %t239 = load i8*, i8** %l13
  br i1 %t225, label %then24, label %merge25
then24:
  store i1 0, i1* %l10
  br label %merge25
merge25:
  %t240 = phi i1 [ 0, %then24 ], [ %t236, %loop.body17 ]
  store i1 %t240, i1* %l10
  br label %afterloop19
loop.latch18:
  %t241 = load double, double* %l11
  %t242 = load i1, i1* %l10
  br label %loop.header16
afterloop19:
  %t245 = load i1, i1* %l10
  %t246 = load i8*, i8** %l0
  %t247 = load double, double* %l1
  %t248 = load double, double* %l2
  %t249 = load double, double* %l3
  %t250 = load i8*, i8** %l4
  %t251 = load double, double* %l5
  %t252 = load double, double* %l6
  %t253 = load i1, i1* %l7
  %t254 = load double, double* %l8
  %t255 = load i8*, i8** %l9
  %t256 = load i1, i1* %l10
  %t257 = load double, double* %l11
  br i1 %t245, label %then26, label %merge27
then26:
  %t258 = load i8*, i8** %l4
  %t259 = call i8* @trim_text(i8* %t258)
  %t260 = call i8* @trim_trailing_delimiters(i8* %t259)
  store i8* %t260, i8** %l14
  %t261 = load i8*, i8** %l14
  %t262 = insertvalue %ExpressionContinuationCapture undef, i8* %t261, 0
  %t263 = load double, double* %l6
  %t264 = insertvalue %ExpressionContinuationCapture %t262, double %t263, 1
  %t265 = insertvalue %ExpressionContinuationCapture %t264, i1 1, 2
  ret %ExpressionContinuationCapture %t265
merge27:
  br label %merge15
merge15:
  br label %loop.latch4
loop.latch4:
  %t266 = load double, double* %l5
  %t267 = load double, double* %l6
  %t268 = load i1, i1* %l7
  %t269 = load i8*, i8** %l4
  %t270 = load double, double* %l1
  %t271 = load double, double* %l2
  %t272 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t281 = load i1, i1* %l7
  br label %logical_or_entry_280

logical_or_entry_280:
  br i1 %t281, label %logical_or_merge_280, label %logical_or_right_280

logical_or_right_280:
  %t282 = load double, double* %l6
  %t283 = sitofp i64 0 to double
  %t284 = fcmp oeq double %t282, %t283
  br label %logical_or_right_end_280

logical_or_right_end_280:
  br label %logical_or_merge_280

logical_or_merge_280:
  %t285 = phi i1 [ true, %logical_or_entry_280 ], [ %t284, %logical_or_right_end_280 ]
  %t286 = xor i1 %t285, 1
  %t287 = load i8*, i8** %l0
  %t288 = load double, double* %l1
  %t289 = load double, double* %l2
  %t290 = load double, double* %l3
  %t291 = load i8*, i8** %l4
  %t292 = load double, double* %l5
  %t293 = load double, double* %l6
  %t294 = load i1, i1* %l7
  br i1 %t286, label %then28, label %merge29
then28:
  %t295 = load i8*, i8** %l0
  %t296 = insertvalue %ExpressionContinuationCapture undef, i8* %t295, 0
  %t297 = sitofp i64 0 to double
  %t298 = insertvalue %ExpressionContinuationCapture %t296, double %t297, 1
  %t299 = insertvalue %ExpressionContinuationCapture %t298, i1 0, 2
  ret %ExpressionContinuationCapture %t299
merge29:
  %t301 = load double, double* %l1
  %t302 = sitofp i64 0 to double
  %t303 = fcmp ole double %t301, %t302
  br label %logical_and_entry_300

logical_and_entry_300:
  br i1 %t303, label %logical_and_right_300, label %logical_and_merge_300

logical_and_right_300:
  %t305 = load double, double* %l2
  %t306 = sitofp i64 0 to double
  %t307 = fcmp ole double %t305, %t306
  br label %logical_and_entry_304

logical_and_entry_304:
  br i1 %t307, label %logical_and_right_304, label %logical_and_merge_304

logical_and_right_304:
  %t308 = load double, double* %l3
  %t309 = sitofp i64 0 to double
  %t310 = fcmp ole double %t308, %t309
  br label %logical_and_right_end_304

logical_and_right_end_304:
  br label %logical_and_merge_304

logical_and_merge_304:
  %t311 = phi i1 [ false, %logical_and_entry_304 ], [ %t310, %logical_and_right_end_304 ]
  br label %logical_and_right_end_300

logical_and_right_end_300:
  br label %logical_and_merge_300

logical_and_merge_300:
  %t312 = phi i1 [ false, %logical_and_entry_300 ], [ %t311, %logical_and_right_end_300 ]
  %t313 = load i8*, i8** %l0
  %t314 = load double, double* %l1
  %t315 = load double, double* %l2
  %t316 = load double, double* %l3
  %t317 = load i8*, i8** %l4
  %t318 = load double, double* %l5
  %t319 = load double, double* %l6
  %t320 = load i1, i1* %l7
  br i1 %t312, label %then30, label %merge31
then30:
  %t321 = load i8*, i8** %l4
  %t322 = call i8* @trim_text(i8* %t321)
  %t323 = call i8* @trim_trailing_delimiters(i8* %t322)
  store i8* %t323, i8** %l15
  %t324 = load i8*, i8** %l15
  %t325 = insertvalue %ExpressionContinuationCapture undef, i8* %t324, 0
  %t326 = load double, double* %l6
  %t327 = insertvalue %ExpressionContinuationCapture %t325, double %t326, 1
  %t328 = insertvalue %ExpressionContinuationCapture %t327, i1 1, 2
  ret %ExpressionContinuationCapture %t328
merge31:
  %t329 = load i8*, i8** %l0
  %t330 = insertvalue %ExpressionContinuationCapture undef, i8* %t329, 0
  %t331 = sitofp i64 0 to double
  %t332 = insertvalue %ExpressionContinuationCapture %t330, double %t331, 1
  %t333 = insertvalue %ExpressionContinuationCapture %t332, i1 0, 2
  ret %ExpressionContinuationCapture %t333
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
  %s2 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.2, i32 0, i32 0
  %t3 = call i1 @starts_with(i8* %segment, i8* %s2)
  br i1 %t3, label %then2, label %merge3
then2:
  ret i1 1
merge3:
  %s4 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.4, i32 0, i32 0
  %t5 = call i1 @starts_with(i8* %segment, i8* %s4)
  br i1 %t5, label %then4, label %merge5
then4:
  ret i1 1
merge5:
  %t6 = sitofp i64 0 to double
  %t7 = call i8* @char_at(i8* %segment, double %t6)
  store i8* %t7, i8** %l0
  %t9 = load i8*, i8** %l0
  %t10 = getelementptr i8, i8* %t9, i64 0
  %t11 = load i8, i8* %t10
  %t12 = icmp eq i8 %t11, 46
  br label %logical_or_entry_8

logical_or_entry_8:
  br i1 %t12, label %logical_or_merge_8, label %logical_or_right_8

logical_or_right_8:
  %t14 = load i8*, i8** %l0
  %t15 = getelementptr i8, i8* %t14, i64 0
  %t16 = load i8, i8* %t15
  %t17 = icmp eq i8 %t16, 41
  br label %logical_or_entry_13

logical_or_entry_13:
  br i1 %t17, label %logical_or_merge_13, label %logical_or_right_13

logical_or_right_13:
  %t19 = load i8*, i8** %l0
  %t20 = getelementptr i8, i8* %t19, i64 0
  %t21 = load i8, i8* %t20
  %t22 = icmp eq i8 %t21, 93
  br label %logical_or_entry_18

logical_or_entry_18:
  br i1 %t22, label %logical_or_merge_18, label %logical_or_right_18

logical_or_right_18:
  %t23 = load i8*, i8** %l0
  %t24 = getelementptr i8, i8* %t23, i64 0
  %t25 = load i8, i8* %t24
  %t26 = icmp eq i8 %t25, 125
  br label %logical_or_right_end_18

logical_or_right_end_18:
  br label %logical_or_merge_18

logical_or_merge_18:
  %t27 = phi i1 [ true, %logical_or_entry_18 ], [ %t26, %logical_or_right_end_18 ]
  br label %logical_or_right_end_13

logical_or_right_end_13:
  br label %logical_or_merge_13

logical_or_merge_13:
  %t28 = phi i1 [ true, %logical_or_entry_13 ], [ %t27, %logical_or_right_end_13 ]
  br label %logical_or_right_end_8

logical_or_right_end_8:
  br label %logical_or_merge_8

logical_or_merge_8:
  %t29 = phi i1 [ true, %logical_or_entry_8 ], [ %t28, %logical_or_right_end_8 ]
  %t30 = load i8*, i8** %l0
  br i1 %t29, label %then6, label %merge7
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
  %t42 = phi double [ %t5, %entry ], [ %t40, %loop.latch4 ]
  %t43 = phi double [ %t6, %entry ], [ %t41, %loop.latch4 ]
  store double %t42, double* %l0
  store double %t43, double* %l1
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
  %t16 = getelementptr i8, i8* %t15, i64 0
  %t17 = load i8, i8* %t16
  %t18 = icmp eq i8 %t17, 123
  %t19 = load double, double* %l0
  %t20 = load double, double* %l1
  %t21 = load i8*, i8** %l2
  br i1 %t18, label %then8, label %else9
then8:
  %t22 = load double, double* %l0
  %t23 = sitofp i64 1 to double
  %t24 = fadd double %t22, %t23
  store double %t24, double* %l0
  br label %merge10
else9:
  %t25 = load i8*, i8** %l2
  %t26 = getelementptr i8, i8* %t25, i64 0
  %t27 = load i8, i8* %t26
  %t28 = icmp eq i8 %t27, 125
  %t29 = load double, double* %l0
  %t30 = load double, double* %l1
  %t31 = load i8*, i8** %l2
  br i1 %t28, label %then11, label %merge12
then11:
  %t32 = load double, double* %l0
  %t33 = sitofp i64 1 to double
  %t34 = fsub double %t32, %t33
  store double %t34, double* %l0
  br label %merge12
merge12:
  %t35 = phi double [ %t34, %then11 ], [ %t29, %else9 ]
  store double %t35, double* %l0
  br label %merge10
merge10:
  %t36 = phi double [ %t24, %then8 ], [ %t34, %else9 ]
  store double %t36, double* %l0
  %t37 = load double, double* %l1
  %t38 = sitofp i64 1 to double
  %t39 = fadd double %t37, %t38
  store double %t39, double* %l1
  br label %loop.latch4
loop.latch4:
  %t40 = load double, double* %l0
  %t41 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t44 = load double, double* %l0
  ret double %t44
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
  %s5 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.5, i32 0, i32 0
  store i8* %s5, i8** %l1
  %t6 = sitofp i64 0 to double
  store double %t6, double* %l2
  %t7 = sitofp i64 0 to double
  store double %t7, double* %l3
  store i1 0, i1* %l4
  %s8 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.8, i32 0, i32 0
  store i8* %s8, i8** %l5
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t10 = load i8*, i8** %l1
  %t11 = load double, double* %l2
  %t12 = load double, double* %l3
  %t13 = load i1, i1* %l4
  %t14 = load i8*, i8** %l5
  br label %loop.header0
loop.header0:
  %t208 = phi i8* [ %t10, %entry ], [ %t202, %loop.latch2 ]
  %t209 = phi double [ %t12, %entry ], [ %t203, %loop.latch2 ]
  %t210 = phi i1 [ %t13, %entry ], [ %t204, %loop.latch2 ]
  %t211 = phi i8* [ %t14, %entry ], [ %t205, %loop.latch2 ]
  %t212 = phi double [ %t11, %entry ], [ %t206, %loop.latch2 ]
  %t213 = phi { i8**, i64 }* [ %t9, %entry ], [ %t207, %loop.latch2 ]
  store i8* %t208, i8** %l1
  store double %t209, double* %l3
  store i1 %t210, i1* %l4
  store i8* %t211, i8** %l5
  store double %t212, double* %l2
  store { i8**, i64 }* %t213, { i8**, i64 }** %l0
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
  %t37 = add i8* %t35, %t36
  store i8* %t37, i8** %l1
  %t38 = load i8*, i8** %l6
  %t39 = getelementptr i8, i8* %t38, i64 0
  %t40 = load i8, i8* %t39
  %t41 = icmp eq i8 %t40, 92
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t43 = load i8*, i8** %l1
  %t44 = load double, double* %l2
  %t45 = load double, double* %l3
  %t46 = load i1, i1* %l4
  %t47 = load i8*, i8** %l5
  %t48 = load i8*, i8** %l6
  br i1 %t41, label %then8, label %else9
then8:
  %t49 = load double, double* %l3
  %t50 = sitofp i64 1 to double
  %t51 = fadd double %t49, %t50
  store double %t51, double* %l3
  %t52 = load double, double* %l3
  %t53 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t54 = sitofp i64 %t53 to double
  %t55 = fcmp olt double %t52, %t54
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t57 = load i8*, i8** %l1
  %t58 = load double, double* %l2
  %t59 = load double, double* %l3
  %t60 = load i1, i1* %l4
  %t61 = load i8*, i8** %l5
  %t62 = load i8*, i8** %l6
  br i1 %t55, label %then11, label %merge12
then11:
  %t63 = load i8*, i8** %l1
  %t64 = load double, double* %l3
  %t65 = call i8* @char_at(i8* %text, double %t64)
  %t66 = add i8* %t63, %t65
  store i8* %t66, i8** %l1
  br label %merge12
merge12:
  %t67 = phi i8* [ %t66, %then11 ], [ %t57, %then8 ]
  store i8* %t67, i8** %l1
  br label %merge10
else9:
  %t68 = load i8*, i8** %l6
  %t69 = load i8*, i8** %l5
  %t70 = icmp eq i8* %t68, %t69
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t72 = load i8*, i8** %l1
  %t73 = load double, double* %l2
  %t74 = load double, double* %l3
  %t75 = load i1, i1* %l4
  %t76 = load i8*, i8** %l5
  %t77 = load i8*, i8** %l6
  br i1 %t70, label %then13, label %merge14
then13:
  store i1 0, i1* %l4
  br label %merge14
merge14:
  %t78 = phi i1 [ 0, %then13 ], [ %t75, %else9 ]
  store i1 %t78, i1* %l4
  br label %merge10
merge10:
  %t79 = phi double [ %t51, %then8 ], [ %t45, %else9 ]
  %t80 = phi i8* [ %t66, %then8 ], [ %t43, %else9 ]
  %t81 = phi i1 [ %t46, %then8 ], [ 0, %else9 ]
  store double %t79, double* %l3
  store i8* %t80, i8** %l1
  store i1 %t81, i1* %l4
  %t82 = load double, double* %l3
  %t83 = sitofp i64 1 to double
  %t84 = fadd double %t82, %t83
  store double %t84, double* %l3
  br label %loop.latch2
merge7:
  %t86 = load i8*, i8** %l6
  %t87 = getelementptr i8, i8* %t86, i64 0
  %t88 = load i8, i8* %t87
  %t89 = icmp eq i8 %t88, 34
  br label %logical_or_entry_85

logical_or_entry_85:
  br i1 %t89, label %logical_or_merge_85, label %logical_or_right_85

logical_or_right_85:
  %t90 = load i8*, i8** %l6
  %t91 = getelementptr i8, i8* %t90, i64 0
  %t92 = load i8, i8* %t91
  %t93 = icmp eq i8 %t92, 39
  br label %logical_or_right_end_85

logical_or_right_end_85:
  br label %logical_or_merge_85

logical_or_merge_85:
  %t94 = phi i1 [ true, %logical_or_entry_85 ], [ %t93, %logical_or_right_end_85 ]
  %t95 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t96 = load i8*, i8** %l1
  %t97 = load double, double* %l2
  %t98 = load double, double* %l3
  %t99 = load i1, i1* %l4
  %t100 = load i8*, i8** %l5
  %t101 = load i8*, i8** %l6
  br i1 %t94, label %then15, label %merge16
then15:
  store i1 1, i1* %l4
  %t102 = load i8*, i8** %l6
  store i8* %t102, i8** %l5
  %t103 = load i8*, i8** %l1
  %t104 = load i8*, i8** %l6
  %t105 = add i8* %t103, %t104
  store i8* %t105, i8** %l1
  %t106 = load double, double* %l3
  %t107 = sitofp i64 1 to double
  %t108 = fadd double %t106, %t107
  store double %t108, double* %l3
  br label %loop.latch2
merge16:
  %t110 = load i8*, i8** %l6
  %t111 = getelementptr i8, i8* %t110, i64 0
  %t112 = load i8, i8* %t111
  %t113 = icmp eq i8 %t112, 123
  br label %logical_or_entry_109

logical_or_entry_109:
  br i1 %t113, label %logical_or_merge_109, label %logical_or_right_109

logical_or_right_109:
  %t115 = load i8*, i8** %l6
  %t116 = getelementptr i8, i8* %t115, i64 0
  %t117 = load i8, i8* %t116
  %t118 = icmp eq i8 %t117, 91
  br label %logical_or_entry_114

logical_or_entry_114:
  br i1 %t118, label %logical_or_merge_114, label %logical_or_right_114

logical_or_right_114:
  %t119 = load i8*, i8** %l6
  %t120 = getelementptr i8, i8* %t119, i64 0
  %t121 = load i8, i8* %t120
  %t122 = icmp eq i8 %t121, 40
  br label %logical_or_right_end_114

logical_or_right_end_114:
  br label %logical_or_merge_114

logical_or_merge_114:
  %t123 = phi i1 [ true, %logical_or_entry_114 ], [ %t122, %logical_or_right_end_114 ]
  br label %logical_or_right_end_109

logical_or_right_end_109:
  br label %logical_or_merge_109

logical_or_merge_109:
  %t124 = phi i1 [ true, %logical_or_entry_109 ], [ %t123, %logical_or_right_end_109 ]
  %t125 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t126 = load i8*, i8** %l1
  %t127 = load double, double* %l2
  %t128 = load double, double* %l3
  %t129 = load i1, i1* %l4
  %t130 = load i8*, i8** %l5
  %t131 = load i8*, i8** %l6
  br i1 %t124, label %then17, label %else18
then17:
  %t132 = load double, double* %l2
  %t133 = sitofp i64 1 to double
  %t134 = fadd double %t132, %t133
  store double %t134, double* %l2
  br label %merge19
else18:
  %t136 = load i8*, i8** %l6
  %t137 = getelementptr i8, i8* %t136, i64 0
  %t138 = load i8, i8* %t137
  %t139 = icmp eq i8 %t138, 125
  br label %logical_or_entry_135

logical_or_entry_135:
  br i1 %t139, label %logical_or_merge_135, label %logical_or_right_135

logical_or_right_135:
  %t141 = load i8*, i8** %l6
  %t142 = getelementptr i8, i8* %t141, i64 0
  %t143 = load i8, i8* %t142
  %t144 = icmp eq i8 %t143, 93
  br label %logical_or_entry_140

logical_or_entry_140:
  br i1 %t144, label %logical_or_merge_140, label %logical_or_right_140

logical_or_right_140:
  %t145 = load i8*, i8** %l6
  %t146 = getelementptr i8, i8* %t145, i64 0
  %t147 = load i8, i8* %t146
  %t148 = icmp eq i8 %t147, 41
  br label %logical_or_right_end_140

logical_or_right_end_140:
  br label %logical_or_merge_140

logical_or_merge_140:
  %t149 = phi i1 [ true, %logical_or_entry_140 ], [ %t148, %logical_or_right_end_140 ]
  br label %logical_or_right_end_135

logical_or_right_end_135:
  br label %logical_or_merge_135

logical_or_merge_135:
  %t150 = phi i1 [ true, %logical_or_entry_135 ], [ %t149, %logical_or_right_end_135 ]
  %t151 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t152 = load i8*, i8** %l1
  %t153 = load double, double* %l2
  %t154 = load double, double* %l3
  %t155 = load i1, i1* %l4
  %t156 = load i8*, i8** %l5
  %t157 = load i8*, i8** %l6
  br i1 %t150, label %then20, label %merge21
then20:
  %t158 = load double, double* %l2
  %t159 = sitofp i64 0 to double
  %t160 = fcmp ogt double %t158, %t159
  %t161 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t162 = load i8*, i8** %l1
  %t163 = load double, double* %l2
  %t164 = load double, double* %l3
  %t165 = load i1, i1* %l4
  %t166 = load i8*, i8** %l5
  %t167 = load i8*, i8** %l6
  br i1 %t160, label %then22, label %merge23
then22:
  %t168 = load double, double* %l2
  %t169 = sitofp i64 1 to double
  %t170 = fsub double %t168, %t169
  store double %t170, double* %l2
  br label %merge23
merge23:
  %t171 = phi double [ %t170, %then22 ], [ %t163, %then20 ]
  store double %t171, double* %l2
  br label %merge21
merge21:
  %t172 = phi double [ %t170, %then20 ], [ %t153, %else18 ]
  store double %t172, double* %l2
  br label %merge19
merge19:
  %t173 = phi double [ %t134, %then17 ], [ %t170, %else18 ]
  store double %t173, double* %l2
  %t175 = load i8*, i8** %l6
  %t176 = getelementptr i8, i8* %t175, i64 0
  %t177 = load i8, i8* %t176
  %t178 = icmp eq i8 %t177, 44
  br label %logical_and_entry_174

logical_and_entry_174:
  br i1 %t178, label %logical_and_right_174, label %logical_and_merge_174

logical_and_right_174:
  %t179 = load double, double* %l2
  %t180 = sitofp i64 0 to double
  %t181 = fcmp oeq double %t179, %t180
  br label %logical_and_right_end_174

logical_and_right_end_174:
  br label %logical_and_merge_174

logical_and_merge_174:
  %t182 = phi i1 [ false, %logical_and_entry_174 ], [ %t181, %logical_and_right_end_174 ]
  %t183 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t184 = load i8*, i8** %l1
  %t185 = load double, double* %l2
  %t186 = load double, double* %l3
  %t187 = load i1, i1* %l4
  %t188 = load i8*, i8** %l5
  %t189 = load i8*, i8** %l6
  br i1 %t182, label %then24, label %else25
then24:
  %t190 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t191 = load i8*, i8** %l1
  %t192 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t190, i8* %t191)
  store { i8**, i64 }* %t192, { i8**, i64 }** %l0
  %s193 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.193, i32 0, i32 0
  store i8* %s193, i8** %l1
  br label %merge26
else25:
  %t194 = load i8*, i8** %l1
  %t195 = load i8*, i8** %l6
  %t196 = add i8* %t194, %t195
  store i8* %t196, i8** %l1
  br label %merge26
merge26:
  %t197 = phi { i8**, i64 }* [ %t192, %then24 ], [ %t183, %else25 ]
  %t198 = phi i8* [ %s193, %then24 ], [ %t196, %else25 ]
  store { i8**, i64 }* %t197, { i8**, i64 }** %l0
  store i8* %t198, i8** %l1
  %t199 = load double, double* %l3
  %t200 = sitofp i64 1 to double
  %t201 = fadd double %t199, %t200
  store double %t201, double* %l3
  br label %loop.latch2
loop.latch2:
  %t202 = load i8*, i8** %l1
  %t203 = load double, double* %l3
  %t204 = load i1, i1* %l4
  %t205 = load i8*, i8** %l5
  %t206 = load double, double* %l2
  %t207 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t214 = load i8*, i8** %l1
  %t215 = call i64 @sailfin_runtime_string_length(i8* %t214)
  %t216 = icmp sgt i64 %t215, 0
  %t217 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t218 = load i8*, i8** %l1
  %t219 = load double, double* %l2
  %t220 = load double, double* %l3
  %t221 = load i1, i1* %l4
  %t222 = load i8*, i8** %l5
  br i1 %t216, label %then27, label %merge28
then27:
  %t223 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t224 = load i8*, i8** %l1
  %t225 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t223, i8* %t224)
  store { i8**, i64 }* %t225, { i8**, i64 }** %l0
  br label %merge28
merge28:
  %t226 = phi { i8**, i64 }* [ %t225, %then27 ], [ %t217, %entry ]
  store { i8**, i64 }* %t226, { i8**, i64 }** %l0
  %t227 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t227
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
  %s5 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.5, i32 0, i32 0
  store i8* %s5, i8** %l1
  %t6 = sitofp i64 0 to double
  store double %t6, double* %l2
  %t7 = sitofp i64 0 to double
  store double %t7, double* %l3
  store i1 0, i1* %l4
  %s8 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.8, i32 0, i32 0
  store i8* %s8, i8** %l5
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t10 = load i8*, i8** %l1
  %t11 = load double, double* %l2
  %t12 = load double, double* %l3
  %t13 = load i1, i1* %l4
  %t14 = load i8*, i8** %l5
  br label %loop.header0
loop.header0:
  %t208 = phi i8* [ %t10, %entry ], [ %t202, %loop.latch2 ]
  %t209 = phi double [ %t12, %entry ], [ %t203, %loop.latch2 ]
  %t210 = phi i1 [ %t13, %entry ], [ %t204, %loop.latch2 ]
  %t211 = phi i8* [ %t14, %entry ], [ %t205, %loop.latch2 ]
  %t212 = phi double [ %t11, %entry ], [ %t206, %loop.latch2 ]
  %t213 = phi { i8**, i64 }* [ %t9, %entry ], [ %t207, %loop.latch2 ]
  store i8* %t208, i8** %l1
  store double %t209, double* %l3
  store i1 %t210, i1* %l4
  store i8* %t211, i8** %l5
  store double %t212, double* %l2
  store { i8**, i64 }* %t213, { i8**, i64 }** %l0
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
  %t37 = add i8* %t35, %t36
  store i8* %t37, i8** %l1
  %t38 = load i8*, i8** %l6
  %t39 = getelementptr i8, i8* %t38, i64 0
  %t40 = load i8, i8* %t39
  %t41 = icmp eq i8 %t40, 92
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t43 = load i8*, i8** %l1
  %t44 = load double, double* %l2
  %t45 = load double, double* %l3
  %t46 = load i1, i1* %l4
  %t47 = load i8*, i8** %l5
  %t48 = load i8*, i8** %l6
  br i1 %t41, label %then8, label %else9
then8:
  %t49 = load double, double* %l3
  %t50 = sitofp i64 1 to double
  %t51 = fadd double %t49, %t50
  store double %t51, double* %l3
  %t52 = load double, double* %l3
  %t53 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t54 = sitofp i64 %t53 to double
  %t55 = fcmp olt double %t52, %t54
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t57 = load i8*, i8** %l1
  %t58 = load double, double* %l2
  %t59 = load double, double* %l3
  %t60 = load i1, i1* %l4
  %t61 = load i8*, i8** %l5
  %t62 = load i8*, i8** %l6
  br i1 %t55, label %then11, label %merge12
then11:
  %t63 = load i8*, i8** %l1
  %t64 = load double, double* %l3
  %t65 = call i8* @char_at(i8* %text, double %t64)
  %t66 = add i8* %t63, %t65
  store i8* %t66, i8** %l1
  br label %merge12
merge12:
  %t67 = phi i8* [ %t66, %then11 ], [ %t57, %then8 ]
  store i8* %t67, i8** %l1
  br label %merge10
else9:
  %t68 = load i8*, i8** %l6
  %t69 = load i8*, i8** %l5
  %t70 = icmp eq i8* %t68, %t69
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t72 = load i8*, i8** %l1
  %t73 = load double, double* %l2
  %t74 = load double, double* %l3
  %t75 = load i1, i1* %l4
  %t76 = load i8*, i8** %l5
  %t77 = load i8*, i8** %l6
  br i1 %t70, label %then13, label %merge14
then13:
  store i1 0, i1* %l4
  br label %merge14
merge14:
  %t78 = phi i1 [ 0, %then13 ], [ %t75, %else9 ]
  store i1 %t78, i1* %l4
  br label %merge10
merge10:
  %t79 = phi double [ %t51, %then8 ], [ %t45, %else9 ]
  %t80 = phi i8* [ %t66, %then8 ], [ %t43, %else9 ]
  %t81 = phi i1 [ %t46, %then8 ], [ 0, %else9 ]
  store double %t79, double* %l3
  store i8* %t80, i8** %l1
  store i1 %t81, i1* %l4
  %t82 = load double, double* %l3
  %t83 = sitofp i64 1 to double
  %t84 = fadd double %t82, %t83
  store double %t84, double* %l3
  br label %loop.latch2
merge7:
  %t86 = load i8*, i8** %l6
  %t87 = getelementptr i8, i8* %t86, i64 0
  %t88 = load i8, i8* %t87
  %t89 = icmp eq i8 %t88, 34
  br label %logical_or_entry_85

logical_or_entry_85:
  br i1 %t89, label %logical_or_merge_85, label %logical_or_right_85

logical_or_right_85:
  %t90 = load i8*, i8** %l6
  %t91 = getelementptr i8, i8* %t90, i64 0
  %t92 = load i8, i8* %t91
  %t93 = icmp eq i8 %t92, 39
  br label %logical_or_right_end_85

logical_or_right_end_85:
  br label %logical_or_merge_85

logical_or_merge_85:
  %t94 = phi i1 [ true, %logical_or_entry_85 ], [ %t93, %logical_or_right_end_85 ]
  %t95 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t96 = load i8*, i8** %l1
  %t97 = load double, double* %l2
  %t98 = load double, double* %l3
  %t99 = load i1, i1* %l4
  %t100 = load i8*, i8** %l5
  %t101 = load i8*, i8** %l6
  br i1 %t94, label %then15, label %merge16
then15:
  store i1 1, i1* %l4
  %t102 = load i8*, i8** %l6
  store i8* %t102, i8** %l5
  %t103 = load i8*, i8** %l1
  %t104 = load i8*, i8** %l6
  %t105 = add i8* %t103, %t104
  store i8* %t105, i8** %l1
  %t106 = load double, double* %l3
  %t107 = sitofp i64 1 to double
  %t108 = fadd double %t106, %t107
  store double %t108, double* %l3
  br label %loop.latch2
merge16:
  %t110 = load i8*, i8** %l6
  %t111 = getelementptr i8, i8* %t110, i64 0
  %t112 = load i8, i8* %t111
  %t113 = icmp eq i8 %t112, 123
  br label %logical_or_entry_109

logical_or_entry_109:
  br i1 %t113, label %logical_or_merge_109, label %logical_or_right_109

logical_or_right_109:
  %t115 = load i8*, i8** %l6
  %t116 = getelementptr i8, i8* %t115, i64 0
  %t117 = load i8, i8* %t116
  %t118 = icmp eq i8 %t117, 91
  br label %logical_or_entry_114

logical_or_entry_114:
  br i1 %t118, label %logical_or_merge_114, label %logical_or_right_114

logical_or_right_114:
  %t119 = load i8*, i8** %l6
  %t120 = getelementptr i8, i8* %t119, i64 0
  %t121 = load i8, i8* %t120
  %t122 = icmp eq i8 %t121, 40
  br label %logical_or_right_end_114

logical_or_right_end_114:
  br label %logical_or_merge_114

logical_or_merge_114:
  %t123 = phi i1 [ true, %logical_or_entry_114 ], [ %t122, %logical_or_right_end_114 ]
  br label %logical_or_right_end_109

logical_or_right_end_109:
  br label %logical_or_merge_109

logical_or_merge_109:
  %t124 = phi i1 [ true, %logical_or_entry_109 ], [ %t123, %logical_or_right_end_109 ]
  %t125 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t126 = load i8*, i8** %l1
  %t127 = load double, double* %l2
  %t128 = load double, double* %l3
  %t129 = load i1, i1* %l4
  %t130 = load i8*, i8** %l5
  %t131 = load i8*, i8** %l6
  br i1 %t124, label %then17, label %else18
then17:
  %t132 = load double, double* %l2
  %t133 = sitofp i64 1 to double
  %t134 = fadd double %t132, %t133
  store double %t134, double* %l2
  br label %merge19
else18:
  %t136 = load i8*, i8** %l6
  %t137 = getelementptr i8, i8* %t136, i64 0
  %t138 = load i8, i8* %t137
  %t139 = icmp eq i8 %t138, 125
  br label %logical_or_entry_135

logical_or_entry_135:
  br i1 %t139, label %logical_or_merge_135, label %logical_or_right_135

logical_or_right_135:
  %t141 = load i8*, i8** %l6
  %t142 = getelementptr i8, i8* %t141, i64 0
  %t143 = load i8, i8* %t142
  %t144 = icmp eq i8 %t143, 93
  br label %logical_or_entry_140

logical_or_entry_140:
  br i1 %t144, label %logical_or_merge_140, label %logical_or_right_140

logical_or_right_140:
  %t145 = load i8*, i8** %l6
  %t146 = getelementptr i8, i8* %t145, i64 0
  %t147 = load i8, i8* %t146
  %t148 = icmp eq i8 %t147, 41
  br label %logical_or_right_end_140

logical_or_right_end_140:
  br label %logical_or_merge_140

logical_or_merge_140:
  %t149 = phi i1 [ true, %logical_or_entry_140 ], [ %t148, %logical_or_right_end_140 ]
  br label %logical_or_right_end_135

logical_or_right_end_135:
  br label %logical_or_merge_135

logical_or_merge_135:
  %t150 = phi i1 [ true, %logical_or_entry_135 ], [ %t149, %logical_or_right_end_135 ]
  %t151 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t152 = load i8*, i8** %l1
  %t153 = load double, double* %l2
  %t154 = load double, double* %l3
  %t155 = load i1, i1* %l4
  %t156 = load i8*, i8** %l5
  %t157 = load i8*, i8** %l6
  br i1 %t150, label %then20, label %merge21
then20:
  %t158 = load double, double* %l2
  %t159 = sitofp i64 0 to double
  %t160 = fcmp ogt double %t158, %t159
  %t161 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t162 = load i8*, i8** %l1
  %t163 = load double, double* %l2
  %t164 = load double, double* %l3
  %t165 = load i1, i1* %l4
  %t166 = load i8*, i8** %l5
  %t167 = load i8*, i8** %l6
  br i1 %t160, label %then22, label %merge23
then22:
  %t168 = load double, double* %l2
  %t169 = sitofp i64 1 to double
  %t170 = fsub double %t168, %t169
  store double %t170, double* %l2
  br label %merge23
merge23:
  %t171 = phi double [ %t170, %then22 ], [ %t163, %then20 ]
  store double %t171, double* %l2
  br label %merge21
merge21:
  %t172 = phi double [ %t170, %then20 ], [ %t153, %else18 ]
  store double %t172, double* %l2
  br label %merge19
merge19:
  %t173 = phi double [ %t134, %then17 ], [ %t170, %else18 ]
  store double %t173, double* %l2
  %t175 = load i8*, i8** %l6
  %t176 = getelementptr i8, i8* %t175, i64 0
  %t177 = load i8, i8* %t176
  %t178 = icmp eq i8 %t177, 44
  br label %logical_and_entry_174

logical_and_entry_174:
  br i1 %t178, label %logical_and_right_174, label %logical_and_merge_174

logical_and_right_174:
  %t179 = load double, double* %l2
  %t180 = sitofp i64 0 to double
  %t181 = fcmp oeq double %t179, %t180
  br label %logical_and_right_end_174

logical_and_right_end_174:
  br label %logical_and_merge_174

logical_and_merge_174:
  %t182 = phi i1 [ false, %logical_and_entry_174 ], [ %t181, %logical_and_right_end_174 ]
  %t183 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t184 = load i8*, i8** %l1
  %t185 = load double, double* %l2
  %t186 = load double, double* %l3
  %t187 = load i1, i1* %l4
  %t188 = load i8*, i8** %l5
  %t189 = load i8*, i8** %l6
  br i1 %t182, label %then24, label %else25
then24:
  %t190 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t191 = load i8*, i8** %l1
  %t192 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t190, i8* %t191)
  store { i8**, i64 }* %t192, { i8**, i64 }** %l0
  %s193 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.193, i32 0, i32 0
  store i8* %s193, i8** %l1
  br label %merge26
else25:
  %t194 = load i8*, i8** %l1
  %t195 = load i8*, i8** %l6
  %t196 = add i8* %t194, %t195
  store i8* %t196, i8** %l1
  br label %merge26
merge26:
  %t197 = phi { i8**, i64 }* [ %t192, %then24 ], [ %t183, %else25 ]
  %t198 = phi i8* [ %s193, %then24 ], [ %t196, %else25 ]
  store { i8**, i64 }* %t197, { i8**, i64 }** %l0
  store i8* %t198, i8** %l1
  %t199 = load double, double* %l3
  %t200 = sitofp i64 1 to double
  %t201 = fadd double %t199, %t200
  store double %t201, double* %l3
  br label %loop.latch2
loop.latch2:
  %t202 = load i8*, i8** %l1
  %t203 = load double, double* %l3
  %t204 = load i1, i1* %l4
  %t205 = load i8*, i8** %l5
  %t206 = load double, double* %l2
  %t207 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t214 = load i8*, i8** %l1
  %t215 = call i64 @sailfin_runtime_string_length(i8* %t214)
  %t216 = icmp sgt i64 %t215, 0
  %t217 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t218 = load i8*, i8** %l1
  %t219 = load double, double* %l2
  %t220 = load double, double* %l3
  %t221 = load i1, i1* %l4
  %t222 = load i8*, i8** %l5
  br i1 %t216, label %then27, label %merge28
then27:
  %t223 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t224 = load i8*, i8** %l1
  %t225 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t223, i8* %t224)
  store { i8**, i64 }* %t225, { i8**, i64 }** %l0
  br label %merge28
merge28:
  %t226 = phi { i8**, i64 }* [ %t225, %then27 ], [ %t217, %entry ]
  store { i8**, i64 }* %t226, { i8**, i64 }** %l0
  %t227 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t227
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
  %t27 = phi double [ %t2, %entry ], [ %t26, %loop.latch2 ]
  store double %t27, double* %l0
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
  %t13 = getelementptr i8, i8* %t12, i64 0
  %t14 = load i8, i8* %t13
  %t15 = icmp eq i8 %t14, 44
  br label %logical_or_entry_11

logical_or_entry_11:
  br i1 %t15, label %logical_or_merge_11, label %logical_or_right_11

logical_or_right_11:
  %t16 = load i8*, i8** %l1
  %t17 = getelementptr i8, i8* %t16, i64 0
  %t18 = load i8, i8* %t17
  %t19 = icmp eq i8 %t18, 59
  br label %logical_or_right_end_11

logical_or_right_end_11:
  br label %logical_or_merge_11

logical_or_merge_11:
  %t20 = phi i1 [ true, %logical_or_entry_11 ], [ %t19, %logical_or_right_end_11 ]
  %t21 = load double, double* %l0
  %t22 = load i8*, i8** %l1
  br i1 %t20, label %then6, label %merge7
then6:
  %t23 = load double, double* %l0
  %t24 = sitofp i64 1 to double
  %t25 = fsub double %t23, %t24
  store double %t25, double* %l0
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  %t26 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t28 = load double, double* %l0
  %t29 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t30 = sitofp i64 %t29 to double
  %t31 = fcmp oeq double %t28, %t30
  %t32 = load double, double* %l0
  br i1 %t31, label %then8, label %merge9
then8:
  ret i8* %text
merge9:
  %t33 = load double, double* %l0
  %t34 = fptosi double %t33 to i64
  %t35 = call i8* @sailfin_runtime_substring(i8* %text, i64 0, i64 %t34)
  ret i8* %t35
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
  %t52 = phi double [ %t1, %entry ], [ %t50, %loop.latch2 ]
  %t53 = phi double [ %t2, %entry ], [ %t51, %loop.latch2 ]
  store double %t52, double* %l0
  store double %t53, double* %l1
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
  %t12 = getelementptr i8, i8* %t11, i64 0
  %t13 = load i8, i8* %t12
  %t14 = icmp eq i8 %t13, 123
  %t15 = load double, double* %l0
  %t16 = load double, double* %l1
  %t17 = load i8*, i8** %l2
  br i1 %t14, label %then6, label %else7
then6:
  %t18 = load double, double* %l0
  %t19 = sitofp i64 1 to double
  %t20 = fadd double %t18, %t19
  store double %t20, double* %l0
  br label %merge8
else7:
  %t21 = load i8*, i8** %l2
  %t22 = getelementptr i8, i8* %t21, i64 0
  %t23 = load i8, i8* %t22
  %t24 = icmp eq i8 %t23, 125
  %t25 = load double, double* %l0
  %t26 = load double, double* %l1
  %t27 = load i8*, i8** %l2
  br i1 %t24, label %then9, label %merge10
then9:
  %t28 = load double, double* %l0
  %t29 = sitofp i64 0 to double
  %t30 = fcmp ole double %t28, %t29
  %t31 = load double, double* %l0
  %t32 = load double, double* %l1
  %t33 = load i8*, i8** %l2
  br i1 %t30, label %then11, label %merge12
then11:
  %t34 = sitofp i64 -1 to double
  ret double %t34
merge12:
  %t35 = load double, double* %l0
  %t36 = sitofp i64 1 to double
  %t37 = fsub double %t35, %t36
  store double %t37, double* %l0
  %t38 = load double, double* %l0
  %t39 = sitofp i64 0 to double
  %t40 = fcmp oeq double %t38, %t39
  %t41 = load double, double* %l0
  %t42 = load double, double* %l1
  %t43 = load i8*, i8** %l2
  br i1 %t40, label %then13, label %merge14
then13:
  %t44 = load double, double* %l1
  ret double %t44
merge14:
  br label %merge10
merge10:
  %t45 = phi double [ %t37, %then9 ], [ %t25, %else7 ]
  store double %t45, double* %l0
  br label %merge8
merge8:
  %t46 = phi double [ %t20, %then6 ], [ %t37, %else7 ]
  store double %t46, double* %l0
  %t47 = load double, double* %l1
  %t48 = sitofp i64 1 to double
  %t49 = fadd double %t47, %t48
  store double %t49, double* %l1
  br label %loop.latch2
loop.latch2:
  %t50 = load double, double* %l0
  %t51 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t54 = sitofp i64 -1 to double
  ret double %t54
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
  %t27 = phi double [ %t5, %entry ], [ %t25, %loop.latch4 ]
  %t28 = phi double [ %t6, %entry ], [ %t26, %loop.latch4 ]
  store double %t27, double* %l0
  store double %t28, double* %l1
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
  %t14 = getelementptr i8, i8* %t13, i64 0
  %t15 = load i8, i8* %t14
  %t16 = icmp ne i8 %t15, 92
  %t17 = load double, double* %l0
  %t18 = load double, double* %l1
  br i1 %t16, label %then8, label %merge9
then8:
  br label %afterloop5
merge9:
  %t19 = load double, double* %l0
  %t20 = sitofp i64 1 to double
  %t21 = fadd double %t19, %t20
  store double %t21, double* %l0
  %t22 = load double, double* %l1
  %t23 = sitofp i64 1 to double
  %t24 = fsub double %t22, %t23
  store double %t24, double* %l1
  br label %loop.latch4
loop.latch4:
  %t25 = load double, double* %l0
  %t26 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t29 = load double, double* %l0
  %t30 = sitofp i64 2 to double
  %t31 = frem double %t29, %t30
  %t32 = sitofp i64 1 to double
  %t33 = fcmp oeq double %t31, %t32
  %t34 = load double, double* %l0
  %t35 = load double, double* %l1
  br i1 %t33, label %then10, label %merge11
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
  %t96 = phi i1 [ %t1, %entry ], [ %t93, %loop.latch2 ]
  %t97 = phi double [ %t0, %entry ], [ %t94, %loop.latch2 ]
  %t98 = phi i1 [ %t2, %entry ], [ %t95, %loop.latch2 ]
  store i1 %t96, i1* %l1
  store double %t97, double* %l0
  store i1 %t98, i1* %l2
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
  %t13 = getelementptr i8, i8* %t12, i64 0
  %t14 = load i8, i8* %t13
  %t15 = icmp eq i8 %t14, 39
  %t16 = load double, double* %l0
  %t17 = load i1, i1* %l1
  %t18 = load i1, i1* %l2
  %t19 = load i8*, i8** %l3
  br i1 %t15, label %then6, label %merge7
then6:
  %t21 = load i1, i1* %l2
  br label %logical_and_entry_20

logical_and_entry_20:
  br i1 %t21, label %logical_and_right_20, label %logical_and_merge_20

logical_and_right_20:
  %t22 = load double, double* %l0
  %t23 = call i1 @is_escaped_quote(i8* %text, double %t22)
  %t24 = xor i1 %t23, 1
  br label %logical_and_right_end_20

logical_and_right_end_20:
  br label %logical_and_merge_20

logical_and_merge_20:
  %t25 = phi i1 [ false, %logical_and_entry_20 ], [ %t24, %logical_and_right_end_20 ]
  %t26 = xor i1 %t25, 1
  %t27 = load double, double* %l0
  %t28 = load i1, i1* %l1
  %t29 = load i1, i1* %l2
  %t30 = load i8*, i8** %l3
  br i1 %t26, label %then8, label %merge9
then8:
  %t31 = load i1, i1* %l1
  %t32 = xor i1 %t31, 1
  store i1 %t32, i1* %l1
  br label %merge9
merge9:
  %t33 = phi i1 [ %t32, %then8 ], [ %t28, %then6 ]
  store i1 %t33, i1* %l1
  %t34 = load double, double* %l0
  %t35 = sitofp i64 1 to double
  %t36 = fadd double %t34, %t35
  store double %t36, double* %l0
  br label %loop.latch2
merge7:
  %t37 = load i8*, i8** %l3
  %t38 = getelementptr i8, i8* %t37, i64 0
  %t39 = load i8, i8* %t38
  %t40 = icmp eq i8 %t39, 34
  %t41 = load double, double* %l0
  %t42 = load i1, i1* %l1
  %t43 = load i1, i1* %l2
  %t44 = load i8*, i8** %l3
  br i1 %t40, label %then10, label %merge11
then10:
  %t46 = load i1, i1* %l1
  br label %logical_and_entry_45

logical_and_entry_45:
  br i1 %t46, label %logical_and_right_45, label %logical_and_merge_45

logical_and_right_45:
  %t47 = load double, double* %l0
  %t48 = call i1 @is_escaped_quote(i8* %text, double %t47)
  %t49 = xor i1 %t48, 1
  br label %logical_and_right_end_45

logical_and_right_end_45:
  br label %logical_and_merge_45

logical_and_merge_45:
  %t50 = phi i1 [ false, %logical_and_entry_45 ], [ %t49, %logical_and_right_end_45 ]
  %t51 = xor i1 %t50, 1
  %t52 = load double, double* %l0
  %t53 = load i1, i1* %l1
  %t54 = load i1, i1* %l2
  %t55 = load i8*, i8** %l3
  br i1 %t51, label %then12, label %merge13
then12:
  %t56 = load i1, i1* %l2
  %t57 = xor i1 %t56, 1
  store i1 %t57, i1* %l2
  br label %merge13
merge13:
  %t58 = phi i1 [ %t57, %then12 ], [ %t54, %then10 ]
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
  %t73 = getelementptr i8, i8* %t72, i64 0
  %t74 = load i8, i8* %t73
  %t75 = icmp eq i8 %t74, 91
  %t76 = load double, double* %l0
  %t77 = load i1, i1* %l1
  %t78 = load i1, i1* %l2
  %t79 = load i8*, i8** %l3
  br i1 %t75, label %then16, label %merge17
then16:
  %t80 = load double, double* %l0
  ret double %t80
merge17:
  %t81 = load i8*, i8** %l3
  %t82 = getelementptr i8, i8* %t81, i64 0
  %t83 = load i8, i8* %t82
  %t84 = icmp eq i8 %t83, 93
  %t85 = load double, double* %l0
  %t86 = load i1, i1* %l1
  %t87 = load i1, i1* %l2
  %t88 = load i8*, i8** %l3
  br i1 %t84, label %then18, label %merge19
then18:
  %t89 = sitofp i64 -1 to double
  ret double %t89
merge19:
  br label %merge15
merge15:
  %t90 = load double, double* %l0
  %t91 = sitofp i64 1 to double
  %t92 = fadd double %t90, %t91
  store double %t92, double* %l0
  br label %loop.latch2
loop.latch2:
  %t93 = load i1, i1* %l1
  %t94 = load double, double* %l0
  %t95 = load i1, i1* %l2
  br label %loop.header0
afterloop3:
  %t99 = sitofp i64 -1 to double
  ret double %t99
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
  %t50 = phi double [ %t16, %entry ], [ %t49, %loop.latch10 ]
  store double %t50, double* %l0
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
  %t40 = phi double [ %t28, %loop.body9 ], [ %t39, %loop.latch16 ]
  store double %t40, double* %l2
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
  %t36 = load double, double* %l2
  %t37 = sitofp i64 1 to double
  %t38 = fadd double %t36, %t37
  store double %t38, double* %l2
  br label %loop.latch16
loop.latch16:
  %t39 = load double, double* %l2
  br label %loop.header14
afterloop17:
  %t41 = load i1, i1* %l1
  %t42 = load double, double* %l0
  %t43 = load i1, i1* %l1
  %t44 = load double, double* %l2
  br i1 %t41, label %then20, label %merge21
then20:
  %t45 = load double, double* %l0
  ret double %t45
merge21:
  %t46 = load double, double* %l0
  %t47 = sitofp i64 1 to double
  %t48 = fadd double %t46, %t47
  store double %t48, double* %l0
  br label %loop.latch10
loop.latch10:
  %t49 = load double, double* %l0
  br label %loop.header8
afterloop11:
  %t51 = sitofp i64 -1 to double
  ret double %t51
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
  %l33 = alloca double
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
  %s8 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.8, i32 0, i32 0
  %t9 = extractvalue %NativeFunction %function, 0
  %t10 = call i8* @sanitize_identifier(i8* %t9)
  %t11 = add i8* %s8, %t10
  %t12 = getelementptr i8, i8* %t11, i64 0
  %t13 = load i8, i8* %t12
  %t14 = add i8 %t13, 40
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %s16 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.16, i32 0, i32 0
  %t17 = call i8* @join_with_separator({ i8**, i64 }* %t15, i8* %s16)
  %t18 = getelementptr i8, i8* %t17, i64 0
  %t19 = load i8, i8* %t18
  %t20 = add i8 %t14, %t19
  %s21 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.21, i32 0, i32 0
  %t22 = getelementptr i8, i8* %s21, i64 0
  %t23 = load i8, i8* %t22
  %t24 = add i8 %t20, %t23
  store i8 %t24, i8* %l3
  %t25 = load %PythonBuilder, %PythonBuilder* %l0
  %t26 = load i8, i8* %l3
  %t27 = alloca [2 x i8], align 1
  %t28 = getelementptr [2 x i8], [2 x i8]* %t27, i32 0, i32 0
  store i8 %t26, i8* %t28
  %t29 = getelementptr [2 x i8], [2 x i8]* %t27, i32 0, i32 1
  store i8 0, i8* %t29
  %t30 = getelementptr [2 x i8], [2 x i8]* %t27, i32 0, i32 0
  %t31 = call %PythonBuilder @builder_emit(%PythonBuilder %t25, i8* %t30)
  store %PythonBuilder %t31, %PythonBuilder* %l0
  %t32 = load %PythonBuilder, %PythonBuilder* %l0
  %t33 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t32)
  store %PythonBuilder %t33, %PythonBuilder* %l0
  %t34 = extractvalue %NativeFunction %function, 3
  %t35 = load { i8**, i64 }, { i8**, i64 }* %t34
  %t36 = extractvalue { i8**, i64 } %t35, 1
  %t37 = icmp sgt i64 %t36, 0
  %t38 = load %PythonBuilder, %PythonBuilder* %l0
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t41 = load i8, i8* %l3
  br i1 %t37, label %then0, label %merge1
then0:
  %t42 = load %PythonBuilder, %PythonBuilder* %l0
  %s43 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.43, i32 0, i32 0
  %t44 = extractvalue %NativeFunction %function, 3
  %s45 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.45, i32 0, i32 0
  %t46 = call i8* @join_with_separator({ i8**, i64 }* %t44, i8* %s45)
  %t47 = add i8* %s43, %t46
  %t48 = call %PythonBuilder @builder_emit(%PythonBuilder %t42, i8* %t47)
  store %PythonBuilder %t48, %PythonBuilder* %l0
  br label %merge1
merge1:
  %t49 = phi %PythonBuilder [ %t48, %then0 ], [ %t38, %entry ]
  store %PythonBuilder %t49, %PythonBuilder* %l0
  %t50 = extractvalue %NativeFunction %function, 4
  %t51 = load { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t50
  %t52 = extractvalue { %NativeInstruction**, i64 } %t51, 1
  %t53 = icmp eq i64 %t52, 0
  %t54 = load %PythonBuilder, %PythonBuilder* %l0
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t57 = load i8, i8* %l3
  br i1 %t53, label %then2, label %merge3
then2:
  %t58 = load %PythonBuilder, %PythonBuilder* %l0
  %s59 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.59, i32 0, i32 0
  %t60 = call %PythonBuilder @builder_emit(%PythonBuilder %t58, i8* %s59)
  store %PythonBuilder %t60, %PythonBuilder* %l0
  %t61 = load %PythonBuilder, %PythonBuilder* %l0
  %t62 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t61)
  store %PythonBuilder %t62, %PythonBuilder* %l0
  %t63 = load %PythonBuilder, %PythonBuilder* %l0
  %t64 = insertvalue %PythonFunctionEmission undef, %PythonBuilder* null, 0
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t66 = insertvalue %PythonFunctionEmission %t64, { i8**, i64 }* %t65, 1
  ret %PythonFunctionEmission %t66
merge3:
  %t67 = sitofp i64 0 to double
  store double %t67, double* %l4
  %t68 = alloca [0 x %MatchContext]
  %t69 = getelementptr [0 x %MatchContext], [0 x %MatchContext]* %t68, i32 0, i32 0
  %t70 = alloca { %MatchContext*, i64 }
  %t71 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t70, i32 0, i32 0
  store %MatchContext* %t69, %MatchContext** %t71
  %t72 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t70, i32 0, i32 1
  store i64 0, i64* %t72
  store { %MatchContext*, i64 }* %t70, { %MatchContext*, i64 }** %l5
  %t73 = sitofp i64 0 to double
  store double %t73, double* %l6
  %t74 = sitofp i64 0 to double
  store double %t74, double* %l7
  %t75 = load %PythonBuilder, %PythonBuilder* %l0
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t77 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t78 = load i8, i8* %l3
  %t79 = load double, double* %l4
  %t80 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t81 = load double, double* %l6
  %t82 = load double, double* %l7
  br label %loop.header4
loop.header4:
  %t2083 = phi %PythonBuilder [ %t75, %entry ], [ %t2077, %loop.latch6 ]
  %t2084 = phi double [ %t82, %entry ], [ %t2078, %loop.latch6 ]
  %t2085 = phi double [ %t79, %entry ], [ %t2079, %loop.latch6 ]
  %t2086 = phi { i8**, i64 }* [ %t76, %entry ], [ %t2080, %loop.latch6 ]
  %t2087 = phi double [ %t81, %entry ], [ %t2081, %loop.latch6 ]
  %t2088 = phi { %MatchContext*, i64 }* [ %t80, %entry ], [ %t2082, %loop.latch6 ]
  store %PythonBuilder %t2083, %PythonBuilder* %l0
  store double %t2084, double* %l7
  store double %t2085, double* %l4
  store { i8**, i64 }* %t2086, { i8**, i64 }** %l1
  store double %t2087, double* %l6
  store { %MatchContext*, i64 }* %t2088, { %MatchContext*, i64 }** %l5
  br label %loop.body5
loop.body5:
  %t83 = load double, double* %l7
  %t84 = extractvalue %NativeFunction %function, 4
  %t85 = load { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t84
  %t86 = extractvalue { %NativeInstruction**, i64 } %t85, 1
  %t87 = sitofp i64 %t86 to double
  %t88 = fcmp oge double %t83, %t87
  %t89 = load %PythonBuilder, %PythonBuilder* %l0
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t91 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t92 = load i8, i8* %l3
  %t93 = load double, double* %l4
  %t94 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t95 = load double, double* %l6
  %t96 = load double, double* %l7
  br i1 %t88, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t97 = extractvalue %NativeFunction %function, 4
  %t98 = load double, double* %l7
  %t99 = fptosi double %t98 to i64
  %t100 = load { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t97
  %t101 = extractvalue { %NativeInstruction**, i64 } %t100, 0
  %t102 = extractvalue { %NativeInstruction**, i64 } %t100, 1
  %t103 = icmp uge i64 %t99, %t102
  ; bounds check: %t103 (if true, out of bounds)
  %t104 = getelementptr %NativeInstruction*, %NativeInstruction** %t101, i64 %t99
  %t105 = load %NativeInstruction*, %NativeInstruction** %t104
  store %NativeInstruction* %t105, %NativeInstruction** %l8
  %t106 = load %NativeInstruction*, %NativeInstruction** %l8
  %t107 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t106, i32 0, i32 0
  %t108 = load i32, i32* %t107
  %t109 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t110 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t111 = icmp eq i32 %t108, 0
  %t112 = select i1 %t111, i8* %t110, i8* %t109
  %t113 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t114 = icmp eq i32 %t108, 1
  %t115 = select i1 %t114, i8* %t113, i8* %t112
  %t116 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t117 = icmp eq i32 %t108, 2
  %t118 = select i1 %t117, i8* %t116, i8* %t115
  %t119 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t120 = icmp eq i32 %t108, 3
  %t121 = select i1 %t120, i8* %t119, i8* %t118
  %t122 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t123 = icmp eq i32 %t108, 4
  %t124 = select i1 %t123, i8* %t122, i8* %t121
  %t125 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t126 = icmp eq i32 %t108, 5
  %t127 = select i1 %t126, i8* %t125, i8* %t124
  %t128 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t129 = icmp eq i32 %t108, 6
  %t130 = select i1 %t129, i8* %t128, i8* %t127
  %t131 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t132 = icmp eq i32 %t108, 7
  %t133 = select i1 %t132, i8* %t131, i8* %t130
  %t134 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t135 = icmp eq i32 %t108, 8
  %t136 = select i1 %t135, i8* %t134, i8* %t133
  %t137 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t138 = icmp eq i32 %t108, 9
  %t139 = select i1 %t138, i8* %t137, i8* %t136
  %t140 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t141 = icmp eq i32 %t108, 10
  %t142 = select i1 %t141, i8* %t140, i8* %t139
  %t143 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t144 = icmp eq i32 %t108, 11
  %t145 = select i1 %t144, i8* %t143, i8* %t142
  %t146 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t147 = icmp eq i32 %t108, 12
  %t148 = select i1 %t147, i8* %t146, i8* %t145
  %t149 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t150 = icmp eq i32 %t108, 13
  %t151 = select i1 %t150, i8* %t149, i8* %t148
  %t152 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t153 = icmp eq i32 %t108, 14
  %t154 = select i1 %t153, i8* %t152, i8* %t151
  %t155 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t156 = icmp eq i32 %t108, 15
  %t157 = select i1 %t156, i8* %t155, i8* %t154
  %t158 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t159 = icmp eq i32 %t108, 16
  %t160 = select i1 %t159, i8* %t158, i8* %t157
  %s161 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.161, i32 0, i32 0
  %t162 = icmp eq i8* %t160, %s161
  %t163 = load %PythonBuilder, %PythonBuilder* %l0
  %t164 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t165 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t166 = load i8, i8* %l3
  %t167 = load double, double* %l4
  %t168 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t169 = load double, double* %l6
  %t170 = load double, double* %l7
  %t171 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t162, label %then10, label %else11
then10:
  %t172 = load %NativeInstruction*, %NativeInstruction** %l8
  %t173 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t172, i32 0, i32 0
  %t174 = load i32, i32* %t173
  %t175 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t172, i32 0, i32 1
  %t176 = bitcast [16 x i8]* %t175 to i8*
  %t177 = bitcast i8* %t176 to i8**
  %t178 = load i8*, i8** %t177
  %t179 = icmp eq i32 %t174, 0
  %t180 = select i1 %t179, i8* %t178, i8* null
  %t181 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t172, i32 0, i32 1
  %t182 = bitcast [16 x i8]* %t181 to i8*
  %t183 = bitcast i8* %t182 to i8**
  %t184 = load i8*, i8** %t183
  %t185 = icmp eq i32 %t174, 1
  %t186 = select i1 %t185, i8* %t184, i8* %t180
  %t187 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t172, i32 0, i32 1
  %t188 = bitcast [8 x i8]* %t187 to i8*
  %t189 = bitcast i8* %t188 to i8**
  %t190 = load i8*, i8** %t189
  %t191 = icmp eq i32 %t174, 12
  %t192 = select i1 %t191, i8* %t190, i8* %t186
  %t193 = call i64 @sailfin_runtime_string_length(i8* %t192)
  %t194 = icmp eq i64 %t193, 0
  %t195 = load %PythonBuilder, %PythonBuilder* %l0
  %t196 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t197 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t198 = load i8, i8* %l3
  %t199 = load double, double* %l4
  %t200 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t201 = load double, double* %l6
  %t202 = load double, double* %l7
  %t203 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t194, label %then13, label %else14
then13:
  %t204 = load %PythonBuilder, %PythonBuilder* %l0
  %s205 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.205, i32 0, i32 0
  %t206 = call %PythonBuilder @builder_emit(%PythonBuilder %t204, i8* %s205)
  store %PythonBuilder %t206, %PythonBuilder* %l0
  br label %merge15
else14:
  %t207 = load %NativeInstruction*, %NativeInstruction** %l8
  %t208 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t207, i32 0, i32 0
  %t209 = load i32, i32* %t208
  %t210 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t207, i32 0, i32 1
  %t211 = bitcast [16 x i8]* %t210 to i8*
  %t212 = bitcast i8* %t211 to i8**
  %t213 = load i8*, i8** %t212
  %t214 = icmp eq i32 %t209, 0
  %t215 = select i1 %t214, i8* %t213, i8* null
  %t216 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t207, i32 0, i32 1
  %t217 = bitcast [16 x i8]* %t216 to i8*
  %t218 = bitcast i8* %t217 to i8**
  %t219 = load i8*, i8** %t218
  %t220 = icmp eq i32 %t209, 1
  %t221 = select i1 %t220, i8* %t219, i8* %t215
  %t222 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t207, i32 0, i32 1
  %t223 = bitcast [8 x i8]* %t222 to i8*
  %t224 = bitcast i8* %t223 to i8**
  %t225 = load i8*, i8** %t224
  %t226 = icmp eq i32 %t209, 12
  %t227 = select i1 %t226, i8* %t225, i8* %t221
  store i8* %t227, i8** %l9
  %t228 = load i8*, i8** %l9
  %t229 = extractvalue %NativeFunction %function, 4
  %t230 = load double, double* %l7
  %t231 = sitofp i64 1 to double
  %t232 = fadd double %t230, %t231
  %t233 = bitcast { %NativeInstruction**, i64 }* %t229 to { %NativeInstruction*, i64 }*
  %t234 = call %StructLiteralCapture @capture_struct_literal_expression(i8* %t228, { %NativeInstruction*, i64 }* %t233, double %t232)
  store %StructLiteralCapture %t234, %StructLiteralCapture* %l10
  %t235 = sitofp i64 0 to double
  store double %t235, double* %l11
  %t236 = load %StructLiteralCapture, %StructLiteralCapture* %l10
  %t237 = extractvalue %StructLiteralCapture %t236, 2
  %t238 = load %PythonBuilder, %PythonBuilder* %l0
  %t239 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t240 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t241 = load i8, i8* %l3
  %t242 = load double, double* %l4
  %t243 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t244 = load double, double* %l6
  %t245 = load double, double* %l7
  %t246 = load %NativeInstruction*, %NativeInstruction** %l8
  %t247 = load i8*, i8** %l9
  %t248 = load %StructLiteralCapture, %StructLiteralCapture* %l10
  %t249 = load double, double* %l11
  br i1 %t237, label %then16, label %else17
then16:
  %t250 = load %StructLiteralCapture, %StructLiteralCapture* %l10
  %t251 = extractvalue %StructLiteralCapture %t250, 0
  store i8* %t251, i8** %l9
  %t252 = load %StructLiteralCapture, %StructLiteralCapture* %l10
  %t253 = extractvalue %StructLiteralCapture %t252, 1
  store double %t253, double* %l11
  br label %merge18
else17:
  %t254 = load i8*, i8** %l9
  %t255 = extractvalue %NativeFunction %function, 4
  %t256 = load double, double* %l7
  %t257 = sitofp i64 1 to double
  %t258 = fadd double %t256, %t257
  %t259 = bitcast { %NativeInstruction**, i64 }* %t255 to { %NativeInstruction*, i64 }*
  %t260 = call %ExpressionContinuationCapture @capture_expression_continuation(i8* %t254, { %NativeInstruction*, i64 }* %t259, double %t258)
  store %ExpressionContinuationCapture %t260, %ExpressionContinuationCapture* %l12
  %t261 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l12
  %t262 = extractvalue %ExpressionContinuationCapture %t261, 2
  %t263 = load %PythonBuilder, %PythonBuilder* %l0
  %t264 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t265 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t266 = load i8, i8* %l3
  %t267 = load double, double* %l4
  %t268 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t269 = load double, double* %l6
  %t270 = load double, double* %l7
  %t271 = load %NativeInstruction*, %NativeInstruction** %l8
  %t272 = load i8*, i8** %l9
  %t273 = load %StructLiteralCapture, %StructLiteralCapture* %l10
  %t274 = load double, double* %l11
  %t275 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l12
  br i1 %t262, label %then19, label %merge20
then19:
  %t276 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l12
  %t277 = extractvalue %ExpressionContinuationCapture %t276, 0
  store i8* %t277, i8** %l9
  %t278 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l12
  %t279 = extractvalue %ExpressionContinuationCapture %t278, 1
  store double %t279, double* %l11
  br label %merge20
merge20:
  %t280 = phi i8* [ %t277, %then19 ], [ %t272, %else17 ]
  %t281 = phi double [ %t279, %then19 ], [ %t274, %else17 ]
  store i8* %t280, i8** %l9
  store double %t281, double* %l11
  br label %merge18
merge18:
  %t282 = phi i8* [ %t251, %then16 ], [ %t277, %else17 ]
  %t283 = phi double [ %t253, %then16 ], [ %t279, %else17 ]
  store i8* %t282, i8** %l9
  store double %t283, double* %l11
  %t284 = load %PythonBuilder, %PythonBuilder* %l0
  %s285 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.285, i32 0, i32 0
  %t286 = load i8*, i8** %l9
  %t287 = call i8* @lower_expression(i8* %t286)
  %t288 = add i8* %s285, %t287
  %t289 = call %PythonBuilder @builder_emit(%PythonBuilder %t284, i8* %t288)
  store %PythonBuilder %t289, %PythonBuilder* %l0
  %t290 = load double, double* %l7
  %t291 = load double, double* %l11
  %t292 = fadd double %t290, %t291
  store double %t292, double* %l7
  br label %merge15
merge15:
  %t293 = phi %PythonBuilder [ %t206, %then13 ], [ %t289, %else14 ]
  %t294 = phi double [ %t202, %then13 ], [ %t292, %else14 ]
  store %PythonBuilder %t293, %PythonBuilder* %l0
  store double %t294, double* %l7
  br label %merge12
else11:
  %t295 = load %NativeInstruction*, %NativeInstruction** %l8
  %t296 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t295, i32 0, i32 0
  %t297 = load i32, i32* %t296
  %t298 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t299 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t300 = icmp eq i32 %t297, 0
  %t301 = select i1 %t300, i8* %t299, i8* %t298
  %t302 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t303 = icmp eq i32 %t297, 1
  %t304 = select i1 %t303, i8* %t302, i8* %t301
  %t305 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t306 = icmp eq i32 %t297, 2
  %t307 = select i1 %t306, i8* %t305, i8* %t304
  %t308 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t309 = icmp eq i32 %t297, 3
  %t310 = select i1 %t309, i8* %t308, i8* %t307
  %t311 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t312 = icmp eq i32 %t297, 4
  %t313 = select i1 %t312, i8* %t311, i8* %t310
  %t314 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t315 = icmp eq i32 %t297, 5
  %t316 = select i1 %t315, i8* %t314, i8* %t313
  %t317 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t318 = icmp eq i32 %t297, 6
  %t319 = select i1 %t318, i8* %t317, i8* %t316
  %t320 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t321 = icmp eq i32 %t297, 7
  %t322 = select i1 %t321, i8* %t320, i8* %t319
  %t323 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t324 = icmp eq i32 %t297, 8
  %t325 = select i1 %t324, i8* %t323, i8* %t322
  %t326 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t327 = icmp eq i32 %t297, 9
  %t328 = select i1 %t327, i8* %t326, i8* %t325
  %t329 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t330 = icmp eq i32 %t297, 10
  %t331 = select i1 %t330, i8* %t329, i8* %t328
  %t332 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t333 = icmp eq i32 %t297, 11
  %t334 = select i1 %t333, i8* %t332, i8* %t331
  %t335 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t336 = icmp eq i32 %t297, 12
  %t337 = select i1 %t336, i8* %t335, i8* %t334
  %t338 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t339 = icmp eq i32 %t297, 13
  %t340 = select i1 %t339, i8* %t338, i8* %t337
  %t341 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t342 = icmp eq i32 %t297, 14
  %t343 = select i1 %t342, i8* %t341, i8* %t340
  %t344 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t345 = icmp eq i32 %t297, 15
  %t346 = select i1 %t345, i8* %t344, i8* %t343
  %t347 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t348 = icmp eq i32 %t297, 16
  %t349 = select i1 %t348, i8* %t347, i8* %t346
  %s350 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.350, i32 0, i32 0
  %t351 = icmp eq i8* %t349, %s350
  %t352 = load %PythonBuilder, %PythonBuilder* %l0
  %t353 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t354 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t355 = load i8, i8* %l3
  %t356 = load double, double* %l4
  %t357 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t358 = load double, double* %l6
  %t359 = load double, double* %l7
  %t360 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t351, label %then21, label %else22
then21:
  %t361 = load %NativeInstruction*, %NativeInstruction** %l8
  %t362 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t361, i32 0, i32 0
  %t363 = load i32, i32* %t362
  %t364 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t361, i32 0, i32 1
  %t365 = bitcast [16 x i8]* %t364 to i8*
  %t366 = bitcast i8* %t365 to i8**
  %t367 = load i8*, i8** %t366
  %t368 = icmp eq i32 %t363, 0
  %t369 = select i1 %t368, i8* %t367, i8* null
  %t370 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t361, i32 0, i32 1
  %t371 = bitcast [16 x i8]* %t370 to i8*
  %t372 = bitcast i8* %t371 to i8**
  %t373 = load i8*, i8** %t372
  %t374 = icmp eq i32 %t363, 1
  %t375 = select i1 %t374, i8* %t373, i8* %t369
  %t376 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t361, i32 0, i32 1
  %t377 = bitcast [8 x i8]* %t376 to i8*
  %t378 = bitcast i8* %t377 to i8**
  %t379 = load i8*, i8** %t378
  %t380 = icmp eq i32 %t363, 12
  %t381 = select i1 %t380, i8* %t379, i8* %t375
  store i8* %t381, i8** %l13
  %t382 = load i8*, i8** %l13
  %t383 = extractvalue %NativeFunction %function, 4
  %t384 = load double, double* %l7
  %t385 = sitofp i64 1 to double
  %t386 = fadd double %t384, %t385
  %t387 = bitcast { %NativeInstruction**, i64 }* %t383 to { %NativeInstruction*, i64 }*
  %t388 = call %StructLiteralCapture @capture_struct_literal_expression(i8* %t382, { %NativeInstruction*, i64 }* %t387, double %t386)
  store %StructLiteralCapture %t388, %StructLiteralCapture* %l14
  %t389 = sitofp i64 0 to double
  store double %t389, double* %l15
  %t390 = load %StructLiteralCapture, %StructLiteralCapture* %l14
  %t391 = extractvalue %StructLiteralCapture %t390, 2
  %t392 = load %PythonBuilder, %PythonBuilder* %l0
  %t393 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t394 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t395 = load i8, i8* %l3
  %t396 = load double, double* %l4
  %t397 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t398 = load double, double* %l6
  %t399 = load double, double* %l7
  %t400 = load %NativeInstruction*, %NativeInstruction** %l8
  %t401 = load i8*, i8** %l13
  %t402 = load %StructLiteralCapture, %StructLiteralCapture* %l14
  %t403 = load double, double* %l15
  br i1 %t391, label %then24, label %else25
then24:
  %t404 = load %StructLiteralCapture, %StructLiteralCapture* %l14
  %t405 = extractvalue %StructLiteralCapture %t404, 0
  store i8* %t405, i8** %l13
  %t406 = load %StructLiteralCapture, %StructLiteralCapture* %l14
  %t407 = extractvalue %StructLiteralCapture %t406, 1
  store double %t407, double* %l15
  br label %merge26
else25:
  %t408 = load i8*, i8** %l13
  %t409 = extractvalue %NativeFunction %function, 4
  %t410 = load double, double* %l7
  %t411 = sitofp i64 1 to double
  %t412 = fadd double %t410, %t411
  %t413 = bitcast { %NativeInstruction**, i64 }* %t409 to { %NativeInstruction*, i64 }*
  %t414 = call %ExpressionContinuationCapture @capture_expression_continuation(i8* %t408, { %NativeInstruction*, i64 }* %t413, double %t412)
  store %ExpressionContinuationCapture %t414, %ExpressionContinuationCapture* %l16
  %t415 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l16
  %t416 = extractvalue %ExpressionContinuationCapture %t415, 2
  %t417 = load %PythonBuilder, %PythonBuilder* %l0
  %t418 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t419 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t420 = load i8, i8* %l3
  %t421 = load double, double* %l4
  %t422 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t423 = load double, double* %l6
  %t424 = load double, double* %l7
  %t425 = load %NativeInstruction*, %NativeInstruction** %l8
  %t426 = load i8*, i8** %l13
  %t427 = load %StructLiteralCapture, %StructLiteralCapture* %l14
  %t428 = load double, double* %l15
  %t429 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l16
  br i1 %t416, label %then27, label %merge28
then27:
  %t430 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l16
  %t431 = extractvalue %ExpressionContinuationCapture %t430, 0
  store i8* %t431, i8** %l13
  %t432 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l16
  %t433 = extractvalue %ExpressionContinuationCapture %t432, 1
  store double %t433, double* %l15
  br label %merge28
merge28:
  %t434 = phi i8* [ %t431, %then27 ], [ %t426, %else25 ]
  %t435 = phi double [ %t433, %then27 ], [ %t428, %else25 ]
  store i8* %t434, i8** %l13
  store double %t435, double* %l15
  br label %merge26
merge26:
  %t436 = phi i8* [ %t405, %then24 ], [ %t431, %else25 ]
  %t437 = phi double [ %t407, %then24 ], [ %t433, %else25 ]
  store i8* %t436, i8** %l13
  store double %t437, double* %l15
  %t438 = load %PythonBuilder, %PythonBuilder* %l0
  %t439 = load i8*, i8** %l13
  %t440 = call i8* @lower_expression(i8* %t439)
  %t441 = call %PythonBuilder @builder_emit(%PythonBuilder %t438, i8* %t440)
  store %PythonBuilder %t441, %PythonBuilder* %l0
  %t442 = load double, double* %l7
  %t443 = load double, double* %l15
  %t444 = fadd double %t442, %t443
  store double %t444, double* %l7
  br label %merge23
else22:
  %t445 = load %NativeInstruction*, %NativeInstruction** %l8
  %t446 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t445, i32 0, i32 0
  %t447 = load i32, i32* %t446
  %t448 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t449 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t450 = icmp eq i32 %t447, 0
  %t451 = select i1 %t450, i8* %t449, i8* %t448
  %t452 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t453 = icmp eq i32 %t447, 1
  %t454 = select i1 %t453, i8* %t452, i8* %t451
  %t455 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t456 = icmp eq i32 %t447, 2
  %t457 = select i1 %t456, i8* %t455, i8* %t454
  %t458 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t459 = icmp eq i32 %t447, 3
  %t460 = select i1 %t459, i8* %t458, i8* %t457
  %t461 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t462 = icmp eq i32 %t447, 4
  %t463 = select i1 %t462, i8* %t461, i8* %t460
  %t464 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t465 = icmp eq i32 %t447, 5
  %t466 = select i1 %t465, i8* %t464, i8* %t463
  %t467 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t468 = icmp eq i32 %t447, 6
  %t469 = select i1 %t468, i8* %t467, i8* %t466
  %t470 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t471 = icmp eq i32 %t447, 7
  %t472 = select i1 %t471, i8* %t470, i8* %t469
  %t473 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t474 = icmp eq i32 %t447, 8
  %t475 = select i1 %t474, i8* %t473, i8* %t472
  %t476 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t477 = icmp eq i32 %t447, 9
  %t478 = select i1 %t477, i8* %t476, i8* %t475
  %t479 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t480 = icmp eq i32 %t447, 10
  %t481 = select i1 %t480, i8* %t479, i8* %t478
  %t482 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t483 = icmp eq i32 %t447, 11
  %t484 = select i1 %t483, i8* %t482, i8* %t481
  %t485 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t486 = icmp eq i32 %t447, 12
  %t487 = select i1 %t486, i8* %t485, i8* %t484
  %t488 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t489 = icmp eq i32 %t447, 13
  %t490 = select i1 %t489, i8* %t488, i8* %t487
  %t491 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t492 = icmp eq i32 %t447, 14
  %t493 = select i1 %t492, i8* %t491, i8* %t490
  %t494 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t495 = icmp eq i32 %t447, 15
  %t496 = select i1 %t495, i8* %t494, i8* %t493
  %t497 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t498 = icmp eq i32 %t447, 16
  %t499 = select i1 %t498, i8* %t497, i8* %t496
  %s500 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.500, i32 0, i32 0
  %t501 = icmp eq i8* %t499, %s500
  %t502 = load %PythonBuilder, %PythonBuilder* %l0
  %t503 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t504 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t505 = load i8, i8* %l3
  %t506 = load double, double* %l4
  %t507 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t508 = load double, double* %l6
  %t509 = load double, double* %l7
  %t510 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t501, label %then29, label %else30
then29:
  %t511 = load %NativeInstruction*, %NativeInstruction** %l8
  %t512 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t511, i32 0, i32 0
  %t513 = load i32, i32* %t512
  %t514 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t511, i32 0, i32 1
  %t515 = bitcast [48 x i8]* %t514 to i8*
  %t516 = bitcast i8* %t515 to i8**
  %t517 = load i8*, i8** %t516
  %t518 = icmp eq i32 %t513, 2
  %t519 = select i1 %t518, i8* %t517, i8* null
  %t520 = call i8* @sanitize_identifier(i8* %t519)
  store i8* %t520, i8** %l17
  %t521 = load i8*, i8** %l17
  %s522 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.522, i32 0, i32 0
  %t523 = add i8* %t521, %s522
  store i8* %t523, i8** %l18
  %t524 = load %NativeInstruction*, %NativeInstruction** %l8
  %t525 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t524, i32 0, i32 0
  %t526 = load i32, i32* %t525
  %t527 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t524, i32 0, i32 1
  %t528 = bitcast [48 x i8]* %t527 to i8*
  %t529 = getelementptr inbounds i8, i8* %t528, i64 24
  %t530 = bitcast i8* %t529 to i8**
  %t531 = load i8*, i8** %t530
  %t532 = icmp eq i32 %t526, 2
  %t533 = select i1 %t532, i8* %t531, i8* null
  %t534 = icmp ne i8* %t533, null
  %t535 = load %PythonBuilder, %PythonBuilder* %l0
  %t536 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t537 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t538 = load i8, i8* %l3
  %t539 = load double, double* %l4
  %t540 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t541 = load double, double* %l6
  %t542 = load double, double* %l7
  %t543 = load %NativeInstruction*, %NativeInstruction** %l8
  %t544 = load i8*, i8** %l17
  %t545 = load i8*, i8** %l18
  br i1 %t534, label %then32, label %else33
then32:
  %t546 = load %NativeInstruction*, %NativeInstruction** %l8
  %t547 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t546, i32 0, i32 0
  %t548 = load i32, i32* %t547
  %t549 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t546, i32 0, i32 1
  %t550 = bitcast [48 x i8]* %t549 to i8*
  %t551 = getelementptr inbounds i8, i8* %t550, i64 24
  %t552 = bitcast i8* %t551 to i8**
  %t553 = load i8*, i8** %t552
  %t554 = icmp eq i32 %t548, 2
  %t555 = select i1 %t554, i8* %t553, i8* null
  store i8* %t555, i8** %l19
  %t556 = load i8*, i8** %l19
  %t557 = extractvalue %NativeFunction %function, 4
  %t558 = load double, double* %l7
  %t559 = sitofp i64 1 to double
  %t560 = fadd double %t558, %t559
  %t561 = bitcast { %NativeInstruction**, i64 }* %t557 to { %NativeInstruction*, i64 }*
  %t562 = call %StructLiteralCapture @capture_struct_literal_expression(i8* %t556, { %NativeInstruction*, i64 }* %t561, double %t560)
  store %StructLiteralCapture %t562, %StructLiteralCapture* %l20
  %t563 = sitofp i64 0 to double
  store double %t563, double* %l21
  %t564 = load %StructLiteralCapture, %StructLiteralCapture* %l20
  %t565 = extractvalue %StructLiteralCapture %t564, 2
  %t566 = load %PythonBuilder, %PythonBuilder* %l0
  %t567 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t568 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t569 = load i8, i8* %l3
  %t570 = load double, double* %l4
  %t571 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t572 = load double, double* %l6
  %t573 = load double, double* %l7
  %t574 = load %NativeInstruction*, %NativeInstruction** %l8
  %t575 = load i8*, i8** %l17
  %t576 = load i8*, i8** %l18
  %t577 = load i8*, i8** %l19
  %t578 = load %StructLiteralCapture, %StructLiteralCapture* %l20
  %t579 = load double, double* %l21
  br i1 %t565, label %then35, label %else36
then35:
  %t580 = load %StructLiteralCapture, %StructLiteralCapture* %l20
  %t581 = extractvalue %StructLiteralCapture %t580, 0
  store i8* %t581, i8** %l19
  %t582 = load %StructLiteralCapture, %StructLiteralCapture* %l20
  %t583 = extractvalue %StructLiteralCapture %t582, 1
  store double %t583, double* %l21
  br label %merge37
else36:
  %t584 = load i8*, i8** %l19
  %t585 = extractvalue %NativeFunction %function, 4
  %t586 = load double, double* %l7
  %t587 = sitofp i64 1 to double
  %t588 = fadd double %t586, %t587
  %t589 = bitcast { %NativeInstruction**, i64 }* %t585 to { %NativeInstruction*, i64 }*
  %t590 = call %ExpressionContinuationCapture @capture_expression_continuation(i8* %t584, { %NativeInstruction*, i64 }* %t589, double %t588)
  store %ExpressionContinuationCapture %t590, %ExpressionContinuationCapture* %l22
  %t591 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l22
  %t592 = extractvalue %ExpressionContinuationCapture %t591, 2
  %t593 = load %PythonBuilder, %PythonBuilder* %l0
  %t594 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t595 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t596 = load i8, i8* %l3
  %t597 = load double, double* %l4
  %t598 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t599 = load double, double* %l6
  %t600 = load double, double* %l7
  %t601 = load %NativeInstruction*, %NativeInstruction** %l8
  %t602 = load i8*, i8** %l17
  %t603 = load i8*, i8** %l18
  %t604 = load i8*, i8** %l19
  %t605 = load %StructLiteralCapture, %StructLiteralCapture* %l20
  %t606 = load double, double* %l21
  %t607 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l22
  br i1 %t592, label %then38, label %merge39
then38:
  %t608 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l22
  %t609 = extractvalue %ExpressionContinuationCapture %t608, 0
  store i8* %t609, i8** %l19
  %t610 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l22
  %t611 = extractvalue %ExpressionContinuationCapture %t610, 1
  store double %t611, double* %l21
  br label %merge39
merge39:
  %t612 = phi i8* [ %t609, %then38 ], [ %t604, %else36 ]
  %t613 = phi double [ %t611, %then38 ], [ %t606, %else36 ]
  store i8* %t612, i8** %l19
  store double %t613, double* %l21
  br label %merge37
merge37:
  %t614 = phi i8* [ %t581, %then35 ], [ %t609, %else36 ]
  %t615 = phi double [ %t583, %then35 ], [ %t611, %else36 ]
  store i8* %t614, i8** %l19
  store double %t615, double* %l21
  %t616 = load i8*, i8** %l18
  %t617 = load i8*, i8** %l19
  %t618 = call i8* @lower_expression(i8* %t617)
  %t619 = add i8* %t616, %t618
  store i8* %t619, i8** %l18
  %t620 = load double, double* %l7
  %t621 = load double, double* %l21
  %t622 = fadd double %t620, %t621
  store double %t622, double* %l7
  br label %merge34
else33:
  %t623 = load i8*, i8** %l18
  %s624 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.624, i32 0, i32 0
  %t625 = add i8* %t623, %s624
  store i8* %t625, i8** %l18
  br label %merge34
merge34:
  %t626 = phi i8* [ %t619, %then32 ], [ %t625, %else33 ]
  %t627 = phi double [ %t622, %then32 ], [ %t542, %else33 ]
  store i8* %t626, i8** %l18
  store double %t627, double* %l7
  %t628 = load %PythonBuilder, %PythonBuilder* %l0
  %t629 = load i8*, i8** %l18
  %t630 = call %PythonBuilder @builder_emit(%PythonBuilder %t628, i8* %t629)
  store %PythonBuilder %t630, %PythonBuilder* %l0
  br label %merge31
else30:
  %t631 = load %NativeInstruction*, %NativeInstruction** %l8
  %t632 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t631, i32 0, i32 0
  %t633 = load i32, i32* %t632
  %t634 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t635 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t636 = icmp eq i32 %t633, 0
  %t637 = select i1 %t636, i8* %t635, i8* %t634
  %t638 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t639 = icmp eq i32 %t633, 1
  %t640 = select i1 %t639, i8* %t638, i8* %t637
  %t641 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t642 = icmp eq i32 %t633, 2
  %t643 = select i1 %t642, i8* %t641, i8* %t640
  %t644 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t645 = icmp eq i32 %t633, 3
  %t646 = select i1 %t645, i8* %t644, i8* %t643
  %t647 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t648 = icmp eq i32 %t633, 4
  %t649 = select i1 %t648, i8* %t647, i8* %t646
  %t650 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t651 = icmp eq i32 %t633, 5
  %t652 = select i1 %t651, i8* %t650, i8* %t649
  %t653 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t654 = icmp eq i32 %t633, 6
  %t655 = select i1 %t654, i8* %t653, i8* %t652
  %t656 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t657 = icmp eq i32 %t633, 7
  %t658 = select i1 %t657, i8* %t656, i8* %t655
  %t659 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t660 = icmp eq i32 %t633, 8
  %t661 = select i1 %t660, i8* %t659, i8* %t658
  %t662 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t663 = icmp eq i32 %t633, 9
  %t664 = select i1 %t663, i8* %t662, i8* %t661
  %t665 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t666 = icmp eq i32 %t633, 10
  %t667 = select i1 %t666, i8* %t665, i8* %t664
  %t668 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t669 = icmp eq i32 %t633, 11
  %t670 = select i1 %t669, i8* %t668, i8* %t667
  %t671 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t672 = icmp eq i32 %t633, 12
  %t673 = select i1 %t672, i8* %t671, i8* %t670
  %t674 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t675 = icmp eq i32 %t633, 13
  %t676 = select i1 %t675, i8* %t674, i8* %t673
  %t677 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t678 = icmp eq i32 %t633, 14
  %t679 = select i1 %t678, i8* %t677, i8* %t676
  %t680 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t681 = icmp eq i32 %t633, 15
  %t682 = select i1 %t681, i8* %t680, i8* %t679
  %t683 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t684 = icmp eq i32 %t633, 16
  %t685 = select i1 %t684, i8* %t683, i8* %t682
  %s686 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.686, i32 0, i32 0
  %t687 = icmp eq i8* %t685, %s686
  %t688 = load %PythonBuilder, %PythonBuilder* %l0
  %t689 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t690 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t691 = load i8, i8* %l3
  %t692 = load double, double* %l4
  %t693 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t694 = load double, double* %l6
  %t695 = load double, double* %l7
  %t696 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t687, label %then40, label %else41
then40:
  %t697 = load %NativeInstruction*, %NativeInstruction** %l8
  %t698 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t697, i32 0, i32 0
  %t699 = load i32, i32* %t698
  %t700 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t697, i32 0, i32 1
  %t701 = bitcast [8 x i8]* %t700 to i8*
  %t702 = bitcast i8* %t701 to i8**
  %t703 = load i8*, i8** %t702
  %t704 = icmp eq i32 %t699, 3
  %t705 = select i1 %t704, i8* %t703, i8* null
  %t706 = call i8* @trim_text(i8* %t705)
  %t707 = call i8* @rewrite_expression_intrinsics(i8* %t706)
  store i8* %t707, i8** %l23
  %t708 = load %PythonBuilder, %PythonBuilder* %l0
  %s709 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.709, i32 0, i32 0
  %t710 = load i8*, i8** %l23
  %t711 = add i8* %s709, %t710
  %t712 = getelementptr i8, i8* %t711, i64 0
  %t713 = load i8, i8* %t712
  %t714 = add i8 %t713, 58
  %t715 = alloca [2 x i8], align 1
  %t716 = getelementptr [2 x i8], [2 x i8]* %t715, i32 0, i32 0
  store i8 %t714, i8* %t716
  %t717 = getelementptr [2 x i8], [2 x i8]* %t715, i32 0, i32 1
  store i8 0, i8* %t717
  %t718 = getelementptr [2 x i8], [2 x i8]* %t715, i32 0, i32 0
  %t719 = call %PythonBuilder @builder_emit(%PythonBuilder %t708, i8* %t718)
  store %PythonBuilder %t719, %PythonBuilder* %l0
  %t720 = load %PythonBuilder, %PythonBuilder* %l0
  %t721 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t720)
  store %PythonBuilder %t721, %PythonBuilder* %l0
  %t722 = load double, double* %l4
  %t723 = sitofp i64 1 to double
  %t724 = fadd double %t722, %t723
  store double %t724, double* %l4
  br label %merge42
else41:
  %t725 = load %NativeInstruction*, %NativeInstruction** %l8
  %t726 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t725, i32 0, i32 0
  %t727 = load i32, i32* %t726
  %t728 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t729 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t730 = icmp eq i32 %t727, 0
  %t731 = select i1 %t730, i8* %t729, i8* %t728
  %t732 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t733 = icmp eq i32 %t727, 1
  %t734 = select i1 %t733, i8* %t732, i8* %t731
  %t735 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t736 = icmp eq i32 %t727, 2
  %t737 = select i1 %t736, i8* %t735, i8* %t734
  %t738 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t739 = icmp eq i32 %t727, 3
  %t740 = select i1 %t739, i8* %t738, i8* %t737
  %t741 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t742 = icmp eq i32 %t727, 4
  %t743 = select i1 %t742, i8* %t741, i8* %t740
  %t744 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t745 = icmp eq i32 %t727, 5
  %t746 = select i1 %t745, i8* %t744, i8* %t743
  %t747 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t748 = icmp eq i32 %t727, 6
  %t749 = select i1 %t748, i8* %t747, i8* %t746
  %t750 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t751 = icmp eq i32 %t727, 7
  %t752 = select i1 %t751, i8* %t750, i8* %t749
  %t753 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t754 = icmp eq i32 %t727, 8
  %t755 = select i1 %t754, i8* %t753, i8* %t752
  %t756 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t757 = icmp eq i32 %t727, 9
  %t758 = select i1 %t757, i8* %t756, i8* %t755
  %t759 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t760 = icmp eq i32 %t727, 10
  %t761 = select i1 %t760, i8* %t759, i8* %t758
  %t762 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t763 = icmp eq i32 %t727, 11
  %t764 = select i1 %t763, i8* %t762, i8* %t761
  %t765 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t766 = icmp eq i32 %t727, 12
  %t767 = select i1 %t766, i8* %t765, i8* %t764
  %t768 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t769 = icmp eq i32 %t727, 13
  %t770 = select i1 %t769, i8* %t768, i8* %t767
  %t771 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t772 = icmp eq i32 %t727, 14
  %t773 = select i1 %t772, i8* %t771, i8* %t770
  %t774 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t775 = icmp eq i32 %t727, 15
  %t776 = select i1 %t775, i8* %t774, i8* %t773
  %t777 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t778 = icmp eq i32 %t727, 16
  %t779 = select i1 %t778, i8* %t777, i8* %t776
  %s780 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.780, i32 0, i32 0
  %t781 = icmp eq i8* %t779, %s780
  %t782 = load %PythonBuilder, %PythonBuilder* %l0
  %t783 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t784 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t785 = load i8, i8* %l3
  %t786 = load double, double* %l4
  %t787 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t788 = load double, double* %l6
  %t789 = load double, double* %l7
  %t790 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t781, label %then43, label %else44
then43:
  %t791 = load double, double* %l4
  %t792 = sitofp i64 0 to double
  %t793 = fcmp ogt double %t791, %t792
  %t794 = load %PythonBuilder, %PythonBuilder* %l0
  %t795 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t796 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t797 = load i8, i8* %l3
  %t798 = load double, double* %l4
  %t799 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t800 = load double, double* %l6
  %t801 = load double, double* %l7
  %t802 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t793, label %then46, label %else47
then46:
  %t803 = load %PythonBuilder, %PythonBuilder* %l0
  %t804 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t803)
  store %PythonBuilder %t804, %PythonBuilder* %l0
  br label %merge48
else47:
  %t805 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t806 = extractvalue %NativeFunction %function, 0
  %s807 = getelementptr inbounds [25 x i8], [25 x i8]* @.str.807, i32 0, i32 0
  %t808 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t805, i8* %t806, i8* %s807)
  store { i8**, i64 }* %t808, { i8**, i64 }** %l1
  br label %merge48
merge48:
  %t809 = phi %PythonBuilder [ %t804, %then46 ], [ %t794, %else47 ]
  %t810 = phi { i8**, i64 }* [ %t795, %then46 ], [ %t808, %else47 ]
  store %PythonBuilder %t809, %PythonBuilder* %l0
  store { i8**, i64 }* %t810, { i8**, i64 }** %l1
  %t811 = load %PythonBuilder, %PythonBuilder* %l0
  %s812 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.812, i32 0, i32 0
  %t813 = call %PythonBuilder @builder_emit(%PythonBuilder %t811, i8* %s812)
  store %PythonBuilder %t813, %PythonBuilder* %l0
  %t814 = load %PythonBuilder, %PythonBuilder* %l0
  %t815 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t814)
  store %PythonBuilder %t815, %PythonBuilder* %l0
  br label %merge45
else44:
  %t816 = load %NativeInstruction*, %NativeInstruction** %l8
  %t817 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t816, i32 0, i32 0
  %t818 = load i32, i32* %t817
  %t819 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t820 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t821 = icmp eq i32 %t818, 0
  %t822 = select i1 %t821, i8* %t820, i8* %t819
  %t823 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t824 = icmp eq i32 %t818, 1
  %t825 = select i1 %t824, i8* %t823, i8* %t822
  %t826 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t827 = icmp eq i32 %t818, 2
  %t828 = select i1 %t827, i8* %t826, i8* %t825
  %t829 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t830 = icmp eq i32 %t818, 3
  %t831 = select i1 %t830, i8* %t829, i8* %t828
  %t832 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t833 = icmp eq i32 %t818, 4
  %t834 = select i1 %t833, i8* %t832, i8* %t831
  %t835 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t836 = icmp eq i32 %t818, 5
  %t837 = select i1 %t836, i8* %t835, i8* %t834
  %t838 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t839 = icmp eq i32 %t818, 6
  %t840 = select i1 %t839, i8* %t838, i8* %t837
  %t841 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t842 = icmp eq i32 %t818, 7
  %t843 = select i1 %t842, i8* %t841, i8* %t840
  %t844 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t845 = icmp eq i32 %t818, 8
  %t846 = select i1 %t845, i8* %t844, i8* %t843
  %t847 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t848 = icmp eq i32 %t818, 9
  %t849 = select i1 %t848, i8* %t847, i8* %t846
  %t850 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t851 = icmp eq i32 %t818, 10
  %t852 = select i1 %t851, i8* %t850, i8* %t849
  %t853 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t854 = icmp eq i32 %t818, 11
  %t855 = select i1 %t854, i8* %t853, i8* %t852
  %t856 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t857 = icmp eq i32 %t818, 12
  %t858 = select i1 %t857, i8* %t856, i8* %t855
  %t859 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t860 = icmp eq i32 %t818, 13
  %t861 = select i1 %t860, i8* %t859, i8* %t858
  %t862 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t863 = icmp eq i32 %t818, 14
  %t864 = select i1 %t863, i8* %t862, i8* %t861
  %t865 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t866 = icmp eq i32 %t818, 15
  %t867 = select i1 %t866, i8* %t865, i8* %t864
  %t868 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t869 = icmp eq i32 %t818, 16
  %t870 = select i1 %t869, i8* %t868, i8* %t867
  %s871 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.871, i32 0, i32 0
  %t872 = icmp eq i8* %t870, %s871
  %t873 = load %PythonBuilder, %PythonBuilder* %l0
  %t874 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t875 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t876 = load i8, i8* %l3
  %t877 = load double, double* %l4
  %t878 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t879 = load double, double* %l6
  %t880 = load double, double* %l7
  %t881 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t872, label %then49, label %else50
then49:
  %t882 = load double, double* %l4
  %t883 = sitofp i64 0 to double
  %t884 = fcmp ogt double %t882, %t883
  %t885 = load %PythonBuilder, %PythonBuilder* %l0
  %t886 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t887 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t888 = load i8, i8* %l3
  %t889 = load double, double* %l4
  %t890 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t891 = load double, double* %l6
  %t892 = load double, double* %l7
  %t893 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t884, label %then52, label %else53
then52:
  %t894 = load %PythonBuilder, %PythonBuilder* %l0
  %t895 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t894)
  store %PythonBuilder %t895, %PythonBuilder* %l0
  %t896 = load double, double* %l4
  %t897 = sitofp i64 1 to double
  %t898 = fsub double %t896, %t897
  store double %t898, double* %l4
  br label %merge54
else53:
  %t899 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t900 = extractvalue %NativeFunction %function, 0
  %s901 = getelementptr inbounds [26 x i8], [26 x i8]* @.str.901, i32 0, i32 0
  %t902 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t899, i8* %t900, i8* %s901)
  store { i8**, i64 }* %t902, { i8**, i64 }** %l1
  br label %merge54
merge54:
  %t903 = phi %PythonBuilder [ %t895, %then52 ], [ %t885, %else53 ]
  %t904 = phi double [ %t898, %then52 ], [ %t889, %else53 ]
  %t905 = phi { i8**, i64 }* [ %t886, %then52 ], [ %t902, %else53 ]
  store %PythonBuilder %t903, %PythonBuilder* %l0
  store double %t904, double* %l4
  store { i8**, i64 }* %t905, { i8**, i64 }** %l1
  br label %merge51
else50:
  %t906 = load %NativeInstruction*, %NativeInstruction** %l8
  %t907 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t906, i32 0, i32 0
  %t908 = load i32, i32* %t907
  %t909 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t910 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t911 = icmp eq i32 %t908, 0
  %t912 = select i1 %t911, i8* %t910, i8* %t909
  %t913 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t914 = icmp eq i32 %t908, 1
  %t915 = select i1 %t914, i8* %t913, i8* %t912
  %t916 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t917 = icmp eq i32 %t908, 2
  %t918 = select i1 %t917, i8* %t916, i8* %t915
  %t919 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t920 = icmp eq i32 %t908, 3
  %t921 = select i1 %t920, i8* %t919, i8* %t918
  %t922 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t923 = icmp eq i32 %t908, 4
  %t924 = select i1 %t923, i8* %t922, i8* %t921
  %t925 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t926 = icmp eq i32 %t908, 5
  %t927 = select i1 %t926, i8* %t925, i8* %t924
  %t928 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t929 = icmp eq i32 %t908, 6
  %t930 = select i1 %t929, i8* %t928, i8* %t927
  %t931 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t932 = icmp eq i32 %t908, 7
  %t933 = select i1 %t932, i8* %t931, i8* %t930
  %t934 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t935 = icmp eq i32 %t908, 8
  %t936 = select i1 %t935, i8* %t934, i8* %t933
  %t937 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t938 = icmp eq i32 %t908, 9
  %t939 = select i1 %t938, i8* %t937, i8* %t936
  %t940 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t941 = icmp eq i32 %t908, 10
  %t942 = select i1 %t941, i8* %t940, i8* %t939
  %t943 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t944 = icmp eq i32 %t908, 11
  %t945 = select i1 %t944, i8* %t943, i8* %t942
  %t946 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t947 = icmp eq i32 %t908, 12
  %t948 = select i1 %t947, i8* %t946, i8* %t945
  %t949 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t950 = icmp eq i32 %t908, 13
  %t951 = select i1 %t950, i8* %t949, i8* %t948
  %t952 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t953 = icmp eq i32 %t908, 14
  %t954 = select i1 %t953, i8* %t952, i8* %t951
  %t955 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t956 = icmp eq i32 %t908, 15
  %t957 = select i1 %t956, i8* %t955, i8* %t954
  %t958 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t959 = icmp eq i32 %t908, 16
  %t960 = select i1 %t959, i8* %t958, i8* %t957
  %s961 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.961, i32 0, i32 0
  %t962 = icmp eq i8* %t960, %s961
  %t963 = load %PythonBuilder, %PythonBuilder* %l0
  %t964 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t965 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t966 = load i8, i8* %l3
  %t967 = load double, double* %l4
  %t968 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t969 = load double, double* %l6
  %t970 = load double, double* %l7
  %t971 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t962, label %then55, label %else56
then55:
  %t972 = load %NativeInstruction*, %NativeInstruction** %l8
  %t973 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t972, i32 0, i32 0
  %t974 = load i32, i32* %t973
  %t975 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t972, i32 0, i32 1
  %t976 = bitcast [16 x i8]* %t975 to i8*
  %t977 = getelementptr inbounds i8, i8* %t976, i64 8
  %t978 = bitcast i8* %t977 to i8**
  %t979 = load i8*, i8** %t978
  %t980 = icmp eq i32 %t974, 6
  %t981 = select i1 %t980, i8* %t979, i8* null
  %t982 = call i8* @trim_text(i8* %t981)
  %t983 = call i8* @rewrite_expression_intrinsics(i8* %t982)
  store i8* %t983, i8** %l24
  %t984 = load %PythonBuilder, %PythonBuilder* %l0
  %s985 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.985, i32 0, i32 0
  %t986 = load %NativeInstruction*, %NativeInstruction** %l8
  %t987 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t986, i32 0, i32 0
  %t988 = load i32, i32* %t987
  %t989 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t986, i32 0, i32 1
  %t990 = bitcast [16 x i8]* %t989 to i8*
  %t991 = bitcast i8* %t990 to i8**
  %t992 = load i8*, i8** %t991
  %t993 = icmp eq i32 %t988, 6
  %t994 = select i1 %t993, i8* %t992, i8* null
  %t995 = add i8* %s985, %t994
  %s996 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.996, i32 0, i32 0
  %t997 = add i8* %t995, %s996
  %t998 = load i8*, i8** %l24
  %t999 = add i8* %t997, %t998
  %t1000 = getelementptr i8, i8* %t999, i64 0
  %t1001 = load i8, i8* %t1000
  %t1002 = add i8 %t1001, 58
  %t1003 = alloca [2 x i8], align 1
  %t1004 = getelementptr [2 x i8], [2 x i8]* %t1003, i32 0, i32 0
  store i8 %t1002, i8* %t1004
  %t1005 = getelementptr [2 x i8], [2 x i8]* %t1003, i32 0, i32 1
  store i8 0, i8* %t1005
  %t1006 = getelementptr [2 x i8], [2 x i8]* %t1003, i32 0, i32 0
  %t1007 = call %PythonBuilder @builder_emit(%PythonBuilder %t984, i8* %t1006)
  store %PythonBuilder %t1007, %PythonBuilder* %l0
  %t1008 = load %PythonBuilder, %PythonBuilder* %l0
  %t1009 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t1008)
  store %PythonBuilder %t1009, %PythonBuilder* %l0
  %t1010 = load double, double* %l4
  %t1011 = sitofp i64 1 to double
  %t1012 = fadd double %t1010, %t1011
  store double %t1012, double* %l4
  br label %merge57
else56:
  %t1013 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1014 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1013, i32 0, i32 0
  %t1015 = load i32, i32* %t1014
  %t1016 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1017 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1018 = icmp eq i32 %t1015, 0
  %t1019 = select i1 %t1018, i8* %t1017, i8* %t1016
  %t1020 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1021 = icmp eq i32 %t1015, 1
  %t1022 = select i1 %t1021, i8* %t1020, i8* %t1019
  %t1023 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1024 = icmp eq i32 %t1015, 2
  %t1025 = select i1 %t1024, i8* %t1023, i8* %t1022
  %t1026 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1027 = icmp eq i32 %t1015, 3
  %t1028 = select i1 %t1027, i8* %t1026, i8* %t1025
  %t1029 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1030 = icmp eq i32 %t1015, 4
  %t1031 = select i1 %t1030, i8* %t1029, i8* %t1028
  %t1032 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1033 = icmp eq i32 %t1015, 5
  %t1034 = select i1 %t1033, i8* %t1032, i8* %t1031
  %t1035 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1036 = icmp eq i32 %t1015, 6
  %t1037 = select i1 %t1036, i8* %t1035, i8* %t1034
  %t1038 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1039 = icmp eq i32 %t1015, 7
  %t1040 = select i1 %t1039, i8* %t1038, i8* %t1037
  %t1041 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1042 = icmp eq i32 %t1015, 8
  %t1043 = select i1 %t1042, i8* %t1041, i8* %t1040
  %t1044 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1045 = icmp eq i32 %t1015, 9
  %t1046 = select i1 %t1045, i8* %t1044, i8* %t1043
  %t1047 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1048 = icmp eq i32 %t1015, 10
  %t1049 = select i1 %t1048, i8* %t1047, i8* %t1046
  %t1050 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1051 = icmp eq i32 %t1015, 11
  %t1052 = select i1 %t1051, i8* %t1050, i8* %t1049
  %t1053 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1054 = icmp eq i32 %t1015, 12
  %t1055 = select i1 %t1054, i8* %t1053, i8* %t1052
  %t1056 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1057 = icmp eq i32 %t1015, 13
  %t1058 = select i1 %t1057, i8* %t1056, i8* %t1055
  %t1059 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1060 = icmp eq i32 %t1015, 14
  %t1061 = select i1 %t1060, i8* %t1059, i8* %t1058
  %t1062 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1063 = icmp eq i32 %t1015, 15
  %t1064 = select i1 %t1063, i8* %t1062, i8* %t1061
  %t1065 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1066 = icmp eq i32 %t1015, 16
  %t1067 = select i1 %t1066, i8* %t1065, i8* %t1064
  %s1068 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.1068, i32 0, i32 0
  %t1069 = icmp eq i8* %t1067, %s1068
  %t1070 = load %PythonBuilder, %PythonBuilder* %l0
  %t1071 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1072 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1073 = load i8, i8* %l3
  %t1074 = load double, double* %l4
  %t1075 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1076 = load double, double* %l6
  %t1077 = load double, double* %l7
  %t1078 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1069, label %then58, label %else59
then58:
  %t1079 = load double, double* %l4
  %t1080 = sitofp i64 0 to double
  %t1081 = fcmp ogt double %t1079, %t1080
  %t1082 = load %PythonBuilder, %PythonBuilder* %l0
  %t1083 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1084 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1085 = load i8, i8* %l3
  %t1086 = load double, double* %l4
  %t1087 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1088 = load double, double* %l6
  %t1089 = load double, double* %l7
  %t1090 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1081, label %then61, label %else62
then61:
  %t1091 = load %PythonBuilder, %PythonBuilder* %l0
  %t1092 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t1091)
  store %PythonBuilder %t1092, %PythonBuilder* %l0
  %t1093 = load double, double* %l4
  %t1094 = sitofp i64 1 to double
  %t1095 = fsub double %t1093, %t1094
  store double %t1095, double* %l4
  br label %merge63
else62:
  %t1096 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1097 = extractvalue %NativeFunction %function, 0
  %s1098 = getelementptr inbounds [33 x i8], [33 x i8]* @.str.1098, i32 0, i32 0
  %t1099 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t1096, i8* %t1097, i8* %s1098)
  store { i8**, i64 }* %t1099, { i8**, i64 }** %l1
  br label %merge63
merge63:
  %t1100 = phi %PythonBuilder [ %t1092, %then61 ], [ %t1082, %else62 ]
  %t1101 = phi double [ %t1095, %then61 ], [ %t1086, %else62 ]
  %t1102 = phi { i8**, i64 }* [ %t1083, %then61 ], [ %t1099, %else62 ]
  store %PythonBuilder %t1100, %PythonBuilder* %l0
  store double %t1101, double* %l4
  store { i8**, i64 }* %t1102, { i8**, i64 }** %l1
  br label %merge60
else59:
  %t1103 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1104 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1103, i32 0, i32 0
  %t1105 = load i32, i32* %t1104
  %t1106 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1107 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1108 = icmp eq i32 %t1105, 0
  %t1109 = select i1 %t1108, i8* %t1107, i8* %t1106
  %t1110 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1111 = icmp eq i32 %t1105, 1
  %t1112 = select i1 %t1111, i8* %t1110, i8* %t1109
  %t1113 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1114 = icmp eq i32 %t1105, 2
  %t1115 = select i1 %t1114, i8* %t1113, i8* %t1112
  %t1116 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1117 = icmp eq i32 %t1105, 3
  %t1118 = select i1 %t1117, i8* %t1116, i8* %t1115
  %t1119 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1120 = icmp eq i32 %t1105, 4
  %t1121 = select i1 %t1120, i8* %t1119, i8* %t1118
  %t1122 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1123 = icmp eq i32 %t1105, 5
  %t1124 = select i1 %t1123, i8* %t1122, i8* %t1121
  %t1125 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1126 = icmp eq i32 %t1105, 6
  %t1127 = select i1 %t1126, i8* %t1125, i8* %t1124
  %t1128 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1129 = icmp eq i32 %t1105, 7
  %t1130 = select i1 %t1129, i8* %t1128, i8* %t1127
  %t1131 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1132 = icmp eq i32 %t1105, 8
  %t1133 = select i1 %t1132, i8* %t1131, i8* %t1130
  %t1134 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1135 = icmp eq i32 %t1105, 9
  %t1136 = select i1 %t1135, i8* %t1134, i8* %t1133
  %t1137 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1138 = icmp eq i32 %t1105, 10
  %t1139 = select i1 %t1138, i8* %t1137, i8* %t1136
  %t1140 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1141 = icmp eq i32 %t1105, 11
  %t1142 = select i1 %t1141, i8* %t1140, i8* %t1139
  %t1143 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1144 = icmp eq i32 %t1105, 12
  %t1145 = select i1 %t1144, i8* %t1143, i8* %t1142
  %t1146 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1147 = icmp eq i32 %t1105, 13
  %t1148 = select i1 %t1147, i8* %t1146, i8* %t1145
  %t1149 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1150 = icmp eq i32 %t1105, 14
  %t1151 = select i1 %t1150, i8* %t1149, i8* %t1148
  %t1152 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1153 = icmp eq i32 %t1105, 15
  %t1154 = select i1 %t1153, i8* %t1152, i8* %t1151
  %t1155 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1156 = icmp eq i32 %t1105, 16
  %t1157 = select i1 %t1156, i8* %t1155, i8* %t1154
  %s1158 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.1158, i32 0, i32 0
  %t1159 = icmp eq i8* %t1157, %s1158
  %t1160 = load %PythonBuilder, %PythonBuilder* %l0
  %t1161 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1162 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1163 = load i8, i8* %l3
  %t1164 = load double, double* %l4
  %t1165 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1166 = load double, double* %l6
  %t1167 = load double, double* %l7
  %t1168 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1159, label %then64, label %else65
then64:
  %t1169 = load %PythonBuilder, %PythonBuilder* %l0
  %s1170 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.1170, i32 0, i32 0
  %t1171 = call %PythonBuilder @builder_emit(%PythonBuilder %t1169, i8* %s1170)
  store %PythonBuilder %t1171, %PythonBuilder* %l0
  %t1172 = load %PythonBuilder, %PythonBuilder* %l0
  %t1173 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t1172)
  store %PythonBuilder %t1173, %PythonBuilder* %l0
  %t1174 = load double, double* %l4
  %t1175 = sitofp i64 1 to double
  %t1176 = fadd double %t1174, %t1175
  store double %t1176, double* %l4
  br label %merge66
else65:
  %t1177 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1178 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1177, i32 0, i32 0
  %t1179 = load i32, i32* %t1178
  %t1180 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1181 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1182 = icmp eq i32 %t1179, 0
  %t1183 = select i1 %t1182, i8* %t1181, i8* %t1180
  %t1184 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1185 = icmp eq i32 %t1179, 1
  %t1186 = select i1 %t1185, i8* %t1184, i8* %t1183
  %t1187 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1188 = icmp eq i32 %t1179, 2
  %t1189 = select i1 %t1188, i8* %t1187, i8* %t1186
  %t1190 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1191 = icmp eq i32 %t1179, 3
  %t1192 = select i1 %t1191, i8* %t1190, i8* %t1189
  %t1193 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1194 = icmp eq i32 %t1179, 4
  %t1195 = select i1 %t1194, i8* %t1193, i8* %t1192
  %t1196 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1197 = icmp eq i32 %t1179, 5
  %t1198 = select i1 %t1197, i8* %t1196, i8* %t1195
  %t1199 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1200 = icmp eq i32 %t1179, 6
  %t1201 = select i1 %t1200, i8* %t1199, i8* %t1198
  %t1202 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1203 = icmp eq i32 %t1179, 7
  %t1204 = select i1 %t1203, i8* %t1202, i8* %t1201
  %t1205 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1206 = icmp eq i32 %t1179, 8
  %t1207 = select i1 %t1206, i8* %t1205, i8* %t1204
  %t1208 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1209 = icmp eq i32 %t1179, 9
  %t1210 = select i1 %t1209, i8* %t1208, i8* %t1207
  %t1211 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1212 = icmp eq i32 %t1179, 10
  %t1213 = select i1 %t1212, i8* %t1211, i8* %t1210
  %t1214 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1215 = icmp eq i32 %t1179, 11
  %t1216 = select i1 %t1215, i8* %t1214, i8* %t1213
  %t1217 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1218 = icmp eq i32 %t1179, 12
  %t1219 = select i1 %t1218, i8* %t1217, i8* %t1216
  %t1220 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1221 = icmp eq i32 %t1179, 13
  %t1222 = select i1 %t1221, i8* %t1220, i8* %t1219
  %t1223 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1224 = icmp eq i32 %t1179, 14
  %t1225 = select i1 %t1224, i8* %t1223, i8* %t1222
  %t1226 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1227 = icmp eq i32 %t1179, 15
  %t1228 = select i1 %t1227, i8* %t1226, i8* %t1225
  %t1229 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1230 = icmp eq i32 %t1179, 16
  %t1231 = select i1 %t1230, i8* %t1229, i8* %t1228
  %s1232 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.1232, i32 0, i32 0
  %t1233 = icmp eq i8* %t1231, %s1232
  %t1234 = load %PythonBuilder, %PythonBuilder* %l0
  %t1235 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1236 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1237 = load i8, i8* %l3
  %t1238 = load double, double* %l4
  %t1239 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1240 = load double, double* %l6
  %t1241 = load double, double* %l7
  %t1242 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1233, label %then67, label %else68
then67:
  %t1243 = load double, double* %l4
  %t1244 = sitofp i64 0 to double
  %t1245 = fcmp ogt double %t1243, %t1244
  %t1246 = load %PythonBuilder, %PythonBuilder* %l0
  %t1247 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1248 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1249 = load i8, i8* %l3
  %t1250 = load double, double* %l4
  %t1251 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1252 = load double, double* %l6
  %t1253 = load double, double* %l7
  %t1254 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1245, label %then70, label %else71
then70:
  %t1255 = load %PythonBuilder, %PythonBuilder* %l0
  %t1256 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t1255)
  store %PythonBuilder %t1256, %PythonBuilder* %l0
  %t1257 = load double, double* %l4
  %t1258 = sitofp i64 1 to double
  %t1259 = fsub double %t1257, %t1258
  store double %t1259, double* %l4
  br label %merge72
else71:
  %t1260 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1261 = extractvalue %NativeFunction %function, 0
  %s1262 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.1262, i32 0, i32 0
  %t1263 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t1260, i8* %t1261, i8* %s1262)
  store { i8**, i64 }* %t1263, { i8**, i64 }** %l1
  br label %merge72
merge72:
  %t1264 = phi %PythonBuilder [ %t1256, %then70 ], [ %t1246, %else71 ]
  %t1265 = phi double [ %t1259, %then70 ], [ %t1250, %else71 ]
  %t1266 = phi { i8**, i64 }* [ %t1247, %then70 ], [ %t1263, %else71 ]
  store %PythonBuilder %t1264, %PythonBuilder* %l0
  store double %t1265, double* %l4
  store { i8**, i64 }* %t1266, { i8**, i64 }** %l1
  br label %merge69
else68:
  %t1267 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1268 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1267, i32 0, i32 0
  %t1269 = load i32, i32* %t1268
  %t1270 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1271 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1272 = icmp eq i32 %t1269, 0
  %t1273 = select i1 %t1272, i8* %t1271, i8* %t1270
  %t1274 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1275 = icmp eq i32 %t1269, 1
  %t1276 = select i1 %t1275, i8* %t1274, i8* %t1273
  %t1277 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1278 = icmp eq i32 %t1269, 2
  %t1279 = select i1 %t1278, i8* %t1277, i8* %t1276
  %t1280 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1281 = icmp eq i32 %t1269, 3
  %t1282 = select i1 %t1281, i8* %t1280, i8* %t1279
  %t1283 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1284 = icmp eq i32 %t1269, 4
  %t1285 = select i1 %t1284, i8* %t1283, i8* %t1282
  %t1286 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1287 = icmp eq i32 %t1269, 5
  %t1288 = select i1 %t1287, i8* %t1286, i8* %t1285
  %t1289 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1290 = icmp eq i32 %t1269, 6
  %t1291 = select i1 %t1290, i8* %t1289, i8* %t1288
  %t1292 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1293 = icmp eq i32 %t1269, 7
  %t1294 = select i1 %t1293, i8* %t1292, i8* %t1291
  %t1295 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1296 = icmp eq i32 %t1269, 8
  %t1297 = select i1 %t1296, i8* %t1295, i8* %t1294
  %t1298 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1299 = icmp eq i32 %t1269, 9
  %t1300 = select i1 %t1299, i8* %t1298, i8* %t1297
  %t1301 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1302 = icmp eq i32 %t1269, 10
  %t1303 = select i1 %t1302, i8* %t1301, i8* %t1300
  %t1304 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1305 = icmp eq i32 %t1269, 11
  %t1306 = select i1 %t1305, i8* %t1304, i8* %t1303
  %t1307 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1308 = icmp eq i32 %t1269, 12
  %t1309 = select i1 %t1308, i8* %t1307, i8* %t1306
  %t1310 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1311 = icmp eq i32 %t1269, 13
  %t1312 = select i1 %t1311, i8* %t1310, i8* %t1309
  %t1313 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1314 = icmp eq i32 %t1269, 14
  %t1315 = select i1 %t1314, i8* %t1313, i8* %t1312
  %t1316 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1317 = icmp eq i32 %t1269, 15
  %t1318 = select i1 %t1317, i8* %t1316, i8* %t1315
  %t1319 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1320 = icmp eq i32 %t1269, 16
  %t1321 = select i1 %t1320, i8* %t1319, i8* %t1318
  %s1322 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.1322, i32 0, i32 0
  %t1323 = icmp eq i8* %t1321, %s1322
  %t1324 = load %PythonBuilder, %PythonBuilder* %l0
  %t1325 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1326 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1327 = load i8, i8* %l3
  %t1328 = load double, double* %l4
  %t1329 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1330 = load double, double* %l6
  %t1331 = load double, double* %l7
  %t1332 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1323, label %then73, label %else74
then73:
  %t1333 = load %PythonBuilder, %PythonBuilder* %l0
  %s1334 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.1334, i32 0, i32 0
  %t1335 = call %PythonBuilder @builder_emit(%PythonBuilder %t1333, i8* %s1334)
  store %PythonBuilder %t1335, %PythonBuilder* %l0
  br label %merge75
else74:
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
  %s1391 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.1391, i32 0, i32 0
  %t1392 = icmp eq i8* %t1390, %s1391
  %t1393 = load %PythonBuilder, %PythonBuilder* %l0
  %t1394 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1395 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1396 = load i8, i8* %l3
  %t1397 = load double, double* %l4
  %t1398 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1399 = load double, double* %l6
  %t1400 = load double, double* %l7
  %t1401 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1392, label %then76, label %else77
then76:
  %t1402 = load %PythonBuilder, %PythonBuilder* %l0
  %s1403 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.1403, i32 0, i32 0
  %t1404 = call %PythonBuilder @builder_emit(%PythonBuilder %t1402, i8* %s1403)
  store %PythonBuilder %t1404, %PythonBuilder* %l0
  br label %merge78
else77:
  %t1405 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1406 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1405, i32 0, i32 0
  %t1407 = load i32, i32* %t1406
  %t1408 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1409 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1410 = icmp eq i32 %t1407, 0
  %t1411 = select i1 %t1410, i8* %t1409, i8* %t1408
  %t1412 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1413 = icmp eq i32 %t1407, 1
  %t1414 = select i1 %t1413, i8* %t1412, i8* %t1411
  %t1415 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1416 = icmp eq i32 %t1407, 2
  %t1417 = select i1 %t1416, i8* %t1415, i8* %t1414
  %t1418 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1419 = icmp eq i32 %t1407, 3
  %t1420 = select i1 %t1419, i8* %t1418, i8* %t1417
  %t1421 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1422 = icmp eq i32 %t1407, 4
  %t1423 = select i1 %t1422, i8* %t1421, i8* %t1420
  %t1424 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1425 = icmp eq i32 %t1407, 5
  %t1426 = select i1 %t1425, i8* %t1424, i8* %t1423
  %t1427 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1428 = icmp eq i32 %t1407, 6
  %t1429 = select i1 %t1428, i8* %t1427, i8* %t1426
  %t1430 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1431 = icmp eq i32 %t1407, 7
  %t1432 = select i1 %t1431, i8* %t1430, i8* %t1429
  %t1433 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1434 = icmp eq i32 %t1407, 8
  %t1435 = select i1 %t1434, i8* %t1433, i8* %t1432
  %t1436 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1437 = icmp eq i32 %t1407, 9
  %t1438 = select i1 %t1437, i8* %t1436, i8* %t1435
  %t1439 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1440 = icmp eq i32 %t1407, 10
  %t1441 = select i1 %t1440, i8* %t1439, i8* %t1438
  %t1442 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1443 = icmp eq i32 %t1407, 11
  %t1444 = select i1 %t1443, i8* %t1442, i8* %t1441
  %t1445 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1446 = icmp eq i32 %t1407, 12
  %t1447 = select i1 %t1446, i8* %t1445, i8* %t1444
  %t1448 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1449 = icmp eq i32 %t1407, 13
  %t1450 = select i1 %t1449, i8* %t1448, i8* %t1447
  %t1451 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1452 = icmp eq i32 %t1407, 14
  %t1453 = select i1 %t1452, i8* %t1451, i8* %t1450
  %t1454 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1455 = icmp eq i32 %t1407, 15
  %t1456 = select i1 %t1455, i8* %t1454, i8* %t1453
  %t1457 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1458 = icmp eq i32 %t1407, 16
  %t1459 = select i1 %t1458, i8* %t1457, i8* %t1456
  %s1460 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.1460, i32 0, i32 0
  %t1461 = icmp eq i8* %t1459, %s1460
  %t1462 = load %PythonBuilder, %PythonBuilder* %l0
  %t1463 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1464 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1465 = load i8, i8* %l3
  %t1466 = load double, double* %l4
  %t1467 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1468 = load double, double* %l6
  %t1469 = load double, double* %l7
  %t1470 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1461, label %then79, label %else80
then79:
  %t1471 = load double, double* %l6
  %t1472 = call i8* @generate_match_subject_name(double %t1471)
  store i8* %t1472, i8** %l25
  %t1473 = load double, double* %l6
  %t1474 = sitofp i64 1 to double
  %t1475 = fadd double %t1473, %t1474
  store double %t1475, double* %l6
  %t1476 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1477 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1476, i32 0, i32 0
  %t1478 = load i32, i32* %t1477
  %t1479 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1476, i32 0, i32 1
  %t1480 = bitcast [16 x i8]* %t1479 to i8*
  %t1481 = bitcast i8* %t1480 to i8**
  %t1482 = load i8*, i8** %t1481
  %t1483 = icmp eq i32 %t1478, 0
  %t1484 = select i1 %t1483, i8* %t1482, i8* null
  %t1485 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1476, i32 0, i32 1
  %t1486 = bitcast [16 x i8]* %t1485 to i8*
  %t1487 = bitcast i8* %t1486 to i8**
  %t1488 = load i8*, i8** %t1487
  %t1489 = icmp eq i32 %t1478, 1
  %t1490 = select i1 %t1489, i8* %t1488, i8* %t1484
  %t1491 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1476, i32 0, i32 1
  %t1492 = bitcast [8 x i8]* %t1491 to i8*
  %t1493 = bitcast i8* %t1492 to i8**
  %t1494 = load i8*, i8** %t1493
  %t1495 = icmp eq i32 %t1478, 12
  %t1496 = select i1 %t1495, i8* %t1494, i8* %t1490
  %t1497 = call i8* @lower_expression(i8* %t1496)
  store i8* %t1497, i8** %l26
  %t1498 = load %PythonBuilder, %PythonBuilder* %l0
  %t1499 = load i8*, i8** %l25
  %s1500 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.1500, i32 0, i32 0
  %t1501 = add i8* %t1499, %s1500
  %t1502 = load i8*, i8** %l26
  %t1503 = add i8* %t1501, %t1502
  %t1504 = call %PythonBuilder @builder_emit(%PythonBuilder %t1498, i8* %t1503)
  store %PythonBuilder %t1504, %PythonBuilder* %l0
  %t1505 = load i8*, i8** %l25
  %t1506 = insertvalue %MatchContext undef, i8* %t1505, 0
  %t1507 = sitofp i64 0 to double
  %t1508 = insertvalue %MatchContext %t1506, double %t1507, 1
  %t1509 = insertvalue %MatchContext %t1508, i1 0, 2
  store %MatchContext %t1509, %MatchContext* %l27
  %t1510 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1511 = load %MatchContext, %MatchContext* %l27
  %t1512 = call { %MatchContext*, i64 }* @append_match_context({ %MatchContext*, i64 }* %t1510, %MatchContext %t1511)
  store { %MatchContext*, i64 }* %t1512, { %MatchContext*, i64 }** %l5
  br label %merge81
else80:
  %t1513 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1514 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1513, i32 0, i32 0
  %t1515 = load i32, i32* %t1514
  %t1516 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1517 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1518 = icmp eq i32 %t1515, 0
  %t1519 = select i1 %t1518, i8* %t1517, i8* %t1516
  %t1520 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1521 = icmp eq i32 %t1515, 1
  %t1522 = select i1 %t1521, i8* %t1520, i8* %t1519
  %t1523 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1524 = icmp eq i32 %t1515, 2
  %t1525 = select i1 %t1524, i8* %t1523, i8* %t1522
  %t1526 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1527 = icmp eq i32 %t1515, 3
  %t1528 = select i1 %t1527, i8* %t1526, i8* %t1525
  %t1529 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1530 = icmp eq i32 %t1515, 4
  %t1531 = select i1 %t1530, i8* %t1529, i8* %t1528
  %t1532 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1533 = icmp eq i32 %t1515, 5
  %t1534 = select i1 %t1533, i8* %t1532, i8* %t1531
  %t1535 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1536 = icmp eq i32 %t1515, 6
  %t1537 = select i1 %t1536, i8* %t1535, i8* %t1534
  %t1538 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1539 = icmp eq i32 %t1515, 7
  %t1540 = select i1 %t1539, i8* %t1538, i8* %t1537
  %t1541 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1542 = icmp eq i32 %t1515, 8
  %t1543 = select i1 %t1542, i8* %t1541, i8* %t1540
  %t1544 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1545 = icmp eq i32 %t1515, 9
  %t1546 = select i1 %t1545, i8* %t1544, i8* %t1543
  %t1547 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1548 = icmp eq i32 %t1515, 10
  %t1549 = select i1 %t1548, i8* %t1547, i8* %t1546
  %t1550 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1551 = icmp eq i32 %t1515, 11
  %t1552 = select i1 %t1551, i8* %t1550, i8* %t1549
  %t1553 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1554 = icmp eq i32 %t1515, 12
  %t1555 = select i1 %t1554, i8* %t1553, i8* %t1552
  %t1556 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1557 = icmp eq i32 %t1515, 13
  %t1558 = select i1 %t1557, i8* %t1556, i8* %t1555
  %t1559 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1560 = icmp eq i32 %t1515, 14
  %t1561 = select i1 %t1560, i8* %t1559, i8* %t1558
  %t1562 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1563 = icmp eq i32 %t1515, 15
  %t1564 = select i1 %t1563, i8* %t1562, i8* %t1561
  %t1565 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1566 = icmp eq i32 %t1515, 16
  %t1567 = select i1 %t1566, i8* %t1565, i8* %t1564
  %s1568 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.1568, i32 0, i32 0
  %t1569 = icmp eq i8* %t1567, %s1568
  %t1570 = load %PythonBuilder, %PythonBuilder* %l0
  %t1571 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1572 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1573 = load i8, i8* %l3
  %t1574 = load double, double* %l4
  %t1575 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1576 = load double, double* %l6
  %t1577 = load double, double* %l7
  %t1578 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1569, label %then82, label %else83
then82:
  %t1579 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1580 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t1579
  %t1581 = extractvalue { %MatchContext*, i64 } %t1580, 1
  %t1582 = icmp eq i64 %t1581, 0
  %t1583 = load %PythonBuilder, %PythonBuilder* %l0
  %t1584 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1585 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1586 = load i8, i8* %l3
  %t1587 = load double, double* %l4
  %t1588 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1589 = load double, double* %l6
  %t1590 = load double, double* %l7
  %t1591 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1582, label %then85, label %else86
then85:
  %t1592 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1593 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1592, i32 0, i32 0
  %t1594 = load i32, i32* %t1593
  %t1595 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1592, i32 0, i32 1
  %t1596 = bitcast [16 x i8]* %t1595 to i8*
  %t1597 = bitcast i8* %t1596 to i8**
  %t1598 = load i8*, i8** %t1597
  %t1599 = icmp eq i32 %t1594, 13
  %t1600 = select i1 %t1599, i8* %t1598, i8* null
  %t1601 = call i8* @trim_text(i8* %t1600)
  store i8* %t1601, i8** %l28
  %s1602 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.1602, i32 0, i32 0
  store i8* %s1602, i8** %l29
  %t1603 = load i8*, i8** %l28
  %t1604 = call i64 @sailfin_runtime_string_length(i8* %t1603)
  %t1605 = icmp sgt i64 %t1604, 0
  %t1606 = load %PythonBuilder, %PythonBuilder* %l0
  %t1607 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1608 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1609 = load i8, i8* %l3
  %t1610 = load double, double* %l4
  %t1611 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1612 = load double, double* %l6
  %t1613 = load double, double* %l7
  %t1614 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1615 = load i8*, i8** %l28
  %t1616 = load i8*, i8** %l29
  br i1 %t1605, label %then88, label %merge89
then88:
  %t1617 = load i8*, i8** %l29
  %s1618 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.1618, i32 0, i32 0
  %t1619 = add i8* %t1617, %s1618
  %t1620 = load i8*, i8** %l28
  %t1621 = add i8* %t1619, %t1620
  %t1622 = getelementptr i8, i8* %t1621, i64 0
  %t1623 = load i8, i8* %t1622
  %t1624 = add i8 %t1623, 41
  %t1625 = alloca [2 x i8], align 1
  %t1626 = getelementptr [2 x i8], [2 x i8]* %t1625, i32 0, i32 0
  store i8 %t1624, i8* %t1626
  %t1627 = getelementptr [2 x i8], [2 x i8]* %t1625, i32 0, i32 1
  store i8 0, i8* %t1627
  %t1628 = getelementptr [2 x i8], [2 x i8]* %t1625, i32 0, i32 0
  store i8* %t1628, i8** %l29
  br label %merge89
merge89:
  %t1629 = phi i8* [ %t1628, %then88 ], [ %t1616, %then85 ]
  store i8* %t1629, i8** %l29
  %t1630 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1631 = extractvalue %NativeFunction %function, 0
  %t1632 = load i8*, i8** %l29
  %t1633 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t1630, i8* %t1631, i8* %t1632)
  store { i8**, i64 }* %t1633, { i8**, i64 }** %l1
  %t1634 = load %PythonBuilder, %PythonBuilder* %l0
  %s1635 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.1635, i32 0, i32 0
  %t1636 = call %PythonBuilder @builder_emit(%PythonBuilder %t1634, i8* %s1635)
  store %PythonBuilder %t1636, %PythonBuilder* %l0
  br label %merge87
else86:
  %t1637 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1638 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t1637
  %t1639 = extractvalue { %MatchContext*, i64 } %t1638, 1
  %t1640 = sub i64 %t1639, 1
  store i64 %t1640, i64* %l30
  %t1641 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1642 = load i64, i64* %l30
  %t1643 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t1641
  %t1644 = extractvalue { %MatchContext*, i64 } %t1643, 0
  %t1645 = extractvalue { %MatchContext*, i64 } %t1643, 1
  %t1646 = icmp uge i64 %t1642, %t1645
  ; bounds check: %t1646 (if true, out of bounds)
  %t1647 = getelementptr %MatchContext, %MatchContext* %t1644, i64 %t1642
  %t1648 = load %MatchContext, %MatchContext* %t1647
  store %MatchContext %t1648, %MatchContext* %l31
  %t1649 = load %MatchContext, %MatchContext* %l31
  %t1650 = extractvalue %MatchContext %t1649, 2
  %t1651 = load %PythonBuilder, %PythonBuilder* %l0
  %t1652 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1653 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1654 = load i8, i8* %l3
  %t1655 = load double, double* %l4
  %t1656 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1657 = load double, double* %l6
  %t1658 = load double, double* %l7
  %t1659 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1660 = load i64, i64* %l30
  %t1661 = load %MatchContext, %MatchContext* %l31
  br i1 %t1650, label %then90, label %merge91
then90:
  %t1662 = load %PythonBuilder, %PythonBuilder* %l0
  %t1663 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t1662)
  store %PythonBuilder %t1663, %PythonBuilder* %l0
  br label %merge91
merge91:
  %t1664 = phi %PythonBuilder [ %t1663, %then90 ], [ %t1651, %else86 ]
  store %PythonBuilder %t1664, %PythonBuilder* %l0
  %t1665 = load %MatchContext, %MatchContext* %l31
  %t1666 = extractvalue %MatchContext %t1665, 0
  %t1667 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1668 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1667, i32 0, i32 0
  %t1669 = load i32, i32* %t1668
  %t1670 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1667, i32 0, i32 1
  %t1671 = bitcast [16 x i8]* %t1670 to i8*
  %t1672 = bitcast i8* %t1671 to i8**
  %t1673 = load i8*, i8** %t1672
  %t1674 = icmp eq i32 %t1669, 13
  %t1675 = select i1 %t1674, i8* %t1673, i8* null
  %t1676 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1677 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1676, i32 0, i32 0
  %t1678 = load i32, i32* %t1677
  %t1679 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1676, i32 0, i32 1
  %t1680 = bitcast [16 x i8]* %t1679 to i8*
  %t1681 = getelementptr inbounds i8, i8* %t1680, i64 8
  %t1682 = bitcast i8* %t1681 to i8**
  %t1683 = load i8*, i8** %t1682
  %t1684 = icmp eq i32 %t1678, 13
  %t1685 = select i1 %t1684, i8* %t1683, i8* null
  %t1686 = call %LoweredCaseCondition @lower_match_case_condition(i8* %t1666, i8* %t1675, i8* %t1685)
  store %LoweredCaseCondition %t1686, %LoweredCaseCondition* %l32
  %t1687 = load %MatchContext, %MatchContext* %l31
  %t1688 = extractvalue %MatchContext %t1687, 1
  %t1689 = sitofp i64 0 to double
  %t1690 = fcmp oeq double %t1688, %t1689
  %t1691 = load %PythonBuilder, %PythonBuilder* %l0
  %t1692 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1693 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1694 = load i8, i8* %l3
  %t1695 = load double, double* %l4
  %t1696 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1697 = load double, double* %l6
  %t1698 = load double, double* %l7
  %t1699 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1700 = load i64, i64* %l30
  %t1701 = load %MatchContext, %MatchContext* %l31
  %t1702 = load %LoweredCaseCondition, %LoweredCaseCondition* %l32
  br i1 %t1690, label %then92, label %else93
then92:
  %t1703 = load %PythonBuilder, %PythonBuilder* %l0
  %s1704 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.1704, i32 0, i32 0
  %t1705 = load %LoweredCaseCondition, %LoweredCaseCondition* %l32
  %t1706 = extractvalue %LoweredCaseCondition %t1705, 0
  %t1707 = add i8* %s1704, %t1706
  %t1708 = getelementptr i8, i8* %t1707, i64 0
  %t1709 = load i8, i8* %t1708
  %t1710 = add i8 %t1709, 58
  %t1711 = alloca [2 x i8], align 1
  %t1712 = getelementptr [2 x i8], [2 x i8]* %t1711, i32 0, i32 0
  store i8 %t1710, i8* %t1712
  %t1713 = getelementptr [2 x i8], [2 x i8]* %t1711, i32 0, i32 1
  store i8 0, i8* %t1713
  %t1714 = getelementptr [2 x i8], [2 x i8]* %t1711, i32 0, i32 0
  %t1715 = call %PythonBuilder @builder_emit(%PythonBuilder %t1703, i8* %t1714)
  store %PythonBuilder %t1715, %PythonBuilder* %l0
  br label %merge94
else93:
  %t1717 = load %LoweredCaseCondition, %LoweredCaseCondition* %l32
  %t1718 = extractvalue %LoweredCaseCondition %t1717, 1
  br label %logical_and_entry_1716

logical_and_entry_1716:
  br i1 %t1718, label %logical_and_right_1716, label %logical_and_merge_1716

logical_and_right_1716:
  %t1719 = load %LoweredCaseCondition, %LoweredCaseCondition* %l32
  %t1720 = extractvalue %LoweredCaseCondition %t1719, 2
  %t1721 = xor i1 %t1720, 1
  br label %logical_and_right_end_1716

logical_and_right_end_1716:
  br label %logical_and_merge_1716

logical_and_merge_1716:
  %t1722 = phi i1 [ false, %logical_and_entry_1716 ], [ %t1721, %logical_and_right_end_1716 ]
  %t1723 = load %PythonBuilder, %PythonBuilder* %l0
  %t1724 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1725 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1726 = load i8, i8* %l3
  %t1727 = load double, double* %l4
  %t1728 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1729 = load double, double* %l6
  %t1730 = load double, double* %l7
  %t1731 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1732 = load i64, i64* %l30
  %t1733 = load %MatchContext, %MatchContext* %l31
  %t1734 = load %LoweredCaseCondition, %LoweredCaseCondition* %l32
  br i1 %t1722, label %then95, label %else96
then95:
  %t1735 = load %PythonBuilder, %PythonBuilder* %l0
  %s1736 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.1736, i32 0, i32 0
  %t1737 = call %PythonBuilder @builder_emit(%PythonBuilder %t1735, i8* %s1736)
  store %PythonBuilder %t1737, %PythonBuilder* %l0
  br label %merge97
else96:
  %t1738 = load %PythonBuilder, %PythonBuilder* %l0
  %s1739 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.1739, i32 0, i32 0
  %t1740 = load %LoweredCaseCondition, %LoweredCaseCondition* %l32
  %t1741 = extractvalue %LoweredCaseCondition %t1740, 0
  %t1742 = add i8* %s1739, %t1741
  %t1743 = getelementptr i8, i8* %t1742, i64 0
  %t1744 = load i8, i8* %t1743
  %t1745 = add i8 %t1744, 58
  %t1746 = alloca [2 x i8], align 1
  %t1747 = getelementptr [2 x i8], [2 x i8]* %t1746, i32 0, i32 0
  store i8 %t1745, i8* %t1747
  %t1748 = getelementptr [2 x i8], [2 x i8]* %t1746, i32 0, i32 1
  store i8 0, i8* %t1748
  %t1749 = getelementptr [2 x i8], [2 x i8]* %t1746, i32 0, i32 0
  %t1750 = call %PythonBuilder @builder_emit(%PythonBuilder %t1738, i8* %t1749)
  store %PythonBuilder %t1750, %PythonBuilder* %l0
  br label %merge97
merge97:
  %t1751 = phi %PythonBuilder [ %t1737, %then95 ], [ %t1750, %else96 ]
  store %PythonBuilder %t1751, %PythonBuilder* %l0
  br label %merge94
merge94:
  %t1752 = phi %PythonBuilder [ %t1715, %then92 ], [ %t1737, %else93 ]
  store %PythonBuilder %t1752, %PythonBuilder* %l0
  %t1753 = load %PythonBuilder, %PythonBuilder* %l0
  %t1754 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t1753)
  store %PythonBuilder %t1754, %PythonBuilder* %l0
  store double 0.0, double* %l33
  %t1755 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1756 = load i64, i64* %l30
  %t1757 = load double, double* %l33
  %t1758 = sitofp i64 %t1756 to double
  %t1759 = call { %MatchContext*, i64 }* @replace_match_context({ %MatchContext*, i64 }* %t1755, double %t1758, %MatchContext zeroinitializer)
  store { %MatchContext*, i64 }* %t1759, { %MatchContext*, i64 }** %l5
  br label %merge87
merge87:
  %t1760 = phi { i8**, i64 }* [ %t1633, %then85 ], [ %t1584, %else86 ]
  %t1761 = phi %PythonBuilder [ %t1636, %then85 ], [ %t1663, %else86 ]
  %t1762 = phi { %MatchContext*, i64 }* [ %t1588, %then85 ], [ %t1759, %else86 ]
  store { i8**, i64 }* %t1760, { i8**, i64 }** %l1
  store %PythonBuilder %t1761, %PythonBuilder* %l0
  store { %MatchContext*, i64 }* %t1762, { %MatchContext*, i64 }** %l5
  br label %merge84
else83:
  %t1763 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1764 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1763, i32 0, i32 0
  %t1765 = load i32, i32* %t1764
  %t1766 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1767 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1768 = icmp eq i32 %t1765, 0
  %t1769 = select i1 %t1768, i8* %t1767, i8* %t1766
  %t1770 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1771 = icmp eq i32 %t1765, 1
  %t1772 = select i1 %t1771, i8* %t1770, i8* %t1769
  %t1773 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1774 = icmp eq i32 %t1765, 2
  %t1775 = select i1 %t1774, i8* %t1773, i8* %t1772
  %t1776 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1777 = icmp eq i32 %t1765, 3
  %t1778 = select i1 %t1777, i8* %t1776, i8* %t1775
  %t1779 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1780 = icmp eq i32 %t1765, 4
  %t1781 = select i1 %t1780, i8* %t1779, i8* %t1778
  %t1782 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1783 = icmp eq i32 %t1765, 5
  %t1784 = select i1 %t1783, i8* %t1782, i8* %t1781
  %t1785 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1786 = icmp eq i32 %t1765, 6
  %t1787 = select i1 %t1786, i8* %t1785, i8* %t1784
  %t1788 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1789 = icmp eq i32 %t1765, 7
  %t1790 = select i1 %t1789, i8* %t1788, i8* %t1787
  %t1791 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1792 = icmp eq i32 %t1765, 8
  %t1793 = select i1 %t1792, i8* %t1791, i8* %t1790
  %t1794 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1795 = icmp eq i32 %t1765, 9
  %t1796 = select i1 %t1795, i8* %t1794, i8* %t1793
  %t1797 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1798 = icmp eq i32 %t1765, 10
  %t1799 = select i1 %t1798, i8* %t1797, i8* %t1796
  %t1800 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1801 = icmp eq i32 %t1765, 11
  %t1802 = select i1 %t1801, i8* %t1800, i8* %t1799
  %t1803 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1804 = icmp eq i32 %t1765, 12
  %t1805 = select i1 %t1804, i8* %t1803, i8* %t1802
  %t1806 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1807 = icmp eq i32 %t1765, 13
  %t1808 = select i1 %t1807, i8* %t1806, i8* %t1805
  %t1809 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1810 = icmp eq i32 %t1765, 14
  %t1811 = select i1 %t1810, i8* %t1809, i8* %t1808
  %t1812 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1813 = icmp eq i32 %t1765, 15
  %t1814 = select i1 %t1813, i8* %t1812, i8* %t1811
  %t1815 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1816 = icmp eq i32 %t1765, 16
  %t1817 = select i1 %t1816, i8* %t1815, i8* %t1814
  %s1818 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.1818, i32 0, i32 0
  %t1819 = icmp eq i8* %t1817, %s1818
  %t1820 = load %PythonBuilder, %PythonBuilder* %l0
  %t1821 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1822 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1823 = load i8, i8* %l3
  %t1824 = load double, double* %l4
  %t1825 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1826 = load double, double* %l6
  %t1827 = load double, double* %l7
  %t1828 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1819, label %then98, label %else99
then98:
  %t1829 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1830 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t1829
  %t1831 = extractvalue { %MatchContext*, i64 } %t1830, 1
  %t1832 = icmp eq i64 %t1831, 0
  %t1833 = load %PythonBuilder, %PythonBuilder* %l0
  %t1834 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1835 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1836 = load i8, i8* %l3
  %t1837 = load double, double* %l4
  %t1838 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1839 = load double, double* %l6
  %t1840 = load double, double* %l7
  %t1841 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1832, label %then101, label %else102
then101:
  %t1842 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1843 = extractvalue %NativeFunction %function, 0
  %s1844 = getelementptr inbounds [38 x i8], [38 x i8]* @.str.1844, i32 0, i32 0
  %t1845 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t1842, i8* %t1843, i8* %s1844)
  store { i8**, i64 }* %t1845, { i8**, i64 }** %l1
  %t1846 = load %PythonBuilder, %PythonBuilder* %l0
  %s1847 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.1847, i32 0, i32 0
  %t1848 = call %PythonBuilder @builder_emit(%PythonBuilder %t1846, i8* %s1847)
  store %PythonBuilder %t1848, %PythonBuilder* %l0
  br label %merge103
else102:
  %t1849 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1850 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t1849
  %t1851 = extractvalue { %MatchContext*, i64 } %t1850, 1
  %t1852 = sub i64 %t1851, 1
  store i64 %t1852, i64* %l34
  %t1853 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1854 = load i64, i64* %l34
  %t1855 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t1853
  %t1856 = extractvalue { %MatchContext*, i64 } %t1855, 0
  %t1857 = extractvalue { %MatchContext*, i64 } %t1855, 1
  %t1858 = icmp uge i64 %t1854, %t1857
  ; bounds check: %t1858 (if true, out of bounds)
  %t1859 = getelementptr %MatchContext, %MatchContext* %t1856, i64 %t1854
  %t1860 = load %MatchContext, %MatchContext* %t1859
  store %MatchContext %t1860, %MatchContext* %l35
  %t1861 = load %MatchContext, %MatchContext* %l35
  %t1862 = extractvalue %MatchContext %t1861, 2
  %t1863 = load %PythonBuilder, %PythonBuilder* %l0
  %t1864 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1865 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1866 = load i8, i8* %l3
  %t1867 = load double, double* %l4
  %t1868 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1869 = load double, double* %l6
  %t1870 = load double, double* %l7
  %t1871 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1872 = load i64, i64* %l34
  %t1873 = load %MatchContext, %MatchContext* %l35
  br i1 %t1862, label %then104, label %merge105
then104:
  %t1874 = load %PythonBuilder, %PythonBuilder* %l0
  %t1875 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t1874)
  store %PythonBuilder %t1875, %PythonBuilder* %l0
  br label %merge105
merge105:
  %t1876 = phi %PythonBuilder [ %t1875, %then104 ], [ %t1863, %else102 ]
  store %PythonBuilder %t1876, %PythonBuilder* %l0
  %t1877 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1878 = load i64, i64* %l34
  %t1879 = sitofp i64 %t1878 to double
  %t1880 = call { %MatchContext*, i64 }* @truncate_match_contexts({ %MatchContext*, i64 }* %t1877, double %t1879)
  store { %MatchContext*, i64 }* %t1880, { %MatchContext*, i64 }** %l5
  br label %merge103
merge103:
  %t1881 = phi { i8**, i64 }* [ %t1845, %then101 ], [ %t1834, %else102 ]
  %t1882 = phi %PythonBuilder [ %t1848, %then101 ], [ %t1875, %else102 ]
  %t1883 = phi { %MatchContext*, i64 }* [ %t1838, %then101 ], [ %t1880, %else102 ]
  store { i8**, i64 }* %t1881, { i8**, i64 }** %l1
  store %PythonBuilder %t1882, %PythonBuilder* %l0
  store { %MatchContext*, i64 }* %t1883, { %MatchContext*, i64 }** %l5
  br label %merge100
else99:
  %t1884 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1885 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1884, i32 0, i32 0
  %t1886 = load i32, i32* %t1885
  %t1887 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1888 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1889 = icmp eq i32 %t1886, 0
  %t1890 = select i1 %t1889, i8* %t1888, i8* %t1887
  %t1891 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1892 = icmp eq i32 %t1886, 1
  %t1893 = select i1 %t1892, i8* %t1891, i8* %t1890
  %t1894 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1895 = icmp eq i32 %t1886, 2
  %t1896 = select i1 %t1895, i8* %t1894, i8* %t1893
  %t1897 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1898 = icmp eq i32 %t1886, 3
  %t1899 = select i1 %t1898, i8* %t1897, i8* %t1896
  %t1900 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1901 = icmp eq i32 %t1886, 4
  %t1902 = select i1 %t1901, i8* %t1900, i8* %t1899
  %t1903 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1904 = icmp eq i32 %t1886, 5
  %t1905 = select i1 %t1904, i8* %t1903, i8* %t1902
  %t1906 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1907 = icmp eq i32 %t1886, 6
  %t1908 = select i1 %t1907, i8* %t1906, i8* %t1905
  %t1909 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1910 = icmp eq i32 %t1886, 7
  %t1911 = select i1 %t1910, i8* %t1909, i8* %t1908
  %t1912 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1913 = icmp eq i32 %t1886, 8
  %t1914 = select i1 %t1913, i8* %t1912, i8* %t1911
  %t1915 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1916 = icmp eq i32 %t1886, 9
  %t1917 = select i1 %t1916, i8* %t1915, i8* %t1914
  %t1918 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1919 = icmp eq i32 %t1886, 10
  %t1920 = select i1 %t1919, i8* %t1918, i8* %t1917
  %t1921 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1922 = icmp eq i32 %t1886, 11
  %t1923 = select i1 %t1922, i8* %t1921, i8* %t1920
  %t1924 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1925 = icmp eq i32 %t1886, 12
  %t1926 = select i1 %t1925, i8* %t1924, i8* %t1923
  %t1927 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1928 = icmp eq i32 %t1886, 13
  %t1929 = select i1 %t1928, i8* %t1927, i8* %t1926
  %t1930 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1931 = icmp eq i32 %t1886, 14
  %t1932 = select i1 %t1931, i8* %t1930, i8* %t1929
  %t1933 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1934 = icmp eq i32 %t1886, 15
  %t1935 = select i1 %t1934, i8* %t1933, i8* %t1932
  %t1936 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1937 = icmp eq i32 %t1886, 16
  %t1938 = select i1 %t1937, i8* %t1936, i8* %t1935
  %s1939 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.1939, i32 0, i32 0
  %t1940 = icmp eq i8* %t1938, %s1939
  %t1941 = load %PythonBuilder, %PythonBuilder* %l0
  %t1942 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1943 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1944 = load i8, i8* %l3
  %t1945 = load double, double* %l4
  %t1946 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1947 = load double, double* %l6
  %t1948 = load double, double* %l7
  %t1949 = load %NativeInstruction*, %NativeInstruction** %l8
  br i1 %t1940, label %then106, label %else107
then106:
  %t1950 = load %PythonBuilder, %PythonBuilder* %l0
  %s1951 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.1951, i32 0, i32 0
  %t1952 = call %PythonBuilder @builder_emit(%PythonBuilder %t1950, i8* %s1951)
  store %PythonBuilder %t1952, %PythonBuilder* %l0
  br label %merge108
else107:
  %t1953 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1954 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1953, i32 0, i32 0
  %t1955 = load i32, i32* %t1954
  %t1956 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1953, i32 0, i32 1
  %t1957 = bitcast [8 x i8]* %t1956 to i8*
  %t1958 = bitcast i8* %t1957 to i8**
  %t1959 = load i8*, i8** %t1958
  %t1960 = icmp eq i32 %t1955, 16
  %t1961 = select i1 %t1960, i8* %t1959, i8* null
  %t1962 = call i8* @trim_text(i8* %t1961)
  store i8* %t1962, i8** %l36
  %s1963 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.1963, i32 0, i32 0
  store i8* %s1963, i8** %l37
  %t1964 = load i8*, i8** %l36
  %t1965 = call i64 @sailfin_runtime_string_length(i8* %t1964)
  %t1966 = icmp sgt i64 %t1965, 0
  %t1967 = load %PythonBuilder, %PythonBuilder* %l0
  %t1968 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1969 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1970 = load i8, i8* %l3
  %t1971 = load double, double* %l4
  %t1972 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1973 = load double, double* %l6
  %t1974 = load double, double* %l7
  %t1975 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1976 = load i8*, i8** %l36
  %t1977 = load i8*, i8** %l37
  br i1 %t1966, label %then109, label %merge110
then109:
  %t1978 = load i8*, i8** %l37
  %s1979 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.1979, i32 0, i32 0
  %t1980 = add i8* %t1978, %s1979
  %t1981 = load i8*, i8** %l36
  %t1982 = add i8* %t1980, %t1981
  store i8* %t1982, i8** %l37
  br label %merge110
merge110:
  %t1983 = phi i8* [ %t1982, %then109 ], [ %t1977, %else107 ]
  store i8* %t1983, i8** %l37
  %t1984 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1985 = extractvalue %NativeFunction %function, 0
  %t1986 = load i8*, i8** %l37
  %t1987 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t1984, i8* %t1985, i8* %t1986)
  store { i8**, i64 }* %t1987, { i8**, i64 }** %l1
  %t1988 = load %PythonBuilder, %PythonBuilder* %l0
  %s1989 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.1989, i32 0, i32 0
  %t1990 = load %NativeInstruction*, %NativeInstruction** %l8
  %t1991 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1990, i32 0, i32 0
  %t1992 = load i32, i32* %t1991
  %t1993 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1990, i32 0, i32 1
  %t1994 = bitcast [8 x i8]* %t1993 to i8*
  %t1995 = bitcast i8* %t1994 to i8**
  %t1996 = load i8*, i8** %t1995
  %t1997 = icmp eq i32 %t1992, 16
  %t1998 = select i1 %t1997, i8* %t1996, i8* null
  %t1999 = add i8* %s1989, %t1998
  %t2000 = call %PythonBuilder @builder_emit(%PythonBuilder %t1988, i8* %t1999)
  store %PythonBuilder %t2000, %PythonBuilder* %l0
  br label %merge108
merge108:
  %t2001 = phi %PythonBuilder [ %t1952, %then106 ], [ %t2000, %else107 ]
  %t2002 = phi { i8**, i64 }* [ %t1942, %then106 ], [ %t1987, %else107 ]
  store %PythonBuilder %t2001, %PythonBuilder* %l0
  store { i8**, i64 }* %t2002, { i8**, i64 }** %l1
  br label %merge100
merge100:
  %t2003 = phi { i8**, i64 }* [ %t1845, %then98 ], [ %t1987, %else99 ]
  %t2004 = phi %PythonBuilder [ %t1848, %then98 ], [ %t1952, %else99 ]
  %t2005 = phi { %MatchContext*, i64 }* [ %t1880, %then98 ], [ %t1825, %else99 ]
  store { i8**, i64 }* %t2003, { i8**, i64 }** %l1
  store %PythonBuilder %t2004, %PythonBuilder* %l0
  store { %MatchContext*, i64 }* %t2005, { %MatchContext*, i64 }** %l5
  br label %merge84
merge84:
  %t2006 = phi { i8**, i64 }* [ %t1633, %then82 ], [ %t1845, %else83 ]
  %t2007 = phi %PythonBuilder [ %t1636, %then82 ], [ %t1848, %else83 ]
  %t2008 = phi { %MatchContext*, i64 }* [ %t1759, %then82 ], [ %t1880, %else83 ]
  store { i8**, i64 }* %t2006, { i8**, i64 }** %l1
  store %PythonBuilder %t2007, %PythonBuilder* %l0
  store { %MatchContext*, i64 }* %t2008, { %MatchContext*, i64 }** %l5
  br label %merge81
merge81:
  %t2009 = phi double [ %t1475, %then79 ], [ %t1468, %else80 ]
  %t2010 = phi %PythonBuilder [ %t1504, %then79 ], [ %t1636, %else80 ]
  %t2011 = phi { %MatchContext*, i64 }* [ %t1512, %then79 ], [ %t1759, %else80 ]
  %t2012 = phi { i8**, i64 }* [ %t1463, %then79 ], [ %t1633, %else80 ]
  store double %t2009, double* %l6
  store %PythonBuilder %t2010, %PythonBuilder* %l0
  store { %MatchContext*, i64 }* %t2011, { %MatchContext*, i64 }** %l5
  store { i8**, i64 }* %t2012, { i8**, i64 }** %l1
  br label %merge78
merge78:
  %t2013 = phi %PythonBuilder [ %t1404, %then76 ], [ %t1504, %else77 ]
  %t2014 = phi double [ %t1399, %then76 ], [ %t1475, %else77 ]
  %t2015 = phi { %MatchContext*, i64 }* [ %t1398, %then76 ], [ %t1512, %else77 ]
  %t2016 = phi { i8**, i64 }* [ %t1394, %then76 ], [ %t1633, %else77 ]
  store %PythonBuilder %t2013, %PythonBuilder* %l0
  store double %t2014, double* %l6
  store { %MatchContext*, i64 }* %t2015, { %MatchContext*, i64 }** %l5
  store { i8**, i64 }* %t2016, { i8**, i64 }** %l1
  br label %merge75
merge75:
  %t2017 = phi %PythonBuilder [ %t1335, %then73 ], [ %t1404, %else74 ]
  %t2018 = phi double [ %t1330, %then73 ], [ %t1475, %else74 ]
  %t2019 = phi { %MatchContext*, i64 }* [ %t1329, %then73 ], [ %t1512, %else74 ]
  %t2020 = phi { i8**, i64 }* [ %t1325, %then73 ], [ %t1633, %else74 ]
  store %PythonBuilder %t2017, %PythonBuilder* %l0
  store double %t2018, double* %l6
  store { %MatchContext*, i64 }* %t2019, { %MatchContext*, i64 }** %l5
  store { i8**, i64 }* %t2020, { i8**, i64 }** %l1
  br label %merge69
merge69:
  %t2021 = phi %PythonBuilder [ %t1256, %then67 ], [ %t1335, %else68 ]
  %t2022 = phi double [ %t1259, %then67 ], [ %t1238, %else68 ]
  %t2023 = phi { i8**, i64 }* [ %t1263, %then67 ], [ %t1633, %else68 ]
  %t2024 = phi double [ %t1240, %then67 ], [ %t1475, %else68 ]
  %t2025 = phi { %MatchContext*, i64 }* [ %t1239, %then67 ], [ %t1512, %else68 ]
  store %PythonBuilder %t2021, %PythonBuilder* %l0
  store double %t2022, double* %l4
  store { i8**, i64 }* %t2023, { i8**, i64 }** %l1
  store double %t2024, double* %l6
  store { %MatchContext*, i64 }* %t2025, { %MatchContext*, i64 }** %l5
  br label %merge66
merge66:
  %t2026 = phi %PythonBuilder [ %t1171, %then64 ], [ %t1256, %else65 ]
  %t2027 = phi double [ %t1176, %then64 ], [ %t1259, %else65 ]
  %t2028 = phi { i8**, i64 }* [ %t1161, %then64 ], [ %t1263, %else65 ]
  %t2029 = phi double [ %t1166, %then64 ], [ %t1475, %else65 ]
  %t2030 = phi { %MatchContext*, i64 }* [ %t1165, %then64 ], [ %t1512, %else65 ]
  store %PythonBuilder %t2026, %PythonBuilder* %l0
  store double %t2027, double* %l4
  store { i8**, i64 }* %t2028, { i8**, i64 }** %l1
  store double %t2029, double* %l6
  store { %MatchContext*, i64 }* %t2030, { %MatchContext*, i64 }** %l5
  br label %merge60
merge60:
  %t2031 = phi %PythonBuilder [ %t1092, %then58 ], [ %t1171, %else59 ]
  %t2032 = phi double [ %t1095, %then58 ], [ %t1176, %else59 ]
  %t2033 = phi { i8**, i64 }* [ %t1099, %then58 ], [ %t1263, %else59 ]
  %t2034 = phi double [ %t1076, %then58 ], [ %t1475, %else59 ]
  %t2035 = phi { %MatchContext*, i64 }* [ %t1075, %then58 ], [ %t1512, %else59 ]
  store %PythonBuilder %t2031, %PythonBuilder* %l0
  store double %t2032, double* %l4
  store { i8**, i64 }* %t2033, { i8**, i64 }** %l1
  store double %t2034, double* %l6
  store { %MatchContext*, i64 }* %t2035, { %MatchContext*, i64 }** %l5
  br label %merge57
merge57:
  %t2036 = phi %PythonBuilder [ %t1007, %then55 ], [ %t1092, %else56 ]
  %t2037 = phi double [ %t1012, %then55 ], [ %t1095, %else56 ]
  %t2038 = phi { i8**, i64 }* [ %t964, %then55 ], [ %t1099, %else56 ]
  %t2039 = phi double [ %t969, %then55 ], [ %t1475, %else56 ]
  %t2040 = phi { %MatchContext*, i64 }* [ %t968, %then55 ], [ %t1512, %else56 ]
  store %PythonBuilder %t2036, %PythonBuilder* %l0
  store double %t2037, double* %l4
  store { i8**, i64 }* %t2038, { i8**, i64 }** %l1
  store double %t2039, double* %l6
  store { %MatchContext*, i64 }* %t2040, { %MatchContext*, i64 }** %l5
  br label %merge51
merge51:
  %t2041 = phi %PythonBuilder [ %t895, %then49 ], [ %t1007, %else50 ]
  %t2042 = phi double [ %t898, %then49 ], [ %t1012, %else50 ]
  %t2043 = phi { i8**, i64 }* [ %t902, %then49 ], [ %t1099, %else50 ]
  %t2044 = phi double [ %t879, %then49 ], [ %t1475, %else50 ]
  %t2045 = phi { %MatchContext*, i64 }* [ %t878, %then49 ], [ %t1512, %else50 ]
  store %PythonBuilder %t2041, %PythonBuilder* %l0
  store double %t2042, double* %l4
  store { i8**, i64 }* %t2043, { i8**, i64 }** %l1
  store double %t2044, double* %l6
  store { %MatchContext*, i64 }* %t2045, { %MatchContext*, i64 }** %l5
  br label %merge45
merge45:
  %t2046 = phi %PythonBuilder [ %t804, %then43 ], [ %t895, %else44 ]
  %t2047 = phi { i8**, i64 }* [ %t808, %then43 ], [ %t902, %else44 ]
  %t2048 = phi double [ %t786, %then43 ], [ %t898, %else44 ]
  %t2049 = phi double [ %t788, %then43 ], [ %t1475, %else44 ]
  %t2050 = phi { %MatchContext*, i64 }* [ %t787, %then43 ], [ %t1512, %else44 ]
  store %PythonBuilder %t2046, %PythonBuilder* %l0
  store { i8**, i64 }* %t2047, { i8**, i64 }** %l1
  store double %t2048, double* %l4
  store double %t2049, double* %l6
  store { %MatchContext*, i64 }* %t2050, { %MatchContext*, i64 }** %l5
  br label %merge42
merge42:
  %t2051 = phi %PythonBuilder [ %t719, %then40 ], [ %t804, %else41 ]
  %t2052 = phi double [ %t724, %then40 ], [ %t898, %else41 ]
  %t2053 = phi { i8**, i64 }* [ %t689, %then40 ], [ %t808, %else41 ]
  %t2054 = phi double [ %t694, %then40 ], [ %t1475, %else41 ]
  %t2055 = phi { %MatchContext*, i64 }* [ %t693, %then40 ], [ %t1512, %else41 ]
  store %PythonBuilder %t2051, %PythonBuilder* %l0
  store double %t2052, double* %l4
  store { i8**, i64 }* %t2053, { i8**, i64 }** %l1
  store double %t2054, double* %l6
  store { %MatchContext*, i64 }* %t2055, { %MatchContext*, i64 }** %l5
  br label %merge31
merge31:
  %t2056 = phi double [ %t622, %then29 ], [ %t509, %else30 ]
  %t2057 = phi %PythonBuilder [ %t630, %then29 ], [ %t719, %else30 ]
  %t2058 = phi double [ %t506, %then29 ], [ %t724, %else30 ]
  %t2059 = phi { i8**, i64 }* [ %t503, %then29 ], [ %t808, %else30 ]
  %t2060 = phi double [ %t508, %then29 ], [ %t1475, %else30 ]
  %t2061 = phi { %MatchContext*, i64 }* [ %t507, %then29 ], [ %t1512, %else30 ]
  store double %t2056, double* %l7
  store %PythonBuilder %t2057, %PythonBuilder* %l0
  store double %t2058, double* %l4
  store { i8**, i64 }* %t2059, { i8**, i64 }** %l1
  store double %t2060, double* %l6
  store { %MatchContext*, i64 }* %t2061, { %MatchContext*, i64 }** %l5
  br label %merge23
merge23:
  %t2062 = phi %PythonBuilder [ %t441, %then21 ], [ %t630, %else22 ]
  %t2063 = phi double [ %t444, %then21 ], [ %t622, %else22 ]
  %t2064 = phi double [ %t356, %then21 ], [ %t724, %else22 ]
  %t2065 = phi { i8**, i64 }* [ %t353, %then21 ], [ %t808, %else22 ]
  %t2066 = phi double [ %t358, %then21 ], [ %t1475, %else22 ]
  %t2067 = phi { %MatchContext*, i64 }* [ %t357, %then21 ], [ %t1512, %else22 ]
  store %PythonBuilder %t2062, %PythonBuilder* %l0
  store double %t2063, double* %l7
  store double %t2064, double* %l4
  store { i8**, i64 }* %t2065, { i8**, i64 }** %l1
  store double %t2066, double* %l6
  store { %MatchContext*, i64 }* %t2067, { %MatchContext*, i64 }** %l5
  br label %merge12
merge12:
  %t2068 = phi %PythonBuilder [ %t206, %then10 ], [ %t441, %else11 ]
  %t2069 = phi double [ %t292, %then10 ], [ %t444, %else11 ]
  %t2070 = phi double [ %t167, %then10 ], [ %t724, %else11 ]
  %t2071 = phi { i8**, i64 }* [ %t164, %then10 ], [ %t808, %else11 ]
  %t2072 = phi double [ %t169, %then10 ], [ %t1475, %else11 ]
  %t2073 = phi { %MatchContext*, i64 }* [ %t168, %then10 ], [ %t1512, %else11 ]
  store %PythonBuilder %t2068, %PythonBuilder* %l0
  store double %t2069, double* %l7
  store double %t2070, double* %l4
  store { i8**, i64 }* %t2071, { i8**, i64 }** %l1
  store double %t2072, double* %l6
  store { %MatchContext*, i64 }* %t2073, { %MatchContext*, i64 }** %l5
  %t2074 = load double, double* %l7
  %t2075 = sitofp i64 1 to double
  %t2076 = fadd double %t2074, %t2075
  store double %t2076, double* %l7
  br label %loop.latch6
loop.latch6:
  %t2077 = load %PythonBuilder, %PythonBuilder* %l0
  %t2078 = load double, double* %l7
  %t2079 = load double, double* %l4
  %t2080 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2081 = load double, double* %l6
  %t2082 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  br label %loop.header4
afterloop7:
  %t2089 = load %PythonBuilder, %PythonBuilder* %l0
  %t2090 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2091 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2092 = load i8, i8* %l3
  %t2093 = load double, double* %l4
  %t2094 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2095 = load double, double* %l6
  %t2096 = load double, double* %l7
  br label %loop.header111
loop.header111:
  %t2147 = phi %PythonBuilder [ %t2089, %entry ], [ %t2144, %loop.latch113 ]
  %t2148 = phi { i8**, i64 }* [ %t2090, %entry ], [ %t2145, %loop.latch113 ]
  %t2149 = phi { %MatchContext*, i64 }* [ %t2094, %entry ], [ %t2146, %loop.latch113 ]
  store %PythonBuilder %t2147, %PythonBuilder* %l0
  store { i8**, i64 }* %t2148, { i8**, i64 }** %l1
  store { %MatchContext*, i64 }* %t2149, { %MatchContext*, i64 }** %l5
  br label %loop.body112
loop.body112:
  %t2097 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2098 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t2097
  %t2099 = extractvalue { %MatchContext*, i64 } %t2098, 1
  %t2100 = icmp eq i64 %t2099, 0
  %t2101 = load %PythonBuilder, %PythonBuilder* %l0
  %t2102 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2103 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2104 = load i8, i8* %l3
  %t2105 = load double, double* %l4
  %t2106 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2107 = load double, double* %l6
  %t2108 = load double, double* %l7
  br i1 %t2100, label %then115, label %merge116
then115:
  br label %afterloop114
merge116:
  %t2109 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2110 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t2109
  %t2111 = extractvalue { %MatchContext*, i64 } %t2110, 1
  %t2112 = sub i64 %t2111, 1
  store i64 %t2112, i64* %l38
  %t2113 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2114 = load i64, i64* %l38
  %t2115 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t2113
  %t2116 = extractvalue { %MatchContext*, i64 } %t2115, 0
  %t2117 = extractvalue { %MatchContext*, i64 } %t2115, 1
  %t2118 = icmp uge i64 %t2114, %t2117
  ; bounds check: %t2118 (if true, out of bounds)
  %t2119 = getelementptr %MatchContext, %MatchContext* %t2116, i64 %t2114
  %t2120 = load %MatchContext, %MatchContext* %t2119
  store %MatchContext %t2120, %MatchContext* %l39
  %t2121 = load %MatchContext, %MatchContext* %l39
  %t2122 = extractvalue %MatchContext %t2121, 2
  %t2123 = load %PythonBuilder, %PythonBuilder* %l0
  %t2124 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2125 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2126 = load i8, i8* %l3
  %t2127 = load double, double* %l4
  %t2128 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2129 = load double, double* %l6
  %t2130 = load double, double* %l7
  %t2131 = load i64, i64* %l38
  %t2132 = load %MatchContext, %MatchContext* %l39
  br i1 %t2122, label %then117, label %merge118
then117:
  %t2133 = load %PythonBuilder, %PythonBuilder* %l0
  %t2134 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t2133)
  store %PythonBuilder %t2134, %PythonBuilder* %l0
  br label %merge118
merge118:
  %t2135 = phi %PythonBuilder [ %t2134, %then117 ], [ %t2123, %loop.body112 ]
  store %PythonBuilder %t2135, %PythonBuilder* %l0
  %t2136 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2137 = extractvalue %NativeFunction %function, 0
  %s2138 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.2138, i32 0, i32 0
  %t2139 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t2136, i8* %t2137, i8* %s2138)
  store { i8**, i64 }* %t2139, { i8**, i64 }** %l1
  %t2140 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2141 = load i64, i64* %l38
  %t2142 = sitofp i64 %t2141 to double
  %t2143 = call { %MatchContext*, i64 }* @truncate_match_contexts({ %MatchContext*, i64 }* %t2140, double %t2142)
  store { %MatchContext*, i64 }* %t2143, { %MatchContext*, i64 }** %l5
  br label %loop.latch113
loop.latch113:
  %t2144 = load %PythonBuilder, %PythonBuilder* %l0
  %t2145 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2146 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  br label %loop.header111
afterloop114:
  %t2150 = load %PythonBuilder, %PythonBuilder* %l0
  %t2151 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2152 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2153 = load i8, i8* %l3
  %t2154 = load double, double* %l4
  %t2155 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2156 = load double, double* %l6
  %t2157 = load double, double* %l7
  br label %loop.header119
loop.header119:
  %t2181 = phi %PythonBuilder [ %t2150, %entry ], [ %t2178, %loop.latch121 ]
  %t2182 = phi double [ %t2154, %entry ], [ %t2179, %loop.latch121 ]
  %t2183 = phi { i8**, i64 }* [ %t2151, %entry ], [ %t2180, %loop.latch121 ]
  store %PythonBuilder %t2181, %PythonBuilder* %l0
  store double %t2182, double* %l4
  store { i8**, i64 }* %t2183, { i8**, i64 }** %l1
  br label %loop.body120
loop.body120:
  %t2158 = load double, double* %l4
  %t2159 = sitofp i64 0 to double
  %t2160 = fcmp ole double %t2158, %t2159
  %t2161 = load %PythonBuilder, %PythonBuilder* %l0
  %t2162 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2163 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2164 = load i8, i8* %l3
  %t2165 = load double, double* %l4
  %t2166 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2167 = load double, double* %l6
  %t2168 = load double, double* %l7
  br i1 %t2160, label %then123, label %merge124
then123:
  br label %afterloop122
merge124:
  %t2169 = load %PythonBuilder, %PythonBuilder* %l0
  %t2170 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t2169)
  store %PythonBuilder %t2170, %PythonBuilder* %l0
  %t2171 = load double, double* %l4
  %t2172 = sitofp i64 1 to double
  %t2173 = fsub double %t2171, %t2172
  store double %t2173, double* %l4
  %t2174 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2175 = extractvalue %NativeFunction %function, 0
  %s2176 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.2176, i32 0, i32 0
  %t2177 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t2174, i8* %t2175, i8* %s2176)
  store { i8**, i64 }* %t2177, { i8**, i64 }** %l1
  br label %loop.latch121
loop.latch121:
  %t2178 = load %PythonBuilder, %PythonBuilder* %l0
  %t2179 = load double, double* %l4
  %t2180 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %loop.header119
afterloop122:
  %t2184 = load %PythonBuilder, %PythonBuilder* %l0
  %t2185 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t2184)
  store %PythonBuilder %t2185, %PythonBuilder* %l0
  %t2186 = load %PythonBuilder, %PythonBuilder* %l0
  %t2187 = insertvalue %PythonFunctionEmission undef, %PythonBuilder* null, 0
  %t2188 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2189 = insertvalue %PythonFunctionEmission %t2187, { i8**, i64 }* %t2188, 1
  ret %PythonFunctionEmission %t2189
}

define { %MatchContext*, i64 }* @append_match_context({ %MatchContext*, i64 }* %values, %MatchContext %value) {
entry:
  %t0 = alloca [1 x %MatchContext]
  %t1 = getelementptr [1 x %MatchContext], [1 x %MatchContext]* %t0, i32 0, i32 0
  %t2 = getelementptr %MatchContext, %MatchContext* %t1, i64 0
  store %MatchContext %value, %MatchContext* %t2
  %t3 = alloca { %MatchContext*, i64 }
  %t4 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t3, i32 0, i32 0
  store %MatchContext* %t1, %MatchContext** %t4
  %t5 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = bitcast { %MatchContext*, i64 }* %values to { i8**, i64 }*
  %t7 = bitcast { %MatchContext*, i64 }* %t3 to { i8**, i64 }*
  %t8 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t6, { i8**, i64 }* %t7)
  %t9 = bitcast { i8**, i64 }* %t8 to { %MatchContext*, i64 }*
  ret { %MatchContext*, i64 }* %t9
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
  %s0 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.0, i32 0, i32 0
  %t1 = call i8* @number_to_string(double %counter)
  %t2 = add i8* %s0, %t1
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
  %t19 = getelementptr i8, i8* %t18, i64 0
  %t20 = load i8, i8* %t19
  %t21 = icmp eq i8 %t20, 95
  br label %logical_or_right_end_14

logical_or_right_end_14:
  br label %logical_or_merge_14

logical_or_merge_14:
  %t22 = phi i1 [ true, %logical_or_entry_14 ], [ %t21, %logical_or_right_end_14 ]
  %t23 = load i8*, i8** %l0
  %t24 = load i8*, i8** %l1
  br i1 %t22, label %then4, label %merge5
then4:
  %t25 = load i8*, i8** %l1
  %t26 = icmp eq i8* %t25, null
  %t27 = load i8*, i8** %l0
  %t28 = load i8*, i8** %l1
  br i1 %t26, label %then6, label %merge7
then6:
  %s29 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.29, i32 0, i32 0
  %t30 = insertvalue %LoweredCaseCondition undef, i8* %s29, 0
  %t31 = insertvalue %LoweredCaseCondition %t30, i1 1, 1
  %t32 = insertvalue %LoweredCaseCondition %t31, i1 0, 2
  ret %LoweredCaseCondition %t32
merge7:
  %t33 = load i8*, i8** %l1
  %t34 = call i8* @lower_expression(i8* %t33)
  store i8* %t34, i8** %l3
  %t35 = load i8*, i8** %l3
  %t36 = insertvalue %LoweredCaseCondition undef, i8* %t35, 0
  %t37 = insertvalue %LoweredCaseCondition %t36, i1 0, 1
  %t38 = insertvalue %LoweredCaseCondition %t37, i1 1, 2
  ret %LoweredCaseCondition %t38
merge5:
  %t39 = load i8*, i8** %l0
  %t40 = call i8* @lower_expression(i8* %t39)
  store i8* %t40, i8** %l4
  %s41 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.41, i32 0, i32 0
  %t42 = add i8* %subject_name, %s41
  %t43 = load i8*, i8** %l4
  %t44 = add i8* %t42, %t43
  store i8* %t44, i8** %l5
  store i1 0, i1* %l6
  %t45 = load i8*, i8** %l1
  %t46 = icmp ne i8* %t45, null
  %t47 = load i8*, i8** %l0
  %t48 = load i8*, i8** %l1
  %t49 = load i8*, i8** %l4
  %t50 = load i8*, i8** %l5
  %t51 = load i1, i1* %l6
  br i1 %t46, label %then8, label %merge9
then8:
  %t52 = load i8*, i8** %l1
  %t53 = call i8* @lower_expression(i8* %t52)
  store i8* %t53, i8** %l7
  %t54 = load i8*, i8** %l5
  %t55 = getelementptr i8, i8* %t54, i64 0
  %t56 = load i8, i8* %t55
  %t57 = add i8 40, %t56
  %s58 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.58, i32 0, i32 0
  %t59 = getelementptr i8, i8* %s58, i64 0
  %t60 = load i8, i8* %t59
  %t61 = add i8 %t57, %t60
  %t62 = load i8*, i8** %l7
  %t63 = getelementptr i8, i8* %t62, i64 0
  %t64 = load i8, i8* %t63
  %t65 = add i8 %t61, %t64
  %t66 = add i8 %t65, 41
  %t67 = alloca [2 x i8], align 1
  %t68 = getelementptr [2 x i8], [2 x i8]* %t67, i32 0, i32 0
  store i8 %t66, i8* %t68
  %t69 = getelementptr [2 x i8], [2 x i8]* %t67, i32 0, i32 1
  store i8 0, i8* %t69
  %t70 = getelementptr [2 x i8], [2 x i8]* %t67, i32 0, i32 0
  store i8* %t70, i8** %l5
  store i1 1, i1* %l6
  br label %merge9
merge9:
  %t71 = phi i8* [ %t70, %then8 ], [ %t50, %entry ]
  %t72 = phi i1 [ 1, %then8 ], [ %t51, %entry ]
  store i8* %t71, i8** %l5
  store i1 %t72, i1* %l6
  %t73 = load i8*, i8** %l5
  %t74 = insertvalue %LoweredCaseCondition undef, i8* %t73, 0
  %t75 = insertvalue %LoweredCaseCondition %t74, i1 0, 1
  %t76 = load i1, i1* %l6
  %t77 = insertvalue %LoweredCaseCondition %t75, i1 %t76, 2
  ret %LoweredCaseCondition %t77
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
  %s6 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.6, i32 0, i32 0
  store i8* %s6, i8** %l0
  store double %value, double* %l1
  %s7 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.7, i32 0, i32 0
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
  %t53 = add i8* %t51, %t52
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
  %s41 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.41, i32 0, i32 0
  %t42 = add i8* %t40, %s41
  %t43 = load %NativeParameter, %NativeParameter* %l2
  %t44 = extractvalue %NativeParameter %t43, 3
  %t45 = add i8* %t42, %t44
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
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.3, i32 0, i32 0
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
  %s13 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.13, i32 0, i32 0
  %t14 = add i8* %t12, %s13
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
  %t23 = add i8* %t22, %line
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
  %s1 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.1, i32 0, i32 0
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
  ret %PythonBuilder zeroinitializer
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
  %s10 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.10, i32 0, i32 0
  ret i8* %s10
merge1:
  %t11 = load i8*, i8** %l0
  %t12 = getelementptr i8, i8* %t11, i64 0
  %t13 = load i8, i8* %t12
  %t14 = add i8 %t13, 10
  %t15 = alloca [2 x i8], align 1
  %t16 = getelementptr [2 x i8], [2 x i8]* %t15, i32 0, i32 0
  store i8 %t14, i8* %t16
  %t17 = getelementptr [2 x i8], [2 x i8]* %t15, i32 0, i32 1
  store i8 0, i8* %t17
  %t18 = getelementptr [2 x i8], [2 x i8]* %t15, i32 0, i32 0
  ret i8* %t18
}

define i8* @sanitize_identifier(i8* %name) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = load i8*, i8** %l0
  %t3 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t52 = phi i8* [ %t2, %entry ], [ %t50, %loop.latch2 ]
  %t53 = phi double [ %t3, %entry ], [ %t51, %loop.latch2 ]
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
  %t25 = getelementptr i8, i8* %t23, i64 0
  %t26 = load i8, i8* %t25
  %t27 = add i8 %t26, %t24
  %t28 = alloca [2 x i8], align 1
  %t29 = getelementptr [2 x i8], [2 x i8]* %t28, i32 0, i32 0
  store i8 %t27, i8* %t29
  %t30 = getelementptr [2 x i8], [2 x i8]* %t28, i32 0, i32 1
  store i8 0, i8* %t30
  %t31 = getelementptr [2 x i8], [2 x i8]* %t28, i32 0, i32 0
  store i8* %t31, i8** %l0
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
  %t38 = getelementptr i8, i8* %t37, i64 0
  %t39 = load i8, i8* %t38
  %t40 = add i8 %t39, 95
  %t41 = alloca [2 x i8], align 1
  %t42 = getelementptr [2 x i8], [2 x i8]* %t41, i32 0, i32 0
  store i8 %t40, i8* %t42
  %t43 = getelementptr [2 x i8], [2 x i8]* %t41, i32 0, i32 1
  store i8 0, i8* %t43
  %t44 = getelementptr [2 x i8], [2 x i8]* %t41, i32 0, i32 0
  store i8* %t44, i8** %l0
  br label %merge10
merge10:
  %t45 = phi i8* [ %t44, %then9 ], [ %t34, %else7 ]
  store i8* %t45, i8** %l0
  br label %merge8
merge8:
  %t46 = phi i8* [ %t31, %then6 ], [ %t44, %else7 ]
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
  %t55 = call i64 @sailfin_runtime_string_length(i8* %t54)
  %t56 = icmp eq i64 %t55, 0
  %t57 = load i8*, i8** %l0
  %t58 = load double, double* %l1
  br i1 %t56, label %then11, label %merge12
then11:
  %s59 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.59, i32 0, i32 0
  ret i8* %s59
merge12:
  %t60 = load i8*, i8** %l0
  ret i8* %t60
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
  %s7 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.7, i32 0, i32 0
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
  %t71 = phi { i8**, i64 }* [ %t16, %entry ], [ %t68, %loop.latch4 ]
  %t72 = phi i8* [ %t15, %entry ], [ %t69, %loop.latch4 ]
  %t73 = phi double [ %t17, %entry ], [ %t70, %loop.latch4 ]
  store { i8**, i64 }* %t71, { i8**, i64 }** %l2
  store i8* %t72, i8** %l1
  store double %t73, double* %l3
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
  %s51 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.51, i32 0, i32 0
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
  %t56 = getelementptr i8, i8* %t54, i64 0
  %t57 = load i8, i8* %t56
  %t58 = add i8 %t57, %t55
  %t59 = alloca [2 x i8], align 1
  %t60 = getelementptr [2 x i8], [2 x i8]* %t59, i32 0, i32 0
  store i8 %t58, i8* %t60
  %t61 = getelementptr [2 x i8], [2 x i8]* %t59, i32 0, i32 1
  store i8 0, i8* %t61
  %t62 = getelementptr [2 x i8], [2 x i8]* %t59, i32 0, i32 0
  store i8* %t62, i8** %l1
  br label %merge10
merge10:
  %t63 = phi { i8**, i64 }* [ %t50, %then8 ], [ %t36, %else9 ]
  %t64 = phi i8* [ %s51, %then8 ], [ %t62, %else9 ]
  store { i8**, i64 }* %t63, { i8**, i64 }** %l2
  store i8* %t64, i8** %l1
  %t65 = load double, double* %l3
  %t66 = sitofp i64 1 to double
  %t67 = fadd double %t65, %t66
  store double %t67, double* %l3
  br label %loop.latch4
loop.latch4:
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t69 = load i8*, i8** %l1
  %t70 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t74 = load i8*, i8** %l1
  %t75 = call i64 @sailfin_runtime_string_length(i8* %t74)
  %t76 = icmp sgt i64 %t75, 0
  %t77 = load i8*, i8** %l0
  %t78 = load i8*, i8** %l1
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t80 = load double, double* %l3
  br i1 %t76, label %then13, label %merge14
then13:
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t82 = load i8*, i8** %l1
  %t83 = call i8* @sanitize_identifier(i8* %t82)
  %t84 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t81, i8* %t83)
  store { i8**, i64 }* %t84, { i8**, i64 }** %l2
  br label %merge14
merge14:
  %t85 = phi { i8**, i64 }* [ %t84, %then13 ], [ %t79, %entry ]
  store { i8**, i64 }* %t85, { i8**, i64 }** %l2
  %t86 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t87 = load { i8**, i64 }, { i8**, i64 }* %t86
  %t88 = extractvalue { i8**, i64 } %t87, 1
  %t89 = icmp eq i64 %t88, 0
  %t90 = load i8*, i8** %l0
  %t91 = load i8*, i8** %l1
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t93 = load double, double* %l3
  br i1 %t89, label %then15, label %merge16
then15:
  %t94 = load i8*, i8** %l0
  %t95 = call i8* @sanitize_identifier(i8* %t94)
  ret i8* %t95
merge16:
  %t96 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t97 = alloca [2 x i8], align 1
  %t98 = getelementptr [2 x i8], [2 x i8]* %t97, i32 0, i32 0
  store i8 46, i8* %t98
  %t99 = getelementptr [2 x i8], [2 x i8]* %t97, i32 0, i32 1
  store i8 0, i8* %t99
  %t100 = getelementptr [2 x i8], [2 x i8]* %t97, i32 0, i32 0
  %t101 = call i8* @join_with_separator({ i8**, i64 }* %t96, i8* %t100)
  ret i8* %t101
}

define i1 @is_identifier_char(i8* %ch) {
entry:
  %l0 = alloca double
  %t0 = getelementptr i8, i8* %ch, i64 0
  %t1 = load i8, i8* %t0
  %t2 = icmp eq i8 %t1, 95
  br i1 %t2, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %t3 = call double @char_code(i8* %ch)
  store double %t3, double* %l0
  %t5 = load double, double* %l0
  %t6 = call double @char_code(i8 97)
  %t7 = fcmp oge double %t5, %t6
  br label %logical_and_entry_4

logical_and_entry_4:
  br i1 %t7, label %logical_and_right_4, label %logical_and_merge_4

logical_and_right_4:
  %t8 = load double, double* %l0
  %t9 = call double @char_code(i8 122)
  %t10 = fcmp ole double %t8, %t9
  br label %logical_and_right_end_4

logical_and_right_end_4:
  br label %logical_and_merge_4

logical_and_merge_4:
  %t11 = phi i1 [ false, %logical_and_entry_4 ], [ %t10, %logical_and_right_end_4 ]
  %t12 = load double, double* %l0
  br i1 %t11, label %then2, label %merge3
then2:
  ret i1 1
merge3:
  %t14 = load double, double* %l0
  %t15 = call double @char_code(i8 65)
  %t16 = fcmp oge double %t14, %t15
  br label %logical_and_entry_13

logical_and_entry_13:
  br i1 %t16, label %logical_and_right_13, label %logical_and_merge_13

logical_and_right_13:
  %t17 = load double, double* %l0
  %t18 = call double @char_code(i8 90)
  %t19 = fcmp ole double %t17, %t18
  br label %logical_and_right_end_13

logical_and_right_end_13:
  br label %logical_and_merge_13

logical_and_merge_13:
  %t20 = phi i1 [ false, %logical_and_entry_13 ], [ %t19, %logical_and_right_end_13 ]
  %t21 = load double, double* %l0
  br i1 %t20, label %then4, label %merge5
then4:
  ret i1 1
merge5:
  %t23 = load double, double* %l0
  %t24 = call double @char_code(i8 48)
  %t25 = fcmp oge double %t23, %t24
  br label %logical_and_entry_22

logical_and_entry_22:
  br i1 %t25, label %logical_and_right_22, label %logical_and_merge_22

logical_and_right_22:
  %t26 = load double, double* %l0
  %t27 = call double @char_code(i8 57)
  %t28 = fcmp ole double %t26, %t27
  br label %logical_and_right_end_22

logical_and_right_end_22:
  br label %logical_and_merge_22

logical_and_merge_22:
  %t29 = phi i1 [ false, %logical_and_entry_22 ], [ %t28, %logical_and_right_end_22 ]
  %t30 = load double, double* %l0
  br i1 %t29, label %then6, label %merge7
then6:
  ret i1 1
merge7:
  ret i1 0
}

define i1 @is_whitespace_char(i8* %ch) {
entry:
  %t0 = getelementptr i8, i8* %ch, i64 0
  %t1 = load i8, i8* %t0
  %t2 = icmp eq i8 %t1, 32
  br i1 %t2, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %t3 = getelementptr i8, i8* %ch, i64 0
  %t4 = load i8, i8* %t3
  %t5 = icmp eq i8 %t4, 10
  br i1 %t5, label %then2, label %merge3
then2:
  ret i1 1
merge3:
  %t6 = getelementptr i8, i8* %ch, i64 0
  %t7 = load i8, i8* %t6
  %t8 = icmp eq i8 %t7, 13
  br i1 %t8, label %then4, label %merge5
then4:
  ret i1 1
merge5:
  %t9 = getelementptr i8, i8* %ch, i64 0
  %t10 = load i8, i8* %t9
  %t11 = icmp eq i8 %t10, 9
  br i1 %t11, label %then6, label %merge7
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
  %t46 = phi double [ %t3, %entry ], [ %t45, %loop.latch2 ]
  store double %t46, double* %l0
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
  %t19 = getelementptr i8, i8* %t18, i64 0
  %t20 = load i8, i8* %t19
  %t21 = icmp eq i8 %t20, 32
  br label %logical_or_entry_17

logical_or_entry_17:
  br i1 %t21, label %logical_or_merge_17, label %logical_or_right_17

logical_or_right_17:
  %t23 = load i8*, i8** %l2
  %t24 = getelementptr i8, i8* %t23, i64 0
  %t25 = load i8, i8* %t24
  %t26 = icmp eq i8 %t25, 10
  br label %logical_or_entry_22

logical_or_entry_22:
  br i1 %t26, label %logical_or_merge_22, label %logical_or_right_22

logical_or_right_22:
  %t28 = load i8*, i8** %l2
  %t29 = getelementptr i8, i8* %t28, i64 0
  %t30 = load i8, i8* %t29
  %t31 = icmp eq i8 %t30, 13
  br label %logical_or_entry_27

logical_or_entry_27:
  br i1 %t31, label %logical_or_merge_27, label %logical_or_right_27

logical_or_right_27:
  %t32 = load i8*, i8** %l2
  %t33 = getelementptr i8, i8* %t32, i64 0
  %t34 = load i8, i8* %t33
  %t35 = icmp eq i8 %t34, 9
  br label %logical_or_right_end_27

logical_or_right_end_27:
  br label %logical_or_merge_27

logical_or_merge_27:
  %t36 = phi i1 [ true, %logical_or_entry_27 ], [ %t35, %logical_or_right_end_27 ]
  br label %logical_or_right_end_22

logical_or_right_end_22:
  br label %logical_or_merge_22

logical_or_merge_22:
  %t37 = phi i1 [ true, %logical_or_entry_22 ], [ %t36, %logical_or_right_end_22 ]
  br label %logical_or_right_end_17

logical_or_right_end_17:
  br label %logical_or_merge_17

logical_or_merge_17:
  %t38 = phi i1 [ true, %logical_or_entry_17 ], [ %t37, %logical_or_right_end_17 ]
  %t39 = load double, double* %l0
  %t40 = load double, double* %l1
  %t41 = load i8*, i8** %l2
  br i1 %t38, label %then6, label %merge7
then6:
  %t42 = load double, double* %l0
  %t43 = sitofp i64 1 to double
  %t44 = fadd double %t42, %t43
  store double %t44, double* %l0
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  %t45 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t47 = load double, double* %l0
  %t48 = load double, double* %l1
  br label %loop.header8
loop.header8:
  %t94 = phi double [ %t48, %entry ], [ %t93, %loop.latch10 ]
  store double %t94, double* %l1
  br label %loop.body9
loop.body9:
  %t49 = load double, double* %l1
  %t50 = load double, double* %l0
  %t51 = fcmp ole double %t49, %t50
  %t52 = load double, double* %l0
  %t53 = load double, double* %l1
  br i1 %t51, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t54 = load double, double* %l1
  %t55 = sitofp i64 1 to double
  %t56 = fsub double %t54, %t55
  store double %t56, double* %l3
  %t57 = load double, double* %l3
  %t58 = load double, double* %l3
  %t59 = sitofp i64 1 to double
  %t60 = fadd double %t58, %t59
  %t61 = fptosi double %t57 to i64
  %t62 = fptosi double %t60 to i64
  %t63 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t61, i64 %t62)
  store i8* %t63, i8** %l4
  %t65 = load i8*, i8** %l4
  %t66 = getelementptr i8, i8* %t65, i64 0
  %t67 = load i8, i8* %t66
  %t68 = icmp eq i8 %t67, 32
  br label %logical_or_entry_64

logical_or_entry_64:
  br i1 %t68, label %logical_or_merge_64, label %logical_or_right_64

logical_or_right_64:
  %t70 = load i8*, i8** %l4
  %t71 = getelementptr i8, i8* %t70, i64 0
  %t72 = load i8, i8* %t71
  %t73 = icmp eq i8 %t72, 10
  br label %logical_or_entry_69

logical_or_entry_69:
  br i1 %t73, label %logical_or_merge_69, label %logical_or_right_69

logical_or_right_69:
  %t75 = load i8*, i8** %l4
  %t76 = getelementptr i8, i8* %t75, i64 0
  %t77 = load i8, i8* %t76
  %t78 = icmp eq i8 %t77, 13
  br label %logical_or_entry_74

logical_or_entry_74:
  br i1 %t78, label %logical_or_merge_74, label %logical_or_right_74

logical_or_right_74:
  %t79 = load i8*, i8** %l4
  %t80 = getelementptr i8, i8* %t79, i64 0
  %t81 = load i8, i8* %t80
  %t82 = icmp eq i8 %t81, 9
  br label %logical_or_right_end_74

logical_or_right_end_74:
  br label %logical_or_merge_74

logical_or_merge_74:
  %t83 = phi i1 [ true, %logical_or_entry_74 ], [ %t82, %logical_or_right_end_74 ]
  br label %logical_or_right_end_69

logical_or_right_end_69:
  br label %logical_or_merge_69

logical_or_merge_69:
  %t84 = phi i1 [ true, %logical_or_entry_69 ], [ %t83, %logical_or_right_end_69 ]
  br label %logical_or_right_end_64

logical_or_right_end_64:
  br label %logical_or_merge_64

logical_or_merge_64:
  %t85 = phi i1 [ true, %logical_or_entry_64 ], [ %t84, %logical_or_right_end_64 ]
  %t86 = load double, double* %l0
  %t87 = load double, double* %l1
  %t88 = load double, double* %l3
  %t89 = load i8*, i8** %l4
  br i1 %t85, label %then14, label %merge15
then14:
  %t90 = load double, double* %l1
  %t91 = sitofp i64 1 to double
  %t92 = fsub double %t90, %t91
  store double %t92, double* %l1
  br label %loop.latch10
merge15:
  br label %afterloop11
loop.latch10:
  %t93 = load double, double* %l1
  br label %loop.header8
afterloop11:
  %t96 = load double, double* %l0
  %t97 = sitofp i64 0 to double
  %t98 = fcmp oeq double %t96, %t97
  br label %logical_and_entry_95

logical_and_entry_95:
  br i1 %t98, label %logical_and_right_95, label %logical_and_merge_95

logical_and_right_95:
  %t99 = load double, double* %l1
  %t100 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t101 = sitofp i64 %t100 to double
  %t102 = fcmp oeq double %t99, %t101
  br label %logical_and_right_end_95

logical_and_right_end_95:
  br label %logical_and_merge_95

logical_and_merge_95:
  %t103 = phi i1 [ false, %logical_and_entry_95 ], [ %t102, %logical_and_right_end_95 ]
  %t104 = load double, double* %l0
  %t105 = load double, double* %l1
  br i1 %t103, label %then16, label %merge17
then16:
  ret i8* %value
merge17:
  %t106 = load double, double* %l0
  %t107 = load double, double* %l1
  %t108 = fptosi double %t106 to i64
  %t109 = fptosi double %t107 to i64
  %t110 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t108, i64 %t109)
  ret i8* %t110
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
  %t16 = phi double [ %t6, %entry ], [ %t15, %loop.latch6 ]
  store double %t16, double* %l0
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
  %t12 = load double, double* %l0
  %t13 = sitofp i64 1 to double
  %t14 = fadd double %t12, %t13
  store double %t14, double* %l0
  br label %loop.latch6
loop.latch6:
  %t15 = load double, double* %l0
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
  %s2 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.2, i32 0, i32 0
  store i8* %s2, i8** %l0
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l1
  %t4 = load i8*, i8** %l0
  %t5 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t61 = phi i8* [ %t4, %entry ], [ %t59, %loop.latch4 ]
  %t62 = phi double [ %t5, %entry ], [ %t60, %loop.latch4 ]
  store i8* %t61, i8** %l0
  store double %t62, double* %l1
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
  %t38 = phi double [ %t25, %then8 ], [ %t37, %loop.latch12 ]
  store double %t38, double* %l3
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
  %t34 = load double, double* %l3
  %t35 = sitofp i64 1 to double
  %t36 = fadd double %t34, %t35
  store double %t36, double* %l3
  br label %loop.latch12
loop.latch12:
  %t37 = load double, double* %l3
  br label %loop.header10
afterloop13:
  %t39 = load i1, i1* %l2
  %t40 = load i8*, i8** %l0
  %t41 = load double, double* %l1
  %t42 = load i1, i1* %l2
  %t43 = load double, double* %l3
  br i1 %t39, label %then16, label %merge17
then16:
  %t44 = load i8*, i8** %l0
  %t45 = add i8* %t44, %replacement
  store i8* %t45, i8** %l0
  %t46 = load double, double* %l1
  %t47 = call i64 @sailfin_runtime_string_length(i8* %target)
  %t48 = sitofp i64 %t47 to double
  %t49 = fadd double %t46, %t48
  store double %t49, double* %l1
  br label %loop.latch4
merge17:
  br label %merge9
merge9:
  %t50 = phi i8* [ %t45, %then8 ], [ %t19, %loop.body3 ]
  %t51 = phi double [ %t49, %then8 ], [ %t20, %loop.body3 ]
  store i8* %t50, i8** %l0
  store double %t51, double* %l1
  %t52 = load i8*, i8** %l0
  %t53 = load double, double* %l1
  %t54 = call i8* @char_at(i8* %value, double %t53)
  %t55 = add i8* %t52, %t54
  store i8* %t55, i8** %l0
  %t56 = load double, double* %l1
  %t57 = sitofp i64 1 to double
  %t58 = fadd double %t56, %t57
  store double %t58, double* %l1
  br label %loop.latch4
loop.latch4:
  %t59 = load i8*, i8** %l0
  %t60 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t63 = load i8*, i8** %l0
  ret i8* %t63
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
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.3, i32 0, i32 0
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
  %t21 = add i8* %t20, %separator
  %t22 = load double, double* %l1
  %t23 = fptosi double %t22 to i64
  %t24 = load { i8**, i64 }, { i8**, i64 }* %values
  %t25 = extractvalue { i8**, i64 } %t24, 0
  %t26 = extractvalue { i8**, i64 } %t24, 1
  %t27 = icmp uge i64 %t23, %t26
  ; bounds check: %t27 (if true, out of bounds)
  %t28 = getelementptr i8*, i8** %t25, i64 %t23
  %t29 = load i8*, i8** %t28
  %t30 = add i8* %t21, %t29
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
  %s1 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.1, i32 0, i32 0
  store i8* %s1, i8** %l1
  %t2 = load i8*, i8** %l0
  %t3 = call i64 @sailfin_runtime_string_length(i8* %t2)
  %t4 = icmp eq i64 %t3, 0
  %t5 = load i8*, i8** %l0
  %t6 = load i8*, i8** %l1
  br i1 %t4, label %then0, label %else1
then0:
  %t7 = load i8*, i8** %l1
  %t8 = add i8* %t7, %detail
  store i8* %t8, i8** %l1
  br label %merge2
else1:
  %t9 = load i8*, i8** %l1
  %t10 = load i8*, i8** %l0
  %t11 = add i8* %t9, %t10
  %s12 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.12, i32 0, i32 0
  %t13 = add i8* %t11, %s12
  %t14 = add i8* %t13, %detail
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
