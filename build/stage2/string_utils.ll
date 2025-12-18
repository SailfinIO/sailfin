; ModuleID = 'sailfin'
source_filename = "sailfin"

%EnumField = type { i8*, i8* }
%EnumVariantDefinition = type { i8*, { i8**, i64 }* }
%EnumType = type { i8*, { %EnumVariantDefinition*, i64 }* }
%EnumInstance = type { %EnumType, i8*, { %EnumField*, i64 }* }
%StructField = type { i8*, i8* }
%TypeDescriptor = type { i8*, i8*, { %TypeDescriptor*, i64 }* }

declare void @sailfin_runtime_bounds_check(i64, i64)
declare i8* @sailfin_runtime_substring(i8*, i64, i64)
declare i64 @sailfin_runtime_string_length(i8*)
declare i8* @sailfin_runtime_string_concat(i8*, i8*)
declare double @char_code(i8*)
declare i8* @sailfin_runtime_get_field(i8*, i8*)
declare void @sailfin_runtime_mark_persistent(i8*)

declare i8* @capability_grant({ i8**, i64 }*)
declare i8* @fs_bridge(i8*)
declare i8* @http_bridge(i8*)
declare i8* @model_bridge(i8*)
declare void @sleep(double)
declare i8* @channel(double)
declare { i8**, i64 }* @parallel({ i8**, i64 }*)
declare void @spawn(i8*, i8*)
declare i8* @logExecution(i8*)
declare { i8**, i64 }* @array_map({ i8**, i64 }*, i8*)
declare { i8**, i64 }* @array_filter({ i8**, i64 }*, i8*)
declare i8* @array_reduce({ i8**, i64 }*, i8*, i8*)
declare %EnumType @enum_type(i8*)
declare %EnumField @enum_field(i8*, i8*)
declare %EnumType @enum_define_variant(%EnumType, i8*, { i8**, i64 }*)
declare %EnumField* @enum_lookup_field({ %EnumField*, i64 }*, i8*)
declare %EnumVariantDefinition* @enum_find_variant(%EnumType, i8*)
declare { %EnumField*, i64 }* @enum_normalize_fields(%EnumVariantDefinition*, { %EnumField*, i64 }*)
declare %EnumInstance @enum_instantiate(%EnumType, i8*, { %EnumField*, i64 }*)
declare i8* @enum_get_field(%EnumInstance, i8*)
declare %StructField @struct_field(i8*, i8*)
declare i8* @struct_repr(i8*, { %StructField*, i64 }*)
declare i8* @to_debug_string(i8*)
declare i8* @format_interpolated({ i8**, i64 }*, { i8**, i64 }*)
declare %TypeDescriptor @type_descriptor(i8*, i8*, { %TypeDescriptor*, i64 }*)
declare %TypeDescriptor @type_descriptor_primitive(i8*)
declare %TypeDescriptor @type_descriptor_union({ %TypeDescriptor*, i64 }*)
declare %TypeDescriptor @type_descriptor_intersection({ %TypeDescriptor*, i64 }*)
declare %TypeDescriptor @type_descriptor_array(%TypeDescriptor)
declare %TypeDescriptor @type_descriptor_function()
declare %TypeDescriptor @type_descriptor_named(i8*)
declare %TypeDescriptor @type_descriptor_unknown()
declare i8* @descriptor_trim(i8*)
declare i1 @string_starts_with(i8*, i8*)
declare i1 @string_ends_with(i8*, i8*)
declare double @descriptor_find_top_level(i8*, i8*)
declare i8* @descriptor_strip_outer_parens(i8*)
declare { i8**, i64 }* @split_descriptor(i8*, i8*)
declare { %TypeDescriptor*, i64 }* @parse_descriptor_list({ i8**, i64 }*)
declare %TypeDescriptor @parse_type_descriptor(i8*)
declare i1 @check_type_primitive(i8*, i8*)
declare i1 @check_type_descriptor(i8*, %TypeDescriptor)
declare i1 @check_type(i8*, i8*)
declare void @serve(i8*, i8*)
declare double @clamp(double, double, double)
declare i8* @substring(i8*, double, double)
declare double @find_char(i8*, i8*, double)
declare void @match_exhaustive_failed(i8*)
declare double @grapheme_count(i8*)
declare i8* @grapheme_at(i8*, double)

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
  call void @sailfin_runtime_mark_persistent(i8* %s2)
  ret i8* %s2
merge1:
  %t3 = sitofp i64 0 to double
  %t4 = fcmp olt double %index, %t3
  br i1 %t4, label %then2, label %merge3
then2:
  %s5 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %s5)
  ret i8* %s5
merge3:
  %t6 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t7 = sitofp i64 %t6 to double
  %t8 = fcmp oge double %index, %t7
  br i1 %t8, label %then4, label %merge5
then4:
  %s9 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %s9)
  ret i8* %s9
merge5:
  %t10 = sitofp i64 1 to double
  %t11 = fadd double %index, %t10
  %t12 = call double @llvm.round.f64(double %index)
  %t13 = fptosi double %t12 to i64
  %t14 = call double @llvm.round.f64(double %t11)
  %t15 = fptosi double %t14 to i64
  %t16 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t13, i64 %t15)
  call void @sailfin_runtime_mark_persistent(i8* %t16)
  ret i8* %t16
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
  %t5 = add i64 0, 2
  %t6 = call i8* @malloc(i64 %t5)
  store i8 97, i8* %t6
  %t7 = getelementptr i8, i8* %t6, i64 1
  store i8 0, i8* %t7
  call void @sailfin_runtime_mark_persistent(i8* %t6)
  %t8 = call double @char_code(i8* %t6)
  store double %t8, double* %l1
  %t9 = add i64 0, 2
  %t10 = call i8* @malloc(i64 %t9)
  store i8 122, i8* %t10
  %t11 = getelementptr i8, i8* %t10, i64 1
  store i8 0, i8* %t11
  call void @sailfin_runtime_mark_persistent(i8* %t10)
  %t12 = call double @char_code(i8* %t10)
  store double %t12, double* %l2
  %t14 = load double, double* %l0
  %t15 = load double, double* %l1
  %t16 = fcmp oge double %t14, %t15
  br label %logical_and_entry_13

logical_and_entry_13:
  br i1 %t16, label %logical_and_right_13, label %logical_and_merge_13

logical_and_right_13:
  %t17 = load double, double* %l0
  %t18 = load double, double* %l2
  %t19 = fcmp ole double %t17, %t18
  br label %logical_and_right_end_13

logical_and_right_end_13:
  br label %logical_and_merge_13

logical_and_merge_13:
  %t20 = phi i1 [ false, %logical_and_entry_13 ], [ %t19, %logical_and_right_end_13 ]
  %t21 = load double, double* %l0
  %t22 = load double, double* %l1
  %t23 = load double, double* %l2
  br i1 %t20, label %then4, label %merge5
then4:
  ret i1 1
merge5:
  %t24 = add i64 0, 2
  %t25 = call i8* @malloc(i64 %t24)
  store i8 65, i8* %t25
  %t26 = getelementptr i8, i8* %t25, i64 1
  store i8 0, i8* %t26
  call void @sailfin_runtime_mark_persistent(i8* %t25)
  %t27 = call double @char_code(i8* %t25)
  store double %t27, double* %l3
  %t28 = add i64 0, 2
  %t29 = call i8* @malloc(i64 %t28)
  store i8 90, i8* %t29
  %t30 = getelementptr i8, i8* %t29, i64 1
  store i8 0, i8* %t30
  call void @sailfin_runtime_mark_persistent(i8* %t29)
  %t31 = call double @char_code(i8* %t29)
  store double %t31, double* %l4
  %t33 = load double, double* %l0
  %t34 = load double, double* %l3
  %t35 = fcmp oge double %t33, %t34
  br label %logical_and_entry_32

logical_and_entry_32:
  br i1 %t35, label %logical_and_right_32, label %logical_and_merge_32

logical_and_right_32:
  %t36 = load double, double* %l0
  %t37 = load double, double* %l4
  %t38 = fcmp ole double %t36, %t37
  br label %logical_and_right_end_32

logical_and_right_end_32:
  br label %logical_and_merge_32

logical_and_merge_32:
  %t39 = phi i1 [ false, %logical_and_entry_32 ], [ %t38, %logical_and_right_end_32 ]
  %t40 = load double, double* %l0
  %t41 = load double, double* %l1
  %t42 = load double, double* %l2
  %t43 = load double, double* %l3
  %t44 = load double, double* %l4
  br i1 %t39, label %then6, label %merge7
then6:
  ret i1 1
merge7:
  %t45 = add i64 0, 2
  %t46 = call i8* @malloc(i64 %t45)
  store i8 48, i8* %t46
  %t47 = getelementptr i8, i8* %t46, i64 1
  store i8 0, i8* %t47
  call void @sailfin_runtime_mark_persistent(i8* %t46)
  %t48 = call double @char_code(i8* %t46)
  store double %t48, double* %l5
  %t49 = add i64 0, 2
  %t50 = call i8* @malloc(i64 %t49)
  store i8 57, i8* %t50
  %t51 = getelementptr i8, i8* %t50, i64 1
  store i8 0, i8* %t51
  call void @sailfin_runtime_mark_persistent(i8* %t50)
  %t52 = call double @char_code(i8* %t50)
  store double %t52, double* %l6
  %t54 = load double, double* %l0
  %t55 = load double, double* %l5
  %t56 = fcmp oge double %t54, %t55
  br label %logical_and_entry_53

logical_and_entry_53:
  br i1 %t56, label %logical_and_right_53, label %logical_and_merge_53

logical_and_right_53:
  %t57 = load double, double* %l0
  %t58 = load double, double* %l6
  %t59 = fcmp ole double %t57, %t58
  br label %logical_and_right_end_53

logical_and_right_end_53:
  br label %logical_and_merge_53

logical_and_merge_53:
  %t60 = phi i1 [ false, %logical_and_entry_53 ], [ %t59, %logical_and_right_end_53 ]
  %t61 = load double, double* %l0
  %t62 = load double, double* %l1
  %t63 = load double, double* %l2
  %t64 = load double, double* %l3
  %t65 = load double, double* %l4
  %t66 = load double, double* %l5
  %t67 = load double, double* %l6
  br i1 %t60, label %then8, label %merge9
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
  %t2 = add i64 0, 2
  %t3 = call i8* @malloc(i64 %t2)
  store i8 95, i8* %t3
  %t4 = getelementptr i8, i8* %t3, i64 1
  store i8 0, i8* %t4
  call void @sailfin_runtime_mark_persistent(i8* %t3)
  call void @sailfin_runtime_mark_persistent(i8* %t3)
  ret i8* %t3
merge1:
  %s5 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s5, i8** %l0
  %t6 = sitofp i64 0 to double
  store double %t6, double* %l1
  %t7 = load i8*, i8** %l0
  %t8 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t41 = phi i8* [ %t7, %merge1 ], [ %t39, %loop.latch4 ]
  %t42 = phi double [ %t8, %merge1 ], [ %t40, %loop.latch4 ]
  store i8* %t41, i8** %l0
  store double %t42, double* %l1
  br label %loop.body3
loop.body3:
  %t9 = load double, double* %l1
  %t10 = call i64 @sailfin_runtime_string_length(i8* %name)
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t9, %t11
  %t13 = load i8*, i8** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t15 = load double, double* %l1
  %t16 = call double @llvm.round.f64(double %t15)
  %t17 = fptosi double %t16 to i64
  %t18 = getelementptr i8, i8* %name, i64 %t17
  %t19 = load i8, i8* %t18
  store i8 %t19, i8* %l2
  %t20 = load i8, i8* %l2
  %t21 = add i64 0, 2
  %t22 = call i8* @malloc(i64 %t21)
  store i8 %t20, i8* %t22
  %t23 = getelementptr i8, i8* %t22, i64 1
  store i8 0, i8* %t23
  call void @sailfin_runtime_mark_persistent(i8* %t22)
  %t24 = call i1 @is_symbol_char(i8* %t22)
  %t25 = load i8*, i8** %l0
  %t26 = load double, double* %l1
  %t27 = load i8, i8* %l2
  br i1 %t24, label %then8, label %merge9
then8:
  %t28 = load i8*, i8** %l0
  %t29 = load i8, i8* %l2
  %t30 = add i64 0, 2
  %t31 = call i8* @malloc(i64 %t30)
  store i8 %t29, i8* %t31
  %t32 = getelementptr i8, i8* %t31, i64 1
  store i8 0, i8* %t32
  call void @sailfin_runtime_mark_persistent(i8* %t31)
  %t33 = call i8* @sailfin_runtime_string_concat(i8* %t28, i8* %t31)
  store i8* %t33, i8** %l0
  %t34 = load i8*, i8** %l0
  br label %merge9
merge9:
  %t35 = phi i8* [ %t34, %then8 ], [ %t25, %merge7 ]
  store i8* %t35, i8** %l0
  %t36 = load double, double* %l1
  %t37 = sitofp i64 1 to double
  %t38 = fadd double %t36, %t37
  store double %t38, double* %l1
  br label %loop.latch4
loop.latch4:
  %t39 = load i8*, i8** %l0
  %t40 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t43 = load i8*, i8** %l0
  %t44 = load double, double* %l1
  %t45 = load i8*, i8** %l0
  %t46 = call i64 @sailfin_runtime_string_length(i8* %t45)
  %t47 = icmp eq i64 %t46, 0
  %t48 = load i8*, i8** %l0
  %t49 = load double, double* %l1
  br i1 %t47, label %then10, label %merge11
then10:
  %t50 = add i64 0, 2
  %t51 = call i8* @malloc(i64 %t50)
  store i8 95, i8* %t51
  %t52 = getelementptr i8, i8* %t51, i64 1
  store i8 0, i8* %t52
  call void @sailfin_runtime_mark_persistent(i8* %t51)
  call void @sailfin_runtime_mark_persistent(i8* %t51)
  ret i8* %t51
merge11:
  %t53 = load i8*, i8** %l0
  %t54 = getelementptr i8, i8* %t53, i64 0
  %t55 = load i8, i8* %t54
  store i8 %t55, i8* %l3
  %t56 = load i8, i8* %l3
  %t57 = add i64 0, 2
  %t58 = call i8* @malloc(i64 %t57)
  store i8 %t56, i8* %t58
  %t59 = getelementptr i8, i8* %t58, i64 1
  store i8 0, i8* %t59
  call void @sailfin_runtime_mark_persistent(i8* %t58)
  %t60 = call double @char_code(i8* %t58)
  store double %t60, double* %l4
  %t61 = add i64 0, 2
  %t62 = call i8* @malloc(i64 %t61)
  store i8 48, i8* %t62
  %t63 = getelementptr i8, i8* %t62, i64 1
  store i8 0, i8* %t63
  call void @sailfin_runtime_mark_persistent(i8* %t62)
  %t64 = call double @char_code(i8* %t62)
  store double %t64, double* %l5
  %t65 = add i64 0, 2
  %t66 = call i8* @malloc(i64 %t65)
  store i8 57, i8* %t66
  %t67 = getelementptr i8, i8* %t66, i64 1
  store i8 0, i8* %t67
  call void @sailfin_runtime_mark_persistent(i8* %t66)
  %t68 = call double @char_code(i8* %t66)
  store double %t68, double* %l6
  %t70 = load double, double* %l4
  %t71 = load double, double* %l5
  %t72 = fcmp oge double %t70, %t71
  br label %logical_and_entry_69

logical_and_entry_69:
  br i1 %t72, label %logical_and_right_69, label %logical_and_merge_69

logical_and_right_69:
  %t73 = load double, double* %l4
  %t74 = load double, double* %l6
  %t75 = fcmp ole double %t73, %t74
  br label %logical_and_right_end_69

logical_and_right_end_69:
  br label %logical_and_merge_69

logical_and_merge_69:
  %t76 = phi i1 [ false, %logical_and_entry_69 ], [ %t75, %logical_and_right_end_69 ]
  %t77 = load i8*, i8** %l0
  %t78 = load double, double* %l1
  %t79 = load i8, i8* %l3
  %t80 = load double, double* %l4
  %t81 = load double, double* %l5
  %t82 = load double, double* %l6
  br i1 %t76, label %then12, label %merge13
then12:
  %t83 = load i8*, i8** %l0
  %t84 = add i64 0, 2
  %t85 = call i8* @malloc(i64 %t84)
  store i8 95, i8* %t85
  %t86 = getelementptr i8, i8* %t85, i64 1
  store i8 0, i8* %t86
  call void @sailfin_runtime_mark_persistent(i8* %t85)
  %t87 = call i8* @sailfin_runtime_string_concat(i8* %t85, i8* %t83)
  store i8* %t87, i8** %l0
  %t88 = load i8*, i8** %l0
  br label %merge13
merge13:
  %t89 = phi i8* [ %t88, %then12 ], [ %t77, %logical_and_merge_69 ]
  store i8* %t89, i8** %l0
  %t90 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t90)
  ret i8* %t90
}

define i1 @strings_equal(i8* %left, i8* %right) {
block.entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %l2 = alloca i8*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %left)
  %t1 = call i64 @sailfin_runtime_string_length(i8* %right)
  %t2 = icmp ne i64 %t0, %t1
  br i1 %t2, label %then0, label %merge1
then0:
  ret i1 0
merge1:
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l0
  %t4 = load double, double* %l0
  br label %loop.header2
loop.header2:
  %t26 = phi double [ %t4, %merge1 ], [ %t25, %loop.latch4 ]
  store double %t26, double* %l0
  br label %loop.body3
loop.body3:
  %t5 = load double, double* %l0
  %t6 = call i64 @sailfin_runtime_string_length(i8* %left)
  %t7 = sitofp i64 %t6 to double
  %t8 = fcmp oge double %t5, %t7
  %t9 = load double, double* %l0
  br i1 %t8, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t10 = load double, double* %l0
  %t11 = call i8* @char_at(i8* %left, double %t10)
  store i8* %t11, i8** %l1
  %t12 = load double, double* %l0
  %t13 = call i8* @char_at(i8* %right, double %t12)
  store i8* %t13, i8** %l2
  %t14 = load i8*, i8** %l1
  %t15 = call double @char_code(i8* %t14)
  %t16 = load i8*, i8** %l2
  %t17 = call double @char_code(i8* %t16)
  %t18 = fcmp une double %t15, %t17
  %t19 = load double, double* %l0
  %t20 = load i8*, i8** %l1
  %t21 = load i8*, i8** %l2
  br i1 %t18, label %then8, label %merge9
then8:
  ret i1 0
merge9:
  %t22 = load double, double* %l0
  %t23 = sitofp i64 1 to double
  %t24 = fadd double %t22, %t23
  store double %t24, double* %l0
  br label %loop.latch4
loop.latch4:
  %t25 = load double, double* %l0
  br label %loop.header2
afterloop5:
  %t27 = load double, double* %l0
  ret i1 1
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
