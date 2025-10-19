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
  %l27 = alloca i8
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
  %t325 = phi { %Token*, i64 }* [ %t6, %entry ], [ %t324, %loop.latch2 ]
  store { %Token*, i64 }* %t325, { %Token*, i64 }** %l1
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
  %t20 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
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
  %t29 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
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
  %t44 = call i1 @is_whitespace(i8* null)
  %t45 = xor i1 %t44, 1
  %t46 = load %LexerState, %LexerState* %l0
  %t47 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
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
  %t58 = icmp eq i8 %t57, 10
  %t59 = load %LexerState, %LexerState* %l0
  %t60 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t61 = load i8, i8* %l2
  %t62 = load double, double* %l3
  %t63 = load double, double* %l4
  %t64 = load double, double* %l5
  br i1 %t58, label %then12, label %else13
then12:
  br label %merge14
else13:
  br label %merge14
merge14:
  br label %loop.latch8
loop.latch8:
  br label %loop.header6
afterloop9:
  %t65 = load %LexerState, %LexerState* %l0
  %t66 = extractvalue %LexerState %t65, 0
  %t67 = load double, double* %l3
  %t68 = load %LexerState, %LexerState* %l0
  %t69 = extractvalue %LexerState %t68, 1
  %t70 = call i8* @slice(i8* %t66, double %t67, double %t69)
  store i8* %t70, i8** %l6
  br label %loop.latch2
merge5:
  %t71 = load i8, i8* %l2
  %t72 = load i8, i8* %l2
  %t73 = call i1 @is_double_quote(i8* null)
  %t74 = load %LexerState, %LexerState* %l0
  %t75 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t76 = load i8, i8* %l2
  br i1 %t73, label %then15, label %merge16
then15:
  %t77 = load %LexerState, %LexerState* %l0
  %t78 = extractvalue %LexerState %t77, 1
  store double %t78, double* %l7
  %t79 = load %LexerState, %LexerState* %l0
  %t80 = extractvalue %LexerState %t79, 2
  store double %t80, double* %l8
  %t81 = load %LexerState, %LexerState* %l0
  %t82 = extractvalue %LexerState %t81, 3
  store double %t82, double* %l9
  %s83 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.83, i32 0, i32 0
  store i8* %s83, i8** %l10
  store i1 0, i1* %l11
  %t84 = load %LexerState, %LexerState* %l0
  %t85 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t86 = load i8, i8* %l2
  %t87 = load double, double* %l7
  %t88 = load double, double* %l8
  %t89 = load double, double* %l9
  %t90 = load i8*, i8** %l10
  %t91 = load i1, i1* %l11
  br label %loop.header17
loop.header17:
  %t166 = phi i1 [ %t91, %then15 ], [ %t164, %loop.latch19 ]
  %t167 = phi i8* [ %t90, %then15 ], [ %t165, %loop.latch19 ]
  store i1 %t166, i1* %l11
  store i8* %t167, i8** %l10
  br label %loop.body18
loop.body18:
  %t92 = load %LexerState, %LexerState* %l0
  %t93 = extractvalue %LexerState %t92, 1
  %t94 = load %LexerState, %LexerState* %l0
  %t95 = extractvalue %LexerState %t94, 0
  %t96 = load %LexerState, %LexerState* %l0
  %t97 = extractvalue %LexerState %t96, 0
  %t98 = load %LexerState, %LexerState* %l0
  %t99 = extractvalue %LexerState %t98, 1
  %t100 = getelementptr i8, i8* %t97, i64 %t99
  %t101 = load i8, i8* %t100
  store i8 %t101, i8* %l12
  %t103 = load i1, i1* %l11
  br label %logical_and_entry_102

logical_and_entry_102:
  br i1 %t103, label %logical_and_right_102, label %logical_and_merge_102

logical_and_right_102:
  %t104 = load i8, i8* %l12
  %t105 = call i1 @is_double_quote(i8* null)
  br label %logical_and_right_end_102

logical_and_right_end_102:
  br label %logical_and_merge_102

logical_and_merge_102:
  %t106 = phi i1 [ false, %logical_and_entry_102 ], [ %t105, %logical_and_right_end_102 ]
  %t107 = xor i1 %t106, 1
  %t108 = load %LexerState, %LexerState* %l0
  %t109 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t110 = load i8, i8* %l2
  %t111 = load double, double* %l7
  %t112 = load double, double* %l8
  %t113 = load double, double* %l9
  %t114 = load i8*, i8** %l10
  %t115 = load i1, i1* %l11
  %t116 = load i8, i8* %l12
  br i1 %t107, label %then21, label %merge22
then21:
  br label %afterloop20
merge22:
  %t118 = load i1, i1* %l11
  br label %logical_and_entry_117

logical_and_entry_117:
  br i1 %t118, label %logical_and_right_117, label %logical_and_merge_117

logical_and_right_117:
  %t119 = load i8, i8* %l12
  %t120 = call i1 @is_backslash(i8* null)
  br label %logical_and_right_end_117

logical_and_right_end_117:
  br label %logical_and_merge_117

logical_and_merge_117:
  %t121 = phi i1 [ false, %logical_and_entry_117 ], [ %t120, %logical_and_right_end_117 ]
  %t122 = xor i1 %t121, 1
  %t123 = load %LexerState, %LexerState* %l0
  %t124 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t125 = load i8, i8* %l2
  %t126 = load double, double* %l7
  %t127 = load double, double* %l8
  %t128 = load double, double* %l9
  %t129 = load i8*, i8** %l10
  %t130 = load i1, i1* %l11
  %t131 = load i8, i8* %l12
  br i1 %t122, label %then23, label %merge24
then23:
  store i1 1, i1* %l11
  br label %loop.latch19
merge24:
  %t132 = load i1, i1* %l11
  %t133 = load %LexerState, %LexerState* %l0
  %t134 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t135 = load i8, i8* %l2
  %t136 = load double, double* %l7
  %t137 = load double, double* %l8
  %t138 = load double, double* %l9
  %t139 = load i8*, i8** %l10
  %t140 = load i1, i1* %l11
  %t141 = load i8, i8* %l12
  br i1 %t132, label %then25, label %else26
then25:
  %t142 = load i8*, i8** %l10
  %t143 = load i8, i8* %l12
  %t144 = call i8* @interpret_escape(i8* null)
  %t145 = add i8* %t142, %t144
  store i8* %t145, i8** %l10
  store i1 0, i1* %l11
  br label %merge27
else26:
  %t146 = load i8*, i8** %l10
  %t147 = load i8, i8* %l12
  %t148 = getelementptr i8, i8* %t146, i64 0
  %t149 = load i8, i8* %t148
  %t150 = add i8 %t149, %t147
  store i8* null, i8** %l10
  br label %merge27
merge27:
  %t151 = phi i8* [ %t145, %then25 ], [ null, %else26 ]
  %t152 = phi i1 [ 0, %then25 ], [ %t140, %else26 ]
  store i8* %t151, i8** %l10
  store i1 %t152, i1* %l11
  %t153 = load i8, i8* %l12
  %t154 = icmp eq i8 %t153, 10
  %t155 = load %LexerState, %LexerState* %l0
  %t156 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t157 = load i8, i8* %l2
  %t158 = load double, double* %l7
  %t159 = load double, double* %l8
  %t160 = load double, double* %l9
  %t161 = load i8*, i8** %l10
  %t162 = load i1, i1* %l11
  %t163 = load i8, i8* %l12
  br i1 %t154, label %then28, label %else29
then28:
  br label %merge30
else29:
  br label %merge30
merge30:
  br label %loop.latch19
loop.latch19:
  %t164 = load i1, i1* %l11
  %t165 = load i8*, i8** %l10
  br label %loop.header17
afterloop20:
  %t168 = load %LexerState, %LexerState* %l0
  %t169 = extractvalue %LexerState %t168, 0
  %t170 = load double, double* %l7
  %t171 = load %LexerState, %LexerState* %l0
  %t172 = extractvalue %LexerState %t171, 1
  %t173 = call i8* @slice(i8* %t169, double %t170, double %t172)
  store i8* %t173, i8** %l13
  br label %loop.latch2
merge16:
  %t174 = load i8, i8* %l2
  %t175 = call i1 @is_digit(i8* null)
  %t176 = load %LexerState, %LexerState* %l0
  %t177 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t178 = load i8, i8* %l2
  br i1 %t175, label %then31, label %merge32
then31:
  %t179 = load %LexerState, %LexerState* %l0
  %t180 = extractvalue %LexerState %t179, 1
  store double %t180, double* %l14
  %t181 = load %LexerState, %LexerState* %l0
  %t182 = extractvalue %LexerState %t181, 2
  store double %t182, double* %l15
  %t183 = load %LexerState, %LexerState* %l0
  %t184 = extractvalue %LexerState %t183, 3
  store double %t184, double* %l16
  %t185 = load %LexerState, %LexerState* %l0
  %t186 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t187 = load i8, i8* %l2
  %t188 = load double, double* %l14
  %t189 = load double, double* %l15
  %t190 = load double, double* %l16
  br label %loop.header33
loop.header33:
  br label %loop.body34
loop.body34:
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
  %t201 = call i1 @is_digit(i8* null)
  %t202 = xor i1 %t201, 1
  %t203 = load %LexerState, %LexerState* %l0
  %t204 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t205 = load i8, i8* %l2
  %t206 = load double, double* %l14
  %t207 = load double, double* %l15
  %t208 = load double, double* %l16
  br i1 %t202, label %then37, label %merge38
then37:
  br label %afterloop36
merge38:
  br label %loop.latch35
loop.latch35:
  br label %loop.header33
afterloop36:
  %t210 = load %LexerState, %LexerState* %l0
  %t211 = extractvalue %LexerState %t210, 1
  %t212 = load %LexerState, %LexerState* %l0
  %t213 = extractvalue %LexerState %t212, 0
  %t214 = load %LexerState, %LexerState* %l0
  %t215 = extractvalue %LexerState %t214, 0
  %t216 = load double, double* %l14
  %t217 = load %LexerState, %LexerState* %l0
  %t218 = extractvalue %LexerState %t217, 1
  %t219 = call i8* @slice(i8* %t215, double %t216, double %t218)
  store i8* %t219, i8** %l17
  br label %loop.latch2
merge32:
  %t220 = load i8, i8* %l2
  %t221 = call i1 @is_identifier_start(i8* null)
  %t222 = load %LexerState, %LexerState* %l0
  %t223 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t224 = load i8, i8* %l2
  br i1 %t221, label %then39, label %merge40
then39:
  %t225 = load %LexerState, %LexerState* %l0
  %t226 = extractvalue %LexerState %t225, 1
  store double %t226, double* %l18
  %t227 = load %LexerState, %LexerState* %l0
  %t228 = extractvalue %LexerState %t227, 2
  store double %t228, double* %l19
  %t229 = load %LexerState, %LexerState* %l0
  %t230 = extractvalue %LexerState %t229, 3
  store double %t230, double* %l20
  %t231 = load %LexerState, %LexerState* %l0
  %t232 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t233 = load i8, i8* %l2
  %t234 = load double, double* %l18
  %t235 = load double, double* %l19
  %t236 = load double, double* %l20
  br label %loop.header41
loop.header41:
  br label %loop.body42
loop.body42:
  %t237 = load %LexerState, %LexerState* %l0
  %t238 = extractvalue %LexerState %t237, 1
  %t239 = load %LexerState, %LexerState* %l0
  %t240 = extractvalue %LexerState %t239, 0
  %t241 = load %LexerState, %LexerState* %l0
  %t242 = extractvalue %LexerState %t241, 0
  %t243 = load %LexerState, %LexerState* %l0
  %t244 = extractvalue %LexerState %t243, 1
  %t245 = getelementptr i8, i8* %t242, i64 %t244
  %t246 = load i8, i8* %t245
  %t247 = call i1 @is_identifier_part(i8* null)
  %t248 = xor i1 %t247, 1
  %t249 = load %LexerState, %LexerState* %l0
  %t250 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t251 = load i8, i8* %l2
  %t252 = load double, double* %l18
  %t253 = load double, double* %l19
  %t254 = load double, double* %l20
  br i1 %t248, label %then45, label %merge46
then45:
  br label %afterloop44
merge46:
  br label %loop.latch43
loop.latch43:
  br label %loop.header41
afterloop44:
  %t255 = load %LexerState, %LexerState* %l0
  %t256 = extractvalue %LexerState %t255, 0
  %t257 = load double, double* %l18
  %t258 = load %LexerState, %LexerState* %l0
  %t259 = extractvalue %LexerState %t258, 1
  %t260 = call i8* @slice(i8* %t256, double %t257, double %t259)
  store i8* %t260, i8** %l21
  %t262 = load i8*, i8** %l21
  %s263 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.263, i32 0, i32 0
  %t264 = icmp eq i8* %t262, %s263
  br label %logical_or_entry_261

logical_or_entry_261:
  br i1 %t264, label %logical_or_merge_261, label %logical_or_right_261

logical_or_right_261:
  %t265 = load i8*, i8** %l21
  %s266 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.266, i32 0, i32 0
  %t267 = icmp eq i8* %t265, %s266
  br label %logical_or_right_end_261

logical_or_right_end_261:
  br label %logical_or_merge_261

logical_or_merge_261:
  %t268 = phi i1 [ true, %logical_or_entry_261 ], [ %t267, %logical_or_right_end_261 ]
  %t269 = load %LexerState, %LexerState* %l0
  %t270 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t271 = load i8, i8* %l2
  %t272 = load double, double* %l18
  %t273 = load double, double* %l19
  %t274 = load double, double* %l20
  %t275 = load i8*, i8** %l21
  br i1 %t268, label %then47, label %else48
then47:
  %t276 = load i8*, i8** %l21
  %s277 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.277, i32 0, i32 0
  %t278 = icmp eq i8* %t276, %s277
  store i1 %t278, i1* %l22
  br label %merge49
else48:
  br label %merge49
merge49:
  %t279 = phi { %Token*, i64 }* [ null, %then47 ], [ null, %else48 ]
  store { %Token*, i64 }* %t279, { %Token*, i64 }** %l1
  br label %loop.latch2
merge40:
  %t280 = load %LexerState, %LexerState* %l0
  %t281 = extractvalue %LexerState %t280, 2
  store double %t281, double* %l23
  %t282 = load %LexerState, %LexerState* %l0
  %t283 = extractvalue %LexerState %t282, 3
  store double %t283, double* %l24
  %t284 = load i8, i8* %l2
  store i8 %t284, i8* %l25
  %t285 = load %LexerState, %LexerState* %l0
  %t286 = call i8* @peek_next_char(%LexerState %t285)
  store i8* %t286, i8** %l26
  %t287 = load i8*, i8** %l26
  %s288 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.288, i32 0, i32 0
  %t289 = icmp ne i8* %t287, %s288
  %t290 = load %LexerState, %LexerState* %l0
  %t291 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t292 = load i8, i8* %l2
  %t293 = load double, double* %l23
  %t294 = load double, double* %l24
  %t295 = load i8, i8* %l25
  %t296 = load i8*, i8** %l26
  br i1 %t289, label %then50, label %merge51
then50:
  %t297 = load i8, i8* %l2
  %t298 = load i8*, i8** %l26
  %t299 = getelementptr i8, i8* %t298, i64 0
  %t300 = load i8, i8* %t299
  %t301 = add i8 %t297, %t300
  store i8 %t301, i8* %l27
  %t302 = load i8, i8* %l27
  %t303 = call i1 @is_two_char_symbol(i8* null)
  %t304 = load %LexerState, %LexerState* %l0
  %t305 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t306 = load i8, i8* %l2
  %t307 = load double, double* %l23
  %t308 = load double, double* %l24
  %t309 = load i8, i8* %l25
  %t310 = load i8*, i8** %l26
  %t311 = load i8, i8* %l27
  br i1 %t303, label %then52, label %merge53
then52:
  %t312 = load i8, i8* %l27
  store i8 %t312, i8* %l25
  br label %loop.latch2
merge53:
  br label %merge51
merge51:
  %t313 = phi i8 [ %t312, %then50 ], [ %t295, %loop.body1 ]
  %t314 = phi { %Token*, i64 }* [ null, %then50 ], [ %t291, %loop.body1 ]
  store i8 %t313, i8* %l25
  store { %Token*, i64 }* %t314, { %Token*, i64 }** %l1
  %t315 = load i8, i8* %l2
  %t316 = icmp eq i8 %t315, 10
  %t317 = load %LexerState, %LexerState* %l0
  %t318 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t319 = load i8, i8* %l2
  %t320 = load double, double* %l23
  %t321 = load double, double* %l24
  %t322 = load i8, i8* %l25
  %t323 = load i8*, i8** %l26
  br i1 %t316, label %then54, label %else55
then54:
  br label %merge56
else55:
  br label %merge56
merge56:
  br label %loop.latch2
loop.latch2:
  %t324 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br label %loop.header0
afterloop3:
  %t326 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t327 = load %LexerState, %LexerState* %l0
  %t328 = extractvalue %LexerState %t327, 2
  %t329 = load %LexerState, %LexerState* %l0
  %t330 = extractvalue %LexerState %t329, 3
  %t331 = call double @eof_token(double %t328, double %t330)
  %t332 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t326, %Token zeroinitializer)
  store { %Token*, i64 }* %t332, { %Token*, i64 }** %l1
  %t333 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  ret { %Token*, i64 }* %t333
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
  %t6 = call double @tokensconcat({ %Token*, i64 }* %t3)
  ret { %Token*, i64 }* null
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
