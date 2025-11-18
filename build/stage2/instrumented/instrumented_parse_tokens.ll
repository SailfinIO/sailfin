define %Program @parse_tokens({ %Token*, i64 }* %tokens) {
block.entry:
  call void @stage2_debug_marker(i64 12010)
  %l0 = alloca %Parser
  %l1 = alloca { %Statement*, i64 }*
  %l2 = alloca %Token
  %l3 = alloca %StatementParseResult
  %t0 = bitcast { %Token*, i64 }* %tokens to { %Token**, i64 }*
  %t1 = insertvalue %Parser undef, { %Token**, i64 }* %t0, 0
  %t2 = sitofp i64 0 to double
  %t3 = insertvalue %Parser %t1, double %t2, 1
  store %Parser %t3, %Parser* %l0
  %t4 = getelementptr [0 x %Statement], [0 x %Statement]* null, i32 1
  %t5 = ptrtoint [0 x %Statement]* %t4 to i64
  %t6 = icmp eq i64 %t5, 0
  %t7 = select i1 %t6, i64 1, i64 %t5
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to %Statement*
  %t10 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* null, i32 1
  %t11 = ptrtoint { %Statement*, i64 }* %t10 to i64
  %t12 = call i8* @malloc(i64 %t11)
  %t13 = bitcast i8* %t12 to { %Statement*, i64 }*
  %t14 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t13, i32 0, i32 0
  store %Statement* %t9, %Statement** %t14
  %t15 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t13, i32 0, i32 1
  store i64 0, i64* %t15
  store { %Statement*, i64 }* %t13, { %Statement*, i64 }** %l1
  %t16 = load %Parser, %Parser* %l0
  %t17 = call %Parser @skip_trivia(%Parser %t16)
  store %Parser %t17, %Parser* %l0
  %t18 = load %Parser, %Parser* %l0
  %t19 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l1
  br label %loop.header0
loop.header0:
  %t67 = phi %Parser [ %t18, %block.entry ], [ %t65, %loop.latch2 ]
  %t68 = phi { %Statement*, i64 }* [ %t19, %block.entry ], [ %t66, %loop.latch2 ]
  store %Parser %t67, %Parser* %l0
  store { %Statement*, i64 }* %t68, { %Statement*, i64 }** %l1
  br label %loop.body1
loop.body1:
  %t20 = load %Parser, %Parser* %l0
  %stage2_parse_index = extractvalue %Parser %t20, 1
  %stage2_parse_index_i64 = fptosi double %stage2_parse_index to i64
  %stage2_parse_marker = add i64 %stage2_parse_index_i64, 6000
  call void @stage2_debug_marker(i64 %stage2_parse_marker)
  %t21 = call %Token @parser_peek_raw(%Parser %t20)
  store %Token %t21, %Token* %l2
  %t22 = load %Token, %Token* %l2
  %stage2_token_kind = extractvalue %Token %t22, 0
  %stage2_token_variant = extractvalue %TokenKind %stage2_token_kind, 0
  %stage2_token_variant_i64 = sext i32 %stage2_token_variant to i64
  %stage2_token_marker = add i64 %stage2_token_variant_i64, 7000
  call void @stage2_debug_marker(i64 %stage2_token_marker)
  %t23 = extractvalue %Token %t22, 0
  %t24 = extractvalue %TokenKind %t23, 0
  %t25 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t26 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t27 = icmp eq i32 %t24, 0
  %t28 = select i1 %t27, i8* %t26, i8* %t25
  %t29 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t30 = icmp eq i32 %t24, 1
  %t31 = select i1 %t30, i8* %t29, i8* %t28
  %t32 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t33 = icmp eq i32 %t24, 2
  %t34 = select i1 %t33, i8* %t32, i8* %t31
  %t35 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t36 = icmp eq i32 %t24, 3
  %t37 = select i1 %t36, i8* %t35, i8* %t34
  %t38 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t39 = icmp eq i32 %t24, 4
  %t40 = select i1 %t39, i8* %t38, i8* %t37
  %t41 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t42 = icmp eq i32 %t24, 5
  %t43 = select i1 %t42, i8* %t41, i8* %t40
  %t44 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t45 = icmp eq i32 %t24, 6
  %t46 = select i1 %t45, i8* %t44, i8* %t43
  %t47 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t48 = icmp eq i32 %t24, 7
  %t49 = select i1 %t48, i8* %t47, i8* %t46
  %s50 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1021477046, i32 0, i32 0
  %t51 = icmp eq i8* %t49, %s50
  %t52 = load %Parser, %Parser* %l0
  %t53 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l1
  %t54 = load %Token, %Token* %l2
  br i1 %t51, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t55 = load %Parser, %Parser* %l0
  call void @stage2_debug_marker(i64 12000)
  %t56 = call %StatementParseResult @parse_statement(%Parser %t55)
  store %StatementParseResult %t56, %StatementParseResult* %l3
  %t57 = load %StatementParseResult, %StatementParseResult* %l3
  %t58 = extractvalue %StatementParseResult %t57, 0
  store %Parser %t58, %Parser* %l0
  %t59 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l1
  %t60 = load %StatementParseResult, %StatementParseResult* %l3
  %t61 = extractvalue %StatementParseResult %t60, 1
  %t62 = call { %Statement*, i64 }* @append_statement({ %Statement*, i64 }* %t59, %Statement %t61)
  store { %Statement*, i64 }* %t62, { %Statement*, i64 }** %l1
  %t63 = load %Parser, %Parser* %l0
  %t64 = call %Parser @skip_trivia(%Parser %t63)
  store %Parser %t64, %Parser* %l0
  br label %loop.latch2
loop.latch2:
  %t65 = load %Parser, %Parser* %l0
  %t66 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l1
  br label %loop.header0
afterloop3:
  %t69 = load %Parser, %Parser* %l0
  %t70 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l1
  %t71 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l1
  %t72 = bitcast { %Statement*, i64 }* %t71 to { %Statement**, i64 }*
  %t73 = insertvalue %Program undef, { %Statement**, i64 }* %t72, 0
  ret %Program %t73
}
