define %Parser @skip_trivia(%Parser %parser) {
block.entry:
  %l0 = alloca %Parser
  %l1 = alloca %Token*
  store %Parser %parser, %Parser* %l0
  %t0 = load %Parser, %Parser* %l0
  br label %loop.header0
loop.header0:
  %t29 = phi %Parser [ %t0, %block.entry ], [ %t28, %loop.latch2 ]
  store %Parser %t29, %Parser* %l0
  br label %loop.body1
loop.body1:
  %t1 = load %Parser, %Parser* %l0
  %t2 = extractvalue %Parser %t1, 1
  %stage2_skip_index_i64 = fptosi double %t2 to i64
  %stage2_skip_index_marker = add i64 %stage2_skip_index_i64, 5000
  call void @stage2_debug_marker(i64 %stage2_skip_index_marker)
  %t3 = load %Parser, %Parser* %l0
  %t4 = extractvalue %Parser %t3, 0
  %t5 = load { %Token**, i64 }, { %Token**, i64 }* %t4
  %t6 = extractvalue { %Token**, i64 } %t5, 1
  %t7 = sitofp i64 %t6 to double
  %t8 = fcmp oge double %t2, %t7
  %t9 = load %Parser, %Parser* %l0
  %stage2_skip_bounds_marker = select i1 %t8, i64 52100, i64 52101
  call void @stage2_debug_marker(i64 %stage2_skip_bounds_marker)
  br i1 %t8, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t10 = load %Parser, %Parser* %l0
  %t11 = extractvalue %Parser %t10, 0
  %t12 = load %Parser, %Parser* %l0
  %t13 = extractvalue %Parser %t12, 1
  %t14 = fptosi double %t13 to i64
  %t15 = load { %Token**, i64 }, { %Token**, i64 }* %t11
  %t16 = extractvalue { %Token**, i64 } %t15, 0
  %t17 = extractvalue { %Token**, i64 } %t15, 1
  %t18 = icmp uge i64 %t14, %t17
  ; bounds check: %t18 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t14, i64 %t17)
  %t19 = getelementptr %Token*, %Token** %t16, i64 %t14
  %t20 = load %Token*, %Token** %t19
  store %Token* %t20, %Token** %l1
  %t21 = load %Token*, %Token** %l1
  %t22 = load %Token, %Token* %t21
  %stage2_skip_token_kind = extractvalue %Token %t22, 0
  %stage2_skip_token_variant = extractvalue %TokenKind %stage2_skip_token_kind, 0
  %stage2_skip_token_variant_i64 = sext i32 %stage2_skip_token_variant to i64
  %stage2_skip_token_marker = add i64 %stage2_skip_token_variant_i64, 5100
  call void @stage2_debug_marker(i64 %stage2_skip_token_marker)
  call void @stage2_debug_marker(i64 53080)
  %t23 = call i1 @is_trivia_token(%Token %t22)
  %t24 = load %Parser, %Parser* %l0
  %t25 = load %Token*, %Token** %l1
  %stage2_skip_trivia_decision = select i1 %t23, i64 52021, i64 52020
  call void @stage2_debug_marker(i64 %stage2_skip_trivia_decision)
  br i1 %t23, label %then6, label %merge7
then6:
  call void @stage2_debug_marker(i64 52001)
  %t26 = load %Parser, %Parser* %l0
  %t27 = call %Parser @parser_advance_raw(%Parser %t26)
  store %Parser %t27, %Parser* %l0
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  %t28 = load %Parser, %Parser* %l0
  br label %loop.header0
afterloop3:
  %t30 = load %Parser, %Parser* %l0
  %t31 = load %Parser, %Parser* %l0
  ret %Parser %t31
}
