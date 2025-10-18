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
  %l3 = alloca double
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
  store double 0.0, double* %l3
  %t9 = load double, double* %l3
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t10 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s11 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.11, i32 0, i32 0
  %t12 = call double @requires_iocontains_effect({ i8**, i64 }* %t10, i8* %s11)
  %t13 = fcmp one double %t12, 0.0
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t15 = load i1, i1* %l1
  %t16 = load double, double* %l2
  br i1 %t13, label %then4, label %merge5
then4:
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s18 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.18, i32 0, i32 0
  %t19 = call { i8**, i64 }* @append_string({ i8**, i64 }* %t17, i8* %s18)
  store { i8**, i64 }* %t19, { i8**, i64 }** %l0
  br label %merge5
merge5:
  %t20 = phi { i8**, i64 }* [ %t19, %then4 ], [ %t14, %entry ]
  store { i8**, i64 }* %t20, { i8**, i64 }** %l0
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t21
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
  %t11 = phi { %DecoratorInfo*, i64 }* [ %t6, %entry ], [ %t10, %loop.latch2 ]
  store { %DecoratorInfo*, i64 }* %t11, { %DecoratorInfo*, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  store double 0.0, double* %l2
  %t9 = load double, double* %l2
  store double 0.0, double* %l3
  br label %loop.latch2
loop.latch2:
  %t10 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t12 = load { %DecoratorInfo*, i64 }*, { %DecoratorInfo*, i64 }** %l0
  ret { %DecoratorInfo*, i64 }* %t12
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
  %t11 = phi { %DecoratorArgumentInfo*, i64 }* [ %t6, %entry ], [ %t10, %loop.latch2 ]
  store { %DecoratorArgumentInfo*, i64 }* %t11, { %DecoratorArgumentInfo*, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  store double 0.0, double* %l2
  %t9 = load double, double* %l2
  store double 0.0, double* %l3
  br label %loop.latch2
loop.latch2:
  %t10 = load { %DecoratorArgumentInfo*, i64 }*, { %DecoratorArgumentInfo*, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t12 = load { %DecoratorArgumentInfo*, i64 }*, { %DecoratorArgumentInfo*, i64 }** %l0
  ret { %DecoratorArgumentInfo*, i64 }* %t12
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
  %l2 = alloca double
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
  store double 0.0, double* %l2
  %t8 = load double, double* %l2
  %t9 = call i1 @is_whitespace_char(i8* null)
  %t10 = load double, double* %l0
  %t11 = load double, double* %l1
  %t12 = load double, double* %l2
  br i1 %t9, label %then6, label %merge7
then6:
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  br label %loop.header0
afterloop3:
  %t13 = load double, double* %l0
  %t14 = load double, double* %l1
  br label %loop.header8
loop.header8:
  br label %loop.body9
loop.body9:
  %t15 = load double, double* %l1
  %t16 = load double, double* %l0
  %t17 = fcmp ole double %t15, %t16
  %t18 = load double, double* %l0
  %t19 = load double, double* %l1
  br i1 %t17, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  store double 0.0, double* %l3
  %t20 = load double, double* %l3
  %t21 = call i1 @is_whitespace_char(i8* null)
  %t22 = load double, double* %l0
  %t23 = load double, double* %l1
  %t24 = load double, double* %l3
  br i1 %t21, label %then14, label %merge15
then14:
  %t25 = load double, double* %l1
  br label %loop.latch10
merge15:
  br label %afterloop11
loop.latch10:
  br label %loop.header8
afterloop11:
  %t26 = load double, double* %l0
  %t27 = load double, double* %l1
  %t28 = call i8* @slice_text(i8* %value, double %t26, double %t27)
  ret i8* %t28
}

define i1 @looks_like_quoted_string(i8* %text) {
entry:
  ret i1 1
}

define i1 @looks_like_number(i8* %text) {
entry:
  %l0 = alloca i1
  %l1 = alloca double
  %l2 = alloca double
  store i1 0, i1* %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load i1, i1* %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  store double 0.0, double* %l2
  %t4 = load double, double* %l2
  %s5 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.5, i32 0, i32 0
  %t6 = load double, double* %l2
  %t7 = call double @is_decimal_digit(double %t6)
  %t8 = fcmp one double %t7, 0.0
  %t9 = load i1, i1* %l0
  %t10 = load double, double* %l1
  %t11 = load double, double* %l2
  br i1 %t8, label %then4, label %merge5
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
  %t11 = phi { i8**, i64 }* [ %t6, %entry ], [ %t10, %loop.latch2 ]
  store { i8**, i64 }* %t11, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.latch2
loop.latch2:
  %t10 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t12 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t12
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
