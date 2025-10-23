; ModuleID = 'sailfin'
source_filename = "sailfin"

%LexerState = type { i8*, double, double, double }
%Token = type { %TokenKind, i8*, double, double }

%TokenKind = type { i32, [8 x i8] }

declare i8* @sailfin_runtime_substring(i8*, i64, i64)
declare i8* @sailfin_runtime_string_concat(i8*, i8*)
declare double @char_code(i8*)
declare { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }*, { i8**, i64 }*)
declare i8* @sailfin_runtime_get_field(i8*, i8*)

declare noalias i8* @malloc(i64)

@runtime = external global i8**

@.str.len2.h193428050 = private unnamed_addr constant [3 x i8] c"->\00"
@.str.len2.h193445474 = private unnamed_addr constant [3 x i8] c"=>\00"
@.str.len2.h193445441 = private unnamed_addr constant [3 x i8] c"==\00"
@.str.len2.h193414949 = private unnamed_addr constant [3 x i8] c"!=\00"
@.str.len2.h193444352 = private unnamed_addr constant [3 x i8] c"<=\00"
@.str.len2.h193446530 = private unnamed_addr constant [3 x i8] c">=\00"
@.str.len2.h193419635 = private unnamed_addr constant [3 x i8] c"&&\00"
@.str.len2.h193516127 = private unnamed_addr constant [3 x i8] c"||\00"
@.str.len2.h193428611 = private unnamed_addr constant [3 x i8] c"..\00"

declare i64 @sailfin_runtime_string_length(i8*)

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
  %l13 = alloca i8
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
  %t1087 = phi { %Token*, i64 }* [ %t13, %entry ], [ %t1086, %loop.latch2 ]
  store { %Token*, i64 }* %t1087, { %Token*, i64 }** %l1
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
  %t174 = call i64 @sailfin_runtime_string_length(i8* %t173)
  %t175 = sitofp i64 %t174 to double
  store double %t175, double* %l11
  %t176 = load %LexerState, %LexerState* %l0
  %t177 = extractvalue %LexerState %t176, 1
  store double %t177, double* %l12
  %t178 = load %LexerState, %LexerState* %l0
  %t179 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t180 = load i8, i8* %l2
  %t181 = load i8*, i8** %l7
  %t182 = load double, double* %l8
  %t183 = load double, double* %l9
  %t184 = load double, double* %l10
  %t185 = load double, double* %l11
  %t186 = load double, double* %l12
  br label %loop.header23
loop.header23:
  %t230 = phi double [ %t185, %then21 ], [ %t228, %loop.latch25 ]
  %t231 = phi double [ %t186, %then21 ], [ %t229, %loop.latch25 ]
  store double %t230, double* %l11
  store double %t231, double* %l12
  br label %loop.body24
loop.body24:
  %t187 = load double, double* %l12
  %t188 = load %LexerState, %LexerState* %l0
  %t189 = extractvalue %LexerState %t188, 0
  %t190 = call i64 @sailfin_runtime_string_length(i8* %t189)
  %t191 = sitofp i64 %t190 to double
  %t192 = fcmp oge double %t187, %t191
  %t193 = load %LexerState, %LexerState* %l0
  %t194 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t195 = load i8, i8* %l2
  %t196 = load i8*, i8** %l7
  %t197 = load double, double* %l8
  %t198 = load double, double* %l9
  %t199 = load double, double* %l10
  %t200 = load double, double* %l11
  %t201 = load double, double* %l12
  br i1 %t192, label %then27, label %merge28
then27:
  br label %afterloop26
merge28:
  %t202 = load %LexerState, %LexerState* %l0
  %t203 = extractvalue %LexerState %t202, 0
  %t204 = load double, double* %l12
  %t205 = fptosi double %t204 to i64
  %t206 = getelementptr i8, i8* %t203, i64 %t205
  %t207 = load i8, i8* %t206
  store i8 %t207, i8* %l13
  %t209 = load i8, i8* %l13
  %t210 = icmp eq i8 %t209, 10
  br label %logical_or_entry_208

logical_or_entry_208:
  br i1 %t210, label %logical_or_merge_208, label %logical_or_right_208

logical_or_right_208:
  %t211 = load i8, i8* %l13
  %t212 = icmp eq i8 %t211, 13
  br label %logical_or_right_end_208

logical_or_right_end_208:
  br label %logical_or_merge_208

logical_or_merge_208:
  %t213 = phi i1 [ true, %logical_or_entry_208 ], [ %t212, %logical_or_right_end_208 ]
  %t214 = load %LexerState, %LexerState* %l0
  %t215 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t216 = load i8, i8* %l2
  %t217 = load i8*, i8** %l7
  %t218 = load double, double* %l8
  %t219 = load double, double* %l9
  %t220 = load double, double* %l10
  %t221 = load double, double* %l11
  %t222 = load double, double* %l12
  %t223 = load i8, i8* %l13
  br i1 %t213, label %then29, label %merge30
then29:
  %t224 = load double, double* %l12
  store double %t224, double* %l11
  br label %afterloop26
merge30:
  %t225 = load double, double* %l12
  %t226 = sitofp i64 1 to double
  %t227 = fadd double %t225, %t226
  store double %t227, double* %l12
  br label %loop.latch25
loop.latch25:
  %t228 = load double, double* %l11
  %t229 = load double, double* %l12
  br label %loop.header23
afterloop26:
  %t232 = load %LexerState, %LexerState* %l0
  %t233 = extractvalue %LexerState %t232, 0
  %t234 = load double, double* %l8
  %t235 = load double, double* %l11
  %t236 = call i8* @slice(i8* %t233, double %t234, double %t235)
  store i8* %t236, i8** %l14
  %t237 = load double, double* %l11
  %t238 = load %LexerState, %LexerState* %l0
  %t239 = extractvalue %LexerState %t238, 1
  %t240 = fsub double %t237, %t239
  store double %t240, double* %l15
  %t241 = load double, double* %l11
  %t242 = load %LexerState, %LexerState* %l0
  %t243 = getelementptr %LexerState, %LexerState %t242, i32 0, i32 1
  store double %t241, double* %t243
  %t244 = load %LexerState, %LexerState* %l0
  %t245 = extractvalue %LexerState %t244, 3
  %t246 = load double, double* %l15
  %t247 = fadd double %t245, %t246
  %t248 = load %LexerState, %LexerState* %l0
  %t249 = getelementptr %LexerState, %LexerState %t248, i32 0, i32 3
  store double %t247, double* %t249
  %t250 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t251 = insertvalue %TokenKind undef, i32 6, 0
  %t252 = insertvalue %Token undef, %TokenKind %t251, 0
  %t253 = load i8*, i8** %l14
  %t254 = insertvalue %Token %t252, i8* %t253, 1
  %t255 = load double, double* %l9
  %t256 = insertvalue %Token %t254, double %t255, 2
  %t257 = load double, double* %l10
  %t258 = insertvalue %Token %t256, double %t257, 3
  %t259 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t250, %Token %t258)
  store { %Token*, i64 }* %t259, { %Token*, i64 }** %l1
  br label %loop.latch2
merge22:
  %t260 = load i8*, i8** %l7
  %t261 = load i8, i8* %t260
  %t262 = icmp eq i8 %t261, 42
  %t263 = load %LexerState, %LexerState* %l0
  %t264 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t265 = load i8, i8* %l2
  %t266 = load i8*, i8** %l7
  br i1 %t262, label %then31, label %merge32
then31:
  %t267 = load %LexerState, %LexerState* %l0
  %t268 = extractvalue %LexerState %t267, 1
  store double %t268, double* %l16
  %t269 = load %LexerState, %LexerState* %l0
  %t270 = extractvalue %LexerState %t269, 2
  store double %t270, double* %l17
  %t271 = load %LexerState, %LexerState* %l0
  %t272 = extractvalue %LexerState %t271, 3
  store double %t272, double* %l18
  %t273 = load %LexerState, %LexerState* %l0
  %t274 = extractvalue %LexerState %t273, 1
  %t275 = sitofp i64 2 to double
  %t276 = fadd double %t274, %t275
  %t277 = load %LexerState, %LexerState* %l0
  %t278 = getelementptr %LexerState, %LexerState %t277, i32 0, i32 1
  store double %t276, double* %t278
  %t279 = load %LexerState, %LexerState* %l0
  %t280 = extractvalue %LexerState %t279, 3
  %t281 = sitofp i64 2 to double
  %t282 = fadd double %t280, %t281
  %t283 = load %LexerState, %LexerState* %l0
  %t284 = getelementptr %LexerState, %LexerState %t283, i32 0, i32 3
  store double %t282, double* %t284
  %t285 = load %LexerState, %LexerState* %l0
  %t286 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t287 = load i8, i8* %l2
  %t288 = load i8*, i8** %l7
  %t289 = load double, double* %l16
  %t290 = load double, double* %l17
  %t291 = load double, double* %l18
  br label %loop.header33
loop.header33:
  br label %loop.body34
loop.body34:
  %t292 = load %LexerState, %LexerState* %l0
  %t293 = extractvalue %LexerState %t292, 1
  %t294 = load %LexerState, %LexerState* %l0
  %t295 = extractvalue %LexerState %t294, 0
  %t296 = call i64 @sailfin_runtime_string_length(i8* %t295)
  %t297 = sitofp i64 %t296 to double
  %t298 = fcmp oge double %t293, %t297
  %t299 = load %LexerState, %LexerState* %l0
  %t300 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t301 = load i8, i8* %l2
  %t302 = load i8*, i8** %l7
  %t303 = load double, double* %l16
  %t304 = load double, double* %l17
  %t305 = load double, double* %l18
  br i1 %t298, label %then37, label %merge38
then37:
  br label %afterloop36
merge38:
  %t307 = load %LexerState, %LexerState* %l0
  %t308 = extractvalue %LexerState %t307, 0
  %t309 = load %LexerState, %LexerState* %l0
  %t310 = extractvalue %LexerState %t309, 1
  %t311 = fptosi double %t310 to i64
  %t312 = getelementptr i8, i8* %t308, i64 %t311
  %t313 = load i8, i8* %t312
  %t314 = icmp eq i8 %t313, 42
  br label %logical_and_entry_306

logical_and_entry_306:
  br i1 %t314, label %logical_and_right_306, label %logical_and_merge_306

logical_and_right_306:
  %t315 = load %LexerState, %LexerState* %l0
  %t316 = call i8* @peek_next_char(%LexerState %t315)
  %t317 = load i8, i8* %t316
  %t318 = icmp eq i8 %t317, 47
  br label %logical_and_right_end_306

logical_and_right_end_306:
  br label %logical_and_merge_306

logical_and_merge_306:
  %t319 = phi i1 [ false, %logical_and_entry_306 ], [ %t318, %logical_and_right_end_306 ]
  %t320 = load %LexerState, %LexerState* %l0
  %t321 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t322 = load i8, i8* %l2
  %t323 = load i8*, i8** %l7
  %t324 = load double, double* %l16
  %t325 = load double, double* %l17
  %t326 = load double, double* %l18
  br i1 %t319, label %then39, label %merge40
then39:
  %t327 = load %LexerState, %LexerState* %l0
  %t328 = extractvalue %LexerState %t327, 1
  %t329 = sitofp i64 2 to double
  %t330 = fadd double %t328, %t329
  %t331 = load %LexerState, %LexerState* %l0
  %t332 = getelementptr %LexerState, %LexerState %t331, i32 0, i32 1
  store double %t330, double* %t332
  %t333 = load %LexerState, %LexerState* %l0
  %t334 = extractvalue %LexerState %t333, 3
  %t335 = sitofp i64 2 to double
  %t336 = fadd double %t334, %t335
  %t337 = load %LexerState, %LexerState* %l0
  %t338 = getelementptr %LexerState, %LexerState %t337, i32 0, i32 3
  store double %t336, double* %t338
  br label %afterloop36
merge40:
  %t339 = load %LexerState, %LexerState* %l0
  %t340 = extractvalue %LexerState %t339, 0
  %t341 = load %LexerState, %LexerState* %l0
  %t342 = extractvalue %LexerState %t341, 1
  %t343 = fptosi double %t342 to i64
  %t344 = getelementptr i8, i8* %t340, i64 %t343
  %t345 = load i8, i8* %t344
  %t346 = icmp eq i8 %t345, 10
  %t347 = load %LexerState, %LexerState* %l0
  %t348 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t349 = load i8, i8* %l2
  %t350 = load i8*, i8** %l7
  %t351 = load double, double* %l16
  %t352 = load double, double* %l17
  %t353 = load double, double* %l18
  br i1 %t346, label %then41, label %else42
then41:
  %t354 = load %LexerState, %LexerState* %l0
  %t355 = extractvalue %LexerState %t354, 1
  %t356 = sitofp i64 1 to double
  %t357 = fadd double %t355, %t356
  %t358 = load %LexerState, %LexerState* %l0
  %t359 = getelementptr %LexerState, %LexerState %t358, i32 0, i32 1
  store double %t357, double* %t359
  %t360 = load %LexerState, %LexerState* %l0
  %t361 = extractvalue %LexerState %t360, 2
  %t362 = sitofp i64 1 to double
  %t363 = fadd double %t361, %t362
  %t364 = load %LexerState, %LexerState* %l0
  %t365 = getelementptr %LexerState, %LexerState %t364, i32 0, i32 2
  store double %t363, double* %t365
  %t366 = load %LexerState, %LexerState* %l0
  %t367 = sitofp i64 1 to double
  %t368 = getelementptr %LexerState, %LexerState %t366, i32 0, i32 3
  store double %t367, double* %t368
  br label %merge43
else42:
  %t369 = load %LexerState, %LexerState* %l0
  %t370 = extractvalue %LexerState %t369, 1
  %t371 = sitofp i64 1 to double
  %t372 = fadd double %t370, %t371
  %t373 = load %LexerState, %LexerState* %l0
  %t374 = getelementptr %LexerState, %LexerState %t373, i32 0, i32 1
  store double %t372, double* %t374
  %t375 = load %LexerState, %LexerState* %l0
  %t376 = extractvalue %LexerState %t375, 3
  %t377 = sitofp i64 1 to double
  %t378 = fadd double %t376, %t377
  %t379 = load %LexerState, %LexerState* %l0
  %t380 = getelementptr %LexerState, %LexerState %t379, i32 0, i32 3
  store double %t378, double* %t380
  br label %merge43
merge43:
  br label %loop.latch35
loop.latch35:
  br label %loop.header33
afterloop36:
  %t381 = load %LexerState, %LexerState* %l0
  %t382 = extractvalue %LexerState %t381, 0
  %t383 = load double, double* %l16
  %t384 = load %LexerState, %LexerState* %l0
  %t385 = extractvalue %LexerState %t384, 1
  %t386 = call i8* @slice(i8* %t382, double %t383, double %t385)
  store i8* %t386, i8** %l19
  %t387 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t388 = insertvalue %TokenKind undef, i32 6, 0
  %t389 = insertvalue %Token undef, %TokenKind %t388, 0
  %t390 = load i8*, i8** %l19
  %t391 = insertvalue %Token %t389, i8* %t390, 1
  %t392 = load double, double* %l17
  %t393 = insertvalue %Token %t391, double %t392, 2
  %t394 = load double, double* %l18
  %t395 = insertvalue %Token %t393, double %t394, 3
  %t396 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t387, %Token %t395)
  store { %Token*, i64 }* %t396, { %Token*, i64 }** %l1
  br label %loop.latch2
merge32:
  br label %merge20
merge20:
  %t397 = phi { %Token*, i64 }* [ %t259, %then19 ], [ %t143, %loop.body1 ]
  %t398 = phi { %Token*, i64 }* [ %t396, %then19 ], [ %t143, %loop.body1 ]
  store { %Token*, i64 }* %t397, { %Token*, i64 }** %l1
  store { %Token*, i64 }* %t398, { %Token*, i64 }** %l1
  %t399 = load i8, i8* %l2
  %t400 = alloca [2 x i8], align 1
  %t401 = getelementptr [2 x i8], [2 x i8]* %t400, i32 0, i32 0
  store i8 %t399, i8* %t401
  %t402 = getelementptr [2 x i8], [2 x i8]* %t400, i32 0, i32 1
  store i8 0, i8* %t402
  %t403 = getelementptr [2 x i8], [2 x i8]* %t400, i32 0, i32 0
  %t404 = call i1 @is_double_quote(i8* %t403)
  %t405 = load %LexerState, %LexerState* %l0
  %t406 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t407 = load i8, i8* %l2
  br i1 %t404, label %then44, label %merge45
then44:
  %t408 = load %LexerState, %LexerState* %l0
  %t409 = extractvalue %LexerState %t408, 1
  store double %t409, double* %l20
  %t410 = load %LexerState, %LexerState* %l0
  %t411 = extractvalue %LexerState %t410, 2
  store double %t411, double* %l21
  %t412 = load %LexerState, %LexerState* %l0
  %t413 = extractvalue %LexerState %t412, 3
  store double %t413, double* %l22
  %t414 = load %LexerState, %LexerState* %l0
  %t415 = extractvalue %LexerState %t414, 1
  %t416 = sitofp i64 1 to double
  %t417 = fadd double %t415, %t416
  %t418 = load %LexerState, %LexerState* %l0
  %t419 = getelementptr %LexerState, %LexerState %t418, i32 0, i32 1
  store double %t417, double* %t419
  %t420 = load %LexerState, %LexerState* %l0
  %t421 = extractvalue %LexerState %t420, 3
  %t422 = sitofp i64 1 to double
  %t423 = fadd double %t421, %t422
  %t424 = load %LexerState, %LexerState* %l0
  %t425 = getelementptr %LexerState, %LexerState %t424, i32 0, i32 3
  store double %t423, double* %t425
  %s426 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s426, i8** %l23
  store i1 0, i1* %l24
  %t427 = load %LexerState, %LexerState* %l0
  %t428 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t429 = load i8, i8* %l2
  %t430 = load double, double* %l20
  %t431 = load double, double* %l21
  %t432 = load double, double* %l22
  %t433 = load i8*, i8** %l23
  %t434 = load i1, i1* %l24
  br label %loop.header46
loop.header46:
  %t587 = phi i1 [ %t434, %then44 ], [ %t585, %loop.latch48 ]
  %t588 = phi i8* [ %t433, %then44 ], [ %t586, %loop.latch48 ]
  store i1 %t587, i1* %l24
  store i8* %t588, i8** %l23
  br label %loop.body47
loop.body47:
  %t435 = load %LexerState, %LexerState* %l0
  %t436 = extractvalue %LexerState %t435, 1
  %t437 = load %LexerState, %LexerState* %l0
  %t438 = extractvalue %LexerState %t437, 0
  %t439 = call i64 @sailfin_runtime_string_length(i8* %t438)
  %t440 = sitofp i64 %t439 to double
  %t441 = fcmp oge double %t436, %t440
  %t442 = load %LexerState, %LexerState* %l0
  %t443 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t444 = load i8, i8* %l2
  %t445 = load double, double* %l20
  %t446 = load double, double* %l21
  %t447 = load double, double* %l22
  %t448 = load i8*, i8** %l23
  %t449 = load i1, i1* %l24
  br i1 %t441, label %then50, label %merge51
then50:
  br label %afterloop49
merge51:
  %t450 = load %LexerState, %LexerState* %l0
  %t451 = extractvalue %LexerState %t450, 0
  %t452 = load %LexerState, %LexerState* %l0
  %t453 = extractvalue %LexerState %t452, 1
  %t454 = fptosi double %t453 to i64
  %t455 = getelementptr i8, i8* %t451, i64 %t454
  %t456 = load i8, i8* %t455
  store i8 %t456, i8* %l25
  %t458 = load i1, i1* %l24
  br label %logical_and_entry_457

logical_and_entry_457:
  br i1 %t458, label %logical_and_right_457, label %logical_and_merge_457

logical_and_right_457:
  %t459 = load i8, i8* %l25
  %t460 = alloca [2 x i8], align 1
  %t461 = getelementptr [2 x i8], [2 x i8]* %t460, i32 0, i32 0
  store i8 %t459, i8* %t461
  %t462 = getelementptr [2 x i8], [2 x i8]* %t460, i32 0, i32 1
  store i8 0, i8* %t462
  %t463 = getelementptr [2 x i8], [2 x i8]* %t460, i32 0, i32 0
  %t464 = call i1 @is_double_quote(i8* %t463)
  br label %logical_and_right_end_457

logical_and_right_end_457:
  br label %logical_and_merge_457

logical_and_merge_457:
  %t465 = phi i1 [ false, %logical_and_entry_457 ], [ %t464, %logical_and_right_end_457 ]
  %t466 = xor i1 %t465, 1
  %t467 = load %LexerState, %LexerState* %l0
  %t468 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t469 = load i8, i8* %l2
  %t470 = load double, double* %l20
  %t471 = load double, double* %l21
  %t472 = load double, double* %l22
  %t473 = load i8*, i8** %l23
  %t474 = load i1, i1* %l24
  %t475 = load i8, i8* %l25
  br i1 %t466, label %then52, label %merge53
then52:
  %t476 = load %LexerState, %LexerState* %l0
  %t477 = extractvalue %LexerState %t476, 1
  %t478 = sitofp i64 1 to double
  %t479 = fadd double %t477, %t478
  %t480 = load %LexerState, %LexerState* %l0
  %t481 = getelementptr %LexerState, %LexerState %t480, i32 0, i32 1
  store double %t479, double* %t481
  %t482 = load %LexerState, %LexerState* %l0
  %t483 = extractvalue %LexerState %t482, 3
  %t484 = sitofp i64 1 to double
  %t485 = fadd double %t483, %t484
  %t486 = load %LexerState, %LexerState* %l0
  %t487 = getelementptr %LexerState, %LexerState %t486, i32 0, i32 3
  store double %t485, double* %t487
  br label %afterloop49
merge53:
  %t489 = load i1, i1* %l24
  br label %logical_and_entry_488

logical_and_entry_488:
  br i1 %t489, label %logical_and_right_488, label %logical_and_merge_488

logical_and_right_488:
  %t490 = load i8, i8* %l25
  %t491 = alloca [2 x i8], align 1
  %t492 = getelementptr [2 x i8], [2 x i8]* %t491, i32 0, i32 0
  store i8 %t490, i8* %t492
  %t493 = getelementptr [2 x i8], [2 x i8]* %t491, i32 0, i32 1
  store i8 0, i8* %t493
  %t494 = getelementptr [2 x i8], [2 x i8]* %t491, i32 0, i32 0
  %t495 = call i1 @is_backslash(i8* %t494)
  br label %logical_and_right_end_488

logical_and_right_end_488:
  br label %logical_and_merge_488

logical_and_merge_488:
  %t496 = phi i1 [ false, %logical_and_entry_488 ], [ %t495, %logical_and_right_end_488 ]
  %t497 = xor i1 %t496, 1
  %t498 = load %LexerState, %LexerState* %l0
  %t499 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t500 = load i8, i8* %l2
  %t501 = load double, double* %l20
  %t502 = load double, double* %l21
  %t503 = load double, double* %l22
  %t504 = load i8*, i8** %l23
  %t505 = load i1, i1* %l24
  %t506 = load i8, i8* %l25
  br i1 %t497, label %then54, label %merge55
then54:
  store i1 1, i1* %l24
  %t507 = load %LexerState, %LexerState* %l0
  %t508 = extractvalue %LexerState %t507, 1
  %t509 = sitofp i64 1 to double
  %t510 = fadd double %t508, %t509
  %t511 = load %LexerState, %LexerState* %l0
  %t512 = getelementptr %LexerState, %LexerState %t511, i32 0, i32 1
  store double %t510, double* %t512
  %t513 = load %LexerState, %LexerState* %l0
  %t514 = extractvalue %LexerState %t513, 3
  %t515 = sitofp i64 1 to double
  %t516 = fadd double %t514, %t515
  %t517 = load %LexerState, %LexerState* %l0
  %t518 = getelementptr %LexerState, %LexerState %t517, i32 0, i32 3
  store double %t516, double* %t518
  br label %loop.latch48
merge55:
  %t519 = load i1, i1* %l24
  %t520 = load %LexerState, %LexerState* %l0
  %t521 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t522 = load i8, i8* %l2
  %t523 = load double, double* %l20
  %t524 = load double, double* %l21
  %t525 = load double, double* %l22
  %t526 = load i8*, i8** %l23
  %t527 = load i1, i1* %l24
  %t528 = load i8, i8* %l25
  br i1 %t519, label %then56, label %else57
then56:
  %t529 = load i8*, i8** %l23
  %t530 = load i8, i8* %l25
  %t531 = alloca [2 x i8], align 1
  %t532 = getelementptr [2 x i8], [2 x i8]* %t531, i32 0, i32 0
  store i8 %t530, i8* %t532
  %t533 = getelementptr [2 x i8], [2 x i8]* %t531, i32 0, i32 1
  store i8 0, i8* %t533
  %t534 = getelementptr [2 x i8], [2 x i8]* %t531, i32 0, i32 0
  %t535 = call i8* @interpret_escape(i8* %t534)
  %t536 = call i8* @sailfin_runtime_string_concat(i8* %t529, i8* %t535)
  store i8* %t536, i8** %l23
  store i1 0, i1* %l24
  br label %merge58
else57:
  %t537 = load i8*, i8** %l23
  %t538 = load i8, i8* %l25
  %t539 = load i8, i8* %t537
  %t540 = add i8 %t539, %t538
  %t541 = alloca [2 x i8], align 1
  %t542 = getelementptr [2 x i8], [2 x i8]* %t541, i32 0, i32 0
  store i8 %t540, i8* %t542
  %t543 = getelementptr [2 x i8], [2 x i8]* %t541, i32 0, i32 1
  store i8 0, i8* %t543
  %t544 = getelementptr [2 x i8], [2 x i8]* %t541, i32 0, i32 0
  store i8* %t544, i8** %l23
  br label %merge58
merge58:
  %t545 = phi i8* [ %t536, %then56 ], [ %t544, %else57 ]
  %t546 = phi i1 [ 0, %then56 ], [ %t527, %else57 ]
  store i8* %t545, i8** %l23
  store i1 %t546, i1* %l24
  %t547 = load i8, i8* %l25
  %t548 = icmp eq i8 %t547, 10
  %t549 = load %LexerState, %LexerState* %l0
  %t550 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t551 = load i8, i8* %l2
  %t552 = load double, double* %l20
  %t553 = load double, double* %l21
  %t554 = load double, double* %l22
  %t555 = load i8*, i8** %l23
  %t556 = load i1, i1* %l24
  %t557 = load i8, i8* %l25
  br i1 %t548, label %then59, label %else60
then59:
  %t558 = load %LexerState, %LexerState* %l0
  %t559 = extractvalue %LexerState %t558, 1
  %t560 = sitofp i64 1 to double
  %t561 = fadd double %t559, %t560
  %t562 = load %LexerState, %LexerState* %l0
  %t563 = getelementptr %LexerState, %LexerState %t562, i32 0, i32 1
  store double %t561, double* %t563
  %t564 = load %LexerState, %LexerState* %l0
  %t565 = extractvalue %LexerState %t564, 2
  %t566 = sitofp i64 1 to double
  %t567 = fadd double %t565, %t566
  %t568 = load %LexerState, %LexerState* %l0
  %t569 = getelementptr %LexerState, %LexerState %t568, i32 0, i32 2
  store double %t567, double* %t569
  %t570 = load %LexerState, %LexerState* %l0
  %t571 = sitofp i64 1 to double
  %t572 = getelementptr %LexerState, %LexerState %t570, i32 0, i32 3
  store double %t571, double* %t572
  br label %merge61
else60:
  %t573 = load %LexerState, %LexerState* %l0
  %t574 = extractvalue %LexerState %t573, 1
  %t575 = sitofp i64 1 to double
  %t576 = fadd double %t574, %t575
  %t577 = load %LexerState, %LexerState* %l0
  %t578 = getelementptr %LexerState, %LexerState %t577, i32 0, i32 1
  store double %t576, double* %t578
  %t579 = load %LexerState, %LexerState* %l0
  %t580 = extractvalue %LexerState %t579, 3
  %t581 = sitofp i64 1 to double
  %t582 = fadd double %t580, %t581
  %t583 = load %LexerState, %LexerState* %l0
  %t584 = getelementptr %LexerState, %LexerState %t583, i32 0, i32 3
  store double %t582, double* %t584
  br label %merge61
merge61:
  br label %loop.latch48
loop.latch48:
  %t585 = load i1, i1* %l24
  %t586 = load i8*, i8** %l23
  br label %loop.header46
afterloop49:
  %t589 = load %LexerState, %LexerState* %l0
  %t590 = extractvalue %LexerState %t589, 0
  %t591 = load double, double* %l20
  %t592 = load %LexerState, %LexerState* %l0
  %t593 = extractvalue %LexerState %t592, 1
  %t594 = call i8* @slice(i8* %t590, double %t591, double %t593)
  store i8* %t594, i8** %l26
  %t595 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t596 = alloca %TokenKind
  %t597 = getelementptr inbounds %TokenKind, %TokenKind* %t596, i32 0, i32 0
  store i32 2, i32* %t597
  %t598 = load i8*, i8** %l23
  %t599 = getelementptr inbounds %TokenKind, %TokenKind* %t596, i32 0, i32 1
  %t600 = bitcast [8 x i8]* %t599 to i8*
  %t601 = bitcast i8* %t600 to i8**
  store i8* %t598, i8** %t601
  %t602 = load %TokenKind, %TokenKind* %t596
  %t603 = insertvalue %Token undef, %TokenKind %t602, 0
  %t604 = load i8*, i8** %l26
  %t605 = insertvalue %Token %t603, i8* %t604, 1
  %t606 = load double, double* %l21
  %t607 = insertvalue %Token %t605, double %t606, 2
  %t608 = load double, double* %l22
  %t609 = insertvalue %Token %t607, double %t608, 3
  %t610 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t595, %Token %t609)
  store { %Token*, i64 }* %t610, { %Token*, i64 }** %l1
  br label %loop.latch2
merge45:
  %t611 = load i8, i8* %l2
  %t612 = alloca [2 x i8], align 1
  %t613 = getelementptr [2 x i8], [2 x i8]* %t612, i32 0, i32 0
  store i8 %t611, i8* %t613
  %t614 = getelementptr [2 x i8], [2 x i8]* %t612, i32 0, i32 1
  store i8 0, i8* %t614
  %t615 = getelementptr [2 x i8], [2 x i8]* %t612, i32 0, i32 0
  %t616 = call i1 @is_digit(i8* %t615)
  %t617 = load %LexerState, %LexerState* %l0
  %t618 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t619 = load i8, i8* %l2
  br i1 %t616, label %then62, label %merge63
then62:
  %t620 = load %LexerState, %LexerState* %l0
  %t621 = extractvalue %LexerState %t620, 1
  store double %t621, double* %l27
  %t622 = load %LexerState, %LexerState* %l0
  %t623 = extractvalue %LexerState %t622, 2
  store double %t623, double* %l28
  %t624 = load %LexerState, %LexerState* %l0
  %t625 = extractvalue %LexerState %t624, 3
  store double %t625, double* %l29
  %t626 = load %LexerState, %LexerState* %l0
  %t627 = extractvalue %LexerState %t626, 1
  %t628 = sitofp i64 1 to double
  %t629 = fadd double %t627, %t628
  %t630 = load %LexerState, %LexerState* %l0
  %t631 = getelementptr %LexerState, %LexerState %t630, i32 0, i32 1
  store double %t629, double* %t631
  %t632 = load %LexerState, %LexerState* %l0
  %t633 = extractvalue %LexerState %t632, 3
  %t634 = sitofp i64 1 to double
  %t635 = fadd double %t633, %t634
  %t636 = load %LexerState, %LexerState* %l0
  %t637 = getelementptr %LexerState, %LexerState %t636, i32 0, i32 3
  store double %t635, double* %t637
  %t638 = load %LexerState, %LexerState* %l0
  %t639 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t640 = load i8, i8* %l2
  %t641 = load double, double* %l27
  %t642 = load double, double* %l28
  %t643 = load double, double* %l29
  br label %loop.header64
loop.header64:
  br label %loop.body65
loop.body65:
  %t644 = load %LexerState, %LexerState* %l0
  %t645 = extractvalue %LexerState %t644, 1
  %t646 = load %LexerState, %LexerState* %l0
  %t647 = extractvalue %LexerState %t646, 0
  %t648 = call i64 @sailfin_runtime_string_length(i8* %t647)
  %t649 = sitofp i64 %t648 to double
  %t650 = fcmp oge double %t645, %t649
  %t651 = load %LexerState, %LexerState* %l0
  %t652 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t653 = load i8, i8* %l2
  %t654 = load double, double* %l27
  %t655 = load double, double* %l28
  %t656 = load double, double* %l29
  br i1 %t650, label %then68, label %merge69
then68:
  br label %afterloop67
merge69:
  %t657 = load %LexerState, %LexerState* %l0
  %t658 = extractvalue %LexerState %t657, 0
  %t659 = load %LexerState, %LexerState* %l0
  %t660 = extractvalue %LexerState %t659, 1
  %t661 = fptosi double %t660 to i64
  %t662 = getelementptr i8, i8* %t658, i64 %t661
  %t663 = load i8, i8* %t662
  %t664 = alloca [2 x i8], align 1
  %t665 = getelementptr [2 x i8], [2 x i8]* %t664, i32 0, i32 0
  store i8 %t663, i8* %t665
  %t666 = getelementptr [2 x i8], [2 x i8]* %t664, i32 0, i32 1
  store i8 0, i8* %t666
  %t667 = getelementptr [2 x i8], [2 x i8]* %t664, i32 0, i32 0
  %t668 = call i1 @is_digit(i8* %t667)
  %t669 = xor i1 %t668, 1
  %t670 = load %LexerState, %LexerState* %l0
  %t671 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t672 = load i8, i8* %l2
  %t673 = load double, double* %l27
  %t674 = load double, double* %l28
  %t675 = load double, double* %l29
  br i1 %t669, label %then70, label %merge71
then70:
  br label %afterloop67
merge71:
  %t676 = load %LexerState, %LexerState* %l0
  %t677 = extractvalue %LexerState %t676, 1
  %t678 = sitofp i64 1 to double
  %t679 = fadd double %t677, %t678
  %t680 = load %LexerState, %LexerState* %l0
  %t681 = getelementptr %LexerState, %LexerState %t680, i32 0, i32 1
  store double %t679, double* %t681
  %t682 = load %LexerState, %LexerState* %l0
  %t683 = extractvalue %LexerState %t682, 3
  %t684 = sitofp i64 1 to double
  %t685 = fadd double %t683, %t684
  %t686 = load %LexerState, %LexerState* %l0
  %t687 = getelementptr %LexerState, %LexerState %t686, i32 0, i32 3
  store double %t685, double* %t687
  br label %loop.latch66
loop.latch66:
  br label %loop.header64
afterloop67:
  %t689 = load %LexerState, %LexerState* %l0
  %t690 = extractvalue %LexerState %t689, 1
  %t691 = load %LexerState, %LexerState* %l0
  %t692 = extractvalue %LexerState %t691, 0
  %t693 = call i64 @sailfin_runtime_string_length(i8* %t692)
  %t694 = sitofp i64 %t693 to double
  %t695 = fcmp olt double %t690, %t694
  br label %logical_and_entry_688

logical_and_entry_688:
  br i1 %t695, label %logical_and_right_688, label %logical_and_merge_688

logical_and_right_688:
  %t696 = load %LexerState, %LexerState* %l0
  %t697 = extractvalue %LexerState %t696, 0
  %t698 = load %LexerState, %LexerState* %l0
  %t699 = extractvalue %LexerState %t698, 1
  %t700 = fptosi double %t699 to i64
  %t701 = getelementptr i8, i8* %t697, i64 %t700
  %t702 = load i8, i8* %t701
  %t703 = icmp eq i8 %t702, 46
  br label %logical_and_right_end_688

logical_and_right_end_688:
  br label %logical_and_merge_688

logical_and_merge_688:
  %t704 = phi i1 [ false, %logical_and_entry_688 ], [ %t703, %logical_and_right_end_688 ]
  %t705 = load %LexerState, %LexerState* %l0
  %t706 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t707 = load i8, i8* %l2
  %t708 = load double, double* %l27
  %t709 = load double, double* %l28
  %t710 = load double, double* %l29
  br i1 %t704, label %then72, label %merge73
then72:
  %t712 = load %LexerState, %LexerState* %l0
  %t713 = extractvalue %LexerState %t712, 1
  %t714 = sitofp i64 1 to double
  %t715 = fadd double %t713, %t714
  %t716 = load %LexerState, %LexerState* %l0
  %t717 = extractvalue %LexerState %t716, 0
  %t718 = call i64 @sailfin_runtime_string_length(i8* %t717)
  %t719 = sitofp i64 %t718 to double
  %t720 = fcmp olt double %t715, %t719
  br label %logical_and_entry_711

logical_and_entry_711:
  br i1 %t720, label %logical_and_right_711, label %logical_and_merge_711

logical_and_right_711:
  %t721 = load %LexerState, %LexerState* %l0
  %t722 = extractvalue %LexerState %t721, 0
  %t723 = load %LexerState, %LexerState* %l0
  %t724 = extractvalue %LexerState %t723, 1
  %t725 = sitofp i64 1 to double
  %t726 = fadd double %t724, %t725
  %t727 = fptosi double %t726 to i64
  %t728 = getelementptr i8, i8* %t722, i64 %t727
  %t729 = load i8, i8* %t728
  %t730 = alloca [2 x i8], align 1
  %t731 = getelementptr [2 x i8], [2 x i8]* %t730, i32 0, i32 0
  store i8 %t729, i8* %t731
  %t732 = getelementptr [2 x i8], [2 x i8]* %t730, i32 0, i32 1
  store i8 0, i8* %t732
  %t733 = getelementptr [2 x i8], [2 x i8]* %t730, i32 0, i32 0
  %t734 = call i1 @is_digit(i8* %t733)
  br label %logical_and_right_end_711

logical_and_right_end_711:
  br label %logical_and_merge_711

logical_and_merge_711:
  %t735 = phi i1 [ false, %logical_and_entry_711 ], [ %t734, %logical_and_right_end_711 ]
  store i1 %t735, i1* %l30
  %t736 = load i1, i1* %l30
  %t737 = load %LexerState, %LexerState* %l0
  %t738 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t739 = load i8, i8* %l2
  %t740 = load double, double* %l27
  %t741 = load double, double* %l28
  %t742 = load double, double* %l29
  %t743 = load i1, i1* %l30
  br i1 %t736, label %then74, label %merge75
then74:
  %t744 = load %LexerState, %LexerState* %l0
  %t745 = extractvalue %LexerState %t744, 1
  %t746 = sitofp i64 1 to double
  %t747 = fadd double %t745, %t746
  %t748 = load %LexerState, %LexerState* %l0
  %t749 = getelementptr %LexerState, %LexerState %t748, i32 0, i32 1
  store double %t747, double* %t749
  %t750 = load %LexerState, %LexerState* %l0
  %t751 = extractvalue %LexerState %t750, 3
  %t752 = sitofp i64 1 to double
  %t753 = fadd double %t751, %t752
  %t754 = load %LexerState, %LexerState* %l0
  %t755 = getelementptr %LexerState, %LexerState %t754, i32 0, i32 3
  store double %t753, double* %t755
  %t756 = load %LexerState, %LexerState* %l0
  %t757 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t758 = load i8, i8* %l2
  %t759 = load double, double* %l27
  %t760 = load double, double* %l28
  %t761 = load double, double* %l29
  %t762 = load i1, i1* %l30
  br label %loop.header76
loop.header76:
  br label %loop.body77
loop.body77:
  %t763 = load %LexerState, %LexerState* %l0
  %t764 = extractvalue %LexerState %t763, 1
  %t765 = load %LexerState, %LexerState* %l0
  %t766 = extractvalue %LexerState %t765, 0
  %t767 = call i64 @sailfin_runtime_string_length(i8* %t766)
  %t768 = sitofp i64 %t767 to double
  %t769 = fcmp oge double %t764, %t768
  %t770 = load %LexerState, %LexerState* %l0
  %t771 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t772 = load i8, i8* %l2
  %t773 = load double, double* %l27
  %t774 = load double, double* %l28
  %t775 = load double, double* %l29
  %t776 = load i1, i1* %l30
  br i1 %t769, label %then80, label %merge81
then80:
  br label %afterloop79
merge81:
  %t777 = load %LexerState, %LexerState* %l0
  %t778 = extractvalue %LexerState %t777, 0
  %t779 = load %LexerState, %LexerState* %l0
  %t780 = extractvalue %LexerState %t779, 1
  %t781 = fptosi double %t780 to i64
  %t782 = getelementptr i8, i8* %t778, i64 %t781
  %t783 = load i8, i8* %t782
  %t784 = alloca [2 x i8], align 1
  %t785 = getelementptr [2 x i8], [2 x i8]* %t784, i32 0, i32 0
  store i8 %t783, i8* %t785
  %t786 = getelementptr [2 x i8], [2 x i8]* %t784, i32 0, i32 1
  store i8 0, i8* %t786
  %t787 = getelementptr [2 x i8], [2 x i8]* %t784, i32 0, i32 0
  %t788 = call i1 @is_digit(i8* %t787)
  %t789 = xor i1 %t788, 1
  %t790 = load %LexerState, %LexerState* %l0
  %t791 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t792 = load i8, i8* %l2
  %t793 = load double, double* %l27
  %t794 = load double, double* %l28
  %t795 = load double, double* %l29
  %t796 = load i1, i1* %l30
  br i1 %t789, label %then82, label %merge83
then82:
  br label %afterloop79
merge83:
  %t797 = load %LexerState, %LexerState* %l0
  %t798 = extractvalue %LexerState %t797, 1
  %t799 = sitofp i64 1 to double
  %t800 = fadd double %t798, %t799
  %t801 = load %LexerState, %LexerState* %l0
  %t802 = getelementptr %LexerState, %LexerState %t801, i32 0, i32 1
  store double %t800, double* %t802
  %t803 = load %LexerState, %LexerState* %l0
  %t804 = extractvalue %LexerState %t803, 3
  %t805 = sitofp i64 1 to double
  %t806 = fadd double %t804, %t805
  %t807 = load %LexerState, %LexerState* %l0
  %t808 = getelementptr %LexerState, %LexerState %t807, i32 0, i32 3
  store double %t806, double* %t808
  br label %loop.latch78
loop.latch78:
  br label %loop.header76
afterloop79:
  br label %merge75
merge75:
  br label %merge73
merge73:
  %t809 = load %LexerState, %LexerState* %l0
  %t810 = extractvalue %LexerState %t809, 0
  %t811 = load double, double* %l27
  %t812 = load %LexerState, %LexerState* %l0
  %t813 = extractvalue %LexerState %t812, 1
  %t814 = call i8* @slice(i8* %t810, double %t811, double %t813)
  store i8* %t814, i8** %l31
  %t815 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t816 = alloca %TokenKind
  %t817 = getelementptr inbounds %TokenKind, %TokenKind* %t816, i32 0, i32 0
  store i32 1, i32* %t817
  %t818 = load i8*, i8** %l31
  %t819 = getelementptr inbounds %TokenKind, %TokenKind* %t816, i32 0, i32 1
  %t820 = bitcast [8 x i8]* %t819 to i8*
  %t821 = bitcast i8* %t820 to i8**
  store i8* %t818, i8** %t821
  %t822 = load %TokenKind, %TokenKind* %t816
  %t823 = insertvalue %Token undef, %TokenKind %t822, 0
  %t824 = load i8*, i8** %l31
  %t825 = insertvalue %Token %t823, i8* %t824, 1
  %t826 = load double, double* %l28
  %t827 = insertvalue %Token %t825, double %t826, 2
  %t828 = load double, double* %l29
  %t829 = insertvalue %Token %t827, double %t828, 3
  %t830 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t815, %Token %t829)
  store { %Token*, i64 }* %t830, { %Token*, i64 }** %l1
  br label %loop.latch2
merge63:
  %t831 = load i8, i8* %l2
  %t832 = alloca [2 x i8], align 1
  %t833 = getelementptr [2 x i8], [2 x i8]* %t832, i32 0, i32 0
  store i8 %t831, i8* %t833
  %t834 = getelementptr [2 x i8], [2 x i8]* %t832, i32 0, i32 1
  store i8 0, i8* %t834
  %t835 = getelementptr [2 x i8], [2 x i8]* %t832, i32 0, i32 0
  %t836 = call i1 @is_identifier_start(i8* %t835)
  %t837 = load %LexerState, %LexerState* %l0
  %t838 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t839 = load i8, i8* %l2
  br i1 %t836, label %then84, label %merge85
then84:
  %t840 = load %LexerState, %LexerState* %l0
  %t841 = extractvalue %LexerState %t840, 1
  store double %t841, double* %l32
  %t842 = load %LexerState, %LexerState* %l0
  %t843 = extractvalue %LexerState %t842, 2
  store double %t843, double* %l33
  %t844 = load %LexerState, %LexerState* %l0
  %t845 = extractvalue %LexerState %t844, 3
  store double %t845, double* %l34
  %t846 = load %LexerState, %LexerState* %l0
  %t847 = extractvalue %LexerState %t846, 1
  %t848 = sitofp i64 1 to double
  %t849 = fadd double %t847, %t848
  %t850 = load %LexerState, %LexerState* %l0
  %t851 = getelementptr %LexerState, %LexerState %t850, i32 0, i32 1
  store double %t849, double* %t851
  %t852 = load %LexerState, %LexerState* %l0
  %t853 = extractvalue %LexerState %t852, 3
  %t854 = sitofp i64 1 to double
  %t855 = fadd double %t853, %t854
  %t856 = load %LexerState, %LexerState* %l0
  %t857 = getelementptr %LexerState, %LexerState %t856, i32 0, i32 3
  store double %t855, double* %t857
  %t858 = load %LexerState, %LexerState* %l0
  %t859 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t860 = load i8, i8* %l2
  %t861 = load double, double* %l32
  %t862 = load double, double* %l33
  %t863 = load double, double* %l34
  br label %loop.header86
loop.header86:
  br label %loop.body87
loop.body87:
  %t864 = load %LexerState, %LexerState* %l0
  %t865 = extractvalue %LexerState %t864, 1
  %t866 = load %LexerState, %LexerState* %l0
  %t867 = extractvalue %LexerState %t866, 0
  %t868 = call i64 @sailfin_runtime_string_length(i8* %t867)
  %t869 = sitofp i64 %t868 to double
  %t870 = fcmp oge double %t865, %t869
  %t871 = load %LexerState, %LexerState* %l0
  %t872 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t873 = load i8, i8* %l2
  %t874 = load double, double* %l32
  %t875 = load double, double* %l33
  %t876 = load double, double* %l34
  br i1 %t870, label %then90, label %merge91
then90:
  br label %afterloop89
merge91:
  %t877 = load %LexerState, %LexerState* %l0
  %t878 = extractvalue %LexerState %t877, 0
  %t879 = load %LexerState, %LexerState* %l0
  %t880 = extractvalue %LexerState %t879, 1
  %t881 = fptosi double %t880 to i64
  %t882 = getelementptr i8, i8* %t878, i64 %t881
  %t883 = load i8, i8* %t882
  %t884 = alloca [2 x i8], align 1
  %t885 = getelementptr [2 x i8], [2 x i8]* %t884, i32 0, i32 0
  store i8 %t883, i8* %t885
  %t886 = getelementptr [2 x i8], [2 x i8]* %t884, i32 0, i32 1
  store i8 0, i8* %t886
  %t887 = getelementptr [2 x i8], [2 x i8]* %t884, i32 0, i32 0
  %t888 = call i1 @is_identifier_part(i8* %t887)
  %t889 = xor i1 %t888, 1
  %t890 = load %LexerState, %LexerState* %l0
  %t891 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t892 = load i8, i8* %l2
  %t893 = load double, double* %l32
  %t894 = load double, double* %l33
  %t895 = load double, double* %l34
  br i1 %t889, label %then92, label %merge93
then92:
  br label %afterloop89
merge93:
  %t896 = load %LexerState, %LexerState* %l0
  %t897 = extractvalue %LexerState %t896, 1
  %t898 = sitofp i64 1 to double
  %t899 = fadd double %t897, %t898
  %t900 = load %LexerState, %LexerState* %l0
  %t901 = getelementptr %LexerState, %LexerState %t900, i32 0, i32 1
  store double %t899, double* %t901
  %t902 = load %LexerState, %LexerState* %l0
  %t903 = extractvalue %LexerState %t902, 3
  %t904 = sitofp i64 1 to double
  %t905 = fadd double %t903, %t904
  %t906 = load %LexerState, %LexerState* %l0
  %t907 = getelementptr %LexerState, %LexerState %t906, i32 0, i32 3
  store double %t905, double* %t907
  br label %loop.latch88
loop.latch88:
  br label %loop.header86
afterloop89:
  %t908 = load %LexerState, %LexerState* %l0
  %t909 = extractvalue %LexerState %t908, 0
  %t910 = load double, double* %l32
  %t911 = load %LexerState, %LexerState* %l0
  %t912 = extractvalue %LexerState %t911, 1
  %t913 = call i8* @slice(i8* %t909, double %t910, double %t912)
  store i8* %t913, i8** %l35
  %t915 = load i8*, i8** %l35
  %s916 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h275946731, i32 0, i32 0
  %t917 = icmp eq i8* %t915, %s916
  br label %logical_or_entry_914

logical_or_entry_914:
  br i1 %t917, label %logical_or_merge_914, label %logical_or_right_914

logical_or_right_914:
  %t918 = load i8*, i8** %l35
  %s919 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2095430042, i32 0, i32 0
  %t920 = icmp eq i8* %t918, %s919
  br label %logical_or_right_end_914

logical_or_right_end_914:
  br label %logical_or_merge_914

logical_or_merge_914:
  %t921 = phi i1 [ true, %logical_or_entry_914 ], [ %t920, %logical_or_right_end_914 ]
  %t922 = load %LexerState, %LexerState* %l0
  %t923 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t924 = load i8, i8* %l2
  %t925 = load double, double* %l32
  %t926 = load double, double* %l33
  %t927 = load double, double* %l34
  %t928 = load i8*, i8** %l35
  br i1 %t921, label %then94, label %else95
then94:
  %t929 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t930 = alloca %TokenKind
  %t931 = getelementptr inbounds %TokenKind, %TokenKind* %t930, i32 0, i32 0
  store i32 3, i32* %t931
  %t932 = load i8*, i8** %l35
  %t933 = getelementptr inbounds %TokenKind, %TokenKind* %t930, i32 0, i32 1
  %t934 = bitcast [8 x i8]* %t933 to i8*
  %t935 = bitcast i8* %t934 to i8**
  store i8* %t932, i8** %t935
  %t936 = load %TokenKind, %TokenKind* %t930
  %t937 = insertvalue %Token undef, %TokenKind %t936, 0
  %t938 = load i8*, i8** %l35
  %t939 = insertvalue %Token %t937, i8* %t938, 1
  %t940 = load double, double* %l33
  %t941 = insertvalue %Token %t939, double %t940, 2
  %t942 = load double, double* %l34
  %t943 = insertvalue %Token %t941, double %t942, 3
  %t944 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t929, %Token %t943)
  store { %Token*, i64 }* %t944, { %Token*, i64 }** %l1
  br label %merge96
else95:
  %t945 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t946 = alloca %TokenKind
  %t947 = getelementptr inbounds %TokenKind, %TokenKind* %t946, i32 0, i32 0
  store i32 0, i32* %t947
  %t948 = load i8*, i8** %l35
  %t949 = getelementptr inbounds %TokenKind, %TokenKind* %t946, i32 0, i32 1
  %t950 = bitcast [8 x i8]* %t949 to i8*
  %t951 = bitcast i8* %t950 to i8**
  store i8* %t948, i8** %t951
  %t952 = load %TokenKind, %TokenKind* %t946
  %t953 = insertvalue %Token undef, %TokenKind %t952, 0
  %t954 = load i8*, i8** %l35
  %t955 = insertvalue %Token %t953, i8* %t954, 1
  %t956 = load double, double* %l33
  %t957 = insertvalue %Token %t955, double %t956, 2
  %t958 = load double, double* %l34
  %t959 = insertvalue %Token %t957, double %t958, 3
  %t960 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t945, %Token %t959)
  store { %Token*, i64 }* %t960, { %Token*, i64 }** %l1
  br label %merge96
merge96:
  %t961 = phi { %Token*, i64 }* [ %t944, %then94 ], [ %t960, %else95 ]
  store { %Token*, i64 }* %t961, { %Token*, i64 }** %l1
  br label %loop.latch2
merge85:
  %t962 = load %LexerState, %LexerState* %l0
  %t963 = extractvalue %LexerState %t962, 2
  store double %t963, double* %l36
  %t964 = load %LexerState, %LexerState* %l0
  %t965 = extractvalue %LexerState %t964, 3
  store double %t965, double* %l37
  %t966 = load i8, i8* %l2
  store i8 %t966, i8* %l38
  %t967 = load %LexerState, %LexerState* %l0
  %t968 = call i8* @peek_next_char(%LexerState %t967)
  store i8* %t968, i8** %l39
  %t969 = load i8*, i8** %l39
  %s970 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t971 = icmp ne i8* %t969, %s970
  %t972 = load %LexerState, %LexerState* %l0
  %t973 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t974 = load i8, i8* %l2
  %t975 = load double, double* %l36
  %t976 = load double, double* %l37
  %t977 = load i8, i8* %l38
  %t978 = load i8*, i8** %l39
  br i1 %t971, label %then97, label %merge98
then97:
  %t979 = load i8, i8* %l2
  %t980 = load i8*, i8** %l39
  %t981 = load i8, i8* %t980
  %t982 = add i8 %t979, %t981
  store i8 %t982, i8* %l40
  %t983 = load i8, i8* %l40
  %t984 = alloca [2 x i8], align 1
  %t985 = getelementptr [2 x i8], [2 x i8]* %t984, i32 0, i32 0
  store i8 %t983, i8* %t985
  %t986 = getelementptr [2 x i8], [2 x i8]* %t984, i32 0, i32 1
  store i8 0, i8* %t986
  %t987 = getelementptr [2 x i8], [2 x i8]* %t984, i32 0, i32 0
  %t988 = call i1 @is_two_char_symbol(i8* %t987)
  %t989 = load %LexerState, %LexerState* %l0
  %t990 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t991 = load i8, i8* %l2
  %t992 = load double, double* %l36
  %t993 = load double, double* %l37
  %t994 = load i8, i8* %l38
  %t995 = load i8*, i8** %l39
  %t996 = load i8, i8* %l40
  br i1 %t988, label %then99, label %merge100
then99:
  %t997 = load i8, i8* %l40
  store i8 %t997, i8* %l38
  %t998 = load %LexerState, %LexerState* %l0
  %t999 = extractvalue %LexerState %t998, 1
  %t1000 = sitofp i64 2 to double
  %t1001 = fadd double %t999, %t1000
  %t1002 = load %LexerState, %LexerState* %l0
  %t1003 = getelementptr %LexerState, %LexerState %t1002, i32 0, i32 1
  store double %t1001, double* %t1003
  %t1004 = load %LexerState, %LexerState* %l0
  %t1005 = extractvalue %LexerState %t1004, 3
  %t1006 = sitofp i64 2 to double
  %t1007 = fadd double %t1005, %t1006
  %t1008 = load %LexerState, %LexerState* %l0
  %t1009 = getelementptr %LexerState, %LexerState %t1008, i32 0, i32 3
  store double %t1007, double* %t1009
  %t1010 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t1011 = alloca %TokenKind
  %t1012 = getelementptr inbounds %TokenKind, %TokenKind* %t1011, i32 0, i32 0
  store i32 4, i32* %t1012
  %t1013 = load i8, i8* %l38
  %t1014 = call noalias i8* @malloc(i64 1)
  %t1015 = bitcast i8* %t1014 to i8*
  store i8 %t1013, i8* %t1015
  %t1016 = getelementptr inbounds %TokenKind, %TokenKind* %t1011, i32 0, i32 1
  %t1017 = bitcast [8 x i8]* %t1016 to i8*
  %t1018 = bitcast i8* %t1017 to i8**
  store i8* %t1014, i8** %t1018
  %t1019 = load %TokenKind, %TokenKind* %t1011
  %t1020 = insertvalue %Token undef, %TokenKind %t1019, 0
  %t1021 = load i8, i8* %l38
  %t1022 = alloca [2 x i8], align 1
  %t1023 = getelementptr [2 x i8], [2 x i8]* %t1022, i32 0, i32 0
  store i8 %t1021, i8* %t1023
  %t1024 = getelementptr [2 x i8], [2 x i8]* %t1022, i32 0, i32 1
  store i8 0, i8* %t1024
  %t1025 = getelementptr [2 x i8], [2 x i8]* %t1022, i32 0, i32 0
  %t1026 = insertvalue %Token %t1020, i8* %t1025, 1
  %t1027 = load double, double* %l36
  %t1028 = insertvalue %Token %t1026, double %t1027, 2
  %t1029 = load double, double* %l37
  %t1030 = insertvalue %Token %t1028, double %t1029, 3
  %t1031 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t1010, %Token %t1030)
  store { %Token*, i64 }* %t1031, { %Token*, i64 }** %l1
  br label %loop.latch2
merge100:
  br label %merge98
merge98:
  %t1032 = phi i8 [ %t997, %then97 ], [ %t977, %loop.body1 ]
  %t1033 = phi { %Token*, i64 }* [ %t1031, %then97 ], [ %t973, %loop.body1 ]
  store i8 %t1032, i8* %l38
  store { %Token*, i64 }* %t1033, { %Token*, i64 }** %l1
  %t1034 = load %LexerState, %LexerState* %l0
  %t1035 = extractvalue %LexerState %t1034, 1
  %t1036 = sitofp i64 1 to double
  %t1037 = fadd double %t1035, %t1036
  %t1038 = load %LexerState, %LexerState* %l0
  %t1039 = getelementptr %LexerState, %LexerState %t1038, i32 0, i32 1
  store double %t1037, double* %t1039
  %t1040 = load i8, i8* %l2
  %t1041 = icmp eq i8 %t1040, 10
  %t1042 = load %LexerState, %LexerState* %l0
  %t1043 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t1044 = load i8, i8* %l2
  %t1045 = load double, double* %l36
  %t1046 = load double, double* %l37
  %t1047 = load i8, i8* %l38
  %t1048 = load i8*, i8** %l39
  br i1 %t1041, label %then101, label %else102
then101:
  %t1049 = load %LexerState, %LexerState* %l0
  %t1050 = extractvalue %LexerState %t1049, 2
  %t1051 = sitofp i64 1 to double
  %t1052 = fadd double %t1050, %t1051
  %t1053 = load %LexerState, %LexerState* %l0
  %t1054 = getelementptr %LexerState, %LexerState %t1053, i32 0, i32 2
  store double %t1052, double* %t1054
  %t1055 = load %LexerState, %LexerState* %l0
  %t1056 = sitofp i64 1 to double
  %t1057 = getelementptr %LexerState, %LexerState %t1055, i32 0, i32 3
  store double %t1056, double* %t1057
  br label %merge103
else102:
  %t1058 = load %LexerState, %LexerState* %l0
  %t1059 = extractvalue %LexerState %t1058, 3
  %t1060 = sitofp i64 1 to double
  %t1061 = fadd double %t1059, %t1060
  %t1062 = load %LexerState, %LexerState* %l0
  %t1063 = getelementptr %LexerState, %LexerState %t1062, i32 0, i32 3
  store double %t1061, double* %t1063
  br label %merge103
merge103:
  %t1064 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t1065 = alloca %TokenKind
  %t1066 = getelementptr inbounds %TokenKind, %TokenKind* %t1065, i32 0, i32 0
  store i32 4, i32* %t1066
  %t1067 = load i8, i8* %l38
  %t1068 = call noalias i8* @malloc(i64 1)
  %t1069 = bitcast i8* %t1068 to i8*
  store i8 %t1067, i8* %t1069
  %t1070 = getelementptr inbounds %TokenKind, %TokenKind* %t1065, i32 0, i32 1
  %t1071 = bitcast [8 x i8]* %t1070 to i8*
  %t1072 = bitcast i8* %t1071 to i8**
  store i8* %t1068, i8** %t1072
  %t1073 = load %TokenKind, %TokenKind* %t1065
  %t1074 = insertvalue %Token undef, %TokenKind %t1073, 0
  %t1075 = load i8, i8* %l38
  %t1076 = alloca [2 x i8], align 1
  %t1077 = getelementptr [2 x i8], [2 x i8]* %t1076, i32 0, i32 0
  store i8 %t1075, i8* %t1077
  %t1078 = getelementptr [2 x i8], [2 x i8]* %t1076, i32 0, i32 1
  store i8 0, i8* %t1078
  %t1079 = getelementptr [2 x i8], [2 x i8]* %t1076, i32 0, i32 0
  %t1080 = insertvalue %Token %t1074, i8* %t1079, 1
  %t1081 = load double, double* %l36
  %t1082 = insertvalue %Token %t1080, double %t1081, 2
  %t1083 = load double, double* %l37
  %t1084 = insertvalue %Token %t1082, double %t1083, 3
  %t1085 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t1064, %Token %t1084)
  store { %Token*, i64 }* %t1085, { %Token*, i64 }** %l1
  br label %loop.latch2
loop.latch2:
  %t1086 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br label %loop.header0
afterloop3:
  %t1088 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t1089 = load %LexerState, %LexerState* %l0
  %t1090 = extractvalue %LexerState %t1089, 2
  %t1091 = load %LexerState, %LexerState* %l0
  %t1092 = extractvalue %LexerState %t1091, 3
  %t1093 = call %Token @eof_token(double %t1090, double %t1092)
  %t1094 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t1088, %Token %t1093)
  store { %Token*, i64 }* %t1094, { %Token*, i64 }** %l1
  %t1095 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  ret { %Token*, i64 }* %t1095
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
  %t0 = call noalias i8* @malloc(i64 32)
  %t1 = bitcast i8* %t0 to %Token*
  store %Token %token, %Token* %t1
  %t2 = alloca [1 x i8*]
  %t3 = getelementptr [1 x i8*], [1 x i8*]* %t2, i32 0, i32 0
  %t4 = getelementptr i8*, i8** %t3, i64 0
  store i8* %t0, i8** %t4
  %t5 = alloca { i8**, i64 }
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 0
  store i8** %t3, i8*** %t6
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* %t5, i32 0, i32 1
  store i64 1, i64* %t7
  %t8 = bitcast { %Token*, i64 }* %tokens to { i8**, i64 }*
  %t9 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t8, { i8**, i64 }* %t5)
  %t10 = bitcast { i8**, i64 }* %t9 to { %Token*, i64 }*
  ret { %Token*, i64 }* %t10
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
  %s9 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
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
  %s1 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193428050, i32 0, i32 0
  %t2 = icmp eq i8* %value, %s1
  br label %logical_or_entry_0

logical_or_entry_0:
  br i1 %t2, label %logical_or_merge_0, label %logical_or_right_0

logical_or_right_0:
  %s4 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193445474, i32 0, i32 0
  %t5 = icmp eq i8* %value, %s4
  br label %logical_or_entry_3

logical_or_entry_3:
  br i1 %t5, label %logical_or_merge_3, label %logical_or_right_3

logical_or_right_3:
  %s7 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193445441, i32 0, i32 0
  %t8 = icmp eq i8* %value, %s7
  br label %logical_or_entry_6

logical_or_entry_6:
  br i1 %t8, label %logical_or_merge_6, label %logical_or_right_6

logical_or_right_6:
  %s10 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193414949, i32 0, i32 0
  %t11 = icmp eq i8* %value, %s10
  br label %logical_or_entry_9

logical_or_entry_9:
  br i1 %t11, label %logical_or_merge_9, label %logical_or_right_9

logical_or_right_9:
  %s13 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193444352, i32 0, i32 0
  %t14 = icmp eq i8* %value, %s13
  br label %logical_or_entry_12

logical_or_entry_12:
  br i1 %t14, label %logical_or_merge_12, label %logical_or_right_12

logical_or_right_12:
  %s16 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193446530, i32 0, i32 0
  %t17 = icmp eq i8* %value, %s16
  br label %logical_or_entry_15

logical_or_entry_15:
  br i1 %t17, label %logical_or_merge_15, label %logical_or_right_15

logical_or_right_15:
  %s19 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193419635, i32 0, i32 0
  %t20 = icmp eq i8* %value, %s19
  br label %logical_or_entry_18

logical_or_entry_18:
  br i1 %t20, label %logical_or_merge_18, label %logical_or_right_18

logical_or_right_18:
  %s22 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193516127, i32 0, i32 0
  %t23 = icmp eq i8* %value, %s22
  br label %logical_or_entry_21

logical_or_entry_21:
  br i1 %t23, label %logical_or_merge_21, label %logical_or_right_21

logical_or_right_21:
  %s24 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193428611, i32 0, i32 0
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