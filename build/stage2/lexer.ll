; ModuleID = 'sailfin'
source_filename = "sailfin"

%LexerState = type { i8*, double, double, double }

declare noalias i8* @malloc(i64)

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
  %l22 = alloca double
  %l23 = alloca double
  %l24 = alloca i8
  %l25 = alloca i8*
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
  %t247 = phi { i8**, i64 }* [ %t6, %entry ], [ %t246, %loop.latch2 ]
  store { i8**, i64 }* %t247, { i8**, i64 }** %l1
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
  %t142 = phi i1 [ %t85, %then12 ], [ %t140, %loop.latch16 ]
  %t143 = phi i8* [ %t84, %then12 ], [ %t141, %loop.latch16 ]
  store i1 %t142, i1* %l11
  store i8* %t143, i8** %l10
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
  %t96 = load i8, i8* %l12
  %t97 = call double @escapedis_double_quote(i8 %t96)
  %t98 = fcmp one double %t97, 0.0
  %t99 = load %LexerState, %LexerState* %l0
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t101 = load i8, i8* %l2
  %t102 = load double, double* %l7
  %t103 = load double, double* %l8
  %t104 = load double, double* %l9
  %t105 = load i8*, i8** %l10
  %t106 = load i1, i1* %l11
  %t107 = load i8, i8* %l12
  br i1 %t98, label %then18, label %merge19
then18:
  br label %afterloop17
merge19:
  %t108 = load i8, i8* %l12
  %t109 = call double @escapedis_backslash(i8 %t108)
  %t110 = fcmp one double %t109, 0.0
  %t111 = load %LexerState, %LexerState* %l0
  %t112 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t113 = load i8, i8* %l2
  %t114 = load double, double* %l7
  %t115 = load double, double* %l8
  %t116 = load double, double* %l9
  %t117 = load i8*, i8** %l10
  %t118 = load i1, i1* %l11
  %t119 = load i8, i8* %l12
  br i1 %t110, label %then20, label %merge21
then20:
  store i1 1, i1* %l11
  br label %loop.latch16
merge21:
  %t120 = load i1, i1* %l11
  %t121 = load %LexerState, %LexerState* %l0
  %t122 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t123 = load i8, i8* %l2
  %t124 = load double, double* %l7
  %t125 = load double, double* %l8
  %t126 = load double, double* %l9
  %t127 = load i8*, i8** %l10
  %t128 = load i1, i1* %l11
  %t129 = load i8, i8* %l12
  br i1 %t120, label %then22, label %else23
then22:
  %t130 = load i8*, i8** %l10
  %t131 = load i8, i8* %l12
  %t132 = call i8* @interpret_escape(i8* null)
  %t133 = add i8* %t130, %t132
  store i8* %t133, i8** %l10
  store i1 0, i1* %l11
  br label %merge24
else23:
  %t134 = load i8*, i8** %l10
  %t135 = load i8, i8* %l12
  br label %merge24
merge24:
  %t136 = phi i8* [ %t133, %then22 ], [ null, %else23 ]
  %t137 = phi i1 [ 0, %then22 ], [ %t128, %else23 ]
  store i8* %t136, i8** %l10
  store i1 %t137, i1* %l11
  %t138 = load i8, i8* %l12
  %s139 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.139, i32 0, i32 0
  br label %loop.latch16
loop.latch16:
  %t140 = load i1, i1* %l11
  %t141 = load i8*, i8** %l10
  br label %loop.header14
afterloop17:
  %t144 = load %LexerState, %LexerState* %l0
  %t145 = extractvalue %LexerState %t144, 0
  %t146 = load double, double* %l7
  %t147 = load %LexerState, %LexerState* %l0
  %t148 = extractvalue %LexerState %t147, 1
  %t149 = call i8* @slice(i8* %t145, double %t146, double %t148)
  store i8* %t149, i8** %l13
  br label %loop.latch2
merge13:
  %t150 = load i8, i8* %l2
  %t151 = call i1 @is_digit(i8* null)
  %t152 = load %LexerState, %LexerState* %l0
  %t153 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t154 = load i8, i8* %l2
  br i1 %t151, label %then25, label %merge26
then25:
  %t155 = load %LexerState, %LexerState* %l0
  %t156 = extractvalue %LexerState %t155, 1
  store double %t156, double* %l14
  %t157 = load %LexerState, %LexerState* %l0
  %t158 = extractvalue %LexerState %t157, 2
  store double %t158, double* %l15
  %t159 = load %LexerState, %LexerState* %l0
  %t160 = extractvalue %LexerState %t159, 3
  store double %t160, double* %l16
  %t161 = load %LexerState, %LexerState* %l0
  %t162 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t163 = load i8, i8* %l2
  %t164 = load double, double* %l14
  %t165 = load double, double* %l15
  %t166 = load double, double* %l16
  br label %loop.header27
loop.header27:
  br label %loop.body28
loop.body28:
  %t167 = load %LexerState, %LexerState* %l0
  %t168 = extractvalue %LexerState %t167, 1
  %t169 = load %LexerState, %LexerState* %l0
  %t170 = extractvalue %LexerState %t169, 0
  %t171 = load %LexerState, %LexerState* %l0
  %t172 = extractvalue %LexerState %t171, 0
  %t173 = load %LexerState, %LexerState* %l0
  %t174 = extractvalue %LexerState %t173, 1
  %t175 = getelementptr i8, i8* %t172, i64 %t174
  %t176 = load i8, i8* %t175
  %t177 = call double @is_digit(i8 %t176)
  %t178 = fcmp one double %t177, 0.0
  %t179 = load %LexerState, %LexerState* %l0
  %t180 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t181 = load i8, i8* %l2
  %t182 = load double, double* %l14
  %t183 = load double, double* %l15
  %t184 = load double, double* %l16
  br i1 %t178, label %then31, label %merge32
then31:
  br label %afterloop30
merge32:
  br label %loop.latch29
loop.latch29:
  br label %loop.header27
afterloop30:
  %t185 = load %LexerState, %LexerState* %l0
  %t186 = extractvalue %LexerState %t185, 1
  %t187 = load %LexerState, %LexerState* %l0
  %t188 = extractvalue %LexerState %t187, 0
  %t189 = load double, double* %l14
  %t190 = load %LexerState, %LexerState* %l0
  %t191 = extractvalue %LexerState %t190, 1
  %t192 = call i8* @slice(i8* %t188, double %t189, double %t191)
  store i8* %t192, i8** %l17
  br label %loop.latch2
merge26:
  %t193 = load i8, i8* %l2
  %t194 = call i1 @is_identifier_start(i8* null)
  %t195 = load %LexerState, %LexerState* %l0
  %t196 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t197 = load i8, i8* %l2
  br i1 %t194, label %then33, label %merge34
then33:
  %t198 = load %LexerState, %LexerState* %l0
  %t199 = extractvalue %LexerState %t198, 1
  store double %t199, double* %l18
  %t200 = load %LexerState, %LexerState* %l0
  %t201 = extractvalue %LexerState %t200, 2
  store double %t201, double* %l19
  %t202 = load %LexerState, %LexerState* %l0
  %t203 = extractvalue %LexerState %t202, 3
  store double %t203, double* %l20
  %t204 = load %LexerState, %LexerState* %l0
  %t205 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t206 = load i8, i8* %l2
  %t207 = load double, double* %l18
  %t208 = load double, double* %l19
  %t209 = load double, double* %l20
  br label %loop.header35
loop.header35:
  br label %loop.body36
loop.body36:
  %t210 = load %LexerState, %LexerState* %l0
  %t211 = extractvalue %LexerState %t210, 1
  %t212 = load %LexerState, %LexerState* %l0
  %t213 = extractvalue %LexerState %t212, 0
  %t214 = load %LexerState, %LexerState* %l0
  %t215 = extractvalue %LexerState %t214, 0
  %t216 = load %LexerState, %LexerState* %l0
  %t217 = extractvalue %LexerState %t216, 1
  %t218 = getelementptr i8, i8* %t215, i64 %t217
  %t219 = load i8, i8* %t218
  %t220 = call double @is_identifier_part(i8 %t219)
  %t221 = fcmp one double %t220, 0.0
  %t222 = load %LexerState, %LexerState* %l0
  %t223 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t224 = load i8, i8* %l2
  %t225 = load double, double* %l18
  %t226 = load double, double* %l19
  %t227 = load double, double* %l20
  br i1 %t221, label %then39, label %merge40
then39:
  br label %afterloop38
merge40:
  br label %loop.latch37
loop.latch37:
  br label %loop.header35
afterloop38:
  %t228 = load %LexerState, %LexerState* %l0
  %t229 = extractvalue %LexerState %t228, 0
  %t230 = load double, double* %l18
  %t231 = load %LexerState, %LexerState* %l0
  %t232 = extractvalue %LexerState %t231, 1
  %t233 = call i8* @slice(i8* %t229, double %t230, double %t232)
  store i8* %t233, i8** %l21
  %t234 = load i8*, i8** %l21
  br label %loop.latch2
merge34:
  %t235 = load %LexerState, %LexerState* %l0
  %t236 = extractvalue %LexerState %t235, 2
  store double %t236, double* %l22
  %t237 = load %LexerState, %LexerState* %l0
  %t238 = extractvalue %LexerState %t237, 3
  store double %t238, double* %l23
  %t239 = load i8, i8* %l2
  store i8 %t239, i8* %l24
  %t240 = load %LexerState, %LexerState* %l0
  %t241 = call i8* @peek_next_char(%LexerState %t240)
  store i8* %t241, i8** %l25
  %t242 = load i8*, i8** %l25
  %s243 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.243, i32 0, i32 0
  %t244 = load i8, i8* %l2
  %s245 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.245, i32 0, i32 0
  br label %loop.latch2
loop.latch2:
  %t246 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %loop.header0
afterloop3:
  %t248 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t249 = load %LexerState, %LexerState* %l0
  %t250 = extractvalue %LexerState %t249, 2
  %t251 = load %LexerState, %LexerState* %l0
  %t252 = extractvalue %LexerState %t251, 3
  %t253 = call double @eof_token(double %t250, double %t252)
  %t254 = call { i8**, i64 }* @append({ i8**, i64 }* %t248, i8* null)
  store { i8**, i64 }* %t254, { i8**, i64 }** %l1
  %t255 = load { i8**, i64 }*, { i8**, i64 }** %l1
  ret { i8**, i64 }* %t255
}

define i1 @is_whitespace(i8* %ch) {
entry:
  ret i1 false
}

define i1 @is_identifier_start(i8* %ch) {
entry:
  ret i1 false
}

define i1 @is_identifier_part(i8* %ch) {
entry:
  ret i1 false
}

define i1 @is_letter(i8* %ch) {
entry:
  %l0 = alloca double
  %t0 = call double @char_code(i8* %ch)
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  ret i1 false
}

define i1 @is_digit(i8* %ch) {
entry:
  %l0 = alloca double
  %t0 = call double @char_code(i8* %ch)
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  ret i1 false
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
  %s1 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.1, i32 0, i32 0
  %s2 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.2, i32 0, i32 0
  %t3 = call i1 @is_double_quote(i8* %ch)
  br i1 %t3, label %then0, label %merge1
then0:
  %s4 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.4, i32 0, i32 0
  ret i8* %s4
merge1:
  %t5 = call i1 @is_backslash(i8* %ch)
  br i1 %t5, label %then2, label %merge3
then2:
  %s6 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.6, i32 0, i32 0
  ret i8* %s6
merge3:
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
