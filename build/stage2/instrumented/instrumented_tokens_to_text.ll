define i8* @tokens_to_text({ %Token*, i64 }* %tokens) {
block.entry:
  call void @stage2_debug_marker(i64 61000)
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i1
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = sitofp i64 8192 to double
  store double %t2, double* %l2
  %t3 = sitofp i64 512 to double
  store double %t3, double* %l3
  store i1 0, i1* %l4
  %t4 = load i8*, i8** %l0
  %t5 = load double, double* %l1
  %t6 = load double, double* %l2
  %t7 = load double, double* %l3
  %t8 = load i1, i1* %l4
  br label %loop.header0
loop.header0:
  %t60 = phi i1 [ %t8, %block.entry ], [ %t57, %loop.latch2 ]
  %t61 = phi i8* [ %t4, %block.entry ], [ %t58, %loop.latch2 ]
  %t62 = phi double [ %t5, %block.entry ], [ %t59, %loop.latch2 ]
  store i1 %t60, i1* %l4
  store i8* %t61, i8** %l0
  store double %t62, double* %l1
  br label %loop.body1
loop.body1:
  %t9 = load double, double* %l1
  %t10 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t11 = extractvalue { %Token*, i64 } %t10, 1
  %t12 = sitofp i64 %t11 to double
  %t13 = fcmp oge double %t9, %t12
  %t14 = load i8*, i8** %l0
  %t15 = load double, double* %l1
  %t16 = load double, double* %l2
  %t17 = load double, double* %l3
  %t18 = load i1, i1* %l4
  br i1 %t13, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t19 = load double, double* %l1
  %t20 = load double, double* %l3
  %t21 = fcmp oge double %t19, %t20
  %t22 = load i8*, i8** %l0
  %t23 = load double, double* %l1
  %t24 = load double, double* %l2
  %t25 = load double, double* %l3
  %t26 = load i1, i1* %l4
  br i1 %t21, label %then6, label %merge7
then6:
  call void @stage2_debug_marker(i64 61200)
  store i1 1, i1* %l4
  br label %afterloop3
merge7:
  %t27 = load i8*, i8** %l0
  %t28 = load double, double* %l1
  %t29 = call double @llvm.round.f64(double %t28)
  %t30 = fptosi double %t29 to i64
  %stage2_tokens_text_index = add i64 %t30, 61100
  call void @stage2_debug_marker(i64 %stage2_tokens_text_index)
  %t31 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t32 = extractvalue { %Token*, i64 } %t31, 0
  %t33 = extractvalue { %Token*, i64 } %t31, 1
  %t34 = icmp uge i64 %t30, %t33
  ; bounds check: %t34 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t30, i64 %t33)
  %t35 = getelementptr %Token, %Token* %t32, i64 %t30
  %t36 = load %Token, %Token* %t35
  %stage2_tokens_text_kind = extractvalue %Token %t36, 0
  %stage2_tokens_text_variant = extractvalue %TokenKind %stage2_tokens_text_kind, 0
  %stage2_tokens_text_variant_i64 = sext i32 %stage2_tokens_text_variant to i64
  %t37 = extractvalue %Token %t36, 1
  call void @stage2_debug_token(i64 %t30, i64 %stage2_tokens_text_variant_i64, i8* %t37)
  %t38 = call i8* @sailfin_runtime_string_concat(i8* %t27, i8* %t37)
  store i8* %t38, i8** %l0
  %t39 = load double, double* %l1
  %t40 = sitofp i64 1 to double
  %t41 = fadd double %t39, %t40
  store double %t41, double* %l1
  %t42 = load i8*, i8** %l0
  %t43 = call i64 @sailfin_runtime_string_length(i8* %t42)
  %t44 = load double, double* %l2
  %t45 = sitofp i64 %t43 to double
  %t46 = fcmp ogt double %t45, %t44
  %t47 = load i8*, i8** %l0
  %t48 = load double, double* %l1
  %t49 = load double, double* %l2
  %t50 = load double, double* %l3
  %t51 = load i1, i1* %l4
  br i1 %t46, label %then8, label %merge9
then8:
  call void @stage2_debug_marker(i64 61210)
  %t52 = load i8*, i8** %l0
  %t53 = load double, double* %l2
  %t54 = call double @llvm.round.f64(double %t53)
  %t55 = fptosi double %t54 to i64
  %t56 = call i8* @sailfin_runtime_substring(i8* %t52, i64 0, i64 %t55)
  store i8* %t56, i8** %l0
  store i1 1, i1* %l4
  br label %afterloop3
merge9:
  br label %loop.latch2
loop.latch2:
  %t57 = load i1, i1* %l4
  %t58 = load i8*, i8** %l0
  %t59 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t63 = load i1, i1* %l4
  %t64 = load i8*, i8** %l0
  %t65 = load double, double* %l1
  %t67 = load i1, i1* %l4
  br label %logical_and_entry_66

logical_and_entry_66:
  br i1 %t67, label %logical_and_right_66, label %logical_and_merge_66

logical_and_right_66:
  %t68 = load i8*, i8** %l0
  %t69 = call i64 @sailfin_runtime_string_length(i8* %t68)
  %t70 = load double, double* %l2
  %t71 = sitofp i64 %t69 to double
  %t72 = fcmp ogt double %t71, %t70
  br label %logical_and_right_end_66

logical_and_right_end_66:
  br label %logical_and_merge_66

logical_and_merge_66:
  %t73 = phi i1 [ false, %logical_and_entry_66 ], [ %t72, %logical_and_right_end_66 ]
  %t74 = load i8*, i8** %l0
  %t75 = load double, double* %l1
  %t76 = load double, double* %l2
  %t77 = load double, double* %l3
  %t78 = load i1, i1* %l4
  br i1 %t73, label %then10, label %merge11
then10:
  call void @stage2_debug_marker(i64 61220)
  %t79 = load i8*, i8** %l0
  %t80 = load double, double* %l2
  %t81 = call double @llvm.round.f64(double %t80)
  %t82 = fptosi double %t81 to i64
  %t83 = call i8* @sailfin_runtime_substring(i8* %t79, i64 0, i64 %t82)
  store i8* %t83, i8** %l0
  %t84 = load i8*, i8** %l0
  br label %merge11
merge11:
  %t85 = phi i8* [ %t84, %then10 ], [ %t74, %logical_and_merge_66 ]
  store i8* %t85, i8** %l0
  %t86 = load i1, i1* %l4
  %t87 = load i8*, i8** %l0
  %t88 = load double, double* %l1
  %t89 = load double, double* %l2
  %t90 = load double, double* %l3
  %t91 = load i1, i1* %l4
  br i1 %t86, label %then12, label %merge13
then12:
  call void @stage2_debug_marker(i64 61230)
  %t92 = load i8*, i8** %l0
  %s93 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h1896695889, i32 0, i32 0
  %t94 = call i8* @sailfin_runtime_string_concat(i8* %t92, i8* %s93)
  store i8* %t94, i8** %l0
  %t95 = load i8*, i8** %l0
  br label %merge13
merge13:
  %t96 = phi i8* [ %t95, %then12 ], [ %t87, %merge11 ]
  store i8* %t96, i8** %l0
  %t97 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t97)
  call void @stage2_debug_marker(i64 61290)
  ret i8* %t97
}
