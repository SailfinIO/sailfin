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
  %t297 = phi { i8**, i64 }* [ %t6, %entry ], [ %t296, %loop.latch2 ]
  store { i8**, i64 }* %t297, { i8**, i64 }** %l1
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
  %t44 = call i1 @is_whitespace(i8* null)
  %t45 = xor i1 %t44, 1
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
  %t148 = phi i1 [ %t85, %then12 ], [ %t146, %loop.latch16 ]
  %t149 = phi i8* [ %t84, %then12 ], [ %t147, %loop.latch16 ]
  store i1 %t148, i1* %l11
  store i8* %t149, i8** %l10
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
  %t97 = load i1, i1* %l11
  br label %logical_and_entry_96

logical_and_entry_96:
  br i1 %t97, label %logical_and_right_96, label %logical_and_merge_96

logical_and_right_96:
  %t98 = load i8, i8* %l12
  %t99 = call i1 @is_double_quote(i8* null)
  br label %logical_and_right_end_96

logical_and_right_end_96:
  br label %logical_and_merge_96

logical_and_merge_96:
  %t100 = phi i1 [ false, %logical_and_entry_96 ], [ %t99, %logical_and_right_end_96 ]
  %t101 = xor i1 %t100, 1
  %t102 = load %LexerState, %LexerState* %l0
  %t103 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t104 = load i8, i8* %l2
  %t105 = load double, double* %l7
  %t106 = load double, double* %l8
  %t107 = load double, double* %l9
  %t108 = load i8*, i8** %l10
  %t109 = load i1, i1* %l11
  %t110 = load i8, i8* %l12
  br i1 %t101, label %then18, label %merge19
then18:
  br label %afterloop17
merge19:
  %t112 = load i1, i1* %l11
  br label %logical_and_entry_111

logical_and_entry_111:
  br i1 %t112, label %logical_and_right_111, label %logical_and_merge_111

logical_and_right_111:
  %t113 = load i8, i8* %l12
  %t114 = call i1 @is_backslash(i8* null)
  br label %logical_and_right_end_111

logical_and_right_end_111:
  br label %logical_and_merge_111

logical_and_merge_111:
  %t115 = phi i1 [ false, %logical_and_entry_111 ], [ %t114, %logical_and_right_end_111 ]
  %t116 = xor i1 %t115, 1
  %t117 = load %LexerState, %LexerState* %l0
  %t118 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t119 = load i8, i8* %l2
  %t120 = load double, double* %l7
  %t121 = load double, double* %l8
  %t122 = load double, double* %l9
  %t123 = load i8*, i8** %l10
  %t124 = load i1, i1* %l11
  %t125 = load i8, i8* %l12
  br i1 %t116, label %then20, label %merge21
then20:
  store i1 1, i1* %l11
  br label %loop.latch16
merge21:
  %t126 = load i1, i1* %l11
  %t127 = load %LexerState, %LexerState* %l0
  %t128 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t129 = load i8, i8* %l2
  %t130 = load double, double* %l7
  %t131 = load double, double* %l8
  %t132 = load double, double* %l9
  %t133 = load i8*, i8** %l10
  %t134 = load i1, i1* %l11
  %t135 = load i8, i8* %l12
  br i1 %t126, label %then22, label %else23
then22:
  %t136 = load i8*, i8** %l10
  %t137 = load i8, i8* %l12
  %t138 = call i8* @interpret_escape(i8* null)
  %t139 = add i8* %t136, %t138
  store i8* %t139, i8** %l10
  store i1 0, i1* %l11
  br label %merge24
else23:
  %t140 = load i8*, i8** %l10
  %t141 = load i8, i8* %l12
  br label %merge24
merge24:
  %t142 = phi i8* [ %t139, %then22 ], [ null, %else23 ]
  %t143 = phi i1 [ 0, %then22 ], [ %t134, %else23 ]
  store i8* %t142, i8** %l10
  store i1 %t143, i1* %l11
  %t144 = load i8, i8* %l12
  %s145 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.145, i32 0, i32 0
  br label %loop.latch16
loop.latch16:
  %t146 = load i1, i1* %l11
  %t147 = load i8*, i8** %l10
  br label %loop.header14
afterloop17:
  %t150 = load %LexerState, %LexerState* %l0
  %t151 = extractvalue %LexerState %t150, 0
  %t152 = load double, double* %l7
  %t153 = load %LexerState, %LexerState* %l0
  %t154 = extractvalue %LexerState %t153, 1
  %t155 = call i8* @slice(i8* %t151, double %t152, double %t154)
  store i8* %t155, i8** %l13
  br label %loop.latch2
merge13:
  %t156 = load i8, i8* %l2
  %t157 = call i1 @is_digit(i8* null)
  %t158 = load %LexerState, %LexerState* %l0
  %t159 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t160 = load i8, i8* %l2
  br i1 %t157, label %then25, label %merge26
then25:
  %t161 = load %LexerState, %LexerState* %l0
  %t162 = extractvalue %LexerState %t161, 1
  store double %t162, double* %l14
  %t163 = load %LexerState, %LexerState* %l0
  %t164 = extractvalue %LexerState %t163, 2
  store double %t164, double* %l15
  %t165 = load %LexerState, %LexerState* %l0
  %t166 = extractvalue %LexerState %t165, 3
  store double %t166, double* %l16
  %t167 = load %LexerState, %LexerState* %l0
  %t168 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t169 = load i8, i8* %l2
  %t170 = load double, double* %l14
  %t171 = load double, double* %l15
  %t172 = load double, double* %l16
  br label %loop.header27
loop.header27:
  br label %loop.body28
loop.body28:
  %t173 = load %LexerState, %LexerState* %l0
  %t174 = extractvalue %LexerState %t173, 1
  %t175 = load %LexerState, %LexerState* %l0
  %t176 = extractvalue %LexerState %t175, 0
  %t177 = load %LexerState, %LexerState* %l0
  %t178 = extractvalue %LexerState %t177, 0
  %t179 = load %LexerState, %LexerState* %l0
  %t180 = extractvalue %LexerState %t179, 1
  %t181 = getelementptr i8, i8* %t178, i64 %t180
  %t182 = load i8, i8* %t181
  %t183 = call i1 @is_digit(i8* null)
  %t184 = xor i1 %t183, 1
  %t185 = load %LexerState, %LexerState* %l0
  %t186 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t187 = load i8, i8* %l2
  %t188 = load double, double* %l14
  %t189 = load double, double* %l15
  %t190 = load double, double* %l16
  br i1 %t184, label %then31, label %merge32
then31:
  br label %afterloop30
merge32:
  br label %loop.latch29
loop.latch29:
  br label %loop.header27
afterloop30:
  %t192 = load %LexerState, %LexerState* %l0
  %t193 = extractvalue %LexerState %t192, 1
  %t194 = load %LexerState, %LexerState* %l0
  %t195 = extractvalue %LexerState %t194, 0
  %t196 = load %LexerState, %LexerState* %l0
  %t197 = extractvalue %LexerState %t196, 0
  %t198 = load double, double* %l14
  %t199 = load %LexerState, %LexerState* %l0
  %t200 = extractvalue %LexerState %t199, 1
  %t201 = call i8* @slice(i8* %t197, double %t198, double %t200)
  store i8* %t201, i8** %l17
  br label %loop.latch2
merge26:
  %t202 = load i8, i8* %l2
  %t203 = call i1 @is_identifier_start(i8* null)
  %t204 = load %LexerState, %LexerState* %l0
  %t205 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t206 = load i8, i8* %l2
  br i1 %t203, label %then33, label %merge34
then33:
  %t207 = load %LexerState, %LexerState* %l0
  %t208 = extractvalue %LexerState %t207, 1
  store double %t208, double* %l18
  %t209 = load %LexerState, %LexerState* %l0
  %t210 = extractvalue %LexerState %t209, 2
  store double %t210, double* %l19
  %t211 = load %LexerState, %LexerState* %l0
  %t212 = extractvalue %LexerState %t211, 3
  store double %t212, double* %l20
  %t213 = load %LexerState, %LexerState* %l0
  %t214 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t215 = load i8, i8* %l2
  %t216 = load double, double* %l18
  %t217 = load double, double* %l19
  %t218 = load double, double* %l20
  br label %loop.header35
loop.header35:
  br label %loop.body36
loop.body36:
  %t219 = load %LexerState, %LexerState* %l0
  %t220 = extractvalue %LexerState %t219, 1
  %t221 = load %LexerState, %LexerState* %l0
  %t222 = extractvalue %LexerState %t221, 0
  %t223 = load %LexerState, %LexerState* %l0
  %t224 = extractvalue %LexerState %t223, 0
  %t225 = load %LexerState, %LexerState* %l0
  %t226 = extractvalue %LexerState %t225, 1
  %t227 = getelementptr i8, i8* %t224, i64 %t226
  %t228 = load i8, i8* %t227
  %t229 = call i1 @is_identifier_part(i8* null)
  %t230 = xor i1 %t229, 1
  %t231 = load %LexerState, %LexerState* %l0
  %t232 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t233 = load i8, i8* %l2
  %t234 = load double, double* %l18
  %t235 = load double, double* %l19
  %t236 = load double, double* %l20
  br i1 %t230, label %then39, label %merge40
then39:
  br label %afterloop38
merge40:
  br label %loop.latch37
loop.latch37:
  br label %loop.header35
afterloop38:
  %t237 = load %LexerState, %LexerState* %l0
  %t238 = extractvalue %LexerState %t237, 0
  %t239 = load double, double* %l18
  %t240 = load %LexerState, %LexerState* %l0
  %t241 = extractvalue %LexerState %t240, 1
  %t242 = call i8* @slice(i8* %t238, double %t239, double %t241)
  store i8* %t242, i8** %l21
  %t244 = load i8*, i8** %l21
  %s245 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.245, i32 0, i32 0
  %t246 = icmp eq i8* %t244, %s245
  br label %logical_or_entry_243

logical_or_entry_243:
  br i1 %t246, label %logical_or_merge_243, label %logical_or_right_243

logical_or_right_243:
  %t247 = load i8*, i8** %l21
  %s248 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.248, i32 0, i32 0
  %t249 = icmp eq i8* %t247, %s248
  br label %logical_or_right_end_243

logical_or_right_end_243:
  br label %logical_or_merge_243

logical_or_merge_243:
  %t250 = phi i1 [ true, %logical_or_entry_243 ], [ %t249, %logical_or_right_end_243 ]
  %t251 = load %LexerState, %LexerState* %l0
  %t252 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t253 = load i8, i8* %l2
  %t254 = load double, double* %l18
  %t255 = load double, double* %l19
  %t256 = load double, double* %l20
  %t257 = load i8*, i8** %l21
  br i1 %t250, label %then41, label %else42
then41:
  %t258 = load i8*, i8** %l21
  %s259 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.259, i32 0, i32 0
  %t260 = icmp eq i8* %t258, %s259
  store i1 %t260, i1* %l22
  br label %merge43
else42:
  br label %merge43
merge43:
  %t261 = phi { i8**, i64 }* [ null, %then41 ], [ null, %else42 ]
  store { i8**, i64 }* %t261, { i8**, i64 }** %l1
  br label %loop.latch2
merge34:
  %t262 = load %LexerState, %LexerState* %l0
  %t263 = extractvalue %LexerState %t262, 2
  store double %t263, double* %l23
  %t264 = load %LexerState, %LexerState* %l0
  %t265 = extractvalue %LexerState %t264, 3
  store double %t265, double* %l24
  %t266 = load i8, i8* %l2
  store i8 %t266, i8* %l25
  %t267 = load %LexerState, %LexerState* %l0
  %t268 = call i8* @peek_next_char(%LexerState %t267)
  store i8* %t268, i8** %l26
  %t269 = load i8*, i8** %l26
  %s270 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.270, i32 0, i32 0
  %t271 = icmp ne i8* %t269, %s270
  %t272 = load %LexerState, %LexerState* %l0
  %t273 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t274 = load i8, i8* %l2
  %t275 = load double, double* %l23
  %t276 = load double, double* %l24
  %t277 = load i8, i8* %l25
  %t278 = load i8*, i8** %l26
  br i1 %t271, label %then44, label %merge45
then44:
  %t279 = load i8, i8* %l2
  %t280 = load i8*, i8** %l26
  store double 0.0, double* %l27
  %t281 = load double, double* %l27
  %t282 = call i1 @is_two_char_symbol(i8* null)
  %t283 = load %LexerState, %LexerState* %l0
  %t284 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t285 = load i8, i8* %l2
  %t286 = load double, double* %l23
  %t287 = load double, double* %l24
  %t288 = load i8, i8* %l25
  %t289 = load i8*, i8** %l26
  %t290 = load double, double* %l27
  br i1 %t282, label %then46, label %merge47
then46:
  %t291 = load double, double* %l27
  store i8 zeroinitializer, i8* %l25
  br label %loop.latch2
merge47:
  br label %merge45
merge45:
  %t292 = phi i8 [ zeroinitializer, %then44 ], [ %t277, %loop.body1 ]
  %t293 = phi { i8**, i64 }* [ null, %then44 ], [ %t273, %loop.body1 ]
  store i8 %t292, i8* %l25
  store { i8**, i64 }* %t293, { i8**, i64 }** %l1
  %t294 = load i8, i8* %l2
  %s295 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.295, i32 0, i32 0
  br label %loop.latch2
loop.latch2:
  %t296 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %loop.header0
afterloop3:
  %t298 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t299 = load %LexerState, %LexerState* %l0
  %t300 = extractvalue %LexerState %t299, 2
  %t301 = load %LexerState, %LexerState* %l0
  %t302 = extractvalue %LexerState %t301, 3
  %t303 = call double @eof_token(double %t300, double %t302)
  %t304 = call { i8**, i64 }* @append({ i8**, i64 }* %t298, i8* null)
  store { i8**, i64 }* %t304, { i8**, i64 }** %l1
  %t305 = load { i8**, i64 }*, { i8**, i64 }** %l1
  ret { i8**, i64 }* %t305
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
