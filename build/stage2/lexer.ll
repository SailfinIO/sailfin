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
  %t0 = insertvalue %LexerState undef, i8* %source, 0
  %t1 = sitofp i64 0 to double
  %t2 = insertvalue %LexerState %t0, double %t1, 1
  %t3 = sitofp i64 1 to double
  %t4 = insertvalue %LexerState %t2, double %t3, 2
  %t5 = sitofp i64 1 to double
  %t6 = insertvalue %LexerState %t4, double %t5, 3
  store %LexerState %t6, %LexerState* %l0
  %t7 = alloca [0 x %Token]
  %t8 = getelementptr [0 x %Token], [0 x %Token]* %t7, i32 0, i32 0
  %t9 = alloca { %Token*, i64 }
  %t10 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t9, i32 0, i32 0
  store %Token* %t8, %Token** %t10
  %t11 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { %Token*, i64 }* %t9, { %Token*, i64 }** %l1
  %t12 = load %LexerState, %LexerState* %l0
  %t13 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br label %loop.header0
loop.header0:
  %t565 = phi { %Token*, i64 }* [ %t13, %entry ], [ %t564, %loop.latch2 ]
  store { %Token*, i64 }* %t565, { %Token*, i64 }** %l1
  br label %loop.body1
loop.body1:
  %t14 = load %LexerState, %LexerState* %l0
  %t15 = extractvalue %LexerState %t14, 1
  %t16 = load %LexerState, %LexerState* %l0
  %t17 = extractvalue %LexerState %t16, 0
  %t18 = call i64 @sailfin_runtime_string_length(i8* %t17)
  %t19 = sitofp i64 %t18 to double
  %t20 = fcmp oge double %t15, %t19
  %t21 = load %LexerState, %LexerState* %l0
  %t22 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br i1 %t20, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t23 = load %LexerState, %LexerState* %l0
  %t24 = extractvalue %LexerState %t23, 0
  %t25 = load %LexerState, %LexerState* %l0
  %t26 = extractvalue %LexerState %t25, 1
  %t27 = fptosi double %t26 to i64
  %t28 = getelementptr i8, i8* %t24, i64 %t27
  %t29 = load i8, i8* %t28
  store i8 %t29, i8* %l2
  %t30 = load i8, i8* %l2
  %t31 = call i1 @is_whitespace(i8* null)
  %t32 = load %LexerState, %LexerState* %l0
  %t33 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t34 = load i8, i8* %l2
  br i1 %t31, label %then6, label %merge7
then6:
  %t35 = load %LexerState, %LexerState* %l0
  %t36 = extractvalue %LexerState %t35, 1
  store double %t36, double* %l3
  %t37 = load %LexerState, %LexerState* %l0
  %t38 = extractvalue %LexerState %t37, 2
  store double %t38, double* %l4
  %t39 = load %LexerState, %LexerState* %l0
  %t40 = extractvalue %LexerState %t39, 3
  store double %t40, double* %l5
  %t41 = load %LexerState, %LexerState* %l0
  %t42 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t43 = load i8, i8* %l2
  %t44 = load double, double* %l3
  %t45 = load double, double* %l4
  %t46 = load double, double* %l5
  br label %loop.header8
loop.header8:
  br label %loop.body9
loop.body9:
  %t47 = load %LexerState, %LexerState* %l0
  %t48 = extractvalue %LexerState %t47, 1
  %t49 = load %LexerState, %LexerState* %l0
  %t50 = extractvalue %LexerState %t49, 0
  %t51 = call i64 @sailfin_runtime_string_length(i8* %t50)
  %t52 = sitofp i64 %t51 to double
  %t53 = fcmp oge double %t48, %t52
  %t54 = load %LexerState, %LexerState* %l0
  %t55 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t56 = load i8, i8* %l2
  %t57 = load double, double* %l3
  %t58 = load double, double* %l4
  %t59 = load double, double* %l5
  br i1 %t53, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t60 = load %LexerState, %LexerState* %l0
  %t61 = extractvalue %LexerState %t60, 0
  %t62 = load %LexerState, %LexerState* %l0
  %t63 = extractvalue %LexerState %t62, 1
  %t64 = fptosi double %t63 to i64
  %t65 = getelementptr i8, i8* %t61, i64 %t64
  %t66 = load i8, i8* %t65
  %t67 = call i1 @is_whitespace(i8* null)
  %t68 = xor i1 %t67, 1
  %t69 = load %LexerState, %LexerState* %l0
  %t70 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t71 = load i8, i8* %l2
  %t72 = load double, double* %l3
  %t73 = load double, double* %l4
  %t74 = load double, double* %l5
  br i1 %t68, label %then14, label %merge15
then14:
  br label %afterloop11
merge15:
  %t75 = load %LexerState, %LexerState* %l0
  %t76 = extractvalue %LexerState %t75, 0
  %t77 = load %LexerState, %LexerState* %l0
  %t78 = extractvalue %LexerState %t77, 1
  %t79 = fptosi double %t78 to i64
  %t80 = getelementptr i8, i8* %t76, i64 %t79
  %t81 = load i8, i8* %t80
  %t82 = icmp eq i8 %t81, 10
  %t83 = load %LexerState, %LexerState* %l0
  %t84 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t85 = load i8, i8* %l2
  %t86 = load double, double* %l3
  %t87 = load double, double* %l4
  %t88 = load double, double* %l5
  br i1 %t82, label %then16, label %else17
then16:
  br label %merge18
else17:
  br label %merge18
merge18:
  br label %loop.latch10
loop.latch10:
  br label %loop.header8
afterloop11:
  %t89 = load %LexerState, %LexerState* %l0
  %t90 = extractvalue %LexerState %t89, 0
  %t91 = load double, double* %l3
  %t92 = load %LexerState, %LexerState* %l0
  %t93 = extractvalue %LexerState %t92, 1
  %t94 = call i8* @slice(i8* %t90, double %t91, double %t93)
  store i8* %t94, i8** %l6
  %t95 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t96 = insertvalue %TokenKind undef, i32 5, 0
  %t97 = insertvalue %Token undef, i8* null, 0
  %t98 = load i8*, i8** %l6
  %t99 = insertvalue %Token %t97, i8* %t98, 1
  %t100 = load double, double* %l4
  %t101 = insertvalue %Token %t99, double %t100, 2
  %t102 = load double, double* %l5
  %t103 = insertvalue %Token %t101, double %t102, 3
  %t104 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t95, %Token %t103)
  store { %Token*, i64 }* %t104, { %Token*, i64 }** %l1
  br label %loop.latch2
merge7:
  %t105 = load i8, i8* %l2
  %t106 = load i8, i8* %l2
  %t107 = call i1 @is_double_quote(i8* null)
  %t108 = load %LexerState, %LexerState* %l0
  %t109 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t110 = load i8, i8* %l2
  br i1 %t107, label %then19, label %merge20
then19:
  %t111 = load %LexerState, %LexerState* %l0
  %t112 = extractvalue %LexerState %t111, 1
  store double %t112, double* %l7
  %t113 = load %LexerState, %LexerState* %l0
  %t114 = extractvalue %LexerState %t113, 2
  store double %t114, double* %l8
  %t115 = load %LexerState, %LexerState* %l0
  %t116 = extractvalue %LexerState %t115, 3
  store double %t116, double* %l9
  %s117 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.117, i32 0, i32 0
  store i8* %s117, i8** %l10
  store i1 0, i1* %l11
  %t118 = load %LexerState, %LexerState* %l0
  %t119 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t120 = load i8, i8* %l2
  %t121 = load double, double* %l7
  %t122 = load double, double* %l8
  %t123 = load double, double* %l9
  %t124 = load i8*, i8** %l10
  %t125 = load i1, i1* %l11
  br label %loop.header21
loop.header21:
  %t212 = phi i1 [ %t125, %then19 ], [ %t210, %loop.latch23 ]
  %t213 = phi i8* [ %t124, %then19 ], [ %t211, %loop.latch23 ]
  store i1 %t212, i1* %l11
  store i8* %t213, i8** %l10
  br label %loop.body22
loop.body22:
  %t126 = load %LexerState, %LexerState* %l0
  %t127 = extractvalue %LexerState %t126, 1
  %t128 = load %LexerState, %LexerState* %l0
  %t129 = extractvalue %LexerState %t128, 0
  %t130 = call i64 @sailfin_runtime_string_length(i8* %t129)
  %t131 = sitofp i64 %t130 to double
  %t132 = fcmp oge double %t127, %t131
  %t133 = load %LexerState, %LexerState* %l0
  %t134 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t135 = load i8, i8* %l2
  %t136 = load double, double* %l7
  %t137 = load double, double* %l8
  %t138 = load double, double* %l9
  %t139 = load i8*, i8** %l10
  %t140 = load i1, i1* %l11
  br i1 %t132, label %then25, label %merge26
then25:
  br label %afterloop24
merge26:
  %t141 = load %LexerState, %LexerState* %l0
  %t142 = extractvalue %LexerState %t141, 0
  %t143 = load %LexerState, %LexerState* %l0
  %t144 = extractvalue %LexerState %t143, 1
  %t145 = fptosi double %t144 to i64
  %t146 = getelementptr i8, i8* %t142, i64 %t145
  %t147 = load i8, i8* %t146
  store i8 %t147, i8* %l12
  %t149 = load i1, i1* %l11
  br label %logical_and_entry_148

logical_and_entry_148:
  br i1 %t149, label %logical_and_right_148, label %logical_and_merge_148

logical_and_right_148:
  %t150 = load i8, i8* %l12
  %t151 = call i1 @is_double_quote(i8* null)
  br label %logical_and_right_end_148

logical_and_right_end_148:
  br label %logical_and_merge_148

logical_and_merge_148:
  %t152 = phi i1 [ false, %logical_and_entry_148 ], [ %t151, %logical_and_right_end_148 ]
  %t153 = xor i1 %t152, 1
  %t154 = load %LexerState, %LexerState* %l0
  %t155 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t156 = load i8, i8* %l2
  %t157 = load double, double* %l7
  %t158 = load double, double* %l8
  %t159 = load double, double* %l9
  %t160 = load i8*, i8** %l10
  %t161 = load i1, i1* %l11
  %t162 = load i8, i8* %l12
  br i1 %t153, label %then27, label %merge28
then27:
  br label %afterloop24
merge28:
  %t164 = load i1, i1* %l11
  br label %logical_and_entry_163

logical_and_entry_163:
  br i1 %t164, label %logical_and_right_163, label %logical_and_merge_163

logical_and_right_163:
  %t165 = load i8, i8* %l12
  %t166 = call i1 @is_backslash(i8* null)
  br label %logical_and_right_end_163

logical_and_right_end_163:
  br label %logical_and_merge_163

logical_and_merge_163:
  %t167 = phi i1 [ false, %logical_and_entry_163 ], [ %t166, %logical_and_right_end_163 ]
  %t168 = xor i1 %t167, 1
  %t169 = load %LexerState, %LexerState* %l0
  %t170 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t171 = load i8, i8* %l2
  %t172 = load double, double* %l7
  %t173 = load double, double* %l8
  %t174 = load double, double* %l9
  %t175 = load i8*, i8** %l10
  %t176 = load i1, i1* %l11
  %t177 = load i8, i8* %l12
  br i1 %t168, label %then29, label %merge30
then29:
  store i1 1, i1* %l11
  br label %loop.latch23
merge30:
  %t178 = load i1, i1* %l11
  %t179 = load %LexerState, %LexerState* %l0
  %t180 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t181 = load i8, i8* %l2
  %t182 = load double, double* %l7
  %t183 = load double, double* %l8
  %t184 = load double, double* %l9
  %t185 = load i8*, i8** %l10
  %t186 = load i1, i1* %l11
  %t187 = load i8, i8* %l12
  br i1 %t178, label %then31, label %else32
then31:
  %t188 = load i8*, i8** %l10
  %t189 = load i8, i8* %l12
  %t190 = call i8* @interpret_escape(i8* null)
  %t191 = add i8* %t188, %t190
  store i8* %t191, i8** %l10
  store i1 0, i1* %l11
  br label %merge33
else32:
  %t192 = load i8*, i8** %l10
  %t193 = load i8, i8* %l12
  %t194 = getelementptr i8, i8* %t192, i64 0
  %t195 = load i8, i8* %t194
  %t196 = add i8 %t195, %t193
  store i8* null, i8** %l10
  br label %merge33
merge33:
  %t197 = phi i8* [ %t191, %then31 ], [ null, %else32 ]
  %t198 = phi i1 [ 0, %then31 ], [ %t186, %else32 ]
  store i8* %t197, i8** %l10
  store i1 %t198, i1* %l11
  %t199 = load i8, i8* %l12
  %t200 = icmp eq i8 %t199, 10
  %t201 = load %LexerState, %LexerState* %l0
  %t202 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t203 = load i8, i8* %l2
  %t204 = load double, double* %l7
  %t205 = load double, double* %l8
  %t206 = load double, double* %l9
  %t207 = load i8*, i8** %l10
  %t208 = load i1, i1* %l11
  %t209 = load i8, i8* %l12
  br i1 %t200, label %then34, label %else35
then34:
  br label %merge36
else35:
  br label %merge36
merge36:
  br label %loop.latch23
loop.latch23:
  %t210 = load i1, i1* %l11
  %t211 = load i8*, i8** %l10
  br label %loop.header21
afterloop24:
  %t214 = load %LexerState, %LexerState* %l0
  %t215 = extractvalue %LexerState %t214, 0
  %t216 = load double, double* %l7
  %t217 = load %LexerState, %LexerState* %l0
  %t218 = extractvalue %LexerState %t217, 1
  %t219 = call i8* @slice(i8* %t215, double %t216, double %t218)
  store i8* %t219, i8** %l13
  %t220 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t221 = alloca %TokenKind
  %t222 = getelementptr inbounds %TokenKind, %TokenKind* %t221, i32 0, i32 0
  store i32 2, i32* %t222
  %t223 = load i8*, i8** %l10
  %t224 = getelementptr inbounds %TokenKind, %TokenKind* %t221, i32 0, i32 1
  %t225 = bitcast [8 x i8]* %t224 to i8*
  %t226 = bitcast i8* %t225 to i8**
  store i8* %t223, i8** %t226
  %t227 = load %TokenKind, %TokenKind* %t221
  %t228 = insertvalue %Token undef, i8* null, 0
  %t229 = load i8*, i8** %l13
  %t230 = insertvalue %Token %t228, i8* %t229, 1
  %t231 = load double, double* %l8
  %t232 = insertvalue %Token %t230, double %t231, 2
  %t233 = load double, double* %l9
  %t234 = insertvalue %Token %t232, double %t233, 3
  %t235 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t220, %Token %t234)
  store { %Token*, i64 }* %t235, { %Token*, i64 }** %l1
  br label %loop.latch2
merge20:
  %t236 = load i8, i8* %l2
  %t237 = call i1 @is_digit(i8* null)
  %t238 = load %LexerState, %LexerState* %l0
  %t239 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t240 = load i8, i8* %l2
  br i1 %t237, label %then37, label %merge38
then37:
  %t241 = load %LexerState, %LexerState* %l0
  %t242 = extractvalue %LexerState %t241, 1
  store double %t242, double* %l14
  %t243 = load %LexerState, %LexerState* %l0
  %t244 = extractvalue %LexerState %t243, 2
  store double %t244, double* %l15
  %t245 = load %LexerState, %LexerState* %l0
  %t246 = extractvalue %LexerState %t245, 3
  store double %t246, double* %l16
  %t247 = load %LexerState, %LexerState* %l0
  %t248 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t249 = load i8, i8* %l2
  %t250 = load double, double* %l14
  %t251 = load double, double* %l15
  %t252 = load double, double* %l16
  br label %loop.header39
loop.header39:
  br label %loop.body40
loop.body40:
  %t253 = load %LexerState, %LexerState* %l0
  %t254 = extractvalue %LexerState %t253, 1
  %t255 = load %LexerState, %LexerState* %l0
  %t256 = extractvalue %LexerState %t255, 0
  %t257 = call i64 @sailfin_runtime_string_length(i8* %t256)
  %t258 = sitofp i64 %t257 to double
  %t259 = fcmp oge double %t254, %t258
  %t260 = load %LexerState, %LexerState* %l0
  %t261 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t262 = load i8, i8* %l2
  %t263 = load double, double* %l14
  %t264 = load double, double* %l15
  %t265 = load double, double* %l16
  br i1 %t259, label %then43, label %merge44
then43:
  br label %afterloop42
merge44:
  %t266 = load %LexerState, %LexerState* %l0
  %t267 = extractvalue %LexerState %t266, 0
  %t268 = load %LexerState, %LexerState* %l0
  %t269 = extractvalue %LexerState %t268, 1
  %t270 = fptosi double %t269 to i64
  %t271 = getelementptr i8, i8* %t267, i64 %t270
  %t272 = load i8, i8* %t271
  %t273 = call i1 @is_digit(i8* null)
  %t274 = xor i1 %t273, 1
  %t275 = load %LexerState, %LexerState* %l0
  %t276 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t277 = load i8, i8* %l2
  %t278 = load double, double* %l14
  %t279 = load double, double* %l15
  %t280 = load double, double* %l16
  br i1 %t274, label %then45, label %merge46
then45:
  br label %afterloop42
merge46:
  br label %loop.latch41
loop.latch41:
  br label %loop.header39
afterloop42:
  %t282 = load %LexerState, %LexerState* %l0
  %t283 = extractvalue %LexerState %t282, 1
  %t284 = load %LexerState, %LexerState* %l0
  %t285 = extractvalue %LexerState %t284, 0
  %t286 = call i64 @sailfin_runtime_string_length(i8* %t285)
  %t287 = sitofp i64 %t286 to double
  %t288 = fcmp olt double %t283, %t287
  br label %logical_and_entry_281

logical_and_entry_281:
  br i1 %t288, label %logical_and_right_281, label %logical_and_merge_281

logical_and_right_281:
  %t289 = load %LexerState, %LexerState* %l0
  %t290 = extractvalue %LexerState %t289, 0
  %t291 = load %LexerState, %LexerState* %l0
  %t292 = extractvalue %LexerState %t291, 1
  %t293 = fptosi double %t292 to i64
  %t294 = getelementptr i8, i8* %t290, i64 %t293
  %t295 = load i8, i8* %t294
  %t296 = icmp eq i8 %t295, 46
  br label %logical_and_right_end_281

logical_and_right_end_281:
  br label %logical_and_merge_281

logical_and_merge_281:
  %t297 = phi i1 [ false, %logical_and_entry_281 ], [ %t296, %logical_and_right_end_281 ]
  %t298 = load %LexerState, %LexerState* %l0
  %t299 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t300 = load i8, i8* %l2
  %t301 = load double, double* %l14
  %t302 = load double, double* %l15
  %t303 = load double, double* %l16
  br i1 %t297, label %then47, label %merge48
then47:
  %t305 = load %LexerState, %LexerState* %l0
  %t306 = extractvalue %LexerState %t305, 1
  %t307 = sitofp i64 1 to double
  %t308 = fadd double %t306, %t307
  %t309 = load %LexerState, %LexerState* %l0
  %t310 = extractvalue %LexerState %t309, 0
  %t311 = call i64 @sailfin_runtime_string_length(i8* %t310)
  %t312 = sitofp i64 %t311 to double
  %t313 = fcmp olt double %t308, %t312
  br label %logical_and_entry_304

logical_and_entry_304:
  br i1 %t313, label %logical_and_right_304, label %logical_and_merge_304

logical_and_right_304:
  store double 0.0, double* %l17
  %t314 = load double, double* %l17
  %t315 = fcmp one double %t314, 0.0
  %t316 = load %LexerState, %LexerState* %l0
  %t317 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t318 = load i8, i8* %l2
  %t319 = load double, double* %l14
  %t320 = load double, double* %l15
  %t321 = load double, double* %l16
  %t322 = load double, double* %l17
  br i1 %t315, label %then49, label %merge50
then49:
  %t323 = load %LexerState, %LexerState* %l0
  %t324 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t325 = load i8, i8* %l2
  %t326 = load double, double* %l14
  %t327 = load double, double* %l15
  %t328 = load double, double* %l16
  %t329 = load double, double* %l17
  br label %loop.header51
loop.header51:
  br label %loop.body52
loop.body52:
  %t330 = load %LexerState, %LexerState* %l0
  %t331 = extractvalue %LexerState %t330, 1
  %t332 = load %LexerState, %LexerState* %l0
  %t333 = extractvalue %LexerState %t332, 0
  %t334 = call i64 @sailfin_runtime_string_length(i8* %t333)
  %t335 = sitofp i64 %t334 to double
  %t336 = fcmp oge double %t331, %t335
  %t337 = load %LexerState, %LexerState* %l0
  %t338 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t339 = load i8, i8* %l2
  %t340 = load double, double* %l14
  %t341 = load double, double* %l15
  %t342 = load double, double* %l16
  %t343 = load double, double* %l17
  br i1 %t336, label %then55, label %merge56
then55:
  br label %afterloop54
merge56:
  %t344 = load %LexerState, %LexerState* %l0
  %t345 = extractvalue %LexerState %t344, 0
  %t346 = load %LexerState, %LexerState* %l0
  %t347 = extractvalue %LexerState %t346, 1
  %t348 = fptosi double %t347 to i64
  %t349 = getelementptr i8, i8* %t345, i64 %t348
  %t350 = load i8, i8* %t349
  %t351 = call i1 @is_digit(i8* null)
  %t352 = xor i1 %t351, 1
  %t353 = load %LexerState, %LexerState* %l0
  %t354 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t355 = load i8, i8* %l2
  %t356 = load double, double* %l14
  %t357 = load double, double* %l15
  %t358 = load double, double* %l16
  %t359 = load double, double* %l17
  br i1 %t352, label %then57, label %merge58
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
  %t360 = load %LexerState, %LexerState* %l0
  %t361 = extractvalue %LexerState %t360, 0
  %t362 = load double, double* %l14
  %t363 = load %LexerState, %LexerState* %l0
  %t364 = extractvalue %LexerState %t363, 1
  %t365 = call i8* @slice(i8* %t361, double %t362, double %t364)
  store i8* %t365, i8** %l18
  %t366 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t367 = alloca %TokenKind
  %t368 = getelementptr inbounds %TokenKind, %TokenKind* %t367, i32 0, i32 0
  store i32 1, i32* %t368
  %t369 = load i8*, i8** %l18
  %t370 = getelementptr inbounds %TokenKind, %TokenKind* %t367, i32 0, i32 1
  %t371 = bitcast [8 x i8]* %t370 to i8*
  %t372 = bitcast i8* %t371 to i8**
  store i8* %t369, i8** %t372
  %t373 = load %TokenKind, %TokenKind* %t367
  %t374 = insertvalue %Token undef, i8* null, 0
  %t375 = load i8*, i8** %l18
  %t376 = insertvalue %Token %t374, i8* %t375, 1
  %t377 = load double, double* %l15
  %t378 = insertvalue %Token %t376, double %t377, 2
  %t379 = load double, double* %l16
  %t380 = insertvalue %Token %t378, double %t379, 3
  %t381 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t366, %Token %t380)
  store { %Token*, i64 }* %t381, { %Token*, i64 }** %l1
  br label %loop.latch2
merge38:
  %t382 = load i8, i8* %l2
  %t383 = call i1 @is_identifier_start(i8* null)
  %t384 = load %LexerState, %LexerState* %l0
  %t385 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t386 = load i8, i8* %l2
  br i1 %t383, label %then59, label %merge60
then59:
  %t387 = load %LexerState, %LexerState* %l0
  %t388 = extractvalue %LexerState %t387, 1
  store double %t388, double* %l19
  %t389 = load %LexerState, %LexerState* %l0
  %t390 = extractvalue %LexerState %t389, 2
  store double %t390, double* %l20
  %t391 = load %LexerState, %LexerState* %l0
  %t392 = extractvalue %LexerState %t391, 3
  store double %t392, double* %l21
  %t393 = load %LexerState, %LexerState* %l0
  %t394 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t395 = load i8, i8* %l2
  %t396 = load double, double* %l19
  %t397 = load double, double* %l20
  %t398 = load double, double* %l21
  br label %loop.header61
loop.header61:
  br label %loop.body62
loop.body62:
  %t399 = load %LexerState, %LexerState* %l0
  %t400 = extractvalue %LexerState %t399, 1
  %t401 = load %LexerState, %LexerState* %l0
  %t402 = extractvalue %LexerState %t401, 0
  %t403 = call i64 @sailfin_runtime_string_length(i8* %t402)
  %t404 = sitofp i64 %t403 to double
  %t405 = fcmp oge double %t400, %t404
  %t406 = load %LexerState, %LexerState* %l0
  %t407 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t408 = load i8, i8* %l2
  %t409 = load double, double* %l19
  %t410 = load double, double* %l20
  %t411 = load double, double* %l21
  br i1 %t405, label %then65, label %merge66
then65:
  br label %afterloop64
merge66:
  %t412 = load %LexerState, %LexerState* %l0
  %t413 = extractvalue %LexerState %t412, 0
  %t414 = load %LexerState, %LexerState* %l0
  %t415 = extractvalue %LexerState %t414, 1
  %t416 = fptosi double %t415 to i64
  %t417 = getelementptr i8, i8* %t413, i64 %t416
  %t418 = load i8, i8* %t417
  %t419 = call i1 @is_identifier_part(i8* null)
  %t420 = xor i1 %t419, 1
  %t421 = load %LexerState, %LexerState* %l0
  %t422 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t423 = load i8, i8* %l2
  %t424 = load double, double* %l19
  %t425 = load double, double* %l20
  %t426 = load double, double* %l21
  br i1 %t420, label %then67, label %merge68
then67:
  br label %afterloop64
merge68:
  br label %loop.latch63
loop.latch63:
  br label %loop.header61
afterloop64:
  %t427 = load %LexerState, %LexerState* %l0
  %t428 = extractvalue %LexerState %t427, 0
  %t429 = load double, double* %l19
  %t430 = load %LexerState, %LexerState* %l0
  %t431 = extractvalue %LexerState %t430, 1
  %t432 = call i8* @slice(i8* %t428, double %t429, double %t431)
  store i8* %t432, i8** %l22
  %t434 = load i8*, i8** %l22
  %s435 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.435, i32 0, i32 0
  %t436 = icmp eq i8* %t434, %s435
  br label %logical_or_entry_433

logical_or_entry_433:
  br i1 %t436, label %logical_or_merge_433, label %logical_or_right_433

logical_or_right_433:
  %t437 = load i8*, i8** %l22
  %s438 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.438, i32 0, i32 0
  %t439 = icmp eq i8* %t437, %s438
  br label %logical_or_right_end_433

logical_or_right_end_433:
  br label %logical_or_merge_433

logical_or_merge_433:
  %t440 = phi i1 [ true, %logical_or_entry_433 ], [ %t439, %logical_or_right_end_433 ]
  %t441 = load %LexerState, %LexerState* %l0
  %t442 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t443 = load i8, i8* %l2
  %t444 = load double, double* %l19
  %t445 = load double, double* %l20
  %t446 = load double, double* %l21
  %t447 = load i8*, i8** %l22
  br i1 %t440, label %then69, label %else70
then69:
  %t448 = load i8*, i8** %l22
  %s449 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.449, i32 0, i32 0
  %t450 = icmp eq i8* %t448, %s449
  store i1 %t450, i1* %l23
  %t451 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t452 = alloca %TokenKind
  %t453 = getelementptr inbounds %TokenKind, %TokenKind* %t452, i32 0, i32 0
  store i32 3, i32* %t453
  %t454 = load i1, i1* %l23
  %t455 = getelementptr inbounds %TokenKind, %TokenKind* %t452, i32 0, i32 1
  %t456 = bitcast [1 x i8]* %t455 to i8*
  %t457 = bitcast i8* %t456 to i1*
  store i1 %t454, i1* %t457
  %t458 = load %TokenKind, %TokenKind* %t452
  %t459 = insertvalue %Token undef, i8* null, 0
  %t460 = load i8*, i8** %l22
  %t461 = insertvalue %Token %t459, i8* %t460, 1
  %t462 = load double, double* %l20
  %t463 = insertvalue %Token %t461, double %t462, 2
  %t464 = load double, double* %l21
  %t465 = insertvalue %Token %t463, double %t464, 3
  %t466 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t451, %Token %t465)
  store { %Token*, i64 }* %t466, { %Token*, i64 }** %l1
  br label %merge71
else70:
  %t467 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t468 = alloca %TokenKind
  %t469 = getelementptr inbounds %TokenKind, %TokenKind* %t468, i32 0, i32 0
  store i32 0, i32* %t469
  %t470 = load i8*, i8** %l22
  %t471 = getelementptr inbounds %TokenKind, %TokenKind* %t468, i32 0, i32 1
  %t472 = bitcast [8 x i8]* %t471 to i8*
  %t473 = bitcast i8* %t472 to i8**
  store i8* %t470, i8** %t473
  %t474 = load %TokenKind, %TokenKind* %t468
  %t475 = insertvalue %Token undef, i8* null, 0
  %t476 = load i8*, i8** %l22
  %t477 = insertvalue %Token %t475, i8* %t476, 1
  %t478 = load double, double* %l20
  %t479 = insertvalue %Token %t477, double %t478, 2
  %t480 = load double, double* %l21
  %t481 = insertvalue %Token %t479, double %t480, 3
  %t482 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t467, %Token %t481)
  store { %Token*, i64 }* %t482, { %Token*, i64 }** %l1
  br label %merge71
merge71:
  %t483 = phi { %Token*, i64 }* [ %t466, %then69 ], [ %t482, %else70 ]
  store { %Token*, i64 }* %t483, { %Token*, i64 }** %l1
  br label %loop.latch2
merge60:
  %t484 = load %LexerState, %LexerState* %l0
  %t485 = extractvalue %LexerState %t484, 2
  store double %t485, double* %l24
  %t486 = load %LexerState, %LexerState* %l0
  %t487 = extractvalue %LexerState %t486, 3
  store double %t487, double* %l25
  %t488 = load i8, i8* %l2
  store i8 %t488, i8* %l26
  %t489 = load %LexerState, %LexerState* %l0
  %t490 = call i8* @peek_next_char(%LexerState %t489)
  store i8* %t490, i8** %l27
  %t491 = load i8*, i8** %l27
  %s492 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.492, i32 0, i32 0
  %t493 = icmp ne i8* %t491, %s492
  %t494 = load %LexerState, %LexerState* %l0
  %t495 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t496 = load i8, i8* %l2
  %t497 = load double, double* %l24
  %t498 = load double, double* %l25
  %t499 = load i8, i8* %l26
  %t500 = load i8*, i8** %l27
  br i1 %t493, label %then72, label %merge73
then72:
  %t501 = load i8, i8* %l2
  %t502 = load i8*, i8** %l27
  %t503 = getelementptr i8, i8* %t502, i64 0
  %t504 = load i8, i8* %t503
  %t505 = add i8 %t501, %t504
  store i8 %t505, i8* %l28
  %t506 = load i8, i8* %l28
  %t507 = call i1 @is_two_char_symbol(i8* null)
  %t508 = load %LexerState, %LexerState* %l0
  %t509 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t510 = load i8, i8* %l2
  %t511 = load double, double* %l24
  %t512 = load double, double* %l25
  %t513 = load i8, i8* %l26
  %t514 = load i8*, i8** %l27
  %t515 = load i8, i8* %l28
  br i1 %t507, label %then74, label %merge75
then74:
  %t516 = load i8, i8* %l28
  store i8 %t516, i8* %l26
  %t517 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t518 = alloca %TokenKind
  %t519 = getelementptr inbounds %TokenKind, %TokenKind* %t518, i32 0, i32 0
  store i32 4, i32* %t519
  %t520 = load i8, i8* %l26
  %t521 = call noalias i8* @malloc(i64 1)
  %t522 = bitcast i8* %t521 to i8*
  store i8 %t520, i8* %t522
  %t523 = getelementptr inbounds %TokenKind, %TokenKind* %t518, i32 0, i32 1
  %t524 = bitcast [8 x i8]* %t523 to i8*
  %t525 = bitcast i8* %t524 to i8**
  store i8* %t521, i8** %t525
  %t526 = load %TokenKind, %TokenKind* %t518
  %t527 = insertvalue %Token undef, i8* null, 0
  %t528 = load i8, i8* %l26
  %t529 = insertvalue %Token %t527, i8* null, 1
  %t530 = load double, double* %l24
  %t531 = insertvalue %Token %t529, double %t530, 2
  %t532 = load double, double* %l25
  %t533 = insertvalue %Token %t531, double %t532, 3
  %t534 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t517, %Token %t533)
  store { %Token*, i64 }* %t534, { %Token*, i64 }** %l1
  br label %loop.latch2
merge75:
  br label %merge73
merge73:
  %t535 = phi i8 [ %t516, %then72 ], [ %t499, %loop.body1 ]
  %t536 = phi { %Token*, i64 }* [ %t534, %then72 ], [ %t495, %loop.body1 ]
  store i8 %t535, i8* %l26
  store { %Token*, i64 }* %t536, { %Token*, i64 }** %l1
  %t537 = load i8, i8* %l2
  %t538 = icmp eq i8 %t537, 10
  %t539 = load %LexerState, %LexerState* %l0
  %t540 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t541 = load i8, i8* %l2
  %t542 = load double, double* %l24
  %t543 = load double, double* %l25
  %t544 = load i8, i8* %l26
  %t545 = load i8*, i8** %l27
  br i1 %t538, label %then76, label %else77
then76:
  br label %merge78
else77:
  br label %merge78
merge78:
  %t546 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t547 = alloca %TokenKind
  %t548 = getelementptr inbounds %TokenKind, %TokenKind* %t547, i32 0, i32 0
  store i32 4, i32* %t548
  %t549 = load i8, i8* %l26
  %t550 = call noalias i8* @malloc(i64 1)
  %t551 = bitcast i8* %t550 to i8*
  store i8 %t549, i8* %t551
  %t552 = getelementptr inbounds %TokenKind, %TokenKind* %t547, i32 0, i32 1
  %t553 = bitcast [8 x i8]* %t552 to i8*
  %t554 = bitcast i8* %t553 to i8**
  store i8* %t550, i8** %t554
  %t555 = load %TokenKind, %TokenKind* %t547
  %t556 = insertvalue %Token undef, i8* null, 0
  %t557 = load i8, i8* %l26
  %t558 = insertvalue %Token %t556, i8* null, 1
  %t559 = load double, double* %l24
  %t560 = insertvalue %Token %t558, double %t559, 2
  %t561 = load double, double* %l25
  %t562 = insertvalue %Token %t560, double %t561, 3
  %t563 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t546, %Token %t562)
  store { %Token*, i64 }* %t563, { %Token*, i64 }** %l1
  br label %loop.latch2
loop.latch2:
  %t564 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br label %loop.header0
afterloop3:
  %t566 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t567 = load %LexerState, %LexerState* %l0
  %t568 = extractvalue %LexerState %t567, 2
  %t569 = load %LexerState, %LexerState* %l0
  %t570 = extractvalue %LexerState %t569, 3
  %t571 = call double @eof_token(double %t568, double %t570)
  %t572 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t566, %Token zeroinitializer)
  store { %Token*, i64 }* %t572, { %Token*, i64 }** %l1
  %t573 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  ret { %Token*, i64 }* %t573
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
  %t12 = fptosi double %t11 to i64
  %t13 = getelementptr i8, i8* %t10, i64 %t12
  %t14 = load i8, i8* %t13
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
