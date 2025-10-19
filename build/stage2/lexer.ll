; ModuleID = 'sailfin'
source_filename = "sailfin"

%LexerState = type { i8*, double, double, double }
%Token = type { i8*, i8*, double, double }

%TokenKind = type { i32, [8 x i8] }

declare i8* @sailfin_runtime_substring(i8*, i64, i64)

declare noalias i8* @malloc(i64)

define { %Token*, i64 }* @lex(i8* %source) {
entry:
  %l0 = alloca %LexerState
  %l1 = alloca { %Token*, i64 }*
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
  %l17 = alloca double
  %l18 = alloca i8*
  %l19 = alloca double
  %l20 = alloca double
  %l21 = alloca double
  %l22 = alloca i8*
  %l23 = alloca i1
  %l24 = alloca double
  %l25 = alloca double
  %l26 = alloca i8
  %l27 = alloca i8*
  %l28 = alloca i8
  store %LexerState zeroinitializer, %LexerState* %l0
  %t0 = alloca [0 x %Token]
  %t1 = getelementptr [0 x %Token], [0 x %Token]* %t0, i32 0, i32 0
  %t2 = alloca { %Token*, i64 }
  %t3 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t2, i32 0, i32 0
  store %Token* %t1, %Token** %t3
  %t4 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %Token*, i64 }* %t2, { %Token*, i64 }** %l1
  %t5 = load %LexerState, %LexerState* %l0
  %t6 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br label %loop.header0
loop.header0:
  %t440 = phi { %Token*, i64 }* [ %t6, %entry ], [ %t439, %loop.latch2 ]
  store { %Token*, i64 }* %t440, { %Token*, i64 }** %l1
  br label %loop.body1
loop.body1:
  %t7 = load %LexerState, %LexerState* %l0
  %t8 = extractvalue %LexerState %t7, 1
  %t9 = load %LexerState, %LexerState* %l0
  %t10 = extractvalue %LexerState %t9, 0
  %t11 = call i64 @sailfin_runtime_string_length(i8* %t10)
  %t12 = sitofp i64 %t11 to double
  %t13 = fcmp oge double %t8, %t12
  %t14 = load %LexerState, %LexerState* %l0
  %t15 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br i1 %t13, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t16 = load %LexerState, %LexerState* %l0
  %t17 = extractvalue %LexerState %t16, 0
  %t18 = load %LexerState, %LexerState* %l0
  %t19 = extractvalue %LexerState %t18, 1
  %t20 = getelementptr i8, i8* %t17, i64 %t19
  %t21 = load i8, i8* %t20
  store i8 %t21, i8* %l2
  %t22 = load i8, i8* %l2
  %t23 = call i1 @is_whitespace(i8* null)
  %t24 = load %LexerState, %LexerState* %l0
  %t25 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t26 = load i8, i8* %l2
  br i1 %t23, label %then6, label %merge7
then6:
  %t27 = load %LexerState, %LexerState* %l0
  %t28 = extractvalue %LexerState %t27, 1
  store double %t28, double* %l3
  %t29 = load %LexerState, %LexerState* %l0
  %t30 = extractvalue %LexerState %t29, 2
  store double %t30, double* %l4
  %t31 = load %LexerState, %LexerState* %l0
  %t32 = extractvalue %LexerState %t31, 3
  store double %t32, double* %l5
  %t33 = load %LexerState, %LexerState* %l0
  %t34 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t35 = load i8, i8* %l2
  %t36 = load double, double* %l3
  %t37 = load double, double* %l4
  %t38 = load double, double* %l5
  br label %loop.header8
loop.header8:
  br label %loop.body9
loop.body9:
  %t39 = load %LexerState, %LexerState* %l0
  %t40 = extractvalue %LexerState %t39, 1
  %t41 = load %LexerState, %LexerState* %l0
  %t42 = extractvalue %LexerState %t41, 0
  %t43 = call i64 @sailfin_runtime_string_length(i8* %t42)
  %t44 = sitofp i64 %t43 to double
  %t45 = fcmp oge double %t40, %t44
  %t46 = load %LexerState, %LexerState* %l0
  %t47 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t48 = load i8, i8* %l2
  %t49 = load double, double* %l3
  %t50 = load double, double* %l4
  %t51 = load double, double* %l5
  br i1 %t45, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t52 = load %LexerState, %LexerState* %l0
  %t53 = extractvalue %LexerState %t52, 0
  %t54 = load %LexerState, %LexerState* %l0
  %t55 = extractvalue %LexerState %t54, 1
  %t56 = getelementptr i8, i8* %t53, i64 %t55
  %t57 = load i8, i8* %t56
  %t58 = call i1 @is_whitespace(i8* null)
  %t59 = xor i1 %t58, 1
  %t60 = load %LexerState, %LexerState* %l0
  %t61 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t62 = load i8, i8* %l2
  %t63 = load double, double* %l3
  %t64 = load double, double* %l4
  %t65 = load double, double* %l5
  br i1 %t59, label %then14, label %merge15
then14:
  br label %afterloop11
merge15:
  %t66 = load %LexerState, %LexerState* %l0
  %t67 = extractvalue %LexerState %t66, 0
  %t68 = load %LexerState, %LexerState* %l0
  %t69 = extractvalue %LexerState %t68, 1
  %t70 = getelementptr i8, i8* %t67, i64 %t69
  %t71 = load i8, i8* %t70
  %t72 = icmp eq i8 %t71, 10
  %t73 = load %LexerState, %LexerState* %l0
  %t74 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t75 = load i8, i8* %l2
  %t76 = load double, double* %l3
  %t77 = load double, double* %l4
  %t78 = load double, double* %l5
  br i1 %t72, label %then16, label %else17
then16:
  br label %merge18
else17:
  br label %merge18
merge18:
  br label %loop.latch10
loop.latch10:
  br label %loop.header8
afterloop11:
  %t79 = load %LexerState, %LexerState* %l0
  %t80 = extractvalue %LexerState %t79, 0
  %t81 = load double, double* %l3
  %t82 = load %LexerState, %LexerState* %l0
  %t83 = extractvalue %LexerState %t82, 1
  %t84 = call i8* @slice(i8* %t80, double %t81, double %t83)
  store i8* %t84, i8** %l6
  br label %loop.latch2
merge7:
  %t85 = load i8, i8* %l2
  %t86 = load i8, i8* %l2
  %t87 = call i1 @is_double_quote(i8* null)
  %t88 = load %LexerState, %LexerState* %l0
  %t89 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t90 = load i8, i8* %l2
  br i1 %t87, label %then19, label %merge20
then19:
  %t91 = load %LexerState, %LexerState* %l0
  %t92 = extractvalue %LexerState %t91, 1
  store double %t92, double* %l7
  %t93 = load %LexerState, %LexerState* %l0
  %t94 = extractvalue %LexerState %t93, 2
  store double %t94, double* %l8
  %t95 = load %LexerState, %LexerState* %l0
  %t96 = extractvalue %LexerState %t95, 3
  store double %t96, double* %l9
  %s97 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.97, i32 0, i32 0
  store i8* %s97, i8** %l10
  store i1 0, i1* %l11
  %t98 = load %LexerState, %LexerState* %l0
  %t99 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t100 = load i8, i8* %l2
  %t101 = load double, double* %l7
  %t102 = load double, double* %l8
  %t103 = load double, double* %l9
  %t104 = load i8*, i8** %l10
  %t105 = load i1, i1* %l11
  br label %loop.header21
loop.header21:
  %t191 = phi i1 [ %t105, %then19 ], [ %t189, %loop.latch23 ]
  %t192 = phi i8* [ %t104, %then19 ], [ %t190, %loop.latch23 ]
  store i1 %t191, i1* %l11
  store i8* %t192, i8** %l10
  br label %loop.body22
loop.body22:
  %t106 = load %LexerState, %LexerState* %l0
  %t107 = extractvalue %LexerState %t106, 1
  %t108 = load %LexerState, %LexerState* %l0
  %t109 = extractvalue %LexerState %t108, 0
  %t110 = call i64 @sailfin_runtime_string_length(i8* %t109)
  %t111 = sitofp i64 %t110 to double
  %t112 = fcmp oge double %t107, %t111
  %t113 = load %LexerState, %LexerState* %l0
  %t114 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t115 = load i8, i8* %l2
  %t116 = load double, double* %l7
  %t117 = load double, double* %l8
  %t118 = load double, double* %l9
  %t119 = load i8*, i8** %l10
  %t120 = load i1, i1* %l11
  br i1 %t112, label %then25, label %merge26
then25:
  br label %afterloop24
merge26:
  %t121 = load %LexerState, %LexerState* %l0
  %t122 = extractvalue %LexerState %t121, 0
  %t123 = load %LexerState, %LexerState* %l0
  %t124 = extractvalue %LexerState %t123, 1
  %t125 = getelementptr i8, i8* %t122, i64 %t124
  %t126 = load i8, i8* %t125
  store i8 %t126, i8* %l12
  %t128 = load i1, i1* %l11
  br label %logical_and_entry_127

logical_and_entry_127:
  br i1 %t128, label %logical_and_right_127, label %logical_and_merge_127

logical_and_right_127:
  %t129 = load i8, i8* %l12
  %t130 = call i1 @is_double_quote(i8* null)
  br label %logical_and_right_end_127

logical_and_right_end_127:
  br label %logical_and_merge_127

logical_and_merge_127:
  %t131 = phi i1 [ false, %logical_and_entry_127 ], [ %t130, %logical_and_right_end_127 ]
  %t132 = xor i1 %t131, 1
  %t133 = load %LexerState, %LexerState* %l0
  %t134 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t135 = load i8, i8* %l2
  %t136 = load double, double* %l7
  %t137 = load double, double* %l8
  %t138 = load double, double* %l9
  %t139 = load i8*, i8** %l10
  %t140 = load i1, i1* %l11
  %t141 = load i8, i8* %l12
  br i1 %t132, label %then27, label %merge28
then27:
  br label %afterloop24
merge28:
  %t143 = load i1, i1* %l11
  br label %logical_and_entry_142

logical_and_entry_142:
  br i1 %t143, label %logical_and_right_142, label %logical_and_merge_142

logical_and_right_142:
  %t144 = load i8, i8* %l12
  %t145 = call i1 @is_backslash(i8* null)
  br label %logical_and_right_end_142

logical_and_right_end_142:
  br label %logical_and_merge_142

logical_and_merge_142:
  %t146 = phi i1 [ false, %logical_and_entry_142 ], [ %t145, %logical_and_right_end_142 ]
  %t147 = xor i1 %t146, 1
  %t148 = load %LexerState, %LexerState* %l0
  %t149 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t150 = load i8, i8* %l2
  %t151 = load double, double* %l7
  %t152 = load double, double* %l8
  %t153 = load double, double* %l9
  %t154 = load i8*, i8** %l10
  %t155 = load i1, i1* %l11
  %t156 = load i8, i8* %l12
  br i1 %t147, label %then29, label %merge30
then29:
  store i1 1, i1* %l11
  br label %loop.latch23
merge30:
  %t157 = load i1, i1* %l11
  %t158 = load %LexerState, %LexerState* %l0
  %t159 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t160 = load i8, i8* %l2
  %t161 = load double, double* %l7
  %t162 = load double, double* %l8
  %t163 = load double, double* %l9
  %t164 = load i8*, i8** %l10
  %t165 = load i1, i1* %l11
  %t166 = load i8, i8* %l12
  br i1 %t157, label %then31, label %else32
then31:
  %t167 = load i8*, i8** %l10
  %t168 = load i8, i8* %l12
  %t169 = call i8* @interpret_escape(i8* null)
  %t170 = add i8* %t167, %t169
  store i8* %t170, i8** %l10
  store i1 0, i1* %l11
  br label %merge33
else32:
  %t171 = load i8*, i8** %l10
  %t172 = load i8, i8* %l12
  %t173 = getelementptr i8, i8* %t171, i64 0
  %t174 = load i8, i8* %t173
  %t175 = add i8 %t174, %t172
  store i8* null, i8** %l10
  br label %merge33
merge33:
  %t176 = phi i8* [ %t170, %then31 ], [ null, %else32 ]
  %t177 = phi i1 [ 0, %then31 ], [ %t165, %else32 ]
  store i8* %t176, i8** %l10
  store i1 %t177, i1* %l11
  %t178 = load i8, i8* %l12
  %t179 = icmp eq i8 %t178, 10
  %t180 = load %LexerState, %LexerState* %l0
  %t181 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t182 = load i8, i8* %l2
  %t183 = load double, double* %l7
  %t184 = load double, double* %l8
  %t185 = load double, double* %l9
  %t186 = load i8*, i8** %l10
  %t187 = load i1, i1* %l11
  %t188 = load i8, i8* %l12
  br i1 %t179, label %then34, label %else35
then34:
  br label %merge36
else35:
  br label %merge36
merge36:
  br label %loop.latch23
loop.latch23:
  %t189 = load i1, i1* %l11
  %t190 = load i8*, i8** %l10
  br label %loop.header21
afterloop24:
  %t193 = load %LexerState, %LexerState* %l0
  %t194 = extractvalue %LexerState %t193, 0
  %t195 = load double, double* %l7
  %t196 = load %LexerState, %LexerState* %l0
  %t197 = extractvalue %LexerState %t196, 1
  %t198 = call i8* @slice(i8* %t194, double %t195, double %t197)
  store i8* %t198, i8** %l13
  br label %loop.latch2
merge20:
  %t199 = load i8, i8* %l2
  %t200 = call i1 @is_digit(i8* null)
  %t201 = load %LexerState, %LexerState* %l0
  %t202 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t203 = load i8, i8* %l2
  br i1 %t200, label %then37, label %merge38
then37:
  %t204 = load %LexerState, %LexerState* %l0
  %t205 = extractvalue %LexerState %t204, 1
  store double %t205, double* %l14
  %t206 = load %LexerState, %LexerState* %l0
  %t207 = extractvalue %LexerState %t206, 2
  store double %t207, double* %l15
  %t208 = load %LexerState, %LexerState* %l0
  %t209 = extractvalue %LexerState %t208, 3
  store double %t209, double* %l16
  %t210 = load %LexerState, %LexerState* %l0
  %t211 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t212 = load i8, i8* %l2
  %t213 = load double, double* %l14
  %t214 = load double, double* %l15
  %t215 = load double, double* %l16
  br label %loop.header39
loop.header39:
  br label %loop.body40
loop.body40:
  %t216 = load %LexerState, %LexerState* %l0
  %t217 = extractvalue %LexerState %t216, 1
  %t218 = load %LexerState, %LexerState* %l0
  %t219 = extractvalue %LexerState %t218, 0
  %t220 = call i64 @sailfin_runtime_string_length(i8* %t219)
  %t221 = sitofp i64 %t220 to double
  %t222 = fcmp oge double %t217, %t221
  %t223 = load %LexerState, %LexerState* %l0
  %t224 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t225 = load i8, i8* %l2
  %t226 = load double, double* %l14
  %t227 = load double, double* %l15
  %t228 = load double, double* %l16
  br i1 %t222, label %then43, label %merge44
then43:
  br label %afterloop42
merge44:
  %t229 = load %LexerState, %LexerState* %l0
  %t230 = extractvalue %LexerState %t229, 0
  %t231 = load %LexerState, %LexerState* %l0
  %t232 = extractvalue %LexerState %t231, 1
  %t233 = getelementptr i8, i8* %t230, i64 %t232
  %t234 = load i8, i8* %t233
  %t235 = call i1 @is_digit(i8* null)
  %t236 = xor i1 %t235, 1
  %t237 = load %LexerState, %LexerState* %l0
  %t238 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t239 = load i8, i8* %l2
  %t240 = load double, double* %l14
  %t241 = load double, double* %l15
  %t242 = load double, double* %l16
  br i1 %t236, label %then45, label %merge46
then45:
  br label %afterloop42
merge46:
  br label %loop.latch41
loop.latch41:
  br label %loop.header39
afterloop42:
  %t244 = load %LexerState, %LexerState* %l0
  %t245 = extractvalue %LexerState %t244, 1
  %t246 = load %LexerState, %LexerState* %l0
  %t247 = extractvalue %LexerState %t246, 0
  %t248 = call i64 @sailfin_runtime_string_length(i8* %t247)
  %t249 = sitofp i64 %t248 to double
  %t250 = fcmp olt double %t245, %t249
  br label %logical_and_entry_243

logical_and_entry_243:
  br i1 %t250, label %logical_and_right_243, label %logical_and_merge_243

logical_and_right_243:
  %t251 = load %LexerState, %LexerState* %l0
  %t252 = extractvalue %LexerState %t251, 0
  %t253 = load %LexerState, %LexerState* %l0
  %t254 = extractvalue %LexerState %t253, 1
  %t255 = getelementptr i8, i8* %t252, i64 %t254
  %t256 = load i8, i8* %t255
  %t257 = icmp eq i8 %t256, 46
  br label %logical_and_right_end_243

logical_and_right_end_243:
  br label %logical_and_merge_243

logical_and_merge_243:
  %t258 = phi i1 [ false, %logical_and_entry_243 ], [ %t257, %logical_and_right_end_243 ]
  %t259 = load %LexerState, %LexerState* %l0
  %t260 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t261 = load i8, i8* %l2
  %t262 = load double, double* %l14
  %t263 = load double, double* %l15
  %t264 = load double, double* %l16
  br i1 %t258, label %then47, label %merge48
then47:
  %t266 = load %LexerState, %LexerState* %l0
  %t267 = extractvalue %LexerState %t266, 1
  %t268 = sitofp i64 1 to double
  %t269 = fadd double %t267, %t268
  %t270 = load %LexerState, %LexerState* %l0
  %t271 = extractvalue %LexerState %t270, 0
  %t272 = call i64 @sailfin_runtime_string_length(i8* %t271)
  %t273 = sitofp i64 %t272 to double
  %t274 = fcmp olt double %t269, %t273
  br label %logical_and_entry_265

logical_and_entry_265:
  br i1 %t274, label %logical_and_right_265, label %logical_and_merge_265

logical_and_right_265:
  store double 0.0, double* %l17
  %t275 = load double, double* %l17
  %t276 = fcmp one double %t275, 0.0
  %t277 = load %LexerState, %LexerState* %l0
  %t278 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t279 = load i8, i8* %l2
  %t280 = load double, double* %l14
  %t281 = load double, double* %l15
  %t282 = load double, double* %l16
  %t283 = load double, double* %l17
  br i1 %t276, label %then49, label %merge50
then49:
  %t284 = load %LexerState, %LexerState* %l0
  %t285 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t286 = load i8, i8* %l2
  %t287 = load double, double* %l14
  %t288 = load double, double* %l15
  %t289 = load double, double* %l16
  %t290 = load double, double* %l17
  br label %loop.header51
loop.header51:
  br label %loop.body52
loop.body52:
  %t291 = load %LexerState, %LexerState* %l0
  %t292 = extractvalue %LexerState %t291, 1
  %t293 = load %LexerState, %LexerState* %l0
  %t294 = extractvalue %LexerState %t293, 0
  %t295 = call i64 @sailfin_runtime_string_length(i8* %t294)
  %t296 = sitofp i64 %t295 to double
  %t297 = fcmp oge double %t292, %t296
  %t298 = load %LexerState, %LexerState* %l0
  %t299 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t300 = load i8, i8* %l2
  %t301 = load double, double* %l14
  %t302 = load double, double* %l15
  %t303 = load double, double* %l16
  %t304 = load double, double* %l17
  br i1 %t297, label %then55, label %merge56
then55:
  br label %afterloop54
merge56:
  %t305 = load %LexerState, %LexerState* %l0
  %t306 = extractvalue %LexerState %t305, 0
  %t307 = load %LexerState, %LexerState* %l0
  %t308 = extractvalue %LexerState %t307, 1
  %t309 = getelementptr i8, i8* %t306, i64 %t308
  %t310 = load i8, i8* %t309
  %t311 = call i1 @is_digit(i8* null)
  %t312 = xor i1 %t311, 1
  %t313 = load %LexerState, %LexerState* %l0
  %t314 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t315 = load i8, i8* %l2
  %t316 = load double, double* %l14
  %t317 = load double, double* %l15
  %t318 = load double, double* %l16
  %t319 = load double, double* %l17
  br i1 %t312, label %then57, label %merge58
then57:
  br label %afterloop54
merge58:
  br label %loop.latch53
loop.latch53:
  br label %loop.header51
afterloop54:
  br label %merge50
merge50:
  br label %merge48
merge48:
  %t320 = load %LexerState, %LexerState* %l0
  %t321 = extractvalue %LexerState %t320, 0
  %t322 = load double, double* %l14
  %t323 = load %LexerState, %LexerState* %l0
  %t324 = extractvalue %LexerState %t323, 1
  %t325 = call i8* @slice(i8* %t321, double %t322, double %t324)
  store i8* %t325, i8** %l18
  br label %loop.latch2
merge38:
  %t326 = load i8, i8* %l2
  %t327 = call i1 @is_identifier_start(i8* null)
  %t328 = load %LexerState, %LexerState* %l0
  %t329 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t330 = load i8, i8* %l2
  br i1 %t327, label %then59, label %merge60
then59:
  %t331 = load %LexerState, %LexerState* %l0
  %t332 = extractvalue %LexerState %t331, 1
  store double %t332, double* %l19
  %t333 = load %LexerState, %LexerState* %l0
  %t334 = extractvalue %LexerState %t333, 2
  store double %t334, double* %l20
  %t335 = load %LexerState, %LexerState* %l0
  %t336 = extractvalue %LexerState %t335, 3
  store double %t336, double* %l21
  %t337 = load %LexerState, %LexerState* %l0
  %t338 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t339 = load i8, i8* %l2
  %t340 = load double, double* %l19
  %t341 = load double, double* %l20
  %t342 = load double, double* %l21
  br label %loop.header61
loop.header61:
  br label %loop.body62
loop.body62:
  %t343 = load %LexerState, %LexerState* %l0
  %t344 = extractvalue %LexerState %t343, 1
  %t345 = load %LexerState, %LexerState* %l0
  %t346 = extractvalue %LexerState %t345, 0
  %t347 = call i64 @sailfin_runtime_string_length(i8* %t346)
  %t348 = sitofp i64 %t347 to double
  %t349 = fcmp oge double %t344, %t348
  %t350 = load %LexerState, %LexerState* %l0
  %t351 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t352 = load i8, i8* %l2
  %t353 = load double, double* %l19
  %t354 = load double, double* %l20
  %t355 = load double, double* %l21
  br i1 %t349, label %then65, label %merge66
then65:
  br label %afterloop64
merge66:
  %t356 = load %LexerState, %LexerState* %l0
  %t357 = extractvalue %LexerState %t356, 0
  %t358 = load %LexerState, %LexerState* %l0
  %t359 = extractvalue %LexerState %t358, 1
  %t360 = getelementptr i8, i8* %t357, i64 %t359
  %t361 = load i8, i8* %t360
  %t362 = call i1 @is_identifier_part(i8* null)
  %t363 = xor i1 %t362, 1
  %t364 = load %LexerState, %LexerState* %l0
  %t365 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t366 = load i8, i8* %l2
  %t367 = load double, double* %l19
  %t368 = load double, double* %l20
  %t369 = load double, double* %l21
  br i1 %t363, label %then67, label %merge68
then67:
  br label %afterloop64
merge68:
  br label %loop.latch63
loop.latch63:
  br label %loop.header61
afterloop64:
  %t370 = load %LexerState, %LexerState* %l0
  %t371 = extractvalue %LexerState %t370, 0
  %t372 = load double, double* %l19
  %t373 = load %LexerState, %LexerState* %l0
  %t374 = extractvalue %LexerState %t373, 1
  %t375 = call i8* @slice(i8* %t371, double %t372, double %t374)
  store i8* %t375, i8** %l22
  %t377 = load i8*, i8** %l22
  %s378 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.378, i32 0, i32 0
  %t379 = icmp eq i8* %t377, %s378
  br label %logical_or_entry_376

logical_or_entry_376:
  br i1 %t379, label %logical_or_merge_376, label %logical_or_right_376

logical_or_right_376:
  %t380 = load i8*, i8** %l22
  %s381 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.381, i32 0, i32 0
  %t382 = icmp eq i8* %t380, %s381
  br label %logical_or_right_end_376

logical_or_right_end_376:
  br label %logical_or_merge_376

logical_or_merge_376:
  %t383 = phi i1 [ true, %logical_or_entry_376 ], [ %t382, %logical_or_right_end_376 ]
  %t384 = load %LexerState, %LexerState* %l0
  %t385 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t386 = load i8, i8* %l2
  %t387 = load double, double* %l19
  %t388 = load double, double* %l20
  %t389 = load double, double* %l21
  %t390 = load i8*, i8** %l22
  br i1 %t383, label %then69, label %else70
then69:
  %t391 = load i8*, i8** %l22
  %s392 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.392, i32 0, i32 0
  %t393 = icmp eq i8* %t391, %s392
  store i1 %t393, i1* %l23
  br label %merge71
else70:
  br label %merge71
merge71:
  %t394 = phi { %Token*, i64 }* [ null, %then69 ], [ null, %else70 ]
  store { %Token*, i64 }* %t394, { %Token*, i64 }** %l1
  br label %loop.latch2
merge60:
  %t395 = load %LexerState, %LexerState* %l0
  %t396 = extractvalue %LexerState %t395, 2
  store double %t396, double* %l24
  %t397 = load %LexerState, %LexerState* %l0
  %t398 = extractvalue %LexerState %t397, 3
  store double %t398, double* %l25
  %t399 = load i8, i8* %l2
  store i8 %t399, i8* %l26
  %t400 = load %LexerState, %LexerState* %l0
  %t401 = call i8* @peek_next_char(%LexerState %t400)
  store i8* %t401, i8** %l27
  %t402 = load i8*, i8** %l27
  %s403 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.403, i32 0, i32 0
  %t404 = icmp ne i8* %t402, %s403
  %t405 = load %LexerState, %LexerState* %l0
  %t406 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t407 = load i8, i8* %l2
  %t408 = load double, double* %l24
  %t409 = load double, double* %l25
  %t410 = load i8, i8* %l26
  %t411 = load i8*, i8** %l27
  br i1 %t404, label %then72, label %merge73
then72:
  %t412 = load i8, i8* %l2
  %t413 = load i8*, i8** %l27
  %t414 = getelementptr i8, i8* %t413, i64 0
  %t415 = load i8, i8* %t414
  %t416 = add i8 %t412, %t415
  store i8 %t416, i8* %l28
  %t417 = load i8, i8* %l28
  %t418 = call i1 @is_two_char_symbol(i8* null)
  %t419 = load %LexerState, %LexerState* %l0
  %t420 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t421 = load i8, i8* %l2
  %t422 = load double, double* %l24
  %t423 = load double, double* %l25
  %t424 = load i8, i8* %l26
  %t425 = load i8*, i8** %l27
  %t426 = load i8, i8* %l28
  br i1 %t418, label %then74, label %merge75
then74:
  %t427 = load i8, i8* %l28
  store i8 %t427, i8* %l26
  br label %loop.latch2
merge75:
  br label %merge73
merge73:
  %t428 = phi i8 [ %t427, %then72 ], [ %t410, %loop.body1 ]
  %t429 = phi { %Token*, i64 }* [ null, %then72 ], [ %t406, %loop.body1 ]
  store i8 %t428, i8* %l26
  store { %Token*, i64 }* %t429, { %Token*, i64 }** %l1
  %t430 = load i8, i8* %l2
  %t431 = icmp eq i8 %t430, 10
  %t432 = load %LexerState, %LexerState* %l0
  %t433 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t434 = load i8, i8* %l2
  %t435 = load double, double* %l24
  %t436 = load double, double* %l25
  %t437 = load i8, i8* %l26
  %t438 = load i8*, i8** %l27
  br i1 %t431, label %then76, label %else77
then76:
  br label %merge78
else77:
  br label %merge78
merge78:
  br label %loop.latch2
loop.latch2:
  %t439 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br label %loop.header0
afterloop3:
  %t441 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t442 = load %LexerState, %LexerState* %l0
  %t443 = extractvalue %LexerState %t442, 2
  %t444 = load %LexerState, %LexerState* %l0
  %t445 = extractvalue %LexerState %t444, 3
  %t446 = call double @eof_token(double %t443, double %t445)
  %t447 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t441, %Token zeroinitializer)
  store { %Token*, i64 }* %t447, { %Token*, i64 }** %l1
  %t448 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  ret { %Token*, i64 }* %t448
}

define i1 @is_whitespace(i8* %ch) {
entry:
  %t3 = getelementptr i8, i8* %ch, i64 0
  %t4 = load i8, i8* %t3
  %t5 = icmp eq i8 %t4, 32
  br label %logical_or_entry_2

logical_or_entry_2:
  br i1 %t5, label %logical_or_merge_2, label %logical_or_right_2

logical_or_right_2:
  %t6 = getelementptr i8, i8* %ch, i64 0
  %t7 = load i8, i8* %t6
  %t8 = icmp eq i8 %t7, 9
  br label %logical_or_right_end_2

logical_or_right_end_2:
  br label %logical_or_merge_2

logical_or_merge_2:
  %t9 = phi i1 [ true, %logical_or_entry_2 ], [ %t8, %logical_or_right_end_2 ]
  br label %logical_or_entry_1

logical_or_entry_1:
  br i1 %t9, label %logical_or_merge_1, label %logical_or_right_1

logical_or_right_1:
  %t10 = getelementptr i8, i8* %ch, i64 0
  %t11 = load i8, i8* %t10
  %t12 = icmp eq i8 %t11, 10
  br label %logical_or_right_end_1

logical_or_right_end_1:
  br label %logical_or_merge_1

logical_or_merge_1:
  %t13 = phi i1 [ true, %logical_or_entry_1 ], [ %t12, %logical_or_right_end_1 ]
  br label %logical_or_entry_0

logical_or_entry_0:
  br i1 %t13, label %logical_or_merge_0, label %logical_or_right_0

logical_or_right_0:
  %t14 = getelementptr i8, i8* %ch, i64 0
  %t15 = load i8, i8* %t14
  %t16 = icmp eq i8 %t15, 13
  br label %logical_or_right_end_0

logical_or_right_end_0:
  br label %logical_or_merge_0

logical_or_merge_0:
  %t17 = phi i1 [ true, %logical_or_entry_0 ], [ %t16, %logical_or_right_end_0 ]
  ret i1 %t17
}

define i1 @is_identifier_start(i8* %ch) {
entry:
  %t1 = call i1 @is_letter(i8* %ch)
  br label %logical_or_entry_0

logical_or_entry_0:
  br i1 %t1, label %logical_or_merge_0, label %logical_or_right_0

logical_or_right_0:
  %t2 = getelementptr i8, i8* %ch, i64 0
  %t3 = load i8, i8* %t2
  %t4 = icmp eq i8 %t3, 95
  br label %logical_or_right_end_0

logical_or_right_end_0:
  br label %logical_or_merge_0

logical_or_merge_0:
  %t5 = phi i1 [ true, %logical_or_entry_0 ], [ %t4, %logical_or_right_end_0 ]
  ret i1 %t5
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
  %t4 = call double @char_code(i8 97)
  %t5 = fcmp oge double %t3, %t4
  br label %logical_and_entry_2

logical_and_entry_2:
  br i1 %t5, label %logical_and_right_2, label %logical_and_merge_2

logical_and_right_2:
  %t6 = load double, double* %l0
  %t7 = call double @char_code(i8 122)
  %t8 = fcmp ole double %t6, %t7
  br label %logical_and_right_end_2

logical_and_right_end_2:
  br label %logical_and_merge_2

logical_and_merge_2:
  %t9 = phi i1 [ false, %logical_and_entry_2 ], [ %t8, %logical_and_right_end_2 ]
  br label %logical_or_entry_1

logical_or_entry_1:
  br i1 %t9, label %logical_or_merge_1, label %logical_or_right_1

logical_or_right_1:
  %t11 = load double, double* %l0
  %t12 = call double @char_code(i8 65)
  %t13 = fcmp oge double %t11, %t12
  br label %logical_and_entry_10

logical_and_entry_10:
  br i1 %t13, label %logical_and_right_10, label %logical_and_merge_10

logical_and_right_10:
  %t14 = load double, double* %l0
  %t15 = call double @char_code(i8 90)
  %t16 = fcmp ole double %t14, %t15
  br label %logical_and_right_end_10

logical_and_right_end_10:
  br label %logical_and_merge_10

logical_and_merge_10:
  %t17 = phi i1 [ false, %logical_and_entry_10 ], [ %t16, %logical_and_right_end_10 ]
  br label %logical_or_right_end_1

logical_or_right_end_1:
  br label %logical_or_merge_1

logical_or_merge_1:
  %t18 = phi i1 [ true, %logical_or_entry_1 ], [ %t17, %logical_or_right_end_1 ]
  ret i1 %t18
}

define i1 @is_digit(i8* %ch) {
entry:
  %l0 = alloca double
  %t0 = call double @char_code(i8* %ch)
  store double %t0, double* %l0
  %t2 = load double, double* %l0
  %t3 = call double @char_code(i8 48)
  %t4 = fcmp oge double %t2, %t3
  br label %logical_and_entry_1

logical_and_entry_1:
  br i1 %t4, label %logical_and_right_1, label %logical_and_merge_1

logical_and_right_1:
  %t5 = load double, double* %l0
  %t6 = call double @char_code(i8 57)
  %t7 = fcmp ole double %t5, %t6
  br label %logical_and_right_end_1

logical_and_right_end_1:
  br label %logical_and_merge_1

logical_and_merge_1:
  %t8 = phi i1 [ false, %logical_and_entry_1 ], [ %t7, %logical_and_right_end_1 ]
  ret i1 %t8
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
  %t0 = fptosi double %start to i64
  %t1 = fptosi double %end to i64
  %t2 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t0, i64 %t1)
  ret i8* %t2
}

define { %Token*, i64 }* @append({ %Token*, i64 }* %tokens, %Token %token) {
entry:
  %t0 = alloca [1 x %Token]
  %t1 = getelementptr [1 x %Token], [1 x %Token]* %t0, i32 0, i32 0
  %t2 = getelementptr %Token, %Token* %t1, i64 0
  store %Token %token, %Token* %t2
  %t3 = alloca { %Token*, i64 }
  %t4 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t3, i32 0, i32 0
  store %Token* %t1, %Token** %t4
  %t5 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = bitcast { %Token*, i64 }* %tokens to { i8**, i64 }*
  %t7 = bitcast { %Token*, i64 }* %t3 to { i8**, i64 }*
  %t8 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t6, { i8**, i64 }* %t7)
  %t9 = bitcast { i8**, i64 }* %t8 to { %Token*, i64 }*
  ret { %Token*, i64 }* %t9
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
  %t5 = call i64 @sailfin_runtime_string_length(i8* %t4)
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp oge double %t3, %t6
  %t8 = load double, double* %l0
  br i1 %t7, label %then0, label %merge1
then0:
  %s9 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.9, i32 0, i32 0
  ret i8* %s9
merge1:
  %t10 = extractvalue %LexerState %state, 0
  %t11 = load double, double* %l0
  %t12 = getelementptr i8, i8* %t10, i64 %t11
  %t13 = load i8, i8* %t12
  ret i8* null
}

define i8* @interpret_escape(i8* %ch) {
entry:
  %t0 = getelementptr i8, i8* %ch, i64 0
  %t1 = load i8, i8* %t0
  %t2 = icmp eq i8 %t1, 110
  br i1 %t2, label %then0, label %merge1
then0:
  ret i8* null
merge1:
  %t3 = getelementptr i8, i8* %ch, i64 0
  %t4 = load i8, i8* %t3
  %t5 = icmp eq i8 %t4, 116
  br i1 %t5, label %then2, label %merge3
then2:
  ret i8* null
merge3:
  %t6 = getelementptr i8, i8* %ch, i64 0
  %t7 = load i8, i8* %t6
  %t8 = icmp eq i8 %t7, 114
  br i1 %t8, label %then4, label %merge5
then4:
  ret i8* null
merge5:
  %t9 = call i1 @is_double_quote(i8* %ch)
  br i1 %t9, label %then6, label %merge7
then6:
  ret i8* null
merge7:
  %t10 = call i1 @is_backslash(i8* %ch)
  br i1 %t10, label %then8, label %merge9
then8:
  ret i8* null
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
