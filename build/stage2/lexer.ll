; ModuleID = 'sailfin'
source_filename = "sailfin"

%LexerState = type { i8*, double, double, double }
%Token = type { %TokenKind, i8*, double, double }

%TokenKind = type { i32, [8 x i8] }

declare i8* @sailfin_runtime_substring(i8*, i64, i64)
declare double @char_code(i8*)

declare noalias i8* @malloc(i64)

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
  %l30 = alloca double
  %l31 = alloca i8*
  %l32 = alloca double
  %l33 = alloca double
  %l34 = alloca double
  %l35 = alloca i8*
  %l36 = alloca i1
  %l37 = alloca double
  %l38 = alloca double
  %l39 = alloca i8
  %l40 = alloca i8*
  %l41 = alloca i8
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
  %t798 = phi { %Token*, i64 }* [ %t13, %entry ], [ %t797, %loop.latch2 ]
  store { %Token*, i64 }* %t798, { %Token*, i64 }** %l1
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
  %t105 = insertvalue %Token undef, %TokenKind %t104, 0
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
  %t114 = icmp eq i8 %t113, 47
  %t115 = load %LexerState, %LexerState* %l0
  %t116 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t117 = load i8, i8* %l2
  br i1 %t114, label %then19, label %merge20
then19:
  %t118 = load %LexerState, %LexerState* %l0
  %t119 = call i8* @peek_next_char(%LexerState %t118)
  store i8* %t119, i8** %l7
  %t120 = load i8*, i8** %l7
  %t121 = load i8, i8* %t120
  %t122 = icmp eq i8 %t121, 47
  %t123 = load %LexerState, %LexerState* %l0
  %t124 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t125 = load i8, i8* %l2
  %t126 = load i8*, i8** %l7
  br i1 %t122, label %then21, label %merge22
then21:
  %t127 = load %LexerState, %LexerState* %l0
  %t128 = extractvalue %LexerState %t127, 1
  store double %t128, double* %l8
  %t129 = load %LexerState, %LexerState* %l0
  %t130 = extractvalue %LexerState %t129, 2
  store double %t130, double* %l9
  %t131 = load %LexerState, %LexerState* %l0
  %t132 = extractvalue %LexerState %t131, 3
  store double %t132, double* %l10
  %t133 = load %LexerState, %LexerState* %l0
  %t134 = extractvalue %LexerState %t133, 0
  %t135 = load %LexerState, %LexerState* %l0
  %t136 = extractvalue %LexerState %t135, 1
  %t137 = call double @find_char(i8* %t134, i8 10, double %t136)
  store double %t137, double* %l11
  %t138 = load %LexerState, %LexerState* %l0
  %t139 = extractvalue %LexerState %t138, 0
  %t140 = load %LexerState, %LexerState* %l0
  %t141 = extractvalue %LexerState %t140, 1
  %t142 = call double @find_char(i8* %t139, i8 13, double %t141)
  store double %t142, double* %l12
  %t143 = load %LexerState, %LexerState* %l0
  %t144 = extractvalue %LexerState %t143, 0
  %t145 = call i64 @sailfin_runtime_string_length(i8* %t144)
  %t146 = sitofp i64 %t145 to double
  store double %t146, double* %l13
  %t147 = load double, double* %l11
  %t148 = sitofp i64 -1 to double
  %t149 = fcmp une double %t147, %t148
  %t150 = load %LexerState, %LexerState* %l0
  %t151 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t152 = load i8, i8* %l2
  %t153 = load i8*, i8** %l7
  %t154 = load double, double* %l8
  %t155 = load double, double* %l9
  %t156 = load double, double* %l10
  %t157 = load double, double* %l11
  %t158 = load double, double* %l12
  %t159 = load double, double* %l13
  br i1 %t149, label %then23, label %merge24
then23:
  %t160 = load double, double* %l11
  store double %t160, double* %l13
  br label %merge24
merge24:
  %t161 = phi double [ %t160, %then23 ], [ %t159, %then21 ]
  store double %t161, double* %l13
  %t163 = load double, double* %l12
  %t164 = sitofp i64 -1 to double
  %t165 = fcmp une double %t163, %t164
  br label %logical_and_entry_162

logical_and_entry_162:
  br i1 %t165, label %logical_and_right_162, label %logical_and_merge_162

logical_and_right_162:
  %t166 = load double, double* %l12
  %t167 = load double, double* %l13
  %t168 = fcmp olt double %t166, %t167
  br label %logical_and_right_end_162

logical_and_right_end_162:
  br label %logical_and_merge_162

logical_and_merge_162:
  %t169 = phi i1 [ false, %logical_and_entry_162 ], [ %t168, %logical_and_right_end_162 ]
  %t170 = load %LexerState, %LexerState* %l0
  %t171 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t172 = load i8, i8* %l2
  %t173 = load i8*, i8** %l7
  %t174 = load double, double* %l8
  %t175 = load double, double* %l9
  %t176 = load double, double* %l10
  %t177 = load double, double* %l11
  %t178 = load double, double* %l12
  %t179 = load double, double* %l13
  br i1 %t169, label %then25, label %merge26
then25:
  %t180 = load double, double* %l12
  store double %t180, double* %l13
  br label %merge26
merge26:
  %t181 = phi double [ %t180, %then25 ], [ %t179, %then21 ]
  store double %t181, double* %l13
  %t182 = load %LexerState, %LexerState* %l0
  %t183 = extractvalue %LexerState %t182, 0
  %t184 = load double, double* %l8
  %t185 = load double, double* %l13
  %t186 = call i8* @slice(i8* %t183, double %t184, double %t185)
  store i8* %t186, i8** %l14
  %t187 = load double, double* %l13
  %t188 = load %LexerState, %LexerState* %l0
  %t189 = extractvalue %LexerState %t188, 1
  %t190 = fsub double %t187, %t189
  store double %t190, double* %l15
  %t191 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t192 = insertvalue %TokenKind undef, i32 6, 0
  %t193 = insertvalue %Token undef, %TokenKind %t192, 0
  %t194 = load i8*, i8** %l14
  %t195 = insertvalue %Token %t193, i8* %t194, 1
  %t196 = load double, double* %l9
  %t197 = insertvalue %Token %t195, double %t196, 2
  %t198 = load double, double* %l10
  %t199 = insertvalue %Token %t197, double %t198, 3
  %t200 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t191, %Token %t199)
  store { %Token*, i64 }* %t200, { %Token*, i64 }** %l1
  br label %loop.latch2
merge22:
  %t201 = load i8*, i8** %l7
  %t202 = load i8, i8* %t201
  %t203 = icmp eq i8 %t202, 42
  %t204 = load %LexerState, %LexerState* %l0
  %t205 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t206 = load i8, i8* %l2
  %t207 = load i8*, i8** %l7
  br i1 %t203, label %then27, label %merge28
then27:
  %t208 = load %LexerState, %LexerState* %l0
  %t209 = extractvalue %LexerState %t208, 1
  store double %t209, double* %l16
  %t210 = load %LexerState, %LexerState* %l0
  %t211 = extractvalue %LexerState %t210, 2
  store double %t211, double* %l17
  %t212 = load %LexerState, %LexerState* %l0
  %t213 = extractvalue %LexerState %t212, 3
  store double %t213, double* %l18
  %t214 = load %LexerState, %LexerState* %l0
  %t215 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t216 = load i8, i8* %l2
  %t217 = load i8*, i8** %l7
  %t218 = load double, double* %l16
  %t219 = load double, double* %l17
  %t220 = load double, double* %l18
  br label %loop.header29
loop.header29:
  br label %loop.body30
loop.body30:
  %t221 = load %LexerState, %LexerState* %l0
  %t222 = extractvalue %LexerState %t221, 1
  %t223 = load %LexerState, %LexerState* %l0
  %t224 = extractvalue %LexerState %t223, 0
  %t225 = call i64 @sailfin_runtime_string_length(i8* %t224)
  %t226 = sitofp i64 %t225 to double
  %t227 = fcmp oge double %t222, %t226
  %t228 = load %LexerState, %LexerState* %l0
  %t229 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t230 = load i8, i8* %l2
  %t231 = load i8*, i8** %l7
  %t232 = load double, double* %l16
  %t233 = load double, double* %l17
  %t234 = load double, double* %l18
  br i1 %t227, label %then33, label %merge34
then33:
  br label %afterloop32
merge34:
  %t236 = load %LexerState, %LexerState* %l0
  %t237 = extractvalue %LexerState %t236, 0
  %t238 = load %LexerState, %LexerState* %l0
  %t239 = extractvalue %LexerState %t238, 1
  %t240 = fptosi double %t239 to i64
  %t241 = getelementptr i8, i8* %t237, i64 %t240
  %t242 = load i8, i8* %t241
  %t243 = icmp eq i8 %t242, 42
  br label %logical_and_entry_235

logical_and_entry_235:
  br i1 %t243, label %logical_and_right_235, label %logical_and_merge_235

logical_and_right_235:
  %t244 = load %LexerState, %LexerState* %l0
  %t245 = call i8* @peek_next_char(%LexerState %t244)
  %t246 = load i8, i8* %t245
  %t247 = icmp eq i8 %t246, 47
  br label %logical_and_right_end_235

logical_and_right_end_235:
  br label %logical_and_merge_235

logical_and_merge_235:
  %t248 = phi i1 [ false, %logical_and_entry_235 ], [ %t247, %logical_and_right_end_235 ]
  %t249 = load %LexerState, %LexerState* %l0
  %t250 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t251 = load i8, i8* %l2
  %t252 = load i8*, i8** %l7
  %t253 = load double, double* %l16
  %t254 = load double, double* %l17
  %t255 = load double, double* %l18
  br i1 %t248, label %then35, label %merge36
then35:
  br label %afterloop32
merge36:
  %t256 = load %LexerState, %LexerState* %l0
  %t257 = extractvalue %LexerState %t256, 0
  %t258 = load %LexerState, %LexerState* %l0
  %t259 = extractvalue %LexerState %t258, 1
  %t260 = fptosi double %t259 to i64
  %t261 = getelementptr i8, i8* %t257, i64 %t260
  %t262 = load i8, i8* %t261
  %t263 = icmp eq i8 %t262, 10
  %t264 = load %LexerState, %LexerState* %l0
  %t265 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t266 = load i8, i8* %l2
  %t267 = load i8*, i8** %l7
  %t268 = load double, double* %l16
  %t269 = load double, double* %l17
  %t270 = load double, double* %l18
  br i1 %t263, label %then37, label %else38
then37:
  br label %merge39
else38:
  br label %merge39
merge39:
  br label %loop.latch31
loop.latch31:
  br label %loop.header29
afterloop32:
  %t271 = load %LexerState, %LexerState* %l0
  %t272 = extractvalue %LexerState %t271, 0
  %t273 = load double, double* %l16
  %t274 = load %LexerState, %LexerState* %l0
  %t275 = extractvalue %LexerState %t274, 1
  %t276 = call i8* @slice(i8* %t272, double %t273, double %t275)
  store i8* %t276, i8** %l19
  %t277 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t278 = insertvalue %TokenKind undef, i32 6, 0
  %t279 = insertvalue %Token undef, %TokenKind %t278, 0
  %t280 = load i8*, i8** %l19
  %t281 = insertvalue %Token %t279, i8* %t280, 1
  %t282 = load double, double* %l17
  %t283 = insertvalue %Token %t281, double %t282, 2
  %t284 = load double, double* %l18
  %t285 = insertvalue %Token %t283, double %t284, 3
  %t286 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t277, %Token %t285)
  store { %Token*, i64 }* %t286, { %Token*, i64 }** %l1
  br label %loop.latch2
merge28:
  br label %merge20
merge20:
  %t287 = phi { %Token*, i64 }* [ %t200, %then19 ], [ %t116, %loop.body1 ]
  %t288 = phi { %Token*, i64 }* [ %t286, %then19 ], [ %t116, %loop.body1 ]
  store { %Token*, i64 }* %t287, { %Token*, i64 }** %l1
  store { %Token*, i64 }* %t288, { %Token*, i64 }** %l1
  %t289 = load i8, i8* %l2
  %t290 = alloca [2 x i8], align 1
  %t291 = getelementptr [2 x i8], [2 x i8]* %t290, i32 0, i32 0
  store i8 %t289, i8* %t291
  %t292 = getelementptr [2 x i8], [2 x i8]* %t290, i32 0, i32 1
  store i8 0, i8* %t292
  %t293 = getelementptr [2 x i8], [2 x i8]* %t290, i32 0, i32 0
  %t294 = call i1 @is_double_quote(i8* %t293)
  %t295 = load %LexerState, %LexerState* %l0
  %t296 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t297 = load i8, i8* %l2
  br i1 %t294, label %then40, label %merge41
then40:
  %t298 = load %LexerState, %LexerState* %l0
  %t299 = extractvalue %LexerState %t298, 1
  store double %t299, double* %l20
  %t300 = load %LexerState, %LexerState* %l0
  %t301 = extractvalue %LexerState %t300, 2
  store double %t301, double* %l21
  %t302 = load %LexerState, %LexerState* %l0
  %t303 = extractvalue %LexerState %t302, 3
  store double %t303, double* %l22
  %s304 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.304, i32 0, i32 0
  store i8* %s304, i8** %l23
  store i1 0, i1* %l24
  %t305 = load %LexerState, %LexerState* %l0
  %t306 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t307 = load i8, i8* %l2
  %t308 = load double, double* %l20
  %t309 = load double, double* %l21
  %t310 = load double, double* %l22
  %t311 = load i8*, i8** %l23
  %t312 = load i1, i1* %l24
  br label %loop.header42
loop.header42:
  %t414 = phi i1 [ %t312, %then40 ], [ %t412, %loop.latch44 ]
  %t415 = phi i8* [ %t311, %then40 ], [ %t413, %loop.latch44 ]
  store i1 %t414, i1* %l24
  store i8* %t415, i8** %l23
  br label %loop.body43
loop.body43:
  %t313 = load %LexerState, %LexerState* %l0
  %t314 = extractvalue %LexerState %t313, 1
  %t315 = load %LexerState, %LexerState* %l0
  %t316 = extractvalue %LexerState %t315, 0
  %t317 = call i64 @sailfin_runtime_string_length(i8* %t316)
  %t318 = sitofp i64 %t317 to double
  %t319 = fcmp oge double %t314, %t318
  %t320 = load %LexerState, %LexerState* %l0
  %t321 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t322 = load i8, i8* %l2
  %t323 = load double, double* %l20
  %t324 = load double, double* %l21
  %t325 = load double, double* %l22
  %t326 = load i8*, i8** %l23
  %t327 = load i1, i1* %l24
  br i1 %t319, label %then46, label %merge47
then46:
  br label %afterloop45
merge47:
  %t328 = load %LexerState, %LexerState* %l0
  %t329 = extractvalue %LexerState %t328, 0
  %t330 = load %LexerState, %LexerState* %l0
  %t331 = extractvalue %LexerState %t330, 1
  %t332 = fptosi double %t331 to i64
  %t333 = getelementptr i8, i8* %t329, i64 %t332
  %t334 = load i8, i8* %t333
  store i8 %t334, i8* %l25
  %t336 = load i1, i1* %l24
  br label %logical_and_entry_335

logical_and_entry_335:
  br i1 %t336, label %logical_and_right_335, label %logical_and_merge_335

logical_and_right_335:
  %t337 = load i8, i8* %l25
  %t338 = alloca [2 x i8], align 1
  %t339 = getelementptr [2 x i8], [2 x i8]* %t338, i32 0, i32 0
  store i8 %t337, i8* %t339
  %t340 = getelementptr [2 x i8], [2 x i8]* %t338, i32 0, i32 1
  store i8 0, i8* %t340
  %t341 = getelementptr [2 x i8], [2 x i8]* %t338, i32 0, i32 0
  %t342 = call i1 @is_double_quote(i8* %t341)
  br label %logical_and_right_end_335

logical_and_right_end_335:
  br label %logical_and_merge_335

logical_and_merge_335:
  %t343 = phi i1 [ false, %logical_and_entry_335 ], [ %t342, %logical_and_right_end_335 ]
  %t344 = xor i1 %t343, 1
  %t345 = load %LexerState, %LexerState* %l0
  %t346 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t347 = load i8, i8* %l2
  %t348 = load double, double* %l20
  %t349 = load double, double* %l21
  %t350 = load double, double* %l22
  %t351 = load i8*, i8** %l23
  %t352 = load i1, i1* %l24
  %t353 = load i8, i8* %l25
  br i1 %t344, label %then48, label %merge49
then48:
  br label %afterloop45
merge49:
  %t355 = load i1, i1* %l24
  br label %logical_and_entry_354

logical_and_entry_354:
  br i1 %t355, label %logical_and_right_354, label %logical_and_merge_354

logical_and_right_354:
  %t356 = load i8, i8* %l25
  %t357 = alloca [2 x i8], align 1
  %t358 = getelementptr [2 x i8], [2 x i8]* %t357, i32 0, i32 0
  store i8 %t356, i8* %t358
  %t359 = getelementptr [2 x i8], [2 x i8]* %t357, i32 0, i32 1
  store i8 0, i8* %t359
  %t360 = getelementptr [2 x i8], [2 x i8]* %t357, i32 0, i32 0
  %t361 = call i1 @is_backslash(i8* %t360)
  br label %logical_and_right_end_354

logical_and_right_end_354:
  br label %logical_and_merge_354

logical_and_merge_354:
  %t362 = phi i1 [ false, %logical_and_entry_354 ], [ %t361, %logical_and_right_end_354 ]
  %t363 = xor i1 %t362, 1
  %t364 = load %LexerState, %LexerState* %l0
  %t365 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t366 = load i8, i8* %l2
  %t367 = load double, double* %l20
  %t368 = load double, double* %l21
  %t369 = load double, double* %l22
  %t370 = load i8*, i8** %l23
  %t371 = load i1, i1* %l24
  %t372 = load i8, i8* %l25
  br i1 %t363, label %then50, label %merge51
then50:
  store i1 1, i1* %l24
  br label %loop.latch44
merge51:
  %t373 = load i1, i1* %l24
  %t374 = load %LexerState, %LexerState* %l0
  %t375 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t376 = load i8, i8* %l2
  %t377 = load double, double* %l20
  %t378 = load double, double* %l21
  %t379 = load double, double* %l22
  %t380 = load i8*, i8** %l23
  %t381 = load i1, i1* %l24
  %t382 = load i8, i8* %l25
  br i1 %t373, label %then52, label %else53
then52:
  %t383 = load i8*, i8** %l23
  %t384 = load i8, i8* %l25
  %t385 = alloca [2 x i8], align 1
  %t386 = getelementptr [2 x i8], [2 x i8]* %t385, i32 0, i32 0
  store i8 %t384, i8* %t386
  %t387 = getelementptr [2 x i8], [2 x i8]* %t385, i32 0, i32 1
  store i8 0, i8* %t387
  %t388 = getelementptr [2 x i8], [2 x i8]* %t385, i32 0, i32 0
  %t389 = call i8* @interpret_escape(i8* %t388)
  %t390 = add i8* %t383, %t389
  store i8* %t390, i8** %l23
  store i1 0, i1* %l24
  br label %merge54
else53:
  %t391 = load i8*, i8** %l23
  %t392 = load i8, i8* %l25
  %t393 = load i8, i8* %t391
  %t394 = add i8 %t393, %t392
  %t395 = alloca [2 x i8], align 1
  %t396 = getelementptr [2 x i8], [2 x i8]* %t395, i32 0, i32 0
  store i8 %t394, i8* %t396
  %t397 = getelementptr [2 x i8], [2 x i8]* %t395, i32 0, i32 1
  store i8 0, i8* %t397
  %t398 = getelementptr [2 x i8], [2 x i8]* %t395, i32 0, i32 0
  store i8* %t398, i8** %l23
  br label %merge54
merge54:
  %t399 = phi i8* [ %t390, %then52 ], [ %t398, %else53 ]
  %t400 = phi i1 [ 0, %then52 ], [ %t381, %else53 ]
  store i8* %t399, i8** %l23
  store i1 %t400, i1* %l24
  %t401 = load i8, i8* %l25
  %t402 = icmp eq i8 %t401, 10
  %t403 = load %LexerState, %LexerState* %l0
  %t404 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t405 = load i8, i8* %l2
  %t406 = load double, double* %l20
  %t407 = load double, double* %l21
  %t408 = load double, double* %l22
  %t409 = load i8*, i8** %l23
  %t410 = load i1, i1* %l24
  %t411 = load i8, i8* %l25
  br i1 %t402, label %then55, label %else56
then55:
  br label %merge57
else56:
  br label %merge57
merge57:
  br label %loop.latch44
loop.latch44:
  %t412 = load i1, i1* %l24
  %t413 = load i8*, i8** %l23
  br label %loop.header42
afterloop45:
  %t416 = load %LexerState, %LexerState* %l0
  %t417 = extractvalue %LexerState %t416, 0
  %t418 = load double, double* %l20
  %t419 = load %LexerState, %LexerState* %l0
  %t420 = extractvalue %LexerState %t419, 1
  %t421 = call i8* @slice(i8* %t417, double %t418, double %t420)
  store i8* %t421, i8** %l26
  %t422 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t423 = alloca %TokenKind
  %t424 = getelementptr inbounds %TokenKind, %TokenKind* %t423, i32 0, i32 0
  store i32 2, i32* %t424
  %t425 = load i8*, i8** %l23
  %t426 = getelementptr inbounds %TokenKind, %TokenKind* %t423, i32 0, i32 1
  %t427 = bitcast [8 x i8]* %t426 to i8*
  %t428 = bitcast i8* %t427 to i8**
  store i8* %t425, i8** %t428
  %t429 = load %TokenKind, %TokenKind* %t423
  %t430 = insertvalue %Token undef, %TokenKind %t429, 0
  %t431 = load i8*, i8** %l26
  %t432 = insertvalue %Token %t430, i8* %t431, 1
  %t433 = load double, double* %l21
  %t434 = insertvalue %Token %t432, double %t433, 2
  %t435 = load double, double* %l22
  %t436 = insertvalue %Token %t434, double %t435, 3
  %t437 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t422, %Token %t436)
  store { %Token*, i64 }* %t437, { %Token*, i64 }** %l1
  br label %loop.latch2
merge41:
  %t438 = load i8, i8* %l2
  %t439 = alloca [2 x i8], align 1
  %t440 = getelementptr [2 x i8], [2 x i8]* %t439, i32 0, i32 0
  store i8 %t438, i8* %t440
  %t441 = getelementptr [2 x i8], [2 x i8]* %t439, i32 0, i32 1
  store i8 0, i8* %t441
  %t442 = getelementptr [2 x i8], [2 x i8]* %t439, i32 0, i32 0
  %t443 = call i1 @is_digit(i8* %t442)
  %t444 = load %LexerState, %LexerState* %l0
  %t445 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t446 = load i8, i8* %l2
  br i1 %t443, label %then58, label %merge59
then58:
  %t447 = load %LexerState, %LexerState* %l0
  %t448 = extractvalue %LexerState %t447, 1
  store double %t448, double* %l27
  %t449 = load %LexerState, %LexerState* %l0
  %t450 = extractvalue %LexerState %t449, 2
  store double %t450, double* %l28
  %t451 = load %LexerState, %LexerState* %l0
  %t452 = extractvalue %LexerState %t451, 3
  store double %t452, double* %l29
  %t453 = load %LexerState, %LexerState* %l0
  %t454 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t455 = load i8, i8* %l2
  %t456 = load double, double* %l27
  %t457 = load double, double* %l28
  %t458 = load double, double* %l29
  br label %loop.header60
loop.header60:
  br label %loop.body61
loop.body61:
  %t459 = load %LexerState, %LexerState* %l0
  %t460 = extractvalue %LexerState %t459, 1
  %t461 = load %LexerState, %LexerState* %l0
  %t462 = extractvalue %LexerState %t461, 0
  %t463 = call i64 @sailfin_runtime_string_length(i8* %t462)
  %t464 = sitofp i64 %t463 to double
  %t465 = fcmp oge double %t460, %t464
  %t466 = load %LexerState, %LexerState* %l0
  %t467 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t468 = load i8, i8* %l2
  %t469 = load double, double* %l27
  %t470 = load double, double* %l28
  %t471 = load double, double* %l29
  br i1 %t465, label %then64, label %merge65
then64:
  br label %afterloop63
merge65:
  %t472 = load %LexerState, %LexerState* %l0
  %t473 = extractvalue %LexerState %t472, 0
  %t474 = load %LexerState, %LexerState* %l0
  %t475 = extractvalue %LexerState %t474, 1
  %t476 = fptosi double %t475 to i64
  %t477 = getelementptr i8, i8* %t473, i64 %t476
  %t478 = load i8, i8* %t477
  %t479 = alloca [2 x i8], align 1
  %t480 = getelementptr [2 x i8], [2 x i8]* %t479, i32 0, i32 0
  store i8 %t478, i8* %t480
  %t481 = getelementptr [2 x i8], [2 x i8]* %t479, i32 0, i32 1
  store i8 0, i8* %t481
  %t482 = getelementptr [2 x i8], [2 x i8]* %t479, i32 0, i32 0
  %t483 = call i1 @is_digit(i8* %t482)
  %t484 = xor i1 %t483, 1
  %t485 = load %LexerState, %LexerState* %l0
  %t486 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t487 = load i8, i8* %l2
  %t488 = load double, double* %l27
  %t489 = load double, double* %l28
  %t490 = load double, double* %l29
  br i1 %t484, label %then66, label %merge67
then66:
  br label %afterloop63
merge67:
  br label %loop.latch62
loop.latch62:
  br label %loop.header60
afterloop63:
  %t492 = load %LexerState, %LexerState* %l0
  %t493 = extractvalue %LexerState %t492, 1
  %t494 = load %LexerState, %LexerState* %l0
  %t495 = extractvalue %LexerState %t494, 0
  %t496 = call i64 @sailfin_runtime_string_length(i8* %t495)
  %t497 = sitofp i64 %t496 to double
  %t498 = fcmp olt double %t493, %t497
  br label %logical_and_entry_491

logical_and_entry_491:
  br i1 %t498, label %logical_and_right_491, label %logical_and_merge_491

logical_and_right_491:
  %t499 = load %LexerState, %LexerState* %l0
  %t500 = extractvalue %LexerState %t499, 0
  %t501 = load %LexerState, %LexerState* %l0
  %t502 = extractvalue %LexerState %t501, 1
  %t503 = fptosi double %t502 to i64
  %t504 = getelementptr i8, i8* %t500, i64 %t503
  %t505 = load i8, i8* %t504
  %t506 = icmp eq i8 %t505, 46
  br label %logical_and_right_end_491

logical_and_right_end_491:
  br label %logical_and_merge_491

logical_and_merge_491:
  %t507 = phi i1 [ false, %logical_and_entry_491 ], [ %t506, %logical_and_right_end_491 ]
  %t508 = load %LexerState, %LexerState* %l0
  %t509 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t510 = load i8, i8* %l2
  %t511 = load double, double* %l27
  %t512 = load double, double* %l28
  %t513 = load double, double* %l29
  br i1 %t507, label %then68, label %merge69
then68:
  %t515 = load %LexerState, %LexerState* %l0
  %t516 = extractvalue %LexerState %t515, 1
  %t517 = sitofp i64 1 to double
  %t518 = fadd double %t516, %t517
  %t519 = load %LexerState, %LexerState* %l0
  %t520 = extractvalue %LexerState %t519, 0
  %t521 = call i64 @sailfin_runtime_string_length(i8* %t520)
  %t522 = sitofp i64 %t521 to double
  %t523 = fcmp olt double %t518, %t522
  br label %logical_and_entry_514

logical_and_entry_514:
  br i1 %t523, label %logical_and_right_514, label %logical_and_merge_514

logical_and_right_514:
  store double 0.0, double* %l30
  %t524 = load double, double* %l30
  %t525 = fcmp one double %t524, 0.0
  %t526 = load %LexerState, %LexerState* %l0
  %t527 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t528 = load i8, i8* %l2
  %t529 = load double, double* %l27
  %t530 = load double, double* %l28
  %t531 = load double, double* %l29
  %t532 = load double, double* %l30
  br i1 %t525, label %then70, label %merge71
then70:
  %t533 = load %LexerState, %LexerState* %l0
  %t534 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t535 = load i8, i8* %l2
  %t536 = load double, double* %l27
  %t537 = load double, double* %l28
  %t538 = load double, double* %l29
  %t539 = load double, double* %l30
  br label %loop.header72
loop.header72:
  br label %loop.body73
loop.body73:
  %t540 = load %LexerState, %LexerState* %l0
  %t541 = extractvalue %LexerState %t540, 1
  %t542 = load %LexerState, %LexerState* %l0
  %t543 = extractvalue %LexerState %t542, 0
  %t544 = call i64 @sailfin_runtime_string_length(i8* %t543)
  %t545 = sitofp i64 %t544 to double
  %t546 = fcmp oge double %t541, %t545
  %t547 = load %LexerState, %LexerState* %l0
  %t548 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t549 = load i8, i8* %l2
  %t550 = load double, double* %l27
  %t551 = load double, double* %l28
  %t552 = load double, double* %l29
  %t553 = load double, double* %l30
  br i1 %t546, label %then76, label %merge77
then76:
  br label %afterloop75
merge77:
  %t554 = load %LexerState, %LexerState* %l0
  %t555 = extractvalue %LexerState %t554, 0
  %t556 = load %LexerState, %LexerState* %l0
  %t557 = extractvalue %LexerState %t556, 1
  %t558 = fptosi double %t557 to i64
  %t559 = getelementptr i8, i8* %t555, i64 %t558
  %t560 = load i8, i8* %t559
  %t561 = alloca [2 x i8], align 1
  %t562 = getelementptr [2 x i8], [2 x i8]* %t561, i32 0, i32 0
  store i8 %t560, i8* %t562
  %t563 = getelementptr [2 x i8], [2 x i8]* %t561, i32 0, i32 1
  store i8 0, i8* %t563
  %t564 = getelementptr [2 x i8], [2 x i8]* %t561, i32 0, i32 0
  %t565 = call i1 @is_digit(i8* %t564)
  %t566 = xor i1 %t565, 1
  %t567 = load %LexerState, %LexerState* %l0
  %t568 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t569 = load i8, i8* %l2
  %t570 = load double, double* %l27
  %t571 = load double, double* %l28
  %t572 = load double, double* %l29
  %t573 = load double, double* %l30
  br i1 %t566, label %then78, label %merge79
then78:
  br label %afterloop75
merge79:
  br label %loop.latch74
loop.latch74:
  br label %loop.header72
afterloop75:
  br label %merge71
merge71:
  br label %merge69
merge69:
  %t574 = load %LexerState, %LexerState* %l0
  %t575 = extractvalue %LexerState %t574, 0
  %t576 = load double, double* %l27
  %t577 = load %LexerState, %LexerState* %l0
  %t578 = extractvalue %LexerState %t577, 1
  %t579 = call i8* @slice(i8* %t575, double %t576, double %t578)
  store i8* %t579, i8** %l31
  %t580 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t581 = alloca %TokenKind
  %t582 = getelementptr inbounds %TokenKind, %TokenKind* %t581, i32 0, i32 0
  store i32 1, i32* %t582
  %t583 = load i8*, i8** %l31
  %t584 = getelementptr inbounds %TokenKind, %TokenKind* %t581, i32 0, i32 1
  %t585 = bitcast [8 x i8]* %t584 to i8*
  %t586 = bitcast i8* %t585 to i8**
  store i8* %t583, i8** %t586
  %t587 = load %TokenKind, %TokenKind* %t581
  %t588 = insertvalue %Token undef, %TokenKind %t587, 0
  %t589 = load i8*, i8** %l31
  %t590 = insertvalue %Token %t588, i8* %t589, 1
  %t591 = load double, double* %l28
  %t592 = insertvalue %Token %t590, double %t591, 2
  %t593 = load double, double* %l29
  %t594 = insertvalue %Token %t592, double %t593, 3
  %t595 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t580, %Token %t594)
  store { %Token*, i64 }* %t595, { %Token*, i64 }** %l1
  br label %loop.latch2
merge59:
  %t596 = load i8, i8* %l2
  %t597 = alloca [2 x i8], align 1
  %t598 = getelementptr [2 x i8], [2 x i8]* %t597, i32 0, i32 0
  store i8 %t596, i8* %t598
  %t599 = getelementptr [2 x i8], [2 x i8]* %t597, i32 0, i32 1
  store i8 0, i8* %t599
  %t600 = getelementptr [2 x i8], [2 x i8]* %t597, i32 0, i32 0
  %t601 = call i1 @is_identifier_start(i8* %t600)
  %t602 = load %LexerState, %LexerState* %l0
  %t603 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t604 = load i8, i8* %l2
  br i1 %t601, label %then80, label %merge81
then80:
  %t605 = load %LexerState, %LexerState* %l0
  %t606 = extractvalue %LexerState %t605, 1
  store double %t606, double* %l32
  %t607 = load %LexerState, %LexerState* %l0
  %t608 = extractvalue %LexerState %t607, 2
  store double %t608, double* %l33
  %t609 = load %LexerState, %LexerState* %l0
  %t610 = extractvalue %LexerState %t609, 3
  store double %t610, double* %l34
  %t611 = load %LexerState, %LexerState* %l0
  %t612 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t613 = load i8, i8* %l2
  %t614 = load double, double* %l32
  %t615 = load double, double* %l33
  %t616 = load double, double* %l34
  br label %loop.header82
loop.header82:
  br label %loop.body83
loop.body83:
  %t617 = load %LexerState, %LexerState* %l0
  %t618 = extractvalue %LexerState %t617, 1
  %t619 = load %LexerState, %LexerState* %l0
  %t620 = extractvalue %LexerState %t619, 0
  %t621 = call i64 @sailfin_runtime_string_length(i8* %t620)
  %t622 = sitofp i64 %t621 to double
  %t623 = fcmp oge double %t618, %t622
  %t624 = load %LexerState, %LexerState* %l0
  %t625 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t626 = load i8, i8* %l2
  %t627 = load double, double* %l32
  %t628 = load double, double* %l33
  %t629 = load double, double* %l34
  br i1 %t623, label %then86, label %merge87
then86:
  br label %afterloop85
merge87:
  %t630 = load %LexerState, %LexerState* %l0
  %t631 = extractvalue %LexerState %t630, 0
  %t632 = load %LexerState, %LexerState* %l0
  %t633 = extractvalue %LexerState %t632, 1
  %t634 = fptosi double %t633 to i64
  %t635 = getelementptr i8, i8* %t631, i64 %t634
  %t636 = load i8, i8* %t635
  %t637 = alloca [2 x i8], align 1
  %t638 = getelementptr [2 x i8], [2 x i8]* %t637, i32 0, i32 0
  store i8 %t636, i8* %t638
  %t639 = getelementptr [2 x i8], [2 x i8]* %t637, i32 0, i32 1
  store i8 0, i8* %t639
  %t640 = getelementptr [2 x i8], [2 x i8]* %t637, i32 0, i32 0
  %t641 = call i1 @is_identifier_part(i8* %t640)
  %t642 = xor i1 %t641, 1
  %t643 = load %LexerState, %LexerState* %l0
  %t644 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t645 = load i8, i8* %l2
  %t646 = load double, double* %l32
  %t647 = load double, double* %l33
  %t648 = load double, double* %l34
  br i1 %t642, label %then88, label %merge89
then88:
  br label %afterloop85
merge89:
  br label %loop.latch84
loop.latch84:
  br label %loop.header82
afterloop85:
  %t649 = load %LexerState, %LexerState* %l0
  %t650 = extractvalue %LexerState %t649, 0
  %t651 = load double, double* %l32
  %t652 = load %LexerState, %LexerState* %l0
  %t653 = extractvalue %LexerState %t652, 1
  %t654 = call i8* @slice(i8* %t650, double %t651, double %t653)
  store i8* %t654, i8** %l35
  %t656 = load i8*, i8** %l35
  %s657 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.657, i32 0, i32 0
  %t658 = icmp eq i8* %t656, %s657
  br label %logical_or_entry_655

logical_or_entry_655:
  br i1 %t658, label %logical_or_merge_655, label %logical_or_right_655

logical_or_right_655:
  %t659 = load i8*, i8** %l35
  %s660 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.660, i32 0, i32 0
  %t661 = icmp eq i8* %t659, %s660
  br label %logical_or_right_end_655

logical_or_right_end_655:
  br label %logical_or_merge_655

logical_or_merge_655:
  %t662 = phi i1 [ true, %logical_or_entry_655 ], [ %t661, %logical_or_right_end_655 ]
  %t663 = load %LexerState, %LexerState* %l0
  %t664 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t665 = load i8, i8* %l2
  %t666 = load double, double* %l32
  %t667 = load double, double* %l33
  %t668 = load double, double* %l34
  %t669 = load i8*, i8** %l35
  br i1 %t662, label %then90, label %else91
then90:
  %t670 = load i8*, i8** %l35
  %s671 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.671, i32 0, i32 0
  %t672 = icmp eq i8* %t670, %s671
  store i1 %t672, i1* %l36
  %t673 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t674 = alloca %TokenKind
  %t675 = getelementptr inbounds %TokenKind, %TokenKind* %t674, i32 0, i32 0
  store i32 3, i32* %t675
  %t676 = load i1, i1* %l36
  %t677 = getelementptr inbounds %TokenKind, %TokenKind* %t674, i32 0, i32 1
  %t678 = bitcast [1 x i8]* %t677 to i8*
  %t679 = bitcast i8* %t678 to i1*
  store i1 %t676, i1* %t679
  %t680 = load %TokenKind, %TokenKind* %t674
  %t681 = insertvalue %Token undef, %TokenKind %t680, 0
  %t682 = load i8*, i8** %l35
  %t683 = insertvalue %Token %t681, i8* %t682, 1
  %t684 = load double, double* %l33
  %t685 = insertvalue %Token %t683, double %t684, 2
  %t686 = load double, double* %l34
  %t687 = insertvalue %Token %t685, double %t686, 3
  %t688 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t673, %Token %t687)
  store { %Token*, i64 }* %t688, { %Token*, i64 }** %l1
  br label %merge92
else91:
  %t689 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t690 = alloca %TokenKind
  %t691 = getelementptr inbounds %TokenKind, %TokenKind* %t690, i32 0, i32 0
  store i32 0, i32* %t691
  %t692 = load i8*, i8** %l35
  %t693 = getelementptr inbounds %TokenKind, %TokenKind* %t690, i32 0, i32 1
  %t694 = bitcast [8 x i8]* %t693 to i8*
  %t695 = bitcast i8* %t694 to i8**
  store i8* %t692, i8** %t695
  %t696 = load %TokenKind, %TokenKind* %t690
  %t697 = insertvalue %Token undef, %TokenKind %t696, 0
  %t698 = load i8*, i8** %l35
  %t699 = insertvalue %Token %t697, i8* %t698, 1
  %t700 = load double, double* %l33
  %t701 = insertvalue %Token %t699, double %t700, 2
  %t702 = load double, double* %l34
  %t703 = insertvalue %Token %t701, double %t702, 3
  %t704 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t689, %Token %t703)
  store { %Token*, i64 }* %t704, { %Token*, i64 }** %l1
  br label %merge92
merge92:
  %t705 = phi { %Token*, i64 }* [ %t688, %then90 ], [ %t704, %else91 ]
  store { %Token*, i64 }* %t705, { %Token*, i64 }** %l1
  br label %loop.latch2
merge81:
  %t706 = load %LexerState, %LexerState* %l0
  %t707 = extractvalue %LexerState %t706, 2
  store double %t707, double* %l37
  %t708 = load %LexerState, %LexerState* %l0
  %t709 = extractvalue %LexerState %t708, 3
  store double %t709, double* %l38
  %t710 = load i8, i8* %l2
  store i8 %t710, i8* %l39
  %t711 = load %LexerState, %LexerState* %l0
  %t712 = call i8* @peek_next_char(%LexerState %t711)
  store i8* %t712, i8** %l40
  %t713 = load i8*, i8** %l40
  %s714 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.714, i32 0, i32 0
  %t715 = icmp ne i8* %t713, %s714
  %t716 = load %LexerState, %LexerState* %l0
  %t717 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t718 = load i8, i8* %l2
  %t719 = load double, double* %l37
  %t720 = load double, double* %l38
  %t721 = load i8, i8* %l39
  %t722 = load i8*, i8** %l40
  br i1 %t715, label %then93, label %merge94
then93:
  %t723 = load i8, i8* %l2
  %t724 = load i8*, i8** %l40
  %t725 = load i8, i8* %t724
  %t726 = add i8 %t723, %t725
  store i8 %t726, i8* %l41
  %t727 = load i8, i8* %l41
  %t728 = alloca [2 x i8], align 1
  %t729 = getelementptr [2 x i8], [2 x i8]* %t728, i32 0, i32 0
  store i8 %t727, i8* %t729
  %t730 = getelementptr [2 x i8], [2 x i8]* %t728, i32 0, i32 1
  store i8 0, i8* %t730
  %t731 = getelementptr [2 x i8], [2 x i8]* %t728, i32 0, i32 0
  %t732 = call i1 @is_two_char_symbol(i8* %t731)
  %t733 = load %LexerState, %LexerState* %l0
  %t734 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t735 = load i8, i8* %l2
  %t736 = load double, double* %l37
  %t737 = load double, double* %l38
  %t738 = load i8, i8* %l39
  %t739 = load i8*, i8** %l40
  %t740 = load i8, i8* %l41
  br i1 %t732, label %then95, label %merge96
then95:
  %t741 = load i8, i8* %l41
  store i8 %t741, i8* %l39
  %t742 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t743 = alloca %TokenKind
  %t744 = getelementptr inbounds %TokenKind, %TokenKind* %t743, i32 0, i32 0
  store i32 4, i32* %t744
  %t745 = load i8, i8* %l39
  %t746 = call noalias i8* @malloc(i64 1)
  %t747 = bitcast i8* %t746 to i8*
  store i8 %t745, i8* %t747
  %t748 = getelementptr inbounds %TokenKind, %TokenKind* %t743, i32 0, i32 1
  %t749 = bitcast [8 x i8]* %t748 to i8*
  %t750 = bitcast i8* %t749 to i8**
  store i8* %t746, i8** %t750
  %t751 = load %TokenKind, %TokenKind* %t743
  %t752 = insertvalue %Token undef, %TokenKind %t751, 0
  %t753 = load i8, i8* %l39
  %t754 = alloca [2 x i8], align 1
  %t755 = getelementptr [2 x i8], [2 x i8]* %t754, i32 0, i32 0
  store i8 %t753, i8* %t755
  %t756 = getelementptr [2 x i8], [2 x i8]* %t754, i32 0, i32 1
  store i8 0, i8* %t756
  %t757 = getelementptr [2 x i8], [2 x i8]* %t754, i32 0, i32 0
  %t758 = insertvalue %Token %t752, i8* %t757, 1
  %t759 = load double, double* %l37
  %t760 = insertvalue %Token %t758, double %t759, 2
  %t761 = load double, double* %l38
  %t762 = insertvalue %Token %t760, double %t761, 3
  %t763 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t742, %Token %t762)
  store { %Token*, i64 }* %t763, { %Token*, i64 }** %l1
  br label %loop.latch2
merge96:
  br label %merge94
merge94:
  %t764 = phi i8 [ %t741, %then93 ], [ %t721, %loop.body1 ]
  %t765 = phi { %Token*, i64 }* [ %t763, %then93 ], [ %t717, %loop.body1 ]
  store i8 %t764, i8* %l39
  store { %Token*, i64 }* %t765, { %Token*, i64 }** %l1
  %t766 = load i8, i8* %l2
  %t767 = icmp eq i8 %t766, 10
  %t768 = load %LexerState, %LexerState* %l0
  %t769 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t770 = load i8, i8* %l2
  %t771 = load double, double* %l37
  %t772 = load double, double* %l38
  %t773 = load i8, i8* %l39
  %t774 = load i8*, i8** %l40
  br i1 %t767, label %then97, label %else98
then97:
  br label %merge99
else98:
  br label %merge99
merge99:
  %t775 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t776 = alloca %TokenKind
  %t777 = getelementptr inbounds %TokenKind, %TokenKind* %t776, i32 0, i32 0
  store i32 4, i32* %t777
  %t778 = load i8, i8* %l39
  %t779 = call noalias i8* @malloc(i64 1)
  %t780 = bitcast i8* %t779 to i8*
  store i8 %t778, i8* %t780
  %t781 = getelementptr inbounds %TokenKind, %TokenKind* %t776, i32 0, i32 1
  %t782 = bitcast [8 x i8]* %t781 to i8*
  %t783 = bitcast i8* %t782 to i8**
  store i8* %t779, i8** %t783
  %t784 = load %TokenKind, %TokenKind* %t776
  %t785 = insertvalue %Token undef, %TokenKind %t784, 0
  %t786 = load i8, i8* %l39
  %t787 = alloca [2 x i8], align 1
  %t788 = getelementptr [2 x i8], [2 x i8]* %t787, i32 0, i32 0
  store i8 %t786, i8* %t788
  %t789 = getelementptr [2 x i8], [2 x i8]* %t787, i32 0, i32 1
  store i8 0, i8* %t789
  %t790 = getelementptr [2 x i8], [2 x i8]* %t787, i32 0, i32 0
  %t791 = insertvalue %Token %t785, i8* %t790, 1
  %t792 = load double, double* %l37
  %t793 = insertvalue %Token %t791, double %t792, 2
  %t794 = load double, double* %l38
  %t795 = insertvalue %Token %t793, double %t794, 3
  %t796 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t775, %Token %t795)
  store { %Token*, i64 }* %t796, { %Token*, i64 }** %l1
  br label %loop.latch2
loop.latch2:
  %t797 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br label %loop.header0
afterloop3:
  %t799 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t800 = load %LexerState, %LexerState* %l0
  %t801 = extractvalue %LexerState %t800, 2
  %t802 = load %LexerState, %LexerState* %l0
  %t803 = extractvalue %LexerState %t802, 3
  %t804 = call double @eof_token(double %t801, double %t803)
  %t805 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t799, %Token zeroinitializer)
  store { %Token*, i64 }* %t805, { %Token*, i64 }** %l1
  %t806 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  ret { %Token*, i64 }* %t806
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
