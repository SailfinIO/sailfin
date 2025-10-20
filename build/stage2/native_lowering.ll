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
%InstructionGatherResult = type { i8*, double }
%InstructionDepthState = type { double, double, double, i1, i1 }
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
@.str.18 = private unnamed_addr constant [6 x i8] c"from \00"
@.str.21 = private unnamed_addr constant [9 x i8] c" import \00"
@.str.12 = private unnamed_addr constant [5 x i8] c" as \00"
@.str.122 = private unnamed_addr constant [12 x i8] c"__all__ = [\00"
@.str.2 = private unnamed_addr constant [7 x i8] c"class \00"
@.str.99 = private unnamed_addr constant [20 x i8] c"def __repr__(self):\00"
@.str.40 = private unnamed_addr constant [96 x i8] c"return runtime.struct_repr('\22 + class_name + \22', [\22 + join_with_separator(rendered, \22, \22) + \22])\00"
@.str.97 = private unnamed_addr constant [1 x i8] c"\00"
@.str.0 = private unnamed_addr constant [7 x i8] c"(\22, \22)\00"
@.str.5 = private unnamed_addr constant [1 x i8] c"\00"
@.str.8 = private unnamed_addr constant [1 x i8] c"\00"

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
  %t6 = call double @select_text_artifact({ i8**, i64 }* %t5)
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
  %t153 = insertvalue %PythonModuleEmission undef, i8* null, 0
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
  %t36 = bitcast { i8**, i64 }* %t35 to { %NativeImportSpecifier*, i64 }*
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
  %t78 = insertvalue %PythonImportEmission undef, i8* null, 0
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
  %t40 = phi %PythonBuilder [ %t8, %entry ], [ %t38, %loop.latch2 ]
  %t41 = phi double [ %t9, %entry ], [ %t39, %loop.latch2 ]
  store %PythonBuilder %t40, %PythonBuilder* %l1
  store double %t41, double* %l2
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
  %t21 = fptosi double %t20 to i64
  %t22 = load { i8**, i64 }, { i8**, i64 }* %t19
  %t23 = extractvalue { i8**, i64 } %t22, 0
  %t24 = extractvalue { i8**, i64 } %t22, 1
  %t25 = icmp uge i64 %t21, %t24
  ; bounds check: %t25 (if true, out of bounds)
  %t26 = getelementptr i8*, i8** %t23, i64 %t21
  %t27 = load i8*, i8** %t26
  store i8* %t27, i8** %l3
  %t28 = load i8*, i8** %l3
  store double 0.0, double* %l4
  %t29 = load i8*, i8** %l0
  %s30 = getelementptr inbounds [128 x i8], [128 x i8]* @.str.30, i32 0, i32 0
  %t31 = add i8* %t29, %s30
  store i8* %t31, i8** %l5
  %t32 = load %PythonBuilder, %PythonBuilder* %l1
  %t33 = load i8*, i8** %l5
  %t34 = call %PythonBuilder @builder_emit(%PythonBuilder %t32, i8* %t33)
  store %PythonBuilder %t34, %PythonBuilder* %l1
  %t35 = load double, double* %l2
  %t36 = sitofp i64 1 to double
  %t37 = fadd double %t35, %t36
  store double %t37, double* %l2
  br label %loop.latch2
loop.latch2:
  %t38 = load %PythonBuilder, %PythonBuilder* %l1
  %t39 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t42 = load %PythonBuilder, %PythonBuilder* %l1
  ret %PythonBuilder %t42
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
  %t40 = phi { i8**, i64 }* [ %t10, %entry ], [ %t38, %loop.latch4 ]
  %t41 = phi double [ %t11, %entry ], [ %t39, %loop.latch4 ]
  store { i8**, i64 }* %t40, { i8**, i64 }** %l0
  store double %t41, double* %l1
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
  %t34 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t19, i8* null)
  store { i8**, i64 }* %t34, { i8**, i64 }** %l0
  %t35 = load double, double* %l1
  %t36 = sitofp i64 1 to double
  %t37 = fadd double %t35, %t36
  store double %t37, double* %l1
  br label %loop.latch4
loop.latch4:
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t39 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l0
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
  %t3 = call i64 @sailfin_runtime_string_length(i8* %t2)
  %t4 = icmp eq i64 %t3, 0
  %t5 = load i8*, i8** %l0
  br i1 %t4, label %then0, label %merge1
then0:
  %s6 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.6, i32 0, i32 0
  ret i8* %s6
merge1:
  %t7 = extractvalue %NativeImport %entry, 2
  %t8 = load { i8**, i64 }, { i8**, i64 }* %t7
  %t9 = extractvalue { i8**, i64 } %t8, 1
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
  %t16 = bitcast { i8**, i64 }* %t15 to { %NativeImportSpecifier*, i64 }*
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
  %t7 = load i8*, i8** %l0
  %t8 = load i8*, i8** %l0
  ret i8* null
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
  %t57 = insertvalue %PythonStructEmission undef, i8* null, 0
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
  %t120 = phi { i8**, i64 }* [ %t90, %entry ], [ %t118, %loop.latch18 ]
  %t121 = phi double [ %t89, %entry ], [ %t119, %loop.latch18 ]
  store { i8**, i64 }* %t120, { i8**, i64 }** %l5
  store double %t121, double* %l1
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
  %t114 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t100, i8* null)
  store { i8**, i64 }* %t114, { i8**, i64 }** %l5
  %t115 = load double, double* %l1
  %t116 = sitofp i64 1 to double
  %t117 = fadd double %t115, %t116
  store double %t117, double* %l1
  br label %loop.latch18
loop.latch18:
  %t118 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t119 = load double, double* %l1
  br label %loop.header16
afterloop19:
  %s122 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.122, i32 0, i32 0
  %t123 = load { i8**, i64 }*, { i8**, i64 }** %l5
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
  %t11 = alloca [0 x i8*]
  %t12 = getelementptr [0 x i8*], [0 x i8*]* %t11, i32 0, i32 0
  %t13 = alloca { i8**, i64 }
  %t14 = getelementptr { i8**, i64 }, { i8**, i64 }* %t13, i32 0, i32 0
  store i8** %t12, i8*** %t14
  %t15 = getelementptr { i8**, i64 }, { i8**, i64 }* %t13, i32 0, i32 1
  store i64 0, i64* %t15
  store { i8**, i64 }* %t13, { i8**, i64 }** %l2
  %t16 = extractvalue %NativeStruct %definition, 1
  %t17 = bitcast { i8**, i64 }* %t16 to { %NativeStructField*, i64 }*
  %t18 = call { i8**, i64 }* @render_struct_parameters({ %NativeStructField*, i64 }* %t17)
  store { i8**, i64 }* %t18, { i8**, i64 }** %l3
  %s19 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.19, i32 0, i32 0
  store i8* %s19, i8** %l4
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t21 = load { i8**, i64 }, { i8**, i64 }* %t20
  %t22 = extractvalue { i8**, i64 } %t21, 1
  %t23 = icmp sgt i64 %t22, 0
  %t24 = load i8*, i8** %l0
  %t25 = load %PythonBuilder, %PythonBuilder* %l1
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t28 = load i8*, i8** %l4
  br i1 %t23, label %then0, label %merge1
then0:
  %t29 = load i8*, i8** %l4
  %s30 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.30, i32 0, i32 0
  %t31 = add i8* %t29, %s30
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l3
  br label %merge1
merge1:
  %t33 = phi i8* [ null, %then0 ], [ %t28, %entry ]
  store i8* %t33, i8** %l4
  %t34 = load %PythonBuilder, %PythonBuilder* %l1
  %t35 = load i8*, i8** %l4
  %t36 = getelementptr i8, i8* %t35, i64 0
  %t37 = load i8, i8* %t36
  %t38 = add i8 %t37, 58
  %t39 = call %PythonBuilder @builder_emit(%PythonBuilder %t34, i8* null)
  store %PythonBuilder %t39, %PythonBuilder* %l1
  %t40 = load %PythonBuilder, %PythonBuilder* %l1
  %t41 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t40)
  store %PythonBuilder %t41, %PythonBuilder* %l1
  %t42 = extractvalue %NativeStruct %definition, 1
  %t43 = load { i8**, i64 }, { i8**, i64 }* %t42
  %t44 = extractvalue { i8**, i64 } %t43, 1
  %t45 = icmp eq i64 %t44, 0
  %t46 = load i8*, i8** %l0
  %t47 = load %PythonBuilder, %PythonBuilder* %l1
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t50 = load i8*, i8** %l4
  br i1 %t45, label %then2, label %else3
then2:
  %t51 = load %PythonBuilder, %PythonBuilder* %l1
  %s52 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.52, i32 0, i32 0
  %t53 = call %PythonBuilder @builder_emit(%PythonBuilder %t51, i8* %s52)
  store %PythonBuilder %t53, %PythonBuilder* %l1
  br label %merge4
else3:
  %t54 = sitofp i64 0 to double
  store double %t54, double* %l5
  %t55 = load i8*, i8** %l0
  %t56 = load %PythonBuilder, %PythonBuilder* %l1
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t59 = load i8*, i8** %l4
  %t60 = load double, double* %l5
  br label %loop.header5
loop.header5:
  %t91 = phi %PythonBuilder [ %t56, %else3 ], [ %t89, %loop.latch7 ]
  %t92 = phi double [ %t60, %else3 ], [ %t90, %loop.latch7 ]
  store %PythonBuilder %t91, %PythonBuilder* %l1
  store double %t92, double* %l5
  br label %loop.body6
loop.body6:
  %t61 = load double, double* %l5
  %t62 = extractvalue %NativeStruct %definition, 1
  %t63 = load { i8**, i64 }, { i8**, i64 }* %t62
  %t64 = extractvalue { i8**, i64 } %t63, 1
  %t65 = sitofp i64 %t64 to double
  %t66 = fcmp oge double %t61, %t65
  %t67 = load i8*, i8** %l0
  %t68 = load %PythonBuilder, %PythonBuilder* %l1
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t71 = load i8*, i8** %l4
  %t72 = load double, double* %l5
  br i1 %t66, label %then9, label %merge10
then9:
  br label %afterloop8
merge10:
  %t73 = extractvalue %NativeStruct %definition, 1
  %t74 = load double, double* %l5
  %t75 = fptosi double %t74 to i64
  %t76 = load { i8**, i64 }, { i8**, i64 }* %t73
  %t77 = extractvalue { i8**, i64 } %t76, 0
  %t78 = extractvalue { i8**, i64 } %t76, 1
  %t79 = icmp uge i64 %t75, %t78
  ; bounds check: %t79 (if true, out of bounds)
  %t80 = getelementptr i8*, i8** %t77, i64 %t75
  %t81 = load i8*, i8** %t80
  store i8* %t81, i8** %l6
  %t82 = load i8*, i8** %l6
  store double 0.0, double* %l7
  %t83 = load %PythonBuilder, %PythonBuilder* %l1
  %s84 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.84, i32 0, i32 0
  %t85 = load double, double* %l7
  %t86 = load double, double* %l5
  %t87 = sitofp i64 1 to double
  %t88 = fadd double %t86, %t87
  store double %t88, double* %l5
  br label %loop.latch7
loop.latch7:
  %t89 = load %PythonBuilder, %PythonBuilder* %l1
  %t90 = load double, double* %l5
  br label %loop.header5
afterloop8:
  br label %merge4
merge4:
  %t93 = phi %PythonBuilder [ %t53, %then2 ], [ zeroinitializer, %else3 ]
  store %PythonBuilder %t93, %PythonBuilder* %l1
  %t94 = load %PythonBuilder, %PythonBuilder* %l1
  %t95 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t94)
  store %PythonBuilder %t95, %PythonBuilder* %l1
  %t96 = load %PythonBuilder, %PythonBuilder* %l1
  %t97 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t96)
  store %PythonBuilder %t97, %PythonBuilder* %l1
  %t98 = load %PythonBuilder, %PythonBuilder* %l1
  %s99 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.99, i32 0, i32 0
  %t100 = call %PythonBuilder @builder_emit(%PythonBuilder %t98, i8* %s99)
  store %PythonBuilder %t100, %PythonBuilder* %l1
  %t101 = load %PythonBuilder, %PythonBuilder* %l1
  %t102 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t101)
  store %PythonBuilder %t102, %PythonBuilder* %l1
  %t103 = load i8*, i8** %l0
  %t104 = extractvalue %NativeStruct %definition, 1
  %t105 = bitcast { i8**, i64 }* %t104 to { %NativeStructField*, i64 }*
  %t106 = call i8* @render_struct_repr_fields(i8* %t103, { %NativeStructField*, i64 }* %t105)
  store i8* %t106, i8** %l8
  %t107 = load %PythonBuilder, %PythonBuilder* %l1
  %t108 = load i8*, i8** %l8
  %t109 = call %PythonBuilder @builder_emit(%PythonBuilder %t107, i8* %t108)
  store %PythonBuilder %t109, %PythonBuilder* %l1
  %t110 = load %PythonBuilder, %PythonBuilder* %l1
  %t111 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t110)
  store %PythonBuilder %t111, %PythonBuilder* %l1
  %t112 = load i8*, i8** %l0
  %s113 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.113, i32 0, i32 0
  %t114 = icmp eq i8* %t112, %s113
  %t115 = load i8*, i8** %l0
  %t116 = load %PythonBuilder, %PythonBuilder* %l1
  %t117 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t118 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t119 = load i8*, i8** %l4
  %t120 = load i8*, i8** %l8
  br i1 %t114, label %then11, label %merge12
then11:
  %t121 = load %PythonBuilder, %PythonBuilder* %l1
  %t122 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t121)
  store %PythonBuilder %t122, %PythonBuilder* %l1
  %t123 = load %PythonBuilder, %PythonBuilder* %l1
  %s124 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.124, i32 0, i32 0
  %t125 = call %PythonBuilder @builder_emit(%PythonBuilder %t123, i8* %s124)
  store %PythonBuilder %t125, %PythonBuilder* %l1
  %t126 = load %PythonBuilder, %PythonBuilder* %l1
  %t127 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t126)
  store %PythonBuilder %t127, %PythonBuilder* %l1
  %t128 = load %PythonBuilder, %PythonBuilder* %l1
  %s129 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.129, i32 0, i32 0
  %t130 = call %PythonBuilder @builder_emit(%PythonBuilder %t128, i8* %s129)
  store %PythonBuilder %t130, %PythonBuilder* %l1
  %t131 = load %PythonBuilder, %PythonBuilder* %l1
  %s132 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.132, i32 0, i32 0
  %t133 = call %PythonBuilder @builder_emit(%PythonBuilder %t131, i8* %s132)
  store %PythonBuilder %t133, %PythonBuilder* %l1
  %t134 = load %PythonBuilder, %PythonBuilder* %l1
  %t135 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t134)
  store %PythonBuilder %t135, %PythonBuilder* %l1
  %t136 = load %PythonBuilder, %PythonBuilder* %l1
  %t137 = load %PythonBuilder, %PythonBuilder* %l1
  %t138 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t137)
  store %PythonBuilder %t138, %PythonBuilder* %l1
  %t139 = load %PythonBuilder, %PythonBuilder* %l1
  %s140 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.140, i32 0, i32 0
  %t141 = call %PythonBuilder @builder_emit(%PythonBuilder %t139, i8* %s140)
  store %PythonBuilder %t141, %PythonBuilder* %l1
  %t142 = load %PythonBuilder, %PythonBuilder* %l1
  %t143 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t142)
  store %PythonBuilder %t143, %PythonBuilder* %l1
  %t144 = load %PythonBuilder, %PythonBuilder* %l1
  %s145 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.145, i32 0, i32 0
  %t146 = call %PythonBuilder @builder_emit(%PythonBuilder %t144, i8* %s145)
  store %PythonBuilder %t146, %PythonBuilder* %l1
  %t147 = load %PythonBuilder, %PythonBuilder* %l1
  %t148 = load %PythonBuilder, %PythonBuilder* %l1
  %t149 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t148)
  store %PythonBuilder %t149, %PythonBuilder* %l1
  %t150 = load %PythonBuilder, %PythonBuilder* %l1
  %s151 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.151, i32 0, i32 0
  %t152 = call %PythonBuilder @builder_emit(%PythonBuilder %t150, i8* %s151)
  store %PythonBuilder %t152, %PythonBuilder* %l1
  %t153 = load %PythonBuilder, %PythonBuilder* %l1
  %t154 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t153)
  store %PythonBuilder %t154, %PythonBuilder* %l1
  %t155 = load %PythonBuilder, %PythonBuilder* %l1
  %t156 = load %PythonBuilder, %PythonBuilder* %l1
  %t157 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t156)
  store %PythonBuilder %t157, %PythonBuilder* %l1
  %t158 = load %PythonBuilder, %PythonBuilder* %l1
  %s159 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.159, i32 0, i32 0
  %t160 = call %PythonBuilder @builder_emit(%PythonBuilder %t158, i8* %s159)
  store %PythonBuilder %t160, %PythonBuilder* %l1
  %t161 = load %PythonBuilder, %PythonBuilder* %l1
  %t162 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t161)
  store %PythonBuilder %t162, %PythonBuilder* %l1
  br label %merge12
merge12:
  %t163 = phi %PythonBuilder [ %t122, %then11 ], [ %t116, %entry ]
  %t164 = phi %PythonBuilder [ %t125, %then11 ], [ %t116, %entry ]
  %t165 = phi %PythonBuilder [ %t127, %then11 ], [ %t116, %entry ]
  %t166 = phi %PythonBuilder [ %t130, %then11 ], [ %t116, %entry ]
  %t167 = phi %PythonBuilder [ %t133, %then11 ], [ %t116, %entry ]
  %t168 = phi %PythonBuilder [ %t135, %then11 ], [ %t116, %entry ]
  %t169 = phi %PythonBuilder [ zeroinitializer, %then11 ], [ %t116, %entry ]
  %t170 = phi %PythonBuilder [ %t138, %then11 ], [ %t116, %entry ]
  %t171 = phi %PythonBuilder [ %t141, %then11 ], [ %t116, %entry ]
  %t172 = phi %PythonBuilder [ %t143, %then11 ], [ %t116, %entry ]
  %t173 = phi %PythonBuilder [ %t146, %then11 ], [ %t116, %entry ]
  %t174 = phi %PythonBuilder [ zeroinitializer, %then11 ], [ %t116, %entry ]
  %t175 = phi %PythonBuilder [ %t149, %then11 ], [ %t116, %entry ]
  %t176 = phi %PythonBuilder [ %t152, %then11 ], [ %t116, %entry ]
  %t177 = phi %PythonBuilder [ %t154, %then11 ], [ %t116, %entry ]
  %t178 = phi %PythonBuilder [ zeroinitializer, %then11 ], [ %t116, %entry ]
  %t179 = phi %PythonBuilder [ %t157, %then11 ], [ %t116, %entry ]
  %t180 = phi %PythonBuilder [ %t160, %then11 ], [ %t116, %entry ]
  %t181 = phi %PythonBuilder [ %t162, %then11 ], [ %t116, %entry ]
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
  store %PythonBuilder %t179, %PythonBuilder* %l1
  store %PythonBuilder %t180, %PythonBuilder* %l1
  store %PythonBuilder %t181, %PythonBuilder* %l1
  %t182 = extractvalue %NativeStruct %definition, 2
  %t183 = load { i8**, i64 }, { i8**, i64 }* %t182
  %t184 = extractvalue { i8**, i64 } %t183, 1
  %t185 = icmp sgt i64 %t184, 0
  %t186 = load i8*, i8** %l0
  %t187 = load %PythonBuilder, %PythonBuilder* %l1
  %t188 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t189 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t190 = load i8*, i8** %l4
  %t191 = load i8*, i8** %l8
  br i1 %t185, label %then13, label %merge14
then13:
  %t192 = load %PythonBuilder, %PythonBuilder* %l1
  %t193 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t192)
  store %PythonBuilder %t193, %PythonBuilder* %l1
  %t194 = sitofp i64 0 to double
  store double %t194, double* %l9
  %t195 = load i8*, i8** %l0
  %t196 = load %PythonBuilder, %PythonBuilder* %l1
  %t197 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t198 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t199 = load i8*, i8** %l4
  %t200 = load i8*, i8** %l8
  %t201 = load double, double* %l9
  br label %loop.header15
loop.header15:
  %t259 = phi %PythonBuilder [ %t196, %then13 ], [ %t256, %loop.latch17 ]
  %t260 = phi { i8**, i64 }* [ %t197, %then13 ], [ %t257, %loop.latch17 ]
  %t261 = phi double [ %t201, %then13 ], [ %t258, %loop.latch17 ]
  store %PythonBuilder %t259, %PythonBuilder* %l1
  store { i8**, i64 }* %t260, { i8**, i64 }** %l2
  store double %t261, double* %l9
  br label %loop.body16
loop.body16:
  %t202 = load double, double* %l9
  %t203 = extractvalue %NativeStruct %definition, 2
  %t204 = load { i8**, i64 }, { i8**, i64 }* %t203
  %t205 = extractvalue { i8**, i64 } %t204, 1
  %t206 = sitofp i64 %t205 to double
  %t207 = fcmp oge double %t202, %t206
  %t208 = load i8*, i8** %l0
  %t209 = load %PythonBuilder, %PythonBuilder* %l1
  %t210 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t211 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t212 = load i8*, i8** %l4
  %t213 = load i8*, i8** %l8
  %t214 = load double, double* %l9
  br i1 %t207, label %then19, label %merge20
then19:
  br label %afterloop18
merge20:
  %t215 = extractvalue %NativeStruct %definition, 2
  %t216 = load double, double* %l9
  %t217 = fptosi double %t216 to i64
  %t218 = load { i8**, i64 }, { i8**, i64 }* %t215
  %t219 = extractvalue { i8**, i64 } %t218, 0
  %t220 = extractvalue { i8**, i64 } %t218, 1
  %t221 = icmp uge i64 %t217, %t220
  ; bounds check: %t221 (if true, out of bounds)
  %t222 = getelementptr i8*, i8** %t219, i64 %t217
  %t223 = load i8*, i8** %t222
  store i8* %t223, i8** %l10
  %t224 = load %PythonBuilder, %PythonBuilder* %l1
  %t225 = load i8*, i8** %l10
  %t226 = call %PythonFunctionEmission @emit_python_function(%PythonBuilder %t224, %NativeFunction zeroinitializer)
  store %PythonFunctionEmission %t226, %PythonFunctionEmission* %l11
  %t227 = load %PythonFunctionEmission, %PythonFunctionEmission* %l11
  %t228 = extractvalue %PythonFunctionEmission %t227, 0
  store %PythonBuilder zeroinitializer, %PythonBuilder* %l1
  %t229 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t230 = load %PythonFunctionEmission, %PythonFunctionEmission* %l11
  %t231 = extractvalue %PythonFunctionEmission %t230, 1
  %t232 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t229, { i8**, i64 }* %t231)
  store { i8**, i64 }* %t232, { i8**, i64 }** %l2
  %t233 = load double, double* %l9
  %t234 = sitofp i64 1 to double
  %t235 = fadd double %t233, %t234
  %t236 = extractvalue %NativeStruct %definition, 2
  %t237 = load { i8**, i64 }, { i8**, i64 }* %t236
  %t238 = extractvalue { i8**, i64 } %t237, 1
  %t239 = sitofp i64 %t238 to double
  %t240 = fcmp olt double %t235, %t239
  %t241 = load i8*, i8** %l0
  %t242 = load %PythonBuilder, %PythonBuilder* %l1
  %t243 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t244 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t245 = load i8*, i8** %l4
  %t246 = load i8*, i8** %l8
  %t247 = load double, double* %l9
  %t248 = load i8*, i8** %l10
  %t249 = load %PythonFunctionEmission, %PythonFunctionEmission* %l11
  br i1 %t240, label %then21, label %merge22
then21:
  %t250 = load %PythonBuilder, %PythonBuilder* %l1
  %t251 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t250)
  store %PythonBuilder %t251, %PythonBuilder* %l1
  br label %merge22
merge22:
  %t252 = phi %PythonBuilder [ %t251, %then21 ], [ %t242, %loop.body16 ]
  store %PythonBuilder %t252, %PythonBuilder* %l1
  %t253 = load double, double* %l9
  %t254 = sitofp i64 1 to double
  %t255 = fadd double %t253, %t254
  store double %t255, double* %l9
  br label %loop.latch17
loop.latch17:
  %t256 = load %PythonBuilder, %PythonBuilder* %l1
  %t257 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t258 = load double, double* %l9
  br label %loop.header15
afterloop18:
  br label %merge14
merge14:
  %t262 = phi %PythonBuilder [ %t193, %then13 ], [ %t187, %entry ]
  %t263 = phi %PythonBuilder [ zeroinitializer, %then13 ], [ %t187, %entry ]
  %t264 = phi { i8**, i64 }* [ %t232, %then13 ], [ %t188, %entry ]
  %t265 = phi %PythonBuilder [ %t251, %then13 ], [ %t187, %entry ]
  store %PythonBuilder %t262, %PythonBuilder* %l1
  store %PythonBuilder %t263, %PythonBuilder* %l1
  store { i8**, i64 }* %t264, { i8**, i64 }** %l2
  store %PythonBuilder %t265, %PythonBuilder* %l1
  %t266 = load %PythonBuilder, %PythonBuilder* %l1
  %t267 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t266)
  store %PythonBuilder %t267, %PythonBuilder* %l1
  %t268 = load %PythonBuilder, %PythonBuilder* %l1
  %t269 = insertvalue %PythonStructEmission undef, i8* null, 0
  %t270 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t271 = insertvalue %PythonStructEmission %t269, { i8**, i64 }* %t270, 1
  ret %PythonStructEmission %t271
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
  %s3 = getelementptr inbounds [53 x i8], [53 x i8]* @.str.3, i32 0, i32 0
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
  %t38 = phi { i8**, i64 }* [ %t10, %entry ], [ %t36, %loop.latch4 ]
  %t39 = phi double [ %t11, %entry ], [ %t37, %loop.latch4 ]
  store { i8**, i64 }* %t38, { i8**, i64 }** %l0
  store double %t39, double* %l1
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
  %t20 = fptosi double %t19 to i64
  %t21 = load { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %fields
  %t22 = extractvalue { %NativeStructField*, i64 } %t21, 0
  %t23 = extractvalue { %NativeStructField*, i64 } %t21, 1
  %t24 = icmp uge i64 %t20, %t23
  ; bounds check: %t24 (if true, out of bounds)
  %t25 = getelementptr %NativeStructField, %NativeStructField* %t22, i64 %t20
  %t26 = load %NativeStructField, %NativeStructField* %t25
  store %NativeStructField %t26, %NativeStructField* %l2
  %t27 = load %NativeStructField, %NativeStructField* %l2
  %t28 = extractvalue %NativeStructField %t27, 0
  %t29 = call i8* @sanitize_identifier(i8* %t28)
  store i8* %t29, i8** %l3
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s31 = getelementptr inbounds [56 x i8], [56 x i8]* @.str.31, i32 0, i32 0
  %t32 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t30, i8* %s31)
  store { i8**, i64 }* %t32, { i8**, i64 }** %l0
  %t33 = load double, double* %l1
  %t34 = sitofp i64 1 to double
  %t35 = fadd double %t33, %t34
  store double %t35, double* %l1
  br label %loop.latch4
loop.latch4:
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t37 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %s40 = getelementptr inbounds [96 x i8], [96 x i8]* @.str.40, i32 0, i32 0
  ret i8* %s40
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
  %t6 = call i1 @ends_with(i8* %t5, i8* null)
  ret i1 %t6
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
  ret i8* null
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
  %t208 = phi double [ %t4, %entry ], [ %t206, %loop.latch4 ]
  %t209 = phi i8* [ %t3, %entry ], [ %t207, %loop.latch4 ]
  store double %t208, double* %l1
  store i8* %t209, i8** %l0
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
  store double 0.0, double* %l2
  %t13 = load double, double* %l2
  %t14 = sitofp i64 0 to double
  %t15 = fcmp olt double %t13, %t14
  %t16 = load i8*, i8** %l0
  %t17 = load double, double* %l1
  %t18 = load double, double* %l2
  br i1 %t15, label %then8, label %merge9
then8:
  br label %afterloop5
merge9:
  %t19 = load double, double* %l2
  store double %t19, double* %l3
  %t20 = load i8*, i8** %l0
  %t21 = load double, double* %l1
  %t22 = load double, double* %l2
  %t23 = load double, double* %l3
  br label %loop.header10
loop.header10:
  %t50 = phi double [ %t23, %loop.body3 ], [ %t49, %loop.latch12 ]
  store double %t50, double* %l3
  br label %loop.body11
loop.body11:
  %t24 = load double, double* %l3
  %t25 = sitofp i64 0 to double
  %t26 = fcmp ole double %t24, %t25
  %t27 = load i8*, i8** %l0
  %t28 = load double, double* %l1
  %t29 = load double, double* %l2
  %t30 = load double, double* %l3
  br i1 %t26, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t31 = load i8*, i8** %l0
  %t32 = load double, double* %l3
  %t33 = sitofp i64 1 to double
  %t34 = fsub double %t32, %t33
  %t35 = load double, double* %l3
  %t36 = fptosi double %t34 to i64
  %t37 = fptosi double %t35 to i64
  %t38 = call i8* @sailfin_runtime_substring(i8* %t31, i64 %t36, i64 %t37)
  store i8* %t38, i8** %l4
  %t39 = load i8*, i8** %l4
  %t40 = call i1 @sailfin_runtime_is_whitespace_char(i8* %t39)
  %t41 = load i8*, i8** %l0
  %t42 = load double, double* %l1
  %t43 = load double, double* %l2
  %t44 = load double, double* %l3
  %t45 = load i8*, i8** %l4
  br i1 %t40, label %then16, label %merge17
then16:
  %t46 = load double, double* %l3
  %t47 = sitofp i64 1 to double
  %t48 = fsub double %t46, %t47
  store double %t48, double* %l3
  br label %loop.latch12
merge17:
  br label %afterloop13
loop.latch12:
  %t49 = load double, double* %l3
  br label %loop.header10
afterloop13:
  %t51 = load double, double* %l3
  store double %t51, double* %l5
  %t52 = load i8*, i8** %l0
  %t53 = load double, double* %l1
  %t54 = load double, double* %l2
  %t55 = load double, double* %l3
  %t56 = load double, double* %l5
  br label %loop.header18
loop.header18:
  %t98 = phi double [ %t56, %loop.body3 ], [ %t97, %loop.latch20 ]
  store double %t98, double* %l5
  br label %loop.body19
loop.body19:
  %t57 = load double, double* %l5
  %t58 = sitofp i64 0 to double
  %t59 = fcmp ole double %t57, %t58
  %t60 = load i8*, i8** %l0
  %t61 = load double, double* %l1
  %t62 = load double, double* %l2
  %t63 = load double, double* %l3
  %t64 = load double, double* %l5
  br i1 %t59, label %then22, label %merge23
then22:
  br label %afterloop21
merge23:
  %t65 = load i8*, i8** %l0
  %t66 = load double, double* %l5
  %t67 = sitofp i64 1 to double
  %t68 = fsub double %t66, %t67
  %t69 = load double, double* %l5
  %t70 = fptosi double %t68 to i64
  %t71 = fptosi double %t69 to i64
  %t72 = call i8* @sailfin_runtime_substring(i8* %t65, i64 %t70, i64 %t71)
  store i8* %t72, i8** %l6
  %t73 = load i8*, i8** %l6
  %t74 = getelementptr i8, i8* %t73, i64 0
  %t75 = load i8, i8* %t74
  %t76 = icmp eq i8 %t75, 46
  %t77 = load i8*, i8** %l0
  %t78 = load double, double* %l1
  %t79 = load double, double* %l2
  %t80 = load double, double* %l3
  %t81 = load double, double* %l5
  %t82 = load i8*, i8** %l6
  br i1 %t76, label %then24, label %merge25
then24:
  %t83 = load double, double* %l5
  %t84 = sitofp i64 1 to double
  %t85 = fsub double %t83, %t84
  store double %t85, double* %l5
  br label %loop.latch20
merge25:
  %t86 = load i8*, i8** %l6
  %t87 = call i1 @is_identifier_char(i8* %t86)
  %t88 = load i8*, i8** %l0
  %t89 = load double, double* %l1
  %t90 = load double, double* %l2
  %t91 = load double, double* %l3
  %t92 = load double, double* %l5
  %t93 = load i8*, i8** %l6
  br i1 %t87, label %then26, label %merge27
then26:
  %t94 = load double, double* %l5
  %t95 = sitofp i64 1 to double
  %t96 = fsub double %t94, %t95
  store double %t96, double* %l5
  br label %loop.latch20
merge27:
  br label %afterloop21
loop.latch20:
  %t97 = load double, double* %l5
  br label %loop.header18
afterloop21:
  %t99 = load double, double* %l5
  %t100 = load double, double* %l3
  %t101 = fcmp oeq double %t99, %t100
  %t102 = load i8*, i8** %l0
  %t103 = load double, double* %l1
  %t104 = load double, double* %l2
  %t105 = load double, double* %l3
  %t106 = load double, double* %l5
  br i1 %t101, label %then28, label %merge29
then28:
  %t107 = load double, double* %l2
  %t108 = sitofp i64 1 to double
  %t109 = fadd double %t107, %t108
  store double %t109, double* %l1
  br label %loop.latch4
merge29:
  %t110 = load i8*, i8** %l0
  %t111 = load double, double* %l5
  %t112 = load double, double* %l3
  %t113 = fptosi double %t111 to i64
  %t114 = fptosi double %t112 to i64
  %t115 = call i8* @sailfin_runtime_substring(i8* %t110, i64 %t113, i64 %t114)
  store i8* %t115, i8** %l7
  %t116 = load i8*, i8** %l7
  %t117 = call i1 @is_struct_literal_type_candidate(i8* %t116)
  %t118 = xor i1 %t117, 1
  %t119 = load i8*, i8** %l0
  %t120 = load double, double* %l1
  %t121 = load double, double* %l2
  %t122 = load double, double* %l3
  %t123 = load double, double* %l5
  %t124 = load i8*, i8** %l7
  br i1 %t118, label %then30, label %merge31
then30:
  %t125 = load double, double* %l2
  %t126 = sitofp i64 1 to double
  %t127 = fadd double %t125, %t126
  store double %t127, double* %l1
  br label %loop.latch4
merge31:
  %t128 = load double, double* %l5
  %t129 = sitofp i64 0 to double
  %t130 = fcmp ogt double %t128, %t129
  %t131 = load i8*, i8** %l0
  %t132 = load double, double* %l1
  %t133 = load double, double* %l2
  %t134 = load double, double* %l3
  %t135 = load double, double* %l5
  %t136 = load i8*, i8** %l7
  br i1 %t130, label %then32, label %merge33
then32:
  %t137 = load i8*, i8** %l0
  %t138 = load double, double* %l5
  %t139 = sitofp i64 1 to double
  %t140 = fsub double %t138, %t139
  %t141 = load double, double* %l5
  %t142 = fptosi double %t140 to i64
  %t143 = fptosi double %t141 to i64
  %t144 = call i8* @sailfin_runtime_substring(i8* %t137, i64 %t142, i64 %t143)
  store i8* %t144, i8** %l8
  %t146 = load i8*, i8** %l8
  %t147 = call i1 @is_identifier_char(i8* %t146)
  br label %logical_or_entry_145

logical_or_entry_145:
  br i1 %t147, label %logical_or_merge_145, label %logical_or_right_145

logical_or_right_145:
  %t148 = load i8*, i8** %l8
  %t149 = getelementptr i8, i8* %t148, i64 0
  %t150 = load i8, i8* %t149
  %t151 = icmp eq i8 %t150, 46
  br label %logical_or_right_end_145

logical_or_right_end_145:
  br label %logical_or_merge_145

logical_or_merge_145:
  %t152 = phi i1 [ true, %logical_or_entry_145 ], [ %t151, %logical_or_right_end_145 ]
  %t153 = load i8*, i8** %l0
  %t154 = load double, double* %l1
  %t155 = load double, double* %l2
  %t156 = load double, double* %l3
  %t157 = load double, double* %l5
  %t158 = load i8*, i8** %l7
  %t159 = load i8*, i8** %l8
  br i1 %t152, label %then34, label %merge35
then34:
  %t160 = load double, double* %l2
  %t161 = sitofp i64 1 to double
  %t162 = fadd double %t160, %t161
  store double %t162, double* %l1
  br label %loop.latch4
merge35:
  br label %merge33
merge33:
  %t163 = phi double [ %t162, %then32 ], [ %t132, %loop.body3 ]
  store double %t163, double* %l1
  %t164 = load i8*, i8** %l0
  %t165 = load double, double* %l2
  %t166 = call double @find_matching_brace(i8* %t164, double %t165)
  store double %t166, double* %l9
  %t167 = load double, double* %l9
  %t168 = sitofp i64 0 to double
  %t169 = fcmp olt double %t167, %t168
  %t170 = load i8*, i8** %l0
  %t171 = load double, double* %l1
  %t172 = load double, double* %l2
  %t173 = load double, double* %l3
  %t174 = load double, double* %l5
  %t175 = load i8*, i8** %l7
  %t176 = load double, double* %l9
  br i1 %t169, label %then36, label %merge37
then36:
  br label %afterloop5
merge37:
  %t177 = load i8*, i8** %l0
  %t178 = load double, double* %l5
  %t179 = load double, double* %l9
  %t180 = sitofp i64 1 to double
  %t181 = fadd double %t179, %t180
  %t182 = fptosi double %t178 to i64
  %t183 = fptosi double %t181 to i64
  %t184 = call i8* @sailfin_runtime_substring(i8* %t177, i64 %t182, i64 %t183)
  store i8* %t184, i8** %l10
  %t185 = load i8*, i8** %l10
  %t186 = sitofp i64 1 to double
  %t187 = fadd double %depth, %t186
  %t188 = call double @lower_struct_literal_expression(i8* %t185, double %t187)
  store double %t188, double* %l11
  %t189 = load double, double* %l11
  %t190 = load i8*, i8** %l0
  %t191 = load double, double* %l5
  %t192 = fptosi double %t191 to i64
  %t193 = call i8* @sailfin_runtime_substring(i8* %t190, i64 0, i64 %t192)
  store i8* %t193, i8** %l12
  %t194 = load i8*, i8** %l0
  %t195 = load double, double* %l9
  %t196 = sitofp i64 1 to double
  %t197 = fadd double %t195, %t196
  %t198 = load i8*, i8** %l0
  %t199 = call i64 @sailfin_runtime_string_length(i8* %t198)
  %t200 = fptosi double %t197 to i64
  %t201 = call i8* @sailfin_runtime_substring(i8* %t194, i64 %t200, i64 %t199)
  store i8* %t201, i8** %l13
  %t202 = load i8*, i8** %l12
  %t203 = load double, double* %l11
  %t204 = load double, double* %l5
  %t205 = load double, double* %l11
  br label %loop.latch4
loop.latch4:
  %t206 = load double, double* %l1
  %t207 = load i8*, i8** %l0
  br label %loop.header2
afterloop5:
  %t210 = load i8*, i8** %l0
  ret i8* %t210
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
  %t165 = phi i8* [ %t28, %entry ], [ %t161, %loop.latch6 ]
  %t166 = phi double [ %t31, %entry ], [ %t162, %loop.latch6 ]
  %t167 = phi double [ %t30, %entry ], [ %t163, %loop.latch6 ]
  %t168 = phi double [ %t29, %entry ], [ %t164, %loop.latch6 ]
  store i8* %t165, i8** %l1
  store double %t166, double* %l4
  store double %t167, double* %l3
  store double %t168, double* %l2
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
  %t43 = fptosi double %t42 to i64
  %t44 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %instructions
  %t45 = extractvalue { %NativeInstruction*, i64 } %t44, 0
  %t46 = extractvalue { %NativeInstruction*, i64 } %t44, 1
  %t47 = icmp uge i64 %t43, %t46
  ; bounds check: %t47 (if true, out of bounds)
  %t48 = getelementptr %NativeInstruction, %NativeInstruction* %t45, i64 %t43
  %t49 = load %NativeInstruction, %NativeInstruction* %t48
  store %NativeInstruction %t49, %NativeInstruction* %l5
  %t50 = load %NativeInstruction, %NativeInstruction* %l5
  %t51 = extractvalue %NativeInstruction %t50, 0
  %t52 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t53 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t54 = icmp eq i32 %t51, 0
  %t55 = select i1 %t54, i8* %t53, i8* %t52
  %t56 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t57 = icmp eq i32 %t51, 1
  %t58 = select i1 %t57, i8* %t56, i8* %t55
  %t59 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t60 = icmp eq i32 %t51, 2
  %t61 = select i1 %t60, i8* %t59, i8* %t58
  %t62 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t63 = icmp eq i32 %t51, 3
  %t64 = select i1 %t63, i8* %t62, i8* %t61
  %t65 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t66 = icmp eq i32 %t51, 4
  %t67 = select i1 %t66, i8* %t65, i8* %t64
  %t68 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t69 = icmp eq i32 %t51, 5
  %t70 = select i1 %t69, i8* %t68, i8* %t67
  %t71 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t72 = icmp eq i32 %t51, 6
  %t73 = select i1 %t72, i8* %t71, i8* %t70
  %t74 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t75 = icmp eq i32 %t51, 7
  %t76 = select i1 %t75, i8* %t74, i8* %t73
  %t77 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t78 = icmp eq i32 %t51, 8
  %t79 = select i1 %t78, i8* %t77, i8* %t76
  %t80 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t81 = icmp eq i32 %t51, 9
  %t82 = select i1 %t81, i8* %t80, i8* %t79
  %t83 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t84 = icmp eq i32 %t51, 10
  %t85 = select i1 %t84, i8* %t83, i8* %t82
  %t86 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t87 = icmp eq i32 %t51, 11
  %t88 = select i1 %t87, i8* %t86, i8* %t85
  %t89 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t90 = icmp eq i32 %t51, 12
  %t91 = select i1 %t90, i8* %t89, i8* %t88
  %t92 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t93 = icmp eq i32 %t51, 13
  %t94 = select i1 %t93, i8* %t92, i8* %t91
  %t95 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t96 = icmp eq i32 %t51, 14
  %t97 = select i1 %t96, i8* %t95, i8* %t94
  %t98 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t99 = icmp eq i32 %t51, 15
  %t100 = select i1 %t99, i8* %t98, i8* %t97
  %t101 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t102 = icmp eq i32 %t51, 16
  %t103 = select i1 %t102, i8* %t101, i8* %t100
  %s104 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.104, i32 0, i32 0
  %t105 = icmp ne i8* %t103, %s104
  %t106 = load i8*, i8** %l0
  %t107 = load i8*, i8** %l1
  %t108 = load double, double* %l2
  %t109 = load double, double* %l3
  %t110 = load double, double* %l4
  %t111 = load %NativeInstruction, %NativeInstruction* %l5
  br i1 %t105, label %then10, label %merge11
then10:
  br label %afterloop7
merge11:
  %t112 = load %NativeInstruction, %NativeInstruction* %l5
  %t113 = extractvalue %NativeInstruction %t112, 0
  %t114 = alloca %NativeInstruction
  store %NativeInstruction %t112, %NativeInstruction* %t114
  %t115 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t114, i32 0, i32 1
  %t116 = bitcast [8 x i8]* %t115 to i8*
  %t117 = bitcast i8* %t116 to i8**
  %t118 = load i8*, i8** %t117
  %t119 = icmp eq i32 %t113, 16
  %t120 = select i1 %t119, i8* %t118, i8* null
  %t121 = call i8* @trim_text(i8* %t120)
  store i8* %t121, i8** %l6
  %t122 = load i8*, i8** %l6
  %t123 = call i64 @sailfin_runtime_string_length(i8* %t122)
  %t124 = icmp sgt i64 %t123, 0
  %t125 = load i8*, i8** %l0
  %t126 = load i8*, i8** %l1
  %t127 = load double, double* %l2
  %t128 = load double, double* %l3
  %t129 = load double, double* %l4
  %t130 = load %NativeInstruction, %NativeInstruction* %l5
  %t131 = load i8*, i8** %l6
  br i1 %t124, label %then12, label %merge13
then12:
  %t132 = load i8*, i8** %l1
  %t133 = getelementptr i8, i8* %t132, i64 0
  %t134 = load i8, i8* %t133
  %t135 = add i8 %t134, 32
  %t136 = load i8*, i8** %l6
  %t137 = getelementptr i8, i8* %t136, i64 0
  %t138 = load i8, i8* %t137
  %t139 = add i8 %t135, %t138
  store i8* null, i8** %l1
  br label %merge13
merge13:
  %t140 = phi i8* [ null, %then12 ], [ %t126, %loop.body5 ]
  store i8* %t140, i8** %l1
  %t141 = load double, double* %l4
  %t142 = load i8*, i8** %l6
  %t143 = call double @compute_brace_balance(i8* %t142)
  %t144 = fadd double %t141, %t143
  store double %t144, double* %l4
  %t145 = load double, double* %l3
  %t146 = sitofp i64 1 to double
  %t147 = fadd double %t145, %t146
  store double %t147, double* %l3
  %t148 = load double, double* %l2
  %t149 = sitofp i64 1 to double
  %t150 = fadd double %t148, %t149
  store double %t150, double* %l2
  %t151 = load double, double* %l4
  %t152 = sitofp i64 0 to double
  %t153 = fcmp ole double %t151, %t152
  %t154 = load i8*, i8** %l0
  %t155 = load i8*, i8** %l1
  %t156 = load double, double* %l2
  %t157 = load double, double* %l3
  %t158 = load double, double* %l4
  %t159 = load %NativeInstruction, %NativeInstruction* %l5
  %t160 = load i8*, i8** %l6
  br i1 %t153, label %then14, label %merge15
then14:
  br label %afterloop7
merge15:
  br label %loop.latch6
loop.latch6:
  %t161 = load i8*, i8** %l1
  %t162 = load double, double* %l4
  %t163 = load double, double* %l3
  %t164 = load double, double* %l2
  br label %loop.header4
afterloop7:
  %t169 = load double, double* %l4
  %t170 = sitofp i64 0 to double
  %t171 = fcmp une double %t169, %t170
  %t172 = load i8*, i8** %l0
  %t173 = load i8*, i8** %l1
  %t174 = load double, double* %l2
  %t175 = load double, double* %l3
  %t176 = load double, double* %l4
  br i1 %t171, label %then16, label %merge17
then16:
  %t177 = load i8*, i8** %l0
  %t178 = insertvalue %StructLiteralCapture undef, i8* %t177, 0
  %t179 = sitofp i64 0 to double
  %t180 = insertvalue %StructLiteralCapture %t178, double %t179, 1
  %t181 = insertvalue %StructLiteralCapture %t180, i1 0, 2
  ret %StructLiteralCapture %t181
merge17:
  %t182 = load double, double* %l3
  %t183 = sitofp i64 0 to double
  %t184 = fcmp oeq double %t182, %t183
  %t185 = load i8*, i8** %l0
  %t186 = load i8*, i8** %l1
  %t187 = load double, double* %l2
  %t188 = load double, double* %l3
  %t189 = load double, double* %l4
  br i1 %t184, label %then18, label %merge19
then18:
  %t190 = load i8*, i8** %l0
  %t191 = insertvalue %StructLiteralCapture undef, i8* %t190, 0
  %t192 = sitofp i64 0 to double
  %t193 = insertvalue %StructLiteralCapture %t191, double %t192, 1
  %t194 = insertvalue %StructLiteralCapture %t193, i1 0, 2
  ret %StructLiteralCapture %t194
merge19:
  %t195 = load i8*, i8** %l1
  %t196 = call i8* @trim_text(i8* %t195)
  %t197 = call i8* @trim_trailing_delimiters(i8* %t196)
  store i8* %t197, i8** %l7
  %t198 = load i8*, i8** %l7
  %t199 = call i1 @ends_with(i8* %t198, i8* null)
  %t200 = xor i1 %t199, 1
  %t201 = load i8*, i8** %l0
  %t202 = load i8*, i8** %l1
  %t203 = load double, double* %l2
  %t204 = load double, double* %l3
  %t205 = load double, double* %l4
  %t206 = load i8*, i8** %l7
  br i1 %t200, label %then20, label %merge21
then20:
  %t207 = load i8*, i8** %l0
  %t208 = insertvalue %StructLiteralCapture undef, i8* %t207, 0
  %t209 = sitofp i64 0 to double
  %t210 = insertvalue %StructLiteralCapture %t208, double %t209, 1
  %t211 = insertvalue %StructLiteralCapture %t210, i1 0, 2
  ret %StructLiteralCapture %t211
merge21:
  %t212 = load i8*, i8** %l7
  %t213 = insertvalue %StructLiteralCapture undef, i8* %t212, 0
  %t214 = load double, double* %l3
  %t215 = insertvalue %StructLiteralCapture %t213, double %t214, 1
  %t216 = insertvalue %StructLiteralCapture %t215, i1 1, 2
  ret %StructLiteralCapture %t216
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
  %t181 = phi i8* [ %t4, %entry ], [ %t179, %loop.latch4 ]
  %t182 = phi double [ %t5, %entry ], [ %t180, %loop.latch4 ]
  store i8* %t181, i8** %l0
  store double %t182, double* %l1
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
  %t162 = load double, double* %l1
  %t163 = sitofp i64 2 to double
  %t164 = fadd double %t162, %t163
  store double %t164, double* %l1
  br label %loop.latch4
merge27:
  br label %merge25
merge25:
  %t165 = phi i8* [ null, %then24 ], [ %t141, %then22 ]
  %t166 = phi double [ %t164, %then24 ], [ %t142, %then22 ]
  store i8* %t165, i8** %l0
  store double %t166, double* %l1
  %t167 = load i8*, i8** %l0
  %s168 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.168, i32 0, i32 0
  %t169 = add i8* %t167, %s168
  store i8* %t169, i8** %l0
  %t170 = load double, double* %l1
  %t171 = sitofp i64 1 to double
  %t172 = fadd double %t170, %t171
  store double %t172, double* %l1
  br label %loop.latch4
merge23:
  %t173 = load i8*, i8** %l0
  %t174 = load i8*, i8** %l2
  %t175 = add i8* %t173, %t174
  store i8* %t175, i8** %l0
  %t176 = load double, double* %l1
  %t177 = sitofp i64 1 to double
  %t178 = fadd double %t176, %t177
  store double %t178, double* %l1
  br label %loop.latch4
loop.latch4:
  %t179 = load i8*, i8** %l0
  %t180 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t183 = load i8*, i8** %l0
  ret i8* %t183
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
  %l9 = alloca double
  store i8* %expression, i8** %l0
  %t0 = load i8*, i8** %l0
  br label %loop.header0
loop.header0:
  %t53 = phi i8* [ %t0, %entry ], [ %t52, %loop.latch2 ]
  store i8* %t53, i8** %l0
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
  store double 0.0, double* %l9
  %t50 = load i8*, i8** %l5
  %t51 = load double, double* %l9
  br label %loop.latch2
loop.latch2:
  %t52 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t54 = load i8*, i8** %l0
  ret i8* %t54
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
  %t49 = phi i8* [ %t0, %entry ], [ %t48, %loop.latch2 ]
  store i8* %t49, i8** %l0
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
  %s44 = getelementptr inbounds [25 x i8], [25 x i8]* @.str.44, i32 0, i32 0
  %t45 = add i8* %t43, %s44
  %t46 = load i8*, i8** %l4
  %t47 = add i8* %t45, %t46
  store i8* %t47, i8** %l0
  br label %loop.latch2
loop.latch2:
  %t48 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t50 = load i8*, i8** %l0
  ret i8* %t50
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
  %t20 = load double, double* %l1
  %t21 = sitofp i64 0 to double
  %t22 = fcmp ogt double %t20, %t21
  br label %logical_or_entry_19

logical_or_entry_19:
  br i1 %t22, label %logical_or_merge_19, label %logical_or_right_19

logical_or_right_19:
  %t23 = load double, double* %l2
  %t24 = sitofp i64 0 to double
  %t25 = fcmp ogt double %t23, %t24
  br label %logical_or_right_end_19

logical_or_right_end_19:
  br label %logical_or_merge_19

logical_or_merge_19:
  %t26 = phi i1 [ true, %logical_or_entry_19 ], [ %t25, %logical_or_right_end_19 ]
  br label %logical_or_entry_18

logical_or_entry_18:
  br i1 %t26, label %logical_or_merge_18, label %logical_or_right_18

logical_or_right_18:
  %t27 = load double, double* %l3
  %t28 = sitofp i64 0 to double
  %t29 = fcmp ogt double %t27, %t28
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
  %t269 = phi double [ %t36, %entry ], [ %t262, %loop.latch4 ]
  %t270 = phi double [ %t37, %entry ], [ %t263, %loop.latch4 ]
  %t271 = phi i1 [ %t38, %entry ], [ %t264, %loop.latch4 ]
  %t272 = phi i8* [ %t35, %entry ], [ %t265, %loop.latch4 ]
  %t273 = phi double [ %t32, %entry ], [ %t266, %loop.latch4 ]
  %t274 = phi double [ %t33, %entry ], [ %t267, %loop.latch4 ]
  %t275 = phi double [ %t34, %entry ], [ %t268, %loop.latch4 ]
  store double %t269, double* %l5
  store double %t270, double* %l6
  store i1 %t271, i1* %l7
  store i8* %t272, i8** %l4
  store double %t273, double* %l1
  store double %t274, double* %l2
  store double %t275, double* %l3
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
  store i8* null, i8** %l4
  %t117 = load double, double* %l1
  %t118 = load i8*, i8** %l9
  %t119 = call double @compute_parenthesis_balance(i8* %t118)
  %t120 = fadd double %t117, %t119
  store double %t120, double* %l1
  %t121 = load double, double* %l2
  %t122 = load i8*, i8** %l9
  %t123 = call double @compute_brace_balance(i8* %t122)
  %t124 = fadd double %t121, %t123
  store double %t124, double* %l2
  %t125 = load double, double* %l3
  %t126 = load i8*, i8** %l9
  %t127 = call double @compute_bracket_balance(i8* %t126)
  %t128 = fadd double %t125, %t127
  store double %t128, double* %l3
  %t129 = load double, double* %l6
  %t130 = sitofp i64 1 to double
  %t131 = fadd double %t129, %t130
  store double %t131, double* %l6
  %t132 = load double, double* %l5
  %t133 = sitofp i64 1 to double
  %t134 = fadd double %t132, %t133
  store double %t134, double* %l5
  %t137 = load double, double* %l1
  %t138 = sitofp i64 0 to double
  %t139 = fcmp ole double %t137, %t138
  br label %logical_and_entry_136

logical_and_entry_136:
  br i1 %t139, label %logical_and_right_136, label %logical_and_merge_136

logical_and_right_136:
  %t140 = load double, double* %l2
  %t141 = sitofp i64 0 to double
  %t142 = fcmp ole double %t140, %t141
  br label %logical_and_right_end_136

logical_and_right_end_136:
  br label %logical_and_merge_136

logical_and_merge_136:
  %t143 = phi i1 [ false, %logical_and_entry_136 ], [ %t142, %logical_and_right_end_136 ]
  br label %logical_and_entry_135

logical_and_entry_135:
  br i1 %t143, label %logical_and_right_135, label %logical_and_merge_135

logical_and_right_135:
  %t144 = load double, double* %l3
  %t145 = sitofp i64 0 to double
  %t146 = fcmp ole double %t144, %t145
  br label %logical_and_right_end_135

logical_and_right_end_135:
  br label %logical_and_merge_135

logical_and_merge_135:
  %t147 = phi i1 [ false, %logical_and_entry_135 ], [ %t146, %logical_and_right_end_135 ]
  %t148 = load i8*, i8** %l0
  %t149 = load double, double* %l1
  %t150 = load double, double* %l2
  %t151 = load double, double* %l3
  %t152 = load i8*, i8** %l4
  %t153 = load double, double* %l5
  %t154 = load double, double* %l6
  %t155 = load i1, i1* %l7
  %t156 = load double, double* %l8
  %t157 = load i8*, i8** %l9
  br i1 %t147, label %then14, label %merge15
then14:
  store i1 1, i1* %l10
  %t158 = load double, double* %l5
  store double %t158, double* %l11
  %t159 = load i8*, i8** %l0
  %t160 = load double, double* %l1
  %t161 = load double, double* %l2
  %t162 = load double, double* %l3
  %t163 = load i8*, i8** %l4
  %t164 = load double, double* %l5
  %t165 = load double, double* %l6
  %t166 = load i1, i1* %l7
  %t167 = load double, double* %l8
  %t168 = load i8*, i8** %l9
  %t169 = load i1, i1* %l10
  %t170 = load double, double* %l11
  br label %loop.header16
loop.header16:
  %t239 = phi double [ %t170, %then14 ], [ %t237, %loop.latch18 ]
  %t240 = phi i1 [ %t169, %then14 ], [ %t238, %loop.latch18 ]
  store double %t239, double* %l11
  store i1 %t240, i1* %l10
  br label %loop.body17
loop.body17:
  %t171 = load double, double* %l11
  %t172 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %instructions
  %t173 = extractvalue { %NativeInstruction*, i64 } %t172, 1
  %t174 = sitofp i64 %t173 to double
  %t175 = fcmp oge double %t171, %t174
  %t176 = load i8*, i8** %l0
  %t177 = load double, double* %l1
  %t178 = load double, double* %l2
  %t179 = load double, double* %l3
  %t180 = load i8*, i8** %l4
  %t181 = load double, double* %l5
  %t182 = load double, double* %l6
  %t183 = load i1, i1* %l7
  %t184 = load double, double* %l8
  %t185 = load i8*, i8** %l9
  %t186 = load i1, i1* %l10
  %t187 = load double, double* %l11
  br i1 %t175, label %then20, label %merge21
then20:
  br label %afterloop19
merge21:
  %t188 = load double, double* %l11
  %t189 = fptosi double %t188 to i64
  %t190 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %instructions
  %t191 = extractvalue { %NativeInstruction*, i64 } %t190, 0
  %t192 = extractvalue { %NativeInstruction*, i64 } %t190, 1
  %t193 = icmp uge i64 %t189, %t192
  ; bounds check: %t193 (if true, out of bounds)
  %t194 = getelementptr %NativeInstruction, %NativeInstruction* %t191, i64 %t189
  %t195 = load %NativeInstruction, %NativeInstruction* %t194
  %t196 = call double @continuation_segment_text(%NativeInstruction %t195)
  store double %t196, double* %l12
  %t197 = load double, double* %l12
  %t198 = load double, double* %l12
  %t199 = call i8* @trim_text(i8* null)
  store i8* %t199, i8** %l13
  %t200 = load i8*, i8** %l13
  %t201 = call i64 @sailfin_runtime_string_length(i8* %t200)
  %t202 = icmp eq i64 %t201, 0
  %t203 = load i8*, i8** %l0
  %t204 = load double, double* %l1
  %t205 = load double, double* %l2
  %t206 = load double, double* %l3
  %t207 = load i8*, i8** %l4
  %t208 = load double, double* %l5
  %t209 = load double, double* %l6
  %t210 = load i1, i1* %l7
  %t211 = load double, double* %l8
  %t212 = load i8*, i8** %l9
  %t213 = load i1, i1* %l10
  %t214 = load double, double* %l11
  %t215 = load double, double* %l12
  %t216 = load i8*, i8** %l13
  br i1 %t202, label %then22, label %merge23
then22:
  %t217 = load double, double* %l11
  %t218 = sitofp i64 1 to double
  %t219 = fadd double %t217, %t218
  store double %t219, double* %l11
  br label %loop.latch18
merge23:
  %t220 = load i8*, i8** %l13
  %t221 = call i1 @segment_signals_expression_continuation(i8* %t220)
  %t222 = load i8*, i8** %l0
  %t223 = load double, double* %l1
  %t224 = load double, double* %l2
  %t225 = load double, double* %l3
  %t226 = load i8*, i8** %l4
  %t227 = load double, double* %l5
  %t228 = load double, double* %l6
  %t229 = load i1, i1* %l7
  %t230 = load double, double* %l8
  %t231 = load i8*, i8** %l9
  %t232 = load i1, i1* %l10
  %t233 = load double, double* %l11
  %t234 = load double, double* %l12
  %t235 = load i8*, i8** %l13
  br i1 %t221, label %then24, label %merge25
then24:
  store i1 0, i1* %l10
  br label %merge25
merge25:
  %t236 = phi i1 [ 0, %then24 ], [ %t232, %loop.body17 ]
  store i1 %t236, i1* %l10
  br label %afterloop19
loop.latch18:
  %t237 = load double, double* %l11
  %t238 = load i1, i1* %l10
  br label %loop.header16
afterloop19:
  %t241 = load i1, i1* %l10
  %t242 = load i8*, i8** %l0
  %t243 = load double, double* %l1
  %t244 = load double, double* %l2
  %t245 = load double, double* %l3
  %t246 = load i8*, i8** %l4
  %t247 = load double, double* %l5
  %t248 = load double, double* %l6
  %t249 = load i1, i1* %l7
  %t250 = load double, double* %l8
  %t251 = load i8*, i8** %l9
  %t252 = load i1, i1* %l10
  %t253 = load double, double* %l11
  br i1 %t241, label %then26, label %merge27
then26:
  %t254 = load i8*, i8** %l4
  %t255 = call i8* @trim_text(i8* %t254)
  %t256 = call i8* @trim_trailing_delimiters(i8* %t255)
  store i8* %t256, i8** %l14
  %t257 = load i8*, i8** %l14
  %t258 = insertvalue %ExpressionContinuationCapture undef, i8* %t257, 0
  %t259 = load double, double* %l6
  %t260 = insertvalue %ExpressionContinuationCapture %t258, double %t259, 1
  %t261 = insertvalue %ExpressionContinuationCapture %t260, i1 1, 2
  ret %ExpressionContinuationCapture %t261
merge27:
  br label %merge15
merge15:
  br label %loop.latch4
loop.latch4:
  %t262 = load double, double* %l5
  %t263 = load double, double* %l6
  %t264 = load i1, i1* %l7
  %t265 = load i8*, i8** %l4
  %t266 = load double, double* %l1
  %t267 = load double, double* %l2
  %t268 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t277 = load i1, i1* %l7
  br label %logical_or_entry_276

logical_or_entry_276:
  br i1 %t277, label %logical_or_merge_276, label %logical_or_right_276

logical_or_right_276:
  %t278 = load double, double* %l6
  %t279 = sitofp i64 0 to double
  %t280 = fcmp oeq double %t278, %t279
  br label %logical_or_right_end_276

logical_or_right_end_276:
  br label %logical_or_merge_276

logical_or_merge_276:
  %t281 = phi i1 [ true, %logical_or_entry_276 ], [ %t280, %logical_or_right_end_276 ]
  %t282 = xor i1 %t281, 1
  %t283 = load i8*, i8** %l0
  %t284 = load double, double* %l1
  %t285 = load double, double* %l2
  %t286 = load double, double* %l3
  %t287 = load i8*, i8** %l4
  %t288 = load double, double* %l5
  %t289 = load double, double* %l6
  %t290 = load i1, i1* %l7
  br i1 %t282, label %then28, label %merge29
then28:
  %t291 = load i8*, i8** %l0
  %t292 = insertvalue %ExpressionContinuationCapture undef, i8* %t291, 0
  %t293 = sitofp i64 0 to double
  %t294 = insertvalue %ExpressionContinuationCapture %t292, double %t293, 1
  %t295 = insertvalue %ExpressionContinuationCapture %t294, i1 0, 2
  ret %ExpressionContinuationCapture %t295
merge29:
  %t298 = load double, double* %l1
  %t299 = sitofp i64 0 to double
  %t300 = fcmp ole double %t298, %t299
  br label %logical_and_entry_297

logical_and_entry_297:
  br i1 %t300, label %logical_and_right_297, label %logical_and_merge_297

logical_and_right_297:
  %t301 = load double, double* %l2
  %t302 = sitofp i64 0 to double
  %t303 = fcmp ole double %t301, %t302
  br label %logical_and_right_end_297

logical_and_right_end_297:
  br label %logical_and_merge_297

logical_and_merge_297:
  %t304 = phi i1 [ false, %logical_and_entry_297 ], [ %t303, %logical_and_right_end_297 ]
  br label %logical_and_entry_296

logical_and_entry_296:
  br i1 %t304, label %logical_and_right_296, label %logical_and_merge_296

logical_and_right_296:
  %t305 = load double, double* %l3
  %t306 = sitofp i64 0 to double
  %t307 = fcmp ole double %t305, %t306
  br label %logical_and_right_end_296

logical_and_right_end_296:
  br label %logical_and_merge_296

logical_and_merge_296:
  %t308 = phi i1 [ false, %logical_and_entry_296 ], [ %t307, %logical_and_right_end_296 ]
  %t309 = load i8*, i8** %l0
  %t310 = load double, double* %l1
  %t311 = load double, double* %l2
  %t312 = load double, double* %l3
  %t313 = load i8*, i8** %l4
  %t314 = load double, double* %l5
  %t315 = load double, double* %l6
  %t316 = load i1, i1* %l7
  br i1 %t308, label %then30, label %merge31
then30:
  %t317 = load i8*, i8** %l4
  %t318 = call i8* @trim_text(i8* %t317)
  %t319 = call i8* @trim_trailing_delimiters(i8* %t318)
  store i8* %t319, i8** %l15
  %t320 = load i8*, i8** %l15
  %t321 = insertvalue %ExpressionContinuationCapture undef, i8* %t320, 0
  %t322 = load double, double* %l6
  %t323 = insertvalue %ExpressionContinuationCapture %t321, double %t322, 1
  %t324 = insertvalue %ExpressionContinuationCapture %t323, i1 1, 2
  ret %ExpressionContinuationCapture %t324
merge31:
  %t325 = load i8*, i8** %l0
  %t326 = insertvalue %ExpressionContinuationCapture undef, i8* %t325, 0
  %t327 = sitofp i64 0 to double
  %t328 = insertvalue %ExpressionContinuationCapture %t326, double %t327, 1
  %t329 = insertvalue %ExpressionContinuationCapture %t328, i1 0, 2
  ret %ExpressionContinuationCapture %t329
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
  %t4 = sitofp i64 0 to double
  %t5 = call i8* @char_at(i8* %segment, double %t4)
  store i8* %t5, i8** %l0
  %t8 = load i8*, i8** %l0
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
  %t172 = phi i8* [ %t10, %entry ], [ %t166, %loop.latch2 ]
  %t173 = phi double [ %t12, %entry ], [ %t167, %loop.latch2 ]
  %t174 = phi i1 [ %t13, %entry ], [ %t168, %loop.latch2 ]
  %t175 = phi i8* [ %t14, %entry ], [ %t169, %loop.latch2 ]
  %t176 = phi double [ %t11, %entry ], [ %t170, %loop.latch2 ]
  %t177 = phi { i8**, i64 }* [ %t9, %entry ], [ %t171, %loop.latch2 ]
  store i8* %t172, i8** %l1
  store double %t173, double* %l3
  store i1 %t174, i1* %l4
  store i8* %t175, i8** %l5
  store double %t176, double* %l2
  store { i8**, i64 }* %t177, { i8**, i64 }** %l0
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
  %t111 = load i8*, i8** %l6
  %t112 = getelementptr i8, i8* %t111, i64 0
  %t113 = load i8, i8* %t112
  %t114 = icmp eq i8 %t113, 123
  br label %logical_or_entry_110

logical_or_entry_110:
  br i1 %t114, label %logical_or_merge_110, label %logical_or_right_110

logical_or_right_110:
  %t115 = load i8*, i8** %l6
  %t116 = getelementptr i8, i8* %t115, i64 0
  %t117 = load i8, i8* %t116
  %t118 = icmp eq i8 %t117, 91
  br label %logical_or_right_end_110

logical_or_right_end_110:
  br label %logical_or_merge_110

logical_or_merge_110:
  %t119 = phi i1 [ true, %logical_or_entry_110 ], [ %t118, %logical_or_right_end_110 ]
  br label %logical_or_entry_109

logical_or_entry_109:
  br i1 %t119, label %logical_or_merge_109, label %logical_or_right_109

logical_or_right_109:
  %t120 = load i8*, i8** %l6
  %t121 = getelementptr i8, i8* %t120, i64 0
  %t122 = load i8, i8* %t121
  %t123 = icmp eq i8 %t122, 40
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
  %t135 = load i8*, i8** %l6
  br label %merge19
merge19:
  %t137 = phi double [ %t134, %then17 ], [ %t127, %else18 ]
  store double %t137, double* %l2
  %t139 = load i8*, i8** %l6
  %t140 = getelementptr i8, i8* %t139, i64 0
  %t141 = load i8, i8* %t140
  %t142 = icmp eq i8 %t141, 44
  br label %logical_and_entry_138

logical_and_entry_138:
  br i1 %t142, label %logical_and_right_138, label %logical_and_merge_138

logical_and_right_138:
  %t143 = load double, double* %l2
  %t144 = sitofp i64 0 to double
  %t145 = fcmp oeq double %t143, %t144
  br label %logical_and_right_end_138

logical_and_right_end_138:
  br label %logical_and_merge_138

logical_and_merge_138:
  %t146 = phi i1 [ false, %logical_and_entry_138 ], [ %t145, %logical_and_right_end_138 ]
  %t147 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t148 = load i8*, i8** %l1
  %t149 = load double, double* %l2
  %t150 = load double, double* %l3
  %t151 = load i1, i1* %l4
  %t152 = load i8*, i8** %l5
  %t153 = load i8*, i8** %l6
  br i1 %t146, label %then20, label %else21
then20:
  %t154 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t155 = load i8*, i8** %l1
  %t156 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t154, i8* %t155)
  store { i8**, i64 }* %t156, { i8**, i64 }** %l0
  %s157 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.157, i32 0, i32 0
  store i8* %s157, i8** %l1
  br label %merge22
else21:
  %t158 = load i8*, i8** %l1
  %t159 = load i8*, i8** %l6
  %t160 = add i8* %t158, %t159
  store i8* %t160, i8** %l1
  br label %merge22
merge22:
  %t161 = phi { i8**, i64 }* [ %t156, %then20 ], [ %t147, %else21 ]
  %t162 = phi i8* [ %s157, %then20 ], [ %t160, %else21 ]
  store { i8**, i64 }* %t161, { i8**, i64 }** %l0
  store i8* %t162, i8** %l1
  %t163 = load double, double* %l3
  %t164 = sitofp i64 1 to double
  %t165 = fadd double %t163, %t164
  store double %t165, double* %l3
  br label %loop.latch2
loop.latch2:
  %t166 = load i8*, i8** %l1
  %t167 = load double, double* %l3
  %t168 = load i1, i1* %l4
  %t169 = load i8*, i8** %l5
  %t170 = load double, double* %l2
  %t171 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t178 = load i8*, i8** %l1
  %t179 = call i64 @sailfin_runtime_string_length(i8* %t178)
  %t180 = icmp sgt i64 %t179, 0
  %t181 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t182 = load i8*, i8** %l1
  %t183 = load double, double* %l2
  %t184 = load double, double* %l3
  %t185 = load i1, i1* %l4
  %t186 = load i8*, i8** %l5
  br i1 %t180, label %then23, label %merge24
then23:
  %t187 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t188 = load i8*, i8** %l1
  %t189 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t187, i8* %t188)
  store { i8**, i64 }* %t189, { i8**, i64 }** %l0
  br label %merge24
merge24:
  %t190 = phi { i8**, i64 }* [ %t189, %then23 ], [ %t181, %entry ]
  store { i8**, i64 }* %t190, { i8**, i64 }** %l0
  %t191 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t191
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
  %t172 = phi i8* [ %t10, %entry ], [ %t166, %loop.latch2 ]
  %t173 = phi double [ %t12, %entry ], [ %t167, %loop.latch2 ]
  %t174 = phi i1 [ %t13, %entry ], [ %t168, %loop.latch2 ]
  %t175 = phi i8* [ %t14, %entry ], [ %t169, %loop.latch2 ]
  %t176 = phi double [ %t11, %entry ], [ %t170, %loop.latch2 ]
  %t177 = phi { i8**, i64 }* [ %t9, %entry ], [ %t171, %loop.latch2 ]
  store i8* %t172, i8** %l1
  store double %t173, double* %l3
  store i1 %t174, i1* %l4
  store i8* %t175, i8** %l5
  store double %t176, double* %l2
  store { i8**, i64 }* %t177, { i8**, i64 }** %l0
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
  %t111 = load i8*, i8** %l6
  %t112 = getelementptr i8, i8* %t111, i64 0
  %t113 = load i8, i8* %t112
  %t114 = icmp eq i8 %t113, 123
  br label %logical_or_entry_110

logical_or_entry_110:
  br i1 %t114, label %logical_or_merge_110, label %logical_or_right_110

logical_or_right_110:
  %t115 = load i8*, i8** %l6
  %t116 = getelementptr i8, i8* %t115, i64 0
  %t117 = load i8, i8* %t116
  %t118 = icmp eq i8 %t117, 91
  br label %logical_or_right_end_110

logical_or_right_end_110:
  br label %logical_or_merge_110

logical_or_merge_110:
  %t119 = phi i1 [ true, %logical_or_entry_110 ], [ %t118, %logical_or_right_end_110 ]
  br label %logical_or_entry_109

logical_or_entry_109:
  br i1 %t119, label %logical_or_merge_109, label %logical_or_right_109

logical_or_right_109:
  %t120 = load i8*, i8** %l6
  %t121 = getelementptr i8, i8* %t120, i64 0
  %t122 = load i8, i8* %t121
  %t123 = icmp eq i8 %t122, 40
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
  %t135 = load i8*, i8** %l6
  br label %merge19
merge19:
  %t137 = phi double [ %t134, %then17 ], [ %t127, %else18 ]
  store double %t137, double* %l2
  %t139 = load i8*, i8** %l6
  %t140 = getelementptr i8, i8* %t139, i64 0
  %t141 = load i8, i8* %t140
  %t142 = icmp eq i8 %t141, 44
  br label %logical_and_entry_138

logical_and_entry_138:
  br i1 %t142, label %logical_and_right_138, label %logical_and_merge_138

logical_and_right_138:
  %t143 = load double, double* %l2
  %t144 = sitofp i64 0 to double
  %t145 = fcmp oeq double %t143, %t144
  br label %logical_and_right_end_138

logical_and_right_end_138:
  br label %logical_and_merge_138

logical_and_merge_138:
  %t146 = phi i1 [ false, %logical_and_entry_138 ], [ %t145, %logical_and_right_end_138 ]
  %t147 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t148 = load i8*, i8** %l1
  %t149 = load double, double* %l2
  %t150 = load double, double* %l3
  %t151 = load i1, i1* %l4
  %t152 = load i8*, i8** %l5
  %t153 = load i8*, i8** %l6
  br i1 %t146, label %then20, label %else21
then20:
  %t154 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t155 = load i8*, i8** %l1
  %t156 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t154, i8* %t155)
  store { i8**, i64 }* %t156, { i8**, i64 }** %l0
  %s157 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.157, i32 0, i32 0
  store i8* %s157, i8** %l1
  br label %merge22
else21:
  %t158 = load i8*, i8** %l1
  %t159 = load i8*, i8** %l6
  %t160 = add i8* %t158, %t159
  store i8* %t160, i8** %l1
  br label %merge22
merge22:
  %t161 = phi { i8**, i64 }* [ %t156, %then20 ], [ %t147, %else21 ]
  %t162 = phi i8* [ %s157, %then20 ], [ %t160, %else21 ]
  store { i8**, i64 }* %t161, { i8**, i64 }** %l0
  store i8* %t162, i8** %l1
  %t163 = load double, double* %l3
  %t164 = sitofp i64 1 to double
  %t165 = fadd double %t163, %t164
  store double %t165, double* %l3
  br label %loop.latch2
loop.latch2:
  %t166 = load i8*, i8** %l1
  %t167 = load double, double* %l3
  %t168 = load i1, i1* %l4
  %t169 = load i8*, i8** %l5
  %t170 = load double, double* %l2
  %t171 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t178 = load i8*, i8** %l1
  %t179 = call i64 @sailfin_runtime_string_length(i8* %t178)
  %t180 = icmp sgt i64 %t179, 0
  %t181 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t182 = load i8*, i8** %l1
  %t183 = load double, double* %l2
  %t184 = load double, double* %l3
  %t185 = load i1, i1* %l4
  %t186 = load i8*, i8** %l5
  br i1 %t180, label %then23, label %merge24
then23:
  %t187 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t188 = load i8*, i8** %l1
  %t189 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t187, i8* %t188)
  store { i8**, i64 }* %t189, { i8**, i64 }** %l0
  br label %merge24
merge24:
  %t190 = phi { i8**, i64 }* [ %t189, %then23 ], [ %t181, %entry ]
  store { i8**, i64 }* %t190, { i8**, i64 }** %l0
  %t191 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t191
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
  %l3 = alloca i8*
  %l4 = alloca double
  %l5 = alloca { %MatchContext*, i64 }*
  %l6 = alloca double
  %l7 = alloca double
  %l8 = alloca i8*
  %l9 = alloca i64
  %l10 = alloca %MatchContext
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
  %t6 = bitcast { i8**, i64 }* %t5 to { %NativeParameter*, i64 }*
  %t7 = call { i8**, i64 }* @render_python_parameters({ %NativeParameter*, i64 }* %t6)
  store { i8**, i64 }* %t7, { i8**, i64 }** %l2
  %s8 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.8, i32 0, i32 0
  %t9 = extractvalue %NativeFunction %function, 0
  %t10 = call i8* @sanitize_identifier(i8* %t9)
  %t11 = add i8* %s8, %t10
  %s12 = getelementptr inbounds [49 x i8], [49 x i8]* @.str.12, i32 0, i32 0
  %t13 = add i8* %t11, %s12
  store i8* %t13, i8** %l3
  %t14 = load %PythonBuilder, %PythonBuilder* %l0
  %t15 = load i8*, i8** %l3
  %t16 = call %PythonBuilder @builder_emit(%PythonBuilder %t14, i8* %t15)
  store %PythonBuilder %t16, %PythonBuilder* %l0
  %t17 = load %PythonBuilder, %PythonBuilder* %l0
  %t18 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t17)
  store %PythonBuilder %t18, %PythonBuilder* %l0
  %t19 = extractvalue %NativeFunction %function, 3
  %t20 = load { i8**, i64 }, { i8**, i64 }* %t19
  %t21 = extractvalue { i8**, i64 } %t20, 1
  %t22 = icmp sgt i64 %t21, 0
  %t23 = load %PythonBuilder, %PythonBuilder* %l0
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t26 = load i8*, i8** %l3
  br i1 %t22, label %then0, label %merge1
then0:
  %t27 = load %PythonBuilder, %PythonBuilder* %l0
  %s28 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.28, i32 0, i32 0
  %t29 = extractvalue %NativeFunction %function, 3
  br label %merge1
merge1:
  %t30 = phi %PythonBuilder [ zeroinitializer, %then0 ], [ %t23, %entry ]
  store %PythonBuilder %t30, %PythonBuilder* %l0
  %t31 = extractvalue %NativeFunction %function, 4
  %t32 = load { i8**, i64 }, { i8**, i64 }* %t31
  %t33 = extractvalue { i8**, i64 } %t32, 1
  %t34 = icmp eq i64 %t33, 0
  %t35 = load %PythonBuilder, %PythonBuilder* %l0
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t38 = load i8*, i8** %l3
  br i1 %t34, label %then2, label %merge3
then2:
  %t39 = load %PythonBuilder, %PythonBuilder* %l0
  %s40 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.40, i32 0, i32 0
  %t41 = call %PythonBuilder @builder_emit(%PythonBuilder %t39, i8* %s40)
  store %PythonBuilder %t41, %PythonBuilder* %l0
  %t42 = load %PythonBuilder, %PythonBuilder* %l0
  %t43 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t42)
  store %PythonBuilder %t43, %PythonBuilder* %l0
  %t44 = load %PythonBuilder, %PythonBuilder* %l0
  %t45 = insertvalue %PythonFunctionEmission undef, i8* null, 0
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t47 = insertvalue %PythonFunctionEmission %t45, { i8**, i64 }* %t46, 1
  ret %PythonFunctionEmission %t47
merge3:
  %t48 = sitofp i64 0 to double
  store double %t48, double* %l4
  %t49 = alloca [0 x %MatchContext]
  %t50 = getelementptr [0 x %MatchContext], [0 x %MatchContext]* %t49, i32 0, i32 0
  %t51 = alloca { %MatchContext*, i64 }
  %t52 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t51, i32 0, i32 0
  store %MatchContext* %t50, %MatchContext** %t52
  %t53 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t51, i32 0, i32 1
  store i64 0, i64* %t53
  store { %MatchContext*, i64 }* %t51, { %MatchContext*, i64 }** %l5
  %t54 = sitofp i64 0 to double
  store double %t54, double* %l6
  %t55 = sitofp i64 0 to double
  store double %t55, double* %l7
  %t56 = load %PythonBuilder, %PythonBuilder* %l0
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t59 = load i8*, i8** %l3
  %t60 = load double, double* %l4
  %t61 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t62 = load double, double* %l6
  %t63 = load double, double* %l7
  br label %loop.header4
loop.header4:
  %t92 = phi double [ %t63, %entry ], [ %t91, %loop.latch6 ]
  store double %t92, double* %l7
  br label %loop.body5
loop.body5:
  %t64 = load double, double* %l7
  %t65 = extractvalue %NativeFunction %function, 4
  %t66 = load { i8**, i64 }, { i8**, i64 }* %t65
  %t67 = extractvalue { i8**, i64 } %t66, 1
  %t68 = sitofp i64 %t67 to double
  %t69 = fcmp oge double %t64, %t68
  %t70 = load %PythonBuilder, %PythonBuilder* %l0
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t73 = load i8*, i8** %l3
  %t74 = load double, double* %l4
  %t75 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t76 = load double, double* %l6
  %t77 = load double, double* %l7
  br i1 %t69, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t78 = extractvalue %NativeFunction %function, 4
  %t79 = load double, double* %l7
  %t80 = fptosi double %t79 to i64
  %t81 = load { i8**, i64 }, { i8**, i64 }* %t78
  %t82 = extractvalue { i8**, i64 } %t81, 0
  %t83 = extractvalue { i8**, i64 } %t81, 1
  %t84 = icmp uge i64 %t80, %t83
  ; bounds check: %t84 (if true, out of bounds)
  %t85 = getelementptr i8*, i8** %t82, i64 %t80
  %t86 = load i8*, i8** %t85
  store i8* %t86, i8** %l8
  %t87 = load i8*, i8** %l8
  %t88 = load double, double* %l7
  %t89 = sitofp i64 1 to double
  %t90 = fadd double %t88, %t89
  store double %t90, double* %l7
  br label %loop.latch6
loop.latch6:
  %t91 = load double, double* %l7
  br label %loop.header4
afterloop7:
  %t93 = load %PythonBuilder, %PythonBuilder* %l0
  %t94 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t95 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t96 = load i8*, i8** %l3
  %t97 = load double, double* %l4
  %t98 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t99 = load double, double* %l6
  %t100 = load double, double* %l7
  br label %loop.header10
loop.header10:
  %t151 = phi %PythonBuilder [ %t93, %entry ], [ %t148, %loop.latch12 ]
  %t152 = phi { i8**, i64 }* [ %t94, %entry ], [ %t149, %loop.latch12 ]
  %t153 = phi { %MatchContext*, i64 }* [ %t98, %entry ], [ %t150, %loop.latch12 ]
  store %PythonBuilder %t151, %PythonBuilder* %l0
  store { i8**, i64 }* %t152, { i8**, i64 }** %l1
  store { %MatchContext*, i64 }* %t153, { %MatchContext*, i64 }** %l5
  br label %loop.body11
loop.body11:
  %t101 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t102 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t101
  %t103 = extractvalue { %MatchContext*, i64 } %t102, 1
  %t104 = icmp eq i64 %t103, 0
  %t105 = load %PythonBuilder, %PythonBuilder* %l0
  %t106 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t107 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t108 = load i8*, i8** %l3
  %t109 = load double, double* %l4
  %t110 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t111 = load double, double* %l6
  %t112 = load double, double* %l7
  br i1 %t104, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t113 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t114 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t113
  %t115 = extractvalue { %MatchContext*, i64 } %t114, 1
  %t116 = sub i64 %t115, 1
  store i64 %t116, i64* %l9
  %t117 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t118 = load i64, i64* %l9
  %t119 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t117
  %t120 = extractvalue { %MatchContext*, i64 } %t119, 0
  %t121 = extractvalue { %MatchContext*, i64 } %t119, 1
  %t122 = icmp uge i64 %t118, %t121
  ; bounds check: %t122 (if true, out of bounds)
  %t123 = getelementptr %MatchContext, %MatchContext* %t120, i64 %t118
  %t124 = load %MatchContext, %MatchContext* %t123
  store %MatchContext %t124, %MatchContext* %l10
  %t125 = load %MatchContext, %MatchContext* %l10
  %t126 = extractvalue %MatchContext %t125, 2
  %t127 = load %PythonBuilder, %PythonBuilder* %l0
  %t128 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t129 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t130 = load i8*, i8** %l3
  %t131 = load double, double* %l4
  %t132 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t133 = load double, double* %l6
  %t134 = load double, double* %l7
  %t135 = load i64, i64* %l9
  %t136 = load %MatchContext, %MatchContext* %l10
  br i1 %t126, label %then16, label %merge17
then16:
  %t137 = load %PythonBuilder, %PythonBuilder* %l0
  %t138 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t137)
  store %PythonBuilder %t138, %PythonBuilder* %l0
  br label %merge17
merge17:
  %t139 = phi %PythonBuilder [ %t138, %then16 ], [ %t127, %loop.body11 ]
  store %PythonBuilder %t139, %PythonBuilder* %l0
  %t140 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t141 = extractvalue %NativeFunction %function, 0
  %s142 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.142, i32 0, i32 0
  %t143 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t140, i8* %t141, i8* %s142)
  store { i8**, i64 }* %t143, { i8**, i64 }** %l1
  %t144 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t145 = load i64, i64* %l9
  %t146 = sitofp i64 %t145 to double
  %t147 = call { %MatchContext*, i64 }* @truncate_match_contexts({ %MatchContext*, i64 }* %t144, double %t146)
  store { %MatchContext*, i64 }* %t147, { %MatchContext*, i64 }** %l5
  br label %loop.latch12
loop.latch12:
  %t148 = load %PythonBuilder, %PythonBuilder* %l0
  %t149 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t150 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  br label %loop.header10
afterloop13:
  %t154 = load %PythonBuilder, %PythonBuilder* %l0
  %t155 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t156 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t157 = load i8*, i8** %l3
  %t158 = load double, double* %l4
  %t159 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t160 = load double, double* %l6
  %t161 = load double, double* %l7
  br label %loop.header18
loop.header18:
  %t183 = phi %PythonBuilder [ %t154, %entry ], [ %t180, %loop.latch20 ]
  %t184 = phi double [ %t158, %entry ], [ %t181, %loop.latch20 ]
  %t185 = phi { i8**, i64 }* [ %t155, %entry ], [ %t182, %loop.latch20 ]
  store %PythonBuilder %t183, %PythonBuilder* %l0
  store double %t184, double* %l4
  store { i8**, i64 }* %t185, { i8**, i64 }** %l1
  br label %loop.body19
loop.body19:
  %t162 = load double, double* %l4
  %t163 = sitofp i64 0 to double
  %t164 = fcmp ole double %t162, %t163
  %t165 = load %PythonBuilder, %PythonBuilder* %l0
  %t166 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t167 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t168 = load i8*, i8** %l3
  %t169 = load double, double* %l4
  %t170 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t171 = load double, double* %l6
  %t172 = load double, double* %l7
  br i1 %t164, label %then22, label %merge23
then22:
  br label %afterloop21
merge23:
  %t173 = load %PythonBuilder, %PythonBuilder* %l0
  %t174 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t173)
  store %PythonBuilder %t174, %PythonBuilder* %l0
  %t175 = load double, double* %l4
  %t176 = sitofp i64 1 to double
  %t177 = fsub double %t175, %t176
  store double %t177, double* %l4
  %t178 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t179 = extractvalue %NativeFunction %function, 0
  br label %loop.latch20
loop.latch20:
  %t180 = load %PythonBuilder, %PythonBuilder* %l0
  %t181 = load double, double* %l4
  %t182 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %loop.header18
afterloop21:
  %t186 = load %PythonBuilder, %PythonBuilder* %l0
  %t187 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t186)
  store %PythonBuilder %t187, %PythonBuilder* %l0
  %t188 = load %PythonBuilder, %PythonBuilder* %l0
  %t189 = insertvalue %PythonFunctionEmission undef, i8* null, 0
  %t190 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t191 = insertvalue %PythonFunctionEmission %t189, { i8**, i64 }* %t190, 1
  ret %PythonFunctionEmission %t191
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
  store i8* null, i8** %l5
  store i1 0, i1* %l6
  %t41 = load i8*, i8** %l1
  %t42 = icmp ne i8* %t41, null
  %t43 = load i8*, i8** %l0
  %t44 = load i8*, i8** %l1
  %t45 = load i8*, i8** %l4
  %t46 = load i8*, i8** %l5
  %t47 = load i1, i1* %l6
  br i1 %t42, label %then8, label %merge9
then8:
  %t48 = load i8*, i8** %l1
  %t49 = call i8* @lower_expression(i8* %t48)
  store i8* %t49, i8** %l7
  %s50 = getelementptr inbounds [48 x i8], [48 x i8]* @.str.50, i32 0, i32 0
  store i8* %s50, i8** %l5
  store i1 1, i1* %l6
  br label %merge9
merge9:
  %t51 = phi i8* [ %s50, %then8 ], [ %t46, %entry ]
  %t52 = phi i1 [ 1, %then8 ], [ %t47, %entry ]
  store i8* %t51, i8** %l5
  store i1 %t52, i1* %l6
  %t53 = load i8*, i8** %l5
  %t54 = insertvalue %LoweredCaseCondition undef, i8* %t53, 0
  %t55 = insertvalue %LoweredCaseCondition %t54, i1 0, 1
  %t56 = load i1, i1* %l6
  %t57 = insertvalue %LoweredCaseCondition %t55, i1 %t56, 2
  ret %LoweredCaseCondition %t57
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
  %t1 = call i8* @join_with_separator({ i8**, i64 }* %t0, i8* null)
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
  %t7 = load i8*, i8** %l0
  %t8 = getelementptr i8, i8* %t7, i64 0
  %t9 = load i8, i8* %t8
  %t10 = add i8 %t9, 10
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
  %t40 = phi i8* [ %t2, %entry ], [ %t38, %loop.latch2 ]
  %t41 = phi double [ %t3, %entry ], [ %t39, %loop.latch2 ]
  store i8* %t40, i8** %l0
  store double %t41, double* %l1
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
  %t15 = call i1 @is_identifier_char(i8* null)
  %t16 = load i8*, i8** %l0
  %t17 = load double, double* %l1
  %t18 = load i8, i8* %l2
  br i1 %t15, label %then6, label %else7
then6:
  %t19 = load i8*, i8** %l0
  %t20 = load i8, i8* %l2
  %t21 = getelementptr i8, i8* %t19, i64 0
  %t22 = load i8, i8* %t21
  %t23 = add i8 %t22, %t20
  store i8* null, i8** %l0
  br label %merge8
else7:
  %t24 = load i8, i8* %l2
  %t25 = icmp eq i8 %t24, 32
  %t26 = load i8*, i8** %l0
  %t27 = load double, double* %l1
  %t28 = load i8, i8* %l2
  br i1 %t25, label %then9, label %merge10
then9:
  %t29 = load i8*, i8** %l0
  %t30 = getelementptr i8, i8* %t29, i64 0
  %t31 = load i8, i8* %t30
  %t32 = add i8 %t31, 95
  store i8* null, i8** %l0
  br label %merge10
merge10:
  %t33 = phi i8* [ null, %then9 ], [ %t26, %else7 ]
  store i8* %t33, i8** %l0
  br label %merge8
merge8:
  %t34 = phi i8* [ null, %then6 ], [ null, %else7 ]
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
  %t43 = call i64 @sailfin_runtime_string_length(i8* %t42)
  %t44 = icmp eq i64 %t43, 0
  %t45 = load i8*, i8** %l0
  %t46 = load double, double* %l1
  br i1 %t44, label %then11, label %merge12
then11:
  %s47 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.47, i32 0, i32 0
  ret i8* %s47
merge12:
  %t48 = load i8*, i8** %l0
  ret i8* %t48
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
  %t67 = phi { i8**, i64 }* [ %t16, %entry ], [ %t64, %loop.latch4 ]
  %t68 = phi i8* [ %t15, %entry ], [ %t65, %loop.latch4 ]
  %t69 = phi double [ %t17, %entry ], [ %t66, %loop.latch4 ]
  store { i8**, i64 }* %t67, { i8**, i64 }** %l2
  store i8* %t68, i8** %l1
  store double %t69, double* %l3
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
  store i8* null, i8** %l1
  br label %merge10
merge10:
  %t59 = phi { i8**, i64 }* [ %t50, %then8 ], [ %t36, %else9 ]
  %t60 = phi i8* [ %s51, %then8 ], [ null, %else9 ]
  store { i8**, i64 }* %t59, { i8**, i64 }** %l2
  store i8* %t60, i8** %l1
  %t61 = load double, double* %l3
  %t62 = sitofp i64 1 to double
  %t63 = fadd double %t61, %t62
  store double %t63, double* %l3
  br label %loop.latch4
loop.latch4:
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t65 = load i8*, i8** %l1
  %t66 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t70 = load i8*, i8** %l1
  %t71 = call i64 @sailfin_runtime_string_length(i8* %t70)
  %t72 = icmp sgt i64 %t71, 0
  %t73 = load i8*, i8** %l0
  %t74 = load i8*, i8** %l1
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t76 = load double, double* %l3
  br i1 %t72, label %then13, label %merge14
then13:
  %t77 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t78 = load i8*, i8** %l1
  %t79 = call i8* @sanitize_identifier(i8* %t78)
  %t80 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t77, i8* %t79)
  store { i8**, i64 }* %t80, { i8**, i64 }** %l2
  br label %merge14
merge14:
  %t81 = phi { i8**, i64 }* [ %t80, %then13 ], [ %t75, %entry ]
  store { i8**, i64 }* %t81, { i8**, i64 }** %l2
  %t82 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t83 = load { i8**, i64 }, { i8**, i64 }* %t82
  %t84 = extractvalue { i8**, i64 } %t83, 1
  %t85 = icmp eq i64 %t84, 0
  %t86 = load i8*, i8** %l0
  %t87 = load i8*, i8** %l1
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t89 = load double, double* %l3
  br i1 %t85, label %then15, label %merge16
then15:
  %t90 = load i8*, i8** %l0
  %t91 = call i8* @sanitize_identifier(i8* %t90)
  ret i8* %t91
merge16:
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t93 = call i8* @join_with_separator({ i8**, i64 }* %t92, i8* null)
  ret i8* %t93
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
  %t20 = load i8*, i8** %l2
  %t21 = getelementptr i8, i8* %t20, i64 0
  %t22 = load i8, i8* %t21
  %t23 = icmp eq i8 %t22, 32
  br label %logical_or_entry_19

logical_or_entry_19:
  br i1 %t23, label %logical_or_merge_19, label %logical_or_right_19

logical_or_right_19:
  %t24 = load i8*, i8** %l2
  %t25 = getelementptr i8, i8* %t24, i64 0
  %t26 = load i8, i8* %t25
  %t27 = icmp eq i8 %t26, 10
  br label %logical_or_right_end_19

logical_or_right_end_19:
  br label %logical_or_merge_19

logical_or_merge_19:
  %t28 = phi i1 [ true, %logical_or_entry_19 ], [ %t27, %logical_or_right_end_19 ]
  br label %logical_or_entry_18

logical_or_entry_18:
  br i1 %t28, label %logical_or_merge_18, label %logical_or_right_18

logical_or_right_18:
  %t29 = load i8*, i8** %l2
  %t30 = getelementptr i8, i8* %t29, i64 0
  %t31 = load i8, i8* %t30
  %t32 = icmp eq i8 %t31, 13
  br label %logical_or_right_end_18

logical_or_right_end_18:
  br label %logical_or_merge_18

logical_or_merge_18:
  %t33 = phi i1 [ true, %logical_or_entry_18 ], [ %t32, %logical_or_right_end_18 ]
  br label %logical_or_entry_17

logical_or_entry_17:
  br i1 %t33, label %logical_or_merge_17, label %logical_or_right_17

logical_or_right_17:
  %t34 = load i8*, i8** %l2
  %t35 = getelementptr i8, i8* %t34, i64 0
  %t36 = load i8, i8* %t35
  %t37 = icmp eq i8 %t36, 9
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
  %t67 = load i8*, i8** %l4
  %t68 = getelementptr i8, i8* %t67, i64 0
  %t69 = load i8, i8* %t68
  %t70 = icmp eq i8 %t69, 32
  br label %logical_or_entry_66

logical_or_entry_66:
  br i1 %t70, label %logical_or_merge_66, label %logical_or_right_66

logical_or_right_66:
  %t71 = load i8*, i8** %l4
  %t72 = getelementptr i8, i8* %t71, i64 0
  %t73 = load i8, i8* %t72
  %t74 = icmp eq i8 %t73, 10
  br label %logical_or_right_end_66

logical_or_right_end_66:
  br label %logical_or_merge_66

logical_or_merge_66:
  %t75 = phi i1 [ true, %logical_or_entry_66 ], [ %t74, %logical_or_right_end_66 ]
  br label %logical_or_entry_65

logical_or_entry_65:
  br i1 %t75, label %logical_or_merge_65, label %logical_or_right_65

logical_or_right_65:
  %t76 = load i8*, i8** %l4
  %t77 = getelementptr i8, i8* %t76, i64 0
  %t78 = load i8, i8* %t77
  %t79 = icmp eq i8 %t78, 13
  br label %logical_or_right_end_65

logical_or_right_end_65:
  br label %logical_or_merge_65

logical_or_merge_65:
  %t80 = phi i1 [ true, %logical_or_entry_65 ], [ %t79, %logical_or_right_end_65 ]
  br label %logical_or_entry_64

logical_or_entry_64:
  br i1 %t80, label %logical_or_merge_64, label %logical_or_right_64

logical_or_right_64:
  %t81 = load i8*, i8** %l4
  %t82 = getelementptr i8, i8* %t81, i64 0
  %t83 = load i8, i8* %t82
  %t84 = icmp eq i8 %t83, 9
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
