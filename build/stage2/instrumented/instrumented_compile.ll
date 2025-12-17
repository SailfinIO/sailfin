define i8* @compile_to_sailfin(i8* %source) {
block.entry:
  call void @stage2_debug_marker(i64 1990)
  %l0 = alloca %Program
  %l1 = alloca %TypecheckResult
  call void @stage2_debug_marker(i64 1991)
  %t0 = call %Program @parse_program(i8* %source)
  call void @stage2_debug_marker(i64 2000)
  store %Program %t0, %Program* %l0
  %t1 = load %Program, %Program* %l0
  %t2 = call %TypecheckResult @typecheck_program(%Program %t1)
  call void @stage2_debug_marker(i64 2001)
  store %TypecheckResult %t2, %TypecheckResult* %l1
  %t3 = load %TypecheckResult, %TypecheckResult* %l1
  %t4 = extractvalue %TypecheckResult %t3, 0
  %t5 = load { %Diagnostic*, i64 }, { %Diagnostic*, i64 }* %t4
  %t6 = extractvalue { %Diagnostic*, i64 } %t5, 1
  %t7 = icmp sgt i64 %t6, 0
  %t8 = load %Program, %Program* %l0
  %t9 = load %TypecheckResult, %TypecheckResult* %l1
  br i1 %t7, label %then0, label %merge1
then0:
  call void @stage2_debug_marker(i64 2002)
  %t10 = load %TypecheckResult, %TypecheckResult* %l1
  %t11 = extractvalue %TypecheckResult %t10, 0
  call void @report_typecheck_errors({ %Diagnostic*, i64 }* %t11, i8* %source)
  %s12 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %s12)
  ret i8* %s12
merge1:
  call void @stage2_debug_marker(i64 2003)
  %t13 = load %Program, %Program* %l0
  %t14 = call i8* @emit_program(%Program %t13)
  call void @sailfin_runtime_mark_persistent(i8* %t14)
  ret i8* %t14
}
