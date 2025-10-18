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
@.str.0 = private unnamed_addr constant [11 x i8] c"0123456789\00"
@.str.14 = private unnamed_addr constant [27 x i8] c"abcdefghijklmnopqrstuvwxyz\00"
@.str.30 = private unnamed_addr constant [27 x i8] c"ABCDEFGHIJKLMNOPQRSTUVWXYZ\00"

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

define { %EnumField*, i64 }* @enum_normalize_fields(double %definition, { %EnumField*, i64 }* %provided) {
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
  %t18 = phi { %EnumField*, i64 }* [ %t7, %entry ], [ %t16, %loop.latch2 ]
  %t19 = phi i64 [ %t8, %entry ], [ %t17, %loop.latch2 ]
  store { %EnumField*, i64 }* %t18, { %EnumField*, i64 }** %l1
  store i64 %t19, i64* %l2
  br label %loop.body1
loop.body1:
  %t9 = load i64, i64* %l2
  %t10 = load double, double* %l0
  store double 0.0, double* %l3
  %t11 = load double, double* %l3
  %t12 = call double @enum_lookup_field({ %EnumField*, i64 }* %provided, i8* null)
  store double %t12, double* %l4
  store double 0.0, double* %l5
  %t13 = load double, double* %l4
  %t14 = load i64, i64* %l2
  %t15 = add i64 %t14, 1
  store i64 %t15, i64* %l2
  br label %loop.latch2
loop.latch2:
  %t16 = load { %EnumField*, i64 }*, { %EnumField*, i64 }** %l1
  %t17 = load i64, i64* %l2
  br label %loop.header0
afterloop3:
  %t20 = load { %EnumField*, i64 }*, { %EnumField*, i64 }** %l1
  ret { %EnumField*, i64 }* %t20
}

define %EnumInstance @enum_instantiate(%EnumType %enum_type, i8* %variant_name, { %EnumField*, i64 }* %provided) {
entry:
  %l0 = alloca double
  %l1 = alloca { %EnumField*, i64 }*
  %t0 = call double @enum_find_variant(%EnumType %enum_type, i8* %variant_name)
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  %t2 = call { %EnumField*, i64 }* @enum_normalize_fields(double %t1, { %EnumField*, i64 }* %provided)
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
  %l1 = alloca double
  store i64 0, i64* %l0
  %t0 = load i64, i64* %l0
  br label %loop.header0
loop.header0:
  %t7 = phi i64 [ %t0, %entry ], [ %t6, %loop.latch2 ]
  store i64 %t7, i64* %l0
  br label %loop.body1
loop.body1:
  %t1 = load i64, i64* %l0
  %t2 = extractvalue %EnumInstance %instance, 2
  store double 0.0, double* %l1
  %t3 = load double, double* %l1
  %t4 = load i64, i64* %l0
  %t5 = add i64 %t4, 1
  store i64 %t5, i64* %l0
  br label %loop.latch2
loop.latch2:
  %t6 = load i64, i64* %l0
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
  %l2 = alloca double
  %l3 = alloca double
  %s0 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.0, i32 0, i32 0
  %t1 = add i8* %name, %s0
  store i8* %t1, i8** %l0
  store i64 0, i64* %l1
  %t2 = load i8*, i8** %l0
  %t3 = load i64, i64* %l1
  br label %loop.header0
loop.header0:
  %t20 = phi i8* [ %t2, %entry ], [ %t18, %loop.latch2 ]
  %t21 = phi i64 [ %t3, %entry ], [ %t19, %loop.latch2 ]
  store i8* %t20, i8** %l0
  store i64 %t21, i64* %l1
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
  store double 0.0, double* %l2
  %t13 = load double, double* %l2
  store double 0.0, double* %l3
  %t14 = load i8*, i8** %l0
  %t15 = load double, double* %l2
  %t16 = load i64, i64* %l1
  %t17 = add i64 %t16, 1
  store i64 %t17, i64* %l1
  br label %loop.latch2
loop.latch2:
  %t18 = load i8*, i8** %l0
  %t19 = load i64, i64* %l1
  br label %loop.header0
afterloop3:
  %t22 = load i8*, i8** %l0
  ret i8* %t22
}

define i8* @to_debug_string(double %value) {
entry:
  %t0 = call double @runtimeto_debug_string(double %value)
  ret i8* null
}

define i8* @format_interpolated({ i8**, i64 }* %parts, double %values) {
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
  %t10 = phi i8* [ %t1, %entry ], [ %t8, %loop.latch2 ]
  %t11 = phi i64 [ %t2, %entry ], [ %t9, %loop.latch2 ]
  store i8* %t10, i8** %l0
  store i64 %t11, i64* %l1
  br label %loop.body1
loop.body1:
  %t3 = load i64, i64* %l1
  %t4 = load i8*, i8** %l0
  %t5 = load i64, i64* %l1
  %t6 = load i64, i64* %l1
  %t7 = add i64 %t6, 1
  store i64 %t7, i64* %l1
  br label %loop.latch2
loop.latch2:
  %t8 = load i8*, i8** %l0
  %t9 = load i64, i64* %l1
  br label %loop.header0
afterloop3:
  %t12 = load i8*, i8** %l0
  ret i8* %t12
}

define %TypeDescriptor @type_descriptor(i8* %kind, double %name, { %TypeDescriptor*, i64 }* %items) {
entry:
  %t0 = insertvalue %TypeDescriptor undef, i8* %kind, 0
  %t1 = insertvalue %TypeDescriptor %t0, i8* null, 1
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
  %t6 = call %TypeDescriptor @type_descriptor(i8* %s0, double 0.0, { %TypeDescriptor*, i64 }* null)
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
  %t6 = call %TypeDescriptor @type_descriptor(i8* %s0, double 0.0, { %TypeDescriptor*, i64 }* null)
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
  %l2 = alloca double
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
  store double 0.0, double* %l2
  %t8 = load double, double* %l2
  br label %afterloop3
loop.latch2:
  br label %loop.header0
afterloop3:
  %t9 = load i64, i64* %l0
  %t10 = load double, double* %l1
  br label %loop.header6
loop.header6:
  br label %loop.body7
loop.body7:
  %t11 = load double, double* %l1
  %t12 = load i64, i64* %l0
  %t13 = sitofp i64 %t12 to double
  %t14 = fcmp ole double %t11, %t13
  %t15 = load i64, i64* %l0
  %t16 = load double, double* %l1
  br i1 %t14, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  store double 0.0, double* %l3
  %t17 = load double, double* %l3
  br label %afterloop9
loop.latch8:
  br label %loop.header6
afterloop9:
  %t18 = load i64, i64* %l0
  %t19 = load double, double* %l1
  %t20 = sitofp i64 %t18 to double
  %t21 = call i8* @substring(i8* %value, double %t20, double %t19)
  ret i8* %t21
}

define i1 @string_starts_with(i8* %value, i8* %prefix) {
entry:
  %l0 = alloca i64
  store i64 0, i64* %l0
  %t0 = load i64, i64* %l0
  br label %loop.header0
loop.header0:
  %t5 = phi i64 [ %t0, %entry ], [ %t4, %loop.latch2 ]
  store i64 %t5, i64* %l0
  br label %loop.body1
loop.body1:
  %t1 = load i64, i64* %l0
  %t2 = load i64, i64* %l0
  %t3 = add i64 %t2, 1
  store i64 %t3, i64* %l0
  br label %loop.latch2
loop.latch2:
  %t4 = load i64, i64* %l0
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
  %l1 = alloca double
  %l2 = alloca i64
  %l3 = alloca i64
  %l4 = alloca i64
  %l5 = alloca i64
  %l6 = alloca double
  %t0 = call i8* @descriptor_trim(i8* %value)
  store i8* %t0, i8** %l0
  store double 0.0, double* %l1
  store i64 0, i64* %l2
  store i64 0, i64* %l3
  store i64 0, i64* %l4
  store i64 0, i64* %l5
  %t1 = load i8*, i8** %l0
  %t2 = load double, double* %l1
  %t3 = load i64, i64* %l2
  %t4 = load i64, i64* %l3
  %t5 = load i64, i64* %l4
  %t6 = load i64, i64* %l5
  br label %loop.header0
loop.header0:
  %t15 = phi i64 [ %t3, %entry ], [ %t14, %loop.latch2 ]
  store i64 %t15, i64* %l2
  br label %loop.body1
loop.body1:
  %t7 = load i64, i64* %l2
  %t8 = load i8*, i8** %l0
  store double 0.0, double* %l6
  %t9 = load double, double* %l6
  %s10 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.10, i32 0, i32 0
  %t11 = load double, double* %l6
  %t12 = load i64, i64* %l2
  %t13 = add i64 %t12, 1
  store i64 %t13, i64* %l2
  br label %loop.latch2
loop.latch2:
  %t14 = load i64, i64* %l2
  br label %loop.header0
afterloop3:
  %t16 = sitofp i64 -1 to double
  ret double %t16
}

define i8* @descriptor_strip_outer_parens(i8* %value) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i64
  %l2 = alloca i64
  %l3 = alloca i1
  %l4 = alloca double
  %t0 = call i8* @descriptor_trim(i8* %value)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  br label %loop.header0
loop.header0:
  %t18 = phi i8* [ %t1, %entry ], [ %t17, %loop.latch2 ]
  store i8* %t18, i8** %l0
  br label %loop.body1
loop.body1:
  %t2 = load i8*, i8** %l0
  store i64 0, i64* %l1
  store i64 0, i64* %l2
  store i1 1, i1* %l3
  %t3 = load i8*, i8** %l0
  %t4 = load i64, i64* %l1
  %t5 = load i64, i64* %l2
  %t6 = load i1, i1* %l3
  br label %loop.header4
loop.header4:
  %t14 = phi i64 [ %t5, %loop.body1 ], [ %t13, %loop.latch6 ]
  store i64 %t14, i64* %l2
  br label %loop.body5
loop.body5:
  %t7 = load i64, i64* %l2
  %t8 = load i8*, i8** %l0
  store double 0.0, double* %l4
  %t9 = load double, double* %l4
  %s10 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.10, i32 0, i32 0
  %t11 = load i64, i64* %l2
  %t12 = add i64 %t11, 1
  store i64 %t12, i64* %l2
  br label %loop.latch6
loop.latch6:
  %t13 = load i64, i64* %l2
  br label %loop.header4
afterloop7:
  %t15 = load i8*, i8** %l0
  %t16 = load i8*, i8** %l0
  br label %loop.latch2
loop.latch2:
  %t17 = load i8*, i8** %l0
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
  %l7 = alloca double
  %l8 = alloca double
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
  store double 0.0, double* %l7
  %t6 = load i8*, i8** %l0
  %t7 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t8 = load i64, i64* %l2
  %t9 = load i64, i64* %l3
  %t10 = load i64, i64* %l4
  %t11 = load i64, i64* %l5
  %t12 = load i64, i64* %l6
  %t13 = load double, double* %l7
  br label %loop.header0
loop.header0:
  %t22 = phi i64 [ %t9, %entry ], [ %t21, %loop.latch2 ]
  store i64 %t22, i64* %l3
  br label %loop.body1
loop.body1:
  %t14 = load i64, i64* %l3
  %t15 = load i8*, i8** %l0
  store double 0.0, double* %l8
  %t16 = load double, double* %l8
  %s17 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.17, i32 0, i32 0
  %t18 = load double, double* %l8
  %t19 = load i64, i64* %l3
  %t20 = add i64 %t19, 1
  store i64 %t20, i64* %l3
  br label %loop.latch2
loop.latch2:
  %t21 = load i64, i64* %l3
  br label %loop.header0
afterloop3:
  %t23 = load i8*, i8** %l0
  %t24 = load i64, i64* %l2
  %t25 = load i8*, i8** %l0
  store double 0.0, double* %l9
  %t26 = load double, double* %l9
  %t27 = call i8* @descriptor_trim(i8* null)
  store i8* %t27, i8** %l10
  %t28 = load i8*, i8** %l10
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l1
  ret { i8**, i64 }* %t29
}

define { %TypeDescriptor*, i64 }* @parse_descriptor_list({ i8**, i64 }* %parts) {
entry:
  %l0 = alloca { %TypeDescriptor*, i64 }*
  %l1 = alloca i64
  %l2 = alloca double
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
  %t12 = phi i64 [ %t6, %entry ], [ %t11, %loop.latch2 ]
  store i64 %t12, i64* %l1
  br label %loop.body1
loop.body1:
  %t7 = load i64, i64* %l1
  store double 0.0, double* %l2
  %t8 = load double, double* %l2
  %t9 = load i64, i64* %l1
  %t10 = add i64 %t9, 1
  store i64 %t10, i64* %l1
  br label %loop.latch2
loop.latch2:
  %t11 = load i64, i64* %l1
  br label %loop.header0
afterloop3:
  %t13 = load { %TypeDescriptor*, i64 }*, { %TypeDescriptor*, i64 }** %l0
  ret { %TypeDescriptor*, i64 }* %t13
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
  %t39 = phi i8* [ %t24, %entry ], [ %t37, %loop.latch6 ]
  %t40 = phi double [ %t23, %entry ], [ %t38, %loop.latch6 ]
  store i8* %t39, i8** %l4
  store double %t40, double* %l3
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
  %t35 = sitofp i64 1 to double
  %t36 = fadd double %t34, %t35
  store double %t36, double* %l3
  br label %loop.latch6
loop.latch6:
  %t37 = load i8*, i8** %l4
  %t38 = load double, double* %l3
  br label %loop.header4
afterloop7:
  %t41 = load i8*, i8** %l4
  ret i8* %t41
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
  %t35 = phi double [ %t23, %entry ], [ %t34, %loop.latch8 ]
  store double %t35, double* %l3
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
  %t32 = sitofp i64 1 to double
  %t33 = fadd double %t31, %t32
  store double %t33, double* %l3
  br label %loop.latch8
loop.latch8:
  %t34 = load double, double* %l3
  br label %loop.header6
afterloop9:
  %t36 = sitofp i64 -1 to double
  ret double %t36
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
  %l0 = alloca double
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
  store double 0.0, double* %l0
  %s0 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l1
  %t1 = load i8*, i8** %l1
  %t2 = load double, double* %l0
  %t3 = sitofp i64 0 to double
  %t4 = call double @find_char(i8* %t1, i8* null, double %t3)
  store double %t4, double* %l2
  %t5 = load double, double* %l2
  %t6 = sitofp i64 0 to double
  %t7 = fcmp oge double %t5, %t6
  %t8 = load double, double* %l0
  %t9 = load i8*, i8** %l1
  %t10 = load double, double* %l2
  br i1 %t7, label %then0, label %merge1
then0:
  %t11 = load double, double* %l2
  %t12 = sitofp i64 48 to double
  %t13 = fadd double %t12, %t11
  ret double %t13
merge1:
  %s14 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.14, i32 0, i32 0
  store i8* %s14, i8** %l3
  %t15 = load i8*, i8** %l3
  %t16 = load double, double* %l0
  %t17 = sitofp i64 0 to double
  %t18 = call double @find_char(i8* %t15, i8* null, double %t17)
  store double %t18, double* %l4
  %t19 = load double, double* %l4
  %t20 = sitofp i64 0 to double
  %t21 = fcmp oge double %t19, %t20
  %t22 = load double, double* %l0
  %t23 = load i8*, i8** %l1
  %t24 = load double, double* %l2
  %t25 = load i8*, i8** %l3
  %t26 = load double, double* %l4
  br i1 %t21, label %then2, label %merge3
then2:
  %t27 = load double, double* %l4
  %t28 = sitofp i64 97 to double
  %t29 = fadd double %t28, %t27
  ret double %t29
merge3:
  %s30 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.30, i32 0, i32 0
  store i8* %s30, i8** %l5
  %t31 = load i8*, i8** %l5
  %t32 = load double, double* %l0
  %t33 = sitofp i64 0 to double
  %t34 = call double @find_char(i8* %t31, i8* null, double %t33)
  store double %t34, double* %l6
  %t35 = load double, double* %l6
  %t36 = sitofp i64 0 to double
  %t37 = fcmp oge double %t35, %t36
  %t38 = load double, double* %l0
  %t39 = load i8*, i8** %l1
  %t40 = load double, double* %l2
  %t41 = load i8*, i8** %l3
  %t42 = load double, double* %l4
  %t43 = load i8*, i8** %l5
  %t44 = load double, double* %l6
  br i1 %t37, label %then4, label %merge5
then4:
  %t45 = load double, double* %l6
  %t46 = sitofp i64 65 to double
  %t47 = fadd double %t46, %t45
  ret double %t47
merge5:
  %t48 = load double, double* %l0
  %s49 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.49, i32 0, i32 0
  %t50 = load double, double* %l0
  %s51 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.51, i32 0, i32 0
  %t52 = load double, double* %l0
  %s53 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.53, i32 0, i32 0
  %t54 = load double, double* %l0
  %s55 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.55, i32 0, i32 0
  %t56 = load double, double* %l0
  %s57 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.57, i32 0, i32 0
  %t58 = load double, double* %l0
  %s59 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.59, i32 0, i32 0
  %t60 = load double, double* %l0
  %s61 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.61, i32 0, i32 0
  store double 0.0, double* %l7
  %t62 = load double, double* %l7
  store double 0.0, double* %l8
  %t63 = load double, double* %l8
  %t64 = sitofp i64 0 to double
  %t65 = fcmp oeq double %t63, %t64
  %t66 = load double, double* %l0
  %t67 = load i8*, i8** %l1
  %t68 = load double, double* %l2
  %t69 = load i8*, i8** %l3
  %t70 = load double, double* %l4
  %t71 = load i8*, i8** %l5
  %t72 = load double, double* %l6
  %t73 = load double, double* %l7
  %t74 = load double, double* %l8
  br i1 %t65, label %then6, label %merge7
then6:
  %t75 = sitofp i64 -1 to double
  ret double %t75
merge7:
  %t76 = load double, double* %l8
  %t77 = sitofp i64 4 to double
  %t78 = fcmp ogt double %t76, %t77
  %t79 = load double, double* %l0
  %t80 = load i8*, i8** %l1
  %t81 = load double, double* %l2
  %t82 = load i8*, i8** %l3
  %t83 = load double, double* %l4
  %t84 = load i8*, i8** %l5
  %t85 = load double, double* %l6
  %t86 = load double, double* %l7
  %t87 = load double, double* %l8
  br i1 %t78, label %then8, label %merge9
then8:
  %t88 = sitofp i64 -1 to double
  ret double %t88
merge9:
  store i64 0, i64* %l9
  store i64 0, i64* %l10
  %t89 = load double, double* %l0
  %t90 = load i8*, i8** %l1
  %t91 = load double, double* %l2
  %t92 = load i8*, i8** %l3
  %t93 = load double, double* %l4
  %t94 = load i8*, i8** %l5
  %t95 = load double, double* %l6
  %t96 = load double, double* %l7
  %t97 = load double, double* %l8
  %t98 = load i64, i64* %l9
  %t99 = load i64, i64* %l10
  br label %loop.header10
loop.header10:
  %t160 = phi i64 [ %t99, %entry ], [ %t158, %loop.latch12 ]
  %t161 = phi i64 [ %t98, %entry ], [ %t159, %loop.latch12 ]
  store i64 %t160, i64* %l10
  store i64 %t161, i64* %l9
  br label %loop.body11
loop.body11:
  %t100 = load i64, i64* %l9
  %t101 = load double, double* %l8
  %t102 = sitofp i64 %t100 to double
  %t103 = fcmp oge double %t102, %t101
  %t104 = load double, double* %l0
  %t105 = load i8*, i8** %l1
  %t106 = load double, double* %l2
  %t107 = load i8*, i8** %l3
  %t108 = load double, double* %l4
  %t109 = load i8*, i8** %l5
  %t110 = load double, double* %l6
  %t111 = load double, double* %l7
  %t112 = load double, double* %l8
  %t113 = load i64, i64* %l9
  %t114 = load i64, i64* %l10
  br i1 %t103, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  store double 0.0, double* %l11
  %t115 = load i64, i64* %l9
  %t116 = icmp eq i64 %t115, 0
  %t117 = load double, double* %l0
  %t118 = load i8*, i8** %l1
  %t119 = load double, double* %l2
  %t120 = load i8*, i8** %l3
  %t121 = load double, double* %l4
  %t122 = load i8*, i8** %l5
  %t123 = load double, double* %l6
  %t124 = load double, double* %l7
  %t125 = load double, double* %l8
  %t126 = load i64, i64* %l9
  %t127 = load i64, i64* %l10
  %t128 = load double, double* %l11
  br i1 %t116, label %then16, label %else17
then16:
  %t129 = load double, double* %l11
  %t130 = sitofp i64 128 to double
  %t131 = fcmp olt double %t129, %t130
  %t132 = load double, double* %l0
  %t133 = load i8*, i8** %l1
  %t134 = load double, double* %l2
  %t135 = load i8*, i8** %l3
  %t136 = load double, double* %l4
  %t137 = load i8*, i8** %l5
  %t138 = load double, double* %l6
  %t139 = load double, double* %l7
  %t140 = load double, double* %l8
  %t141 = load i64, i64* %l9
  %t142 = load i64, i64* %l10
  %t143 = load double, double* %l11
  br i1 %t131, label %then19, label %merge20
then19:
  %t144 = load double, double* %l11
  ret double %t144
merge20:
  %t145 = load double, double* %l11
  br label %merge18
else17:
  %t146 = load double, double* %l11
  %t147 = load i64, i64* %l10
  %t148 = mul i64 %t147, 64
  %t149 = load double, double* %l11
  %t150 = sitofp i64 128 to double
  %t151 = fsub double %t149, %t150
  %t152 = sitofp i64 %t148 to double
  %t153 = fadd double %t152, %t151
  %t154 = fptosi double %t153 to i64
  store i64 %t154, i64* %l10
  br label %merge18
merge18:
  %t155 = phi i64 [ %t127, %then16 ], [ %t154, %else17 ]
  store i64 %t155, i64* %l10
  %t156 = load i64, i64* %l9
  %t157 = add i64 %t156, 1
  store i64 %t157, i64* %l9
  br label %loop.latch12
loop.latch12:
  %t158 = load i64, i64* %l10
  %t159 = load i64, i64* %l9
  br label %loop.header10
afterloop13:
  %t162 = load i64, i64* %l10
  %t163 = sitofp i64 %t162 to double
  ret double %t163
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
  %t15 = phi i64 [ %t0, %entry ], [ %t14, %loop.latch2 ]
  store i64 %t15, i64* %l0
  br label %loop.body1
loop.body1:
  %t1 = load i64, i64* %l0
  store double 0.0, double* %l1
  store double 0.0, double* %l2
  %t2 = load double, double* %l1
  %t3 = fcmp olt double %codepoint, %t2
  %t4 = load i64, i64* %l0
  %t5 = load double, double* %l1
  %t6 = load double, double* %l2
  br i1 %t3, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t7 = load double, double* %l2
  %t8 = fcmp ole double %codepoint, %t7
  %t9 = load i64, i64* %l0
  %t10 = load double, double* %l1
  %t11 = load double, double* %l2
  br i1 %t8, label %then6, label %merge7
then6:
  ret i1 1
merge7:
  %t12 = load i64, i64* %l0
  %t13 = add i64 %t12, 2
  store i64 %t13, i64* %l0
  br label %loop.latch2
loop.latch2:
  %t14 = load i64, i64* %l0
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
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i1
  %l5 = alloca i64
  %l6 = alloca i64
  %l7 = alloca double
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
  store double 0.0, double* %l1
  %t5 = load double, double* %l1
  %t6 = call double @char_code(i8* null)
  store double %t6, double* %l2
  %t7 = load double, double* %l2
  store double 0.0, double* %l3
  %t8 = load double, double* %l2
  %t9 = call i1 @is_regional_indicator(double %t8)
  store i1 %t9, i1* %l4
  store i64 0, i64* %l5
  %t10 = load i1, i1* %l4
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t12 = load double, double* %l1
  %t13 = load double, double* %l2
  %t14 = load double, double* %l3
  %t15 = load i1, i1* %l4
  %t16 = load i64, i64* %l5
  br i1 %t10, label %then0, label %merge1
then0:
  store i64 1, i64* %l5
  br label %merge1
merge1:
  %t17 = phi i64 [ 1, %then0 ], [ %t16, %entry ]
  store i64 %t17, i64* %l5
  store i64 1, i64* %l6
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t19 = load double, double* %l1
  %t20 = load double, double* %l2
  %t21 = load double, double* %l3
  %t22 = load i1, i1* %l4
  %t23 = load i64, i64* %l5
  %t24 = load i64, i64* %l6
  br label %loop.header2
loop.header2:
  %t139 = phi { i8**, i64 }* [ %t18, %entry ], [ %t132, %loop.latch4 ]
  %t140 = phi double [ %t19, %entry ], [ %t133, %loop.latch4 ]
  %t141 = phi i64 [ %t23, %entry ], [ %t134, %loop.latch4 ]
  %t142 = phi double [ %t20, %entry ], [ %t135, %loop.latch4 ]
  %t143 = phi double [ %t21, %entry ], [ %t136, %loop.latch4 ]
  %t144 = phi i1 [ %t22, %entry ], [ %t137, %loop.latch4 ]
  %t145 = phi i64 [ %t24, %entry ], [ %t138, %loop.latch4 ]
  store { i8**, i64 }* %t139, { i8**, i64 }** %l0
  store double %t140, double* %l1
  store i64 %t141, i64* %l5
  store double %t142, double* %l2
  store double %t143, double* %l3
  store i1 %t144, i1* %l4
  store i64 %t145, i64* %l6
  br label %loop.body3
loop.body3:
  %t25 = load i64, i64* %l6
  store double 0.0, double* %l7
  %t26 = load double, double* %l7
  %t27 = call double @char_code(i8* null)
  store double %t27, double* %l8
  %t28 = load double, double* %l8
  store double 0.0, double* %l9
  %t29 = load double, double* %l8
  %t30 = call i1 @is_grapheme_extend(double %t29)
  store i1 %t30, i1* %l10
  %t31 = load double, double* %l8
  %t32 = call i1 @is_regional_indicator(double %t31)
  store i1 %t32, i1* %l11
  store i1 0, i1* %l12
  %t33 = load double, double* %l2
  %t34 = load i1, i1* %l12
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t36 = load double, double* %l1
  %t37 = load double, double* %l2
  %t38 = load double, double* %l3
  %t39 = load i1, i1* %l4
  %t40 = load i64, i64* %l5
  %t41 = load i64, i64* %l6
  %t42 = load double, double* %l7
  %t43 = load double, double* %l8
  %t44 = load double, double* %l9
  %t45 = load i1, i1* %l10
  %t46 = load i1, i1* %l11
  %t47 = load i1, i1* %l12
  br i1 %t34, label %then6, label %else7
then6:
  %t48 = load double, double* %l1
  %t49 = alloca [1 x double]
  %t50 = getelementptr [1 x double], [1 x double]* %t49, i32 0, i32 0
  %t51 = getelementptr double, double* %t50, i64 0
  store double %t48, double* %t51
  %t52 = alloca { double*, i64 }
  %t53 = getelementptr { double*, i64 }, { double*, i64 }* %t52, i32 0, i32 0
  store double* %t50, double** %t53
  %t54 = getelementptr { double*, i64 }, { double*, i64 }* %t52, i32 0, i32 1
  store i64 1, i64* %t54
  %t55 = call double @clustersconcat({ double*, i64 }* %t52)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t56 = load double, double* %l7
  store double %t56, double* %l1
  %t57 = load i1, i1* %l11
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t59 = load double, double* %l1
  %t60 = load double, double* %l2
  %t61 = load double, double* %l3
  %t62 = load i1, i1* %l4
  %t63 = load i64, i64* %l5
  %t64 = load i64, i64* %l6
  %t65 = load double, double* %l7
  %t66 = load double, double* %l8
  %t67 = load double, double* %l9
  %t68 = load i1, i1* %l10
  %t69 = load i1, i1* %l11
  %t70 = load i1, i1* %l12
  br i1 %t57, label %then9, label %else10
then9:
  store i64 1, i64* %l5
  br label %merge11
else10:
  store i64 0, i64* %l5
  br label %merge11
merge11:
  %t71 = phi i64 [ 1, %then9 ], [ 0, %else10 ]
  store i64 %t71, i64* %l5
  br label %merge8
else7:
  %t72 = load double, double* %l1
  %t73 = load double, double* %l7
  %t74 = fadd double %t72, %t73
  store double %t74, double* %l1
  %t75 = load i1, i1* %l11
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t77 = load double, double* %l1
  %t78 = load double, double* %l2
  %t79 = load double, double* %l3
  %t80 = load i1, i1* %l4
  %t81 = load i64, i64* %l5
  %t82 = load i64, i64* %l6
  %t83 = load double, double* %l7
  %t84 = load double, double* %l8
  %t85 = load double, double* %l9
  %t86 = load i1, i1* %l10
  %t87 = load i1, i1* %l11
  %t88 = load i1, i1* %l12
  br i1 %t75, label %then12, label %else13
then12:
  %t89 = load i64, i64* %l5
  %t90 = add i64 %t89, 1
  store i64 %t90, i64* %l5
  br label %merge14
else13:
  br label %merge14
merge14:
  %t91 = phi i64 [ %t90, %then12 ], [ %t81, %else13 ]
  store i64 %t91, i64* %l5
  br label %merge8
merge8:
  %t92 = phi { i8**, i64 }* [ null, %then6 ], [ %t35, %else7 ]
  %t93 = phi double [ %t56, %then6 ], [ %t74, %else7 ]
  %t94 = phi i64 [ 1, %then6 ], [ %t90, %else7 ]
  store { i8**, i64 }* %t92, { i8**, i64 }** %l0
  store double %t93, double* %l1
  store i64 %t94, i64* %l5
  %t95 = load double, double* %l8
  store double %t95, double* %l2
  %t96 = load double, double* %l9
  store double %t96, double* %l3
  %t97 = load double, double* %l9
  %t98 = fcmp one double %t97, 0.0
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t100 = load double, double* %l1
  %t101 = load double, double* %l2
  %t102 = load double, double* %l3
  %t103 = load i1, i1* %l4
  %t104 = load i64, i64* %l5
  %t105 = load i64, i64* %l6
  %t106 = load double, double* %l7
  %t107 = load double, double* %l8
  %t108 = load double, double* %l9
  %t109 = load i1, i1* %l10
  %t110 = load i1, i1* %l11
  %t111 = load i1, i1* %l12
  br i1 %t98, label %then15, label %else16
then15:
  store i1 0, i1* %l4
  store i64 0, i64* %l5
  br label %merge17
else16:
  %t112 = load i1, i1* %l10
  %t113 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t114 = load double, double* %l1
  %t115 = load double, double* %l2
  %t116 = load double, double* %l3
  %t117 = load i1, i1* %l4
  %t118 = load i64, i64* %l5
  %t119 = load i64, i64* %l6
  %t120 = load double, double* %l7
  %t121 = load double, double* %l8
  %t122 = load double, double* %l9
  %t123 = load i1, i1* %l10
  %t124 = load i1, i1* %l11
  %t125 = load i1, i1* %l12
  br i1 %t112, label %then18, label %else19
then18:
  br label %merge20
else19:
  %t126 = load i1, i1* %l11
  store i1 %t126, i1* %l4
  br label %merge20
merge20:
  %t127 = phi i1 [ %t117, %then18 ], [ %t126, %else19 ]
  store i1 %t127, i1* %l4
  br label %merge17
merge17:
  %t128 = phi i1 [ 0, %then15 ], [ %t126, %else16 ]
  %t129 = phi i64 [ 0, %then15 ], [ %t104, %else16 ]
  store i1 %t128, i1* %l4
  store i64 %t129, i64* %l5
  %t130 = load i64, i64* %l6
  %t131 = add i64 %t130, 1
  store i64 %t131, i64* %l6
  br label %loop.latch4
loop.latch4:
  %t132 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t133 = load double, double* %l1
  %t134 = load i64, i64* %l5
  %t135 = load double, double* %l2
  %t136 = load double, double* %l3
  %t137 = load i1, i1* %l4
  %t138 = load i64, i64* %l6
  br label %loop.header2
afterloop5:
  %t146 = load double, double* %l1
  %t147 = alloca [1 x double]
  %t148 = getelementptr [1 x double], [1 x double]* %t147, i32 0, i32 0
  %t149 = getelementptr double, double* %t148, i64 0
  store double %t146, double* %t149
  %t150 = alloca { double*, i64 }
  %t151 = getelementptr { double*, i64 }, { double*, i64 }* %t150, i32 0, i32 0
  store double* %t148, double** %t151
  %t152 = getelementptr { double*, i64 }, { double*, i64 }* %t150, i32 0, i32 1
  store i64 1, i64* %t152
  %t153 = call double @clustersconcat({ double*, i64 }* %t150)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t154 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t154
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
  ret i8* null
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
