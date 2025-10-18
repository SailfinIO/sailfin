; ModuleID = 'sailfin'
source_filename = "sailfin"

%LexerState = type { i8*, double, double, double }

declare noalias i8* @malloc(i64)

@.str.3 = private unnamed_addr constant [2 x i8] c" \00"
@.str.5 = private unnamed_addr constant [2 x i8] c"\09\00"
@.str.8 = private unnamed_addr constant [2 x i8] c"\0A\00"
@.str.11 = private unnamed_addr constant [2 x i8] c"\0D\00"
@.str.2 = private unnamed_addr constant [2 x i8] c"_\00"
@.str.4 = private unnamed_addr constant [2 x i8] c"a\00"
@.str.8 = private unnamed_addr constant [2 x i8] c"z\00"
@.str.14 = private unnamed_addr constant [2 x i8] c"A\00"
@.str.18 = private unnamed_addr constant [2 x i8] c"Z\00"
@.str.3 = private unnamed_addr constant [2 x i8] c"0\00"
@.str.7 = private unnamed_addr constant [2 x i8] c"9\00"

define { i8**, i64 }* @lex(i8* %source) {
entry:
  %l0 = alloca %LexerState
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca i8
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca i8*
  %l7 = alloca double
  %l8 = alloca double
  %l9 = alloca double
  %l10 = alloca i8*
  %l11 = alloca i1
  %l12 = alloca i8
  %l13 = alloca i8*
  %l14 = alloca double
  %l15 = alloca double
  %l16 = alloca double
  %l17 = alloca i8*
  %l18 = alloca double
  %l19 = alloca double
  %l20 = alloca double
  %l21 = alloca i8*
  %l22 = alloca i1
  %l23 = alloca double
  %l24 = alloca double
  %l25 = alloca i8
  %l26 = alloca i8*
  %l27 = alloca double
  store %LexerState zeroinitializer, %LexerState* %l0
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t5 = load %LexerState, %LexerState* %l0
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %loop.header0
loop.header0:
  %t269 = phi { i8**, i64 }* [ %t6, %entry ], [ %t268, %loop.latch2 ]
  store { i8**, i64 }* %t269, { i8**, i64 }** %l1
  br label %loop.body1
loop.body1:
  %t7 = load %LexerState, %LexerState* %l0
  %t8 = extractvalue %LexerState %t7, 1
  %t9 = load %LexerState, %LexerState* %l0
  %t10 = extractvalue %LexerState %t9, 0
  %t11 = load %LexerState, %LexerState* %l0
  %t12 = extractvalue %LexerState %t11, 0
  %t13 = load %LexerState, %LexerState* %l0
  %t14 = extractvalue %LexerState %t13, 1
  %t15 = getelementptr i8, i8* %t12, i64 %t14
  %t16 = load i8, i8* %t15
  store i8 %t16, i8* %l2
  %t17 = load i8, i8* %l2
  %t18 = call i1 @is_whitespace(i8* null)
  %t19 = load %LexerState, %LexerState* %l0
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t21 = load i8, i8* %l2
  br i1 %t18, label %then4, label %merge5
then4:
  %t22 = load %LexerState, %LexerState* %l0
  %t23 = extractvalue %LexerState %t22, 1
  store double %t23, double* %l3
  %t24 = load %LexerState, %LexerState* %l0
  %t25 = extractvalue %LexerState %t24, 2
  store double %t25, double* %l4
  %t26 = load %LexerState, %LexerState* %l0
  %t27 = extractvalue %LexerState %t26, 3
  store double %t27, double* %l5
  %t28 = load %LexerState, %LexerState* %l0
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t30 = load i8, i8* %l2
  %t31 = load double, double* %l3
  %t32 = load double, double* %l4
  %t33 = load double, double* %l5
  br label %loop.header6
loop.header6:
  br label %loop.body7
loop.body7:
  %t34 = load %LexerState, %LexerState* %l0
  %t35 = extractvalue %LexerState %t34, 1
  %t36 = load %LexerState, %LexerState* %l0
  %t37 = extractvalue %LexerState %t36, 0
  %t38 = load %LexerState, %LexerState* %l0
  %t39 = extractvalue %LexerState %t38, 0
  %t40 = load %LexerState, %LexerState* %l0
  %t41 = extractvalue %LexerState %t40, 1
  %t42 = getelementptr i8, i8* %t39, i64 %t41
  %t43 = load i8, i8* %t42
  %t44 = call double @is_whitespace(i8 %t43)
  %t45 = fcmp one double %t44, 0.0
  %t46 = load %LexerState, %LexerState* %l0
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t48 = load i8, i8* %l2
  %t49 = load double, double* %l3
  %t50 = load double, double* %l4
  %t51 = load double, double* %l5
  br i1 %t45, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t52 = load %LexerState, %LexerState* %l0
  %t53 = extractvalue %LexerState %t52, 0
  %t54 = load %LexerState, %LexerState* %l0
  %t55 = extractvalue %LexerState %t54, 1
  %t56 = getelementptr i8, i8* %t53, i64 %t55
  %t57 = load i8, i8* %t56
  %s58 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.58, i32 0, i32 0
  br label %loop.latch8
loop.latch8:
  br label %loop.header6
afterloop9:
  %t59 = load %LexerState, %LexerState* %l0
  %t60 = extractvalue %LexerState %t59, 0
  %t61 = load double, double* %l3
  %t62 = load %LexerState, %LexerState* %l0
  %t63 = extractvalue %LexerState %t62, 1
  %t64 = call i8* @slice(i8* %t60, double %t61, double %t63)
  store i8* %t64, i8** %l6
  br label %loop.latch2
merge5:
  %t65 = load i8, i8* %l2
  %t66 = load i8, i8* %l2
  %t67 = call i1 @is_double_quote(i8* null)
  %t68 = load %LexerState, %LexerState* %l0
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t70 = load i8, i8* %l2
  br i1 %t67, label %then12, label %merge13
then12:
  %t71 = load %LexerState, %LexerState* %l0
  %t72 = extractvalue %LexerState %t71, 1
  store double %t72, double* %l7
  %t73 = load %LexerState, %LexerState* %l0
  %t74 = extractvalue %LexerState %t73, 2
  store double %t74, double* %l8
  %t75 = load %LexerState, %LexerState* %l0
  %t76 = extractvalue %LexerState %t75, 3
  store double %t76, double* %l9
  %s77 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.77, i32 0, i32 0
  store i8* %s77, i8** %l10
  store i1 0, i1* %l11
  %t78 = load %LexerState, %LexerState* %l0
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t80 = load i8, i8* %l2
  %t81 = load double, double* %l7
  %t82 = load double, double* %l8
  %t83 = load double, double* %l9
  %t84 = load i8*, i8** %l10
  %t85 = load i1, i1* %l11
  br label %loop.header14
loop.header14:
  %t120 = phi i8* [ %t84, %then12 ], [ %t118, %loop.latch16 ]
  %t121 = phi i1 [ %t85, %then12 ], [ %t119, %loop.latch16 ]
  store i8* %t120, i8** %l10
  store i1 %t121, i1* %l11
  br label %loop.body15
loop.body15:
  %t86 = load %LexerState, %LexerState* %l0
  %t87 = extractvalue %LexerState %t86, 1
  %t88 = load %LexerState, %LexerState* %l0
  %t89 = extractvalue %LexerState %t88, 0
  %t90 = load %LexerState, %LexerState* %l0
  %t91 = extractvalue %LexerState %t90, 0
  %t92 = load %LexerState, %LexerState* %l0
  %t93 = extractvalue %LexerState %t92, 1
  %t94 = getelementptr i8, i8* %t91, i64 %t93
  %t95 = load i8, i8* %t94
  store i8 %t95, i8* %l12
  %t98 = load i1, i1* %l11
  %t99 = load %LexerState, %LexerState* %l0
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t101 = load i8, i8* %l2
  %t102 = load double, double* %l7
  %t103 = load double, double* %l8
  %t104 = load double, double* %l9
  %t105 = load i8*, i8** %l10
  %t106 = load i1, i1* %l11
  %t107 = load i8, i8* %l12
  br i1 %t98, label %then18, label %else19
then18:
  %t108 = load i8*, i8** %l10
  %t109 = load i8, i8* %l12
  %t110 = call i8* @interpret_escape(i8* null)
  %t111 = add i8* %t108, %t110
  store i8* %t111, i8** %l10
  store i1 0, i1* %l11
  br label %merge20
else19:
  %t112 = load i8*, i8** %l10
  %t113 = load i8, i8* %l12
  br label %merge20
merge20:
  %t114 = phi i8* [ %t111, %then18 ], [ null, %else19 ]
  %t115 = phi i1 [ 0, %then18 ], [ %t106, %else19 ]
  store i8* %t114, i8** %l10
  store i1 %t115, i1* %l11
  %t116 = load i8, i8* %l12
  %s117 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.117, i32 0, i32 0
  br label %loop.latch16
loop.latch16:
  %t118 = load i8*, i8** %l10
  %t119 = load i1, i1* %l11
  br label %loop.header14
afterloop17:
  %t122 = load %LexerState, %LexerState* %l0
  %t123 = extractvalue %LexerState %t122, 0
  %t124 = load double, double* %l7
  %t125 = load %LexerState, %LexerState* %l0
  %t126 = extractvalue %LexerState %t125, 1
  %t127 = call i8* @slice(i8* %t123, double %t124, double %t126)
  store i8* %t127, i8** %l13
  br label %loop.latch2
merge13:
  %t128 = load i8, i8* %l2
  %t129 = call i1 @is_digit(i8* null)
  %t130 = load %LexerState, %LexerState* %l0
  %t131 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t132 = load i8, i8* %l2
  br i1 %t129, label %then21, label %merge22
then21:
  %t133 = load %LexerState, %LexerState* %l0
  %t134 = extractvalue %LexerState %t133, 1
  store double %t134, double* %l14
  %t135 = load %LexerState, %LexerState* %l0
  %t136 = extractvalue %LexerState %t135, 2
  store double %t136, double* %l15
  %t137 = load %LexerState, %LexerState* %l0
  %t138 = extractvalue %LexerState %t137, 3
  store double %t138, double* %l16
  %t139 = load %LexerState, %LexerState* %l0
  %t140 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t141 = load i8, i8* %l2
  %t142 = load double, double* %l14
  %t143 = load double, double* %l15
  %t144 = load double, double* %l16
  br label %loop.header23
loop.header23:
  br label %loop.body24
loop.body24:
  %t145 = load %LexerState, %LexerState* %l0
  %t146 = extractvalue %LexerState %t145, 1
  %t147 = load %LexerState, %LexerState* %l0
  %t148 = extractvalue %LexerState %t147, 0
  %t149 = load %LexerState, %LexerState* %l0
  %t150 = extractvalue %LexerState %t149, 0
  %t151 = load %LexerState, %LexerState* %l0
  %t152 = extractvalue %LexerState %t151, 1
  %t153 = getelementptr i8, i8* %t150, i64 %t152
  %t154 = load i8, i8* %t153
  %t155 = call double @is_digit(i8 %t154)
  %t156 = fcmp one double %t155, 0.0
  %t157 = load %LexerState, %LexerState* %l0
  %t158 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t159 = load i8, i8* %l2
  %t160 = load double, double* %l14
  %t161 = load double, double* %l15
  %t162 = load double, double* %l16
  br i1 %t156, label %then27, label %merge28
then27:
  br label %afterloop26
merge28:
  br label %loop.latch25
loop.latch25:
  br label %loop.header23
afterloop26:
  %t164 = load %LexerState, %LexerState* %l0
  %t165 = extractvalue %LexerState %t164, 1
  %t166 = load %LexerState, %LexerState* %l0
  %t167 = extractvalue %LexerState %t166, 0
  %t168 = load %LexerState, %LexerState* %l0
  %t169 = extractvalue %LexerState %t168, 0
  %t170 = load double, double* %l14
  %t171 = load %LexerState, %LexerState* %l0
  %t172 = extractvalue %LexerState %t171, 1
  %t173 = call i8* @slice(i8* %t169, double %t170, double %t172)
  store i8* %t173, i8** %l17
  br label %loop.latch2
merge22:
  %t174 = load i8, i8* %l2
  %t175 = call i1 @is_identifier_start(i8* null)
  %t176 = load %LexerState, %LexerState* %l0
  %t177 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t178 = load i8, i8* %l2
  br i1 %t175, label %then29, label %merge30
then29:
  %t179 = load %LexerState, %LexerState* %l0
  %t180 = extractvalue %LexerState %t179, 1
  store double %t180, double* %l18
  %t181 = load %LexerState, %LexerState* %l0
  %t182 = extractvalue %LexerState %t181, 2
  store double %t182, double* %l19
  %t183 = load %LexerState, %LexerState* %l0
  %t184 = extractvalue %LexerState %t183, 3
  store double %t184, double* %l20
  %t185 = load %LexerState, %LexerState* %l0
  %t186 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t187 = load i8, i8* %l2
  %t188 = load double, double* %l18
  %t189 = load double, double* %l19
  %t190 = load double, double* %l20
  br label %loop.header31
loop.header31:
  br label %loop.body32
loop.body32:
  %t191 = load %LexerState, %LexerState* %l0
  %t192 = extractvalue %LexerState %t191, 1
  %t193 = load %LexerState, %LexerState* %l0
  %t194 = extractvalue %LexerState %t193, 0
  %t195 = load %LexerState, %LexerState* %l0
  %t196 = extractvalue %LexerState %t195, 0
  %t197 = load %LexerState, %LexerState* %l0
  %t198 = extractvalue %LexerState %t197, 1
  %t199 = getelementptr i8, i8* %t196, i64 %t198
  %t200 = load i8, i8* %t199
  %t201 = call double @is_identifier_part(i8 %t200)
  %t202 = fcmp one double %t201, 0.0
  %t203 = load %LexerState, %LexerState* %l0
  %t204 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t205 = load i8, i8* %l2
  %t206 = load double, double* %l18
  %t207 = load double, double* %l19
  %t208 = load double, double* %l20
  br i1 %t202, label %then35, label %merge36
then35:
  br label %afterloop34
merge36:
  br label %loop.latch33
loop.latch33:
  br label %loop.header31
afterloop34:
  %t209 = load %LexerState, %LexerState* %l0
  %t210 = extractvalue %LexerState %t209, 0
  %t211 = load double, double* %l18
  %t212 = load %LexerState, %LexerState* %l0
  %t213 = extractvalue %LexerState %t212, 1
  %t214 = call i8* @slice(i8* %t210, double %t211, double %t213)
  store i8* %t214, i8** %l21
  %t216 = load i8*, i8** %l21
  %s217 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.217, i32 0, i32 0
  %t218 = icmp eq i8* %t216, %s217
  br label %logical_or_entry_215

logical_or_entry_215:
  br i1 %t218, label %logical_or_merge_215, label %logical_or_right_215

logical_or_right_215:
  %t219 = load i8*, i8** %l21
  %s220 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.220, i32 0, i32 0
  %t221 = icmp eq i8* %t219, %s220
  br label %logical_or_right_end_215

logical_or_right_end_215:
  br label %logical_or_merge_215

logical_or_merge_215:
  %t222 = phi i1 [ true, %logical_or_entry_215 ], [ %t221, %logical_or_right_end_215 ]
  %t223 = load %LexerState, %LexerState* %l0
  %t224 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t225 = load i8, i8* %l2
  %t226 = load double, double* %l18
  %t227 = load double, double* %l19
  %t228 = load double, double* %l20
  %t229 = load i8*, i8** %l21
  br i1 %t222, label %then37, label %else38
then37:
  %t230 = load i8*, i8** %l21
  %s231 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.231, i32 0, i32 0
  %t232 = icmp eq i8* %t230, %s231
  store i1 %t232, i1* %l22
  br label %merge39
else38:
  br label %merge39
merge39:
  %t233 = phi { i8**, i64 }* [ null, %then37 ], [ null, %else38 ]
  store { i8**, i64 }* %t233, { i8**, i64 }** %l1
  br label %loop.latch2
merge30:
  %t234 = load %LexerState, %LexerState* %l0
  %t235 = extractvalue %LexerState %t234, 2
  store double %t235, double* %l23
  %t236 = load %LexerState, %LexerState* %l0
  %t237 = extractvalue %LexerState %t236, 3
  store double %t237, double* %l24
  %t238 = load i8, i8* %l2
  store i8 %t238, i8* %l25
  %t239 = load %LexerState, %LexerState* %l0
  %t240 = call i8* @peek_next_char(%LexerState %t239)
  store i8* %t240, i8** %l26
  %t241 = load i8*, i8** %l26
  %s242 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.242, i32 0, i32 0
  %t243 = icmp ne i8* %t241, %s242
  %t244 = load %LexerState, %LexerState* %l0
  %t245 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t246 = load i8, i8* %l2
  %t247 = load double, double* %l23
  %t248 = load double, double* %l24
  %t249 = load i8, i8* %l25
  %t250 = load i8*, i8** %l26
  br i1 %t243, label %then40, label %merge41
then40:
  %t251 = load i8, i8* %l2
  %t252 = load i8*, i8** %l26
  store double 0.0, double* %l27
  %t253 = load double, double* %l27
  %t254 = call i1 @is_two_char_symbol(i8* null)
  %t255 = load %LexerState, %LexerState* %l0
  %t256 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t257 = load i8, i8* %l2
  %t258 = load double, double* %l23
  %t259 = load double, double* %l24
  %t260 = load i8, i8* %l25
  %t261 = load i8*, i8** %l26
  %t262 = load double, double* %l27
  br i1 %t254, label %then42, label %merge43
then42:
  %t263 = load double, double* %l27
  store i8 zeroinitializer, i8* %l25
  br label %loop.latch2
merge43:
  br label %merge41
merge41:
  %t264 = phi i8 [ zeroinitializer, %then40 ], [ %t249, %loop.body1 ]
  %t265 = phi { i8**, i64 }* [ null, %then40 ], [ %t245, %loop.body1 ]
  store i8 %t264, i8* %l25
  store { i8**, i64 }* %t265, { i8**, i64 }** %l1
  %t266 = load i8, i8* %l2
  %s267 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.267, i32 0, i32 0
  br label %loop.latch2
loop.latch2:
  %t268 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %loop.header0
afterloop3:
  %t270 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t271 = load %LexerState, %LexerState* %l0
  %t272 = extractvalue %LexerState %t271, 2
  %t273 = load %LexerState, %LexerState* %l0
  %t274 = extractvalue %LexerState %t273, 3
  %t275 = call double @eof_token(double %t272, double %t274)
  %t276 = call { i8**, i64 }* @append({ i8**, i64 }* %t270, i8* null)
  store { i8**, i64 }* %t276, { i8**, i64 }** %l1
  %t277 = load { i8**, i64 }*, { i8**, i64 }** %l1
  ret { i8**, i64 }* %t277
}

define i1 @is_whitespace(i8* %ch) {
entry:
  %s3 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.3, i32 0, i32 0
  %t4 = icmp eq i8* %ch, %s3
  br label %logical_or_entry_2

logical_or_entry_2:
  br i1 %t4, label %logical_or_merge_2, label %logical_or_right_2

logical_or_right_2:
  %s5 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.5, i32 0, i32 0
  %t6 = icmp eq i8* %ch, %s5
  br label %logical_or_right_end_2

logical_or_right_end_2:
  br label %logical_or_merge_2

logical_or_merge_2:
  %t7 = phi i1 [ true, %logical_or_entry_2 ], [ %t6, %logical_or_right_end_2 ]
  br label %logical_or_entry_1

logical_or_entry_1:
  br i1 %t7, label %logical_or_merge_1, label %logical_or_right_1

logical_or_right_1:
  %s8 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.8, i32 0, i32 0
  %t9 = icmp eq i8* %ch, %s8
  br label %logical_or_right_end_1

logical_or_right_end_1:
  br label %logical_or_merge_1

logical_or_merge_1:
  %t10 = phi i1 [ true, %logical_or_entry_1 ], [ %t9, %logical_or_right_end_1 ]
  br label %logical_or_entry_0

logical_or_entry_0:
  br i1 %t10, label %logical_or_merge_0, label %logical_or_right_0

logical_or_right_0:
  %s11 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.11, i32 0, i32 0
  %t12 = icmp eq i8* %ch, %s11
  br label %logical_or_right_end_0

logical_or_right_end_0:
  br label %logical_or_merge_0

logical_or_merge_0:
  %t13 = phi i1 [ true, %logical_or_entry_0 ], [ %t12, %logical_or_right_end_0 ]
  ret i1 %t13
}

define i1 @is_identifier_start(i8* %ch) {
entry:
  %t1 = call i1 @is_letter(i8* %ch)
  br label %logical_or_entry_0

logical_or_entry_0:
  br i1 %t1, label %logical_or_merge_0, label %logical_or_right_0

logical_or_right_0:
  %s2 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.2, i32 0, i32 0
  %t3 = icmp eq i8* %ch, %s2
  br label %logical_or_right_end_0

logical_or_right_end_0:
  br label %logical_or_merge_0

logical_or_merge_0:
  %t4 = phi i1 [ true, %logical_or_entry_0 ], [ %t3, %logical_or_right_end_0 ]
  ret i1 %t4
}

define i1 @is_identifier_part(i8* %ch) {
entry:
  %t1 = call i1 @is_identifier_start(i8* %ch)
  br label %logical_or_entry_0

logical_or_entry_0:
  br i1 %t1, label %logical_or_merge_0, label %logical_or_right_0

logical_or_right_0:
  %t2 = call i1 @is_digit(i8* %ch)
  br label %logical_or_right_end_0

logical_or_right_end_0:
  br label %logical_or_merge_0

logical_or_merge_0:
  %t3 = phi i1 [ true, %logical_or_entry_0 ], [ %t2, %logical_or_right_end_0 ]
  ret i1 %t3
}

define i1 @is_letter(i8* %ch) {
entry:
  %l0 = alloca double
  %t0 = call double @char_code(i8* %ch)
  store double %t0, double* %l0
  %t3 = load double, double* %l0
  %s4 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.4, i32 0, i32 0
  %t5 = call double @char_code(i8* %s4)
  %t6 = fcmp oge double %t3, %t5
  br label %logical_and_entry_2

logical_and_entry_2:
  br i1 %t6, label %logical_and_right_2, label %logical_and_merge_2

logical_and_right_2:
  %t7 = load double, double* %l0
  %s8 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.8, i32 0, i32 0
  %t9 = call double @char_code(i8* %s8)
  %t10 = fcmp ole double %t7, %t9
  br label %logical_and_right_end_2

logical_and_right_end_2:
  br label %logical_and_merge_2

logical_and_merge_2:
  %t11 = phi i1 [ false, %logical_and_entry_2 ], [ %t10, %logical_and_right_end_2 ]
  br label %logical_or_entry_1

logical_or_entry_1:
  br i1 %t11, label %logical_or_merge_1, label %logical_or_right_1

logical_or_right_1:
  %t13 = load double, double* %l0
  %s14 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.14, i32 0, i32 0
  %t15 = call double @char_code(i8* %s14)
  %t16 = fcmp oge double %t13, %t15
  br label %logical_and_entry_12

logical_and_entry_12:
  br i1 %t16, label %logical_and_right_12, label %logical_and_merge_12

logical_and_right_12:
  %t17 = load double, double* %l0
  %s18 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.18, i32 0, i32 0
  %t19 = call double @char_code(i8* %s18)
  %t20 = fcmp ole double %t17, %t19
  br label %logical_and_right_end_12

logical_and_right_end_12:
  br label %logical_and_merge_12

logical_and_merge_12:
  %t21 = phi i1 [ false, %logical_and_entry_12 ], [ %t20, %logical_and_right_end_12 ]
  br label %logical_or_right_end_1

logical_or_right_end_1:
  br label %logical_or_merge_1

logical_or_merge_1:
  %t22 = phi i1 [ true, %logical_or_entry_1 ], [ %t21, %logical_or_right_end_1 ]
  ret i1 %t22
}

define i1 @is_digit(i8* %ch) {
entry:
  %l0 = alloca double
  %t0 = call double @char_code(i8* %ch)
  store double %t0, double* %l0
  %t2 = load double, double* %l0
  %s3 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.3, i32 0, i32 0
  %t4 = call double @char_code(i8* %s3)
  %t5 = fcmp oge double %t2, %t4
  br label %logical_and_entry_1

logical_and_entry_1:
  br i1 %t5, label %logical_and_right_1, label %logical_and_merge_1

logical_and_right_1:
  %t6 = load double, double* %l0
  %s7 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.7, i32 0, i32 0
  %t8 = call double @char_code(i8* %s7)
  %t9 = fcmp ole double %t6, %t8
  br label %logical_and_right_end_1

logical_and_right_end_1:
  br label %logical_and_merge_1

logical_and_merge_1:
  %t10 = phi i1 [ false, %logical_and_entry_1 ], [ %t9, %logical_and_right_end_1 ]
  ret i1 %t10
}

define i1 @is_double_quote(i8* %ch) {
entry:
  %t0 = call double @char_code(i8* %ch)
  %t1 = sitofp i64 34 to double
  %t2 = fcmp oeq double %t0, %t1
  ret i1 %t2
}

define i1 @is_backslash(i8* %ch) {
entry:
  %t0 = call double @char_code(i8* %ch)
  %t1 = sitofp i64 92 to double
  %t2 = fcmp oeq double %t0, %t1
  ret i1 %t2
}

define i8* @slice(i8* %text, double %start, double %end) {
entry:
  %t0 = call double @substring(i8* %text, double %start, double %end)
  ret i8* null
}

define { i8**, i64 }* @append({ i8**, i64 }* %tokens, i8* %token) {
entry:
  %t0 = alloca [1 x i8*]
  %t1 = getelementptr [1 x i8*], [1 x i8*]* %t0, i32 0, i32 0
  %t2 = getelementptr i8*, i8** %t1, i64 0
  store i8* %token, i8** %t2
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t1, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @tokensconcat({ i8**, i64 }* %t3)
  ret { i8**, i64 }* null
}

define i8* @peek_next_char(%LexerState %state) {
entry:
  %l0 = alloca double
  %t0 = extractvalue %LexerState %state, 1
  %t1 = sitofp i64 1 to double
  %t2 = fadd double %t0, %t1
  store double %t2, double* %l0
  %t3 = load double, double* %l0
  %t4 = extractvalue %LexerState %state, 0
  %t5 = extractvalue %LexerState %state, 0
  %t6 = load double, double* %l0
  %t7 = getelementptr i8, i8* %t5, i64 %t6
  %t8 = load i8, i8* %t7
  ret i8* null
}

define i8* @interpret_escape(i8* %ch) {
entry:
  %s0 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.0, i32 0, i32 0
  %t1 = icmp eq i8* %ch, %s0
  br i1 %t1, label %then0, label %merge1
then0:
  %s2 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.2, i32 0, i32 0
  ret i8* %s2
merge1:
  %s3 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.3, i32 0, i32 0
  %t4 = icmp eq i8* %ch, %s3
  br i1 %t4, label %then2, label %merge3
then2:
  %s5 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.5, i32 0, i32 0
  ret i8* %s5
merge3:
  %s6 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.6, i32 0, i32 0
  %t7 = icmp eq i8* %ch, %s6
  br i1 %t7, label %then4, label %merge5
then4:
  %s8 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.8, i32 0, i32 0
  ret i8* %s8
merge5:
  %t9 = call i1 @is_double_quote(i8* %ch)
  br i1 %t9, label %then6, label %merge7
then6:
  %s10 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.10, i32 0, i32 0
  ret i8* %s10
merge7:
  %t11 = call i1 @is_backslash(i8* %ch)
  br i1 %t11, label %then8, label %merge9
then8:
  %s12 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.12, i32 0, i32 0
  ret i8* %s12
merge9:
  ret i8* %ch
}

define i1 @is_two_char_symbol(i8* %value) {
entry:
  ret i1 false
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
