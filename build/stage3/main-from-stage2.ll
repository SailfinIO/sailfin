
  %t30 = load double, double* %l1
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t28, label %then0, label %merge1
then0:
  %t32 = sitofp i64 0 to double
  store double %t32, double* %l3
  %t33 = load i8*, i8** %l0
  %t34 = load double, double* %l1
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t36 = load double, double* %l3
  br label %loop.header2
loop.header2:
  %t63 = phi double [ %t36, %then0 ], [ %t62, %loop.latch4 ]
  store double %t63, double* %l3
  br label %loop.body3
loop.body3:
  %t37 = load double, double* %l3
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t39 = load { i8**, i64 }, { i8**, i64 }* %t38
  %t40 = extractvalue { i8**, i64 } %t39, 1
  %t41 = sitofp i64 %t40 to double
  %t42 = fcmp ogt double %t37, %t41
  %t43 = load i8*, i8** %l0
  %t44 = load double, double* %l1
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t46 = load double, double* %l3
  br i1 %t42, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %s47 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h2048158982, i32 0, i32 0
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t49 = load double, double* %l3
  %t50 = call double @llvm.round.f64(double %t49)
  %t51 = fptosi double %t50 to i64
  %t52 = load { i8**, i64 }, { i8**, i64 }* %t48
  %t53 = extractvalue { i8**, i64 } %t52, 0
  %t54 = extractvalue { i8**, i64 } %t52, 1
  %t55 = icmp uge i64 %t51, %t54
  ; bounds check: %t55 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t51, i64 %t54)
  %t56 = getelementptr i8*, i8** %t53, i64 %t51
  %t57 = load i8*, i8** %t56
  %t58 = call i8* @sailfin_runtime_string_concat(i8* %s47, i8* %t57)
  call void @sailfin_runtime_print_warn(i8* %t58)
  %t59 = load double, double* %l3
  %t60 = sitofp i64 1 to double
  %t61 = fadd double %t59, %t60
  store double %t61, double* %l3
  br label %loop.latch4
loop.latch4:
  %t62 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t64 = load double, double* %l3
  br label %merge1
merge1:
  ret i8* null
}

; fn compile_to_llvm effects: ![io]
define i8* @compile_to_llvm(i8* %source) {
block.entry:
  %l0 = alloca i8*
  %t0 = call i8* @compile_to_native_llvm(i8* %source)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = getelementptr inbounds [3 x i8], [3 x i8]* @.runtime.field.ir, i32 0, i32 0
  %t3 = call i8* @sailfin_runtime_get_field(i8* %t1, i8* %t2)
  call void @sailfin_runtime_mark_persistent(i8* %t3)
  ret i8* %t3
}

; fn compile_to_native_llvm_full effects: ![io]
define %LLVMCompilationResult @compile_to_native_llvm_full(i8* %source) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca double
  %t0 = call i8* @compile_to_native(i8* %source)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = getelementptr inbounds [7 x i8], [7 x i8]* @.runtime.field.module, i32 0, i32 0
  %t3 = call i8* @sailfin_runtime_get_field(i8* %t1, i8* %t2)
  %t4 = call double @lower_to_llvm(i8* %t3)
  store double %t4, double* %l1
  %t5 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t6 = ptrtoint [0 x i8*]* %t5 to i64
  %t7 = icmp eq i64 %t6, 0
  %t8 = select i1 %t7, i64 1, i64 %t6
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to i8**
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t12 = ptrtoint { i8**, i64 }* %t11 to i64
  %t13 = call i8* @malloc(i64 %t12)
  %t14 = bitcast i8* %t13 to { i8**, i64 }*
  %t15 = getelementptr { i8**, i64 }, { i8**, i64 }* %t14, i32 0, i32 0
  store i8** %t10, i8*** %t15
  %t16 = getelementptr { i8**, i64 }, { i8**, i64 }* %t14, i32 0, i32 1
  store i64 0, i64* %t16
  store { i8**, i64 }* %t14, { i8**, i64 }** %l2
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t18 = load i8*, i8** %l0
  %t19 = getelementptr inbounds [12 x i8], [12 x i8]* @.runtime.field.diagnostics, i32 0, i32 0
  %t20 = call i8* @sailfin_runtime_get_field(i8* %t18, i8* %t19)
  %t21 = bitcast i8* %t20 to { i8**, i64 }*
  %t22 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t17, { i8**, i64 }* %t21)
  store { i8**, i64 }* %t22, { i8**, i64 }** %l2
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t24 = load double, double* %l1
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t26 = load { i8**, i64 }, { i8**, i64 }* %t25
  %t27 = extractvalue { i8**, i64 } %t26, 1
  %t28 = icmp sgt i64 %t27, 0
  %t29 = load i8*, i8** %l0
  %t30 = load double, double* %l1
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t28, label %then0, label %merge1
then0:
  %t32 = sitofp i64 0 to double
  store double %t32, double* %l3
  %t33 = load i8*, i8** %l0
  %t34 = load double, double* %l1
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t36 = load double, double* %l3
  br label %loop.header2
loop.header2:
  %t63 = phi double [ %t36, %then0 ], [ %t62, %loop.latch4 ]
  store double %t63, double* %l3
  br label %loop.body3
loop.body3:
  %t37 = load double, double* %l3
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t39 = load { i8**, i64 }, { i8**, i64 }* %t38
  %t40 = extractvalue { i8**, i64 } %t39, 1
  %t41 = sitofp i64 %t40 to double
  %t42 = fcmp ogt double %t37, %t41
  %t43 = load i8*, i8** %l0
  %t44 = load double, double* %l1
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t46 = load double, double* %l3
  br i1 %t42, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %s47 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h2048158982, i32 0, i32 0
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t49 = load double, double* %l3
  %t50 = call double @llvm.round.f64(double %t49)
  %t51 = fptosi double %t50 to i64
  %t52 = load { i8**, i64 }, { i8**, i64 }* %t48
  %t53 = extractvalue { i8**, i64 } %t52, 0
  %t54 = extractvalue { i8**, i64 } %t52, 1
  %t55 = icmp uge i64 %t51, %t54
  ; bounds check: %t55 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t51, i64 %t54)
  %t56 = getelementptr i8*, i8** %t53, i64 %t51
  %t57 = load i8*, i8** %t56
  %t58 = call i8* @sailfin_runtime_string_concat(i8* %s47, i8* %t57)
  call void @sailfin_runtime_print_warn(i8* %t58)
  %t59 = load double, double* %l3
  %t60 = sitofp i64 1 to double
  %t61 = fadd double %t59, %t60
  store double %t61, double* %l3
  br label %loop.latch4
loop.latch4:
  %t62 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t64 = load double, double* %l3
  br label %merge1
merge1:
  ret %LLVMCompilationResult zeroinitializer
}

; fn compile_to_native_llvm_with_context effects: ![io]
define i8* @compile_to_native_llvm_with_context(i8* %source, { i8**, i64 }* %manifest_contents, { i8**, i64 }* %native_artifacts) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca i8*
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca { i8**, i64 }*
  %l7 = alloca double
  %t0 = call i8* @compile_to_native(i8* %source)
  store i8* %t0, i8** %l0
  %t1 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t2 = ptrtoint [0 x i8*]* %t1 to i64
  %t3 = icmp eq i64 %t2, 0
  %t4 = select i1 %t3, i64 1, i64 %t2
  %t5 = call i8* @malloc(i64 %t4)
  %t6 = bitcast i8* %t5 to i8**
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t8 = ptrtoint { i8**, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { i8**, i64 }*
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 0
  store i8** %t6, i8*** %t11
  %t12 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 1
  store i64 0, i64* %t12
  store { i8**, i64 }* %t10, { i8**, i64 }** %l1
  %t13 = sitofp i64 0 to double
  store double %t13, double* %l2
  %t14 = load i8*, i8** %l0
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t16 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t53 = phi { i8**, i64 }* [ %t15, %block.entry ], [ %t51, %loop.latch2 ]
  %t54 = phi double [ %t16, %block.entry ], [ %t52, %loop.latch2 ]
  store { i8**, i64 }* %t53, { i8**, i64 }** %l1
  store double %t54, double* %l2
  br label %loop.body1
loop.body1:
  %t17 = load double, double* %l2
  %t18 = load { i8**, i64 }, { i8**, i64 }* %manifest_contents
  %t19 = extractvalue { i8**, i64 } %t18, 1
  %t20 = sitofp i64 %t19 to double
  %t21 = fcmp ogt double %t17, %t20
  %t22 = load i8*, i8** %l0
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t24 = load double, double* %l2
  br i1 %t21, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t25 = load double, double* %l2
  %t26 = call double @llvm.round.f64(double %t25)
  %t27 = fptosi double %t26 to i64
  %t28 = load { i8**, i64 }, { i8**, i64 }* %manifest_contents
  %t29 = extractvalue { i8**, i64 } %t28, 0
  %t30 = extractvalue { i8**, i64 } %t28, 1
  %t31 = icmp uge i64 %t27, %t30
  ; bounds check: %t31 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t27, i64 %t30)
  %t32 = getelementptr i8*, i8** %t29, i64 %t27
  %t33 = load i8*, i8** %t32
  store i8* %t33, i8** %l3
  %t34 = load i8*, i8** %l3
  %t35 = call i64 @sailfin_runtime_string_length(i8* %t34)
  %t36 = icmp eq i64 %t35, 0
  %t37 = load i8*, i8** %l0
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t39 = load double, double* %l2
  %t40 = load i8*, i8** %l3
  br i1 %t36, label %then6, label %else7
then6:
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge8
else7:
  %t43 = load i8*, i8** %l3
  %t44 = call double @parse_layout_manifest(i8* %t43)
  store double %t44, double* %l4
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge8
merge8:
  %t47 = phi { i8**, i64 }* [ %t42, %then6 ], [ %t46, %else7 ]
  store { i8**, i64 }* %t47, { i8**, i64 }** %l1
  %t48 = load double, double* %l2
  %t49 = sitofp i64 1 to double
  %t50 = fadd double %t48, %t49
  store double %t50, double* %l2
  br label %loop.latch2
loop.latch2:
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t52 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t56 = load double, double* %l2
  %t57 = load i8*, i8** %l0
  %t58 = getelementptr inbounds [7 x i8], [7 x i8]* @.runtime.field.module, i32 0, i32 0
  %t59 = call i8* @sailfin_runtime_get_field(i8* %t57, i8* %t58)
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t61 = getelementptr [0 x double], [0 x double]* null, i32 1
  %t62 = ptrtoint [0 x double]* %t61 to i64
  %t63 = icmp eq i64 %t62, 0
  %t64 = select i1 %t63, i64 1, i64 %t62
  %t65 = call i8* @malloc(i64 %t64)
  %t66 = bitcast i8* %t65 to double*
  %t67 = getelementptr { double*, i64 }, { double*, i64 }* null, i32 1
  %t68 = ptrtoint { double*, i64 }* %t67 to i64
  %t69 = call i8* @malloc(i64 %t68)
  %t70 = bitcast i8* %t69 to { double*, i64 }*
  %t71 = getelementptr { double*, i64 }, { double*, i64 }* %t70, i32 0, i32 0
  store double* %t66, double** %t71
  %t72 = getelementptr { double*, i64 }, { double*, i64 }* %t70, i32 0, i32 1
  store i64 0, i64* %t72
  %t73 = call double @lower_to_llvm_with_context(i8* %t59, { i8**, i64 }* %t60, { i8**, i64 }* %native_artifacts, { double*, i64 }* %t70)
  store double %t73, double* %l5
  %t74 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t75 = ptrtoint [0 x i8*]* %t74 to i64
  %t76 = icmp eq i64 %t75, 0
  %t77 = select i1 %t76, i64 1, i64 %t75
  %t78 = call i8* @malloc(i64 %t77)
  %t79 = bitcast i8* %t78 to i8**
  %t80 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t81 = ptrtoint { i8**, i64 }* %t80 to i64
  %t82 = call i8* @malloc(i64 %t81)
  %t83 = bitcast i8* %t82 to { i8**, i64 }*
  %t84 = getelementptr { i8**, i64 }, { i8**, i64 }* %t83, i32 0, i32 0
  store i8** %t79, i8*** %t84
  %t85 = getelementptr { i8**, i64 }, { i8**, i64 }* %t83, i32 0, i32 1
  store i64 0, i64* %t85
  store { i8**, i64 }* %t83, { i8**, i64 }** %l6
  %t86 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t87 = load i8*, i8** %l0
  %t88 = getelementptr inbounds [12 x i8], [12 x i8]* @.runtime.field.diagnostics, i32 0, i32 0
  %t89 = call i8* @sailfin_runtime_get_field(i8* %t87, i8* %t88)
  %t90 = bitcast i8* %t89 to { i8**, i64 }*
  %t91 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t86, { i8**, i64 }* %t90)
  store { i8**, i64 }* %t91, { i8**, i64 }** %l6
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t93 = load double, double* %l5
  %t94 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t95 = load { i8**, i64 }, { i8**, i64 }* %t94
  %t96 = extractvalue { i8**, i64 } %t95, 1
  %t97 = icmp sgt i64 %t96, 0
  %t98 = load i8*, i8** %l0
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t100 = load double, double* %l2
  %t101 = load double, double* %l5
  %t102 = load { i8**, i64 }*, { i8**, i64 }** %l6
  br i1 %t97, label %then9, label %merge10
then9:
  %t103 = sitofp i64 0 to double
  store double %t103, double* %l7
  %t104 = load i8*, i8** %l0
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t106 = load double, double* %l2
  %t107 = load double, double* %l5
  %t108 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t109 = load double, double* %l7
  br label %loop.header11
loop.header11:
  %t138 = phi double [ %t109, %then9 ], [ %t137, %loop.latch13 ]
  store double %t138, double* %l7
  br label %loop.body12
loop.body12:
  %t110 = load double, double* %l7
  %t111 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t112 = load { i8**, i64 }, { i8**, i64 }* %t111
  %t113 = extractvalue { i8**, i64 } %t112, 1
  %t114 = sitofp i64 %t113 to double
  %t115 = fcmp ogt double %t110, %t114
  %t116 = load i8*, i8** %l0
  %t117 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t118 = load double, double* %l2
  %t119 = load double, double* %l5
  %t120 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t121 = load double, double* %l7
  br i1 %t115, label %then15, label %merge16
then15:
  br label %afterloop14
merge16:
  %s122 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h2048158982, i32 0, i32 0
  %t123 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t124 = load double, double* %l7
  %t125 = call double @llvm.round.f64(double %t124)
  %t126 = fptosi double %t125 to i64
  %t127 = load { i8**, i64 }, { i8**, i64 }* %t123
  %t128 = extractvalue { i8**, i64 } %t127, 0
  %t129 = extractvalue { i8**, i64 } %t127, 1
  %t130 = icmp uge i64 %t126, %t129
  ; bounds check: %t130 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t126, i64 %t129)
  %t131 = getelementptr i8*, i8** %t128, i64 %t126
  %t132 = load i8*, i8** %t131
  %t133 = call i8* @sailfin_runtime_string_concat(i8* %s122, i8* %t132)
  call void @sailfin_runtime_print_warn(i8* %t133)
  %t134 = load double, double* %l7
  %t135 = sitofp i64 1 to double
  %t136 = fadd double %t134, %t135
  store double %t136, double* %l7
  br label %loop.latch13
loop.latch13:
  %t137 = load double, double* %l7
  br label %loop.header11
afterloop14:
  %t139 = load double, double* %l7
  br label %merge10
merge10:
  ret i8* null
}

; fn compile_to_native_llvm_with_manifests effects: ![io]
define i8* @compile_to_native_llvm_with_manifests(i8* %source, { i8**, i64 }* %manifest_contents) {
block.entry:
  %t0 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t1 = ptrtoint [0 x i8*]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to i8**
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t7 = ptrtoint { i8**, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { i8**, i64 }*
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 0
  store i8** %t5, i8*** %t10
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  %t12 = call i8* @compile_to_native_llvm_with_context(i8* %source, { i8**, i64 }* %manifest_contents, { i8**, i64 }* %t9)
  call void @sailfin_runtime_mark_persistent(i8* %t12)
  ret i8* %t12
}

; fn main effects: ![io]
define void @main() {
block.entry:
  %s0 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.len16.h385769534, i32 0, i32 0
  call void @sailfin_runtime_print_info(i8* %s0)
  ret void
}

; fn compile_project effects: ![io]
define %ProjectCompilation @compile_project({ i8**, i64 }* %sources) {
block.entry:
  %l0 = alloca { %CompiledModule*, i64 }*
  %l1 = alloca { %ModuleDiagnostics*, i64 }*
  %l2 = alloca i64
  %l3 = alloca i8*
  %l4 = alloca %ModuleCompilationResult
  %t0 = getelementptr [0 x %CompiledModule], [0 x %CompiledModule]* null, i32 1
  %t1 = ptrtoint [0 x %CompiledModule]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %CompiledModule*
  %t6 = getelementptr { %CompiledModule*, i64 }, { %CompiledModule*, i64 }* null, i32 1
  %t7 = ptrtoint { %CompiledModule*, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { %CompiledModule*, i64 }*
  %t10 = getelementptr { %CompiledModule*, i64 }, { %CompiledModule*, i64 }* %t9, i32 0, i32 0
  store %CompiledModule* %t5, %CompiledModule** %t10
  %t11 = getelementptr { %CompiledModule*, i64 }, { %CompiledModule*, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { %CompiledModule*, i64 }* %t9, { %CompiledModule*, i64 }** %l0
  %t12 = getelementptr [0 x %ModuleDiagnostics], [0 x %ModuleDiagnostics]* null, i32 1
  %t13 = ptrtoint [0 x %ModuleDiagnostics]* %t12 to i64
  %t14 = icmp eq i64 %t13, 0
  %t15 = select i1 %t14, i64 1, i64 %t13
  %t16 = call i8* @malloc(i64 %t15)
  %t17 = bitcast i8* %t16 to %ModuleDiagnostics*
  %t18 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* null, i32 1
  %t19 = ptrtoint { %ModuleDiagnostics*, i64 }* %t18 to i64
  %t20 = call i8* @malloc(i64 %t19)
  %t21 = bitcast i8* %t20 to { %ModuleDiagnostics*, i64 }*
  %t22 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t21, i32 0, i32 0
  store %ModuleDiagnostics* %t17, %ModuleDiagnostics** %t22
  %t23 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t21, i32 0, i32 1
  store i64 0, i64* %t23
  store { %ModuleDiagnostics*, i64 }* %t21, { %ModuleDiagnostics*, i64 }** %l1
  %t24 = getelementptr { i8**, i64 }, { i8**, i64 }* %sources, i32 0, i32 1
  %t25 = load i64, i64* %t24
  %t26 = getelementptr { i8**, i64 }, { i8**, i64 }* %sources, i32 0, i32 0
  %t27 = load i8**, i8*** %t26
  store i64 0, i64* %l2
  store i8* null, i8** %l3
  br label %for0
for0:
  %t28 = load i64, i64* %l2
  %t29 = icmp slt i64 %t28, %t25
  br i1 %t29, label %forbody1, label %afterfor3
forbody1:
  %t30 = load i64, i64* %l2
  %t31 = getelementptr i8*, i8** %t27, i64 %t30
  %t32 = load i8*, i8** %t31
  store i8* %t32, i8** %l3
  %t33 = load i8*, i8** %l3
  %t34 = call %ModuleCompilationResult @compile_source_at_path(i8* %t33)
  store %ModuleCompilationResult %t34, %ModuleCompilationResult* %l4
  %t35 = load %ModuleCompilationResult, %ModuleCompilationResult* %l4
  %t36 = load %ModuleCompilationResult, %ModuleCompilationResult* %l4
  br label %forinc2
forinc2:
  %t37 = load i64, i64* %l2
  %t38 = add i64 %t37, 1
  store i64 %t38, i64* %l2
  br label %for0
afterfor3:
  ret %ProjectCompilation zeroinitializer
}

; fn compile_source_at_path effects: ![io]
define %ModuleCompilationResult @compile_source_at_path(i8* %source_path) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca { i8**, i64 }*
  %l6 = alloca double
  %l7 = alloca i1
  %l8 = alloca { %ModuleDiagnostics*, i64 }*
  %t0 = call i8* @sailfin_adapter_fs_read_file(i8* %source_path)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call double @parse_program(i8* %t1)
  store double %t2, double* %l1
  %t3 = load double, double* %l1
  %t4 = call double @typecheck_program(double %t3)
  store double %t4, double* %l2
  %t5 = load double, double* %l2
  %t6 = load double, double* %l1
  %t7 = call double @emit_native(double %t6)
  store double %t7, double* %l3
  %t8 = load double, double* %l3
  store double 0.0, double* %l4
  %t9 = load double, double* %l3
  store { i8**, i64 }* null, { i8**, i64 }** %l5
  %t10 = load double, double* %l4
  store double 0.0, double* %l6
  %t11 = load double, double* %l6
  %t12 = call i1 @needs_python_fallback(i8* null)
  store i1 %t12, i1* %l7
  %t13 = load i1, i1* %l7
  %t14 = load i8*, i8** %l0
  %t15 = load double, double* %l1
  %t16 = load double, double* %l2
  %t17 = load double, double* %l3
  %t18 = load double, double* %l4
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t20 = load double, double* %l6
  %t21 = load i1, i1* %l7
  br i1 %t13, label %then0, label %merge1
then0:
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %s23 = getelementptr inbounds [86 x i8], [86 x i8]* @.str.len85.h1706301526, i32 0, i32 0
  %t24 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t25 = ptrtoint [1 x i8*]* %t24 to i64
  %t26 = icmp eq i64 %t25, 0
  %t27 = select i1 %t26, i64 1, i64 %t25
  %t28 = call i8* @malloc(i64 %t27)
  %t29 = bitcast i8* %t28 to i8**
  %t30 = getelementptr i8*, i8** %t29, i64 0
  store i8* %s23, i8** %t30
  %t31 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t32 = ptrtoint { i8**, i64 }* %t31 to i64
  %t33 = call i8* @malloc(i64 %t32)
  %t34 = bitcast i8* %t33 to { i8**, i64 }*
  %t35 = getelementptr { i8**, i64 }, { i8**, i64 }* %t34, i32 0, i32 0
  store i8** %t29, i8*** %t35
  %t36 = getelementptr { i8**, i64 }, { i8**, i64 }* %t34, i32 0, i32 1
  store i64 1, i64* %t36
  %t37 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t22, { i8**, i64 }* %t34)
  store { i8**, i64 }* %t37, { i8**, i64 }** %l5
  ret %ModuleCompilationResult zeroinitializer
merge1:
  %t38 = getelementptr [0 x %ModuleDiagnostics], [0 x %ModuleDiagnostics]* null, i32 1
  %t39 = ptrtoint [0 x %ModuleDiagnostics]* %t38 to i64
  %t40 = icmp eq i64 %t39, 0
  %t41 = select i1 %t40, i64 1, i64 %t39
  %t42 = call i8* @malloc(i64 %t41)
  %t43 = bitcast i8* %t42 to %ModuleDiagnostics*
  %t44 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* null, i32 1
  %t45 = ptrtoint { %ModuleDiagnostics*, i64 }* %t44 to i64
  %t46 = call i8* @malloc(i64 %t45)
  %t47 = bitcast i8* %t46 to { %ModuleDiagnostics*, i64 }*
  %t48 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t47, i32 0, i32 0
  store %ModuleDiagnostics* %t43, %ModuleDiagnostics** %t48
  %t49 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t47, i32 0, i32 1
  store i64 0, i64* %t49
  store { %ModuleDiagnostics*, i64 }* %t47, { %ModuleDiagnostics*, i64 }** %l8
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t51 = load { i8**, i64 }, { i8**, i64 }* %t50
  %t52 = extractvalue { i8**, i64 } %t51, 1
  %t53 = icmp sgt i64 %t52, 0
  %t54 = load i8*, i8** %l0
  %t55 = load double, double* %l1
  %t56 = load double, double* %l2
  %t57 = load double, double* %l3
  %t58 = load double, double* %l4
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t60 = load double, double* %l6
  %t61 = load i1, i1* %l7
  %t62 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l8
  br i1 %t53, label %then2, label %merge3
then2:
  %t63 = getelementptr [1 x %ModuleDiagnostics], [1 x %ModuleDiagnostics]* null, i32 1
  %t64 = ptrtoint [1 x %ModuleDiagnostics]* %t63 to i64
  %t65 = icmp eq i64 %t64, 0
  %t66 = select i1 %t65, i64 1, i64 %t64
  %t67 = call i8* @malloc(i64 %t66)
  %t68 = bitcast i8* %t67 to %ModuleDiagnostics*
  %t69 = getelementptr %ModuleDiagnostics, %ModuleDiagnostics* %t68, i64 0
  store %ModuleDiagnostics zeroinitializer, %ModuleDiagnostics* %t69
  %t70 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* null, i32 1
  %t71 = ptrtoint { %ModuleDiagnostics*, i64 }* %t70 to i64
  %t72 = call i8* @malloc(i64 %t71)
  %t73 = bitcast i8* %t72 to { %ModuleDiagnostics*, i64 }*
  %t74 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t73, i32 0, i32 0
  store %ModuleDiagnostics* %t68, %ModuleDiagnostics** %t74
  %t75 = getelementptr { %ModuleDiagnostics*, i64 }, { %ModuleDiagnostics*, i64 }* %t73, i32 0, i32 1
  store i64 1, i64* %t75
  store { %ModuleDiagnostics*, i64 }* %t73, { %ModuleDiagnostics*, i64 }** %l8
  %t76 = load { %ModuleDiagnostics*, i64 }*, { %ModuleDiagnostics*, i64 }** %l8
  br label %merge3
merge3:
  %t77 = phi { %ModuleDiagnostics*, i64 }* [ %t76, %then2 ], [ %t62, %merge1 ]
  store { %ModuleDiagnostics*, i64 }* %t77, { %ModuleDiagnostics*, i64 }** %l8
  ret %ModuleCompilationResult zeroinitializer
}

define { i8**, i64 }* @format_typecheck_diagnostics({ i8**, i64 }* %entries, i8* %source) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca double
  %l4 = alloca i8*
  %t0 = call { i8**, i64 }* @split_source_lines(i8* %source)
  store { i8**, i64 }* %t0, { i8**, i64 }** %l0
  %t1 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t2 = load { i8**, i64 }, { i8**, i64 }* %t1
  %t3 = extractvalue { i8**, i64 } %t2, 1
  %t4 = sitofp i64 %t3 to double
  %t5 = call i8* @number_to_string(double %t4)
  %t6 = call i64 @sailfin_runtime_string_length(i8* %t5)
  %t7 = sitofp i64 %t6 to double
  store double %t7, double* %l1
  %t8 = load double, double* %l1
  %t9 = sitofp i64 1 to double
  %t10 = fcmp olt double %t8, %t9
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t12 = load double, double* %l1
  br i1 %t10, label %then0, label %merge1
then0:
  %t13 = sitofp i64 1 to double
  store double %t13, double* %l1
  %t14 = load double, double* %l1
  br label %merge1
merge1:
  %t15 = phi double [ %t14, %then0 ], [ %t12, %block.entry ]
  store double %t15, double* %l1
  %t16 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t17 = ptrtoint [0 x i8*]* %t16 to i64
  %t18 = icmp eq i64 %t17, 0
  %t19 = select i1 %t18, i64 1, i64 %t17
  %t20 = call i8* @malloc(i64 %t19)
  %t21 = bitcast i8* %t20 to i8**
  %t22 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t23 = ptrtoint { i8**, i64 }* %t22 to i64
  %t24 = call i8* @malloc(i64 %t23)
  %t25 = bitcast i8* %t24 to { i8**, i64 }*
  %t26 = getelementptr { i8**, i64 }, { i8**, i64 }* %t25, i32 0, i32 0
  store i8** %t21, i8*** %t26
  %t27 = getelementptr { i8**, i64 }, { i8**, i64 }* %t25, i32 0, i32 1
  store i64 0, i64* %t27
  store { i8**, i64 }* %t25, { i8**, i64 }** %l2
  %t28 = sitofp i64 0 to double
  store double %t28, double* %l3
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t30 = load double, double* %l1
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t32 = load double, double* %l3
  br label %loop.header2
loop.header2:
  %t62 = phi { i8**, i64 }* [ %t31, %merge1 ], [ %t60, %loop.latch4 ]
  %t63 = phi double [ %t32, %merge1 ], [ %t61, %loop.latch4 ]
  store { i8**, i64 }* %t62, { i8**, i64 }** %l2
  store double %t63, double* %l3
  br label %loop.body3
loop.body3:
  %t33 = load double, double* %l3
  %t34 = load { i8**, i64 }, { i8**, i64 }* %entries
  %t35 = extractvalue { i8**, i64 } %t34, 1
  %t36 = sitofp i64 %t35 to double
  %t37 = fcmp ogt double %t33, %t36
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t39 = load double, double* %l1
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t41 = load double, double* %l3
  br i1 %t37, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t42 = load double, double* %l3
  %t43 = call double @llvm.round.f64(double %t42)
  %t44 = fptosi double %t43 to i64
  %t45 = load { i8**, i64 }, { i8**, i64 }* %entries
  %t46 = extractvalue { i8**, i64 } %t45, 0
  %t47 = extractvalue { i8**, i64 } %t45, 1
  %t48 = icmp uge i64 %t44, %t47
  ; bounds check: %t48 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t44, i64 %t47)
  %t49 = getelementptr i8*, i8** %t46, i64 %t44
  %t50 = load i8*, i8** %t49
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t52 = load double, double* %l1
  %t53 = call i8* @format_typecheck_diagnostic(i8* %t50, { i8**, i64 }* %t51, double %t52)
  store i8* %t53, i8** %l4
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t55 = load i8*, i8** %l4
  %t56 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t54, i8* %t55)
  store { i8**, i64 }* %t56, { i8**, i64 }** %l2
  %t57 = load double, double* %l3
  %t58 = sitofp i64 1 to double
  %t59 = fadd double %t57, %t58
  store double %t59, double* %l3
  br label %loop.latch4
loop.latch4:
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t61 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t65 = load double, double* %l3
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l2
  ret { i8**, i64 }* %t66
}

; fn report_typecheck_errors effects: ![io]
define void @report_typecheck_errors({ i8**, i64 }* %entries, i8* %source) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca { i8**, i64 }*
  %l6 = alloca double
  %t0 = call { i8**, i64 }* @format_typecheck_diagnostics({ i8**, i64 }* %entries, i8* %source)
  store { i8**, i64 }* %t0, { i8**, i64 }** %l0
  %s1 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h1402485025, i32 0, i32 0
  store i8* %s1, i8** %l1
  %t2 = load i8*, i8** %l1
  %t3 = call i64 @sailfin_runtime_string_length(i8* %t2)
  %t4 = add i64 0, 2
  %t5 = call i8* @malloc(i64 %t4)
  store i8 32, i8* %t5
  %t6 = getelementptr i8, i8* %t5, i64 1
  store i8 0, i8* %t6
  call void @sailfin_runtime_mark_persistent(i8* %t5)
  %t7 = sitofp i64 %t3 to double
  %t8 = call i8* @repeat_character(i8* %t5, double %t7)
  store i8* %t8, i8** %l2
  %t9 = sitofp i64 0 to double
  store double %t9, double* %l3
  %t10 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t11 = load i8*, i8** %l1
  %t12 = load i8*, i8** %l2
  %t13 = load double, double* %l3
  br label %loop.header0
loop.header0:
  %t115 = phi double [ %t13, %block.entry ], [ %t114, %loop.latch2 ]
  store double %t115, double* %l3
  br label %loop.body1
loop.body1:
  %t14 = load double, double* %l3
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t16 = load { i8**, i64 }, { i8**, i64 }* %t15
  %t17 = extractvalue { i8**, i64 } %t16, 1
  %t18 = sitofp i64 %t17 to double
  %t19 = fcmp ogt double %t14, %t18
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t21 = load i8*, i8** %l1
  %t22 = load i8*, i8** %l2
  %t23 = load double, double* %l3
  br i1 %t19, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t25 = load double, double* %l3
  %t26 = call double @llvm.round.f64(double %t25)
  %t27 = fptosi double %t26 to i64
  %t28 = load { i8**, i64 }, { i8**, i64 }* %t24
  %t29 = extractvalue { i8**, i64 } %t28, 0
  %t30 = extractvalue { i8**, i64 } %t28, 1
  %t31 = icmp uge i64 %t27, %t30
  ; bounds check: %t31 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t27, i64 %t30)
  %t32 = getelementptr i8*, i8** %t29, i64 %t27
  %t33 = load i8*, i8** %t32
  store i8* %t33, i8** %l4
  %t34 = load i8*, i8** %l4
  %t35 = call { i8**, i64 }* @split_source_lines(i8* %t34)
  store { i8**, i64 }* %t35, { i8**, i64 }** %l5
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t37 = load { i8**, i64 }, { i8**, i64 }* %t36
  %t38 = extractvalue { i8**, i64 } %t37, 1
  %t39 = icmp eq i64 %t38, 0
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t41 = load i8*, i8** %l1
  %t42 = load i8*, i8** %l2
  %t43 = load double, double* %l3
  %t44 = load i8*, i8** %l4
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l5
  br i1 %t39, label %then6, label %merge7
then6:
  %t46 = load i8*, i8** %l1
  call void @sailfin_runtime_print_error(i8* %t46)
  %t47 = load double, double* %l3
  %t48 = sitofp i64 1 to double
  %t49 = fadd double %t47, %t48
  store double %t49, double* %l3
  br label %loop.latch2
merge7:
  %t50 = sitofp i64 0 to double
  store double %t50, double* %l6
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t52 = load i8*, i8** %l1
  %t53 = load i8*, i8** %l2
  %t54 = load double, double* %l3
  %t55 = load i8*, i8** %l4
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t57 = load double, double* %l6
  br label %loop.header8
loop.header8:
  %t109 = phi double [ %t57, %merge7 ], [ %t108, %loop.latch10 ]
  store double %t109, double* %l6
  br label %loop.body9
loop.body9:
  %t58 = load double, double* %l6
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t60 = load { i8**, i64 }, { i8**, i64 }* %t59
  %t61 = extractvalue { i8**, i64 } %t60, 1
  %t62 = sitofp i64 %t61 to double
  %t63 = fcmp ogt double %t58, %t62
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t65 = load i8*, i8** %l1
  %t66 = load i8*, i8** %l2
  %t67 = load double, double* %l3
  %t68 = load i8*, i8** %l4
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t70 = load double, double* %l6
  br i1 %t63, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t71 = load double, double* %l6
  %t72 = sitofp i64 0 to double
  %t73 = fcmp oeq double %t71, %t72
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t75 = load i8*, i8** %l1
  %t76 = load i8*, i8** %l2
  %t77 = load double, double* %l3
  %t78 = load i8*, i8** %l4
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t80 = load double, double* %l6
  br i1 %t73, label %then14, label %else15
then14:
  %t81 = load i8*, i8** %l1
  %t82 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t83 = load double, double* %l6
  %t84 = call double @llvm.round.f64(double %t83)
  %t85 = fptosi double %t84 to i64
  %t86 = load { i8**, i64 }, { i8**, i64 }* %t82
  %t87 = extractvalue { i8**, i64 } %t86, 0
  %t88 = extractvalue { i8**, i64 } %t86, 1
  %t89 = icmp uge i64 %t85, %t88
  ; bounds check: %t89 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t85, i64 %t88)
  %t90 = getelementptr i8*, i8** %t87, i64 %t85
  %t91 = load i8*, i8** %t90
  %t92 = call i8* @sailfin_runtime_string_concat(i8* %t81, i8* %t91)
  call void @sailfin_runtime_print_error(i8* %t92)
  br label %merge16
else15:
  %t93 = load i8*, i8** %l2
  %t94 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t95 = load double, double* %l6
  %t96 = call double @llvm.round.f64(double %t95)
  %t97 = fptosi double %t96 to i64
  %t98 = load { i8**, i64 }, { i8**, i64 }* %t94
  %t99 = extractvalue { i8**, i64 } %t98, 0
  %t100 = extractvalue { i8**, i64 } %t98, 1
  %t101 = icmp uge i64 %t97, %t100
  ; bounds check: %t101 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t97, i64 %t100)
  %t102 = getelementptr i8*, i8** %t99, i64 %t97
  %t103 = load i8*, i8** %t102
  %t104 = call i8* @sailfin_runtime_string_concat(i8* %t93, i8* %t103)
  call void @sailfin_runtime_print_error(i8* %t104)
  br label %merge16
merge16:
  %t105 = load double, double* %l6
  %t106 = sitofp i64 1 to double
  %t107 = fadd double %t105, %t106
  store double %t107, double* %l6
  br label %loop.latch10
loop.latch10:
  %t108 = load double, double* %l6
  br label %loop.header8
afterloop11:
  %t110 = load double, double* %l6
  %t111 = load double, double* %l3
  %t112 = sitofp i64 1 to double
  %t113 = fadd double %t111, %t112
  store double %t113, double* %l3
  br label %loop.latch2
loop.latch2:
  %t114 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t116 = load double, double* %l3
  ret void
}

define i8* @format_typecheck_diagnostic(i8* %entry, { i8**, i64 }* %source_lines, double %line_padding) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca i8*
  %l4 = alloca i8*
  %l5 = alloca double
  %l6 = alloca i8*
  %l7 = alloca i8*
  %l8 = alloca i8*
  %l9 = alloca double
  %l10 = alloca i8*
  %t0 = getelementptr inbounds [8 x i8], [8 x i8]* @.runtime.field.primary, i32 0, i32 0
  %t1 = call i8* @sailfin_runtime_get_field(i8* %entry, i8* %t0)
  %t2 = icmp eq i8* %t1, null
  br i1 %t2, label %then0, label %merge1
then0:
  %t3 = getelementptr inbounds [8 x i8], [8 x i8]* @.runtime.field.message, i32 0, i32 0
  %t4 = call i8* @sailfin_runtime_get_field(i8* %entry, i8* %t3)
  call void @sailfin_runtime_mark_persistent(i8* %t4)
  ret i8* %t4
merge1:
  %t5 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t6 = ptrtoint [0 x i8*]* %t5 to i64
  %t7 = icmp eq i64 %t6, 0
  %t8 = select i1 %t7, i64 1, i64 %t6
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to i8**
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t12 = ptrtoint { i8**, i64 }* %t11 to i64
  %t13 = call i8* @malloc(i64 %t12)
  %t14 = bitcast i8* %t13 to { i8**, i64 }*
  %t15 = getelementptr { i8**, i64 }, { i8**, i64 }* %t14, i32 0, i32 0
  store i8** %t10, i8*** %t15
  %t16 = getelementptr { i8**, i64 }, { i8**, i64 }* %t14, i32 0, i32 1
  store i64 0, i64* %t16
  store { i8**, i64 }* %t14, { i8**, i64 }** %l0
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = getelementptr inbounds [8 x i8], [8 x i8]* @.runtime.field.message, i32 0, i32 0
  %t19 = call i8* @sailfin_runtime_get_field(i8* %entry, i8* %t18)
  %t20 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t17, i8* %t19)
  store { i8**, i64 }* %t20, { i8**, i64 }** %l0
  %t21 = getelementptr inbounds [8 x i8], [8 x i8]* @.runtime.field.primary, i32 0, i32 0
  %t22 = call i8* @sailfin_runtime_get_field(i8* %entry, i8* %t21)
  store i8* %t22, i8** %l1
  %t23 = load i8*, i8** %l1
  %t24 = getelementptr inbounds [5 x i8], [5 x i8]* @.runtime.field.line, i32 0, i32 0
  %t25 = call i8* @sailfin_runtime_get_field(i8* %t23, i8* %t24)
  store i8* %t25, i8** %l2
  %t26 = load i8*, i8** %l1
  %t27 = getelementptr inbounds [7 x i8], [7 x i8]* @.runtime.field.column, i32 0, i32 0
  %t28 = call i8* @sailfin_runtime_get_field(i8* %t26, i8* %t27)
  store i8* %t28, i8** %l3
  %s29 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1801723778, i32 0, i32 0
  %t30 = load i8*, i8** %l2
  %t31 = bitcast i8* %t30 to double*
  %t32 = load double, double* %t31
  %t33 = call i8* @number_to_string(double %t32)
  %t34 = call i8* @sailfin_runtime_string_concat(i8* %s29, i8* %t33)
  %s35 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h507529196, i32 0, i32 0
  %t36 = call i8* @sailfin_runtime_string_concat(i8* %t34, i8* %s35)
  %t37 = load i8*, i8** %l3
  %t38 = bitcast i8* %t37 to double*
  %t39 = load double, double* %t38
  %t40 = call i8* @number_to_string(double %t39)
  %t41 = call i8* @sailfin_runtime_string_concat(i8* %t36, i8* %t40)
  store i8* %t41, i8** %l4
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t43 = load i8*, i8** %l4
  %t44 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t42, i8* %t43)
  store { i8**, i64 }* %t44, { i8**, i64 }** %l0
  %t46 = load i8*, i8** %l2
  %t47 = load i8*, i8** %l2
  store double 0.0, double* %l5
  %t48 = add i64 0, 2
  %t49 = call i8* @malloc(i64 %t48)
  store i8 32, i8* %t49
  %t50 = getelementptr i8, i8* %t49, i64 1
  store i8 0, i8* %t50
  call void @sailfin_runtime_mark_persistent(i8* %t49)
  %t51 = call i8* @repeat_character(i8* %t49, double %line_padding)
  store i8* %t51, i8** %l6
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t53 = load i8*, i8** %l6
  %t54 = add i64 0, 2
  %t55 = call i8* @malloc(i64 %t54)
  store i8 32, i8* %t55
  %t56 = getelementptr i8, i8* %t55, i64 1
  store i8 0, i8* %t56
  call void @sailfin_runtime_mark_persistent(i8* %t55)
  %t57 = call i8* @sailfin_runtime_string_concat(i8* %t55, i8* %t53)
  %s58 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193415939, i32 0, i32 0
  %t59 = call i8* @sailfin_runtime_string_concat(i8* %t57, i8* %s58)
  %t60 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t52, i8* %t59)
  store { i8**, i64 }* %t60, { i8**, i64 }** %l0
  %t61 = load i8*, i8** %l2
  %t62 = bitcast i8* %t61 to double*
  %t63 = load double, double* %t62
  %t64 = call i8* @number_to_string(double %t63)
  store i8* %t64, i8** %l7
  %s65 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s65, i8** %l8
  %t66 = load i8*, i8** %l7
  %t67 = call i64 @sailfin_runtime_string_length(i8* %t66)
  %t68 = sitofp i64 %t67 to double
  %t69 = fsub double %line_padding, %t68
  store double %t69, double* %l9
  %t70 = load double, double* %l9
  %t71 = sitofp i64 0 to double
  %t72 = fcmp olt double %t70, %t71
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t74 = load i8*, i8** %l1
  %t75 = load i8*, i8** %l2
  %t76 = load i8*, i8** %l3
  %t77 = load i8*, i8** %l4
  %t78 = load double, double* %l5
  %t79 = load i8*, i8** %l6
  %t80 = load i8*, i8** %l7
  %t81 = load i8*, i8** %l8
  %t82 = load double, double* %l9
  br i1 %t72, label %then2, label %merge3
then2:
  %t83 = sitofp i64 0 to double
  store double %t83, double* %l9
  %t84 = load double, double* %l9
  br label %merge3
merge3:
  %t85 = phi double [ %t84, %then2 ], [ %t82, %merge1 ]
  store double %t85, double* %l9
  %t86 = load double, double* %l9
  %t87 = sitofp i64 0 to double
  %t88 = fcmp ogt double %t86, %t87
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t90 = load i8*, i8** %l1
  %t91 = load i8*, i8** %l2
  %t92 = load i8*, i8** %l3
  %t93 = load i8*, i8** %l4
  %t94 = load double, double* %l5
  %t95 = load i8*, i8** %l6
  %t96 = load i8*, i8** %l7
  %t97 = load i8*, i8** %l8
  %t98 = load double, double* %l9
  br i1 %t88, label %then4, label %merge5
then4:
  %t99 = load double, double* %l9
  %t100 = add i64 0, 2
  %t101 = call i8* @malloc(i64 %t100)
  store i8 32, i8* %t101
  %t102 = getelementptr i8, i8* %t101, i64 1
  store i8 0, i8* %t102
  call void @sailfin_runtime_mark_persistent(i8* %t101)
  %t103 = call i8* @repeat_character(i8* %t101, double %t99)
  store i8* %t103, i8** %l8
  %t104 = load i8*, i8** %l8
  br label %merge5
merge5:
  %t105 = phi i8* [ %t104, %then4 ], [ %t97, %merge3 ]
  store i8* %t105, i8** %l8
  %t106 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t107 = load i8*, i8** %l8
  %t108 = add i64 0, 2
  %t109 = call i8* @malloc(i64 %t108)
  store i8 32, i8* %t109
  %t110 = getelementptr i8, i8* %t109, i64 1
  store i8 0, i8* %t110
  call void @sailfin_runtime_mark_persistent(i8* %t109)
  %t111 = call i8* @sailfin_runtime_string_concat(i8* %t109, i8* %t107)
  %t112 = load i8*, i8** %l7
  %t113 = call i8* @sailfin_runtime_string_concat(i8* %t111, i8* %t112)
  %s114 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087759686, i32 0, i32 0
  %t115 = call i8* @sailfin_runtime_string_concat(i8* %t113, i8* %s114)
  %t116 = load double, double* %l5
  %t117 = load i8*, i8** %l3
  %t118 = load i8*, i8** %l1
  %t119 = getelementptr inbounds [7 x i8], [7 x i8]* @.runtime.field.lexeme, i32 0, i32 0
  %t120 = call i8* @sailfin_runtime_get_field(i8* %t118, i8* %t119)
  %t121 = load double, double* %l5
  %t122 = bitcast i8* %t117 to double*
  %t123 = load double, double* %t122
  %t124 = call i8* @build_pointer_line(double %t123, i8* %t120, i8* null)
  store i8* %t124, i8** %l10
  %t125 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t126 = load i8*, i8** %l6
  %t127 = add i64 0, 2
  %t128 = call i8* @malloc(i64 %t127)
  store i8 32, i8* %t128
  %t129 = getelementptr i8, i8* %t128, i64 1
  store i8 0, i8* %t129
  call void @sailfin_runtime_mark_persistent(i8* %t128)
  %t130 = call i8* @sailfin_runtime_string_concat(i8* %t128, i8* %t126)
  %s131 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087759686, i32 0, i32 0
  %t132 = call i8* @sailfin_runtime_string_concat(i8* %t130, i8* %s131)
  %t133 = load i8*, i8** %l10
  %t134 = call i8* @sailfin_runtime_string_concat(i8* %t132, i8* %t133)
  %t135 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t125, i8* %t134)
  store { i8**, i64 }* %t135, { i8**, i64 }** %l0
  %t136 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t137 = call i8* @join_lines({ i8**, i64 }* %t136)
  call void @sailfin_runtime_mark_persistent(i8* %t137)
  ret i8* %t137
}

define { i8**, i64 }* @split_source_lines(i8* %source) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca i8*
  %l4 = alloca i8*
  %t0 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t1 = ptrtoint [0 x i8*]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to i8**
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t7 = ptrtoint { i8**, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { i8**, i64 }*
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 0
  store i8** %t5, i8*** %t10
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { i8**, i64 }* %t9, { i8**, i64 }** %l0
  %s12 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s12, i8** %l1
  %t13 = sitofp i64 0 to double
  store double %t13, double* %l2
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t15 = load i8*, i8** %l1
  %t16 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t104 = phi { i8**, i64 }* [ %t14, %block.entry ], [ %t101, %loop.latch2 ]
  %t105 = phi i8* [ %t15, %block.entry ], [ %t102, %loop.latch2 ]
  %t106 = phi double [ %t16, %block.entry ], [ %t103, %loop.latch2 ]
  store { i8**, i64 }* %t104, { i8**, i64 }** %l0
  store i8* %t105, i8** %l1
  store double %t106, double* %l2
  br label %loop.body1
loop.body1:
  %t17 = load double, double* %l2
  %t18 = call i64 @sailfin_runtime_string_length(i8* %source)
  %t19 = sitofp i64 %t18 to double
  %t20 = fcmp ogt double %t17, %t19
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t22 = load i8*, i8** %l1
  %t23 = load double, double* %l2
  br i1 %t20, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t24 = load double, double* %l2
  %t25 = load double, double* %l2
  %t26 = sitofp i64 1 to double
  %t27 = fadd double %t25, %t26
  %t28 = call double @llvm.round.f64(double %t24)
  %t29 = fptosi double %t28 to i64
  %t30 = call double @llvm.round.f64(double %t27)
  %t31 = fptosi double %t30 to i64
  %t32 = call i8* @sailfin_runtime_substring(i8* %source, i64 %t29, i64 %t31)
  store i8* %t32, i8** %l3
  %t33 = load i8*, i8** %l3
  %t34 = load i8, i8* %t33
  %t35 = icmp eq i8 %t34, 13
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t37 = load i8*, i8** %l1
  %t38 = load double, double* %l2
  %t39 = load i8*, i8** %l3
  br i1 %t35, label %then6, label %merge7
then6:
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t41 = load i8*, i8** %l1
  %t42 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t40, i8* %t41)
  store { i8**, i64 }* %t42, { i8**, i64 }** %l0
  %s43 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s43, i8** %l1
  %t44 = load double, double* %l2
  %t45 = sitofp i64 1 to double
  %t46 = fadd double %t44, %t45
  %t47 = call i64 @sailfin_runtime_string_length(i8* %source)
  %t48 = sitofp i64 %t47 to double
  %t49 = fcmp olt double %t46, %t48
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t51 = load i8*, i8** %l1
  %t52 = load double, double* %l2
  %t53 = load i8*, i8** %l3
  br i1 %t49, label %then8, label %merge9
then8:
  %t54 = load double, double* %l2
  %t55 = sitofp i64 1 to double
  %t56 = fadd double %t54, %t55
  %t57 = load double, double* %l2
  %t58 = sitofp i64 2 to double
  %t59 = fadd double %t57, %t58
  %t60 = call double @llvm.round.f64(double %t56)
  %t61 = fptosi double %t60 to i64
  %t62 = call double @llvm.round.f64(double %t59)
  %t63 = fptosi double %t62 to i64
  %t64 = call i8* @sailfin_runtime_substring(i8* %source, i64 %t61, i64 %t63)
  store i8* %t64, i8** %l4
  %t65 = load i8*, i8** %l4
  %t66 = load i8, i8* %t65
  %t67 = icmp eq i8 %t66, 10
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t69 = load i8*, i8** %l1
  %t70 = load double, double* %l2
  %t71 = load i8*, i8** %l3
  %t72 = load i8*, i8** %l4
  br i1 %t67, label %then10, label %merge11
then10:
  %t73 = load double, double* %l2
  %t74 = sitofp i64 2 to double
  %t75 = fadd double %t73, %t74
  store double %t75, double* %l2
  br label %loop.latch2
merge11:
  %t76 = load double, double* %l2
  br label %merge9
merge9:
  %t77 = phi double [ %t76, %merge11 ], [ %t52, %then6 ]
  store double %t77, double* %l2
  %t78 = load double, double* %l2
  %t79 = sitofp i64 1 to double
  %t80 = fadd double %t78, %t79
  store double %t80, double* %l2
  br label %loop.latch2
merge7:
  %t81 = load i8*, i8** %l3
  %t82 = load i8, i8* %t81
  %t83 = icmp eq i8 %t82, 10
  %t84 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t85 = load i8*, i8** %l1
  %t86 = load double, double* %l2
  %t87 = load i8*, i8** %l3
  br i1 %t83, label %then12, label %merge13
then12:
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t89 = load i8*, i8** %l1
  %t90 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t88, i8* %t89)
  store { i8**, i64 }* %t90, { i8**, i64 }** %l0
  %s91 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s91, i8** %l1
  %t92 = load double, double* %l2
  %t93 = sitofp i64 1 to double
  %t94 = fadd double %t92, %t93
  store double %t94, double* %l2
  br label %loop.latch2
merge13:
  %t95 = load i8*, i8** %l1
  %t96 = load i8*, i8** %l3
  %t97 = call i8* @sailfin_runtime_string_concat(i8* %t95, i8* %t96)
  store i8* %t97, i8** %l1
  %t98 = load double, double* %l2
  %t99 = sitofp i64 1 to double
  %t100 = fadd double %t98, %t99
  store double %t100, double* %l2
  br label %loop.latch2
loop.latch2:
  %t101 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t102 = load i8*, i8** %l1
  %t103 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t107 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t108 = load i8*, i8** %l1
  %t109 = load double, double* %l2
  %t110 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t111 = load i8*, i8** %l1
  %t112 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t110, i8* %t111)
  store { i8**, i64 }* %t112, { i8**, i64 }** %l0
  %t113 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t113
}

define i8* @build_pointer_line(double %column, i8* %lexeme, i8* %line_text) {
block.entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca i8*
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca double
  %t0 = call i64 @sailfin_runtime_string_length(i8* %line_text)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = add i64 0, 2
  %t3 = call i8* @malloc(i64 %t2)
  store i8 94, i8* %t3
  %t4 = getelementptr i8, i8* %t3, i64 1
  store i8 0, i8* %t4
  call void @sailfin_runtime_mark_persistent(i8* %t3)
  call void @sailfin_runtime_mark_persistent(i8* %t3)
  ret i8* %t3
merge1:
  store double %column, double* %l0
  %t5 = load double, double* %l0
  %t6 = sitofp i64 1 to double
  %t7 = fcmp olt double %t5, %t6
  %t8 = load double, double* %l0
  br i1 %t7, label %then2, label %merge3
then2:
  %t9 = sitofp i64 1 to double
  store double %t9, double* %l0
  %t10 = load double, double* %l0
  br label %merge3
merge3:
  %t11 = phi double [ %t10, %then2 ], [ %t8, %merge1 ]
  store double %t11, double* %l0
  %t12 = load double, double* %l0
  %t13 = call i64 @sailfin_runtime_string_length(i8* %line_text)
  %t14 = sitofp i64 %t13 to double
  %t15 = fcmp ogt double %t12, %t14
  %t16 = load double, double* %l0
  br i1 %t15, label %then4, label %merge5
then4:
  %t17 = call i64 @sailfin_runtime_string_length(i8* %line_text)
  %t18 = sitofp i64 %t17 to double
  store double %t18, double* %l0
  %t19 = load double, double* %l0
  br label %merge5
merge5:
  %t20 = phi double [ %t19, %then4 ], [ %t16, %merge3 ]
  store double %t20, double* %l0
  %s21 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s21, i8** %l1
  %t22 = sitofp i64 1 to double
  store double %t22, double* %l2
  %t23 = load double, double* %l0
  %t24 = load i8*, i8** %l1
  %t25 = load double, double* %l2
  br label %loop.header6
loop.header6:
  %t82 = phi i8* [ %t24, %merge5 ], [ %t80, %loop.latch8 ]
  %t83 = phi double [ %t25, %merge5 ], [ %t81, %loop.latch8 ]
  store i8* %t82, i8** %l1
  store double %t83, double* %l2
  br label %loop.body7
loop.body7:
  %t26 = load double, double* %l2
  %t27 = load double, double* %l0
  %t28 = fcmp ogt double %t26, %t27
  %t29 = load double, double* %l0
  %t30 = load i8*, i8** %l1
  %t31 = load double, double* %l2
  br i1 %t28, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t32 = load double, double* %l2
  %t33 = call i64 @sailfin_runtime_string_length(i8* %line_text)
  %t34 = sitofp i64 %t33 to double
  %t35 = fcmp olt double %t32, %t34
  %t36 = load double, double* %l0
  %t37 = load i8*, i8** %l1
  %t38 = load double, double* %l2
  br i1 %t35, label %then12, label %else13
then12:
  %t39 = load double, double* %l2
  %t40 = sitofp i64 1 to double
  %t41 = fsub double %t39, %t40
  %t42 = load double, double* %l2
  %t43 = call double @llvm.round.f64(double %t41)
  %t44 = fptosi double %t43 to i64
  %t45 = call double @llvm.round.f64(double %t42)
  %t46 = fptosi double %t45 to i64
  %t47 = call i8* @sailfin_runtime_substring(i8* %line_text, i64 %t44, i64 %t46)
  store i8* %t47, i8** %l3
  %t48 = load i8*, i8** %l3
  %t49 = load i8, i8* %t48
  %t50 = icmp eq i8 %t49, 9
  %t51 = load double, double* %l0
  %t52 = load i8*, i8** %l1
  %t53 = load double, double* %l2
  %t54 = load i8*, i8** %l3
  br i1 %t50, label %then15, label %else16
then15:
  %t55 = load i8*, i8** %l1
  %t56 = add i64 0, 2
  %t57 = call i8* @malloc(i64 %t56)
  store i8 9, i8* %t57
  %t58 = getelementptr i8, i8* %t57, i64 1
  store i8 0, i8* %t58
  call void @sailfin_runtime_mark_persistent(i8* %t57)
  %t59 = call i8* @sailfin_runtime_string_concat(i8* %t55, i8* %t57)
  store i8* %t59, i8** %l1
  %t60 = load i8*, i8** %l1
  br label %merge17
else16:
  %t61 = load i8*, i8** %l1
  %t62 = add i64 0, 2
  %t63 = call i8* @malloc(i64 %t62)
  store i8 32, i8* %t63
  %t64 = getelementptr i8, i8* %t63, i64 1
  store i8 0, i8* %t64
  call void @sailfin_runtime_mark_persistent(i8* %t63)
  %t65 = call i8* @sailfin_runtime_string_concat(i8* %t61, i8* %t63)
  store i8* %t65, i8** %l1
  %t66 = load i8*, i8** %l1
  br label %merge17
merge17:
  %t67 = phi i8* [ %t60, %then15 ], [ %t66, %else16 ]
  store i8* %t67, i8** %l1
  %t68 = load i8*, i8** %l1
  %t69 = load i8*, i8** %l1
  br label %merge14
else13:
  %t70 = load i8*, i8** %l1
  %t71 = add i64 0, 2
  %t72 = call i8* @malloc(i64 %t71)
  store i8 32, i8* %t72
  %t73 = getelementptr i8, i8* %t72, i64 1
  store i8 0, i8* %t73
  call void @sailfin_runtime_mark_persistent(i8* %t72)
  %t74 = call i8* @sailfin_runtime_string_concat(i8* %t70, i8* %t72)
  store i8* %t74, i8** %l1
  %t75 = load i8*, i8** %l1
  br label %merge14
merge14:
  %t76 = phi i8* [ %t68, %merge17 ], [ %t75, %else13 ]
  store i8* %t76, i8** %l1
  %t77 = load double, double* %l2
  %t78 = sitofp i64 1 to double
  %t79 = fadd double %t77, %t78
  store double %t79, double* %l2
  br label %loop.latch8
loop.latch8:
  %t80 = load i8*, i8** %l1
  %t81 = load double, double* %l2
  br label %loop.header6
afterloop9:
  %t84 = load i8*, i8** %l1
  %t85 = load double, double* %l2
  %t86 = call i64 @sailfin_runtime_string_length(i8* %lexeme)
  %t87 = sitofp i64 %t86 to double
  store double %t87, double* %l4
  %t88 = load double, double* %l4
  %t89 = sitofp i64 0 to double
  %t90 = fcmp olt double %t88, %t89
  %t91 = load double, double* %l0
  %t92 = load i8*, i8** %l1
  %t93 = load double, double* %l2
  %t94 = load double, double* %l4
  br i1 %t90, label %then18, label %merge19
then18:
  %t95 = sitofp i64 1 to double
  store double %t95, double* %l4
  %t96 = load double, double* %l4
  br label %merge19
merge19:
  %t97 = phi double [ %t96, %then18 ], [ %t94, %afterloop9 ]
  store double %t97, double* %l4
  %t98 = call i64 @sailfin_runtime_string_length(i8* %line_text)
  %t99 = load double, double* %l0
  %t100 = sitofp i64 1 to double
  %t101 = fsub double %t99, %t100
  %t102 = sitofp i64 %t98 to double
  %t103 = fsub double %t102, %t101
  store double %t103, double* %l5
  %t104 = load double, double* %l5
  %t105 = sitofp i64 0 to double
  %t106 = fcmp olt double %t104, %t105
  %t107 = load double, double* %l0
  %t108 = load i8*, i8** %l1
  %t109 = load double, double* %l2
  %t110 = load double, double* %l4
  %t111 = load double, double* %l5
  br i1 %t106, label %then20, label %merge21
then20:
  %t112 = sitofp i64 1 to double
  store double %t112, double* %l5
  %t113 = load double, double* %l5
  br label %merge21
merge21:
  %t114 = phi double [ %t113, %then20 ], [ %t111, %merge19 ]
  store double %t114, double* %l5
  %t115 = load double, double* %l4
  %t116 = load double, double* %l5
  %t117 = fcmp ogt double %t115, %t116
  %t118 = load double, double* %l0
  %t119 = load i8*, i8** %l1
  %t120 = load double, double* %l2
  %t121 = load double, double* %l4
  %t122 = load double, double* %l5
  br i1 %t117, label %then22, label %merge23
then22:
  %t123 = load double, double* %l5
  store double %t123, double* %l4
  %t124 = load double, double* %l4
  br label %merge23
merge23:
  %t125 = phi double [ %t124, %then22 ], [ %t121, %merge21 ]
  store double %t125, double* %l4
  %t126 = sitofp i64 0 to double
  store double %t126, double* %l6
  %t127 = load double, double* %l0
  %t128 = load i8*, i8** %l1
  %t129 = load double, double* %l2
  %t130 = load double, double* %l4
  %t131 = load double, double* %l5
  %t132 = load double, double* %l6
  br label %loop.header24
loop.header24:
  %t152 = phi i8* [ %t128, %merge23 ], [ %t150, %loop.latch26 ]
  %t153 = phi double [ %t132, %merge23 ], [ %t151, %loop.latch26 ]
  store i8* %t152, i8** %l1
  store double %t153, double* %l6
  br label %loop.body25
loop.body25:
  %t133 = load double, double* %l6
  %t134 = load double, double* %l4
  %t135 = fcmp ogt double %t133, %t134
  %t136 = load double, double* %l0
  %t137 = load i8*, i8** %l1
  %t138 = load double, double* %l2
  %t139 = load double, double* %l4
  %t140 = load double, double* %l5
  %t141 = load double, double* %l6
  br i1 %t135, label %then28, label %merge29
then28:
  br label %afterloop27
merge29:
  %t142 = load i8*, i8** %l1
  %t143 = add i64 0, 2
  %t144 = call i8* @malloc(i64 %t143)
  store i8 94, i8* %t144
  %t145 = getelementptr i8, i8* %t144, i64 1
  store i8 0, i8* %t145
  call void @sailfin_runtime_mark_persistent(i8* %t144)
  %t146 = call i8* @sailfin_runtime_string_concat(i8* %t142, i8* %t144)
  store i8* %t146, i8** %l1
  %t147 = load double, double* %l6
  %t148 = sitofp i64 1 to double
  %t149 = fadd double %t147, %t148
  store double %t149, double* %l6
  br label %loop.latch26
loop.latch26:
  %t150 = load i8*, i8** %l1
  %t151 = load double, double* %l6
  br label %loop.header24
afterloop27:
  %t154 = load i8*, i8** %l1
  %t155 = load double, double* %l6
  %t156 = load i8*, i8** %l1
  call void @sailfin_runtime_mark_persistent(i8* %t156)
  ret i8* %t156
}

define i8* @join_lines({ i8**, i64 }* %lines) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %t0 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t1 = extractvalue { i8**, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %s3)
  ret i8* %s3
merge1:
  %t4 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t5 = extractvalue { i8**, i64 } %t4, 0
  %t6 = extractvalue { i8**, i64 } %t4, 1
  %t7 = icmp uge i64 0, %t6
  ; bounds check: %t7 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 0, i64 %t6)
  %t8 = getelementptr i8*, i8** %t5, i64 0
  %t9 = load i8*, i8** %t8
  store i8* %t9, i8** %l0
  %t10 = sitofp i64 1 to double
  store double %t10, double* %l1
  %t11 = load i8*, i8** %l0
  %t12 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t40 = phi i8* [ %t11, %merge1 ], [ %t38, %loop.latch4 ]
  %t41 = phi double [ %t12, %merge1 ], [ %t39, %loop.latch4 ]
  store i8* %t40, i8** %l0
  store double %t41, double* %l1
  br label %loop.body3
loop.body3:
  %t13 = load double, double* %l1
  %t14 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t15 = extractvalue { i8**, i64 } %t14, 1
  %t16 = sitofp i64 %t15 to double
  %t17 = fcmp ogt double %t13, %t16
  %t18 = load i8*, i8** %l0
  %t19 = load double, double* %l1
  br i1 %t17, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t20 = load i8*, i8** %l0
  %t21 = add i64 0, 2
  %t22 = call i8* @malloc(i64 %t21)
  store i8 10, i8* %t22
  %t23 = getelementptr i8, i8* %t22, i64 1
  store i8 0, i8* %t23
  call void @sailfin_runtime_mark_persistent(i8* %t22)
  %t24 = call i8* @sailfin_runtime_string_concat(i8* %t20, i8* %t22)
  %t25 = load double, double* %l1
  %t26 = call double @llvm.round.f64(double %t25)
  %t27 = fptosi double %t26 to i64
  %t28 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t29 = extractvalue { i8**, i64 } %t28, 0
  %t30 = extractvalue { i8**, i64 } %t28, 1
  %t31 = icmp uge i64 %t27, %t30
  ; bounds check: %t31 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t27, i64 %t30)
  %t32 = getelementptr i8*, i8** %t29, i64 %t27
  %t33 = load i8*, i8** %t32
  %t34 = call i8* @sailfin_runtime_string_concat(i8* %t24, i8* %t33)
  store i8* %t34, i8** %l0
  %t35 = load double, double* %l1
  %t36 = sitofp i64 1 to double
  %t37 = fadd double %t35, %t36
  store double %t37, double* %l1
  br label %loop.latch4
loop.latch4:
  %t38 = load i8*, i8** %l0
  %t39 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t42 = load i8*, i8** %l0
  %t43 = load double, double* %l1
  %t44 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t44)
  ret i8* %t44
}

define { i8**, i64 }* @append_string({ i8**, i64 }* %values, i8* %value) {
block.entry:
  %t0 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t1 = ptrtoint [1 x i8*]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to i8**
  %t6 = getelementptr i8*, i8** %t5, i64 0
  store i8* %value, i8** %t6
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t8 = ptrtoint { i8**, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { i8**, i64 }*
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 0
  store i8** %t5, i8*** %t11
  %t12 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 1
  store i64 1, i64* %t12
  %t13 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %values, { i8**, i64 }* %t10)
  ret { i8**, i64 }* %t13
}

define i8* @number_to_string(double %value) {
block.entry:
  %l0 = alloca double
  %l1 = alloca i1
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca i8*
  %t0 = sitofp i64 0 to double
  %t1 = fcmp oeq double %value, %t0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = add i64 0, 2
  %t3 = call i8* @malloc(i64 %t2)
  store i8 48, i8* %t3
  %t4 = getelementptr i8, i8* %t3, i64 1
  store i8 0, i8* %t4
  call void @sailfin_runtime_mark_persistent(i8* %t3)
  call void @sailfin_runtime_mark_persistent(i8* %t3)
  ret i8* %t3
merge1:
  store double %value, double* %l0
  store i1 0, i1* %l1
  %t5 = load double, double* %l0
  %t6 = sitofp i64 0 to double
  %t7 = fcmp olt double %t5, %t6
  %t8 = load double, double* %l0
  %t9 = load i1, i1* %l1
  br i1 %t7, label %then2, label %merge3
then2:
  store i1 1, i1* %l1
  %t10 = load double, double* %l0
  %t11 = sitofp i64 0 to double
  %t12 = fsub double %t11, %t10
  store double %t12, double* %l0
  %t13 = load i1, i1* %l1
  %t14 = load double, double* %l0
  br label %merge3
merge3:
  %t15 = phi i1 [ %t13, %then2 ], [ %t9, %merge1 ]
  %t16 = phi double [ %t14, %then2 ], [ %t8, %merge1 ]
  store i1 %t15, i1* %l1
  store double %t16, double* %l0
  %s17 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h626550212, i32 0, i32 0
  store i8* %s17, i8** %l2
  %t18 = load double, double* %l0
  store double %t18, double* %l3
  %s19 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s19, i8** %l4
  %t20 = load double, double* %l0
  %t21 = load i1, i1* %l1
  %t22 = load i8*, i8** %l2
  %t23 = load double, double* %l3
  %t24 = load i8*, i8** %l4
  br label %loop.header4
loop.header4:
  %t80 = phi i8* [ %t24, %merge3 ], [ %t78, %loop.latch6 ]
  %t81 = phi double [ %t23, %merge3 ], [ %t79, %loop.latch6 ]
  store i8* %t80, i8** %l4
  store double %t81, double* %l3
  br label %loop.body5
loop.body5:
  %t25 = load double, double* %l3
  %t26 = sitofp i64 0 to double
  %t27 = fcmp olt double %t25, %t26
  %t28 = load double, double* %l0
  %t29 = load i1, i1* %l1
  %t30 = load i8*, i8** %l2
  %t31 = load double, double* %l3
  %t32 = load i8*, i8** %l4
  br i1 %t27, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t33 = load double, double* %l3
  store double %t33, double* %l5
  %t34 = sitofp i64 0 to double
  store double %t34, double* %l6
  %t35 = load double, double* %l0
  %t36 = load i1, i1* %l1
  %t37 = load i8*, i8** %l2
  %t38 = load double, double* %l3
  %t39 = load i8*, i8** %l4
  %t40 = load double, double* %l5
  %t41 = load double, double* %l6
  br label %loop.header10
loop.header10:
  %t60 = phi double [ %t40, %merge9 ], [ %t58, %loop.latch12 ]
  %t61 = phi double [ %t41, %merge9 ], [ %t59, %loop.latch12 ]
  store double %t60, double* %l5
  store double %t61, double* %l6
  br label %loop.body11
loop.body11:
  %t42 = load double, double* %l5
  %t43 = sitofp i64 10 to double
  %t44 = fcmp olt double %t42, %t43
  %t45 = load double, double* %l0
  %t46 = load i1, i1* %l1
  %t47 = load i8*, i8** %l2
  %t48 = load double, double* %l3
  %t49 = load i8*, i8** %l4
  %t50 = load double, double* %l5
  %t51 = load double, double* %l6
  br i1 %t44, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t52 = load double, double* %l5
  %t53 = sitofp i64 10 to double
  %t54 = fsub double %t52, %t53
  store double %t54, double* %l5
  %t55 = load double, double* %l6
  %t56 = sitofp i64 1 to double
  %t57 = fadd double %t55, %t56
  store double %t57, double* %l6
  br label %loop.latch12
loop.latch12:
  %t58 = load double, double* %l5
  %t59 = load double, double* %l6
  br label %loop.header10
afterloop13:
  %t62 = load double, double* %l5
  %t63 = load double, double* %l6
  %t64 = load i8*, i8** %l2
  %t65 = load double, double* %l5
  %t66 = load double, double* %l5
  %t67 = sitofp i64 1 to double
  %t68 = fadd double %t66, %t67
  %t69 = call double @llvm.round.f64(double %t65)
  %t70 = fptosi double %t69 to i64
  %t71 = call double @llvm.round.f64(double %t68)
  %t72 = fptosi double %t71 to i64
  %t73 = call i8* @sailfin_runtime_substring(i8* %t64, i64 %t70, i64 %t72)
  store i8* %t73, i8** %l7
  %t74 = load i8*, i8** %l7
  %t75 = load i8*, i8** %l4
  %t76 = call i8* @sailfin_runtime_string_concat(i8* %t74, i8* %t75)
  store i8* %t76, i8** %l4
  %t77 = load double, double* %l6
  store double %t77, double* %l3
  br label %loop.latch6
loop.latch6:
  %t78 = load i8*, i8** %l4
  %t79 = load double, double* %l3
  br label %loop.header4
afterloop7:
  %t82 = load i8*, i8** %l4
  %t83 = load double, double* %l3
  %t84 = load i1, i1* %l1
  %t85 = load double, double* %l0
  %t86 = load i1, i1* %l1
  %t87 = load i8*, i8** %l2
  %t88 = load double, double* %l3
  %t89 = load i8*, i8** %l4
  br i1 %t84, label %then16, label %merge17
then16:
  %t90 = load i8*, i8** %l4
  %t91 = add i64 0, 2
  %t92 = call i8* @malloc(i64 %t91)
  store i8 45, i8* %t92
  %t93 = getelementptr i8, i8* %t92, i64 1
  store i8 0, i8* %t93
  call void @sailfin_runtime_mark_persistent(i8* %t92)
  %t94 = call i8* @sailfin_runtime_string_concat(i8* %t92, i8* %t90)
  store i8* %t94, i8** %l4
  %t95 = load i8*, i8** %l4
  br label %merge17
merge17:
  %t96 = phi i8* [ %t95, %then16 ], [ %t89, %afterloop7 ]
  store i8* %t96, i8** %l4
  %t97 = load i8*, i8** %l4
  call void @sailfin_runtime_mark_persistent(i8* %t97)
  ret i8* %t97
}

define i8* @empty_native_module() {
block.entry:
  ret i8* null
}

define i1 @has_prefix(i8* %value, i8* %prefix) {
block.entry:
  %l0 = alloca double
  %t0 = call i64 @sailfin_runtime_string_length(i8* %prefix)
  %t1 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t2 = icmp sgt i64 %t0, %t1
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
  %t6 = call i64 @sailfin_runtime_string_length(i8* %prefix)
  %t7 = sitofp i64 %t6 to double
  %t8 = fcmp ogt double %t5, %t7
  %t9 = load double, double* %l0
  br i1 %t8, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t10 = load double, double* %l0
  %t11 = call double @llvm.round.f64(double %t10)
  %t12 = fptosi double %t11 to i64
  %t13 = getelementptr i8, i8* %value, i64 %t12
  %t14 = load i8, i8* %t13
  %t15 = load double, double* %l0
  %t16 = call double @llvm.round.f64(double %t15)
  %t17 = fptosi double %t16 to i64
  %t18 = getelementptr i8, i8* %prefix, i64 %t17
  %t19 = load i8, i8* %t18
  %t20 = icmp ne i8 %t14, %t19
  %t21 = load double, double* %l0
  br i1 %t20, label %then8, label %merge9
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

define i1 @needs_python_fallback(i8* %source) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca i8*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %source)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %t2 = call i8* @strip_needs_python_fallback_literals(i8* %source)
  store i8* %t2, i8** %l0
  %t3 = load i8*, i8** %l0
  %t4 = call i8* @strip_python_string_literals(i8* %t3)
  store i8* %t4, i8** %l1
  %t5 = load i8*, i8** %l1
  store i8* %t5, i8** %l2
  %t6 = load i8*, i8** %l2
  %t7 = call i64 @sailfin_runtime_string_length(i8* %t6)
  %t8 = icmp eq i64 %t7, 0
  %t9 = load i8*, i8** %l0
  %t10 = load i8*, i8** %l1
  %t11 = load i8*, i8** %l2
  br i1 %t8, label %then2, label %merge3
then2:
  %t12 = load i8*, i8** %l0
  store i8* %t12, i8** %l2
  %t13 = load i8*, i8** %l2
  br label %merge3
merge3:
  %t14 = phi i8* [ %t13, %then2 ], [ %t11, %merge1 ]
  store i8* %t14, i8** %l2
  %t15 = load i8*, i8** %l2
  store i8* %t15, i8** %l3
  %t16 = load i8*, i8** %l3
  %t17 = call i64 @sailfin_runtime_string_length(i8* %t16)
  %t18 = icmp eq i64 %t17, 0
  %t19 = load i8*, i8** %l0
  %t20 = load i8*, i8** %l1
  %t21 = load i8*, i8** %l2
  %t22 = load i8*, i8** %l3
  br i1 %t18, label %then4, label %merge5
then4:
  ret i1 1
merge5:
  %t23 = load i8*, i8** %l3
  %s24 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h655249917, i32 0, i32 0
  %t25 = call i1 @string_contains(i8* %t23, i8* %s24)
  %t26 = load i8*, i8** %l0
  %t27 = load i8*, i8** %l1
  %t28 = load i8*, i8** %l2
  %t29 = load i8*, i8** %l3
  br i1 %t25, label %then6, label %merge7
then6:
  ret i1 1
merge7:
  %t30 = load i8*, i8** %l3
  %s31 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1516228563, i32 0, i32 0
  %t32 = call i1 @string_contains(i8* %t30, i8* %s31)
  %t33 = load i8*, i8** %l0
  %t34 = load i8*, i8** %l1
  %t35 = load i8*, i8** %l2
  %t36 = load i8*, i8** %l3
  br i1 %t32, label %then8, label %merge9
then8:
  ret i1 1
merge9:
  %t37 = load i8*, i8** %l3
  %s38 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1517989476, i32 0, i32 0
  %t39 = call i1 @string_contains(i8* %t37, i8* %s38)
  %t40 = load i8*, i8** %l0
  %t41 = load i8*, i8** %l1
  %t42 = load i8*, i8** %l2
  %t43 = load i8*, i8** %l3
  br i1 %t39, label %then10, label %merge11
then10:
  ret i1 1
merge11:
  %t44 = load i8*, i8** %l3
  %s45 = getelementptr inbounds [36 x i8], [36 x i8]* @.str.len35.h1158922578, i32 0, i32 0
  %t46 = call i1 @string_contains(i8* %t44, i8* %s45)
  %t47 = load i8*, i8** %l0
  %t48 = load i8*, i8** %l1
  %t49 = load i8*, i8** %l2
  %t50 = load i8*, i8** %l3
  br i1 %t46, label %then12, label %merge13
then12:
  ret i1 1
merge13:
  %t51 = load i8*, i8** %l3
  %s52 = getelementptr inbounds [39 x i8], [39 x i8]* @.str.len38.h675779786, i32 0, i32 0
  %t53 = call i1 @string_contains(i8* %t51, i8* %s52)
  %t54 = load i8*, i8** %l0
  %t55 = load i8*, i8** %l1
  %t56 = load i8*, i8** %l2
  %t57 = load i8*, i8** %l3
  br i1 %t53, label %then14, label %merge15
then14:
  ret i1 1
merge15:
  %t58 = load i8*, i8** %l3
  %s59 = getelementptr inbounds [39 x i8], [39 x i8]* @.str.len38.h1073483005, i32 0, i32 0
  %t60 = call i1 @string_contains(i8* %t58, i8* %s59)
  %t61 = load i8*, i8** %l0
  %t62 = load i8*, i8** %l1
  %t63 = load i8*, i8** %l2
  %t64 = load i8*, i8** %l3
  br i1 %t60, label %then16, label %merge17
then16:
  ret i1 1
merge17:
  %t65 = load i8*, i8** %l3
  %s66 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.len39.h459555839, i32 0, i32 0
  %t67 = call i1 @string_contains(i8* %t65, i8* %s66)
  %t68 = load i8*, i8** %l0
  %t69 = load i8*, i8** %l1
  %t70 = load i8*, i8** %l2
  %t71 = load i8*, i8** %l3
  br i1 %t67, label %then18, label %merge19
then18:
  ret i1 1
merge19:
  %t72 = load i8*, i8** %l3
  %s73 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.len31.h76517386, i32 0, i32 0
  %t74 = call i1 @string_contains(i8* %t72, i8* %s73)
  %t75 = load i8*, i8** %l0
  %t76 = load i8*, i8** %l1
  %t77 = load i8*, i8** %l2
  %t78 = load i8*, i8** %l3
  br i1 %t74, label %then20, label %merge21
then20:
  ret i1 1
merge21:
  %t79 = load i8*, i8** %l3
  %s80 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.len23.h2110906862, i32 0, i32 0
  %t81 = call i1 @string_contains(i8* %t79, i8* %s80)
  %t82 = load i8*, i8** %l0
  %t83 = load i8*, i8** %l1
  %t84 = load i8*, i8** %l2
  %t85 = load i8*, i8** %l3
  br i1 %t81, label %then22, label %merge23
then22:
  ret i1 1
merge23:
  %t86 = load i8*, i8** %l3
  %s87 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.len16.h1337894058, i32 0, i32 0
  %t88 = call i1 @string_contains(i8* %t86, i8* %s87)
  %t89 = load i8*, i8** %l0
  %t90 = load i8*, i8** %l1
  %t91 = load i8*, i8** %l2
  %t92 = load i8*, i8** %l3
  br i1 %t88, label %then24, label %merge25
then24:
  ret i1 1
merge25:
  %t93 = load i8*, i8** %l3
  %s94 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.len21.h1300292754, i32 0, i32 0
  %t95 = call i1 @string_contains(i8* %t93, i8* %s94)
  %t96 = load i8*, i8** %l0
  %t97 = load i8*, i8** %l1
  %t98 = load i8*, i8** %l2
  %t99 = load i8*, i8** %l3
  br i1 %t95, label %then26, label %merge27
then26:
  ret i1 1
merge27:
  %t100 = load i8*, i8** %l3
  %s101 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h129277126, i32 0, i32 0
  %t102 = call i1 @string_contains(i8* %t100, i8* %s101)
  %t103 = load i8*, i8** %l0
  %t104 = load i8*, i8** %l1
  %t105 = load i8*, i8** %l2
  %t106 = load i8*, i8** %l3
  br i1 %t102, label %then28, label %merge29
then28:
  ret i1 1
merge29:
  ret i1 0
}

define i1 @string_contains(i8* %value, i8* %pattern) {
block.entry:
  %l0 = alloca double
  %l1 = alloca i1
  %l2 = alloca double
  %t0 = call i64 @sailfin_runtime_string_length(i8* %pattern)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %t2 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t3 = call i64 @sailfin_runtime_string_length(i8* %pattern)
  %t4 = icmp slt i64 %t2, %t3
  br i1 %t4, label %then2, label %merge3
then2:
  ret i1 0
merge3:
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l0
  %t6 = load double, double* %l0
  br label %loop.header4
loop.header4:
  %t59 = phi double [ %t6, %merge3 ], [ %t58, %loop.latch6 ]
  store double %t59, double* %l0
  br label %loop.body5
loop.body5:
  %t7 = load double, double* %l0
  %t8 = call i64 @sailfin_runtime_string_length(i8* %pattern)
  %t9 = sitofp i64 %t8 to double
  %t10 = fadd double %t7, %t9
  %t11 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t12 = sitofp i64 %t11 to double
  %t13 = fcmp ogt double %t10, %t12
  %t14 = load double, double* %l0
  br i1 %t13, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  store i1 1, i1* %l1
  %t15 = sitofp i64 0 to double
  store double %t15, double* %l2
  %t16 = load double, double* %l0
  %t17 = load i1, i1* %l1
  %t18 = load double, double* %l2
  br label %loop.header10
loop.header10:
  %t47 = phi i1 [ %t17, %merge9 ], [ %t45, %loop.latch12 ]
  %t48 = phi double [ %t18, %merge9 ], [ %t46, %loop.latch12 ]
  store i1 %t47, i1* %l1
  store double %t48, double* %l2
  br label %loop.body11
loop.body11:
  %t19 = load double, double* %l2
  %t20 = call i64 @sailfin_runtime_string_length(i8* %pattern)
  %t21 = sitofp i64 %t20 to double
  %t22 = fcmp ogt double %t19, %t21
  %t23 = load double, double* %l0
  %t24 = load i1, i1* %l1
  %t25 = load double, double* %l2
  br i1 %t22, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t26 = load double, double* %l0
  %t27 = load double, double* %l2
  %t28 = fadd double %t26, %t27
  %t29 = call double @llvm.round.f64(double %t28)
  %t30 = fptosi double %t29 to i64
  %t31 = getelementptr i8, i8* %value, i64 %t30
  %t32 = load i8, i8* %t31
  %t33 = load double, double* %l2
  %t34 = call double @llvm.round.f64(double %t33)
  %t35 = fptosi double %t34 to i64
  %t36 = getelementptr i8, i8* %pattern, i64 %t35
  %t37 = load i8, i8* %t36
  %t38 = icmp ne i8 %t32, %t37
  %t39 = load double, double* %l0
  %t40 = load i1, i1* %l1
  %t41 = load double, double* %l2
  br i1 %t38, label %then16, label %merge17
then16:
  store i1 0, i1* %l1
  br label %afterloop13
merge17:
  %t42 = load double, double* %l2
  %t43 = sitofp i64 1 to double
  %t44 = fadd double %t42, %t43
  store double %t44, double* %l2
  br label %loop.latch12
loop.latch12:
  %t45 = load i1, i1* %l1
  %t46 = load double, double* %l2
  br label %loop.header10
afterloop13:
  %t49 = load i1, i1* %l1
  %t50 = load double, double* %l2
  %t51 = load i1, i1* %l1
  %t52 = load double, double* %l0
  %t53 = load i1, i1* %l1
  %t54 = load double, double* %l2
  br i1 %t51, label %then18, label %merge19
then18:
  ret i1 1
merge19:
  %t55 = load double, double* %l0
  %t56 = sitofp i64 1 to double
  %t57 = fadd double %t55, %t56
  store double %t57, double* %l0
  br label %loop.latch6
loop.latch6:
  %t58 = load double, double* %l0
  br label %loop.header4
afterloop7:
  %t60 = load double, double* %l0
  ret i1 0
}

define i8* @strip_needs_python_fallback_literals(i8* %source) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca i8*
  %l6 = alloca i8*
  %s0 = getelementptr inbounds [26 x i8], [26 x i8]* @.str.len25.h111080155, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call double @find_substring(i8* %source, i8* %t1)
  store double %t2, double* %l1
  %t3 = load double, double* %l1
  %t4 = sitofp i64 0 to double
  %t5 = fcmp olt double %t3, %t4
  %t6 = load i8*, i8** %l0
  %t7 = load double, double* %l1
  br i1 %t5, label %then0, label %merge1
then0:
  call void @sailfin_runtime_mark_persistent(i8* %source)
  ret i8* %source
merge1:
  %s8 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h1175821684, i32 0, i32 0
  store i8* %s8, i8** %l2
  %t9 = load i8*, i8** %l2
  %t10 = load double, double* %l1
  %t11 = call double @find_substring_from(i8* %source, i8* %t9, double %t10)
  store double %t11, double* %l3
  %t12 = load double, double* %l3
  %t13 = sitofp i64 0 to double
  %t14 = fcmp olt double %t12, %t13
  %t15 = load i8*, i8** %l0
  %t16 = load double, double* %l1
  %t17 = load i8*, i8** %l2
  %t18 = load double, double* %l3
  br i1 %t14, label %then2, label %merge3
then2:
  call void @sailfin_runtime_mark_persistent(i8* %source)
  ret i8* %source
merge3:
  %t19 = load double, double* %l3
  %t20 = load i8*, i8** %l2
  %t21 = call i64 @sailfin_runtime_string_length(i8* %t20)
  %t22 = sitofp i64 %t21 to double
  %t23 = fadd double %t19, %t22
  store double %t23, double* %l4
  %t24 = load double, double* %l4
  %t25 = call double @advance_to_line_end(i8* %source, double %t24)
  store double %t25, double* %l4
  %t26 = load double, double* %l1
  %t27 = call double @llvm.round.f64(double %t26)
  %t28 = fptosi double %t27 to i64
  %t29 = call i8* @sailfin_runtime_substring(i8* %source, i64 0, i64 %t28)
  store i8* %t29, i8** %l5
  %t30 = load double, double* %l4
  %t31 = call i64 @sailfin_runtime_string_length(i8* %source)
  %t32 = call double @llvm.round.f64(double %t30)
  %t33 = fptosi double %t32 to i64
  %t34 = call i8* @sailfin_runtime_substring(i8* %source, i64 %t33, i64 %t31)
  store i8* %t34, i8** %l6
  %t35 = load i8*, i8** %l5
  %t36 = load i8*, i8** %l6
  %t37 = call i8* @sailfin_runtime_string_concat(i8* %t35, i8* %t36)
  call void @sailfin_runtime_mark_persistent(i8* %t37)
  ret i8* %t37
}

define i8* @strip_python_string_literals(i8* %value) {
block.entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca double
  %l6 = alloca i8*
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %s1 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s1, i8** %l1
  %t2 = load double, double* %l0
  %t3 = load i8*, i8** %l1
  br label %loop.header0
loop.header0:
  %t87 = phi i8* [ %t3, %block.entry ], [ %t85, %loop.latch2 ]
  %t88 = phi double [ %t2, %block.entry ], [ %t86, %loop.latch2 ]
  store i8* %t87, i8** %l1
  store double %t88, double* %l0
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l0
  %t5 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp ogt double %t4, %t6
  %t8 = load double, double* %l0
  %t9 = load i8*, i8** %l1
  br i1 %t7, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t10 = load double, double* %l0
  %t11 = load double, double* %l0
  %t12 = sitofp i64 1 to double
  %t13 = fadd double %t11, %t12
  %t14 = call double @llvm.round.f64(double %t10)
  %t15 = fptosi double %t14 to i64
  %t16 = call double @llvm.round.f64(double %t13)
  %t17 = fptosi double %t16 to i64
  %t18 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t15, i64 %t17)
  store i8* %t18, i8** %l2
  %t19 = load i8*, i8** %l2
  %t20 = load i8, i8* %t19
  %t21 = icmp eq i8 %t20, 39
  %t22 = load double, double* %l0
  %t23 = load i8*, i8** %l1
  %t24 = load i8*, i8** %l2
  br i1 %t21, label %then6, label %merge7
then6:
  %t25 = load double, double* %l0
  %t26 = add i64 0, 2
  %t27 = call i8* @malloc(i64 %t26)
  store i8 39, i8* %t27
  %t28 = getelementptr i8, i8* %t27, i64 1
  store i8 0, i8* %t28
  call void @sailfin_runtime_mark_persistent(i8* %t27)
  %t29 = call double @python_quote_length(i8* %value, double %t25, i8* %t27)
  store double %t29, double* %l3
  %t30 = load double, double* %l3
  %t31 = add i64 0, 2
  %t32 = call i8* @malloc(i64 %t31)
  store i8 39, i8* %t32
  %t33 = getelementptr i8, i8* %t32, i64 1
  store i8 0, i8* %t33
  call void @sailfin_runtime_mark_persistent(i8* %t32)
  %t34 = call i8* @repeat_character(i8* %t32, double %t30)
  store i8* %t34, i8** %l4
  %t35 = load i8*, i8** %l1
  %t36 = load i8*, i8** %l4
  %t37 = call i8* @sailfin_runtime_string_concat(i8* %t35, i8* %t36)
  store i8* %t37, i8** %l1
  %t38 = load double, double* %l0
  %t39 = load double, double* %l3
  %t40 = fadd double %t38, %t39
  %t41 = load double, double* %l3
  %t42 = add i64 0, 2
  %t43 = call i8* @malloc(i64 %t42)
  store i8 39, i8* %t43
  %t44 = getelementptr i8, i8* %t43, i64 1
  store i8 0, i8* %t44
  call void @sailfin_runtime_mark_persistent(i8* %t43)
  %t45 = call double @skip_python_string_literal(i8* %value, double %t40, i8* %t43, double %t41)
  store double %t45, double* %l0
  %t46 = load i8*, i8** %l1
  %t47 = load i8*, i8** %l4
  %t48 = call i8* @sailfin_runtime_string_concat(i8* %t46, i8* %t47)
  store i8* %t48, i8** %l1
  br label %loop.latch2
merge7:
  %t49 = load i8*, i8** %l2
  %t50 = load i8, i8* %t49
  %t51 = icmp eq i8 %t50, 34
  %t52 = load double, double* %l0
  %t53 = load i8*, i8** %l1
  %t54 = load i8*, i8** %l2
  br i1 %t51, label %then8, label %merge9
then8:
  %t55 = load double, double* %l0
  %t56 = add i64 0, 2
  %t57 = call i8* @malloc(i64 %t56)
  store i8 34, i8* %t57
  %t58 = getelementptr i8, i8* %t57, i64 1
  store i8 0, i8* %t58
  call void @sailfin_runtime_mark_persistent(i8* %t57)
  %t59 = call double @python_quote_length(i8* %value, double %t55, i8* %t57)
  store double %t59, double* %l5
  %t60 = load double, double* %l5
  %t61 = add i64 0, 2
  %t62 = call i8* @malloc(i64 %t61)
  store i8 34, i8* %t62
  %t63 = getelementptr i8, i8* %t62, i64 1
  store i8 0, i8* %t63
  call void @sailfin_runtime_mark_persistent(i8* %t62)
  %t64 = call i8* @repeat_character(i8* %t62, double %t60)
  store i8* %t64, i8** %l6
  %t65 = load i8*, i8** %l1
  %t66 = load i8*, i8** %l6
  %t67 = call i8* @sailfin_runtime_string_concat(i8* %t65, i8* %t66)
  store i8* %t67, i8** %l1
  %t68 = load double, double* %l0
  %t69 = load double, double* %l5
  %t70 = fadd double %t68, %t69
  %t71 = load double, double* %l5
  %t72 = add i64 0, 2
  %t73 = call i8* @malloc(i64 %t72)
  store i8 34, i8* %t73
  %t74 = getelementptr i8, i8* %t73, i64 1
  store i8 0, i8* %t74
  call void @sailfin_runtime_mark_persistent(i8* %t73)
  %t75 = call double @skip_python_string_literal(i8* %value, double %t70, i8* %t73, double %t71)
  store double %t75, double* %l0
  %t76 = load i8*, i8** %l1
  %t77 = load i8*, i8** %l6
  %t78 = call i8* @sailfin_runtime_string_concat(i8* %t76, i8* %t77)
  store i8* %t78, i8** %l1
  br label %loop.latch2
merge9:
  %t79 = load i8*, i8** %l1
  %t80 = load i8*, i8** %l2
  %t81 = call i8* @sailfin_runtime_string_concat(i8* %t79, i8* %t80)
  store i8* %t81, i8** %l1
  %t82 = load double, double* %l0
  %t83 = sitofp i64 1 to double
  %t84 = fadd double %t82, %t83
  store double %t84, double* %l0
  br label %loop.latch2
loop.latch2:
  %t85 = load i8*, i8** %l1
  %t86 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t89 = load i8*, i8** %l1
  %t90 = load double, double* %l0
  %t91 = load i8*, i8** %l1
  call void @sailfin_runtime_mark_persistent(i8* %t91)
  ret i8* %t91
}

define double @python_quote_length(i8* %value, double %start, i8* %delimiter) {
block.entry:
  %t0 = sitofp i64 2 to double
  %t1 = fadd double %start, %t0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t3 = sitofp i64 %t2 to double
  %t4 = fcmp olt double %t1, %t3
  br i1 %t4, label %then0, label %merge1
then0:
  %t5 = sitofp i64 1 to double
  %t6 = fadd double %start, %t5
  %t7 = sitofp i64 2 to double
  %t8 = fadd double %start, %t7
  %t9 = call double @llvm.round.f64(double %t6)
  %t10 = fptosi double %t9 to i64
  %t11 = call double @llvm.round.f64(double %t8)
  %t12 = fptosi double %t11 to i64
  %t13 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t10, i64 %t12)
  %t14 = call i1 @strings_equal(i8* %t13, i8* %delimiter)
  br i1 %t14, label %then2, label %merge3
then2:
  %t15 = sitofp i64 2 to double
  %t16 = fadd double %start, %t15
  %t17 = sitofp i64 3 to double
  %t18 = fadd double %start, %t17
  %t19 = call double @llvm.round.f64(double %t16)
  %t20 = fptosi double %t19 to i64
  %t21 = call double @llvm.round.f64(double %t18)
  %t22 = fptosi double %t21 to i64
  %t23 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t20, i64 %t22)
  %t24 = call i1 @strings_equal(i8* %t23, i8* %delimiter)
  br i1 %t24, label %then4, label %merge5
then4:
  %t25 = sitofp i64 3 to double
  ret double %t25
merge5:
  br label %merge3
merge3:
  br label %merge1
merge1:
  %t26 = sitofp i64 1 to double
  ret double %t26
}

define double @skip_python_string_literal(i8* %value, double %position, i8* %delimiter, double %quote_length) {
block.entry:
  %l0 = alloca double
  %l1 = alloca i1
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca i1
  %l5 = alloca double
  %l6 = alloca i8*
  %t0 = sitofp i64 1 to double
  %t1 = fcmp oeq double %quote_length, %t0
  br i1 %t1, label %then0, label %merge1
then0:
  store double %position, double* %l0
  store i1 0, i1* %l1
  %t2 = load double, double* %l0
  %t3 = load i1, i1* %l1
  br label %loop.header2
loop.header2:
  %t41 = phi double [ %t2, %then0 ], [ %t39, %loop.latch4 ]
  %t42 = phi i1 [ %t3, %then0 ], [ %t40, %loop.latch4 ]
  store double %t41, double* %l0
  store i1 %t42, i1* %l1
  br label %loop.body3
loop.body3:
  %t4 = load double, double* %l0
  %t5 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp ogt double %t4, %t6
  %t8 = load double, double* %l0
  %t9 = load i1, i1* %l1
  br i1 %t7, label %then6, label %merge7
then6:
  %t10 = load double, double* %l0
  ret double %t10
merge7:
  %t11 = load double, double* %l0
  %t12 = load double, double* %l0
  %t13 = sitofp i64 1 to double
  %t14 = fadd double %t12, %t13
  %t15 = call double @llvm.round.f64(double %t11)
  %t16 = fptosi double %t15 to i64
  %t17 = call double @llvm.round.f64(double %t14)
  %t18 = fptosi double %t17 to i64
  %t19 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t16, i64 %t18)
  store i8* %t19, i8** %l2
  %t20 = load double, double* %l0
  %t21 = sitofp i64 1 to double
  %t22 = fadd double %t20, %t21
  store double %t22, double* %l0
  %t23 = load i1, i1* %l1
  %t24 = load double, double* %l0
  %t25 = load i1, i1* %l1
  %t26 = load i8*, i8** %l2
  br i1 %t23, label %then8, label %merge9
then8:
  store i1 0, i1* %l1
  br label %loop.latch4
merge9:
  %t27 = load i8*, i8** %l2
  %t28 = load i8, i8* %t27
  %t29 = icmp eq i8 %t28, 92
  %t30 = load double, double* %l0
  %t31 = load i1, i1* %l1
  %t32 = load i8*, i8** %l2
  br i1 %t29, label %then10, label %merge11
then10:
  store i1 1, i1* %l1
  br label %loop.latch4
merge11:
  %t33 = load i8*, i8** %l2
  %t34 = call i1 @strings_equal(i8* %t33, i8* %delimiter)
  %t35 = load double, double* %l0
  %t36 = load i1, i1* %l1
  %t37 = load i8*, i8** %l2
  br i1 %t34, label %then12, label %merge13
then12:
  %t38 = load double, double* %l0
  ret double %t38
merge13:
  br label %loop.latch4
loop.latch4:
  %t39 = load double, double* %l0
  %t40 = load i1, i1* %l1
  br label %loop.header2
afterloop5:
  %t43 = load double, double* %l0
  %t44 = load i1, i1* %l1
  br label %merge1
merge1:
  store double %position, double* %l3
  %t45 = load double, double* %l3
  br label %loop.header14
loop.header14:
  %t102 = phi double [ %t45, %merge1 ], [ %t101, %loop.latch16 ]
  store double %t102, double* %l3
  br label %loop.body15
loop.body15:
  %t46 = load double, double* %l3
  %t47 = fadd double %t46, %quote_length
  %t48 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t49 = sitofp i64 %t48 to double
  %t50 = fcmp ogt double %t47, %t49
  %t51 = load double, double* %l3
  br i1 %t50, label %then18, label %merge19
then18:
  %t52 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t53 = sitofp i64 %t52 to double
  ret double %t53
merge19:
  store i1 1, i1* %l4
  %t54 = sitofp i64 0 to double
  store double %t54, double* %l5
  %t55 = load double, double* %l3
  %t56 = load i1, i1* %l4
  %t57 = load double, double* %l5
  br label %loop.header20
loop.header20:
  %t88 = phi i1 [ %t56, %merge19 ], [ %t86, %loop.latch22 ]
  %t89 = phi double [ %t57, %merge19 ], [ %t87, %loop.latch22 ]
  store i1 %t88, i1* %l4
  store double %t89, double* %l5
  br label %loop.body21
loop.body21:
  %t58 = load double, double* %l5
  %t59 = fcmp ogt double %t58, %quote_length
  %t60 = load double, double* %l3
  %t61 = load i1, i1* %l4
  %t62 = load double, double* %l5
  br i1 %t59, label %then24, label %merge25
then24:
  br label %afterloop23
merge25:
  %t63 = load double, double* %l3
  %t64 = load double, double* %l5
  %t65 = fadd double %t63, %t64
  %t66 = load double, double* %l3
  %t67 = load double, double* %l5
  %t68 = fadd double %t66, %t67
  %t69 = sitofp i64 1 to double
  %t70 = fadd double %t68, %t69
  %t71 = call double @llvm.round.f64(double %t65)
  %t72 = fptosi double %t71 to i64
  %t73 = call double @llvm.round.f64(double %t70)
  %t74 = fptosi double %t73 to i64
  %t75 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t72, i64 %t74)
  store i8* %t75, i8** %l6
  %t76 = load i8*, i8** %l6
  %t77 = call i1 @strings_equal(i8* %t76, i8* %delimiter)
  %t78 = xor i1 %t77, true
  %t79 = load double, double* %l3
  %t80 = load i1, i1* %l4
  %t81 = load double, double* %l5
  %t82 = load i8*, i8** %l6
  br i1 %t78, label %then26, label %merge27
then26:
  store i1 0, i1* %l4
  br label %afterloop23
merge27:
  %t83 = load double, double* %l5
  %t84 = sitofp i64 1 to double
  %t85 = fadd double %t83, %t84
  store double %t85, double* %l5
  br label %loop.latch22
loop.latch22:
  %t86 = load i1, i1* %l4
  %t87 = load double, double* %l5
  br label %loop.header20
afterloop23:
  %t90 = load i1, i1* %l4
  %t91 = load double, double* %l5
  %t92 = load i1, i1* %l4
  %t93 = load double, double* %l3
  %t94 = load i1, i1* %l4
  %t95 = load double, double* %l5
  br i1 %t92, label %then28, label %merge29
then28:
  %t96 = load double, double* %l3
  %t97 = fadd double %t96, %quote_length
  ret double %t97
merge29:
  %t98 = load double, double* %l3
  %t99 = sitofp i64 1 to double
  %t100 = fadd double %t98, %t99
  store double %t100, double* %l3
  br label %loop.latch16
loop.latch16:
  %t101 = load double, double* %l3
  br label %loop.header14
afterloop17:
  %t103 = load double, double* %l3
  %t104 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t105 = sitofp i64 %t104 to double
  ret double %t105
}

define i8* @repeat_character(i8* %ch, double %count) {
block.entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %t0 = sitofp i64 0 to double
  %t1 = fcmp olt double %count, %t0
  br i1 %t1, label %then0, label %merge1
then0:
  %s2 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %s2)
  ret i8* %s2
merge1:
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l0
  %s4 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s4, i8** %l1
  %t5 = load double, double* %l0
  %t6 = load i8*, i8** %l1
  br label %loop.header2
loop.header2:
  %t18 = phi i8* [ %t6, %merge1 ], [ %t16, %loop.latch4 ]
  %t19 = phi double [ %t5, %merge1 ], [ %t17, %loop.latch4 ]
  store i8* %t18, i8** %l1
  store double %t19, double* %l0
  br label %loop.body3
loop.body3:
  %t7 = load double, double* %l0
  %t8 = fcmp ogt double %t7, %count
  %t9 = load double, double* %l0
  %t10 = load i8*, i8** %l1
  br i1 %t8, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t11 = load i8*, i8** %l1
  %t12 = call i8* @sailfin_runtime_string_concat(i8* %t11, i8* %ch)
  store i8* %t12, i8** %l1
  %t13 = load double, double* %l0
  %t14 = sitofp i64 1 to double
  %t15 = fadd double %t13, %t14
  store double %t15, double* %l0
  br label %loop.latch4
loop.latch4:
  %t16 = load i8*, i8** %l1
  %t17 = load double, double* %l0
  br label %loop.header2
afterloop5:
  %t20 = load i8*, i8** %l1
  %t21 = load double, double* %l0
  %t22 = load i8*, i8** %l1
  call void @sailfin_runtime_mark_persistent(i8* %t22)
  ret i8* %t22
}

define double @find_substring(i8* %value, i8* %pattern) {
block.entry:
  %l0 = alloca double
  %l1 = alloca i1
  %l2 = alloca double
  %t0 = call i64 @sailfin_runtime_string_length(i8* %pattern)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = sitofp i64 0 to double
  ret double %t2
merge1:
  %t3 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t4 = call i64 @sailfin_runtime_string_length(i8* %pattern)
  %t5 = icmp slt i64 %t3, %t4
  br i1 %t5, label %then2, label %merge3
then2:
  %t6 = sitofp i64 -1 to double
  ret double %t6
merge3:
  %t7 = sitofp i64 0 to double
  store double %t7, double* %l0
  %t8 = load double, double* %l0
  br label %loop.header4
loop.header4:
  %t62 = phi double [ %t8, %merge3 ], [ %t61, %loop.latch6 ]
  store double %t62, double* %l0
  br label %loop.body5
loop.body5:
  %t9 = load double, double* %l0
  %t10 = call i64 @sailfin_runtime_string_length(i8* %pattern)
  %t11 = sitofp i64 %t10 to double
  %t12 = fadd double %t9, %t11
  %t13 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t14 = sitofp i64 %t13 to double
  %t15 = fcmp ogt double %t12, %t14
  %t16 = load double, double* %l0
  br i1 %t15, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  store i1 1, i1* %l1
  %t17 = sitofp i64 0 to double
  store double %t17, double* %l2
  %t18 = load double, double* %l0
  %t19 = load i1, i1* %l1
  %t20 = load double, double* %l2
  br label %loop.header10
loop.header10:
  %t49 = phi i1 [ %t19, %merge9 ], [ %t47, %loop.latch12 ]
  %t50 = phi double [ %t20, %merge9 ], [ %t48, %loop.latch12 ]
  store i1 %t49, i1* %l1
  store double %t50, double* %l2
  br label %loop.body11
loop.body11:
  %t21 = load double, double* %l2
  %t22 = call i64 @sailfin_runtime_string_length(i8* %pattern)
  %t23 = sitofp i64 %t22 to double
  %t24 = fcmp ogt double %t21, %t23
  %t25 = load double, double* %l0
  %t26 = load i1, i1* %l1
  %t27 = load double, double* %l2
  br i1 %t24, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t28 = load double, double* %l0
  %t29 = load double, double* %l2
  %t30 = fadd double %t28, %t29
  %t31 = call double @llvm.round.f64(double %t30)
  %t32 = fptosi double %t31 to i64
  %t33 = getelementptr i8, i8* %value, i64 %t32
  %t34 = load i8, i8* %t33
  %t35 = load double, double* %l2
  %t36 = call double @llvm.round.f64(double %t35)
  %t37 = fptosi double %t36 to i64
  %t38 = getelementptr i8, i8* %pattern, i64 %t37
  %t39 = load i8, i8* %t38
  %t40 = icmp ne i8 %t34, %t39
  %t41 = load double, double* %l0
  %t42 = load i1, i1* %l1
  %t43 = load double, double* %l2
  br i1 %t40, label %then16, label %merge17
then16:
  store i1 0, i1* %l1
  br label %afterloop13
merge17:
  %t44 = load double, double* %l2
  %t45 = sitofp i64 1 to double
  %t46 = fadd double %t44, %t45
  store double %t46, double* %l2
  br label %loop.latch12
loop.latch12:
  %t47 = load i1, i1* %l1
  %t48 = load double, double* %l2
  br label %loop.header10
afterloop13:
  %t51 = load i1, i1* %l1
  %t52 = load double, double* %l2
  %t53 = load i1, i1* %l1
  %t54 = load double, double* %l0
  %t55 = load i1, i1* %l1
  %t56 = load double, double* %l2
  br i1 %t53, label %then18, label %merge19
then18:
  %t57 = load double, double* %l0
  ret double %t57
merge19:
  %t58 = load double, double* %l0
  %t59 = sitofp i64 1 to double
  %t60 = fadd double %t58, %t59
  store double %t60, double* %l0
  br label %loop.latch6
loop.latch6:
  %t61 = load double, double* %l0
  br label %loop.header4
afterloop7:
  %t63 = load double, double* %l0
  %t64 = sitofp i64 -1 to double
  ret double %t64
}

define double @find_substring_from(i8* %value, i8* %pattern, double %start) {
block.entry:
  %l0 = alloca double
  %l1 = alloca i1
  %l2 = alloca double
  %t0 = sitofp i64 0 to double
  %t1 = fcmp olt double %start, %t0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = call double @find_substring(i8* %value, i8* %pattern)
  ret double %t2
merge1:
  %t3 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t4 = sitofp i64 %t3 to double
  %t5 = fcmp ogt double %start, %t4
  br i1 %t5, label %then2, label %merge3
then2:
  %t6 = sitofp i64 -1 to double
  ret double %t6
merge3:
  store double %start, double* %l0
  %t7 = load double, double* %l0
  br label %loop.header4
loop.header4:
  %t61 = phi double [ %t7, %merge3 ], [ %t60, %loop.latch6 ]
  store double %t61, double* %l0
  br label %loop.body5
loop.body5:
  %t8 = load double, double* %l0
  %t9 = call i64 @sailfin_runtime_string_length(i8* %pattern)
  %t10 = sitofp i64 %t9 to double
  %t11 = fadd double %t8, %t10
  %t12 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t13 = sitofp i64 %t12 to double
  %t14 = fcmp ogt double %t11, %t13
  %t15 = load double, double* %l0
  br i1 %t14, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  store i1 1, i1* %l1
  %t16 = sitofp i64 0 to double
  store double %t16, double* %l2
  %t17 = load double, double* %l0
  %t18 = load i1, i1* %l1
  %t19 = load double, double* %l2
  br label %loop.header10
loop.header10:
  %t48 = phi i1 [ %t18, %merge9 ], [ %t46, %loop.latch12 ]
  %t49 = phi double [ %t19, %merge9 ], [ %t47, %loop.latch12 ]
  store i1 %t48, i1* %l1
  store double %t49, double* %l2
  br label %loop.body11
loop.body11:
  %t20 = load double, double* %l2
  %t21 = call i64 @sailfin_runtime_string_length(i8* %pattern)
  %t22 = sitofp i64 %t21 to double
  %t23 = fcmp ogt double %t20, %t22
  %t24 = load double, double* %l0
  %t25 = load i1, i1* %l1
  %t26 = load double, double* %l2
  br i1 %t23, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t27 = load double, double* %l0
  %t28 = load double, double* %l2
  %t29 = fadd double %t27, %t28
  %t30 = call double @llvm.round.f64(double %t29)
  %t31 = fptosi double %t30 to i64
  %t32 = getelementptr i8, i8* %value, i64 %t31
  %t33 = load i8, i8* %t32
  %t34 = load double, double* %l2
  %t35 = call double @llvm.round.f64(double %t34)
  %t36 = fptosi double %t35 to i64
  %t37 = getelementptr i8, i8* %pattern, i64 %t36
  %t38 = load i8, i8* %t37
  %t39 = icmp ne i8 %t33, %t38
  %t40 = load double, double* %l0
  %t41 = load i1, i1* %l1
  %t42 = load double, double* %l2
  br i1 %t39, label %then16, label %merge17
then16:
  store i1 0, i1* %l1
  br label %afterloop13
merge17:
  %t43 = load double, double* %l2
  %t44 = sitofp i64 1 to double
  %t45 = fadd double %t43, %t44
  store double %t45, double* %l2
  br label %loop.latch12
loop.latch12:
  %t46 = load i1, i1* %l1
  %t47 = load double, double* %l2
  br label %loop.header10
afterloop13:
  %t50 = load i1, i1* %l1
  %t51 = load double, double* %l2
  %t52 = load i1, i1* %l1
  %t53 = load double, double* %l0
  %t54 = load i1, i1* %l1
  %t55 = load double, double* %l2
  br i1 %t52, label %then18, label %merge19
then18:
  %t56 = load double, double* %l0
  ret double %t56
merge19:
  %t57 = load double, double* %l0
  %t58 = sitofp i64 1 to double
  %t59 = fadd double %t57, %t58
  store double %t59, double* %l0
  br label %loop.latch6
loop.latch6:
  %t60 = load double, double* %l0
  br label %loop.header4
afterloop7:
  %t62 = load double, double* %l0
  %t63 = sitofp i64 -1 to double
  ret double %t63
}

define double @advance_to_line_end(i8* %value, double %position) {
block.entry:
  %l0 = alloca double
  %l1 = alloca i8*
  store double %position, double* %l0
  %t0 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t24 = phi double [ %t0, %block.entry ], [ %t23, %loop.latch2 ]
  store double %t24, double* %l0
  br label %loop.body1
loop.body1:
  %t1 = load double, double* %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t3 = sitofp i64 %t2 to double
  %t4 = fcmp ogt double %t1, %t3
  %t5 = load double, double* %l0
  br i1 %t4, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t6 = load double, double* %l0
  %t7 = load double, double* %l0
  %t8 = sitofp i64 1 to double
  %t9 = fadd double %t7, %t8
  %t10 = call double @llvm.round.f64(double %t6)
  %t11 = fptosi double %t10 to i64
  %t12 = call double @llvm.round.f64(double %t9)
  %t13 = fptosi double %t12 to i64
  %t14 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t11, i64 %t13)
  store i8* %t14, i8** %l1
  %t15 = load double, double* %l0
  %t16 = sitofp i64 1 to double
  %t17 = fadd double %t15, %t16
  store double %t17, double* %l0
  %t18 = load i8*, i8** %l1
  %t19 = load i8, i8* %t18
  %t20 = icmp eq i8 %t19, 10
  %t21 = load double, double* %l0
  %t22 = load i8*, i8** %l1
  br i1 %t20, label %then6, label %merge7
then6:
  br label %afterloop3
merge7:
  br label %loop.latch2
loop.latch2:
  %t23 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t25 = load double, double* %l0
  %t26 = load double, double* %l0
  ret double %t26
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
