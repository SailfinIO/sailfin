; ModuleID = 'sailfin'
source_filename = "sailfin"

%EffectRequirement = type { i8*, i8*, i8* }
%EffectViolation = type { i8*, { i8**, i64 }*, { i8**, i64 }* }

declare noalias i8* @malloc(i64)

@.str.8 = private unnamed_addr constant [3 x i8] c"fs\00"
@.str.9 = private unnamed_addr constant [3 x i8] c"io\00"
@.str.10 = private unnamed_addr constant [24 x i8] c"filesystem helper usage\00"
@.str.13 = private unnamed_addr constant [6 x i8] c"print\00"
@.str.15 = private unnamed_addr constant [19 x i8] c"print helper usage\00"
@.str.18 = private unnamed_addr constant [8 x i8] c"console\00"
@.str.20 = private unnamed_addr constant [21 x i8] c"console helper usage\00"
@.str.23 = private unnamed_addr constant [5 x i8] c"http\00"
@.str.24 = private unnamed_addr constant [4 x i8] c"net\00"
@.str.25 = private unnamed_addr constant [18 x i8] c"http helper usage\00"
@.str.28 = private unnamed_addr constant [10 x i8] c"websocket\00"
@.str.30 = private unnamed_addr constant [23 x i8] c"websocket helper usage\00"
@.str.33 = private unnamed_addr constant [6 x i8] c"spawn\00"
@.str.35 = private unnamed_addr constant [11 x i8] c"spawn call\00"
@.str.38 = private unnamed_addr constant [6 x i8] c"serve\00"
@.str.40 = private unnamed_addr constant [11 x i8] c"serve call\00"
@.str.43 = private unnamed_addr constant [6 x i8] c"sleep\00"
@.str.44 = private unnamed_addr constant [6 x i8] c"clock\00"
@.str.45 = private unnamed_addr constant [11 x i8] c"sleep call\00"
@.str.0 = private unnamed_addr constant [2 x i8] c".\00"

define { %EffectViolation*, i64 }* @validate_effects(i8* %program) {
entry:
  %l0 = alloca { %EffectViolation*, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %EffectViolation*, i64 }* null, { %EffectViolation*, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t18 = phi { %EffectViolation*, i64 }* [ %t6, %entry ], [ %t16, %loop.latch2 ]
  %t19 = phi double [ %t7, %entry ], [ %t17, %loop.latch2 ]
  store { %EffectViolation*, i64 }* %t18, { %EffectViolation*, i64 }** %l0
  store double %t19, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  store double 0.0, double* %l2
  %t9 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t10 = load double, double* %l2
  %t11 = call { %EffectViolation*, i64 }* @analyze_statement(i8* null)
  %t12 = call { %EffectViolation*, i64 }* @append_violations({ %EffectViolation*, i64 }* %t9, { %EffectViolation*, i64 }* %t11)
  store { %EffectViolation*, i64 }* %t12, { %EffectViolation*, i64 }** %l0
  %t13 = load double, double* %l1
  %t14 = sitofp i64 1 to double
  %t15 = fadd double %t13, %t14
  store double %t15, double* %l1
  br label %loop.latch2
loop.latch2:
  %t16 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t17 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t20 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  ret { %EffectViolation*, i64 }* %t20
}

define { %EffectViolation*, i64 }* @analyze_statement(i8* %statement) {
entry:
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  ret { %EffectViolation*, i64 }* null
}

define { %EffectViolation*, i64 }* @analyze_routine(i8* %signature, i8* %body, { i8**, i64 }* %decorators, i8* %name) {
entry:
  %l0 = alloca double
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca i1
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca { %EffectRequirement*, i64 }*
  %l7 = alloca { i8**, i64 }*
  %l8 = alloca { %EffectRequirement*, i64 }*
  %l9 = alloca double
  %l10 = alloca %EffectRequirement
  %l11 = alloca i8*
  %l12 = alloca { %EffectViolation*, i64 }*
  %t0 = call double @evaluate_decorators({ i8**, i64 }* %decorators)
  store double %t0, double* %l0
  %t1 = alloca [0 x double]
  %t2 = getelementptr [0 x double], [0 x double]* %t1, i32 0, i32 0
  %t3 = alloca { double*, i64 }
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 0
  store double* %t2, double** %t4
  %t5 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t6 = sitofp i64 0 to double
  store double %t6, double* %l2
  %t7 = load double, double* %l0
  %t8 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t9 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t17 = phi { i8**, i64 }* [ %t8, %entry ], [ %t15, %loop.latch2 ]
  %t18 = phi double [ %t9, %entry ], [ %t16, %loop.latch2 ]
  store { i8**, i64 }* %t17, { i8**, i64 }** %l1
  store double %t18, double* %l2
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l2
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t12 = load double, double* %l2
  %t13 = sitofp i64 1 to double
  %t14 = fadd double %t12, %t13
  store double %t14, double* %l2
  br label %loop.latch2
loop.latch2:
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t16 = load double, double* %l2
  br label %loop.header0
afterloop3:
  store i1 0, i1* %l3
  %t19 = sitofp i64 0 to double
  store double %t19, double* %l4
  %t20 = load double, double* %l0
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t22 = load double, double* %l2
  %t23 = load i1, i1* %l3
  %t24 = load double, double* %l4
  br label %loop.header4
loop.header4:
  %t36 = phi double [ %t24, %entry ], [ %t35, %loop.latch6 ]
  store double %t36, double* %l4
  br label %loop.body5
loop.body5:
  %t25 = load double, double* %l4
  %t26 = load double, double* %l0
  %t27 = load double, double* %l0
  %t28 = load double, double* %l4
  store double 0.0, double* %l5
  %t31 = load double, double* %l5
  %t32 = load double, double* %l4
  %t33 = sitofp i64 1 to double
  %t34 = fadd double %t32, %t33
  store double %t34, double* %l4
  br label %loop.latch6
loop.latch6:
  %t35 = load double, double* %l4
  br label %loop.header4
afterloop7:
  %t37 = load i1, i1* %l3
  %t38 = load double, double* %l0
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t40 = load double, double* %l2
  %t41 = load i1, i1* %l3
  %t42 = load double, double* %l4
  br i1 %t37, label %then8, label %merge9
then8:
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s44 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.44, i32 0, i32 0
  %t45 = call { i8**, i64 }* @append_unique_effect({ i8**, i64 }* %t43, i8* %s44)
  store { i8**, i64 }* %t45, { i8**, i64 }** %l1
  br label %merge9
merge9:
  %t46 = phi { i8**, i64 }* [ %t45, %then8 ], [ %t39, %entry ]
  store { i8**, i64 }* %t46, { i8**, i64 }** %l1
  %t47 = call { %EffectRequirement*, i64 }* @required_effects(i8* %body)
  store { %EffectRequirement*, i64 }* %t47, { %EffectRequirement*, i64 }** %l6
  %t48 = alloca [0 x double]
  %t49 = getelementptr [0 x double], [0 x double]* %t48, i32 0, i32 0
  %t50 = alloca { double*, i64 }
  %t51 = getelementptr { double*, i64 }, { double*, i64 }* %t50, i32 0, i32 0
  store double* %t49, double** %t51
  %t52 = getelementptr { double*, i64 }, { double*, i64 }* %t50, i32 0, i32 1
  store i64 0, i64* %t52
  store { i8**, i64 }* null, { i8**, i64 }** %l7
  %t53 = alloca [0 x double]
  %t54 = getelementptr [0 x double], [0 x double]* %t53, i32 0, i32 0
  %t55 = alloca { double*, i64 }
  %t56 = getelementptr { double*, i64 }, { double*, i64 }* %t55, i32 0, i32 0
  store double* %t54, double** %t56
  %t57 = getelementptr { double*, i64 }, { double*, i64 }* %t55, i32 0, i32 1
  store i64 0, i64* %t57
  store { %EffectRequirement*, i64 }* null, { %EffectRequirement*, i64 }** %l8
  %t58 = sitofp i64 0 to double
  store double %t58, double* %l9
  %t59 = load double, double* %l0
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t61 = load double, double* %l2
  %t62 = load i1, i1* %l3
  %t63 = load double, double* %l4
  %t64 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t66 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t67 = load double, double* %l9
  br label %loop.header10
loop.header10:
  %t145 = phi double [ %t67, %entry ], [ %t142, %loop.latch12 ]
  %t146 = phi { i8**, i64 }* [ %t65, %entry ], [ %t143, %loop.latch12 ]
  %t147 = phi { %EffectRequirement*, i64 }* [ %t66, %entry ], [ %t144, %loop.latch12 ]
  store double %t145, double* %l9
  store { i8**, i64 }* %t146, { i8**, i64 }** %l7
  store { %EffectRequirement*, i64 }* %t147, { %EffectRequirement*, i64 }** %l8
  br label %loop.body11
loop.body11:
  %t68 = load double, double* %l9
  %t69 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t70 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t71 = load double, double* %l9
  %t72 = load { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t70
  %t73 = extractvalue { %EffectRequirement*, i64 } %t72, 0
  %t74 = extractvalue { %EffectRequirement*, i64 } %t72, 1
  %t75 = icmp uge i64 %t71, %t74
  ; bounds check: %t75 (if true, out of bounds)
  %t76 = getelementptr %EffectRequirement, %EffectRequirement* %t73, i64 %t71
  %t77 = load %EffectRequirement, %EffectRequirement* %t76
  store %EffectRequirement %t77, %EffectRequirement* %l10
  %t78 = load %EffectRequirement, %EffectRequirement* %l10
  %t79 = extractvalue %EffectRequirement %t78, 0
  store i8* %t79, i8** %l11
  %t81 = load i8*, i8** %l11
  %s82 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.82, i32 0, i32 0
  %t83 = icmp eq i8* %t81, %s82
  br label %logical_and_entry_80

logical_and_entry_80:
  br i1 %t83, label %logical_and_right_80, label %logical_and_merge_80

logical_and_right_80:
  %t84 = load i1, i1* %l3
  br label %logical_and_right_end_80

logical_and_right_end_80:
  br label %logical_and_merge_80

logical_and_merge_80:
  %t85 = phi i1 [ false, %logical_and_entry_80 ], [ %t84, %logical_and_right_end_80 ]
  %t86 = load double, double* %l0
  %t87 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t88 = load double, double* %l2
  %t89 = load i1, i1* %l3
  %t90 = load double, double* %l4
  %t91 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t93 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t94 = load double, double* %l9
  %t95 = load %EffectRequirement, %EffectRequirement* %l10
  %t96 = load i8*, i8** %l11
  br i1 %t85, label %then14, label %merge15
then14:
  %t97 = load double, double* %l9
  %t98 = sitofp i64 1 to double
  %t99 = fadd double %t97, %t98
  store double %t99, double* %l9
  br label %loop.latch12
merge15:
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t101 = load i8*, i8** %l11
  %t102 = call i1 @contains_effect({ i8**, i64 }* %t100, i8* %t101)
  %t103 = load double, double* %l0
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t105 = load double, double* %l2
  %t106 = load i1, i1* %l3
  %t107 = load double, double* %l4
  %t108 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t109 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t110 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t111 = load double, double* %l9
  %t112 = load %EffectRequirement, %EffectRequirement* %l10
  %t113 = load i8*, i8** %l11
  br i1 %t102, label %then16, label %merge17
then16:
  %t114 = load double, double* %l9
  %t115 = sitofp i64 1 to double
  %t116 = fadd double %t114, %t115
  store double %t116, double* %l9
  br label %loop.latch12
merge17:
  %t117 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t118 = load i8*, i8** %l11
  %t119 = call { i8**, i64 }* @append_unique_effect({ i8**, i64 }* %t117, i8* %t118)
  store { i8**, i64 }* %t119, { i8**, i64 }** %l7
  %t120 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t121 = load i8*, i8** %l11
  %t122 = call double @contains_requirement_for_effect({ %EffectRequirement*, i64 }* %t120, i8* %t121)
  %t123 = fcmp one double %t122, 0.0
  %t124 = load double, double* %l0
  %t125 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t126 = load double, double* %l2
  %t127 = load i1, i1* %l3
  %t128 = load double, double* %l4
  %t129 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t130 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t131 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t132 = load double, double* %l9
  %t133 = load %EffectRequirement, %EffectRequirement* %l10
  %t134 = load i8*, i8** %l11
  br i1 %t123, label %then18, label %merge19
then18:
  %t135 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t136 = load %EffectRequirement, %EffectRequirement* %l10
  %t137 = call { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }* %t135, %EffectRequirement %t136)
  store { %EffectRequirement*, i64 }* %t137, { %EffectRequirement*, i64 }** %l8
  br label %merge19
merge19:
  %t138 = phi { %EffectRequirement*, i64 }* [ %t137, %then18 ], [ %t131, %loop.body11 ]
  store { %EffectRequirement*, i64 }* %t138, { %EffectRequirement*, i64 }** %l8
  %t139 = load double, double* %l9
  %t140 = sitofp i64 1 to double
  %t141 = fadd double %t139, %t140
  store double %t141, double* %l9
  br label %loop.latch12
loop.latch12:
  %t142 = load double, double* %l9
  %t143 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t144 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  br label %loop.header10
afterloop13:
  %t148 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t149 = alloca [0 x double]
  %t150 = getelementptr [0 x double], [0 x double]* %t149, i32 0, i32 0
  %t151 = alloca { double*, i64 }
  %t152 = getelementptr { double*, i64 }, { double*, i64 }* %t151, i32 0, i32 0
  store double* %t150, double** %t152
  %t153 = getelementptr { double*, i64 }, { double*, i64 }* %t151, i32 0, i32 1
  store i64 0, i64* %t153
  store { %EffectViolation*, i64 }* null, { %EffectViolation*, i64 }** %l12
  %t154 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l12
  ret { %EffectViolation*, i64 }* %t154
}

define { %EffectRequirement*, i64 }* @required_effects(i8* %body) {
entry:
  %t0 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(i8* %body)
  ret { %EffectRequirement*, i64 }* %t0
}

define { %EffectRequirement*, i64 }* @collect_effects_from_block(i8* %block) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  store double 0.0, double* %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load double, double* %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t10 = phi double [ %t1, %entry ], [ %t8, %loop.latch2 ]
  %t11 = phi double [ %t2, %entry ], [ %t9, %loop.latch2 ]
  store double %t10, double* %l0
  store double %t11, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load double, double* %l0
  %t5 = load double, double* %l1
  %t6 = sitofp i64 1 to double
  %t7 = fadd double %t5, %t6
  store double %t7, double* %l1
  br label %loop.latch2
loop.latch2:
  %t8 = load double, double* %l0
  %t9 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t12 = load double, double* %l0
  ret { %EffectRequirement*, i64 }* null
}

define { %EffectRequirement*, i64 }* @collect_effects_from_statement(i8* %statement) {
entry:
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  ret { %EffectRequirement*, i64 }* null
}

define { %EffectRequirement*, i64 }* @collect_effects_from_else_branch(i8* %branch) {
entry:
  %l0 = alloca { %EffectRequirement*, i64 }*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %EffectRequirement*, i64 }* null, { %EffectRequirement*, i64 }** %l0
  %t5 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t5
}

define { %EffectRequirement*, i64 }* @collect_effects_from_match_case(i8* %case) {
entry:
  %l0 = alloca double
  store double 0.0, double* %l0
  %t0 = load double, double* %l0
  %t1 = load double, double* %l0
  ret { %EffectRequirement*, i64 }* null
}

define { %EffectRequirement*, i64 }* @collect_effects_from_expression(i8* %expression) {
entry:
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  ret { %EffectRequirement*, i64 }* null
}

define { %EffectRequirement*, i64 }* @collect_effects_from_tokens({ i8**, i64 }* %tokens) {
entry:
  %l0 = alloca { %EffectRequirement*, i64 }*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %EffectRequirement*, i64 }* null, { %EffectRequirement*, i64 }** %l0
  %t5 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t6 = call { %EffectRequirement*, i64 }* @append_prompt_effect({ %EffectRequirement*, i64 }* %t5, { i8**, i64 }* %tokens)
  store { %EffectRequirement*, i64 }* %t6, { %EffectRequirement*, i64 }** %l0
  %t7 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s8 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.8, i32 0, i32 0
  %s9 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.9, i32 0, i32 0
  %s10 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.10, i32 0, i32 0
  %t11 = call { %EffectRequirement*, i64 }* @append_identifier_dot_effect({ %EffectRequirement*, i64 }* %t7, { i8**, i64 }* %tokens, i8* %s8, i8* %s9, i8* %s10)
  store { %EffectRequirement*, i64 }* %t11, { %EffectRequirement*, i64 }** %l0
  %t12 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s13 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.13, i32 0, i32 0
  %s14 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.14, i32 0, i32 0
  %s15 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.15, i32 0, i32 0
  %t16 = call { %EffectRequirement*, i64 }* @append_identifier_dot_effect({ %EffectRequirement*, i64 }* %t12, { i8**, i64 }* %tokens, i8* %s13, i8* %s14, i8* %s15)
  store { %EffectRequirement*, i64 }* %t16, { %EffectRequirement*, i64 }** %l0
  %t17 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s18 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.18, i32 0, i32 0
  %s19 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.19, i32 0, i32 0
  %s20 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.20, i32 0, i32 0
  %t21 = call { %EffectRequirement*, i64 }* @append_identifier_dot_effect({ %EffectRequirement*, i64 }* %t17, { i8**, i64 }* %tokens, i8* %s18, i8* %s19, i8* %s20)
  store { %EffectRequirement*, i64 }* %t21, { %EffectRequirement*, i64 }** %l0
  %t22 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s23 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.23, i32 0, i32 0
  %s24 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.24, i32 0, i32 0
  %s25 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.25, i32 0, i32 0
  %t26 = call { %EffectRequirement*, i64 }* @append_identifier_dot_effect({ %EffectRequirement*, i64 }* %t22, { i8**, i64 }* %tokens, i8* %s23, i8* %s24, i8* %s25)
  store { %EffectRequirement*, i64 }* %t26, { %EffectRequirement*, i64 }** %l0
  %t27 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s28 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.28, i32 0, i32 0
  %s29 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.29, i32 0, i32 0
  %s30 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.30, i32 0, i32 0
  %t31 = call { %EffectRequirement*, i64 }* @append_identifier_dot_effect({ %EffectRequirement*, i64 }* %t27, { i8**, i64 }* %tokens, i8* %s28, i8* %s29, i8* %s30)
  store { %EffectRequirement*, i64 }* %t31, { %EffectRequirement*, i64 }** %l0
  %t32 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s33 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.33, i32 0, i32 0
  %s34 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.34, i32 0, i32 0
  %s35 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.35, i32 0, i32 0
  %t36 = call { %EffectRequirement*, i64 }* @append_identifier_call_effect({ %EffectRequirement*, i64 }* %t32, { i8**, i64 }* %tokens, i8* %s33, i8* %s34, i8* %s35)
  store { %EffectRequirement*, i64 }* %t36, { %EffectRequirement*, i64 }** %l0
  %t37 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s38 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.38, i32 0, i32 0
  %s39 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.39, i32 0, i32 0
  %s40 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.40, i32 0, i32 0
  %t41 = call { %EffectRequirement*, i64 }* @append_identifier_call_effect({ %EffectRequirement*, i64 }* %t37, { i8**, i64 }* %tokens, i8* %s38, i8* %s39, i8* %s40)
  store { %EffectRequirement*, i64 }* %t41, { %EffectRequirement*, i64 }** %l0
  %t42 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s43 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.43, i32 0, i32 0
  %s44 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.44, i32 0, i32 0
  %s45 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.45, i32 0, i32 0
  %t46 = call { %EffectRequirement*, i64 }* @append_identifier_call_effect({ %EffectRequirement*, i64 }* %t42, { i8**, i64 }* %tokens, i8* %s43, i8* %s44, i8* %s45)
  store { %EffectRequirement*, i64 }* %t46, { %EffectRequirement*, i64 }** %l0
  %t47 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t47
}

define { %EffectRequirement*, i64 }* @append_prompt_effect({ %EffectRequirement*, i64 }* %requirements, { i8**, i64 }* %tokens) {
entry:
  %l0 = alloca { %EffectRequirement*, i64 }*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca i8*
  store { %EffectRequirement*, i64 }* %requirements, { %EffectRequirement*, i64 }** %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t45 = phi { %EffectRequirement*, i64 }* [ %t1, %entry ], [ %t43, %loop.latch2 ]
  %t46 = phi double [ %t2, %entry ], [ %t44, %loop.latch2 ]
  store { %EffectRequirement*, i64 }* %t45, { %EffectRequirement*, i64 }** %l0
  store double %t46, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load double, double* %l1
  %t5 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t6 = extractvalue { i8**, i64 } %t5, 0
  %t7 = extractvalue { i8**, i64 } %t5, 1
  %t8 = icmp uge i64 %t4, %t7
  ; bounds check: %t8 (if true, out of bounds)
  %t9 = getelementptr i8*, i8** %t6, i64 %t4
  %t10 = load i8*, i8** %t9
  store i8* %t10, i8** %l2
  %t11 = load i8*, i8** %l2
  %s12 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.12, i32 0, i32 0
  %t13 = call i1 @is_identifier_token(i8* %t11, i8* %s12)
  %t14 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t15 = load double, double* %l1
  %t16 = load i8*, i8** %l2
  br i1 %t13, label %then4, label %merge5
then4:
  %t17 = load double, double* %l1
  %t18 = sitofp i64 1 to double
  %t19 = fadd double %t17, %t18
  %t20 = call double @next_non_trivia({ i8**, i64 }* %tokens, double %t19)
  store double %t20, double* %l3
  %s21 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.21, i32 0, i32 0
  store i8* %s21, i8** %l4
  %t22 = load double, double* %l3
  %t23 = sitofp i64 -1 to double
  %t24 = fcmp une double %t22, %t23
  %t25 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t26 = load double, double* %l1
  %t27 = load i8*, i8** %l2
  %t28 = load double, double* %l3
  %t29 = load i8*, i8** %l4
  br i1 %t24, label %then6, label %merge7
then6:
  %t30 = load double, double* %l3
  %t31 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t32 = extractvalue { i8**, i64 } %t31, 0
  %t33 = extractvalue { i8**, i64 } %t31, 1
  %t34 = icmp uge i64 %t30, %t33
  ; bounds check: %t34 (if true, out of bounds)
  %t35 = getelementptr i8*, i8** %t32, i64 %t30
  %t36 = load i8*, i8** %t35
  store i8* %t36, i8** %l5
  %t38 = load i8*, i8** %l5
  br label %merge7
merge7:
  br label %merge5
merge5:
  %t39 = phi { %EffectRequirement*, i64 }* [ null, %then4 ], [ %t14, %loop.body1 ]
  store { %EffectRequirement*, i64 }* %t39, { %EffectRequirement*, i64 }** %l0
  %t40 = load double, double* %l1
  %t41 = sitofp i64 1 to double
  %t42 = fadd double %t40, %t41
  store double %t42, double* %l1
  br label %loop.latch2
loop.latch2:
  %t43 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t44 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t47 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t47
}

define { %EffectRequirement*, i64 }* @append_identifier_dot_effect({ %EffectRequirement*, i64 }* %requirements, { i8**, i64 }* %tokens, i8* %identifier, i8* %effect, i8* %description) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { %EffectRequirement*, i64 }*
  %l2 = alloca double
  %s0 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.0, i32 0, i32 0
  %t1 = call { i8**, i64 }* @find_identifier_followed_by_symbol({ i8**, i64 }* %tokens, i8* %identifier, i8* %s0)
  store { i8**, i64 }* %t1, { i8**, i64 }** %l0
  store { %EffectRequirement*, i64 }* %requirements, { %EffectRequirement*, i64 }** %l1
  %t2 = sitofp i64 0 to double
  store double %t2, double* %l2
  %t3 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t4 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t5 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t13 = phi { %EffectRequirement*, i64 }* [ %t4, %entry ], [ %t11, %loop.latch2 ]
  %t14 = phi double [ %t5, %entry ], [ %t12, %loop.latch2 ]
  store { %EffectRequirement*, i64 }* %t13, { %EffectRequirement*, i64 }** %l1
  store double %t14, double* %l2
  br label %loop.body1
loop.body1:
  %t6 = load double, double* %l2
  %t7 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t8 = load double, double* %l2
  %t9 = sitofp i64 1 to double
  %t10 = fadd double %t8, %t9
  store double %t10, double* %l2
  br label %loop.latch2
loop.latch2:
  %t11 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t12 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t15 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  ret { %EffectRequirement*, i64 }* %t15
}

define { %EffectRequirement*, i64 }* @append_identifier_call_effect({ %EffectRequirement*, i64 }* %requirements, { i8**, i64 }* %tokens, i8* %identifier, i8* %effect, i8* %description) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { %EffectRequirement*, i64 }*
  %l2 = alloca double
  %t0 = call { i8**, i64 }* @find_identifier_call({ i8**, i64 }* %tokens, i8* %identifier)
  store { i8**, i64 }* %t0, { i8**, i64 }** %l0
  store { %EffectRequirement*, i64 }* %requirements, { %EffectRequirement*, i64 }** %l1
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l2
  %t2 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t3 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t4 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t12 = phi { %EffectRequirement*, i64 }* [ %t3, %entry ], [ %t10, %loop.latch2 ]
  %t13 = phi double [ %t4, %entry ], [ %t11, %loop.latch2 ]
  store { %EffectRequirement*, i64 }* %t12, { %EffectRequirement*, i64 }** %l1
  store double %t13, double* %l2
  br label %loop.body1
loop.body1:
  %t5 = load double, double* %l2
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load double, double* %l2
  %t8 = sitofp i64 1 to double
  %t9 = fadd double %t7, %t8
  store double %t9, double* %l2
  br label %loop.latch2
loop.latch2:
  %t10 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t11 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t14 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  ret { %EffectRequirement*, i64 }* %t14
}

define { i8**, i64 }* @find_identifier_followed_by_symbol({ i8**, i64 }* %tokens, i8* %name, i8* %symbol) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca double
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
  %t60 = phi { i8**, i64 }* [ %t6, %entry ], [ %t58, %loop.latch2 ]
  %t61 = phi double [ %t7, %entry ], [ %t59, %loop.latch2 ]
  store { i8**, i64 }* %t60, { i8**, i64 }** %l0
  store double %t61, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load double, double* %l1
  %t10 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t11 = extractvalue { i8**, i64 } %t10, 0
  %t12 = extractvalue { i8**, i64 } %t10, 1
  %t13 = icmp uge i64 %t9, %t12
  ; bounds check: %t13 (if true, out of bounds)
  %t14 = getelementptr i8*, i8** %t11, i64 %t9
  %t15 = load i8*, i8** %t14
  %t16 = call i1 @is_identifier_token(i8* %t15, i8* %name)
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = load double, double* %l1
  br i1 %t16, label %then4, label %merge5
then4:
  %t19 = load double, double* %l1
  %t20 = sitofp i64 1 to double
  %t21 = fadd double %t19, %t20
  %t22 = call double @next_non_trivia({ i8**, i64 }* %tokens, double %t21)
  store double %t22, double* %l2
  %t24 = load double, double* %l2
  %t25 = sitofp i64 -1 to double
  %t26 = fcmp une double %t24, %t25
  br label %logical_and_entry_23

logical_and_entry_23:
  br i1 %t26, label %logical_and_right_23, label %logical_and_merge_23

logical_and_right_23:
  %t27 = load double, double* %l2
  %t28 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t29 = extractvalue { i8**, i64 } %t28, 0
  %t30 = extractvalue { i8**, i64 } %t28, 1
  %t31 = icmp uge i64 %t27, %t30
  ; bounds check: %t31 (if true, out of bounds)
  %t32 = getelementptr i8*, i8** %t29, i64 %t27
  %t33 = load i8*, i8** %t32
  %t34 = call i1 @is_symbol_token(i8* %t33, i8* %symbol)
  br label %logical_and_right_end_23

logical_and_right_end_23:
  br label %logical_and_merge_23

logical_and_merge_23:
  %t35 = phi i1 [ false, %logical_and_entry_23 ], [ %t34, %logical_and_right_end_23 ]
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t37 = load double, double* %l1
  %t38 = load double, double* %l2
  br i1 %t35, label %then6, label %merge7
then6:
  %t39 = load double, double* %l1
  %t40 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t41 = extractvalue { i8**, i64 } %t40, 0
  %t42 = extractvalue { i8**, i64 } %t40, 1
  %t43 = icmp uge i64 %t39, %t42
  ; bounds check: %t43 (if true, out of bounds)
  %t44 = getelementptr i8*, i8** %t41, i64 %t39
  %t45 = load i8*, i8** %t44
  %t46 = alloca [1 x i8*]
  %t47 = getelementptr [1 x i8*], [1 x i8*]* %t46, i32 0, i32 0
  %t48 = getelementptr i8*, i8** %t47, i64 0
  store i8* %t45, i8** %t48
  %t49 = alloca { i8**, i64 }
  %t50 = getelementptr { i8**, i64 }, { i8**, i64 }* %t49, i32 0, i32 0
  store i8** %t47, i8*** %t50
  %t51 = getelementptr { i8**, i64 }, { i8**, i64 }* %t49, i32 0, i32 1
  store i64 1, i64* %t51
  %t52 = call double @matchesconcat({ i8**, i64 }* %t49)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  br label %merge7
merge7:
  %t53 = phi { i8**, i64 }* [ null, %then6 ], [ %t36, %then4 ]
  store { i8**, i64 }* %t53, { i8**, i64 }** %l0
  br label %merge5
merge5:
  %t54 = phi { i8**, i64 }* [ null, %then4 ], [ %t17, %loop.body1 ]
  store { i8**, i64 }* %t54, { i8**, i64 }** %l0
  %t55 = load double, double* %l1
  %t56 = sitofp i64 1 to double
  %t57 = fadd double %t55, %t56
  store double %t57, double* %l1
  br label %loop.latch2
loop.latch2:
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t59 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t62
}

define { i8**, i64 }* @find_identifier_call({ i8**, i64 }* %tokens, i8* %name) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca double
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
  %t61 = phi { i8**, i64 }* [ %t6, %entry ], [ %t59, %loop.latch2 ]
  %t62 = phi double [ %t7, %entry ], [ %t60, %loop.latch2 ]
  store { i8**, i64 }* %t61, { i8**, i64 }** %l0
  store double %t62, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load double, double* %l1
  %t10 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t11 = extractvalue { i8**, i64 } %t10, 0
  %t12 = extractvalue { i8**, i64 } %t10, 1
  %t13 = icmp uge i64 %t9, %t12
  ; bounds check: %t13 (if true, out of bounds)
  %t14 = getelementptr i8*, i8** %t11, i64 %t9
  %t15 = load i8*, i8** %t14
  %t16 = call i1 @is_identifier_token(i8* %t15, i8* %name)
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = load double, double* %l1
  br i1 %t16, label %then4, label %merge5
then4:
  %t19 = load double, double* %l1
  %t20 = sitofp i64 1 to double
  %t21 = fadd double %t19, %t20
  %t22 = call double @next_non_trivia({ i8**, i64 }* %tokens, double %t21)
  store double %t22, double* %l2
  %t24 = load double, double* %l2
  %t25 = sitofp i64 -1 to double
  %t26 = fcmp une double %t24, %t25
  br label %logical_and_entry_23

logical_and_entry_23:
  br i1 %t26, label %logical_and_right_23, label %logical_and_merge_23

logical_and_right_23:
  %t27 = load double, double* %l2
  %t28 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t29 = extractvalue { i8**, i64 } %t28, 0
  %t30 = extractvalue { i8**, i64 } %t28, 1
  %t31 = icmp uge i64 %t27, %t30
  ; bounds check: %t31 (if true, out of bounds)
  %t32 = getelementptr i8*, i8** %t29, i64 %t27
  %t33 = load i8*, i8** %t32
  %s34 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.34, i32 0, i32 0
  %t35 = call i1 @is_symbol_token(i8* %t33, i8* %s34)
  br label %logical_and_right_end_23

logical_and_right_end_23:
  br label %logical_and_merge_23

logical_and_merge_23:
  %t36 = phi i1 [ false, %logical_and_entry_23 ], [ %t35, %logical_and_right_end_23 ]
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t38 = load double, double* %l1
  %t39 = load double, double* %l2
  br i1 %t36, label %then6, label %merge7
then6:
  %t40 = load double, double* %l1
  %t41 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t42 = extractvalue { i8**, i64 } %t41, 0
  %t43 = extractvalue { i8**, i64 } %t41, 1
  %t44 = icmp uge i64 %t40, %t43
  ; bounds check: %t44 (if true, out of bounds)
  %t45 = getelementptr i8*, i8** %t42, i64 %t40
  %t46 = load i8*, i8** %t45
  %t47 = alloca [1 x i8*]
  %t48 = getelementptr [1 x i8*], [1 x i8*]* %t47, i32 0, i32 0
  %t49 = getelementptr i8*, i8** %t48, i64 0
  store i8* %t46, i8** %t49
  %t50 = alloca { i8**, i64 }
  %t51 = getelementptr { i8**, i64 }, { i8**, i64 }* %t50, i32 0, i32 0
  store i8** %t48, i8*** %t51
  %t52 = getelementptr { i8**, i64 }, { i8**, i64 }* %t50, i32 0, i32 1
  store i64 1, i64* %t52
  %t53 = call double @matchesconcat({ i8**, i64 }* %t50)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  br label %merge7
merge7:
  %t54 = phi { i8**, i64 }* [ null, %then6 ], [ %t37, %then4 ]
  store { i8**, i64 }* %t54, { i8**, i64 }** %l0
  br label %merge5
merge5:
  %t55 = phi { i8**, i64 }* [ null, %then4 ], [ %t17, %loop.body1 ]
  store { i8**, i64 }* %t55, { i8**, i64 }** %l0
  %t56 = load double, double* %l1
  %t57 = sitofp i64 1 to double
  %t58 = fadd double %t56, %t57
  store double %t58, double* %l1
  br label %loop.latch2
loop.latch2:
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t60 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t63
}

define double @next_non_trivia({ i8**, i64 }* %tokens, double %start) {
entry:
  %l0 = alloca double
  %l1 = alloca i8*
  store double %start, double* %l0
  %t0 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t19 = phi double [ %t0, %entry ], [ %t18, %loop.latch2 ]
  store double %t19, double* %l0
  br label %loop.body1
loop.body1:
  %t1 = load double, double* %l0
  %t2 = load double, double* %l0
  %t3 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t4 = extractvalue { i8**, i64 } %t3, 0
  %t5 = extractvalue { i8**, i64 } %t3, 1
  %t6 = icmp uge i64 %t2, %t5
  ; bounds check: %t6 (if true, out of bounds)
  %t7 = getelementptr i8*, i8** %t4, i64 %t2
  %t8 = load i8*, i8** %t7
  store i8* %t8, i8** %l1
  %t9 = load i8*, i8** %l1
  %t10 = call double @is_trivia_token(i8* %t9)
  %t11 = fcmp one double %t10, 0.0
  %t12 = load double, double* %l0
  %t13 = load i8*, i8** %l1
  br i1 %t11, label %then4, label %merge5
then4:
  %t14 = load double, double* %l0
  ret double %t14
merge5:
  %t15 = load double, double* %l0
  %t16 = sitofp i64 1 to double
  %t17 = fadd double %t15, %t16
  store double %t17, double* %l0
  br label %loop.latch2
loop.latch2:
  %t18 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t20 = sitofp i64 -1 to double
  ret double %t20
}

define i1 @is_trivia_token(i8* %token) {
entry:
  ret i1 false
}

define i1 @is_identifier_token(i8* %token, i8* %expected) {
entry:
  ret i1 false
}

define i1 @is_symbol_token(i8* %token, i8* %expected) {
entry:
  ret i1 false
}

define { %EffectViolation*, i64 }* @append_violations({ %EffectViolation*, i64 }* %violations, { %EffectViolation*, i64 }* %new_violations) {
entry:
  %l0 = alloca { %EffectViolation*, i64 }*
  %l1 = alloca double
  store { %EffectViolation*, i64 }* %violations, { %EffectViolation*, i64 }** %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t23 = phi { %EffectViolation*, i64 }* [ %t1, %entry ], [ %t21, %loop.latch2 ]
  %t24 = phi double [ %t2, %entry ], [ %t22, %loop.latch2 ]
  store { %EffectViolation*, i64 }* %t23, { %EffectViolation*, i64 }** %l0
  store double %t24, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load double, double* %l1
  %t5 = load { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %new_violations
  %t6 = extractvalue { %EffectViolation*, i64 } %t5, 0
  %t7 = extractvalue { %EffectViolation*, i64 } %t5, 1
  %t8 = icmp uge i64 %t4, %t7
  ; bounds check: %t8 (if true, out of bounds)
  %t9 = getelementptr %EffectViolation, %EffectViolation* %t6, i64 %t4
  %t10 = load %EffectViolation, %EffectViolation* %t9
  %t11 = alloca [1 x %EffectViolation]
  %t12 = getelementptr [1 x %EffectViolation], [1 x %EffectViolation]* %t11, i32 0, i32 0
  %t13 = getelementptr %EffectViolation, %EffectViolation* %t12, i64 0
  store %EffectViolation %t10, %EffectViolation* %t13
  %t14 = alloca { %EffectViolation*, i64 }
  %t15 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t14, i32 0, i32 0
  store %EffectViolation* %t12, %EffectViolation** %t15
  %t16 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t14, i32 0, i32 1
  store i64 1, i64* %t16
  %t17 = call double @resultconcat({ %EffectViolation*, i64 }* %t14)
  store { %EffectViolation*, i64 }* null, { %EffectViolation*, i64 }** %l0
  %t18 = load double, double* %l1
  %t19 = sitofp i64 1 to double
  %t20 = fadd double %t18, %t19
  store double %t20, double* %l1
  br label %loop.latch2
loop.latch2:
  %t21 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t22 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t25 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  ret { %EffectViolation*, i64 }* %t25
}

define { %EffectViolation*, i64 }* @append_violation({ %EffectViolation*, i64 }* %collection, %EffectViolation %item) {
entry:
  %t0 = alloca [1 x %EffectViolation]
  %t1 = getelementptr [1 x %EffectViolation], [1 x %EffectViolation]* %t0, i32 0, i32 0
  %t2 = getelementptr %EffectViolation, %EffectViolation* %t1, i64 0
  store %EffectViolation %item, %EffectViolation* %t2
  %t3 = alloca { %EffectViolation*, i64 }
  %t4 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t3, i32 0, i32 0
  store %EffectViolation* %t1, %EffectViolation** %t4
  %t5 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @collectionconcat({ %EffectViolation*, i64 }* %t3)
  ret { %EffectViolation*, i64 }* null
}

define { i8**, i64 }* @append_unique_effect({ i8**, i64 }* %effects, i8* %effect) {
entry:
  %t0 = call i1 @contains_effect({ i8**, i64 }* %effects, i8* %effect)
  br i1 %t0, label %then0, label %merge1
then0:
  ret { i8**, i64 }* %effects
merge1:
  %t1 = alloca [1 x i8*]
  %t2 = getelementptr [1 x i8*], [1 x i8*]* %t1, i32 0, i32 0
  %t3 = getelementptr i8*, i8** %t2, i64 0
  store i8* %effect, i8** %t3
  %t4 = alloca { i8**, i64 }
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t4, i32 0, i32 0
  store i8** %t2, i8*** %t5
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* %t4, i32 0, i32 1
  store i64 1, i64* %t6
  %t7 = call double @effectsconcat({ i8**, i64 }* %t4)
  ret { i8**, i64 }* null
}

define i1 @contains_effect({ i8**, i64 }* %effects, i8* %effect) {
entry:
  %l0 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t16 = phi double [ %t1, %entry ], [ %t15, %loop.latch2 ]
  store double %t16, double* %l0
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  %t3 = load double, double* %l0
  %t4 = load { i8**, i64 }, { i8**, i64 }* %effects
  %t5 = extractvalue { i8**, i64 } %t4, 0
  %t6 = extractvalue { i8**, i64 } %t4, 1
  %t7 = icmp uge i64 %t3, %t6
  ; bounds check: %t7 (if true, out of bounds)
  %t8 = getelementptr i8*, i8** %t5, i64 %t3
  %t9 = load i8*, i8** %t8
  %t10 = icmp eq i8* %t9, %effect
  %t11 = load double, double* %l0
  br i1 %t10, label %then4, label %merge5
then4:
  ret i1 1
merge5:
  %t12 = load double, double* %l0
  %t13 = sitofp i64 1 to double
  %t14 = fadd double %t12, %t13
  store double %t14, double* %l0
  br label %loop.latch2
loop.latch2:
  %t15 = load double, double* %l0
  br label %loop.header0
afterloop3:
  ret i1 0
}

define { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }* %collection, %EffectRequirement %item) {
entry:
  %t0 = alloca [1 x %EffectRequirement]
  %t1 = getelementptr [1 x %EffectRequirement], [1 x %EffectRequirement]* %t0, i32 0, i32 0
  %t2 = getelementptr %EffectRequirement, %EffectRequirement* %t1, i64 0
  store %EffectRequirement %item, %EffectRequirement* %t2
  %t3 = alloca { %EffectRequirement*, i64 }
  %t4 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t3, i32 0, i32 0
  store %EffectRequirement* %t1, %EffectRequirement** %t4
  %t5 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @collectionconcat({ %EffectRequirement*, i64 }* %t3)
  ret { %EffectRequirement*, i64 }* null
}

define { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %base, { %EffectRequirement*, i64 }* %additions) {
entry:
  %l0 = alloca { %EffectRequirement*, i64 }*
  %l1 = alloca double
  store { %EffectRequirement*, i64 }* %base, { %EffectRequirement*, i64 }** %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t23 = phi { %EffectRequirement*, i64 }* [ %t1, %entry ], [ %t21, %loop.latch2 ]
  %t24 = phi double [ %t2, %entry ], [ %t22, %loop.latch2 ]
  store { %EffectRequirement*, i64 }* %t23, { %EffectRequirement*, i64 }** %l0
  store double %t24, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load double, double* %l1
  %t5 = load { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %additions
  %t6 = extractvalue { %EffectRequirement*, i64 } %t5, 0
  %t7 = extractvalue { %EffectRequirement*, i64 } %t5, 1
  %t8 = icmp uge i64 %t4, %t7
  ; bounds check: %t8 (if true, out of bounds)
  %t9 = getelementptr %EffectRequirement, %EffectRequirement* %t6, i64 %t4
  %t10 = load %EffectRequirement, %EffectRequirement* %t9
  %t11 = alloca [1 x %EffectRequirement]
  %t12 = getelementptr [1 x %EffectRequirement], [1 x %EffectRequirement]* %t11, i32 0, i32 0
  %t13 = getelementptr %EffectRequirement, %EffectRequirement* %t12, i64 0
  store %EffectRequirement %t10, %EffectRequirement* %t13
  %t14 = alloca { %EffectRequirement*, i64 }
  %t15 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t14, i32 0, i32 0
  store %EffectRequirement* %t12, %EffectRequirement** %t15
  %t16 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t14, i32 0, i32 1
  store i64 1, i64* %t16
  %t17 = call double @resultconcat({ %EffectRequirement*, i64 }* %t14)
  store { %EffectRequirement*, i64 }* null, { %EffectRequirement*, i64 }** %l0
  %t18 = load double, double* %l1
  %t19 = sitofp i64 1 to double
  %t20 = fadd double %t18, %t19
  store double %t20, double* %l1
  br label %loop.latch2
loop.latch2:
  %t21 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t22 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t25 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t25
}

define i1 @contains_requirement_for_effect({ %EffectRequirement*, i64 }* %requirements, i8* %effect) {
entry:
  %l0 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t17 = phi double [ %t1, %entry ], [ %t16, %loop.latch2 ]
  store double %t17, double* %l0
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  %t3 = load double, double* %l0
  %t4 = load { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %requirements
  %t5 = extractvalue { %EffectRequirement*, i64 } %t4, 0
  %t6 = extractvalue { %EffectRequirement*, i64 } %t4, 1
  %t7 = icmp uge i64 %t3, %t6
  ; bounds check: %t7 (if true, out of bounds)
  %t8 = getelementptr %EffectRequirement, %EffectRequirement* %t5, i64 %t3
  %t9 = load %EffectRequirement, %EffectRequirement* %t8
  %t10 = extractvalue %EffectRequirement %t9, 0
  %t11 = icmp eq i8* %t10, %effect
  %t12 = load double, double* %l0
  br i1 %t11, label %then4, label %merge5
then4:
  ret i1 1
merge5:
  %t13 = load double, double* %l0
  %t14 = sitofp i64 1 to double
  %t15 = fadd double %t13, %t14
  store double %t15, double* %l0
  br label %loop.latch2
loop.latch2:
  %t16 = load double, double* %l0
  br label %loop.header0
afterloop3:
  ret i1 0
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
