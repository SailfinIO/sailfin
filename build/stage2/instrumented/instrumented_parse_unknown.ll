define %StatementParseResult @parse_unknown(%Parser %initial_parser) {
block.entry:
  call void @stage2_debug_marker(i64 10000)
  %l0 = alloca %Parser
  %l1 = alloca { %Token*, i64 }*
  %l2 = alloca %Parser
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca i1
  %l7 = alloca %Token
  %l8 = alloca i8*
  %l9 = alloca %Statement
  store %Parser %initial_parser, %Parser* %l0
  %t0 = load %Parser, %Parser* %l0
  %t1 = call %Parser @skip_trivia(%Parser %t0)
  store %Parser %t1, %Parser* %l0
  %t2 = getelementptr [0 x %Token], [0 x %Token]* null, i32 1
  %t3 = ptrtoint [0 x %Token]* %t2 to i64
  %t4 = icmp eq i64 %t3, 0
  %t5 = select i1 %t4, i64 1, i64 %t3
  %t6 = call i8* @malloc(i64 %t5)
  %t7 = bitcast i8* %t6 to %Token*
  %t8 = getelementptr { %Token*, i64 }, { %Token*, i64 }* null, i32 1
  %t9 = ptrtoint { %Token*, i64 }* %t8 to i64
  %t10 = call i8* @malloc(i64 %t9)
  %t11 = bitcast i8* %t10 to { %Token*, i64 }*
  %t12 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t11, i32 0, i32 0
  store %Token* %t7, %Token** %t12
  %t13 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t11, i32 0, i32 1
  store i64 0, i64* %t13
  store { %Token*, i64 }* %t11, { %Token*, i64 }** %l1
  %t14 = load %Parser, %Parser* %l0
  store %Parser %t14, %Parser* %l2
  %t15 = sitofp i64 0 to double
  store double %t15, double* %l3
  %t16 = sitofp i64 16384 to double
  store double %t16, double* %l4
  %t17 = sitofp i64 0 to double
  store double %t17, double* %l5
  store i1 0, i1* %l6
  %t18 = load %Parser, %Parser* %l0
  %t19 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t20 = load %Parser, %Parser* %l2
  %t21 = load double, double* %l3
  %t22 = load double, double* %l4
  %t23 = load double, double* %l5
  %t24 = load i1, i1* %l6
  br label %loop.header0
loop.header0:
  %t181 = phi i1 [ %t24, %block.entry ], [ %t176, %loop.latch2 ]
  %t182 = phi %Parser [ %t20, %block.entry ], [ %t177, %loop.latch2 ]
  %t183 = phi double [ %t23, %block.entry ], [ %t178, %loop.latch2 ]
  %t184 = phi { %Token*, i64 }* [ %t19, %block.entry ], [ %t179, %loop.latch2 ]
  %t185 = phi double [ %t21, %block.entry ], [ %t180, %loop.latch2 ]
  store i1 %t181, i1* %l6
  store %Parser %t182, %Parser* %l2
  store double %t183, double* %l5
  store { %Token*, i64 }* %t184, { %Token*, i64 }** %l1
  store double %t185, double* %l3
  br label %loop.body1
loop.body1:
  %stage2_unknown_parser = load %Parser, %Parser* %l2
  %stage2_unknown_index = extractvalue %Parser %stage2_unknown_parser, 1
  %stage2_unknown_index_i64 = fptosi double %stage2_unknown_index to i64
  %stage2_unknown_marker = add i64 %stage2_unknown_index_i64, 10000
  call void @stage2_debug_marker(i64 %stage2_unknown_marker)
  %t25 = load double, double* %l5
  %t26 = load double, double* %l4
  %t27 = fcmp oge double %t25, %t26
  %t28 = load %Parser, %Parser* %l0
  %t29 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t30 = load %Parser, %Parser* %l2
  %t31 = load double, double* %l3
  %t32 = load double, double* %l4
  %t33 = load double, double* %l5
  %t34 = load i1, i1* %l6
  br i1 %t27, label %then4, label %merge5
then4:
  store i1 1, i1* %l6
  %t35 = load %Parser, %Parser* %l2
  %t36 = call %Parser @parser_advance_raw(%Parser %t35)
  store %Parser %t36, %Parser* %l2
  br label %afterloop3
merge5:
  %t37 = load double, double* %l5
  %t38 = sitofp i64 1 to double
  %t39 = fadd double %t37, %t38
  store double %t39, double* %l5
  %t40 = load %Parser, %Parser* %l2
  %t41 = call %Token @parser_peek_raw(%Parser %t40)
  store %Token %t41, %Token* %l7
  %stage2_unknown_token = load %Token, %Token* %l7
  %stage2_unknown_token_kind = extractvalue %Token %stage2_unknown_token, 0
  %stage2_unknown_token_variant = extractvalue %TokenKind %stage2_unknown_token_kind, 0
  %stage2_unknown_token_variant_i64 = sext i32 %stage2_unknown_token_variant to i64
  %stage2_unknown_token_marker = add i64 %stage2_unknown_token_variant_i64, 11000
  call void @stage2_debug_marker(i64 %stage2_unknown_token_marker)
  %stage2_unknown_depth_value = load double, double* %l3
  %stage2_unknown_depth_i64 = fptosi double %stage2_unknown_depth_value to i64
  %stage2_unknown_depth_marker = add i64 %stage2_unknown_depth_i64, 13000
  call void @stage2_debug_marker(i64 %stage2_unknown_depth_marker)
  %stage2_unknown_lexeme_ptr = extractvalue %Token %stage2_unknown_token, 1
  %stage2_unknown_lexeme_len = call i64 @sailfin_runtime_string_length(i8* %stage2_unknown_lexeme_ptr)
  call void @stage2_debug_unknown_lexeme(i8* %stage2_unknown_lexeme_ptr, i64 %stage2_unknown_lexeme_len)
  %t42 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t43 = load %Token, %Token* %l7
  %t44 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t42, %Token %t43)
  store { %Token*, i64 }* %t44, { %Token*, i64 }** %l1
  %t45 = load %Token, %Token* %l7
  %t46 = add i64 0, 2
  %t47 = call i8* @malloc(i64 %t46)
  store i8 123, i8* %t47
  %t48 = getelementptr i8, i8* %t47, i64 1
  store i8 0, i8* %t48
  call void @sailfin_runtime_mark_persistent(i8* %t47)
  %t49 = call i1 @symbol_matches(%Token %t45, i8* %t47)
  %t50 = load %Parser, %Parser* %l0
  %t51 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t52 = load %Parser, %Parser* %l2
  %t53 = load double, double* %l3
  %t54 = load double, double* %l4
  %t55 = load double, double* %l5
  %t56 = load i1, i1* %l6
  %t57 = load %Token, %Token* %l7
  br i1 %t49, label %then6, label %else7
then6:
  %t58 = load double, double* %l3
  %t59 = sitofp i64 1 to double
  %t60 = fadd double %t58, %t59
  store double %t60, double* %l3
  %t61 = load double, double* %l3
  br label %merge8
else7:
  %t62 = load %Token, %Token* %l7
  %t63 = add i64 0, 2
  %t64 = call i8* @malloc(i64 %t63)
  store i8 125, i8* %t64
  %t65 = getelementptr i8, i8* %t64, i64 1
  store i8 0, i8* %t65
  call void @sailfin_runtime_mark_persistent(i8* %t64)
  %t66 = call i1 @symbol_matches(%Token %t62, i8* %t64)
  %t67 = load %Parser, %Parser* %l0
  %t68 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t69 = load %Parser, %Parser* %l2
  %t70 = load double, double* %l3
  %t71 = load double, double* %l4
  %t72 = load double, double* %l5
  %t73 = load i1, i1* %l6
  %t74 = load %Token, %Token* %l7
  br i1 %t66, label %then9, label %else10
then9:
  %t75 = load double, double* %l3
  %t76 = sitofp i64 0 to double
  %t77 = fcmp ogt double %t75, %t76
  %t78 = load %Parser, %Parser* %l0
  %t79 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t80 = load %Parser, %Parser* %l2
  %t81 = load double, double* %l3
  %t82 = load double, double* %l4
  %t83 = load double, double* %l5
  %t84 = load i1, i1* %l6
  %t85 = load %Token, %Token* %l7
  br i1 %t77, label %then12, label %merge13
then12:
  %t86 = load double, double* %l3
  %t87 = sitofp i64 1 to double
  %t88 = fsub double %t86, %t87
  store double %t88, double* %l3
  %t89 = load double, double* %l3
  br label %merge13
merge13:
  %t90 = phi double [ %t89, %then12 ], [ %t81, %then9 ]
  store double %t90, double* %l3
  %t91 = load double, double* %l3
  %t92 = sitofp i64 0 to double
  %t93 = fcmp oeq double %t91, %t92
  %t94 = load %Parser, %Parser* %l0
  %t95 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t96 = load %Parser, %Parser* %l2
  %t97 = load double, double* %l3
  %t98 = load double, double* %l4
  %t99 = load double, double* %l5
  %t100 = load i1, i1* %l6
  %t101 = load %Token, %Token* %l7
  br i1 %t93, label %then14, label %merge15
then14:
  %t102 = load %Parser, %Parser* %l2
  %t103 = call %Parser @parser_advance_raw(%Parser %t102)
  store %Parser %t103, %Parser* %l2
  br label %afterloop3
merge15:
  %t104 = load double, double* %l3
  %t105 = load %Parser, %Parser* %l2
  br label %merge11
else10:
  %t107 = load double, double* %l3
  %t108 = sitofp i64 0 to double
  %t109 = fcmp oeq double %t107, %t108
  br label %logical_and_entry_106

logical_and_entry_106:
  br i1 %t109, label %logical_and_right_106, label %logical_and_merge_106

logical_and_right_106:
  %t110 = load %Token, %Token* %l7
  %t111 = add i64 0, 2
  %t112 = call i8* @malloc(i64 %t111)
  store i8 59, i8* %t112
  %t113 = getelementptr i8, i8* %t112, i64 1
  store i8 0, i8* %t113
  call void @sailfin_runtime_mark_persistent(i8* %t112)
  %t114 = call i1 @symbol_matches(%Token %t110, i8* %t112)
  br label %logical_and_right_end_106

logical_and_right_end_106:
  br label %logical_and_merge_106

logical_and_merge_106:
  %t115 = phi i1 [ false, %logical_and_entry_106 ], [ %t114, %logical_and_right_end_106 ]
  %t116 = load %Parser, %Parser* %l0
  %t117 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t118 = load %Parser, %Parser* %l2
  %t119 = load double, double* %l3
  %t120 = load double, double* %l4
  %t121 = load double, double* %l5
  %t122 = load i1, i1* %l6
  %t123 = load %Token, %Token* %l7
  br i1 %t115, label %then16, label %merge17
then16:
  %t124 = load %Parser, %Parser* %l2
  %t125 = call %Parser @parser_advance_raw(%Parser %t124)
  store %Parser %t125, %Parser* %l2
  br label %afterloop3
merge17:
  %t126 = load %Parser, %Parser* %l2
  br label %merge11
merge11:
  %t127 = phi double [ %t104, %merge15 ], [ %t70, %merge17 ]
  %t128 = phi %Parser [ %t105, %merge15 ], [ %t126, %merge17 ]
  store double %t127, double* %l3
  store %Parser %t128, %Parser* %l2
  %t129 = load double, double* %l3
  %t130 = load %Parser, %Parser* %l2
  %t131 = load %Parser, %Parser* %l2
  br label %merge8
merge8:
  %t132 = phi double [ %t61, %then6 ], [ %t129, %merge11 ]
  %t133 = phi %Parser [ %t52, %then6 ], [ %t130, %merge11 ]
  store double %t132, double* %l3
  store %Parser %t133, %Parser* %l2
  %t134 = load %Token, %Token* %l7
  %t135 = extractvalue %Token %t134, 0
  %t136 = extractvalue %TokenKind %t135, 0
  %t137 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t138 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t139 = icmp eq i32 %t136, 0
  %t140 = select i1 %t139, i8* %t138, i8* %t137
  %t141 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t142 = icmp eq i32 %t136, 1
  %t143 = select i1 %t142, i8* %t141, i8* %t140
  %t144 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t145 = icmp eq i32 %t136, 2
  %t146 = select i1 %t145, i8* %t144, i8* %t143
  %t147 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t148 = icmp eq i32 %t136, 3
  %t149 = select i1 %t148, i8* %t147, i8* %t146
  %t150 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t151 = icmp eq i32 %t136, 4
  %t152 = select i1 %t151, i8* %t150, i8* %t149
  %t153 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t154 = icmp eq i32 %t136, 5
  %t155 = select i1 %t154, i8* %t153, i8* %t152
  %t156 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t157 = icmp eq i32 %t136, 6
  %t158 = select i1 %t157, i8* %t156, i8* %t155
  %t159 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t160 = icmp eq i32 %t136, 7
  %t161 = select i1 %t160, i8* %t159, i8* %t158
  %s162 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1021477046, i32 0, i32 0
  %t163 = call i1 @strings_equal(i8* %t161, i8* %s162)
  %t164 = load %Parser, %Parser* %l0
  %t165 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t166 = load %Parser, %Parser* %l2
  %t167 = load double, double* %l3
  %t168 = load double, double* %l4
  %t169 = load double, double* %l5
  %t170 = load i1, i1* %l6
  %t171 = load %Token, %Token* %l7
  br i1 %t163, label %then18, label %merge19
then18:
  %t172 = load %Parser, %Parser* %l2
  %t173 = call %Parser @parser_advance_raw(%Parser %t172)
  store %Parser %t173, %Parser* %l2
  br label %afterloop3
merge19:
  %t174 = load %Parser, %Parser* %l2
  %t175 = call %Parser @parser_advance_raw(%Parser %t174)
  store %Parser %t175, %Parser* %l2
  br label %loop.latch2
loop.latch2:
  %t176 = load i1, i1* %l6
  %t177 = load %Parser, %Parser* %l2
  %t178 = load double, double* %l5
  %t179 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t180 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t186 = load i1, i1* %l6
  %t187 = load %Parser, %Parser* %l2
  %t188 = load double, double* %l5
  %t189 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t190 = load double, double* %l3
  %t191 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t192 = call i8* @tokens_to_text({ %Token*, i64 }* %t191)
  store i8* %t192, i8** %l8
  %t193 = load i1, i1* %l6
  %t194 = load %Parser, %Parser* %l0
  %t195 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t196 = load %Parser, %Parser* %l2
  %t197 = load double, double* %l3
  %t198 = load double, double* %l4
  %t199 = load double, double* %l5
  %t200 = load i1, i1* %l6
  %t201 = load i8*, i8** %l8
  br i1 %t193, label %then20, label %merge21
then20:
  %t202 = load i8*, i8** %l8
  %s203 = getelementptr inbounds [31 x i8], [31 x i8]* @.str.len30.h1141851511, i32 0, i32 0
  %t204 = call i8* @sailfin_runtime_string_concat(i8* %t202, i8* %s203)
  store i8* %t204, i8** %l8
  %t205 = load i8*, i8** %l8
  br label %merge21
merge21:
  %t206 = phi i8* [ %t205, %then20 ], [ %t201, %afterloop3 ]
  store i8* %t206, i8** %l8
  %t207 = alloca %Statement
  %t208 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 0
  store i32 22, i32* %t208
  %t209 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t210 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t211 = bitcast [16 x i8]* %t210 to i8*
  %t212 = bitcast i8* %t211 to { %Token*, i64 }**
  store { %Token*, i64 }* %t209, { %Token*, i64 }** %t212
  %t213 = load i8*, i8** %l8
  %t214 = getelementptr inbounds %Statement, %Statement* %t207, i32 0, i32 1
  %t215 = bitcast [16 x i8]* %t214 to i8*
  %t216 = getelementptr inbounds i8, i8* %t215, i64 8
  %t217 = bitcast i8* %t216 to i8**
  store i8* %t213, i8** %t217
  %t218 = load %Statement, %Statement* %t207
  store %Statement %t218, %Statement* %l9
  %t219 = load %Parser, %Parser* %l2
  %t220 = call %Parser @skip_trivia(%Parser %t219)
  store %Parser %t220, %Parser* %l0
  %t221 = load %Parser, %Parser* %l0
  %t222 = insertvalue %StatementParseResult undef, %Parser %t221, 0
  %t223 = load %Statement, %Statement* %l9
  %t224 = insertvalue %StatementParseResult %t222, %Statement %t223, 1
  ret %StatementParseResult %t224
}
