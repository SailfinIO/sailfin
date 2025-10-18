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
@.str.61 = private unnamed_addr constant [12 x i8] c"__all__ = [\00"
@.str.0 = private unnamed_addr constant [7 x i8] c"class \00"
@.str.9 = private unnamed_addr constant [18 x i8] c"def __init__(self\00"
@.str.13 = private unnamed_addr constant [2 x i8] c":\00"
@.str.23 = private unnamed_addr constant [20 x i8] c"def __repr__(self):\00"
@.str.16 = private unnamed_addr constant [96 x i8] c"return runtime.struct_repr('\22 + class_name + \22', [\22 + join_with_separator(rendered, \22, \22) + \22])\00"
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

define %LoweredPythonResult @lower_to_python(double %native_module) {
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

define %PythonModuleEmission @emit_python_module(double %functions, double %imports, double %structs, double %enums, double %bindings) {
entry:
  %l0 = alloca %PythonBuilder
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca double
  %l4 = alloca double
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
  %t38 = phi %PythonBuilder [ %t24, %entry ], [ %t36, %loop.latch2 ]
  %t39 = phi { i8**, i64 }* [ %t25, %entry ], [ %t37, %loop.latch2 ]
  store %PythonBuilder %t38, %PythonBuilder* %l0
  store { i8**, i64 }* %t39, { i8**, i64 }** %l1
  br label %loop.body1
loop.body1:
  %t28 = load double, double* %l3
  %t29 = load %PythonBuilder, %PythonBuilder* %l0
  %t30 = load double, double* %l3
  store double 0.0, double* %l4
  %t31 = load double, double* %l4
  %t32 = load double, double* %l4
  %t33 = load double, double* %l3
  %t34 = sitofp i64 1 to double
  %t35 = fadd double %t33, %t34
  br label %loop.latch2
loop.latch2:
  %t36 = load %PythonBuilder, %PythonBuilder* %l0
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %loop.header0
afterloop3:
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t41 = load %PythonBuilder, %PythonBuilder* %l0
  %t42 = insertvalue %PythonModuleEmission undef, i8* null, 0
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t44 = insertvalue %PythonModuleEmission %t42, { i8**, i64 }* %t43, 1
  ret %PythonModuleEmission %t44
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

define %PythonBuilder @emit_top_level_bindings(%PythonBuilder %builder, double %bindings) {
entry:
  %l0 = alloca %PythonBuilder
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i8*
  store %PythonBuilder %builder, %PythonBuilder* %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load %PythonBuilder, %PythonBuilder* %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t13 = phi %PythonBuilder [ %t1, %entry ], [ %t12, %loop.latch2 ]
  store %PythonBuilder %t13, %PythonBuilder* %l0
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load double, double* %l1
  store double 0.0, double* %l2
  %t5 = load double, double* %l2
  store double 0.0, double* %l3
  %t6 = load double, double* %l3
  %s7 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.7, i32 0, i32 0
  store i8* null, i8** %l4
  %t8 = load double, double* %l2
  %t9 = load %PythonBuilder, %PythonBuilder* %l0
  %t10 = load i8*, i8** %l4
  %t11 = call %PythonBuilder @builder_emit(%PythonBuilder %t9, i8* %t10)
  store %PythonBuilder %t11, %PythonBuilder* %l0
  br label %loop.latch2
loop.latch2:
  %t12 = load %PythonBuilder, %PythonBuilder* %l0
  br label %loop.header0
afterloop3:
  %t14 = load %PythonBuilder, %PythonBuilder* %l0
  ret %PythonBuilder %t14
}

define %PythonImportEmission @emit_python_imports(%PythonBuilder %builder, double %imports) {
entry:
  %l0 = alloca %PythonBuilder
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca double
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
  br label %loop.body1
loop.body1:
  %t9 = load double, double* %l2
  %t10 = load double, double* %l2
  store double 0.0, double* %l3
  %t11 = load double, double* %l3
  %t12 = load double, double* %l3
  %t13 = call i8* @render_python_import(double %t12)
  store i8* %t13, i8** %l4
  %t14 = load i8*, i8** %l4
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t15 = load %PythonBuilder, %PythonBuilder* %l0
  %t16 = insertvalue %PythonImportEmission undef, i8* null, 0
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t18 = insertvalue %PythonImportEmission %t16, { i8**, i64 }* %t17, 1
  ret %PythonImportEmission %t18
}

define %PythonBuilder @emit_enum_definitions(%PythonBuilder %builder, double %enums) {
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
  %t10 = phi %PythonBuilder [ %t1, %entry ], [ %t9, %loop.latch2 ]
  store %PythonBuilder %t10, %PythonBuilder* %l0
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load %PythonBuilder, %PythonBuilder* %l0
  %t5 = load double, double* %l1
  %t6 = load double, double* %l1
  %t7 = sitofp i64 1 to double
  %t8 = fadd double %t6, %t7
  br label %loop.latch2
loop.latch2:
  %t9 = load %PythonBuilder, %PythonBuilder* %l0
  br label %loop.header0
afterloop3:
  %t11 = load %PythonBuilder, %PythonBuilder* %l0
  ret %PythonBuilder %t11
}

define %PythonBuilder @emit_single_enum(%PythonBuilder %builder, double %definition) {
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
  %t14 = phi double [ %t4, %entry ], [ %t13, %loop.latch2 ]
  store double %t14, double* %l1
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
  br label %loop.latch2
loop.latch2:
  %t13 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t15 = load double, double* %l1
  ret %PythonBuilder zeroinitializer
}

define i8* @render_enum_variant_fields(double %fields) {
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
  %t13 = phi { i8**, i64 }* [ %t6, %entry ], [ %t12, %loop.latch2 ]
  store { i8**, i64 }* %t13, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s10 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.10, i32 0, i32 0
  %t11 = load double, double* %l1
  br label %loop.latch2
loop.latch2:
  %t12 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret i8* null
}

define i8* @render_python_import(double %entry) {
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

define i8* @render_python_specifiers(double %specifiers) {
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
  %t12 = phi { i8**, i64 }* [ %t6, %entry ], [ %t11, %loop.latch2 ]
  store { i8**, i64 }* %t12, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t10 = load double, double* %l1
  br label %loop.latch2
loop.latch2:
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret i8* null
}

define i8* @render_python_specifier(double %specifier) {
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

define %PythonStructEmission @emit_struct_definitions(%PythonBuilder %builder, double %structs) {
entry:
  %l0 = alloca %PythonBuilder
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca double
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
  %t19 = phi %PythonBuilder [ %t6, %entry ], [ %t17, %loop.latch2 ]
  %t20 = phi { i8**, i64 }* [ %t7, %entry ], [ %t18, %loop.latch2 ]
  store %PythonBuilder %t19, %PythonBuilder* %l0
  store { i8**, i64 }* %t20, { i8**, i64 }** %l1
  br label %loop.body1
loop.body1:
  %t9 = load double, double* %l2
  %t10 = load %PythonBuilder, %PythonBuilder* %l0
  %t11 = load double, double* %l2
  store double 0.0, double* %l3
  %t12 = load double, double* %l3
  %t13 = load double, double* %l3
  %t14 = load double, double* %l2
  %t15 = sitofp i64 1 to double
  %t16 = fadd double %t14, %t15
  br label %loop.latch2
loop.latch2:
  %t17 = load %PythonBuilder, %PythonBuilder* %l0
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %loop.header0
afterloop3:
  %t21 = load %PythonBuilder, %PythonBuilder* %l0
  %t22 = insertvalue %PythonStructEmission undef, i8* null, 0
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t24 = insertvalue %PythonStructEmission %t22, { i8**, i64 }* %t23, 1
  ret %PythonStructEmission %t24
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
  br label %loop.latch6
loop.latch6:
  br label %loop.header4
afterloop7:
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t34 = alloca [0 x double]
  %t35 = getelementptr [0 x double], [0 x double]* %t34, i32 0, i32 0
  %t36 = alloca { double*, i64 }
  %t37 = getelementptr { double*, i64 }, { double*, i64 }* %t36, i32 0, i32 0
  store double* %t35, double** %t37
  %t38 = getelementptr { double*, i64 }, { double*, i64 }* %t36, i32 0, i32 1
  store i64 0, i64* %t38
  store { i8**, i64 }* null, { i8**, i64 }** %l5
  %t39 = sitofp i64 0 to double
  store double %t39, double* %l1
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t41 = load double, double* %l1
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l5
  br label %loop.header8
loop.header8:
  %t60 = phi { i8**, i64 }* [ %t42, %entry ], [ %t59, %loop.latch10 ]
  store { i8**, i64 }* %t60, { i8**, i64 }** %l5
  br label %loop.body9
loop.body9:
  %t43 = load double, double* %l1
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %s46 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.46, i32 0, i32 0
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t48 = load double, double* %l1
  %t49 = load { i8**, i64 }, { i8**, i64 }* %t47
  %t50 = extractvalue { i8**, i64 } %t49, 0
  %t51 = extractvalue { i8**, i64 } %t49, 1
  %t52 = icmp uge i64 %t48, %t51
  ; bounds check: %t52 (if true, out of bounds)
  %t53 = getelementptr i8*, i8** %t50, i64 %t48
  %t54 = load i8*, i8** %t53
  %t55 = add i8* %s46, %t54
  %s56 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.56, i32 0, i32 0
  %t57 = add i8* %t55, %s56
  %t58 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t45, i8* %t57)
  store { i8**, i64 }* %t58, { i8**, i64 }** %l5
  br label %loop.latch10
loop.latch10:
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l5
  br label %loop.header8
afterloop11:
  %s61 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.61, i32 0, i32 0
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l5
  ret %PythonBuilder zeroinitializer
}

define { i8**, i64 }* @collect_export_names({ i8**, i64 }* %existing, double %specifiers) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca i8*
  store { i8**, i64 }* %existing, { i8**, i64 }** %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load double, double* %l1
  store double 0.0, double* %l2
  %t5 = load double, double* %l2
  %t6 = call i8* @select_export_name(double %t5)
  store i8* %t6, i8** %l3
  %t7 = load i8*, i8** %l3
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t8 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t8
}

define i8* @select_export_name(double %specifier) {
entry:
  ret i8* null
}

define %PythonStructEmission @emit_single_struct(%PythonBuilder %builder, double %definition) {
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

define { i8**, i64 }* @render_struct_parameters(double %fields) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca double
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
  br label %loop.body1
loop.body1:
  %t14 = load double, double* %l2
  %t15 = load double, double* %l2
  store double 0.0, double* %l3
  %t16 = load double, double* %l3
  store double 0.0, double* %l4
  %t17 = load double, double* %l4
  store i8* null, i8** %l5
  %t18 = load double, double* %l3
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t20 = call double @requiredconcat({ i8**, i64 }* %t19)
  ret { i8**, i64 }* null
}

define i8* @render_struct_repr_fields(i8* %class_name, double %fields) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca double
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
  %t15 = phi { i8**, i64 }* [ %t6, %entry ], [ %t14, %loop.latch2 ]
  store { i8**, i64 }* %t15, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load double, double* %l1
  store double 0.0, double* %l2
  %t10 = load double, double* %l2
  store double 0.0, double* %l3
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s12 = getelementptr inbounds [56 x i8], [56 x i8]* @.str.12, i32 0, i32 0
  %t13 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t11, i8* %s12)
  store { i8**, i64 }* %t13, { i8**, i64 }** %l0
  br label %loop.latch2
loop.latch2:
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %s16 = getelementptr inbounds [96 x i8], [96 x i8]* @.str.16, i32 0, i32 0
  ret i8* %s16
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
  br label %loop.latch2
merge5:
  ret i1 0
loop.latch2:
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
  %t137 = phi double [ %t2, %entry ], [ %t135, %loop.latch2 ]
  %t138 = phi i8* [ %t1, %entry ], [ %t136, %loop.latch2 ]
  store double %t137, double* %l1
  store i8* %t138, i8** %l0
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
  br label %loop.latch8
merge13:
  br label %afterloop9
loop.latch8:
  br label %loop.header6
afterloop9:
  %t35 = load double, double* %l3
  store double %t35, double* %l5
  %t36 = load i8*, i8** %l0
  %t37 = load double, double* %l1
  %t38 = load double, double* %l2
  %t39 = load double, double* %l3
  %t40 = load double, double* %l5
  br label %loop.header14
loop.header14:
  br label %loop.body15
loop.body15:
  %t41 = load double, double* %l5
  %t42 = sitofp i64 0 to double
  %t43 = fcmp ole double %t41, %t42
  %t44 = load i8*, i8** %l0
  %t45 = load double, double* %l1
  %t46 = load double, double* %l2
  %t47 = load double, double* %l3
  %t48 = load double, double* %l5
  br i1 %t43, label %then18, label %merge19
then18:
  br label %afterloop17
merge19:
  store double 0.0, double* %l6
  %t49 = load double, double* %l6
  %s50 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.50, i32 0, i32 0
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
  br label %loop.latch16
merge21:
  br label %afterloop17
loop.latch16:
  br label %loop.header14
afterloop17:
  %t60 = load double, double* %l5
  %t61 = load double, double* %l3
  %t62 = fcmp oeq double %t60, %t61
  %t63 = load i8*, i8** %l0
  %t64 = load double, double* %l1
  %t65 = load double, double* %l2
  %t66 = load double, double* %l3
  %t67 = load double, double* %l5
  br i1 %t62, label %then22, label %merge23
then22:
  %t68 = load double, double* %l2
  %t69 = sitofp i64 1 to double
  %t70 = fadd double %t68, %t69
  store double %t70, double* %l1
  br label %loop.latch2
merge23:
  %t71 = load i8*, i8** %l0
  %t72 = load double, double* %l5
  %t73 = load double, double* %l3
  %t74 = call double @substring(i8* %t71, double %t72, double %t73)
  store double %t74, double* %l7
  %t75 = load double, double* %l7
  %t76 = call double @is_struct_literal_type_candidate(double %t75)
  %t77 = fcmp one double %t76, 0.0
  %t78 = load i8*, i8** %l0
  %t79 = load double, double* %l1
  %t80 = load double, double* %l2
  %t81 = load double, double* %l3
  %t82 = load double, double* %l5
  %t83 = load double, double* %l7
  br i1 %t77, label %then24, label %merge25
then24:
  %t84 = load double, double* %l2
  %t85 = sitofp i64 1 to double
  %t86 = fadd double %t84, %t85
  store double %t86, double* %l1
  br label %loop.latch2
merge25:
  %t87 = load double, double* %l5
  %t88 = sitofp i64 0 to double
  %t89 = fcmp ogt double %t87, %t88
  %t90 = load i8*, i8** %l0
  %t91 = load double, double* %l1
  %t92 = load double, double* %l2
  %t93 = load double, double* %l3
  %t94 = load double, double* %l5
  %t95 = load double, double* %l7
  br i1 %t89, label %then26, label %merge27
then26:
  store double 0.0, double* %l8
  br label %merge27
merge27:
  %t96 = load i8*, i8** %l0
  %t97 = load double, double* %l2
  %t98 = call double @find_matching_brace(i8* %t96, double %t97)
  store double %t98, double* %l9
  %t99 = load double, double* %l9
  %t100 = sitofp i64 0 to double
  %t101 = fcmp olt double %t99, %t100
  %t102 = load i8*, i8** %l0
  %t103 = load double, double* %l1
  %t104 = load double, double* %l2
  %t105 = load double, double* %l3
  %t106 = load double, double* %l5
  %t107 = load double, double* %l7
  %t108 = load double, double* %l9
  br i1 %t101, label %then28, label %merge29
then28:
  br label %afterloop3
merge29:
  %t109 = load i8*, i8** %l0
  %t110 = load double, double* %l5
  %t111 = load double, double* %l9
  %t112 = sitofp i64 1 to double
  %t113 = fadd double %t111, %t112
  %t114 = call double @substring(i8* %t109, double %t110, double %t113)
  store double %t114, double* %l10
  %t115 = load double, double* %l10
  %t116 = sitofp i64 1 to double
  %t117 = fadd double %depth, %t116
  %t118 = call double @lower_struct_literal_expression(i8* null, double %t117)
  store double %t118, double* %l11
  %t119 = load double, double* %l11
  %t120 = load i8*, i8** %l0
  %t121 = load double, double* %l5
  %t122 = call double @substring(i8* %t120, i64 0, double %t121)
  store double %t122, double* %l12
  %t123 = load i8*, i8** %l0
  %t124 = load double, double* %l9
  %t125 = sitofp i64 1 to double
  %t126 = fadd double %t124, %t125
  %t127 = load i8*, i8** %l0
  store double 0.0, double* %l13
  %t128 = load double, double* %l12
  %t129 = load double, double* %l11
  %t130 = fadd double %t128, %t129
  %t131 = load double, double* %l13
  %t132 = fadd double %t130, %t131
  store i8* null, i8** %l0
  %t133 = load double, double* %l5
  %t134 = load double, double* %l11
  br label %loop.latch2
loop.latch2:
  %t135 = load double, double* %l1
  %t136 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t139 = load i8*, i8** %l0
  ret i8* %t139
}

define %StructLiteralCapture @capture_struct_literal_expression(i8* %initial, double %instructions, double %start_index) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
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
  br label %loop.body5
loop.body5:
  %t33 = load double, double* %l2
  %t34 = load double, double* %l2
  store double 0.0, double* %l5
  %t35 = load double, double* %l5
  %t36 = load double, double* %l5
  store double 0.0, double* %l6
  %t37 = load double, double* %l6
  %t38 = load double, double* %l4
  %t39 = sitofp i64 0 to double
  %t40 = fcmp ole double %t38, %t39
  %t41 = load i8*, i8** %l0
  %t42 = load i8*, i8** %l1
  %t43 = load double, double* %l2
  %t44 = load double, double* %l3
  %t45 = load double, double* %l4
  %t46 = load double, double* %l5
  %t47 = load double, double* %l6
  br i1 %t40, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  br label %loop.latch6
loop.latch6:
  br label %loop.header4
afterloop7:
  %t48 = load double, double* %l4
  %t49 = sitofp i64 0 to double
  %t50 = fcmp une double %t48, %t49
  %t51 = load i8*, i8** %l0
  %t52 = load i8*, i8** %l1
  %t53 = load double, double* %l2
  %t54 = load double, double* %l3
  %t55 = load double, double* %l4
  br i1 %t50, label %then10, label %merge11
then10:
  %t56 = load i8*, i8** %l0
  %t57 = insertvalue %StructLiteralCapture undef, i8* %t56, 0
  %t58 = sitofp i64 0 to double
  %t59 = insertvalue %StructLiteralCapture %t57, double %t58, 1
  %t60 = insertvalue %StructLiteralCapture %t59, i1 0, 2
  ret %StructLiteralCapture %t60
merge11:
  %t61 = load double, double* %l3
  %t62 = sitofp i64 0 to double
  %t63 = fcmp oeq double %t61, %t62
  %t64 = load i8*, i8** %l0
  %t65 = load i8*, i8** %l1
  %t66 = load double, double* %l2
  %t67 = load double, double* %l3
  %t68 = load double, double* %l4
  br i1 %t63, label %then12, label %merge13
then12:
  %t69 = load i8*, i8** %l0
  %t70 = insertvalue %StructLiteralCapture undef, i8* %t69, 0
  %t71 = sitofp i64 0 to double
  %t72 = insertvalue %StructLiteralCapture %t70, double %t71, 1
  %t73 = insertvalue %StructLiteralCapture %t72, i1 0, 2
  ret %StructLiteralCapture %t73
merge13:
  %t74 = load i8*, i8** %l1
  %t75 = call i8* @trim_text(i8* %t74)
  %t76 = call i8* @trim_trailing_delimiters(i8* %t75)
  store i8* %t76, i8** %l7
  %t77 = load i8*, i8** %l7
  %s78 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.78, i32 0, i32 0
  %t79 = call double @ends_with(i8* %t77, i8* %s78)
  %t80 = fcmp one double %t79, 0.0
  %t81 = load i8*, i8** %l0
  %t82 = load i8*, i8** %l1
  %t83 = load double, double* %l2
  %t84 = load double, double* %l3
  %t85 = load double, double* %l4
  %t86 = load i8*, i8** %l7
  br i1 %t80, label %then14, label %merge15
then14:
  %t87 = load i8*, i8** %l0
  %t88 = insertvalue %StructLiteralCapture undef, i8* %t87, 0
  %t89 = sitofp i64 0 to double
  %t90 = insertvalue %StructLiteralCapture %t88, double %t89, 1
  %t91 = insertvalue %StructLiteralCapture %t90, i1 0, 2
  ret %StructLiteralCapture %t91
merge15:
  %t92 = load i8*, i8** %l7
  %t93 = insertvalue %StructLiteralCapture undef, i8* %t92, 0
  %t94 = load double, double* %l3
  %t95 = insertvalue %StructLiteralCapture %t93, double %t94, 1
  %t96 = insertvalue %StructLiteralCapture %t95, i1 1, 2
  ret %StructLiteralCapture %t96
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
  %t18 = phi i8* [ %t2, %entry ], [ %t17, %loop.latch2 ]
  store i8* %t18, i8** %l0
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
  br label %loop.latch2
loop.latch2:
  %t17 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t19 = load i8*, i8** %l0
  ret i8* %t19
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
  %t39 = phi i8* [ %t2, %entry ], [ %t38, %loop.latch2 ]
  store i8* %t39, i8** %l0
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
  br label %loop.body7
loop.body7:
  %t19 = load double, double* %l1
  %t20 = load double, double* %l1
  %t21 = getelementptr i8, i8* %expression, i64 %t20
  %t22 = load i8, i8* %t21
  store i8 %t22, i8* %l4
  %t23 = load i8, i8* %l4
  %t24 = call double @is_identifier_char(i8 %t23)
  %t25 = fcmp one double %t24, 0.0
  %t26 = load i8*, i8** %l0
  %t27 = load double, double* %l1
  %t28 = load i8, i8* %l2
  %t29 = load double, double* %l3
  %t30 = load i8, i8* %l4
  br i1 %t25, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  br label %loop.latch8
loop.latch8:
  br label %loop.header6
afterloop9:
  %t31 = load double, double* %l3
  %t32 = load double, double* %l1
  %t33 = call double @substring(i8* %expression, double %t31, double %t32)
  store double %t33, double* %l5
  %t34 = load double, double* %l5
  %s35 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.35, i32 0, i32 0
  br label %loop.latch2
merge5:
  %t36 = load i8*, i8** %l0
  %t37 = load i8, i8* %l2
  br label %loop.latch2
loop.latch2:
  %t38 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t40 = load i8*, i8** %l0
  ret i8* %t40
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
  %t18 = phi i8* [ %t6, %entry ], [ %t17, %loop.latch2 ]
  store i8* %t18, i8** %l2
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
  br label %loop.latch2
loop.latch2:
  %t17 = load i8*, i8** %l2
  br label %loop.header0
afterloop3:
  %t19 = load i8*, i8** %l2
  ret i8* %t19
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
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l0
  %t9 = load double, double* %l0
  %t10 = getelementptr i8, i8* %text, i64 %t9
  %t11 = load i8, i8* %t10
  store i8 %t11, i8* %l2
  %t12 = load i8, i8* %l2
  %s13 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.13, i32 0, i32 0
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %s14 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.14, i32 0, i32 0
  %t15 = insertvalue %ExtractedSpan undef, i8* %s14, 0
  %t16 = insertvalue %ExtractedSpan %t15, double %open_index, 1
  %t17 = insertvalue %ExtractedSpan %t16, double %open_index, 2
  %t18 = insertvalue %ExtractedSpan %t17, i1 0, 3
  ret %ExtractedSpan %t18
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
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t14 = load double, double* %l1
  ret double %t14
}

define %ExpressionContinuationCapture @capture_expression_continuation(i8* %initial, double %instructions, double %start_index) {
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
  %t32 = phi i8* [ %t15, %entry ], [ %t31, %loop.latch2 ]
  store i8* %t32, i8** %l4
  br label %loop.body1
loop.body1:
  %t19 = load double, double* %l5
  %t20 = load double, double* %l5
  store double 0.0, double* %l8
  %t21 = load double, double* %l8
  %t22 = load double, double* %l8
  %t23 = call i8* @trim_text(i8* null)
  store i8* %t23, i8** %l9
  %t24 = load i8*, i8** %l9
  %t25 = load i8*, i8** %l4
  %s26 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.26, i32 0, i32 0
  %t27 = add i8* %t25, %s26
  %t28 = load i8*, i8** %l9
  %t29 = add i8* %t27, %t28
  store i8* %t29, i8** %l4
  %t30 = load double, double* %l1
  br label %loop.latch2
loop.latch2:
  %t31 = load i8*, i8** %l4
  br label %loop.header0
afterloop3:
  %t33 = load double, double* %l1
  %t34 = load i8*, i8** %l0
  %t35 = insertvalue %ExpressionContinuationCapture undef, i8* %t34, 0
  %t36 = sitofp i64 0 to double
  %t37 = insertvalue %ExpressionContinuationCapture %t35, double %t36, 1
  %t38 = insertvalue %ExpressionContinuationCapture %t37, i1 0, 2
  ret %ExpressionContinuationCapture %t38
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
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  %t5 = load double, double* %l1
  %t6 = getelementptr i8, i8* %text, i64 %t5
  %t7 = load i8, i8* %t6
  store i8 %t7, i8* %l2
  %t8 = load i8, i8* %l2
  %s9 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.9, i32 0, i32 0
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t10 = load double, double* %l0
  ret double %t10
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
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  %t5 = load double, double* %l1
  %t6 = getelementptr i8, i8* %text, i64 %t5
  %t7 = load i8, i8* %t6
  store i8 %t7, i8* %l2
  %t8 = load i8, i8* %l2
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t9 = load double, double* %l0
  ret double %t9
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
  %t35 = phi i8* [ %t10, %entry ], [ %t34, %loop.latch2 ]
  store i8* %t35, i8** %l1
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
  br label %loop.latch2
merge5:
  %t31 = load i8, i8* %l6
  %t32 = load i8, i8* %l6
  %t33 = load i8, i8* %l6
  br label %loop.latch2
loop.latch2:
  %t34 = load i8*, i8** %l1
  br label %loop.header0
afterloop3:
  %t36 = load i8*, i8** %l1
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t37
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
  %t35 = phi i8* [ %t10, %entry ], [ %t34, %loop.latch2 ]
  store i8* %t35, i8** %l1
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
  br label %loop.latch2
merge5:
  %t31 = load i8, i8* %l6
  %t32 = load i8, i8* %l6
  %t33 = load i8, i8* %l6
  br label %loop.latch2
loop.latch2:
  %t34 = load i8*, i8** %l1
  br label %loop.header0
afterloop3:
  %t36 = load i8*, i8** %l1
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t37
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
  br label %loop.body5
loop.body5:
  %t7 = load double, double* %l1
  br label %loop.latch6
loop.latch6:
  br label %loop.header4
afterloop7:
  %t8 = load i1, i1* %l2
  %t9 = load double, double* %l0
  %t10 = load double, double* %l1
  %t11 = load i1, i1* %l2
  br i1 %t8, label %then8, label %merge9
then8:
  %t12 = load double, double* %l0
  ret double %t12
merge9:
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t13 = sitofp i64 -1 to double
  ret double %t13
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
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load double, double* %l1
  %t5 = getelementptr i8, i8* %text, i64 %t4
  %t6 = load i8, i8* %t5
  store i8 %t6, i8* %l2
  %t7 = load i8, i8* %l2
  %s8 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.8, i32 0, i32 0
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t9 = sitofp i64 -1 to double
  ret double %t9
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
  %t16 = load double, double* %l1
  br label %loop.latch4
loop.latch4:
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
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t11 = sitofp i64 -1 to double
  ret double %t11
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
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t13 = sitofp i64 -1 to double
  ret double %t13
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
  br label %loop.body7
loop.body7:
  %t12 = load double, double* %l2
  br label %loop.latch8
loop.latch8:
  br label %loop.header6
afterloop9:
  %t13 = load i1, i1* %l1
  %t14 = load double, double* %l0
  %t15 = load i1, i1* %l1
  %t16 = load double, double* %l2
  br i1 %t13, label %then10, label %merge11
then10:
  %t17 = load double, double* %l0
  ret double %t17
merge11:
  br label %loop.latch4
loop.latch4:
  br label %loop.header2
afterloop5:
  %t18 = sitofp i64 -1 to double
  ret double %t18
}

define %PythonFunctionEmission @emit_python_function(%PythonBuilder %builder, double %function) {
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
  br label %loop.body1
loop.body1:
  %t27 = load double, double* %l7
  store double 0.0, double* %l8
  %t28 = load double, double* %l8
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t29 = load %PythonBuilder, %PythonBuilder* %l0
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t31 = load double, double* %l2
  %t32 = load double, double* %l3
  %t33 = load double, double* %l4
  %t34 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t35 = load double, double* %l6
  %t36 = load double, double* %l7
  br label %loop.header4
loop.header4:
  %t70 = phi %PythonBuilder [ %t29, %entry ], [ %t67, %loop.latch6 ]
  %t71 = phi { i8**, i64 }* [ %t30, %entry ], [ %t68, %loop.latch6 ]
  %t72 = phi { %MatchContext*, i64 }* [ %t34, %entry ], [ %t69, %loop.latch6 ]
  store %PythonBuilder %t70, %PythonBuilder* %l0
  store { i8**, i64 }* %t71, { i8**, i64 }** %l1
  store { %MatchContext*, i64 }* %t72, { %MatchContext*, i64 }** %l5
  br label %loop.body5
loop.body5:
  %t37 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t38 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  store double 0.0, double* %l9
  %t39 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t40 = load double, double* %l9
  %t41 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t39
  %t42 = extractvalue { %MatchContext*, i64 } %t41, 0
  %t43 = extractvalue { %MatchContext*, i64 } %t41, 1
  %t44 = icmp uge i64 %t40, %t43
  ; bounds check: %t44 (if true, out of bounds)
  %t45 = getelementptr %MatchContext, %MatchContext* %t42, i64 %t40
  %t46 = load %MatchContext, %MatchContext* %t45
  store %MatchContext %t46, %MatchContext* %l10
  %t47 = load %MatchContext, %MatchContext* %l10
  %t48 = extractvalue %MatchContext %t47, 2
  %t49 = load %PythonBuilder, %PythonBuilder* %l0
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t51 = load double, double* %l2
  %t52 = load double, double* %l3
  %t53 = load double, double* %l4
  %t54 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t55 = load double, double* %l6
  %t56 = load double, double* %l7
  %t57 = load double, double* %l9
  %t58 = load %MatchContext, %MatchContext* %l10
  br i1 %t48, label %then8, label %merge9
then8:
  %t59 = load %PythonBuilder, %PythonBuilder* %l0
  %t60 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t59)
  store %PythonBuilder %t60, %PythonBuilder* %l0
  br label %merge9
merge9:
  %t61 = phi %PythonBuilder [ %t60, %then8 ], [ %t49, %loop.body5 ]
  store %PythonBuilder %t61, %PythonBuilder* %l0
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s63 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.63, i32 0, i32 0
  %t64 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t65 = load double, double* %l9
  %t66 = call { %MatchContext*, i64 }* @truncate_match_contexts({ %MatchContext*, i64 }* %t64, double %t65)
  store { %MatchContext*, i64 }* %t66, { %MatchContext*, i64 }** %l5
  br label %loop.latch6
loop.latch6:
  %t67 = load %PythonBuilder, %PythonBuilder* %l0
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t69 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  br label %loop.header4
afterloop7:
  %t73 = load %PythonBuilder, %PythonBuilder* %l0
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t75 = load double, double* %l2
  %t76 = load double, double* %l3
  %t77 = load double, double* %l4
  %t78 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t79 = load double, double* %l6
  %t80 = load double, double* %l7
  br label %loop.header10
loop.header10:
  %t98 = phi %PythonBuilder [ %t73, %entry ], [ %t96, %loop.latch12 ]
  %t99 = phi { i8**, i64 }* [ %t74, %entry ], [ %t97, %loop.latch12 ]
  store %PythonBuilder %t98, %PythonBuilder* %l0
  store { i8**, i64 }* %t99, { i8**, i64 }** %l1
  br label %loop.body11
loop.body11:
  %t81 = load double, double* %l4
  %t82 = sitofp i64 0 to double
  %t83 = fcmp ole double %t81, %t82
  %t84 = load %PythonBuilder, %PythonBuilder* %l0
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t86 = load double, double* %l2
  %t87 = load double, double* %l3
  %t88 = load double, double* %l4
  %t89 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t90 = load double, double* %l6
  %t91 = load double, double* %l7
  br i1 %t83, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t92 = load %PythonBuilder, %PythonBuilder* %l0
  %t93 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t92)
  store %PythonBuilder %t93, %PythonBuilder* %l0
  %t94 = load double, double* %l4
  %t95 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %loop.latch12
loop.latch12:
  %t96 = load %PythonBuilder, %PythonBuilder* %l0
  %t97 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %loop.header10
afterloop13:
  %t100 = load %PythonBuilder, %PythonBuilder* %l0
  %t101 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t100)
  store %PythonBuilder %t101, %PythonBuilder* %l0
  %t102 = load %PythonBuilder, %PythonBuilder* %l0
  %t103 = insertvalue %PythonFunctionEmission undef, i8* null, 0
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t105 = insertvalue %PythonFunctionEmission %t103, { i8**, i64 }* %t104, 1
  ret %PythonFunctionEmission %t105
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
  %t26 = phi { %MatchContext*, i64 }* [ %t6, %entry ], [ %t25, %loop.latch2 ]
  store { %MatchContext*, i64 }* %t26, { %MatchContext*, i64 }** %l0
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
  br label %loop.latch2
loop.latch2:
  %t25 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t27 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  ret { %MatchContext*, i64 }* %t27
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
  %t29 = phi { %MatchContext*, i64 }* [ %t13, %entry ], [ %t28, %loop.latch4 ]
  store { %MatchContext*, i64 }* %t29, { %MatchContext*, i64 }** %l0
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
  br label %loop.latch4
loop.latch4:
  %t28 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  br label %loop.header2
afterloop5:
  %t30 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  ret { %MatchContext*, i64 }* %t30
}

define i8* @generate_match_subject_name(double %counter) {
entry:
  %s0 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.0, i32 0, i32 0
  %t1 = call i8* @number_to_string(double %counter)
  %t2 = add i8* %s0, %t1
  ret i8* %t2
}

define %LoweredCaseCondition @lower_match_case_condition(i8* %subject_name, i8* %pattern, double %guard) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca i8*
  %l4 = alloca i1
  %t0 = call i8* @trim_text(i8* %pattern)
  store i8* %t0, i8** %l0
  store double 0.0, double* %l1
  %t1 = load i8*, i8** %l0
  %t2 = load i8*, i8** %l0
  %t3 = call i8* @lower_expression(i8* %t2)
  store i8* %t3, i8** %l2
  store i8* null, i8** %l3
  store i1 0, i1* %l4
  %t4 = load double, double* %l1
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
  %t42 = phi i8* [ %t7, %entry ], [ %t40, %loop.latch4 ]
  %t43 = phi double [ %t6, %entry ], [ %t41, %loop.latch4 ]
  store i8* %t42, i8** %l2
  store double %t43, double* %l1
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
  br label %loop.latch10
loop.latch10:
  br label %loop.header8
afterloop11:
  %t30 = load double, double* %l3
  store double %t30, double* %l5
  %t31 = load i8*, i8** %l0
  %t32 = load double, double* %l5
  %t33 = load double, double* %l5
  %t34 = sitofp i64 1 to double
  %t35 = fadd double %t33, %t34
  %t36 = call double @substring(i8* %t31, double %t32, double %t35)
  store double %t36, double* %l6
  %t37 = load double, double* %l6
  %t38 = load i8*, i8** %l2
  %t39 = load double, double* %l4
  store double %t39, double* %l1
  br label %loop.latch4
loop.latch4:
  %t40 = load i8*, i8** %l2
  %t41 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t44 = load i8*, i8** %l2
  ret i8* %t44
}

define { i8**, i64 }* @render_python_parameters(double %parameters) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca double
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
  %t16 = phi { i8**, i64 }* [ %t6, %entry ], [ %t15, %loop.latch2 ]
  store { i8**, i64 }* %t16, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load double, double* %l1
  store double 0.0, double* %l2
  %t10 = load double, double* %l2
  store i8* null, i8** %l3
  %t11 = load double, double* %l2
  %t12 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t13 = load i8*, i8** %l3
  %t14 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t12, i8* %t13)
  store { i8**, i64 }* %t14, { i8**, i64 }** %l0
  br label %loop.latch2
loop.latch2:
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t17
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
  %t13 = phi i8* [ %t2, %entry ], [ %t12, %loop.latch2 ]
  store i8* %t13, i8** %l0
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
  br label %loop.latch2
loop.latch2:
  %t12 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t14 = load i8*, i8** %l0
  %t15 = add i8* %t14, %line
  store i8* %t15, i8** %l2
  %t16 = extractvalue %PythonBuilder %builder, 0
  %t17 = load i8*, i8** %l2
  %t18 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t16, i8* %t17)
  store { i8**, i64 }* %t18, { i8**, i64 }** %l3
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t20 = insertvalue %PythonBuilder undef, { i8**, i64 }* %t19, 0
  %t21 = extractvalue %PythonBuilder %builder, 1
  %t22 = insertvalue %PythonBuilder %t20, double %t21, 1
  ret %PythonBuilder %t22
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
  br label %merge1
merge1:
  %t6 = extractvalue %PythonBuilder %builder, 0
  %t7 = insertvalue %PythonBuilder undef, { i8**, i64 }* %t6, 0
  %t8 = load double, double* %l0
  %t9 = insertvalue %PythonBuilder %t7, double %t8, 1
  ret %PythonBuilder %t9
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
  %t19 = phi i8* [ %t2, %entry ], [ %t18, %loop.latch2 ]
  store i8* %t19, i8** %l0
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
  br label %loop.latch2
loop.latch2:
  %t18 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t20 = load i8*, i8** %l0
  %t21 = load i8*, i8** %l0
  ret i8* %t21
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
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t21 = load i8*, i8** %l1
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %s24 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.24, i32 0, i32 0
  %t25 = call i8* @join_with_separator({ i8**, i64 }* %t23, i8* %s24)
  ret i8* %t25
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
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  %t3 = load double, double* %l0
  %t4 = getelementptr i8, i8* %value, i64 %t3
  %t5 = load i8, i8* %t4
  %t6 = load double, double* %l0
  %t7 = getelementptr i8, i8* %prefix, i64 %t6
  %t8 = load i8, i8* %t7
  br label %loop.latch2
loop.latch2:
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
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  br label %loop.latch2
loop.latch2:
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
  %t11 = phi i8* [ %t2, %entry ], [ %t10, %loop.latch2 ]
  store i8* %t11, i8** %l0
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  %t5 = load double, double* %l1
  %t6 = load i8*, i8** %l0
  %t7 = load double, double* %l1
  %t8 = getelementptr i8, i8* %value, i64 %t7
  %t9 = load i8, i8* %t8
  br label %loop.latch2
loop.latch2:
  %t10 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t12 = load i8*, i8** %l0
  ret i8* %t12
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
  %t21 = phi i8* [ %t7, %entry ], [ %t20, %loop.latch2 ]
  store i8* %t21, i8** %l0
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
  br label %loop.latch2
loop.latch2:
  %t20 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t22 = load i8*, i8** %l0
  ret i8* %t22
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
