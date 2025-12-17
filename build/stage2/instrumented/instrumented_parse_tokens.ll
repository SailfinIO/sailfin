define %Program @parse_tokens({ %Token*, i64 }* %tokens) {
block.entry:
  call void @stage2_debug_marker(i64 12010)
  %l0 = alloca %Parser
  %l1 = alloca { %Statement*, i64 }*
  %l2 = alloca %Token
  %l3 = alloca %StatementParseResult
  %t0 = insertvalue %Parser undef, { %Token*, i64 }* %tokens, 0
  %t1 = sitofp i64 0 to double
  %t2 = insertvalue %Parser %t0, double %t1, 1
  store %Parser %t2, %Parser* %l0
  %t3 = getelementptr [0 x %Statement], [0 x %Statement]* null, i32 1
  %t4 = ptrtoint [0 x %Statement]* %t3 to i64
  %t5 = icmp eq i64 %t4, 0
  %t6 = select i1 %t5, i64 1, i64 %t4
  %t7 = call i8* @malloc(i64 %t6)
  %t8 = bitcast i8* %t7 to %Statement*
  %t9 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* null, i32 1
  %t10 = ptrtoint { %Statement*, i64 }* %t9 to i64
  %t11 = call i8* @malloc(i64 %t10)
  %t12 = bitcast i8* %t11 to { %Statement*, i64 }*
  %t13 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t12, i32 0, i32 0
  store %Statement* %t8, %Statement** %t13
  %t14 = getelementptr { %Statement*, i64 }, { %Statement*, i64 }* %t12, i32 0, i32 1
  store i64 0, i64* %t14
  store { %Statement*, i64 }* %t12, { %Statement*, i64 }** %l1
  %t15 = load %Parser, %Parser* %l0
  %t16 = call %Parser @skip_trivia(%Parser %t15)
  store %Parser %t16, %Parser* %l0
  %t17 = load %Parser, %Parser* %l0
  %t18 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l1
  br label %loop.header0
loop.header0:
  %t66 = phi %Parser [ %t17, %block.entry ], [ %t64, %loop.latch2 ]
  %t67 = phi { %Statement*, i64 }* [ %t18, %block.entry ], [ %t65, %loop.latch2 ]
  store %Parser %t66, %Parser* %l0
  store { %Statement*, i64 }* %t67, { %Statement*, i64 }** %l1
  br label %loop.body1
loop.body1:
  %t19 = load %Parser, %Parser* %l0
  %t20 = call %Token @parser_peek_raw(%Parser %t19)
  store %Token %t20, %Token* %l2
  %t21 = load %Token, %Token* %l2
  %t22 = extractvalue %Token %t21, 0
  %t23 = extractvalue %TokenKind %t22, 0
  %t24 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.TokenKind.variant.default, i32 0, i32 0
  %t25 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Identifier.variant, i32 0, i32 0
  %t26 = icmp eq i32 %t23, 0
  %t27 = select i1 %t26, i8* %t25, i8* %t24
  %t28 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.NumberLiteral.variant, i32 0, i32 0
  %t29 = icmp eq i32 %t23, 1
  %t30 = select i1 %t29, i8* %t28, i8* %t27
  %t31 = getelementptr inbounds [14 x i8], [14 x i8]* @.enum.TokenKind.StringLiteral.variant, i32 0, i32 0
  %t32 = icmp eq i32 %t23, 2
  %t33 = select i1 %t32, i8* %t31, i8* %t30
  %t34 = getelementptr inbounds [15 x i8], [15 x i8]* @.enum.TokenKind.BooleanLiteral.variant, i32 0, i32 0
  %t35 = icmp eq i32 %t23, 3
  %t36 = select i1 %t35, i8* %t34, i8* %t33
  %t37 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.TokenKind.Symbol.variant, i32 0, i32 0
  %t38 = icmp eq i32 %t23, 4
  %t39 = select i1 %t38, i8* %t37, i8* %t36
  %t40 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.TokenKind.Whitespace.variant, i32 0, i32 0
  %t41 = icmp eq i32 %t23, 5
  %t42 = select i1 %t41, i8* %t40, i8* %t39
  %t43 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.TokenKind.Comment.variant, i32 0, i32 0
  %t44 = icmp eq i32 %t23, 6
  %t45 = select i1 %t44, i8* %t43, i8* %t42
  %t46 = getelementptr inbounds [10 x i8], [10 x i8]* @.enum.TokenKind.EndOfFile.variant, i32 0, i32 0
  %t47 = icmp eq i32 %t23, 7
  %t48 = select i1 %t47, i8* %t46, i8* %t45
  %s49 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1021477046, i32 0, i32 0
  %t50 = call i1 @strings_equal(i8* %t48, i8* %s49)
  %t51 = load %Parser, %Parser* %l0
  %t52 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l1
  %t53 = load %Token, %Token* %l2
  br i1 %t50, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t54 = load %Parser, %Parser* %l0
  %t55 = call %StatementParseResult @parse_statement(%Parser %t54)
  store %StatementParseResult %t55, %StatementParseResult* %l3
  %t56 = load %StatementParseResult, %StatementParseResult* %l3
  %t57 = extractvalue %StatementParseResult %t56, 0
  store %Parser %t57, %Parser* %l0
  %t58 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l1
  %t59 = load %StatementParseResult, %StatementParseResult* %l3
  %t60 = extractvalue %StatementParseResult %t59, 1
  %t61 = call { %Statement*, i64 }* @append_statement({ %Statement*, i64 }* %t58, %Statement %t60)
  store { %Statement*, i64 }* %t61, { %Statement*, i64 }** %l1
  %t62 = load %Parser, %Parser* %l0
  %t63 = call %Parser @skip_trivia(%Parser %t62)
  store %Parser %t63, %Parser* %l0
  br label %loop.latch2
loop.latch2:
  %t64 = load %Parser, %Parser* %l0
  %t65 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l1
  br label %loop.header0
afterloop3:
  %t68 = load %Parser, %Parser* %l0
  %t69 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l1
  %t70 = load { %Statement*, i64 }*, { %Statement*, i64 }** %l1
  %t71 = insertvalue %Program undef, { %Statement*, i64 }* %t70, 0
  ret %Program %t71
}
