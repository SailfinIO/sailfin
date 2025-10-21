; ModuleID = 'sailfin'
source_filename = "sailfin"

%EnumField = type { i8*, i8* }
%EnumVariantDefinition = type { i8*, { i8**, i64 }* }
%EnumType = type { i8*, { %EnumVariantDefinition**, i64 }* }
%EnumInstance = type { %EnumType, i8*, { %EnumField**, i64 }* }
%StructField = type { i8*, i8* }
%TypeDescriptor = type { i8*, i8*, { %TypeDescriptor**, i64 }* }

declare i8* @sailfin_runtime_substring(i8*, i64, i64)
declare double @char_code(i8*)

declare noalias i8* @malloc(i64)

@runtime = external global i8**

@.str.0 = private unnamed_addr constant [1 x i8] c"\00"
@.str.21 = private unnamed_addr constant [1 x i8] c"\00"
@.str.5 = private unnamed_addr constant [11 x i8] c"0123456789\00"
@.str.19 = private unnamed_addr constant [27 x i8] c"abcdefghijklmnopqrstuvwxyz\00"
@.str.35 = private unnamed_addr constant [27 x i8] c"ABCDEFGHIJKLMNOPQRSTUVWXYZ\00"
@.str.131 = private unnamed_addr constant [6 x i8] c"utf-8\00"

; fn sleep effects: ![clock]
define void @sleep(double %milliseconds) {
entry:
  %t0 = load i8*, i8** @runtime
  %t1 = call double @runtimesleep(double %milliseconds)
  ret void
}

; fn channel effects: ![io]
define void @channel(double %capacity) {
entry:
  %t0 = load i8*, i8** @runtime
  %t1 = call double @runtimechannel(double %capacity)
  ret void
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
  %t2 = load i8*, i8** @runtime
  %t3 = call double @runtimespawn(i8* %task)
  ret void
merge1:
  %t4 = load i8*, i8** @runtime
  %t5 = call double @runtimespawn(i8* %task, i8* %name)
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
  %t10 = fptosi double %index to i64
  %t11 = getelementptr i8, i8* %value, i64 %t10
  %t12 = load i8, i8* %t11
  %t13 = alloca [2 x i8], align 1
  %t14 = getelementptr [2 x i8], [2 x i8]* %t13, i32 0, i32 0
  store i8 %t12, i8* %t14
  %t15 = getelementptr [2 x i8], [2 x i8]* %t13, i32 0, i32 1
  store i8 0, i8* %t15
  %t16 = getelementptr [2 x i8], [2 x i8]* %t13, i32 0, i32 0
  ret i8* %t16
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
  %t4 = call noalias i8* @malloc(i64 16)
  %t5 = bitcast i8* %t4 to %EnumVariantDefinition*
  store %EnumVariantDefinition %t3, %EnumVariantDefinition* %t5
  %t6 = alloca [1 x i8*]
  %t7 = getelementptr [1 x i8*], [1 x i8*]* %t6, i32 0, i32 0
  %t8 = getelementptr i8*, i8** %t7, i64 0
  store i8* %t4, i8** %t8
  %t9 = alloca { i8**, i64 }
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 0
  store i8** %t7, i8*** %t10
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 1
  store i64 1, i64* %t11
  %t12 = bitcast { %EnumVariantDefinition**, i64 }* %t2 to { i8**, i64 }*
  %t13 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t12, { i8**, i64 }* %t9)
  store { i8**, i64 }* %t13, { i8**, i64 }** %l1
  %t14 = extractvalue %EnumType %enum_type, 0
  %t15 = insertvalue %EnumType undef, i8* %t14, 0
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t17 = bitcast { i8**, i64 }* %t16 to { %EnumVariantDefinition**, i64 }*
  %t18 = insertvalue %EnumType %t15, { %EnumVariantDefinition**, i64 }* %t17, 1
  ret %EnumType %t18
}

define %EnumField* @enum_lookup_field({ %EnumField*, i64 }* %fields, i8* %name) {
entry:
  %l0 = alloca i64
  %l1 = alloca %EnumField
  store i64 0, i64* %l0
  %t0 = load i64, i64* %l0
  br label %loop.header0
loop.header0:
  %t23 = phi i64 [ %t0, %entry ], [ %t22, %loop.latch2 ]
  store i64 %t23, i64* %l0
  br label %loop.body1
loop.body1:
  %t1 = load i64, i64* %l0
  %t2 = load { %EnumField*, i64 }, { %EnumField*, i64 }* %fields
  %t3 = extractvalue { %EnumField*, i64 } %t2, 1
  %t4 = icmp sge i64 %t1, %t3
  %t5 = load i64, i64* %l0
  br i1 %t4, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t6 = load i64, i64* %l0
  %t7 = load { %EnumField*, i64 }, { %EnumField*, i64 }* %fields
  %t8 = extractvalue { %EnumField*, i64 } %t7, 0
  %t9 = extractvalue { %EnumField*, i64 } %t7, 1
  %t10 = icmp uge i64 %t6, %t9
  ; bounds check: %t10 (if true, out of bounds)
  %t11 = getelementptr %EnumField, %EnumField* %t8, i64 %t6
  %t12 = load %EnumField, %EnumField* %t11
  store %EnumField %t12, %EnumField* %l1
  %t13 = load %EnumField, %EnumField* %l1
  %t14 = extractvalue %EnumField %t13, 0
  %t15 = icmp eq i8* %t14, %name
  %t16 = load i64, i64* %l0
  %t17 = load %EnumField, %EnumField* %l1
  br i1 %t15, label %then6, label %merge7
then6:
  %t18 = load %EnumField, %EnumField* %l1
  %t19 = alloca %EnumField
  store %EnumField %t18, %EnumField* %t19
  ret %EnumField* %t19
merge7:
  %t20 = load i64, i64* %l0
  %t21 = add i64 %t20, 1
  store i64 %t21, i64* %l0
  br label %loop.latch2
loop.latch2:
  %t22 = load i64, i64* %l0
  br label %loop.header0
afterloop3:
  %t24 = bitcast i8* null to %EnumField*
  ret %EnumField* %t24
}

define %EnumVariantDefinition* @enum_find_variant(%EnumType %enum_type, i8* %variant_name) {
entry:
  %l0 = alloca i64
  %l1 = alloca %EnumVariantDefinition*
  store i64 0, i64* %l0
  %t0 = load i64, i64* %l0
  br label %loop.header0
loop.header0:
  %t25 = phi i64 [ %t0, %entry ], [ %t24, %loop.latch2 ]
  store i64 %t25, i64* %l0
  br label %loop.body1
loop.body1:
  %t1 = load i64, i64* %l0
  %t2 = extractvalue %EnumType %enum_type, 1
  %t3 = load { %EnumVariantDefinition**, i64 }, { %EnumVariantDefinition**, i64 }* %t2
  %t4 = extractvalue { %EnumVariantDefinition**, i64 } %t3, 1
  %t5 = icmp sge i64 %t1, %t4
  %t6 = load i64, i64* %l0
  br i1 %t5, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t7 = extractvalue %EnumType %enum_type, 1
  %t8 = load i64, i64* %l0
  %t9 = load { %EnumVariantDefinition**, i64 }, { %EnumVariantDefinition**, i64 }* %t7
  %t10 = extractvalue { %EnumVariantDefinition**, i64 } %t9, 0
  %t11 = extractvalue { %EnumVariantDefinition**, i64 } %t9, 1
  %t12 = icmp uge i64 %t8, %t11
  ; bounds check: %t12 (if true, out of bounds)
  %t13 = getelementptr %EnumVariantDefinition*, %EnumVariantDefinition** %t10, i64 %t8
  %t14 = load %EnumVariantDefinition*, %EnumVariantDefinition** %t13
  store %EnumVariantDefinition* %t14, %EnumVariantDefinition** %l1
  %t15 = load %EnumVariantDefinition*, %EnumVariantDefinition** %l1
  %t16 = getelementptr %EnumVariantDefinition, %EnumVariantDefinition* %t15, i32 0, i32 0
  %t17 = load i8*, i8** %t16
  %t18 = icmp eq i8* %t17, %variant_name
  %t19 = load i64, i64* %l0
  %t20 = load %EnumVariantDefinition*, %EnumVariantDefinition** %l1
  br i1 %t18, label %then6, label %merge7
then6:
  %t21 = load %EnumVariantDefinition*, %EnumVariantDefinition** %l1
  ret %EnumVariantDefinition* %t21
merge7:
  %t22 = load i64, i64* %l0
  %t23 = add i64 %t22, 1
  store i64 %t23, i64* %l0
  br label %loop.latch2
loop.latch2:
  %t24 = load i64, i64* %l0
  br label %loop.header0
afterloop3:
  %t26 = bitcast i8* null to %EnumVariantDefinition*
  ret %EnumVariantDefinition* %t26
}

define { %EnumField*, i64 }* @enum_normalize_fields(%EnumVariantDefinition* %definition, { %EnumField*, i64 }* %provided) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { %EnumField*, i64 }*
  %l2 = alloca i64
  %l3 = alloca i8*
  %l4 = alloca %EnumField*
  %l5 = alloca i8*
  %t0 = icmp eq %EnumVariantDefinition* %definition, null
  br i1 %t0, label %then0, label %merge1
then0:
  ret { %EnumField*, i64 }* %provided
merge1:
  %t1 = getelementptr %EnumVariantDefinition, %EnumVariantDefinition* %definition, i32 0, i32 1
  %t2 = load { i8**, i64 }*, { i8**, i64 }** %t1
  store { i8**, i64 }* %t2, { i8**, i64 }** %l0
  %t3 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t4 = load { i8**, i64 }, { i8**, i64 }* %t3
  %t5 = extractvalue { i8**, i64 } %t4, 1
  %t6 = icmp eq i64 %t5, 0
  %t7 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br i1 %t6, label %then2, label %merge3
then2:
  %t8 = alloca [0 x %EnumField]
  %t9 = getelementptr [0 x %EnumField], [0 x %EnumField]* %t8, i32 0, i32 0
  %t10 = alloca { %EnumField*, i64 }
  %t11 = getelementptr { %EnumField*, i64 }, { %EnumField*, i64 }* %t10, i32 0, i32 0
  store %EnumField* %t9, %EnumField** %t11
  %t12 = getelementptr { %EnumField*, i64 }, { %EnumField*, i64 }* %t10, i32 0, i32 1
  store i64 0, i64* %t12
  ret { %EnumField*, i64 }* %t10
merge3:
  %t13 = alloca [0 x %EnumField]
  %t14 = getelementptr [0 x %EnumField], [0 x %EnumField]* %t13, i32 0, i32 0
  %t15 = alloca { %EnumField*, i64 }
  %t16 = getelementptr { %EnumField*, i64 }, { %EnumField*, i64 }* %t15, i32 0, i32 0
  store %EnumField* %t14, %EnumField** %t16
  %t17 = getelementptr { %EnumField*, i64 }, { %EnumField*, i64 }* %t15, i32 0, i32 1
  store i64 0, i64* %t17
  store { %EnumField*, i64 }* %t15, { %EnumField*, i64 }** %l1
  store i64 0, i64* %l2
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t19 = load { %EnumField*, i64 }*, { %EnumField*, i64 }** %l1
  %t20 = load i64, i64* %l2
  br label %loop.header4
loop.header4:
  %t71 = phi { %EnumField*, i64 }* [ %t19, %entry ], [ %t69, %loop.latch6 ]
  %t72 = phi i64 [ %t20, %entry ], [ %t70, %loop.latch6 ]
  store { %EnumField*, i64 }* %t71, { %EnumField*, i64 }** %l1
  store i64 %t72, i64* %l2
  br label %loop.body5
loop.body5:
  %t21 = load i64, i64* %l2
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t23 = load { i8**, i64 }, { i8**, i64 }* %t22
  %t24 = extractvalue { i8**, i64 } %t23, 1
  %t25 = icmp sge i64 %t21, %t24
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t27 = load { %EnumField*, i64 }*, { %EnumField*, i64 }** %l1
  %t28 = load i64, i64* %l2
  br i1 %t25, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t30 = load i64, i64* %l2
  %t31 = load { i8**, i64 }, { i8**, i64 }* %t29
  %t32 = extractvalue { i8**, i64 } %t31, 0
  %t33 = extractvalue { i8**, i64 } %t31, 1
  %t34 = icmp uge i64 %t30, %t33
  ; bounds check: %t34 (if true, out of bounds)
  %t35 = getelementptr i8*, i8** %t32, i64 %t30
  %t36 = load i8*, i8** %t35
  store i8* %t36, i8** %l3
  %t37 = load i8*, i8** %l3
  %t38 = call %EnumField* @enum_lookup_field({ %EnumField*, i64 }* %provided, i8* %t37)
  store %EnumField* %t38, %EnumField** %l4
  store i8* null, i8** %l5
  %t39 = load %EnumField*, %EnumField** %l4
  %t40 = icmp ne %EnumField* %t39, null
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t42 = load { %EnumField*, i64 }*, { %EnumField*, i64 }** %l1
  %t43 = load i64, i64* %l2
  %t44 = load i8*, i8** %l3
  %t45 = load %EnumField*, %EnumField** %l4
  %t46 = load i8*, i8** %l5
  br i1 %t40, label %then10, label %merge11
then10:
  %t47 = load %EnumField*, %EnumField** %l4
  %t48 = getelementptr %EnumField, %EnumField* %t47, i32 0, i32 1
  %t49 = load i8*, i8** %t48
  store i8* %t49, i8** %l5
  br label %merge11
merge11:
  %t50 = phi i8* [ %t49, %then10 ], [ %t46, %loop.body5 ]
  store i8* %t50, i8** %l5
  %t51 = load { %EnumField*, i64 }*, { %EnumField*, i64 }** %l1
  %t52 = load i8*, i8** %l3
  %t53 = insertvalue %EnumField undef, i8* %t52, 0
  %t54 = load i8*, i8** %l5
  %t55 = insertvalue %EnumField %t53, i8* %t54, 1
  %t56 = call noalias i8* @malloc(i64 16)
  %t57 = bitcast i8* %t56 to %EnumField*
  store %EnumField %t55, %EnumField* %t57
  %t58 = alloca [1 x i8*]
  %t59 = getelementptr [1 x i8*], [1 x i8*]* %t58, i32 0, i32 0
  %t60 = getelementptr i8*, i8** %t59, i64 0
  store i8* %t56, i8** %t60
  %t61 = alloca { i8**, i64 }
  %t62 = getelementptr { i8**, i64 }, { i8**, i64 }* %t61, i32 0, i32 0
  store i8** %t59, i8*** %t62
  %t63 = getelementptr { i8**, i64 }, { i8**, i64 }* %t61, i32 0, i32 1
  store i64 1, i64* %t63
  %t64 = bitcast { %EnumField*, i64 }* %t51 to { i8**, i64 }*
  %t65 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t64, { i8**, i64 }* %t61)
  %t66 = bitcast { i8**, i64 }* %t65 to { %EnumField*, i64 }*
  store { %EnumField*, i64 }* %t66, { %EnumField*, i64 }** %l1
  %t67 = load i64, i64* %l2
  %t68 = add i64 %t67, 1
  store i64 %t68, i64* %l2
  br label %loop.latch6
loop.latch6:
  %t69 = load { %EnumField*, i64 }*, { %EnumField*, i64 }** %l1
  %t70 = load i64, i64* %l2
  br label %loop.header4
afterloop7:
  %t73 = load { %EnumField*, i64 }*, { %EnumField*, i64 }** %l1
  ret { %EnumField*, i64 }* %t73
}

define %EnumInstance @enum_instantiate(%EnumType %enum_type, i8* %variant_name, { %EnumField*, i64 }* %provided) {
entry:
  %l0 = alloca %EnumVariantDefinition*
  %l1 = alloca { %EnumField*, i64 }*
  %t0 = call %EnumVariantDefinition* @enum_find_variant(%EnumType %enum_type, i8* %variant_name)
  store %EnumVariantDefinition* %t0, %EnumVariantDefinition** %l0
  %t1 = load %EnumVariantDefinition*, %EnumVariantDefinition** %l0
  %t2 = call { %EnumField*, i64 }* @enum_normalize_fields(%EnumVariantDefinition* %t1, { %EnumField*, i64 }* %provided)
  store { %EnumField*, i64 }* %t2, { %EnumField*, i64 }** %l1
  %t3 = insertvalue %EnumInstance undef, %EnumType %enum_type, 0
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
  %t0 = load i8, i8* %name
  %t1 = add i8 %t0, 40
  store i8 %t1, i8* %l0
  store i64 0, i64* %l1
  %t2 = load i8, i8* %l0
  %t3 = load i64, i64* %l1
  br label %loop.header0
loop.header0:
  %t42 = phi i8 [ %t2, %entry ], [ %t40, %loop.latch2 ]
  %t43 = phi i64 [ %t3, %entry ], [ %t41, %loop.latch2 ]
  store i8 %t42, i8* %l0
  store i64 %t43, i64* %l1
  br label %loop.body1
loop.body1:
  %t4 = load i64, i64* %l1
  %t5 = load { %StructField*, i64 }, { %StructField*, i64 }* %fields
  %t6 = extractvalue { %StructField*, i64 } %t5, 1
  %t7 = icmp sge i64 %t4, %t6
  %t8 = load i8, i8* %l0
  %t9 = load i64, i64* %l1
  br i1 %t7, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t10 = load i64, i64* %l1
  %t11 = icmp sgt i64 %t10, 0
  %t12 = load i8, i8* %l0
  %t13 = load i64, i64* %l1
  br i1 %t11, label %then6, label %merge7
then6:
  %t14 = load i8, i8* %l0
  %s15 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.15, i32 0, i32 0
  %t16 = load i8, i8* %s15
  %t17 = add i8 %t14, %t16
  store i8 %t17, i8* %l0
  br label %merge7
merge7:
  %t18 = phi i8 [ %t17, %then6 ], [ %t12, %loop.body1 ]
  store i8 %t18, i8* %l0
  %t19 = load i64, i64* %l1
  %t20 = load { %StructField*, i64 }, { %StructField*, i64 }* %fields
  %t21 = extractvalue { %StructField*, i64 } %t20, 0
  %t22 = extractvalue { %StructField*, i64 } %t20, 1
  %t23 = icmp uge i64 %t19, %t22
  ; bounds check: %t23 (if true, out of bounds)
  %t24 = getelementptr %StructField, %StructField* %t21, i64 %t19
  %t25 = load %StructField, %StructField* %t24
  store %StructField %t25, %StructField* %l2
  %t26 = load %StructField, %StructField* %l2
  %t27 = extractvalue %StructField %t26, 1
  %t28 = call i8* @to_debug_string(i8* %t27)
  store i8* %t28, i8** %l3
  %t29 = load i8, i8* %l0
  %t30 = load %StructField, %StructField* %l2
  %t31 = extractvalue %StructField %t30, 0
  %t32 = load i8, i8* %t31
  %t33 = add i8 %t29, %t32
  %t34 = add i8 %t33, 61
  %t35 = load i8*, i8** %l3
  %t36 = load i8, i8* %t35
  %t37 = add i8 %t34, %t36
  store i8 %t37, i8* %l0
  %t38 = load i64, i64* %l1
  %t39 = add i64 %t38, 1
  store i64 %t39, i64* %l1
  br label %loop.latch2
loop.latch2:
  %t40 = load i8, i8* %l0
  %t41 = load i64, i64* %l1
  br label %loop.header0
afterloop3:
  %t44 = load i8, i8* %l0
  %t45 = add i8 %t44, 41
  store i8 %t45, i8* %l0
  %t46 = load i8, i8* %l0
  %t47 = alloca [2 x i8], align 1
  %t48 = getelementptr [2 x i8], [2 x i8]* %t47, i32 0, i32 0
  store i8 %t46, i8* %t48
  %t49 = getelementptr [2 x i8], [2 x i8]* %t47, i32 0, i32 1
  store i8 0, i8* %t49
  %t50 = getelementptr [2 x i8], [2 x i8]* %t47, i32 0, i32 0
  ret i8* %t50
}

define i8* @to_debug_string(i8* %value) {
entry:
  %t0 = load i8*, i8** @runtime
  %t1 = call double @runtimeto_debug_string(i8* %value)
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
  %t1 = alloca [0 x %TypeDescriptor]
  %t2 = getelementptr [0 x %TypeDescriptor], [0 x %TypeDescriptor]* %t1, i32 0, i32 0
  %t3 = alloca { %TypeDescriptor*, i64 }
  %t4 = getelementptr { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* %t3, i32 0, i32 0
  store %TypeDescriptor* %t2, %TypeDescriptor** %t4
  %t5 = getelementptr { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  %t6 = call %TypeDescriptor @type_descriptor(i8* %s0, i8* %name, { %TypeDescriptor*, i64 }* %t3)
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
  %t1 = alloca [0 x %TypeDescriptor]
  %t2 = getelementptr [0 x %TypeDescriptor], [0 x %TypeDescriptor]* %t1, i32 0, i32 0
  %t3 = alloca { %TypeDescriptor*, i64 }
  %t4 = getelementptr { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* %t3, i32 0, i32 0
  store %TypeDescriptor* %t2, %TypeDescriptor** %t4
  %t5 = getelementptr { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  %t6 = call %TypeDescriptor @type_descriptor(i8* %s0, i8* null, { %TypeDescriptor*, i64 }* %t3)
  ret %TypeDescriptor %t6
}

define %TypeDescriptor @type_descriptor_named(i8* %name) {
entry:
  %s0 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.0, i32 0, i32 0
  %t1 = alloca [0 x %TypeDescriptor]
  %t2 = getelementptr [0 x %TypeDescriptor], [0 x %TypeDescriptor]* %t1, i32 0, i32 0
  %t3 = alloca { %TypeDescriptor*, i64 }
  %t4 = getelementptr { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* %t3, i32 0, i32 0
  store %TypeDescriptor* %t2, %TypeDescriptor** %t4
  %t5 = getelementptr { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  %t6 = call %TypeDescriptor @type_descriptor(i8* %s0, i8* %name, { %TypeDescriptor*, i64 }* %t3)
  ret %TypeDescriptor %t6
}

define %TypeDescriptor @type_descriptor_unknown() {
entry:
  %s0 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.0, i32 0, i32 0
  %t1 = alloca [0 x %TypeDescriptor]
  %t2 = getelementptr [0 x %TypeDescriptor], [0 x %TypeDescriptor]* %t1, i32 0, i32 0
  %t3 = alloca { %TypeDescriptor*, i64 }
  %t4 = getelementptr { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* %t3, i32 0, i32 0
  store %TypeDescriptor* %t2, %TypeDescriptor** %t4
  %t5 = getelementptr { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  %t6 = call %TypeDescriptor @type_descriptor(i8* %s0, i8* null, { %TypeDescriptor*, i64 }* %t3)
  ret %TypeDescriptor %t6
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
  %t35 = phi i64 [ %t1, %entry ], [ %t34, %loop.latch2 ]
  store i64 %t35, i64* %l0
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
  %t13 = load i8, i8* %t12
  %t14 = icmp eq i8 %t13, 32
  br label %logical_or_entry_11

logical_or_entry_11:
  br i1 %t14, label %logical_or_merge_11, label %logical_or_right_11

logical_or_right_11:
  %t16 = load i8*, i8** %l2
  %t17 = load i8, i8* %t16
  %t18 = icmp eq i8 %t17, 10
  br label %logical_or_entry_15

logical_or_entry_15:
  br i1 %t18, label %logical_or_merge_15, label %logical_or_right_15

logical_or_right_15:
  %t20 = load i8*, i8** %l2
  %t21 = load i8, i8* %t20
  %t22 = icmp eq i8 %t21, 9
  br label %logical_or_entry_19

logical_or_entry_19:
  br i1 %t22, label %logical_or_merge_19, label %logical_or_right_19

logical_or_right_19:
  %t23 = load i8*, i8** %l2
  %t24 = load i8, i8* %t23
  %t25 = icmp eq i8 %t24, 13
  br label %logical_or_right_end_19

logical_or_right_end_19:
  br label %logical_or_merge_19

logical_or_merge_19:
  %t26 = phi i1 [ true, %logical_or_entry_19 ], [ %t25, %logical_or_right_end_19 ]
  br label %logical_or_right_end_15

logical_or_right_end_15:
  br label %logical_or_merge_15

logical_or_merge_15:
  %t27 = phi i1 [ true, %logical_or_entry_15 ], [ %t26, %logical_or_right_end_15 ]
  br label %logical_or_right_end_11

logical_or_right_end_11:
  br label %logical_or_merge_11

logical_or_merge_11:
  %t28 = phi i1 [ true, %logical_or_entry_11 ], [ %t27, %logical_or_right_end_11 ]
  %t29 = load i64, i64* %l0
  %t30 = load i64, i64* %l1
  %t31 = load i8*, i8** %l2
  br i1 %t28, label %then6, label %merge7
then6:
  %t32 = load i64, i64* %l0
  %t33 = add i64 %t32, 1
  store i64 %t33, i64* %l0
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  %t34 = load i64, i64* %l0
  br label %loop.header0
afterloop3:
  %t36 = load i64, i64* %l0
  %t37 = load i64, i64* %l1
  br label %loop.header8
loop.header8:
  %t71 = phi i64 [ %t37, %entry ], [ %t70, %loop.latch10 ]
  store i64 %t71, i64* %l1
  br label %loop.body9
loop.body9:
  %t38 = load i64, i64* %l1
  %t39 = load i64, i64* %l0
  %t40 = icmp sle i64 %t38, %t39
  %t41 = load i64, i64* %l0
  %t42 = load i64, i64* %l1
  br i1 %t40, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t43 = load i64, i64* %l1
  %t44 = sub i64 %t43, 1
  %t45 = sitofp i64 %t44 to double
  %t46 = call i8* @char_at(i8* %value, double %t45)
  store i8* %t46, i8** %l3
  %t48 = load i8*, i8** %l3
  %t49 = load i8, i8* %t48
  %t50 = icmp eq i8 %t49, 32
  br label %logical_or_entry_47

logical_or_entry_47:
  br i1 %t50, label %logical_or_merge_47, label %logical_or_right_47

logical_or_right_47:
  %t52 = load i8*, i8** %l3
  %t53 = load i8, i8* %t52
  %t54 = icmp eq i8 %t53, 10
  br label %logical_or_entry_51

logical_or_entry_51:
  br i1 %t54, label %logical_or_merge_51, label %logical_or_right_51

logical_or_right_51:
  %t56 = load i8*, i8** %l3
  %t57 = load i8, i8* %t56
  %t58 = icmp eq i8 %t57, 9
  br label %logical_or_entry_55

logical_or_entry_55:
  br i1 %t58, label %logical_or_merge_55, label %logical_or_right_55

logical_or_right_55:
  %t59 = load i8*, i8** %l3
  %t60 = load i8, i8* %t59
  %t61 = icmp eq i8 %t60, 13
  br label %logical_or_right_end_55

logical_or_right_end_55:
  br label %logical_or_merge_55

logical_or_merge_55:
  %t62 = phi i1 [ true, %logical_or_entry_55 ], [ %t61, %logical_or_right_end_55 ]
  br label %logical_or_right_end_51

logical_or_right_end_51:
  br label %logical_or_merge_51

logical_or_merge_51:
  %t63 = phi i1 [ true, %logical_or_entry_51 ], [ %t62, %logical_or_right_end_51 ]
  br label %logical_or_right_end_47

logical_or_right_end_47:
  br label %logical_or_merge_47

logical_or_merge_47:
  %t64 = phi i1 [ true, %logical_or_entry_47 ], [ %t63, %logical_or_right_end_47 ]
  %t65 = load i64, i64* %l0
  %t66 = load i64, i64* %l1
  %t67 = load i8*, i8** %l3
  br i1 %t64, label %then14, label %merge15
then14:
  %t68 = load i64, i64* %l1
  %t69 = sub i64 %t68, 1
  store i64 %t69, i64* %l1
  br label %loop.latch10
merge15:
  br label %afterloop11
loop.latch10:
  %t70 = load i64, i64* %l1
  br label %loop.header8
afterloop11:
  %t72 = load i64, i64* %l0
  %t73 = load i64, i64* %l1
  %t74 = sitofp i64 %t72 to double
  %t75 = sitofp i64 %t73 to double
  %t76 = call i8* @sailfin_runtime_substring(i8* %value, double %t74, double %t75)
  ret i8* %t76
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
  %t171 = phi i64 [ %t10, %entry ], [ %t167, %loop.latch4 ]
  %t172 = phi i64 [ %t11, %entry ], [ %t168, %loop.latch4 ]
  %t173 = phi i64 [ %t12, %entry ], [ %t169, %loop.latch4 ]
  %t174 = phi i64 [ %t9, %entry ], [ %t170, %loop.latch4 ]
  store i64 %t171, i64* %l3
  store i64 %t172, i64* %l4
  store i64 %t173, i64* %l5
  store i64 %t174, i64* %l2
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
  %t28 = load i8, i8* %t27
  %t29 = icmp eq i8 %t28, 40
  %t30 = load i8*, i8** %l0
  %t31 = load i8*, i8** %l1
  %t32 = load i64, i64* %l2
  %t33 = load i64, i64* %l3
  %t34 = load i64, i64* %l4
  %t35 = load i64, i64* %l5
  %t36 = load i8*, i8** %l6
  br i1 %t29, label %then8, label %else9
then8:
  %t37 = load i64, i64* %l3
  %t38 = add i64 %t37, 1
  store i64 %t38, i64* %l3
  br label %merge10
else9:
  %t39 = load i8*, i8** %l6
  %t40 = load i8, i8* %t39
  %t41 = icmp eq i8 %t40, 41
  %t42 = load i8*, i8** %l0
  %t43 = load i8*, i8** %l1
  %t44 = load i64, i64* %l2
  %t45 = load i64, i64* %l3
  %t46 = load i64, i64* %l4
  %t47 = load i64, i64* %l5
  %t48 = load i8*, i8** %l6
  br i1 %t41, label %then11, label %else12
then11:
  %t49 = load i64, i64* %l3
  %t50 = icmp sgt i64 %t49, 0
  %t51 = load i8*, i8** %l0
  %t52 = load i8*, i8** %l1
  %t53 = load i64, i64* %l2
  %t54 = load i64, i64* %l3
  %t55 = load i64, i64* %l4
  %t56 = load i64, i64* %l5
  %t57 = load i8*, i8** %l6
  br i1 %t50, label %then14, label %merge15
then14:
  %t58 = load i64, i64* %l3
  %t59 = sub i64 %t58, 1
  store i64 %t59, i64* %l3
  br label %merge15
merge15:
  %t60 = phi i64 [ %t59, %then14 ], [ %t54, %then11 ]
  store i64 %t60, i64* %l3
  br label %merge13
else12:
  %t61 = load i8*, i8** %l6
  %t62 = load i8, i8* %t61
  %t63 = icmp eq i8 %t62, 60
  %t64 = load i8*, i8** %l0
  %t65 = load i8*, i8** %l1
  %t66 = load i64, i64* %l2
  %t67 = load i64, i64* %l3
  %t68 = load i64, i64* %l4
  %t69 = load i64, i64* %l5
  %t70 = load i8*, i8** %l6
  br i1 %t63, label %then16, label %else17
then16:
  %t71 = load i64, i64* %l4
  %t72 = add i64 %t71, 1
  store i64 %t72, i64* %l4
  br label %merge18
else17:
  %t73 = load i8*, i8** %l6
  %t74 = load i8, i8* %t73
  %t75 = icmp eq i8 %t74, 62
  %t76 = load i8*, i8** %l0
  %t77 = load i8*, i8** %l1
  %t78 = load i64, i64* %l2
  %t79 = load i64, i64* %l3
  %t80 = load i64, i64* %l4
  %t81 = load i64, i64* %l5
  %t82 = load i8*, i8** %l6
  br i1 %t75, label %then19, label %else20
then19:
  %t83 = load i64, i64* %l4
  %t84 = icmp sgt i64 %t83, 0
  %t85 = load i8*, i8** %l0
  %t86 = load i8*, i8** %l1
  %t87 = load i64, i64* %l2
  %t88 = load i64, i64* %l3
  %t89 = load i64, i64* %l4
  %t90 = load i64, i64* %l5
  %t91 = load i8*, i8** %l6
  br i1 %t84, label %then22, label %merge23
then22:
  %t92 = load i64, i64* %l4
  %t93 = sub i64 %t92, 1
  store i64 %t93, i64* %l4
  br label %merge23
merge23:
  %t94 = phi i64 [ %t93, %then22 ], [ %t89, %then19 ]
  store i64 %t94, i64* %l4
  br label %merge21
else20:
  %t95 = load i8*, i8** %l6
  %t96 = load i8, i8* %t95
  %t97 = icmp eq i8 %t96, 91
  %t98 = load i8*, i8** %l0
  %t99 = load i8*, i8** %l1
  %t100 = load i64, i64* %l2
  %t101 = load i64, i64* %l3
  %t102 = load i64, i64* %l4
  %t103 = load i64, i64* %l5
  %t104 = load i8*, i8** %l6
  br i1 %t97, label %then24, label %else25
then24:
  %t105 = load i64, i64* %l5
  %t106 = add i64 %t105, 1
  store i64 %t106, i64* %l5
  br label %merge26
else25:
  %t107 = load i8*, i8** %l6
  %t108 = load i8, i8* %t107
  %t109 = icmp eq i8 %t108, 93
  %t110 = load i8*, i8** %l0
  %t111 = load i8*, i8** %l1
  %t112 = load i64, i64* %l2
  %t113 = load i64, i64* %l3
  %t114 = load i64, i64* %l4
  %t115 = load i64, i64* %l5
  %t116 = load i8*, i8** %l6
  br i1 %t109, label %then27, label %merge28
then27:
  %t117 = load i64, i64* %l5
  %t118 = icmp sgt i64 %t117, 0
  %t119 = load i8*, i8** %l0
  %t120 = load i8*, i8** %l1
  %t121 = load i64, i64* %l2
  %t122 = load i64, i64* %l3
  %t123 = load i64, i64* %l4
  %t124 = load i64, i64* %l5
  %t125 = load i8*, i8** %l6
  br i1 %t118, label %then29, label %merge30
then29:
  %t126 = load i64, i64* %l5
  %t127 = sub i64 %t126, 1
  store i64 %t127, i64* %l5
  br label %merge30
merge30:
  %t128 = phi i64 [ %t127, %then29 ], [ %t124, %then27 ]
  store i64 %t128, i64* %l5
  br label %merge28
merge28:
  %t129 = phi i64 [ %t127, %then27 ], [ %t115, %else25 ]
  store i64 %t129, i64* %l5
  br label %merge26
merge26:
  %t130 = phi i64 [ %t106, %then24 ], [ %t127, %else25 ]
  store i64 %t130, i64* %l5
  br label %merge21
merge21:
  %t131 = phi i64 [ %t93, %then19 ], [ %t80, %else20 ]
  %t132 = phi i64 [ %t81, %then19 ], [ %t106, %else20 ]
  store i64 %t131, i64* %l4
  store i64 %t132, i64* %l5
  br label %merge18
merge18:
  %t133 = phi i64 [ %t72, %then16 ], [ %t93, %else17 ]
  %t134 = phi i64 [ %t69, %then16 ], [ %t106, %else17 ]
  store i64 %t133, i64* %l4
  store i64 %t134, i64* %l5
  br label %merge13
merge13:
  %t135 = phi i64 [ %t59, %then11 ], [ %t45, %else12 ]
  %t136 = phi i64 [ %t46, %then11 ], [ %t72, %else12 ]
  %t137 = phi i64 [ %t47, %then11 ], [ %t106, %else12 ]
  store i64 %t135, i64* %l3
  store i64 %t136, i64* %l4
  store i64 %t137, i64* %l5
  br label %merge10
merge10:
  %t138 = phi i64 [ %t38, %then8 ], [ %t59, %else9 ]
  %t139 = phi i64 [ %t34, %then8 ], [ %t72, %else9 ]
  %t140 = phi i64 [ %t35, %then8 ], [ %t106, %else9 ]
  store i64 %t138, i64* %l3
  store i64 %t139, i64* %l4
  store i64 %t140, i64* %l5
  %t142 = load i8*, i8** %l6
  %t143 = load i8*, i8** %l1
  %t144 = icmp eq i8* %t142, %t143
  br label %logical_and_entry_141

logical_and_entry_141:
  br i1 %t144, label %logical_and_right_141, label %logical_and_merge_141

logical_and_right_141:
  %t146 = load i64, i64* %l3
  %t147 = icmp eq i64 %t146, 0
  br label %logical_and_entry_145

logical_and_entry_145:
  br i1 %t147, label %logical_and_right_145, label %logical_and_merge_145

logical_and_right_145:
  %t149 = load i64, i64* %l4
  %t150 = icmp eq i64 %t149, 0
  br label %logical_and_entry_148

logical_and_entry_148:
  br i1 %t150, label %logical_and_right_148, label %logical_and_merge_148

logical_and_right_148:
  %t151 = load i64, i64* %l5
  %t152 = icmp eq i64 %t151, 0
  br label %logical_and_right_end_148

logical_and_right_end_148:
  br label %logical_and_merge_148

logical_and_merge_148:
  %t153 = phi i1 [ false, %logical_and_entry_148 ], [ %t152, %logical_and_right_end_148 ]
  br label %logical_and_right_end_145

logical_and_right_end_145:
  br label %logical_and_merge_145

logical_and_merge_145:
  %t154 = phi i1 [ false, %logical_and_entry_145 ], [ %t153, %logical_and_right_end_145 ]
  br label %logical_and_right_end_141

logical_and_right_end_141:
  br label %logical_and_merge_141

logical_and_merge_141:
  %t155 = phi i1 [ false, %logical_and_entry_141 ], [ %t154, %logical_and_right_end_141 ]
  %t156 = load i8*, i8** %l0
  %t157 = load i8*, i8** %l1
  %t158 = load i64, i64* %l2
  %t159 = load i64, i64* %l3
  %t160 = load i64, i64* %l4
  %t161 = load i64, i64* %l5
  %t162 = load i8*, i8** %l6
  br i1 %t155, label %then31, label %merge32
then31:
  %t163 = load i64, i64* %l2
  %t164 = sitofp i64 %t163 to double
  ret double %t164
merge32:
  %t165 = load i64, i64* %l2
  %t166 = add i64 %t165, 1
  store i64 %t166, i64* %l2
  br label %loop.latch4
loop.latch4:
  %t167 = load i64, i64* %l3
  %t168 = load i64, i64* %l4
  %t169 = load i64, i64* %l5
  %t170 = load i64, i64* %l2
  br label %loop.header2
afterloop5:
  %t175 = sitofp i64 -1 to double
  ret double %t175
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
  %t114 = phi i8* [ %t1, %entry ], [ %t113, %loop.latch2 ]
  store i8* %t114, i8** %l0
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
  %t10 = load i8, i8* %t9
  %t11 = icmp ne i8 %t10, 40
  %t12 = load i8*, i8** %l0
  br i1 %t11, label %then6, label %merge7
then6:
  %t13 = load i8*, i8** %l0
  ret i8* %t13
merge7:
  %t14 = load i8*, i8** %l0
  %t15 = load i8*, i8** %l0
  %t16 = call i64 @sailfin_runtime_string_length(i8* %t15)
  %t17 = sub i64 %t16, 1
  %t18 = sitofp i64 %t17 to double
  %t19 = call i8* @char_at(i8* %t14, double %t18)
  %t20 = load i8, i8* %t19
  %t21 = icmp ne i8 %t20, 41
  %t22 = load i8*, i8** %l0
  br i1 %t21, label %then8, label %merge9
then8:
  %t23 = load i8*, i8** %l0
  ret i8* %t23
merge9:
  store i64 0, i64* %l1
  store i64 0, i64* %l2
  store i1 1, i1* %l3
  %t24 = load i8*, i8** %l0
  %t25 = load i64, i64* %l1
  %t26 = load i64, i64* %l2
  %t27 = load i1, i1* %l3
  br label %loop.header10
loop.header10:
  %t91 = phi i64 [ %t25, %loop.body1 ], [ %t88, %loop.latch12 ]
  %t92 = phi i1 [ %t27, %loop.body1 ], [ %t89, %loop.latch12 ]
  %t93 = phi i64 [ %t26, %loop.body1 ], [ %t90, %loop.latch12 ]
  store i64 %t91, i64* %l1
  store i1 %t92, i1* %l3
  store i64 %t93, i64* %l2
  br label %loop.body11
loop.body11:
  %t28 = load i64, i64* %l2
  %t29 = load i8*, i8** %l0
  %t30 = call i64 @sailfin_runtime_string_length(i8* %t29)
  %t31 = icmp sge i64 %t28, %t30
  %t32 = load i8*, i8** %l0
  %t33 = load i64, i64* %l1
  %t34 = load i64, i64* %l2
  %t35 = load i1, i1* %l3
  br i1 %t31, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t36 = load i8*, i8** %l0
  %t37 = load i64, i64* %l2
  %t38 = sitofp i64 %t37 to double
  %t39 = call i8* @char_at(i8* %t36, double %t38)
  store i8* %t39, i8** %l4
  %t40 = load i8*, i8** %l4
  %t41 = load i8, i8* %t40
  %t42 = icmp eq i8 %t41, 40
  %t43 = load i8*, i8** %l0
  %t44 = load i64, i64* %l1
  %t45 = load i64, i64* %l2
  %t46 = load i1, i1* %l3
  %t47 = load i8*, i8** %l4
  br i1 %t42, label %then16, label %else17
then16:
  %t48 = load i64, i64* %l1
  %t49 = add i64 %t48, 1
  store i64 %t49, i64* %l1
  br label %merge18
else17:
  %t50 = load i8*, i8** %l4
  %t51 = load i8, i8* %t50
  %t52 = icmp eq i8 %t51, 41
  %t53 = load i8*, i8** %l0
  %t54 = load i64, i64* %l1
  %t55 = load i64, i64* %l2
  %t56 = load i1, i1* %l3
  %t57 = load i8*, i8** %l4
  br i1 %t52, label %then19, label %merge20
then19:
  %t58 = load i64, i64* %l1
  %t59 = sub i64 %t58, 1
  store i64 %t59, i64* %l1
  %t60 = load i64, i64* %l1
  %t61 = icmp slt i64 %t60, 0
  %t62 = load i8*, i8** %l0
  %t63 = load i64, i64* %l1
  %t64 = load i64, i64* %l2
  %t65 = load i1, i1* %l3
  %t66 = load i8*, i8** %l4
  br i1 %t61, label %then21, label %merge22
then21:
  store i1 0, i1* %l3
  br label %afterloop13
merge22:
  %t68 = load i64, i64* %l1
  %t69 = icmp eq i64 %t68, 0
  br label %logical_and_entry_67

logical_and_entry_67:
  br i1 %t69, label %logical_and_right_67, label %logical_and_merge_67

logical_and_right_67:
  %t70 = load i64, i64* %l2
  %t71 = load i8*, i8** %l0
  %t72 = call i64 @sailfin_runtime_string_length(i8* %t71)
  %t73 = sub i64 %t72, 1
  %t74 = icmp slt i64 %t70, %t73
  br label %logical_and_right_end_67

logical_and_right_end_67:
  br label %logical_and_merge_67

logical_and_merge_67:
  %t75 = phi i1 [ false, %logical_and_entry_67 ], [ %t74, %logical_and_right_end_67 ]
  %t76 = load i8*, i8** %l0
  %t77 = load i64, i64* %l1
  %t78 = load i64, i64* %l2
  %t79 = load i1, i1* %l3
  %t80 = load i8*, i8** %l4
  br i1 %t75, label %then23, label %merge24
then23:
  store i1 0, i1* %l3
  br label %afterloop13
merge24:
  br label %merge20
merge20:
  %t81 = phi i64 [ %t59, %then19 ], [ %t54, %else17 ]
  %t82 = phi i1 [ 0, %then19 ], [ %t56, %else17 ]
  %t83 = phi i1 [ 0, %then19 ], [ %t56, %else17 ]
  store i64 %t81, i64* %l1
  store i1 %t82, i1* %l3
  store i1 %t83, i1* %l3
  br label %merge18
merge18:
  %t84 = phi i64 [ %t49, %then16 ], [ %t59, %else17 ]
  %t85 = phi i1 [ %t46, %then16 ], [ 0, %else17 ]
  store i64 %t84, i64* %l1
  store i1 %t85, i1* %l3
  %t86 = load i64, i64* %l2
  %t87 = add i64 %t86, 1
  store i64 %t87, i64* %l2
  br label %loop.latch12
loop.latch12:
  %t88 = load i64, i64* %l1
  %t89 = load i1, i1* %l3
  %t90 = load i64, i64* %l2
  br label %loop.header10
afterloop13:
  %t95 = load i1, i1* %l3
  br label %logical_or_entry_94

logical_or_entry_94:
  br i1 %t95, label %logical_or_merge_94, label %logical_or_right_94

logical_or_right_94:
  %t96 = load i64, i64* %l1
  %t97 = icmp ne i64 %t96, 0
  br label %logical_or_right_end_94

logical_or_right_end_94:
  br label %logical_or_merge_94

logical_or_merge_94:
  %t98 = phi i1 [ true, %logical_or_entry_94 ], [ %t97, %logical_or_right_end_94 ]
  %t99 = xor i1 %t98, 1
  %t100 = load i8*, i8** %l0
  %t101 = load i64, i64* %l1
  %t102 = load i64, i64* %l2
  %t103 = load i1, i1* %l3
  br i1 %t99, label %then25, label %merge26
then25:
  %t104 = load i8*, i8** %l0
  ret i8* %t104
merge26:
  %t105 = load i8*, i8** %l0
  %t106 = load i8*, i8** %l0
  %t107 = call i64 @sailfin_runtime_string_length(i8* %t106)
  %t108 = sub i64 %t107, 1
  %t109 = sitofp i64 1 to double
  %t110 = sitofp i64 %t108 to double
  %t111 = call i8* @sailfin_runtime_substring(i8* %t105, double %t109, double %t110)
  %t112 = call i8* @descriptor_trim(i8* %t111)
  store i8* %t112, i8** %l0
  br label %loop.latch2
loop.latch2:
  %t113 = load i8*, i8** %l0
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
  %t226 = phi i64 [ %t22, %entry ], [ %t220, %loop.latch4 ]
  %t227 = phi i64 [ %t23, %entry ], [ %t221, %loop.latch4 ]
  %t228 = phi i64 [ %t24, %entry ], [ %t222, %loop.latch4 ]
  %t229 = phi { i8**, i64 }* [ %t19, %entry ], [ %t223, %loop.latch4 ]
  %t230 = phi i64 [ %t20, %entry ], [ %t224, %loop.latch4 ]
  %t231 = phi i64 [ %t21, %entry ], [ %t225, %loop.latch4 ]
  store i64 %t226, i64* %l4
  store i64 %t227, i64* %l5
  store i64 %t228, i64* %l6
  store { i8**, i64 }* %t229, { i8**, i64 }** %l1
  store i64 %t230, i64* %l2
  store i64 %t231, i64* %l3
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
  %t43 = load i8, i8* %t42
  %t44 = icmp eq i8 %t43, 40
  %t45 = load i8*, i8** %l0
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t47 = load i64, i64* %l2
  %t48 = load i64, i64* %l3
  %t49 = load i64, i64* %l4
  %t50 = load i64, i64* %l5
  %t51 = load i64, i64* %l6
  %t52 = load i8*, i8** %l7
  %t53 = load i8*, i8** %l8
  br i1 %t44, label %then8, label %else9
then8:
  %t54 = load i64, i64* %l4
  %t55 = add i64 %t54, 1
  store i64 %t55, i64* %l4
  br label %merge10
else9:
  %t56 = load i8*, i8** %l8
  %t57 = load i8, i8* %t56
  %t58 = icmp eq i8 %t57, 41
  %t59 = load i8*, i8** %l0
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t61 = load i64, i64* %l2
  %t62 = load i64, i64* %l3
  %t63 = load i64, i64* %l4
  %t64 = load i64, i64* %l5
  %t65 = load i64, i64* %l6
  %t66 = load i8*, i8** %l7
  %t67 = load i8*, i8** %l8
  br i1 %t58, label %then11, label %else12
then11:
  %t68 = load i64, i64* %l4
  %t69 = icmp sgt i64 %t68, 0
  %t70 = load i8*, i8** %l0
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t72 = load i64, i64* %l2
  %t73 = load i64, i64* %l3
  %t74 = load i64, i64* %l4
  %t75 = load i64, i64* %l5
  %t76 = load i64, i64* %l6
  %t77 = load i8*, i8** %l7
  %t78 = load i8*, i8** %l8
  br i1 %t69, label %then14, label %merge15
then14:
  %t79 = load i64, i64* %l4
  %t80 = sub i64 %t79, 1
  store i64 %t80, i64* %l4
  br label %merge15
merge15:
  %t81 = phi i64 [ %t80, %then14 ], [ %t74, %then11 ]
  store i64 %t81, i64* %l4
  br label %merge13
else12:
  %t82 = load i8*, i8** %l8
  %t83 = load i8, i8* %t82
  %t84 = icmp eq i8 %t83, 60
  %t85 = load i8*, i8** %l0
  %t86 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t87 = load i64, i64* %l2
  %t88 = load i64, i64* %l3
  %t89 = load i64, i64* %l4
  %t90 = load i64, i64* %l5
  %t91 = load i64, i64* %l6
  %t92 = load i8*, i8** %l7
  %t93 = load i8*, i8** %l8
  br i1 %t84, label %then16, label %else17
then16:
  %t94 = load i64, i64* %l5
  %t95 = add i64 %t94, 1
  store i64 %t95, i64* %l5
  br label %merge18
else17:
  %t96 = load i8*, i8** %l8
  %t97 = load i8, i8* %t96
  %t98 = icmp eq i8 %t97, 62
  %t99 = load i8*, i8** %l0
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t101 = load i64, i64* %l2
  %t102 = load i64, i64* %l3
  %t103 = load i64, i64* %l4
  %t104 = load i64, i64* %l5
  %t105 = load i64, i64* %l6
  %t106 = load i8*, i8** %l7
  %t107 = load i8*, i8** %l8
  br i1 %t98, label %then19, label %else20
then19:
  %t108 = load i64, i64* %l5
  %t109 = icmp sgt i64 %t108, 0
  %t110 = load i8*, i8** %l0
  %t111 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t112 = load i64, i64* %l2
  %t113 = load i64, i64* %l3
  %t114 = load i64, i64* %l4
  %t115 = load i64, i64* %l5
  %t116 = load i64, i64* %l6
  %t117 = load i8*, i8** %l7
  %t118 = load i8*, i8** %l8
  br i1 %t109, label %then22, label %merge23
then22:
  %t119 = load i64, i64* %l5
  %t120 = sub i64 %t119, 1
  store i64 %t120, i64* %l5
  br label %merge23
merge23:
  %t121 = phi i64 [ %t120, %then22 ], [ %t115, %then19 ]
  store i64 %t121, i64* %l5
  br label %merge21
else20:
  %t122 = load i8*, i8** %l8
  %t123 = load i8, i8* %t122
  %t124 = icmp eq i8 %t123, 91
  %t125 = load i8*, i8** %l0
  %t126 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t127 = load i64, i64* %l2
  %t128 = load i64, i64* %l3
  %t129 = load i64, i64* %l4
  %t130 = load i64, i64* %l5
  %t131 = load i64, i64* %l6
  %t132 = load i8*, i8** %l7
  %t133 = load i8*, i8** %l8
  br i1 %t124, label %then24, label %else25
then24:
  %t134 = load i64, i64* %l6
  %t135 = add i64 %t134, 1
  store i64 %t135, i64* %l6
  br label %merge26
else25:
  %t136 = load i8*, i8** %l8
  %t137 = load i8, i8* %t136
  %t138 = icmp eq i8 %t137, 93
  %t139 = load i8*, i8** %l0
  %t140 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t141 = load i64, i64* %l2
  %t142 = load i64, i64* %l3
  %t143 = load i64, i64* %l4
  %t144 = load i64, i64* %l5
  %t145 = load i64, i64* %l6
  %t146 = load i8*, i8** %l7
  %t147 = load i8*, i8** %l8
  br i1 %t138, label %then27, label %merge28
then27:
  %t148 = load i64, i64* %l6
  %t149 = icmp sgt i64 %t148, 0
  %t150 = load i8*, i8** %l0
  %t151 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t152 = load i64, i64* %l2
  %t153 = load i64, i64* %l3
  %t154 = load i64, i64* %l4
  %t155 = load i64, i64* %l5
  %t156 = load i64, i64* %l6
  %t157 = load i8*, i8** %l7
  %t158 = load i8*, i8** %l8
  br i1 %t149, label %then29, label %merge30
then29:
  %t159 = load i64, i64* %l6
  %t160 = sub i64 %t159, 1
  store i64 %t160, i64* %l6
  br label %merge30
merge30:
  %t161 = phi i64 [ %t160, %then29 ], [ %t156, %then27 ]
  store i64 %t161, i64* %l6
  br label %merge28
merge28:
  %t162 = phi i64 [ %t160, %then27 ], [ %t145, %else25 ]
  store i64 %t162, i64* %l6
  br label %merge26
merge26:
  %t163 = phi i64 [ %t135, %then24 ], [ %t160, %else25 ]
  store i64 %t163, i64* %l6
  br label %merge21
merge21:
  %t164 = phi i64 [ %t120, %then19 ], [ %t104, %else20 ]
  %t165 = phi i64 [ %t105, %then19 ], [ %t135, %else20 ]
  store i64 %t164, i64* %l5
  store i64 %t165, i64* %l6
  br label %merge18
merge18:
  %t166 = phi i64 [ %t95, %then16 ], [ %t120, %else17 ]
  %t167 = phi i64 [ %t91, %then16 ], [ %t135, %else17 ]
  store i64 %t166, i64* %l5
  store i64 %t167, i64* %l6
  br label %merge13
merge13:
  %t168 = phi i64 [ %t80, %then11 ], [ %t63, %else12 ]
  %t169 = phi i64 [ %t64, %then11 ], [ %t95, %else12 ]
  %t170 = phi i64 [ %t65, %then11 ], [ %t135, %else12 ]
  store i64 %t168, i64* %l4
  store i64 %t169, i64* %l5
  store i64 %t170, i64* %l6
  br label %merge10
merge10:
  %t171 = phi i64 [ %t55, %then8 ], [ %t80, %else9 ]
  %t172 = phi i64 [ %t50, %then8 ], [ %t95, %else9 ]
  %t173 = phi i64 [ %t51, %then8 ], [ %t135, %else9 ]
  store i64 %t171, i64* %l4
  store i64 %t172, i64* %l5
  store i64 %t173, i64* %l6
  %t175 = load i8*, i8** %l8
  %t176 = load i8*, i8** %l7
  %t177 = icmp eq i8* %t175, %t176
  br label %logical_and_entry_174

logical_and_entry_174:
  br i1 %t177, label %logical_and_right_174, label %logical_and_merge_174

logical_and_right_174:
  %t179 = load i64, i64* %l4
  %t180 = icmp eq i64 %t179, 0
  br label %logical_and_entry_178

logical_and_entry_178:
  br i1 %t180, label %logical_and_right_178, label %logical_and_merge_178

logical_and_right_178:
  %t182 = load i64, i64* %l5
  %t183 = icmp eq i64 %t182, 0
  br label %logical_and_entry_181

logical_and_entry_181:
  br i1 %t183, label %logical_and_right_181, label %logical_and_merge_181

logical_and_right_181:
  %t184 = load i64, i64* %l6
  %t185 = icmp eq i64 %t184, 0
  br label %logical_and_right_end_181

logical_and_right_end_181:
  br label %logical_and_merge_181

logical_and_merge_181:
  %t186 = phi i1 [ false, %logical_and_entry_181 ], [ %t185, %logical_and_right_end_181 ]
  br label %logical_and_right_end_178

logical_and_right_end_178:
  br label %logical_and_merge_178

logical_and_merge_178:
  %t187 = phi i1 [ false, %logical_and_entry_178 ], [ %t186, %logical_and_right_end_178 ]
  br label %logical_and_right_end_174

logical_and_right_end_174:
  br label %logical_and_merge_174

logical_and_merge_174:
  %t188 = phi i1 [ false, %logical_and_entry_174 ], [ %t187, %logical_and_right_end_174 ]
  %t189 = load i8*, i8** %l0
  %t190 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t191 = load i64, i64* %l2
  %t192 = load i64, i64* %l3
  %t193 = load i64, i64* %l4
  %t194 = load i64, i64* %l5
  %t195 = load i64, i64* %l6
  %t196 = load i8*, i8** %l7
  %t197 = load i8*, i8** %l8
  br i1 %t188, label %then31, label %merge32
then31:
  %t198 = load i8*, i8** %l0
  %t199 = load i64, i64* %l2
  %t200 = load i64, i64* %l3
  %t201 = sitofp i64 %t199 to double
  %t202 = sitofp i64 %t200 to double
  %t203 = call i8* @sailfin_runtime_substring(i8* %t198, double %t201, double %t202)
  store i8* %t203, i8** %l9
  %t204 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t205 = load i8*, i8** %l9
  %t206 = call i8* @descriptor_trim(i8* %t205)
  %t207 = alloca [1 x i8*]
  %t208 = getelementptr [1 x i8*], [1 x i8*]* %t207, i32 0, i32 0
  %t209 = getelementptr i8*, i8** %t208, i64 0
  store i8* %t206, i8** %t209
  %t210 = alloca { i8**, i64 }
  %t211 = getelementptr { i8**, i64 }, { i8**, i64 }* %t210, i32 0, i32 0
  store i8** %t208, i8*** %t211
  %t212 = getelementptr { i8**, i64 }, { i8**, i64 }* %t210, i32 0, i32 1
  store i64 1, i64* %t212
  %t213 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t204, { i8**, i64 }* %t210)
  store { i8**, i64 }* %t213, { i8**, i64 }** %l1
  %t214 = load i64, i64* %l3
  %t215 = add i64 %t214, 1
  store i64 %t215, i64* %l2
  br label %merge32
merge32:
  %t216 = phi { i8**, i64 }* [ %t213, %then31 ], [ %t190, %loop.body3 ]
  %t217 = phi i64 [ %t215, %then31 ], [ %t191, %loop.body3 ]
  store { i8**, i64 }* %t216, { i8**, i64 }** %l1
  store i64 %t217, i64* %l2
  %t218 = load i64, i64* %l3
  %t219 = add i64 %t218, 1
  store i64 %t219, i64* %l3
  br label %loop.latch4
loop.latch4:
  %t220 = load i64, i64* %l4
  %t221 = load i64, i64* %l5
  %t222 = load i64, i64* %l6
  %t223 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t224 = load i64, i64* %l2
  %t225 = load i64, i64* %l3
  br label %loop.header2
afterloop5:
  %t232 = load i8*, i8** %l0
  %t233 = load i64, i64* %l2
  %t234 = load i8*, i8** %l0
  %t235 = call i64 @sailfin_runtime_string_length(i8* %t234)
  %t236 = sitofp i64 %t233 to double
  %t237 = sitofp i64 %t235 to double
  %t238 = call i8* @sailfin_runtime_substring(i8* %t232, double %t236, double %t237)
  store i8* %t238, i8** %l10
  %t239 = load i8*, i8** %l10
  %t240 = call i8* @descriptor_trim(i8* %t239)
  store i8* %t240, i8** %l11
  %t242 = load i8*, i8** %l11
  %t243 = call i64 @sailfin_runtime_string_length(i8* %t242)
  %t244 = icmp sgt i64 %t243, 0
  br label %logical_or_entry_241

logical_or_entry_241:
  br i1 %t244, label %logical_or_merge_241, label %logical_or_right_241

logical_or_right_241:
  %t245 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t246 = load { i8**, i64 }, { i8**, i64 }* %t245
  %t247 = extractvalue { i8**, i64 } %t246, 1
  %t248 = icmp eq i64 %t247, 0
  br label %logical_or_right_end_241

logical_or_right_end_241:
  br label %logical_or_merge_241

logical_or_merge_241:
  %t249 = phi i1 [ true, %logical_or_entry_241 ], [ %t248, %logical_or_right_end_241 ]
  %t250 = load i8*, i8** %l0
  %t251 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t252 = load i64, i64* %l2
  %t253 = load i64, i64* %l3
  %t254 = load i64, i64* %l4
  %t255 = load i64, i64* %l5
  %t256 = load i64, i64* %l6
  %t257 = load i8*, i8** %l7
  %t258 = load i8*, i8** %l10
  %t259 = load i8*, i8** %l11
  br i1 %t249, label %then33, label %merge34
then33:
  %t260 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t261 = load i8*, i8** %l11
  %t262 = alloca [1 x i8*]
  %t263 = getelementptr [1 x i8*], [1 x i8*]* %t262, i32 0, i32 0
  %t264 = getelementptr i8*, i8** %t263, i64 0
  store i8* %t261, i8** %t264
  %t265 = alloca { i8**, i64 }
  %t266 = getelementptr { i8**, i64 }, { i8**, i64 }* %t265, i32 0, i32 0
  store i8** %t263, i8*** %t266
  %t267 = getelementptr { i8**, i64 }, { i8**, i64 }* %t265, i32 0, i32 1
  store i64 1, i64* %t267
  %t268 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t260, { i8**, i64 }* %t265)
  store { i8**, i64 }* %t268, { i8**, i64 }** %l1
  br label %merge34
merge34:
  %t269 = phi { i8**, i64 }* [ %t268, %then33 ], [ %t251, %entry ]
  store { i8**, i64 }* %t269, { i8**, i64 }** %l1
  %t270 = load { i8**, i64 }*, { i8**, i64 }** %l1
  ret { i8**, i64 }* %t270
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
  %t45 = phi { %TypeDescriptor*, i64 }* [ %t5, %entry ], [ %t43, %loop.latch2 ]
  %t46 = phi i64 [ %t6, %entry ], [ %t44, %loop.latch2 ]
  store { %TypeDescriptor*, i64 }* %t45, { %TypeDescriptor*, i64 }** %l0
  store i64 %t46, i64* %l1
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
  %t29 = call noalias i8* @malloc(i64 24)
  %t30 = bitcast i8* %t29 to %TypeDescriptor*
  store %TypeDescriptor %t28, %TypeDescriptor* %t30
  %t31 = alloca [1 x i8*]
  %t32 = getelementptr [1 x i8*], [1 x i8*]* %t31, i32 0, i32 0
  %t33 = getelementptr i8*, i8** %t32, i64 0
  store i8* %t29, i8** %t33
  %t34 = alloca { i8**, i64 }
  %t35 = getelementptr { i8**, i64 }, { i8**, i64 }* %t34, i32 0, i32 0
  store i8** %t32, i8*** %t35
  %t36 = getelementptr { i8**, i64 }, { i8**, i64 }* %t34, i32 0, i32 1
  store i64 1, i64* %t36
  %t37 = bitcast { %TypeDescriptor*, i64 }* %t26 to { i8**, i64 }*
  %t38 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t37, { i8**, i64 }* %t34)
  %t39 = bitcast { i8**, i64 }* %t38 to { %TypeDescriptor*, i64 }*
  store { %TypeDescriptor*, i64 }* %t39, { %TypeDescriptor*, i64 }** %l0
  br label %merge7
merge7:
  %t40 = phi { %TypeDescriptor*, i64 }* [ %t39, %then6 ], [ %t23, %loop.body1 ]
  store { %TypeDescriptor*, i64 }* %t40, { %TypeDescriptor*, i64 }** %l0
  %t41 = load i64, i64* %l1
  %t42 = add i64 %t41, 1
  store i64 %t42, i64* %l1
  br label %loop.latch2
loop.latch2:
  %t43 = load { %TypeDescriptor*, i64 }*, { %TypeDescriptor*, i64 }** %l0
  %t44 = load i64, i64* %l1
  br label %loop.header0
afterloop3:
  %t47 = load { %TypeDescriptor*, i64 }*, { %TypeDescriptor*, i64 }** %l0
  ret { %TypeDescriptor*, i64 }* %t47
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
  %t66 = load i8, i8* %t65
  %t67 = icmp eq i8 %t66, 63
  %t68 = load i8*, i8** %l0
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t67, label %then10, label %merge11
then10:
  %t71 = load i8*, i8** %l0
  %t72 = load i8*, i8** %l0
  %t73 = call i64 @sailfin_runtime_string_length(i8* %t72)
  %t74 = sub i64 %t73, 1
  %t75 = sitofp i64 0 to double
  %t76 = sitofp i64 %t74 to double
  %t77 = call i8* @sailfin_runtime_substring(i8* %t71, double %t75, double %t76)
  store i8* %t77, i8** %l4
  %t78 = load i8*, i8** %l4
  %t79 = call %TypeDescriptor @parse_type_descriptor(i8* %t78)
  store %TypeDescriptor %t79, %TypeDescriptor* %l5
  %s80 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.80, i32 0, i32 0
  %t81 = call %TypeDescriptor @type_descriptor_primitive(i8* %s80)
  store %TypeDescriptor %t81, %TypeDescriptor* %l6
  %t82 = load %TypeDescriptor, %TypeDescriptor* %l5
  %t83 = load %TypeDescriptor, %TypeDescriptor* %l6
  %t84 = alloca [2 x %TypeDescriptor]
  %t85 = getelementptr [2 x %TypeDescriptor], [2 x %TypeDescriptor]* %t84, i32 0, i32 0
  %t86 = getelementptr %TypeDescriptor, %TypeDescriptor* %t85, i64 0
  store %TypeDescriptor %t82, %TypeDescriptor* %t86
  %t87 = getelementptr %TypeDescriptor, %TypeDescriptor* %t85, i64 1
  store %TypeDescriptor %t83, %TypeDescriptor* %t87
  %t88 = alloca { %TypeDescriptor*, i64 }
  %t89 = getelementptr { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* %t88, i32 0, i32 0
  store %TypeDescriptor* %t85, %TypeDescriptor** %t89
  %t90 = getelementptr { %TypeDescriptor*, i64 }, { %TypeDescriptor*, i64 }* %t88, i32 0, i32 1
  store i64 2, i64* %t90
  %t91 = call %TypeDescriptor @type_descriptor_union({ %TypeDescriptor*, i64 }* %t88)
  ret %TypeDescriptor %t91
merge11:
  %t92 = load i8*, i8** %l0
  %t93 = alloca [2 x i8], align 1
  %t94 = getelementptr [2 x i8], [2 x i8]* %t93, i32 0, i32 0
  store i8 60, i8* %t94
  %t95 = getelementptr [2 x i8], [2 x i8]* %t93, i32 0, i32 1
  store i8 0, i8* %t95
  %t96 = getelementptr [2 x i8], [2 x i8]* %t93, i32 0, i32 0
  %t97 = call double @descriptor_find_top_level(i8* %t92, i8* %t96)
  store double %t97, double* %l7
  %t98 = load i8*, i8** %l0
  store i8* %t98, i8** %l8
  %t99 = load double, double* %l7
  %t100 = sitofp i64 0 to double
  %t101 = fcmp oge double %t99, %t100
  %t102 = load i8*, i8** %l0
  %t103 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t105 = load double, double* %l7
  %t106 = load i8*, i8** %l8
  br i1 %t101, label %then12, label %merge13
then12:
  %t107 = load i8*, i8** %l0
  %t108 = load double, double* %l7
  %t109 = sitofp i64 0 to double
  %t110 = call i8* @sailfin_runtime_substring(i8* %t107, double %t109, double %t108)
  %t111 = call i8* @descriptor_trim(i8* %t110)
  store i8* %t111, i8** %l8
  br label %merge13
merge13:
  %t112 = phi i8* [ %t111, %then12 ], [ %t106, %entry ]
  store i8* %t112, i8** %l8
  %t113 = load i8*, i8** %l8
  %s114 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.114, i32 0, i32 0
  %t115 = call i1 @string_starts_with(i8* %t113, i8* %s114)
  %t116 = load i8*, i8** %l0
  %t117 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t118 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t119 = load double, double* %l7
  %t120 = load i8*, i8** %l8
  br i1 %t115, label %then14, label %merge15
then14:
  %t121 = load i8*, i8** %l8
  %t122 = load i8*, i8** %l8
  %t123 = call i64 @sailfin_runtime_string_length(i8* %t122)
  %t124 = sitofp i64 8 to double
  %t125 = sitofp i64 %t123 to double
  %t126 = call i8* @sailfin_runtime_substring(i8* %t121, double %t124, double %t125)
  %t127 = call i8* @descriptor_trim(i8* %t126)
  store i8* %t127, i8** %l8
  br label %merge15
merge15:
  %t128 = phi i8* [ %t127, %then14 ], [ %t120, %entry ]
  store i8* %t128, i8** %l8
  %t130 = load i8*, i8** %l8
  %s131 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.131, i32 0, i32 0
  %t132 = icmp eq i8* %t130, %s131
  br label %logical_or_entry_129

logical_or_entry_129:
  br i1 %t132, label %logical_or_merge_129, label %logical_or_right_129

logical_or_right_129:
  %t134 = load i8*, i8** %l8
  %s135 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.135, i32 0, i32 0
  %t136 = icmp eq i8* %t134, %s135
  br label %logical_or_entry_133

logical_or_entry_133:
  br i1 %t136, label %logical_or_merge_133, label %logical_or_right_133

logical_or_right_133:
  %t138 = load i8*, i8** %l8
  %s139 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.139, i32 0, i32 0
  %t140 = icmp eq i8* %t138, %s139
  br label %logical_or_entry_137

logical_or_entry_137:
  br i1 %t140, label %logical_or_merge_137, label %logical_or_right_137

logical_or_right_137:
  %t141 = load i8*, i8** %l8
  %s142 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.142, i32 0, i32 0
  %t143 = icmp eq i8* %t141, %s142
  br label %logical_or_right_end_137

logical_or_right_end_137:
  br label %logical_or_merge_137

logical_or_merge_137:
  %t144 = phi i1 [ true, %logical_or_entry_137 ], [ %t143, %logical_or_right_end_137 ]
  br label %logical_or_right_end_133

logical_or_right_end_133:
  br label %logical_or_merge_133

logical_or_merge_133:
  %t145 = phi i1 [ true, %logical_or_entry_133 ], [ %t144, %logical_or_right_end_133 ]
  br label %logical_or_right_end_129

logical_or_right_end_129:
  br label %logical_or_merge_129

logical_or_merge_129:
  %t146 = phi i1 [ true, %logical_or_entry_129 ], [ %t145, %logical_or_right_end_129 ]
  %t147 = load i8*, i8** %l0
  %t148 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t149 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t150 = load double, double* %l7
  %t151 = load i8*, i8** %l8
  br i1 %t146, label %then16, label %merge17
then16:
  %t152 = load i8*, i8** %l8
  %t153 = call %TypeDescriptor @type_descriptor_primitive(i8* %t152)
  ret %TypeDescriptor %t153
merge17:
  %t154 = load i8*, i8** %l8
  %t155 = call %TypeDescriptor @type_descriptor_named(i8* %t154)
  ret %TypeDescriptor %t155
}

define i1 @check_type_primitive(i8* %value, i8* %name) {
entry:
  %s0 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.0, i32 0, i32 0
  %t1 = icmp eq i8* %name, %s0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = load i8*, i8** @runtime
  %t3 = call double @runtimeis_string(i8* %value)
  %t4 = fcmp one double %t3, 0.0
  ret i1 %t4
merge1:
  %s5 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.5, i32 0, i32 0
  %t6 = icmp eq i8* %name, %s5
  br i1 %t6, label %then2, label %merge3
then2:
  %t7 = load i8*, i8** @runtime
  %t8 = call double @runtimeis_number(i8* %value)
  %t9 = fcmp one double %t8, 0.0
  ret i1 %t9
merge3:
  %s10 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.10, i32 0, i32 0
  %t11 = icmp eq i8* %name, %s10
  br i1 %t11, label %then4, label %merge5
then4:
  %t12 = load i8*, i8** @runtime
  %t13 = call double @runtimeis_boolean(i8* %value)
  %t14 = fcmp one double %t13, 0.0
  ret i1 %t14
merge5:
  %s15 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.15, i32 0, i32 0
  %t16 = icmp eq i8* %name, %s15
  br i1 %t16, label %then6, label %merge7
then6:
  %t17 = load i8*, i8** @runtime
  %t18 = call double @runtimeis_void(i8* %value)
  %t19 = fcmp one double %t18, 0.0
  ret i1 %t19
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
  %t31 = phi i64 [ %t10, %then4 ], [ %t30, %loop.latch8 ]
  store i64 %t31, i64* %l0
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
  %t25 = load %TypeDescriptor, %TypeDescriptor* %t24
  %t26 = call i1 @check_type_descriptor(i8* %value, %TypeDescriptor %t25)
  %t27 = load i64, i64* %l0
  br i1 %t26, label %then12, label %merge13
then12:
  ret i1 1
merge13:
  %t28 = load i64, i64* %l0
  %t29 = add i64 %t28, 1
  store i64 %t29, i64* %l0
  br label %loop.latch8
loop.latch8:
  %t30 = load i64, i64* %l0
  br label %loop.header6
afterloop9:
  ret i1 0
merge5:
  %t32 = extractvalue %TypeDescriptor %descriptor, 0
  %s33 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.33, i32 0, i32 0
  %t34 = icmp eq i8* %t32, %s33
  br i1 %t34, label %then14, label %merge15
then14:
  store i64 0, i64* %l1
  %t35 = load i64, i64* %l1
  br label %loop.header16
loop.header16:
  %t57 = phi i64 [ %t35, %then14 ], [ %t56, %loop.latch18 ]
  store i64 %t57, i64* %l1
  br label %loop.body17
loop.body17:
  %t36 = load i64, i64* %l1
  %t37 = extractvalue %TypeDescriptor %descriptor, 2
  %t38 = load { %TypeDescriptor**, i64 }, { %TypeDescriptor**, i64 }* %t37
  %t39 = extractvalue { %TypeDescriptor**, i64 } %t38, 1
  %t40 = icmp sge i64 %t36, %t39
  %t41 = load i64, i64* %l1
  br i1 %t40, label %then20, label %merge21
then20:
  br label %afterloop19
merge21:
  %t42 = extractvalue %TypeDescriptor %descriptor, 2
  %t43 = load i64, i64* %l1
  %t44 = load { %TypeDescriptor**, i64 }, { %TypeDescriptor**, i64 }* %t42
  %t45 = extractvalue { %TypeDescriptor**, i64 } %t44, 0
  %t46 = extractvalue { %TypeDescriptor**, i64 } %t44, 1
  %t47 = icmp uge i64 %t43, %t46
  ; bounds check: %t47 (if true, out of bounds)
  %t48 = getelementptr %TypeDescriptor*, %TypeDescriptor** %t45, i64 %t43
  %t49 = load %TypeDescriptor*, %TypeDescriptor** %t48
  %t50 = load %TypeDescriptor, %TypeDescriptor* %t49
  %t51 = call i1 @check_type_descriptor(i8* %value, %TypeDescriptor %t50)
  %t52 = xor i1 %t51, 1
  %t53 = load i64, i64* %l1
  br i1 %t52, label %then22, label %merge23
then22:
  ret i1 0
merge23:
  %t54 = load i64, i64* %l1
  %t55 = add i64 %t54, 1
  store i64 %t55, i64* %l1
  br label %loop.latch18
loop.latch18:
  %t56 = load i64, i64* %l1
  br label %loop.header16
afterloop19:
  %t58 = extractvalue %TypeDescriptor %descriptor, 2
  %t59 = load { %TypeDescriptor**, i64 }, { %TypeDescriptor**, i64 }* %t58
  %t60 = extractvalue { %TypeDescriptor**, i64 } %t59, 1
  %t61 = icmp sgt i64 %t60, 0
  ret i1 %t61
merge15:
  %t62 = extractvalue %TypeDescriptor %descriptor, 0
  %s63 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.63, i32 0, i32 0
  %t64 = icmp eq i8* %t62, %s63
  br i1 %t64, label %then24, label %merge25
then24:
  %t65 = extractvalue %TypeDescriptor %descriptor, 2
  %t66 = load { %TypeDescriptor**, i64 }, { %TypeDescriptor**, i64 }* %t65
  %t67 = extractvalue { %TypeDescriptor**, i64 } %t66, 1
  %t68 = icmp eq i64 %t67, 0
  br i1 %t68, label %then26, label %merge27
then26:
  %t69 = load i8*, i8** @runtime
  %t70 = call double @runtimeis_array(i8* %value)
  %t71 = fcmp one double %t70, 0.0
  ret i1 %t71
merge27:
  %t72 = load i8*, i8** @runtime
  %t73 = call double @runtimeis_array(i8* %value)
  %t74 = fcmp one double %t73, 0.0
  %t75 = xor i1 %t74, 1
  br i1 %t75, label %then28, label %merge29
then28:
  ret i1 0
merge29:
  %t76 = extractvalue %TypeDescriptor %descriptor, 2
  %t77 = load { %TypeDescriptor**, i64 }, { %TypeDescriptor**, i64 }* %t76
  %t78 = extractvalue { %TypeDescriptor**, i64 } %t77, 0
  %t79 = extractvalue { %TypeDescriptor**, i64 } %t77, 1
  %t80 = icmp uge i64 0, %t79
  ; bounds check: %t80 (if true, out of bounds)
  %t81 = getelementptr %TypeDescriptor*, %TypeDescriptor** %t78, i64 0
  %t82 = load %TypeDescriptor*, %TypeDescriptor** %t81
  store %TypeDescriptor* %t82, %TypeDescriptor** %l2
  store i64 0, i64* %l3
  %t83 = load %TypeDescriptor*, %TypeDescriptor** %l2
  %t84 = load i64, i64* %l3
  br label %loop.header30
loop.header30:
  %t106 = phi i64 [ %t84, %then24 ], [ %t105, %loop.latch32 ]
  store i64 %t106, i64* %l3
  br label %loop.body31
loop.body31:
  %t85 = load i64, i64* %l3
  %t86 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t87 = icmp sge i64 %t85, %t86
  %t88 = load %TypeDescriptor*, %TypeDescriptor** %l2
  %t89 = load i64, i64* %l3
  br i1 %t87, label %then34, label %merge35
then34:
  br label %afterloop33
merge35:
  %t90 = load i64, i64* %l3
  %t91 = getelementptr i8, i8* %value, i64 %t90
  %t92 = load i8, i8* %t91
  %t93 = load %TypeDescriptor*, %TypeDescriptor** %l2
  %t94 = alloca [2 x i8], align 1
  %t95 = getelementptr [2 x i8], [2 x i8]* %t94, i32 0, i32 0
  store i8 %t92, i8* %t95
  %t96 = getelementptr [2 x i8], [2 x i8]* %t94, i32 0, i32 1
  store i8 0, i8* %t96
  %t97 = getelementptr [2 x i8], [2 x i8]* %t94, i32 0, i32 0
  %t98 = load %TypeDescriptor, %TypeDescriptor* %t93
  %t99 = call i1 @check_type_descriptor(i8* %t97, %TypeDescriptor %t98)
  %t100 = xor i1 %t99, 1
  %t101 = load %TypeDescriptor*, %TypeDescriptor** %l2
  %t102 = load i64, i64* %l3
  br i1 %t100, label %then36, label %merge37
then36:
  ret i1 0
merge37:
  %t103 = load i64, i64* %l3
  %t104 = add i64 %t103, 1
  store i64 %t104, i64* %l3
  br label %loop.latch32
loop.latch32:
  %t105 = load i64, i64* %l3
  br label %loop.header30
afterloop33:
  ret i1 1
merge25:
  %t107 = extractvalue %TypeDescriptor %descriptor, 0
  %s108 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.108, i32 0, i32 0
  %t109 = icmp eq i8* %t107, %s108
  br i1 %t109, label %then38, label %merge39
then38:
  %t110 = load i8*, i8** @runtime
  %t111 = call double @runtimeis_callable(i8* %value)
  %t112 = fcmp one double %t111, 0.0
  ret i1 %t112
merge39:
  %t113 = extractvalue %TypeDescriptor %descriptor, 0
  %s114 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.114, i32 0, i32 0
  %t115 = icmp eq i8* %t113, %s114
  br i1 %t115, label %then40, label %merge41
then40:
  %t116 = extractvalue %TypeDescriptor %descriptor, 1
  %t117 = icmp eq i8* %t116, null
  br i1 %t117, label %then42, label %merge43
then42:
  ret i1 0
merge43:
  %t118 = load i8*, i8** @runtime
  %t119 = extractvalue %TypeDescriptor %descriptor, 1
  %t120 = call double @runtimeresolve_runtime_type(i8* %t119)
  store double %t120, double* %l4
  %t121 = load i8*, i8** @runtime
  %t122 = load double, double* %l4
  %t123 = call double @runtimeinstance_of(i8* %value, double %t122)
  %t124 = fcmp one double %t123, 0.0
  ret i1 %t124
merge41:
  %t125 = extractvalue %TypeDescriptor %descriptor, 0
  %s126 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.126, i32 0, i32 0
  %t127 = icmp eq i8* %t125, %s126
  br i1 %t127, label %then44, label %merge45
then44:
  ret i1 0
merge45:
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
  %t0 = load i8*, i8** @runtime
  %t1 = call double @runtimeserve(i8* %handler, i8* %config)
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
  %t51 = phi i8* [ %t26, %entry ], [ %t49, %loop.latch6 ]
  %t52 = phi double [ %t25, %entry ], [ %t50, %loop.latch6 ]
  store i8* %t51, i8** %l4
  store double %t52, double* %l3
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
  %t40 = load i8, i8* %t35
  %t41 = add i8 %t40, %t39
  %t42 = alloca [2 x i8], align 1
  %t43 = getelementptr [2 x i8], [2 x i8]* %t42, i32 0, i32 0
  store i8 %t41, i8* %t43
  %t44 = getelementptr [2 x i8], [2 x i8]* %t42, i32 0, i32 1
  store i8 0, i8* %t44
  %t45 = getelementptr [2 x i8], [2 x i8]* %t42, i32 0, i32 0
  store i8* %t45, i8** %l4
  %t46 = load double, double* %l3
  %t47 = sitofp i64 1 to double
  %t48 = fadd double %t46, %t47
  store double %t48, double* %l3
  br label %loop.latch6
loop.latch6:
  %t49 = load i8*, i8** %l4
  %t50 = load double, double* %l3
  br label %loop.header4
afterloop7:
  %t53 = load i8*, i8** %l4
  ret i8* %t53
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
  %t26 = load i8, i8* %t25
  %t27 = icmp eq i8 %t26, 92
  br label %logical_and_right_end_19

logical_and_right_end_19:
  br label %logical_and_merge_19

logical_and_merge_19:
  %t28 = phi i1 [ false, %logical_and_entry_19 ], [ %t27, %logical_and_right_end_19 ]
  %t29 = load i64, i64* %l0
  %t30 = load double, double* %l1
  %t31 = load i8*, i8** %l2
  br i1 %t28, label %then6, label %merge7
then6:
  %t32 = load i8*, i8** %l2
  %t33 = sitofp i64 1 to double
  %t34 = call i8* @char_at(i8* %t32, double %t33)
  store i8* %t34, i8** %l3
  %t35 = load i8*, i8** %l3
  %t36 = load i8, i8* %t35
  %t37 = icmp eq i8 %t36, 110
  %t38 = load i64, i64* %l0
  %t39 = load double, double* %l1
  %t40 = load i8*, i8** %l2
  %t41 = load i8*, i8** %l3
  br i1 %t37, label %then8, label %else9
then8:
  %t42 = alloca [2 x i8], align 1
  %t43 = getelementptr [2 x i8], [2 x i8]* %t42, i32 0, i32 0
  store i8 10, i8* %t43
  %t44 = getelementptr [2 x i8], [2 x i8]* %t42, i32 0, i32 1
  store i8 0, i8* %t44
  %t45 = getelementptr [2 x i8], [2 x i8]* %t42, i32 0, i32 0
  store i8* %t45, i8** %l2
  br label %merge10
else9:
  %t46 = load i8*, i8** %l3
  %t47 = load i8, i8* %t46
  %t48 = icmp eq i8 %t47, 114
  %t49 = load i64, i64* %l0
  %t50 = load double, double* %l1
  %t51 = load i8*, i8** %l2
  %t52 = load i8*, i8** %l3
  br i1 %t48, label %then11, label %else12
then11:
  %t53 = alloca [2 x i8], align 1
  %t54 = getelementptr [2 x i8], [2 x i8]* %t53, i32 0, i32 0
  store i8 13, i8* %t54
  %t55 = getelementptr [2 x i8], [2 x i8]* %t53, i32 0, i32 1
  store i8 0, i8* %t55
  %t56 = getelementptr [2 x i8], [2 x i8]* %t53, i32 0, i32 0
  store i8* %t56, i8** %l2
  br label %merge13
else12:
  %t57 = load i8*, i8** %l3
  %t58 = load i8, i8* %t57
  %t59 = icmp eq i8 %t58, 116
  %t60 = load i64, i64* %l0
  %t61 = load double, double* %l1
  %t62 = load i8*, i8** %l2
  %t63 = load i8*, i8** %l3
  br i1 %t59, label %then14, label %merge15
then14:
  %t64 = alloca [2 x i8], align 1
  %t65 = getelementptr [2 x i8], [2 x i8]* %t64, i32 0, i32 0
  store i8 9, i8* %t65
  %t66 = getelementptr [2 x i8], [2 x i8]* %t64, i32 0, i32 1
  store i8 0, i8* %t66
  %t67 = getelementptr [2 x i8], [2 x i8]* %t64, i32 0, i32 0
  store i8* %t67, i8** %l2
  br label %merge15
merge15:
  %t68 = phi i8* [ %t67, %then14 ], [ %t62, %else12 ]
  store i8* %t68, i8** %l2
  br label %merge13
merge13:
  %t69 = phi i8* [ %t56, %then11 ], [ %t67, %else12 ]
  store i8* %t69, i8** %l2
  br label %merge10
merge10:
  %t70 = phi i8* [ %t45, %then8 ], [ %t56, %else9 ]
  store i8* %t70, i8** %l2
  br label %merge7
merge7:
  %t71 = phi i8* [ %t45, %then6 ], [ %t31, %entry ]
  %t72 = phi i8* [ %t56, %then6 ], [ %t31, %entry ]
  %t73 = phi i8* [ %t67, %then6 ], [ %t31, %entry ]
  store i8* %t71, i8** %l2
  store i8* %t72, i8** %l2
  store i8* %t73, i8** %l2
  %t74 = load double, double* %l1
  store double %t74, double* %l4
  %t75 = load i64, i64* %l0
  %t76 = load double, double* %l1
  %t77 = load i8*, i8** %l2
  %t78 = load double, double* %l4
  br label %loop.header16
loop.header16:
  %t100 = phi double [ %t78, %entry ], [ %t99, %loop.latch18 ]
  store double %t100, double* %l4
  br label %loop.body17
loop.body17:
  %t79 = load double, double* %l4
  %t80 = load i64, i64* %l0
  %t81 = sitofp i64 %t80 to double
  %t82 = fcmp oge double %t79, %t81
  %t83 = load i64, i64* %l0
  %t84 = load double, double* %l1
  %t85 = load i8*, i8** %l2
  %t86 = load double, double* %l4
  br i1 %t82, label %then20, label %merge21
then20:
  br label %afterloop19
merge21:
  %t87 = load double, double* %l4
  %t88 = call i8* @char_at(i8* %text, double %t87)
  %t89 = load i8*, i8** %l2
  %t90 = icmp eq i8* %t88, %t89
  %t91 = load i64, i64* %l0
  %t92 = load double, double* %l1
  %t93 = load i8*, i8** %l2
  %t94 = load double, double* %l4
  br i1 %t90, label %then22, label %merge23
then22:
  %t95 = load double, double* %l4
  ret double %t95
merge23:
  %t96 = load double, double* %l4
  %t97 = sitofp i64 1 to double
  %t98 = fadd double %t96, %t97
  store double %t98, double* %l4
  br label %loop.latch18
loop.latch18:
  %t99 = load double, double* %l4
  br label %loop.header16
afterloop19:
  %t101 = sitofp i64 -1 to double
  ret double %t101
}

define void @match_exhaustive_failed(i8* %value) {
entry:
  %l0 = alloca i8*
  %s0 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = load i8*, i8** @runtime
  %t2 = load i8*, i8** %l0
  %t3 = call double @runtimeraise_value_error(i8* %t2)
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
  %t54 = load i8, i8* %t53
  %t55 = icmp eq i8 %t54, 32
  %t56 = load i8*, i8** %l0
  %t57 = load i8*, i8** %l1
  %t58 = load double, double* %l2
  %t59 = load i8*, i8** %l3
  %t60 = load double, double* %l4
  %t61 = load i8*, i8** %l5
  %t62 = load double, double* %l6
  br i1 %t55, label %then8, label %merge9
then8:
  %t63 = sitofp i64 32 to double
  ret double %t63
merge9:
  %t64 = load i8*, i8** %l0
  %t65 = load i8, i8* %t64
  %t66 = icmp eq i8 %t65, 10
  %t67 = load i8*, i8** %l0
  %t68 = load i8*, i8** %l1
  %t69 = load double, double* %l2
  %t70 = load i8*, i8** %l3
  %t71 = load double, double* %l4
  %t72 = load i8*, i8** %l5
  %t73 = load double, double* %l6
  br i1 %t66, label %then10, label %merge11
then10:
  %t74 = sitofp i64 10 to double
  ret double %t74
merge11:
  %t75 = load i8*, i8** %l0
  %t76 = load i8, i8* %t75
  %t77 = icmp eq i8 %t76, 13
  %t78 = load i8*, i8** %l0
  %t79 = load i8*, i8** %l1
  %t80 = load double, double* %l2
  %t81 = load i8*, i8** %l3
  %t82 = load double, double* %l4
  %t83 = load i8*, i8** %l5
  %t84 = load double, double* %l6
  br i1 %t77, label %then12, label %merge13
then12:
  %t85 = sitofp i64 13 to double
  ret double %t85
merge13:
  %t86 = load i8*, i8** %l0
  %t87 = load i8, i8* %t86
  %t88 = icmp eq i8 %t87, 9
  %t89 = load i8*, i8** %l0
  %t90 = load i8*, i8** %l1
  %t91 = load double, double* %l2
  %t92 = load i8*, i8** %l3
  %t93 = load double, double* %l4
  %t94 = load i8*, i8** %l5
  %t95 = load double, double* %l6
  br i1 %t88, label %then14, label %merge15
then14:
  %t96 = sitofp i64 9 to double
  ret double %t96
merge15:
  %t97 = load i8*, i8** %l0
  %t98 = load i8, i8* %t97
  %t99 = icmp eq i8 %t98, 34
  %t100 = load i8*, i8** %l0
  %t101 = load i8*, i8** %l1
  %t102 = load double, double* %l2
  %t103 = load i8*, i8** %l3
  %t104 = load double, double* %l4
  %t105 = load i8*, i8** %l5
  %t106 = load double, double* %l6
  br i1 %t99, label %then16, label %merge17
then16:
  %t107 = sitofp i64 34 to double
  ret double %t107
merge17:
  %t108 = load i8*, i8** %l0
  %t109 = load i8, i8* %t108
  %t110 = icmp eq i8 %t109, 92
  %t111 = load i8*, i8** %l0
  %t112 = load i8*, i8** %l1
  %t113 = load double, double* %l2
  %t114 = load i8*, i8** %l3
  %t115 = load double, double* %l4
  %t116 = load i8*, i8** %l5
  %t117 = load double, double* %l6
  br i1 %t110, label %then18, label %merge19
then18:
  %t118 = sitofp i64 92 to double
  ret double %t118
merge19:
  %t119 = load i8*, i8** %l0
  %t120 = load i8, i8* %t119
  %t121 = icmp eq i8 %t120, 95
  %t122 = load i8*, i8** %l0
  %t123 = load i8*, i8** %l1
  %t124 = load double, double* %l2
  %t125 = load i8*, i8** %l3
  %t126 = load double, double* %l4
  %t127 = load i8*, i8** %l5
  %t128 = load double, double* %l6
  br i1 %t121, label %then20, label %merge21
then20:
  %t129 = sitofp i64 95 to double
  ret double %t129
merge21:
  %t130 = load i8*, i8** %l0
  %s131 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.131, i32 0, i32 0
  %t132 = call double @chencode(i8* %s131)
  store double %t132, double* %l7
  %t133 = load double, double* %l7
  store double 0.0, double* %l8
  %t134 = load double, double* %l8
  %t135 = sitofp i64 0 to double
  %t136 = fcmp oeq double %t134, %t135
  %t137 = load i8*, i8** %l0
  %t138 = load i8*, i8** %l1
  %t139 = load double, double* %l2
  %t140 = load i8*, i8** %l3
  %t141 = load double, double* %l4
  %t142 = load i8*, i8** %l5
  %t143 = load double, double* %l6
  %t144 = load double, double* %l7
  %t145 = load double, double* %l8
  br i1 %t136, label %then22, label %merge23
then22:
  %t146 = sitofp i64 -1 to double
  ret double %t146
merge23:
  %t147 = load double, double* %l8
  %t148 = sitofp i64 4 to double
  %t149 = fcmp ogt double %t147, %t148
  %t150 = load i8*, i8** %l0
  %t151 = load i8*, i8** %l1
  %t152 = load double, double* %l2
  %t153 = load i8*, i8** %l3
  %t154 = load double, double* %l4
  %t155 = load i8*, i8** %l5
  %t156 = load double, double* %l6
  %t157 = load double, double* %l7
  %t158 = load double, double* %l8
  br i1 %t149, label %then24, label %merge25
then24:
  %t159 = sitofp i64 -1 to double
  ret double %t159
merge25:
  store i64 0, i64* %l9
  store i64 0, i64* %l10
  %t160 = load i8*, i8** %l0
  %t161 = load i8*, i8** %l1
  %t162 = load double, double* %l2
  %t163 = load i8*, i8** %l3
  %t164 = load double, double* %l4
  %t165 = load i8*, i8** %l5
  %t166 = load double, double* %l6
  %t167 = load double, double* %l7
  %t168 = load double, double* %l8
  %t169 = load i64, i64* %l9
  %t170 = load i64, i64* %l10
  br label %loop.header26
loop.header26:
  %t327 = phi i64 [ %t170, %entry ], [ %t325, %loop.latch28 ]
  %t328 = phi i64 [ %t169, %entry ], [ %t326, %loop.latch28 ]
  store i64 %t327, i64* %l10
  store i64 %t328, i64* %l9
  br label %loop.body27
loop.body27:
  %t171 = load i64, i64* %l9
  %t172 = load double, double* %l8
  %t173 = sitofp i64 %t171 to double
  %t174 = fcmp oge double %t173, %t172
  %t175 = load i8*, i8** %l0
  %t176 = load i8*, i8** %l1
  %t177 = load double, double* %l2
  %t178 = load i8*, i8** %l3
  %t179 = load double, double* %l4
  %t180 = load i8*, i8** %l5
  %t181 = load double, double* %l6
  %t182 = load double, double* %l7
  %t183 = load double, double* %l8
  %t184 = load i64, i64* %l9
  %t185 = load i64, i64* %l10
  br i1 %t174, label %then30, label %merge31
then30:
  br label %afterloop29
merge31:
  %t186 = load double, double* %l7
  %t187 = load i64, i64* %l9
  store double 0.0, double* %l11
  %t188 = load i64, i64* %l9
  %t189 = icmp eq i64 %t188, 0
  %t190 = load i8*, i8** %l0
  %t191 = load i8*, i8** %l1
  %t192 = load double, double* %l2
  %t193 = load i8*, i8** %l3
  %t194 = load double, double* %l4
  %t195 = load i8*, i8** %l5
  %t196 = load double, double* %l6
  %t197 = load double, double* %l7
  %t198 = load double, double* %l8
  %t199 = load i64, i64* %l9
  %t200 = load i64, i64* %l10
  %t201 = load double, double* %l11
  br i1 %t189, label %then32, label %else33
then32:
  %t202 = load double, double* %l11
  %t203 = sitofp i64 128 to double
  %t204 = fcmp olt double %t202, %t203
  %t205 = load i8*, i8** %l0
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
  br i1 %t204, label %then35, label %merge36
then35:
  %t217 = load double, double* %l11
  ret double %t217
merge36:
  %t219 = load double, double* %l11
  %t220 = sitofp i64 192 to double
  %t221 = fcmp oge double %t219, %t220
  br label %logical_and_entry_218

logical_and_entry_218:
  br i1 %t221, label %logical_and_right_218, label %logical_and_merge_218

logical_and_right_218:
  %t222 = load double, double* %l11
  %t223 = sitofp i64 223 to double
  %t224 = fcmp ole double %t222, %t223
  br label %logical_and_right_end_218

logical_and_right_end_218:
  br label %logical_and_merge_218

logical_and_merge_218:
  %t225 = phi i1 [ false, %logical_and_entry_218 ], [ %t224, %logical_and_right_end_218 ]
  %t226 = load i8*, i8** %l0
  %t227 = load i8*, i8** %l1
  %t228 = load double, double* %l2
  %t229 = load i8*, i8** %l3
  %t230 = load double, double* %l4
  %t231 = load i8*, i8** %l5
  %t232 = load double, double* %l6
  %t233 = load double, double* %l7
  %t234 = load double, double* %l8
  %t235 = load i64, i64* %l9
  %t236 = load i64, i64* %l10
  %t237 = load double, double* %l11
  br i1 %t225, label %then37, label %else38
then37:
  %t238 = load double, double* %l11
  %t239 = sitofp i64 192 to double
  %t240 = fsub double %t238, %t239
  %t241 = fptosi double %t240 to i64
  store i64 %t241, i64* %l10
  br label %merge39
else38:
  %t243 = load double, double* %l11
  %t244 = sitofp i64 224 to double
  %t245 = fcmp oge double %t243, %t244
  br label %logical_and_entry_242

logical_and_entry_242:
  br i1 %t245, label %logical_and_right_242, label %logical_and_merge_242

logical_and_right_242:
  %t246 = load double, double* %l11
  %t247 = sitofp i64 239 to double
  %t248 = fcmp ole double %t246, %t247
  br label %logical_and_right_end_242

logical_and_right_end_242:
  br label %logical_and_merge_242

logical_and_merge_242:
  %t249 = phi i1 [ false, %logical_and_entry_242 ], [ %t248, %logical_and_right_end_242 ]
  %t250 = load i8*, i8** %l0
  %t251 = load i8*, i8** %l1
  %t252 = load double, double* %l2
  %t253 = load i8*, i8** %l3
  %t254 = load double, double* %l4
  %t255 = load i8*, i8** %l5
  %t256 = load double, double* %l6
  %t257 = load double, double* %l7
  %t258 = load double, double* %l8
  %t259 = load i64, i64* %l9
  %t260 = load i64, i64* %l10
  %t261 = load double, double* %l11
  br i1 %t249, label %then40, label %else41
then40:
  %t262 = load double, double* %l11
  %t263 = sitofp i64 224 to double
  %t264 = fsub double %t262, %t263
  %t265 = fptosi double %t264 to i64
  store i64 %t265, i64* %l10
  br label %merge42
else41:
  %t267 = load double, double* %l11
  %t268 = sitofp i64 240 to double
  %t269 = fcmp oge double %t267, %t268
  br label %logical_and_entry_266

logical_and_entry_266:
  br i1 %t269, label %logical_and_right_266, label %logical_and_merge_266

logical_and_right_266:
  %t270 = load double, double* %l11
  %t271 = sitofp i64 247 to double
  %t272 = fcmp ole double %t270, %t271
  br label %logical_and_right_end_266

logical_and_right_end_266:
  br label %logical_and_merge_266

logical_and_merge_266:
  %t273 = phi i1 [ false, %logical_and_entry_266 ], [ %t272, %logical_and_right_end_266 ]
  %t274 = load i8*, i8** %l0
  %t275 = load i8*, i8** %l1
  %t276 = load double, double* %l2
  %t277 = load i8*, i8** %l3
  %t278 = load double, double* %l4
  %t279 = load i8*, i8** %l5
  %t280 = load double, double* %l6
  %t281 = load double, double* %l7
  %t282 = load double, double* %l8
  %t283 = load i64, i64* %l9
  %t284 = load i64, i64* %l10
  %t285 = load double, double* %l11
  br i1 %t273, label %then43, label %else44
then43:
  %t286 = load double, double* %l11
  %t287 = sitofp i64 240 to double
  %t288 = fsub double %t286, %t287
  %t289 = fptosi double %t288 to i64
  store i64 %t289, i64* %l10
  br label %merge45
else44:
  %t290 = sitofp i64 -1 to double
  ret double %t290
merge45:
  br label %merge42
merge42:
  %t291 = phi i64 [ %t265, %then40 ], [ %t289, %else41 ]
  store i64 %t291, i64* %l10
  br label %merge39
merge39:
  %t292 = phi i64 [ %t241, %then37 ], [ %t265, %else38 ]
  store i64 %t292, i64* %l10
  br label %merge34
else33:
  %t294 = load double, double* %l11
  %t295 = sitofp i64 128 to double
  %t296 = fcmp olt double %t294, %t295
  br label %logical_or_entry_293

logical_or_entry_293:
  br i1 %t296, label %logical_or_merge_293, label %logical_or_right_293

logical_or_right_293:
  %t297 = load double, double* %l11
  %t298 = sitofp i64 191 to double
  %t299 = fcmp ogt double %t297, %t298
  br label %logical_or_right_end_293

logical_or_right_end_293:
  br label %logical_or_merge_293

logical_or_merge_293:
  %t300 = phi i1 [ true, %logical_or_entry_293 ], [ %t299, %logical_or_right_end_293 ]
  %t301 = load i8*, i8** %l0
  %t302 = load i8*, i8** %l1
  %t303 = load double, double* %l2
  %t304 = load i8*, i8** %l3
  %t305 = load double, double* %l4
  %t306 = load i8*, i8** %l5
  %t307 = load double, double* %l6
  %t308 = load double, double* %l7
  %t309 = load double, double* %l8
  %t310 = load i64, i64* %l9
  %t311 = load i64, i64* %l10
  %t312 = load double, double* %l11
  br i1 %t300, label %then46, label %merge47
then46:
  %t313 = sitofp i64 -1 to double
  ret double %t313
merge47:
  %t314 = load i64, i64* %l10
  %t315 = mul i64 %t314, 64
  %t316 = load double, double* %l11
  %t317 = sitofp i64 128 to double
  %t318 = fsub double %t316, %t317
  %t319 = sitofp i64 %t315 to double
  %t320 = fadd double %t319, %t318
  %t321 = fptosi double %t320 to i64
  store i64 %t321, i64* %l10
  br label %merge34
merge34:
  %t322 = phi i64 [ %t241, %then32 ], [ %t321, %else33 ]
  store i64 %t322, i64* %l10
  %t323 = load i64, i64* %l9
  %t324 = add i64 %t323, 1
  store i64 %t324, i64* %l9
  br label %loop.latch28
loop.latch28:
  %t325 = load i64, i64* %l10
  %t326 = load i64, i64* %l9
  br label %loop.header26
afterloop29:
  %t329 = load i64, i64* %l10
  %t330 = sitofp i64 %t329 to double
  ret double %t330
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
  %t34 = phi i64 [ %t0, %entry ], [ %t33, %loop.latch2 ]
  store i64 %t34, i64* %l0
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
  %t13 = load i64, i64* %l0
  %t14 = add i64 %t13, 1
  %t15 = load { double*, i64 }, { double*, i64 }* %ranges
  %t16 = extractvalue { double*, i64 } %t15, 0
  %t17 = extractvalue { double*, i64 } %t15, 1
  %t18 = icmp uge i64 %t14, %t17
  ; bounds check: %t18 (if true, out of bounds)
  %t19 = getelementptr double, double* %t16, i64 %t14
  %t20 = load double, double* %t19
  store double %t20, double* %l2
  %t21 = load double, double* %l1
  %t22 = fcmp olt double %codepoint, %t21
  %t23 = load i64, i64* %l0
  %t24 = load double, double* %l1
  %t25 = load double, double* %l2
  br i1 %t22, label %then6, label %merge7
then6:
  br label %afterloop3
merge7:
  %t26 = load double, double* %l2
  %t27 = fcmp ole double %codepoint, %t26
  %t28 = load i64, i64* %l0
  %t29 = load double, double* %l1
  %t30 = load double, double* %l2
  br i1 %t27, label %then8, label %merge9
then8:
  ret i1 1
merge9:
  %t31 = load i64, i64* %l0
  %t32 = add i64 %t31, 2
  store i64 %t32, i64* %l0
  br label %loop.latch2
loop.latch2:
  %t33 = load i64, i64* %l0
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
