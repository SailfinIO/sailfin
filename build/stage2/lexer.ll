; ModuleID = 'sailfin'
source_filename = "sailfin"

%LexerState = type { i8*, double, double, double }
%Token = type { %TokenKind, i8*, double, double }

%TokenKind = type { i32, [8 x i8] }

declare i8* @sailfin_runtime_substring(i8*, i64, i64)
declare double @char_code(i8*)

declare noalias i8* @malloc(i64)

@runtime = external global i8**

@.str.1 = private unnamed_addr constant [3 x i8] c"->\00"
@.str.4 = private unnamed_addr constant [3 x i8] c"=>\00"
@.str.7 = private unnamed_addr constant [3 x i8] c"==\00"
@.str.10 = private unnamed_addr constant [3 x i8] c"!=\00"
@.str.13 = private unnamed_addr constant [3 x i8] c"<=\00"
@.str.16 = private unnamed_addr constant [3 x i8] c">=\00"
@.str.19 = private unnamed_addr constant [3 x i8] c"&&\00"
@.str.22 = private unnamed_addr constant [3 x i8] c"||\00"
@.str.24 = private unnamed_addr constant [3 x i8] c"..\00"

define { %Token*, i64 }* @lex(i8* %source) {
entry:
  %l0 = alloca %LexerState
  %l1 = alloca { %Token*, i64 }*
  %l2 = alloca i8
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca i8*
  %l7 = alloca i8*
  %l8 = alloca double
  %l9 = alloca double
  %l10 = alloca double
  %l11 = alloca double
  %l12 = alloca double
  %l13 = alloca double
  %l14 = alloca i8*
  %l15 = alloca double
  %l16 = alloca double
  %l17 = alloca double
  %l18 = alloca double
  %l19 = alloca i8*
  %l20 = alloca double
  %l21 = alloca double
  %l22 = alloca double
  %l23 = alloca i8*
  %l24 = alloca i1
  %l25 = alloca i8
  %l26 = alloca i8*
  %l27 = alloca double
  %l28 = alloca double
  %l29 = alloca double
  %l30 = alloca i1
  %l31 = alloca i8*
  %l32 = alloca double
  %l33 = alloca double
  %l34 = alloca double
  %l35 = alloca i8*
  %l36 = alloca double
  %l37 = alloca double
  %l38 = alloca i8
  %l39 = alloca i8*
  %l40 = alloca i8
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
  %t1076 = phi { %Token*, i64 }* [ %t13, %entry ], [ %t1075, %loop.latch2 ]
  store { %Token*, i64 }* %t1076, { %Token*, i64 }** %l1
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
  %t97 = load %LexerState, %LexerState* %l0
  %t98 = extractvalue %LexerState %t97, 1
  %t99 = sitofp i64 1 to double
  %t100 = fadd double %t98, %t99
  %t101 = load %LexerState, %LexerState* %l0
  %t102 = getelementptr %LexerState, %LexerState %t101, i32 0, i32 1
  store double %t100, double* %t102
  %t103 = load %LexerState, %LexerState* %l0
  %t104 = extractvalue %LexerState %t103, 2
  %t105 = sitofp i64 1 to double
  %t106 = fadd double %t104, %t105
  %t107 = load %LexerState, %LexerState* %l0
  %t108 = getelementptr %LexerState, %LexerState %t107, i32 0, i32 2
  store double %t106, double* %t108
  %t109 = load %LexerState, %LexerState* %l0
  %t110 = sitofp i64 1 to double
  %t111 = getelementptr %LexerState, %LexerState %t109, i32 0, i32 3
  store double %t110, double* %t111
  br label %merge18
else17:
  %t112 = load %LexerState, %LexerState* %l0
  %t113 = extractvalue %LexerState %t112, 1
  %t114 = sitofp i64 1 to double
  %t115 = fadd double %t113, %t114
  %t116 = load %LexerState, %LexerState* %l0
  %t117 = getelementptr %LexerState, %LexerState %t116, i32 0, i32 1
  store double %t115, double* %t117
  %t118 = load %LexerState, %LexerState* %l0
  %t119 = extractvalue %LexerState %t118, 3
  %t120 = sitofp i64 1 to double
  %t121 = fadd double %t119, %t120
  %t122 = load %LexerState, %LexerState* %l0
  %t123 = getelementptr %LexerState, %LexerState %t122, i32 0, i32 3
  store double %t121, double* %t123
  br label %merge18
merge18:
  br label %loop.latch10
loop.latch10:
  br label %loop.header8
afterloop11:
  %t124 = load %LexerState, %LexerState* %l0
  %t125 = extractvalue %LexerState %t124, 0
  %t126 = load double, double* %l3
  %t127 = load %LexerState, %LexerState* %l0
  %t128 = extractvalue %LexerState %t127, 1
  %t129 = call i8* @slice(i8* %t125, double %t126, double %t128)
  store i8* %t129, i8** %l6
  %t130 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t131 = insertvalue %TokenKind undef, i32 5, 0
  %t132 = insertvalue %Token undef, %TokenKind %t131, 0
  %t133 = load i8*, i8** %l6
  %t134 = insertvalue %Token %t132, i8* %t133, 1
  %t135 = load double, double* %l4
  %t136 = insertvalue %Token %t134, double %t135, 2
  %t137 = load double, double* %l5
  %t138 = insertvalue %Token %t136, double %t137, 3
  %t139 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t130, %Token %t138)
  store { %Token*, i64 }* %t139, { %Token*, i64 }** %l1
  br label %loop.latch2
merge7:
  %t140 = load i8, i8* %l2
  %t141 = icmp eq i8 %t140, 47
  %t142 = load %LexerState, %LexerState* %l0
  %t143 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t144 = load i8, i8* %l2
  br i1 %t141, label %then19, label %merge20
then19:
  %t145 = load %LexerState, %LexerState* %l0
  %t146 = call i8* @peek_next_char(%LexerState %t145)
  store i8* %t146, i8** %l7
  %t147 = load i8*, i8** %l7
  %t148 = load i8, i8* %t147
  %t149 = icmp eq i8 %t148, 47
  %t150 = load %LexerState, %LexerState* %l0
  %t151 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t152 = load i8, i8* %l2
  %t153 = load i8*, i8** %l7
  br i1 %t149, label %then21, label %merge22
then21:
  %t154 = load %LexerState, %LexerState* %l0
  %t155 = extractvalue %LexerState %t154, 1
  store double %t155, double* %l8
  %t156 = load %LexerState, %LexerState* %l0
  %t157 = extractvalue %LexerState %t156, 2
  store double %t157, double* %l9
  %t158 = load %LexerState, %LexerState* %l0
  %t159 = extractvalue %LexerState %t158, 3
  store double %t159, double* %l10
  %t160 = load %LexerState, %LexerState* %l0
  %t161 = extractvalue %LexerState %t160, 1
  %t162 = sitofp i64 2 to double
  %t163 = fadd double %t161, %t162
  %t164 = load %LexerState, %LexerState* %l0
  %t165 = getelementptr %LexerState, %LexerState %t164, i32 0, i32 1
  store double %t163, double* %t165
  %t166 = load %LexerState, %LexerState* %l0
  %t167 = extractvalue %LexerState %t166, 3
  %t168 = sitofp i64 2 to double
  %t169 = fadd double %t167, %t168
  %t170 = load %LexerState, %LexerState* %l0
  %t171 = getelementptr %LexerState, %LexerState %t170, i32 0, i32 3
  store double %t169, double* %t171
  %t172 = load %LexerState, %LexerState* %l0
  %t173 = extractvalue %LexerState %t172, 0
  %t174 = load %LexerState, %LexerState* %l0
  %t175 = extractvalue %LexerState %t174, 1
  %t176 = call double @find_char(i8* %t173, i8 10, double %t175)
  store double %t176, double* %l11
  %t177 = load %LexerState, %LexerState* %l0
  %t178 = extractvalue %LexerState %t177, 0
  %t179 = load %LexerState, %LexerState* %l0
  %t180 = extractvalue %LexerState %t179, 1
  %t181 = call double @find_char(i8* %t178, i8 13, double %t180)
  store double %t181, double* %l12
  %t182 = load %LexerState, %LexerState* %l0
  %t183 = extractvalue %LexerState %t182, 0
  %t184 = call i64 @sailfin_runtime_string_length(i8* %t183)
  %t185 = sitofp i64 %t184 to double
  store double %t185, double* %l13
  %t186 = load double, double* %l11
  %t187 = sitofp i64 -1 to double
  %t188 = fcmp une double %t186, %t187
  %t189 = load %LexerState, %LexerState* %l0
  %t190 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t191 = load i8, i8* %l2
  %t192 = load i8*, i8** %l7
  %t193 = load double, double* %l8
  %t194 = load double, double* %l9
  %t195 = load double, double* %l10
  %t196 = load double, double* %l11
  %t197 = load double, double* %l12
  %t198 = load double, double* %l13
  br i1 %t188, label %then23, label %merge24
then23:
  %t199 = load double, double* %l11
  store double %t199, double* %l13
  br label %merge24
merge24:
  %t200 = phi double [ %t199, %then23 ], [ %t198, %then21 ]
  store double %t200, double* %l13
  %t202 = load double, double* %l12
  %t203 = sitofp i64 -1 to double
  %t204 = fcmp une double %t202, %t203
  br label %logical_and_entry_201

logical_and_entry_201:
  br i1 %t204, label %logical_and_right_201, label %logical_and_merge_201

logical_and_right_201:
  %t205 = load double, double* %l12
  %t206 = load double, double* %l13
  %t207 = fcmp olt double %t205, %t206
  br label %logical_and_right_end_201

logical_and_right_end_201:
  br label %logical_and_merge_201

logical_and_merge_201:
  %t208 = phi i1 [ false, %logical_and_entry_201 ], [ %t207, %logical_and_right_end_201 ]
  %t209 = load %LexerState, %LexerState* %l0
  %t210 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t211 = load i8, i8* %l2
  %t212 = load i8*, i8** %l7
  %t213 = load double, double* %l8
  %t214 = load double, double* %l9
  %t215 = load double, double* %l10
  %t216 = load double, double* %l11
  %t217 = load double, double* %l12
  %t218 = load double, double* %l13
  br i1 %t208, label %then25, label %merge26
then25:
  %t219 = load double, double* %l12
  store double %t219, double* %l13
  br label %merge26
merge26:
  %t220 = phi double [ %t219, %then25 ], [ %t218, %then21 ]
  store double %t220, double* %l13
  %t221 = load %LexerState, %LexerState* %l0
  %t222 = extractvalue %LexerState %t221, 0
  %t223 = load double, double* %l8
  %t224 = load double, double* %l13
  %t225 = call i8* @slice(i8* %t222, double %t223, double %t224)
  store i8* %t225, i8** %l14
  %t226 = load double, double* %l13
  %t227 = load %LexerState, %LexerState* %l0
  %t228 = extractvalue %LexerState %t227, 1
  %t229 = fsub double %t226, %t228
  store double %t229, double* %l15
  %t230 = load double, double* %l13
  %t231 = load %LexerState, %LexerState* %l0
  %t232 = getelementptr %LexerState, %LexerState %t231, i32 0, i32 1
  store double %t230, double* %t232
  %t233 = load %LexerState, %LexerState* %l0
  %t234 = extractvalue %LexerState %t233, 3
  %t235 = load double, double* %l15
  %t236 = fadd double %t234, %t235
  %t237 = load %LexerState, %LexerState* %l0
  %t238 = getelementptr %LexerState, %LexerState %t237, i32 0, i32 3
  store double %t236, double* %t238
  %t239 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t240 = insertvalue %TokenKind undef, i32 6, 0
  %t241 = insertvalue %Token undef, %TokenKind %t240, 0
  %t242 = load i8*, i8** %l14
  %t243 = insertvalue %Token %t241, i8* %t242, 1
  %t244 = load double, double* %l9
  %t245 = insertvalue %Token %t243, double %t244, 2
  %t246 = load double, double* %l10
  %t247 = insertvalue %Token %t245, double %t246, 3
  %t248 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t239, %Token %t247)
  store { %Token*, i64 }* %t248, { %Token*, i64 }** %l1
  br label %loop.latch2
merge22:
  %t249 = load i8*, i8** %l7
  %t250 = load i8, i8* %t249
  %t251 = icmp eq i8 %t250, 42
  %t252 = load %LexerState, %LexerState* %l0
  %t253 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t254 = load i8, i8* %l2
  %t255 = load i8*, i8** %l7
  br i1 %t251, label %then27, label %merge28
then27:
  %t256 = load %LexerState, %LexerState* %l0
  %t257 = extractvalue %LexerState %t256, 1
  store double %t257, double* %l16
  %t258 = load %LexerState, %LexerState* %l0
  %t259 = extractvalue %LexerState %t258, 2
  store double %t259, double* %l17
  %t260 = load %LexerState, %LexerState* %l0
  %t261 = extractvalue %LexerState %t260, 3
  store double %t261, double* %l18
  %t262 = load %LexerState, %LexerState* %l0
  %t263 = extractvalue %LexerState %t262, 1
  %t264 = sitofp i64 2 to double
  %t265 = fadd double %t263, %t264
  %t266 = load %LexerState, %LexerState* %l0
  %t267 = getelementptr %LexerState, %LexerState %t266, i32 0, i32 1
  store double %t265, double* %t267
  %t268 = load %LexerState, %LexerState* %l0
  %t269 = extractvalue %LexerState %t268, 3
  %t270 = sitofp i64 2 to double
  %t271 = fadd double %t269, %t270
  %t272 = load %LexerState, %LexerState* %l0
  %t273 = getelementptr %LexerState, %LexerState %t272, i32 0, i32 3
  store double %t271, double* %t273
  %t274 = load %LexerState, %LexerState* %l0
  %t275 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t276 = load i8, i8* %l2
  %t277 = load i8*, i8** %l7
  %t278 = load double, double* %l16
  %t279 = load double, double* %l17
  %t280 = load double, double* %l18
  br label %loop.header29
loop.header29:
  br label %loop.body30
loop.body30:
  %t281 = load %LexerState, %LexerState* %l0
  %t282 = extractvalue %LexerState %t281, 1
  %t283 = load %LexerState, %LexerState* %l0
  %t284 = extractvalue %LexerState %t283, 0
  %t285 = call i64 @sailfin_runtime_string_length(i8* %t284)
  %t286 = sitofp i64 %t285 to double
  %t287 = fcmp oge double %t282, %t286
  %t288 = load %LexerState, %LexerState* %l0
  %t289 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t290 = load i8, i8* %l2
  %t291 = load i8*, i8** %l7
  %t292 = load double, double* %l16
  %t293 = load double, double* %l17
  %t294 = load double, double* %l18
  br i1 %t287, label %then33, label %merge34
then33:
  br label %afterloop32
merge34:
  %t296 = load %LexerState, %LexerState* %l0
  %t297 = extractvalue %LexerState %t296, 0
  %t298 = load %LexerState, %LexerState* %l0
  %t299 = extractvalue %LexerState %t298, 1
  %t300 = fptosi double %t299 to i64
  %t301 = getelementptr i8, i8* %t297, i64 %t300
  %t302 = load i8, i8* %t301
  %t303 = icmp eq i8 %t302, 42
  br label %logical_and_entry_295

logical_and_entry_295:
  br i1 %t303, label %logical_and_right_295, label %logical_and_merge_295

logical_and_right_295:
  %t304 = load %LexerState, %LexerState* %l0
  %t305 = call i8* @peek_next_char(%LexerState %t304)
  %t306 = load i8, i8* %t305
  %t307 = icmp eq i8 %t306, 47
  br label %logical_and_right_end_295

logical_and_right_end_295:
  br label %logical_and_merge_295

logical_and_merge_295:
  %t308 = phi i1 [ false, %logical_and_entry_295 ], [ %t307, %logical_and_right_end_295 ]
  %t309 = load %LexerState, %LexerState* %l0
  %t310 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t311 = load i8, i8* %l2
  %t312 = load i8*, i8** %l7
  %t313 = load double, double* %l16
  %t314 = load double, double* %l17
  %t315 = load double, double* %l18
  br i1 %t308, label %then35, label %merge36
then35:
  %t316 = load %LexerState, %LexerState* %l0
  %t317 = extractvalue %LexerState %t316, 1
  %t318 = sitofp i64 2 to double
  %t319 = fadd double %t317, %t318
  %t320 = load %LexerState, %LexerState* %l0
  %t321 = getelementptr %LexerState, %LexerState %t320, i32 0, i32 1
  store double %t319, double* %t321
  %t322 = load %LexerState, %LexerState* %l0
  %t323 = extractvalue %LexerState %t322, 3
  %t324 = sitofp i64 2 to double
  %t325 = fadd double %t323, %t324
  %t326 = load %LexerState, %LexerState* %l0
  %t327 = getelementptr %LexerState, %LexerState %t326, i32 0, i32 3
  store double %t325, double* %t327
  br label %afterloop32
merge36:
  %t328 = load %LexerState, %LexerState* %l0
  %t329 = extractvalue %LexerState %t328, 0
  %t330 = load %LexerState, %LexerState* %l0
  %t331 = extractvalue %LexerState %t330, 1
  %t332 = fptosi double %t331 to i64
  %t333 = getelementptr i8, i8* %t329, i64 %t332
  %t334 = load i8, i8* %t333
  %t335 = icmp eq i8 %t334, 10
  %t336 = load %LexerState, %LexerState* %l0
  %t337 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t338 = load i8, i8* %l2
  %t339 = load i8*, i8** %l7
  %t340 = load double, double* %l16
  %t341 = load double, double* %l17
  %t342 = load double, double* %l18
  br i1 %t335, label %then37, label %else38
then37:
  %t343 = load %LexerState, %LexerState* %l0
  %t344 = extractvalue %LexerState %t343, 1
  %t345 = sitofp i64 1 to double
  %t346 = fadd double %t344, %t345
  %t347 = load %LexerState, %LexerState* %l0
  %t348 = getelementptr %LexerState, %LexerState %t347, i32 0, i32 1
  store double %t346, double* %t348
  %t349 = load %LexerState, %LexerState* %l0
  %t350 = extractvalue %LexerState %t349, 2
  %t351 = sitofp i64 1 to double
  %t352 = fadd double %t350, %t351
  %t353 = load %LexerState, %LexerState* %l0
  %t354 = getelementptr %LexerState, %LexerState %t353, i32 0, i32 2
  store double %t352, double* %t354
  %t355 = load %LexerState, %LexerState* %l0
  %t356 = sitofp i64 1 to double
  %t357 = getelementptr %LexerState, %LexerState %t355, i32 0, i32 3
  store double %t356, double* %t357
  br label %merge39
else38:
  %t358 = load %LexerState, %LexerState* %l0
  %t359 = extractvalue %LexerState %t358, 1
  %t360 = sitofp i64 1 to double
  %t361 = fadd double %t359, %t360
  %t362 = load %LexerState, %LexerState* %l0
  %t363 = getelementptr %LexerState, %LexerState %t362, i32 0, i32 1
  store double %t361, double* %t363
  %t364 = load %LexerState, %LexerState* %l0
  %t365 = extractvalue %LexerState %t364, 3
  %t366 = sitofp i64 1 to double
  %t367 = fadd double %t365, %t366
  %t368 = load %LexerState, %LexerState* %l0
  %t369 = getelementptr %LexerState, %LexerState %t368, i32 0, i32 3
  store double %t367, double* %t369
  br label %merge39
merge39:
  br label %loop.latch31
loop.latch31:
  br label %loop.header29
afterloop32:
  %t370 = load %LexerState, %LexerState* %l0
  %t371 = extractvalue %LexerState %t370, 0
  %t372 = load double, double* %l16
  %t373 = load %LexerState, %LexerState* %l0
  %t374 = extractvalue %LexerState %t373, 1
  %t375 = call i8* @slice(i8* %t371, double %t372, double %t374)
  store i8* %t375, i8** %l19
  %t376 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t377 = insertvalue %TokenKind undef, i32 6, 0
  %t378 = insertvalue %Token undef, %TokenKind %t377, 0
  %t379 = load i8*, i8** %l19
  %t380 = insertvalue %Token %t378, i8* %t379, 1
  %t381 = load double, double* %l17
  %t382 = insertvalue %Token %t380, double %t381, 2
  %t383 = load double, double* %l18
  %t384 = insertvalue %Token %t382, double %t383, 3
  %t385 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t376, %Token %t384)
  store { %Token*, i64 }* %t385, { %Token*, i64 }** %l1
  br label %loop.latch2
merge28:
  br label %merge20
merge20:
  %t386 = phi { %Token*, i64 }* [ %t248, %then19 ], [ %t143, %loop.body1 ]
  %t387 = phi { %Token*, i64 }* [ %t385, %then19 ], [ %t143, %loop.body1 ]
  store { %Token*, i64 }* %t386, { %Token*, i64 }** %l1
  store { %Token*, i64 }* %t387, { %Token*, i64 }** %l1
  %t388 = load i8, i8* %l2
  %t389 = alloca [2 x i8], align 1
  %t390 = getelementptr [2 x i8], [2 x i8]* %t389, i32 0, i32 0
  store i8 %t388, i8* %t390
  %t391 = getelementptr [2 x i8], [2 x i8]* %t389, i32 0, i32 1
  store i8 0, i8* %t391
  %t392 = getelementptr [2 x i8], [2 x i8]* %t389, i32 0, i32 0
  %t393 = call i1 @is_double_quote(i8* %t392)
  %t394 = load %LexerState, %LexerState* %l0
  %t395 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t396 = load i8, i8* %l2
  br i1 %t393, label %then40, label %merge41
then40:
  %t397 = load %LexerState, %LexerState* %l0
  %t398 = extractvalue %LexerState %t397, 1
  store double %t398, double* %l20
  %t399 = load %LexerState, %LexerState* %l0
  %t400 = extractvalue %LexerState %t399, 2
  store double %t400, double* %l21
  %t401 = load %LexerState, %LexerState* %l0
  %t402 = extractvalue %LexerState %t401, 3
  store double %t402, double* %l22
  %t403 = load %LexerState, %LexerState* %l0
  %t404 = extractvalue %LexerState %t403, 1
  %t405 = sitofp i64 1 to double
  %t406 = fadd double %t404, %t405
  %t407 = load %LexerState, %LexerState* %l0
  %t408 = getelementptr %LexerState, %LexerState %t407, i32 0, i32 1
  store double %t406, double* %t408
  %t409 = load %LexerState, %LexerState* %l0
  %t410 = extractvalue %LexerState %t409, 3
  %t411 = sitofp i64 1 to double
  %t412 = fadd double %t410, %t411
  %t413 = load %LexerState, %LexerState* %l0
  %t414 = getelementptr %LexerState, %LexerState %t413, i32 0, i32 3
  store double %t412, double* %t414
  %s415 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.415, i32 0, i32 0
  store i8* %s415, i8** %l23
  store i1 0, i1* %l24
  %t416 = load %LexerState, %LexerState* %l0
  %t417 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t418 = load i8, i8* %l2
  %t419 = load double, double* %l20
  %t420 = load double, double* %l21
  %t421 = load double, double* %l22
  %t422 = load i8*, i8** %l23
  %t423 = load i1, i1* %l24
  br label %loop.header42
loop.header42:
  %t576 = phi i1 [ %t423, %then40 ], [ %t574, %loop.latch44 ]
  %t577 = phi i8* [ %t422, %then40 ], [ %t575, %loop.latch44 ]
  store i1 %t576, i1* %l24
  store i8* %t577, i8** %l23
  br label %loop.body43
loop.body43:
  %t424 = load %LexerState, %LexerState* %l0
  %t425 = extractvalue %LexerState %t424, 1
  %t426 = load %LexerState, %LexerState* %l0
  %t427 = extractvalue %LexerState %t426, 0
  %t428 = call i64 @sailfin_runtime_string_length(i8* %t427)
  %t429 = sitofp i64 %t428 to double
  %t430 = fcmp oge double %t425, %t429
  %t431 = load %LexerState, %LexerState* %l0
  %t432 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t433 = load i8, i8* %l2
  %t434 = load double, double* %l20
  %t435 = load double, double* %l21
  %t436 = load double, double* %l22
  %t437 = load i8*, i8** %l23
  %t438 = load i1, i1* %l24
  br i1 %t430, label %then46, label %merge47
then46:
  br label %afterloop45
merge47:
  %t439 = load %LexerState, %LexerState* %l0
  %t440 = extractvalue %LexerState %t439, 0
  %t441 = load %LexerState, %LexerState* %l0
  %t442 = extractvalue %LexerState %t441, 1
  %t443 = fptosi double %t442 to i64
  %t444 = getelementptr i8, i8* %t440, i64 %t443
  %t445 = load i8, i8* %t444
  store i8 %t445, i8* %l25
  %t447 = load i1, i1* %l24
  br label %logical_and_entry_446

logical_and_entry_446:
  br i1 %t447, label %logical_and_right_446, label %logical_and_merge_446

logical_and_right_446:
  %t448 = load i8, i8* %l25
  %t449 = alloca [2 x i8], align 1
  %t450 = getelementptr [2 x i8], [2 x i8]* %t449, i32 0, i32 0
  store i8 %t448, i8* %t450
  %t451 = getelementptr [2 x i8], [2 x i8]* %t449, i32 0, i32 1
  store i8 0, i8* %t451
  %t452 = getelementptr [2 x i8], [2 x i8]* %t449, i32 0, i32 0
  %t453 = call i1 @is_double_quote(i8* %t452)
  br label %logical_and_right_end_446

logical_and_right_end_446:
  br label %logical_and_merge_446

logical_and_merge_446:
  %t454 = phi i1 [ false, %logical_and_entry_446 ], [ %t453, %logical_and_right_end_446 ]
  %t455 = xor i1 %t454, 1
  %t456 = load %LexerState, %LexerState* %l0
  %t457 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t458 = load i8, i8* %l2
  %t459 = load double, double* %l20
  %t460 = load double, double* %l21
  %t461 = load double, double* %l22
  %t462 = load i8*, i8** %l23
  %t463 = load i1, i1* %l24
  %t464 = load i8, i8* %l25
  br i1 %t455, label %then48, label %merge49
then48:
  %t465 = load %LexerState, %LexerState* %l0
  %t466 = extractvalue %LexerState %t465, 1
  %t467 = sitofp i64 1 to double
  %t468 = fadd double %t466, %t467
  %t469 = load %LexerState, %LexerState* %l0
  %t470 = getelementptr %LexerState, %LexerState %t469, i32 0, i32 1
  store double %t468, double* %t470
  %t471 = load %LexerState, %LexerState* %l0
  %t472 = extractvalue %LexerState %t471, 3
  %t473 = sitofp i64 1 to double
  %t474 = fadd double %t472, %t473
  %t475 = load %LexerState, %LexerState* %l0
  %t476 = getelementptr %LexerState, %LexerState %t475, i32 0, i32 3
  store double %t474, double* %t476
  br label %afterloop45
merge49:
  %t478 = load i1, i1* %l24
  br label %logical_and_entry_477

logical_and_entry_477:
  br i1 %t478, label %logical_and_right_477, label %logical_and_merge_477

logical_and_right_477:
  %t479 = load i8, i8* %l25
  %t480 = alloca [2 x i8], align 1
  %t481 = getelementptr [2 x i8], [2 x i8]* %t480, i32 0, i32 0
  store i8 %t479, i8* %t481
  %t482 = getelementptr [2 x i8], [2 x i8]* %t480, i32 0, i32 1
  store i8 0, i8* %t482
  %t483 = getelementptr [2 x i8], [2 x i8]* %t480, i32 0, i32 0
  %t484 = call i1 @is_backslash(i8* %t483)
  br label %logical_and_right_end_477

logical_and_right_end_477:
  br label %logical_and_merge_477

logical_and_merge_477:
  %t485 = phi i1 [ false, %logical_and_entry_477 ], [ %t484, %logical_and_right_end_477 ]
  %t486 = xor i1 %t485, 1
  %t487 = load %LexerState, %LexerState* %l0
  %t488 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t489 = load i8, i8* %l2
  %t490 = load double, double* %l20
  %t491 = load double, double* %l21
  %t492 = load double, double* %l22
  %t493 = load i8*, i8** %l23
  %t494 = load i1, i1* %l24
  %t495 = load i8, i8* %l25
  br i1 %t486, label %then50, label %merge51
then50:
  store i1 1, i1* %l24
  %t496 = load %LexerState, %LexerState* %l0
  %t497 = extractvalue %LexerState %t496, 1
  %t498 = sitofp i64 1 to double
  %t499 = fadd double %t497, %t498
  %t500 = load %LexerState, %LexerState* %l0
  %t501 = getelementptr %LexerState, %LexerState %t500, i32 0, i32 1
  store double %t499, double* %t501
  %t502 = load %LexerState, %LexerState* %l0
  %t503 = extractvalue %LexerState %t502, 3
  %t504 = sitofp i64 1 to double
  %t505 = fadd double %t503, %t504
  %t506 = load %LexerState, %LexerState* %l0
  %t507 = getelementptr %LexerState, %LexerState %t506, i32 0, i32 3
  store double %t505, double* %t507
  br label %loop.latch44
merge51:
  %t508 = load i1, i1* %l24
  %t509 = load %LexerState, %LexerState* %l0
  %t510 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t511 = load i8, i8* %l2
  %t512 = load double, double* %l20
  %t513 = load double, double* %l21
  %t514 = load double, double* %l22
  %t515 = load i8*, i8** %l23
  %t516 = load i1, i1* %l24
  %t517 = load i8, i8* %l25
  br i1 %t508, label %then52, label %else53
then52:
  %t518 = load i8*, i8** %l23
  %t519 = load i8, i8* %l25
  %t520 = alloca [2 x i8], align 1
  %t521 = getelementptr [2 x i8], [2 x i8]* %t520, i32 0, i32 0
  store i8 %t519, i8* %t521
  %t522 = getelementptr [2 x i8], [2 x i8]* %t520, i32 0, i32 1
  store i8 0, i8* %t522
  %t523 = getelementptr [2 x i8], [2 x i8]* %t520, i32 0, i32 0
  %t524 = call i8* @interpret_escape(i8* %t523)
  %t525 = add i8* %t518, %t524
  store i8* %t525, i8** %l23
  store i1 0, i1* %l24
  br label %merge54
else53:
  %t526 = load i8*, i8** %l23
  %t527 = load i8, i8* %l25
  %t528 = load i8, i8* %t526
  %t529 = add i8 %t528, %t527
  %t530 = alloca [2 x i8], align 1
  %t531 = getelementptr [2 x i8], [2 x i8]* %t530, i32 0, i32 0
  store i8 %t529, i8* %t531
  %t532 = getelementptr [2 x i8], [2 x i8]* %t530, i32 0, i32 1
  store i8 0, i8* %t532
  %t533 = getelementptr [2 x i8], [2 x i8]* %t530, i32 0, i32 0
  store i8* %t533, i8** %l23
  br label %merge54
merge54:
  %t534 = phi i8* [ %t525, %then52 ], [ %t533, %else53 ]
  %t535 = phi i1 [ 0, %then52 ], [ %t516, %else53 ]
  store i8* %t534, i8** %l23
  store i1 %t535, i1* %l24
  %t536 = load i8, i8* %l25
  %t537 = icmp eq i8 %t536, 10
  %t538 = load %LexerState, %LexerState* %l0
  %t539 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t540 = load i8, i8* %l2
  %t541 = load double, double* %l20
  %t542 = load double, double* %l21
  %t543 = load double, double* %l22
  %t544 = load i8*, i8** %l23
  %t545 = load i1, i1* %l24
  %t546 = load i8, i8* %l25
  br i1 %t537, label %then55, label %else56
then55:
  %t547 = load %LexerState, %LexerState* %l0
  %t548 = extractvalue %LexerState %t547, 1
  %t549 = sitofp i64 1 to double
  %t550 = fadd double %t548, %t549
  %t551 = load %LexerState, %LexerState* %l0
  %t552 = getelementptr %LexerState, %LexerState %t551, i32 0, i32 1
  store double %t550, double* %t552
  %t553 = load %LexerState, %LexerState* %l0
  %t554 = extractvalue %LexerState %t553, 2
  %t555 = sitofp i64 1 to double
  %t556 = fadd double %t554, %t555
  %t557 = load %LexerState, %LexerState* %l0
  %t558 = getelementptr %LexerState, %LexerState %t557, i32 0, i32 2
  store double %t556, double* %t558
  %t559 = load %LexerState, %LexerState* %l0
  %t560 = sitofp i64 1 to double
  %t561 = getelementptr %LexerState, %LexerState %t559, i32 0, i32 3
  store double %t560, double* %t561
  br label %merge57
else56:
  %t562 = load %LexerState, %LexerState* %l0
  %t563 = extractvalue %LexerState %t562, 1
  %t564 = sitofp i64 1 to double
  %t565 = fadd double %t563, %t564
  %t566 = load %LexerState, %LexerState* %l0
  %t567 = getelementptr %LexerState, %LexerState %t566, i32 0, i32 1
  store double %t565, double* %t567
  %t568 = load %LexerState, %LexerState* %l0
  %t569 = extractvalue %LexerState %t568, 3
  %t570 = sitofp i64 1 to double
  %t571 = fadd double %t569, %t570
  %t572 = load %LexerState, %LexerState* %l0
  %t573 = getelementptr %LexerState, %LexerState %t572, i32 0, i32 3
  store double %t571, double* %t573
  br label %merge57
merge57:
  br label %loop.latch44
loop.latch44:
  %t574 = load i1, i1* %l24
  %t575 = load i8*, i8** %l23
  br label %loop.header42
afterloop45:
  %t578 = load %LexerState, %LexerState* %l0
  %t579 = extractvalue %LexerState %t578, 0
  %t580 = load double, double* %l20
  %t581 = load %LexerState, %LexerState* %l0
  %t582 = extractvalue %LexerState %t581, 1
  %t583 = call i8* @slice(i8* %t579, double %t580, double %t582)
  store i8* %t583, i8** %l26
  %t584 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t585 = alloca %TokenKind
  %t586 = getelementptr inbounds %TokenKind, %TokenKind* %t585, i32 0, i32 0
  store i32 2, i32* %t586
  %t587 = load i8*, i8** %l23
  %t588 = getelementptr inbounds %TokenKind, %TokenKind* %t585, i32 0, i32 1
  %t589 = bitcast [8 x i8]* %t588 to i8*
  %t590 = bitcast i8* %t589 to i8**
  store i8* %t587, i8** %t590
  %t591 = load %TokenKind, %TokenKind* %t585
  %t592 = insertvalue %Token undef, %TokenKind %t591, 0
  %t593 = load i8*, i8** %l26
  %t594 = insertvalue %Token %t592, i8* %t593, 1
  %t595 = load double, double* %l21
  %t596 = insertvalue %Token %t594, double %t595, 2
  %t597 = load double, double* %l22
  %t598 = insertvalue %Token %t596, double %t597, 3
  %t599 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t584, %Token %t598)
  store { %Token*, i64 }* %t599, { %Token*, i64 }** %l1
  br label %loop.latch2
merge41:
  %t600 = load i8, i8* %l2
  %t601 = alloca [2 x i8], align 1
  %t602 = getelementptr [2 x i8], [2 x i8]* %t601, i32 0, i32 0
  store i8 %t600, i8* %t602
  %t603 = getelementptr [2 x i8], [2 x i8]* %t601, i32 0, i32 1
  store i8 0, i8* %t603
  %t604 = getelementptr [2 x i8], [2 x i8]* %t601, i32 0, i32 0
  %t605 = call i1 @is_digit(i8* %t604)
  %t606 = load %LexerState, %LexerState* %l0
  %t607 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t608 = load i8, i8* %l2
  br i1 %t605, label %then58, label %merge59
then58:
  %t609 = load %LexerState, %LexerState* %l0
  %t610 = extractvalue %LexerState %t609, 1
  store double %t610, double* %l27
  %t611 = load %LexerState, %LexerState* %l0
  %t612 = extractvalue %LexerState %t611, 2
  store double %t612, double* %l28
  %t613 = load %LexerState, %LexerState* %l0
  %t614 = extractvalue %LexerState %t613, 3
  store double %t614, double* %l29
  %t615 = load %LexerState, %LexerState* %l0
  %t616 = extractvalue %LexerState %t615, 1
  %t617 = sitofp i64 1 to double
  %t618 = fadd double %t616, %t617
  %t619 = load %LexerState, %LexerState* %l0
  %t620 = getelementptr %LexerState, %LexerState %t619, i32 0, i32 1
  store double %t618, double* %t620
  %t621 = load %LexerState, %LexerState* %l0
  %t622 = extractvalue %LexerState %t621, 3
  %t623 = sitofp i64 1 to double
  %t624 = fadd double %t622, %t623
  %t625 = load %LexerState, %LexerState* %l0
  %t626 = getelementptr %LexerState, %LexerState %t625, i32 0, i32 3
  store double %t624, double* %t626
  %t627 = load %LexerState, %LexerState* %l0
  %t628 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t629 = load i8, i8* %l2
  %t630 = load double, double* %l27
  %t631 = load double, double* %l28
  %t632 = load double, double* %l29
  br label %loop.header60
loop.header60:
  br label %loop.body61
loop.body61:
  %t633 = load %LexerState, %LexerState* %l0
  %t634 = extractvalue %LexerState %t633, 1
  %t635 = load %LexerState, %LexerState* %l0
  %t636 = extractvalue %LexerState %t635, 0
  %t637 = call i64 @sailfin_runtime_string_length(i8* %t636)
  %t638 = sitofp i64 %t637 to double
  %t639 = fcmp oge double %t634, %t638
  %t640 = load %LexerState, %LexerState* %l0
  %t641 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t642 = load i8, i8* %l2
  %t643 = load double, double* %l27
  %t644 = load double, double* %l28
  %t645 = load double, double* %l29
  br i1 %t639, label %then64, label %merge65
then64:
  br label %afterloop63
merge65:
  %t646 = load %LexerState, %LexerState* %l0
  %t647 = extractvalue %LexerState %t646, 0
  %t648 = load %LexerState, %LexerState* %l0
  %t649 = extractvalue %LexerState %t648, 1
  %t650 = fptosi double %t649 to i64
  %t651 = getelementptr i8, i8* %t647, i64 %t650
  %t652 = load i8, i8* %t651
  %t653 = alloca [2 x i8], align 1
  %t654 = getelementptr [2 x i8], [2 x i8]* %t653, i32 0, i32 0
  store i8 %t652, i8* %t654
  %t655 = getelementptr [2 x i8], [2 x i8]* %t653, i32 0, i32 1
  store i8 0, i8* %t655
  %t656 = getelementptr [2 x i8], [2 x i8]* %t653, i32 0, i32 0
  %t657 = call i1 @is_digit(i8* %t656)
  %t658 = xor i1 %t657, 1
  %t659 = load %LexerState, %LexerState* %l0
  %t660 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t661 = load i8, i8* %l2
  %t662 = load double, double* %l27
  %t663 = load double, double* %l28
  %t664 = load double, double* %l29
  br i1 %t658, label %then66, label %merge67
then66:
  br label %afterloop63
merge67:
  %t665 = load %LexerState, %LexerState* %l0
  %t666 = extractvalue %LexerState %t665, 1
  %t667 = sitofp i64 1 to double
  %t668 = fadd double %t666, %t667
  %t669 = load %LexerState, %LexerState* %l0
  %t670 = getelementptr %LexerState, %LexerState %t669, i32 0, i32 1
  store double %t668, double* %t670
  %t671 = load %LexerState, %LexerState* %l0
  %t672 = extractvalue %LexerState %t671, 3
  %t673 = sitofp i64 1 to double
  %t674 = fadd double %t672, %t673
  %t675 = load %LexerState, %LexerState* %l0
  %t676 = getelementptr %LexerState, %LexerState %t675, i32 0, i32 3
  store double %t674, double* %t676
  br label %loop.latch62
loop.latch62:
  br label %loop.header60
afterloop63:
  %t678 = load %LexerState, %LexerState* %l0
  %t679 = extractvalue %LexerState %t678, 1
  %t680 = load %LexerState, %LexerState* %l0
  %t681 = extractvalue %LexerState %t680, 0
  %t682 = call i64 @sailfin_runtime_string_length(i8* %t681)
  %t683 = sitofp i64 %t682 to double
  %t684 = fcmp olt double %t679, %t683
  br label %logical_and_entry_677

logical_and_entry_677:
  br i1 %t684, label %logical_and_right_677, label %logical_and_merge_677

logical_and_right_677:
  %t685 = load %LexerState, %LexerState* %l0
  %t686 = extractvalue %LexerState %t685, 0
  %t687 = load %LexerState, %LexerState* %l0
  %t688 = extractvalue %LexerState %t687, 1
  %t689 = fptosi double %t688 to i64
  %t690 = getelementptr i8, i8* %t686, i64 %t689
  %t691 = load i8, i8* %t690
  %t692 = icmp eq i8 %t691, 46
  br label %logical_and_right_end_677

logical_and_right_end_677:
  br label %logical_and_merge_677

logical_and_merge_677:
  %t693 = phi i1 [ false, %logical_and_entry_677 ], [ %t692, %logical_and_right_end_677 ]
  %t694 = load %LexerState, %LexerState* %l0
  %t695 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t696 = load i8, i8* %l2
  %t697 = load double, double* %l27
  %t698 = load double, double* %l28
  %t699 = load double, double* %l29
  br i1 %t693, label %then68, label %merge69
then68:
  %t701 = load %LexerState, %LexerState* %l0
  %t702 = extractvalue %LexerState %t701, 1
  %t703 = sitofp i64 1 to double
  %t704 = fadd double %t702, %t703
  %t705 = load %LexerState, %LexerState* %l0
  %t706 = extractvalue %LexerState %t705, 0
  %t707 = call i64 @sailfin_runtime_string_length(i8* %t706)
  %t708 = sitofp i64 %t707 to double
  %t709 = fcmp olt double %t704, %t708
  br label %logical_and_entry_700

logical_and_entry_700:
  br i1 %t709, label %logical_and_right_700, label %logical_and_merge_700

logical_and_right_700:
  %t710 = load %LexerState, %LexerState* %l0
  %t711 = extractvalue %LexerState %t710, 0
  %t712 = load %LexerState, %LexerState* %l0
  %t713 = extractvalue %LexerState %t712, 1
  %t714 = sitofp i64 1 to double
  %t715 = fadd double %t713, %t714
  %t716 = fptosi double %t715 to i64
  %t717 = getelementptr i8, i8* %t711, i64 %t716
  %t718 = load i8, i8* %t717
  %t719 = alloca [2 x i8], align 1
  %t720 = getelementptr [2 x i8], [2 x i8]* %t719, i32 0, i32 0
  store i8 %t718, i8* %t720
  %t721 = getelementptr [2 x i8], [2 x i8]* %t719, i32 0, i32 1
  store i8 0, i8* %t721
  %t722 = getelementptr [2 x i8], [2 x i8]* %t719, i32 0, i32 0
  %t723 = call i1 @is_digit(i8* %t722)
  br label %logical_and_right_end_700

logical_and_right_end_700:
  br label %logical_and_merge_700

logical_and_merge_700:
  %t724 = phi i1 [ false, %logical_and_entry_700 ], [ %t723, %logical_and_right_end_700 ]
  store i1 %t724, i1* %l30
  %t725 = load i1, i1* %l30
  %t726 = load %LexerState, %LexerState* %l0
  %t727 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t728 = load i8, i8* %l2
  %t729 = load double, double* %l27
  %t730 = load double, double* %l28
  %t731 = load double, double* %l29
  %t732 = load i1, i1* %l30
  br i1 %t725, label %then70, label %merge71
then70:
  %t733 = load %LexerState, %LexerState* %l0
  %t734 = extractvalue %LexerState %t733, 1
  %t735 = sitofp i64 1 to double
  %t736 = fadd double %t734, %t735
  %t737 = load %LexerState, %LexerState* %l0
  %t738 = getelementptr %LexerState, %LexerState %t737, i32 0, i32 1
  store double %t736, double* %t738
  %t739 = load %LexerState, %LexerState* %l0
  %t740 = extractvalue %LexerState %t739, 3
  %t741 = sitofp i64 1 to double
  %t742 = fadd double %t740, %t741
  %t743 = load %LexerState, %LexerState* %l0
  %t744 = getelementptr %LexerState, %LexerState %t743, i32 0, i32 3
  store double %t742, double* %t744
  %t745 = load %LexerState, %LexerState* %l0
  %t746 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t747 = load i8, i8* %l2
  %t748 = load double, double* %l27
  %t749 = load double, double* %l28
  %t750 = load double, double* %l29
  %t751 = load i1, i1* %l30
  br label %loop.header72
loop.header72:
  br label %loop.body73
loop.body73:
  %t752 = load %LexerState, %LexerState* %l0
  %t753 = extractvalue %LexerState %t752, 1
  %t754 = load %LexerState, %LexerState* %l0
  %t755 = extractvalue %LexerState %t754, 0
  %t756 = call i64 @sailfin_runtime_string_length(i8* %t755)
  %t757 = sitofp i64 %t756 to double
  %t758 = fcmp oge double %t753, %t757
  %t759 = load %LexerState, %LexerState* %l0
  %t760 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t761 = load i8, i8* %l2
  %t762 = load double, double* %l27
  %t763 = load double, double* %l28
  %t764 = load double, double* %l29
  %t765 = load i1, i1* %l30
  br i1 %t758, label %then76, label %merge77
then76:
  br label %afterloop75
merge77:
  %t766 = load %LexerState, %LexerState* %l0
  %t767 = extractvalue %LexerState %t766, 0
  %t768 = load %LexerState, %LexerState* %l0
  %t769 = extractvalue %LexerState %t768, 1
  %t770 = fptosi double %t769 to i64
  %t771 = getelementptr i8, i8* %t767, i64 %t770
  %t772 = load i8, i8* %t771
  %t773 = alloca [2 x i8], align 1
  %t774 = getelementptr [2 x i8], [2 x i8]* %t773, i32 0, i32 0
  store i8 %t772, i8* %t774
  %t775 = getelementptr [2 x i8], [2 x i8]* %t773, i32 0, i32 1
  store i8 0, i8* %t775
  %t776 = getelementptr [2 x i8], [2 x i8]* %t773, i32 0, i32 0
  %t777 = call i1 @is_digit(i8* %t776)
  %t778 = xor i1 %t777, 1
  %t779 = load %LexerState, %LexerState* %l0
  %t780 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t781 = load i8, i8* %l2
  %t782 = load double, double* %l27
  %t783 = load double, double* %l28
  %t784 = load double, double* %l29
  %t785 = load i1, i1* %l30
  br i1 %t778, label %then78, label %merge79
then78:
  br label %afterloop75
merge79:
  %t786 = load %LexerState, %LexerState* %l0
  %t787 = extractvalue %LexerState %t786, 1
  %t788 = sitofp i64 1 to double
  %t789 = fadd double %t787, %t788
  %t790 = load %LexerState, %LexerState* %l0
  %t791 = getelementptr %LexerState, %LexerState %t790, i32 0, i32 1
  store double %t789, double* %t791
  %t792 = load %LexerState, %LexerState* %l0
  %t793 = extractvalue %LexerState %t792, 3
  %t794 = sitofp i64 1 to double
  %t795 = fadd double %t793, %t794
  %t796 = load %LexerState, %LexerState* %l0
  %t797 = getelementptr %LexerState, %LexerState %t796, i32 0, i32 3
  store double %t795, double* %t797
  br label %loop.latch74
loop.latch74:
  br label %loop.header72
afterloop75:
  br label %merge71
merge71:
  br label %merge69
merge69:
  %t798 = load %LexerState, %LexerState* %l0
  %t799 = extractvalue %LexerState %t798, 0
  %t800 = load double, double* %l27
  %t801 = load %LexerState, %LexerState* %l0
  %t802 = extractvalue %LexerState %t801, 1
  %t803 = call i8* @slice(i8* %t799, double %t800, double %t802)
  store i8* %t803, i8** %l31
  %t804 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t805 = alloca %TokenKind
  %t806 = getelementptr inbounds %TokenKind, %TokenKind* %t805, i32 0, i32 0
  store i32 1, i32* %t806
  %t807 = load i8*, i8** %l31
  %t808 = getelementptr inbounds %TokenKind, %TokenKind* %t805, i32 0, i32 1
  %t809 = bitcast [8 x i8]* %t808 to i8*
  %t810 = bitcast i8* %t809 to i8**
  store i8* %t807, i8** %t810
  %t811 = load %TokenKind, %TokenKind* %t805
  %t812 = insertvalue %Token undef, %TokenKind %t811, 0
  %t813 = load i8*, i8** %l31
  %t814 = insertvalue %Token %t812, i8* %t813, 1
  %t815 = load double, double* %l28
  %t816 = insertvalue %Token %t814, double %t815, 2
  %t817 = load double, double* %l29
  %t818 = insertvalue %Token %t816, double %t817, 3
  %t819 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t804, %Token %t818)
  store { %Token*, i64 }* %t819, { %Token*, i64 }** %l1
  br label %loop.latch2
merge59:
  %t820 = load i8, i8* %l2
  %t821 = alloca [2 x i8], align 1
  %t822 = getelementptr [2 x i8], [2 x i8]* %t821, i32 0, i32 0
  store i8 %t820, i8* %t822
  %t823 = getelementptr [2 x i8], [2 x i8]* %t821, i32 0, i32 1
  store i8 0, i8* %t823
  %t824 = getelementptr [2 x i8], [2 x i8]* %t821, i32 0, i32 0
  %t825 = call i1 @is_identifier_start(i8* %t824)
  %t826 = load %LexerState, %LexerState* %l0
  %t827 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t828 = load i8, i8* %l2
  br i1 %t825, label %then80, label %merge81
then80:
  %t829 = load %LexerState, %LexerState* %l0
  %t830 = extractvalue %LexerState %t829, 1
  store double %t830, double* %l32
  %t831 = load %LexerState, %LexerState* %l0
  %t832 = extractvalue %LexerState %t831, 2
  store double %t832, double* %l33
  %t833 = load %LexerState, %LexerState* %l0
  %t834 = extractvalue %LexerState %t833, 3
  store double %t834, double* %l34
  %t835 = load %LexerState, %LexerState* %l0
  %t836 = extractvalue %LexerState %t835, 1
  %t837 = sitofp i64 1 to double
  %t838 = fadd double %t836, %t837
  %t839 = load %LexerState, %LexerState* %l0
  %t840 = getelementptr %LexerState, %LexerState %t839, i32 0, i32 1
  store double %t838, double* %t840
  %t841 = load %LexerState, %LexerState* %l0
  %t842 = extractvalue %LexerState %t841, 3
  %t843 = sitofp i64 1 to double
  %t844 = fadd double %t842, %t843
  %t845 = load %LexerState, %LexerState* %l0
  %t846 = getelementptr %LexerState, %LexerState %t845, i32 0, i32 3
  store double %t844, double* %t846
  %t847 = load %LexerState, %LexerState* %l0
  %t848 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t849 = load i8, i8* %l2
  %t850 = load double, double* %l32
  %t851 = load double, double* %l33
  %t852 = load double, double* %l34
  br label %loop.header82
loop.header82:
  br label %loop.body83
loop.body83:
  %t853 = load %LexerState, %LexerState* %l0
  %t854 = extractvalue %LexerState %t853, 1
  %t855 = load %LexerState, %LexerState* %l0
  %t856 = extractvalue %LexerState %t855, 0
  %t857 = call i64 @sailfin_runtime_string_length(i8* %t856)
  %t858 = sitofp i64 %t857 to double
  %t859 = fcmp oge double %t854, %t858
  %t860 = load %LexerState, %LexerState* %l0
  %t861 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t862 = load i8, i8* %l2
  %t863 = load double, double* %l32
  %t864 = load double, double* %l33
  %t865 = load double, double* %l34
  br i1 %t859, label %then86, label %merge87
then86:
  br label %afterloop85
merge87:
  %t866 = load %LexerState, %LexerState* %l0
  %t867 = extractvalue %LexerState %t866, 0
  %t868 = load %LexerState, %LexerState* %l0
  %t869 = extractvalue %LexerState %t868, 1
  %t870 = fptosi double %t869 to i64
  %t871 = getelementptr i8, i8* %t867, i64 %t870
  %t872 = load i8, i8* %t871
  %t873 = alloca [2 x i8], align 1
  %t874 = getelementptr [2 x i8], [2 x i8]* %t873, i32 0, i32 0
  store i8 %t872, i8* %t874
  %t875 = getelementptr [2 x i8], [2 x i8]* %t873, i32 0, i32 1
  store i8 0, i8* %t875
  %t876 = getelementptr [2 x i8], [2 x i8]* %t873, i32 0, i32 0
  %t877 = call i1 @is_identifier_part(i8* %t876)
  %t878 = xor i1 %t877, 1
  %t879 = load %LexerState, %LexerState* %l0
  %t880 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t881 = load i8, i8* %l2
  %t882 = load double, double* %l32
  %t883 = load double, double* %l33
  %t884 = load double, double* %l34
  br i1 %t878, label %then88, label %merge89
then88:
  br label %afterloop85
merge89:
  %t885 = load %LexerState, %LexerState* %l0
  %t886 = extractvalue %LexerState %t885, 1
  %t887 = sitofp i64 1 to double
  %t888 = fadd double %t886, %t887
  %t889 = load %LexerState, %LexerState* %l0
  %t890 = getelementptr %LexerState, %LexerState %t889, i32 0, i32 1
  store double %t888, double* %t890
  %t891 = load %LexerState, %LexerState* %l0
  %t892 = extractvalue %LexerState %t891, 3
  %t893 = sitofp i64 1 to double
  %t894 = fadd double %t892, %t893
  %t895 = load %LexerState, %LexerState* %l0
  %t896 = getelementptr %LexerState, %LexerState %t895, i32 0, i32 3
  store double %t894, double* %t896
  br label %loop.latch84
loop.latch84:
  br label %loop.header82
afterloop85:
  %t897 = load %LexerState, %LexerState* %l0
  %t898 = extractvalue %LexerState %t897, 0
  %t899 = load double, double* %l32
  %t900 = load %LexerState, %LexerState* %l0
  %t901 = extractvalue %LexerState %t900, 1
  %t902 = call i8* @slice(i8* %t898, double %t899, double %t901)
  store i8* %t902, i8** %l35
  %t904 = load i8*, i8** %l35
  %s905 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.905, i32 0, i32 0
  %t906 = icmp eq i8* %t904, %s905
  br label %logical_or_entry_903

logical_or_entry_903:
  br i1 %t906, label %logical_or_merge_903, label %logical_or_right_903

logical_or_right_903:
  %t907 = load i8*, i8** %l35
  %s908 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.908, i32 0, i32 0
  %t909 = icmp eq i8* %t907, %s908
  br label %logical_or_right_end_903

logical_or_right_end_903:
  br label %logical_or_merge_903

logical_or_merge_903:
  %t910 = phi i1 [ true, %logical_or_entry_903 ], [ %t909, %logical_or_right_end_903 ]
  %t911 = load %LexerState, %LexerState* %l0
  %t912 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t913 = load i8, i8* %l2
  %t914 = load double, double* %l32
  %t915 = load double, double* %l33
  %t916 = load double, double* %l34
  %t917 = load i8*, i8** %l35
  br i1 %t910, label %then90, label %else91
then90:
  %t918 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t919 = alloca %TokenKind
  %t920 = getelementptr inbounds %TokenKind, %TokenKind* %t919, i32 0, i32 0
  store i32 3, i32* %t920
  %t921 = load i8*, i8** %l35
  %t922 = getelementptr inbounds %TokenKind, %TokenKind* %t919, i32 0, i32 1
  %t923 = bitcast [8 x i8]* %t922 to i8*
  %t924 = bitcast i8* %t923 to i8**
  store i8* %t921, i8** %t924
  %t925 = load %TokenKind, %TokenKind* %t919
  %t926 = insertvalue %Token undef, %TokenKind %t925, 0
  %t927 = load i8*, i8** %l35
  %t928 = insertvalue %Token %t926, i8* %t927, 1
  %t929 = load double, double* %l33
  %t930 = insertvalue %Token %t928, double %t929, 2
  %t931 = load double, double* %l34
  %t932 = insertvalue %Token %t930, double %t931, 3
  %t933 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t918, %Token %t932)
  store { %Token*, i64 }* %t933, { %Token*, i64 }** %l1
  br label %merge92
else91:
  %t934 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t935 = alloca %TokenKind
  %t936 = getelementptr inbounds %TokenKind, %TokenKind* %t935, i32 0, i32 0
  store i32 0, i32* %t936
  %t937 = load i8*, i8** %l35
  %t938 = getelementptr inbounds %TokenKind, %TokenKind* %t935, i32 0, i32 1
  %t939 = bitcast [8 x i8]* %t938 to i8*
  %t940 = bitcast i8* %t939 to i8**
  store i8* %t937, i8** %t940
  %t941 = load %TokenKind, %TokenKind* %t935
  %t942 = insertvalue %Token undef, %TokenKind %t941, 0
  %t943 = load i8*, i8** %l35
  %t944 = insertvalue %Token %t942, i8* %t943, 1
  %t945 = load double, double* %l33
  %t946 = insertvalue %Token %t944, double %t945, 2
  %t947 = load double, double* %l34
  %t948 = insertvalue %Token %t946, double %t947, 3
  %t949 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t934, %Token %t948)
  store { %Token*, i64 }* %t949, { %Token*, i64 }** %l1
  br label %merge92
merge92:
  %t950 = phi { %Token*, i64 }* [ %t933, %then90 ], [ %t949, %else91 ]
  store { %Token*, i64 }* %t950, { %Token*, i64 }** %l1
  br label %loop.latch2
merge81:
  %t951 = load %LexerState, %LexerState* %l0
  %t952 = extractvalue %LexerState %t951, 2
  store double %t952, double* %l36
  %t953 = load %LexerState, %LexerState* %l0
  %t954 = extractvalue %LexerState %t953, 3
  store double %t954, double* %l37
  %t955 = load i8, i8* %l2
  store i8 %t955, i8* %l38
  %t956 = load %LexerState, %LexerState* %l0
  %t957 = call i8* @peek_next_char(%LexerState %t956)
  store i8* %t957, i8** %l39
  %t958 = load i8*, i8** %l39
  %s959 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.959, i32 0, i32 0
  %t960 = icmp ne i8* %t958, %s959
  %t961 = load %LexerState, %LexerState* %l0
  %t962 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t963 = load i8, i8* %l2
  %t964 = load double, double* %l36
  %t965 = load double, double* %l37
  %t966 = load i8, i8* %l38
  %t967 = load i8*, i8** %l39
  br i1 %t960, label %then93, label %merge94
then93:
  %t968 = load i8, i8* %l2
  %t969 = load i8*, i8** %l39
  %t970 = load i8, i8* %t969
  %t971 = add i8 %t968, %t970
  store i8 %t971, i8* %l40
  %t972 = load i8, i8* %l40
  %t973 = alloca [2 x i8], align 1
  %t974 = getelementptr [2 x i8], [2 x i8]* %t973, i32 0, i32 0
  store i8 %t972, i8* %t974
  %t975 = getelementptr [2 x i8], [2 x i8]* %t973, i32 0, i32 1
  store i8 0, i8* %t975
  %t976 = getelementptr [2 x i8], [2 x i8]* %t973, i32 0, i32 0
  %t977 = call i1 @is_two_char_symbol(i8* %t976)
  %t978 = load %LexerState, %LexerState* %l0
  %t979 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t980 = load i8, i8* %l2
  %t981 = load double, double* %l36
  %t982 = load double, double* %l37
  %t983 = load i8, i8* %l38
  %t984 = load i8*, i8** %l39
  %t985 = load i8, i8* %l40
  br i1 %t977, label %then95, label %merge96
then95:
  %t986 = load i8, i8* %l40
  store i8 %t986, i8* %l38
  %t987 = load %LexerState, %LexerState* %l0
  %t988 = extractvalue %LexerState %t987, 1
  %t989 = sitofp i64 2 to double
  %t990 = fadd double %t988, %t989
  %t991 = load %LexerState, %LexerState* %l0
  %t992 = getelementptr %LexerState, %LexerState %t991, i32 0, i32 1
  store double %t990, double* %t992
  %t993 = load %LexerState, %LexerState* %l0
  %t994 = extractvalue %LexerState %t993, 3
  %t995 = sitofp i64 2 to double
  %t996 = fadd double %t994, %t995
  %t997 = load %LexerState, %LexerState* %l0
  %t998 = getelementptr %LexerState, %LexerState %t997, i32 0, i32 3
  store double %t996, double* %t998
  %t999 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t1000 = alloca %TokenKind
  %t1001 = getelementptr inbounds %TokenKind, %TokenKind* %t1000, i32 0, i32 0
  store i32 4, i32* %t1001
  %t1002 = load i8, i8* %l38
  %t1003 = call noalias i8* @malloc(i64 1)
  %t1004 = bitcast i8* %t1003 to i8*
  store i8 %t1002, i8* %t1004
  %t1005 = getelementptr inbounds %TokenKind, %TokenKind* %t1000, i32 0, i32 1
  %t1006 = bitcast [8 x i8]* %t1005 to i8*
  %t1007 = bitcast i8* %t1006 to i8**
  store i8* %t1003, i8** %t1007
  %t1008 = load %TokenKind, %TokenKind* %t1000
  %t1009 = insertvalue %Token undef, %TokenKind %t1008, 0
  %t1010 = load i8, i8* %l38
  %t1011 = alloca [2 x i8], align 1
  %t1012 = getelementptr [2 x i8], [2 x i8]* %t1011, i32 0, i32 0
  store i8 %t1010, i8* %t1012
  %t1013 = getelementptr [2 x i8], [2 x i8]* %t1011, i32 0, i32 1
  store i8 0, i8* %t1013
  %t1014 = getelementptr [2 x i8], [2 x i8]* %t1011, i32 0, i32 0
  %t1015 = insertvalue %Token %t1009, i8* %t1014, 1
  %t1016 = load double, double* %l36
  %t1017 = insertvalue %Token %t1015, double %t1016, 2
  %t1018 = load double, double* %l37
  %t1019 = insertvalue %Token %t1017, double %t1018, 3
  %t1020 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t999, %Token %t1019)
  store { %Token*, i64 }* %t1020, { %Token*, i64 }** %l1
  br label %loop.latch2
merge96:
  br label %merge94
merge94:
  %t1021 = phi i8 [ %t986, %then93 ], [ %t966, %loop.body1 ]
  %t1022 = phi { %Token*, i64 }* [ %t1020, %then93 ], [ %t962, %loop.body1 ]
  store i8 %t1021, i8* %l38
  store { %Token*, i64 }* %t1022, { %Token*, i64 }** %l1
  %t1023 = load %LexerState, %LexerState* %l0
  %t1024 = extractvalue %LexerState %t1023, 1
  %t1025 = sitofp i64 1 to double
  %t1026 = fadd double %t1024, %t1025
  %t1027 = load %LexerState, %LexerState* %l0
  %t1028 = getelementptr %LexerState, %LexerState %t1027, i32 0, i32 1
  store double %t1026, double* %t1028
  %t1029 = load i8, i8* %l2
  %t1030 = icmp eq i8 %t1029, 10
  %t1031 = load %LexerState, %LexerState* %l0
  %t1032 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t1033 = load i8, i8* %l2
  %t1034 = load double, double* %l36
  %t1035 = load double, double* %l37
  %t1036 = load i8, i8* %l38
  %t1037 = load i8*, i8** %l39
  br i1 %t1030, label %then97, label %else98
then97:
  %t1038 = load %LexerState, %LexerState* %l0
  %t1039 = extractvalue %LexerState %t1038, 2
  %t1040 = sitofp i64 1 to double
  %t1041 = fadd double %t1039, %t1040
  %t1042 = load %LexerState, %LexerState* %l0
  %t1043 = getelementptr %LexerState, %LexerState %t1042, i32 0, i32 2
  store double %t1041, double* %t1043
  %t1044 = load %LexerState, %LexerState* %l0
  %t1045 = sitofp i64 1 to double
  %t1046 = getelementptr %LexerState, %LexerState %t1044, i32 0, i32 3
  store double %t1045, double* %t1046
  br label %merge99
else98:
  %t1047 = load %LexerState, %LexerState* %l0
  %t1048 = extractvalue %LexerState %t1047, 3
  %t1049 = sitofp i64 1 to double
  %t1050 = fadd double %t1048, %t1049
  %t1051 = load %LexerState, %LexerState* %l0
  %t1052 = getelementptr %LexerState, %LexerState %t1051, i32 0, i32 3
  store double %t1050, double* %t1052
  br label %merge99
merge99:
  %t1053 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t1054 = alloca %TokenKind
  %t1055 = getelementptr inbounds %TokenKind, %TokenKind* %t1054, i32 0, i32 0
  store i32 4, i32* %t1055
  %t1056 = load i8, i8* %l38
  %t1057 = call noalias i8* @malloc(i64 1)
  %t1058 = bitcast i8* %t1057 to i8*
  store i8 %t1056, i8* %t1058
  %t1059 = getelementptr inbounds %TokenKind, %TokenKind* %t1054, i32 0, i32 1
  %t1060 = bitcast [8 x i8]* %t1059 to i8*
  %t1061 = bitcast i8* %t1060 to i8**
  store i8* %t1057, i8** %t1061
  %t1062 = load %TokenKind, %TokenKind* %t1054
  %t1063 = insertvalue %Token undef, %TokenKind %t1062, 0
  %t1064 = load i8, i8* %l38
  %t1065 = alloca [2 x i8], align 1
  %t1066 = getelementptr [2 x i8], [2 x i8]* %t1065, i32 0, i32 0
  store i8 %t1064, i8* %t1066
  %t1067 = getelementptr [2 x i8], [2 x i8]* %t1065, i32 0, i32 1
  store i8 0, i8* %t1067
  %t1068 = getelementptr [2 x i8], [2 x i8]* %t1065, i32 0, i32 0
  %t1069 = insertvalue %Token %t1063, i8* %t1068, 1
  %t1070 = load double, double* %l36
  %t1071 = insertvalue %Token %t1069, double %t1070, 2
  %t1072 = load double, double* %l37
  %t1073 = insertvalue %Token %t1071, double %t1072, 3
  %t1074 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t1053, %Token %t1073)
  store { %Token*, i64 }* %t1074, { %Token*, i64 }** %l1
  br label %loop.latch2
loop.latch2:
  %t1075 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br label %loop.header0
afterloop3:
  %t1077 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t1078 = load %LexerState, %LexerState* %l0
  %t1079 = extractvalue %LexerState %t1078, 2
  %t1080 = load %LexerState, %LexerState* %l0
  %t1081 = extractvalue %LexerState %t1080, 3
  %t1082 = call double @eof_token(double %t1079, double %t1081)
  %t1083 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t1077, i8* null)
  store { %Token*, i64 }* %t1083, { %Token*, i64 }** %l1
  %t1084 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  ret { %Token*, i64 }* %t1084
}

define i1 @is_whitespace(i8* %ch) {
entry:
  %t1 = load i8, i8* %ch
  %t2 = icmp eq i8 %t1, 32
  br label %logical_or_entry_0

logical_or_entry_0:
  br i1 %t2, label %logical_or_merge_0, label %logical_or_right_0

logical_or_right_0:
  %t4 = load i8, i8* %ch
  %t5 = icmp eq i8 %t4, 9
  br label %logical_or_entry_3

logical_or_entry_3:
  br i1 %t5, label %logical_or_merge_3, label %logical_or_right_3

logical_or_right_3:
  %t7 = load i8, i8* %ch
  %t8 = icmp eq i8 %t7, 10
  br label %logical_or_entry_6

logical_or_entry_6:
  br i1 %t8, label %logical_or_merge_6, label %logical_or_right_6

logical_or_right_6:
  %t9 = load i8, i8* %ch
  %t10 = icmp eq i8 %t9, 13
  br label %logical_or_right_end_6

logical_or_right_end_6:
  br label %logical_or_merge_6

logical_or_merge_6:
  %t11 = phi i1 [ true, %logical_or_entry_6 ], [ %t10, %logical_or_right_end_6 ]
  br label %logical_or_right_end_3

logical_or_right_end_3:
  br label %logical_or_merge_3

logical_or_merge_3:
  %t12 = phi i1 [ true, %logical_or_entry_3 ], [ %t11, %logical_or_right_end_3 ]
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
  %t2 = load i8, i8* %ch
  %t3 = icmp eq i8 %t2, 95
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
  %t4 = alloca [2 x i8], align 1
  %t5 = getelementptr [2 x i8], [2 x i8]* %t4, i32 0, i32 0
  store i8 97, i8* %t5
  %t6 = getelementptr [2 x i8], [2 x i8]* %t4, i32 0, i32 1
  store i8 0, i8* %t6
  %t7 = getelementptr [2 x i8], [2 x i8]* %t4, i32 0, i32 0
  %t8 = call double @char_code(i8* %t7)
  %t9 = fcmp oge double %t3, %t8
  br label %logical_and_entry_2

logical_and_entry_2:
  br i1 %t9, label %logical_and_right_2, label %logical_and_merge_2

logical_and_right_2:
  %t10 = load double, double* %l0
  %t11 = alloca [2 x i8], align 1
  %t12 = getelementptr [2 x i8], [2 x i8]* %t11, i32 0, i32 0
  store i8 122, i8* %t12
  %t13 = getelementptr [2 x i8], [2 x i8]* %t11, i32 0, i32 1
  store i8 0, i8* %t13
  %t14 = getelementptr [2 x i8], [2 x i8]* %t11, i32 0, i32 0
  %t15 = call double @char_code(i8* %t14)
  %t16 = fcmp ole double %t10, %t15
  br label %logical_and_right_end_2

logical_and_right_end_2:
  br label %logical_and_merge_2

logical_and_merge_2:
  %t17 = phi i1 [ false, %logical_and_entry_2 ], [ %t16, %logical_and_right_end_2 ]
  br label %logical_or_entry_1

logical_or_entry_1:
  br i1 %t17, label %logical_or_merge_1, label %logical_or_right_1

logical_or_right_1:
  %t19 = load double, double* %l0
  %t20 = alloca [2 x i8], align 1
  %t21 = getelementptr [2 x i8], [2 x i8]* %t20, i32 0, i32 0
  store i8 65, i8* %t21
  %t22 = getelementptr [2 x i8], [2 x i8]* %t20, i32 0, i32 1
  store i8 0, i8* %t22
  %t23 = getelementptr [2 x i8], [2 x i8]* %t20, i32 0, i32 0
  %t24 = call double @char_code(i8* %t23)
  %t25 = fcmp oge double %t19, %t24
  br label %logical_and_entry_18

logical_and_entry_18:
  br i1 %t25, label %logical_and_right_18, label %logical_and_merge_18

logical_and_right_18:
  %t26 = load double, double* %l0
  %t27 = alloca [2 x i8], align 1
  %t28 = getelementptr [2 x i8], [2 x i8]* %t27, i32 0, i32 0
  store i8 90, i8* %t28
  %t29 = getelementptr [2 x i8], [2 x i8]* %t27, i32 0, i32 1
  store i8 0, i8* %t29
  %t30 = getelementptr [2 x i8], [2 x i8]* %t27, i32 0, i32 0
  %t31 = call double @char_code(i8* %t30)
  %t32 = fcmp ole double %t26, %t31
  br label %logical_and_right_end_18

logical_and_right_end_18:
  br label %logical_and_merge_18

logical_and_merge_18:
  %t33 = phi i1 [ false, %logical_and_entry_18 ], [ %t32, %logical_and_right_end_18 ]
  br label %logical_or_right_end_1

logical_or_right_end_1:
  br label %logical_or_merge_1

logical_or_merge_1:
  %t34 = phi i1 [ true, %logical_or_entry_1 ], [ %t33, %logical_or_right_end_1 ]
  ret i1 %t34
}

define i1 @is_digit(i8* %ch) {
entry:
  %l0 = alloca double
  %t0 = call double @char_code(i8* %ch)
  store double %t0, double* %l0
  %t2 = load double, double* %l0
  %t3 = alloca [2 x i8], align 1
  %t4 = getelementptr [2 x i8], [2 x i8]* %t3, i32 0, i32 0
  store i8 48, i8* %t4
  %t5 = getelementptr [2 x i8], [2 x i8]* %t3, i32 0, i32 1
  store i8 0, i8* %t5
  %t6 = getelementptr [2 x i8], [2 x i8]* %t3, i32 0, i32 0
  %t7 = call double @char_code(i8* %t6)
  %t8 = fcmp oge double %t2, %t7
  br label %logical_and_entry_1

logical_and_entry_1:
  br i1 %t8, label %logical_and_right_1, label %logical_and_merge_1

logical_and_right_1:
  %t9 = load double, double* %l0
  %t10 = alloca [2 x i8], align 1
  %t11 = getelementptr [2 x i8], [2 x i8]* %t10, i32 0, i32 0
  store i8 57, i8* %t11
  %t12 = getelementptr [2 x i8], [2 x i8]* %t10, i32 0, i32 1
  store i8 0, i8* %t12
  %t13 = getelementptr [2 x i8], [2 x i8]* %t10, i32 0, i32 0
  %t14 = call double @char_code(i8* %t13)
  %t15 = fcmp ole double %t9, %t14
  br label %logical_and_right_end_1

logical_and_right_end_1:
  br label %logical_and_merge_1

logical_and_merge_1:
  %t16 = phi i1 [ false, %logical_and_entry_1 ], [ %t15, %logical_and_right_end_1 ]
  ret i1 %t16
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
  %t0 = load i8, i8* %ch
  %t1 = icmp eq i8 %t0, 110
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = alloca [2 x i8], align 1
  %t3 = getelementptr [2 x i8], [2 x i8]* %t2, i32 0, i32 0
  store i8 10, i8* %t3
  %t4 = getelementptr [2 x i8], [2 x i8]* %t2, i32 0, i32 1
  store i8 0, i8* %t4
  %t5 = getelementptr [2 x i8], [2 x i8]* %t2, i32 0, i32 0
  ret i8* %t5
merge1:
  %t6 = load i8, i8* %ch
  %t7 = icmp eq i8 %t6, 116
  br i1 %t7, label %then2, label %merge3
then2:
  %t8 = alloca [2 x i8], align 1
  %t9 = getelementptr [2 x i8], [2 x i8]* %t8, i32 0, i32 0
  store i8 9, i8* %t9
  %t10 = getelementptr [2 x i8], [2 x i8]* %t8, i32 0, i32 1
  store i8 0, i8* %t10
  %t11 = getelementptr [2 x i8], [2 x i8]* %t8, i32 0, i32 0
  ret i8* %t11
merge3:
  %t12 = load i8, i8* %ch
  %t13 = icmp eq i8 %t12, 114
  br i1 %t13, label %then4, label %merge5
then4:
  %t14 = alloca [2 x i8], align 1
  %t15 = getelementptr [2 x i8], [2 x i8]* %t14, i32 0, i32 0
  store i8 13, i8* %t15
  %t16 = getelementptr [2 x i8], [2 x i8]* %t14, i32 0, i32 1
  store i8 0, i8* %t16
  %t17 = getelementptr [2 x i8], [2 x i8]* %t14, i32 0, i32 0
  ret i8* %t17
merge5:
  %t18 = call i1 @is_double_quote(i8* %ch)
  br i1 %t18, label %then6, label %merge7
then6:
  %t19 = alloca [2 x i8], align 1
  %t20 = getelementptr [2 x i8], [2 x i8]* %t19, i32 0, i32 0
  store i8 34, i8* %t20
  %t21 = getelementptr [2 x i8], [2 x i8]* %t19, i32 0, i32 1
  store i8 0, i8* %t21
  %t22 = getelementptr [2 x i8], [2 x i8]* %t19, i32 0, i32 0
  ret i8* %t22
merge7:
  %t23 = call i1 @is_backslash(i8* %ch)
  br i1 %t23, label %then8, label %merge9
then8:
  %t24 = alloca [2 x i8], align 1
  %t25 = getelementptr [2 x i8], [2 x i8]* %t24, i32 0, i32 0
  store i8 92, i8* %t25
  %t26 = getelementptr [2 x i8], [2 x i8]* %t24, i32 0, i32 1
  store i8 0, i8* %t26
  %t27 = getelementptr [2 x i8], [2 x i8]* %t24, i32 0, i32 0
  ret i8* %t27
merge9:
  ret i8* %ch
}

define i1 @is_two_char_symbol(i8* %value) {
entry:
  %s1 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.1, i32 0, i32 0
  %t2 = icmp eq i8* %value, %s1
  br label %logical_or_entry_0

logical_or_entry_0:
  br i1 %t2, label %logical_or_merge_0, label %logical_or_right_0

logical_or_right_0:
  %s4 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.4, i32 0, i32 0
  %t5 = icmp eq i8* %value, %s4
  br label %logical_or_entry_3

logical_or_entry_3:
  br i1 %t5, label %logical_or_merge_3, label %logical_or_right_3

logical_or_right_3:
  %s7 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.7, i32 0, i32 0
  %t8 = icmp eq i8* %value, %s7
  br label %logical_or_entry_6

logical_or_entry_6:
  br i1 %t8, label %logical_or_merge_6, label %logical_or_right_6

logical_or_right_6:
  %s10 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.10, i32 0, i32 0
  %t11 = icmp eq i8* %value, %s10
  br label %logical_or_entry_9

logical_or_entry_9:
  br i1 %t11, label %logical_or_merge_9, label %logical_or_right_9

logical_or_right_9:
  %s13 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.13, i32 0, i32 0
  %t14 = icmp eq i8* %value, %s13
  br label %logical_or_entry_12

logical_or_entry_12:
  br i1 %t14, label %logical_or_merge_12, label %logical_or_right_12

logical_or_right_12:
  %s16 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.16, i32 0, i32 0
  %t17 = icmp eq i8* %value, %s16
  br label %logical_or_entry_15

logical_or_entry_15:
  br i1 %t17, label %logical_or_merge_15, label %logical_or_right_15

logical_or_right_15:
  %s19 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.19, i32 0, i32 0
  %t20 = icmp eq i8* %value, %s19
  br label %logical_or_entry_18

logical_or_entry_18:
  br i1 %t20, label %logical_or_merge_18, label %logical_or_right_18

logical_or_right_18:
  %s22 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.22, i32 0, i32 0
  %t23 = icmp eq i8* %value, %s22
  br label %logical_or_entry_21

logical_or_entry_21:
  br i1 %t23, label %logical_or_merge_21, label %logical_or_right_21

logical_or_right_21:
  %s24 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.24, i32 0, i32 0
  %t25 = icmp eq i8* %value, %s24
  br label %logical_or_right_end_21

logical_or_right_end_21:
  br label %logical_or_merge_21

logical_or_merge_21:
  %t26 = phi i1 [ true, %logical_or_entry_21 ], [ %t25, %logical_or_right_end_21 ]
  br label %logical_or_right_end_18

logical_or_right_end_18:
  br label %logical_or_merge_18

logical_or_merge_18:
  %t27 = phi i1 [ true, %logical_or_entry_18 ], [ %t26, %logical_or_right_end_18 ]
  br label %logical_or_right_end_15

logical_or_right_end_15:
  br label %logical_or_merge_15

logical_or_merge_15:
  %t28 = phi i1 [ true, %logical_or_entry_15 ], [ %t27, %logical_or_right_end_15 ]
  br label %logical_or_right_end_12

logical_or_right_end_12:
  br label %logical_or_merge_12

logical_or_merge_12:
  %t29 = phi i1 [ true, %logical_or_entry_12 ], [ %t28, %logical_or_right_end_12 ]
  br label %logical_or_right_end_9

logical_or_right_end_9:
  br label %logical_or_merge_9

logical_or_merge_9:
  %t30 = phi i1 [ true, %logical_or_entry_9 ], [ %t29, %logical_or_right_end_9 ]
  br label %logical_or_right_end_6

logical_or_right_end_6:
  br label %logical_or_merge_6

logical_or_merge_6:
  %t31 = phi i1 [ true, %logical_or_entry_6 ], [ %t30, %logical_or_right_end_6 ]
  br label %logical_or_right_end_3

logical_or_right_end_3:
  br label %logical_or_merge_3

logical_or_merge_3:
  %t32 = phi i1 [ true, %logical_or_entry_3 ], [ %t31, %logical_or_right_end_3 ]
  br label %logical_or_right_end_0

logical_or_right_end_0:
  br label %logical_or_merge_0

logical_or_merge_0:
  %t33 = phi i1 [ true, %logical_or_entry_0 ], [ %t32, %logical_or_right_end_0 ]
  ret i1 %t33
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
