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
@.str.1 = private unnamed_addr constant [5 x i8] c" as \00"
@.str.5 = private unnamed_addr constant [2 x i8] c".\00"
@.str.76 = private unnamed_addr constant [12 x i8] c"__all__ = [\00"
@.str.0 = private unnamed_addr constant [7 x i8] c"class \00"
@.str.9 = private unnamed_addr constant [18 x i8] c"def __init__(self\00"
@.str.13 = private unnamed_addr constant [2 x i8] c":\00"
@.str.23 = private unnamed_addr constant [20 x i8] c"def __repr__(self):\00"
@.str.27 = private unnamed_addr constant [96 x i8] c"return runtime.struct_repr('\22 + class_name + \22', [\22 + join_with_separator(rendered, \22, \22) + \22])\00"
@.str.3 = private unnamed_addr constant [2 x i8] c"?\00"
@.str.0 = private unnamed_addr constant [2 x i8] c"'\00"
@.str.0 = private unnamed_addr constant [1 x i8] c"\00"
@.str.0 = private unnamed_addr constant [7 x i8] c".push(\00"
@.str.1 = private unnamed_addr constant [9 x i8] c".append(\00"
@.str.0 = private unnamed_addr constant [7 x i8] c"(\22, \22)\00"
@.str.0 = private unnamed_addr constant [2 x i8] c"[\00"
@.str.1 = private unnamed_addr constant [2 x i8] c"]\00"
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
  %l3 = alloca double
  %l4 = alloca %PythonFunctionEmission
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
  %t17 = load %PythonBuilder, %PythonBuilder* %l0
  %t18 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t17)
  store %PythonBuilder %t18, %PythonBuilder* %l0
  %t19 = load %PythonBuilder, %PythonBuilder* %l0
  %t20 = call %PythonBuilder @emit_runtime_aliases(%PythonBuilder %t19)
  store %PythonBuilder %t20, %PythonBuilder* %l0
  %t21 = load %PythonBuilder, %PythonBuilder* %l0
  %t22 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t21)
  store %PythonBuilder %t22, %PythonBuilder* %l0
  %t23 = sitofp i64 0 to double
  store double %t23, double* %l3
  %t24 = load %PythonBuilder, %PythonBuilder* %l0
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t27 = load double, double* %l3
  br label %loop.header0
loop.header0:
  %t52 = phi %PythonBuilder [ %t24, %entry ], [ %t49, %loop.latch2 ]
  %t53 = phi { i8**, i64 }* [ %t25, %entry ], [ %t50, %loop.latch2 ]
  %t54 = phi double [ %t27, %entry ], [ %t51, %loop.latch2 ]
  store %PythonBuilder %t52, %PythonBuilder* %l0
  store { i8**, i64 }* %t53, { i8**, i64 }** %l1
  store double %t54, double* %l3
  br label %loop.body1
loop.body1:
  %t28 = load double, double* %l3
  %t29 = load %PythonBuilder, %PythonBuilder* %l0
  %t30 = load double, double* %l3
  %t31 = load { i8**, i64 }, { i8**, i64 }* %functions
  %t32 = extractvalue { i8**, i64 } %t31, 0
  %t33 = extractvalue { i8**, i64 } %t31, 1
  %t34 = icmp uge i64 %t30, %t33
  ; bounds check: %t34 (if true, out of bounds)
  %t35 = getelementptr i8*, i8** %t32, i64 %t30
  %t36 = load i8*, i8** %t35
  %t37 = call %PythonFunctionEmission @emit_python_function(%PythonBuilder %t29, i8* %t36)
  store %PythonFunctionEmission %t37, %PythonFunctionEmission* %l4
  %t38 = load %PythonFunctionEmission, %PythonFunctionEmission* %l4
  %t39 = extractvalue %PythonFunctionEmission %t38, 0
  store %PythonBuilder zeroinitializer, %PythonBuilder* %l0
  %t40 = load %PythonFunctionEmission, %PythonFunctionEmission* %l4
  %t41 = extractvalue %PythonFunctionEmission %t40, 1
  %t42 = call double @diagnosticsconcat({ i8**, i64 }* %t41)
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t43 = load double, double* %l3
  %t44 = sitofp i64 1 to double
  %t45 = fadd double %t43, %t44
  %t46 = load double, double* %l3
  %t47 = sitofp i64 1 to double
  %t48 = fadd double %t46, %t47
  store double %t48, double* %l3
  br label %loop.latch2
loop.latch2:
  %t49 = load %PythonBuilder, %PythonBuilder* %l0
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t51 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t56 = load %PythonBuilder, %PythonBuilder* %l0
  %t57 = insertvalue %PythonModuleEmission undef, i8* null, 0
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t59 = insertvalue %PythonModuleEmission %t57, { i8**, i64 }* %t58, 1
  ret %PythonModuleEmission %t59
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
  %t23 = phi %PythonBuilder [ %t1, %entry ], [ %t21, %loop.latch2 ]
  %t24 = phi double [ %t2, %entry ], [ %t22, %loop.latch2 ]
  store %PythonBuilder %t23, %PythonBuilder* %l0
  store double %t24, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load double, double* %l1
  %t5 = load { i8**, i64 }, { i8**, i64 }* %bindings
  %t6 = extractvalue { i8**, i64 } %t5, 0
  %t7 = extractvalue { i8**, i64 } %t5, 1
  %t8 = icmp uge i64 %t4, %t7
  ; bounds check: %t8 (if true, out of bounds)
  %t9 = getelementptr i8*, i8** %t6, i64 %t4
  %t10 = load i8*, i8** %t9
  store i8* %t10, i8** %l2
  %t11 = load i8*, i8** %l2
  store double 0.0, double* %l3
  %t12 = load double, double* %l3
  %s13 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.13, i32 0, i32 0
  store i8* null, i8** %l4
  %t14 = load i8*, i8** %l2
  %t15 = load %PythonBuilder, %PythonBuilder* %l0
  %t16 = load i8*, i8** %l4
  %t17 = call %PythonBuilder @builder_emit(%PythonBuilder %t15, i8* %t16)
  store %PythonBuilder %t17, %PythonBuilder* %l0
  %t18 = load double, double* %l1
  %t19 = sitofp i64 1 to double
  %t20 = fadd double %t18, %t19
  store double %t20, double* %l1
  br label %loop.latch2
loop.latch2:
  %t21 = load %PythonBuilder, %PythonBuilder* %l0
  %t22 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t25 = load %PythonBuilder, %PythonBuilder* %l0
  ret %PythonBuilder %t25
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
  %t25 = phi double [ %t8, %entry ], [ %t24, %loop.latch2 ]
  store double %t25, double* %l2
  br label %loop.body1
loop.body1:
  %t9 = load double, double* %l2
  %t10 = load double, double* %l2
  %t11 = load { i8**, i64 }, { i8**, i64 }* %imports
  %t12 = extractvalue { i8**, i64 } %t11, 0
  %t13 = extractvalue { i8**, i64 } %t11, 1
  %t14 = icmp uge i64 %t10, %t13
  ; bounds check: %t14 (if true, out of bounds)
  %t15 = getelementptr i8*, i8** %t12, i64 %t10
  %t16 = load i8*, i8** %t15
  store i8* %t16, i8** %l3
  %t17 = load i8*, i8** %l3
  %t18 = load i8*, i8** %l3
  %t19 = call i8* @render_python_import(i8* %t18)
  store i8* %t19, i8** %l4
  %t20 = load i8*, i8** %l4
  %t21 = load double, double* %l2
  %t22 = sitofp i64 1 to double
  %t23 = fadd double %t21, %t22
  store double %t23, double* %l2
  br label %loop.latch2
loop.latch2:
  %t24 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t26 = load %PythonBuilder, %PythonBuilder* %l0
  %t27 = insertvalue %PythonImportEmission undef, i8* null, 0
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t29 = insertvalue %PythonImportEmission %t27, { i8**, i64 }* %t28, 1
  ret %PythonImportEmission %t29
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
  %t21 = phi %PythonBuilder [ %t1, %entry ], [ %t19, %loop.latch2 ]
  %t22 = phi double [ %t2, %entry ], [ %t20, %loop.latch2 ]
  store %PythonBuilder %t21, %PythonBuilder* %l0
  store double %t22, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load %PythonBuilder, %PythonBuilder* %l0
  %t5 = load double, double* %l1
  %t6 = load { i8**, i64 }, { i8**, i64 }* %enums
  %t7 = extractvalue { i8**, i64 } %t6, 0
  %t8 = extractvalue { i8**, i64 } %t6, 1
  %t9 = icmp uge i64 %t5, %t8
  ; bounds check: %t9 (if true, out of bounds)
  %t10 = getelementptr i8*, i8** %t7, i64 %t5
  %t11 = load i8*, i8** %t10
  %t12 = call %PythonBuilder @emit_single_enum(%PythonBuilder %t4, i8* %t11)
  store %PythonBuilder %t12, %PythonBuilder* %l0
  %t13 = load double, double* %l1
  %t14 = sitofp i64 1 to double
  %t15 = fadd double %t13, %t14
  %t16 = load double, double* %l1
  %t17 = sitofp i64 1 to double
  %t18 = fadd double %t16, %t17
  store double %t18, double* %l1
  br label %loop.latch2
loop.latch2:
  %t19 = load %PythonBuilder, %PythonBuilder* %l0
  %t20 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t23 = load %PythonBuilder, %PythonBuilder* %l0
  ret %PythonBuilder %t23
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
  %t23 = phi { i8**, i64 }* [ %t6, %entry ], [ %t21, %loop.latch2 ]
  %t24 = phi double [ %t7, %entry ], [ %t22, %loop.latch2 ]
  store { i8**, i64 }* %t23, { i8**, i64 }** %l0
  store double %t24, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s10 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.10, i32 0, i32 0
  %t11 = load double, double* %l1
  %t12 = load { i8**, i64 }, { i8**, i64 }* %fields
  %t13 = extractvalue { i8**, i64 } %t12, 0
  %t14 = extractvalue { i8**, i64 } %t12, 1
  %t15 = icmp uge i64 %t11, %t14
  ; bounds check: %t15 (if true, out of bounds)
  %t16 = getelementptr i8*, i8** %t13, i64 %t11
  %t17 = load i8*, i8** %t16
  %t18 = load double, double* %l1
  %t19 = sitofp i64 1 to double
  %t20 = fadd double %t18, %t19
  store double %t20, double* %l1
  br label %loop.latch2
loop.latch2:
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t22 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l0
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
  %t24 = phi { i8**, i64 }* [ %t6, %entry ], [ %t22, %loop.latch2 ]
  %t25 = phi double [ %t7, %entry ], [ %t23, %loop.latch2 ]
  store { i8**, i64 }* %t24, { i8**, i64 }** %l0
  store double %t25, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t10 = load double, double* %l1
  %t11 = load { i8**, i64 }, { i8**, i64 }* %specifiers
  %t12 = extractvalue { i8**, i64 } %t11, 0
  %t13 = extractvalue { i8**, i64 } %t11, 1
  %t14 = icmp uge i64 %t10, %t13
  ; bounds check: %t14 (if true, out of bounds)
  %t15 = getelementptr i8*, i8** %t12, i64 %t10
  %t16 = load i8*, i8** %t15
  %t17 = call i8* @render_python_specifier(i8* %t16)
  %t18 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t9, i8* %t17)
  store { i8**, i64 }* %t18, { i8**, i64 }** %l0
  %t19 = load double, double* %l1
  %t20 = sitofp i64 1 to double
  %t21 = fadd double %t19, %t20
  store double %t21, double* %l1
  br label %loop.latch2
loop.latch2:
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t23 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret i8* null
}

define i8* @render_python_specifier(i8* %specifier) {
entry:
  %l0 = alloca double
  store double 0.0, double* %l0
  %t0 = load double, double* %l0
  %s1 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.1, i32 0, i32 0
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
  %t33 = phi %PythonBuilder [ %t6, %entry ], [ %t30, %loop.latch2 ]
  %t34 = phi { i8**, i64 }* [ %t7, %entry ], [ %t31, %loop.latch2 ]
  %t35 = phi double [ %t8, %entry ], [ %t32, %loop.latch2 ]
  store %PythonBuilder %t33, %PythonBuilder* %l0
  store { i8**, i64 }* %t34, { i8**, i64 }** %l1
  store double %t35, double* %l2
  br label %loop.body1
loop.body1:
  %t9 = load double, double* %l2
  %t10 = load %PythonBuilder, %PythonBuilder* %l0
  %t11 = load double, double* %l2
  %t12 = load { i8**, i64 }, { i8**, i64 }* %structs
  %t13 = extractvalue { i8**, i64 } %t12, 0
  %t14 = extractvalue { i8**, i64 } %t12, 1
  %t15 = icmp uge i64 %t11, %t14
  ; bounds check: %t15 (if true, out of bounds)
  %t16 = getelementptr i8*, i8** %t13, i64 %t11
  %t17 = load i8*, i8** %t16
  %t18 = call %PythonStructEmission @emit_single_struct(%PythonBuilder %t10, i8* %t17)
  store %PythonStructEmission %t18, %PythonStructEmission* %l3
  %t19 = load %PythonStructEmission, %PythonStructEmission* %l3
  %t20 = extractvalue %PythonStructEmission %t19, 0
  store %PythonBuilder zeroinitializer, %PythonBuilder* %l0
  %t21 = load %PythonStructEmission, %PythonStructEmission* %l3
  %t22 = extractvalue %PythonStructEmission %t21, 1
  %t23 = call double @diagnosticsconcat({ i8**, i64 }* %t22)
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t24 = load double, double* %l2
  %t25 = sitofp i64 1 to double
  %t26 = fadd double %t24, %t25
  %t27 = load double, double* %l2
  %t28 = sitofp i64 1 to double
  %t29 = fadd double %t27, %t28
  store double %t29, double* %l2
  br label %loop.latch2
loop.latch2:
  %t30 = load %PythonBuilder, %PythonBuilder* %l0
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t32 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t36 = load %PythonBuilder, %PythonBuilder* %l0
  %t37 = insertvalue %PythonStructEmission undef, i8* null, 0
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t39 = insertvalue %PythonStructEmission %t37, { i8**, i64 }* %t38, 1
  ret %PythonStructEmission %t39
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
  %t43 = phi double [ %t7, %entry ], [ %t42, %loop.latch2 ]
  store double %t43, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load double, double* %l1
  %t10 = load { i8**, i64 }, { i8**, i64 }* %exports
  %t11 = extractvalue { i8**, i64 } %t10, 0
  %t12 = extractvalue { i8**, i64 } %t10, 1
  %t13 = icmp uge i64 %t9, %t12
  ; bounds check: %t13 (if true, out of bounds)
  %t14 = getelementptr i8*, i8** %t11, i64 %t9
  %t15 = load i8*, i8** %t14
  %t16 = call i8* @sanitize_identifier(i8* %t15)
  store i8* %t16, i8** %l2
  store i1 0, i1* %l3
  %t17 = sitofp i64 0 to double
  store double %t17, double* %l4
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t19 = load double, double* %l1
  %t20 = load i8*, i8** %l2
  %t21 = load i1, i1* %l3
  %t22 = load double, double* %l4
  br label %loop.header4
loop.header4:
  %t38 = phi double [ %t22, %loop.body1 ], [ %t37, %loop.latch6 ]
  store double %t38, double* %l4
  br label %loop.body5
loop.body5:
  %t23 = load double, double* %l4
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t26 = load double, double* %l4
  %t27 = load { i8**, i64 }, { i8**, i64 }* %t25
  %t28 = extractvalue { i8**, i64 } %t27, 0
  %t29 = extractvalue { i8**, i64 } %t27, 1
  %t30 = icmp uge i64 %t26, %t29
  ; bounds check: %t30 (if true, out of bounds)
  %t31 = getelementptr i8*, i8** %t28, i64 %t26
  %t32 = load i8*, i8** %t31
  %t33 = load i8*, i8** %l2
  %t34 = load double, double* %l4
  %t35 = sitofp i64 1 to double
  %t36 = fadd double %t34, %t35
  store double %t36, double* %l4
  br label %loop.latch6
loop.latch6:
  %t37 = load double, double* %l4
  br label %loop.header4
afterloop7:
  %t39 = load double, double* %l1
  %t40 = sitofp i64 1 to double
  %t41 = fadd double %t39, %t40
  store double %t41, double* %l1
  br label %loop.latch2
loop.latch2:
  %t42 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t44 = alloca [0 x double]
  %t45 = getelementptr [0 x double], [0 x double]* %t44, i32 0, i32 0
  %t46 = alloca { double*, i64 }
  %t47 = getelementptr { double*, i64 }, { double*, i64 }* %t46, i32 0, i32 0
  store double* %t45, double** %t47
  %t48 = getelementptr { double*, i64 }, { double*, i64 }* %t46, i32 0, i32 1
  store i64 0, i64* %t48
  store { i8**, i64 }* null, { i8**, i64 }** %l5
  %t49 = sitofp i64 0 to double
  store double %t49, double* %l1
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t51 = load double, double* %l1
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l5
  br label %loop.header8
loop.header8:
  %t74 = phi { i8**, i64 }* [ %t52, %entry ], [ %t72, %loop.latch10 ]
  %t75 = phi double [ %t51, %entry ], [ %t73, %loop.latch10 ]
  store { i8**, i64 }* %t74, { i8**, i64 }** %l5
  store double %t75, double* %l1
  br label %loop.body9
loop.body9:
  %t53 = load double, double* %l1
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %s56 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.56, i32 0, i32 0
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t58 = load double, double* %l1
  %t59 = load { i8**, i64 }, { i8**, i64 }* %t57
  %t60 = extractvalue { i8**, i64 } %t59, 0
  %t61 = extractvalue { i8**, i64 } %t59, 1
  %t62 = icmp uge i64 %t58, %t61
  ; bounds check: %t62 (if true, out of bounds)
  %t63 = getelementptr i8*, i8** %t60, i64 %t58
  %t64 = load i8*, i8** %t63
  %t65 = add i8* %s56, %t64
  %s66 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.66, i32 0, i32 0
  %t67 = add i8* %t65, %s66
  %t68 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t55, i8* %t67)
  store { i8**, i64 }* %t68, { i8**, i64 }** %l5
  %t69 = load double, double* %l1
  %t70 = sitofp i64 1 to double
  %t71 = fadd double %t69, %t70
  store double %t71, double* %l1
  br label %loop.latch10
loop.latch10:
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t73 = load double, double* %l1
  br label %loop.header8
afterloop11:
  %s76 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.76, i32 0, i32 0
  %t77 = load { i8**, i64 }*, { i8**, i64 }** %l5
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
  %t18 = phi double [ %t2, %entry ], [ %t17, %loop.latch2 ]
  store double %t18, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load double, double* %l1
  %t5 = load { i8**, i64 }, { i8**, i64 }* %specifiers
  %t6 = extractvalue { i8**, i64 } %t5, 0
  %t7 = extractvalue { i8**, i64 } %t5, 1
  %t8 = icmp uge i64 %t4, %t7
  ; bounds check: %t8 (if true, out of bounds)
  %t9 = getelementptr i8*, i8** %t6, i64 %t4
  %t10 = load i8*, i8** %t9
  store i8* %t10, i8** %l2
  %t11 = load i8*, i8** %l2
  %t12 = call i8* @select_export_name(i8* %t11)
  store i8* %t12, i8** %l3
  %t13 = load i8*, i8** %l3
  %t14 = load double, double* %l1
  %t15 = sitofp i64 1 to double
  %t16 = fadd double %t14, %t15
  store double %t16, double* %l1
  br label %loop.latch2
loop.latch2:
  %t17 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t19
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
  %t29 = phi double [ %t13, %entry ], [ %t28, %loop.latch2 ]
  store double %t29, double* %l2
  br label %loop.body1
loop.body1:
  %t14 = load double, double* %l2
  %t15 = load double, double* %l2
  %t16 = load { i8**, i64 }, { i8**, i64 }* %fields
  %t17 = extractvalue { i8**, i64 } %t16, 0
  %t18 = extractvalue { i8**, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  %t20 = getelementptr i8*, i8** %t17, i64 %t15
  %t21 = load i8*, i8** %t20
  store i8* %t21, i8** %l3
  %t22 = load i8*, i8** %l3
  store double 0.0, double* %l4
  %t23 = load double, double* %l4
  store i8* null, i8** %l5
  %t24 = load i8*, i8** %l3
  %t25 = load double, double* %l2
  %t26 = sitofp i64 1 to double
  %t27 = fadd double %t25, %t26
  store double %t27, double* %l2
  br label %loop.latch2
loop.latch2:
  %t28 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t31 = call double @requiredconcat({ i8**, i64 }* %t30)
  ret { i8**, i64 }* null
}

define i8* @render_struct_repr_fields(i8* %class_name, { i8**, i64 }* %fields) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
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
  %t25 = phi { i8**, i64 }* [ %t6, %entry ], [ %t23, %loop.latch2 ]
  %t26 = phi double [ %t7, %entry ], [ %t24, %loop.latch2 ]
  store { i8**, i64 }* %t25, { i8**, i64 }** %l0
  store double %t26, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load double, double* %l1
  %t10 = load { i8**, i64 }, { i8**, i64 }* %fields
  %t11 = extractvalue { i8**, i64 } %t10, 0
  %t12 = extractvalue { i8**, i64 } %t10, 1
  %t13 = icmp uge i64 %t9, %t12
  ; bounds check: %t13 (if true, out of bounds)
  %t14 = getelementptr i8*, i8** %t11, i64 %t9
  %t15 = load i8*, i8** %t14
  store i8* %t15, i8** %l2
  %t16 = load i8*, i8** %l2
  store double 0.0, double* %l3
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s18 = getelementptr inbounds [56 x i8], [56 x i8]* @.str.18, i32 0, i32 0
  %t19 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t17, i8* %s18)
  store { i8**, i64 }* %t19, { i8**, i64 }** %l0
  %t20 = load double, double* %l1
  %t21 = sitofp i64 1 to double
  %t22 = fadd double %t20, %t21
  store double %t22, double* %l1
  br label %loop.latch2
loop.latch2:
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t24 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %s27 = getelementptr inbounds [96 x i8], [96 x i8]* @.str.27, i32 0, i32 0
  ret i8* %s27
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
  %s1 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.1, i32 0, i32 0
  %s2 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.2, i32 0, i32 0
  %s3 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.3, i32 0, i32 0
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
  %t1 = extractvalue { i8**, i64 } %t0, 0
  %t2 = extractvalue { i8**, i64 } %t0, 1
  %t3 = icmp uge i64 0, %t2
  ; bounds check: %t3 (if true, out of bounds)
  %t4 = getelementptr i8*, i8** %t1, i64 0
  %t5 = load i8*, i8** %t4
  %t6 = call i8* @trim_text(i8* %t5)
  %t7 = call i8* @trim_trailing_delimiters(i8* %t6)
  store i8* %t7, i8** %l0
  %t8 = load i8*, i8** %l0
  %t9 = call i1 @is_array_metadata_entry(i8* %t8)
  %t10 = load i8*, i8** %l0
  br i1 %t9, label %then0, label %merge1
then0:
  %t11 = sitofp i64 1 to double
  ret double %t11
merge1:
  %t12 = sitofp i64 0 to double
  ret double %t12
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
  %t4 = call double @starts_with(i8* %t2, i8* %s3)
  %t5 = fcmp one double %t4, 0.0
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
  %t145 = phi double [ %t2, %entry ], [ %t143, %loop.latch2 ]
  %t146 = phi i8* [ %t1, %entry ], [ %t144, %loop.latch2 ]
  store double %t145, double* %l1
  store i8* %t146, i8** %l0
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load i8*, i8** %l0
  %t5 = load i8*, i8** %l0
  %s6 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.6, i32 0, i32 0
  %t7 = load double, double* %l1
  %t8 = call double @find_substring_from(i8* %t5, i8* %s6, double %t7)
  store double %t8, double* %l2
  %t9 = load double, double* %l2
  %t10 = sitofp i64 0 to double
  %t11 = fcmp olt double %t9, %t10
  %t12 = load i8*, i8** %l0
  %t13 = load double, double* %l1
  %t14 = load double, double* %l2
  br i1 %t11, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l2
  store double %t15, double* %l3
  %t16 = load i8*, i8** %l0
  %t17 = load double, double* %l1
  %t18 = load double, double* %l2
  %t19 = load double, double* %l3
  br label %loop.header6
loop.header6:
  %t38 = phi double [ %t19, %loop.body1 ], [ %t37, %loop.latch8 ]
  store double %t38, double* %l3
  br label %loop.body7
loop.body7:
  %t20 = load double, double* %l3
  %t21 = sitofp i64 0 to double
  %t22 = fcmp ole double %t20, %t21
  %t23 = load i8*, i8** %l0
  %t24 = load double, double* %l1
  %t25 = load double, double* %l2
  %t26 = load double, double* %l3
  br i1 %t22, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  store double 0.0, double* %l4
  %t27 = load double, double* %l4
  %t28 = call i1 @is_whitespace_char(i8* null)
  %t29 = load i8*, i8** %l0
  %t30 = load double, double* %l1
  %t31 = load double, double* %l2
  %t32 = load double, double* %l3
  %t33 = load double, double* %l4
  br i1 %t28, label %then12, label %merge13
then12:
  %t34 = load double, double* %l3
  %t35 = sitofp i64 1 to double
  %t36 = fsub double %t34, %t35
  store double %t36, double* %l3
  br label %loop.latch8
merge13:
  br label %afterloop9
loop.latch8:
  %t37 = load double, double* %l3
  br label %loop.header6
afterloop9:
  %t39 = load double, double* %l3
  store double %t39, double* %l5
  %t40 = load i8*, i8** %l0
  %t41 = load double, double* %l1
  %t42 = load double, double* %l2
  %t43 = load double, double* %l3
  %t44 = load double, double* %l5
  br label %loop.header14
loop.header14:
  %t67 = phi double [ %t44, %loop.body1 ], [ %t66, %loop.latch16 ]
  store double %t67, double* %l5
  br label %loop.body15
loop.body15:
  %t45 = load double, double* %l5
  %t46 = sitofp i64 0 to double
  %t47 = fcmp ole double %t45, %t46
  %t48 = load i8*, i8** %l0
  %t49 = load double, double* %l1
  %t50 = load double, double* %l2
  %t51 = load double, double* %l3
  %t52 = load double, double* %l5
  br i1 %t47, label %then18, label %merge19
then18:
  br label %afterloop17
merge19:
  store double 0.0, double* %l6
  %t53 = load double, double* %l6
  %s54 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.54, i32 0, i32 0
  %t55 = load double, double* %l6
  %t56 = call i1 @is_identifier_char(i8* null)
  %t57 = load i8*, i8** %l0
  %t58 = load double, double* %l1
  %t59 = load double, double* %l2
  %t60 = load double, double* %l3
  %t61 = load double, double* %l5
  %t62 = load double, double* %l6
  br i1 %t56, label %then20, label %merge21
then20:
  %t63 = load double, double* %l5
  %t64 = sitofp i64 1 to double
  %t65 = fsub double %t63, %t64
  store double %t65, double* %l5
  br label %loop.latch16
merge21:
  br label %afterloop17
loop.latch16:
  %t66 = load double, double* %l5
  br label %loop.header14
afterloop17:
  %t68 = load double, double* %l5
  %t69 = load double, double* %l3
  %t70 = fcmp oeq double %t68, %t69
  %t71 = load i8*, i8** %l0
  %t72 = load double, double* %l1
  %t73 = load double, double* %l2
  %t74 = load double, double* %l3
  %t75 = load double, double* %l5
  br i1 %t70, label %then22, label %merge23
then22:
  %t76 = load double, double* %l2
  %t77 = sitofp i64 1 to double
  %t78 = fadd double %t76, %t77
  store double %t78, double* %l1
  br label %loop.latch2
merge23:
  %t79 = load i8*, i8** %l0
  %t80 = load double, double* %l5
  %t81 = load double, double* %l3
  %t82 = call double @substring(i8* %t79, double %t80, double %t81)
  store double %t82, double* %l7
  %t83 = load double, double* %l7
  %t84 = call double @is_struct_literal_type_candidate(double %t83)
  %t85 = fcmp one double %t84, 0.0
  %t86 = load i8*, i8** %l0
  %t87 = load double, double* %l1
  %t88 = load double, double* %l2
  %t89 = load double, double* %l3
  %t90 = load double, double* %l5
  %t91 = load double, double* %l7
  br i1 %t85, label %then24, label %merge25
then24:
  %t92 = load double, double* %l2
  %t93 = sitofp i64 1 to double
  %t94 = fadd double %t92, %t93
  store double %t94, double* %l1
  br label %loop.latch2
merge25:
  %t95 = load double, double* %l5
  %t96 = sitofp i64 0 to double
  %t97 = fcmp ogt double %t95, %t96
  %t98 = load i8*, i8** %l0
  %t99 = load double, double* %l1
  %t100 = load double, double* %l2
  %t101 = load double, double* %l3
  %t102 = load double, double* %l5
  %t103 = load double, double* %l7
  br i1 %t97, label %then26, label %merge27
then26:
  store double 0.0, double* %l8
  br label %merge27
merge27:
  %t104 = load i8*, i8** %l0
  %t105 = load double, double* %l2
  %t106 = call double @find_matching_brace(i8* %t104, double %t105)
  store double %t106, double* %l9
  %t107 = load double, double* %l9
  %t108 = sitofp i64 0 to double
  %t109 = fcmp olt double %t107, %t108
  %t110 = load i8*, i8** %l0
  %t111 = load double, double* %l1
  %t112 = load double, double* %l2
  %t113 = load double, double* %l3
  %t114 = load double, double* %l5
  %t115 = load double, double* %l7
  %t116 = load double, double* %l9
  br i1 %t109, label %then28, label %merge29
then28:
  br label %afterloop3
merge29:
  %t117 = load i8*, i8** %l0
  %t118 = load double, double* %l5
  %t119 = load double, double* %l9
  %t120 = sitofp i64 1 to double
  %t121 = fadd double %t119, %t120
  %t122 = call double @substring(i8* %t117, double %t118, double %t121)
  store double %t122, double* %l10
  %t123 = load double, double* %l10
  %t124 = sitofp i64 1 to double
  %t125 = fadd double %depth, %t124
  %t126 = call double @lower_struct_literal_expression(i8* null, double %t125)
  store double %t126, double* %l11
  %t127 = load double, double* %l11
  %t128 = load i8*, i8** %l0
  %t129 = load double, double* %l5
  %t130 = call double @substring(i8* %t128, i64 0, double %t129)
  store double %t130, double* %l12
  %t131 = load i8*, i8** %l0
  %t132 = load double, double* %l9
  %t133 = sitofp i64 1 to double
  %t134 = fadd double %t132, %t133
  %t135 = load i8*, i8** %l0
  store double 0.0, double* %l13
  %t136 = load double, double* %l12
  %t137 = load double, double* %l11
  %t138 = fadd double %t136, %t137
  %t139 = load double, double* %l13
  %t140 = fadd double %t138, %t139
  store i8* null, i8** %l0
  %t141 = load double, double* %l5
  %t142 = load double, double* %l11
  br label %loop.latch2
loop.latch2:
  %t143 = load double, double* %l1
  %t144 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t147 = load i8*, i8** %l0
  ret i8* %t147
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
  %t3 = call double @ends_with(i8* %t1, i8* %s2)
  %t4 = fcmp one double %t3, 0.0
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
  %t67 = phi double [ %t32, %entry ], [ %t64, %loop.latch6 ]
  %t68 = phi double [ %t31, %entry ], [ %t65, %loop.latch6 ]
  %t69 = phi double [ %t30, %entry ], [ %t66, %loop.latch6 ]
  store double %t67, double* %l4
  store double %t68, double* %l3
  store double %t69, double* %l2
  br label %loop.body5
loop.body5:
  %t33 = load double, double* %l2
  %t34 = load double, double* %l2
  %t35 = load { i8**, i64 }, { i8**, i64 }* %instructions
  %t36 = extractvalue { i8**, i64 } %t35, 0
  %t37 = extractvalue { i8**, i64 } %t35, 1
  %t38 = icmp uge i64 %t34, %t37
  ; bounds check: %t38 (if true, out of bounds)
  %t39 = getelementptr i8*, i8** %t36, i64 %t34
  %t40 = load i8*, i8** %t39
  store i8* %t40, i8** %l5
  %t41 = load i8*, i8** %l5
  %t42 = load i8*, i8** %l5
  store double 0.0, double* %l6
  %t43 = load double, double* %l6
  %t44 = load double, double* %l4
  %t45 = load double, double* %l6
  %t46 = call double @compute_brace_balance(i8* null)
  %t47 = fadd double %t44, %t46
  store double %t47, double* %l4
  %t48 = load double, double* %l3
  %t49 = sitofp i64 1 to double
  %t50 = fadd double %t48, %t49
  store double %t50, double* %l3
  %t51 = load double, double* %l2
  %t52 = sitofp i64 1 to double
  %t53 = fadd double %t51, %t52
  store double %t53, double* %l2
  %t54 = load double, double* %l4
  %t55 = sitofp i64 0 to double
  %t56 = fcmp ole double %t54, %t55
  %t57 = load i8*, i8** %l0
  %t58 = load i8*, i8** %l1
  %t59 = load double, double* %l2
  %t60 = load double, double* %l3
  %t61 = load double, double* %l4
  %t62 = load i8*, i8** %l5
  %t63 = load double, double* %l6
  br i1 %t56, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  br label %loop.latch6
loop.latch6:
  %t64 = load double, double* %l4
  %t65 = load double, double* %l3
  %t66 = load double, double* %l2
  br label %loop.header4
afterloop7:
  %t70 = load double, double* %l4
  %t71 = sitofp i64 0 to double
  %t72 = fcmp une double %t70, %t71
  %t73 = load i8*, i8** %l0
  %t74 = load i8*, i8** %l1
  %t75 = load double, double* %l2
  %t76 = load double, double* %l3
  %t77 = load double, double* %l4
  br i1 %t72, label %then10, label %merge11
then10:
  %t78 = load i8*, i8** %l0
  %t79 = insertvalue %StructLiteralCapture undef, i8* %t78, 0
  %t80 = sitofp i64 0 to double
  %t81 = insertvalue %StructLiteralCapture %t79, double %t80, 1
  %t82 = insertvalue %StructLiteralCapture %t81, i1 0, 2
  ret %StructLiteralCapture %t82
merge11:
  %t83 = load double, double* %l3
  %t84 = sitofp i64 0 to double
  %t85 = fcmp oeq double %t83, %t84
  %t86 = load i8*, i8** %l0
  %t87 = load i8*, i8** %l1
  %t88 = load double, double* %l2
  %t89 = load double, double* %l3
  %t90 = load double, double* %l4
  br i1 %t85, label %then12, label %merge13
then12:
  %t91 = load i8*, i8** %l0
  %t92 = insertvalue %StructLiteralCapture undef, i8* %t91, 0
  %t93 = sitofp i64 0 to double
  %t94 = insertvalue %StructLiteralCapture %t92, double %t93, 1
  %t95 = insertvalue %StructLiteralCapture %t94, i1 0, 2
  ret %StructLiteralCapture %t95
merge13:
  %t96 = load i8*, i8** %l1
  %t97 = call i8* @trim_text(i8* %t96)
  %t98 = call i8* @trim_trailing_delimiters(i8* %t97)
  store i8* %t98, i8** %l7
  %t99 = load i8*, i8** %l7
  %s100 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.100, i32 0, i32 0
  %t101 = call double @ends_with(i8* %t99, i8* %s100)
  %t102 = fcmp one double %t101, 0.0
  %t103 = load i8*, i8** %l0
  %t104 = load i8*, i8** %l1
  %t105 = load double, double* %l2
  %t106 = load double, double* %l3
  %t107 = load double, double* %l4
  %t108 = load i8*, i8** %l7
  br i1 %t102, label %then14, label %merge15
then14:
  %t109 = load i8*, i8** %l0
  %t110 = insertvalue %StructLiteralCapture undef, i8* %t109, 0
  %t111 = sitofp i64 0 to double
  %t112 = insertvalue %StructLiteralCapture %t110, double %t111, 1
  %t113 = insertvalue %StructLiteralCapture %t112, i1 0, 2
  ret %StructLiteralCapture %t113
merge15:
  %t114 = load i8*, i8** %l7
  %t115 = insertvalue %StructLiteralCapture undef, i8* %t114, 0
  %t116 = load double, double* %l3
  %t117 = insertvalue %StructLiteralCapture %t115, double %t116, 1
  %t118 = insertvalue %StructLiteralCapture %t117, i1 1, 2
  ret %StructLiteralCapture %t118
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
  %t22 = phi i8* [ %t2, %entry ], [ %t20, %loop.latch2 ]
  %t23 = phi double [ %t3, %entry ], [ %t21, %loop.latch2 ]
  store i8* %t22, i8** %l0
  store double %t23, double* %l1
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  %t5 = load double, double* %l1
  %t6 = getelementptr i8, i8* %expression, i64 %t5
  %t7 = load i8, i8* %t6
  store i8 %t7, i8* %l2
  %t8 = load i8, i8* %l2
  %t9 = load i8, i8* %l2
  %s10 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.10, i32 0, i32 0
  %t11 = load i8, i8* %l2
  %s12 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.12, i32 0, i32 0
  %t13 = load i8, i8* %l2
  %s14 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.14, i32 0, i32 0
  %t15 = load i8*, i8** %l0
  %t16 = load i8, i8* %l2
  %t17 = load double, double* %l1
  %t18 = sitofp i64 1 to double
  %t19 = fadd double %t17, %t18
  store double %t19, double* %l1
  br label %loop.latch2
loop.latch2:
  %t20 = load i8*, i8** %l0
  %t21 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t24 = load i8*, i8** %l0
  ret i8* %t24
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
  %t48 = phi double [ %t3, %entry ], [ %t46, %loop.latch2 ]
  %t49 = phi i8* [ %t2, %entry ], [ %t47, %loop.latch2 ]
  store double %t48, double* %l1
  store i8* %t49, i8** %l0
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  %t5 = load double, double* %l1
  %t6 = getelementptr i8, i8* %expression, i64 %t5
  %t7 = load i8, i8* %t6
  store i8 %t7, i8* %l2
  %t8 = load i8, i8* %l2
  %t9 = load i8, i8* %l2
  %t10 = call i1 @is_identifier_char(i8* null)
  %t11 = load i8*, i8** %l0
  %t12 = load double, double* %l1
  %t13 = load i8, i8* %l2
  br i1 %t10, label %then4, label %merge5
then4:
  %t14 = load double, double* %l1
  store double %t14, double* %l3
  %t15 = load i8*, i8** %l0
  %t16 = load double, double* %l1
  %t17 = load i8, i8* %l2
  %t18 = load double, double* %l3
  br label %loop.header6
loop.header6:
  %t35 = phi double [ %t16, %then4 ], [ %t34, %loop.latch8 ]
  store double %t35, double* %l1
  br label %loop.body7
loop.body7:
  %t19 = load double, double* %l1
  %t20 = sitofp i64 1 to double
  %t21 = fadd double %t19, %t20
  store double %t21, double* %l1
  %t22 = load double, double* %l1
  %t23 = load double, double* %l1
  %t24 = getelementptr i8, i8* %expression, i64 %t23
  %t25 = load i8, i8* %t24
  store i8 %t25, i8* %l4
  %t26 = load i8, i8* %l4
  %t27 = call double @is_identifier_char(i8 %t26)
  %t28 = fcmp one double %t27, 0.0
  %t29 = load i8*, i8** %l0
  %t30 = load double, double* %l1
  %t31 = load i8, i8* %l2
  %t32 = load double, double* %l3
  %t33 = load i8, i8* %l4
  br i1 %t28, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  br label %loop.latch8
loop.latch8:
  %t34 = load double, double* %l1
  br label %loop.header6
afterloop9:
  %t36 = load double, double* %l3
  %t37 = load double, double* %l1
  %t38 = call double @substring(i8* %expression, double %t36, double %t37)
  store double %t38, double* %l5
  %t39 = load double, double* %l5
  %s40 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.40, i32 0, i32 0
  br label %loop.latch2
merge5:
  %t41 = load i8*, i8** %l0
  %t42 = load i8, i8* %l2
  %t43 = load double, double* %l1
  %t44 = sitofp i64 1 to double
  %t45 = fadd double %t43, %t44
  store double %t45, double* %l1
  br label %loop.latch2
loop.latch2:
  %t46 = load double, double* %l1
  %t47 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t50 = load i8*, i8** %l0
  ret i8* %t50
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
  %t22 = phi i8* [ %t6, %entry ], [ %t20, %loop.latch2 ]
  %t23 = phi double [ %t7, %entry ], [ %t21, %loop.latch2 ]
  store i8* %t22, i8** %l2
  store double %t23, double* %l3
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l3
  %t9 = load double, double* %l3
  %t10 = getelementptr i8, i8* %expression, i64 %t9
  %t11 = load i8, i8* %t10
  store i8 %t11, i8* %l4
  %t12 = load i8, i8* %l4
  %t13 = load double, double* %l3
  %t14 = load i8*, i8** %l0
  %t15 = load i8*, i8** %l2
  %t16 = load i8, i8* %l4
  %t17 = load double, double* %l3
  %t18 = sitofp i64 1 to double
  %t19 = fadd double %t17, %t18
  store double %t19, double* %l3
  br label %loop.latch2
loop.latch2:
  %t20 = load i8*, i8** %l2
  %t21 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t24 = load i8*, i8** %l2
  ret i8* %t24
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
  %t38 = phi i8* [ %t0, %entry ], [ %t37, %loop.latch2 ]
  store i8* %t38, i8** %l0
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
  %t12 = load double, double* %l1
  %t13 = sitofp i64 7 to double
  %t14 = fadd double %t12, %t13
  store double %t14, double* %l3
  %t15 = load i8*, i8** %l0
  %t16 = load double, double* %l3
  %t17 = call %ExtractedSpan @extract_parenthesized_span(i8* %t15, double %t16)
  store %ExtractedSpan %t17, %ExtractedSpan* %l4
  %t18 = load i8*, i8** %l0
  %t19 = load %ExtractedSpan, %ExtractedSpan* %l2
  %t20 = extractvalue %ExtractedSpan %t19, 1
  %t21 = call double @substring(i8* %t18, i64 0, double %t20)
  store double %t21, double* %l5
  %t22 = load i8*, i8** %l0
  %t23 = load %ExtractedSpan, %ExtractedSpan* %l4
  %t24 = extractvalue %ExtractedSpan %t23, 2
  %t25 = load i8*, i8** %l0
  store double 0.0, double* %l6
  %t26 = load %ExtractedSpan, %ExtractedSpan* %l2
  %t27 = extractvalue %ExtractedSpan %t26, 0
  %t28 = call i8* @trim_text(i8* %t27)
  store i8* %t28, i8** %l7
  %t29 = load %ExtractedSpan, %ExtractedSpan* %l4
  %t30 = extractvalue %ExtractedSpan %t29, 0
  %t31 = call i8* @trim_text(i8* %t30)
  store i8* %t31, i8** %l8
  store double 0.0, double* %l9
  %t32 = load double, double* %l5
  %t33 = load double, double* %l9
  %t34 = fadd double %t32, %t33
  %t35 = load double, double* %l6
  %t36 = fadd double %t34, %t35
  store i8* null, i8** %l0
  br label %loop.latch2
loop.latch2:
  %t37 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t39 = load i8*, i8** %l0
  ret i8* %t39
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
  %t28 = phi i8* [ %t0, %entry ], [ %t27, %loop.latch2 ]
  store i8* %t28, i8** %l0
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
  %t12 = load i8*, i8** %l0
  %t13 = load %ExtractedSpan, %ExtractedSpan* %l2
  %t14 = extractvalue %ExtractedSpan %t13, 1
  %t15 = call double @substring(i8* %t12, i64 0, double %t14)
  store double %t15, double* %l3
  %t16 = load i8*, i8** %l0
  %t17 = load double, double* %l1
  %t18 = sitofp i64 7 to double
  %t19 = fadd double %t17, %t18
  %t20 = load i8*, i8** %l0
  store double 0.0, double* %l4
  %t21 = load %ExtractedSpan, %ExtractedSpan* %l2
  %t22 = extractvalue %ExtractedSpan %t21, 0
  %t23 = call i8* @trim_text(i8* %t22)
  store i8* %t23, i8** %l5
  %t24 = load i8*, i8** %l5
  %t25 = load double, double* %l3
  %s26 = getelementptr inbounds [25 x i8], [25 x i8]* @.str.26, i32 0, i32 0
  br label %loop.latch2
loop.latch2:
  %t27 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t29 = load i8*, i8** %l0
  ret i8* %t29
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
  %t33 = load double, double* %l1
  br label %afterloop5
loop.latch4:
  br label %loop.header2
afterloop5:
  %t34 = load double, double* %l0
  %t35 = sitofp i64 1 to double
  %t36 = fadd double %t34, %t35
  store double %t36, double* %l4
  %t37 = load double, double* %l4
  %t38 = fcmp oge double %t37, %dot_index
  %t39 = load double, double* %l0
  %t40 = load double, double* %l1
  %t41 = load double, double* %l2
  %t42 = load double, double* %l4
  br i1 %t38, label %then8, label %merge9
then8:
  %s43 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.43, i32 0, i32 0
  %t44 = insertvalue %ExtractedSpan undef, i8* %s43, 0
  %t45 = load double, double* %l4
  %t46 = insertvalue %ExtractedSpan %t44, double %t45, 1
  %t47 = insertvalue %ExtractedSpan %t46, double %dot_index, 2
  %t48 = insertvalue %ExtractedSpan %t47, i1 0, 3
  ret %ExtractedSpan %t48
merge9:
  %t49 = load double, double* %l4
  %t50 = call double @substring(i8* %text, double %t49, double %dot_index)
  store double %t50, double* %l5
  %t51 = load double, double* %l5
  %t52 = insertvalue %ExtractedSpan undef, i8* null, 0
  %t53 = load double, double* %l4
  %t54 = insertvalue %ExtractedSpan %t52, double %t53, 1
  %t55 = insertvalue %ExtractedSpan %t54, double %dot_index, 2
  %t56 = insertvalue %ExtractedSpan %t55, i1 1, 3
  ret %ExtractedSpan %t56
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
  %t18 = phi double [ %t5, %entry ], [ %t17, %loop.latch2 ]
  store double %t18, double* %l1
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
  %t14 = load double, double* %l1
  %t15 = sitofp i64 1 to double
  %t16 = fadd double %t14, %t15
  store double %t16, double* %l1
  br label %loop.latch2
loop.latch2:
  %t17 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t19 = load double, double* %l1
  ret double %t19
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
  %t10 = load double, double* %l1
  store i1 false, i1* %l7
  %t11 = load i8*, i8** %l0
  %t12 = load double, double* %l1
  %t13 = load double, double* %l2
  %t14 = load double, double* %l3
  %t15 = load i8*, i8** %l4
  %t16 = load double, double* %l5
  %t17 = load double, double* %l6
  %t18 = load i1, i1* %l7
  br label %loop.header0
loop.header0:
  %t62 = phi i8* [ %t15, %entry ], [ %t56, %loop.latch2 ]
  %t63 = phi double [ %t12, %entry ], [ %t57, %loop.latch2 ]
  %t64 = phi double [ %t13, %entry ], [ %t58, %loop.latch2 ]
  %t65 = phi double [ %t14, %entry ], [ %t59, %loop.latch2 ]
  %t66 = phi double [ %t17, %entry ], [ %t60, %loop.latch2 ]
  %t67 = phi double [ %t16, %entry ], [ %t61, %loop.latch2 ]
  store i8* %t62, i8** %l4
  store double %t63, double* %l1
  store double %t64, double* %l2
  store double %t65, double* %l3
  store double %t66, double* %l6
  store double %t67, double* %l5
  br label %loop.body1
loop.body1:
  %t19 = load double, double* %l5
  %t20 = load double, double* %l5
  %t21 = load { i8**, i64 }, { i8**, i64 }* %instructions
  %t22 = extractvalue { i8**, i64 } %t21, 0
  %t23 = extractvalue { i8**, i64 } %t21, 1
  %t24 = icmp uge i64 %t20, %t23
  ; bounds check: %t24 (if true, out of bounds)
  %t25 = getelementptr i8*, i8** %t22, i64 %t20
  %t26 = load i8*, i8** %t25
  %t27 = call double @continuation_segment_text(i8* %t26)
  store double %t27, double* %l8
  %t28 = load double, double* %l8
  %t29 = load double, double* %l8
  %t30 = call i8* @trim_text(i8* null)
  store i8* %t30, i8** %l9
  %t31 = load i8*, i8** %l9
  %t32 = load i8*, i8** %l4
  %s33 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.33, i32 0, i32 0
  %t34 = add i8* %t32, %s33
  %t35 = load i8*, i8** %l9
  %t36 = add i8* %t34, %t35
  store i8* %t36, i8** %l4
  %t37 = load double, double* %l1
  %t38 = load i8*, i8** %l9
  %t39 = call double @compute_parenthesis_balance(i8* %t38)
  %t40 = fadd double %t37, %t39
  store double %t40, double* %l1
  %t41 = load double, double* %l2
  %t42 = load i8*, i8** %l9
  %t43 = call double @compute_brace_balance(i8* %t42)
  %t44 = fadd double %t41, %t43
  store double %t44, double* %l2
  %t45 = load double, double* %l3
  %t46 = load i8*, i8** %l9
  %t47 = call double @compute_bracket_balance(i8* %t46)
  %t48 = fadd double %t45, %t47
  store double %t48, double* %l3
  %t49 = load double, double* %l6
  %t50 = sitofp i64 1 to double
  %t51 = fadd double %t49, %t50
  store double %t51, double* %l6
  %t52 = load double, double* %l5
  %t53 = sitofp i64 1 to double
  %t54 = fadd double %t52, %t53
  store double %t54, double* %l5
  %t55 = load double, double* %l1
  br label %loop.latch2
loop.latch2:
  %t56 = load i8*, i8** %l4
  %t57 = load double, double* %l1
  %t58 = load double, double* %l2
  %t59 = load double, double* %l3
  %t60 = load double, double* %l6
  %t61 = load double, double* %l5
  br label %loop.header0
afterloop3:
  %t68 = load double, double* %l1
  %t69 = load i8*, i8** %l0
  %t70 = insertvalue %ExpressionContinuationCapture undef, i8* %t69, 0
  %t71 = sitofp i64 0 to double
  %t72 = insertvalue %ExpressionContinuationCapture %t70, double %t71, 1
  %t73 = insertvalue %ExpressionContinuationCapture %t72, i1 0, 2
  ret %ExpressionContinuationCapture %t73
}

define i1 @segment_signals_expression_continuation(i8* %segment) {
entry:
  %l0 = alloca i8
  %s0 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.0, i32 0, i32 0
  %t1 = call i1 @starts_with(i8* %segment, i8* %s0)
  br i1 %t1, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %s2 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.2, i32 0, i32 0
  %t3 = call i1 @starts_with(i8* %segment, i8* %s2)
  br i1 %t3, label %then2, label %merge3
then2:
  ret i1 1
merge3:
  %t4 = getelementptr i8, i8* %segment, i64 0
  %t5 = load i8, i8* %t4
  store i8 %t5, i8* %l0
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
  %s0 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.0, i32 0, i32 0
  %s1 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.1, i32 0, i32 0
  %t2 = call double @compute_symbol_balance(i8* %text, i8* %s0, i8* %s1)
  ret double %t2
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
  %t42 = phi i8* [ %t10, %entry ], [ %t40, %loop.latch2 ]
  %t43 = phi double [ %t12, %entry ], [ %t41, %loop.latch2 ]
  store i8* %t42, i8** %l1
  store double %t43, double* %l3
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
  %t34 = load i8, i8* %l6
  %t35 = load i8, i8* %l6
  %t36 = load i8, i8* %l6
  %t37 = load double, double* %l3
  %t38 = sitofp i64 1 to double
  %t39 = fadd double %t37, %t38
  store double %t39, double* %l3
  br label %loop.latch2
loop.latch2:
  %t40 = load i8*, i8** %l1
  %t41 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t44 = load i8*, i8** %l1
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t45
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
  %t42 = phi i8* [ %t10, %entry ], [ %t40, %loop.latch2 ]
  %t43 = phi double [ %t12, %entry ], [ %t41, %loop.latch2 ]
  store i8* %t42, i8** %l1
  store double %t43, double* %l3
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
  %t34 = load i8, i8* %l6
  %t35 = load i8, i8* %l6
  %t36 = load i8, i8* %l6
  %t37 = load double, double* %l3
  %t38 = sitofp i64 1 to double
  %t39 = fadd double %t37, %t38
  store double %t39, double* %l3
  br label %loop.latch2
loop.latch2:
  %t40 = load i8*, i8** %l1
  %t41 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t44 = load i8*, i8** %l1
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t45
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
  %t5 = load double, double* %l1
  br label %afterloop3
loop.latch2:
  br label %loop.header0
afterloop3:
  %t6 = load double, double* %l0
  %t7 = load double, double* %l0
  %t8 = call double @substring(i8* %text, i64 0, double %t7)
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
  %t15 = phi double [ %t0, %entry ], [ %t14, %loop.latch2 ]
  store double %t15, double* %l0
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
  %t11 = load double, double* %l0
  %t12 = sitofp i64 1 to double
  %t13 = fadd double %t11, %t12
  store double %t13, double* %l0
  br label %loop.latch2
loop.latch2:
  %t14 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t16 = sitofp i64 -1 to double
  ret double %t16
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
  %t17 = phi double [ %t2, %entry ], [ %t16, %loop.latch2 ]
  store double %t17, double* %l1
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
  %t13 = load double, double* %l1
  %t14 = sitofp i64 1 to double
  %t15 = fadd double %t13, %t14
  store double %t15, double* %l1
  br label %loop.latch2
loop.latch2:
  %t16 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t18 = sitofp i64 -1 to double
  ret double %t18
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
  %l9 = alloca double
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
  %t75 = phi %PythonBuilder [ %t34, %entry ], [ %t72, %loop.latch6 ]
  %t76 = phi { i8**, i64 }* [ %t35, %entry ], [ %t73, %loop.latch6 ]
  %t77 = phi { %MatchContext*, i64 }* [ %t39, %entry ], [ %t74, %loop.latch6 ]
  store %PythonBuilder %t75, %PythonBuilder* %l0
  store { i8**, i64 }* %t76, { i8**, i64 }** %l1
  store { %MatchContext*, i64 }* %t77, { %MatchContext*, i64 }** %l5
  br label %loop.body5
loop.body5:
  %t42 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t43 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  store double 0.0, double* %l9
  %t44 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t45 = load double, double* %l9
  %t46 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t44
  %t47 = extractvalue { %MatchContext*, i64 } %t46, 0
  %t48 = extractvalue { %MatchContext*, i64 } %t46, 1
  %t49 = icmp uge i64 %t45, %t48
  ; bounds check: %t49 (if true, out of bounds)
  %t50 = getelementptr %MatchContext, %MatchContext* %t47, i64 %t45
  %t51 = load %MatchContext, %MatchContext* %t50
  store %MatchContext %t51, %MatchContext* %l10
  %t52 = load %MatchContext, %MatchContext* %l10
  %t53 = extractvalue %MatchContext %t52, 2
  %t54 = load %PythonBuilder, %PythonBuilder* %l0
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t56 = load double, double* %l2
  %t57 = load double, double* %l3
  %t58 = load double, double* %l4
  %t59 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t60 = load double, double* %l6
  %t61 = load double, double* %l7
  %t62 = load double, double* %l9
  %t63 = load %MatchContext, %MatchContext* %l10
  br i1 %t53, label %then8, label %merge9
then8:
  %t64 = load %PythonBuilder, %PythonBuilder* %l0
  %t65 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t64)
  store %PythonBuilder %t65, %PythonBuilder* %l0
  br label %merge9
merge9:
  %t66 = phi %PythonBuilder [ %t65, %then8 ], [ %t54, %loop.body5 ]
  store %PythonBuilder %t66, %PythonBuilder* %l0
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s68 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.68, i32 0, i32 0
  %t69 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t70 = load double, double* %l9
  %t71 = call { %MatchContext*, i64 }* @truncate_match_contexts({ %MatchContext*, i64 }* %t69, double %t70)
  store { %MatchContext*, i64 }* %t71, { %MatchContext*, i64 }** %l5
  br label %loop.latch6
loop.latch6:
  %t72 = load %PythonBuilder, %PythonBuilder* %l0
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t74 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  br label %loop.header4
afterloop7:
  %t78 = load %PythonBuilder, %PythonBuilder* %l0
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t80 = load double, double* %l2
  %t81 = load double, double* %l3
  %t82 = load double, double* %l4
  %t83 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t84 = load double, double* %l6
  %t85 = load double, double* %l7
  br label %loop.header10
loop.header10:
  %t106 = phi %PythonBuilder [ %t78, %entry ], [ %t103, %loop.latch12 ]
  %t107 = phi double [ %t82, %entry ], [ %t104, %loop.latch12 ]
  %t108 = phi { i8**, i64 }* [ %t79, %entry ], [ %t105, %loop.latch12 ]
  store %PythonBuilder %t106, %PythonBuilder* %l0
  store double %t107, double* %l4
  store { i8**, i64 }* %t108, { i8**, i64 }** %l1
  br label %loop.body11
loop.body11:
  %t86 = load double, double* %l4
  %t87 = sitofp i64 0 to double
  %t88 = fcmp ole double %t86, %t87
  %t89 = load %PythonBuilder, %PythonBuilder* %l0
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t91 = load double, double* %l2
  %t92 = load double, double* %l3
  %t93 = load double, double* %l4
  %t94 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t95 = load double, double* %l6
  %t96 = load double, double* %l7
  br i1 %t88, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t97 = load %PythonBuilder, %PythonBuilder* %l0
  %t98 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t97)
  store %PythonBuilder %t98, %PythonBuilder* %l0
  %t99 = load double, double* %l4
  %t100 = sitofp i64 1 to double
  %t101 = fsub double %t99, %t100
  store double %t101, double* %l4
  %t102 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %loop.latch12
loop.latch12:
  %t103 = load %PythonBuilder, %PythonBuilder* %l0
  %t104 = load double, double* %l4
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %loop.header10
afterloop13:
  %t109 = load %PythonBuilder, %PythonBuilder* %l0
  %t110 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t109)
  store %PythonBuilder %t110, %PythonBuilder* %l0
  %t111 = load %PythonBuilder, %PythonBuilder* %l0
  %t112 = insertvalue %PythonFunctionEmission undef, i8* null, 0
  %t113 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t114 = insertvalue %PythonFunctionEmission %t112, { i8**, i64 }* %t113, 1
  ret %PythonFunctionEmission %t114
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
  %t30 = phi { %MatchContext*, i64 }* [ %t6, %entry ], [ %t28, %loop.latch2 ]
  %t31 = phi double [ %t7, %entry ], [ %t29, %loop.latch2 ]
  store { %MatchContext*, i64 }* %t30, { %MatchContext*, i64 }** %l0
  store double %t31, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load double, double* %l1
  %t10 = fcmp oeq double %t9, %index
  %t11 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t12 = load double, double* %l1
  br i1 %t10, label %then4, label %else5
then4:
  %t13 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t14 = call { %MatchContext*, i64 }* @append_match_context({ %MatchContext*, i64 }* %t13, %MatchContext %replacement)
  store { %MatchContext*, i64 }* %t14, { %MatchContext*, i64 }** %l0
  br label %merge6
else5:
  %t15 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t16 = load double, double* %l1
  %t17 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %values
  %t18 = extractvalue { %MatchContext*, i64 } %t17, 0
  %t19 = extractvalue { %MatchContext*, i64 } %t17, 1
  %t20 = icmp uge i64 %t16, %t19
  ; bounds check: %t20 (if true, out of bounds)
  %t21 = getelementptr %MatchContext, %MatchContext* %t18, i64 %t16
  %t22 = load %MatchContext, %MatchContext* %t21
  %t23 = call { %MatchContext*, i64 }* @append_match_context({ %MatchContext*, i64 }* %t15, %MatchContext %t22)
  store { %MatchContext*, i64 }* %t23, { %MatchContext*, i64 }** %l0
  br label %merge6
merge6:
  %t24 = phi { %MatchContext*, i64 }* [ %t14, %then4 ], [ %t23, %else5 ]
  store { %MatchContext*, i64 }* %t24, { %MatchContext*, i64 }** %l0
  %t25 = load double, double* %l1
  %t26 = sitofp i64 1 to double
  %t27 = fadd double %t25, %t26
  store double %t27, double* %l1
  br label %loop.latch2
loop.latch2:
  %t28 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t29 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t32 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  ret { %MatchContext*, i64 }* %t32
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
  %l4 = alloca i1
  %t0 = call i8* @trim_text(i8* %pattern)
  store i8* %t0, i8** %l0
  store i8* null, i8** %l1
  %t1 = load i8*, i8** %l0
  %t2 = load i8*, i8** %l0
  %t3 = call i8* @lower_expression(i8* %t2)
  store i8* %t3, i8** %l2
  store i8* null, i8** %l3
  store i1 0, i1* %l4
  %t4 = load i8*, i8** %l1
  %t5 = load i8*, i8** %l3
  %t6 = insertvalue %LoweredCaseCondition undef, i8* %t5, 0
  %t7 = insertvalue %LoweredCaseCondition %t6, i1 0, 1
  %t8 = load i1, i1* %l4
  %t9 = insertvalue %LoweredCaseCondition %t7, i1 %t8, 2
  ret %LoweredCaseCondition %t9
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
  %t26 = phi { i8**, i64 }* [ %t6, %entry ], [ %t24, %loop.latch2 ]
  %t27 = phi double [ %t7, %entry ], [ %t25, %loop.latch2 ]
  store { i8**, i64 }* %t26, { i8**, i64 }** %l0
  store double %t27, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load double, double* %l1
  %t10 = load { i8**, i64 }, { i8**, i64 }* %parameters
  %t11 = extractvalue { i8**, i64 } %t10, 0
  %t12 = extractvalue { i8**, i64 } %t10, 1
  %t13 = icmp uge i64 %t9, %t12
  ; bounds check: %t13 (if true, out of bounds)
  %t14 = getelementptr i8*, i8** %t11, i64 %t9
  %t15 = load i8*, i8** %t14
  store i8* %t15, i8** %l2
  %t16 = load i8*, i8** %l2
  store i8* null, i8** %l3
  %t17 = load i8*, i8** %l2
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t19 = load i8*, i8** %l3
  %t20 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t18, i8* %t19)
  store { i8**, i64 }* %t20, { i8**, i64 }** %l0
  %t21 = load double, double* %l1
  %t22 = sitofp i64 1 to double
  %t23 = fadd double %t21, %t22
  store double %t23, double* %l1
  br label %loop.latch2
loop.latch2:
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t25 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t28
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
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %s29 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.29, i32 0, i32 0
  %t30 = call i8* @join_with_separator({ i8**, i64 }* %t28, i8* %s29)
  ret i8* %t30
}

define i1 @is_identifier_char(i8* %ch) {
entry:
  %l0 = alloca double
  %s0 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.0, i32 0, i32 0
  %t1 = call double @char_code(i8* %ch)
  store double %t1, double* %l0
  %t2 = load double, double* %l0
  %t3 = load double, double* %l0
  %t4 = load double, double* %l0
  ret i1 0
}

define i1 @is_whitespace_char(i8* %ch) {
entry:
  %s0 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.0, i32 0, i32 0
  %s1 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.1, i32 0, i32 0
  %s2 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.2, i32 0, i32 0
  %s3 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.3, i32 0, i32 0
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
  %t11 = load i8, i8* %l2
  br label %afterloop3
loop.latch2:
  br label %loop.header0
afterloop3:
  %t12 = load double, double* %l0
  %t13 = load double, double* %l1
  br label %loop.header6
loop.header6:
  br label %loop.body7
loop.body7:
  %t14 = load double, double* %l1
  %t15 = load double, double* %l0
  %t16 = fcmp ole double %t14, %t15
  %t17 = load double, double* %l0
  %t18 = load double, double* %l1
  br i1 %t16, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  store double 0.0, double* %l3
  %t19 = load double, double* %l3
  br label %afterloop9
loop.latch8:
  br label %loop.header6
afterloop9:
  %t20 = load double, double* %l0
  %t21 = load double, double* %l0
  %t22 = load double, double* %l1
  %t23 = call double @substring(i8* %value, double %t21, double %t22)
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
  %t13 = phi double [ %t1, %entry ], [ %t12, %loop.latch2 ]
  store double %t13, double* %l0
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  %t3 = load double, double* %l0
  %t4 = getelementptr i8, i8* %value, i64 %t3
  %t5 = load i8, i8* %t4
  %t6 = load double, double* %l0
  %t7 = getelementptr i8, i8* %prefix, i64 %t6
  %t8 = load i8, i8* %t7
  %t9 = load double, double* %l0
  %t10 = sitofp i64 1 to double
  %t11 = fadd double %t9, %t10
  store double %t11, double* %l0
  br label %loop.latch2
loop.latch2:
  %t12 = load double, double* %l0
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
  %t1 = extractvalue { i8**, i64 } %t0, 0
  %t2 = extractvalue { i8**, i64 } %t0, 1
  %t3 = icmp uge i64 0, %t2
  ; bounds check: %t3 (if true, out of bounds)
  %t4 = getelementptr i8*, i8** %t1, i64 0
  %t5 = load i8*, i8** %t4
  store i8* %t5, i8** %l0
  %t6 = sitofp i64 1 to double
  store double %t6, double* %l1
  %t7 = load i8*, i8** %l0
  %t8 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t25 = phi i8* [ %t7, %entry ], [ %t23, %loop.latch2 ]
  %t26 = phi double [ %t8, %entry ], [ %t24, %loop.latch2 ]
  store i8* %t25, i8** %l0
  store double %t26, double* %l1
  br label %loop.body1
loop.body1:
  %t9 = load double, double* %l1
  %t10 = load i8*, i8** %l0
  %t11 = add i8* %t10, %separator
  %t12 = load double, double* %l1
  %t13 = load { i8**, i64 }, { i8**, i64 }* %values
  %t14 = extractvalue { i8**, i64 } %t13, 0
  %t15 = extractvalue { i8**, i64 } %t13, 1
  %t16 = icmp uge i64 %t12, %t15
  ; bounds check: %t16 (if true, out of bounds)
  %t17 = getelementptr i8*, i8** %t14, i64 %t12
  %t18 = load i8*, i8** %t17
  %t19 = add i8* %t11, %t18
  store i8* %t19, i8** %l0
  %t20 = load double, double* %l1
  %t21 = sitofp i64 1 to double
  %t22 = fadd double %t20, %t21
  store double %t22, double* %l1
  br label %loop.latch2
loop.latch2:
  %t23 = load i8*, i8** %l0
  %t24 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t27 = load i8*, i8** %l0
  ret i8* %t27
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
