; ModuleID = 'sailfin'
source_filename = "sailfin"

%LexerState = type { i8*, double, double, double }
%Token = type { %TokenKind, i8*, double, double }

%TokenKind = type { i32, [8 x i8] }

declare void @sailfin_runtime_bounds_check(i64, i64)
declare i8* @sailfin_runtime_substring(i8*, i64, i64)
declare i64 @sailfin_runtime_string_length(i8*)
declare i8* @sailfin_runtime_string_concat(i8*, i8*)
declare i1 @strings_equal(i8*, i8*)
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

define { %Token*, i64 }* @lex(i8* %source) {
block.entry:
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
  %l40 = alloca i8*
  %t0 = insertvalue %LexerState undef, i8* %source, 0
  %t1 = sitofp i64 0 to double
  %t2 = insertvalue %LexerState %t0, double %t1, 1
  %t3 = sitofp i64 1 to double
  %t4 = insertvalue %LexerState %t2, double %t3, 2
  %t5 = sitofp i64 1 to double
  %t6 = insertvalue %LexerState %t4, double %t5, 3
  store %LexerState %t6, %LexerState* %l0
  %t7 = getelementptr [0 x %Token], [0 x %Token]* null, i32 1
  %t8 = ptrtoint [0 x %Token]* %t7 to i64
  %t9 = icmp eq i64 %t8, 0
  %t10 = select i1 %t9, i64 1, i64 %t8
  %t11 = call i8* @malloc(i64 %t10)
  %t12 = bitcast i8* %t11 to %Token*
  %t13 = getelementptr { %Token*, i64 }, { %Token*, i64 }* null, i32 1
  %t14 = ptrtoint { %Token*, i64 }* %t13 to i64
  %t15 = call i8* @malloc(i64 %t14)
  %t16 = bitcast i8* %t15 to { %Token*, i64 }*
  %t17 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t16, i32 0, i32 0
  store %Token* %t12, %Token** %t17
  %t18 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t16, i32 0, i32 1
  store i64 0, i64* %t18
  store { %Token*, i64 }* %t16, { %Token*, i64 }** %l1
  %t19 = load %LexerState, %LexerState* %l0
  %t20 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br label %loop.header0
loop.header0:
  %t1188 = phi { %Token*, i64 }* [ %t20, %block.entry ], [ %t1187, %loop.latch2 ]
  store { %Token*, i64 }* %t1188, { %Token*, i64 }** %l1
  br label %loop.body1
loop.body1:
  %t21 = load %LexerState, %LexerState* %l0
  %t22 = extractvalue %LexerState %t21, 1
  %t23 = load %LexerState, %LexerState* %l0
  %t24 = extractvalue %LexerState %t23, 0
  %t25 = call i64 @sailfin_runtime_string_length(i8* %t24)
  %t26 = sitofp i64 %t25 to double
  %t27 = fcmp oge double %t22, %t26
  %t28 = load %LexerState, %LexerState* %l0
  %t29 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br i1 %t27, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t30 = load %LexerState, %LexerState* %l0
  %t31 = extractvalue %LexerState %t30, 0
  %t32 = load %LexerState, %LexerState* %l0
  %t33 = extractvalue %LexerState %t32, 1
  %t34 = fptosi double %t33 to i64
  %t35 = getelementptr i8, i8* %t31, i64 %t34
  %t36 = load i8, i8* %t35
  store i8 %t36, i8* %l2
  %t37 = load i8, i8* %l2
  %t38 = alloca [2 x i8], align 1
  %t39 = getelementptr [2 x i8], [2 x i8]* %t38, i32 0, i32 0
  store i8 %t37, i8* %t39
  %t40 = getelementptr [2 x i8], [2 x i8]* %t38, i32 0, i32 1
  store i8 0, i8* %t40
  %t41 = getelementptr [2 x i8], [2 x i8]* %t38, i32 0, i32 0
  %t42 = call i1 @is_whitespace(i8* %t41)
  %t43 = load %LexerState, %LexerState* %l0
  %t44 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t45 = load i8, i8* %l2
  br i1 %t42, label %then6, label %merge7
then6:
  %t46 = load %LexerState, %LexerState* %l0
  %t47 = extractvalue %LexerState %t46, 1
  store double %t47, double* %l3
  %t48 = load %LexerState, %LexerState* %l0
  %t49 = extractvalue %LexerState %t48, 2
  store double %t49, double* %l4
  %t50 = load %LexerState, %LexerState* %l0
  %t51 = extractvalue %LexerState %t50, 3
  store double %t51, double* %l5
  %t52 = load %LexerState, %LexerState* %l0
  %t53 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t54 = load i8, i8* %l2
  %t55 = load double, double* %l3
  %t56 = load double, double* %l4
  %t57 = load double, double* %l5
  br label %loop.header8
loop.header8:
  br label %loop.body9
loop.body9:
  %t58 = load %LexerState, %LexerState* %l0
  %t59 = extractvalue %LexerState %t58, 1
  %t60 = load %LexerState, %LexerState* %l0
  %t61 = extractvalue %LexerState %t60, 0
  %t62 = call i64 @sailfin_runtime_string_length(i8* %t61)
  %t63 = sitofp i64 %t62 to double
  %t64 = fcmp oge double %t59, %t63
  %t65 = load %LexerState, %LexerState* %l0
  %t66 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t67 = load i8, i8* %l2
  %t68 = load double, double* %l3
  %t69 = load double, double* %l4
  %t70 = load double, double* %l5
  br i1 %t64, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t71 = load %LexerState, %LexerState* %l0
  %t72 = extractvalue %LexerState %t71, 0
  %t73 = load %LexerState, %LexerState* %l0
  %t74 = extractvalue %LexerState %t73, 1
  %t75 = fptosi double %t74 to i64
  %t76 = getelementptr i8, i8* %t72, i64 %t75
  %t77 = load i8, i8* %t76
  %t78 = alloca [2 x i8], align 1
  %t79 = getelementptr [2 x i8], [2 x i8]* %t78, i32 0, i32 0
  store i8 %t77, i8* %t79
  %t80 = getelementptr [2 x i8], [2 x i8]* %t78, i32 0, i32 1
  store i8 0, i8* %t80
  %t81 = getelementptr [2 x i8], [2 x i8]* %t78, i32 0, i32 0
  %t82 = call i1 @is_whitespace(i8* %t81)
  %t83 = xor i1 %t82, 1
  %t84 = load %LexerState, %LexerState* %l0
  %t85 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t86 = load i8, i8* %l2
  %t87 = load double, double* %l3
  %t88 = load double, double* %l4
  %t89 = load double, double* %l5
  br i1 %t83, label %then14, label %merge15
then14:
  br label %afterloop11
merge15:
  %t90 = load %LexerState, %LexerState* %l0
  %t91 = extractvalue %LexerState %t90, 0
  %t92 = load %LexerState, %LexerState* %l0
  %t93 = extractvalue %LexerState %t92, 1
  %t94 = fptosi double %t93 to i64
  %t95 = getelementptr i8, i8* %t91, i64 %t94
  %t96 = load i8, i8* %t95
  %t97 = alloca [2 x i8], align 1
  %t98 = getelementptr [2 x i8], [2 x i8]* %t97, i32 0, i32 0
  store i8 %t96, i8* %t98
  %t99 = getelementptr [2 x i8], [2 x i8]* %t97, i32 0, i32 1
  store i8 0, i8* %t99
  %t100 = getelementptr [2 x i8], [2 x i8]* %t97, i32 0, i32 0
  %t101 = alloca [2 x i8], align 1
  %t102 = getelementptr [2 x i8], [2 x i8]* %t101, i32 0, i32 0
  store i8 10, i8* %t102
  %t103 = getelementptr [2 x i8], [2 x i8]* %t101, i32 0, i32 1
  store i8 0, i8* %t103
  %t104 = getelementptr [2 x i8], [2 x i8]* %t101, i32 0, i32 0
  %t105 = call i1 @strings_equal(i8* %t100, i8* %t104)
  %t106 = load %LexerState, %LexerState* %l0
  %t107 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t108 = load i8, i8* %l2
  %t109 = load double, double* %l3
  %t110 = load double, double* %l4
  %t111 = load double, double* %l5
  br i1 %t105, label %then16, label %else17
then16:
  %t112 = load %LexerState, %LexerState* %l0
  %t113 = extractvalue %LexerState %t112, 1
  %t114 = sitofp i64 1 to double
  %t115 = fadd double %t113, %t114
  %t116 = load %LexerState, %LexerState* %l0
  %t117 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t115, double* %t117
  %t118 = load %LexerState, %LexerState* %l0
  %t119 = extractvalue %LexerState %t118, 2
  %t120 = sitofp i64 1 to double
  %t121 = fadd double %t119, %t120
  %t122 = load %LexerState, %LexerState* %l0
  %t123 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 2
  store double %t121, double* %t123
  %t124 = load %LexerState, %LexerState* %l0
  %t125 = sitofp i64 1 to double
  %t126 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t125, double* %t126
  br label %merge18
else17:
  %t127 = load %LexerState, %LexerState* %l0
  %t128 = extractvalue %LexerState %t127, 1
  %t129 = sitofp i64 1 to double
  %t130 = fadd double %t128, %t129
  %t131 = load %LexerState, %LexerState* %l0
  %t132 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t130, double* %t132
  %t133 = load %LexerState, %LexerState* %l0
  %t134 = extractvalue %LexerState %t133, 3
  %t135 = sitofp i64 1 to double
  %t136 = fadd double %t134, %t135
  %t137 = load %LexerState, %LexerState* %l0
  %t138 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t136, double* %t138
  br label %merge18
merge18:
  br label %loop.latch10
loop.latch10:
  br label %loop.header8
afterloop11:
  %t139 = load %LexerState, %LexerState* %l0
  %t140 = extractvalue %LexerState %t139, 0
  %t141 = load double, double* %l3
  %t142 = load %LexerState, %LexerState* %l0
  %t143 = extractvalue %LexerState %t142, 1
  %t144 = call i8* @slice(i8* %t140, double %t141, double %t143)
  store i8* %t144, i8** %l6
  %t145 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t146 = insertvalue %TokenKind undef, i32 5, 0
  %t147 = insertvalue %Token undef, %TokenKind %t146, 0
  %t148 = load i8*, i8** %l6
  %t149 = insertvalue %Token %t147, i8* %t148, 1
  %t150 = load double, double* %l4
  %t151 = insertvalue %Token %t149, double %t150, 2
  %t152 = load double, double* %l5
  %t153 = insertvalue %Token %t151, double %t152, 3
  %t154 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t145, %Token %t153)
  store { %Token*, i64 }* %t154, { %Token*, i64 }** %l1
  br label %loop.latch2
merge7:
  %t155 = load i8, i8* %l2
  %t156 = alloca [2 x i8], align 1
  %t157 = getelementptr [2 x i8], [2 x i8]* %t156, i32 0, i32 0
  store i8 %t155, i8* %t157
  %t158 = getelementptr [2 x i8], [2 x i8]* %t156, i32 0, i32 1
  store i8 0, i8* %t158
  %t159 = getelementptr [2 x i8], [2 x i8]* %t156, i32 0, i32 0
  %t160 = alloca [2 x i8], align 1
  %t161 = getelementptr [2 x i8], [2 x i8]* %t160, i32 0, i32 0
  store i8 47, i8* %t161
  %t162 = getelementptr [2 x i8], [2 x i8]* %t160, i32 0, i32 1
  store i8 0, i8* %t162
  %t163 = getelementptr [2 x i8], [2 x i8]* %t160, i32 0, i32 0
  %t164 = call i1 @strings_equal(i8* %t159, i8* %t163)
  %t165 = load %LexerState, %LexerState* %l0
  %t166 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t167 = load i8, i8* %l2
  br i1 %t164, label %then19, label %merge20
then19:
  %t168 = load %LexerState, %LexerState* %l0
  %t169 = call i8* @peek_next_char(%LexerState %t168)
  store i8* %t169, i8** %l7
  %t170 = load i8*, i8** %l7
  %t171 = alloca [2 x i8], align 1
  %t172 = getelementptr [2 x i8], [2 x i8]* %t171, i32 0, i32 0
  store i8 47, i8* %t172
  %t173 = getelementptr [2 x i8], [2 x i8]* %t171, i32 0, i32 1
  store i8 0, i8* %t173
  %t174 = getelementptr [2 x i8], [2 x i8]* %t171, i32 0, i32 0
  %t175 = call i1 @strings_equal(i8* %t170, i8* %t174)
  %t176 = load %LexerState, %LexerState* %l0
  %t177 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t178 = load i8, i8* %l2
  %t179 = load i8*, i8** %l7
  br i1 %t175, label %then21, label %merge22
then21:
  %t180 = load %LexerState, %LexerState* %l0
  %t181 = extractvalue %LexerState %t180, 1
  store double %t181, double* %l8
  %t182 = load %LexerState, %LexerState* %l0
  %t183 = extractvalue %LexerState %t182, 2
  store double %t183, double* %l9
  %t184 = load %LexerState, %LexerState* %l0
  %t185 = extractvalue %LexerState %t184, 3
  store double %t185, double* %l10
  %t186 = load %LexerState, %LexerState* %l0
  %t187 = extractvalue %LexerState %t186, 1
  %t188 = sitofp i64 2 to double
  %t189 = fadd double %t187, %t188
  %t190 = load %LexerState, %LexerState* %l0
  %t191 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t189, double* %t191
  %t192 = load %LexerState, %LexerState* %l0
  %t193 = extractvalue %LexerState %t192, 3
  %t194 = sitofp i64 2 to double
  %t195 = fadd double %t193, %t194
  %t196 = load %LexerState, %LexerState* %l0
  %t197 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t195, double* %t197
  %t198 = load %LexerState, %LexerState* %l0
  %t199 = extractvalue %LexerState %t198, 0
  %t200 = call i64 @sailfin_runtime_string_length(i8* %t199)
  %t201 = sitofp i64 %t200 to double
  store double %t201, double* %l11
  %t202 = load %LexerState, %LexerState* %l0
  %t203 = extractvalue %LexerState %t202, 1
  store double %t203, double* %l12
  %t204 = load %LexerState, %LexerState* %l0
  %t205 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t206 = load i8, i8* %l2
  %t207 = load i8*, i8** %l7
  %t208 = load double, double* %l8
  %t209 = load double, double* %l9
  %t210 = load double, double* %l10
  %t211 = load double, double* %l11
  %t212 = load double, double* %l12
  br label %loop.header23
loop.header23:
  %t272 = phi double [ %t211, %then21 ], [ %t270, %loop.latch25 ]
  %t273 = phi double [ %t212, %then21 ], [ %t271, %loop.latch25 ]
  store double %t272, double* %l11
  store double %t273, double* %l12
  br label %loop.body24
loop.body24:
  %t213 = load double, double* %l12
  %t214 = load %LexerState, %LexerState* %l0
  %t215 = extractvalue %LexerState %t214, 0
  %t216 = call i64 @sailfin_runtime_string_length(i8* %t215)
  %t217 = sitofp i64 %t216 to double
  %t218 = fcmp oge double %t213, %t217
  %t219 = load %LexerState, %LexerState* %l0
  %t220 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t221 = load i8, i8* %l2
  %t222 = load i8*, i8** %l7
  %t223 = load double, double* %l8
  %t224 = load double, double* %l9
  %t225 = load double, double* %l10
  %t226 = load double, double* %l11
  %t227 = load double, double* %l12
  br i1 %t218, label %then27, label %merge28
then27:
  br label %afterloop26
merge28:
  %t228 = load %LexerState, %LexerState* %l0
  %t229 = extractvalue %LexerState %t228, 0
  %t230 = load double, double* %l12
  %t231 = fptosi double %t230 to i64
  %t232 = getelementptr i8, i8* %t229, i64 %t231
  %t233 = load i8, i8* %t232
  store i8 %t233, i8* %l13
  %t235 = load i8, i8* %l13
  %t236 = alloca [2 x i8], align 1
  %t237 = getelementptr [2 x i8], [2 x i8]* %t236, i32 0, i32 0
  store i8 %t235, i8* %t237
  %t238 = getelementptr [2 x i8], [2 x i8]* %t236, i32 0, i32 1
  store i8 0, i8* %t238
  %t239 = getelementptr [2 x i8], [2 x i8]* %t236, i32 0, i32 0
  %t240 = alloca [2 x i8], align 1
  %t241 = getelementptr [2 x i8], [2 x i8]* %t240, i32 0, i32 0
  store i8 10, i8* %t241
  %t242 = getelementptr [2 x i8], [2 x i8]* %t240, i32 0, i32 1
  store i8 0, i8* %t242
  %t243 = getelementptr [2 x i8], [2 x i8]* %t240, i32 0, i32 0
  %t244 = call i1 @strings_equal(i8* %t239, i8* %t243)
  br label %logical_or_entry_234

logical_or_entry_234:
  br i1 %t244, label %logical_or_merge_234, label %logical_or_right_234

logical_or_right_234:
  %t245 = load i8, i8* %l13
  %t246 = alloca [2 x i8], align 1
  %t247 = getelementptr [2 x i8], [2 x i8]* %t246, i32 0, i32 0
  store i8 %t245, i8* %t247
  %t248 = getelementptr [2 x i8], [2 x i8]* %t246, i32 0, i32 1
  store i8 0, i8* %t248
  %t249 = getelementptr [2 x i8], [2 x i8]* %t246, i32 0, i32 0
  %t250 = alloca [2 x i8], align 1
  %t251 = getelementptr [2 x i8], [2 x i8]* %t250, i32 0, i32 0
  store i8 13, i8* %t251
  %t252 = getelementptr [2 x i8], [2 x i8]* %t250, i32 0, i32 1
  store i8 0, i8* %t252
  %t253 = getelementptr [2 x i8], [2 x i8]* %t250, i32 0, i32 0
  %t254 = call i1 @strings_equal(i8* %t249, i8* %t253)
  br label %logical_or_right_end_234

logical_or_right_end_234:
  br label %logical_or_merge_234

logical_or_merge_234:
  %t255 = phi i1 [ true, %logical_or_entry_234 ], [ %t254, %logical_or_right_end_234 ]
  %t256 = load %LexerState, %LexerState* %l0
  %t257 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t258 = load i8, i8* %l2
  %t259 = load i8*, i8** %l7
  %t260 = load double, double* %l8
  %t261 = load double, double* %l9
  %t262 = load double, double* %l10
  %t263 = load double, double* %l11
  %t264 = load double, double* %l12
  %t265 = load i8, i8* %l13
  br i1 %t255, label %then29, label %merge30
then29:
  %t266 = load double, double* %l12
  store double %t266, double* %l11
  br label %afterloop26
merge30:
  %t267 = load double, double* %l12
  %t268 = sitofp i64 1 to double
  %t269 = fadd double %t267, %t268
  store double %t269, double* %l12
  br label %loop.latch25
loop.latch25:
  %t270 = load double, double* %l11
  %t271 = load double, double* %l12
  br label %loop.header23
afterloop26:
  %t274 = load double, double* %l11
  %t275 = load double, double* %l12
  %t276 = load %LexerState, %LexerState* %l0
  %t277 = extractvalue %LexerState %t276, 0
  %t278 = load double, double* %l8
  %t279 = load double, double* %l11
  %t280 = call i8* @slice(i8* %t277, double %t278, double %t279)
  store i8* %t280, i8** %l14
  %t281 = load double, double* %l11
  %t282 = load %LexerState, %LexerState* %l0
  %t283 = extractvalue %LexerState %t282, 1
  %t284 = fsub double %t281, %t283
  store double %t284, double* %l15
  %t285 = load double, double* %l11
  %t286 = load %LexerState, %LexerState* %l0
  %t287 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t285, double* %t287
  %t288 = load %LexerState, %LexerState* %l0
  %t289 = extractvalue %LexerState %t288, 3
  %t290 = load double, double* %l15
  %t291 = fadd double %t289, %t290
  %t292 = load %LexerState, %LexerState* %l0
  %t293 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t291, double* %t293
  %t294 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t295 = insertvalue %TokenKind undef, i32 6, 0
  %t296 = insertvalue %Token undef, %TokenKind %t295, 0
  %t297 = load i8*, i8** %l14
  %t298 = insertvalue %Token %t296, i8* %t297, 1
  %t299 = load double, double* %l9
  %t300 = insertvalue %Token %t298, double %t299, 2
  %t301 = load double, double* %l10
  %t302 = insertvalue %Token %t300, double %t301, 3
  %t303 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t294, %Token %t302)
  store { %Token*, i64 }* %t303, { %Token*, i64 }** %l1
  br label %loop.latch2
merge22:
  %t304 = load i8*, i8** %l7
  %t305 = alloca [2 x i8], align 1
  %t306 = getelementptr [2 x i8], [2 x i8]* %t305, i32 0, i32 0
  store i8 42, i8* %t306
  %t307 = getelementptr [2 x i8], [2 x i8]* %t305, i32 0, i32 1
  store i8 0, i8* %t307
  %t308 = getelementptr [2 x i8], [2 x i8]* %t305, i32 0, i32 0
  %t309 = call i1 @strings_equal(i8* %t304, i8* %t308)
  %t310 = load %LexerState, %LexerState* %l0
  %t311 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t312 = load i8, i8* %l2
  %t313 = load i8*, i8** %l7
  br i1 %t309, label %then31, label %merge32
then31:
  %t314 = load %LexerState, %LexerState* %l0
  %t315 = extractvalue %LexerState %t314, 1
  store double %t315, double* %l16
  %t316 = load %LexerState, %LexerState* %l0
  %t317 = extractvalue %LexerState %t316, 2
  store double %t317, double* %l17
  %t318 = load %LexerState, %LexerState* %l0
  %t319 = extractvalue %LexerState %t318, 3
  store double %t319, double* %l18
  %t320 = load %LexerState, %LexerState* %l0
  %t321 = extractvalue %LexerState %t320, 1
  %t322 = sitofp i64 2 to double
  %t323 = fadd double %t321, %t322
  %t324 = load %LexerState, %LexerState* %l0
  %t325 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t323, double* %t325
  %t326 = load %LexerState, %LexerState* %l0
  %t327 = extractvalue %LexerState %t326, 3
  %t328 = sitofp i64 2 to double
  %t329 = fadd double %t327, %t328
  %t330 = load %LexerState, %LexerState* %l0
  %t331 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t329, double* %t331
  %t332 = load %LexerState, %LexerState* %l0
  %t333 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t334 = load i8, i8* %l2
  %t335 = load i8*, i8** %l7
  %t336 = load double, double* %l16
  %t337 = load double, double* %l17
  %t338 = load double, double* %l18
  br label %loop.header33
loop.header33:
  br label %loop.body34
loop.body34:
  %t339 = load %LexerState, %LexerState* %l0
  %t340 = extractvalue %LexerState %t339, 1
  %t341 = load %LexerState, %LexerState* %l0
  %t342 = extractvalue %LexerState %t341, 0
  %t343 = call i64 @sailfin_runtime_string_length(i8* %t342)
  %t344 = sitofp i64 %t343 to double
  %t345 = fcmp oge double %t340, %t344
  %t346 = load %LexerState, %LexerState* %l0
  %t347 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t348 = load i8, i8* %l2
  %t349 = load i8*, i8** %l7
  %t350 = load double, double* %l16
  %t351 = load double, double* %l17
  %t352 = load double, double* %l18
  br i1 %t345, label %then37, label %merge38
then37:
  br label %afterloop36
merge38:
  %t354 = load %LexerState, %LexerState* %l0
  %t355 = extractvalue %LexerState %t354, 0
  %t356 = load %LexerState, %LexerState* %l0
  %t357 = extractvalue %LexerState %t356, 1
  %t358 = fptosi double %t357 to i64
  %t359 = getelementptr i8, i8* %t355, i64 %t358
  %t360 = load i8, i8* %t359
  %t361 = alloca [2 x i8], align 1
  %t362 = getelementptr [2 x i8], [2 x i8]* %t361, i32 0, i32 0
  store i8 %t360, i8* %t362
  %t363 = getelementptr [2 x i8], [2 x i8]* %t361, i32 0, i32 1
  store i8 0, i8* %t363
  %t364 = getelementptr [2 x i8], [2 x i8]* %t361, i32 0, i32 0
  %t365 = alloca [2 x i8], align 1
  %t366 = getelementptr [2 x i8], [2 x i8]* %t365, i32 0, i32 0
  store i8 42, i8* %t366
  %t367 = getelementptr [2 x i8], [2 x i8]* %t365, i32 0, i32 1
  store i8 0, i8* %t367
  %t368 = getelementptr [2 x i8], [2 x i8]* %t365, i32 0, i32 0
  %t369 = call i1 @strings_equal(i8* %t364, i8* %t368)
  br label %logical_and_entry_353

logical_and_entry_353:
  br i1 %t369, label %logical_and_right_353, label %logical_and_merge_353

logical_and_right_353:
  %t370 = load %LexerState, %LexerState* %l0
  %t371 = call i8* @peek_next_char(%LexerState %t370)
  %t372 = alloca [2 x i8], align 1
  %t373 = getelementptr [2 x i8], [2 x i8]* %t372, i32 0, i32 0
  store i8 47, i8* %t373
  %t374 = getelementptr [2 x i8], [2 x i8]* %t372, i32 0, i32 1
  store i8 0, i8* %t374
  %t375 = getelementptr [2 x i8], [2 x i8]* %t372, i32 0, i32 0
  %t376 = call i1 @strings_equal(i8* %t371, i8* %t375)
  br label %logical_and_right_end_353

logical_and_right_end_353:
  br label %logical_and_merge_353

logical_and_merge_353:
  %t377 = phi i1 [ false, %logical_and_entry_353 ], [ %t376, %logical_and_right_end_353 ]
  %t378 = load %LexerState, %LexerState* %l0
  %t379 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t380 = load i8, i8* %l2
  %t381 = load i8*, i8** %l7
  %t382 = load double, double* %l16
  %t383 = load double, double* %l17
  %t384 = load double, double* %l18
  br i1 %t377, label %then39, label %merge40
then39:
  %t385 = load %LexerState, %LexerState* %l0
  %t386 = extractvalue %LexerState %t385, 1
  %t387 = sitofp i64 2 to double
  %t388 = fadd double %t386, %t387
  %t389 = load %LexerState, %LexerState* %l0
  %t390 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t388, double* %t390
  %t391 = load %LexerState, %LexerState* %l0
  %t392 = extractvalue %LexerState %t391, 3
  %t393 = sitofp i64 2 to double
  %t394 = fadd double %t392, %t393
  %t395 = load %LexerState, %LexerState* %l0
  %t396 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t394, double* %t396
  br label %afterloop36
merge40:
  %t397 = load %LexerState, %LexerState* %l0
  %t398 = extractvalue %LexerState %t397, 0
  %t399 = load %LexerState, %LexerState* %l0
  %t400 = extractvalue %LexerState %t399, 1
  %t401 = fptosi double %t400 to i64
  %t402 = getelementptr i8, i8* %t398, i64 %t401
  %t403 = load i8, i8* %t402
  %t404 = alloca [2 x i8], align 1
  %t405 = getelementptr [2 x i8], [2 x i8]* %t404, i32 0, i32 0
  store i8 %t403, i8* %t405
  %t406 = getelementptr [2 x i8], [2 x i8]* %t404, i32 0, i32 1
  store i8 0, i8* %t406
  %t407 = getelementptr [2 x i8], [2 x i8]* %t404, i32 0, i32 0
  %t408 = alloca [2 x i8], align 1
  %t409 = getelementptr [2 x i8], [2 x i8]* %t408, i32 0, i32 0
  store i8 10, i8* %t409
  %t410 = getelementptr [2 x i8], [2 x i8]* %t408, i32 0, i32 1
  store i8 0, i8* %t410
  %t411 = getelementptr [2 x i8], [2 x i8]* %t408, i32 0, i32 0
  %t412 = call i1 @strings_equal(i8* %t407, i8* %t411)
  %t413 = load %LexerState, %LexerState* %l0
  %t414 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t415 = load i8, i8* %l2
  %t416 = load i8*, i8** %l7
  %t417 = load double, double* %l16
  %t418 = load double, double* %l17
  %t419 = load double, double* %l18
  br i1 %t412, label %then41, label %else42
then41:
  %t420 = load %LexerState, %LexerState* %l0
  %t421 = extractvalue %LexerState %t420, 1
  %t422 = sitofp i64 1 to double
  %t423 = fadd double %t421, %t422
  %t424 = load %LexerState, %LexerState* %l0
  %t425 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t423, double* %t425
  %t426 = load %LexerState, %LexerState* %l0
  %t427 = extractvalue %LexerState %t426, 2
  %t428 = sitofp i64 1 to double
  %t429 = fadd double %t427, %t428
  %t430 = load %LexerState, %LexerState* %l0
  %t431 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 2
  store double %t429, double* %t431
  %t432 = load %LexerState, %LexerState* %l0
  %t433 = sitofp i64 1 to double
  %t434 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t433, double* %t434
  br label %merge43
else42:
  %t435 = load %LexerState, %LexerState* %l0
  %t436 = extractvalue %LexerState %t435, 1
  %t437 = sitofp i64 1 to double
  %t438 = fadd double %t436, %t437
  %t439 = load %LexerState, %LexerState* %l0
  %t440 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t438, double* %t440
  %t441 = load %LexerState, %LexerState* %l0
  %t442 = extractvalue %LexerState %t441, 3
  %t443 = sitofp i64 1 to double
  %t444 = fadd double %t442, %t443
  %t445 = load %LexerState, %LexerState* %l0
  %t446 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t444, double* %t446
  br label %merge43
merge43:
  br label %loop.latch35
loop.latch35:
  br label %loop.header33
afterloop36:
  %t447 = load %LexerState, %LexerState* %l0
  %t448 = extractvalue %LexerState %t447, 0
  %t449 = load double, double* %l16
  %t450 = load %LexerState, %LexerState* %l0
  %t451 = extractvalue %LexerState %t450, 1
  %t452 = call i8* @slice(i8* %t448, double %t449, double %t451)
  store i8* %t452, i8** %l19
  %t453 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t454 = insertvalue %TokenKind undef, i32 6, 0
  %t455 = insertvalue %Token undef, %TokenKind %t454, 0
  %t456 = load i8*, i8** %l19
  %t457 = insertvalue %Token %t455, i8* %t456, 1
  %t458 = load double, double* %l17
  %t459 = insertvalue %Token %t457, double %t458, 2
  %t460 = load double, double* %l18
  %t461 = insertvalue %Token %t459, double %t460, 3
  %t462 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t453, %Token %t461)
  store { %Token*, i64 }* %t462, { %Token*, i64 }** %l1
  br label %loop.latch2
merge32:
  %t463 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t464 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br label %merge20
merge20:
  %t465 = phi { %Token*, i64 }* [ %t463, %merge32 ], [ %t166, %merge7 ]
  %t466 = phi { %Token*, i64 }* [ %t464, %merge32 ], [ %t166, %merge7 ]
  store { %Token*, i64 }* %t465, { %Token*, i64 }** %l1
  store { %Token*, i64 }* %t466, { %Token*, i64 }** %l1
  %t467 = load i8, i8* %l2
  %t468 = alloca [2 x i8], align 1
  %t469 = getelementptr [2 x i8], [2 x i8]* %t468, i32 0, i32 0
  store i8 %t467, i8* %t469
  %t470 = getelementptr [2 x i8], [2 x i8]* %t468, i32 0, i32 1
  store i8 0, i8* %t470
  %t471 = getelementptr [2 x i8], [2 x i8]* %t468, i32 0, i32 0
  %t472 = call i1 @is_double_quote(i8* %t471)
  %t473 = load %LexerState, %LexerState* %l0
  %t474 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t475 = load i8, i8* %l2
  br i1 %t472, label %then44, label %merge45
then44:
  %t476 = load %LexerState, %LexerState* %l0
  %t477 = extractvalue %LexerState %t476, 1
  store double %t477, double* %l20
  %t478 = load %LexerState, %LexerState* %l0
  %t479 = extractvalue %LexerState %t478, 2
  store double %t479, double* %l21
  %t480 = load %LexerState, %LexerState* %l0
  %t481 = extractvalue %LexerState %t480, 3
  store double %t481, double* %l22
  %t482 = load %LexerState, %LexerState* %l0
  %t483 = extractvalue %LexerState %t482, 1
  %t484 = sitofp i64 1 to double
  %t485 = fadd double %t483, %t484
  %t486 = load %LexerState, %LexerState* %l0
  %t487 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t485, double* %t487
  %t488 = load %LexerState, %LexerState* %l0
  %t489 = extractvalue %LexerState %t488, 3
  %t490 = sitofp i64 1 to double
  %t491 = fadd double %t489, %t490
  %t492 = load %LexerState, %LexerState* %l0
  %t493 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t491, double* %t493
  %s494 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s494, i8** %l23
  store i1 0, i1* %l24
  %t495 = load %LexerState, %LexerState* %l0
  %t496 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t497 = load i8, i8* %l2
  %t498 = load double, double* %l20
  %t499 = load double, double* %l21
  %t500 = load double, double* %l22
  %t501 = load i8*, i8** %l23
  %t502 = load i1, i1* %l24
  br label %loop.header46
loop.header46:
  %t665 = phi i1 [ %t502, %then44 ], [ %t663, %loop.latch48 ]
  %t666 = phi i8* [ %t501, %then44 ], [ %t664, %loop.latch48 ]
  store i1 %t665, i1* %l24
  store i8* %t666, i8** %l23
  br label %loop.body47
loop.body47:
  %t503 = load %LexerState, %LexerState* %l0
  %t504 = extractvalue %LexerState %t503, 1
  %t505 = load %LexerState, %LexerState* %l0
  %t506 = extractvalue %LexerState %t505, 0
  %t507 = call i64 @sailfin_runtime_string_length(i8* %t506)
  %t508 = sitofp i64 %t507 to double
  %t509 = fcmp oge double %t504, %t508
  %t510 = load %LexerState, %LexerState* %l0
  %t511 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t512 = load i8, i8* %l2
  %t513 = load double, double* %l20
  %t514 = load double, double* %l21
  %t515 = load double, double* %l22
  %t516 = load i8*, i8** %l23
  %t517 = load i1, i1* %l24
  br i1 %t509, label %then50, label %merge51
then50:
  br label %afterloop49
merge51:
  %t518 = load %LexerState, %LexerState* %l0
  %t519 = extractvalue %LexerState %t518, 0
  %t520 = load %LexerState, %LexerState* %l0
  %t521 = extractvalue %LexerState %t520, 1
  %t522 = fptosi double %t521 to i64
  %t523 = getelementptr i8, i8* %t519, i64 %t522
  %t524 = load i8, i8* %t523
  store i8 %t524, i8* %l25
  %t526 = load i1, i1* %l24
  br label %logical_and_entry_525

logical_and_entry_525:
  br i1 %t526, label %logical_and_right_525, label %logical_and_merge_525

logical_and_right_525:
  %t527 = load i8, i8* %l25
  %t528 = alloca [2 x i8], align 1
  %t529 = getelementptr [2 x i8], [2 x i8]* %t528, i32 0, i32 0
  store i8 %t527, i8* %t529
  %t530 = getelementptr [2 x i8], [2 x i8]* %t528, i32 0, i32 1
  store i8 0, i8* %t530
  %t531 = getelementptr [2 x i8], [2 x i8]* %t528, i32 0, i32 0
  %t532 = call i1 @is_double_quote(i8* %t531)
  br label %logical_and_right_end_525

logical_and_right_end_525:
  br label %logical_and_merge_525

logical_and_merge_525:
  %t533 = phi i1 [ false, %logical_and_entry_525 ], [ %t532, %logical_and_right_end_525 ]
  %t534 = xor i1 %t533, 1
  %t535 = load %LexerState, %LexerState* %l0
  %t536 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t537 = load i8, i8* %l2
  %t538 = load double, double* %l20
  %t539 = load double, double* %l21
  %t540 = load double, double* %l22
  %t541 = load i8*, i8** %l23
  %t542 = load i1, i1* %l24
  %t543 = load i8, i8* %l25
  br i1 %t534, label %then52, label %merge53
then52:
  %t544 = load %LexerState, %LexerState* %l0
  %t545 = extractvalue %LexerState %t544, 1
  %t546 = sitofp i64 1 to double
  %t547 = fadd double %t545, %t546
  %t548 = load %LexerState, %LexerState* %l0
  %t549 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t547, double* %t549
  %t550 = load %LexerState, %LexerState* %l0
  %t551 = extractvalue %LexerState %t550, 3
  %t552 = sitofp i64 1 to double
  %t553 = fadd double %t551, %t552
  %t554 = load %LexerState, %LexerState* %l0
  %t555 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t553, double* %t555
  br label %afterloop49
merge53:
  %t557 = load i1, i1* %l24
  br label %logical_and_entry_556

logical_and_entry_556:
  br i1 %t557, label %logical_and_right_556, label %logical_and_merge_556

logical_and_right_556:
  %t558 = load i8, i8* %l25
  %t559 = alloca [2 x i8], align 1
  %t560 = getelementptr [2 x i8], [2 x i8]* %t559, i32 0, i32 0
  store i8 %t558, i8* %t560
  %t561 = getelementptr [2 x i8], [2 x i8]* %t559, i32 0, i32 1
  store i8 0, i8* %t561
  %t562 = getelementptr [2 x i8], [2 x i8]* %t559, i32 0, i32 0
  %t563 = call i1 @is_backslash(i8* %t562)
  br label %logical_and_right_end_556

logical_and_right_end_556:
  br label %logical_and_merge_556

logical_and_merge_556:
  %t564 = phi i1 [ false, %logical_and_entry_556 ], [ %t563, %logical_and_right_end_556 ]
  %t565 = xor i1 %t564, 1
  %t566 = load %LexerState, %LexerState* %l0
  %t567 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t568 = load i8, i8* %l2
  %t569 = load double, double* %l20
  %t570 = load double, double* %l21
  %t571 = load double, double* %l22
  %t572 = load i8*, i8** %l23
  %t573 = load i1, i1* %l24
  %t574 = load i8, i8* %l25
  br i1 %t565, label %then54, label %merge55
then54:
  store i1 1, i1* %l24
  %t575 = load %LexerState, %LexerState* %l0
  %t576 = extractvalue %LexerState %t575, 1
  %t577 = sitofp i64 1 to double
  %t578 = fadd double %t576, %t577
  %t579 = load %LexerState, %LexerState* %l0
  %t580 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t578, double* %t580
  %t581 = load %LexerState, %LexerState* %l0
  %t582 = extractvalue %LexerState %t581, 3
  %t583 = sitofp i64 1 to double
  %t584 = fadd double %t582, %t583
  %t585 = load %LexerState, %LexerState* %l0
  %t586 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t584, double* %t586
  br label %loop.latch48
merge55:
  %t587 = load i1, i1* %l24
  %t588 = load %LexerState, %LexerState* %l0
  %t589 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t590 = load i8, i8* %l2
  %t591 = load double, double* %l20
  %t592 = load double, double* %l21
  %t593 = load double, double* %l22
  %t594 = load i8*, i8** %l23
  %t595 = load i1, i1* %l24
  %t596 = load i8, i8* %l25
  br i1 %t587, label %then56, label %else57
then56:
  %t597 = load i8*, i8** %l23
  %t598 = load i8, i8* %l25
  %t599 = alloca [2 x i8], align 1
  %t600 = getelementptr [2 x i8], [2 x i8]* %t599, i32 0, i32 0
  store i8 %t598, i8* %t600
  %t601 = getelementptr [2 x i8], [2 x i8]* %t599, i32 0, i32 1
  store i8 0, i8* %t601
  %t602 = getelementptr [2 x i8], [2 x i8]* %t599, i32 0, i32 0
  %t603 = call i8* @interpret_escape(i8* %t602)
  %t604 = call i8* @sailfin_runtime_string_concat(i8* %t597, i8* %t603)
  store i8* %t604, i8** %l23
  store i1 0, i1* %l24
  %t605 = load i8*, i8** %l23
  %t606 = load i1, i1* %l24
  br label %merge58
else57:
  %t607 = load i8*, i8** %l23
  %t608 = load i8, i8* %l25
  %t609 = alloca [2 x i8], align 1
  %t610 = getelementptr [2 x i8], [2 x i8]* %t609, i32 0, i32 0
  store i8 %t608, i8* %t610
  %t611 = getelementptr [2 x i8], [2 x i8]* %t609, i32 0, i32 1
  store i8 0, i8* %t611
  %t612 = getelementptr [2 x i8], [2 x i8]* %t609, i32 0, i32 0
  %t613 = call i8* @sailfin_runtime_string_concat(i8* %t607, i8* %t612)
  store i8* %t613, i8** %l23
  %t614 = load i8*, i8** %l23
  br label %merge58
merge58:
  %t615 = phi i8* [ %t605, %then56 ], [ %t614, %else57 ]
  %t616 = phi i1 [ %t606, %then56 ], [ %t595, %else57 ]
  store i8* %t615, i8** %l23
  store i1 %t616, i1* %l24
  %t617 = load i8, i8* %l25
  %t618 = alloca [2 x i8], align 1
  %t619 = getelementptr [2 x i8], [2 x i8]* %t618, i32 0, i32 0
  store i8 %t617, i8* %t619
  %t620 = getelementptr [2 x i8], [2 x i8]* %t618, i32 0, i32 1
  store i8 0, i8* %t620
  %t621 = getelementptr [2 x i8], [2 x i8]* %t618, i32 0, i32 0
  %t622 = alloca [2 x i8], align 1
  %t623 = getelementptr [2 x i8], [2 x i8]* %t622, i32 0, i32 0
  store i8 10, i8* %t623
  %t624 = getelementptr [2 x i8], [2 x i8]* %t622, i32 0, i32 1
  store i8 0, i8* %t624
  %t625 = getelementptr [2 x i8], [2 x i8]* %t622, i32 0, i32 0
  %t626 = call i1 @strings_equal(i8* %t621, i8* %t625)
  %t627 = load %LexerState, %LexerState* %l0
  %t628 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t629 = load i8, i8* %l2
  %t630 = load double, double* %l20
  %t631 = load double, double* %l21
  %t632 = load double, double* %l22
  %t633 = load i8*, i8** %l23
  %t634 = load i1, i1* %l24
  %t635 = load i8, i8* %l25
  br i1 %t626, label %then59, label %else60
then59:
  %t636 = load %LexerState, %LexerState* %l0
  %t637 = extractvalue %LexerState %t636, 1
  %t638 = sitofp i64 1 to double
  %t639 = fadd double %t637, %t638
  %t640 = load %LexerState, %LexerState* %l0
  %t641 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t639, double* %t641
  %t642 = load %LexerState, %LexerState* %l0
  %t643 = extractvalue %LexerState %t642, 2
  %t644 = sitofp i64 1 to double
  %t645 = fadd double %t643, %t644
  %t646 = load %LexerState, %LexerState* %l0
  %t647 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 2
  store double %t645, double* %t647
  %t648 = load %LexerState, %LexerState* %l0
  %t649 = sitofp i64 1 to double
  %t650 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t649, double* %t650
  br label %merge61
else60:
  %t651 = load %LexerState, %LexerState* %l0
  %t652 = extractvalue %LexerState %t651, 1
  %t653 = sitofp i64 1 to double
  %t654 = fadd double %t652, %t653
  %t655 = load %LexerState, %LexerState* %l0
  %t656 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t654, double* %t656
  %t657 = load %LexerState, %LexerState* %l0
  %t658 = extractvalue %LexerState %t657, 3
  %t659 = sitofp i64 1 to double
  %t660 = fadd double %t658, %t659
  %t661 = load %LexerState, %LexerState* %l0
  %t662 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t660, double* %t662
  br label %merge61
merge61:
  br label %loop.latch48
loop.latch48:
  %t663 = load i1, i1* %l24
  %t664 = load i8*, i8** %l23
  br label %loop.header46
afterloop49:
  %t667 = load i1, i1* %l24
  %t668 = load i8*, i8** %l23
  %t669 = load %LexerState, %LexerState* %l0
  %t670 = extractvalue %LexerState %t669, 0
  %t671 = load double, double* %l20
  %t672 = load %LexerState, %LexerState* %l0
  %t673 = extractvalue %LexerState %t672, 1
  %t674 = call i8* @slice(i8* %t670, double %t671, double %t673)
  store i8* %t674, i8** %l26
  %t675 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t676 = alloca %TokenKind
  %t677 = getelementptr inbounds %TokenKind, %TokenKind* %t676, i32 0, i32 0
  store i32 2, i32* %t677
  %t678 = load i8*, i8** %l23
  %t679 = getelementptr inbounds %TokenKind, %TokenKind* %t676, i32 0, i32 1
  %t680 = bitcast [8 x i8]* %t679 to i8*
  %t681 = bitcast i8* %t680 to i8**
  store i8* %t678, i8** %t681
  %t682 = load %TokenKind, %TokenKind* %t676
  %t683 = insertvalue %Token undef, %TokenKind %t682, 0
  %t684 = load i8*, i8** %l26
  %t685 = insertvalue %Token %t683, i8* %t684, 1
  %t686 = load double, double* %l21
  %t687 = insertvalue %Token %t685, double %t686, 2
  %t688 = load double, double* %l22
  %t689 = insertvalue %Token %t687, double %t688, 3
  %t690 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t675, %Token %t689)
  store { %Token*, i64 }* %t690, { %Token*, i64 }** %l1
  br label %loop.latch2
merge45:
  %t691 = load i8, i8* %l2
  %t692 = alloca [2 x i8], align 1
  %t693 = getelementptr [2 x i8], [2 x i8]* %t692, i32 0, i32 0
  store i8 %t691, i8* %t693
  %t694 = getelementptr [2 x i8], [2 x i8]* %t692, i32 0, i32 1
  store i8 0, i8* %t694
  %t695 = getelementptr [2 x i8], [2 x i8]* %t692, i32 0, i32 0
  %t696 = call i1 @is_digit(i8* %t695)
  %t697 = load %LexerState, %LexerState* %l0
  %t698 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t699 = load i8, i8* %l2
  br i1 %t696, label %then62, label %merge63
then62:
  %t700 = load %LexerState, %LexerState* %l0
  %t701 = extractvalue %LexerState %t700, 1
  store double %t701, double* %l27
  %t702 = load %LexerState, %LexerState* %l0
  %t703 = extractvalue %LexerState %t702, 2
  store double %t703, double* %l28
  %t704 = load %LexerState, %LexerState* %l0
  %t705 = extractvalue %LexerState %t704, 3
  store double %t705, double* %l29
  %t706 = load %LexerState, %LexerState* %l0
  %t707 = extractvalue %LexerState %t706, 1
  %t708 = sitofp i64 1 to double
  %t709 = fadd double %t707, %t708
  %t710 = load %LexerState, %LexerState* %l0
  %t711 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t709, double* %t711
  %t712 = load %LexerState, %LexerState* %l0
  %t713 = extractvalue %LexerState %t712, 3
  %t714 = sitofp i64 1 to double
  %t715 = fadd double %t713, %t714
  %t716 = load %LexerState, %LexerState* %l0
  %t717 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t715, double* %t717
  %t718 = load %LexerState, %LexerState* %l0
  %t719 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t720 = load i8, i8* %l2
  %t721 = load double, double* %l27
  %t722 = load double, double* %l28
  %t723 = load double, double* %l29
  br label %loop.header64
loop.header64:
  br label %loop.body65
loop.body65:
  %t724 = load %LexerState, %LexerState* %l0
  %t725 = extractvalue %LexerState %t724, 1
  %t726 = load %LexerState, %LexerState* %l0
  %t727 = extractvalue %LexerState %t726, 0
  %t728 = call i64 @sailfin_runtime_string_length(i8* %t727)
  %t729 = sitofp i64 %t728 to double
  %t730 = fcmp oge double %t725, %t729
  %t731 = load %LexerState, %LexerState* %l0
  %t732 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t733 = load i8, i8* %l2
  %t734 = load double, double* %l27
  %t735 = load double, double* %l28
  %t736 = load double, double* %l29
  br i1 %t730, label %then68, label %merge69
then68:
  br label %afterloop67
merge69:
  %t737 = load %LexerState, %LexerState* %l0
  %t738 = extractvalue %LexerState %t737, 0
  %t739 = load %LexerState, %LexerState* %l0
  %t740 = extractvalue %LexerState %t739, 1
  %t741 = fptosi double %t740 to i64
  %t742 = getelementptr i8, i8* %t738, i64 %t741
  %t743 = load i8, i8* %t742
  %t744 = alloca [2 x i8], align 1
  %t745 = getelementptr [2 x i8], [2 x i8]* %t744, i32 0, i32 0
  store i8 %t743, i8* %t745
  %t746 = getelementptr [2 x i8], [2 x i8]* %t744, i32 0, i32 1
  store i8 0, i8* %t746
  %t747 = getelementptr [2 x i8], [2 x i8]* %t744, i32 0, i32 0
  %t748 = call i1 @is_digit(i8* %t747)
  %t749 = xor i1 %t748, 1
  %t750 = load %LexerState, %LexerState* %l0
  %t751 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t752 = load i8, i8* %l2
  %t753 = load double, double* %l27
  %t754 = load double, double* %l28
  %t755 = load double, double* %l29
  br i1 %t749, label %then70, label %merge71
then70:
  br label %afterloop67
merge71:
  %t756 = load %LexerState, %LexerState* %l0
  %t757 = extractvalue %LexerState %t756, 1
  %t758 = sitofp i64 1 to double
  %t759 = fadd double %t757, %t758
  %t760 = load %LexerState, %LexerState* %l0
  %t761 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t759, double* %t761
  %t762 = load %LexerState, %LexerState* %l0
  %t763 = extractvalue %LexerState %t762, 3
  %t764 = sitofp i64 1 to double
  %t765 = fadd double %t763, %t764
  %t766 = load %LexerState, %LexerState* %l0
  %t767 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t765, double* %t767
  br label %loop.latch66
loop.latch66:
  br label %loop.header64
afterloop67:
  %t769 = load %LexerState, %LexerState* %l0
  %t770 = extractvalue %LexerState %t769, 1
  %t771 = load %LexerState, %LexerState* %l0
  %t772 = extractvalue %LexerState %t771, 0
  %t773 = call i64 @sailfin_runtime_string_length(i8* %t772)
  %t774 = sitofp i64 %t773 to double
  %t775 = fcmp olt double %t770, %t774
  br label %logical_and_entry_768

logical_and_entry_768:
  br i1 %t775, label %logical_and_right_768, label %logical_and_merge_768

logical_and_right_768:
  %t776 = load %LexerState, %LexerState* %l0
  %t777 = extractvalue %LexerState %t776, 0
  %t778 = load %LexerState, %LexerState* %l0
  %t779 = extractvalue %LexerState %t778, 1
  %t780 = fptosi double %t779 to i64
  %t781 = getelementptr i8, i8* %t777, i64 %t780
  %t782 = load i8, i8* %t781
  %t783 = alloca [2 x i8], align 1
  %t784 = getelementptr [2 x i8], [2 x i8]* %t783, i32 0, i32 0
  store i8 %t782, i8* %t784
  %t785 = getelementptr [2 x i8], [2 x i8]* %t783, i32 0, i32 1
  store i8 0, i8* %t785
  %t786 = getelementptr [2 x i8], [2 x i8]* %t783, i32 0, i32 0
  %t787 = alloca [2 x i8], align 1
  %t788 = getelementptr [2 x i8], [2 x i8]* %t787, i32 0, i32 0
  store i8 46, i8* %t788
  %t789 = getelementptr [2 x i8], [2 x i8]* %t787, i32 0, i32 1
  store i8 0, i8* %t789
  %t790 = getelementptr [2 x i8], [2 x i8]* %t787, i32 0, i32 0
  %t791 = call i1 @strings_equal(i8* %t786, i8* %t790)
  br label %logical_and_right_end_768

logical_and_right_end_768:
  br label %logical_and_merge_768

logical_and_merge_768:
  %t792 = phi i1 [ false, %logical_and_entry_768 ], [ %t791, %logical_and_right_end_768 ]
  %t793 = load %LexerState, %LexerState* %l0
  %t794 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t795 = load i8, i8* %l2
  %t796 = load double, double* %l27
  %t797 = load double, double* %l28
  %t798 = load double, double* %l29
  br i1 %t792, label %then72, label %merge73
then72:
  %t800 = load %LexerState, %LexerState* %l0
  %t801 = extractvalue %LexerState %t800, 1
  %t802 = sitofp i64 1 to double
  %t803 = fadd double %t801, %t802
  %t804 = load %LexerState, %LexerState* %l0
  %t805 = extractvalue %LexerState %t804, 0
  %t806 = call i64 @sailfin_runtime_string_length(i8* %t805)
  %t807 = sitofp i64 %t806 to double
  %t808 = fcmp olt double %t803, %t807
  br label %logical_and_entry_799

logical_and_entry_799:
  br i1 %t808, label %logical_and_right_799, label %logical_and_merge_799

logical_and_right_799:
  %t809 = load %LexerState, %LexerState* %l0
  %t810 = extractvalue %LexerState %t809, 0
  %t811 = load %LexerState, %LexerState* %l0
  %t812 = extractvalue %LexerState %t811, 1
  %t813 = sitofp i64 1 to double
  %t814 = fadd double %t812, %t813
  %t815 = fptosi double %t814 to i64
  %t816 = getelementptr i8, i8* %t810, i64 %t815
  %t817 = load i8, i8* %t816
  %t818 = alloca [2 x i8], align 1
  %t819 = getelementptr [2 x i8], [2 x i8]* %t818, i32 0, i32 0
  store i8 %t817, i8* %t819
  %t820 = getelementptr [2 x i8], [2 x i8]* %t818, i32 0, i32 1
  store i8 0, i8* %t820
  %t821 = getelementptr [2 x i8], [2 x i8]* %t818, i32 0, i32 0
  %t822 = call i1 @is_digit(i8* %t821)
  br label %logical_and_right_end_799

logical_and_right_end_799:
  br label %logical_and_merge_799

logical_and_merge_799:
  %t823 = phi i1 [ false, %logical_and_entry_799 ], [ %t822, %logical_and_right_end_799 ]
  store i1 %t823, i1* %l30
  %t824 = load i1, i1* %l30
  %t825 = load %LexerState, %LexerState* %l0
  %t826 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t827 = load i8, i8* %l2
  %t828 = load double, double* %l27
  %t829 = load double, double* %l28
  %t830 = load double, double* %l29
  %t831 = load i1, i1* %l30
  br i1 %t824, label %then74, label %merge75
then74:
  %t832 = load %LexerState, %LexerState* %l0
  %t833 = extractvalue %LexerState %t832, 1
  %t834 = sitofp i64 1 to double
  %t835 = fadd double %t833, %t834
  %t836 = load %LexerState, %LexerState* %l0
  %t837 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t835, double* %t837
  %t838 = load %LexerState, %LexerState* %l0
  %t839 = extractvalue %LexerState %t838, 3
  %t840 = sitofp i64 1 to double
  %t841 = fadd double %t839, %t840
  %t842 = load %LexerState, %LexerState* %l0
  %t843 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t841, double* %t843
  %t844 = load %LexerState, %LexerState* %l0
  %t845 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t846 = load i8, i8* %l2
  %t847 = load double, double* %l27
  %t848 = load double, double* %l28
  %t849 = load double, double* %l29
  %t850 = load i1, i1* %l30
  br label %loop.header76
loop.header76:
  br label %loop.body77
loop.body77:
  %t851 = load %LexerState, %LexerState* %l0
  %t852 = extractvalue %LexerState %t851, 1
  %t853 = load %LexerState, %LexerState* %l0
  %t854 = extractvalue %LexerState %t853, 0
  %t855 = call i64 @sailfin_runtime_string_length(i8* %t854)
  %t856 = sitofp i64 %t855 to double
  %t857 = fcmp oge double %t852, %t856
  %t858 = load %LexerState, %LexerState* %l0
  %t859 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t860 = load i8, i8* %l2
  %t861 = load double, double* %l27
  %t862 = load double, double* %l28
  %t863 = load double, double* %l29
  %t864 = load i1, i1* %l30
  br i1 %t857, label %then80, label %merge81
then80:
  br label %afterloop79
merge81:
  %t865 = load %LexerState, %LexerState* %l0
  %t866 = extractvalue %LexerState %t865, 0
  %t867 = load %LexerState, %LexerState* %l0
  %t868 = extractvalue %LexerState %t867, 1
  %t869 = fptosi double %t868 to i64
  %t870 = getelementptr i8, i8* %t866, i64 %t869
  %t871 = load i8, i8* %t870
  %t872 = alloca [2 x i8], align 1
  %t873 = getelementptr [2 x i8], [2 x i8]* %t872, i32 0, i32 0
  store i8 %t871, i8* %t873
  %t874 = getelementptr [2 x i8], [2 x i8]* %t872, i32 0, i32 1
  store i8 0, i8* %t874
  %t875 = getelementptr [2 x i8], [2 x i8]* %t872, i32 0, i32 0
  %t876 = call i1 @is_digit(i8* %t875)
  %t877 = xor i1 %t876, 1
  %t878 = load %LexerState, %LexerState* %l0
  %t879 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t880 = load i8, i8* %l2
  %t881 = load double, double* %l27
  %t882 = load double, double* %l28
  %t883 = load double, double* %l29
  %t884 = load i1, i1* %l30
  br i1 %t877, label %then82, label %merge83
then82:
  br label %afterloop79
merge83:
  %t885 = load %LexerState, %LexerState* %l0
  %t886 = extractvalue %LexerState %t885, 1
  %t887 = sitofp i64 1 to double
  %t888 = fadd double %t886, %t887
  %t889 = load %LexerState, %LexerState* %l0
  %t890 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t888, double* %t890
  %t891 = load %LexerState, %LexerState* %l0
  %t892 = extractvalue %LexerState %t891, 3
  %t893 = sitofp i64 1 to double
  %t894 = fadd double %t892, %t893
  %t895 = load %LexerState, %LexerState* %l0
  %t896 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t894, double* %t896
  br label %loop.latch78
loop.latch78:
  br label %loop.header76
afterloop79:
  br label %merge75
merge75:
  br label %merge73
merge73:
  %t897 = load %LexerState, %LexerState* %l0
  %t898 = extractvalue %LexerState %t897, 0
  %t899 = load double, double* %l27
  %t900 = load %LexerState, %LexerState* %l0
  %t901 = extractvalue %LexerState %t900, 1
  %t902 = call i8* @slice(i8* %t898, double %t899, double %t901)
  store i8* %t902, i8** %l31
  %t903 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t904 = alloca %TokenKind
  %t905 = getelementptr inbounds %TokenKind, %TokenKind* %t904, i32 0, i32 0
  store i32 1, i32* %t905
  %t906 = load i8*, i8** %l31
  %t907 = getelementptr inbounds %TokenKind, %TokenKind* %t904, i32 0, i32 1
  %t908 = bitcast [8 x i8]* %t907 to i8*
  %t909 = bitcast i8* %t908 to i8**
  store i8* %t906, i8** %t909
  %t910 = load %TokenKind, %TokenKind* %t904
  %t911 = insertvalue %Token undef, %TokenKind %t910, 0
  %t912 = load i8*, i8** %l31
  %t913 = insertvalue %Token %t911, i8* %t912, 1
  %t914 = load double, double* %l28
  %t915 = insertvalue %Token %t913, double %t914, 2
  %t916 = load double, double* %l29
  %t917 = insertvalue %Token %t915, double %t916, 3
  %t918 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t903, %Token %t917)
  store { %Token*, i64 }* %t918, { %Token*, i64 }** %l1
  br label %loop.latch2
merge63:
  %t919 = load i8, i8* %l2
  %t920 = alloca [2 x i8], align 1
  %t921 = getelementptr [2 x i8], [2 x i8]* %t920, i32 0, i32 0
  store i8 %t919, i8* %t921
  %t922 = getelementptr [2 x i8], [2 x i8]* %t920, i32 0, i32 1
  store i8 0, i8* %t922
  %t923 = getelementptr [2 x i8], [2 x i8]* %t920, i32 0, i32 0
  %t924 = call i1 @is_identifier_start(i8* %t923)
  %t925 = load %LexerState, %LexerState* %l0
  %t926 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t927 = load i8, i8* %l2
  br i1 %t924, label %then84, label %merge85
then84:
  %t928 = load %LexerState, %LexerState* %l0
  %t929 = extractvalue %LexerState %t928, 1
  store double %t929, double* %l32
  %t930 = load %LexerState, %LexerState* %l0
  %t931 = extractvalue %LexerState %t930, 2
  store double %t931, double* %l33
  %t932 = load %LexerState, %LexerState* %l0
  %t933 = extractvalue %LexerState %t932, 3
  store double %t933, double* %l34
  %t934 = load %LexerState, %LexerState* %l0
  %t935 = extractvalue %LexerState %t934, 1
  %t936 = sitofp i64 1 to double
  %t937 = fadd double %t935, %t936
  %t938 = load %LexerState, %LexerState* %l0
  %t939 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t937, double* %t939
  %t940 = load %LexerState, %LexerState* %l0
  %t941 = extractvalue %LexerState %t940, 3
  %t942 = sitofp i64 1 to double
  %t943 = fadd double %t941, %t942
  %t944 = load %LexerState, %LexerState* %l0
  %t945 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t943, double* %t945
  %t946 = load %LexerState, %LexerState* %l0
  %t947 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t948 = load i8, i8* %l2
  %t949 = load double, double* %l32
  %t950 = load double, double* %l33
  %t951 = load double, double* %l34
  br label %loop.header86
loop.header86:
  br label %loop.body87
loop.body87:
  %t952 = load %LexerState, %LexerState* %l0
  %t953 = extractvalue %LexerState %t952, 1
  %t954 = load %LexerState, %LexerState* %l0
  %t955 = extractvalue %LexerState %t954, 0
  %t956 = call i64 @sailfin_runtime_string_length(i8* %t955)
  %t957 = sitofp i64 %t956 to double
  %t958 = fcmp oge double %t953, %t957
  %t959 = load %LexerState, %LexerState* %l0
  %t960 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t961 = load i8, i8* %l2
  %t962 = load double, double* %l32
  %t963 = load double, double* %l33
  %t964 = load double, double* %l34
  br i1 %t958, label %then90, label %merge91
then90:
  br label %afterloop89
merge91:
  %t965 = load %LexerState, %LexerState* %l0
  %t966 = extractvalue %LexerState %t965, 0
  %t967 = load %LexerState, %LexerState* %l0
  %t968 = extractvalue %LexerState %t967, 1
  %t969 = fptosi double %t968 to i64
  %t970 = getelementptr i8, i8* %t966, i64 %t969
  %t971 = load i8, i8* %t970
  %t972 = alloca [2 x i8], align 1
  %t973 = getelementptr [2 x i8], [2 x i8]* %t972, i32 0, i32 0
  store i8 %t971, i8* %t973
  %t974 = getelementptr [2 x i8], [2 x i8]* %t972, i32 0, i32 1
  store i8 0, i8* %t974
  %t975 = getelementptr [2 x i8], [2 x i8]* %t972, i32 0, i32 0
  %t976 = call i1 @is_identifier_part(i8* %t975)
  %t977 = xor i1 %t976, 1
  %t978 = load %LexerState, %LexerState* %l0
  %t979 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t980 = load i8, i8* %l2
  %t981 = load double, double* %l32
  %t982 = load double, double* %l33
  %t983 = load double, double* %l34
  br i1 %t977, label %then92, label %merge93
then92:
  br label %afterloop89
merge93:
  %t984 = load %LexerState, %LexerState* %l0
  %t985 = extractvalue %LexerState %t984, 1
  %t986 = sitofp i64 1 to double
  %t987 = fadd double %t985, %t986
  %t988 = load %LexerState, %LexerState* %l0
  %t989 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t987, double* %t989
  %t990 = load %LexerState, %LexerState* %l0
  %t991 = extractvalue %LexerState %t990, 3
  %t992 = sitofp i64 1 to double
  %t993 = fadd double %t991, %t992
  %t994 = load %LexerState, %LexerState* %l0
  %t995 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t993, double* %t995
  br label %loop.latch88
loop.latch88:
  br label %loop.header86
afterloop89:
  %t996 = load %LexerState, %LexerState* %l0
  %t997 = extractvalue %LexerState %t996, 0
  %t998 = load double, double* %l32
  %t999 = load %LexerState, %LexerState* %l0
  %t1000 = extractvalue %LexerState %t999, 1
  %t1001 = call i8* @slice(i8* %t997, double %t998, double %t1000)
  store i8* %t1001, i8** %l35
  %t1003 = load i8*, i8** %l35
  %s1004 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h275946731, i32 0, i32 0
  %t1005 = call i1 @strings_equal(i8* %t1003, i8* %s1004)
  br label %logical_or_entry_1002

logical_or_entry_1002:
  br i1 %t1005, label %logical_or_merge_1002, label %logical_or_right_1002

logical_or_right_1002:
  %t1006 = load i8*, i8** %l35
  %s1007 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2095430042, i32 0, i32 0
  %t1008 = call i1 @strings_equal(i8* %t1006, i8* %s1007)
  br label %logical_or_right_end_1002

logical_or_right_end_1002:
  br label %logical_or_merge_1002

logical_or_merge_1002:
  %t1009 = phi i1 [ true, %logical_or_entry_1002 ], [ %t1008, %logical_or_right_end_1002 ]
  %t1010 = load %LexerState, %LexerState* %l0
  %t1011 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t1012 = load i8, i8* %l2
  %t1013 = load double, double* %l32
  %t1014 = load double, double* %l33
  %t1015 = load double, double* %l34
  %t1016 = load i8*, i8** %l35
  br i1 %t1009, label %then94, label %else95
then94:
  %t1017 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t1018 = alloca %TokenKind
  %t1019 = getelementptr inbounds %TokenKind, %TokenKind* %t1018, i32 0, i32 0
  store i32 3, i32* %t1019
  %t1020 = load i8*, i8** %l35
  %t1021 = getelementptr inbounds %TokenKind, %TokenKind* %t1018, i32 0, i32 1
  %t1022 = bitcast [8 x i8]* %t1021 to i8*
  %t1023 = bitcast i8* %t1022 to i8**
  store i8* %t1020, i8** %t1023
  %t1024 = load %TokenKind, %TokenKind* %t1018
  %t1025 = insertvalue %Token undef, %TokenKind %t1024, 0
  %t1026 = load i8*, i8** %l35
  %t1027 = insertvalue %Token %t1025, i8* %t1026, 1
  %t1028 = load double, double* %l33
  %t1029 = insertvalue %Token %t1027, double %t1028, 2
  %t1030 = load double, double* %l34
  %t1031 = insertvalue %Token %t1029, double %t1030, 3
  %t1032 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t1017, %Token %t1031)
  store { %Token*, i64 }* %t1032, { %Token*, i64 }** %l1
  %t1033 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br label %merge96
else95:
  %t1034 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t1035 = alloca %TokenKind
  %t1036 = getelementptr inbounds %TokenKind, %TokenKind* %t1035, i32 0, i32 0
  store i32 0, i32* %t1036
  %t1037 = load i8*, i8** %l35
  %t1038 = getelementptr inbounds %TokenKind, %TokenKind* %t1035, i32 0, i32 1
  %t1039 = bitcast [8 x i8]* %t1038 to i8*
  %t1040 = bitcast i8* %t1039 to i8**
  store i8* %t1037, i8** %t1040
  %t1041 = load %TokenKind, %TokenKind* %t1035
  %t1042 = insertvalue %Token undef, %TokenKind %t1041, 0
  %t1043 = load i8*, i8** %l35
  %t1044 = insertvalue %Token %t1042, i8* %t1043, 1
  %t1045 = load double, double* %l33
  %t1046 = insertvalue %Token %t1044, double %t1045, 2
  %t1047 = load double, double* %l34
  %t1048 = insertvalue %Token %t1046, double %t1047, 3
  %t1049 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t1034, %Token %t1048)
  store { %Token*, i64 }* %t1049, { %Token*, i64 }** %l1
  %t1050 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br label %merge96
merge96:
  %t1051 = phi { %Token*, i64 }* [ %t1033, %then94 ], [ %t1050, %else95 ]
  store { %Token*, i64 }* %t1051, { %Token*, i64 }** %l1
  br label %loop.latch2
merge85:
  %t1052 = load %LexerState, %LexerState* %l0
  %t1053 = extractvalue %LexerState %t1052, 2
  store double %t1053, double* %l36
  %t1054 = load %LexerState, %LexerState* %l0
  %t1055 = extractvalue %LexerState %t1054, 3
  store double %t1055, double* %l37
  %t1056 = load i8, i8* %l2
  store i8 %t1056, i8* %l38
  %t1057 = load %LexerState, %LexerState* %l0
  %t1058 = call i8* @peek_next_char(%LexerState %t1057)
  store i8* %t1058, i8** %l39
  %t1059 = load i8*, i8** %l39
  %s1060 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t1061 = call i1 @strings_equal(i8* %t1059, i8* %s1060)
  %t1062 = xor i1 %t1061, 1
  %t1063 = load %LexerState, %LexerState* %l0
  %t1064 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t1065 = load i8, i8* %l2
  %t1066 = load double, double* %l36
  %t1067 = load double, double* %l37
  %t1068 = load i8, i8* %l38
  %t1069 = load i8*, i8** %l39
  br i1 %t1062, label %then97, label %merge98
then97:
  %t1070 = load i8, i8* %l2
  %t1071 = load i8*, i8** %l39
  %t1072 = alloca [2 x i8], align 1
  %t1073 = getelementptr [2 x i8], [2 x i8]* %t1072, i32 0, i32 0
  store i8 %t1070, i8* %t1073
  %t1074 = getelementptr [2 x i8], [2 x i8]* %t1072, i32 0, i32 1
  store i8 0, i8* %t1074
  %t1075 = getelementptr [2 x i8], [2 x i8]* %t1072, i32 0, i32 0
  %t1076 = call i8* @sailfin_runtime_string_concat(i8* %t1075, i8* %t1071)
  store i8* %t1076, i8** %l40
  %t1077 = load i8*, i8** %l40
  %t1078 = call i1 @is_two_char_symbol(i8* %t1077)
  %t1079 = load %LexerState, %LexerState* %l0
  %t1080 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t1081 = load i8, i8* %l2
  %t1082 = load double, double* %l36
  %t1083 = load double, double* %l37
  %t1084 = load i8, i8* %l38
  %t1085 = load i8*, i8** %l39
  %t1086 = load i8*, i8** %l40
  br i1 %t1078, label %then99, label %merge100
then99:
  %t1087 = load i8*, i8** %l40
  %t1088 = load i8, i8* %t1087
  store i8 %t1088, i8* %l38
  %t1089 = load %LexerState, %LexerState* %l0
  %t1090 = extractvalue %LexerState %t1089, 1
  %t1091 = sitofp i64 2 to double
  %t1092 = fadd double %t1090, %t1091
  %t1093 = load %LexerState, %LexerState* %l0
  %t1094 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t1092, double* %t1094
  %t1095 = load %LexerState, %LexerState* %l0
  %t1096 = extractvalue %LexerState %t1095, 3
  %t1097 = sitofp i64 2 to double
  %t1098 = fadd double %t1096, %t1097
  %t1099 = load %LexerState, %LexerState* %l0
  %t1100 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t1098, double* %t1100
  %t1101 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t1102 = alloca %TokenKind
  %t1103 = getelementptr inbounds %TokenKind, %TokenKind* %t1102, i32 0, i32 0
  store i32 4, i32* %t1103
  %t1104 = load i8, i8* %l38
  %t1105 = call noalias i8* @malloc(i64 1)
  %t1106 = bitcast i8* %t1105 to i8*
  store i8 %t1104, i8* %t1106
  %t1107 = getelementptr inbounds %TokenKind, %TokenKind* %t1102, i32 0, i32 1
  %t1108 = bitcast [8 x i8]* %t1107 to i8*
  %t1109 = bitcast i8* %t1108 to i8**
  store i8* %t1105, i8** %t1109
  %t1110 = load %TokenKind, %TokenKind* %t1102
  %t1111 = insertvalue %Token undef, %TokenKind %t1110, 0
  %t1112 = load i8, i8* %l38
  %t1113 = alloca [2 x i8], align 1
  %t1114 = getelementptr [2 x i8], [2 x i8]* %t1113, i32 0, i32 0
  store i8 %t1112, i8* %t1114
  %t1115 = getelementptr [2 x i8], [2 x i8]* %t1113, i32 0, i32 1
  store i8 0, i8* %t1115
  %t1116 = getelementptr [2 x i8], [2 x i8]* %t1113, i32 0, i32 0
  %t1117 = insertvalue %Token %t1111, i8* %t1116, 1
  %t1118 = load double, double* %l36
  %t1119 = insertvalue %Token %t1117, double %t1118, 2
  %t1120 = load double, double* %l37
  %t1121 = insertvalue %Token %t1119, double %t1120, 3
  %t1122 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t1101, %Token %t1121)
  store { %Token*, i64 }* %t1122, { %Token*, i64 }** %l1
  br label %loop.latch2
merge100:
  %t1123 = load i8, i8* %l38
  %t1124 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br label %merge98
merge98:
  %t1125 = phi i8 [ %t1123, %merge100 ], [ %t1068, %merge85 ]
  %t1126 = phi { %Token*, i64 }* [ %t1124, %merge100 ], [ %t1064, %merge85 ]
  store i8 %t1125, i8* %l38
  store { %Token*, i64 }* %t1126, { %Token*, i64 }** %l1
  %t1127 = load %LexerState, %LexerState* %l0
  %t1128 = extractvalue %LexerState %t1127, 1
  %t1129 = sitofp i64 1 to double
  %t1130 = fadd double %t1128, %t1129
  %t1131 = load %LexerState, %LexerState* %l0
  %t1132 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t1130, double* %t1132
  %t1133 = load i8, i8* %l2
  %t1134 = alloca [2 x i8], align 1
  %t1135 = getelementptr [2 x i8], [2 x i8]* %t1134, i32 0, i32 0
  store i8 %t1133, i8* %t1135
  %t1136 = getelementptr [2 x i8], [2 x i8]* %t1134, i32 0, i32 1
  store i8 0, i8* %t1136
  %t1137 = getelementptr [2 x i8], [2 x i8]* %t1134, i32 0, i32 0
  %t1138 = alloca [2 x i8], align 1
  %t1139 = getelementptr [2 x i8], [2 x i8]* %t1138, i32 0, i32 0
  store i8 10, i8* %t1139
  %t1140 = getelementptr [2 x i8], [2 x i8]* %t1138, i32 0, i32 1
  store i8 0, i8* %t1140
  %t1141 = getelementptr [2 x i8], [2 x i8]* %t1138, i32 0, i32 0
  %t1142 = call i1 @strings_equal(i8* %t1137, i8* %t1141)
  %t1143 = load %LexerState, %LexerState* %l0
  %t1144 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t1145 = load i8, i8* %l2
  %t1146 = load double, double* %l36
  %t1147 = load double, double* %l37
  %t1148 = load i8, i8* %l38
  %t1149 = load i8*, i8** %l39
  br i1 %t1142, label %then101, label %else102
then101:
  %t1150 = load %LexerState, %LexerState* %l0
  %t1151 = extractvalue %LexerState %t1150, 2
  %t1152 = sitofp i64 1 to double
  %t1153 = fadd double %t1151, %t1152
  %t1154 = load %LexerState, %LexerState* %l0
  %t1155 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 2
  store double %t1153, double* %t1155
  %t1156 = load %LexerState, %LexerState* %l0
  %t1157 = sitofp i64 1 to double
  %t1158 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t1157, double* %t1158
  br label %merge103
else102:
  %t1159 = load %LexerState, %LexerState* %l0
  %t1160 = extractvalue %LexerState %t1159, 3
  %t1161 = sitofp i64 1 to double
  %t1162 = fadd double %t1160, %t1161
  %t1163 = load %LexerState, %LexerState* %l0
  %t1164 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t1162, double* %t1164
  br label %merge103
merge103:
  %t1165 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t1166 = alloca %TokenKind
  %t1167 = getelementptr inbounds %TokenKind, %TokenKind* %t1166, i32 0, i32 0
  store i32 4, i32* %t1167
  %t1168 = load i8, i8* %l38
  %t1169 = call noalias i8* @malloc(i64 1)
  %t1170 = bitcast i8* %t1169 to i8*
  store i8 %t1168, i8* %t1170
  %t1171 = getelementptr inbounds %TokenKind, %TokenKind* %t1166, i32 0, i32 1
  %t1172 = bitcast [8 x i8]* %t1171 to i8*
  %t1173 = bitcast i8* %t1172 to i8**
  store i8* %t1169, i8** %t1173
  %t1174 = load %TokenKind, %TokenKind* %t1166
  %t1175 = insertvalue %Token undef, %TokenKind %t1174, 0
  %t1176 = load i8, i8* %l38
  %t1177 = alloca [2 x i8], align 1
  %t1178 = getelementptr [2 x i8], [2 x i8]* %t1177, i32 0, i32 0
  store i8 %t1176, i8* %t1178
  %t1179 = getelementptr [2 x i8], [2 x i8]* %t1177, i32 0, i32 1
  store i8 0, i8* %t1179
  %t1180 = getelementptr [2 x i8], [2 x i8]* %t1177, i32 0, i32 0
  %t1181 = insertvalue %Token %t1175, i8* %t1180, 1
  %t1182 = load double, double* %l36
  %t1183 = insertvalue %Token %t1181, double %t1182, 2
  %t1184 = load double, double* %l37
  %t1185 = insertvalue %Token %t1183, double %t1184, 3
  %t1186 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t1165, %Token %t1185)
  store { %Token*, i64 }* %t1186, { %Token*, i64 }** %l1
  br label %loop.latch2
loop.latch2:
  %t1187 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br label %loop.header0
afterloop3:
  %t1189 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t1190 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t1191 = load %LexerState, %LexerState* %l0
  %t1192 = extractvalue %LexerState %t1191, 2
  %t1193 = load %LexerState, %LexerState* %l0
  %t1194 = extractvalue %LexerState %t1193, 3
  %t1195 = call %Token @eof_token(double %t1192, double %t1194)
  %t1196 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t1190, %Token %t1195)
  store { %Token*, i64 }* %t1196, { %Token*, i64 }** %l1
  %t1197 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  ret { %Token*, i64 }* %t1197
}

define i1 @is_whitespace(i8* %ch) {
block.entry:
  %t1 = alloca [2 x i8], align 1
  %t2 = getelementptr [2 x i8], [2 x i8]* %t1, i32 0, i32 0
  store i8 32, i8* %t2
  %t3 = getelementptr [2 x i8], [2 x i8]* %t1, i32 0, i32 1
  store i8 0, i8* %t3
  %t4 = getelementptr [2 x i8], [2 x i8]* %t1, i32 0, i32 0
  %t5 = call i1 @strings_equal(i8* %ch, i8* %t4)
  br label %logical_or_entry_0

logical_or_entry_0:
  br i1 %t5, label %logical_or_merge_0, label %logical_or_right_0

logical_or_right_0:
  %t7 = alloca [2 x i8], align 1
  %t8 = getelementptr [2 x i8], [2 x i8]* %t7, i32 0, i32 0
  store i8 9, i8* %t8
  %t9 = getelementptr [2 x i8], [2 x i8]* %t7, i32 0, i32 1
  store i8 0, i8* %t9
  %t10 = getelementptr [2 x i8], [2 x i8]* %t7, i32 0, i32 0
  %t11 = call i1 @strings_equal(i8* %ch, i8* %t10)
  br label %logical_or_entry_6

logical_or_entry_6:
  br i1 %t11, label %logical_or_merge_6, label %logical_or_right_6

logical_or_right_6:
  %t13 = alloca [2 x i8], align 1
  %t14 = getelementptr [2 x i8], [2 x i8]* %t13, i32 0, i32 0
  store i8 10, i8* %t14
  %t15 = getelementptr [2 x i8], [2 x i8]* %t13, i32 0, i32 1
  store i8 0, i8* %t15
  %t16 = getelementptr [2 x i8], [2 x i8]* %t13, i32 0, i32 0
  %t17 = call i1 @strings_equal(i8* %ch, i8* %t16)
  br label %logical_or_entry_12

logical_or_entry_12:
  br i1 %t17, label %logical_or_merge_12, label %logical_or_right_12

logical_or_right_12:
  %t18 = alloca [2 x i8], align 1
  %t19 = getelementptr [2 x i8], [2 x i8]* %t18, i32 0, i32 0
  store i8 13, i8* %t19
  %t20 = getelementptr [2 x i8], [2 x i8]* %t18, i32 0, i32 1
  store i8 0, i8* %t20
  %t21 = getelementptr [2 x i8], [2 x i8]* %t18, i32 0, i32 0
  %t22 = call i1 @strings_equal(i8* %ch, i8* %t21)
  br label %logical_or_right_end_12

logical_or_right_end_12:
  br label %logical_or_merge_12

logical_or_merge_12:
  %t23 = phi i1 [ true, %logical_or_entry_12 ], [ %t22, %logical_or_right_end_12 ]
  br label %logical_or_right_end_6

logical_or_right_end_6:
  br label %logical_or_merge_6

logical_or_merge_6:
  %t24 = phi i1 [ true, %logical_or_entry_6 ], [ %t23, %logical_or_right_end_6 ]
  br label %logical_or_right_end_0

logical_or_right_end_0:
  br label %logical_or_merge_0

logical_or_merge_0:
  %t25 = phi i1 [ true, %logical_or_entry_0 ], [ %t24, %logical_or_right_end_0 ]
  ret i1 %t25
}

define i1 @is_identifier_start(i8* %ch) {
block.entry:
  %t1 = call i1 @is_letter(i8* %ch)
  br label %logical_or_entry_0

logical_or_entry_0:
  br i1 %t1, label %logical_or_merge_0, label %logical_or_right_0

logical_or_right_0:
  %t2 = alloca [2 x i8], align 1
  %t3 = getelementptr [2 x i8], [2 x i8]* %t2, i32 0, i32 0
  store i8 95, i8* %t3
  %t4 = getelementptr [2 x i8], [2 x i8]* %t2, i32 0, i32 1
  store i8 0, i8* %t4
  %t5 = getelementptr [2 x i8], [2 x i8]* %t2, i32 0, i32 0
  %t6 = call i1 @strings_equal(i8* %ch, i8* %t5)
  br label %logical_or_right_end_0

logical_or_right_end_0:
  br label %logical_or_merge_0

logical_or_merge_0:
  %t7 = phi i1 [ true, %logical_or_entry_0 ], [ %t6, %logical_or_right_end_0 ]
  ret i1 %t7
}

define i1 @is_identifier_part(i8* %ch) {
block.entry:
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
block.entry:
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
block.entry:
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
block.entry:
  %t0 = call double @char_code(i8* %ch)
  %t1 = sitofp i64 34 to double
  %t2 = fcmp oeq double %t0, %t1
  ret i1 %t2
}

define i1 @is_backslash(i8* %ch) {
block.entry:
  %t0 = call double @char_code(i8* %ch)
  %t1 = sitofp i64 92 to double
  %t2 = fcmp oeq double %t0, %t1
  ret i1 %t2
}

define i8* @slice(i8* %text, double %start, double %end) {
block.entry:
  %t0 = fptosi double %start to i64
  %t1 = fptosi double %end to i64
  %t2 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t0, i64 %t1)
  ret i8* %t2
}

define { %Token*, i64 }* @append({ %Token*, i64 }* %tokens, %Token %token) {
block.entry:
  %t0 = call noalias i8* @malloc(i64 32)
  %t1 = bitcast i8* %t0 to %Token*
  store %Token %token, %Token* %t1
  %t2 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t3 = ptrtoint [1 x i8*]* %t2 to i64
  %t4 = icmp eq i64 %t3, 0
  %t5 = select i1 %t4, i64 1, i64 %t3
  %t6 = call i8* @malloc(i64 %t5)
  %t7 = bitcast i8* %t6 to i8**
  %t8 = getelementptr i8*, i8** %t7, i64 0
  store i8* %t0, i8** %t8
  %t9 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t10 = ptrtoint { i8**, i64 }* %t9 to i64
  %t11 = call i8* @malloc(i64 %t10)
  %t12 = bitcast i8* %t11 to { i8**, i64 }*
  %t13 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 0
  store i8** %t7, i8*** %t13
  %t14 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 1
  store i64 1, i64* %t14
  %t15 = bitcast { %Token*, i64 }* %tokens to { i8**, i64 }*
  %t16 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t15, { i8**, i64 }* %t12)
  %t17 = bitcast { i8**, i64 }* %t16 to { %Token*, i64 }*
  ret { %Token*, i64 }* %t17
}

define i8* @peek_next_char(%LexerState %state) {
block.entry:
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
block.entry:
  %t0 = alloca [2 x i8], align 1
  %t1 = getelementptr [2 x i8], [2 x i8]* %t0, i32 0, i32 0
  store i8 110, i8* %t1
  %t2 = getelementptr [2 x i8], [2 x i8]* %t0, i32 0, i32 1
  store i8 0, i8* %t2
  %t3 = getelementptr [2 x i8], [2 x i8]* %t0, i32 0, i32 0
  %t4 = call i1 @strings_equal(i8* %ch, i8* %t3)
  br i1 %t4, label %then0, label %merge1
then0:
  %t5 = alloca [2 x i8], align 1
  %t6 = getelementptr [2 x i8], [2 x i8]* %t5, i32 0, i32 0
  store i8 10, i8* %t6
  %t7 = getelementptr [2 x i8], [2 x i8]* %t5, i32 0, i32 1
  store i8 0, i8* %t7
  %t8 = getelementptr [2 x i8], [2 x i8]* %t5, i32 0, i32 0
  ret i8* %t8
merge1:
  %t9 = alloca [2 x i8], align 1
  %t10 = getelementptr [2 x i8], [2 x i8]* %t9, i32 0, i32 0
  store i8 116, i8* %t10
  %t11 = getelementptr [2 x i8], [2 x i8]* %t9, i32 0, i32 1
  store i8 0, i8* %t11
  %t12 = getelementptr [2 x i8], [2 x i8]* %t9, i32 0, i32 0
  %t13 = call i1 @strings_equal(i8* %ch, i8* %t12)
  br i1 %t13, label %then2, label %merge3
then2:
  %t14 = alloca [2 x i8], align 1
  %t15 = getelementptr [2 x i8], [2 x i8]* %t14, i32 0, i32 0
  store i8 9, i8* %t15
  %t16 = getelementptr [2 x i8], [2 x i8]* %t14, i32 0, i32 1
  store i8 0, i8* %t16
  %t17 = getelementptr [2 x i8], [2 x i8]* %t14, i32 0, i32 0
  ret i8* %t17
merge3:
  %t18 = alloca [2 x i8], align 1
  %t19 = getelementptr [2 x i8], [2 x i8]* %t18, i32 0, i32 0
  store i8 114, i8* %t19
  %t20 = getelementptr [2 x i8], [2 x i8]* %t18, i32 0, i32 1
  store i8 0, i8* %t20
  %t21 = getelementptr [2 x i8], [2 x i8]* %t18, i32 0, i32 0
  %t22 = call i1 @strings_equal(i8* %ch, i8* %t21)
  br i1 %t22, label %then4, label %merge5
then4:
  %t23 = alloca [2 x i8], align 1
  %t24 = getelementptr [2 x i8], [2 x i8]* %t23, i32 0, i32 0
  store i8 13, i8* %t24
  %t25 = getelementptr [2 x i8], [2 x i8]* %t23, i32 0, i32 1
  store i8 0, i8* %t25
  %t26 = getelementptr [2 x i8], [2 x i8]* %t23, i32 0, i32 0
  ret i8* %t26
merge5:
  %t27 = call i1 @is_double_quote(i8* %ch)
  br i1 %t27, label %then6, label %merge7
then6:
  %t28 = alloca [2 x i8], align 1
  %t29 = getelementptr [2 x i8], [2 x i8]* %t28, i32 0, i32 0
  store i8 34, i8* %t29
  %t30 = getelementptr [2 x i8], [2 x i8]* %t28, i32 0, i32 1
  store i8 0, i8* %t30
  %t31 = getelementptr [2 x i8], [2 x i8]* %t28, i32 0, i32 0
  ret i8* %t31
merge7:
  %t32 = call i1 @is_backslash(i8* %ch)
  br i1 %t32, label %then8, label %merge9
then8:
  %t33 = alloca [2 x i8], align 1
  %t34 = getelementptr [2 x i8], [2 x i8]* %t33, i32 0, i32 0
  store i8 92, i8* %t34
  %t35 = getelementptr [2 x i8], [2 x i8]* %t33, i32 0, i32 1
  store i8 0, i8* %t35
  %t36 = getelementptr [2 x i8], [2 x i8]* %t33, i32 0, i32 0
  ret i8* %t36
merge9:
  ret i8* %ch
}

define i1 @is_two_char_symbol(i8* %value) {
block.entry:
  %s1 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193428050, i32 0, i32 0
  %t2 = call i1 @strings_equal(i8* %value, i8* %s1)
  br label %logical_or_entry_0

logical_or_entry_0:
  br i1 %t2, label %logical_or_merge_0, label %logical_or_right_0

logical_or_right_0:
  %s4 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193445474, i32 0, i32 0
  %t5 = call i1 @strings_equal(i8* %value, i8* %s4)
  br label %logical_or_entry_3

logical_or_entry_3:
  br i1 %t5, label %logical_or_merge_3, label %logical_or_right_3

logical_or_right_3:
  %s7 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193445441, i32 0, i32 0
  %t8 = call i1 @strings_equal(i8* %value, i8* %s7)
  br label %logical_or_entry_6

logical_or_entry_6:
  br i1 %t8, label %logical_or_merge_6, label %logical_or_right_6

logical_or_right_6:
  %s10 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193414949, i32 0, i32 0
  %t11 = call i1 @strings_equal(i8* %value, i8* %s10)
  br label %logical_or_entry_9

logical_or_entry_9:
  br i1 %t11, label %logical_or_merge_9, label %logical_or_right_9

logical_or_right_9:
  %s13 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193444352, i32 0, i32 0
  %t14 = call i1 @strings_equal(i8* %value, i8* %s13)
  br label %logical_or_entry_12

logical_or_entry_12:
  br i1 %t14, label %logical_or_merge_12, label %logical_or_right_12

logical_or_right_12:
  %s16 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193446530, i32 0, i32 0
  %t17 = call i1 @strings_equal(i8* %value, i8* %s16)
  br label %logical_or_entry_15

logical_or_entry_15:
  br i1 %t17, label %logical_or_merge_15, label %logical_or_right_15

logical_or_right_15:
  %s19 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193419635, i32 0, i32 0
  %t20 = call i1 @strings_equal(i8* %value, i8* %s19)
  br label %logical_or_entry_18

logical_or_entry_18:
  br i1 %t20, label %logical_or_merge_18, label %logical_or_right_18

logical_or_right_18:
  %s22 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193516127, i32 0, i32 0
  %t23 = call i1 @strings_equal(i8* %value, i8* %s22)
  br label %logical_or_entry_21

logical_or_entry_21:
  br i1 %t23, label %logical_or_merge_21, label %logical_or_right_21

logical_or_right_21:
  %s24 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193428611, i32 0, i32 0
  %t25 = call i1 @strings_equal(i8* %value, i8* %s24)
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
@.str.len5.h2095430042 = private unnamed_addr constant [6 x i8] c"false\00"
@.str.len0.h177573 = private unnamed_addr constant [1 x i8] c"\00"
@.str.len4.h275946731 = private unnamed_addr constant [5 x i8] c"true\00"
