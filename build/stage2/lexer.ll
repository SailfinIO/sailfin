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

declare void @sailfin_runtime_mark_persistent(i8*)
declare void @sailfin_runtime_copy_bytes(i8*, i8*, i64)

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
  %t1119 = phi { %Token*, i64 }* [ %t20, %block.entry ], [ %t1118, %loop.latch2 ]
  store { %Token*, i64 }* %t1119, { %Token*, i64 }** %l1
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
  %t34 = call double @llvm.round.f64(double %t33)
  %t35 = fptosi double %t34 to i64
  %t36 = getelementptr i8, i8* %t31, i64 %t35
  %t37 = load i8, i8* %t36
  store i8 %t37, i8* %l2
  %t38 = load i8, i8* %l2
  %t39 = alloca [2 x i8], align 1
  %t40 = getelementptr [2 x i8], [2 x i8]* %t39, i32 0, i32 0
  store i8 %t38, i8* %t40
  %t41 = getelementptr [2 x i8], [2 x i8]* %t39, i32 0, i32 1
  store i8 0, i8* %t41
  %t42 = getelementptr [2 x i8], [2 x i8]* %t39, i32 0, i32 0
  %t43 = call i1 @is_whitespace(i8* %t42)
  %t44 = load %LexerState, %LexerState* %l0
  %t45 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t46 = load i8, i8* %l2
  br i1 %t43, label %then6, label %merge7
then6:
  %t47 = load %LexerState, %LexerState* %l0
  %t48 = extractvalue %LexerState %t47, 1
  store double %t48, double* %l3
  %t49 = load %LexerState, %LexerState* %l0
  %t50 = extractvalue %LexerState %t49, 2
  store double %t50, double* %l4
  %t51 = load %LexerState, %LexerState* %l0
  %t52 = extractvalue %LexerState %t51, 3
  store double %t52, double* %l5
  %t53 = load %LexerState, %LexerState* %l0
  %t54 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t55 = load i8, i8* %l2
  %t56 = load double, double* %l3
  %t57 = load double, double* %l4
  %t58 = load double, double* %l5
  br label %loop.header8
loop.header8:
  br label %loop.body9
loop.body9:
  %t59 = load %LexerState, %LexerState* %l0
  %t60 = extractvalue %LexerState %t59, 1
  %t61 = load %LexerState, %LexerState* %l0
  %t62 = extractvalue %LexerState %t61, 0
  %t63 = call i64 @sailfin_runtime_string_length(i8* %t62)
  %t64 = sitofp i64 %t63 to double
  %t65 = fcmp oge double %t60, %t64
  %t66 = load %LexerState, %LexerState* %l0
  %t67 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t68 = load i8, i8* %l2
  %t69 = load double, double* %l3
  %t70 = load double, double* %l4
  %t71 = load double, double* %l5
  br i1 %t65, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t72 = load %LexerState, %LexerState* %l0
  %t73 = extractvalue %LexerState %t72, 0
  %t74 = load %LexerState, %LexerState* %l0
  %t75 = extractvalue %LexerState %t74, 1
  %t76 = call double @llvm.round.f64(double %t75)
  %t77 = fptosi double %t76 to i64
  %t78 = getelementptr i8, i8* %t73, i64 %t77
  %t79 = load i8, i8* %t78
  %t80 = alloca [2 x i8], align 1
  %t81 = getelementptr [2 x i8], [2 x i8]* %t80, i32 0, i32 0
  store i8 %t79, i8* %t81
  %t82 = getelementptr [2 x i8], [2 x i8]* %t80, i32 0, i32 1
  store i8 0, i8* %t82
  %t83 = getelementptr [2 x i8], [2 x i8]* %t80, i32 0, i32 0
  %t84 = call i1 @is_whitespace(i8* %t83)
  %t85 = xor i1 %t84, 1
  %t86 = load %LexerState, %LexerState* %l0
  %t87 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t88 = load i8, i8* %l2
  %t89 = load double, double* %l3
  %t90 = load double, double* %l4
  %t91 = load double, double* %l5
  br i1 %t85, label %then14, label %merge15
then14:
  br label %afterloop11
merge15:
  %t92 = load %LexerState, %LexerState* %l0
  %t93 = extractvalue %LexerState %t92, 0
  %t94 = load %LexerState, %LexerState* %l0
  %t95 = extractvalue %LexerState %t94, 1
  %t96 = call double @llvm.round.f64(double %t95)
  %t97 = fptosi double %t96 to i64
  %t98 = getelementptr i8, i8* %t93, i64 %t97
  %t99 = load i8, i8* %t98
  %t100 = icmp eq i8 %t99, 10
  %t101 = load %LexerState, %LexerState* %l0
  %t102 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t103 = load i8, i8* %l2
  %t104 = load double, double* %l3
  %t105 = load double, double* %l4
  %t106 = load double, double* %l5
  br i1 %t100, label %then16, label %else17
then16:
  %t107 = load %LexerState, %LexerState* %l0
  %t108 = extractvalue %LexerState %t107, 1
  %t109 = sitofp i64 1 to double
  %t110 = fadd double %t108, %t109
  %t111 = load %LexerState, %LexerState* %l0
  %t112 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t110, double* %t112
  %t113 = load %LexerState, %LexerState* %l0
  %t114 = extractvalue %LexerState %t113, 2
  %t115 = sitofp i64 1 to double
  %t116 = fadd double %t114, %t115
  %t117 = load %LexerState, %LexerState* %l0
  %t118 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 2
  store double %t116, double* %t118
  %t119 = load %LexerState, %LexerState* %l0
  %t120 = sitofp i64 1 to double
  %t121 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t120, double* %t121
  br label %merge18
else17:
  %t122 = load %LexerState, %LexerState* %l0
  %t123 = extractvalue %LexerState %t122, 1
  %t124 = sitofp i64 1 to double
  %t125 = fadd double %t123, %t124
  %t126 = load %LexerState, %LexerState* %l0
  %t127 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t125, double* %t127
  %t128 = load %LexerState, %LexerState* %l0
  %t129 = extractvalue %LexerState %t128, 3
  %t130 = sitofp i64 1 to double
  %t131 = fadd double %t129, %t130
  %t132 = load %LexerState, %LexerState* %l0
  %t133 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t131, double* %t133
  br label %merge18
merge18:
  br label %loop.latch10
loop.latch10:
  br label %loop.header8
afterloop11:
  %t134 = load %LexerState, %LexerState* %l0
  %t135 = extractvalue %LexerState %t134, 0
  %t136 = load double, double* %l3
  %t137 = load %LexerState, %LexerState* %l0
  %t138 = extractvalue %LexerState %t137, 1
  %t139 = call i8* @slice(i8* %t135, double %t136, double %t138)
  store i8* %t139, i8** %l6
  %t140 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t141 = insertvalue %TokenKind undef, i32 5, 0
  %t142 = insertvalue %Token undef, %TokenKind %t141, 0
  %t143 = load i8*, i8** %l6
  %t144 = insertvalue %Token %t142, i8* %t143, 1
  %t145 = load double, double* %l4
  %t146 = insertvalue %Token %t144, double %t145, 2
  %t147 = load double, double* %l5
  %t148 = insertvalue %Token %t146, double %t147, 3
  %t149 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t140, %Token %t148)
  store { %Token*, i64 }* %t149, { %Token*, i64 }** %l1
  br label %loop.latch2
merge7:
  %t150 = load i8, i8* %l2
  %t151 = icmp eq i8 %t150, 47
  %t152 = load %LexerState, %LexerState* %l0
  %t153 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t154 = load i8, i8* %l2
  br i1 %t151, label %then19, label %merge20
then19:
  %t155 = load %LexerState, %LexerState* %l0
  %t156 = call i8* @peek_next_char(%LexerState %t155)
  store i8* %t156, i8** %l7
  %t157 = load i8*, i8** %l7
  %t158 = load i8, i8* %t157
  %t159 = icmp eq i8 %t158, 47
  %t160 = load %LexerState, %LexerState* %l0
  %t161 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t162 = load i8, i8* %l2
  %t163 = load i8*, i8** %l7
  br i1 %t159, label %then21, label %merge22
then21:
  %t164 = load %LexerState, %LexerState* %l0
  %t165 = extractvalue %LexerState %t164, 1
  store double %t165, double* %l8
  %t166 = load %LexerState, %LexerState* %l0
  %t167 = extractvalue %LexerState %t166, 2
  store double %t167, double* %l9
  %t168 = load %LexerState, %LexerState* %l0
  %t169 = extractvalue %LexerState %t168, 3
  store double %t169, double* %l10
  %t170 = load %LexerState, %LexerState* %l0
  %t171 = extractvalue %LexerState %t170, 1
  %t172 = sitofp i64 2 to double
  %t173 = fadd double %t171, %t172
  %t174 = load %LexerState, %LexerState* %l0
  %t175 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t173, double* %t175
  %t176 = load %LexerState, %LexerState* %l0
  %t177 = extractvalue %LexerState %t176, 3
  %t178 = sitofp i64 2 to double
  %t179 = fadd double %t177, %t178
  %t180 = load %LexerState, %LexerState* %l0
  %t181 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t179, double* %t181
  %t182 = load %LexerState, %LexerState* %l0
  %t183 = extractvalue %LexerState %t182, 0
  %t184 = call i64 @sailfin_runtime_string_length(i8* %t183)
  %t185 = sitofp i64 %t184 to double
  store double %t185, double* %l11
  %t186 = load %LexerState, %LexerState* %l0
  %t187 = extractvalue %LexerState %t186, 1
  store double %t187, double* %l12
  %t188 = load %LexerState, %LexerState* %l0
  %t189 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t190 = load i8, i8* %l2
  %t191 = load i8*, i8** %l7
  %t192 = load double, double* %l8
  %t193 = load double, double* %l9
  %t194 = load double, double* %l10
  %t195 = load double, double* %l11
  %t196 = load double, double* %l12
  br label %loop.header23
loop.header23:
  %t241 = phi double [ %t195, %then21 ], [ %t239, %loop.latch25 ]
  %t242 = phi double [ %t196, %then21 ], [ %t240, %loop.latch25 ]
  store double %t241, double* %l11
  store double %t242, double* %l12
  br label %loop.body24
loop.body24:
  %t197 = load double, double* %l12
  %t198 = load %LexerState, %LexerState* %l0
  %t199 = extractvalue %LexerState %t198, 0
  %t200 = call i64 @sailfin_runtime_string_length(i8* %t199)
  %t201 = sitofp i64 %t200 to double
  %t202 = fcmp oge double %t197, %t201
  %t203 = load %LexerState, %LexerState* %l0
  %t204 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t205 = load i8, i8* %l2
  %t206 = load i8*, i8** %l7
  %t207 = load double, double* %l8
  %t208 = load double, double* %l9
  %t209 = load double, double* %l10
  %t210 = load double, double* %l11
  %t211 = load double, double* %l12
  br i1 %t202, label %then27, label %merge28
then27:
  br label %afterloop26
merge28:
  %t212 = load %LexerState, %LexerState* %l0
  %t213 = extractvalue %LexerState %t212, 0
  %t214 = load double, double* %l12
  %t215 = call double @llvm.round.f64(double %t214)
  %t216 = fptosi double %t215 to i64
  %t217 = getelementptr i8, i8* %t213, i64 %t216
  %t218 = load i8, i8* %t217
  store i8 %t218, i8* %l13
  %t220 = load i8, i8* %l13
  %t221 = icmp eq i8 %t220, 10
  br label %logical_or_entry_219

logical_or_entry_219:
  br i1 %t221, label %logical_or_merge_219, label %logical_or_right_219

logical_or_right_219:
  %t222 = load i8, i8* %l13
  %t223 = icmp eq i8 %t222, 13
  br label %logical_or_right_end_219

logical_or_right_end_219:
  br label %logical_or_merge_219

logical_or_merge_219:
  %t224 = phi i1 [ true, %logical_or_entry_219 ], [ %t223, %logical_or_right_end_219 ]
  %t225 = load %LexerState, %LexerState* %l0
  %t226 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t227 = load i8, i8* %l2
  %t228 = load i8*, i8** %l7
  %t229 = load double, double* %l8
  %t230 = load double, double* %l9
  %t231 = load double, double* %l10
  %t232 = load double, double* %l11
  %t233 = load double, double* %l12
  %t234 = load i8, i8* %l13
  br i1 %t224, label %then29, label %merge30
then29:
  %t235 = load double, double* %l12
  store double %t235, double* %l11
  br label %afterloop26
merge30:
  %t236 = load double, double* %l12
  %t237 = sitofp i64 1 to double
  %t238 = fadd double %t236, %t237
  store double %t238, double* %l12
  br label %loop.latch25
loop.latch25:
  %t239 = load double, double* %l11
  %t240 = load double, double* %l12
  br label %loop.header23
afterloop26:
  %t243 = load double, double* %l11
  %t244 = load double, double* %l12
  %t245 = load %LexerState, %LexerState* %l0
  %t246 = extractvalue %LexerState %t245, 0
  %t247 = load double, double* %l8
  %t248 = load double, double* %l11
  %t249 = call i8* @slice(i8* %t246, double %t247, double %t248)
  store i8* %t249, i8** %l14
  %t250 = load double, double* %l11
  %t251 = load %LexerState, %LexerState* %l0
  %t252 = extractvalue %LexerState %t251, 1
  %t253 = fsub double %t250, %t252
  store double %t253, double* %l15
  %t254 = load double, double* %l11
  %t255 = load %LexerState, %LexerState* %l0
  %t256 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t254, double* %t256
  %t257 = load %LexerState, %LexerState* %l0
  %t258 = extractvalue %LexerState %t257, 3
  %t259 = load double, double* %l15
  %t260 = fadd double %t258, %t259
  %t261 = load %LexerState, %LexerState* %l0
  %t262 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t260, double* %t262
  %t263 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t264 = insertvalue %TokenKind undef, i32 6, 0
  %t265 = insertvalue %Token undef, %TokenKind %t264, 0
  %t266 = load i8*, i8** %l14
  %t267 = insertvalue %Token %t265, i8* %t266, 1
  %t268 = load double, double* %l9
  %t269 = insertvalue %Token %t267, double %t268, 2
  %t270 = load double, double* %l10
  %t271 = insertvalue %Token %t269, double %t270, 3
  %t272 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t263, %Token %t271)
  store { %Token*, i64 }* %t272, { %Token*, i64 }** %l1
  br label %loop.latch2
merge22:
  %t273 = load i8*, i8** %l7
  %t274 = load i8, i8* %t273
  %t275 = icmp eq i8 %t274, 42
  %t276 = load %LexerState, %LexerState* %l0
  %t277 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t278 = load i8, i8* %l2
  %t279 = load i8*, i8** %l7
  br i1 %t275, label %then31, label %merge32
then31:
  %t280 = load %LexerState, %LexerState* %l0
  %t281 = extractvalue %LexerState %t280, 1
  store double %t281, double* %l16
  %t282 = load %LexerState, %LexerState* %l0
  %t283 = extractvalue %LexerState %t282, 2
  store double %t283, double* %l17
  %t284 = load %LexerState, %LexerState* %l0
  %t285 = extractvalue %LexerState %t284, 3
  store double %t285, double* %l18
  %t286 = load %LexerState, %LexerState* %l0
  %t287 = extractvalue %LexerState %t286, 1
  %t288 = sitofp i64 2 to double
  %t289 = fadd double %t287, %t288
  %t290 = load %LexerState, %LexerState* %l0
  %t291 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t289, double* %t291
  %t292 = load %LexerState, %LexerState* %l0
  %t293 = extractvalue %LexerState %t292, 3
  %t294 = sitofp i64 2 to double
  %t295 = fadd double %t293, %t294
  %t296 = load %LexerState, %LexerState* %l0
  %t297 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t295, double* %t297
  %t298 = load %LexerState, %LexerState* %l0
  %t299 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t300 = load i8, i8* %l2
  %t301 = load i8*, i8** %l7
  %t302 = load double, double* %l16
  %t303 = load double, double* %l17
  %t304 = load double, double* %l18
  br label %loop.header33
loop.header33:
  br label %loop.body34
loop.body34:
  %t305 = load %LexerState, %LexerState* %l0
  %t306 = extractvalue %LexerState %t305, 1
  %t307 = load %LexerState, %LexerState* %l0
  %t308 = extractvalue %LexerState %t307, 0
  %t309 = call i64 @sailfin_runtime_string_length(i8* %t308)
  %t310 = sitofp i64 %t309 to double
  %t311 = fcmp oge double %t306, %t310
  %t312 = load %LexerState, %LexerState* %l0
  %t313 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t314 = load i8, i8* %l2
  %t315 = load i8*, i8** %l7
  %t316 = load double, double* %l16
  %t317 = load double, double* %l17
  %t318 = load double, double* %l18
  br i1 %t311, label %then37, label %merge38
then37:
  br label %afterloop36
merge38:
  %t320 = load %LexerState, %LexerState* %l0
  %t321 = extractvalue %LexerState %t320, 0
  %t322 = load %LexerState, %LexerState* %l0
  %t323 = extractvalue %LexerState %t322, 1
  %t324 = call double @llvm.round.f64(double %t323)
  %t325 = fptosi double %t324 to i64
  %t326 = getelementptr i8, i8* %t321, i64 %t325
  %t327 = load i8, i8* %t326
  %t328 = icmp eq i8 %t327, 42
  br label %logical_and_entry_319

logical_and_entry_319:
  br i1 %t328, label %logical_and_right_319, label %logical_and_merge_319

logical_and_right_319:
  %t329 = load %LexerState, %LexerState* %l0
  %t330 = call i8* @peek_next_char(%LexerState %t329)
  %t331 = load i8, i8* %t330
  %t332 = icmp eq i8 %t331, 47
  br label %logical_and_right_end_319

logical_and_right_end_319:
  br label %logical_and_merge_319

logical_and_merge_319:
  %t333 = phi i1 [ false, %logical_and_entry_319 ], [ %t332, %logical_and_right_end_319 ]
  %t334 = load %LexerState, %LexerState* %l0
  %t335 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t336 = load i8, i8* %l2
  %t337 = load i8*, i8** %l7
  %t338 = load double, double* %l16
  %t339 = load double, double* %l17
  %t340 = load double, double* %l18
  br i1 %t333, label %then39, label %merge40
then39:
  %t341 = load %LexerState, %LexerState* %l0
  %t342 = extractvalue %LexerState %t341, 1
  %t343 = sitofp i64 2 to double
  %t344 = fadd double %t342, %t343
  %t345 = load %LexerState, %LexerState* %l0
  %t346 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t344, double* %t346
  %t347 = load %LexerState, %LexerState* %l0
  %t348 = extractvalue %LexerState %t347, 3
  %t349 = sitofp i64 2 to double
  %t350 = fadd double %t348, %t349
  %t351 = load %LexerState, %LexerState* %l0
  %t352 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t350, double* %t352
  br label %afterloop36
merge40:
  %t353 = load %LexerState, %LexerState* %l0
  %t354 = extractvalue %LexerState %t353, 0
  %t355 = load %LexerState, %LexerState* %l0
  %t356 = extractvalue %LexerState %t355, 1
  %t357 = call double @llvm.round.f64(double %t356)
  %t358 = fptosi double %t357 to i64
  %t359 = getelementptr i8, i8* %t354, i64 %t358
  %t360 = load i8, i8* %t359
  %t361 = icmp eq i8 %t360, 10
  %t362 = load %LexerState, %LexerState* %l0
  %t363 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t364 = load i8, i8* %l2
  %t365 = load i8*, i8** %l7
  %t366 = load double, double* %l16
  %t367 = load double, double* %l17
  %t368 = load double, double* %l18
  br i1 %t361, label %then41, label %else42
then41:
  %t369 = load %LexerState, %LexerState* %l0
  %t370 = extractvalue %LexerState %t369, 1
  %t371 = sitofp i64 1 to double
  %t372 = fadd double %t370, %t371
  %t373 = load %LexerState, %LexerState* %l0
  %t374 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t372, double* %t374
  %t375 = load %LexerState, %LexerState* %l0
  %t376 = extractvalue %LexerState %t375, 2
  %t377 = sitofp i64 1 to double
  %t378 = fadd double %t376, %t377
  %t379 = load %LexerState, %LexerState* %l0
  %t380 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 2
  store double %t378, double* %t380
  %t381 = load %LexerState, %LexerState* %l0
  %t382 = sitofp i64 1 to double
  %t383 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t382, double* %t383
  br label %merge43
else42:
  %t384 = load %LexerState, %LexerState* %l0
  %t385 = extractvalue %LexerState %t384, 1
  %t386 = sitofp i64 1 to double
  %t387 = fadd double %t385, %t386
  %t388 = load %LexerState, %LexerState* %l0
  %t389 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t387, double* %t389
  %t390 = load %LexerState, %LexerState* %l0
  %t391 = extractvalue %LexerState %t390, 3
  %t392 = sitofp i64 1 to double
  %t393 = fadd double %t391, %t392
  %t394 = load %LexerState, %LexerState* %l0
  %t395 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t393, double* %t395
  br label %merge43
merge43:
  br label %loop.latch35
loop.latch35:
  br label %loop.header33
afterloop36:
  %t396 = load %LexerState, %LexerState* %l0
  %t397 = extractvalue %LexerState %t396, 0
  %t398 = load double, double* %l16
  %t399 = load %LexerState, %LexerState* %l0
  %t400 = extractvalue %LexerState %t399, 1
  %t401 = call i8* @slice(i8* %t397, double %t398, double %t400)
  store i8* %t401, i8** %l19
  %t402 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t403 = insertvalue %TokenKind undef, i32 6, 0
  %t404 = insertvalue %Token undef, %TokenKind %t403, 0
  %t405 = load i8*, i8** %l19
  %t406 = insertvalue %Token %t404, i8* %t405, 1
  %t407 = load double, double* %l17
  %t408 = insertvalue %Token %t406, double %t407, 2
  %t409 = load double, double* %l18
  %t410 = insertvalue %Token %t408, double %t409, 3
  %t411 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t402, %Token %t410)
  store { %Token*, i64 }* %t411, { %Token*, i64 }** %l1
  br label %loop.latch2
merge32:
  %t412 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t413 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br label %merge20
merge20:
  %t414 = phi { %Token*, i64 }* [ %t412, %merge32 ], [ %t153, %merge7 ]
  %t415 = phi { %Token*, i64 }* [ %t413, %merge32 ], [ %t153, %merge7 ]
  store { %Token*, i64 }* %t414, { %Token*, i64 }** %l1
  store { %Token*, i64 }* %t415, { %Token*, i64 }** %l1
  %t416 = load i8, i8* %l2
  %t417 = alloca [2 x i8], align 1
  %t418 = getelementptr [2 x i8], [2 x i8]* %t417, i32 0, i32 0
  store i8 %t416, i8* %t418
  %t419 = getelementptr [2 x i8], [2 x i8]* %t417, i32 0, i32 1
  store i8 0, i8* %t419
  %t420 = getelementptr [2 x i8], [2 x i8]* %t417, i32 0, i32 0
  %t421 = call i1 @is_double_quote(i8* %t420)
  %t422 = load %LexerState, %LexerState* %l0
  %t423 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t424 = load i8, i8* %l2
  br i1 %t421, label %then44, label %merge45
then44:
  %t425 = load %LexerState, %LexerState* %l0
  %t426 = extractvalue %LexerState %t425, 1
  store double %t426, double* %l20
  %t427 = load %LexerState, %LexerState* %l0
  %t428 = extractvalue %LexerState %t427, 2
  store double %t428, double* %l21
  %t429 = load %LexerState, %LexerState* %l0
  %t430 = extractvalue %LexerState %t429, 3
  store double %t430, double* %l22
  %t431 = load %LexerState, %LexerState* %l0
  %t432 = extractvalue %LexerState %t431, 1
  %t433 = sitofp i64 1 to double
  %t434 = fadd double %t432, %t433
  %t435 = load %LexerState, %LexerState* %l0
  %t436 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t434, double* %t436
  %t437 = load %LexerState, %LexerState* %l0
  %t438 = extractvalue %LexerState %t437, 3
  %t439 = sitofp i64 1 to double
  %t440 = fadd double %t438, %t439
  %t441 = load %LexerState, %LexerState* %l0
  %t442 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t440, double* %t442
  %s443 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s443, i8** %l23
  store i1 0, i1* %l24
  %t444 = load %LexerState, %LexerState* %l0
  %t445 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t446 = load i8, i8* %l2
  %t447 = load double, double* %l20
  %t448 = load double, double* %l21
  %t449 = load double, double* %l22
  %t450 = load i8*, i8** %l23
  %t451 = load i1, i1* %l24
  br label %loop.header46
loop.header46:
  %t607 = phi i1 [ %t451, %then44 ], [ %t605, %loop.latch48 ]
  %t608 = phi i8* [ %t450, %then44 ], [ %t606, %loop.latch48 ]
  store i1 %t607, i1* %l24
  store i8* %t608, i8** %l23
  br label %loop.body47
loop.body47:
  %t452 = load %LexerState, %LexerState* %l0
  %t453 = extractvalue %LexerState %t452, 1
  %t454 = load %LexerState, %LexerState* %l0
  %t455 = extractvalue %LexerState %t454, 0
  %t456 = call i64 @sailfin_runtime_string_length(i8* %t455)
  %t457 = sitofp i64 %t456 to double
  %t458 = fcmp oge double %t453, %t457
  %t459 = load %LexerState, %LexerState* %l0
  %t460 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t461 = load i8, i8* %l2
  %t462 = load double, double* %l20
  %t463 = load double, double* %l21
  %t464 = load double, double* %l22
  %t465 = load i8*, i8** %l23
  %t466 = load i1, i1* %l24
  br i1 %t458, label %then50, label %merge51
then50:
  br label %afterloop49
merge51:
  %t467 = load %LexerState, %LexerState* %l0
  %t468 = extractvalue %LexerState %t467, 0
  %t469 = load %LexerState, %LexerState* %l0
  %t470 = extractvalue %LexerState %t469, 1
  %t471 = call double @llvm.round.f64(double %t470)
  %t472 = fptosi double %t471 to i64
  %t473 = getelementptr i8, i8* %t468, i64 %t472
  %t474 = load i8, i8* %t473
  store i8 %t474, i8* %l25
  %t476 = load i1, i1* %l24
  br label %logical_and_entry_475

logical_and_entry_475:
  br i1 %t476, label %logical_and_right_475, label %logical_and_merge_475

logical_and_right_475:
  %t477 = load i8, i8* %l25
  %t478 = alloca [2 x i8], align 1
  %t479 = getelementptr [2 x i8], [2 x i8]* %t478, i32 0, i32 0
  store i8 %t477, i8* %t479
  %t480 = getelementptr [2 x i8], [2 x i8]* %t478, i32 0, i32 1
  store i8 0, i8* %t480
  %t481 = getelementptr [2 x i8], [2 x i8]* %t478, i32 0, i32 0
  %t482 = call i1 @is_double_quote(i8* %t481)
  br label %logical_and_right_end_475

logical_and_right_end_475:
  br label %logical_and_merge_475

logical_and_merge_475:
  %t483 = phi i1 [ false, %logical_and_entry_475 ], [ %t482, %logical_and_right_end_475 ]
  %t484 = xor i1 %t483, 1
  %t485 = load %LexerState, %LexerState* %l0
  %t486 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t487 = load i8, i8* %l2
  %t488 = load double, double* %l20
  %t489 = load double, double* %l21
  %t490 = load double, double* %l22
  %t491 = load i8*, i8** %l23
  %t492 = load i1, i1* %l24
  %t493 = load i8, i8* %l25
  br i1 %t484, label %then52, label %merge53
then52:
  %t494 = load %LexerState, %LexerState* %l0
  %t495 = extractvalue %LexerState %t494, 1
  %t496 = sitofp i64 1 to double
  %t497 = fadd double %t495, %t496
  %t498 = load %LexerState, %LexerState* %l0
  %t499 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t497, double* %t499
  %t500 = load %LexerState, %LexerState* %l0
  %t501 = extractvalue %LexerState %t500, 3
  %t502 = sitofp i64 1 to double
  %t503 = fadd double %t501, %t502
  %t504 = load %LexerState, %LexerState* %l0
  %t505 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t503, double* %t505
  br label %afterloop49
merge53:
  %t507 = load i1, i1* %l24
  br label %logical_and_entry_506

logical_and_entry_506:
  br i1 %t507, label %logical_and_right_506, label %logical_and_merge_506

logical_and_right_506:
  %t508 = load i8, i8* %l25
  %t509 = alloca [2 x i8], align 1
  %t510 = getelementptr [2 x i8], [2 x i8]* %t509, i32 0, i32 0
  store i8 %t508, i8* %t510
  %t511 = getelementptr [2 x i8], [2 x i8]* %t509, i32 0, i32 1
  store i8 0, i8* %t511
  %t512 = getelementptr [2 x i8], [2 x i8]* %t509, i32 0, i32 0
  %t513 = call i1 @is_backslash(i8* %t512)
  br label %logical_and_right_end_506

logical_and_right_end_506:
  br label %logical_and_merge_506

logical_and_merge_506:
  %t514 = phi i1 [ false, %logical_and_entry_506 ], [ %t513, %logical_and_right_end_506 ]
  %t515 = xor i1 %t514, 1
  %t516 = load %LexerState, %LexerState* %l0
  %t517 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t518 = load i8, i8* %l2
  %t519 = load double, double* %l20
  %t520 = load double, double* %l21
  %t521 = load double, double* %l22
  %t522 = load i8*, i8** %l23
  %t523 = load i1, i1* %l24
  %t524 = load i8, i8* %l25
  br i1 %t515, label %then54, label %merge55
then54:
  store i1 1, i1* %l24
  %t525 = load %LexerState, %LexerState* %l0
  %t526 = extractvalue %LexerState %t525, 1
  %t527 = sitofp i64 1 to double
  %t528 = fadd double %t526, %t527
  %t529 = load %LexerState, %LexerState* %l0
  %t530 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t528, double* %t530
  %t531 = load %LexerState, %LexerState* %l0
  %t532 = extractvalue %LexerState %t531, 3
  %t533 = sitofp i64 1 to double
  %t534 = fadd double %t532, %t533
  %t535 = load %LexerState, %LexerState* %l0
  %t536 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t534, double* %t536
  br label %loop.latch48
merge55:
  %t537 = load i1, i1* %l24
  %t538 = load %LexerState, %LexerState* %l0
  %t539 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t540 = load i8, i8* %l2
  %t541 = load double, double* %l20
  %t542 = load double, double* %l21
  %t543 = load double, double* %l22
  %t544 = load i8*, i8** %l23
  %t545 = load i1, i1* %l24
  %t546 = load i8, i8* %l25
  br i1 %t537, label %then56, label %else57
then56:
  %t547 = load i8*, i8** %l23
  %t548 = load i8, i8* %l25
  %t549 = alloca [2 x i8], align 1
  %t550 = getelementptr [2 x i8], [2 x i8]* %t549, i32 0, i32 0
  store i8 %t548, i8* %t550
  %t551 = getelementptr [2 x i8], [2 x i8]* %t549, i32 0, i32 1
  store i8 0, i8* %t551
  %t552 = getelementptr [2 x i8], [2 x i8]* %t549, i32 0, i32 0
  %t553 = call i8* @interpret_escape(i8* %t552)
  %t554 = call i8* @sailfin_runtime_string_concat(i8* %t547, i8* %t553)
  store i8* %t554, i8** %l23
  store i1 0, i1* %l24
  %t555 = load i8*, i8** %l23
  %t556 = load i1, i1* %l24
  br label %merge58
else57:
  %t557 = load i8*, i8** %l23
  %t558 = load i8, i8* %l25
  %t559 = alloca [2 x i8], align 1
  %t560 = getelementptr [2 x i8], [2 x i8]* %t559, i32 0, i32 0
  store i8 %t558, i8* %t560
  %t561 = getelementptr [2 x i8], [2 x i8]* %t559, i32 0, i32 1
  store i8 0, i8* %t561
  %t562 = getelementptr [2 x i8], [2 x i8]* %t559, i32 0, i32 0
  %t563 = call i8* @sailfin_runtime_string_concat(i8* %t557, i8* %t562)
  store i8* %t563, i8** %l23
  %t564 = load i8*, i8** %l23
  br label %merge58
merge58:
  %t565 = phi i8* [ %t555, %then56 ], [ %t564, %else57 ]
  %t566 = phi i1 [ %t556, %then56 ], [ %t545, %else57 ]
  store i8* %t565, i8** %l23
  store i1 %t566, i1* %l24
  %t567 = load i8, i8* %l25
  %t568 = icmp eq i8 %t567, 10
  %t569 = load %LexerState, %LexerState* %l0
  %t570 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t571 = load i8, i8* %l2
  %t572 = load double, double* %l20
  %t573 = load double, double* %l21
  %t574 = load double, double* %l22
  %t575 = load i8*, i8** %l23
  %t576 = load i1, i1* %l24
  %t577 = load i8, i8* %l25
  br i1 %t568, label %then59, label %else60
then59:
  %t578 = load %LexerState, %LexerState* %l0
  %t579 = extractvalue %LexerState %t578, 1
  %t580 = sitofp i64 1 to double
  %t581 = fadd double %t579, %t580
  %t582 = load %LexerState, %LexerState* %l0
  %t583 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t581, double* %t583
  %t584 = load %LexerState, %LexerState* %l0
  %t585 = extractvalue %LexerState %t584, 2
  %t586 = sitofp i64 1 to double
  %t587 = fadd double %t585, %t586
  %t588 = load %LexerState, %LexerState* %l0
  %t589 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 2
  store double %t587, double* %t589
  %t590 = load %LexerState, %LexerState* %l0
  %t591 = sitofp i64 1 to double
  %t592 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t591, double* %t592
  br label %merge61
else60:
  %t593 = load %LexerState, %LexerState* %l0
  %t594 = extractvalue %LexerState %t593, 1
  %t595 = sitofp i64 1 to double
  %t596 = fadd double %t594, %t595
  %t597 = load %LexerState, %LexerState* %l0
  %t598 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t596, double* %t598
  %t599 = load %LexerState, %LexerState* %l0
  %t600 = extractvalue %LexerState %t599, 3
  %t601 = sitofp i64 1 to double
  %t602 = fadd double %t600, %t601
  %t603 = load %LexerState, %LexerState* %l0
  %t604 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t602, double* %t604
  br label %merge61
merge61:
  br label %loop.latch48
loop.latch48:
  %t605 = load i1, i1* %l24
  %t606 = load i8*, i8** %l23
  br label %loop.header46
afterloop49:
  %t609 = load i1, i1* %l24
  %t610 = load i8*, i8** %l23
  %t611 = load %LexerState, %LexerState* %l0
  %t612 = extractvalue %LexerState %t611, 0
  %t613 = load double, double* %l20
  %t614 = load %LexerState, %LexerState* %l0
  %t615 = extractvalue %LexerState %t614, 1
  %t616 = call i8* @slice(i8* %t612, double %t613, double %t615)
  store i8* %t616, i8** %l26
  %t617 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t618 = alloca %TokenKind
  %t619 = getelementptr inbounds %TokenKind, %TokenKind* %t618, i32 0, i32 0
  store i32 2, i32* %t619
  %t620 = load i8*, i8** %l23
  %t621 = getelementptr inbounds %TokenKind, %TokenKind* %t618, i32 0, i32 1
  %t622 = bitcast [8 x i8]* %t621 to i8*
  %t623 = bitcast i8* %t622 to i8**
  store i8* %t620, i8** %t623
  %t624 = load %TokenKind, %TokenKind* %t618
  %t625 = insertvalue %Token undef, %TokenKind %t624, 0
  %t626 = load i8*, i8** %l26
  %t627 = insertvalue %Token %t625, i8* %t626, 1
  %t628 = load double, double* %l21
  %t629 = insertvalue %Token %t627, double %t628, 2
  %t630 = load double, double* %l22
  %t631 = insertvalue %Token %t629, double %t630, 3
  %t632 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t617, %Token %t631)
  store { %Token*, i64 }* %t632, { %Token*, i64 }** %l1
  br label %loop.latch2
merge45:
  %t633 = load i8, i8* %l2
  %t634 = alloca [2 x i8], align 1
  %t635 = getelementptr [2 x i8], [2 x i8]* %t634, i32 0, i32 0
  store i8 %t633, i8* %t635
  %t636 = getelementptr [2 x i8], [2 x i8]* %t634, i32 0, i32 1
  store i8 0, i8* %t636
  %t637 = getelementptr [2 x i8], [2 x i8]* %t634, i32 0, i32 0
  %t638 = call i1 @is_digit(i8* %t637)
  %t639 = load %LexerState, %LexerState* %l0
  %t640 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t641 = load i8, i8* %l2
  br i1 %t638, label %then62, label %merge63
then62:
  %t642 = load %LexerState, %LexerState* %l0
  %t643 = extractvalue %LexerState %t642, 1
  store double %t643, double* %l27
  %t644 = load %LexerState, %LexerState* %l0
  %t645 = extractvalue %LexerState %t644, 2
  store double %t645, double* %l28
  %t646 = load %LexerState, %LexerState* %l0
  %t647 = extractvalue %LexerState %t646, 3
  store double %t647, double* %l29
  %t648 = load %LexerState, %LexerState* %l0
  %t649 = extractvalue %LexerState %t648, 1
  %t650 = sitofp i64 1 to double
  %t651 = fadd double %t649, %t650
  %t652 = load %LexerState, %LexerState* %l0
  %t653 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t651, double* %t653
  %t654 = load %LexerState, %LexerState* %l0
  %t655 = extractvalue %LexerState %t654, 3
  %t656 = sitofp i64 1 to double
  %t657 = fadd double %t655, %t656
  %t658 = load %LexerState, %LexerState* %l0
  %t659 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t657, double* %t659
  %t660 = load %LexerState, %LexerState* %l0
  %t661 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t662 = load i8, i8* %l2
  %t663 = load double, double* %l27
  %t664 = load double, double* %l28
  %t665 = load double, double* %l29
  br label %loop.header64
loop.header64:
  br label %loop.body65
loop.body65:
  %t666 = load %LexerState, %LexerState* %l0
  %t667 = extractvalue %LexerState %t666, 1
  %t668 = load %LexerState, %LexerState* %l0
  %t669 = extractvalue %LexerState %t668, 0
  %t670 = call i64 @sailfin_runtime_string_length(i8* %t669)
  %t671 = sitofp i64 %t670 to double
  %t672 = fcmp oge double %t667, %t671
  %t673 = load %LexerState, %LexerState* %l0
  %t674 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t675 = load i8, i8* %l2
  %t676 = load double, double* %l27
  %t677 = load double, double* %l28
  %t678 = load double, double* %l29
  br i1 %t672, label %then68, label %merge69
then68:
  br label %afterloop67
merge69:
  %t679 = load %LexerState, %LexerState* %l0
  %t680 = extractvalue %LexerState %t679, 0
  %t681 = load %LexerState, %LexerState* %l0
  %t682 = extractvalue %LexerState %t681, 1
  %t683 = call double @llvm.round.f64(double %t682)
  %t684 = fptosi double %t683 to i64
  %t685 = getelementptr i8, i8* %t680, i64 %t684
  %t686 = load i8, i8* %t685
  %t687 = alloca [2 x i8], align 1
  %t688 = getelementptr [2 x i8], [2 x i8]* %t687, i32 0, i32 0
  store i8 %t686, i8* %t688
  %t689 = getelementptr [2 x i8], [2 x i8]* %t687, i32 0, i32 1
  store i8 0, i8* %t689
  %t690 = getelementptr [2 x i8], [2 x i8]* %t687, i32 0, i32 0
  %t691 = call i1 @is_digit(i8* %t690)
  %t692 = xor i1 %t691, 1
  %t693 = load %LexerState, %LexerState* %l0
  %t694 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t695 = load i8, i8* %l2
  %t696 = load double, double* %l27
  %t697 = load double, double* %l28
  %t698 = load double, double* %l29
  br i1 %t692, label %then70, label %merge71
then70:
  br label %afterloop67
merge71:
  %t699 = load %LexerState, %LexerState* %l0
  %t700 = extractvalue %LexerState %t699, 1
  %t701 = sitofp i64 1 to double
  %t702 = fadd double %t700, %t701
  %t703 = load %LexerState, %LexerState* %l0
  %t704 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t702, double* %t704
  %t705 = load %LexerState, %LexerState* %l0
  %t706 = extractvalue %LexerState %t705, 3
  %t707 = sitofp i64 1 to double
  %t708 = fadd double %t706, %t707
  %t709 = load %LexerState, %LexerState* %l0
  %t710 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t708, double* %t710
  br label %loop.latch66
loop.latch66:
  br label %loop.header64
afterloop67:
  %t712 = load %LexerState, %LexerState* %l0
  %t713 = extractvalue %LexerState %t712, 1
  %t714 = load %LexerState, %LexerState* %l0
  %t715 = extractvalue %LexerState %t714, 0
  %t716 = call i64 @sailfin_runtime_string_length(i8* %t715)
  %t717 = sitofp i64 %t716 to double
  %t718 = fcmp olt double %t713, %t717
  br label %logical_and_entry_711

logical_and_entry_711:
  br i1 %t718, label %logical_and_right_711, label %logical_and_merge_711

logical_and_right_711:
  %t719 = load %LexerState, %LexerState* %l0
  %t720 = extractvalue %LexerState %t719, 0
  %t721 = load %LexerState, %LexerState* %l0
  %t722 = extractvalue %LexerState %t721, 1
  %t723 = call double @llvm.round.f64(double %t722)
  %t724 = fptosi double %t723 to i64
  %t725 = getelementptr i8, i8* %t720, i64 %t724
  %t726 = load i8, i8* %t725
  %t727 = icmp eq i8 %t726, 46
  br label %logical_and_right_end_711

logical_and_right_end_711:
  br label %logical_and_merge_711

logical_and_merge_711:
  %t728 = phi i1 [ false, %logical_and_entry_711 ], [ %t727, %logical_and_right_end_711 ]
  %t729 = load %LexerState, %LexerState* %l0
  %t730 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t731 = load i8, i8* %l2
  %t732 = load double, double* %l27
  %t733 = load double, double* %l28
  %t734 = load double, double* %l29
  br i1 %t728, label %then72, label %merge73
then72:
  %t736 = load %LexerState, %LexerState* %l0
  %t737 = extractvalue %LexerState %t736, 1
  %t738 = sitofp i64 1 to double
  %t739 = fadd double %t737, %t738
  %t740 = load %LexerState, %LexerState* %l0
  %t741 = extractvalue %LexerState %t740, 0
  %t742 = call i64 @sailfin_runtime_string_length(i8* %t741)
  %t743 = sitofp i64 %t742 to double
  %t744 = fcmp olt double %t739, %t743
  br label %logical_and_entry_735

logical_and_entry_735:
  br i1 %t744, label %logical_and_right_735, label %logical_and_merge_735

logical_and_right_735:
  %t745 = load %LexerState, %LexerState* %l0
  %t746 = extractvalue %LexerState %t745, 0
  %t747 = load %LexerState, %LexerState* %l0
  %t748 = extractvalue %LexerState %t747, 1
  %t749 = sitofp i64 1 to double
  %t750 = fadd double %t748, %t749
  %t751 = call double @llvm.round.f64(double %t750)
  %t752 = fptosi double %t751 to i64
  %t753 = getelementptr i8, i8* %t746, i64 %t752
  %t754 = load i8, i8* %t753
  %t755 = alloca [2 x i8], align 1
  %t756 = getelementptr [2 x i8], [2 x i8]* %t755, i32 0, i32 0
  store i8 %t754, i8* %t756
  %t757 = getelementptr [2 x i8], [2 x i8]* %t755, i32 0, i32 1
  store i8 0, i8* %t757
  %t758 = getelementptr [2 x i8], [2 x i8]* %t755, i32 0, i32 0
  %t759 = call i1 @is_digit(i8* %t758)
  br label %logical_and_right_end_735

logical_and_right_end_735:
  br label %logical_and_merge_735

logical_and_merge_735:
  %t760 = phi i1 [ false, %logical_and_entry_735 ], [ %t759, %logical_and_right_end_735 ]
  store i1 %t760, i1* %l30
  %t761 = load i1, i1* %l30
  %t762 = load %LexerState, %LexerState* %l0
  %t763 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t764 = load i8, i8* %l2
  %t765 = load double, double* %l27
  %t766 = load double, double* %l28
  %t767 = load double, double* %l29
  %t768 = load i1, i1* %l30
  br i1 %t761, label %then74, label %merge75
then74:
  %t769 = load %LexerState, %LexerState* %l0
  %t770 = extractvalue %LexerState %t769, 1
  %t771 = sitofp i64 1 to double
  %t772 = fadd double %t770, %t771
  %t773 = load %LexerState, %LexerState* %l0
  %t774 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t772, double* %t774
  %t775 = load %LexerState, %LexerState* %l0
  %t776 = extractvalue %LexerState %t775, 3
  %t777 = sitofp i64 1 to double
  %t778 = fadd double %t776, %t777
  %t779 = load %LexerState, %LexerState* %l0
  %t780 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t778, double* %t780
  %t781 = load %LexerState, %LexerState* %l0
  %t782 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t783 = load i8, i8* %l2
  %t784 = load double, double* %l27
  %t785 = load double, double* %l28
  %t786 = load double, double* %l29
  %t787 = load i1, i1* %l30
  br label %loop.header76
loop.header76:
  br label %loop.body77
loop.body77:
  %t788 = load %LexerState, %LexerState* %l0
  %t789 = extractvalue %LexerState %t788, 1
  %t790 = load %LexerState, %LexerState* %l0
  %t791 = extractvalue %LexerState %t790, 0
  %t792 = call i64 @sailfin_runtime_string_length(i8* %t791)
  %t793 = sitofp i64 %t792 to double
  %t794 = fcmp oge double %t789, %t793
  %t795 = load %LexerState, %LexerState* %l0
  %t796 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t797 = load i8, i8* %l2
  %t798 = load double, double* %l27
  %t799 = load double, double* %l28
  %t800 = load double, double* %l29
  %t801 = load i1, i1* %l30
  br i1 %t794, label %then80, label %merge81
then80:
  br label %afterloop79
merge81:
  %t802 = load %LexerState, %LexerState* %l0
  %t803 = extractvalue %LexerState %t802, 0
  %t804 = load %LexerState, %LexerState* %l0
  %t805 = extractvalue %LexerState %t804, 1
  %t806 = call double @llvm.round.f64(double %t805)
  %t807 = fptosi double %t806 to i64
  %t808 = getelementptr i8, i8* %t803, i64 %t807
  %t809 = load i8, i8* %t808
  %t810 = alloca [2 x i8], align 1
  %t811 = getelementptr [2 x i8], [2 x i8]* %t810, i32 0, i32 0
  store i8 %t809, i8* %t811
  %t812 = getelementptr [2 x i8], [2 x i8]* %t810, i32 0, i32 1
  store i8 0, i8* %t812
  %t813 = getelementptr [2 x i8], [2 x i8]* %t810, i32 0, i32 0
  %t814 = call i1 @is_digit(i8* %t813)
  %t815 = xor i1 %t814, 1
  %t816 = load %LexerState, %LexerState* %l0
  %t817 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t818 = load i8, i8* %l2
  %t819 = load double, double* %l27
  %t820 = load double, double* %l28
  %t821 = load double, double* %l29
  %t822 = load i1, i1* %l30
  br i1 %t815, label %then82, label %merge83
then82:
  br label %afterloop79
merge83:
  %t823 = load %LexerState, %LexerState* %l0
  %t824 = extractvalue %LexerState %t823, 1
  %t825 = sitofp i64 1 to double
  %t826 = fadd double %t824, %t825
  %t827 = load %LexerState, %LexerState* %l0
  %t828 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t826, double* %t828
  %t829 = load %LexerState, %LexerState* %l0
  %t830 = extractvalue %LexerState %t829, 3
  %t831 = sitofp i64 1 to double
  %t832 = fadd double %t830, %t831
  %t833 = load %LexerState, %LexerState* %l0
  %t834 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t832, double* %t834
  br label %loop.latch78
loop.latch78:
  br label %loop.header76
afterloop79:
  br label %merge75
merge75:
  br label %merge73
merge73:
  %t835 = load %LexerState, %LexerState* %l0
  %t836 = extractvalue %LexerState %t835, 0
  %t837 = load double, double* %l27
  %t838 = load %LexerState, %LexerState* %l0
  %t839 = extractvalue %LexerState %t838, 1
  %t840 = call i8* @slice(i8* %t836, double %t837, double %t839)
  store i8* %t840, i8** %l31
  %t841 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t842 = alloca %TokenKind
  %t843 = getelementptr inbounds %TokenKind, %TokenKind* %t842, i32 0, i32 0
  store i32 1, i32* %t843
  %t844 = load i8*, i8** %l31
  %t845 = getelementptr inbounds %TokenKind, %TokenKind* %t842, i32 0, i32 1
  %t846 = bitcast [8 x i8]* %t845 to i8*
  %t847 = bitcast i8* %t846 to i8**
  store i8* %t844, i8** %t847
  %t848 = load %TokenKind, %TokenKind* %t842
  %t849 = insertvalue %Token undef, %TokenKind %t848, 0
  %t850 = load i8*, i8** %l31
  %t851 = insertvalue %Token %t849, i8* %t850, 1
  %t852 = load double, double* %l28
  %t853 = insertvalue %Token %t851, double %t852, 2
  %t854 = load double, double* %l29
  %t855 = insertvalue %Token %t853, double %t854, 3
  %t856 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t841, %Token %t855)
  store { %Token*, i64 }* %t856, { %Token*, i64 }** %l1
  br label %loop.latch2
merge63:
  %t857 = load i8, i8* %l2
  %t858 = alloca [2 x i8], align 1
  %t859 = getelementptr [2 x i8], [2 x i8]* %t858, i32 0, i32 0
  store i8 %t857, i8* %t859
  %t860 = getelementptr [2 x i8], [2 x i8]* %t858, i32 0, i32 1
  store i8 0, i8* %t860
  %t861 = getelementptr [2 x i8], [2 x i8]* %t858, i32 0, i32 0
  %t862 = call i1 @is_identifier_start(i8* %t861)
  %t863 = load %LexerState, %LexerState* %l0
  %t864 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t865 = load i8, i8* %l2
  br i1 %t862, label %then84, label %merge85
then84:
  %t866 = load %LexerState, %LexerState* %l0
  %t867 = extractvalue %LexerState %t866, 1
  store double %t867, double* %l32
  %t868 = load %LexerState, %LexerState* %l0
  %t869 = extractvalue %LexerState %t868, 2
  store double %t869, double* %l33
  %t870 = load %LexerState, %LexerState* %l0
  %t871 = extractvalue %LexerState %t870, 3
  store double %t871, double* %l34
  %t872 = load %LexerState, %LexerState* %l0
  %t873 = extractvalue %LexerState %t872, 1
  %t874 = sitofp i64 1 to double
  %t875 = fadd double %t873, %t874
  %t876 = load %LexerState, %LexerState* %l0
  %t877 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t875, double* %t877
  %t878 = load %LexerState, %LexerState* %l0
  %t879 = extractvalue %LexerState %t878, 3
  %t880 = sitofp i64 1 to double
  %t881 = fadd double %t879, %t880
  %t882 = load %LexerState, %LexerState* %l0
  %t883 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t881, double* %t883
  %t884 = load %LexerState, %LexerState* %l0
  %t885 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t886 = load i8, i8* %l2
  %t887 = load double, double* %l32
  %t888 = load double, double* %l33
  %t889 = load double, double* %l34
  br label %loop.header86
loop.header86:
  br label %loop.body87
loop.body87:
  %t890 = load %LexerState, %LexerState* %l0
  %t891 = extractvalue %LexerState %t890, 1
  %t892 = load %LexerState, %LexerState* %l0
  %t893 = extractvalue %LexerState %t892, 0
  %t894 = call i64 @sailfin_runtime_string_length(i8* %t893)
  %t895 = sitofp i64 %t894 to double
  %t896 = fcmp oge double %t891, %t895
  %t897 = load %LexerState, %LexerState* %l0
  %t898 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t899 = load i8, i8* %l2
  %t900 = load double, double* %l32
  %t901 = load double, double* %l33
  %t902 = load double, double* %l34
  br i1 %t896, label %then90, label %merge91
then90:
  br label %afterloop89
merge91:
  %t903 = load %LexerState, %LexerState* %l0
  %t904 = extractvalue %LexerState %t903, 0
  %t905 = load %LexerState, %LexerState* %l0
  %t906 = extractvalue %LexerState %t905, 1
  %t907 = call double @llvm.round.f64(double %t906)
  %t908 = fptosi double %t907 to i64
  %t909 = getelementptr i8, i8* %t904, i64 %t908
  %t910 = load i8, i8* %t909
  %t911 = alloca [2 x i8], align 1
  %t912 = getelementptr [2 x i8], [2 x i8]* %t911, i32 0, i32 0
  store i8 %t910, i8* %t912
  %t913 = getelementptr [2 x i8], [2 x i8]* %t911, i32 0, i32 1
  store i8 0, i8* %t913
  %t914 = getelementptr [2 x i8], [2 x i8]* %t911, i32 0, i32 0
  %t915 = call i1 @is_identifier_part(i8* %t914)
  %t916 = xor i1 %t915, 1
  %t917 = load %LexerState, %LexerState* %l0
  %t918 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t919 = load i8, i8* %l2
  %t920 = load double, double* %l32
  %t921 = load double, double* %l33
  %t922 = load double, double* %l34
  br i1 %t916, label %then92, label %merge93
then92:
  br label %afterloop89
merge93:
  %t923 = load %LexerState, %LexerState* %l0
  %t924 = extractvalue %LexerState %t923, 1
  %t925 = sitofp i64 1 to double
  %t926 = fadd double %t924, %t925
  %t927 = load %LexerState, %LexerState* %l0
  %t928 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t926, double* %t928
  %t929 = load %LexerState, %LexerState* %l0
  %t930 = extractvalue %LexerState %t929, 3
  %t931 = sitofp i64 1 to double
  %t932 = fadd double %t930, %t931
  %t933 = load %LexerState, %LexerState* %l0
  %t934 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t932, double* %t934
  br label %loop.latch88
loop.latch88:
  br label %loop.header86
afterloop89:
  %t935 = load %LexerState, %LexerState* %l0
  %t936 = extractvalue %LexerState %t935, 0
  %t937 = load double, double* %l32
  %t938 = load %LexerState, %LexerState* %l0
  %t939 = extractvalue %LexerState %t938, 1
  %t940 = call i8* @slice(i8* %t936, double %t937, double %t939)
  store i8* %t940, i8** %l35
  %t942 = load i8*, i8** %l35
  %s943 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h275946731, i32 0, i32 0
  %t944 = call i1 @strings_equal(i8* %t942, i8* %s943)
  br label %logical_or_entry_941

logical_or_entry_941:
  br i1 %t944, label %logical_or_merge_941, label %logical_or_right_941

logical_or_right_941:
  %t945 = load i8*, i8** %l35
  %s946 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2095430042, i32 0, i32 0
  %t947 = call i1 @strings_equal(i8* %t945, i8* %s946)
  br label %logical_or_right_end_941

logical_or_right_end_941:
  br label %logical_or_merge_941

logical_or_merge_941:
  %t948 = phi i1 [ true, %logical_or_entry_941 ], [ %t947, %logical_or_right_end_941 ]
  %t949 = load %LexerState, %LexerState* %l0
  %t950 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t951 = load i8, i8* %l2
  %t952 = load double, double* %l32
  %t953 = load double, double* %l33
  %t954 = load double, double* %l34
  %t955 = load i8*, i8** %l35
  br i1 %t948, label %then94, label %else95
then94:
  %t956 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t957 = alloca %TokenKind
  %t958 = getelementptr inbounds %TokenKind, %TokenKind* %t957, i32 0, i32 0
  store i32 3, i32* %t958
  %t959 = load i8*, i8** %l35
  %t960 = getelementptr inbounds %TokenKind, %TokenKind* %t957, i32 0, i32 1
  %t961 = bitcast [8 x i8]* %t960 to i8*
  %t962 = bitcast i8* %t961 to i8**
  store i8* %t959, i8** %t962
  %t963 = load %TokenKind, %TokenKind* %t957
  %t964 = insertvalue %Token undef, %TokenKind %t963, 0
  %t965 = load i8*, i8** %l35
  %t966 = insertvalue %Token %t964, i8* %t965, 1
  %t967 = load double, double* %l33
  %t968 = insertvalue %Token %t966, double %t967, 2
  %t969 = load double, double* %l34
  %t970 = insertvalue %Token %t968, double %t969, 3
  %t971 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t956, %Token %t970)
  store { %Token*, i64 }* %t971, { %Token*, i64 }** %l1
  %t972 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br label %merge96
else95:
  %t973 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t974 = alloca %TokenKind
  %t975 = getelementptr inbounds %TokenKind, %TokenKind* %t974, i32 0, i32 0
  store i32 0, i32* %t975
  %t976 = load i8*, i8** %l35
  %t977 = getelementptr inbounds %TokenKind, %TokenKind* %t974, i32 0, i32 1
  %t978 = bitcast [8 x i8]* %t977 to i8*
  %t979 = bitcast i8* %t978 to i8**
  store i8* %t976, i8** %t979
  %t980 = load %TokenKind, %TokenKind* %t974
  %t981 = insertvalue %Token undef, %TokenKind %t980, 0
  %t982 = load i8*, i8** %l35
  %t983 = insertvalue %Token %t981, i8* %t982, 1
  %t984 = load double, double* %l33
  %t985 = insertvalue %Token %t983, double %t984, 2
  %t986 = load double, double* %l34
  %t987 = insertvalue %Token %t985, double %t986, 3
  %t988 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t973, %Token %t987)
  store { %Token*, i64 }* %t988, { %Token*, i64 }** %l1
  %t989 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br label %merge96
merge96:
  %t990 = phi { %Token*, i64 }* [ %t972, %then94 ], [ %t989, %else95 ]
  store { %Token*, i64 }* %t990, { %Token*, i64 }** %l1
  br label %loop.latch2
merge85:
  %t991 = load %LexerState, %LexerState* %l0
  %t992 = extractvalue %LexerState %t991, 2
  store double %t992, double* %l36
  %t993 = load %LexerState, %LexerState* %l0
  %t994 = extractvalue %LexerState %t993, 3
  store double %t994, double* %l37
  %t995 = load i8, i8* %l2
  store i8 %t995, i8* %l38
  %t996 = load %LexerState, %LexerState* %l0
  %t997 = call i8* @peek_next_char(%LexerState %t996)
  store i8* %t997, i8** %l39
  %t998 = load i8*, i8** %l39
  %s999 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t1000 = call i1 @strings_equal(i8* %t998, i8* %s999)
  %t1001 = xor i1 %t1000, true
  %t1002 = load %LexerState, %LexerState* %l0
  %t1003 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t1004 = load i8, i8* %l2
  %t1005 = load double, double* %l36
  %t1006 = load double, double* %l37
  %t1007 = load i8, i8* %l38
  %t1008 = load i8*, i8** %l39
  br i1 %t1001, label %then97, label %merge98
then97:
  %t1009 = load i8, i8* %l2
  %t1010 = load i8*, i8** %l39
  %t1011 = alloca [2 x i8], align 1
  %t1012 = getelementptr [2 x i8], [2 x i8]* %t1011, i32 0, i32 0
  store i8 %t1009, i8* %t1012
  %t1013 = getelementptr [2 x i8], [2 x i8]* %t1011, i32 0, i32 1
  store i8 0, i8* %t1013
  %t1014 = getelementptr [2 x i8], [2 x i8]* %t1011, i32 0, i32 0
  %t1015 = call i8* @sailfin_runtime_string_concat(i8* %t1014, i8* %t1010)
  store i8* %t1015, i8** %l40
  %t1016 = load i8*, i8** %l40
  %t1017 = call i1 @is_two_char_symbol(i8* %t1016)
  %t1018 = load %LexerState, %LexerState* %l0
  %t1019 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t1020 = load i8, i8* %l2
  %t1021 = load double, double* %l36
  %t1022 = load double, double* %l37
  %t1023 = load i8, i8* %l38
  %t1024 = load i8*, i8** %l39
  %t1025 = load i8*, i8** %l40
  br i1 %t1017, label %then99, label %merge100
then99:
  %t1026 = load i8*, i8** %l40
  %t1027 = load i8, i8* %t1026
  store i8 %t1027, i8* %l38
  %t1028 = load %LexerState, %LexerState* %l0
  %t1029 = extractvalue %LexerState %t1028, 1
  %t1030 = sitofp i64 2 to double
  %t1031 = fadd double %t1029, %t1030
  %t1032 = load %LexerState, %LexerState* %l0
  %t1033 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t1031, double* %t1033
  %t1034 = load %LexerState, %LexerState* %l0
  %t1035 = extractvalue %LexerState %t1034, 3
  %t1036 = sitofp i64 2 to double
  %t1037 = fadd double %t1035, %t1036
  %t1038 = load %LexerState, %LexerState* %l0
  %t1039 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t1037, double* %t1039
  %t1040 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t1041 = alloca %TokenKind
  %t1042 = getelementptr inbounds %TokenKind, %TokenKind* %t1041, i32 0, i32 0
  store i32 4, i32* %t1042
  %t1043 = load i8, i8* %l38
  %t1044 = call noalias i8* @malloc(i64 1)
  %t1045 = bitcast i8* %t1044 to i8*
  store i8 %t1043, i8* %t1045
  %t1046 = getelementptr inbounds %TokenKind, %TokenKind* %t1041, i32 0, i32 1
  %t1047 = bitcast [8 x i8]* %t1046 to i8*
  %t1048 = bitcast i8* %t1047 to i8**
  store i8* %t1044, i8** %t1048
  %t1049 = load %TokenKind, %TokenKind* %t1041
  %t1050 = insertvalue %Token undef, %TokenKind %t1049, 0
  %t1051 = load i8, i8* %l38
  %t1052 = alloca [2 x i8], align 1
  %t1053 = getelementptr [2 x i8], [2 x i8]* %t1052, i32 0, i32 0
  store i8 %t1051, i8* %t1053
  %t1054 = getelementptr [2 x i8], [2 x i8]* %t1052, i32 0, i32 1
  store i8 0, i8* %t1054
  %t1055 = getelementptr [2 x i8], [2 x i8]* %t1052, i32 0, i32 0
  %t1056 = insertvalue %Token %t1050, i8* %t1055, 1
  %t1057 = load double, double* %l36
  %t1058 = insertvalue %Token %t1056, double %t1057, 2
  %t1059 = load double, double* %l37
  %t1060 = insertvalue %Token %t1058, double %t1059, 3
  %t1061 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t1040, %Token %t1060)
  store { %Token*, i64 }* %t1061, { %Token*, i64 }** %l1
  br label %loop.latch2
merge100:
  %t1062 = load i8, i8* %l38
  %t1063 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br label %merge98
merge98:
  %t1064 = phi i8 [ %t1062, %merge100 ], [ %t1007, %merge85 ]
  %t1065 = phi { %Token*, i64 }* [ %t1063, %merge100 ], [ %t1003, %merge85 ]
  store i8 %t1064, i8* %l38
  store { %Token*, i64 }* %t1065, { %Token*, i64 }** %l1
  %t1066 = load %LexerState, %LexerState* %l0
  %t1067 = extractvalue %LexerState %t1066, 1
  %t1068 = sitofp i64 1 to double
  %t1069 = fadd double %t1067, %t1068
  %t1070 = load %LexerState, %LexerState* %l0
  %t1071 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 1
  store double %t1069, double* %t1071
  %t1072 = load i8, i8* %l2
  %t1073 = icmp eq i8 %t1072, 10
  %t1074 = load %LexerState, %LexerState* %l0
  %t1075 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t1076 = load i8, i8* %l2
  %t1077 = load double, double* %l36
  %t1078 = load double, double* %l37
  %t1079 = load i8, i8* %l38
  %t1080 = load i8*, i8** %l39
  br i1 %t1073, label %then101, label %else102
then101:
  %t1081 = load %LexerState, %LexerState* %l0
  %t1082 = extractvalue %LexerState %t1081, 2
  %t1083 = sitofp i64 1 to double
  %t1084 = fadd double %t1082, %t1083
  %t1085 = load %LexerState, %LexerState* %l0
  %t1086 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 2
  store double %t1084, double* %t1086
  %t1087 = load %LexerState, %LexerState* %l0
  %t1088 = sitofp i64 1 to double
  %t1089 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t1088, double* %t1089
  br label %merge103
else102:
  %t1090 = load %LexerState, %LexerState* %l0
  %t1091 = extractvalue %LexerState %t1090, 3
  %t1092 = sitofp i64 1 to double
  %t1093 = fadd double %t1091, %t1092
  %t1094 = load %LexerState, %LexerState* %l0
  %t1095 = getelementptr %LexerState, %LexerState* %l0, i32 0, i32 3
  store double %t1093, double* %t1095
  br label %merge103
merge103:
  %t1096 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t1097 = alloca %TokenKind
  %t1098 = getelementptr inbounds %TokenKind, %TokenKind* %t1097, i32 0, i32 0
  store i32 4, i32* %t1098
  %t1099 = load i8, i8* %l38
  %t1100 = call noalias i8* @malloc(i64 1)
  %t1101 = bitcast i8* %t1100 to i8*
  store i8 %t1099, i8* %t1101
  %t1102 = getelementptr inbounds %TokenKind, %TokenKind* %t1097, i32 0, i32 1
  %t1103 = bitcast [8 x i8]* %t1102 to i8*
  %t1104 = bitcast i8* %t1103 to i8**
  store i8* %t1100, i8** %t1104
  %t1105 = load %TokenKind, %TokenKind* %t1097
  %t1106 = insertvalue %Token undef, %TokenKind %t1105, 0
  %t1107 = load i8, i8* %l38
  %t1108 = alloca [2 x i8], align 1
  %t1109 = getelementptr [2 x i8], [2 x i8]* %t1108, i32 0, i32 0
  store i8 %t1107, i8* %t1109
  %t1110 = getelementptr [2 x i8], [2 x i8]* %t1108, i32 0, i32 1
  store i8 0, i8* %t1110
  %t1111 = getelementptr [2 x i8], [2 x i8]* %t1108, i32 0, i32 0
  %t1112 = insertvalue %Token %t1106, i8* %t1111, 1
  %t1113 = load double, double* %l36
  %t1114 = insertvalue %Token %t1112, double %t1113, 2
  %t1115 = load double, double* %l37
  %t1116 = insertvalue %Token %t1114, double %t1115, 3
  %t1117 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t1096, %Token %t1116)
  store { %Token*, i64 }* %t1117, { %Token*, i64 }** %l1
  br label %loop.latch2
loop.latch2:
  %t1118 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  br label %loop.header0
afterloop3:
  %t1120 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t1121 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t1122 = load %LexerState, %LexerState* %l0
  %t1123 = extractvalue %LexerState %t1122, 2
  %t1124 = load %LexerState, %LexerState* %l0
  %t1125 = extractvalue %LexerState %t1124, 3
  %t1126 = call %Token @eof_token(double %t1123, double %t1125)
  %t1127 = call { %Token*, i64 }* @append({ %Token*, i64 }* %t1121, %Token %t1126)
  store { %Token*, i64 }* %t1127, { %Token*, i64 }** %l1
  %t1128 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  ret { %Token*, i64 }* %t1128
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
  %t0 = call noalias i8* @malloc(i64 40)
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
  %t16 = getelementptr { %Token*, i64 }, { i8**, i64 }* %t15, i32 0, i32 0
  %t17 = load %Token*, %Token** %t16
  %t18 = getelementptr { %Token*, i64 }, { i8**, i64 }* %t15, i32 0, i32 1
  %t19 = load i64, i64* %t18
  %t20 = getelementptr { %Token*, i64 }, { i8**, i64 }* %t12, i32 0, i32 0
  %t21 = load %Token*, %Token** %t20
  %t22 = getelementptr { %Token*, i64 }, { i8**, i64 }* %t12, i32 0, i32 1
  %t23 = load i64, i64* %t22
  %t24 = getelementptr [1 x %Token], [1 x %Token]* null, i32 0, i32 1
  %t25 = ptrtoint %Token* %t24 to i64
  %t26 = add i64 %t19, %t23
  %t27 = mul i64 %t25, %t26
  %t28 = call noalias i8* @malloc(i64 %t27)
  %t29 = bitcast i8* %t28 to %Token*
  %t30 = bitcast %Token* %t29 to i8*
  %t31 = mul i64 %t25, %t19
  %t32 = bitcast %Token* %t17 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t30, i8* %t32, i64 %t31)
  %t33 = mul i64 %t25, %t23
  %t34 = bitcast %Token* %t21 to i8*
  %t35 = getelementptr %Token, %Token* %t29, i64 %t19
  %t36 = bitcast %Token* %t35 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t36, i8* %t34, i64 %t33)
  %t37 = getelementptr { %Token*, i64 }, { %Token*, i64 }* null, i32 1
  %t38 = ptrtoint { %Token*, i64 }* %t37 to i64
  %t39 = call i8* @malloc(i64 %t38)
  %t40 = bitcast i8* %t39 to { %Token*, i64 }*
  %t41 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t40, i32 0, i32 0
  store %Token* %t29, %Token** %t41
  %t42 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t40, i32 0, i32 1
  store i64 %t26, i64* %t42
  %t43 = bitcast { i8**, i64 }* %t40 to { %Token*, i64 }*
  ret { %Token*, i64 }* %t43
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
  %t12 = call double @llvm.round.f64(double %t11)
  %t13 = fptosi double %t12 to i64
  %t14 = getelementptr i8, i8* %t10, i64 %t13
  %t15 = load i8, i8* %t14
  %t16 = alloca [2 x i8], align 1
  %t17 = getelementptr [2 x i8], [2 x i8]* %t16, i32 0, i32 0
  store i8 %t15, i8* %t17
  %t18 = getelementptr [2 x i8], [2 x i8]* %t16, i32 0, i32 1
  store i8 0, i8* %t18
  %t19 = getelementptr [2 x i8], [2 x i8]* %t16, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %t19)
  ret i8* %t19
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
  call void @sailfin_runtime_mark_persistent(i8* %t5)
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
  call void @sailfin_runtime_mark_persistent(i8* %t11)
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
  call void @sailfin_runtime_mark_persistent(i8* %t17)
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
  call void @sailfin_runtime_mark_persistent(i8* %t22)
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
  call void @sailfin_runtime_mark_persistent(i8* %t27)
  ret i8* %t27
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
@.str.len5.h2095430042 = private unnamed_addr constant [6 x i8] c"false\00"
@.str.len0.h177573 = private unnamed_addr constant [1 x i8] c"\00"
@.str.len4.h275946731 = private unnamed_addr constant [5 x i8] c"true\00"