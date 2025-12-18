define %BlockParseResult @parse_block(%Parser %initial_parser) {
block.entry:
  %l0 = alloca %Parser
  %l1 = alloca %Token
  %l2 = alloca double
  %l3 = alloca %Parser
  %l4 = alloca double
  %l5 = alloca { %Statement*, i64 }*
  %l6 = alloca %Token
  %l7 = alloca %BlockStatementParseResult
  %l8 = alloca double
  %l9 = alloca %StatementParseResult
  %l10 = alloca double
  %l11 = alloca { %Token*, i64 }*
  %l12 = alloca i8*
  %l13 = alloca %Block
  store %Parser %initial_parser, %Parser* %l0
  %t0 = load %Parser, %Parser* %l0
  %t1 = call %Parser @skip_trivia(%Parser %t0)
  store %Parser %t1, %Parser* %l0
  %t2 = load %Parser, %Parser* %l0
  %t3 = call %Token @parser_peek_raw(%Parser %t2)
  store %Token %t3, %Token* %l1
  %t4 = load %Token, %Token* %l1
  %t5 = add i64 0, 2
  %t6 = call i8* @malloc(i64 %t5)
  store i8 123, i8* %t6
  %t7 = getelementptr i8, i8* %t6, i64 1
  store i8 0, i8* %t7
  call void @sailfin_runtime_mark_persistent(i8* %t6)
  %t8 = call i1 @symbol_matches(%Token %t4, i8* %t6)
  %t9 = xor i1 %t8, 1
  %t10 = load %Parser, %Parser* %l0
  %t11 = load %Token, %Token* %l1
  br i1 %t9, label %then0, label %merge1
then0:
  %t12 = load %Parser, %Parser* %l0
  %t13 = insertvalue %BlockParseResult undef, %Parser %t12, 0
  %t14 = getelementptr [0 x %Token], [0 x %Token]* null, i32 1
  %t15 = ptrtoint [0 x %Token]* %t14 to i64
  %t16 = icmp eq i64 %t15, 0
  %t17 = select i1 %t16, i64 1, i64 %t15
  %t18 = call i8* @malloc(i64 %t17)
  %t19 = bitcast i8* %t18 to %Token*
  %t20 = getelementptr { %Token*, i64 }, { %Token*, i64 }* null, i32 1
  %t21 = ptrtoint { %Token*, i64 }* %t20 to i64
  %t22 = call i8* @malloc(i64 %t21)
  %t23 = bitcast i8* %t22 to { %Token*, i64 }*
  %t24 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t23, i32 0, i32 0
  store %Token* %t19, %Token** %t24
  %t25 = getelementptr { %Token*, i64 }, { %Token*, i64 }* %t23, i32 0, i32 1
  store i64 0, i64* %t25
  %t26 = insertvalue %Block undef, { %Token*, i64 }* %t23, 0
  %s27 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t28 = insertvalue %Block %t26, i8* %s27, 1
  %t29 = getelementptr [0 x %Statement], [0 x %Statement]* null, i32 1
  %t30 = ptrtoint [0 x %Statement]* %t29 to i64
  %t31 = icmp eq i64 %t30, 0
  %t32 = select i1 %t31, i64 1, i64 %t30
  %t33 = call i8* @malloc(i64 %t32)
  %t34 = bitcast i8* %t33 to %Statement*
  %t35 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* null, i32 1
  %t36 = ptrtoint { %Statement*, i64 }* %t35 to i64
  %t37 = call i8* @malloc(i64 %t36)
  %t38 = bitcast i8* %t37 to { %Statement*, i64 }*
  %t39 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t38, i32 0, i32 0
  store %Statement* %t34, %Statement** %t39
  %t40 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t38, i32 0, i32 1
  store i64 0, i64* %t40
  %t41 = insertvalue %Block %t28, { %Statement*, i64 }* %t38, 2
  %t42 = insertvalue %BlockParseResult %t13, %Block %t41, 1
  ret %BlockParseResult %t42
merge1:
  %t43 = load %Parser, %Parser* %l0
  %t44 = extractvalue %Parser %t43, 1
  store double %t44, double* %l2
  %t45 = load %Parser, %Parser* %l0
  %t46 = call %Parser @parser_advance_raw(%Parser %t45)
  store %Parser %t46, %Parser* %l3
  %t47 = load double, double* %l2
  store double %t47, double* %l4
  %t48 = getelementptr [0 x %Statement], [0 x %Statement]* null, i32 1
  %t49 = ptrtoint [0 x %Statement]* %t48 to i64
  %t50 = icmp eq i64 %t49, 0
  %t51 = select i1 %t50, i64 1, i64 %t49
  %t52 = call i8* @malloc(i64 %t51)
  %t53 = bitcast i8* %t52 to %Statement*
  %t54 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* null, i32 1
  %t55 = ptrtoint { %Statement*, i64 }* %t54 to i64
  %t56 = call i8* @malloc(i64 %t55)
  %t57 = bitcast i8* %t56 to { %Statement*, i64 }*
  %t58 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t57, i32 0, i32 0
  store %Statement* %t53, %Statement** %t58
  %t59 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t57, i32 0, i32 1
  store i64 0, i64* %t59
  store { %Statement*, i64 }* %t57, { %Statement*, i64 }** %l5
  %t60 = load %Parser, %Parser* %l0
  %t61 = load %Token, %Token* %l1
  %t62 = load double, double* %l2
  %t63 = load %Parser, %Parser* %l3
  %t64 = load double, double* %l4
  %t65 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l5
  br label %loop.header2
loop.header2:
  %t275 = phi %Parser [ %t63, %merge1 ], [ %t272, %loop.latch4 ]
  %t276 = phi double [ %t64, %merge1 ], [ %t273, %loop.latch4 ]
  %t277 = phi { %Statement*, i64 }* [ %t65, %merge1 ], [ %t274, %loop.latch4 ]
  store %Parser %t275, %Parser* %l3
  store double %t276, double* %l4
  store { %Statement*, i64 }* %t277, { %Statement*, i64 }** %l5
  br label %loop.body3
loop.body3:
  %t66 = load %Parser, %Parser* %l3
  %t67 = call %Parser @skip_trivia(%Parser %t66)
  store %Parser %t67, %Parser* %l3
  %t68 = load %Parser, %Parser* %l3
  %t69 = call %Token @parser_peek_raw(%Parser %t68)
  store %Token %t69, %Token* %l6
  %t70 = load %Token, %Token* %l6
  %t71 = add i64 0, 2
  %t72 = call i8* @malloc(i64 %t71)
  store i8 125, i8* %t72
  %t73 = getelementptr i8, i8* %t72, i64 1
  store i8 0, i8* %t73
  call void @sailfin_runtime_mark_persistent(i8* %t72)
  %t74 = call i1 @symbol_matches(%Token %t70, i8* %t72)
  %t75 = load %Parser, %Parser* %l0
  %t76 = load %Token, %Token* %l1
  %t77 = load double, double* %l2
  %t78 = load %Parser, %Parser* %l3
  %t79 = load double, double* %l4
  %t80 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l5
  %t81 = load %Token, %Token* %l6
  br i1 %t74, label %then6, label %merge7
then6:
  %t82 = load %Parser, %Parser* %l3
  %t83 = extractvalue %Parser %t82, 1
  %t84 = sitofp i64 1 to double
  %t85 = fadd double %t83, %t84
  store double %t85, double* %l4
  %t86 = load %Parser, %Parser* %l3
  %t87 = call %Parser @parser_advance_raw(%Parser %t86)
  store %Parser %t87, %Parser* %l3
  br label %afterloop5
merge7:
  %t88 = load %Token, %Token* %l6
  %t89 = extractvalue %Token %t88, 0
  %t90 = extractvalue %TokenKind %t89, 0
  %t91 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t92 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t93 = icmp eq i32 %t90, 0
  %t94 = select i1 %t93, i8* %t92, i8* %t91
  %t95 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t96 = icmp eq i32 %t90, 1
  %t97 = select i1 %t96, i8* %t95, i8* %t94
  %t98 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t99 = icmp eq i32 %t90, 2
  %t100 = select i1 %t99, i8* %t98, i8* %t97
  %t101 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t102 = icmp eq i32 %t90, 3
  %t103 = select i1 %t102, i8* %t101, i8* %t100
  %t104 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t105 = icmp eq i32 %t90, 4
  %t106 = select i1 %t105, i8* %t104, i8* %t103
  %t107 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t108 = icmp eq i32 %t90, 5
  %t109 = select i1 %t108, i8* %t107, i8* %t106
  %t110 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t111 = icmp eq i32 %t90, 6
  %t112 = select i1 %t111, i8* %t110, i8* %t109
  %t113 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t114 = icmp eq i32 %t90, 7
  %t115 = select i1 %t114, i8* %t113, i8* %t112
  %s116 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1021477046, i32 0, i32 0
  %t117 = call i1 @strings_equal(i8* %t115, i8* %s116)
  %t118 = load %Parser, %Parser* %l0
  %t119 = load %Token, %Token* %l1
  %t120 = load double, double* %l2
  %t121 = load %Parser, %Parser* %l3
  %t122 = load double, double* %l4
  %t123 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l5
  %t124 = load %Token, %Token* %l6
  br i1 %t117, label %then8, label %merge9
then8:
  br label %afterloop5
merge9:
  %t125 = load %Parser, %Parser* %l3
  %t126 = call %BlockStatementParseResult @parse_block_statement(%Parser %t125)
  store %BlockStatementParseResult %t126, %BlockStatementParseResult* %l7
  %t127 = load %BlockStatementParseResult, %BlockStatementParseResult* %l7
  %t128 = extractvalue %BlockStatementParseResult %t127, 2
  %t129 = load %Parser, %Parser* %l0
  %t130 = load %Token, %Token* %l1
  %t131 = load double, double* %l2
  %t132 = load %Parser, %Parser* %l3
  %t133 = load double, double* %l4
  %t134 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l5
  %t135 = load %Token, %Token* %l6
  %t136 = load %BlockStatementParseResult, %BlockStatementParseResult* %l7
  br i1 %t128, label %then10, label %merge11
then10:
  %t137 = load %BlockStatementParseResult, %BlockStatementParseResult* %l7
  %t138 = extractvalue %BlockStatementParseResult %t137, 0
  store %Parser %t138, %Parser* %l3
  %t139 = load %BlockStatementParseResult, %BlockStatementParseResult* %l7
  %t140 = extractvalue %BlockStatementParseResult %t139, 1
  %t141 = icmp ne %Statement* %t140, null
  %t142 = load %Parser, %Parser* %l0
  %t143 = load %Token, %Token* %l1
  %t144 = load double, double* %l2
  %t145 = load %Parser, %Parser* %l3
  %t146 = load double, double* %l4
  %t147 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l5
  %t148 = load %Token, %Token* %l6
  %t149 = load %BlockStatementParseResult, %BlockStatementParseResult* %l7
  br i1 %t141, label %then12, label %merge13
then12:
  %t150 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l5
  %t151 = load %BlockStatementParseResult, %BlockStatementParseResult* %l7
  %t152 = extractvalue %BlockStatementParseResult %t151, 1
  %t153 = load %Statement, %Statement* %t152
  %t154 = call { %Statement*, i64 }* @append_statement({ %Statement*, i64 }* %t150, %Statement %t153)
  store { %Statement*, i64 }* %t154, { %Statement*, i64 }** %l5
  %t155 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l5
  br label %merge13
merge13:
  %t156 = phi { %Statement*, i64 }* [ %t155, %then12 ], [ %t147, %then10 ]
  store { %Statement*, i64 }* %t156, { %Statement*, i64 }** %l5
  br label %loop.latch4
merge11:
  %t157 = load %Parser, %Parser* %l3
  %t158 = extractvalue %Parser %t157, 1
  store double %t158, double* %l8
  %t159 = load %Parser, %Parser* %l3
  %t160 = call %StatementParseResult @parse_unknown(%Parser %t159)
  store %StatementParseResult %t160, %StatementParseResult* %l9
  %t161 = load %StatementParseResult, %StatementParseResult* %l9
  %t162 = extractvalue %StatementParseResult %t161, 0
  store %Parser %t162, %Parser* %l3
  %t163 = load %StatementParseResult, %StatementParseResult* %l9
  %t164 = extractvalue %StatementParseResult %t163, 1
  %t165 = extractvalue %Statement %t164, 0
  %t166 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t167 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t168 = icmp eq i32 %t165, 0
  %t169 = select i1 %t168, i8* %t167, i8* %t166
  %t170 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t171 = icmp eq i32 %t165, 1
  %t172 = select i1 %t171, i8* %t170, i8* %t169
  %t173 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t174 = icmp eq i32 %t165, 2
  %t175 = select i1 %t174, i8* %t173, i8* %t172
  %t176 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t177 = icmp eq i32 %t165, 3
  %t178 = select i1 %t177, i8* %t176, i8* %t175
  %t179 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t180 = icmp eq i32 %t165, 4
  %t181 = select i1 %t180, i8* %t179, i8* %t178
  %t182 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t183 = icmp eq i32 %t165, 5
  %t184 = select i1 %t183, i8* %t182, i8* %t181
  %t185 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t186 = icmp eq i32 %t165, 6
  %t187 = select i1 %t186, i8* %t185, i8* %t184
  %t188 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t189 = icmp eq i32 %t165, 7
  %t190 = select i1 %t189, i8* %t188, i8* %t187
  %t191 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t192 = icmp eq i32 %t165, 8
  %t193 = select i1 %t192, i8* %t191, i8* %t190
  %t194 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t195 = icmp eq i32 %t165, 9
  %t196 = select i1 %t195, i8* %t194, i8* %t193
  %t197 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t198 = icmp eq i32 %t165, 10
  %t199 = select i1 %t198, i8* %t197, i8* %t196
  %t200 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t201 = icmp eq i32 %t165, 11
  %t202 = select i1 %t201, i8* %t200, i8* %t199
  %t203 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t204 = icmp eq i32 %t165, 12
  %t205 = select i1 %t204, i8* %t203, i8* %t202
  %t206 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t207 = icmp eq i32 %t165, 13
  %t208 = select i1 %t207, i8* %t206, i8* %t205
  %t209 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t210 = icmp eq i32 %t165, 14
  %t211 = select i1 %t210, i8* %t209, i8* %t208
  %t212 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t213 = icmp eq i32 %t165, 15
  %t214 = select i1 %t213, i8* %t212, i8* %t211
  %t215 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t216 = icmp eq i32 %t165, 16
  %t217 = select i1 %t216, i8* %t215, i8* %t214
  %t218 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t219 = icmp eq i32 %t165, 17
  %t220 = select i1 %t219, i8* %t218, i8* %t217
  %t221 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t222 = icmp eq i32 %t165, 18
  %t223 = select i1 %t222, i8* %t221, i8* %t220
  %t224 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t225 = icmp eq i32 %t165, 19
  %t226 = select i1 %t225, i8* %t224, i8* %t223
  %t227 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t228 = icmp eq i32 %t165, 20
  %t229 = select i1 %t228, i8* %t227, i8* %t226
  %t230 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t231 = icmp eq i32 %t165, 21
  %t232 = select i1 %t231, i8* %t230, i8* %t229
  %t233 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t234 = icmp eq i32 %t165, 22
  %t235 = select i1 %t234, i8* %t233, i8* %t232
  %s236 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h48777630, i32 0, i32 0
  %t237 = call i1 @strings_equal(i8* %t235, i8* %s236)
  %t238 = load %Parser, %Parser* %l0
  %t239 = load %Token, %Token* %l1
  %t240 = load double, double* %l2
  %t241 = load %Parser, %Parser* %l3
  %t242 = load double, double* %l4
  %t243 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l5
  %t244 = load %Token, %Token* %l6
  %t245 = load %BlockStatementParseResult, %BlockStatementParseResult* %l7
  %t246 = load double, double* %l8
  %t247 = load %StatementParseResult, %StatementParseResult* %l9
  br i1 %t237, label %then14, label %merge15
then14:
  %t248 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l5
  %t249 = load %StatementParseResult, %StatementParseResult* %l9
  %t250 = extractvalue %StatementParseResult %t249, 1
  %t251 = call { %Statement*, i64 }* @append_statement({ %Statement*, i64 }* %t248, %Statement %t250)
  store { %Statement*, i64 }* %t251, { %Statement*, i64 }** %l5
  %t252 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l5
  br label %merge15
merge15:
  %t253 = phi { %Statement*, i64 }* [ %t252, %then14 ], [ %t243, %merge11 ]
  store { %Statement*, i64 }* %t253, { %Statement*, i64 }** %l5
  %t254 = load %Parser, %Parser* %l3
  %t255 = extractvalue %Parser %t254, 1
  %t256 = load double, double* %l8
  %t257 = fcmp ole double %t255, %t256
  %t258 = load %Parser, %Parser* %l0
  %t259 = load %Token, %Token* %l1
  %t260 = load double, double* %l2
  %t261 = load %Parser, %Parser* %l3
  %t262 = load double, double* %l4
  %t263 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l5
  %t264 = load %Token, %Token* %l6
  %t265 = load %BlockStatementParseResult, %BlockStatementParseResult* %l7
  %t266 = load double, double* %l8
  %t267 = load %StatementParseResult, %StatementParseResult* %l9
  br i1 %t257, label %then16, label %merge17
then16:
  %t268 = load %Parser, %Parser* %l3
  %t269 = call %Parser @parser_advance_raw(%Parser %t268)
  store %Parser %t269, %Parser* %l3
  %t270 = load %Parser, %Parser* %l3
  br label %merge17
merge17:
  %t271 = phi %Parser [ %t270, %then16 ], [ %t261, %merge15 ]
  store %Parser %t271, %Parser* %l3
  br label %loop.latch4
loop.latch4:
  %t272 = load %Parser, %Parser* %l3
  %t273 = load double, double* %l4
  %t274 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l5
  br label %loop.header2
afterloop5:
  %t278 = load %Parser, %Parser* %l3
  %t279 = load double, double* %l4
  %t280 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l5
  %t281 = load %Parser, %Parser* %l3
  %t282 = extractvalue %Parser %t281, 1
  store double %t282, double* %l10
  %t283 = load double, double* %l4
  %t284 = load double, double* %l2
  %t285 = fcmp ogt double %t283, %t284
  %t286 = load %Parser, %Parser* %l0
  %t287 = load %Token, %Token* %l1
  %t288 = load double, double* %l2
  %t289 = load %Parser, %Parser* %l3
  %t290 = load double, double* %l4
  %t291 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l5
  %t292 = load double, double* %l10
  br i1 %t285, label %then18, label %merge19
then18:
  %t293 = load double, double* %l4
  store double %t293, double* %l10
  %t294 = load double, double* %l10
  br label %merge19
merge19:
  %t295 = phi double [ %t294, %then18 ], [ %t292, %afterloop5 ]
  store double %t295, double* %l10
  %t296 = load %Parser, %Parser* %l0
  %t297 = extractvalue %Parser %t296, 0
  %t298 = load double, double* %l2
  %t299 = load double, double* %l10
  %t300 = call { %Token*, i64 }* @token_slice({ %Token*, i64 }* %t297, double %t298, double %t299)
  store { %Token*, i64 }* %t300, { %Token*, i64 }** %l11
  %t301 = load { %Token*, i64 }*, { %Token*, i64 }** %l11
  %t302 = call { %Token*, i64 }* @trim_block_tokens({ %Token*, i64 }* %t301)
  store { %Token*, i64 }* %t302, { %Token*, i64 }** %l11
  %t303 = load { %Token*, i64 }*, { %Token*, i64 }** %l11
  %t304 = call i8* @tokens_to_text({ %Token*, i64 }* %t303)
  store i8* %t304, i8** %l12
  %t305 = load { %Token*, i64 }*, { %Token*, i64 }** %l11
  %t306 = insertvalue %Block undef, { %Token*, i64 }* %t305, 0
  %t307 = load i8*, i8** %l12
  %t308 = insertvalue %Block %t306, i8* %t307, 1
  %t309 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l5
  %t310 = insertvalue %Block %t308, { %Statement*, i64 }* %t309, 2
  store %Block %t310, %Block* %l13
  %t311 = load %Parser, %Parser* %l3
  %t312 = call %Parser @skip_trivia(%Parser %t311)
  %t313 = insertvalue %BlockParseResult undef, %Parser %t312, 0
  %t314 = load %Block, %Block* %l13
  %t315 = insertvalue %BlockParseResult %t313, %Block %t314, 1
  ret %BlockParseResult %t315
}
