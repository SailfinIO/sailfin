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
  %t5 = alloca [2 x i8], align 1
  %t6 = getelementptr [2 x i8], [2 x i8]* %t5, i32 0, i32 0
  store i8 123, i8* %t6
  %t7 = getelementptr [2 x i8], [2 x i8]* %t5, i32 0, i32 1
  store i8 0, i8* %t7
  %t8 = getelementptr [2 x i8], [2 x i8]* %t5, i32 0, i32 0
  %t9 = call i1 @symbol_matches(%Token %t4, i8* %t8)
  %t10 = xor i1 %t9, 1
  %t11 = load %Parser, %Parser* %l0
  %t12 = load %Token, %Token* %l1
  br i1 %t10, label %then0, label %merge1
then0:
  %t13 = load %Parser, %Parser* %l0
  %t14 = insertvalue %BlockParseResult undef, %Parser %t13, 0
  %t15 = getelementptr [0 x %Token*], [0 x %Token*]* null, i32 1
  %t16 = ptrtoint [0 x %Token*]* %t15 to i64
  %t17 = icmp eq i64 %t16, 0
  %t18 = select i1 %t17, i64 1, i64 %t16
  %t19 = call i8* @malloc(i64 %t18)
  %t20 = bitcast i8* %t19 to %Token**
  %t21 = getelementptr { %Token**, i64 }, { %Token**, i64 }* null, i32 1
  %t22 = ptrtoint { %Token**, i64 }* %t21 to i64
  %t23 = call i8* @malloc(i64 %t22)
  %t24 = bitcast i8* %t23 to { %Token**, i64 }*
  %t25 = getelementptr { %Token**, i64 }, { %Token**, i64 }* %t24, i32 0, i32 0
  store %Token** %t20, %Token*** %t25
  %t26 = getelementptr { %Token**, i64 }, { %Token**, i64 }* %t24, i32 0, i32 1
  store i64 0, i64* %t26
  %t27 = insertvalue %Block undef, { %Token**, i64 }* %t24, 0
  %s28 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t29 = insertvalue %Block %t27, i8* %s28, 1
  %t30 = getelementptr [0 x %Statement*], [0 x %Statement*]* null, i32 1
  %t31 = ptrtoint [0 x %Statement*]* %t30 to i64
  %t32 = icmp eq i64 %t31, 0
  %t33 = select i1 %t32, i64 1, i64 %t31
  %t34 = call i8* @malloc(i64 %t33)
  %t35 = bitcast i8* %t34 to %Statement**
  %t36 = getelementptr { %Statement**, i64 }, { %Statement**, i64 }* null, i32 1
  %t37 = ptrtoint { %Statement**, i64 }* %t36 to i64
  %t38 = call i8* @malloc(i64 %t37)
  %t39 = bitcast i8* %t38 to { %Statement**, i64 }*
  %t40 = getelementptr { %Statement**, i64 }, { %Statement**, i64 }* %t39, i32 0, i32 0
  store %Statement** %t35, %Statement*** %t40
  %t41 = getelementptr { %Statement**, i64 }, { %Statement**, i64 }* %t39, i32 0, i32 1
  store i64 0, i64* %t41
  %t42 = insertvalue %Block %t29, { %Statement**, i64 }* %t39, 2
  %t43 = insertvalue %BlockParseResult %t14, %Block %t42, 1
  ret %BlockParseResult %t43
merge1:
  %t44 = load %Parser, %Parser* %l0
  %t45 = extractvalue %Parser %t44, 1
  store double %t45, double* %l2
  %t46 = load %Parser, %Parser* %l0
  %t47 = call %Parser @parser_advance_raw(%Parser %t46)
  store %Parser %t47, %Parser* %l3
  %t48 = load double, double* %l2
  store double %t48, double* %l4
  %t49 = getelementptr [0 x %Statement], [0 x %Statement]* null, i32 1
  %t50 = ptrtoint [0 x %Statement]* %t49 to i64
  %t51 = icmp eq i64 %t50, 0
  %t52 = select i1 %t51, i64 1, i64 %t50
  %t53 = call i8* @malloc(i64 %t52)
  %t54 = bitcast i8* %t53 to %Statement*
  %t55 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* null, i32 1
  %t56 = ptrtoint { %Statement*, i64 }* %t55 to i64
  %t57 = call i8* @malloc(i64 %t56)
  %t58 = bitcast i8* %t57 to { %Statement*, i64 }*
  %t59 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t58, i32 0, i32 0
  store %Statement* %t54, %Statement** %t59
  %t60 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t58, i32 0, i32 1
  store i64 0, i64* %t60
  store { %Statement*, i64 }* %t58, { %Statement*, i64 }** %l5
  %t61 = load %Parser, %Parser* %l0
  %t62 = load %Token, %Token* %l1
  %t63 = load double, double* %l2
  %t64 = load %Parser, %Parser* %l3
  %t65 = load double, double* %l4
  %t66 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l5
  br label %loop.header2
loop.header2:
  %t277 = phi %Parser [ %t64, %merge1 ], [ %t274, %loop.latch4 ]
  %t278 = phi double [ %t65, %merge1 ], [ %t275, %loop.latch4 ]
  %t279 = phi { %Statement*, i64 }* [ %t66, %merge1 ], [ %t276, %loop.latch4 ]
  store %Parser %t277, %Parser* %l3
  store double %t278, double* %l4
  store { %Statement*, i64 }* %t279, { %Statement*, i64 }** %l5
  br label %loop.body3
loop.body3:
  %t67 = load %Parser, %Parser* %l3
  %t68 = call %Parser @skip_trivia(%Parser %t67)
  store %Parser %t68, %Parser* %l3
  %t69 = load %Parser, %Parser* %l3
  %t70 = call %Token @parser_peek_raw(%Parser %t69)
  store %Token %t70, %Token* %l6
  %t71 = load %Token, %Token* %l6
  %t72 = alloca [2 x i8], align 1
  %t73 = getelementptr [2 x i8], [2 x i8]* %t72, i32 0, i32 0
  store i8 125, i8* %t73
  %t74 = getelementptr [2 x i8], [2 x i8]* %t72, i32 0, i32 1
  store i8 0, i8* %t74
  %t75 = getelementptr [2 x i8], [2 x i8]* %t72, i32 0, i32 0
  %t76 = call i1 @symbol_matches(%Token %t71, i8* %t75)
  %t77 = load %Parser, %Parser* %l0
  %t78 = load %Token, %Token* %l1
  %t79 = load double, double* %l2
  %t80 = load %Parser, %Parser* %l3
  %t81 = load double, double* %l4
  %t82 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l5
  %t83 = load %Token, %Token* %l6
  br i1 %t76, label %then6, label %merge7
then6:
  %t84 = load %Parser, %Parser* %l3
  %t85 = extractvalue %Parser %t84, 1
  %t86 = sitofp i64 1 to double
  %t87 = fadd double %t85, %t86
  store double %t87, double* %l4
  %t88 = load %Parser, %Parser* %l3
  %t89 = call %Parser @parser_advance_raw(%Parser %t88)
  store %Parser %t89, %Parser* %l3
  br label %afterloop5
merge7:
  %t90 = load %Token, %Token* %l6
  %t91 = extractvalue %Token %t90, 0
  %t92 = extractvalue %TokenKind %t91, 0
  %t93 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t94 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t95 = icmp eq i32 %t92, 0
  %t96 = select i1 %t95, i8* %t94, i8* %t93
  %t97 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t98 = icmp eq i32 %t92, 1
  %t99 = select i1 %t98, i8* %t97, i8* %t96
  %t100 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t101 = icmp eq i32 %t92, 2
  %t102 = select i1 %t101, i8* %t100, i8* %t99
  %t103 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t104 = icmp eq i32 %t92, 3
  %t105 = select i1 %t104, i8* %t103, i8* %t102
  %t106 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t107 = icmp eq i32 %t92, 4
  %t108 = select i1 %t107, i8* %t106, i8* %t105
  %t109 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t110 = icmp eq i32 %t92, 5
  %t111 = select i1 %t110, i8* %t109, i8* %t108
  %t112 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t113 = icmp eq i32 %t92, 6
  %t114 = select i1 %t113, i8* %t112, i8* %t111
  %t115 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t116 = icmp eq i32 %t92, 7
  %t117 = select i1 %t116, i8* %t115, i8* %t114
  %s118 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1021477046, i32 0, i32 0
  %t119 = icmp eq i8* %t117, %s118
  %t120 = load %Parser, %Parser* %l0
  %t121 = load %Token, %Token* %l1
  %t122 = load double, double* %l2
  %t123 = load %Parser, %Parser* %l3
  %t124 = load double, double* %l4
  %t125 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l5
  %t126 = load %Token, %Token* %l6
  br i1 %t119, label %then8, label %merge9
then8:
  br label %afterloop5
merge9:
  %t127 = load %Parser, %Parser* %l3
  %t128 = call %BlockStatementParseResult @parse_block_statement(%Parser %t127)
  store %BlockStatementParseResult %t128, %BlockStatementParseResult* %l7
  %t129 = load %BlockStatementParseResult, %BlockStatementParseResult* %l7
  %t130 = extractvalue %BlockStatementParseResult %t129, 2
  %t131 = load %Parser, %Parser* %l0
  %t132 = load %Token, %Token* %l1
  %t133 = load double, double* %l2
  %t134 = load %Parser, %Parser* %l3
  %t135 = load double, double* %l4
  %t136 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l5
  %t137 = load %Token, %Token* %l6
  %t138 = load %BlockStatementParseResult, %BlockStatementParseResult* %l7
  br i1 %t130, label %then10, label %merge11
then10:
  %t139 = load %BlockStatementParseResult, %BlockStatementParseResult* %l7
  %t140 = extractvalue %BlockStatementParseResult %t139, 0
  store %Parser %t140, %Parser* %l3
  %t141 = load %BlockStatementParseResult, %BlockStatementParseResult* %l7
  %t142 = extractvalue %BlockStatementParseResult %t141, 1
  %t143 = icmp ne %Statement* %t142, null
  %t144 = load %Parser, %Parser* %l0
  %t145 = load %Token, %Token* %l1
  %t146 = load double, double* %l2
  %t147 = load %Parser, %Parser* %l3
  %t148 = load double, double* %l4
  %t149 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l5
  %t150 = load %Token, %Token* %l6
  %t151 = load %BlockStatementParseResult, %BlockStatementParseResult* %l7
  br i1 %t143, label %then12, label %merge13
then12:
  %t152 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l5
  %t153 = load %BlockStatementParseResult, %BlockStatementParseResult* %l7
  %t154 = extractvalue %BlockStatementParseResult %t153, 1
  %t155 = load %Statement, %Statement* %t154
  %t156 = call { %Statement*, i64 }* @append_statement({ %Statement*, i64 }* %t152, %Statement %t155)
  store { %Statement*, i64 }* %t156, { %Statement*, i64 }** %l5
  %t157 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l5
  br label %merge13
merge13:
  %t158 = phi { %Statement*, i64 }* [ %t157, %then12 ], [ %t149, %then10 ]
  store { %Statement*, i64 }* %t158, { %Statement*, i64 }** %l5
  br label %loop.latch4
merge11:
  %t159 = load %Parser, %Parser* %l3
  %t160 = extractvalue %Parser %t159, 1
  store double %t160, double* %l8
  %t161 = load %Parser, %Parser* %l3
  %t162 = call %StatementParseResult @parse_unknown(%Parser %t161)
  store %StatementParseResult %t162, %StatementParseResult* %l9
  %t163 = load %StatementParseResult, %StatementParseResult* %l9
  %t164 = extractvalue %StatementParseResult %t163, 0
  store %Parser %t164, %Parser* %l3
  %t165 = load %StatementParseResult, %StatementParseResult* %l9
  %t166 = extractvalue %StatementParseResult %t165, 1
  %t167 = extractvalue %Statement %t166, 0
  %t168 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.Statement.variant.default, i32 0, i32 0
  %t169 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ImportDeclaration.variant, i32 0, i32 0
  %t170 = icmp eq i32 %t167, 0
  %t171 = select i1 %t170, i8* %t169, i8* %t168
  %t172 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ExportDeclaration.variant, i32 0, i32 0
  %t173 = icmp eq i32 %t167, 1
  %t174 = select i1 %t173, i8* %t172, i8* %t171
  %t175 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.VariableDeclaration.variant, i32 0, i32 0
  %t176 = icmp eq i32 %t167, 2
  %t177 = select i1 %t176, i8* %t175, i8* %t174
  %t178 = getelementptr inbounds [17 x i8], [17 x i8]* @.enum.Statement.ModelDeclaration.variant, i32 0, i32 0
  %t179 = icmp eq i32 %t167, 3
  %t180 = select i1 %t179, i8* %t178, i8* %t177
  %t181 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.PipelineDeclaration.variant, i32 0, i32 0
  %t182 = icmp eq i32 %t167, 4
  %t183 = select i1 %t182, i8* %t181, i8* %t180
  %t184 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ToolDeclaration.variant, i32 0, i32 0
  %t185 = icmp eq i32 %t167, 5
  %t186 = select i1 %t185, i8* %t184, i8* %t183
  %t187 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.TestDeclaration.variant, i32 0, i32 0
  %t188 = icmp eq i32 %t167, 6
  %t189 = select i1 %t188, i8* %t187, i8* %t186
  %t190 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.FunctionDeclaration.variant, i32 0, i32 0
  %t191 = icmp eq i32 %t167, 7
  %t192 = select i1 %t191, i8* %t190, i8* %t189
  %t193 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.StructDeclaration.variant, i32 0, i32 0
  %t194 = icmp eq i32 %t167, 8
  %t195 = select i1 %t194, i8* %t193, i8* %t192
  %t196 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.TypeAliasDeclaration.variant, i32 0, i32 0
  %t197 = icmp eq i32 %t167, 9
  %t198 = select i1 %t197, i8* %t196, i8* %t195
  %t199 = getelementptr inbounds [21 x i8], [21 x i8]* @.enum.Statement.InterfaceDeclaration.variant, i32 0, i32 0
  %t200 = icmp eq i32 %t167, 10
  %t201 = select i1 %t200, i8* %t199, i8* %t198
  %t202 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.EnumDeclaration.variant, i32 0, i32 0
  %t203 = icmp eq i32 %t167, 11
  %t204 = select i1 %t203, i8* %t202, i8* %t201
  %t205 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.PromptStatement.variant, i32 0, i32 0
  %t206 = icmp eq i32 %t167, 12
  %t207 = select i1 %t206, i8* %t205, i8* %t204
  %t208 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.WithStatement.variant, i32 0, i32 0
  %t209 = icmp eq i32 %t167, 13
  %t210 = select i1 %t209, i8* %t208, i8* %t207
  %t211 = getelementptr inbounds [13 x i8], [13 x i8]* @.enum.Statement.ForStatement.variant, i32 0, i32 0
  %t212 = icmp eq i32 %t167, 14
  %t213 = select i1 %t212, i8* %t211, i8* %t210
  %t214 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.Statement.LoopStatement.variant, i32 0, i32 0
  %t215 = icmp eq i32 %t167, 15
  %t216 = select i1 %t215, i8* %t214, i8* %t213
  %t217 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.BreakStatement.variant, i32 0, i32 0
  %t218 = icmp eq i32 %t167, 16
  %t219 = select i1 %t218, i8* %t217, i8* %t216
  %t220 = getelementptr inbounds [18 x i8], [18 x i8]* @.enum.Statement.ContinueStatement.variant, i32 0, i32 0
  %t221 = icmp eq i32 %t167, 17
  %t222 = select i1 %t221, i8* %t220, i8* %t219
  %t223 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.Statement.MatchStatement.variant, i32 0, i32 0
  %t224 = icmp eq i32 %t167, 18
  %t225 = select i1 %t224, i8* %t223, i8* %t222
  %t226 = getelementptr inbounds [12 x i8], [12 x i8]* @.enum.Statement.IfStatement.variant, i32 0, i32 0
  %t227 = icmp eq i32 %t167, 19
  %t228 = select i1 %t227, i8* %t226, i8* %t225
  %t229 = getelementptr inbounds [16 x i8], [16 x i8]* @.enum.Statement.ReturnStatement.variant, i32 0, i32 0
  %t230 = icmp eq i32 %t167, 20
  %t231 = select i1 %t230, i8* %t229, i8* %t228
  %t232 = getelementptr inbounds [20 x i8], [20 x i8]* @.enum.Statement.ExpressionStatement.variant, i32 0, i32 0
  %t233 = icmp eq i32 %t167, 21
  %t234 = select i1 %t233, i8* %t232, i8* %t231
  %t235 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.Statement.Unknown.variant, i32 0, i32 0
  %t236 = icmp eq i32 %t167, 22
  %t237 = select i1 %t236, i8* %t235, i8* %t234
  %s238 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h48777630, i32 0, i32 0
  %t239 = icmp eq i8* %t237, %s238
  %t240 = load %Parser, %Parser* %l0
  %t241 = load %Token, %Token* %l1
  %t242 = load double, double* %l2
  %t243 = load %Parser, %Parser* %l3
  %t244 = load double, double* %l4
  %t245 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l5
  %t246 = load %Token, %Token* %l6
  %t247 = load %BlockStatementParseResult, %BlockStatementParseResult* %l7
  %t248 = load double, double* %l8
  %t249 = load %StatementParseResult, %StatementParseResult* %l9
  br i1 %t239, label %then14, label %merge15
then14:
  %t250 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l5
  %t251 = load %StatementParseResult, %StatementParseResult* %l9
  %t252 = extractvalue %StatementParseResult %t251, 1
  %t253 = call { %Statement*, i64 }* @append_statement({ %Statement*, i64 }* %t250, %Statement %t252)
  store { %Statement*, i64 }* %t253, { %Statement*, i64 }** %l5
  %t254 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l5
  br label %merge15
merge15:
  %t255 = phi { %Statement*, i64 }* [ %t254, %then14 ], [ %t245, %merge11 ]
  store { %Statement*, i64 }* %t255, { %Statement*, i64 }** %l5
  %t256 = load %Parser, %Parser* %l3
  %t257 = extractvalue %Parser %t256, 1
  %t258 = load double, double* %l8
  %t259 = fcmp ole double %t257, %t258
  %t260 = load %Parser, %Parser* %l0
  %t261 = load %Token, %Token* %l1
  %t262 = load double, double* %l2
  %t263 = load %Parser, %Parser* %l3
  %t264 = load double, double* %l4
  %t265 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l5
  %t266 = load %Token, %Token* %l6
  %t267 = load %BlockStatementParseResult, %BlockStatementParseResult* %l7
  %t268 = load double, double* %l8
  %t269 = load %StatementParseResult, %StatementParseResult* %l9
  br i1 %t259, label %then16, label %merge17
then16:
  %t270 = load %Parser, %Parser* %l3
  %t271 = call %Parser @parser_advance_raw(%Parser %t270)
  store %Parser %t271, %Parser* %l3
  %t272 = load %Parser, %Parser* %l3
  br label %merge17
merge17:
  %t273 = phi %Parser [ %t272, %then16 ], [ %t263, %merge15 ]
  store %Parser %t273, %Parser* %l3
  br label %loop.latch4
loop.latch4:
  %t274 = load %Parser, %Parser* %l3
  %t275 = load double, double* %l4
  %t276 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l5
  br label %loop.header2
afterloop5:
  %t280 = load %Parser, %Parser* %l3
  %t281 = load double, double* %l4
  %t282 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l5
  %t283 = load %Parser, %Parser* %l3
  %t284 = extractvalue %Parser %t283, 1
  store double %t284, double* %l10
  %t285 = load double, double* %l4
  %t286 = load double, double* %l2
  %t287 = fcmp ogt double %t285, %t286
  %t288 = load %Parser, %Parser* %l0
  %t289 = load %Token, %Token* %l1
  %t290 = load double, double* %l2
  %t291 = load %Parser, %Parser* %l3
  %t292 = load double, double* %l4
  %t293 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l5
  %t294 = load double, double* %l10
  br i1 %t287, label %then18, label %merge19
then18:
  %t295 = load double, double* %l4
  store double %t295, double* %l10
  %t296 = load double, double* %l10
  br label %merge19
merge19:
  %t297 = phi double [ %t296, %then18 ], [ %t294, %afterloop5 ]
  store double %t297, double* %l10
  %t298 = load %Parser, %Parser* %l0
  %t299 = extractvalue %Parser %t298, 0
  %t300 = load double, double* %l2
  %t301 = load double, double* %l10
  %t302 = bitcast { %Token**, i64 }* %t299 to { %Token*, i64 }*
  %t303 = call { %Token*, i64 }* @token_slice({ %Token*, i64 }* %t302, double %t300, double %t301)
  store { %Token*, i64 }* %t303, { %Token*, i64 }** %l11
  %t304 = load { %Token*, i64 }*, { %Token*, i64 }** %l11
  %t305 = call { %Token*, i64 }* @trim_block_tokens({ %Token*, i64 }* %t304)
  store { %Token*, i64 }* %t305, { %Token*, i64 }** %l11
  %t306 = load { %Token*, i64 }*, { %Token*, i64 }** %l11
  %t307 = call i8* @tokens_to_text({ %Token*, i64 }* %t306)
  store i8* %t307, i8** %l12
  %t308 = load { %Token*, i64 }*, { %Token*, i64 }** %l11
  %t309 = bitcast { %Token*, i64 }* %t308 to { %Token**, i64 }*
  %t310 = insertvalue %Block undef, { %Token**, i64 }* %t309, 0
  %t311 = load i8*, i8** %l12
  %t312 = insertvalue %Block %t310, i8* %t311, 1
  %t313 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l5
  %t314 = bitcast { %Statement*, i64 }* %t313 to { %Statement**, i64 }*
  %t315 = insertvalue %Block %t312, { %Statement**, i64 }* %t314, 2
  store %Block %t315, %Block* %l13
  %t316 = load %Parser, %Parser* %l3
  %t317 = call %Parser @skip_trivia(%Parser %t316)
  %t318 = insertvalue %BlockParseResult undef, %Parser %t317, 0
  %t319 = load %Block, %Block* %l13
  %t320 = insertvalue %BlockParseResult %t318, %Block %t319, 1
  ret %BlockParseResult %t320
}
