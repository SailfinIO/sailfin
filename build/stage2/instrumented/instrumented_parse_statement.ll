define %StatementParseResult @parse_statement(%Parser %initial_parser) {
block.entry:
  call void @stage2_debug_marker(i64 12100)
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca %DecoratorParseResult
  %l3 = alloca { %Decorator**, i64 }*
  %l4 = alloca %Token
  %l5 = alloca %Parser
  store %Parser %initial_parser, %Parser* %l0
  %t0 = load %Parser, %Parser* %l0
  store %Parser %t0, %Parser* %l1
  %t1 = load %Parser, %Parser* %l0
  %t2 = call %Parser @skip_trivia(%Parser %t1)
  store %Parser %t2, %Parser* %l0
  %t3 = load %Parser, %Parser* %l0
  %t4 = call %DecoratorParseResult @parse_decorators(%Parser %t3)
  store %DecoratorParseResult %t4, %DecoratorParseResult* %l2
  %t5 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t6 = extractvalue %DecoratorParseResult %t5, 0
  store %Parser %t6, %Parser* %l0
  %t7 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t8 = extractvalue %DecoratorParseResult %t7, 1
  store { %Decorator**, i64 }* %t8, { %Decorator**, i64 }** %l3
  %t9 = load %Parser, %Parser* %l0
  %t10 = call %Parser @skip_trivia(%Parser %t9)
  store %Parser %t10, %Parser* %l0
  %t11 = load %Parser, %Parser* %l0
  %t12 = call %Token @parser_peek_raw(%Parser %t11)
  store %Token %t12, %Token* %l4
  %stage2_stmt_token_kind = extractvalue %Token %t12, 0
  %stage2_stmt_token_variant = extractvalue %TokenKind %stage2_stmt_token_kind, 0
  %stage2_stmt_token_variant_i64 = sext i32 %stage2_stmt_token_variant to i64
  %stage2_stmt_token_marker = add i64 %stage2_stmt_token_variant_i64, 12200
  call void @stage2_debug_marker(i64 %stage2_stmt_token_marker)
  %t13 = load %Token, %Token* %l4
  %s14 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h483393773, i32 0, i32 0
  %t15 = call i1 @identifier_matches(%Token %t13, i8* %s14)
  %t16 = load %Parser, %Parser* %l0
  %t17 = load %Parser, %Parser* %l1
  %t18 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t19 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t20 = load %Token, %Token* %l4
  br i1 %t15, label %then0, label %merge1
then0:
  %t21 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t22 = load { %Decorator**, i64 }, { %Decorator**, i64 }* %t21
  %t23 = extractvalue { %Decorator**, i64 } %t22, 1
  %t24 = icmp sgt i64 %t23, 0
  %t25 = load %Parser, %Parser* %l0
  %t26 = load %Parser, %Parser* %l1
  %t27 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t28 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t29 = load %Token, %Token* %l4
  br i1 %t24, label %then2, label %merge3
then2:
  %t30 = load %Parser, %Parser* %l1
  call void @stage2_debug_marker(i64 12113)
  %t31 = call %StatementParseResult @parse_unknown(%Parser %t30)
  ret %StatementParseResult %t31
merge3:
  %t32 = load %Parser, %Parser* %l0
  call void @stage2_debug_marker(i64 12101)
  %t33 = call %StatementParseResult @parse_import(%Parser %t32)
  ret %StatementParseResult %t33
merge1:
  %t34 = load %Token, %Token* %l4
  %s35 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h42978514, i32 0, i32 0
  %t36 = call i1 @identifier_matches(%Token %t34, i8* %s35)
  %t37 = load %Parser, %Parser* %l0
  %t38 = load %Parser, %Parser* %l1
  %t39 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t40 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t41 = load %Token, %Token* %l4
  br i1 %t36, label %then4, label %merge5
then4:
  %t42 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t43 = load { %Decorator**, i64 }, { %Decorator**, i64 }* %t42
  %t44 = extractvalue { %Decorator**, i64 } %t43, 1
  %t45 = icmp sgt i64 %t44, 0
  %t46 = load %Parser, %Parser* %l0
  %t47 = load %Parser, %Parser* %l1
  %t48 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t49 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t50 = load %Token, %Token* %l4
  br i1 %t45, label %then6, label %merge7
then6:
  %t51 = load %Parser, %Parser* %l1
  call void @stage2_debug_marker(i64 12113)
  %t52 = call %StatementParseResult @parse_unknown(%Parser %t51)
  ret %StatementParseResult %t52
merge7:
  %t53 = load %Parser, %Parser* %l0
  call void @stage2_debug_marker(i64 12102)
  %t54 = call %StatementParseResult @parse_export(%Parser %t53)
  ret %StatementParseResult %t54
merge5:
  %t55 = load %Token, %Token* %l4
  %s56 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2090468623, i32 0, i32 0
  %t57 = call i1 @identifier_matches(%Token %t55, i8* %s56)
  %t58 = load %Parser, %Parser* %l0
  %t59 = load %Parser, %Parser* %l1
  %t60 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t61 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t62 = load %Token, %Token* %l4
  br i1 %t57, label %then8, label %merge9
then8:
  %t63 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t64 = load { %Decorator**, i64 }, { %Decorator**, i64 }* %t63
  %t65 = extractvalue { %Decorator**, i64 } %t64, 1
  %t66 = icmp sgt i64 %t65, 0
  %t67 = load %Parser, %Parser* %l0
  %t68 = load %Parser, %Parser* %l1
  %t69 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t70 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t71 = load %Token, %Token* %l4
  br i1 %t66, label %then10, label %merge11
then10:
  %t72 = load %Parser, %Parser* %l1
  call void @stage2_debug_marker(i64 12113)
  %t73 = call %StatementParseResult @parse_unknown(%Parser %t72)
  ret %StatementParseResult %t73
merge11:
  %t74 = load %Parser, %Parser* %l0
  call void @stage2_debug_marker(i64 12103)
  %t75 = call %StatementParseResult @parse_variable(%Parser %t74)
  ret %StatementParseResult %t75
merge9:
  %t76 = load %Token, %Token* %l4
  %s77 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h238194529, i32 0, i32 0
  %t78 = call i1 @identifier_matches(%Token %t76, i8* %s77)
  %t79 = load %Parser, %Parser* %l0
  %t80 = load %Parser, %Parser* %l1
  %t81 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t82 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t83 = load %Token, %Token* %l4
  br i1 %t78, label %then12, label %merge13
then12:
  %t84 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t85 = load { %Decorator**, i64 }, { %Decorator**, i64 }* %t84
  %t86 = extractvalue { %Decorator**, i64 } %t85, 1
  %t87 = icmp sgt i64 %t86, 0
  %t88 = load %Parser, %Parser* %l0
  %t89 = load %Parser, %Parser* %l1
  %t90 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t91 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t92 = load %Token, %Token* %l4
  br i1 %t87, label %then14, label %merge15
then14:
  %t93 = load %Parser, %Parser* %l1
  call void @stage2_debug_marker(i64 12113)
  %t94 = call %StatementParseResult @parse_unknown(%Parser %t93)
  ret %StatementParseResult %t94
merge15:
  %t95 = load %Parser, %Parser* %l0
  %t96 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t97 = bitcast { %Decorator**, i64 }* %t96 to { %Decorator*, i64 }*
  call void @stage2_debug_marker(i64 12104)
  %t98 = call %StatementParseResult @parse_model(%Parser %t95, { %Decorator*, i64 }* %t97)
  ret %StatementParseResult %t98
merge13:
  %t99 = load %Token, %Token* %l4
  %s100 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h2003786807, i32 0, i32 0
  %t101 = call i1 @identifier_matches(%Token %t99, i8* %s100)
  %t102 = load %Parser, %Parser* %l0
  %t103 = load %Parser, %Parser* %l1
  %t104 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t105 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t106 = load %Token, %Token* %l4
  br i1 %t101, label %then16, label %merge17
then16:
  %t107 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t108 = load { %Decorator**, i64 }, { %Decorator**, i64 }* %t107
  %t109 = extractvalue { %Decorator**, i64 } %t108, 1
  %t110 = icmp sgt i64 %t109, 0
  %t111 = load %Parser, %Parser* %l0
  %t112 = load %Parser, %Parser* %l1
  %t113 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t114 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t115 = load %Token, %Token* %l4
  br i1 %t110, label %then18, label %merge19
then18:
  %t116 = load %Parser, %Parser* %l1
  call void @stage2_debug_marker(i64 12113)
  %t117 = call %StatementParseResult @parse_unknown(%Parser %t116)
  ret %StatementParseResult %t117
merge19:
  %t118 = load %Parser, %Parser* %l0
  %t119 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t120 = bitcast { %Decorator**, i64 }* %t119 to { %Decorator*, i64 }*
  call void @stage2_debug_marker(i64 12105)
  %t121 = call %StatementParseResult @parse_pipeline(%Parser %t118, { %Decorator*, i64 }* %t120)
  ret %StatementParseResult %t121
merge17:
  %t122 = load %Token, %Token* %l4
  %s123 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h275832617, i32 0, i32 0
  %t124 = call i1 @identifier_matches(%Token %t122, i8* %s123)
  %t125 = load %Parser, %Parser* %l0
  %t126 = load %Parser, %Parser* %l1
  %t127 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t128 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t129 = load %Token, %Token* %l4
  br i1 %t124, label %then20, label %merge21
then20:
  %t130 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t131 = load { %Decorator**, i64 }, { %Decorator**, i64 }* %t130
  %t132 = extractvalue { %Decorator**, i64 } %t131, 1
  %t133 = icmp sgt i64 %t132, 0
  %t134 = load %Parser, %Parser* %l0
  %t135 = load %Parser, %Parser* %l1
  %t136 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t137 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t138 = load %Token, %Token* %l4
  br i1 %t133, label %then22, label %merge23
then22:
  %t139 = load %Parser, %Parser* %l1
  call void @stage2_debug_marker(i64 12113)
  %t140 = call %StatementParseResult @parse_unknown(%Parser %t139)
  ret %StatementParseResult %t140
merge23:
  %t141 = load %Parser, %Parser* %l0
  %t142 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t143 = bitcast { %Decorator**, i64 }* %t142 to { %Decorator*, i64 }*
  call void @stage2_debug_marker(i64 12106)
  %t144 = call %StatementParseResult @parse_tool(%Parser %t141, { %Decorator*, i64 }* %t143)
  ret %StatementParseResult %t144
merge21:
  %t145 = load %Token, %Token* %l4
  %s146 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h275477867, i32 0, i32 0
  %t147 = call i1 @identifier_matches(%Token %t145, i8* %s146)
  %t148 = load %Parser, %Parser* %l0
  %t149 = load %Parser, %Parser* %l1
  %t150 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t151 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t152 = load %Token, %Token* %l4
  br i1 %t147, label %then24, label %merge25
then24:
  %t153 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t154 = load { %Decorator**, i64 }, { %Decorator**, i64 }* %t153
  %t155 = extractvalue { %Decorator**, i64 } %t154, 1
  %t156 = icmp sgt i64 %t155, 0
  %t157 = load %Parser, %Parser* %l0
  %t158 = load %Parser, %Parser* %l1
  %t159 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t160 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t161 = load %Token, %Token* %l4
  br i1 %t156, label %then26, label %merge27
then26:
  %t162 = load %Parser, %Parser* %l1
  call void @stage2_debug_marker(i64 12113)
  %t163 = call %StatementParseResult @parse_unknown(%Parser %t162)
  ret %StatementParseResult %t163
merge27:
  %t164 = load %Parser, %Parser* %l0
  %t165 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t166 = bitcast { %Decorator**, i64 }* %t165 to { %Decorator*, i64 }*
  call void @stage2_debug_marker(i64 12107)
  %t167 = call %StatementParseResult @parse_test(%Parser %t164, { %Decorator*, i64 }* %t166)
  ret %StatementParseResult %t167
merge25:
  %t168 = load %Token, %Token* %l4
  %s169 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193491707, i32 0, i32 0
  %t170 = call i1 @identifier_matches(%Token %t168, i8* %s169)
  %t171 = load %Parser, %Parser* %l0
  %t172 = load %Parser, %Parser* %l1
  %t173 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t174 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t175 = load %Token, %Token* %l4
  br i1 %t170, label %then28, label %merge29
then28:
  %t176 = load %Parser, %Parser* %l0
  %t177 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t178 = bitcast { %Decorator**, i64 }* %t177 to { %Decorator*, i64 }*
  call void @stage2_debug_marker(i64 12108)
  %t179 = call %StatementParseResult @parse_function(%Parser %t176, i1 0, { %Decorator*, i64 }* %t178)
  ret %StatementParseResult %t179
merge29:
  %t180 = load %Token, %Token* %l4
  %s181 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1921561325, i32 0, i32 0
  %t182 = call i1 @identifier_matches(%Token %t180, i8* %s181)
  %t183 = load %Parser, %Parser* %l0
  %t184 = load %Parser, %Parser* %l1
  %t185 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t186 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t187 = load %Token, %Token* %l4
  br i1 %t182, label %then30, label %merge31
then30:
  %t188 = load %Parser, %Parser* %l0
  %t189 = call %Parser @parser_advance_raw(%Parser %t188)
  %t190 = call %Parser @skip_trivia(%Parser %t189)
  store %Parser %t190, %Parser* %l5
  %t191 = load %Parser, %Parser* %l5
  %t192 = call %Token @parser_peek_raw(%Parser %t191)
  %s193 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193491707, i32 0, i32 0
  %t194 = call i1 @identifier_matches(%Token %t192, i8* %s193)
  %t195 = load %Parser, %Parser* %l0
  %t196 = load %Parser, %Parser* %l1
  %t197 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t198 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t199 = load %Token, %Token* %l4
  %t200 = load %Parser, %Parser* %l5
  br i1 %t194, label %then32, label %merge33
then32:
  %t201 = load %Parser, %Parser* %l0
  %t202 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t203 = bitcast { %Decorator**, i64 }* %t202 to { %Decorator*, i64 }*
  call void @stage2_debug_marker(i64 12108)
  %t204 = call %StatementParseResult @parse_function(%Parser %t201, i1 1, { %Decorator*, i64 }* %t203)
  ret %StatementParseResult %t204
merge33:
  br label %merge31
merge31:
  %t205 = load %Token, %Token* %l4
  %s206 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h789690461, i32 0, i32 0
  %t207 = call i1 @identifier_matches(%Token %t205, i8* %s206)
  %t208 = load %Parser, %Parser* %l0
  %t209 = load %Parser, %Parser* %l1
  %t210 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t211 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t212 = load %Token, %Token* %l4
  br i1 %t207, label %then34, label %merge35
then34:
  %t213 = load %Parser, %Parser* %l0
  %t214 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t215 = bitcast { %Decorator**, i64 }* %t214 to { %Decorator*, i64 }*
  call void @stage2_debug_marker(i64 12109)
  %t216 = call %StatementParseResult @parse_struct(%Parser %t213, { %Decorator*, i64 }* %t215)
  ret %StatementParseResult %t216
merge35:
  %t217 = load %Token, %Token* %l4
  %s218 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h276192845, i32 0, i32 0
  %t219 = call i1 @identifier_matches(%Token %t217, i8* %s218)
  %t220 = load %Parser, %Parser* %l0
  %t221 = load %Parser, %Parser* %l1
  %t222 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t223 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t224 = load %Token, %Token* %l4
  br i1 %t219, label %then36, label %merge37
then36:
  %t225 = load %Parser, %Parser* %l0
  %t226 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t227 = bitcast { %Decorator**, i64 }* %t226 to { %Decorator*, i64 }*
  call void @stage2_debug_marker(i64 12110)
  %t228 = call %StatementParseResult @parse_type_alias(%Parser %t225, { %Decorator*, i64 }* %t227)
  ret %StatementParseResult %t228
merge37:
  %t229 = load %Token, %Token* %l4
  %s230 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1313193687, i32 0, i32 0
  %t231 = call i1 @identifier_matches(%Token %t229, i8* %s230)
  %t232 = load %Parser, %Parser* %l0
  %t233 = load %Parser, %Parser* %l1
  %t234 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t235 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t236 = load %Token, %Token* %l4
  br i1 %t231, label %then38, label %merge39
then38:
  %t237 = load %Parser, %Parser* %l0
  %t238 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t239 = bitcast { %Decorator**, i64 }* %t238 to { %Decorator*, i64 }*
  call void @stage2_debug_marker(i64 12111)
  %t240 = call %StatementParseResult @parse_interface(%Parser %t237, { %Decorator*, i64 }* %t239)
  ret %StatementParseResult %t240
merge39:
  %t241 = load %Token, %Token* %l4
  %s242 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h258014432, i32 0, i32 0
  %t243 = call i1 @identifier_matches(%Token %t241, i8* %s242)
  %t244 = load %Parser, %Parser* %l0
  %t245 = load %Parser, %Parser* %l1
  %t246 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t247 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t248 = load %Token, %Token* %l4
  br i1 %t243, label %then40, label %merge41
then40:
  %t249 = load %Parser, %Parser* %l0
  %t250 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t251 = bitcast { %Decorator**, i64 }* %t250 to { %Decorator*, i64 }*
  call void @stage2_debug_marker(i64 12112)
  %t252 = call %StatementParseResult @parse_enum(%Parser %t249, { %Decorator*, i64 }* %t251)
  ret %StatementParseResult %t252
merge41:
  %t253 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t254 = load { %Decorator**, i64 }, { %Decorator**, i64 }* %t253
  %t255 = extractvalue { %Decorator**, i64 } %t254, 1
  %t256 = icmp sgt i64 %t255, 0
  %t257 = load %Parser, %Parser* %l0
  %t258 = load %Parser, %Parser* %l1
  %t259 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t260 = load { %Decorator**, i64 }*, { %Decorator**, i64 }** %l3
  %t261 = load %Token, %Token* %l4
  br i1 %t256, label %then42, label %merge43
then42:
  %t262 = load %Parser, %Parser* %l1
  call void @stage2_debug_marker(i64 12113)
  %t263 = call %StatementParseResult @parse_unknown(%Parser %t262)
  ret %StatementParseResult %t263
merge43:
  %t264 = load %Parser, %Parser* %l0
  call void @stage2_debug_marker(i64 12113)
  %t265 = call %StatementParseResult @parse_unknown(%Parser %t264)
  ret %StatementParseResult %t265
}