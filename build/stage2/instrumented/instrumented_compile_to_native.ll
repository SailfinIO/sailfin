define %EmitNativeResult @compile_to_native(i8* %source) {
block.entry:
  call void @stage2_debug_marker(i64 2990)
  %l0 = alloca %Program
  %l1 = alloca %TypecheckResult
  call void @stage2_debug_marker(i64 2991)
  %t0 = call %Program @parse_program(i8* %source)
  call void @stage2_debug_marker(i64 2992)
  store %Program %t0, %Program* %l0
  %t1 = load %Program, %Program* %l0
  %t2 = call %TypecheckResult @typecheck_program(%Program %t1)
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
  %t10 = load %TypecheckResult, %TypecheckResult* %l1
  %t11 = extractvalue %TypecheckResult %t10, 0
  call void @report_typecheck_errors({ %Diagnostic*, i64 }* %t11, i8* %source)
  %t12 = call %NativeModule @empty_native_module()
  %t13 = insertvalue %EmitNativeResult undef, %NativeModule %t12, 0
  %t14 = load %TypecheckResult, %TypecheckResult* %l1
  %t15 = extractvalue %TypecheckResult %t14, 0
  %t16 = call { i8**, i64 }* @format_typecheck_diagnostics({ %Diagnostic*, i64 }* %t15, i8* %source)
  %t17 = insertvalue %EmitNativeResult %t13, { i8**, i64 }* %t16, 1
  ret %EmitNativeResult %t17
merge1:
  %t18 = load %Program, %Program* %l0
  call void @stage2_debug_marker(i64 2994)
  %t19 = call %EmitNativeResult @emit_native(%Program %t18)
  ret %EmitNativeResult %t19
}
