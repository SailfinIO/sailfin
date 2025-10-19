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
  %t557 = phi { %Token*, i64 }* [ %t13, %entry ], [ %t556, %loop.latch2 ]
  store { %Token*, i64 }* %t557, { %Token*, i64 }** %l1
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
  %t27 = getelementptr i8, i8* %t24, i64 %t26
  %t28 = load i8, i8* %t27
  store i8 %t28, i8* %l2
  %t29 = load i8, i8* %l2
  %t30 = call i1 @is_whitespace(i8* null)
  %t31 = load %LexerState, %LexerState* %l0
  %t32 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t33 = load i8, i8* %l2
  br i1 %t30, label %then6, label %merge7
then6:
  %t34 = load %LexerState, %LexerState* %l0
  %t35 = extractvalue %LexerState %t34, 1
  store double %t35, double* %l3
  %t36 = load %LexerState, %LexerState* %l0
  %t37 = extractvalue %LexerState %t36, 2
  store double %t37, double* %l4
  %t38 = load %LexerState, %LexerState* %l0
  %t39 = extractvalue %LexerState %t38, 3
  store double %t39, double* %l5
  %t40 = load %LexerState, %LexerState* %l0
  %t41 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t42 = load i8, i8* %l2
  %t43 = load double, double* %l3
  %t44 = load double, double* %l4
  %t45 = load double, double* %l5
  br label %loop.header8
loop.header8:
  br label %loop.body9
loop.body9:
  %t46 = load %LexerState, %LexerState* %l0
  %t47 = extractvalue %LexerState %t46, 1
  %t48 = load %LexerState, %LexerState* %l0
  %t49 = extractvalue %LexerState %t48, 0
  %t50 = call i64 @sailfin_runtime_string_length(i8* %t49)
  %t51 = sitofp i64 %t50 to double
  %t52 = fcmp oge double %t47, %t51
  %t53 = load %LexerState, %LexerState* %l0
  %t54 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t55 = load i8, i8* %l2
  %t56 = load double, double* %l3
  %t57 = load double, double* %l4
  %t58 = load double, double* %l5
  br i1 %t52, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t59 = load %LexerState, %LexerState* %l0
  %t60 = extractvalue %LexerState %t59, 0
  %t61 = load %LexerState, %LexerState* %l0
  %t62 = extractvalue %LexerState %t61, 1
  %t63 = getelementptr i8, i8* %t60, i64 %t62
  %t64 = load i8, i8* %t63
  %t65 = call i1 @is_whitespace(i8* null)
  %t66 = xor i1 %t65, 1
  %t67 = load %LexerState, %LexerState* %l0
  %t68 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t69 = load i8, i8* %l2
  %t70 = load double, double* %l3
  %t71 = load double, double* %l4
  %t72 = load double, double* %l5
  br i1 %t66, label %then14, label %merge15
then14:
  br label %afterloop11
merge15:
  %t73 = load %LexerState, %LexerState* %l0
  %t74 = extractvalue %LexerState %t73, 0
  %t75 = load %LexerState, %LexerState* %l0
  %t76 = extractvalue %LexerState %t75, 1
  %t77 = getelementptr i8, i8* %t74, i64 %t76
  %t78 = load i8, i8* %t77
  %t79 = icmp eq i8 %t78, 10
  %t80 = load %LexerState, %LexerState* %l0
  %t81 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t82 = load i8, i8* %l2
  %t83 = load double, double* %l3
  %t84 = load double, double* %l4
  %t85 = load double, double* %l5
  br i1 %t79, label %then16, label %else17
then16:
  br label %merge18
else17:
  br label %merge18
merge18:
  br label %loop.latch10
loop.latch10:
  br label %loop.header8
afterloop11:
  %t86 = load %LexerState, %LexerState* %l0
  %t87 = extractvalue %LexerState %t86, 0
  %t88 = load double, double* %l3
  %t89 = load %LexerState, %LexerState* %l0
  %t90 = extractvalue %LexerState %t89, 1
  %t91 = call i8* @slice(i8* %t87, double %t88, double %t90)
  store i8* %t91, i8** %l6
  %t92 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t93 = insertvalue %TokenKind undef, i32 5, 0
  %t94 = insertvalue %Token undef, i8* null, 0
  %t95 = load i8*, i8** %l6
  %t96 = insertvalue %Token %t94, i8* %t95, 1
  %t97 = load double, double* %l4
  %t98 = insertvalue %Token %t96, double %t97, 2
  %t99 = load double, double* %l5
  %t100 = insertvalue %Token %t98, double %t99, 3
  %t101 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t92, %Token %t100)
  store { %Token*, i64 }* %t101, { %Token*, i64 }** %l1
  br label %loop.latch2
merge7:
  %t102 = load i8, i8* %l2
  %t103 = load i8, i8* %l2
  %t104 = call i1 @is_double_quote(i8* null)
  %t105 = load %LexerState, %LexerState* %l0
  %t106 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t107 = load i8, i8* %l2
  br i1 %t104, label %then19, label %merge20
then19:
  %t108 = load %LexerState, %LexerState* %l0
  %t109 = extractvalue %LexerState %t108, 1
  store double %t109, double* %l7
  %t110 = load %LexerState, %LexerState* %l0
  %t111 = extractvalue %LexerState %t110, 2
  store double %t111, double* %l8
  %t112 = load %LexerState, %LexerState* %l0
  %t113 = extractvalue %LexerState %t112, 3
  store double %t113, double* %l9
  %s114 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.114, i32 0, i32 0
  store i8* %s114, i8** %l10
  store i1 0, i1* %l11
  %t115 = load %LexerState, %LexerState* %l0
  %t116 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t117 = load i8, i8* %l2
  %t118 = load double, double* %l7
  %t119 = load double, double* %l8
  %t120 = load double, double* %l9
  %t121 = load i8*, i8** %l10
  %t122 = load i1, i1* %l11
  br label %loop.header21
loop.header21:
  %t208 = phi i1 [ %t122, %then19 ], [ %t206, %loop.latch23 ]
  %t209 = phi i8* [ %t121, %then19 ], [ %t207, %loop.latch23 ]
  store i1 %t208, i1* %l11
  store i8* %t209, i8** %l10
  br label %loop.body22
loop.body22:
  %t123 = load %LexerState, %LexerState* %l0
  %t124 = extractvalue %LexerState %t123, 1
  %t125 = load %LexerState, %LexerState* %l0
  %t126 = extractvalue %LexerState %t125, 0
  %t127 = call i64 @sailfin_runtime_string_length(i8* %t126)
  %t128 = sitofp i64 %t127 to double
  %t129 = fcmp oge double %t124, %t128
  %t130 = load %LexerState, %LexerState* %l0
  %t131 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t132 = load i8, i8* %l2
  %t133 = load double, double* %l7
  %t134 = load double, double* %l8
  %t135 = load double, double* %l9
  %t136 = load i8*, i8** %l10
  %t137 = load i1, i1* %l11
  br i1 %t129, label %then25, label %merge26
then25:
  br label %afterloop24
merge26:
  %t138 = load %LexerState, %LexerState* %l0
  %t139 = extractvalue %LexerState %t138, 0
  %t140 = load %LexerState, %LexerState* %l0
  %t141 = extractvalue %LexerState %t140, 1
  %t142 = getelementptr i8, i8* %t139, i64 %t141
  %t143 = load i8, i8* %t142
  store i8 %t143, i8* %l12
  %t145 = load i1, i1* %l11
  br label %logical_and_entry_144

logical_and_entry_144:
  br i1 %t145, label %logical_and_right_144, label %logical_and_merge_144

logical_and_right_144:
  %t146 = load i8, i8* %l12
  %t147 = call i1 @is_double_quote(i8* null)
  br label %logical_and_right_end_144

logical_and_right_end_144:
  br label %logical_and_merge_144

logical_and_merge_144:
  %t148 = phi i1 [ false, %logical_and_entry_144 ], [ %t147, %logical_and_right_end_144 ]
  %t149 = xor i1 %t148, 1
  %t150 = load %LexerState, %LexerState* %l0
  %t151 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t152 = load i8, i8* %l2
  %t153 = load double, double* %l7
  %t154 = load double, double* %l8
  %t155 = load double, double* %l9
  %t156 = load i8*, i8** %l10
  %t157 = load i1, i1* %l11
  %t158 = load i8, i8* %l12
  br i1 %t149, label %then27, label %merge28
then27:
  br label %afterloop24
merge28:
  %t160 = load i1, i1* %l11
  br label %logical_and_entry_159

logical_and_entry_159:
  br i1 %t160, label %logical_and_right_159, label %logical_and_merge_159

logical_and_right_159:
  %t161 = load i8, i8* %l12
  %t162 = call i1 @is_backslash(i8* null)
  br label %logical_and_right_end_159

logical_and_right_end_159:
  br label %logical_and_merge_159

logical_and_merge_159:
  %t163 = phi i1 [ false, %logical_and_entry_159 ], [ %t162, %logical_and_right_end_159 ]
  %t164 = xor i1 %t163, 1
  %t165 = load %LexerState, %LexerState* %l0
  %t166 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t167 = load i8, i8* %l2
  %t168 = load double, double* %l7
  %t169 = load double, double* %l8
  %t170 = load double, double* %l9
  %t171 = load i8*, i8** %l10
  %t172 = load i1, i1* %l11
  %t173 = load i8, i8* %l12
  br i1 %t164, label %then29, label %merge30
then29:
  store i1 1, i1* %l11
  br label %loop.latch23
merge30:
  %t174 = load i1, i1* %l11
  %t175 = load %LexerState, %LexerState* %l0
  %t176 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t177 = load i8, i8* %l2
  %t178 = load double, double* %l7
  %t179 = load double, double* %l8
  %t180 = load double, double* %l9
  %t181 = load i8*, i8** %l10
  %t182 = load i1, i1* %l11
  %t183 = load i8, i8* %l12
  br i1 %t174, label %then31, label %else32
then31:
  %t184 = load i8*, i8** %l10
  %t185 = load i8, i8* %l12
  %t186 = call i8* @interpret_escape(i8* null)
  %t187 = add i8* %t184, %t186
  store i8* %t187, i8** %l10
  store i1 0, i1* %l11
  br label %merge33
else32:
  %t188 = load i8*, i8** %l10
  %t189 = load i8, i8* %l12
  %t190 = getelementptr i8, i8* %t188, i64 0
  %t191 = load i8, i8* %t190
  %t192 = add i8 %t191, %t189
  store i8* null, i8** %l10
  br label %merge33
merge33:
  %t193 = phi i8* [ %t187, %then31 ], [ null, %else32 ]
  %t194 = phi i1 [ 0, %then31 ], [ %t182, %else32 ]
  store i8* %t193, i8** %l10
  store i1 %t194, i1* %l11
  %t195 = load i8, i8* %l12
  %t196 = icmp eq i8 %t195, 10
  %t197 = load %LexerState, %LexerState* %l0
  %t198 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t199 = load i8, i8* %l2
  %t200 = load double, double* %l7
  %t201 = load double, double* %l8
  %t202 = load double, double* %l9
  %t203 = load i8*, i8** %l10
  %t204 = load i1, i1* %l11
  %t205 = load i8, i8* %l12
  br i1 %t196, label %then34, label %else35
then34:
  br label %merge36
else35:
  br label %merge36
merge36:
  br label %loop.latch23
loop.latch23:
  %t206 = load i1, i1* %l11
  %t207 = load i8*, i8** %l10
  br label %loop.header21
afterloop24:
  %t210 = load %LexerState, %LexerState* %l0
  %t211 = extractvalue %LexerState %t210, 0
  %t212 = load double, double* %l7
  %t213 = load %LexerState, %LexerState* %l0
  %t214 = extractvalue %LexerState %t213, 1
  %t215 = call i8* @slice(i8* %t211, double %t212, double %t214)
  store i8* %t215, i8** %l13
  %t216 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t217 = alloca %TokenKind
  %t218 = getelementptr inbounds %TokenKind, %TokenKind* %t217, i32 0, i32 0
  store i32 2, i32* %t218
  %t219 = load i8*, i8** %l10
  %t220 = getelementptr inbounds %TokenKind, %TokenKind* %t217, i32 0, i32 1
  %t221 = bitcast [8 x i8]* %t220 to i8*
  %t222 = bitcast i8* %t221 to i8**
  store i8* %t219, i8** %t222
  %t223 = load %TokenKind, %TokenKind* %t217
  %t224 = insertvalue %Token undef, i8* null, 0
  %t225 = load i8*, i8** %l13
  %t226 = insertvalue %Token %t224, i8* %t225, 1
  %t227 = load double, double* %l8
  %t228 = insertvalue %Token %t226, double %t227, 2
  %t229 = load double, double* %l9
  %t230 = insertvalue %Token %t228, double %t229, 3
  %t231 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t216, %Token %t230)
  store { %Token*, i64 }* %t231, { %Token*, i64 }** %l1
  br label %loop.latch2
merge20:
  %t232 = load i8, i8* %l2
  %t233 = call i1 @is_digit(i8* null)
  %t234 = load %LexerState, %LexerState* %l0
  %t235 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t236 = load i8, i8* %l2
  br i1 %t233, label %then37, label %merge38
then37:
  %t237 = load %LexerState, %LexerState* %l0
  %t238 = extractvalue %LexerState %t237, 1
  store double %t238, double* %l14
  %t239 = load %LexerState, %LexerState* %l0
  %t240 = extractvalue %LexerState %t239, 2
  store double %t240, double* %l15
  %t241 = load %LexerState, %LexerState* %l0
  %t242 = extractvalue %LexerState %t241, 3
  store double %t242, double* %l16
  %t243 = load %LexerState, %LexerState* %l0
  %t244 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t245 = load i8, i8* %l2
  %t246 = load double, double* %l14
  %t247 = load double, double* %l15
  %t248 = load double, double* %l16
  br label %loop.header39
loop.header39:
  br label %loop.body40
loop.body40:
  %t249 = load %LexerState, %LexerState* %l0
  %t250 = extractvalue %LexerState %t249, 1
  %t251 = load %LexerState, %LexerState* %l0
  %t252 = extractvalue %LexerState %t251, 0
  %t253 = call i64 @sailfin_runtime_string_length(i8* %t252)
  %t254 = sitofp i64 %t253 to double
  %t255 = fcmp oge double %t250, %t254
  %t256 = load %LexerState, %LexerState* %l0
  %t257 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t258 = load i8, i8* %l2
  %t259 = load double, double* %l14
  %t260 = load double, double* %l15
  %t261 = load double, double* %l16
  br i1 %t255, label %then43, label %merge44
then43:
  br label %afterloop42
merge44:
  %t262 = load %LexerState, %LexerState* %l0
  %t263 = extractvalue %LexerState %t262, 0
  %t264 = load %LexerState, %LexerState* %l0
  %t265 = extractvalue %LexerState %t264, 1
  %t266 = getelementptr i8, i8* %t263, i64 %t265
  %t267 = load i8, i8* %t266
  %t268 = call i1 @is_digit(i8* null)
  %t269 = xor i1 %t268, 1
  %t270 = load %LexerState, %LexerState* %l0
  %t271 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t272 = load i8, i8* %l2
  %t273 = load double, double* %l14
  %t274 = load double, double* %l15
  %t275 = load double, double* %l16
  br i1 %t269, label %then45, label %merge46
then45:
  br label %afterloop42
merge46:
  br label %loop.latch41
loop.latch41:
  br label %loop.header39
afterloop42:
  %t277 = load %LexerState, %LexerState* %l0
  %t278 = extractvalue %LexerState %t277, 1
  %t279 = load %LexerState, %LexerState* %l0
  %t280 = extractvalue %LexerState %t279, 0
  %t281 = call i64 @sailfin_runtime_string_length(i8* %t280)
  %t282 = sitofp i64 %t281 to double
  %t283 = fcmp olt double %t278, %t282
  br label %logical_and_entry_276

logical_and_entry_276:
  br i1 %t283, label %logical_and_right_276, label %logical_and_merge_276

logical_and_right_276:
  %t284 = load %LexerState, %LexerState* %l0
  %t285 = extractvalue %LexerState %t284, 0
  %t286 = load %LexerState, %LexerState* %l0
  %t287 = extractvalue %LexerState %t286, 1
  %t288 = getelementptr i8, i8* %t285, i64 %t287
  %t289 = load i8, i8* %t288
  %t290 = icmp eq i8 %t289, 46
  br label %logical_and_right_end_276

logical_and_right_end_276:
  br label %logical_and_merge_276

logical_and_merge_276:
  %t291 = phi i1 [ false, %logical_and_entry_276 ], [ %t290, %logical_and_right_end_276 ]
  %t292 = load %LexerState, %LexerState* %l0
  %t293 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t294 = load i8, i8* %l2
  %t295 = load double, double* %l14
  %t296 = load double, double* %l15
  %t297 = load double, double* %l16
  br i1 %t291, label %then47, label %merge48
then47:
  %t299 = load %LexerState, %LexerState* %l0
  %t300 = extractvalue %LexerState %t299, 1
  %t301 = sitofp i64 1 to double
  %t302 = fadd double %t300, %t301
  %t303 = load %LexerState, %LexerState* %l0
  %t304 = extractvalue %LexerState %t303, 0
  %t305 = call i64 @sailfin_runtime_string_length(i8* %t304)
  %t306 = sitofp i64 %t305 to double
  %t307 = fcmp olt double %t302, %t306
  br label %logical_and_entry_298

logical_and_entry_298:
  br i1 %t307, label %logical_and_right_298, label %logical_and_merge_298

logical_and_right_298:
  store double 0.0, double* %l17
  %t308 = load double, double* %l17
  %t309 = fcmp one double %t308, 0.0
  %t310 = load %LexerState, %LexerState* %l0
  %t311 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t312 = load i8, i8* %l2
  %t313 = load double, double* %l14
  %t314 = load double, double* %l15
  %t315 = load double, double* %l16
  %t316 = load double, double* %l17
  br i1 %t309, label %then49, label %merge50
then49:
  %t317 = load %LexerState, %LexerState* %l0
  %t318 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t319 = load i8, i8* %l2
  %t320 = load double, double* %l14
  %t321 = load double, double* %l15
  %t322 = load double, double* %l16
  %t323 = load double, double* %l17
  br label %loop.header51
loop.header51:
  br label %loop.body52
loop.body52:
  %t324 = load %LexerState, %LexerState* %l0
  %t325 = extractvalue %LexerState %t324, 1
  %t326 = load %LexerState, %LexerState* %l0
  %t327 = extractvalue %LexerState %t326, 0
  %t328 = call i64 @sailfin_runtime_string_length(i8* %t327)
  %t329 = sitofp i64 %t328 to double
  %t330 = fcmp oge double %t325, %t329
  %t331 = load %LexerState, %LexerState* %l0
  %t332 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t333 = load i8, i8* %l2
  %t334 = load double, double* %l14
  %t335 = load double, double* %l15
  %t336 = load double, double* %l16
  %t337 = load double, double* %l17
  br i1 %t330, label %then55, label %merge56
then55:
  br label %afterloop54
merge56:
  %t338 = load %LexerState, %LexerState* %l0
  %t339 = extractvalue %LexerState %t338, 0
  %t340 = load %LexerState, %LexerState* %l0
  %t341 = extractvalue %LexerState %t340, 1
  %t342 = getelementptr i8, i8* %t339, i64 %t341
  %t343 = load i8, i8* %t342
  %t344 = call i1 @is_digit(i8* null)
  %t345 = xor i1 %t344, 1
  %t346 = load %LexerState, %LexerState* %l0
  %t347 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t348 = load i8, i8* %l2
  %t349 = load double, double* %l14
  %t350 = load double, double* %l15
  %t351 = load double, double* %l16
  %t352 = load double, double* %l17
  br i1 %t345, label %then57, label %merge58
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
  %t353 = load %LexerState, %LexerState* %l0
  %t354 = extractvalue %LexerState %t353, 0
  %t355 = load double, double* %l14
  %t356 = load %LexerState, %LexerState* %l0
  %t357 = extractvalue %LexerState %t356, 1
  %t358 = call i8* @slice(i8* %t354, double %t355, double %t357)
  store i8* %t358, i8** %l18
  %t359 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t360 = alloca %TokenKind
  %t361 = getelementptr inbounds %TokenKind, %TokenKind* %t360, i32 0, i32 0
  store i32 1, i32* %t361
  %t362 = load i8*, i8** %l18
  %t363 = getelementptr inbounds %TokenKind, %TokenKind* %t360, i32 0, i32 1
  %t364 = bitcast [8 x i8]* %t363 to i8*
  %t365 = bitcast i8* %t364 to i8**
  store i8* %t362, i8** %t365
  %t366 = load %TokenKind, %TokenKind* %t360
  %t367 = insertvalue %Token undef, i8* null, 0
  %t368 = load i8*, i8** %l18
  %t369 = insertvalue %Token %t367, i8* %t368, 1
  %t370 = load double, double* %l15
  %t371 = insertvalue %Token %t369, double %t370, 2
  %t372 = load double, double* %l16
  %t373 = insertvalue %Token %t371, double %t372, 3
  %t374 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t359, %Token %t373)
  store { %Token*, i64 }* %t374, { %Token*, i64 }** %l1
  br label %loop.latch2
merge38:
  %t375 = load i8, i8* %l2
  %t376 = call i1 @is_identifier_start(i8* null)
  %t377 = load %LexerState, %LexerState* %l0
  %t378 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t379 = load i8, i8* %l2
  br i1 %t376, label %then59, label %merge60
then59:
  %t380 = load %LexerState, %LexerState* %l0
  %t381 = extractvalue %LexerState %t380, 1
  store double %t381, double* %l19
  %t382 = load %LexerState, %LexerState* %l0
  %t383 = extractvalue %LexerState %t382, 2
  store double %t383, double* %l20
  %t384 = load %LexerState, %LexerState* %l0
  %t385 = extractvalue %LexerState %t384, 3
  store double %t385, double* %l21
  %t386 = load %LexerState, %LexerState* %l0
  %t387 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t388 = load i8, i8* %l2
  %t389 = load double, double* %l19
  %t390 = load double, double* %l20
  %t391 = load double, double* %l21
  br label %loop.header61
loop.header61:
  br label %loop.body62
loop.body62:
  %t392 = load %LexerState, %LexerState* %l0
  %t393 = extractvalue %LexerState %t392, 1
  %t394 = load %LexerState, %LexerState* %l0
  %t395 = extractvalue %LexerState %t394, 0
  %t396 = call i64 @sailfin_runtime_string_length(i8* %t395)
  %t397 = sitofp i64 %t396 to double
  %t398 = fcmp oge double %t393, %t397
  %t399 = load %LexerState, %LexerState* %l0
  %t400 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t401 = load i8, i8* %l2
  %t402 = load double, double* %l19
  %t403 = load double, double* %l20
  %t404 = load double, double* %l21
  br i1 %t398, label %then65, label %merge66
then65:
  br label %afterloop64
merge66:
  %t405 = load %LexerState, %LexerState* %l0
  %t406 = extractvalue %LexerState %t405, 0
  %t407 = load %LexerState, %LexerState* %l0
  %t408 = extractvalue %LexerState %t407, 1
  %t409 = getelementptr i8, i8* %t406, i64 %t408
  %t410 = load i8, i8* %t409
  %t411 = call i1 @is_identifier_part(i8* null)
  %t412 = xor i1 %t411, 1
  %t413 = load %LexerState, %LexerState* %l0
  %t414 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t415 = load i8, i8* %l2
  %t416 = load double, double* %l19
  %t417 = load double, double* %l20
  %t418 = load double, double* %l21
  br i1 %t412, label %then67, label %merge68
then67:
  br label %afterloop64
merge68:
  br label %loop.latch63
loop.latch63:
  br label %loop.header61
afterloop64:
  %t419 = load %LexerState, %LexerState* %l0
  %t420 = extractvalue %LexerState %t419, 0
  %t421 = load double, double* %l19
  %t422 = load %LexerState, %LexerState* %l0
  %t423 = extractvalue %LexerState %t422, 1
  %t424 = call i8* @slice(i8* %t420, double %t421, double %t423)
  store i8* %t424, i8** %l22
  %t426 = load i8*, i8** %l22
  %s427 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.427, i32 0, i32 0
  %t428 = icmp eq i8* %t426, %s427
  br label %logical_or_entry_425

logical_or_entry_425:
  br i1 %t428, label %logical_or_merge_425, label %logical_or_right_425

logical_or_right_425:
  %t429 = load i8*, i8** %l22
  %s430 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.430, i32 0, i32 0
  %t431 = icmp eq i8* %t429, %s430
  br label %logical_or_right_end_425

logical_or_right_end_425:
  br label %logical_or_merge_425

logical_or_merge_425:
  %t432 = phi i1 [ true, %logical_or_entry_425 ], [ %t431, %logical_or_right_end_425 ]
  %t433 = load %LexerState, %LexerState* %l0
  %t434 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t435 = load i8, i8* %l2
  %t436 = load double, double* %l19
  %t437 = load double, double* %l20
  %t438 = load double, double* %l21
  %t439 = load i8*, i8** %l22
  br i1 %t432, label %then69, label %else70
then69:
  %t440 = load i8*, i8** %l22
  %s441 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.441, i32 0, i32 0
  %t442 = icmp eq i8* %t440, %s441
  store i1 %t442, i1* %l23
  %t443 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t444 = alloca %TokenKind
  %t445 = getelementptr inbounds %TokenKind, %TokenKind* %t444, i32 0, i32 0
  store i32 3, i32* %t445
  %t446 = load i1, i1* %l23
  %t447 = getelementptr inbounds %TokenKind, %TokenKind* %t444, i32 0, i32 1
  %t448 = bitcast [1 x i8]* %t447 to i8*
  %t449 = bitcast i8* %t448 to i1*
  store i1 %t446, i1* %t449
  %t450 = load %TokenKind, %TokenKind* %t444
  %t451 = insertvalue %Token undef, i8* null, 0
  %t452 = load i8*, i8** %l22
  %t453 = insertvalue %Token %t451, i8* %t452, 1
  %t454 = load double, double* %l20
  %t455 = insertvalue %Token %t453, double %t454, 2
  %t456 = load double, double* %l21
  %t457 = insertvalue %Token %t455, double %t456, 3
  %t458 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t443, %Token %t457)
  store { %Token*, i64 }* %t458, { %Token*, i64 }** %l1
  br label %merge71
else70:
  %t459 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t460 = alloca %TokenKind
  %t461 = getelementptr inbounds %TokenKind, %TokenKind* %t460, i32 0, i32 0
  store i32 0, i32* %t461
  %t462 = load i8*, i8** %l22
  %t463 = getelementptr inbounds %TokenKind, %TokenKind* %t460, i32 0, i32 1
  %t464 = bitcast [8 x i8]* %t463 to i8*
  %t465 = bitcast i8* %t464 to i8**
  store i8* %t462, i8** %t465
  %t466 = load %TokenKind, %TokenKind* %t460
  %t467 = insertvalue %Token undef, i8* null, 0
  %t468 = load i8*, i8** %l22
  %t469 = insertvalue %Token %t467, i8* %t468, 1
  %t470 = load double, double* %l20
  %t471 = insertvalue %Token %t469, double %t470, 2
  %t472 = load double, double* %l21
  %t473 = insertvalue %Token %t471, double %t472, 3
  %t474 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t459, %Token %t473)
  store { %Token*, i64 }* %t474, { %Token*, i64 }** %l1
  br label %merge71
merge71:
  %t475 = phi { %Token*, i64 }* [ %t458, %then69 ], [ %t474, %else70 ]
  store { %Token*, i64 }* %t475, { %Token*, i64 }** %l1
  br label %loop.latch2
merge60:
  %t476 = load %LexerState, %LexerState* %l0
  %t477 = extractvalue %LexerState %t476, 2
  store double %t477, double* %l24
  %t478 = load %LexerState, %LexerState* %l0
  %t479 = extractvalue %LexerState %t478, 3
  store double %t479, double* %l25
  %t480 = load i8, i8* %l2
  store i8 %t480, i8* %l26
  %t481 = load %LexerState, %LexerState* %l0
  %t482 = call i8* @peek_next_char(%LexerState %t481)
  store i8* %t482, i8** %l27
  %t483 = load i8*, i8** %l27
  %s484 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.484, i32 0, i32 0
  %t485 = icmp ne i8* %t483, %s484
  %t486 = load %LexerState, %LexerState* %l0
  %t487 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t488 = load i8, i8* %l2
  %t489 = load double, double* %l24
  %t490 = load double, double* %l25
  %t491 = load i8, i8* %l26
  %t492 = load i8*, i8** %l27
  br i1 %t485, label %then72, label %merge73
then72:
  %t493 = load i8, i8* %l2
  %t494 = load i8*, i8** %l27
  %t495 = getelementptr i8, i8* %t494, i64 0
  %t496 = load i8, i8* %t495
  %t497 = add i8 %t493, %t496
  store i8 %t497, i8* %l28
  %t498 = load i8, i8* %l28
  %t499 = call i1 @is_two_char_symbol(i8* null)
  %t500 = load %LexerState, %LexerState* %l0
  %t501 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t502 = load i8, i8* %l2
  %t503 = load double, double* %l24
  %t504 = load double, double* %l25
  %t505 = load i8, i8* %l26
  %t506 = load i8*, i8** %l27
  %t507 = load i8, i8* %l28
  br i1 %t499, label %then74, label %merge75
then74:
  %t508 = load i8, i8* %l28
  store i8 %t508, i8* %l26
  %t509 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t510 = alloca %TokenKind
  %t511 = getelementptr inbounds %TokenKind, %TokenKind* %t510, i32 0, i32 0
  store i32 4, i32* %t511
  %t512 = load i8, i8* %l26
  %t513 = call noalias i8* @malloc(i64 1)
  %t514 = bitcast i8* %t513 to i8*
  store i8 %t512, i8* %t514
  %t515 = getelementptr inbounds %TokenKind, %TokenKind* %t510, i32 0, i32 1
  %t516 = bitcast [8 x i8]* %t515 to i8*
  %t517 = bitcast i8* %t516 to i8**
  store i8* %t513, i8** %t517
  %t518 = load %TokenKind, %TokenKind* %t510
  %t519 = insertvalue %Token undef, i8* null, 0
  %t520 = load i8, i8* %l26
  %t521 = insertvalue %Token %t519, i8* null, 1
  %t522 = load double, double* %l24
  %t523 = insertvalue %Token %t521, double %t522, 2
  %t524 = load double, double* %l25
  %t525 = insertvalue %Token %t523, double %t524, 3
  %t526 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t509, %Token %t525)
  store { %Token*, i64 }* %t526, { %Token*, i64 }** %l1
  br label %loop.latch2
merge75:
  br label %merge73
merge73:
  %t527 = phi i8 [ %t508, %then72 ], [ %t491, %loop.body1 ]
  %t528 = phi { %Token*, i64 }* [ %t526, %then72 ], [ %t487, %loop.body1 ]
  store i8 %t527, i8* %l26
  store { %Token*, i64 }* %t528, { %Token*, i64 }** %l1
  %t529 = load i8, i8* %l2
  %t530 = icmp eq i8 %t529, 10
  %t531 = load %LexerState, %LexerState* %l0
  %t532 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t533 = load i8, i8* %l2
  %t534 = load double, double* %l24
  %t535 = load double, double* %l25
  %t536 = load i8, i8* %l26
  %t537 = load i8*, i8** %l27
  br i1 %t530, label %then76, label %else77
then76:
  br label %merge78
else77:
  br label %merge78
merge78:
  %t538 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t539 = alloca %TokenKind
  %t540 = getelementptr inbounds %TokenKind, %TokenKind* %t539, i32 0, i32 0
  store i32 4, i32* %t540
  %t541 = load i8, i8* %l26
  %t542 = call noalias i8* @malloc(i64 1)
  %t543 = bitcast i8* %t542 to i8*
  store i8 %t541, i8* %t543
  %t544 = getelementptr inbounds %TokenKind, %TokenKind* %t539, i32 0, i32 1
  %t545 = bitcast [8 x i8]* %t544 to i8*
  %t546 = bitcast i8* %t545 to i8**
  store i8* %t542, i8** %t546
  %t547 = load %TokenKind, %TokenKind* %t539
  %t548 = insertvalue %Token undef, i8* null, 0
  %t549 = load i8, i8* %l26
  %t550 = insertvalue %Token %t548, i8* null, 1
  %t551 = load double, double* %l24
  %t552 = insertvalue %Token %t550, double %t551, 2
  %t553 = load double, double* %l25
  %t554 = insertvalue %Token %t552, double %t553, 3
  %t555 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t538, %Token %t554)
  store { %Token*, i64 }* %t555, { %Token*, i64 }** %l1
  br label %loop.latch2
loop.latch2:
  %t556 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br label %loop.header0
afterloop3:
  %t558 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t559 = load %LexerState, %LexerState* %l0
  %t560 = extractvalue %LexerState %t559, 2
  %t561 = load %LexerState, %LexerState* %l0
  %t562 = extractvalue %LexerState %t561, 3
  %t563 = call double @eof_token(double %t560, double %t562)
  %t564 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t558, %Token zeroinitializer)
  store { %Token*, i64 }* %t564, { %Token*, i64 }** %l1
  %t565 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  ret { %Token*, i64 }* %t565
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
