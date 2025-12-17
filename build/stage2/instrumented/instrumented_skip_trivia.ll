define %Parser @skip_trivia(%Parser %parser) {
block.entry:
  %l0 = alloca %Parser
  %l1 = alloca %Token
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
  %t5 = load { %Token*, i64 }, { %Token*, i64 }* %t4
  %t6 = extractvalue { %Token*, i64 } %t5, 1
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
  %t14 = call double @llvm.round.f64(double %t13)
  %t15 = fptosi double %t14 to i64
  %t16 = load { %Token*, i64 }, { %Token*, i64 }* %t11
  %t17 = extractvalue { %Token*, i64 } %t16, 0
  %t18 = extractvalue { %Token*, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t15, i64 %t18)
  %t20 = getelementptr %Token, %Token* %t17, i64 %t15
  %t21 = load %Token, %Token* %t20
  store %Token %t21, %Token* %l1
  %t22 = load %Token, %Token* %l1
  call void @stage2_debug_marker(i64 53080)
  %t23 = call i1 @is_trivia_token(%Token %t22)
  %t24 = load %Parser, %Parser* %l0
  %t25 = load %Token, %Token* %l1
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
