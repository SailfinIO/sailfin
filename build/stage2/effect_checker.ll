; ModuleID = 'sailfin'
source_filename = "sailfin"

%EffectRequirement = type { i8*, i8*, i8* }
%EffectViolation = type { i8*, { i8**, i64 }*, { i8**, i64 }* }
%Program = type { { i8**, i64 }* }
%TypeAnnotation = type { i8* }
%TypeParameter = type { i8*, i8*, i8* }
%Block = type { { i8**, i64 }*, i8*, { i8**, i64 }* }
%SourceSpan = type { double, double, double, double }
%Parameter = type { i8*, i8*, i8*, i1, i8* }
%WithClause = type { i8* }
%ObjectField = type { i8*, i8* }
%ElseBranch = type { i8*, i8* }
%ForClause = type { i8*, i8*, { i8**, i64 }* }
%MatchCase = type { i8*, i8*, i8* }
%ModelProperty = type { i8*, i8*, i8* }
%FieldDeclaration = type { i8*, i8*, i1, i8* }
%MethodDeclaration = type { i8*, i8*, { i8**, i64 }* }
%EnumVariant = type { i8*, { i8**, i64 }*, i8* }
%FunctionSignature = type { i8*, i1, { i8**, i64 }*, i8*, { i8**, i64 }*, { i8**, i64 }*, i8* }
%PipelineDeclaration = type { i8*, i8*, { i8**, i64 }* }
%ToolDeclaration = type { i8*, i8*, { i8**, i64 }* }
%TestDeclaration = type { i8*, i8*, { i8**, i64 }*, { i8**, i64 }* }
%ModelDeclaration = type { i8*, i8*, { i8**, i64 }*, { i8**, i64 }*, { i8**, i64 }* }
%Decorator = type { i8*, { i8**, i64 }* }
%DecoratorArgument = type { i8*, i8* }
%ImportSpecifier = type { i8*, i8* }
%ExportSpecifier = type { i8*, i8* }
%Token = type { i8*, i8*, double, double }
%DecoratorArgumentInfo = type { i8*, i8* }
%DecoratorInfo = type { i8*, { i8**, i64 }* }

%Expression = type { i32, [24 x i8] }
%Statement = type { i32, [56 x i8] }
%TokenKind = type { i32, [8 x i8] }
%LiteralValue = type { i32, [8 x i8] }

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

define { %EffectViolation*, i64 }* @validate_effects(%Program %program) {
entry:
  %l0 = alloca { %EffectViolation*, i64 }*
  %l1 = alloca double
  %l2 = alloca i8*
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
  %t33 = phi { %EffectViolation*, i64 }* [ %t6, %entry ], [ %t31, %loop.latch2 ]
  %t34 = phi double [ %t7, %entry ], [ %t32, %loop.latch2 ]
  store { %EffectViolation*, i64 }* %t33, { %EffectViolation*, i64 }** %l0
  store double %t34, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = extractvalue %Program %program, 0
  %t10 = load { i8**, i64 }, { i8**, i64 }* %t9
  %t11 = extractvalue { i8**, i64 } %t10, 1
  %t12 = sitofp i64 %t11 to double
  %t13 = fcmp oge double %t8, %t12
  %t14 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t15 = load double, double* %l1
  br i1 %t13, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t16 = extractvalue %Program %program, 0
  %t17 = load double, double* %l1
  %t18 = load { i8**, i64 }, { i8**, i64 }* %t16
  %t19 = extractvalue { i8**, i64 } %t18, 0
  %t20 = extractvalue { i8**, i64 } %t18, 1
  %t21 = icmp uge i64 %t17, %t20
  ; bounds check: %t21 (if true, out of bounds)
  %t22 = getelementptr i8*, i8** %t19, i64 %t17
  %t23 = load i8*, i8** %t22
  store i8* %t23, i8** %l2
  %t24 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t25 = load i8*, i8** %l2
  %t26 = call { %EffectViolation*, i64 }* @analyze_statement(%Statement zeroinitializer)
  %t27 = call { %EffectViolation*, i64 }* @append_violations({ %EffectViolation*, i64 }* %t24, { %EffectViolation*, i64 }* %t26)
  store { %EffectViolation*, i64 }* %t27, { %EffectViolation*, i64 }** %l0
  %t28 = load double, double* %l1
  %t29 = sitofp i64 1 to double
  %t30 = fadd double %t28, %t29
  store double %t30, double* %l1
  br label %loop.latch2
loop.latch2:
  %t31 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  %t32 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t35 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l0
  ret { %EffectViolation*, i64 }* %t35
}

define { %EffectViolation*, i64 }* @analyze_statement(%Statement %statement) {
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

define { %EffectViolation*, i64 }* @analyze_routine(%FunctionSignature %signature, %Block %body, { %Decorator*, i64 }* %decorators, i8* %name) {
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
  %t0 = call double @evaluate_decorators({ %Decorator*, i64 }* %decorators)
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
  %t34 = phi { i8**, i64 }* [ %t8, %entry ], [ %t32, %loop.latch2 ]
  %t35 = phi double [ %t9, %entry ], [ %t33, %loop.latch2 ]
  store { i8**, i64 }* %t34, { i8**, i64 }** %l1
  store double %t35, double* %l2
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l2
  %t11 = extractvalue %FunctionSignature %signature, 4
  %t12 = load { i8**, i64 }, { i8**, i64 }* %t11
  %t13 = extractvalue { i8**, i64 } %t12, 1
  %t14 = sitofp i64 %t13 to double
  %t15 = fcmp oge double %t10, %t14
  %t16 = load double, double* %l0
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t18 = load double, double* %l2
  br i1 %t15, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t20 = extractvalue %FunctionSignature %signature, 4
  %t21 = load double, double* %l2
  %t22 = load { i8**, i64 }, { i8**, i64 }* %t20
  %t23 = extractvalue { i8**, i64 } %t22, 0
  %t24 = extractvalue { i8**, i64 } %t22, 1
  %t25 = icmp uge i64 %t21, %t24
  ; bounds check: %t25 (if true, out of bounds)
  %t26 = getelementptr i8*, i8** %t23, i64 %t21
  %t27 = load i8*, i8** %t26
  %t28 = call { i8**, i64 }* @append_unique_effect({ i8**, i64 }* %t19, i8* %t27)
  store { i8**, i64 }* %t28, { i8**, i64 }** %l1
  %t29 = load double, double* %l2
  %t30 = sitofp i64 1 to double
  %t31 = fadd double %t29, %t30
  store double %t31, double* %l2
  br label %loop.latch2
loop.latch2:
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t33 = load double, double* %l2
  br label %loop.header0
afterloop3:
  store i1 0, i1* %l3
  %t36 = sitofp i64 0 to double
  store double %t36, double* %l4
  %t37 = load double, double* %l0
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t39 = load double, double* %l2
  %t40 = load i1, i1* %l3
  %t41 = load double, double* %l4
  br label %loop.header6
loop.header6:
  %t53 = phi double [ %t41, %entry ], [ %t52, %loop.latch8 ]
  store double %t53, double* %l4
  br label %loop.body7
loop.body7:
  %t42 = load double, double* %l4
  %t43 = load double, double* %l0
  %t44 = load double, double* %l0
  %t45 = load double, double* %l4
  store double 0.0, double* %l5
  %t48 = load double, double* %l5
  %t49 = load double, double* %l4
  %t50 = sitofp i64 1 to double
  %t51 = fadd double %t49, %t50
  store double %t51, double* %l4
  br label %loop.latch8
loop.latch8:
  %t52 = load double, double* %l4
  br label %loop.header6
afterloop9:
  %t54 = load i1, i1* %l3
  %t55 = load double, double* %l0
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t57 = load double, double* %l2
  %t58 = load i1, i1* %l3
  %t59 = load double, double* %l4
  br i1 %t54, label %then10, label %merge11
then10:
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s61 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.61, i32 0, i32 0
  %t62 = call { i8**, i64 }* @append_unique_effect({ i8**, i64 }* %t60, i8* %s61)
  store { i8**, i64 }* %t62, { i8**, i64 }** %l1
  br label %merge11
merge11:
  %t63 = phi { i8**, i64 }* [ %t62, %then10 ], [ %t56, %entry ]
  store { i8**, i64 }* %t63, { i8**, i64 }** %l1
  %t64 = call { %EffectRequirement*, i64 }* @required_effects(%Block %body)
  store { %EffectRequirement*, i64 }* %t64, { %EffectRequirement*, i64 }** %l6
  %t65 = alloca [0 x double]
  %t66 = getelementptr [0 x double], [0 x double]* %t65, i32 0, i32 0
  %t67 = alloca { double*, i64 }
  %t68 = getelementptr { double*, i64 }, { double*, i64 }* %t67, i32 0, i32 0
  store double* %t66, double** %t68
  %t69 = getelementptr { double*, i64 }, { double*, i64 }* %t67, i32 0, i32 1
  store i64 0, i64* %t69
  store { i8**, i64 }* null, { i8**, i64 }** %l7
  %t70 = alloca [0 x double]
  %t71 = getelementptr [0 x double], [0 x double]* %t70, i32 0, i32 0
  %t72 = alloca { double*, i64 }
  %t73 = getelementptr { double*, i64 }, { double*, i64 }* %t72, i32 0, i32 0
  store double* %t71, double** %t73
  %t74 = getelementptr { double*, i64 }, { double*, i64 }* %t72, i32 0, i32 1
  store i64 0, i64* %t74
  store { %EffectRequirement*, i64 }* null, { %EffectRequirement*, i64 }** %l8
  %t75 = sitofp i64 0 to double
  store double %t75, double* %l9
  %t76 = load double, double* %l0
  %t77 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t78 = load double, double* %l2
  %t79 = load i1, i1* %l3
  %t80 = load double, double* %l4
  %t81 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t82 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t83 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t84 = load double, double* %l9
  br label %loop.header12
loop.header12:
  %t175 = phi double [ %t84, %entry ], [ %t172, %loop.latch14 ]
  %t176 = phi { i8**, i64 }* [ %t82, %entry ], [ %t173, %loop.latch14 ]
  %t177 = phi { %EffectRequirement*, i64 }* [ %t83, %entry ], [ %t174, %loop.latch14 ]
  store double %t175, double* %l9
  store { i8**, i64 }* %t176, { i8**, i64 }** %l7
  store { %EffectRequirement*, i64 }* %t177, { %EffectRequirement*, i64 }** %l8
  br label %loop.body13
loop.body13:
  %t85 = load double, double* %l9
  %t86 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t87 = load { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t86
  %t88 = extractvalue { %EffectRequirement*, i64 } %t87, 1
  %t89 = sitofp i64 %t88 to double
  %t90 = fcmp oge double %t85, %t89
  %t91 = load double, double* %l0
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t93 = load double, double* %l2
  %t94 = load i1, i1* %l3
  %t95 = load double, double* %l4
  %t96 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t97 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t98 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t99 = load double, double* %l9
  br i1 %t90, label %then16, label %merge17
then16:
  br label %afterloop15
merge17:
  %t100 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t101 = load double, double* %l9
  %t102 = load { %EffectRequirement*, i64 }, { %EffectRequirement*, i64 }* %t100
  %t103 = extractvalue { %EffectRequirement*, i64 } %t102, 0
  %t104 = extractvalue { %EffectRequirement*, i64 } %t102, 1
  %t105 = icmp uge i64 %t101, %t104
  ; bounds check: %t105 (if true, out of bounds)
  %t106 = getelementptr %EffectRequirement, %EffectRequirement* %t103, i64 %t101
  %t107 = load %EffectRequirement, %EffectRequirement* %t106
  store %EffectRequirement %t107, %EffectRequirement* %l10
  %t108 = load %EffectRequirement, %EffectRequirement* %l10
  %t109 = extractvalue %EffectRequirement %t108, 0
  store i8* %t109, i8** %l11
  %t111 = load i8*, i8** %l11
  %s112 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.112, i32 0, i32 0
  %t113 = icmp eq i8* %t111, %s112
  br label %logical_and_entry_110

logical_and_entry_110:
  br i1 %t113, label %logical_and_right_110, label %logical_and_merge_110

logical_and_right_110:
  %t114 = load i1, i1* %l3
  br label %logical_and_right_end_110

logical_and_right_end_110:
  br label %logical_and_merge_110

logical_and_merge_110:
  %t115 = phi i1 [ false, %logical_and_entry_110 ], [ %t114, %logical_and_right_end_110 ]
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
  br label %loop.latch14
merge19:
  %t130 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t131 = load i8*, i8** %l11
  %t132 = call i1 @contains_effect({ i8**, i64 }* %t130, i8* %t131)
  %t133 = load double, double* %l0
  %t134 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t135 = load double, double* %l2
  %t136 = load i1, i1* %l3
  %t137 = load double, double* %l4
  %t138 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t139 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t140 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t141 = load double, double* %l9
  %t142 = load %EffectRequirement, %EffectRequirement* %l10
  %t143 = load i8*, i8** %l11
  br i1 %t132, label %then20, label %merge21
then20:
  %t144 = load double, double* %l9
  %t145 = sitofp i64 1 to double
  %t146 = fadd double %t144, %t145
  store double %t146, double* %l9
  br label %loop.latch14
merge21:
  %t147 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t148 = load i8*, i8** %l11
  %t149 = call { i8**, i64 }* @append_unique_effect({ i8**, i64 }* %t147, i8* %t148)
  store { i8**, i64 }* %t149, { i8**, i64 }** %l7
  %t150 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t151 = load i8*, i8** %l11
  %t152 = call i1 @contains_requirement_for_effect({ %EffectRequirement*, i64 }* %t150, i8* %t151)
  %t153 = xor i1 %t152, 1
  %t154 = load double, double* %l0
  %t155 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t156 = load double, double* %l2
  %t157 = load i1, i1* %l3
  %t158 = load double, double* %l4
  %t159 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t160 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t161 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t162 = load double, double* %l9
  %t163 = load %EffectRequirement, %EffectRequirement* %l10
  %t164 = load i8*, i8** %l11
  br i1 %t153, label %then22, label %merge23
then22:
  %t165 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t166 = load %EffectRequirement, %EffectRequirement* %l10
  %t167 = call { %EffectRequirement*, i64 }* @append_requirement({ %EffectRequirement*, i64 }* %t165, %EffectRequirement %t166)
  store { %EffectRequirement*, i64 }* %t167, { %EffectRequirement*, i64 }** %l8
  br label %merge23
merge23:
  %t168 = phi { %EffectRequirement*, i64 }* [ %t167, %then22 ], [ %t161, %loop.body13 ]
  store { %EffectRequirement*, i64 }* %t168, { %EffectRequirement*, i64 }** %l8
  %t169 = load double, double* %l9
  %t170 = sitofp i64 1 to double
  %t171 = fadd double %t169, %t170
  store double %t171, double* %l9
  br label %loop.latch14
loop.latch14:
  %t172 = load double, double* %l9
  %t173 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t174 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  br label %loop.header12
afterloop15:
  %t178 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t179 = load { i8**, i64 }, { i8**, i64 }* %t178
  %t180 = extractvalue { i8**, i64 } %t179, 1
  %t181 = icmp eq i64 %t180, 0
  %t182 = load double, double* %l0
  %t183 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t184 = load double, double* %l2
  %t185 = load i1, i1* %l3
  %t186 = load double, double* %l4
  %t187 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l6
  %t188 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t189 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l8
  %t190 = load double, double* %l9
  br i1 %t181, label %then24, label %merge25
then24:
  %t191 = alloca [0 x double]
  %t192 = getelementptr [0 x double], [0 x double]* %t191, i32 0, i32 0
  %t193 = alloca { double*, i64 }
  %t194 = getelementptr { double*, i64 }, { double*, i64 }* %t193, i32 0, i32 0
  store double* %t192, double** %t194
  %t195 = getelementptr { double*, i64 }, { double*, i64 }* %t193, i32 0, i32 1
  store i64 0, i64* %t195
  ret { %EffectViolation*, i64 }* null
merge25:
  %t196 = alloca [0 x double]
  %t197 = getelementptr [0 x double], [0 x double]* %t196, i32 0, i32 0
  %t198 = alloca { double*, i64 }
  %t199 = getelementptr { double*, i64 }, { double*, i64 }* %t198, i32 0, i32 0
  store double* %t197, double** %t199
  %t200 = getelementptr { double*, i64 }, { double*, i64 }* %t198, i32 0, i32 1
  store i64 0, i64* %t200
  store { %EffectViolation*, i64 }* null, { %EffectViolation*, i64 }** %l12
  %t201 = load { %EffectViolation*, i64 }*, { %EffectViolation*, i64 }** %l12
  ret { %EffectViolation*, i64 }* %t201
}

define { %EffectRequirement*, i64 }* @required_effects(%Block %body) {
entry:
  %t0 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %body)
  ret { %EffectRequirement*, i64 }* %t0
}

define { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block %block) {
entry:
  %l0 = alloca { %EffectRequirement*, i64 }*
  %l1 = alloca double
  %t0 = extractvalue %Block %block, 0
  %t1 = call { %EffectRequirement*, i64 }* @collect_effects_from_tokens({ %Token*, i64 }* null)
  store { %EffectRequirement*, i64 }* %t1, { %EffectRequirement*, i64 }** %l0
  %t2 = sitofp i64 0 to double
  store double %t2, double* %l1
  %t3 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t4 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t29 = phi { %EffectRequirement*, i64 }* [ %t3, %entry ], [ %t27, %loop.latch2 ]
  %t30 = phi double [ %t4, %entry ], [ %t28, %loop.latch2 ]
  store { %EffectRequirement*, i64 }* %t29, { %EffectRequirement*, i64 }** %l0
  store double %t30, double* %l1
  br label %loop.body1
loop.body1:
  %t5 = load double, double* %l1
  %t6 = extractvalue %Block %block, 2
  %t7 = load { i8**, i64 }, { i8**, i64 }* %t6
  %t8 = extractvalue { i8**, i64 } %t7, 1
  %t9 = sitofp i64 %t8 to double
  %t10 = fcmp oge double %t5, %t9
  %t11 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t12 = load double, double* %l1
  br i1 %t10, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t13 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t14 = extractvalue %Block %block, 2
  %t15 = load double, double* %l1
  %t16 = load { i8**, i64 }, { i8**, i64 }* %t14
  %t17 = extractvalue { i8**, i64 } %t16, 0
  %t18 = extractvalue { i8**, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  %t20 = getelementptr i8*, i8** %t17, i64 %t15
  %t21 = load i8*, i8** %t20
  %t22 = call { %EffectRequirement*, i64 }* @collect_effects_from_statement(%Statement zeroinitializer)
  %t23 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t13, { %EffectRequirement*, i64 }* %t22)
  store { %EffectRequirement*, i64 }* %t23, { %EffectRequirement*, i64 }** %l0
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

define { %EffectRequirement*, i64 }* @collect_effects_from_statement(%Statement %statement) {
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

define { %EffectRequirement*, i64 }* @collect_effects_from_else_branch(%ElseBranch %branch) {
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
  %t5 = extractvalue %ElseBranch %branch, 1
  %t6 = icmp ne i8* %t5, null
  %t7 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  br i1 %t6, label %then0, label %merge1
then0:
  %t8 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t9 = extractvalue %ElseBranch %branch, 1
  %t10 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block zeroinitializer)
  %t11 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t8, { %EffectRequirement*, i64 }* %t10)
  store { %EffectRequirement*, i64 }* %t11, { %EffectRequirement*, i64 }** %l0
  br label %merge1
merge1:
  %t12 = phi { %EffectRequirement*, i64 }* [ %t11, %then0 ], [ %t7, %entry ]
  store { %EffectRequirement*, i64 }* %t12, { %EffectRequirement*, i64 }** %l0
  %t13 = extractvalue %ElseBranch %branch, 0
  %t14 = icmp ne i8* %t13, null
  %t15 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  br i1 %t14, label %then2, label %merge3
then2:
  %t16 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t17 = extractvalue %ElseBranch %branch, 0
  %t18 = call { %EffectRequirement*, i64 }* @collect_effects_from_statement(%Statement zeroinitializer)
  %t19 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t16, { %EffectRequirement*, i64 }* %t18)
  store { %EffectRequirement*, i64 }* %t19, { %EffectRequirement*, i64 }** %l0
  br label %merge3
merge3:
  %t20 = phi { %EffectRequirement*, i64 }* [ %t19, %then2 ], [ %t15, %entry ]
  store { %EffectRequirement*, i64 }* %t20, { %EffectRequirement*, i64 }** %l0
  %t21 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t21
}

define { %EffectRequirement*, i64 }* @collect_effects_from_match_case(%MatchCase %case) {
entry:
  %l0 = alloca { %EffectRequirement*, i64 }*
  %t0 = extractvalue %MatchCase %case, 0
  %t1 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(i8* %t0)
  store { %EffectRequirement*, i64 }* %t1, { %EffectRequirement*, i64 }** %l0
  %t2 = extractvalue %MatchCase %case, 1
  %t3 = icmp ne i8* %t2, null
  %t4 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t6 = extractvalue %MatchCase %case, 1
  %t7 = call { %EffectRequirement*, i64 }* @collect_effects_from_expression(i8* %t6)
  %t8 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t5, { %EffectRequirement*, i64 }* %t7)
  store { %EffectRequirement*, i64 }* %t8, { %EffectRequirement*, i64 }** %l0
  br label %merge1
merge1:
  %t9 = phi { %EffectRequirement*, i64 }* [ %t8, %then0 ], [ %t4, %entry ]
  store { %EffectRequirement*, i64 }* %t9, { %EffectRequirement*, i64 }** %l0
  %t10 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t11 = extractvalue %MatchCase %case, 2
  %t12 = call { %EffectRequirement*, i64 }* @collect_effects_from_block(%Block zeroinitializer)
  %t13 = call { %EffectRequirement*, i64 }* @merge_requirements({ %EffectRequirement*, i64 }* %t10, { %EffectRequirement*, i64 }* %t12)
  store { %EffectRequirement*, i64 }* %t13, { %EffectRequirement*, i64 }** %l0
  %t14 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t14
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

define { %EffectRequirement*, i64 }* @collect_effects_from_tokens({ %Token*, i64 }* %tokens) {
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
  %t6 = call { %EffectRequirement*, i64 }* @append_prompt_effect({ %EffectRequirement*, i64 }* %t5, { %Token*, i64 }* %tokens)
  store { %EffectRequirement*, i64 }* %t6, { %EffectRequirement*, i64 }** %l0
  %t7 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s8 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.8, i32 0, i32 0
  %s9 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.9, i32 0, i32 0
  %s10 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.10, i32 0, i32 0
  %t11 = call { %EffectRequirement*, i64 }* @append_identifier_dot_effect({ %EffectRequirement*, i64 }* %t7, { %Token*, i64 }* %tokens, i8* %s8, i8* %s9, i8* %s10)
  store { %EffectRequirement*, i64 }* %t11, { %EffectRequirement*, i64 }** %l0
  %t12 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s13 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.13, i32 0, i32 0
  %s14 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.14, i32 0, i32 0
  %s15 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.15, i32 0, i32 0
  %t16 = call { %EffectRequirement*, i64 }* @append_identifier_dot_effect({ %EffectRequirement*, i64 }* %t12, { %Token*, i64 }* %tokens, i8* %s13, i8* %s14, i8* %s15)
  store { %EffectRequirement*, i64 }* %t16, { %EffectRequirement*, i64 }** %l0
  %t17 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s18 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.18, i32 0, i32 0
  %s19 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.19, i32 0, i32 0
  %s20 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.20, i32 0, i32 0
  %t21 = call { %EffectRequirement*, i64 }* @append_identifier_dot_effect({ %EffectRequirement*, i64 }* %t17, { %Token*, i64 }* %tokens, i8* %s18, i8* %s19, i8* %s20)
  store { %EffectRequirement*, i64 }* %t21, { %EffectRequirement*, i64 }** %l0
  %t22 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s23 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.23, i32 0, i32 0
  %s24 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.24, i32 0, i32 0
  %s25 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.25, i32 0, i32 0
  %t26 = call { %EffectRequirement*, i64 }* @append_identifier_dot_effect({ %EffectRequirement*, i64 }* %t22, { %Token*, i64 }* %tokens, i8* %s23, i8* %s24, i8* %s25)
  store { %EffectRequirement*, i64 }* %t26, { %EffectRequirement*, i64 }** %l0
  %t27 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s28 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.28, i32 0, i32 0
  %s29 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.29, i32 0, i32 0
  %s30 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.30, i32 0, i32 0
  %t31 = call { %EffectRequirement*, i64 }* @append_identifier_dot_effect({ %EffectRequirement*, i64 }* %t27, { %Token*, i64 }* %tokens, i8* %s28, i8* %s29, i8* %s30)
  store { %EffectRequirement*, i64 }* %t31, { %EffectRequirement*, i64 }** %l0
  %t32 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s33 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.33, i32 0, i32 0
  %s34 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.34, i32 0, i32 0
  %s35 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.35, i32 0, i32 0
  %t36 = call { %EffectRequirement*, i64 }* @append_identifier_call_effect({ %EffectRequirement*, i64 }* %t32, { %Token*, i64 }* %tokens, i8* %s33, i8* %s34, i8* %s35)
  store { %EffectRequirement*, i64 }* %t36, { %EffectRequirement*, i64 }** %l0
  %t37 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s38 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.38, i32 0, i32 0
  %s39 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.39, i32 0, i32 0
  %s40 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.40, i32 0, i32 0
  %t41 = call { %EffectRequirement*, i64 }* @append_identifier_call_effect({ %EffectRequirement*, i64 }* %t37, { %Token*, i64 }* %tokens, i8* %s38, i8* %s39, i8* %s40)
  store { %EffectRequirement*, i64 }* %t41, { %EffectRequirement*, i64 }** %l0
  %t42 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %s43 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.43, i32 0, i32 0
  %s44 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.44, i32 0, i32 0
  %s45 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.45, i32 0, i32 0
  %t46 = call { %EffectRequirement*, i64 }* @append_identifier_call_effect({ %EffectRequirement*, i64 }* %t42, { %Token*, i64 }* %tokens, i8* %s43, i8* %s44, i8* %s45)
  store { %EffectRequirement*, i64 }* %t46, { %EffectRequirement*, i64 }** %l0
  %t47 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t47
}

define { %EffectRequirement*, i64 }* @append_prompt_effect({ %EffectRequirement*, i64 }* %requirements, { %Token*, i64 }* %tokens) {
entry:
  %l0 = alloca { %EffectRequirement*, i64 }*
  %l1 = alloca double
  %l2 = alloca %Token
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca %Token
  store { %EffectRequirement*, i64 }* %requirements, { %EffectRequirement*, i64 }** %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t52 = phi { %EffectRequirement*, i64 }* [ %t1, %entry ], [ %t50, %loop.latch2 ]
  %t53 = phi double [ %t2, %entry ], [ %t51, %loop.latch2 ]
  store { %EffectRequirement*, i64 }* %t52, { %EffectRequirement*, i64 }** %l0
  store double %t53, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t5 = extractvalue { %Token*, i64 } %t4, 1
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp oge double %t3, %t6
  %t8 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t9 = load double, double* %l1
  br i1 %t7, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t10 = load double, double* %l1
  %t11 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t12 = extractvalue { %Token*, i64 } %t11, 0
  %t13 = extractvalue { %Token*, i64 } %t11, 1
  %t14 = icmp uge i64 %t10, %t13
  ; bounds check: %t14 (if true, out of bounds)
  %t15 = getelementptr %Token, %Token* %t12, i64 %t10
  %t16 = load %Token, %Token* %t15
  store %Token %t16, %Token* %l2
  %t17 = load %Token, %Token* %l2
  %s18 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.18, i32 0, i32 0
  %t19 = call i1 @is_identifier_token(%Token %t17, i8* %s18)
  %t20 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t21 = load double, double* %l1
  %t22 = load %Token, %Token* %l2
  br i1 %t19, label %then6, label %merge7
then6:
  %t23 = load double, double* %l1
  %t24 = sitofp i64 1 to double
  %t25 = fadd double %t23, %t24
  %t26 = call double @next_non_trivia({ %Token*, i64 }* %tokens, double %t25)
  store double %t26, double* %l3
  %s27 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.27, i32 0, i32 0
  store i8* %s27, i8** %l4
  %t28 = load double, double* %l3
  %t29 = sitofp i64 -1 to double
  %t30 = fcmp une double %t28, %t29
  %t31 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t32 = load double, double* %l1
  %t33 = load %Token, %Token* %l2
  %t34 = load double, double* %l3
  %t35 = load i8*, i8** %l4
  br i1 %t30, label %then8, label %merge9
then8:
  %t36 = load double, double* %l3
  %t37 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t38 = extractvalue { %Token*, i64 } %t37, 0
  %t39 = extractvalue { %Token*, i64 } %t37, 1
  %t40 = icmp uge i64 %t36, %t39
  ; bounds check: %t40 (if true, out of bounds)
  %t41 = getelementptr %Token, %Token* %t38, i64 %t36
  %t42 = load %Token, %Token* %t41
  store %Token %t42, %Token* %l5
  %t44 = load %Token, %Token* %l5
  %t45 = extractvalue %Token %t44, 0
  br label %merge9
merge9:
  br label %merge7
merge7:
  %t46 = phi { %EffectRequirement*, i64 }* [ null, %then6 ], [ %t20, %loop.body1 ]
  store { %EffectRequirement*, i64 }* %t46, { %EffectRequirement*, i64 }** %l0
  %t47 = load double, double* %l1
  %t48 = sitofp i64 1 to double
  %t49 = fadd double %t47, %t48
  store double %t49, double* %l1
  br label %loop.latch2
loop.latch2:
  %t50 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  %t51 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t54 = load { %EffectRequirement*, i64 }*, { %EffectRequirement*, i64 }** %l0
  ret { %EffectRequirement*, i64 }* %t54
}

define { %EffectRequirement*, i64 }* @append_identifier_dot_effect({ %EffectRequirement*, i64 }* %requirements, { %Token*, i64 }* %tokens, i8* %identifier, i8* %effect, i8* %description) {
entry:
  %l0 = alloca { %Token*, i64 }*
  %l1 = alloca { %EffectRequirement*, i64 }*
  %l2 = alloca double
  %t0 = call { %Token*, i64 }* @find_identifier_followed_by_symbol({ %Token*, i64 }* %tokens, i8* %identifier, i8* null)
  store { %Token*, i64 }* %t0, { %Token*, i64 }** %l0
  store { %EffectRequirement*, i64 }* %requirements, { %EffectRequirement*, i64 }** %l1
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l2
  %t2 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
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
  %t6 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t7 = load { %Token*, i64 }, { %Token*, i64 }* %t6
  %t8 = extractvalue { %Token*, i64 } %t7, 1
  %t9 = sitofp i64 %t8 to double
  %t10 = fcmp oge double %t5, %t9
  %t11 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
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

define { %EffectRequirement*, i64 }* @append_identifier_call_effect({ %EffectRequirement*, i64 }* %requirements, { %Token*, i64 }* %tokens, i8* %identifier, i8* %effect, i8* %description) {
entry:
  %l0 = alloca { %Token*, i64 }*
  %l1 = alloca { %EffectRequirement*, i64 }*
  %l2 = alloca double
  %t0 = call { %Token*, i64 }* @find_identifier_call({ %Token*, i64 }* %tokens, i8* %identifier)
  store { %Token*, i64 }* %t0, { %Token*, i64 }** %l0
  store { %EffectRequirement*, i64 }* %requirements, { %EffectRequirement*, i64 }** %l1
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l2
  %t2 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
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
  %t6 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t7 = load { %Token*, i64 }, { %Token*, i64 }* %t6
  %t8 = extractvalue { %Token*, i64 } %t7, 1
  %t9 = sitofp i64 %t8 to double
  %t10 = fcmp oge double %t5, %t9
  %t11 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
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

define { %Token*, i64 }* @find_identifier_followed_by_symbol({ %Token*, i64 }* %tokens, i8* %name, i8* %symbol) {
entry:
  %l0 = alloca { %Token*, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %Token*, i64 }* null, { %Token*, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t66 = phi { %Token*, i64 }* [ %t6, %entry ], [ %t64, %loop.latch2 ]
  %t67 = phi double [ %t7, %entry ], [ %t65, %loop.latch2 ]
  store { %Token*, i64 }* %t66, { %Token*, i64 }** %l0
  store double %t67, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t10 = extractvalue { %Token*, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l1
  %t16 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t17 = extractvalue { %Token*, i64 } %t16, 0
  %t18 = extractvalue { %Token*, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  %t20 = getelementptr %Token, %Token* %t17, i64 %t15
  %t21 = load %Token, %Token* %t20
  %t22 = call i1 @is_identifier_token(%Token %t21, i8* %name)
  %t23 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t24 = load double, double* %l1
  br i1 %t22, label %then6, label %merge7
then6:
  %t25 = load double, double* %l1
  %t26 = sitofp i64 1 to double
  %t27 = fadd double %t25, %t26
  %t28 = call double @next_non_trivia({ %Token*, i64 }* %tokens, double %t27)
  store double %t28, double* %l2
  %t30 = load double, double* %l2
  %t31 = sitofp i64 -1 to double
  %t32 = fcmp une double %t30, %t31
  br label %logical_and_entry_29

logical_and_entry_29:
  br i1 %t32, label %logical_and_right_29, label %logical_and_merge_29

logical_and_right_29:
  %t33 = load double, double* %l2
  %t34 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t35 = extractvalue { %Token*, i64 } %t34, 0
  %t36 = extractvalue { %Token*, i64 } %t34, 1
  %t37 = icmp uge i64 %t33, %t36
  ; bounds check: %t37 (if true, out of bounds)
  %t38 = getelementptr %Token, %Token* %t35, i64 %t33
  %t39 = load %Token, %Token* %t38
  %t40 = call i1 @is_symbol_token(%Token %t39, i8* %symbol)
  br label %logical_and_right_end_29

logical_and_right_end_29:
  br label %logical_and_merge_29

logical_and_merge_29:
  %t41 = phi i1 [ false, %logical_and_entry_29 ], [ %t40, %logical_and_right_end_29 ]
  %t42 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t43 = load double, double* %l1
  %t44 = load double, double* %l2
  br i1 %t41, label %then8, label %merge9
then8:
  %t45 = load double, double* %l1
  %t46 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t47 = extractvalue { %Token*, i64 } %t46, 0
  %t48 = extractvalue { %Token*, i64 } %t46, 1
  %t49 = icmp uge i64 %t45, %t48
  ; bounds check: %t49 (if true, out of bounds)
  %t50 = getelementptr %Token, %Token* %t47, i64 %t45
  %t51 = load %Token, %Token* %t50
  %t52 = alloca [1 x %Token]
  %t53 = getelementptr [1 x %Token], [1 x %Token]* %t52, i32 0, i32 0
  %t54 = getelementptr %Token, %Token* %t53, i64 0
  store %Token %t51, %Token* %t54
  %t55 = alloca { %Token*, i64 }
  %t56 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t55, i32 0, i32 0
  store %Token* %t53, %Token** %t56
  %t57 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t55, i32 0, i32 1
  store i64 1, i64* %t57
  %t58 = call double @matchesconcat({ %Token*, i64 }* %t55)
  store { %Token*, i64 }* null, { %Token*, i64 }** %l0
  br label %merge9
merge9:
  %t59 = phi { %Token*, i64 }* [ null, %then8 ], [ %t42, %then6 ]
  store { %Token*, i64 }* %t59, { %Token*, i64 }** %l0
  br label %merge7
merge7:
  %t60 = phi { %Token*, i64 }* [ null, %then6 ], [ %t23, %loop.body1 ]
  store { %Token*, i64 }* %t60, { %Token*, i64 }** %l0
  %t61 = load double, double* %l1
  %t62 = sitofp i64 1 to double
  %t63 = fadd double %t61, %t62
  store double %t63, double* %l1
  br label %loop.latch2
loop.latch2:
  %t64 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t65 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t68 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  ret { %Token*, i64 }* %t68
}

define { %Token*, i64 }* @find_identifier_call({ %Token*, i64 }* %tokens, i8* %name) {
entry:
  %l0 = alloca { %Token*, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %Token*, i64 }* null, { %Token*, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t66 = phi { %Token*, i64 }* [ %t6, %entry ], [ %t64, %loop.latch2 ]
  %t67 = phi double [ %t7, %entry ], [ %t65, %loop.latch2 ]
  store { %Token*, i64 }* %t66, { %Token*, i64 }** %l0
  store double %t67, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t10 = extractvalue { %Token*, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l1
  %t16 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t17 = extractvalue { %Token*, i64 } %t16, 0
  %t18 = extractvalue { %Token*, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  %t20 = getelementptr %Token, %Token* %t17, i64 %t15
  %t21 = load %Token, %Token* %t20
  %t22 = call i1 @is_identifier_token(%Token %t21, i8* %name)
  %t23 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t24 = load double, double* %l1
  br i1 %t22, label %then6, label %merge7
then6:
  %t25 = load double, double* %l1
  %t26 = sitofp i64 1 to double
  %t27 = fadd double %t25, %t26
  %t28 = call double @next_non_trivia({ %Token*, i64 }* %tokens, double %t27)
  store double %t28, double* %l2
  %t30 = load double, double* %l2
  %t31 = sitofp i64 -1 to double
  %t32 = fcmp une double %t30, %t31
  br label %logical_and_entry_29

logical_and_entry_29:
  br i1 %t32, label %logical_and_right_29, label %logical_and_merge_29

logical_and_right_29:
  %t33 = load double, double* %l2
  %t34 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t35 = extractvalue { %Token*, i64 } %t34, 0
  %t36 = extractvalue { %Token*, i64 } %t34, 1
  %t37 = icmp uge i64 %t33, %t36
  ; bounds check: %t37 (if true, out of bounds)
  %t38 = getelementptr %Token, %Token* %t35, i64 %t33
  %t39 = load %Token, %Token* %t38
  %t40 = call i1 @is_symbol_token(%Token %t39, i8* null)
  br label %logical_and_right_end_29

logical_and_right_end_29:
  br label %logical_and_merge_29

logical_and_merge_29:
  %t41 = phi i1 [ false, %logical_and_entry_29 ], [ %t40, %logical_and_right_end_29 ]
  %t42 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t43 = load double, double* %l1
  %t44 = load double, double* %l2
  br i1 %t41, label %then8, label %merge9
then8:
  %t45 = load double, double* %l1
  %t46 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t47 = extractvalue { %Token*, i64 } %t46, 0
  %t48 = extractvalue { %Token*, i64 } %t46, 1
  %t49 = icmp uge i64 %t45, %t48
  ; bounds check: %t49 (if true, out of bounds)
  %t50 = getelementptr %Token, %Token* %t47, i64 %t45
  %t51 = load %Token, %Token* %t50
  %t52 = alloca [1 x %Token]
  %t53 = getelementptr [1 x %Token], [1 x %Token]* %t52, i32 0, i32 0
  %t54 = getelementptr %Token, %Token* %t53, i64 0
  store %Token %t51, %Token* %t54
  %t55 = alloca { %Token*, i64 }
  %t56 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t55, i32 0, i32 0
  store %Token* %t53, %Token** %t56
  %t57 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t55, i32 0, i32 1
  store i64 1, i64* %t57
  %t58 = call double @matchesconcat({ %Token*, i64 }* %t55)
  store { %Token*, i64 }* null, { %Token*, i64 }** %l0
  br label %merge9
merge9:
  %t59 = phi { %Token*, i64 }* [ null, %then8 ], [ %t42, %then6 ]
  store { %Token*, i64 }* %t59, { %Token*, i64 }** %l0
  br label %merge7
merge7:
  %t60 = phi { %Token*, i64 }* [ null, %then6 ], [ %t23, %loop.body1 ]
  store { %Token*, i64 }* %t60, { %Token*, i64 }** %l0
  %t61 = load double, double* %l1
  %t62 = sitofp i64 1 to double
  %t63 = fadd double %t61, %t62
  store double %t63, double* %l1
  br label %loop.latch2
loop.latch2:
  %t64 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  %t65 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t68 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  ret { %Token*, i64 }* %t68
}

define double @next_non_trivia({ %Token*, i64 }* %tokens, double %start) {
entry:
  %l0 = alloca double
  %l1 = alloca %Token
  store double %start, double* %l0
  %t0 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t24 = phi double [ %t0, %entry ], [ %t23, %loop.latch2 ]
  store double %t24, double* %l0
  br label %loop.body1
loop.body1:
  %t1 = load double, double* %l0
  %t2 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t3 = extractvalue { %Token*, i64 } %t2, 1
  %t4 = sitofp i64 %t3 to double
  %t5 = fcmp oge double %t1, %t4
  %t6 = load double, double* %l0
  br i1 %t5, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t7 = load double, double* %l0
  %t8 = load { %Token*, i64 }, { %Token*, i64 }* %tokens
  %t9 = extractvalue { %Token*, i64 } %t8, 0
  %t10 = extractvalue { %Token*, i64 } %t8, 1
  %t11 = icmp uge i64 %t7, %t10
  ; bounds check: %t11 (if true, out of bounds)
  %t12 = getelementptr %Token, %Token* %t9, i64 %t7
  %t13 = load %Token, %Token* %t12
  store %Token %t13, %Token* %l1
  %t14 = load %Token, %Token* %l1
  %t15 = call i1 @is_trivia_token(%Token %t14)
  %t16 = xor i1 %t15, 1
  %t17 = load double, double* %l0
  %t18 = load %Token, %Token* %l1
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

define i1 @is_trivia_token(%Token %token) {
entry:
  %t1 = extractvalue %Token %token, 0
  ret i1 false
}

define i1 @is_identifier_token(%Token %token, i8* %expected) {
entry:
  %t0 = extractvalue %Token %token, 0
  %t1 = extractvalue %Token %token, 1
  %t2 = icmp eq i8* %t1, %expected
  ret i1 %t2
}

define i1 @is_symbol_token(%Token %token, i8* %expected) {
entry:
  %t0 = extractvalue %Token %token, 0
  %t1 = extractvalue %Token %token, 1
  %t2 = icmp eq i8* %t1, %expected
  ret i1 %t2
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
