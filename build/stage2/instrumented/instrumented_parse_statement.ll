define %StatementParseResult @parse_statement(%Parser %initial_parser) {
block.entry:
  call void @stage2_debug_marker(i64 12100)
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca %DecoratorParseResult
  %l3 = alloca { %Decorator*, i64 }*
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
  store { %Decorator*, i64 }* %t8, { %Decorator*, i64 }** %l3
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
  %t19 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l3
  %t20 = load %Token, %Token* %l4
  br i1 %t15, label %then0, label %merge1
then0:
  %t21 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l3
  %t22 = load { %Decorator*, i64 }, { %Decorator*, i64 }* %t21
  %t23 = extractvalue { %Decorator*, i64 } %t22, 1
  %t24 = icmp sgt i64 %t23, 0
  %t25 = load %Parser, %Parser* %l0
  %t26 = load %Parser, %Parser* %l1
  %t27 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t28 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l3
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
  %t40 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l3
  %t41 = load %Token, %Token* %l4
  br i1 %t36, label %then4, label %merge5
then4:
  %t42 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l3
  %t43 = load { %Decorator*, i64 }, { %Decorator*, i64 }* %t42
  %t44 = extractvalue { %Decorator*, i64 } %t43, 1
  %t45 = icmp sgt i64 %t44, 0
  %t46 = load %Parser, %Parser* %l0
  %t47 = load %Parser, %Parser* %l1
  %t48 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t49 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l3
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
  %t61 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l3
  %t62 = load %Token, %Token* %l4
  br i1 %t57, label %then8, label %merge9
then8:
  %t63 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l3
  %t64 = load { %Decorator*, i64 }, { %Decorator*, i64 }* %t63
  %t65 = extractvalue { %Decorator*, i64 } %t64, 1
  %t66 = icmp sgt i64 %t65, 0
  %t67 = load %Parser, %Parser* %l0
  %t68 = load %Parser, %Parser* %l1
  %t69 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t70 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l3
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
  %t82 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l3
  %t83 = load %Token, %Token* %l4
  br i1 %t78, label %then12, label %merge13
then12:
  %t84 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l3
  %t85 = load { %Decorator*, i64 }, { %Decorator*, i64 }* %t84
  %t86 = extractvalue { %Decorator*, i64 } %t85, 1
  %t87 = icmp sgt i64 %t86, 0
  %t88 = load %Parser, %Parser* %l0
  %t89 = load %Parser, %Parser* %l1
  %t90 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t91 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l3
  %t92 = load %Token, %Token* %l4
  br i1 %t87, label %then14, label %merge15
then14:
  %t93 = load %Parser, %Parser* %l1
  call void @stage2_debug_marker(i64 12113)
  %t94 = call %StatementParseResult @parse_unknown(%Parser %t93)
  ret %StatementParseResult %t94
merge15:
  %t95 = load %Parser, %Parser* %l0
  %t96 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l3
  call void @stage2_debug_marker(i64 12104)
  %t97 = call %StatementParseResult @parse_model(%Parser %t95, { %Decorator*, i64 }* %t96)
  ret %StatementParseResult %t97
merge13:
  %t98 = load %Token, %Token* %l4
  %s99 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h2003786807, i32 0, i32 0
  %t100 = call i1 @identifier_matches(%Token %t98, i8* %s99)
  %t101 = load %Parser, %Parser* %l0
  %t102 = load %Parser, %Parser* %l1
  %t103 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t104 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l3
  %t105 = load %Token, %Token* %l4
  br i1 %t100, label %then16, label %merge17
then16:
  %t106 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l3
  %t107 = load { %Decorator*, i64 }, { %Decorator*, i64 }* %t106
  %t108 = extractvalue { %Decorator*, i64 } %t107, 1
  %t109 = icmp sgt i64 %t108, 0
  %t110 = load %Parser, %Parser* %l0
  %t111 = load %Parser, %Parser* %l1
  %t112 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t113 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l3
  %t114 = load %Token, %Token* %l4
  br i1 %t109, label %then18, label %merge19
then18:
  %t115 = load %Parser, %Parser* %l1
  call void @stage2_debug_marker(i64 12113)
  %t116 = call %StatementParseResult @parse_unknown(%Parser %t115)
  ret %StatementParseResult %t116
merge19:
  %t117 = load %Parser, %Parser* %l0
  %t118 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l3
  call void @stage2_debug_marker(i64 12105)
  %t119 = call %StatementParseResult @parse_pipeline(%Parser %t117, { %Decorator*, i64 }* %t118)
  ret %StatementParseResult %t119
merge17:
  %t120 = load %Token, %Token* %l4
  %s121 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h275832617, i32 0, i32 0
  %t122 = call i1 @identifier_matches(%Token %t120, i8* %s121)
  %t123 = load %Parser, %Parser* %l0
  %t124 = load %Parser, %Parser* %l1
  %t125 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t126 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l3
  %t127 = load %Token, %Token* %l4
  br i1 %t122, label %then20, label %merge21
then20:
  %t128 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l3
  %t129 = load { %Decorator*, i64 }, { %Decorator*, i64 }* %t128
  %t130 = extractvalue { %Decorator*, i64 } %t129, 1
  %t131 = icmp sgt i64 %t130, 0
  %t132 = load %Parser, %Parser* %l0
  %t133 = load %Parser, %Parser* %l1
  %t134 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t135 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l3
  %t136 = load %Token, %Token* %l4
  br i1 %t131, label %then22, label %merge23
then22:
  %t137 = load %Parser, %Parser* %l1
  call void @stage2_debug_marker(i64 12113)
  %t138 = call %StatementParseResult @parse_unknown(%Parser %t137)
  ret %StatementParseResult %t138
merge23:
  %t139 = load %Parser, %Parser* %l0
  %t140 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l3
  call void @stage2_debug_marker(i64 12106)
  %t141 = call %StatementParseResult @parse_tool(%Parser %t139, { %Decorator*, i64 }* %t140)
  ret %StatementParseResult %t141
merge21:
  %t142 = load %Token, %Token* %l4
  %s143 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h275477867, i32 0, i32 0
  %t144 = call i1 @identifier_matches(%Token %t142, i8* %s143)
  %t145 = load %Parser, %Parser* %l0
  %t146 = load %Parser, %Parser* %l1
  %t147 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t148 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l3
  %t149 = load %Token, %Token* %l4
  br i1 %t144, label %then24, label %merge25
then24:
  %t150 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l3
  %t151 = load { %Decorator*, i64 }, { %Decorator*, i64 }* %t150
  %t152 = extractvalue { %Decorator*, i64 } %t151, 1
  %t153 = icmp sgt i64 %t152, 0
  %t154 = load %Parser, %Parser* %l0
  %t155 = load %Parser, %Parser* %l1
  %t156 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t157 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l3
  %t158 = load %Token, %Token* %l4
  br i1 %t153, label %then26, label %merge27
then26:
  %t159 = load %Parser, %Parser* %l1
  call void @stage2_debug_marker(i64 12113)
  %t160 = call %StatementParseResult @parse_unknown(%Parser %t159)
  ret %StatementParseResult %t160
merge27:
  %t161 = load %Parser, %Parser* %l0
  %t162 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l3
  call void @stage2_debug_marker(i64 12107)
  %t163 = call %StatementParseResult @parse_test(%Parser %t161, { %Decorator*, i64 }* %t162)
  ret %StatementParseResult %t163
merge25:
  %t164 = load %Token, %Token* %l4
  %s165 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193491707, i32 0, i32 0
  %t166 = call i1 @identifier_matches(%Token %t164, i8* %s165)
  %t167 = load %Parser, %Parser* %l0
  %t168 = load %Parser, %Parser* %l1
  %t169 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t170 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l3
  %t171 = load %Token, %Token* %l4
  br i1 %t166, label %then28, label %merge29
then28:
  %t172 = load %Parser, %Parser* %l0
  %t173 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l3
  call void @stage2_debug_marker(i64 12108)
  %t174 = call %StatementParseResult @parse_function(%Parser %t172, i1 0, { %Decorator*, i64 }* %t173)
  ret %StatementParseResult %t174
merge29:
  %t175 = load %Token, %Token* %l4
  %s176 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1921561325, i32 0, i32 0
  %t177 = call i1 @identifier_matches(%Token %t175, i8* %s176)
  %t178 = load %Parser, %Parser* %l0
  %t179 = load %Parser, %Parser* %l1
  %t180 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t181 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l3
  %t182 = load %Token, %Token* %l4
  br i1 %t177, label %then30, label %merge31
then30:
  %t183 = load %Parser, %Parser* %l0
  %t184 = call %Parser @parser_advance_raw(%Parser %t183)
  %t185 = call %Parser @skip_trivia(%Parser %t184)
  store %Parser %t185, %Parser* %l5
  %t186 = load %Parser, %Parser* %l5
  %t187 = call %Token @parser_peek_raw(%Parser %t186)
  %s188 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193491707, i32 0, i32 0
  %t189 = call i1 @identifier_matches(%Token %t187, i8* %s188)
  %t190 = load %Parser, %Parser* %l0
  %t191 = load %Parser, %Parser* %l1
  %t192 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t193 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l3
  %t194 = load %Token, %Token* %l4
  %t195 = load %Parser, %Parser* %l5
  br i1 %t189, label %then32, label %merge33
then32:
  %t196 = load %Parser, %Parser* %l0
  %t197 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l3
  call void @stage2_debug_marker(i64 12108)
  %t198 = call %StatementParseResult @parse_function(%Parser %t196, i1 1, { %Decorator*, i64 }* %t197)
  ret %StatementParseResult %t198
merge33:
  br label %merge31
merge31:
  %t199 = load %Token, %Token* %l4
  %s200 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h789690461, i32 0, i32 0
  %t201 = call i1 @identifier_matches(%Token %t199, i8* %s200)
  %t202 = load %Parser, %Parser* %l0
  %t203 = load %Parser, %Parser* %l1
  %t204 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t205 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l3
  %t206 = load %Token, %Token* %l4
  br i1 %t201, label %then34, label %merge35
then34:
  %t207 = load %Parser, %Parser* %l0
  %t208 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l3
  call void @stage2_debug_marker(i64 12109)
  %t209 = call %StatementParseResult @parse_struct(%Parser %t207, { %Decorator*, i64 }* %t208)
  ret %StatementParseResult %t209
merge35:
  %t210 = load %Token, %Token* %l4
  %s211 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h276192845, i32 0, i32 0
  %t212 = call i1 @identifier_matches(%Token %t210, i8* %s211)
  %t213 = load %Parser, %Parser* %l0
  %t214 = load %Parser, %Parser* %l1
  %t215 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t216 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l3
  %t217 = load %Token, %Token* %l4
  br i1 %t212, label %then36, label %merge37
then36:
  %t218 = load %Parser, %Parser* %l0
  %t219 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l3
  call void @stage2_debug_marker(i64 12110)
  %t220 = call %StatementParseResult @parse_type_alias(%Parser %t218, { %Decorator*, i64 }* %t219)
  ret %StatementParseResult %t220
merge37:
  %t221 = load %Token, %Token* %l4
  %s222 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1313193687, i32 0, i32 0
  %t223 = call i1 @identifier_matches(%Token %t221, i8* %s222)
  %t224 = load %Parser, %Parser* %l0
  %t225 = load %Parser, %Parser* %l1
  %t226 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t227 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l3
  %t228 = load %Token, %Token* %l4
  br i1 %t223, label %then38, label %merge39
then38:
  %t229 = load %Parser, %Parser* %l0
  %t230 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l3
  call void @stage2_debug_marker(i64 12111)
  %t231 = call %StatementParseResult @parse_interface(%Parser %t229, { %Decorator*, i64 }* %t230)
  ret %StatementParseResult %t231
merge39:
  %t232 = load %Token, %Token* %l4
  %s233 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h258014432, i32 0, i32 0
  %t234 = call i1 @identifier_matches(%Token %t232, i8* %s233)
  %t235 = load %Parser, %Parser* %l0
  %t236 = load %Parser, %Parser* %l1
  %t237 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t238 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l3
  %t239 = load %Token, %Token* %l4
  br i1 %t234, label %then40, label %merge41
then40:
  %t240 = load %Parser, %Parser* %l0
  %t241 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l3
  call void @stage2_debug_marker(i64 12112)
  %t242 = call %StatementParseResult @parse_enum(%Parser %t240, { %Decorator*, i64 }* %t241)
  ret %StatementParseResult %t242
merge41:
  %t243 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l3
  %t244 = load { %Decorator*, i64 }, { %Decorator*, i64 }* %t243
  %t245 = extractvalue { %Decorator*, i64 } %t244, 1
  %t246 = icmp sgt i64 %t245, 0
  %t247 = load %Parser, %Parser* %l0
  %t248 = load %Parser, %Parser* %l1
  %t249 = load %DecoratorParseResult, %DecoratorParseResult* %l2
  %t250 = load { %Decorator*, i64 }*, { %Decorator*, i64 }** %l3
  %t251 = load %Token, %Token* %l4
  br i1 %t246, label %then42, label %merge43
then42:
  %t252 = load %Parser, %Parser* %l1
  call void @stage2_debug_marker(i64 12113)
  %t253 = call %StatementParseResult @parse_unknown(%Parser %t252)
  ret %StatementParseResult %t253
merge43:
  %t254 = load %Parser, %Parser* %l0
  call void @stage2_debug_marker(i64 12113)
  %t255 = call %StatementParseResult @parse_unknown(%Parser %t254)
  ret %StatementParseResult %t255
}