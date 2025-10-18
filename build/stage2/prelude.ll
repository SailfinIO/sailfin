; ModuleID = 'sailfin'
source_filename = "sailfin"

%EnumField = type { i8*, i8* }
%EnumVariantDefinition = type { i8*, { i8**, i64 }* }
%EnumType = type { i8*, { i8**, i64 }* }
%EnumInstance = type { i8*, i8*, { i8**, i64 }* }
%StructField = type { i8*, i8* }
%TypeDescriptor = type { i8*, i8*, { i8**, i64 }* }

declare noalias i8* @malloc(i64)

@.str.0 = private unnamed_addr constant [2 x i8] c"(\00"
@.str.0 = private unnamed_addr constant [1 x i8] c"\00"
@.str.0 = private unnamed_addr constant [10 x i8] c"primitive\00"
@.str.0 = private unnamed_addr constant [6 x i8] c"union\00"
@.str.0 = private unnamed_addr constant [13 x i8] c"intersection\00"
@.str.0 = private unnamed_addr constant [6 x i8] c"array\00"
@.str.0 = private unnamed_addr constant [9 x i8] c"function\00"
@.str.0 = private unnamed_addr constant [6 x i8] c"named\00"
@.str.0 = private unnamed_addr constant [8 x i8] c"unknown\00"
@.str.3 = private unnamed_addr constant [2 x i8] c"|\00"
@.str.7 = private unnamed_addr constant [2 x i8] c"&\00"
@.str.2 = private unnamed_addr constant [11 x i8] c"0123456789\00"
@.str.16 = private unnamed_addr constant [27 x i8] c"abcdefghijklmnopqrstuvwxyz\00"
@.str.32 = private unnamed_addr constant [27 x i8] c"ABCDEFGHIJKLMNOPQRSTUVWXYZ\00"

define void @capability_grant(double %effects) {
entry:
  %t0 = call double @runtimecreate_capability_grant(double %effects)
  ret void
}

define void @fs_bridge(double %grant) {
entry:
  %t0 = call double @runtimecreate_filesystem_bridge(double %grant)
  ret void
}

define void @http_bridge(double %grant) {
entry:
  %t0 = call double @runtimecreate_http_bridge(double %grant)
  ret void
}

define void @model_bridge(double %grant) {
entry:
  %t0 = call double @runtimecreate_model_bridge(double %grant)
  ret void
}

; fn sleep effects: ![clock]
define void @sleep(double %milliseconds) {
entry:
  %t0 = call double @runtimesleep(double %milliseconds)
  ret void
}

; fn channel effects: ![io]
define void @channel(double %capacity) {
entry:
  %t0 = call double @runtimechannel(double %capacity)
  ret void
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
  %t0 = call double @runtimespawn(double %task, i8* %name)
  ret void
}

define void @logExecution(double %callable) {
entry:
  %t0 = call double @runtimelogExecution(double %callable)
  ret void
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
  %t1 = alloca [0 x double]
  %t2 = getelementptr [0 x double], [0 x double]* %t1, i32 0, i32 0
  %t3 = alloca { double*, i64 }
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 0
  store double* %t2, double** %t4
  %t5 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  %t6 = insertvalue %EnumType %t0, { i8**, i64 }* null, 1
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
  %l1 = alloca double
  %t0 = insertvalue %EnumVariantDefinition undef, i8* %variant_name, 0
  %t1 = insertvalue %EnumVariantDefinition %t0, { i8**, i64 }* %field_names, 1
  store %EnumVariantDefinition %t1, %EnumVariantDefinition* %l0
  %t2 = load %EnumVariantDefinition, %EnumVariantDefinition* %l0
  %t3 = alloca [1 x %EnumVariantDefinition]
  %t4 = getelementptr [1 x %EnumVariantDefinition], [1 x %EnumVariantDefinition]* %t3, i32 0, i32 0
  %t5 = getelementptr %EnumVariantDefinition, %EnumVariantDefinition* %t4, i64 0
  store %EnumVariantDefinition %t2, %EnumVariantDefinition* %t5
  %t6 = alloca { %EnumVariantDefinition*, i64 }
  %t7 = getelementptr { %EnumVariantDefinition*, i64 }, { %EnumVariantDefinition*, i64 }* %t6, i32 0, i32 0
  store %EnumVariantDefinition* %t4, %EnumVariantDefinition** %t7
  %t8 = getelementptr { %EnumVariantDefinition*, i64 }, { %EnumVariantDefinition*, i64 }* %t6, i32 0, i32 1
  store i64 1, i64* %t8
  %t9 = call double @enum_typevariantsconcat({ %EnumVariantDefinition*, i64 }* %t6)
  store double %t9, double* %l1
  %t10 = extractvalue %EnumType %enum_type, 0
  %t11 = insertvalue %EnumType undef, i8* %t10, 0
  %t12 = load double, double* %l1
  %t13 = insertvalue %EnumType %t11, { i8**, i64 }* null, 1
  ret %EnumType %t13
}

define { %EnumField*, i64 }* @enum_normalize_fields(i8* %definition, { %EnumField*, i64 }* %provided) {
entry:
  %l0 = alloca double
  %l1 = alloca { %EnumField*, i64 }*
  %l2 = alloca i64
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  store double 0.0, double* %l0
  %t0 = load double, double* %l0
  %t1 = alloca [0 x double]
  %t2 = getelementptr [0 x double], [0 x double]* %t1, i32 0, i32 0
  %t3 = alloca { double*, i64 }
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 0
  store double* %t2, double** %t4
  %t5 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { %EnumField*, i64 }* null, { %EnumField*, i64 }** %l1
  store i64 0, i64* %l2
  %t6 = load double, double* %l0
  %t7 = load { %EnumField*, i64 }*, { %EnumField*, i64 }** %l1
  %t8 = load i64, i64* %l2
  br label %loop.header0
loop.header0:
  %t20 = phi { %EnumField*, i64 }* [ %t7, %entry ], [ %t18, %loop.latch2 ]
  %t21 = phi i64 [ %t8, %entry ], [ %t19, %loop.latch2 ]
  store { %EnumField*, i64 }* %t20, { %EnumField*, i64 }** %l1
  store i64 %t21, i64* %l2
  br label %loop.body1
loop.body1:
  %t9 = load i64, i64* %l2
  %t10 = load double, double* %l0
  %t11 = load double, double* %l0
  %t12 = load i64, i64* %l2
  store double 0.0, double* %l3
  %t13 = load double, double* %l3
  %t14 = call double @enum_lookup_field({ %EnumField*, i64 }* %provided, i8* null)
  store double %t14, double* %l4
  store double 0.0, double* %l5
  %t15 = load double, double* %l4
  %t16 = load i64, i64* %l2
  %t17 = add i64 %t16, 1
  store i64 %t17, i64* %l2
  br label %loop.latch2
loop.latch2:
  %t18 = load { %EnumField*, i64 }*, { %EnumField*, i64 }** %l1
  %t19 = load i64, i64* %l2
  br label %loop.header0
afterloop3:
  %t22 = load { %EnumField*, i64 }*, { %EnumField*, i64 }** %l1
  ret { %EnumField*, i64 }* %t22
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
  %t6 = insertvalue %EnumInstance %t4, { i8**, i64 }* null, 2
  ret %EnumInstance %t6
}

define void @enum_get_field(%EnumInstance %instance, i8* %name) {
entry:
  %l0 = alloca i64
  %l1 = alloca i8*
  store i64 0, i64* %l0
  %t0 = load i64, i64* %l0
  br label %loop.header0
loop.header0:
  %t15 = phi i64 [ %t0, %entry ], [ %t14, %loop.latch2 ]
  store i64 %t15, i64* %l0
  br label %loop.body1
loop.body1:
  %t1 = load i64, i64* %l0
  %t2 = extractvalue %EnumInstance %instance, 2
  %t3 = extractvalue %EnumInstance %instance, 2
  %t4 = load i64, i64* %l0
  %t5 = load { i8**, i64 }, { i8**, i64 }* %t3
  %t6 = extractvalue { i8**, i64 } %t5, 0
  %t7 = extractvalue { i8**, i64 } %t5, 1
  %t8 = icmp uge i64 %t4, %t7
  ; bounds check: %t8 (if true, out of bounds)
  %t9 = getelementptr i8*, i8** %t6, i64 %t4
  %t10 = load i8*, i8** %t9
  store i8* %t10, i8** %l1
  %t11 = load i8*, i8** %l1
  %t12 = load i64, i64* %l0
  %t13 = add i64 %t12, 1
  store i64 %t13, i64* %l0
  br label %loop.latch2
loop.latch2:
  %t14 = load i64, i64* %l0
  br label %loop.header0
afterloop3:
  ret void zeroinitializer
}

define %StructField @struct_field(i8* %name, double %value) {
entry:
  %t0 = insertvalue %StructField undef, i8* %name, 0
  %t1 = insertvalue %StructField %t0, i8* null, 1
  ret %StructField %t1
}

define i8* @struct_repr(i8* %name, { %StructField*, i64 }* %fields) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i64
  %l2 = alloca %StructField
  %l3 = alloca i8*
  %s0 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.0, i32 0, i32 0
  %t1 = add i8* %name, %s0
  store i8* %t1, i8** %l0
  store i64 0, i64* %l1
  %t2 = load i8*, i8** %l0
  %t3 = load i64, i64* %l1
  br label %loop.header0
loop.header0:
  %t35 = phi i8* [ %t2, %entry ], [ %t33, %loop.latch2 ]
  %t36 = phi i64 [ %t3, %entry ], [ %t34, %loop.latch2 ]
  store i8* %t35, i8** %l0
  store i64 %t36, i64* %l1
  br label %loop.body1
loop.body1:
  %t4 = load i64, i64* %l1
  %t5 = load i64, i64* %l1
  %t6 = icmp sgt i64 %t5, 0
  %t7 = load i8*, i8** %l0
  %t8 = load i64, i64* %l1
  br i1 %t6, label %then4, label %merge5
then4:
  %t9 = load i8*, i8** %l0
  %s10 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.10, i32 0, i32 0
  %t11 = add i8* %t9, %s10
  store i8* %t11, i8** %l0
  br label %merge5
merge5:
  %t12 = phi i8* [ %t11, %then4 ], [ %t7, %loop.body1 ]
  store i8* %t12, i8** %l0
  %t13 = load i64, i64* %l1
  %t14 = load { %StructField*, i64 }, { %StructField*, i64 }* %fields
  %t15 = extractvalue { %StructField*, i64 } %t14, 0
  %t16 = extractvalue { %StructField*, i64 } %t14, 1
  %t17 = icmp uge i64 %t13, %t16
  ; bounds check: %t17 (if true, out of bounds)
  %t18 = getelementptr %StructField, %StructField* %t15, i64 %t13
  %t19 = load %StructField, %StructField* %t18
  store %StructField %t19, %StructField* %l2
  %t20 = load %StructField, %StructField* %l2
  %t21 = extractvalue %StructField %t20, 1
  %t22 = call i8* @to_debug_string(double 0.0)
  store i8* %t22, i8** %l3
  %t23 = load i8*, i8** %l0
  %t24 = load %StructField, %StructField* %l2
  %t25 = extractvalue %StructField %t24, 0
  %t26 = add i8* %t23, %t25
  %s27 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.27, i32 0, i32 0
  %t28 = add i8* %t26, %s27
  %t29 = load i8*, i8** %l3
  %t30 = add i8* %t28, %t29
  store i8* %t30, i8** %l0
  %t31 = load i64, i64* %l1
  %t32 = add i64 %t31, 1
  store i64 %t32, i64* %l1
  br label %loop.latch2
loop.latch2:
  %t33 = load i8*, i8** %l0
  %t34 = load i64, i64* %l1
  br label %loop.header0
afterloop3:
  %t37 = load i8*, i8** %l0
  ret i8* %t37
}

define i8* @to_debug_string(double %value) {
entry:
  %t0 = call double @runtimeto_debug_string(double %value)
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
  %t18 = phi i8* [ %t1, %entry ], [ %t16, %loop.latch2 ]
  %t19 = phi i64 [ %t2, %entry ], [ %t17, %loop.latch2 ]
  store i8* %t18, i8** %l0
  store i64 %t19, i64* %l1
  br label %loop.body1
loop.body1:
  %t3 = load i64, i64* %l1
  %t4 = load i8*, i8** %l0
  %t5 = load i64, i64* %l1
  %t6 = load { i8**, i64 }, { i8**, i64 }* %parts
  %t7 = extractvalue { i8**, i64 } %t6, 0
  %t8 = extractvalue { i8**, i64 } %t6, 1
  %t9 = icmp uge i64 %t5, %t8
  ; bounds check: %t9 (if true, out of bounds)
  %t10 = getelementptr i8*, i8** %t7, i64 %t5
  %t11 = load i8*, i8** %t10
  %t12 = add i8* %t4, %t11
  store i8* %t12, i8** %l0
  %t13 = load i64, i64* %l1
  %t14 = load i64, i64* %l1
  %t15 = add i64 %t14, 1
  store i64 %t15, i64* %l1
  br label %loop.latch2
loop.latch2:
  %t16 = load i8*, i8** %l0
  %t17 = load i64, i64* %l1
  br label %loop.header0
afterloop3:
  %t20 = load i8*, i8** %l0
  ret i8* %t20
}

define %TypeDescriptor @type_descriptor(i8* %kind, i8* %name, { %TypeDescriptor*, i64 }* %items) {
entry:
  %t0 = insertvalue %TypeDescriptor undef, i8* %kind, 0
  %t1 = insertvalue %TypeDescriptor %t0, i8* %name, 1
  %t2 = insertvalue %TypeDescriptor %t1, { i8**, i64 }* null, 2
  ret %TypeDescriptor %t2
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
  %t6 = call %TypeDescriptor @type_descriptor(i8* %s0, i8* %name, { %TypeDescriptor*, i64 }* null)
  ret %TypeDescriptor %t6
}

define %TypeDescriptor @type_descriptor_union({ %TypeDescriptor*, i64 }* %descriptors) {
entry:
  %s0 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.0, i32 0, i32 0
  ret %TypeDescriptor zeroinitializer
}

define %TypeDescriptor @type_descriptor_intersection({ %TypeDescriptor*, i64 }* %descriptors) {
entry:
  %s0 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.0, i32 0, i32 0
  ret %TypeDescriptor zeroinitializer
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
  ret %TypeDescriptor zeroinitializer
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
  ret %TypeDescriptor zeroinitializer
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
  %t6 = call %TypeDescriptor @type_descriptor(i8* %s0, i8* %name, { %TypeDescriptor*, i64 }* null)
  ret %TypeDescriptor %t6
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
  ret %TypeDescriptor zeroinitializer
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
  %t11 = load i8, i8* %l2
  br label %afterloop3
loop.latch2:
  br label %loop.header0
afterloop3:
  %t12 = load i64, i64* %l0
  %t13 = load double, double* %l1
  br label %loop.header6
loop.header6:
  br label %loop.body7
loop.body7:
  %t14 = load double, double* %l1
  %t15 = load i64, i64* %l0
  %t16 = sitofp i64 %t15 to double
  %t17 = fcmp ole double %t14, %t16
  %t18 = load i64, i64* %l0
  %t19 = load double, double* %l1
  br i1 %t17, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  store double 0.0, double* %l3
  %t20 = load double, double* %l3
  br label %afterloop9
loop.latch8:
  br label %loop.header6
afterloop9:
  %t21 = load i64, i64* %l0
  %t22 = load double, double* %l1
  %t23 = sitofp i64 %t21 to double
  %t24 = call i8* @substring(i8* %value, double %t23, double %t22)
  ret i8* %t24
}

define i1 @string_starts_with(i8* %value, i8* %prefix) {
entry:
  %l0 = alloca i64
  store i64 0, i64* %l0
  %t0 = load i64, i64* %l0
  br label %loop.header0
loop.header0:
  %t11 = phi i64 [ %t0, %entry ], [ %t10, %loop.latch2 ]
  store i64 %t11, i64* %l0
  br label %loop.body1
loop.body1:
  %t1 = load i64, i64* %l0
  %t2 = load i64, i64* %l0
  %t3 = getelementptr i8, i8* %value, i64 %t2
  %t4 = load i8, i8* %t3
  %t5 = load i64, i64* %l0
  %t6 = getelementptr i8, i8* %prefix, i64 %t5
  %t7 = load i8, i8* %t6
  %t8 = load i64, i64* %l0
  %t9 = add i64 %t8, 1
  store i64 %t9, i64* %l0
  br label %loop.latch2
loop.latch2:
  %t10 = load i64, i64* %l0
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
  %t21 = phi i64 [ %t5, %entry ], [ %t20, %loop.latch2 ]
  store i64 %t21, i64* %l2
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
  %s16 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.16, i32 0, i32 0
  %t17 = load i8, i8* %l6
  %t18 = load i64, i64* %l2
  %t19 = add i64 %t18, 1
  store i64 %t19, i64* %l2
  br label %loop.latch2
loop.latch2:
  %t20 = load i64, i64* %l2
  br label %loop.header0
afterloop3:
  %t22 = sitofp i64 -1 to double
  ret double %t22
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
  %t26 = phi i8* [ %t1, %entry ], [ %t25, %loop.latch2 ]
  store i8* %t26, i8** %l0
  br label %loop.body1
loop.body1:
  %t2 = load i8*, i8** %l0
  %t3 = load i8*, i8** %l0
  %t4 = getelementptr i8, i8* %t3, i64 0
  %t5 = load i8, i8* %t4
  %s6 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.6, i32 0, i32 0
  store i64 0, i64* %l1
  store i64 0, i64* %l2
  store i1 1, i1* %l3
  %t7 = load i8*, i8** %l0
  %t8 = load i64, i64* %l1
  %t9 = load i64, i64* %l2
  %t10 = load i1, i1* %l3
  br label %loop.header4
loop.header4:
  %t22 = phi i64 [ %t9, %loop.body1 ], [ %t21, %loop.latch6 ]
  store i64 %t22, i64* %l2
  br label %loop.body5
loop.body5:
  %t11 = load i64, i64* %l2
  %t12 = load i8*, i8** %l0
  %t13 = load i8*, i8** %l0
  %t14 = load i64, i64* %l2
  %t15 = getelementptr i8, i8* %t13, i64 %t14
  %t16 = load i8, i8* %t15
  store i8 %t16, i8* %l4
  %t17 = load i8, i8* %l4
  %s18 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.18, i32 0, i32 0
  %t19 = load i64, i64* %l2
  %t20 = add i64 %t19, 1
  store i64 %t20, i64* %l2
  br label %loop.latch6
loop.latch6:
  %t21 = load i64, i64* %l2
  br label %loop.header4
afterloop7:
  %t23 = load i8*, i8** %l0
  %t24 = load i8*, i8** %l0
  br label %loop.latch2
loop.latch2:
  %t25 = load i8*, i8** %l0
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
  %l9 = alloca double
  %l10 = alloca i8*
  %t0 = call i8* @descriptor_trim(i8* %value)
  store i8* %t0, i8** %l0
  %t1 = alloca [0 x double]
  %t2 = getelementptr [0 x double], [0 x double]* %t1, i32 0, i32 0
  %t3 = alloca { double*, i64 }
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 0
  store double* %t2, double** %t4
  %t5 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { i8**, i64 }* null, { i8**, i64 }** %l1
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
  %t28 = phi i64 [ %t11, %entry ], [ %t27, %loop.latch2 ]
  store i64 %t28, i64* %l3
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
  %s23 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.23, i32 0, i32 0
  %t24 = load i8, i8* %l8
  %t25 = load i64, i64* %l3
  %t26 = add i64 %t25, 1
  store i64 %t26, i64* %l3
  br label %loop.latch2
loop.latch2:
  %t27 = load i64, i64* %l3
  br label %loop.header0
afterloop3:
  %t29 = load i8*, i8** %l0
  %t30 = load i64, i64* %l2
  %t31 = load i8*, i8** %l0
  store double 0.0, double* %l9
  %t32 = load double, double* %l9
  %t33 = call i8* @descriptor_trim(i8* null)
  store i8* %t33, i8** %l10
  %t34 = load i8*, i8** %l10
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l1
  ret { i8**, i64 }* %t35
}

define { %TypeDescriptor*, i64 }* @parse_descriptor_list({ i8**, i64 }* %parts) {
entry:
  %l0 = alloca { %TypeDescriptor*, i64 }*
  %l1 = alloca i64
  %l2 = alloca i8*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %TypeDescriptor*, i64 }* null, { %TypeDescriptor*, i64 }** %l0
  store i64 0, i64* %l1
  %t5 = load { %TypeDescriptor*, i64 }*, { %TypeDescriptor*, i64 }** %l0
  %t6 = load i64, i64* %l1
  br label %loop.header0
loop.header0:
  %t19 = phi i64 [ %t6, %entry ], [ %t18, %loop.latch2 ]
  store i64 %t19, i64* %l1
  br label %loop.body1
loop.body1:
  %t7 = load i64, i64* %l1
  %t8 = load i64, i64* %l1
  %t9 = load { i8**, i64 }, { i8**, i64 }* %parts
  %t10 = extractvalue { i8**, i64 } %t9, 0
  %t11 = extractvalue { i8**, i64 } %t9, 1
  %t12 = icmp uge i64 %t8, %t11
  ; bounds check: %t12 (if true, out of bounds)
  %t13 = getelementptr i8*, i8** %t10, i64 %t8
  %t14 = load i8*, i8** %t13
  store i8* %t14, i8** %l2
  %t15 = load i8*, i8** %l2
  %t16 = load i64, i64* %l1
  %t17 = add i64 %t16, 1
  store i64 %t17, i64* %l1
  br label %loop.latch2
loop.latch2:
  %t18 = load i64, i64* %l1
  br label %loop.header0
afterloop3:
  %t20 = load { %TypeDescriptor*, i64 }*, { %TypeDescriptor*, i64 }** %l0
  ret { %TypeDescriptor*, i64 }* %t20
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
  %s3 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.3, i32 0, i32 0
  %t4 = call { i8**, i64 }* @split_descriptor(i8* %t2, i8* %s3)
  store { i8**, i64 }* %t4, { i8**, i64 }** %l1
  %t5 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t6 = load i8*, i8** %l0
  %s7 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.7, i32 0, i32 0
  %t8 = call { i8**, i64 }* @split_descriptor(i8* %t6, i8* %s7)
  store { i8**, i64 }* %t8, { i8**, i64 }** %l2
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t10 = load i8*, i8** %l0
  %s11 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.11, i32 0, i32 0
  %t12 = call i1 @string_ends_with(i8* %t10, i8* %s11)
  %t13 = load i8*, i8** %l0
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t12, label %then0, label %merge1
then0:
  %t16 = load i8*, i8** %l0
  %t17 = load i8*, i8** %l0
  store double 0.0, double* %l3
  %t18 = load double, double* %l3
  %t19 = call %TypeDescriptor @parse_type_descriptor(i8* null)
  %t20 = call %TypeDescriptor @type_descriptor_array(%TypeDescriptor %t19)
  ret %TypeDescriptor %t20
merge1:
  %t21 = load i8*, i8** %l0
  %s22 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.22, i32 0, i32 0
  %t23 = call i1 @string_starts_with(i8* %t21, i8* %s22)
  %t24 = load i8*, i8** %l0
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t23, label %then2, label %merge3
then2:
  %t27 = call %TypeDescriptor @type_descriptor_function()
  ret %TypeDescriptor %t27
merge3:
  %t28 = load i8*, i8** %l0
  store double 0.0, double* %l4
  %t29 = load i8*, i8** %l0
  store i8* %t29, i8** %l5
  %t30 = load double, double* %l4
  %t31 = sitofp i64 0 to double
  %t32 = fcmp oge double %t30, %t31
  %t33 = load i8*, i8** %l0
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t36 = load double, double* %l4
  %t37 = load i8*, i8** %l5
  br i1 %t32, label %then4, label %merge5
then4:
  %t38 = load i8*, i8** %l0
  %t39 = load double, double* %l4
  %t40 = sitofp i64 0 to double
  %t41 = call i8* @substring(i8* %t38, double %t40, double %t39)
  %t42 = call i8* @descriptor_trim(i8* %t41)
  store i8* %t42, i8** %l5
  br label %merge5
merge5:
  %t43 = phi i8* [ %t42, %then4 ], [ %t37, %entry ]
  store i8* %t43, i8** %l5
  %t44 = load i8*, i8** %l5
  %s45 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.45, i32 0, i32 0
  %t46 = call i1 @string_starts_with(i8* %t44, i8* %s45)
  %t47 = load i8*, i8** %l0
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t50 = load double, double* %l4
  %t51 = load i8*, i8** %l5
  br i1 %t46, label %then6, label %merge7
then6:
  %t52 = load i8*, i8** %l5
  %t53 = load i8*, i8** %l5
  br label %merge7
merge7:
  %t54 = phi i8* [ null, %then6 ], [ %t51, %entry ]
  store i8* %t54, i8** %l5
  %t55 = load i8*, i8** %l5
  %t56 = load i8*, i8** %l5
  %t57 = call %TypeDescriptor @type_descriptor_named(i8* %t56)
  ret %TypeDescriptor %t57
}

define i1 @check_type_primitive(double %value, i8* %name) {
entry:
  %s0 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.0, i32 0, i32 0
  %s1 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.1, i32 0, i32 0
  %s2 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.2, i32 0, i32 0
  %s3 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.3, i32 0, i32 0
  ret i1 0
}

define i1 @check_type_descriptor(double %value, %TypeDescriptor %descriptor) {
entry:
  %t0 = extractvalue %TypeDescriptor %descriptor, 0
  %s1 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.1, i32 0, i32 0
  %t2 = extractvalue %TypeDescriptor %descriptor, 0
  %s3 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.3, i32 0, i32 0
  %t4 = extractvalue %TypeDescriptor %descriptor, 0
  %s5 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.5, i32 0, i32 0
  %t6 = extractvalue %TypeDescriptor %descriptor, 0
  %s7 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.7, i32 0, i32 0
  %t8 = extractvalue %TypeDescriptor %descriptor, 0
  %s9 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.9, i32 0, i32 0
  %t10 = extractvalue %TypeDescriptor %descriptor, 0
  %s11 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.11, i32 0, i32 0
  %t12 = extractvalue %TypeDescriptor %descriptor, 0
  %s13 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.13, i32 0, i32 0
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
  %t0 = call double @runtimeserve(double %handler, double %config)
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
  %t42 = phi i8* [ %t24, %entry ], [ %t40, %loop.latch6 ]
  %t43 = phi double [ %t23, %entry ], [ %t41, %loop.latch6 ]
  store i8* %t42, i8** %l4
  store double %t43, double* %l3
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
  %t37 = load double, double* %l3
  %t38 = sitofp i64 1 to double
  %t39 = fadd double %t37, %t38
  store double %t39, double* %l3
  br label %loop.latch6
loop.latch6:
  %t40 = load i8*, i8** %l4
  %t41 = load double, double* %l3
  br label %loop.header4
afterloop7:
  %t44 = load i8*, i8** %l4
  ret i8* %t44
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
  %t18 = load i8*, i8** %l2
  %t19 = load double, double* %l1
  store double %t19, double* %l3
  %t20 = load double, double* %l0
  %t21 = load double, double* %l1
  %t22 = load i8*, i8** %l2
  %t23 = load double, double* %l3
  br label %loop.header6
loop.header6:
  %t39 = phi double [ %t23, %entry ], [ %t38, %loop.latch8 ]
  store double %t39, double* %l3
  br label %loop.body7
loop.body7:
  %t24 = load double, double* %l3
  %t25 = load double, double* %l0
  %t26 = fcmp oge double %t24, %t25
  %t27 = load double, double* %l0
  %t28 = load double, double* %l1
  %t29 = load i8*, i8** %l2
  %t30 = load double, double* %l3
  br i1 %t26, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t31 = load double, double* %l3
  %t32 = getelementptr i8, i8* %text, i64 %t31
  %t33 = load i8, i8* %t32
  %t34 = load i8*, i8** %l2
  %t35 = load double, double* %l3
  %t36 = sitofp i64 1 to double
  %t37 = fadd double %t35, %t36
  store double %t37, double* %l3
  br label %loop.latch8
loop.latch8:
  %t38 = load double, double* %l3
  br label %loop.header6
afterloop9:
  %t40 = sitofp i64 -1 to double
  ret double %t40
}

define void @match_exhaustive_failed(double %value) {
entry:
  %l0 = alloca double
  store double 0.0, double* %l0
  %t0 = load double, double* %l0
  %t1 = call double @runtimeraise_value_error(double %t0)
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
  %s51 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.51, i32 0, i32 0
  %t52 = load i8, i8* %l0
  %s53 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.53, i32 0, i32 0
  %t54 = load i8, i8* %l0
  %s55 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.55, i32 0, i32 0
  %t56 = load i8, i8* %l0
  %s57 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.57, i32 0, i32 0
  %t58 = load i8, i8* %l0
  %s59 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.59, i32 0, i32 0
  %t60 = load i8, i8* %l0
  %s61 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.61, i32 0, i32 0
  %t62 = load i8, i8* %l0
  %s63 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.63, i32 0, i32 0
  store double 0.0, double* %l7
  %t64 = load double, double* %l7
  store double 0.0, double* %l8
  %t65 = load double, double* %l8
  %t66 = sitofp i64 0 to double
  %t67 = fcmp oeq double %t65, %t66
  %t68 = load i8, i8* %l0
  %t69 = load i8*, i8** %l1
  %t70 = load double, double* %l2
  %t71 = load i8*, i8** %l3
  %t72 = load double, double* %l4
  %t73 = load i8*, i8** %l5
  %t74 = load double, double* %l6
  %t75 = load double, double* %l7
  %t76 = load double, double* %l8
  br i1 %t67, label %then6, label %merge7
then6:
  %t77 = sitofp i64 -1 to double
  ret double %t77
merge7:
  %t78 = load double, double* %l8
  %t79 = sitofp i64 4 to double
  %t80 = fcmp ogt double %t78, %t79
  %t81 = load i8, i8* %l0
  %t82 = load i8*, i8** %l1
  %t83 = load double, double* %l2
  %t84 = load i8*, i8** %l3
  %t85 = load double, double* %l4
  %t86 = load i8*, i8** %l5
  %t87 = load double, double* %l6
  %t88 = load double, double* %l7
  %t89 = load double, double* %l8
  br i1 %t80, label %then8, label %merge9
then8:
  %t90 = sitofp i64 -1 to double
  ret double %t90
merge9:
  store i64 0, i64* %l9
  store i64 0, i64* %l10
  %t91 = load i8, i8* %l0
  %t92 = load i8*, i8** %l1
  %t93 = load double, double* %l2
  %t94 = load i8*, i8** %l3
  %t95 = load double, double* %l4
  %t96 = load i8*, i8** %l5
  %t97 = load double, double* %l6
  %t98 = load double, double* %l7
  %t99 = load double, double* %l8
  %t100 = load i64, i64* %l9
  %t101 = load i64, i64* %l10
  br label %loop.header10
loop.header10:
  %t164 = phi i64 [ %t101, %entry ], [ %t162, %loop.latch12 ]
  %t165 = phi i64 [ %t100, %entry ], [ %t163, %loop.latch12 ]
  store i64 %t164, i64* %l10
  store i64 %t165, i64* %l9
  br label %loop.body11
loop.body11:
  %t102 = load i64, i64* %l9
  %t103 = load double, double* %l8
  %t104 = sitofp i64 %t102 to double
  %t105 = fcmp oge double %t104, %t103
  %t106 = load i8, i8* %l0
  %t107 = load i8*, i8** %l1
  %t108 = load double, double* %l2
  %t109 = load i8*, i8** %l3
  %t110 = load double, double* %l4
  %t111 = load i8*, i8** %l5
  %t112 = load double, double* %l6
  %t113 = load double, double* %l7
  %t114 = load double, double* %l8
  %t115 = load i64, i64* %l9
  %t116 = load i64, i64* %l10
  br i1 %t105, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t117 = load double, double* %l7
  %t118 = load i64, i64* %l9
  store double 0.0, double* %l11
  %t119 = load i64, i64* %l9
  %t120 = icmp eq i64 %t119, 0
  %t121 = load i8, i8* %l0
  %t122 = load i8*, i8** %l1
  %t123 = load double, double* %l2
  %t124 = load i8*, i8** %l3
  %t125 = load double, double* %l4
  %t126 = load i8*, i8** %l5
  %t127 = load double, double* %l6
  %t128 = load double, double* %l7
  %t129 = load double, double* %l8
  %t130 = load i64, i64* %l9
  %t131 = load i64, i64* %l10
  %t132 = load double, double* %l11
  br i1 %t120, label %then16, label %else17
then16:
  %t133 = load double, double* %l11
  %t134 = sitofp i64 128 to double
  %t135 = fcmp olt double %t133, %t134
  %t136 = load i8, i8* %l0
  %t137 = load i8*, i8** %l1
  %t138 = load double, double* %l2
  %t139 = load i8*, i8** %l3
  %t140 = load double, double* %l4
  %t141 = load i8*, i8** %l5
  %t142 = load double, double* %l6
  %t143 = load double, double* %l7
  %t144 = load double, double* %l8
  %t145 = load i64, i64* %l9
  %t146 = load i64, i64* %l10
  %t147 = load double, double* %l11
  br i1 %t135, label %then19, label %merge20
then19:
  %t148 = load double, double* %l11
  ret double %t148
merge20:
  %t149 = load double, double* %l11
  br label %merge18
else17:
  %t150 = load double, double* %l11
  %t151 = load i64, i64* %l10
  %t152 = mul i64 %t151, 64
  %t153 = load double, double* %l11
  %t154 = sitofp i64 128 to double
  %t155 = fsub double %t153, %t154
  %t156 = sitofp i64 %t152 to double
  %t157 = fadd double %t156, %t155
  %t158 = fptosi double %t157 to i64
  store i64 %t158, i64* %l10
  br label %merge18
merge18:
  %t159 = phi i64 [ %t131, %then16 ], [ %t158, %else17 ]
  store i64 %t159, i64* %l10
  %t160 = load i64, i64* %l9
  %t161 = add i64 %t160, 1
  store i64 %t161, i64* %l9
  br label %loop.latch12
loop.latch12:
  %t162 = load i64, i64* %l10
  %t163 = load i64, i64* %l9
  br label %loop.header10
afterloop13:
  %t166 = load i64, i64* %l10
  %t167 = sitofp i64 %t166 to double
  ret double %t167
}

define i1 @is_regional_indicator(double %codepoint) {
entry:
  ret i1 false
}

define i1 @is_variation_selector(double %codepoint) {
entry:
  ret i1 false
}

define i1 @is_emoji_modifier(double %codepoint) {
entry:
  ret i1 false
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
  %t22 = phi i64 [ %t0, %entry ], [ %t21, %loop.latch2 ]
  store i64 %t22, i64* %l0
  br label %loop.body1
loop.body1:
  %t1 = load i64, i64* %l0
  %t2 = load i64, i64* %l0
  %t3 = load { double*, i64 }, { double*, i64 }* %ranges
  %t4 = extractvalue { double*, i64 } %t3, 0
  %t5 = extractvalue { double*, i64 } %t3, 1
  %t6 = icmp uge i64 %t2, %t5
  ; bounds check: %t6 (if true, out of bounds)
  %t7 = getelementptr double, double* %t4, i64 %t2
  %t8 = load double, double* %t7
  store double %t8, double* %l1
  store double 0.0, double* %l2
  %t9 = load double, double* %l1
  %t10 = fcmp olt double %codepoint, %t9
  %t11 = load i64, i64* %l0
  %t12 = load double, double* %l1
  %t13 = load double, double* %l2
  br i1 %t10, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t14 = load double, double* %l2
  %t15 = fcmp ole double %codepoint, %t14
  %t16 = load i64, i64* %l0
  %t17 = load double, double* %l1
  %t18 = load double, double* %l2
  br i1 %t15, label %then6, label %merge7
then6:
  ret i1 1
merge7:
  %t19 = load i64, i64* %l0
  %t20 = add i64 %t19, 2
  store i64 %t20, i64* %l0
  br label %loop.latch2
loop.latch2:
  %t21 = load i64, i64* %l0
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
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
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
  %t144 = phi { i8**, i64 }* [ %t20, %entry ], [ %t137, %loop.latch4 ]
  %t145 = phi i8 [ %t21, %entry ], [ %t138, %loop.latch4 ]
  %t146 = phi i64 [ %t25, %entry ], [ %t139, %loop.latch4 ]
  %t147 = phi double [ %t22, %entry ], [ %t140, %loop.latch4 ]
  %t148 = phi double [ %t23, %entry ], [ %t141, %loop.latch4 ]
  %t149 = phi i1 [ %t24, %entry ], [ %t142, %loop.latch4 ]
  %t150 = phi i64 [ %t26, %entry ], [ %t143, %loop.latch4 ]
  store { i8**, i64 }* %t144, { i8**, i64 }** %l0
  store i8 %t145, i8* %l1
  store i64 %t146, i64* %l5
  store double %t147, double* %l2
  store double %t148, double* %l3
  store i1 %t149, i1* %l4
  store i64 %t150, i64* %l6
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
  %t38 = load double, double* %l2
  %t39 = load i1, i1* %l12
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t41 = load i8, i8* %l1
  %t42 = load double, double* %l2
  %t43 = load double, double* %l3
  %t44 = load i1, i1* %l4
  %t45 = load i64, i64* %l5
  %t46 = load i64, i64* %l6
  %t47 = load i8, i8* %l7
  %t48 = load double, double* %l8
  %t49 = load double, double* %l9
  %t50 = load i1, i1* %l10
  %t51 = load i1, i1* %l11
  %t52 = load i1, i1* %l12
  br i1 %t39, label %then6, label %else7
then6:
  %t53 = load i8, i8* %l1
  %t54 = alloca [1 x i8]
  %t55 = getelementptr [1 x i8], [1 x i8]* %t54, i32 0, i32 0
  %t56 = getelementptr i8, i8* %t55, i64 0
  store i8 %t53, i8* %t56
  %t57 = alloca { i8*, i64 }
  %t58 = getelementptr { i8*, i64 }, { i8*, i64 }* %t57, i32 0, i32 0
  store i8* %t55, i8** %t58
  %t59 = getelementptr { i8*, i64 }, { i8*, i64 }* %t57, i32 0, i32 1
  store i64 1, i64* %t59
  %t60 = call double @clustersconcat({ i8*, i64 }* %t57)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t61 = load i8, i8* %l7
  store i8 %t61, i8* %l1
  %t62 = load i1, i1* %l11
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t64 = load i8, i8* %l1
  %t65 = load double, double* %l2
  %t66 = load double, double* %l3
  %t67 = load i1, i1* %l4
  %t68 = load i64, i64* %l5
  %t69 = load i64, i64* %l6
  %t70 = load i8, i8* %l7
  %t71 = load double, double* %l8
  %t72 = load double, double* %l9
  %t73 = load i1, i1* %l10
  %t74 = load i1, i1* %l11
  %t75 = load i1, i1* %l12
  br i1 %t62, label %then9, label %else10
then9:
  store i64 1, i64* %l5
  br label %merge11
else10:
  store i64 0, i64* %l5
  br label %merge11
merge11:
  %t76 = phi i64 [ 1, %then9 ], [ 0, %else10 ]
  store i64 %t76, i64* %l5
  br label %merge8
else7:
  %t77 = load i8, i8* %l1
  %t78 = load i8, i8* %l7
  %t79 = add i8 %t77, %t78
  store i8 %t79, i8* %l1
  %t80 = load i1, i1* %l11
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t82 = load i8, i8* %l1
  %t83 = load double, double* %l2
  %t84 = load double, double* %l3
  %t85 = load i1, i1* %l4
  %t86 = load i64, i64* %l5
  %t87 = load i64, i64* %l6
  %t88 = load i8, i8* %l7
  %t89 = load double, double* %l8
  %t90 = load double, double* %l9
  %t91 = load i1, i1* %l10
  %t92 = load i1, i1* %l11
  %t93 = load i1, i1* %l12
  br i1 %t80, label %then12, label %else13
then12:
  %t94 = load i64, i64* %l5
  %t95 = add i64 %t94, 1
  store i64 %t95, i64* %l5
  br label %merge14
else13:
  br label %merge14
merge14:
  %t96 = phi i64 [ %t95, %then12 ], [ %t86, %else13 ]
  store i64 %t96, i64* %l5
  br label %merge8
merge8:
  %t97 = phi { i8**, i64 }* [ null, %then6 ], [ %t40, %else7 ]
  %t98 = phi i8 [ %t61, %then6 ], [ %t79, %else7 ]
  %t99 = phi i64 [ 1, %then6 ], [ %t95, %else7 ]
  store { i8**, i64 }* %t97, { i8**, i64 }** %l0
  store i8 %t98, i8* %l1
  store i64 %t99, i64* %l5
  %t100 = load double, double* %l8
  store double %t100, double* %l2
  %t101 = load double, double* %l9
  store double %t101, double* %l3
  %t102 = load double, double* %l9
  %t103 = fcmp one double %t102, 0.0
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t105 = load i8, i8* %l1
  %t106 = load double, double* %l2
  %t107 = load double, double* %l3
  %t108 = load i1, i1* %l4
  %t109 = load i64, i64* %l5
  %t110 = load i64, i64* %l6
  %t111 = load i8, i8* %l7
  %t112 = load double, double* %l8
  %t113 = load double, double* %l9
  %t114 = load i1, i1* %l10
  %t115 = load i1, i1* %l11
  %t116 = load i1, i1* %l12
  br i1 %t103, label %then15, label %else16
then15:
  store i1 0, i1* %l4
  store i64 0, i64* %l5
  br label %merge17
else16:
  %t117 = load i1, i1* %l10
  %t118 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t119 = load i8, i8* %l1
  %t120 = load double, double* %l2
  %t121 = load double, double* %l3
  %t122 = load i1, i1* %l4
  %t123 = load i64, i64* %l5
  %t124 = load i64, i64* %l6
  %t125 = load i8, i8* %l7
  %t126 = load double, double* %l8
  %t127 = load double, double* %l9
  %t128 = load i1, i1* %l10
  %t129 = load i1, i1* %l11
  %t130 = load i1, i1* %l12
  br i1 %t117, label %then18, label %else19
then18:
  br label %merge20
else19:
  %t131 = load i1, i1* %l11
  store i1 %t131, i1* %l4
  br label %merge20
merge20:
  %t132 = phi i1 [ %t122, %then18 ], [ %t131, %else19 ]
  store i1 %t132, i1* %l4
  br label %merge17
merge17:
  %t133 = phi i1 [ 0, %then15 ], [ %t131, %else16 ]
  %t134 = phi i64 [ 0, %then15 ], [ %t109, %else16 ]
  store i1 %t133, i1* %l4
  store i64 %t134, i64* %l5
  %t135 = load i64, i64* %l6
  %t136 = add i64 %t135, 1
  store i64 %t136, i64* %l6
  br label %loop.latch4
loop.latch4:
  %t137 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t138 = load i8, i8* %l1
  %t139 = load i64, i64* %l5
  %t140 = load double, double* %l2
  %t141 = load double, double* %l3
  %t142 = load i1, i1* %l4
  %t143 = load i64, i64* %l6
  br label %loop.header2
afterloop5:
  %t151 = load i8, i8* %l1
  %t152 = alloca [1 x i8]
  %t153 = getelementptr [1 x i8], [1 x i8]* %t152, i32 0, i32 0
  %t154 = getelementptr i8, i8* %t153, i64 0
  store i8 %t151, i8* %t154
  %t155 = alloca { i8*, i64 }
  %t156 = getelementptr { i8*, i64 }, { i8*, i64 }* %t155, i32 0, i32 0
  store i8* %t153, i8** %t156
  %t157 = getelementptr { i8*, i64 }, { i8*, i64 }* %t155, i32 0, i32 1
  store i64 1, i64* %t157
  %t158 = call double @clustersconcat({ i8*, i64 }* %t155)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t159 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t159
}

define double @grapheme_count(i8* %text) {
entry:
  %l0 = alloca { i8**, i64 }*
  %t0 = call { i8**, i64 }* @iter_grapheme_clusters(i8* %text)
  store { i8**, i64 }* %t0, { i8**, i64 }** %l0
  %t1 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret double 0.0
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
  %t5 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t6 = load { i8**, i64 }, { i8**, i64 }* %t5
  %t7 = extractvalue { i8**, i64 } %t6, 0
  %t8 = extractvalue { i8**, i64 } %t6, 1
  %t9 = icmp uge i64 %index, %t8
  ; bounds check: %t9 (if true, out of bounds)
  %t10 = getelementptr i8*, i8** %t7, i64 %index
  %t11 = load i8*, i8** %t10
  ret i8* %t11
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
