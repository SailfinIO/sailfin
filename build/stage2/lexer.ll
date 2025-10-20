; ModuleID = 'sailfin'
source_filename = "sailfin"

%LexerState = type { i8*, double, double, double }
%Token = type { %TokenKind*, i8*, double, double }

%TokenKind = type { i32, [8 x i8] }

declare i8* @sailfin_runtime_substring(i8*, i64, i64)

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
  %t803 = phi { %Token*, i64 }* [ %t13, %entry ], [ %t802, %loop.latch2 ]
  store { %Token*, i64 }* %t803, { %Token*, i64 }** %l1
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
  %t105 = insertvalue %Token undef, %TokenKind* null, 0
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
  %t121 = getelementptr i8, i8* %t120, i64 0
  %t122 = load i8, i8* %t121
  %t123 = icmp eq i8 %t122, 47
  %t124 = load %LexerState, %LexerState* %l0
  %t125 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t126 = load i8, i8* %l2
  %t127 = load i8*, i8** %l7
  br i1 %t123, label %then21, label %merge22
then21:
  %t128 = load %LexerState, %LexerState* %l0
  %t129 = extractvalue %LexerState %t128, 1
  store double %t129, double* %l8
  %t130 = load %LexerState, %LexerState* %l0
  %t131 = extractvalue %LexerState %t130, 2
  store double %t131, double* %l9
  %t132 = load %LexerState, %LexerState* %l0
  %t133 = extractvalue %LexerState %t132, 3
  store double %t133, double* %l10
  %t134 = load %LexerState, %LexerState* %l0
  %t135 = extractvalue %LexerState %t134, 0
  %t136 = load %LexerState, %LexerState* %l0
  %t137 = extractvalue %LexerState %t136, 1
  %t138 = call double @find_char(i8* %t135, i8 10, double %t137)
  store double %t138, double* %l11
  %t139 = load %LexerState, %LexerState* %l0
  %t140 = extractvalue %LexerState %t139, 0
  %t141 = load %LexerState, %LexerState* %l0
  %t142 = extractvalue %LexerState %t141, 1
  %t143 = call double @find_char(i8* %t140, i8 13, double %t142)
  store double %t143, double* %l12
  %t144 = load %LexerState, %LexerState* %l0
  %t145 = extractvalue %LexerState %t144, 0
  %t146 = call i64 @sailfin_runtime_string_length(i8* %t145)
  %t147 = sitofp i64 %t146 to double
  store double %t147, double* %l13
  %t148 = load double, double* %l11
  %t149 = sitofp i64 -1 to double
  %t150 = fcmp une double %t148, %t149
  %t151 = load %LexerState, %LexerState* %l0
  %t152 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t153 = load i8, i8* %l2
  %t154 = load i8*, i8** %l7
  %t155 = load double, double* %l8
  %t156 = load double, double* %l9
  %t157 = load double, double* %l10
  %t158 = load double, double* %l11
  %t159 = load double, double* %l12
  %t160 = load double, double* %l13
  br i1 %t150, label %then23, label %merge24
then23:
  %t161 = load double, double* %l11
  store double %t161, double* %l13
  br label %merge24
merge24:
  %t162 = phi double [ %t161, %then23 ], [ %t160, %then21 ]
  store double %t162, double* %l13
  %t164 = load double, double* %l12
  %t165 = sitofp i64 -1 to double
  %t166 = fcmp une double %t164, %t165
  br label %logical_and_entry_163

logical_and_entry_163:
  br i1 %t166, label %logical_and_right_163, label %logical_and_merge_163

logical_and_right_163:
  %t167 = load double, double* %l12
  %t168 = load double, double* %l13
  %t169 = fcmp olt double %t167, %t168
  br label %logical_and_right_end_163

logical_and_right_end_163:
  br label %logical_and_merge_163

logical_and_merge_163:
  %t170 = phi i1 [ false, %logical_and_entry_163 ], [ %t169, %logical_and_right_end_163 ]
  %t171 = load %LexerState, %LexerState* %l0
  %t172 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t173 = load i8, i8* %l2
  %t174 = load i8*, i8** %l7
  %t175 = load double, double* %l8
  %t176 = load double, double* %l9
  %t177 = load double, double* %l10
  %t178 = load double, double* %l11
  %t179 = load double, double* %l12
  %t180 = load double, double* %l13
  br i1 %t170, label %then25, label %merge26
then25:
  %t181 = load double, double* %l12
  store double %t181, double* %l13
  br label %merge26
merge26:
  %t182 = phi double [ %t181, %then25 ], [ %t180, %then21 ]
  store double %t182, double* %l13
  %t183 = load %LexerState, %LexerState* %l0
  %t184 = extractvalue %LexerState %t183, 0
  %t185 = load double, double* %l8
  %t186 = load double, double* %l13
  %t187 = call i8* @slice(i8* %t184, double %t185, double %t186)
  store i8* %t187, i8** %l14
  %t188 = load double, double* %l13
  %t189 = load %LexerState, %LexerState* %l0
  %t190 = extractvalue %LexerState %t189, 1
  %t191 = fsub double %t188, %t190
  store double %t191, double* %l15
  %t192 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t193 = insertvalue %TokenKind undef, i32 6, 0
  %t194 = insertvalue %Token undef, %TokenKind* null, 0
  %t195 = load i8*, i8** %l14
  %t196 = insertvalue %Token %t194, i8* %t195, 1
  %t197 = load double, double* %l9
  %t198 = insertvalue %Token %t196, double %t197, 2
  %t199 = load double, double* %l10
  %t200 = insertvalue %Token %t198, double %t199, 3
  %t201 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t192, %Token %t200)
  store { %Token*, i64 }* %t201, { %Token*, i64 }** %l1
  br label %loop.latch2
merge22:
  %t202 = load i8*, i8** %l7
  %t203 = getelementptr i8, i8* %t202, i64 0
  %t204 = load i8, i8* %t203
  %t205 = icmp eq i8 %t204, 42
  %t206 = load %LexerState, %LexerState* %l0
  %t207 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t208 = load i8, i8* %l2
  %t209 = load i8*, i8** %l7
  br i1 %t205, label %then27, label %merge28
then27:
  %t210 = load %LexerState, %LexerState* %l0
  %t211 = extractvalue %LexerState %t210, 1
  store double %t211, double* %l16
  %t212 = load %LexerState, %LexerState* %l0
  %t213 = extractvalue %LexerState %t212, 2
  store double %t213, double* %l17
  %t214 = load %LexerState, %LexerState* %l0
  %t215 = extractvalue %LexerState %t214, 3
  store double %t215, double* %l18
  %t216 = load %LexerState, %LexerState* %l0
  %t217 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t218 = load i8, i8* %l2
  %t219 = load i8*, i8** %l7
  %t220 = load double, double* %l16
  %t221 = load double, double* %l17
  %t222 = load double, double* %l18
  br label %loop.header29
loop.header29:
  br label %loop.body30
loop.body30:
  %t223 = load %LexerState, %LexerState* %l0
  %t224 = extractvalue %LexerState %t223, 1
  %t225 = load %LexerState, %LexerState* %l0
  %t226 = extractvalue %LexerState %t225, 0
  %t227 = call i64 @sailfin_runtime_string_length(i8* %t226)
  %t228 = sitofp i64 %t227 to double
  %t229 = fcmp oge double %t224, %t228
  %t230 = load %LexerState, %LexerState* %l0
  %t231 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t232 = load i8, i8* %l2
  %t233 = load i8*, i8** %l7
  %t234 = load double, double* %l16
  %t235 = load double, double* %l17
  %t236 = load double, double* %l18
  br i1 %t229, label %then33, label %merge34
then33:
  br label %afterloop32
merge34:
  %t238 = load %LexerState, %LexerState* %l0
  %t239 = extractvalue %LexerState %t238, 0
  %t240 = load %LexerState, %LexerState* %l0
  %t241 = extractvalue %LexerState %t240, 1
  %t242 = fptosi double %t241 to i64
  %t243 = getelementptr i8, i8* %t239, i64 %t242
  %t244 = load i8, i8* %t243
  %t245 = icmp eq i8 %t244, 42
  br label %logical_and_entry_237

logical_and_entry_237:
  br i1 %t245, label %logical_and_right_237, label %logical_and_merge_237

logical_and_right_237:
  %t246 = load %LexerState, %LexerState* %l0
  %t247 = call i8* @peek_next_char(%LexerState %t246)
  %t248 = getelementptr i8, i8* %t247, i64 0
  %t249 = load i8, i8* %t248
  %t250 = icmp eq i8 %t249, 47
  br label %logical_and_right_end_237

logical_and_right_end_237:
  br label %logical_and_merge_237

logical_and_merge_237:
  %t251 = phi i1 [ false, %logical_and_entry_237 ], [ %t250, %logical_and_right_end_237 ]
  %t252 = load %LexerState, %LexerState* %l0
  %t253 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t254 = load i8, i8* %l2
  %t255 = load i8*, i8** %l7
  %t256 = load double, double* %l16
  %t257 = load double, double* %l17
  %t258 = load double, double* %l18
  br i1 %t251, label %then35, label %merge36
then35:
  br label %afterloop32
merge36:
  %t259 = load %LexerState, %LexerState* %l0
  %t260 = extractvalue %LexerState %t259, 0
  %t261 = load %LexerState, %LexerState* %l0
  %t262 = extractvalue %LexerState %t261, 1
  %t263 = fptosi double %t262 to i64
  %t264 = getelementptr i8, i8* %t260, i64 %t263
  %t265 = load i8, i8* %t264
  %t266 = icmp eq i8 %t265, 10
  %t267 = load %LexerState, %LexerState* %l0
  %t268 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t269 = load i8, i8* %l2
  %t270 = load i8*, i8** %l7
  %t271 = load double, double* %l16
  %t272 = load double, double* %l17
  %t273 = load double, double* %l18
  br i1 %t266, label %then37, label %else38
then37:
  br label %merge39
else38:
  br label %merge39
merge39:
  br label %loop.latch31
loop.latch31:
  br label %loop.header29
afterloop32:
  %t274 = load %LexerState, %LexerState* %l0
  %t275 = extractvalue %LexerState %t274, 0
  %t276 = load double, double* %l16
  %t277 = load %LexerState, %LexerState* %l0
  %t278 = extractvalue %LexerState %t277, 1
  %t279 = call i8* @slice(i8* %t275, double %t276, double %t278)
  store i8* %t279, i8** %l19
  %t280 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t281 = insertvalue %TokenKind undef, i32 6, 0
  %t282 = insertvalue %Token undef, %TokenKind* null, 0
  %t283 = load i8*, i8** %l19
  %t284 = insertvalue %Token %t282, i8* %t283, 1
  %t285 = load double, double* %l17
  %t286 = insertvalue %Token %t284, double %t285, 2
  %t287 = load double, double* %l18
  %t288 = insertvalue %Token %t286, double %t287, 3
  %t289 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t280, %Token %t288)
  store { %Token*, i64 }* %t289, { %Token*, i64 }** %l1
  br label %loop.latch2
merge28:
  br label %merge20
merge20:
  %t290 = phi { %Token*, i64 }* [ %t201, %then19 ], [ %t116, %loop.body1 ]
  %t291 = phi { %Token*, i64 }* [ %t289, %then19 ], [ %t116, %loop.body1 ]
  store { %Token*, i64 }* %t290, { %Token*, i64 }** %l1
  store { %Token*, i64 }* %t291, { %Token*, i64 }** %l1
  %t292 = load i8, i8* %l2
  %t293 = alloca [2 x i8], align 1
  %t294 = getelementptr [2 x i8], [2 x i8]* %t293, i32 0, i32 0
  store i8 %t292, i8* %t294
  %t295 = getelementptr [2 x i8], [2 x i8]* %t293, i32 0, i32 1
  store i8 0, i8* %t295
  %t296 = getelementptr [2 x i8], [2 x i8]* %t293, i32 0, i32 0
  %t297 = call i1 @is_double_quote(i8* %t296)
  %t298 = load %LexerState, %LexerState* %l0
  %t299 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t300 = load i8, i8* %l2
  br i1 %t297, label %then40, label %merge41
then40:
  %t301 = load %LexerState, %LexerState* %l0
  %t302 = extractvalue %LexerState %t301, 1
  store double %t302, double* %l20
  %t303 = load %LexerState, %LexerState* %l0
  %t304 = extractvalue %LexerState %t303, 2
  store double %t304, double* %l21
  %t305 = load %LexerState, %LexerState* %l0
  %t306 = extractvalue %LexerState %t305, 3
  store double %t306, double* %l22
  %s307 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.307, i32 0, i32 0
  store i8* %s307, i8** %l23
  store i1 0, i1* %l24
  %t308 = load %LexerState, %LexerState* %l0
  %t309 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t310 = load i8, i8* %l2
  %t311 = load double, double* %l20
  %t312 = load double, double* %l21
  %t313 = load double, double* %l22
  %t314 = load i8*, i8** %l23
  %t315 = load i1, i1* %l24
  br label %loop.header42
loop.header42:
  %t418 = phi i1 [ %t315, %then40 ], [ %t416, %loop.latch44 ]
  %t419 = phi i8* [ %t314, %then40 ], [ %t417, %loop.latch44 ]
  store i1 %t418, i1* %l24
  store i8* %t419, i8** %l23
  br label %loop.body43
loop.body43:
  %t316 = load %LexerState, %LexerState* %l0
  %t317 = extractvalue %LexerState %t316, 1
  %t318 = load %LexerState, %LexerState* %l0
  %t319 = extractvalue %LexerState %t318, 0
  %t320 = call i64 @sailfin_runtime_string_length(i8* %t319)
  %t321 = sitofp i64 %t320 to double
  %t322 = fcmp oge double %t317, %t321
  %t323 = load %LexerState, %LexerState* %l0
  %t324 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t325 = load i8, i8* %l2
  %t326 = load double, double* %l20
  %t327 = load double, double* %l21
  %t328 = load double, double* %l22
  %t329 = load i8*, i8** %l23
  %t330 = load i1, i1* %l24
  br i1 %t322, label %then46, label %merge47
then46:
  br label %afterloop45
merge47:
  %t331 = load %LexerState, %LexerState* %l0
  %t332 = extractvalue %LexerState %t331, 0
  %t333 = load %LexerState, %LexerState* %l0
  %t334 = extractvalue %LexerState %t333, 1
  %t335 = fptosi double %t334 to i64
  %t336 = getelementptr i8, i8* %t332, i64 %t335
  %t337 = load i8, i8* %t336
  store i8 %t337, i8* %l25
  %t339 = load i1, i1* %l24
  br label %logical_and_entry_338

logical_and_entry_338:
  br i1 %t339, label %logical_and_right_338, label %logical_and_merge_338

logical_and_right_338:
  %t340 = load i8, i8* %l25
  %t341 = alloca [2 x i8], align 1
  %t342 = getelementptr [2 x i8], [2 x i8]* %t341, i32 0, i32 0
  store i8 %t340, i8* %t342
  %t343 = getelementptr [2 x i8], [2 x i8]* %t341, i32 0, i32 1
  store i8 0, i8* %t343
  %t344 = getelementptr [2 x i8], [2 x i8]* %t341, i32 0, i32 0
  %t345 = call i1 @is_double_quote(i8* %t344)
  br label %logical_and_right_end_338

logical_and_right_end_338:
  br label %logical_and_merge_338

logical_and_merge_338:
  %t346 = phi i1 [ false, %logical_and_entry_338 ], [ %t345, %logical_and_right_end_338 ]
  %t347 = xor i1 %t346, 1
  %t348 = load %LexerState, %LexerState* %l0
  %t349 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t350 = load i8, i8* %l2
  %t351 = load double, double* %l20
  %t352 = load double, double* %l21
  %t353 = load double, double* %l22
  %t354 = load i8*, i8** %l23
  %t355 = load i1, i1* %l24
  %t356 = load i8, i8* %l25
  br i1 %t347, label %then48, label %merge49
then48:
  br label %afterloop45
merge49:
  %t358 = load i1, i1* %l24
  br label %logical_and_entry_357

logical_and_entry_357:
  br i1 %t358, label %logical_and_right_357, label %logical_and_merge_357

logical_and_right_357:
  %t359 = load i8, i8* %l25
  %t360 = alloca [2 x i8], align 1
  %t361 = getelementptr [2 x i8], [2 x i8]* %t360, i32 0, i32 0
  store i8 %t359, i8* %t361
  %t362 = getelementptr [2 x i8], [2 x i8]* %t360, i32 0, i32 1
  store i8 0, i8* %t362
  %t363 = getelementptr [2 x i8], [2 x i8]* %t360, i32 0, i32 0
  %t364 = call i1 @is_backslash(i8* %t363)
  br label %logical_and_right_end_357

logical_and_right_end_357:
  br label %logical_and_merge_357

logical_and_merge_357:
  %t365 = phi i1 [ false, %logical_and_entry_357 ], [ %t364, %logical_and_right_end_357 ]
  %t366 = xor i1 %t365, 1
  %t367 = load %LexerState, %LexerState* %l0
  %t368 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t369 = load i8, i8* %l2
  %t370 = load double, double* %l20
  %t371 = load double, double* %l21
  %t372 = load double, double* %l22
  %t373 = load i8*, i8** %l23
  %t374 = load i1, i1* %l24
  %t375 = load i8, i8* %l25
  br i1 %t366, label %then50, label %merge51
then50:
  store i1 1, i1* %l24
  br label %loop.latch44
merge51:
  %t376 = load i1, i1* %l24
  %t377 = load %LexerState, %LexerState* %l0
  %t378 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t379 = load i8, i8* %l2
  %t380 = load double, double* %l20
  %t381 = load double, double* %l21
  %t382 = load double, double* %l22
  %t383 = load i8*, i8** %l23
  %t384 = load i1, i1* %l24
  %t385 = load i8, i8* %l25
  br i1 %t376, label %then52, label %else53
then52:
  %t386 = load i8*, i8** %l23
  %t387 = load i8, i8* %l25
  %t388 = alloca [2 x i8], align 1
  %t389 = getelementptr [2 x i8], [2 x i8]* %t388, i32 0, i32 0
  store i8 %t387, i8* %t389
  %t390 = getelementptr [2 x i8], [2 x i8]* %t388, i32 0, i32 1
  store i8 0, i8* %t390
  %t391 = getelementptr [2 x i8], [2 x i8]* %t388, i32 0, i32 0
  %t392 = call i8* @interpret_escape(i8* %t391)
  %t393 = add i8* %t386, %t392
  store i8* %t393, i8** %l23
  store i1 0, i1* %l24
  br label %merge54
else53:
  %t394 = load i8*, i8** %l23
  %t395 = load i8, i8* %l25
  %t396 = getelementptr i8, i8* %t394, i64 0
  %t397 = load i8, i8* %t396
  %t398 = add i8 %t397, %t395
  %t399 = alloca [2 x i8], align 1
  %t400 = getelementptr [2 x i8], [2 x i8]* %t399, i32 0, i32 0
  store i8 %t398, i8* %t400
  %t401 = getelementptr [2 x i8], [2 x i8]* %t399, i32 0, i32 1
  store i8 0, i8* %t401
  %t402 = getelementptr [2 x i8], [2 x i8]* %t399, i32 0, i32 0
  store i8* %t402, i8** %l23
  br label %merge54
merge54:
  %t403 = phi i8* [ %t393, %then52 ], [ %t402, %else53 ]
  %t404 = phi i1 [ 0, %then52 ], [ %t384, %else53 ]
  store i8* %t403, i8** %l23
  store i1 %t404, i1* %l24
  %t405 = load i8, i8* %l25
  %t406 = icmp eq i8 %t405, 10
  %t407 = load %LexerState, %LexerState* %l0
  %t408 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t409 = load i8, i8* %l2
  %t410 = load double, double* %l20
  %t411 = load double, double* %l21
  %t412 = load double, double* %l22
  %t413 = load i8*, i8** %l23
  %t414 = load i1, i1* %l24
  %t415 = load i8, i8* %l25
  br i1 %t406, label %then55, label %else56
then55:
  br label %merge57
else56:
  br label %merge57
merge57:
  br label %loop.latch44
loop.latch44:
  %t416 = load i1, i1* %l24
  %t417 = load i8*, i8** %l23
  br label %loop.header42
afterloop45:
  %t420 = load %LexerState, %LexerState* %l0
  %t421 = extractvalue %LexerState %t420, 0
  %t422 = load double, double* %l20
  %t423 = load %LexerState, %LexerState* %l0
  %t424 = extractvalue %LexerState %t423, 1
  %t425 = call i8* @slice(i8* %t421, double %t422, double %t424)
  store i8* %t425, i8** %l26
  %t426 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t427 = alloca %TokenKind
  %t428 = getelementptr inbounds %TokenKind, %TokenKind* %t427, i32 0, i32 0
  store i32 2, i32* %t428
  %t429 = load i8*, i8** %l23
  %t430 = getelementptr inbounds %TokenKind, %TokenKind* %t427, i32 0, i32 1
  %t431 = bitcast [8 x i8]* %t430 to i8*
  %t432 = bitcast i8* %t431 to i8**
  store i8* %t429, i8** %t432
  %t433 = load %TokenKind, %TokenKind* %t427
  %t434 = insertvalue %Token undef, %TokenKind* null, 0
  %t435 = load i8*, i8** %l26
  %t436 = insertvalue %Token %t434, i8* %t435, 1
  %t437 = load double, double* %l21
  %t438 = insertvalue %Token %t436, double %t437, 2
  %t439 = load double, double* %l22
  %t440 = insertvalue %Token %t438, double %t439, 3
  %t441 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t426, %Token %t440)
  store { %Token*, i64 }* %t441, { %Token*, i64 }** %l1
  br label %loop.latch2
merge41:
  %t442 = load i8, i8* %l2
  %t443 = alloca [2 x i8], align 1
  %t444 = getelementptr [2 x i8], [2 x i8]* %t443, i32 0, i32 0
  store i8 %t442, i8* %t444
  %t445 = getelementptr [2 x i8], [2 x i8]* %t443, i32 0, i32 1
  store i8 0, i8* %t445
  %t446 = getelementptr [2 x i8], [2 x i8]* %t443, i32 0, i32 0
  %t447 = call i1 @is_digit(i8* %t446)
  %t448 = load %LexerState, %LexerState* %l0
  %t449 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t450 = load i8, i8* %l2
  br i1 %t447, label %then58, label %merge59
then58:
  %t451 = load %LexerState, %LexerState* %l0
  %t452 = extractvalue %LexerState %t451, 1
  store double %t452, double* %l27
  %t453 = load %LexerState, %LexerState* %l0
  %t454 = extractvalue %LexerState %t453, 2
  store double %t454, double* %l28
  %t455 = load %LexerState, %LexerState* %l0
  %t456 = extractvalue %LexerState %t455, 3
  store double %t456, double* %l29
  %t457 = load %LexerState, %LexerState* %l0
  %t458 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t459 = load i8, i8* %l2
  %t460 = load double, double* %l27
  %t461 = load double, double* %l28
  %t462 = load double, double* %l29
  br label %loop.header60
loop.header60:
  br label %loop.body61
loop.body61:
  %t463 = load %LexerState, %LexerState* %l0
  %t464 = extractvalue %LexerState %t463, 1
  %t465 = load %LexerState, %LexerState* %l0
  %t466 = extractvalue %LexerState %t465, 0
  %t467 = call i64 @sailfin_runtime_string_length(i8* %t466)
  %t468 = sitofp i64 %t467 to double
  %t469 = fcmp oge double %t464, %t468
  %t470 = load %LexerState, %LexerState* %l0
  %t471 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t472 = load i8, i8* %l2
  %t473 = load double, double* %l27
  %t474 = load double, double* %l28
  %t475 = load double, double* %l29
  br i1 %t469, label %then64, label %merge65
then64:
  br label %afterloop63
merge65:
  %t476 = load %LexerState, %LexerState* %l0
  %t477 = extractvalue %LexerState %t476, 0
  %t478 = load %LexerState, %LexerState* %l0
  %t479 = extractvalue %LexerState %t478, 1
  %t480 = fptosi double %t479 to i64
  %t481 = getelementptr i8, i8* %t477, i64 %t480
  %t482 = load i8, i8* %t481
  %t483 = alloca [2 x i8], align 1
  %t484 = getelementptr [2 x i8], [2 x i8]* %t483, i32 0, i32 0
  store i8 %t482, i8* %t484
  %t485 = getelementptr [2 x i8], [2 x i8]* %t483, i32 0, i32 1
  store i8 0, i8* %t485
  %t486 = getelementptr [2 x i8], [2 x i8]* %t483, i32 0, i32 0
  %t487 = call i1 @is_digit(i8* %t486)
  %t488 = xor i1 %t487, 1
  %t489 = load %LexerState, %LexerState* %l0
  %t490 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t491 = load i8, i8* %l2
  %t492 = load double, double* %l27
  %t493 = load double, double* %l28
  %t494 = load double, double* %l29
  br i1 %t488, label %then66, label %merge67
then66:
  br label %afterloop63
merge67:
  br label %loop.latch62
loop.latch62:
  br label %loop.header60
afterloop63:
  %t496 = load %LexerState, %LexerState* %l0
  %t497 = extractvalue %LexerState %t496, 1
  %t498 = load %LexerState, %LexerState* %l0
  %t499 = extractvalue %LexerState %t498, 0
  %t500 = call i64 @sailfin_runtime_string_length(i8* %t499)
  %t501 = sitofp i64 %t500 to double
  %t502 = fcmp olt double %t497, %t501
  br label %logical_and_entry_495

logical_and_entry_495:
  br i1 %t502, label %logical_and_right_495, label %logical_and_merge_495

logical_and_right_495:
  %t503 = load %LexerState, %LexerState* %l0
  %t504 = extractvalue %LexerState %t503, 0
  %t505 = load %LexerState, %LexerState* %l0
  %t506 = extractvalue %LexerState %t505, 1
  %t507 = fptosi double %t506 to i64
  %t508 = getelementptr i8, i8* %t504, i64 %t507
  %t509 = load i8, i8* %t508
  %t510 = icmp eq i8 %t509, 46
  br label %logical_and_right_end_495

logical_and_right_end_495:
  br label %logical_and_merge_495

logical_and_merge_495:
  %t511 = phi i1 [ false, %logical_and_entry_495 ], [ %t510, %logical_and_right_end_495 ]
  %t512 = load %LexerState, %LexerState* %l0
  %t513 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t514 = load i8, i8* %l2
  %t515 = load double, double* %l27
  %t516 = load double, double* %l28
  %t517 = load double, double* %l29
  br i1 %t511, label %then68, label %merge69
then68:
  %t519 = load %LexerState, %LexerState* %l0
  %t520 = extractvalue %LexerState %t519, 1
  %t521 = sitofp i64 1 to double
  %t522 = fadd double %t520, %t521
  %t523 = load %LexerState, %LexerState* %l0
  %t524 = extractvalue %LexerState %t523, 0
  %t525 = call i64 @sailfin_runtime_string_length(i8* %t524)
  %t526 = sitofp i64 %t525 to double
  %t527 = fcmp olt double %t522, %t526
  br label %logical_and_entry_518

logical_and_entry_518:
  br i1 %t527, label %logical_and_right_518, label %logical_and_merge_518

logical_and_right_518:
  store double 0.0, double* %l30
  %t528 = load double, double* %l30
  %t529 = fcmp one double %t528, 0.0
  %t530 = load %LexerState, %LexerState* %l0
  %t531 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t532 = load i8, i8* %l2
  %t533 = load double, double* %l27
  %t534 = load double, double* %l28
  %t535 = load double, double* %l29
  %t536 = load double, double* %l30
  br i1 %t529, label %then70, label %merge71
then70:
  %t537 = load %LexerState, %LexerState* %l0
  %t538 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t539 = load i8, i8* %l2
  %t540 = load double, double* %l27
  %t541 = load double, double* %l28
  %t542 = load double, double* %l29
  %t543 = load double, double* %l30
  br label %loop.header72
loop.header72:
  br label %loop.body73
loop.body73:
  %t544 = load %LexerState, %LexerState* %l0
  %t545 = extractvalue %LexerState %t544, 1
  %t546 = load %LexerState, %LexerState* %l0
  %t547 = extractvalue %LexerState %t546, 0
  %t548 = call i64 @sailfin_runtime_string_length(i8* %t547)
  %t549 = sitofp i64 %t548 to double
  %t550 = fcmp oge double %t545, %t549
  %t551 = load %LexerState, %LexerState* %l0
  %t552 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t553 = load i8, i8* %l2
  %t554 = load double, double* %l27
  %t555 = load double, double* %l28
  %t556 = load double, double* %l29
  %t557 = load double, double* %l30
  br i1 %t550, label %then76, label %merge77
then76:
  br label %afterloop75
merge77:
  %t558 = load %LexerState, %LexerState* %l0
  %t559 = extractvalue %LexerState %t558, 0
  %t560 = load %LexerState, %LexerState* %l0
  %t561 = extractvalue %LexerState %t560, 1
  %t562 = fptosi double %t561 to i64
  %t563 = getelementptr i8, i8* %t559, i64 %t562
  %t564 = load i8, i8* %t563
  %t565 = alloca [2 x i8], align 1
  %t566 = getelementptr [2 x i8], [2 x i8]* %t565, i32 0, i32 0
  store i8 %t564, i8* %t566
  %t567 = getelementptr [2 x i8], [2 x i8]* %t565, i32 0, i32 1
  store i8 0, i8* %t567
  %t568 = getelementptr [2 x i8], [2 x i8]* %t565, i32 0, i32 0
  %t569 = call i1 @is_digit(i8* %t568)
  %t570 = xor i1 %t569, 1
  %t571 = load %LexerState, %LexerState* %l0
  %t572 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t573 = load i8, i8* %l2
  %t574 = load double, double* %l27
  %t575 = load double, double* %l28
  %t576 = load double, double* %l29
  %t577 = load double, double* %l30
  br i1 %t570, label %then78, label %merge79
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
  %t578 = load %LexerState, %LexerState* %l0
  %t579 = extractvalue %LexerState %t578, 0
  %t580 = load double, double* %l27
  %t581 = load %LexerState, %LexerState* %l0
  %t582 = extractvalue %LexerState %t581, 1
  %t583 = call i8* @slice(i8* %t579, double %t580, double %t582)
  store i8* %t583, i8** %l31
  %t584 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t585 = alloca %TokenKind
  %t586 = getelementptr inbounds %TokenKind, %TokenKind* %t585, i32 0, i32 0
  store i32 1, i32* %t586
  %t587 = load i8*, i8** %l31
  %t588 = getelementptr inbounds %TokenKind, %TokenKind* %t585, i32 0, i32 1
  %t589 = bitcast [8 x i8]* %t588 to i8*
  %t590 = bitcast i8* %t589 to i8**
  store i8* %t587, i8** %t590
  %t591 = load %TokenKind, %TokenKind* %t585
  %t592 = insertvalue %Token undef, %TokenKind* null, 0
  %t593 = load i8*, i8** %l31
  %t594 = insertvalue %Token %t592, i8* %t593, 1
  %t595 = load double, double* %l28
  %t596 = insertvalue %Token %t594, double %t595, 2
  %t597 = load double, double* %l29
  %t598 = insertvalue %Token %t596, double %t597, 3
  %t599 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t584, %Token %t598)
  store { %Token*, i64 }* %t599, { %Token*, i64 }** %l1
  br label %loop.latch2
merge59:
  %t600 = load i8, i8* %l2
  %t601 = alloca [2 x i8], align 1
  %t602 = getelementptr [2 x i8], [2 x i8]* %t601, i32 0, i32 0
  store i8 %t600, i8* %t602
  %t603 = getelementptr [2 x i8], [2 x i8]* %t601, i32 0, i32 1
  store i8 0, i8* %t603
  %t604 = getelementptr [2 x i8], [2 x i8]* %t601, i32 0, i32 0
  %t605 = call i1 @is_identifier_start(i8* %t604)
  %t606 = load %LexerState, %LexerState* %l0
  %t607 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t608 = load i8, i8* %l2
  br i1 %t605, label %then80, label %merge81
then80:
  %t609 = load %LexerState, %LexerState* %l0
  %t610 = extractvalue %LexerState %t609, 1
  store double %t610, double* %l32
  %t611 = load %LexerState, %LexerState* %l0
  %t612 = extractvalue %LexerState %t611, 2
  store double %t612, double* %l33
  %t613 = load %LexerState, %LexerState* %l0
  %t614 = extractvalue %LexerState %t613, 3
  store double %t614, double* %l34
  %t615 = load %LexerState, %LexerState* %l0
  %t616 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t617 = load i8, i8* %l2
  %t618 = load double, double* %l32
  %t619 = load double, double* %l33
  %t620 = load double, double* %l34
  br label %loop.header82
loop.header82:
  br label %loop.body83
loop.body83:
  %t621 = load %LexerState, %LexerState* %l0
  %t622 = extractvalue %LexerState %t621, 1
  %t623 = load %LexerState, %LexerState* %l0
  %t624 = extractvalue %LexerState %t623, 0
  %t625 = call i64 @sailfin_runtime_string_length(i8* %t624)
  %t626 = sitofp i64 %t625 to double
  %t627 = fcmp oge double %t622, %t626
  %t628 = load %LexerState, %LexerState* %l0
  %t629 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t630 = load i8, i8* %l2
  %t631 = load double, double* %l32
  %t632 = load double, double* %l33
  %t633 = load double, double* %l34
  br i1 %t627, label %then86, label %merge87
then86:
  br label %afterloop85
merge87:
  %t634 = load %LexerState, %LexerState* %l0
  %t635 = extractvalue %LexerState %t634, 0
  %t636 = load %LexerState, %LexerState* %l0
  %t637 = extractvalue %LexerState %t636, 1
  %t638 = fptosi double %t637 to i64
  %t639 = getelementptr i8, i8* %t635, i64 %t638
  %t640 = load i8, i8* %t639
  %t641 = alloca [2 x i8], align 1
  %t642 = getelementptr [2 x i8], [2 x i8]* %t641, i32 0, i32 0
  store i8 %t640, i8* %t642
  %t643 = getelementptr [2 x i8], [2 x i8]* %t641, i32 0, i32 1
  store i8 0, i8* %t643
  %t644 = getelementptr [2 x i8], [2 x i8]* %t641, i32 0, i32 0
  %t645 = call i1 @is_identifier_part(i8* %t644)
  %t646 = xor i1 %t645, 1
  %t647 = load %LexerState, %LexerState* %l0
  %t648 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t649 = load i8, i8* %l2
  %t650 = load double, double* %l32
  %t651 = load double, double* %l33
  %t652 = load double, double* %l34
  br i1 %t646, label %then88, label %merge89
then88:
  br label %afterloop85
merge89:
  br label %loop.latch84
loop.latch84:
  br label %loop.header82
afterloop85:
  %t653 = load %LexerState, %LexerState* %l0
  %t654 = extractvalue %LexerState %t653, 0
  %t655 = load double, double* %l32
  %t656 = load %LexerState, %LexerState* %l0
  %t657 = extractvalue %LexerState %t656, 1
  %t658 = call i8* @slice(i8* %t654, double %t655, double %t657)
  store i8* %t658, i8** %l35
  %t660 = load i8*, i8** %l35
  %s661 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.661, i32 0, i32 0
  %t662 = icmp eq i8* %t660, %s661
  br label %logical_or_entry_659

logical_or_entry_659:
  br i1 %t662, label %logical_or_merge_659, label %logical_or_right_659

logical_or_right_659:
  %t663 = load i8*, i8** %l35
  %s664 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.664, i32 0, i32 0
  %t665 = icmp eq i8* %t663, %s664
  br label %logical_or_right_end_659

logical_or_right_end_659:
  br label %logical_or_merge_659

logical_or_merge_659:
  %t666 = phi i1 [ true, %logical_or_entry_659 ], [ %t665, %logical_or_right_end_659 ]
  %t667 = load %LexerState, %LexerState* %l0
  %t668 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t669 = load i8, i8* %l2
  %t670 = load double, double* %l32
  %t671 = load double, double* %l33
  %t672 = load double, double* %l34
  %t673 = load i8*, i8** %l35
  br i1 %t666, label %then90, label %else91
then90:
  %t674 = load i8*, i8** %l35
  %s675 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.675, i32 0, i32 0
  %t676 = icmp eq i8* %t674, %s675
  store i1 %t676, i1* %l36
  %t677 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t678 = alloca %TokenKind
  %t679 = getelementptr inbounds %TokenKind, %TokenKind* %t678, i32 0, i32 0
  store i32 3, i32* %t679
  %t680 = load i1, i1* %l36
  %t681 = getelementptr inbounds %TokenKind, %TokenKind* %t678, i32 0, i32 1
  %t682 = bitcast [1 x i8]* %t681 to i8*
  %t683 = bitcast i8* %t682 to i1*
  store i1 %t680, i1* %t683
  %t684 = load %TokenKind, %TokenKind* %t678
  %t685 = insertvalue %Token undef, %TokenKind* null, 0
  %t686 = load i8*, i8** %l35
  %t687 = insertvalue %Token %t685, i8* %t686, 1
  %t688 = load double, double* %l33
  %t689 = insertvalue %Token %t687, double %t688, 2
  %t690 = load double, double* %l34
  %t691 = insertvalue %Token %t689, double %t690, 3
  %t692 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t677, %Token %t691)
  store { %Token*, i64 }* %t692, { %Token*, i64 }** %l1
  br label %merge92
else91:
  %t693 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t694 = alloca %TokenKind
  %t695 = getelementptr inbounds %TokenKind, %TokenKind* %t694, i32 0, i32 0
  store i32 0, i32* %t695
  %t696 = load i8*, i8** %l35
  %t697 = getelementptr inbounds %TokenKind, %TokenKind* %t694, i32 0, i32 1
  %t698 = bitcast [8 x i8]* %t697 to i8*
  %t699 = bitcast i8* %t698 to i8**
  store i8* %t696, i8** %t699
  %t700 = load %TokenKind, %TokenKind* %t694
  %t701 = insertvalue %Token undef, %TokenKind* null, 0
  %t702 = load i8*, i8** %l35
  %t703 = insertvalue %Token %t701, i8* %t702, 1
  %t704 = load double, double* %l33
  %t705 = insertvalue %Token %t703, double %t704, 2
  %t706 = load double, double* %l34
  %t707 = insertvalue %Token %t705, double %t706, 3
  %t708 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t693, %Token %t707)
  store { %Token*, i64 }* %t708, { %Token*, i64 }** %l1
  br label %merge92
merge92:
  %t709 = phi { %Token*, i64 }* [ %t692, %then90 ], [ %t708, %else91 ]
  store { %Token*, i64 }* %t709, { %Token*, i64 }** %l1
  br label %loop.latch2
merge81:
  %t710 = load %LexerState, %LexerState* %l0
  %t711 = extractvalue %LexerState %t710, 2
  store double %t711, double* %l37
  %t712 = load %LexerState, %LexerState* %l0
  %t713 = extractvalue %LexerState %t712, 3
  store double %t713, double* %l38
  %t714 = load i8, i8* %l2
  store i8 %t714, i8* %l39
  %t715 = load %LexerState, %LexerState* %l0
  %t716 = call i8* @peek_next_char(%LexerState %t715)
  store i8* %t716, i8** %l40
  %t717 = load i8*, i8** %l40
  %s718 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.718, i32 0, i32 0
  %t719 = icmp ne i8* %t717, %s718
  %t720 = load %LexerState, %LexerState* %l0
  %t721 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t722 = load i8, i8* %l2
  %t723 = load double, double* %l37
  %t724 = load double, double* %l38
  %t725 = load i8, i8* %l39
  %t726 = load i8*, i8** %l40
  br i1 %t719, label %then93, label %merge94
then93:
  %t727 = load i8, i8* %l2
  %t728 = load i8*, i8** %l40
  %t729 = getelementptr i8, i8* %t728, i64 0
  %t730 = load i8, i8* %t729
  %t731 = add i8 %t727, %t730
  store i8 %t731, i8* %l41
  %t732 = load i8, i8* %l41
  %t733 = alloca [2 x i8], align 1
  %t734 = getelementptr [2 x i8], [2 x i8]* %t733, i32 0, i32 0
  store i8 %t732, i8* %t734
  %t735 = getelementptr [2 x i8], [2 x i8]* %t733, i32 0, i32 1
  store i8 0, i8* %t735
  %t736 = getelementptr [2 x i8], [2 x i8]* %t733, i32 0, i32 0
  %t737 = call i1 @is_two_char_symbol(i8* %t736)
  %t738 = load %LexerState, %LexerState* %l0
  %t739 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t740 = load i8, i8* %l2
  %t741 = load double, double* %l37
  %t742 = load double, double* %l38
  %t743 = load i8, i8* %l39
  %t744 = load i8*, i8** %l40
  %t745 = load i8, i8* %l41
  br i1 %t737, label %then95, label %merge96
then95:
  %t746 = load i8, i8* %l41
  store i8 %t746, i8* %l39
  %t747 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t748 = alloca %TokenKind
  %t749 = getelementptr inbounds %TokenKind, %TokenKind* %t748, i32 0, i32 0
  store i32 4, i32* %t749
  %t750 = load i8, i8* %l39
  %t751 = call noalias i8* @malloc(i64 1)
  %t752 = bitcast i8* %t751 to i8*
  store i8 %t750, i8* %t752
  %t753 = getelementptr inbounds %TokenKind, %TokenKind* %t748, i32 0, i32 1
  %t754 = bitcast [8 x i8]* %t753 to i8*
  %t755 = bitcast i8* %t754 to i8**
  store i8* %t751, i8** %t755
  %t756 = load %TokenKind, %TokenKind* %t748
  %t757 = insertvalue %Token undef, %TokenKind* null, 0
  %t758 = load i8, i8* %l39
  %t759 = alloca [2 x i8], align 1
  %t760 = getelementptr [2 x i8], [2 x i8]* %t759, i32 0, i32 0
  store i8 %t758, i8* %t760
  %t761 = getelementptr [2 x i8], [2 x i8]* %t759, i32 0, i32 1
  store i8 0, i8* %t761
  %t762 = getelementptr [2 x i8], [2 x i8]* %t759, i32 0, i32 0
  %t763 = insertvalue %Token %t757, i8* %t762, 1
  %t764 = load double, double* %l37
  %t765 = insertvalue %Token %t763, double %t764, 2
  %t766 = load double, double* %l38
  %t767 = insertvalue %Token %t765, double %t766, 3
  %t768 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t747, %Token %t767)
  store { %Token*, i64 }* %t768, { %Token*, i64 }** %l1
  br label %loop.latch2
merge96:
  br label %merge94
merge94:
  %t769 = phi i8 [ %t746, %then93 ], [ %t725, %loop.body1 ]
  %t770 = phi { %Token*, i64 }* [ %t768, %then93 ], [ %t721, %loop.body1 ]
  store i8 %t769, i8* %l39
  store { %Token*, i64 }* %t770, { %Token*, i64 }** %l1
  %t771 = load i8, i8* %l2
  %t772 = icmp eq i8 %t771, 10
  %t773 = load %LexerState, %LexerState* %l0
  %t774 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t775 = load i8, i8* %l2
  %t776 = load double, double* %l37
  %t777 = load double, double* %l38
  %t778 = load i8, i8* %l39
  %t779 = load i8*, i8** %l40
  br i1 %t772, label %then97, label %else98
then97:
  br label %merge99
else98:
  br label %merge99
merge99:
  %t780 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t781 = alloca %TokenKind
  %t782 = getelementptr inbounds %TokenKind, %TokenKind* %t781, i32 0, i32 0
  store i32 4, i32* %t782
  %t783 = load i8, i8* %l39
  %t784 = call noalias i8* @malloc(i64 1)
  %t785 = bitcast i8* %t784 to i8*
  store i8 %t783, i8* %t785
  %t786 = getelementptr inbounds %TokenKind, %TokenKind* %t781, i32 0, i32 1
  %t787 = bitcast [8 x i8]* %t786 to i8*
  %t788 = bitcast i8* %t787 to i8**
  store i8* %t784, i8** %t788
  %t789 = load %TokenKind, %TokenKind* %t781
  %t790 = insertvalue %Token undef, %TokenKind* null, 0
  %t791 = load i8, i8* %l39
  %t792 = alloca [2 x i8], align 1
  %t793 = getelementptr [2 x i8], [2 x i8]* %t792, i32 0, i32 0
  store i8 %t791, i8* %t793
  %t794 = getelementptr [2 x i8], [2 x i8]* %t792, i32 0, i32 1
  store i8 0, i8* %t794
  %t795 = getelementptr [2 x i8], [2 x i8]* %t792, i32 0, i32 0
  %t796 = insertvalue %Token %t790, i8* %t795, 1
  %t797 = load double, double* %l37
  %t798 = insertvalue %Token %t796, double %t797, 2
  %t799 = load double, double* %l38
  %t800 = insertvalue %Token %t798, double %t799, 3
  %t801 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t780, %Token %t800)
  store { %Token*, i64 }* %t801, { %Token*, i64 }** %l1
  br label %loop.latch2
loop.latch2:
  %t802 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br label %loop.header0
afterloop3:
  %t804 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t805 = load %LexerState, %LexerState* %l0
  %t806 = extractvalue %LexerState %t805, 2
  %t807 = load %LexerState, %LexerState* %l0
  %t808 = extractvalue %LexerState %t807, 3
  %t809 = call double @eof_token(double %t806, double %t808)
  %t810 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t804, %Token zeroinitializer)
  store { %Token*, i64 }* %t810, { %Token*, i64 }** %l1
  %t811 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  ret { %Token*, i64 }* %t811
}

define i1 @is_whitespace(i8* %ch) {
entry:
  %t1 = getelementptr i8, i8* %ch, i64 0
  %t2 = load i8, i8* %t1
  %t3 = icmp eq i8 %t2, 32
  br label %logical_or_entry_0

logical_or_entry_0:
  br i1 %t3, label %logical_or_merge_0, label %logical_or_right_0

logical_or_right_0:
  %t5 = getelementptr i8, i8* %ch, i64 0
  %t6 = load i8, i8* %t5
  %t7 = icmp eq i8 %t6, 9
  br label %logical_or_entry_4

logical_or_entry_4:
  br i1 %t7, label %logical_or_merge_4, label %logical_or_right_4

logical_or_right_4:
  %t9 = getelementptr i8, i8* %ch, i64 0
  %t10 = load i8, i8* %t9
  %t11 = icmp eq i8 %t10, 10
  br label %logical_or_entry_8

logical_or_entry_8:
  br i1 %t11, label %logical_or_merge_8, label %logical_or_right_8

logical_or_right_8:
  %t12 = getelementptr i8, i8* %ch, i64 0
  %t13 = load i8, i8* %t12
  %t14 = icmp eq i8 %t13, 13
  br label %logical_or_right_end_8

logical_or_right_end_8:
  br label %logical_or_merge_8

logical_or_merge_8:
  %t15 = phi i1 [ true, %logical_or_entry_8 ], [ %t14, %logical_or_right_end_8 ]
  br label %logical_or_right_end_4

logical_or_right_end_4:
  br label %logical_or_merge_4

logical_or_merge_4:
  %t16 = phi i1 [ true, %logical_or_entry_4 ], [ %t15, %logical_or_right_end_4 ]
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
