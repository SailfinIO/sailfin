; ModuleID = 'sailfin'
source_filename = "sailfin"

%EnumField = type { i8*, i8* }
%EnumVariantDefinition = type { i8*, { i8**, i64 }* }
%EnumType = type { i8*, { %EnumVariantDefinition**, i64 }* }
%EnumInstance = type { %EnumType*, i8*, { %EnumField**, i64 }* }
%StructField = type { i8*, i8* }
%TypeDescriptor = type { i8*, i8*, { %TypeDescriptor**, i64 }* }

declare i8* @sailfin_runtime_substring(i8*, i64, i64)

declare noalias i8* @malloc(i64)

@.str.0 = private unnamed_addr constant [1 x i8] c"\00"
@.str.5 = private unnamed_addr constant [11 x i8] c"0123456789\00"
@.str.19 = private unnamed_addr constant [27 x i8] c"abcdefghijklmnopqrstuvwxyz\00"
@.str.35 = private unnamed_addr constant [27 x i8] c"ABCDEFGHIJKLMNOPQRSTUVWXYZ\00"
@.str.138 = private unnamed_addr constant [6 x i8] c"utf-8\00"

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

define i8* @char_at(i8* %value, double %index) {
entry:
  %t0 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  %s2 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.2, i32 0, i32 0
  ret i8* %s2
merge1:
  %t3 = sitofp i64 0 to double
  %t4 = fcmp olt double %index, %t3
  br i1 %t4, label %then2, label %merge3
then2:
  %s5 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.5, i32 0, i32 0
  ret i8* %s5
merge3:
  %t6 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t7 = sitofp i64 %t6 to double
  %t8 = fcmp oge double %index, %t7
  br i1 %t8, label %then4, label %merge5
then4:
  %s9 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.9, i32 0, i32 0
  ret i8* %s9
merge5:
  ret i8* null
}

define %EnumType @enum_type(i8* %name) {
entry:
  %t0 = insertvalue %EnumType undef, i8* %name, 0
  %t1 = alloca [0 x %EnumVariantDefinition*]
  %t2 = getelementptr [0 x %EnumVariantDefinition*], [0 x %EnumVariantDefinition*]* %t1, i32 0, i32 0
  %t3 = alloca { %EnumVariantDefinition**, i64 }
  %t4 = getelementptr { %EnumVariantDefinition**, i64 }, { %EnumVariantDefinition**, i64 }* %t3, i32 0, i32 0
  store %EnumVariantDefinition** %t2, %EnumVariantDefinition*** %t4
  %t5 = getelementptr { %EnumVariantDefinition**, i64 }, { %EnumVariantDefinition**, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  %t6 = insertvalue %EnumType %t0, { %EnumVariantDefinition**, i64 }* %t3, 1
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
  %t10 = bitcast { %EnumVariantDefinition**, i64 }* %t2 to { i8**, i64 }*
  %t11 = bitcast { %EnumVariantDefinition*, i64 }* %t7 to { i8**, i64 }*
  %t12 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t10, { i8**, i64 }* %t11)
  store { i8**, i64 }* %t12, { i8**, i64 }** %l1
  %t13 = extractvalue %EnumType %enum_type, 0
  %t14 = insertvalue %EnumType undef, i8* %t13, 0
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t16 = bitcast { i8**, i64 }* %t15 to { %EnumVariantDefinition**, i64 }*
  %t17 = insertvalue %EnumType %t14, { %EnumVariantDefinition**, i64 }* %t16, 1
  ret %EnumType %t17
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
  %t3 = insertvalue %EnumInstance undef, %EnumType* null, 0
  %t4 = insertvalue %EnumInstance %t3, i8* %variant_name, 1
  %t5 = load { %EnumField*, i64 }*, { %EnumField*, i64 }** %l1
  %t6 = bitcast { %EnumField*, i64 }* %t5 to { %EnumField**, i64 }*
  %t7 = insertvalue %EnumInstance %t4, { %EnumField**, i64 }* %t6, 2
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
  %t49 = add i8 %t48, 41
  store i8 %t49, i8* %l0
  %t50 = load i8, i8* %l0
  %t51 = alloca [2 x i8], align 1
  %t52 = getelementptr [2 x i8], [2 x i8]* %t51, i32 0, i32 0
  store i8 %t50, i8* %t52
  %t53 = getelementptr [2 x i8], [2 x i8]* %t51, i32 0, i32 1
  store i8 0, i8* %t53
  %t54 = getelementptr [2 x i8], [2 x i8]* %t51, i32 0, i32 0
  ret i8* %t54
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
  %t2 = bitcast { %TypeDescriptor*, i64 }* %items to { %TypeDescriptor**, i64 }*
  %t3 = insertvalue %TypeDescriptor %t1, { %TypeDescriptor**, i64 }* %t2, 2
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
  %l2 = alloca i8*
  %l3 = alloca i8*
  store i64 0, i64* %l0
  %t0 = call i64 @sailfin_runtime_string_length(i8* %value)
  store i64 %t0, i64* %l1
  %t1 = load i64, i64* %l0
  %t2 = load i64, i64* %l1
  br label %loop.header0
loop.header0:
  %t39 = phi i64 [ %t1, %entry ], [ %t38, %loop.latch2 ]
  store i64 %t39, i64* %l0
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
  %t9 = sitofp i64 %t8 to double
  %t10 = call i8* @char_at(i8* %value, double %t9)
  store i8* %t10, i8** %l2
  %t12 = load i8*, i8** %l2
  %t13 = getelementptr i8, i8* %t12, i64 0
  %t14 = load i8, i8* %t13
  %t15 = icmp eq i8 %t14, 32
  br label %logical_or_entry_11

logical_or_entry_11:
  br i1 %t15, label %logical_or_merge_11, label %logical_or_right_11

logical_or_right_11:
  %t17 = load i8*, i8** %l2
  %t18 = getelementptr i8, i8* %t17, i64 0
  %t19 = load i8, i8* %t18
  %t20 = icmp eq i8 %t19, 10
  br label %logical_or_entry_16

logical_or_entry_16:
  br i1 %t20, label %logical_or_merge_16, label %logical_or_right_16

logical_or_right_16:
  %t22 = load i8*, i8** %l2
  %t23 = getelementptr i8, i8* %t22, i64 0
  %t24 = load i8, i8* %t23
  %t25 = icmp eq i8 %t24, 9
  br label %logical_or_entry_21

logical_or_entry_21:
  br i1 %t25, label %logical_or_merge_21, label %logical_or_right_21

logical_or_right_21:
  %t26 = load i8*, i8** %l2
  %t27 = getelementptr i8, i8* %t26, i64 0
  %t28 = load i8, i8* %t27
  %t29 = icmp eq i8 %t28, 13
  br label %logical_or_right_end_21

logical_or_right_end_21:
  br label %logical_or_merge_21

logical_or_merge_21:
  %t30 = phi i1 [ true, %logical_or_entry_21 ], [ %t29, %logical_or_right_end_21 ]
  br label %logical_or_right_end_16

logical_or_right_end_16:
  br label %logical_or_merge_16

logical_or_merge_16:
  %t31 = phi i1 [ true, %logical_or_entry_16 ], [ %t30, %logical_or_right_end_16 ]
  br label %logical_or_right_end_11

logical_or_right_end_11:
  br label %logical_or_merge_11

logical_or_merge_11:
  %t32 = phi i1 [ true, %logical_or_entry_11 ], [ %t31, %logical_or_right_end_11 ]
  %t33 = load i64, i64* %l0
  %t34 = load i64, i64* %l1
  %t35 = load i8*, i8** %l2
  br i1 %t32, label %then6, label %merge7
then6:
  %t36 = load i64, i64* %l0
  %t37 = add i64 %t36, 1
  store i64 %t37, i64* %l0
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  %t38 = load i64, i64* %l0
  br label %loop.header0
afterloop3:
  %t40 = load i64, i64* %l0
  %t41 = load i64, i64* %l1
  br label %loop.header8
loop.header8:
  %t79 = phi i64 [ %t41, %entry ], [ %t78, %loop.latch10 ]
  store i64 %t79, i64* %l1
  br label %loop.body9
loop.body9:
  %t42 = load i64, i64* %l1
  %t43 = load i64, i64* %l0
  %t44 = icmp sle i64 %t42, %t43
  %t45 = load i64, i64* %l0
  %t46 = load i64, i64* %l1
  br i1 %t44, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t47 = load i64, i64* %l1
  %t48 = sub i64 %t47, 1
  %t49 = sitofp i64 %t48 to double
  %t50 = call i8* @char_at(i8* %value, double %t49)
  store i8* %t50, i8** %l3
  %t52 = load i8*, i8** %l3
  %t53 = getelementptr i8, i8* %t52, i64 0
  %t54 = load i8, i8* %t53
  %t55 = icmp eq i8 %t54, 32
  br label %logical_or_entry_51

logical_or_entry_51:
  br i1 %t55, label %logical_or_merge_51, label %logical_or_right_51

logical_or_right_51:
  %t57 = load i8*, i8** %l3
  %t58 = getelementptr i8, i8* %t57, i64 0
  %t59 = load i8, i8* %t58
  %t60 = icmp eq i8 %t59, 10
  br label %logical_or_entry_56

logical_or_entry_56:
  br i1 %t60, label %logical_or_merge_56, label %logical_or_right_56

logical_or_right_56:
  %t62 = load i8*, i8** %l3
  %t63 = getelementptr i8, i8* %t62, i64 0
  %t64 = load i8, i8* %t63
  %t65 = icmp eq i8 %t64, 9
  br label %logical_or_entry_61

logical_or_entry_61:
  br i1 %t65, label %logical_or_merge_61, label %logical_or_right_61

logical_or_right_61:
  %t66 = load i8*, i8** %l3
  %t67 = getelementptr i8, i8* %t66, i64 0
  %t68 = load i8, i8* %t67
  %t69 = icmp eq i8 %t68, 13
  br label %logical_or_right_end_61

logical_or_right_end_61:
  br label %logical_or_merge_61

logical_or_merge_61:
  %t70 = phi i1 [ true, %logical_or_entry_61 ], [ %t69, %logical_or_right_end_61 ]
  br label %logical_or_right_end_56

logical_or_right_end_56:
  br label %logical_or_merge_56

logical_or_merge_56:
  %t71 = phi i1 [ true, %logical_or_entry_56 ], [ %t70, %logical_or_right_end_56 ]
  br label %logical_or_right_end_51

logical_or_right_end_51:
  br label %logical_or_merge_51

logical_or_merge_51:
  %t72 = phi i1 [ true, %logical_or_entry_51 ], [ %t71, %logical_or_right_end_51 ]
  %t73 = load i64, i64* %l0
  %t74 = load i64, i64* %l1
  %t75 = load i8*, i8** %l3
  br i1 %t72, label %then14, label %merge15
then14:
  %t76 = load i64, i64* %l1
  %t77 = sub i64 %t76, 1
  store i64 %t77, i64* %l1
  br label %loop.latch10
merge15:
  br label %afterloop11
loop.latch10:
  %t78 = load i64, i64* %l1
  br label %loop.header8
afterloop11:
  %t80 = load i64, i64* %l0
  %t81 = load i64, i64* %l1
  %t82 = sitofp i64 %t80 to double
  %t83 = sitofp i64 %t81 to double
  %t84 = call i8* @sailfin_runtime_substring(i8* %value, double %t82, double %t83)
  ret i8* %t84
}

define i1 @string_starts_with(i8* %value, i8* %prefix) {
entry:
  %l0 = alloca i64
  %l1 = alloca i8*
  %l2 = alloca i8*
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
  %t23 = phi i64 [ %t3, %entry ], [ %t22, %loop.latch4 ]
  store i64 %t23, i64* %l0
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
  %t9 = sitofp i64 %t8 to double
  %t10 = call i8* @char_at(i8* %value, double %t9)
  store i8* %t10, i8** %l1
  %t11 = load i64, i64* %l0
  %t12 = sitofp i64 %t11 to double
  %t13 = call i8* @char_at(i8* %prefix, double %t12)
  store i8* %t13, i8** %l2
  %t14 = load i8*, i8** %l1
  %t15 = load i8*, i8** %l2
  %t16 = icmp ne i8* %t14, %t15
  %t17 = load i64, i64* %l0
  %t18 = load i8*, i8** %l1
  %t19 = load i8*, i8** %l2
  br i1 %t16, label %then8, label %merge9
then8:
  ret i1 0
merge9:
  %t20 = load i64, i64* %l0
  %t21 = add i64 %t20, 1
  store i64 %t21, i64* %l0
  br label %loop.latch4
loop.latch4:
  %t22 = load i64, i64* %l0
  br label %loop.header2
afterloop5:
  ret i1 1
}

define i1 @string_ends_with(i8* %value, i8* %suffix) {
entry:
  %l0 = alloca i64
  %l1 = alloca i64
  %l2 = alloca i8*
  %l3 = alloca i8*
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
  %t31 = phi i64 [ %t7, %entry ], [ %t30, %loop.latch4 ]
  store i64 %t31, i64* %l1
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
  %t13 = load i64, i64* %l0
  %t14 = load i64, i64* %l1
  %t15 = add i64 %t13, %t14
  %t16 = sitofp i64 %t15 to double
  %t17 = call i8* @char_at(i8* %value, double %t16)
  store i8* %t17, i8** %l2
  %t18 = load i64, i64* %l1
  %t19 = sitofp i64 %t18 to double
  %t20 = call i8* @char_at(i8* %suffix, double %t19)
  store i8* %t20, i8** %l3
  %t21 = load i8*, i8** %l2
  %t22 = load i8*, i8** %l3
  %t23 = icmp ne i8* %t21, %t22
  %t24 = load i64, i64* %l0
  %t25 = load i64, i64* %l1
  %t26 = load i8*, i8** %l2
  %t27 = load i8*, i8** %l3
  br i1 %t23, label %then8, label %merge9
then8:
  ret i1 0
merge9:
  %t28 = load i64, i64* %l1
  %t29 = add i64 %t28, 1
  store i64 %t29, i64* %l1
  br label %loop.latch4
loop.latch4:
  %t30 = load i64, i64* %l1
  br label %loop.header2
afterloop5:
  ret i1 1
}

define double @descriptor_find_top_level(i8* %value, i8* %needle) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca i64
  %l3 = alloca i64
  %l4 = alloca i64
  %l5 = alloca i64
  %l6 = alloca i8*
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
  %t5 = sitofp i64 0 to double
  %t6 = call i8* @char_at(i8* %needle, double %t5)
  store i8* %t6, i8** %l1
  store i64 0, i64* %l2
  store i64 0, i64* %l3
  store i64 0, i64* %l4
  store i64 0, i64* %l5
  %t7 = load i8*, i8** %l0
  %t8 = load i8*, i8** %l1
  %t9 = load i64, i64* %l2
  %t10 = load i64, i64* %l3
  %t11 = load i64, i64* %l4
  %t12 = load i64, i64* %l5
  br label %loop.header2
loop.header2:
  %t177 = phi i64 [ %t10, %entry ], [ %t173, %loop.latch4 ]
  %t178 = phi i64 [ %t11, %entry ], [ %t174, %loop.latch4 ]
  %t179 = phi i64 [ %t12, %entry ], [ %t175, %loop.latch4 ]
  %t180 = phi i64 [ %t9, %entry ], [ %t176, %loop.latch4 ]
  store i64 %t177, i64* %l3
  store i64 %t178, i64* %l4
  store i64 %t179, i64* %l5
  store i64 %t180, i64* %l2
  br label %loop.body3
loop.body3:
  %t13 = load i64, i64* %l2
  %t14 = load i8*, i8** %l0
  %t15 = call i64 @sailfin_runtime_string_length(i8* %t14)
  %t16 = icmp sge i64 %t13, %t15
  %t17 = load i8*, i8** %l0
  %t18 = load i8*, i8** %l1
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
  %t25 = sitofp i64 %t24 to double
  %t26 = call i8* @char_at(i8* %t23, double %t25)
  store i8* %t26, i8** %l6
  %t27 = load i8*, i8** %l6
  %t28 = getelementptr i8, i8* %t27, i64 0
  %t29 = load i8, i8* %t28
  %t30 = icmp eq i8 %t29, 40
  %t31 = load i8*, i8** %l0
  %t32 = load i8*, i8** %l1
  %t33 = load i64, i64* %l2
  %t34 = load i64, i64* %l3
  %t35 = load i64, i64* %l4
  %t36 = load i64, i64* %l5
  %t37 = load i8*, i8** %l6
  br i1 %t30, label %then8, label %else9
then8:
  %t38 = load i64, i64* %l3
  %t39 = add i64 %t38, 1
  store i64 %t39, i64* %l3
  br label %merge10
else9:
  %t40 = load i8*, i8** %l6
  %t41 = getelementptr i8, i8* %t40, i64 0
  %t42 = load i8, i8* %t41
  %t43 = icmp eq i8 %t42, 41
  %t44 = load i8*, i8** %l0
  %t45 = load i8*, i8** %l1
  %t46 = load i64, i64* %l2
  %t47 = load i64, i64* %l3
  %t48 = load i64, i64* %l4
  %t49 = load i64, i64* %l5
  %t50 = load i8*, i8** %l6
  br i1 %t43, label %then11, label %else12
then11:
  %t51 = load i64, i64* %l3
  %t52 = icmp sgt i64 %t51, 0
  %t53 = load i8*, i8** %l0
  %t54 = load i8*, i8** %l1
  %t55 = load i64, i64* %l2
  %t56 = load i64, i64* %l3
  %t57 = load i64, i64* %l4
  %t58 = load i64, i64* %l5
  %t59 = load i8*, i8** %l6
  br i1 %t52, label %then14, label %merge15
then14:
  %t60 = load i64, i64* %l3
  %t61 = sub i64 %t60, 1
  store i64 %t61, i64* %l3
  br label %merge15
merge15:
  %t62 = phi i64 [ %t61, %then14 ], [ %t56, %then11 ]
  store i64 %t62, i64* %l3
  br label %merge13
else12:
  %t63 = load i8*, i8** %l6
  %t64 = getelementptr i8, i8* %t63, i64 0
  %t65 = load i8, i8* %t64
  %t66 = icmp eq i8 %t65, 60
  %t67 = load i8*, i8** %l0
  %t68 = load i8*, i8** %l1
  %t69 = load i64, i64* %l2
  %t70 = load i64, i64* %l3
  %t71 = load i64, i64* %l4
  %t72 = load i64, i64* %l5
  %t73 = load i8*, i8** %l6
  br i1 %t66, label %then16, label %else17
then16:
  %t74 = load i64, i64* %l4
  %t75 = add i64 %t74, 1
  store i64 %t75, i64* %l4
  br label %merge18
else17:
  %t76 = load i8*, i8** %l6
  %t77 = getelementptr i8, i8* %t76, i64 0
  %t78 = load i8, i8* %t77
  %t79 = icmp eq i8 %t78, 62
  %t80 = load i8*, i8** %l0
  %t81 = load i8*, i8** %l1
  %t82 = load i64, i64* %l2
  %t83 = load i64, i64* %l3
  %t84 = load i64, i64* %l4
  %t85 = load i64, i64* %l5
  %t86 = load i8*, i8** %l6
  br i1 %t79, label %then19, label %else20
then19:
  %t87 = load i64, i64* %l4
  %t88 = icmp sgt i64 %t87, 0
  %t89 = load i8*, i8** %l0
  %t90 = load i8*, i8** %l1
  %t91 = load i64, i64* %l2
  %t92 = load i64, i64* %l3
  %t93 = load i64, i64* %l4
  %t94 = load i64, i64* %l5
  %t95 = load i8*, i8** %l6
  br i1 %t88, label %then22, label %merge23
then22:
  %t96 = load i64, i64* %l4
  %t97 = sub i64 %t96, 1
  store i64 %t97, i64* %l4
  br label %merge23
merge23:
  %t98 = phi i64 [ %t97, %then22 ], [ %t93, %then19 ]
  store i64 %t98, i64* %l4
  br label %merge21
else20:
  %t99 = load i8*, i8** %l6
  %t100 = getelementptr i8, i8* %t99, i64 0
  %t101 = load i8, i8* %t100
  %t102 = icmp eq i8 %t101, 91
  %t103 = load i8*, i8** %l0
  %t104 = load i8*, i8** %l1
  %t105 = load i64, i64* %l2
  %t106 = load i64, i64* %l3
  %t107 = load i64, i64* %l4
  %t108 = load i64, i64* %l5
  %t109 = load i8*, i8** %l6
  br i1 %t102, label %then24, label %else25
then24:
  %t110 = load i64, i64* %l5
  %t111 = add i64 %t110, 1
  store i64 %t111, i64* %l5
  br label %merge26
else25:
  %t112 = load i8*, i8** %l6
  %t113 = getelementptr i8, i8* %t112, i64 0
  %t114 = load i8, i8* %t113
  %t115 = icmp eq i8 %t114, 93
  %t116 = load i8*, i8** %l0
  %t117 = load i8*, i8** %l1
  %t118 = load i64, i64* %l2
  %t119 = load i64, i64* %l3
  %t120 = load i64, i64* %l4
  %t121 = load i64, i64* %l5
  %t122 = load i8*, i8** %l6
  br i1 %t115, label %then27, label %merge28
then27:
  %t123 = load i64, i64* %l5
  %t124 = icmp sgt i64 %t123, 0
  %t125 = load i8*, i8** %l0
  %t126 = load i8*, i8** %l1
  %t127 = load i64, i64* %l2
  %t128 = load i64, i64* %l3
  %t129 = load i64, i64* %l4
  %t130 = load i64, i64* %l5
  %t131 = load i8*, i8** %l6
  br i1 %t124, label %then29, label %merge30
then29:
  %t132 = load i64, i64* %l5
  %t133 = sub i64 %t132, 1
  store i64 %t133, i64* %l5
  br label %merge30
merge30:
  %t134 = phi i64 [ %t133, %then29 ], [ %t130, %then27 ]
  store i64 %t134, i64* %l5
  br label %merge28
merge28:
  %t135 = phi i64 [ %t133, %then27 ], [ %t121, %else25 ]
  store i64 %t135, i64* %l5
  br label %merge26
merge26:
  %t136 = phi i64 [ %t111, %then24 ], [ %t133, %else25 ]
  store i64 %t136, i64* %l5
  br label %merge21
merge21:
  %t137 = phi i64 [ %t97, %then19 ], [ %t84, %else20 ]
  %t138 = phi i64 [ %t85, %then19 ], [ %t111, %else20 ]
  store i64 %t137, i64* %l4
  store i64 %t138, i64* %l5
  br label %merge18
merge18:
  %t139 = phi i64 [ %t75, %then16 ], [ %t97, %else17 ]
  %t140 = phi i64 [ %t72, %then16 ], [ %t111, %else17 ]
  store i64 %t139, i64* %l4
  store i64 %t140, i64* %l5
  br label %merge13
merge13:
  %t141 = phi i64 [ %t61, %then11 ], [ %t47, %else12 ]
  %t142 = phi i64 [ %t48, %then11 ], [ %t75, %else12 ]
  %t143 = phi i64 [ %t49, %then11 ], [ %t111, %else12 ]
  store i64 %t141, i64* %l3
  store i64 %t142, i64* %l4
  store i64 %t143, i64* %l5
  br label %merge10
merge10:
  %t144 = phi i64 [ %t39, %then8 ], [ %t61, %else9 ]
  %t145 = phi i64 [ %t35, %then8 ], [ %t75, %else9 ]
  %t146 = phi i64 [ %t36, %then8 ], [ %t111, %else9 ]
  store i64 %t144, i64* %l3
  store i64 %t145, i64* %l4
  store i64 %t146, i64* %l5
  %t148 = load i8*, i8** %l6
  %t149 = load i8*, i8** %l1
  %t150 = icmp eq i8* %t148, %t149
  br label %logical_and_entry_147

logical_and_entry_147:
  br i1 %t150, label %logical_and_right_147, label %logical_and_merge_147

logical_and_right_147:
  %t152 = load i64, i64* %l3
  %t153 = icmp eq i64 %t152, 0
  br label %logical_and_entry_151

logical_and_entry_151:
  br i1 %t153, label %logical_and_right_151, label %logical_and_merge_151

logical_and_right_151:
  %t155 = load i64, i64* %l4
  %t156 = icmp eq i64 %t155, 0
  br label %logical_and_entry_154

logical_and_entry_154:
  br i1 %t156, label %logical_and_right_154, label %logical_and_merge_154

logical_and_right_154:
  %t157 = load i64, i64* %l5
  %t158 = icmp eq i64 %t157, 0
  br label %logical_and_right_end_154

logical_and_right_end_154:
  br label %logical_and_merge_154

logical_and_merge_154:
  %t159 = phi i1 [ false, %logical_and_entry_154 ], [ %t158, %logical_and_right_end_154 ]
  br label %logical_and_right_end_151

logical_and_right_end_151:
  br label %logical_and_merge_151

logical_and_merge_151:
  %t160 = phi i1 [ false, %logical_and_entry_151 ], [ %t159, %logical_and_right_end_151 ]
  br label %logical_and_right_end_147

logical_and_right_end_147:
  br label %logical_and_merge_147

logical_and_merge_147:
  %t161 = phi i1 [ false, %logical_and_entry_147 ], [ %t160, %logical_and_right_end_147 ]
  %t162 = load i8*, i8** %l0
  %t163 = load i8*, i8** %l1
  %t164 = load i64, i64* %l2
  %t165 = load i64, i64* %l3
  %t166 = load i64, i64* %l4
  %t167 = load i64, i64* %l5
  %t168 = load i8*, i8** %l6
  br i1 %t161, label %then31, label %merge32
then31:
  %t169 = load i64, i64* %l2
  %t170 = sitofp i64 %t169 to double
  ret double %t170
merge32:
  %t171 = load i64, i64* %l2
  %t172 = add i64 %t171, 1
  store i64 %t172, i64* %l2
  br label %loop.latch4
loop.latch4:
  %t173 = load i64, i64* %l3
  %t174 = load i64, i64* %l4
  %t175 = load i64, i64* %l5
  %t176 = load i64, i64* %l2
  br label %loop.header2
afterloop5:
  %t181 = sitofp i64 -1 to double
  ret double %t181
}

define i8* @descriptor_strip_outer_parens(i8* %value) {
entry:
  %l0 = alloca i8*
  %l1 = alloca i64
  %l2 = alloca i64
  %l3 = alloca i1
  %l4 = alloca i8*
  %t0 = call i8* @descriptor_trim(i8* %value)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  br label %loop.header0
loop.header0:
  %t118 = phi i8* [ %t1, %entry ], [ %t117, %loop.latch2 ]
  store i8* %t118, i8** %l0
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
  %t8 = sitofp i64 0 to double
  %t9 = call i8* @char_at(i8* %t7, double %t8)
  %t10 = getelementptr i8, i8* %t9, i64 0
  %t11 = load i8, i8* %t10
  %t12 = icmp ne i8 %t11, 40
  %t13 = load i8*, i8** %l0
  br i1 %t12, label %then6, label %merge7
then6:
  %t14 = load i8*, i8** %l0
  ret i8* %t14
merge7:
  %t15 = load i8*, i8** %l0
  %t16 = load i8*, i8** %l0
  %t17 = call i64 @sailfin_runtime_string_length(i8* %t16)
  %t18 = sub i64 %t17, 1
  %t19 = sitofp i64 %t18 to double
  %t20 = call i8* @char_at(i8* %t15, double %t19)
  %t21 = getelementptr i8, i8* %t20, i64 0
  %t22 = load i8, i8* %t21
  %t23 = icmp ne i8 %t22, 41
  %t24 = load i8*, i8** %l0
  br i1 %t23, label %then8, label %merge9
then8:
  %t25 = load i8*, i8** %l0
  ret i8* %t25
merge9:
  store i64 0, i64* %l1
  store i64 0, i64* %l2
  store i1 1, i1* %l3
  %t26 = load i8*, i8** %l0
  %t27 = load i64, i64* %l1
  %t28 = load i64, i64* %l2
  %t29 = load i1, i1* %l3
  br label %loop.header10
loop.header10:
  %t95 = phi i64 [ %t27, %loop.body1 ], [ %t92, %loop.latch12 ]
  %t96 = phi i1 [ %t29, %loop.body1 ], [ %t93, %loop.latch12 ]
  %t97 = phi i64 [ %t28, %loop.body1 ], [ %t94, %loop.latch12 ]
  store i64 %t95, i64* %l1
  store i1 %t96, i1* %l3
  store i64 %t97, i64* %l2
  br label %loop.body11
loop.body11:
  %t30 = load i64, i64* %l2
  %t31 = load i8*, i8** %l0
  %t32 = call i64 @sailfin_runtime_string_length(i8* %t31)
  %t33 = icmp sge i64 %t30, %t32
  %t34 = load i8*, i8** %l0
  %t35 = load i64, i64* %l1
  %t36 = load i64, i64* %l2
  %t37 = load i1, i1* %l3
  br i1 %t33, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t38 = load i8*, i8** %l0
  %t39 = load i64, i64* %l2
  %t40 = sitofp i64 %t39 to double
  %t41 = call i8* @char_at(i8* %t38, double %t40)
  store i8* %t41, i8** %l4
  %t42 = load i8*, i8** %l4
  %t43 = getelementptr i8, i8* %t42, i64 0
  %t44 = load i8, i8* %t43
  %t45 = icmp eq i8 %t44, 40
  %t46 = load i8*, i8** %l0
  %t47 = load i64, i64* %l1
  %t48 = load i64, i64* %l2
  %t49 = load i1, i1* %l3
  %t50 = load i8*, i8** %l4
  br i1 %t45, label %then16, label %else17
then16:
  %t51 = load i64, i64* %l1
  %t52 = add i64 %t51, 1
  store i64 %t52, i64* %l1
  br label %merge18
else17:
  %t53 = load i8*, i8** %l4
  %t54 = getelementptr i8, i8* %t53, i64 0
  %t55 = load i8, i8* %t54
  %t56 = icmp eq i8 %t55, 41
  %t57 = load i8*, i8** %l0
  %t58 = load i64, i64* %l1
  %t59 = load i64, i64* %l2
  %t60 = load i1, i1* %l3
  %t61 = load i8*, i8** %l4
  br i1 %t56, label %then19, label %merge20
then19:
  %t62 = load i64, i64* %l1
  %t63 = sub i64 %t62, 1
  store i64 %t63, i64* %l1
  %t64 = load i64, i64* %l1
  %t65 = icmp slt i64 %t64, 0
  %t66 = load i8*, i8** %l0
  %t67 = load i64, i64* %l1
  %t68 = load i64, i64* %l2
  %t69 = load i1, i1* %l3
  %t70 = load i8*, i8** %l4
  br i1 %t65, label %then21, label %merge22
then21:
  store i1 0, i1* %l3
  br label %afterloop13
merge22:
  %t72 = load i64, i64* %l1
  %t73 = icmp eq i64 %t72, 0
  br label %logical_and_entry_71

logical_and_entry_71:
  br i1 %t73, label %logical_and_right_71, label %logical_and_merge_71

logical_and_right_71:
  %t74 = load i64, i64* %l2
  %t75 = load i8*, i8** %l0
  %t76 = call i64 @sailfin_runtime_string_length(i8* %t75)
  %t77 = sub i64 %t76, 1
  %t78 = icmp slt i64 %t74, %t77
  br label %logical_and_right_end_71

logical_and_right_end_71:
  br label %logical_and_merge_71

logical_and_merge_71:
  %t79 = phi i1 [ false, %logical_and_entry_71 ], [ %t78, %logical_and_right_end_71 ]
  %t80 = load i8*, i8** %l0
  %t81 = load i64, i64* %l1
  %t82 = load i64, i64* %l2
  %t83 = load i1, i1* %l3
  %t84 = load i8*, i8** %l4
  br i1 %t79, label %then23, label %merge24
then23:
  store i1 0, i1* %l3
  br label %afterloop13
merge24:
  br label %merge20
merge20:
  %t85 = phi i64 [ %t63, %then19 ], [ %t58, %else17 ]
  %t86 = phi i1 [ 0, %then19 ], [ %t60, %else17 ]
  %t87 = phi i1 [ 0, %then19 ], [ %t60, %else17 ]
  store i64 %t85, i64* %l1
  store i1 %t86, i1* %l3
  store i1 %t87, i1* %l3
  br label %merge18
merge18:
  %t88 = phi i64 [ %t52, %then16 ], [ %t63, %else17 ]
  %t89 = phi i1 [ %t49, %then16 ], [ 0, %else17 ]
  store i64 %t88, i64* %l1
  store i1 %t89, i1* %l3
  %t90 = load i64, i64* %l2
  %t91 = add i64 %t90, 1
  store i64 %t91, i64* %l2
  br label %loop.latch12
loop.latch12:
  %t92 = load i64, i64* %l1
  %t93 = load i1, i1* %l3
  %t94 = load i64, i64* %l2
  br label %loop.header10
afterloop13:
  %t99 = load i1, i1* %l3
  br label %logical_or_entry_98

logical_or_entry_98:
  br i1 %t99, label %logical_or_merge_98, label %logical_or_right_98

logical_or_right_98:
  %t100 = load i64, i64* %l1
  %t101 = icmp ne i64 %t100, 0
  br label %logical_or_right_end_98

logical_or_right_end_98:
  br label %logical_or_merge_98

logical_or_merge_98:
  %t102 = phi i1 [ true, %logical_or_entry_98 ], [ %t101, %logical_or_right_end_98 ]
  %t103 = xor i1 %t102, 1
  %t104 = load i8*, i8** %l0
  %t105 = load i64, i64* %l1
  %t106 = load i64, i64* %l2
  %t107 = load i1, i1* %l3
  br i1 %t103, label %then25, label %merge26
then25:
  %t108 = load i8*, i8** %l0
  ret i8* %t108
merge26:
  %t109 = load i8*, i8** %l0
  %t110 = load i8*, i8** %l0
  %t111 = call i64 @sailfin_runtime_string_length(i8* %t110)
  %t112 = sub i64 %t111, 1
  %t113 = sitofp i64 1 to double
  %t114 = sitofp i64 %t112 to double
  %t115 = call i8* @sailfin_runtime_substring(i8* %t109, double %t113, double %t114)
  %t116 = call i8* @descriptor_trim(i8* %t115)
  store i8* %t116, i8** %l0
  br label %loop.latch2
loop.latch2:
  %t117 = load i8*, i8** %l0
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
  %l7 = alloca i8*
  %l8 = alloca i8*
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
  %t16 = sitofp i64 0 to double
  %t17 = call i8* @char_at(i8* %separator, double %t16)
  store i8* %t17, i8** %l7
  %t18 = load i8*, i8** %l0
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t20 = load i64, i64* %l2
  %t21 = load i64, i64* %l3
  %t22 = load i64, i64* %l4
  %t23 = load i64, i64* %l5
  %t24 = load i64, i64* %l6
  %t25 = load i8*, i8** %l7
  br label %loop.header2
loop.header2:
  %t232 = phi i64 [ %t22, %entry ], [ %t226, %loop.latch4 ]
  %t233 = phi i64 [ %t23, %entry ], [ %t227, %loop.latch4 ]
  %t234 = phi i64 [ %t24, %entry ], [ %t228, %loop.latch4 ]
  %t235 = phi { i8**, i64 }* [ %t19, %entry ], [ %t229, %loop.latch4 ]
  %t236 = phi i64 [ %t20, %entry ], [ %t230, %loop.latch4 ]
  %t237 = phi i64 [ %t21, %entry ], [ %t231, %loop.latch4 ]
  store i64 %t232, i64* %l4
  store i64 %t233, i64* %l5
  store i64 %t234, i64* %l6
  store { i8**, i64 }* %t235, { i8**, i64 }** %l1
  store i64 %t236, i64* %l2
  store i64 %t237, i64* %l3
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
  %t37 = load i8*, i8** %l7
  br i1 %t29, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t38 = load i8*, i8** %l0
  %t39 = load i64, i64* %l3
  %t40 = sitofp i64 %t39 to double
  %t41 = call i8* @char_at(i8* %t38, double %t40)
  store i8* %t41, i8** %l8
  %t42 = load i8*, i8** %l8
  %t43 = getelementptr i8, i8* %t42, i64 0
  %t44 = load i8, i8* %t43
  %t45 = icmp eq i8 %t44, 40
  %t46 = load i8*, i8** %l0
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t48 = load i64, i64* %l2
  %t49 = load i64, i64* %l3
  %t50 = load i64, i64* %l4
  %t51 = load i64, i64* %l5
  %t52 = load i64, i64* %l6
  %t53 = load i8*, i8** %l7
  %t54 = load i8*, i8** %l8
  br i1 %t45, label %then8, label %else9
then8:
  %t55 = load i64, i64* %l4
  %t56 = add i64 %t55, 1
  store i64 %t56, i64* %l4
  br label %merge10
else9:
  %t57 = load i8*, i8** %l8
  %t58 = getelementptr i8, i8* %t57, i64 0
  %t59 = load i8, i8* %t58
  %t60 = icmp eq i8 %t59, 41
  %t61 = load i8*, i8** %l0
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t63 = load i64, i64* %l2
  %t64 = load i64, i64* %l3
  %t65 = load i64, i64* %l4
  %t66 = load i64, i64* %l5
  %t67 = load i64, i64* %l6
  %t68 = load i8*, i8** %l7
  %t69 = load i8*, i8** %l8
  br i1 %t60, label %then11, label %else12
then11:
  %t70 = load i64, i64* %l4
  %t71 = icmp sgt i64 %t70, 0
  %t72 = load i8*, i8** %l0
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t74 = load i64, i64* %l2
  %t75 = load i64, i64* %l3
  %t76 = load i64, i64* %l4
  %t77 = load i64, i64* %l5
  %t78 = load i64, i64* %l6
  %t79 = load i8*, i8** %l7
  %t80 = load i8*, i8** %l8
  br i1 %t71, label %then14, label %merge15
then14:
  %t81 = load i64, i64* %l4
  %t82 = sub i64 %t81, 1
  store i64 %t82, i64* %l4
  br label %merge15
merge15:
  %t83 = phi i64 [ %t82, %then14 ], [ %t76, %then11 ]
  store i64 %t83, i64* %l4
  br label %merge13
else12:
  %t84 = load i8*, i8** %l8
  %t85 = getelementptr i8, i8* %t84, i64 0
  %t86 = load i8, i8* %t85
  %t87 = icmp eq i8 %t86, 60
  %t88 = load i8*, i8** %l0
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t90 = load i64, i64* %l2
  %t91 = load i64, i64* %l3
  %t92 = load i64, i64* %l4
  %t93 = load i64, i64* %l5
  %t94 = load i64, i64* %l6
  %t95 = load i8*, i8** %l7
  %t96 = load i8*, i8** %l8
  br i1 %t87, label %then16, label %else17
then16:
  %t97 = load i64, i64* %l5
  %t98 = add i64 %t97, 1
  store i64 %t98, i64* %l5
  br label %merge18
else17:
  %t99 = load i8*, i8** %l8
  %t100 = getelementptr i8, i8* %t99, i64 0
  %t101 = load i8, i8* %t100
  %t102 = icmp eq i8 %t101, 62
  %t103 = load i8*, i8** %l0
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t105 = load i64, i64* %l2
  %t106 = load i64, i64* %l3
  %t107 = load i64, i64* %l4
  %t108 = load i64, i64* %l5
  %t109 = load i64, i64* %l6
  %t110 = load i8*, i8** %l7
  %t111 = load i8*, i8** %l8
  br i1 %t102, label %then19, label %else20
then19:
  %t112 = load i64, i64* %l5
  %t113 = icmp sgt i64 %t112, 0
  %t114 = load i8*, i8** %l0
  %t115 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t116 = load i64, i64* %l2
  %t117 = load i64, i64* %l3
  %t118 = load i64, i64* %l4
  %t119 = load i64, i64* %l5
  %t120 = load i64, i64* %l6
  %t121 = load i8*, i8** %l7
  %t122 = load i8*, i8** %l8
  br i1 %t113, label %then22, label %merge23
then22:
  %t123 = load i64, i64* %l5
  %t124 = sub i64 %t123, 1
  store i64 %t124, i64* %l5
  br label %merge23
merge23:
  %t125 = phi i64 [ %t124, %then22 ], [ %t119, %then19 ]
  store i64 %t125, i64* %l5
  br label %merge21
else20:
  %t126 = load i8*, i8** %l8
  %t127 = getelementptr i8, i8* %t126, i64 0
  %t128 = load i8, i8* %t127
  %t129 = icmp eq i8 %t128, 91
  %t130 = load i8*, i8** %l0
  %t131 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t132 = load i64, i64* %l2
  %t133 = load i64, i64* %l3
  %t134 = load i64, i64* %l4
  %t135 = load i64, i64* %l5
  %t136 = load i64, i64* %l6
  %t137 = load i8*, i8** %l7
  %t138 = load i8*, i8** %l8
  br i1 %t129, label %then24, label %else25
then24:
  %t139 = load i64, i64* %l6
  %t140 = add i64 %t139, 1
  store i64 %t140, i64* %l6
  br label %merge26
else25:
  %t141 = load i8*, i8** %l8
  %t142 = getelementptr i8, i8* %t141, i64 0
  %t143 = load i8, i8* %t142
  %t144 = icmp eq i8 %t143, 93
  %t145 = load i8*, i8** %l0
  %t146 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t147 = load i64, i64* %l2
  %t148 = load i64, i64* %l3
  %t149 = load i64, i64* %l4
  %t150 = load i64, i64* %l5
  %t151 = load i64, i64* %l6
  %t152 = load i8*, i8** %l7
  %t153 = load i8*, i8** %l8
  br i1 %t144, label %then27, label %merge28
then27:
  %t154 = load i64, i64* %l6
  %t155 = icmp sgt i64 %t154, 0
  %t156 = load i8*, i8** %l0
  %t157 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t158 = load i64, i64* %l2
  %t159 = load i64, i64* %l3
  %t160 = load i64, i64* %l4
  %t161 = load i64, i64* %l5
  %t162 = load i64, i64* %l6
  %t163 = load i8*, i8** %l7
  %t164 = load i8*, i8** %l8
  br i1 %t155, label %then29, label %merge30
then29:
  %t165 = load i64, i64* %l6
  %t166 = sub i64 %t165, 1
  store i64 %t166, i64* %l6
  br label %merge30
merge30:
  %t167 = phi i64 [ %t166, %then29 ], [ %t162, %then27 ]
  store i64 %t167, i64* %l6
  br label %merge28
merge28:
  %t168 = phi i64 [ %t166, %then27 ], [ %t151, %else25 ]
  store i64 %t168, i64* %l6
  br label %merge26
merge26:
  %t169 = phi i64 [ %t140, %then24 ], [ %t166, %else25 ]
  store i64 %t169, i64* %l6
  br label %merge21
merge21:
  %t170 = phi i64 [ %t124, %then19 ], [ %t108, %else20 ]
  %t171 = phi i64 [ %t109, %then19 ], [ %t140, %else20 ]
  store i64 %t170, i64* %l5
  store i64 %t171, i64* %l6
  br label %merge18
merge18:
  %t172 = phi i64 [ %t98, %then16 ], [ %t124, %else17 ]
  %t173 = phi i64 [ %t94, %then16 ], [ %t140, %else17 ]
  store i64 %t172, i64* %l5
  store i64 %t173, i64* %l6
  br label %merge13
merge13:
  %t174 = phi i64 [ %t82, %then11 ], [ %t65, %else12 ]
  %t175 = phi i64 [ %t66, %then11 ], [ %t98, %else12 ]
  %t176 = phi i64 [ %t67, %then11 ], [ %t140, %else12 ]
  store i64 %t174, i64* %l4
  store i64 %t175, i64* %l5
  store i64 %t176, i64* %l6
  br label %merge10
merge10:
  %t177 = phi i64 [ %t56, %then8 ], [ %t82, %else9 ]
  %t178 = phi i64 [ %t51, %then8 ], [ %t98, %else9 ]
  %t179 = phi i64 [ %t52, %then8 ], [ %t140, %else9 ]
  store i64 %t177, i64* %l4
  store i64 %t178, i64* %l5
  store i64 %t179, i64* %l6
  %t181 = load i8*, i8** %l8
  %t182 = load i8*, i8** %l7
  %t183 = icmp eq i8* %t181, %t182
  br label %logical_and_entry_180

logical_and_entry_180:
  br i1 %t183, label %logical_and_right_180, label %logical_and_merge_180

logical_and_right_180:
  %t185 = load i64, i64* %l4
  %t186 = icmp eq i64 %t185, 0
  br label %logical_and_entry_184

logical_and_entry_184:
  br i1 %t186, label %logical_and_right_184, label %logical_and_merge_184

logical_and_right_184:
  %t188 = load i64, i64* %l5
  %t189 = icmp eq i64 %t188, 0
  br label %logical_and_entry_187

logical_and_entry_187:
  br i1 %t189, label %logical_and_right_187, label %logical_and_merge_187

logical_and_right_187:
  %t190 = load i64, i64* %l6
  %t191 = icmp eq i64 %t190, 0
  br label %logical_and_right_end_187

logical_and_right_end_187:
  br label %logical_and_merge_187

logical_and_merge_187:
  %t192 = phi i1 [ false, %logical_and_entry_187 ], [ %t191, %logical_and_right_end_187 ]
  br label %logical_and_right_end_184

logical_and_right_end_184:
  br label %logical_and_merge_184

logical_and_merge_184:
  %t193 = phi i1 [ false, %logical_and_entry_184 ], [ %t192, %logical_and_right_end_184 ]
  br label %logical_and_right_end_180

logical_and_right_end_180:
  br label %logical_and_merge_180

logical_and_merge_180:
  %t194 = phi i1 [ false, %logical_and_entry_180 ], [ %t193, %logical_and_right_end_180 ]
  %t195 = load i8*, i8** %l0
  %t196 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t197 = load i64, i64* %l2
  %t198 = load i64, i64* %l3
  %t199 = load i64, i64* %l4
  %t200 = load i64, i64* %l5
  %t201 = load i64, i64* %l6
  %t202 = load i8*, i8** %l7
  %t203 = load i8*, i8** %l8
  br i1 %t194, label %then31, label %merge32
then31:
  %t204 = load i8*, i8** %l0
  %t205 = load i64, i64* %l2
  %t206 = load i64, i64* %l3
  %t207 = sitofp i64 %t205 to double
  %t208 = sitofp i64 %t206 to double
  %t209 = call i8* @sailfin_runtime_substring(i8* %t204, double %t207, double %t208)
  store i8* %t209, i8** %l9
  %t210 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t211 = load i8*, i8** %l9
  %t212 = call i8* @descriptor_trim(i8* %t211)
  %t213 = alloca [1 x i8*]
  %t214 = getelementptr [1 x i8*], [1 x i8*]* %t213, i32 0, i32 0
  %t215 = getelementptr i8*, i8** %t214, i64 0
  store i8* %t212, i8** %t215
  %t216 = alloca { i8**, i64 }
  %t217 = getelementptr { i8**, i64 }, { i8**, i64 }* %t216, i32 0, i32 0
  store i8** %t214, i8*** %t217
  %t218 = getelementptr { i8**, i64 }, { i8**, i64 }* %t216, i32 0, i32 1
  store i64 1, i64* %t218
  %t219 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t210, { i8**, i64 }* %t216)
  store { i8**, i64 }* %t219, { i8**, i64 }** %l1
  %t220 = load i64, i64* %l3
  %t221 = add i64 %t220, 1
  store i64 %t221, i64* %l2
  br label %merge32
merge32:
  %t222 = phi { i8**, i64 }* [ %t219, %then31 ], [ %t196, %loop.body3 ]
  %t223 = phi i64 [ %t221, %then31 ], [ %t197, %loop.body3 ]
  store { i8**, i64 }* %t222, { i8**, i64 }** %l1
  store i64 %t223, i64* %l2
  %t224 = load i64, i64* %l3
  %t225 = add i64 %t224, 1
  store i64 %t225, i64* %l3
  br label %loop.latch4
loop.latch4:
  %t226 = load i64, i64* %l4
  %t227 = load i64, i64* %l5
  %t228 = load i64, i64* %l6
  %t229 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t230 = load i64, i64* %l2
  %t231 = load i64, i64* %l3
  br label %loop.header2
afterloop5:
  %t238 = load i8*, i8** %l0
  %t239 = load i64, i64* %l2
  %t240 = load i8*, i8** %l0
  %t241 = call i64 @sailfin_runtime_string_length(i8* %t240)
  %t242 = sitofp i64 %t239 to double
  %t243 = sitofp i64 %t241 to double
  %t244 = call i8* @sailfin_runtime_substring(i8* %t238, double %t242, double %t243)
  store i8* %t244, i8** %l10
  %t245 = load i8*, i8** %l10
  %t246 = call i8* @descriptor_trim(i8* %t245)
  store i8* %t246, i8** %l11
  %t248 = load i8*, i8** %l11
  %t249 = call i64 @sailfin_runtime_string_length(i8* %t248)
  %t250 = icmp sgt i64 %t249, 0
  br label %logical_or_entry_247

logical_or_entry_247:
  br i1 %t250, label %logical_or_merge_247, label %logical_or_right_247

logical_or_right_247:
  %t251 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t252 = load { i8**, i64 }, { i8**, i64 }* %t251
  %t253 = extractvalue { i8**, i64 } %t252, 1
  %t254 = icmp eq i64 %t253, 0
  br label %logical_or_right_end_247

logical_or_right_end_247:
  br label %logical_or_merge_247

logical_or_merge_247:
  %t255 = phi i1 [ true, %logical_or_entry_247 ], [ %t254, %logical_or_right_end_247 ]
  %t256 = load i8*, i8** %l0
  %t257 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t258 = load i64, i64* %l2
  %t259 = load i64, i64* %l3
  %t260 = load i64, i64* %l4
  %t261 = load i64, i64* %l5
  %t262 = load i64, i64* %l6
  %t263 = load i8*, i8** %l7
  %t264 = load i8*, i8** %l10
  %t265 = load i8*, i8** %l11
  br i1 %t255, label %then33, label %merge34
then33:
  %t266 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t267 = load i8*, i8** %l11
  %t268 = alloca [1 x i8*]
  %t269 = getelementptr [1 x i8*], [1 x i8*]* %t268, i32 0, i32 0
  %t270 = getelementptr i8*, i8** %t269, i64 0
  store i8* %t267, i8** %t270
  %t271 = alloca { i8**, i64 }
  %t272 = getelementptr { i8**, i64 }, { i8**, i64 }* %t271, i32 0, i32 0
  store i8** %t269, i8*** %t272
  %t273 = getelementptr { i8**, i64 }, { i8**, i64 }* %t271, i32 0, i32 1
  store i64 1, i64* %t273
  %t274 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t266, { i8**, i64 }* %t271)
  store { i8**, i64 }* %t274, { i8**, i64 }** %l1
  br label %merge34
merge34:
  %t275 = phi { i8**, i64 }* [ %t274, %then33 ], [ %t257, %entry ]
  store { i8**, i64 }* %t275, { i8**, i64 }** %l1
  %t276 = load { i8**, i64 }*, { i8**, i64 }** %l1
  ret { i8**, i64 }* %t276
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
  %l4 = alloca i8*
  %l5 = alloca %TypeDescriptor
  %l6 = alloca %TypeDescriptor
  %l7 = alloca double
  %l8 = alloca i8*
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
  %t7 = alloca [2 x i8], align 1
  %t8 = getelementptr [2 x i8], [2 x i8]* %t7, i32 0, i32 0
  store i8 124, i8* %t8
  %t9 = getelementptr [2 x i8], [2 x i8]* %t7, i32 0, i32 1
  store i8 0, i8* %t9
  %t10 = getelementptr [2 x i8], [2 x i8]* %t7, i32 0, i32 0
  %t11 = call { i8**, i64 }* @split_descriptor(i8* %t6, i8* %t10)
  store { i8**, i64 }* %t11, { i8**, i64 }** %l1
  %t12 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t13 = load { i8**, i64 }, { i8**, i64 }* %t12
  %t14 = extractvalue { i8**, i64 } %t13, 1
  %t15 = icmp sgt i64 %t14, 1
  %t16 = load i8*, i8** %l0
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t15, label %then2, label %merge3
then2:
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t19 = call { %TypeDescriptor*, i64 }* @parse_descriptor_list({ i8**, i64 }* %t18)
  %t20 = call %TypeDescriptor @type_descriptor_union({ %TypeDescriptor*, i64 }* %t19)
  ret %TypeDescriptor %t20
merge3:
  %t21 = load i8*, i8** %l0
  %t22 = alloca [2 x i8], align 1
  %t23 = getelementptr [2 x i8], [2 x i8]* %t22, i32 0, i32 0
  store i8 38, i8* %t23
  %t24 = getelementptr [2 x i8], [2 x i8]* %t22, i32 0, i32 1
  store i8 0, i8* %t24
  %t25 = getelementptr [2 x i8], [2 x i8]* %t22, i32 0, i32 0
  %t26 = call { i8**, i64 }* @split_descriptor(i8* %t21, i8* %t25)
  store { i8**, i64 }* %t26, { i8**, i64 }** %l2
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t28 = load { i8**, i64 }, { i8**, i64 }* %t27
  %t29 = extractvalue { i8**, i64 } %t28, 1
  %t30 = icmp sgt i64 %t29, 1
  %t31 = load i8*, i8** %l0
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t30, label %then4, label %merge5
then4:
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t35 = call { %TypeDescriptor*, i64 }* @parse_descriptor_list({ i8**, i64 }* %t34)
  %t36 = call %TypeDescriptor @type_descriptor_intersection({ %TypeDescriptor*, i64 }* %t35)
  ret %TypeDescriptor %t36
merge5:
  %t37 = load i8*, i8** %l0
  %s38 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.38, i32 0, i32 0
  %t39 = call i1 @string_ends_with(i8* %t37, i8* %s38)
  %t40 = load i8*, i8** %l0
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t39, label %then6, label %merge7
then6:
  %t43 = load i8*, i8** %l0
  %t44 = load i8*, i8** %l0
  %t45 = call i64 @sailfin_runtime_string_length(i8* %t44)
  %t46 = sub i64 %t45, 2
  %t47 = sitofp i64 0 to double
  %t48 = sitofp i64 %t46 to double
  %t49 = call i8* @sailfin_runtime_substring(i8* %t43, double %t47, double %t48)
  store i8* %t49, i8** %l3
  %t50 = load i8*, i8** %l3
  %t51 = call %TypeDescriptor @parse_type_descriptor(i8* %t50)
  %t52 = call %TypeDescriptor @type_descriptor_array(%TypeDescriptor %t51)
  ret %TypeDescriptor %t52
merge7:
  %t53 = load i8*, i8** %l0
  %s54 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.54, i32 0, i32 0
  %t55 = call i1 @string_starts_with(i8* %t53, i8* %s54)
  %t56 = load i8*, i8** %l0
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t55, label %then8, label %merge9
then8:
  %t59 = call %TypeDescriptor @type_descriptor_function()
  ret %TypeDescriptor %t59
merge9:
  %t60 = load i8*, i8** %l0
  %t61 = load i8*, i8** %l0
  %t62 = call i64 @sailfin_runtime_string_length(i8* %t61)
  %t63 = sub i64 %t62, 1
  %t64 = sitofp i64 %t63 to double
  %t65 = call i8* @char_at(i8* %t60, double %t64)
  %t66 = getelementptr i8, i8* %t65, i64 0
  %t67 = load i8, i8* %t66
  %t68 = icmp eq i8 %t67, 63
  %t69 = load i8*, i8** %l0
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t68, label %then10, label %merge11
then10:
  %t72 = load i8*, i8** %l0
  %t73 = load i8*, i8** %l0
  %t74 = call i64 @sailfin_runtime_string_length(i8* %t73)
  %t75 = sub i64 %t74, 1
  %t76 = sitofp i64 0 to double
  %t77 = sitofp i64 %t75 to double
  %t78 = call i8* @sailfin_runtime_substring(i8* %t72, double %t76, double %t77)
  store i8* %t78, i8** %l4
  %t79 = load i8*, i8** %l4
  %t80 = call %TypeDescriptor @parse_type_descriptor(i8* %t79)
  store %TypeDescriptor %t80, %TypeDescriptor* %l5
  %s81 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.81, i32 0, i32 0
  %t82 = call %TypeDescriptor @type_descriptor_primitive(i8* %s81)
  store %TypeDescriptor %t82, %TypeDescriptor* %l6
  %t83 = load %TypeDescriptor, %TypeDescriptor* %l5
  %t84 = load %TypeDescriptor, %TypeDescriptor* %l6
  %t85 = alloca [2 x %TypeDescriptor]
  %t86 = getelementptr [2 x %TypeDescriptor], [2 x %TypeDescriptor]* %t85, i32 0, i32 0
  %t87 = getelementptr %TypeDescriptor, %TypeDescriptor* %t86, i64 0
  store %TypeDescriptor %t83, %TypeDescriptor* %t87
  %t88 = getelementptr %TypeDescriptor, %TypeDescriptor* %t86, i64 1
  store %TypeDescriptor %t84, %TypeDescriptor* %t88
  %t89 = alloca { %TypeDescriptor*, i64 }
  %t90 = getelementptr { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* %t89, i32 0, i32 0
  store %TypeDescriptor* %t86, %TypeDescriptor** %t90
  %t91 = getelementptr { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* %t89, i32 0, i32 1
  store i64 2, i64* %t91
  %t92 = call %TypeDescriptor @type_descriptor_union({ %TypeDescriptor*, i64 }* %t89)
  ret %TypeDescriptor %t92
merge11:
  %t93 = load i8*, i8** %l0
  %t94 = alloca [2 x i8], align 1
  %t95 = getelementptr [2 x i8], [2 x i8]* %t94, i32 0, i32 0
  store i8 60, i8* %t95
  %t96 = getelementptr [2 x i8], [2 x i8]* %t94, i32 0, i32 1
  store i8 0, i8* %t96
  %t97 = getelementptr [2 x i8], [2 x i8]* %t94, i32 0, i32 0
  %t98 = call double @descriptor_find_top_level(i8* %t93, i8* %t97)
  store double %t98, double* %l7
  %t99 = load i8*, i8** %l0
  store i8* %t99, i8** %l8
  %t100 = load double, double* %l7
  %t101 = sitofp i64 0 to double
  %t102 = fcmp oge double %t100, %t101
  %t103 = load i8*, i8** %l0
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t106 = load double, double* %l7
  %t107 = load i8*, i8** %l8
  br i1 %t102, label %then12, label %merge13
then12:
  %t108 = load i8*, i8** %l0
  %t109 = load double, double* %l7
  %t110 = sitofp i64 0 to double
  %t111 = call i8* @sailfin_runtime_substring(i8* %t108, double %t110, double %t109)
  %t112 = call i8* @descriptor_trim(i8* %t111)
  store i8* %t112, i8** %l8
  br label %merge13
merge13:
  %t113 = phi i8* [ %t112, %then12 ], [ %t107, %entry ]
  store i8* %t113, i8** %l8
  %t114 = load i8*, i8** %l8
  %s115 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.115, i32 0, i32 0
  %t116 = call i1 @string_starts_with(i8* %t114, i8* %s115)
  %t117 = load i8*, i8** %l0
  %t118 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t119 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t120 = load double, double* %l7
  %t121 = load i8*, i8** %l8
  br i1 %t116, label %then14, label %merge15
then14:
  %t122 = load i8*, i8** %l8
  %t123 = load i8*, i8** %l8
  %t124 = call i64 @sailfin_runtime_string_length(i8* %t123)
  %t125 = sitofp i64 8 to double
  %t126 = sitofp i64 %t124 to double
  %t127 = call i8* @sailfin_runtime_substring(i8* %t122, double %t125, double %t126)
  %t128 = call i8* @descriptor_trim(i8* %t127)
  store i8* %t128, i8** %l8
  br label %merge15
merge15:
  %t129 = phi i8* [ %t128, %then14 ], [ %t121, %entry ]
  store i8* %t129, i8** %l8
  %t131 = load i8*, i8** %l8
  %s132 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.132, i32 0, i32 0
  %t133 = icmp eq i8* %t131, %s132
  br label %logical_or_entry_130

logical_or_entry_130:
  br i1 %t133, label %logical_or_merge_130, label %logical_or_right_130

logical_or_right_130:
  %t135 = load i8*, i8** %l8
  %s136 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.136, i32 0, i32 0
  %t137 = icmp eq i8* %t135, %s136
  br label %logical_or_entry_134

logical_or_entry_134:
  br i1 %t137, label %logical_or_merge_134, label %logical_or_right_134

logical_or_right_134:
  %t139 = load i8*, i8** %l8
  %s140 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.140, i32 0, i32 0
  %t141 = icmp eq i8* %t139, %s140
  br label %logical_or_entry_138

logical_or_entry_138:
  br i1 %t141, label %logical_or_merge_138, label %logical_or_right_138

logical_or_right_138:
  %t142 = load i8*, i8** %l8
  %s143 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.143, i32 0, i32 0
  %t144 = icmp eq i8* %t142, %s143
  br label %logical_or_right_end_138

logical_or_right_end_138:
  br label %logical_or_merge_138

logical_or_merge_138:
  %t145 = phi i1 [ true, %logical_or_entry_138 ], [ %t144, %logical_or_right_end_138 ]
  br label %logical_or_right_end_134

logical_or_right_end_134:
  br label %logical_or_merge_134

logical_or_merge_134:
  %t146 = phi i1 [ true, %logical_or_entry_134 ], [ %t145, %logical_or_right_end_134 ]
  br label %logical_or_right_end_130

logical_or_right_end_130:
  br label %logical_or_merge_130

logical_or_merge_130:
  %t147 = phi i1 [ true, %logical_or_entry_130 ], [ %t146, %logical_or_right_end_130 ]
  %t148 = load i8*, i8** %l0
  %t149 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t150 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t151 = load double, double* %l7
  %t152 = load i8*, i8** %l8
  br i1 %t147, label %then16, label %merge17
then16:
  %t153 = load i8*, i8** %l8
  %t154 = call %TypeDescriptor @type_descriptor_primitive(i8* %t153)
  ret %TypeDescriptor %t154
merge17:
  %t155 = load i8*, i8** %l8
  %t156 = call %TypeDescriptor @type_descriptor_named(i8* %t155)
  ret %TypeDescriptor %t156
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
  %l2 = alloca %TypeDescriptor*
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
  %t13 = load { %TypeDescriptor**, i64 }, { %TypeDescriptor**, i64 }* %t12
  %t14 = extractvalue { %TypeDescriptor**, i64 } %t13, 1
  %t15 = icmp sge i64 %t11, %t14
  %t16 = load i64, i64* %l0
  br i1 %t15, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t17 = extractvalue %TypeDescriptor %descriptor, 2
  %t18 = load i64, i64* %l0
  %t19 = load { %TypeDescriptor**, i64 }, { %TypeDescriptor**, i64 }* %t17
  %t20 = extractvalue { %TypeDescriptor**, i64 } %t19, 0
  %t21 = extractvalue { %TypeDescriptor**, i64 } %t19, 1
  %t22 = icmp uge i64 %t18, %t21
  ; bounds check: %t22 (if true, out of bounds)
  %t23 = getelementptr %TypeDescriptor*, %TypeDescriptor** %t20, i64 %t18
  %t24 = load %TypeDescriptor*, %TypeDescriptor** %t23
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
  %t37 = load { %TypeDescriptor**, i64 }, { %TypeDescriptor**, i64 }* %t36
  %t38 = extractvalue { %TypeDescriptor**, i64 } %t37, 1
  %t39 = icmp sge i64 %t35, %t38
  %t40 = load i64, i64* %l1
  br i1 %t39, label %then20, label %merge21
then20:
  br label %afterloop19
merge21:
  %t41 = extractvalue %TypeDescriptor %descriptor, 2
  %t42 = load i64, i64* %l1
  %t43 = load { %TypeDescriptor**, i64 }, { %TypeDescriptor**, i64 }* %t41
  %t44 = extractvalue { %TypeDescriptor**, i64 } %t43, 0
  %t45 = extractvalue { %TypeDescriptor**, i64 } %t43, 1
  %t46 = icmp uge i64 %t42, %t45
  ; bounds check: %t46 (if true, out of bounds)
  %t47 = getelementptr %TypeDescriptor*, %TypeDescriptor** %t44, i64 %t42
  %t48 = load %TypeDescriptor*, %TypeDescriptor** %t47
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
  %t57 = load { %TypeDescriptor**, i64 }, { %TypeDescriptor**, i64 }* %t56
  %t58 = extractvalue { %TypeDescriptor**, i64 } %t57, 1
  %t59 = icmp sgt i64 %t58, 0
  ret i1 %t59
merge15:
  %t60 = extractvalue %TypeDescriptor %descriptor, 0
  %s61 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.61, i32 0, i32 0
  %t62 = icmp eq i8* %t60, %s61
  br i1 %t62, label %then24, label %merge25
then24:
  %t63 = extractvalue %TypeDescriptor %descriptor, 2
  %t64 = load { %TypeDescriptor**, i64 }, { %TypeDescriptor**, i64 }* %t63
  %t65 = extractvalue { %TypeDescriptor**, i64 } %t64, 1
  %t66 = icmp eq i64 %t65, 0
  br i1 %t66, label %then26, label %merge27
then26:
  ret i1 false
merge27:
  %t67 = extractvalue %TypeDescriptor %descriptor, 2
  %t68 = load { %TypeDescriptor**, i64 }, { %TypeDescriptor**, i64 }* %t67
  %t69 = extractvalue { %TypeDescriptor**, i64 } %t68, 0
  %t70 = extractvalue { %TypeDescriptor**, i64 } %t68, 1
  %t71 = icmp uge i64 0, %t70
  ; bounds check: %t71 (if true, out of bounds)
  %t72 = getelementptr %TypeDescriptor*, %TypeDescriptor** %t69, i64 0
  %t73 = load %TypeDescriptor*, %TypeDescriptor** %t72
  store %TypeDescriptor* %t73, %TypeDescriptor** %l2
  store i64 0, i64* %l3
  %t74 = load %TypeDescriptor*, %TypeDescriptor** %l2
  %t75 = load i64, i64* %l3
  br label %loop.header28
loop.header28:
  %t96 = phi i64 [ %t75, %then24 ], [ %t95, %loop.latch30 ]
  store i64 %t96, i64* %l3
  br label %loop.body29
loop.body29:
  %t76 = load i64, i64* %l3
  %t77 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t78 = icmp sge i64 %t76, %t77
  %t79 = load %TypeDescriptor*, %TypeDescriptor** %l2
  %t80 = load i64, i64* %l3
  br i1 %t78, label %then32, label %merge33
then32:
  br label %afterloop31
merge33:
  %t81 = load i64, i64* %l3
  %t82 = getelementptr i8, i8* %value, i64 %t81
  %t83 = load i8, i8* %t82
  %t84 = load %TypeDescriptor*, %TypeDescriptor** %l2
  %t85 = alloca [2 x i8], align 1
  %t86 = getelementptr [2 x i8], [2 x i8]* %t85, i32 0, i32 0
  store i8 %t83, i8* %t86
  %t87 = getelementptr [2 x i8], [2 x i8]* %t85, i32 0, i32 1
  store i8 0, i8* %t87
  %t88 = getelementptr [2 x i8], [2 x i8]* %t85, i32 0, i32 0
  %t89 = call i1 @check_type_descriptor(i8* %t88, %TypeDescriptor zeroinitializer)
  %t90 = xor i1 %t89, 1
  %t91 = load %TypeDescriptor*, %TypeDescriptor** %l2
  %t92 = load i64, i64* %l3
  br i1 %t90, label %then34, label %merge35
then34:
  ret i1 0
merge35:
  %t93 = load i64, i64* %l3
  %t94 = add i64 %t93, 1
  store i64 %t94, i64* %l3
  br label %loop.latch30
loop.latch30:
  %t95 = load i64, i64* %l3
  br label %loop.header28
afterloop31:
  ret i1 1
merge25:
  %t97 = extractvalue %TypeDescriptor %descriptor, 0
  %s98 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.98, i32 0, i32 0
  %t99 = icmp eq i8* %t97, %s98
  br i1 %t99, label %then36, label %merge37
then36:
  ret i1 false
merge37:
  %t100 = extractvalue %TypeDescriptor %descriptor, 0
  %s101 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.101, i32 0, i32 0
  %t102 = icmp eq i8* %t100, %s101
  br i1 %t102, label %then38, label %merge39
then38:
  %t103 = extractvalue %TypeDescriptor %descriptor, 1
  %t104 = icmp eq i8* %t103, null
  br i1 %t104, label %then40, label %merge41
then40:
  ret i1 0
merge41:
  store double 0.0, double* %l4
  ret i1 false
merge39:
  %t105 = extractvalue %TypeDescriptor %descriptor, 0
  %s106 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.106, i32 0, i32 0
  %t107 = icmp eq i8* %t105, %s106
  br i1 %t107, label %then42, label %merge43
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
  ret i8* null
}

define double @find_char(i8* %text, i8* %character, double %start) {
entry:
  %l0 = alloca i64
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca i8*
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
  %t24 = sitofp i64 0 to double
  %t25 = call i8* @char_at(i8* %t23, double %t24)
  %t26 = getelementptr i8, i8* %t25, i64 0
  %t27 = load i8, i8* %t26
  %t28 = icmp eq i8 %t27, 92
  br label %logical_and_right_end_19

logical_and_right_end_19:
  br label %logical_and_merge_19

logical_and_merge_19:
  %t29 = phi i1 [ false, %logical_and_entry_19 ], [ %t28, %logical_and_right_end_19 ]
  %t30 = load i64, i64* %l0
  %t31 = load double, double* %l1
  %t32 = load i8*, i8** %l2
  br i1 %t29, label %then6, label %merge7
then6:
  %t33 = load i8*, i8** %l2
  %t34 = sitofp i64 1 to double
  %t35 = call i8* @char_at(i8* %t33, double %t34)
  store i8* %t35, i8** %l3
  %t36 = load i8*, i8** %l3
  %t37 = getelementptr i8, i8* %t36, i64 0
  %t38 = load i8, i8* %t37
  %t39 = icmp eq i8 %t38, 110
  %t40 = load i64, i64* %l0
  %t41 = load double, double* %l1
  %t42 = load i8*, i8** %l2
  %t43 = load i8*, i8** %l3
  br i1 %t39, label %then8, label %else9
then8:
  %t44 = alloca [2 x i8], align 1
  %t45 = getelementptr [2 x i8], [2 x i8]* %t44, i32 0, i32 0
  store i8 10, i8* %t45
  %t46 = getelementptr [2 x i8], [2 x i8]* %t44, i32 0, i32 1
  store i8 0, i8* %t46
  %t47 = getelementptr [2 x i8], [2 x i8]* %t44, i32 0, i32 0
  store i8* %t47, i8** %l2
  br label %merge10
else9:
  %t48 = load i8*, i8** %l3
  %t49 = getelementptr i8, i8* %t48, i64 0
  %t50 = load i8, i8* %t49
  %t51 = icmp eq i8 %t50, 114
  %t52 = load i64, i64* %l0
  %t53 = load double, double* %l1
  %t54 = load i8*, i8** %l2
  %t55 = load i8*, i8** %l3
  br i1 %t51, label %then11, label %else12
then11:
  %t56 = alloca [2 x i8], align 1
  %t57 = getelementptr [2 x i8], [2 x i8]* %t56, i32 0, i32 0
  store i8 13, i8* %t57
  %t58 = getelementptr [2 x i8], [2 x i8]* %t56, i32 0, i32 1
  store i8 0, i8* %t58
  %t59 = getelementptr [2 x i8], [2 x i8]* %t56, i32 0, i32 0
  store i8* %t59, i8** %l2
  br label %merge13
else12:
  %t60 = load i8*, i8** %l3
  %t61 = getelementptr i8, i8* %t60, i64 0
  %t62 = load i8, i8* %t61
  %t63 = icmp eq i8 %t62, 116
  %t64 = load i64, i64* %l0
  %t65 = load double, double* %l1
  %t66 = load i8*, i8** %l2
  %t67 = load i8*, i8** %l3
  br i1 %t63, label %then14, label %merge15
then14:
  %t68 = alloca [2 x i8], align 1
  %t69 = getelementptr [2 x i8], [2 x i8]* %t68, i32 0, i32 0
  store i8 9, i8* %t69
  %t70 = getelementptr [2 x i8], [2 x i8]* %t68, i32 0, i32 1
  store i8 0, i8* %t70
  %t71 = getelementptr [2 x i8], [2 x i8]* %t68, i32 0, i32 0
  store i8* %t71, i8** %l2
  br label %merge15
merge15:
  %t72 = phi i8* [ %t71, %then14 ], [ %t66, %else12 ]
  store i8* %t72, i8** %l2
  br label %merge13
merge13:
  %t73 = phi i8* [ %t59, %then11 ], [ %t71, %else12 ]
  store i8* %t73, i8** %l2
  br label %merge10
merge10:
  %t74 = phi i8* [ %t47, %then8 ], [ %t59, %else9 ]
  store i8* %t74, i8** %l2
  br label %merge7
merge7:
  %t75 = phi i8* [ %t47, %then6 ], [ %t32, %entry ]
  %t76 = phi i8* [ %t59, %then6 ], [ %t32, %entry ]
  %t77 = phi i8* [ %t71, %then6 ], [ %t32, %entry ]
  store i8* %t75, i8** %l2
  store i8* %t76, i8** %l2
  store i8* %t77, i8** %l2
  %t78 = load double, double* %l1
  store double %t78, double* %l4
  %t79 = load i64, i64* %l0
  %t80 = load double, double* %l1
  %t81 = load i8*, i8** %l2
  %t82 = load double, double* %l4
  br label %loop.header16
loop.header16:
  %t104 = phi double [ %t82, %entry ], [ %t103, %loop.latch18 ]
  store double %t104, double* %l4
  br label %loop.body17
loop.body17:
  %t83 = load double, double* %l4
  %t84 = load i64, i64* %l0
  %t85 = sitofp i64 %t84 to double
  %t86 = fcmp oge double %t83, %t85
  %t87 = load i64, i64* %l0
  %t88 = load double, double* %l1
  %t89 = load i8*, i8** %l2
  %t90 = load double, double* %l4
  br i1 %t86, label %then20, label %merge21
then20:
  br label %afterloop19
merge21:
  %t91 = load double, double* %l4
  %t92 = call i8* @char_at(i8* %text, double %t91)
  %t93 = load i8*, i8** %l2
  %t94 = icmp eq i8* %t92, %t93
  %t95 = load i64, i64* %l0
  %t96 = load double, double* %l1
  %t97 = load i8*, i8** %l2
  %t98 = load double, double* %l4
  br i1 %t94, label %then22, label %merge23
then22:
  %t99 = load double, double* %l4
  ret double %t99
merge23:
  %t100 = load double, double* %l4
  %t101 = sitofp i64 1 to double
  %t102 = fadd double %t100, %t101
  store double %t102, double* %l4
  br label %loop.latch18
loop.latch18:
  %t103 = load double, double* %l4
  br label %loop.header16
afterloop19:
  %t105 = sitofp i64 -1 to double
  ret double %t105
}

define void @match_exhaustive_failed(i8* %value) {
entry:
  %l0 = alloca i8*
  %s0 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l0
  ret void
}

define double @char_code(i8* %character) {
entry:
  %l0 = alloca i8*
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
  %t3 = sitofp i64 0 to double
  %t4 = call i8* @char_at(i8* %character, double %t3)
  store i8* %t4, i8** %l0
  %s5 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.5, i32 0, i32 0
  store i8* %s5, i8** %l1
  %t6 = load i8*, i8** %l1
  %t7 = load i8*, i8** %l0
  %t8 = sitofp i64 0 to double
  %t9 = call double @find_char(i8* %t6, i8* %t7, double %t8)
  store double %t9, double* %l2
  %t10 = load double, double* %l2
  %t11 = sitofp i64 0 to double
  %t12 = fcmp oge double %t10, %t11
  %t13 = load i8*, i8** %l0
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
  %t21 = load i8*, i8** %l0
  %t22 = sitofp i64 0 to double
  %t23 = call double @find_char(i8* %t20, i8* %t21, double %t22)
  store double %t23, double* %l4
  %t24 = load double, double* %l4
  %t25 = sitofp i64 0 to double
  %t26 = fcmp oge double %t24, %t25
  %t27 = load i8*, i8** %l0
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
  %t37 = load i8*, i8** %l0
  %t38 = sitofp i64 0 to double
  %t39 = call double @find_char(i8* %t36, i8* %t37, double %t38)
  store double %t39, double* %l6
  %t40 = load double, double* %l6
  %t41 = sitofp i64 0 to double
  %t42 = fcmp oge double %t40, %t41
  %t43 = load i8*, i8** %l0
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
  %t53 = load i8*, i8** %l0
  %t54 = getelementptr i8, i8* %t53, i64 0
  %t55 = load i8, i8* %t54
  %t56 = icmp eq i8 %t55, 32
  %t57 = load i8*, i8** %l0
  %t58 = load i8*, i8** %l1
  %t59 = load double, double* %l2
  %t60 = load i8*, i8** %l3
  %t61 = load double, double* %l4
  %t62 = load i8*, i8** %l5
  %t63 = load double, double* %l6
  br i1 %t56, label %then8, label %merge9
then8:
  %t64 = sitofp i64 32 to double
  ret double %t64
merge9:
  %t65 = load i8*, i8** %l0
  %t66 = getelementptr i8, i8* %t65, i64 0
  %t67 = load i8, i8* %t66
  %t68 = icmp eq i8 %t67, 10
  %t69 = load i8*, i8** %l0
  %t70 = load i8*, i8** %l1
  %t71 = load double, double* %l2
  %t72 = load i8*, i8** %l3
  %t73 = load double, double* %l4
  %t74 = load i8*, i8** %l5
  %t75 = load double, double* %l6
  br i1 %t68, label %then10, label %merge11
then10:
  %t76 = sitofp i64 10 to double
  ret double %t76
merge11:
  %t77 = load i8*, i8** %l0
  %t78 = getelementptr i8, i8* %t77, i64 0
  %t79 = load i8, i8* %t78
  %t80 = icmp eq i8 %t79, 13
  %t81 = load i8*, i8** %l0
  %t82 = load i8*, i8** %l1
  %t83 = load double, double* %l2
  %t84 = load i8*, i8** %l3
  %t85 = load double, double* %l4
  %t86 = load i8*, i8** %l5
  %t87 = load double, double* %l6
  br i1 %t80, label %then12, label %merge13
then12:
  %t88 = sitofp i64 13 to double
  ret double %t88
merge13:
  %t89 = load i8*, i8** %l0
  %t90 = getelementptr i8, i8* %t89, i64 0
  %t91 = load i8, i8* %t90
  %t92 = icmp eq i8 %t91, 9
  %t93 = load i8*, i8** %l0
  %t94 = load i8*, i8** %l1
  %t95 = load double, double* %l2
  %t96 = load i8*, i8** %l3
  %t97 = load double, double* %l4
  %t98 = load i8*, i8** %l5
  %t99 = load double, double* %l6
  br i1 %t92, label %then14, label %merge15
then14:
  %t100 = sitofp i64 9 to double
  ret double %t100
merge15:
  %t101 = load i8*, i8** %l0
  %t102 = getelementptr i8, i8* %t101, i64 0
  %t103 = load i8, i8* %t102
  %t104 = icmp eq i8 %t103, 34
  %t105 = load i8*, i8** %l0
  %t106 = load i8*, i8** %l1
  %t107 = load double, double* %l2
  %t108 = load i8*, i8** %l3
  %t109 = load double, double* %l4
  %t110 = load i8*, i8** %l5
  %t111 = load double, double* %l6
  br i1 %t104, label %then16, label %merge17
then16:
  %t112 = sitofp i64 34 to double
  ret double %t112
merge17:
  %t113 = load i8*, i8** %l0
  %t114 = getelementptr i8, i8* %t113, i64 0
  %t115 = load i8, i8* %t114
  %t116 = icmp eq i8 %t115, 92
  %t117 = load i8*, i8** %l0
  %t118 = load i8*, i8** %l1
  %t119 = load double, double* %l2
  %t120 = load i8*, i8** %l3
  %t121 = load double, double* %l4
  %t122 = load i8*, i8** %l5
  %t123 = load double, double* %l6
  br i1 %t116, label %then18, label %merge19
then18:
  %t124 = sitofp i64 92 to double
  ret double %t124
merge19:
  %t125 = load i8*, i8** %l0
  %t126 = getelementptr i8, i8* %t125, i64 0
  %t127 = load i8, i8* %t126
  %t128 = icmp eq i8 %t127, 95
  %t129 = load i8*, i8** %l0
  %t130 = load i8*, i8** %l1
  %t131 = load double, double* %l2
  %t132 = load i8*, i8** %l3
  %t133 = load double, double* %l4
  %t134 = load i8*, i8** %l5
  %t135 = load double, double* %l6
  br i1 %t128, label %then20, label %merge21
then20:
  %t136 = sitofp i64 95 to double
  ret double %t136
merge21:
  %t137 = load i8*, i8** %l0
  %s138 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.138, i32 0, i32 0
  %t139 = call double @chencode(i8* %s138)
  store double %t139, double* %l7
  %t140 = load double, double* %l7
  store double 0.0, double* %l8
  %t141 = load double, double* %l8
  %t142 = sitofp i64 0 to double
  %t143 = fcmp oeq double %t141, %t142
  %t144 = load i8*, i8** %l0
  %t145 = load i8*, i8** %l1
  %t146 = load double, double* %l2
  %t147 = load i8*, i8** %l3
  %t148 = load double, double* %l4
  %t149 = load i8*, i8** %l5
  %t150 = load double, double* %l6
  %t151 = load double, double* %l7
  %t152 = load double, double* %l8
  br i1 %t143, label %then22, label %merge23
then22:
  %t153 = sitofp i64 -1 to double
  ret double %t153
merge23:
  %t154 = load double, double* %l8
  %t155 = sitofp i64 4 to double
  %t156 = fcmp ogt double %t154, %t155
  %t157 = load i8*, i8** %l0
  %t158 = load i8*, i8** %l1
  %t159 = load double, double* %l2
  %t160 = load i8*, i8** %l3
  %t161 = load double, double* %l4
  %t162 = load i8*, i8** %l5
  %t163 = load double, double* %l6
  %t164 = load double, double* %l7
  %t165 = load double, double* %l8
  br i1 %t156, label %then24, label %merge25
then24:
  %t166 = sitofp i64 -1 to double
  ret double %t166
merge25:
  store i64 0, i64* %l9
  store i64 0, i64* %l10
  %t167 = load i8*, i8** %l0
  %t168 = load i8*, i8** %l1
  %t169 = load double, double* %l2
  %t170 = load i8*, i8** %l3
  %t171 = load double, double* %l4
  %t172 = load i8*, i8** %l5
  %t173 = load double, double* %l6
  %t174 = load double, double* %l7
  %t175 = load double, double* %l8
  %t176 = load i64, i64* %l9
  %t177 = load i64, i64* %l10
  br label %loop.header26
loop.header26:
  %t334 = phi i64 [ %t177, %entry ], [ %t332, %loop.latch28 ]
  %t335 = phi i64 [ %t176, %entry ], [ %t333, %loop.latch28 ]
  store i64 %t334, i64* %l10
  store i64 %t335, i64* %l9
  br label %loop.body27
loop.body27:
  %t178 = load i64, i64* %l9
  %t179 = load double, double* %l8
  %t180 = sitofp i64 %t178 to double
  %t181 = fcmp oge double %t180, %t179
  %t182 = load i8*, i8** %l0
  %t183 = load i8*, i8** %l1
  %t184 = load double, double* %l2
  %t185 = load i8*, i8** %l3
  %t186 = load double, double* %l4
  %t187 = load i8*, i8** %l5
  %t188 = load double, double* %l6
  %t189 = load double, double* %l7
  %t190 = load double, double* %l8
  %t191 = load i64, i64* %l9
  %t192 = load i64, i64* %l10
  br i1 %t181, label %then30, label %merge31
then30:
  br label %afterloop29
merge31:
  %t193 = load double, double* %l7
  %t194 = load i64, i64* %l9
  store double 0.0, double* %l11
  %t195 = load i64, i64* %l9
  %t196 = icmp eq i64 %t195, 0
  %t197 = load i8*, i8** %l0
  %t198 = load i8*, i8** %l1
  %t199 = load double, double* %l2
  %t200 = load i8*, i8** %l3
  %t201 = load double, double* %l4
  %t202 = load i8*, i8** %l5
  %t203 = load double, double* %l6
  %t204 = load double, double* %l7
  %t205 = load double, double* %l8
  %t206 = load i64, i64* %l9
  %t207 = load i64, i64* %l10
  %t208 = load double, double* %l11
  br i1 %t196, label %then32, label %else33
then32:
  %t209 = load double, double* %l11
  %t210 = sitofp i64 128 to double
  %t211 = fcmp olt double %t209, %t210
  %t212 = load i8*, i8** %l0
  %t213 = load i8*, i8** %l1
  %t214 = load double, double* %l2
  %t215 = load i8*, i8** %l3
  %t216 = load double, double* %l4
  %t217 = load i8*, i8** %l5
  %t218 = load double, double* %l6
  %t219 = load double, double* %l7
  %t220 = load double, double* %l8
  %t221 = load i64, i64* %l9
  %t222 = load i64, i64* %l10
  %t223 = load double, double* %l11
  br i1 %t211, label %then35, label %merge36
then35:
  %t224 = load double, double* %l11
  ret double %t224
merge36:
  %t226 = load double, double* %l11
  %t227 = sitofp i64 192 to double
  %t228 = fcmp oge double %t226, %t227
  br label %logical_and_entry_225

logical_and_entry_225:
  br i1 %t228, label %logical_and_right_225, label %logical_and_merge_225

logical_and_right_225:
  %t229 = load double, double* %l11
  %t230 = sitofp i64 223 to double
  %t231 = fcmp ole double %t229, %t230
  br label %logical_and_right_end_225

logical_and_right_end_225:
  br label %logical_and_merge_225

logical_and_merge_225:
  %t232 = phi i1 [ false, %logical_and_entry_225 ], [ %t231, %logical_and_right_end_225 ]
  %t233 = load i8*, i8** %l0
  %t234 = load i8*, i8** %l1
  %t235 = load double, double* %l2
  %t236 = load i8*, i8** %l3
  %t237 = load double, double* %l4
  %t238 = load i8*, i8** %l5
  %t239 = load double, double* %l6
  %t240 = load double, double* %l7
  %t241 = load double, double* %l8
  %t242 = load i64, i64* %l9
  %t243 = load i64, i64* %l10
  %t244 = load double, double* %l11
  br i1 %t232, label %then37, label %else38
then37:
  %t245 = load double, double* %l11
  %t246 = sitofp i64 192 to double
  %t247 = fsub double %t245, %t246
  %t248 = fptosi double %t247 to i64
  store i64 %t248, i64* %l10
  br label %merge39
else38:
  %t250 = load double, double* %l11
  %t251 = sitofp i64 224 to double
  %t252 = fcmp oge double %t250, %t251
  br label %logical_and_entry_249

logical_and_entry_249:
  br i1 %t252, label %logical_and_right_249, label %logical_and_merge_249

logical_and_right_249:
  %t253 = load double, double* %l11
  %t254 = sitofp i64 239 to double
  %t255 = fcmp ole double %t253, %t254
  br label %logical_and_right_end_249

logical_and_right_end_249:
  br label %logical_and_merge_249

logical_and_merge_249:
  %t256 = phi i1 [ false, %logical_and_entry_249 ], [ %t255, %logical_and_right_end_249 ]
  %t257 = load i8*, i8** %l0
  %t258 = load i8*, i8** %l1
  %t259 = load double, double* %l2
  %t260 = load i8*, i8** %l3
  %t261 = load double, double* %l4
  %t262 = load i8*, i8** %l5
  %t263 = load double, double* %l6
  %t264 = load double, double* %l7
  %t265 = load double, double* %l8
  %t266 = load i64, i64* %l9
  %t267 = load i64, i64* %l10
  %t268 = load double, double* %l11
  br i1 %t256, label %then40, label %else41
then40:
  %t269 = load double, double* %l11
  %t270 = sitofp i64 224 to double
  %t271 = fsub double %t269, %t270
  %t272 = fptosi double %t271 to i64
  store i64 %t272, i64* %l10
  br label %merge42
else41:
  %t274 = load double, double* %l11
  %t275 = sitofp i64 240 to double
  %t276 = fcmp oge double %t274, %t275
  br label %logical_and_entry_273

logical_and_entry_273:
  br i1 %t276, label %logical_and_right_273, label %logical_and_merge_273

logical_and_right_273:
  %t277 = load double, double* %l11
  %t278 = sitofp i64 247 to double
  %t279 = fcmp ole double %t277, %t278
  br label %logical_and_right_end_273

logical_and_right_end_273:
  br label %logical_and_merge_273

logical_and_merge_273:
  %t280 = phi i1 [ false, %logical_and_entry_273 ], [ %t279, %logical_and_right_end_273 ]
  %t281 = load i8*, i8** %l0
  %t282 = load i8*, i8** %l1
  %t283 = load double, double* %l2
  %t284 = load i8*, i8** %l3
  %t285 = load double, double* %l4
  %t286 = load i8*, i8** %l5
  %t287 = load double, double* %l6
  %t288 = load double, double* %l7
  %t289 = load double, double* %l8
  %t290 = load i64, i64* %l9
  %t291 = load i64, i64* %l10
  %t292 = load double, double* %l11
  br i1 %t280, label %then43, label %else44
then43:
  %t293 = load double, double* %l11
  %t294 = sitofp i64 240 to double
  %t295 = fsub double %t293, %t294
  %t296 = fptosi double %t295 to i64
  store i64 %t296, i64* %l10
  br label %merge45
else44:
  %t297 = sitofp i64 -1 to double
  ret double %t297
merge45:
  br label %merge42
merge42:
  %t298 = phi i64 [ %t272, %then40 ], [ %t296, %else41 ]
  store i64 %t298, i64* %l10
  br label %merge39
merge39:
  %t299 = phi i64 [ %t248, %then37 ], [ %t272, %else38 ]
  store i64 %t299, i64* %l10
  br label %merge34
else33:
  %t301 = load double, double* %l11
  %t302 = sitofp i64 128 to double
  %t303 = fcmp olt double %t301, %t302
  br label %logical_or_entry_300

logical_or_entry_300:
  br i1 %t303, label %logical_or_merge_300, label %logical_or_right_300

logical_or_right_300:
  %t304 = load double, double* %l11
  %t305 = sitofp i64 191 to double
  %t306 = fcmp ogt double %t304, %t305
  br label %logical_or_right_end_300

logical_or_right_end_300:
  br label %logical_or_merge_300

logical_or_merge_300:
  %t307 = phi i1 [ true, %logical_or_entry_300 ], [ %t306, %logical_or_right_end_300 ]
  %t308 = load i8*, i8** %l0
  %t309 = load i8*, i8** %l1
  %t310 = load double, double* %l2
  %t311 = load i8*, i8** %l3
  %t312 = load double, double* %l4
  %t313 = load i8*, i8** %l5
  %t314 = load double, double* %l6
  %t315 = load double, double* %l7
  %t316 = load double, double* %l8
  %t317 = load i64, i64* %l9
  %t318 = load i64, i64* %l10
  %t319 = load double, double* %l11
  br i1 %t307, label %then46, label %merge47
then46:
  %t320 = sitofp i64 -1 to double
  ret double %t320
merge47:
  %t321 = load i64, i64* %l10
  %t322 = mul i64 %t321, 64
  %t323 = load double, double* %l11
  %t324 = sitofp i64 128 to double
  %t325 = fsub double %t323, %t324
  %t326 = sitofp i64 %t322 to double
  %t327 = fadd double %t326, %t325
  %t328 = fptosi double %t327 to i64
  store i64 %t328, i64* %l10
  br label %merge34
merge34:
  %t329 = phi i64 [ %t248, %then32 ], [ %t328, %else33 ]
  store i64 %t329, i64* %l10
  %t330 = load i64, i64* %l9
  %t331 = add i64 %t330, 1
  store i64 %t331, i64* %l9
  br label %loop.latch28
loop.latch28:
  %t332 = load i64, i64* %l10
  %t333 = load i64, i64* %l9
  br label %loop.header26
afterloop29:
  %t336 = load i64, i64* %l10
  %t337 = sitofp i64 %t336 to double
  ret double %t337
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
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i1
  %l5 = alloca i64
  %l6 = alloca i64
  %l7 = alloca i8*
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
  %t9 = sitofp i64 0 to double
  %t10 = call i8* @char_at(i8* %text, double %t9)
  store i8* %t10, i8** %l1
  %t11 = load i8*, i8** %l1
  %t12 = call double @char_code(i8* %t11)
  store double %t12, double* %l2
  %t13 = load double, double* %l2
  store double 0.0, double* %l3
  %t14 = load double, double* %l2
  %t15 = call i1 @is_regional_indicator(double %t14)
  store i1 %t15, i1* %l4
  store i64 0, i64* %l5
  %t16 = load i1, i1* %l4
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = load i8*, i8** %l1
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
  %t25 = load i8*, i8** %l1
  %t26 = load double, double* %l2
  %t27 = load double, double* %l3
  %t28 = load i1, i1* %l4
  %t29 = load i64, i64* %l5
  %t30 = load i64, i64* %l6
  br label %loop.header4
loop.header4:
  %t287 = phi { i8**, i64 }* [ %t24, %entry ], [ %t280, %loop.latch6 ]
  %t288 = phi i8* [ %t25, %entry ], [ %t281, %loop.latch6 ]
  %t289 = phi i64 [ %t29, %entry ], [ %t282, %loop.latch6 ]
  %t290 = phi double [ %t26, %entry ], [ %t283, %loop.latch6 ]
  %t291 = phi double [ %t27, %entry ], [ %t284, %loop.latch6 ]
  %t292 = phi i1 [ %t28, %entry ], [ %t285, %loop.latch6 ]
  %t293 = phi i64 [ %t30, %entry ], [ %t286, %loop.latch6 ]
  store { i8**, i64 }* %t287, { i8**, i64 }** %l0
  store i8* %t288, i8** %l1
  store i64 %t289, i64* %l5
  store double %t290, double* %l2
  store double %t291, double* %l3
  store i1 %t292, i1* %l4
  store i64 %t293, i64* %l6
  br label %loop.body5
loop.body5:
  %t31 = load i64, i64* %l6
  %t32 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t33 = icmp sge i64 %t31, %t32
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t35 = load i8*, i8** %l1
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
  %t42 = sitofp i64 %t41 to double
  %t43 = call i8* @char_at(i8* %text, double %t42)
  store i8* %t43, i8** %l7
  %t44 = load i8*, i8** %l7
  %t45 = call double @char_code(i8* %t44)
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
  %t60 = load i8*, i8** %l1
  %t61 = load double, double* %l2
  %t62 = load double, double* %l3
  %t63 = load i1, i1* %l4
  %t64 = load i64, i64* %l5
  %t65 = load i64, i64* %l6
  %t66 = load i8*, i8** %l7
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
  %t75 = load i8*, i8** %l1
  %t76 = load double, double* %l2
  %t77 = load double, double* %l3
  %t78 = load i1, i1* %l4
  %t79 = load i64, i64* %l5
  %t80 = load i64, i64* %l6
  %t81 = load i8*, i8** %l7
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
  %t90 = load i8*, i8** %l1
  %t91 = load double, double* %l2
  %t92 = load double, double* %l3
  %t93 = load i1, i1* %l4
  %t94 = load i64, i64* %l5
  %t95 = load i64, i64* %l6
  %t96 = load i8*, i8** %l7
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
  %t104 = load i8*, i8** %l1
  %t105 = load double, double* %l2
  %t106 = load double, double* %l3
  %t107 = load i1, i1* %l4
  %t108 = load i64, i64* %l5
  %t109 = load i64, i64* %l6
  %t110 = load i8*, i8** %l7
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
  %t117 = load i1, i1* %l11
  br label %logical_and_entry_116

logical_and_entry_116:
  br i1 %t117, label %logical_and_right_116, label %logical_and_merge_116

logical_and_right_116:
  %t119 = load i1, i1* %l4
  br label %logical_and_entry_118

logical_and_entry_118:
  br i1 %t119, label %logical_and_right_118, label %logical_and_merge_118

logical_and_right_118:
  %t120 = load i64, i64* %l5
  %t121 = srem i64 %t120, 2
  %t122 = icmp eq i64 %t121, 1
  br label %logical_and_right_end_118

logical_and_right_end_118:
  br label %logical_and_merge_118

logical_and_merge_118:
  %t123 = phi i1 [ false, %logical_and_entry_118 ], [ %t122, %logical_and_right_end_118 ]
  br label %logical_and_right_end_116

logical_and_right_end_116:
  br label %logical_and_merge_116

logical_and_merge_116:
  %t124 = phi i1 [ false, %logical_and_entry_116 ], [ %t123, %logical_and_right_end_116 ]
  %t125 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t126 = load i8*, i8** %l1
  %t127 = load double, double* %l2
  %t128 = load double, double* %l3
  %t129 = load i1, i1* %l4
  %t130 = load i64, i64* %l5
  %t131 = load i64, i64* %l6
  %t132 = load i8*, i8** %l7
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
  %t145 = load i8*, i8** %l1
  %t146 = load double, double* %l2
  %t147 = load double, double* %l3
  %t148 = load i1, i1* %l4
  %t149 = load i64, i64* %l5
  %t150 = load i64, i64* %l6
  %t151 = load i8*, i8** %l7
  %t152 = load double, double* %l8
  %t153 = load double, double* %l9
  %t154 = load i1, i1* %l10
  %t155 = load i1, i1* %l11
  %t156 = load i1, i1* %l12
  br i1 %t143, label %then25, label %else26
then25:
  %t157 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t158 = load i8*, i8** %l1
  %t159 = alloca [1 x i8*]
  %t160 = getelementptr [1 x i8*], [1 x i8*]* %t159, i32 0, i32 0
  %t161 = getelementptr i8*, i8** %t160, i64 0
  store i8* %t158, i8** %t161
  %t162 = alloca { i8**, i64 }
  %t163 = getelementptr { i8**, i64 }, { i8**, i64 }* %t162, i32 0, i32 0
  store i8** %t160, i8*** %t163
  %t164 = getelementptr { i8**, i64 }, { i8**, i64 }* %t162, i32 0, i32 1
  store i64 1, i64* %t164
  %t165 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t157, { i8**, i64 }* %t162)
  store { i8**, i64 }* %t165, { i8**, i64 }** %l0
  %t166 = load i8*, i8** %l7
  store i8* %t166, i8** %l1
  %t167 = load i1, i1* %l11
  %t168 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t169 = load i8*, i8** %l1
  %t170 = load double, double* %l2
  %t171 = load double, double* %l3
  %t172 = load i1, i1* %l4
  %t173 = load i64, i64* %l5
  %t174 = load i64, i64* %l6
  %t175 = load i8*, i8** %l7
  %t176 = load double, double* %l8
  %t177 = load double, double* %l9
  %t178 = load i1, i1* %l10
  %t179 = load i1, i1* %l11
  %t180 = load i1, i1* %l12
  br i1 %t167, label %then28, label %else29
then28:
  store i64 1, i64* %l5
  br label %merge30
else29:
  store i64 0, i64* %l5
  br label %merge30
merge30:
  %t181 = phi i64 [ 1, %then28 ], [ 0, %else29 ]
  store i64 %t181, i64* %l5
  br label %merge27
else26:
  %t182 = load i8*, i8** %l1
  %t183 = load i8*, i8** %l7
  %t184 = add i8* %t182, %t183
  store i8* %t184, i8** %l1
  %t185 = load i1, i1* %l11
  %t186 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t187 = load i8*, i8** %l1
  %t188 = load double, double* %l2
  %t189 = load double, double* %l3
  %t190 = load i1, i1* %l4
  %t191 = load i64, i64* %l5
  %t192 = load i64, i64* %l6
  %t193 = load i8*, i8** %l7
  %t194 = load double, double* %l8
  %t195 = load double, double* %l9
  %t196 = load i1, i1* %l10
  %t197 = load i1, i1* %l11
  %t198 = load i1, i1* %l12
  br i1 %t185, label %then31, label %else32
then31:
  %t199 = load i64, i64* %l5
  %t200 = add i64 %t199, 1
  store i64 %t200, i64* %l5
  br label %merge33
else32:
  %t202 = load double, double* %l9
  %t203 = fcmp one double %t202, 0.0
  br label %logical_and_entry_201

logical_and_entry_201:
  br i1 %t203, label %logical_and_right_201, label %logical_and_merge_201

logical_and_right_201:
  %t204 = load i1, i1* %l10
  %t205 = xor i1 %t204, 1
  br label %logical_and_right_end_201

logical_and_right_end_201:
  br label %logical_and_merge_201

logical_and_merge_201:
  %t206 = phi i1 [ false, %logical_and_entry_201 ], [ %t205, %logical_and_right_end_201 ]
  %t207 = xor i1 %t206, 1
  %t208 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t209 = load i8*, i8** %l1
  %t210 = load double, double* %l2
  %t211 = load double, double* %l3
  %t212 = load i1, i1* %l4
  %t213 = load i64, i64* %l5
  %t214 = load i64, i64* %l6
  %t215 = load i8*, i8** %l7
  %t216 = load double, double* %l8
  %t217 = load double, double* %l9
  %t218 = load i1, i1* %l10
  %t219 = load i1, i1* %l11
  %t220 = load i1, i1* %l12
  br i1 %t207, label %then34, label %merge35
then34:
  store i64 0, i64* %l5
  br label %merge35
merge35:
  %t221 = phi i64 [ 0, %then34 ], [ %t213, %else32 ]
  store i64 %t221, i64* %l5
  br label %merge33
merge33:
  %t222 = phi i64 [ %t200, %then31 ], [ 0, %else32 ]
  store i64 %t222, i64* %l5
  br label %merge27
merge27:
  %t223 = phi { i8**, i64 }* [ %t165, %then25 ], [ %t144, %else26 ]
  %t224 = phi i8* [ %t166, %then25 ], [ %t184, %else26 ]
  %t225 = phi i64 [ 1, %then25 ], [ %t200, %else26 ]
  store { i8**, i64 }* %t223, { i8**, i64 }** %l0
  store i8* %t224, i8** %l1
  store i64 %t225, i64* %l5
  %t226 = load double, double* %l8
  store double %t226, double* %l2
  %t227 = load double, double* %l9
  store double %t227, double* %l3
  %t228 = load double, double* %l9
  %t229 = fcmp one double %t228, 0.0
  %t230 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t231 = load i8*, i8** %l1
  %t232 = load double, double* %l2
  %t233 = load double, double* %l3
  %t234 = load i1, i1* %l4
  %t235 = load i64, i64* %l5
  %t236 = load i64, i64* %l6
  %t237 = load i8*, i8** %l7
  %t238 = load double, double* %l8
  %t239 = load double, double* %l9
  %t240 = load i1, i1* %l10
  %t241 = load i1, i1* %l11
  %t242 = load i1, i1* %l12
  br i1 %t229, label %then36, label %else37
then36:
  store i1 0, i1* %l4
  store i64 0, i64* %l5
  br label %merge38
else37:
  %t243 = load i1, i1* %l10
  %t244 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t245 = load i8*, i8** %l1
  %t246 = load double, double* %l2
  %t247 = load double, double* %l3
  %t248 = load i1, i1* %l4
  %t249 = load i64, i64* %l5
  %t250 = load i64, i64* %l6
  %t251 = load i8*, i8** %l7
  %t252 = load double, double* %l8
  %t253 = load double, double* %l9
  %t254 = load i1, i1* %l10
  %t255 = load i1, i1* %l11
  %t256 = load i1, i1* %l12
  br i1 %t243, label %then39, label %else40
then39:
  br label %merge41
else40:
  %t257 = load i1, i1* %l11
  store i1 %t257, i1* %l4
  %t258 = load i1, i1* %l11
  %t259 = xor i1 %t258, 1
  %t260 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t261 = load i8*, i8** %l1
  %t262 = load double, double* %l2
  %t263 = load double, double* %l3
  %t264 = load i1, i1* %l4
  %t265 = load i64, i64* %l5
  %t266 = load i64, i64* %l6
  %t267 = load i8*, i8** %l7
  %t268 = load double, double* %l8
  %t269 = load double, double* %l9
  %t270 = load i1, i1* %l10
  %t271 = load i1, i1* %l11
  %t272 = load i1, i1* %l12
  br i1 %t259, label %then42, label %merge43
then42:
  store i64 0, i64* %l5
  br label %merge43
merge43:
  %t273 = phi i64 [ 0, %then42 ], [ %t265, %else40 ]
  store i64 %t273, i64* %l5
  br label %merge41
merge41:
  %t274 = phi i1 [ %t248, %then39 ], [ %t257, %else40 ]
  %t275 = phi i64 [ %t249, %then39 ], [ 0, %else40 ]
  store i1 %t274, i1* %l4
  store i64 %t275, i64* %l5
  br label %merge38
merge38:
  %t276 = phi i1 [ 0, %then36 ], [ %t257, %else37 ]
  %t277 = phi i64 [ 0, %then36 ], [ 0, %else37 ]
  store i1 %t276, i1* %l4
  store i64 %t277, i64* %l5
  %t278 = load i64, i64* %l6
  %t279 = add i64 %t278, 1
  store i64 %t279, i64* %l6
  br label %loop.latch6
loop.latch6:
  %t280 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t281 = load i8*, i8** %l1
  %t282 = load i64, i64* %l5
  %t283 = load double, double* %l2
  %t284 = load double, double* %l3
  %t285 = load i1, i1* %l4
  %t286 = load i64, i64* %l6
  br label %loop.header4
afterloop7:
  %t294 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t295 = load i8*, i8** %l1
  %t296 = alloca [1 x i8*]
  %t297 = getelementptr [1 x i8*], [1 x i8*]* %t296, i32 0, i32 0
  %t298 = getelementptr i8*, i8** %t297, i64 0
  store i8* %t295, i8** %t298
  %t299 = alloca { i8**, i64 }
  %t300 = getelementptr { i8**, i64 }, { i8**, i64 }* %t299, i32 0, i32 0
  store i8** %t297, i8*** %t300
  %t301 = getelementptr { i8**, i64 }, { i8**, i64 }* %t299, i32 0, i32 1
  store i64 1, i64* %t301
  %t302 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t294, { i8**, i64 }* %t299)
  store { i8**, i64 }* %t302, { i8**, i64 }** %l0
  %t303 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t303
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
