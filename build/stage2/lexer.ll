; ModuleID = 'sailfin'
source_filename = "sailfin"

%LexerState = type { i8*, double, double, double }
%Token = type { %TokenKind, i8*, double, double }

%TokenKind = type { i32 }

declare void @sailfin_runtime_bounds_check(i64, i64)
declare i8* @sailfin_runtime_substring(i8*, i64, i64)
declare i64 @sailfin_runtime_string_length(i8*)
declare i8* @sailfin_runtime_string_concat(i8*, i8*)
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

@.str.len2.h193428050 = private unnamed_addr constant [3 x i8] c"->\00"
@.str.len2.h193445474 = private unnamed_addr constant [3 x i8] c"=>\00"
@.str.len2.h193445441 = private unnamed_addr constant [3 x i8] c"==\00"
@.str.len2.h193414949 = private unnamed_addr constant [3 x i8] c"!=\00"
@.str.len2.h193444352 = private unnamed_addr constant [3 x i8] c"<=\00"
@.str.len2.h193446530 = private unnamed_addr constant [3 x i8] c">=\00"
@.str.len2.h193419635 = private unnamed_addr constant [3 x i8] c"&&\00"
@.str.len2.h193516127 = private unnamed_addr constant [3 x i8] c"||\00"
@.str.len2.h193428611 = private unnamed_addr constant [3 x i8] c"..\00"

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
  %t987 = phi { %Token*, i64 }* [ %t20, %block.entry ], [ %t986, %loop.latch2 ]
  store { %Token*, i64 }* %t987, { %Token*, i64 }** %l1
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
  %s419 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s419, i8** %l23
  store i1 0, i1* %l24
  %t420 = load %LexerState, %LexerState* %l0
  %t421 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t422 = load i8*, i8** %l2
  %t423 = load double, double* %l20
  %t424 = load double, double* %l21
  %t425 = load double, double* %l22
  %t426 = load i8*, i8** %l23
  %t427 = load i1, i1* %l24
  br label %loop.header46
loop.header46:
  %t565 = phi i1 [ %t427, %then44 ], [ %t563, %loop.latch48 ]
  %t566 = phi i8* [ %t426, %then44 ], [ %t564, %loop.latch48 ]
  store i1 %t565, i1* %l24
  store i8* %t566, i8** %l23
  br label %loop.body47
loop.body47:
  %t428 = load %LexerState, %LexerState* %l0
  %t429 = extractvalue %LexerState %t428, 1
  %t430 = load %LexerState, %LexerState* %l0
  %t431 = extractvalue %LexerState %t430, 0
  %t432 = call i64 @sailfin_runtime_string_length(i8* %t431)
  %t433 = sitofp i64 %t432 to double
  %t434 = fcmp oge double %t429, %t433
  %t435 = load %LexerState, %LexerState* %l0
  %t436 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t437 = load i8*, i8** %l2
  %t438 = load double, double* %l20
  %t439 = load double, double* %l21
  %t440 = load double, double* %l22
  %t441 = load i8*, i8** %l23
  %t442 = load i1, i1* %l24
  br i1 %t434, label %then50, label %merge51
then50:
  br label %afterloop49
merge51:
  %t443 = load %LexerState, %LexerState* %l0
  %t444 = extractvalue %LexerState %t443, 0
  %t445 = load %LexerState, %LexerState* %l0
  %t446 = extractvalue %LexerState %t445, 1
  %t447 = call i8* @char_at(i8* %t444, double %t446)
  store i8* %t447, i8** %l25
  %t449 = load i1, i1* %l24
  br label %logical_and_entry_448

logical_and_entry_448:
  br i1 %t449, label %logical_and_right_448, label %logical_and_merge_448

logical_and_right_448:
  %t450 = load i8*, i8** %l25
  %t451 = call i1 @is_double_quote(i8* %t450)
  br label %logical_and_right_end_448

logical_and_right_end_448:
  br label %logical_and_merge_448

logical_and_merge_448:
  %t452 = phi i1 [ false, %logical_and_entry_448 ], [ %t451, %logical_and_right_end_448 ]
  %t453 = xor i1 %t452, 1
  %t454 = load %LexerState, %LexerState* %l0
  %t455 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t456 = load i8*, i8** %l2
  %t457 = load double, double* %l20
  %t458 = load double, double* %l21
  %t459 = load double, double* %l22
  %t460 = load i8*, i8** %l23
  %t461 = load i1, i1* %l24
  %t462 = load i8*, i8** %l25
  br i1 %t453, label %then52, label %merge53
then52:
  %t463 = load %LexerState, %LexerState* %l0
  %t464 = extractvalue %LexerState %t463, 1
  %t465 = sitofp i64 1 to double
  %t466 = fadd double %t464, %t465
  %t467 = load %LexerState, %LexerState* %l0
  %t468 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t466, double* %t468
  %t469 = load %LexerState, %LexerState* %l0
  %t470 = extractvalue %LexerState %t469, 3
  %t471 = sitofp i64 1 to double
  %t472 = fadd double %t470, %t471
  %t473 = load %LexerState, %LexerState* %l0
  %t474 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t472, double* %t474
  br label %afterloop49
merge53:
  %t476 = load i1, i1* %l24
  br label %logical_and_entry_475

logical_and_entry_475:
  br i1 %t476, label %logical_and_right_475, label %logical_and_merge_475

logical_and_right_475:
  %t477 = load i8*, i8** %l25
  %t478 = call i1 @is_backslash(i8* %t477)
  br label %logical_and_right_end_475

logical_and_right_end_475:
  br label %logical_and_merge_475

logical_and_merge_475:
  %t479 = phi i1 [ false, %logical_and_entry_475 ], [ %t478, %logical_and_right_end_475 ]
  %t480 = xor i1 %t479, 1
  %t481 = load %LexerState, %LexerState* %l0
  %t482 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t483 = load i8*, i8** %l2
  %t484 = load double, double* %l20
  %t485 = load double, double* %l21
  %t486 = load double, double* %l22
  %t487 = load i8*, i8** %l23
  %t488 = load i1, i1* %l24
  %t489 = load i8*, i8** %l25
  br i1 %t480, label %then54, label %merge55
then54:
  store i1 1, i1* %l24
  %t490 = load %LexerState, %LexerState* %l0
  %t491 = extractvalue %LexerState %t490, 1
  %t492 = sitofp i64 1 to double
  %t493 = fadd double %t491, %t492
  %t494 = load %LexerState, %LexerState* %l0
  %t495 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t493, double* %t495
  %t496 = load %LexerState, %LexerState* %l0
  %t497 = extractvalue %LexerState %t496, 3
  %t498 = sitofp i64 1 to double
  %t499 = fadd double %t497, %t498
  %t500 = load %LexerState, %LexerState* %l0
  %t501 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t499, double* %t501
  br label %loop.latch48
merge55:
  %t502 = load i1, i1* %l24
  %t503 = load %LexerState, %LexerState* %l0
  %t504 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t505 = load i8*, i8** %l2
  %t506 = load double, double* %l20
  %t507 = load double, double* %l21
  %t508 = load double, double* %l22
  %t509 = load i8*, i8** %l23
  %t510 = load i1, i1* %l24
  %t511 = load i8*, i8** %l25
  br i1 %t502, label %then56, label %else57
then56:
  %t512 = load i8*, i8** %l23
  %t513 = load i8*, i8** %l25
  %t514 = call i8* @interpret_escape(i8* %t513)
  %t515 = call i8* @sailfin_runtime_string_concat(i8* %t512, i8* %t514)
  store i8* %t515, i8** %l23
  store i1 0, i1* %l24
  %t516 = load i8*, i8** %l23
  %t517 = load i1, i1* %l24
  br label %merge58
else57:
  %t518 = load i8*, i8** %l23
  %t519 = load i8*, i8** %l25
  %t520 = call i8* @sailfin_runtime_string_concat(i8* %t518, i8* %t519)
  store i8* %t520, i8** %l23
  %t521 = load i8*, i8** %l23
  br label %merge58
merge58:
  %t522 = phi i8* [ %t516, %then56 ], [ %t521, %else57 ]
  %t523 = phi i1 [ %t517, %then56 ], [ %t510, %else57 ]
  store i8* %t522, i8** %l23
  store i1 %t523, i1* %l24
  %t524 = load i8*, i8** %l25
  %t525 = load i8, i8* %t524
  %t526 = icmp eq i8 %t525, 10
  %t527 = load %LexerState, %LexerState* %l0
  %t528 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t529 = load i8*, i8** %l2
  %t530 = load double, double* %l20
  %t531 = load double, double* %l21
  %t532 = load double, double* %l22
  %t533 = load i8*, i8** %l23
  %t534 = load i1, i1* %l24
  %t535 = load i8*, i8** %l25
  br i1 %t526, label %then59, label %else60
then59:
  %t536 = load %LexerState, %LexerState* %l0
  %t537 = extractvalue %LexerState %t536, 1
  %t538 = sitofp i64 1 to double
  %t539 = fadd double %t537, %t538
  %t540 = load %LexerState, %LexerState* %l0
  %t541 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t539, double* %t541
  %t542 = load %LexerState, %LexerState* %l0
  %t543 = extractvalue %LexerState %t542, 2
  %t544 = sitofp i64 1 to double
  %t545 = fadd double %t543, %t544
  %t546 = load %LexerState, %LexerState* %l0
  %t547 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 2
  store double %t545, double* %t547
  %t548 = load %LexerState, %LexerState* %l0
  %t549 = sitofp i64 1 to double
  %t550 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t549, double* %t550
  br label %merge61
else60:
  %t551 = load %LexerState, %LexerState* %l0
  %t552 = extractvalue %LexerState %t551, 1
  %t553 = sitofp i64 1 to double
  %t554 = fadd double %t552, %t553
  %t555 = load %LexerState, %LexerState* %l0
  %t556 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t554, double* %t556
  %t557 = load %LexerState, %LexerState* %l0
  %t558 = extractvalue %LexerState %t557, 3
  %t559 = sitofp i64 1 to double
  %t560 = fadd double %t558, %t559
  %t561 = load %LexerState, %LexerState* %l0
  %t562 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t560, double* %t562
  br label %merge61
merge61:
  br label %loop.latch48
loop.latch48:
  %t563 = load i1, i1* %l24
  %t564 = load i8*, i8** %l23
  br label %loop.header46
afterloop49:
  %t567 = load i1, i1* %l24
  %t568 = load i8*, i8** %l23
  %t569 = load %LexerState, %LexerState* %l0
  %t570 = extractvalue %LexerState %t569, 0
  %t571 = load double, double* %l20
  %t572 = load %LexerState, %LexerState* %l0
  %t573 = extractvalue %LexerState %t572, 1
  %t574 = call i8* @slice(i8* %t570, double %t571, double %t573)
  store i8* %t574, i8** %l26
  %t575 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t576 = insertvalue %TokenKind undef, i32 2, 0
  %t577 = insertvalue %Token undef, %TokenKind %t576, 0
  %t578 = load i8*, i8** %l26
  %t579 = insertvalue %Token %t577, i8* %t578, 1
  %t580 = load double, double* %l21
  %t581 = insertvalue %Token %t579, double %t580, 2
  %t582 = load double, double* %l22
  %t583 = insertvalue %Token %t581, double %t582, 3
  %t584 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t575, %Token %t583)
  store { %Token*, i64 }* %t584, { %Token*, i64 }** %l1
  br label %loop.latch2
merge45:
  %t585 = load i8*, i8** %l2
  %t586 = call i1 @is_digit(i8* %t585)
  %t587 = load %LexerState, %LexerState* %l0
  %t588 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t589 = load i8*, i8** %l2
  br i1 %t586, label %then62, label %merge63
then62:
  %t590 = load %LexerState, %LexerState* %l0
  %t591 = extractvalue %LexerState %t590, 1
  store double %t591, double* %l27
  %t592 = load %LexerState, %LexerState* %l0
  %t593 = extractvalue %LexerState %t592, 2
  store double %t593, double* %l28
  %t594 = load %LexerState, %LexerState* %l0
  %t595 = extractvalue %LexerState %t594, 3
  store double %t595, double* %l29
  %t596 = load %LexerState, %LexerState* %l0
  %t597 = extractvalue %LexerState %t596, 1
  %t598 = sitofp i64 1 to double
  %t599 = fadd double %t597, %t598
  %t600 = load %LexerState, %LexerState* %l0
  %t601 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t599, double* %t601
  %t602 = load %LexerState, %LexerState* %l0
  %t603 = extractvalue %LexerState %t602, 3
  %t604 = sitofp i64 1 to double
  %t605 = fadd double %t603, %t604
  %t606 = load %LexerState, %LexerState* %l0
  %t607 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t605, double* %t607
  %t608 = load %LexerState, %LexerState* %l0
  %t609 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t610 = load i8*, i8** %l2
  %t611 = load double, double* %l27
  %t612 = load double, double* %l28
  %t613 = load double, double* %l29
  br label %loop.header64
loop.header64:
  br label %loop.body65
loop.body65:
  %t614 = load %LexerState, %LexerState* %l0
  %t615 = extractvalue %LexerState %t614, 1
  %t616 = load %LexerState, %LexerState* %l0
  %t617 = extractvalue %LexerState %t616, 0
  %t618 = call i64 @sailfin_runtime_string_length(i8* %t617)
  %t619 = sitofp i64 %t618 to double
  %t620 = fcmp oge double %t615, %t619
  %t621 = load %LexerState, %LexerState* %l0
  %t622 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t623 = load i8*, i8** %l2
  %t624 = load double, double* %l27
  %t625 = load double, double* %l28
  %t626 = load double, double* %l29
  br i1 %t620, label %then68, label %merge69
then68:
  br label %afterloop67
merge69:
  %t627 = load %LexerState, %LexerState* %l0
  %t628 = extractvalue %LexerState %t627, 0
  %t629 = load %LexerState, %LexerState* %l0
  %t630 = extractvalue %LexerState %t629, 1
  %t631 = call i8* @char_at(i8* %t628, double %t630)
  %t632 = call i1 @is_digit(i8* %t631)
  %t633 = xor i1 %t632, 1
  %t634 = load %LexerState, %LexerState* %l0
  %t635 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t636 = load i8*, i8** %l2
  %t637 = load double, double* %l27
  %t638 = load double, double* %l28
  %t639 = load double, double* %l29
  br i1 %t633, label %then70, label %merge71
then70:
  br label %afterloop67
merge71:
  %t640 = load %LexerState, %LexerState* %l0
  %t641 = extractvalue %LexerState %t640, 1
  %t642 = sitofp i64 1 to double
  %t643 = fadd double %t641, %t642
  %t644 = load %LexerState, %LexerState* %l0
  %t645 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t643, double* %t645
  %t646 = load %LexerState, %LexerState* %l0
  %t647 = extractvalue %LexerState %t646, 3
  %t648 = sitofp i64 1 to double
  %t649 = fadd double %t647, %t648
  %t650 = load %LexerState, %LexerState* %l0
  %t651 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t649, double* %t651
  br label %loop.latch66
loop.latch66:
  br label %loop.header64
afterloop67:
  %t653 = load %LexerState, %LexerState* %l0
  %t654 = extractvalue %LexerState %t653, 1
  %t655 = load %LexerState, %LexerState* %l0
  %t656 = extractvalue %LexerState %t655, 0
  %t657 = call i64 @sailfin_runtime_string_length(i8* %t656)
  %t658 = sitofp i64 %t657 to double
  %t659 = fcmp olt double %t654, %t658
  br label %logical_and_entry_652

logical_and_entry_652:
  br i1 %t659, label %logical_and_right_652, label %logical_and_merge_652

logical_and_right_652:
  %t660 = load %LexerState, %LexerState* %l0
  %t661 = extractvalue %LexerState %t660, 0
  %t662 = load %LexerState, %LexerState* %l0
  %t663 = extractvalue %LexerState %t662, 1
  %t664 = call i8* @char_at(i8* %t661, double %t663)
  %t665 = load i8, i8* %t664
  %t666 = icmp eq i8 %t665, 46
  br label %logical_and_right_end_652

logical_and_right_end_652:
  br label %logical_and_merge_652

logical_and_merge_652:
  %t667 = phi i1 [ false, %logical_and_entry_652 ], [ %t666, %logical_and_right_end_652 ]
  %t668 = load %LexerState, %LexerState* %l0
  %t669 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t670 = load i8*, i8** %l2
  %t671 = load double, double* %l27
  %t672 = load double, double* %l28
  %t673 = load double, double* %l29
  br i1 %t667, label %then72, label %merge73
then72:
  %t675 = load %LexerState, %LexerState* %l0
  %t676 = extractvalue %LexerState %t675, 1
  %t677 = sitofp i64 1 to double
  %t678 = fadd double %t676, %t677
  %t679 = load %LexerState, %LexerState* %l0
  %t680 = extractvalue %LexerState %t679, 0
  %t681 = call i64 @sailfin_runtime_string_length(i8* %t680)
  %t682 = sitofp i64 %t681 to double
  %t683 = fcmp olt double %t678, %t682
  br label %logical_and_entry_674

logical_and_entry_674:
  br i1 %t683, label %logical_and_right_674, label %logical_and_merge_674

logical_and_right_674:
  %t684 = load %LexerState, %LexerState* %l0
  %t685 = extractvalue %LexerState %t684, 0
  %t686 = load %LexerState, %LexerState* %l0
  %t687 = extractvalue %LexerState %t686, 1
  %t688 = sitofp i64 1 to double
  %t689 = fadd double %t687, %t688
  %t690 = call i8* @char_at(i8* %t685, double %t689)
  %t691 = call i1 @is_digit(i8* %t690)
  br label %logical_and_right_end_674

logical_and_right_end_674:
  br label %logical_and_merge_674

logical_and_merge_674:
  %t692 = phi i1 [ false, %logical_and_entry_674 ], [ %t691, %logical_and_right_end_674 ]
  store i1 %t692, i1* %l30
  %t693 = load i1, i1* %l30
  %t694 = load %LexerState, %LexerState* %l0
  %t695 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t696 = load i8*, i8** %l2
  %t697 = load double, double* %l27
  %t698 = load double, double* %l28
  %t699 = load double, double* %l29
  %t700 = load i1, i1* %l30
  br i1 %t693, label %then74, label %merge75
then74:
  %t701 = load %LexerState, %LexerState* %l0
  %t702 = extractvalue %LexerState %t701, 1
  %t703 = sitofp i64 1 to double
  %t704 = fadd double %t702, %t703
  %t705 = load %LexerState, %LexerState* %l0
  %t706 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t704, double* %t706
  %t707 = load %LexerState, %LexerState* %l0
  %t708 = extractvalue %LexerState %t707, 3
  %t709 = sitofp i64 1 to double
  %t710 = fadd double %t708, %t709
  %t711 = load %LexerState, %LexerState* %l0
  %t712 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t710, double* %t712
  %t713 = load %LexerState, %LexerState* %l0
  %t714 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t715 = load i8*, i8** %l2
  %t716 = load double, double* %l27
  %t717 = load double, double* %l28
  %t718 = load double, double* %l29
  %t719 = load i1, i1* %l30
  br label %loop.header76
loop.header76:
  br label %loop.body77
loop.body77:
  %t720 = load %LexerState, %LexerState* %l0
  %t721 = extractvalue %LexerState %t720, 1
  %t722 = load %LexerState, %LexerState* %l0
  %t723 = extractvalue %LexerState %t722, 0
  %t724 = call i64 @sailfin_runtime_string_length(i8* %t723)
  %t725 = sitofp i64 %t724 to double
  %t726 = fcmp oge double %t721, %t725
  %t727 = load %LexerState, %LexerState* %l0
  %t728 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t729 = load i8*, i8** %l2
  %t730 = load double, double* %l27
  %t731 = load double, double* %l28
  %t732 = load double, double* %l29
  %t733 = load i1, i1* %l30
  br i1 %t726, label %then80, label %merge81
then80:
  br label %afterloop79
merge81:
  %t734 = load %LexerState, %LexerState* %l0
  %t735 = extractvalue %LexerState %t734, 0
  %t736 = load %LexerState, %LexerState* %l0
  %t737 = extractvalue %LexerState %t736, 1
  %t738 = call i8* @char_at(i8* %t735, double %t737)
  %t739 = call i1 @is_digit(i8* %t738)
  %t740 = xor i1 %t739, 1
  %t741 = load %LexerState, %LexerState* %l0
  %t742 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t743 = load i8*, i8** %l2
  %t744 = load double, double* %l27
  %t745 = load double, double* %l28
  %t746 = load double, double* %l29
  %t747 = load i1, i1* %l30
  br i1 %t740, label %then82, label %merge83
then82:
  br label %afterloop79
merge83:
  %t748 = load %LexerState, %LexerState* %l0
  %t749 = extractvalue %LexerState %t748, 1
  %t750 = sitofp i64 1 to double
  %t751 = fadd double %t749, %t750
  %t752 = load %LexerState, %LexerState* %l0
  %t753 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t751, double* %t753
  %t754 = load %LexerState, %LexerState* %l0
  %t755 = extractvalue %LexerState %t754, 3
  %t756 = sitofp i64 1 to double
  %t757 = fadd double %t755, %t756
  %t758 = load %LexerState, %LexerState* %l0
  %t759 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t757, double* %t759
  br label %loop.latch78
loop.latch78:
  br label %loop.header76
afterloop79:
  br label %merge75
merge75:
  br label %merge73
merge73:
  %t760 = load %LexerState, %LexerState* %l0
  %t761 = extractvalue %LexerState %t760, 0
  %t762 = load double, double* %l27
  %t763 = load %LexerState, %LexerState* %l0
  %t764 = extractvalue %LexerState %t763, 1
  %t765 = call i8* @slice(i8* %t761, double %t762, double %t764)
  store i8* %t765, i8** %l31
  %t766 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t767 = insertvalue %TokenKind undef, i32 1, 0
  %t768 = insertvalue %Token undef, %TokenKind %t767, 0
  %t769 = load i8*, i8** %l31
  %t770 = insertvalue %Token %t768, i8* %t769, 1
  %t771 = load double, double* %l28
  %t772 = insertvalue %Token %t770, double %t771, 2
  %t773 = load double, double* %l29
  %t774 = insertvalue %Token %t772, double %t773, 3
  %t775 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t766, %Token %t774)
  store { %Token*, i64 }* %t775, { %Token*, i64 }** %l1
  br label %loop.latch2
merge63:
  %t776 = load i8*, i8** %l2
  %t777 = call i1 @is_identifier_start(i8* %t776)
  %t778 = load %LexerState, %LexerState* %l0
  %t779 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t780 = load i8*, i8** %l2
  br i1 %t777, label %then84, label %merge85
then84:
  %t781 = load %LexerState, %LexerState* %l0
  %t782 = extractvalue %LexerState %t781, 1
  store double %t782, double* %l32
  %t783 = load %LexerState, %LexerState* %l0
  %t784 = extractvalue %LexerState %t783, 2
  store double %t784, double* %l33
  %t785 = load %LexerState, %LexerState* %l0
  %t786 = extractvalue %LexerState %t785, 3
  store double %t786, double* %l34
  %t787 = load %LexerState, %LexerState* %l0
  %t788 = extractvalue %LexerState %t787, 1
  %t789 = sitofp i64 1 to double
  %t790 = fadd double %t788, %t789
  %t791 = load %LexerState, %LexerState* %l0
  %t792 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t790, double* %t792
  %t793 = load %LexerState, %LexerState* %l0
  %t794 = extractvalue %LexerState %t793, 3
  %t795 = sitofp i64 1 to double
  %t796 = fadd double %t794, %t795
  %t797 = load %LexerState, %LexerState* %l0
  %t798 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t796, double* %t798
  %t799 = load %LexerState, %LexerState* %l0
  %t800 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t801 = load i8*, i8** %l2
  %t802 = load double, double* %l32
  %t803 = load double, double* %l33
  %t804 = load double, double* %l34
  br label %loop.header86
loop.header86:
  br label %loop.body87
loop.body87:
  %t805 = load %LexerState, %LexerState* %l0
  %t806 = extractvalue %LexerState %t805, 1
  %t807 = load %LexerState, %LexerState* %l0
  %t808 = extractvalue %LexerState %t807, 0
  %t809 = call i64 @sailfin_runtime_string_length(i8* %t808)
  %t810 = sitofp i64 %t809 to double
  %t811 = fcmp oge double %t806, %t810
  %t812 = load %LexerState, %LexerState* %l0
  %t813 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t814 = load i8*, i8** %l2
  %t815 = load double, double* %l32
  %t816 = load double, double* %l33
  %t817 = load double, double* %l34
  br i1 %t811, label %then90, label %merge91
then90:
  br label %afterloop89
merge91:
  %t818 = load %LexerState, %LexerState* %l0
  %t819 = extractvalue %LexerState %t818, 0
  %t820 = load %LexerState, %LexerState* %l0
  %t821 = extractvalue %LexerState %t820, 1
  %t822 = call i8* @char_at(i8* %t819, double %t821)
  %t823 = call i1 @is_identifier_part(i8* %t822)
  %t824 = xor i1 %t823, 1
  %t825 = load %LexerState, %LexerState* %l0
  %t826 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t827 = load i8*, i8** %l2
  %t828 = load double, double* %l32
  %t829 = load double, double* %l33
  %t830 = load double, double* %l34
  br i1 %t824, label %then92, label %merge93
then92:
  br label %afterloop89
merge93:
  %t831 = load %LexerState, %LexerState* %l0
  %t832 = extractvalue %LexerState %t831, 1
  %t833 = sitofp i64 1 to double
  %t834 = fadd double %t832, %t833
  %t835 = load %LexerState, %LexerState* %l0
  %t836 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t834, double* %t836
  %t837 = load %LexerState, %LexerState* %l0
  %t838 = extractvalue %LexerState %t837, 3
  %t839 = sitofp i64 1 to double
  %t840 = fadd double %t838, %t839
  %t841 = load %LexerState, %LexerState* %l0
  %t842 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t840, double* %t842
  br label %loop.latch88
loop.latch88:
  br label %loop.header86
afterloop89:
  %t843 = load %LexerState, %LexerState* %l0
  %t844 = extractvalue %LexerState %t843, 0
  %t845 = load double, double* %l32
  %t846 = load %LexerState, %LexerState* %l0
  %t847 = extractvalue %LexerState %t846, 1
  %t848 = call i8* @slice(i8* %t844, double %t845, double %t847)
  store i8* %t848, i8** %l35
  %t850 = load i8*, i8** %l35
  %s851 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h275946731, i32 0, i32 0
  %t852 = call i1 @strings_equal(i8* %t850, i8* %s851)
  br label %logical_or_entry_849

logical_or_entry_849:
  br i1 %t852, label %logical_or_merge_849, label %logical_or_right_849

logical_or_right_849:
  %t853 = load i8*, i8** %l35
  %s854 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2095430042, i32 0, i32 0
  %t855 = call i1 @strings_equal(i8* %t853, i8* %s854)
  br label %logical_or_right_end_849

logical_or_right_end_849:
  br label %logical_or_merge_849

logical_or_merge_849:
  %t856 = phi i1 [ true, %logical_or_entry_849 ], [ %t855, %logical_or_right_end_849 ]
  %t857 = load %LexerState, %LexerState* %l0
  %t858 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t859 = load i8*, i8** %l2
  %t860 = load double, double* %l32
  %t861 = load double, double* %l33
  %t862 = load double, double* %l34
  %t863 = load i8*, i8** %l35
  br i1 %t856, label %then94, label %else95
then94:
  %t864 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t865 = insertvalue %TokenKind undef, i32 3, 0
  %t866 = insertvalue %Token undef, %TokenKind %t865, 0
  %t867 = load i8*, i8** %l35
  %t868 = insertvalue %Token %t866, i8* %t867, 1
  %t869 = load double, double* %l33
  %t870 = insertvalue %Token %t868, double %t869, 2
  %t871 = load double, double* %l34
  %t872 = insertvalue %Token %t870, double %t871, 3
  %t873 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t864, %Token %t872)
  store { %Token*, i64 }* %t873, { %Token*, i64 }** %l1
  %t874 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br label %merge96
else95:
  %t875 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t876 = insertvalue %TokenKind undef, i32 0, 0
  %t877 = insertvalue %Token undef, %TokenKind %t876, 0
  %t878 = load i8*, i8** %l35
  %t879 = insertvalue %Token %t877, i8* %t878, 1
  %t880 = load double, double* %l33
  %t881 = insertvalue %Token %t879, double %t880, 2
  %t882 = load double, double* %l34
  %t883 = insertvalue %Token %t881, double %t882, 3
  %t884 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t875, %Token %t883)
  store { %Token*, i64 }* %t884, { %Token*, i64 }** %l1
  %t885 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br label %merge96
merge96:
  %t886 = phi { %Token*, i64 }* [ %t874, %then94 ], [ %t885, %else95 ]
  store { %Token*, i64 }* %t886, { %Token*, i64 }** %l1
  br label %loop.latch2
merge85:
  %t887 = load %LexerState, %LexerState* %l0
  %t888 = extractvalue %LexerState %t887, 2
  store double %t888, double* %l36
  %t889 = load %LexerState, %LexerState* %l0
  %t890 = extractvalue %LexerState %t889, 3
  store double %t890, double* %l37
  %t891 = load i8*, i8** %l2
  store i8* %t891, i8** %l38
  %t892 = load %LexerState, %LexerState* %l0
  %t893 = call i8* @peek_next_char(%LexerState %t892)
  store i8* %t893, i8** %l39
  %t894 = load i8*, i8** %l39
  %s895 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t896 = call i1 @strings_equal(i8* %t894, i8* %s895)
  %t897 = xor i1 %t896, true
  %t898 = load %LexerState, %LexerState* %l0
  %t899 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t900 = load i8*, i8** %l2
  %t901 = load double, double* %l36
  %t902 = load double, double* %l37
  %t903 = load i8*, i8** %l38
  %t904 = load i8*, i8** %l39
  br i1 %t897, label %then97, label %merge98
then97:
  %t905 = load i8*, i8** %l2
  %t906 = load i8*, i8** %l39
  %t907 = call i8* @sailfin_runtime_string_concat(i8* %t905, i8* %t906)
  store i8* %t907, i8** %l40
  %t908 = load i8*, i8** %l40
  %t909 = call i1 @is_two_char_symbol(i8* %t908)
  %t910 = load %LexerState, %LexerState* %l0
  %t911 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t912 = load i8*, i8** %l2
  %t913 = load double, double* %l36
  %t914 = load double, double* %l37
  %t915 = load i8*, i8** %l38
  %t916 = load i8*, i8** %l39
  %t917 = load i8*, i8** %l40
  br i1 %t909, label %then99, label %merge100
then99:
  %t918 = load i8*, i8** %l40
  store i8* %t918, i8** %l38
  %t919 = load %LexerState, %LexerState* %l0
  %t920 = extractvalue %LexerState %t919, 1
  %t921 = sitofp i64 2 to double
  %t922 = fadd double %t920, %t921
  %t923 = load %LexerState, %LexerState* %l0
  %t924 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t922, double* %t924
  %t925 = load %LexerState, %LexerState* %l0
  %t926 = extractvalue %LexerState %t925, 3
  %t927 = sitofp i64 2 to double
  %t928 = fadd double %t926, %t927
  %t929 = load %LexerState, %LexerState* %l0
  %t930 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t928, double* %t930
  %t931 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t932 = insertvalue %TokenKind undef, i32 4, 0
  %t933 = insertvalue %Token undef, %TokenKind %t932, 0
  %t934 = load i8*, i8** %l38
  %t935 = insertvalue %Token %t933, i8* %t934, 1
  %t936 = load double, double* %l36
  %t937 = insertvalue %Token %t935, double %t936, 2
  %t938 = load double, double* %l37
  %t939 = insertvalue %Token %t937, double %t938, 3
  %t940 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t931, %Token %t939)
  store { %Token*, i64 }* %t940, { %Token*, i64 }** %l1
  br label %loop.latch2
merge100:
  %t941 = load i8*, i8** %l38
  %t942 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br label %merge98
merge98:
  %t943 = phi i8* [ %t941, %merge100 ], [ %t903, %merge85 ]
  %t944 = phi { %Token*, i64 }* [ %t942, %merge100 ], [ %t899, %merge85 ]
  store i8* %t943, i8** %l38
  store { %Token*, i64 }* %t944, { %Token*, i64 }** %l1
  %t945 = load %LexerState, %LexerState* %l0
  %t946 = extractvalue %LexerState %t945, 1
  %t947 = sitofp i64 1 to double
  %t948 = fadd double %t946, %t947
  %t949 = load %LexerState, %LexerState* %l0
  %t950 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t948, double* %t950
  %t951 = load i8*, i8** %l2
  %t952 = load i8, i8* %t951
  %t953 = icmp eq i8 %t952, 10
  %t954 = load %LexerState, %LexerState* %l0
  %t955 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t956 = load i8*, i8** %l2
  %t957 = load double, double* %l36
  %t958 = load double, double* %l37
  %t959 = load i8*, i8** %l38
  %t960 = load i8*, i8** %l39
  br i1 %t953, label %then101, label %else102
then101:
  %t961 = load %LexerState, %LexerState* %l0
  %t962 = extractvalue %LexerState %t961, 2
  %t963 = sitofp i64 1 to double
  %t964 = fadd double %t962, %t963
  %t965 = load %LexerState, %LexerState* %l0
  %t966 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 2
  store double %t964, double* %t966
  %t967 = load %LexerState, %LexerState* %l0
  %t968 = sitofp i64 1 to double
  %t969 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t968, double* %t969
  br label %merge103
else102:
  %t970 = load %LexerState, %LexerState* %l0
  %t971 = extractvalue %LexerState %t970, 3
  %t972 = sitofp i64 1 to double
  %t973 = fadd double %t971, %t972
  %t974 = load %LexerState, %LexerState* %l0
  %t975 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t973, double* %t975
  br label %merge103
merge103:
  %t976 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t977 = insertvalue %TokenKind undef, i32 4, 0
  %t978 = insertvalue %Token undef, %TokenKind %t977, 0
  %t979 = load i8*, i8** %l38
  %t980 = insertvalue %Token %t978, i8* %t979, 1
  %t981 = load double, double* %l36
  %t982 = insertvalue %Token %t980, double %t981, 2
  %t983 = load double, double* %l37
  %t984 = insertvalue %Token %t982, double %t983, 3
  %t985 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t976, %Token %t984)
  store { %Token*, i64 }* %t985, { %Token*, i64 }** %l1
  br label %loop.latch2
loop.latch2:
  %t986 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br label %loop.header0
afterloop3:
  %t988 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t989 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t990 = load %LexerState, %LexerState* %l0
  %t991 = extractvalue %LexerState %t990, 2
  %t992 = load %LexerState, %LexerState* %l0
  %t993 = extractvalue %LexerState %t992, 3
  %t994 = call %Token @eof_token(double %t991, double %t993)
  %t995 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t989, %Token %t994)
  store { %Token*, i64 }* %t995, { %Token*, i64 }** %l1
  %t996 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  ret { %Token*, i64 }* %t996
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
  %s9 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %s9)
  ret i8* %s9
merge1:
  %t10 = extractvalue %LexerState %state, 0
  %t11 = load double, double* %l0
  %t12 = call i8* @char_at(i8* %t10, double %t11)
  call void @sailfin_runtime_mark_persistent(i8* %t12)
  ret i8* %t12
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
@.str.len0.h177573 = private unnamed_addr constant [1 x i8] c"\00"
@.str.len5.h2095430042 = private unnamed_addr constant [6 x i8] c"false\00"
@.str.len4.h275946731 = private unnamed_addr constant [5 x i8] c"true\00"