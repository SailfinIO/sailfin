; ModuleID = 'sailfin'
source_filename = "sailfin"

%LexerState = type { i8*, double, double, double }
%Token = type { %TokenKind, i8*, double, double }

%TokenKind = type { i32, [8 x i8] }

declare void @sailfin_runtime_bounds_check(i64, i64)
declare i8* @sailfin_runtime_substring(i8*, i64, i64)
declare i64 @sailfin_runtime_string_length(i8*)
declare i8* @sailfin_runtime_string_concat(i8*, i8*)
declare double @char_code(i8*)
declare { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }*, { i8**, i64 }*)
declare i8* @sailfin_runtime_get_field(i8*, i8*)

declare noalias i8* @malloc(i64)

@runtime = external global i8**

@.str.len0.h177573 = private unnamed_addr constant [1 x i8] c"\00"
@.str.len4.h275946731 = private unnamed_addr constant [5 x i8] c"true\00"
@.str.len5.h2095430042 = private unnamed_addr constant [6 x i8] c"false\00"
@.str.len2.h193428050 = private unnamed_addr constant [3 x i8] c"->\00"
@.str.len2.h193445474 = private unnamed_addr constant [3 x i8] c"=>\00"
@.str.len2.h193445441 = private unnamed_addr constant [3 x i8] c"==\00"
@.str.len2.h193414949 = private unnamed_addr constant [3 x i8] c"!=\00"
@.str.len2.h193444352 = private unnamed_addr constant [3 x i8] c"<=\00"
@.str.len2.h193446530 = private unnamed_addr constant [3 x i8] c">=\00"
@.str.len2.h193419635 = private unnamed_addr constant [3 x i8] c"&&\00"
@.str.len2.h193516127 = private unnamed_addr constant [3 x i8] c"||\00"
@.str.len2.h193428611 = private unnamed_addr constant [3 x i8] c"..\00"

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
  %t1100 = phi { %Token*, i64 }* [ %t13, %entry ], [ %t1099, %loop.latch2 ]
  store { %Token*, i64 }* %t1100, { %Token*, i64 }** %l1
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
  %t102 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t100, double* %t102
  %t103 = load %LexerState, %LexerState* %l0
  %t104 = extractvalue %LexerState %t103, 2
  %t105 = sitofp i64 1 to double
  %t106 = fadd double %t104, %t105
  %t107 = load %LexerState, %LexerState* %l0
  %t108 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 2
  store double %t106, double* %t108
  %t109 = load %LexerState, %LexerState* %l0
  %t110 = sitofp i64 1 to double
  %t111 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t110, double* %t111
  br label %merge18
else17:
  %t112 = load %LexerState, %LexerState* %l0
  %t113 = extractvalue %LexerState %t112, 1
  %t114 = sitofp i64 1 to double
  %t115 = fadd double %t113, %t114
  %t116 = load %LexerState, %LexerState* %l0
  %t117 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t115, double* %t117
  %t118 = load %LexerState, %LexerState* %l0
  %t119 = extractvalue %LexerState %t118, 3
  %t120 = sitofp i64 1 to double
  %t121 = fadd double %t119, %t120
  %t122 = load %LexerState, %LexerState* %l0
  %t123 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
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
  %t165 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t163, double* %t165
  %t166 = load %LexerState, %LexerState* %l0
  %t167 = extractvalue %LexerState %t166, 3
  %t168 = sitofp i64 2 to double
  %t169 = fadd double %t167, %t168
  %t170 = load %LexerState, %LexerState* %l0
  %t171 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
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
  %t232 = load double, double* %l11
  %t233 = load double, double* %l12
  %t234 = load %LexerState, %LexerState* %l0
  %t235 = extractvalue %LexerState %t234, 0
  %t236 = load double, double* %l8
  %t237 = load double, double* %l11
  %t238 = call i8* @slice(i8* %t235, double %t236, double %t237)
  store i8* %t238, i8** %l14
  %t239 = load double, double* %l11
  %t240 = load %LexerState, %LexerState* %l0
  %t241 = extractvalue %LexerState %t240, 1
  %t242 = fsub double %t239, %t241
  store double %t242, double* %l15
  %t243 = load double, double* %l11
  %t244 = load %LexerState, %LexerState* %l0
  %t245 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t243, double* %t245
  %t246 = load %LexerState, %LexerState* %l0
  %t247 = extractvalue %LexerState %t246, 3
  %t248 = load double, double* %l15
  %t249 = fadd double %t247, %t248
  %t250 = load %LexerState, %LexerState* %l0
  %t251 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t249, double* %t251
  %t252 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t253 = insertvalue %TokenKind undef, i32 6, 0
  %t254 = insertvalue %Token undef, %TokenKind %t253, 0
  %t255 = load i8*, i8** %l14
  %t256 = insertvalue %Token %t254, i8* %t255, 1
  %t257 = load double, double* %l9
  %t258 = insertvalue %Token %t256, double %t257, 2
  %t259 = load double, double* %l10
  %t260 = insertvalue %Token %t258, double %t259, 3
  %t261 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t252, %Token %t260)
  store { %Token*, i64 }* %t261, { %Token*, i64 }** %l1
  br label %loop.latch2
merge22:
  %t262 = load i8*, i8** %l7
  %t263 = load i8, i8* %t262
  %t264 = icmp eq i8 %t263, 42
  %t265 = load %LexerState, %LexerState* %l0
  %t266 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t267 = load i8, i8* %l2
  %t268 = load i8*, i8** %l7
  br i1 %t264, label %then31, label %merge32
then31:
  %t269 = load %LexerState, %LexerState* %l0
  %t270 = extractvalue %LexerState %t269, 1
  store double %t270, double* %l16
  %t271 = load %LexerState, %LexerState* %l0
  %t272 = extractvalue %LexerState %t271, 2
  store double %t272, double* %l17
  %t273 = load %LexerState, %LexerState* %l0
  %t274 = extractvalue %LexerState %t273, 3
  store double %t274, double* %l18
  %t275 = load %LexerState, %LexerState* %l0
  %t276 = extractvalue %LexerState %t275, 1
  %t277 = sitofp i64 2 to double
  %t278 = fadd double %t276, %t277
  %t279 = load %LexerState, %LexerState* %l0
  %t280 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t278, double* %t280
  %t281 = load %LexerState, %LexerState* %l0
  %t282 = extractvalue %LexerState %t281, 3
  %t283 = sitofp i64 2 to double
  %t284 = fadd double %t282, %t283
  %t285 = load %LexerState, %LexerState* %l0
  %t286 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t284, double* %t286
  %t287 = load %LexerState, %LexerState* %l0
  %t288 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t289 = load i8, i8* %l2
  %t290 = load i8*, i8** %l7
  %t291 = load double, double* %l16
  %t292 = load double, double* %l17
  %t293 = load double, double* %l18
  br label %loop.header33
loop.header33:
  br label %loop.body34
loop.body34:
  %t294 = load %LexerState, %LexerState* %l0
  %t295 = extractvalue %LexerState %t294, 1
  %t296 = load %LexerState, %LexerState* %l0
  %t297 = extractvalue %LexerState %t296, 0
  %t298 = call i64 @sailfin_runtime_string_length(i8* %t297)
  %t299 = sitofp i64 %t298 to double
  %t300 = fcmp oge double %t295, %t299
  %t301 = load %LexerState, %LexerState* %l0
  %t302 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t303 = load i8, i8* %l2
  %t304 = load i8*, i8** %l7
  %t305 = load double, double* %l16
  %t306 = load double, double* %l17
  %t307 = load double, double* %l18
  br i1 %t300, label %then37, label %merge38
then37:
  br label %afterloop36
merge38:
  %t309 = load %LexerState, %LexerState* %l0
  %t310 = extractvalue %LexerState %t309, 0
  %t311 = load %LexerState, %LexerState* %l0
  %t312 = extractvalue %LexerState %t311, 1
  %t313 = fptosi double %t312 to i64
  %t314 = getelementptr i8, i8* %t310, i64 %t313
  %t315 = load i8, i8* %t314
  %t316 = icmp eq i8 %t315, 42
  br label %logical_and_entry_308

logical_and_entry_308:
  br i1 %t316, label %logical_and_right_308, label %logical_and_merge_308

logical_and_right_308:
  %t317 = load %LexerState, %LexerState* %l0
  %t318 = call i8* @peek_next_char(%LexerState %t317)
  %t319 = load i8, i8* %t318
  %t320 = icmp eq i8 %t319, 47
  br label %logical_and_right_end_308

logical_and_right_end_308:
  br label %logical_and_merge_308

logical_and_merge_308:
  %t321 = phi i1 [ false, %logical_and_entry_308 ], [ %t320, %logical_and_right_end_308 ]
  %t322 = load %LexerState, %LexerState* %l0
  %t323 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t324 = load i8, i8* %l2
  %t325 = load i8*, i8** %l7
  %t326 = load double, double* %l16
  %t327 = load double, double* %l17
  %t328 = load double, double* %l18
  br i1 %t321, label %then39, label %merge40
then39:
  %t329 = load %LexerState, %LexerState* %l0
  %t330 = extractvalue %LexerState %t329, 1
  %t331 = sitofp i64 2 to double
  %t332 = fadd double %t330, %t331
  %t333 = load %LexerState, %LexerState* %l0
  %t334 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t332, double* %t334
  %t335 = load %LexerState, %LexerState* %l0
  %t336 = extractvalue %LexerState %t335, 3
  %t337 = sitofp i64 2 to double
  %t338 = fadd double %t336, %t337
  %t339 = load %LexerState, %LexerState* %l0
  %t340 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t338, double* %t340
  br label %afterloop36
merge40:
  %t341 = load %LexerState, %LexerState* %l0
  %t342 = extractvalue %LexerState %t341, 0
  %t343 = load %LexerState, %LexerState* %l0
  %t344 = extractvalue %LexerState %t343, 1
  %t345 = fptosi double %t344 to i64
  %t346 = getelementptr i8, i8* %t342, i64 %t345
  %t347 = load i8, i8* %t346
  %t348 = icmp eq i8 %t347, 10
  %t349 = load %LexerState, %LexerState* %l0
  %t350 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t351 = load i8, i8* %l2
  %t352 = load i8*, i8** %l7
  %t353 = load double, double* %l16
  %t354 = load double, double* %l17
  %t355 = load double, double* %l18
  br i1 %t348, label %then41, label %else42
then41:
  %t356 = load %LexerState, %LexerState* %l0
  %t357 = extractvalue %LexerState %t356, 1
  %t358 = sitofp i64 1 to double
  %t359 = fadd double %t357, %t358
  %t360 = load %LexerState, %LexerState* %l0
  %t361 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t359, double* %t361
  %t362 = load %LexerState, %LexerState* %l0
  %t363 = extractvalue %LexerState %t362, 2
  %t364 = sitofp i64 1 to double
  %t365 = fadd double %t363, %t364
  %t366 = load %LexerState, %LexerState* %l0
  %t367 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 2
  store double %t365, double* %t367
  %t368 = load %LexerState, %LexerState* %l0
  %t369 = sitofp i64 1 to double
  %t370 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t369, double* %t370
  br label %merge43
else42:
  %t371 = load %LexerState, %LexerState* %l0
  %t372 = extractvalue %LexerState %t371, 1
  %t373 = sitofp i64 1 to double
  %t374 = fadd double %t372, %t373
  %t375 = load %LexerState, %LexerState* %l0
  %t376 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t374, double* %t376
  %t377 = load %LexerState, %LexerState* %l0
  %t378 = extractvalue %LexerState %t377, 3
  %t379 = sitofp i64 1 to double
  %t380 = fadd double %t378, %t379
  %t381 = load %LexerState, %LexerState* %l0
  %t382 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t380, double* %t382
  br label %merge43
merge43:
  br label %loop.latch35
loop.latch35:
  br label %loop.header33
afterloop36:
  %t383 = load %LexerState, %LexerState* %l0
  %t384 = extractvalue %LexerState %t383, 0
  %t385 = load double, double* %l16
  %t386 = load %LexerState, %LexerState* %l0
  %t387 = extractvalue %LexerState %t386, 1
  %t388 = call i8* @slice(i8* %t384, double %t385, double %t387)
  store i8* %t388, i8** %l19
  %t389 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t390 = insertvalue %TokenKind undef, i32 6, 0
  %t391 = insertvalue %Token undef, %TokenKind %t390, 0
  %t392 = load i8*, i8** %l19
  %t393 = insertvalue %Token %t391, i8* %t392, 1
  %t394 = load double, double* %l17
  %t395 = insertvalue %Token %t393, double %t394, 2
  %t396 = load double, double* %l18
  %t397 = insertvalue %Token %t395, double %t396, 3
  %t398 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t389, %Token %t397)
  store { %Token*, i64 }* %t398, { %Token*, i64 }** %l1
  br label %loop.latch2
merge32:
  %t399 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t400 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br label %merge20
merge20:
  %t401 = phi { %Token*, i64 }* [ %t399, %merge32 ], [ %t143, %merge7 ]
  %t402 = phi { %Token*, i64 }* [ %t400, %merge32 ], [ %t143, %merge7 ]
  store { %Token*, i64 }* %t401, { %Token*, i64 }** %l1
  store { %Token*, i64 }* %t402, { %Token*, i64 }** %l1
  %t403 = load i8, i8* %l2
  %t404 = alloca [2 x i8], align 1
  %t405 = getelementptr [2 x i8], [2 x i8]* %t404, i32 0, i32 0
  store i8 %t403, i8* %t405
  %t406 = getelementptr [2 x i8], [2 x i8]* %t404, i32 0, i32 1
  store i8 0, i8* %t406
  %t407 = getelementptr [2 x i8], [2 x i8]* %t404, i32 0, i32 0
  %t408 = call i1 @is_double_quote(i8* %t407)
  %t409 = load %LexerState, %LexerState* %l0
  %t410 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t411 = load i8, i8* %l2
  br i1 %t408, label %then44, label %merge45
then44:
  %t412 = load %LexerState, %LexerState* %l0
  %t413 = extractvalue %LexerState %t412, 1
  store double %t413, double* %l20
  %t414 = load %LexerState, %LexerState* %l0
  %t415 = extractvalue %LexerState %t414, 2
  store double %t415, double* %l21
  %t416 = load %LexerState, %LexerState* %l0
  %t417 = extractvalue %LexerState %t416, 3
  store double %t417, double* %l22
  %t418 = load %LexerState, %LexerState* %l0
  %t419 = extractvalue %LexerState %t418, 1
  %t420 = sitofp i64 1 to double
  %t421 = fadd double %t419, %t420
  %t422 = load %LexerState, %LexerState* %l0
  %t423 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t421, double* %t423
  %t424 = load %LexerState, %LexerState* %l0
  %t425 = extractvalue %LexerState %t424, 3
  %t426 = sitofp i64 1 to double
  %t427 = fadd double %t425, %t426
  %t428 = load %LexerState, %LexerState* %l0
  %t429 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t427, double* %t429
  %s430 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s430, i8** %l23
  store i1 0, i1* %l24
  %t431 = load %LexerState, %LexerState* %l0
  %t432 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t433 = load i8, i8* %l2
  %t434 = load double, double* %l20
  %t435 = load double, double* %l21
  %t436 = load double, double* %l22
  %t437 = load i8*, i8** %l23
  %t438 = load i1, i1* %l24
  br label %loop.header46
loop.header46:
  %t594 = phi i1 [ %t438, %then44 ], [ %t592, %loop.latch48 ]
  %t595 = phi i8* [ %t437, %then44 ], [ %t593, %loop.latch48 ]
  store i1 %t594, i1* %l24
  store i8* %t595, i8** %l23
  br label %loop.body47
loop.body47:
  %t439 = load %LexerState, %LexerState* %l0
  %t440 = extractvalue %LexerState %t439, 1
  %t441 = load %LexerState, %LexerState* %l0
  %t442 = extractvalue %LexerState %t441, 0
  %t443 = call i64 @sailfin_runtime_string_length(i8* %t442)
  %t444 = sitofp i64 %t443 to double
  %t445 = fcmp oge double %t440, %t444
  %t446 = load %LexerState, %LexerState* %l0
  %t447 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t448 = load i8, i8* %l2
  %t449 = load double, double* %l20
  %t450 = load double, double* %l21
  %t451 = load double, double* %l22
  %t452 = load i8*, i8** %l23
  %t453 = load i1, i1* %l24
  br i1 %t445, label %then50, label %merge51
then50:
  br label %afterloop49
merge51:
  %t454 = load %LexerState, %LexerState* %l0
  %t455 = extractvalue %LexerState %t454, 0
  %t456 = load %LexerState, %LexerState* %l0
  %t457 = extractvalue %LexerState %t456, 1
  %t458 = fptosi double %t457 to i64
  %t459 = getelementptr i8, i8* %t455, i64 %t458
  %t460 = load i8, i8* %t459
  store i8 %t460, i8* %l25
  %t462 = load i1, i1* %l24
  br label %logical_and_entry_461

logical_and_entry_461:
  br i1 %t462, label %logical_and_right_461, label %logical_and_merge_461

logical_and_right_461:
  %t463 = load i8, i8* %l25
  %t464 = alloca [2 x i8], align 1
  %t465 = getelementptr [2 x i8], [2 x i8]* %t464, i32 0, i32 0
  store i8 %t463, i8* %t465
  %t466 = getelementptr [2 x i8], [2 x i8]* %t464, i32 0, i32 1
  store i8 0, i8* %t466
  %t467 = getelementptr [2 x i8], [2 x i8]* %t464, i32 0, i32 0
  %t468 = call i1 @is_double_quote(i8* %t467)
  br label %logical_and_right_end_461

logical_and_right_end_461:
  br label %logical_and_merge_461

logical_and_merge_461:
  %t469 = phi i1 [ false, %logical_and_entry_461 ], [ %t468, %logical_and_right_end_461 ]
  %t470 = xor i1 %t469, 1
  %t471 = load %LexerState, %LexerState* %l0
  %t472 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t473 = load i8, i8* %l2
  %t474 = load double, double* %l20
  %t475 = load double, double* %l21
  %t476 = load double, double* %l22
  %t477 = load i8*, i8** %l23
  %t478 = load i1, i1* %l24
  %t479 = load i8, i8* %l25
  br i1 %t470, label %then52, label %merge53
then52:
  %t480 = load %LexerState, %LexerState* %l0
  %t481 = extractvalue %LexerState %t480, 1
  %t482 = sitofp i64 1 to double
  %t483 = fadd double %t481, %t482
  %t484 = load %LexerState, %LexerState* %l0
  %t485 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t483, double* %t485
  %t486 = load %LexerState, %LexerState* %l0
  %t487 = extractvalue %LexerState %t486, 3
  %t488 = sitofp i64 1 to double
  %t489 = fadd double %t487, %t488
  %t490 = load %LexerState, %LexerState* %l0
  %t491 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t489, double* %t491
  br label %afterloop49
merge53:
  %t493 = load i1, i1* %l24
  br label %logical_and_entry_492

logical_and_entry_492:
  br i1 %t493, label %logical_and_right_492, label %logical_and_merge_492

logical_and_right_492:
  %t494 = load i8, i8* %l25
  %t495 = alloca [2 x i8], align 1
  %t496 = getelementptr [2 x i8], [2 x i8]* %t495, i32 0, i32 0
  store i8 %t494, i8* %t496
  %t497 = getelementptr [2 x i8], [2 x i8]* %t495, i32 0, i32 1
  store i8 0, i8* %t497
  %t498 = getelementptr [2 x i8], [2 x i8]* %t495, i32 0, i32 0
  %t499 = call i1 @is_backslash(i8* %t498)
  br label %logical_and_right_end_492

logical_and_right_end_492:
  br label %logical_and_merge_492

logical_and_merge_492:
  %t500 = phi i1 [ false, %logical_and_entry_492 ], [ %t499, %logical_and_right_end_492 ]
  %t501 = xor i1 %t500, 1
  %t502 = load %LexerState, %LexerState* %l0
  %t503 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t504 = load i8, i8* %l2
  %t505 = load double, double* %l20
  %t506 = load double, double* %l21
  %t507 = load double, double* %l22
  %t508 = load i8*, i8** %l23
  %t509 = load i1, i1* %l24
  %t510 = load i8, i8* %l25
  br i1 %t501, label %then54, label %merge55
then54:
  store i1 1, i1* %l24
  %t511 = load %LexerState, %LexerState* %l0
  %t512 = extractvalue %LexerState %t511, 1
  %t513 = sitofp i64 1 to double
  %t514 = fadd double %t512, %t513
  %t515 = load %LexerState, %LexerState* %l0
  %t516 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t514, double* %t516
  %t517 = load %LexerState, %LexerState* %l0
  %t518 = extractvalue %LexerState %t517, 3
  %t519 = sitofp i64 1 to double
  %t520 = fadd double %t518, %t519
  %t521 = load %LexerState, %LexerState* %l0
  %t522 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t520, double* %t522
  br label %loop.latch48
merge55:
  %t523 = load i1, i1* %l24
  %t524 = load %LexerState, %LexerState* %l0
  %t525 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t526 = load i8, i8* %l2
  %t527 = load double, double* %l20
  %t528 = load double, double* %l21
  %t529 = load double, double* %l22
  %t530 = load i8*, i8** %l23
  %t531 = load i1, i1* %l24
  %t532 = load i8, i8* %l25
  br i1 %t523, label %then56, label %else57
then56:
  %t533 = load i8*, i8** %l23
  %t534 = load i8, i8* %l25
  %t535 = alloca [2 x i8], align 1
  %t536 = getelementptr [2 x i8], [2 x i8]* %t535, i32 0, i32 0
  store i8 %t534, i8* %t536
  %t537 = getelementptr [2 x i8], [2 x i8]* %t535, i32 0, i32 1
  store i8 0, i8* %t537
  %t538 = getelementptr [2 x i8], [2 x i8]* %t535, i32 0, i32 0
  %t539 = call i8* @interpret_escape(i8* %t538)
  %t540 = call i8* @sailfin_runtime_string_concat(i8* %t533, i8* %t539)
  store i8* %t540, i8** %l23
  store i1 0, i1* %l24
  %t541 = load i8*, i8** %l23
  %t542 = load i1, i1* %l24
  br label %merge58
else57:
  %t543 = load i8*, i8** %l23
  %t544 = load i8, i8* %l25
  %t545 = load i8, i8* %t543
  %t546 = add i8 %t545, %t544
  %t547 = alloca [2 x i8], align 1
  %t548 = getelementptr [2 x i8], [2 x i8]* %t547, i32 0, i32 0
  store i8 %t546, i8* %t548
  %t549 = getelementptr [2 x i8], [2 x i8]* %t547, i32 0, i32 1
  store i8 0, i8* %t549
  %t550 = getelementptr [2 x i8], [2 x i8]* %t547, i32 0, i32 0
  store i8* %t550, i8** %l23
  %t551 = load i8*, i8** %l23
  br label %merge58
merge58:
  %t552 = phi i8* [ %t541, %then56 ], [ %t551, %else57 ]
  %t553 = phi i1 [ %t542, %then56 ], [ %t531, %else57 ]
  store i8* %t552, i8** %l23
  store i1 %t553, i1* %l24
  %t554 = load i8, i8* %l25
  %t555 = icmp eq i8 %t554, 10
  %t556 = load %LexerState, %LexerState* %l0
  %t557 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t558 = load i8, i8* %l2
  %t559 = load double, double* %l20
  %t560 = load double, double* %l21
  %t561 = load double, double* %l22
  %t562 = load i8*, i8** %l23
  %t563 = load i1, i1* %l24
  %t564 = load i8, i8* %l25
  br i1 %t555, label %then59, label %else60
then59:
  %t565 = load %LexerState, %LexerState* %l0
  %t566 = extractvalue %LexerState %t565, 1
  %t567 = sitofp i64 1 to double
  %t568 = fadd double %t566, %t567
  %t569 = load %LexerState, %LexerState* %l0
  %t570 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t568, double* %t570
  %t571 = load %LexerState, %LexerState* %l0
  %t572 = extractvalue %LexerState %t571, 2
  %t573 = sitofp i64 1 to double
  %t574 = fadd double %t572, %t573
  %t575 = load %LexerState, %LexerState* %l0
  %t576 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 2
  store double %t574, double* %t576
  %t577 = load %LexerState, %LexerState* %l0
  %t578 = sitofp i64 1 to double
  %t579 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t578, double* %t579
  br label %merge61
else60:
  %t580 = load %LexerState, %LexerState* %l0
  %t581 = extractvalue %LexerState %t580, 1
  %t582 = sitofp i64 1 to double
  %t583 = fadd double %t581, %t582
  %t584 = load %LexerState, %LexerState* %l0
  %t585 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t583, double* %t585
  %t586 = load %LexerState, %LexerState* %l0
  %t587 = extractvalue %LexerState %t586, 3
  %t588 = sitofp i64 1 to double
  %t589 = fadd double %t587, %t588
  %t590 = load %LexerState, %LexerState* %l0
  %t591 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t589, double* %t591
  br label %merge61
merge61:
  br label %loop.latch48
loop.latch48:
  %t592 = load i1, i1* %l24
  %t593 = load i8*, i8** %l23
  br label %loop.header46
afterloop49:
  %t596 = load i1, i1* %l24
  %t597 = load i8*, i8** %l23
  %t598 = load %LexerState, %LexerState* %l0
  %t599 = extractvalue %LexerState %t598, 0
  %t600 = load double, double* %l20
  %t601 = load %LexerState, %LexerState* %l0
  %t602 = extractvalue %LexerState %t601, 1
  %t603 = call i8* @slice(i8* %t599, double %t600, double %t602)
  store i8* %t603, i8** %l26
  %t604 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t605 = alloca %TokenKind
  %t606 = getelementptr inbounds %TokenKind, %TokenKind* %t605, i32 0, i32 0
  store i32 2, i32* %t606
  %t607 = load i8*, i8** %l23
  %t608 = getelementptr inbounds %TokenKind, %TokenKind* %t605, i32 0, i32 1
  %t609 = bitcast [8 x i8]* %t608 to i8*
  %t610 = bitcast i8* %t609 to i8**
  store i8* %t607, i8** %t610
  %t611 = load %TokenKind, %TokenKind* %t605
  %t612 = insertvalue %Token undef, %TokenKind %t611, 0
  %t613 = load i8*, i8** %l26
  %t614 = insertvalue %Token %t612, i8* %t613, 1
  %t615 = load double, double* %l21
  %t616 = insertvalue %Token %t614, double %t615, 2
  %t617 = load double, double* %l22
  %t618 = insertvalue %Token %t616, double %t617, 3
  %t619 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t604, %Token %t618)
  store { %Token*, i64 }* %t619, { %Token*, i64 }** %l1
  br label %loop.latch2
merge45:
  %t620 = load i8, i8* %l2
  %t621 = alloca [2 x i8], align 1
  %t622 = getelementptr [2 x i8], [2 x i8]* %t621, i32 0, i32 0
  store i8 %t620, i8* %t622
  %t623 = getelementptr [2 x i8], [2 x i8]* %t621, i32 0, i32 1
  store i8 0, i8* %t623
  %t624 = getelementptr [2 x i8], [2 x i8]* %t621, i32 0, i32 0
  %t625 = call i1 @is_digit(i8* %t624)
  %t626 = load %LexerState, %LexerState* %l0
  %t627 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t628 = load i8, i8* %l2
  br i1 %t625, label %then62, label %merge63
then62:
  %t629 = load %LexerState, %LexerState* %l0
  %t630 = extractvalue %LexerState %t629, 1
  store double %t630, double* %l27
  %t631 = load %LexerState, %LexerState* %l0
  %t632 = extractvalue %LexerState %t631, 2
  store double %t632, double* %l28
  %t633 = load %LexerState, %LexerState* %l0
  %t634 = extractvalue %LexerState %t633, 3
  store double %t634, double* %l29
  %t635 = load %LexerState, %LexerState* %l0
  %t636 = extractvalue %LexerState %t635, 1
  %t637 = sitofp i64 1 to double
  %t638 = fadd double %t636, %t637
  %t639 = load %LexerState, %LexerState* %l0
  %t640 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t638, double* %t640
  %t641 = load %LexerState, %LexerState* %l0
  %t642 = extractvalue %LexerState %t641, 3
  %t643 = sitofp i64 1 to double
  %t644 = fadd double %t642, %t643
  %t645 = load %LexerState, %LexerState* %l0
  %t646 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t644, double* %t646
  %t647 = load %LexerState, %LexerState* %l0
  %t648 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t649 = load i8, i8* %l2
  %t650 = load double, double* %l27
  %t651 = load double, double* %l28
  %t652 = load double, double* %l29
  br label %loop.header64
loop.header64:
  br label %loop.body65
loop.body65:
  %t653 = load %LexerState, %LexerState* %l0
  %t654 = extractvalue %LexerState %t653, 1
  %t655 = load %LexerState, %LexerState* %l0
  %t656 = extractvalue %LexerState %t655, 0
  %t657 = call i64 @sailfin_runtime_string_length(i8* %t656)
  %t658 = sitofp i64 %t657 to double
  %t659 = fcmp oge double %t654, %t658
  %t660 = load %LexerState, %LexerState* %l0
  %t661 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t662 = load i8, i8* %l2
  %t663 = load double, double* %l27
  %t664 = load double, double* %l28
  %t665 = load double, double* %l29
  br i1 %t659, label %then68, label %merge69
then68:
  br label %afterloop67
merge69:
  %t666 = load %LexerState, %LexerState* %l0
  %t667 = extractvalue %LexerState %t666, 0
  %t668 = load %LexerState, %LexerState* %l0
  %t669 = extractvalue %LexerState %t668, 1
  %t670 = fptosi double %t669 to i64
  %t671 = getelementptr i8, i8* %t667, i64 %t670
  %t672 = load i8, i8* %t671
  %t673 = alloca [2 x i8], align 1
  %t674 = getelementptr [2 x i8], [2 x i8]* %t673, i32 0, i32 0
  store i8 %t672, i8* %t674
  %t675 = getelementptr [2 x i8], [2 x i8]* %t673, i32 0, i32 1
  store i8 0, i8* %t675
  %t676 = getelementptr [2 x i8], [2 x i8]* %t673, i32 0, i32 0
  %t677 = call i1 @is_digit(i8* %t676)
  %t678 = xor i1 %t677, 1
  %t679 = load %LexerState, %LexerState* %l0
  %t680 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t681 = load i8, i8* %l2
  %t682 = load double, double* %l27
  %t683 = load double, double* %l28
  %t684 = load double, double* %l29
  br i1 %t678, label %then70, label %merge71
then70:
  br label %afterloop67
merge71:
  %t685 = load %LexerState, %LexerState* %l0
  %t686 = extractvalue %LexerState %t685, 1
  %t687 = sitofp i64 1 to double
  %t688 = fadd double %t686, %t687
  %t689 = load %LexerState, %LexerState* %l0
  %t690 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t688, double* %t690
  %t691 = load %LexerState, %LexerState* %l0
  %t692 = extractvalue %LexerState %t691, 3
  %t693 = sitofp i64 1 to double
  %t694 = fadd double %t692, %t693
  %t695 = load %LexerState, %LexerState* %l0
  %t696 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t694, double* %t696
  br label %loop.latch66
loop.latch66:
  br label %loop.header64
afterloop67:
  %t698 = load %LexerState, %LexerState* %l0
  %t699 = extractvalue %LexerState %t698, 1
  %t700 = load %LexerState, %LexerState* %l0
  %t701 = extractvalue %LexerState %t700, 0
  %t702 = call i64 @sailfin_runtime_string_length(i8* %t701)
  %t703 = sitofp i64 %t702 to double
  %t704 = fcmp olt double %t699, %t703
  br label %logical_and_entry_697

logical_and_entry_697:
  br i1 %t704, label %logical_and_right_697, label %logical_and_merge_697

logical_and_right_697:
  %t705 = load %LexerState, %LexerState* %l0
  %t706 = extractvalue %LexerState %t705, 0
  %t707 = load %LexerState, %LexerState* %l0
  %t708 = extractvalue %LexerState %t707, 1
  %t709 = fptosi double %t708 to i64
  %t710 = getelementptr i8, i8* %t706, i64 %t709
  %t711 = load i8, i8* %t710
  %t712 = icmp eq i8 %t711, 46
  br label %logical_and_right_end_697

logical_and_right_end_697:
  br label %logical_and_merge_697

logical_and_merge_697:
  %t713 = phi i1 [ false, %logical_and_entry_697 ], [ %t712, %logical_and_right_end_697 ]
  %t714 = load %LexerState, %LexerState* %l0
  %t715 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t716 = load i8, i8* %l2
  %t717 = load double, double* %l27
  %t718 = load double, double* %l28
  %t719 = load double, double* %l29
  br i1 %t713, label %then72, label %merge73
then72:
  %t721 = load %LexerState, %LexerState* %l0
  %t722 = extractvalue %LexerState %t721, 1
  %t723 = sitofp i64 1 to double
  %t724 = fadd double %t722, %t723
  %t725 = load %LexerState, %LexerState* %l0
  %t726 = extractvalue %LexerState %t725, 0
  %t727 = call i64 @sailfin_runtime_string_length(i8* %t726)
  %t728 = sitofp i64 %t727 to double
  %t729 = fcmp olt double %t724, %t728
  br label %logical_and_entry_720

logical_and_entry_720:
  br i1 %t729, label %logical_and_right_720, label %logical_and_merge_720

logical_and_right_720:
  %t730 = load %LexerState, %LexerState* %l0
  %t731 = extractvalue %LexerState %t730, 0
  %t732 = load %LexerState, %LexerState* %l0
  %t733 = extractvalue %LexerState %t732, 1
  %t734 = sitofp i64 1 to double
  %t735 = fadd double %t733, %t734
  %t736 = fptosi double %t735 to i64
  %t737 = getelementptr i8, i8* %t731, i64 %t736
  %t738 = load i8, i8* %t737
  %t739 = alloca [2 x i8], align 1
  %t740 = getelementptr [2 x i8], [2 x i8]* %t739, i32 0, i32 0
  store i8 %t738, i8* %t740
  %t741 = getelementptr [2 x i8], [2 x i8]* %t739, i32 0, i32 1
  store i8 0, i8* %t741
  %t742 = getelementptr [2 x i8], [2 x i8]* %t739, i32 0, i32 0
  %t743 = call i1 @is_digit(i8* %t742)
  br label %logical_and_right_end_720

logical_and_right_end_720:
  br label %logical_and_merge_720

logical_and_merge_720:
  %t744 = phi i1 [ false, %logical_and_entry_720 ], [ %t743, %logical_and_right_end_720 ]
  store i1 %t744, i1* %l30
  %t745 = load i1, i1* %l30
  %t746 = load %LexerState, %LexerState* %l0
  %t747 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t748 = load i8, i8* %l2
  %t749 = load double, double* %l27
  %t750 = load double, double* %l28
  %t751 = load double, double* %l29
  %t752 = load i1, i1* %l30
  br i1 %t745, label %then74, label %merge75
then74:
  %t753 = load %LexerState, %LexerState* %l0
  %t754 = extractvalue %LexerState %t753, 1
  %t755 = sitofp i64 1 to double
  %t756 = fadd double %t754, %t755
  %t757 = load %LexerState, %LexerState* %l0
  %t758 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t756, double* %t758
  %t759 = load %LexerState, %LexerState* %l0
  %t760 = extractvalue %LexerState %t759, 3
  %t761 = sitofp i64 1 to double
  %t762 = fadd double %t760, %t761
  %t763 = load %LexerState, %LexerState* %l0
  %t764 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t762, double* %t764
  %t765 = load %LexerState, %LexerState* %l0
  %t766 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t767 = load i8, i8* %l2
  %t768 = load double, double* %l27
  %t769 = load double, double* %l28
  %t770 = load double, double* %l29
  %t771 = load i1, i1* %l30
  br label %loop.header76
loop.header76:
  br label %loop.body77
loop.body77:
  %t772 = load %LexerState, %LexerState* %l0
  %t773 = extractvalue %LexerState %t772, 1
  %t774 = load %LexerState, %LexerState* %l0
  %t775 = extractvalue %LexerState %t774, 0
  %t776 = call i64 @sailfin_runtime_string_length(i8* %t775)
  %t777 = sitofp i64 %t776 to double
  %t778 = fcmp oge double %t773, %t777
  %t779 = load %LexerState, %LexerState* %l0
  %t780 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t781 = load i8, i8* %l2
  %t782 = load double, double* %l27
  %t783 = load double, double* %l28
  %t784 = load double, double* %l29
  %t785 = load i1, i1* %l30
  br i1 %t778, label %then80, label %merge81
then80:
  br label %afterloop79
merge81:
  %t786 = load %LexerState, %LexerState* %l0
  %t787 = extractvalue %LexerState %t786, 0
  %t788 = load %LexerState, %LexerState* %l0
  %t789 = extractvalue %LexerState %t788, 1
  %t790 = fptosi double %t789 to i64
  %t791 = getelementptr i8, i8* %t787, i64 %t790
  %t792 = load i8, i8* %t791
  %t793 = alloca [2 x i8], align 1
  %t794 = getelementptr [2 x i8], [2 x i8]* %t793, i32 0, i32 0
  store i8 %t792, i8* %t794
  %t795 = getelementptr [2 x i8], [2 x i8]* %t793, i32 0, i32 1
  store i8 0, i8* %t795
  %t796 = getelementptr [2 x i8], [2 x i8]* %t793, i32 0, i32 0
  %t797 = call i1 @is_digit(i8* %t796)
  %t798 = xor i1 %t797, 1
  %t799 = load %LexerState, %LexerState* %l0
  %t800 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t801 = load i8, i8* %l2
  %t802 = load double, double* %l27
  %t803 = load double, double* %l28
  %t804 = load double, double* %l29
  %t805 = load i1, i1* %l30
  br i1 %t798, label %then82, label %merge83
then82:
  br label %afterloop79
merge83:
  %t806 = load %LexerState, %LexerState* %l0
  %t807 = extractvalue %LexerState %t806, 1
  %t808 = sitofp i64 1 to double
  %t809 = fadd double %t807, %t808
  %t810 = load %LexerState, %LexerState* %l0
  %t811 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t809, double* %t811
  %t812 = load %LexerState, %LexerState* %l0
  %t813 = extractvalue %LexerState %t812, 3
  %t814 = sitofp i64 1 to double
  %t815 = fadd double %t813, %t814
  %t816 = load %LexerState, %LexerState* %l0
  %t817 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t815, double* %t817
  br label %loop.latch78
loop.latch78:
  br label %loop.header76
afterloop79:
  br label %merge75
merge75:
  br label %merge73
merge73:
  %t818 = load %LexerState, %LexerState* %l0
  %t819 = extractvalue %LexerState %t818, 0
  %t820 = load double, double* %l27
  %t821 = load %LexerState, %LexerState* %l0
  %t822 = extractvalue %LexerState %t821, 1
  %t823 = call i8* @slice(i8* %t819, double %t820, double %t822)
  store i8* %t823, i8** %l31
  %t824 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t825 = alloca %TokenKind
  %t826 = getelementptr inbounds %TokenKind, %TokenKind* %t825, i32 0, i32 0
  store i32 1, i32* %t826
  %t827 = load i8*, i8** %l31
  %t828 = getelementptr inbounds %TokenKind, %TokenKind* %t825, i32 0, i32 1
  %t829 = bitcast [8 x i8]* %t828 to i8*
  %t830 = bitcast i8* %t829 to i8**
  store i8* %t827, i8** %t830
  %t831 = load %TokenKind, %TokenKind* %t825
  %t832 = insertvalue %Token undef, %TokenKind %t831, 0
  %t833 = load i8*, i8** %l31
  %t834 = insertvalue %Token %t832, i8* %t833, 1
  %t835 = load double, double* %l28
  %t836 = insertvalue %Token %t834, double %t835, 2
  %t837 = load double, double* %l29
  %t838 = insertvalue %Token %t836, double %t837, 3
  %t839 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t824, %Token %t838)
  store { %Token*, i64 }* %t839, { %Token*, i64 }** %l1
  br label %loop.latch2
merge63:
  %t840 = load i8, i8* %l2
  %t841 = alloca [2 x i8], align 1
  %t842 = getelementptr [2 x i8], [2 x i8]* %t841, i32 0, i32 0
  store i8 %t840, i8* %t842
  %t843 = getelementptr [2 x i8], [2 x i8]* %t841, i32 0, i32 1
  store i8 0, i8* %t843
  %t844 = getelementptr [2 x i8], [2 x i8]* %t841, i32 0, i32 0
  %t845 = call i1 @is_identifier_start(i8* %t844)
  %t846 = load %LexerState, %LexerState* %l0
  %t847 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t848 = load i8, i8* %l2
  br i1 %t845, label %then84, label %merge85
then84:
  %t849 = load %LexerState, %LexerState* %l0
  %t850 = extractvalue %LexerState %t849, 1
  store double %t850, double* %l32
  %t851 = load %LexerState, %LexerState* %l0
  %t852 = extractvalue %LexerState %t851, 2
  store double %t852, double* %l33
  %t853 = load %LexerState, %LexerState* %l0
  %t854 = extractvalue %LexerState %t853, 3
  store double %t854, double* %l34
  %t855 = load %LexerState, %LexerState* %l0
  %t856 = extractvalue %LexerState %t855, 1
  %t857 = sitofp i64 1 to double
  %t858 = fadd double %t856, %t857
  %t859 = load %LexerState, %LexerState* %l0
  %t860 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t858, double* %t860
  %t861 = load %LexerState, %LexerState* %l0
  %t862 = extractvalue %LexerState %t861, 3
  %t863 = sitofp i64 1 to double
  %t864 = fadd double %t862, %t863
  %t865 = load %LexerState, %LexerState* %l0
  %t866 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t864, double* %t866
  %t867 = load %LexerState, %LexerState* %l0
  %t868 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t869 = load i8, i8* %l2
  %t870 = load double, double* %l32
  %t871 = load double, double* %l33
  %t872 = load double, double* %l34
  br label %loop.header86
loop.header86:
  br label %loop.body87
loop.body87:
  %t873 = load %LexerState, %LexerState* %l0
  %t874 = extractvalue %LexerState %t873, 1
  %t875 = load %LexerState, %LexerState* %l0
  %t876 = extractvalue %LexerState %t875, 0
  %t877 = call i64 @sailfin_runtime_string_length(i8* %t876)
  %t878 = sitofp i64 %t877 to double
  %t879 = fcmp oge double %t874, %t878
  %t880 = load %LexerState, %LexerState* %l0
  %t881 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t882 = load i8, i8* %l2
  %t883 = load double, double* %l32
  %t884 = load double, double* %l33
  %t885 = load double, double* %l34
  br i1 %t879, label %then90, label %merge91
then90:
  br label %afterloop89
merge91:
  %t886 = load %LexerState, %LexerState* %l0
  %t887 = extractvalue %LexerState %t886, 0
  %t888 = load %LexerState, %LexerState* %l0
  %t889 = extractvalue %LexerState %t888, 1
  %t890 = fptosi double %t889 to i64
  %t891 = getelementptr i8, i8* %t887, i64 %t890
  %t892 = load i8, i8* %t891
  %t893 = alloca [2 x i8], align 1
  %t894 = getelementptr [2 x i8], [2 x i8]* %t893, i32 0, i32 0
  store i8 %t892, i8* %t894
  %t895 = getelementptr [2 x i8], [2 x i8]* %t893, i32 0, i32 1
  store i8 0, i8* %t895
  %t896 = getelementptr [2 x i8], [2 x i8]* %t893, i32 0, i32 0
  %t897 = call i1 @is_identifier_part(i8* %t896)
  %t898 = xor i1 %t897, 1
  %t899 = load %LexerState, %LexerState* %l0
  %t900 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t901 = load i8, i8* %l2
  %t902 = load double, double* %l32
  %t903 = load double, double* %l33
  %t904 = load double, double* %l34
  br i1 %t898, label %then92, label %merge93
then92:
  br label %afterloop89
merge93:
  %t905 = load %LexerState, %LexerState* %l0
  %t906 = extractvalue %LexerState %t905, 1
  %t907 = sitofp i64 1 to double
  %t908 = fadd double %t906, %t907
  %t909 = load %LexerState, %LexerState* %l0
  %t910 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t908, double* %t910
  %t911 = load %LexerState, %LexerState* %l0
  %t912 = extractvalue %LexerState %t911, 3
  %t913 = sitofp i64 1 to double
  %t914 = fadd double %t912, %t913
  %t915 = load %LexerState, %LexerState* %l0
  %t916 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t914, double* %t916
  br label %loop.latch88
loop.latch88:
  br label %loop.header86
afterloop89:
  %t917 = load %LexerState, %LexerState* %l0
  %t918 = extractvalue %LexerState %t917, 0
  %t919 = load double, double* %l32
  %t920 = load %LexerState, %LexerState* %l0
  %t921 = extractvalue %LexerState %t920, 1
  %t922 = call i8* @slice(i8* %t918, double %t919, double %t921)
  store i8* %t922, i8** %l35
  %t924 = load i8*, i8** %l35
  %s925 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h275946731, i32 0, i32 0
  %t926 = icmp eq i8* %t924, %s925
  br label %logical_or_entry_923

logical_or_entry_923:
  br i1 %t926, label %logical_or_merge_923, label %logical_or_right_923

logical_or_right_923:
  %t927 = load i8*, i8** %l35
  %s928 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2095430042, i32 0, i32 0
  %t929 = icmp eq i8* %t927, %s928
  br label %logical_or_right_end_923

logical_or_right_end_923:
  br label %logical_or_merge_923

logical_or_merge_923:
  %t930 = phi i1 [ true, %logical_or_entry_923 ], [ %t929, %logical_or_right_end_923 ]
  %t931 = load %LexerState, %LexerState* %l0
  %t932 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t933 = load i8, i8* %l2
  %t934 = load double, double* %l32
  %t935 = load double, double* %l33
  %t936 = load double, double* %l34
  %t937 = load i8*, i8** %l35
  br i1 %t930, label %then94, label %else95
then94:
  %t938 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t939 = alloca %TokenKind
  %t940 = getelementptr inbounds %TokenKind, %TokenKind* %t939, i32 0, i32 0
  store i32 3, i32* %t940
  %t941 = load i8*, i8** %l35
  %t942 = getelementptr inbounds %TokenKind, %TokenKind* %t939, i32 0, i32 1
  %t943 = bitcast [8 x i8]* %t942 to i8*
  %t944 = bitcast i8* %t943 to i8**
  store i8* %t941, i8** %t944
  %t945 = load %TokenKind, %TokenKind* %t939
  %t946 = insertvalue %Token undef, %TokenKind %t945, 0
  %t947 = load i8*, i8** %l35
  %t948 = insertvalue %Token %t946, i8* %t947, 1
  %t949 = load double, double* %l33
  %t950 = insertvalue %Token %t948, double %t949, 2
  %t951 = load double, double* %l34
  %t952 = insertvalue %Token %t950, double %t951, 3
  %t953 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t938, %Token %t952)
  store { %Token*, i64 }* %t953, { %Token*, i64 }** %l1
  %t954 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br label %merge96
else95:
  %t955 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t956 = alloca %TokenKind
  %t957 = getelementptr inbounds %TokenKind, %TokenKind* %t956, i32 0, i32 0
  store i32 0, i32* %t957
  %t958 = load i8*, i8** %l35
  %t959 = getelementptr inbounds %TokenKind, %TokenKind* %t956, i32 0, i32 1
  %t960 = bitcast [8 x i8]* %t959 to i8*
  %t961 = bitcast i8* %t960 to i8**
  store i8* %t958, i8** %t961
  %t962 = load %TokenKind, %TokenKind* %t956
  %t963 = insertvalue %Token undef, %TokenKind %t962, 0
  %t964 = load i8*, i8** %l35
  %t965 = insertvalue %Token %t963, i8* %t964, 1
  %t966 = load double, double* %l33
  %t967 = insertvalue %Token %t965, double %t966, 2
  %t968 = load double, double* %l34
  %t969 = insertvalue %Token %t967, double %t968, 3
  %t970 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t955, %Token %t969)
  store { %Token*, i64 }* %t970, { %Token*, i64 }** %l1
  %t971 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br label %merge96
merge96:
  %t972 = phi { %Token*, i64 }* [ %t954, %then94 ], [ %t971, %else95 ]
  store { %Token*, i64 }* %t972, { %Token*, i64 }** %l1
  br label %loop.latch2
merge85:
  %t973 = load %LexerState, %LexerState* %l0
  %t974 = extractvalue %LexerState %t973, 2
  store double %t974, double* %l36
  %t975 = load %LexerState, %LexerState* %l0
  %t976 = extractvalue %LexerState %t975, 3
  store double %t976, double* %l37
  %t977 = load i8, i8* %l2
  store i8 %t977, i8* %l38
  %t978 = load %LexerState, %LexerState* %l0
  %t979 = call i8* @peek_next_char(%LexerState %t978)
  store i8* %t979, i8** %l39
  %t980 = load i8*, i8** %l39
  %s981 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t982 = icmp ne i8* %t980, %s981
  %t983 = load %LexerState, %LexerState* %l0
  %t984 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t985 = load i8, i8* %l2
  %t986 = load double, double* %l36
  %t987 = load double, double* %l37
  %t988 = load i8, i8* %l38
  %t989 = load i8*, i8** %l39
  br i1 %t982, label %then97, label %merge98
then97:
  %t990 = load i8, i8* %l2
  %t991 = load i8*, i8** %l39
  %t992 = load i8, i8* %t991
  %t993 = add i8 %t990, %t992
  store i8 %t993, i8* %l40
  %t994 = load i8, i8* %l40
  %t995 = alloca [2 x i8], align 1
  %t996 = getelementptr [2 x i8], [2 x i8]* %t995, i32 0, i32 0
  store i8 %t994, i8* %t996
  %t997 = getelementptr [2 x i8], [2 x i8]* %t995, i32 0, i32 1
  store i8 0, i8* %t997
  %t998 = getelementptr [2 x i8], [2 x i8]* %t995, i32 0, i32 0
  %t999 = call i1 @is_two_char_symbol(i8* %t998)
  %t1000 = load %LexerState, %LexerState* %l0
  %t1001 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t1002 = load i8, i8* %l2
  %t1003 = load double, double* %l36
  %t1004 = load double, double* %l37
  %t1005 = load i8, i8* %l38
  %t1006 = load i8*, i8** %l39
  %t1007 = load i8, i8* %l40
  br i1 %t999, label %then99, label %merge100
then99:
  %t1008 = load i8, i8* %l40
  store i8 %t1008, i8* %l38
  %t1009 = load %LexerState, %LexerState* %l0
  %t1010 = extractvalue %LexerState %t1009, 1
  %t1011 = sitofp i64 2 to double
  %t1012 = fadd double %t1010, %t1011
  %t1013 = load %LexerState, %LexerState* %l0
  %t1014 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t1012, double* %t1014
  %t1015 = load %LexerState, %LexerState* %l0
  %t1016 = extractvalue %LexerState %t1015, 3
  %t1017 = sitofp i64 2 to double
  %t1018 = fadd double %t1016, %t1017
  %t1019 = load %LexerState, %LexerState* %l0
  %t1020 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t1018, double* %t1020
  %t1021 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t1022 = alloca %TokenKind
  %t1023 = getelementptr inbounds %TokenKind, %TokenKind* %t1022, i32 0, i32 0
  store i32 4, i32* %t1023
  %t1024 = load i8, i8* %l38
  %t1025 = call noalias i8* @malloc(i64 1)
  %t1026 = bitcast i8* %t1025 to i8*
  store i8 %t1024, i8* %t1026
  %t1027 = getelementptr inbounds %TokenKind, %TokenKind* %t1022, i32 0, i32 1
  %t1028 = bitcast [8 x i8]* %t1027 to i8*
  %t1029 = bitcast i8* %t1028 to i8**
  store i8* %t1025, i8** %t1029
  %t1030 = load %TokenKind, %TokenKind* %t1022
  %t1031 = insertvalue %Token undef, %TokenKind %t1030, 0
  %t1032 = load i8, i8* %l38
  %t1033 = alloca [2 x i8], align 1
  %t1034 = getelementptr [2 x i8], [2 x i8]* %t1033, i32 0, i32 0
  store i8 %t1032, i8* %t1034
  %t1035 = getelementptr [2 x i8], [2 x i8]* %t1033, i32 0, i32 1
  store i8 0, i8* %t1035
  %t1036 = getelementptr [2 x i8], [2 x i8]* %t1033, i32 0, i32 0
  %t1037 = insertvalue %Token %t1031, i8* %t1036, 1
  %t1038 = load double, double* %l36
  %t1039 = insertvalue %Token %t1037, double %t1038, 2
  %t1040 = load double, double* %l37
  %t1041 = insertvalue %Token %t1039, double %t1040, 3
  %t1042 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t1021, %Token %t1041)
  store { %Token*, i64 }* %t1042, { %Token*, i64 }** %l1
  br label %loop.latch2
merge100:
  %t1043 = load i8, i8* %l38
  %t1044 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br label %merge98
merge98:
  %t1045 = phi i8 [ %t1043, %merge100 ], [ %t988, %merge85 ]
  %t1046 = phi { %Token*, i64 }* [ %t1044, %merge100 ], [ %t984, %merge85 ]
  store i8 %t1045, i8* %l38
  store { %Token*, i64 }* %t1046, { %Token*, i64 }** %l1
  %t1047 = load %LexerState, %LexerState* %l0
  %t1048 = extractvalue %LexerState %t1047, 1
  %t1049 = sitofp i64 1 to double
  %t1050 = fadd double %t1048, %t1049
  %t1051 = load %LexerState, %LexerState* %l0
  %t1052 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t1050, double* %t1052
  %t1053 = load i8, i8* %l2
  %t1054 = icmp eq i8 %t1053, 10
  %t1055 = load %LexerState, %LexerState* %l0
  %t1056 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t1057 = load i8, i8* %l2
  %t1058 = load double, double* %l36
  %t1059 = load double, double* %l37
  %t1060 = load i8, i8* %l38
  %t1061 = load i8*, i8** %l39
  br i1 %t1054, label %then101, label %else102
then101:
  %t1062 = load %LexerState, %LexerState* %l0
  %t1063 = extractvalue %LexerState %t1062, 2
  %t1064 = sitofp i64 1 to double
  %t1065 = fadd double %t1063, %t1064
  %t1066 = load %LexerState, %LexerState* %l0
  %t1067 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 2
  store double %t1065, double* %t1067
  %t1068 = load %LexerState, %LexerState* %l0
  %t1069 = sitofp i64 1 to double
  %t1070 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t1069, double* %t1070
  br label %merge103
else102:
  %t1071 = load %LexerState, %LexerState* %l0
  %t1072 = extractvalue %LexerState %t1071, 3
  %t1073 = sitofp i64 1 to double
  %t1074 = fadd double %t1072, %t1073
  %t1075 = load %LexerState, %LexerState* %l0
  %t1076 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t1074, double* %t1076
  br label %merge103
merge103:
  %t1077 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t1078 = alloca %TokenKind
  %t1079 = getelementptr inbounds %TokenKind, %TokenKind* %t1078, i32 0, i32 0
  store i32 4, i32* %t1079
  %t1080 = load i8, i8* %l38
  %t1081 = call noalias i8* @malloc(i64 1)
  %t1082 = bitcast i8* %t1081 to i8*
  store i8 %t1080, i8* %t1082
  %t1083 = getelementptr inbounds %TokenKind, %TokenKind* %t1078, i32 0, i32 1
  %t1084 = bitcast [8 x i8]* %t1083 to i8*
  %t1085 = bitcast i8* %t1084 to i8**
  store i8* %t1081, i8** %t1085
  %t1086 = load %TokenKind, %TokenKind* %t1078
  %t1087 = insertvalue %Token undef, %TokenKind %t1086, 0
  %t1088 = load i8, i8* %l38
  %t1089 = alloca [2 x i8], align 1
  %t1090 = getelementptr [2 x i8], [2 x i8]* %t1089, i32 0, i32 0
  store i8 %t1088, i8* %t1090
  %t1091 = getelementptr [2 x i8], [2 x i8]* %t1089, i32 0, i32 1
  store i8 0, i8* %t1091
  %t1092 = getelementptr [2 x i8], [2 x i8]* %t1089, i32 0, i32 0
  %t1093 = insertvalue %Token %t1087, i8* %t1092, 1
  %t1094 = load double, double* %l36
  %t1095 = insertvalue %Token %t1093, double %t1094, 2
  %t1096 = load double, double* %l37
  %t1097 = insertvalue %Token %t1095, double %t1096, 3
  %t1098 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t1077, %Token %t1097)
  store { %Token*, i64 }* %t1098, { %Token*, i64 }** %l1
  br label %loop.latch2
loop.latch2:
  %t1099 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br label %loop.header0
afterloop3:
  %t1101 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t1102 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t1103 = load %LexerState, %LexerState* %l0
  %t1104 = extractvalue %LexerState %t1103, 2
  %t1105 = load %LexerState, %LexerState* %l0
  %t1106 = extractvalue %LexerState %t1105, 3
  %t1107 = call %Token @eof_token(double %t1104, double %t1106)
  %t1108 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t1102, %Token %t1107)
  store { %Token*, i64 }* %t1108, { %Token*, i64 }** %l1
  %t1109 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  ret { %Token*, i64 }* %t1109
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
