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
  %t1106 = phi { %Token*, i64 }* [ %t20, %block.entry ], [ %t1105, %loop.latch2 ]
  store { %Token*, i64 }* %t1106, { %Token*, i64 }** %l1
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
  %t97 = icmp eq i8 %t96, 10
  %t98 = load %LexerState, %LexerState* %l0
  %t99 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t100 = load i8, i8* %l2
  %t101 = load double, double* %l3
  %t102 = load double, double* %l4
  %t103 = load double, double* %l5
  br i1 %t97, label %then16, label %else17
then16:
  %t104 = load %LexerState, %LexerState* %l0
  %t105 = extractvalue %LexerState %t104, 1
  %t106 = sitofp i64 1 to double
  %t107 = fadd double %t105, %t106
  %t108 = load %LexerState, %LexerState* %l0
  %t109 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t107, double* %t109
  %t110 = load %LexerState, %LexerState* %l0
  %t111 = extractvalue %LexerState %t110, 2
  %t112 = sitofp i64 1 to double
  %t113 = fadd double %t111, %t112
  %t114 = load %LexerState, %LexerState* %l0
  %t115 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 2
  store double %t113, double* %t115
  %t116 = load %LexerState, %LexerState* %l0
  %t117 = sitofp i64 1 to double
  %t118 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t117, double* %t118
  br label %merge18
else17:
  %t119 = load %LexerState, %LexerState* %l0
  %t120 = extractvalue %LexerState %t119, 1
  %t121 = sitofp i64 1 to double
  %t122 = fadd double %t120, %t121
  %t123 = load %LexerState, %LexerState* %l0
  %t124 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t122, double* %t124
  %t125 = load %LexerState, %LexerState* %l0
  %t126 = extractvalue %LexerState %t125, 3
  %t127 = sitofp i64 1 to double
  %t128 = fadd double %t126, %t127
  %t129 = load %LexerState, %LexerState* %l0
  %t130 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t128, double* %t130
  br label %merge18
merge18:
  br label %loop.latch10
loop.latch10:
  br label %loop.header8
afterloop11:
  %t131 = load %LexerState, %LexerState* %l0
  %t132 = extractvalue %LexerState %t131, 0
  %t133 = load double, double* %l3
  %t134 = load %LexerState, %LexerState* %l0
  %t135 = extractvalue %LexerState %t134, 1
  %t136 = call i8* @slice(i8* %t132, double %t133, double %t135)
  store i8* %t136, i8** %l6
  %t137 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t138 = insertvalue %TokenKind undef, i32 5, 0
  %t139 = insertvalue %Token undef, %TokenKind %t138, 0
  %t140 = load i8*, i8** %l6
  %t141 = insertvalue %Token %t139, i8* %t140, 1
  %t142 = load double, double* %l4
  %t143 = insertvalue %Token %t141, double %t142, 2
  %t144 = load double, double* %l5
  %t145 = insertvalue %Token %t143, double %t144, 3
  %t146 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t137, %Token %t145)
  store { %Token*, i64 }* %t146, { %Token*, i64 }** %l1
  br label %loop.latch2
merge7:
  %t147 = load i8, i8* %l2
  %t148 = icmp eq i8 %t147, 47
  %t149 = load %LexerState, %LexerState* %l0
  %t150 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t151 = load i8, i8* %l2
  br i1 %t148, label %then19, label %merge20
then19:
  %t152 = load %LexerState, %LexerState* %l0
  %t153 = call i8* @peek_next_char(%LexerState %t152)
  store i8* %t153, i8** %l7
  %t154 = load i8*, i8** %l7
  %t155 = load i8, i8* %t154
  %t156 = icmp eq i8 %t155, 47
  %t157 = load %LexerState, %LexerState* %l0
  %t158 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t159 = load i8, i8* %l2
  %t160 = load i8*, i8** %l7
  br i1 %t156, label %then21, label %merge22
then21:
  %t161 = load %LexerState, %LexerState* %l0
  %t162 = extractvalue %LexerState %t161, 1
  store double %t162, double* %l8
  %t163 = load %LexerState, %LexerState* %l0
  %t164 = extractvalue %LexerState %t163, 2
  store double %t164, double* %l9
  %t165 = load %LexerState, %LexerState* %l0
  %t166 = extractvalue %LexerState %t165, 3
  store double %t166, double* %l10
  %t167 = load %LexerState, %LexerState* %l0
  %t168 = extractvalue %LexerState %t167, 1
  %t169 = sitofp i64 2 to double
  %t170 = fadd double %t168, %t169
  %t171 = load %LexerState, %LexerState* %l0
  %t172 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t170, double* %t172
  %t173 = load %LexerState, %LexerState* %l0
  %t174 = extractvalue %LexerState %t173, 3
  %t175 = sitofp i64 2 to double
  %t176 = fadd double %t174, %t175
  %t177 = load %LexerState, %LexerState* %l0
  %t178 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t176, double* %t178
  %t179 = load %LexerState, %LexerState* %l0
  %t180 = extractvalue %LexerState %t179, 0
  %t181 = call i64 @sailfin_runtime_string_length(i8* %t180)
  %t182 = sitofp i64 %t181 to double
  store double %t182, double* %l11
  %t183 = load %LexerState, %LexerState* %l0
  %t184 = extractvalue %LexerState %t183, 1
  store double %t184, double* %l12
  %t185 = load %LexerState, %LexerState* %l0
  %t186 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t187 = load i8, i8* %l2
  %t188 = load i8*, i8** %l7
  %t189 = load double, double* %l8
  %t190 = load double, double* %l9
  %t191 = load double, double* %l10
  %t192 = load double, double* %l11
  %t193 = load double, double* %l12
  br label %loop.header23
loop.header23:
  %t237 = phi double [ %t192, %then21 ], [ %t235, %loop.latch25 ]
  %t238 = phi double [ %t193, %then21 ], [ %t236, %loop.latch25 ]
  store double %t237, double* %l11
  store double %t238, double* %l12
  br label %loop.body24
loop.body24:
  %t194 = load double, double* %l12
  %t195 = load %LexerState, %LexerState* %l0
  %t196 = extractvalue %LexerState %t195, 0
  %t197 = call i64 @sailfin_runtime_string_length(i8* %t196)
  %t198 = sitofp i64 %t197 to double
  %t199 = fcmp oge double %t194, %t198
  %t200 = load %LexerState, %LexerState* %l0
  %t201 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t202 = load i8, i8* %l2
  %t203 = load i8*, i8** %l7
  %t204 = load double, double* %l8
  %t205 = load double, double* %l9
  %t206 = load double, double* %l10
  %t207 = load double, double* %l11
  %t208 = load double, double* %l12
  br i1 %t199, label %then27, label %merge28
then27:
  br label %afterloop26
merge28:
  %t209 = load %LexerState, %LexerState* %l0
  %t210 = extractvalue %LexerState %t209, 0
  %t211 = load double, double* %l12
  %t212 = fptosi double %t211 to i64
  %t213 = getelementptr i8, i8* %t210, i64 %t212
  %t214 = load i8, i8* %t213
  store i8 %t214, i8* %l13
  %t216 = load i8, i8* %l13
  %t217 = icmp eq i8 %t216, 10
  br label %logical_or_entry_215

logical_or_entry_215:
  br i1 %t217, label %logical_or_merge_215, label %logical_or_right_215

logical_or_right_215:
  %t218 = load i8, i8* %l13
  %t219 = icmp eq i8 %t218, 13
  br label %logical_or_right_end_215

logical_or_right_end_215:
  br label %logical_or_merge_215

logical_or_merge_215:
  %t220 = phi i1 [ true, %logical_or_entry_215 ], [ %t219, %logical_or_right_end_215 ]
  %t221 = load %LexerState, %LexerState* %l0
  %t222 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t223 = load i8, i8* %l2
  %t224 = load i8*, i8** %l7
  %t225 = load double, double* %l8
  %t226 = load double, double* %l9
  %t227 = load double, double* %l10
  %t228 = load double, double* %l11
  %t229 = load double, double* %l12
  %t230 = load i8, i8* %l13
  br i1 %t220, label %then29, label %merge30
then29:
  %t231 = load double, double* %l12
  store double %t231, double* %l11
  br label %afterloop26
merge30:
  %t232 = load double, double* %l12
  %t233 = sitofp i64 1 to double
  %t234 = fadd double %t232, %t233
  store double %t234, double* %l12
  br label %loop.latch25
loop.latch25:
  %t235 = load double, double* %l11
  %t236 = load double, double* %l12
  br label %loop.header23
afterloop26:
  %t239 = load double, double* %l11
  %t240 = load double, double* %l12
  %t241 = load %LexerState, %LexerState* %l0
  %t242 = extractvalue %LexerState %t241, 0
  %t243 = load double, double* %l8
  %t244 = load double, double* %l11
  %t245 = call i8* @slice(i8* %t242, double %t243, double %t244)
  store i8* %t245, i8** %l14
  %t246 = load double, double* %l11
  %t247 = load %LexerState, %LexerState* %l0
  %t248 = extractvalue %LexerState %t247, 1
  %t249 = fsub double %t246, %t248
  store double %t249, double* %l15
  %t250 = load double, double* %l11
  %t251 = load %LexerState, %LexerState* %l0
  %t252 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t250, double* %t252
  %t253 = load %LexerState, %LexerState* %l0
  %t254 = extractvalue %LexerState %t253, 3
  %t255 = load double, double* %l15
  %t256 = fadd double %t254, %t255
  %t257 = load %LexerState, %LexerState* %l0
  %t258 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t256, double* %t258
  %t259 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t260 = insertvalue %TokenKind undef, i32 6, 0
  %t261 = insertvalue %Token undef, %TokenKind %t260, 0
  %t262 = load i8*, i8** %l14
  %t263 = insertvalue %Token %t261, i8* %t262, 1
  %t264 = load double, double* %l9
  %t265 = insertvalue %Token %t263, double %t264, 2
  %t266 = load double, double* %l10
  %t267 = insertvalue %Token %t265, double %t266, 3
  %t268 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t259, %Token %t267)
  store { %Token*, i64 }* %t268, { %Token*, i64 }** %l1
  br label %loop.latch2
merge22:
  %t269 = load i8*, i8** %l7
  %t270 = load i8, i8* %t269
  %t271 = icmp eq i8 %t270, 42
  %t272 = load %LexerState, %LexerState* %l0
  %t273 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t274 = load i8, i8* %l2
  %t275 = load i8*, i8** %l7
  br i1 %t271, label %then31, label %merge32
then31:
  %t276 = load %LexerState, %LexerState* %l0
  %t277 = extractvalue %LexerState %t276, 1
  store double %t277, double* %l16
  %t278 = load %LexerState, %LexerState* %l0
  %t279 = extractvalue %LexerState %t278, 2
  store double %t279, double* %l17
  %t280 = load %LexerState, %LexerState* %l0
  %t281 = extractvalue %LexerState %t280, 3
  store double %t281, double* %l18
  %t282 = load %LexerState, %LexerState* %l0
  %t283 = extractvalue %LexerState %t282, 1
  %t284 = sitofp i64 2 to double
  %t285 = fadd double %t283, %t284
  %t286 = load %LexerState, %LexerState* %l0
  %t287 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t285, double* %t287
  %t288 = load %LexerState, %LexerState* %l0
  %t289 = extractvalue %LexerState %t288, 3
  %t290 = sitofp i64 2 to double
  %t291 = fadd double %t289, %t290
  %t292 = load %LexerState, %LexerState* %l0
  %t293 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t291, double* %t293
  %t294 = load %LexerState, %LexerState* %l0
  %t295 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t296 = load i8, i8* %l2
  %t297 = load i8*, i8** %l7
  %t298 = load double, double* %l16
  %t299 = load double, double* %l17
  %t300 = load double, double* %l18
  br label %loop.header33
loop.header33:
  br label %loop.body34
loop.body34:
  %t301 = load %LexerState, %LexerState* %l0
  %t302 = extractvalue %LexerState %t301, 1
  %t303 = load %LexerState, %LexerState* %l0
  %t304 = extractvalue %LexerState %t303, 0
  %t305 = call i64 @sailfin_runtime_string_length(i8* %t304)
  %t306 = sitofp i64 %t305 to double
  %t307 = fcmp oge double %t302, %t306
  %t308 = load %LexerState, %LexerState* %l0
  %t309 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t310 = load i8, i8* %l2
  %t311 = load i8*, i8** %l7
  %t312 = load double, double* %l16
  %t313 = load double, double* %l17
  %t314 = load double, double* %l18
  br i1 %t307, label %then37, label %merge38
then37:
  br label %afterloop36
merge38:
  %t316 = load %LexerState, %LexerState* %l0
  %t317 = extractvalue %LexerState %t316, 0
  %t318 = load %LexerState, %LexerState* %l0
  %t319 = extractvalue %LexerState %t318, 1
  %t320 = fptosi double %t319 to i64
  %t321 = getelementptr i8, i8* %t317, i64 %t320
  %t322 = load i8, i8* %t321
  %t323 = icmp eq i8 %t322, 42
  br label %logical_and_entry_315

logical_and_entry_315:
  br i1 %t323, label %logical_and_right_315, label %logical_and_merge_315

logical_and_right_315:
  %t324 = load %LexerState, %LexerState* %l0
  %t325 = call i8* @peek_next_char(%LexerState %t324)
  %t326 = load i8, i8* %t325
  %t327 = icmp eq i8 %t326, 47
  br label %logical_and_right_end_315

logical_and_right_end_315:
  br label %logical_and_merge_315

logical_and_merge_315:
  %t328 = phi i1 [ false, %logical_and_entry_315 ], [ %t327, %logical_and_right_end_315 ]
  %t329 = load %LexerState, %LexerState* %l0
  %t330 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t331 = load i8, i8* %l2
  %t332 = load i8*, i8** %l7
  %t333 = load double, double* %l16
  %t334 = load double, double* %l17
  %t335 = load double, double* %l18
  br i1 %t328, label %then39, label %merge40
then39:
  %t336 = load %LexerState, %LexerState* %l0
  %t337 = extractvalue %LexerState %t336, 1
  %t338 = sitofp i64 2 to double
  %t339 = fadd double %t337, %t338
  %t340 = load %LexerState, %LexerState* %l0
  %t341 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t339, double* %t341
  %t342 = load %LexerState, %LexerState* %l0
  %t343 = extractvalue %LexerState %t342, 3
  %t344 = sitofp i64 2 to double
  %t345 = fadd double %t343, %t344
  %t346 = load %LexerState, %LexerState* %l0
  %t347 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t345, double* %t347
  br label %afterloop36
merge40:
  %t348 = load %LexerState, %LexerState* %l0
  %t349 = extractvalue %LexerState %t348, 0
  %t350 = load %LexerState, %LexerState* %l0
  %t351 = extractvalue %LexerState %t350, 1
  %t352 = fptosi double %t351 to i64
  %t353 = getelementptr i8, i8* %t349, i64 %t352
  %t354 = load i8, i8* %t353
  %t355 = icmp eq i8 %t354, 10
  %t356 = load %LexerState, %LexerState* %l0
  %t357 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t358 = load i8, i8* %l2
  %t359 = load i8*, i8** %l7
  %t360 = load double, double* %l16
  %t361 = load double, double* %l17
  %t362 = load double, double* %l18
  br i1 %t355, label %then41, label %else42
then41:
  %t363 = load %LexerState, %LexerState* %l0
  %t364 = extractvalue %LexerState %t363, 1
  %t365 = sitofp i64 1 to double
  %t366 = fadd double %t364, %t365
  %t367 = load %LexerState, %LexerState* %l0
  %t368 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t366, double* %t368
  %t369 = load %LexerState, %LexerState* %l0
  %t370 = extractvalue %LexerState %t369, 2
  %t371 = sitofp i64 1 to double
  %t372 = fadd double %t370, %t371
  %t373 = load %LexerState, %LexerState* %l0
  %t374 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 2
  store double %t372, double* %t374
  %t375 = load %LexerState, %LexerState* %l0
  %t376 = sitofp i64 1 to double
  %t377 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t376, double* %t377
  br label %merge43
else42:
  %t378 = load %LexerState, %LexerState* %l0
  %t379 = extractvalue %LexerState %t378, 1
  %t380 = sitofp i64 1 to double
  %t381 = fadd double %t379, %t380
  %t382 = load %LexerState, %LexerState* %l0
  %t383 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t381, double* %t383
  %t384 = load %LexerState, %LexerState* %l0
  %t385 = extractvalue %LexerState %t384, 3
  %t386 = sitofp i64 1 to double
  %t387 = fadd double %t385, %t386
  %t388 = load %LexerState, %LexerState* %l0
  %t389 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t387, double* %t389
  br label %merge43
merge43:
  br label %loop.latch35
loop.latch35:
  br label %loop.header33
afterloop36:
  %t390 = load %LexerState, %LexerState* %l0
  %t391 = extractvalue %LexerState %t390, 0
  %t392 = load double, double* %l16
  %t393 = load %LexerState, %LexerState* %l0
  %t394 = extractvalue %LexerState %t393, 1
  %t395 = call i8* @slice(i8* %t391, double %t392, double %t394)
  store i8* %t395, i8** %l19
  %t396 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t397 = insertvalue %TokenKind undef, i32 6, 0
  %t398 = insertvalue %Token undef, %TokenKind %t397, 0
  %t399 = load i8*, i8** %l19
  %t400 = insertvalue %Token %t398, i8* %t399, 1
  %t401 = load double, double* %l17
  %t402 = insertvalue %Token %t400, double %t401, 2
  %t403 = load double, double* %l18
  %t404 = insertvalue %Token %t402, double %t403, 3
  %t405 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t396, %Token %t404)
  store { %Token*, i64 }* %t405, { %Token*, i64 }** %l1
  br label %loop.latch2
merge32:
  %t406 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t407 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br label %merge20
merge20:
  %t408 = phi { %Token*, i64 }* [ %t406, %merge32 ], [ %t150, %merge7 ]
  %t409 = phi { %Token*, i64 }* [ %t407, %merge32 ], [ %t150, %merge7 ]
  store { %Token*, i64 }* %t408, { %Token*, i64 }** %l1
  store { %Token*, i64 }* %t409, { %Token*, i64 }** %l1
  %t410 = load i8, i8* %l2
  %t411 = alloca [2 x i8], align 1
  %t412 = getelementptr [2 x i8], [2 x i8]* %t411, i32 0, i32 0
  store i8 %t410, i8* %t412
  %t413 = getelementptr [2 x i8], [2 x i8]* %t411, i32 0, i32 1
  store i8 0, i8* %t413
  %t414 = getelementptr [2 x i8], [2 x i8]* %t411, i32 0, i32 0
  %t415 = call i1 @is_double_quote(i8* %t414)
  %t416 = load %LexerState, %LexerState* %l0
  %t417 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t418 = load i8, i8* %l2
  br i1 %t415, label %then44, label %merge45
then44:
  %t419 = load %LexerState, %LexerState* %l0
  %t420 = extractvalue %LexerState %t419, 1
  store double %t420, double* %l20
  %t421 = load %LexerState, %LexerState* %l0
  %t422 = extractvalue %LexerState %t421, 2
  store double %t422, double* %l21
  %t423 = load %LexerState, %LexerState* %l0
  %t424 = extractvalue %LexerState %t423, 3
  store double %t424, double* %l22
  %t425 = load %LexerState, %LexerState* %l0
  %t426 = extractvalue %LexerState %t425, 1
  %t427 = sitofp i64 1 to double
  %t428 = fadd double %t426, %t427
  %t429 = load %LexerState, %LexerState* %l0
  %t430 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t428, double* %t430
  %t431 = load %LexerState, %LexerState* %l0
  %t432 = extractvalue %LexerState %t431, 3
  %t433 = sitofp i64 1 to double
  %t434 = fadd double %t432, %t433
  %t435 = load %LexerState, %LexerState* %l0
  %t436 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t434, double* %t436
  %s437 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s437, i8** %l23
  store i1 0, i1* %l24
  %t438 = load %LexerState, %LexerState* %l0
  %t439 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t440 = load i8, i8* %l2
  %t441 = load double, double* %l20
  %t442 = load double, double* %l21
  %t443 = load double, double* %l22
  %t444 = load i8*, i8** %l23
  %t445 = load i1, i1* %l24
  br label %loop.header46
loop.header46:
  %t600 = phi i1 [ %t445, %then44 ], [ %t598, %loop.latch48 ]
  %t601 = phi i8* [ %t444, %then44 ], [ %t599, %loop.latch48 ]
  store i1 %t600, i1* %l24
  store i8* %t601, i8** %l23
  br label %loop.body47
loop.body47:
  %t446 = load %LexerState, %LexerState* %l0
  %t447 = extractvalue %LexerState %t446, 1
  %t448 = load %LexerState, %LexerState* %l0
  %t449 = extractvalue %LexerState %t448, 0
  %t450 = call i64 @sailfin_runtime_string_length(i8* %t449)
  %t451 = sitofp i64 %t450 to double
  %t452 = fcmp oge double %t447, %t451
  %t453 = load %LexerState, %LexerState* %l0
  %t454 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t455 = load i8, i8* %l2
  %t456 = load double, double* %l20
  %t457 = load double, double* %l21
  %t458 = load double, double* %l22
  %t459 = load i8*, i8** %l23
  %t460 = load i1, i1* %l24
  br i1 %t452, label %then50, label %merge51
then50:
  br label %afterloop49
merge51:
  %t461 = load %LexerState, %LexerState* %l0
  %t462 = extractvalue %LexerState %t461, 0
  %t463 = load %LexerState, %LexerState* %l0
  %t464 = extractvalue %LexerState %t463, 1
  %t465 = fptosi double %t464 to i64
  %t466 = getelementptr i8, i8* %t462, i64 %t465
  %t467 = load i8, i8* %t466
  store i8 %t467, i8* %l25
  %t469 = load i1, i1* %l24
  br label %logical_and_entry_468

logical_and_entry_468:
  br i1 %t469, label %logical_and_right_468, label %logical_and_merge_468

logical_and_right_468:
  %t470 = load i8, i8* %l25
  %t471 = alloca [2 x i8], align 1
  %t472 = getelementptr [2 x i8], [2 x i8]* %t471, i32 0, i32 0
  store i8 %t470, i8* %t472
  %t473 = getelementptr [2 x i8], [2 x i8]* %t471, i32 0, i32 1
  store i8 0, i8* %t473
  %t474 = getelementptr [2 x i8], [2 x i8]* %t471, i32 0, i32 0
  %t475 = call i1 @is_double_quote(i8* %t474)
  br label %logical_and_right_end_468

logical_and_right_end_468:
  br label %logical_and_merge_468

logical_and_merge_468:
  %t476 = phi i1 [ false, %logical_and_entry_468 ], [ %t475, %logical_and_right_end_468 ]
  %t477 = xor i1 %t476, 1
  %t478 = load %LexerState, %LexerState* %l0
  %t479 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t480 = load i8, i8* %l2
  %t481 = load double, double* %l20
  %t482 = load double, double* %l21
  %t483 = load double, double* %l22
  %t484 = load i8*, i8** %l23
  %t485 = load i1, i1* %l24
  %t486 = load i8, i8* %l25
  br i1 %t477, label %then52, label %merge53
then52:
  %t487 = load %LexerState, %LexerState* %l0
  %t488 = extractvalue %LexerState %t487, 1
  %t489 = sitofp i64 1 to double
  %t490 = fadd double %t488, %t489
  %t491 = load %LexerState, %LexerState* %l0
  %t492 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t490, double* %t492
  %t493 = load %LexerState, %LexerState* %l0
  %t494 = extractvalue %LexerState %t493, 3
  %t495 = sitofp i64 1 to double
  %t496 = fadd double %t494, %t495
  %t497 = load %LexerState, %LexerState* %l0
  %t498 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t496, double* %t498
  br label %afterloop49
merge53:
  %t500 = load i1, i1* %l24
  br label %logical_and_entry_499

logical_and_entry_499:
  br i1 %t500, label %logical_and_right_499, label %logical_and_merge_499

logical_and_right_499:
  %t501 = load i8, i8* %l25
  %t502 = alloca [2 x i8], align 1
  %t503 = getelementptr [2 x i8], [2 x i8]* %t502, i32 0, i32 0
  store i8 %t501, i8* %t503
  %t504 = getelementptr [2 x i8], [2 x i8]* %t502, i32 0, i32 1
  store i8 0, i8* %t504
  %t505 = getelementptr [2 x i8], [2 x i8]* %t502, i32 0, i32 0
  %t506 = call i1 @is_backslash(i8* %t505)
  br label %logical_and_right_end_499

logical_and_right_end_499:
  br label %logical_and_merge_499

logical_and_merge_499:
  %t507 = phi i1 [ false, %logical_and_entry_499 ], [ %t506, %logical_and_right_end_499 ]
  %t508 = xor i1 %t507, 1
  %t509 = load %LexerState, %LexerState* %l0
  %t510 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t511 = load i8, i8* %l2
  %t512 = load double, double* %l20
  %t513 = load double, double* %l21
  %t514 = load double, double* %l22
  %t515 = load i8*, i8** %l23
  %t516 = load i1, i1* %l24
  %t517 = load i8, i8* %l25
  br i1 %t508, label %then54, label %merge55
then54:
  store i1 1, i1* %l24
  %t518 = load %LexerState, %LexerState* %l0
  %t519 = extractvalue %LexerState %t518, 1
  %t520 = sitofp i64 1 to double
  %t521 = fadd double %t519, %t520
  %t522 = load %LexerState, %LexerState* %l0
  %t523 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t521, double* %t523
  %t524 = load %LexerState, %LexerState* %l0
  %t525 = extractvalue %LexerState %t524, 3
  %t526 = sitofp i64 1 to double
  %t527 = fadd double %t525, %t526
  %t528 = load %LexerState, %LexerState* %l0
  %t529 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t527, double* %t529
  br label %loop.latch48
merge55:
  %t530 = load i1, i1* %l24
  %t531 = load %LexerState, %LexerState* %l0
  %t532 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t533 = load i8, i8* %l2
  %t534 = load double, double* %l20
  %t535 = load double, double* %l21
  %t536 = load double, double* %l22
  %t537 = load i8*, i8** %l23
  %t538 = load i1, i1* %l24
  %t539 = load i8, i8* %l25
  br i1 %t530, label %then56, label %else57
then56:
  %t540 = load i8*, i8** %l23
  %t541 = load i8, i8* %l25
  %t542 = alloca [2 x i8], align 1
  %t543 = getelementptr [2 x i8], [2 x i8]* %t542, i32 0, i32 0
  store i8 %t541, i8* %t543
  %t544 = getelementptr [2 x i8], [2 x i8]* %t542, i32 0, i32 1
  store i8 0, i8* %t544
  %t545 = getelementptr [2 x i8], [2 x i8]* %t542, i32 0, i32 0
  %t546 = call i8* @interpret_escape(i8* %t545)
  %t547 = call i8* @sailfin_runtime_string_concat(i8* %t540, i8* %t546)
  store i8* %t547, i8** %l23
  store i1 0, i1* %l24
  %t548 = load i8*, i8** %l23
  %t549 = load i1, i1* %l24
  br label %merge58
else57:
  %t550 = load i8*, i8** %l23
  %t551 = load i8, i8* %l25
  %t552 = alloca [2 x i8], align 1
  %t553 = getelementptr [2 x i8], [2 x i8]* %t552, i32 0, i32 0
  store i8 %t551, i8* %t553
  %t554 = getelementptr [2 x i8], [2 x i8]* %t552, i32 0, i32 1
  store i8 0, i8* %t554
  %t555 = getelementptr [2 x i8], [2 x i8]* %t552, i32 0, i32 0
  %t556 = call i8* @sailfin_runtime_string_concat(i8* %t550, i8* %t555)
  store i8* %t556, i8** %l23
  %t557 = load i8*, i8** %l23
  br label %merge58
merge58:
  %t558 = phi i8* [ %t548, %then56 ], [ %t557, %else57 ]
  %t559 = phi i1 [ %t549, %then56 ], [ %t538, %else57 ]
  store i8* %t558, i8** %l23
  store i1 %t559, i1* %l24
  %t560 = load i8, i8* %l25
  %t561 = icmp eq i8 %t560, 10
  %t562 = load %LexerState, %LexerState* %l0
  %t563 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t564 = load i8, i8* %l2
  %t565 = load double, double* %l20
  %t566 = load double, double* %l21
  %t567 = load double, double* %l22
  %t568 = load i8*, i8** %l23
  %t569 = load i1, i1* %l24
  %t570 = load i8, i8* %l25
  br i1 %t561, label %then59, label %else60
then59:
  %t571 = load %LexerState, %LexerState* %l0
  %t572 = extractvalue %LexerState %t571, 1
  %t573 = sitofp i64 1 to double
  %t574 = fadd double %t572, %t573
  %t575 = load %LexerState, %LexerState* %l0
  %t576 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t574, double* %t576
  %t577 = load %LexerState, %LexerState* %l0
  %t578 = extractvalue %LexerState %t577, 2
  %t579 = sitofp i64 1 to double
  %t580 = fadd double %t578, %t579
  %t581 = load %LexerState, %LexerState* %l0
  %t582 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 2
  store double %t580, double* %t582
  %t583 = load %LexerState, %LexerState* %l0
  %t584 = sitofp i64 1 to double
  %t585 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t584, double* %t585
  br label %merge61
else60:
  %t586 = load %LexerState, %LexerState* %l0
  %t587 = extractvalue %LexerState %t586, 1
  %t588 = sitofp i64 1 to double
  %t589 = fadd double %t587, %t588
  %t590 = load %LexerState, %LexerState* %l0
  %t591 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t589, double* %t591
  %t592 = load %LexerState, %LexerState* %l0
  %t593 = extractvalue %LexerState %t592, 3
  %t594 = sitofp i64 1 to double
  %t595 = fadd double %t593, %t594
  %t596 = load %LexerState, %LexerState* %l0
  %t597 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t595, double* %t597
  br label %merge61
merge61:
  br label %loop.latch48
loop.latch48:
  %t598 = load i1, i1* %l24
  %t599 = load i8*, i8** %l23
  br label %loop.header46
afterloop49:
  %t602 = load i1, i1* %l24
  %t603 = load i8*, i8** %l23
  %t604 = load %LexerState, %LexerState* %l0
  %t605 = extractvalue %LexerState %t604, 0
  %t606 = load double, double* %l20
  %t607 = load %LexerState, %LexerState* %l0
  %t608 = extractvalue %LexerState %t607, 1
  %t609 = call i8* @slice(i8* %t605, double %t606, double %t608)
  store i8* %t609, i8** %l26
  %t610 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t611 = alloca %TokenKind
  %t612 = getelementptr inbounds %TokenKind, %TokenKind* %t611, i32 0, i32 0
  store i32 2, i32* %t612
  %t613 = load i8*, i8** %l23
  %t614 = getelementptr inbounds %TokenKind, %TokenKind* %t611, i32 0, i32 1
  %t615 = bitcast [8 x i8]* %t614 to i8*
  %t616 = bitcast i8* %t615 to i8**
  store i8* %t613, i8** %t616
  %t617 = load %TokenKind, %TokenKind* %t611
  %t618 = insertvalue %Token undef, %TokenKind %t617, 0
  %t619 = load i8*, i8** %l26
  %t620 = insertvalue %Token %t618, i8* %t619, 1
  %t621 = load double, double* %l21
  %t622 = insertvalue %Token %t620, double %t621, 2
  %t623 = load double, double* %l22
  %t624 = insertvalue %Token %t622, double %t623, 3
  %t625 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t610, %Token %t624)
  store { %Token*, i64 }* %t625, { %Token*, i64 }** %l1
  br label %loop.latch2
merge45:
  %t626 = load i8, i8* %l2
  %t627 = alloca [2 x i8], align 1
  %t628 = getelementptr [2 x i8], [2 x i8]* %t627, i32 0, i32 0
  store i8 %t626, i8* %t628
  %t629 = getelementptr [2 x i8], [2 x i8]* %t627, i32 0, i32 1
  store i8 0, i8* %t629
  %t630 = getelementptr [2 x i8], [2 x i8]* %t627, i32 0, i32 0
  %t631 = call i1 @is_digit(i8* %t630)
  %t632 = load %LexerState, %LexerState* %l0
  %t633 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t634 = load i8, i8* %l2
  br i1 %t631, label %then62, label %merge63
then62:
  %t635 = load %LexerState, %LexerState* %l0
  %t636 = extractvalue %LexerState %t635, 1
  store double %t636, double* %l27
  %t637 = load %LexerState, %LexerState* %l0
  %t638 = extractvalue %LexerState %t637, 2
  store double %t638, double* %l28
  %t639 = load %LexerState, %LexerState* %l0
  %t640 = extractvalue %LexerState %t639, 3
  store double %t640, double* %l29
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
  %t653 = load %LexerState, %LexerState* %l0
  %t654 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t655 = load i8, i8* %l2
  %t656 = load double, double* %l27
  %t657 = load double, double* %l28
  %t658 = load double, double* %l29
  br label %loop.header64
loop.header64:
  br label %loop.body65
loop.body65:
  %t659 = load %LexerState, %LexerState* %l0
  %t660 = extractvalue %LexerState %t659, 1
  %t661 = load %LexerState, %LexerState* %l0
  %t662 = extractvalue %LexerState %t661, 0
  %t663 = call i64 @sailfin_runtime_string_length(i8* %t662)
  %t664 = sitofp i64 %t663 to double
  %t665 = fcmp oge double %t660, %t664
  %t666 = load %LexerState, %LexerState* %l0
  %t667 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t668 = load i8, i8* %l2
  %t669 = load double, double* %l27
  %t670 = load double, double* %l28
  %t671 = load double, double* %l29
  br i1 %t665, label %then68, label %merge69
then68:
  br label %afterloop67
merge69:
  %t672 = load %LexerState, %LexerState* %l0
  %t673 = extractvalue %LexerState %t672, 0
  %t674 = load %LexerState, %LexerState* %l0
  %t675 = extractvalue %LexerState %t674, 1
  %t676 = fptosi double %t675 to i64
  %t677 = getelementptr i8, i8* %t673, i64 %t676
  %t678 = load i8, i8* %t677
  %t679 = alloca [2 x i8], align 1
  %t680 = getelementptr [2 x i8], [2 x i8]* %t679, i32 0, i32 0
  store i8 %t678, i8* %t680
  %t681 = getelementptr [2 x i8], [2 x i8]* %t679, i32 0, i32 1
  store i8 0, i8* %t681
  %t682 = getelementptr [2 x i8], [2 x i8]* %t679, i32 0, i32 0
  %t683 = call i1 @is_digit(i8* %t682)
  %t684 = xor i1 %t683, 1
  %t685 = load %LexerState, %LexerState* %l0
  %t686 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t687 = load i8, i8* %l2
  %t688 = load double, double* %l27
  %t689 = load double, double* %l28
  %t690 = load double, double* %l29
  br i1 %t684, label %then70, label %merge71
then70:
  br label %afterloop67
merge71:
  %t691 = load %LexerState, %LexerState* %l0
  %t692 = extractvalue %LexerState %t691, 1
  %t693 = sitofp i64 1 to double
  %t694 = fadd double %t692, %t693
  %t695 = load %LexerState, %LexerState* %l0
  %t696 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t694, double* %t696
  %t697 = load %LexerState, %LexerState* %l0
  %t698 = extractvalue %LexerState %t697, 3
  %t699 = sitofp i64 1 to double
  %t700 = fadd double %t698, %t699
  %t701 = load %LexerState, %LexerState* %l0
  %t702 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t700, double* %t702
  br label %loop.latch66
loop.latch66:
  br label %loop.header64
afterloop67:
  %t704 = load %LexerState, %LexerState* %l0
  %t705 = extractvalue %LexerState %t704, 1
  %t706 = load %LexerState, %LexerState* %l0
  %t707 = extractvalue %LexerState %t706, 0
  %t708 = call i64 @sailfin_runtime_string_length(i8* %t707)
  %t709 = sitofp i64 %t708 to double
  %t710 = fcmp olt double %t705, %t709
  br label %logical_and_entry_703

logical_and_entry_703:
  br i1 %t710, label %logical_and_right_703, label %logical_and_merge_703

logical_and_right_703:
  %t711 = load %LexerState, %LexerState* %l0
  %t712 = extractvalue %LexerState %t711, 0
  %t713 = load %LexerState, %LexerState* %l0
  %t714 = extractvalue %LexerState %t713, 1
  %t715 = fptosi double %t714 to i64
  %t716 = getelementptr i8, i8* %t712, i64 %t715
  %t717 = load i8, i8* %t716
  %t718 = icmp eq i8 %t717, 46
  br label %logical_and_right_end_703

logical_and_right_end_703:
  br label %logical_and_merge_703

logical_and_merge_703:
  %t719 = phi i1 [ false, %logical_and_entry_703 ], [ %t718, %logical_and_right_end_703 ]
  %t720 = load %LexerState, %LexerState* %l0
  %t721 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t722 = load i8, i8* %l2
  %t723 = load double, double* %l27
  %t724 = load double, double* %l28
  %t725 = load double, double* %l29
  br i1 %t719, label %then72, label %merge73
then72:
  %t727 = load %LexerState, %LexerState* %l0
  %t728 = extractvalue %LexerState %t727, 1
  %t729 = sitofp i64 1 to double
  %t730 = fadd double %t728, %t729
  %t731 = load %LexerState, %LexerState* %l0
  %t732 = extractvalue %LexerState %t731, 0
  %t733 = call i64 @sailfin_runtime_string_length(i8* %t732)
  %t734 = sitofp i64 %t733 to double
  %t735 = fcmp olt double %t730, %t734
  br label %logical_and_entry_726

logical_and_entry_726:
  br i1 %t735, label %logical_and_right_726, label %logical_and_merge_726

logical_and_right_726:
  %t736 = load %LexerState, %LexerState* %l0
  %t737 = extractvalue %LexerState %t736, 0
  %t738 = load %LexerState, %LexerState* %l0
  %t739 = extractvalue %LexerState %t738, 1
  %t740 = sitofp i64 1 to double
  %t741 = fadd double %t739, %t740
  %t742 = fptosi double %t741 to i64
  %t743 = getelementptr i8, i8* %t737, i64 %t742
  %t744 = load i8, i8* %t743
  %t745 = alloca [2 x i8], align 1
  %t746 = getelementptr [2 x i8], [2 x i8]* %t745, i32 0, i32 0
  store i8 %t744, i8* %t746
  %t747 = getelementptr [2 x i8], [2 x i8]* %t745, i32 0, i32 1
  store i8 0, i8* %t747
  %t748 = getelementptr [2 x i8], [2 x i8]* %t745, i32 0, i32 0
  %t749 = call i1 @is_digit(i8* %t748)
  br label %logical_and_right_end_726

logical_and_right_end_726:
  br label %logical_and_merge_726

logical_and_merge_726:
  %t750 = phi i1 [ false, %logical_and_entry_726 ], [ %t749, %logical_and_right_end_726 ]
  store i1 %t750, i1* %l30
  %t751 = load i1, i1* %l30
  %t752 = load %LexerState, %LexerState* %l0
  %t753 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t754 = load i8, i8* %l2
  %t755 = load double, double* %l27
  %t756 = load double, double* %l28
  %t757 = load double, double* %l29
  %t758 = load i1, i1* %l30
  br i1 %t751, label %then74, label %merge75
then74:
  %t759 = load %LexerState, %LexerState* %l0
  %t760 = extractvalue %LexerState %t759, 1
  %t761 = sitofp i64 1 to double
  %t762 = fadd double %t760, %t761
  %t763 = load %LexerState, %LexerState* %l0
  %t764 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t762, double* %t764
  %t765 = load %LexerState, %LexerState* %l0
  %t766 = extractvalue %LexerState %t765, 3
  %t767 = sitofp i64 1 to double
  %t768 = fadd double %t766, %t767
  %t769 = load %LexerState, %LexerState* %l0
  %t770 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t768, double* %t770
  %t771 = load %LexerState, %LexerState* %l0
  %t772 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t773 = load i8, i8* %l2
  %t774 = load double, double* %l27
  %t775 = load double, double* %l28
  %t776 = load double, double* %l29
  %t777 = load i1, i1* %l30
  br label %loop.header76
loop.header76:
  br label %loop.body77
loop.body77:
  %t778 = load %LexerState, %LexerState* %l0
  %t779 = extractvalue %LexerState %t778, 1
  %t780 = load %LexerState, %LexerState* %l0
  %t781 = extractvalue %LexerState %t780, 0
  %t782 = call i64 @sailfin_runtime_string_length(i8* %t781)
  %t783 = sitofp i64 %t782 to double
  %t784 = fcmp oge double %t779, %t783
  %t785 = load %LexerState, %LexerState* %l0
  %t786 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t787 = load i8, i8* %l2
  %t788 = load double, double* %l27
  %t789 = load double, double* %l28
  %t790 = load double, double* %l29
  %t791 = load i1, i1* %l30
  br i1 %t784, label %then80, label %merge81
then80:
  br label %afterloop79
merge81:
  %t792 = load %LexerState, %LexerState* %l0
  %t793 = extractvalue %LexerState %t792, 0
  %t794 = load %LexerState, %LexerState* %l0
  %t795 = extractvalue %LexerState %t794, 1
  %t796 = fptosi double %t795 to i64
  %t797 = getelementptr i8, i8* %t793, i64 %t796
  %t798 = load i8, i8* %t797
  %t799 = alloca [2 x i8], align 1
  %t800 = getelementptr [2 x i8], [2 x i8]* %t799, i32 0, i32 0
  store i8 %t798, i8* %t800
  %t801 = getelementptr [2 x i8], [2 x i8]* %t799, i32 0, i32 1
  store i8 0, i8* %t801
  %t802 = getelementptr [2 x i8], [2 x i8]* %t799, i32 0, i32 0
  %t803 = call i1 @is_digit(i8* %t802)
  %t804 = xor i1 %t803, 1
  %t805 = load %LexerState, %LexerState* %l0
  %t806 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t807 = load i8, i8* %l2
  %t808 = load double, double* %l27
  %t809 = load double, double* %l28
  %t810 = load double, double* %l29
  %t811 = load i1, i1* %l30
  br i1 %t804, label %then82, label %merge83
then82:
  br label %afterloop79
merge83:
  %t812 = load %LexerState, %LexerState* %l0
  %t813 = extractvalue %LexerState %t812, 1
  %t814 = sitofp i64 1 to double
  %t815 = fadd double %t813, %t814
  %t816 = load %LexerState, %LexerState* %l0
  %t817 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t815, double* %t817
  %t818 = load %LexerState, %LexerState* %l0
  %t819 = extractvalue %LexerState %t818, 3
  %t820 = sitofp i64 1 to double
  %t821 = fadd double %t819, %t820
  %t822 = load %LexerState, %LexerState* %l0
  %t823 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t821, double* %t823
  br label %loop.latch78
loop.latch78:
  br label %loop.header76
afterloop79:
  br label %merge75
merge75:
  br label %merge73
merge73:
  %t824 = load %LexerState, %LexerState* %l0
  %t825 = extractvalue %LexerState %t824, 0
  %t826 = load double, double* %l27
  %t827 = load %LexerState, %LexerState* %l0
  %t828 = extractvalue %LexerState %t827, 1
  %t829 = call i8* @slice(i8* %t825, double %t826, double %t828)
  store i8* %t829, i8** %l31
  %t830 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t831 = alloca %TokenKind
  %t832 = getelementptr inbounds %TokenKind, %TokenKind* %t831, i32 0, i32 0
  store i32 1, i32* %t832
  %t833 = load i8*, i8** %l31
  %t834 = getelementptr inbounds %TokenKind, %TokenKind* %t831, i32 0, i32 1
  %t835 = bitcast [8 x i8]* %t834 to i8*
  %t836 = bitcast i8* %t835 to i8**
  store i8* %t833, i8** %t836
  %t837 = load %TokenKind, %TokenKind* %t831
  %t838 = insertvalue %Token undef, %TokenKind %t837, 0
  %t839 = load i8*, i8** %l31
  %t840 = insertvalue %Token %t838, i8* %t839, 1
  %t841 = load double, double* %l28
  %t842 = insertvalue %Token %t840, double %t841, 2
  %t843 = load double, double* %l29
  %t844 = insertvalue %Token %t842, double %t843, 3
  %t845 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t830, %Token %t844)
  store { %Token*, i64 }* %t845, { %Token*, i64 }** %l1
  br label %loop.latch2
merge63:
  %t846 = load i8, i8* %l2
  %t847 = alloca [2 x i8], align 1
  %t848 = getelementptr [2 x i8], [2 x i8]* %t847, i32 0, i32 0
  store i8 %t846, i8* %t848
  %t849 = getelementptr [2 x i8], [2 x i8]* %t847, i32 0, i32 1
  store i8 0, i8* %t849
  %t850 = getelementptr [2 x i8], [2 x i8]* %t847, i32 0, i32 0
  %t851 = call i1 @is_identifier_start(i8* %t850)
  %t852 = load %LexerState, %LexerState* %l0
  %t853 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t854 = load i8, i8* %l2
  br i1 %t851, label %then84, label %merge85
then84:
  %t855 = load %LexerState, %LexerState* %l0
  %t856 = extractvalue %LexerState %t855, 1
  store double %t856, double* %l32
  %t857 = load %LexerState, %LexerState* %l0
  %t858 = extractvalue %LexerState %t857, 2
  store double %t858, double* %l33
  %t859 = load %LexerState, %LexerState* %l0
  %t860 = extractvalue %LexerState %t859, 3
  store double %t860, double* %l34
  %t861 = load %LexerState, %LexerState* %l0
  %t862 = extractvalue %LexerState %t861, 1
  %t863 = sitofp i64 1 to double
  %t864 = fadd double %t862, %t863
  %t865 = load %LexerState, %LexerState* %l0
  %t866 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t864, double* %t866
  %t867 = load %LexerState, %LexerState* %l0
  %t868 = extractvalue %LexerState %t867, 3
  %t869 = sitofp i64 1 to double
  %t870 = fadd double %t868, %t869
  %t871 = load %LexerState, %LexerState* %l0
  %t872 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t870, double* %t872
  %t873 = load %LexerState, %LexerState* %l0
  %t874 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t875 = load i8, i8* %l2
  %t876 = load double, double* %l32
  %t877 = load double, double* %l33
  %t878 = load double, double* %l34
  br label %loop.header86
loop.header86:
  br label %loop.body87
loop.body87:
  %t879 = load %LexerState, %LexerState* %l0
  %t880 = extractvalue %LexerState %t879, 1
  %t881 = load %LexerState, %LexerState* %l0
  %t882 = extractvalue %LexerState %t881, 0
  %t883 = call i64 @sailfin_runtime_string_length(i8* %t882)
  %t884 = sitofp i64 %t883 to double
  %t885 = fcmp oge double %t880, %t884
  %t886 = load %LexerState, %LexerState* %l0
  %t887 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t888 = load i8, i8* %l2
  %t889 = load double, double* %l32
  %t890 = load double, double* %l33
  %t891 = load double, double* %l34
  br i1 %t885, label %then90, label %merge91
then90:
  br label %afterloop89
merge91:
  %t892 = load %LexerState, %LexerState* %l0
  %t893 = extractvalue %LexerState %t892, 0
  %t894 = load %LexerState, %LexerState* %l0
  %t895 = extractvalue %LexerState %t894, 1
  %t896 = fptosi double %t895 to i64
  %t897 = getelementptr i8, i8* %t893, i64 %t896
  %t898 = load i8, i8* %t897
  %t899 = alloca [2 x i8], align 1
  %t900 = getelementptr [2 x i8], [2 x i8]* %t899, i32 0, i32 0
  store i8 %t898, i8* %t900
  %t901 = getelementptr [2 x i8], [2 x i8]* %t899, i32 0, i32 1
  store i8 0, i8* %t901
  %t902 = getelementptr [2 x i8], [2 x i8]* %t899, i32 0, i32 0
  %t903 = call i1 @is_identifier_part(i8* %t902)
  %t904 = xor i1 %t903, 1
  %t905 = load %LexerState, %LexerState* %l0
  %t906 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t907 = load i8, i8* %l2
  %t908 = load double, double* %l32
  %t909 = load double, double* %l33
  %t910 = load double, double* %l34
  br i1 %t904, label %then92, label %merge93
then92:
  br label %afterloop89
merge93:
  %t911 = load %LexerState, %LexerState* %l0
  %t912 = extractvalue %LexerState %t911, 1
  %t913 = sitofp i64 1 to double
  %t914 = fadd double %t912, %t913
  %t915 = load %LexerState, %LexerState* %l0
  %t916 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t914, double* %t916
  %t917 = load %LexerState, %LexerState* %l0
  %t918 = extractvalue %LexerState %t917, 3
  %t919 = sitofp i64 1 to double
  %t920 = fadd double %t918, %t919
  %t921 = load %LexerState, %LexerState* %l0
  %t922 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t920, double* %t922
  br label %loop.latch88
loop.latch88:
  br label %loop.header86
afterloop89:
  %t923 = load %LexerState, %LexerState* %l0
  %t924 = extractvalue %LexerState %t923, 0
  %t925 = load double, double* %l32
  %t926 = load %LexerState, %LexerState* %l0
  %t927 = extractvalue %LexerState %t926, 1
  %t928 = call i8* @slice(i8* %t924, double %t925, double %t927)
  store i8* %t928, i8** %l35
  %t930 = load i8*, i8** %l35
  %s931 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h275946731, i32 0, i32 0
  %t932 = icmp eq i8* %t930, %s931
  br label %logical_or_entry_929

logical_or_entry_929:
  br i1 %t932, label %logical_or_merge_929, label %logical_or_right_929

logical_or_right_929:
  %t933 = load i8*, i8** %l35
  %s934 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2095430042, i32 0, i32 0
  %t935 = icmp eq i8* %t933, %s934
  br label %logical_or_right_end_929

logical_or_right_end_929:
  br label %logical_or_merge_929

logical_or_merge_929:
  %t936 = phi i1 [ true, %logical_or_entry_929 ], [ %t935, %logical_or_right_end_929 ]
  %t937 = load %LexerState, %LexerState* %l0
  %t938 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t939 = load i8, i8* %l2
  %t940 = load double, double* %l32
  %t941 = load double, double* %l33
  %t942 = load double, double* %l34
  %t943 = load i8*, i8** %l35
  br i1 %t936, label %then94, label %else95
then94:
  %t944 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t945 = alloca %TokenKind
  %t946 = getelementptr inbounds %TokenKind, %TokenKind* %t945, i32 0, i32 0
  store i32 3, i32* %t946
  %t947 = load i8*, i8** %l35
  %t948 = getelementptr inbounds %TokenKind, %TokenKind* %t945, i32 0, i32 1
  %t949 = bitcast [8 x i8]* %t948 to i8*
  %t950 = bitcast i8* %t949 to i8**
  store i8* %t947, i8** %t950
  %t951 = load %TokenKind, %TokenKind* %t945
  %t952 = insertvalue %Token undef, %TokenKind %t951, 0
  %t953 = load i8*, i8** %l35
  %t954 = insertvalue %Token %t952, i8* %t953, 1
  %t955 = load double, double* %l33
  %t956 = insertvalue %Token %t954, double %t955, 2
  %t957 = load double, double* %l34
  %t958 = insertvalue %Token %t956, double %t957, 3
  %t959 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t944, %Token %t958)
  store { %Token*, i64 }* %t959, { %Token*, i64 }** %l1
  %t960 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br label %merge96
else95:
  %t961 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t962 = alloca %TokenKind
  %t963 = getelementptr inbounds %TokenKind, %TokenKind* %t962, i32 0, i32 0
  store i32 0, i32* %t963
  %t964 = load i8*, i8** %l35
  %t965 = getelementptr inbounds %TokenKind, %TokenKind* %t962, i32 0, i32 1
  %t966 = bitcast [8 x i8]* %t965 to i8*
  %t967 = bitcast i8* %t966 to i8**
  store i8* %t964, i8** %t967
  %t968 = load %TokenKind, %TokenKind* %t962
  %t969 = insertvalue %Token undef, %TokenKind %t968, 0
  %t970 = load i8*, i8** %l35
  %t971 = insertvalue %Token %t969, i8* %t970, 1
  %t972 = load double, double* %l33
  %t973 = insertvalue %Token %t971, double %t972, 2
  %t974 = load double, double* %l34
  %t975 = insertvalue %Token %t973, double %t974, 3
  %t976 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t961, %Token %t975)
  store { %Token*, i64 }* %t976, { %Token*, i64 }** %l1
  %t977 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br label %merge96
merge96:
  %t978 = phi { %Token*, i64 }* [ %t960, %then94 ], [ %t977, %else95 ]
  store { %Token*, i64 }* %t978, { %Token*, i64 }** %l1
  br label %loop.latch2
merge85:
  %t979 = load %LexerState, %LexerState* %l0
  %t980 = extractvalue %LexerState %t979, 2
  store double %t980, double* %l36
  %t981 = load %LexerState, %LexerState* %l0
  %t982 = extractvalue %LexerState %t981, 3
  store double %t982, double* %l37
  %t983 = load i8, i8* %l2
  store i8 %t983, i8* %l38
  %t984 = load %LexerState, %LexerState* %l0
  %t985 = call i8* @peek_next_char(%LexerState %t984)
  store i8* %t985, i8** %l39
  %t986 = load i8*, i8** %l39
  %s987 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t988 = icmp ne i8* %t986, %s987
  %t989 = load %LexerState, %LexerState* %l0
  %t990 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t991 = load i8, i8* %l2
  %t992 = load double, double* %l36
  %t993 = load double, double* %l37
  %t994 = load i8, i8* %l38
  %t995 = load i8*, i8** %l39
  br i1 %t988, label %then97, label %merge98
then97:
  %t996 = load i8, i8* %l2
  %t997 = load i8*, i8** %l39
  %t998 = alloca [2 x i8], align 1
  %t999 = getelementptr [2 x i8], [2 x i8]* %t998, i32 0, i32 0
  store i8 %t996, i8* %t999
  %t1000 = getelementptr [2 x i8], [2 x i8]* %t998, i32 0, i32 1
  store i8 0, i8* %t1000
  %t1001 = getelementptr [2 x i8], [2 x i8]* %t998, i32 0, i32 0
  %t1002 = call i8* @sailfin_runtime_string_concat(i8* %t1001, i8* %t997)
  store i8* %t1002, i8** %l40
  %t1003 = load i8*, i8** %l40
  %t1004 = call i1 @is_two_char_symbol(i8* %t1003)
  %t1005 = load %LexerState, %LexerState* %l0
  %t1006 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t1007 = load i8, i8* %l2
  %t1008 = load double, double* %l36
  %t1009 = load double, double* %l37
  %t1010 = load i8, i8* %l38
  %t1011 = load i8*, i8** %l39
  %t1012 = load i8*, i8** %l40
  br i1 %t1004, label %then99, label %merge100
then99:
  %t1013 = load i8*, i8** %l40
  %t1014 = load i8, i8* %t1013
  store i8 %t1014, i8* %l38
  %t1015 = load %LexerState, %LexerState* %l0
  %t1016 = extractvalue %LexerState %t1015, 1
  %t1017 = sitofp i64 2 to double
  %t1018 = fadd double %t1016, %t1017
  %t1019 = load %LexerState, %LexerState* %l0
  %t1020 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t1018, double* %t1020
  %t1021 = load %LexerState, %LexerState* %l0
  %t1022 = extractvalue %LexerState %t1021, 3
  %t1023 = sitofp i64 2 to double
  %t1024 = fadd double %t1022, %t1023
  %t1025 = load %LexerState, %LexerState* %l0
  %t1026 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t1024, double* %t1026
  %t1027 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t1028 = alloca %TokenKind
  %t1029 = getelementptr inbounds %TokenKind, %TokenKind* %t1028, i32 0, i32 0
  store i32 4, i32* %t1029
  %t1030 = load i8, i8* %l38
  %t1031 = call noalias i8* @malloc(i64 1)
  %t1032 = bitcast i8* %t1031 to i8*
  store i8 %t1030, i8* %t1032
  %t1033 = getelementptr inbounds %TokenKind, %TokenKind* %t1028, i32 0, i32 1
  %t1034 = bitcast [8 x i8]* %t1033 to i8*
  %t1035 = bitcast i8* %t1034 to i8**
  store i8* %t1031, i8** %t1035
  %t1036 = load %TokenKind, %TokenKind* %t1028
  %t1037 = insertvalue %Token undef, %TokenKind %t1036, 0
  %t1038 = load i8, i8* %l38
  %t1039 = alloca [2 x i8], align 1
  %t1040 = getelementptr [2 x i8], [2 x i8]* %t1039, i32 0, i32 0
  store i8 %t1038, i8* %t1040
  %t1041 = getelementptr [2 x i8], [2 x i8]* %t1039, i32 0, i32 1
  store i8 0, i8* %t1041
  %t1042 = getelementptr [2 x i8], [2 x i8]* %t1039, i32 0, i32 0
  %t1043 = insertvalue %Token %t1037, i8* %t1042, 1
  %t1044 = load double, double* %l36
  %t1045 = insertvalue %Token %t1043, double %t1044, 2
  %t1046 = load double, double* %l37
  %t1047 = insertvalue %Token %t1045, double %t1046, 3
  %t1048 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t1027, %Token %t1047)
  store { %Token*, i64 }* %t1048, { %Token*, i64 }** %l1
  br label %loop.latch2
merge100:
  %t1049 = load i8, i8* %l38
  %t1050 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br label %merge98
merge98:
  %t1051 = phi i8 [ %t1049, %merge100 ], [ %t994, %merge85 ]
  %t1052 = phi { %Token*, i64 }* [ %t1050, %merge100 ], [ %t990, %merge85 ]
  store i8 %t1051, i8* %l38
  store { %Token*, i64 }* %t1052, { %Token*, i64 }** %l1
  %t1053 = load %LexerState, %LexerState* %l0
  %t1054 = extractvalue %LexerState %t1053, 1
  %t1055 = sitofp i64 1 to double
  %t1056 = fadd double %t1054, %t1055
  %t1057 = load %LexerState, %LexerState* %l0
  %t1058 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t1056, double* %t1058
  %t1059 = load i8, i8* %l2
  %t1060 = icmp eq i8 %t1059, 10
  %t1061 = load %LexerState, %LexerState* %l0
  %t1062 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t1063 = load i8, i8* %l2
  %t1064 = load double, double* %l36
  %t1065 = load double, double* %l37
  %t1066 = load i8, i8* %l38
  %t1067 = load i8*, i8** %l39
  br i1 %t1060, label %then101, label %else102
then101:
  %t1068 = load %LexerState, %LexerState* %l0
  %t1069 = extractvalue %LexerState %t1068, 2
  %t1070 = sitofp i64 1 to double
  %t1071 = fadd double %t1069, %t1070
  %t1072 = load %LexerState, %LexerState* %l0
  %t1073 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 2
  store double %t1071, double* %t1073
  %t1074 = load %LexerState, %LexerState* %l0
  %t1075 = sitofp i64 1 to double
  %t1076 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t1075, double* %t1076
  br label %merge103
else102:
  %t1077 = load %LexerState, %LexerState* %l0
  %t1078 = extractvalue %LexerState %t1077, 3
  %t1079 = sitofp i64 1 to double
  %t1080 = fadd double %t1078, %t1079
  %t1081 = load %LexerState, %LexerState* %l0
  %t1082 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t1080, double* %t1082
  br label %merge103
merge103:
  %t1083 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t1084 = alloca %TokenKind
  %t1085 = getelementptr inbounds %TokenKind, %TokenKind* %t1084, i32 0, i32 0
  store i32 4, i32* %t1085
  %t1086 = load i8, i8* %l38
  %t1087 = call noalias i8* @malloc(i64 1)
  %t1088 = bitcast i8* %t1087 to i8*
  store i8 %t1086, i8* %t1088
  %t1089 = getelementptr inbounds %TokenKind, %TokenKind* %t1084, i32 0, i32 1
  %t1090 = bitcast [8 x i8]* %t1089 to i8*
  %t1091 = bitcast i8* %t1090 to i8**
  store i8* %t1087, i8** %t1091
  %t1092 = load %TokenKind, %TokenKind* %t1084
  %t1093 = insertvalue %Token undef, %TokenKind %t1092, 0
  %t1094 = load i8, i8* %l38
  %t1095 = alloca [2 x i8], align 1
  %t1096 = getelementptr [2 x i8], [2 x i8]* %t1095, i32 0, i32 0
  store i8 %t1094, i8* %t1096
  %t1097 = getelementptr [2 x i8], [2 x i8]* %t1095, i32 0, i32 1
  store i8 0, i8* %t1097
  %t1098 = getelementptr [2 x i8], [2 x i8]* %t1095, i32 0, i32 0
  %t1099 = insertvalue %Token %t1093, i8* %t1098, 1
  %t1100 = load double, double* %l36
  %t1101 = insertvalue %Token %t1099, double %t1100, 2
  %t1102 = load double, double* %l37
  %t1103 = insertvalue %Token %t1101, double %t1102, 3
  %t1104 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t1083, %Token %t1103)
  store { %Token*, i64 }* %t1104, { %Token*, i64 }** %l1
  br label %loop.latch2
loop.latch2:
  %t1105 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br label %loop.header0
afterloop3:
  %t1107 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t1108 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t1109 = load %LexerState, %LexerState* %l0
  %t1110 = extractvalue %LexerState %t1109, 2
  %t1111 = load %LexerState, %LexerState* %l0
  %t1112 = extractvalue %LexerState %t1111, 3
  %t1113 = call %Token @eof_token(double %t1110, double %t1112)
  %t1114 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t1108, %Token %t1113)
  store { %Token*, i64 }* %t1114, { %Token*, i64 }** %l1
  %t1115 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  ret { %Token*, i64 }* %t1115
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
block.entry:
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
@.str.len5.h2095430042 = private unnamed_addr constant [6 x i8] c"false\00"
@.str.len0.h177573 = private unnamed_addr constant [1 x i8] c"\00"
@.str.len4.h275946731 = private unnamed_addr constant [5 x i8] c"true\00"
