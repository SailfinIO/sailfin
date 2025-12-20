; ModuleID = 'sailfin'
source_filename = "sailfin"

%LexerState = type { i8*, double, double, double }
%Token = type { %TokenKind, i8*, double, double }

%TokenKind = type { i32 }

declare void @sailfin_runtime_bounds_check(i64, i64)
declare i8* @sailfin_runtime_substring(i8*, i64, i64)
declare i64 @sailfin_runtime_string_length(i8*)
declare i8* @sailfin_runtime_string_concat(i8*, i8*)
declare i8* @sailfin_runtime_number_to_string(double)
declare i1 @strings_equal(i8*, i8*)
declare double @char_code(i8*)
declare { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }*, { i8**, i64 }*)
declare i8* @sailfin_runtime_get_field(i8*, i8*)
declare void @sailfin_runtime_mark_persistent(i8*)

declare %Token @eof_token(double, double)
declare i8* @char_at(i8*, double)
declare i1 @is_symbol_char(i8*)
declare i8* @sanitize_symbol(i8*)

declare noalias i8* @malloc(i64)

@runtime = external global i8**

declare void @sailfin_runtime_copy_bytes(i8*, i8*, i64)

define { %Token*, i64 }* @lex(i8* %source) {
block.entry:
  %l0 = alloca %LexerState
  %l1 = alloca { %Token*, i64 }*
  %l2 = alloca i8*
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
  %l13 = alloca i8*
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
  %l25 = alloca i8*
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
  %l38 = alloca i8*
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
  %t991 = phi { %Token*, i64 }* [ %t20, %block.entry ], [ %t990, %loop.latch2 ]
  store { %Token*, i64 }* %t991, { %Token*, i64 }** %l1
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
  %t34 = call i8* @char_at(i8* %t31, double %t33)
  store i8* %t34, i8** %l2
  %t35 = load i8*, i8** %l2
  %t36 = call i1 @is_whitespace(i8* %t35)
  %t37 = load %LexerState, %LexerState* %l0
  %t38 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t39 = load i8*, i8** %l2
  br i1 %t36, label %then6, label %merge7
then6:
  %t40 = load %LexerState, %LexerState* %l0
  %t41 = extractvalue %LexerState %t40, 1
  store double %t41, double* %l3
  %t42 = load %LexerState, %LexerState* %l0
  %t43 = extractvalue %LexerState %t42, 2
  store double %t43, double* %l4
  %t44 = load %LexerState, %LexerState* %l0
  %t45 = extractvalue %LexerState %t44, 3
  store double %t45, double* %l5
  %t46 = load %LexerState, %LexerState* %l0
  %t47 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t48 = load i8*, i8** %l2
  %t49 = load double, double* %l3
  %t50 = load double, double* %l4
  %t51 = load double, double* %l5
  br label %loop.header8
loop.header8:
  br label %loop.body9
loop.body9:
  %t52 = load %LexerState, %LexerState* %l0
  %t53 = extractvalue %LexerState %t52, 1
  %t54 = load %LexerState, %LexerState* %l0
  %t55 = extractvalue %LexerState %t54, 0
  %t56 = call i64 @sailfin_runtime_string_length(i8* %t55)
  %t57 = sitofp i64 %t56 to double
  %t58 = fcmp oge double %t53, %t57
  %t59 = load %LexerState, %LexerState* %l0
  %t60 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t61 = load i8*, i8** %l2
  %t62 = load double, double* %l3
  %t63 = load double, double* %l4
  %t64 = load double, double* %l5
  br i1 %t58, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t65 = load %LexerState, %LexerState* %l0
  %t66 = extractvalue %LexerState %t65, 0
  %t67 = load %LexerState, %LexerState* %l0
  %t68 = extractvalue %LexerState %t67, 1
  %t69 = call i8* @char_at(i8* %t66, double %t68)
  %t70 = call i1 @is_whitespace(i8* %t69)
  %t71 = xor i1 %t70, 1
  %t72 = load %LexerState, %LexerState* %l0
  %t73 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t74 = load i8*, i8** %l2
  %t75 = load double, double* %l3
  %t76 = load double, double* %l4
  %t77 = load double, double* %l5
  br i1 %t71, label %then14, label %merge15
then14:
  br label %afterloop11
merge15:
  %t78 = load %LexerState, %LexerState* %l0
  %t79 = extractvalue %LexerState %t78, 0
  %t80 = load %LexerState, %LexerState* %l0
  %t81 = extractvalue %LexerState %t80, 1
  %t82 = call i8* @char_at(i8* %t79, double %t81)
  %t83 = load i8, i8* %t82
  %t84 = icmp eq i8 %t83, 10
  %t85 = load %LexerState, %LexerState* %l0
  %t86 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t87 = load i8*, i8** %l2
  %t88 = load double, double* %l3
  %t89 = load double, double* %l4
  %t90 = load double, double* %l5
  br i1 %t84, label %then16, label %else17
then16:
  %t91 = load %LexerState, %LexerState* %l0
  %t92 = extractvalue %LexerState %t91, 1
  %t93 = sitofp i64 1 to double
  %t94 = fadd double %t92, %t93
  %t95 = load %LexerState, %LexerState* %l0
  %t96 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t94, double* %t96
  %t97 = load %LexerState, %LexerState* %l0
  %t98 = extractvalue %LexerState %t97, 2
  %t99 = sitofp i64 1 to double
  %t100 = fadd double %t98, %t99
  %t101 = load %LexerState, %LexerState* %l0
  %t102 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 2
  store double %t100, double* %t102
  %t103 = load %LexerState, %LexerState* %l0
  %t104 = sitofp i64 1 to double
  %t105 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t104, double* %t105
  br label %merge18
else17:
  %t106 = load %LexerState, %LexerState* %l0
  %t107 = extractvalue %LexerState %t106, 1
  %t108 = sitofp i64 1 to double
  %t109 = fadd double %t107, %t108
  %t110 = load %LexerState, %LexerState* %l0
  %t111 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t109, double* %t111
  %t112 = load %LexerState, %LexerState* %l0
  %t113 = extractvalue %LexerState %t112, 3
  %t114 = sitofp i64 1 to double
  %t115 = fadd double %t113, %t114
  %t116 = load %LexerState, %LexerState* %l0
  %t117 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t115, double* %t117
  br label %merge18
merge18:
  br label %loop.latch10
loop.latch10:
  br label %loop.header8
afterloop11:
  %t118 = load %LexerState, %LexerState* %l0
  %t119 = extractvalue %LexerState %t118, 0
  %t120 = load double, double* %l3
  %t121 = load %LexerState, %LexerState* %l0
  %t122 = extractvalue %LexerState %t121, 1
  %t123 = call i8* @slice(i8* %t119, double %t120, double %t122)
  store i8* %t123, i8** %l6
  %t124 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t125 = insertvalue %TokenKind undef, i32 5, 0
  %t126 = insertvalue %Token undef, %TokenKind %t125, 0
  %t127 = load i8*, i8** %l6
  %t128 = insertvalue %Token %t126, i8* %t127, 1
  %t129 = load double, double* %l4
  %t130 = insertvalue %Token %t128, double %t129, 2
  %t131 = load double, double* %l5
  %t132 = insertvalue %Token %t130, double %t131, 3
  %t133 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t124, %Token %t132)
  store { %Token*, i64 }* %t133, { %Token*, i64 }** %l1
  br label %loop.latch2
merge7:
  %t134 = load i8*, i8** %l2
  %t135 = load i8, i8* %t134
  %t136 = icmp eq i8 %t135, 47
  %t137 = load %LexerState, %LexerState* %l0
  %t138 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t139 = load i8*, i8** %l2
  br i1 %t136, label %then19, label %merge20
then19:
  %t140 = load %LexerState, %LexerState* %l0
  %t141 = call i8* @peek_next_char(%LexerState %t140)
  store i8* %t141, i8** %l7
  %t142 = load i8*, i8** %l7
  %t143 = load i8, i8* %t142
  %t144 = icmp eq i8 %t143, 47
  %t145 = load %LexerState, %LexerState* %l0
  %t146 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t147 = load i8*, i8** %l2
  %t148 = load i8*, i8** %l7
  br i1 %t144, label %then21, label %merge22
then21:
  %t149 = load %LexerState, %LexerState* %l0
  %t150 = extractvalue %LexerState %t149, 1
  store double %t150, double* %l8
  %t151 = load %LexerState, %LexerState* %l0
  %t152 = extractvalue %LexerState %t151, 2
  store double %t152, double* %l9
  %t153 = load %LexerState, %LexerState* %l0
  %t154 = extractvalue %LexerState %t153, 3
  store double %t154, double* %l10
  %t155 = load %LexerState, %LexerState* %l0
  %t156 = extractvalue %LexerState %t155, 1
  %t157 = sitofp i64 2 to double
  %t158 = fadd double %t156, %t157
  %t159 = load %LexerState, %LexerState* %l0
  %t160 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t158, double* %t160
  %t161 = load %LexerState, %LexerState* %l0
  %t162 = extractvalue %LexerState %t161, 3
  %t163 = sitofp i64 2 to double
  %t164 = fadd double %t162, %t163
  %t165 = load %LexerState, %LexerState* %l0
  %t166 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t164, double* %t166
  %t167 = load %LexerState, %LexerState* %l0
  %t168 = extractvalue %LexerState %t167, 0
  %t169 = call i64 @sailfin_runtime_string_length(i8* %t168)
  %t170 = sitofp i64 %t169 to double
  store double %t170, double* %l11
  %t171 = load %LexerState, %LexerState* %l0
  %t172 = extractvalue %LexerState %t171, 1
  store double %t172, double* %l12
  %t173 = load %LexerState, %LexerState* %l0
  %t174 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t175 = load i8*, i8** %l2
  %t176 = load i8*, i8** %l7
  %t177 = load double, double* %l8
  %t178 = load double, double* %l9
  %t179 = load double, double* %l10
  %t180 = load double, double* %l11
  %t181 = load double, double* %l12
  br label %loop.header23
loop.header23:
  %t225 = phi double [ %t180, %then21 ], [ %t223, %loop.latch25 ]
  %t226 = phi double [ %t181, %then21 ], [ %t224, %loop.latch25 ]
  store double %t225, double* %l11
  store double %t226, double* %l12
  br label %loop.body24
loop.body24:
  %t182 = load double, double* %l12
  %t183 = load %LexerState, %LexerState* %l0
  %t184 = extractvalue %LexerState %t183, 0
  %t185 = call i64 @sailfin_runtime_string_length(i8* %t184)
  %t186 = sitofp i64 %t185 to double
  %t187 = fcmp oge double %t182, %t186
  %t188 = load %LexerState, %LexerState* %l0
  %t189 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t190 = load i8*, i8** %l2
  %t191 = load i8*, i8** %l7
  %t192 = load double, double* %l8
  %t193 = load double, double* %l9
  %t194 = load double, double* %l10
  %t195 = load double, double* %l11
  %t196 = load double, double* %l12
  br i1 %t187, label %then27, label %merge28
then27:
  br label %afterloop26
merge28:
  %t197 = load %LexerState, %LexerState* %l0
  %t198 = extractvalue %LexerState %t197, 0
  %t199 = load double, double* %l12
  %t200 = call i8* @char_at(i8* %t198, double %t199)
  store i8* %t200, i8** %l13
  %t202 = load i8*, i8** %l13
  %t203 = load i8, i8* %t202
  %t204 = icmp eq i8 %t203, 10
  br label %logical_or_entry_201

logical_or_entry_201:
  br i1 %t204, label %logical_or_merge_201, label %logical_or_right_201

logical_or_right_201:
  %t205 = load i8*, i8** %l13
  %t206 = load i8, i8* %t205
  %t207 = icmp eq i8 %t206, 13
  br label %logical_or_right_end_201

logical_or_right_end_201:
  br label %logical_or_merge_201

logical_or_merge_201:
  %t208 = phi i1 [ true, %logical_or_entry_201 ], [ %t207, %logical_or_right_end_201 ]
  %t209 = load %LexerState, %LexerState* %l0
  %t210 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t211 = load i8*, i8** %l2
  %t212 = load i8*, i8** %l7
  %t213 = load double, double* %l8
  %t214 = load double, double* %l9
  %t215 = load double, double* %l10
  %t216 = load double, double* %l11
  %t217 = load double, double* %l12
  %t218 = load i8*, i8** %l13
  br i1 %t208, label %then29, label %merge30
then29:
  %t219 = load double, double* %l12
  store double %t219, double* %l11
  br label %afterloop26
merge30:
  %t220 = load double, double* %l12
  %t221 = sitofp i64 1 to double
  %t222 = fadd double %t220, %t221
  store double %t222, double* %l12
  br label %loop.latch25
loop.latch25:
  %t223 = load double, double* %l11
  %t224 = load double, double* %l12
  br label %loop.header23
afterloop26:
  %t227 = load double, double* %l11
  %t228 = load double, double* %l12
  %t229 = load %LexerState, %LexerState* %l0
  %t230 = extractvalue %LexerState %t229, 0
  %t231 = load double, double* %l8
  %t232 = load double, double* %l11
  %t233 = call i8* @slice(i8* %t230, double %t231, double %t232)
  store i8* %t233, i8** %l14
  %t234 = load double, double* %l11
  %t235 = load %LexerState, %LexerState* %l0
  %t236 = extractvalue %LexerState %t235, 1
  %t237 = fsub double %t234, %t236
  store double %t237, double* %l15
  %t238 = load double, double* %l11
  %t239 = load %LexerState, %LexerState* %l0
  %t240 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t238, double* %t240
  %t241 = load %LexerState, %LexerState* %l0
  %t242 = extractvalue %LexerState %t241, 3
  %t243 = load double, double* %l15
  %t244 = fadd double %t242, %t243
  %t245 = load %LexerState, %LexerState* %l0
  %t246 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t244, double* %t246
  %t247 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t248 = insertvalue %TokenKind undef, i32 6, 0
  %t249 = insertvalue %Token undef, %TokenKind %t248, 0
  %t250 = load i8*, i8** %l14
  %t251 = insertvalue %Token %t249, i8* %t250, 1
  %t252 = load double, double* %l9
  %t253 = insertvalue %Token %t251, double %t252, 2
  %t254 = load double, double* %l10
  %t255 = insertvalue %Token %t253, double %t254, 3
  %t256 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t247, %Token %t255)
  store { %Token*, i64 }* %t256, { %Token*, i64 }** %l1
  br label %loop.latch2
merge22:
  %t257 = load i8*, i8** %l7
  %t258 = load i8, i8* %t257
  %t259 = icmp eq i8 %t258, 42
  %t260 = load %LexerState, %LexerState* %l0
  %t261 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t262 = load i8*, i8** %l2
  %t263 = load i8*, i8** %l7
  br i1 %t259, label %then31, label %merge32
then31:
  %t264 = load %LexerState, %LexerState* %l0
  %t265 = extractvalue %LexerState %t264, 1
  store double %t265, double* %l16
  %t266 = load %LexerState, %LexerState* %l0
  %t267 = extractvalue %LexerState %t266, 2
  store double %t267, double* %l17
  %t268 = load %LexerState, %LexerState* %l0
  %t269 = extractvalue %LexerState %t268, 3
  store double %t269, double* %l18
  %t270 = load %LexerState, %LexerState* %l0
  %t271 = extractvalue %LexerState %t270, 1
  %t272 = sitofp i64 2 to double
  %t273 = fadd double %t271, %t272
  %t274 = load %LexerState, %LexerState* %l0
  %t275 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t273, double* %t275
  %t276 = load %LexerState, %LexerState* %l0
  %t277 = extractvalue %LexerState %t276, 3
  %t278 = sitofp i64 2 to double
  %t279 = fadd double %t277, %t278
  %t280 = load %LexerState, %LexerState* %l0
  %t281 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t279, double* %t281
  %t282 = load %LexerState, %LexerState* %l0
  %t283 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t284 = load i8*, i8** %l2
  %t285 = load i8*, i8** %l7
  %t286 = load double, double* %l16
  %t287 = load double, double* %l17
  %t288 = load double, double* %l18
  br label %loop.header33
loop.header33:
  br label %loop.body34
loop.body34:
  %t289 = load %LexerState, %LexerState* %l0
  %t290 = extractvalue %LexerState %t289, 1
  %t291 = load %LexerState, %LexerState* %l0
  %t292 = extractvalue %LexerState %t291, 0
  %t293 = call i64 @sailfin_runtime_string_length(i8* %t292)
  %t294 = sitofp i64 %t293 to double
  %t295 = fcmp oge double %t290, %t294
  %t296 = load %LexerState, %LexerState* %l0
  %t297 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t298 = load i8*, i8** %l2
  %t299 = load i8*, i8** %l7
  %t300 = load double, double* %l16
  %t301 = load double, double* %l17
  %t302 = load double, double* %l18
  br i1 %t295, label %then37, label %merge38
then37:
  br label %afterloop36
merge38:
  %t304 = load %LexerState, %LexerState* %l0
  %t305 = extractvalue %LexerState %t304, 0
  %t306 = load %LexerState, %LexerState* %l0
  %t307 = extractvalue %LexerState %t306, 1
  %t308 = call i8* @char_at(i8* %t305, double %t307)
  %t309 = load i8, i8* %t308
  %t310 = icmp eq i8 %t309, 42
  br label %logical_and_entry_303

logical_and_entry_303:
  br i1 %t310, label %logical_and_right_303, label %logical_and_merge_303

logical_and_right_303:
  %t311 = load %LexerState, %LexerState* %l0
  %t312 = call i8* @peek_next_char(%LexerState %t311)
  %t313 = load i8, i8* %t312
  %t314 = icmp eq i8 %t313, 47
  br label %logical_and_right_end_303

logical_and_right_end_303:
  br label %logical_and_merge_303

logical_and_merge_303:
  %t315 = phi i1 [ false, %logical_and_entry_303 ], [ %t314, %logical_and_right_end_303 ]
  %t316 = load %LexerState, %LexerState* %l0
  %t317 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t318 = load i8*, i8** %l2
  %t319 = load i8*, i8** %l7
  %t320 = load double, double* %l16
  %t321 = load double, double* %l17
  %t322 = load double, double* %l18
  br i1 %t315, label %then39, label %merge40
then39:
  %t323 = load %LexerState, %LexerState* %l0
  %t324 = extractvalue %LexerState %t323, 1
  %t325 = sitofp i64 2 to double
  %t326 = fadd double %t324, %t325
  %t327 = load %LexerState, %LexerState* %l0
  %t328 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t326, double* %t328
  %t329 = load %LexerState, %LexerState* %l0
  %t330 = extractvalue %LexerState %t329, 3
  %t331 = sitofp i64 2 to double
  %t332 = fadd double %t330, %t331
  %t333 = load %LexerState, %LexerState* %l0
  %t334 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t332, double* %t334
  br label %afterloop36
merge40:
  %t335 = load %LexerState, %LexerState* %l0
  %t336 = extractvalue %LexerState %t335, 0
  %t337 = load %LexerState, %LexerState* %l0
  %t338 = extractvalue %LexerState %t337, 1
  %t339 = call i8* @char_at(i8* %t336, double %t338)
  %t340 = load i8, i8* %t339
  %t341 = icmp eq i8 %t340, 10
  %t342 = load %LexerState, %LexerState* %l0
  %t343 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t344 = load i8*, i8** %l2
  %t345 = load i8*, i8** %l7
  %t346 = load double, double* %l16
  %t347 = load double, double* %l17
  %t348 = load double, double* %l18
  br i1 %t341, label %then41, label %else42
then41:
  %t349 = load %LexerState, %LexerState* %l0
  %t350 = extractvalue %LexerState %t349, 1
  %t351 = sitofp i64 1 to double
  %t352 = fadd double %t350, %t351
  %t353 = load %LexerState, %LexerState* %l0
  %t354 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t352, double* %t354
  %t355 = load %LexerState, %LexerState* %l0
  %t356 = extractvalue %LexerState %t355, 2
  %t357 = sitofp i64 1 to double
  %t358 = fadd double %t356, %t357
  %t359 = load %LexerState, %LexerState* %l0
  %t360 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 2
  store double %t358, double* %t360
  %t361 = load %LexerState, %LexerState* %l0
  %t362 = sitofp i64 1 to double
  %t363 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t362, double* %t363
  br label %merge43
else42:
  %t364 = load %LexerState, %LexerState* %l0
  %t365 = extractvalue %LexerState %t364, 1
  %t366 = sitofp i64 1 to double
  %t367 = fadd double %t365, %t366
  %t368 = load %LexerState, %LexerState* %l0
  %t369 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t367, double* %t369
  %t370 = load %LexerState, %LexerState* %l0
  %t371 = extractvalue %LexerState %t370, 3
  %t372 = sitofp i64 1 to double
  %t373 = fadd double %t371, %t372
  %t374 = load %LexerState, %LexerState* %l0
  %t375 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t373, double* %t375
  br label %merge43
merge43:
  br label %loop.latch35
loop.latch35:
  br label %loop.header33
afterloop36:
  %t376 = load %LexerState, %LexerState* %l0
  %t377 = extractvalue %LexerState %t376, 0
  %t378 = load double, double* %l16
  %t379 = load %LexerState, %LexerState* %l0
  %t380 = extractvalue %LexerState %t379, 1
  %t381 = call i8* @slice(i8* %t377, double %t378, double %t380)
  store i8* %t381, i8** %l19
  %t382 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t383 = insertvalue %TokenKind undef, i32 6, 0
  %t384 = insertvalue %Token undef, %TokenKind %t383, 0
  %t385 = load i8*, i8** %l19
  %t386 = insertvalue %Token %t384, i8* %t385, 1
  %t387 = load double, double* %l17
  %t388 = insertvalue %Token %t386, double %t387, 2
  %t389 = load double, double* %l18
  %t390 = insertvalue %Token %t388, double %t389, 3
  %t391 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t382, %Token %t390)
  store { %Token*, i64 }* %t391, { %Token*, i64 }** %l1
  br label %loop.latch2
merge32:
  %t392 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t393 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br label %merge20
merge20:
  %t394 = phi { %Token*, i64 }* [ %t392, %merge32 ], [ %t138, %merge7 ]
  %t395 = phi { %Token*, i64 }* [ %t393, %merge32 ], [ %t138, %merge7 ]
  store { %Token*, i64 }* %t394, { %Token*, i64 }** %l1
  store { %Token*, i64 }* %t395, { %Token*, i64 }** %l1
  %t396 = load i8*, i8** %l2
  %t397 = call i1 @is_double_quote(i8* %t396)
  %t398 = load %LexerState, %LexerState* %l0
  %t399 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t400 = load i8*, i8** %l2
  br i1 %t397, label %then44, label %merge45
then44:
  %t401 = load %LexerState, %LexerState* %l0
  %t402 = extractvalue %LexerState %t401, 1
  store double %t402, double* %l20
  %t403 = load %LexerState, %LexerState* %l0
  %t404 = extractvalue %LexerState %t403, 2
  store double %t404, double* %l21
  %t405 = load %LexerState, %LexerState* %l0
  %t406 = extractvalue %LexerState %t405, 3
  store double %t406, double* %l22
  %t407 = load %LexerState, %LexerState* %l0
  %t408 = extractvalue %LexerState %t407, 1
  %t409 = sitofp i64 1 to double
  %t410 = fadd double %t408, %t409
  %t411 = load %LexerState, %LexerState* %l0
  %t412 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t410, double* %t412
  %t413 = load %LexerState, %LexerState* %l0
  %t414 = extractvalue %LexerState %t413, 3
  %t415 = sitofp i64 1 to double
  %t416 = fadd double %t414, %t415
  %t417 = load %LexerState, %LexerState* %l0
  %t418 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t416, double* %t418
  %t419 = call i8* @malloc(i64 1)
  %t420 = bitcast i8* %t419 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t420
  store i8* %t419, i8** %l23
  store i1 0, i1* %l24
  %t421 = load %LexerState, %LexerState* %l0
  %t422 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t423 = load i8*, i8** %l2
  %t424 = load double, double* %l20
  %t425 = load double, double* %l21
  %t426 = load double, double* %l22
  %t427 = load i8*, i8** %l23
  %t428 = load i1, i1* %l24
  br label %loop.header46
loop.header46:
  %t566 = phi i1 [ %t428, %then44 ], [ %t564, %loop.latch48 ]
  %t567 = phi i8* [ %t427, %then44 ], [ %t565, %loop.latch48 ]
  store i1 %t566, i1* %l24
  store i8* %t567, i8** %l23
  br label %loop.body47
loop.body47:
  %t429 = load %LexerState, %LexerState* %l0
  %t430 = extractvalue %LexerState %t429, 1
  %t431 = load %LexerState, %LexerState* %l0
  %t432 = extractvalue %LexerState %t431, 0
  %t433 = call i64 @sailfin_runtime_string_length(i8* %t432)
  %t434 = sitofp i64 %t433 to double
  %t435 = fcmp oge double %t430, %t434
  %t436 = load %LexerState, %LexerState* %l0
  %t437 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t438 = load i8*, i8** %l2
  %t439 = load double, double* %l20
  %t440 = load double, double* %l21
  %t441 = load double, double* %l22
  %t442 = load i8*, i8** %l23
  %t443 = load i1, i1* %l24
  br i1 %t435, label %then50, label %merge51
then50:
  br label %afterloop49
merge51:
  %t444 = load %LexerState, %LexerState* %l0
  %t445 = extractvalue %LexerState %t444, 0
  %t446 = load %LexerState, %LexerState* %l0
  %t447 = extractvalue %LexerState %t446, 1
  %t448 = call i8* @char_at(i8* %t445, double %t447)
  store i8* %t448, i8** %l25
  %t450 = load i1, i1* %l24
  %t451 = xor i1 %t450, 1
  br label %logical_and_entry_449

logical_and_entry_449:
  br i1 %t451, label %logical_and_right_449, label %logical_and_merge_449

logical_and_right_449:
  %t452 = load i8*, i8** %l25
  %t453 = call i1 @is_double_quote(i8* %t452)
  br label %logical_and_right_end_449

logical_and_right_end_449:
  br label %logical_and_merge_449

logical_and_merge_449:
  %t454 = phi i1 [ false, %logical_and_entry_449 ], [ %t453, %logical_and_right_end_449 ]
  %t455 = load %LexerState, %LexerState* %l0
  %t456 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t457 = load i8*, i8** %l2
  %t458 = load double, double* %l20
  %t459 = load double, double* %l21
  %t460 = load double, double* %l22
  %t461 = load i8*, i8** %l23
  %t462 = load i1, i1* %l24
  %t463 = load i8*, i8** %l25
  br i1 %t454, label %then52, label %merge53
then52:
  %t464 = load %LexerState, %LexerState* %l0
  %t465 = extractvalue %LexerState %t464, 1
  %t466 = sitofp i64 1 to double
  %t467 = fadd double %t465, %t466
  %t468 = load %LexerState, %LexerState* %l0
  %t469 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t467, double* %t469
  %t470 = load %LexerState, %LexerState* %l0
  %t471 = extractvalue %LexerState %t470, 3
  %t472 = sitofp i64 1 to double
  %t473 = fadd double %t471, %t472
  %t474 = load %LexerState, %LexerState* %l0
  %t475 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t473, double* %t475
  br label %afterloop49
merge53:
  %t477 = load i1, i1* %l24
  %t478 = xor i1 %t477, 1
  br label %logical_and_entry_476

logical_and_entry_476:
  br i1 %t478, label %logical_and_right_476, label %logical_and_merge_476

logical_and_right_476:
  %t479 = load i8*, i8** %l25
  %t480 = call i1 @is_backslash(i8* %t479)
  br label %logical_and_right_end_476

logical_and_right_end_476:
  br label %logical_and_merge_476

logical_and_merge_476:
  %t481 = phi i1 [ false, %logical_and_entry_476 ], [ %t480, %logical_and_right_end_476 ]
  %t482 = load %LexerState, %LexerState* %l0
  %t483 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t484 = load i8*, i8** %l2
  %t485 = load double, double* %l20
  %t486 = load double, double* %l21
  %t487 = load double, double* %l22
  %t488 = load i8*, i8** %l23
  %t489 = load i1, i1* %l24
  %t490 = load i8*, i8** %l25
  br i1 %t481, label %then54, label %merge55
then54:
  store i1 1, i1* %l24
  %t491 = load %LexerState, %LexerState* %l0
  %t492 = extractvalue %LexerState %t491, 1
  %t493 = sitofp i64 1 to double
  %t494 = fadd double %t492, %t493
  %t495 = load %LexerState, %LexerState* %l0
  %t496 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t494, double* %t496
  %t497 = load %LexerState, %LexerState* %l0
  %t498 = extractvalue %LexerState %t497, 3
  %t499 = sitofp i64 1 to double
  %t500 = fadd double %t498, %t499
  %t501 = load %LexerState, %LexerState* %l0
  %t502 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t500, double* %t502
  br label %loop.latch48
merge55:
  %t503 = load i1, i1* %l24
  %t504 = load %LexerState, %LexerState* %l0
  %t505 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t506 = load i8*, i8** %l2
  %t507 = load double, double* %l20
  %t508 = load double, double* %l21
  %t509 = load double, double* %l22
  %t510 = load i8*, i8** %l23
  %t511 = load i1, i1* %l24
  %t512 = load i8*, i8** %l25
  br i1 %t503, label %then56, label %else57
then56:
  %t513 = load i8*, i8** %l23
  %t514 = load i8*, i8** %l25
  %t515 = call i8* @interpret_escape(i8* %t514)
  %t516 = call i8* @sailfin_runtime_string_concat(i8* %t513, i8* %t515)
  store i8* %t516, i8** %l23
  store i1 0, i1* %l24
  %t517 = load i8*, i8** %l23
  %t518 = load i1, i1* %l24
  br label %merge58
else57:
  %t519 = load i8*, i8** %l23
  %t520 = load i8*, i8** %l25
  %t521 = call i8* @sailfin_runtime_string_concat(i8* %t519, i8* %t520)
  store i8* %t521, i8** %l23
  %t522 = load i8*, i8** %l23
  br label %merge58
merge58:
  %t523 = phi i8* [ %t517, %then56 ], [ %t522, %else57 ]
  %t524 = phi i1 [ %t518, %then56 ], [ %t511, %else57 ]
  store i8* %t523, i8** %l23
  store i1 %t524, i1* %l24
  %t525 = load i8*, i8** %l25
  %t526 = load i8, i8* %t525
  %t527 = icmp eq i8 %t526, 10
  %t528 = load %LexerState, %LexerState* %l0
  %t529 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t530 = load i8*, i8** %l2
  %t531 = load double, double* %l20
  %t532 = load double, double* %l21
  %t533 = load double, double* %l22
  %t534 = load i8*, i8** %l23
  %t535 = load i1, i1* %l24
  %t536 = load i8*, i8** %l25
  br i1 %t527, label %then59, label %else60
then59:
  %t537 = load %LexerState, %LexerState* %l0
  %t538 = extractvalue %LexerState %t537, 1
  %t539 = sitofp i64 1 to double
  %t540 = fadd double %t538, %t539
  %t541 = load %LexerState, %LexerState* %l0
  %t542 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t540, double* %t542
  %t543 = load %LexerState, %LexerState* %l0
  %t544 = extractvalue %LexerState %t543, 2
  %t545 = sitofp i64 1 to double
  %t546 = fadd double %t544, %t545
  %t547 = load %LexerState, %LexerState* %l0
  %t548 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 2
  store double %t546, double* %t548
  %t549 = load %LexerState, %LexerState* %l0
  %t550 = sitofp i64 1 to double
  %t551 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t550, double* %t551
  br label %merge61
else60:
  %t552 = load %LexerState, %LexerState* %l0
  %t553 = extractvalue %LexerState %t552, 1
  %t554 = sitofp i64 1 to double
  %t555 = fadd double %t553, %t554
  %t556 = load %LexerState, %LexerState* %l0
  %t557 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t555, double* %t557
  %t558 = load %LexerState, %LexerState* %l0
  %t559 = extractvalue %LexerState %t558, 3
  %t560 = sitofp i64 1 to double
  %t561 = fadd double %t559, %t560
  %t562 = load %LexerState, %LexerState* %l0
  %t563 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t561, double* %t563
  br label %merge61
merge61:
  br label %loop.latch48
loop.latch48:
  %t564 = load i1, i1* %l24
  %t565 = load i8*, i8** %l23
  br label %loop.header46
afterloop49:
  %t568 = load i1, i1* %l24
  %t569 = load i8*, i8** %l23
  %t570 = load %LexerState, %LexerState* %l0
  %t571 = extractvalue %LexerState %t570, 0
  %t572 = load double, double* %l20
  %t573 = load %LexerState, %LexerState* %l0
  %t574 = extractvalue %LexerState %t573, 1
  %t575 = call i8* @slice(i8* %t571, double %t572, double %t574)
  store i8* %t575, i8** %l26
  %t576 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t577 = insertvalue %TokenKind undef, i32 2, 0
  %t578 = insertvalue %Token undef, %TokenKind %t577, 0
  %t579 = load i8*, i8** %l26
  %t580 = insertvalue %Token %t578, i8* %t579, 1
  %t581 = load double, double* %l21
  %t582 = insertvalue %Token %t580, double %t581, 2
  %t583 = load double, double* %l22
  %t584 = insertvalue %Token %t582, double %t583, 3
  %t585 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t576, %Token %t584)
  store { %Token*, i64 }* %t585, { %Token*, i64 }** %l1
  br label %loop.latch2
merge45:
  %t586 = load i8*, i8** %l2
  %t587 = call i1 @is_digit(i8* %t586)
  %t588 = load %LexerState, %LexerState* %l0
  %t589 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t590 = load i8*, i8** %l2
  br i1 %t587, label %then62, label %merge63
then62:
  %t591 = load %LexerState, %LexerState* %l0
  %t592 = extractvalue %LexerState %t591, 1
  store double %t592, double* %l27
  %t593 = load %LexerState, %LexerState* %l0
  %t594 = extractvalue %LexerState %t593, 2
  store double %t594, double* %l28
  %t595 = load %LexerState, %LexerState* %l0
  %t596 = extractvalue %LexerState %t595, 3
  store double %t596, double* %l29
  %t597 = load %LexerState, %LexerState* %l0
  %t598 = extractvalue %LexerState %t597, 1
  %t599 = sitofp i64 1 to double
  %t600 = fadd double %t598, %t599
  %t601 = load %LexerState, %LexerState* %l0
  %t602 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t600, double* %t602
  %t603 = load %LexerState, %LexerState* %l0
  %t604 = extractvalue %LexerState %t603, 3
  %t605 = sitofp i64 1 to double
  %t606 = fadd double %t604, %t605
  %t607 = load %LexerState, %LexerState* %l0
  %t608 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t606, double* %t608
  %t609 = load %LexerState, %LexerState* %l0
  %t610 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t611 = load i8*, i8** %l2
  %t612 = load double, double* %l27
  %t613 = load double, double* %l28
  %t614 = load double, double* %l29
  br label %loop.header64
loop.header64:
  br label %loop.body65
loop.body65:
  %t615 = load %LexerState, %LexerState* %l0
  %t616 = extractvalue %LexerState %t615, 1
  %t617 = load %LexerState, %LexerState* %l0
  %t618 = extractvalue %LexerState %t617, 0
  %t619 = call i64 @sailfin_runtime_string_length(i8* %t618)
  %t620 = sitofp i64 %t619 to double
  %t621 = fcmp oge double %t616, %t620
  %t622 = load %LexerState, %LexerState* %l0
  %t623 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t624 = load i8*, i8** %l2
  %t625 = load double, double* %l27
  %t626 = load double, double* %l28
  %t627 = load double, double* %l29
  br i1 %t621, label %then68, label %merge69
then68:
  br label %afterloop67
merge69:
  %t628 = load %LexerState, %LexerState* %l0
  %t629 = extractvalue %LexerState %t628, 0
  %t630 = load %LexerState, %LexerState* %l0
  %t631 = extractvalue %LexerState %t630, 1
  %t632 = call i8* @char_at(i8* %t629, double %t631)
  %t633 = call i1 @is_digit(i8* %t632)
  %t634 = xor i1 %t633, 1
  %t635 = load %LexerState, %LexerState* %l0
  %t636 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t637 = load i8*, i8** %l2
  %t638 = load double, double* %l27
  %t639 = load double, double* %l28
  %t640 = load double, double* %l29
  br i1 %t634, label %then70, label %merge71
then70:
  br label %afterloop67
merge71:
  %t641 = load %LexerState, %LexerState* %l0
  %t642 = extractvalue %LexerState %t641, 1
  %t643 = sitofp i64 1 to double
  %t644 = fadd double %t642, %t643
  %t645 = load %LexerState, %LexerState* %l0
  %t646 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t644, double* %t646
  %t647 = load %LexerState, %LexerState* %l0
  %t648 = extractvalue %LexerState %t647, 3
  %t649 = sitofp i64 1 to double
  %t650 = fadd double %t648, %t649
  %t651 = load %LexerState, %LexerState* %l0
  %t652 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t650, double* %t652
  br label %loop.latch66
loop.latch66:
  br label %loop.header64
afterloop67:
  %t654 = load %LexerState, %LexerState* %l0
  %t655 = extractvalue %LexerState %t654, 1
  %t656 = load %LexerState, %LexerState* %l0
  %t657 = extractvalue %LexerState %t656, 0
  %t658 = call i64 @sailfin_runtime_string_length(i8* %t657)
  %t659 = sitofp i64 %t658 to double
  %t660 = fcmp olt double %t655, %t659
  br label %logical_and_entry_653

logical_and_entry_653:
  br i1 %t660, label %logical_and_right_653, label %logical_and_merge_653

logical_and_right_653:
  %t661 = load %LexerState, %LexerState* %l0
  %t662 = extractvalue %LexerState %t661, 0
  %t663 = load %LexerState, %LexerState* %l0
  %t664 = extractvalue %LexerState %t663, 1
  %t665 = call i8* @char_at(i8* %t662, double %t664)
  %t666 = load i8, i8* %t665
  %t667 = icmp eq i8 %t666, 46
  br label %logical_and_right_end_653

logical_and_right_end_653:
  br label %logical_and_merge_653

logical_and_merge_653:
  %t668 = phi i1 [ false, %logical_and_entry_653 ], [ %t667, %logical_and_right_end_653 ]
  %t669 = load %LexerState, %LexerState* %l0
  %t670 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t671 = load i8*, i8** %l2
  %t672 = load double, double* %l27
  %t673 = load double, double* %l28
  %t674 = load double, double* %l29
  br i1 %t668, label %then72, label %merge73
then72:
  %t676 = load %LexerState, %LexerState* %l0
  %t677 = extractvalue %LexerState %t676, 1
  %t678 = sitofp i64 1 to double
  %t679 = fadd double %t677, %t678
  %t680 = load %LexerState, %LexerState* %l0
  %t681 = extractvalue %LexerState %t680, 0
  %t682 = call i64 @sailfin_runtime_string_length(i8* %t681)
  %t683 = sitofp i64 %t682 to double
  %t684 = fcmp olt double %t679, %t683
  br label %logical_and_entry_675

logical_and_entry_675:
  br i1 %t684, label %logical_and_right_675, label %logical_and_merge_675

logical_and_right_675:
  %t685 = load %LexerState, %LexerState* %l0
  %t686 = extractvalue %LexerState %t685, 0
  %t687 = load %LexerState, %LexerState* %l0
  %t688 = extractvalue %LexerState %t687, 1
  %t689 = sitofp i64 1 to double
  %t690 = fadd double %t688, %t689
  %t691 = call i8* @char_at(i8* %t686, double %t690)
  %t692 = call i1 @is_digit(i8* %t691)
  br label %logical_and_right_end_675

logical_and_right_end_675:
  br label %logical_and_merge_675

logical_and_merge_675:
  %t693 = phi i1 [ false, %logical_and_entry_675 ], [ %t692, %logical_and_right_end_675 ]
  store i1 %t693, i1* %l30
  %t694 = load i1, i1* %l30
  %t695 = load %LexerState, %LexerState* %l0
  %t696 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t697 = load i8*, i8** %l2
  %t698 = load double, double* %l27
  %t699 = load double, double* %l28
  %t700 = load double, double* %l29
  %t701 = load i1, i1* %l30
  br i1 %t694, label %then74, label %merge75
then74:
  %t702 = load %LexerState, %LexerState* %l0
  %t703 = extractvalue %LexerState %t702, 1
  %t704 = sitofp i64 1 to double
  %t705 = fadd double %t703, %t704
  %t706 = load %LexerState, %LexerState* %l0
  %t707 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t705, double* %t707
  %t708 = load %LexerState, %LexerState* %l0
  %t709 = extractvalue %LexerState %t708, 3
  %t710 = sitofp i64 1 to double
  %t711 = fadd double %t709, %t710
  %t712 = load %LexerState, %LexerState* %l0
  %t713 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t711, double* %t713
  %t714 = load %LexerState, %LexerState* %l0
  %t715 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t716 = load i8*, i8** %l2
  %t717 = load double, double* %l27
  %t718 = load double, double* %l28
  %t719 = load double, double* %l29
  %t720 = load i1, i1* %l30
  br label %loop.header76
loop.header76:
  br label %loop.body77
loop.body77:
  %t721 = load %LexerState, %LexerState* %l0
  %t722 = extractvalue %LexerState %t721, 1
  %t723 = load %LexerState, %LexerState* %l0
  %t724 = extractvalue %LexerState %t723, 0
  %t725 = call i64 @sailfin_runtime_string_length(i8* %t724)
  %t726 = sitofp i64 %t725 to double
  %t727 = fcmp oge double %t722, %t726
  %t728 = load %LexerState, %LexerState* %l0
  %t729 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t730 = load i8*, i8** %l2
  %t731 = load double, double* %l27
  %t732 = load double, double* %l28
  %t733 = load double, double* %l29
  %t734 = load i1, i1* %l30
  br i1 %t727, label %then80, label %merge81
then80:
  br label %afterloop79
merge81:
  %t735 = load %LexerState, %LexerState* %l0
  %t736 = extractvalue %LexerState %t735, 0
  %t737 = load %LexerState, %LexerState* %l0
  %t738 = extractvalue %LexerState %t737, 1
  %t739 = call i8* @char_at(i8* %t736, double %t738)
  %t740 = call i1 @is_digit(i8* %t739)
  %t741 = xor i1 %t740, 1
  %t742 = load %LexerState, %LexerState* %l0
  %t743 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t744 = load i8*, i8** %l2
  %t745 = load double, double* %l27
  %t746 = load double, double* %l28
  %t747 = load double, double* %l29
  %t748 = load i1, i1* %l30
  br i1 %t741, label %then82, label %merge83
then82:
  br label %afterloop79
merge83:
  %t749 = load %LexerState, %LexerState* %l0
  %t750 = extractvalue %LexerState %t749, 1
  %t751 = sitofp i64 1 to double
  %t752 = fadd double %t750, %t751
  %t753 = load %LexerState, %LexerState* %l0
  %t754 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t752, double* %t754
  %t755 = load %LexerState, %LexerState* %l0
  %t756 = extractvalue %LexerState %t755, 3
  %t757 = sitofp i64 1 to double
  %t758 = fadd double %t756, %t757
  %t759 = load %LexerState, %LexerState* %l0
  %t760 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t758, double* %t760
  br label %loop.latch78
loop.latch78:
  br label %loop.header76
afterloop79:
  br label %merge75
merge75:
  br label %merge73
merge73:
  %t761 = load %LexerState, %LexerState* %l0
  %t762 = extractvalue %LexerState %t761, 0
  %t763 = load double, double* %l27
  %t764 = load %LexerState, %LexerState* %l0
  %t765 = extractvalue %LexerState %t764, 1
  %t766 = call i8* @slice(i8* %t762, double %t763, double %t765)
  store i8* %t766, i8** %l31
  %t767 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t768 = insertvalue %TokenKind undef, i32 1, 0
  %t769 = insertvalue %Token undef, %TokenKind %t768, 0
  %t770 = load i8*, i8** %l31
  %t771 = insertvalue %Token %t769, i8* %t770, 1
  %t772 = load double, double* %l28
  %t773 = insertvalue %Token %t771, double %t772, 2
  %t774 = load double, double* %l29
  %t775 = insertvalue %Token %t773, double %t774, 3
  %t776 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t767, %Token %t775)
  store { %Token*, i64 }* %t776, { %Token*, i64 }** %l1
  br label %loop.latch2
merge63:
  %t777 = load i8*, i8** %l2
  %t778 = call i1 @is_identifier_start(i8* %t777)
  %t779 = load %LexerState, %LexerState* %l0
  %t780 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t781 = load i8*, i8** %l2
  br i1 %t778, label %then84, label %merge85
then84:
  %t782 = load %LexerState, %LexerState* %l0
  %t783 = extractvalue %LexerState %t782, 1
  store double %t783, double* %l32
  %t784 = load %LexerState, %LexerState* %l0
  %t785 = extractvalue %LexerState %t784, 2
  store double %t785, double* %l33
  %t786 = load %LexerState, %LexerState* %l0
  %t787 = extractvalue %LexerState %t786, 3
  store double %t787, double* %l34
  %t788 = load %LexerState, %LexerState* %l0
  %t789 = extractvalue %LexerState %t788, 1
  %t790 = sitofp i64 1 to double
  %t791 = fadd double %t789, %t790
  %t792 = load %LexerState, %LexerState* %l0
  %t793 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t791, double* %t793
  %t794 = load %LexerState, %LexerState* %l0
  %t795 = extractvalue %LexerState %t794, 3
  %t796 = sitofp i64 1 to double
  %t797 = fadd double %t795, %t796
  %t798 = load %LexerState, %LexerState* %l0
  %t799 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t797, double* %t799
  %t800 = load %LexerState, %LexerState* %l0
  %t801 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t802 = load i8*, i8** %l2
  %t803 = load double, double* %l32
  %t804 = load double, double* %l33
  %t805 = load double, double* %l34
  br label %loop.header86
loop.header86:
  br label %loop.body87
loop.body87:
  %t806 = load %LexerState, %LexerState* %l0
  %t807 = extractvalue %LexerState %t806, 1
  %t808 = load %LexerState, %LexerState* %l0
  %t809 = extractvalue %LexerState %t808, 0
  %t810 = call i64 @sailfin_runtime_string_length(i8* %t809)
  %t811 = sitofp i64 %t810 to double
  %t812 = fcmp oge double %t807, %t811
  %t813 = load %LexerState, %LexerState* %l0
  %t814 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t815 = load i8*, i8** %l2
  %t816 = load double, double* %l32
  %t817 = load double, double* %l33
  %t818 = load double, double* %l34
  br i1 %t812, label %then90, label %merge91
then90:
  br label %afterloop89
merge91:
  %t819 = load %LexerState, %LexerState* %l0
  %t820 = extractvalue %LexerState %t819, 0
  %t821 = load %LexerState, %LexerState* %l0
  %t822 = extractvalue %LexerState %t821, 1
  %t823 = call i8* @char_at(i8* %t820, double %t822)
  %t824 = call i1 @is_identifier_part(i8* %t823)
  %t825 = xor i1 %t824, 1
  %t826 = load %LexerState, %LexerState* %l0
  %t827 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t828 = load i8*, i8** %l2
  %t829 = load double, double* %l32
  %t830 = load double, double* %l33
  %t831 = load double, double* %l34
  br i1 %t825, label %then92, label %merge93
then92:
  br label %afterloop89
merge93:
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
  br label %loop.latch88
loop.latch88:
  br label %loop.header86
afterloop89:
  %t844 = load %LexerState, %LexerState* %l0
  %t845 = extractvalue %LexerState %t844, 0
  %t846 = load double, double* %l32
  %t847 = load %LexerState, %LexerState* %l0
  %t848 = extractvalue %LexerState %t847, 1
  %t849 = call i8* @slice(i8* %t845, double %t846, double %t848)
  store i8* %t849, i8** %l35
  %t851 = load i8*, i8** %l35
  %t852 = call i8* @malloc(i64 5)
  %t853 = bitcast i8* %t852 to [5 x i8]*
  store [5 x i8] c"true\00", [5 x i8]* %t853
  %t854 = call i1 @strings_equal(i8* %t851, i8* %t852)
  br label %logical_or_entry_850

logical_or_entry_850:
  br i1 %t854, label %logical_or_merge_850, label %logical_or_right_850

logical_or_right_850:
  %t855 = load i8*, i8** %l35
  %t856 = call i8* @malloc(i64 6)
  %t857 = bitcast i8* %t856 to [6 x i8]*
  store [6 x i8] c"false\00", [6 x i8]* %t857
  %t858 = call i1 @strings_equal(i8* %t855, i8* %t856)
  br label %logical_or_right_end_850

logical_or_right_end_850:
  br label %logical_or_merge_850

logical_or_merge_850:
  %t859 = phi i1 [ true, %logical_or_entry_850 ], [ %t858, %logical_or_right_end_850 ]
  %t860 = load %LexerState, %LexerState* %l0
  %t861 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t862 = load i8*, i8** %l2
  %t863 = load double, double* %l32
  %t864 = load double, double* %l33
  %t865 = load double, double* %l34
  %t866 = load i8*, i8** %l35
  br i1 %t859, label %then94, label %else95
then94:
  %t867 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t868 = insertvalue %TokenKind undef, i32 3, 0
  %t869 = insertvalue %Token undef, %TokenKind %t868, 0
  %t870 = load i8*, i8** %l35
  %t871 = insertvalue %Token %t869, i8* %t870, 1
  %t872 = load double, double* %l33
  %t873 = insertvalue %Token %t871, double %t872, 2
  %t874 = load double, double* %l34
  %t875 = insertvalue %Token %t873, double %t874, 3
  %t876 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t867, %Token %t875)
  store { %Token*, i64 }* %t876, { %Token*, i64 }** %l1
  %t877 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br label %merge96
else95:
  %t878 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t879 = insertvalue %TokenKind undef, i32 0, 0
  %t880 = insertvalue %Token undef, %TokenKind %t879, 0
  %t881 = load i8*, i8** %l35
  %t882 = insertvalue %Token %t880, i8* %t881, 1
  %t883 = load double, double* %l33
  %t884 = insertvalue %Token %t882, double %t883, 2
  %t885 = load double, double* %l34
  %t886 = insertvalue %Token %t884, double %t885, 3
  %t887 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t878, %Token %t886)
  store { %Token*, i64 }* %t887, { %Token*, i64 }** %l1
  %t888 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br label %merge96
merge96:
  %t889 = phi { %Token*, i64 }* [ %t877, %then94 ], [ %t888, %else95 ]
  store { %Token*, i64 }* %t889, { %Token*, i64 }** %l1
  br label %loop.latch2
merge85:
  %t890 = load %LexerState, %LexerState* %l0
  %t891 = extractvalue %LexerState %t890, 2
  store double %t891, double* %l36
  %t892 = load %LexerState, %LexerState* %l0
  %t893 = extractvalue %LexerState %t892, 3
  store double %t893, double* %l37
  %t894 = load i8*, i8** %l2
  store i8* %t894, i8** %l38
  %t895 = load %LexerState, %LexerState* %l0
  %t896 = call i8* @peek_next_char(%LexerState %t895)
  store i8* %t896, i8** %l39
  %t897 = load i8*, i8** %l39
  %t898 = call i8* @malloc(i64 1)
  %t899 = bitcast i8* %t898 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t899
  %t900 = call i1 @strings_equal(i8* %t897, i8* %t898)
  %t901 = xor i1 %t900, true
  %t902 = load %LexerState, %LexerState* %l0
  %t903 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t904 = load i8*, i8** %l2
  %t905 = load double, double* %l36
  %t906 = load double, double* %l37
  %t907 = load i8*, i8** %l38
  %t908 = load i8*, i8** %l39
  br i1 %t901, label %then97, label %merge98
then97:
  %t909 = load i8*, i8** %l2
  %t910 = load i8*, i8** %l39
  %t911 = call i8* @sailfin_runtime_string_concat(i8* %t909, i8* %t910)
  store i8* %t911, i8** %l40
  %t912 = load i8*, i8** %l40
  %t913 = call i1 @is_two_char_symbol(i8* %t912)
  %t914 = load %LexerState, %LexerState* %l0
  %t915 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t916 = load i8*, i8** %l2
  %t917 = load double, double* %l36
  %t918 = load double, double* %l37
  %t919 = load i8*, i8** %l38
  %t920 = load i8*, i8** %l39
  %t921 = load i8*, i8** %l40
  br i1 %t913, label %then99, label %merge100
then99:
  %t922 = load i8*, i8** %l40
  store i8* %t922, i8** %l38
  %t923 = load %LexerState, %LexerState* %l0
  %t924 = extractvalue %LexerState %t923, 1
  %t925 = sitofp i64 2 to double
  %t926 = fadd double %t924, %t925
  %t927 = load %LexerState, %LexerState* %l0
  %t928 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t926, double* %t928
  %t929 = load %LexerState, %LexerState* %l0
  %t930 = extractvalue %LexerState %t929, 3
  %t931 = sitofp i64 2 to double
  %t932 = fadd double %t930, %t931
  %t933 = load %LexerState, %LexerState* %l0
  %t934 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t932, double* %t934
  %t935 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t936 = insertvalue %TokenKind undef, i32 4, 0
  %t937 = insertvalue %Token undef, %TokenKind %t936, 0
  %t938 = load i8*, i8** %l38
  %t939 = insertvalue %Token %t937, i8* %t938, 1
  %t940 = load double, double* %l36
  %t941 = insertvalue %Token %t939, double %t940, 2
  %t942 = load double, double* %l37
  %t943 = insertvalue %Token %t941, double %t942, 3
  %t944 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t935, %Token %t943)
  store { %Token*, i64 }* %t944, { %Token*, i64 }** %l1
  br label %loop.latch2
merge100:
  %t945 = load i8*, i8** %l38
  %t946 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br label %merge98
merge98:
  %t947 = phi i8* [ %t945, %merge100 ], [ %t907, %merge85 ]
  %t948 = phi { %Token*, i64 }* [ %t946, %merge100 ], [ %t903, %merge85 ]
  store i8* %t947, i8** %l38
  store { %Token*, i64 }* %t948, { %Token*, i64 }** %l1
  %t949 = load %LexerState, %LexerState* %l0
  %t950 = extractvalue %LexerState %t949, 1
  %t951 = sitofp i64 1 to double
  %t952 = fadd double %t950, %t951
  %t953 = load %LexerState, %LexerState* %l0
  %t954 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t952, double* %t954
  %t955 = load i8*, i8** %l2
  %t956 = load i8, i8* %t955
  %t957 = icmp eq i8 %t956, 10
  %t958 = load %LexerState, %LexerState* %l0
  %t959 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t960 = load i8*, i8** %l2
  %t961 = load double, double* %l36
  %t962 = load double, double* %l37
  %t963 = load i8*, i8** %l38
  %t964 = load i8*, i8** %l39
  br i1 %t957, label %then101, label %else102
then101:
  %t965 = load %LexerState, %LexerState* %l0
  %t966 = extractvalue %LexerState %t965, 2
  %t967 = sitofp i64 1 to double
  %t968 = fadd double %t966, %t967
  %t969 = load %LexerState, %LexerState* %l0
  %t970 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 2
  store double %t968, double* %t970
  %t971 = load %LexerState, %LexerState* %l0
  %t972 = sitofp i64 1 to double
  %t973 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t972, double* %t973
  br label %merge103
else102:
  %t974 = load %LexerState, %LexerState* %l0
  %t975 = extractvalue %LexerState %t974, 3
  %t976 = sitofp i64 1 to double
  %t977 = fadd double %t975, %t976
  %t978 = load %LexerState, %LexerState* %l0
  %t979 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t977, double* %t979
  br label %merge103
merge103:
  %t980 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t981 = insertvalue %TokenKind undef, i32 4, 0
  %t982 = insertvalue %Token undef, %TokenKind %t981, 0
  %t983 = load i8*, i8** %l38
  %t984 = insertvalue %Token %t982, i8* %t983, 1
  %t985 = load double, double* %l36
  %t986 = insertvalue %Token %t984, double %t985, 2
  %t987 = load double, double* %l37
  %t988 = insertvalue %Token %t986, double %t987, 3
  %t989 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t980, %Token %t988)
  store { %Token*, i64 }* %t989, { %Token*, i64 }** %l1
  br label %loop.latch2
loop.latch2:
  %t990 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br label %loop.header0
afterloop3:
  %t992 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t993 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t994 = load %LexerState, %LexerState* %l0
  %t995 = extractvalue %LexerState %t994, 2
  %t996 = load %LexerState, %LexerState* %l0
  %t997 = extractvalue %LexerState %t996, 3
  %t998 = call %Token @eof_token(double %t995, double %t997)
  %t999 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t993, %Token %t998)
  store { %Token*, i64 }* %t999, { %Token*, i64 }** %l1
  %t1000 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  ret { %Token*, i64 }* %t1000
}

define i1 @is_whitespace(i8* %ch) {
block.entry:
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
block.entry:
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
  %t4 = add i64 0, 2
  %t5 = call i8* @malloc(i64 %t4)
  store i8 97, i8* %t5
  %t6 = getelementptr i8, i8* %t5, i64 1
  store i8 0, i8* %t6
  call void @sailfin_runtime_mark_persistent(i8* %t5)
  %t7 = call double @char_code(i8* %t5)
  %t8 = fcmp oge double %t3, %t7
  br label %logical_and_entry_2

logical_and_entry_2:
  br i1 %t8, label %logical_and_right_2, label %logical_and_merge_2

logical_and_right_2:
  %t9 = load double, double* %l0
  %t10 = add i64 0, 2
  %t11 = call i8* @malloc(i64 %t10)
  store i8 122, i8* %t11
  %t12 = getelementptr i8, i8* %t11, i64 1
  store i8 0, i8* %t12
  call void @sailfin_runtime_mark_persistent(i8* %t11)
  %t13 = call double @char_code(i8* %t11)
  %t14 = fcmp ole double %t9, %t13
  br label %logical_and_right_end_2

logical_and_right_end_2:
  br label %logical_and_merge_2

logical_and_merge_2:
  %t15 = phi i1 [ false, %logical_and_entry_2 ], [ %t14, %logical_and_right_end_2 ]
  br label %logical_or_entry_1

logical_or_entry_1:
  br i1 %t15, label %logical_or_merge_1, label %logical_or_right_1

logical_or_right_1:
  %t17 = load double, double* %l0
  %t18 = add i64 0, 2
  %t19 = call i8* @malloc(i64 %t18)
  store i8 65, i8* %t19
  %t20 = getelementptr i8, i8* %t19, i64 1
  store i8 0, i8* %t20
  call void @sailfin_runtime_mark_persistent(i8* %t19)
  %t21 = call double @char_code(i8* %t19)
  %t22 = fcmp oge double %t17, %t21
  br label %logical_and_entry_16

logical_and_entry_16:
  br i1 %t22, label %logical_and_right_16, label %logical_and_merge_16

logical_and_right_16:
  %t23 = load double, double* %l0
  %t24 = add i64 0, 2
  %t25 = call i8* @malloc(i64 %t24)
  store i8 90, i8* %t25
  %t26 = getelementptr i8, i8* %t25, i64 1
  store i8 0, i8* %t26
  call void @sailfin_runtime_mark_persistent(i8* %t25)
  %t27 = call double @char_code(i8* %t25)
  %t28 = fcmp ole double %t23, %t27
  br label %logical_and_right_end_16

logical_and_right_end_16:
  br label %logical_and_merge_16

logical_and_merge_16:
  %t29 = phi i1 [ false, %logical_and_entry_16 ], [ %t28, %logical_and_right_end_16 ]
  br label %logical_or_right_end_1

logical_or_right_end_1:
  br label %logical_or_merge_1

logical_or_merge_1:
  %t30 = phi i1 [ true, %logical_or_entry_1 ], [ %t29, %logical_or_right_end_1 ]
  ret i1 %t30
}

define i1 @is_digit(i8* %ch) {
block.entry:
  %l0 = alloca double
  %t0 = call double @char_code(i8* %ch)
  store double %t0, double* %l0
  %t2 = load double, double* %l0
  %t3 = add i64 0, 2
  %t4 = call i8* @malloc(i64 %t3)
  store i8 48, i8* %t4
  %t5 = getelementptr i8, i8* %t4, i64 1
  store i8 0, i8* %t5
  call void @sailfin_runtime_mark_persistent(i8* %t4)
  %t6 = call double @char_code(i8* %t4)
  %t7 = fcmp oge double %t2, %t6
  br label %logical_and_entry_1

logical_and_entry_1:
  br i1 %t7, label %logical_and_right_1, label %logical_and_merge_1

logical_and_right_1:
  %t8 = load double, double* %l0
  %t9 = add i64 0, 2
  %t10 = call i8* @malloc(i64 %t9)
  store i8 57, i8* %t10
  %t11 = getelementptr i8, i8* %t10, i64 1
  store i8 0, i8* %t11
  call void @sailfin_runtime_mark_persistent(i8* %t10)
  %t12 = call double @char_code(i8* %t10)
  %t13 = fcmp ole double %t8, %t12
  br label %logical_and_right_end_1

logical_and_right_end_1:
  br label %logical_and_merge_1

logical_and_merge_1:
  %t14 = phi i1 [ false, %logical_and_entry_1 ], [ %t13, %logical_and_right_end_1 ]
  ret i1 %t14
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
  %t0 = call double @llvm.round.f64(double %start)
  %t1 = fptosi double %t0 to i64
  %t2 = call double @llvm.round.f64(double %end)
  %t3 = fptosi double %t2 to i64
  %t4 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t1, i64 %t3)
  call void @sailfin_runtime_mark_persistent(i8* %t4)
  ret i8* %t4
}

define { %Token*, i64 }* @append({ %Token*, i64 }* %tokens, %Token %token) {
block.entry:
  %t0 = getelementptr [1 x %Token], [1 x %Token]* null, i32 1
  %t1 = ptrtoint [1 x %Token]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %Token*
  %t6 = getelementptr %Token, %Token* %t5, i64 0
  store %Token %token, %Token* %t6
  %t7 = getelementptr { %Token*, i64 }, { %Token*, i64 }* null, i32 1
  %t8 = ptrtoint { %Token*, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { %Token*, i64 }*
  %t11 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t10, i32 0, i32 0
  store %Token* %t5, %Token** %t11
  %t12 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t10, i32 0, i32 1
  store i64 1, i64* %t12
  %t13 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %tokens, i32 0, i32 0
  %t14 = load %Token*, %Token** %t13
  %t15 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %tokens, i32 0, i32 1
  %t16 = load i64, i64* %t15
  %t17 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t10, i32 0, i32 0
  %t18 = load %Token*, %Token** %t17
  %t19 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t10, i32 0, i32 1
  %t20 = load i64, i64* %t19
  %t21 = getelementptr [1 x %Token], [1 x %Token]* null, i32 0, i32 1
  %t22 = ptrtoint %Token* %t21 to i64
  %t23 = add i64 %t16, %t20
  %t24 = mul i64 %t22, %t23
  %t25 = call noalias i8* @malloc(i64 %t24)
  %t26 = bitcast i8* %t25 to %Token*
  %t27 = bitcast %Token* %t26 to i8*
  %t28 = mul i64 %t22, %t16
  %t29 = bitcast %Token* %t14 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t27, i8* %t29, i64 %t28)
  %t30 = mul i64 %t22, %t20
  %t31 = bitcast %Token* %t18 to i8*
  %t32 = getelementptr %Token, %Token* %t26, i64 %t16
  %t33 = bitcast %Token* %t32 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t33, i8* %t31, i64 %t30)
  %t34 = getelementptr { %Token*, i64 }, { %Token*, i64 }* null, i32 1
  %t35 = ptrtoint { %Token*, i64 }* %t34 to i64
  %t36 = call i8* @malloc(i64 %t35)
  %t37 = bitcast i8* %t36 to { %Token*, i64 }*
  %t38 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t37, i32 0, i32 0
  store %Token* %t26, %Token** %t38
  %t39 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t37, i32 0, i32 1
  store i64 %t23, i64* %t39
  ret { %Token*, i64 }* %t37
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
  %t9 = call i8* @malloc(i64 1)
  %t10 = bitcast i8* %t9 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t10
  call void @sailfin_runtime_mark_persistent(i8* %t9)
  ret i8* %t9
merge1:
  %t11 = extractvalue %LexerState %state, 0
  %t12 = load double, double* %l0
  %t13 = call i8* @char_at(i8* %t11, double %t12)
  call void @sailfin_runtime_mark_persistent(i8* %t13)
  ret i8* %t13
}

define i8* @interpret_escape(i8* %ch) {
block.entry:
  %t0 = load i8, i8* %ch
  %t1 = icmp eq i8 %t0, 110
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = add i64 0, 2
  %t3 = call i8* @malloc(i64 %t2)
  store i8 10, i8* %t3
  %t4 = getelementptr i8, i8* %t3, i64 1
  store i8 0, i8* %t4
  call void @sailfin_runtime_mark_persistent(i8* %t3)
  call void @sailfin_runtime_mark_persistent(i8* %t3)
  ret i8* %t3
merge1:
  %t5 = load i8, i8* %ch
  %t6 = icmp eq i8 %t5, 116
  br i1 %t6, label %then2, label %merge3
then2:
  %t7 = add i64 0, 2
  %t8 = call i8* @malloc(i64 %t7)
  store i8 9, i8* %t8
  %t9 = getelementptr i8, i8* %t8, i64 1
  store i8 0, i8* %t9
  call void @sailfin_runtime_mark_persistent(i8* %t8)
  call void @sailfin_runtime_mark_persistent(i8* %t8)
  ret i8* %t8
merge3:
  %t10 = load i8, i8* %ch
  %t11 = icmp eq i8 %t10, 114
  br i1 %t11, label %then4, label %merge5
then4:
  %t12 = add i64 0, 2
  %t13 = call i8* @malloc(i64 %t12)
  store i8 13, i8* %t13
  %t14 = getelementptr i8, i8* %t13, i64 1
  store i8 0, i8* %t14
  call void @sailfin_runtime_mark_persistent(i8* %t13)
  call void @sailfin_runtime_mark_persistent(i8* %t13)
  ret i8* %t13
merge5:
  %t15 = call i1 @is_double_quote(i8* %ch)
  br i1 %t15, label %then6, label %merge7
then6:
  %t16 = add i64 0, 2
  %t17 = call i8* @malloc(i64 %t16)
  store i8 34, i8* %t17
  %t18 = getelementptr i8, i8* %t17, i64 1
  store i8 0, i8* %t18
  call void @sailfin_runtime_mark_persistent(i8* %t17)
  call void @sailfin_runtime_mark_persistent(i8* %t17)
  ret i8* %t17
merge7:
  %t19 = call i1 @is_backslash(i8* %ch)
  br i1 %t19, label %then8, label %merge9
then8:
  %t20 = add i64 0, 2
  %t21 = call i8* @malloc(i64 %t20)
  store i8 92, i8* %t21
  %t22 = getelementptr i8, i8* %t21, i64 1
  store i8 0, i8* %t22
  call void @sailfin_runtime_mark_persistent(i8* %t21)
  call void @sailfin_runtime_mark_persistent(i8* %t21)
  ret i8* %t21
merge9:
  call void @sailfin_runtime_mark_persistent(i8* %ch)
  ret i8* %ch
}

define i1 @is_two_char_symbol(i8* %value) {
block.entry:
  %t1 = call i8* @malloc(i64 3)
  %t2 = bitcast i8* %t1 to [3 x i8]*
  store [3 x i8] c"->\00", [3 x i8]* %t2
  %t3 = call i1 @strings_equal(i8* %value, i8* %t1)
  br label %logical_or_entry_0

logical_or_entry_0:
  br i1 %t3, label %logical_or_merge_0, label %logical_or_right_0

logical_or_right_0:
  %t5 = call i8* @malloc(i64 3)
  %t6 = bitcast i8* %t5 to [3 x i8]*
  store [3 x i8] c"=>\00", [3 x i8]* %t6
  %t7 = call i1 @strings_equal(i8* %value, i8* %t5)
  br label %logical_or_entry_4

logical_or_entry_4:
  br i1 %t7, label %logical_or_merge_4, label %logical_or_right_4

logical_or_right_4:
  %t9 = call i8* @malloc(i64 3)
  %t10 = bitcast i8* %t9 to [3 x i8]*
  store [3 x i8] c"==\00", [3 x i8]* %t10
  %t11 = call i1 @strings_equal(i8* %value, i8* %t9)
  br label %logical_or_entry_8

logical_or_entry_8:
  br i1 %t11, label %logical_or_merge_8, label %logical_or_right_8

logical_or_right_8:
  %t13 = call i8* @malloc(i64 3)
  %t14 = bitcast i8* %t13 to [3 x i8]*
  store [3 x i8] c"!=\00", [3 x i8]* %t14
  %t15 = call i1 @strings_equal(i8* %value, i8* %t13)
  br label %logical_or_entry_12

logical_or_entry_12:
  br i1 %t15, label %logical_or_merge_12, label %logical_or_right_12

logical_or_right_12:
  %t17 = call i8* @malloc(i64 3)
  %t18 = bitcast i8* %t17 to [3 x i8]*
  store [3 x i8] c"<=\00", [3 x i8]* %t18
  %t19 = call i1 @strings_equal(i8* %value, i8* %t17)
  br label %logical_or_entry_16

logical_or_entry_16:
  br i1 %t19, label %logical_or_merge_16, label %logical_or_right_16

logical_or_right_16:
  %t21 = call i8* @malloc(i64 3)
  %t22 = bitcast i8* %t21 to [3 x i8]*
  store [3 x i8] c">=\00", [3 x i8]* %t22
  %t23 = call i1 @strings_equal(i8* %value, i8* %t21)
  br label %logical_or_entry_20

logical_or_entry_20:
  br i1 %t23, label %logical_or_merge_20, label %logical_or_right_20

logical_or_right_20:
  %t25 = call i8* @malloc(i64 3)
  %t26 = bitcast i8* %t25 to [3 x i8]*
  store [3 x i8] c"&&\00", [3 x i8]* %t26
  %t27 = call i1 @strings_equal(i8* %value, i8* %t25)
  br label %logical_or_entry_24

logical_or_entry_24:
  br i1 %t27, label %logical_or_merge_24, label %logical_or_right_24

logical_or_right_24:
  %t29 = call i8* @malloc(i64 3)
  %t30 = bitcast i8* %t29 to [3 x i8]*
  store [3 x i8] c"||\00", [3 x i8]* %t30
  %t31 = call i1 @strings_equal(i8* %value, i8* %t29)
  br label %logical_or_entry_28

logical_or_entry_28:
  br i1 %t31, label %logical_or_merge_28, label %logical_or_right_28

logical_or_right_28:
  %t32 = call i8* @malloc(i64 3)
  %t33 = bitcast i8* %t32 to [3 x i8]*
  store [3 x i8] c"..\00", [3 x i8]* %t33
  %t34 = call i1 @strings_equal(i8* %value, i8* %t32)
  br label %logical_or_right_end_28

logical_or_right_end_28:
  br label %logical_or_merge_28

logical_or_merge_28:
  %t35 = phi i1 [ true, %logical_or_entry_28 ], [ %t34, %logical_or_right_end_28 ]
  br label %logical_or_right_end_24

logical_or_right_end_24:
  br label %logical_or_merge_24

logical_or_merge_24:
  %t36 = phi i1 [ true, %logical_or_entry_24 ], [ %t35, %logical_or_right_end_24 ]
  br label %logical_or_right_end_20

logical_or_right_end_20:
  br label %logical_or_merge_20

logical_or_merge_20:
  %t37 = phi i1 [ true, %logical_or_entry_20 ], [ %t36, %logical_or_right_end_20 ]
  br label %logical_or_right_end_16

logical_or_right_end_16:
  br label %logical_or_merge_16

logical_or_merge_16:
  %t38 = phi i1 [ true, %logical_or_entry_16 ], [ %t37, %logical_or_right_end_16 ]
  br label %logical_or_right_end_12

logical_or_right_end_12:
  br label %logical_or_merge_12

logical_or_merge_12:
  %t39 = phi i1 [ true, %logical_or_entry_12 ], [ %t38, %logical_or_right_end_12 ]
  br label %logical_or_right_end_8

logical_or_right_end_8:
  br label %logical_or_merge_8

logical_or_merge_8:
  %t40 = phi i1 [ true, %logical_or_entry_8 ], [ %t39, %logical_or_right_end_8 ]
  br label %logical_or_right_end_4

logical_or_right_end_4:
  br label %logical_or_merge_4

logical_or_merge_4:
  %t41 = phi i1 [ true, %logical_or_entry_4 ], [ %t40, %logical_or_right_end_4 ]
  br label %logical_or_right_end_0

logical_or_right_end_0:
  br label %logical_or_merge_0

logical_or_merge_0:
  %t42 = phi i1 [ true, %logical_or_entry_0 ], [ %t41, %logical_or_right_end_0 ]
  ret i1 %t42
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}