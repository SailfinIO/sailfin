; ModuleID = 'sailfin'
source_filename = "sailfin"

%TextBuilder = type { { i8**, i64 }*, double }

declare noalias i8* @malloc(i64)

@.str.1 = private unnamed_addr constant [10 x i8] c"import { \00"
@.str.4 = private unnamed_addr constant [10 x i8] c" } from \22\00"
@.str.7 = private unnamed_addr constant [3 x i8] c"\22;\00"
@.str.1 = private unnamed_addr constant [10 x i8] c"export { \00"
@.str.0 = private unnamed_addr constant [5 x i8] c"let \00"
@.str.5 = private unnamed_addr constant [2 x i8] c";\00"
@.str.0 = private unnamed_addr constant [6 x i8] c"test \00"
@.str.0 = private unnamed_addr constant [7 x i8] c"model \00"
@.str.6 = private unnamed_addr constant [2 x i8] c"{\00"
@.str.30 = private unnamed_addr constant [2 x i8] c"}\00"
@.str.2 = private unnamed_addr constant [5 x i8] c" as \00"
@.str.0 = private unnamed_addr constant [6 x i8] c"type \00"
@.str.3 = private unnamed_addr constant [4 x i8] c" = \00"
@.str.0 = private unnamed_addr constant [11 x i8] c"interface \00"
@.str.0 = private unnamed_addr constant [6 x i8] c"enum \00"
@.str.0 = private unnamed_addr constant [8 x i8] c"struct \00"
@.str.0 = private unnamed_addr constant [8 x i8] c"prompt \00"
@.str.0 = private unnamed_addr constant [6 x i8] c"with \00"
@.str.0 = private unnamed_addr constant [4 x i8] c"if \00"
@.str.0 = private unnamed_addr constant [5 x i8] c"for \00"
@.str.0 = private unnamed_addr constant [7 x i8] c"match \00"
@.str.0 = private unnamed_addr constant [6 x i8] c"case \00"
@.str.0 = private unnamed_addr constant [2 x i8] c"@\00"
@.str.20 = private unnamed_addr constant [43 x i8] c"(\22 + join_with_separator(parts, \22, \22) + \22)\00"
@.str.3 = private unnamed_addr constant [5 x i8] c" in \00"
@.str.0 = private unnamed_addr constant [3 x i8] c"fn\00"
@.str.0 = private unnamed_addr constant [1 x i8] c"\00"
@.str.3 = private unnamed_addr constant [2 x i8] c" \00"
@.str.7 = private unnamed_addr constant [50 x i8] c"(\22 + format_parameters(signature.parameters) + \22)\00"
@.str.0 = private unnamed_addr constant [3 x i8] c"![\00"
@.str.0 = private unnamed_addr constant [4 x i8] c"fn \00"
@.str.29 = private unnamed_addr constant [15 x i8] c"(\22 + args + \22)\00"
@.str.8 = private unnamed_addr constant [3 x i8] c"{\0A\00"
@.str.10 = private unnamed_addr constant [2 x i8] c"\0A\00"
@.str.13 = private unnamed_addr constant [3 x i8] c"\0A}\00"
@.str.0 = private unnamed_addr constant [2 x i8] c"\22\00"
@.str.6 = private unnamed_addr constant [2 x i8] c"a\00"
@.str.10 = private unnamed_addr constant [2 x i8] c"z\00"
@.str.16 = private unnamed_addr constant [2 x i8] c"A\00"
@.str.20 = private unnamed_addr constant [2 x i8] c"Z\00"
@.str.4 = private unnamed_addr constant [2 x i8] c"0\00"
@.str.8 = private unnamed_addr constant [2 x i8] c"9\00"
@.str.8 = private unnamed_addr constant [2 x i8] c"\0D\00"
@.str.11 = private unnamed_addr constant [2 x i8] c"\09\00"

define i8* @emit_program(i8* %program) {
entry:
  %l0 = alloca %TextBuilder
  %l1 = alloca double
  %t0 = call %TextBuilder @builder_new()
  store %TextBuilder %t0, %TextBuilder* %l0
  %t1 = load %TextBuilder, %TextBuilder* %l0
  %t2 = load %TextBuilder, %TextBuilder* %l0
  %t3 = call %TextBuilder @builder_emit_blank(%TextBuilder %t2)
  store %TextBuilder %t3, %TextBuilder* %l0
  %t4 = load %TextBuilder, %TextBuilder* %l0
  %t5 = call %TextBuilder @builder_emit_blank(%TextBuilder %t4)
  store %TextBuilder %t5, %TextBuilder* %l0
  %t6 = sitofp i64 0 to double
  store double %t6, double* %l1
  %t7 = load %TextBuilder, %TextBuilder* %l0
  %t8 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t19 = phi %TextBuilder [ %t7, %entry ], [ %t17, %loop.latch2 ]
  %t20 = phi double [ %t8, %entry ], [ %t18, %loop.latch2 ]
  store %TextBuilder %t19, %TextBuilder* %l0
  store double %t20, double* %l1
  br label %loop.body1
loop.body1:
  %t9 = load double, double* %l1
  %t10 = load %TextBuilder, %TextBuilder* %l0
  %t11 = load double, double* %l1
  %t12 = sitofp i64 1 to double
  %t13 = fadd double %t11, %t12
  %t14 = load double, double* %l1
  %t15 = sitofp i64 1 to double
  %t16 = fadd double %t14, %t15
  store double %t16, double* %l1
  br label %loop.latch2
loop.latch2:
  %t17 = load %TextBuilder, %TextBuilder* %l0
  %t18 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t21 = load %TextBuilder, %TextBuilder* %l0
  %t22 = call i8* @builder_to_string(%TextBuilder %t21)
  ret i8* %t22
}

define %TextBuilder @emit_statement(%TextBuilder %builder, i8* %statement) {
entry:
  ret %TextBuilder zeroinitializer
}

define %TextBuilder @emit_import(%TextBuilder %builder, { i8**, i64 }* %specifiers, i8* %source) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %t0 = call i8* @format_import_specifiers({ i8**, i64 }* %specifiers)
  store i8* %t0, i8** %l0
  %s1 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.1, i32 0, i32 0
  %t2 = load i8*, i8** %l0
  %t3 = add i8* %s1, %t2
  %s4 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.4, i32 0, i32 0
  %t5 = add i8* %t3, %s4
  %t6 = add i8* %t5, %source
  %s7 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.7, i32 0, i32 0
  %t8 = add i8* %t6, %s7
  store i8* %t8, i8** %l1
  %t9 = load i8*, i8** %l1
  %t10 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* %t9)
  ret %TextBuilder %t10
}

define %TextBuilder @emit_export(%TextBuilder %builder, { i8**, i64 }* %specifiers, i8* %source) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %t0 = call i8* @format_export_specifiers({ i8**, i64 }* %specifiers)
  store i8* %t0, i8** %l0
  %s1 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.1, i32 0, i32 0
  %t2 = load i8*, i8** %l0
  %t3 = add i8* %s1, %t2
  %s4 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.4, i32 0, i32 0
  %t5 = add i8* %t3, %s4
  %t6 = add i8* %t5, %source
  %s7 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.7, i32 0, i32 0
  %t8 = add i8* %t6, %s7
  store i8* %t8, i8** %l1
  %t9 = load i8*, i8** %l1
  %t10 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* %t9)
  ret %TextBuilder %t10
}

define %TextBuilder @emit_variable(%TextBuilder %builder, i8* %statement) {
entry:
  %l0 = alloca i8*
  %s0 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = load i8*, i8** %l0
  %t3 = load i8*, i8** %l0
  %t4 = load i8*, i8** %l0
  %s5 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.5, i32 0, i32 0
  %t6 = add i8* %t4, %s5
  %t7 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* %t6)
  ret %TextBuilder %t7
}

define %TextBuilder @emit_function(%TextBuilder %builder, i8* %signature, i8* %body, { i8**, i64 }* %decorators) {
entry:
  %l0 = alloca %TextBuilder
  %l1 = alloca i8*
  %t0 = call %TextBuilder @emit_decorators(%TextBuilder %builder, { i8**, i64 }* %decorators)
  store %TextBuilder %t0, %TextBuilder* %l0
  %t1 = call i8* @format_function_header(i8* %signature)
  store i8* %t1, i8** %l1
  %t2 = load %TextBuilder, %TextBuilder* %l0
  %t3 = load i8*, i8** %l1
  %t4 = call %TextBuilder @builder_emit_line(%TextBuilder %t2, i8* %t3)
  store %TextBuilder %t4, %TextBuilder* %l0
  %t5 = load %TextBuilder, %TextBuilder* %l0
  %t6 = call %TextBuilder @emit_block(%TextBuilder %t5, i8* %body)
  store %TextBuilder %t6, %TextBuilder* %l0
  %t7 = load %TextBuilder, %TextBuilder* %l0
  ret %TextBuilder %t7
}

define %TextBuilder @emit_callable(%TextBuilder %builder, i8* %keyword, i8* %signature, i8* %body, { i8**, i64 }* %decorators) {
entry:
  %l0 = alloca %TextBuilder
  %l1 = alloca i8*
  %t0 = call %TextBuilder @emit_decorators(%TextBuilder %builder, { i8**, i64 }* %decorators)
  store %TextBuilder %t0, %TextBuilder* %l0
  %t1 = call i8* @format_callable_header(i8* %keyword, i8* %signature)
  store i8* %t1, i8** %l1
  %t2 = load %TextBuilder, %TextBuilder* %l0
  %t3 = load i8*, i8** %l1
  %t4 = call %TextBuilder @builder_emit_line(%TextBuilder %t2, i8* %t3)
  store %TextBuilder %t4, %TextBuilder* %l0
  %t5 = load %TextBuilder, %TextBuilder* %l0
  %t6 = call %TextBuilder @emit_block(%TextBuilder %t5, i8* %body)
  store %TextBuilder %t6, %TextBuilder* %l0
  %t7 = load %TextBuilder, %TextBuilder* %l0
  ret %TextBuilder %t7
}

define %TextBuilder @emit_test(%TextBuilder %builder, i8* %statement) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca i8*
  store double 0.0, double* %l0
  store double 0.0, double* %l1
  store double 0.0, double* %l2
  %s0 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.0, i32 0, i32 0
  %t1 = load double, double* %l1
  store i8* null, i8** %l3
  %t2 = load double, double* %l2
  %t3 = load double, double* %l0
  %t4 = load i8*, i8** %l3
  %t5 = call %TextBuilder @builder_emit_line(%TextBuilder zeroinitializer, i8* %t4)
  store double 0.0, double* %l0
  %t6 = load double, double* %l0
  %t7 = load double, double* %l0
  ret %TextBuilder zeroinitializer
}

define %TextBuilder @emit_model(%TextBuilder %builder, i8* %statement) {
entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  store double 0.0, double* %l0
  %s0 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.0, i32 0, i32 0
  store i8* null, i8** %l1
  store double 0.0, double* %l2
  %t1 = load double, double* %l2
  %t2 = load double, double* %l0
  %t3 = load i8*, i8** %l1
  %t4 = call %TextBuilder @builder_emit_line(%TextBuilder zeroinitializer, i8* %t3)
  store double 0.0, double* %l0
  %t5 = load double, double* %l0
  %s6 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.6, i32 0, i32 0
  %t7 = call %TextBuilder @builder_emit_line(%TextBuilder zeroinitializer, i8* %s6)
  store double 0.0, double* %l0
  %t8 = load double, double* %l0
  %t9 = call %TextBuilder @builder_push_indent(%TextBuilder zeroinitializer)
  store double 0.0, double* %l0
  %t10 = sitofp i64 0 to double
  store double %t10, double* %l3
  %t11 = load double, double* %l0
  %t12 = load i8*, i8** %l1
  %t13 = load double, double* %l2
  %t14 = load double, double* %l3
  br label %loop.header0
loop.header0:
  %t25 = phi double [ %t11, %entry ], [ %t23, %loop.latch2 ]
  %t26 = phi double [ %t14, %entry ], [ %t24, %loop.latch2 ]
  store double %t25, double* %l0
  store double %t26, double* %l3
  br label %loop.body1
loop.body1:
  %t15 = load double, double* %l3
  store double 0.0, double* %l4
  %t16 = load double, double* %l4
  store double 0.0, double* %l5
  %t17 = load double, double* %l0
  %t18 = load double, double* %l5
  %t19 = call %TextBuilder @builder_emit_line(%TextBuilder zeroinitializer, i8* null)
  store double 0.0, double* %l0
  %t20 = load double, double* %l3
  %t21 = sitofp i64 1 to double
  %t22 = fadd double %t20, %t21
  store double %t22, double* %l3
  br label %loop.latch2
loop.latch2:
  %t23 = load double, double* %l0
  %t24 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t27 = load double, double* %l0
  %t28 = call %TextBuilder @builder_pop_indent(%TextBuilder zeroinitializer)
  store double 0.0, double* %l0
  %t29 = load double, double* %l0
  %s30 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.30, i32 0, i32 0
  %t31 = call %TextBuilder @builder_emit_line(%TextBuilder zeroinitializer, i8* %s30)
  store double 0.0, double* %l0
  %t32 = load double, double* %l0
  ret %TextBuilder zeroinitializer
}

define i8* @format_import_specifiers({ i8**, i64 }* %specifiers) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca double
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
  %t31 = phi { i8**, i64 }* [ %t6, %entry ], [ %t29, %loop.latch2 ]
  %t32 = phi double [ %t7, %entry ], [ %t30, %loop.latch2 ]
  store { i8**, i64 }* %t31, { i8**, i64 }** %l0
  store double %t32, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load double, double* %l1
  %t10 = load { i8**, i64 }, { i8**, i64 }* %specifiers
  %t11 = extractvalue { i8**, i64 } %t10, 0
  %t12 = extractvalue { i8**, i64 } %t10, 1
  %t13 = icmp uge i64 %t9, %t12
  ; bounds check: %t13 (if true, out of bounds)
  %t14 = getelementptr i8*, i8** %t11, i64 %t9
  %t15 = load i8*, i8** %t14
  %t16 = load double, double* %l1
  %t17 = load { i8**, i64 }, { i8**, i64 }* %specifiers
  %t18 = extractvalue { i8**, i64 } %t17, 0
  %t19 = extractvalue { i8**, i64 } %t17, 1
  %t20 = icmp uge i64 %t16, %t19
  ; bounds check: %t20 (if true, out of bounds)
  %t21 = getelementptr i8*, i8** %t18, i64 %t16
  %t22 = load i8*, i8** %t21
  store double 0.0, double* %l2
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t24 = load double, double* %l2
  %t25 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t23, i8* null)
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

define i8* @format_export_specifiers({ i8**, i64 }* %specifiers) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca double
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
  %t31 = phi { i8**, i64 }* [ %t6, %entry ], [ %t29, %loop.latch2 ]
  %t32 = phi double [ %t7, %entry ], [ %t30, %loop.latch2 ]
  store { i8**, i64 }* %t31, { i8**, i64 }** %l0
  store double %t32, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load double, double* %l1
  %t10 = load { i8**, i64 }, { i8**, i64 }* %specifiers
  %t11 = extractvalue { i8**, i64 } %t10, 0
  %t12 = extractvalue { i8**, i64 } %t10, 1
  %t13 = icmp uge i64 %t9, %t12
  ; bounds check: %t13 (if true, out of bounds)
  %t14 = getelementptr i8*, i8** %t11, i64 %t9
  %t15 = load i8*, i8** %t14
  %t16 = load double, double* %l1
  %t17 = load { i8**, i64 }, { i8**, i64 }* %specifiers
  %t18 = extractvalue { i8**, i64 } %t17, 0
  %t19 = extractvalue { i8**, i64 } %t17, 1
  %t20 = icmp uge i64 %t16, %t19
  ; bounds check: %t20 (if true, out of bounds)
  %t21 = getelementptr i8*, i8** %t18, i64 %t16
  %t22 = load i8*, i8** %t21
  store double 0.0, double* %l2
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t24 = load double, double* %l2
  %t25 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t23, i8* null)
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

define i8* @format_specifier_entry(i8* %name, i8* %alias) {
entry:
  %t1 = icmp eq i8* %alias, null
  br label %logical_or_entry_0

logical_or_entry_0:
  br i1 %t1, label %logical_or_merge_0, label %logical_or_right_0

logical_or_right_0:
  %s2 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.2, i32 0, i32 0
  %t3 = add i8* %name, %s2
  %t4 = add i8* %t3, %alias
  ret i8* %t4
}

define %TextBuilder @emit_type_alias(%TextBuilder %builder, i8* %statement) {
entry:
  %l0 = alloca i8*
  %s0 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.0, i32 0, i32 0
  store i8* null, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = load i8*, i8** %l0
  %s3 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.3, i32 0, i32 0
  %t4 = add i8* %t2, %s3
  %t5 = load i8*, i8** %l0
  ret %TextBuilder zeroinitializer
}

define %TextBuilder @emit_interface(%TextBuilder %builder, i8* %statement) {
entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i8*
  store double 0.0, double* %l0
  %s0 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.0, i32 0, i32 0
  store i8* null, i8** %l1
  %t1 = load i8*, i8** %l1
  %t2 = load double, double* %l0
  %t3 = load i8*, i8** %l1
  %t4 = call %TextBuilder @builder_emit_line(%TextBuilder zeroinitializer, i8* %t3)
  store double 0.0, double* %l0
  %t5 = load double, double* %l0
  %t6 = call %TextBuilder @emit_block_start(%TextBuilder zeroinitializer)
  store double 0.0, double* %l0
  %t7 = sitofp i64 0 to double
  store double %t7, double* %l2
  %t8 = load double, double* %l0
  %t9 = load i8*, i8** %l1
  %t10 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t25 = phi double [ %t8, %entry ], [ %t23, %loop.latch2 ]
  %t26 = phi double [ %t10, %entry ], [ %t24, %loop.latch2 ]
  store double %t25, double* %l0
  store double %t26, double* %l2
  br label %loop.body1
loop.body1:
  %t11 = load double, double* %l2
  store double 0.0, double* %l3
  %s12 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.12, i32 0, i32 0
  %t13 = load double, double* %l3
  %t14 = call i8* @format_signature_line(i8* %s12, i8* null)
  %s15 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.15, i32 0, i32 0
  %t16 = add i8* %t14, %s15
  store i8* %t16, i8** %l4
  %t17 = load double, double* %l0
  %t18 = load i8*, i8** %l4
  %t19 = call %TextBuilder @builder_emit_line(%TextBuilder zeroinitializer, i8* %t18)
  store double 0.0, double* %l0
  %t20 = load double, double* %l2
  %t21 = sitofp i64 1 to double
  %t22 = fadd double %t20, %t21
  store double %t22, double* %l2
  br label %loop.latch2
loop.latch2:
  %t23 = load double, double* %l0
  %t24 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t27 = load double, double* %l0
  %t28 = call %TextBuilder @emit_block_end(%TextBuilder zeroinitializer)
  store double 0.0, double* %l0
  %t29 = load double, double* %l0
  ret %TextBuilder zeroinitializer
}

define %TextBuilder @emit_enum(%TextBuilder %builder, i8* %statement) {
entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  store double 0.0, double* %l0
  %s0 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.0, i32 0, i32 0
  store i8* null, i8** %l1
  %t1 = load i8*, i8** %l1
  %t2 = load double, double* %l0
  %t3 = load i8*, i8** %l1
  %t4 = call %TextBuilder @builder_emit_line(%TextBuilder zeroinitializer, i8* %t3)
  store double 0.0, double* %l0
  %t5 = load double, double* %l0
  %t6 = call %TextBuilder @emit_block_start(%TextBuilder zeroinitializer)
  store double 0.0, double* %l0
  %t7 = sitofp i64 0 to double
  store double %t7, double* %l2
  %t8 = load double, double* %l0
  %t9 = load i8*, i8** %l1
  %t10 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t23 = phi double [ %t8, %entry ], [ %t21, %loop.latch2 ]
  %t24 = phi double [ %t10, %entry ], [ %t22, %loop.latch2 ]
  store double %t23, double* %l0
  store double %t24, double* %l2
  br label %loop.body1
loop.body1:
  %t11 = load double, double* %l2
  store double 0.0, double* %l3
  %t12 = load double, double* %l0
  %t13 = load double, double* %l3
  %t14 = call i8* @format_enum_variant(i8* null)
  %s15 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.15, i32 0, i32 0
  %t16 = add i8* %t14, %s15
  %t17 = call %TextBuilder @builder_emit_line(%TextBuilder zeroinitializer, i8* %t16)
  store double 0.0, double* %l0
  %t18 = load double, double* %l2
  %t19 = sitofp i64 1 to double
  %t20 = fadd double %t18, %t19
  store double %t20, double* %l2
  br label %loop.latch2
loop.latch2:
  %t21 = load double, double* %l0
  %t22 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t25 = load double, double* %l0
  %t26 = call %TextBuilder @emit_block_end(%TextBuilder zeroinitializer)
  store double 0.0, double* %l0
  %t27 = load double, double* %l0
  ret %TextBuilder zeroinitializer
}

define %TextBuilder @emit_struct(%TextBuilder %builder, i8* %statement) {
entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  store double 0.0, double* %l0
  %s0 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.0, i32 0, i32 0
  store i8* null, i8** %l1
  %t1 = load i8*, i8** %l1
  %t2 = load double, double* %l0
  %t3 = load i8*, i8** %l1
  %t4 = call %TextBuilder @builder_emit_line(%TextBuilder zeroinitializer, i8* %t3)
  store double 0.0, double* %l0
  %t5 = load double, double* %l0
  %t6 = call %TextBuilder @emit_block_start(%TextBuilder zeroinitializer)
  store double 0.0, double* %l0
  %t7 = sitofp i64 0 to double
  store double %t7, double* %l2
  %t8 = load double, double* %l0
  %t9 = load i8*, i8** %l1
  %t10 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t18 = phi double [ %t8, %entry ], [ %t16, %loop.latch2 ]
  %t19 = phi double [ %t10, %entry ], [ %t17, %loop.latch2 ]
  store double %t18, double* %l0
  store double %t19, double* %l2
  br label %loop.body1
loop.body1:
  %t11 = load double, double* %l2
  %t12 = load double, double* %l0
  %t13 = load double, double* %l2
  %t14 = sitofp i64 1 to double
  %t15 = fadd double %t13, %t14
  store double %t15, double* %l2
  br label %loop.latch2
loop.latch2:
  %t16 = load double, double* %l0
  %t17 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t20 = sitofp i64 0 to double
  store double %t20, double* %l3
  %t21 = load double, double* %l0
  %t22 = load i8*, i8** %l1
  %t23 = load double, double* %l2
  %t24 = load double, double* %l3
  br label %loop.header4
loop.header4:
  %t40 = phi double [ %t21, %entry ], [ %t38, %loop.latch6 ]
  %t41 = phi double [ %t24, %entry ], [ %t39, %loop.latch6 ]
  store double %t40, double* %l0
  store double %t41, double* %l3
  br label %loop.body5
loop.body5:
  %t25 = load double, double* %l3
  store double 0.0, double* %l4
  %t26 = load double, double* %l0
  %t27 = load double, double* %l4
  %t28 = load double, double* %l0
  %t29 = load double, double* %l4
  %t30 = load double, double* %l0
  %t31 = load double, double* %l4
  %t32 = load double, double* %l3
  %t33 = sitofp i64 1 to double
  %t34 = fadd double %t32, %t33
  %t35 = load double, double* %l3
  %t36 = sitofp i64 1 to double
  %t37 = fadd double %t35, %t36
  store double %t37, double* %l3
  br label %loop.latch6
loop.latch6:
  %t38 = load double, double* %l0
  %t39 = load double, double* %l3
  br label %loop.header4
afterloop7:
  %t43 = load double, double* %l0
  %t44 = call %TextBuilder @emit_block_end(%TextBuilder zeroinitializer)
  store double 0.0, double* %l0
  %t45 = load double, double* %l0
  ret %TextBuilder zeroinitializer
}

define %TextBuilder @emit_block(%TextBuilder %builder, i8* %block) {
entry:
  %l0 = alloca %TextBuilder
  %t0 = call %TextBuilder @emit_block_start(%TextBuilder %builder)
  store %TextBuilder %t0, %TextBuilder* %l0
  %t1 = load %TextBuilder, %TextBuilder* %l0
  %t2 = call %TextBuilder @emit_block_body(%TextBuilder %t1, i8* %block)
  store %TextBuilder %t2, %TextBuilder* %l0
  %t3 = load %TextBuilder, %TextBuilder* %l0
  %t4 = call %TextBuilder @emit_block_end(%TextBuilder %t3)
  store %TextBuilder %t4, %TextBuilder* %l0
  %t5 = load %TextBuilder, %TextBuilder* %l0
  ret %TextBuilder %t5
}

define %TextBuilder @emit_block_body(%TextBuilder %builder, i8* %block) {
entry:
  %l0 = alloca %TextBuilder
  %l1 = alloca double
  store %TextBuilder %builder, %TextBuilder* %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load %TextBuilder, %TextBuilder* %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t10 = phi %TextBuilder [ %t1, %entry ], [ %t8, %loop.latch2 ]
  %t11 = phi double [ %t2, %entry ], [ %t9, %loop.latch2 ]
  store %TextBuilder %t10, %TextBuilder* %l0
  store double %t11, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load %TextBuilder, %TextBuilder* %l0
  %t5 = load double, double* %l1
  %t6 = sitofp i64 1 to double
  %t7 = fadd double %t5, %t6
  store double %t7, double* %l1
  br label %loop.latch2
loop.latch2:
  %t8 = load %TextBuilder, %TextBuilder* %l0
  %t9 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t12 = load %TextBuilder, %TextBuilder* %l0
  ret %TextBuilder %t12
}

define %TextBuilder @emit_block_statement(%TextBuilder %builder, i8* %statement) {
entry:
  ret %TextBuilder zeroinitializer
}

define %TextBuilder @emit_prompt(%TextBuilder %builder, i8* %statement) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  store double 0.0, double* %l0
  %s0 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.0, i32 0, i32 0
  store double 0.0, double* %l1
  %t1 = load double, double* %l0
  %t2 = load double, double* %l1
  %t3 = call %TextBuilder @builder_emit_line(%TextBuilder zeroinitializer, i8* null)
  store double 0.0, double* %l0
  %t4 = load double, double* %l0
  %t5 = load double, double* %l0
  %s6 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.6, i32 0, i32 0
  %t7 = call %TextBuilder @builder_emit_line(%TextBuilder zeroinitializer, i8* %s6)
  ret %TextBuilder %t7
}

define %TextBuilder @emit_with(%TextBuilder %builder, i8* %statement) {
entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %l2 = alloca double
  store double 0.0, double* %l0
  %s0 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l1
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l2
  %t2 = load double, double* %l0
  %t3 = load i8*, i8** %l1
  %t4 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t22 = phi i8* [ %t3, %entry ], [ %t20, %loop.latch2 ]
  %t23 = phi double [ %t4, %entry ], [ %t21, %loop.latch2 ]
  store i8* %t22, i8** %l1
  store double %t23, double* %l2
  br label %loop.body1
loop.body1:
  %t5 = load double, double* %l2
  %t6 = load double, double* %l2
  %t7 = sitofp i64 0 to double
  %t8 = fcmp ogt double %t6, %t7
  %t9 = load double, double* %l0
  %t10 = load i8*, i8** %l1
  %t11 = load double, double* %l2
  br i1 %t8, label %then4, label %merge5
then4:
  %t12 = load i8*, i8** %l1
  %s13 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.13, i32 0, i32 0
  %t14 = add i8* %t12, %s13
  store i8* %t14, i8** %l1
  br label %merge5
merge5:
  %t15 = phi i8* [ %t14, %then4 ], [ %t10, %loop.body1 ]
  store i8* %t15, i8** %l1
  %t16 = load i8*, i8** %l1
  %t17 = load double, double* %l2
  %t18 = sitofp i64 1 to double
  %t19 = fadd double %t17, %t18
  store double %t19, double* %l2
  br label %loop.latch2
loop.latch2:
  %t20 = load i8*, i8** %l1
  %t21 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t24 = load double, double* %l0
  %t25 = load i8*, i8** %l1
  %t26 = call %TextBuilder @builder_emit_line(%TextBuilder zeroinitializer, i8* %t25)
  store double 0.0, double* %l0
  %t27 = load double, double* %l0
  %t28 = load double, double* %l0
  ret %TextBuilder zeroinitializer
}

define %TextBuilder @emit_if(%TextBuilder %builder, i8* %statement) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  store double 0.0, double* %l0
  %s0 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.0, i32 0, i32 0
  store double 0.0, double* %l1
  %t1 = load double, double* %l0
  %t2 = load double, double* %l1
  %t3 = call %TextBuilder @builder_emit_line(%TextBuilder zeroinitializer, i8* null)
  store double 0.0, double* %l0
  %t4 = load double, double* %l0
  %t5 = load double, double* %l0
  ret %TextBuilder zeroinitializer
}

define %TextBuilder @emit_else_branch(%TextBuilder %builder, i8* %branch) {
entry:
  ret %TextBuilder %builder
}

define %TextBuilder @emit_for(%TextBuilder %builder, i8* %statement) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  store double 0.0, double* %l0
  %s0 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.0, i32 0, i32 0
  store double 0.0, double* %l1
  %t1 = load double, double* %l0
  %t2 = load double, double* %l1
  %t3 = call %TextBuilder @builder_emit_line(%TextBuilder zeroinitializer, i8* null)
  store double 0.0, double* %l0
  %t4 = load double, double* %l0
  ret %TextBuilder zeroinitializer
}

define %TextBuilder @emit_match(%TextBuilder %builder, i8* %statement) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  store double 0.0, double* %l0
  %s0 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.0, i32 0, i32 0
  store double 0.0, double* %l1
  %t1 = load double, double* %l0
  %t2 = load double, double* %l1
  %t3 = call %TextBuilder @builder_emit_line(%TextBuilder zeroinitializer, i8* null)
  store double 0.0, double* %l0
  %t4 = load double, double* %l0
  %s5 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.5, i32 0, i32 0
  %t6 = call %TextBuilder @builder_emit_line(%TextBuilder zeroinitializer, i8* %s5)
  store double 0.0, double* %l0
  %t7 = load double, double* %l0
  %t8 = call %TextBuilder @builder_push_indent(%TextBuilder zeroinitializer)
  store double 0.0, double* %l0
  %t9 = sitofp i64 0 to double
  store double %t9, double* %l2
  %t10 = load double, double* %l0
  %t11 = load double, double* %l1
  %t12 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t20 = phi double [ %t10, %entry ], [ %t18, %loop.latch2 ]
  %t21 = phi double [ %t12, %entry ], [ %t19, %loop.latch2 ]
  store double %t20, double* %l0
  store double %t21, double* %l2
  br label %loop.body1
loop.body1:
  %t13 = load double, double* %l2
  %t14 = load double, double* %l0
  %t15 = load double, double* %l2
  %t16 = sitofp i64 1 to double
  %t17 = fadd double %t15, %t16
  store double %t17, double* %l2
  br label %loop.latch2
loop.latch2:
  %t18 = load double, double* %l0
  %t19 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t22 = load double, double* %l0
  %t23 = call %TextBuilder @builder_pop_indent(%TextBuilder zeroinitializer)
  store double 0.0, double* %l0
  %t24 = load double, double* %l0
  %s25 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.25, i32 0, i32 0
  %t26 = call %TextBuilder @builder_emit_line(%TextBuilder zeroinitializer, i8* %s25)
  ret %TextBuilder %t26
}

define %TextBuilder @emit_match_case(%TextBuilder %builder, i8* %case) {
entry:
  %l0 = alloca i8*
  %l1 = alloca %TextBuilder
  %s0 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.0, i32 0, i32 0
  store i8* null, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = load i8*, i8** %l0
  %t3 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* %t2)
  store %TextBuilder %t3, %TextBuilder* %l1
  %t4 = load %TextBuilder, %TextBuilder* %l1
  %t5 = call %TextBuilder @builder_push_indent(%TextBuilder %t4)
  store %TextBuilder %t5, %TextBuilder* %l1
  %t6 = load %TextBuilder, %TextBuilder* %l1
  %t7 = load %TextBuilder, %TextBuilder* %l1
  %t8 = call %TextBuilder @builder_pop_indent(%TextBuilder %t7)
  store %TextBuilder %t8, %TextBuilder* %l1
  %t9 = load %TextBuilder, %TextBuilder* %l1
  %s10 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.10, i32 0, i32 0
  %t11 = call %TextBuilder @builder_emit_line(%TextBuilder %t9, i8* %s10)
  ret %TextBuilder %t11
}

define %TextBuilder @emit_block_start(%TextBuilder %builder) {
entry:
  %l0 = alloca %TextBuilder
  %s0 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.0, i32 0, i32 0
  %t1 = call %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* %s0)
  store %TextBuilder %t1, %TextBuilder* %l0
  %t2 = load %TextBuilder, %TextBuilder* %l0
  %t3 = call %TextBuilder @builder_push_indent(%TextBuilder %t2)
  ret %TextBuilder %t3
}

define %TextBuilder @emit_block_end(%TextBuilder %builder) {
entry:
  %l0 = alloca %TextBuilder
  %t0 = call %TextBuilder @builder_pop_indent(%TextBuilder %builder)
  store %TextBuilder %t0, %TextBuilder* %l0
  %t1 = load %TextBuilder, %TextBuilder* %l0
  %s2 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.2, i32 0, i32 0
  %t3 = call %TextBuilder @builder_emit_line(%TextBuilder %t1, i8* %s2)
  ret %TextBuilder %t3
}

define %TextBuilder @emit_decorators_then_line(%TextBuilder %builder, { i8**, i64 }* %decorators, i8* %line) {
entry:
  %l0 = alloca %TextBuilder
  %t0 = call %TextBuilder @emit_decorators(%TextBuilder %builder, { i8**, i64 }* %decorators)
  store %TextBuilder %t0, %TextBuilder* %l0
  %t1 = load %TextBuilder, %TextBuilder* %l0
  %t2 = call %TextBuilder @builder_emit_line(%TextBuilder %t1, i8* %line)
  ret %TextBuilder %t2
}

define %TextBuilder @emit_decorators(%TextBuilder %builder, { i8**, i64 }* %decorators) {
entry:
  %l0 = alloca %TextBuilder
  %l1 = alloca double
  store %TextBuilder %builder, %TextBuilder* %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load %TextBuilder, %TextBuilder* %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t19 = phi %TextBuilder [ %t1, %entry ], [ %t17, %loop.latch2 ]
  %t20 = phi double [ %t2, %entry ], [ %t18, %loop.latch2 ]
  store %TextBuilder %t19, %TextBuilder* %l0
  store double %t20, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load %TextBuilder, %TextBuilder* %l0
  %t5 = load double, double* %l1
  %t6 = load { i8**, i64 }, { i8**, i64 }* %decorators
  %t7 = extractvalue { i8**, i64 } %t6, 0
  %t8 = extractvalue { i8**, i64 } %t6, 1
  %t9 = icmp uge i64 %t5, %t8
  ; bounds check: %t9 (if true, out of bounds)
  %t10 = getelementptr i8*, i8** %t7, i64 %t5
  %t11 = load i8*, i8** %t10
  %t12 = call i8* @format_decorator(i8* %t11)
  %t13 = call %TextBuilder @builder_emit_line(%TextBuilder %t4, i8* %t12)
  store %TextBuilder %t13, %TextBuilder* %l0
  %t14 = load double, double* %l1
  %t15 = sitofp i64 1 to double
  %t16 = fadd double %t14, %t15
  store double %t16, double* %l1
  br label %loop.latch2
loop.latch2:
  %t17 = load %TextBuilder, %TextBuilder* %l0
  %t18 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t21 = load %TextBuilder, %TextBuilder* %l0
  ret %TextBuilder %t21
}

define i8* @format_decorator(i8* %decorator) {
entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %s0 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.0, i32 0, i32 0
  store i8* null, i8** %l0
  %t1 = alloca [0 x double]
  %t2 = getelementptr [0 x double], [0 x double]* %t1, i32 0, i32 0
  %t3 = alloca { double*, i64 }
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 0
  store double* %t2, double** %t4
  %t5 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t6 = sitofp i64 0 to double
  store double %t6, double* %l2
  %t7 = load i8*, i8** %l0
  %t8 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t9 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t17 = phi { i8**, i64 }* [ %t8, %entry ], [ %t15, %loop.latch2 ]
  %t18 = phi double [ %t9, %entry ], [ %t16, %loop.latch2 ]
  store { i8**, i64 }* %t17, { i8**, i64 }** %l1
  store double %t18, double* %l2
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l2
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t12 = load double, double* %l2
  %t13 = sitofp i64 1 to double
  %t14 = fadd double %t12, %t13
  store double %t14, double* %l2
  br label %loop.latch2
loop.latch2:
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t16 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t19 = load i8*, i8** %l0
  %s20 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.20, i32 0, i32 0
  %t21 = add i8* %t19, %s20
  ret i8* %t21
}

define i8* @format_decorator_argument(i8* %argument) {
entry:
  %l0 = alloca double
  store double 0.0, double* %l0
  ret i8* null
}

define i8* @format_for_clause(i8* %clause) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  store double 0.0, double* %l0
  store double 0.0, double* %l1
  %t1 = load double, double* %l0
  %t2 = load double, double* %l0
  %s3 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.3, i32 0, i32 0
  ret i8* null
}

define i8* @format_function_header(i8* %signature) {
entry:
  %s0 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.0, i32 0, i32 0
  %t1 = call i8* @format_signature_line(i8* %s0, i8* %signature)
  ret i8* %t1
}

define i8* @format_method_header(i8* %signature) {
entry:
  %s0 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.0, i32 0, i32 0
  %t1 = call i8* @format_signature_line(i8* %s0, i8* %signature)
  ret i8* %t1
}

define i8* @format_callable_header(i8* %keyword, i8* %signature) {
entry:
  %t0 = call i8* @format_signature_line(i8* %keyword, i8* %signature)
  ret i8* %t0
}

define i8* @format_signature_line(i8* %keyword, i8* %signature) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca double
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = add i8* %t1, %keyword
  %s3 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.3, i32 0, i32 0
  %t4 = add i8* %t2, %s3
  store i8* null, i8** %l1
  %t5 = load i8*, i8** %l1
  %t6 = load i8*, i8** %l1
  %s7 = getelementptr inbounds [50 x i8], [50 x i8]* @.str.7, i32 0, i32 0
  %t8 = add i8* %t6, %s7
  store i8* %t8, i8** %l1
  store double 0.0, double* %l2
  %t9 = load double, double* %l2
  %t10 = load i8*, i8** %l1
  ret i8* %t10
}

define i8* @format_field(i8* %field) {
entry:
  %l0 = alloca i8*
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = load i8*, i8** %l0
  %t3 = load i8*, i8** %l0
  ret i8* %t3
}

define i8* @format_enum_variant(i8* %variant) {
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
  %t15 = phi { i8**, i64 }* [ %t6, %entry ], [ %t13, %loop.latch2 ]
  %t16 = phi double [ %t7, %entry ], [ %t14, %loop.latch2 ]
  store { i8**, i64 }* %t15, { i8**, i64 }** %l0
  store double %t16, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t10 = load double, double* %l1
  %t11 = sitofp i64 1 to double
  %t12 = fadd double %t10, %t11
  store double %t12, double* %l1
  br label %loop.latch2
loop.latch2:
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load double, double* %l1
  br label %loop.header0
afterloop3:
  ret i8* null
}

define i8* @format_parameters({ i8**, i64 }* %parameters) {
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
  %t11 = load { i8**, i64 }, { i8**, i64 }* %parameters
  %t12 = extractvalue { i8**, i64 } %t11, 0
  %t13 = extractvalue { i8**, i64 } %t11, 1
  %t14 = icmp uge i64 %t10, %t13
  ; bounds check: %t14 (if true, out of bounds)
  %t15 = getelementptr i8*, i8** %t12, i64 %t10
  %t16 = load i8*, i8** %t15
  %t17 = call i8* @format_parameter(i8* %t16)
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

define i8* @format_parameter(i8* %parameter) {
entry:
  %l0 = alloca i8*
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = load i8*, i8** %l0
  ret i8* %t1
}

define i8* @format_type_parameters({ i8**, i64 }* %parameters) {
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
  ret i8* null
}

define i8* @format_type_annotation(i8* %annotation) {
entry:
  %t0 = icmp eq i8* %annotation, null
  br i1 %t0, label %then0, label %merge1
then0:
  %s1 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.1, i32 0, i32 0
  ret i8* %s1
merge1:
  ret i8* null
}

define i8* @format_initializer(i8* %initializer) {
entry:
  %l0 = alloca i8*
  %t0 = icmp eq i8* %initializer, null
  br i1 %t0, label %then0, label %merge1
then0:
  %s1 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.1, i32 0, i32 0
  ret i8* %s1
merge1:
  %t2 = call i8* @format_expression(i8* %initializer)
  store i8* %t2, i8** %l0
  %t3 = load i8*, i8** %l0
  %s4 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.4, i32 0, i32 0
  %t5 = load i8*, i8** %l0
  %t6 = add i8* %s4, %t5
  ret i8* %t6
}

define i8* @format_effects({ i8**, i64 }* %effects) {
entry:
  %s0 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.0, i32 0, i32 0
  ret i8* null
}

define i8* @join_type_annotations({ i8**, i64 }* %values) {
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
  %t22 = phi { i8**, i64 }* [ %t6, %entry ], [ %t20, %loop.latch2 ]
  %t23 = phi double [ %t7, %entry ], [ %t21, %loop.latch2 ]
  store { i8**, i64 }* %t22, { i8**, i64 }** %l0
  store double %t23, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t10 = load double, double* %l1
  %t11 = load { i8**, i64 }, { i8**, i64 }* %values
  %t12 = extractvalue { i8**, i64 } %t11, 0
  %t13 = extractvalue { i8**, i64 } %t11, 1
  %t14 = icmp uge i64 %t10, %t13
  ; bounds check: %t14 (if true, out of bounds)
  %t15 = getelementptr i8*, i8** %t12, i64 %t10
  %t16 = load i8*, i8** %t15
  %t17 = load double, double* %l1
  %t18 = sitofp i64 1 to double
  %t19 = fadd double %t17, %t18
  store double %t19, double* %l1
  br label %loop.latch2
loop.latch2:
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t21 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret i8* null
}

define i8* @format_expression(i8* %expression) {
entry:
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.0, i32 0, i32 0
  ret i8* %s0
}

define i8* @format_lambda_expression(i8* %expression) {
entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %l2 = alloca double
  store double 0.0, double* %l0
  %s0 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.0, i32 0, i32 0
  %t1 = load double, double* %l0
  store i8* null, i8** %l1
  store double 0.0, double* %l2
  %t2 = load i8*, i8** %l1
  %s3 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.3, i32 0, i32 0
  %t4 = add i8* %t2, %s3
  %t5 = load double, double* %l2
  ret i8* null
}

define i8* @format_lambda_parameters({ i8**, i64 }* %parameters) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca i8*
  %l4 = alloca double
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
  store double 0.0, double* %l4
  %s29 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.29, i32 0, i32 0
  ret i8* %s29
}

define i8* @format_lambda_body(i8* %body) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { i8**, i64 }*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t6 = sitofp i64 1 to double
  %t7 = call { i8**, i64 }* @indent_lines({ i8**, i64 }* %t5, double %t6)
  store { i8**, i64 }* %t7, { i8**, i64 }** %l1
  %s8 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.8, i32 0, i32 0
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s10 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.10, i32 0, i32 0
  %t11 = call i8* @join_with_separator({ i8**, i64 }* %t9, i8* %s10)
  %t12 = add i8* %s8, %t11
  %s13 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.13, i32 0, i32 0
  %t14 = add i8* %t12, %s13
  ret i8* %t14
}

define i8* @format_lambda_statement(i8* %statement) {
entry:
  ret i8* null
}

define { i8**, i64 }* @indent_lines({ i8**, i64 }* %lines, double %depth) {
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
  %t47 = phi { i8**, i64 }* [ %t6, %entry ], [ %t45, %loop.latch2 ]
  %t48 = phi double [ %t7, %entry ], [ %t46, %loop.latch2 ]
  store { i8**, i64 }* %t47, { i8**, i64 }** %l0
  store double %t48, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %s9 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.9, i32 0, i32 0
  store i8* %s9, i8** %l2
  %t10 = sitofp i64 0 to double
  store double %t10, double* %l3
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t12 = load double, double* %l1
  %t13 = load i8*, i8** %l2
  %t14 = load double, double* %l3
  br label %loop.header4
loop.header4:
  %t29 = phi i8* [ %t13, %loop.body1 ], [ %t27, %loop.latch6 ]
  %t30 = phi double [ %t14, %loop.body1 ], [ %t28, %loop.latch6 ]
  store i8* %t29, i8** %l2
  store double %t30, double* %l3
  br label %loop.body5
loop.body5:
  %t15 = load double, double* %l3
  %t16 = fcmp oge double %t15, %depth
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = load double, double* %l1
  %t19 = load i8*, i8** %l2
  %t20 = load double, double* %l3
  br i1 %t16, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t21 = load i8*, i8** %l2
  %s22 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.22, i32 0, i32 0
  %t23 = add i8* %t21, %s22
  store i8* %t23, i8** %l2
  %t24 = load double, double* %l3
  %t25 = sitofp i64 1 to double
  %t26 = fadd double %t24, %t25
  store double %t26, double* %l3
  br label %loop.latch6
loop.latch6:
  %t27 = load i8*, i8** %l2
  %t28 = load double, double* %l3
  br label %loop.header4
afterloop7:
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t32 = load i8*, i8** %l2
  %t33 = load double, double* %l1
  %t34 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t35 = extractvalue { i8**, i64 } %t34, 0
  %t36 = extractvalue { i8**, i64 } %t34, 1
  %t37 = icmp uge i64 %t33, %t36
  ; bounds check: %t37 (if true, out of bounds)
  %t38 = getelementptr i8*, i8** %t35, i64 %t33
  %t39 = load i8*, i8** %t38
  %t40 = add i8* %t32, %t39
  %t41 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t31, i8* %t40)
  store { i8**, i64 }* %t41, { i8**, i64 }** %l0
  %t42 = load double, double* %l1
  %t43 = sitofp i64 1 to double
  %t44 = fadd double %t42, %t43
  store double %t44, double* %l1
  br label %loop.latch2
loop.latch2:
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t46 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t49
}

define i8* @quote_string(i8* %value) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %s0 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = load i8*, i8** %l0
  %t3 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t16 = phi i8* [ %t2, %entry ], [ %t14, %loop.latch2 ]
  %t17 = phi double [ %t3, %entry ], [ %t15, %loop.latch2 ]
  store i8* %t16, i8** %l0
  store double %t17, double* %l1
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  %t5 = load i8*, i8** %l0
  %t6 = load double, double* %l1
  %t7 = getelementptr i8, i8* %value, i64 %t6
  %t8 = load i8, i8* %t7
  %t9 = call i8* @escape_string_char(i8* null)
  %t10 = add i8* %t5, %t9
  store i8* %t10, i8** %l0
  %t11 = load double, double* %l1
  %t12 = sitofp i64 1 to double
  %t13 = fadd double %t11, %t12
  store double %t13, double* %l1
  br label %loop.latch2
loop.latch2:
  %t14 = load i8*, i8** %l0
  %t15 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t18 = load i8*, i8** %l0
  %s19 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.19, i32 0, i32 0
  %t20 = add i8* %t18, %s19
  store i8* %t20, i8** %l0
  %t21 = load i8*, i8** %l0
  ret i8* %t21
}

define i8* @escape_string_char(i8* %ch) {
entry:
  %s0 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.0, i32 0, i32 0
  %t1 = icmp eq i8* %ch, %s0
  br i1 %t1, label %then0, label %merge1
then0:
  %s2 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.2, i32 0, i32 0
  ret i8* %s2
merge1:
  %s3 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.3, i32 0, i32 0
  %t4 = icmp eq i8* %ch, %s3
  br i1 %t4, label %then2, label %merge3
then2:
  %s5 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.5, i32 0, i32 0
  ret i8* %s5
merge3:
  %s6 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.6, i32 0, i32 0
  %t7 = icmp eq i8* %ch, %s6
  br i1 %t7, label %then4, label %merge5
then4:
  %s8 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.8, i32 0, i32 0
  ret i8* %s8
merge5:
  %s9 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.9, i32 0, i32 0
  %t10 = icmp eq i8* %ch, %s9
  br i1 %t10, label %then6, label %merge7
then6:
  %s11 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.11, i32 0, i32 0
  ret i8* %s11
merge7:
  %s12 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.12, i32 0, i32 0
  %t13 = icmp eq i8* %ch, %s12
  br i1 %t13, label %then8, label %merge9
then8:
  %s14 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.14, i32 0, i32 0
  ret i8* %s14
merge9:
  ret i8* %ch
}

define i8* @format_test_name(i8* %name) {
entry:
  %t0 = call i8* @quote_string(i8* %name)
  ret i8* %t0
}

define i1 @is_identifier(i8* %value) {
entry:
  %l0 = alloca i8
  %l1 = alloca double
  %t0 = getelementptr i8, i8* %value, i64 0
  %t1 = load i8, i8* %t0
  store i8 %t1, i8* %l0
  %t2 = load i8, i8* %l0
  %t3 = call i1 @is_identifier_start(i8* null)
  %t4 = xor i1 %t3, 1
  %t5 = load i8, i8* %l0
  br i1 %t4, label %then0, label %merge1
then0:
  ret i1 0
merge1:
  %t6 = sitofp i64 1 to double
  store double %t6, double* %l1
  %t7 = load i8, i8* %l0
  %t8 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t21 = phi double [ %t8, %entry ], [ %t20, %loop.latch4 ]
  store double %t21, double* %l1
  br label %loop.body3
loop.body3:
  %t9 = load double, double* %l1
  %t10 = load double, double* %l1
  %t11 = getelementptr i8, i8* %value, i64 %t10
  %t12 = load i8, i8* %t11
  %t13 = call i1 @is_identifier_part(i8* null)
  %t14 = xor i1 %t13, 1
  %t15 = load i8, i8* %l0
  %t16 = load double, double* %l1
  br i1 %t14, label %then6, label %merge7
then6:
  ret i1 0
merge7:
  %t17 = load double, double* %l1
  %t18 = sitofp i64 1 to double
  %t19 = fadd double %t17, %t18
  store double %t19, double* %l1
  br label %loop.latch4
loop.latch4:
  %t20 = load double, double* %l1
  br label %loop.header2
afterloop5:
  ret i1 1
}

define i1 @is_identifier_start(i8* %ch) {
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
  %t5 = load double, double* %l0
  %s6 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.6, i32 0, i32 0
  %t7 = call double @char_code(i8* %s6)
  %t8 = fcmp oge double %t5, %t7
  br label %logical_and_entry_4

logical_and_entry_4:
  br i1 %t8, label %logical_and_right_4, label %logical_and_merge_4

logical_and_right_4:
  %t9 = load double, double* %l0
  %s10 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.10, i32 0, i32 0
  %t11 = call double @char_code(i8* %s10)
  %t12 = fcmp ole double %t9, %t11
  br label %logical_and_right_end_4

logical_and_right_end_4:
  br label %logical_and_merge_4

logical_and_merge_4:
  %t13 = phi i1 [ false, %logical_and_entry_4 ], [ %t12, %logical_and_right_end_4 ]
  br label %logical_or_entry_3

logical_or_entry_3:
  br i1 %t13, label %logical_or_merge_3, label %logical_or_right_3

logical_or_right_3:
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
  br label %logical_or_right_end_3

logical_or_right_end_3:
  br label %logical_or_merge_3

logical_or_merge_3:
  %t24 = phi i1 [ true, %logical_or_entry_3 ], [ %t23, %logical_or_right_end_3 ]
  ret i1 %t24
}

define i1 @is_identifier_part(i8* %ch) {
entry:
  %l0 = alloca double
  %t0 = call i1 @is_identifier_start(i8* %ch)
  br i1 %t0, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %t1 = call double @char_code(i8* %ch)
  store double %t1, double* %l0
  %t3 = load double, double* %l0
  %s4 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.4, i32 0, i32 0
  %t5 = call double @char_code(i8* %s4)
  %t6 = fcmp oge double %t3, %t5
  br label %logical_and_entry_2

logical_and_entry_2:
  br i1 %t6, label %logical_and_right_2, label %logical_and_merge_2

logical_and_right_2:
  %t7 = load double, double* %l0
  %s8 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.8, i32 0, i32 0
  %t9 = call double @char_code(i8* %s8)
  %t10 = fcmp ole double %t7, %t9
  br label %logical_and_right_end_2

logical_and_right_end_2:
  br label %logical_and_merge_2

logical_and_merge_2:
  %t11 = phi i1 [ false, %logical_and_entry_2 ], [ %t10, %logical_and_right_end_2 ]
  ret i1 %t11
}

define i8* @trim_block_body(i8* %text) {
entry:
  %l0 = alloca i8*
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t3 = load i8*, i8** %l0
  %t4 = getelementptr i8, i8* %t3, i64 0
  %t5 = load i8, i8* %t4
  %s6 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.6, i32 0, i32 0
  %t7 = load i8*, i8** %l0
  ret i8* %t7
}

define i8* @collapse_whitespace(i8* %value) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i1
  %l3 = alloca i8
  %l4 = alloca double
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  store i1 0, i1* %l2
  %t2 = load i8*, i8** %l0
  %t3 = load double, double* %l1
  %t4 = load i1, i1* %l2
  br label %loop.header0
loop.header0:
  %t43 = phi i8* [ %t2, %entry ], [ %t40, %loop.latch2 ]
  %t44 = phi i1 [ %t4, %entry ], [ %t41, %loop.latch2 ]
  %t45 = phi double [ %t3, %entry ], [ %t42, %loop.latch2 ]
  store i8* %t43, i8** %l0
  store i1 %t44, i1* %l2
  store double %t45, double* %l1
  br label %loop.body1
loop.body1:
  %t5 = load double, double* %l1
  %t6 = load double, double* %l1
  %t7 = getelementptr i8, i8* %value, i64 %t6
  %t8 = load i8, i8* %t7
  store i8 %t8, i8* %l3
  %t12 = load i8, i8* %l3
  %s13 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.13, i32 0, i32 0
  store double 0.0, double* %l4
  %t14 = load double, double* %l4
  %t15 = fcmp one double %t14, 0.0
  %t16 = load i8*, i8** %l0
  %t17 = load double, double* %l1
  %t18 = load i1, i1* %l2
  %t19 = load i8, i8* %l3
  %t20 = load double, double* %l4
  br i1 %t15, label %then4, label %else5
then4:
  %t21 = load i1, i1* %l2
  %t22 = xor i1 %t21, 1
  %t23 = load i8*, i8** %l0
  %t24 = load double, double* %l1
  %t25 = load i1, i1* %l2
  %t26 = load i8, i8* %l3
  %t27 = load double, double* %l4
  br i1 %t22, label %then7, label %merge8
then7:
  %t28 = load i8*, i8** %l0
  %s29 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.29, i32 0, i32 0
  %t30 = add i8* %t28, %s29
  store i8* %t30, i8** %l0
  store i1 1, i1* %l2
  br label %merge8
merge8:
  %t31 = phi i8* [ %t30, %then7 ], [ %t23, %then4 ]
  %t32 = phi i1 [ 1, %then7 ], [ %t25, %then4 ]
  store i8* %t31, i8** %l0
  store i1 %t32, i1* %l2
  br label %merge6
else5:
  %t33 = load i8*, i8** %l0
  %t34 = load i8, i8* %l3
  store i1 0, i1* %l2
  br label %merge6
merge6:
  %t35 = phi i8* [ %t30, %then4 ], [ null, %else5 ]
  %t36 = phi i1 [ 1, %then4 ], [ 0, %else5 ]
  store i8* %t35, i8** %l0
  store i1 %t36, i1* %l2
  %t37 = load double, double* %l1
  %t38 = sitofp i64 1 to double
  %t39 = fadd double %t37, %t38
  store double %t39, double* %l1
  br label %loop.latch2
loop.latch2:
  %t40 = load i8*, i8** %l0
  %t41 = load i1, i1* %l2
  %t42 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t46 = load i8*, i8** %l0
  %t47 = call i8* @trim_text(i8* %t46)
  ret i8* %t47
}

define i8* @tokens_to_source({ i8**, i64 }* %tokens) {
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
  %t22 = phi { i8**, i64 }* [ %t6, %entry ], [ %t20, %loop.latch2 ]
  %t23 = phi double [ %t7, %entry ], [ %t21, %loop.latch2 ]
  store { i8**, i64 }* %t22, { i8**, i64 }** %l0
  store double %t23, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t10 = load double, double* %l1
  %t11 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t12 = extractvalue { i8**, i64 } %t11, 0
  %t13 = extractvalue { i8**, i64 } %t11, 1
  %t14 = icmp uge i64 %t10, %t13
  ; bounds check: %t14 (if true, out of bounds)
  %t15 = getelementptr i8*, i8** %t12, i64 %t10
  %t16 = load i8*, i8** %t15
  %t17 = load double, double* %l1
  %t18 = sitofp i64 1 to double
  %t19 = fadd double %t17, %t18
  store double %t19, double* %l1
  br label %loop.latch2
loop.latch2:
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t21 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s25 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.25, i32 0, i32 0
  %t26 = call i8* @join_with_separator({ i8**, i64 }* %t24, i8* %s25)
  %t27 = call i8* @collapse_whitespace(i8* %t26)
  ret i8* %t27
}

define %TextBuilder @builder_new() {
entry:
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  %t5 = insertvalue %TextBuilder undef, { i8**, i64 }* null, 0
  %t6 = sitofp i64 0 to double
  %t7 = insertvalue %TextBuilder %t5, double %t6, 1
  ret %TextBuilder %t7
}

define %TextBuilder @builder_emit_line(%TextBuilder %builder, i8* %line) {
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
  %t5 = extractvalue %TextBuilder %builder, 1
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
  %t20 = call i8* @trim_right(i8* %line)
  %t21 = add i8* %t19, %t20
  store i8* %t21, i8** %l2
  %t22 = extractvalue %TextBuilder %builder, 0
  %t23 = load i8*, i8** %l2
  %t24 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t22, i8* %t23)
  store { i8**, i64 }* %t24, { i8**, i64 }** %l3
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t26 = insertvalue %TextBuilder undef, { i8**, i64 }* %t25, 0
  %t27 = extractvalue %TextBuilder %builder, 1
  %t28 = insertvalue %TextBuilder %t26, double %t27, 1
  ret %TextBuilder %t28
}

define %TextBuilder @builder_emit_blank(%TextBuilder %builder) {
entry:
  %l0 = alloca { i8**, i64 }*
  %t0 = extractvalue %TextBuilder %builder, 0
  %s1 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.1, i32 0, i32 0
  %t2 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t0, i8* %s1)
  store { i8**, i64 }* %t2, { i8**, i64 }** %l0
  %t3 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t4 = insertvalue %TextBuilder undef, { i8**, i64 }* %t3, 0
  %t5 = extractvalue %TextBuilder %builder, 1
  %t6 = insertvalue %TextBuilder %t4, double %t5, 1
  ret %TextBuilder %t6
}

define %TextBuilder @builder_push_indent(%TextBuilder %builder) {
entry:
  ret %TextBuilder zeroinitializer
}

define %TextBuilder @builder_pop_indent(%TextBuilder %builder) {
entry:
  %l0 = alloca double
  %t0 = extractvalue %TextBuilder %builder, 1
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
  %t9 = extractvalue %TextBuilder %builder, 0
  %t10 = insertvalue %TextBuilder undef, { i8**, i64 }* %t9, 0
  %t11 = load double, double* %l0
  %t12 = insertvalue %TextBuilder %t10, double %t11, 1
  ret %TextBuilder %t12
}

define i8* @builder_to_string(%TextBuilder %builder) {
entry:
  %l0 = alloca i8*
  %t0 = extractvalue %TextBuilder %builder, 0
  %s1 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.1, i32 0, i32 0
  %t2 = call i8* @join_with_separator({ i8**, i64 }* %t0, i8* %s1)
  store i8* %t2, i8** %l0
  %t3 = load i8*, i8** %l0
  %t4 = load i8*, i8** %l0
  %s5 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.5, i32 0, i32 0
  %t6 = add i8* %t4, %s5
  ret i8* %t6
}

define i8* @trim_right(i8* %value) {
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
  %t10 = call double @substring(i8* %value, i64 0, double %t9)
  ret i8* null
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
  %t20 = phi double [ %t1, %entry ], [ %t19, %loop.latch2 ]
  store double %t20, double* %l0
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
  %t12 = call i1 @is_trim_char(i8* null)
  %t13 = load double, double* %l0
  %t14 = load double, double* %l1
  %t15 = load i8, i8* %l2
  br i1 %t12, label %then6, label %merge7
then6:
  %t16 = load double, double* %l0
  %t17 = sitofp i64 1 to double
  %t18 = fadd double %t16, %t17
  store double %t18, double* %l0
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  %t19 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t21 = load double, double* %l0
  %t22 = load double, double* %l1
  br label %loop.header8
loop.header8:
  %t37 = phi double [ %t22, %entry ], [ %t36, %loop.latch10 ]
  store double %t37, double* %l1
  br label %loop.body9
loop.body9:
  %t23 = load double, double* %l1
  %t24 = load double, double* %l0
  %t25 = fcmp ole double %t23, %t24
  %t26 = load double, double* %l0
  %t27 = load double, double* %l1
  br i1 %t25, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  store double 0.0, double* %l3
  %t28 = load double, double* %l3
  %t29 = call i1 @is_trim_char(i8* null)
  %t30 = load double, double* %l0
  %t31 = load double, double* %l1
  %t32 = load double, double* %l3
  br i1 %t29, label %then14, label %merge15
then14:
  %t33 = load double, double* %l1
  %t34 = sitofp i64 1 to double
  %t35 = fsub double %t33, %t34
  store double %t35, double* %l1
  br label %loop.latch10
merge15:
  br label %afterloop11
loop.latch10:
  %t36 = load double, double* %l1
  br label %loop.header8
afterloop11:
  %t39 = load double, double* %l0
  %t40 = sitofp i64 0 to double
  %t41 = fcmp oeq double %t39, %t40
  br label %logical_and_entry_38

logical_and_entry_38:
  br i1 %t41, label %logical_and_right_38, label %logical_and_merge_38

logical_and_right_38:
  %t42 = load double, double* %l1
  %t43 = load double, double* %l0
  %t44 = load double, double* %l1
  %t45 = call double @substring(i8* %value, double %t43, double %t44)
  ret i8* null
}

define i1 @is_trim_char(i8* %ch) {
entry:
  %s3 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.3, i32 0, i32 0
  %t4 = icmp eq i8* %ch, %s3
  br label %logical_or_entry_2

logical_or_entry_2:
  br i1 %t4, label %logical_or_merge_2, label %logical_or_right_2

logical_or_right_2:
  %s5 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.5, i32 0, i32 0
  %t6 = icmp eq i8* %ch, %s5
  br label %logical_or_right_end_2

logical_or_right_end_2:
  br label %logical_or_merge_2

logical_or_merge_2:
  %t7 = phi i1 [ true, %logical_or_entry_2 ], [ %t6, %logical_or_right_end_2 ]
  br label %logical_or_entry_1

logical_or_entry_1:
  br i1 %t7, label %logical_or_merge_1, label %logical_or_right_1

logical_or_right_1:
  %s8 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.8, i32 0, i32 0
  %t9 = icmp eq i8* %ch, %s8
  br label %logical_or_right_end_1

logical_or_right_end_1:
  br label %logical_or_merge_1

logical_or_merge_1:
  %t10 = phi i1 [ true, %logical_or_entry_1 ], [ %t9, %logical_or_right_end_1 ]
  br label %logical_or_entry_0

logical_or_entry_0:
  br i1 %t10, label %logical_or_merge_0, label %logical_or_right_0

logical_or_right_0:
  %s11 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.11, i32 0, i32 0
  %t12 = icmp eq i8* %ch, %s11
  br label %logical_or_right_end_0

logical_or_right_end_0:
  br label %logical_or_merge_0

logical_or_merge_0:
  %t13 = phi i1 [ true, %logical_or_entry_0 ], [ %t12, %logical_or_right_end_0 ]
  ret i1 %t13
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
