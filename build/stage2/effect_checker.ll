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
  %t158 = phi double [ %t67, %entry ], [ %t155, %loop.latch12 ]
  %t159 = phi { i8**, i64 }* [ %t65, %entry ], [ %t156, %loop.latch12 ]
  %t160 = phi { %EffectRequirement*, i64 }* [ %t66, %entry ], [ %t157, %loop.latch12 ]
  store double %t158, double* %l9
  store { i8**, i64 }* %t159, { i8**, i64 }** %l7
  store { %EffectRequirement*, i64 }* %t160, { %EffectRequirement*, i64 }** %l8
  br label %loop.body11
loop.body11:
  %t68 = load double, double* %l9
  %t69 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t70 = load { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t69
  %t71 = extractvalue { %EffectRequirement*, i64 } %t70, 1
  %t72 = sitofp i64 %t71 to double
  %t73 = fcmp oge double %t68, %t72
  %t74 = load double, double* %l0
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t76 = load double, double* %l2
  %t77 = load i1, i1* %l3
  %t78 = load double, double* %l4
  %t79 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t80 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t81 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t82 = load double, double* %l9
  br i1 %t73, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t83 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t84 = load double, double* %l9
  %t85 = load { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t83
  %t86 = extractvalue { %EffectRequirement*, i64 } %t85, 0
  %t87 = extractvalue { %EffectRequirement*, i64 } %t85, 1
  %t88 = icmp uge i64 %t84, %t87
  ; bounds check: %t88 (if true, out of bounds)
  %t89 = getelementptr %EffectRequirement, %EffectRequirement* %t86, i64 %t84
  %t90 = load %EffectRequirement, %EffectRequirement* %t89
  store %EffectRequirement %t90, %EffectRequirement* %l10
  %t91 = load %EffectRequirement, %EffectRequirement* %l10
  %t92 = extractvalue %EffectRequirement %t91, 0
  store i8* %t92, i8** %l11
  %t94 = load i8*, i8** %l11
  %s95 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.95, i32 0, i32 0
  %t96 = icmp eq i8* %t94, %s95
  br label %logical_and_entry_93

logical_and_entry_93:
  br i1 %t96, label %logical_and_right_93, label %logical_and_merge_93

logical_and_right_93:
  %t97 = load i1, i1* %l3
  br label %logical_and_right_end_93

logical_and_right_end_93:
  br label %logical_and_merge_93

logical_and_merge_93:
  %t98 = phi i1 [ false, %logical_and_entry_93 ], [ %t97, %logical_and_right_end_93 ]
  %t99 = load double, double* %l0
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t101 = load double, double* %l2
  %t102 = load i1, i1* %l3
  %t103 = load double, double* %l4
  %t104 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t106 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t107 = load double, double* %l9
  %t108 = load %EffectRequirement, %EffectRequirement* %l10
  %t109 = load i8*, i8** %l11
  br i1 %t98, label %then16, label %merge17
then16:
  %t110 = load double, double* %l9
  %t111 = sitofp i64 1 to double
  %t112 = fadd double %t110, %t111
  store double %t112, double* %l9
  br label %loop.latch12
merge17:
  %t113 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t114 = load i8*, i8** %l11
  %t115 = call i1 @contains_effect({ i8**, i64 }* %t113, i8* %t114)
  %t116 = load double, double* %l0
  %t117 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t118 = load double, double* %l2
  %t119 = load i1, i1* %l3
  %t120 = load double, double* %l4
  %t121 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t122 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t123 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t124 = load double, double* %l9
  %t125 = load %EffectRequirement, %EffectRequirement* %l10
  %t126 = load i8*, i8** %l11
  br i1 %t115, label %then18, label %merge19
then18:
  %t127 = load double, double* %l9
  %t128 = sitofp i64 1 to double
  %t129 = fadd double %t127, %t128
  store double %t129, double* %l9
  br label %loop.latch12
merge19:
  %t130 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t131 = load i8*, i8** %l11
  %t132 = call { i8**, i64 }* @append_unique_effect({ i8**, i64 }* %t130, i8* %t131)
  store { i8**, i64 }* %t132, { i8**, i64 }** %l7
  %t133 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t134 = load i8*, i8** %l11
  %t135 = call i1 @contains_requirement_for_effect({ %EffectRequirement*, i64 }* %t133, i8* %t134)
  %t136 = xor i1 %t135, 1
  %t137 = load double, double* %l0
  %t138 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t139 = load double, double* %l2
  %t140 = load i1, i1* %l3
  %t141 = load double, double* %l4
  %t142 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t143 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t144 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t145 = load double, double* %l9
  %t146 = load %EffectRequirement, %EffectRequirement* %l10
  %t147 = load i8*, i8** %l11
  br i1 %t136, label %then20, label %merge21
then20:
  %t148 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t149 = load %EffectRequirement, %EffectRequirement* %l10
  %t150 = call { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }* %t148, %EffectRequirement %t149)
  store { %EffectRequirement*, i64 }* %t150, { %EffectRequirement*, i64 }** %l8
  br label %merge21
merge21:
  %t151 = phi { %EffectRequirement*, i64 }* [ %t150, %then20 ], [ %t144, %loop.body11 ]
  store { %EffectRequirement*, i64 }* %t151, { %EffectRequirement*, i64 }** %l8
  %t152 = load double, double* %l9
  %t153 = sitofp i64 1 to double
  %t154 = fadd double %t152, %t153
  store double %t154, double* %l9
  br label %loop.latch12
loop.latch12:
  %t155 = load double, double* %l9
  %t156 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t157 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  br label %loop.header10
afterloop13:
  %t161 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t162 = load { i8**, i64 }, { i8**, i64 }* %t161
  %t163 = extractvalue { i8**, i64 } %t162, 1
  %t164 = icmp eq i64 %t163, 0
  %t165 = load double, double* %l0
  %t166 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t167 = load double, double* %l2
  %t168 = load i1, i1* %l3
  %t169 = load double, double* %l4
  %t170 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t171 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t172 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t173 = load double, double* %l9
  br i1 %t164, label %then22, label %merge23
then22:
  %t174 = alloca [0 x double]
  %t175 = getelementptr [0 x double], [0 x double]* %t174, i32 0, i32 0
  %t176 = alloca { double*, i64 }
  %t177 = getelementptr { double*, i64 }, { double*, i64 }* %t176, i32 0, i32 0
  store double* %t175, double** %t177
  %t178 = getelementptr { double*, i64 }, { double*, i64 }* %t176, i32 0, i32 1
  store i64 0, i64* %t178
  ret { %EffectViolation*, i64 }* null
merge23:
  %t179 = alloca [0 x double]
  %t180 = getelementptr [0 x double], [0 x double]* %t179, i32 0, i32 0
  %t181 = alloca { double*, i64 }
  %t182 = getelementptr { double*, i64 }, { double*, i64 }* %t181, i32 0, i32 0
  store double* %t180, double** %t182
  %t183 = getelementptr { double*, i64 }, { double*, i64 }* %t181, i32 0, i32 1
  store i64 0, i64* %t183
  store { %EffectViolation*, i64 }* null, { %EffectViolation*, i64 }** %l12
  %t184 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l12
  ret { %EffectViolation*, i64 }* %t184
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
  %t0 = icmp eq i8* %expression, null
  br i1 %t0, label %then0, label %merge1
then0:
  %t1 = alloca [0 x double]
  %t2 = getelementptr [0 x double], [0 x double]* %t1, i32 0, i32 0
  %t3 = alloca { double*, i64 }
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 0
  store double* %t2, double** %t4
  %t5 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  ret { %EffectRequirement*, i64 }* null
merge1:
  %t6 = alloca [0 x double]
  %t7 = getelementptr [0 x double], [0 x double]* %t6, i32 0, i32 0
  %t8 = alloca { double*, i64 }
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t8, i32 0, i32 0
  store double* %t7, double** %t9
  %t10 = getelementptr { double*, i64 }, { double*, i64 }* %t8, i32 0, i32 1
  store i64 0, i64* %t10
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
  %t51 = phi { %EffectRequirement*, i64 }* [ %t1, %entry ], [ %t49, %loop.latch2 ]
  %t52 = phi double [ %t2, %entry ], [ %t50, %loop.latch2 ]
  store { %EffectRequirement*, i64 }* %t51, { %EffectRequirement*, i64 }** %l0
  store double %t52, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t5 = extractvalue { i8**, i64 } %t4, 1
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp oge double %t3, %t6
  %t8 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t9 = load double, double* %l1
  br i1 %t7, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t10 = load double, double* %l1
  %t11 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t12 = extractvalue { i8**, i64 } %t11, 0
  %t13 = extractvalue { i8**, i64 } %t11, 1
  %t14 = icmp uge i64 %t10, %t13
  ; bounds check: %t14 (if true, out of bounds)
  %t15 = getelementptr i8*, i8** %t12, i64 %t10
  %t16 = load i8*, i8** %t15
  store i8* %t16, i8** %l2
  %t17 = load i8*, i8** %l2
  %s18 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.18, i32 0, i32 0
  %t19 = call i1 @is_identifier_token(i8* %t17, i8* %s18)
  %t20 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t21 = load double, double* %l1
  %t22 = load i8*, i8** %l2
  br i1 %t19, label %then6, label %merge7
then6:
  %t23 = load double, double* %l1
  %t24 = sitofp i64 1 to double
  %t25 = fadd double %t23, %t24
  %t26 = call double @next_non_trivia({ i8**, i64 }* %tokens, double %t25)
  store double %t26, double* %l3
  %s27 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.27, i32 0, i32 0
  store i8* %s27, i8** %l4
  %t28 = load double, double* %l3
  %t29 = sitofp i64 -1 to double
  %t30 = fcmp une double %t28, %t29
  %t31 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t32 = load double, double* %l1
  %t33 = load i8*, i8** %l2
  %t34 = load double, double* %l3
  %t35 = load i8*, i8** %l4
  br i1 %t30, label %then8, label %merge9
then8:
  %t36 = load double, double* %l3
  %t37 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t38 = extractvalue { i8**, i64 } %t37, 0
  %t39 = extractvalue { i8**, i64 } %t37, 1
  %t40 = icmp uge i64 %t36, %t39
  ; bounds check: %t40 (if true, out of bounds)
  %t41 = getelementptr i8*, i8** %t38, i64 %t36
  %t42 = load i8*, i8** %t41
  store i8* %t42, i8** %l5
  %t44 = load i8*, i8** %l5
  br label %merge9
merge9:
  br label %merge7
merge7:
  %t45 = phi { %EffectRequirement*, i64 }* [ null, %then6 ], [ %t20, %loop.body1 ]
  store { %EffectRequirement*, i64 }* %t45, { %EffectRequirement*, i64 }** %l0
  %t46 = load double, double* %l1
  %t47 = sitofp i64 1 to double
  %t48 = fadd double %t46, %t47
  store double %t48, double* %l1
  br label %loop.latch2
loop.latch2:
  %t49 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t50 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t53 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t53
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
  %t20 = phi { %EffectRequirement*, i64 }* [ %t4, %entry ], [ %t18, %loop.latch2 ]
  %t21 = phi double [ %t5, %entry ], [ %t19, %loop.latch2 ]
  store { %EffectRequirement*, i64 }* %t20, { %EffectRequirement*, i64 }** %l1
  store double %t21, double* %l2
  br label %loop.body1
loop.body1:
  %t6 = load double, double* %l2
  %t7 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t8 = load { i8**, i64 }, { i8**, i64 }* %t7
  %t9 = extractvalue { i8**, i64 } %t8, 1
  %t10 = sitofp i64 %t9 to double
  %t11 = fcmp oge double %t6, %t10
  %t12 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t13 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t14 = load double, double* %l2
  br i1 %t11, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l2
  %t16 = sitofp i64 1 to double
  %t17 = fadd double %t15, %t16
  store double %t17, double* %l2
  br label %loop.latch2
loop.latch2:
  %t18 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t19 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t22 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  ret { %EffectRequirement*, i64 }* %t22
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
  %t19 = phi { %EffectRequirement*, i64 }* [ %t3, %entry ], [ %t17, %loop.latch2 ]
  %t20 = phi double [ %t4, %entry ], [ %t18, %loop.latch2 ]
  store { %EffectRequirement*, i64 }* %t19, { %EffectRequirement*, i64 }** %l1
  store double %t20, double* %l2
  br label %loop.body1
loop.body1:
  %t5 = load double, double* %l2
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load { i8**, i64 }, { i8**, i64 }* %t6
  %t8 = extractvalue { i8**, i64 } %t7, 1
  %t9 = sitofp i64 %t8 to double
  %t10 = fcmp oge double %t5, %t9
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t12 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t13 = load double, double* %l2
  br i1 %t10, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t14 = load double, double* %l2
  %t15 = sitofp i64 1 to double
  %t16 = fadd double %t14, %t15
  store double %t16, double* %l2
  br label %loop.latch2
loop.latch2:
  %t17 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t18 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t21 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  ret { %EffectRequirement*, i64 }* %t21
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
  %t66 = phi { i8**, i64 }* [ %t6, %entry ], [ %t64, %loop.latch2 ]
  %t67 = phi double [ %t7, %entry ], [ %t65, %loop.latch2 ]
  store { i8**, i64 }* %t66, { i8**, i64 }** %l0
  store double %t67, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t10 = extractvalue { i8**, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l1
  %t16 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t17 = extractvalue { i8**, i64 } %t16, 0
  %t18 = extractvalue { i8**, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  %t20 = getelementptr i8*, i8** %t17, i64 %t15
  %t21 = load i8*, i8** %t20
  %t22 = call i1 @is_identifier_token(i8* %t21, i8* %name)
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t24 = load double, double* %l1
  br i1 %t22, label %then6, label %merge7
then6:
  %t25 = load double, double* %l1
  %t26 = sitofp i64 1 to double
  %t27 = fadd double %t25, %t26
  %t28 = call double @next_non_trivia({ i8**, i64 }* %tokens, double %t27)
  store double %t28, double* %l2
  %t30 = load double, double* %l2
  %t31 = sitofp i64 -1 to double
  %t32 = fcmp une double %t30, %t31
  br label %logical_and_entry_29

logical_and_entry_29:
  br i1 %t32, label %logical_and_right_29, label %logical_and_merge_29

logical_and_right_29:
  %t33 = load double, double* %l2
  %t34 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t35 = extractvalue { i8**, i64 } %t34, 0
  %t36 = extractvalue { i8**, i64 } %t34, 1
  %t37 = icmp uge i64 %t33, %t36
  ; bounds check: %t37 (if true, out of bounds)
  %t38 = getelementptr i8*, i8** %t35, i64 %t33
  %t39 = load i8*, i8** %t38
  %t40 = call i1 @is_symbol_token(i8* %t39, i8* %symbol)
  br label %logical_and_right_end_29

logical_and_right_end_29:
  br label %logical_and_merge_29

logical_and_merge_29:
  %t41 = phi i1 [ false, %logical_and_entry_29 ], [ %t40, %logical_and_right_end_29 ]
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t43 = load double, double* %l1
  %t44 = load double, double* %l2
  br i1 %t41, label %then8, label %merge9
then8:
  %t45 = load double, double* %l1
  %t46 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t47 = extractvalue { i8**, i64 } %t46, 0
  %t48 = extractvalue { i8**, i64 } %t46, 1
  %t49 = icmp uge i64 %t45, %t48
  ; bounds check: %t49 (if true, out of bounds)
  %t50 = getelementptr i8*, i8** %t47, i64 %t45
  %t51 = load i8*, i8** %t50
  %t52 = alloca [1 x i8*]
  %t53 = getelementptr [1 x i8*], [1 x i8*]* %t52, i32 0, i32 0
  %t54 = getelementptr i8*, i8** %t53, i64 0
  store i8* %t51, i8** %t54
  %t55 = alloca { i8**, i64 }
  %t56 = getelementptr { i8**, i64 }, { i8**, i64 }* %t55, i32 0, i32 0
  store i8** %t53, i8*** %t56
  %t57 = getelementptr { i8**, i64 }, { i8**, i64 }* %t55, i32 0, i32 1
  store i64 1, i64* %t57
  %t58 = call double @matchesconcat({ i8**, i64 }* %t55)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  br label %merge9
merge9:
  %t59 = phi { i8**, i64 }* [ null, %then8 ], [ %t42, %then6 ]
  store { i8**, i64 }* %t59, { i8**, i64 }** %l0
  br label %merge7
merge7:
  %t60 = phi { i8**, i64 }* [ null, %then6 ], [ %t23, %loop.body1 ]
  store { i8**, i64 }* %t60, { i8**, i64 }** %l0
  %t61 = load double, double* %l1
  %t62 = sitofp i64 1 to double
  %t63 = fadd double %t61, %t62
  store double %t63, double* %l1
  br label %loop.latch2
loop.latch2:
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t65 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t68
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
  %t67 = phi { i8**, i64 }* [ %t6, %entry ], [ %t65, %loop.latch2 ]
  %t68 = phi double [ %t7, %entry ], [ %t66, %loop.latch2 ]
  store { i8**, i64 }* %t67, { i8**, i64 }** %l0
  store double %t68, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t10 = extractvalue { i8**, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l1
  %t16 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t17 = extractvalue { i8**, i64 } %t16, 0
  %t18 = extractvalue { i8**, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  %t20 = getelementptr i8*, i8** %t17, i64 %t15
  %t21 = load i8*, i8** %t20
  %t22 = call i1 @is_identifier_token(i8* %t21, i8* %name)
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t24 = load double, double* %l1
  br i1 %t22, label %then6, label %merge7
then6:
  %t25 = load double, double* %l1
  %t26 = sitofp i64 1 to double
  %t27 = fadd double %t25, %t26
  %t28 = call double @next_non_trivia({ i8**, i64 }* %tokens, double %t27)
  store double %t28, double* %l2
  %t30 = load double, double* %l2
  %t31 = sitofp i64 -1 to double
  %t32 = fcmp une double %t30, %t31
  br label %logical_and_entry_29

logical_and_entry_29:
  br i1 %t32, label %logical_and_right_29, label %logical_and_merge_29

logical_and_right_29:
  %t33 = load double, double* %l2
  %t34 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t35 = extractvalue { i8**, i64 } %t34, 0
  %t36 = extractvalue { i8**, i64 } %t34, 1
  %t37 = icmp uge i64 %t33, %t36
  ; bounds check: %t37 (if true, out of bounds)
  %t38 = getelementptr i8*, i8** %t35, i64 %t33
  %t39 = load i8*, i8** %t38
  %s40 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.40, i32 0, i32 0
  %t41 = call i1 @is_symbol_token(i8* %t39, i8* %s40)
  br label %logical_and_right_end_29

logical_and_right_end_29:
  br label %logical_and_merge_29

logical_and_merge_29:
  %t42 = phi i1 [ false, %logical_and_entry_29 ], [ %t41, %logical_and_right_end_29 ]
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t44 = load double, double* %l1
  %t45 = load double, double* %l2
  br i1 %t42, label %then8, label %merge9
then8:
  %t46 = load double, double* %l1
  %t47 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t48 = extractvalue { i8**, i64 } %t47, 0
  %t49 = extractvalue { i8**, i64 } %t47, 1
  %t50 = icmp uge i64 %t46, %t49
  ; bounds check: %t50 (if true, out of bounds)
  %t51 = getelementptr i8*, i8** %t48, i64 %t46
  %t52 = load i8*, i8** %t51
  %t53 = alloca [1 x i8*]
  %t54 = getelementptr [1 x i8*], [1 x i8*]* %t53, i32 0, i32 0
  %t55 = getelementptr i8*, i8** %t54, i64 0
  store i8* %t52, i8** %t55
  %t56 = alloca { i8**, i64 }
  %t57 = getelementptr { i8**, i64 }, { i8**, i64 }* %t56, i32 0, i32 0
  store i8** %t54, i8*** %t57
  %t58 = getelementptr { i8**, i64 }, { i8**, i64 }* %t56, i32 0, i32 1
  store i64 1, i64* %t58
  %t59 = call double @matchesconcat({ i8**, i64 }* %t56)
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  br label %merge9
merge9:
  %t60 = phi { i8**, i64 }* [ null, %then8 ], [ %t43, %then6 ]
  store { i8**, i64 }* %t60, { i8**, i64 }** %l0
  br label %merge7
merge7:
  %t61 = phi { i8**, i64 }* [ null, %then6 ], [ %t23, %loop.body1 ]
  store { i8**, i64 }* %t61, { i8**, i64 }** %l0
  %t62 = load double, double* %l1
  %t63 = sitofp i64 1 to double
  %t64 = fadd double %t62, %t63
  store double %t64, double* %l1
  br label %loop.latch2
loop.latch2:
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t66 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t69
}

define double @next_non_trivia({ i8**, i64 }* %tokens, double %start) {
entry:
  %l0 = alloca double
  %l1 = alloca i8*
  store double %start, double* %l0
  %t0 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t24 = phi double [ %t0, %entry ], [ %t23, %loop.latch2 ]
  store double %t24, double* %l0
  br label %loop.body1
loop.body1:
  %t1 = load double, double* %l0
  %t2 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t3 = extractvalue { i8**, i64 } %t2, 1
  %t4 = sitofp i64 %t3 to double
  %t5 = fcmp oge double %t1, %t4
  %t6 = load double, double* %l0
  br i1 %t5, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t7 = load double, double* %l0
  %t8 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t9 = extractvalue { i8**, i64 } %t8, 0
  %t10 = extractvalue { i8**, i64 } %t8, 1
  %t11 = icmp uge i64 %t7, %t10
  ; bounds check: %t11 (if true, out of bounds)
  %t12 = getelementptr i8*, i8** %t9, i64 %t7
  %t13 = load i8*, i8** %t12
  store i8* %t13, i8** %l1
  %t14 = load i8*, i8** %l1
  %t15 = call i1 @is_trivia_token(i8* %t14)
  %t16 = xor i1 %t15, 1
  %t17 = load double, double* %l0
  %t18 = load i8*, i8** %l1
  br i1 %t16, label %then6, label %merge7
then6:
  %t19 = load double, double* %l0
  ret double %t19
merge7:
  %t20 = load double, double* %l0
  %t21 = sitofp i64 1 to double
  %t22 = fadd double %t20, %t21
  store double %t22, double* %l0
  br label %loop.latch2
loop.latch2:
  %t23 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t25 = sitofp i64 -1 to double
  ret double %t25
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
  %t29 = phi { %EffectViolation*, i64 }* [ %t1, %entry ], [ %t27, %loop.latch2 ]
  %t30 = phi double [ %t2, %entry ], [ %t28, %loop.latch2 ]
  store { %EffectViolation*, i64 }* %t29, { %EffectViolation*, i64 }** %l0
  store double %t30, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %new_violations
  %t5 = extractvalue { %EffectViolation*, i64 } %t4, 1
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp oge double %t3, %t6
  %t8 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t9 = load double, double* %l1
  br i1 %t7, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t10 = load double, double* %l1
  %t11 = load { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %new_violations
  %t12 = extractvalue { %EffectViolation*, i64 } %t11, 0
  %t13 = extractvalue { %EffectViolation*, i64 } %t11, 1
  %t14 = icmp uge i64 %t10, %t13
  ; bounds check: %t14 (if true, out of bounds)
  %t15 = getelementptr %EffectViolation, %EffectViolation* %t12, i64 %t10
  %t16 = load %EffectViolation, %EffectViolation* %t15
  %t17 = alloca [1 x %EffectViolation]
  %t18 = getelementptr [1 x %EffectViolation], [1 x %EffectViolation]* %t17, i32 0, i32 0
  %t19 = getelementptr %EffectViolation, %EffectViolation* %t18, i64 0
  store %EffectViolation %t16, %EffectViolation* %t19
  %t20 = alloca { %EffectViolation*, i64 }
  %t21 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t20, i32 0, i32 0
  store %EffectViolation* %t18, %EffectViolation** %t21
  %t22 = getelementptr { %EffectViolation*, i64 }, { %EffectViolation*, i64 }* %t20, i32 0, i32 1
  store i64 1, i64* %t22
  %t23 = call double @resultconcat({ %EffectViolation*, i64 }* %t20)
  store { %EffectViolation*, i64 }* null, { %EffectViolation*, i64 }** %l0
  %t24 = load double, double* %l1
  %t25 = sitofp i64 1 to double
  %t26 = fadd double %t24, %t25
  store double %t26, double* %l1
  br label %loop.latch2
loop.latch2:
  %t27 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t28 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t31 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  ret { %EffectViolation*, i64 }* %t31
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
  %t21 = phi double [ %t1, %entry ], [ %t20, %loop.latch2 ]
  store double %t21, double* %l0
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  %t3 = load { i8**, i64 }, { i8**, i64 }* %effects
  %t4 = extractvalue { i8**, i64 } %t3, 1
  %t5 = sitofp i64 %t4 to double
  %t6 = fcmp oge double %t2, %t5
  %t7 = load double, double* %l0
  br i1 %t6, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t8 = load double, double* %l0
  %t9 = load { i8**, i64 }, { i8**, i64 }* %effects
  %t10 = extractvalue { i8**, i64 } %t9, 0
  %t11 = extractvalue { i8**, i64 } %t9, 1
  %t12 = icmp uge i64 %t8, %t11
  ; bounds check: %t12 (if true, out of bounds)
  %t13 = getelementptr i8*, i8** %t10, i64 %t8
  %t14 = load i8*, i8** %t13
  %t15 = icmp eq i8* %t14, %effect
  %t16 = load double, double* %l0
  br i1 %t15, label %then6, label %merge7
then6:
  ret i1 1
merge7:
  %t17 = load double, double* %l0
  %t18 = sitofp i64 1 to double
  %t19 = fadd double %t17, %t18
  store double %t19, double* %l0
  br label %loop.latch2
loop.latch2:
  %t20 = load double, double* %l0
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
  %t29 = phi { %EffectRequirement*, i64 }* [ %t1, %entry ], [ %t27, %loop.latch2 ]
  %t30 = phi double [ %t2, %entry ], [ %t28, %loop.latch2 ]
  store { %EffectRequirement*, i64 }* %t29, { %EffectRequirement*, i64 }** %l0
  store double %t30, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %additions
  %t5 = extractvalue { %EffectRequirement*, i64 } %t4, 1
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp oge double %t3, %t6
  %t8 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t9 = load double, double* %l1
  br i1 %t7, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t10 = load double, double* %l1
  %t11 = load { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %additions
  %t12 = extractvalue { %EffectRequirement*, i64 } %t11, 0
  %t13 = extractvalue { %EffectRequirement*, i64 } %t11, 1
  %t14 = icmp uge i64 %t10, %t13
  ; bounds check: %t14 (if true, out of bounds)
  %t15 = getelementptr %EffectRequirement, %EffectRequirement* %t12, i64 %t10
  %t16 = load %EffectRequirement, %EffectRequirement* %t15
  %t17 = alloca [1 x %EffectRequirement]
  %t18 = getelementptr [1 x %EffectRequirement], [1 x %EffectRequirement]* %t17, i32 0, i32 0
  %t19 = getelementptr %EffectRequirement, %EffectRequirement* %t18, i64 0
  store %EffectRequirement %t16, %EffectRequirement* %t19
  %t20 = alloca { %EffectRequirement*, i64 }
  %t21 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t20, i32 0, i32 0
  store %EffectRequirement* %t18, %EffectRequirement** %t21
  %t22 = getelementptr { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t20, i32 0, i32 1
  store i64 1, i64* %t22
  %t23 = call double @resultconcat({ %EffectRequirement*, i64 }* %t20)
  store { %EffectRequirement*, i64 }* null, { %EffectRequirement*, i64 }** %l0
  %t24 = load double, double* %l1
  %t25 = sitofp i64 1 to double
  %t26 = fadd double %t24, %t25
  store double %t26, double* %l1
  br label %loop.latch2
loop.latch2:
  %t27 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t28 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t31 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t31
}

define i1 @contains_requirement_for_effect({ %EffectRequirement*, i64 }* %requirements, i8* %effect) {
entry:
  %l0 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t22 = phi double [ %t1, %entry ], [ %t21, %loop.latch2 ]
  store double %t22, double* %l0
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  %t3 = load { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %requirements
  %t4 = extractvalue { %EffectRequirement*, i64 } %t3, 1
  %t5 = sitofp i64 %t4 to double
  %t6 = fcmp oge double %t2, %t5
  %t7 = load double, double* %l0
  br i1 %t6, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t8 = load double, double* %l0
  %t9 = load { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %requirements
  %t10 = extractvalue { %EffectRequirement*, i64 } %t9, 0
  %t11 = extractvalue { %EffectRequirement*, i64 } %t9, 1
  %t12 = icmp uge i64 %t8, %t11
  ; bounds check: %t12 (if true, out of bounds)
  %t13 = getelementptr %EffectRequirement, %EffectRequirement* %t10, i64 %t8
  %t14 = load %EffectRequirement, %EffectRequirement* %t13
  %t15 = extractvalue %EffectRequirement %t14, 0
  %t16 = icmp eq i8* %t15, %effect
  %t17 = load double, double* %l0
  br i1 %t16, label %then6, label %merge7
then6:
  ret i1 1
merge7:
  %t18 = load double, double* %l0
  %t19 = sitofp i64 1 to double
  %t20 = fadd double %t18, %t19
  store double %t20, double* %l0
  br label %loop.latch2
loop.latch2:
  %t21 = load double, double* %l0
  br label %loop.header0
afterloop3:
  ret i1 0
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
