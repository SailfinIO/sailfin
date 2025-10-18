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

declare noalias i8* @malloc(i64)

@.str.7 = private unnamed_addr constant [15 x i8] c"import asyncio\00"
@.str.10 = private unnamed_addr constant [47 x i8] c"from runtime import runtime_support as runtime\00"
@.str.1 = private unnamed_addr constant [24 x i8] c"print = runtime.console\00"
@.str.4 = private unnamed_addr constant [22 x i8] c"sleep = runtime.sleep\00"
@.str.7 = private unnamed_addr constant [26 x i8] c"channel = runtime.channel\00"
@.str.10 = private unnamed_addr constant [28 x i8] c"parallel = runtime.parallel\00"
@.str.13 = private unnamed_addr constant [22 x i8] c"spawn = runtime.spawn\00"
@.str.16 = private unnamed_addr constant [16 x i8] c"fs = runtime.fs\00"
@.str.19 = private unnamed_addr constant [22 x i8] c"serve = runtime.serve\00"
@.str.22 = private unnamed_addr constant [20 x i8] c"http = runtime.http\00"
@.str.25 = private unnamed_addr constant [30 x i8] c"websocket = runtime.websocket\00"
@.str.28 = private unnamed_addr constant [36 x i8] c"logExecution = runtime.logExecution\00"
@.str.31 = private unnamed_addr constant [30 x i8] c"array_map = runtime.array_map\00"
@.str.34 = private unnamed_addr constant [36 x i8] c"array_filter = runtime.array_filter\00"
@.str.37 = private unnamed_addr constant [36 x i8] c"array_reduce = runtime.array_reduce\00"
@.str.1 = private unnamed_addr constant [42 x i8] c" = runtime.enum_type('\22 + enum_name + \22')\00"
@.str.1 = private unnamed_addr constant [6 x i8] c"from \00"
@.str.2 = private unnamed_addr constant [5 x i8] c" as \00"
@.str.5 = private unnamed_addr constant [2 x i8] c".\00"
@.str.119 = private unnamed_addr constant [12 x i8] c"__all__ = [\00"
@.str.0 = private unnamed_addr constant [7 x i8] c"class \00"
@.str.9 = private unnamed_addr constant [18 x i8] c"def __init__(self\00"
@.str.13 = private unnamed_addr constant [2 x i8] c":\00"
@.str.23 = private unnamed_addr constant [20 x i8] c"def __repr__(self):\00"
@.str.37 = private unnamed_addr constant [96 x i8] c"return runtime.struct_repr('\22 + class_name + \22', [\22 + join_with_separator(rendered, \22, \22) + \22])\00"
@.str.3 = private unnamed_addr constant [2 x i8] c"?\00"
@.str.0 = private unnamed_addr constant [2 x i8] c"'\00"
@.str.0 = private unnamed_addr constant [1 x i8] c"\00"
@.str.0 = private unnamed_addr constant [7 x i8] c".push(\00"
@.str.1 = private unnamed_addr constant [9 x i8] c".append(\00"
@.str.0 = private unnamed_addr constant [7 x i8] c"(\22, \22)\00"
@.str.0 = private unnamed_addr constant [7 x i8] c"[\22, \22]\00"
@.str.5 = private unnamed_addr constant [5 x i8] c"def \00"
@.str.0 = private unnamed_addr constant [15 x i8] c"__match_value_\00"
@.str.3 = private unnamed_addr constant [11 x i8] c"0123456789\00"
@.str.1 = private unnamed_addr constant [2 x i8] c"\0A\00"
@.str.1 = private unnamed_addr constant [12 x i8] c"[lowering] \00"

define %LoweredPythonResult @lower_to_python(i8* %native_module) {
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
  store double 0.0, double* %l1
  %t5 = load double, double* %l1
  %t6 = load double, double* %l1
  store double 0.0, double* %l2
  %t7 = load double, double* %l2
  %t8 = load double, double* %l2
  %t9 = load double, double* %l2
  %t10 = load double, double* %l2
  %t11 = load double, double* %l2
  %t12 = load double, double* %l2
  store double 0.0, double* %l3
  %t13 = load double, double* %l3
  %t14 = load double, double* %l3
  store double 0.0, double* %l4
  %t15 = load double, double* %l4
  %t16 = insertvalue %LoweredPythonResult undef, i8* null, 0
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = insertvalue %LoweredPythonResult %t16, { i8**, i64 }* %t17, 1
  ret %LoweredPythonResult %t18
}

define %PythonModuleEmission @emit_python_module({ i8**, i64 }* %functions, { i8**, i64 }* %imports, { i8**, i64 }* %structs, { i8**, i64 }* %enums, { i8**, i64 }* %bindings) {
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
  %t17 = load { i8**, i64 }, { i8**, i64 }* %imports
  %t18 = extractvalue { i8**, i64 } %t17, 1
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
  %t26 = call %PythonImportEmission @emit_python_imports(%PythonBuilder %t25, { i8**, i64 }* %imports)
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
  %t38 = load { i8**, i64 }, { i8**, i64 }* %bindings
  %t39 = extractvalue { i8**, i64 } %t38, 1
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
  %t47 = call %PythonBuilder @emit_top_level_bindings(%PythonBuilder %t46, { i8**, i64 }* %bindings)
  store %PythonBuilder %t47, %PythonBuilder* %l0
  br label %merge3
merge3:
  %t48 = phi %PythonBuilder [ %t45, %then2 ], [ %t41, %entry ]
  %t49 = phi %PythonBuilder [ %t47, %then2 ], [ %t41, %entry ]
  store %PythonBuilder %t48, %PythonBuilder* %l0
  store %PythonBuilder %t49, %PythonBuilder* %l0
  %t50 = load { i8**, i64 }, { i8**, i64 }* %enums
  %t51 = extractvalue { i8**, i64 } %t50, 1
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
  %t59 = call %PythonBuilder @emit_enum_definitions(%PythonBuilder %t58, { i8**, i64 }* %enums)
  store %PythonBuilder %t59, %PythonBuilder* %l0
  br label %merge5
merge5:
  %t60 = phi %PythonBuilder [ %t57, %then4 ], [ %t53, %entry ]
  %t61 = phi %PythonBuilder [ %t59, %then4 ], [ %t53, %entry ]
  store %PythonBuilder %t60, %PythonBuilder* %l0
  store %PythonBuilder %t61, %PythonBuilder* %l0
  %t62 = load { i8**, i64 }, { i8**, i64 }* %structs
  %t63 = extractvalue { i8**, i64 } %t62, 1
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
  %t71 = call %PythonStructEmission @emit_struct_definitions(%PythonBuilder %t70, { i8**, i64 }* %structs)
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
  %t88 = load { i8**, i64 }, { i8**, i64 }* %functions
  %t89 = extractvalue { i8**, i64 } %t88, 1
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
  %t98 = load { i8**, i64 }, { i8**, i64 }* %functions
  %t99 = extractvalue { i8**, i64 } %t98, 0
  %t100 = extractvalue { i8**, i64 } %t98, 1
  %t101 = icmp uge i64 %t97, %t100
  ; bounds check: %t101 (if true, out of bounds)
  %t102 = getelementptr i8*, i8** %t99, i64 %t97
  %t103 = load i8*, i8** %t102
  %t104 = call %PythonFunctionEmission @emit_python_function(%PythonBuilder %t96, i8* %t103)
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
  %t113 = load { i8**, i64 }, { i8**, i64 }* %functions
  %t114 = extractvalue { i8**, i64 } %t113, 1
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

define %PythonBuilder @emit_top_level_bindings(%PythonBuilder %builder, { i8**, i64 }* %bindings) {
entry:
  %l0 = alloca %PythonBuilder
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca i8*
  store %PythonBuilder %builder, %PythonBuilder* %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load %PythonBuilder, %PythonBuilder* %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t29 = phi %PythonBuilder [ %t1, %entry ], [ %t27, %loop.latch2 ]
  %t30 = phi double [ %t2, %entry ], [ %t28, %loop.latch2 ]
  store %PythonBuilder %t29, %PythonBuilder* %l0
  store double %t30, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load { i8**, i64 }, { i8**, i64 }* %bindings
  %t5 = extractvalue { i8**, i64 } %t4, 1
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp oge double %t3, %t6
  %t8 = load %PythonBuilder, %PythonBuilder* %l0
  %t9 = load double, double* %l1
  br i1 %t7, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t10 = load double, double* %l1
  %t11 = load { i8**, i64 }, { i8**, i64 }* %bindings
  %t12 = extractvalue { i8**, i64 } %t11, 0
  %t13 = extractvalue { i8**, i64 } %t11, 1
  %t14 = icmp uge i64 %t10, %t13
  ; bounds check: %t14 (if true, out of bounds)
  %t15 = getelementptr i8*, i8** %t12, i64 %t10
  %t16 = load i8*, i8** %t15
  store i8* %t16, i8** %l2
  %t17 = load i8*, i8** %l2
  store double 0.0, double* %l3
  %t18 = load double, double* %l3
  %s19 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.19, i32 0, i32 0
  store i8* null, i8** %l4
  %t20 = load i8*, i8** %l2
  %t21 = load %PythonBuilder, %PythonBuilder* %l0
  %t22 = load i8*, i8** %l4
  %t23 = call %PythonBuilder @builder_emit(%PythonBuilder %t21, i8* %t22)
  store %PythonBuilder %t23, %PythonBuilder* %l0
  %t24 = load double, double* %l1
  %t25 = sitofp i64 1 to double
  %t26 = fadd double %t24, %t25
  store double %t26, double* %l1
  br label %loop.latch2
loop.latch2:
  %t27 = load %PythonBuilder, %PythonBuilder* %l0
  %t28 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t31 = load %PythonBuilder, %PythonBuilder* %l0
  ret %PythonBuilder %t31
}

define %PythonImportEmission @emit_python_imports(%PythonBuilder %builder, { i8**, i64 }* %imports) {
entry:
  %l0 = alloca %PythonBuilder
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca i8*
  %l4 = alloca i8*
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
  %t32 = phi double [ %t8, %entry ], [ %t31, %loop.latch2 ]
  store double %t32, double* %l2
  br label %loop.body1
loop.body1:
  %t9 = load double, double* %l2
  %t10 = load { i8**, i64 }, { i8**, i64 }* %imports
  %t11 = extractvalue { i8**, i64 } %t10, 1
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
  %t18 = load { i8**, i64 }, { i8**, i64 }* %imports
  %t19 = extractvalue { i8**, i64 } %t18, 0
  %t20 = extractvalue { i8**, i64 } %t18, 1
  %t21 = icmp uge i64 %t17, %t20
  ; bounds check: %t21 (if true, out of bounds)
  %t22 = getelementptr i8*, i8** %t19, i64 %t17
  %t23 = load i8*, i8** %t22
  store i8* %t23, i8** %l3
  %t24 = load i8*, i8** %l3
  %t25 = load i8*, i8** %l3
  %t26 = call i8* @render_python_import(i8* %t25)
  store i8* %t26, i8** %l4
  %t27 = load i8*, i8** %l4
  %t28 = load double, double* %l2
  %t29 = sitofp i64 1 to double
  %t30 = fadd double %t28, %t29
  store double %t30, double* %l2
  br label %loop.latch2
loop.latch2:
  %t31 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t33 = load %PythonBuilder, %PythonBuilder* %l0
  %t34 = insertvalue %PythonImportEmission undef, i8* null, 0
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t36 = insertvalue %PythonImportEmission %t34, { i8**, i64 }* %t35, 1
  ret %PythonImportEmission %t36
}

define %PythonBuilder @emit_enum_definitions(%PythonBuilder %builder, { i8**, i64 }* %enums) {
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
  %t4 = load { i8**, i64 }, { i8**, i64 }* %enums
  %t5 = extractvalue { i8**, i64 } %t4, 1
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
  %t12 = load { i8**, i64 }, { i8**, i64 }* %enums
  %t13 = extractvalue { i8**, i64 } %t12, 0
  %t14 = extractvalue { i8**, i64 } %t12, 1
  %t15 = icmp uge i64 %t11, %t14
  ; bounds check: %t15 (if true, out of bounds)
  %t16 = getelementptr i8*, i8** %t13, i64 %t11
  %t17 = load i8*, i8** %t16
  %t18 = call %PythonBuilder @emit_single_enum(%PythonBuilder %t10, i8* %t17)
  store %PythonBuilder %t18, %PythonBuilder* %l0
  %t19 = load double, double* %l1
  %t20 = sitofp i64 1 to double
  %t21 = fadd double %t19, %t20
  %t22 = load { i8**, i64 }, { i8**, i64 }* %enums
  %t23 = extractvalue { i8**, i64 } %t22, 1
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

define %PythonBuilder @emit_single_enum(%PythonBuilder %builder, i8* %definition) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  store double 0.0, double* %l0
  %t0 = load double, double* %l0
  %s1 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.1, i32 0, i32 0
  store double 0.0, double* %l1
  %t2 = sitofp i64 0 to double
  store double %t2, double* %l2
  %t3 = load double, double* %l0
  %t4 = load double, double* %l1
  %t5 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t18 = phi double [ %t4, %entry ], [ %t16, %loop.latch2 ]
  %t19 = phi double [ %t5, %entry ], [ %t17, %loop.latch2 ]
  store double %t18, double* %l1
  store double %t19, double* %l2
  br label %loop.body1
loop.body1:
  %t6 = load double, double* %l2
  store double 0.0, double* %l3
  %t7 = load double, double* %l3
  store double 0.0, double* %l4
  %t8 = load double, double* %l0
  %s9 = getelementptr inbounds [128 x i8], [128 x i8]* @.str.9, i32 0, i32 0
  store double 0.0, double* %l5
  %t10 = load double, double* %l1
  %t11 = load double, double* %l5
  %t12 = call %PythonBuilder @builder_emit(%PythonBuilder zeroinitializer, i8* null)
  store double 0.0, double* %l1
  %t13 = load double, double* %l2
  %t14 = sitofp i64 1 to double
  %t15 = fadd double %t13, %t14
  store double %t15, double* %l2
  br label %loop.latch2
loop.latch2:
  %t16 = load double, double* %l1
  %t17 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t20 = load double, double* %l1
  ret %PythonBuilder zeroinitializer
}

define i8* @render_enum_variant_fields({ i8**, i64 }* %fields) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %t0 = load { i8**, i64 }, { i8**, i64 }* %fields
  %t1 = extractvalue { i8**, i64 } %t0, 1
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
  %t33 = phi { i8**, i64 }* [ %t10, %entry ], [ %t31, %loop.latch4 ]
  %t34 = phi double [ %t11, %entry ], [ %t32, %loop.latch4 ]
  store { i8**, i64 }* %t33, { i8**, i64 }** %l0
  store double %t34, double* %l1
  br label %loop.body3
loop.body3:
  %t12 = load double, double* %l1
  %t13 = load { i8**, i64 }, { i8**, i64 }* %fields
  %t14 = extractvalue { i8**, i64 } %t13, 1
  %t15 = sitofp i64 %t14 to double
  %t16 = fcmp oge double %t12, %t15
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = load double, double* %l1
  br i1 %t16, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s20 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.20, i32 0, i32 0
  %t21 = load double, double* %l1
  %t22 = load { i8**, i64 }, { i8**, i64 }* %fields
  %t23 = extractvalue { i8**, i64 } %t22, 0
  %t24 = extractvalue { i8**, i64 } %t22, 1
  %t25 = icmp uge i64 %t21, %t24
  ; bounds check: %t25 (if true, out of bounds)
  %t26 = getelementptr i8*, i8** %t23, i64 %t21
  %t27 = load i8*, i8** %t26
  %t28 = load double, double* %l1
  %t29 = sitofp i64 1 to double
  %t30 = fadd double %t28, %t29
  store double %t30, double* %l1
  br label %loop.latch4
loop.latch4:
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t32 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret i8* null
}

define i8* @render_python_import(i8* %entry) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  store double 0.0, double* %l0
  %t0 = load double, double* %l0
  store double 0.0, double* %l1
  %s1 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.1, i32 0, i32 0
  %t2 = load double, double* %l0
  ret i8* null
}

define i8* @render_python_specifiers({ i8**, i64 }* %specifiers) {
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
  %t9 = load { i8**, i64 }, { i8**, i64 }* %specifiers
  %t10 = extractvalue { i8**, i64 } %t9, 1
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
  %t17 = load { i8**, i64 }, { i8**, i64 }* %specifiers
  %t18 = extractvalue { i8**, i64 } %t17, 0
  %t19 = extractvalue { i8**, i64 } %t17, 1
  %t20 = icmp uge i64 %t16, %t19
  ; bounds check: %t20 (if true, out of bounds)
  %t21 = getelementptr i8*, i8** %t18, i64 %t16
  %t22 = load i8*, i8** %t21
  %t23 = call i8* @render_python_specifier(i8* %t22)
  %t24 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t15, i8* %t23)
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

define i8* @render_python_specifier(i8* %specifier) {
entry:
  %l0 = alloca double
  store double 0.0, double* %l0
  %t1 = load double, double* %l0
  %s2 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.2, i32 0, i32 0
  ret i8* null
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
  %s5 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.5, i32 0, i32 0
  ret i8* null
}

define %PythonStructEmission @emit_struct_definitions(%PythonBuilder %builder, { i8**, i64 }* %structs) {
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
  %t10 = load { i8**, i64 }, { i8**, i64 }* %structs
  %t11 = extractvalue { i8**, i64 } %t10, 1
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
  %t19 = load { i8**, i64 }, { i8**, i64 }* %structs
  %t20 = extractvalue { i8**, i64 } %t19, 0
  %t21 = extractvalue { i8**, i64 } %t19, 1
  %t22 = icmp uge i64 %t18, %t21
  ; bounds check: %t22 (if true, out of bounds)
  %t23 = getelementptr i8*, i8** %t20, i64 %t18
  %t24 = load i8*, i8** %t23
  %t25 = call %PythonStructEmission @emit_single_struct(%PythonBuilder %t17, i8* %t24)
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
  %t34 = load { i8**, i64 }, { i8**, i64 }* %structs
  %t35 = extractvalue { i8**, i64 } %t34, 1
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
  %t71 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t69, i8* %t70)
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
  %s99 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.99, i32 0, i32 0
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t101 = load double, double* %l1
  %t102 = load { i8**, i64 }, { i8**, i64 }* %t100
  %t103 = extractvalue { i8**, i64 } %t102, 0
  %t104 = extractvalue { i8**, i64 } %t102, 1
  %t105 = icmp uge i64 %t101, %t104
  ; bounds check: %t105 (if true, out of bounds)
  %t106 = getelementptr i8*, i8** %t103, i64 %t101
  %t107 = load i8*, i8** %t106
  %t108 = add i8* %s99, %t107
  %s109 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.109, i32 0, i32 0
  %t110 = add i8* %t108, %s109
  %t111 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t98, i8* %t110)
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

define { i8**, i64 }* @collect_export_names({ i8**, i64 }* %existing, { i8**, i64 }* %specifiers) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca i8*
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
  %t4 = load { i8**, i64 }, { i8**, i64 }* %specifiers
  %t5 = extractvalue { i8**, i64 } %t4, 1
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp oge double %t3, %t6
  %t8 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t9 = load double, double* %l1
  br i1 %t7, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t10 = load double, double* %l1
  %t11 = load { i8**, i64 }, { i8**, i64 }* %specifiers
  %t12 = extractvalue { i8**, i64 } %t11, 0
  %t13 = extractvalue { i8**, i64 } %t11, 1
  %t14 = icmp uge i64 %t10, %t13
  ; bounds check: %t14 (if true, out of bounds)
  %t15 = getelementptr i8*, i8** %t12, i64 %t10
  %t16 = load i8*, i8** %t15
  store i8* %t16, i8** %l2
  %t17 = load i8*, i8** %l2
  %t18 = call i8* @select_export_name(i8* %t17)
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

define i8* @select_export_name(i8* %specifier) {
entry:
  ret i8* null
}

define %PythonStructEmission @emit_single_struct(%PythonBuilder %builder, i8* %definition) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca double
  store double 0.0, double* %l0
  %s0 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.0, i32 0, i32 0
  %t1 = load double, double* %l0
  store double 0.0, double* %l1
  %t2 = load double, double* %l1
  %t3 = call %PythonBuilder @builder_push_indent(%PythonBuilder zeroinitializer)
  store double 0.0, double* %l1
  %t4 = alloca [0 x double]
  %t5 = getelementptr [0 x double], [0 x double]* %t4, i32 0, i32 0
  %t6 = alloca { double*, i64 }
  %t7 = getelementptr { double*, i64 }, { double*, i64 }* %t6, i32 0, i32 0
  store double* %t5, double** %t7
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t6, i32 0, i32 1
  store i64 0, i64* %t8
  store { i8**, i64 }* null, { i8**, i64 }** %l2
  store double 0.0, double* %l3
  %s9 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.9, i32 0, i32 0
  store i8* %s9, i8** %l4
  %t10 = load double, double* %l3
  %t11 = load double, double* %l1
  %t12 = load i8*, i8** %l4
  %s13 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.13, i32 0, i32 0
  %t14 = add i8* %t12, %s13
  %t15 = call %PythonBuilder @builder_emit(%PythonBuilder zeroinitializer, i8* %t14)
  store double 0.0, double* %l1
  %t16 = load double, double* %l1
  %t17 = call %PythonBuilder @builder_push_indent(%PythonBuilder zeroinitializer)
  store double 0.0, double* %l1
  %t18 = load double, double* %l1
  %t19 = call %PythonBuilder @builder_pop_indent(%PythonBuilder zeroinitializer)
  store double 0.0, double* %l1
  %t20 = load double, double* %l1
  %t21 = call %PythonBuilder @builder_emit_blank(%PythonBuilder zeroinitializer)
  store double 0.0, double* %l1
  %t22 = load double, double* %l1
  %s23 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.23, i32 0, i32 0
  %t24 = call %PythonBuilder @builder_emit(%PythonBuilder zeroinitializer, i8* %s23)
  store double 0.0, double* %l1
  %t25 = load double, double* %l1
  %t26 = call %PythonBuilder @builder_push_indent(%PythonBuilder zeroinitializer)
  store double 0.0, double* %l1
  %t27 = load double, double* %l0
  store double 0.0, double* %l5
  %t28 = load double, double* %l1
  %t29 = load double, double* %l5
  %t30 = call %PythonBuilder @builder_emit(%PythonBuilder zeroinitializer, i8* null)
  store double 0.0, double* %l1
  %t31 = load double, double* %l1
  %t32 = call %PythonBuilder @builder_pop_indent(%PythonBuilder zeroinitializer)
  store double 0.0, double* %l1
  %t33 = load double, double* %l0
  %s34 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.34, i32 0, i32 0
  %t35 = load double, double* %l1
  %t36 = call %PythonBuilder @builder_pop_indent(%PythonBuilder zeroinitializer)
  store double 0.0, double* %l1
  %t37 = load double, double* %l1
  %t38 = insertvalue %PythonStructEmission undef, i8* null, 0
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t40 = insertvalue %PythonStructEmission %t38, { i8**, i64 }* %t39, 1
  ret %PythonStructEmission %t40
}

define { i8**, i64 }* @render_struct_parameters({ i8**, i64 }* %fields) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca i8*
  %l4 = alloca double
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
  %t36 = phi double [ %t13, %entry ], [ %t35, %loop.latch2 ]
  store double %t36, double* %l2
  br label %loop.body1
loop.body1:
  %t14 = load double, double* %l2
  %t15 = load { i8**, i64 }, { i8**, i64 }* %fields
  %t16 = extractvalue { i8**, i64 } %t15, 1
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
  %t23 = load { i8**, i64 }, { i8**, i64 }* %fields
  %t24 = extractvalue { i8**, i64 } %t23, 0
  %t25 = extractvalue { i8**, i64 } %t23, 1
  %t26 = icmp uge i64 %t22, %t25
  ; bounds check: %t26 (if true, out of bounds)
  %t27 = getelementptr i8*, i8** %t24, i64 %t22
  %t28 = load i8*, i8** %t27
  store i8* %t28, i8** %l3
  %t29 = load i8*, i8** %l3
  store double 0.0, double* %l4
  %t30 = load double, double* %l4
  store i8* null, i8** %l5
  %t31 = load i8*, i8** %l3
  %t32 = load double, double* %l2
  %t33 = sitofp i64 1 to double
  %t34 = fadd double %t32, %t33
  store double %t34, double* %l2
  br label %loop.latch2
loop.latch2:
  %t35 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t38 = call double @requiredconcat({ i8**, i64 }* %t37)
  ret { i8**, i64 }* null
}

define i8* @render_struct_repr_fields(i8* %class_name, { i8**, i64 }* %fields) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
  %t0 = load { i8**, i64 }, { i8**, i64 }* %fields
  %t1 = extractvalue { i8**, i64 } %t0, 1
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
  %t35 = phi { i8**, i64 }* [ %t10, %entry ], [ %t33, %loop.latch4 ]
  %t36 = phi double [ %t11, %entry ], [ %t34, %loop.latch4 ]
  store { i8**, i64 }* %t35, { i8**, i64 }** %l0
  store double %t36, double* %l1
  br label %loop.body3
loop.body3:
  %t12 = load double, double* %l1
  %t13 = load { i8**, i64 }, { i8**, i64 }* %fields
  %t14 = extractvalue { i8**, i64 } %t13, 1
  %t15 = sitofp i64 %t14 to double
  %t16 = fcmp oge double %t12, %t15
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = load double, double* %l1
  br i1 %t16, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t19 = load double, double* %l1
  %t20 = load { i8**, i64 }, { i8**, i64 }* %fields
  %t21 = extractvalue { i8**, i64 } %t20, 0
  %t22 = extractvalue { i8**, i64 } %t20, 1
  %t23 = icmp uge i64 %t19, %t22
  ; bounds check: %t23 (if true, out of bounds)
  %t24 = getelementptr i8*, i8** %t21, i64 %t19
  %t25 = load i8*, i8** %t24
  store i8* %t25, i8** %l2
  %t26 = load i8*, i8** %l2
  store double 0.0, double* %l3
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s28 = getelementptr inbounds [56 x i8], [56 x i8]* @.str.28, i32 0, i32 0
  %t29 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t27, i8* %s28)
  store { i8**, i64 }* %t29, { i8**, i64 }** %l0
  %t30 = load double, double* %l1
  %t31 = sitofp i64 1 to double
  %t32 = fadd double %t30, %t31
  store double %t32, double* %l1
  br label %loop.latch4
loop.latch4:
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t34 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %s37 = getelementptr inbounds [96 x i8], [96 x i8]* @.str.37, i32 0, i32 0
  ret i8* %s37
}

define i1 @is_optional_type(i8* %type_annotation) {
entry:
  %l0 = alloca i8*
  %t0 = call i8* @trim_text(i8* %type_annotation)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = load i8*, i8** %l0
  %s3 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.3, i32 0, i32 0
  %t4 = call i1 @ends_with(i8* %t2, i8* %s3)
  ret i1 %t4
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
  %s0 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.0, i32 0, i32 0
  %t1 = icmp eq i8* %escape, %s0
  br i1 %t1, label %then0, label %merge1
then0:
  %s2 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.2, i32 0, i32 0
  ret i8* %s2
merge1:
  %s3 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.3, i32 0, i32 0
  %t4 = icmp eq i8* %escape, %s3
  br i1 %t4, label %then2, label %merge3
then2:
  %s5 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.5, i32 0, i32 0
  ret i8* %s5
merge3:
  %s6 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.6, i32 0, i32 0
  %t7 = icmp eq i8* %escape, %s6
  br i1 %t7, label %then4, label %merge5
then4:
  %s8 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.8, i32 0, i32 0
  ret i8* %s8
merge5:
  %s9 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.9, i32 0, i32 0
  %t10 = icmp eq i8* %escape, %s9
  br i1 %t10, label %then6, label %merge7
then6:
  %s11 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.11, i32 0, i32 0
  ret i8* %s11
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
  %l0 = alloca i8*
  %l1 = alloca i64
  %l2 = alloca i8
  %s0 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l0
  store i64 0, i64* %l1
  %t1 = load i8*, i8** %l0
  %t2 = load i64, i64* %l1
  br label %loop.header0
loop.header0:
  %t12 = phi i64 [ %t2, %entry ], [ %t11, %loop.latch2 ]
  store i64 %t12, i64* %l1
  br label %loop.body1
loop.body1:
  %t3 = load i64, i64* %l1
  %t4 = load i64, i64* %l1
  %t5 = getelementptr i8, i8* %value, i64 %t4
  %t6 = load i8, i8* %t5
  store i8 %t6, i8* %l2
  %t7 = load i8, i8* %l2
  %s8 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.8, i32 0, i32 0
  %t9 = load i64, i64* %l1
  %t10 = add i64 %t9, 1
  store i64 %t10, i64* %l1
  br label %loop.latch2
loop.latch2:
  %t11 = load i64, i64* %l1
  br label %loop.header0
afterloop3:
  %t13 = load i8*, i8** %l0
  %s14 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.14, i32 0, i32 0
  %t15 = add i8* %t13, %s14
  store i8* %t15, i8** %l0
  %t16 = load i8*, i8** %l0
  ret i8* %t16
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
  %t16 = phi double [ %t1, %entry ], [ %t15, %loop.latch2 ]
  store double %t16, double* %l0
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  %t3 = load double, double* %l0
  %t4 = getelementptr i8, i8* %text, i64 %t3
  %t5 = load i8, i8* %t4
  store i8 %t5, i8* %l1
  %t6 = load i8, i8* %l1
  %s7 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.7, i32 0, i32 0
  %t8 = load i8, i8* %l1
  %t9 = call i1 @is_identifier_char(i8* null)
  %t10 = load double, double* %l0
  %t11 = load i8, i8* %l1
  br i1 %t9, label %then4, label %merge5
then4:
  %t12 = load double, double* %l0
  %t13 = sitofp i64 1 to double
  %t14 = fadd double %t12, %t13
  store double %t14, double* %l0
  br label %loop.latch2
merge5:
  ret i1 0
loop.latch2:
  %t15 = load double, double* %l0
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
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca double
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
  %t29 = call double @substring(i8* %t24, double %t25, double %t28)
  store double %t29, double* %l4
  %t30 = load double, double* %l4
  %t31 = sitofp i64 1 to double
  %t32 = fadd double %depth, %t31
  %t33 = call double @lower_array_literal_expression(i8* null, double %t32)
  store double %t33, double* %l5
  %t34 = load double, double* %l5
  %t35 = load i8*, i8** %l0
  %t36 = load double, double* %l2
  %t37 = call double @substring(i8* %t35, i64 0, double %t36)
  store double %t37, double* %l6
  %t38 = load i8*, i8** %l0
  %t39 = load double, double* %l3
  %t40 = sitofp i64 1 to double
  %t41 = fadd double %t39, %t40
  %t42 = load i8*, i8** %l0
  store double 0.0, double* %l7
  %t43 = load double, double* %l6
  %t44 = load double, double* %l5
  %t45 = fadd double %t43, %t44
  %t46 = load double, double* %l7
  %t47 = fadd double %t45, %t46
  store i8* null, i8** %l0
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
  %l7 = alloca double
  %l8 = alloca double
  %l9 = alloca double
  %l10 = alloca double
  %l11 = alloca double
  %l12 = alloca double
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
  %t25 = call i1 @is_whitespace_char(i8* null)
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
  %t64 = phi double [ %t41, %loop.body1 ], [ %t63, %loop.latch16 ]
  store double %t64, double* %l5
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
  %s51 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.51, i32 0, i32 0
  %t52 = load double, double* %l6
  %t53 = call i1 @is_identifier_char(i8* null)
  %t54 = load i8*, i8** %l0
  %t55 = load double, double* %l1
  %t56 = load double, double* %l2
  %t57 = load double, double* %l3
  %t58 = load double, double* %l5
  %t59 = load double, double* %l6
  br i1 %t53, label %then20, label %merge21
then20:
  %t60 = load double, double* %l5
  %t61 = sitofp i64 1 to double
  %t62 = fsub double %t60, %t61
  store double %t62, double* %l5
  br label %loop.latch16
merge21:
  br label %afterloop17
loop.latch16:
  %t63 = load double, double* %l5
  br label %loop.header14
afterloop17:
  %t65 = load double, double* %l5
  %t66 = load double, double* %l3
  %t67 = fcmp oeq double %t65, %t66
  %t68 = load i8*, i8** %l0
  %t69 = load double, double* %l1
  %t70 = load double, double* %l2
  %t71 = load double, double* %l3
  %t72 = load double, double* %l5
  br i1 %t67, label %then22, label %merge23
then22:
  %t73 = load double, double* %l2
  %t74 = sitofp i64 1 to double
  %t75 = fadd double %t73, %t74
  store double %t75, double* %l1
  br label %loop.latch2
merge23:
  %t76 = load i8*, i8** %l0
  %t77 = load double, double* %l5
  %t78 = load double, double* %l3
  %t79 = call double @substring(i8* %t76, double %t77, double %t78)
  store double %t79, double* %l7
  %t80 = load double, double* %l7
  %t81 = call i1 @is_struct_literal_type_candidate(i8* null)
  %t82 = xor i1 %t81, 1
  %t83 = load i8*, i8** %l0
  %t84 = load double, double* %l1
  %t85 = load double, double* %l2
  %t86 = load double, double* %l3
  %t87 = load double, double* %l5
  %t88 = load double, double* %l7
  br i1 %t82, label %then24, label %merge25
then24:
  %t89 = load double, double* %l2
  %t90 = sitofp i64 1 to double
  %t91 = fadd double %t89, %t90
  store double %t91, double* %l1
  br label %loop.latch2
merge25:
  %t92 = load double, double* %l5
  %t93 = sitofp i64 0 to double
  %t94 = fcmp ogt double %t92, %t93
  %t95 = load i8*, i8** %l0
  %t96 = load double, double* %l1
  %t97 = load double, double* %l2
  %t98 = load double, double* %l3
  %t99 = load double, double* %l5
  %t100 = load double, double* %l7
  br i1 %t94, label %then26, label %merge27
then26:
  store double 0.0, double* %l8
  %t102 = load double, double* %l8
  %t103 = call i1 @is_identifier_char(i8* null)
  br label %logical_or_entry_101

logical_or_entry_101:
  br i1 %t103, label %logical_or_merge_101, label %logical_or_right_101

logical_or_right_101:
  %t104 = load double, double* %l8
  %s105 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.105, i32 0, i32 0
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
  %t117 = load double, double* %l7
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
  %t124 = call double @substring(i8* %t119, double %t120, double %t123)
  store double %t124, double* %l10
  %t125 = load double, double* %l10
  %t126 = sitofp i64 1 to double
  %t127 = fadd double %depth, %t126
  %t128 = call double @lower_struct_literal_expression(i8* null, double %t127)
  store double %t128, double* %l11
  %t129 = load double, double* %l11
  %t130 = load i8*, i8** %l0
  %t131 = load double, double* %l5
  %t132 = call double @substring(i8* %t130, i64 0, double %t131)
  store double %t132, double* %l12
  %t133 = load i8*, i8** %l0
  %t134 = load double, double* %l9
  %t135 = sitofp i64 1 to double
  %t136 = fadd double %t134, %t135
  %t137 = load i8*, i8** %l0
  store double 0.0, double* %l13
  %t138 = load double, double* %l12
  %t139 = load double, double* %l11
  %t140 = fadd double %t138, %t139
  %t141 = load double, double* %l13
  %t142 = fadd double %t140, %t141
  store i8* null, i8** %l0
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

define %StructLiteralCapture @capture_struct_literal_expression(i8* %initial, { i8**, i64 }* %instructions, double %start_index) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca i8*
  %l6 = alloca double
  %l7 = alloca i8*
  %t0 = call i8* @trim_text(i8* %initial)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %s2 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.2, i32 0, i32 0
  %t3 = call i1 @ends_with(i8* %t1, i8* %s2)
  %t4 = xor i1 %t3, 1
  %t5 = load i8*, i8** %l0
  br i1 %t4, label %then0, label %merge1
then0:
  %t6 = load i8*, i8** %l0
  %t7 = insertvalue %StructLiteralCapture undef, i8* %t6, 0
  %t8 = sitofp i64 0 to double
  %t9 = insertvalue %StructLiteralCapture %t7, double %t8, 1
  %t10 = insertvalue %StructLiteralCapture %t9, i1 0, 2
  ret %StructLiteralCapture %t10
merge1:
  %t11 = load i8*, i8** %l0
  store i8* %t11, i8** %l1
  store double %start_index, double* %l2
  %t12 = sitofp i64 0 to double
  store double %t12, double* %l3
  %t13 = load i8*, i8** %l0
  %t14 = call double @compute_brace_balance(i8* %t13)
  store double %t14, double* %l4
  %t15 = load double, double* %l4
  %t16 = sitofp i64 0 to double
  %t17 = fcmp ole double %t15, %t16
  %t18 = load i8*, i8** %l0
  %t19 = load i8*, i8** %l1
  %t20 = load double, double* %l2
  %t21 = load double, double* %l3
  %t22 = load double, double* %l4
  br i1 %t17, label %then2, label %merge3
then2:
  %t23 = load i8*, i8** %l0
  %t24 = insertvalue %StructLiteralCapture undef, i8* %t23, 0
  %t25 = sitofp i64 0 to double
  %t26 = insertvalue %StructLiteralCapture %t24, double %t25, 1
  %t27 = insertvalue %StructLiteralCapture %t26, i1 0, 2
  ret %StructLiteralCapture %t27
merge3:
  %t28 = load i8*, i8** %l0
  %t29 = load i8*, i8** %l1
  %t30 = load double, double* %l2
  %t31 = load double, double* %l3
  %t32 = load double, double* %l4
  br label %loop.header4
loop.header4:
  %t76 = phi double [ %t32, %entry ], [ %t73, %loop.latch6 ]
  %t77 = phi double [ %t31, %entry ], [ %t74, %loop.latch6 ]
  %t78 = phi double [ %t30, %entry ], [ %t75, %loop.latch6 ]
  store double %t76, double* %l4
  store double %t77, double* %l3
  store double %t78, double* %l2
  br label %loop.body5
loop.body5:
  %t33 = load double, double* %l2
  %t34 = load { i8**, i64 }, { i8**, i64 }* %instructions
  %t35 = extractvalue { i8**, i64 } %t34, 1
  %t36 = sitofp i64 %t35 to double
  %t37 = fcmp oge double %t33, %t36
  %t38 = load i8*, i8** %l0
  %t39 = load i8*, i8** %l1
  %t40 = load double, double* %l2
  %t41 = load double, double* %l3
  %t42 = load double, double* %l4
  br i1 %t37, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t43 = load double, double* %l2
  %t44 = load { i8**, i64 }, { i8**, i64 }* %instructions
  %t45 = extractvalue { i8**, i64 } %t44, 0
  %t46 = extractvalue { i8**, i64 } %t44, 1
  %t47 = icmp uge i64 %t43, %t46
  ; bounds check: %t47 (if true, out of bounds)
  %t48 = getelementptr i8*, i8** %t45, i64 %t43
  %t49 = load i8*, i8** %t48
  store i8* %t49, i8** %l5
  %t50 = load i8*, i8** %l5
  %t51 = load i8*, i8** %l5
  store double 0.0, double* %l6
  %t52 = load double, double* %l6
  %t53 = load double, double* %l4
  %t54 = load double, double* %l6
  %t55 = call double @compute_brace_balance(i8* null)
  %t56 = fadd double %t53, %t55
  store double %t56, double* %l4
  %t57 = load double, double* %l3
  %t58 = sitofp i64 1 to double
  %t59 = fadd double %t57, %t58
  store double %t59, double* %l3
  %t60 = load double, double* %l2
  %t61 = sitofp i64 1 to double
  %t62 = fadd double %t60, %t61
  store double %t62, double* %l2
  %t63 = load double, double* %l4
  %t64 = sitofp i64 0 to double
  %t65 = fcmp ole double %t63, %t64
  %t66 = load i8*, i8** %l0
  %t67 = load i8*, i8** %l1
  %t68 = load double, double* %l2
  %t69 = load double, double* %l3
  %t70 = load double, double* %l4
  %t71 = load i8*, i8** %l5
  %t72 = load double, double* %l6
  br i1 %t65, label %then10, label %merge11
then10:
  br label %afterloop7
merge11:
  br label %loop.latch6
loop.latch6:
  %t73 = load double, double* %l4
  %t74 = load double, double* %l3
  %t75 = load double, double* %l2
  br label %loop.header4
afterloop7:
  %t79 = load double, double* %l4
  %t80 = sitofp i64 0 to double
  %t81 = fcmp une double %t79, %t80
  %t82 = load i8*, i8** %l0
  %t83 = load i8*, i8** %l1
  %t84 = load double, double* %l2
  %t85 = load double, double* %l3
  %t86 = load double, double* %l4
  br i1 %t81, label %then12, label %merge13
then12:
  %t87 = load i8*, i8** %l0
  %t88 = insertvalue %StructLiteralCapture undef, i8* %t87, 0
  %t89 = sitofp i64 0 to double
  %t90 = insertvalue %StructLiteralCapture %t88, double %t89, 1
  %t91 = insertvalue %StructLiteralCapture %t90, i1 0, 2
  ret %StructLiteralCapture %t91
merge13:
  %t92 = load double, double* %l3
  %t93 = sitofp i64 0 to double
  %t94 = fcmp oeq double %t92, %t93
  %t95 = load i8*, i8** %l0
  %t96 = load i8*, i8** %l1
  %t97 = load double, double* %l2
  %t98 = load double, double* %l3
  %t99 = load double, double* %l4
  br i1 %t94, label %then14, label %merge15
then14:
  %t100 = load i8*, i8** %l0
  %t101 = insertvalue %StructLiteralCapture undef, i8* %t100, 0
  %t102 = sitofp i64 0 to double
  %t103 = insertvalue %StructLiteralCapture %t101, double %t102, 1
  %t104 = insertvalue %StructLiteralCapture %t103, i1 0, 2
  ret %StructLiteralCapture %t104
merge15:
  %t105 = load i8*, i8** %l1
  %t106 = call i8* @trim_text(i8* %t105)
  %t107 = call i8* @trim_trailing_delimiters(i8* %t106)
  store i8* %t107, i8** %l7
  %t108 = load i8*, i8** %l7
  %s109 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.109, i32 0, i32 0
  %t110 = call i1 @ends_with(i8* %t108, i8* %s109)
  %t111 = xor i1 %t110, 1
  %t112 = load i8*, i8** %l0
  %t113 = load i8*, i8** %l1
  %t114 = load double, double* %l2
  %t115 = load double, double* %l3
  %t116 = load double, double* %l4
  %t117 = load i8*, i8** %l7
  br i1 %t111, label %then16, label %merge17
then16:
  %t118 = load i8*, i8** %l0
  %t119 = insertvalue %StructLiteralCapture undef, i8* %t118, 0
  %t120 = sitofp i64 0 to double
  %t121 = insertvalue %StructLiteralCapture %t119, double %t120, 1
  %t122 = insertvalue %StructLiteralCapture %t121, i1 0, 2
  ret %StructLiteralCapture %t122
merge17:
  %t123 = load i8*, i8** %l7
  %t124 = insertvalue %StructLiteralCapture undef, i8* %t123, 0
  %t125 = load double, double* %l3
  %t126 = insertvalue %StructLiteralCapture %t124, double %t125, 1
  %t127 = insertvalue %StructLiteralCapture %t126, i1 1, 2
  ret %StructLiteralCapture %t127
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
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = load i8*, i8** %l0
  %t3 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t24 = phi i8* [ %t2, %entry ], [ %t22, %loop.latch2 ]
  %t25 = phi double [ %t3, %entry ], [ %t23, %loop.latch2 ]
  store i8* %t24, i8** %l0
  store double %t25, double* %l1
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  %t5 = load double, double* %l1
  %t6 = getelementptr i8, i8* %expression, i64 %t5
  %t7 = load i8, i8* %t6
  store i8 %t7, i8* %l2
  %t9 = load i8, i8* %l2
  %s10 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.10, i32 0, i32 0
  %t11 = load i8, i8* %l2
  %s12 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.12, i32 0, i32 0
  %t13 = load i8, i8* %l2
  %s14 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.14, i32 0, i32 0
  %t15 = load i8, i8* %l2
  %s16 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.16, i32 0, i32 0
  %t17 = load i8*, i8** %l0
  %t18 = load i8, i8* %l2
  %t19 = load double, double* %l1
  %t20 = sitofp i64 1 to double
  %t21 = fadd double %t19, %t20
  store double %t21, double* %l1
  br label %loop.latch2
loop.latch2:
  %t22 = load i8*, i8** %l0
  %t23 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t26 = load i8*, i8** %l0
  ret i8* %t26
}

define i8* @rewrite_literal_tokens(i8* %expression) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8
  %l3 = alloca double
  %l4 = alloca i8
  %l5 = alloca double
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = load i8*, i8** %l0
  %t3 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t50 = phi double [ %t3, %entry ], [ %t48, %loop.latch2 ]
  %t51 = phi i8* [ %t2, %entry ], [ %t49, %loop.latch2 ]
  store double %t50, double* %l1
  store i8* %t51, i8** %l0
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  %t5 = load double, double* %l1
  %t6 = getelementptr i8, i8* %expression, i64 %t5
  %t7 = load i8, i8* %t6
  store i8 %t7, i8* %l2
  %t9 = load i8, i8* %l2
  %s10 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.10, i32 0, i32 0
  %t11 = load i8, i8* %l2
  %t12 = call i1 @is_identifier_char(i8* null)
  %t13 = load i8*, i8** %l0
  %t14 = load double, double* %l1
  %t15 = load i8, i8* %l2
  br i1 %t12, label %then4, label %merge5
then4:
  %t16 = load double, double* %l1
  store double %t16, double* %l3
  %t17 = load i8*, i8** %l0
  %t18 = load double, double* %l1
  %t19 = load i8, i8* %l2
  %t20 = load double, double* %l3
  br label %loop.header6
loop.header6:
  %t37 = phi double [ %t18, %then4 ], [ %t36, %loop.latch8 ]
  store double %t37, double* %l1
  br label %loop.body7
loop.body7:
  %t21 = load double, double* %l1
  %t22 = sitofp i64 1 to double
  %t23 = fadd double %t21, %t22
  store double %t23, double* %l1
  %t24 = load double, double* %l1
  %t25 = load double, double* %l1
  %t26 = getelementptr i8, i8* %expression, i64 %t25
  %t27 = load i8, i8* %t26
  store i8 %t27, i8* %l4
  %t28 = load i8, i8* %l4
  %t29 = call i1 @is_identifier_char(i8* null)
  %t30 = xor i1 %t29, 1
  %t31 = load i8*, i8** %l0
  %t32 = load double, double* %l1
  %t33 = load i8, i8* %l2
  %t34 = load double, double* %l3
  %t35 = load i8, i8* %l4
  br i1 %t30, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  br label %loop.latch8
loop.latch8:
  %t36 = load double, double* %l1
  br label %loop.header6
afterloop9:
  %t38 = load double, double* %l3
  %t39 = load double, double* %l1
  %t40 = call double @substring(i8* %expression, double %t38, double %t39)
  store double %t40, double* %l5
  %t41 = load double, double* %l5
  %s42 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.42, i32 0, i32 0
  br label %loop.latch2
merge5:
  %t43 = load i8*, i8** %l0
  %t44 = load i8, i8* %l2
  %t45 = load double, double* %l1
  %t46 = sitofp i64 1 to double
  %t47 = fadd double %t45, %t46
  store double %t47, double* %l1
  br label %loop.latch2
loop.latch2:
  %t48 = load double, double* %l1
  %t49 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t52 = load i8*, i8** %l0
  ret i8* %t52
}

define i8* @rewrite_push_calls(i8* %expression) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca i8
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
  %t24 = phi i8* [ %t6, %entry ], [ %t22, %loop.latch2 ]
  %t25 = phi double [ %t7, %entry ], [ %t23, %loop.latch2 ]
  store i8* %t24, i8** %l2
  store double %t25, double* %l3
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l3
  %t9 = load double, double* %l3
  %t10 = getelementptr i8, i8* %expression, i64 %t9
  %t11 = load i8, i8* %t10
  store i8 %t11, i8* %l4
  %t13 = load i8, i8* %l4
  %s14 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.14, i32 0, i32 0
  %t15 = load double, double* %l3
  %t16 = load i8*, i8** %l0
  %t17 = load i8*, i8** %l2
  %t18 = load i8, i8* %l4
  %t19 = load double, double* %l3
  %t20 = sitofp i64 1 to double
  %t21 = fadd double %t19, %t20
  store double %t21, double* %l3
  br label %loop.latch2
loop.latch2:
  %t22 = load i8*, i8** %l2
  %t23 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t26 = load i8*, i8** %l2
  ret i8* %t26
}

define i8* @rewrite_concat_calls(i8* %expression) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca %ExtractedSpan
  %l3 = alloca double
  %l4 = alloca %ExtractedSpan
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca i8*
  %l8 = alloca i8*
  %l9 = alloca double
  store i8* %expression, i8** %l0
  %t0 = load i8*, i8** %l0
  br label %loop.header0
loop.header0:
  %t52 = phi i8* [ %t0, %entry ], [ %t51, %loop.latch2 ]
  store i8* %t52, i8** %l0
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
  %t35 = call double @substring(i8* %t32, i64 0, double %t34)
  store double %t35, double* %l5
  %t36 = load i8*, i8** %l0
  %t37 = load %ExtractedSpan, %ExtractedSpan* %l4
  %t38 = extractvalue %ExtractedSpan %t37, 2
  %t39 = load i8*, i8** %l0
  store double 0.0, double* %l6
  %t40 = load %ExtractedSpan, %ExtractedSpan* %l2
  %t41 = extractvalue %ExtractedSpan %t40, 0
  %t42 = call i8* @trim_text(i8* %t41)
  store i8* %t42, i8** %l7
  %t43 = load %ExtractedSpan, %ExtractedSpan* %l4
  %t44 = extractvalue %ExtractedSpan %t43, 0
  %t45 = call i8* @trim_text(i8* %t44)
  store i8* %t45, i8** %l8
  store double 0.0, double* %l9
  %t46 = load double, double* %l5
  %t47 = load double, double* %l9
  %t48 = fadd double %t46, %t47
  %t49 = load double, double* %l6
  %t50 = fadd double %t48, %t49
  store i8* null, i8** %l0
  br label %loop.latch2
loop.latch2:
  %t51 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t53 = load i8*, i8** %l0
  ret i8* %t53
}

define i8* @rewrite_length_accesses(i8* %expression) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca %ExtractedSpan
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca i8*
  store i8* %expression, i8** %l0
  %t0 = load i8*, i8** %l0
  br label %loop.header0
loop.header0:
  %t34 = phi i8* [ %t0, %entry ], [ %t33, %loop.latch2 ]
  store i8* %t34, i8** %l0
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
  %t21 = call double @substring(i8* %t18, i64 0, double %t20)
  store double %t21, double* %l3
  %t22 = load i8*, i8** %l0
  %t23 = load double, double* %l1
  %t24 = sitofp i64 7 to double
  %t25 = fadd double %t23, %t24
  %t26 = load i8*, i8** %l0
  store double 0.0, double* %l4
  %t27 = load %ExtractedSpan, %ExtractedSpan* %l2
  %t28 = extractvalue %ExtractedSpan %t27, 0
  %t29 = call i8* @trim_text(i8* %t28)
  store i8* %t29, i8** %l5
  %t30 = load i8*, i8** %l5
  %t31 = load double, double* %l3
  %s32 = getelementptr inbounds [25 x i8], [25 x i8]* @.str.32, i32 0, i32 0
  br label %loop.latch2
loop.latch2:
  %t33 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t35 = load i8*, i8** %l0
  ret i8* %t35
}

define %ExtractedSpan @extract_object_span(i8* %text, double %dot_index) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca i8
  %l4 = alloca double
  %l5 = alloca double
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
  %t54 = phi double [ %t13, %entry ], [ %t53, %loop.latch4 ]
  store double %t54, double* %l0
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
  %s26 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.26, i32 0, i32 0
  %t27 = load i8, i8* %l3
  %s28 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.28, i32 0, i32 0
  %t29 = load i8, i8* %l3
  %s30 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.30, i32 0, i32 0
  %t31 = load i8, i8* %l3
  %s32 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.32, i32 0, i32 0
  %t34 = load double, double* %l1
  %t35 = sitofp i64 0 to double
  %t36 = fcmp ogt double %t34, %t35
  br label %logical_or_entry_33

logical_or_entry_33:
  br i1 %t36, label %logical_or_merge_33, label %logical_or_right_33

logical_or_right_33:
  %t37 = load double, double* %l2
  %t38 = sitofp i64 0 to double
  %t39 = fcmp ogt double %t37, %t38
  br label %logical_or_right_end_33

logical_or_right_end_33:
  br label %logical_or_merge_33

logical_or_merge_33:
  %t40 = phi i1 [ true, %logical_or_entry_33 ], [ %t39, %logical_or_right_end_33 ]
  %t41 = load double, double* %l0
  %t42 = load double, double* %l1
  %t43 = load double, double* %l2
  %t44 = load i8, i8* %l3
  br i1 %t40, label %then8, label %merge9
then8:
  %t45 = load double, double* %l0
  %t46 = sitofp i64 1 to double
  %t47 = fsub double %t45, %t46
  store double %t47, double* %l0
  br label %loop.latch4
merge9:
  %t49 = load i8, i8* %l3
  %t50 = call i1 @is_identifier_char(i8* null)
  br label %logical_or_entry_48

logical_or_entry_48:
  br i1 %t50, label %logical_or_merge_48, label %logical_or_right_48

logical_or_right_48:
  %t51 = load i8, i8* %l3
  %s52 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.52, i32 0, i32 0
  br label %afterloop5
loop.latch4:
  %t53 = load double, double* %l0
  br label %loop.header2
afterloop5:
  %t55 = load double, double* %l0
  %t56 = sitofp i64 1 to double
  %t57 = fadd double %t55, %t56
  store double %t57, double* %l4
  %t58 = load double, double* %l4
  %t59 = fcmp oge double %t58, %dot_index
  %t60 = load double, double* %l0
  %t61 = load double, double* %l1
  %t62 = load double, double* %l2
  %t63 = load double, double* %l4
  br i1 %t59, label %then10, label %merge11
then10:
  %s64 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.64, i32 0, i32 0
  %t65 = insertvalue %ExtractedSpan undef, i8* %s64, 0
  %t66 = load double, double* %l4
  %t67 = insertvalue %ExtractedSpan %t65, double %t66, 1
  %t68 = insertvalue %ExtractedSpan %t67, double %dot_index, 2
  %t69 = insertvalue %ExtractedSpan %t68, i1 0, 3
  ret %ExtractedSpan %t69
merge11:
  %t70 = load double, double* %l4
  %t71 = call double @substring(i8* %text, double %t70, double %dot_index)
  store double %t71, double* %l5
  %t72 = load double, double* %l5
  %t73 = insertvalue %ExtractedSpan undef, i8* null, 0
  %t74 = load double, double* %l4
  %t75 = insertvalue %ExtractedSpan %t73, double %t74, 1
  %t76 = insertvalue %ExtractedSpan %t75, double %dot_index, 2
  %t77 = insertvalue %ExtractedSpan %t76, i1 1, 3
  ret %ExtractedSpan %t77
}

define %ExtractedSpan @extract_parenthesized_span(i8* %text, double %open_index) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i8
  %t0 = getelementptr i8, i8* %text, i64 %open_index
  %t1 = load i8, i8* %t0
  %s2 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.2, i32 0, i32 0
  %t3 = sitofp i64 1 to double
  %t4 = fadd double %open_index, %t3
  store double %t4, double* %l0
  %t5 = sitofp i64 1 to double
  store double %t5, double* %l1
  %t6 = load double, double* %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t18 = phi double [ %t6, %entry ], [ %t17, %loop.latch2 ]
  store double %t18, double* %l0
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l0
  %t9 = load double, double* %l0
  %t10 = getelementptr i8, i8* %text, i64 %t9
  %t11 = load i8, i8* %t10
  store i8 %t11, i8* %l2
  %t12 = load i8, i8* %l2
  %s13 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.13, i32 0, i32 0
  %t14 = load double, double* %l0
  %t15 = sitofp i64 1 to double
  %t16 = fadd double %t14, %t15
  store double %t16, double* %l0
  br label %loop.latch2
loop.latch2:
  %t17 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %s19 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.19, i32 0, i32 0
  %t20 = insertvalue %ExtractedSpan undef, i8* %s19, 0
  %t21 = insertvalue %ExtractedSpan %t20, double %open_index, 1
  %t22 = insertvalue %ExtractedSpan %t21, double %open_index, 2
  %t23 = insertvalue %ExtractedSpan %t22, i1 0, 3
  ret %ExtractedSpan %t23
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
  %t25 = phi double [ %t5, %entry ], [ %t24, %loop.latch2 ]
  store double %t25, double* %l1
  br label %loop.body1
loop.body1:
  %t6 = load double, double* %l1
  %t7 = load double, double* %l1
  %t8 = getelementptr i8, i8* %text, i64 %t7
  %t9 = load i8, i8* %t8
  store i8 %t9, i8* %l2
  %t10 = load i8, i8* %l2
  %s11 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.11, i32 0, i32 0
  %t12 = load i8, i8* %l2
  %t13 = load i8, i8* %l0
  %t14 = icmp eq i8 %t12, %t13
  %t15 = load i8, i8* %l0
  %t16 = load double, double* %l1
  %t17 = load i8, i8* %l2
  br i1 %t14, label %then4, label %merge5
then4:
  %t18 = load double, double* %l1
  %t19 = sitofp i64 1 to double
  %t20 = fadd double %t18, %t19
  store double %t20, double* %l1
  br label %afterloop3
merge5:
  %t21 = load double, double* %l1
  %t22 = sitofp i64 1 to double
  %t23 = fadd double %t21, %t22
  store double %t23, double* %l1
  br label %loop.latch2
loop.latch2:
  %t24 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t26 = load double, double* %l1
  ret double %t26
}

define %ExpressionContinuationCapture @capture_expression_continuation(i8* %initial, { i8**, i64 }* %instructions, double %start_index) {
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
  %t217 = phi i1 [ %t30, %entry ], [ %t210, %loop.latch2 ]
  %t218 = phi i8* [ %t27, %entry ], [ %t211, %loop.latch2 ]
  %t219 = phi double [ %t24, %entry ], [ %t212, %loop.latch2 ]
  %t220 = phi double [ %t25, %entry ], [ %t213, %loop.latch2 ]
  %t221 = phi double [ %t26, %entry ], [ %t214, %loop.latch2 ]
  %t222 = phi double [ %t29, %entry ], [ %t215, %loop.latch2 ]
  %t223 = phi double [ %t28, %entry ], [ %t216, %loop.latch2 ]
  store i1 %t217, i1* %l7
  store i8* %t218, i8** %l4
  store double %t219, double* %l1
  store double %t220, double* %l2
  store double %t221, double* %l3
  store double %t222, double* %l6
  store double %t223, double* %l5
  br label %loop.body1
loop.body1:
  %t31 = load double, double* %l5
  %t32 = load { i8**, i64 }, { i8**, i64 }* %instructions
  %t33 = extractvalue { i8**, i64 } %t32, 1
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
  %t45 = load { i8**, i64 }, { i8**, i64 }* %instructions
  %t46 = extractvalue { i8**, i64 } %t45, 0
  %t47 = extractvalue { i8**, i64 } %t45, 1
  %t48 = icmp uge i64 %t44, %t47
  ; bounds check: %t48 (if true, out of bounds)
  %t49 = getelementptr i8*, i8** %t46, i64 %t44
  %t50 = load i8*, i8** %t49
  %t51 = call double @continuation_segment_text(i8* %t50)
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
  %s83 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.83, i32 0, i32 0
  %t84 = add i8* %t82, %s83
  %t85 = load i8*, i8** %l9
  %t86 = add i8* %t84, %t85
  store i8* %t86, i8** %l4
  %t87 = load double, double* %l1
  %t88 = load i8*, i8** %l9
  %t89 = call double @compute_parenthesis_balance(i8* %t88)
  %t90 = fadd double %t87, %t89
  store double %t90, double* %l1
  %t91 = load double, double* %l2
  %t92 = load i8*, i8** %l9
  %t93 = call double @compute_brace_balance(i8* %t92)
  %t94 = fadd double %t91, %t93
  store double %t94, double* %l2
  %t95 = load double, double* %l3
  %t96 = load i8*, i8** %l9
  %t97 = call double @compute_bracket_balance(i8* %t96)
  %t98 = fadd double %t95, %t97
  store double %t98, double* %l3
  %t99 = load double, double* %l6
  %t100 = sitofp i64 1 to double
  %t101 = fadd double %t99, %t100
  store double %t101, double* %l6
  %t102 = load double, double* %l5
  %t103 = sitofp i64 1 to double
  %t104 = fadd double %t102, %t103
  store double %t104, double* %l5
  %t107 = load double, double* %l1
  %t108 = sitofp i64 0 to double
  %t109 = fcmp ole double %t107, %t108
  br label %logical_and_entry_106

logical_and_entry_106:
  br i1 %t109, label %logical_and_right_106, label %logical_and_merge_106

logical_and_right_106:
  %t110 = load double, double* %l2
  %t111 = sitofp i64 0 to double
  %t112 = fcmp ole double %t110, %t111
  br label %logical_and_right_end_106

logical_and_right_end_106:
  br label %logical_and_merge_106

logical_and_merge_106:
  %t113 = phi i1 [ false, %logical_and_entry_106 ], [ %t112, %logical_and_right_end_106 ]
  br label %logical_and_entry_105

logical_and_entry_105:
  br i1 %t113, label %logical_and_right_105, label %logical_and_merge_105

logical_and_right_105:
  %t114 = load double, double* %l3
  %t115 = sitofp i64 0 to double
  %t116 = fcmp ole double %t114, %t115
  br label %logical_and_right_end_105

logical_and_right_end_105:
  br label %logical_and_merge_105

logical_and_merge_105:
  %t117 = phi i1 [ false, %logical_and_entry_105 ], [ %t116, %logical_and_right_end_105 ]
  %t118 = load i8*, i8** %l0
  %t119 = load double, double* %l1
  %t120 = load double, double* %l2
  %t121 = load double, double* %l3
  %t122 = load i8*, i8** %l4
  %t123 = load double, double* %l5
  %t124 = load double, double* %l6
  %t125 = load i1, i1* %l7
  %t126 = load double, double* %l8
  %t127 = load i8*, i8** %l9
  br i1 %t117, label %then10, label %merge11
then10:
  store i1 1, i1* %l10
  %t128 = load double, double* %l5
  store double %t128, double* %l11
  %t129 = load i8*, i8** %l0
  %t130 = load double, double* %l1
  %t131 = load double, double* %l2
  %t132 = load double, double* %l3
  %t133 = load i8*, i8** %l4
  %t134 = load double, double* %l5
  %t135 = load double, double* %l6
  %t136 = load i1, i1* %l7
  %t137 = load double, double* %l8
  %t138 = load i8*, i8** %l9
  %t139 = load i1, i1* %l10
  %t140 = load double, double* %l11
  br label %loop.header12
loop.header12:
  %t188 = phi i1 [ %t139, %then10 ], [ %t187, %loop.latch14 ]
  store i1 %t188, i1* %l10
  br label %loop.body13
loop.body13:
  %t141 = load double, double* %l11
  %t142 = load { i8**, i64 }, { i8**, i64 }* %instructions
  %t143 = extractvalue { i8**, i64 } %t142, 1
  %t144 = sitofp i64 %t143 to double
  %t145 = fcmp oge double %t141, %t144
  %t146 = load i8*, i8** %l0
  %t147 = load double, double* %l1
  %t148 = load double, double* %l2
  %t149 = load double, double* %l3
  %t150 = load i8*, i8** %l4
  %t151 = load double, double* %l5
  %t152 = load double, double* %l6
  %t153 = load i1, i1* %l7
  %t154 = load double, double* %l8
  %t155 = load i8*, i8** %l9
  %t156 = load i1, i1* %l10
  %t157 = load double, double* %l11
  br i1 %t145, label %then16, label %merge17
then16:
  br label %afterloop15
merge17:
  %t158 = load double, double* %l11
  %t159 = load { i8**, i64 }, { i8**, i64 }* %instructions
  %t160 = extractvalue { i8**, i64 } %t159, 0
  %t161 = extractvalue { i8**, i64 } %t159, 1
  %t162 = icmp uge i64 %t158, %t161
  ; bounds check: %t162 (if true, out of bounds)
  %t163 = getelementptr i8*, i8** %t160, i64 %t158
  %t164 = load i8*, i8** %t163
  %t165 = call double @continuation_segment_text(i8* %t164)
  store double %t165, double* %l12
  %t166 = load double, double* %l12
  %t167 = load double, double* %l12
  %t168 = call i8* @trim_text(i8* null)
  store i8* %t168, i8** %l13
  %t169 = load i8*, i8** %l13
  %t170 = load i8*, i8** %l13
  %t171 = call i1 @segment_signals_expression_continuation(i8* %t170)
  %t172 = load i8*, i8** %l0
  %t173 = load double, double* %l1
  %t174 = load double, double* %l2
  %t175 = load double, double* %l3
  %t176 = load i8*, i8** %l4
  %t177 = load double, double* %l5
  %t178 = load double, double* %l6
  %t179 = load i1, i1* %l7
  %t180 = load double, double* %l8
  %t181 = load i8*, i8** %l9
  %t182 = load i1, i1* %l10
  %t183 = load double, double* %l11
  %t184 = load double, double* %l12
  %t185 = load i8*, i8** %l13
  br i1 %t171, label %then18, label %merge19
then18:
  store i1 0, i1* %l10
  br label %merge19
merge19:
  %t186 = phi i1 [ 0, %then18 ], [ %t182, %loop.body13 ]
  store i1 %t186, i1* %l10
  br label %afterloop15
loop.latch14:
  %t187 = load i1, i1* %l10
  br label %loop.header12
afterloop15:
  %t189 = load i1, i1* %l10
  %t190 = load i8*, i8** %l0
  %t191 = load double, double* %l1
  %t192 = load double, double* %l2
  %t193 = load double, double* %l3
  %t194 = load i8*, i8** %l4
  %t195 = load double, double* %l5
  %t196 = load double, double* %l6
  %t197 = load i1, i1* %l7
  %t198 = load double, double* %l8
  %t199 = load i8*, i8** %l9
  %t200 = load i1, i1* %l10
  %t201 = load double, double* %l11
  br i1 %t189, label %then20, label %merge21
then20:
  %t202 = load i8*, i8** %l4
  %t203 = call i8* @trim_text(i8* %t202)
  %t204 = call i8* @trim_trailing_delimiters(i8* %t203)
  store i8* %t204, i8** %l14
  %t205 = load i8*, i8** %l14
  %t206 = insertvalue %ExpressionContinuationCapture undef, i8* %t205, 0
  %t207 = load double, double* %l6
  %t208 = insertvalue %ExpressionContinuationCapture %t206, double %t207, 1
  %t209 = insertvalue %ExpressionContinuationCapture %t208, i1 1, 2
  ret %ExpressionContinuationCapture %t209
merge21:
  br label %merge11
merge11:
  br label %loop.latch2
loop.latch2:
  %t210 = load i1, i1* %l7
  %t211 = load i8*, i8** %l4
  %t212 = load double, double* %l1
  %t213 = load double, double* %l2
  %t214 = load double, double* %l3
  %t215 = load double, double* %l6
  %t216 = load double, double* %l5
  br label %loop.header0
afterloop3:
  %t225 = load i1, i1* %l7
  br label %logical_or_entry_224

logical_or_entry_224:
  br i1 %t225, label %logical_or_merge_224, label %logical_or_right_224

logical_or_right_224:
  %t226 = load double, double* %l6
  %t227 = sitofp i64 0 to double
  %t228 = fcmp oeq double %t226, %t227
  br label %logical_or_right_end_224

logical_or_right_end_224:
  br label %logical_or_merge_224

logical_or_merge_224:
  %t229 = phi i1 [ true, %logical_or_entry_224 ], [ %t228, %logical_or_right_end_224 ]
  %t230 = xor i1 %t229, 1
  %t231 = load i8*, i8** %l0
  %t232 = load double, double* %l1
  %t233 = load double, double* %l2
  %t234 = load double, double* %l3
  %t235 = load i8*, i8** %l4
  %t236 = load double, double* %l5
  %t237 = load double, double* %l6
  %t238 = load i1, i1* %l7
  br i1 %t230, label %then22, label %merge23
then22:
  %t239 = load i8*, i8** %l0
  %t240 = insertvalue %ExpressionContinuationCapture undef, i8* %t239, 0
  %t241 = sitofp i64 0 to double
  %t242 = insertvalue %ExpressionContinuationCapture %t240, double %t241, 1
  %t243 = insertvalue %ExpressionContinuationCapture %t242, i1 0, 2
  ret %ExpressionContinuationCapture %t243
merge23:
  %t246 = load double, double* %l1
  %t247 = sitofp i64 0 to double
  %t248 = fcmp ole double %t246, %t247
  br label %logical_and_entry_245

logical_and_entry_245:
  br i1 %t248, label %logical_and_right_245, label %logical_and_merge_245

logical_and_right_245:
  %t249 = load double, double* %l2
  %t250 = sitofp i64 0 to double
  %t251 = fcmp ole double %t249, %t250
  br label %logical_and_right_end_245

logical_and_right_end_245:
  br label %logical_and_merge_245

logical_and_merge_245:
  %t252 = phi i1 [ false, %logical_and_entry_245 ], [ %t251, %logical_and_right_end_245 ]
  br label %logical_and_entry_244

logical_and_entry_244:
  br i1 %t252, label %logical_and_right_244, label %logical_and_merge_244

logical_and_right_244:
  %t253 = load double, double* %l3
  %t254 = sitofp i64 0 to double
  %t255 = fcmp ole double %t253, %t254
  br label %logical_and_right_end_244

logical_and_right_end_244:
  br label %logical_and_merge_244

logical_and_merge_244:
  %t256 = phi i1 [ false, %logical_and_entry_244 ], [ %t255, %logical_and_right_end_244 ]
  %t257 = load i8*, i8** %l0
  %t258 = load double, double* %l1
  %t259 = load double, double* %l2
  %t260 = load double, double* %l3
  %t261 = load i8*, i8** %l4
  %t262 = load double, double* %l5
  %t263 = load double, double* %l6
  %t264 = load i1, i1* %l7
  br i1 %t256, label %then24, label %merge25
then24:
  %t265 = load i8*, i8** %l4
  %t266 = call i8* @trim_text(i8* %t265)
  %t267 = call i8* @trim_trailing_delimiters(i8* %t266)
  store i8* %t267, i8** %l15
  %t268 = load i8*, i8** %l15
  %t269 = insertvalue %ExpressionContinuationCapture undef, i8* %t268, 0
  %t270 = load double, double* %l6
  %t271 = insertvalue %ExpressionContinuationCapture %t269, double %t270, 1
  %t272 = insertvalue %ExpressionContinuationCapture %t271, i1 1, 2
  ret %ExpressionContinuationCapture %t272
merge25:
  %t273 = load i8*, i8** %l0
  %t274 = insertvalue %ExpressionContinuationCapture undef, i8* %t273, 0
  %t275 = sitofp i64 0 to double
  %t276 = insertvalue %ExpressionContinuationCapture %t274, double %t275, 1
  %t277 = insertvalue %ExpressionContinuationCapture %t276, i1 0, 2
  ret %ExpressionContinuationCapture %t277
}

define i1 @segment_signals_expression_continuation(i8* %segment) {
entry:
  %l0 = alloca i8
  %t2 = getelementptr i8, i8* %segment, i64 0
  %t3 = load i8, i8* %t2
  store i8 %t3, i8* %l0
  %t6 = load i8, i8* %l0
  %s8 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.8, i32 0, i32 0
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
  %t14 = phi double [ %t3, %entry ], [ %t13, %loop.latch2 ]
  store double %t14, double* %l1
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  %t5 = load double, double* %l1
  %t6 = getelementptr i8, i8* %text, i64 %t5
  %t7 = load i8, i8* %t6
  store i8 %t7, i8* %l2
  %t8 = load i8, i8* %l2
  %s9 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.9, i32 0, i32 0
  %t10 = load double, double* %l1
  %t11 = sitofp i64 1 to double
  %t12 = fadd double %t10, %t11
  store double %t12, double* %l1
  br label %loop.latch2
loop.latch2:
  %t13 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t15 = load double, double* %l0
  ret double %t15
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
  %t13 = phi double [ %t3, %entry ], [ %t12, %loop.latch2 ]
  store double %t13, double* %l1
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  %t5 = load double, double* %l1
  %t6 = getelementptr i8, i8* %text, i64 %t5
  %t7 = load i8, i8* %t6
  store i8 %t7, i8* %l2
  %t8 = load i8, i8* %l2
  %t9 = load double, double* %l1
  %t10 = sitofp i64 1 to double
  %t11 = fadd double %t9, %t10
  store double %t11, double* %l1
  br label %loop.latch2
loop.latch2:
  %t12 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t14 = load double, double* %l0
  ret double %t14
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
  %t49 = phi i8* [ %t10, %entry ], [ %t47, %loop.latch2 ]
  %t50 = phi double [ %t12, %entry ], [ %t48, %loop.latch2 ]
  store i8* %t49, i8** %l1
  store double %t50, double* %l3
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
  %t29 = load i8, i8* %l6
  %s30 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.30, i32 0, i32 0
  %t31 = load double, double* %l3
  %t32 = sitofp i64 1 to double
  %t33 = fadd double %t31, %t32
  store double %t33, double* %l3
  br label %loop.latch2
merge5:
  %t35 = load i8, i8* %l6
  %s36 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.36, i32 0, i32 0
  %t39 = load i8, i8* %l6
  %s40 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.40, i32 0, i32 0
  %t42 = load i8, i8* %l6
  %s43 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.43, i32 0, i32 0
  %t44 = load double, double* %l3
  %t45 = sitofp i64 1 to double
  %t46 = fadd double %t44, %t45
  store double %t46, double* %l3
  br label %loop.latch2
loop.latch2:
  %t47 = load i8*, i8** %l1
  %t48 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t51 = load i8*, i8** %l1
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t52
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
  %t49 = phi i8* [ %t10, %entry ], [ %t47, %loop.latch2 ]
  %t50 = phi double [ %t12, %entry ], [ %t48, %loop.latch2 ]
  store i8* %t49, i8** %l1
  store double %t50, double* %l3
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
  %t29 = load i8, i8* %l6
  %s30 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.30, i32 0, i32 0
  %t31 = load double, double* %l3
  %t32 = sitofp i64 1 to double
  %t33 = fadd double %t31, %t32
  store double %t33, double* %l3
  br label %loop.latch2
merge5:
  %t35 = load i8, i8* %l6
  %s36 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.36, i32 0, i32 0
  %t39 = load i8, i8* %l6
  %s40 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.40, i32 0, i32 0
  %t42 = load i8, i8* %l6
  %s43 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.43, i32 0, i32 0
  %t44 = load double, double* %l3
  %t45 = sitofp i64 1 to double
  %t46 = fadd double %t44, %t45
  store double %t46, double* %l3
  br label %loop.latch2
loop.latch2:
  %t47 = load i8*, i8** %l1
  %t48 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t51 = load i8*, i8** %l1
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t52
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
  %s7 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.7, i32 0, i32 0
  br label %afterloop3
loop.latch2:
  br label %loop.header0
afterloop3:
  %t8 = load double, double* %l0
  %t9 = load double, double* %l0
  %t10 = call double @substring(i8* %text, i64 0, double %t9)
  ret i8* null
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
  %t13 = phi double [ %t2, %entry ], [ %t12, %loop.latch2 ]
  store double %t13, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load double, double* %l1
  %t5 = getelementptr i8, i8* %text, i64 %t4
  %t6 = load i8, i8* %t5
  store i8 %t6, i8* %l2
  %t7 = load i8, i8* %l2
  %s8 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.8, i32 0, i32 0
  %t9 = load double, double* %l1
  %t10 = sitofp i64 1 to double
  %t11 = fadd double %t9, %t10
  store double %t11, double* %l1
  br label %loop.latch2
loop.latch2:
  %t12 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t14 = sitofp i64 -1 to double
  ret double %t14
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
  %t24 = phi double [ %t5, %entry ], [ %t22, %loop.latch4 ]
  %t25 = phi double [ %t6, %entry ], [ %t23, %loop.latch4 ]
  store double %t24, double* %l0
  store double %t25, double* %l1
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
  %s15 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.15, i32 0, i32 0
  %t16 = load double, double* %l0
  %t17 = sitofp i64 1 to double
  %t18 = fadd double %t16, %t17
  store double %t18, double* %l0
  %t19 = load double, double* %l1
  %t20 = sitofp i64 1 to double
  %t21 = fsub double %t19, %t20
  store double %t21, double* %l1
  br label %loop.latch4
loop.latch4:
  %t22 = load double, double* %l0
  %t23 = load double, double* %l1
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
  %t29 = phi double [ %t0, %entry ], [ %t28, %loop.latch2 ]
  store double %t29, double* %l0
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l0
  %t4 = load double, double* %l0
  %t5 = getelementptr i8, i8* %text, i64 %t4
  %t6 = load i8, i8* %t5
  store i8 %t6, i8* %l3
  %t7 = load i8, i8* %l3
  %s8 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.8, i32 0, i32 0
  %t9 = load i8, i8* %l3
  %s10 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.10, i32 0, i32 0
  %t12 = load i1, i1* %l1
  br label %logical_and_entry_11

logical_and_entry_11:
  br i1 %t12, label %logical_and_right_11, label %logical_and_merge_11

logical_and_right_11:
  %t13 = load i1, i1* %l2
  %t14 = xor i1 %t13, 1
  br label %logical_and_right_end_11

logical_and_right_end_11:
  br label %logical_and_merge_11

logical_and_merge_11:
  %t15 = phi i1 [ false, %logical_and_entry_11 ], [ %t14, %logical_and_right_end_11 ]
  %t16 = xor i1 %t15, 1
  %t17 = load double, double* %l0
  %t18 = load i1, i1* %l1
  %t19 = load i1, i1* %l2
  %t20 = load i8, i8* %l3
  br i1 %t16, label %then4, label %merge5
then4:
  %t21 = load i8, i8* %l3
  %s22 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.22, i32 0, i32 0
  %t23 = load i8, i8* %l3
  %s24 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.24, i32 0, i32 0
  br label %merge5
merge5:
  %t25 = load double, double* %l0
  %t26 = sitofp i64 1 to double
  %t27 = fadd double %t25, %t26
  store double %t27, double* %l0
  br label %loop.latch2
loop.latch2:
  %t28 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t30 = sitofp i64 -1 to double
  ret double %t30
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
  %t30 = phi double [ %t2, %entry ], [ %t29, %loop.latch2 ]
  store double %t30, double* %l1
  br label %loop.body1
loop.body1:
  %t5 = load double, double* %l1
  %t6 = load double, double* %l1
  %t7 = getelementptr i8, i8* %text, i64 %t6
  %t8 = load i8, i8* %t7
  store i8 %t8, i8* %l4
  %t9 = load i8, i8* %l4
  %s10 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.10, i32 0, i32 0
  %t11 = load i8, i8* %l4
  %s12 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.12, i32 0, i32 0
  %t14 = load i1, i1* %l2
  br label %logical_and_entry_13

logical_and_entry_13:
  br i1 %t14, label %logical_and_right_13, label %logical_and_merge_13

logical_and_right_13:
  %t15 = load i1, i1* %l3
  %t16 = xor i1 %t15, 1
  br label %logical_and_right_end_13

logical_and_right_end_13:
  br label %logical_and_merge_13

logical_and_merge_13:
  %t17 = phi i1 [ false, %logical_and_entry_13 ], [ %t16, %logical_and_right_end_13 ]
  %t18 = xor i1 %t17, 1
  %t19 = load double, double* %l0
  %t20 = load double, double* %l1
  %t21 = load i1, i1* %l2
  %t22 = load i1, i1* %l3
  %t23 = load i8, i8* %l4
  br i1 %t18, label %then4, label %merge5
then4:
  %t24 = load i8, i8* %l4
  %s25 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.25, i32 0, i32 0
  br label %merge5
merge5:
  %t26 = load double, double* %l1
  %t27 = sitofp i64 1 to double
  %t28 = fadd double %t26, %t27
  store double %t28, double* %l1
  br label %loop.latch2
loop.latch2:
  %t29 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t31 = sitofp i64 -1 to double
  ret double %t31
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

define %PythonFunctionEmission @emit_python_function(%PythonBuilder %builder, i8* %function) {
entry:
  %l0 = alloca %PythonBuilder
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca { %MatchContext*, i64 }*
  %l6 = alloca double
  %l7 = alloca double
  %l8 = alloca double
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
  store double 0.0, double* %l2
  %s5 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.5, i32 0, i32 0
  store double 0.0, double* %l3
  %t6 = load %PythonBuilder, %PythonBuilder* %l0
  %t7 = load double, double* %l3
  %t8 = call %PythonBuilder @builder_emit(%PythonBuilder %t6, i8* null)
  store %PythonBuilder %t8, %PythonBuilder* %l0
  %t9 = load %PythonBuilder, %PythonBuilder* %l0
  %t10 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t9)
  store %PythonBuilder %t10, %PythonBuilder* %l0
  %t11 = sitofp i64 0 to double
  store double %t11, double* %l4
  %t12 = alloca [0 x double]
  %t13 = getelementptr [0 x double], [0 x double]* %t12, i32 0, i32 0
  %t14 = alloca { double*, i64 }
  %t15 = getelementptr { double*, i64 }, { double*, i64 }* %t14, i32 0, i32 0
  store double* %t13, double** %t15
  %t16 = getelementptr { double*, i64 }, { double*, i64 }* %t14, i32 0, i32 1
  store i64 0, i64* %t16
  store { %MatchContext*, i64 }* null, { %MatchContext*, i64 }** %l5
  %t17 = sitofp i64 0 to double
  store double %t17, double* %l6
  %t18 = sitofp i64 0 to double
  store double %t18, double* %l7
  %t19 = load %PythonBuilder, %PythonBuilder* %l0
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t21 = load double, double* %l2
  %t22 = load double, double* %l3
  %t23 = load double, double* %l4
  %t24 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t25 = load double, double* %l6
  %t26 = load double, double* %l7
  br label %loop.header0
loop.header0:
  %t33 = phi double [ %t26, %entry ], [ %t32, %loop.latch2 ]
  store double %t33, double* %l7
  br label %loop.body1
loop.body1:
  %t27 = load double, double* %l7
  store double 0.0, double* %l8
  %t28 = load double, double* %l8
  %t29 = load double, double* %l7
  %t30 = sitofp i64 1 to double
  %t31 = fadd double %t29, %t30
  store double %t31, double* %l7
  br label %loop.latch2
loop.latch2:
  %t32 = load double, double* %l7
  br label %loop.header0
afterloop3:
  %t34 = load %PythonBuilder, %PythonBuilder* %l0
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t36 = load double, double* %l2
  %t37 = load double, double* %l3
  %t38 = load double, double* %l4
  %t39 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t40 = load double, double* %l6
  %t41 = load double, double* %l7
  br label %loop.header4
loop.header4:
  %t90 = phi %PythonBuilder [ %t34, %entry ], [ %t87, %loop.latch6 ]
  %t91 = phi { i8**, i64 }* [ %t35, %entry ], [ %t88, %loop.latch6 ]
  %t92 = phi { %MatchContext*, i64 }* [ %t39, %entry ], [ %t89, %loop.latch6 ]
  store %PythonBuilder %t90, %PythonBuilder* %l0
  store { i8**, i64 }* %t91, { i8**, i64 }** %l1
  store { %MatchContext*, i64 }* %t92, { %MatchContext*, i64 }** %l5
  br label %loop.body5
loop.body5:
  %t42 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t43 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t42
  %t44 = extractvalue { %MatchContext*, i64 } %t43, 1
  %t45 = icmp eq i64 %t44, 0
  %t46 = load %PythonBuilder, %PythonBuilder* %l0
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t48 = load double, double* %l2
  %t49 = load double, double* %l3
  %t50 = load double, double* %l4
  %t51 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t52 = load double, double* %l6
  %t53 = load double, double* %l7
  br i1 %t45, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t54 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t55 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t54
  %t56 = extractvalue { %MatchContext*, i64 } %t55, 1
  %t57 = sub i64 %t56, 1
  store i64 %t57, i64* %l9
  %t58 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t59 = load i64, i64* %l9
  %t60 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t58
  %t61 = extractvalue { %MatchContext*, i64 } %t60, 0
  %t62 = extractvalue { %MatchContext*, i64 } %t60, 1
  %t63 = icmp uge i64 %t59, %t62
  ; bounds check: %t63 (if true, out of bounds)
  %t64 = getelementptr %MatchContext, %MatchContext* %t61, i64 %t59
  %t65 = load %MatchContext, %MatchContext* %t64
  store %MatchContext %t65, %MatchContext* %l10
  %t66 = load %MatchContext, %MatchContext* %l10
  %t67 = extractvalue %MatchContext %t66, 2
  %t68 = load %PythonBuilder, %PythonBuilder* %l0
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t70 = load double, double* %l2
  %t71 = load double, double* %l3
  %t72 = load double, double* %l4
  %t73 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t74 = load double, double* %l6
  %t75 = load double, double* %l7
  %t76 = load i64, i64* %l9
  %t77 = load %MatchContext, %MatchContext* %l10
  br i1 %t67, label %then10, label %merge11
then10:
  %t78 = load %PythonBuilder, %PythonBuilder* %l0
  %t79 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t78)
  store %PythonBuilder %t79, %PythonBuilder* %l0
  br label %merge11
merge11:
  %t80 = phi %PythonBuilder [ %t79, %then10 ], [ %t68, %loop.body5 ]
  store %PythonBuilder %t80, %PythonBuilder* %l0
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s82 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.82, i32 0, i32 0
  %t83 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t84 = load i64, i64* %l9
  %t85 = sitofp i64 %t84 to double
  %t86 = call { %MatchContext*, i64 }* @truncate_match_contexts({ %MatchContext*, i64 }* %t83, double %t85)
  store { %MatchContext*, i64 }* %t86, { %MatchContext*, i64 }** %l5
  br label %loop.latch6
loop.latch6:
  %t87 = load %PythonBuilder, %PythonBuilder* %l0
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t89 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  br label %loop.header4
afterloop7:
  %t93 = load %PythonBuilder, %PythonBuilder* %l0
  %t94 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t95 = load double, double* %l2
  %t96 = load double, double* %l3
  %t97 = load double, double* %l4
  %t98 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t99 = load double, double* %l6
  %t100 = load double, double* %l7
  br label %loop.header12
loop.header12:
  %t121 = phi %PythonBuilder [ %t93, %entry ], [ %t118, %loop.latch14 ]
  %t122 = phi double [ %t97, %entry ], [ %t119, %loop.latch14 ]
  %t123 = phi { i8**, i64 }* [ %t94, %entry ], [ %t120, %loop.latch14 ]
  store %PythonBuilder %t121, %PythonBuilder* %l0
  store double %t122, double* %l4
  store { i8**, i64 }* %t123, { i8**, i64 }** %l1
  br label %loop.body13
loop.body13:
  %t101 = load double, double* %l4
  %t102 = sitofp i64 0 to double
  %t103 = fcmp ole double %t101, %t102
  %t104 = load %PythonBuilder, %PythonBuilder* %l0
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t106 = load double, double* %l2
  %t107 = load double, double* %l3
  %t108 = load double, double* %l4
  %t109 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t110 = load double, double* %l6
  %t111 = load double, double* %l7
  br i1 %t103, label %then16, label %merge17
then16:
  br label %afterloop15
merge17:
  %t112 = load %PythonBuilder, %PythonBuilder* %l0
  %t113 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t112)
  store %PythonBuilder %t113, %PythonBuilder* %l0
  %t114 = load double, double* %l4
  %t115 = sitofp i64 1 to double
  %t116 = fsub double %t114, %t115
  store double %t116, double* %l4
  %t117 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %loop.latch14
loop.latch14:
  %t118 = load %PythonBuilder, %PythonBuilder* %l0
  %t119 = load double, double* %l4
  %t120 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %loop.header12
afterloop15:
  %t124 = load %PythonBuilder, %PythonBuilder* %l0
  %t125 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t124)
  store %PythonBuilder %t125, %PythonBuilder* %l0
  %t126 = load %PythonBuilder, %PythonBuilder* %l0
  %t127 = insertvalue %PythonFunctionEmission undef, i8* null, 0
  %t128 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t129 = insertvalue %PythonFunctionEmission %t127, { i8**, i64 }* %t128, 1
  ret %PythonFunctionEmission %t129
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
  %l6 = alloca double
  %t0 = sitofp i64 0 to double
  %t1 = fcmp oeq double %value, %t0
  br i1 %t1, label %then0, label %merge1
then0:
  %s2 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.2, i32 0, i32 0
  ret i8* %s2
merge1:
  %s3 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.3, i32 0, i32 0
  store i8* %s3, i8** %l0
  store double %value, double* %l1
  %s4 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.4, i32 0, i32 0
  store i8* %s4, i8** %l2
  %t5 = load i8*, i8** %l0
  %t6 = load double, double* %l1
  %t7 = load i8*, i8** %l2
  br label %loop.header2
loop.header2:
  %t51 = phi i8* [ %t7, %entry ], [ %t49, %loop.latch4 ]
  %t52 = phi double [ %t6, %entry ], [ %t50, %loop.latch4 ]
  store i8* %t51, i8** %l2
  store double %t52, double* %l1
  br label %loop.body3
loop.body3:
  %t8 = load double, double* %l1
  %t9 = sitofp i64 0 to double
  %t10 = fcmp ole double %t8, %t9
  %t11 = load i8*, i8** %l0
  %t12 = load double, double* %l1
  %t13 = load i8*, i8** %l2
  br i1 %t10, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t14 = load double, double* %l1
  store double %t14, double* %l3
  %t15 = sitofp i64 0 to double
  store double %t15, double* %l4
  %t16 = load i8*, i8** %l0
  %t17 = load double, double* %l1
  %t18 = load i8*, i8** %l2
  %t19 = load double, double* %l3
  %t20 = load double, double* %l4
  br label %loop.header8
loop.header8:
  %t37 = phi double [ %t19, %loop.body3 ], [ %t35, %loop.latch10 ]
  %t38 = phi double [ %t20, %loop.body3 ], [ %t36, %loop.latch10 ]
  store double %t37, double* %l3
  store double %t38, double* %l4
  br label %loop.body9
loop.body9:
  %t21 = load double, double* %l3
  %t22 = sitofp i64 10 to double
  %t23 = fcmp olt double %t21, %t22
  %t24 = load i8*, i8** %l0
  %t25 = load double, double* %l1
  %t26 = load i8*, i8** %l2
  %t27 = load double, double* %l3
  %t28 = load double, double* %l4
  br i1 %t23, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t29 = load double, double* %l3
  %t30 = sitofp i64 10 to double
  %t31 = fsub double %t29, %t30
  store double %t31, double* %l3
  %t32 = load double, double* %l4
  %t33 = sitofp i64 1 to double
  %t34 = fadd double %t32, %t33
  store double %t34, double* %l4
  br label %loop.latch10
loop.latch10:
  %t35 = load double, double* %l3
  %t36 = load double, double* %l4
  br label %loop.header8
afterloop11:
  %t39 = load double, double* %l3
  store double %t39, double* %l5
  %t40 = load i8*, i8** %l0
  %t41 = load double, double* %l5
  %t42 = load double, double* %l5
  %t43 = sitofp i64 1 to double
  %t44 = fadd double %t42, %t43
  %t45 = call double @substring(i8* %t40, double %t41, double %t44)
  store double %t45, double* %l6
  %t46 = load double, double* %l6
  %t47 = load i8*, i8** %l2
  %t48 = load double, double* %l4
  store double %t48, double* %l1
  br label %loop.latch4
loop.latch4:
  %t49 = load i8*, i8** %l2
  %t50 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t53 = load i8*, i8** %l2
  ret i8* %t53
}

define { i8**, i64 }* @render_python_parameters({ i8**, i64 }* %parameters) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca i8*
  %t0 = load { i8**, i64 }, { i8**, i64 }* %parameters
  %t1 = extractvalue { i8**, i64 } %t0, 1
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
  %t40 = phi { i8**, i64 }* [ %t14, %entry ], [ %t38, %loop.latch4 ]
  %t41 = phi double [ %t15, %entry ], [ %t39, %loop.latch4 ]
  store { i8**, i64 }* %t40, { i8**, i64 }** %l0
  store double %t41, double* %l1
  br label %loop.body3
loop.body3:
  %t16 = load double, double* %l1
  %t17 = load { i8**, i64 }, { i8**, i64 }* %parameters
  %t18 = extractvalue { i8**, i64 } %t17, 1
  %t19 = sitofp i64 %t18 to double
  %t20 = fcmp oge double %t16, %t19
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t22 = load double, double* %l1
  br i1 %t20, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t23 = load double, double* %l1
  %t24 = load { i8**, i64 }, { i8**, i64 }* %parameters
  %t25 = extractvalue { i8**, i64 } %t24, 0
  %t26 = extractvalue { i8**, i64 } %t24, 1
  %t27 = icmp uge i64 %t23, %t26
  ; bounds check: %t27 (if true, out of bounds)
  %t28 = getelementptr i8*, i8** %t25, i64 %t23
  %t29 = load i8*, i8** %t28
  store i8* %t29, i8** %l2
  %t30 = load i8*, i8** %l2
  store i8* null, i8** %l3
  %t31 = load i8*, i8** %l2
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t33 = load i8*, i8** %l3
  %t34 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t32, i8* %t33)
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
  ret { i8**, i64 }* %t42
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
  %t23 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t21, i8* %t22)
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
  %t2 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t0, i8* %s1)
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
  %s1 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.1, i32 0, i32 0
  %t2 = call i8* @join_with_separator({ i8**, i64 }* %t0, i8* %s1)
  store i8* %t2, i8** %l0
  %t3 = load i8*, i8** %l0
  %t4 = load i8*, i8** %l0
  %s5 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.5, i32 0, i32 0
  %t6 = add i8* %t4, %s5
  ret i8* %t6
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
  %t23 = phi i8* [ %t2, %entry ], [ %t21, %loop.latch2 ]
  %t24 = phi double [ %t3, %entry ], [ %t22, %loop.latch2 ]
  store i8* %t23, i8** %l0
  store double %t24, double* %l1
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
  br label %merge6
else5:
  %t15 = load i8, i8* %l2
  %s16 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.16, i32 0, i32 0
  br label %merge6
merge6:
  %t17 = phi i8* [ null, %then4 ], [ %t10, %else5 ]
  store i8* %t17, i8** %l0
  %t18 = load double, double* %l1
  %t19 = sitofp i64 1 to double
  %t20 = fadd double %t18, %t19
  store double %t20, double* %l1
  br label %loop.latch2
loop.latch2:
  %t21 = load i8*, i8** %l0
  %t22 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t25 = load i8*, i8** %l0
  %t26 = load i8*, i8** %l0
  ret i8* %t26
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
  %t25 = phi double [ %t12, %entry ], [ %t24, %loop.latch2 ]
  store double %t25, double* %l3
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
  %s20 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.20, i32 0, i32 0
  %t21 = load double, double* %l3
  %t22 = sitofp i64 1 to double
  %t23 = fadd double %t21, %t22
  store double %t23, double* %l3
  br label %loop.latch2
loop.latch2:
  %t24 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t26 = load i8*, i8** %l1
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t28 = load { i8**, i64 }, { i8**, i64 }* %t27
  %t29 = extractvalue { i8**, i64 } %t28, 1
  %t30 = icmp eq i64 %t29, 0
  %t31 = load i8*, i8** %l0
  %t32 = load i8*, i8** %l1
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t34 = load double, double* %l3
  br i1 %t30, label %then4, label %merge5
then4:
  %t35 = load i8*, i8** %l0
  %t36 = call i8* @sanitize_identifier(i8* %t35)
  ret i8* %t36
merge5:
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %s38 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.38, i32 0, i32 0
  %t39 = call i8* @join_with_separator({ i8**, i64 }* %t37, i8* %s38)
  ret i8* %t39
}

define i1 @is_identifier_char(i8* %ch) {
entry:
  %l0 = alloca double
  %s0 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.0, i32 0, i32 0
  %t1 = icmp eq i8* %ch, %s0
  br i1 %t1, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %t2 = call double @char_code(i8* %ch)
  store double %t2, double* %l0
  %t4 = load double, double* %l0
  %s5 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.5, i32 0, i32 0
  %t6 = call double @char_code(i8* %s5)
  %t7 = fcmp oge double %t4, %t6
  br label %logical_and_entry_3

logical_and_entry_3:
  br i1 %t7, label %logical_and_right_3, label %logical_and_merge_3

logical_and_right_3:
  %t8 = load double, double* %l0
  %s9 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.9, i32 0, i32 0
  %t10 = call double @char_code(i8* %s9)
  %t11 = fcmp ole double %t8, %t10
  br label %logical_and_right_end_3

logical_and_right_end_3:
  br label %logical_and_merge_3

logical_and_merge_3:
  %t12 = phi i1 [ false, %logical_and_entry_3 ], [ %t11, %logical_and_right_end_3 ]
  %t13 = load double, double* %l0
  br i1 %t12, label %then2, label %merge3
then2:
  ret i1 1
merge3:
  %t15 = load double, double* %l0
  %s16 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.16, i32 0, i32 0
  %t17 = call double @char_code(i8* %s16)
  %t18 = fcmp oge double %t15, %t17
  br label %logical_and_entry_14

logical_and_entry_14:
  br i1 %t18, label %logical_and_right_14, label %logical_and_merge_14

logical_and_right_14:
  %t19 = load double, double* %l0
  %s20 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.20, i32 0, i32 0
  %t21 = call double @char_code(i8* %s20)
  %t22 = fcmp ole double %t19, %t21
  br label %logical_and_right_end_14

logical_and_right_end_14:
  br label %logical_and_merge_14

logical_and_merge_14:
  %t23 = phi i1 [ false, %logical_and_entry_14 ], [ %t22, %logical_and_right_end_14 ]
  %t24 = load double, double* %l0
  br i1 %t23, label %then4, label %merge5
then4:
  ret i1 1
merge5:
  %t26 = load double, double* %l0
  %s27 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.27, i32 0, i32 0
  %t28 = call double @char_code(i8* %s27)
  %t29 = fcmp oge double %t26, %t28
  br label %logical_and_entry_25

logical_and_entry_25:
  br i1 %t29, label %logical_and_right_25, label %logical_and_merge_25

logical_and_right_25:
  %t30 = load double, double* %l0
  %s31 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.31, i32 0, i32 0
  %t32 = call double @char_code(i8* %s31)
  %t33 = fcmp ole double %t30, %t32
  br label %logical_and_right_end_25

logical_and_right_end_25:
  br label %logical_and_merge_25

logical_and_merge_25:
  %t34 = phi i1 [ false, %logical_and_entry_25 ], [ %t33, %logical_and_right_end_25 ]
  %t35 = load double, double* %l0
  br i1 %t34, label %then6, label %merge7
then6:
  ret i1 1
merge7:
  ret i1 0
}

define i1 @is_whitespace_char(i8* %ch) {
entry:
  %s0 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.0, i32 0, i32 0
  %t1 = icmp eq i8* %ch, %s0
  br i1 %t1, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %s2 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.2, i32 0, i32 0
  %t3 = icmp eq i8* %ch, %s2
  br i1 %t3, label %then2, label %merge3
then2:
  ret i1 1
merge3:
  %s4 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.4, i32 0, i32 0
  %t5 = icmp eq i8* %ch, %s4
  br i1 %t5, label %then4, label %merge5
then4:
  ret i1 1
merge5:
  %s6 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.6, i32 0, i32 0
  %t7 = icmp eq i8* %ch, %s6
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
  %l2 = alloca i8
  %l3 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  store double 0.0, double* %l1
  %t1 = load double, double* %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
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
  %s15 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.15, i32 0, i32 0
  br label %afterloop3
loop.latch2:
  br label %loop.header0
afterloop3:
  %t16 = load double, double* %l0
  %t17 = load double, double* %l1
  br label %loop.header6
loop.header6:
  br label %loop.body7
loop.body7:
  %t18 = load double, double* %l1
  %t19 = load double, double* %l0
  %t20 = fcmp ole double %t18, %t19
  %t21 = load double, double* %l0
  %t22 = load double, double* %l1
  br i1 %t20, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  store double 0.0, double* %l3
  %t26 = load double, double* %l3
  %s27 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.27, i32 0, i32 0
  br label %afterloop9
loop.latch8:
  br label %loop.header6
afterloop9:
  %t29 = load double, double* %l0
  %t30 = sitofp i64 0 to double
  %t31 = fcmp oeq double %t29, %t30
  br label %logical_and_entry_28

logical_and_entry_28:
  br i1 %t31, label %logical_and_right_28, label %logical_and_merge_28

logical_and_right_28:
  %t32 = load double, double* %l1
  %t33 = load double, double* %l0
  %t34 = load double, double* %l1
  %t35 = call double @substring(i8* %value, double %t33, double %t34)
  ret i8* null
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
  %t15 = phi i8* [ %t2, %entry ], [ %t13, %loop.latch2 ]
  %t16 = phi double [ %t3, %entry ], [ %t14, %loop.latch2 ]
  store i8* %t15, i8** %l0
  store double %t16, double* %l1
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  %t5 = load double, double* %l1
  %t6 = load i8*, i8** %l0
  %t7 = load double, double* %l1
  %t8 = getelementptr i8, i8* %value, i64 %t7
  %t9 = load i8, i8* %t8
  %t10 = load double, double* %l1
  %t11 = sitofp i64 1 to double
  %t12 = fadd double %t10, %t11
  store double %t12, double* %l1
  br label %loop.latch2
loop.latch2:
  %t13 = load i8*, i8** %l0
  %t14 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t17 = load i8*, i8** %l0
  ret i8* %t17
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
  %t4 = call { i8**, i64 }* @append_string({ i8**, i64 }* %diagnostics, i8* %t3)
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
