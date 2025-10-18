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
  %l5 = alloca i8*
  %t0 = icmp eq i8* %definition, null
  br i1 %t0, label %then0, label %merge1
then0:
  ret { %EnumField*, i64 }* %provided
merge1:
  store double 0.0, double* %l0
  %t1 = load double, double* %l0
  %t2 = alloca [0 x double]
  %t3 = getelementptr [0 x double], [0 x double]* %t2, i32 0, i32 0
  %t4 = alloca { double*, i64 }
  %t5 = getelementptr { double*, i64 }, { double*, i64 }* %t4, i32 0, i32 0
  store double* %t3, double** %t5
  %t6 = getelementptr { double*, i64 }, { double*, i64 }* %t4, i32 0, i32 1
  store i64 0, i64* %t6
  store { %EnumField*, i64 }* null, { %EnumField*, i64 }** %l1
  store i64 0, i64* %l2
  %t7 = load double, double* %l0
  %t8 = load { %EnumField*, i64 }*, { %EnumField*, i64 }** %l1
  %t9 = load i64, i64* %l2
  br label %loop.header2
loop.header2:
  %t32 = phi { %EnumField*, i64 }* [ %t8, %entry ], [ %t30, %loop.latch4 ]
  %t33 = phi i64 [ %t9, %entry ], [ %t31, %loop.latch4 ]
  store { %EnumField*, i64 }* %t32, { %EnumField*, i64 }** %l1
  store i64 %t33, i64* %l2
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
  %t17 = load double, double* %l3
  %t18 = insertvalue %EnumField undef, i8* null, 0
  %t19 = load i8*, i8** %l5
  %t20 = insertvalue %EnumField %t18, i8* %t19, 1
  %t21 = alloca [1 x %EnumField]
  %t22 = getelementptr [1 x %EnumField], [1 x %EnumField]* %t21, i32 0, i32 0
  %t23 = getelementptr %EnumField, %EnumField* %t22, i64 0
  store %EnumField %t20, %EnumField* %t23
  %t24 = alloca { %EnumField*, i64 }
  %t25 = getelementptr { %EnumField*, i64 }, { %EnumField*, i64 }* %t24, i32 0, i32 0
  store %EnumField* %t22, %EnumField** %t25
  %t26 = getelementptr { %EnumField*, i64 }, { %EnumField*, i64 }* %t24, i32 0, i32 1
  store i64 1, i64* %t26
  %t27 = call double @normalizedconcat({ %EnumField*, i64 }* %t24)
  store { %EnumField*, i64 }* null, { %EnumField*, i64 }** %l1
  %t28 = load i64, i64* %l2
  %t29 = add i64 %t28, 1
  store i64 %t29, i64* %l2
  br label %loop.latch4
loop.latch4:
  %t30 = load { %EnumField*, i64 }*, { %EnumField*, i64 }** %l1
  %t31 = load i64, i64* %l2
  br label %loop.header2
afterloop5:
  %t34 = load { %EnumField*, i64 }*, { %EnumField*, i64 }** %l1
  ret { %EnumField*, i64 }* %t34
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
  %t6 = call %TypeDescriptor @type_descriptor(i8* %s0, i8* null, { %TypeDescriptor*, i64 }* null)
  ret %TypeDescriptor %t6
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
  %t6 = call %TypeDescriptor @type_descriptor(i8* %s0, i8* null, { %TypeDescriptor*, i64 }* null)
  ret %TypeDescriptor %t6
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
  %t14 = load i8, i8* %l2
  %s15 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.15, i32 0, i32 0
  br label %afterloop3
loop.latch2:
  br label %loop.header0
afterloop3:
  %t16 = load i64, i64* %l0
  %t17 = load double, double* %l1
  br label %loop.header6
loop.header6:
  br label %loop.body7
loop.body7:
  %t18 = load double, double* %l1
  %t19 = load i64, i64* %l0
  %t20 = sitofp i64 %t19 to double
  %t21 = fcmp ole double %t18, %t20
  %t22 = load i64, i64* %l0
  %t23 = load double, double* %l1
  br i1 %t21, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  store double 0.0, double* %l3
  %t27 = load double, double* %l3
  %s28 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.28, i32 0, i32 0
  br label %afterloop9
loop.latch8:
  br label %loop.header6
afterloop9:
  %t29 = load i64, i64* %l0
  %t30 = load double, double* %l1
  %t31 = sitofp i64 %t29 to double
  %t32 = call i8* @substring(i8* %value, double %t31, double %t30)
  ret i8* %t32
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
  %t44 = phi i64 [ %t5, %entry ], [ %t43, %loop.latch2 ]
  store i64 %t44, i64* %l2
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
  %t20 = load i8, i8* %l6
  %t21 = load i8, i8* %l1
  %t22 = icmp eq i8 %t20, %t21
  br label %logical_and_entry_19

logical_and_entry_19:
  br i1 %t22, label %logical_and_right_19, label %logical_and_merge_19

logical_and_right_19:
  %t23 = load i64, i64* %l3
  %t24 = icmp eq i64 %t23, 0
  br label %logical_and_right_end_19

logical_and_right_end_19:
  br label %logical_and_merge_19

logical_and_merge_19:
  %t25 = phi i1 [ false, %logical_and_entry_19 ], [ %t24, %logical_and_right_end_19 ]
  br label %logical_and_entry_18

logical_and_entry_18:
  br i1 %t25, label %logical_and_right_18, label %logical_and_merge_18

logical_and_right_18:
  %t26 = load i64, i64* %l4
  %t27 = icmp eq i64 %t26, 0
  br label %logical_and_right_end_18

logical_and_right_end_18:
  br label %logical_and_merge_18

logical_and_merge_18:
  %t28 = phi i1 [ false, %logical_and_entry_18 ], [ %t27, %logical_and_right_end_18 ]
  br label %logical_and_entry_17

logical_and_entry_17:
  br i1 %t28, label %logical_and_right_17, label %logical_and_merge_17

logical_and_right_17:
  %t29 = load i64, i64* %l5
  %t30 = icmp eq i64 %t29, 0
  br label %logical_and_right_end_17

logical_and_right_end_17:
  br label %logical_and_merge_17

logical_and_merge_17:
  %t31 = phi i1 [ false, %logical_and_entry_17 ], [ %t30, %logical_and_right_end_17 ]
  %t32 = load i8*, i8** %l0
  %t33 = load i8, i8* %l1
  %t34 = load i64, i64* %l2
  %t35 = load i64, i64* %l3
  %t36 = load i64, i64* %l4
  %t37 = load i64, i64* %l5
  %t38 = load i8, i8* %l6
  br i1 %t31, label %then4, label %merge5
then4:
  %t39 = load i64, i64* %l2
  %t40 = sitofp i64 %t39 to double
  ret double %t40
merge5:
  %t41 = load i64, i64* %l2
  %t42 = add i64 %t41, 1
  store i64 %t42, i64* %l2
  br label %loop.latch2
loop.latch2:
  %t43 = load i64, i64* %l2
  br label %loop.header0
afterloop3:
  %t45 = sitofp i64 -1 to double
  ret double %t45
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
  %t37 = phi i8* [ %t1, %entry ], [ %t36, %loop.latch2 ]
  store i8* %t37, i8** %l0
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
  %t24 = load i1, i1* %l3
  br label %logical_or_entry_23

logical_or_entry_23:
  br i1 %t24, label %logical_or_merge_23, label %logical_or_right_23

logical_or_right_23:
  %t25 = load i64, i64* %l1
  %t26 = icmp ne i64 %t25, 0
  br label %logical_or_right_end_23

logical_or_right_end_23:
  br label %logical_or_merge_23

logical_or_merge_23:
  %t27 = phi i1 [ true, %logical_or_entry_23 ], [ %t26, %logical_or_right_end_23 ]
  %t28 = xor i1 %t27, 1
  %t29 = load i8*, i8** %l0
  %t30 = load i64, i64* %l1
  %t31 = load i64, i64* %l2
  %t32 = load i1, i1* %l3
  br i1 %t28, label %then8, label %merge9
then8:
  %t33 = load i8*, i8** %l0
  ret i8* %t33
merge9:
  %t34 = load i8*, i8** %l0
  %t35 = load i8*, i8** %l0
  br label %loop.latch2
loop.latch2:
  %t36 = load i8*, i8** %l0
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
  %t72 = phi { i8**, i64 }* [ %t9, %entry ], [ %t69, %loop.latch2 ]
  %t73 = phi i64 [ %t10, %entry ], [ %t70, %loop.latch2 ]
  %t74 = phi i64 [ %t11, %entry ], [ %t71, %loop.latch2 ]
  store { i8**, i64 }* %t72, { i8**, i64 }** %l1
  store i64 %t73, i64* %l2
  store i64 %t74, i64* %l3
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
  %t27 = load i8, i8* %l8
  %t28 = load i8, i8* %l7
  %t29 = icmp eq i8 %t27, %t28
  br label %logical_and_entry_26

logical_and_entry_26:
  br i1 %t29, label %logical_and_right_26, label %logical_and_merge_26

logical_and_right_26:
  %t30 = load i64, i64* %l4
  %t31 = icmp eq i64 %t30, 0
  br label %logical_and_right_end_26

logical_and_right_end_26:
  br label %logical_and_merge_26

logical_and_merge_26:
  %t32 = phi i1 [ false, %logical_and_entry_26 ], [ %t31, %logical_and_right_end_26 ]
  br label %logical_and_entry_25

logical_and_entry_25:
  br i1 %t32, label %logical_and_right_25, label %logical_and_merge_25

logical_and_right_25:
  %t33 = load i64, i64* %l5
  %t34 = icmp eq i64 %t33, 0
  br label %logical_and_right_end_25

logical_and_right_end_25:
  br label %logical_and_merge_25

logical_and_merge_25:
  %t35 = phi i1 [ false, %logical_and_entry_25 ], [ %t34, %logical_and_right_end_25 ]
  br label %logical_and_entry_24

logical_and_entry_24:
  br i1 %t35, label %logical_and_right_24, label %logical_and_merge_24

logical_and_right_24:
  %t36 = load i64, i64* %l6
  %t37 = icmp eq i64 %t36, 0
  br label %logical_and_right_end_24

logical_and_right_end_24:
  br label %logical_and_merge_24

logical_and_merge_24:
  %t38 = phi i1 [ false, %logical_and_entry_24 ], [ %t37, %logical_and_right_end_24 ]
  %t39 = load i8*, i8** %l0
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t41 = load i64, i64* %l2
  %t42 = load i64, i64* %l3
  %t43 = load i64, i64* %l4
  %t44 = load i64, i64* %l5
  %t45 = load i64, i64* %l6
  %t46 = load i8, i8* %l7
  %t47 = load i8, i8* %l8
  br i1 %t38, label %then4, label %merge5
then4:
  %t48 = load i8*, i8** %l0
  %t49 = load i64, i64* %l2
  %t50 = load i64, i64* %l3
  %t51 = sitofp i64 %t49 to double
  %t52 = sitofp i64 %t50 to double
  %t53 = call i8* @substring(i8* %t48, double %t51, double %t52)
  store i8* %t53, i8** %l9
  %t54 = load i8*, i8** %l9
  %t55 = call i8* @descriptor_trim(i8* %t54)
  %t56 = alloca [1 x i8*]
  %t57 = getelementptr [1 x i8*], [1 x i8*]* %t56, i32 0, i32 0
  %t58 = getelementptr i8*, i8** %t57, i64 0
  store i8* %t55, i8** %t58
  %t59 = alloca { i8**, i64 }
  %t60 = getelementptr { i8**, i64 }, { i8**, i64 }* %t59, i32 0, i32 0
  store i8** %t57, i8*** %t60
  %t61 = getelementptr { i8**, i64 }, { i8**, i64 }* %t59, i32 0, i32 1
  store i64 1, i64* %t61
  %t62 = call double @partsconcat({ i8**, i64 }* %t59)
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t63 = load i64, i64* %l3
  %t64 = add i64 %t63, 1
  store i64 %t64, i64* %l2
  br label %merge5
merge5:
  %t65 = phi { i8**, i64 }* [ null, %then4 ], [ %t40, %loop.body1 ]
  %t66 = phi i64 [ %t64, %then4 ], [ %t41, %loop.body1 ]
  store { i8**, i64 }* %t65, { i8**, i64 }** %l1
  store i64 %t66, i64* %l2
  %t67 = load i64, i64* %l3
  %t68 = add i64 %t67, 1
  store i64 %t68, i64* %l3
  br label %loop.latch2
loop.latch2:
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t70 = load i64, i64* %l2
  %t71 = load i64, i64* %l3
  br label %loop.header0
afterloop3:
  %t75 = load i8*, i8** %l0
  %t76 = load i64, i64* %l2
  %t77 = load i8*, i8** %l0
  store double 0.0, double* %l10
  %t78 = load double, double* %l10
  %t79 = call i8* @descriptor_trim(i8* null)
  store i8* %t79, i8** %l11
  %t81 = load i8*, i8** %l11
  %t82 = load { i8**, i64 }*, { i8**, i64 }** %l1
  ret { i8**, i64 }* %t82
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
  %t58 = load i8*, i8** %l5
  %s59 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.59, i32 0, i32 0
  %t60 = icmp eq i8* %t58, %s59
  br label %logical_or_entry_57

logical_or_entry_57:
  br i1 %t60, label %logical_or_merge_57, label %logical_or_right_57

logical_or_right_57:
  %t61 = load i8*, i8** %l5
  %s62 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.62, i32 0, i32 0
  %t63 = icmp eq i8* %t61, %s62
  br label %logical_or_right_end_57

logical_or_right_end_57:
  br label %logical_or_merge_57

logical_or_merge_57:
  %t64 = phi i1 [ true, %logical_or_entry_57 ], [ %t63, %logical_or_right_end_57 ]
  br label %logical_or_entry_56

logical_or_entry_56:
  br i1 %t64, label %logical_or_merge_56, label %logical_or_right_56

logical_or_right_56:
  %t65 = load i8*, i8** %l5
  %s66 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.66, i32 0, i32 0
  %t67 = icmp eq i8* %t65, %s66
  br label %logical_or_right_end_56

logical_or_right_end_56:
  br label %logical_or_merge_56

logical_or_merge_56:
  %t68 = phi i1 [ true, %logical_or_entry_56 ], [ %t67, %logical_or_right_end_56 ]
  br label %logical_or_entry_55

logical_or_entry_55:
  br i1 %t68, label %logical_or_merge_55, label %logical_or_right_55

logical_or_right_55:
  %t69 = load i8*, i8** %l5
  %s70 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.70, i32 0, i32 0
  %t71 = icmp eq i8* %t69, %s70
  br label %logical_or_right_end_55

logical_or_right_end_55:
  br label %logical_or_merge_55

logical_or_merge_55:
  %t72 = phi i1 [ true, %logical_or_entry_55 ], [ %t71, %logical_or_right_end_55 ]
  %t73 = load i8*, i8** %l0
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t76 = load double, double* %l4
  %t77 = load i8*, i8** %l5
  br i1 %t72, label %then8, label %merge9
then8:
  %t78 = load i8*, i8** %l5
  %t79 = call %TypeDescriptor @type_descriptor_primitive(i8* %t78)
  ret %TypeDescriptor %t79
merge9:
  %t80 = load i8*, i8** %l5
  %t81 = call %TypeDescriptor @type_descriptor_named(i8* %t80)
  ret %TypeDescriptor %t81
}

define i1 @check_type_primitive(double %value, i8* %name) {
entry:
  %s0 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.0, i32 0, i32 0
  %t1 = icmp eq i8* %name, %s0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = call double @runtimeis_string(double %value)
  %t3 = fcmp one double %t2, 0.0
  ret i1 %t3
merge1:
  %s4 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.4, i32 0, i32 0
  %t5 = icmp eq i8* %name, %s4
  br i1 %t5, label %then2, label %merge3
then2:
  %t6 = call double @runtimeis_number(double %value)
  %t7 = fcmp one double %t6, 0.0
  ret i1 %t7
merge3:
  %s8 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.8, i32 0, i32 0
  %t9 = icmp eq i8* %name, %s8
  br i1 %t9, label %then4, label %merge5
then4:
  %t10 = call double @runtimeis_boolean(double %value)
  %t11 = fcmp one double %t10, 0.0
  ret i1 %t11
merge5:
  %s12 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.12, i32 0, i32 0
  %t13 = icmp eq i8* %name, %s12
  br i1 %t13, label %then6, label %merge7
then6:
  %t14 = call double @runtimeis_void(double %value)
  %t15 = fcmp one double %t14, 0.0
  ret i1 %t15
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
  %t26 = phi i64 [ %t10, %then4 ], [ %t25, %loop.latch8 ]
  store i64 %t26, i64* %l0
  br label %loop.body7
loop.body7:
  %t11 = load i64, i64* %l0
  %t12 = extractvalue %TypeDescriptor %descriptor, 2
  %t13 = extractvalue %TypeDescriptor %descriptor, 2
  %t14 = load i64, i64* %l0
  %t15 = load { i8**, i64 }, { i8**, i64 }* %t13
  %t16 = extractvalue { i8**, i64 } %t15, 0
  %t17 = extractvalue { i8**, i64 } %t15, 1
  %t18 = icmp uge i64 %t14, %t17
  ; bounds check: %t18 (if true, out of bounds)
  %t19 = getelementptr i8*, i8** %t16, i64 %t14
  %t20 = load i8*, i8** %t19
  %t21 = call i1 @check_type_descriptor(double %value, %TypeDescriptor zeroinitializer)
  %t22 = load i64, i64* %l0
  br i1 %t21, label %then10, label %merge11
then10:
  ret i1 1
merge11:
  %t23 = load i64, i64* %l0
  %t24 = add i64 %t23, 1
  store i64 %t24, i64* %l0
  br label %loop.latch8
loop.latch8:
  %t25 = load i64, i64* %l0
  br label %loop.header6
afterloop9:
  ret i1 0
merge5:
  %t27 = extractvalue %TypeDescriptor %descriptor, 0
  %s28 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.28, i32 0, i32 0
  %t29 = icmp eq i8* %t27, %s28
  br i1 %t29, label %then12, label %merge13
then12:
  store i64 0, i64* %l1
  %t30 = load i64, i64* %l1
  br label %loop.header14
loop.header14:
  %t47 = phi i64 [ %t30, %then12 ], [ %t46, %loop.latch16 ]
  store i64 %t47, i64* %l1
  br label %loop.body15
loop.body15:
  %t31 = load i64, i64* %l1
  %t32 = extractvalue %TypeDescriptor %descriptor, 2
  %t33 = extractvalue %TypeDescriptor %descriptor, 2
  %t34 = load i64, i64* %l1
  %t35 = load { i8**, i64 }, { i8**, i64 }* %t33
  %t36 = extractvalue { i8**, i64 } %t35, 0
  %t37 = extractvalue { i8**, i64 } %t35, 1
  %t38 = icmp uge i64 %t34, %t37
  ; bounds check: %t38 (if true, out of bounds)
  %t39 = getelementptr i8*, i8** %t36, i64 %t34
  %t40 = load i8*, i8** %t39
  %t41 = call i1 @check_type_descriptor(double %value, %TypeDescriptor zeroinitializer)
  %t42 = xor i1 %t41, 1
  %t43 = load i64, i64* %l1
  br i1 %t42, label %then18, label %merge19
then18:
  ret i1 0
merge19:
  %t44 = load i64, i64* %l1
  %t45 = add i64 %t44, 1
  store i64 %t45, i64* %l1
  br label %loop.latch16
loop.latch16:
  %t46 = load i64, i64* %l1
  br label %loop.header14
afterloop17:
  %t48 = extractvalue %TypeDescriptor %descriptor, 2
  ret i1 false
merge13:
  %t49 = extractvalue %TypeDescriptor %descriptor, 0
  %s50 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.50, i32 0, i32 0
  %t51 = icmp eq i8* %t49, %s50
  br i1 %t51, label %then20, label %merge21
then20:
  %t52 = extractvalue %TypeDescriptor %descriptor, 2
  %t53 = call double @runtimeis_array(double %value)
  %t54 = fcmp one double %t53, 0.0
  %t55 = xor i1 %t54, 1
  br i1 %t55, label %then22, label %merge23
then22:
  ret i1 0
merge23:
  %t56 = extractvalue %TypeDescriptor %descriptor, 2
  %t57 = load { i8**, i64 }, { i8**, i64 }* %t56
  %t58 = extractvalue { i8**, i64 } %t57, 0
  %t59 = extractvalue { i8**, i64 } %t57, 1
  %t60 = icmp uge i64 0, %t59
  ; bounds check: %t60 (if true, out of bounds)
  %t61 = getelementptr i8*, i8** %t58, i64 0
  %t62 = load i8*, i8** %t61
  store i8* %t62, i8** %l2
  store i64 0, i64* %l3
  %t63 = load i8*, i8** %l2
  %t64 = load i64, i64* %l3
  br label %loop.header24
loop.header24:
  %t71 = phi i64 [ %t64, %then20 ], [ %t70, %loop.latch26 ]
  store i64 %t71, i64* %l3
  br label %loop.body25
loop.body25:
  %t65 = load i64, i64* %l3
  %t66 = load i64, i64* %l3
  %t67 = load i8*, i8** %l2
  %t68 = load i64, i64* %l3
  %t69 = add i64 %t68, 1
  store i64 %t69, i64* %l3
  br label %loop.latch26
loop.latch26:
  %t70 = load i64, i64* %l3
  br label %loop.header24
afterloop27:
  ret i1 1
merge21:
  %t72 = extractvalue %TypeDescriptor %descriptor, 0
  %s73 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.73, i32 0, i32 0
  %t74 = icmp eq i8* %t72, %s73
  br i1 %t74, label %then28, label %merge29
then28:
  %t75 = call double @runtimeis_callable(double %value)
  %t76 = fcmp one double %t75, 0.0
  ret i1 %t76
merge29:
  %t77 = extractvalue %TypeDescriptor %descriptor, 0
  %s78 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.78, i32 0, i32 0
  %t79 = icmp eq i8* %t77, %s78
  br i1 %t79, label %then30, label %merge31
then30:
  %t80 = extractvalue %TypeDescriptor %descriptor, 1
  %t81 = icmp eq i8* %t80, null
  br i1 %t81, label %then32, label %merge33
then32:
  ret i1 0
merge33:
  %t82 = extractvalue %TypeDescriptor %descriptor, 1
  %t83 = call double @runtimeresolve_runtime_type(i8* %t82)
  store double %t83, double* %l4
  %t84 = load double, double* %l4
  %t85 = call double @runtimeinstance_of(double %value, double %t84)
  %t86 = fcmp one double %t85, 0.0
  ret i1 %t86
merge31:
  %t87 = extractvalue %TypeDescriptor %descriptor, 0
  %s88 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.88, i32 0, i32 0
  %t89 = icmp eq i8* %t87, %s88
  br i1 %t89, label %then34, label %merge35
then34:
  ret i1 0
merge35:
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
  %t19 = load i8*, i8** %l2
  %t20 = load double, double* %l1
  store double %t20, double* %l3
  %t21 = load double, double* %l0
  %t22 = load double, double* %l1
  %t23 = load i8*, i8** %l2
  %t24 = load double, double* %l3
  br label %loop.header6
loop.header6:
  %t40 = phi double [ %t24, %entry ], [ %t39, %loop.latch8 ]
  store double %t40, double* %l3
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
  %t36 = load double, double* %l3
  %t37 = sitofp i64 1 to double
  %t38 = fadd double %t36, %t37
  store double %t38, double* %l3
  br label %loop.latch8
loop.latch8:
  %t39 = load double, double* %l3
  br label %loop.header6
afterloop9:
  %t41 = sitofp i64 -1 to double
  ret double %t41
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
  %t258 = phi i64 [ %t101, %entry ], [ %t256, %loop.latch12 ]
  %t259 = phi i64 [ %t100, %entry ], [ %t257, %loop.latch12 ]
  store i64 %t258, i64* %l10
  store i64 %t259, i64* %l9
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
  %t150 = load double, double* %l11
  %t151 = sitofp i64 192 to double
  %t152 = fcmp oge double %t150, %t151
  br label %logical_and_entry_149

logical_and_entry_149:
  br i1 %t152, label %logical_and_right_149, label %logical_and_merge_149

logical_and_right_149:
  %t153 = load double, double* %l11
  %t154 = sitofp i64 223 to double
  %t155 = fcmp ole double %t153, %t154
  br label %logical_and_right_end_149

logical_and_right_end_149:
  br label %logical_and_merge_149

logical_and_merge_149:
  %t156 = phi i1 [ false, %logical_and_entry_149 ], [ %t155, %logical_and_right_end_149 ]
  %t157 = load i8, i8* %l0
  %t158 = load i8*, i8** %l1
  %t159 = load double, double* %l2
  %t160 = load i8*, i8** %l3
  %t161 = load double, double* %l4
  %t162 = load i8*, i8** %l5
  %t163 = load double, double* %l6
  %t164 = load double, double* %l7
  %t165 = load double, double* %l8
  %t166 = load i64, i64* %l9
  %t167 = load i64, i64* %l10
  %t168 = load double, double* %l11
  br i1 %t156, label %then21, label %else22
then21:
  %t169 = load double, double* %l11
  %t170 = sitofp i64 192 to double
  %t171 = fsub double %t169, %t170
  %t172 = fptosi double %t171 to i64
  store i64 %t172, i64* %l10
  br label %merge23
else22:
  %t174 = load double, double* %l11
  %t175 = sitofp i64 224 to double
  %t176 = fcmp oge double %t174, %t175
  br label %logical_and_entry_173

logical_and_entry_173:
  br i1 %t176, label %logical_and_right_173, label %logical_and_merge_173

logical_and_right_173:
  %t177 = load double, double* %l11
  %t178 = sitofp i64 239 to double
  %t179 = fcmp ole double %t177, %t178
  br label %logical_and_right_end_173

logical_and_right_end_173:
  br label %logical_and_merge_173

logical_and_merge_173:
  %t180 = phi i1 [ false, %logical_and_entry_173 ], [ %t179, %logical_and_right_end_173 ]
  %t181 = load i8, i8* %l0
  %t182 = load i8*, i8** %l1
  %t183 = load double, double* %l2
  %t184 = load i8*, i8** %l3
  %t185 = load double, double* %l4
  %t186 = load i8*, i8** %l5
  %t187 = load double, double* %l6
  %t188 = load double, double* %l7
  %t189 = load double, double* %l8
  %t190 = load i64, i64* %l9
  %t191 = load i64, i64* %l10
  %t192 = load double, double* %l11
  br i1 %t180, label %then24, label %else25
then24:
  %t193 = load double, double* %l11
  %t194 = sitofp i64 224 to double
  %t195 = fsub double %t193, %t194
  %t196 = fptosi double %t195 to i64
  store i64 %t196, i64* %l10
  br label %merge26
else25:
  %t198 = load double, double* %l11
  %t199 = sitofp i64 240 to double
  %t200 = fcmp oge double %t198, %t199
  br label %logical_and_entry_197

logical_and_entry_197:
  br i1 %t200, label %logical_and_right_197, label %logical_and_merge_197

logical_and_right_197:
  %t201 = load double, double* %l11
  %t202 = sitofp i64 247 to double
  %t203 = fcmp ole double %t201, %t202
  br label %logical_and_right_end_197

logical_and_right_end_197:
  br label %logical_and_merge_197

logical_and_merge_197:
  %t204 = phi i1 [ false, %logical_and_entry_197 ], [ %t203, %logical_and_right_end_197 ]
  %t205 = load i8, i8* %l0
  %t206 = load i8*, i8** %l1
  %t207 = load double, double* %l2
  %t208 = load i8*, i8** %l3
  %t209 = load double, double* %l4
  %t210 = load i8*, i8** %l5
  %t211 = load double, double* %l6
  %t212 = load double, double* %l7
  %t213 = load double, double* %l8
  %t214 = load i64, i64* %l9
  %t215 = load i64, i64* %l10
  %t216 = load double, double* %l11
  br i1 %t204, label %then27, label %else28
then27:
  %t217 = load double, double* %l11
  %t218 = sitofp i64 240 to double
  %t219 = fsub double %t217, %t218
  %t220 = fptosi double %t219 to i64
  store i64 %t220, i64* %l10
  br label %merge29
else28:
  %t221 = sitofp i64 -1 to double
  ret double %t221
merge29:
  br label %merge26
merge26:
  %t222 = phi i64 [ %t196, %then24 ], [ %t220, %else25 ]
  store i64 %t222, i64* %l10
  br label %merge23
merge23:
  %t223 = phi i64 [ %t172, %then21 ], [ %t196, %else22 ]
  store i64 %t223, i64* %l10
  br label %merge18
else17:
  %t225 = load double, double* %l11
  %t226 = sitofp i64 128 to double
  %t227 = fcmp olt double %t225, %t226
  br label %logical_or_entry_224

logical_or_entry_224:
  br i1 %t227, label %logical_or_merge_224, label %logical_or_right_224

logical_or_right_224:
  %t228 = load double, double* %l11
  %t229 = sitofp i64 191 to double
  %t230 = fcmp ogt double %t228, %t229
  br label %logical_or_right_end_224

logical_or_right_end_224:
  br label %logical_or_merge_224

logical_or_merge_224:
  %t231 = phi i1 [ true, %logical_or_entry_224 ], [ %t230, %logical_or_right_end_224 ]
  %t232 = load i8, i8* %l0
  %t233 = load i8*, i8** %l1
  %t234 = load double, double* %l2
  %t235 = load i8*, i8** %l3
  %t236 = load double, double* %l4
  %t237 = load i8*, i8** %l5
  %t238 = load double, double* %l6
  %t239 = load double, double* %l7
  %t240 = load double, double* %l8
  %t241 = load i64, i64* %l9
  %t242 = load i64, i64* %l10
  %t243 = load double, double* %l11
  br i1 %t231, label %then30, label %merge31
then30:
  %t244 = sitofp i64 -1 to double
  ret double %t244
merge31:
  %t245 = load i64, i64* %l10
  %t246 = mul i64 %t245, 64
  %t247 = load double, double* %l11
  %t248 = sitofp i64 128 to double
  %t249 = fsub double %t247, %t248
  %t250 = sitofp i64 %t246 to double
  %t251 = fadd double %t250, %t249
  %t252 = fptosi double %t251 to i64
  store i64 %t252, i64* %l10
  br label %merge18
merge18:
  %t253 = phi i64 [ %t172, %then16 ], [ %t252, %else17 ]
  store i64 %t253, i64* %l10
  %t254 = load i64, i64* %l9
  %t255 = add i64 %t254, 1
  store i64 %t255, i64* %l9
  br label %loop.latch12
loop.latch12:
  %t256 = load i64, i64* %l10
  %t257 = load i64, i64* %l9
  br label %loop.header10
afterloop13:
  %t260 = load i64, i64* %l10
  %t261 = sitofp i64 %t260 to double
  ret double %t261
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
  %t255 = phi { i8**, i64 }* [ %t20, %entry ], [ %t248, %loop.latch4 ]
  %t256 = phi i8 [ %t21, %entry ], [ %t249, %loop.latch4 ]
  %t257 = phi i64 [ %t25, %entry ], [ %t250, %loop.latch4 ]
  %t258 = phi double [ %t22, %entry ], [ %t251, %loop.latch4 ]
  %t259 = phi double [ %t23, %entry ], [ %t252, %loop.latch4 ]
  %t260 = phi i1 [ %t24, %entry ], [ %t253, %loop.latch4 ]
  %t261 = phi i64 [ %t26, %entry ], [ %t254, %loop.latch4 ]
  store { i8**, i64 }* %t255, { i8**, i64 }** %l0
  store i8 %t256, i8* %l1
  store i64 %t257, i64* %l5
  store double %t258, double* %l2
  store double %t259, double* %l3
  store i1 %t260, i1* %l4
  store i64 %t261, i64* %l6
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
  br label %merge17
merge17:
  %t108 = phi i1 [ 0, %then15 ], [ %t102, %else16 ]
  store i1 %t108, i1* %l12
  br label %merge14
merge14:
  %t109 = phi i1 [ 0, %then12 ], [ 0, %else13 ]
  store i1 %t109, i1* %l12
  br label %merge11
merge11:
  %t110 = phi i1 [ 0, %then9 ], [ 0, %else10 ]
  store i1 %t110, i1* %l12
  br label %merge8
merge8:
  %t111 = phi i1 [ 0, %then6 ], [ 0, %else7 ]
  store i1 %t111, i1* %l12
  %t112 = load i1, i1* %l12
  %t113 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t114 = load i8, i8* %l1
  %t115 = load double, double* %l2
  %t116 = load double, double* %l3
  %t117 = load i1, i1* %l4
  %t118 = load i64, i64* %l5
  %t119 = load i64, i64* %l6
  %t120 = load i8, i8* %l7
  %t121 = load double, double* %l8
  %t122 = load double, double* %l9
  %t123 = load i1, i1* %l10
  %t124 = load i1, i1* %l11
  %t125 = load i1, i1* %l12
  br i1 %t112, label %then18, label %else19
then18:
  %t126 = load i8, i8* %l1
  %t127 = alloca [1 x i8]
  %t128 = getelementptr [1 x i8], [1 x i8]* %t127, i32 0, i32 0
  %t129 = getelementptr i8, i8* %t128, i64 0
  store i8 %t126, i8* %t129
  %t130 = alloca { i8*, i64 }
  %t131 = getelementptr { i8*, i64 }, { i8*, i64 }* %t130, i32 0, i32 0
  store i8* %t128, i8** %t131
  %t132 = getelementptr { i8*, i64 }, { i8*, i64 }* %t130, i32 0, i32 1
  store i64 1, i64* %t132
  %t133 = call double @clustersconcat({ i8*, i64 }* %t130)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t134 = load i8, i8* %l7
  store i8 %t134, i8* %l1
  %t135 = load i1, i1* %l11
  %t136 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t137 = load i8, i8* %l1
  %t138 = load double, double* %l2
  %t139 = load double, double* %l3
  %t140 = load i1, i1* %l4
  %t141 = load i64, i64* %l5
  %t142 = load i64, i64* %l6
  %t143 = load i8, i8* %l7
  %t144 = load double, double* %l8
  %t145 = load double, double* %l9
  %t146 = load i1, i1* %l10
  %t147 = load i1, i1* %l11
  %t148 = load i1, i1* %l12
  br i1 %t135, label %then21, label %else22
then21:
  store i64 1, i64* %l5
  br label %merge23
else22:
  store i64 0, i64* %l5
  br label %merge23
merge23:
  %t149 = phi i64 [ 1, %then21 ], [ 0, %else22 ]
  store i64 %t149, i64* %l5
  br label %merge20
else19:
  %t150 = load i8, i8* %l1
  %t151 = load i8, i8* %l7
  %t152 = add i8 %t150, %t151
  store i8 %t152, i8* %l1
  %t153 = load i1, i1* %l11
  %t154 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t155 = load i8, i8* %l1
  %t156 = load double, double* %l2
  %t157 = load double, double* %l3
  %t158 = load i1, i1* %l4
  %t159 = load i64, i64* %l5
  %t160 = load i64, i64* %l6
  %t161 = load i8, i8* %l7
  %t162 = load double, double* %l8
  %t163 = load double, double* %l9
  %t164 = load i1, i1* %l10
  %t165 = load i1, i1* %l11
  %t166 = load i1, i1* %l12
  br i1 %t153, label %then24, label %else25
then24:
  %t167 = load i64, i64* %l5
  %t168 = add i64 %t167, 1
  store i64 %t168, i64* %l5
  br label %merge26
else25:
  %t170 = load double, double* %l9
  %t171 = fcmp one double %t170, 0.0
  br label %logical_and_entry_169

logical_and_entry_169:
  br i1 %t171, label %logical_and_right_169, label %logical_and_merge_169

logical_and_right_169:
  %t172 = load i1, i1* %l10
  %t173 = xor i1 %t172, 1
  br label %logical_and_right_end_169

logical_and_right_end_169:
  br label %logical_and_merge_169

logical_and_merge_169:
  %t174 = phi i1 [ false, %logical_and_entry_169 ], [ %t173, %logical_and_right_end_169 ]
  %t175 = xor i1 %t174, 1
  %t176 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t177 = load i8, i8* %l1
  %t178 = load double, double* %l2
  %t179 = load double, double* %l3
  %t180 = load i1, i1* %l4
  %t181 = load i64, i64* %l5
  %t182 = load i64, i64* %l6
  %t183 = load i8, i8* %l7
  %t184 = load double, double* %l8
  %t185 = load double, double* %l9
  %t186 = load i1, i1* %l10
  %t187 = load i1, i1* %l11
  %t188 = load i1, i1* %l12
  br i1 %t175, label %then27, label %merge28
then27:
  store i64 0, i64* %l5
  br label %merge28
merge28:
  %t189 = phi i64 [ 0, %then27 ], [ %t181, %else25 ]
  store i64 %t189, i64* %l5
  br label %merge26
merge26:
  %t190 = phi i64 [ %t168, %then24 ], [ 0, %else25 ]
  store i64 %t190, i64* %l5
  br label %merge20
merge20:
  %t191 = phi { i8**, i64 }* [ null, %then18 ], [ %t113, %else19 ]
  %t192 = phi i8 [ %t134, %then18 ], [ %t152, %else19 ]
  %t193 = phi i64 [ 1, %then18 ], [ %t168, %else19 ]
  store { i8**, i64 }* %t191, { i8**, i64 }** %l0
  store i8 %t192, i8* %l1
  store i64 %t193, i64* %l5
  %t194 = load double, double* %l8
  store double %t194, double* %l2
  %t195 = load double, double* %l9
  store double %t195, double* %l3
  %t196 = load double, double* %l9
  %t197 = fcmp one double %t196, 0.0
  %t198 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t199 = load i8, i8* %l1
  %t200 = load double, double* %l2
  %t201 = load double, double* %l3
  %t202 = load i1, i1* %l4
  %t203 = load i64, i64* %l5
  %t204 = load i64, i64* %l6
  %t205 = load i8, i8* %l7
  %t206 = load double, double* %l8
  %t207 = load double, double* %l9
  %t208 = load i1, i1* %l10
  %t209 = load i1, i1* %l11
  %t210 = load i1, i1* %l12
  br i1 %t197, label %then29, label %else30
then29:
  store i1 0, i1* %l4
  store i64 0, i64* %l5
  br label %merge31
else30:
  %t211 = load i1, i1* %l10
  %t212 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t213 = load i8, i8* %l1
  %t214 = load double, double* %l2
  %t215 = load double, double* %l3
  %t216 = load i1, i1* %l4
  %t217 = load i64, i64* %l5
  %t218 = load i64, i64* %l6
  %t219 = load i8, i8* %l7
  %t220 = load double, double* %l8
  %t221 = load double, double* %l9
  %t222 = load i1, i1* %l10
  %t223 = load i1, i1* %l11
  %t224 = load i1, i1* %l12
  br i1 %t211, label %then32, label %else33
then32:
  br label %merge34
else33:
  %t225 = load i1, i1* %l11
  store i1 %t225, i1* %l4
  %t226 = load i1, i1* %l11
  %t227 = xor i1 %t226, 1
  %t228 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t229 = load i8, i8* %l1
  %t230 = load double, double* %l2
  %t231 = load double, double* %l3
  %t232 = load i1, i1* %l4
  %t233 = load i64, i64* %l5
  %t234 = load i64, i64* %l6
  %t235 = load i8, i8* %l7
  %t236 = load double, double* %l8
  %t237 = load double, double* %l9
  %t238 = load i1, i1* %l10
  %t239 = load i1, i1* %l11
  %t240 = load i1, i1* %l12
  br i1 %t227, label %then35, label %merge36
then35:
  store i64 0, i64* %l5
  br label %merge36
merge36:
  %t241 = phi i64 [ 0, %then35 ], [ %t233, %else33 ]
  store i64 %t241, i64* %l5
  br label %merge34
merge34:
  %t242 = phi i1 [ %t216, %then32 ], [ %t225, %else33 ]
  %t243 = phi i64 [ %t217, %then32 ], [ 0, %else33 ]
  store i1 %t242, i1* %l4
  store i64 %t243, i64* %l5
  br label %merge31
merge31:
  %t244 = phi i1 [ 0, %then29 ], [ %t225, %else30 ]
  %t245 = phi i64 [ 0, %then29 ], [ 0, %else30 ]
  store i1 %t244, i1* %l4
  store i64 %t245, i64* %l5
  %t246 = load i64, i64* %l6
  %t247 = add i64 %t246, 1
  store i64 %t247, i64* %l6
  br label %loop.latch4
loop.latch4:
  %t248 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t249 = load i8, i8* %l1
  %t250 = load i64, i64* %l5
  %t251 = load double, double* %l2
  %t252 = load double, double* %l3
  %t253 = load i1, i1* %l4
  %t254 = load i64, i64* %l6
  br label %loop.header2
afterloop5:
  %t262 = load i8, i8* %l1
  %t263 = alloca [1 x i8]
  %t264 = getelementptr [1 x i8], [1 x i8]* %t263, i32 0, i32 0
  %t265 = getelementptr i8, i8* %t264, i64 0
  store i8 %t262, i8* %t265
  %t266 = alloca { i8*, i64 }
  %t267 = getelementptr { i8*, i64 }, { i8*, i64 }* %t266, i32 0, i32 0
  store i8* %t264, i8** %t267
  %t268 = getelementptr { i8*, i64 }, { i8*, i64 }* %t266, i32 0, i32 1
  store i64 1, i64* %t268
  %t269 = call double @clustersconcat({ i8*, i64 }* %t266)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t270 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t270
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
