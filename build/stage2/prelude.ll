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
@.str.21 = private unnamed_addr constant [1 x i8] c"\00"
@.str.5 = private unnamed_addr constant [11 x i8] c"0123456789\00"
@.str.19 = private unnamed_addr constant [27 x i8] c"abcdefghijklmnopqrstuvwxyz\00"
@.str.35 = private unnamed_addr constant [27 x i8] c"ABCDEFGHIJKLMNOPQRSTUVWXYZ\00"

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
define { i8**, i64 }* @parallel({ i8**, i64 }* %tasks) {
entry:
  %l0 = alloca { double*, i64 }*
  %l1 = alloca i64
  %l2 = alloca i8*
  %l3 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { double*, i64 }* %t2, { double*, i64 }** %l0
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %tasks, i32 0, i32 1
  %t6 = load i64, i64* %t5
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %tasks, i32 0, i32 0
  %t8 = load i8**, i8*** %t7
  store i64 0, i64* %l1
  store i8* null, i8** %l2
  br label %for0
for0:
  %t9 = load i64, i64* %l1
  %t10 = icmp slt i64 %t9, %t6
  br i1 %t10, label %forbody1, label %afterfor3
forbody1:
  %t11 = load i64, i64* %l1
  %t12 = getelementptr i8*, i8** %t8, i64 %t11
  %t13 = load i8*, i8** %t12
  store i8* %t13, i8** %l2
  %t14 = call double @task()
  store double %t14, double* %l3
  %t15 = load { double*, i64 }*, { double*, i64 }** %l0
  %t16 = load double, double* %l3
  %t17 = alloca [1 x double]
  %t18 = getelementptr [1 x double], [1 x double]* %t17, i32 0, i32 0
  %t19 = getelementptr double, double* %t18, i64 0
  store double %t16, double* %t19
  %t20 = alloca { double*, i64 }
  %t21 = getelementptr { double*, i64 }, { double*, i64 }* %t20, i32 0, i32 0
  store double* %t18, double** %t21
  %t22 = getelementptr { double*, i64 }, { double*, i64 }* %t20, i32 0, i32 1
  store i64 1, i64* %t22
  %t23 = bitcast { double*, i64 }* %t15 to { i8**, i64 }*
  %t24 = bitcast { double*, i64 }* %t20 to { i8**, i64 }*
  %t25 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t23, { i8**, i64 }* %t24)
  %t26 = bitcast { i8**, i64 }* %t25 to { double*, i64 }*
  store { double*, i64 }* %t26, { double*, i64 }** %l0
  br label %forinc2
forinc2:
  %t27 = load i64, i64* %l1
  %t28 = add i64 %t27, 1
  store i64 %t28, i64* %l1
  br label %for0
afterfor3:
  %t29 = load { double*, i64 }*, { double*, i64 }** %l0
  %t30 = bitcast { double*, i64 }* %t29 to { i8**, i64 }*
  ret { i8**, i64 }* %t30
}

; fn spawn effects: ![io]
define void @spawn(i8* %task, i8* %name) {
entry:
  %t0 = call i64 @sailfin_runtime_string_length(i8* %name)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  ret void
merge1:
  ret void
}

define { i8**, i64 }* @array_map({ i8**, i64 }* %items, i8* %mapper) {
entry:
  %l0 = alloca { double*, i64 }*
  %l1 = alloca i64
  %l2 = alloca i8*
  %l3 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { double*, i64 }* %t2, { double*, i64 }** %l0
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %items, i32 0, i32 1
  %t6 = load i64, i64* %t5
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %items, i32 0, i32 0
  %t8 = load i8**, i8*** %t7
  store i64 0, i64* %l1
  store i8* null, i8** %l2
  br label %for0
for0:
  %t9 = load i64, i64* %l1
  %t10 = icmp slt i64 %t9, %t6
  br i1 %t10, label %forbody1, label %afterfor3
forbody1:
  %t11 = load i64, i64* %l1
  %t12 = getelementptr i8*, i8** %t8, i64 %t11
  %t13 = load i8*, i8** %t12
  store i8* %t13, i8** %l2
  %t14 = load i8*, i8** %l2
  %t15 = call double @mapper(i8* %t14)
  store double %t15, double* %l3
  %t16 = load { double*, i64 }*, { double*, i64 }** %l0
  %t17 = load double, double* %l3
  %t18 = alloca [1 x double]
  %t19 = getelementptr [1 x double], [1 x double]* %t18, i32 0, i32 0
  %t20 = getelementptr double, double* %t19, i64 0
  store double %t17, double* %t20
  %t21 = alloca { double*, i64 }
  %t22 = getelementptr { double*, i64 }, { double*, i64 }* %t21, i32 0, i32 0
  store double* %t19, double** %t22
  %t23 = getelementptr { double*, i64 }, { double*, i64 }* %t21, i32 0, i32 1
  store i64 1, i64* %t23
  %t24 = bitcast { double*, i64 }* %t16 to { i8**, i64 }*
  %t25 = bitcast { double*, i64 }* %t21 to { i8**, i64 }*
  %t26 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t24, { i8**, i64 }* %t25)
  %t27 = bitcast { i8**, i64 }* %t26 to { double*, i64 }*
  store { double*, i64 }* %t27, { double*, i64 }** %l0
  br label %forinc2
forinc2:
  %t28 = load i64, i64* %l1
  %t29 = add i64 %t28, 1
  store i64 %t29, i64* %l1
  br label %for0
afterfor3:
  %t30 = load { double*, i64 }*, { double*, i64 }** %l0
  %t31 = bitcast { double*, i64 }* %t30 to { i8**, i64 }*
  ret { i8**, i64 }* %t31
}

define { i8**, i64 }* @array_filter({ i8**, i64 }* %items, i8* %predicate) {
entry:
  %l0 = alloca { double*, i64 }*
  %l1 = alloca i64
  %l2 = alloca i8*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { double*, i64 }* %t2, { double*, i64 }** %l0
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %items, i32 0, i32 1
  %t6 = load i64, i64* %t5
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %items, i32 0, i32 0
  %t8 = load i8**, i8*** %t7
  store i64 0, i64* %l1
  store i8* null, i8** %l2
  br label %for0
for0:
  %t9 = load i64, i64* %l1
  %t10 = icmp slt i64 %t9, %t6
  br i1 %t10, label %forbody1, label %afterfor3
forbody1:
  %t11 = load i64, i64* %l1
  %t12 = getelementptr i8*, i8** %t8, i64 %t11
  %t13 = load i8*, i8** %t12
  store i8* %t13, i8** %l2
  %t14 = load i8*, i8** %l2
  %t15 = call double @predicate(i8* %t14)
  %t16 = fcmp one double %t15, 0.0
  %t17 = load { double*, i64 }*, { double*, i64 }** %l0
  %t18 = load i8*, i8** %l2
  br i1 %t16, label %then4, label %merge5
then4:
  %t19 = load { double*, i64 }*, { double*, i64 }** %l0
  %t20 = load i8*, i8** %l2
  %t21 = alloca [1 x i8*]
  %t22 = getelementptr [1 x i8*], [1 x i8*]* %t21, i32 0, i32 0
  %t23 = getelementptr i8*, i8** %t22, i64 0
  store i8* %t20, i8** %t23
  %t24 = alloca { i8**, i64 }
  %t25 = getelementptr { i8**, i64 }, { i8**, i64 }* %t24, i32 0, i32 0
  store i8** %t22, i8*** %t25
  %t26 = getelementptr { i8**, i64 }, { i8**, i64 }* %t24, i32 0, i32 1
  store i64 1, i64* %t26
  %t27 = bitcast { double*, i64 }* %t19 to { i8**, i64 }*
  %t28 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t27, { i8**, i64 }* %t24)
  %t29 = bitcast { i8**, i64 }* %t28 to { double*, i64 }*
  store { double*, i64 }* %t29, { double*, i64 }** %l0
  br label %merge5
merge5:
  %t30 = phi { double*, i64 }* [ %t29, %then4 ], [ %t17, %forbody1 ]
  store { double*, i64 }* %t30, { double*, i64 }** %l0
  br label %forinc2
forinc2:
  %t31 = load i64, i64* %l1
  %t32 = add i64 %t31, 1
  store i64 %t32, i64* %l1
  br label %for0
afterfor3:
  %t33 = load { double*, i64 }*, { double*, i64 }** %l0
  %t34 = bitcast { double*, i64 }* %t33 to { i8**, i64 }*
  ret { i8**, i64 }* %t34
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

define %EnumField @enum_field(i8* %name, i8* %value) {
entry:
  %t0 = insertvalue %EnumField undef, i8* %name, 0
  %t1 = insertvalue %EnumField %t0, i8* %value, 1
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

define %StructField @struct_field(i8* %name, i8* %value) {
entry:
  %t0 = insertvalue %StructField undef, i8* %name, 0
  %t1 = insertvalue %StructField %t0, i8* %value, 1
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
  %t30 = call i8* @to_debug_string(i8* %t29)
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

define i8* @to_debug_string(i8* %value) {
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
  %t32 = call i8* @to_debug_string(i8* %t31)
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
  %l1 = alloca i64
  %l2 = alloca i8
  %l3 = alloca double
  store i64 0, i64* %l0
  %t0 = call i64 @sailfin_runtime_string_length(i8* %value)
  store i64 %t0, i64* %l1
  %t1 = load i64, i64* %l0
  %t2 = load i64, i64* %l1
  br label %loop.header0
loop.header0:
  %t31 = phi i64 [ %t1, %entry ], [ %t30, %loop.latch2 ]
  store i64 %t31, i64* %l0
  br label %loop.body1
loop.body1:
  %t3 = load i64, i64* %l0
  %t4 = load i64, i64* %l1
  %t5 = icmp sge i64 %t3, %t4
  %t6 = load i64, i64* %l0
  %t7 = load i64, i64* %l1
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
  %t26 = load i64, i64* %l1
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
  %t33 = load i64, i64* %l1
  br label %loop.header8
loop.header8:
  br label %loop.body9
loop.body9:
  %t34 = load i64, i64* %l1
  %t35 = load i64, i64* %l0
  %t36 = icmp sle i64 %t34, %t35
  %t37 = load i64, i64* %l0
  %t38 = load i64, i64* %l1
  br i1 %t36, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  store double 0.0, double* %l3
  %t42 = load double, double* %l3
  br label %afterloop11
loop.latch10:
  br label %loop.header8
afterloop11:
  %t43 = load i64, i64* %l0
  %t44 = load i64, i64* %l1
  %t45 = sitofp i64 %t43 to double
  %t46 = sitofp i64 %t44 to double
  %t47 = call i8* @sailfin_runtime_substring(i8* %value, double %t45, double %t46)
  ret i8* %t47
}

define i1 @string_starts_with(i8* %value, i8* %prefix) {
entry:
  %l0 = alloca i64
  %t0 = call i64 @sailfin_runtime_string_length(i8* %prefix)
  %t1 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t2 = icmp sgt i64 %t0, %t1
  br i1 %t2, label %then0, label %merge1
then0:
  ret i1 0
merge1:
  store i64 0, i64* %l0
  %t3 = load i64, i64* %l0
  br label %loop.header2
loop.header2:
  %t19 = phi i64 [ %t3, %entry ], [ %t18, %loop.latch4 ]
  store i64 %t19, i64* %l0
  br label %loop.body3
loop.body3:
  %t4 = load i64, i64* %l0
  %t5 = call i64 @sailfin_runtime_string_length(i8* %prefix)
  %t6 = icmp sge i64 %t4, %t5
  %t7 = load i64, i64* %l0
  br i1 %t6, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t8 = load i64, i64* %l0
  %t9 = getelementptr i8, i8* %value, i64 %t8
  %t10 = load i8, i8* %t9
  %t11 = load i64, i64* %l0
  %t12 = getelementptr i8, i8* %prefix, i64 %t11
  %t13 = load i8, i8* %t12
  %t14 = icmp ne i8 %t10, %t13
  %t15 = load i64, i64* %l0
  br i1 %t14, label %then8, label %merge9
then8:
  ret i1 0
merge9:
  %t16 = load i64, i64* %l0
  %t17 = add i64 %t16, 1
  store i64 %t17, i64* %l0
  br label %loop.latch4
loop.latch4:
  %t18 = load i64, i64* %l0
  br label %loop.header2
afterloop5:
  ret i1 1
}

define i1 @string_ends_with(i8* %value, i8* %suffix) {
entry:
  %l0 = alloca i64
  %l1 = alloca i64
  %t0 = call i64 @sailfin_runtime_string_length(i8* %suffix)
  %t1 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t2 = icmp sgt i64 %t0, %t1
  br i1 %t2, label %then0, label %merge1
then0:
  ret i1 0
merge1:
  %t3 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t4 = call i64 @sailfin_runtime_string_length(i8* %suffix)
  %t5 = sub i64 %t3, %t4
  store i64 %t5, i64* %l0
  store i64 0, i64* %l1
  %t6 = load i64, i64* %l0
  %t7 = load i64, i64* %l1
  br label %loop.header2
loop.header2:
  %t16 = phi i64 [ %t7, %entry ], [ %t15, %loop.latch4 ]
  store i64 %t16, i64* %l1
  br label %loop.body3
loop.body3:
  %t8 = load i64, i64* %l1
  %t9 = call i64 @sailfin_runtime_string_length(i8* %suffix)
  %t10 = icmp sge i64 %t8, %t9
  %t11 = load i64, i64* %l0
  %t12 = load i64, i64* %l1
  br i1 %t10, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t13 = load i64, i64* %l1
  %t14 = add i64 %t13, 1
  store i64 %t14, i64* %l1
  br label %loop.latch4
loop.latch4:
  %t15 = load i64, i64* %l1
  br label %loop.header2
afterloop5:
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
  %t1 = call i64 @sailfin_runtime_string_length(i8* %needle)
  %t2 = icmp ne i64 %t1, 1
  %t3 = load i8*, i8** %l0
  br i1 %t2, label %then0, label %merge1
then0:
  %t4 = sitofp i64 -1 to double
  ret double %t4
merge1:
  %t5 = getelementptr i8, i8* %needle, i64 0
  %t6 = load i8, i8* %t5
  store i8 %t6, i8* %l1
  store i64 0, i64* %l2
  store i64 0, i64* %l3
  store i64 0, i64* %l4
  store i64 0, i64* %l5
  %t7 = load i8*, i8** %l0
  %t8 = load i8, i8* %l1
  %t9 = load i64, i64* %l2
  %t10 = load i64, i64* %l3
  %t11 = load i64, i64* %l4
  %t12 = load i64, i64* %l5
  br label %loop.header2
loop.header2:
  %t90 = phi i64 [ %t10, %entry ], [ %t88, %loop.latch4 ]
  %t91 = phi i64 [ %t9, %entry ], [ %t89, %loop.latch4 ]
  store i64 %t90, i64* %l3
  store i64 %t91, i64* %l2
  br label %loop.body3
loop.body3:
  %t13 = load i64, i64* %l2
  %t14 = load i8*, i8** %l0
  %t15 = call i64 @sailfin_runtime_string_length(i8* %t14)
  %t16 = icmp sge i64 %t13, %t15
  %t17 = load i8*, i8** %l0
  %t18 = load i8, i8* %l1
  %t19 = load i64, i64* %l2
  %t20 = load i64, i64* %l3
  %t21 = load i64, i64* %l4
  %t22 = load i64, i64* %l5
  br i1 %t16, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t23 = load i8*, i8** %l0
  %t24 = load i64, i64* %l2
  %t25 = getelementptr i8, i8* %t23, i64 %t24
  %t26 = load i8, i8* %t25
  store i8 %t26, i8* %l6
  %t27 = load i8, i8* %l6
  %t28 = icmp eq i8 %t27, 40
  %t29 = load i8*, i8** %l0
  %t30 = load i8, i8* %l1
  %t31 = load i64, i64* %l2
  %t32 = load i64, i64* %l3
  %t33 = load i64, i64* %l4
  %t34 = load i64, i64* %l5
  %t35 = load i8, i8* %l6
  br i1 %t28, label %then8, label %else9
then8:
  %t36 = load i64, i64* %l3
  %t37 = add i64 %t36, 1
  store i64 %t37, i64* %l3
  br label %merge10
else9:
  %t38 = load i8, i8* %l6
  %t39 = icmp eq i8 %t38, 41
  %t40 = load i8*, i8** %l0
  %t41 = load i8, i8* %l1
  %t42 = load i64, i64* %l2
  %t43 = load i64, i64* %l3
  %t44 = load i64, i64* %l4
  %t45 = load i64, i64* %l5
  %t46 = load i8, i8* %l6
  br i1 %t39, label %then11, label %else12
then11:
  %t47 = load i64, i64* %l3
  %t48 = icmp sgt i64 %t47, 0
  %t49 = load i8*, i8** %l0
  %t50 = load i8, i8* %l1
  %t51 = load i64, i64* %l2
  %t52 = load i64, i64* %l3
  %t53 = load i64, i64* %l4
  %t54 = load i64, i64* %l5
  %t55 = load i8, i8* %l6
  br i1 %t48, label %then14, label %merge15
then14:
  %t56 = load i64, i64* %l3
  %t57 = sub i64 %t56, 1
  store i64 %t57, i64* %l3
  br label %merge15
merge15:
  %t58 = phi i64 [ %t57, %then14 ], [ %t52, %then11 ]
  store i64 %t58, i64* %l3
  br label %merge13
else12:
  %t59 = load i8, i8* %l6
  br label %merge13
merge13:
  %t60 = phi i64 [ %t57, %then11 ], [ %t43, %else12 ]
  store i64 %t60, i64* %l3
  br label %merge10
merge10:
  %t61 = phi i64 [ %t37, %then8 ], [ %t57, %else9 ]
  store i64 %t61, i64* %l3
  %t65 = load i8, i8* %l6
  %t66 = load i8, i8* %l1
  %t67 = icmp eq i8 %t65, %t66
  br label %logical_and_entry_64

logical_and_entry_64:
  br i1 %t67, label %logical_and_right_64, label %logical_and_merge_64

logical_and_right_64:
  %t68 = load i64, i64* %l3
  %t69 = icmp eq i64 %t68, 0
  br label %logical_and_right_end_64

logical_and_right_end_64:
  br label %logical_and_merge_64

logical_and_merge_64:
  %t70 = phi i1 [ false, %logical_and_entry_64 ], [ %t69, %logical_and_right_end_64 ]
  br label %logical_and_entry_63

logical_and_entry_63:
  br i1 %t70, label %logical_and_right_63, label %logical_and_merge_63

logical_and_right_63:
  %t71 = load i64, i64* %l4
  %t72 = icmp eq i64 %t71, 0
  br label %logical_and_right_end_63

logical_and_right_end_63:
  br label %logical_and_merge_63

logical_and_merge_63:
  %t73 = phi i1 [ false, %logical_and_entry_63 ], [ %t72, %logical_and_right_end_63 ]
  br label %logical_and_entry_62

logical_and_entry_62:
  br i1 %t73, label %logical_and_right_62, label %logical_and_merge_62

logical_and_right_62:
  %t74 = load i64, i64* %l5
  %t75 = icmp eq i64 %t74, 0
  br label %logical_and_right_end_62

logical_and_right_end_62:
  br label %logical_and_merge_62

logical_and_merge_62:
  %t76 = phi i1 [ false, %logical_and_entry_62 ], [ %t75, %logical_and_right_end_62 ]
  %t77 = load i8*, i8** %l0
  %t78 = load i8, i8* %l1
  %t79 = load i64, i64* %l2
  %t80 = load i64, i64* %l3
  %t81 = load i64, i64* %l4
  %t82 = load i64, i64* %l5
  %t83 = load i8, i8* %l6
  br i1 %t76, label %then16, label %merge17
then16:
  %t84 = load i64, i64* %l2
  %t85 = sitofp i64 %t84 to double
  ret double %t85
merge17:
  %t86 = load i64, i64* %l2
  %t87 = add i64 %t86, 1
  store i64 %t87, i64* %l2
  br label %loop.latch4
loop.latch4:
  %t88 = load i64, i64* %l3
  %t89 = load i64, i64* %l2
  br label %loop.header2
afterloop5:
  %t92 = sitofp i64 -1 to double
  ret double %t92
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
  %t101 = phi i8* [ %t1, %entry ], [ %t100, %loop.latch2 ]
  store i8* %t101, i8** %l0
  br label %loop.body1
loop.body1:
  %t2 = load i8*, i8** %l0
  %t3 = call i64 @sailfin_runtime_string_length(i8* %t2)
  %t4 = icmp slt i64 %t3, 2
  %t5 = load i8*, i8** %l0
  br i1 %t4, label %then4, label %merge5
then4:
  %t6 = load i8*, i8** %l0
  ret i8* %t6
merge5:
  %t7 = load i8*, i8** %l0
  %t8 = getelementptr i8, i8* %t7, i64 0
  %t9 = load i8, i8* %t8
  %t10 = icmp ne i8 %t9, 40
  %t11 = load i8*, i8** %l0
  br i1 %t10, label %then6, label %merge7
then6:
  %t12 = load i8*, i8** %l0
  ret i8* %t12
merge7:
  store i64 0, i64* %l1
  store i64 0, i64* %l2
  store i1 1, i1* %l3
  %t13 = load i8*, i8** %l0
  %t14 = load i64, i64* %l1
  %t15 = load i64, i64* %l2
  %t16 = load i1, i1* %l3
  br label %loop.header8
loop.header8:
  %t78 = phi i64 [ %t14, %loop.body1 ], [ %t75, %loop.latch10 ]
  %t79 = phi i1 [ %t16, %loop.body1 ], [ %t76, %loop.latch10 ]
  %t80 = phi i64 [ %t15, %loop.body1 ], [ %t77, %loop.latch10 ]
  store i64 %t78, i64* %l1
  store i1 %t79, i1* %l3
  store i64 %t80, i64* %l2
  br label %loop.body9
loop.body9:
  %t17 = load i64, i64* %l2
  %t18 = load i8*, i8** %l0
  %t19 = call i64 @sailfin_runtime_string_length(i8* %t18)
  %t20 = icmp sge i64 %t17, %t19
  %t21 = load i8*, i8** %l0
  %t22 = load i64, i64* %l1
  %t23 = load i64, i64* %l2
  %t24 = load i1, i1* %l3
  br i1 %t20, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t25 = load i8*, i8** %l0
  %t26 = load i64, i64* %l2
  %t27 = getelementptr i8, i8* %t25, i64 %t26
  %t28 = load i8, i8* %t27
  store i8 %t28, i8* %l4
  %t29 = load i8, i8* %l4
  %t30 = icmp eq i8 %t29, 40
  %t31 = load i8*, i8** %l0
  %t32 = load i64, i64* %l1
  %t33 = load i64, i64* %l2
  %t34 = load i1, i1* %l3
  %t35 = load i8, i8* %l4
  br i1 %t30, label %then14, label %else15
then14:
  %t36 = load i64, i64* %l1
  %t37 = add i64 %t36, 1
  store i64 %t37, i64* %l1
  br label %merge16
else15:
  %t38 = load i8, i8* %l4
  %t39 = icmp eq i8 %t38, 41
  %t40 = load i8*, i8** %l0
  %t41 = load i64, i64* %l1
  %t42 = load i64, i64* %l2
  %t43 = load i1, i1* %l3
  %t44 = load i8, i8* %l4
  br i1 %t39, label %then17, label %merge18
then17:
  %t45 = load i64, i64* %l1
  %t46 = sub i64 %t45, 1
  store i64 %t46, i64* %l1
  %t47 = load i64, i64* %l1
  %t48 = icmp slt i64 %t47, 0
  %t49 = load i8*, i8** %l0
  %t50 = load i64, i64* %l1
  %t51 = load i64, i64* %l2
  %t52 = load i1, i1* %l3
  %t53 = load i8, i8* %l4
  br i1 %t48, label %then19, label %merge20
then19:
  store i1 0, i1* %l3
  br label %afterloop11
merge20:
  %t55 = load i64, i64* %l1
  %t56 = icmp eq i64 %t55, 0
  br label %logical_and_entry_54

logical_and_entry_54:
  br i1 %t56, label %logical_and_right_54, label %logical_and_merge_54

logical_and_right_54:
  %t57 = load i64, i64* %l2
  %t58 = load i8*, i8** %l0
  %t59 = call i64 @sailfin_runtime_string_length(i8* %t58)
  %t60 = sub i64 %t59, 1
  %t61 = icmp slt i64 %t57, %t60
  br label %logical_and_right_end_54

logical_and_right_end_54:
  br label %logical_and_merge_54

logical_and_merge_54:
  %t62 = phi i1 [ false, %logical_and_entry_54 ], [ %t61, %logical_and_right_end_54 ]
  %t63 = load i8*, i8** %l0
  %t64 = load i64, i64* %l1
  %t65 = load i64, i64* %l2
  %t66 = load i1, i1* %l3
  %t67 = load i8, i8* %l4
  br i1 %t62, label %then21, label %merge22
then21:
  store i1 0, i1* %l3
  br label %afterloop11
merge22:
  br label %merge18
merge18:
  %t68 = phi i64 [ %t46, %then17 ], [ %t41, %else15 ]
  %t69 = phi i1 [ 0, %then17 ], [ %t43, %else15 ]
  %t70 = phi i1 [ 0, %then17 ], [ %t43, %else15 ]
  store i64 %t68, i64* %l1
  store i1 %t69, i1* %l3
  store i1 %t70, i1* %l3
  br label %merge16
merge16:
  %t71 = phi i64 [ %t37, %then14 ], [ %t46, %else15 ]
  %t72 = phi i1 [ %t34, %then14 ], [ 0, %else15 ]
  store i64 %t71, i64* %l1
  store i1 %t72, i1* %l3
  %t73 = load i64, i64* %l2
  %t74 = add i64 %t73, 1
  store i64 %t74, i64* %l2
  br label %loop.latch10
loop.latch10:
  %t75 = load i64, i64* %l1
  %t76 = load i1, i1* %l3
  %t77 = load i64, i64* %l2
  br label %loop.header8
afterloop11:
  %t82 = load i1, i1* %l3
  br label %logical_or_entry_81

logical_or_entry_81:
  br i1 %t82, label %logical_or_merge_81, label %logical_or_right_81

logical_or_right_81:
  %t83 = load i64, i64* %l1
  %t84 = icmp ne i64 %t83, 0
  br label %logical_or_right_end_81

logical_or_right_end_81:
  br label %logical_or_merge_81

logical_or_merge_81:
  %t85 = phi i1 [ true, %logical_or_entry_81 ], [ %t84, %logical_or_right_end_81 ]
  %t86 = xor i1 %t85, 1
  %t87 = load i8*, i8** %l0
  %t88 = load i64, i64* %l1
  %t89 = load i64, i64* %l2
  %t90 = load i1, i1* %l3
  br i1 %t86, label %then23, label %merge24
then23:
  %t91 = load i8*, i8** %l0
  ret i8* %t91
merge24:
  %t92 = load i8*, i8** %l0
  %t93 = load i8*, i8** %l0
  %t94 = call i64 @sailfin_runtime_string_length(i8* %t93)
  %t95 = sub i64 %t94, 1
  %t96 = sitofp i64 1 to double
  %t97 = sitofp i64 %t95 to double
  %t98 = call i8* @sailfin_runtime_substring(i8* %t92, double %t96, double %t97)
  %t99 = call i8* @descriptor_trim(i8* %t98)
  store i8* %t99, i8** %l0
  br label %loop.latch2
loop.latch2:
  %t100 = load i8*, i8** %l0
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
  %l10 = alloca i8*
  %l11 = alloca i8*
  %t0 = call i8* @descriptor_trim(i8* %value)
  store i8* %t0, i8** %l0
  %t1 = call i64 @sailfin_runtime_string_length(i8* %separator)
  %t2 = icmp ne i64 %t1, 1
  %t3 = load i8*, i8** %l0
  br i1 %t2, label %then0, label %merge1
then0:
  %t4 = load i8*, i8** %l0
  %t5 = alloca [1 x i8*]
  %t6 = getelementptr [1 x i8*], [1 x i8*]* %t5, i32 0, i32 0
  %t7 = getelementptr i8*, i8** %t6, i64 0
  store i8* %t4, i8** %t7
  %t8 = alloca { i8**, i64 }
  %t9 = getelementptr { i8**, i64 }, { i8**, i64 }* %t8, i32 0, i32 0
  store i8** %t6, i8*** %t9
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* %t8, i32 0, i32 1
  store i64 1, i64* %t10
  ret { i8**, i64 }* %t8
merge1:
  %t11 = alloca [0 x i8*]
  %t12 = getelementptr [0 x i8*], [0 x i8*]* %t11, i32 0, i32 0
  %t13 = alloca { i8**, i64 }
  %t14 = getelementptr { i8**, i64 }, { i8**, i64 }* %t13, i32 0, i32 0
  store i8** %t12, i8*** %t14
  %t15 = getelementptr { i8**, i64 }, { i8**, i64 }* %t13, i32 0, i32 1
  store i64 0, i64* %t15
  store { i8**, i64 }* %t13, { i8**, i64 }** %l1
  store i64 0, i64* %l2
  store i64 0, i64* %l3
  store i64 0, i64* %l4
  store i64 0, i64* %l5
  store i64 0, i64* %l6
  %t16 = getelementptr i8, i8* %separator, i64 0
  %t17 = load i8, i8* %t16
  store i8 %t17, i8* %l7
  %t18 = load i8*, i8** %l0
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t20 = load i64, i64* %l2
  %t21 = load i64, i64* %l3
  %t22 = load i64, i64* %l4
  %t23 = load i64, i64* %l5
  %t24 = load i64, i64* %l6
  %t25 = load i8, i8* %l7
  br label %loop.header2
loop.header2:
  %t133 = phi i64 [ %t22, %entry ], [ %t129, %loop.latch4 ]
  %t134 = phi { i8**, i64 }* [ %t19, %entry ], [ %t130, %loop.latch4 ]
  %t135 = phi i64 [ %t20, %entry ], [ %t131, %loop.latch4 ]
  %t136 = phi i64 [ %t21, %entry ], [ %t132, %loop.latch4 ]
  store i64 %t133, i64* %l4
  store { i8**, i64 }* %t134, { i8**, i64 }** %l1
  store i64 %t135, i64* %l2
  store i64 %t136, i64* %l3
  br label %loop.body3
loop.body3:
  %t26 = load i64, i64* %l3
  %t27 = load i8*, i8** %l0
  %t28 = call i64 @sailfin_runtime_string_length(i8* %t27)
  %t29 = icmp sge i64 %t26, %t28
  %t30 = load i8*, i8** %l0
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t32 = load i64, i64* %l2
  %t33 = load i64, i64* %l3
  %t34 = load i64, i64* %l4
  %t35 = load i64, i64* %l5
  %t36 = load i64, i64* %l6
  %t37 = load i8, i8* %l7
  br i1 %t29, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t38 = load i8*, i8** %l0
  %t39 = load i64, i64* %l3
  %t40 = getelementptr i8, i8* %t38, i64 %t39
  %t41 = load i8, i8* %t40
  store i8 %t41, i8* %l8
  %t42 = load i8, i8* %l8
  %t43 = icmp eq i8 %t42, 40
  %t44 = load i8*, i8** %l0
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t46 = load i64, i64* %l2
  %t47 = load i64, i64* %l3
  %t48 = load i64, i64* %l4
  %t49 = load i64, i64* %l5
  %t50 = load i64, i64* %l6
  %t51 = load i8, i8* %l7
  %t52 = load i8, i8* %l8
  br i1 %t43, label %then8, label %else9
then8:
  %t53 = load i64, i64* %l4
  %t54 = add i64 %t53, 1
  store i64 %t54, i64* %l4
  br label %merge10
else9:
  %t55 = load i8, i8* %l8
  %t56 = icmp eq i8 %t55, 41
  %t57 = load i8*, i8** %l0
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t59 = load i64, i64* %l2
  %t60 = load i64, i64* %l3
  %t61 = load i64, i64* %l4
  %t62 = load i64, i64* %l5
  %t63 = load i64, i64* %l6
  %t64 = load i8, i8* %l7
  %t65 = load i8, i8* %l8
  br i1 %t56, label %then11, label %else12
then11:
  %t66 = load i64, i64* %l4
  %t67 = icmp sgt i64 %t66, 0
  %t68 = load i8*, i8** %l0
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t70 = load i64, i64* %l2
  %t71 = load i64, i64* %l3
  %t72 = load i64, i64* %l4
  %t73 = load i64, i64* %l5
  %t74 = load i64, i64* %l6
  %t75 = load i8, i8* %l7
  %t76 = load i8, i8* %l8
  br i1 %t67, label %then14, label %merge15
then14:
  %t77 = load i64, i64* %l4
  %t78 = sub i64 %t77, 1
  store i64 %t78, i64* %l4
  br label %merge15
merge15:
  %t79 = phi i64 [ %t78, %then14 ], [ %t72, %then11 ]
  store i64 %t79, i64* %l4
  br label %merge13
else12:
  %t80 = load i8, i8* %l8
  br label %merge13
merge13:
  %t81 = phi i64 [ %t78, %then11 ], [ %t61, %else12 ]
  store i64 %t81, i64* %l4
  br label %merge10
merge10:
  %t82 = phi i64 [ %t54, %then8 ], [ %t78, %else9 ]
  store i64 %t82, i64* %l4
  %t86 = load i8, i8* %l8
  %t87 = load i8, i8* %l7
  %t88 = icmp eq i8 %t86, %t87
  br label %logical_and_entry_85

logical_and_entry_85:
  br i1 %t88, label %logical_and_right_85, label %logical_and_merge_85

logical_and_right_85:
  %t89 = load i64, i64* %l4
  %t90 = icmp eq i64 %t89, 0
  br label %logical_and_right_end_85

logical_and_right_end_85:
  br label %logical_and_merge_85

logical_and_merge_85:
  %t91 = phi i1 [ false, %logical_and_entry_85 ], [ %t90, %logical_and_right_end_85 ]
  br label %logical_and_entry_84

logical_and_entry_84:
  br i1 %t91, label %logical_and_right_84, label %logical_and_merge_84

logical_and_right_84:
  %t92 = load i64, i64* %l5
  %t93 = icmp eq i64 %t92, 0
  br label %logical_and_right_end_84

logical_and_right_end_84:
  br label %logical_and_merge_84

logical_and_merge_84:
  %t94 = phi i1 [ false, %logical_and_entry_84 ], [ %t93, %logical_and_right_end_84 ]
  br label %logical_and_entry_83

logical_and_entry_83:
  br i1 %t94, label %logical_and_right_83, label %logical_and_merge_83

logical_and_right_83:
  %t95 = load i64, i64* %l6
  %t96 = icmp eq i64 %t95, 0
  br label %logical_and_right_end_83

logical_and_right_end_83:
  br label %logical_and_merge_83

logical_and_merge_83:
  %t97 = phi i1 [ false, %logical_and_entry_83 ], [ %t96, %logical_and_right_end_83 ]
  %t98 = load i8*, i8** %l0
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t100 = load i64, i64* %l2
  %t101 = load i64, i64* %l3
  %t102 = load i64, i64* %l4
  %t103 = load i64, i64* %l5
  %t104 = load i64, i64* %l6
  %t105 = load i8, i8* %l7
  %t106 = load i8, i8* %l8
  br i1 %t97, label %then16, label %merge17
then16:
  %t107 = load i8*, i8** %l0
  %t108 = load i64, i64* %l2
  %t109 = load i64, i64* %l3
  %t110 = sitofp i64 %t108 to double
  %t111 = sitofp i64 %t109 to double
  %t112 = call i8* @sailfin_runtime_substring(i8* %t107, double %t110, double %t111)
  store i8* %t112, i8** %l9
  %t113 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t114 = load i8*, i8** %l9
  %t115 = call i8* @descriptor_trim(i8* %t114)
  %t116 = alloca [1 x i8*]
  %t117 = getelementptr [1 x i8*], [1 x i8*]* %t116, i32 0, i32 0
  %t118 = getelementptr i8*, i8** %t117, i64 0
  store i8* %t115, i8** %t118
  %t119 = alloca { i8**, i64 }
  %t120 = getelementptr { i8**, i64 }, { i8**, i64 }* %t119, i32 0, i32 0
  store i8** %t117, i8*** %t120
  %t121 = getelementptr { i8**, i64 }, { i8**, i64 }* %t119, i32 0, i32 1
  store i64 1, i64* %t121
  %t122 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t113, { i8**, i64 }* %t119)
  store { i8**, i64 }* %t122, { i8**, i64 }** %l1
  %t123 = load i64, i64* %l3
  %t124 = add i64 %t123, 1
  store i64 %t124, i64* %l2
  br label %merge17
merge17:
  %t125 = phi { i8**, i64 }* [ %t122, %then16 ], [ %t99, %loop.body3 ]
  %t126 = phi i64 [ %t124, %then16 ], [ %t100, %loop.body3 ]
  store { i8**, i64 }* %t125, { i8**, i64 }** %l1
  store i64 %t126, i64* %l2
  %t127 = load i64, i64* %l3
  %t128 = add i64 %t127, 1
  store i64 %t128, i64* %l3
  br label %loop.latch4
loop.latch4:
  %t129 = load i64, i64* %l4
  %t130 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t131 = load i64, i64* %l2
  %t132 = load i64, i64* %l3
  br label %loop.header2
afterloop5:
  %t137 = load i8*, i8** %l0
  %t138 = load i64, i64* %l2
  %t139 = load i8*, i8** %l0
  %t140 = call i64 @sailfin_runtime_string_length(i8* %t139)
  %t141 = sitofp i64 %t138 to double
  %t142 = sitofp i64 %t140 to double
  %t143 = call i8* @sailfin_runtime_substring(i8* %t137, double %t141, double %t142)
  store i8* %t143, i8** %l10
  %t144 = load i8*, i8** %l10
  %t145 = call i8* @descriptor_trim(i8* %t144)
  store i8* %t145, i8** %l11
  %t147 = load i8*, i8** %l11
  %t148 = call i64 @sailfin_runtime_string_length(i8* %t147)
  %t149 = icmp sgt i64 %t148, 0
  br label %logical_or_entry_146

logical_or_entry_146:
  br i1 %t149, label %logical_or_merge_146, label %logical_or_right_146

logical_or_right_146:
  %t150 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t151 = load { i8**, i64 }, { i8**, i64 }* %t150
  %t152 = extractvalue { i8**, i64 } %t151, 1
  %t153 = icmp eq i64 %t152, 0
  br label %logical_or_right_end_146

logical_or_right_end_146:
  br label %logical_or_merge_146

logical_or_merge_146:
  %t154 = phi i1 [ true, %logical_or_entry_146 ], [ %t153, %logical_or_right_end_146 ]
  %t155 = load i8*, i8** %l0
  %t156 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t157 = load i64, i64* %l2
  %t158 = load i64, i64* %l3
  %t159 = load i64, i64* %l4
  %t160 = load i64, i64* %l5
  %t161 = load i64, i64* %l6
  %t162 = load i8, i8* %l7
  %t163 = load i8*, i8** %l10
  %t164 = load i8*, i8** %l11
  br i1 %t154, label %then18, label %merge19
then18:
  %t165 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t166 = load i8*, i8** %l11
  %t167 = alloca [1 x i8*]
  %t168 = getelementptr [1 x i8*], [1 x i8*]* %t167, i32 0, i32 0
  %t169 = getelementptr i8*, i8** %t168, i64 0
  store i8* %t166, i8** %t169
  %t170 = alloca { i8**, i64 }
  %t171 = getelementptr { i8**, i64 }, { i8**, i64 }* %t170, i32 0, i32 0
  store i8** %t168, i8*** %t171
  %t172 = getelementptr { i8**, i64 }, { i8**, i64 }* %t170, i32 0, i32 1
  store i64 1, i64* %t172
  %t173 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t165, { i8**, i64 }* %t170)
  store { i8**, i64 }* %t173, { i8**, i64 }** %l1
  br label %merge19
merge19:
  %t174 = phi { i8**, i64 }* [ %t173, %then18 ], [ %t156, %entry ]
  store { i8**, i64 }* %t174, { i8**, i64 }** %l1
  %t175 = load { i8**, i64 }*, { i8**, i64 }** %l1
  ret { i8**, i64 }* %t175
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
  %t44 = phi { %TypeDescriptor*, i64 }* [ %t5, %entry ], [ %t42, %loop.latch2 ]
  %t45 = phi i64 [ %t6, %entry ], [ %t43, %loop.latch2 ]
  store { %TypeDescriptor*, i64 }* %t44, { %TypeDescriptor*, i64 }** %l0
  store i64 %t45, i64* %l1
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
  %t21 = call i64 @sailfin_runtime_string_length(i8* %t20)
  %t22 = icmp sgt i64 %t21, 0
  %t23 = load { %TypeDescriptor*, i64 }*, { %TypeDescriptor*, i64 }** %l0
  %t24 = load i64, i64* %l1
  %t25 = load i8*, i8** %l2
  br i1 %t22, label %then6, label %merge7
then6:
  %t26 = load { %TypeDescriptor*, i64 }*, { %TypeDescriptor*, i64 }** %l0
  %t27 = load i8*, i8** %l2
  %t28 = call %TypeDescriptor @parse_type_descriptor(i8* %t27)
  %t29 = alloca [1 x %TypeDescriptor]
  %t30 = getelementptr [1 x %TypeDescriptor], [1 x %TypeDescriptor]* %t29, i32 0, i32 0
  %t31 = getelementptr %TypeDescriptor, %TypeDescriptor* %t30, i64 0
  store %TypeDescriptor %t28, %TypeDescriptor* %t31
  %t32 = alloca { %TypeDescriptor*, i64 }
  %t33 = getelementptr { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* %t32, i32 0, i32 0
  store %TypeDescriptor* %t30, %TypeDescriptor** %t33
  %t34 = getelementptr { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* %t32, i32 0, i32 1
  store i64 1, i64* %t34
  %t35 = bitcast { %TypeDescriptor*, i64 }* %t26 to { i8**, i64 }*
  %t36 = bitcast { %TypeDescriptor*, i64 }* %t32 to { i8**, i64 }*
  %t37 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t35, { i8**, i64 }* %t36)
  %t38 = bitcast { i8**, i64 }* %t37 to { %TypeDescriptor*, i64 }*
  store { %TypeDescriptor*, i64 }* %t38, { %TypeDescriptor*, i64 }** %l0
  br label %merge7
merge7:
  %t39 = phi { %TypeDescriptor*, i64 }* [ %t38, %then6 ], [ %t23, %loop.body1 ]
  store { %TypeDescriptor*, i64 }* %t39, { %TypeDescriptor*, i64 }** %l0
  %t40 = load i64, i64* %l1
  %t41 = add i64 %t40, 1
  store i64 %t41, i64* %l1
  br label %loop.latch2
loop.latch2:
  %t42 = load { %TypeDescriptor*, i64 }*, { %TypeDescriptor*, i64 }** %l0
  %t43 = load i64, i64* %l1
  br label %loop.header0
afterloop3:
  %t46 = load { %TypeDescriptor*, i64 }*, { %TypeDescriptor*, i64 }** %l0
  ret { %TypeDescriptor*, i64 }* %t46
}

define %TypeDescriptor @parse_type_descriptor(i8* %text) {
entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca i8*
  %l4 = alloca double
  %l5 = alloca i8*
  %t0 = call i8* @descriptor_strip_outer_parens(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = call %TypeDescriptor @type_descriptor_unknown()
  ret %TypeDescriptor %t5
merge1:
  %t6 = load i8*, i8** %l0
  %t7 = call { i8**, i64 }* @split_descriptor(i8* %t6, i8* null)
  store { i8**, i64 }* %t7, { i8**, i64 }** %l1
  %t8 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t9 = load { i8**, i64 }, { i8**, i64 }* %t8
  %t10 = extractvalue { i8**, i64 } %t9, 1
  %t11 = icmp sgt i64 %t10, 1
  %t12 = load i8*, i8** %l0
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t11, label %then2, label %merge3
then2:
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t15 = call { %TypeDescriptor*, i64 }* @parse_descriptor_list({ i8**, i64 }* %t14)
  %t16 = call %TypeDescriptor @type_descriptor_union({ %TypeDescriptor*, i64 }* %t15)
  ret %TypeDescriptor %t16
merge3:
  %t17 = load i8*, i8** %l0
  %t18 = call { i8**, i64 }* @split_descriptor(i8* %t17, i8* null)
  store { i8**, i64 }* %t18, { i8**, i64 }** %l2
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t20 = load { i8**, i64 }, { i8**, i64 }* %t19
  %t21 = extractvalue { i8**, i64 } %t20, 1
  %t22 = icmp sgt i64 %t21, 1
  %t23 = load i8*, i8** %l0
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t22, label %then4, label %merge5
then4:
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t27 = call { %TypeDescriptor*, i64 }* @parse_descriptor_list({ i8**, i64 }* %t26)
  %t28 = call %TypeDescriptor @type_descriptor_intersection({ %TypeDescriptor*, i64 }* %t27)
  ret %TypeDescriptor %t28
merge5:
  %t29 = load i8*, i8** %l0
  %s30 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.30, i32 0, i32 0
  %t31 = call i1 @string_ends_with(i8* %t29, i8* %s30)
  %t32 = load i8*, i8** %l0
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t31, label %then6, label %merge7
then6:
  %t35 = load i8*, i8** %l0
  %t36 = load i8*, i8** %l0
  %t37 = call i64 @sailfin_runtime_string_length(i8* %t36)
  %t38 = sub i64 %t37, 2
  %t39 = sitofp i64 0 to double
  %t40 = sitofp i64 %t38 to double
  %t41 = call i8* @sailfin_runtime_substring(i8* %t35, double %t39, double %t40)
  store i8* %t41, i8** %l3
  %t42 = load i8*, i8** %l3
  %t43 = call %TypeDescriptor @parse_type_descriptor(i8* %t42)
  %t44 = call %TypeDescriptor @type_descriptor_array(%TypeDescriptor %t43)
  ret %TypeDescriptor %t44
merge7:
  %t45 = load i8*, i8** %l0
  %s46 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.46, i32 0, i32 0
  %t47 = call i1 @string_starts_with(i8* %t45, i8* %s46)
  %t48 = load i8*, i8** %l0
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t47, label %then8, label %merge9
then8:
  %t51 = call %TypeDescriptor @type_descriptor_function()
  ret %TypeDescriptor %t51
merge9:
  %t52 = load i8*, i8** %l0
  store double 0.0, double* %l4
  %t53 = load i8*, i8** %l0
  store i8* %t53, i8** %l5
  %t54 = load double, double* %l4
  %t55 = sitofp i64 0 to double
  %t56 = fcmp oge double %t54, %t55
  %t57 = load i8*, i8** %l0
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t60 = load double, double* %l4
  %t61 = load i8*, i8** %l5
  br i1 %t56, label %then10, label %merge11
then10:
  %t62 = load i8*, i8** %l0
  %t63 = load double, double* %l4
  %t64 = sitofp i64 0 to double
  %t65 = call i8* @sailfin_runtime_substring(i8* %t62, double %t64, double %t63)
  %t66 = call i8* @descriptor_trim(i8* %t65)
  store i8* %t66, i8** %l5
  br label %merge11
merge11:
  %t67 = phi i8* [ %t66, %then10 ], [ %t61, %entry ]
  store i8* %t67, i8** %l5
  %t68 = load i8*, i8** %l5
  %s69 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.69, i32 0, i32 0
  %t70 = call i1 @string_starts_with(i8* %t68, i8* %s69)
  %t71 = load i8*, i8** %l0
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t74 = load double, double* %l4
  %t75 = load i8*, i8** %l5
  br i1 %t70, label %then12, label %merge13
then12:
  %t76 = load i8*, i8** %l5
  %t77 = load i8*, i8** %l5
  %t78 = call i64 @sailfin_runtime_string_length(i8* %t77)
  %t79 = sitofp i64 8 to double
  %t80 = sitofp i64 %t78 to double
  %t81 = call i8* @sailfin_runtime_substring(i8* %t76, double %t79, double %t80)
  %t82 = call i8* @descriptor_trim(i8* %t81)
  store i8* %t82, i8** %l5
  br label %merge13
merge13:
  %t83 = phi i8* [ %t82, %then12 ], [ %t75, %entry ]
  store i8* %t83, i8** %l5
  %t87 = load i8*, i8** %l5
  %s88 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.88, i32 0, i32 0
  %t89 = icmp eq i8* %t87, %s88
  br label %logical_or_entry_86

logical_or_entry_86:
  br i1 %t89, label %logical_or_merge_86, label %logical_or_right_86

logical_or_right_86:
  %t90 = load i8*, i8** %l5
  %s91 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.91, i32 0, i32 0
  %t92 = icmp eq i8* %t90, %s91
  br label %logical_or_right_end_86

logical_or_right_end_86:
  br label %logical_or_merge_86

logical_or_merge_86:
  %t93 = phi i1 [ true, %logical_or_entry_86 ], [ %t92, %logical_or_right_end_86 ]
  br label %logical_or_entry_85

logical_or_entry_85:
  br i1 %t93, label %logical_or_merge_85, label %logical_or_right_85

logical_or_right_85:
  %t94 = load i8*, i8** %l5
  %s95 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.95, i32 0, i32 0
  %t96 = icmp eq i8* %t94, %s95
  br label %logical_or_right_end_85

logical_or_right_end_85:
  br label %logical_or_merge_85

logical_or_merge_85:
  %t97 = phi i1 [ true, %logical_or_entry_85 ], [ %t96, %logical_or_right_end_85 ]
  br label %logical_or_entry_84

logical_or_entry_84:
  br i1 %t97, label %logical_or_merge_84, label %logical_or_right_84

logical_or_right_84:
  %t98 = load i8*, i8** %l5
  %s99 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.99, i32 0, i32 0
  %t100 = icmp eq i8* %t98, %s99
  br label %logical_or_right_end_84

logical_or_right_end_84:
  br label %logical_or_merge_84

logical_or_merge_84:
  %t101 = phi i1 [ true, %logical_or_entry_84 ], [ %t100, %logical_or_right_end_84 ]
  %t102 = load i8*, i8** %l0
  %t103 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t105 = load double, double* %l4
  %t106 = load i8*, i8** %l5
  br i1 %t101, label %then14, label %merge15
then14:
  %t107 = load i8*, i8** %l5
  %t108 = call %TypeDescriptor @type_descriptor_primitive(i8* %t107)
  ret %TypeDescriptor %t108
merge15:
  %t109 = load i8*, i8** %l5
  %t110 = call %TypeDescriptor @type_descriptor_named(i8* %t109)
  ret %TypeDescriptor %t110
}

define i1 @check_type_primitive(i8* %value, i8* %name) {
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

define i1 @check_type_descriptor(i8* %value, %TypeDescriptor %descriptor) {
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
  %t6 = call i1 @check_type_primitive(i8* %value, i8* %t5)
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
  %t25 = call i1 @check_type_descriptor(i8* %value, %TypeDescriptor zeroinitializer)
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
  %t49 = call i1 @check_type_descriptor(i8* %value, %TypeDescriptor zeroinitializer)
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
  %t92 = phi i64 [ %t75, %then24 ], [ %t91, %loop.latch30 ]
  store i64 %t92, i64* %l3
  br label %loop.body29
loop.body29:
  %t76 = load i64, i64* %l3
  %t77 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t78 = icmp sge i64 %t76, %t77
  %t79 = load i8*, i8** %l2
  %t80 = load i64, i64* %l3
  br i1 %t78, label %then32, label %merge33
then32:
  br label %afterloop31
merge33:
  %t81 = load i64, i64* %l3
  %t82 = getelementptr i8, i8* %value, i64 %t81
  %t83 = load i8, i8* %t82
  %t84 = load i8*, i8** %l2
  %t85 = call i1 @check_type_descriptor(i8* null, %TypeDescriptor zeroinitializer)
  %t86 = xor i1 %t85, 1
  %t87 = load i8*, i8** %l2
  %t88 = load i64, i64* %l3
  br i1 %t86, label %then34, label %merge35
then34:
  ret i1 0
merge35:
  %t89 = load i64, i64* %l3
  %t90 = add i64 %t89, 1
  store i64 %t90, i64* %l3
  br label %loop.latch30
loop.latch30:
  %t91 = load i64, i64* %l3
  br label %loop.header28
afterloop31:
  ret i1 1
merge25:
  %t93 = extractvalue %TypeDescriptor %descriptor, 0
  %s94 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.94, i32 0, i32 0
  %t95 = icmp eq i8* %t93, %s94
  br i1 %t95, label %then36, label %merge37
then36:
  ret i1 false
merge37:
  %t96 = extractvalue %TypeDescriptor %descriptor, 0
  %s97 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.97, i32 0, i32 0
  %t98 = icmp eq i8* %t96, %s97
  br i1 %t98, label %then38, label %merge39
then38:
  %t99 = extractvalue %TypeDescriptor %descriptor, 1
  %t100 = icmp eq i8* %t99, null
  br i1 %t100, label %then40, label %merge41
then40:
  ret i1 0
merge41:
  store double 0.0, double* %l4
  ret i1 false
merge39:
  %t101 = extractvalue %TypeDescriptor %descriptor, 0
  %s102 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.102, i32 0, i32 0
  %t103 = icmp eq i8* %t101, %s102
  br i1 %t103, label %then42, label %merge43
then42:
  ret i1 0
merge43:
  ret i1 0
}

define i1 @check_type(i8* %value, i8* %descriptor) {
entry:
  %l0 = alloca %TypeDescriptor
  %t0 = call %TypeDescriptor @parse_type_descriptor(i8* %descriptor)
  store %TypeDescriptor %t0, %TypeDescriptor* %l0
  %t1 = load %TypeDescriptor, %TypeDescriptor* %l0
  %t2 = call i1 @check_type_descriptor(i8* %value, %TypeDescriptor %t1)
  ret i1 %t2
}

; fn serve effects: ![io, net]
define void @serve(i8* %handler, i8* %config) {
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
  %l0 = alloca i64
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i8*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %text)
  store i64 %t0, i64* %l0
  %t1 = load i64, i64* %l0
  %t2 = icmp eq i64 %t1, 0
  %t3 = load i64, i64* %l0
  br i1 %t2, label %then0, label %merge1
then0:
  %s4 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.4, i32 0, i32 0
  ret i8* %s4
merge1:
  %t5 = load i64, i64* %l0
  %t6 = sitofp i64 0 to double
  %t7 = sitofp i64 %t5 to double
  %t8 = call double @clamp(double %start, double %t6, double %t7)
  store double %t8, double* %l1
  %t9 = load i64, i64* %l0
  %t10 = sitofp i64 0 to double
  %t11 = sitofp i64 %t9 to double
  %t12 = call double @clamp(double %end, double %t10, double %t11)
  store double %t12, double* %l2
  %t13 = load double, double* %l1
  %t14 = load double, double* %l2
  %t15 = fcmp oge double %t13, %t14
  %t16 = load i64, i64* %l0
  %t17 = load double, double* %l1
  %t18 = load double, double* %l2
  br i1 %t15, label %then2, label %merge3
then2:
  %s19 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.19, i32 0, i32 0
  ret i8* %s19
merge3:
  %t20 = load double, double* %l1
  store double %t20, double* %l3
  %s21 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.21, i32 0, i32 0
  store i8* %s21, i8** %l4
  %t22 = load i64, i64* %l0
  %t23 = load double, double* %l1
  %t24 = load double, double* %l2
  %t25 = load double, double* %l3
  %t26 = load i8*, i8** %l4
  br label %loop.header4
loop.header4:
  %t48 = phi i8* [ %t26, %entry ], [ %t46, %loop.latch6 ]
  %t49 = phi double [ %t25, %entry ], [ %t47, %loop.latch6 ]
  store i8* %t48, i8** %l4
  store double %t49, double* %l3
  br label %loop.body5
loop.body5:
  %t27 = load double, double* %l3
  %t28 = load double, double* %l2
  %t29 = fcmp oge double %t27, %t28
  %t30 = load i64, i64* %l0
  %t31 = load double, double* %l1
  %t32 = load double, double* %l2
  %t33 = load double, double* %l3
  %t34 = load i8*, i8** %l4
  br i1 %t29, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t35 = load i8*, i8** %l4
  %t36 = load double, double* %l3
  %t37 = fptosi double %t36 to i64
  %t38 = getelementptr i8, i8* %text, i64 %t37
  %t39 = load i8, i8* %t38
  %t40 = getelementptr i8, i8* %t35, i64 0
  %t41 = load i8, i8* %t40
  %t42 = add i8 %t41, %t39
  store i8* null, i8** %l4
  %t43 = load double, double* %l3
  %t44 = sitofp i64 1 to double
  %t45 = fadd double %t43, %t44
  store double %t45, double* %l3
  br label %loop.latch6
loop.latch6:
  %t46 = load i8*, i8** %l4
  %t47 = load double, double* %l3
  br label %loop.header4
afterloop7:
  %t50 = load i8*, i8** %l4
  ret i8* %t50
}

define double @find_char(i8* %text, i8* %character, double %start) {
entry:
  %l0 = alloca i64
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca i8
  %l4 = alloca double
  %t0 = call i64 @sailfin_runtime_string_length(i8* %text)
  store i64 %t0, i64* %l0
  %t1 = load i64, i64* %l0
  %t2 = icmp eq i64 %t1, 0
  %t3 = load i64, i64* %l0
  br i1 %t2, label %then0, label %merge1
then0:
  %t4 = sitofp i64 -1 to double
  ret double %t4
merge1:
  store double %start, double* %l1
  %t5 = load double, double* %l1
  %t6 = sitofp i64 0 to double
  %t7 = fcmp olt double %t5, %t6
  %t8 = load i64, i64* %l0
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
  %t13 = load i64, i64* %l0
  %t14 = sitofp i64 %t13 to double
  %t15 = fcmp oge double %t12, %t14
  %t16 = load i64, i64* %l0
  %t17 = load double, double* %l1
  br i1 %t15, label %then4, label %merge5
then4:
  %t18 = sitofp i64 -1 to double
  ret double %t18
merge5:
  store i8* %character, i8** %l2
  %t20 = load i8*, i8** %l2
  %t21 = call i64 @sailfin_runtime_string_length(i8* %t20)
  %t22 = icmp eq i64 %t21, 2
  br label %logical_and_entry_19

logical_and_entry_19:
  br i1 %t22, label %logical_and_right_19, label %logical_and_merge_19

logical_and_right_19:
  %t23 = load i8*, i8** %l2
  %t24 = getelementptr i8, i8* %t23, i64 0
  %t25 = load i8, i8* %t24
  %t26 = icmp eq i8 %t25, 92
  br label %logical_and_right_end_19

logical_and_right_end_19:
  br label %logical_and_merge_19

logical_and_merge_19:
  %t27 = phi i1 [ false, %logical_and_entry_19 ], [ %t26, %logical_and_right_end_19 ]
  %t28 = load i64, i64* %l0
  %t29 = load double, double* %l1
  %t30 = load i8*, i8** %l2
  br i1 %t27, label %then6, label %merge7
then6:
  %t31 = load i8*, i8** %l2
  %t32 = getelementptr i8, i8* %t31, i64 1
  %t33 = load i8, i8* %t32
  store i8 %t33, i8* %l3
  %t34 = load i8, i8* %l3
  %t35 = icmp eq i8 %t34, 110
  %t36 = load i64, i64* %l0
  %t37 = load double, double* %l1
  %t38 = load i8*, i8** %l2
  %t39 = load i8, i8* %l3
  br i1 %t35, label %then8, label %else9
then8:
  store i8* null, i8** %l2
  br label %merge10
else9:
  %t40 = load i8, i8* %l3
  %t41 = icmp eq i8 %t40, 114
  %t42 = load i64, i64* %l0
  %t43 = load double, double* %l1
  %t44 = load i8*, i8** %l2
  %t45 = load i8, i8* %l3
  br i1 %t41, label %then11, label %else12
then11:
  store i8* null, i8** %l2
  br label %merge13
else12:
  %t46 = load i8, i8* %l3
  %t47 = icmp eq i8 %t46, 116
  %t48 = load i64, i64* %l0
  %t49 = load double, double* %l1
  %t50 = load i8*, i8** %l2
  %t51 = load i8, i8* %l3
  br i1 %t47, label %then14, label %merge15
then14:
  store i8* null, i8** %l2
  br label %merge15
merge15:
  %t52 = phi i8* [ null, %then14 ], [ %t50, %else12 ]
  store i8* %t52, i8** %l2
  br label %merge13
merge13:
  %t53 = phi i8* [ null, %then11 ], [ null, %else12 ]
  store i8* %t53, i8** %l2
  br label %merge10
merge10:
  %t54 = phi i8* [ null, %then8 ], [ null, %else9 ]
  store i8* %t54, i8** %l2
  br label %merge7
merge7:
  %t55 = phi i8* [ null, %then6 ], [ %t30, %entry ]
  %t56 = phi i8* [ null, %then6 ], [ %t30, %entry ]
  %t57 = phi i8* [ null, %then6 ], [ %t30, %entry ]
  store i8* %t55, i8** %l2
  store i8* %t56, i8** %l2
  store i8* %t57, i8** %l2
  %t58 = load double, double* %l1
  store double %t58, double* %l4
  %t59 = load i64, i64* %l0
  %t60 = load double, double* %l1
  %t61 = load i8*, i8** %l2
  %t62 = load double, double* %l4
  br label %loop.header16
loop.header16:
  %t88 = phi double [ %t62, %entry ], [ %t87, %loop.latch18 ]
  store double %t88, double* %l4
  br label %loop.body17
loop.body17:
  %t63 = load double, double* %l4
  %t64 = load i64, i64* %l0
  %t65 = sitofp i64 %t64 to double
  %t66 = fcmp oge double %t63, %t65
  %t67 = load i64, i64* %l0
  %t68 = load double, double* %l1
  %t69 = load i8*, i8** %l2
  %t70 = load double, double* %l4
  br i1 %t66, label %then20, label %merge21
then20:
  br label %afterloop19
merge21:
  %t71 = load double, double* %l4
  %t72 = fptosi double %t71 to i64
  %t73 = getelementptr i8, i8* %text, i64 %t72
  %t74 = load i8, i8* %t73
  %t75 = load i8*, i8** %l2
  %t76 = getelementptr i8, i8* %t75, i64 0
  %t77 = load i8, i8* %t76
  %t78 = icmp eq i8 %t74, %t77
  %t79 = load i64, i64* %l0
  %t80 = load double, double* %l1
  %t81 = load i8*, i8** %l2
  %t82 = load double, double* %l4
  br i1 %t78, label %then22, label %merge23
then22:
  %t83 = load double, double* %l4
  ret double %t83
merge23:
  %t84 = load double, double* %l4
  %t85 = sitofp i64 1 to double
  %t86 = fadd double %t84, %t85
  store double %t86, double* %l4
  br label %loop.latch18
loop.latch18:
  %t87 = load double, double* %l4
  br label %loop.header16
afterloop19:
  %t89 = sitofp i64 -1 to double
  ret double %t89
}

define void @match_exhaustive_failed(i8* %value) {
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
  %t0 = call i64 @sailfin_runtime_string_length(i8* %character)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = sitofp i64 -1 to double
  ret double %t2
merge1:
  %t3 = getelementptr i8, i8* %character, i64 0
  %t4 = load i8, i8* %t3
  store i8 %t4, i8* %l0
  %s5 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.5, i32 0, i32 0
  store i8* %s5, i8** %l1
  %t6 = load i8*, i8** %l1
  %t7 = load i8, i8* %l0
  %t8 = sitofp i64 0 to double
  %t9 = call double @find_char(i8* %t6, i8* null, double %t8)
  store double %t9, double* %l2
  %t10 = load double, double* %l2
  %t11 = sitofp i64 0 to double
  %t12 = fcmp oge double %t10, %t11
  %t13 = load i8, i8* %l0
  %t14 = load i8*, i8** %l1
  %t15 = load double, double* %l2
  br i1 %t12, label %then2, label %merge3
then2:
  %t16 = load double, double* %l2
  %t17 = sitofp i64 48 to double
  %t18 = fadd double %t17, %t16
  ret double %t18
merge3:
  %s19 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.19, i32 0, i32 0
  store i8* %s19, i8** %l3
  %t20 = load i8*, i8** %l3
  %t21 = load i8, i8* %l0
  %t22 = sitofp i64 0 to double
  %t23 = call double @find_char(i8* %t20, i8* null, double %t22)
  store double %t23, double* %l4
  %t24 = load double, double* %l4
  %t25 = sitofp i64 0 to double
  %t26 = fcmp oge double %t24, %t25
  %t27 = load i8, i8* %l0
  %t28 = load i8*, i8** %l1
  %t29 = load double, double* %l2
  %t30 = load i8*, i8** %l3
  %t31 = load double, double* %l4
  br i1 %t26, label %then4, label %merge5
then4:
  %t32 = load double, double* %l4
  %t33 = sitofp i64 97 to double
  %t34 = fadd double %t33, %t32
  ret double %t34
merge5:
  %s35 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.35, i32 0, i32 0
  store i8* %s35, i8** %l5
  %t36 = load i8*, i8** %l5
  %t37 = load i8, i8* %l0
  %t38 = sitofp i64 0 to double
  %t39 = call double @find_char(i8* %t36, i8* null, double %t38)
  store double %t39, double* %l6
  %t40 = load double, double* %l6
  %t41 = sitofp i64 0 to double
  %t42 = fcmp oge double %t40, %t41
  %t43 = load i8, i8* %l0
  %t44 = load i8*, i8** %l1
  %t45 = load double, double* %l2
  %t46 = load i8*, i8** %l3
  %t47 = load double, double* %l4
  %t48 = load i8*, i8** %l5
  %t49 = load double, double* %l6
  br i1 %t42, label %then6, label %merge7
then6:
  %t50 = load double, double* %l6
  %t51 = sitofp i64 65 to double
  %t52 = fadd double %t51, %t50
  ret double %t52
merge7:
  %t53 = load i8, i8* %l0
  %t54 = icmp eq i8 %t53, 32
  %t55 = load i8, i8* %l0
  %t56 = load i8*, i8** %l1
  %t57 = load double, double* %l2
  %t58 = load i8*, i8** %l3
  %t59 = load double, double* %l4
  %t60 = load i8*, i8** %l5
  %t61 = load double, double* %l6
  br i1 %t54, label %then8, label %merge9
then8:
  %t62 = sitofp i64 32 to double
  ret double %t62
merge9:
  %t63 = load i8, i8* %l0
  %t64 = icmp eq i8 %t63, 10
  %t65 = load i8, i8* %l0
  %t66 = load i8*, i8** %l1
  %t67 = load double, double* %l2
  %t68 = load i8*, i8** %l3
  %t69 = load double, double* %l4
  %t70 = load i8*, i8** %l5
  %t71 = load double, double* %l6
  br i1 %t64, label %then10, label %merge11
then10:
  %t72 = sitofp i64 10 to double
  ret double %t72
merge11:
  %t73 = load i8, i8* %l0
  %t74 = icmp eq i8 %t73, 13
  %t75 = load i8, i8* %l0
  %t76 = load i8*, i8** %l1
  %t77 = load double, double* %l2
  %t78 = load i8*, i8** %l3
  %t79 = load double, double* %l4
  %t80 = load i8*, i8** %l5
  %t81 = load double, double* %l6
  br i1 %t74, label %then12, label %merge13
then12:
  %t82 = sitofp i64 13 to double
  ret double %t82
merge13:
  %t83 = load i8, i8* %l0
  %t84 = icmp eq i8 %t83, 9
  %t85 = load i8, i8* %l0
  %t86 = load i8*, i8** %l1
  %t87 = load double, double* %l2
  %t88 = load i8*, i8** %l3
  %t89 = load double, double* %l4
  %t90 = load i8*, i8** %l5
  %t91 = load double, double* %l6
  br i1 %t84, label %then14, label %merge15
then14:
  %t92 = sitofp i64 9 to double
  ret double %t92
merge15:
  %t93 = load i8, i8* %l0
  %t94 = icmp eq i8 %t93, 34
  %t95 = load i8, i8* %l0
  %t96 = load i8*, i8** %l1
  %t97 = load double, double* %l2
  %t98 = load i8*, i8** %l3
  %t99 = load double, double* %l4
  %t100 = load i8*, i8** %l5
  %t101 = load double, double* %l6
  br i1 %t94, label %then16, label %merge17
then16:
  %t102 = sitofp i64 34 to double
  ret double %t102
merge17:
  %t103 = load i8, i8* %l0
  %t104 = icmp eq i8 %t103, 92
  %t105 = load i8, i8* %l0
  %t106 = load i8*, i8** %l1
  %t107 = load double, double* %l2
  %t108 = load i8*, i8** %l3
  %t109 = load double, double* %l4
  %t110 = load i8*, i8** %l5
  %t111 = load double, double* %l6
  br i1 %t104, label %then18, label %merge19
then18:
  %t112 = sitofp i64 92 to double
  ret double %t112
merge19:
  %t113 = load i8, i8* %l0
  %t114 = icmp eq i8 %t113, 95
  %t115 = load i8, i8* %l0
  %t116 = load i8*, i8** %l1
  %t117 = load double, double* %l2
  %t118 = load i8*, i8** %l3
  %t119 = load double, double* %l4
  %t120 = load i8*, i8** %l5
  %t121 = load double, double* %l6
  br i1 %t114, label %then20, label %merge21
then20:
  %t122 = sitofp i64 95 to double
  ret double %t122
merge21:
  %t123 = load i8, i8* %l0
  store double 0.0, double* %l7
  %t124 = load double, double* %l7
  store double 0.0, double* %l8
  %t125 = load double, double* %l8
  %t126 = sitofp i64 0 to double
  %t127 = fcmp oeq double %t125, %t126
  %t128 = load i8, i8* %l0
  %t129 = load i8*, i8** %l1
  %t130 = load double, double* %l2
  %t131 = load i8*, i8** %l3
  %t132 = load double, double* %l4
  %t133 = load i8*, i8** %l5
  %t134 = load double, double* %l6
  %t135 = load double, double* %l7
  %t136 = load double, double* %l8
  br i1 %t127, label %then22, label %merge23
then22:
  %t137 = sitofp i64 -1 to double
  ret double %t137
merge23:
  %t138 = load double, double* %l8
  %t139 = sitofp i64 4 to double
  %t140 = fcmp ogt double %t138, %t139
  %t141 = load i8, i8* %l0
  %t142 = load i8*, i8** %l1
  %t143 = load double, double* %l2
  %t144 = load i8*, i8** %l3
  %t145 = load double, double* %l4
  %t146 = load i8*, i8** %l5
  %t147 = load double, double* %l6
  %t148 = load double, double* %l7
  %t149 = load double, double* %l8
  br i1 %t140, label %then24, label %merge25
then24:
  %t150 = sitofp i64 -1 to double
  ret double %t150
merge25:
  store i64 0, i64* %l9
  store i64 0, i64* %l10
  %t151 = load i8, i8* %l0
  %t152 = load i8*, i8** %l1
  %t153 = load double, double* %l2
  %t154 = load i8*, i8** %l3
  %t155 = load double, double* %l4
  %t156 = load i8*, i8** %l5
  %t157 = load double, double* %l6
  %t158 = load double, double* %l7
  %t159 = load double, double* %l8
  %t160 = load i64, i64* %l9
  %t161 = load i64, i64* %l10
  br label %loop.header26
loop.header26:
  %t318 = phi i64 [ %t161, %entry ], [ %t316, %loop.latch28 ]
  %t319 = phi i64 [ %t160, %entry ], [ %t317, %loop.latch28 ]
  store i64 %t318, i64* %l10
  store i64 %t319, i64* %l9
  br label %loop.body27
loop.body27:
  %t162 = load i64, i64* %l9
  %t163 = load double, double* %l8
  %t164 = sitofp i64 %t162 to double
  %t165 = fcmp oge double %t164, %t163
  %t166 = load i8, i8* %l0
  %t167 = load i8*, i8** %l1
  %t168 = load double, double* %l2
  %t169 = load i8*, i8** %l3
  %t170 = load double, double* %l4
  %t171 = load i8*, i8** %l5
  %t172 = load double, double* %l6
  %t173 = load double, double* %l7
  %t174 = load double, double* %l8
  %t175 = load i64, i64* %l9
  %t176 = load i64, i64* %l10
  br i1 %t165, label %then30, label %merge31
then30:
  br label %afterloop29
merge31:
  %t177 = load double, double* %l7
  %t178 = load i64, i64* %l9
  store double 0.0, double* %l11
  %t179 = load i64, i64* %l9
  %t180 = icmp eq i64 %t179, 0
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
  br i1 %t180, label %then32, label %else33
then32:
  %t193 = load double, double* %l11
  %t194 = sitofp i64 128 to double
  %t195 = fcmp olt double %t193, %t194
  %t196 = load i8, i8* %l0
  %t197 = load i8*, i8** %l1
  %t198 = load double, double* %l2
  %t199 = load i8*, i8** %l3
  %t200 = load double, double* %l4
  %t201 = load i8*, i8** %l5
  %t202 = load double, double* %l6
  %t203 = load double, double* %l7
  %t204 = load double, double* %l8
  %t205 = load i64, i64* %l9
  %t206 = load i64, i64* %l10
  %t207 = load double, double* %l11
  br i1 %t195, label %then35, label %merge36
then35:
  %t208 = load double, double* %l11
  ret double %t208
merge36:
  %t210 = load double, double* %l11
  %t211 = sitofp i64 192 to double
  %t212 = fcmp oge double %t210, %t211
  br label %logical_and_entry_209

logical_and_entry_209:
  br i1 %t212, label %logical_and_right_209, label %logical_and_merge_209

logical_and_right_209:
  %t213 = load double, double* %l11
  %t214 = sitofp i64 223 to double
  %t215 = fcmp ole double %t213, %t214
  br label %logical_and_right_end_209

logical_and_right_end_209:
  br label %logical_and_merge_209

logical_and_merge_209:
  %t216 = phi i1 [ false, %logical_and_entry_209 ], [ %t215, %logical_and_right_end_209 ]
  %t217 = load i8, i8* %l0
  %t218 = load i8*, i8** %l1
  %t219 = load double, double* %l2
  %t220 = load i8*, i8** %l3
  %t221 = load double, double* %l4
  %t222 = load i8*, i8** %l5
  %t223 = load double, double* %l6
  %t224 = load double, double* %l7
  %t225 = load double, double* %l8
  %t226 = load i64, i64* %l9
  %t227 = load i64, i64* %l10
  %t228 = load double, double* %l11
  br i1 %t216, label %then37, label %else38
then37:
  %t229 = load double, double* %l11
  %t230 = sitofp i64 192 to double
  %t231 = fsub double %t229, %t230
  %t232 = fptosi double %t231 to i64
  store i64 %t232, i64* %l10
  br label %merge39
else38:
  %t234 = load double, double* %l11
  %t235 = sitofp i64 224 to double
  %t236 = fcmp oge double %t234, %t235
  br label %logical_and_entry_233

logical_and_entry_233:
  br i1 %t236, label %logical_and_right_233, label %logical_and_merge_233

logical_and_right_233:
  %t237 = load double, double* %l11
  %t238 = sitofp i64 239 to double
  %t239 = fcmp ole double %t237, %t238
  br label %logical_and_right_end_233

logical_and_right_end_233:
  br label %logical_and_merge_233

logical_and_merge_233:
  %t240 = phi i1 [ false, %logical_and_entry_233 ], [ %t239, %logical_and_right_end_233 ]
  %t241 = load i8, i8* %l0
  %t242 = load i8*, i8** %l1
  %t243 = load double, double* %l2
  %t244 = load i8*, i8** %l3
  %t245 = load double, double* %l4
  %t246 = load i8*, i8** %l5
  %t247 = load double, double* %l6
  %t248 = load double, double* %l7
  %t249 = load double, double* %l8
  %t250 = load i64, i64* %l9
  %t251 = load i64, i64* %l10
  %t252 = load double, double* %l11
  br i1 %t240, label %then40, label %else41
then40:
  %t253 = load double, double* %l11
  %t254 = sitofp i64 224 to double
  %t255 = fsub double %t253, %t254
  %t256 = fptosi double %t255 to i64
  store i64 %t256, i64* %l10
  br label %merge42
else41:
  %t258 = load double, double* %l11
  %t259 = sitofp i64 240 to double
  %t260 = fcmp oge double %t258, %t259
  br label %logical_and_entry_257

logical_and_entry_257:
  br i1 %t260, label %logical_and_right_257, label %logical_and_merge_257

logical_and_right_257:
  %t261 = load double, double* %l11
  %t262 = sitofp i64 247 to double
  %t263 = fcmp ole double %t261, %t262
  br label %logical_and_right_end_257

logical_and_right_end_257:
  br label %logical_and_merge_257

logical_and_merge_257:
  %t264 = phi i1 [ false, %logical_and_entry_257 ], [ %t263, %logical_and_right_end_257 ]
  %t265 = load i8, i8* %l0
  %t266 = load i8*, i8** %l1
  %t267 = load double, double* %l2
  %t268 = load i8*, i8** %l3
  %t269 = load double, double* %l4
  %t270 = load i8*, i8** %l5
  %t271 = load double, double* %l6
  %t272 = load double, double* %l7
  %t273 = load double, double* %l8
  %t274 = load i64, i64* %l9
  %t275 = load i64, i64* %l10
  %t276 = load double, double* %l11
  br i1 %t264, label %then43, label %else44
then43:
  %t277 = load double, double* %l11
  %t278 = sitofp i64 240 to double
  %t279 = fsub double %t277, %t278
  %t280 = fptosi double %t279 to i64
  store i64 %t280, i64* %l10
  br label %merge45
else44:
  %t281 = sitofp i64 -1 to double
  ret double %t281
merge45:
  br label %merge42
merge42:
  %t282 = phi i64 [ %t256, %then40 ], [ %t280, %else41 ]
  store i64 %t282, i64* %l10
  br label %merge39
merge39:
  %t283 = phi i64 [ %t232, %then37 ], [ %t256, %else38 ]
  store i64 %t283, i64* %l10
  br label %merge34
else33:
  %t285 = load double, double* %l11
  %t286 = sitofp i64 128 to double
  %t287 = fcmp olt double %t285, %t286
  br label %logical_or_entry_284

logical_or_entry_284:
  br i1 %t287, label %logical_or_merge_284, label %logical_or_right_284

logical_or_right_284:
  %t288 = load double, double* %l11
  %t289 = sitofp i64 191 to double
  %t290 = fcmp ogt double %t288, %t289
  br label %logical_or_right_end_284

logical_or_right_end_284:
  br label %logical_or_merge_284

logical_or_merge_284:
  %t291 = phi i1 [ true, %logical_or_entry_284 ], [ %t290, %logical_or_right_end_284 ]
  %t292 = load i8, i8* %l0
  %t293 = load i8*, i8** %l1
  %t294 = load double, double* %l2
  %t295 = load i8*, i8** %l3
  %t296 = load double, double* %l4
  %t297 = load i8*, i8** %l5
  %t298 = load double, double* %l6
  %t299 = load double, double* %l7
  %t300 = load double, double* %l8
  %t301 = load i64, i64* %l9
  %t302 = load i64, i64* %l10
  %t303 = load double, double* %l11
  br i1 %t291, label %then46, label %merge47
then46:
  %t304 = sitofp i64 -1 to double
  ret double %t304
merge47:
  %t305 = load i64, i64* %l10
  %t306 = mul i64 %t305, 64
  %t307 = load double, double* %l11
  %t308 = sitofp i64 128 to double
  %t309 = fsub double %t307, %t308
  %t310 = sitofp i64 %t306 to double
  %t311 = fadd double %t310, %t309
  %t312 = fptosi double %t311 to i64
  store i64 %t312, i64* %l10
  br label %merge34
merge34:
  %t313 = phi i64 [ %t232, %then32 ], [ %t312, %else33 ]
  store i64 %t313, i64* %l10
  %t314 = load i64, i64* %l9
  %t315 = add i64 %t314, 1
  store i64 %t315, i64* %l9
  br label %loop.latch28
loop.latch28:
  %t316 = load i64, i64* %l10
  %t317 = load i64, i64* %l9
  br label %loop.header26
afterloop29:
  %t320 = load i64, i64* %l10
  %t321 = sitofp i64 %t320 to double
  ret double %t321
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
  %t5 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t6 = icmp eq i64 %t5, 0
  %t7 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br i1 %t6, label %then0, label %merge1
then0:
  %t8 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t8
merge1:
  %t9 = getelementptr i8, i8* %text, i64 0
  %t10 = load i8, i8* %t9
  store i8 %t10, i8* %l1
  %t11 = load i8, i8* %l1
  %t12 = call double @char_code(i8* null)
  store double %t12, double* %l2
  %t13 = load double, double* %l2
  store double 0.0, double* %l3
  %t14 = load double, double* %l2
  %t15 = call i1 @is_regional_indicator(double %t14)
  store i1 %t15, i1* %l4
  store i64 0, i64* %l5
  %t16 = load i1, i1* %l4
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = load i8, i8* %l1
  %t19 = load double, double* %l2
  %t20 = load double, double* %l3
  %t21 = load i1, i1* %l4
  %t22 = load i64, i64* %l5
  br i1 %t16, label %then2, label %merge3
then2:
  store i64 1, i64* %l5
  br label %merge3
merge3:
  %t23 = phi i64 [ 1, %then2 ], [ %t22, %entry ]
  store i64 %t23, i64* %l5
  store i64 1, i64* %l6
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t25 = load i8, i8* %l1
  %t26 = load double, double* %l2
  %t27 = load double, double* %l3
  %t28 = load i1, i1* %l4
  %t29 = load i64, i64* %l5
  %t30 = load i64, i64* %l6
  br label %loop.header4
loop.header4:
  %t288 = phi { i8**, i64 }* [ %t24, %entry ], [ %t281, %loop.latch6 ]
  %t289 = phi i8 [ %t25, %entry ], [ %t282, %loop.latch6 ]
  %t290 = phi i64 [ %t29, %entry ], [ %t283, %loop.latch6 ]
  %t291 = phi double [ %t26, %entry ], [ %t284, %loop.latch6 ]
  %t292 = phi double [ %t27, %entry ], [ %t285, %loop.latch6 ]
  %t293 = phi i1 [ %t28, %entry ], [ %t286, %loop.latch6 ]
  %t294 = phi i64 [ %t30, %entry ], [ %t287, %loop.latch6 ]
  store { i8**, i64 }* %t288, { i8**, i64 }** %l0
  store i8 %t289, i8* %l1
  store i64 %t290, i64* %l5
  store double %t291, double* %l2
  store double %t292, double* %l3
  store i1 %t293, i1* %l4
  store i64 %t294, i64* %l6
  br label %loop.body5
loop.body5:
  %t31 = load i64, i64* %l6
  %t32 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t33 = icmp sge i64 %t31, %t32
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t35 = load i8, i8* %l1
  %t36 = load double, double* %l2
  %t37 = load double, double* %l3
  %t38 = load i1, i1* %l4
  %t39 = load i64, i64* %l5
  %t40 = load i64, i64* %l6
  br i1 %t33, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t41 = load i64, i64* %l6
  %t42 = getelementptr i8, i8* %text, i64 %t41
  %t43 = load i8, i8* %t42
  store i8 %t43, i8* %l7
  %t44 = load i8, i8* %l7
  %t45 = call double @char_code(i8* null)
  store double %t45, double* %l8
  %t46 = load double, double* %l8
  store double 0.0, double* %l9
  %t47 = load double, double* %l8
  %t48 = call i1 @is_grapheme_extend(double %t47)
  store i1 %t48, i1* %l10
  %t49 = load double, double* %l8
  %t50 = call i1 @is_regional_indicator(double %t49)
  store i1 %t50, i1* %l11
  store i1 0, i1* %l12
  %t52 = load double, double* %l2
  %t53 = sitofp i64 13 to double
  %t54 = fcmp oeq double %t52, %t53
  br label %logical_and_entry_51

logical_and_entry_51:
  br i1 %t54, label %logical_and_right_51, label %logical_and_merge_51

logical_and_right_51:
  %t55 = load double, double* %l8
  %t56 = sitofp i64 10 to double
  %t57 = fcmp oeq double %t55, %t56
  br label %logical_and_right_end_51

logical_and_right_end_51:
  br label %logical_and_merge_51

logical_and_merge_51:
  %t58 = phi i1 [ false, %logical_and_entry_51 ], [ %t57, %logical_and_right_end_51 ]
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t60 = load i8, i8* %l1
  %t61 = load double, double* %l2
  %t62 = load double, double* %l3
  %t63 = load i1, i1* %l4
  %t64 = load i64, i64* %l5
  %t65 = load i64, i64* %l6
  %t66 = load i8, i8* %l7
  %t67 = load double, double* %l8
  %t68 = load double, double* %l9
  %t69 = load i1, i1* %l10
  %t70 = load i1, i1* %l11
  %t71 = load i1, i1* %l12
  br i1 %t58, label %then10, label %else11
then10:
  store i1 0, i1* %l12
  br label %merge12
else11:
  %t72 = load double, double* %l3
  %t73 = fcmp one double %t72, 0.0
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t75 = load i8, i8* %l1
  %t76 = load double, double* %l2
  %t77 = load double, double* %l3
  %t78 = load i1, i1* %l4
  %t79 = load i64, i64* %l5
  %t80 = load i64, i64* %l6
  %t81 = load i8, i8* %l7
  %t82 = load double, double* %l8
  %t83 = load double, double* %l9
  %t84 = load i1, i1* %l10
  %t85 = load i1, i1* %l11
  %t86 = load i1, i1* %l12
  br i1 %t73, label %then13, label %else14
then13:
  store i1 0, i1* %l12
  br label %merge15
else14:
  %t87 = load double, double* %l9
  %t88 = fcmp one double %t87, 0.0
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t90 = load i8, i8* %l1
  %t91 = load double, double* %l2
  %t92 = load double, double* %l3
  %t93 = load i1, i1* %l4
  %t94 = load i64, i64* %l5
  %t95 = load i64, i64* %l6
  %t96 = load i8, i8* %l7
  %t97 = load double, double* %l8
  %t98 = load double, double* %l9
  %t99 = load i1, i1* %l10
  %t100 = load i1, i1* %l11
  %t101 = load i1, i1* %l12
  br i1 %t88, label %then16, label %else17
then16:
  store i1 0, i1* %l12
  br label %merge18
else17:
  %t102 = load i1, i1* %l10
  %t103 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t104 = load i8, i8* %l1
  %t105 = load double, double* %l2
  %t106 = load double, double* %l3
  %t107 = load i1, i1* %l4
  %t108 = load i64, i64* %l5
  %t109 = load i64, i64* %l6
  %t110 = load i8, i8* %l7
  %t111 = load double, double* %l8
  %t112 = load double, double* %l9
  %t113 = load i1, i1* %l10
  %t114 = load i1, i1* %l11
  %t115 = load i1, i1* %l12
  br i1 %t102, label %then19, label %else20
then19:
  store i1 0, i1* %l12
  br label %merge21
else20:
  %t118 = load i1, i1* %l11
  br label %logical_and_entry_117

logical_and_entry_117:
  br i1 %t118, label %logical_and_right_117, label %logical_and_merge_117

logical_and_right_117:
  %t119 = load i1, i1* %l4
  br label %logical_and_right_end_117

logical_and_right_end_117:
  br label %logical_and_merge_117

logical_and_merge_117:
  %t120 = phi i1 [ false, %logical_and_entry_117 ], [ %t119, %logical_and_right_end_117 ]
  br label %logical_and_entry_116

logical_and_entry_116:
  br i1 %t120, label %logical_and_right_116, label %logical_and_merge_116

logical_and_right_116:
  %t121 = load i64, i64* %l5
  %t122 = srem i64 %t121, 2
  %t123 = icmp eq i64 %t122, 1
  br label %logical_and_right_end_116

logical_and_right_end_116:
  br label %logical_and_merge_116

logical_and_merge_116:
  %t124 = phi i1 [ false, %logical_and_entry_116 ], [ %t123, %logical_and_right_end_116 ]
  %t125 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t126 = load i8, i8* %l1
  %t127 = load double, double* %l2
  %t128 = load double, double* %l3
  %t129 = load i1, i1* %l4
  %t130 = load i64, i64* %l5
  %t131 = load i64, i64* %l6
  %t132 = load i8, i8* %l7
  %t133 = load double, double* %l8
  %t134 = load double, double* %l9
  %t135 = load i1, i1* %l10
  %t136 = load i1, i1* %l11
  %t137 = load i1, i1* %l12
  br i1 %t124, label %then22, label %else23
then22:
  store i1 0, i1* %l12
  br label %merge24
else23:
  store i1 1, i1* %l12
  br label %merge24
merge24:
  %t138 = phi i1 [ 0, %then22 ], [ 1, %else23 ]
  store i1 %t138, i1* %l12
  br label %merge21
merge21:
  %t139 = phi i1 [ 0, %then19 ], [ 0, %else20 ]
  store i1 %t139, i1* %l12
  br label %merge18
merge18:
  %t140 = phi i1 [ 0, %then16 ], [ 0, %else17 ]
  store i1 %t140, i1* %l12
  br label %merge15
merge15:
  %t141 = phi i1 [ 0, %then13 ], [ 0, %else14 ]
  store i1 %t141, i1* %l12
  br label %merge12
merge12:
  %t142 = phi i1 [ 0, %then10 ], [ 0, %else11 ]
  store i1 %t142, i1* %l12
  %t143 = load i1, i1* %l12
  %t144 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t145 = load i8, i8* %l1
  %t146 = load double, double* %l2
  %t147 = load double, double* %l3
  %t148 = load i1, i1* %l4
  %t149 = load i64, i64* %l5
  %t150 = load i64, i64* %l6
  %t151 = load i8, i8* %l7
  %t152 = load double, double* %l8
  %t153 = load double, double* %l9
  %t154 = load i1, i1* %l10
  %t155 = load i1, i1* %l11
  %t156 = load i1, i1* %l12
  br i1 %t143, label %then25, label %else26
then25:
  %t157 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t158 = load i8, i8* %l1
  %t159 = alloca [1 x i8]
  %t160 = getelementptr [1 x i8], [1 x i8]* %t159, i32 0, i32 0
  %t161 = getelementptr i8, i8* %t160, i64 0
  store i8 %t158, i8* %t161
  %t162 = alloca { i8*, i64 }
  %t163 = getelementptr { i8*, i64 }, { i8*, i64 }* %t162, i32 0, i32 0
  store i8* %t160, i8** %t163
  %t164 = getelementptr { i8*, i64 }, { i8*, i64 }* %t162, i32 0, i32 1
  store i64 1, i64* %t164
  %t165 = bitcast { i8*, i64 }* %t162 to { i8**, i64 }*
  %t166 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t157, { i8**, i64 }* %t165)
  store { i8**, i64 }* %t166, { i8**, i64 }** %l0
  %t167 = load i8, i8* %l7
  store i8 %t167, i8* %l1
  %t168 = load i1, i1* %l11
  %t169 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t170 = load i8, i8* %l1
  %t171 = load double, double* %l2
  %t172 = load double, double* %l3
  %t173 = load i1, i1* %l4
  %t174 = load i64, i64* %l5
  %t175 = load i64, i64* %l6
  %t176 = load i8, i8* %l7
  %t177 = load double, double* %l8
  %t178 = load double, double* %l9
  %t179 = load i1, i1* %l10
  %t180 = load i1, i1* %l11
  %t181 = load i1, i1* %l12
  br i1 %t168, label %then28, label %else29
then28:
  store i64 1, i64* %l5
  br label %merge30
else29:
  store i64 0, i64* %l5
  br label %merge30
merge30:
  %t182 = phi i64 [ 1, %then28 ], [ 0, %else29 ]
  store i64 %t182, i64* %l5
  br label %merge27
else26:
  %t183 = load i8, i8* %l1
  %t184 = load i8, i8* %l7
  %t185 = add i8 %t183, %t184
  store i8 %t185, i8* %l1
  %t186 = load i1, i1* %l11
  %t187 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t188 = load i8, i8* %l1
  %t189 = load double, double* %l2
  %t190 = load double, double* %l3
  %t191 = load i1, i1* %l4
  %t192 = load i64, i64* %l5
  %t193 = load i64, i64* %l6
  %t194 = load i8, i8* %l7
  %t195 = load double, double* %l8
  %t196 = load double, double* %l9
  %t197 = load i1, i1* %l10
  %t198 = load i1, i1* %l11
  %t199 = load i1, i1* %l12
  br i1 %t186, label %then31, label %else32
then31:
  %t200 = load i64, i64* %l5
  %t201 = add i64 %t200, 1
  store i64 %t201, i64* %l5
  br label %merge33
else32:
  %t203 = load double, double* %l9
  %t204 = fcmp one double %t203, 0.0
  br label %logical_and_entry_202

logical_and_entry_202:
  br i1 %t204, label %logical_and_right_202, label %logical_and_merge_202

logical_and_right_202:
  %t205 = load i1, i1* %l10
  %t206 = xor i1 %t205, 1
  br label %logical_and_right_end_202

logical_and_right_end_202:
  br label %logical_and_merge_202

logical_and_merge_202:
  %t207 = phi i1 [ false, %logical_and_entry_202 ], [ %t206, %logical_and_right_end_202 ]
  %t208 = xor i1 %t207, 1
  %t209 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t210 = load i8, i8* %l1
  %t211 = load double, double* %l2
  %t212 = load double, double* %l3
  %t213 = load i1, i1* %l4
  %t214 = load i64, i64* %l5
  %t215 = load i64, i64* %l6
  %t216 = load i8, i8* %l7
  %t217 = load double, double* %l8
  %t218 = load double, double* %l9
  %t219 = load i1, i1* %l10
  %t220 = load i1, i1* %l11
  %t221 = load i1, i1* %l12
  br i1 %t208, label %then34, label %merge35
then34:
  store i64 0, i64* %l5
  br label %merge35
merge35:
  %t222 = phi i64 [ 0, %then34 ], [ %t214, %else32 ]
  store i64 %t222, i64* %l5
  br label %merge33
merge33:
  %t223 = phi i64 [ %t201, %then31 ], [ 0, %else32 ]
  store i64 %t223, i64* %l5
  br label %merge27
merge27:
  %t224 = phi { i8**, i64 }* [ %t166, %then25 ], [ %t144, %else26 ]
  %t225 = phi i8 [ %t167, %then25 ], [ %t185, %else26 ]
  %t226 = phi i64 [ 1, %then25 ], [ %t201, %else26 ]
  store { i8**, i64 }* %t224, { i8**, i64 }** %l0
  store i8 %t225, i8* %l1
  store i64 %t226, i64* %l5
  %t227 = load double, double* %l8
  store double %t227, double* %l2
  %t228 = load double, double* %l9
  store double %t228, double* %l3
  %t229 = load double, double* %l9
  %t230 = fcmp one double %t229, 0.0
  %t231 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t232 = load i8, i8* %l1
  %t233 = load double, double* %l2
  %t234 = load double, double* %l3
  %t235 = load i1, i1* %l4
  %t236 = load i64, i64* %l5
  %t237 = load i64, i64* %l6
  %t238 = load i8, i8* %l7
  %t239 = load double, double* %l8
  %t240 = load double, double* %l9
  %t241 = load i1, i1* %l10
  %t242 = load i1, i1* %l11
  %t243 = load i1, i1* %l12
  br i1 %t230, label %then36, label %else37
then36:
  store i1 0, i1* %l4
  store i64 0, i64* %l5
  br label %merge38
else37:
  %t244 = load i1, i1* %l10
  %t245 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t246 = load i8, i8* %l1
  %t247 = load double, double* %l2
  %t248 = load double, double* %l3
  %t249 = load i1, i1* %l4
  %t250 = load i64, i64* %l5
  %t251 = load i64, i64* %l6
  %t252 = load i8, i8* %l7
  %t253 = load double, double* %l8
  %t254 = load double, double* %l9
  %t255 = load i1, i1* %l10
  %t256 = load i1, i1* %l11
  %t257 = load i1, i1* %l12
  br i1 %t244, label %then39, label %else40
then39:
  br label %merge41
else40:
  %t258 = load i1, i1* %l11
  store i1 %t258, i1* %l4
  %t259 = load i1, i1* %l11
  %t260 = xor i1 %t259, 1
  %t261 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t262 = load i8, i8* %l1
  %t263 = load double, double* %l2
  %t264 = load double, double* %l3
  %t265 = load i1, i1* %l4
  %t266 = load i64, i64* %l5
  %t267 = load i64, i64* %l6
  %t268 = load i8, i8* %l7
  %t269 = load double, double* %l8
  %t270 = load double, double* %l9
  %t271 = load i1, i1* %l10
  %t272 = load i1, i1* %l11
  %t273 = load i1, i1* %l12
  br i1 %t260, label %then42, label %merge43
then42:
  store i64 0, i64* %l5
  br label %merge43
merge43:
  %t274 = phi i64 [ 0, %then42 ], [ %t266, %else40 ]
  store i64 %t274, i64* %l5
  br label %merge41
merge41:
  %t275 = phi i1 [ %t249, %then39 ], [ %t258, %else40 ]
  %t276 = phi i64 [ %t250, %then39 ], [ 0, %else40 ]
  store i1 %t275, i1* %l4
  store i64 %t276, i64* %l5
  br label %merge38
merge38:
  %t277 = phi i1 [ 0, %then36 ], [ %t258, %else37 ]
  %t278 = phi i64 [ 0, %then36 ], [ 0, %else37 ]
  store i1 %t277, i1* %l4
  store i64 %t278, i64* %l5
  %t279 = load i64, i64* %l6
  %t280 = add i64 %t279, 1
  store i64 %t280, i64* %l6
  br label %loop.latch6
loop.latch6:
  %t281 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t282 = load i8, i8* %l1
  %t283 = load i64, i64* %l5
  %t284 = load double, double* %l2
  %t285 = load double, double* %l3
  %t286 = load i1, i1* %l4
  %t287 = load i64, i64* %l6
  br label %loop.header4
afterloop7:
  %t295 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t296 = load i8, i8* %l1
  %t297 = alloca [1 x i8]
  %t298 = getelementptr [1 x i8], [1 x i8]* %t297, i32 0, i32 0
  %t299 = getelementptr i8, i8* %t298, i64 0
  store i8 %t296, i8* %t299
  %t300 = alloca { i8*, i64 }
  %t301 = getelementptr { i8*, i64 }, { i8*, i64 }* %t300, i32 0, i32 0
  store i8* %t298, i8** %t301
  %t302 = getelementptr { i8*, i64 }, { i8*, i64 }* %t300, i32 0, i32 1
  store i64 1, i64* %t302
  %t303 = bitcast { i8*, i64 }* %t300 to { i8**, i64 }*
  %t304 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t295, { i8**, i64 }* %t303)
  store { i8**, i64 }* %t304, { i8**, i64 }** %l0
  %t305 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t305
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
  %t12 = fptosi double %index to i64
  %t13 = load { i8**, i64 }, { i8**, i64 }* %t11
  %t14 = extractvalue { i8**, i64 } %t13, 0
  %t15 = extractvalue { i8**, i64 } %t13, 1
  %t16 = icmp uge i64 %t12, %t15
  ; bounds check: %t16 (if true, out of bounds)
  %t17 = getelementptr i8*, i8** %t14, i64 %t12
  %t18 = load i8*, i8** %t17
  ret i8* %t18
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
