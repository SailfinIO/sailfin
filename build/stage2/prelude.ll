; ModuleID = 'sailfin'
source_filename = "sailfin"

%EnumField = type { i8*, i8* }
%EnumVariantDefinition = type { i8*, { i8**, i64 }* }
%EnumType = type { i8*, { i8**, i64 }* }
%EnumInstance = type { i8*, i8*, { i8**, i64 }* }
%StructField = type { i8*, i8* }
%TypeDescriptor = type { i8*, i8*, { i8**, i64 }* }

declare i8* @sailfin_runtime_substring(i8*, i64, i64)

declare noalias i8* @malloc(i64)

@.str.0 = private unnamed_addr constant [1 x i8] c"\00"
@.str.19 = private unnamed_addr constant [1 x i8] c"\00"
@.str.2 = private unnamed_addr constant [11 x i8] c"0123456789\00"
@.str.16 = private unnamed_addr constant [27 x i8] c"abcdefghijklmnopqrstuvwxyz\00"
@.str.32 = private unnamed_addr constant [27 x i8] c"ABCDEFGHIJKLMNOPQRSTUVWXYZ\00"

define void @capability_grant(double %effects) {
entry:
  ret void zeroinitializer
}

define void @fs_bridge(double %grant) {
entry:
  ret void zeroinitializer
}

define void @http_bridge(double %grant) {
entry:
  ret void zeroinitializer
}

define void @model_bridge(double %grant) {
entry:
  ret void zeroinitializer
}

; fn sleep effects: ![clock]
define void @sleep(double %milliseconds) {
entry:
  ret void
}

; fn channel effects: ![io]
define void @channel(double %capacity) {
entry:
  ret void zeroinitializer
}

; fn parallel effects: ![io]
define void @parallel(double %tasks) {
entry:
  %l0 = alloca { double*, i64 }*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { double*, i64 }* %t2, { double*, i64 }** %l0
  %t5 = load { double*, i64 }*, { double*, i64 }** %l0
  ret void
}

; fn spawn effects: ![io]
define void @spawn(double %task, i8* %name) {
entry:
  ret void
}

define void @logExecution(double %callable) {
entry:
  ret void zeroinitializer
}

define void @array_map(double %items, double %mapper) {
entry:
  %l0 = alloca { double*, i64 }*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { double*, i64 }* %t2, { double*, i64 }** %l0
  %t5 = load { double*, i64 }*, { double*, i64 }** %l0
  ret void
}

define void @array_filter(double %items, double %predicate) {
entry:
  %l0 = alloca { double*, i64 }*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { double*, i64 }* %t2, { double*, i64 }** %l0
  %t5 = load { double*, i64 }*, { double*, i64 }** %l0
  ret void
}

define void @array_reduce(double %items, double %initial, double %reducer) {
entry:
  %l0 = alloca double
  store double %initial, double* %l0
  %t0 = load double, double* %l0
  ret void
}

define %EnumType @enum_type(i8* %name) {
entry:
  %t0 = insertvalue %EnumType undef, i8* %name, 0
  %t1 = alloca [0 x i8*]
  %t2 = getelementptr [0 x i8*], [0 x i8*]* %t1, i32 0, i32 0
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t2, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  %t6 = insertvalue %EnumType %t0, { i8**, i64 }* %t3, 1
  ret %EnumType %t6
}

define %EnumField @enum_field(i8* %name, double %value) {
entry:
  %t0 = insertvalue %EnumField undef, i8* %name, 0
  %t1 = insertvalue %EnumField %t0, i8* null, 1
  ret %EnumField %t1
}

define %EnumType @enum_define_variant(%EnumType %enum_type, i8* %variant_name, { i8**, i64 }* %field_names) {
entry:
  %l0 = alloca %EnumVariantDefinition
  %l1 = alloca { i8**, i64 }*
  %t0 = insertvalue %EnumVariantDefinition undef, i8* %variant_name, 0
  %t1 = insertvalue %EnumVariantDefinition %t0, { i8**, i64 }* %field_names, 1
  store %EnumVariantDefinition %t1, %EnumVariantDefinition* %l0
  %t2 = extractvalue %EnumType %enum_type, 1
  %t3 = load %EnumVariantDefinition, %EnumVariantDefinition* %l0
  %t4 = alloca [1 x %EnumVariantDefinition]
  %t5 = getelementptr [1 x %EnumVariantDefinition], [1 x %EnumVariantDefinition]* %t4, i32 0, i32 0
  %t6 = getelementptr %EnumVariantDefinition, %EnumVariantDefinition* %t5, i64 0
  store %EnumVariantDefinition %t3, %EnumVariantDefinition* %t6
  %t7 = alloca { %EnumVariantDefinition*, i64 }
  %t8 = getelementptr { %EnumVariantDefinition*, i64 }, { %EnumVariantDefinition*, i64 }* %t7, i32 0, i32 0
  store %EnumVariantDefinition* %t5, %EnumVariantDefinition** %t8
  %t9 = getelementptr { %EnumVariantDefinition*, i64 }, { %EnumVariantDefinition*, i64 }* %t7, i32 0, i32 1
  store i64 1, i64* %t9
  %t10 = bitcast { %EnumVariantDefinition*, i64 }* %t7 to { i8**, i64 }*
  %t11 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t2, { i8**, i64 }* %t10)
  store { i8**, i64 }* %t11, { i8**, i64 }** %l1
  %t12 = extractvalue %EnumType %enum_type, 0
  %t13 = insertvalue %EnumType undef, i8* %t12, 0
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t15 = insertvalue %EnumType %t13, { i8**, i64 }* %t14, 1
  ret %EnumType %t15
}

define { %EnumField*, i64 }* @enum_normalize_fields(i8* %definition, { %EnumField*, i64 }* %provided) {
entry:
  %l0 = alloca double
  %l1 = alloca { %EnumField*, i64 }*
  %l2 = alloca i64
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca i8*
  %t0 = icmp eq i8* %definition, null
  br i1 %t0, label %then0, label %merge1
then0:
  ret { %EnumField*, i64 }* %provided
merge1:
  store double 0.0, double* %l0
  %t1 = load double, double* %l0
  %t2 = alloca [0 x %EnumField]
  %t3 = getelementptr [0 x %EnumField], [0 x %EnumField]* %t2, i32 0, i32 0
  %t4 = alloca { %EnumField*, i64 }
  %t5 = getelementptr { %EnumField*, i64 }, { %EnumField*, i64 }* %t4, i32 0, i32 0
  store %EnumField* %t3, %EnumField** %t5
  %t6 = getelementptr { %EnumField*, i64 }, { %EnumField*, i64 }* %t4, i32 0, i32 1
  store i64 0, i64* %t6
  store { %EnumField*, i64 }* %t4, { %EnumField*, i64 }** %l1
  store i64 0, i64* %l2
  %t7 = load double, double* %l0
  %t8 = load { %EnumField*, i64 }*, { %EnumField*, i64 }** %l1
  %t9 = load i64, i64* %l2
  br label %loop.header2
loop.header2:
  %t36 = phi { %EnumField*, i64 }* [ %t8, %entry ], [ %t34, %loop.latch4 ]
  %t37 = phi i64 [ %t9, %entry ], [ %t35, %loop.latch4 ]
  store { %EnumField*, i64 }* %t36, { %EnumField*, i64 }** %l1
  store i64 %t37, i64* %l2
  br label %loop.body3
loop.body3:
  %t10 = load i64, i64* %l2
  %t11 = load double, double* %l0
  %t12 = load double, double* %l0
  %t13 = load i64, i64* %l2
  store double 0.0, double* %l3
  %t14 = load double, double* %l3
  %t15 = call double @enum_lookup_field({ %EnumField*, i64 }* %provided, i8* null)
  store double %t15, double* %l4
  store i8* null, i8** %l5
  %t16 = load double, double* %l4
  %t17 = load { %EnumField*, i64 }*, { %EnumField*, i64 }** %l1
  %t18 = load double, double* %l3
  %t19 = insertvalue %EnumField undef, i8* null, 0
  %t20 = load i8*, i8** %l5
  %t21 = insertvalue %EnumField %t19, i8* %t20, 1
  %t22 = alloca [1 x %EnumField]
  %t23 = getelementptr [1 x %EnumField], [1 x %EnumField]* %t22, i32 0, i32 0
  %t24 = getelementptr %EnumField, %EnumField* %t23, i64 0
  store %EnumField %t21, %EnumField* %t24
  %t25 = alloca { %EnumField*, i64 }
  %t26 = getelementptr { %EnumField*, i64 }, { %EnumField*, i64 }* %t25, i32 0, i32 0
  store %EnumField* %t23, %EnumField** %t26
  %t27 = getelementptr { %EnumField*, i64 }, { %EnumField*, i64 }* %t25, i32 0, i32 1
  store i64 1, i64* %t27
  %t28 = bitcast { %EnumField*, i64 }* %t17 to { i8**, i64 }*
  %t29 = bitcast { %EnumField*, i64 }* %t25 to { i8**, i64 }*
  %t30 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t28, { i8**, i64 }* %t29)
  %t31 = bitcast { i8**, i64 }* %t30 to { %EnumField*, i64 }*
  store { %EnumField*, i64 }* %t31, { %EnumField*, i64 }** %l1
  %t32 = load i64, i64* %l2
  %t33 = add i64 %t32, 1
  store i64 %t33, i64* %l2
  br label %loop.latch4
loop.latch4:
  %t34 = load { %EnumField*, i64 }*, { %EnumField*, i64 }** %l1
  %t35 = load i64, i64* %l2
  br label %loop.header2
afterloop5:
  %t38 = load { %EnumField*, i64 }*, { %EnumField*, i64 }** %l1
  ret { %EnumField*, i64 }* %t38
}

define %EnumInstance @enum_instantiate(%EnumType %enum_type, i8* %variant_name, { %EnumField*, i64 }* %provided) {
entry:
  %l0 = alloca double
  %l1 = alloca { %EnumField*, i64 }*
  %t0 = call double @enum_find_variant(%EnumType %enum_type, i8* %variant_name)
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  %t2 = call { %EnumField*, i64 }* @enum_normalize_fields(i8* null, { %EnumField*, i64 }* %provided)
  store { %EnumField*, i64 }* %t2, { %EnumField*, i64 }** %l1
  %t3 = insertvalue %EnumInstance undef, i8* null, 0
  %t4 = insertvalue %EnumInstance %t3, i8* %variant_name, 1
  %t5 = load { %EnumField*, i64 }*, { %EnumField*, i64 }** %l1
  %t6 = bitcast { %EnumField*, i64 }* %t5 to { i8**, i64 }*
  %t7 = insertvalue %EnumInstance %t4, { i8**, i64 }* %t6, 2
  ret %EnumInstance %t7
}

define void @enum_get_field(%EnumInstance %instance, i8* %name) {
entry:
  %l0 = alloca i64
  %l1 = alloca i8*
  store i64 0, i64* %l0
  %t0 = load i64, i64* %l0
  br label %loop.header0
loop.header0:
  %t19 = phi i64 [ %t0, %entry ], [ %t18, %loop.latch2 ]
  store i64 %t19, i64* %l0
  br label %loop.body1
loop.body1:
  %t1 = load i64, i64* %l0
  %t2 = extractvalue %EnumInstance %instance, 2
  %t3 = load { i8**, i64 }, { i8**, i64 }* %t2
  %t4 = extractvalue { i8**, i64 } %t3, 1
  %t5 = icmp sge i64 %t1, %t4
  %t6 = load i64, i64* %l0
  br i1 %t5, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t7 = extractvalue %EnumInstance %instance, 2
  %t8 = load i64, i64* %l0
  %t9 = load { i8**, i64 }, { i8**, i64 }* %t7
  %t10 = extractvalue { i8**, i64 } %t9, 0
  %t11 = extractvalue { i8**, i64 } %t9, 1
  %t12 = icmp uge i64 %t8, %t11
  ; bounds check: %t12 (if true, out of bounds)
  %t13 = getelementptr i8*, i8** %t10, i64 %t8
  %t14 = load i8*, i8** %t13
  store i8* %t14, i8** %l1
  %t15 = load i8*, i8** %l1
  %t16 = load i64, i64* %l0
  %t17 = add i64 %t16, 1
  store i64 %t17, i64* %l0
  br label %loop.latch2
loop.latch2:
  %t18 = load i64, i64* %l0
  br label %loop.header0
afterloop3:
  ret void
}

define %StructField @struct_field(i8* %name, double %value) {
entry:
  %t0 = insertvalue %StructField undef, i8* %name, 0
  %t1 = insertvalue %StructField %t0, i8* null, 1
  ret %StructField %t1
}

define i8* @struct_repr(i8* %name, { %StructField*, i64 }* %fields) {
entry:
  %l0 = alloca i8
  %l1 = alloca i64
  %l2 = alloca %StructField
  %l3 = alloca i8*
  %t0 = getelementptr i8, i8* %name, i64 0
  %t1 = load i8, i8* %t0
  %t2 = add i8 %t1, 40
  store i8 %t2, i8* %l0
  store i64 0, i64* %l1
  %t3 = load i8, i8* %l0
  %t4 = load i64, i64* %l1
  br label %loop.header0
loop.header0:
  %t46 = phi i8 [ %t3, %entry ], [ %t44, %loop.latch2 ]
  %t47 = phi i64 [ %t4, %entry ], [ %t45, %loop.latch2 ]
  store i8 %t46, i8* %l0
  store i64 %t47, i64* %l1
  br label %loop.body1
loop.body1:
  %t5 = load i64, i64* %l1
  %t6 = load { %StructField*, i64 }, { %StructField*, i64 }* %fields
  %t7 = extractvalue { %StructField*, i64 } %t6, 1
  %t8 = icmp sge i64 %t5, %t7
  %t9 = load i8, i8* %l0
  %t10 = load i64, i64* %l1
  br i1 %t8, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t11 = load i64, i64* %l1
  %t12 = icmp sgt i64 %t11, 0
  %t13 = load i8, i8* %l0
  %t14 = load i64, i64* %l1
  br i1 %t12, label %then6, label %merge7
then6:
  %t15 = load i8, i8* %l0
  %s16 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.16, i32 0, i32 0
  %t17 = getelementptr i8, i8* %s16, i64 0
  %t18 = load i8, i8* %t17
  %t19 = add i8 %t15, %t18
  store i8 %t19, i8* %l0
  br label %merge7
merge7:
  %t20 = phi i8 [ %t19, %then6 ], [ %t13, %loop.body1 ]
  store i8 %t20, i8* %l0
  %t21 = load i64, i64* %l1
  %t22 = load { %StructField*, i64 }, { %StructField*, i64 }* %fields
  %t23 = extractvalue { %StructField*, i64 } %t22, 0
  %t24 = extractvalue { %StructField*, i64 } %t22, 1
  %t25 = icmp uge i64 %t21, %t24
  ; bounds check: %t25 (if true, out of bounds)
  %t26 = getelementptr %StructField, %StructField* %t23, i64 %t21
  %t27 = load %StructField, %StructField* %t26
  store %StructField %t27, %StructField* %l2
  %t28 = load %StructField, %StructField* %l2
  %t29 = extractvalue %StructField %t28, 1
  %t30 = call i8* @to_debug_string(double 0.0)
  store i8* %t30, i8** %l3
  %t31 = load i8, i8* %l0
  %t32 = load %StructField, %StructField* %l2
  %t33 = extractvalue %StructField %t32, 0
  %t34 = getelementptr i8, i8* %t33, i64 0
  %t35 = load i8, i8* %t34
  %t36 = add i8 %t31, %t35
  %t37 = add i8 %t36, 61
  %t38 = load i8*, i8** %l3
  %t39 = getelementptr i8, i8* %t38, i64 0
  %t40 = load i8, i8* %t39
  %t41 = add i8 %t37, %t40
  store i8 %t41, i8* %l0
  %t42 = load i64, i64* %l1
  %t43 = add i64 %t42, 1
  store i64 %t43, i64* %l1
  br label %loop.latch2
loop.latch2:
  %t44 = load i8, i8* %l0
  %t45 = load i64, i64* %l1
  br label %loop.header0
afterloop3:
  %t48 = load i8, i8* %l0
  ret i8* null
}

define i8* @to_debug_string(double %value) {
entry:
  ret i8* null
}

define i8* @format_interpolated({ i8**, i64 }* %parts, { i8**, i64 }* %values) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i64
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l0
  store i64 0, i64* %l1
  %t1 = load i8*, i8** %l0
  %t2 = load i64, i64* %l1
  br label %loop.header0
loop.header0:
  %t39 = phi i8* [ %t1, %entry ], [ %t37, %loop.latch2 ]
  %t40 = phi i64 [ %t2, %entry ], [ %t38, %loop.latch2 ]
  store i8* %t39, i8** %l0
  store i64 %t40, i64* %l1
  br label %loop.body1
loop.body1:
  %t3 = load i64, i64* %l1
  %t4 = load { i8**, i64 }, { i8**, i64 }* %parts
  %t5 = extractvalue { i8**, i64 } %t4, 1
  %t6 = icmp sge i64 %t3, %t5
  %t7 = load i8*, i8** %l0
  %t8 = load i64, i64* %l1
  br i1 %t6, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t9 = load i8*, i8** %l0
  %t10 = load i64, i64* %l1
  %t11 = load { i8**, i64 }, { i8**, i64 }* %parts
  %t12 = extractvalue { i8**, i64 } %t11, 0
  %t13 = extractvalue { i8**, i64 } %t11, 1
  %t14 = icmp uge i64 %t10, %t13
  ; bounds check: %t14 (if true, out of bounds)
  %t15 = getelementptr i8*, i8** %t12, i64 %t10
  %t16 = load i8*, i8** %t15
  %t17 = add i8* %t9, %t16
  store i8* %t17, i8** %l0
  %t18 = load i64, i64* %l1
  %t19 = load { i8**, i64 }, { i8**, i64 }* %values
  %t20 = extractvalue { i8**, i64 } %t19, 1
  %t21 = icmp slt i64 %t18, %t20
  %t22 = load i8*, i8** %l0
  %t23 = load i64, i64* %l1
  br i1 %t21, label %then6, label %merge7
then6:
  %t24 = load i8*, i8** %l0
  %t25 = load i64, i64* %l1
  %t26 = load { i8**, i64 }, { i8**, i64 }* %values
  %t27 = extractvalue { i8**, i64 } %t26, 0
  %t28 = extractvalue { i8**, i64 } %t26, 1
  %t29 = icmp uge i64 %t25, %t28
  ; bounds check: %t29 (if true, out of bounds)
  %t30 = getelementptr i8*, i8** %t27, i64 %t25
  %t31 = load i8*, i8** %t30
  %t32 = call i8* @to_debug_string(double 0.0)
  %t33 = add i8* %t24, %t32
  store i8* %t33, i8** %l0
  br label %merge7
merge7:
  %t34 = phi i8* [ %t33, %then6 ], [ %t22, %loop.body1 ]
  store i8* %t34, i8** %l0
  %t35 = load i64, i64* %l1
  %t36 = add i64 %t35, 1
  store i64 %t36, i64* %l1
  br label %loop.latch2
loop.latch2:
  %t37 = load i8*, i8** %l0
  %t38 = load i64, i64* %l1
  br label %loop.header0
afterloop3:
  %t41 = load i8*, i8** %l0
  ret i8* %t41
}

define %TypeDescriptor @type_descriptor(i8* %kind, i8* %name, { %TypeDescriptor*, i64 }* %items) {
entry:
  %t0 = insertvalue %TypeDescriptor undef, i8* %kind, 0
  %t1 = insertvalue %TypeDescriptor %t0, i8* %name, 1
  %t2 = bitcast { %TypeDescriptor*, i64 }* %items to { i8**, i64 }*
  %t3 = insertvalue %TypeDescriptor %t1, { i8**, i64 }* %t2, 2
  ret %TypeDescriptor %t3
}

define %TypeDescriptor @type_descriptor_primitive(i8* %name) {
entry:
  %s0 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.0, i32 0, i32 0
  %t1 = alloca [0 x double]
  %t2 = getelementptr [0 x double], [0 x double]* %t1, i32 0, i32 0
  %t3 = alloca { double*, i64 }
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 0
  store double* %t2, double** %t4
  %t5 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  %t6 = bitcast { double*, i64 }* %t3 to { %TypeDescriptor*, i64 }*
  %t7 = call %TypeDescriptor @type_descriptor(i8* %s0, i8* %name, { %TypeDescriptor*, i64 }* %t6)
  ret %TypeDescriptor %t7
}

define %TypeDescriptor @type_descriptor_union({ %TypeDescriptor*, i64 }* %descriptors) {
entry:
  %s0 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.0, i32 0, i32 0
  %t1 = call %TypeDescriptor @type_descriptor(i8* %s0, i8* null, { %TypeDescriptor*, i64 }* %descriptors)
  ret %TypeDescriptor %t1
}

define %TypeDescriptor @type_descriptor_intersection({ %TypeDescriptor*, i64 }* %descriptors) {
entry:
  %s0 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.0, i32 0, i32 0
  %t1 = call %TypeDescriptor @type_descriptor(i8* %s0, i8* null, { %TypeDescriptor*, i64 }* %descriptors)
  ret %TypeDescriptor %t1
}

define %TypeDescriptor @type_descriptor_array(%TypeDescriptor %inner) {
entry:
  %s0 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.0, i32 0, i32 0
  %t1 = alloca [1 x %TypeDescriptor]
  %t2 = getelementptr [1 x %TypeDescriptor], [1 x %TypeDescriptor]* %t1, i32 0, i32 0
  %t3 = getelementptr %TypeDescriptor, %TypeDescriptor* %t2, i64 0
  store %TypeDescriptor %inner, %TypeDescriptor* %t3
  %t4 = alloca { %TypeDescriptor*, i64 }
  %t5 = getelementptr { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* %t4, i32 0, i32 0
  store %TypeDescriptor* %t2, %TypeDescriptor** %t5
  %t6 = getelementptr { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* %t4, i32 0, i32 1
  store i64 1, i64* %t6
  %t7 = call %TypeDescriptor @type_descriptor(i8* %s0, i8* null, { %TypeDescriptor*, i64 }* %t4)
  ret %TypeDescriptor %t7
}

define %TypeDescriptor @type_descriptor_function() {
entry:
  %s0 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.0, i32 0, i32 0
  %t1 = alloca [0 x double]
  %t2 = getelementptr [0 x double], [0 x double]* %t1, i32 0, i32 0
  %t3 = alloca { double*, i64 }
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 0
  store double* %t2, double** %t4
  %t5 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  %t6 = bitcast { double*, i64 }* %t3 to { %TypeDescriptor*, i64 }*
  %t7 = call %TypeDescriptor @type_descriptor(i8* %s0, i8* null, { %TypeDescriptor*, i64 }* %t6)
  ret %TypeDescriptor %t7
}

define %TypeDescriptor @type_descriptor_named(i8* %name) {
entry:
  %s0 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.0, i32 0, i32 0
  %t1 = alloca [0 x double]
  %t2 = getelementptr [0 x double], [0 x double]* %t1, i32 0, i32 0
  %t3 = alloca { double*, i64 }
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 0
  store double* %t2, double** %t4
  %t5 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  %t6 = bitcast { double*, i64 }* %t3 to { %TypeDescriptor*, i64 }*
  %t7 = call %TypeDescriptor @type_descriptor(i8* %s0, i8* %name, { %TypeDescriptor*, i64 }* %t6)
  ret %TypeDescriptor %t7
}

define %TypeDescriptor @type_descriptor_unknown() {
entry:
  %s0 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.0, i32 0, i32 0
  %t1 = alloca [0 x double]
  %t2 = getelementptr [0 x double], [0 x double]* %t1, i32 0, i32 0
  %t3 = alloca { double*, i64 }
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 0
  store double* %t2, double** %t4
  %t5 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  %t6 = bitcast { double*, i64 }* %t3 to { %TypeDescriptor*, i64 }*
  %t7 = call %TypeDescriptor @type_descriptor(i8* %s0, i8* null, { %TypeDescriptor*, i64 }* %t6)
  ret %TypeDescriptor %t7
}

define i8* @descriptor_trim(i8* %value) {
entry:
  %l0 = alloca i64
  %l1 = alloca double
  %l2 = alloca i8
  %l3 = alloca double
  store i64 0, i64* %l0
  store double 0.0, double* %l1
  %t0 = load i64, i64* %l0
  %t1 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t31 = phi i64 [ %t0, %entry ], [ %t30, %loop.latch2 ]
  store i64 %t31, i64* %l0
  br label %loop.body1
loop.body1:
  %t2 = load i64, i64* %l0
  %t3 = load double, double* %l1
  %t4 = sitofp i64 %t2 to double
  %t5 = fcmp oge double %t4, %t3
  %t6 = load i64, i64* %l0
  %t7 = load double, double* %l1
  br i1 %t5, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t8 = load i64, i64* %l0
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
  %t20 = icmp eq i8 %t19, 9
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
  %t23 = icmp eq i8 %t22, 13
  br label %logical_or_right_end_11

logical_or_right_end_11:
  br label %logical_or_merge_11

logical_or_merge_11:
  %t24 = phi i1 [ true, %logical_or_entry_11 ], [ %t23, %logical_or_right_end_11 ]
  %t25 = load i64, i64* %l0
  %t26 = load double, double* %l1
  %t27 = load i8, i8* %l2
  br i1 %t24, label %then6, label %merge7
then6:
  %t28 = load i64, i64* %l0
  %t29 = add i64 %t28, 1
  store i64 %t29, i64* %l0
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  %t30 = load i64, i64* %l0
  br label %loop.header0
afterloop3:
  %t32 = load i64, i64* %l0
  %t33 = load double, double* %l1
  br label %loop.header8
loop.header8:
  br label %loop.body9
loop.body9:
  %t34 = load double, double* %l1
  %t35 = load i64, i64* %l0
  %t36 = sitofp i64 %t35 to double
  %t37 = fcmp ole double %t34, %t36
  %t38 = load i64, i64* %l0
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
  %t44 = load i64, i64* %l0
  %t45 = load double, double* %l1
  %t46 = sitofp i64 %t44 to double
  %t47 = call i8* @sailfin_runtime_substring(i8* %value, double %t46, double %t45)
  ret i8* %t47
}

define i1 @string_starts_with(i8* %value, i8* %prefix) {
entry:
  %l0 = alloca i64
  store i64 0, i64* %l0
  %t0 = load i64, i64* %l0
  br label %loop.header0
loop.header0:
  %t13 = phi i64 [ %t0, %entry ], [ %t12, %loop.latch2 ]
  store i64 %t13, i64* %l0
  br label %loop.body1
loop.body1:
  %t1 = load i64, i64* %l0
  %t2 = load i64, i64* %l0
  %t3 = getelementptr i8, i8* %value, i64 %t2
  %t4 = load i8, i8* %t3
  %t5 = load i64, i64* %l0
  %t6 = getelementptr i8, i8* %prefix, i64 %t5
  %t7 = load i8, i8* %t6
  %t8 = icmp ne i8 %t4, %t7
  %t9 = load i64, i64* %l0
  br i1 %t8, label %then4, label %merge5
then4:
  ret i1 0
merge5:
  %t10 = load i64, i64* %l0
  %t11 = add i64 %t10, 1
  store i64 %t11, i64* %l0
  br label %loop.latch2
loop.latch2:
  %t12 = load i64, i64* %l0
  br label %loop.header0
afterloop3:
  ret i1 1
}

define i1 @string_ends_with(i8* %value, i8* %suffix) {
entry:
  %l0 = alloca double
  %l1 = alloca i64
  store double 0.0, double* %l0
  store i64 0, i64* %l1
  %t0 = load double, double* %l0
  %t1 = load i64, i64* %l1
  br label %loop.header0
loop.header0:
  %t6 = phi i64 [ %t1, %entry ], [ %t5, %loop.latch2 ]
  store i64 %t6, i64* %l1
  br label %loop.body1
loop.body1:
  %t2 = load i64, i64* %l1
  %t3 = load i64, i64* %l1
  %t4 = add i64 %t3, 1
  store i64 %t4, i64* %l1
  br label %loop.latch2
loop.latch2:
  %t5 = load i64, i64* %l1
  br label %loop.header0
afterloop3:
  ret i1 1
}

define double @descriptor_find_top_level(i8* %value, i8* %needle) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8
  %l2 = alloca i64
  %l3 = alloca i64
  %l4 = alloca i64
  %l5 = alloca i64
  %l6 = alloca i8
  %t0 = call i8* @descriptor_trim(i8* %value)
  store i8* %t0, i8** %l0
  %t1 = getelementptr i8, i8* %needle, i64 0
  %t2 = load i8, i8* %t1
  store i8 %t2, i8* %l1
  store i64 0, i64* %l2
  store i64 0, i64* %l3
  store i64 0, i64* %l4
  store i64 0, i64* %l5
  %t3 = load i8*, i8** %l0
  %t4 = load i8, i8* %l1
  %t5 = load i64, i64* %l2
  %t6 = load i64, i64* %l3
  %t7 = load i64, i64* %l4
  %t8 = load i64, i64* %l5
  br label %loop.header0
loop.header0:
  %t78 = phi i64 [ %t6, %entry ], [ %t76, %loop.latch2 ]
  %t79 = phi i64 [ %t5, %entry ], [ %t77, %loop.latch2 ]
  store i64 %t78, i64* %l3
  store i64 %t79, i64* %l2
  br label %loop.body1
loop.body1:
  %t9 = load i64, i64* %l2
  %t10 = load i8*, i8** %l0
  %t11 = load i8*, i8** %l0
  %t12 = load i64, i64* %l2
  %t13 = getelementptr i8, i8* %t11, i64 %t12
  %t14 = load i8, i8* %t13
  store i8 %t14, i8* %l6
  %t15 = load i8, i8* %l6
  %t16 = icmp eq i8 %t15, 40
  %t17 = load i8*, i8** %l0
  %t18 = load i8, i8* %l1
  %t19 = load i64, i64* %l2
  %t20 = load i64, i64* %l3
  %t21 = load i64, i64* %l4
  %t22 = load i64, i64* %l5
  %t23 = load i8, i8* %l6
  br i1 %t16, label %then4, label %else5
then4:
  %t24 = load i64, i64* %l3
  %t25 = add i64 %t24, 1
  store i64 %t25, i64* %l3
  br label %merge6
else5:
  %t26 = load i8, i8* %l6
  %t27 = icmp eq i8 %t26, 41
  %t28 = load i8*, i8** %l0
  %t29 = load i8, i8* %l1
  %t30 = load i64, i64* %l2
  %t31 = load i64, i64* %l3
  %t32 = load i64, i64* %l4
  %t33 = load i64, i64* %l5
  %t34 = load i8, i8* %l6
  br i1 %t27, label %then7, label %else8
then7:
  %t35 = load i64, i64* %l3
  %t36 = icmp sgt i64 %t35, 0
  %t37 = load i8*, i8** %l0
  %t38 = load i8, i8* %l1
  %t39 = load i64, i64* %l2
  %t40 = load i64, i64* %l3
  %t41 = load i64, i64* %l4
  %t42 = load i64, i64* %l5
  %t43 = load i8, i8* %l6
  br i1 %t36, label %then10, label %merge11
then10:
  %t44 = load i64, i64* %l3
  %t45 = sub i64 %t44, 1
  store i64 %t45, i64* %l3
  br label %merge11
merge11:
  %t46 = phi i64 [ %t45, %then10 ], [ %t40, %then7 ]
  store i64 %t46, i64* %l3
  br label %merge9
else8:
  %t47 = load i8, i8* %l6
  br label %merge9
merge9:
  %t48 = phi i64 [ %t45, %then7 ], [ %t31, %else8 ]
  store i64 %t48, i64* %l3
  br label %merge6
merge6:
  %t49 = phi i64 [ %t25, %then4 ], [ %t45, %else5 ]
  store i64 %t49, i64* %l3
  %t53 = load i8, i8* %l6
  %t54 = load i8, i8* %l1
  %t55 = icmp eq i8 %t53, %t54
  br label %logical_and_entry_52

logical_and_entry_52:
  br i1 %t55, label %logical_and_right_52, label %logical_and_merge_52

logical_and_right_52:
  %t56 = load i64, i64* %l3
  %t57 = icmp eq i64 %t56, 0
  br label %logical_and_right_end_52

logical_and_right_end_52:
  br label %logical_and_merge_52

logical_and_merge_52:
  %t58 = phi i1 [ false, %logical_and_entry_52 ], [ %t57, %logical_and_right_end_52 ]
  br label %logical_and_entry_51

logical_and_entry_51:
  br i1 %t58, label %logical_and_right_51, label %logical_and_merge_51

logical_and_right_51:
  %t59 = load i64, i64* %l4
  %t60 = icmp eq i64 %t59, 0
  br label %logical_and_right_end_51

logical_and_right_end_51:
  br label %logical_and_merge_51

logical_and_merge_51:
  %t61 = phi i1 [ false, %logical_and_entry_51 ], [ %t60, %logical_and_right_end_51 ]
  br label %logical_and_entry_50

logical_and_entry_50:
  br i1 %t61, label %logical_and_right_50, label %logical_and_merge_50

logical_and_right_50:
  %t62 = load i64, i64* %l5
  %t63 = icmp eq i64 %t62, 0
  br label %logical_and_right_end_50

logical_and_right_end_50:
  br label %logical_and_merge_50

logical_and_merge_50:
  %t64 = phi i1 [ false, %logical_and_entry_50 ], [ %t63, %logical_and_right_end_50 ]
  %t65 = load i8*, i8** %l0
  %t66 = load i8, i8* %l1
  %t67 = load i64, i64* %l2
  %t68 = load i64, i64* %l3
  %t69 = load i64, i64* %l4
  %t70 = load i64, i64* %l5
  %t71 = load i8, i8* %l6
  br i1 %t64, label %then12, label %merge13
then12:
  %t72 = load i64, i64* %l2
  %t73 = sitofp i64 %t72 to double
  ret double %t73
merge13:
  %t74 = load i64, i64* %l2
  %t75 = add i64 %t74, 1
  store i64 %t75, i64* %l2
  br label %loop.latch2
loop.latch2:
  %t76 = load i64, i64* %l3
  %t77 = load i64, i64* %l2
  br label %loop.header0
afterloop3:
  %t80 = sitofp i64 -1 to double
  ret double %t80
}

define i8* @descriptor_strip_outer_parens(i8* %value) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i64
  %l2 = alloca i64
  %l3 = alloca i1
  %l4 = alloca i8
  %t0 = call i8* @descriptor_trim(i8* %value)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  br label %loop.header0
loop.header0:
  %t75 = phi i8* [ %t1, %entry ], [ %t74, %loop.latch2 ]
  store i8* %t75, i8** %l0
  br label %loop.body1
loop.body1:
  %t2 = load i8*, i8** %l0
  %t3 = load i8*, i8** %l0
  %t4 = getelementptr i8, i8* %t3, i64 0
  %t5 = load i8, i8* %t4
  %t6 = icmp ne i8 %t5, 40
  %t7 = load i8*, i8** %l0
  br i1 %t6, label %then4, label %merge5
then4:
  %t8 = load i8*, i8** %l0
  ret i8* %t8
merge5:
  store i64 0, i64* %l1
  store i64 0, i64* %l2
  store i1 1, i1* %l3
  %t9 = load i8*, i8** %l0
  %t10 = load i64, i64* %l1
  %t11 = load i64, i64* %l2
  %t12 = load i1, i1* %l3
  br label %loop.header6
loop.header6:
  %t58 = phi i64 [ %t10, %loop.body1 ], [ %t55, %loop.latch8 ]
  %t59 = phi i1 [ %t12, %loop.body1 ], [ %t56, %loop.latch8 ]
  %t60 = phi i64 [ %t11, %loop.body1 ], [ %t57, %loop.latch8 ]
  store i64 %t58, i64* %l1
  store i1 %t59, i1* %l3
  store i64 %t60, i64* %l2
  br label %loop.body7
loop.body7:
  %t13 = load i64, i64* %l2
  %t14 = load i8*, i8** %l0
  %t15 = load i8*, i8** %l0
  %t16 = load i64, i64* %l2
  %t17 = getelementptr i8, i8* %t15, i64 %t16
  %t18 = load i8, i8* %t17
  store i8 %t18, i8* %l4
  %t19 = load i8, i8* %l4
  %t20 = icmp eq i8 %t19, 40
  %t21 = load i8*, i8** %l0
  %t22 = load i64, i64* %l1
  %t23 = load i64, i64* %l2
  %t24 = load i1, i1* %l3
  %t25 = load i8, i8* %l4
  br i1 %t20, label %then10, label %else11
then10:
  %t26 = load i64, i64* %l1
  %t27 = add i64 %t26, 1
  store i64 %t27, i64* %l1
  br label %merge12
else11:
  %t28 = load i8, i8* %l4
  %t29 = icmp eq i8 %t28, 41
  %t30 = load i8*, i8** %l0
  %t31 = load i64, i64* %l1
  %t32 = load i64, i64* %l2
  %t33 = load i1, i1* %l3
  %t34 = load i8, i8* %l4
  br i1 %t29, label %then13, label %merge14
then13:
  %t35 = load i64, i64* %l1
  %t36 = sub i64 %t35, 1
  store i64 %t36, i64* %l1
  %t37 = load i64, i64* %l1
  %t38 = icmp slt i64 %t37, 0
  %t39 = load i8*, i8** %l0
  %t40 = load i64, i64* %l1
  %t41 = load i64, i64* %l2
  %t42 = load i1, i1* %l3
  %t43 = load i8, i8* %l4
  br i1 %t38, label %then15, label %merge16
then15:
  store i1 0, i1* %l3
  br label %afterloop9
merge16:
  %t45 = load i64, i64* %l1
  %t46 = icmp eq i64 %t45, 0
  br label %logical_and_entry_44

logical_and_entry_44:
  br i1 %t46, label %logical_and_right_44, label %logical_and_merge_44

logical_and_right_44:
  %t47 = load i64, i64* %l2
  %t48 = load i8*, i8** %l0
  br label %merge14
merge14:
  %t49 = phi i64 [ %t36, %then13 ], [ %t31, %else11 ]
  %t50 = phi i1 [ 0, %then13 ], [ %t33, %else11 ]
  store i64 %t49, i64* %l1
  store i1 %t50, i1* %l3
  br label %merge12
merge12:
  %t51 = phi i64 [ %t27, %then10 ], [ %t36, %else11 ]
  %t52 = phi i1 [ %t24, %then10 ], [ 0, %else11 ]
  store i64 %t51, i64* %l1
  store i1 %t52, i1* %l3
  %t53 = load i64, i64* %l2
  %t54 = add i64 %t53, 1
  store i64 %t54, i64* %l2
  br label %loop.latch8
loop.latch8:
  %t55 = load i64, i64* %l1
  %t56 = load i1, i1* %l3
  %t57 = load i64, i64* %l2
  br label %loop.header6
afterloop9:
  %t62 = load i1, i1* %l3
  br label %logical_or_entry_61

logical_or_entry_61:
  br i1 %t62, label %logical_or_merge_61, label %logical_or_right_61

logical_or_right_61:
  %t63 = load i64, i64* %l1
  %t64 = icmp ne i64 %t63, 0
  br label %logical_or_right_end_61

logical_or_right_end_61:
  br label %logical_or_merge_61

logical_or_merge_61:
  %t65 = phi i1 [ true, %logical_or_entry_61 ], [ %t64, %logical_or_right_end_61 ]
  %t66 = xor i1 %t65, 1
  %t67 = load i8*, i8** %l0
  %t68 = load i64, i64* %l1
  %t69 = load i64, i64* %l2
  %t70 = load i1, i1* %l3
  br i1 %t66, label %then17, label %merge18
then17:
  %t71 = load i8*, i8** %l0
  ret i8* %t71
merge18:
  %t72 = load i8*, i8** %l0
  %t73 = load i8*, i8** %l0
  br label %loop.latch2
loop.latch2:
  %t74 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  ret i8* null
}

define { i8**, i64 }* @split_descriptor(i8* %value, i8* %separator) {
entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca i64
  %l3 = alloca i64
  %l4 = alloca i64
  %l5 = alloca i64
  %l6 = alloca i64
  %l7 = alloca i8
  %l8 = alloca i8
  %l9 = alloca i8*
  %l10 = alloca double
  %l11 = alloca i8*
  %t0 = call i8* @descriptor_trim(i8* %value)
  store i8* %t0, i8** %l0
  %t1 = alloca [0 x i8*]
  %t2 = getelementptr [0 x i8*], [0 x i8*]* %t1, i32 0, i32 0
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t2, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { i8**, i64 }* %t3, { i8**, i64 }** %l1
  store i64 0, i64* %l2
  store i64 0, i64* %l3
  store i64 0, i64* %l4
  store i64 0, i64* %l5
  store i64 0, i64* %l6
  %t6 = getelementptr i8, i8* %separator, i64 0
  %t7 = load i8, i8* %t6
  store i8 %t7, i8* %l7
  %t8 = load i8*, i8** %l0
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t10 = load i64, i64* %l2
  %t11 = load i64, i64* %l3
  %t12 = load i64, i64* %l4
  %t13 = load i64, i64* %l5
  %t14 = load i64, i64* %l6
  %t15 = load i8, i8* %l7
  br label %loop.header0
loop.header0:
  %t113 = phi i64 [ %t12, %entry ], [ %t109, %loop.latch2 ]
  %t114 = phi { i8**, i64 }* [ %t9, %entry ], [ %t110, %loop.latch2 ]
  %t115 = phi i64 [ %t10, %entry ], [ %t111, %loop.latch2 ]
  %t116 = phi i64 [ %t11, %entry ], [ %t112, %loop.latch2 ]
  store i64 %t113, i64* %l4
  store { i8**, i64 }* %t114, { i8**, i64 }** %l1
  store i64 %t115, i64* %l2
  store i64 %t116, i64* %l3
  br label %loop.body1
loop.body1:
  %t16 = load i64, i64* %l3
  %t17 = load i8*, i8** %l0
  %t18 = load i8*, i8** %l0
  %t19 = load i64, i64* %l3
  %t20 = getelementptr i8, i8* %t18, i64 %t19
  %t21 = load i8, i8* %t20
  store i8 %t21, i8* %l8
  %t22 = load i8, i8* %l8
  %t23 = icmp eq i8 %t22, 40
  %t24 = load i8*, i8** %l0
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t26 = load i64, i64* %l2
  %t27 = load i64, i64* %l3
  %t28 = load i64, i64* %l4
  %t29 = load i64, i64* %l5
  %t30 = load i64, i64* %l6
  %t31 = load i8, i8* %l7
  %t32 = load i8, i8* %l8
  br i1 %t23, label %then4, label %else5
then4:
  %t33 = load i64, i64* %l4
  %t34 = add i64 %t33, 1
  store i64 %t34, i64* %l4
  br label %merge6
else5:
  %t35 = load i8, i8* %l8
  %t36 = icmp eq i8 %t35, 41
  %t37 = load i8*, i8** %l0
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t39 = load i64, i64* %l2
  %t40 = load i64, i64* %l3
  %t41 = load i64, i64* %l4
  %t42 = load i64, i64* %l5
  %t43 = load i64, i64* %l6
  %t44 = load i8, i8* %l7
  %t45 = load i8, i8* %l8
  br i1 %t36, label %then7, label %else8
then7:
  %t46 = load i64, i64* %l4
  %t47 = icmp sgt i64 %t46, 0
  %t48 = load i8*, i8** %l0
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t50 = load i64, i64* %l2
  %t51 = load i64, i64* %l3
  %t52 = load i64, i64* %l4
  %t53 = load i64, i64* %l5
  %t54 = load i64, i64* %l6
  %t55 = load i8, i8* %l7
  %t56 = load i8, i8* %l8
  br i1 %t47, label %then10, label %merge11
then10:
  %t57 = load i64, i64* %l4
  %t58 = sub i64 %t57, 1
  store i64 %t58, i64* %l4
  br label %merge11
merge11:
  %t59 = phi i64 [ %t58, %then10 ], [ %t52, %then7 ]
  store i64 %t59, i64* %l4
  br label %merge9
else8:
  %t60 = load i8, i8* %l8
  br label %merge9
merge9:
  %t61 = phi i64 [ %t58, %then7 ], [ %t41, %else8 ]
  store i64 %t61, i64* %l4
  br label %merge6
merge6:
  %t62 = phi i64 [ %t34, %then4 ], [ %t58, %else5 ]
  store i64 %t62, i64* %l4
  %t66 = load i8, i8* %l8
  %t67 = load i8, i8* %l7
  %t68 = icmp eq i8 %t66, %t67
  br label %logical_and_entry_65

logical_and_entry_65:
  br i1 %t68, label %logical_and_right_65, label %logical_and_merge_65

logical_and_right_65:
  %t69 = load i64, i64* %l4
  %t70 = icmp eq i64 %t69, 0
  br label %logical_and_right_end_65

logical_and_right_end_65:
  br label %logical_and_merge_65

logical_and_merge_65:
  %t71 = phi i1 [ false, %logical_and_entry_65 ], [ %t70, %logical_and_right_end_65 ]
  br label %logical_and_entry_64

logical_and_entry_64:
  br i1 %t71, label %logical_and_right_64, label %logical_and_merge_64

logical_and_right_64:
  %t72 = load i64, i64* %l5
  %t73 = icmp eq i64 %t72, 0
  br label %logical_and_right_end_64

logical_and_right_end_64:
  br label %logical_and_merge_64

logical_and_merge_64:
  %t74 = phi i1 [ false, %logical_and_entry_64 ], [ %t73, %logical_and_right_end_64 ]
  br label %logical_and_entry_63

logical_and_entry_63:
  br i1 %t74, label %logical_and_right_63, label %logical_and_merge_63

logical_and_right_63:
  %t75 = load i64, i64* %l6
  %t76 = icmp eq i64 %t75, 0
  br label %logical_and_right_end_63

logical_and_right_end_63:
  br label %logical_and_merge_63

logical_and_merge_63:
  %t77 = phi i1 [ false, %logical_and_entry_63 ], [ %t76, %logical_and_right_end_63 ]
  %t78 = load i8*, i8** %l0
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t80 = load i64, i64* %l2
  %t81 = load i64, i64* %l3
  %t82 = load i64, i64* %l4
  %t83 = load i64, i64* %l5
  %t84 = load i64, i64* %l6
  %t85 = load i8, i8* %l7
  %t86 = load i8, i8* %l8
  br i1 %t77, label %then12, label %merge13
then12:
  %t87 = load i8*, i8** %l0
  %t88 = load i64, i64* %l2
  %t89 = load i64, i64* %l3
  %t90 = sitofp i64 %t88 to double
  %t91 = sitofp i64 %t89 to double
  %t92 = call i8* @sailfin_runtime_substring(i8* %t87, double %t90, double %t91)
  store i8* %t92, i8** %l9
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t94 = load i8*, i8** %l9
  %t95 = call i8* @descriptor_trim(i8* %t94)
  %t96 = alloca [1 x i8*]
  %t97 = getelementptr [1 x i8*], [1 x i8*]* %t96, i32 0, i32 0
  %t98 = getelementptr i8*, i8** %t97, i64 0
  store i8* %t95, i8** %t98
  %t99 = alloca { i8**, i64 }
  %t100 = getelementptr { i8**, i64 }, { i8**, i64 }* %t99, i32 0, i32 0
  store i8** %t97, i8*** %t100
  %t101 = getelementptr { i8**, i64 }, { i8**, i64 }* %t99, i32 0, i32 1
  store i64 1, i64* %t101
  %t102 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t93, { i8**, i64 }* %t99)
  store { i8**, i64 }* %t102, { i8**, i64 }** %l1
  %t103 = load i64, i64* %l3
  %t104 = add i64 %t103, 1
  store i64 %t104, i64* %l2
  br label %merge13
merge13:
  %t105 = phi { i8**, i64 }* [ %t102, %then12 ], [ %t79, %loop.body1 ]
  %t106 = phi i64 [ %t104, %then12 ], [ %t80, %loop.body1 ]
  store { i8**, i64 }* %t105, { i8**, i64 }** %l1
  store i64 %t106, i64* %l2
  %t107 = load i64, i64* %l3
  %t108 = add i64 %t107, 1
  store i64 %t108, i64* %l3
  br label %loop.latch2
loop.latch2:
  %t109 = load i64, i64* %l4
  %t110 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t111 = load i64, i64* %l2
  %t112 = load i64, i64* %l3
  br label %loop.header0
afterloop3:
  %t117 = load i8*, i8** %l0
  %t118 = load i64, i64* %l2
  %t119 = load i8*, i8** %l0
  store double 0.0, double* %l10
  %t120 = load double, double* %l10
  %t121 = call i8* @descriptor_trim(i8* null)
  store i8* %t121, i8** %l11
  %t123 = load i8*, i8** %l11
  %t124 = load { i8**, i64 }*, { i8**, i64 }** %l1
  ret { i8**, i64 }* %t124
}

define { %TypeDescriptor*, i64 }* @parse_descriptor_list({ i8**, i64 }* %parts) {
entry:
  %l0 = alloca { %TypeDescriptor*, i64 }*
  %l1 = alloca i64
  %l2 = alloca i8*
  %t0 = alloca [0 x %TypeDescriptor]
  %t1 = getelementptr [0 x %TypeDescriptor], [0 x %TypeDescriptor]* %t0, i32 0, i32 0
  %t2 = alloca { %TypeDescriptor*, i64 }
  %t3 = getelementptr { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* %t2, i32 0, i32 0
  store %TypeDescriptor* %t1, %TypeDescriptor** %t3
  %t4 = getelementptr { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %TypeDescriptor*, i64 }* %t2, { %TypeDescriptor*, i64 }** %l0
  store i64 0, i64* %l1
  %t5 = load { %TypeDescriptor*, i64 }*, { %TypeDescriptor*, i64 }** %l0
  %t6 = load i64, i64* %l1
  br label %loop.header0
loop.header0:
  %t24 = phi i64 [ %t6, %entry ], [ %t23, %loop.latch2 ]
  store i64 %t24, i64* %l1
  br label %loop.body1
loop.body1:
  %t7 = load i64, i64* %l1
  %t8 = load { i8**, i64 }, { i8**, i64 }* %parts
  %t9 = extractvalue { i8**, i64 } %t8, 1
  %t10 = icmp sge i64 %t7, %t9
  %t11 = load { %TypeDescriptor*, i64 }*, { %TypeDescriptor*, i64 }** %l0
  %t12 = load i64, i64* %l1
  br i1 %t10, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t13 = load i64, i64* %l1
  %t14 = load { i8**, i64 }, { i8**, i64 }* %parts
  %t15 = extractvalue { i8**, i64 } %t14, 0
  %t16 = extractvalue { i8**, i64 } %t14, 1
  %t17 = icmp uge i64 %t13, %t16
  ; bounds check: %t17 (if true, out of bounds)
  %t18 = getelementptr i8*, i8** %t15, i64 %t13
  %t19 = load i8*, i8** %t18
  store i8* %t19, i8** %l2
  %t20 = load i8*, i8** %l2
  %t21 = load i64, i64* %l1
  %t22 = add i64 %t21, 1
  store i64 %t22, i64* %l1
  br label %loop.latch2
loop.latch2:
  %t23 = load i64, i64* %l1
  br label %loop.header0
afterloop3:
  %t25 = load { %TypeDescriptor*, i64 }*, { %TypeDescriptor*, i64 }** %l0
  ret { %TypeDescriptor*, i64 }* %t25
}

define %TypeDescriptor @parse_type_descriptor(i8* %text) {
entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca i8*
  %t0 = call i8* @descriptor_strip_outer_parens(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = load i8*, i8** %l0
  %t3 = call { i8**, i64 }* @split_descriptor(i8* %t2, i8* null)
  store { i8**, i64 }* %t3, { i8**, i64 }** %l1
  %t4 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t5 = load { i8**, i64 }, { i8**, i64 }* %t4
  %t6 = extractvalue { i8**, i64 } %t5, 1
  %t7 = icmp sgt i64 %t6, 1
  %t8 = load i8*, i8** %l0
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t7, label %then0, label %merge1
then0:
  %t10 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t11 = call { %TypeDescriptor*, i64 }* @parse_descriptor_list({ i8**, i64 }* %t10)
  %t12 = call %TypeDescriptor @type_descriptor_union({ %TypeDescriptor*, i64 }* %t11)
  ret %TypeDescriptor %t12
merge1:
  %t13 = load i8*, i8** %l0
  %t14 = call { i8**, i64 }* @split_descriptor(i8* %t13, i8* null)
  store { i8**, i64 }* %t14, { i8**, i64 }** %l2
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t16 = load { i8**, i64 }, { i8**, i64 }* %t15
  %t17 = extractvalue { i8**, i64 } %t16, 1
  %t18 = icmp sgt i64 %t17, 1
  %t19 = load i8*, i8** %l0
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t18, label %then2, label %merge3
then2:
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t23 = call { %TypeDescriptor*, i64 }* @parse_descriptor_list({ i8**, i64 }* %t22)
  %t24 = call %TypeDescriptor @type_descriptor_intersection({ %TypeDescriptor*, i64 }* %t23)
  ret %TypeDescriptor %t24
merge3:
  %t25 = load i8*, i8** %l0
  %s26 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.26, i32 0, i32 0
  %t27 = call i1 @string_ends_with(i8* %t25, i8* %s26)
  %t28 = load i8*, i8** %l0
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t27, label %then4, label %merge5
then4:
  %t31 = load i8*, i8** %l0
  %t32 = load i8*, i8** %l0
  store double 0.0, double* %l3
  %t33 = load double, double* %l3
  %t34 = call %TypeDescriptor @parse_type_descriptor(i8* null)
  %t35 = call %TypeDescriptor @type_descriptor_array(%TypeDescriptor %t34)
  ret %TypeDescriptor %t35
merge5:
  %t36 = load i8*, i8** %l0
  %s37 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.37, i32 0, i32 0
  %t38 = call i1 @string_starts_with(i8* %t36, i8* %s37)
  %t39 = load i8*, i8** %l0
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t38, label %then6, label %merge7
then6:
  %t42 = call %TypeDescriptor @type_descriptor_function()
  ret %TypeDescriptor %t42
merge7:
  %t43 = load i8*, i8** %l0
  store double 0.0, double* %l4
  %t44 = load i8*, i8** %l0
  store i8* %t44, i8** %l5
  %t45 = load double, double* %l4
  %t46 = sitofp i64 0 to double
  %t47 = fcmp oge double %t45, %t46
  %t48 = load i8*, i8** %l0
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t51 = load double, double* %l4
  %t52 = load i8*, i8** %l5
  br i1 %t47, label %then8, label %merge9
then8:
  %t53 = load i8*, i8** %l0
  %t54 = load double, double* %l4
  %t55 = sitofp i64 0 to double
  %t56 = call i8* @sailfin_runtime_substring(i8* %t53, double %t55, double %t54)
  %t57 = call i8* @descriptor_trim(i8* %t56)
  store i8* %t57, i8** %l5
  br label %merge9
merge9:
  %t58 = phi i8* [ %t57, %then8 ], [ %t52, %entry ]
  store i8* %t58, i8** %l5
  %t59 = load i8*, i8** %l5
  %s60 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.60, i32 0, i32 0
  %t61 = call i1 @string_starts_with(i8* %t59, i8* %s60)
  %t62 = load i8*, i8** %l0
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t65 = load double, double* %l4
  %t66 = load i8*, i8** %l5
  br i1 %t61, label %then10, label %merge11
then10:
  %t67 = load i8*, i8** %l5
  %t68 = load i8*, i8** %l5
  br label %merge11
merge11:
  %t69 = phi i8* [ null, %then10 ], [ %t66, %entry ]
  store i8* %t69, i8** %l5
  %t73 = load i8*, i8** %l5
  %s74 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.74, i32 0, i32 0
  %t75 = icmp eq i8* %t73, %s74
  br label %logical_or_entry_72

logical_or_entry_72:
  br i1 %t75, label %logical_or_merge_72, label %logical_or_right_72

logical_or_right_72:
  %t76 = load i8*, i8** %l5
  %s77 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.77, i32 0, i32 0
  %t78 = icmp eq i8* %t76, %s77
  br label %logical_or_right_end_72

logical_or_right_end_72:
  br label %logical_or_merge_72

logical_or_merge_72:
  %t79 = phi i1 [ true, %logical_or_entry_72 ], [ %t78, %logical_or_right_end_72 ]
  br label %logical_or_entry_71

logical_or_entry_71:
  br i1 %t79, label %logical_or_merge_71, label %logical_or_right_71

logical_or_right_71:
  %t80 = load i8*, i8** %l5
  %s81 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.81, i32 0, i32 0
  %t82 = icmp eq i8* %t80, %s81
  br label %logical_or_right_end_71

logical_or_right_end_71:
  br label %logical_or_merge_71

logical_or_merge_71:
  %t83 = phi i1 [ true, %logical_or_entry_71 ], [ %t82, %logical_or_right_end_71 ]
  br label %logical_or_entry_70

logical_or_entry_70:
  br i1 %t83, label %logical_or_merge_70, label %logical_or_right_70

logical_or_right_70:
  %t84 = load i8*, i8** %l5
  %s85 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.85, i32 0, i32 0
  %t86 = icmp eq i8* %t84, %s85
  br label %logical_or_right_end_70

logical_or_right_end_70:
  br label %logical_or_merge_70

logical_or_merge_70:
  %t87 = phi i1 [ true, %logical_or_entry_70 ], [ %t86, %logical_or_right_end_70 ]
  %t88 = load i8*, i8** %l0
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t91 = load double, double* %l4
  %t92 = load i8*, i8** %l5
  br i1 %t87, label %then12, label %merge13
then12:
  %t93 = load i8*, i8** %l5
  %t94 = call %TypeDescriptor @type_descriptor_primitive(i8* %t93)
  ret %TypeDescriptor %t94
merge13:
  %t95 = load i8*, i8** %l5
  %t96 = call %TypeDescriptor @type_descriptor_named(i8* %t95)
  ret %TypeDescriptor %t96
}

define i1 @check_type_primitive(double %value, i8* %name) {
entry:
  %s0 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.0, i32 0, i32 0
  %t1 = icmp eq i8* %name, %s0
  br i1 %t1, label %then0, label %merge1
then0:
  ret i1 false
merge1:
  %s2 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.2, i32 0, i32 0
  %t3 = icmp eq i8* %name, %s2
  br i1 %t3, label %then2, label %merge3
then2:
  ret i1 false
merge3:
  %s4 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.4, i32 0, i32 0
  %t5 = icmp eq i8* %name, %s4
  br i1 %t5, label %then4, label %merge5
then4:
  ret i1 false
merge5:
  %s6 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.6, i32 0, i32 0
  %t7 = icmp eq i8* %name, %s6
  br i1 %t7, label %then6, label %merge7
then6:
  ret i1 false
merge7:
  ret i1 0
}

define i1 @check_type_descriptor(double %value, %TypeDescriptor %descriptor) {
entry:
  %l0 = alloca i64
  %l1 = alloca i64
  %l2 = alloca i8*
  %l3 = alloca i64
  %l4 = alloca double
  %t0 = extractvalue %TypeDescriptor %descriptor, 0
  %s1 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.1, i32 0, i32 0
  %t2 = icmp eq i8* %t0, %s1
  br i1 %t2, label %then0, label %merge1
then0:
  %t3 = extractvalue %TypeDescriptor %descriptor, 1
  %t4 = icmp eq i8* %t3, null
  br i1 %t4, label %then2, label %merge3
then2:
  ret i1 0
merge3:
  %t5 = extractvalue %TypeDescriptor %descriptor, 1
  %t6 = call i1 @check_type_primitive(double %value, i8* %t5)
  ret i1 %t6
merge1:
  %t7 = extractvalue %TypeDescriptor %descriptor, 0
  %s8 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.8, i32 0, i32 0
  %t9 = icmp eq i8* %t7, %s8
  br i1 %t9, label %then4, label %merge5
then4:
  store i64 0, i64* %l0
  %t10 = load i64, i64* %l0
  br label %loop.header6
loop.header6:
  %t30 = phi i64 [ %t10, %then4 ], [ %t29, %loop.latch8 ]
  store i64 %t30, i64* %l0
  br label %loop.body7
loop.body7:
  %t11 = load i64, i64* %l0
  %t12 = extractvalue %TypeDescriptor %descriptor, 2
  %t13 = load { i8**, i64 }, { i8**, i64 }* %t12
  %t14 = extractvalue { i8**, i64 } %t13, 1
  %t15 = icmp sge i64 %t11, %t14
  %t16 = load i64, i64* %l0
  br i1 %t15, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t17 = extractvalue %TypeDescriptor %descriptor, 2
  %t18 = load i64, i64* %l0
  %t19 = load { i8**, i64 }, { i8**, i64 }* %t17
  %t20 = extractvalue { i8**, i64 } %t19, 0
  %t21 = extractvalue { i8**, i64 } %t19, 1
  %t22 = icmp uge i64 %t18, %t21
  ; bounds check: %t22 (if true, out of bounds)
  %t23 = getelementptr i8*, i8** %t20, i64 %t18
  %t24 = load i8*, i8** %t23
  %t25 = call i1 @check_type_descriptor(double %value, %TypeDescriptor zeroinitializer)
  %t26 = load i64, i64* %l0
  br i1 %t25, label %then12, label %merge13
then12:
  ret i1 1
merge13:
  %t27 = load i64, i64* %l0
  %t28 = add i64 %t27, 1
  store i64 %t28, i64* %l0
  br label %loop.latch8
loop.latch8:
  %t29 = load i64, i64* %l0
  br label %loop.header6
afterloop9:
  ret i1 0
merge5:
  %t31 = extractvalue %TypeDescriptor %descriptor, 0
  %s32 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.32, i32 0, i32 0
  %t33 = icmp eq i8* %t31, %s32
  br i1 %t33, label %then14, label %merge15
then14:
  store i64 0, i64* %l1
  %t34 = load i64, i64* %l1
  br label %loop.header16
loop.header16:
  %t55 = phi i64 [ %t34, %then14 ], [ %t54, %loop.latch18 ]
  store i64 %t55, i64* %l1
  br label %loop.body17
loop.body17:
  %t35 = load i64, i64* %l1
  %t36 = extractvalue %TypeDescriptor %descriptor, 2
  %t37 = load { i8**, i64 }, { i8**, i64 }* %t36
  %t38 = extractvalue { i8**, i64 } %t37, 1
  %t39 = icmp sge i64 %t35, %t38
  %t40 = load i64, i64* %l1
  br i1 %t39, label %then20, label %merge21
then20:
  br label %afterloop19
merge21:
  %t41 = extractvalue %TypeDescriptor %descriptor, 2
  %t42 = load i64, i64* %l1
  %t43 = load { i8**, i64 }, { i8**, i64 }* %t41
  %t44 = extractvalue { i8**, i64 } %t43, 0
  %t45 = extractvalue { i8**, i64 } %t43, 1
  %t46 = icmp uge i64 %t42, %t45
  ; bounds check: %t46 (if true, out of bounds)
  %t47 = getelementptr i8*, i8** %t44, i64 %t42
  %t48 = load i8*, i8** %t47
  %t49 = call i1 @check_type_descriptor(double %value, %TypeDescriptor zeroinitializer)
  %t50 = xor i1 %t49, 1
  %t51 = load i64, i64* %l1
  br i1 %t50, label %then22, label %merge23
then22:
  ret i1 0
merge23:
  %t52 = load i64, i64* %l1
  %t53 = add i64 %t52, 1
  store i64 %t53, i64* %l1
  br label %loop.latch18
loop.latch18:
  %t54 = load i64, i64* %l1
  br label %loop.header16
afterloop19:
  %t56 = extractvalue %TypeDescriptor %descriptor, 2
  %t57 = load { i8**, i64 }, { i8**, i64 }* %t56
  %t58 = extractvalue { i8**, i64 } %t57, 1
  %t59 = icmp sgt i64 %t58, 0
  ret i1 %t59
merge15:
  %t60 = extractvalue %TypeDescriptor %descriptor, 0
  %s61 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.61, i32 0, i32 0
  %t62 = icmp eq i8* %t60, %s61
  br i1 %t62, label %then24, label %merge25
then24:
  %t63 = extractvalue %TypeDescriptor %descriptor, 2
  %t64 = load { i8**, i64 }, { i8**, i64 }* %t63
  %t65 = extractvalue { i8**, i64 } %t64, 1
  %t66 = icmp eq i64 %t65, 0
  br i1 %t66, label %then26, label %merge27
then26:
  ret i1 false
merge27:
  %t67 = extractvalue %TypeDescriptor %descriptor, 2
  %t68 = load { i8**, i64 }, { i8**, i64 }* %t67
  %t69 = extractvalue { i8**, i64 } %t68, 0
  %t70 = extractvalue { i8**, i64 } %t68, 1
  %t71 = icmp uge i64 0, %t70
  ; bounds check: %t71 (if true, out of bounds)
  %t72 = getelementptr i8*, i8** %t69, i64 0
  %t73 = load i8*, i8** %t72
  store i8* %t73, i8** %l2
  store i64 0, i64* %l3
  %t74 = load i8*, i8** %l2
  %t75 = load i64, i64* %l3
  br label %loop.header28
loop.header28:
  %t82 = phi i64 [ %t75, %then24 ], [ %t81, %loop.latch30 ]
  store i64 %t82, i64* %l3
  br label %loop.body29
loop.body29:
  %t76 = load i64, i64* %l3
  %t77 = load i64, i64* %l3
  %t78 = load i8*, i8** %l2
  %t79 = load i64, i64* %l3
  %t80 = add i64 %t79, 1
  store i64 %t80, i64* %l3
  br label %loop.latch30
loop.latch30:
  %t81 = load i64, i64* %l3
  br label %loop.header28
afterloop31:
  ret i1 1
merge25:
  %t83 = extractvalue %TypeDescriptor %descriptor, 0
  %s84 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.84, i32 0, i32 0
  %t85 = icmp eq i8* %t83, %s84
  br i1 %t85, label %then32, label %merge33
then32:
  ret i1 false
merge33:
  %t86 = extractvalue %TypeDescriptor %descriptor, 0
  %s87 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.87, i32 0, i32 0
  %t88 = icmp eq i8* %t86, %s87
  br i1 %t88, label %then34, label %merge35
then34:
  %t89 = extractvalue %TypeDescriptor %descriptor, 1
  %t90 = icmp eq i8* %t89, null
  br i1 %t90, label %then36, label %merge37
then36:
  ret i1 0
merge37:
  store double 0.0, double* %l4
  ret i1 false
merge35:
  %t91 = extractvalue %TypeDescriptor %descriptor, 0
  %s92 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.92, i32 0, i32 0
  %t93 = icmp eq i8* %t91, %s92
  br i1 %t93, label %then38, label %merge39
then38:
  ret i1 0
merge39:
  ret i1 0
}

define i1 @check_type(double %value, i8* %descriptor) {
entry:
  %l0 = alloca %TypeDescriptor
  %t0 = call %TypeDescriptor @parse_type_descriptor(i8* %descriptor)
  store %TypeDescriptor %t0, %TypeDescriptor* %l0
  %t1 = load %TypeDescriptor, %TypeDescriptor* %l0
  %t2 = call i1 @check_type_descriptor(double %value, %TypeDescriptor %t1)
  ret i1 %t2
}

; fn serve effects: ![io, net]
define void @serve(double %handler, double %config) {
entry:
  ret void
}

define double @clamp(double %value, double %minimum, double %maximum) {
entry:
  %t0 = fcmp olt double %value, %minimum
  br i1 %t0, label %then0, label %merge1
then0:
  ret double %minimum
merge1:
  %t1 = fcmp ogt double %value, %maximum
  br i1 %t1, label %then2, label %merge3
then2:
  ret double %maximum
merge3:
  ret double %value
}

define i8* @substring(i8* %text, double %start, double %end) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i8*
  store double 0.0, double* %l0
  %t0 = load double, double* %l0
  %t1 = sitofp i64 0 to double
  %t2 = fcmp oeq double %t0, %t1
  %t3 = load double, double* %l0
  br i1 %t2, label %then0, label %merge1
then0:
  %s4 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.4, i32 0, i32 0
  ret i8* %s4
merge1:
  %t5 = load double, double* %l0
  %t6 = sitofp i64 0 to double
  %t7 = call double @clamp(double %start, double %t6, double %t5)
  store double %t7, double* %l1
  %t8 = load double, double* %l0
  %t9 = sitofp i64 0 to double
  %t10 = call double @clamp(double %end, double %t9, double %t8)
  store double %t10, double* %l2
  %t11 = load double, double* %l1
  %t12 = load double, double* %l2
  %t13 = fcmp oge double %t11, %t12
  %t14 = load double, double* %l0
  %t15 = load double, double* %l1
  %t16 = load double, double* %l2
  br i1 %t13, label %then2, label %merge3
then2:
  %s17 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.17, i32 0, i32 0
  ret i8* %s17
merge3:
  %t18 = load double, double* %l1
  store double %t18, double* %l3
  %s19 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.19, i32 0, i32 0
  store i8* %s19, i8** %l4
  %t20 = load double, double* %l0
  %t21 = load double, double* %l1
  %t22 = load double, double* %l2
  %t23 = load double, double* %l3
  %t24 = load i8*, i8** %l4
  br label %loop.header4
loop.header4:
  %t45 = phi i8* [ %t24, %entry ], [ %t43, %loop.latch6 ]
  %t46 = phi double [ %t23, %entry ], [ %t44, %loop.latch6 ]
  store i8* %t45, i8** %l4
  store double %t46, double* %l3
  br label %loop.body5
loop.body5:
  %t25 = load double, double* %l3
  %t26 = load double, double* %l2
  %t27 = fcmp oge double %t25, %t26
  %t28 = load double, double* %l0
  %t29 = load double, double* %l1
  %t30 = load double, double* %l2
  %t31 = load double, double* %l3
  %t32 = load i8*, i8** %l4
  br i1 %t27, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t33 = load i8*, i8** %l4
  %t34 = load double, double* %l3
  %t35 = getelementptr i8, i8* %text, i64 %t34
  %t36 = load i8, i8* %t35
  %t37 = getelementptr i8, i8* %t33, i64 0
  %t38 = load i8, i8* %t37
  %t39 = add i8 %t38, %t36
  store i8* null, i8** %l4
  %t40 = load double, double* %l3
  %t41 = sitofp i64 1 to double
  %t42 = fadd double %t40, %t41
  store double %t42, double* %l3
  br label %loop.latch6
loop.latch6:
  %t43 = load i8*, i8** %l4
  %t44 = load double, double* %l3
  br label %loop.header4
afterloop7:
  %t47 = load i8*, i8** %l4
  ret i8* %t47
}

define double @find_char(i8* %text, i8* %character, double %start) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
  store double 0.0, double* %l0
  %t0 = load double, double* %l0
  %t1 = sitofp i64 0 to double
  %t2 = fcmp oeq double %t0, %t1
  %t3 = load double, double* %l0
  br i1 %t2, label %then0, label %merge1
then0:
  %t4 = sitofp i64 -1 to double
  ret double %t4
merge1:
  store double %start, double* %l1
  %t5 = load double, double* %l1
  %t6 = sitofp i64 0 to double
  %t7 = fcmp olt double %t5, %t6
  %t8 = load double, double* %l0
  %t9 = load double, double* %l1
  br i1 %t7, label %then2, label %merge3
then2:
  %t10 = sitofp i64 0 to double
  store double %t10, double* %l1
  br label %merge3
merge3:
  %t11 = phi double [ %t10, %then2 ], [ %t9, %entry ]
  store double %t11, double* %l1
  %t12 = load double, double* %l1
  %t13 = load double, double* %l0
  %t14 = fcmp oge double %t12, %t13
  %t15 = load double, double* %l0
  %t16 = load double, double* %l1
  br i1 %t14, label %then4, label %merge5
then4:
  %t17 = sitofp i64 -1 to double
  ret double %t17
merge5:
  store i8* %character, i8** %l2
  %t19 = load i8*, i8** %l2
  %t20 = load double, double* %l1
  store double %t20, double* %l3
  %t21 = load double, double* %l0
  %t22 = load double, double* %l1
  %t23 = load i8*, i8** %l2
  %t24 = load double, double* %l3
  br label %loop.header6
loop.header6:
  %t48 = phi double [ %t24, %entry ], [ %t47, %loop.latch8 ]
  store double %t48, double* %l3
  br label %loop.body7
loop.body7:
  %t25 = load double, double* %l3
  %t26 = load double, double* %l0
  %t27 = fcmp oge double %t25, %t26
  %t28 = load double, double* %l0
  %t29 = load double, double* %l1
  %t30 = load i8*, i8** %l2
  %t31 = load double, double* %l3
  br i1 %t27, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t32 = load double, double* %l3
  %t33 = getelementptr i8, i8* %text, i64 %t32
  %t34 = load i8, i8* %t33
  %t35 = load i8*, i8** %l2
  %t36 = getelementptr i8, i8* %t35, i64 0
  %t37 = load i8, i8* %t36
  %t38 = icmp eq i8 %t34, %t37
  %t39 = load double, double* %l0
  %t40 = load double, double* %l1
  %t41 = load i8*, i8** %l2
  %t42 = load double, double* %l3
  br i1 %t38, label %then12, label %merge13
then12:
  %t43 = load double, double* %l3
  ret double %t43
merge13:
  %t44 = load double, double* %l3
  %t45 = sitofp i64 1 to double
  %t46 = fadd double %t44, %t45
  store double %t46, double* %l3
  br label %loop.latch8
loop.latch8:
  %t47 = load double, double* %l3
  br label %loop.header6
afterloop9:
  %t49 = sitofp i64 -1 to double
  ret double %t49
}

define void @match_exhaustive_failed(double %value) {
entry:
  %l0 = alloca double
  store double 0.0, double* %l0
  ret void
}

define double @char_code(i8* %character) {
entry:
  %l0 = alloca i8
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca i8*
  %l4 = alloca double
  %l5 = alloca i8*
  %l6 = alloca double
  %l7 = alloca double
  %l8 = alloca double
  %l9 = alloca i64
  %l10 = alloca i64
  %l11 = alloca double
  %t0 = getelementptr i8, i8* %character, i64 0
  %t1 = load i8, i8* %t0
  store i8 %t1, i8* %l0
  %s2 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.2, i32 0, i32 0
  store i8* %s2, i8** %l1
  %t3 = load i8*, i8** %l1
  %t4 = load i8, i8* %l0
  %t5 = sitofp i64 0 to double
  %t6 = call double @find_char(i8* %t3, i8* null, double %t5)
  store double %t6, double* %l2
  %t7 = load double, double* %l2
  %t8 = sitofp i64 0 to double
  %t9 = fcmp oge double %t7, %t8
  %t10 = load i8, i8* %l0
  %t11 = load i8*, i8** %l1
  %t12 = load double, double* %l2
  br i1 %t9, label %then0, label %merge1
then0:
  %t13 = load double, double* %l2
  %t14 = sitofp i64 48 to double
  %t15 = fadd double %t14, %t13
  ret double %t15
merge1:
  %s16 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.16, i32 0, i32 0
  store i8* %s16, i8** %l3
  %t17 = load i8*, i8** %l3
  %t18 = load i8, i8* %l0
  %t19 = sitofp i64 0 to double
  %t20 = call double @find_char(i8* %t17, i8* null, double %t19)
  store double %t20, double* %l4
  %t21 = load double, double* %l4
  %t22 = sitofp i64 0 to double
  %t23 = fcmp oge double %t21, %t22
  %t24 = load i8, i8* %l0
  %t25 = load i8*, i8** %l1
  %t26 = load double, double* %l2
  %t27 = load i8*, i8** %l3
  %t28 = load double, double* %l4
  br i1 %t23, label %then2, label %merge3
then2:
  %t29 = load double, double* %l4
  %t30 = sitofp i64 97 to double
  %t31 = fadd double %t30, %t29
  ret double %t31
merge3:
  %s32 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.32, i32 0, i32 0
  store i8* %s32, i8** %l5
  %t33 = load i8*, i8** %l5
  %t34 = load i8, i8* %l0
  %t35 = sitofp i64 0 to double
  %t36 = call double @find_char(i8* %t33, i8* null, double %t35)
  store double %t36, double* %l6
  %t37 = load double, double* %l6
  %t38 = sitofp i64 0 to double
  %t39 = fcmp oge double %t37, %t38
  %t40 = load i8, i8* %l0
  %t41 = load i8*, i8** %l1
  %t42 = load double, double* %l2
  %t43 = load i8*, i8** %l3
  %t44 = load double, double* %l4
  %t45 = load i8*, i8** %l5
  %t46 = load double, double* %l6
  br i1 %t39, label %then4, label %merge5
then4:
  %t47 = load double, double* %l6
  %t48 = sitofp i64 65 to double
  %t49 = fadd double %t48, %t47
  ret double %t49
merge5:
  %t50 = load i8, i8* %l0
  %t51 = icmp eq i8 %t50, 32
  %t52 = load i8, i8* %l0
  %t53 = load i8*, i8** %l1
  %t54 = load double, double* %l2
  %t55 = load i8*, i8** %l3
  %t56 = load double, double* %l4
  %t57 = load i8*, i8** %l5
  %t58 = load double, double* %l6
  br i1 %t51, label %then6, label %merge7
then6:
  %t59 = sitofp i64 32 to double
  ret double %t59
merge7:
  %t60 = load i8, i8* %l0
  %t61 = icmp eq i8 %t60, 10
  %t62 = load i8, i8* %l0
  %t63 = load i8*, i8** %l1
  %t64 = load double, double* %l2
  %t65 = load i8*, i8** %l3
  %t66 = load double, double* %l4
  %t67 = load i8*, i8** %l5
  %t68 = load double, double* %l6
  br i1 %t61, label %then8, label %merge9
then8:
  %t69 = sitofp i64 10 to double
  ret double %t69
merge9:
  %t70 = load i8, i8* %l0
  %t71 = icmp eq i8 %t70, 13
  %t72 = load i8, i8* %l0
  %t73 = load i8*, i8** %l1
  %t74 = load double, double* %l2
  %t75 = load i8*, i8** %l3
  %t76 = load double, double* %l4
  %t77 = load i8*, i8** %l5
  %t78 = load double, double* %l6
  br i1 %t71, label %then10, label %merge11
then10:
  %t79 = sitofp i64 13 to double
  ret double %t79
merge11:
  %t80 = load i8, i8* %l0
  %t81 = icmp eq i8 %t80, 9
  %t82 = load i8, i8* %l0
  %t83 = load i8*, i8** %l1
  %t84 = load double, double* %l2
  %t85 = load i8*, i8** %l3
  %t86 = load double, double* %l4
  %t87 = load i8*, i8** %l5
  %t88 = load double, double* %l6
  br i1 %t81, label %then12, label %merge13
then12:
  %t89 = sitofp i64 9 to double
  ret double %t89
merge13:
  %t90 = load i8, i8* %l0
  %t91 = icmp eq i8 %t90, 34
  %t92 = load i8, i8* %l0
  %t93 = load i8*, i8** %l1
  %t94 = load double, double* %l2
  %t95 = load i8*, i8** %l3
  %t96 = load double, double* %l4
  %t97 = load i8*, i8** %l5
  %t98 = load double, double* %l6
  br i1 %t91, label %then14, label %merge15
then14:
  %t99 = sitofp i64 34 to double
  ret double %t99
merge15:
  %t100 = load i8, i8* %l0
  %t101 = icmp eq i8 %t100, 92
  %t102 = load i8, i8* %l0
  %t103 = load i8*, i8** %l1
  %t104 = load double, double* %l2
  %t105 = load i8*, i8** %l3
  %t106 = load double, double* %l4
  %t107 = load i8*, i8** %l5
  %t108 = load double, double* %l6
  br i1 %t101, label %then16, label %merge17
then16:
  %t109 = sitofp i64 92 to double
  ret double %t109
merge17:
  %t110 = load i8, i8* %l0
  %t111 = icmp eq i8 %t110, 95
  %t112 = load i8, i8* %l0
  %t113 = load i8*, i8** %l1
  %t114 = load double, double* %l2
  %t115 = load i8*, i8** %l3
  %t116 = load double, double* %l4
  %t117 = load i8*, i8** %l5
  %t118 = load double, double* %l6
  br i1 %t111, label %then18, label %merge19
then18:
  %t119 = sitofp i64 95 to double
  ret double %t119
merge19:
  %t120 = load i8, i8* %l0
  store double 0.0, double* %l7
  %t121 = load double, double* %l7
  store double 0.0, double* %l8
  %t122 = load double, double* %l8
  %t123 = sitofp i64 0 to double
  %t124 = fcmp oeq double %t122, %t123
  %t125 = load i8, i8* %l0
  %t126 = load i8*, i8** %l1
  %t127 = load double, double* %l2
  %t128 = load i8*, i8** %l3
  %t129 = load double, double* %l4
  %t130 = load i8*, i8** %l5
  %t131 = load double, double* %l6
  %t132 = load double, double* %l7
  %t133 = load double, double* %l8
  br i1 %t124, label %then20, label %merge21
then20:
  %t134 = sitofp i64 -1 to double
  ret double %t134
merge21:
  %t135 = load double, double* %l8
  %t136 = sitofp i64 4 to double
  %t137 = fcmp ogt double %t135, %t136
  %t138 = load i8, i8* %l0
  %t139 = load i8*, i8** %l1
  %t140 = load double, double* %l2
  %t141 = load i8*, i8** %l3
  %t142 = load double, double* %l4
  %t143 = load i8*, i8** %l5
  %t144 = load double, double* %l6
  %t145 = load double, double* %l7
  %t146 = load double, double* %l8
  br i1 %t137, label %then22, label %merge23
then22:
  %t147 = sitofp i64 -1 to double
  ret double %t147
merge23:
  store i64 0, i64* %l9
  store i64 0, i64* %l10
  %t148 = load i8, i8* %l0
  %t149 = load i8*, i8** %l1
  %t150 = load double, double* %l2
  %t151 = load i8*, i8** %l3
  %t152 = load double, double* %l4
  %t153 = load i8*, i8** %l5
  %t154 = load double, double* %l6
  %t155 = load double, double* %l7
  %t156 = load double, double* %l8
  %t157 = load i64, i64* %l9
  %t158 = load i64, i64* %l10
  br label %loop.header24
loop.header24:
  %t315 = phi i64 [ %t158, %entry ], [ %t313, %loop.latch26 ]
  %t316 = phi i64 [ %t157, %entry ], [ %t314, %loop.latch26 ]
  store i64 %t315, i64* %l10
  store i64 %t316, i64* %l9
  br label %loop.body25
loop.body25:
  %t159 = load i64, i64* %l9
  %t160 = load double, double* %l8
  %t161 = sitofp i64 %t159 to double
  %t162 = fcmp oge double %t161, %t160
  %t163 = load i8, i8* %l0
  %t164 = load i8*, i8** %l1
  %t165 = load double, double* %l2
  %t166 = load i8*, i8** %l3
  %t167 = load double, double* %l4
  %t168 = load i8*, i8** %l5
  %t169 = load double, double* %l6
  %t170 = load double, double* %l7
  %t171 = load double, double* %l8
  %t172 = load i64, i64* %l9
  %t173 = load i64, i64* %l10
  br i1 %t162, label %then28, label %merge29
then28:
  br label %afterloop27
merge29:
  %t174 = load double, double* %l7
  %t175 = load i64, i64* %l9
  store double 0.0, double* %l11
  %t176 = load i64, i64* %l9
  %t177 = icmp eq i64 %t176, 0
  %t178 = load i8, i8* %l0
  %t179 = load i8*, i8** %l1
  %t180 = load double, double* %l2
  %t181 = load i8*, i8** %l3
  %t182 = load double, double* %l4
  %t183 = load i8*, i8** %l5
  %t184 = load double, double* %l6
  %t185 = load double, double* %l7
  %t186 = load double, double* %l8
  %t187 = load i64, i64* %l9
  %t188 = load i64, i64* %l10
  %t189 = load double, double* %l11
  br i1 %t177, label %then30, label %else31
then30:
  %t190 = load double, double* %l11
  %t191 = sitofp i64 128 to double
  %t192 = fcmp olt double %t190, %t191
  %t193 = load i8, i8* %l0
  %t194 = load i8*, i8** %l1
  %t195 = load double, double* %l2
  %t196 = load i8*, i8** %l3
  %t197 = load double, double* %l4
  %t198 = load i8*, i8** %l5
  %t199 = load double, double* %l6
  %t200 = load double, double* %l7
  %t201 = load double, double* %l8
  %t202 = load i64, i64* %l9
  %t203 = load i64, i64* %l10
  %t204 = load double, double* %l11
  br i1 %t192, label %then33, label %merge34
then33:
  %t205 = load double, double* %l11
  ret double %t205
merge34:
  %t207 = load double, double* %l11
  %t208 = sitofp i64 192 to double
  %t209 = fcmp oge double %t207, %t208
  br label %logical_and_entry_206

logical_and_entry_206:
  br i1 %t209, label %logical_and_right_206, label %logical_and_merge_206

logical_and_right_206:
  %t210 = load double, double* %l11
  %t211 = sitofp i64 223 to double
  %t212 = fcmp ole double %t210, %t211
  br label %logical_and_right_end_206

logical_and_right_end_206:
  br label %logical_and_merge_206

logical_and_merge_206:
  %t213 = phi i1 [ false, %logical_and_entry_206 ], [ %t212, %logical_and_right_end_206 ]
  %t214 = load i8, i8* %l0
  %t215 = load i8*, i8** %l1
  %t216 = load double, double* %l2
  %t217 = load i8*, i8** %l3
  %t218 = load double, double* %l4
  %t219 = load i8*, i8** %l5
  %t220 = load double, double* %l6
  %t221 = load double, double* %l7
  %t222 = load double, double* %l8
  %t223 = load i64, i64* %l9
  %t224 = load i64, i64* %l10
  %t225 = load double, double* %l11
  br i1 %t213, label %then35, label %else36
then35:
  %t226 = load double, double* %l11
  %t227 = sitofp i64 192 to double
  %t228 = fsub double %t226, %t227
  %t229 = fptosi double %t228 to i64
  store i64 %t229, i64* %l10
  br label %merge37
else36:
  %t231 = load double, double* %l11
  %t232 = sitofp i64 224 to double
  %t233 = fcmp oge double %t231, %t232
  br label %logical_and_entry_230

logical_and_entry_230:
  br i1 %t233, label %logical_and_right_230, label %logical_and_merge_230

logical_and_right_230:
  %t234 = load double, double* %l11
  %t235 = sitofp i64 239 to double
  %t236 = fcmp ole double %t234, %t235
  br label %logical_and_right_end_230

logical_and_right_end_230:
  br label %logical_and_merge_230

logical_and_merge_230:
  %t237 = phi i1 [ false, %logical_and_entry_230 ], [ %t236, %logical_and_right_end_230 ]
  %t238 = load i8, i8* %l0
  %t239 = load i8*, i8** %l1
  %t240 = load double, double* %l2
  %t241 = load i8*, i8** %l3
  %t242 = load double, double* %l4
  %t243 = load i8*, i8** %l5
  %t244 = load double, double* %l6
  %t245 = load double, double* %l7
  %t246 = load double, double* %l8
  %t247 = load i64, i64* %l9
  %t248 = load i64, i64* %l10
  %t249 = load double, double* %l11
  br i1 %t237, label %then38, label %else39
then38:
  %t250 = load double, double* %l11
  %t251 = sitofp i64 224 to double
  %t252 = fsub double %t250, %t251
  %t253 = fptosi double %t252 to i64
  store i64 %t253, i64* %l10
  br label %merge40
else39:
  %t255 = load double, double* %l11
  %t256 = sitofp i64 240 to double
  %t257 = fcmp oge double %t255, %t256
  br label %logical_and_entry_254

logical_and_entry_254:
  br i1 %t257, label %logical_and_right_254, label %logical_and_merge_254

logical_and_right_254:
  %t258 = load double, double* %l11
  %t259 = sitofp i64 247 to double
  %t260 = fcmp ole double %t258, %t259
  br label %logical_and_right_end_254

logical_and_right_end_254:
  br label %logical_and_merge_254

logical_and_merge_254:
  %t261 = phi i1 [ false, %logical_and_entry_254 ], [ %t260, %logical_and_right_end_254 ]
  %t262 = load i8, i8* %l0
  %t263 = load i8*, i8** %l1
  %t264 = load double, double* %l2
  %t265 = load i8*, i8** %l3
  %t266 = load double, double* %l4
  %t267 = load i8*, i8** %l5
  %t268 = load double, double* %l6
  %t269 = load double, double* %l7
  %t270 = load double, double* %l8
  %t271 = load i64, i64* %l9
  %t272 = load i64, i64* %l10
  %t273 = load double, double* %l11
  br i1 %t261, label %then41, label %else42
then41:
  %t274 = load double, double* %l11
  %t275 = sitofp i64 240 to double
  %t276 = fsub double %t274, %t275
  %t277 = fptosi double %t276 to i64
  store i64 %t277, i64* %l10
  br label %merge43
else42:
  %t278 = sitofp i64 -1 to double
  ret double %t278
merge43:
  br label %merge40
merge40:
  %t279 = phi i64 [ %t253, %then38 ], [ %t277, %else39 ]
  store i64 %t279, i64* %l10
  br label %merge37
merge37:
  %t280 = phi i64 [ %t229, %then35 ], [ %t253, %else36 ]
  store i64 %t280, i64* %l10
  br label %merge32
else31:
  %t282 = load double, double* %l11
  %t283 = sitofp i64 128 to double
  %t284 = fcmp olt double %t282, %t283
  br label %logical_or_entry_281

logical_or_entry_281:
  br i1 %t284, label %logical_or_merge_281, label %logical_or_right_281

logical_or_right_281:
  %t285 = load double, double* %l11
  %t286 = sitofp i64 191 to double
  %t287 = fcmp ogt double %t285, %t286
  br label %logical_or_right_end_281

logical_or_right_end_281:
  br label %logical_or_merge_281

logical_or_merge_281:
  %t288 = phi i1 [ true, %logical_or_entry_281 ], [ %t287, %logical_or_right_end_281 ]
  %t289 = load i8, i8* %l0
  %t290 = load i8*, i8** %l1
  %t291 = load double, double* %l2
  %t292 = load i8*, i8** %l3
  %t293 = load double, double* %l4
  %t294 = load i8*, i8** %l5
  %t295 = load double, double* %l6
  %t296 = load double, double* %l7
  %t297 = load double, double* %l8
  %t298 = load i64, i64* %l9
  %t299 = load i64, i64* %l10
  %t300 = load double, double* %l11
  br i1 %t288, label %then44, label %merge45
then44:
  %t301 = sitofp i64 -1 to double
  ret double %t301
merge45:
  %t302 = load i64, i64* %l10
  %t303 = mul i64 %t302, 64
  %t304 = load double, double* %l11
  %t305 = sitofp i64 128 to double
  %t306 = fsub double %t304, %t305
  %t307 = sitofp i64 %t303 to double
  %t308 = fadd double %t307, %t306
  %t309 = fptosi double %t308 to i64
  store i64 %t309, i64* %l10
  br label %merge32
merge32:
  %t310 = phi i64 [ %t229, %then30 ], [ %t309, %else31 ]
  store i64 %t310, i64* %l10
  %t311 = load i64, i64* %l9
  %t312 = add i64 %t311, 1
  store i64 %t312, i64* %l9
  br label %loop.latch26
loop.latch26:
  %t313 = load i64, i64* %l10
  %t314 = load i64, i64* %l9
  br label %loop.header24
afterloop27:
  %t317 = load i64, i64* %l10
  %t318 = sitofp i64 %t317 to double
  ret double %t318
}

define i1 @is_regional_indicator(double %codepoint) {
entry:
  %t1 = sitofp i64 127462 to double
  %t2 = fcmp oge double %codepoint, %t1
  br label %logical_and_entry_0

logical_and_entry_0:
  br i1 %t2, label %logical_and_right_0, label %logical_and_merge_0

logical_and_right_0:
  %t3 = sitofp i64 127487 to double
  %t4 = fcmp ole double %codepoint, %t3
  br label %logical_and_right_end_0

logical_and_right_end_0:
  br label %logical_and_merge_0

logical_and_merge_0:
  %t5 = phi i1 [ false, %logical_and_entry_0 ], [ %t4, %logical_and_right_end_0 ]
  ret i1 %t5
}

define i1 @is_variation_selector(double %codepoint) {
entry:
  %t1 = sitofp i64 65024 to double
  %t2 = fcmp oge double %codepoint, %t1
  br label %logical_and_entry_0

logical_and_entry_0:
  br i1 %t2, label %logical_and_right_0, label %logical_and_merge_0

logical_and_right_0:
  %t3 = sitofp i64 65039 to double
  %t4 = fcmp ole double %codepoint, %t3
  br label %logical_and_right_end_0

logical_and_right_end_0:
  br label %logical_and_merge_0

logical_and_merge_0:
  %t5 = phi i1 [ false, %logical_and_entry_0 ], [ %t4, %logical_and_right_end_0 ]
  br i1 %t5, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %t7 = sitofp i64 917760 to double
  %t8 = fcmp oge double %codepoint, %t7
  br label %logical_and_entry_6

logical_and_entry_6:
  br i1 %t8, label %logical_and_right_6, label %logical_and_merge_6

logical_and_right_6:
  %t9 = sitofp i64 917999 to double
  %t10 = fcmp ole double %codepoint, %t9
  br label %logical_and_right_end_6

logical_and_right_end_6:
  br label %logical_and_merge_6

logical_and_merge_6:
  %t11 = phi i1 [ false, %logical_and_entry_6 ], [ %t10, %logical_and_right_end_6 ]
  ret i1 %t11
}

define i1 @is_emoji_modifier(double %codepoint) {
entry:
  %t1 = sitofp i64 127995 to double
  %t2 = fcmp oge double %codepoint, %t1
  br label %logical_and_entry_0

logical_and_entry_0:
  br i1 %t2, label %logical_and_right_0, label %logical_and_merge_0

logical_and_right_0:
  %t3 = sitofp i64 127999 to double
  %t4 = fcmp ole double %codepoint, %t3
  br label %logical_and_right_end_0

logical_and_right_end_0:
  br label %logical_and_merge_0

logical_and_merge_0:
  %t5 = phi i1 [ false, %logical_and_entry_0 ], [ %t4, %logical_and_right_end_0 ]
  ret i1 %t5
}

define i1 @is_codepoint_in_ranges(double %codepoint, { double*, i64 }* %ranges) {
entry:
  %l0 = alloca i64
  %l1 = alloca double
  %l2 = alloca double
  store i64 0, i64* %l0
  %t0 = load i64, i64* %l0
  br label %loop.header0
loop.header0:
  %t26 = phi i64 [ %t0, %entry ], [ %t25, %loop.latch2 ]
  store i64 %t26, i64* %l0
  br label %loop.body1
loop.body1:
  %t1 = load i64, i64* %l0
  %t2 = load { double*, i64 }, { double*, i64 }* %ranges
  %t3 = extractvalue { double*, i64 } %t2, 1
  %t4 = icmp sge i64 %t1, %t3
  %t5 = load i64, i64* %l0
  br i1 %t4, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t6 = load i64, i64* %l0
  %t7 = load { double*, i64 }, { double*, i64 }* %ranges
  %t8 = extractvalue { double*, i64 } %t7, 0
  %t9 = extractvalue { double*, i64 } %t7, 1
  %t10 = icmp uge i64 %t6, %t9
  ; bounds check: %t10 (if true, out of bounds)
  %t11 = getelementptr double, double* %t8, i64 %t6
  %t12 = load double, double* %t11
  store double %t12, double* %l1
  store double 0.0, double* %l2
  %t13 = load double, double* %l1
  %t14 = fcmp olt double %codepoint, %t13
  %t15 = load i64, i64* %l0
  %t16 = load double, double* %l1
  %t17 = load double, double* %l2
  br i1 %t14, label %then6, label %merge7
then6:
  br label %afterloop3
merge7:
  %t18 = load double, double* %l2
  %t19 = fcmp ole double %codepoint, %t18
  %t20 = load i64, i64* %l0
  %t21 = load double, double* %l1
  %t22 = load double, double* %l2
  br i1 %t19, label %then8, label %merge9
then8:
  ret i1 1
merge9:
  %t23 = load i64, i64* %l0
  %t24 = add i64 %t23, 2
  store i64 %t24, i64* %l0
  br label %loop.latch2
loop.latch2:
  %t25 = load i64, i64* %l0
  br label %loop.header0
afterloop3:
  ret i1 0
}

define i1 @is_grapheme_extend(double %codepoint) {
entry:
  %t0 = sitofp i64 0 to double
  %t1 = fcmp olt double %codepoint, %t0
  br i1 %t1, label %then0, label %merge1
then0:
  ret i1 0
merge1:
  %t2 = call i1 @is_variation_selector(double %codepoint)
  br i1 %t2, label %then2, label %merge3
then2:
  ret i1 1
merge3:
  %t3 = call i1 @is_emoji_modifier(double %codepoint)
  br i1 %t3, label %then4, label %merge5
then4:
  ret i1 1
merge5:
  ret i1 false
}

define { i8**, i64 }* @iter_grapheme_clusters(i8* %text) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i1
  %l5 = alloca i64
  %l6 = alloca i64
  %l7 = alloca i8
  %l8 = alloca double
  %l9 = alloca double
  %l10 = alloca i1
  %l11 = alloca i1
  %l12 = alloca i1
  %t0 = alloca [0 x i8*]
  %t1 = getelementptr [0 x i8*], [0 x i8*]* %t0, i32 0, i32 0
  %t2 = alloca { i8**, i64 }
  %t3 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 0
  store i8** %t1, i8*** %t3
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* %t2, { i8**, i64 }** %l0
  %t5 = getelementptr i8, i8* %text, i64 0
  %t6 = load i8, i8* %t5
  store i8 %t6, i8* %l1
  %t7 = load i8, i8* %l1
  %t8 = call double @char_code(i8* null)
  store double %t8, double* %l2
  %t9 = load double, double* %l2
  store double 0.0, double* %l3
  %t10 = load double, double* %l2
  %t11 = call i1 @is_regional_indicator(double %t10)
  store i1 %t11, i1* %l4
  store i64 0, i64* %l5
  %t12 = load i1, i1* %l4
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load i8, i8* %l1
  %t15 = load double, double* %l2
  %t16 = load double, double* %l3
  %t17 = load i1, i1* %l4
  %t18 = load i64, i64* %l5
  br i1 %t12, label %then0, label %merge1
then0:
  store i64 1, i64* %l5
  br label %merge1
merge1:
  %t19 = phi i64 [ 1, %then0 ], [ %t18, %entry ]
  store i64 %t19, i64* %l5
  store i64 1, i64* %l6
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t21 = load i8, i8* %l1
  %t22 = load double, double* %l2
  %t23 = load double, double* %l3
  %t24 = load i1, i1* %l4
  %t25 = load i64, i64* %l5
  %t26 = load i64, i64* %l6
  br label %loop.header2
loop.header2:
  %t275 = phi { i8**, i64 }* [ %t20, %entry ], [ %t268, %loop.latch4 ]
  %t276 = phi i8 [ %t21, %entry ], [ %t269, %loop.latch4 ]
  %t277 = phi i64 [ %t25, %entry ], [ %t270, %loop.latch4 ]
  %t278 = phi double [ %t22, %entry ], [ %t271, %loop.latch4 ]
  %t279 = phi double [ %t23, %entry ], [ %t272, %loop.latch4 ]
  %t280 = phi i1 [ %t24, %entry ], [ %t273, %loop.latch4 ]
  %t281 = phi i64 [ %t26, %entry ], [ %t274, %loop.latch4 ]
  store { i8**, i64 }* %t275, { i8**, i64 }** %l0
  store i8 %t276, i8* %l1
  store i64 %t277, i64* %l5
  store double %t278, double* %l2
  store double %t279, double* %l3
  store i1 %t280, i1* %l4
  store i64 %t281, i64* %l6
  br label %loop.body3
loop.body3:
  %t27 = load i64, i64* %l6
  %t28 = load i64, i64* %l6
  %t29 = getelementptr i8, i8* %text, i64 %t28
  %t30 = load i8, i8* %t29
  store i8 %t30, i8* %l7
  %t31 = load i8, i8* %l7
  %t32 = call double @char_code(i8* null)
  store double %t32, double* %l8
  %t33 = load double, double* %l8
  store double 0.0, double* %l9
  %t34 = load double, double* %l8
  %t35 = call i1 @is_grapheme_extend(double %t34)
  store i1 %t35, i1* %l10
  %t36 = load double, double* %l8
  %t37 = call i1 @is_regional_indicator(double %t36)
  store i1 %t37, i1* %l11
  store i1 0, i1* %l12
  %t39 = load double, double* %l2
  %t40 = sitofp i64 13 to double
  %t41 = fcmp oeq double %t39, %t40
  br label %logical_and_entry_38

logical_and_entry_38:
  br i1 %t41, label %logical_and_right_38, label %logical_and_merge_38

logical_and_right_38:
  %t42 = load double, double* %l8
  %t43 = sitofp i64 10 to double
  %t44 = fcmp oeq double %t42, %t43
  br label %logical_and_right_end_38

logical_and_right_end_38:
  br label %logical_and_merge_38

logical_and_merge_38:
  %t45 = phi i1 [ false, %logical_and_entry_38 ], [ %t44, %logical_and_right_end_38 ]
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t47 = load i8, i8* %l1
  %t48 = load double, double* %l2
  %t49 = load double, double* %l3
  %t50 = load i1, i1* %l4
  %t51 = load i64, i64* %l5
  %t52 = load i64, i64* %l6
  %t53 = load i8, i8* %l7
  %t54 = load double, double* %l8
  %t55 = load double, double* %l9
  %t56 = load i1, i1* %l10
  %t57 = load i1, i1* %l11
  %t58 = load i1, i1* %l12
  br i1 %t45, label %then6, label %else7
then6:
  store i1 0, i1* %l12
  br label %merge8
else7:
  %t59 = load double, double* %l3
  %t60 = fcmp one double %t59, 0.0
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t62 = load i8, i8* %l1
  %t63 = load double, double* %l2
  %t64 = load double, double* %l3
  %t65 = load i1, i1* %l4
  %t66 = load i64, i64* %l5
  %t67 = load i64, i64* %l6
  %t68 = load i8, i8* %l7
  %t69 = load double, double* %l8
  %t70 = load double, double* %l9
  %t71 = load i1, i1* %l10
  %t72 = load i1, i1* %l11
  %t73 = load i1, i1* %l12
  br i1 %t60, label %then9, label %else10
then9:
  store i1 0, i1* %l12
  br label %merge11
else10:
  %t74 = load double, double* %l9
  %t75 = fcmp one double %t74, 0.0
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t77 = load i8, i8* %l1
  %t78 = load double, double* %l2
  %t79 = load double, double* %l3
  %t80 = load i1, i1* %l4
  %t81 = load i64, i64* %l5
  %t82 = load i64, i64* %l6
  %t83 = load i8, i8* %l7
  %t84 = load double, double* %l8
  %t85 = load double, double* %l9
  %t86 = load i1, i1* %l10
  %t87 = load i1, i1* %l11
  %t88 = load i1, i1* %l12
  br i1 %t75, label %then12, label %else13
then12:
  store i1 0, i1* %l12
  br label %merge14
else13:
  %t89 = load i1, i1* %l10
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t91 = load i8, i8* %l1
  %t92 = load double, double* %l2
  %t93 = load double, double* %l3
  %t94 = load i1, i1* %l4
  %t95 = load i64, i64* %l5
  %t96 = load i64, i64* %l6
  %t97 = load i8, i8* %l7
  %t98 = load double, double* %l8
  %t99 = load double, double* %l9
  %t100 = load i1, i1* %l10
  %t101 = load i1, i1* %l11
  %t102 = load i1, i1* %l12
  br i1 %t89, label %then15, label %else16
then15:
  store i1 0, i1* %l12
  br label %merge17
else16:
  %t105 = load i1, i1* %l11
  br label %logical_and_entry_104

logical_and_entry_104:
  br i1 %t105, label %logical_and_right_104, label %logical_and_merge_104

logical_and_right_104:
  %t106 = load i1, i1* %l4
  br label %logical_and_right_end_104

logical_and_right_end_104:
  br label %logical_and_merge_104

logical_and_merge_104:
  %t107 = phi i1 [ false, %logical_and_entry_104 ], [ %t106, %logical_and_right_end_104 ]
  br label %logical_and_entry_103

logical_and_entry_103:
  br i1 %t107, label %logical_and_right_103, label %logical_and_merge_103

logical_and_right_103:
  %t108 = load i64, i64* %l5
  %t109 = srem i64 %t108, 2
  %t110 = icmp eq i64 %t109, 1
  br label %logical_and_right_end_103

logical_and_right_end_103:
  br label %logical_and_merge_103

logical_and_merge_103:
  %t111 = phi i1 [ false, %logical_and_entry_103 ], [ %t110, %logical_and_right_end_103 ]
  %t112 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t113 = load i8, i8* %l1
  %t114 = load double, double* %l2
  %t115 = load double, double* %l3
  %t116 = load i1, i1* %l4
  %t117 = load i64, i64* %l5
  %t118 = load i64, i64* %l6
  %t119 = load i8, i8* %l7
  %t120 = load double, double* %l8
  %t121 = load double, double* %l9
  %t122 = load i1, i1* %l10
  %t123 = load i1, i1* %l11
  %t124 = load i1, i1* %l12
  br i1 %t111, label %then18, label %else19
then18:
  store i1 0, i1* %l12
  br label %merge20
else19:
  store i1 1, i1* %l12
  br label %merge20
merge20:
  %t125 = phi i1 [ 0, %then18 ], [ 1, %else19 ]
  store i1 %t125, i1* %l12
  br label %merge17
merge17:
  %t126 = phi i1 [ 0, %then15 ], [ 0, %else16 ]
  store i1 %t126, i1* %l12
  br label %merge14
merge14:
  %t127 = phi i1 [ 0, %then12 ], [ 0, %else13 ]
  store i1 %t127, i1* %l12
  br label %merge11
merge11:
  %t128 = phi i1 [ 0, %then9 ], [ 0, %else10 ]
  store i1 %t128, i1* %l12
  br label %merge8
merge8:
  %t129 = phi i1 [ 0, %then6 ], [ 0, %else7 ]
  store i1 %t129, i1* %l12
  %t130 = load i1, i1* %l12
  %t131 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t132 = load i8, i8* %l1
  %t133 = load double, double* %l2
  %t134 = load double, double* %l3
  %t135 = load i1, i1* %l4
  %t136 = load i64, i64* %l5
  %t137 = load i64, i64* %l6
  %t138 = load i8, i8* %l7
  %t139 = load double, double* %l8
  %t140 = load double, double* %l9
  %t141 = load i1, i1* %l10
  %t142 = load i1, i1* %l11
  %t143 = load i1, i1* %l12
  br i1 %t130, label %then21, label %else22
then21:
  %t144 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t145 = load i8, i8* %l1
  %t146 = alloca [1 x i8]
  %t147 = getelementptr [1 x i8], [1 x i8]* %t146, i32 0, i32 0
  %t148 = getelementptr i8, i8* %t147, i64 0
  store i8 %t145, i8* %t148
  %t149 = alloca { i8*, i64 }
  %t150 = getelementptr { i8*, i64 }, { i8*, i64 }* %t149, i32 0, i32 0
  store i8* %t147, i8** %t150
  %t151 = getelementptr { i8*, i64 }, { i8*, i64 }* %t149, i32 0, i32 1
  store i64 1, i64* %t151
  %t152 = bitcast { i8*, i64 }* %t149 to { i8**, i64 }*
  %t153 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t144, { i8**, i64 }* %t152)
  store { i8**, i64 }* %t153, { i8**, i64 }** %l0
  %t154 = load i8, i8* %l7
  store i8 %t154, i8* %l1
  %t155 = load i1, i1* %l11
  %t156 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t157 = load i8, i8* %l1
  %t158 = load double, double* %l2
  %t159 = load double, double* %l3
  %t160 = load i1, i1* %l4
  %t161 = load i64, i64* %l5
  %t162 = load i64, i64* %l6
  %t163 = load i8, i8* %l7
  %t164 = load double, double* %l8
  %t165 = load double, double* %l9
  %t166 = load i1, i1* %l10
  %t167 = load i1, i1* %l11
  %t168 = load i1, i1* %l12
  br i1 %t155, label %then24, label %else25
then24:
  store i64 1, i64* %l5
  br label %merge26
else25:
  store i64 0, i64* %l5
  br label %merge26
merge26:
  %t169 = phi i64 [ 1, %then24 ], [ 0, %else25 ]
  store i64 %t169, i64* %l5
  br label %merge23
else22:
  %t170 = load i8, i8* %l1
  %t171 = load i8, i8* %l7
  %t172 = add i8 %t170, %t171
  store i8 %t172, i8* %l1
  %t173 = load i1, i1* %l11
  %t174 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t175 = load i8, i8* %l1
  %t176 = load double, double* %l2
  %t177 = load double, double* %l3
  %t178 = load i1, i1* %l4
  %t179 = load i64, i64* %l5
  %t180 = load i64, i64* %l6
  %t181 = load i8, i8* %l7
  %t182 = load double, double* %l8
  %t183 = load double, double* %l9
  %t184 = load i1, i1* %l10
  %t185 = load i1, i1* %l11
  %t186 = load i1, i1* %l12
  br i1 %t173, label %then27, label %else28
then27:
  %t187 = load i64, i64* %l5
  %t188 = add i64 %t187, 1
  store i64 %t188, i64* %l5
  br label %merge29
else28:
  %t190 = load double, double* %l9
  %t191 = fcmp one double %t190, 0.0
  br label %logical_and_entry_189

logical_and_entry_189:
  br i1 %t191, label %logical_and_right_189, label %logical_and_merge_189

logical_and_right_189:
  %t192 = load i1, i1* %l10
  %t193 = xor i1 %t192, 1
  br label %logical_and_right_end_189

logical_and_right_end_189:
  br label %logical_and_merge_189

logical_and_merge_189:
  %t194 = phi i1 [ false, %logical_and_entry_189 ], [ %t193, %logical_and_right_end_189 ]
  %t195 = xor i1 %t194, 1
  %t196 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t197 = load i8, i8* %l1
  %t198 = load double, double* %l2
  %t199 = load double, double* %l3
  %t200 = load i1, i1* %l4
  %t201 = load i64, i64* %l5
  %t202 = load i64, i64* %l6
  %t203 = load i8, i8* %l7
  %t204 = load double, double* %l8
  %t205 = load double, double* %l9
  %t206 = load i1, i1* %l10
  %t207 = load i1, i1* %l11
  %t208 = load i1, i1* %l12
  br i1 %t195, label %then30, label %merge31
then30:
  store i64 0, i64* %l5
  br label %merge31
merge31:
  %t209 = phi i64 [ 0, %then30 ], [ %t201, %else28 ]
  store i64 %t209, i64* %l5
  br label %merge29
merge29:
  %t210 = phi i64 [ %t188, %then27 ], [ 0, %else28 ]
  store i64 %t210, i64* %l5
  br label %merge23
merge23:
  %t211 = phi { i8**, i64 }* [ %t153, %then21 ], [ %t131, %else22 ]
  %t212 = phi i8 [ %t154, %then21 ], [ %t172, %else22 ]
  %t213 = phi i64 [ 1, %then21 ], [ %t188, %else22 ]
  store { i8**, i64 }* %t211, { i8**, i64 }** %l0
  store i8 %t212, i8* %l1
  store i64 %t213, i64* %l5
  %t214 = load double, double* %l8
  store double %t214, double* %l2
  %t215 = load double, double* %l9
  store double %t215, double* %l3
  %t216 = load double, double* %l9
  %t217 = fcmp one double %t216, 0.0
  %t218 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t219 = load i8, i8* %l1
  %t220 = load double, double* %l2
  %t221 = load double, double* %l3
  %t222 = load i1, i1* %l4
  %t223 = load i64, i64* %l5
  %t224 = load i64, i64* %l6
  %t225 = load i8, i8* %l7
  %t226 = load double, double* %l8
  %t227 = load double, double* %l9
  %t228 = load i1, i1* %l10
  %t229 = load i1, i1* %l11
  %t230 = load i1, i1* %l12
  br i1 %t217, label %then32, label %else33
then32:
  store i1 0, i1* %l4
  store i64 0, i64* %l5
  br label %merge34
else33:
  %t231 = load i1, i1* %l10
  %t232 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t233 = load i8, i8* %l1
  %t234 = load double, double* %l2
  %t235 = load double, double* %l3
  %t236 = load i1, i1* %l4
  %t237 = load i64, i64* %l5
  %t238 = load i64, i64* %l6
  %t239 = load i8, i8* %l7
  %t240 = load double, double* %l8
  %t241 = load double, double* %l9
  %t242 = load i1, i1* %l10
  %t243 = load i1, i1* %l11
  %t244 = load i1, i1* %l12
  br i1 %t231, label %then35, label %else36
then35:
  br label %merge37
else36:
  %t245 = load i1, i1* %l11
  store i1 %t245, i1* %l4
  %t246 = load i1, i1* %l11
  %t247 = xor i1 %t246, 1
  %t248 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t249 = load i8, i8* %l1
  %t250 = load double, double* %l2
  %t251 = load double, double* %l3
  %t252 = load i1, i1* %l4
  %t253 = load i64, i64* %l5
  %t254 = load i64, i64* %l6
  %t255 = load i8, i8* %l7
  %t256 = load double, double* %l8
  %t257 = load double, double* %l9
  %t258 = load i1, i1* %l10
  %t259 = load i1, i1* %l11
  %t260 = load i1, i1* %l12
  br i1 %t247, label %then38, label %merge39
then38:
  store i64 0, i64* %l5
  br label %merge39
merge39:
  %t261 = phi i64 [ 0, %then38 ], [ %t253, %else36 ]
  store i64 %t261, i64* %l5
  br label %merge37
merge37:
  %t262 = phi i1 [ %t236, %then35 ], [ %t245, %else36 ]
  %t263 = phi i64 [ %t237, %then35 ], [ 0, %else36 ]
  store i1 %t262, i1* %l4
  store i64 %t263, i64* %l5
  br label %merge34
merge34:
  %t264 = phi i1 [ 0, %then32 ], [ %t245, %else33 ]
  %t265 = phi i64 [ 0, %then32 ], [ 0, %else33 ]
  store i1 %t264, i1* %l4
  store i64 %t265, i64* %l5
  %t266 = load i64, i64* %l6
  %t267 = add i64 %t266, 1
  store i64 %t267, i64* %l6
  br label %loop.latch4
loop.latch4:
  %t268 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t269 = load i8, i8* %l1
  %t270 = load i64, i64* %l5
  %t271 = load double, double* %l2
  %t272 = load double, double* %l3
  %t273 = load i1, i1* %l4
  %t274 = load i64, i64* %l6
  br label %loop.header2
afterloop5:
  %t282 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t283 = load i8, i8* %l1
  %t284 = alloca [1 x i8]
  %t285 = getelementptr [1 x i8], [1 x i8]* %t284, i32 0, i32 0
  %t286 = getelementptr i8, i8* %t285, i64 0
  store i8 %t283, i8* %t286
  %t287 = alloca { i8*, i64 }
  %t288 = getelementptr { i8*, i64 }, { i8*, i64 }* %t287, i32 0, i32 0
  store i8* %t285, i8** %t288
  %t289 = getelementptr { i8*, i64 }, { i8*, i64 }* %t287, i32 0, i32 1
  store i64 1, i64* %t289
  %t290 = bitcast { i8*, i64 }* %t287 to { i8**, i64 }*
  %t291 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t282, { i8**, i64 }* %t290)
  store { i8**, i64 }* %t291, { i8**, i64 }** %l0
  %t292 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t292
}

define double @grapheme_count(i8* %text) {
entry:
  %l0 = alloca { i8**, i64 }*
  %t0 = call { i8**, i64 }* @iter_grapheme_clusters(i8* %text)
  store { i8**, i64 }* %t0, { i8**, i64 }** %l0
  %t1 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t2 = load { i8**, i64 }, { i8**, i64 }* %t1
  %t3 = extractvalue { i8**, i64 } %t2, 1
  %t4 = sitofp i64 %t3 to double
  ret double %t4
}

define i8* @grapheme_at(i8* %text, double %index) {
entry:
  %l0 = alloca { i8**, i64 }*
  %t0 = sitofp i64 0 to double
  %t1 = fcmp olt double %index, %t0
  br i1 %t1, label %then0, label %merge1
then0:
  %s2 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.2, i32 0, i32 0
  ret i8* %s2
merge1:
  %t3 = call { i8**, i64 }* @iter_grapheme_clusters(i8* %text)
  store { i8**, i64 }* %t3, { i8**, i64 }** %l0
  %t4 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t5 = load { i8**, i64 }, { i8**, i64 }* %t4
  %t6 = extractvalue { i8**, i64 } %t5, 1
  %t7 = sitofp i64 %t6 to double
  %t8 = fcmp oge double %index, %t7
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br i1 %t8, label %then2, label %merge3
then2:
  %s10 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.10, i32 0, i32 0
  ret i8* %s10
merge3:
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t12 = load { i8**, i64 }, { i8**, i64 }* %t11
  %t13 = extractvalue { i8**, i64 } %t12, 0
  %t14 = extractvalue { i8**, i64 } %t12, 1
  %t15 = icmp uge i64 %index, %t14
  ; bounds check: %t15 (if true, out of bounds)
  %t16 = getelementptr i8*, i8** %t13, i64 %index
  %t17 = load i8*, i8** %t16
  ret i8* %t17
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
