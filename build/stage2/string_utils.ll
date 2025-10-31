; ModuleID = 'sailfin'
source_filename = "sailfin"

%EnumField = type { i8*, i8* }
%EnumVariantDefinition = type { i8*, { i8**, i64 }* }
%EnumType = type { i8*, { %EnumVariantDefinition**, i64 }* }
%EnumInstance = type { %EnumType, i8*, { %EnumField**, i64 }* }
%StructField = type { i8*, i8* }
%TypeDescriptor = type { i8*, i8*, { %TypeDescriptor**, i64 }* }

declare void @sailfin_runtime_bounds_check(i64, i64)
declare i8* @sailfin_runtime_substring(i8*, i64, i64)
declare i64 @sailfin_runtime_string_length(i8*)
declare i8* @sailfin_runtime_string_concat(i8*, i8*)
declare double @char_code(i8*)
declare i8* @sailfin_runtime_get_field(i8*, i8*)

declare noalias i8* @malloc(i64)

@runtime = external global i8**

@.str.len0.h177573 = private unnamed_addr constant [1 x i8] c"\00"

define i8* @char_at(i8* %value, double %index) {
block.entry:
  %t0 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  %s2 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  ret i8* %s2
merge1:
  %t3 = sitofp i64 0 to double
  %t4 = fcmp olt double %index, %t3
  br i1 %t4, label %then2, label %merge3
then2:
  %s5 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  ret i8* %s5
merge3:
  %t6 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t7 = sitofp i64 %t6 to double
  %t8 = fcmp oge double %index, %t7
  br i1 %t8, label %then4, label %merge5
then4:
  %s9 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  ret i8* %s9
merge5:
  %t10 = sitofp i64 1 to double
  %t11 = fadd double %index, %t10
  %t12 = call i8* @sailfin_runtime_substring(i8* %value, double %index, double %t11)
  ret i8* %t12
}

define i1 @is_symbol_char(i8* %ch) {
block.entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca double
  %t0 = call i64 @sailfin_runtime_string_length(i8* %ch)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  ret i1 0
merge1:
  %t2 = load i8, i8* %ch
  %t3 = icmp eq i8 %t2, 95
  br i1 %t3, label %then2, label %merge3
then2:
  ret i1 1
merge3:
  %t4 = call double @char_code(i8* %ch)
  store double %t4, double* %l0
  %t5 = alloca [2 x i8], align 1
  %t6 = getelementptr [2 x i8], [2 x i8]* %t5, i32 0, i32 0
  store i8 97, i8* %t6
  %t7 = getelementptr [2 x i8], [2 x i8]* %t5, i32 0, i32 1
  store i8 0, i8* %t7
  %t8 = getelementptr [2 x i8], [2 x i8]* %t5, i32 0, i32 0
  %t9 = call double @char_code(i8* %t8)
  store double %t9, double* %l1
  %t10 = alloca [2 x i8], align 1
  %t11 = getelementptr [2 x i8], [2 x i8]* %t10, i32 0, i32 0
  store i8 122, i8* %t11
  %t12 = getelementptr [2 x i8], [2 x i8]* %t10, i32 0, i32 1
  store i8 0, i8* %t12
  %t13 = getelementptr [2 x i8], [2 x i8]* %t10, i32 0, i32 0
  %t14 = call double @char_code(i8* %t13)
  store double %t14, double* %l2
  %t16 = load double, double* %l0
  %t17 = load double, double* %l1
  %t18 = fcmp oge double %t16, %t17
  br label %logical_and_entry_15

logical_and_entry_15:
  br i1 %t18, label %logical_and_right_15, label %logical_and_merge_15

logical_and_right_15:
  %t19 = load double, double* %l0
  %t20 = load double, double* %l2
  %t21 = fcmp ole double %t19, %t20
  br label %logical_and_right_end_15

logical_and_right_end_15:
  br label %logical_and_merge_15

logical_and_merge_15:
  %t22 = phi i1 [ false, %logical_and_entry_15 ], [ %t21, %logical_and_right_end_15 ]
  %t23 = load double, double* %l0
  %t24 = load double, double* %l1
  %t25 = load double, double* %l2
  br i1 %t22, label %then4, label %merge5
then4:
  ret i1 1
merge5:
  %t26 = alloca [2 x i8], align 1
  %t27 = getelementptr [2 x i8], [2 x i8]* %t26, i32 0, i32 0
  store i8 65, i8* %t27
  %t28 = getelementptr [2 x i8], [2 x i8]* %t26, i32 0, i32 1
  store i8 0, i8* %t28
  %t29 = getelementptr [2 x i8], [2 x i8]* %t26, i32 0, i32 0
  %t30 = call double @char_code(i8* %t29)
  store double %t30, double* %l3
  %t31 = alloca [2 x i8], align 1
  %t32 = getelementptr [2 x i8], [2 x i8]* %t31, i32 0, i32 0
  store i8 90, i8* %t32
  %t33 = getelementptr [2 x i8], [2 x i8]* %t31, i32 0, i32 1
  store i8 0, i8* %t33
  %t34 = getelementptr [2 x i8], [2 x i8]* %t31, i32 0, i32 0
  %t35 = call double @char_code(i8* %t34)
  store double %t35, double* %l4
  %t37 = load double, double* %l0
  %t38 = load double, double* %l3
  %t39 = fcmp oge double %t37, %t38
  br label %logical_and_entry_36

logical_and_entry_36:
  br i1 %t39, label %logical_and_right_36, label %logical_and_merge_36

logical_and_right_36:
  %t40 = load double, double* %l0
  %t41 = load double, double* %l4
  %t42 = fcmp ole double %t40, %t41
  br label %logical_and_right_end_36

logical_and_right_end_36:
  br label %logical_and_merge_36

logical_and_merge_36:
  %t43 = phi i1 [ false, %logical_and_entry_36 ], [ %t42, %logical_and_right_end_36 ]
  %t44 = load double, double* %l0
  %t45 = load double, double* %l1
  %t46 = load double, double* %l2
  %t47 = load double, double* %l3
  %t48 = load double, double* %l4
  br i1 %t43, label %then6, label %merge7
then6:
  ret i1 1
merge7:
  %t49 = alloca [2 x i8], align 1
  %t50 = getelementptr [2 x i8], [2 x i8]* %t49, i32 0, i32 0
  store i8 48, i8* %t50
  %t51 = getelementptr [2 x i8], [2 x i8]* %t49, i32 0, i32 1
  store i8 0, i8* %t51
  %t52 = getelementptr [2 x i8], [2 x i8]* %t49, i32 0, i32 0
  %t53 = call double @char_code(i8* %t52)
  store double %t53, double* %l5
  %t54 = alloca [2 x i8], align 1
  %t55 = getelementptr [2 x i8], [2 x i8]* %t54, i32 0, i32 0
  store i8 57, i8* %t55
  %t56 = getelementptr [2 x i8], [2 x i8]* %t54, i32 0, i32 1
  store i8 0, i8* %t56
  %t57 = getelementptr [2 x i8], [2 x i8]* %t54, i32 0, i32 0
  %t58 = call double @char_code(i8* %t57)
  store double %t58, double* %l6
  %t60 = load double, double* %l0
  %t61 = load double, double* %l5
  %t62 = fcmp oge double %t60, %t61
  br label %logical_and_entry_59

logical_and_entry_59:
  br i1 %t62, label %logical_and_right_59, label %logical_and_merge_59

logical_and_right_59:
  %t63 = load double, double* %l0
  %t64 = load double, double* %l6
  %t65 = fcmp ole double %t63, %t64
  br label %logical_and_right_end_59

logical_and_right_end_59:
  br label %logical_and_merge_59

logical_and_merge_59:
  %t66 = phi i1 [ false, %logical_and_entry_59 ], [ %t65, %logical_and_right_end_59 ]
  %t67 = load double, double* %l0
  %t68 = load double, double* %l1
  %t69 = load double, double* %l2
  %t70 = load double, double* %l3
  %t71 = load double, double* %l4
  %t72 = load double, double* %l5
  %t73 = load double, double* %l6
  br i1 %t66, label %then8, label %merge9
then8:
  ret i1 1
merge9:
  ret i1 0
}

define i8* @sanitize_symbol(i8* %name) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8
  %l3 = alloca i8
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca double
  %t0 = call i64 @sailfin_runtime_string_length(i8* %name)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = alloca [2 x i8], align 1
  %t3 = getelementptr [2 x i8], [2 x i8]* %t2, i32 0, i32 0
  store i8 95, i8* %t3
  %t4 = getelementptr [2 x i8], [2 x i8]* %t2, i32 0, i32 1
  store i8 0, i8* %t4
  %t5 = getelementptr [2 x i8], [2 x i8]* %t2, i32 0, i32 0
  ret i8* %t5
merge1:
  %s6 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s6, i8** %l0
  %t7 = sitofp i64 0 to double
  store double %t7, double* %l1
  %t8 = load i8*, i8** %l0
  %t9 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t43 = phi i8* [ %t8, %merge1 ], [ %t41, %loop.latch4 ]
  %t44 = phi double [ %t9, %merge1 ], [ %t42, %loop.latch4 ]
  store i8* %t43, i8** %l0
  store double %t44, double* %l1
  br label %loop.body3
loop.body3:
  %t10 = load double, double* %l1
  %t11 = call i64 @sailfin_runtime_string_length(i8* %name)
  %t12 = sitofp i64 %t11 to double
  %t13 = fcmp oge double %t10, %t12
  %t14 = load i8*, i8** %l0
  %t15 = load double, double* %l1
  br i1 %t13, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t16 = load double, double* %l1
  %t17 = fptosi double %t16 to i64
  %t18 = getelementptr i8, i8* %name, i64 %t17
  %t19 = load i8, i8* %t18
  store i8 %t19, i8* %l2
  %t20 = load i8, i8* %l2
  %t21 = alloca [2 x i8], align 1
  %t22 = getelementptr [2 x i8], [2 x i8]* %t21, i32 0, i32 0
  store i8 %t20, i8* %t22
  %t23 = getelementptr [2 x i8], [2 x i8]* %t21, i32 0, i32 1
  store i8 0, i8* %t23
  %t24 = getelementptr [2 x i8], [2 x i8]* %t21, i32 0, i32 0
  %t25 = call i1 @is_symbol_char(i8* %t24)
  %t26 = load i8*, i8** %l0
  %t27 = load double, double* %l1
  %t28 = load i8, i8* %l2
  br i1 %t25, label %then8, label %merge9
then8:
  %t29 = load i8*, i8** %l0
  %t30 = load i8, i8* %l2
  %t31 = alloca [2 x i8], align 1
  %t32 = getelementptr [2 x i8], [2 x i8]* %t31, i32 0, i32 0
  store i8 %t30, i8* %t32
  %t33 = getelementptr [2 x i8], [2 x i8]* %t31, i32 0, i32 1
  store i8 0, i8* %t33
  %t34 = getelementptr [2 x i8], [2 x i8]* %t31, i32 0, i32 0
  %t35 = call i8* @sailfin_runtime_string_concat(i8* %t29, i8* %t34)
  store i8* %t35, i8** %l0
  %t36 = load i8*, i8** %l0
  br label %merge9
merge9:
  %t37 = phi i8* [ %t36, %then8 ], [ %t26, %merge7 ]
  store i8* %t37, i8** %l0
  %t38 = load double, double* %l1
  %t39 = sitofp i64 1 to double
  %t40 = fadd double %t38, %t39
  store double %t40, double* %l1
  br label %loop.latch4
loop.latch4:
  %t41 = load i8*, i8** %l0
  %t42 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t45 = load i8*, i8** %l0
  %t46 = load double, double* %l1
  %t47 = load i8*, i8** %l0
  %t48 = call i64 @sailfin_runtime_string_length(i8* %t47)
  %t49 = icmp eq i64 %t48, 0
  %t50 = load i8*, i8** %l0
  %t51 = load double, double* %l1
  br i1 %t49, label %then10, label %merge11
then10:
  %t52 = alloca [2 x i8], align 1
  %t53 = getelementptr [2 x i8], [2 x i8]* %t52, i32 0, i32 0
  store i8 95, i8* %t53
  %t54 = getelementptr [2 x i8], [2 x i8]* %t52, i32 0, i32 1
  store i8 0, i8* %t54
  %t55 = getelementptr [2 x i8], [2 x i8]* %t52, i32 0, i32 0
  ret i8* %t55
merge11:
  %t56 = load i8*, i8** %l0
  %t57 = getelementptr i8, i8* %t56, i64 0
  %t58 = load i8, i8* %t57
  store i8 %t58, i8* %l3
  %t59 = load i8, i8* %l3
  %t60 = alloca [2 x i8], align 1
  %t61 = getelementptr [2 x i8], [2 x i8]* %t60, i32 0, i32 0
  store i8 %t59, i8* %t61
  %t62 = getelementptr [2 x i8], [2 x i8]* %t60, i32 0, i32 1
  store i8 0, i8* %t62
  %t63 = getelementptr [2 x i8], [2 x i8]* %t60, i32 0, i32 0
  %t64 = call double @char_code(i8* %t63)
  store double %t64, double* %l4
  %t65 = alloca [2 x i8], align 1
  %t66 = getelementptr [2 x i8], [2 x i8]* %t65, i32 0, i32 0
  store i8 48, i8* %t66
  %t67 = getelementptr [2 x i8], [2 x i8]* %t65, i32 0, i32 1
  store i8 0, i8* %t67
  %t68 = getelementptr [2 x i8], [2 x i8]* %t65, i32 0, i32 0
  %t69 = call double @char_code(i8* %t68)
  store double %t69, double* %l5
  %t70 = alloca [2 x i8], align 1
  %t71 = getelementptr [2 x i8], [2 x i8]* %t70, i32 0, i32 0
  store i8 57, i8* %t71
  %t72 = getelementptr [2 x i8], [2 x i8]* %t70, i32 0, i32 1
  store i8 0, i8* %t72
  %t73 = getelementptr [2 x i8], [2 x i8]* %t70, i32 0, i32 0
  %t74 = call double @char_code(i8* %t73)
  store double %t74, double* %l6
  %t76 = load double, double* %l4
  %t77 = load double, double* %l5
  %t78 = fcmp oge double %t76, %t77
  br label %logical_and_entry_75

logical_and_entry_75:
  br i1 %t78, label %logical_and_right_75, label %logical_and_merge_75

logical_and_right_75:
  %t79 = load double, double* %l4
  %t80 = load double, double* %l6
  %t81 = fcmp ole double %t79, %t80
  br label %logical_and_right_end_75

logical_and_right_end_75:
  br label %logical_and_merge_75

logical_and_merge_75:
  %t82 = phi i1 [ false, %logical_and_entry_75 ], [ %t81, %logical_and_right_end_75 ]
  %t83 = load i8*, i8** %l0
  %t84 = load double, double* %l1
  %t85 = load i8, i8* %l3
  %t86 = load double, double* %l4
  %t87 = load double, double* %l5
  %t88 = load double, double* %l6
  br i1 %t82, label %then12, label %merge13
then12:
  %t89 = load i8*, i8** %l0
  %t90 = alloca [2 x i8], align 1
  %t91 = getelementptr [2 x i8], [2 x i8]* %t90, i32 0, i32 0
  store i8 95, i8* %t91
  %t92 = getelementptr [2 x i8], [2 x i8]* %t90, i32 0, i32 1
  store i8 0, i8* %t92
  %t93 = getelementptr [2 x i8], [2 x i8]* %t90, i32 0, i32 0
  %t94 = call i8* @sailfin_runtime_string_concat(i8* %t93, i8* %t89)
  store i8* %t94, i8** %l0
  %t95 = load i8*, i8** %l0
  br label %merge13
merge13:
  %t96 = phi i8* [ %t95, %then12 ], [ %t83, %logical_and_merge_75 ]
  store i8* %t96, i8** %l0
  %t97 = load i8*, i8** %l0
  ret i8* %t97
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
