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

define { %EffectViolation*, i64 }* @validate_effects(double %program) {
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
  %t14 = phi { %EffectViolation*, i64 }* [ %t6, %entry ], [ %t13, %loop.latch2 ]
  store { %EffectViolation*, i64 }* %t14, { %EffectViolation*, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  store double 0.0, double* %l2
  %t9 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t10 = load double, double* %l2
  %t11 = call { %EffectViolation*, i64 }* @analyze_statement(double %t10)
  %t12 = call { %EffectViolation*, i64 }* @append_violations({ %EffectViolation*, i64 }* %t9, { %EffectViolation*, i64 }* %t11)
  store { %EffectViolation*, i64 }* %t12, { %EffectViolation*, i64 }** %l0
  br label %loop.latch2
loop.latch2:
  %t13 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t15 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  ret { %EffectViolation*, i64 }* %t15
}

define { %EffectViolation*, i64 }* @analyze_statement(double %statement) {
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

define { %EffectViolation*, i64 }* @analyze_routine(double %signature, double %body, double %decorators, i8* %name) {
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
  %t0 = call double @evaluate_decorators(double %decorators)
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
  %t13 = phi { i8**, i64 }* [ %t8, %entry ], [ %t12, %loop.latch2 ]
  store { i8**, i64 }* %t13, { i8**, i64 }** %l1
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l2
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %loop.latch2
loop.latch2:
  %t12 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %loop.header0
afterloop3:
  store i1 0, i1* %l3
  %t14 = sitofp i64 0 to double
  store double %t14, double* %l4
  %t15 = load double, double* %l0
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t17 = load double, double* %l2
  %t18 = load i1, i1* %l3
  %t19 = load double, double* %l4
  br label %loop.header4
loop.header4:
  br label %loop.body5
loop.body5:
  %t20 = load double, double* %l4
  %t21 = load double, double* %l0
  %t22 = load double, double* %l0
  %t23 = load double, double* %l4
  store double 0.0, double* %l5
  %t24 = load double, double* %l5
  br label %loop.latch6
loop.latch6:
  br label %loop.header4
afterloop7:
  %t25 = load i1, i1* %l3
  %t26 = load double, double* %l0
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t28 = load double, double* %l2
  %t29 = load i1, i1* %l3
  %t30 = load double, double* %l4
  br i1 %t25, label %then8, label %merge9
then8:
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s32 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.32, i32 0, i32 0
  %t33 = call { i8**, i64 }* @append_unique_effect({ i8**, i64 }* %t31, i8* %s32)
  store { i8**, i64 }* %t33, { i8**, i64 }** %l1
  br label %merge9
merge9:
  %t34 = phi { i8**, i64 }* [ %t33, %then8 ], [ %t27, %entry ]
  store { i8**, i64 }* %t34, { i8**, i64 }** %l1
  %t35 = call { %EffectRequirement*, i64 }* @required_effects(double %body)
  store { %EffectRequirement*, i64 }* %t35, { %EffectRequirement*, i64 }** %l6
  %t36 = alloca [0 x double]
  %t37 = getelementptr [0 x double], [0 x double]* %t36, i32 0, i32 0
  %t38 = alloca { double*, i64 }
  %t39 = getelementptr { double*, i64 }, { double*, i64 }* %t38, i32 0, i32 0
  store double* %t37, double** %t39
  %t40 = getelementptr { double*, i64 }, { double*, i64 }* %t38, i32 0, i32 1
  store i64 0, i64* %t40
  store { i8**, i64 }* null, { i8**, i64 }** %l7
  %t41 = alloca [0 x double]
  %t42 = getelementptr [0 x double], [0 x double]* %t41, i32 0, i32 0
  %t43 = alloca { double*, i64 }
  %t44 = getelementptr { double*, i64 }, { double*, i64 }* %t43, i32 0, i32 0
  store double* %t42, double** %t44
  %t45 = getelementptr { double*, i64 }, { double*, i64 }* %t43, i32 0, i32 1
  store i64 0, i64* %t45
  store { %EffectRequirement*, i64 }* null, { %EffectRequirement*, i64 }** %l8
  %t46 = sitofp i64 0 to double
  store double %t46, double* %l9
  %t47 = load double, double* %l0
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t49 = load double, double* %l2
  %t50 = load i1, i1* %l3
  %t51 = load double, double* %l4
  %t52 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t54 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t55 = load double, double* %l9
  br label %loop.header10
loop.header10:
  %t107 = phi { i8**, i64 }* [ %t53, %entry ], [ %t105, %loop.latch12 ]
  %t108 = phi { %EffectRequirement*, i64 }* [ %t54, %entry ], [ %t106, %loop.latch12 ]
  store { i8**, i64 }* %t107, { i8**, i64 }** %l7
  store { %EffectRequirement*, i64 }* %t108, { %EffectRequirement*, i64 }** %l8
  br label %loop.body11
loop.body11:
  %t56 = load double, double* %l9
  %t57 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t58 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t59 = load double, double* %l9
  %t60 = load { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t58
  %t61 = extractvalue { %EffectRequirement*, i64 } %t60, 0
  %t62 = extractvalue { %EffectRequirement*, i64 } %t60, 1
  %t63 = icmp uge i64 %t59, %t62
  ; bounds check: %t63 (if true, out of bounds)
  %t64 = getelementptr %EffectRequirement, %EffectRequirement* %t61, i64 %t59
  %t65 = load %EffectRequirement, %EffectRequirement* %t64
  store %EffectRequirement %t65, %EffectRequirement* %l10
  %t66 = load %EffectRequirement, %EffectRequirement* %l10
  %t67 = extractvalue %EffectRequirement %t66, 0
  store i8* %t67, i8** %l11
  %t68 = load i8*, i8** %l11
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t70 = load i8*, i8** %l11
  %t71 = call i1 @contains_effect({ i8**, i64 }* %t69, i8* %t70)
  %t72 = load double, double* %l0
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t74 = load double, double* %l2
  %t75 = load i1, i1* %l3
  %t76 = load double, double* %l4
  %t77 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t78 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t79 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t80 = load double, double* %l9
  %t81 = load %EffectRequirement, %EffectRequirement* %l10
  %t82 = load i8*, i8** %l11
  br i1 %t71, label %then14, label %merge15
then14:
  br label %loop.latch12
merge15:
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t84 = load i8*, i8** %l11
  %t85 = call { i8**, i64 }* @append_unique_effect({ i8**, i64 }* %t83, i8* %t84)
  store { i8**, i64 }* %t85, { i8**, i64 }** %l7
  %t86 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t87 = load i8*, i8** %l11
  %t88 = call double @contains_requirement_for_effect({ %EffectRequirement*, i64 }* %t86, i8* %t87)
  %t89 = fcmp one double %t88, 0.0
  %t90 = load double, double* %l0
  %t91 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t92 = load double, double* %l2
  %t93 = load i1, i1* %l3
  %t94 = load double, double* %l4
  %t95 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t96 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t97 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t98 = load double, double* %l9
  %t99 = load %EffectRequirement, %EffectRequirement* %l10
  %t100 = load i8*, i8** %l11
  br i1 %t89, label %then16, label %merge17
then16:
  %t101 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t102 = load %EffectRequirement, %EffectRequirement* %l10
  %t103 = call { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }* %t101, %EffectRequirement %t102)
  store { %EffectRequirement*, i64 }* %t103, { %EffectRequirement*, i64 }** %l8
  br label %merge17
merge17:
  %t104 = phi { %EffectRequirement*, i64 }* [ %t103, %then16 ], [ %t97, %loop.body11 ]
  store { %EffectRequirement*, i64 }* %t104, { %EffectRequirement*, i64 }** %l8
  br label %loop.latch12
loop.latch12:
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t106 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  br label %loop.header10
afterloop13:
  %t109 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t110 = alloca [0 x double]
  %t111 = getelementptr [0 x double], [0 x double]* %t110, i32 0, i32 0
  %t112 = alloca { double*, i64 }
  %t113 = getelementptr { double*, i64 }, { double*, i64 }* %t112, i32 0, i32 0
  store double* %t111, double** %t113
  %t114 = getelementptr { double*, i64 }, { double*, i64 }* %t112, i32 0, i32 1
  store i64 0, i64* %t114
  store { %EffectViolation*, i64 }* null, { %EffectViolation*, i64 }** %l12
  %t115 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l12
  ret { %EffectViolation*, i64 }* %t115
}

define { %EffectRequirement*, i64 }* @required_effects(double %body) {
entry:
  %t0 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(double %body)
  ret { %EffectRequirement*, i64 }* %t0
}

define { %EffectRequirement*, i64 }* @collect_effects_from_block(double %block) {
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
  %t6 = phi double [ %t1, %entry ], [ %t5, %loop.latch2 ]
  store double %t6, double* %l0
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load double, double* %l0
  br label %loop.latch2
loop.latch2:
  %t5 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t7 = load double, double* %l0
  ret { %EffectRequirement*, i64 }* null
}

define { %EffectRequirement*, i64 }* @collect_effects_from_statement(double %statement) {
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

define { %EffectRequirement*, i64 }* @collect_effects_from_else_branch(double %branch) {
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

define { %EffectRequirement*, i64 }* @collect_effects_from_match_case(double %case) {
entry:
  %l0 = alloca double
  store double 0.0, double* %l0
  %t0 = load double, double* %l0
  %t1 = load double, double* %l0
  ret { %EffectRequirement*, i64 }* null
}

define { %EffectRequirement*, i64 }* @collect_effects_from_expression(double %expression) {
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

define { %EffectRequirement*, i64 }* @collect_effects_from_tokens(double %tokens) {
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
  %t6 = call { %EffectRequirement*, i64 }* @append_prompt_effect({ %EffectRequirement*, i64 }* %t5, double %tokens)
  store { %EffectRequirement*, i64 }* %t6, { %EffectRequirement*, i64 }** %l0
  %t7 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s8 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.8, i32 0, i32 0
  %s9 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.9, i32 0, i32 0
  %s10 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.10, i32 0, i32 0
  %t11 = call { %EffectRequirement*, i64 }* @append_identifier_dot_effect({ %EffectRequirement*, i64 }* %t7, double %tokens, i8* %s8, i8* %s9, i8* %s10)
  store { %EffectRequirement*, i64 }* %t11, { %EffectRequirement*, i64 }** %l0
  %t12 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s13 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.13, i32 0, i32 0
  %s14 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.14, i32 0, i32 0
  %s15 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.15, i32 0, i32 0
  %t16 = call { %EffectRequirement*, i64 }* @append_identifier_dot_effect({ %EffectRequirement*, i64 }* %t12, double %tokens, i8* %s13, i8* %s14, i8* %s15)
  store { %EffectRequirement*, i64 }* %t16, { %EffectRequirement*, i64 }** %l0
  %t17 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s18 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.18, i32 0, i32 0
  %s19 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.19, i32 0, i32 0
  %s20 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.20, i32 0, i32 0
  %t21 = call { %EffectRequirement*, i64 }* @append_identifier_dot_effect({ %EffectRequirement*, i64 }* %t17, double %tokens, i8* %s18, i8* %s19, i8* %s20)
  store { %EffectRequirement*, i64 }* %t21, { %EffectRequirement*, i64 }** %l0
  %t22 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s23 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.23, i32 0, i32 0
  %s24 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.24, i32 0, i32 0
  %s25 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.25, i32 0, i32 0
  %t26 = call { %EffectRequirement*, i64 }* @append_identifier_dot_effect({ %EffectRequirement*, i64 }* %t22, double %tokens, i8* %s23, i8* %s24, i8* %s25)
  store { %EffectRequirement*, i64 }* %t26, { %EffectRequirement*, i64 }** %l0
  %t27 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s28 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.28, i32 0, i32 0
  %s29 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.29, i32 0, i32 0
  %s30 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.30, i32 0, i32 0
  %t31 = call { %EffectRequirement*, i64 }* @append_identifier_dot_effect({ %EffectRequirement*, i64 }* %t27, double %tokens, i8* %s28, i8* %s29, i8* %s30)
  store { %EffectRequirement*, i64 }* %t31, { %EffectRequirement*, i64 }** %l0
  %t32 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s33 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.33, i32 0, i32 0
  %s34 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.34, i32 0, i32 0
  %s35 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.35, i32 0, i32 0
  %t36 = call { %EffectRequirement*, i64 }* @append_identifier_call_effect({ %EffectRequirement*, i64 }* %t32, double %tokens, i8* %s33, i8* %s34, i8* %s35)
  store { %EffectRequirement*, i64 }* %t36, { %EffectRequirement*, i64 }** %l0
  %t37 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s38 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.38, i32 0, i32 0
  %s39 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.39, i32 0, i32 0
  %s40 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.40, i32 0, i32 0
  %t41 = call { %EffectRequirement*, i64 }* @append_identifier_call_effect({ %EffectRequirement*, i64 }* %t37, double %tokens, i8* %s38, i8* %s39, i8* %s40)
  store { %EffectRequirement*, i64 }* %t41, { %EffectRequirement*, i64 }** %l0
  %t42 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s43 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.43, i32 0, i32 0
  %s44 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.44, i32 0, i32 0
  %s45 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.45, i32 0, i32 0
  %t46 = call { %EffectRequirement*, i64 }* @append_identifier_call_effect({ %EffectRequirement*, i64 }* %t42, double %tokens, i8* %s43, i8* %s44, i8* %s45)
  store { %EffectRequirement*, i64 }* %t46, { %EffectRequirement*, i64 }** %l0
  %t47 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t47
}

define { %EffectRequirement*, i64 }* @append_prompt_effect({ %EffectRequirement*, i64 }* %requirements, double %tokens) {
entry:
  %l0 = alloca { %EffectRequirement*, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca double
  store { %EffectRequirement*, i64 }* %requirements, { %EffectRequirement*, i64 }** %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t28 = phi { %EffectRequirement*, i64 }* [ %t1, %entry ], [ %t27, %loop.latch2 ]
  store { %EffectRequirement*, i64 }* %t28, { %EffectRequirement*, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load double, double* %l1
  store double 0.0, double* %l2
  %t5 = load double, double* %l2
  %s6 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.6, i32 0, i32 0
  %t7 = call i1 @is_identifier_token(double %t5, i8* %s6)
  %t8 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t9 = load double, double* %l1
  %t10 = load double, double* %l2
  br i1 %t7, label %then4, label %merge5
then4:
  %t11 = load double, double* %l1
  %t12 = sitofp i64 1 to double
  %t13 = fadd double %t11, %t12
  %t14 = call double @next_non_trivia(double %tokens, double %t13)
  store double %t14, double* %l3
  %s15 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.15, i32 0, i32 0
  store i8* %s15, i8** %l4
  %t16 = load double, double* %l3
  %t17 = sitofp i64 -1 to double
  %t18 = fcmp une double %t16, %t17
  %t19 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t20 = load double, double* %l1
  %t21 = load double, double* %l2
  %t22 = load double, double* %l3
  %t23 = load i8*, i8** %l4
  br i1 %t18, label %then6, label %merge7
then6:
  %t24 = load double, double* %l3
  store double 0.0, double* %l5
  %t25 = load double, double* %l5
  br label %merge7
merge7:
  br label %merge5
merge5:
  %t26 = phi { %EffectRequirement*, i64 }* [ null, %then4 ], [ %t8, %loop.body1 ]
  store { %EffectRequirement*, i64 }* %t26, { %EffectRequirement*, i64 }** %l0
  br label %loop.latch2
loop.latch2:
  %t27 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t29 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t29
}

define { %EffectRequirement*, i64 }* @append_identifier_dot_effect({ %EffectRequirement*, i64 }* %requirements, double %tokens, i8* %identifier, i8* %effect, i8* %description) {
entry:
  %l0 = alloca double
  %l1 = alloca { %EffectRequirement*, i64 }*
  %l2 = alloca double
  %s0 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.0, i32 0, i32 0
  %t1 = call double @find_identifier_followed_by_symbol(double %tokens, i8* %identifier, i8* %s0)
  store double %t1, double* %l0
  store { %EffectRequirement*, i64 }* %requirements, { %EffectRequirement*, i64 }** %l1
  %t2 = sitofp i64 0 to double
  store double %t2, double* %l2
  %t3 = load double, double* %l0
  %t4 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t5 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t9 = phi { %EffectRequirement*, i64 }* [ %t4, %entry ], [ %t8, %loop.latch2 ]
  store { %EffectRequirement*, i64 }* %t9, { %EffectRequirement*, i64 }** %l1
  br label %loop.body1
loop.body1:
  %t6 = load double, double* %l2
  %t7 = load double, double* %l0
  br label %loop.latch2
loop.latch2:
  %t8 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  br label %loop.header0
afterloop3:
  %t10 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  ret { %EffectRequirement*, i64 }* %t10
}

define { %EffectRequirement*, i64 }* @append_identifier_call_effect({ %EffectRequirement*, i64 }* %requirements, double %tokens, i8* %identifier, i8* %effect, i8* %description) {
entry:
  %l0 = alloca double
  %l1 = alloca { %EffectRequirement*, i64 }*
  %l2 = alloca double
  %t0 = call double @find_identifier_call(double %tokens, i8* %identifier)
  store double %t0, double* %l0
  store { %EffectRequirement*, i64 }* %requirements, { %EffectRequirement*, i64 }** %l1
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l2
  %t2 = load double, double* %l0
  %t3 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  %t4 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t8 = phi { %EffectRequirement*, i64 }* [ %t3, %entry ], [ %t7, %loop.latch2 ]
  store { %EffectRequirement*, i64 }* %t8, { %EffectRequirement*, i64 }** %l1
  br label %loop.body1
loop.body1:
  %t5 = load double, double* %l2
  %t6 = load double, double* %l0
  br label %loop.latch2
loop.latch2:
  %t7 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  br label %loop.header0
afterloop3:
  %t9 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l1
  ret { %EffectRequirement*, i64 }* %t9
}

define double @next_non_trivia(double %tokens, double %start) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  store double %start, double* %l0
  %t0 = load double, double* %l0
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t1 = load double, double* %l0
  %t2 = load double, double* %l0
  store double 0.0, double* %l1
  %t3 = load double, double* %l1
  %t4 = call double @is_trivia_token(double %t3)
  %t5 = fcmp one double %t4, 0.0
  %t6 = load double, double* %l0
  %t7 = load double, double* %l1
  br i1 %t5, label %then4, label %merge5
then4:
  %t8 = load double, double* %l0
  ret double %t8
merge5:
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t9 = sitofp i64 -1 to double
  ret double %t9
}

define i1 @is_trivia_token(double %token) {
entry:
  ret i1 false
}

define i1 @is_identifier_token(double %token, i8* %expected) {
entry:
  ret i1 false
}

define i1 @is_symbol_token(double %token, i8* %expected) {
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
  %t19 = phi { %EffectViolation*, i64 }* [ %t1, %entry ], [ %t18, %loop.latch2 ]
  store { %EffectViolation*, i64 }* %t19, { %EffectViolation*, i64 }** %l0
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
  br label %loop.latch2
loop.latch2:
  %t18 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t20 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  ret { %EffectViolation*, i64 }* %t20
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
  br label %loop.latch2
loop.latch2:
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
  %t19 = phi { %EffectRequirement*, i64 }* [ %t1, %entry ], [ %t18, %loop.latch2 ]
  store { %EffectRequirement*, i64 }* %t19, { %EffectRequirement*, i64 }** %l0
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
  br label %loop.latch2
loop.latch2:
  %t18 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t20 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t20
}

define i1 @contains_requirement_for_effect({ %EffectRequirement*, i64 }* %requirements, i8* %effect) {
entry:
  %l0 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
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
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  ret i1 0
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
