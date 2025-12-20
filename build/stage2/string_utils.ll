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
declare i8* @sailfin_runtime_number_to_string(double)
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

define i8* @char_at(i8* %value, double %index) {
block.entry:
  %t0 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = call i8* @malloc(i64 1)
  %t3 = bitcast i8* %t2 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t3
  call void @sailfin_runtime_mark_persistent(i8* %t2)
  ret i8* %t2
merge1:
  %t4 = sitofp i64 0 to double
  %t5 = fcmp olt double %index, %t4
  br i1 %t5, label %then2, label %merge3
then2:
  %t6 = call i8* @malloc(i64 1)
  %t7 = bitcast i8* %t6 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t7
  call void @sailfin_runtime_mark_persistent(i8* %t6)
  ret i8* %t6
merge3:
  %t8 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t9 = sitofp i64 %t8 to double
  %t10 = fcmp oge double %index, %t9
  br i1 %t10, label %then4, label %merge5
then4:
  %t11 = call i8* @malloc(i64 1)
  %t12 = bitcast i8* %t11 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t12
  call void @sailfin_runtime_mark_persistent(i8* %t11)
  ret i8* %t11
merge5:
  %t13 = sitofp i64 1 to double
  %t14 = fadd double %index, %t13
  %t15 = call double @llvm.round.f64(double %index)
  %t16 = fptosi double %t15 to i64
  %t17 = call double @llvm.round.f64(double %t14)
  %t18 = fptosi double %t17 to i64
  %t19 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t16, i64 %t18)
  call void @sailfin_runtime_mark_persistent(i8* %t19)
  ret i8* %t19
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
  %l2 = alloca i8*
  %l3 = alloca i8*
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
  %t5 = call i8* @malloc(i64 1)
  %t6 = bitcast i8* %t5 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t6
  store i8* %t5, i8** %l0
  %t7 = sitofp i64 0 to double
  store double %t7, double* %l1
  %t8 = load i8*, i8** %l0
  %t9 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t33 = phi i8* [ %t8, %merge1 ], [ %t31, %loop.latch4 ]
  %t34 = phi double [ %t9, %merge1 ], [ %t32, %loop.latch4 ]
  store i8* %t33, i8** %l0
  store double %t34, double* %l1
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
  %t17 = call i8* @char_at(i8* %name, double %t16)
  store i8* %t17, i8** %l2
  %t18 = load i8*, i8** %l2
  %t19 = call i1 @is_symbol_char(i8* %t18)
  %t20 = load i8*, i8** %l0
  %t21 = load double, double* %l1
  %t22 = load i8*, i8** %l2
  br i1 %t19, label %then8, label %merge9
then8:
  %t23 = load i8*, i8** %l0
  %t24 = load i8*, i8** %l2
  %t25 = call i8* @sailfin_runtime_string_concat(i8* %t23, i8* %t24)
  store i8* %t25, i8** %l0
  %t26 = load i8*, i8** %l0
  br label %merge9
merge9:
  %t27 = phi i8* [ %t26, %then8 ], [ %t20, %merge7 ]
  store i8* %t27, i8** %l0
  %t28 = load double, double* %l1
  %t29 = sitofp i64 1 to double
  %t30 = fadd double %t28, %t29
  store double %t30, double* %l1
  br label %loop.latch4
loop.latch4:
  %t31 = load i8*, i8** %l0
  %t32 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t35 = load i8*, i8** %l0
  %t36 = load double, double* %l1
  %t37 = load i8*, i8** %l0
  %t38 = call i64 @sailfin_runtime_string_length(i8* %t37)
  %t39 = icmp eq i64 %t38, 0
  %t40 = load i8*, i8** %l0
  %t41 = load double, double* %l1
  br i1 %t39, label %then10, label %merge11
then10:
  %t42 = add i64 0, 2
  %t43 = call i8* @malloc(i64 %t42)
  store i8 95, i8* %t43
  %t44 = getelementptr i8, i8* %t43, i64 1
  store i8 0, i8* %t44
  call void @sailfin_runtime_mark_persistent(i8* %t43)
  call void @sailfin_runtime_mark_persistent(i8* %t43)
  ret i8* %t43
merge11:
  %t45 = load i8*, i8** %l0
  %t46 = sitofp i64 0 to double
  %t47 = call i8* @char_at(i8* %t45, double %t46)
  store i8* %t47, i8** %l3
  %t48 = load i8*, i8** %l3
  %t49 = call double @char_code(i8* %t48)
  store double %t49, double* %l4
  %t50 = add i64 0, 2
  %t51 = call i8* @malloc(i64 %t50)
  store i8 48, i8* %t51
  %t52 = getelementptr i8, i8* %t51, i64 1
  store i8 0, i8* %t52
  call void @sailfin_runtime_mark_persistent(i8* %t51)
  %t53 = call double @char_code(i8* %t51)
  store double %t53, double* %l5
  %t54 = add i64 0, 2
  %t55 = call i8* @malloc(i64 %t54)
  store i8 57, i8* %t55
  %t56 = getelementptr i8, i8* %t55, i64 1
  store i8 0, i8* %t56
  call void @sailfin_runtime_mark_persistent(i8* %t55)
  %t57 = call double @char_code(i8* %t55)
  store double %t57, double* %l6
  %t59 = load double, double* %l4
  %t60 = load double, double* %l5
  %t61 = fcmp oge double %t59, %t60
  br label %logical_and_entry_58

logical_and_entry_58:
  br i1 %t61, label %logical_and_right_58, label %logical_and_merge_58

logical_and_right_58:
  %t62 = load double, double* %l4
  %t63 = load double, double* %l6
  %t64 = fcmp ole double %t62, %t63
  br label %logical_and_right_end_58

logical_and_right_end_58:
  br label %logical_and_merge_58

logical_and_merge_58:
  %t65 = phi i1 [ false, %logical_and_entry_58 ], [ %t64, %logical_and_right_end_58 ]
  %t66 = load i8*, i8** %l0
  %t67 = load double, double* %l1
  %t68 = load i8*, i8** %l3
  %t69 = load double, double* %l4
  %t70 = load double, double* %l5
  %t71 = load double, double* %l6
  br i1 %t65, label %then12, label %merge13
then12:
  %t72 = load i8*, i8** %l0
  %t73 = add i64 0, 2
  %t74 = call i8* @malloc(i64 %t73)
  store i8 95, i8* %t74
  %t75 = getelementptr i8, i8* %t74, i64 1
  store i8 0, i8* %t75
  call void @sailfin_runtime_mark_persistent(i8* %t74)
  %t76 = call i8* @sailfin_runtime_string_concat(i8* %t74, i8* %t72)
  store i8* %t76, i8** %l0
  %t77 = load i8*, i8** %l0
  br label %merge13
merge13:
  %t78 = phi i8* [ %t77, %then12 ], [ %t66, %logical_and_merge_58 ]
  store i8* %t78, i8** %l0
  %t79 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t79)
  ret i8* %t79
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
