; ModuleID = 'sailfin'
source_filename = "sailfin"

%LoweredPythonResult = type { i8*, { i8**, i64 }* }
%MatchContext = type { i8*, double, i1 }
%LoweredCaseCondition = type { i8*, i1, i1 }
%PythonModuleEmission = type { i8*, { i8**, i64 }* }
%PythonFunctionEmission = type { i8*, { i8**, i64 }* }
%PythonImportEmission = type { i8*, { i8**, i64 }* }
%PythonStructEmission = type { i8*, { i8**, i64 }* }
%StructLiteralCapture = type { i8*, double, i1 }
%ExpressionContinuationCapture = type { i8*, double, i1 }
%ExtractedSpan = type { i8*, double, double, i1 }
%PythonBuilder = type { { i8**, i64 }*, double }
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
@.str.3 = private unnamed_addr constant [42 x i8] c" = runtime.enum_type('\22 + enum_name + \22')\00"
@.str.119 = private unnamed_addr constant [12 x i8] c"__all__ = [\00"
@.str.2 = private unnamed_addr constant [7 x i8] c"class \00"
@.str.18 = private unnamed_addr constant [18 x i8] c"def __init__(self\00"
@.str.97 = private unnamed_addr constant [20 x i8] c"def __repr__(self):\00"
@.str.39 = private unnamed_addr constant [96 x i8] c"return runtime.struct_repr('\22 + class_name + \22', [\22 + join_with_separator(rendered, \22, \22) + \22])\00"
@.str.0 = private unnamed_addr constant [1 x i8] c"\00"
@.str.67 = private unnamed_addr constant [1 x i8] c"\00"
@.str.5 = private unnamed_addr constant [1 x i8] c"\00"
@.str.8 = private unnamed_addr constant [1 x i8] c"\00"
@.str.11 = private unnamed_addr constant [49 x i8] c"(\22 + join_with_separator(parameters, \22, \22) + \22):\00"

define %LoweredPythonResult @lower_to_python(%NativeModule %native_module) {
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
  %t5 = extractvalue %NativeModule %native_module, 0
  %t6 = call double @select_text_artifact({ i8**, i64 }* %t5)
  store double %t6, double* %l1
  %t7 = load double, double* %l1
  %t8 = load double, double* %l1
  store double 0.0, double* %l2
  %t9 = load double, double* %l2
  %t10 = load double, double* %l2
  %t11 = load double, double* %l2
  %t12 = load double, double* %l2
  %t13 = load double, double* %l2
  %t14 = load double, double* %l2
  store double 0.0, double* %l3
  %t15 = load double, double* %l3
  %t16 = load double, double* %l3
  store double 0.0, double* %l4
  %t17 = load double, double* %l4
  %t18 = insertvalue %LoweredPythonResult undef, i8* null, 0
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t20 = insertvalue %LoweredPythonResult %t18, { i8**, i64 }* %t19, 1
  ret %LoweredPythonResult %t20
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
  %t1 = alloca [0 x double]
  %t2 = getelementptr [0 x double], [0 x double]* %t1, i32 0, i32 0
  %t3 = alloca { double*, i64 }
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 0
  store double* %t2, double** %t4
  %t5 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t6 = load %PythonBuilder, %PythonBuilder* %l0
  %s7 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.7, i32 0, i32 0
  %t8 = call %PythonBuilder @builder_emit(%PythonBuilder %t6, i8* %s7)
  store %PythonBuilder %t8, %PythonBuilder* %l0
  %t9 = load %PythonBuilder, %PythonBuilder* %l0
  %s10 = getelementptr inbounds [47 x i8], [47 x i8]* @.str.10, i32 0, i32 0
  %t11 = call %PythonBuilder @builder_emit(%PythonBuilder %t9, i8* %s10)
  store %PythonBuilder %t11, %PythonBuilder* %l0
  %t12 = alloca [0 x double]
  %t13 = getelementptr [0 x double], [0 x double]* %t12, i32 0, i32 0
  %t14 = alloca { double*, i64 }
  %t15 = getelementptr { double*, i64 }, { double*, i64 }* %t14, i32 0, i32 0
  store double* %t13, double** %t15
  %t16 = getelementptr { double*, i64 }, { double*, i64 }* %t14, i32 0, i32 1
  store i64 0, i64* %t16
  store { i8**, i64 }* null, { i8**, i64 }** %l2
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
  %t74 = load %PythonStructEmission, %PythonStructEmission* %l4
  %t75 = extractvalue %PythonStructEmission %t74, 1
  %t76 = call double @diagnosticsconcat({ i8**, i64 }* %t75)
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  br label %merge7
merge7:
  %t77 = phi %PythonBuilder [ %t69, %then6 ], [ %t65, %entry ]
  %t78 = phi %PythonBuilder [ zeroinitializer, %then6 ], [ %t65, %entry ]
  %t79 = phi { i8**, i64 }* [ null, %then6 ], [ %t66, %entry ]
  store %PythonBuilder %t77, %PythonBuilder* %l0
  store %PythonBuilder %t78, %PythonBuilder* %l0
  store { i8**, i64 }* %t79, { i8**, i64 }** %l1
  %t80 = load %PythonBuilder, %PythonBuilder* %l0
  %t81 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t80)
  store %PythonBuilder %t81, %PythonBuilder* %l0
  %t82 = sitofp i64 0 to double
  store double %t82, double* %l5
  %t83 = load %PythonBuilder, %PythonBuilder* %l0
  %t84 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t86 = load double, double* %l5
  br label %loop.header8
loop.header8:
  %t131 = phi %PythonBuilder [ %t83, %entry ], [ %t128, %loop.latch10 ]
  %t132 = phi { i8**, i64 }* [ %t84, %entry ], [ %t129, %loop.latch10 ]
  %t133 = phi double [ %t86, %entry ], [ %t130, %loop.latch10 ]
  store %PythonBuilder %t131, %PythonBuilder* %l0
  store { i8**, i64 }* %t132, { i8**, i64 }** %l1
  store double %t133, double* %l5
  br label %loop.body9
loop.body9:
  %t87 = load double, double* %l5
  %t88 = load { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %functions
  %t89 = extractvalue { %NativeFunction*, i64 } %t88, 1
  %t90 = sitofp i64 %t89 to double
  %t91 = fcmp oge double %t87, %t90
  %t92 = load %PythonBuilder, %PythonBuilder* %l0
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t94 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t95 = load double, double* %l5
  br i1 %t91, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t96 = load %PythonBuilder, %PythonBuilder* %l0
  %t97 = load double, double* %l5
  %t98 = load { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %functions
  %t99 = extractvalue { %NativeFunction*, i64 } %t98, 0
  %t100 = extractvalue { %NativeFunction*, i64 } %t98, 1
  %t101 = icmp uge i64 %t97, %t100
  ; bounds check: %t101 (if true, out of bounds)
  %t102 = getelementptr %NativeFunction, %NativeFunction* %t99, i64 %t97
  %t103 = load %NativeFunction, %NativeFunction* %t102
  %t104 = call %PythonFunctionEmission @emit_python_function(%PythonBuilder %t96, %NativeFunction %t103)
  store %PythonFunctionEmission %t104, %PythonFunctionEmission* %l6
  %t105 = load %PythonFunctionEmission, %PythonFunctionEmission* %l6
  %t106 = extractvalue %PythonFunctionEmission %t105, 0
  store %PythonBuilder zeroinitializer, %PythonBuilder* %l0
  %t107 = load %PythonFunctionEmission, %PythonFunctionEmission* %l6
  %t108 = extractvalue %PythonFunctionEmission %t107, 1
  %t109 = call double @diagnosticsconcat({ i8**, i64 }* %t108)
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t110 = load double, double* %l5
  %t111 = sitofp i64 1 to double
  %t112 = fadd double %t110, %t111
  %t113 = load { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %functions
  %t114 = extractvalue { %NativeFunction*, i64 } %t113, 1
  %t115 = sitofp i64 %t114 to double
  %t116 = fcmp olt double %t112, %t115
  %t117 = load %PythonBuilder, %PythonBuilder* %l0
  %t118 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t119 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t120 = load double, double* %l5
  %t121 = load %PythonFunctionEmission, %PythonFunctionEmission* %l6
  br i1 %t116, label %then14, label %merge15
then14:
  %t122 = load %PythonBuilder, %PythonBuilder* %l0
  %t123 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t122)
  store %PythonBuilder %t123, %PythonBuilder* %l0
  br label %merge15
merge15:
  %t124 = phi %PythonBuilder [ %t123, %then14 ], [ %t117, %loop.body9 ]
  store %PythonBuilder %t124, %PythonBuilder* %l0
  %t125 = load double, double* %l5
  %t126 = sitofp i64 1 to double
  %t127 = fadd double %t125, %t126
  store double %t127, double* %l5
  br label %loop.latch10
loop.latch10:
  %t128 = load %PythonBuilder, %PythonBuilder* %l0
  %t129 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t130 = load double, double* %l5
  br label %loop.header8
afterloop11:
  %t134 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t135 = load { i8**, i64 }, { i8**, i64 }* %t134
  %t136 = extractvalue { i8**, i64 } %t135, 1
  %t137 = icmp sgt i64 %t136, 0
  %t138 = load %PythonBuilder, %PythonBuilder* %l0
  %t139 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t140 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t141 = load double, double* %l5
  br i1 %t137, label %then16, label %merge17
then16:
  %t142 = load %PythonBuilder, %PythonBuilder* %l0
  %t143 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t142)
  store %PythonBuilder %t143, %PythonBuilder* %l0
  %t144 = load %PythonBuilder, %PythonBuilder* %l0
  %t145 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t146 = call %PythonBuilder @emit_export_list(%PythonBuilder %t144, { i8**, i64 }* %t145)
  store %PythonBuilder %t146, %PythonBuilder* %l0
  br label %merge17
merge17:
  %t147 = phi %PythonBuilder [ %t143, %then16 ], [ %t138, %entry ]
  %t148 = phi %PythonBuilder [ %t146, %then16 ], [ %t138, %entry ]
  store %PythonBuilder %t147, %PythonBuilder* %l0
  store %PythonBuilder %t148, %PythonBuilder* %l0
  %t149 = load %PythonBuilder, %PythonBuilder* %l0
  %t150 = insertvalue %PythonModuleEmission undef, i8* null, 0
  %t151 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t152 = insertvalue %PythonModuleEmission %t150, { i8**, i64 }* %t151, 1
  ret %PythonModuleEmission %t152
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
  %t40 = load %PythonBuilder, %PythonBuilder* %l0
  %t41 = load %PythonBuilder, %PythonBuilder* %l0
  ret %PythonBuilder %t41
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
  %t49 = phi %PythonBuilder [ %t1, %entry ], [ %t47, %loop.latch2 ]
  %t50 = phi double [ %t2, %entry ], [ %t48, %loop.latch2 ]
  store %PythonBuilder %t49, %PythonBuilder* %l0
  store double %t50, double* %l1
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
  %t11 = load { %NativeBinding*, i64 }, { %NativeBinding*, i64 }* %bindings
  %t12 = extractvalue { %NativeBinding*, i64 } %t11, 0
  %t13 = extractvalue { %NativeBinding*, i64 } %t11, 1
  %t14 = icmp uge i64 %t10, %t13
  ; bounds check: %t14 (if true, out of bounds)
  %t15 = getelementptr %NativeBinding, %NativeBinding* %t12, i64 %t10
  %t16 = load %NativeBinding, %NativeBinding* %t15
  store %NativeBinding %t16, %NativeBinding* %l2
  %t17 = load %NativeBinding, %NativeBinding* %l2
  %t18 = extractvalue %NativeBinding %t17, 0
  %t19 = call i8* @sanitize_identifier(i8* %t18)
  store i8* %t19, i8** %l3
  %t20 = load i8*, i8** %l3
  %s21 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.21, i32 0, i32 0
  %t22 = add i8* %t20, %s21
  store i8* %t22, i8** %l4
  %t23 = load %NativeBinding, %NativeBinding* %l2
  %t24 = extractvalue %NativeBinding %t23, 3
  %t25 = icmp ne i8* %t24, null
  %t26 = load %PythonBuilder, %PythonBuilder* %l0
  %t27 = load double, double* %l1
  %t28 = load %NativeBinding, %NativeBinding* %l2
  %t29 = load i8*, i8** %l3
  %t30 = load i8*, i8** %l4
  br i1 %t25, label %then6, label %else7
then6:
  %t31 = load %NativeBinding, %NativeBinding* %l2
  %t32 = extractvalue %NativeBinding %t31, 3
  store i8* %t32, i8** %l5
  %t33 = load i8*, i8** %l4
  %t34 = load i8*, i8** %l5
  %t35 = call i8* @lower_expression(i8* %t34)
  %t36 = add i8* %t33, %t35
  store i8* %t36, i8** %l4
  br label %merge8
else7:
  %t37 = load i8*, i8** %l4
  %s38 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.38, i32 0, i32 0
  %t39 = add i8* %t37, %s38
  store i8* %t39, i8** %l4
  br label %merge8
merge8:
  %t40 = phi i8* [ %t36, %then6 ], [ %t39, %else7 ]
  store i8* %t40, i8** %l4
  %t41 = load %PythonBuilder, %PythonBuilder* %l0
  %t42 = load i8*, i8** %l4
  %t43 = call %PythonBuilder @builder_emit(%PythonBuilder %t41, i8* %t42)
  store %PythonBuilder %t43, %PythonBuilder* %l0
  %t44 = load double, double* %l1
  %t45 = sitofp i64 1 to double
  %t46 = fadd double %t44, %t45
  store double %t46, double* %l1
  br label %loop.latch2
loop.latch2:
  %t47 = load %PythonBuilder, %PythonBuilder* %l0
  %t48 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t51 = load %PythonBuilder, %PythonBuilder* %l0
  ret %PythonBuilder %t51
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
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l2
  %t6 = load %PythonBuilder, %PythonBuilder* %l0
  %t7 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t8 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t49 = phi { i8**, i64 }* [ %t7, %entry ], [ %t47, %loop.latch2 ]
  %t50 = phi double [ %t8, %entry ], [ %t48, %loop.latch2 ]
  store { i8**, i64 }* %t49, { i8**, i64 }** %l1
  store double %t50, double* %l2
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
  %t18 = load { %NativeImport*, i64 }, { %NativeImport*, i64 }* %imports
  %t19 = extractvalue { %NativeImport*, i64 } %t18, 0
  %t20 = extractvalue { %NativeImport*, i64 } %t18, 1
  %t21 = icmp uge i64 %t17, %t20
  ; bounds check: %t21 (if true, out of bounds)
  %t22 = getelementptr %NativeImport, %NativeImport* %t19, i64 %t17
  %t23 = load %NativeImport, %NativeImport* %t22
  store %NativeImport %t23, %NativeImport* %l3
  %t24 = load %NativeImport, %NativeImport* %l3
  %t25 = extractvalue %NativeImport %t24, 0
  %s26 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.26, i32 0, i32 0
  %t27 = icmp eq i8* %t25, %s26
  %t28 = load %PythonBuilder, %PythonBuilder* %l0
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t30 = load double, double* %l2
  %t31 = load %NativeImport, %NativeImport* %l3
  br i1 %t27, label %then6, label %merge7
then6:
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t33 = load %NativeImport, %NativeImport* %l3
  %t34 = extractvalue %NativeImport %t33, 2
  %t35 = call { i8**, i64 }* @collect_export_names({ i8**, i64 }* %t32, { %NativeImportSpecifier*, i64 }* null)
  store { i8**, i64 }* %t35, { i8**, i64 }** %l1
  %t36 = load %NativeImport, %NativeImport* %l3
  %t37 = extractvalue %NativeImport %t36, 1
  %t38 = call i8* @trim_text(i8* %t37)
  store i8* %t38, i8** %l4
  %t39 = load i8*, i8** %l4
  br label %merge7
merge7:
  %t40 = phi { i8**, i64 }* [ %t35, %then6 ], [ %t29, %loop.body1 ]
  store { i8**, i64 }* %t40, { i8**, i64 }** %l1
  %t41 = load %NativeImport, %NativeImport* %l3
  %t42 = call i8* @render_python_import(%NativeImport %t41)
  store i8* %t42, i8** %l5
  %t43 = load i8*, i8** %l5
  %t44 = load double, double* %l2
  %t45 = sitofp i64 1 to double
  %t46 = fadd double %t44, %t45
  store double %t46, double* %l2
  br label %loop.latch2
loop.latch2:
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t48 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t51 = load %PythonBuilder, %PythonBuilder* %l0
  %t52 = insertvalue %PythonImportEmission undef, i8* null, 0
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t54 = insertvalue %PythonImportEmission %t52, { i8**, i64 }* %t53, 1
  ret %PythonImportEmission %t54
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
  %t36 = phi %PythonBuilder [ %t1, %entry ], [ %t34, %loop.latch2 ]
  %t37 = phi double [ %t2, %entry ], [ %t35, %loop.latch2 ]
  store %PythonBuilder %t36, %PythonBuilder* %l0
  store double %t37, double* %l1
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
  %t12 = load { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* %enums
  %t13 = extractvalue { %NativeEnum*, i64 } %t12, 0
  %t14 = extractvalue { %NativeEnum*, i64 } %t12, 1
  %t15 = icmp uge i64 %t11, %t14
  ; bounds check: %t15 (if true, out of bounds)
  %t16 = getelementptr %NativeEnum, %NativeEnum* %t13, i64 %t11
  %t17 = load %NativeEnum, %NativeEnum* %t16
  %t18 = call %PythonBuilder @emit_single_enum(%PythonBuilder %t10, %NativeEnum %t17)
  store %PythonBuilder %t18, %PythonBuilder* %l0
  %t19 = load double, double* %l1
  %t20 = sitofp i64 1 to double
  %t21 = fadd double %t19, %t20
  %t22 = load { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* %enums
  %t23 = extractvalue { %NativeEnum*, i64 } %t22, 1
  %t24 = sitofp i64 %t23 to double
  %t25 = fcmp olt double %t21, %t24
  %t26 = load %PythonBuilder, %PythonBuilder* %l0
  %t27 = load double, double* %l1
  br i1 %t25, label %then6, label %merge7
then6:
  %t28 = load %PythonBuilder, %PythonBuilder* %l0
  %t29 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t28)
  store %PythonBuilder %t29, %PythonBuilder* %l0
  br label %merge7
merge7:
  %t30 = phi %PythonBuilder [ %t29, %then6 ], [ %t26, %loop.body1 ]
  store %PythonBuilder %t30, %PythonBuilder* %l0
  %t31 = load double, double* %l1
  %t32 = sitofp i64 1 to double
  %t33 = fadd double %t31, %t32
  store double %t33, double* %l1
  br label %loop.latch2
loop.latch2:
  %t34 = load %PythonBuilder, %PythonBuilder* %l0
  %t35 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t38 = load %PythonBuilder, %PythonBuilder* %l0
  ret %PythonBuilder %t38
}

define %PythonBuilder @emit_single_enum(%PythonBuilder %builder, %NativeEnum %definition) {
entry:
  %l0 = alloca i8*
  %l1 = alloca %PythonBuilder
  %l2 = alloca double
  %l3 = alloca i8*
  %l4 = alloca double
  %l5 = alloca i8*
  %t0 = extractvalue %NativeEnum %definition, 0
  %t1 = call i8* @sanitize_identifier(i8* %t0)
  store i8* %t1, i8** %l0
  %t2 = load i8*, i8** %l0
  %s3 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.3, i32 0, i32 0
  %t4 = add i8* %t2, %s3
  %t5 = call %PythonBuilder @builder_emit(%PythonBuilder %builder, i8* %t4)
  store %PythonBuilder %t5, %PythonBuilder* %l1
  %t6 = sitofp i64 0 to double
  store double %t6, double* %l2
  %t7 = load i8*, i8** %l0
  %t8 = load %PythonBuilder, %PythonBuilder* %l1
  %t9 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t39 = phi %PythonBuilder [ %t8, %entry ], [ %t37, %loop.latch2 ]
  %t40 = phi double [ %t9, %entry ], [ %t38, %loop.latch2 ]
  store %PythonBuilder %t39, %PythonBuilder* %l1
  store double %t40, double* %l2
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l2
  %t11 = extractvalue %NativeEnum %definition, 1
  %t12 = load { i8**, i64 }, { i8**, i64 }* %t11
  %t13 = extractvalue { i8**, i64 } %t12, 1
  %t14 = sitofp i64 %t13 to double
  %t15 = fcmp oge double %t10, %t14
  %t16 = load i8*, i8** %l0
  %t17 = load %PythonBuilder, %PythonBuilder* %l1
  %t18 = load double, double* %l2
  br i1 %t15, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t19 = extractvalue %NativeEnum %definition, 1
  %t20 = load double, double* %l2
  %t21 = load { i8**, i64 }, { i8**, i64 }* %t19
  %t22 = extractvalue { i8**, i64 } %t21, 0
  %t23 = extractvalue { i8**, i64 } %t21, 1
  %t24 = icmp uge i64 %t20, %t23
  ; bounds check: %t24 (if true, out of bounds)
  %t25 = getelementptr i8*, i8** %t22, i64 %t20
  %t26 = load i8*, i8** %t25
  store i8* %t26, i8** %l3
  %t27 = load i8*, i8** %l3
  store double 0.0, double* %l4
  %t28 = load i8*, i8** %l0
  %s29 = getelementptr inbounds [128 x i8], [128 x i8]* @.str.29, i32 0, i32 0
  %t30 = add i8* %t28, %s29
  store i8* %t30, i8** %l5
  %t31 = load %PythonBuilder, %PythonBuilder* %l1
  %t32 = load i8*, i8** %l5
  %t33 = call %PythonBuilder @builder_emit(%PythonBuilder %t31, i8* %t32)
  store %PythonBuilder %t33, %PythonBuilder* %l1
  %t34 = load double, double* %l2
  %t35 = sitofp i64 1 to double
  %t36 = fadd double %t34, %t35
  store double %t36, double* %l2
  br label %loop.latch2
loop.latch2:
  %t37 = load %PythonBuilder, %PythonBuilder* %l1
  %t38 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t41 = load %PythonBuilder, %PythonBuilder* %l1
  ret %PythonBuilder %t41
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
  %t4 = alloca [0 x double]
  %t5 = getelementptr [0 x double], [0 x double]* %t4, i32 0, i32 0
  %t6 = alloca { double*, i64 }
  %t7 = getelementptr { double*, i64 }, { double*, i64 }* %t6, i32 0, i32 0
  store double* %t5, double** %t7
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t6, i32 0, i32 1
  store i64 0, i64* %t8
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t9 = sitofp i64 0 to double
  store double %t9, double* %l1
  %t10 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t11 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t39 = phi { i8**, i64 }* [ %t10, %entry ], [ %t37, %loop.latch4 ]
  %t40 = phi double [ %t11, %entry ], [ %t38, %loop.latch4 ]
  store { i8**, i64 }* %t39, { i8**, i64 }** %l0
  store double %t40, double* %l1
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
  %t21 = load { %NativeEnumVariantField*, i64 }, { %NativeEnumVariantField*, i64 }* %fields
  %t22 = extractvalue { %NativeEnumVariantField*, i64 } %t21, 0
  %t23 = extractvalue { %NativeEnumVariantField*, i64 } %t21, 1
  %t24 = icmp uge i64 %t20, %t23
  ; bounds check: %t24 (if true, out of bounds)
  %t25 = getelementptr %NativeEnumVariantField, %NativeEnumVariantField* %t22, i64 %t20
  %t26 = load %NativeEnumVariantField, %NativeEnumVariantField* %t25
  %t27 = extractvalue %NativeEnumVariantField %t26, 0
  %t28 = call i8* @sanitize_identifier(i8* %t27)
  %t29 = getelementptr i8, i8* %t28, i64 0
  %t30 = load i8, i8* %t29
  %t31 = add i8 39, %t30
  %t32 = add i8 %t31, 39
  %t33 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t19, i8* null)
  store { i8**, i64 }* %t33, { i8**, i64 }** %l0
  %t34 = load double, double* %l1
  %t35 = sitofp i64 1 to double
  %t36 = fadd double %t34, %t35
  store double %t36, double* %l1
  br label %loop.latch4
loop.latch4:
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t38 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret i8* null
}

define i8* @render_python_import(%NativeImport %entry) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %t0 = extractvalue %NativeImport %entry, 1
  %t1 = call i8* @normalize_import_module(i8* %t0)
  store i8* %t1, i8** %l0
  %t2 = load i8*, i8** %l0
  %t3 = extractvalue %NativeImport %entry, 2
  %t4 = load { i8**, i64 }, { i8**, i64 }* %t3
  %t5 = extractvalue { i8**, i64 } %t4, 1
  %t6 = icmp eq i64 %t5, 0
  %t7 = load i8*, i8** %l0
  br i1 %t6, label %then0, label %merge1
then0:
  %s8 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.8, i32 0, i32 0
  %t9 = load i8*, i8** %l0
  %t10 = add i8* %s8, %t9
  ret i8* %t10
merge1:
  %t11 = extractvalue %NativeImport %entry, 2
  %t12 = call i8* @render_python_specifiers({ %NativeImportSpecifier*, i64 }* null)
  store i8* %t12, i8** %l1
  %s13 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.13, i32 0, i32 0
  %t14 = load i8*, i8** %l0
  %t15 = add i8* %s13, %t14
  %s16 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.16, i32 0, i32 0
  %t17 = add i8* %t15, %s16
  %t18 = load i8*, i8** %l1
  %t19 = add i8* %t17, %t18
  ret i8* %t19
}

define i8* @render_python_specifiers({ %NativeImportSpecifier*, i64 }* %specifiers) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
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
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t30 = phi { i8**, i64 }* [ %t6, %entry ], [ %t28, %loop.latch2 ]
  %t31 = phi double [ %t7, %entry ], [ %t29, %loop.latch2 ]
  store { i8**, i64 }* %t30, { i8**, i64 }** %l0
  store double %t31, double* %l1
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
  %t17 = load { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %specifiers
  %t18 = extractvalue { %NativeImportSpecifier*, i64 } %t17, 0
  %t19 = extractvalue { %NativeImportSpecifier*, i64 } %t17, 1
  %t20 = icmp uge i64 %t16, %t19
  ; bounds check: %t20 (if true, out of bounds)
  %t21 = getelementptr %NativeImportSpecifier, %NativeImportSpecifier* %t18, i64 %t16
  %t22 = load %NativeImportSpecifier, %NativeImportSpecifier* %t21
  %t23 = call i8* @render_python_specifier(%NativeImportSpecifier %t22)
  %t24 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t15, i8* %t23)
  store { i8**, i64 }* %t24, { i8**, i64 }** %l0
  %t25 = load double, double* %l1
  %t26 = sitofp i64 1 to double
  %t27 = fadd double %t25, %t26
  store double %t27, double* %l1
  br label %loop.latch2
loop.latch2:
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t29 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret i8* null
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
  %t6 = load i8*, i8** %l0
  %s7 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.7, i32 0, i32 0
  %t8 = add i8* %t6, %s7
  %t9 = extractvalue %NativeImportSpecifier %specifier, 1
  %t10 = call i8* @sanitize_identifier(i8* %t9)
  %t11 = add i8* %t8, %t10
  ret i8* %t11
}

define i8* @normalize_import_module(i8* %path) {
entry:
  %l0 = alloca i8*
  %t0 = call i8* @trim_text(i8* %path)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = load i8*, i8** %l0
  %t3 = load i8*, i8** %l0
  %t4 = load i8*, i8** %l0
  ret i8* null
}

define %PythonStructEmission @emit_struct_definitions(%PythonBuilder %builder, { %NativeStruct*, i64 }* %structs) {
entry:
  %l0 = alloca %PythonBuilder
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca %PythonStructEmission
  store %PythonBuilder %builder, %PythonBuilder* %l0
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l2
  %t6 = load %PythonBuilder, %PythonBuilder* %l0
  %t7 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t8 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t51 = phi %PythonBuilder [ %t6, %entry ], [ %t48, %loop.latch2 ]
  %t52 = phi { i8**, i64 }* [ %t7, %entry ], [ %t49, %loop.latch2 ]
  %t53 = phi double [ %t8, %entry ], [ %t50, %loop.latch2 ]
  store %PythonBuilder %t51, %PythonBuilder* %l0
  store { i8**, i64 }* %t52, { i8**, i64 }** %l1
  store double %t53, double* %l2
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
  %t19 = load { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* %structs
  %t20 = extractvalue { %NativeStruct*, i64 } %t19, 0
  %t21 = extractvalue { %NativeStruct*, i64 } %t19, 1
  %t22 = icmp uge i64 %t18, %t21
  ; bounds check: %t22 (if true, out of bounds)
  %t23 = getelementptr %NativeStruct, %NativeStruct* %t20, i64 %t18
  %t24 = load %NativeStruct, %NativeStruct* %t23
  %t25 = call %PythonStructEmission @emit_single_struct(%PythonBuilder %t17, %NativeStruct %t24)
  store %PythonStructEmission %t25, %PythonStructEmission* %l3
  %t26 = load %PythonStructEmission, %PythonStructEmission* %l3
  %t27 = extractvalue %PythonStructEmission %t26, 0
  store %PythonBuilder zeroinitializer, %PythonBuilder* %l0
  %t28 = load %PythonStructEmission, %PythonStructEmission* %l3
  %t29 = extractvalue %PythonStructEmission %t28, 1
  %t30 = call double @diagnosticsconcat({ i8**, i64 }* %t29)
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t31 = load double, double* %l2
  %t32 = sitofp i64 1 to double
  %t33 = fadd double %t31, %t32
  %t34 = load { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* %structs
  %t35 = extractvalue { %NativeStruct*, i64 } %t34, 1
  %t36 = sitofp i64 %t35 to double
  %t37 = fcmp olt double %t33, %t36
  %t38 = load %PythonBuilder, %PythonBuilder* %l0
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t40 = load double, double* %l2
  %t41 = load %PythonStructEmission, %PythonStructEmission* %l3
  br i1 %t37, label %then6, label %merge7
then6:
  %t42 = load %PythonBuilder, %PythonBuilder* %l0
  %t43 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t42)
  store %PythonBuilder %t43, %PythonBuilder* %l0
  br label %merge7
merge7:
  %t44 = phi %PythonBuilder [ %t43, %then6 ], [ %t38, %loop.body1 ]
  store %PythonBuilder %t44, %PythonBuilder* %l0
  %t45 = load double, double* %l2
  %t46 = sitofp i64 1 to double
  %t47 = fadd double %t45, %t46
  store double %t47, double* %l2
  br label %loop.latch2
loop.latch2:
  %t48 = load %PythonBuilder, %PythonBuilder* %l0
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t50 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t54 = load %PythonBuilder, %PythonBuilder* %l0
  %t55 = insertvalue %PythonStructEmission undef, i8* null, 0
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t57 = insertvalue %PythonStructEmission %t55, { i8**, i64 }* %t56, 1
  ret %PythonStructEmission %t57
}

define %PythonBuilder @emit_export_list(%PythonBuilder %builder, { i8**, i64 }* %exports) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca i1
  %l4 = alloca double
  %l5 = alloca { i8**, i64 }*
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
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t78 = phi { i8**, i64 }* [ %t6, %entry ], [ %t76, %loop.latch2 ]
  %t79 = phi double [ %t7, %entry ], [ %t77, %loop.latch2 ]
  store { i8**, i64 }* %t78, { i8**, i64 }** %l0
  store double %t79, double* %l1
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
  %t16 = load { i8**, i64 }, { i8**, i64 }* %exports
  %t17 = extractvalue { i8**, i64 } %t16, 0
  %t18 = extractvalue { i8**, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  %t20 = getelementptr i8*, i8** %t17, i64 %t15
  %t21 = load i8*, i8** %t20
  %t22 = call i8* @sanitize_identifier(i8* %t21)
  store i8* %t22, i8** %l2
  store i1 0, i1* %l3
  %t23 = sitofp i64 0 to double
  store double %t23, double* %l4
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t25 = load double, double* %l1
  %t26 = load i8*, i8** %l2
  %t27 = load i1, i1* %l3
  %t28 = load double, double* %l4
  br label %loop.header6
loop.header6:
  %t60 = phi i1 [ %t27, %loop.body1 ], [ %t58, %loop.latch8 ]
  %t61 = phi double [ %t28, %loop.body1 ], [ %t59, %loop.latch8 ]
  store i1 %t60, i1* %l3
  store double %t61, double* %l4
  br label %loop.body7
loop.body7:
  %t29 = load double, double* %l4
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t31 = load { i8**, i64 }, { i8**, i64 }* %t30
  %t32 = extractvalue { i8**, i64 } %t31, 1
  %t33 = sitofp i64 %t32 to double
  %t34 = fcmp oge double %t29, %t33
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t36 = load double, double* %l1
  %t37 = load i8*, i8** %l2
  %t38 = load i1, i1* %l3
  %t39 = load double, double* %l4
  br i1 %t34, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t41 = load double, double* %l4
  %t42 = load { i8**, i64 }, { i8**, i64 }* %t40
  %t43 = extractvalue { i8**, i64 } %t42, 0
  %t44 = extractvalue { i8**, i64 } %t42, 1
  %t45 = icmp uge i64 %t41, %t44
  ; bounds check: %t45 (if true, out of bounds)
  %t46 = getelementptr i8*, i8** %t43, i64 %t41
  %t47 = load i8*, i8** %t46
  %t48 = load i8*, i8** %l2
  %t49 = icmp eq i8* %t47, %t48
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t51 = load double, double* %l1
  %t52 = load i8*, i8** %l2
  %t53 = load i1, i1* %l3
  %t54 = load double, double* %l4
  br i1 %t49, label %then12, label %merge13
then12:
  store i1 1, i1* %l3
  br label %afterloop9
merge13:
  %t55 = load double, double* %l4
  %t56 = sitofp i64 1 to double
  %t57 = fadd double %t55, %t56
  store double %t57, double* %l4
  br label %loop.latch8
loop.latch8:
  %t58 = load i1, i1* %l3
  %t59 = load double, double* %l4
  br label %loop.header6
afterloop9:
  %t62 = load i1, i1* %l3
  %t63 = xor i1 %t62, 1
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t65 = load double, double* %l1
  %t66 = load i8*, i8** %l2
  %t67 = load i1, i1* %l3
  %t68 = load double, double* %l4
  br i1 %t63, label %then14, label %merge15
then14:
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t70 = load i8*, i8** %l2
  %t71 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t69, i8* %t70)
  store { i8**, i64 }* %t71, { i8**, i64 }** %l0
  br label %merge15
merge15:
  %t72 = phi { i8**, i64 }* [ %t71, %then14 ], [ %t64, %loop.body1 ]
  store { i8**, i64 }* %t72, { i8**, i64 }** %l0
  %t73 = load double, double* %l1
  %t74 = sitofp i64 1 to double
  %t75 = fadd double %t73, %t74
  store double %t75, double* %l1
  br label %loop.latch2
loop.latch2:
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t77 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t80 = alloca [0 x double]
  %t81 = getelementptr [0 x double], [0 x double]* %t80, i32 0, i32 0
  %t82 = alloca { double*, i64 }
  %t83 = getelementptr { double*, i64 }, { double*, i64 }* %t82, i32 0, i32 0
  store double* %t81, double** %t83
  %t84 = getelementptr { double*, i64 }, { double*, i64 }* %t82, i32 0, i32 1
  store i64 0, i64* %t84
  store { i8**, i64 }* null, { i8**, i64 }** %l5
  %t85 = sitofp i64 0 to double
  store double %t85, double* %l1
  %t86 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t87 = load double, double* %l1
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l5
  br label %loop.header16
loop.header16:
  %t117 = phi { i8**, i64 }* [ %t88, %entry ], [ %t115, %loop.latch18 ]
  %t118 = phi double [ %t87, %entry ], [ %t116, %loop.latch18 ]
  store { i8**, i64 }* %t117, { i8**, i64 }** %l5
  store double %t118, double* %l1
  br label %loop.body17
loop.body17:
  %t89 = load double, double* %l1
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t91 = load { i8**, i64 }, { i8**, i64 }* %t90
  %t92 = extractvalue { i8**, i64 } %t91, 1
  %t93 = sitofp i64 %t92 to double
  %t94 = fcmp oge double %t89, %t93
  %t95 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t96 = load double, double* %l1
  %t97 = load { i8**, i64 }*, { i8**, i64 }** %l5
  br i1 %t94, label %then20, label %merge21
then20:
  br label %afterloop19
merge21:
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t100 = load double, double* %l1
  %t101 = load { i8**, i64 }, { i8**, i64 }* %t99
  %t102 = extractvalue { i8**, i64 } %t101, 0
  %t103 = extractvalue { i8**, i64 } %t101, 1
  %t104 = icmp uge i64 %t100, %t103
  ; bounds check: %t104 (if true, out of bounds)
  %t105 = getelementptr i8*, i8** %t102, i64 %t100
  %t106 = load i8*, i8** %t105
  %t107 = getelementptr i8, i8* %t106, i64 0
  %t108 = load i8, i8* %t107
  %t109 = add i8 34, %t108
  %t110 = add i8 %t109, 34
  %t111 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t98, i8* null)
  store { i8**, i64 }* %t111, { i8**, i64 }** %l5
  %t112 = load double, double* %l1
  %t113 = sitofp i64 1 to double
  %t114 = fadd double %t112, %t113
  store double %t114, double* %l1
  br label %loop.latch18
loop.latch18:
  %t115 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t116 = load double, double* %l1
  br label %loop.header16
afterloop19:
  %s119 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.119, i32 0, i32 0
  %t120 = load { i8**, i64 }*, { i8**, i64 }** %l5
  ret %PythonBuilder zeroinitializer
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
  %t24 = phi double [ %t2, %entry ], [ %t23, %loop.latch2 ]
  store double %t24, double* %l1
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
  %t11 = load { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %specifiers
  %t12 = extractvalue { %NativeImportSpecifier*, i64 } %t11, 0
  %t13 = extractvalue { %NativeImportSpecifier*, i64 } %t11, 1
  %t14 = icmp uge i64 %t10, %t13
  ; bounds check: %t14 (if true, out of bounds)
  %t15 = getelementptr %NativeImportSpecifier, %NativeImportSpecifier* %t12, i64 %t10
  %t16 = load %NativeImportSpecifier, %NativeImportSpecifier* %t15
  store %NativeImportSpecifier %t16, %NativeImportSpecifier* %l2
  %t17 = load %NativeImportSpecifier, %NativeImportSpecifier* %l2
  %t18 = call i8* @select_export_name(%NativeImportSpecifier %t17)
  store i8* %t18, i8** %l3
  %t19 = load i8*, i8** %l3
  %t20 = load double, double* %l1
  %t21 = sitofp i64 1 to double
  %t22 = fadd double %t20, %t21
  store double %t22, double* %l1
  br label %loop.latch2
loop.latch2:
  %t23 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t25
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
  %t4 = extractvalue %NativeImportSpecifier %specifier, 0
  ret i8* %t4
}

define %PythonStructEmission @emit_single_struct(%PythonBuilder %builder, %NativeStruct %definition) {
entry:
  %l0 = alloca i8*
  %l1 = alloca %PythonBuilder
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca { i8**, i64 }*
  %l4 = alloca i8*
  %l5 = alloca double
  %l6 = alloca i8*
  %l7 = alloca double
  %l8 = alloca i8*
  %l9 = alloca double
  %l10 = alloca i8*
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
  %t8 = call %PythonBuilder @builder_emit(%PythonBuilder %builder, i8* null)
  store %PythonBuilder %t8, %PythonBuilder* %l1
  %t9 = load %PythonBuilder, %PythonBuilder* %l1
  %t10 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t9)
  store %PythonBuilder %t10, %PythonBuilder* %l1
  %t11 = alloca [0 x double]
  %t12 = getelementptr [0 x double], [0 x double]* %t11, i32 0, i32 0
  %t13 = alloca { double*, i64 }
  %t14 = getelementptr { double*, i64 }, { double*, i64 }* %t13, i32 0, i32 0
  store double* %t12, double** %t14
  %t15 = getelementptr { double*, i64 }, { double*, i64 }* %t13, i32 0, i32 1
  store i64 0, i64* %t15
  store { i8**, i64 }* null, { i8**, i64 }** %l2
  %t16 = extractvalue %NativeStruct %definition, 1
  %t17 = call { i8**, i64 }* @render_struct_parameters({ %NativeStructField*, i64 }* null)
  store { i8**, i64 }* %t17, { i8**, i64 }** %l3
  %s18 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.18, i32 0, i32 0
  store i8* %s18, i8** %l4
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t20 = load { i8**, i64 }, { i8**, i64 }* %t19
  %t21 = extractvalue { i8**, i64 } %t20, 1
  %t22 = icmp sgt i64 %t21, 0
  %t23 = load i8*, i8** %l0
  %t24 = load %PythonBuilder, %PythonBuilder* %l1
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t27 = load i8*, i8** %l4
  br i1 %t22, label %then0, label %merge1
then0:
  %t28 = load i8*, i8** %l4
  %s29 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.29, i32 0, i32 0
  %t30 = add i8* %t28, %s29
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l3
  br label %merge1
merge1:
  %t32 = phi i8* [ null, %then0 ], [ %t27, %entry ]
  store i8* %t32, i8** %l4
  %t33 = load %PythonBuilder, %PythonBuilder* %l1
  %t34 = load i8*, i8** %l4
  %t35 = getelementptr i8, i8* %t34, i64 0
  %t36 = load i8, i8* %t35
  %t37 = add i8 %t36, 58
  %t38 = call %PythonBuilder @builder_emit(%PythonBuilder %t33, i8* null)
  store %PythonBuilder %t38, %PythonBuilder* %l1
  %t39 = load %PythonBuilder, %PythonBuilder* %l1
  %t40 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t39)
  store %PythonBuilder %t40, %PythonBuilder* %l1
  %t41 = extractvalue %NativeStruct %definition, 1
  %t42 = load { i8**, i64 }, { i8**, i64 }* %t41
  %t43 = extractvalue { i8**, i64 } %t42, 1
  %t44 = icmp eq i64 %t43, 0
  %t45 = load i8*, i8** %l0
  %t46 = load %PythonBuilder, %PythonBuilder* %l1
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t49 = load i8*, i8** %l4
  br i1 %t44, label %then2, label %else3
then2:
  %t50 = load %PythonBuilder, %PythonBuilder* %l1
  %s51 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.51, i32 0, i32 0
  %t52 = call %PythonBuilder @builder_emit(%PythonBuilder %t50, i8* %s51)
  store %PythonBuilder %t52, %PythonBuilder* %l1
  br label %merge4
else3:
  %t53 = sitofp i64 0 to double
  store double %t53, double* %l5
  %t54 = load i8*, i8** %l0
  %t55 = load %PythonBuilder, %PythonBuilder* %l1
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t58 = load i8*, i8** %l4
  %t59 = load double, double* %l5
  br label %loop.header5
loop.header5:
  %t89 = phi %PythonBuilder [ %t55, %else3 ], [ %t87, %loop.latch7 ]
  %t90 = phi double [ %t59, %else3 ], [ %t88, %loop.latch7 ]
  store %PythonBuilder %t89, %PythonBuilder* %l1
  store double %t90, double* %l5
  br label %loop.body6
loop.body6:
  %t60 = load double, double* %l5
  %t61 = extractvalue %NativeStruct %definition, 1
  %t62 = load { i8**, i64 }, { i8**, i64 }* %t61
  %t63 = extractvalue { i8**, i64 } %t62, 1
  %t64 = sitofp i64 %t63 to double
  %t65 = fcmp oge double %t60, %t64
  %t66 = load i8*, i8** %l0
  %t67 = load %PythonBuilder, %PythonBuilder* %l1
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t70 = load i8*, i8** %l4
  %t71 = load double, double* %l5
  br i1 %t65, label %then9, label %merge10
then9:
  br label %afterloop8
merge10:
  %t72 = extractvalue %NativeStruct %definition, 1
  %t73 = load double, double* %l5
  %t74 = load { i8**, i64 }, { i8**, i64 }* %t72
  %t75 = extractvalue { i8**, i64 } %t74, 0
  %t76 = extractvalue { i8**, i64 } %t74, 1
  %t77 = icmp uge i64 %t73, %t76
  ; bounds check: %t77 (if true, out of bounds)
  %t78 = getelementptr i8*, i8** %t75, i64 %t73
  %t79 = load i8*, i8** %t78
  store i8* %t79, i8** %l6
  %t80 = load i8*, i8** %l6
  store double 0.0, double* %l7
  %t81 = load %PythonBuilder, %PythonBuilder* %l1
  %s82 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.82, i32 0, i32 0
  %t83 = load double, double* %l7
  %t84 = load double, double* %l5
  %t85 = sitofp i64 1 to double
  %t86 = fadd double %t84, %t85
  store double %t86, double* %l5
  br label %loop.latch7
loop.latch7:
  %t87 = load %PythonBuilder, %PythonBuilder* %l1
  %t88 = load double, double* %l5
  br label %loop.header5
afterloop8:
  br label %merge4
merge4:
  %t91 = phi %PythonBuilder [ %t52, %then2 ], [ zeroinitializer, %else3 ]
  store %PythonBuilder %t91, %PythonBuilder* %l1
  %t92 = load %PythonBuilder, %PythonBuilder* %l1
  %t93 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t92)
  store %PythonBuilder %t93, %PythonBuilder* %l1
  %t94 = load %PythonBuilder, %PythonBuilder* %l1
  %t95 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t94)
  store %PythonBuilder %t95, %PythonBuilder* %l1
  %t96 = load %PythonBuilder, %PythonBuilder* %l1
  %s97 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.97, i32 0, i32 0
  %t98 = call %PythonBuilder @builder_emit(%PythonBuilder %t96, i8* %s97)
  store %PythonBuilder %t98, %PythonBuilder* %l1
  %t99 = load %PythonBuilder, %PythonBuilder* %l1
  %t100 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t99)
  store %PythonBuilder %t100, %PythonBuilder* %l1
  %t101 = load i8*, i8** %l0
  %t102 = extractvalue %NativeStruct %definition, 1
  %t103 = call i8* @render_struct_repr_fields(i8* %t101, { %NativeStructField*, i64 }* null)
  store i8* %t103, i8** %l8
  %t104 = load %PythonBuilder, %PythonBuilder* %l1
  %t105 = load i8*, i8** %l8
  %t106 = call %PythonBuilder @builder_emit(%PythonBuilder %t104, i8* %t105)
  store %PythonBuilder %t106, %PythonBuilder* %l1
  %t107 = load %PythonBuilder, %PythonBuilder* %l1
  %t108 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t107)
  store %PythonBuilder %t108, %PythonBuilder* %l1
  %t109 = load i8*, i8** %l0
  %s110 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.110, i32 0, i32 0
  %t111 = icmp eq i8* %t109, %s110
  %t112 = load i8*, i8** %l0
  %t113 = load %PythonBuilder, %PythonBuilder* %l1
  %t114 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t115 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t116 = load i8*, i8** %l4
  %t117 = load i8*, i8** %l8
  br i1 %t111, label %then11, label %merge12
then11:
  %t118 = load %PythonBuilder, %PythonBuilder* %l1
  %t119 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t118)
  store %PythonBuilder %t119, %PythonBuilder* %l1
  %t120 = load %PythonBuilder, %PythonBuilder* %l1
  %s121 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.121, i32 0, i32 0
  %t122 = call %PythonBuilder @builder_emit(%PythonBuilder %t120, i8* %s121)
  store %PythonBuilder %t122, %PythonBuilder* %l1
  %t123 = load %PythonBuilder, %PythonBuilder* %l1
  %t124 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t123)
  store %PythonBuilder %t124, %PythonBuilder* %l1
  %t125 = load %PythonBuilder, %PythonBuilder* %l1
  %s126 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.126, i32 0, i32 0
  %t127 = call %PythonBuilder @builder_emit(%PythonBuilder %t125, i8* %s126)
  store %PythonBuilder %t127, %PythonBuilder* %l1
  %t128 = load %PythonBuilder, %PythonBuilder* %l1
  %s129 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.129, i32 0, i32 0
  %t130 = call %PythonBuilder @builder_emit(%PythonBuilder %t128, i8* %s129)
  store %PythonBuilder %t130, %PythonBuilder* %l1
  %t131 = load %PythonBuilder, %PythonBuilder* %l1
  %t132 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t131)
  store %PythonBuilder %t132, %PythonBuilder* %l1
  %t133 = load %PythonBuilder, %PythonBuilder* %l1
  %t134 = load %PythonBuilder, %PythonBuilder* %l1
  %t135 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t134)
  store %PythonBuilder %t135, %PythonBuilder* %l1
  %t136 = load %PythonBuilder, %PythonBuilder* %l1
  %s137 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.137, i32 0, i32 0
  %t138 = call %PythonBuilder @builder_emit(%PythonBuilder %t136, i8* %s137)
  store %PythonBuilder %t138, %PythonBuilder* %l1
  %t139 = load %PythonBuilder, %PythonBuilder* %l1
  %t140 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t139)
  store %PythonBuilder %t140, %PythonBuilder* %l1
  %t141 = load %PythonBuilder, %PythonBuilder* %l1
  %s142 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.142, i32 0, i32 0
  %t143 = call %PythonBuilder @builder_emit(%PythonBuilder %t141, i8* %s142)
  store %PythonBuilder %t143, %PythonBuilder* %l1
  %t144 = load %PythonBuilder, %PythonBuilder* %l1
  %t145 = load %PythonBuilder, %PythonBuilder* %l1
  %t146 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t145)
  store %PythonBuilder %t146, %PythonBuilder* %l1
  %t147 = load %PythonBuilder, %PythonBuilder* %l1
  %s148 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.148, i32 0, i32 0
  %t149 = call %PythonBuilder @builder_emit(%PythonBuilder %t147, i8* %s148)
  store %PythonBuilder %t149, %PythonBuilder* %l1
  %t150 = load %PythonBuilder, %PythonBuilder* %l1
  %t151 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t150)
  store %PythonBuilder %t151, %PythonBuilder* %l1
  %t152 = load %PythonBuilder, %PythonBuilder* %l1
  %t153 = load %PythonBuilder, %PythonBuilder* %l1
  %t154 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t153)
  store %PythonBuilder %t154, %PythonBuilder* %l1
  %t155 = load %PythonBuilder, %PythonBuilder* %l1
  %s156 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.156, i32 0, i32 0
  %t157 = call %PythonBuilder @builder_emit(%PythonBuilder %t155, i8* %s156)
  store %PythonBuilder %t157, %PythonBuilder* %l1
  %t158 = load %PythonBuilder, %PythonBuilder* %l1
  %t159 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t158)
  store %PythonBuilder %t159, %PythonBuilder* %l1
  br label %merge12
merge12:
  %t160 = phi %PythonBuilder [ %t119, %then11 ], [ %t113, %entry ]
  %t161 = phi %PythonBuilder [ %t122, %then11 ], [ %t113, %entry ]
  %t162 = phi %PythonBuilder [ %t124, %then11 ], [ %t113, %entry ]
  %t163 = phi %PythonBuilder [ %t127, %then11 ], [ %t113, %entry ]
  %t164 = phi %PythonBuilder [ %t130, %then11 ], [ %t113, %entry ]
  %t165 = phi %PythonBuilder [ %t132, %then11 ], [ %t113, %entry ]
  %t166 = phi %PythonBuilder [ zeroinitializer, %then11 ], [ %t113, %entry ]
  %t167 = phi %PythonBuilder [ %t135, %then11 ], [ %t113, %entry ]
  %t168 = phi %PythonBuilder [ %t138, %then11 ], [ %t113, %entry ]
  %t169 = phi %PythonBuilder [ %t140, %then11 ], [ %t113, %entry ]
  %t170 = phi %PythonBuilder [ %t143, %then11 ], [ %t113, %entry ]
  %t171 = phi %PythonBuilder [ zeroinitializer, %then11 ], [ %t113, %entry ]
  %t172 = phi %PythonBuilder [ %t146, %then11 ], [ %t113, %entry ]
  %t173 = phi %PythonBuilder [ %t149, %then11 ], [ %t113, %entry ]
  %t174 = phi %PythonBuilder [ %t151, %then11 ], [ %t113, %entry ]
  %t175 = phi %PythonBuilder [ zeroinitializer, %then11 ], [ %t113, %entry ]
  %t176 = phi %PythonBuilder [ %t154, %then11 ], [ %t113, %entry ]
  %t177 = phi %PythonBuilder [ %t157, %then11 ], [ %t113, %entry ]
  %t178 = phi %PythonBuilder [ %t159, %then11 ], [ %t113, %entry ]
  store %PythonBuilder %t160, %PythonBuilder* %l1
  store %PythonBuilder %t161, %PythonBuilder* %l1
  store %PythonBuilder %t162, %PythonBuilder* %l1
  store %PythonBuilder %t163, %PythonBuilder* %l1
  store %PythonBuilder %t164, %PythonBuilder* %l1
  store %PythonBuilder %t165, %PythonBuilder* %l1
  store %PythonBuilder %t166, %PythonBuilder* %l1
  store %PythonBuilder %t167, %PythonBuilder* %l1
  store %PythonBuilder %t168, %PythonBuilder* %l1
  store %PythonBuilder %t169, %PythonBuilder* %l1
  store %PythonBuilder %t170, %PythonBuilder* %l1
  store %PythonBuilder %t171, %PythonBuilder* %l1
  store %PythonBuilder %t172, %PythonBuilder* %l1
  store %PythonBuilder %t173, %PythonBuilder* %l1
  store %PythonBuilder %t174, %PythonBuilder* %l1
  store %PythonBuilder %t175, %PythonBuilder* %l1
  store %PythonBuilder %t176, %PythonBuilder* %l1
  store %PythonBuilder %t177, %PythonBuilder* %l1
  store %PythonBuilder %t178, %PythonBuilder* %l1
  %t179 = extractvalue %NativeStruct %definition, 2
  %t180 = load { i8**, i64 }, { i8**, i64 }* %t179
  %t181 = extractvalue { i8**, i64 } %t180, 1
  %t182 = icmp sgt i64 %t181, 0
  %t183 = load i8*, i8** %l0
  %t184 = load %PythonBuilder, %PythonBuilder* %l1
  %t185 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t186 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t187 = load i8*, i8** %l4
  %t188 = load i8*, i8** %l8
  br i1 %t182, label %then13, label %merge14
then13:
  %t189 = load %PythonBuilder, %PythonBuilder* %l1
  %t190 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t189)
  store %PythonBuilder %t190, %PythonBuilder* %l1
  %t191 = sitofp i64 0 to double
  store double %t191, double* %l9
  %t192 = load i8*, i8** %l0
  %t193 = load %PythonBuilder, %PythonBuilder* %l1
  %t194 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t195 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t196 = load i8*, i8** %l4
  %t197 = load i8*, i8** %l8
  %t198 = load double, double* %l9
  br label %loop.header15
loop.header15:
  %t254 = phi %PythonBuilder [ %t193, %then13 ], [ %t251, %loop.latch17 ]
  %t255 = phi { i8**, i64 }* [ %t194, %then13 ], [ %t252, %loop.latch17 ]
  %t256 = phi double [ %t198, %then13 ], [ %t253, %loop.latch17 ]
  store %PythonBuilder %t254, %PythonBuilder* %l1
  store { i8**, i64 }* %t255, { i8**, i64 }** %l2
  store double %t256, double* %l9
  br label %loop.body16
loop.body16:
  %t199 = load double, double* %l9
  %t200 = extractvalue %NativeStruct %definition, 2
  %t201 = load { i8**, i64 }, { i8**, i64 }* %t200
  %t202 = extractvalue { i8**, i64 } %t201, 1
  %t203 = sitofp i64 %t202 to double
  %t204 = fcmp oge double %t199, %t203
  %t205 = load i8*, i8** %l0
  %t206 = load %PythonBuilder, %PythonBuilder* %l1
  %t207 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t208 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t209 = load i8*, i8** %l4
  %t210 = load i8*, i8** %l8
  %t211 = load double, double* %l9
  br i1 %t204, label %then19, label %merge20
then19:
  br label %afterloop18
merge20:
  %t212 = extractvalue %NativeStruct %definition, 2
  %t213 = load double, double* %l9
  %t214 = load { i8**, i64 }, { i8**, i64 }* %t212
  %t215 = extractvalue { i8**, i64 } %t214, 0
  %t216 = extractvalue { i8**, i64 } %t214, 1
  %t217 = icmp uge i64 %t213, %t216
  ; bounds check: %t217 (if true, out of bounds)
  %t218 = getelementptr i8*, i8** %t215, i64 %t213
  %t219 = load i8*, i8** %t218
  store i8* %t219, i8** %l10
  %t220 = load %PythonBuilder, %PythonBuilder* %l1
  %t221 = load i8*, i8** %l10
  %t222 = call %PythonFunctionEmission @emit_python_function(%PythonBuilder %t220, %NativeFunction zeroinitializer)
  store %PythonFunctionEmission %t222, %PythonFunctionEmission* %l11
  %t223 = load %PythonFunctionEmission, %PythonFunctionEmission* %l11
  %t224 = extractvalue %PythonFunctionEmission %t223, 0
  store %PythonBuilder zeroinitializer, %PythonBuilder* %l1
  %t225 = load %PythonFunctionEmission, %PythonFunctionEmission* %l11
  %t226 = extractvalue %PythonFunctionEmission %t225, 1
  %t227 = call double @diagnosticsconcat({ i8**, i64 }* %t226)
  store { i8**, i64 }* null, { i8**, i64 }** %l2
  %t228 = load double, double* %l9
  %t229 = sitofp i64 1 to double
  %t230 = fadd double %t228, %t229
  %t231 = extractvalue %NativeStruct %definition, 2
  %t232 = load { i8**, i64 }, { i8**, i64 }* %t231
  %t233 = extractvalue { i8**, i64 } %t232, 1
  %t234 = sitofp i64 %t233 to double
  %t235 = fcmp olt double %t230, %t234
  %t236 = load i8*, i8** %l0
  %t237 = load %PythonBuilder, %PythonBuilder* %l1
  %t238 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t239 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t240 = load i8*, i8** %l4
  %t241 = load i8*, i8** %l8
  %t242 = load double, double* %l9
  %t243 = load i8*, i8** %l10
  %t244 = load %PythonFunctionEmission, %PythonFunctionEmission* %l11
  br i1 %t235, label %then21, label %merge22
then21:
  %t245 = load %PythonBuilder, %PythonBuilder* %l1
  %t246 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t245)
  store %PythonBuilder %t246, %PythonBuilder* %l1
  br label %merge22
merge22:
  %t247 = phi %PythonBuilder [ %t246, %then21 ], [ %t237, %loop.body16 ]
  store %PythonBuilder %t247, %PythonBuilder* %l1
  %t248 = load double, double* %l9
  %t249 = sitofp i64 1 to double
  %t250 = fadd double %t248, %t249
  store double %t250, double* %l9
  br label %loop.latch17
loop.latch17:
  %t251 = load %PythonBuilder, %PythonBuilder* %l1
  %t252 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t253 = load double, double* %l9
  br label %loop.header15
afterloop18:
  br label %merge14
merge14:
  %t257 = phi %PythonBuilder [ %t190, %then13 ], [ %t184, %entry ]
  %t258 = phi %PythonBuilder [ zeroinitializer, %then13 ], [ %t184, %entry ]
  %t259 = phi { i8**, i64 }* [ null, %then13 ], [ %t185, %entry ]
  %t260 = phi %PythonBuilder [ %t246, %then13 ], [ %t184, %entry ]
  store %PythonBuilder %t257, %PythonBuilder* %l1
  store %PythonBuilder %t258, %PythonBuilder* %l1
  store { i8**, i64 }* %t259, { i8**, i64 }** %l2
  store %PythonBuilder %t260, %PythonBuilder* %l1
  %t261 = load %PythonBuilder, %PythonBuilder* %l1
  %t262 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t261)
  store %PythonBuilder %t262, %PythonBuilder* %l1
  %t263 = load %PythonBuilder, %PythonBuilder* %l1
  %t264 = insertvalue %PythonStructEmission undef, i8* null, 0
  %t265 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t266 = insertvalue %PythonStructEmission %t264, { i8**, i64 }* %t265, 1
  ret %PythonStructEmission %t266
}

define { i8**, i64 }* @render_struct_parameters({ %NativeStructField*, i64 }* %fields) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca %NativeStructField
  %l4 = alloca i8*
  %l5 = alloca i8*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = alloca [0 x double]
  %t6 = getelementptr [0 x double], [0 x double]* %t5, i32 0, i32 0
  %t7 = alloca { double*, i64 }
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 0
  store double* %t6, double** %t8
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t10 = sitofp i64 0 to double
  store double %t10, double* %l2
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t12 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t13 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t60 = phi { i8**, i64 }* [ %t12, %entry ], [ %t57, %loop.latch2 ]
  %t61 = phi { i8**, i64 }* [ %t11, %entry ], [ %t58, %loop.latch2 ]
  %t62 = phi double [ %t13, %entry ], [ %t59, %loop.latch2 ]
  store { i8**, i64 }* %t60, { i8**, i64 }** %l1
  store { i8**, i64 }* %t61, { i8**, i64 }** %l0
  store double %t62, double* %l2
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
  %t23 = load { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %fields
  %t24 = extractvalue { %NativeStructField*, i64 } %t23, 0
  %t25 = extractvalue { %NativeStructField*, i64 } %t23, 1
  %t26 = icmp uge i64 %t22, %t25
  ; bounds check: %t26 (if true, out of bounds)
  %t27 = getelementptr %NativeStructField, %NativeStructField* %t24, i64 %t22
  %t28 = load %NativeStructField, %NativeStructField* %t27
  store %NativeStructField %t28, %NativeStructField* %l3
  %t29 = load %NativeStructField, %NativeStructField* %l3
  %t30 = extractvalue %NativeStructField %t29, 0
  %t31 = call i8* @sanitize_identifier(i8* %t30)
  store i8* %t31, i8** %l4
  %t32 = load i8*, i8** %l4
  store i8* %t32, i8** %l5
  %t33 = load %NativeStructField, %NativeStructField* %l3
  %t34 = extractvalue %NativeStructField %t33, 1
  %t35 = call i1 @is_optional_type(i8* %t34)
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t38 = load double, double* %l2
  %t39 = load %NativeStructField, %NativeStructField* %l3
  %t40 = load i8*, i8** %l4
  %t41 = load i8*, i8** %l5
  br i1 %t35, label %then6, label %else7
then6:
  %t42 = load i8*, i8** %l5
  %s43 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.43, i32 0, i32 0
  %t44 = add i8* %t42, %s43
  store i8* %t44, i8** %l5
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t46 = load i8*, i8** %l5
  %t47 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t45, i8* %t46)
  store { i8**, i64 }* %t47, { i8**, i64 }** %l1
  br label %merge8
else7:
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t49 = load i8*, i8** %l5
  %t50 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t48, i8* %t49)
  store { i8**, i64 }* %t50, { i8**, i64 }** %l0
  br label %merge8
merge8:
  %t51 = phi i8* [ %t44, %then6 ], [ %t41, %else7 ]
  %t52 = phi { i8**, i64 }* [ %t47, %then6 ], [ %t37, %else7 ]
  %t53 = phi { i8**, i64 }* [ %t36, %then6 ], [ %t50, %else7 ]
  store i8* %t51, i8** %l5
  store { i8**, i64 }* %t52, { i8**, i64 }** %l1
  store { i8**, i64 }* %t53, { i8**, i64 }** %l0
  %t54 = load double, double* %l2
  %t55 = sitofp i64 1 to double
  %t56 = fadd double %t54, %t55
  store double %t56, double* %l2
  br label %loop.latch2
loop.latch2:
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t59 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t64 = call double @requiredconcat({ i8**, i64 }* %t63)
  ret { i8**, i64 }* null
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
  %s3 = getelementptr inbounds [53 x i8], [53 x i8]* @.str.3, i32 0, i32 0
  ret i8* %s3
merge1:
  %t4 = alloca [0 x double]
  %t5 = getelementptr [0 x double], [0 x double]* %t4, i32 0, i32 0
  %t6 = alloca { double*, i64 }
  %t7 = getelementptr { double*, i64 }, { double*, i64 }* %t6, i32 0, i32 0
  store double* %t5, double** %t7
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t6, i32 0, i32 1
  store i64 0, i64* %t8
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t9 = sitofp i64 0 to double
  store double %t9, double* %l1
  %t10 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t11 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t37 = phi { i8**, i64 }* [ %t10, %entry ], [ %t35, %loop.latch4 ]
  %t38 = phi double [ %t11, %entry ], [ %t36, %loop.latch4 ]
  store { i8**, i64 }* %t37, { i8**, i64 }** %l0
  store double %t38, double* %l1
  br label %loop.body3
loop.body3:
  %t12 = load double, double* %l1
  %t13 = load { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %fields
  %t14 = extractvalue { %NativeStructField*, i64 } %t13, 1
  %t15 = sitofp i64 %t14 to double
  %t16 = fcmp oge double %t12, %t15
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = load double, double* %l1
  br i1 %t16, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t19 = load double, double* %l1
  %t20 = load { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %fields
  %t21 = extractvalue { %NativeStructField*, i64 } %t20, 0
  %t22 = extractvalue { %NativeStructField*, i64 } %t20, 1
  %t23 = icmp uge i64 %t19, %t22
  ; bounds check: %t23 (if true, out of bounds)
  %t24 = getelementptr %NativeStructField, %NativeStructField* %t21, i64 %t19
  %t25 = load %NativeStructField, %NativeStructField* %t24
  store %NativeStructField %t25, %NativeStructField* %l2
  %t26 = load %NativeStructField, %NativeStructField* %l2
  %t27 = extractvalue %NativeStructField %t26, 0
  %t28 = call i8* @sanitize_identifier(i8* %t27)
  store i8* %t28, i8** %l3
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s30 = getelementptr inbounds [56 x i8], [56 x i8]* @.str.30, i32 0, i32 0
  %t31 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t29, i8* %s30)
  store { i8**, i64 }* %t31, { i8**, i64 }** %l0
  %t32 = load double, double* %l1
  %t33 = sitofp i64 1 to double
  %t34 = fadd double %t32, %t33
  store double %t34, double* %l1
  br label %loop.latch4
loop.latch4:
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t36 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %s39 = getelementptr inbounds [96 x i8], [96 x i8]* @.str.39, i32 0, i32 0
  ret i8* %s39
}

define i1 @is_optional_type(i8* %type_annotation) {
entry:
  %l0 = alloca i8*
  %t0 = call i8* @trim_text(i8* %type_annotation)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = load i8*, i8** %l0
  %t3 = call i1 @ends_with(i8* %t2, i8* null)
  ret i1 %t3
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
  %t5 = load i8*, i8** %l0
  %t6 = call double @rewrite_interpolated_string_literal(i8* %t5)
  store double %t6, double* %l1
  %t7 = load double, double* %l1
  %t8 = load i8*, i8** %l0
  %t9 = call double @lower_struct_literal_expression(i8* %t8, double %depth)
  store double %t9, double* %l2
  %t10 = load double, double* %l2
  %t11 = load i8*, i8** %l0
  %t12 = call double @lower_array_literal_expression(i8* %t11, double %depth)
  store double %t12, double* %l3
  %t13 = load double, double* %l3
  %t14 = load i8*, i8** %l0
  %t15 = call i8* @rewrite_expression_intrinsics(i8* %t14)
  store i8* %t15, i8** %l4
  %t16 = load i8*, i8** %l4
  %t17 = call i8* @rewrite_array_literals_inline(i8* %t16, double %depth)
  store i8* %t17, i8** %l5
  %t18 = load i8*, i8** %l5
  %t19 = call i8* @rewrite_struct_literals_inline(i8* %t18, double %depth)
  ret i8* %t19
}

define i8* @decode_escape_sequence(i8* %escape, i8* %quote) {
entry:
  %t0 = getelementptr i8, i8* %escape, i64 0
  %t1 = load i8, i8* %t0
  %t2 = icmp eq i8 %t1, 110
  br i1 %t2, label %then0, label %merge1
then0:
  ret i8* null
merge1:
  %t3 = getelementptr i8, i8* %escape, i64 0
  %t4 = load i8, i8* %t3
  %t5 = icmp eq i8 %t4, 114
  br i1 %t5, label %then2, label %merge3
then2:
  ret i8* null
merge3:
  %t6 = getelementptr i8, i8* %escape, i64 0
  %t7 = load i8, i8* %t6
  %t8 = icmp eq i8 %t7, 116
  br i1 %t8, label %then4, label %merge5
then4:
  ret i8* null
merge5:
  %t9 = getelementptr i8, i8* %escape, i64 0
  %t10 = load i8, i8* %t9
  %t11 = icmp eq i8 %t10, 92
  br i1 %t11, label %then6, label %merge7
then6:
  ret i8* null
merge7:
  %t12 = icmp eq i8* %escape, %quote
  br i1 %t12, label %then8, label %merge9
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
  %t68 = phi i8 [ %t0, %entry ], [ %t66, %loop.latch2 ]
  %t69 = phi i64 [ %t1, %entry ], [ %t67, %loop.latch2 ]
  store i8 %t68, i8* %l0
  store i64 %t69, i64* %l1
  br label %loop.body1
loop.body1:
  %t2 = load i64, i64* %l1
  %t3 = load i64, i64* %l1
  %t4 = getelementptr i8, i8* %value, i64 %t3
  %t5 = load i8, i8* %t4
  store i8 %t5, i8* %l2
  %t6 = load i8, i8* %l2
  %t7 = icmp eq i8 %t6, 92
  %t8 = load i8, i8* %l0
  %t9 = load i64, i64* %l1
  %t10 = load i8, i8* %l2
  br i1 %t7, label %then4, label %else5
then4:
  %t11 = load i8, i8* %l0
  %s12 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.12, i32 0, i32 0
  %t13 = getelementptr i8, i8* %s12, i64 0
  %t14 = load i8, i8* %t13
  %t15 = add i8 %t11, %t14
  store i8 %t15, i8* %l0
  br label %merge6
else5:
  %t16 = load i8, i8* %l2
  %t17 = icmp eq i8 %t16, 39
  %t18 = load i8, i8* %l0
  %t19 = load i64, i64* %l1
  %t20 = load i8, i8* %l2
  br i1 %t17, label %then7, label %else8
then7:
  %t21 = load i8, i8* %l0
  %s22 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.22, i32 0, i32 0
  %t23 = getelementptr i8, i8* %s22, i64 0
  %t24 = load i8, i8* %t23
  %t25 = add i8 %t21, %t24
  store i8 %t25, i8* %l0
  br label %merge9
else8:
  %t26 = load i8, i8* %l2
  %t27 = icmp eq i8 %t26, 10
  %t28 = load i8, i8* %l0
  %t29 = load i64, i64* %l1
  %t30 = load i8, i8* %l2
  br i1 %t27, label %then10, label %else11
then10:
  %t31 = load i8, i8* %l0
  %s32 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.32, i32 0, i32 0
  %t33 = getelementptr i8, i8* %s32, i64 0
  %t34 = load i8, i8* %t33
  %t35 = add i8 %t31, %t34
  store i8 %t35, i8* %l0
  br label %merge12
else11:
  %t36 = load i8, i8* %l2
  %t37 = icmp eq i8 %t36, 13
  %t38 = load i8, i8* %l0
  %t39 = load i64, i64* %l1
  %t40 = load i8, i8* %l2
  br i1 %t37, label %then13, label %else14
then13:
  %t41 = load i8, i8* %l0
  %s42 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.42, i32 0, i32 0
  %t43 = getelementptr i8, i8* %s42, i64 0
  %t44 = load i8, i8* %t43
  %t45 = add i8 %t41, %t44
  store i8 %t45, i8* %l0
  br label %merge15
else14:
  %t46 = load i8, i8* %l2
  %t47 = icmp eq i8 %t46, 9
  %t48 = load i8, i8* %l0
  %t49 = load i64, i64* %l1
  %t50 = load i8, i8* %l2
  br i1 %t47, label %then16, label %else17
then16:
  %t51 = load i8, i8* %l0
  %s52 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.52, i32 0, i32 0
  %t53 = getelementptr i8, i8* %s52, i64 0
  %t54 = load i8, i8* %t53
  %t55 = add i8 %t51, %t54
  store i8 %t55, i8* %l0
  br label %merge18
else17:
  %t56 = load i8, i8* %l0
  %t57 = load i8, i8* %l2
  %t58 = add i8 %t56, %t57
  store i8 %t58, i8* %l0
  br label %merge18
merge18:
  %t59 = phi i8 [ %t55, %then16 ], [ %t58, %else17 ]
  store i8 %t59, i8* %l0
  br label %merge15
merge15:
  %t60 = phi i8 [ %t45, %then13 ], [ %t55, %else14 ]
  store i8 %t60, i8* %l0
  br label %merge12
merge12:
  %t61 = phi i8 [ %t35, %then10 ], [ %t45, %else11 ]
  store i8 %t61, i8* %l0
  br label %merge9
merge9:
  %t62 = phi i8 [ %t25, %then7 ], [ %t35, %else8 ]
  store i8 %t62, i8* %l0
  br label %merge6
merge6:
  %t63 = phi i8 [ %t15, %then4 ], [ %t25, %else5 ]
  store i8 %t63, i8* %l0
  %t64 = load i64, i64* %l1
  %t65 = add i64 %t64, 1
  store i64 %t65, i64* %l1
  br label %loop.latch2
loop.latch2:
  %t66 = load i8, i8* %l0
  %t67 = load i64, i64* %l1
  br label %loop.header0
afterloop3:
  %t70 = load i8, i8* %l0
  %t71 = add i8 %t70, 39
  store i8 %t71, i8* %l0
  %t72 = load i8, i8* %l0
  ret i8* null
}

define double @find_substring(i8* %value, i8* %pattern) {
entry:
  %l0 = alloca i64
  %l1 = alloca i1
  %l2 = alloca i64
  store i64 0, i64* %l0
  %t0 = load i64, i64* %l0
  br label %loop.header0
loop.header0:
  %t19 = phi i64 [ %t0, %entry ], [ %t18, %loop.latch2 ]
  store i64 %t19, i64* %l0
  br label %loop.body1
loop.body1:
  %t1 = load i64, i64* %l0
  store i1 1, i1* %l1
  store i64 0, i64* %l2
  %t2 = load i64, i64* %l0
  %t3 = load i1, i1* %l1
  %t4 = load i64, i64* %l2
  br label %loop.header4
loop.header4:
  %t9 = phi i64 [ %t4, %loop.body1 ], [ %t8, %loop.latch6 ]
  store i64 %t9, i64* %l2
  br label %loop.body5
loop.body5:
  %t5 = load i64, i64* %l2
  %t6 = load i64, i64* %l2
  %t7 = add i64 %t6, 1
  store i64 %t7, i64* %l2
  br label %loop.latch6
loop.latch6:
  %t8 = load i64, i64* %l2
  br label %loop.header4
afterloop7:
  %t10 = load i1, i1* %l1
  %t11 = load i64, i64* %l0
  %t12 = load i1, i1* %l1
  %t13 = load i64, i64* %l2
  br i1 %t10, label %then8, label %merge9
then8:
  %t14 = load i64, i64* %l0
  %t15 = sitofp i64 %t14 to double
  ret double %t15
merge9:
  %t16 = load i64, i64* %l0
  %t17 = add i64 %t16, 1
  store i64 %t17, i64* %l0
  br label %loop.latch2
loop.latch2:
  %t18 = load i64, i64* %l0
  br label %loop.header0
afterloop3:
  %t20 = sitofp i64 -1 to double
  ret double %t20
}

define i1 @is_struct_literal_type_candidate(i8* %text) {
entry:
  %l0 = alloca double
  %l1 = alloca i8
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t21 = phi double [ %t1, %entry ], [ %t20, %loop.latch2 ]
  store double %t21, double* %l0
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  %t3 = load double, double* %l0
  %t4 = getelementptr i8, i8* %text, i64 %t3
  %t5 = load i8, i8* %t4
  store i8 %t5, i8* %l1
  %t6 = load i8, i8* %l1
  %t7 = icmp eq i8 %t6, 46
  %t8 = load double, double* %l0
  %t9 = load i8, i8* %l1
  br i1 %t7, label %then4, label %merge5
then4:
  %t10 = load double, double* %l0
  %t11 = sitofp i64 1 to double
  %t12 = fadd double %t10, %t11
  store double %t12, double* %l0
  br label %loop.latch2
merge5:
  %t13 = load i8, i8* %l1
  %t14 = call i1 @is_identifier_char(i8* null)
  %t15 = load double, double* %l0
  %t16 = load i8, i8* %l1
  br i1 %t14, label %then6, label %merge7
then6:
  %t17 = load double, double* %l0
  %t18 = sitofp i64 1 to double
  %t19 = fadd double %t17, %t18
  store double %t19, double* %l0
  br label %loop.latch2
merge7:
  ret i1 0
loop.latch2:
  %t20 = load double, double* %l0
  br label %loop.header0
afterloop3:
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
  %l1 = alloca double
  %t0 = call i8* @trim_text(i8* %entry)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = load i8*, i8** %l0
  %s3 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.3, i32 0, i32 0
  %t4 = call i1 @starts_with(i8* %t2, i8* %s3)
  %t5 = xor i1 %t4, 1
  %t6 = load i8*, i8** %l0
  br i1 %t5, label %then0, label %merge1
then0:
  ret i1 0
merge1:
  %t7 = load i8*, i8** %l0
  %t8 = load i8*, i8** %l0
  store double 0.0, double* %l1
  %t9 = load double, double* %l1
  ret i1 false
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
  %l7 = alloca double
  store i8* %expression, i8** %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load i8*, i8** %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t52 = phi i8* [ %t1, %entry ], [ %t50, %loop.latch2 ]
  %t53 = phi double [ %t2, %entry ], [ %t51, %loop.latch2 ]
  store i8* %t52, i8** %l0
  store double %t53, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load i8*, i8** %l0
  %t5 = load i8*, i8** %l0
  %t6 = load double, double* %l1
  %t7 = call double @find_next_square_open(i8* %t5, double %t6)
  store double %t7, double* %l2
  %t8 = load double, double* %l2
  %t9 = sitofp i64 0 to double
  %t10 = fcmp olt double %t8, %t9
  %t11 = load i8*, i8** %l0
  %t12 = load double, double* %l1
  %t13 = load double, double* %l2
  br i1 %t10, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t14 = load i8*, i8** %l0
  %t15 = load double, double* %l2
  %t16 = call double @find_matching_square(i8* %t14, double %t15)
  store double %t16, double* %l3
  %t17 = load double, double* %l3
  %t18 = sitofp i64 0 to double
  %t19 = fcmp olt double %t17, %t18
  %t20 = load i8*, i8** %l0
  %t21 = load double, double* %l1
  %t22 = load double, double* %l2
  %t23 = load double, double* %l3
  br i1 %t19, label %then6, label %merge7
then6:
  br label %afterloop3
merge7:
  %t24 = load i8*, i8** %l0
  %t25 = load double, double* %l2
  %t26 = load double, double* %l3
  %t27 = sitofp i64 1 to double
  %t28 = fadd double %t26, %t27
  %t29 = fptosi double %t25 to i64
  %t30 = fptosi double %t28 to i64
  %t31 = call i8* @sailfin_runtime_substring(i8* %t24, i64 %t29, i64 %t30)
  store i8* %t31, i8** %l4
  %t32 = load i8*, i8** %l4
  %t33 = sitofp i64 1 to double
  %t34 = fadd double %depth, %t33
  %t35 = call double @lower_array_literal_expression(i8* %t32, double %t34)
  store double %t35, double* %l5
  %t36 = load double, double* %l5
  %t37 = load i8*, i8** %l0
  %t38 = load double, double* %l2
  %t39 = fptosi double %t38 to i64
  %t40 = call i8* @sailfin_runtime_substring(i8* %t37, i64 0, i64 %t39)
  store i8* %t40, i8** %l6
  %t41 = load i8*, i8** %l0
  %t42 = load double, double* %l3
  %t43 = sitofp i64 1 to double
  %t44 = fadd double %t42, %t43
  %t45 = load i8*, i8** %l0
  store double 0.0, double* %l7
  %t46 = load i8*, i8** %l6
  %t47 = load double, double* %l5
  %t48 = load double, double* %l2
  %t49 = load double, double* %l5
  br label %loop.latch2
loop.latch2:
  %t50 = load i8*, i8** %l0
  %t51 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t54 = load i8*, i8** %l0
  ret i8* %t54
}

define i8* @rewrite_struct_literals_inline(i8* %expression, double %depth) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca i8*
  %l8 = alloca double
  %l9 = alloca double
  %l10 = alloca i8*
  %l11 = alloca double
  %l12 = alloca i8*
  %l13 = alloca double
  store i8* %expression, i8** %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load i8*, i8** %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t147 = phi double [ %t2, %entry ], [ %t145, %loop.latch2 ]
  %t148 = phi i8* [ %t1, %entry ], [ %t146, %loop.latch2 ]
  store double %t147, double* %l1
  store i8* %t148, i8** %l0
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load i8*, i8** %l0
  %t5 = load i8*, i8** %l0
  store double 0.0, double* %l2
  %t6 = load double, double* %l2
  %t7 = sitofp i64 0 to double
  %t8 = fcmp olt double %t6, %t7
  %t9 = load i8*, i8** %l0
  %t10 = load double, double* %l1
  %t11 = load double, double* %l2
  br i1 %t8, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t12 = load double, double* %l2
  store double %t12, double* %l3
  %t13 = load i8*, i8** %l0
  %t14 = load double, double* %l1
  %t15 = load double, double* %l2
  %t16 = load double, double* %l3
  br label %loop.header6
loop.header6:
  %t35 = phi double [ %t16, %loop.body1 ], [ %t34, %loop.latch8 ]
  store double %t35, double* %l3
  br label %loop.body7
loop.body7:
  %t17 = load double, double* %l3
  %t18 = sitofp i64 0 to double
  %t19 = fcmp ole double %t17, %t18
  %t20 = load i8*, i8** %l0
  %t21 = load double, double* %l1
  %t22 = load double, double* %l2
  %t23 = load double, double* %l3
  br i1 %t19, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  store double 0.0, double* %l4
  %t24 = load double, double* %l4
  %t25 = call i1 @sailfin_runtime_is_whitespace_char(i8* null)
  %t26 = load i8*, i8** %l0
  %t27 = load double, double* %l1
  %t28 = load double, double* %l2
  %t29 = load double, double* %l3
  %t30 = load double, double* %l4
  br i1 %t25, label %then12, label %merge13
then12:
  %t31 = load double, double* %l3
  %t32 = sitofp i64 1 to double
  %t33 = fsub double %t31, %t32
  store double %t33, double* %l3
  br label %loop.latch8
merge13:
  br label %afterloop9
loop.latch8:
  %t34 = load double, double* %l3
  br label %loop.header6
afterloop9:
  %t36 = load double, double* %l3
  store double %t36, double* %l5
  %t37 = load i8*, i8** %l0
  %t38 = load double, double* %l1
  %t39 = load double, double* %l2
  %t40 = load double, double* %l3
  %t41 = load double, double* %l5
  br label %loop.header14
loop.header14:
  %t63 = phi double [ %t41, %loop.body1 ], [ %t62, %loop.latch16 ]
  store double %t63, double* %l5
  br label %loop.body15
loop.body15:
  %t42 = load double, double* %l5
  %t43 = sitofp i64 0 to double
  %t44 = fcmp ole double %t42, %t43
  %t45 = load i8*, i8** %l0
  %t46 = load double, double* %l1
  %t47 = load double, double* %l2
  %t48 = load double, double* %l3
  %t49 = load double, double* %l5
  br i1 %t44, label %then18, label %merge19
then18:
  br label %afterloop17
merge19:
  store double 0.0, double* %l6
  %t50 = load double, double* %l6
  %t51 = load double, double* %l6
  %t52 = call i1 @is_identifier_char(i8* null)
  %t53 = load i8*, i8** %l0
  %t54 = load double, double* %l1
  %t55 = load double, double* %l2
  %t56 = load double, double* %l3
  %t57 = load double, double* %l5
  %t58 = load double, double* %l6
  br i1 %t52, label %then20, label %merge21
then20:
  %t59 = load double, double* %l5
  %t60 = sitofp i64 1 to double
  %t61 = fsub double %t59, %t60
  store double %t61, double* %l5
  br label %loop.latch16
merge21:
  br label %afterloop17
loop.latch16:
  %t62 = load double, double* %l5
  br label %loop.header14
afterloop17:
  %t64 = load double, double* %l5
  %t65 = load double, double* %l3
  %t66 = fcmp oeq double %t64, %t65
  %t67 = load i8*, i8** %l0
  %t68 = load double, double* %l1
  %t69 = load double, double* %l2
  %t70 = load double, double* %l3
  %t71 = load double, double* %l5
  br i1 %t66, label %then22, label %merge23
then22:
  %t72 = load double, double* %l2
  %t73 = sitofp i64 1 to double
  %t74 = fadd double %t72, %t73
  store double %t74, double* %l1
  br label %loop.latch2
merge23:
  %t75 = load i8*, i8** %l0
  %t76 = load double, double* %l5
  %t77 = load double, double* %l3
  %t78 = fptosi double %t76 to i64
  %t79 = fptosi double %t77 to i64
  %t80 = call i8* @sailfin_runtime_substring(i8* %t75, i64 %t78, i64 %t79)
  store i8* %t80, i8** %l7
  %t81 = load i8*, i8** %l7
  %t82 = call i1 @is_struct_literal_type_candidate(i8* %t81)
  %t83 = xor i1 %t82, 1
  %t84 = load i8*, i8** %l0
  %t85 = load double, double* %l1
  %t86 = load double, double* %l2
  %t87 = load double, double* %l3
  %t88 = load double, double* %l5
  %t89 = load i8*, i8** %l7
  br i1 %t83, label %then24, label %merge25
then24:
  %t90 = load double, double* %l2
  %t91 = sitofp i64 1 to double
  %t92 = fadd double %t90, %t91
  store double %t92, double* %l1
  br label %loop.latch2
merge25:
  %t93 = load double, double* %l5
  %t94 = sitofp i64 0 to double
  %t95 = fcmp ogt double %t93, %t94
  %t96 = load i8*, i8** %l0
  %t97 = load double, double* %l1
  %t98 = load double, double* %l2
  %t99 = load double, double* %l3
  %t100 = load double, double* %l5
  %t101 = load i8*, i8** %l7
  br i1 %t95, label %then26, label %merge27
then26:
  store double 0.0, double* %l8
  %t103 = load double, double* %l8
  %t104 = call i1 @is_identifier_char(i8* null)
  br label %logical_or_entry_102

logical_or_entry_102:
  br i1 %t104, label %logical_or_merge_102, label %logical_or_right_102

logical_or_right_102:
  %t105 = load double, double* %l8
  br label %merge27
merge27:
  %t106 = load i8*, i8** %l0
  %t107 = load double, double* %l2
  %t108 = call double @find_matching_brace(i8* %t106, double %t107)
  store double %t108, double* %l9
  %t109 = load double, double* %l9
  %t110 = sitofp i64 0 to double
  %t111 = fcmp olt double %t109, %t110
  %t112 = load i8*, i8** %l0
  %t113 = load double, double* %l1
  %t114 = load double, double* %l2
  %t115 = load double, double* %l3
  %t116 = load double, double* %l5
  %t117 = load i8*, i8** %l7
  %t118 = load double, double* %l9
  br i1 %t111, label %then28, label %merge29
then28:
  br label %afterloop3
merge29:
  %t119 = load i8*, i8** %l0
  %t120 = load double, double* %l5
  %t121 = load double, double* %l9
  %t122 = sitofp i64 1 to double
  %t123 = fadd double %t121, %t122
  %t124 = fptosi double %t120 to i64
  %t125 = fptosi double %t123 to i64
  %t126 = call i8* @sailfin_runtime_substring(i8* %t119, i64 %t124, i64 %t125)
  store i8* %t126, i8** %l10
  %t127 = load i8*, i8** %l10
  %t128 = sitofp i64 1 to double
  %t129 = fadd double %depth, %t128
  %t130 = call double @lower_struct_literal_expression(i8* %t127, double %t129)
  store double %t130, double* %l11
  %t131 = load double, double* %l11
  %t132 = load i8*, i8** %l0
  %t133 = load double, double* %l5
  %t134 = fptosi double %t133 to i64
  %t135 = call i8* @sailfin_runtime_substring(i8* %t132, i64 0, i64 %t134)
  store i8* %t135, i8** %l12
  %t136 = load i8*, i8** %l0
  %t137 = load double, double* %l9
  %t138 = sitofp i64 1 to double
  %t139 = fadd double %t137, %t138
  %t140 = load i8*, i8** %l0
  store double 0.0, double* %l13
  %t141 = load i8*, i8** %l12
  %t142 = load double, double* %l11
  %t143 = load double, double* %l5
  %t144 = load double, double* %l11
  br label %loop.latch2
loop.latch2:
  %t145 = load double, double* %l1
  %t146 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t149 = load i8*, i8** %l0
  ret i8* %t149
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
  %t2 = call i1 @ends_with(i8* %t1, i8* null)
  %t3 = xor i1 %t2, 1
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = load i8*, i8** %l0
  %t6 = insertvalue %StructLiteralCapture undef, i8* %t5, 0
  %t7 = sitofp i64 0 to double
  %t8 = insertvalue %StructLiteralCapture %t6, double %t7, 1
  %t9 = insertvalue %StructLiteralCapture %t8, i1 0, 2
  ret %StructLiteralCapture %t9
merge1:
  %t10 = load i8*, i8** %l0
  store i8* %t10, i8** %l1
  store double %start_index, double* %l2
  %t11 = sitofp i64 0 to double
  store double %t11, double* %l3
  %t12 = load i8*, i8** %l0
  %t13 = call double @compute_brace_balance(i8* %t12)
  store double %t13, double* %l4
  %t14 = load double, double* %l4
  %t15 = sitofp i64 0 to double
  %t16 = fcmp ole double %t14, %t15
  %t17 = load i8*, i8** %l0
  %t18 = load i8*, i8** %l1
  %t19 = load double, double* %l2
  %t20 = load double, double* %l3
  %t21 = load double, double* %l4
  br i1 %t16, label %then2, label %merge3
then2:
  %t22 = load i8*, i8** %l0
  %t23 = insertvalue %StructLiteralCapture undef, i8* %t22, 0
  %t24 = sitofp i64 0 to double
  %t25 = insertvalue %StructLiteralCapture %t23, double %t24, 1
  %t26 = insertvalue %StructLiteralCapture %t25, i1 0, 2
  ret %StructLiteralCapture %t26
merge3:
  %t27 = load i8*, i8** %l0
  %t28 = load i8*, i8** %l1
  %t29 = load double, double* %l2
  %t30 = load double, double* %l3
  %t31 = load double, double* %l4
  br label %loop.header4
loop.header4:
  %t145 = phi double [ %t31, %entry ], [ %t142, %loop.latch6 ]
  %t146 = phi double [ %t30, %entry ], [ %t143, %loop.latch6 ]
  %t147 = phi double [ %t29, %entry ], [ %t144, %loop.latch6 ]
  store double %t145, double* %l4
  store double %t146, double* %l3
  store double %t147, double* %l2
  br label %loop.body5
loop.body5:
  %t32 = load double, double* %l2
  %t33 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %instructions
  %t34 = extractvalue { %NativeInstruction*, i64 } %t33, 1
  %t35 = sitofp i64 %t34 to double
  %t36 = fcmp oge double %t32, %t35
  %t37 = load i8*, i8** %l0
  %t38 = load i8*, i8** %l1
  %t39 = load double, double* %l2
  %t40 = load double, double* %l3
  %t41 = load double, double* %l4
  br i1 %t36, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t42 = load double, double* %l2
  %t43 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %instructions
  %t44 = extractvalue { %NativeInstruction*, i64 } %t43, 0
  %t45 = extractvalue { %NativeInstruction*, i64 } %t43, 1
  %t46 = icmp uge i64 %t42, %t45
  ; bounds check: %t46 (if true, out of bounds)
  %t47 = getelementptr %NativeInstruction, %NativeInstruction* %t44, i64 %t42
  %t48 = load %NativeInstruction, %NativeInstruction* %t47
  store %NativeInstruction %t48, %NativeInstruction* %l5
  %t49 = load %NativeInstruction, %NativeInstruction* %l5
  %t50 = extractvalue %NativeInstruction %t49, 0
  %t51 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t52 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t53 = icmp eq i32 %t50, 0
  %t54 = select i1 %t53, i8* %t52, i8* %t51
  %t55 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t56 = icmp eq i32 %t50, 1
  %t57 = select i1 %t56, i8* %t55, i8* %t54
  %t58 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t59 = icmp eq i32 %t50, 2
  %t60 = select i1 %t59, i8* %t58, i8* %t57
  %t61 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t62 = icmp eq i32 %t50, 3
  %t63 = select i1 %t62, i8* %t61, i8* %t60
  %t64 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t65 = icmp eq i32 %t50, 4
  %t66 = select i1 %t65, i8* %t64, i8* %t63
  %t67 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t68 = icmp eq i32 %t50, 5
  %t69 = select i1 %t68, i8* %t67, i8* %t66
  %t70 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t71 = icmp eq i32 %t50, 6
  %t72 = select i1 %t71, i8* %t70, i8* %t69
  %t73 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t74 = icmp eq i32 %t50, 7
  %t75 = select i1 %t74, i8* %t73, i8* %t72
  %t76 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t77 = icmp eq i32 %t50, 8
  %t78 = select i1 %t77, i8* %t76, i8* %t75
  %t79 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t80 = icmp eq i32 %t50, 9
  %t81 = select i1 %t80, i8* %t79, i8* %t78
  %t82 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t83 = icmp eq i32 %t50, 10
  %t84 = select i1 %t83, i8* %t82, i8* %t81
  %t85 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t86 = icmp eq i32 %t50, 11
  %t87 = select i1 %t86, i8* %t85, i8* %t84
  %t88 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t89 = icmp eq i32 %t50, 12
  %t90 = select i1 %t89, i8* %t88, i8* %t87
  %t91 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t92 = icmp eq i32 %t50, 13
  %t93 = select i1 %t92, i8* %t91, i8* %t90
  %t94 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t95 = icmp eq i32 %t50, 14
  %t96 = select i1 %t95, i8* %t94, i8* %t93
  %t97 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t98 = icmp eq i32 %t50, 15
  %t99 = select i1 %t98, i8* %t97, i8* %t96
  %t100 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t101 = icmp eq i32 %t50, 16
  %t102 = select i1 %t101, i8* %t100, i8* %t99
  %s103 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.103, i32 0, i32 0
  %t104 = icmp ne i8* %t102, %s103
  %t105 = load i8*, i8** %l0
  %t106 = load i8*, i8** %l1
  %t107 = load double, double* %l2
  %t108 = load double, double* %l3
  %t109 = load double, double* %l4
  %t110 = load %NativeInstruction, %NativeInstruction* %l5
  br i1 %t104, label %then10, label %merge11
then10:
  br label %afterloop7
merge11:
  %t111 = load %NativeInstruction, %NativeInstruction* %l5
  %t112 = extractvalue %NativeInstruction %t111, 0
  %t113 = alloca %NativeInstruction
  store %NativeInstruction %t111, %NativeInstruction* %t113
  %t114 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t113, i32 0, i32 1
  %t115 = bitcast [8 x i8]* %t114 to i8*
  %t116 = bitcast i8* %t115 to i8**
  %t117 = load i8*, i8** %t116
  %t118 = icmp eq i32 %t112, 16
  %t119 = select i1 %t118, i8* %t117, i8* null
  %t120 = call i8* @trim_text(i8* %t119)
  store i8* %t120, i8** %l6
  %t121 = load i8*, i8** %l6
  %t122 = load double, double* %l4
  %t123 = load i8*, i8** %l6
  %t124 = call double @compute_brace_balance(i8* %t123)
  %t125 = fadd double %t122, %t124
  store double %t125, double* %l4
  %t126 = load double, double* %l3
  %t127 = sitofp i64 1 to double
  %t128 = fadd double %t126, %t127
  store double %t128, double* %l3
  %t129 = load double, double* %l2
  %t130 = sitofp i64 1 to double
  %t131 = fadd double %t129, %t130
  store double %t131, double* %l2
  %t132 = load double, double* %l4
  %t133 = sitofp i64 0 to double
  %t134 = fcmp ole double %t132, %t133
  %t135 = load i8*, i8** %l0
  %t136 = load i8*, i8** %l1
  %t137 = load double, double* %l2
  %t138 = load double, double* %l3
  %t139 = load double, double* %l4
  %t140 = load %NativeInstruction, %NativeInstruction* %l5
  %t141 = load i8*, i8** %l6
  br i1 %t134, label %then12, label %merge13
then12:
  br label %afterloop7
merge13:
  br label %loop.latch6
loop.latch6:
  %t142 = load double, double* %l4
  %t143 = load double, double* %l3
  %t144 = load double, double* %l2
  br label %loop.header4
afterloop7:
  %t148 = load double, double* %l4
  %t149 = sitofp i64 0 to double
  %t150 = fcmp une double %t148, %t149
  %t151 = load i8*, i8** %l0
  %t152 = load i8*, i8** %l1
  %t153 = load double, double* %l2
  %t154 = load double, double* %l3
  %t155 = load double, double* %l4
  br i1 %t150, label %then14, label %merge15
then14:
  %t156 = load i8*, i8** %l0
  %t157 = insertvalue %StructLiteralCapture undef, i8* %t156, 0
  %t158 = sitofp i64 0 to double
  %t159 = insertvalue %StructLiteralCapture %t157, double %t158, 1
  %t160 = insertvalue %StructLiteralCapture %t159, i1 0, 2
  ret %StructLiteralCapture %t160
merge15:
  %t161 = load double, double* %l3
  %t162 = sitofp i64 0 to double
  %t163 = fcmp oeq double %t161, %t162
  %t164 = load i8*, i8** %l0
  %t165 = load i8*, i8** %l1
  %t166 = load double, double* %l2
  %t167 = load double, double* %l3
  %t168 = load double, double* %l4
  br i1 %t163, label %then16, label %merge17
then16:
  %t169 = load i8*, i8** %l0
  %t170 = insertvalue %StructLiteralCapture undef, i8* %t169, 0
  %t171 = sitofp i64 0 to double
  %t172 = insertvalue %StructLiteralCapture %t170, double %t171, 1
  %t173 = insertvalue %StructLiteralCapture %t172, i1 0, 2
  ret %StructLiteralCapture %t173
merge17:
  %t174 = load i8*, i8** %l1
  %t175 = call i8* @trim_text(i8* %t174)
  %t176 = call i8* @trim_trailing_delimiters(i8* %t175)
  store i8* %t176, i8** %l7
  %t177 = load i8*, i8** %l7
  %t178 = call i1 @ends_with(i8* %t177, i8* null)
  %t179 = xor i1 %t178, 1
  %t180 = load i8*, i8** %l0
  %t181 = load i8*, i8** %l1
  %t182 = load double, double* %l2
  %t183 = load double, double* %l3
  %t184 = load double, double* %l4
  %t185 = load i8*, i8** %l7
  br i1 %t179, label %then18, label %merge19
then18:
  %t186 = load i8*, i8** %l0
  %t187 = insertvalue %StructLiteralCapture undef, i8* %t186, 0
  %t188 = sitofp i64 0 to double
  %t189 = insertvalue %StructLiteralCapture %t187, double %t188, 1
  %t190 = insertvalue %StructLiteralCapture %t189, i1 0, 2
  ret %StructLiteralCapture %t190
merge19:
  %t191 = load i8*, i8** %l7
  %t192 = insertvalue %StructLiteralCapture undef, i8* %t191, 0
  %t193 = load double, double* %l3
  %t194 = insertvalue %StructLiteralCapture %t192, double %t193, 1
  %t195 = insertvalue %StructLiteralCapture %t194, i1 1, 2
  ret %StructLiteralCapture %t195
}

define i8* @rewrite_expression_intrinsics(i8* %expression) {
entry:
  %l0 = alloca i8*
  store i8* %expression, i8** %l0
  %t0 = load i8*, i8** %l0
  %t1 = call i8* @rewrite_literal_tokens(i8* %t0)
  store i8* %t1, i8** %l0
  %t2 = load i8*, i8** %l0
  %t3 = call i8* @rewrite_logical_operators(i8* %t2)
  store i8* %t3, i8** %l0
  %t4 = load i8*, i8** %l0
  %t5 = call i8* @rewrite_push_calls(i8* %t4)
  store i8* %t5, i8** %l0
  %t6 = load i8*, i8** %l0
  %t7 = call i8* @rewrite_concat_calls(i8* %t6)
  store i8* %t7, i8** %l0
  %t8 = load i8*, i8** %l0
  %t9 = call i8* @rewrite_length_accesses(i8* %t8)
  store i8* %t9, i8** %l0
  %t10 = load i8*, i8** %l0
  ret i8* %t10
}

define i8* @rewrite_logical_operators(i8* %expression) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8
  %l3 = alloca double
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = load i8*, i8** %l0
  %t3 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t67 = phi i8* [ %t2, %entry ], [ %t65, %loop.latch2 ]
  %t68 = phi double [ %t3, %entry ], [ %t66, %loop.latch2 ]
  store i8* %t67, i8** %l0
  store double %t68, double* %l1
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  %t5 = load double, double* %l1
  %t6 = getelementptr i8, i8* %expression, i64 %t5
  %t7 = load i8, i8* %t6
  store i8 %t7, i8* %l2
  %t9 = load i8, i8* %l2
  %t10 = icmp eq i8 %t9, 39
  br label %logical_or_entry_8

logical_or_entry_8:
  br i1 %t10, label %logical_or_merge_8, label %logical_or_right_8

logical_or_right_8:
  %t11 = load i8, i8* %l2
  %t12 = icmp eq i8 %t11, 34
  br label %logical_or_right_end_8

logical_or_right_end_8:
  br label %logical_or_merge_8

logical_or_merge_8:
  %t13 = phi i1 [ true, %logical_or_entry_8 ], [ %t12, %logical_or_right_end_8 ]
  %t14 = load i8*, i8** %l0
  %t15 = load double, double* %l1
  %t16 = load i8, i8* %l2
  br i1 %t13, label %then4, label %merge5
then4:
  %t17 = load double, double* %l1
  %t18 = call double @skip_string_literal(i8* %expression, double %t17)
  store double %t18, double* %l3
  %t19 = load i8*, i8** %l0
  %t20 = load double, double* %l1
  %t21 = load double, double* %l3
  %t22 = fptosi double %t20 to i64
  %t23 = fptosi double %t21 to i64
  %t24 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t22, i64 %t23)
  %t25 = add i8* %t19, %t24
  store i8* %t25, i8** %l0
  %t26 = load double, double* %l3
  store double %t26, double* %l1
  br label %loop.latch2
merge5:
  %t27 = load i8, i8* %l2
  %t28 = icmp eq i8 %t27, 38
  %t29 = load i8*, i8** %l0
  %t30 = load double, double* %l1
  %t31 = load i8, i8* %l2
  br i1 %t28, label %then6, label %merge7
then6:
  %t32 = load double, double* %l1
  %t33 = sitofp i64 1 to double
  %t34 = fadd double %t32, %t33
  br label %merge7
merge7:
  %t35 = load i8, i8* %l2
  %t36 = icmp eq i8 %t35, 124
  %t37 = load i8*, i8** %l0
  %t38 = load double, double* %l1
  %t39 = load i8, i8* %l2
  br i1 %t36, label %then8, label %merge9
then8:
  %t40 = load double, double* %l1
  %t41 = sitofp i64 1 to double
  %t42 = fadd double %t40, %t41
  br label %merge9
merge9:
  %t43 = load i8, i8* %l2
  %t44 = icmp eq i8 %t43, 33
  %t45 = load i8*, i8** %l0
  %t46 = load double, double* %l1
  %t47 = load i8, i8* %l2
  br i1 %t44, label %then10, label %merge11
then10:
  %t48 = load double, double* %l1
  %t49 = sitofp i64 1 to double
  %t50 = fadd double %t48, %t49
  %t51 = load i8*, i8** %l0
  %s52 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.52, i32 0, i32 0
  %t53 = add i8* %t51, %s52
  store i8* %t53, i8** %l0
  %t54 = load double, double* %l1
  %t55 = sitofp i64 1 to double
  %t56 = fadd double %t54, %t55
  store double %t56, double* %l1
  br label %loop.latch2
merge11:
  %t57 = load i8*, i8** %l0
  %t58 = load i8, i8* %l2
  %t59 = getelementptr i8, i8* %t57, i64 0
  %t60 = load i8, i8* %t59
  %t61 = add i8 %t60, %t58
  store i8* null, i8** %l0
  %t62 = load double, double* %l1
  %t63 = sitofp i64 1 to double
  %t64 = fadd double %t62, %t63
  store double %t64, double* %l1
  br label %loop.latch2
loop.latch2:
  %t65 = load i8*, i8** %l0
  %t66 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t69 = load i8*, i8** %l0
  ret i8* %t69
}

define i8* @rewrite_literal_tokens(i8* %expression) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca i8
  %l6 = alloca i8*
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = load i8*, i8** %l0
  %t3 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t108 = phi i8* [ %t2, %entry ], [ %t106, %loop.latch2 ]
  %t109 = phi double [ %t3, %entry ], [ %t107, %loop.latch2 ]
  store i8* %t108, i8** %l0
  store double %t109, double* %l1
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  %t5 = load double, double* %l1
  %t6 = getelementptr i8, i8* %expression, i64 %t5
  %t7 = load i8, i8* %t6
  store i8 %t7, i8* %l2
  %t9 = load i8, i8* %l2
  %t10 = icmp eq i8 %t9, 39
  br label %logical_or_entry_8

logical_or_entry_8:
  br i1 %t10, label %logical_or_merge_8, label %logical_or_right_8

logical_or_right_8:
  %t11 = load i8, i8* %l2
  %t12 = icmp eq i8 %t11, 34
  br label %logical_or_right_end_8

logical_or_right_end_8:
  br label %logical_or_merge_8

logical_or_merge_8:
  %t13 = phi i1 [ true, %logical_or_entry_8 ], [ %t12, %logical_or_right_end_8 ]
  %t14 = load i8*, i8** %l0
  %t15 = load double, double* %l1
  %t16 = load i8, i8* %l2
  br i1 %t13, label %then4, label %merge5
then4:
  %t17 = load double, double* %l1
  %t18 = call double @skip_string_literal(i8* %expression, double %t17)
  store double %t18, double* %l3
  %t19 = load i8*, i8** %l0
  %t20 = load double, double* %l1
  %t21 = load double, double* %l3
  %t22 = fptosi double %t20 to i64
  %t23 = fptosi double %t21 to i64
  %t24 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t22, i64 %t23)
  %t25 = add i8* %t19, %t24
  store i8* %t25, i8** %l0
  %t26 = load double, double* %l3
  store double %t26, double* %l1
  br label %loop.latch2
merge5:
  %t27 = load i8, i8* %l2
  %t28 = call i1 @is_identifier_char(i8* null)
  %t29 = load i8*, i8** %l0
  %t30 = load double, double* %l1
  %t31 = load i8, i8* %l2
  br i1 %t28, label %then6, label %merge7
then6:
  %t32 = load double, double* %l1
  store double %t32, double* %l4
  %t33 = load i8*, i8** %l0
  %t34 = load double, double* %l1
  %t35 = load i8, i8* %l2
  %t36 = load double, double* %l4
  br label %loop.header8
loop.header8:
  %t53 = phi double [ %t34, %then6 ], [ %t52, %loop.latch10 ]
  store double %t53, double* %l1
  br label %loop.body9
loop.body9:
  %t37 = load double, double* %l1
  %t38 = sitofp i64 1 to double
  %t39 = fadd double %t37, %t38
  store double %t39, double* %l1
  %t40 = load double, double* %l1
  %t41 = load double, double* %l1
  %t42 = getelementptr i8, i8* %expression, i64 %t41
  %t43 = load i8, i8* %t42
  store i8 %t43, i8* %l5
  %t44 = load i8, i8* %l5
  %t45 = call i1 @is_identifier_char(i8* null)
  %t46 = xor i1 %t45, 1
  %t47 = load i8*, i8** %l0
  %t48 = load double, double* %l1
  %t49 = load i8, i8* %l2
  %t50 = load double, double* %l4
  %t51 = load i8, i8* %l5
  br i1 %t46, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  br label %loop.latch10
loop.latch10:
  %t52 = load double, double* %l1
  br label %loop.header8
afterloop11:
  %t54 = load double, double* %l4
  %t55 = load double, double* %l1
  %t56 = fptosi double %t54 to i64
  %t57 = fptosi double %t55 to i64
  %t58 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t56, i64 %t57)
  store i8* %t58, i8** %l6
  %t59 = load i8*, i8** %l6
  %s60 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.60, i32 0, i32 0
  %t61 = icmp eq i8* %t59, %s60
  %t62 = load i8*, i8** %l0
  %t63 = load double, double* %l1
  %t64 = load i8, i8* %l2
  %t65 = load double, double* %l4
  %t66 = load i8*, i8** %l6
  br i1 %t61, label %then14, label %else15
then14:
  %t67 = load i8*, i8** %l0
  %s68 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.68, i32 0, i32 0
  %t69 = add i8* %t67, %s68
  store i8* %t69, i8** %l0
  br label %merge16
else15:
  %t70 = load i8*, i8** %l6
  %s71 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.71, i32 0, i32 0
  %t72 = icmp eq i8* %t70, %s71
  %t73 = load i8*, i8** %l0
  %t74 = load double, double* %l1
  %t75 = load i8, i8* %l2
  %t76 = load double, double* %l4
  %t77 = load i8*, i8** %l6
  br i1 %t72, label %then17, label %else18
then17:
  %t78 = load i8*, i8** %l0
  %s79 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.79, i32 0, i32 0
  %t80 = add i8* %t78, %s79
  store i8* %t80, i8** %l0
  br label %merge19
else18:
  %t81 = load i8*, i8** %l6
  %s82 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.82, i32 0, i32 0
  %t83 = icmp eq i8* %t81, %s82
  %t84 = load i8*, i8** %l0
  %t85 = load double, double* %l1
  %t86 = load i8, i8* %l2
  %t87 = load double, double* %l4
  %t88 = load i8*, i8** %l6
  br i1 %t83, label %then20, label %else21
then20:
  %t89 = load i8*, i8** %l0
  %s90 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.90, i32 0, i32 0
  %t91 = add i8* %t89, %s90
  store i8* %t91, i8** %l0
  br label %merge22
else21:
  %t92 = load i8*, i8** %l0
  %t93 = load i8*, i8** %l6
  %t94 = add i8* %t92, %t93
  store i8* %t94, i8** %l0
  br label %merge22
merge22:
  %t95 = phi i8* [ %t91, %then20 ], [ %t94, %else21 ]
  store i8* %t95, i8** %l0
  br label %merge19
merge19:
  %t96 = phi i8* [ %t80, %then17 ], [ %t91, %else18 ]
  store i8* %t96, i8** %l0
  br label %merge16
merge16:
  %t97 = phi i8* [ %t69, %then14 ], [ %t80, %else15 ]
  store i8* %t97, i8** %l0
  br label %loop.latch2
merge7:
  %t98 = load i8*, i8** %l0
  %t99 = load i8, i8* %l2
  %t100 = getelementptr i8, i8* %t98, i64 0
  %t101 = load i8, i8* %t100
  %t102 = add i8 %t101, %t99
  store i8* null, i8** %l0
  %t103 = load double, double* %l1
  %t104 = sitofp i64 1 to double
  %t105 = fadd double %t103, %t104
  store double %t105, double* %l1
  br label %loop.latch2
loop.latch2:
  %t106 = load i8*, i8** %l0
  %t107 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t110 = load i8*, i8** %l0
  ret i8* %t110
}

define i8* @rewrite_push_calls(i8* %expression) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca i8
  %l5 = alloca double
  %s0 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l0
  %s1 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.1, i32 0, i32 0
  store i8* %s1, i8** %l1
  %s2 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.2, i32 0, i32 0
  store i8* %s2, i8** %l2
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l3
  %t4 = load i8*, i8** %l0
  %t5 = load i8*, i8** %l1
  %t6 = load i8*, i8** %l2
  %t7 = load double, double* %l3
  br label %loop.header0
loop.header0:
  %t45 = phi i8* [ %t6, %entry ], [ %t43, %loop.latch2 ]
  %t46 = phi double [ %t7, %entry ], [ %t44, %loop.latch2 ]
  store i8* %t45, i8** %l2
  store double %t46, double* %l3
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l3
  %t9 = load double, double* %l3
  %t10 = getelementptr i8, i8* %expression, i64 %t9
  %t11 = load i8, i8* %t10
  store i8 %t11, i8* %l4
  %t13 = load i8, i8* %l4
  %t14 = icmp eq i8 %t13, 39
  br label %logical_or_entry_12

logical_or_entry_12:
  br i1 %t14, label %logical_or_merge_12, label %logical_or_right_12

logical_or_right_12:
  %t15 = load i8, i8* %l4
  %t16 = icmp eq i8 %t15, 34
  br label %logical_or_right_end_12

logical_or_right_end_12:
  br label %logical_or_merge_12

logical_or_merge_12:
  %t17 = phi i1 [ true, %logical_or_entry_12 ], [ %t16, %logical_or_right_end_12 ]
  %t18 = load i8*, i8** %l0
  %t19 = load i8*, i8** %l1
  %t20 = load i8*, i8** %l2
  %t21 = load double, double* %l3
  %t22 = load i8, i8* %l4
  br i1 %t17, label %then4, label %merge5
then4:
  %t23 = load double, double* %l3
  %t24 = call double @skip_string_literal(i8* %expression, double %t23)
  store double %t24, double* %l5
  %t25 = load i8*, i8** %l2
  %t26 = load double, double* %l3
  %t27 = load double, double* %l5
  %t28 = fptosi double %t26 to i64
  %t29 = fptosi double %t27 to i64
  %t30 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t28, i64 %t29)
  %t31 = add i8* %t25, %t30
  store i8* %t31, i8** %l2
  %t32 = load double, double* %l5
  store double %t32, double* %l3
  br label %loop.latch2
merge5:
  %t33 = load double, double* %l3
  %t34 = load i8*, i8** %l0
  %t35 = load i8*, i8** %l2
  %t36 = load i8, i8* %l4
  %t37 = getelementptr i8, i8* %t35, i64 0
  %t38 = load i8, i8* %t37
  %t39 = add i8 %t38, %t36
  store i8* null, i8** %l2
  %t40 = load double, double* %l3
  %t41 = sitofp i64 1 to double
  %t42 = fadd double %t40, %t41
  store double %t42, double* %l3
  br label %loop.latch2
loop.latch2:
  %t43 = load i8*, i8** %l2
  %t44 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t47 = load i8*, i8** %l2
  ret i8* %t47
}

define i8* @rewrite_concat_calls(i8* %expression) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca %ExtractedSpan
  %l3 = alloca double
  %l4 = alloca %ExtractedSpan
  %l5 = alloca i8*
  %l6 = alloca double
  %l7 = alloca i8*
  %l8 = alloca i8*
  %l9 = alloca double
  store i8* %expression, i8** %l0
  %t0 = load i8*, i8** %l0
  br label %loop.header0
loop.header0:
  %t50 = phi i8* [ %t0, %entry ], [ %t49, %loop.latch2 ]
  store i8* %t50, i8** %l0
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
  store double 0.0, double* %l6
  %t41 = load %ExtractedSpan, %ExtractedSpan* %l2
  %t42 = extractvalue %ExtractedSpan %t41, 0
  %t43 = call i8* @trim_text(i8* %t42)
  store i8* %t43, i8** %l7
  %t44 = load %ExtractedSpan, %ExtractedSpan* %l4
  %t45 = extractvalue %ExtractedSpan %t44, 0
  %t46 = call i8* @trim_text(i8* %t45)
  store i8* %t46, i8** %l8
  store double 0.0, double* %l9
  %t47 = load i8*, i8** %l5
  %t48 = load double, double* %l9
  br label %loop.latch2
loop.latch2:
  %t49 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t51 = load i8*, i8** %l0
  ret i8* %t51
}

define i8* @rewrite_length_accesses(i8* %expression) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca %ExtractedSpan
  %l3 = alloca i8*
  %l4 = alloca double
  %l5 = alloca i8*
  store i8* %expression, i8** %l0
  %t0 = load i8*, i8** %l0
  br label %loop.header0
loop.header0:
  %t37 = phi i8* [ %t0, %entry ], [ %t36, %loop.latch2 ]
  store i8* %t37, i8** %l0
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
  store double 0.0, double* %l4
  %t28 = load %ExtractedSpan, %ExtractedSpan* %l2
  %t29 = extractvalue %ExtractedSpan %t28, 0
  %t30 = call i8* @trim_text(i8* %t29)
  store i8* %t30, i8** %l5
  %t31 = load i8*, i8** %l5
  %t32 = load i8*, i8** %l3
  %s33 = getelementptr inbounds [25 x i8], [25 x i8]* @.str.33, i32 0, i32 0
  %t34 = add i8* %t32, %s33
  %t35 = load double, double* %l4
  br label %loop.latch2
loop.latch2:
  %t36 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t38 = load i8*, i8** %l0
  ret i8* %t38
}

define %ExtractedSpan @extract_object_span(i8* %text, double %dot_index) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca i8
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
  %t118 = phi double [ %t14, %entry ], [ %t115, %loop.latch4 ]
  %t119 = phi double [ %t13, %entry ], [ %t116, %loop.latch4 ]
  %t120 = phi double [ %t15, %entry ], [ %t117, %loop.latch4 ]
  store double %t118, double* %l1
  store double %t119, double* %l0
  store double %t120, double* %l2
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
  %t23 = getelementptr i8, i8* %text, i64 %t22
  %t24 = load i8, i8* %t23
  store i8 %t24, i8* %l3
  %t25 = load i8, i8* %l3
  %t26 = icmp eq i8 %t25, 93
  %t27 = load double, double* %l0
  %t28 = load double, double* %l1
  %t29 = load double, double* %l2
  %t30 = load i8, i8* %l3
  br i1 %t26, label %then8, label %merge9
then8:
  %t31 = load double, double* %l1
  %t32 = sitofp i64 1 to double
  %t33 = fadd double %t31, %t32
  store double %t33, double* %l1
  %t34 = load double, double* %l0
  %t35 = sitofp i64 1 to double
  %t36 = fsub double %t34, %t35
  store double %t36, double* %l0
  br label %loop.latch4
merge9:
  %t37 = load i8, i8* %l3
  %t38 = icmp eq i8 %t37, 91
  %t39 = load double, double* %l0
  %t40 = load double, double* %l1
  %t41 = load double, double* %l2
  %t42 = load i8, i8* %l3
  br i1 %t38, label %then10, label %merge11
then10:
  %t43 = load double, double* %l1
  %t44 = sitofp i64 0 to double
  %t45 = fcmp ogt double %t43, %t44
  %t46 = load double, double* %l0
  %t47 = load double, double* %l1
  %t48 = load double, double* %l2
  %t49 = load i8, i8* %l3
  br i1 %t45, label %then12, label %merge13
then12:
  %t50 = load double, double* %l1
  %t51 = sitofp i64 1 to double
  %t52 = fsub double %t50, %t51
  store double %t52, double* %l1
  %t53 = load double, double* %l0
  %t54 = sitofp i64 1 to double
  %t55 = fsub double %t53, %t54
  store double %t55, double* %l0
  br label %loop.latch4
merge13:
  br label %afterloop5
merge11:
  %t56 = load i8, i8* %l3
  %t57 = icmp eq i8 %t56, 41
  %t58 = load double, double* %l0
  %t59 = load double, double* %l1
  %t60 = load double, double* %l2
  %t61 = load i8, i8* %l3
  br i1 %t57, label %then14, label %merge15
then14:
  %t62 = load double, double* %l2
  %t63 = sitofp i64 1 to double
  %t64 = fadd double %t62, %t63
  store double %t64, double* %l2
  %t65 = load double, double* %l0
  %t66 = sitofp i64 1 to double
  %t67 = fsub double %t65, %t66
  store double %t67, double* %l0
  br label %loop.latch4
merge15:
  %t68 = load i8, i8* %l3
  %t69 = icmp eq i8 %t68, 40
  %t70 = load double, double* %l0
  %t71 = load double, double* %l1
  %t72 = load double, double* %l2
  %t73 = load i8, i8* %l3
  br i1 %t69, label %then16, label %merge17
then16:
  %t74 = load double, double* %l2
  %t75 = sitofp i64 0 to double
  %t76 = fcmp ogt double %t74, %t75
  %t77 = load double, double* %l0
  %t78 = load double, double* %l1
  %t79 = load double, double* %l2
  %t80 = load i8, i8* %l3
  br i1 %t76, label %then18, label %merge19
then18:
  %t81 = load double, double* %l2
  %t82 = sitofp i64 1 to double
  %t83 = fsub double %t81, %t82
  store double %t83, double* %l2
  %t84 = load double, double* %l0
  %t85 = sitofp i64 1 to double
  %t86 = fsub double %t84, %t85
  store double %t86, double* %l0
  br label %loop.latch4
merge19:
  br label %afterloop5
merge17:
  %t88 = load double, double* %l1
  %t89 = sitofp i64 0 to double
  %t90 = fcmp ogt double %t88, %t89
  br label %logical_or_entry_87

logical_or_entry_87:
  br i1 %t90, label %logical_or_merge_87, label %logical_or_right_87

logical_or_right_87:
  %t91 = load double, double* %l2
  %t92 = sitofp i64 0 to double
  %t93 = fcmp ogt double %t91, %t92
  br label %logical_or_right_end_87

logical_or_right_end_87:
  br label %logical_or_merge_87

logical_or_merge_87:
  %t94 = phi i1 [ true, %logical_or_entry_87 ], [ %t93, %logical_or_right_end_87 ]
  %t95 = load double, double* %l0
  %t96 = load double, double* %l1
  %t97 = load double, double* %l2
  %t98 = load i8, i8* %l3
  br i1 %t94, label %then20, label %merge21
then20:
  %t99 = load double, double* %l0
  %t100 = sitofp i64 1 to double
  %t101 = fsub double %t99, %t100
  store double %t101, double* %l0
  br label %loop.latch4
merge21:
  %t103 = load i8, i8* %l3
  %t104 = call i1 @is_identifier_char(i8* null)
  br label %logical_or_entry_102

logical_or_entry_102:
  br i1 %t104, label %logical_or_merge_102, label %logical_or_right_102

logical_or_right_102:
  %t105 = load i8, i8* %l3
  %t106 = icmp eq i8 %t105, 46
  br label %logical_or_right_end_102

logical_or_right_end_102:
  br label %logical_or_merge_102

logical_or_merge_102:
  %t107 = phi i1 [ true, %logical_or_entry_102 ], [ %t106, %logical_or_right_end_102 ]
  %t108 = load double, double* %l0
  %t109 = load double, double* %l1
  %t110 = load double, double* %l2
  %t111 = load i8, i8* %l3
  br i1 %t107, label %then22, label %merge23
then22:
  %t112 = load double, double* %l0
  %t113 = sitofp i64 1 to double
  %t114 = fsub double %t112, %t113
  store double %t114, double* %l0
  br label %loop.latch4
merge23:
  br label %afterloop5
loop.latch4:
  %t115 = load double, double* %l1
  %t116 = load double, double* %l0
  %t117 = load double, double* %l2
  br label %loop.header2
afterloop5:
  %t121 = load double, double* %l0
  %t122 = sitofp i64 1 to double
  %t123 = fadd double %t121, %t122
  store double %t123, double* %l4
  %t124 = load double, double* %l4
  %t125 = fcmp oge double %t124, %dot_index
  %t126 = load double, double* %l0
  %t127 = load double, double* %l1
  %t128 = load double, double* %l2
  %t129 = load double, double* %l4
  br i1 %t125, label %then24, label %merge25
then24:
  %s130 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.130, i32 0, i32 0
  %t131 = insertvalue %ExtractedSpan undef, i8* %s130, 0
  %t132 = load double, double* %l4
  %t133 = insertvalue %ExtractedSpan %t131, double %t132, 1
  %t134 = insertvalue %ExtractedSpan %t133, double %dot_index, 2
  %t135 = insertvalue %ExtractedSpan %t134, i1 0, 3
  ret %ExtractedSpan %t135
merge25:
  %t136 = load double, double* %l4
  %t137 = fptosi double %t136 to i64
  %t138 = fptosi double %dot_index to i64
  %t139 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t137, i64 %t138)
  store i8* %t139, i8** %l5
  %t140 = load i8*, i8** %l5
  %t141 = insertvalue %ExtractedSpan undef, i8* %t140, 0
  %t142 = load double, double* %l4
  %t143 = insertvalue %ExtractedSpan %t141, double %t142, 1
  %t144 = insertvalue %ExtractedSpan %t143, double %dot_index, 2
  %t145 = insertvalue %ExtractedSpan %t144, i1 1, 3
  ret %ExtractedSpan %t145
}

define %ExtractedSpan @extract_parenthesized_span(i8* %text, double %open_index) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i8
  %l3 = alloca i8*
  %t0 = getelementptr i8, i8* %text, i64 %open_index
  %t1 = load i8, i8* %t0
  %t2 = icmp ne i8 %t1, 40
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
  store double %t9, double* %l0
  %t10 = sitofp i64 1 to double
  store double %t10, double* %l1
  %t11 = load double, double* %l0
  %t12 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t65 = phi double [ %t12, %entry ], [ %t63, %loop.latch4 ]
  %t66 = phi double [ %t11, %entry ], [ %t64, %loop.latch4 ]
  store double %t65, double* %l1
  store double %t66, double* %l0
  br label %loop.body3
loop.body3:
  %t13 = load double, double* %l0
  %t14 = load double, double* %l0
  %t15 = getelementptr i8, i8* %text, i64 %t14
  %t16 = load i8, i8* %t15
  store i8 %t16, i8* %l2
  %t17 = load i8, i8* %l2
  %t18 = icmp eq i8 %t17, 40
  %t19 = load double, double* %l0
  %t20 = load double, double* %l1
  %t21 = load i8, i8* %l2
  br i1 %t18, label %then6, label %else7
then6:
  %t22 = load double, double* %l1
  %t23 = sitofp i64 1 to double
  %t24 = fadd double %t22, %t23
  store double %t24, double* %l1
  br label %merge8
else7:
  %t25 = load i8, i8* %l2
  %t26 = icmp eq i8 %t25, 41
  %t27 = load double, double* %l0
  %t28 = load double, double* %l1
  %t29 = load i8, i8* %l2
  br i1 %t26, label %then9, label %else10
then9:
  %t30 = load double, double* %l1
  %t31 = sitofp i64 1 to double
  %t32 = fsub double %t30, %t31
  store double %t32, double* %l1
  %t33 = load double, double* %l1
  %t34 = sitofp i64 0 to double
  %t35 = fcmp oeq double %t33, %t34
  %t36 = load double, double* %l0
  %t37 = load double, double* %l1
  %t38 = load i8, i8* %l2
  br i1 %t35, label %then12, label %merge13
then12:
  %t39 = sitofp i64 1 to double
  %t40 = fadd double %open_index, %t39
  %t41 = load double, double* %l0
  %t42 = fptosi double %t40 to i64
  %t43 = fptosi double %t41 to i64
  %t44 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t42, i64 %t43)
  store i8* %t44, i8** %l3
  ret %ExtractedSpan zeroinitializer
merge13:
  br label %merge11
else10:
  %t46 = load i8, i8* %l2
  %t47 = icmp eq i8 %t46, 34
  br label %logical_or_entry_45

logical_or_entry_45:
  br i1 %t47, label %logical_or_merge_45, label %logical_or_right_45

logical_or_right_45:
  %t48 = load i8, i8* %l2
  %t49 = icmp eq i8 %t48, 39
  br label %logical_or_right_end_45

logical_or_right_end_45:
  br label %logical_or_merge_45

logical_or_merge_45:
  %t50 = phi i1 [ true, %logical_or_entry_45 ], [ %t49, %logical_or_right_end_45 ]
  %t51 = load double, double* %l0
  %t52 = load double, double* %l1
  %t53 = load i8, i8* %l2
  br i1 %t50, label %then14, label %merge15
then14:
  %t54 = load double, double* %l0
  %t55 = call double @skip_string_literal(i8* %text, double %t54)
  store double %t55, double* %l0
  br label %loop.latch4
merge15:
  br label %merge11
merge11:
  %t56 = phi double [ %t32, %then9 ], [ %t28, %else10 ]
  %t57 = phi double [ %t27, %then9 ], [ %t55, %else10 ]
  store double %t56, double* %l1
  store double %t57, double* %l0
  br label %merge8
merge8:
  %t58 = phi double [ %t24, %then6 ], [ %t32, %else7 ]
  %t59 = phi double [ %t19, %then6 ], [ %t55, %else7 ]
  store double %t58, double* %l1
  store double %t59, double* %l0
  %t60 = load double, double* %l0
  %t61 = sitofp i64 1 to double
  %t62 = fadd double %t60, %t61
  store double %t62, double* %l0
  br label %loop.latch4
loop.latch4:
  %t63 = load double, double* %l1
  %t64 = load double, double* %l0
  br label %loop.header2
afterloop5:
  %s67 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.67, i32 0, i32 0
  %t68 = insertvalue %ExtractedSpan undef, i8* %s67, 0
  %t69 = insertvalue %ExtractedSpan %t68, double %open_index, 1
  %t70 = insertvalue %ExtractedSpan %t69, double %open_index, 2
  %t71 = insertvalue %ExtractedSpan %t70, i1 0, 3
  ret %ExtractedSpan %t71
}

define double @skip_string_literal(i8* %text, double %quote_index) {
entry:
  %l0 = alloca i8
  %l1 = alloca double
  %l2 = alloca i8
  %t0 = getelementptr i8, i8* %text, i64 %quote_index
  %t1 = load i8, i8* %t0
  store i8 %t1, i8* %l0
  %t2 = sitofp i64 1 to double
  %t3 = fadd double %quote_index, %t2
  store double %t3, double* %l1
  %t4 = load i8, i8* %l0
  %t5 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t31 = phi double [ %t5, %entry ], [ %t30, %loop.latch2 ]
  store double %t31, double* %l1
  br label %loop.body1
loop.body1:
  %t6 = load double, double* %l1
  %t7 = load double, double* %l1
  %t8 = getelementptr i8, i8* %text, i64 %t7
  %t9 = load i8, i8* %t8
  store i8 %t9, i8* %l2
  %t10 = load i8, i8* %l2
  %t11 = icmp eq i8 %t10, 92
  %t12 = load i8, i8* %l0
  %t13 = load double, double* %l1
  %t14 = load i8, i8* %l2
  br i1 %t11, label %then4, label %merge5
then4:
  %t15 = load double, double* %l1
  %t16 = sitofp i64 2 to double
  %t17 = fadd double %t15, %t16
  store double %t17, double* %l1
  br label %loop.latch2
merge5:
  %t18 = load i8, i8* %l2
  %t19 = load i8, i8* %l0
  %t20 = icmp eq i8 %t18, %t19
  %t21 = load i8, i8* %l0
  %t22 = load double, double* %l1
  %t23 = load i8, i8* %l2
  br i1 %t20, label %then6, label %merge7
then6:
  %t24 = load double, double* %l1
  %t25 = sitofp i64 1 to double
  %t26 = fadd double %t24, %t25
  store double %t26, double* %l1
  br label %afterloop3
merge7:
  %t27 = load double, double* %l1
  %t28 = sitofp i64 1 to double
  %t29 = fadd double %t27, %t28
  store double %t29, double* %l1
  br label %loop.latch2
loop.latch2:
  %t30 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t32 = load double, double* %l1
  ret double %t32
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
  %t2 = load i8*, i8** %l0
  %t3 = call double @compute_parenthesis_balance(i8* %t2)
  store double %t3, double* %l1
  %t4 = load i8*, i8** %l0
  %t5 = call double @compute_brace_balance(i8* %t4)
  store double %t5, double* %l2
  %t6 = load i8*, i8** %l0
  %t7 = call double @compute_bracket_balance(i8* %t6)
  store double %t7, double* %l3
  %t8 = load i8*, i8** %l0
  store i8* %t8, i8** %l4
  store double %start_index, double* %l5
  %t9 = sitofp i64 0 to double
  store double %t9, double* %l6
  %t12 = load double, double* %l1
  %t13 = sitofp i64 0 to double
  %t14 = fcmp ogt double %t12, %t13
  br label %logical_or_entry_11

logical_or_entry_11:
  br i1 %t14, label %logical_or_merge_11, label %logical_or_right_11

logical_or_right_11:
  %t15 = load double, double* %l2
  %t16 = sitofp i64 0 to double
  %t17 = fcmp ogt double %t15, %t16
  br label %logical_or_right_end_11

logical_or_right_end_11:
  br label %logical_or_merge_11

logical_or_merge_11:
  %t18 = phi i1 [ true, %logical_or_entry_11 ], [ %t17, %logical_or_right_end_11 ]
  br label %logical_or_entry_10

logical_or_entry_10:
  br i1 %t18, label %logical_or_merge_10, label %logical_or_right_10

logical_or_right_10:
  %t19 = load double, double* %l3
  %t20 = sitofp i64 0 to double
  %t21 = fcmp ogt double %t19, %t20
  br label %logical_or_right_end_10

logical_or_right_end_10:
  br label %logical_or_merge_10

logical_or_merge_10:
  %t22 = phi i1 [ true, %logical_or_entry_10 ], [ %t21, %logical_or_right_end_10 ]
  store i1 %t22, i1* %l7
  %t23 = load i8*, i8** %l0
  %t24 = load double, double* %l1
  %t25 = load double, double* %l2
  %t26 = load double, double* %l3
  %t27 = load i8*, i8** %l4
  %t28 = load double, double* %l5
  %t29 = load double, double* %l6
  %t30 = load i1, i1* %l7
  br label %loop.header0
loop.header0:
  %t220 = phi i1 [ %t30, %entry ], [ %t213, %loop.latch2 ]
  %t221 = phi i8* [ %t27, %entry ], [ %t214, %loop.latch2 ]
  %t222 = phi double [ %t24, %entry ], [ %t215, %loop.latch2 ]
  %t223 = phi double [ %t25, %entry ], [ %t216, %loop.latch2 ]
  %t224 = phi double [ %t26, %entry ], [ %t217, %loop.latch2 ]
  %t225 = phi double [ %t29, %entry ], [ %t218, %loop.latch2 ]
  %t226 = phi double [ %t28, %entry ], [ %t219, %loop.latch2 ]
  store i1 %t220, i1* %l7
  store i8* %t221, i8** %l4
  store double %t222, double* %l1
  store double %t223, double* %l2
  store double %t224, double* %l3
  store double %t225, double* %l6
  store double %t226, double* %l5
  br label %loop.body1
loop.body1:
  %t31 = load double, double* %l5
  %t32 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %instructions
  %t33 = extractvalue { %NativeInstruction*, i64 } %t32, 1
  %t34 = sitofp i64 %t33 to double
  %t35 = fcmp oge double %t31, %t34
  %t36 = load i8*, i8** %l0
  %t37 = load double, double* %l1
  %t38 = load double, double* %l2
  %t39 = load double, double* %l3
  %t40 = load i8*, i8** %l4
  %t41 = load double, double* %l5
  %t42 = load double, double* %l6
  %t43 = load i1, i1* %l7
  br i1 %t35, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t44 = load double, double* %l5
  %t45 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %instructions
  %t46 = extractvalue { %NativeInstruction*, i64 } %t45, 0
  %t47 = extractvalue { %NativeInstruction*, i64 } %t45, 1
  %t48 = icmp uge i64 %t44, %t47
  ; bounds check: %t48 (if true, out of bounds)
  %t49 = getelementptr %NativeInstruction, %NativeInstruction* %t46, i64 %t44
  %t50 = load %NativeInstruction, %NativeInstruction* %t49
  %t51 = call double @continuation_segment_text(%NativeInstruction %t50)
  store double %t51, double* %l8
  %t52 = load double, double* %l8
  %t53 = load double, double* %l8
  %t54 = call i8* @trim_text(i8* null)
  store i8* %t54, i8** %l9
  %t55 = load i8*, i8** %l9
  %t56 = load i1, i1* %l7
  %t57 = xor i1 %t56, 1
  %t58 = load i8*, i8** %l0
  %t59 = load double, double* %l1
  %t60 = load double, double* %l2
  %t61 = load double, double* %l3
  %t62 = load i8*, i8** %l4
  %t63 = load double, double* %l5
  %t64 = load double, double* %l6
  %t65 = load i1, i1* %l7
  %t66 = load double, double* %l8
  %t67 = load i8*, i8** %l9
  br i1 %t57, label %then6, label %merge7
then6:
  %t68 = load i8*, i8** %l9
  %t69 = call i1 @segment_signals_expression_continuation(i8* %t68)
  %t70 = xor i1 %t69, 1
  %t71 = load i8*, i8** %l0
  %t72 = load double, double* %l1
  %t73 = load double, double* %l2
  %t74 = load double, double* %l3
  %t75 = load i8*, i8** %l4
  %t76 = load double, double* %l5
  %t77 = load double, double* %l6
  %t78 = load i1, i1* %l7
  %t79 = load double, double* %l8
  %t80 = load i8*, i8** %l9
  br i1 %t70, label %then8, label %merge9
then8:
  br label %afterloop3
merge9:
  store i1 1, i1* %l7
  br label %merge7
merge7:
  %t81 = phi i1 [ 1, %then6 ], [ %t65, %loop.body1 ]
  store i1 %t81, i1* %l7
  %t82 = load i8*, i8** %l4
  %t83 = getelementptr i8, i8* %t82, i64 0
  %t84 = load i8, i8* %t83
  %t85 = add i8 %t84, 32
  %t86 = load i8*, i8** %l9
  %t87 = getelementptr i8, i8* %t86, i64 0
  %t88 = load i8, i8* %t87
  %t89 = add i8 %t85, %t88
  store i8* null, i8** %l4
  %t90 = load double, double* %l1
  %t91 = load i8*, i8** %l9
  %t92 = call double @compute_parenthesis_balance(i8* %t91)
  %t93 = fadd double %t90, %t92
  store double %t93, double* %l1
  %t94 = load double, double* %l2
  %t95 = load i8*, i8** %l9
  %t96 = call double @compute_brace_balance(i8* %t95)
  %t97 = fadd double %t94, %t96
  store double %t97, double* %l2
  %t98 = load double, double* %l3
  %t99 = load i8*, i8** %l9
  %t100 = call double @compute_bracket_balance(i8* %t99)
  %t101 = fadd double %t98, %t100
  store double %t101, double* %l3
  %t102 = load double, double* %l6
  %t103 = sitofp i64 1 to double
  %t104 = fadd double %t102, %t103
  store double %t104, double* %l6
  %t105 = load double, double* %l5
  %t106 = sitofp i64 1 to double
  %t107 = fadd double %t105, %t106
  store double %t107, double* %l5
  %t110 = load double, double* %l1
  %t111 = sitofp i64 0 to double
  %t112 = fcmp ole double %t110, %t111
  br label %logical_and_entry_109

logical_and_entry_109:
  br i1 %t112, label %logical_and_right_109, label %logical_and_merge_109

logical_and_right_109:
  %t113 = load double, double* %l2
  %t114 = sitofp i64 0 to double
  %t115 = fcmp ole double %t113, %t114
  br label %logical_and_right_end_109

logical_and_right_end_109:
  br label %logical_and_merge_109

logical_and_merge_109:
  %t116 = phi i1 [ false, %logical_and_entry_109 ], [ %t115, %logical_and_right_end_109 ]
  br label %logical_and_entry_108

logical_and_entry_108:
  br i1 %t116, label %logical_and_right_108, label %logical_and_merge_108

logical_and_right_108:
  %t117 = load double, double* %l3
  %t118 = sitofp i64 0 to double
  %t119 = fcmp ole double %t117, %t118
  br label %logical_and_right_end_108

logical_and_right_end_108:
  br label %logical_and_merge_108

logical_and_merge_108:
  %t120 = phi i1 [ false, %logical_and_entry_108 ], [ %t119, %logical_and_right_end_108 ]
  %t121 = load i8*, i8** %l0
  %t122 = load double, double* %l1
  %t123 = load double, double* %l2
  %t124 = load double, double* %l3
  %t125 = load i8*, i8** %l4
  %t126 = load double, double* %l5
  %t127 = load double, double* %l6
  %t128 = load i1, i1* %l7
  %t129 = load double, double* %l8
  %t130 = load i8*, i8** %l9
  br i1 %t120, label %then10, label %merge11
then10:
  store i1 1, i1* %l10
  %t131 = load double, double* %l5
  store double %t131, double* %l11
  %t132 = load i8*, i8** %l0
  %t133 = load double, double* %l1
  %t134 = load double, double* %l2
  %t135 = load double, double* %l3
  %t136 = load i8*, i8** %l4
  %t137 = load double, double* %l5
  %t138 = load double, double* %l6
  %t139 = load i1, i1* %l7
  %t140 = load double, double* %l8
  %t141 = load i8*, i8** %l9
  %t142 = load i1, i1* %l10
  %t143 = load double, double* %l11
  br label %loop.header12
loop.header12:
  %t191 = phi i1 [ %t142, %then10 ], [ %t190, %loop.latch14 ]
  store i1 %t191, i1* %l10
  br label %loop.body13
loop.body13:
  %t144 = load double, double* %l11
  %t145 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %instructions
  %t146 = extractvalue { %NativeInstruction*, i64 } %t145, 1
  %t147 = sitofp i64 %t146 to double
  %t148 = fcmp oge double %t144, %t147
  %t149 = load i8*, i8** %l0
  %t150 = load double, double* %l1
  %t151 = load double, double* %l2
  %t152 = load double, double* %l3
  %t153 = load i8*, i8** %l4
  %t154 = load double, double* %l5
  %t155 = load double, double* %l6
  %t156 = load i1, i1* %l7
  %t157 = load double, double* %l8
  %t158 = load i8*, i8** %l9
  %t159 = load i1, i1* %l10
  %t160 = load double, double* %l11
  br i1 %t148, label %then16, label %merge17
then16:
  br label %afterloop15
merge17:
  %t161 = load double, double* %l11
  %t162 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %instructions
  %t163 = extractvalue { %NativeInstruction*, i64 } %t162, 0
  %t164 = extractvalue { %NativeInstruction*, i64 } %t162, 1
  %t165 = icmp uge i64 %t161, %t164
  ; bounds check: %t165 (if true, out of bounds)
  %t166 = getelementptr %NativeInstruction, %NativeInstruction* %t163, i64 %t161
  %t167 = load %NativeInstruction, %NativeInstruction* %t166
  %t168 = call double @continuation_segment_text(%NativeInstruction %t167)
  store double %t168, double* %l12
  %t169 = load double, double* %l12
  %t170 = load double, double* %l12
  %t171 = call i8* @trim_text(i8* null)
  store i8* %t171, i8** %l13
  %t172 = load i8*, i8** %l13
  %t173 = load i8*, i8** %l13
  %t174 = call i1 @segment_signals_expression_continuation(i8* %t173)
  %t175 = load i8*, i8** %l0
  %t176 = load double, double* %l1
  %t177 = load double, double* %l2
  %t178 = load double, double* %l3
  %t179 = load i8*, i8** %l4
  %t180 = load double, double* %l5
  %t181 = load double, double* %l6
  %t182 = load i1, i1* %l7
  %t183 = load double, double* %l8
  %t184 = load i8*, i8** %l9
  %t185 = load i1, i1* %l10
  %t186 = load double, double* %l11
  %t187 = load double, double* %l12
  %t188 = load i8*, i8** %l13
  br i1 %t174, label %then18, label %merge19
then18:
  store i1 0, i1* %l10
  br label %merge19
merge19:
  %t189 = phi i1 [ 0, %then18 ], [ %t185, %loop.body13 ]
  store i1 %t189, i1* %l10
  br label %afterloop15
loop.latch14:
  %t190 = load i1, i1* %l10
  br label %loop.header12
afterloop15:
  %t192 = load i1, i1* %l10
  %t193 = load i8*, i8** %l0
  %t194 = load double, double* %l1
  %t195 = load double, double* %l2
  %t196 = load double, double* %l3
  %t197 = load i8*, i8** %l4
  %t198 = load double, double* %l5
  %t199 = load double, double* %l6
  %t200 = load i1, i1* %l7
  %t201 = load double, double* %l8
  %t202 = load i8*, i8** %l9
  %t203 = load i1, i1* %l10
  %t204 = load double, double* %l11
  br i1 %t192, label %then20, label %merge21
then20:
  %t205 = load i8*, i8** %l4
  %t206 = call i8* @trim_text(i8* %t205)
  %t207 = call i8* @trim_trailing_delimiters(i8* %t206)
  store i8* %t207, i8** %l14
  %t208 = load i8*, i8** %l14
  %t209 = insertvalue %ExpressionContinuationCapture undef, i8* %t208, 0
  %t210 = load double, double* %l6
  %t211 = insertvalue %ExpressionContinuationCapture %t209, double %t210, 1
  %t212 = insertvalue %ExpressionContinuationCapture %t211, i1 1, 2
  ret %ExpressionContinuationCapture %t212
merge21:
  br label %merge11
merge11:
  br label %loop.latch2
loop.latch2:
  %t213 = load i1, i1* %l7
  %t214 = load i8*, i8** %l4
  %t215 = load double, double* %l1
  %t216 = load double, double* %l2
  %t217 = load double, double* %l3
  %t218 = load double, double* %l6
  %t219 = load double, double* %l5
  br label %loop.header0
afterloop3:
  %t228 = load i1, i1* %l7
  br label %logical_or_entry_227

logical_or_entry_227:
  br i1 %t228, label %logical_or_merge_227, label %logical_or_right_227

logical_or_right_227:
  %t229 = load double, double* %l6
  %t230 = sitofp i64 0 to double
  %t231 = fcmp oeq double %t229, %t230
  br label %logical_or_right_end_227

logical_or_right_end_227:
  br label %logical_or_merge_227

logical_or_merge_227:
  %t232 = phi i1 [ true, %logical_or_entry_227 ], [ %t231, %logical_or_right_end_227 ]
  %t233 = xor i1 %t232, 1
  %t234 = load i8*, i8** %l0
  %t235 = load double, double* %l1
  %t236 = load double, double* %l2
  %t237 = load double, double* %l3
  %t238 = load i8*, i8** %l4
  %t239 = load double, double* %l5
  %t240 = load double, double* %l6
  %t241 = load i1, i1* %l7
  br i1 %t233, label %then22, label %merge23
then22:
  %t242 = load i8*, i8** %l0
  %t243 = insertvalue %ExpressionContinuationCapture undef, i8* %t242, 0
  %t244 = sitofp i64 0 to double
  %t245 = insertvalue %ExpressionContinuationCapture %t243, double %t244, 1
  %t246 = insertvalue %ExpressionContinuationCapture %t245, i1 0, 2
  ret %ExpressionContinuationCapture %t246
merge23:
  %t249 = load double, double* %l1
  %t250 = sitofp i64 0 to double
  %t251 = fcmp ole double %t249, %t250
  br label %logical_and_entry_248

logical_and_entry_248:
  br i1 %t251, label %logical_and_right_248, label %logical_and_merge_248

logical_and_right_248:
  %t252 = load double, double* %l2
  %t253 = sitofp i64 0 to double
  %t254 = fcmp ole double %t252, %t253
  br label %logical_and_right_end_248

logical_and_right_end_248:
  br label %logical_and_merge_248

logical_and_merge_248:
  %t255 = phi i1 [ false, %logical_and_entry_248 ], [ %t254, %logical_and_right_end_248 ]
  br label %logical_and_entry_247

logical_and_entry_247:
  br i1 %t255, label %logical_and_right_247, label %logical_and_merge_247

logical_and_right_247:
  %t256 = load double, double* %l3
  %t257 = sitofp i64 0 to double
  %t258 = fcmp ole double %t256, %t257
  br label %logical_and_right_end_247

logical_and_right_end_247:
  br label %logical_and_merge_247

logical_and_merge_247:
  %t259 = phi i1 [ false, %logical_and_entry_247 ], [ %t258, %logical_and_right_end_247 ]
  %t260 = load i8*, i8** %l0
  %t261 = load double, double* %l1
  %t262 = load double, double* %l2
  %t263 = load double, double* %l3
  %t264 = load i8*, i8** %l4
  %t265 = load double, double* %l5
  %t266 = load double, double* %l6
  %t267 = load i1, i1* %l7
  br i1 %t259, label %then24, label %merge25
then24:
  %t268 = load i8*, i8** %l4
  %t269 = call i8* @trim_text(i8* %t268)
  %t270 = call i8* @trim_trailing_delimiters(i8* %t269)
  store i8* %t270, i8** %l15
  %t271 = load i8*, i8** %l15
  %t272 = insertvalue %ExpressionContinuationCapture undef, i8* %t271, 0
  %t273 = load double, double* %l6
  %t274 = insertvalue %ExpressionContinuationCapture %t272, double %t273, 1
  %t275 = insertvalue %ExpressionContinuationCapture %t274, i1 1, 2
  ret %ExpressionContinuationCapture %t275
merge25:
  %t276 = load i8*, i8** %l0
  %t277 = insertvalue %ExpressionContinuationCapture undef, i8* %t276, 0
  %t278 = sitofp i64 0 to double
  %t279 = insertvalue %ExpressionContinuationCapture %t277, double %t278, 1
  %t280 = insertvalue %ExpressionContinuationCapture %t279, i1 0, 2
  ret %ExpressionContinuationCapture %t280
}

define i1 @segment_signals_expression_continuation(i8* %segment) {
entry:
  %l0 = alloca i8
  %t2 = getelementptr i8, i8* %segment, i64 0
  %t3 = load i8, i8* %t2
  store i8 %t3, i8* %l0
  %t6 = load i8, i8* %l0
  ret i1 0
}

define double @compute_brace_balance(i8* %text) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i8
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = load double, double* %l0
  %t3 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t31 = phi double [ %t2, %entry ], [ %t29, %loop.latch2 ]
  %t32 = phi double [ %t3, %entry ], [ %t30, %loop.latch2 ]
  store double %t31, double* %l0
  store double %t32, double* %l1
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  %t5 = load double, double* %l1
  %t6 = getelementptr i8, i8* %text, i64 %t5
  %t7 = load i8, i8* %t6
  store i8 %t7, i8* %l2
  %t8 = load i8, i8* %l2
  %t9 = icmp eq i8 %t8, 123
  %t10 = load double, double* %l0
  %t11 = load double, double* %l1
  %t12 = load i8, i8* %l2
  br i1 %t9, label %then4, label %else5
then4:
  %t13 = load double, double* %l0
  %t14 = sitofp i64 1 to double
  %t15 = fadd double %t13, %t14
  store double %t15, double* %l0
  br label %merge6
else5:
  %t16 = load i8, i8* %l2
  %t17 = icmp eq i8 %t16, 125
  %t18 = load double, double* %l0
  %t19 = load double, double* %l1
  %t20 = load i8, i8* %l2
  br i1 %t17, label %then7, label %merge8
then7:
  %t21 = load double, double* %l0
  %t22 = sitofp i64 1 to double
  %t23 = fsub double %t21, %t22
  store double %t23, double* %l0
  br label %merge8
merge8:
  %t24 = phi double [ %t23, %then7 ], [ %t18, %else5 ]
  store double %t24, double* %l0
  br label %merge6
merge6:
  %t25 = phi double [ %t15, %then4 ], [ %t23, %else5 ]
  store double %t25, double* %l0
  %t26 = load double, double* %l1
  %t27 = sitofp i64 1 to double
  %t28 = fadd double %t26, %t27
  store double %t28, double* %l1
  br label %loop.latch2
loop.latch2:
  %t29 = load double, double* %l0
  %t30 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t33 = load double, double* %l0
  ret double %t33
}

define double @compute_parenthesis_balance(i8* %text) {
entry:
  %s0 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.0, i32 0, i32 0
  %t1 = call double @compute_symbol_balance(i8* %text, i8* %s0)
  ret double %t1
}

define double @compute_bracket_balance(i8* %text) {
entry:
  %s0 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.0, i32 0, i32 0
  %t1 = call double @compute_symbol_balance(i8* %text, i8* %s0)
  ret double %t1
}

define double @compute_symbol_balance(i8* %text, i8* %open, i8* %close) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i8
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = load double, double* %l0
  %t3 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t35 = phi double [ %t2, %entry ], [ %t33, %loop.latch2 ]
  %t36 = phi double [ %t3, %entry ], [ %t34, %loop.latch2 ]
  store double %t35, double* %l0
  store double %t36, double* %l1
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  %t5 = load double, double* %l1
  %t6 = getelementptr i8, i8* %text, i64 %t5
  %t7 = load i8, i8* %t6
  store i8 %t7, i8* %l2
  %t8 = load i8, i8* %l2
  %t9 = getelementptr i8, i8* %open, i64 0
  %t10 = load i8, i8* %t9
  %t11 = icmp eq i8 %t8, %t10
  %t12 = load double, double* %l0
  %t13 = load double, double* %l1
  %t14 = load i8, i8* %l2
  br i1 %t11, label %then4, label %else5
then4:
  %t15 = load double, double* %l0
  %t16 = sitofp i64 1 to double
  %t17 = fadd double %t15, %t16
  store double %t17, double* %l0
  br label %merge6
else5:
  %t18 = load i8, i8* %l2
  %t19 = getelementptr i8, i8* %close, i64 0
  %t20 = load i8, i8* %t19
  %t21 = icmp eq i8 %t18, %t20
  %t22 = load double, double* %l0
  %t23 = load double, double* %l1
  %t24 = load i8, i8* %l2
  br i1 %t21, label %then7, label %merge8
then7:
  %t25 = load double, double* %l0
  %t26 = sitofp i64 1 to double
  %t27 = fsub double %t25, %t26
  store double %t27, double* %l0
  br label %merge8
merge8:
  %t28 = phi double [ %t27, %then7 ], [ %t22, %else5 ]
  store double %t28, double* %l0
  br label %merge6
merge6:
  %t29 = phi double [ %t17, %then4 ], [ %t27, %else5 ]
  store double %t29, double* %l0
  %t30 = load double, double* %l1
  %t31 = sitofp i64 1 to double
  %t32 = fadd double %t30, %t31
  store double %t32, double* %l1
  br label %loop.latch2
loop.latch2:
  %t33 = load double, double* %l0
  %t34 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t37 = load double, double* %l0
  ret double %t37
}

define { i8**, i64 }* @split_struct_field_entries(i8* %text) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i1
  %l5 = alloca i8*
  %l6 = alloca i8
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
  %t142 = phi i8* [ %t10, %entry ], [ %t136, %loop.latch2 ]
  %t143 = phi double [ %t12, %entry ], [ %t137, %loop.latch2 ]
  %t144 = phi i1 [ %t13, %entry ], [ %t138, %loop.latch2 ]
  %t145 = phi i8* [ %t14, %entry ], [ %t139, %loop.latch2 ]
  %t146 = phi double [ %t11, %entry ], [ %t140, %loop.latch2 ]
  %t147 = phi { i8**, i64 }* [ %t9, %entry ], [ %t141, %loop.latch2 ]
  store i8* %t142, i8** %l1
  store double %t143, double* %l3
  store i1 %t144, i1* %l4
  store i8* %t145, i8** %l5
  store double %t146, double* %l2
  store { i8**, i64 }* %t147, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t15 = load double, double* %l3
  %t16 = load double, double* %l3
  %t17 = getelementptr i8, i8* %text, i64 %t16
  %t18 = load i8, i8* %t17
  store i8 %t18, i8* %l6
  %t19 = load i1, i1* %l4
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t21 = load i8*, i8** %l1
  %t22 = load double, double* %l2
  %t23 = load double, double* %l3
  %t24 = load i1, i1* %l4
  %t25 = load i8*, i8** %l5
  %t26 = load i8, i8* %l6
  br i1 %t19, label %then4, label %merge5
then4:
  %t27 = load i8*, i8** %l1
  %t28 = load i8, i8* %l6
  %t29 = getelementptr i8, i8* %t27, i64 0
  %t30 = load i8, i8* %t29
  %t31 = add i8 %t30, %t28
  store i8* null, i8** %l1
  %t32 = load i8, i8* %l6
  %t33 = icmp eq i8 %t32, 92
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t35 = load i8*, i8** %l1
  %t36 = load double, double* %l2
  %t37 = load double, double* %l3
  %t38 = load i1, i1* %l4
  %t39 = load i8*, i8** %l5
  %t40 = load i8, i8* %l6
  br i1 %t33, label %then6, label %else7
then6:
  %t41 = load double, double* %l3
  %t42 = sitofp i64 1 to double
  %t43 = fadd double %t41, %t42
  store double %t43, double* %l3
  %t44 = load double, double* %l3
  br label %merge8
else7:
  %t45 = load i8, i8* %l6
  %t46 = load i8*, i8** %l5
  %t47 = getelementptr i8, i8* %t46, i64 0
  %t48 = load i8, i8* %t47
  %t49 = icmp eq i8 %t45, %t48
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t51 = load i8*, i8** %l1
  %t52 = load double, double* %l2
  %t53 = load double, double* %l3
  %t54 = load i1, i1* %l4
  %t55 = load i8*, i8** %l5
  %t56 = load i8, i8* %l6
  br i1 %t49, label %then9, label %merge10
then9:
  store i1 0, i1* %l4
  br label %merge10
merge10:
  %t57 = phi i1 [ 0, %then9 ], [ %t54, %else7 ]
  store i1 %t57, i1* %l4
  br label %merge8
merge8:
  %t58 = phi double [ %t43, %then6 ], [ %t37, %else7 ]
  %t59 = phi i1 [ %t38, %then6 ], [ 0, %else7 ]
  store double %t58, double* %l3
  store i1 %t59, i1* %l4
  %t60 = load double, double* %l3
  %t61 = sitofp i64 1 to double
  %t62 = fadd double %t60, %t61
  store double %t62, double* %l3
  br label %loop.latch2
merge5:
  %t64 = load i8, i8* %l6
  %t65 = icmp eq i8 %t64, 34
  br label %logical_or_entry_63

logical_or_entry_63:
  br i1 %t65, label %logical_or_merge_63, label %logical_or_right_63

logical_or_right_63:
  %t66 = load i8, i8* %l6
  %t67 = icmp eq i8 %t66, 39
  br label %logical_or_right_end_63

logical_or_right_end_63:
  br label %logical_or_merge_63

logical_or_merge_63:
  %t68 = phi i1 [ true, %logical_or_entry_63 ], [ %t67, %logical_or_right_end_63 ]
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t70 = load i8*, i8** %l1
  %t71 = load double, double* %l2
  %t72 = load double, double* %l3
  %t73 = load i1, i1* %l4
  %t74 = load i8*, i8** %l5
  %t75 = load i8, i8* %l6
  br i1 %t68, label %then11, label %merge12
then11:
  store i1 1, i1* %l4
  %t76 = load i8, i8* %l6
  store i8* null, i8** %l5
  %t77 = load i8*, i8** %l1
  %t78 = load i8, i8* %l6
  %t79 = getelementptr i8, i8* %t77, i64 0
  %t80 = load i8, i8* %t79
  %t81 = add i8 %t80, %t78
  store i8* null, i8** %l1
  %t82 = load double, double* %l3
  %t83 = sitofp i64 1 to double
  %t84 = fadd double %t82, %t83
  store double %t84, double* %l3
  br label %loop.latch2
merge12:
  %t87 = load i8, i8* %l6
  %t88 = icmp eq i8 %t87, 123
  br label %logical_or_entry_86

logical_or_entry_86:
  br i1 %t88, label %logical_or_merge_86, label %logical_or_right_86

logical_or_right_86:
  %t89 = load i8, i8* %l6
  %t90 = icmp eq i8 %t89, 91
  br label %logical_or_right_end_86

logical_or_right_end_86:
  br label %logical_or_merge_86

logical_or_merge_86:
  %t91 = phi i1 [ true, %logical_or_entry_86 ], [ %t90, %logical_or_right_end_86 ]
  br label %logical_or_entry_85

logical_or_entry_85:
  br i1 %t91, label %logical_or_merge_85, label %logical_or_right_85

logical_or_right_85:
  %t92 = load i8, i8* %l6
  %t93 = icmp eq i8 %t92, 40
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
  %t101 = load i8, i8* %l6
  br i1 %t94, label %then13, label %else14
then13:
  %t102 = load double, double* %l2
  %t103 = sitofp i64 1 to double
  %t104 = fadd double %t102, %t103
  store double %t104, double* %l2
  br label %merge15
else14:
  %t105 = load i8, i8* %l6
  br label %merge15
merge15:
  %t107 = phi double [ %t104, %then13 ], [ %t97, %else14 ]
  store double %t107, double* %l2
  %t109 = load i8, i8* %l6
  %t110 = icmp eq i8 %t109, 44
  br label %logical_and_entry_108

logical_and_entry_108:
  br i1 %t110, label %logical_and_right_108, label %logical_and_merge_108

logical_and_right_108:
  %t111 = load double, double* %l2
  %t112 = sitofp i64 0 to double
  %t113 = fcmp oeq double %t111, %t112
  br label %logical_and_right_end_108

logical_and_right_end_108:
  br label %logical_and_merge_108

logical_and_merge_108:
  %t114 = phi i1 [ false, %logical_and_entry_108 ], [ %t113, %logical_and_right_end_108 ]
  %t115 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t116 = load i8*, i8** %l1
  %t117 = load double, double* %l2
  %t118 = load double, double* %l3
  %t119 = load i1, i1* %l4
  %t120 = load i8*, i8** %l5
  %t121 = load i8, i8* %l6
  br i1 %t114, label %then16, label %else17
then16:
  %t122 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t123 = load i8*, i8** %l1
  %t124 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t122, i8* %t123)
  store { i8**, i64 }* %t124, { i8**, i64 }** %l0
  %s125 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.125, i32 0, i32 0
  store i8* %s125, i8** %l1
  br label %merge18
else17:
  %t126 = load i8*, i8** %l1
  %t127 = load i8, i8* %l6
  %t128 = getelementptr i8, i8* %t126, i64 0
  %t129 = load i8, i8* %t128
  %t130 = add i8 %t129, %t127
  store i8* null, i8** %l1
  br label %merge18
merge18:
  %t131 = phi { i8**, i64 }* [ %t124, %then16 ], [ %t115, %else17 ]
  %t132 = phi i8* [ %s125, %then16 ], [ null, %else17 ]
  store { i8**, i64 }* %t131, { i8**, i64 }** %l0
  store i8* %t132, i8** %l1
  %t133 = load double, double* %l3
  %t134 = sitofp i64 1 to double
  %t135 = fadd double %t133, %t134
  store double %t135, double* %l3
  br label %loop.latch2
loop.latch2:
  %t136 = load i8*, i8** %l1
  %t137 = load double, double* %l3
  %t138 = load i1, i1* %l4
  %t139 = load i8*, i8** %l5
  %t140 = load double, double* %l2
  %t141 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t148 = load i8*, i8** %l1
  %t149 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t149
}

define { i8**, i64 }* @split_array_entries(i8* %text) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i1
  %l5 = alloca i8*
  %l6 = alloca i8
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
  %t142 = phi i8* [ %t10, %entry ], [ %t136, %loop.latch2 ]
  %t143 = phi double [ %t12, %entry ], [ %t137, %loop.latch2 ]
  %t144 = phi i1 [ %t13, %entry ], [ %t138, %loop.latch2 ]
  %t145 = phi i8* [ %t14, %entry ], [ %t139, %loop.latch2 ]
  %t146 = phi double [ %t11, %entry ], [ %t140, %loop.latch2 ]
  %t147 = phi { i8**, i64 }* [ %t9, %entry ], [ %t141, %loop.latch2 ]
  store i8* %t142, i8** %l1
  store double %t143, double* %l3
  store i1 %t144, i1* %l4
  store i8* %t145, i8** %l5
  store double %t146, double* %l2
  store { i8**, i64 }* %t147, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t15 = load double, double* %l3
  %t16 = load double, double* %l3
  %t17 = getelementptr i8, i8* %text, i64 %t16
  %t18 = load i8, i8* %t17
  store i8 %t18, i8* %l6
  %t19 = load i1, i1* %l4
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t21 = load i8*, i8** %l1
  %t22 = load double, double* %l2
  %t23 = load double, double* %l3
  %t24 = load i1, i1* %l4
  %t25 = load i8*, i8** %l5
  %t26 = load i8, i8* %l6
  br i1 %t19, label %then4, label %merge5
then4:
  %t27 = load i8*, i8** %l1
  %t28 = load i8, i8* %l6
  %t29 = getelementptr i8, i8* %t27, i64 0
  %t30 = load i8, i8* %t29
  %t31 = add i8 %t30, %t28
  store i8* null, i8** %l1
  %t32 = load i8, i8* %l6
  %t33 = icmp eq i8 %t32, 92
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t35 = load i8*, i8** %l1
  %t36 = load double, double* %l2
  %t37 = load double, double* %l3
  %t38 = load i1, i1* %l4
  %t39 = load i8*, i8** %l5
  %t40 = load i8, i8* %l6
  br i1 %t33, label %then6, label %else7
then6:
  %t41 = load double, double* %l3
  %t42 = sitofp i64 1 to double
  %t43 = fadd double %t41, %t42
  store double %t43, double* %l3
  %t44 = load double, double* %l3
  br label %merge8
else7:
  %t45 = load i8, i8* %l6
  %t46 = load i8*, i8** %l5
  %t47 = getelementptr i8, i8* %t46, i64 0
  %t48 = load i8, i8* %t47
  %t49 = icmp eq i8 %t45, %t48
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t51 = load i8*, i8** %l1
  %t52 = load double, double* %l2
  %t53 = load double, double* %l3
  %t54 = load i1, i1* %l4
  %t55 = load i8*, i8** %l5
  %t56 = load i8, i8* %l6
  br i1 %t49, label %then9, label %merge10
then9:
  store i1 0, i1* %l4
  br label %merge10
merge10:
  %t57 = phi i1 [ 0, %then9 ], [ %t54, %else7 ]
  store i1 %t57, i1* %l4
  br label %merge8
merge8:
  %t58 = phi double [ %t43, %then6 ], [ %t37, %else7 ]
  %t59 = phi i1 [ %t38, %then6 ], [ 0, %else7 ]
  store double %t58, double* %l3
  store i1 %t59, i1* %l4
  %t60 = load double, double* %l3
  %t61 = sitofp i64 1 to double
  %t62 = fadd double %t60, %t61
  store double %t62, double* %l3
  br label %loop.latch2
merge5:
  %t64 = load i8, i8* %l6
  %t65 = icmp eq i8 %t64, 34
  br label %logical_or_entry_63

logical_or_entry_63:
  br i1 %t65, label %logical_or_merge_63, label %logical_or_right_63

logical_or_right_63:
  %t66 = load i8, i8* %l6
  %t67 = icmp eq i8 %t66, 39
  br label %logical_or_right_end_63

logical_or_right_end_63:
  br label %logical_or_merge_63

logical_or_merge_63:
  %t68 = phi i1 [ true, %logical_or_entry_63 ], [ %t67, %logical_or_right_end_63 ]
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t70 = load i8*, i8** %l1
  %t71 = load double, double* %l2
  %t72 = load double, double* %l3
  %t73 = load i1, i1* %l4
  %t74 = load i8*, i8** %l5
  %t75 = load i8, i8* %l6
  br i1 %t68, label %then11, label %merge12
then11:
  store i1 1, i1* %l4
  %t76 = load i8, i8* %l6
  store i8* null, i8** %l5
  %t77 = load i8*, i8** %l1
  %t78 = load i8, i8* %l6
  %t79 = getelementptr i8, i8* %t77, i64 0
  %t80 = load i8, i8* %t79
  %t81 = add i8 %t80, %t78
  store i8* null, i8** %l1
  %t82 = load double, double* %l3
  %t83 = sitofp i64 1 to double
  %t84 = fadd double %t82, %t83
  store double %t84, double* %l3
  br label %loop.latch2
merge12:
  %t87 = load i8, i8* %l6
  %t88 = icmp eq i8 %t87, 123
  br label %logical_or_entry_86

logical_or_entry_86:
  br i1 %t88, label %logical_or_merge_86, label %logical_or_right_86

logical_or_right_86:
  %t89 = load i8, i8* %l6
  %t90 = icmp eq i8 %t89, 91
  br label %logical_or_right_end_86

logical_or_right_end_86:
  br label %logical_or_merge_86

logical_or_merge_86:
  %t91 = phi i1 [ true, %logical_or_entry_86 ], [ %t90, %logical_or_right_end_86 ]
  br label %logical_or_entry_85

logical_or_entry_85:
  br i1 %t91, label %logical_or_merge_85, label %logical_or_right_85

logical_or_right_85:
  %t92 = load i8, i8* %l6
  %t93 = icmp eq i8 %t92, 40
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
  %t101 = load i8, i8* %l6
  br i1 %t94, label %then13, label %else14
then13:
  %t102 = load double, double* %l2
  %t103 = sitofp i64 1 to double
  %t104 = fadd double %t102, %t103
  store double %t104, double* %l2
  br label %merge15
else14:
  %t105 = load i8, i8* %l6
  br label %merge15
merge15:
  %t107 = phi double [ %t104, %then13 ], [ %t97, %else14 ]
  store double %t107, double* %l2
  %t109 = load i8, i8* %l6
  %t110 = icmp eq i8 %t109, 44
  br label %logical_and_entry_108

logical_and_entry_108:
  br i1 %t110, label %logical_and_right_108, label %logical_and_merge_108

logical_and_right_108:
  %t111 = load double, double* %l2
  %t112 = sitofp i64 0 to double
  %t113 = fcmp oeq double %t111, %t112
  br label %logical_and_right_end_108

logical_and_right_end_108:
  br label %logical_and_merge_108

logical_and_merge_108:
  %t114 = phi i1 [ false, %logical_and_entry_108 ], [ %t113, %logical_and_right_end_108 ]
  %t115 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t116 = load i8*, i8** %l1
  %t117 = load double, double* %l2
  %t118 = load double, double* %l3
  %t119 = load i1, i1* %l4
  %t120 = load i8*, i8** %l5
  %t121 = load i8, i8* %l6
  br i1 %t114, label %then16, label %else17
then16:
  %t122 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t123 = load i8*, i8** %l1
  %t124 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t122, i8* %t123)
  store { i8**, i64 }* %t124, { i8**, i64 }** %l0
  %s125 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.125, i32 0, i32 0
  store i8* %s125, i8** %l1
  br label %merge18
else17:
  %t126 = load i8*, i8** %l1
  %t127 = load i8, i8* %l6
  %t128 = getelementptr i8, i8* %t126, i64 0
  %t129 = load i8, i8* %t128
  %t130 = add i8 %t129, %t127
  store i8* null, i8** %l1
  br label %merge18
merge18:
  %t131 = phi { i8**, i64 }* [ %t124, %then16 ], [ %t115, %else17 ]
  %t132 = phi i8* [ %s125, %then16 ], [ null, %else17 ]
  store { i8**, i64 }* %t131, { i8**, i64 }** %l0
  store i8* %t132, i8** %l1
  %t133 = load double, double* %l3
  %t134 = sitofp i64 1 to double
  %t135 = fadd double %t133, %t134
  store double %t135, double* %l3
  br label %loop.latch2
loop.latch2:
  %t136 = load i8*, i8** %l1
  %t137 = load double, double* %l3
  %t138 = load i1, i1* %l4
  %t139 = load i8*, i8** %l5
  %t140 = load double, double* %l2
  %t141 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t148 = load i8*, i8** %l1
  %t149 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t149
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
  %t6 = load double, double* %l1
  br label %afterloop3
loop.latch2:
  br label %loop.header0
afterloop3:
  %t7 = load double, double* %l0
  %t8 = load double, double* %l0
  %t9 = fptosi double %t8 to i64
  %t10 = call i8* @sailfin_runtime_substring(i8* %text, i64 0, i64 %t9)
  ret i8* %t10
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
  %t22 = phi double [ %t1, %entry ], [ %t21, %loop.latch2 ]
  store double %t22, double* %l0
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
  %t12 = phi double [ %t5, %loop.body1 ], [ %t11, %loop.latch6 ]
  store double %t12, double* %l1
  br label %loop.body5
loop.body5:
  %t7 = load double, double* %l1
  %t8 = load double, double* %l1
  %t9 = sitofp i64 1 to double
  %t10 = fadd double %t8, %t9
  store double %t10, double* %l1
  br label %loop.latch6
loop.latch6:
  %t11 = load double, double* %l1
  br label %loop.header4
afterloop7:
  %t13 = load i1, i1* %l2
  %t14 = load double, double* %l0
  %t15 = load double, double* %l1
  %t16 = load i1, i1* %l2
  br i1 %t13, label %then8, label %merge9
then8:
  %t17 = load double, double* %l0
  ret double %t17
merge9:
  %t18 = load double, double* %l0
  %t19 = sitofp i64 1 to double
  %t20 = fadd double %t18, %t19
  store double %t20, double* %l0
  br label %loop.latch2
loop.latch2:
  %t21 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t23 = sitofp i64 -1 to double
  ret double %t23
}

define double @find_matching_brace(i8* %text, double %open_index) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i8
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  store double %open_index, double* %l1
  %t1 = load double, double* %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t44 = phi double [ %t1, %entry ], [ %t42, %loop.latch2 ]
  %t45 = phi double [ %t2, %entry ], [ %t43, %loop.latch2 ]
  store double %t44, double* %l0
  store double %t45, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load double, double* %l1
  %t5 = getelementptr i8, i8* %text, i64 %t4
  %t6 = load i8, i8* %t5
  store i8 %t6, i8* %l2
  %t7 = load i8, i8* %l2
  %t8 = icmp eq i8 %t7, 123
  %t9 = load double, double* %l0
  %t10 = load double, double* %l1
  %t11 = load i8, i8* %l2
  br i1 %t8, label %then4, label %else5
then4:
  %t12 = load double, double* %l0
  %t13 = sitofp i64 1 to double
  %t14 = fadd double %t12, %t13
  store double %t14, double* %l0
  br label %merge6
else5:
  %t15 = load i8, i8* %l2
  %t16 = icmp eq i8 %t15, 125
  %t17 = load double, double* %l0
  %t18 = load double, double* %l1
  %t19 = load i8, i8* %l2
  br i1 %t16, label %then7, label %merge8
then7:
  %t20 = load double, double* %l0
  %t21 = sitofp i64 0 to double
  %t22 = fcmp ole double %t20, %t21
  %t23 = load double, double* %l0
  %t24 = load double, double* %l1
  %t25 = load i8, i8* %l2
  br i1 %t22, label %then9, label %merge10
then9:
  %t26 = sitofp i64 -1 to double
  ret double %t26
merge10:
  %t27 = load double, double* %l0
  %t28 = sitofp i64 1 to double
  %t29 = fsub double %t27, %t28
  store double %t29, double* %l0
  %t30 = load double, double* %l0
  %t31 = sitofp i64 0 to double
  %t32 = fcmp oeq double %t30, %t31
  %t33 = load double, double* %l0
  %t34 = load double, double* %l1
  %t35 = load i8, i8* %l2
  br i1 %t32, label %then11, label %merge12
then11:
  %t36 = load double, double* %l1
  ret double %t36
merge12:
  br label %merge8
merge8:
  %t37 = phi double [ %t29, %then7 ], [ %t17, %else5 ]
  store double %t37, double* %l0
  br label %merge6
merge6:
  %t38 = phi double [ %t14, %then4 ], [ %t29, %else5 ]
  store double %t38, double* %l0
  %t39 = load double, double* %l1
  %t40 = sitofp i64 1 to double
  %t41 = fadd double %t39, %t40
  store double %t41, double* %l1
  br label %loop.latch2
loop.latch2:
  %t42 = load double, double* %l0
  %t43 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t46 = sitofp i64 -1 to double
  ret double %t46
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
  %t13 = getelementptr i8, i8* %text, i64 %t12
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
  ret i1 0
}

define double @find_next_square_open(i8* %text, double %start) {
entry:
  %l0 = alloca double
  %l1 = alloca i1
  %l2 = alloca i1
  %l3 = alloca i8
  store double %start, double* %l0
  store i1 0, i1* %l1
  store i1 0, i1* %l2
  %t0 = load double, double* %l0
  %t1 = load i1, i1* %l1
  %t2 = load i1, i1* %l2
  br label %loop.header0
loop.header0:
  %t83 = phi i1 [ %t1, %entry ], [ %t80, %loop.latch2 ]
  %t84 = phi double [ %t0, %entry ], [ %t81, %loop.latch2 ]
  %t85 = phi i1 [ %t2, %entry ], [ %t82, %loop.latch2 ]
  store i1 %t83, i1* %l1
  store double %t84, double* %l0
  store i1 %t85, i1* %l2
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l0
  %t4 = load double, double* %l0
  %t5 = getelementptr i8, i8* %text, i64 %t4
  %t6 = load i8, i8* %t5
  store i8 %t6, i8* %l3
  %t7 = load i8, i8* %l3
  %t8 = icmp eq i8 %t7, 39
  %t9 = load double, double* %l0
  %t10 = load i1, i1* %l1
  %t11 = load i1, i1* %l2
  %t12 = load i8, i8* %l3
  br i1 %t8, label %then4, label %merge5
then4:
  %t14 = load i1, i1* %l2
  br label %logical_and_entry_13

logical_and_entry_13:
  br i1 %t14, label %logical_and_right_13, label %logical_and_merge_13

logical_and_right_13:
  %t15 = load double, double* %l0
  %t16 = call i1 @is_escaped_quote(i8* %text, double %t15)
  %t17 = xor i1 %t16, 1
  br label %logical_and_right_end_13

logical_and_right_end_13:
  br label %logical_and_merge_13

logical_and_merge_13:
  %t18 = phi i1 [ false, %logical_and_entry_13 ], [ %t17, %logical_and_right_end_13 ]
  %t19 = xor i1 %t18, 1
  %t20 = load double, double* %l0
  %t21 = load i1, i1* %l1
  %t22 = load i1, i1* %l2
  %t23 = load i8, i8* %l3
  br i1 %t19, label %then6, label %merge7
then6:
  %t24 = load i1, i1* %l1
  %t25 = xor i1 %t24, 1
  store i1 %t25, i1* %l1
  br label %merge7
merge7:
  %t26 = phi i1 [ %t25, %then6 ], [ %t21, %then4 ]
  store i1 %t26, i1* %l1
  %t27 = load double, double* %l0
  %t28 = sitofp i64 1 to double
  %t29 = fadd double %t27, %t28
  store double %t29, double* %l0
  br label %loop.latch2
merge5:
  %t30 = load i8, i8* %l3
  %t31 = icmp eq i8 %t30, 34
  %t32 = load double, double* %l0
  %t33 = load i1, i1* %l1
  %t34 = load i1, i1* %l2
  %t35 = load i8, i8* %l3
  br i1 %t31, label %then8, label %merge9
then8:
  %t37 = load i1, i1* %l1
  br label %logical_and_entry_36

logical_and_entry_36:
  br i1 %t37, label %logical_and_right_36, label %logical_and_merge_36

logical_and_right_36:
  %t38 = load double, double* %l0
  %t39 = call i1 @is_escaped_quote(i8* %text, double %t38)
  %t40 = xor i1 %t39, 1
  br label %logical_and_right_end_36

logical_and_right_end_36:
  br label %logical_and_merge_36

logical_and_merge_36:
  %t41 = phi i1 [ false, %logical_and_entry_36 ], [ %t40, %logical_and_right_end_36 ]
  %t42 = xor i1 %t41, 1
  %t43 = load double, double* %l0
  %t44 = load i1, i1* %l1
  %t45 = load i1, i1* %l2
  %t46 = load i8, i8* %l3
  br i1 %t42, label %then10, label %merge11
then10:
  %t47 = load i1, i1* %l2
  %t48 = xor i1 %t47, 1
  store i1 %t48, i1* %l2
  br label %merge11
merge11:
  %t49 = phi i1 [ %t48, %then10 ], [ %t45, %then8 ]
  store i1 %t49, i1* %l2
  %t50 = load double, double* %l0
  %t51 = sitofp i64 1 to double
  %t52 = fadd double %t50, %t51
  store double %t52, double* %l0
  br label %loop.latch2
merge9:
  %t54 = load i1, i1* %l1
  br label %logical_and_entry_53

logical_and_entry_53:
  br i1 %t54, label %logical_and_right_53, label %logical_and_merge_53

logical_and_right_53:
  %t55 = load i1, i1* %l2
  %t56 = xor i1 %t55, 1
  br label %logical_and_right_end_53

logical_and_right_end_53:
  br label %logical_and_merge_53

logical_and_merge_53:
  %t57 = phi i1 [ false, %logical_and_entry_53 ], [ %t56, %logical_and_right_end_53 ]
  %t58 = xor i1 %t57, 1
  %t59 = load double, double* %l0
  %t60 = load i1, i1* %l1
  %t61 = load i1, i1* %l2
  %t62 = load i8, i8* %l3
  br i1 %t58, label %then12, label %merge13
then12:
  %t63 = load i8, i8* %l3
  %t64 = icmp eq i8 %t63, 91
  %t65 = load double, double* %l0
  %t66 = load i1, i1* %l1
  %t67 = load i1, i1* %l2
  %t68 = load i8, i8* %l3
  br i1 %t64, label %then14, label %merge15
then14:
  %t69 = load double, double* %l0
  ret double %t69
merge15:
  %t70 = load i8, i8* %l3
  %t71 = icmp eq i8 %t70, 93
  %t72 = load double, double* %l0
  %t73 = load i1, i1* %l1
  %t74 = load i1, i1* %l2
  %t75 = load i8, i8* %l3
  br i1 %t71, label %then16, label %merge17
then16:
  %t76 = sitofp i64 -1 to double
  ret double %t76
merge17:
  br label %merge13
merge13:
  %t77 = load double, double* %l0
  %t78 = sitofp i64 1 to double
  %t79 = fadd double %t77, %t78
  store double %t79, double* %l0
  br label %loop.latch2
loop.latch2:
  %t80 = load i1, i1* %l1
  %t81 = load double, double* %l0
  %t82 = load i1, i1* %l2
  br label %loop.header0
afterloop3:
  %t86 = sitofp i64 -1 to double
  ret double %t86
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
  %t119 = phi i1 [ %t3, %entry ], [ %t115, %loop.latch2 ]
  %t120 = phi double [ %t2, %entry ], [ %t116, %loop.latch2 ]
  %t121 = phi i1 [ %t4, %entry ], [ %t117, %loop.latch2 ]
  %t122 = phi double [ %t1, %entry ], [ %t118, %loop.latch2 ]
  store i1 %t119, i1* %l2
  store double %t120, double* %l1
  store i1 %t121, i1* %l3
  store double %t122, double* %l0
  br label %loop.body1
loop.body1:
  %t5 = load double, double* %l1
  %t6 = load double, double* %l1
  %t7 = getelementptr i8, i8* %text, i64 %t6
  %t8 = load i8, i8* %t7
  store i8 %t8, i8* %l4
  %t9 = load i8, i8* %l4
  %t10 = icmp eq i8 %t9, 39
  %t11 = load double, double* %l0
  %t12 = load double, double* %l1
  %t13 = load i1, i1* %l2
  %t14 = load i1, i1* %l3
  %t15 = load i8, i8* %l4
  br i1 %t10, label %then4, label %merge5
then4:
  %t17 = load i1, i1* %l3
  br label %logical_and_entry_16

logical_and_entry_16:
  br i1 %t17, label %logical_and_right_16, label %logical_and_merge_16

logical_and_right_16:
  %t18 = load double, double* %l1
  %t19 = call i1 @is_escaped_quote(i8* %text, double %t18)
  %t20 = xor i1 %t19, 1
  br label %logical_and_right_end_16

logical_and_right_end_16:
  br label %logical_and_merge_16

logical_and_merge_16:
  %t21 = phi i1 [ false, %logical_and_entry_16 ], [ %t20, %logical_and_right_end_16 ]
  %t22 = xor i1 %t21, 1
  %t23 = load double, double* %l0
  %t24 = load double, double* %l1
  %t25 = load i1, i1* %l2
  %t26 = load i1, i1* %l3
  %t27 = load i8, i8* %l4
  br i1 %t22, label %then6, label %merge7
then6:
  %t28 = load i1, i1* %l2
  %t29 = xor i1 %t28, 1
  store i1 %t29, i1* %l2
  br label %merge7
merge7:
  %t30 = phi i1 [ %t29, %then6 ], [ %t25, %then4 ]
  store i1 %t30, i1* %l2
  %t31 = load double, double* %l1
  %t32 = sitofp i64 1 to double
  %t33 = fadd double %t31, %t32
  store double %t33, double* %l1
  br label %loop.latch2
merge5:
  %t34 = load i8, i8* %l4
  %t35 = icmp eq i8 %t34, 34
  %t36 = load double, double* %l0
  %t37 = load double, double* %l1
  %t38 = load i1, i1* %l2
  %t39 = load i1, i1* %l3
  %t40 = load i8, i8* %l4
  br i1 %t35, label %then8, label %merge9
then8:
  %t42 = load i1, i1* %l2
  br label %logical_and_entry_41

logical_and_entry_41:
  br i1 %t42, label %logical_and_right_41, label %logical_and_merge_41

logical_and_right_41:
  %t43 = load double, double* %l1
  %t44 = call i1 @is_escaped_quote(i8* %text, double %t43)
  %t45 = xor i1 %t44, 1
  br label %logical_and_right_end_41

logical_and_right_end_41:
  br label %logical_and_merge_41

logical_and_merge_41:
  %t46 = phi i1 [ false, %logical_and_entry_41 ], [ %t45, %logical_and_right_end_41 ]
  %t47 = xor i1 %t46, 1
  %t48 = load double, double* %l0
  %t49 = load double, double* %l1
  %t50 = load i1, i1* %l2
  %t51 = load i1, i1* %l3
  %t52 = load i8, i8* %l4
  br i1 %t47, label %then10, label %merge11
then10:
  %t53 = load i1, i1* %l3
  %t54 = xor i1 %t53, 1
  store i1 %t54, i1* %l3
  br label %merge11
merge11:
  %t55 = phi i1 [ %t54, %then10 ], [ %t51, %then8 ]
  store i1 %t55, i1* %l3
  %t56 = load double, double* %l1
  %t57 = sitofp i64 1 to double
  %t58 = fadd double %t56, %t57
  store double %t58, double* %l1
  br label %loop.latch2
merge9:
  %t60 = load i1, i1* %l2
  br label %logical_and_entry_59

logical_and_entry_59:
  br i1 %t60, label %logical_and_right_59, label %logical_and_merge_59

logical_and_right_59:
  %t61 = load i1, i1* %l3
  %t62 = xor i1 %t61, 1
  br label %logical_and_right_end_59

logical_and_right_end_59:
  br label %logical_and_merge_59

logical_and_merge_59:
  %t63 = phi i1 [ false, %logical_and_entry_59 ], [ %t62, %logical_and_right_end_59 ]
  %t64 = xor i1 %t63, 1
  %t65 = load double, double* %l0
  %t66 = load double, double* %l1
  %t67 = load i1, i1* %l2
  %t68 = load i1, i1* %l3
  %t69 = load i8, i8* %l4
  br i1 %t64, label %then12, label %merge13
then12:
  %t70 = load i8, i8* %l4
  %t71 = icmp eq i8 %t70, 91
  %t72 = load double, double* %l0
  %t73 = load double, double* %l1
  %t74 = load i1, i1* %l2
  %t75 = load i1, i1* %l3
  %t76 = load i8, i8* %l4
  br i1 %t71, label %then14, label %else15
then14:
  %t77 = load double, double* %l0
  %t78 = sitofp i64 1 to double
  %t79 = fadd double %t77, %t78
  store double %t79, double* %l0
  br label %merge16
else15:
  %t80 = load i8, i8* %l4
  %t81 = icmp eq i8 %t80, 93
  %t82 = load double, double* %l0
  %t83 = load double, double* %l1
  %t84 = load i1, i1* %l2
  %t85 = load i1, i1* %l3
  %t86 = load i8, i8* %l4
  br i1 %t81, label %then17, label %merge18
then17:
  %t87 = load double, double* %l0
  %t88 = sitofp i64 0 to double
  %t89 = fcmp ole double %t87, %t88
  %t90 = load double, double* %l0
  %t91 = load double, double* %l1
  %t92 = load i1, i1* %l2
  %t93 = load i1, i1* %l3
  %t94 = load i8, i8* %l4
  br i1 %t89, label %then19, label %merge20
then19:
  %t95 = sitofp i64 -1 to double
  ret double %t95
merge20:
  %t96 = load double, double* %l0
  %t97 = sitofp i64 1 to double
  %t98 = fsub double %t96, %t97
  store double %t98, double* %l0
  %t99 = load double, double* %l0
  %t100 = sitofp i64 0 to double
  %t101 = fcmp oeq double %t99, %t100
  %t102 = load double, double* %l0
  %t103 = load double, double* %l1
  %t104 = load i1, i1* %l2
  %t105 = load i1, i1* %l3
  %t106 = load i8, i8* %l4
  br i1 %t101, label %then21, label %merge22
then21:
  %t107 = load double, double* %l1
  ret double %t107
merge22:
  br label %merge18
merge18:
  %t108 = phi double [ %t98, %then17 ], [ %t82, %else15 ]
  store double %t108, double* %l0
  br label %merge16
merge16:
  %t109 = phi double [ %t79, %then14 ], [ %t98, %else15 ]
  store double %t109, double* %l0
  br label %merge13
merge13:
  %t110 = phi double [ %t79, %then12 ], [ %t65, %loop.body1 ]
  %t111 = phi double [ %t98, %then12 ], [ %t65, %loop.body1 ]
  store double %t110, double* %l0
  store double %t111, double* %l0
  %t112 = load double, double* %l1
  %t113 = sitofp i64 1 to double
  %t114 = fadd double %t112, %t113
  store double %t114, double* %l1
  br label %loop.latch2
loop.latch2:
  %t115 = load i1, i1* %l2
  %t116 = load double, double* %l1
  %t117 = load i1, i1* %l3
  %t118 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t123 = sitofp i64 -1 to double
  ret double %t123
}

define double @find_substring_from(i8* %value, i8* %pattern, double %start) {
entry:
  %l0 = alloca double
  %l1 = alloca i1
  %l2 = alloca double
  store double %start, double* %l0
  %t0 = load double, double* %l0
  %t1 = sitofp i64 0 to double
  %t2 = fcmp olt double %t0, %t1
  %t3 = load double, double* %l0
  br i1 %t2, label %then0, label %merge1
then0:
  %t4 = sitofp i64 0 to double
  store double %t4, double* %l0
  br label %merge1
merge1:
  %t5 = phi double [ %t4, %then0 ], [ %t3, %entry ]
  store double %t5, double* %l0
  %t6 = load double, double* %l0
  br label %loop.header2
loop.header2:
  %t27 = phi double [ %t6, %entry ], [ %t26, %loop.latch4 ]
  store double %t27, double* %l0
  br label %loop.body3
loop.body3:
  %t7 = load double, double* %l0
  store i1 1, i1* %l1
  %t8 = sitofp i64 0 to double
  store double %t8, double* %l2
  %t9 = load double, double* %l0
  %t10 = load i1, i1* %l1
  %t11 = load double, double* %l2
  br label %loop.header6
loop.header6:
  %t17 = phi double [ %t11, %loop.body3 ], [ %t16, %loop.latch8 ]
  store double %t17, double* %l2
  br label %loop.body7
loop.body7:
  %t12 = load double, double* %l2
  %t13 = load double, double* %l2
  %t14 = sitofp i64 1 to double
  %t15 = fadd double %t13, %t14
  store double %t15, double* %l2
  br label %loop.latch8
loop.latch8:
  %t16 = load double, double* %l2
  br label %loop.header6
afterloop9:
  %t18 = load i1, i1* %l1
  %t19 = load double, double* %l0
  %t20 = load i1, i1* %l1
  %t21 = load double, double* %l2
  br i1 %t18, label %then10, label %merge11
then10:
  %t22 = load double, double* %l0
  ret double %t22
merge11:
  %t23 = load double, double* %l0
  %t24 = sitofp i64 1 to double
  %t25 = fadd double %t23, %t24
  store double %t25, double* %l0
  br label %loop.latch4
loop.latch4:
  %t26 = load double, double* %l0
  br label %loop.header2
afterloop5:
  %t28 = sitofp i64 -1 to double
  ret double %t28
}

define %PythonFunctionEmission @emit_python_function(%PythonBuilder %builder, %NativeFunction %function) {
entry:
  %l0 = alloca %PythonBuilder
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca i8*
  %l4 = alloca double
  %l5 = alloca { %MatchContext*, i64 }*
  %l6 = alloca double
  %l7 = alloca double
  %l8 = alloca i8*
  %l9 = alloca i64
  %l10 = alloca %MatchContext
  store %PythonBuilder %builder, %PythonBuilder* %l0
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t5 = extractvalue %NativeFunction %function, 1
  %t6 = call { i8**, i64 }* @render_python_parameters({ %NativeParameter*, i64 }* null)
  store { i8**, i64 }* %t6, { i8**, i64 }** %l2
  %s7 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.7, i32 0, i32 0
  %t8 = extractvalue %NativeFunction %function, 0
  %t9 = call i8* @sanitize_identifier(i8* %t8)
  %t10 = add i8* %s7, %t9
  %s11 = getelementptr inbounds [49 x i8], [49 x i8]* @.str.11, i32 0, i32 0
  %t12 = add i8* %t10, %s11
  store i8* %t12, i8** %l3
  %t13 = load %PythonBuilder, %PythonBuilder* %l0
  %t14 = load i8*, i8** %l3
  %t15 = call %PythonBuilder @builder_emit(%PythonBuilder %t13, i8* %t14)
  store %PythonBuilder %t15, %PythonBuilder* %l0
  %t16 = load %PythonBuilder, %PythonBuilder* %l0
  %t17 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t16)
  store %PythonBuilder %t17, %PythonBuilder* %l0
  %t18 = extractvalue %NativeFunction %function, 3
  %t19 = load { i8**, i64 }, { i8**, i64 }* %t18
  %t20 = extractvalue { i8**, i64 } %t19, 1
  %t21 = icmp sgt i64 %t20, 0
  %t22 = load %PythonBuilder, %PythonBuilder* %l0
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t25 = load i8*, i8** %l3
  br i1 %t21, label %then0, label %merge1
then0:
  %t26 = load %PythonBuilder, %PythonBuilder* %l0
  %s27 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.27, i32 0, i32 0
  %t28 = extractvalue %NativeFunction %function, 3
  br label %merge1
merge1:
  %t29 = phi %PythonBuilder [ zeroinitializer, %then0 ], [ %t22, %entry ]
  store %PythonBuilder %t29, %PythonBuilder* %l0
  %t30 = extractvalue %NativeFunction %function, 4
  %t31 = load { i8**, i64 }, { i8**, i64 }* %t30
  %t32 = extractvalue { i8**, i64 } %t31, 1
  %t33 = icmp eq i64 %t32, 0
  %t34 = load %PythonBuilder, %PythonBuilder* %l0
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t37 = load i8*, i8** %l3
  br i1 %t33, label %then2, label %merge3
then2:
  %t38 = load %PythonBuilder, %PythonBuilder* %l0
  %s39 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.39, i32 0, i32 0
  %t40 = call %PythonBuilder @builder_emit(%PythonBuilder %t38, i8* %s39)
  store %PythonBuilder %t40, %PythonBuilder* %l0
  %t41 = load %PythonBuilder, %PythonBuilder* %l0
  %t42 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t41)
  store %PythonBuilder %t42, %PythonBuilder* %l0
  %t43 = load %PythonBuilder, %PythonBuilder* %l0
  %t44 = insertvalue %PythonFunctionEmission undef, i8* null, 0
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t46 = insertvalue %PythonFunctionEmission %t44, { i8**, i64 }* %t45, 1
  ret %PythonFunctionEmission %t46
merge3:
  %t47 = sitofp i64 0 to double
  store double %t47, double* %l4
  %t48 = alloca [0 x double]
  %t49 = getelementptr [0 x double], [0 x double]* %t48, i32 0, i32 0
  %t50 = alloca { double*, i64 }
  %t51 = getelementptr { double*, i64 }, { double*, i64 }* %t50, i32 0, i32 0
  store double* %t49, double** %t51
  %t52 = getelementptr { double*, i64 }, { double*, i64 }* %t50, i32 0, i32 1
  store i64 0, i64* %t52
  store { %MatchContext*, i64 }* null, { %MatchContext*, i64 }** %l5
  %t53 = sitofp i64 0 to double
  store double %t53, double* %l6
  %t54 = sitofp i64 0 to double
  store double %t54, double* %l7
  %t55 = load %PythonBuilder, %PythonBuilder* %l0
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t58 = load i8*, i8** %l3
  %t59 = load double, double* %l4
  %t60 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t61 = load double, double* %l6
  %t62 = load double, double* %l7
  br label %loop.header4
loop.header4:
  %t90 = phi double [ %t62, %entry ], [ %t89, %loop.latch6 ]
  store double %t90, double* %l7
  br label %loop.body5
loop.body5:
  %t63 = load double, double* %l7
  %t64 = extractvalue %NativeFunction %function, 4
  %t65 = load { i8**, i64 }, { i8**, i64 }* %t64
  %t66 = extractvalue { i8**, i64 } %t65, 1
  %t67 = sitofp i64 %t66 to double
  %t68 = fcmp oge double %t63, %t67
  %t69 = load %PythonBuilder, %PythonBuilder* %l0
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t72 = load i8*, i8** %l3
  %t73 = load double, double* %l4
  %t74 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t75 = load double, double* %l6
  %t76 = load double, double* %l7
  br i1 %t68, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t77 = extractvalue %NativeFunction %function, 4
  %t78 = load double, double* %l7
  %t79 = load { i8**, i64 }, { i8**, i64 }* %t77
  %t80 = extractvalue { i8**, i64 } %t79, 0
  %t81 = extractvalue { i8**, i64 } %t79, 1
  %t82 = icmp uge i64 %t78, %t81
  ; bounds check: %t82 (if true, out of bounds)
  %t83 = getelementptr i8*, i8** %t80, i64 %t78
  %t84 = load i8*, i8** %t83
  store i8* %t84, i8** %l8
  %t85 = load i8*, i8** %l8
  %t86 = load double, double* %l7
  %t87 = sitofp i64 1 to double
  %t88 = fadd double %t86, %t87
  store double %t88, double* %l7
  br label %loop.latch6
loop.latch6:
  %t89 = load double, double* %l7
  br label %loop.header4
afterloop7:
  %t91 = load %PythonBuilder, %PythonBuilder* %l0
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t94 = load i8*, i8** %l3
  %t95 = load double, double* %l4
  %t96 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t97 = load double, double* %l6
  %t98 = load double, double* %l7
  br label %loop.header10
loop.header10:
  %t149 = phi %PythonBuilder [ %t91, %entry ], [ %t146, %loop.latch12 ]
  %t150 = phi { i8**, i64 }* [ %t92, %entry ], [ %t147, %loop.latch12 ]
  %t151 = phi { %MatchContext*, i64 }* [ %t96, %entry ], [ %t148, %loop.latch12 ]
  store %PythonBuilder %t149, %PythonBuilder* %l0
  store { i8**, i64 }* %t150, { i8**, i64 }** %l1
  store { %MatchContext*, i64 }* %t151, { %MatchContext*, i64 }** %l5
  br label %loop.body11
loop.body11:
  %t99 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t100 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t99
  %t101 = extractvalue { %MatchContext*, i64 } %t100, 1
  %t102 = icmp eq i64 %t101, 0
  %t103 = load %PythonBuilder, %PythonBuilder* %l0
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t106 = load i8*, i8** %l3
  %t107 = load double, double* %l4
  %t108 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t109 = load double, double* %l6
  %t110 = load double, double* %l7
  br i1 %t102, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t111 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t112 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t111
  %t113 = extractvalue { %MatchContext*, i64 } %t112, 1
  %t114 = sub i64 %t113, 1
  store i64 %t114, i64* %l9
  %t115 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t116 = load i64, i64* %l9
  %t117 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t115
  %t118 = extractvalue { %MatchContext*, i64 } %t117, 0
  %t119 = extractvalue { %MatchContext*, i64 } %t117, 1
  %t120 = icmp uge i64 %t116, %t119
  ; bounds check: %t120 (if true, out of bounds)
  %t121 = getelementptr %MatchContext, %MatchContext* %t118, i64 %t116
  %t122 = load %MatchContext, %MatchContext* %t121
  store %MatchContext %t122, %MatchContext* %l10
  %t123 = load %MatchContext, %MatchContext* %l10
  %t124 = extractvalue %MatchContext %t123, 2
  %t125 = load %PythonBuilder, %PythonBuilder* %l0
  %t126 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t127 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t128 = load i8*, i8** %l3
  %t129 = load double, double* %l4
  %t130 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t131 = load double, double* %l6
  %t132 = load double, double* %l7
  %t133 = load i64, i64* %l9
  %t134 = load %MatchContext, %MatchContext* %l10
  br i1 %t124, label %then16, label %merge17
then16:
  %t135 = load %PythonBuilder, %PythonBuilder* %l0
  %t136 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t135)
  store %PythonBuilder %t136, %PythonBuilder* %l0
  br label %merge17
merge17:
  %t137 = phi %PythonBuilder [ %t136, %then16 ], [ %t125, %loop.body11 ]
  store %PythonBuilder %t137, %PythonBuilder* %l0
  %t138 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t139 = extractvalue %NativeFunction %function, 0
  %s140 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.140, i32 0, i32 0
  %t141 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t138, i8* %t139, i8* %s140)
  store { i8**, i64 }* %t141, { i8**, i64 }** %l1
  %t142 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t143 = load i64, i64* %l9
  %t144 = sitofp i64 %t143 to double
  %t145 = call { %MatchContext*, i64 }* @truncate_match_contexts({ %MatchContext*, i64 }* %t142, double %t144)
  store { %MatchContext*, i64 }* %t145, { %MatchContext*, i64 }** %l5
  br label %loop.latch12
loop.latch12:
  %t146 = load %PythonBuilder, %PythonBuilder* %l0
  %t147 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t148 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  br label %loop.header10
afterloop13:
  %t152 = load %PythonBuilder, %PythonBuilder* %l0
  %t153 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t154 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t155 = load i8*, i8** %l3
  %t156 = load double, double* %l4
  %t157 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t158 = load double, double* %l6
  %t159 = load double, double* %l7
  br label %loop.header18
loop.header18:
  %t181 = phi %PythonBuilder [ %t152, %entry ], [ %t178, %loop.latch20 ]
  %t182 = phi double [ %t156, %entry ], [ %t179, %loop.latch20 ]
  %t183 = phi { i8**, i64 }* [ %t153, %entry ], [ %t180, %loop.latch20 ]
  store %PythonBuilder %t181, %PythonBuilder* %l0
  store double %t182, double* %l4
  store { i8**, i64 }* %t183, { i8**, i64 }** %l1
  br label %loop.body19
loop.body19:
  %t160 = load double, double* %l4
  %t161 = sitofp i64 0 to double
  %t162 = fcmp ole double %t160, %t161
  %t163 = load %PythonBuilder, %PythonBuilder* %l0
  %t164 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t165 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t166 = load i8*, i8** %l3
  %t167 = load double, double* %l4
  %t168 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t169 = load double, double* %l6
  %t170 = load double, double* %l7
  br i1 %t162, label %then22, label %merge23
then22:
  br label %afterloop21
merge23:
  %t171 = load %PythonBuilder, %PythonBuilder* %l0
  %t172 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t171)
  store %PythonBuilder %t172, %PythonBuilder* %l0
  %t173 = load double, double* %l4
  %t174 = sitofp i64 1 to double
  %t175 = fsub double %t173, %t174
  store double %t175, double* %l4
  %t176 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t177 = extractvalue %NativeFunction %function, 0
  br label %loop.latch20
loop.latch20:
  %t178 = load %PythonBuilder, %PythonBuilder* %l0
  %t179 = load double, double* %l4
  %t180 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %loop.header18
afterloop21:
  %t184 = load %PythonBuilder, %PythonBuilder* %l0
  %t185 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t184)
  store %PythonBuilder %t185, %PythonBuilder* %l0
  %t186 = load %PythonBuilder, %PythonBuilder* %l0
  %t187 = insertvalue %PythonFunctionEmission undef, i8* null, 0
  %t188 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t189 = insertvalue %PythonFunctionEmission %t187, { i8**, i64 }* %t188, 1
  ret %PythonFunctionEmission %t189
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
  %t6 = call double @valuesconcat({ %MatchContext*, i64 }* %t3)
  ret { %MatchContext*, i64 }* null
}

define { %MatchContext*, i64 }* @replace_match_context({ %MatchContext*, i64 }* %values, double %index, %MatchContext %replacement) {
entry:
  %l0 = alloca { %MatchContext*, i64 }*
  %l1 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %MatchContext*, i64 }* null, { %MatchContext*, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t36 = phi { %MatchContext*, i64 }* [ %t6, %entry ], [ %t34, %loop.latch2 ]
  %t37 = phi double [ %t7, %entry ], [ %t35, %loop.latch2 ]
  store { %MatchContext*, i64 }* %t36, { %MatchContext*, i64 }** %l0
  store double %t37, double* %l1
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
  %t23 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %values
  %t24 = extractvalue { %MatchContext*, i64 } %t23, 0
  %t25 = extractvalue { %MatchContext*, i64 } %t23, 1
  %t26 = icmp uge i64 %t22, %t25
  ; bounds check: %t26 (if true, out of bounds)
  %t27 = getelementptr %MatchContext, %MatchContext* %t24, i64 %t22
  %t28 = load %MatchContext, %MatchContext* %t27
  %t29 = call { %MatchContext*, i64 }* @append_match_context({ %MatchContext*, i64 }* %t21, %MatchContext %t28)
  store { %MatchContext*, i64 }* %t29, { %MatchContext*, i64 }** %l0
  br label %merge8
merge8:
  %t30 = phi { %MatchContext*, i64 }* [ %t20, %then6 ], [ %t29, %else7 ]
  store { %MatchContext*, i64 }* %t30, { %MatchContext*, i64 }** %l0
  %t31 = load double, double* %l1
  %t32 = sitofp i64 1 to double
  %t33 = fadd double %t31, %t32
  store double %t33, double* %l1
  br label %loop.latch2
loop.latch2:
  %t34 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t35 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t38 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  ret { %MatchContext*, i64 }* %t38
}

define { %MatchContext*, i64 }* @truncate_match_contexts({ %MatchContext*, i64 }* %values, double %end_index) {
entry:
  %l0 = alloca { %MatchContext*, i64 }*
  %l1 = alloca double
  %t0 = sitofp i64 0 to double
  %t1 = fcmp ole double %end_index, %t0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = alloca [0 x double]
  %t3 = getelementptr [0 x double], [0 x double]* %t2, i32 0, i32 0
  %t4 = alloca { double*, i64 }
  %t5 = getelementptr { double*, i64 }, { double*, i64 }* %t4, i32 0, i32 0
  store double* %t3, double** %t5
  %t6 = getelementptr { double*, i64 }, { double*, i64 }* %t4, i32 0, i32 1
  store i64 0, i64* %t6
  ret { %MatchContext*, i64 }* null
merge1:
  %t7 = alloca [0 x double]
  %t8 = getelementptr [0 x double], [0 x double]* %t7, i32 0, i32 0
  %t9 = alloca { double*, i64 }
  %t10 = getelementptr { double*, i64 }, { double*, i64 }* %t9, i32 0, i32 0
  store double* %t8, double** %t10
  %t11 = getelementptr { double*, i64 }, { double*, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { %MatchContext*, i64 }* null, { %MatchContext*, i64 }** %l0
  %t12 = sitofp i64 0 to double
  store double %t12, double* %l1
  %t13 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t14 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t33 = phi { %MatchContext*, i64 }* [ %t13, %entry ], [ %t31, %loop.latch4 ]
  %t34 = phi double [ %t14, %entry ], [ %t32, %loop.latch4 ]
  store { %MatchContext*, i64 }* %t33, { %MatchContext*, i64 }** %l0
  store double %t34, double* %l1
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
  %t21 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %values
  %t22 = extractvalue { %MatchContext*, i64 } %t21, 0
  %t23 = extractvalue { %MatchContext*, i64 } %t21, 1
  %t24 = icmp uge i64 %t20, %t23
  ; bounds check: %t24 (if true, out of bounds)
  %t25 = getelementptr %MatchContext, %MatchContext* %t22, i64 %t20
  %t26 = load %MatchContext, %MatchContext* %t25
  %t27 = call { %MatchContext*, i64 }* @append_match_context({ %MatchContext*, i64 }* %t19, %MatchContext %t26)
  store { %MatchContext*, i64 }* %t27, { %MatchContext*, i64 }** %l0
  %t28 = load double, double* %l1
  %t29 = sitofp i64 1 to double
  %t30 = fadd double %t28, %t29
  store double %t30, double* %l1
  br label %loop.latch4
loop.latch4:
  %t31 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t32 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t35 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  ret { %MatchContext*, i64 }* %t35
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
  %l5 = alloca i1
  %l6 = alloca i8*
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
  br label %merge1
merge1:
  %t7 = load i8*, i8** %l0
  %t8 = load i8*, i8** %l0
  %t9 = call i8* @lower_expression(i8* %t8)
  store i8* %t9, i8** %l3
  store i8* null, i8** %l4
  store i1 0, i1* %l5
  %t10 = load i8*, i8** %l1
  %t11 = icmp ne i8* %t10, null
  %t12 = load i8*, i8** %l0
  %t13 = load i8*, i8** %l1
  %t14 = load i8*, i8** %l3
  %t15 = load i8*, i8** %l4
  %t16 = load i1, i1* %l5
  br i1 %t11, label %then2, label %merge3
then2:
  %t17 = load i8*, i8** %l1
  %t18 = call i8* @lower_expression(i8* %t17)
  store i8* %t18, i8** %l6
  %s19 = getelementptr inbounds [48 x i8], [48 x i8]* @.str.19, i32 0, i32 0
  store i8* %s19, i8** %l4
  store i1 1, i1* %l5
  br label %merge3
merge3:
  %t20 = phi i8* [ %s19, %then2 ], [ %t15, %entry ]
  %t21 = phi i1 [ 1, %then2 ], [ %t16, %entry ]
  store i8* %t20, i8** %l4
  store i1 %t21, i1* %l5
  %t22 = load i8*, i8** %l4
  %t23 = insertvalue %LoweredCaseCondition undef, i8* %t22, 0
  %t24 = insertvalue %LoweredCaseCondition %t23, i1 0, 1
  %t25 = load i1, i1* %l5
  %t26 = insertvalue %LoweredCaseCondition %t24, i1 %t25, 2
  ret %LoweredCaseCondition %t26
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
  ret i8* null
merge1:
  %s2 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.2, i32 0, i32 0
  store i8* %s2, i8** %l0
  store double %value, double* %l1
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.3, i32 0, i32 0
  store i8* %s3, i8** %l2
  %t4 = load i8*, i8** %l0
  %t5 = load double, double* %l1
  %t6 = load i8*, i8** %l2
  br label %loop.header2
loop.header2:
  %t53 = phi i8* [ %t6, %entry ], [ %t51, %loop.latch4 ]
  %t54 = phi double [ %t5, %entry ], [ %t52, %loop.latch4 ]
  store i8* %t53, i8** %l2
  store double %t54, double* %l1
  br label %loop.body3
loop.body3:
  %t7 = load double, double* %l1
  %t8 = sitofp i64 0 to double
  %t9 = fcmp ole double %t7, %t8
  %t10 = load i8*, i8** %l0
  %t11 = load double, double* %l1
  %t12 = load i8*, i8** %l2
  br i1 %t9, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t13 = load double, double* %l1
  store double %t13, double* %l3
  %t14 = sitofp i64 0 to double
  store double %t14, double* %l4
  %t15 = load i8*, i8** %l0
  %t16 = load double, double* %l1
  %t17 = load i8*, i8** %l2
  %t18 = load double, double* %l3
  %t19 = load double, double* %l4
  br label %loop.header8
loop.header8:
  %t36 = phi double [ %t18, %loop.body3 ], [ %t34, %loop.latch10 ]
  %t37 = phi double [ %t19, %loop.body3 ], [ %t35, %loop.latch10 ]
  store double %t36, double* %l3
  store double %t37, double* %l4
  br label %loop.body9
loop.body9:
  %t20 = load double, double* %l3
  %t21 = sitofp i64 10 to double
  %t22 = fcmp olt double %t20, %t21
  %t23 = load i8*, i8** %l0
  %t24 = load double, double* %l1
  %t25 = load i8*, i8** %l2
  %t26 = load double, double* %l3
  %t27 = load double, double* %l4
  br i1 %t22, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t28 = load double, double* %l3
  %t29 = sitofp i64 10 to double
  %t30 = fsub double %t28, %t29
  store double %t30, double* %l3
  %t31 = load double, double* %l4
  %t32 = sitofp i64 1 to double
  %t33 = fadd double %t31, %t32
  store double %t33, double* %l4
  br label %loop.latch10
loop.latch10:
  %t34 = load double, double* %l3
  %t35 = load double, double* %l4
  br label %loop.header8
afterloop11:
  %t38 = load double, double* %l3
  store double %t38, double* %l5
  %t39 = load i8*, i8** %l0
  %t40 = load double, double* %l5
  %t41 = load double, double* %l5
  %t42 = sitofp i64 1 to double
  %t43 = fadd double %t41, %t42
  %t44 = fptosi double %t40 to i64
  %t45 = fptosi double %t43 to i64
  %t46 = call i8* @sailfin_runtime_substring(i8* %t39, i64 %t44, i64 %t45)
  store i8* %t46, i8** %l6
  %t47 = load i8*, i8** %l6
  %t48 = load i8*, i8** %l2
  %t49 = add i8* %t47, %t48
  store i8* %t49, i8** %l2
  %t50 = load double, double* %l4
  store double %t50, double* %l1
  br label %loop.latch4
loop.latch4:
  %t51 = load i8*, i8** %l2
  %t52 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t55 = load i8*, i8** %l2
  ret i8* %t55
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
  %t3 = alloca [0 x double]
  %t4 = getelementptr [0 x double], [0 x double]* %t3, i32 0, i32 0
  %t5 = alloca { double*, i64 }
  %t6 = getelementptr { double*, i64 }, { double*, i64 }* %t5, i32 0, i32 0
  store double* %t4, double** %t6
  %t7 = getelementptr { double*, i64 }, { double*, i64 }* %t5, i32 0, i32 1
  store i64 0, i64* %t7
  ret { i8**, i64 }* null
merge1:
  %t8 = alloca [0 x double]
  %t9 = getelementptr [0 x double], [0 x double]* %t8, i32 0, i32 0
  %t10 = alloca { double*, i64 }
  %t11 = getelementptr { double*, i64 }, { double*, i64 }* %t10, i32 0, i32 0
  store double* %t9, double** %t11
  %t12 = getelementptr { double*, i64 }, { double*, i64 }* %t10, i32 0, i32 1
  store i64 0, i64* %t12
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t13 = sitofp i64 0 to double
  store double %t13, double* %l1
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t15 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t54 = phi { i8**, i64 }* [ %t14, %entry ], [ %t52, %loop.latch4 ]
  %t55 = phi double [ %t15, %entry ], [ %t53, %loop.latch4 ]
  store { i8**, i64 }* %t54, { i8**, i64 }** %l0
  store double %t55, double* %l1
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
  %t24 = load { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %parameters
  %t25 = extractvalue { %NativeParameter*, i64 } %t24, 0
  %t26 = extractvalue { %NativeParameter*, i64 } %t24, 1
  %t27 = icmp uge i64 %t23, %t26
  ; bounds check: %t27 (if true, out of bounds)
  %t28 = getelementptr %NativeParameter, %NativeParameter* %t25, i64 %t23
  %t29 = load %NativeParameter, %NativeParameter* %t28
  store %NativeParameter %t29, %NativeParameter* %l2
  %t30 = load %NativeParameter, %NativeParameter* %l2
  %t31 = extractvalue %NativeParameter %t30, 0
  store i8* %t31, i8** %l3
  %t32 = load %NativeParameter, %NativeParameter* %l2
  %t33 = extractvalue %NativeParameter %t32, 3
  %t34 = icmp ne i8* %t33, null
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t36 = load double, double* %l1
  %t37 = load %NativeParameter, %NativeParameter* %l2
  %t38 = load i8*, i8** %l3
  br i1 %t34, label %then8, label %merge9
then8:
  %t39 = load i8*, i8** %l3
  %s40 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.40, i32 0, i32 0
  %t41 = add i8* %t39, %s40
  %t42 = load %NativeParameter, %NativeParameter* %l2
  %t43 = extractvalue %NativeParameter %t42, 3
  %t44 = add i8* %t41, %t43
  store i8* %t44, i8** %l3
  br label %merge9
merge9:
  %t45 = phi i8* [ %t44, %then8 ], [ %t38, %loop.body3 ]
  store i8* %t45, i8** %l3
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t47 = load i8*, i8** %l3
  %t48 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t46, i8* %t47)
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
  ret { i8**, i64 }* %t56
}

define %PythonBuilder @builder_new() {
entry:
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  %t5 = insertvalue %PythonBuilder undef, { i8**, i64 }* null, 0
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
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = load i8*, i8** %l0
  %t3 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t17 = phi i8* [ %t2, %entry ], [ %t15, %loop.latch2 ]
  %t18 = phi double [ %t3, %entry ], [ %t16, %loop.latch2 ]
  store i8* %t17, i8** %l0
  store double %t18, double* %l1
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  %t5 = extractvalue %PythonBuilder %builder, 1
  %t6 = fcmp oge double %t4, %t5
  %t7 = load i8*, i8** %l0
  %t8 = load double, double* %l1
  br i1 %t6, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t9 = load i8*, i8** %l0
  %s10 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.10, i32 0, i32 0
  %t11 = add i8* %t9, %s10
  store i8* %t11, i8** %l0
  %t12 = load double, double* %l1
  %t13 = sitofp i64 1 to double
  %t14 = fadd double %t12, %t13
  store double %t14, double* %l1
  br label %loop.latch2
loop.latch2:
  %t15 = load i8*, i8** %l0
  %t16 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t19 = load i8*, i8** %l0
  %t20 = add i8* %t19, %line
  store i8* %t20, i8** %l2
  %t21 = extractvalue %PythonBuilder %builder, 0
  %t22 = load i8*, i8** %l2
  %t23 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t21, i8* %t22)
  store { i8**, i64 }* %t23, { i8**, i64 }** %l3
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t25 = insertvalue %PythonBuilder undef, { i8**, i64 }* %t24, 0
  %t26 = extractvalue %PythonBuilder %builder, 1
  %t27 = insertvalue %PythonBuilder %t25, double %t26, 1
  ret %PythonBuilder %t27
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
  %t1 = call i8* @join_with_separator({ i8**, i64 }* %t0, i8* null)
  store i8* %t1, i8** %l0
  %t2 = load i8*, i8** %l0
  %t3 = load i8*, i8** %l0
  %t4 = getelementptr i8, i8* %t3, i64 0
  %t5 = load i8, i8* %t4
  %t6 = add i8 %t5, 10
  ret i8* null
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
  %t34 = phi i8* [ %t2, %entry ], [ %t32, %loop.latch2 ]
  %t35 = phi double [ %t3, %entry ], [ %t33, %loop.latch2 ]
  store i8* %t34, i8** %l0
  store double %t35, double* %l1
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  %t5 = load double, double* %l1
  %t6 = getelementptr i8, i8* %name, i64 %t5
  %t7 = load i8, i8* %t6
  store i8 %t7, i8* %l2
  %t8 = load i8, i8* %l2
  %t9 = call i1 @is_identifier_char(i8* null)
  %t10 = load i8*, i8** %l0
  %t11 = load double, double* %l1
  %t12 = load i8, i8* %l2
  br i1 %t9, label %then4, label %else5
then4:
  %t13 = load i8*, i8** %l0
  %t14 = load i8, i8* %l2
  %t15 = getelementptr i8, i8* %t13, i64 0
  %t16 = load i8, i8* %t15
  %t17 = add i8 %t16, %t14
  store i8* null, i8** %l0
  br label %merge6
else5:
  %t18 = load i8, i8* %l2
  %t19 = icmp eq i8 %t18, 32
  %t20 = load i8*, i8** %l0
  %t21 = load double, double* %l1
  %t22 = load i8, i8* %l2
  br i1 %t19, label %then7, label %merge8
then7:
  %t23 = load i8*, i8** %l0
  %t24 = getelementptr i8, i8* %t23, i64 0
  %t25 = load i8, i8* %t24
  %t26 = add i8 %t25, 95
  store i8* null, i8** %l0
  br label %merge8
merge8:
  %t27 = phi i8* [ null, %then7 ], [ %t20, %else5 ]
  store i8* %t27, i8** %l0
  br label %merge6
merge6:
  %t28 = phi i8* [ null, %then4 ], [ null, %else5 ]
  store i8* %t28, i8** %l0
  %t29 = load double, double* %l1
  %t30 = sitofp i64 1 to double
  %t31 = fadd double %t29, %t30
  store double %t31, double* %l1
  br label %loop.latch2
loop.latch2:
  %t32 = load i8*, i8** %l0
  %t33 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t36 = load i8*, i8** %l0
  %t37 = load i8*, i8** %l0
  ret i8* %t37
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
  %s2 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.2, i32 0, i32 0
  store i8* %s2, i8** %l1
  %t3 = alloca [0 x double]
  %t4 = getelementptr [0 x double], [0 x double]* %t3, i32 0, i32 0
  %t5 = alloca { double*, i64 }
  %t6 = getelementptr { double*, i64 }, { double*, i64 }* %t5, i32 0, i32 0
  store double* %t4, double** %t6
  %t7 = getelementptr { double*, i64 }, { double*, i64 }* %t5, i32 0, i32 1
  store i64 0, i64* %t7
  store { i8**, i64 }* null, { i8**, i64 }** %l2
  %t8 = sitofp i64 0 to double
  store double %t8, double* %l3
  %t9 = load i8*, i8** %l0
  %t10 = load i8*, i8** %l1
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t12 = load double, double* %l3
  br label %loop.header0
loop.header0:
  %t38 = phi i8* [ %t10, %entry ], [ %t36, %loop.latch2 ]
  %t39 = phi double [ %t12, %entry ], [ %t37, %loop.latch2 ]
  store i8* %t38, i8** %l1
  store double %t39, double* %l3
  br label %loop.body1
loop.body1:
  %t13 = load double, double* %l3
  %t14 = load i8*, i8** %l0
  %t15 = load i8*, i8** %l0
  %t16 = load double, double* %l3
  %t17 = getelementptr i8, i8* %t15, i64 %t16
  %t18 = load i8, i8* %t17
  store i8 %t18, i8* %l4
  %t19 = load i8, i8* %l4
  %t20 = icmp eq i8 %t19, 46
  %t21 = load i8*, i8** %l0
  %t22 = load i8*, i8** %l1
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t24 = load double, double* %l3
  %t25 = load i8, i8* %l4
  br i1 %t20, label %then4, label %else5
then4:
  %t26 = load i8*, i8** %l1
  br label %merge6
else5:
  %t27 = load i8*, i8** %l1
  %t28 = load i8, i8* %l4
  %t29 = getelementptr i8, i8* %t27, i64 0
  %t30 = load i8, i8* %t29
  %t31 = add i8 %t30, %t28
  store i8* null, i8** %l1
  br label %merge6
merge6:
  %t32 = phi i8* [ %t22, %then4 ], [ null, %else5 ]
  store i8* %t32, i8** %l1
  %t33 = load double, double* %l3
  %t34 = sitofp i64 1 to double
  %t35 = fadd double %t33, %t34
  store double %t35, double* %l3
  br label %loop.latch2
loop.latch2:
  %t36 = load i8*, i8** %l1
  %t37 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t40 = load i8*, i8** %l1
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t42 = load { i8**, i64 }, { i8**, i64 }* %t41
  %t43 = extractvalue { i8**, i64 } %t42, 1
  %t44 = icmp eq i64 %t43, 0
  %t45 = load i8*, i8** %l0
  %t46 = load i8*, i8** %l1
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t48 = load double, double* %l3
  br i1 %t44, label %then7, label %merge8
then7:
  %t49 = load i8*, i8** %l0
  %t50 = call i8* @sanitize_identifier(i8* %t49)
  ret i8* %t50
merge8:
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t52 = call i8* @join_with_separator({ i8**, i64 }* %t51, i8* null)
  ret i8* %t52
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
  %l2 = alloca i8
  %l3 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  store double 0.0, double* %l1
  %t1 = load double, double* %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t32 = phi double [ %t1, %entry ], [ %t31, %loop.latch2 ]
  store double %t32, double* %l0
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
  %t14 = load i8, i8* %l2
  %t15 = icmp eq i8 %t14, 32
  br label %logical_or_entry_13

logical_or_entry_13:
  br i1 %t15, label %logical_or_merge_13, label %logical_or_right_13

logical_or_right_13:
  %t16 = load i8, i8* %l2
  %t17 = icmp eq i8 %t16, 10
  br label %logical_or_right_end_13

logical_or_right_end_13:
  br label %logical_or_merge_13

logical_or_merge_13:
  %t18 = phi i1 [ true, %logical_or_entry_13 ], [ %t17, %logical_or_right_end_13 ]
  br label %logical_or_entry_12

logical_or_entry_12:
  br i1 %t18, label %logical_or_merge_12, label %logical_or_right_12

logical_or_right_12:
  %t19 = load i8, i8* %l2
  %t20 = icmp eq i8 %t19, 13
  br label %logical_or_right_end_12

logical_or_right_end_12:
  br label %logical_or_merge_12

logical_or_merge_12:
  %t21 = phi i1 [ true, %logical_or_entry_12 ], [ %t20, %logical_or_right_end_12 ]
  br label %logical_or_entry_11

logical_or_entry_11:
  br i1 %t21, label %logical_or_merge_11, label %logical_or_right_11

logical_or_right_11:
  %t22 = load i8, i8* %l2
  %t23 = icmp eq i8 %t22, 9
  br label %logical_or_right_end_11

logical_or_right_end_11:
  br label %logical_or_merge_11

logical_or_merge_11:
  %t24 = phi i1 [ true, %logical_or_entry_11 ], [ %t23, %logical_or_right_end_11 ]
  %t25 = load double, double* %l0
  %t26 = load double, double* %l1
  %t27 = load i8, i8* %l2
  br i1 %t24, label %then6, label %merge7
then6:
  %t28 = load double, double* %l0
  %t29 = sitofp i64 1 to double
  %t30 = fadd double %t28, %t29
  store double %t30, double* %l0
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  %t31 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t33 = load double, double* %l0
  %t34 = load double, double* %l1
  br label %loop.header8
loop.header8:
  br label %loop.body9
loop.body9:
  %t35 = load double, double* %l1
  %t36 = load double, double* %l0
  %t37 = fcmp ole double %t35, %t36
  %t38 = load double, double* %l0
  %t39 = load double, double* %l1
  br i1 %t37, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  store double 0.0, double* %l3
  %t43 = load double, double* %l3
  br label %afterloop11
loop.latch10:
  br label %loop.header8
afterloop11:
  %t45 = load double, double* %l0
  %t46 = sitofp i64 0 to double
  %t47 = fcmp oeq double %t45, %t46
  br label %logical_and_entry_44

logical_and_entry_44:
  br i1 %t47, label %logical_and_right_44, label %logical_and_merge_44

logical_and_right_44:
  %t48 = load double, double* %l1
  %t49 = load double, double* %l0
  %t50 = load double, double* %l1
  %t51 = fptosi double %t49 to i64
  %t52 = fptosi double %t50 to i64
  %t53 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t51, i64 %t52)
  ret i8* %t53
}

define i1 @starts_with(i8* %value, i8* %prefix) {
entry:
  %l0 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t15 = phi double [ %t1, %entry ], [ %t14, %loop.latch2 ]
  store double %t15, double* %l0
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  %t3 = load double, double* %l0
  %t4 = getelementptr i8, i8* %value, i64 %t3
  %t5 = load i8, i8* %t4
  %t6 = load double, double* %l0
  %t7 = getelementptr i8, i8* %prefix, i64 %t6
  %t8 = load i8, i8* %t7
  %t9 = icmp ne i8 %t5, %t8
  %t10 = load double, double* %l0
  br i1 %t9, label %then4, label %merge5
then4:
  ret i1 0
merge5:
  %t11 = load double, double* %l0
  %t12 = sitofp i64 1 to double
  %t13 = fadd double %t11, %t12
  store double %t13, double* %l0
  br label %loop.latch2
loop.latch2:
  %t14 = load double, double* %l0
  br label %loop.header0
afterloop3:
  ret i1 1
}

define i1 @ends_with(i8* %value, i8* %suffix) {
entry:
  %l0 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t7 = phi double [ %t1, %entry ], [ %t6, %loop.latch2 ]
  store double %t7, double* %l0
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  %t3 = load double, double* %l0
  %t4 = sitofp i64 1 to double
  %t5 = fadd double %t3, %t4
  store double %t5, double* %l0
  br label %loop.latch2
loop.latch2:
  %t6 = load double, double* %l0
  br label %loop.header0
afterloop3:
  ret i1 1
}

define i8* @replace_all(i8* %value, i8* %target, i8* %replacement) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = load i8*, i8** %l0
  %t3 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t18 = phi i8* [ %t2, %entry ], [ %t16, %loop.latch2 ]
  %t19 = phi double [ %t3, %entry ], [ %t17, %loop.latch2 ]
  store i8* %t18, i8** %l0
  store double %t19, double* %l1
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  %t5 = load double, double* %l1
  %t6 = load i8*, i8** %l0
  %t7 = load double, double* %l1
  %t8 = getelementptr i8, i8* %value, i64 %t7
  %t9 = load i8, i8* %t8
  %t10 = getelementptr i8, i8* %t6, i64 0
  %t11 = load i8, i8* %t10
  %t12 = add i8 %t11, %t9
  store i8* null, i8** %l0
  %t13 = load double, double* %l1
  %t14 = sitofp i64 1 to double
  %t15 = fadd double %t13, %t14
  store double %t15, double* %l1
  br label %loop.latch2
loop.latch2:
  %t16 = load i8*, i8** %l0
  %t17 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t20 = load i8*, i8** %l0
  ret i8* %t20
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
  %t35 = phi i8* [ %t11, %entry ], [ %t33, %loop.latch4 ]
  %t36 = phi double [ %t12, %entry ], [ %t34, %loop.latch4 ]
  store i8* %t35, i8** %l0
  store double %t36, double* %l1
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
  %t23 = load { i8**, i64 }, { i8**, i64 }* %values
  %t24 = extractvalue { i8**, i64 } %t23, 0
  %t25 = extractvalue { i8**, i64 } %t23, 1
  %t26 = icmp uge i64 %t22, %t25
  ; bounds check: %t26 (if true, out of bounds)
  %t27 = getelementptr i8*, i8** %t24, i64 %t22
  %t28 = load i8*, i8** %t27
  %t29 = add i8* %t21, %t28
  store i8* %t29, i8** %l0
  %t30 = load double, double* %l1
  %t31 = sitofp i64 1 to double
  %t32 = fadd double %t30, %t31
  store double %t32, double* %l1
  br label %loop.latch4
loop.latch4:
  %t33 = load i8*, i8** %l0
  %t34 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t37 = load i8*, i8** %l0
  ret i8* %t37
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
  %t3 = load i8*, i8** %l1
  %t4 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %diagnostics, i8* %t3)
  ret { i8**, i64 }* %t4
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

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
