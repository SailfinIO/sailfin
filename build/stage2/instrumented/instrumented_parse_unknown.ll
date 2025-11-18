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
  %t184 = phi i1 [ %t24, %block.entry ], [ %t179, %loop.latch2 ]
  %t185 = phi %Parser [ %t20, %block.entry ], [ %t180, %loop.latch2 ]
  %t186 = phi double [ %t23, %block.entry ], [ %t181, %loop.latch2 ]
  %t187 = phi { %Token*, i64 }* [ %t19, %block.entry ], [ %t182, %loop.latch2 ]
  %t188 = phi double [ %t21, %block.entry ], [ %t183, %loop.latch2 ]
  store i1 %t184, i1* %l6
  store %Parser %t185, %Parser* %l2
  store double %t186, double* %l5
  store { %Token*, i64 }* %t187, { %Token*, i64 }** %l1
  store double %t188, double* %l3
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
  %t42 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t43 = load %Token, %Token* %l7
  %t44 = call { %Token*, i64 }* @append_token({ %Token*, i64 }* %t42, %Token %t43)
  store { %Token*, i64 }* %t44, { %Token*, i64 }** %l1
  %t45 = load %Token, %Token* %l7
  %t46 = alloca [2 x i8], align 1
  %t47 = getelementptr [2 x i8], [2 x i8]* %t46, i32 0, i32 0
  store i8 123, i8* %t47
  %t48 = getelementptr [2 x i8], [2 x i8]* %t46, i32 0, i32 1
  store i8 0, i8* %t48
  %t49 = getelementptr [2 x i8], [2 x i8]* %t46, i32 0, i32 0
  %t50 = call i1 @symbol_matches(%Token %t45, i8* %t49)
  %t51 = load %Parser, %Parser* %l0
  %t52 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t53 = load %Parser, %Parser* %l2
  %t54 = load double, double* %l3
  %t55 = load double, double* %l4
  %t56 = load double, double* %l5
  %t57 = load i1, i1* %l6
  %t58 = load %Token, %Token* %l7
  br i1 %t50, label %then6, label %else7
then6:
  %t59 = load double, double* %l3
  %t60 = sitofp i64 1 to double
  %t61 = fadd double %t59, %t60
  store double %t61, double* %l3
  %t62 = load double, double* %l3
  br label %merge8
else7:
  %t63 = load %Token, %Token* %l7
  %t64 = alloca [2 x i8], align 1
  %t65 = getelementptr [2 x i8], [2 x i8]* %t64, i32 0, i32 0
  store i8 125, i8* %t65
  %t66 = getelementptr [2 x i8], [2 x i8]* %t64, i32 0, i32 1
  store i8 0, i8* %t66
  %t67 = getelementptr [2 x i8], [2 x i8]* %t64, i32 0, i32 0
  %t68 = call i1 @symbol_matches(%Token %t63, i8* %t67)
  %t69 = load %Parser, %Parser* %l0
  %t70 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t71 = load %Parser, %Parser* %l2
  %t72 = load double, double* %l3
  %t73 = load double, double* %l4
  %t74 = load double, double* %l5
  %t75 = load i1, i1* %l6
  %t76 = load %Token, %Token* %l7
  br i1 %t68, label %then9, label %else10
then9:
  %t77 = load double, double* %l3
  %t78 = sitofp i64 0 to double
  %t79 = fcmp ogt double %t77, %t78
  %t80 = load %Parser, %Parser* %l0
  %t81 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t82 = load %Parser, %Parser* %l2
  %t83 = load double, double* %l3
  %t84 = load double, double* %l4
  %t85 = load double, double* %l5
  %t86 = load i1, i1* %l6
  %t87 = load %Token, %Token* %l7
  br i1 %t79, label %then12, label %merge13
then12:
  %t88 = load double, double* %l3
  %t89 = sitofp i64 1 to double
  %t90 = fsub double %t88, %t89
  store double %t90, double* %l3
  %t91 = load double, double* %l3
  br label %merge13
merge13:
  %t92 = phi double [ %t91, %then12 ], [ %t83, %then9 ]
  store double %t92, double* %l3
  %t93 = load double, double* %l3
  %t94 = sitofp i64 0 to double
  %t95 = fcmp oeq double %t93, %t94
  %t96 = load %Parser, %Parser* %l0
  %t97 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t98 = load %Parser, %Parser* %l2
  %t99 = load double, double* %l3
  %t100 = load double, double* %l4
  %t101 = load double, double* %l5
  %t102 = load i1, i1* %l6
  %t103 = load %Token, %Token* %l7
  br i1 %t95, label %then14, label %merge15
then14:
  %t104 = load %Parser, %Parser* %l2
  %t105 = call %Parser @parser_advance_raw(%Parser %t104)
  store %Parser %t105, %Parser* %l2
  br label %afterloop3
merge15:
  %t106 = load double, double* %l3
  %t107 = load %Parser, %Parser* %l2
  br label %merge11
else10:
  %t109 = load double, double* %l3
  %t110 = sitofp i64 0 to double
  %t111 = fcmp oeq double %t109, %t110
  br label %logical_and_entry_108

logical_and_entry_108:
  br i1 %t111, label %logical_and_right_108, label %logical_and_merge_108

logical_and_right_108:
  %t112 = load %Token, %Token* %l7
  %t113 = alloca [2 x i8], align 1
  %t114 = getelementptr [2 x i8], [2 x i8]* %t113, i32 0, i32 0
  store i8 59, i8* %t114
  %t115 = getelementptr [2 x i8], [2 x i8]* %t113, i32 0, i32 1
  store i8 0, i8* %t115
  %t116 = getelementptr [2 x i8], [2 x i8]* %t113, i32 0, i32 0
  %t117 = call i1 @symbol_matches(%Token %t112, i8* %t116)
  br label %logical_and_right_end_108

logical_and_right_end_108:
  br label %logical_and_merge_108

logical_and_merge_108:
  %t118 = phi i1 [ false, %logical_and_entry_108 ], [ %t117, %logical_and_right_end_108 ]
  %t119 = load %Parser, %Parser* %l0
  %t120 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t121 = load %Parser, %Parser* %l2
  %t122 = load double, double* %l3
  %t123 = load double, double* %l4
  %t124 = load double, double* %l5
  %t125 = load i1, i1* %l6
  %t126 = load %Token, %Token* %l7
  br i1 %t118, label %then16, label %merge17
then16:
  %t127 = load %Parser, %Parser* %l2
  %t128 = call %Parser @parser_advance_raw(%Parser %t127)
  store %Parser %t128, %Parser* %l2
  br label %afterloop3
merge17:
  %t129 = load %Parser, %Parser* %l2
  br label %merge11
merge11:
  %t130 = phi double [ %t106, %merge15 ], [ %t72, %merge17 ]
  %t131 = phi %Parser [ %t107, %merge15 ], [ %t129, %merge17 ]
  store double %t130, double* %l3
  store %Parser %t131, %Parser* %l2
  %t132 = load double, double* %l3
  %t133 = load %Parser, %Parser* %l2
  %t134 = load %Parser, %Parser* %l2
  br label %merge8
merge8:
  %t135 = phi double [ %t62, %then6 ], [ %t132, %merge11 ]
  %t136 = phi %Parser [ %t53, %then6 ], [ %t133, %merge11 ]
  store double %t135, double* %l3
  store %Parser %t136, %Parser* %l2
  %t137 = load %Token, %Token* %l7
  %t138 = extractvalue %Token %t137, 0
  %t139 = extractvalue %TokenKind %t138, 0
  %t140 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t141 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t142 = icmp eq i32 %t139, 0
  %t143 = select i1 %t142, i8* %t141, i8* %t140
  %t144 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t145 = icmp eq i32 %t139, 1
  %t146 = select i1 %t145, i8* %t144, i8* %t143
  %t147 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t148 = icmp eq i32 %t139, 2
  %t149 = select i1 %t148, i8* %t147, i8* %t146
  %t150 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t151 = icmp eq i32 %t139, 3
  %t152 = select i1 %t151, i8* %t150, i8* %t149
  %t153 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t154 = icmp eq i32 %t139, 4
  %t155 = select i1 %t154, i8* %t153, i8* %t152
  %t156 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t157 = icmp eq i32 %t139, 5
  %t158 = select i1 %t157, i8* %t156, i8* %t155
  %t159 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t160 = icmp eq i32 %t139, 6
  %t161 = select i1 %t160, i8* %t159, i8* %t158
  %t162 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t163 = icmp eq i32 %t139, 7
  %t164 = select i1 %t163, i8* %t162, i8* %t161
  %s165 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1021477046, i32 0, i32 0
  %t166 = icmp eq i8* %t164, %s165
  %t167 = load %Parser, %Parser* %l0
  %t168 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t169 = load %Parser, %Parser* %l2
  %t170 = load double, double* %l3
  %t171 = load double, double* %l4
  %t172 = load double, double* %l5
  %t173 = load i1, i1* %l6
  %t174 = load %Token, %Token* %l7
  br i1 %t166, label %then18, label %merge19
then18:
  %t175 = load %Parser, %Parser* %l2
  %t176 = call %Parser @parser_advance_raw(%Parser %t175)
  store %Parser %t176, %Parser* %l2
  br label %afterloop3
merge19:
  %t177 = load %Parser, %Parser* %l2
  %t178 = call %Parser @parser_advance_raw(%Parser %t177)
  store %Parser %t178, %Parser* %l2
  br label %loop.latch2
loop.latch2:
  %t179 = load i1, i1* %l6
  %t180 = load %Parser, %Parser* %l2
  %t181 = load double, double* %l5
  %t182 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t183 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t189 = load i1, i1* %l6
  %t190 = load %Parser, %Parser* %l2
  %t191 = load double, double* %l5
  %t192 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t193 = load double, double* %l3
  %t194 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t195 = call i8* @tokens_to_text({ %Token*, i64 }* %t194)
  store i8* %t195, i8** %l8
  %t196 = load i1, i1* %l6
  %t197 = load %Parser, %Parser* %l0
  %t198 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t199 = load %Parser, %Parser* %l2
  %t200 = load double, double* %l3
  %t201 = load double, double* %l4
  %t202 = load double, double* %l5
  %t203 = load i1, i1* %l6
  %t204 = load i8*, i8** %l8
  br i1 %t196, label %then20, label %merge21
then20:
  %t205 = load i8*, i8** %l8
  %s206 = getelementptr inbounds [31 x i8], [31 x i8]* @.str.len30.h1141851511, i32 0, i32 0
  %t207 = call i8* @sailfin_runtime_string_concat(i8* %t205, i8* %s206)
  store i8* %t207, i8** %l8
  %t208 = load i8*, i8** %l8
  br label %merge21
merge21:
  %t209 = phi i8* [ %t208, %then20 ], [ %t204, %afterloop3 ]
  store i8* %t209, i8** %l8
  %t210 = alloca %Statement
  %t211 = getelementptr inbounds %Statement, %Statement* %t210, i32 0, i32 0
  store i32 22, i32* %t211
  %t212 = load { %Token*, i64 }*, { %Token*, i64 }** %l1
  %t213 = bitcast { %Token*, i64 }* %t212 to { %Token**, i64 }*
  %t214 = getelementptr inbounds %Statement, %Statement* %t210, i32 0, i32 1
  %t215 = bitcast [16 x i8]* %t214 to i8*
  %t216 = bitcast i8* %t215 to { %Token**, i64 }**
  store { %Token**, i64 }* %t213, { %Token**, i64 }** %t216
  %t217 = load i8*, i8** %l8
  %t218 = getelementptr inbounds %Statement, %Statement* %t210, i32 0, i32 1
  %t219 = bitcast [16 x i8]* %t218 to i8*
  %t220 = getelementptr inbounds i8, i8* %t219, i64 8
  %t221 = bitcast i8* %t220 to i8**
  store i8* %t217, i8** %t221
  %t222 = load %Statement, %Statement* %t210
  store %Statement %t222, %Statement* %l9
  %t223 = load %Parser, %Parser* %l2
  %t224 = call %Parser @skip_trivia(%Parser %t223)
  store %Parser %t224, %Parser* %l0
  %t225 = load %Parser, %Parser* %l0
  %t226 = insertvalue %StatementParseResult undef, %Parser %t225, 0
  %t227 = load %Statement, %Statement* %l9
  %t228 = insertvalue %StatementParseResult %t226, %Statement %t227, 1
  ret %StatementParseResult %t228
}
