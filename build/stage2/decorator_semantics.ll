; ModuleID = 'sailfin'
source_filename = "sailfin"

%DecoratorArgumentInfo = type { i8*, i8* }
%DecoratorInfo = type { i8*, { i8**, i64 }* }

%LiteralValue = type { i32, [8 x i8] }

declare noalias i8* @malloc(i64)

@.str.2 = private unnamed_addr constant [3 x i8] c"io\00"

define { i8**, i64 }* @infer_effects({ i8**, i64 }* %existing, { %DecoratorInfo*, i64 }* %decorators) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i1
  %l2 = alloca double
  %l3 = alloca %DecoratorInfo
  %t0 = call { i8**, i64 }* @clone_effects({ i8**, i64 }* %existing)
  store { i8**, i64 }* %t0, { i8**, i64 }** %l0
  %t1 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s2 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.2, i32 0, i32 0
  %t3 = call i1 @contains_effect({ i8**, i64 }* %t1, i8* %s2)
  store i1 %t3, i1* %l1
  %t4 = sitofp i64 0 to double
  store double %t4, double* %l2
  %t5 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t6 = load i1, i1* %l1
  %t7 = load double, double* %l2
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l2
  %t9 = load double, double* %l2
  %t10 = load { %DecoratorInfo*, i64 }, { %DecoratorInfo*, i64 }* %decorators
  %t11 = extractvalue { %DecoratorInfo*, i64 } %t10, 0
  %t12 = extractvalue { %DecoratorInfo*, i64 } %t10, 1
  %t13 = icmp uge i64 %t9, %t12
  ; bounds check: %t13 (if true, out of bounds)
  %t14 = getelementptr %DecoratorInfo, %DecoratorInfo* %t11, i64 %t9
  %t15 = load %DecoratorInfo, %DecoratorInfo* %t14
  store %DecoratorInfo %t15, %DecoratorInfo* %l3
  %t16 = load %DecoratorInfo, %DecoratorInfo* %l3
  %t17 = extractvalue %DecoratorInfo %t16, 0
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s19 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.19, i32 0, i32 0
  %t20 = call double @requires_iocontains_effect({ i8**, i64 }* %t18, i8* %s19)
  %t21 = fcmp one double %t20, 0.0
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t23 = load i1, i1* %l1
  %t24 = load double, double* %l2
  br i1 %t21, label %then4, label %merge5
then4:
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s26 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.26, i32 0, i32 0
  %t27 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t25, i8* %s26)
  store { i8**, i64 }* %t27, { i8**, i64 }** %l0
  br label %merge5
merge5:
  %t28 = phi { i8**, i64 }* [ %t27, %then4 ], [ %t22, %entry ]
  store { i8**, i64 }* %t28, { i8**, i64 }** %l0
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t29
}

define { %DecoratorInfo*, i64 }* @evaluate_decorators(double %decorators) {
entry:
  %l0 = alloca { %DecoratorInfo*, i64 }*
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
  store { %DecoratorInfo*, i64 }* null, { %DecoratorInfo*, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t12 = phi { %DecoratorInfo*, i64 }* [ %t6, %entry ], [ %t11, %loop.latch2 ]
  store { %DecoratorInfo*, i64 }* %t12, { %DecoratorInfo*, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load double, double* %l1
  store double 0.0, double* %l2
  %t10 = load double, double* %l2
  store double 0.0, double* %l3
  br label %loop.latch2
loop.latch2:
  %t11 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t13 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  ret { %DecoratorInfo*, i64 }* %t13
}

define { %DecoratorArgumentInfo*, i64 }* @evaluate_arguments(double %arguments) {
entry:
  %l0 = alloca { %DecoratorArgumentInfo*, i64 }*
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
  store { %DecoratorArgumentInfo*, i64 }* null, { %DecoratorArgumentInfo*, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { %DecoratorArgumentInfo*, i64 }*, { %DecoratorArgumentInfo*, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t12 = phi { %DecoratorArgumentInfo*, i64 }* [ %t6, %entry ], [ %t11, %loop.latch2 ]
  store { %DecoratorArgumentInfo*, i64 }* %t12, { %DecoratorArgumentInfo*, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load double, double* %l1
  store double 0.0, double* %l2
  %t10 = load double, double* %l2
  store double 0.0, double* %l3
  br label %loop.latch2
loop.latch2:
  %t11 = load { %DecoratorArgumentInfo*, i64 }*, { %DecoratorArgumentInfo*, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t13 = load { %DecoratorArgumentInfo*, i64 }*, { %DecoratorArgumentInfo*, i64 }** %l0
  ret { %DecoratorArgumentInfo*, i64 }* %t13
}

define %LiteralValue @evaluate_expression(double %expr) {
entry:
  %t0 = call double @LiteralValueUnsupported()
  ret %LiteralValue zeroinitializer
}

define { %DecoratorInfo*, i64 }* @evaluate_statement_decorators(double %statement) {
entry:
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  ret { %DecoratorInfo*, i64 }* null
}

define i8* @trim_whitespace(i8* %value) {
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
  %t12 = call i1 @is_whitespace_char(i8* null)
  %t13 = load double, double* %l0
  %t14 = load double, double* %l1
  %t15 = load i8, i8* %l2
  br i1 %t12, label %then6, label %merge7
then6:
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  br label %loop.header0
afterloop3:
  %t16 = load double, double* %l0
  %t17 = load double, double* %l1
  br label %loop.header8
loop.header8:
  br label %loop.body9
loop.body9:
  %t18 = load double, double* %l1
  %t19 = load double, double* %l0
  %t20 = fcmp ole double %t18, %t19
  %t21 = load double, double* %l0
  %t22 = load double, double* %l1
  br i1 %t20, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  store double 0.0, double* %l3
  %t23 = load double, double* %l3
  %t24 = call i1 @is_whitespace_char(i8* null)
  %t25 = load double, double* %l0
  %t26 = load double, double* %l1
  %t27 = load double, double* %l3
  br i1 %t24, label %then14, label %merge15
then14:
  %t28 = load double, double* %l1
  br label %loop.latch10
merge15:
  br label %afterloop11
loop.latch10:
  br label %loop.header8
afterloop11:
  %t29 = load double, double* %l0
  %t30 = load double, double* %l1
  %t31 = call i8* @slice_text(i8* %value, double %t29, double %t30)
  ret i8* %t31
}

define i1 @looks_like_quoted_string(i8* %text) {
entry:
  %t0 = getelementptr i8, i8* %text, i64 0
  %t1 = load i8, i8* %t0
  %s2 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.2, i32 0, i32 0
  ret i1 1
}

define i1 @looks_like_number(i8* %text) {
entry:
  %l0 = alloca i1
  %l1 = alloca double
  %l2 = alloca i8
  store i1 0, i1* %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = getelementptr i8, i8* %text, i64 0
  %t2 = load i8, i8* %t1
  %t3 = load i1, i1* %l0
  %t4 = load double, double* %l1
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t5 = load double, double* %l1
  %t6 = load double, double* %l1
  %t7 = getelementptr i8, i8* %text, i64 %t6
  %t8 = load i8, i8* %t7
  store i8 %t8, i8* %l2
  %t9 = load i8, i8* %l2
  %s10 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.10, i32 0, i32 0
  %t11 = load i8, i8* %l2
  %t12 = call double @is_decimal_digit(i8 %t11)
  %t13 = fcmp one double %t12, 0.0
  %t14 = load i1, i1* %l0
  %t15 = load double, double* %l1
  %t16 = load i8, i8* %l2
  br i1 %t13, label %then4, label %merge5
then4:
  ret i1 0
merge5:
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  ret i1 1
}

define i1 @is_decimal_digit(i8* %ch) {
entry:
  ret i1 false
}

define { %DecoratorInfo*, i64 }* @append_decorator_info({ %DecoratorInfo*, i64 }* %collection, %DecoratorInfo %item) {
entry:
  %t0 = alloca [1 x %DecoratorInfo]
  %t1 = getelementptr [1 x %DecoratorInfo], [1 x %DecoratorInfo]* %t0, i32 0, i32 0
  %t2 = getelementptr %DecoratorInfo, %DecoratorInfo* %t1, i64 0
  store %DecoratorInfo %item, %DecoratorInfo* %t2
  %t3 = alloca { %DecoratorInfo*, i64 }
  %t4 = getelementptr { %DecoratorInfo*, i64 }, { %DecoratorInfo*, i64 }* %t3, i32 0, i32 0
  store %DecoratorInfo* %t1, %DecoratorInfo** %t4
  %t5 = getelementptr { %DecoratorInfo*, i64 }, { %DecoratorInfo*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @collectionconcat({ %DecoratorInfo*, i64 }* %t3)
  ret { %DecoratorInfo*, i64 }* null
}

define { %DecoratorArgumentInfo*, i64 }* @append_argument_info({ %DecoratorArgumentInfo*, i64 }* %collection, %DecoratorArgumentInfo %item) {
entry:
  %t0 = alloca [1 x %DecoratorArgumentInfo]
  %t1 = getelementptr [1 x %DecoratorArgumentInfo], [1 x %DecoratorArgumentInfo]* %t0, i32 0, i32 0
  %t2 = getelementptr %DecoratorArgumentInfo, %DecoratorArgumentInfo* %t1, i64 0
  store %DecoratorArgumentInfo %item, %DecoratorArgumentInfo* %t2
  %t3 = alloca { %DecoratorArgumentInfo*, i64 }
  %t4 = getelementptr { %DecoratorArgumentInfo*, i64 }, { %DecoratorArgumentInfo*, i64 }* %t3, i32 0, i32 0
  store %DecoratorArgumentInfo* %t1, %DecoratorArgumentInfo** %t4
  %t5 = getelementptr { %DecoratorArgumentInfo*, i64 }, { %DecoratorArgumentInfo*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @collectionconcat({ %DecoratorArgumentInfo*, i64 }* %t3)
  ret { %DecoratorArgumentInfo*, i64 }* null
}

define { i8**, i64 }* @append_string({ i8**, i64 }* %collection, i8* %item) {
entry:
  %t0 = alloca [1 x i8*]
  %t1 = getelementptr [1 x i8*], [1 x i8*]* %t0, i32 0, i32 0
  %t2 = getelementptr i8*, i8** %t1, i64 0
  store i8* %item, i8** %t2
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t1, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @collectionconcat({ i8**, i64 }* %t3)
  ret { i8**, i64 }* null
}

define { i8**, i64 }* @clone_effects({ i8**, i64 }* %effects) {
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
  %t19 = phi { i8**, i64 }* [ %t6, %entry ], [ %t18, %loop.latch2 ]
  store { i8**, i64 }* %t19, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t10 = load double, double* %l1
  %t11 = load { i8**, i64 }, { i8**, i64 }* %effects
  %t12 = extractvalue { i8**, i64 } %t11, 0
  %t13 = extractvalue { i8**, i64 } %t11, 1
  %t14 = icmp uge i64 %t10, %t13
  ; bounds check: %t14 (if true, out of bounds)
  %t15 = getelementptr i8*, i8** %t12, i64 %t10
  %t16 = load i8*, i8** %t15
  %t17 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t9, i8* %t16)
  store { i8**, i64 }* %t17, { i8**, i64 }** %l0
  br label %loop.latch2
loop.latch2:
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t20
}

define i1 @contains_effect({ i8**, i64 }* %effects, i8* %effect) {
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
  %t4 = load { i8**, i64 }, { i8**, i64 }* %effects
  %t5 = extractvalue { i8**, i64 } %t4, 0
  %t6 = extractvalue { i8**, i64 } %t4, 1
  %t7 = icmp uge i64 %t3, %t6
  ; bounds check: %t7 (if true, out of bounds)
  %t8 = getelementptr i8*, i8** %t5, i64 %t3
  %t9 = load i8*, i8** %t8
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  ret i1 0
}

define i1 @is_whitespace_char(i8* %ch) {
entry:
  ret i1 false
}

define i8* @slice_text(i8* %text, double %start, double %end) {
entry:
  %t0 = call double @substring(i8* %text, double %start, double %end)
  ret i8* null
}

define i8* @strip_surrounding_quotes(i8* %value) {
entry:
  ret i8* null
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
