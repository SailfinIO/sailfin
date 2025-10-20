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
  %t625 = phi { %Token*, i64 }* [ %t13, %entry ], [ %t624, %loop.latch2 ]
  store { %Token*, i64 }* %t625, { %Token*, i64 }** %l1
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
  %t31 = alloca [2 x i8], align 1
  %t32 = getelementptr [2 x i8], [2 x i8]* %t31, i32 0, i32 0
  store i8 %t30, i8* %t32
  %t33 = getelementptr [2 x i8], [2 x i8]* %t31, i32 0, i32 1
  store i8 0, i8* %t33
  %t34 = getelementptr [2 x i8], [2 x i8]* %t31, i32 0, i32 0
  %t35 = call i1 @is_whitespace(i8* %t34)
  %t36 = load %LexerState, %LexerState* %l0
  %t37 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t38 = load i8, i8* %l2
  br i1 %t35, label %then6, label %merge7
then6:
  %t39 = load %LexerState, %LexerState* %l0
  %t40 = extractvalue %LexerState %t39, 1
  store double %t40, double* %l3
  %t41 = load %LexerState, %LexerState* %l0
  %t42 = extractvalue %LexerState %t41, 2
  store double %t42, double* %l4
  %t43 = load %LexerState, %LexerState* %l0
  %t44 = extractvalue %LexerState %t43, 3
  store double %t44, double* %l5
  %t45 = load %LexerState, %LexerState* %l0
  %t46 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t47 = load i8, i8* %l2
  %t48 = load double, double* %l3
  %t49 = load double, double* %l4
  %t50 = load double, double* %l5
  br label %loop.header8
loop.header8:
  br label %loop.body9
loop.body9:
  %t51 = load %LexerState, %LexerState* %l0
  %t52 = extractvalue %LexerState %t51, 1
  %t53 = load %LexerState, %LexerState* %l0
  %t54 = extractvalue %LexerState %t53, 0
  %t55 = call i64 @sailfin_runtime_string_length(i8* %t54)
  %t56 = sitofp i64 %t55 to double
  %t57 = fcmp oge double %t52, %t56
  %t58 = load %LexerState, %LexerState* %l0
  %t59 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t60 = load i8, i8* %l2
  %t61 = load double, double* %l3
  %t62 = load double, double* %l4
  %t63 = load double, double* %l5
  br i1 %t57, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t64 = load %LexerState, %LexerState* %l0
  %t65 = extractvalue %LexerState %t64, 0
  %t66 = load %LexerState, %LexerState* %l0
  %t67 = extractvalue %LexerState %t66, 1
  %t68 = fptosi double %t67 to i64
  %t69 = getelementptr i8, i8* %t65, i64 %t68
  %t70 = load i8, i8* %t69
  %t71 = alloca [2 x i8], align 1
  %t72 = getelementptr [2 x i8], [2 x i8]* %t71, i32 0, i32 0
  store i8 %t70, i8* %t72
  %t73 = getelementptr [2 x i8], [2 x i8]* %t71, i32 0, i32 1
  store i8 0, i8* %t73
  %t74 = getelementptr [2 x i8], [2 x i8]* %t71, i32 0, i32 0
  %t75 = call i1 @is_whitespace(i8* %t74)
  %t76 = xor i1 %t75, 1
  %t77 = load %LexerState, %LexerState* %l0
  %t78 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t79 = load i8, i8* %l2
  %t80 = load double, double* %l3
  %t81 = load double, double* %l4
  %t82 = load double, double* %l5
  br i1 %t76, label %then14, label %merge15
then14:
  br label %afterloop11
merge15:
  %t83 = load %LexerState, %LexerState* %l0
  %t84 = extractvalue %LexerState %t83, 0
  %t85 = load %LexerState, %LexerState* %l0
  %t86 = extractvalue %LexerState %t85, 1
  %t87 = fptosi double %t86 to i64
  %t88 = getelementptr i8, i8* %t84, i64 %t87
  %t89 = load i8, i8* %t88
  %t90 = icmp eq i8 %t89, 10
  %t91 = load %LexerState, %LexerState* %l0
  %t92 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t93 = load i8, i8* %l2
  %t94 = load double, double* %l3
  %t95 = load double, double* %l4
  %t96 = load double, double* %l5
  br i1 %t90, label %then16, label %else17
then16:
  br label %merge18
else17:
  br label %merge18
merge18:
  br label %loop.latch10
loop.latch10:
  br label %loop.header8
afterloop11:
  %t97 = load %LexerState, %LexerState* %l0
  %t98 = extractvalue %LexerState %t97, 0
  %t99 = load double, double* %l3
  %t100 = load %LexerState, %LexerState* %l0
  %t101 = extractvalue %LexerState %t100, 1
  %t102 = call i8* @slice(i8* %t98, double %t99, double %t101)
  store i8* %t102, i8** %l6
  %t103 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t104 = insertvalue %TokenKind undef, i32 5, 0
  %t105 = insertvalue %Token undef, i8* null, 0
  %t106 = load i8*, i8** %l6
  %t107 = insertvalue %Token %t105, i8* %t106, 1
  %t108 = load double, double* %l4
  %t109 = insertvalue %Token %t107, double %t108, 2
  %t110 = load double, double* %l5
  %t111 = insertvalue %Token %t109, double %t110, 3
  %t112 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t103, %Token %t111)
  store { %Token*, i64 }* %t112, { %Token*, i64 }** %l1
  br label %loop.latch2
merge7:
  %t113 = load i8, i8* %l2
  %t114 = load i8, i8* %l2
  %t115 = alloca [2 x i8], align 1
  %t116 = getelementptr [2 x i8], [2 x i8]* %t115, i32 0, i32 0
  store i8 %t114, i8* %t116
  %t117 = getelementptr [2 x i8], [2 x i8]* %t115, i32 0, i32 1
  store i8 0, i8* %t117
  %t118 = getelementptr [2 x i8], [2 x i8]* %t115, i32 0, i32 0
  %t119 = call i1 @is_double_quote(i8* %t118)
  %t120 = load %LexerState, %LexerState* %l0
  %t121 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t122 = load i8, i8* %l2
  br i1 %t119, label %then19, label %merge20
then19:
  %t123 = load %LexerState, %LexerState* %l0
  %t124 = extractvalue %LexerState %t123, 1
  store double %t124, double* %l7
  %t125 = load %LexerState, %LexerState* %l0
  %t126 = extractvalue %LexerState %t125, 2
  store double %t126, double* %l8
  %t127 = load %LexerState, %LexerState* %l0
  %t128 = extractvalue %LexerState %t127, 3
  store double %t128, double* %l9
  %s129 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.129, i32 0, i32 0
  store i8* %s129, i8** %l10
  store i1 0, i1* %l11
  %t130 = load %LexerState, %LexerState* %l0
  %t131 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t132 = load i8, i8* %l2
  %t133 = load double, double* %l7
  %t134 = load double, double* %l8
  %t135 = load double, double* %l9
  %t136 = load i8*, i8** %l10
  %t137 = load i1, i1* %l11
  br label %loop.header21
loop.header21:
  %t240 = phi i1 [ %t137, %then19 ], [ %t238, %loop.latch23 ]
  %t241 = phi i8* [ %t136, %then19 ], [ %t239, %loop.latch23 ]
  store i1 %t240, i1* %l11
  store i8* %t241, i8** %l10
  br label %loop.body22
loop.body22:
  %t138 = load %LexerState, %LexerState* %l0
  %t139 = extractvalue %LexerState %t138, 1
  %t140 = load %LexerState, %LexerState* %l0
  %t141 = extractvalue %LexerState %t140, 0
  %t142 = call i64 @sailfin_runtime_string_length(i8* %t141)
  %t143 = sitofp i64 %t142 to double
  %t144 = fcmp oge double %t139, %t143
  %t145 = load %LexerState, %LexerState* %l0
  %t146 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t147 = load i8, i8* %l2
  %t148 = load double, double* %l7
  %t149 = load double, double* %l8
  %t150 = load double, double* %l9
  %t151 = load i8*, i8** %l10
  %t152 = load i1, i1* %l11
  br i1 %t144, label %then25, label %merge26
then25:
  br label %afterloop24
merge26:
  %t153 = load %LexerState, %LexerState* %l0
  %t154 = extractvalue %LexerState %t153, 0
  %t155 = load %LexerState, %LexerState* %l0
  %t156 = extractvalue %LexerState %t155, 1
  %t157 = fptosi double %t156 to i64
  %t158 = getelementptr i8, i8* %t154, i64 %t157
  %t159 = load i8, i8* %t158
  store i8 %t159, i8* %l12
  %t161 = load i1, i1* %l11
  br label %logical_and_entry_160

logical_and_entry_160:
  br i1 %t161, label %logical_and_right_160, label %logical_and_merge_160

logical_and_right_160:
  %t162 = load i8, i8* %l12
  %t163 = alloca [2 x i8], align 1
  %t164 = getelementptr [2 x i8], [2 x i8]* %t163, i32 0, i32 0
  store i8 %t162, i8* %t164
  %t165 = getelementptr [2 x i8], [2 x i8]* %t163, i32 0, i32 1
  store i8 0, i8* %t165
  %t166 = getelementptr [2 x i8], [2 x i8]* %t163, i32 0, i32 0
  %t167 = call i1 @is_double_quote(i8* %t166)
  br label %logical_and_right_end_160

logical_and_right_end_160:
  br label %logical_and_merge_160

logical_and_merge_160:
  %t168 = phi i1 [ false, %logical_and_entry_160 ], [ %t167, %logical_and_right_end_160 ]
  %t169 = xor i1 %t168, 1
  %t170 = load %LexerState, %LexerState* %l0
  %t171 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t172 = load i8, i8* %l2
  %t173 = load double, double* %l7
  %t174 = load double, double* %l8
  %t175 = load double, double* %l9
  %t176 = load i8*, i8** %l10
  %t177 = load i1, i1* %l11
  %t178 = load i8, i8* %l12
  br i1 %t169, label %then27, label %merge28
then27:
  br label %afterloop24
merge28:
  %t180 = load i1, i1* %l11
  br label %logical_and_entry_179

logical_and_entry_179:
  br i1 %t180, label %logical_and_right_179, label %logical_and_merge_179

logical_and_right_179:
  %t181 = load i8, i8* %l12
  %t182 = alloca [2 x i8], align 1
  %t183 = getelementptr [2 x i8], [2 x i8]* %t182, i32 0, i32 0
  store i8 %t181, i8* %t183
  %t184 = getelementptr [2 x i8], [2 x i8]* %t182, i32 0, i32 1
  store i8 0, i8* %t184
  %t185 = getelementptr [2 x i8], [2 x i8]* %t182, i32 0, i32 0
  %t186 = call i1 @is_backslash(i8* %t185)
  br label %logical_and_right_end_179

logical_and_right_end_179:
  br label %logical_and_merge_179

logical_and_merge_179:
  %t187 = phi i1 [ false, %logical_and_entry_179 ], [ %t186, %logical_and_right_end_179 ]
  %t188 = xor i1 %t187, 1
  %t189 = load %LexerState, %LexerState* %l0
  %t190 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t191 = load i8, i8* %l2
  %t192 = load double, double* %l7
  %t193 = load double, double* %l8
  %t194 = load double, double* %l9
  %t195 = load i8*, i8** %l10
  %t196 = load i1, i1* %l11
  %t197 = load i8, i8* %l12
  br i1 %t188, label %then29, label %merge30
then29:
  store i1 1, i1* %l11
  br label %loop.latch23
merge30:
  %t198 = load i1, i1* %l11
  %t199 = load %LexerState, %LexerState* %l0
  %t200 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t201 = load i8, i8* %l2
  %t202 = load double, double* %l7
  %t203 = load double, double* %l8
  %t204 = load double, double* %l9
  %t205 = load i8*, i8** %l10
  %t206 = load i1, i1* %l11
  %t207 = load i8, i8* %l12
  br i1 %t198, label %then31, label %else32
then31:
  %t208 = load i8*, i8** %l10
  %t209 = load i8, i8* %l12
  %t210 = alloca [2 x i8], align 1
  %t211 = getelementptr [2 x i8], [2 x i8]* %t210, i32 0, i32 0
  store i8 %t209, i8* %t211
  %t212 = getelementptr [2 x i8], [2 x i8]* %t210, i32 0, i32 1
  store i8 0, i8* %t212
  %t213 = getelementptr [2 x i8], [2 x i8]* %t210, i32 0, i32 0
  %t214 = call i8* @interpret_escape(i8* %t213)
  %t215 = add i8* %t208, %t214
  store i8* %t215, i8** %l10
  store i1 0, i1* %l11
  br label %merge33
else32:
  %t216 = load i8*, i8** %l10
  %t217 = load i8, i8* %l12
  %t218 = getelementptr i8, i8* %t216, i64 0
  %t219 = load i8, i8* %t218
  %t220 = add i8 %t219, %t217
  %t221 = alloca [2 x i8], align 1
  %t222 = getelementptr [2 x i8], [2 x i8]* %t221, i32 0, i32 0
  store i8 %t220, i8* %t222
  %t223 = getelementptr [2 x i8], [2 x i8]* %t221, i32 0, i32 1
  store i8 0, i8* %t223
  %t224 = getelementptr [2 x i8], [2 x i8]* %t221, i32 0, i32 0
  store i8* %t224, i8** %l10
  br label %merge33
merge33:
  %t225 = phi i8* [ %t215, %then31 ], [ %t224, %else32 ]
  %t226 = phi i1 [ 0, %then31 ], [ %t206, %else32 ]
  store i8* %t225, i8** %l10
  store i1 %t226, i1* %l11
  %t227 = load i8, i8* %l12
  %t228 = icmp eq i8 %t227, 10
  %t229 = load %LexerState, %LexerState* %l0
  %t230 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t231 = load i8, i8* %l2
  %t232 = load double, double* %l7
  %t233 = load double, double* %l8
  %t234 = load double, double* %l9
  %t235 = load i8*, i8** %l10
  %t236 = load i1, i1* %l11
  %t237 = load i8, i8* %l12
  br i1 %t228, label %then34, label %else35
then34:
  br label %merge36
else35:
  br label %merge36
merge36:
  br label %loop.latch23
loop.latch23:
  %t238 = load i1, i1* %l11
  %t239 = load i8*, i8** %l10
  br label %loop.header21
afterloop24:
  %t242 = load %LexerState, %LexerState* %l0
  %t243 = extractvalue %LexerState %t242, 0
  %t244 = load double, double* %l7
  %t245 = load %LexerState, %LexerState* %l0
  %t246 = extractvalue %LexerState %t245, 1
  %t247 = call i8* @slice(i8* %t243, double %t244, double %t246)
  store i8* %t247, i8** %l13
  %t248 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t249 = alloca %TokenKind
  %t250 = getelementptr inbounds %TokenKind, %TokenKind* %t249, i32 0, i32 0
  store i32 2, i32* %t250
  %t251 = load i8*, i8** %l10
  %t252 = getelementptr inbounds %TokenKind, %TokenKind* %t249, i32 0, i32 1
  %t253 = bitcast [8 x i8]* %t252 to i8*
  %t254 = bitcast i8* %t253 to i8**
  store i8* %t251, i8** %t254
  %t255 = load %TokenKind, %TokenKind* %t249
  %t256 = insertvalue %Token undef, i8* null, 0
  %t257 = load i8*, i8** %l13
  %t258 = insertvalue %Token %t256, i8* %t257, 1
  %t259 = load double, double* %l8
  %t260 = insertvalue %Token %t258, double %t259, 2
  %t261 = load double, double* %l9
  %t262 = insertvalue %Token %t260, double %t261, 3
  %t263 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t248, %Token %t262)
  store { %Token*, i64 }* %t263, { %Token*, i64 }** %l1
  br label %loop.latch2
merge20:
  %t264 = load i8, i8* %l2
  %t265 = alloca [2 x i8], align 1
  %t266 = getelementptr [2 x i8], [2 x i8]* %t265, i32 0, i32 0
  store i8 %t264, i8* %t266
  %t267 = getelementptr [2 x i8], [2 x i8]* %t265, i32 0, i32 1
  store i8 0, i8* %t267
  %t268 = getelementptr [2 x i8], [2 x i8]* %t265, i32 0, i32 0
  %t269 = call i1 @is_digit(i8* %t268)
  %t270 = load %LexerState, %LexerState* %l0
  %t271 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t272 = load i8, i8* %l2
  br i1 %t269, label %then37, label %merge38
then37:
  %t273 = load %LexerState, %LexerState* %l0
  %t274 = extractvalue %LexerState %t273, 1
  store double %t274, double* %l14
  %t275 = load %LexerState, %LexerState* %l0
  %t276 = extractvalue %LexerState %t275, 2
  store double %t276, double* %l15
  %t277 = load %LexerState, %LexerState* %l0
  %t278 = extractvalue %LexerState %t277, 3
  store double %t278, double* %l16
  %t279 = load %LexerState, %LexerState* %l0
  %t280 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t281 = load i8, i8* %l2
  %t282 = load double, double* %l14
  %t283 = load double, double* %l15
  %t284 = load double, double* %l16
  br label %loop.header39
loop.header39:
  br label %loop.body40
loop.body40:
  %t285 = load %LexerState, %LexerState* %l0
  %t286 = extractvalue %LexerState %t285, 1
  %t287 = load %LexerState, %LexerState* %l0
  %t288 = extractvalue %LexerState %t287, 0
  %t289 = call i64 @sailfin_runtime_string_length(i8* %t288)
  %t290 = sitofp i64 %t289 to double
  %t291 = fcmp oge double %t286, %t290
  %t292 = load %LexerState, %LexerState* %l0
  %t293 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t294 = load i8, i8* %l2
  %t295 = load double, double* %l14
  %t296 = load double, double* %l15
  %t297 = load double, double* %l16
  br i1 %t291, label %then43, label %merge44
then43:
  br label %afterloop42
merge44:
  %t298 = load %LexerState, %LexerState* %l0
  %t299 = extractvalue %LexerState %t298, 0
  %t300 = load %LexerState, %LexerState* %l0
  %t301 = extractvalue %LexerState %t300, 1
  %t302 = fptosi double %t301 to i64
  %t303 = getelementptr i8, i8* %t299, i64 %t302
  %t304 = load i8, i8* %t303
  %t305 = alloca [2 x i8], align 1
  %t306 = getelementptr [2 x i8], [2 x i8]* %t305, i32 0, i32 0
  store i8 %t304, i8* %t306
  %t307 = getelementptr [2 x i8], [2 x i8]* %t305, i32 0, i32 1
  store i8 0, i8* %t307
  %t308 = getelementptr [2 x i8], [2 x i8]* %t305, i32 0, i32 0
  %t309 = call i1 @is_digit(i8* %t308)
  %t310 = xor i1 %t309, 1
  %t311 = load %LexerState, %LexerState* %l0
  %t312 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t313 = load i8, i8* %l2
  %t314 = load double, double* %l14
  %t315 = load double, double* %l15
  %t316 = load double, double* %l16
  br i1 %t310, label %then45, label %merge46
then45:
  br label %afterloop42
merge46:
  br label %loop.latch41
loop.latch41:
  br label %loop.header39
afterloop42:
  %t318 = load %LexerState, %LexerState* %l0
  %t319 = extractvalue %LexerState %t318, 1
  %t320 = load %LexerState, %LexerState* %l0
  %t321 = extractvalue %LexerState %t320, 0
  %t322 = call i64 @sailfin_runtime_string_length(i8* %t321)
  %t323 = sitofp i64 %t322 to double
  %t324 = fcmp olt double %t319, %t323
  br label %logical_and_entry_317

logical_and_entry_317:
  br i1 %t324, label %logical_and_right_317, label %logical_and_merge_317

logical_and_right_317:
  %t325 = load %LexerState, %LexerState* %l0
  %t326 = extractvalue %LexerState %t325, 0
  %t327 = load %LexerState, %LexerState* %l0
  %t328 = extractvalue %LexerState %t327, 1
  %t329 = fptosi double %t328 to i64
  %t330 = getelementptr i8, i8* %t326, i64 %t329
  %t331 = load i8, i8* %t330
  %t332 = icmp eq i8 %t331, 46
  br label %logical_and_right_end_317

logical_and_right_end_317:
  br label %logical_and_merge_317

logical_and_merge_317:
  %t333 = phi i1 [ false, %logical_and_entry_317 ], [ %t332, %logical_and_right_end_317 ]
  %t334 = load %LexerState, %LexerState* %l0
  %t335 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t336 = load i8, i8* %l2
  %t337 = load double, double* %l14
  %t338 = load double, double* %l15
  %t339 = load double, double* %l16
  br i1 %t333, label %then47, label %merge48
then47:
  %t341 = load %LexerState, %LexerState* %l0
  %t342 = extractvalue %LexerState %t341, 1
  %t343 = sitofp i64 1 to double
  %t344 = fadd double %t342, %t343
  %t345 = load %LexerState, %LexerState* %l0
  %t346 = extractvalue %LexerState %t345, 0
  %t347 = call i64 @sailfin_runtime_string_length(i8* %t346)
  %t348 = sitofp i64 %t347 to double
  %t349 = fcmp olt double %t344, %t348
  br label %logical_and_entry_340

logical_and_entry_340:
  br i1 %t349, label %logical_and_right_340, label %logical_and_merge_340

logical_and_right_340:
  store double 0.0, double* %l17
  %t350 = load double, double* %l17
  %t351 = fcmp one double %t350, 0.0
  %t352 = load %LexerState, %LexerState* %l0
  %t353 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t354 = load i8, i8* %l2
  %t355 = load double, double* %l14
  %t356 = load double, double* %l15
  %t357 = load double, double* %l16
  %t358 = load double, double* %l17
  br i1 %t351, label %then49, label %merge50
then49:
  %t359 = load %LexerState, %LexerState* %l0
  %t360 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t361 = load i8, i8* %l2
  %t362 = load double, double* %l14
  %t363 = load double, double* %l15
  %t364 = load double, double* %l16
  %t365 = load double, double* %l17
  br label %loop.header51
loop.header51:
  br label %loop.body52
loop.body52:
  %t366 = load %LexerState, %LexerState* %l0
  %t367 = extractvalue %LexerState %t366, 1
  %t368 = load %LexerState, %LexerState* %l0
  %t369 = extractvalue %LexerState %t368, 0
  %t370 = call i64 @sailfin_runtime_string_length(i8* %t369)
  %t371 = sitofp i64 %t370 to double
  %t372 = fcmp oge double %t367, %t371
  %t373 = load %LexerState, %LexerState* %l0
  %t374 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t375 = load i8, i8* %l2
  %t376 = load double, double* %l14
  %t377 = load double, double* %l15
  %t378 = load double, double* %l16
  %t379 = load double, double* %l17
  br i1 %t372, label %then55, label %merge56
then55:
  br label %afterloop54
merge56:
  %t380 = load %LexerState, %LexerState* %l0
  %t381 = extractvalue %LexerState %t380, 0
  %t382 = load %LexerState, %LexerState* %l0
  %t383 = extractvalue %LexerState %t382, 1
  %t384 = fptosi double %t383 to i64
  %t385 = getelementptr i8, i8* %t381, i64 %t384
  %t386 = load i8, i8* %t385
  %t387 = alloca [2 x i8], align 1
  %t388 = getelementptr [2 x i8], [2 x i8]* %t387, i32 0, i32 0
  store i8 %t386, i8* %t388
  %t389 = getelementptr [2 x i8], [2 x i8]* %t387, i32 0, i32 1
  store i8 0, i8* %t389
  %t390 = getelementptr [2 x i8], [2 x i8]* %t387, i32 0, i32 0
  %t391 = call i1 @is_digit(i8* %t390)
  %t392 = xor i1 %t391, 1
  %t393 = load %LexerState, %LexerState* %l0
  %t394 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t395 = load i8, i8* %l2
  %t396 = load double, double* %l14
  %t397 = load double, double* %l15
  %t398 = load double, double* %l16
  %t399 = load double, double* %l17
  br i1 %t392, label %then57, label %merge58
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
  %t400 = load %LexerState, %LexerState* %l0
  %t401 = extractvalue %LexerState %t400, 0
  %t402 = load double, double* %l14
  %t403 = load %LexerState, %LexerState* %l0
  %t404 = extractvalue %LexerState %t403, 1
  %t405 = call i8* @slice(i8* %t401, double %t402, double %t404)
  store i8* %t405, i8** %l18
  %t406 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t407 = alloca %TokenKind
  %t408 = getelementptr inbounds %TokenKind, %TokenKind* %t407, i32 0, i32 0
  store i32 1, i32* %t408
  %t409 = load i8*, i8** %l18
  %t410 = getelementptr inbounds %TokenKind, %TokenKind* %t407, i32 0, i32 1
  %t411 = bitcast [8 x i8]* %t410 to i8*
  %t412 = bitcast i8* %t411 to i8**
  store i8* %t409, i8** %t412
  %t413 = load %TokenKind, %TokenKind* %t407
  %t414 = insertvalue %Token undef, i8* null, 0
  %t415 = load i8*, i8** %l18
  %t416 = insertvalue %Token %t414, i8* %t415, 1
  %t417 = load double, double* %l15
  %t418 = insertvalue %Token %t416, double %t417, 2
  %t419 = load double, double* %l16
  %t420 = insertvalue %Token %t418, double %t419, 3
  %t421 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t406, %Token %t420)
  store { %Token*, i64 }* %t421, { %Token*, i64 }** %l1
  br label %loop.latch2
merge38:
  %t422 = load i8, i8* %l2
  %t423 = alloca [2 x i8], align 1
  %t424 = getelementptr [2 x i8], [2 x i8]* %t423, i32 0, i32 0
  store i8 %t422, i8* %t424
  %t425 = getelementptr [2 x i8], [2 x i8]* %t423, i32 0, i32 1
  store i8 0, i8* %t425
  %t426 = getelementptr [2 x i8], [2 x i8]* %t423, i32 0, i32 0
  %t427 = call i1 @is_identifier_start(i8* %t426)
  %t428 = load %LexerState, %LexerState* %l0
  %t429 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t430 = load i8, i8* %l2
  br i1 %t427, label %then59, label %merge60
then59:
  %t431 = load %LexerState, %LexerState* %l0
  %t432 = extractvalue %LexerState %t431, 1
  store double %t432, double* %l19
  %t433 = load %LexerState, %LexerState* %l0
  %t434 = extractvalue %LexerState %t433, 2
  store double %t434, double* %l20
  %t435 = load %LexerState, %LexerState* %l0
  %t436 = extractvalue %LexerState %t435, 3
  store double %t436, double* %l21
  %t437 = load %LexerState, %LexerState* %l0
  %t438 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t439 = load i8, i8* %l2
  %t440 = load double, double* %l19
  %t441 = load double, double* %l20
  %t442 = load double, double* %l21
  br label %loop.header61
loop.header61:
  br label %loop.body62
loop.body62:
  %t443 = load %LexerState, %LexerState* %l0
  %t444 = extractvalue %LexerState %t443, 1
  %t445 = load %LexerState, %LexerState* %l0
  %t446 = extractvalue %LexerState %t445, 0
  %t447 = call i64 @sailfin_runtime_string_length(i8* %t446)
  %t448 = sitofp i64 %t447 to double
  %t449 = fcmp oge double %t444, %t448
  %t450 = load %LexerState, %LexerState* %l0
  %t451 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t452 = load i8, i8* %l2
  %t453 = load double, double* %l19
  %t454 = load double, double* %l20
  %t455 = load double, double* %l21
  br i1 %t449, label %then65, label %merge66
then65:
  br label %afterloop64
merge66:
  %t456 = load %LexerState, %LexerState* %l0
  %t457 = extractvalue %LexerState %t456, 0
  %t458 = load %LexerState, %LexerState* %l0
  %t459 = extractvalue %LexerState %t458, 1
  %t460 = fptosi double %t459 to i64
  %t461 = getelementptr i8, i8* %t457, i64 %t460
  %t462 = load i8, i8* %t461
  %t463 = alloca [2 x i8], align 1
  %t464 = getelementptr [2 x i8], [2 x i8]* %t463, i32 0, i32 0
  store i8 %t462, i8* %t464
  %t465 = getelementptr [2 x i8], [2 x i8]* %t463, i32 0, i32 1
  store i8 0, i8* %t465
  %t466 = getelementptr [2 x i8], [2 x i8]* %t463, i32 0, i32 0
  %t467 = call i1 @is_identifier_part(i8* %t466)
  %t468 = xor i1 %t467, 1
  %t469 = load %LexerState, %LexerState* %l0
  %t470 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t471 = load i8, i8* %l2
  %t472 = load double, double* %l19
  %t473 = load double, double* %l20
  %t474 = load double, double* %l21
  br i1 %t468, label %then67, label %merge68
then67:
  br label %afterloop64
merge68:
  br label %loop.latch63
loop.latch63:
  br label %loop.header61
afterloop64:
  %t475 = load %LexerState, %LexerState* %l0
  %t476 = extractvalue %LexerState %t475, 0
  %t477 = load double, double* %l19
  %t478 = load %LexerState, %LexerState* %l0
  %t479 = extractvalue %LexerState %t478, 1
  %t480 = call i8* @slice(i8* %t476, double %t477, double %t479)
  store i8* %t480, i8** %l22
  %t482 = load i8*, i8** %l22
  %s483 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.483, i32 0, i32 0
  %t484 = icmp eq i8* %t482, %s483
  br label %logical_or_entry_481

logical_or_entry_481:
  br i1 %t484, label %logical_or_merge_481, label %logical_or_right_481

logical_or_right_481:
  %t485 = load i8*, i8** %l22
  %s486 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.486, i32 0, i32 0
  %t487 = icmp eq i8* %t485, %s486
  br label %logical_or_right_end_481

logical_or_right_end_481:
  br label %logical_or_merge_481

logical_or_merge_481:
  %t488 = phi i1 [ true, %logical_or_entry_481 ], [ %t487, %logical_or_right_end_481 ]
  %t489 = load %LexerState, %LexerState* %l0
  %t490 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t491 = load i8, i8* %l2
  %t492 = load double, double* %l19
  %t493 = load double, double* %l20
  %t494 = load double, double* %l21
  %t495 = load i8*, i8** %l22
  br i1 %t488, label %then69, label %else70
then69:
  %t496 = load i8*, i8** %l22
  %s497 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.497, i32 0, i32 0
  %t498 = icmp eq i8* %t496, %s497
  store i1 %t498, i1* %l23
  %t499 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t500 = alloca %TokenKind
  %t501 = getelementptr inbounds %TokenKind, %TokenKind* %t500, i32 0, i32 0
  store i32 3, i32* %t501
  %t502 = load i1, i1* %l23
  %t503 = getelementptr inbounds %TokenKind, %TokenKind* %t500, i32 0, i32 1
  %t504 = bitcast [1 x i8]* %t503 to i8*
  %t505 = bitcast i8* %t504 to i1*
  store i1 %t502, i1* %t505
  %t506 = load %TokenKind, %TokenKind* %t500
  %t507 = insertvalue %Token undef, i8* null, 0
  %t508 = load i8*, i8** %l22
  %t509 = insertvalue %Token %t507, i8* %t508, 1
  %t510 = load double, double* %l20
  %t511 = insertvalue %Token %t509, double %t510, 2
  %t512 = load double, double* %l21
  %t513 = insertvalue %Token %t511, double %t512, 3
  %t514 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t499, %Token %t513)
  store { %Token*, i64 }* %t514, { %Token*, i64 }** %l1
  br label %merge71
else70:
  %t515 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t516 = alloca %TokenKind
  %t517 = getelementptr inbounds %TokenKind, %TokenKind* %t516, i32 0, i32 0
  store i32 0, i32* %t517
  %t518 = load i8*, i8** %l22
  %t519 = getelementptr inbounds %TokenKind, %TokenKind* %t516, i32 0, i32 1
  %t520 = bitcast [8 x i8]* %t519 to i8*
  %t521 = bitcast i8* %t520 to i8**
  store i8* %t518, i8** %t521
  %t522 = load %TokenKind, %TokenKind* %t516
  %t523 = insertvalue %Token undef, i8* null, 0
  %t524 = load i8*, i8** %l22
  %t525 = insertvalue %Token %t523, i8* %t524, 1
  %t526 = load double, double* %l20
  %t527 = insertvalue %Token %t525, double %t526, 2
  %t528 = load double, double* %l21
  %t529 = insertvalue %Token %t527, double %t528, 3
  %t530 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t515, %Token %t529)
  store { %Token*, i64 }* %t530, { %Token*, i64 }** %l1
  br label %merge71
merge71:
  %t531 = phi { %Token*, i64 }* [ %t514, %then69 ], [ %t530, %else70 ]
  store { %Token*, i64 }* %t531, { %Token*, i64 }** %l1
  br label %loop.latch2
merge60:
  %t532 = load %LexerState, %LexerState* %l0
  %t533 = extractvalue %LexerState %t532, 2
  store double %t533, double* %l24
  %t534 = load %LexerState, %LexerState* %l0
  %t535 = extractvalue %LexerState %t534, 3
  store double %t535, double* %l25
  %t536 = load i8, i8* %l2
  store i8 %t536, i8* %l26
  %t537 = load %LexerState, %LexerState* %l0
  %t538 = call i8* @peek_next_char(%LexerState %t537)
  store i8* %t538, i8** %l27
  %t539 = load i8*, i8** %l27
  %s540 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.540, i32 0, i32 0
  %t541 = icmp ne i8* %t539, %s540
  %t542 = load %LexerState, %LexerState* %l0
  %t543 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t544 = load i8, i8* %l2
  %t545 = load double, double* %l24
  %t546 = load double, double* %l25
  %t547 = load i8, i8* %l26
  %t548 = load i8*, i8** %l27
  br i1 %t541, label %then72, label %merge73
then72:
  %t549 = load i8, i8* %l2
  %t550 = load i8*, i8** %l27
  %t551 = getelementptr i8, i8* %t550, i64 0
  %t552 = load i8, i8* %t551
  %t553 = add i8 %t549, %t552
  store i8 %t553, i8* %l28
  %t554 = load i8, i8* %l28
  %t555 = alloca [2 x i8], align 1
  %t556 = getelementptr [2 x i8], [2 x i8]* %t555, i32 0, i32 0
  store i8 %t554, i8* %t556
  %t557 = getelementptr [2 x i8], [2 x i8]* %t555, i32 0, i32 1
  store i8 0, i8* %t557
  %t558 = getelementptr [2 x i8], [2 x i8]* %t555, i32 0, i32 0
  %t559 = call i1 @is_two_char_symbol(i8* %t558)
  %t560 = load %LexerState, %LexerState* %l0
  %t561 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t562 = load i8, i8* %l2
  %t563 = load double, double* %l24
  %t564 = load double, double* %l25
  %t565 = load i8, i8* %l26
  %t566 = load i8*, i8** %l27
  %t567 = load i8, i8* %l28
  br i1 %t559, label %then74, label %merge75
then74:
  %t568 = load i8, i8* %l28
  store i8 %t568, i8* %l26
  %t569 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t570 = alloca %TokenKind
  %t571 = getelementptr inbounds %TokenKind, %TokenKind* %t570, i32 0, i32 0
  store i32 4, i32* %t571
  %t572 = load i8, i8* %l26
  %t573 = call noalias i8* @malloc(i64 1)
  %t574 = bitcast i8* %t573 to i8*
  store i8 %t572, i8* %t574
  %t575 = getelementptr inbounds %TokenKind, %TokenKind* %t570, i32 0, i32 1
  %t576 = bitcast [8 x i8]* %t575 to i8*
  %t577 = bitcast i8* %t576 to i8**
  store i8* %t573, i8** %t577
  %t578 = load %TokenKind, %TokenKind* %t570
  %t579 = insertvalue %Token undef, i8* null, 0
  %t580 = load i8, i8* %l26
  %t581 = alloca [2 x i8], align 1
  %t582 = getelementptr [2 x i8], [2 x i8]* %t581, i32 0, i32 0
  store i8 %t580, i8* %t582
  %t583 = getelementptr [2 x i8], [2 x i8]* %t581, i32 0, i32 1
  store i8 0, i8* %t583
  %t584 = getelementptr [2 x i8], [2 x i8]* %t581, i32 0, i32 0
  %t585 = insertvalue %Token %t579, i8* %t584, 1
  %t586 = load double, double* %l24
  %t587 = insertvalue %Token %t585, double %t586, 2
  %t588 = load double, double* %l25
  %t589 = insertvalue %Token %t587, double %t588, 3
  %t590 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t569, %Token %t589)
  store { %Token*, i64 }* %t590, { %Token*, i64 }** %l1
  br label %loop.latch2
merge75:
  br label %merge73
merge73:
  %t591 = phi i8 [ %t568, %then72 ], [ %t547, %loop.body1 ]
  %t592 = phi { %Token*, i64 }* [ %t590, %then72 ], [ %t543, %loop.body1 ]
  store i8 %t591, i8* %l26
  store { %Token*, i64 }* %t592, { %Token*, i64 }** %l1
  %t593 = load i8, i8* %l2
  %t594 = icmp eq i8 %t593, 10
  %t595 = load %LexerState, %LexerState* %l0
  %t596 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t597 = load i8, i8* %l2
  %t598 = load double, double* %l24
  %t599 = load double, double* %l25
  %t600 = load i8, i8* %l26
  %t601 = load i8*, i8** %l27
  br i1 %t594, label %then76, label %else77
then76:
  br label %merge78
else77:
  br label %merge78
merge78:
  %t602 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t603 = alloca %TokenKind
  %t604 = getelementptr inbounds %TokenKind, %TokenKind* %t603, i32 0, i32 0
  store i32 4, i32* %t604
  %t605 = load i8, i8* %l26
  %t606 = call noalias i8* @malloc(i64 1)
  %t607 = bitcast i8* %t606 to i8*
  store i8 %t605, i8* %t607
  %t608 = getelementptr inbounds %TokenKind, %TokenKind* %t603, i32 0, i32 1
  %t609 = bitcast [8 x i8]* %t608 to i8*
  %t610 = bitcast i8* %t609 to i8**
  store i8* %t606, i8** %t610
  %t611 = load %TokenKind, %TokenKind* %t603
  %t612 = insertvalue %Token undef, i8* null, 0
  %t613 = load i8, i8* %l26
  %t614 = alloca [2 x i8], align 1
  %t615 = getelementptr [2 x i8], [2 x i8]* %t614, i32 0, i32 0
  store i8 %t613, i8* %t615
  %t616 = getelementptr [2 x i8], [2 x i8]* %t614, i32 0, i32 1
  store i8 0, i8* %t616
  %t617 = getelementptr [2 x i8], [2 x i8]* %t614, i32 0, i32 0
  %t618 = insertvalue %Token %t612, i8* %t617, 1
  %t619 = load double, double* %l24
  %t620 = insertvalue %Token %t618, double %t619, 2
  %t621 = load double, double* %l25
  %t622 = insertvalue %Token %t620, double %t621, 3
  %t623 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t602, %Token %t622)
  store { %Token*, i64 }* %t623, { %Token*, i64 }** %l1
  br label %loop.latch2
loop.latch2:
  %t624 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br label %loop.header0
afterloop3:
  %t626 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t627 = load %LexerState, %LexerState* %l0
  %t628 = extractvalue %LexerState %t627, 2
  %t629 = load %LexerState, %LexerState* %l0
  %t630 = extractvalue %LexerState %t629, 3
  %t631 = call double @eof_token(double %t628, double %t630)
  %t632 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t626, %Token zeroinitializer)
  store { %Token*, i64 }* %t632, { %Token*, i64 }** %l1
  %t633 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  ret { %Token*, i64 }* %t633
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
  %t15 = alloca [2 x i8], align 1
  %t16 = getelementptr [2 x i8], [2 x i8]* %t15, i32 0, i32 0
  store i8 %t14, i8* %t16
  %t17 = getelementptr [2 x i8], [2 x i8]* %t15, i32 0, i32 1
  store i8 0, i8* %t17
  %t18 = getelementptr [2 x i8], [2 x i8]* %t15, i32 0, i32 0
  ret i8* %t18
}

define i8* @interpret_escape(i8* %ch) {
entry:
  %t0 = getelementptr i8, i8* %ch, i64 0
  %t1 = load i8, i8* %t0
  %t2 = icmp eq i8 %t1, 110
  br i1 %t2, label %then0, label %merge1
then0:
  %t3 = alloca [2 x i8], align 1
  %t4 = getelementptr [2 x i8], [2 x i8]* %t3, i32 0, i32 0
  store i8 10, i8* %t4
  %t5 = getelementptr [2 x i8], [2 x i8]* %t3, i32 0, i32 1
  store i8 0, i8* %t5
  %t6 = getelementptr [2 x i8], [2 x i8]* %t3, i32 0, i32 0
  ret i8* %t6
merge1:
  %t7 = getelementptr i8, i8* %ch, i64 0
  %t8 = load i8, i8* %t7
  %t9 = icmp eq i8 %t8, 116
  br i1 %t9, label %then2, label %merge3
then2:
  %t10 = alloca [2 x i8], align 1
  %t11 = getelementptr [2 x i8], [2 x i8]* %t10, i32 0, i32 0
  store i8 9, i8* %t11
  %t12 = getelementptr [2 x i8], [2 x i8]* %t10, i32 0, i32 1
  store i8 0, i8* %t12
  %t13 = getelementptr [2 x i8], [2 x i8]* %t10, i32 0, i32 0
  ret i8* %t13
merge3:
  %t14 = getelementptr i8, i8* %ch, i64 0
  %t15 = load i8, i8* %t14
  %t16 = icmp eq i8 %t15, 114
  br i1 %t16, label %then4, label %merge5
then4:
  %t17 = alloca [2 x i8], align 1
  %t18 = getelementptr [2 x i8], [2 x i8]* %t17, i32 0, i32 0
  store i8 13, i8* %t18
  %t19 = getelementptr [2 x i8], [2 x i8]* %t17, i32 0, i32 1
  store i8 0, i8* %t19
  %t20 = getelementptr [2 x i8], [2 x i8]* %t17, i32 0, i32 0
  ret i8* %t20
merge5:
  %t21 = call i1 @is_double_quote(i8* %ch)
  br i1 %t21, label %then6, label %merge7
then6:
  %t22 = alloca [2 x i8], align 1
  %t23 = getelementptr [2 x i8], [2 x i8]* %t22, i32 0, i32 0
  store i8 34, i8* %t23
  %t24 = getelementptr [2 x i8], [2 x i8]* %t22, i32 0, i32 1
  store i8 0, i8* %t24
  %t25 = getelementptr [2 x i8], [2 x i8]* %t22, i32 0, i32 0
  ret i8* %t25
merge7:
  %t26 = call i1 @is_backslash(i8* %ch)
  br i1 %t26, label %then8, label %merge9
then8:
  %t27 = alloca [2 x i8], align 1
  %t28 = getelementptr [2 x i8], [2 x i8]* %t27, i32 0, i32 0
  store i8 92, i8* %t28
  %t29 = getelementptr [2 x i8], [2 x i8]* %t27, i32 0, i32 1
  store i8 0, i8* %t29
  %t30 = getelementptr [2 x i8], [2 x i8]* %t27, i32 0, i32 0
  ret i8* %t30
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
