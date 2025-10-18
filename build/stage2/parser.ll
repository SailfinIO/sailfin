; ModuleID = 'sailfin'
source_filename = "sailfin"

%Parser = type { { i8**, i64 }*, double }
%StatementParseResult = type { i8*, i8* }
%ParameterParseResult = type { i8*, i8* }
%ParameterListParseResult = type { i8*, { i8**, i64 }* }
%StructFieldParseResult = type { i8*, i8*, i1 }
%ModelPropertyParseResult = type { i8*, i8*, i1 }
%MethodParseResult = type { i8*, i8*, i1 }
%InterfaceMemberParseResult = type { i8*, i8*, i1 }
%SpecifierListParseResult = type { i8*, { i8**, i64 }* }
%NamedSpecifier = type { i8*, i8* }
%EnumVariantParseResult = type { i8*, i8*, i1 }
%TypeParameterParseResult = type { i8*, { i8**, i64 }* }
%ImplementsParseResult = type { i8*, { i8**, i64 }*, i1 }
%DecoratorParseResult = type { i8*, { i8**, i64 }* }
%BlockStatementParseResult = type { i8*, i8*, i1 }
%ParenthesizedParseResult = type { i8*, { i8**, i64 }*, i1 }
%MatchCasesParseResult = type { i8*, { i8**, i64 }*, i1 }
%MatchCaseParseResult = type { i8*, i8*, i1 }
%MatchCaseTokenSplit = type { { i8**, i64 }*, { i8**, i64 }*, i1 }
%ExpressionTokens = type { { i8**, i64 }*, double }
%ExpressionParseResult = type { i8*, i8*, i1 }
%LambdaParameterParseResult = type { i8*, i8*, i1 }
%LambdaParameterListParseResult = type { i8*, { i8**, i64 }*, i1 }
%ExpressionCollectResult = type { i8*, { i8**, i64 }*, i1 }
%ExpressionBlockParseResult = type { i8*, { i8**, i64 }*, i1 }
%CallArgumentsParseResult = type { i8*, { i8**, i64 }*, i1 }
%ArrayLiteralParseResult = type { i8*, { i8**, i64 }*, i1 }
%ObjectLiteralParseResult = type { i8*, { i8**, i64 }*, i1 }
%StructTypeNameResult = type { { i8**, i64 }*, i1 }
%CaptureResult = type { i8*, { i8**, i64 }* }
%EffectParseResult = type { i8*, { i8**, i64 }* }
%BlockParseResult = type { i8*, i8* }
%PatternCaptureResult = type { i8*, { i8**, i64 }*, i1 }

declare noalias i8* @malloc(i64)

@.str.4 = private unnamed_addr constant [2 x i8] c";\00"
@.str.45 = private unnamed_addr constant [3 x i8] c"fn\00"
@.str.73 = private unnamed_addr constant [2 x i8] c"(\00"
@.str.12 = private unnamed_addr constant [2 x i8] c"!\00"
@.str.13 = private unnamed_addr constant [2 x i8] c"{\00"
@.str.16 = private unnamed_addr constant [11 x i8] c"implements\00"
@.str.13 = private unnamed_addr constant [4 x i8] c"for\00"
@.str.43 = private unnamed_addr constant [3 x i8] c"in\00"
@.str.13 = private unnamed_addr constant [5 x i8] c"loop\00"
@.str.13 = private unnamed_addr constant [6 x i8] c"break\00"
@.str.13 = private unnamed_addr constant [9 x i8] c"continue\00"
@.str.13 = private unnamed_addr constant [3 x i8] c"if\00"
@.str.13 = private unnamed_addr constant [6 x i8] c"match\00"
@.str.15 = private unnamed_addr constant [7 x i8] c"prompt\00"
@.str.21 = private unnamed_addr constant [1 x i8] c"\00"
@.str.13 = private unnamed_addr constant [5 x i8] c"with\00"
@.str.22 = private unnamed_addr constant [7 x i8] c"return\00"
@.str.27 = private unnamed_addr constant [2 x i8] c"}\00"
@.str.9 = private unnamed_addr constant [2 x i8] c"0\00"
@.str.11 = private unnamed_addr constant [2 x i8] c"1\00"
@.str.14 = private unnamed_addr constant [2 x i8] c"2\00"
@.str.17 = private unnamed_addr constant [2 x i8] c"3\00"
@.str.20 = private unnamed_addr constant [2 x i8] c"4\00"
@.str.23 = private unnamed_addr constant [2 x i8] c"5\00"
@.str.26 = private unnamed_addr constant [2 x i8] c"6\00"
@.str.29 = private unnamed_addr constant [2 x i8] c"7\00"
@.str.32 = private unnamed_addr constant [2 x i8] c"8\00"
@.str.35 = private unnamed_addr constant [2 x i8] c"9\00"

define %StatementParseResult @parse_statement(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %DecoratorParseResult
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca double
  %l4 = alloca double
  store %Parser %parser, %Parser* %l0
  %t0 = call %DecoratorParseResult @parse_decorators(%Parser %parser)
  store %DecoratorParseResult %t0, %DecoratorParseResult* %l1
  %t1 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t2 = extractvalue %DecoratorParseResult %t1, 1
  store { i8**, i64 }* %t2, { i8**, i64 }** %l2
  %t3 = call double @parser_peek_raw(%Parser %parser)
  store double %t3, double* %l3
  %t4 = load double, double* %l3
  %s5 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.5, i32 0, i32 0
  %t6 = call i1 @identifier_matches(i8* null, i8* %s5)
  %t7 = load %Parser, %Parser* %l0
  %t8 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t10 = load double, double* %l3
  br i1 %t6, label %then0, label %merge1
then0:
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t12 = load { i8**, i64 }, { i8**, i64 }* %t11
  %t13 = extractvalue { i8**, i64 } %t12, 1
  %t14 = icmp sgt i64 %t13, 0
  %t15 = load %Parser, %Parser* %l0
  %t16 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t18 = load double, double* %l3
  br i1 %t14, label %then2, label %merge3
then2:
  %t19 = load %Parser, %Parser* %l0
  %t20 = call %StatementParseResult @parse_unknown(%Parser %t19)
  ret %StatementParseResult %t20
merge3:
  %t21 = call %StatementParseResult @parse_import(%Parser %parser)
  ret %StatementParseResult %t21
merge1:
  %t22 = load double, double* %l3
  %s23 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.23, i32 0, i32 0
  %t24 = call i1 @identifier_matches(i8* null, i8* %s23)
  %t25 = load %Parser, %Parser* %l0
  %t26 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t28 = load double, double* %l3
  br i1 %t24, label %then4, label %merge5
then4:
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t30 = load { i8**, i64 }, { i8**, i64 }* %t29
  %t31 = extractvalue { i8**, i64 } %t30, 1
  %t32 = icmp sgt i64 %t31, 0
  %t33 = load %Parser, %Parser* %l0
  %t34 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t36 = load double, double* %l3
  br i1 %t32, label %then6, label %merge7
then6:
  %t37 = load %Parser, %Parser* %l0
  %t38 = call %StatementParseResult @parse_unknown(%Parser %t37)
  ret %StatementParseResult %t38
merge7:
  %t39 = call %StatementParseResult @parse_variable(%Parser %parser)
  ret %StatementParseResult %t39
merge5:
  %t40 = load double, double* %l3
  %s41 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.41, i32 0, i32 0
  %t42 = call i1 @identifier_matches(i8* null, i8* %s41)
  %t43 = load %Parser, %Parser* %l0
  %t44 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t46 = load double, double* %l3
  br i1 %t42, label %then8, label %merge9
then8:
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t48 = load { i8**, i64 }, { i8**, i64 }* %t47
  %t49 = extractvalue { i8**, i64 } %t48, 1
  %t50 = icmp sgt i64 %t49, 0
  %t51 = load %Parser, %Parser* %l0
  %t52 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t54 = load double, double* %l3
  br i1 %t50, label %then10, label %merge11
then10:
  %t55 = load %Parser, %Parser* %l0
  %t56 = call %StatementParseResult @parse_unknown(%Parser %t55)
  ret %StatementParseResult %t56
merge11:
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t58 = call %StatementParseResult @parse_model(%Parser %parser, { i8**, i64 }* %t57)
  ret %StatementParseResult %t58
merge9:
  %t59 = load double, double* %l3
  %s60 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.60, i32 0, i32 0
  %t61 = call i1 @identifier_matches(i8* null, i8* %s60)
  %t62 = load %Parser, %Parser* %l0
  %t63 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t65 = load double, double* %l3
  br i1 %t61, label %then12, label %merge13
then12:
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t67 = load { i8**, i64 }, { i8**, i64 }* %t66
  %t68 = extractvalue { i8**, i64 } %t67, 1
  %t69 = icmp sgt i64 %t68, 0
  %t70 = load %Parser, %Parser* %l0
  %t71 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t73 = load double, double* %l3
  br i1 %t69, label %then14, label %merge15
then14:
  %t74 = load %Parser, %Parser* %l0
  %t75 = call %StatementParseResult @parse_unknown(%Parser %t74)
  ret %StatementParseResult %t75
merge15:
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t77 = call %StatementParseResult @parse_pipeline(%Parser %parser, { i8**, i64 }* %t76)
  ret %StatementParseResult %t77
merge13:
  %t78 = load double, double* %l3
  %s79 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.79, i32 0, i32 0
  %t80 = call i1 @identifier_matches(i8* null, i8* %s79)
  %t81 = load %Parser, %Parser* %l0
  %t82 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t84 = load double, double* %l3
  br i1 %t80, label %then16, label %merge17
then16:
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t86 = load { i8**, i64 }, { i8**, i64 }* %t85
  %t87 = extractvalue { i8**, i64 } %t86, 1
  %t88 = icmp sgt i64 %t87, 0
  %t89 = load %Parser, %Parser* %l0
  %t90 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t91 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t92 = load double, double* %l3
  br i1 %t88, label %then18, label %merge19
then18:
  %t93 = load %Parser, %Parser* %l0
  %t94 = call %StatementParseResult @parse_unknown(%Parser %t93)
  ret %StatementParseResult %t94
merge19:
  %t95 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t96 = call %StatementParseResult @parse_tool(%Parser %parser, { i8**, i64 }* %t95)
  ret %StatementParseResult %t96
merge17:
  %t97 = load double, double* %l3
  %s98 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.98, i32 0, i32 0
  %t99 = call i1 @identifier_matches(i8* null, i8* %s98)
  %t100 = load %Parser, %Parser* %l0
  %t101 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t102 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t103 = load double, double* %l3
  br i1 %t99, label %then20, label %merge21
then20:
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t105 = load { i8**, i64 }, { i8**, i64 }* %t104
  %t106 = extractvalue { i8**, i64 } %t105, 1
  %t107 = icmp sgt i64 %t106, 0
  %t108 = load %Parser, %Parser* %l0
  %t109 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t110 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t111 = load double, double* %l3
  br i1 %t107, label %then22, label %merge23
then22:
  %t112 = load %Parser, %Parser* %l0
  %t113 = call %StatementParseResult @parse_unknown(%Parser %t112)
  ret %StatementParseResult %t113
merge23:
  %t114 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t115 = call %StatementParseResult @parse_test(%Parser %parser, { i8**, i64 }* %t114)
  ret %StatementParseResult %t115
merge21:
  %t116 = load double, double* %l3
  %s117 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.117, i32 0, i32 0
  %t118 = call i1 @identifier_matches(i8* null, i8* %s117)
  %t119 = load %Parser, %Parser* %l0
  %t120 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t121 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t122 = load double, double* %l3
  br i1 %t118, label %then24, label %merge25
then24:
  %t123 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t124 = call %StatementParseResult @parse_function(%Parser %parser, i1 0, { i8**, i64 }* %t123)
  ret %StatementParseResult %t124
merge25:
  %t125 = load double, double* %l3
  %s126 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.126, i32 0, i32 0
  %t127 = call i1 @identifier_matches(i8* null, i8* %s126)
  %t128 = load %Parser, %Parser* %l0
  %t129 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t130 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t131 = load double, double* %l3
  br i1 %t127, label %then26, label %merge27
then26:
  %t132 = load double, double* %l3
  %s133 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.133, i32 0, i32 0
  %t134 = call i1 @identifier_matches(i8* null, i8* %s133)
  %t135 = load %Parser, %Parser* %l0
  %t136 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t137 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t138 = load double, double* %l3
  br i1 %t134, label %then28, label %merge29
then28:
  br label %merge29
merge29:
  %t139 = load double, double* %l3
  %s140 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.140, i32 0, i32 0
  %t141 = call i1 @identifier_matches(i8* null, i8* %s140)
  %t142 = load %Parser, %Parser* %l0
  %t143 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t144 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t145 = load double, double* %l3
  br i1 %t141, label %then30, label %merge31
then30:
  %t146 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t147 = load { i8**, i64 }, { i8**, i64 }* %t146
  %t148 = extractvalue { i8**, i64 } %t147, 1
  %t149 = icmp sgt i64 %t148, 0
  %t150 = load %Parser, %Parser* %l0
  %t151 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t152 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t153 = load double, double* %l3
  br i1 %t149, label %then32, label %merge33
then32:
  %t154 = load %Parser, %Parser* %l0
  %t155 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t156 = insertvalue %BlockStatementParseResult %t155, i8* null, 1
  %t157 = insertvalue %BlockStatementParseResult %t156, i1 0, 2
  ret %StatementParseResult zeroinitializer
merge33:
  ret %StatementParseResult zeroinitializer
merge31:
  %t158 = load double, double* %l3
  %s159 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.159, i32 0, i32 0
  %t160 = call i1 @identifier_matches(i8* null, i8* %s159)
  %t161 = load %Parser, %Parser* %l0
  %t162 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t163 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t164 = load double, double* %l3
  br i1 %t160, label %then34, label %merge35
then34:
  %t165 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t166 = load { i8**, i64 }, { i8**, i64 }* %t165
  %t167 = extractvalue { i8**, i64 } %t166, 1
  %t168 = icmp sgt i64 %t167, 0
  %t169 = load %Parser, %Parser* %l0
  %t170 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t171 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t172 = load double, double* %l3
  br i1 %t168, label %then36, label %merge37
then36:
  %t173 = load %Parser, %Parser* %l0
  %t174 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t175 = insertvalue %BlockStatementParseResult %t174, i8* null, 1
  %t176 = insertvalue %BlockStatementParseResult %t175, i1 0, 2
  ret %StatementParseResult zeroinitializer
merge37:
  ret %StatementParseResult zeroinitializer
merge35:
  store double 0.0, double* %l4
  %t177 = load double, double* %l4
  %s178 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.178, i32 0, i32 0
  %t179 = call i1 @identifier_matches(i8* null, i8* %s178)
  %t180 = load %Parser, %Parser* %l0
  %t181 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t182 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t183 = load double, double* %l3
  %t184 = load double, double* %l4
  br i1 %t179, label %then38, label %merge39
then38:
  %t185 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t186 = call %StatementParseResult @parse_function(%Parser %parser, i1 1, { i8**, i64 }* %t185)
  ret %StatementParseResult %t186
merge39:
  br label %merge27
merge27:
  %t187 = load double, double* %l3
  %s188 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.188, i32 0, i32 0
  %t189 = call i1 @identifier_matches(i8* null, i8* %s188)
  %t190 = load %Parser, %Parser* %l0
  %t191 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t192 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t193 = load double, double* %l3
  br i1 %t189, label %then40, label %merge41
then40:
  %t194 = call %StatementParseResult @parse_import(%Parser %parser)
  ret %StatementParseResult %t194
merge41:
  %t195 = load double, double* %l3
  %s196 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.196, i32 0, i32 0
  %t197 = call i1 @identifier_matches(i8* null, i8* %s196)
  %t198 = load %Parser, %Parser* %l0
  %t199 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t200 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t201 = load double, double* %l3
  br i1 %t197, label %then42, label %merge43
then42:
  %t202 = call %StatementParseResult @parse_export(%Parser %parser)
  ret %StatementParseResult %t202
merge43:
  %t203 = load double, double* %l3
  %s204 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.204, i32 0, i32 0
  %t205 = call i1 @identifier_matches(i8* null, i8* %s204)
  %t206 = load %Parser, %Parser* %l0
  %t207 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t208 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t209 = load double, double* %l3
  br i1 %t205, label %then44, label %merge45
then44:
  %t210 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t211 = call %StatementParseResult @parse_struct(%Parser %parser, { i8**, i64 }* %t210)
  ret %StatementParseResult %t211
merge45:
  %t212 = load double, double* %l3
  %s213 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.213, i32 0, i32 0
  %t214 = call i1 @identifier_matches(i8* null, i8* %s213)
  %t215 = load %Parser, %Parser* %l0
  %t216 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t217 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t218 = load double, double* %l3
  br i1 %t214, label %then46, label %merge47
then46:
  %t219 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t220 = call %StatementParseResult @parse_type_alias(%Parser %parser, { i8**, i64 }* %t219)
  ret %StatementParseResult %t220
merge47:
  %t221 = load double, double* %l3
  %s222 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.222, i32 0, i32 0
  %t223 = call i1 @identifier_matches(i8* null, i8* %s222)
  %t224 = load %Parser, %Parser* %l0
  %t225 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t226 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t227 = load double, double* %l3
  br i1 %t223, label %then48, label %merge49
then48:
  %t228 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t229 = call %StatementParseResult @parse_interface(%Parser %parser, { i8**, i64 }* %t228)
  ret %StatementParseResult %t229
merge49:
  %t230 = load double, double* %l3
  %s231 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.231, i32 0, i32 0
  %t232 = call i1 @identifier_matches(i8* null, i8* %s231)
  %t233 = load %Parser, %Parser* %l0
  %t234 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t235 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t236 = load double, double* %l3
  br i1 %t232, label %then50, label %merge51
then50:
  %t237 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t238 = call %StatementParseResult @parse_enum(%Parser %parser, { i8**, i64 }* %t237)
  ret %StatementParseResult %t238
merge51:
  %t239 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t240 = load { i8**, i64 }, { i8**, i64 }* %t239
  %t241 = extractvalue { i8**, i64 } %t240, 1
  %t242 = icmp sgt i64 %t241, 0
  %t243 = load %Parser, %Parser* %l0
  %t244 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t245 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t246 = load double, double* %l3
  br i1 %t242, label %then52, label %merge53
then52:
  %t247 = load %Parser, %Parser* %l0
  %t248 = call %StatementParseResult @parse_unknown(%Parser %t247)
  ret %StatementParseResult %t248
merge53:
  %t249 = call %StatementParseResult @parse_unknown(%Parser %parser)
  ret %StatementParseResult %t249
}

define %StatementParseResult @parse_import(%Parser %parser) {
entry:
  %l0 = alloca %SpecifierListParseResult
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca %CaptureResult
  %l3 = alloca i8*
  %l4 = alloca double
  %t0 = call %SpecifierListParseResult @parse_specifier_list(%Parser %parser)
  store %SpecifierListParseResult %t0, %SpecifierListParseResult* %l0
  %t1 = load %SpecifierListParseResult, %SpecifierListParseResult* %l0
  %t2 = extractvalue %SpecifierListParseResult %t1, 1
  %t3 = call { i8**, i64 }* @build_import_specifiers({ %NamedSpecifier*, i64 }* null)
  store { i8**, i64 }* %t3, { i8**, i64 }** %l1
  %s4 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.4, i32 0, i32 0
  %t5 = alloca [1 x i8*]
  %t6 = getelementptr [1 x i8*], [1 x i8*]* %t5, i32 0, i32 0
  %t7 = getelementptr i8*, i8** %t6, i64 0
  store i8* %s4, i8** %t7
  %t8 = alloca { i8**, i64 }
  %t9 = getelementptr { i8**, i64 }, { i8**, i64 }* %t8, i32 0, i32 0
  store i8** %t6, i8*** %t9
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* %t8, i32 0, i32 1
  store i64 1, i64* %t10
  %t11 = call %CaptureResult @collect_until(%Parser %parser, { i8**, i64 }* %t8)
  store %CaptureResult %t11, %CaptureResult* %l2
  %t12 = load %CaptureResult, %CaptureResult* %l2
  %t13 = extractvalue %CaptureResult %t12, 1
  %t14 = call i8* @tokens_to_text({ i8**, i64 }* %t13)
  %t15 = call i8* @trim_text(i8* %t14)
  store i8* %t15, i8** %l3
  %t16 = load i8*, i8** %l3
  %t17 = call i8* @strip_surrounding_quotes(i8* %t16)
  store i8* %t17, i8** %l3
  %t19 = call double @parser_peek_raw(%Parser %parser)
  store double 0.0, double* %l4
  %t20 = insertvalue %StatementParseResult undef, i8* null, 0
  %t21 = load double, double* %l4
  %t22 = insertvalue %StatementParseResult %t20, i8* null, 1
  ret %StatementParseResult %t22
}

define %StatementParseResult @parse_export(%Parser %parser) {
entry:
  %l0 = alloca %SpecifierListParseResult
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca %CaptureResult
  %l3 = alloca i8*
  %l4 = alloca double
  %t0 = call %SpecifierListParseResult @parse_specifier_list(%Parser %parser)
  store %SpecifierListParseResult %t0, %SpecifierListParseResult* %l0
  %t1 = load %SpecifierListParseResult, %SpecifierListParseResult* %l0
  %t2 = extractvalue %SpecifierListParseResult %t1, 1
  %t3 = call { i8**, i64 }* @build_export_specifiers({ %NamedSpecifier*, i64 }* null)
  store { i8**, i64 }* %t3, { i8**, i64 }** %l1
  %s4 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.4, i32 0, i32 0
  %t5 = alloca [1 x i8*]
  %t6 = getelementptr [1 x i8*], [1 x i8*]* %t5, i32 0, i32 0
  %t7 = getelementptr i8*, i8** %t6, i64 0
  store i8* %s4, i8** %t7
  %t8 = alloca { i8**, i64 }
  %t9 = getelementptr { i8**, i64 }, { i8**, i64 }* %t8, i32 0, i32 0
  store i8** %t6, i8*** %t9
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* %t8, i32 0, i32 1
  store i64 1, i64* %t10
  %t11 = call %CaptureResult @collect_until(%Parser %parser, { i8**, i64 }* %t8)
  store %CaptureResult %t11, %CaptureResult* %l2
  %t12 = load %CaptureResult, %CaptureResult* %l2
  %t13 = extractvalue %CaptureResult %t12, 1
  %t14 = call i8* @tokens_to_text({ i8**, i64 }* %t13)
  %t15 = call i8* @trim_text(i8* %t14)
  store i8* %t15, i8** %l3
  %t16 = load i8*, i8** %l3
  %t17 = call i8* @strip_surrounding_quotes(i8* %t16)
  store i8* %t17, i8** %l3
  %t19 = call double @parser_peek_raw(%Parser %parser)
  store double 0.0, double* %l4
  %t20 = insertvalue %StatementParseResult undef, i8* null, 0
  %t21 = load double, double* %l4
  %t22 = insertvalue %StatementParseResult %t20, i8* null, 1
  ret %StatementParseResult %t22
}

define %StatementParseResult @parse_variable(%Parser %parser) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca i1
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca i8*
  %l6 = alloca i8*
  %l7 = alloca double
  %l8 = alloca i8*
  %l9 = alloca i8*
  %l10 = alloca double
  %l11 = alloca double
  %l12 = alloca double
  %l13 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = call double @parser_peek_raw(%Parser %parser)
  store double %t5, double* %l1
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load double, double* %l1
  %t8 = call { i8**, i64 }* @append_token({ i8**, i64 }* %t6, i8* null)
  store { i8**, i64 }* %t8, { i8**, i64 }** %l0
  store i1 0, i1* %l2
  %t9 = call double @parser_peek_raw(%Parser %parser)
  store double %t9, double* %l3
  %t10 = load double, double* %l3
  %s11 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.11, i32 0, i32 0
  %t12 = call i1 @identifier_matches(i8* null, i8* %s11)
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load double, double* %l1
  %t15 = load i1, i1* %l2
  %t16 = load double, double* %l3
  br i1 %t12, label %then0, label %merge1
then0:
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = load double, double* %l3
  %t19 = call { i8**, i64 }* @append_token({ i8**, i64 }* %t17, i8* null)
  store { i8**, i64 }* %t19, { i8**, i64 }** %l0
  store i1 1, i1* %l2
  br label %merge1
merge1:
  %t20 = phi { i8**, i64 }* [ %t19, %then0 ], [ %t13, %entry ]
  %t21 = phi i1 [ 1, %then0 ], [ %t15, %entry ]
  store { i8**, i64 }* %t20, { i8**, i64 }** %l0
  store i1 %t21, i1* %l2
  %t22 = call double @parser_peek_raw(%Parser %parser)
  store double %t22, double* %l4
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t24 = load double, double* %l4
  %t25 = call { i8**, i64 }* @append_token({ i8**, i64 }* %t23, i8* null)
  store { i8**, i64 }* %t25, { i8**, i64 }** %l0
  %t26 = load double, double* %l4
  %t27 = call i8* @identifier_text(i8* null)
  store i8* %t27, i8** %l5
  store i8* null, i8** %l6
  %t28 = call double @parser_peek_raw(%Parser %parser)
  store double %t28, double* %l7
  %t31 = load double, double* %l7
  store i8* null, i8** %l8
  store i8* null, i8** %l9
  %t32 = call double @parser_peek_raw(%Parser %parser)
  store double %t32, double* %l10
  %t34 = load double, double* %l10
  %t35 = call double @parser_peek_raw(%Parser %parser)
  store double %t35, double* %l11
  %t37 = load double, double* %l11
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t39 = call double @source_span_from_tokens({ i8**, i64 }* %t38)
  store double %t39, double* %l12
  store double 0.0, double* %l13
  %t40 = insertvalue %StatementParseResult undef, i8* null, 0
  %t41 = load double, double* %l13
  %t42 = insertvalue %StatementParseResult %t40, i8* null, 1
  ret %StatementParseResult %t42
}

define %SpecifierListParseResult @parse_specifier_list(%Parser %parser) {
entry:
  %l0 = alloca { %NamedSpecifier*, i64 }*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca i8*
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { %NamedSpecifier*, i64 }* null, { %NamedSpecifier*, i64 }** %l0
  %t5 = load { %NamedSpecifier*, i64 }*, { %NamedSpecifier*, i64 }** %l0
  br label %loop.header0
loop.header0:
  %t38 = phi { %NamedSpecifier*, i64 }* [ %t5, %entry ], [ %t37, %loop.latch2 ]
  store { %NamedSpecifier*, i64 }* %t38, { %NamedSpecifier*, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t6 = call double @parser_peek_raw(%Parser %parser)
  store double %t6, double* %l1
  %t8 = load double, double* %l1
  %t9 = load double, double* %l1
  %t10 = load double, double* %l1
  %t11 = call i8* @identifier_text(i8* null)
  store i8* %t11, i8** %l2
  store i8* null, i8** %l3
  %t12 = call double @parser_peek_raw(%Parser %parser)
  store double %t12, double* %l4
  %t13 = load double, double* %l4
  %s14 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.14, i32 0, i32 0
  %t15 = call i1 @identifier_matches(i8* null, i8* %s14)
  %t16 = load { %NamedSpecifier*, i64 }*, { %NamedSpecifier*, i64 }** %l0
  %t17 = load double, double* %l1
  %t18 = load i8*, i8** %l2
  %t19 = load i8*, i8** %l3
  %t20 = load double, double* %l4
  br i1 %t15, label %then4, label %merge5
then4:
  %t21 = call double @parser_peek_raw(%Parser %parser)
  store double %t21, double* %l5
  %t22 = load double, double* %l5
  br label %merge5
merge5:
  %t23 = load i8*, i8** %l2
  %t24 = insertvalue %NamedSpecifier undef, i8* %t23, 0
  %t25 = load i8*, i8** %l3
  %t26 = insertvalue %NamedSpecifier %t24, i8* %t25, 1
  %t27 = alloca [1 x %NamedSpecifier]
  %t28 = getelementptr [1 x %NamedSpecifier], [1 x %NamedSpecifier]* %t27, i32 0, i32 0
  %t29 = getelementptr %NamedSpecifier, %NamedSpecifier* %t28, i64 0
  store %NamedSpecifier %t26, %NamedSpecifier* %t29
  %t30 = alloca { %NamedSpecifier*, i64 }
  %t31 = getelementptr { %NamedSpecifier*, i64 }, { %NamedSpecifier*, i64 }* %t30, i32 0, i32 0
  store %NamedSpecifier* %t28, %NamedSpecifier** %t31
  %t32 = getelementptr { %NamedSpecifier*, i64 }, { %NamedSpecifier*, i64 }* %t30, i32 0, i32 1
  store i64 1, i64* %t32
  %t33 = call double @specifiersconcat({ %NamedSpecifier*, i64 }* %t30)
  store { %NamedSpecifier*, i64 }* null, { %NamedSpecifier*, i64 }** %l0
  %t34 = call double @parser_peek_raw(%Parser %parser)
  store double %t34, double* %l6
  %t36 = load double, double* %l6
  br label %loop.latch2
loop.latch2:
  %t37 = load { %NamedSpecifier*, i64 }*, { %NamedSpecifier*, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t40 = call double @parser_peek_raw(%Parser %parser)
  %t41 = insertvalue %SpecifierListParseResult undef, i8* null, 0
  %t42 = load { %NamedSpecifier*, i64 }*, { %NamedSpecifier*, i64 }** %l0
  %t43 = insertvalue %SpecifierListParseResult %t41, { i8**, i64 }* null, 1
  ret %SpecifierListParseResult %t43
}

define { i8**, i64 }* @build_import_specifiers({ %NamedSpecifier*, i64 }* %values) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca %NamedSpecifier
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t27 = phi { i8**, i64 }* [ %t6, %entry ], [ %t25, %loop.latch2 ]
  %t28 = phi double [ %t7, %entry ], [ %t26, %loop.latch2 ]
  store { i8**, i64 }* %t27, { i8**, i64 }** %l0
  store double %t28, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { %NamedSpecifier*, i64 }, { %NamedSpecifier*, i64 }* %values
  %t10 = extractvalue { %NamedSpecifier*, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l1
  %t16 = load { %NamedSpecifier*, i64 }, { %NamedSpecifier*, i64 }* %values
  %t17 = extractvalue { %NamedSpecifier*, i64 } %t16, 0
  %t18 = extractvalue { %NamedSpecifier*, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  %t20 = getelementptr %NamedSpecifier, %NamedSpecifier* %t17, i64 %t15
  %t21 = load %NamedSpecifier, %NamedSpecifier* %t20
  store %NamedSpecifier %t21, %NamedSpecifier* %l2
  %t22 = load double, double* %l1
  %t23 = sitofp i64 1 to double
  %t24 = fadd double %t22, %t23
  store double %t24, double* %l1
  br label %loop.latch2
loop.latch2:
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t26 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t29
}

define { i8**, i64 }* @build_export_specifiers({ %NamedSpecifier*, i64 }* %values) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca %NamedSpecifier
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t27 = phi { i8**, i64 }* [ %t6, %entry ], [ %t25, %loop.latch2 ]
  %t28 = phi double [ %t7, %entry ], [ %t26, %loop.latch2 ]
  store { i8**, i64 }* %t27, { i8**, i64 }** %l0
  store double %t28, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { %NamedSpecifier*, i64 }, { %NamedSpecifier*, i64 }* %values
  %t10 = extractvalue { %NamedSpecifier*, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l1
  %t16 = load { %NamedSpecifier*, i64 }, { %NamedSpecifier*, i64 }* %values
  %t17 = extractvalue { %NamedSpecifier*, i64 } %t16, 0
  %t18 = extractvalue { %NamedSpecifier*, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  %t20 = getelementptr %NamedSpecifier, %NamedSpecifier* %t17, i64 %t15
  %t21 = load %NamedSpecifier, %NamedSpecifier* %t20
  store %NamedSpecifier %t21, %NamedSpecifier* %l2
  %t22 = load double, double* %l1
  %t23 = sitofp i64 1 to double
  %t24 = fadd double %t22, %t23
  store double %t24, double* %l1
  br label %loop.latch2
loop.latch2:
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t26 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t29
}

define %StatementParseResult @parse_struct(%Parser %parser, { i8**, i64 }* %decorators) {
entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca %TypeParameterParseResult
  %l4 = alloca { i8**, i64 }*
  %l5 = alloca %ImplementsParseResult
  %l6 = alloca { i8**, i64 }*
  %l7 = alloca { i8**, i64 }*
  %l8 = alloca { i8**, i64 }*
  %l9 = alloca %Parser
  %l10 = alloca %DecoratorParseResult
  %l11 = alloca { i8**, i64 }*
  %l12 = alloca double
  %l13 = alloca %StructFieldParseResult
  %l14 = alloca %MethodParseResult
  %l15 = alloca double
  %t0 = call double @parser_peek_raw(%Parser %parser)
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  %t2 = call i8* @identifier_text(i8* null)
  store i8* %t2, i8** %l1
  %t3 = load double, double* %l0
  %t4 = alloca [1 x double]
  %t5 = getelementptr [1 x double], [1 x double]* %t4, i32 0, i32 0
  %t6 = getelementptr double, double* %t5, i64 0
  store double %t3, double* %t6
  %t7 = alloca { double*, i64 }
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 0
  store double* %t5, double** %t8
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 1
  store i64 1, i64* %t9
  %t10 = call double @source_span_from_tokens({ i8**, i64 }* null)
  store double %t10, double* %l2
  %t11 = call %TypeParameterParseResult @parse_type_parameter_clause(%Parser %parser)
  store %TypeParameterParseResult %t11, %TypeParameterParseResult* %l3
  %t12 = load %TypeParameterParseResult, %TypeParameterParseResult* %l3
  %t13 = extractvalue %TypeParameterParseResult %t12, 1
  store { i8**, i64 }* %t13, { i8**, i64 }** %l4
  %t14 = call %ImplementsParseResult @parse_implements_clause(%Parser %parser)
  store %ImplementsParseResult %t14, %ImplementsParseResult* %l5
  %t15 = load %ImplementsParseResult, %ImplementsParseResult* %l5
  %t16 = extractvalue %ImplementsParseResult %t15, 1
  store { i8**, i64 }* %t16, { i8**, i64 }** %l6
  %t17 = alloca [0 x double]
  %t18 = getelementptr [0 x double], [0 x double]* %t17, i32 0, i32 0
  %t19 = alloca { double*, i64 }
  %t20 = getelementptr { double*, i64 }, { double*, i64 }* %t19, i32 0, i32 0
  store double* %t18, double** %t20
  %t21 = getelementptr { double*, i64 }, { double*, i64 }* %t19, i32 0, i32 1
  store i64 0, i64* %t21
  store { i8**, i64 }* null, { i8**, i64 }** %l7
  %t22 = alloca [0 x double]
  %t23 = getelementptr [0 x double], [0 x double]* %t22, i32 0, i32 0
  %t24 = alloca { double*, i64 }
  %t25 = getelementptr { double*, i64 }, { double*, i64 }* %t24, i32 0, i32 0
  store double* %t23, double** %t25
  %t26 = getelementptr { double*, i64 }, { double*, i64 }* %t24, i32 0, i32 1
  store i64 0, i64* %t26
  store { i8**, i64 }* null, { i8**, i64 }** %l8
  %t27 = load double, double* %l0
  %t28 = load i8*, i8** %l1
  %t29 = load double, double* %l2
  %t30 = load %TypeParameterParseResult, %TypeParameterParseResult* %l3
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t32 = load %ImplementsParseResult, %ImplementsParseResult* %l5
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l8
  br label %loop.header0
loop.header0:
  %t132 = phi { i8**, i64 }* [ %t34, %entry ], [ %t130, %loop.latch2 ]
  %t133 = phi { i8**, i64 }* [ %t35, %entry ], [ %t131, %loop.latch2 ]
  store { i8**, i64 }* %t132, { i8**, i64 }** %l7
  store { i8**, i64 }* %t133, { i8**, i64 }** %l8
  br label %loop.body1
loop.body1:
  store %Parser %parser, %Parser* %l9
  %t36 = call %DecoratorParseResult @parse_decorators(%Parser %parser)
  store %DecoratorParseResult %t36, %DecoratorParseResult* %l10
  %t37 = load %DecoratorParseResult, %DecoratorParseResult* %l10
  %t38 = extractvalue %DecoratorParseResult %t37, 1
  store { i8**, i64 }* %t38, { i8**, i64 }** %l11
  %t39 = call double @parser_peek_raw(%Parser %parser)
  store double %t39, double* %l12
  %t41 = load double, double* %l12
  %t42 = load double, double* %l12
  %t43 = call %StructFieldParseResult @parse_struct_field(%Parser %parser)
  store %StructFieldParseResult %t43, %StructFieldParseResult* %l13
  %t45 = load %StructFieldParseResult, %StructFieldParseResult* %l13
  %t46 = extractvalue %StructFieldParseResult %t45, 2
  br label %logical_and_entry_44

logical_and_entry_44:
  br i1 %t46, label %logical_and_right_44, label %logical_and_merge_44

logical_and_right_44:
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %t48 = load { i8**, i64 }, { i8**, i64 }* %t47
  %t49 = extractvalue { i8**, i64 } %t48, 1
  %t50 = icmp eq i64 %t49, 0
  br label %logical_and_right_end_44

logical_and_right_end_44:
  br label %logical_and_merge_44

logical_and_merge_44:
  %t51 = phi i1 [ false, %logical_and_entry_44 ], [ %t50, %logical_and_right_end_44 ]
  %t52 = load double, double* %l0
  %t53 = load i8*, i8** %l1
  %t54 = load double, double* %l2
  %t55 = load %TypeParameterParseResult, %TypeParameterParseResult* %l3
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t57 = load %ImplementsParseResult, %ImplementsParseResult* %l5
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t61 = load %Parser, %Parser* %l9
  %t62 = load %DecoratorParseResult, %DecoratorParseResult* %l10
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %t64 = load double, double* %l12
  %t65 = load %StructFieldParseResult, %StructFieldParseResult* %l13
  br i1 %t51, label %then4, label %merge5
then4:
  %t66 = load %StructFieldParseResult, %StructFieldParseResult* %l13
  %t67 = extractvalue %StructFieldParseResult %t66, 1
  %t68 = icmp ne i8* %t67, null
  %t69 = load double, double* %l0
  %t70 = load i8*, i8** %l1
  %t71 = load double, double* %l2
  %t72 = load %TypeParameterParseResult, %TypeParameterParseResult* %l3
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t74 = load %ImplementsParseResult, %ImplementsParseResult* %l5
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t77 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t78 = load %Parser, %Parser* %l9
  %t79 = load %DecoratorParseResult, %DecoratorParseResult* %l10
  %t80 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %t81 = load double, double* %l12
  %t82 = load %StructFieldParseResult, %StructFieldParseResult* %l13
  br i1 %t68, label %then6, label %merge7
then6:
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t84 = load %StructFieldParseResult, %StructFieldParseResult* %l13
  %t85 = extractvalue %StructFieldParseResult %t84, 1
  %t86 = call { i8**, i64 }* @append_field({ i8**, i64 }* %t83, i8* %t85)
  store { i8**, i64 }* %t86, { i8**, i64 }** %l7
  br label %merge7
merge7:
  %t87 = phi { i8**, i64 }* [ %t86, %then6 ], [ %t76, %then4 ]
  store { i8**, i64 }* %t87, { i8**, i64 }** %l7
  br label %loop.latch2
merge5:
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %t89 = call %MethodParseResult @parse_struct_method(%Parser %parser, { i8**, i64 }* %t88)
  store %MethodParseResult %t89, %MethodParseResult* %l14
  %t90 = load %MethodParseResult, %MethodParseResult* %l14
  %t91 = extractvalue %MethodParseResult %t90, 2
  %t92 = load double, double* %l0
  %t93 = load i8*, i8** %l1
  %t94 = load double, double* %l2
  %t95 = load %TypeParameterParseResult, %TypeParameterParseResult* %l3
  %t96 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t97 = load %ImplementsParseResult, %ImplementsParseResult* %l5
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t101 = load %Parser, %Parser* %l9
  %t102 = load %DecoratorParseResult, %DecoratorParseResult* %l10
  %t103 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %t104 = load double, double* %l12
  %t105 = load %StructFieldParseResult, %StructFieldParseResult* %l13
  %t106 = load %MethodParseResult, %MethodParseResult* %l14
  br i1 %t91, label %then8, label %merge9
then8:
  %t107 = load %MethodParseResult, %MethodParseResult* %l14
  %t108 = extractvalue %MethodParseResult %t107, 1
  %t109 = icmp ne i8* %t108, null
  %t110 = load double, double* %l0
  %t111 = load i8*, i8** %l1
  %t112 = load double, double* %l2
  %t113 = load %TypeParameterParseResult, %TypeParameterParseResult* %l3
  %t114 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t115 = load %ImplementsParseResult, %ImplementsParseResult* %l5
  %t116 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t117 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t118 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t119 = load %Parser, %Parser* %l9
  %t120 = load %DecoratorParseResult, %DecoratorParseResult* %l10
  %t121 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %t122 = load double, double* %l12
  %t123 = load %StructFieldParseResult, %StructFieldParseResult* %l13
  %t124 = load %MethodParseResult, %MethodParseResult* %l14
  br i1 %t109, label %then10, label %merge11
then10:
  %t125 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t126 = load %MethodParseResult, %MethodParseResult* %l14
  %t127 = extractvalue %MethodParseResult %t126, 1
  %t128 = call { i8**, i64 }* @append_method({ i8**, i64 }* %t125, i8* %t127)
  store { i8**, i64 }* %t128, { i8**, i64 }** %l8
  br label %merge11
merge11:
  %t129 = phi { i8**, i64 }* [ %t128, %then10 ], [ %t118, %then8 ]
  store { i8**, i64 }* %t129, { i8**, i64 }** %l8
  br label %loop.latch2
merge9:
  br label %loop.latch2
loop.latch2:
  %t130 = load { i8**, i64 }*, { i8**, i64 }** %l7
  %t131 = load { i8**, i64 }*, { i8**, i64 }** %l8
  br label %loop.header0
afterloop3:
  store double 0.0, double* %l15
  %t134 = insertvalue %StatementParseResult undef, i8* null, 0
  %t135 = load double, double* %l15
  %t136 = insertvalue %StatementParseResult %t134, i8* null, 1
  ret %StatementParseResult %t136
}

define %StatementParseResult @parse_type_alias(%Parser %parser, { i8**, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca %TypeParameterParseResult
  %l5 = alloca { i8**, i64 }*
  %l6 = alloca double
  %l7 = alloca %CaptureResult
  %l8 = alloca i8*
  %l9 = alloca double
  %l10 = alloca double
  store %Parser %parser, %Parser* %l0
  %t0 = call double @parser_peek_raw(%Parser %parser)
  store double %t0, double* %l1
  %t1 = load double, double* %l1
  %t2 = load double, double* %l1
  %t3 = call i8* @identifier_text(i8* null)
  store i8* %t3, i8** %l2
  %t4 = load double, double* %l1
  %t5 = alloca [1 x double]
  %t6 = getelementptr [1 x double], [1 x double]* %t5, i32 0, i32 0
  %t7 = getelementptr double, double* %t6, i64 0
  store double %t4, double* %t7
  %t8 = alloca { double*, i64 }
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t8, i32 0, i32 0
  store double* %t6, double** %t9
  %t10 = getelementptr { double*, i64 }, { double*, i64 }* %t8, i32 0, i32 1
  store i64 1, i64* %t10
  %t11 = call double @source_span_from_tokens({ i8**, i64 }* null)
  store double %t11, double* %l3
  %t12 = call %TypeParameterParseResult @parse_type_parameter_clause(%Parser %parser)
  store %TypeParameterParseResult %t12, %TypeParameterParseResult* %l4
  %t13 = load %TypeParameterParseResult, %TypeParameterParseResult* %l4
  %t14 = extractvalue %TypeParameterParseResult %t13, 1
  store { i8**, i64 }* %t14, { i8**, i64 }** %l5
  %t15 = call double @parser_peek_raw(%Parser %parser)
  store double %t15, double* %l6
  %t17 = load double, double* %l6
  %t18 = call %Parser @skip_trivia(%Parser %parser)
  %s19 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.19, i32 0, i32 0
  %t20 = alloca [1 x i8*]
  %t21 = getelementptr [1 x i8*], [1 x i8*]* %t20, i32 0, i32 0
  %t22 = getelementptr i8*, i8** %t21, i64 0
  store i8* %s19, i8** %t22
  %t23 = alloca { i8**, i64 }
  %t24 = getelementptr { i8**, i64 }, { i8**, i64 }* %t23, i32 0, i32 0
  store i8** %t21, i8*** %t24
  %t25 = getelementptr { i8**, i64 }, { i8**, i64 }* %t23, i32 0, i32 1
  store i64 1, i64* %t25
  %t26 = call %CaptureResult @collect_until(%Parser %t18, { i8**, i64 }* %t23)
  store %CaptureResult %t26, %CaptureResult* %l7
  %t27 = load %CaptureResult, %CaptureResult* %l7
  %t28 = extractvalue %CaptureResult %t27, 1
  %t29 = call i8* @tokens_to_text({ i8**, i64 }* %t28)
  %t30 = call i8* @trim_text(i8* %t29)
  store i8* %t30, i8** %l8
  %t31 = load i8*, i8** %l8
  store double 0.0, double* %l9
  %t33 = call double @parser_peek_raw(%Parser %parser)
  store double 0.0, double* %l10
  %t34 = insertvalue %StatementParseResult undef, i8* null, 0
  %t35 = load double, double* %l10
  %t36 = insertvalue %StatementParseResult %t34, i8* null, 1
  ret %StatementParseResult %t36
}

define %StatementParseResult @parse_interface(%Parser %parser, { i8**, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca %TypeParameterParseResult
  %l5 = alloca { i8**, i64 }*
  %l6 = alloca { i8**, i64 }*
  %l7 = alloca double
  %l8 = alloca %Parser
  %l9 = alloca %DecoratorParseResult
  %l10 = alloca { i8**, i64 }*
  %l11 = alloca %InterfaceMemberParseResult
  %l12 = alloca double
  store %Parser %parser, %Parser* %l0
  %t0 = call double @parser_peek_raw(%Parser %parser)
  store double %t0, double* %l1
  %t1 = load double, double* %l1
  %t2 = load double, double* %l1
  %t3 = call i8* @identifier_text(i8* null)
  store i8* %t3, i8** %l2
  %t4 = load double, double* %l1
  %t5 = alloca [1 x double]
  %t6 = getelementptr [1 x double], [1 x double]* %t5, i32 0, i32 0
  %t7 = getelementptr double, double* %t6, i64 0
  store double %t4, double* %t7
  %t8 = alloca { double*, i64 }
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t8, i32 0, i32 0
  store double* %t6, double** %t9
  %t10 = getelementptr { double*, i64 }, { double*, i64 }* %t8, i32 0, i32 1
  store i64 1, i64* %t10
  %t11 = call double @source_span_from_tokens({ i8**, i64 }* null)
  store double %t11, double* %l3
  %t12 = call %TypeParameterParseResult @parse_type_parameter_clause(%Parser %parser)
  store %TypeParameterParseResult %t12, %TypeParameterParseResult* %l4
  %t13 = load %TypeParameterParseResult, %TypeParameterParseResult* %l4
  %t14 = extractvalue %TypeParameterParseResult %t13, 1
  store { i8**, i64 }* %t14, { i8**, i64 }** %l5
  %t15 = alloca [0 x double]
  %t16 = getelementptr [0 x double], [0 x double]* %t15, i32 0, i32 0
  %t17 = alloca { double*, i64 }
  %t18 = getelementptr { double*, i64 }, { double*, i64 }* %t17, i32 0, i32 0
  store double* %t16, double** %t18
  %t19 = getelementptr { double*, i64 }, { double*, i64 }* %t17, i32 0, i32 1
  store i64 0, i64* %t19
  store { i8**, i64 }* null, { i8**, i64 }** %l6
  %t20 = load %Parser, %Parser* %l0
  %t21 = load double, double* %l1
  %t22 = load i8*, i8** %l2
  %t23 = load double, double* %l3
  %t24 = load %TypeParameterParseResult, %TypeParameterParseResult* %l4
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l6
  br label %loop.header0
loop.header0:
  %t71 = phi { i8**, i64 }* [ %t26, %entry ], [ %t70, %loop.latch2 ]
  store { i8**, i64 }* %t71, { i8**, i64 }** %l6
  br label %loop.body1
loop.body1:
  %t27 = call double @parser_peek_raw(%Parser %parser)
  store double %t27, double* %l7
  %t29 = load double, double* %l7
  %t30 = load double, double* %l7
  store %Parser %parser, %Parser* %l8
  %t31 = call %DecoratorParseResult @parse_decorators(%Parser %parser)
  store %DecoratorParseResult %t31, %DecoratorParseResult* %l9
  %t32 = load %DecoratorParseResult, %DecoratorParseResult* %l9
  %t33 = extractvalue %DecoratorParseResult %t32, 1
  store { i8**, i64 }* %t33, { i8**, i64 }** %l10
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t35 = call %InterfaceMemberParseResult @parse_interface_member(%Parser %parser, { i8**, i64 }* %t34)
  store %InterfaceMemberParseResult %t35, %InterfaceMemberParseResult* %l11
  %t36 = load %InterfaceMemberParseResult, %InterfaceMemberParseResult* %l11
  %t37 = extractvalue %InterfaceMemberParseResult %t36, 2
  %t38 = load %Parser, %Parser* %l0
  %t39 = load double, double* %l1
  %t40 = load i8*, i8** %l2
  %t41 = load double, double* %l3
  %t42 = load %TypeParameterParseResult, %TypeParameterParseResult* %l4
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t45 = load double, double* %l7
  %t46 = load %Parser, %Parser* %l8
  %t47 = load %DecoratorParseResult, %DecoratorParseResult* %l9
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t49 = load %InterfaceMemberParseResult, %InterfaceMemberParseResult* %l11
  br i1 %t37, label %then4, label %merge5
then4:
  %t50 = load %InterfaceMemberParseResult, %InterfaceMemberParseResult* %l11
  %t51 = extractvalue %InterfaceMemberParseResult %t50, 1
  %t52 = icmp ne i8* %t51, null
  %t53 = load %Parser, %Parser* %l0
  %t54 = load double, double* %l1
  %t55 = load i8*, i8** %l2
  %t56 = load double, double* %l3
  %t57 = load %TypeParameterParseResult, %TypeParameterParseResult* %l4
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t60 = load double, double* %l7
  %t61 = load %Parser, %Parser* %l8
  %t62 = load %DecoratorParseResult, %DecoratorParseResult* %l9
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t64 = load %InterfaceMemberParseResult, %InterfaceMemberParseResult* %l11
  br i1 %t52, label %then6, label %merge7
then6:
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t66 = load %InterfaceMemberParseResult, %InterfaceMemberParseResult* %l11
  %t67 = extractvalue %InterfaceMemberParseResult %t66, 1
  %t68 = call { i8**, i64 }* @append_signature({ i8**, i64 }* %t65, i8* %t67)
  store { i8**, i64 }* %t68, { i8**, i64 }** %l6
  br label %merge7
merge7:
  %t69 = phi { i8**, i64 }* [ %t68, %then6 ], [ %t59, %then4 ]
  store { i8**, i64 }* %t69, { i8**, i64 }** %l6
  br label %loop.latch2
merge5:
  br label %loop.latch2
loop.latch2:
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l6
  br label %loop.header0
afterloop3:
  store double 0.0, double* %l12
  %t72 = insertvalue %StatementParseResult undef, i8* null, 0
  %t73 = load double, double* %l12
  %t74 = insertvalue %StatementParseResult %t72, i8* null, 1
  ret %StatementParseResult %t74
}

define %StatementParseResult @parse_enum(%Parser %parser, { i8**, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca %TypeParameterParseResult
  %l5 = alloca { i8**, i64 }*
  %l6 = alloca { i8**, i64 }*
  %l7 = alloca double
  %l8 = alloca %EnumVariantParseResult
  %l9 = alloca double
  store %Parser %parser, %Parser* %l0
  %t0 = call double @parser_peek_raw(%Parser %parser)
  store double %t0, double* %l1
  %t1 = load double, double* %l1
  %t2 = load double, double* %l1
  %t3 = call i8* @identifier_text(i8* null)
  store i8* %t3, i8** %l2
  %t4 = load double, double* %l1
  %t5 = alloca [1 x double]
  %t6 = getelementptr [1 x double], [1 x double]* %t5, i32 0, i32 0
  %t7 = getelementptr double, double* %t6, i64 0
  store double %t4, double* %t7
  %t8 = alloca { double*, i64 }
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t8, i32 0, i32 0
  store double* %t6, double** %t9
  %t10 = getelementptr { double*, i64 }, { double*, i64 }* %t8, i32 0, i32 1
  store i64 1, i64* %t10
  %t11 = call double @source_span_from_tokens({ i8**, i64 }* null)
  store double %t11, double* %l3
  %t12 = call %TypeParameterParseResult @parse_type_parameter_clause(%Parser %parser)
  store %TypeParameterParseResult %t12, %TypeParameterParseResult* %l4
  %t13 = load %TypeParameterParseResult, %TypeParameterParseResult* %l4
  %t14 = extractvalue %TypeParameterParseResult %t13, 1
  store { i8**, i64 }* %t14, { i8**, i64 }** %l5
  %t15 = alloca [0 x double]
  %t16 = getelementptr [0 x double], [0 x double]* %t15, i32 0, i32 0
  %t17 = alloca { double*, i64 }
  %t18 = getelementptr { double*, i64 }, { double*, i64 }* %t17, i32 0, i32 0
  store double* %t16, double** %t18
  %t19 = getelementptr { double*, i64 }, { double*, i64 }* %t17, i32 0, i32 1
  store i64 0, i64* %t19
  store { i8**, i64 }* null, { i8**, i64 }** %l6
  %t20 = load %Parser, %Parser* %l0
  %t21 = load double, double* %l1
  %t22 = load i8*, i8** %l2
  %t23 = load double, double* %l3
  %t24 = load %TypeParameterParseResult, %TypeParameterParseResult* %l4
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l6
  br label %loop.header0
loop.header0:
  %t61 = phi { i8**, i64 }* [ %t26, %entry ], [ %t60, %loop.latch2 ]
  store { i8**, i64 }* %t61, { i8**, i64 }** %l6
  br label %loop.body1
loop.body1:
  %t27 = call double @parser_peek_raw(%Parser %parser)
  store double %t27, double* %l7
  %t29 = load double, double* %l7
  %t30 = load double, double* %l7
  %t31 = call %EnumVariantParseResult @parse_enum_variant(%Parser %parser)
  store %EnumVariantParseResult %t31, %EnumVariantParseResult* %l8
  %t32 = load %EnumVariantParseResult, %EnumVariantParseResult* %l8
  %t33 = extractvalue %EnumVariantParseResult %t32, 2
  %t34 = load %Parser, %Parser* %l0
  %t35 = load double, double* %l1
  %t36 = load i8*, i8** %l2
  %t37 = load double, double* %l3
  %t38 = load %TypeParameterParseResult, %TypeParameterParseResult* %l4
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t41 = load double, double* %l7
  %t42 = load %EnumVariantParseResult, %EnumVariantParseResult* %l8
  br i1 %t33, label %then4, label %merge5
then4:
  %t43 = load %EnumVariantParseResult, %EnumVariantParseResult* %l8
  %t44 = extractvalue %EnumVariantParseResult %t43, 1
  %t45 = icmp ne i8* %t44, null
  %t46 = load %Parser, %Parser* %l0
  %t47 = load double, double* %l1
  %t48 = load i8*, i8** %l2
  %t49 = load double, double* %l3
  %t50 = load %TypeParameterParseResult, %TypeParameterParseResult* %l4
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t53 = load double, double* %l7
  %t54 = load %EnumVariantParseResult, %EnumVariantParseResult* %l8
  br i1 %t45, label %then6, label %merge7
then6:
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t56 = load %EnumVariantParseResult, %EnumVariantParseResult* %l8
  %t57 = extractvalue %EnumVariantParseResult %t56, 1
  %t58 = call { i8**, i64 }* @append_enum_variant({ i8**, i64 }* %t55, i8* %t57)
  store { i8**, i64 }* %t58, { i8**, i64 }** %l6
  br label %merge7
merge7:
  %t59 = phi { i8**, i64 }* [ %t58, %then6 ], [ %t52, %then4 ]
  store { i8**, i64 }* %t59, { i8**, i64 }** %l6
  br label %loop.latch2
merge5:
  br label %loop.latch2
loop.latch2:
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l6
  br label %loop.header0
afterloop3:
  store double 0.0, double* %l9
  %t62 = insertvalue %StatementParseResult undef, i8* null, 0
  %t63 = load double, double* %l9
  %t64 = insertvalue %StatementParseResult %t62, i8* null, 1
  ret %StatementParseResult %t64
}

define %InterfaceMemberParseResult @parse_interface_member(%Parser %parser, { i8**, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca i1
  %l3 = alloca double
  %l4 = alloca %Parser
  %l5 = alloca double
  %l6 = alloca i8*
  %l7 = alloca double
  %l8 = alloca %TypeParameterParseResult
  %l9 = alloca { i8**, i64 }*
  %l10 = alloca %ParameterListParseResult
  %l11 = alloca { i8**, i64 }*
  %l12 = alloca i8*
  %l13 = alloca double
  %l14 = alloca %EffectParseResult
  %l15 = alloca { i8**, i64 }*
  %l16 = alloca double
  %l17 = alloca double
  %l18 = alloca double
  %l19 = alloca double
  store %Parser %parser, %Parser* %l0
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l1
  store i1 0, i1* %l2
  %t1 = load %Parser, %Parser* %l1
  %t2 = call double @parser_peek_raw(%Parser %t1)
  store double %t2, double* %l3
  %t3 = load double, double* %l3
  %s4 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.4, i32 0, i32 0
  %t5 = call i1 @identifier_matches(i8* null, i8* %s4)
  %t6 = load %Parser, %Parser* %l0
  %t7 = load %Parser, %Parser* %l1
  %t8 = load i1, i1* %l2
  %t9 = load double, double* %l3
  br i1 %t5, label %then0, label %merge1
then0:
  %t10 = load %Parser, %Parser* %l1
  %t11 = call %Parser @parser_advance_raw(%Parser %t10)
  %t12 = call %Parser @skip_trivia(%Parser %t11)
  store %Parser %t12, %Parser* %l4
  %t13 = load %Parser, %Parser* %l4
  %t14 = call double @parser_peek_raw(%Parser %t13)
  %s15 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.15, i32 0, i32 0
  %t16 = call i1 @identifier_matches(i8* null, i8* %s15)
  %t17 = load %Parser, %Parser* %l0
  %t18 = load %Parser, %Parser* %l1
  %t19 = load i1, i1* %l2
  %t20 = load double, double* %l3
  %t21 = load %Parser, %Parser* %l4
  br i1 %t16, label %then2, label %merge3
then2:
  %t22 = load %Parser, %Parser* %l1
  %s23 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.23, i32 0, i32 0
  %t24 = call %Parser @consume_keyword(%Parser %t22, i8* %s23)
  store %Parser %t24, %Parser* %l1
  store i1 1, i1* %l2
  br label %merge3
merge3:
  %t25 = phi %Parser [ %t24, %then2 ], [ %t18, %then0 ]
  %t26 = phi i1 [ 1, %then2 ], [ %t19, %then0 ]
  store %Parser %t25, %Parser* %l1
  store i1 %t26, i1* %l2
  br label %merge1
merge1:
  %t27 = phi %Parser [ %t24, %then0 ], [ %t7, %entry ]
  %t28 = phi i1 [ 1, %then0 ], [ %t8, %entry ]
  store %Parser %t27, %Parser* %l1
  store i1 %t28, i1* %l2
  %t29 = load %Parser, %Parser* %l1
  %t30 = call %Parser @skip_trivia(%Parser %t29)
  store %Parser %t30, %Parser* %l1
  %t31 = load %Parser, %Parser* %l1
  %t32 = call double @parser_peek_raw(%Parser %t31)
  %s33 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.33, i32 0, i32 0
  %t34 = call i1 @identifier_matches(i8* null, i8* %s33)
  %t35 = xor i1 %t34, 1
  %t36 = load %Parser, %Parser* %l0
  %t37 = load %Parser, %Parser* %l1
  %t38 = load i1, i1* %l2
  %t39 = load double, double* %l3
  br i1 %t35, label %then4, label %merge5
then4:
  %t40 = load %Parser, %Parser* %l0
  %t41 = insertvalue %InterfaceMemberParseResult undef, i8* null, 0
  %t42 = insertvalue %InterfaceMemberParseResult %t41, i8* null, 1
  %t43 = insertvalue %InterfaceMemberParseResult %t42, i1 0, 2
  ret %InterfaceMemberParseResult %t43
merge5:
  %t44 = load %Parser, %Parser* %l1
  %s45 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.45, i32 0, i32 0
  %t46 = call %Parser @consume_keyword(%Parser %t44, i8* %s45)
  store %Parser %t46, %Parser* %l1
  %t47 = load %Parser, %Parser* %l1
  %t48 = call %Parser @skip_trivia(%Parser %t47)
  store %Parser %t48, %Parser* %l1
  %t49 = load %Parser, %Parser* %l1
  %t50 = call double @parser_peek_raw(%Parser %t49)
  store double %t50, double* %l5
  %t51 = load double, double* %l5
  %t52 = load double, double* %l5
  %t53 = call i8* @identifier_text(i8* null)
  store i8* %t53, i8** %l6
  %t54 = load double, double* %l5
  %t55 = alloca [1 x double]
  %t56 = getelementptr [1 x double], [1 x double]* %t55, i32 0, i32 0
  %t57 = getelementptr double, double* %t56, i64 0
  store double %t54, double* %t57
  %t58 = alloca { double*, i64 }
  %t59 = getelementptr { double*, i64 }, { double*, i64 }* %t58, i32 0, i32 0
  store double* %t56, double** %t59
  %t60 = getelementptr { double*, i64 }, { double*, i64 }* %t58, i32 0, i32 1
  store i64 1, i64* %t60
  %t61 = call double @source_span_from_tokens({ i8**, i64 }* null)
  store double %t61, double* %l7
  %t62 = load %Parser, %Parser* %l1
  %t63 = call %Parser @parser_advance_raw(%Parser %t62)
  store %Parser %t63, %Parser* %l1
  %t64 = load %Parser, %Parser* %l1
  %t65 = call %TypeParameterParseResult @parse_type_parameter_clause(%Parser %t64)
  store %TypeParameterParseResult %t65, %TypeParameterParseResult* %l8
  %t66 = load %TypeParameterParseResult, %TypeParameterParseResult* %l8
  %t67 = extractvalue %TypeParameterParseResult %t66, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t68 = load %TypeParameterParseResult, %TypeParameterParseResult* %l8
  %t69 = extractvalue %TypeParameterParseResult %t68, 1
  store { i8**, i64 }* %t69, { i8**, i64 }** %l9
  %t70 = load %Parser, %Parser* %l1
  %t71 = call %Parser @skip_trivia(%Parser %t70)
  store %Parser %t71, %Parser* %l1
  %t72 = load %Parser, %Parser* %l1
  %s73 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.73, i32 0, i32 0
  %t74 = call %Parser @consume_symbol(%Parser %t72, i8* %s73)
  store %Parser %t74, %Parser* %l1
  %t75 = load %Parser, %Parser* %l1
  %t76 = call %ParameterListParseResult @parse_parameter_list(%Parser %t75)
  store %ParameterListParseResult %t76, %ParameterListParseResult* %l10
  %t77 = load %ParameterListParseResult, %ParameterListParseResult* %l10
  %t78 = extractvalue %ParameterListParseResult %t77, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t79 = load %ParameterListParseResult, %ParameterListParseResult* %l10
  %t80 = extractvalue %ParameterListParseResult %t79, 1
  store { i8**, i64 }* %t80, { i8**, i64 }** %l11
  %t81 = load %Parser, %Parser* %l1
  %t82 = call %Parser @skip_trivia(%Parser %t81)
  store %Parser %t82, %Parser* %l1
  store i8* null, i8** %l12
  %t83 = load %Parser, %Parser* %l1
  %t84 = call double @parser_peek_raw(%Parser %t83)
  store double %t84, double* %l13
  %t87 = load double, double* %l13
  %t88 = load %Parser, %Parser* %l1
  %t89 = call %EffectParseResult @parse_effect_list(%Parser %t88)
  store %EffectParseResult %t89, %EffectParseResult* %l14
  %t90 = load %EffectParseResult, %EffectParseResult* %l14
  %t91 = extractvalue %EffectParseResult %t90, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t92 = load %EffectParseResult, %EffectParseResult* %l14
  %t93 = extractvalue %EffectParseResult %t92, 1
  store { i8**, i64 }* %t93, { i8**, i64 }** %l15
  %t94 = call double @evaluate_decorators({ i8**, i64 }* %decorators)
  store double %t94, double* %l16
  %t95 = load { i8**, i64 }*, { i8**, i64 }** %l15
  %t96 = load double, double* %l16
  %t97 = call double @infer_effects({ i8**, i64 }* %t95, double %t96)
  store double %t97, double* %l17
  %t98 = load %Parser, %Parser* %l1
  %t99 = call %Parser @skip_trivia(%Parser %t98)
  store %Parser %t99, %Parser* %l1
  %t100 = load %Parser, %Parser* %l1
  %t101 = extractvalue %Parser %t100, 1
  %t102 = load %Parser, %Parser* %l1
  %t103 = extractvalue %Parser %t102, 0
  %t104 = load { i8**, i64 }, { i8**, i64 }* %t103
  %t105 = extractvalue { i8**, i64 } %t104, 1
  %t106 = sitofp i64 %t105 to double
  %t107 = fcmp olt double %t101, %t106
  %t108 = load %Parser, %Parser* %l0
  %t109 = load %Parser, %Parser* %l1
  %t110 = load i1, i1* %l2
  %t111 = load double, double* %l3
  %t112 = load double, double* %l5
  %t113 = load i8*, i8** %l6
  %t114 = load double, double* %l7
  %t115 = load %TypeParameterParseResult, %TypeParameterParseResult* %l8
  %t116 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t117 = load %ParameterListParseResult, %ParameterListParseResult* %l10
  %t118 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %t119 = load i8*, i8** %l12
  %t120 = load double, double* %l13
  %t121 = load %EffectParseResult, %EffectParseResult* %l14
  %t122 = load { i8**, i64 }*, { i8**, i64 }** %l15
  %t123 = load double, double* %l16
  %t124 = load double, double* %l17
  br i1 %t107, label %then6, label %merge7
then6:
  %t125 = load %Parser, %Parser* %l1
  %t126 = call double @parser_peek_raw(%Parser %t125)
  store double %t126, double* %l18
  %t128 = load double, double* %l18
  br label %merge7
merge7:
  store double 0.0, double* %l19
  %t129 = load %Parser, %Parser* %l1
  %t130 = insertvalue %InterfaceMemberParseResult undef, i8* null, 0
  %t131 = load double, double* %l19
  %t132 = insertvalue %InterfaceMemberParseResult %t130, i8* null, 1
  %t133 = insertvalue %InterfaceMemberParseResult %t132, i1 1, 2
  ret %InterfaceMemberParseResult %t133
}

define %EnumVariantParseResult @parse_enum_variant(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca double
  %l3 = alloca i8*
  %l4 = alloca double
  %l5 = alloca { i8**, i64 }*
  %l6 = alloca double
  %l7 = alloca double
  %l8 = alloca double
  store %Parser %parser, %Parser* %l0
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l1
  %t1 = load %Parser, %Parser* %l1
  %t2 = call double @parser_peek_raw(%Parser %t1)
  store double %t2, double* %l2
  %t3 = load double, double* %l2
  %t4 = load double, double* %l2
  %t5 = call i8* @identifier_text(i8* null)
  store i8* %t5, i8** %l3
  %t6 = load double, double* %l2
  %t7 = alloca [1 x double]
  %t8 = getelementptr [1 x double], [1 x double]* %t7, i32 0, i32 0
  %t9 = getelementptr double, double* %t8, i64 0
  store double %t6, double* %t9
  %t10 = alloca { double*, i64 }
  %t11 = getelementptr { double*, i64 }, { double*, i64 }* %t10, i32 0, i32 0
  store double* %t8, double** %t11
  %t12 = getelementptr { double*, i64 }, { double*, i64 }* %t10, i32 0, i32 1
  store i64 1, i64* %t12
  %t13 = call double @source_span_from_tokens({ i8**, i64 }* null)
  store double %t13, double* %l4
  %t14 = load %Parser, %Parser* %l1
  %t15 = call %Parser @parser_advance_raw(%Parser %t14)
  store %Parser %t15, %Parser* %l1
  %t16 = alloca [0 x double]
  %t17 = getelementptr [0 x double], [0 x double]* %t16, i32 0, i32 0
  %t18 = alloca { double*, i64 }
  %t19 = getelementptr { double*, i64 }, { double*, i64 }* %t18, i32 0, i32 0
  store double* %t17, double** %t19
  %t20 = getelementptr { double*, i64 }, { double*, i64 }* %t18, i32 0, i32 1
  store i64 0, i64* %t20
  store { i8**, i64 }* null, { i8**, i64 }** %l5
  %t21 = load %Parser, %Parser* %l1
  %t22 = call %Parser @skip_trivia(%Parser %t21)
  store %Parser %t22, %Parser* %l1
  %t23 = load %Parser, %Parser* %l1
  %t24 = call double @parser_peek_raw(%Parser %t23)
  store double %t24, double* %l6
  %t26 = load double, double* %l6
  %t27 = load %Parser, %Parser* %l1
  %t28 = call %Parser @skip_trivia(%Parser %t27)
  store %Parser %t28, %Parser* %l1
  %t29 = load %Parser, %Parser* %l1
  %t30 = call double @parser_peek_raw(%Parser %t29)
  store double %t30, double* %l7
  %t32 = load double, double* %l7
  store double 0.0, double* %l8
  %t33 = load %Parser, %Parser* %l1
  %t34 = insertvalue %EnumVariantParseResult undef, i8* null, 0
  %t35 = load double, double* %l8
  %t36 = insertvalue %EnumVariantParseResult %t34, i8* null, 1
  %t37 = insertvalue %EnumVariantParseResult %t36, i1 1, 2
  ret %EnumVariantParseResult %t37
}

define %StructFieldParseResult @parse_enum_variant_field(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca i1
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca double
  %l8 = alloca double
  %l9 = alloca double
  %l10 = alloca double
  %l11 = alloca double
  %l12 = alloca double
  %l13 = alloca double
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l0
  store i1 0, i1* %l1
  %t1 = load %Parser, %Parser* %l0
  %t2 = call double @parser_peek_raw(%Parser %t1)
  store double %t2, double* %l2
  %t3 = load double, double* %l2
  store double %t3, double* %l3
  %t4 = load double, double* %l3
  %s5 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.5, i32 0, i32 0
  %t6 = call i1 @identifier_matches(i8* null, i8* %s5)
  %t7 = load %Parser, %Parser* %l0
  %t8 = load i1, i1* %l1
  %t9 = load double, double* %l2
  %t10 = load double, double* %l3
  br i1 %t6, label %then0, label %merge1
then0:
  %t11 = load %Parser, %Parser* %l0
  %t12 = call %Parser @parser_advance_raw(%Parser %t11)
  store %Parser %t12, %Parser* %l0
  store i1 1, i1* %l1
  %t13 = load %Parser, %Parser* %l0
  %t14 = call %Parser @skip_trivia(%Parser %t13)
  store %Parser %t14, %Parser* %l0
  %t15 = load %Parser, %Parser* %l0
  %t16 = call double @parser_peek_raw(%Parser %t15)
  store double %t16, double* %l3
  br label %merge1
merge1:
  %t17 = phi %Parser [ %t12, %then0 ], [ %t7, %entry ]
  %t18 = phi i1 [ 1, %then0 ], [ %t8, %entry ]
  %t19 = phi %Parser [ %t14, %then0 ], [ %t7, %entry ]
  %t20 = phi double [ %t16, %then0 ], [ %t10, %entry ]
  store %Parser %t17, %Parser* %l0
  store i1 %t18, i1* %l1
  store %Parser %t19, %Parser* %l0
  store double %t20, double* %l3
  %t21 = load double, double* %l3
  %t22 = load double, double* %l3
  %t23 = call i8* @identifier_text(i8* null)
  store i8* %t23, i8** %l4
  %t24 = load double, double* %l3
  %t25 = alloca [1 x double]
  %t26 = getelementptr [1 x double], [1 x double]* %t25, i32 0, i32 0
  %t27 = getelementptr double, double* %t26, i64 0
  store double %t24, double* %t27
  %t28 = alloca { double*, i64 }
  %t29 = getelementptr { double*, i64 }, { double*, i64 }* %t28, i32 0, i32 0
  store double* %t26, double** %t29
  %t30 = getelementptr { double*, i64 }, { double*, i64 }* %t28, i32 0, i32 1
  store i64 1, i64* %t30
  %t31 = call double @source_span_from_tokens({ i8**, i64 }* null)
  store double %t31, double* %l5
  %t32 = load %Parser, %Parser* %l0
  %t33 = call %Parser @parser_advance_raw(%Parser %t32)
  store %Parser %t33, %Parser* %l0
  %t34 = load %Parser, %Parser* %l0
  %t35 = call %Parser @skip_trivia(%Parser %t34)
  store %Parser %t35, %Parser* %l0
  %t36 = load %Parser, %Parser* %l0
  %t37 = call double @parser_peek_raw(%Parser %t36)
  store double %t37, double* %l6
  %t38 = load double, double* %l6
  store double 0.0, double* %l7
  %t39 = load double, double* %l7
  %t40 = fcmp one double %t39, 0.0
  %t41 = xor i1 %t40, 1
  %t42 = load %Parser, %Parser* %l0
  %t43 = load i1, i1* %l1
  %t44 = load double, double* %l2
  %t45 = load double, double* %l3
  %t46 = load i8*, i8** %l4
  %t47 = load double, double* %l5
  %t48 = load double, double* %l6
  %t49 = load double, double* %l7
  br i1 %t41, label %then2, label %merge3
then2:
  %t50 = insertvalue %StructFieldParseResult undef, i8* null, 0
  %t51 = insertvalue %StructFieldParseResult %t50, i8* null, 1
  %t52 = insertvalue %StructFieldParseResult %t51, i1 0, 2
  ret %StructFieldParseResult %t52
merge3:
  %t53 = load %Parser, %Parser* %l0
  %t54 = call %Parser @parser_advance_raw(%Parser %t53)
  store %Parser %t54, %Parser* %l0
  %t55 = load %Parser, %Parser* %l0
  %t56 = call %Parser @skip_trivia(%Parser %t55)
  store double 0.0, double* %l8
  %t57 = load double, double* %l8
  %t58 = load double, double* %l8
  store double 0.0, double* %l9
  %t59 = load %Parser, %Parser* %l0
  %t60 = load i1, i1* %l1
  %t61 = load double, double* %l2
  %t62 = load double, double* %l3
  %t63 = load i8*, i8** %l4
  %t64 = load double, double* %l5
  %t65 = load double, double* %l6
  %t66 = load double, double* %l7
  %t67 = load double, double* %l8
  %t68 = load double, double* %l9
  br label %loop.header4
loop.header4:
  %t77 = phi double [ %t68, %entry ], [ %t76, %loop.latch6 ]
  store double %t77, double* %l9
  br label %loop.body5
loop.body5:
  %t69 = load double, double* %l9
  store double 0.0, double* %l10
  %t70 = load double, double* %l10
  %s71 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.71, i32 0, i32 0
  %t72 = load double, double* %l9
  %t73 = load double, double* %l9
  store double 0.0, double* %l11
  %t74 = load double, double* %l11
  %t75 = call i8* @trim_text(i8* null)
  store double 0.0, double* %l9
  br label %loop.latch6
loop.latch6:
  %t76 = load double, double* %l9
  br label %loop.header4
afterloop7:
  %t78 = load double, double* %l9
  %t79 = load %Parser, %Parser* %l0
  %t80 = call %Parser @skip_trivia(%Parser %t79)
  store %Parser %t80, %Parser* %l0
  %t81 = load %Parser, %Parser* %l0
  %t82 = call double @parser_peek_raw(%Parser %t81)
  store double %t82, double* %l12
  %t83 = load double, double* %l12
  store double 0.0, double* %l13
  %t84 = load %Parser, %Parser* %l0
  %t85 = insertvalue %StructFieldParseResult undef, i8* null, 0
  %t86 = load double, double* %l13
  %t87 = insertvalue %StructFieldParseResult %t85, i8* null, 1
  %t88 = insertvalue %StructFieldParseResult %t87, i1 1, 2
  ret %StructFieldParseResult %t88
}

define %Parser @skip_trailing_comma(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca double
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l0
  %t1 = load %Parser, %Parser* %l0
  %t2 = call double @parser_peek_raw(%Parser %t1)
  store double %t2, double* %l1
  %t4 = load double, double* %l1
  %t5 = load %Parser, %Parser* %l0
  ret %Parser %t5
}

define %StatementParseResult @parse_model(%Parser %parser, { i8**, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca %CaptureResult
  %l5 = alloca i8*
  %l6 = alloca double
  %l7 = alloca %EffectParseResult
  %l8 = alloca { i8**, i64 }*
  %l9 = alloca { i8**, i64 }*
  %l10 = alloca double
  %l11 = alloca %Parser
  %l12 = alloca %ModelPropertyParseResult
  %l13 = alloca double
  %l14 = alloca double
  store %Parser %parser, %Parser* %l0
  %t0 = call double @parser_peek_raw(%Parser %parser)
  store double %t0, double* %l1
  %t1 = load double, double* %l1
  %t2 = call i8* @identifier_text(i8* null)
  store i8* %t2, i8** %l2
  %t3 = load double, double* %l1
  %t4 = alloca [1 x double]
  %t5 = getelementptr [1 x double], [1 x double]* %t4, i32 0, i32 0
  %t6 = getelementptr double, double* %t5, i64 0
  store double %t3, double* %t6
  %t7 = alloca { double*, i64 }
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 0
  store double* %t5, double** %t8
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 1
  store i64 1, i64* %t9
  %t10 = call double @source_span_from_tokens({ i8**, i64 }* null)
  store double %t10, double* %l3
  %t11 = call %Parser @skip_trivia(%Parser %parser)
  %s12 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.12, i32 0, i32 0
  %s13 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.13, i32 0, i32 0
  %t14 = alloca [2 x i8*]
  %t15 = getelementptr [2 x i8*], [2 x i8*]* %t14, i32 0, i32 0
  %t16 = getelementptr i8*, i8** %t15, i64 0
  store i8* %s12, i8** %t16
  %t17 = getelementptr i8*, i8** %t15, i64 1
  store i8* %s13, i8** %t17
  %t18 = alloca { i8**, i64 }
  %t19 = getelementptr { i8**, i64 }, { i8**, i64 }* %t18, i32 0, i32 0
  store i8** %t15, i8*** %t19
  %t20 = getelementptr { i8**, i64 }, { i8**, i64 }* %t18, i32 0, i32 1
  store i64 2, i64* %t20
  %t21 = call %CaptureResult @collect_until(%Parser %t11, { i8**, i64 }* %t18)
  store %CaptureResult %t21, %CaptureResult* %l4
  %t22 = load %CaptureResult, %CaptureResult* %l4
  %t23 = extractvalue %CaptureResult %t22, 1
  %t24 = call i8* @tokens_to_text({ i8**, i64 }* %t23)
  %t25 = call i8* @trim_text(i8* %t24)
  store i8* %t25, i8** %l5
  %t26 = load i8*, i8** %l5
  store double 0.0, double* %l6
  %t27 = call %EffectParseResult @parse_effect_list(%Parser %parser)
  store %EffectParseResult %t27, %EffectParseResult* %l7
  %t28 = load %EffectParseResult, %EffectParseResult* %l7
  %t29 = extractvalue %EffectParseResult %t28, 1
  store { i8**, i64 }* %t29, { i8**, i64 }** %l8
  %t30 = alloca [0 x double]
  %t31 = getelementptr [0 x double], [0 x double]* %t30, i32 0, i32 0
  %t32 = alloca { double*, i64 }
  %t33 = getelementptr { double*, i64 }, { double*, i64 }* %t32, i32 0, i32 0
  store double* %t31, double** %t33
  %t34 = getelementptr { double*, i64 }, { double*, i64 }* %t32, i32 0, i32 1
  store i64 0, i64* %t34
  store { i8**, i64 }* null, { i8**, i64 }** %l9
  %t35 = load %Parser, %Parser* %l0
  %t36 = load double, double* %l1
  %t37 = load i8*, i8** %l2
  %t38 = load double, double* %l3
  %t39 = load %CaptureResult, %CaptureResult* %l4
  %t40 = load i8*, i8** %l5
  %t41 = load double, double* %l6
  %t42 = load %EffectParseResult, %EffectParseResult* %l7
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l9
  br label %loop.header0
loop.header0:
  %t79 = phi { i8**, i64 }* [ %t44, %entry ], [ %t78, %loop.latch2 ]
  store { i8**, i64 }* %t79, { i8**, i64 }** %l9
  br label %loop.body1
loop.body1:
  %t45 = call double @parser_peek_raw(%Parser %parser)
  store double %t45, double* %l10
  %t47 = load double, double* %l10
  %t48 = load double, double* %l10
  store %Parser %parser, %Parser* %l11
  %t49 = call %ModelPropertyParseResult @parse_model_property(%Parser %parser)
  store %ModelPropertyParseResult %t49, %ModelPropertyParseResult* %l12
  %t51 = load %ModelPropertyParseResult, %ModelPropertyParseResult* %l12
  %t52 = extractvalue %ModelPropertyParseResult %t51, 2
  br label %logical_and_entry_50

logical_and_entry_50:
  br i1 %t52, label %logical_and_right_50, label %logical_and_merge_50

logical_and_right_50:
  %t53 = load %ModelPropertyParseResult, %ModelPropertyParseResult* %l12
  %t54 = extractvalue %ModelPropertyParseResult %t53, 1
  %t55 = icmp ne i8* %t54, null
  br label %logical_and_right_end_50

logical_and_right_end_50:
  br label %logical_and_merge_50

logical_and_merge_50:
  %t56 = phi i1 [ false, %logical_and_entry_50 ], [ %t55, %logical_and_right_end_50 ]
  %t57 = load %Parser, %Parser* %l0
  %t58 = load double, double* %l1
  %t59 = load i8*, i8** %l2
  %t60 = load double, double* %l3
  %t61 = load %CaptureResult, %CaptureResult* %l4
  %t62 = load i8*, i8** %l5
  %t63 = load double, double* %l6
  %t64 = load %EffectParseResult, %EffectParseResult* %l7
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t67 = load double, double* %l10
  %t68 = load %Parser, %Parser* %l11
  %t69 = load %ModelPropertyParseResult, %ModelPropertyParseResult* %l12
  br i1 %t56, label %then4, label %merge5
then4:
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t71 = load %ModelPropertyParseResult, %ModelPropertyParseResult* %l12
  %t72 = extractvalue %ModelPropertyParseResult %t71, 1
  %t73 = call { i8**, i64 }* @append_model_property({ i8**, i64 }* %t70, i8* %t72)
  store { i8**, i64 }* %t73, { i8**, i64 }** %l9
  br label %loop.latch2
merge5:
  %t74 = call double @parser_peek_raw(%Parser %parser)
  store double %t74, double* %l13
  %t76 = load double, double* %l13
  %t77 = load double, double* %l13
  br label %loop.latch2
loop.latch2:
  %t78 = load { i8**, i64 }*, { i8**, i64 }** %l9
  br label %loop.header0
afterloop3:
  store double 0.0, double* %l14
  %t80 = insertvalue %StatementParseResult undef, i8* null, 0
  %t81 = load double, double* %l14
  %t82 = insertvalue %StatementParseResult %t80, i8* null, 1
  ret %StatementParseResult %t82
}

define %StatementParseResult @parse_pipeline(%Parser %parser, { i8**, i64 }* %decorators) {
entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca %TypeParameterParseResult
  %l4 = alloca { i8**, i64 }*
  %l5 = alloca %ParameterListParseResult
  %l6 = alloca { i8**, i64 }*
  %l7 = alloca i8*
  %l8 = alloca double
  %l9 = alloca %EffectParseResult
  %l10 = alloca { i8**, i64 }*
  %l11 = alloca double
  %l12 = alloca double
  %l13 = alloca %BlockParseResult
  %l14 = alloca i8*
  %l15 = alloca double
  %l16 = alloca double
  %t0 = call double @parser_peek_raw(%Parser %parser)
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  %t2 = call i8* @identifier_text(i8* null)
  store i8* %t2, i8** %l1
  %t3 = load double, double* %l0
  %t4 = alloca [1 x double]
  %t5 = getelementptr [1 x double], [1 x double]* %t4, i32 0, i32 0
  %t6 = getelementptr double, double* %t5, i64 0
  store double %t3, double* %t6
  %t7 = alloca { double*, i64 }
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 0
  store double* %t5, double** %t8
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 1
  store i64 1, i64* %t9
  %t10 = call double @source_span_from_tokens({ i8**, i64 }* null)
  store double %t10, double* %l2
  %t11 = call %TypeParameterParseResult @parse_type_parameter_clause(%Parser %parser)
  store %TypeParameterParseResult %t11, %TypeParameterParseResult* %l3
  %t12 = load %TypeParameterParseResult, %TypeParameterParseResult* %l3
  %t13 = extractvalue %TypeParameterParseResult %t12, 1
  store { i8**, i64 }* %t13, { i8**, i64 }** %l4
  %t14 = call %ParameterListParseResult @parse_parameter_list(%Parser %parser)
  store %ParameterListParseResult %t14, %ParameterListParseResult* %l5
  %t15 = load %ParameterListParseResult, %ParameterListParseResult* %l5
  %t16 = extractvalue %ParameterListParseResult %t15, 1
  store { i8**, i64 }* %t16, { i8**, i64 }** %l6
  store i8* null, i8** %l7
  %t17 = call double @parser_peek_raw(%Parser %parser)
  store double %t17, double* %l8
  %t20 = load double, double* %l8
  %t21 = call %EffectParseResult @parse_effect_list(%Parser %parser)
  store %EffectParseResult %t21, %EffectParseResult* %l9
  %t22 = load %EffectParseResult, %EffectParseResult* %l9
  %t23 = extractvalue %EffectParseResult %t22, 1
  store { i8**, i64 }* %t23, { i8**, i64 }** %l10
  %t24 = call double @evaluate_decorators({ i8**, i64 }* %decorators)
  store double %t24, double* %l11
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t26 = load double, double* %l11
  %t27 = call double @infer_effects({ i8**, i64 }* %t25, double %t26)
  store double %t27, double* %l12
  %t28 = call %BlockParseResult @parse_block(%Parser %parser)
  store %BlockParseResult %t28, %BlockParseResult* %l13
  %t29 = load %BlockParseResult, %BlockParseResult* %l13
  %t30 = extractvalue %BlockParseResult %t29, 1
  store i8* %t30, i8** %l14
  store double 0.0, double* %l15
  store double 0.0, double* %l16
  %t31 = insertvalue %StatementParseResult undef, i8* null, 0
  %t32 = load double, double* %l16
  %t33 = insertvalue %StatementParseResult %t31, i8* null, 1
  ret %StatementParseResult %t33
}

define %StatementParseResult @parse_tool(%Parser %parser, { i8**, i64 }* %decorators) {
entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca %ParameterListParseResult
  %l4 = alloca { i8**, i64 }*
  %l5 = alloca i8*
  %l6 = alloca double
  %l7 = alloca %EffectParseResult
  %l8 = alloca { i8**, i64 }*
  %l9 = alloca double
  %l10 = alloca double
  %l11 = alloca %BlockParseResult
  %l12 = alloca i8*
  %l13 = alloca double
  %l14 = alloca double
  %t0 = call double @parser_peek_raw(%Parser %parser)
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  %t2 = call i8* @identifier_text(i8* null)
  store i8* %t2, i8** %l1
  %t3 = load double, double* %l0
  %t4 = alloca [1 x double]
  %t5 = getelementptr [1 x double], [1 x double]* %t4, i32 0, i32 0
  %t6 = getelementptr double, double* %t5, i64 0
  store double %t3, double* %t6
  %t7 = alloca { double*, i64 }
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 0
  store double* %t5, double** %t8
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 1
  store i64 1, i64* %t9
  %t10 = call double @source_span_from_tokens({ i8**, i64 }* null)
  store double %t10, double* %l2
  %t11 = call %ParameterListParseResult @parse_parameter_list(%Parser %parser)
  store %ParameterListParseResult %t11, %ParameterListParseResult* %l3
  %t12 = load %ParameterListParseResult, %ParameterListParseResult* %l3
  %t13 = extractvalue %ParameterListParseResult %t12, 1
  store { i8**, i64 }* %t13, { i8**, i64 }** %l4
  store i8* null, i8** %l5
  %t14 = call double @parser_peek_raw(%Parser %parser)
  store double %t14, double* %l6
  %t17 = load double, double* %l6
  %t18 = call %EffectParseResult @parse_effect_list(%Parser %parser)
  store %EffectParseResult %t18, %EffectParseResult* %l7
  %t19 = load %EffectParseResult, %EffectParseResult* %l7
  %t20 = extractvalue %EffectParseResult %t19, 1
  store { i8**, i64 }* %t20, { i8**, i64 }** %l8
  %t21 = call double @evaluate_decorators({ i8**, i64 }* %decorators)
  store double %t21, double* %l9
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t23 = load double, double* %l9
  %t24 = call double @infer_effects({ i8**, i64 }* %t22, double %t23)
  store double %t24, double* %l10
  %t25 = call %BlockParseResult @parse_block(%Parser %parser)
  store %BlockParseResult %t25, %BlockParseResult* %l11
  %t26 = load %BlockParseResult, %BlockParseResult* %l11
  %t27 = extractvalue %BlockParseResult %t26, 1
  store i8* %t27, i8** %l12
  store double 0.0, double* %l13
  store double 0.0, double* %l14
  %t28 = insertvalue %StatementParseResult undef, i8* null, 0
  %t29 = load double, double* %l14
  %t30 = insertvalue %StatementParseResult %t28, i8* null, 1
  ret %StatementParseResult %t30
}

define %StatementParseResult @parse_test(%Parser %parser, { i8**, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %CaptureResult
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca %EffectParseResult
  %l6 = alloca { i8**, i64 }*
  %l7 = alloca double
  %l8 = alloca double
  %l9 = alloca %BlockParseResult
  %l10 = alloca i8*
  %l11 = alloca double
  store %Parser %parser, %Parser* %l0
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  %s1 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.1, i32 0, i32 0
  %s2 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.2, i32 0, i32 0
  %t3 = alloca [2 x i8*]
  %t4 = getelementptr [2 x i8*], [2 x i8*]* %t3, i32 0, i32 0
  %t5 = getelementptr i8*, i8** %t4, i64 0
  store i8* %s1, i8** %t5
  %t6 = getelementptr i8*, i8** %t4, i64 1
  store i8* %s2, i8** %t6
  %t7 = alloca { i8**, i64 }
  %t8 = getelementptr { i8**, i64 }, { i8**, i64 }* %t7, i32 0, i32 0
  store i8** %t4, i8*** %t8
  %t9 = getelementptr { i8**, i64 }, { i8**, i64 }* %t7, i32 0, i32 1
  store i64 2, i64* %t9
  %t10 = call %CaptureResult @collect_until(%Parser %t0, { i8**, i64 }* %t7)
  store %CaptureResult %t10, %CaptureResult* %l1
  %t11 = load %CaptureResult, %CaptureResult* %l1
  %t12 = extractvalue %CaptureResult %t11, 1
  %t13 = call i8* @tokens_to_text({ i8**, i64 }* %t12)
  %t14 = call i8* @trim_text(i8* %t13)
  store i8* %t14, i8** %l2
  %t15 = load i8*, i8** %l2
  %t16 = load %CaptureResult, %CaptureResult* %l1
  %t17 = extractvalue %CaptureResult %t16, 1
  %t18 = call double @source_span_from_tokens({ i8**, i64 }* %t17)
  store double %t18, double* %l3
  %t19 = load i8*, i8** %l2
  %t20 = call i8* @normalize_test_name(i8* %t19)
  store i8* %t20, i8** %l4
  %t21 = call %EffectParseResult @parse_effect_list(%Parser %parser)
  store %EffectParseResult %t21, %EffectParseResult* %l5
  %t22 = load %EffectParseResult, %EffectParseResult* %l5
  %t23 = extractvalue %EffectParseResult %t22, 1
  store { i8**, i64 }* %t23, { i8**, i64 }** %l6
  %t24 = call double @evaluate_decorators({ i8**, i64 }* %decorators)
  store double %t24, double* %l7
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t26 = load double, double* %l7
  %t27 = call double @infer_effects({ i8**, i64 }* %t25, double %t26)
  store double %t27, double* %l8
  %t28 = call %BlockParseResult @parse_block(%Parser %parser)
  store %BlockParseResult %t28, %BlockParseResult* %l9
  %t29 = load %BlockParseResult, %BlockParseResult* %l9
  %t30 = extractvalue %BlockParseResult %t29, 1
  store i8* %t30, i8** %l10
  store double 0.0, double* %l11
  %t31 = insertvalue %StatementParseResult undef, i8* null, 0
  %t32 = load double, double* %l11
  %t33 = insertvalue %StatementParseResult %t31, i8* null, 1
  ret %StatementParseResult %t33
}

define %StatementParseResult @parse_function(%Parser %parser, i1 %starts_with_async, { i8**, i64 }* %decorators) {
entry:
  %l0 = alloca i1
  %l1 = alloca double
  %l2 = alloca %Parser
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca i8*
  %l6 = alloca double
  %l7 = alloca %TypeParameterParseResult
  %l8 = alloca { i8**, i64 }*
  %l9 = alloca %ParameterListParseResult
  %l10 = alloca { i8**, i64 }*
  %l11 = alloca i8*
  %l12 = alloca double
  %l13 = alloca %EffectParseResult
  %l14 = alloca { i8**, i64 }*
  %l15 = alloca double
  %l16 = alloca double
  %l17 = alloca %BlockParseResult
  %l18 = alloca i8*
  %l19 = alloca double
  %l20 = alloca double
  store i1 0, i1* %l0
  %t0 = load i1, i1* %l0
  br i1 %starts_with_async, label %then0, label %else1
then0:
  store i1 1, i1* %l0
  br label %merge2
else1:
  %t1 = call double @parser_peek_raw(%Parser %parser)
  store double %t1, double* %l1
  %t2 = load double, double* %l1
  %s3 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.3, i32 0, i32 0
  %t4 = call i1 @identifier_matches(i8* null, i8* %s3)
  %t5 = load i1, i1* %l0
  %t6 = load double, double* %l1
  br i1 %t4, label %then3, label %merge4
then3:
  %t7 = call %Parser @parser_advance_raw(%Parser %parser)
  %t8 = call %Parser @skip_trivia(%Parser %t7)
  store %Parser %t8, %Parser* %l2
  %t9 = load %Parser, %Parser* %l2
  %t10 = call double @parser_peek_raw(%Parser %t9)
  store double %t10, double* %l3
  %t11 = load double, double* %l3
  %s12 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.12, i32 0, i32 0
  %t13 = call i1 @identifier_matches(i8* null, i8* %s12)
  %t14 = load i1, i1* %l0
  %t15 = load double, double* %l1
  %t16 = load %Parser, %Parser* %l2
  %t17 = load double, double* %l3
  br i1 %t13, label %then5, label %merge6
then5:
  store i1 1, i1* %l0
  br label %merge6
merge6:
  %t18 = phi i1 [ 1, %then5 ], [ %t14, %then3 ]
  store i1 %t18, i1* %l0
  br label %merge4
merge4:
  %t19 = phi i1 [ 1, %then3 ], [ %t5, %else1 ]
  store i1 %t19, i1* %l0
  br label %merge2
merge2:
  %t20 = phi i1 [ 1, %then0 ], [ 1, %else1 ]
  store i1 %t20, i1* %l0
  %t21 = call double @parser_peek_raw(%Parser %parser)
  store double %t21, double* %l4
  %t22 = load double, double* %l4
  %t23 = call i8* @identifier_text(i8* null)
  store i8* %t23, i8** %l5
  %t24 = load double, double* %l4
  %t25 = alloca [1 x double]
  %t26 = getelementptr [1 x double], [1 x double]* %t25, i32 0, i32 0
  %t27 = getelementptr double, double* %t26, i64 0
  store double %t24, double* %t27
  %t28 = alloca { double*, i64 }
  %t29 = getelementptr { double*, i64 }, { double*, i64 }* %t28, i32 0, i32 0
  store double* %t26, double** %t29
  %t30 = getelementptr { double*, i64 }, { double*, i64 }* %t28, i32 0, i32 1
  store i64 1, i64* %t30
  %t31 = call double @source_span_from_tokens({ i8**, i64 }* null)
  store double %t31, double* %l6
  %t32 = call %TypeParameterParseResult @parse_type_parameter_clause(%Parser %parser)
  store %TypeParameterParseResult %t32, %TypeParameterParseResult* %l7
  %t33 = load %TypeParameterParseResult, %TypeParameterParseResult* %l7
  %t34 = extractvalue %TypeParameterParseResult %t33, 1
  store { i8**, i64 }* %t34, { i8**, i64 }** %l8
  %t35 = call %ParameterListParseResult @parse_parameter_list(%Parser %parser)
  store %ParameterListParseResult %t35, %ParameterListParseResult* %l9
  %t36 = load %ParameterListParseResult, %ParameterListParseResult* %l9
  %t37 = extractvalue %ParameterListParseResult %t36, 1
  store { i8**, i64 }* %t37, { i8**, i64 }** %l10
  store i8* null, i8** %l11
  %t38 = call double @parser_peek_raw(%Parser %parser)
  store double %t38, double* %l12
  %t41 = load double, double* %l12
  %t42 = call %EffectParseResult @parse_effect_list(%Parser %parser)
  store %EffectParseResult %t42, %EffectParseResult* %l13
  %t43 = load %EffectParseResult, %EffectParseResult* %l13
  %t44 = extractvalue %EffectParseResult %t43, 1
  store { i8**, i64 }* %t44, { i8**, i64 }** %l14
  %t45 = call double @evaluate_decorators({ i8**, i64 }* %decorators)
  store double %t45, double* %l15
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l14
  %t47 = load double, double* %l15
  %t48 = call double @infer_effects({ i8**, i64 }* %t46, double %t47)
  store double %t48, double* %l16
  %t49 = call %BlockParseResult @parse_block(%Parser %parser)
  store %BlockParseResult %t49, %BlockParseResult* %l17
  %t50 = load %BlockParseResult, %BlockParseResult* %l17
  %t51 = extractvalue %BlockParseResult %t50, 1
  store i8* %t51, i8** %l18
  store double 0.0, double* %l19
  store double 0.0, double* %l20
  %t52 = insertvalue %StatementParseResult undef, i8* null, 0
  %t53 = load double, double* %l20
  %t54 = insertvalue %StatementParseResult %t52, i8* null, 1
  ret %StatementParseResult %t54
}

define %ParameterListParseResult @parse_parameter_list(%Parser %parser) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca %ParameterParseResult
  %l3 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = call double @parser_peek_raw(%Parser %parser)
  store double %t5, double* %l1
  %t6 = load double, double* %l1
  %t7 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t8 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t20 = phi { i8**, i64 }* [ %t7, %entry ], [ %t19, %loop.latch2 ]
  store { i8**, i64 }* %t20, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t9 = call %ParameterParseResult @parse_single_parameter(%Parser %parser)
  store %ParameterParseResult %t9, %ParameterParseResult* %l2
  %t10 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t11 = load %ParameterParseResult, %ParameterParseResult* %l2
  %t12 = extractvalue %ParameterParseResult %t11, 1
  %t13 = call { i8**, i64 }* @append_parameter({ i8**, i64 }* %t10, i8* %t12)
  store { i8**, i64 }* %t13, { i8**, i64 }** %l0
  %t14 = call double @parser_peek_raw(%Parser %parser)
  store double %t14, double* %l3
  %t16 = load double, double* %l3
  %t17 = load double, double* %l3
  %t18 = load double, double* %l3
  br label %loop.latch2
loop.latch2:
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t21 = insertvalue %ParameterListParseResult undef, i8* null, 0
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t23 = insertvalue %ParameterListParseResult %t21, { i8**, i64 }* %t22, 1
  ret %ParameterListParseResult %t23
}

define %StructFieldParseResult @parse_struct_field(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca i1
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca double
  %l8 = alloca %CaptureResult
  %l9 = alloca i8*
  %l10 = alloca double
  %l11 = alloca double
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l0
  store i1 0, i1* %l1
  %t1 = load %Parser, %Parser* %l0
  %t2 = call double @parser_peek_raw(%Parser %t1)
  store double %t2, double* %l2
  %t3 = load double, double* %l2
  store double %t3, double* %l3
  %t4 = load double, double* %l3
  %s5 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.5, i32 0, i32 0
  %t6 = call i1 @identifier_matches(i8* null, i8* %s5)
  %t7 = load %Parser, %Parser* %l0
  %t8 = load i1, i1* %l1
  %t9 = load double, double* %l2
  %t10 = load double, double* %l3
  br i1 %t6, label %then0, label %merge1
then0:
  %t11 = load %Parser, %Parser* %l0
  %t12 = call %Parser @parser_advance_raw(%Parser %t11)
  store %Parser %t12, %Parser* %l0
  store i1 1, i1* %l1
  %t13 = load %Parser, %Parser* %l0
  %t14 = call %Parser @skip_trivia(%Parser %t13)
  store %Parser %t14, %Parser* %l0
  %t15 = load %Parser, %Parser* %l0
  %t16 = call double @parser_peek_raw(%Parser %t15)
  store double %t16, double* %l3
  br label %merge1
merge1:
  %t17 = phi %Parser [ %t12, %then0 ], [ %t7, %entry ]
  %t18 = phi i1 [ 1, %then0 ], [ %t8, %entry ]
  %t19 = phi %Parser [ %t14, %then0 ], [ %t7, %entry ]
  %t20 = phi double [ %t16, %then0 ], [ %t10, %entry ]
  store %Parser %t17, %Parser* %l0
  store i1 %t18, i1* %l1
  store %Parser %t19, %Parser* %l0
  store double %t20, double* %l3
  %t21 = load double, double* %l3
  %t22 = load double, double* %l3
  %t23 = call i8* @identifier_text(i8* null)
  store i8* %t23, i8** %l4
  %t24 = load double, double* %l3
  %t25 = alloca [1 x double]
  %t26 = getelementptr [1 x double], [1 x double]* %t25, i32 0, i32 0
  %t27 = getelementptr double, double* %t26, i64 0
  store double %t24, double* %t27
  %t28 = alloca { double*, i64 }
  %t29 = getelementptr { double*, i64 }, { double*, i64 }* %t28, i32 0, i32 0
  store double* %t26, double** %t29
  %t30 = getelementptr { double*, i64 }, { double*, i64 }* %t28, i32 0, i32 1
  store i64 1, i64* %t30
  %t31 = call double @source_span_from_tokens({ i8**, i64 }* null)
  store double %t31, double* %l5
  %t32 = load %Parser, %Parser* %l0
  %t33 = call %Parser @parser_advance_raw(%Parser %t32)
  store %Parser %t33, %Parser* %l0
  %t34 = load %Parser, %Parser* %l0
  %t35 = call %Parser @skip_trivia(%Parser %t34)
  store %Parser %t35, %Parser* %l0
  %t36 = load %Parser, %Parser* %l0
  %t37 = call double @parser_peek_raw(%Parser %t36)
  store double %t37, double* %l6
  %t38 = load double, double* %l6
  store double 0.0, double* %l7
  %t39 = load double, double* %l7
  %t40 = fcmp one double %t39, 0.0
  %t41 = xor i1 %t40, 1
  %t42 = load %Parser, %Parser* %l0
  %t43 = load i1, i1* %l1
  %t44 = load double, double* %l2
  %t45 = load double, double* %l3
  %t46 = load i8*, i8** %l4
  %t47 = load double, double* %l5
  %t48 = load double, double* %l6
  %t49 = load double, double* %l7
  br i1 %t41, label %then2, label %merge3
then2:
  %t50 = insertvalue %StructFieldParseResult undef, i8* null, 0
  %t51 = insertvalue %StructFieldParseResult %t50, i8* null, 1
  %t52 = insertvalue %StructFieldParseResult %t51, i1 0, 2
  ret %StructFieldParseResult %t52
merge3:
  %t53 = load %Parser, %Parser* %l0
  %t54 = call %Parser @parser_advance_raw(%Parser %t53)
  store %Parser %t54, %Parser* %l0
  %t55 = load %Parser, %Parser* %l0
  %t56 = call %Parser @skip_trivia(%Parser %t55)
  %s57 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.57, i32 0, i32 0
  %t58 = alloca [1 x i8*]
  %t59 = getelementptr [1 x i8*], [1 x i8*]* %t58, i32 0, i32 0
  %t60 = getelementptr i8*, i8** %t59, i64 0
  store i8* %s57, i8** %t60
  %t61 = alloca { i8**, i64 }
  %t62 = getelementptr { i8**, i64 }, { i8**, i64 }* %t61, i32 0, i32 0
  store i8** %t59, i8*** %t62
  %t63 = getelementptr { i8**, i64 }, { i8**, i64 }* %t61, i32 0, i32 1
  store i64 1, i64* %t63
  %t64 = call %CaptureResult @collect_until(%Parser %t56, { i8**, i64 }* %t61)
  store %CaptureResult %t64, %CaptureResult* %l8
  %t65 = load %CaptureResult, %CaptureResult* %l8
  %t66 = extractvalue %CaptureResult %t65, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t67 = load %CaptureResult, %CaptureResult* %l8
  %t68 = extractvalue %CaptureResult %t67, 1
  %t69 = call i8* @tokens_to_text({ i8**, i64 }* %t68)
  %t70 = call i8* @trim_text(i8* %t69)
  store i8* %t70, i8** %l9
  %t71 = load i8*, i8** %l9
  %t72 = load %Parser, %Parser* %l0
  %t73 = call %Parser @skip_trivia(%Parser %t72)
  store %Parser %t73, %Parser* %l0
  %t74 = load %Parser, %Parser* %l0
  %t75 = call double @parser_peek_raw(%Parser %t74)
  store double %t75, double* %l10
  %t77 = load double, double* %l10
  %t78 = load %Parser, %Parser* %l0
  %t79 = call %Parser @parser_advance_raw(%Parser %t78)
  store %Parser %t79, %Parser* %l0
  store double 0.0, double* %l11
  %t80 = load %Parser, %Parser* %l0
  %t81 = insertvalue %StructFieldParseResult undef, i8* null, 0
  %t82 = load double, double* %l11
  %t83 = insertvalue %StructFieldParseResult %t81, i8* null, 1
  %t84 = insertvalue %StructFieldParseResult %t83, i1 1, 2
  ret %StructFieldParseResult %t84
}

define %ModelPropertyParseResult @parse_model_property(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca %CaptureResult
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca double
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l0
  %t1 = load %Parser, %Parser* %l0
  %t2 = call double @parser_peek_raw(%Parser %t1)
  store double %t2, double* %l1
  %t3 = load double, double* %l1
  %t4 = load double, double* %l1
  %t5 = call i8* @identifier_text(i8* null)
  store i8* %t5, i8** %l2
  %t6 = load %Parser, %Parser* %l0
  %t7 = call %Parser @parser_advance_raw(%Parser %t6)
  store %Parser %t7, %Parser* %l0
  %t8 = load %Parser, %Parser* %l0
  %t9 = call %Parser @skip_trivia(%Parser %t8)
  store %Parser %t9, %Parser* %l0
  %t10 = load %Parser, %Parser* %l0
  %t11 = call double @parser_peek_raw(%Parser %t10)
  store double %t11, double* %l3
  %t13 = load double, double* %l3
  %t14 = load %Parser, %Parser* %l0
  %t15 = call %Parser @parser_advance_raw(%Parser %t14)
  store %Parser %t15, %Parser* %l0
  %t16 = load %Parser, %Parser* %l0
  %t17 = call %Parser @skip_trivia(%Parser %t16)
  %s18 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.18, i32 0, i32 0
  %t19 = alloca [1 x i8*]
  %t20 = getelementptr [1 x i8*], [1 x i8*]* %t19, i32 0, i32 0
  %t21 = getelementptr i8*, i8** %t20, i64 0
  store i8* %s18, i8** %t21
  %t22 = alloca { i8**, i64 }
  %t23 = getelementptr { i8**, i64 }, { i8**, i64 }* %t22, i32 0, i32 0
  store i8** %t20, i8*** %t23
  %t24 = getelementptr { i8**, i64 }, { i8**, i64 }* %t22, i32 0, i32 1
  store i64 1, i64* %t24
  %t25 = call %CaptureResult @collect_until(%Parser %t17, { i8**, i64 }* %t22)
  store %CaptureResult %t25, %CaptureResult* %l4
  %t26 = load %CaptureResult, %CaptureResult* %l4
  %t27 = extractvalue %CaptureResult %t26, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t28 = load %CaptureResult, %CaptureResult* %l4
  %t29 = extractvalue %CaptureResult %t28, 1
  %t30 = call double @expression_from_tokens({ i8**, i64 }* %t29)
  store double %t30, double* %l5
  %t31 = load %Parser, %Parser* %l0
  %t32 = call %Parser @skip_trivia(%Parser %t31)
  store %Parser %t32, %Parser* %l0
  %t33 = load %Parser, %Parser* %l0
  %t34 = call double @parser_peek_raw(%Parser %t33)
  store double %t34, double* %l6
  %t36 = load double, double* %l6
  %t37 = load %Parser, %Parser* %l0
  %t38 = call %Parser @parser_advance_raw(%Parser %t37)
  store %Parser %t38, %Parser* %l0
  store double 0.0, double* %l7
  %t39 = load %Parser, %Parser* %l0
  %t40 = insertvalue %ModelPropertyParseResult undef, i8* null, 0
  %t41 = load double, double* %l7
  %t42 = insertvalue %ModelPropertyParseResult %t40, i8* null, 1
  %t43 = insertvalue %ModelPropertyParseResult %t42, i1 1, 2
  ret %ModelPropertyParseResult %t43
}

define %MethodParseResult @parse_struct_method(%Parser %parser, { i8**, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca i1
  %l2 = alloca double
  %l3 = alloca %Parser
  %l4 = alloca double
  %l5 = alloca i8*
  %l6 = alloca double
  %l7 = alloca %TypeParameterParseResult
  %l8 = alloca { i8**, i64 }*
  %l9 = alloca %ParameterListParseResult
  %l10 = alloca { i8**, i64 }*
  %l11 = alloca i8*
  %l12 = alloca double
  %l13 = alloca %EffectParseResult
  %l14 = alloca { i8**, i64 }*
  %l15 = alloca double
  %l16 = alloca double
  %l17 = alloca %BlockParseResult
  %l18 = alloca i8*
  %l19 = alloca double
  %l20 = alloca double
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l0
  store i1 0, i1* %l1
  %t1 = load %Parser, %Parser* %l0
  %t2 = call double @parser_peek_raw(%Parser %t1)
  store double %t2, double* %l2
  %t3 = load double, double* %l2
  %s4 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.4, i32 0, i32 0
  %t5 = call i1 @identifier_matches(i8* null, i8* %s4)
  %t6 = load %Parser, %Parser* %l0
  %t7 = load i1, i1* %l1
  %t8 = load double, double* %l2
  br i1 %t5, label %then0, label %merge1
then0:
  %t9 = load %Parser, %Parser* %l0
  %t10 = call %Parser @parser_advance_raw(%Parser %t9)
  %t11 = call %Parser @skip_trivia(%Parser %t10)
  store %Parser %t11, %Parser* %l3
  %t12 = load %Parser, %Parser* %l3
  %t13 = call double @parser_peek_raw(%Parser %t12)
  %s14 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.14, i32 0, i32 0
  %t15 = call i1 @identifier_matches(i8* null, i8* %s14)
  %t16 = load %Parser, %Parser* %l0
  %t17 = load i1, i1* %l1
  %t18 = load double, double* %l2
  %t19 = load %Parser, %Parser* %l3
  br i1 %t15, label %then2, label %merge3
then2:
  %t20 = load %Parser, %Parser* %l0
  %s21 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.21, i32 0, i32 0
  %t22 = call %Parser @consume_keyword(%Parser %t20, i8* %s21)
  store %Parser %t22, %Parser* %l0
  store i1 1, i1* %l1
  br label %merge3
merge3:
  %t23 = phi %Parser [ %t22, %then2 ], [ %t16, %then0 ]
  %t24 = phi i1 [ 1, %then2 ], [ %t17, %then0 ]
  store %Parser %t23, %Parser* %l0
  store i1 %t24, i1* %l1
  br label %merge1
merge1:
  %t25 = phi %Parser [ %t22, %then0 ], [ %t6, %entry ]
  %t26 = phi i1 [ 1, %then0 ], [ %t7, %entry ]
  store %Parser %t25, %Parser* %l0
  store i1 %t26, i1* %l1
  %t27 = load %Parser, %Parser* %l0
  %t28 = call %Parser @skip_trivia(%Parser %t27)
  store %Parser %t28, %Parser* %l0
  %t29 = load %Parser, %Parser* %l0
  %t30 = call double @parser_peek_raw(%Parser %t29)
  %s31 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.31, i32 0, i32 0
  %t32 = call i1 @identifier_matches(i8* null, i8* %s31)
  %t33 = xor i1 %t32, 1
  %t34 = load %Parser, %Parser* %l0
  %t35 = load i1, i1* %l1
  %t36 = load double, double* %l2
  br i1 %t33, label %then4, label %merge5
then4:
  %t37 = insertvalue %MethodParseResult undef, i8* null, 0
  %t38 = insertvalue %MethodParseResult %t37, i8* null, 1
  %t39 = insertvalue %MethodParseResult %t38, i1 0, 2
  ret %MethodParseResult %t39
merge5:
  %t40 = load %Parser, %Parser* %l0
  %s41 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.41, i32 0, i32 0
  %t42 = call %Parser @consume_keyword(%Parser %t40, i8* %s41)
  store %Parser %t42, %Parser* %l0
  %t43 = load %Parser, %Parser* %l0
  %t44 = call %Parser @skip_trivia(%Parser %t43)
  store %Parser %t44, %Parser* %l0
  %t45 = load %Parser, %Parser* %l0
  %t46 = call double @parser_peek_raw(%Parser %t45)
  store double %t46, double* %l4
  %t47 = load double, double* %l4
  %t48 = load double, double* %l4
  %t49 = call i8* @identifier_text(i8* null)
  store i8* %t49, i8** %l5
  %t50 = load double, double* %l4
  %t51 = alloca [1 x double]
  %t52 = getelementptr [1 x double], [1 x double]* %t51, i32 0, i32 0
  %t53 = getelementptr double, double* %t52, i64 0
  store double %t50, double* %t53
  %t54 = alloca { double*, i64 }
  %t55 = getelementptr { double*, i64 }, { double*, i64 }* %t54, i32 0, i32 0
  store double* %t52, double** %t55
  %t56 = getelementptr { double*, i64 }, { double*, i64 }* %t54, i32 0, i32 1
  store i64 1, i64* %t56
  %t57 = call double @source_span_from_tokens({ i8**, i64 }* null)
  store double %t57, double* %l6
  %t58 = load %Parser, %Parser* %l0
  %t59 = call %Parser @parser_advance_raw(%Parser %t58)
  store %Parser %t59, %Parser* %l0
  %t60 = load %Parser, %Parser* %l0
  %t61 = call %TypeParameterParseResult @parse_type_parameter_clause(%Parser %t60)
  store %TypeParameterParseResult %t61, %TypeParameterParseResult* %l7
  %t62 = load %TypeParameterParseResult, %TypeParameterParseResult* %l7
  %t63 = extractvalue %TypeParameterParseResult %t62, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t64 = load %TypeParameterParseResult, %TypeParameterParseResult* %l7
  %t65 = extractvalue %TypeParameterParseResult %t64, 1
  store { i8**, i64 }* %t65, { i8**, i64 }** %l8
  %t66 = load %Parser, %Parser* %l0
  %t67 = call %Parser @skip_trivia(%Parser %t66)
  store %Parser %t67, %Parser* %l0
  %t68 = load %Parser, %Parser* %l0
  %s69 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.69, i32 0, i32 0
  %t70 = call %Parser @consume_symbol(%Parser %t68, i8* %s69)
  store %Parser %t70, %Parser* %l0
  %t71 = load %Parser, %Parser* %l0
  %t72 = call %ParameterListParseResult @parse_parameter_list(%Parser %t71)
  store %ParameterListParseResult %t72, %ParameterListParseResult* %l9
  %t73 = load %ParameterListParseResult, %ParameterListParseResult* %l9
  %t74 = extractvalue %ParameterListParseResult %t73, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t75 = load %ParameterListParseResult, %ParameterListParseResult* %l9
  %t76 = extractvalue %ParameterListParseResult %t75, 1
  store { i8**, i64 }* %t76, { i8**, i64 }** %l10
  %t77 = load %Parser, %Parser* %l0
  %t78 = call %Parser @skip_trivia(%Parser %t77)
  store %Parser %t78, %Parser* %l0
  store i8* null, i8** %l11
  %t79 = load %Parser, %Parser* %l0
  %t80 = call double @parser_peek_raw(%Parser %t79)
  store double %t80, double* %l12
  %t83 = load double, double* %l12
  %t84 = load %Parser, %Parser* %l0
  %t85 = call %EffectParseResult @parse_effect_list(%Parser %t84)
  store %EffectParseResult %t85, %EffectParseResult* %l13
  %t86 = load %EffectParseResult, %EffectParseResult* %l13
  %t87 = extractvalue %EffectParseResult %t86, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t88 = load %EffectParseResult, %EffectParseResult* %l13
  %t89 = extractvalue %EffectParseResult %t88, 1
  store { i8**, i64 }* %t89, { i8**, i64 }** %l14
  %t90 = call double @evaluate_decorators({ i8**, i64 }* %decorators)
  store double %t90, double* %l15
  %t91 = load { i8**, i64 }*, { i8**, i64 }** %l14
  %t92 = load double, double* %l15
  %t93 = call double @infer_effects({ i8**, i64 }* %t91, double %t92)
  store double %t93, double* %l16
  %t94 = load %Parser, %Parser* %l0
  %t95 = call %BlockParseResult @parse_block(%Parser %t94)
  store %BlockParseResult %t95, %BlockParseResult* %l17
  %t96 = load %BlockParseResult, %BlockParseResult* %l17
  %t97 = extractvalue %BlockParseResult %t96, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t98 = load %BlockParseResult, %BlockParseResult* %l17
  %t99 = extractvalue %BlockParseResult %t98, 1
  store i8* %t99, i8** %l18
  store double 0.0, double* %l19
  store double 0.0, double* %l20
  %t100 = load %Parser, %Parser* %l0
  %t101 = insertvalue %MethodParseResult undef, i8* null, 0
  %t102 = load double, double* %l20
  %t103 = insertvalue %MethodParseResult %t101, i8* null, 1
  %t104 = insertvalue %MethodParseResult %t103, i1 1, 2
  ret %MethodParseResult %t104
}

define %DecoratorParseResult @parse_decorators(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca %Parser
  %l4 = alloca double
  %l5 = alloca i8*
  %l6 = alloca { i8**, i64 }*
  %l7 = alloca double
  store %Parser %parser, %Parser* %l0
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t5 = load %Parser, %Parser* %l0
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %loop.header0
loop.header0:
  %t39 = phi %Parser [ %t5, %entry ], [ %t37, %loop.latch2 ]
  %t40 = phi { i8**, i64 }* [ %t6, %entry ], [ %t38, %loop.latch2 ]
  store %Parser %t39, %Parser* %l0
  store { i8**, i64 }* %t40, { i8**, i64 }** %l1
  br label %loop.body1
loop.body1:
  %t7 = load %Parser, %Parser* %l0
  %t8 = call %Parser @skip_trivia(%Parser %t7)
  store %Parser %t8, %Parser* %l0
  %t9 = load %Parser, %Parser* %l0
  %t10 = call double @parser_peek_raw(%Parser %t9)
  store double %t10, double* %l2
  %t12 = load double, double* %l2
  %t13 = load %Parser, %Parser* %l0
  store %Parser %t13, %Parser* %l3
  %t14 = load %Parser, %Parser* %l0
  %t15 = call %Parser @parser_advance_raw(%Parser %t14)
  store %Parser %t15, %Parser* %l0
  %t16 = load %Parser, %Parser* %l0
  %t17 = call %Parser @skip_trivia(%Parser %t16)
  store %Parser %t17, %Parser* %l0
  %t18 = load %Parser, %Parser* %l0
  %t19 = call double @parser_peek_raw(%Parser %t18)
  store double %t19, double* %l4
  %t20 = load double, double* %l4
  %t21 = load double, double* %l4
  %t22 = call i8* @identifier_text(i8* null)
  store i8* %t22, i8** %l5
  %t23 = load %Parser, %Parser* %l0
  %t24 = call %Parser @parser_advance_raw(%Parser %t23)
  store %Parser %t24, %Parser* %l0
  %t25 = load %Parser, %Parser* %l0
  %t26 = call %Parser @skip_trivia(%Parser %t25)
  store %Parser %t26, %Parser* %l0
  %t27 = alloca [0 x double]
  %t28 = getelementptr [0 x double], [0 x double]* %t27, i32 0, i32 0
  %t29 = alloca { double*, i64 }
  %t30 = getelementptr { double*, i64 }, { double*, i64 }* %t29, i32 0, i32 0
  store double* %t28, double** %t30
  %t31 = getelementptr { double*, i64 }, { double*, i64 }* %t29, i32 0, i32 1
  store i64 0, i64* %t31
  store { i8**, i64 }* null, { i8**, i64 }** %l6
  %t32 = load %Parser, %Parser* %l0
  %t33 = call double @parser_peek_raw(%Parser %t32)
  store double %t33, double* %l7
  %t35 = load double, double* %l7
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %loop.latch2
loop.latch2:
  %t37 = load %Parser, %Parser* %l0
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %loop.header0
afterloop3:
  %t41 = load %Parser, %Parser* %l0
  %t42 = insertvalue %DecoratorParseResult undef, i8* null, 0
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t44 = insertvalue %DecoratorParseResult %t42, { i8**, i64 }* %t43, 1
  ret %DecoratorParseResult %t44
}

define %TypeParameterParseResult @parse_type_parameter_clause(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca double
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca { i8**, i64 }*
  %l6 = alloca { i8**, i64 }*
  %l7 = alloca double
  %l8 = alloca { i8**, i64 }*
  %l9 = alloca double
  %l10 = alloca { i8**, i64 }*
  %l11 = alloca { i8**, i64 }*
  %l12 = alloca i8*
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l0
  %t1 = load %Parser, %Parser* %l0
  %t2 = call double @parser_peek_raw(%Parser %t1)
  store double %t2, double* %l1
  %t4 = load double, double* %l1
  %t5 = load %Parser, %Parser* %l0
  %t6 = call %Parser @parser_advance_raw(%Parser %t5)
  store %Parser %t6, %Parser* %l0
  %t7 = alloca [0 x double]
  %t8 = getelementptr [0 x double], [0 x double]* %t7, i32 0, i32 0
  %t9 = alloca { double*, i64 }
  %t10 = getelementptr { double*, i64 }, { double*, i64 }* %t9, i32 0, i32 0
  store double* %t8, double** %t10
  %t11 = getelementptr { double*, i64 }, { double*, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { i8**, i64 }* null, { i8**, i64 }** %l2
  %t12 = sitofp i64 1 to double
  store double %t12, double* %l3
  %t13 = load %Parser, %Parser* %l0
  %t14 = load double, double* %l1
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t16 = load double, double* %l3
  br label %loop.header0
loop.header0:
  %t28 = phi { i8**, i64 }* [ %t15, %entry ], [ %t26, %loop.latch2 ]
  %t29 = phi %Parser [ %t13, %entry ], [ %t27, %loop.latch2 ]
  store { i8**, i64 }* %t28, { i8**, i64 }** %l2
  store %Parser %t29, %Parser* %l0
  br label %loop.body1
loop.body1:
  %t17 = load %Parser, %Parser* %l0
  %t18 = call double @parser_peek_raw(%Parser %t17)
  store double %t18, double* %l4
  %t19 = load double, double* %l4
  %t20 = load double, double* %l4
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t22 = load double, double* %l4
  %t23 = call { i8**, i64 }* @append_token({ i8**, i64 }* %t21, i8* null)
  store { i8**, i64 }* %t23, { i8**, i64 }** %l2
  %t24 = load %Parser, %Parser* %l0
  %t25 = call %Parser @parser_advance_raw(%Parser %t24)
  store %Parser %t25, %Parser* %l0
  br label %loop.latch2
loop.latch2:
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t27 = load %Parser, %Parser* %l0
  br label %loop.header0
afterloop3:
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t31 = call { i8**, i64 }* @split_token_slices_by_comma({ i8**, i64 }* %t30)
  store { i8**, i64 }* %t31, { i8**, i64 }** %l5
  %t32 = alloca [0 x double]
  %t33 = getelementptr [0 x double], [0 x double]* %t32, i32 0, i32 0
  %t34 = alloca { double*, i64 }
  %t35 = getelementptr { double*, i64 }, { double*, i64 }* %t34, i32 0, i32 0
  store double* %t33, double** %t35
  %t36 = getelementptr { double*, i64 }, { double*, i64 }* %t34, i32 0, i32 1
  store i64 0, i64* %t36
  store { i8**, i64 }* null, { i8**, i64 }** %l6
  %t37 = sitofp i64 0 to double
  store double %t37, double* %l7
  %t38 = load %Parser, %Parser* %l0
  %t39 = load double, double* %l1
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t41 = load double, double* %l3
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t44 = load double, double* %l7
  br label %loop.header4
loop.header4:
  %t125 = phi double [ %t44, %entry ], [ %t124, %loop.latch6 ]
  store double %t125, double* %l7
  br label %loop.body5
loop.body5:
  %t45 = load double, double* %l7
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t47 = load { i8**, i64 }, { i8**, i64 }* %t46
  %t48 = extractvalue { i8**, i64 } %t47, 1
  %t49 = sitofp i64 %t48 to double
  %t50 = fcmp oge double %t45, %t49
  %t51 = load %Parser, %Parser* %l0
  %t52 = load double, double* %l1
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t54 = load double, double* %l3
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t57 = load double, double* %l7
  br i1 %t50, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t59 = load double, double* %l7
  %t60 = load { i8**, i64 }, { i8**, i64 }* %t58
  %t61 = extractvalue { i8**, i64 } %t60, 0
  %t62 = extractvalue { i8**, i64 } %t60, 1
  %t63 = icmp uge i64 %t59, %t62
  ; bounds check: %t63 (if true, out of bounds)
  %t64 = getelementptr i8*, i8** %t61, i64 %t59
  %t65 = load i8*, i8** %t64
  %t66 = call { i8**, i64 }* @trim_token_edges({ i8**, i64 }* null)
  store { i8**, i64 }* %t66, { i8**, i64 }** %l8
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t68 = load { i8**, i64 }, { i8**, i64 }* %t67
  %t69 = extractvalue { i8**, i64 } %t68, 1
  %t70 = icmp sgt i64 %t69, 0
  %t71 = load %Parser, %Parser* %l0
  %t72 = load double, double* %l1
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t74 = load double, double* %l3
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t77 = load double, double* %l7
  %t78 = load { i8**, i64 }*, { i8**, i64 }** %l8
  br i1 %t70, label %then10, label %merge11
then10:
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %s80 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.80, i32 0, i32 0
  %t81 = call double @find_top_level_symbol({ i8**, i64 }* %t79, i8* %s80)
  store double %t81, double* %l9
  %t82 = load { i8**, i64 }*, { i8**, i64 }** %l8
  store { i8**, i64 }* %t82, { i8**, i64 }** %l10
  %t83 = alloca [0 x double]
  %t84 = getelementptr [0 x double], [0 x double]* %t83, i32 0, i32 0
  %t85 = alloca { double*, i64 }
  %t86 = getelementptr { double*, i64 }, { double*, i64 }* %t85, i32 0, i32 0
  store double* %t84, double** %t86
  %t87 = getelementptr { double*, i64 }, { double*, i64 }* %t85, i32 0, i32 1
  store i64 0, i64* %t87
  store { i8**, i64 }* null, { i8**, i64 }** %l11
  %t88 = load double, double* %l9
  %t89 = sitofp i64 -1 to double
  %t90 = fcmp une double %t88, %t89
  %t91 = load %Parser, %Parser* %l0
  %t92 = load double, double* %l1
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t94 = load double, double* %l3
  %t95 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t96 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t97 = load double, double* %l7
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t99 = load double, double* %l9
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t101 = load { i8**, i64 }*, { i8**, i64 }** %l11
  br i1 %t90, label %then12, label %merge13
then12:
  %t102 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t103 = load double, double* %l9
  %t104 = sitofp i64 0 to double
  %t105 = call { i8**, i64 }* @token_slice({ i8**, i64 }* %t102, double %t104, double %t103)
  store { i8**, i64 }* %t105, { i8**, i64 }** %l10
  %t106 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t107 = load double, double* %l9
  %t108 = sitofp i64 1 to double
  %t109 = fadd double %t107, %t108
  %t110 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t111 = load { i8**, i64 }, { i8**, i64 }* %t110
  %t112 = extractvalue { i8**, i64 } %t111, 1
  %t113 = sitofp i64 %t112 to double
  %t114 = call { i8**, i64 }* @token_slice({ i8**, i64 }* %t106, double %t109, double %t113)
  store { i8**, i64 }* %t114, { i8**, i64 }** %l11
  br label %merge13
merge13:
  %t115 = phi { i8**, i64 }* [ %t105, %then12 ], [ %t100, %then10 ]
  %t116 = phi { i8**, i64 }* [ %t114, %then12 ], [ %t101, %then10 ]
  store { i8**, i64 }* %t115, { i8**, i64 }** %l10
  store { i8**, i64 }* %t116, { i8**, i64 }** %l11
  %t117 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t118 = call i8* @tokens_to_text({ i8**, i64 }* %t117)
  %t119 = call i8* @trim_text(i8* %t118)
  store i8* %t119, i8** %l12
  %t120 = load i8*, i8** %l12
  br label %merge11
merge11:
  %t121 = load double, double* %l7
  %t122 = sitofp i64 1 to double
  %t123 = fadd double %t121, %t122
  store double %t123, double* %l7
  br label %loop.latch6
loop.latch6:
  %t124 = load double, double* %l7
  br label %loop.header4
afterloop7:
  %t126 = load %Parser, %Parser* %l0
  %t127 = insertvalue %TypeParameterParseResult undef, i8* null, 0
  %t128 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t129 = insertvalue %TypeParameterParseResult %t127, { i8**, i64 }* %t128, 1
  ret %TypeParameterParseResult %t129
}

define %ImplementsParseResult @parse_implements_clause(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %CaptureResult
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca { i8**, i64 }*
  %l4 = alloca double
  %l5 = alloca i8*
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l0
  %t1 = load %Parser, %Parser* %l0
  %t2 = call double @parser_peek_raw(%Parser %t1)
  %s3 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.3, i32 0, i32 0
  %t4 = call i1 @identifier_matches(i8* null, i8* %s3)
  %t5 = xor i1 %t4, 1
  %t6 = load %Parser, %Parser* %l0
  br i1 %t5, label %then0, label %merge1
then0:
  %t7 = insertvalue %ImplementsParseResult undef, i8* null, 0
  %t8 = alloca [0 x double]
  %t9 = getelementptr [0 x double], [0 x double]* %t8, i32 0, i32 0
  %t10 = alloca { double*, i64 }
  %t11 = getelementptr { double*, i64 }, { double*, i64 }* %t10, i32 0, i32 0
  store double* %t9, double** %t11
  %t12 = getelementptr { double*, i64 }, { double*, i64 }* %t10, i32 0, i32 1
  store i64 0, i64* %t12
  %t13 = insertvalue %ImplementsParseResult %t7, { i8**, i64 }* null, 1
  %t14 = insertvalue %ImplementsParseResult %t13, i1 0, 2
  ret %ImplementsParseResult %t14
merge1:
  %t15 = load %Parser, %Parser* %l0
  %s16 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.16, i32 0, i32 0
  %t17 = call %Parser @consume_keyword(%Parser %t15, i8* %s16)
  store %Parser %t17, %Parser* %l0
  %t18 = load %Parser, %Parser* %l0
  %t19 = call %Parser @skip_trivia(%Parser %t18)
  store %Parser %t19, %Parser* %l0
  %t20 = load %Parser, %Parser* %l0
  %s21 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.21, i32 0, i32 0
  %t22 = alloca [1 x i8*]
  %t23 = getelementptr [1 x i8*], [1 x i8*]* %t22, i32 0, i32 0
  %t24 = getelementptr i8*, i8** %t23, i64 0
  store i8* %s21, i8** %t24
  %t25 = alloca { i8**, i64 }
  %t26 = getelementptr { i8**, i64 }, { i8**, i64 }* %t25, i32 0, i32 0
  store i8** %t23, i8*** %t26
  %t27 = getelementptr { i8**, i64 }, { i8**, i64 }* %t25, i32 0, i32 1
  store i64 1, i64* %t27
  %t28 = call %CaptureResult @collect_until(%Parser %t20, { i8**, i64 }* %t25)
  store %CaptureResult %t28, %CaptureResult* %l1
  %t29 = load %CaptureResult, %CaptureResult* %l1
  %t30 = extractvalue %CaptureResult %t29, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t31 = alloca [0 x double]
  %t32 = getelementptr [0 x double], [0 x double]* %t31, i32 0, i32 0
  %t33 = alloca { double*, i64 }
  %t34 = getelementptr { double*, i64 }, { double*, i64 }* %t33, i32 0, i32 0
  store double* %t32, double** %t34
  %t35 = getelementptr { double*, i64 }, { double*, i64 }* %t33, i32 0, i32 1
  store i64 0, i64* %t35
  store { i8**, i64 }* null, { i8**, i64 }** %l2
  %t36 = load %CaptureResult, %CaptureResult* %l1
  %t37 = extractvalue %CaptureResult %t36, 1
  %t38 = call { i8**, i64 }* @split_tokens_by_comma({ i8**, i64 }* %t37)
  store { i8**, i64 }* %t38, { i8**, i64 }** %l3
  %t39 = sitofp i64 0 to double
  store double %t39, double* %l4
  %t40 = load %Parser, %Parser* %l0
  %t41 = load %CaptureResult, %CaptureResult* %l1
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t44 = load double, double* %l4
  br label %loop.header2
loop.header2:
  %t70 = phi double [ %t44, %entry ], [ %t69, %loop.latch4 ]
  store double %t70, double* %l4
  br label %loop.body3
loop.body3:
  %t45 = load double, double* %l4
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t47 = load { i8**, i64 }, { i8**, i64 }* %t46
  %t48 = extractvalue { i8**, i64 } %t47, 1
  %t49 = sitofp i64 %t48 to double
  %t50 = fcmp oge double %t45, %t49
  %t51 = load %Parser, %Parser* %l0
  %t52 = load %CaptureResult, %CaptureResult* %l1
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t55 = load double, double* %l4
  br i1 %t50, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t57 = load double, double* %l4
  %t58 = load { i8**, i64 }, { i8**, i64 }* %t56
  %t59 = extractvalue { i8**, i64 } %t58, 0
  %t60 = extractvalue { i8**, i64 } %t58, 1
  %t61 = icmp uge i64 %t57, %t60
  ; bounds check: %t61 (if true, out of bounds)
  %t62 = getelementptr i8*, i8** %t59, i64 %t57
  %t63 = load i8*, i8** %t62
  %t64 = call i8* @trim_text(i8* %t63)
  store i8* %t64, i8** %l5
  %t65 = load i8*, i8** %l5
  %t66 = load double, double* %l4
  %t67 = sitofp i64 1 to double
  %t68 = fadd double %t66, %t67
  store double %t68, double* %l4
  br label %loop.latch4
loop.latch4:
  %t69 = load double, double* %l4
  br label %loop.header2
afterloop5:
  %t71 = load %Parser, %Parser* %l0
  %t72 = insertvalue %ImplementsParseResult undef, i8* null, 0
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t74 = insertvalue %ImplementsParseResult %t72, { i8**, i64 }* %t73, 1
  %t75 = insertvalue %ImplementsParseResult %t74, i1 1, 2
  ret %ImplementsParseResult %t75
}

define %ParameterParseResult @parse_single_parameter(%Parser %parser) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca i1
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca i8*
  %l6 = alloca i8*
  %l7 = alloca double
  %l8 = alloca i8*
  %l9 = alloca double
  %l10 = alloca double
  %l11 = alloca { i8**, i64 }*
  %l12 = alloca double
  %l13 = alloca double
  %t0 = extractvalue %Parser %parser, 0
  store { i8**, i64 }* %t0, { i8**, i64 }** %l0
  %t1 = extractvalue %Parser %parser, 1
  store double %t1, double* %l1
  store i1 0, i1* %l2
  %t2 = call double @parser_peek_raw(%Parser %parser)
  store double %t2, double* %l3
  %t3 = load double, double* %l3
  %s4 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.4, i32 0, i32 0
  %t5 = call i1 @identifier_matches(i8* null, i8* %s4)
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load double, double* %l1
  %t8 = load i1, i1* %l2
  %t9 = load double, double* %l3
  br i1 %t5, label %then0, label %merge1
then0:
  store i1 1, i1* %l2
  br label %merge1
merge1:
  %t10 = phi i1 [ 1, %then0 ], [ %t8, %entry ]
  store i1 %t10, i1* %l2
  %t11 = call double @parser_peek_raw(%Parser %parser)
  store double %t11, double* %l4
  %t12 = load double, double* %l4
  %t13 = call i8* @identifier_text(i8* null)
  store i8* %t13, i8** %l5
  store i8* null, i8** %l6
  %t14 = call double @parser_peek_raw(%Parser %parser)
  store double %t14, double* %l7
  %t17 = load double, double* %l7
  store i8* null, i8** %l8
  %t18 = call double @parser_peek_raw(%Parser %parser)
  store double %t18, double* %l9
  %t20 = load double, double* %l9
  %t21 = extractvalue %Parser %parser, 1
  store double %t21, double* %l10
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t23 = load double, double* %l1
  %t24 = load double, double* %l10
  %t25 = call { i8**, i64 }* @token_slice({ i8**, i64 }* %t22, double %t23, double %t24)
  store { i8**, i64 }* %t25, { i8**, i64 }** %l11
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %t27 = call double @source_span_from_tokens({ i8**, i64 }* %t26)
  store double %t27, double* %l12
  store double 0.0, double* %l13
  %t28 = insertvalue %ParameterParseResult undef, i8* null, 0
  %t29 = load double, double* %l13
  %t30 = insertvalue %ParameterParseResult %t28, i8* null, 1
  ret %ParameterParseResult %t30
}

define %EffectParseResult @parse_effect_list(%Parser %parser) {
entry:
  %l0 = alloca double
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %t0 = call double @parser_peek_raw(%Parser %parser)
  store double %t0, double* %l0
  %t2 = load double, double* %l0
  %t3 = alloca [0 x double]
  %t4 = getelementptr [0 x double], [0 x double]* %t3, i32 0, i32 0
  %t5 = alloca { double*, i64 }
  %t6 = getelementptr { double*, i64 }, { double*, i64 }* %t5, i32 0, i32 0
  store double* %t4, double** %t6
  %t7 = getelementptr { double*, i64 }, { double*, i64 }* %t5, i32 0, i32 1
  store i64 0, i64* %t7
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t8 = load double, double* %l0
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t10 = call double @parser_peek_raw(%Parser %parser)
  store double %t10, double* %l2
  %t12 = load double, double* %l2
  %t13 = load double, double* %l2
  br label %loop.latch2
loop.latch2:
  br label %loop.header0
afterloop3:
  %t14 = insertvalue %EffectParseResult undef, i8* null, 0
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t16 = insertvalue %EffectParseResult %t14, { i8**, i64 }* %t15, 1
  ret %EffectParseResult %t16
}

define %BlockParseResult @parse_block(%Parser %parser) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca %Parser
  %l3 = alloca double
  %l4 = alloca { i8**, i64 }*
  %l5 = alloca double
  %l6 = alloca %BlockStatementParseResult
  %l7 = alloca double
  %l8 = alloca %StatementParseResult
  %l9 = alloca double
  %l10 = alloca { i8**, i64 }*
  %l11 = alloca i8*
  %l12 = alloca double
  %t0 = call double @parser_peek_raw(%Parser %parser)
  store double %t0, double* %l0
  %t2 = load double, double* %l0
  %t3 = extractvalue %Parser %parser, 1
  store double %t3, double* %l1
  %t4 = call %Parser @parser_advance_raw(%Parser %parser)
  store %Parser %t4, %Parser* %l2
  %t5 = load double, double* %l1
  store double %t5, double* %l3
  %t6 = alloca [0 x double]
  %t7 = getelementptr [0 x double], [0 x double]* %t6, i32 0, i32 0
  %t8 = alloca { double*, i64 }
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t8, i32 0, i32 0
  store double* %t7, double** %t9
  %t10 = getelementptr { double*, i64 }, { double*, i64 }* %t8, i32 0, i32 1
  store i64 0, i64* %t10
  store { i8**, i64 }* null, { i8**, i64 }** %l4
  %t11 = load double, double* %l0
  %t12 = load double, double* %l1
  %t13 = load %Parser, %Parser* %l2
  %t14 = load double, double* %l3
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l4
  br label %loop.header0
loop.header0:
  %t77 = phi %Parser [ %t13, %entry ], [ %t75, %loop.latch2 ]
  %t78 = phi { i8**, i64 }* [ %t15, %entry ], [ %t76, %loop.latch2 ]
  store %Parser %t77, %Parser* %l2
  store { i8**, i64 }* %t78, { i8**, i64 }** %l4
  br label %loop.body1
loop.body1:
  %t16 = load %Parser, %Parser* %l2
  %t17 = call %Parser @skip_trivia(%Parser %t16)
  store %Parser %t17, %Parser* %l2
  %t18 = load %Parser, %Parser* %l2
  %t19 = call double @parser_peek_raw(%Parser %t18)
  store double %t19, double* %l5
  %t21 = load double, double* %l5
  %t22 = load double, double* %l5
  %t23 = load %Parser, %Parser* %l2
  %t24 = call %BlockStatementParseResult @parse_block_statement(%Parser %t23)
  store %BlockStatementParseResult %t24, %BlockStatementParseResult* %l6
  %t25 = load %BlockStatementParseResult, %BlockStatementParseResult* %l6
  %t26 = extractvalue %BlockStatementParseResult %t25, 2
  %t27 = load double, double* %l0
  %t28 = load double, double* %l1
  %t29 = load %Parser, %Parser* %l2
  %t30 = load double, double* %l3
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t32 = load double, double* %l5
  %t33 = load %BlockStatementParseResult, %BlockStatementParseResult* %l6
  br i1 %t26, label %then4, label %merge5
then4:
  %t34 = load %BlockStatementParseResult, %BlockStatementParseResult* %l6
  %t35 = extractvalue %BlockStatementParseResult %t34, 0
  store %Parser zeroinitializer, %Parser* %l2
  %t36 = load %BlockStatementParseResult, %BlockStatementParseResult* %l6
  %t37 = extractvalue %BlockStatementParseResult %t36, 1
  %t38 = icmp ne i8* %t37, null
  %t39 = load double, double* %l0
  %t40 = load double, double* %l1
  %t41 = load %Parser, %Parser* %l2
  %t42 = load double, double* %l3
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t44 = load double, double* %l5
  %t45 = load %BlockStatementParseResult, %BlockStatementParseResult* %l6
  br i1 %t38, label %then6, label %merge7
then6:
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t47 = load %BlockStatementParseResult, %BlockStatementParseResult* %l6
  %t48 = extractvalue %BlockStatementParseResult %t47, 1
  %t49 = call { i8**, i64 }* @append_statement({ i8**, i64 }* %t46, i8* %t48)
  store { i8**, i64 }* %t49, { i8**, i64 }** %l4
  br label %merge7
merge7:
  %t50 = phi { i8**, i64 }* [ %t49, %then6 ], [ %t43, %then4 ]
  store { i8**, i64 }* %t50, { i8**, i64 }** %l4
  br label %loop.latch2
merge5:
  %t51 = load %Parser, %Parser* %l2
  %t52 = extractvalue %Parser %t51, 1
  store double %t52, double* %l7
  %t53 = load %Parser, %Parser* %l2
  %t54 = call %StatementParseResult @parse_unknown(%Parser %t53)
  store %StatementParseResult %t54, %StatementParseResult* %l8
  %t55 = load %StatementParseResult, %StatementParseResult* %l8
  %t56 = extractvalue %StatementParseResult %t55, 0
  store %Parser zeroinitializer, %Parser* %l2
  %t57 = load %StatementParseResult, %StatementParseResult* %l8
  %t58 = extractvalue %StatementParseResult %t57, 1
  %t59 = load %Parser, %Parser* %l2
  %t60 = extractvalue %Parser %t59, 1
  %t61 = load double, double* %l7
  %t62 = fcmp ole double %t60, %t61
  %t63 = load double, double* %l0
  %t64 = load double, double* %l1
  %t65 = load %Parser, %Parser* %l2
  %t66 = load double, double* %l3
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t68 = load double, double* %l5
  %t69 = load %BlockStatementParseResult, %BlockStatementParseResult* %l6
  %t70 = load double, double* %l7
  %t71 = load %StatementParseResult, %StatementParseResult* %l8
  br i1 %t62, label %then8, label %merge9
then8:
  %t72 = load %Parser, %Parser* %l2
  %t73 = call %Parser @parser_advance_raw(%Parser %t72)
  store %Parser %t73, %Parser* %l2
  br label %merge9
merge9:
  %t74 = phi %Parser [ %t73, %then8 ], [ %t65, %loop.body1 ]
  store %Parser %t74, %Parser* %l2
  br label %loop.latch2
loop.latch2:
  %t75 = load %Parser, %Parser* %l2
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l4
  br label %loop.header0
afterloop3:
  %t79 = load %Parser, %Parser* %l2
  %t80 = extractvalue %Parser %t79, 1
  store double %t80, double* %l9
  %t81 = load double, double* %l3
  %t82 = load double, double* %l1
  %t83 = fcmp ogt double %t81, %t82
  %t84 = load double, double* %l0
  %t85 = load double, double* %l1
  %t86 = load %Parser, %Parser* %l2
  %t87 = load double, double* %l3
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t89 = load double, double* %l9
  br i1 %t83, label %then10, label %merge11
then10:
  %t90 = load double, double* %l3
  store double %t90, double* %l9
  br label %merge11
merge11:
  %t91 = phi double [ %t90, %then10 ], [ %t89, %entry ]
  store double %t91, double* %l9
  %t92 = extractvalue %Parser %parser, 0
  %t93 = load double, double* %l1
  %t94 = load double, double* %l9
  %t95 = call { i8**, i64 }* @token_slice({ i8**, i64 }* %t92, double %t93, double %t94)
  store { i8**, i64 }* %t95, { i8**, i64 }** %l10
  %t96 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t97 = call { i8**, i64 }* @trim_block_tokens({ i8**, i64 }* %t96)
  store { i8**, i64 }* %t97, { i8**, i64 }** %l10
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t99 = call i8* @tokens_to_text({ i8**, i64 }* %t98)
  store i8* %t99, i8** %l11
  store double 0.0, double* %l12
  %t100 = load %Parser, %Parser* %l2
  %t101 = call %Parser @skip_trivia(%Parser %t100)
  %t102 = insertvalue %BlockParseResult undef, i8* null, 0
  %t103 = load double, double* %l12
  %t104 = insertvalue %BlockParseResult %t102, i8* null, 1
  ret %BlockParseResult %t104
}

define %BlockStatementParseResult @parse_block_statement(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %DecoratorParseResult
  %l2 = alloca i8*
  %l3 = alloca { i8**, i64 }*
  %l4 = alloca %Parser
  %l5 = alloca double
  %l6 = alloca %BlockStatementParseResult
  store %Parser %parser, %Parser* %l0
  %t0 = call %DecoratorParseResult @parse_decorators(%Parser %parser)
  store %DecoratorParseResult %t0, %DecoratorParseResult* %l1
  %t1 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t2 = extractvalue %DecoratorParseResult %t1, 0
  store i8* %t2, i8** %l2
  %t3 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t4 = extractvalue %DecoratorParseResult %t3, 1
  store { i8**, i64 }* %t4, { i8**, i64 }** %l3
  %t5 = load i8*, i8** %l2
  %t6 = call %Parser @skip_trivia(%Parser zeroinitializer)
  store %Parser %t6, %Parser* %l4
  %t7 = load %Parser, %Parser* %l4
  %t8 = call double @parser_peek_raw(%Parser %t7)
  store double %t8, double* %l5
  %t9 = load double, double* %l5
  %s10 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.10, i32 0, i32 0
  %t11 = call i1 @identifier_matches(i8* null, i8* %s10)
  %t12 = load %Parser, %Parser* %l0
  %t13 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t14 = load i8*, i8** %l2
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t16 = load %Parser, %Parser* %l4
  %t17 = load double, double* %l5
  br i1 %t11, label %then0, label %merge1
then0:
  %t18 = load %Parser, %Parser* %l4
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t20 = call %BlockStatementParseResult @parse_for_statement(%Parser %t18, { i8**, i64 }* %t19)
  ret %BlockStatementParseResult %t20
merge1:
  %t21 = load double, double* %l5
  %s22 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.22, i32 0, i32 0
  %t23 = call i1 @identifier_matches(i8* null, i8* %s22)
  %t24 = load %Parser, %Parser* %l0
  %t25 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t26 = load i8*, i8** %l2
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t28 = load %Parser, %Parser* %l4
  %t29 = load double, double* %l5
  br i1 %t23, label %then2, label %merge3
then2:
  %t30 = load %Parser, %Parser* %l4
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t32 = call %BlockStatementParseResult @parse_loop_statement(%Parser %t30, { i8**, i64 }* %t31)
  ret %BlockStatementParseResult %t32
merge3:
  %t33 = load double, double* %l5
  %s34 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.34, i32 0, i32 0
  %t35 = call i1 @identifier_matches(i8* null, i8* %s34)
  %t36 = load %Parser, %Parser* %l0
  %t37 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t38 = load i8*, i8** %l2
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t40 = load %Parser, %Parser* %l4
  %t41 = load double, double* %l5
  br i1 %t35, label %then4, label %merge5
then4:
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t43 = load { i8**, i64 }, { i8**, i64 }* %t42
  %t44 = extractvalue { i8**, i64 } %t43, 1
  %t45 = icmp sgt i64 %t44, 0
  %t46 = load %Parser, %Parser* %l0
  %t47 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t48 = load i8*, i8** %l2
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t50 = load %Parser, %Parser* %l4
  %t51 = load double, double* %l5
  br i1 %t45, label %then6, label %merge7
then6:
  %t52 = load %Parser, %Parser* %l0
  %t53 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t54 = insertvalue %BlockStatementParseResult %t53, i8* null, 1
  %t55 = insertvalue %BlockStatementParseResult %t54, i1 0, 2
  ret %BlockStatementParseResult %t55
merge7:
  %t56 = load %Parser, %Parser* %l4
  %t57 = call %BlockStatementParseResult @parse_break_statement(%Parser %t56)
  ret %BlockStatementParseResult %t57
merge5:
  %t58 = load double, double* %l5
  %s59 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.59, i32 0, i32 0
  %t60 = call i1 @identifier_matches(i8* null, i8* %s59)
  %t61 = load %Parser, %Parser* %l0
  %t62 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t63 = load i8*, i8** %l2
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t65 = load %Parser, %Parser* %l4
  %t66 = load double, double* %l5
  br i1 %t60, label %then8, label %merge9
then8:
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t68 = load { i8**, i64 }, { i8**, i64 }* %t67
  %t69 = extractvalue { i8**, i64 } %t68, 1
  %t70 = icmp sgt i64 %t69, 0
  %t71 = load %Parser, %Parser* %l0
  %t72 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t73 = load i8*, i8** %l2
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t75 = load %Parser, %Parser* %l4
  %t76 = load double, double* %l5
  br i1 %t70, label %then10, label %merge11
then10:
  %t77 = load %Parser, %Parser* %l0
  %t78 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t79 = insertvalue %BlockStatementParseResult %t78, i8* null, 1
  %t80 = insertvalue %BlockStatementParseResult %t79, i1 0, 2
  ret %BlockStatementParseResult %t80
merge11:
  %t81 = load %Parser, %Parser* %l4
  %t82 = call %BlockStatementParseResult @parse_continue_statement(%Parser %t81)
  ret %BlockStatementParseResult %t82
merge9:
  %t83 = load double, double* %l5
  %s84 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.84, i32 0, i32 0
  %t85 = call i1 @identifier_matches(i8* null, i8* %s84)
  %t86 = load %Parser, %Parser* %l0
  %t87 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t88 = load i8*, i8** %l2
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t90 = load %Parser, %Parser* %l4
  %t91 = load double, double* %l5
  br i1 %t85, label %then12, label %merge13
then12:
  %t92 = load %Parser, %Parser* %l4
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t94 = call %BlockStatementParseResult @parse_if_statement(%Parser %t92, { i8**, i64 }* %t93)
  ret %BlockStatementParseResult %t94
merge13:
  %t95 = load double, double* %l5
  %s96 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.96, i32 0, i32 0
  %t97 = call i1 @identifier_matches(i8* null, i8* %s96)
  %t98 = load %Parser, %Parser* %l0
  %t99 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t100 = load i8*, i8** %l2
  %t101 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t102 = load %Parser, %Parser* %l4
  %t103 = load double, double* %l5
  br i1 %t97, label %then14, label %merge15
then14:
  %t104 = load %Parser, %Parser* %l4
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t106 = call %BlockStatementParseResult @parse_match_statement(%Parser %t104, { i8**, i64 }* %t105)
  ret %BlockStatementParseResult %t106
merge15:
  %t107 = load double, double* %l5
  %s108 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.108, i32 0, i32 0
  %t109 = call i1 @identifier_matches(i8* null, i8* %s108)
  %t110 = load %Parser, %Parser* %l0
  %t111 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t112 = load i8*, i8** %l2
  %t113 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t114 = load %Parser, %Parser* %l4
  %t115 = load double, double* %l5
  br i1 %t109, label %then16, label %merge17
then16:
  %t116 = load %Parser, %Parser* %l4
  %t117 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t118 = call %BlockStatementParseResult @parse_prompt_statement(%Parser %t116, { i8**, i64 }* %t117)
  ret %BlockStatementParseResult %t118
merge17:
  %t119 = load double, double* %l5
  %s120 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.120, i32 0, i32 0
  %t121 = call i1 @identifier_matches(i8* null, i8* %s120)
  %t122 = load %Parser, %Parser* %l0
  %t123 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t124 = load i8*, i8** %l2
  %t125 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t126 = load %Parser, %Parser* %l4
  %t127 = load double, double* %l5
  br i1 %t121, label %then18, label %merge19
then18:
  %t128 = load %Parser, %Parser* %l4
  %t129 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t130 = call %BlockStatementParseResult @parse_with_statement(%Parser %t128, { i8**, i64 }* %t129)
  ret %BlockStatementParseResult %t130
merge19:
  %t131 = load double, double* %l5
  %s132 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.132, i32 0, i32 0
  %t133 = call i1 @identifier_matches(i8* null, i8* %s132)
  %t134 = load %Parser, %Parser* %l0
  %t135 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t136 = load i8*, i8** %l2
  %t137 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t138 = load %Parser, %Parser* %l4
  %t139 = load double, double* %l5
  br i1 %t133, label %then20, label %merge21
then20:
  %t140 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t141 = load { i8**, i64 }, { i8**, i64 }* %t140
  %t142 = extractvalue { i8**, i64 } %t141, 1
  %t143 = icmp sgt i64 %t142, 0
  %t144 = load %Parser, %Parser* %l0
  %t145 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t146 = load i8*, i8** %l2
  %t147 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t148 = load %Parser, %Parser* %l4
  %t149 = load double, double* %l5
  br i1 %t143, label %then22, label %merge23
then22:
  %t150 = load %Parser, %Parser* %l0
  %t151 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t152 = insertvalue %BlockStatementParseResult %t151, i8* null, 1
  %t153 = insertvalue %BlockStatementParseResult %t152, i1 0, 2
  ret %BlockStatementParseResult %t153
merge23:
  %t154 = load %Parser, %Parser* %l4
  %t155 = call %BlockStatementParseResult @parse_return_statement(%Parser %t154)
  ret %BlockStatementParseResult %t155
merge21:
  %t156 = load %Parser, %Parser* %l4
  %t157 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t158 = call %BlockStatementParseResult @parse_expression_statement(%Parser %t156, { i8**, i64 }* %t157)
  store %BlockStatementParseResult %t158, %BlockStatementParseResult* %l6
  %t159 = load %BlockStatementParseResult, %BlockStatementParseResult* %l6
  %t160 = extractvalue %BlockStatementParseResult %t159, 2
  %t161 = load %Parser, %Parser* %l0
  %t162 = load %DecoratorParseResult, %DecoratorParseResult* %l1
  %t163 = load i8*, i8** %l2
  %t164 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t165 = load %Parser, %Parser* %l4
  %t166 = load double, double* %l5
  %t167 = load %BlockStatementParseResult, %BlockStatementParseResult* %l6
  br i1 %t160, label %then24, label %merge25
then24:
  %t168 = load %BlockStatementParseResult, %BlockStatementParseResult* %l6
  ret %BlockStatementParseResult %t168
merge25:
  %t169 = load %Parser, %Parser* %l0
  %t170 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t171 = insertvalue %BlockStatementParseResult %t170, i8* null, 1
  %t172 = insertvalue %BlockStatementParseResult %t171, i1 0, 2
  ret %BlockStatementParseResult %t172
}

define %BlockStatementParseResult @parse_for_statement(%Parser %parser, { i8**, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca %CaptureResult
  %l3 = alloca { i8**, i64 }*
  %l4 = alloca double
  %l5 = alloca { i8**, i64 }*
  %l6 = alloca { i8**, i64 }*
  %l7 = alloca double
  %l8 = alloca double
  %l9 = alloca double
  %l10 = alloca %BlockParseResult
  %l11 = alloca i8*
  %l12 = alloca double
  %l13 = alloca double
  store %Parser %parser, %Parser* %l0
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l1
  %t1 = load %Parser, %Parser* %l1
  %t2 = call double @parser_peek_raw(%Parser %t1)
  %s3 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.3, i32 0, i32 0
  %t4 = call i1 @identifier_matches(i8* null, i8* %s3)
  %t5 = xor i1 %t4, 1
  %t6 = load %Parser, %Parser* %l0
  %t7 = load %Parser, %Parser* %l1
  br i1 %t5, label %then0, label %merge1
then0:
  %t8 = load %Parser, %Parser* %l0
  %t9 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t10 = insertvalue %BlockStatementParseResult %t9, i8* null, 1
  %t11 = insertvalue %BlockStatementParseResult %t10, i1 0, 2
  ret %BlockStatementParseResult %t11
merge1:
  %t12 = load %Parser, %Parser* %l1
  %s13 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.13, i32 0, i32 0
  %t14 = call %Parser @consume_keyword(%Parser %t12, i8* %s13)
  store %Parser %t14, %Parser* %l1
  %t15 = load %Parser, %Parser* %l1
  %t16 = call %Parser @skip_trivia(%Parser %t15)
  %s17 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.17, i32 0, i32 0
  %t18 = alloca [1 x i8*]
  %t19 = getelementptr [1 x i8*], [1 x i8*]* %t18, i32 0, i32 0
  %t20 = getelementptr i8*, i8** %t19, i64 0
  store i8* %s17, i8** %t20
  %t21 = alloca { i8**, i64 }
  %t22 = getelementptr { i8**, i64 }, { i8**, i64 }* %t21, i32 0, i32 0
  store i8** %t19, i8*** %t22
  %t23 = getelementptr { i8**, i64 }, { i8**, i64 }* %t21, i32 0, i32 1
  store i64 1, i64* %t23
  %t24 = call %CaptureResult @collect_until(%Parser %t16, { i8**, i64 }* %t21)
  store %CaptureResult %t24, %CaptureResult* %l2
  %t25 = load %CaptureResult, %CaptureResult* %l2
  %t26 = extractvalue %CaptureResult %t25, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t27 = load %CaptureResult, %CaptureResult* %l2
  %t28 = extractvalue %CaptureResult %t27, 1
  %t29 = call { i8**, i64 }* @trim_token_edges({ i8**, i64 }* %t28)
  store { i8**, i64 }* %t29, { i8**, i64 }** %l3
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t31 = load { i8**, i64 }, { i8**, i64 }* %t30
  %t32 = extractvalue { i8**, i64 } %t31, 1
  %t33 = icmp eq i64 %t32, 0
  %t34 = load %Parser, %Parser* %l0
  %t35 = load %Parser, %Parser* %l1
  %t36 = load %CaptureResult, %CaptureResult* %l2
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l3
  br i1 %t33, label %then2, label %merge3
then2:
  %t38 = load %Parser, %Parser* %l0
  %t39 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t40 = insertvalue %BlockStatementParseResult %t39, i8* null, 1
  %t41 = insertvalue %BlockStatementParseResult %t40, i1 0, 2
  ret %BlockStatementParseResult %t41
merge3:
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %s43 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.43, i32 0, i32 0
  %t44 = call double @find_top_level_identifier({ i8**, i64 }* %t42, i8* %s43)
  store double %t44, double* %l4
  %t45 = load double, double* %l4
  %t46 = sitofp i64 -1 to double
  %t47 = fcmp oeq double %t45, %t46
  %t48 = load %Parser, %Parser* %l0
  %t49 = load %Parser, %Parser* %l1
  %t50 = load %CaptureResult, %CaptureResult* %l2
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t52 = load double, double* %l4
  br i1 %t47, label %then4, label %merge5
then4:
  %t53 = load %Parser, %Parser* %l0
  %t54 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t55 = insertvalue %BlockStatementParseResult %t54, i8* null, 1
  %t56 = insertvalue %BlockStatementParseResult %t55, i1 0, 2
  ret %BlockStatementParseResult %t56
merge5:
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t58 = load double, double* %l4
  %t59 = sitofp i64 0 to double
  %t60 = call { i8**, i64 }* @token_slice({ i8**, i64 }* %t57, double %t59, double %t58)
  %t61 = call { i8**, i64 }* @trim_token_edges({ i8**, i64 }* %t60)
  store { i8**, i64 }* %t61, { i8**, i64 }** %l5
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t63 = load double, double* %l4
  %t64 = sitofp i64 1 to double
  %t65 = fadd double %t63, %t64
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t67 = load { i8**, i64 }, { i8**, i64 }* %t66
  %t68 = extractvalue { i8**, i64 } %t67, 1
  %t69 = sitofp i64 %t68 to double
  %t70 = call { i8**, i64 }* @token_slice({ i8**, i64 }* %t62, double %t65, double %t69)
  %t71 = call { i8**, i64 }* @trim_token_edges({ i8**, i64 }* %t70)
  store { i8**, i64 }* %t71, { i8**, i64 }** %l6
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t74 = load { i8**, i64 }, { i8**, i64 }* %t73
  %t75 = extractvalue { i8**, i64 } %t74, 1
  %t76 = icmp eq i64 %t75, 0
  br label %logical_or_entry_72

logical_or_entry_72:
  br i1 %t76, label %logical_or_merge_72, label %logical_or_right_72

logical_or_right_72:
  %t77 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t78 = load { i8**, i64 }, { i8**, i64 }* %t77
  %t79 = extractvalue { i8**, i64 } %t78, 1
  %t80 = icmp eq i64 %t79, 0
  br label %logical_or_right_end_72

logical_or_right_end_72:
  br label %logical_or_merge_72

logical_or_merge_72:
  %t81 = phi i1 [ true, %logical_or_entry_72 ], [ %t80, %logical_or_right_end_72 ]
  %t82 = load %Parser, %Parser* %l0
  %t83 = load %Parser, %Parser* %l1
  %t84 = load %CaptureResult, %CaptureResult* %l2
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t86 = load double, double* %l4
  %t87 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l6
  br i1 %t81, label %then6, label %merge7
then6:
  %t89 = load %Parser, %Parser* %l0
  %t90 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t91 = insertvalue %BlockStatementParseResult %t90, i8* null, 1
  %t92 = insertvalue %BlockStatementParseResult %t91, i1 0, 2
  ret %BlockStatementParseResult %t92
merge7:
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t94 = call double @expression_from_tokens({ i8**, i64 }* %t93)
  store double %t94, double* %l7
  %t95 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t96 = call double @expression_from_tokens({ i8**, i64 }* %t95)
  store double %t96, double* %l8
  store double 0.0, double* %l9
  %t97 = load %Parser, %Parser* %l1
  %t98 = call %BlockParseResult @parse_block(%Parser %t97)
  store %BlockParseResult %t98, %BlockParseResult* %l10
  %t99 = load %BlockParseResult, %BlockParseResult* %l10
  %t100 = extractvalue %BlockParseResult %t99, 1
  %t101 = load %BlockParseResult, %BlockParseResult* %l10
  %t102 = extractvalue %BlockParseResult %t101, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t103 = load %BlockParseResult, %BlockParseResult* %l10
  %t104 = extractvalue %BlockParseResult %t103, 1
  store i8* %t104, i8** %l11
  %t105 = load %Parser, %Parser* %l1
  %t106 = call %Parser @skip_trivia(%Parser %t105)
  store %Parser %t106, %Parser* %l1
  %t107 = load %Parser, %Parser* %l1
  %t108 = call double @parser_peek_raw(%Parser %t107)
  store double %t108, double* %l12
  %t110 = load double, double* %l12
  store double 0.0, double* %l13
  %t111 = load %Parser, %Parser* %l1
  %t112 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t113 = load double, double* %l13
  %t114 = insertvalue %BlockStatementParseResult %t112, i8* null, 1
  %t115 = insertvalue %BlockStatementParseResult %t114, i1 1, 2
  ret %BlockStatementParseResult %t115
}

define %BlockStatementParseResult @parse_loop_statement(%Parser %parser, { i8**, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca %BlockParseResult
  %l3 = alloca double
  %l4 = alloca double
  store %Parser %parser, %Parser* %l0
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l1
  %t1 = load %Parser, %Parser* %l1
  %t2 = call double @parser_peek_raw(%Parser %t1)
  %s3 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.3, i32 0, i32 0
  %t4 = call i1 @identifier_matches(i8* null, i8* %s3)
  %t5 = xor i1 %t4, 1
  %t6 = load %Parser, %Parser* %l0
  %t7 = load %Parser, %Parser* %l1
  br i1 %t5, label %then0, label %merge1
then0:
  %t8 = load %Parser, %Parser* %l0
  %t9 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t10 = insertvalue %BlockStatementParseResult %t9, i8* null, 1
  %t11 = insertvalue %BlockStatementParseResult %t10, i1 0, 2
  ret %BlockStatementParseResult %t11
merge1:
  %t12 = load %Parser, %Parser* %l1
  %s13 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.13, i32 0, i32 0
  %t14 = call %Parser @consume_keyword(%Parser %t12, i8* %s13)
  store %Parser %t14, %Parser* %l1
  %t15 = load %Parser, %Parser* %l1
  %t16 = call %BlockParseResult @parse_block(%Parser %t15)
  store %BlockParseResult %t16, %BlockParseResult* %l2
  %t17 = load %BlockParseResult, %BlockParseResult* %l2
  %t18 = extractvalue %BlockParseResult %t17, 1
  %t19 = load %BlockParseResult, %BlockParseResult* %l2
  %t20 = extractvalue %BlockParseResult %t19, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t21 = load %Parser, %Parser* %l1
  %t22 = call %Parser @skip_trivia(%Parser %t21)
  store %Parser %t22, %Parser* %l1
  %t23 = load %Parser, %Parser* %l1
  %t24 = call double @parser_peek_raw(%Parser %t23)
  store double %t24, double* %l3
  %t26 = load double, double* %l3
  store double 0.0, double* %l4
  %t27 = load %Parser, %Parser* %l1
  %t28 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t29 = load double, double* %l4
  %t30 = insertvalue %BlockStatementParseResult %t28, i8* null, 1
  %t31 = insertvalue %BlockStatementParseResult %t30, i1 1, 2
  ret %BlockStatementParseResult %t31
}

define %BlockStatementParseResult @parse_break_statement(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca double
  store %Parser %parser, %Parser* %l0
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l1
  %t1 = load %Parser, %Parser* %l1
  %t2 = call double @parser_peek_raw(%Parser %t1)
  %s3 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.3, i32 0, i32 0
  %t4 = call i1 @identifier_matches(i8* null, i8* %s3)
  %t5 = xor i1 %t4, 1
  %t6 = load %Parser, %Parser* %l0
  %t7 = load %Parser, %Parser* %l1
  br i1 %t5, label %then0, label %merge1
then0:
  %t8 = load %Parser, %Parser* %l0
  %t9 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t10 = insertvalue %BlockStatementParseResult %t9, i8* null, 1
  %t11 = insertvalue %BlockStatementParseResult %t10, i1 0, 2
  ret %BlockStatementParseResult %t11
merge1:
  %t12 = load %Parser, %Parser* %l1
  %s13 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.13, i32 0, i32 0
  %t14 = call %Parser @consume_keyword(%Parser %t12, i8* %s13)
  store %Parser %t14, %Parser* %l1
  %t15 = load %Parser, %Parser* %l1
  %t16 = call %Parser @skip_trivia(%Parser %t15)
  store %Parser %t16, %Parser* %l1
  %t17 = load %Parser, %Parser* %l1
  %t18 = call double @parser_peek_raw(%Parser %t17)
  store double %t18, double* %l2
  %t20 = load double, double* %l2
  %t21 = load %Parser, %Parser* %l1
  %t22 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t23 = call double @StatementBreakStatement()
  %t24 = insertvalue %BlockStatementParseResult %t22, i8* null, 1
  %t25 = insertvalue %BlockStatementParseResult %t24, i1 1, 2
  ret %BlockStatementParseResult %t25
}

define %BlockStatementParseResult @parse_continue_statement(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca double
  store %Parser %parser, %Parser* %l0
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l1
  %t1 = load %Parser, %Parser* %l1
  %t2 = call double @parser_peek_raw(%Parser %t1)
  %s3 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.3, i32 0, i32 0
  %t4 = call i1 @identifier_matches(i8* null, i8* %s3)
  %t5 = xor i1 %t4, 1
  %t6 = load %Parser, %Parser* %l0
  %t7 = load %Parser, %Parser* %l1
  br i1 %t5, label %then0, label %merge1
then0:
  %t8 = load %Parser, %Parser* %l0
  %t9 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t10 = insertvalue %BlockStatementParseResult %t9, i8* null, 1
  %t11 = insertvalue %BlockStatementParseResult %t10, i1 0, 2
  ret %BlockStatementParseResult %t11
merge1:
  %t12 = load %Parser, %Parser* %l1
  %s13 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.13, i32 0, i32 0
  %t14 = call %Parser @consume_keyword(%Parser %t12, i8* %s13)
  store %Parser %t14, %Parser* %l1
  %t15 = load %Parser, %Parser* %l1
  %t16 = call %Parser @skip_trivia(%Parser %t15)
  store %Parser %t16, %Parser* %l1
  %t17 = load %Parser, %Parser* %l1
  %t18 = call double @parser_peek_raw(%Parser %t17)
  store double %t18, double* %l2
  %t20 = load double, double* %l2
  %t21 = load %Parser, %Parser* %l1
  %t22 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t23 = call double @StatementContinueStatement()
  %t24 = insertvalue %BlockStatementParseResult %t22, i8* null, 1
  %t25 = insertvalue %BlockStatementParseResult %t24, i1 1, 2
  ret %BlockStatementParseResult %t25
}

define %BlockStatementParseResult @parse_if_statement(%Parser %parser, { i8**, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca %CaptureResult
  %l3 = alloca { i8**, i64 }*
  %l4 = alloca double
  %l5 = alloca %BlockParseResult
  %l6 = alloca i8*
  %l7 = alloca i8*
  %l8 = alloca double
  %l9 = alloca %BlockStatementParseResult
  %l10 = alloca %BlockParseResult
  %l11 = alloca double
  %l12 = alloca double
  store %Parser %parser, %Parser* %l0
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l1
  %t1 = load %Parser, %Parser* %l1
  %t2 = call double @parser_peek_raw(%Parser %t1)
  %s3 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.3, i32 0, i32 0
  %t4 = call i1 @identifier_matches(i8* null, i8* %s3)
  %t5 = xor i1 %t4, 1
  %t6 = load %Parser, %Parser* %l0
  %t7 = load %Parser, %Parser* %l1
  br i1 %t5, label %then0, label %merge1
then0:
  %t8 = load %Parser, %Parser* %l0
  %t9 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t10 = insertvalue %BlockStatementParseResult %t9, i8* null, 1
  %t11 = insertvalue %BlockStatementParseResult %t10, i1 0, 2
  ret %BlockStatementParseResult %t11
merge1:
  %t12 = load %Parser, %Parser* %l1
  %s13 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.13, i32 0, i32 0
  %t14 = call %Parser @consume_keyword(%Parser %t12, i8* %s13)
  store %Parser %t14, %Parser* %l1
  %t15 = load %Parser, %Parser* %l1
  %t16 = call %Parser @skip_trivia(%Parser %t15)
  %s17 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.17, i32 0, i32 0
  %t18 = alloca [1 x i8*]
  %t19 = getelementptr [1 x i8*], [1 x i8*]* %t18, i32 0, i32 0
  %t20 = getelementptr i8*, i8** %t19, i64 0
  store i8* %s17, i8** %t20
  %t21 = alloca { i8**, i64 }
  %t22 = getelementptr { i8**, i64 }, { i8**, i64 }* %t21, i32 0, i32 0
  store i8** %t19, i8*** %t22
  %t23 = getelementptr { i8**, i64 }, { i8**, i64 }* %t21, i32 0, i32 1
  store i64 1, i64* %t23
  %t24 = call %CaptureResult @collect_until(%Parser %t16, { i8**, i64 }* %t21)
  store %CaptureResult %t24, %CaptureResult* %l2
  %t25 = load %CaptureResult, %CaptureResult* %l2
  %t26 = extractvalue %CaptureResult %t25, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t27 = load %CaptureResult, %CaptureResult* %l2
  %t28 = extractvalue %CaptureResult %t27, 1
  %t29 = call { i8**, i64 }* @trim_token_edges({ i8**, i64 }* %t28)
  store { i8**, i64 }* %t29, { i8**, i64 }** %l3
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t31 = load { i8**, i64 }, { i8**, i64 }* %t30
  %t32 = extractvalue { i8**, i64 } %t31, 1
  %t33 = icmp eq i64 %t32, 0
  %t34 = load %Parser, %Parser* %l0
  %t35 = load %Parser, %Parser* %l1
  %t36 = load %CaptureResult, %CaptureResult* %l2
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l3
  br i1 %t33, label %then2, label %merge3
then2:
  %t38 = load %Parser, %Parser* %l0
  %t39 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t40 = insertvalue %BlockStatementParseResult %t39, i8* null, 1
  %t41 = insertvalue %BlockStatementParseResult %t40, i1 0, 2
  ret %BlockStatementParseResult %t41
merge3:
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t43 = call double @expression_from_tokens({ i8**, i64 }* %t42)
  store double %t43, double* %l4
  %t44 = load %Parser, %Parser* %l1
  %t45 = call %BlockParseResult @parse_block(%Parser %t44)
  store %BlockParseResult %t45, %BlockParseResult* %l5
  %t46 = load %BlockParseResult, %BlockParseResult* %l5
  %t47 = extractvalue %BlockParseResult %t46, 1
  %t48 = load %BlockParseResult, %BlockParseResult* %l5
  %t49 = extractvalue %BlockParseResult %t48, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t50 = load %BlockParseResult, %BlockParseResult* %l5
  %t51 = extractvalue %BlockParseResult %t50, 1
  store i8* %t51, i8** %l6
  %t52 = load %Parser, %Parser* %l1
  %t53 = call %Parser @skip_trivia(%Parser %t52)
  store %Parser %t53, %Parser* %l1
  store i8* null, i8** %l7
  %t54 = load %Parser, %Parser* %l1
  %t55 = call double @parser_peek_raw(%Parser %t54)
  %s56 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.56, i32 0, i32 0
  %t57 = call i1 @identifier_matches(i8* null, i8* %s56)
  %t58 = load %Parser, %Parser* %l0
  %t59 = load %Parser, %Parser* %l1
  %t60 = load %CaptureResult, %CaptureResult* %l2
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t62 = load double, double* %l4
  %t63 = load %BlockParseResult, %BlockParseResult* %l5
  %t64 = load i8*, i8** %l6
  %t65 = load i8*, i8** %l7
  br i1 %t57, label %then4, label %merge5
then4:
  %t66 = load %Parser, %Parser* %l1
  %s67 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.67, i32 0, i32 0
  %t68 = call %Parser @consume_keyword(%Parser %t66, i8* %s67)
  store %Parser %t68, %Parser* %l1
  %t69 = load %Parser, %Parser* %l1
  %t70 = call %Parser @skip_trivia(%Parser %t69)
  store %Parser %t70, %Parser* %l1
  %t71 = load %Parser, %Parser* %l1
  %t72 = call double @parser_peek_raw(%Parser %t71)
  store double %t72, double* %l8
  %t73 = load double, double* %l8
  %s74 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.74, i32 0, i32 0
  %t75 = call i1 @identifier_matches(i8* null, i8* %s74)
  %t76 = load %Parser, %Parser* %l0
  %t77 = load %Parser, %Parser* %l1
  %t78 = load %CaptureResult, %CaptureResult* %l2
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t80 = load double, double* %l4
  %t81 = load %BlockParseResult, %BlockParseResult* %l5
  %t82 = load i8*, i8** %l6
  %t83 = load i8*, i8** %l7
  %t84 = load double, double* %l8
  br i1 %t75, label %then6, label %else7
then6:
  %t85 = load %Parser, %Parser* %l1
  %t86 = alloca [0 x double]
  %t87 = getelementptr [0 x double], [0 x double]* %t86, i32 0, i32 0
  %t88 = alloca { double*, i64 }
  %t89 = getelementptr { double*, i64 }, { double*, i64 }* %t88, i32 0, i32 0
  store double* %t87, double** %t89
  %t90 = getelementptr { double*, i64 }, { double*, i64 }* %t88, i32 0, i32 1
  store i64 0, i64* %t90
  %t91 = call %BlockStatementParseResult @parse_if_statement(%Parser %t85, { i8**, i64 }* null)
  store %BlockStatementParseResult %t91, %BlockStatementParseResult* %l9
  %t92 = load %BlockStatementParseResult, %BlockStatementParseResult* %l9
  %t93 = extractvalue %BlockStatementParseResult %t92, 2
  %t94 = xor i1 %t93, 1
  %t95 = load %Parser, %Parser* %l0
  %t96 = load %Parser, %Parser* %l1
  %t97 = load %CaptureResult, %CaptureResult* %l2
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t99 = load double, double* %l4
  %t100 = load %BlockParseResult, %BlockParseResult* %l5
  %t101 = load i8*, i8** %l6
  %t102 = load i8*, i8** %l7
  %t103 = load double, double* %l8
  %t104 = load %BlockStatementParseResult, %BlockStatementParseResult* %l9
  br i1 %t94, label %then9, label %merge10
then9:
  %t105 = load %Parser, %Parser* %l0
  %t106 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t107 = insertvalue %BlockStatementParseResult %t106, i8* null, 1
  %t108 = insertvalue %BlockStatementParseResult %t107, i1 0, 2
  ret %BlockStatementParseResult %t108
merge10:
  %t109 = load %BlockStatementParseResult, %BlockStatementParseResult* %l9
  %t110 = extractvalue %BlockStatementParseResult %t109, 1
  %t111 = icmp eq i8* %t110, null
  %t112 = load %Parser, %Parser* %l0
  %t113 = load %Parser, %Parser* %l1
  %t114 = load %CaptureResult, %CaptureResult* %l2
  %t115 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t116 = load double, double* %l4
  %t117 = load %BlockParseResult, %BlockParseResult* %l5
  %t118 = load i8*, i8** %l6
  %t119 = load i8*, i8** %l7
  %t120 = load double, double* %l8
  %t121 = load %BlockStatementParseResult, %BlockStatementParseResult* %l9
  br i1 %t111, label %then11, label %merge12
then11:
  %t122 = load %Parser, %Parser* %l0
  %t123 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t124 = insertvalue %BlockStatementParseResult %t123, i8* null, 1
  %t125 = insertvalue %BlockStatementParseResult %t124, i1 0, 2
  ret %BlockStatementParseResult %t125
merge12:
  %t126 = load %BlockStatementParseResult, %BlockStatementParseResult* %l9
  %t127 = extractvalue %BlockStatementParseResult %t126, 0
  store %Parser zeroinitializer, %Parser* %l1
  br label %merge8
else7:
  %t128 = load %Parser, %Parser* %l1
  %t129 = call %BlockParseResult @parse_block(%Parser %t128)
  store %BlockParseResult %t129, %BlockParseResult* %l10
  %t130 = load %BlockParseResult, %BlockParseResult* %l10
  %t131 = extractvalue %BlockParseResult %t130, 1
  %t132 = load %BlockParseResult, %BlockParseResult* %l10
  %t133 = extractvalue %BlockParseResult %t132, 0
  store %Parser zeroinitializer, %Parser* %l1
  br label %merge8
merge8:
  %t134 = phi %Parser [ zeroinitializer, %then6 ], [ zeroinitializer, %else7 ]
  %t135 = phi i8* [ null, %then6 ], [ null, %else7 ]
  store %Parser %t134, %Parser* %l1
  store i8* %t135, i8** %l7
  %t136 = load %Parser, %Parser* %l1
  %t137 = call %Parser @skip_trivia(%Parser %t136)
  store %Parser %t137, %Parser* %l1
  %t138 = load %Parser, %Parser* %l1
  %t139 = call double @parser_peek_raw(%Parser %t138)
  store double %t139, double* %l11
  %t141 = load double, double* %l11
  br label %merge5
merge5:
  %t142 = phi %Parser [ %t68, %then4 ], [ %t59, %entry ]
  %t143 = phi %Parser [ %t70, %then4 ], [ %t59, %entry ]
  %t144 = phi %Parser [ zeroinitializer, %then4 ], [ %t59, %entry ]
  %t145 = phi i8* [ null, %then4 ], [ %t65, %entry ]
  %t146 = phi %Parser [ zeroinitializer, %then4 ], [ %t59, %entry ]
  %t147 = phi i8* [ null, %then4 ], [ %t65, %entry ]
  %t148 = phi %Parser [ %t137, %then4 ], [ %t59, %entry ]
  store %Parser %t142, %Parser* %l1
  store %Parser %t143, %Parser* %l1
  store %Parser %t144, %Parser* %l1
  store i8* %t145, i8** %l7
  store %Parser %t146, %Parser* %l1
  store i8* %t147, i8** %l7
  store %Parser %t148, %Parser* %l1
  store double 0.0, double* %l12
  %t149 = load %Parser, %Parser* %l1
  %t150 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t151 = load double, double* %l12
  %t152 = insertvalue %BlockStatementParseResult %t150, i8* null, 1
  %t153 = insertvalue %BlockStatementParseResult %t152, i1 1, 2
  ret %BlockStatementParseResult %t153
}

define %BlockStatementParseResult @parse_match_statement(%Parser %parser, { i8**, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca %CaptureResult
  %l3 = alloca { i8**, i64 }*
  %l4 = alloca double
  %l5 = alloca %MatchCasesParseResult
  %l6 = alloca double
  %l7 = alloca double
  store %Parser %parser, %Parser* %l0
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l1
  %t1 = load %Parser, %Parser* %l1
  %t2 = call double @parser_peek_raw(%Parser %t1)
  %s3 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.3, i32 0, i32 0
  %t4 = call i1 @identifier_matches(i8* null, i8* %s3)
  %t5 = xor i1 %t4, 1
  %t6 = load %Parser, %Parser* %l0
  %t7 = load %Parser, %Parser* %l1
  br i1 %t5, label %then0, label %merge1
then0:
  %t8 = load %Parser, %Parser* %l0
  %t9 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t10 = insertvalue %BlockStatementParseResult %t9, i8* null, 1
  %t11 = insertvalue %BlockStatementParseResult %t10, i1 0, 2
  ret %BlockStatementParseResult %t11
merge1:
  %t12 = load %Parser, %Parser* %l1
  %s13 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.13, i32 0, i32 0
  %t14 = call %Parser @consume_keyword(%Parser %t12, i8* %s13)
  store %Parser %t14, %Parser* %l1
  %t15 = load %Parser, %Parser* %l1
  %t16 = call %Parser @skip_trivia(%Parser %t15)
  %s17 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.17, i32 0, i32 0
  %t18 = alloca [1 x i8*]
  %t19 = getelementptr [1 x i8*], [1 x i8*]* %t18, i32 0, i32 0
  %t20 = getelementptr i8*, i8** %t19, i64 0
  store i8* %s17, i8** %t20
  %t21 = alloca { i8**, i64 }
  %t22 = getelementptr { i8**, i64 }, { i8**, i64 }* %t21, i32 0, i32 0
  store i8** %t19, i8*** %t22
  %t23 = getelementptr { i8**, i64 }, { i8**, i64 }* %t21, i32 0, i32 1
  store i64 1, i64* %t23
  %t24 = call %CaptureResult @collect_until(%Parser %t16, { i8**, i64 }* %t21)
  store %CaptureResult %t24, %CaptureResult* %l2
  %t25 = load %CaptureResult, %CaptureResult* %l2
  %t26 = extractvalue %CaptureResult %t25, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t27 = load %CaptureResult, %CaptureResult* %l2
  %t28 = extractvalue %CaptureResult %t27, 1
  %t29 = call { i8**, i64 }* @trim_token_edges({ i8**, i64 }* %t28)
  store { i8**, i64 }* %t29, { i8**, i64 }** %l3
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t31 = load { i8**, i64 }, { i8**, i64 }* %t30
  %t32 = extractvalue { i8**, i64 } %t31, 1
  %t33 = icmp eq i64 %t32, 0
  %t34 = load %Parser, %Parser* %l0
  %t35 = load %Parser, %Parser* %l1
  %t36 = load %CaptureResult, %CaptureResult* %l2
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l3
  br i1 %t33, label %then2, label %merge3
then2:
  %t38 = load %Parser, %Parser* %l0
  %t39 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t40 = insertvalue %BlockStatementParseResult %t39, i8* null, 1
  %t41 = insertvalue %BlockStatementParseResult %t40, i1 0, 2
  ret %BlockStatementParseResult %t41
merge3:
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t43 = call double @expression_from_tokens({ i8**, i64 }* %t42)
  store double %t43, double* %l4
  %t44 = load %Parser, %Parser* %l1
  %t45 = call %MatchCasesParseResult @parse_match_cases(%Parser %t44)
  store %MatchCasesParseResult %t45, %MatchCasesParseResult* %l5
  %t46 = load %MatchCasesParseResult, %MatchCasesParseResult* %l5
  %t47 = extractvalue %MatchCasesParseResult %t46, 2
  %t48 = xor i1 %t47, 1
  %t49 = load %Parser, %Parser* %l0
  %t50 = load %Parser, %Parser* %l1
  %t51 = load %CaptureResult, %CaptureResult* %l2
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t53 = load double, double* %l4
  %t54 = load %MatchCasesParseResult, %MatchCasesParseResult* %l5
  br i1 %t48, label %then4, label %merge5
then4:
  %t55 = load %Parser, %Parser* %l0
  %t56 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t57 = insertvalue %BlockStatementParseResult %t56, i8* null, 1
  %t58 = insertvalue %BlockStatementParseResult %t57, i1 0, 2
  ret %BlockStatementParseResult %t58
merge5:
  %t59 = load %MatchCasesParseResult, %MatchCasesParseResult* %l5
  %t60 = extractvalue %MatchCasesParseResult %t59, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t61 = load %Parser, %Parser* %l1
  %t62 = call %Parser @skip_trivia(%Parser %t61)
  store %Parser %t62, %Parser* %l1
  %t63 = load %Parser, %Parser* %l1
  %t64 = extractvalue %Parser %t63, 1
  %t65 = load %Parser, %Parser* %l1
  %t66 = extractvalue %Parser %t65, 0
  %t67 = load { i8**, i64 }, { i8**, i64 }* %t66
  %t68 = extractvalue { i8**, i64 } %t67, 1
  %t69 = sitofp i64 %t68 to double
  %t70 = fcmp olt double %t64, %t69
  %t71 = load %Parser, %Parser* %l0
  %t72 = load %Parser, %Parser* %l1
  %t73 = load %CaptureResult, %CaptureResult* %l2
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t75 = load double, double* %l4
  %t76 = load %MatchCasesParseResult, %MatchCasesParseResult* %l5
  br i1 %t70, label %then6, label %merge7
then6:
  %t77 = load %Parser, %Parser* %l1
  %t78 = call double @parser_peek_raw(%Parser %t77)
  store double %t78, double* %l6
  %t80 = load double, double* %l6
  br label %merge7
merge7:
  store double 0.0, double* %l7
  %t81 = load %Parser, %Parser* %l1
  %t82 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t83 = load double, double* %l7
  %t84 = insertvalue %BlockStatementParseResult %t82, i8* null, 1
  %t85 = insertvalue %BlockStatementParseResult %t84, i1 1, 2
  ret %BlockStatementParseResult %t85
}

define %MatchCasesParseResult @parse_match_cases(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca double
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca double
  %l4 = alloca %MatchCaseParseResult
  %l5 = alloca double
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l0
  %t1 = load %Parser, %Parser* %l0
  %s2 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.2, i32 0, i32 0
  %t3 = call %Parser @advance_to_symbol(%Parser %t1, i8* %s2)
  store %Parser %t3, %Parser* %l0
  %t4 = load %Parser, %Parser* %l0
  %t5 = call double @parser_peek_raw(%Parser %t4)
  store double %t5, double* %l1
  %t7 = load double, double* %l1
  %t8 = load %Parser, %Parser* %l0
  %t9 = call %Parser @parser_advance_raw(%Parser %t8)
  store %Parser %t9, %Parser* %l0
  %t10 = alloca [0 x double]
  %t11 = getelementptr [0 x double], [0 x double]* %t10, i32 0, i32 0
  %t12 = alloca { double*, i64 }
  %t13 = getelementptr { double*, i64 }, { double*, i64 }* %t12, i32 0, i32 0
  store double* %t11, double** %t13
  %t14 = getelementptr { double*, i64 }, { double*, i64 }* %t12, i32 0, i32 1
  store i64 0, i64* %t14
  store { i8**, i64 }* null, { i8**, i64 }** %l2
  %t15 = load %Parser, %Parser* %l0
  %t16 = load double, double* %l1
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br label %loop.header0
loop.header0:
  %t62 = phi %Parser [ %t15, %entry ], [ %t60, %loop.latch2 ]
  %t63 = phi { i8**, i64 }* [ %t17, %entry ], [ %t61, %loop.latch2 ]
  store %Parser %t62, %Parser* %l0
  store { i8**, i64 }* %t63, { i8**, i64 }** %l2
  br label %loop.body1
loop.body1:
  %t18 = load %Parser, %Parser* %l0
  %t19 = call %Parser @skip_trivia(%Parser %t18)
  store %Parser %t19, %Parser* %l0
  %t20 = load %Parser, %Parser* %l0
  %t21 = call double @parser_peek_raw(%Parser %t20)
  store double %t21, double* %l3
  %t23 = load double, double* %l3
  %t24 = load double, double* %l3
  %t25 = load %Parser, %Parser* %l0
  %t26 = call %MatchCaseParseResult @parse_match_case(%Parser %t25)
  store %MatchCaseParseResult %t26, %MatchCaseParseResult* %l4
  %t28 = load %MatchCaseParseResult, %MatchCaseParseResult* %l4
  %t29 = extractvalue %MatchCaseParseResult %t28, 2
  br label %logical_or_entry_27

logical_or_entry_27:
  br i1 %t29, label %logical_or_merge_27, label %logical_or_right_27

logical_or_right_27:
  %t30 = load %MatchCaseParseResult, %MatchCaseParseResult* %l4
  %t31 = extractvalue %MatchCaseParseResult %t30, 1
  %t32 = icmp eq i8* %t31, null
  br label %logical_or_right_end_27

logical_or_right_end_27:
  br label %logical_or_merge_27

logical_or_merge_27:
  %t33 = phi i1 [ true, %logical_or_entry_27 ], [ %t32, %logical_or_right_end_27 ]
  %t34 = xor i1 %t33, 1
  %t35 = load %Parser, %Parser* %l0
  %t36 = load double, double* %l1
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t38 = load double, double* %l3
  %t39 = load %MatchCaseParseResult, %MatchCaseParseResult* %l4
  br i1 %t34, label %then4, label %merge5
then4:
  %t40 = insertvalue %MatchCasesParseResult undef, i8* null, 0
  %t41 = alloca [0 x double]
  %t42 = getelementptr [0 x double], [0 x double]* %t41, i32 0, i32 0
  %t43 = alloca { double*, i64 }
  %t44 = getelementptr { double*, i64 }, { double*, i64 }* %t43, i32 0, i32 0
  store double* %t42, double** %t44
  %t45 = getelementptr { double*, i64 }, { double*, i64 }* %t43, i32 0, i32 1
  store i64 0, i64* %t45
  %t46 = insertvalue %MatchCasesParseResult %t40, { i8**, i64 }* null, 1
  %t47 = insertvalue %MatchCasesParseResult %t46, i1 0, 2
  ret %MatchCasesParseResult %t47
merge5:
  %t48 = load %MatchCaseParseResult, %MatchCaseParseResult* %l4
  %t49 = extractvalue %MatchCaseParseResult %t48, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t51 = load %MatchCaseParseResult, %MatchCaseParseResult* %l4
  %t52 = extractvalue %MatchCaseParseResult %t51, 1
  %t53 = call { i8**, i64 }* @append_match_case({ i8**, i64 }* %t50, i8* %t52)
  store { i8**, i64 }* %t53, { i8**, i64 }** %l2
  %t54 = load %Parser, %Parser* %l0
  %t55 = call %Parser @skip_trivia(%Parser %t54)
  store %Parser %t55, %Parser* %l0
  %t56 = load %Parser, %Parser* %l0
  %t57 = call double @parser_peek_raw(%Parser %t56)
  store double %t57, double* %l5
  %t59 = load double, double* %l5
  br label %loop.latch2
loop.latch2:
  %t60 = load %Parser, %Parser* %l0
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br label %loop.header0
afterloop3:
  %t64 = load %Parser, %Parser* %l0
  %t65 = insertvalue %MatchCasesParseResult undef, i8* null, 0
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t67 = insertvalue %MatchCasesParseResult %t65, { i8**, i64 }* %t66, 1
  %t68 = insertvalue %MatchCasesParseResult %t67, i1 1, 2
  ret %MatchCasesParseResult %t68
}

define %MatchCaseParseResult @parse_match_case(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca %PatternCaptureResult
  %l3 = alloca %MatchCaseTokenSplit
  %l4 = alloca double
  %l5 = alloca i8*
  %l6 = alloca double
  %l7 = alloca i8*
  %l8 = alloca double
  store %Parser %parser, %Parser* %l0
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l1
  %t1 = load %Parser, %Parser* %l1
  %t2 = call double @parser_peek_raw(%Parser %t1)
  %s3 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.3, i32 0, i32 0
  %t4 = call i1 @identifier_matches(i8* null, i8* %s3)
  %t5 = load %Parser, %Parser* %l0
  %t6 = load %Parser, %Parser* %l1
  br i1 %t4, label %then0, label %merge1
then0:
  %t7 = load %Parser, %Parser* %l1
  %s8 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.8, i32 0, i32 0
  %t9 = call %Parser @consume_keyword(%Parser %t7, i8* %s8)
  store %Parser %t9, %Parser* %l1
  %t10 = load %Parser, %Parser* %l1
  %t11 = call %Parser @skip_trivia(%Parser %t10)
  store %Parser %t11, %Parser* %l1
  br label %merge1
merge1:
  %t12 = phi %Parser [ %t9, %then0 ], [ %t6, %entry ]
  %t13 = phi %Parser [ %t11, %then0 ], [ %t6, %entry ]
  store %Parser %t12, %Parser* %l1
  store %Parser %t13, %Parser* %l1
  %t14 = load %Parser, %Parser* %l1
  %t15 = call %PatternCaptureResult @collect_pattern_until_arrow(%Parser %t14)
  store %PatternCaptureResult %t15, %PatternCaptureResult* %l2
  %t16 = load %PatternCaptureResult, %PatternCaptureResult* %l2
  %t17 = extractvalue %PatternCaptureResult %t16, 2
  %t18 = xor i1 %t17, 1
  %t19 = load %Parser, %Parser* %l0
  %t20 = load %Parser, %Parser* %l1
  %t21 = load %PatternCaptureResult, %PatternCaptureResult* %l2
  br i1 %t18, label %then2, label %merge3
then2:
  %t22 = load %Parser, %Parser* %l0
  %t23 = insertvalue %MatchCaseParseResult undef, i8* null, 0
  %t24 = insertvalue %MatchCaseParseResult %t23, i8* null, 1
  %t25 = insertvalue %MatchCaseParseResult %t24, i1 0, 2
  ret %MatchCaseParseResult %t25
merge3:
  %t26 = load %PatternCaptureResult, %PatternCaptureResult* %l2
  %t27 = extractvalue %PatternCaptureResult %t26, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t28 = load %PatternCaptureResult, %PatternCaptureResult* %l2
  %t29 = extractvalue %PatternCaptureResult %t28, 1
  %t30 = call %MatchCaseTokenSplit @split_match_case_tokens({ i8**, i64 }* %t29)
  store %MatchCaseTokenSplit %t30, %MatchCaseTokenSplit* %l3
  %t31 = load %MatchCaseTokenSplit, %MatchCaseTokenSplit* %l3
  %t32 = extractvalue %MatchCaseTokenSplit %t31, 0
  %t33 = load { i8**, i64 }, { i8**, i64 }* %t32
  %t34 = extractvalue { i8**, i64 } %t33, 1
  %t35 = icmp eq i64 %t34, 0
  %t36 = load %Parser, %Parser* %l0
  %t37 = load %Parser, %Parser* %l1
  %t38 = load %PatternCaptureResult, %PatternCaptureResult* %l2
  %t39 = load %MatchCaseTokenSplit, %MatchCaseTokenSplit* %l3
  br i1 %t35, label %then4, label %merge5
then4:
  %t40 = load %Parser, %Parser* %l0
  %t41 = insertvalue %MatchCaseParseResult undef, i8* null, 0
  %t42 = insertvalue %MatchCaseParseResult %t41, i8* null, 1
  %t43 = insertvalue %MatchCaseParseResult %t42, i1 0, 2
  ret %MatchCaseParseResult %t43
merge5:
  %t44 = load %MatchCaseTokenSplit, %MatchCaseTokenSplit* %l3
  %t45 = extractvalue %MatchCaseTokenSplit %t44, 0
  %t46 = call double @expression_from_tokens({ i8**, i64 }* %t45)
  store double %t46, double* %l4
  store i8* null, i8** %l5
  %t47 = load %MatchCaseTokenSplit, %MatchCaseTokenSplit* %l3
  %t48 = extractvalue %MatchCaseTokenSplit %t47, 2
  %t49 = load %Parser, %Parser* %l0
  %t50 = load %Parser, %Parser* %l1
  %t51 = load %PatternCaptureResult, %PatternCaptureResult* %l2
  %t52 = load %MatchCaseTokenSplit, %MatchCaseTokenSplit* %l3
  %t53 = load double, double* %l4
  %t54 = load i8*, i8** %l5
  br i1 %t48, label %then6, label %merge7
then6:
  %t55 = load %MatchCaseTokenSplit, %MatchCaseTokenSplit* %l3
  %t56 = extractvalue %MatchCaseTokenSplit %t55, 1
  %t57 = load { i8**, i64 }, { i8**, i64 }* %t56
  %t58 = extractvalue { i8**, i64 } %t57, 1
  %t59 = icmp eq i64 %t58, 0
  %t60 = load %Parser, %Parser* %l0
  %t61 = load %Parser, %Parser* %l1
  %t62 = load %PatternCaptureResult, %PatternCaptureResult* %l2
  %t63 = load %MatchCaseTokenSplit, %MatchCaseTokenSplit* %l3
  %t64 = load double, double* %l4
  %t65 = load i8*, i8** %l5
  br i1 %t59, label %then8, label %merge9
then8:
  %t66 = load %Parser, %Parser* %l0
  %t67 = insertvalue %MatchCaseParseResult undef, i8* null, 0
  %t68 = insertvalue %MatchCaseParseResult %t67, i8* null, 1
  %t69 = insertvalue %MatchCaseParseResult %t68, i1 0, 2
  ret %MatchCaseParseResult %t69
merge9:
  %t70 = load %MatchCaseTokenSplit, %MatchCaseTokenSplit* %l3
  %t71 = extractvalue %MatchCaseTokenSplit %t70, 1
  %t72 = call double @expression_from_tokens({ i8**, i64 }* %t71)
  store i8* null, i8** %l5
  br label %merge7
merge7:
  %t73 = phi i8* [ null, %then6 ], [ %t54, %entry ]
  store i8* %t73, i8** %l5
  %t74 = load %Parser, %Parser* %l1
  %t75 = call %Parser @skip_trivia(%Parser %t74)
  store %Parser %t75, %Parser* %l1
  %t76 = load %Parser, %Parser* %l1
  %t77 = call double @parser_peek_raw(%Parser %t76)
  store double %t77, double* %l6
  store i8* null, i8** %l7
  %t79 = load double, double* %l6
  %t80 = load i8*, i8** %l7
  %t81 = icmp eq i8* %t80, null
  %t82 = load %Parser, %Parser* %l0
  %t83 = load %Parser, %Parser* %l1
  %t84 = load %PatternCaptureResult, %PatternCaptureResult* %l2
  %t85 = load %MatchCaseTokenSplit, %MatchCaseTokenSplit* %l3
  %t86 = load double, double* %l4
  %t87 = load i8*, i8** %l5
  %t88 = load double, double* %l6
  %t89 = load i8*, i8** %l7
  br i1 %t81, label %then10, label %merge11
then10:
  %t90 = load %Parser, %Parser* %l0
  %t91 = insertvalue %MatchCaseParseResult undef, i8* null, 0
  %t92 = insertvalue %MatchCaseParseResult %t91, i8* null, 1
  %t93 = insertvalue %MatchCaseParseResult %t92, i1 0, 2
  ret %MatchCaseParseResult %t93
merge11:
  store double 0.0, double* %l8
  %t94 = load %Parser, %Parser* %l1
  %t95 = insertvalue %MatchCaseParseResult undef, i8* null, 0
  %t96 = load double, double* %l8
  %t97 = insertvalue %MatchCaseParseResult %t95, i8* null, 1
  %t98 = insertvalue %MatchCaseParseResult %t97, i1 1, 2
  ret %MatchCaseParseResult %t98
}

define %BlockStatementParseResult @parse_prompt_statement(%Parser %parser, { i8**, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca %BlockParseResult
  %l6 = alloca i8*
  %l7 = alloca double
  store %Parser %parser, %Parser* %l0
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l1
  %t1 = load %Parser, %Parser* %l1
  %t2 = call double @parser_peek_raw(%Parser %t1)
  store double %t2, double* %l2
  %t3 = load double, double* %l2
  %s4 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.4, i32 0, i32 0
  %t5 = call i1 @identifier_matches(i8* null, i8* %s4)
  %t6 = xor i1 %t5, 1
  %t7 = load %Parser, %Parser* %l0
  %t8 = load %Parser, %Parser* %l1
  %t9 = load double, double* %l2
  br i1 %t6, label %then0, label %merge1
then0:
  %t10 = load %Parser, %Parser* %l0
  %t11 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t12 = insertvalue %BlockStatementParseResult %t11, i8* null, 1
  %t13 = insertvalue %BlockStatementParseResult %t12, i1 0, 2
  ret %BlockStatementParseResult %t13
merge1:
  %t14 = load %Parser, %Parser* %l1
  %s15 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.15, i32 0, i32 0
  %t16 = call %Parser @consume_keyword(%Parser %t14, i8* %s15)
  store %Parser %t16, %Parser* %l1
  %t17 = load %Parser, %Parser* %l1
  %t18 = call %Parser @skip_trivia(%Parser %t17)
  store %Parser %t18, %Parser* %l1
  %t19 = load %Parser, %Parser* %l1
  %t20 = call double @parser_peek_raw(%Parser %t19)
  store double %t20, double* %l3
  %s21 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.21, i32 0, i32 0
  store i8* %s21, i8** %l4
  %t22 = load double, double* %l3
  %t23 = load %Parser, %Parser* %l1
  %t24 = call %BlockParseResult @parse_block(%Parser %t23)
  store %BlockParseResult %t24, %BlockParseResult* %l5
  %t25 = load %BlockParseResult, %BlockParseResult* %l5
  %t26 = extractvalue %BlockParseResult %t25, 1
  %t27 = load %BlockParseResult, %BlockParseResult* %l5
  %t28 = extractvalue %BlockParseResult %t27, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t29 = load %BlockParseResult, %BlockParseResult* %l5
  %t30 = extractvalue %BlockParseResult %t29, 1
  store i8* %t30, i8** %l6
  %t31 = load %Parser, %Parser* %l1
  %t32 = call %Parser @skip_trivia(%Parser %t31)
  store %Parser %t32, %Parser* %l1
  %t34 = load %Parser, %Parser* %l1
  %t35 = call double @parser_peek_raw(%Parser %t34)
  store double 0.0, double* %l7
  %t36 = load %Parser, %Parser* %l1
  %t37 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t38 = load double, double* %l7
  %t39 = insertvalue %BlockStatementParseResult %t37, i8* null, 1
  %t40 = insertvalue %BlockStatementParseResult %t39, i1 1, 2
  ret %BlockStatementParseResult %t40
}

define %BlockStatementParseResult @parse_with_statement(%Parser %parser, { i8**, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca %CaptureResult
  %l3 = alloca { i8**, i64 }*
  %l4 = alloca { i8**, i64 }*
  %l5 = alloca double
  %l6 = alloca { i8**, i64 }*
  %l7 = alloca double
  %l8 = alloca %BlockParseResult
  %l9 = alloca i8*
  %l10 = alloca double
  store %Parser %parser, %Parser* %l0
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l1
  %t1 = load %Parser, %Parser* %l1
  %t2 = call double @parser_peek_raw(%Parser %t1)
  %s3 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.3, i32 0, i32 0
  %t4 = call i1 @identifier_matches(i8* null, i8* %s3)
  %t5 = xor i1 %t4, 1
  %t6 = load %Parser, %Parser* %l0
  %t7 = load %Parser, %Parser* %l1
  br i1 %t5, label %then0, label %merge1
then0:
  %t8 = load %Parser, %Parser* %l0
  %t9 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t10 = insertvalue %BlockStatementParseResult %t9, i8* null, 1
  %t11 = insertvalue %BlockStatementParseResult %t10, i1 0, 2
  ret %BlockStatementParseResult %t11
merge1:
  %t12 = load %Parser, %Parser* %l1
  %s13 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.13, i32 0, i32 0
  %t14 = call %Parser @consume_keyword(%Parser %t12, i8* %s13)
  store %Parser %t14, %Parser* %l1
  %t15 = load %Parser, %Parser* %l1
  %t16 = call %Parser @skip_trivia(%Parser %t15)
  %s17 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.17, i32 0, i32 0
  %t18 = alloca [1 x i8*]
  %t19 = getelementptr [1 x i8*], [1 x i8*]* %t18, i32 0, i32 0
  %t20 = getelementptr i8*, i8** %t19, i64 0
  store i8* %s17, i8** %t20
  %t21 = alloca { i8**, i64 }
  %t22 = getelementptr { i8**, i64 }, { i8**, i64 }* %t21, i32 0, i32 0
  store i8** %t19, i8*** %t22
  %t23 = getelementptr { i8**, i64 }, { i8**, i64 }* %t21, i32 0, i32 1
  store i64 1, i64* %t23
  %t24 = call %CaptureResult @collect_until(%Parser %t16, { i8**, i64 }* %t21)
  store %CaptureResult %t24, %CaptureResult* %l2
  %t25 = load %CaptureResult, %CaptureResult* %l2
  %t26 = extractvalue %CaptureResult %t25, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t27 = load %CaptureResult, %CaptureResult* %l2
  %t28 = extractvalue %CaptureResult %t27, 1
  %t29 = call { i8**, i64 }* @split_token_slices_by_comma({ i8**, i64 }* %t28)
  store { i8**, i64 }* %t29, { i8**, i64 }** %l3
  %t30 = alloca [0 x double]
  %t31 = getelementptr [0 x double], [0 x double]* %t30, i32 0, i32 0
  %t32 = alloca { double*, i64 }
  %t33 = getelementptr { double*, i64 }, { double*, i64 }* %t32, i32 0, i32 0
  store double* %t31, double** %t33
  %t34 = getelementptr { double*, i64 }, { double*, i64 }* %t32, i32 0, i32 1
  store i64 0, i64* %t34
  store { i8**, i64 }* null, { i8**, i64 }** %l4
  %t35 = sitofp i64 0 to double
  store double %t35, double* %l5
  %t36 = load %Parser, %Parser* %l0
  %t37 = load %Parser, %Parser* %l1
  %t38 = load %CaptureResult, %CaptureResult* %l2
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t41 = load double, double* %l5
  br label %loop.header2
loop.header2:
  %t83 = phi { i8**, i64 }* [ %t40, %entry ], [ %t81, %loop.latch4 ]
  %t84 = phi double [ %t41, %entry ], [ %t82, %loop.latch4 ]
  store { i8**, i64 }* %t83, { i8**, i64 }** %l4
  store double %t84, double* %l5
  br label %loop.body3
loop.body3:
  %t42 = load double, double* %l5
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t44 = load { i8**, i64 }, { i8**, i64 }* %t43
  %t45 = extractvalue { i8**, i64 } %t44, 1
  %t46 = sitofp i64 %t45 to double
  %t47 = fcmp oge double %t42, %t46
  %t48 = load %Parser, %Parser* %l0
  %t49 = load %Parser, %Parser* %l1
  %t50 = load %CaptureResult, %CaptureResult* %l2
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t53 = load double, double* %l5
  br i1 %t47, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t55 = load double, double* %l5
  %t56 = load { i8**, i64 }, { i8**, i64 }* %t54
  %t57 = extractvalue { i8**, i64 } %t56, 0
  %t58 = extractvalue { i8**, i64 } %t56, 1
  %t59 = icmp uge i64 %t55, %t58
  ; bounds check: %t59 (if true, out of bounds)
  %t60 = getelementptr i8*, i8** %t57, i64 %t55
  %t61 = load i8*, i8** %t60
  %t62 = call { i8**, i64 }* @trim_token_edges({ i8**, i64 }* null)
  store { i8**, i64 }* %t62, { i8**, i64 }** %l6
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t64 = load { i8**, i64 }, { i8**, i64 }* %t63
  %t65 = extractvalue { i8**, i64 } %t64, 1
  %t66 = icmp sgt i64 %t65, 0
  %t67 = load %Parser, %Parser* %l0
  %t68 = load %Parser, %Parser* %l1
  %t69 = load %CaptureResult, %CaptureResult* %l2
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t72 = load double, double* %l5
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l6
  br i1 %t66, label %then8, label %merge9
then8:
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t75 = call double @expression_from_tokens({ i8**, i64 }* %t74)
  store double %t75, double* %l7
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l4
  br label %merge9
merge9:
  %t77 = phi { i8**, i64 }* [ null, %then8 ], [ %t71, %loop.body3 ]
  store { i8**, i64 }* %t77, { i8**, i64 }** %l4
  %t78 = load double, double* %l5
  %t79 = sitofp i64 1 to double
  %t80 = fadd double %t78, %t79
  store double %t80, double* %l5
  br label %loop.latch4
loop.latch4:
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t82 = load double, double* %l5
  br label %loop.header2
afterloop5:
  %t85 = load %Parser, %Parser* %l1
  %t86 = call %BlockParseResult @parse_block(%Parser %t85)
  store %BlockParseResult %t86, %BlockParseResult* %l8
  %t87 = load %BlockParseResult, %BlockParseResult* %l8
  %t88 = extractvalue %BlockParseResult %t87, 1
  %t89 = load %BlockParseResult, %BlockParseResult* %l8
  %t90 = extractvalue %BlockParseResult %t89, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t91 = load %BlockParseResult, %BlockParseResult* %l8
  %t92 = extractvalue %BlockParseResult %t91, 1
  store i8* %t92, i8** %l9
  %t93 = load %Parser, %Parser* %l1
  %t94 = call %Parser @skip_trivia(%Parser %t93)
  store %Parser %t94, %Parser* %l1
  %t96 = load %Parser, %Parser* %l1
  %t97 = call double @parser_peek_raw(%Parser %t96)
  store double 0.0, double* %l10
  %t98 = load %Parser, %Parser* %l1
  %t99 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t100 = load double, double* %l10
  %t101 = insertvalue %BlockStatementParseResult %t99, i8* null, 1
  %t102 = insertvalue %BlockStatementParseResult %t101, i1 1, 2
  ret %BlockStatementParseResult %t102
}

define %BlockStatementParseResult @parse_return_statement(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca %CaptureResult
  %l4 = alloca { i8**, i64 }*
  %l5 = alloca i8*
  %l6 = alloca double
  %l7 = alloca double
  %l8 = alloca double
  %l9 = alloca double
  store %Parser %parser, %Parser* %l0
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l1
  %t1 = load %Parser, %Parser* %l1
  %t2 = call double @parser_peek_raw(%Parser %t1)
  %s3 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.3, i32 0, i32 0
  %t4 = call i1 @identifier_matches(i8* null, i8* %s3)
  %t5 = xor i1 %t4, 1
  %t6 = load %Parser, %Parser* %l0
  %t7 = load %Parser, %Parser* %l1
  br i1 %t5, label %then0, label %merge1
then0:
  %t8 = load %Parser, %Parser* %l0
  %t9 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t10 = insertvalue %BlockStatementParseResult %t9, i8* null, 1
  %t11 = insertvalue %BlockStatementParseResult %t10, i1 0, 2
  ret %BlockStatementParseResult %t11
merge1:
  %t12 = alloca [0 x double]
  %t13 = getelementptr [0 x double], [0 x double]* %t12, i32 0, i32 0
  %t14 = alloca { double*, i64 }
  %t15 = getelementptr { double*, i64 }, { double*, i64 }* %t14, i32 0, i32 0
  store double* %t13, double** %t15
  %t16 = getelementptr { double*, i64 }, { double*, i64 }* %t14, i32 0, i32 1
  store i64 0, i64* %t16
  store { i8**, i64 }* null, { i8**, i64 }** %l2
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t18 = load %Parser, %Parser* %l1
  %t19 = call double @parser_peek_raw(%Parser %t18)
  %t20 = call { i8**, i64 }* @append_token({ i8**, i64 }* %t17, i8* null)
  store { i8**, i64 }* %t20, { i8**, i64 }** %l2
  %t21 = load %Parser, %Parser* %l1
  %s22 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.22, i32 0, i32 0
  %t23 = call %Parser @consume_keyword(%Parser %t21, i8* %s22)
  store %Parser %t23, %Parser* %l1
  %t24 = load %Parser, %Parser* %l1
  %t25 = call %Parser @skip_trivia(%Parser %t24)
  %s26 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.26, i32 0, i32 0
  %s27 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.27, i32 0, i32 0
  %t28 = alloca [2 x i8*]
  %t29 = getelementptr [2 x i8*], [2 x i8*]* %t28, i32 0, i32 0
  %t30 = getelementptr i8*, i8** %t29, i64 0
  store i8* %s26, i8** %t30
  %t31 = getelementptr i8*, i8** %t29, i64 1
  store i8* %s27, i8** %t31
  %t32 = alloca { i8**, i64 }
  %t33 = getelementptr { i8**, i64 }, { i8**, i64 }* %t32, i32 0, i32 0
  store i8** %t29, i8*** %t33
  %t34 = getelementptr { i8**, i64 }, { i8**, i64 }* %t32, i32 0, i32 1
  store i64 2, i64* %t34
  %t35 = call %CaptureResult @collect_until(%Parser %t25, { i8**, i64 }* %t32)
  store %CaptureResult %t35, %CaptureResult* %l3
  %t36 = load %CaptureResult, %CaptureResult* %l3
  %t37 = extractvalue %CaptureResult %t36, 0
  store %Parser zeroinitializer, %Parser* %l1
  %t38 = load %CaptureResult, %CaptureResult* %l3
  %t39 = extractvalue %CaptureResult %t38, 1
  %t40 = call { i8**, i64 }* @trim_token_edges({ i8**, i64 }* %t39)
  store { i8**, i64 }* %t40, { i8**, i64 }** %l4
  store i8* null, i8** %l5
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t42 = load { i8**, i64 }, { i8**, i64 }* %t41
  %t43 = extractvalue { i8**, i64 } %t42, 1
  %t44 = icmp sgt i64 %t43, 0
  %t45 = load %Parser, %Parser* %l0
  %t46 = load %Parser, %Parser* %l1
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t48 = load %CaptureResult, %CaptureResult* %l3
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t50 = load i8*, i8** %l5
  br i1 %t44, label %then2, label %merge3
then2:
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t52 = call double @expression_from_tokens({ i8**, i64 }* %t51)
  store i8* null, i8** %l5
  br label %merge3
merge3:
  %t53 = phi i8* [ null, %then2 ], [ %t50, %entry ]
  store i8* %t53, i8** %l5
  %t54 = sitofp i64 0 to double
  store double %t54, double* %l6
  %t55 = load %Parser, %Parser* %l0
  %t56 = load %Parser, %Parser* %l1
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t58 = load %CaptureResult, %CaptureResult* %l3
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t60 = load i8*, i8** %l5
  %t61 = load double, double* %l6
  br label %loop.header4
loop.header4:
  %t92 = phi { i8**, i64 }* [ %t57, %entry ], [ %t90, %loop.latch6 ]
  %t93 = phi double [ %t61, %entry ], [ %t91, %loop.latch6 ]
  store { i8**, i64 }* %t92, { i8**, i64 }** %l2
  store double %t93, double* %l6
  br label %loop.body5
loop.body5:
  %t62 = load double, double* %l6
  %t63 = load %CaptureResult, %CaptureResult* %l3
  %t64 = extractvalue %CaptureResult %t63, 1
  %t65 = load { i8**, i64 }, { i8**, i64 }* %t64
  %t66 = extractvalue { i8**, i64 } %t65, 1
  %t67 = sitofp i64 %t66 to double
  %t68 = fcmp oge double %t62, %t67
  %t69 = load %Parser, %Parser* %l0
  %t70 = load %Parser, %Parser* %l1
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t72 = load %CaptureResult, %CaptureResult* %l3
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t74 = load i8*, i8** %l5
  %t75 = load double, double* %l6
  br i1 %t68, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t77 = load %CaptureResult, %CaptureResult* %l3
  %t78 = extractvalue %CaptureResult %t77, 1
  %t79 = load double, double* %l6
  %t80 = load { i8**, i64 }, { i8**, i64 }* %t78
  %t81 = extractvalue { i8**, i64 } %t80, 0
  %t82 = extractvalue { i8**, i64 } %t80, 1
  %t83 = icmp uge i64 %t79, %t82
  ; bounds check: %t83 (if true, out of bounds)
  %t84 = getelementptr i8*, i8** %t81, i64 %t79
  %t85 = load i8*, i8** %t84
  %t86 = call { i8**, i64 }* @append_token({ i8**, i64 }* %t76, i8* %t85)
  store { i8**, i64 }* %t86, { i8**, i64 }** %l2
  %t87 = load double, double* %l6
  %t88 = sitofp i64 1 to double
  %t89 = fadd double %t87, %t88
  store double %t89, double* %l6
  br label %loop.latch6
loop.latch6:
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t91 = load double, double* %l6
  br label %loop.header4
afterloop7:
  %t94 = load %Parser, %Parser* %l1
  %t95 = call %Parser @skip_trivia(%Parser %t94)
  store %Parser %t95, %Parser* %l1
  %t96 = load %Parser, %Parser* %l1
  %t97 = call double @parser_peek_raw(%Parser %t96)
  store double %t97, double* %l7
  %t99 = load double, double* %l7
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t101 = call double @source_span_from_tokens({ i8**, i64 }* %t100)
  store double %t101, double* %l8
  store double 0.0, double* %l9
  %t102 = load %Parser, %Parser* %l1
  %t103 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t104 = load double, double* %l9
  %t105 = insertvalue %BlockStatementParseResult %t103, i8* null, 1
  %t106 = insertvalue %BlockStatementParseResult %t105, i1 1, 2
  ret %BlockStatementParseResult %t106
}

define %BlockStatementParseResult @parse_expression_statement(%Parser %parser, { i8**, i64 }* %decorators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca double
  %l2 = alloca %CaptureResult
  %l3 = alloca { i8**, i64 }*
  %l4 = alloca double
  %l5 = alloca { i8**, i64 }*
  %l6 = alloca double
  %l7 = alloca double
  %l8 = alloca double
  %l9 = alloca double
  %t0 = load { i8**, i64 }, { i8**, i64 }* %decorators
  %t1 = extractvalue { i8**, i64 } %t0, 1
  %t2 = icmp sgt i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  %t3 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t4 = insertvalue %BlockStatementParseResult %t3, i8* null, 1
  %t5 = insertvalue %BlockStatementParseResult %t4, i1 0, 2
  ret %BlockStatementParseResult %t5
merge1:
  %t6 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t6, %Parser* %l0
  %t7 = load %Parser, %Parser* %l0
  %t8 = call double @parser_peek_raw(%Parser %t7)
  store double %t8, double* %l1
  %t9 = load double, double* %l1
  %t10 = load double, double* %l1
  %t11 = load %Parser, %Parser* %l0
  %s12 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.12, i32 0, i32 0
  %t13 = alloca [1 x i8*]
  %t14 = getelementptr [1 x i8*], [1 x i8*]* %t13, i32 0, i32 0
  %t15 = getelementptr i8*, i8** %t14, i64 0
  store i8* %s12, i8** %t15
  %t16 = alloca { i8**, i64 }
  %t17 = getelementptr { i8**, i64 }, { i8**, i64 }* %t16, i32 0, i32 0
  store i8** %t14, i8*** %t17
  %t18 = getelementptr { i8**, i64 }, { i8**, i64 }* %t16, i32 0, i32 1
  store i64 1, i64* %t18
  %t19 = call %CaptureResult @collect_until(%Parser %t11, { i8**, i64 }* %t16)
  store %CaptureResult %t19, %CaptureResult* %l2
  %t20 = load %CaptureResult, %CaptureResult* %l2
  %t21 = extractvalue %CaptureResult %t20, 1
  %t22 = load { i8**, i64 }, { i8**, i64 }* %t21
  %t23 = extractvalue { i8**, i64 } %t22, 1
  %t24 = icmp eq i64 %t23, 0
  %t25 = load %Parser, %Parser* %l0
  %t26 = load double, double* %l1
  %t27 = load %CaptureResult, %CaptureResult* %l2
  br i1 %t24, label %then2, label %merge3
then2:
  %t28 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t29 = insertvalue %BlockStatementParseResult %t28, i8* null, 1
  %t30 = insertvalue %BlockStatementParseResult %t29, i1 0, 2
  ret %BlockStatementParseResult %t30
merge3:
  %t31 = alloca [0 x double]
  %t32 = getelementptr [0 x double], [0 x double]* %t31, i32 0, i32 0
  %t33 = alloca { double*, i64 }
  %t34 = getelementptr { double*, i64 }, { double*, i64 }* %t33, i32 0, i32 0
  store double* %t32, double** %t34
  %t35 = getelementptr { double*, i64 }, { double*, i64 }* %t33, i32 0, i32 1
  store i64 0, i64* %t35
  store { i8**, i64 }* null, { i8**, i64 }** %l3
  %t36 = sitofp i64 0 to double
  store double %t36, double* %l4
  %t37 = load %Parser, %Parser* %l0
  %t38 = load double, double* %l1
  %t39 = load %CaptureResult, %CaptureResult* %l2
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t41 = load double, double* %l4
  br label %loop.header4
loop.header4:
  %t70 = phi { i8**, i64 }* [ %t40, %entry ], [ %t68, %loop.latch6 ]
  %t71 = phi double [ %t41, %entry ], [ %t69, %loop.latch6 ]
  store { i8**, i64 }* %t70, { i8**, i64 }** %l3
  store double %t71, double* %l4
  br label %loop.body5
loop.body5:
  %t42 = load double, double* %l4
  %t43 = load %CaptureResult, %CaptureResult* %l2
  %t44 = extractvalue %CaptureResult %t43, 1
  %t45 = load { i8**, i64 }, { i8**, i64 }* %t44
  %t46 = extractvalue { i8**, i64 } %t45, 1
  %t47 = sitofp i64 %t46 to double
  %t48 = fcmp oge double %t42, %t47
  %t49 = load %Parser, %Parser* %l0
  %t50 = load double, double* %l1
  %t51 = load %CaptureResult, %CaptureResult* %l2
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t53 = load double, double* %l4
  br i1 %t48, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t55 = load %CaptureResult, %CaptureResult* %l2
  %t56 = extractvalue %CaptureResult %t55, 1
  %t57 = load double, double* %l4
  %t58 = load { i8**, i64 }, { i8**, i64 }* %t56
  %t59 = extractvalue { i8**, i64 } %t58, 0
  %t60 = extractvalue { i8**, i64 } %t58, 1
  %t61 = icmp uge i64 %t57, %t60
  ; bounds check: %t61 (if true, out of bounds)
  %t62 = getelementptr i8*, i8** %t59, i64 %t57
  %t63 = load i8*, i8** %t62
  %t64 = call { i8**, i64 }* @append_token({ i8**, i64 }* %t54, i8* %t63)
  store { i8**, i64 }* %t64, { i8**, i64 }** %l3
  %t65 = load double, double* %l4
  %t66 = sitofp i64 1 to double
  %t67 = fadd double %t65, %t66
  store double %t67, double* %l4
  br label %loop.latch6
loop.latch6:
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t69 = load double, double* %l4
  br label %loop.header4
afterloop7:
  %t72 = load %CaptureResult, %CaptureResult* %l2
  %t73 = extractvalue %CaptureResult %t72, 1
  %t74 = call { i8**, i64 }* @trim_token_edges({ i8**, i64 }* %t73)
  store { i8**, i64 }* %t74, { i8**, i64 }** %l5
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t76 = load { i8**, i64 }, { i8**, i64 }* %t75
  %t77 = extractvalue { i8**, i64 } %t76, 1
  %t78 = icmp eq i64 %t77, 0
  %t79 = load %Parser, %Parser* %l0
  %t80 = load double, double* %l1
  %t81 = load %CaptureResult, %CaptureResult* %l2
  %t82 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t83 = load double, double* %l4
  %t84 = load { i8**, i64 }*, { i8**, i64 }** %l5
  br i1 %t78, label %then10, label %merge11
then10:
  %t85 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t86 = insertvalue %BlockStatementParseResult %t85, i8* null, 1
  %t87 = insertvalue %BlockStatementParseResult %t86, i1 0, 2
  ret %BlockStatementParseResult %t87
merge11:
  %t88 = load %CaptureResult, %CaptureResult* %l2
  %t89 = extractvalue %CaptureResult %t88, 0
  store %Parser zeroinitializer, %Parser* %l0
  %t90 = load %Parser, %Parser* %l0
  %t91 = call %Parser @skip_trivia(%Parser %t90)
  store %Parser %t91, %Parser* %l0
  %t92 = load %Parser, %Parser* %l0
  %t93 = call double @parser_peek_raw(%Parser %t92)
  store double %t93, double* %l6
  %t95 = load double, double* %l6
  %t96 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t97 = load double, double* %l6
  %t98 = call { i8**, i64 }* @append_token({ i8**, i64 }* %t96, i8* null)
  store { i8**, i64 }* %t98, { i8**, i64 }** %l3
  %t99 = load %Parser, %Parser* %l0
  %t100 = call %Parser @parser_advance_raw(%Parser %t99)
  store %Parser %t100, %Parser* %l0
  %t101 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t102 = call double @expression_from_tokens({ i8**, i64 }* %t101)
  store double %t102, double* %l7
  %t103 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t104 = call double @source_span_from_tokens({ i8**, i64 }* %t103)
  store double %t104, double* %l8
  store double 0.0, double* %l9
  %t105 = load %Parser, %Parser* %l0
  %t106 = insertvalue %BlockStatementParseResult undef, i8* null, 0
  %t107 = load double, double* %l9
  %t108 = insertvalue %BlockStatementParseResult %t106, i8* null, 1
  %t109 = insertvalue %BlockStatementParseResult %t108, i1 1, 2
  ret %BlockStatementParseResult %t109
}

define %StatementParseResult @parse_unknown(%Parser %parser) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca %Parser
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  store %Parser %parser, %Parser* %l1
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l2
  %t6 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t7 = load %Parser, %Parser* %l1
  %t8 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t20 = phi { i8**, i64 }* [ %t6, %entry ], [ %t18, %loop.latch2 ]
  %t21 = phi %Parser [ %t7, %entry ], [ %t19, %loop.latch2 ]
  store { i8**, i64 }* %t20, { i8**, i64 }** %l0
  store %Parser %t21, %Parser* %l1
  br label %loop.body1
loop.body1:
  %t9 = load %Parser, %Parser* %l1
  %t10 = call double @parser_peek_raw(%Parser %t9)
  store double %t10, double* %l3
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t12 = load double, double* %l3
  %t13 = call { i8**, i64 }* @append_token({ i8**, i64 }* %t11, i8* null)
  store { i8**, i64 }* %t13, { i8**, i64 }** %l0
  %t14 = load double, double* %l3
  %t15 = load double, double* %l3
  %t16 = load %Parser, %Parser* %l1
  %t17 = call %Parser @parser_advance_raw(%Parser %t16)
  store %Parser %t17, %Parser* %l1
  br label %loop.latch2
loop.latch2:
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t19 = load %Parser, %Parser* %l1
  br label %loop.header0
afterloop3:
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t23 = call i8* @tokens_to_text({ i8**, i64 }* %t22)
  store i8* %t23, i8** %l4
  store double 0.0, double* %l5
  %t24 = insertvalue %StatementParseResult undef, i8* null, 0
  %t25 = load double, double* %l5
  %t26 = insertvalue %StatementParseResult %t24, i8* null, 1
  ret %StatementParseResult %t26
}

define i1 @identifier_matches(i8* %token, i8* %expected) {
entry:
  ret i1 false
}

define i8* @identifier_text(i8* %token) {
entry:
  ret i8* null
}

define i8* @string_literal_value(i8* %token) {
entry:
  %l0 = alloca double
  store double 0.0, double* %l0
  %t0 = load double, double* %l0
  %t1 = call i8* @strip_surrounding_quotes(i8* null)
  ret i8* %t1
}

define %Parser @skip_trivia(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca i8*
  store %Parser %parser, %Parser* %l0
  %t0 = load %Parser, %Parser* %l0
  br label %loop.header0
loop.header0:
  %t27 = phi %Parser [ %t0, %entry ], [ %t26, %loop.latch2 ]
  store %Parser %t27, %Parser* %l0
  br label %loop.body1
loop.body1:
  %t1 = load %Parser, %Parser* %l0
  %t2 = extractvalue %Parser %t1, 1
  %t3 = load %Parser, %Parser* %l0
  %t4 = extractvalue %Parser %t3, 0
  %t5 = load { i8**, i64 }, { i8**, i64 }* %t4
  %t6 = extractvalue { i8**, i64 } %t5, 1
  %t7 = sitofp i64 %t6 to double
  %t8 = fcmp oge double %t2, %t7
  %t9 = load %Parser, %Parser* %l0
  br i1 %t8, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t10 = load %Parser, %Parser* %l0
  %t11 = extractvalue %Parser %t10, 0
  %t12 = load %Parser, %Parser* %l0
  %t13 = extractvalue %Parser %t12, 1
  %t14 = load { i8**, i64 }, { i8**, i64 }* %t11
  %t15 = extractvalue { i8**, i64 } %t14, 0
  %t16 = extractvalue { i8**, i64 } %t14, 1
  %t17 = icmp uge i64 %t13, %t16
  ; bounds check: %t17 (if true, out of bounds)
  %t18 = getelementptr i8*, i8** %t15, i64 %t13
  %t19 = load i8*, i8** %t18
  store i8* %t19, i8** %l1
  %t20 = load i8*, i8** %l1
  %t21 = call i1 @is_trivia_token(i8* %t20)
  %t22 = load %Parser, %Parser* %l0
  %t23 = load i8*, i8** %l1
  br i1 %t21, label %then6, label %merge7
then6:
  %t24 = load %Parser, %Parser* %l0
  %t25 = call %Parser @parser_advance_raw(%Parser %t24)
  store %Parser %t25, %Parser* %l0
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  %t26 = load %Parser, %Parser* %l0
  br label %loop.header0
afterloop3:
  %t28 = load %Parser, %Parser* %l0
  ret %Parser %t28
}

define %Parser @parser_advance_raw(%Parser %parser) {
entry:
  %t0 = extractvalue %Parser %parser, 1
  %t1 = sitofp i64 1 to double
  %t2 = fadd double %t0, %t1
  %t3 = extractvalue %Parser %parser, 0
  %t4 = load { i8**, i64 }, { i8**, i64 }* %t3
  %t5 = extractvalue { i8**, i64 } %t4, 1
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp ogt double %t2, %t6
  br i1 %t7, label %then0, label %merge1
then0:
  ret %Parser %parser
merge1:
  ret %Parser zeroinitializer
}

define %Parser @consume_keyword(%Parser %parser, i8* %keyword) {
entry:
  %l0 = alloca double
  %t0 = call double @parser_peek_raw(%Parser %parser)
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  %t2 = call i1 @identifier_matches(i8* null, i8* %keyword)
  %t3 = load double, double* %l0
  br i1 %t2, label %then0, label %merge1
then0:
  %t4 = call %Parser @parser_advance_raw(%Parser %parser)
  ret %Parser %t4
merge1:
  ret %Parser %parser
}

define %Parser @consume_symbol(%Parser %parser, i8* %symbol) {
entry:
  %l0 = alloca double
  %t0 = call double @parser_peek_raw(%Parser %parser)
  store double %t0, double* %l0
  %t2 = load double, double* %l0
  ret %Parser %parser
}

define %CaptureResult @collect_until(%Parser %parser, { i8**, i64 }* %terminators) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca i1
  %l7 = alloca %Parser
  store %Parser %parser, %Parser* %l0
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l2
  %t6 = sitofp i64 0 to double
  store double %t6, double* %l3
  %t7 = sitofp i64 0 to double
  store double %t7, double* %l4
  %t8 = load %Parser, %Parser* %l0
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t10 = load double, double* %l2
  %t11 = load double, double* %l3
  %t12 = load double, double* %l4
  br label %loop.header0
loop.header0:
  %t59 = phi { i8**, i64 }* [ %t9, %entry ], [ %t57, %loop.latch2 ]
  %t60 = phi %Parser [ %t8, %entry ], [ %t58, %loop.latch2 ]
  store { i8**, i64 }* %t59, { i8**, i64 }** %l1
  store %Parser %t60, %Parser* %l0
  br label %loop.body1
loop.body1:
  %t13 = load %Parser, %Parser* %l0
  %t14 = call double @parser_peek_raw(%Parser %t13)
  store double %t14, double* %l5
  %t15 = load double, double* %l5
  %t18 = load double, double* %l2
  %t19 = sitofp i64 0 to double
  %t20 = fcmp oeq double %t18, %t19
  br label %logical_and_entry_17

logical_and_entry_17:
  br i1 %t20, label %logical_and_right_17, label %logical_and_merge_17

logical_and_right_17:
  %t21 = load double, double* %l3
  %t22 = sitofp i64 0 to double
  %t23 = fcmp oeq double %t21, %t22
  br label %logical_and_right_end_17

logical_and_right_end_17:
  br label %logical_and_merge_17

logical_and_merge_17:
  %t24 = phi i1 [ false, %logical_and_entry_17 ], [ %t23, %logical_and_right_end_17 ]
  br label %logical_and_entry_16

logical_and_entry_16:
  br i1 %t24, label %logical_and_right_16, label %logical_and_merge_16

logical_and_right_16:
  %t25 = load double, double* %l4
  %t26 = sitofp i64 0 to double
  %t27 = fcmp oeq double %t25, %t26
  br label %logical_and_right_end_16

logical_and_right_end_16:
  br label %logical_and_merge_16

logical_and_merge_16:
  %t28 = phi i1 [ false, %logical_and_entry_16 ], [ %t27, %logical_and_right_end_16 ]
  store i1 %t28, i1* %l6
  %t29 = load i1, i1* %l6
  %t30 = load %Parser, %Parser* %l0
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t32 = load double, double* %l2
  %t33 = load double, double* %l3
  %t34 = load double, double* %l4
  %t35 = load double, double* %l5
  %t36 = load i1, i1* %l6
  br i1 %t29, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t38 = load double, double* %l5
  %t39 = call { i8**, i64 }* @append_token({ i8**, i64 }* %t37, i8* null)
  store { i8**, i64 }* %t39, { i8**, i64 }** %l1
  %t40 = load double, double* %l5
  %t41 = load %Parser, %Parser* %l0
  %t42 = call %Parser @parser_advance_raw(%Parser %t41)
  store %Parser %t42, %Parser* %l7
  %t43 = load %Parser, %Parser* %l7
  %t44 = extractvalue %Parser %t43, 1
  %t45 = load %Parser, %Parser* %l0
  %t46 = extractvalue %Parser %t45, 1
  %t47 = fcmp oeq double %t44, %t46
  %t48 = load %Parser, %Parser* %l0
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t50 = load double, double* %l2
  %t51 = load double, double* %l3
  %t52 = load double, double* %l4
  %t53 = load double, double* %l5
  %t54 = load i1, i1* %l6
  %t55 = load %Parser, %Parser* %l7
  br i1 %t47, label %then6, label %merge7
then6:
  br label %afterloop3
merge7:
  %t56 = load %Parser, %Parser* %l7
  store %Parser %t56, %Parser* %l0
  br label %loop.latch2
loop.latch2:
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t58 = load %Parser, %Parser* %l0
  br label %loop.header0
afterloop3:
  %t61 = load %Parser, %Parser* %l0
  %t62 = insertvalue %CaptureResult undef, i8* null, 0
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t64 = insertvalue %CaptureResult %t62, { i8**, i64 }* %t63, 1
  ret %CaptureResult %t64
}

define %ParenthesizedParseResult @collect_parenthesized(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca double
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca double
  %l4 = alloca double
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l0
  %t1 = load %Parser, %Parser* %l0
  %t2 = call double @parser_peek_raw(%Parser %t1)
  store double %t2, double* %l1
  %t4 = load double, double* %l1
  %t5 = load %Parser, %Parser* %l0
  %t6 = call %Parser @parser_advance_raw(%Parser %t5)
  store %Parser %t6, %Parser* %l0
  %t7 = alloca [0 x double]
  %t8 = getelementptr [0 x double], [0 x double]* %t7, i32 0, i32 0
  %t9 = alloca { double*, i64 }
  %t10 = getelementptr { double*, i64 }, { double*, i64 }* %t9, i32 0, i32 0
  store double* %t8, double** %t10
  %t11 = getelementptr { double*, i64 }, { double*, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { i8**, i64 }* null, { i8**, i64 }** %l2
  %t12 = sitofp i64 1 to double
  store double %t12, double* %l3
  %t13 = load %Parser, %Parser* %l0
  %t14 = load double, double* %l1
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t16 = load double, double* %l3
  br label %loop.header0
loop.header0:
  %t28 = phi { i8**, i64 }* [ %t15, %entry ], [ %t26, %loop.latch2 ]
  %t29 = phi %Parser [ %t13, %entry ], [ %t27, %loop.latch2 ]
  store { i8**, i64 }* %t28, { i8**, i64 }** %l2
  store %Parser %t29, %Parser* %l0
  br label %loop.body1
loop.body1:
  %t17 = load %Parser, %Parser* %l0
  %t18 = call double @parser_peek_raw(%Parser %t17)
  store double %t18, double* %l4
  %t19 = load double, double* %l4
  %t20 = load double, double* %l4
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t22 = load double, double* %l4
  %t23 = call { i8**, i64 }* @append_token({ i8**, i64 }* %t21, i8* null)
  store { i8**, i64 }* %t23, { i8**, i64 }** %l2
  %t24 = load %Parser, %Parser* %l0
  %t25 = call %Parser @parser_advance_raw(%Parser %t24)
  store %Parser %t25, %Parser* %l0
  br label %loop.latch2
loop.latch2:
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t27 = load %Parser, %Parser* %l0
  br label %loop.header0
afterloop3:
  %t30 = load %Parser, %Parser* %l0
  %t31 = insertvalue %ParenthesizedParseResult undef, i8* null, 0
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t33 = insertvalue %ParenthesizedParseResult %t31, { i8**, i64 }* %t32, 1
  %t34 = insertvalue %ParenthesizedParseResult %t33, i1 1, 2
  ret %ParenthesizedParseResult %t34
}

define %PatternCaptureResult @collect_pattern_until_arrow(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca %Parser
  %t0 = call %Parser @skip_trivia(%Parser %parser)
  store %Parser %t0, %Parser* %l0
  %t1 = alloca [0 x double]
  %t2 = getelementptr [0 x double], [0 x double]* %t1, i32 0, i32 0
  %t3 = alloca { double*, i64 }
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 0
  store double* %t2, double** %t4
  %t5 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t6 = load %Parser, %Parser* %l0
  %t7 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %loop.header0
loop.header0:
  %t37 = phi { i8**, i64 }* [ %t7, %entry ], [ %t35, %loop.latch2 ]
  %t38 = phi %Parser [ %t6, %entry ], [ %t36, %loop.latch2 ]
  store { i8**, i64 }* %t37, { i8**, i64 }** %l1
  store %Parser %t38, %Parser* %l0
  br label %loop.body1
loop.body1:
  %t8 = load %Parser, %Parser* %l0
  %t9 = call double @parser_peek_raw(%Parser %t8)
  store double %t9, double* %l2
  %t10 = load double, double* %l2
  %t11 = load double, double* %l2
  %t12 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t13 = load double, double* %l2
  %t14 = call { i8**, i64 }* @append_token({ i8**, i64 }* %t12, i8* null)
  store { i8**, i64 }* %t14, { i8**, i64 }** %l1
  %t15 = load %Parser, %Parser* %l0
  %t16 = call %Parser @parser_advance_raw(%Parser %t15)
  store %Parser %t16, %Parser* %l3
  %t17 = load %Parser, %Parser* %l3
  %t18 = extractvalue %Parser %t17, 1
  %t19 = load %Parser, %Parser* %l0
  %t20 = extractvalue %Parser %t19, 1
  %t21 = fcmp oeq double %t18, %t20
  %t22 = load %Parser, %Parser* %l0
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t24 = load double, double* %l2
  %t25 = load %Parser, %Parser* %l3
  br i1 %t21, label %then4, label %merge5
then4:
  %t26 = insertvalue %PatternCaptureResult undef, i8* null, 0
  %t27 = alloca [0 x double]
  %t28 = getelementptr [0 x double], [0 x double]* %t27, i32 0, i32 0
  %t29 = alloca { double*, i64 }
  %t30 = getelementptr { double*, i64 }, { double*, i64 }* %t29, i32 0, i32 0
  store double* %t28, double** %t30
  %t31 = getelementptr { double*, i64 }, { double*, i64 }* %t29, i32 0, i32 1
  store i64 0, i64* %t31
  %t32 = insertvalue %PatternCaptureResult %t26, { i8**, i64 }* null, 1
  %t33 = insertvalue %PatternCaptureResult %t32, i1 0, 2
  ret %PatternCaptureResult %t33
merge5:
  %t34 = load %Parser, %Parser* %l3
  store %Parser %t34, %Parser* %l0
  br label %loop.latch2
loop.latch2:
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t36 = load %Parser, %Parser* %l0
  br label %loop.header0
afterloop3:
  %t39 = load %Parser, %Parser* %l0
  %t40 = insertvalue %PatternCaptureResult undef, i8* null, 0
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t42 = insertvalue %PatternCaptureResult %t40, { i8**, i64 }* %t41, 1
  %t43 = insertvalue %PatternCaptureResult %t42, i1 1, 2
  ret %PatternCaptureResult %t43
}

define %MatchCaseTokenSplit @split_match_case_tokens({ i8**, i64 }* %tokens) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca { i8**, i64 }*
  %t0 = call { i8**, i64 }* @trim_token_edges({ i8**, i64 }* %tokens)
  store { i8**, i64 }* %t0, { i8**, i64 }** %l0
  %t1 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t2 = load { i8**, i64 }, { i8**, i64 }* %t1
  %t3 = extractvalue { i8**, i64 } %t2, 1
  %t4 = icmp eq i64 %t3, 0
  %t5 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br i1 %t4, label %then0, label %merge1
then0:
  %t6 = alloca [0 x double]
  %t7 = getelementptr [0 x double], [0 x double]* %t6, i32 0, i32 0
  %t8 = alloca { double*, i64 }
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t8, i32 0, i32 0
  store double* %t7, double** %t9
  %t10 = getelementptr { double*, i64 }, { double*, i64 }* %t8, i32 0, i32 1
  store i64 0, i64* %t10
  %t11 = insertvalue %MatchCaseTokenSplit undef, { i8**, i64 }* null, 0
  %t12 = alloca [0 x double]
  %t13 = getelementptr [0 x double], [0 x double]* %t12, i32 0, i32 0
  %t14 = alloca { double*, i64 }
  %t15 = getelementptr { double*, i64 }, { double*, i64 }* %t14, i32 0, i32 0
  store double* %t13, double** %t15
  %t16 = getelementptr { double*, i64 }, { double*, i64 }* %t14, i32 0, i32 1
  store i64 0, i64* %t16
  %t17 = insertvalue %MatchCaseTokenSplit %t11, { i8**, i64 }* null, 1
  %t18 = insertvalue %MatchCaseTokenSplit %t17, i1 0, 2
  ret %MatchCaseTokenSplit %t18
merge1:
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s20 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.20, i32 0, i32 0
  %t21 = call double @find_top_level_identifier({ i8**, i64 }* %t19, i8* %s20)
  store double %t21, double* %l1
  %t22 = load double, double* %l1
  %t23 = sitofp i64 -1 to double
  %t24 = fcmp oeq double %t22, %t23
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t26 = load double, double* %l1
  br i1 %t24, label %then2, label %merge3
then2:
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t28 = insertvalue %MatchCaseTokenSplit undef, { i8**, i64 }* %t27, 0
  %t29 = alloca [0 x double]
  %t30 = getelementptr [0 x double], [0 x double]* %t29, i32 0, i32 0
  %t31 = alloca { double*, i64 }
  %t32 = getelementptr { double*, i64 }, { double*, i64 }* %t31, i32 0, i32 0
  store double* %t30, double** %t32
  %t33 = getelementptr { double*, i64 }, { double*, i64 }* %t31, i32 0, i32 1
  store i64 0, i64* %t33
  %t34 = insertvalue %MatchCaseTokenSplit %t28, { i8**, i64 }* null, 1
  %t35 = insertvalue %MatchCaseTokenSplit %t34, i1 0, 2
  ret %MatchCaseTokenSplit %t35
merge3:
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t37 = load double, double* %l1
  %t38 = sitofp i64 0 to double
  %t39 = call { i8**, i64 }* @token_slice({ i8**, i64 }* %t36, double %t38, double %t37)
  %t40 = call { i8**, i64 }* @trim_token_edges({ i8**, i64 }* %t39)
  store { i8**, i64 }* %t40, { i8**, i64 }** %l2
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t42 = load double, double* %l1
  %t43 = sitofp i64 1 to double
  %t44 = fadd double %t42, %t43
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t46 = load { i8**, i64 }, { i8**, i64 }* %t45
  %t47 = extractvalue { i8**, i64 } %t46, 1
  %t48 = sitofp i64 %t47 to double
  %t49 = call { i8**, i64 }* @token_slice({ i8**, i64 }* %t41, double %t44, double %t48)
  %t50 = call { i8**, i64 }* @trim_token_edges({ i8**, i64 }* %t49)
  store { i8**, i64 }* %t50, { i8**, i64 }** %l3
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t52 = insertvalue %MatchCaseTokenSplit undef, { i8**, i64 }* %t51, 0
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t54 = insertvalue %MatchCaseTokenSplit %t52, { i8**, i64 }* %t53, 1
  %t55 = insertvalue %MatchCaseTokenSplit %t54, i1 1, 2
  ret %MatchCaseTokenSplit %t55
}

define i1 @looks_like_number(i8* %text) {
entry:
  %l0 = alloca i1
  %l1 = alloca double
  %l2 = alloca i8
  store i1 0, i1* %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = getelementptr i8, i8* %text, i64 0
  %t2 = load i8, i8* %t1
  %t3 = load i1, i1* %l0
  %t4 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t21 = phi double [ %t4, %entry ], [ %t20, %loop.latch2 ]
  store double %t21, double* %l1
  br label %loop.body1
loop.body1:
  %t5 = load double, double* %l1
  %t6 = load double, double* %l1
  %t7 = getelementptr i8, i8* %text, i64 %t6
  %t8 = load i8, i8* %t7
  store i8 %t8, i8* %l2
  %t9 = load i8, i8* %l2
  %s10 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.10, i32 0, i32 0
  %t11 = load i8, i8* %l2
  %t12 = call i1 @is_decimal_digit(i8* null)
  %t13 = xor i1 %t12, 1
  %t14 = load i1, i1* %l0
  %t15 = load double, double* %l1
  %t16 = load i8, i8* %l2
  br i1 %t13, label %then4, label %merge5
then4:
  ret i1 0
merge5:
  %t17 = load double, double* %l1
  %t18 = sitofp i64 1 to double
  %t19 = fadd double %t17, %t18
  store double %t19, double* %l1
  br label %loop.latch2
loop.latch2:
  %t20 = load double, double* %l1
  br label %loop.header0
afterloop3:
  ret i1 1
}

define i1 @is_decimal_digit(i8* %ch) {
entry:
  %s9 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.9, i32 0, i32 0
  %t10 = icmp eq i8* %ch, %s9
  br label %logical_or_entry_8

logical_or_entry_8:
  br i1 %t10, label %logical_or_merge_8, label %logical_or_right_8

logical_or_right_8:
  %s11 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.11, i32 0, i32 0
  %t12 = icmp eq i8* %ch, %s11
  br label %logical_or_right_end_8

logical_or_right_end_8:
  br label %logical_or_merge_8

logical_or_merge_8:
  %t13 = phi i1 [ true, %logical_or_entry_8 ], [ %t12, %logical_or_right_end_8 ]
  br label %logical_or_entry_7

logical_or_entry_7:
  br i1 %t13, label %logical_or_merge_7, label %logical_or_right_7

logical_or_right_7:
  %s14 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.14, i32 0, i32 0
  %t15 = icmp eq i8* %ch, %s14
  br label %logical_or_right_end_7

logical_or_right_end_7:
  br label %logical_or_merge_7

logical_or_merge_7:
  %t16 = phi i1 [ true, %logical_or_entry_7 ], [ %t15, %logical_or_right_end_7 ]
  br label %logical_or_entry_6

logical_or_entry_6:
  br i1 %t16, label %logical_or_merge_6, label %logical_or_right_6

logical_or_right_6:
  %s17 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.17, i32 0, i32 0
  %t18 = icmp eq i8* %ch, %s17
  br label %logical_or_right_end_6

logical_or_right_end_6:
  br label %logical_or_merge_6

logical_or_merge_6:
  %t19 = phi i1 [ true, %logical_or_entry_6 ], [ %t18, %logical_or_right_end_6 ]
  br label %logical_or_entry_5

logical_or_entry_5:
  br i1 %t19, label %logical_or_merge_5, label %logical_or_right_5

logical_or_right_5:
  %s20 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.20, i32 0, i32 0
  %t21 = icmp eq i8* %ch, %s20
  br label %logical_or_right_end_5

logical_or_right_end_5:
  br label %logical_or_merge_5

logical_or_merge_5:
  %t22 = phi i1 [ true, %logical_or_entry_5 ], [ %t21, %logical_or_right_end_5 ]
  br label %logical_or_entry_4

logical_or_entry_4:
  br i1 %t22, label %logical_or_merge_4, label %logical_or_right_4

logical_or_right_4:
  %s23 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.23, i32 0, i32 0
  %t24 = icmp eq i8* %ch, %s23
  br label %logical_or_right_end_4

logical_or_right_end_4:
  br label %logical_or_merge_4

logical_or_merge_4:
  %t25 = phi i1 [ true, %logical_or_entry_4 ], [ %t24, %logical_or_right_end_4 ]
  br label %logical_or_entry_3

logical_or_entry_3:
  br i1 %t25, label %logical_or_merge_3, label %logical_or_right_3

logical_or_right_3:
  %s26 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.26, i32 0, i32 0
  %t27 = icmp eq i8* %ch, %s26
  br label %logical_or_right_end_3

logical_or_right_end_3:
  br label %logical_or_merge_3

logical_or_merge_3:
  %t28 = phi i1 [ true, %logical_or_entry_3 ], [ %t27, %logical_or_right_end_3 ]
  br label %logical_or_entry_2

logical_or_entry_2:
  br i1 %t28, label %logical_or_merge_2, label %logical_or_right_2

logical_or_right_2:
  %s29 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.29, i32 0, i32 0
  %t30 = icmp eq i8* %ch, %s29
  br label %logical_or_right_end_2

logical_or_right_end_2:
  br label %logical_or_merge_2

logical_or_merge_2:
  %t31 = phi i1 [ true, %logical_or_entry_2 ], [ %t30, %logical_or_right_end_2 ]
  br label %logical_or_entry_1

logical_or_entry_1:
  br i1 %t31, label %logical_or_merge_1, label %logical_or_right_1

logical_or_right_1:
  %s32 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.32, i32 0, i32 0
  %t33 = icmp eq i8* %ch, %s32
  br label %logical_or_right_end_1

logical_or_right_end_1:
  br label %logical_or_merge_1

logical_or_merge_1:
  %t34 = phi i1 [ true, %logical_or_entry_1 ], [ %t33, %logical_or_right_end_1 ]
  br label %logical_or_entry_0

logical_or_entry_0:
  br i1 %t34, label %logical_or_merge_0, label %logical_or_right_0

logical_or_right_0:
  %s35 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.35, i32 0, i32 0
  %t36 = icmp eq i8* %ch, %s35
  br label %logical_or_right_end_0

logical_or_right_end_0:
  br label %logical_or_merge_0

logical_or_merge_0:
  %t37 = phi i1 [ true, %logical_or_entry_0 ], [ %t36, %logical_or_right_end_0 ]
  ret i1 %t37
}

define { i8**, i64 }* @trim_token_edges({ i8**, i64 }* %tokens) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t2 = extractvalue { i8**, i64 } %t1, 1
  %t3 = sitofp i64 %t2 to double
  store double %t3, double* %l1
  %t4 = load double, double* %l0
  %t5 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t27 = phi double [ %t4, %entry ], [ %t26, %loop.latch2 ]
  store double %t27, double* %l0
  br label %loop.body1
loop.body1:
  %t6 = load double, double* %l0
  %t7 = load double, double* %l1
  %t8 = fcmp oge double %t6, %t7
  %t9 = load double, double* %l0
  %t10 = load double, double* %l1
  br i1 %t8, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t11 = load double, double* %l0
  %t12 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t13 = extractvalue { i8**, i64 } %t12, 0
  %t14 = extractvalue { i8**, i64 } %t12, 1
  %t15 = icmp uge i64 %t11, %t14
  ; bounds check: %t15 (if true, out of bounds)
  %t16 = getelementptr i8*, i8** %t13, i64 %t11
  %t17 = load i8*, i8** %t16
  store i8* %t17, i8** %l2
  %t18 = load i8*, i8** %l2
  %t19 = call i1 @is_trivia_token(i8* %t18)
  %t20 = load double, double* %l0
  %t21 = load double, double* %l1
  %t22 = load i8*, i8** %l2
  br i1 %t19, label %then6, label %merge7
then6:
  %t23 = load double, double* %l0
  %t24 = sitofp i64 1 to double
  %t25 = fadd double %t23, %t24
  store double %t25, double* %l0
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  %t26 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t28 = load double, double* %l0
  %t29 = load double, double* %l1
  br label %loop.header8
loop.header8:
  %t44 = phi double [ %t29, %entry ], [ %t43, %loop.latch10 ]
  store double %t44, double* %l1
  br label %loop.body9
loop.body9:
  %t30 = load double, double* %l1
  %t31 = load double, double* %l0
  %t32 = fcmp ole double %t30, %t31
  %t33 = load double, double* %l0
  %t34 = load double, double* %l1
  br i1 %t32, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  store double 0.0, double* %l3
  %t35 = load double, double* %l3
  %t36 = call i1 @is_trivia_token(i8* null)
  %t37 = load double, double* %l0
  %t38 = load double, double* %l1
  %t39 = load double, double* %l3
  br i1 %t36, label %then14, label %merge15
then14:
  %t40 = load double, double* %l1
  %t41 = sitofp i64 1 to double
  %t42 = fsub double %t40, %t41
  store double %t42, double* %l1
  br label %loop.latch10
merge15:
  br label %afterloop11
loop.latch10:
  %t43 = load double, double* %l1
  br label %loop.header8
afterloop11:
  %t45 = load double, double* %l0
  %t46 = load double, double* %l1
  %t47 = call { i8**, i64 }* @token_slice({ i8**, i64 }* %tokens, double %t45, double %t46)
  ret { i8**, i64 }* %t47
}

define { i8**, i64 }* @token_slice({ i8**, i64 }* %tokens, double %start, double %end) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  store double %start, double* %l1
  %t5 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t6 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t25 = phi { i8**, i64 }* [ %t5, %entry ], [ %t23, %loop.latch2 ]
  %t26 = phi double [ %t6, %entry ], [ %t24, %loop.latch2 ]
  store { i8**, i64 }* %t25, { i8**, i64 }** %l0
  store double %t26, double* %l1
  br label %loop.body1
loop.body1:
  %t7 = load double, double* %l1
  %t8 = fcmp oge double %t7, %end
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t10 = load double, double* %l1
  br i1 %t8, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t12 = load double, double* %l1
  %t13 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t14 = extractvalue { i8**, i64 } %t13, 0
  %t15 = extractvalue { i8**, i64 } %t13, 1
  %t16 = icmp uge i64 %t12, %t15
  ; bounds check: %t16 (if true, out of bounds)
  %t17 = getelementptr i8*, i8** %t14, i64 %t12
  %t18 = load i8*, i8** %t17
  %t19 = call { i8**, i64 }* @append_token({ i8**, i64 }* %t11, i8* %t18)
  store { i8**, i64 }* %t19, { i8**, i64 }** %l0
  %t20 = load double, double* %l1
  %t21 = sitofp i64 1 to double
  %t22 = fadd double %t20, %t21
  store double %t22, double* %l1
  br label %loop.latch2
loop.latch2:
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t24 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t27
}

define { i8**, i64 }* @trim_block_tokens({ i8**, i64 }* %tokens) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca i8*
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t3 = extractvalue { i8**, i64 } %t2, 1
  %t4 = sitofp i64 %t3 to double
  store double %t4, double* %l2
  %t5 = load double, double* %l0
  %t6 = load double, double* %l1
  %t7 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t28 = phi double [ %t6, %entry ], [ %t27, %loop.latch2 ]
  store double %t28, double* %l1
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l1
  %t9 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t10 = extractvalue { i8**, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load double, double* %l0
  %t14 = load double, double* %l1
  %t15 = load double, double* %l2
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t16 = load double, double* %l1
  %t17 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t18 = extractvalue { i8**, i64 } %t17, 0
  %t19 = extractvalue { i8**, i64 } %t17, 1
  %t20 = icmp uge i64 %t16, %t19
  ; bounds check: %t20 (if true, out of bounds)
  %t21 = getelementptr i8*, i8** %t18, i64 %t16
  %t22 = load i8*, i8** %t21
  store i8* %t22, i8** %l3
  %t23 = load i8*, i8** %l3
  %t24 = load double, double* %l1
  %t25 = sitofp i64 1 to double
  %t26 = fadd double %t24, %t25
  store double %t26, double* %l1
  br label %loop.latch2
loop.latch2:
  %t27 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t29 = load double, double* %l2
  %t30 = sitofp i64 0 to double
  %t31 = call { i8**, i64 }* @token_slice({ i8**, i64 }* %tokens, double %t30, double %t29)
  ret { i8**, i64 }* %t31
}

define double @find_top_level_colon({ i8**, i64 }* %tokens) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca i8*
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = sitofp i64 0 to double
  store double %t2, double* %l2
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l3
  %t4 = sitofp i64 0 to double
  store double %t4, double* %l4
  %t5 = load double, double* %l0
  %t6 = load double, double* %l1
  %t7 = load double, double* %l2
  %t8 = load double, double* %l3
  %t9 = load double, double* %l4
  br label %loop.header0
loop.header0:
  %t32 = phi double [ %t9, %entry ], [ %t31, %loop.latch2 ]
  store double %t32, double* %l4
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l4
  %t11 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t12 = extractvalue { i8**, i64 } %t11, 1
  %t13 = sitofp i64 %t12 to double
  %t14 = fcmp oge double %t10, %t13
  %t15 = load double, double* %l0
  %t16 = load double, double* %l1
  %t17 = load double, double* %l2
  %t18 = load double, double* %l3
  %t19 = load double, double* %l4
  br i1 %t14, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t20 = load double, double* %l4
  %t21 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t22 = extractvalue { i8**, i64 } %t21, 0
  %t23 = extractvalue { i8**, i64 } %t21, 1
  %t24 = icmp uge i64 %t20, %t23
  ; bounds check: %t24 (if true, out of bounds)
  %t25 = getelementptr i8*, i8** %t22, i64 %t20
  %t26 = load i8*, i8** %t25
  store i8* %t26, i8** %l5
  %t27 = load i8*, i8** %l5
  %t28 = load double, double* %l4
  %t29 = sitofp i64 1 to double
  %t30 = fadd double %t28, %t29
  store double %t30, double* %l4
  br label %loop.latch2
loop.latch2:
  %t31 = load double, double* %l4
  br label %loop.header0
afterloop3:
  %t33 = sitofp i64 -1 to double
  ret double %t33
}

define %ExpressionCollectResult @expression_tokens_collect_until(%ExpressionTokens %state, { i8**, i64 }* %terminators) {
entry:
  %l0 = alloca %ExpressionTokens
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca i1
  store %ExpressionTokens %state, %ExpressionTokens* %l0
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l2
  %t6 = sitofp i64 0 to double
  store double %t6, double* %l3
  %t7 = sitofp i64 0 to double
  store double %t7, double* %l4
  %t8 = sitofp i64 0 to double
  store double %t8, double* %l5
  %t9 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t10 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t11 = load double, double* %l2
  %t12 = load double, double* %l3
  %t13 = load double, double* %l4
  %t14 = load double, double* %l5
  br label %loop.header0
loop.header0:
  %t60 = phi { i8**, i64 }* [ %t10, %entry ], [ %t58, %loop.latch2 ]
  %t61 = phi %ExpressionTokens [ %t9, %entry ], [ %t59, %loop.latch2 ]
  store { i8**, i64 }* %t60, { i8**, i64 }** %l1
  store %ExpressionTokens %t61, %ExpressionTokens* %l0
  br label %loop.body1
loop.body1:
  %t15 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t16 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t15)
  %t17 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t19 = load double, double* %l2
  %t20 = load double, double* %l3
  %t21 = load double, double* %l4
  %t22 = load double, double* %l5
  br i1 %t16, label %then4, label %merge5
then4:
  %t23 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t24 = insertvalue %ExpressionCollectResult undef, i8* null, 0
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t26 = insertvalue %ExpressionCollectResult %t24, { i8**, i64 }* %t25, 1
  %t27 = insertvalue %ExpressionCollectResult %t26, i1 0, 2
  ret %ExpressionCollectResult %t27
merge5:
  %t28 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t29 = call double @expression_tokens_peek(%ExpressionTokens %t28)
  store double %t29, double* %l6
  %t33 = load double, double* %l2
  %t34 = sitofp i64 0 to double
  %t35 = fcmp oeq double %t33, %t34
  br label %logical_and_entry_32

logical_and_entry_32:
  br i1 %t35, label %logical_and_right_32, label %logical_and_merge_32

logical_and_right_32:
  %t36 = load double, double* %l3
  %t37 = sitofp i64 0 to double
  %t38 = fcmp oeq double %t36, %t37
  br label %logical_and_right_end_32

logical_and_right_end_32:
  br label %logical_and_merge_32

logical_and_merge_32:
  %t39 = phi i1 [ false, %logical_and_entry_32 ], [ %t38, %logical_and_right_end_32 ]
  br label %logical_and_entry_31

logical_and_entry_31:
  br i1 %t39, label %logical_and_right_31, label %logical_and_merge_31

logical_and_right_31:
  %t40 = load double, double* %l4
  %t41 = sitofp i64 0 to double
  %t42 = fcmp oeq double %t40, %t41
  br label %logical_and_right_end_31

logical_and_right_end_31:
  br label %logical_and_merge_31

logical_and_merge_31:
  %t43 = phi i1 [ false, %logical_and_entry_31 ], [ %t42, %logical_and_right_end_31 ]
  br label %logical_and_entry_30

logical_and_entry_30:
  br i1 %t43, label %logical_and_right_30, label %logical_and_merge_30

logical_and_right_30:
  %t44 = load double, double* %l5
  %t45 = sitofp i64 0 to double
  %t46 = fcmp oeq double %t44, %t45
  br label %logical_and_right_end_30

logical_and_right_end_30:
  br label %logical_and_merge_30

logical_and_merge_30:
  %t47 = phi i1 [ false, %logical_and_entry_30 ], [ %t46, %logical_and_right_end_30 ]
  store i1 %t47, i1* %l7
  %t50 = load i1, i1* %l7
  br label %logical_and_entry_49

logical_and_entry_49:
  br i1 %t50, label %logical_and_right_49, label %logical_and_merge_49

logical_and_right_49:
  %t51 = load double, double* %l6
  %t52 = load double, double* %l6
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t54 = load double, double* %l6
  %t55 = call { i8**, i64 }* @append_token({ i8**, i64 }* %t53, i8* null)
  store { i8**, i64 }* %t55, { i8**, i64 }** %l1
  %t56 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t57 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %t56)
  store %ExpressionTokens %t57, %ExpressionTokens* %l0
  br label %loop.latch2
loop.latch2:
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t59 = load %ExpressionTokens, %ExpressionTokens* %l0
  br label %loop.header0
afterloop3:
  %t62 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t63 = insertvalue %ExpressionCollectResult undef, i8* null, 0
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t65 = insertvalue %ExpressionCollectResult %t63, { i8**, i64 }* %t64, 1
  %t66 = insertvalue %ExpressionCollectResult %t65, i1 1, 2
  ret %ExpressionCollectResult %t66
}

define %ExpressionBlockParseResult @collect_expression_block(%ExpressionTokens %state) {
entry:
  %l0 = alloca %ExpressionTokens
  %l1 = alloca double
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca double
  %l4 = alloca double
  store %ExpressionTokens %state, %ExpressionTokens* %l0
  %t0 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t1 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t0)
  %t2 = load %ExpressionTokens, %ExpressionTokens* %l0
  br i1 %t1, label %then0, label %merge1
then0:
  %t3 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t4 = insertvalue %ExpressionBlockParseResult undef, i8* null, 0
  %t5 = alloca [0 x double]
  %t6 = getelementptr [0 x double], [0 x double]* %t5, i32 0, i32 0
  %t7 = alloca { double*, i64 }
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 0
  store double* %t6, double** %t8
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  %t10 = insertvalue %ExpressionBlockParseResult %t4, { i8**, i64 }* null, 1
  %t11 = insertvalue %ExpressionBlockParseResult %t10, i1 0, 2
  ret %ExpressionBlockParseResult %t11
merge1:
  %t12 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t13 = call double @expression_tokens_peek(%ExpressionTokens %t12)
  store double %t13, double* %l1
  %t15 = load double, double* %l1
  %t16 = alloca [0 x double]
  %t17 = getelementptr [0 x double], [0 x double]* %t16, i32 0, i32 0
  %t18 = alloca { double*, i64 }
  %t19 = getelementptr { double*, i64 }, { double*, i64 }* %t18, i32 0, i32 0
  store double* %t17, double** %t19
  %t20 = getelementptr { double*, i64 }, { double*, i64 }* %t18, i32 0, i32 1
  store i64 0, i64* %t20
  store { i8**, i64 }* null, { i8**, i64 }** %l2
  %t21 = sitofp i64 0 to double
  store double %t21, double* %l3
  %t22 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t23 = load double, double* %l1
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t25 = load double, double* %l3
  br label %loop.header2
loop.header2:
  %t47 = phi { i8**, i64 }* [ %t24, %entry ], [ %t45, %loop.latch4 ]
  %t48 = phi %ExpressionTokens [ %t22, %entry ], [ %t46, %loop.latch4 ]
  store { i8**, i64 }* %t47, { i8**, i64 }** %l2
  store %ExpressionTokens %t48, %ExpressionTokens* %l0
  br label %loop.body3
loop.body3:
  %t26 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t27 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t26)
  %t28 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t29 = load double, double* %l1
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t31 = load double, double* %l3
  br i1 %t27, label %then6, label %merge7
then6:
  %t32 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t33 = insertvalue %ExpressionBlockParseResult undef, i8* null, 0
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t35 = insertvalue %ExpressionBlockParseResult %t33, { i8**, i64 }* %t34, 1
  %t36 = insertvalue %ExpressionBlockParseResult %t35, i1 0, 2
  ret %ExpressionBlockParseResult %t36
merge7:
  %t37 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t38 = call double @expression_tokens_peek(%ExpressionTokens %t37)
  store double %t38, double* %l4
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t40 = load double, double* %l4
  %t41 = call { i8**, i64 }* @append_token({ i8**, i64 }* %t39, i8* null)
  store { i8**, i64 }* %t41, { i8**, i64 }** %l2
  %t42 = load double, double* %l4
  %t43 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t44 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %t43)
  store %ExpressionTokens %t44, %ExpressionTokens* %l0
  br label %loop.latch4
loop.latch4:
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t46 = load %ExpressionTokens, %ExpressionTokens* %l0
  br label %loop.header2
afterloop5:
  %t49 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t50 = insertvalue %ExpressionBlockParseResult undef, i8* null, 0
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t52 = insertvalue %ExpressionBlockParseResult %t50, { i8**, i64 }* %t51, 1
  %t53 = insertvalue %ExpressionBlockParseResult %t52, i1 1, 2
  ret %ExpressionBlockParseResult %t53
}

define %LambdaParameterParseResult @parse_lambda_parameter(%ExpressionTokens %state) {
entry:
  %l0 = alloca %ExpressionTokens
  %l1 = alloca double
  %l2 = alloca i1
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca i8*
  %l6 = alloca i8*
  %l7 = alloca double
  %l8 = alloca i8*
  %l9 = alloca double
  %l10 = alloca { i8**, i64 }*
  %l11 = alloca double
  %l12 = alloca double
  store %ExpressionTokens %state, %ExpressionTokens* %l0
  %t0 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t1 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t0)
  %t2 = load %ExpressionTokens, %ExpressionTokens* %l0
  br i1 %t1, label %then0, label %merge1
then0:
  %t3 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t4 = insertvalue %LambdaParameterParseResult undef, i8* null, 0
  %t5 = insertvalue %LambdaParameterParseResult %t4, i8* null, 1
  %t6 = insertvalue %LambdaParameterParseResult %t5, i1 0, 2
  ret %LambdaParameterParseResult %t6
merge1:
  %t7 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t8 = extractvalue %ExpressionTokens %t7, 1
  store double %t8, double* %l1
  store i1 0, i1* %l2
  %t9 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t10 = call double @expression_tokens_peek(%ExpressionTokens %t9)
  store double %t10, double* %l3
  %t12 = load double, double* %l3
  %t13 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t14 = call double @expression_tokens_peek(%ExpressionTokens %t13)
  store double %t14, double* %l4
  %t15 = load double, double* %l4
  %t16 = load double, double* %l4
  %t17 = call i8* @identifier_text(i8* null)
  store i8* %t17, i8** %l5
  %t18 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t19 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %t18)
  store %ExpressionTokens %t19, %ExpressionTokens* %l0
  store i8* null, i8** %l6
  %t20 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t21 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t20)
  %t22 = xor i1 %t21, 1
  %t23 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t24 = load double, double* %l1
  %t25 = load i1, i1* %l2
  %t26 = load double, double* %l3
  %t27 = load double, double* %l4
  %t28 = load i8*, i8** %l5
  %t29 = load i8*, i8** %l6
  br i1 %t22, label %then2, label %merge3
then2:
  %t30 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t31 = call double @expression_tokens_peek(%ExpressionTokens %t30)
  store double %t31, double* %l7
  %t34 = load double, double* %l7
  br label %merge3
merge3:
  store i8* null, i8** %l8
  %t35 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t36 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t35)
  %t37 = xor i1 %t36, 1
  %t38 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t39 = load double, double* %l1
  %t40 = load i1, i1* %l2
  %t41 = load double, double* %l3
  %t42 = load double, double* %l4
  %t43 = load i8*, i8** %l5
  %t44 = load i8*, i8** %l6
  %t45 = load i8*, i8** %l8
  br i1 %t37, label %then4, label %merge5
then4:
  %t46 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t47 = call double @expression_tokens_peek(%ExpressionTokens %t46)
  store double %t47, double* %l9
  %t49 = load double, double* %l9
  br label %merge5
merge5:
  %t50 = extractvalue %ExpressionTokens %state, 0
  %t51 = load double, double* %l1
  %t52 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t53 = extractvalue %ExpressionTokens %t52, 1
  %t54 = call { i8**, i64 }* @token_slice({ i8**, i64 }* %t50, double %t51, double %t53)
  store { i8**, i64 }* %t54, { i8**, i64 }** %l10
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l10
  %t56 = call double @source_span_from_tokens({ i8**, i64 }* %t55)
  store double %t56, double* %l11
  store double 0.0, double* %l12
  %t57 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t58 = insertvalue %LambdaParameterParseResult undef, i8* null, 0
  %t59 = load double, double* %l12
  %t60 = insertvalue %LambdaParameterParseResult %t58, i8* null, 1
  %t61 = insertvalue %LambdaParameterParseResult %t60, i1 1, 2
  ret %LambdaParameterParseResult %t61
}

define %LambdaParameterListParseResult @parse_lambda_parameter_list(%ExpressionTokens %state) {
entry:
  %l0 = alloca %ExpressionTokens
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca %LambdaParameterParseResult
  %l4 = alloca double
  store %ExpressionTokens %state, %ExpressionTokens* %l0
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t5 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t6 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t5)
  %t7 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t8 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t6, label %then0, label %merge1
then0:
  %t9 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t10 = insertvalue %LambdaParameterListParseResult undef, i8* null, 0
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t12 = insertvalue %LambdaParameterListParseResult %t10, { i8**, i64 }* %t11, 1
  %t13 = insertvalue %LambdaParameterListParseResult %t12, i1 0, 2
  ret %LambdaParameterListParseResult %t13
merge1:
  %t14 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t15 = call double @expression_tokens_peek(%ExpressionTokens %t14)
  store double %t15, double* %l2
  %t16 = load double, double* %l2
  %t17 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t19 = load double, double* %l2
  br label %loop.header2
loop.header2:
  %t61 = phi { i8**, i64 }* [ %t18, %entry ], [ %t59, %loop.latch4 ]
  %t62 = phi %ExpressionTokens [ %t17, %entry ], [ %t60, %loop.latch4 ]
  store { i8**, i64 }* %t61, { i8**, i64 }** %l1
  store %ExpressionTokens %t62, %ExpressionTokens* %l0
  br label %loop.body3
loop.body3:
  %t20 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t21 = call %LambdaParameterParseResult @parse_lambda_parameter(%ExpressionTokens %t20)
  store %LambdaParameterParseResult %t21, %LambdaParameterParseResult* %l3
  %t22 = load %LambdaParameterParseResult, %LambdaParameterParseResult* %l3
  %t23 = extractvalue %LambdaParameterParseResult %t22, 2
  %t24 = xor i1 %t23, 1
  %t25 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t27 = load double, double* %l2
  %t28 = load %LambdaParameterParseResult, %LambdaParameterParseResult* %l3
  br i1 %t24, label %then6, label %merge7
then6:
  %t29 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t30 = insertvalue %LambdaParameterListParseResult undef, i8* null, 0
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t32 = insertvalue %LambdaParameterListParseResult %t30, { i8**, i64 }* %t31, 1
  %t33 = insertvalue %LambdaParameterListParseResult %t32, i1 0, 2
  ret %LambdaParameterListParseResult %t33
merge7:
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t35 = load %LambdaParameterParseResult, %LambdaParameterParseResult* %l3
  %t36 = extractvalue %LambdaParameterParseResult %t35, 1
  %t37 = call { i8**, i64 }* @append_parameter({ i8**, i64 }* %t34, i8* %t36)
  store { i8**, i64 }* %t37, { i8**, i64 }** %l1
  %t38 = load %LambdaParameterParseResult, %LambdaParameterParseResult* %l3
  %t39 = extractvalue %LambdaParameterParseResult %t38, 0
  store %ExpressionTokens zeroinitializer, %ExpressionTokens* %l0
  %t40 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t41 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t40)
  %t42 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t44 = load double, double* %l2
  %t45 = load %LambdaParameterParseResult, %LambdaParameterParseResult* %l3
  br i1 %t41, label %then8, label %merge9
then8:
  %t46 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t47 = insertvalue %LambdaParameterListParseResult undef, i8* null, 0
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t49 = insertvalue %LambdaParameterListParseResult %t47, { i8**, i64 }* %t48, 1
  %t50 = insertvalue %LambdaParameterListParseResult %t49, i1 0, 2
  ret %LambdaParameterListParseResult %t50
merge9:
  %t51 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t52 = call double @expression_tokens_peek(%ExpressionTokens %t51)
  store double %t52, double* %l4
  %t53 = load double, double* %l4
  %t54 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t55 = insertvalue %LambdaParameterListParseResult undef, i8* null, 0
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t57 = insertvalue %LambdaParameterListParseResult %t55, { i8**, i64 }* %t56, 1
  %t58 = insertvalue %LambdaParameterListParseResult %t57, i1 0, 2
  ret %LambdaParameterListParseResult %t58
loop.latch4:
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t60 = load %ExpressionTokens, %ExpressionTokens* %l0
  br label %loop.header2
afterloop5:
  %t63 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t64 = insertvalue %LambdaParameterListParseResult undef, i8* null, 0
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t66 = insertvalue %LambdaParameterListParseResult %t64, { i8**, i64 }* %t65, 1
  %t67 = insertvalue %LambdaParameterListParseResult %t66, i1 1, 2
  ret %LambdaParameterListParseResult %t67
}

define %ExpressionParseResult @parse_lambda_expression(%ExpressionTokens %state) {
entry:
  %l0 = alloca %ExpressionTokens
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca %LambdaParameterListParseResult
  %l4 = alloca { i8**, i64 }*
  %l5 = alloca i8*
  %l6 = alloca double
  %l7 = alloca %ExpressionBlockParseResult
  %l8 = alloca { i8**, i64 }*
  %l9 = alloca %Parser
  %l10 = alloca %BlockParseResult
  %l11 = alloca i8*
  store %ExpressionTokens %state, %ExpressionTokens* %l0
  %t0 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t1 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t0)
  %t2 = load %ExpressionTokens, %ExpressionTokens* %l0
  br i1 %t1, label %then0, label %merge1
then0:
  %t3 = call %ExpressionParseResult @expression_parse_failure(%ExpressionTokens %state)
  ret %ExpressionParseResult %t3
merge1:
  %t4 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t5 = call double @expression_tokens_peek(%ExpressionTokens %t4)
  store double %t5, double* %l1
  %t7 = load double, double* %l1
  %t8 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t9 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %t8)
  store %ExpressionTokens %t9, %ExpressionTokens* %l0
  %t10 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t11 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t10)
  %t12 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t13 = load double, double* %l1
  br i1 %t11, label %then2, label %merge3
then2:
  %t14 = call %ExpressionParseResult @expression_parse_failure(%ExpressionTokens %state)
  ret %ExpressionParseResult %t14
merge3:
  %t15 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t16 = call double @expression_tokens_peek(%ExpressionTokens %t15)
  store double %t16, double* %l2
  %t18 = load double, double* %l2
  %t19 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t20 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %t19)
  store %ExpressionTokens %t20, %ExpressionTokens* %l0
  %t21 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t22 = call %LambdaParameterListParseResult @parse_lambda_parameter_list(%ExpressionTokens %t21)
  store %LambdaParameterListParseResult %t22, %LambdaParameterListParseResult* %l3
  %t23 = load %LambdaParameterListParseResult, %LambdaParameterListParseResult* %l3
  %t24 = extractvalue %LambdaParameterListParseResult %t23, 2
  %t25 = xor i1 %t24, 1
  %t26 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t27 = load double, double* %l1
  %t28 = load double, double* %l2
  %t29 = load %LambdaParameterListParseResult, %LambdaParameterListParseResult* %l3
  br i1 %t25, label %then4, label %merge5
then4:
  %t30 = call %ExpressionParseResult @expression_parse_failure(%ExpressionTokens %state)
  ret %ExpressionParseResult %t30
merge5:
  %t31 = load %LambdaParameterListParseResult, %LambdaParameterListParseResult* %l3
  %t32 = extractvalue %LambdaParameterListParseResult %t31, 0
  store %ExpressionTokens zeroinitializer, %ExpressionTokens* %l0
  %t33 = load %LambdaParameterListParseResult, %LambdaParameterListParseResult* %l3
  %t34 = extractvalue %LambdaParameterListParseResult %t33, 1
  store { i8**, i64 }* %t34, { i8**, i64 }** %l4
  store i8* null, i8** %l5
  %t35 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t36 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t35)
  %t37 = xor i1 %t36, 1
  %t38 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t39 = load double, double* %l1
  %t40 = load double, double* %l2
  %t41 = load %LambdaParameterListParseResult, %LambdaParameterListParseResult* %l3
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t43 = load i8*, i8** %l5
  br i1 %t37, label %then6, label %merge7
then6:
  %t44 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t45 = call double @expression_tokens_peek(%ExpressionTokens %t44)
  store double %t45, double* %l6
  %t48 = load double, double* %l6
  br label %merge7
merge7:
  %t49 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t50 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t49)
  %t51 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t52 = load double, double* %l1
  %t53 = load double, double* %l2
  %t54 = load %LambdaParameterListParseResult, %LambdaParameterListParseResult* %l3
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t56 = load i8*, i8** %l5
  br i1 %t50, label %then8, label %merge9
then8:
  %t57 = call %ExpressionParseResult @expression_parse_failure(%ExpressionTokens %state)
  ret %ExpressionParseResult %t57
merge9:
  %t58 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t59 = call %ExpressionBlockParseResult @collect_expression_block(%ExpressionTokens %t58)
  store %ExpressionBlockParseResult %t59, %ExpressionBlockParseResult* %l7
  %t60 = load %ExpressionBlockParseResult, %ExpressionBlockParseResult* %l7
  %t61 = extractvalue %ExpressionBlockParseResult %t60, 2
  %t62 = xor i1 %t61, 1
  %t63 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t64 = load double, double* %l1
  %t65 = load double, double* %l2
  %t66 = load %LambdaParameterListParseResult, %LambdaParameterListParseResult* %l3
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t68 = load i8*, i8** %l5
  %t69 = load %ExpressionBlockParseResult, %ExpressionBlockParseResult* %l7
  br i1 %t62, label %then10, label %merge11
then10:
  %t70 = call %ExpressionParseResult @expression_parse_failure(%ExpressionTokens %state)
  ret %ExpressionParseResult %t70
merge11:
  %t71 = load %ExpressionBlockParseResult, %ExpressionBlockParseResult* %l7
  %t72 = extractvalue %ExpressionBlockParseResult %t71, 0
  store %ExpressionTokens zeroinitializer, %ExpressionTokens* %l0
  %t73 = load %ExpressionBlockParseResult, %ExpressionBlockParseResult* %l7
  %t74 = extractvalue %ExpressionBlockParseResult %t73, 1
  store { i8**, i64 }* %t74, { i8**, i64 }** %l8
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l8
  %t76 = insertvalue %Parser undef, { i8**, i64 }* %t75, 0
  %t77 = sitofp i64 0 to double
  %t78 = insertvalue %Parser %t76, double %t77, 1
  store %Parser %t78, %Parser* %l9
  %t79 = load %Parser, %Parser* %l9
  %t80 = call %BlockParseResult @parse_block(%Parser %t79)
  store %BlockParseResult %t80, %BlockParseResult* %l10
  %t81 = load %BlockParseResult, %BlockParseResult* %l10
  %t82 = extractvalue %BlockParseResult %t81, 1
  store i8* %t82, i8** %l11
  %t83 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t84 = insertvalue %ExpressionParseResult undef, i8* null, 0
  %t85 = insertvalue %ExpressionParseResult %t84, i8* null, 1
  %t86 = insertvalue %ExpressionParseResult %t85, i1 1, 2
  ret %ExpressionParseResult %t86
}

define %ExpressionParseResult @parse_expression_bp(%ExpressionTokens %state, double %min_precedence) {
entry:
  %l0 = alloca %ExpressionParseResult
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca %ExpressionParseResult
  %t0 = call %ExpressionParseResult @parse_prefix_expression(%ExpressionTokens %state)
  store %ExpressionParseResult %t0, %ExpressionParseResult* %l0
  %t1 = load %ExpressionParseResult, %ExpressionParseResult* %l0
  %t2 = extractvalue %ExpressionParseResult %t1, 2
  %t3 = xor i1 %t2, 1
  %t4 = load %ExpressionParseResult, %ExpressionParseResult* %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = load %ExpressionParseResult, %ExpressionParseResult* %l0
  ret %ExpressionParseResult %t5
merge1:
  %t6 = load %ExpressionParseResult, %ExpressionParseResult* %l0
  %t7 = extractvalue %ExpressionParseResult %t6, 0
  store i8* %t7, i8** %l1
  %t8 = load %ExpressionParseResult, %ExpressionParseResult* %l0
  %t9 = extractvalue %ExpressionParseResult %t8, 1
  store i8* %t9, i8** %l2
  %t10 = load %ExpressionParseResult, %ExpressionParseResult* %l0
  %t11 = load i8*, i8** %l1
  %t12 = load i8*, i8** %l2
  br label %loop.header2
loop.header2:
  %t64 = phi i8* [ %t11, %entry ], [ %t63, %loop.latch4 ]
  store i8* %t64, i8** %l1
  br label %loop.body3
loop.body3:
  %t13 = load i8*, i8** %l1
  %t14 = call i1 @expression_tokens_is_at_end(%ExpressionTokens zeroinitializer)
  %t15 = load %ExpressionParseResult, %ExpressionParseResult* %l0
  %t16 = load i8*, i8** %l1
  %t17 = load i8*, i8** %l2
  br i1 %t14, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t18 = load i8*, i8** %l1
  %t19 = call double @expression_tokens_peek(%ExpressionTokens zeroinitializer)
  store double %t19, double* %l3
  %t20 = load double, double* %l3
  %t21 = load double, double* %l3
  store double 0.0, double* %l4
  %t22 = load double, double* %l4
  %t23 = call double @binary_precedence(i8* null)
  store double %t23, double* %l5
  %t24 = load double, double* %l5
  %t25 = sitofp i64 -1 to double
  %t26 = fcmp oeq double %t24, %t25
  %t27 = load %ExpressionParseResult, %ExpressionParseResult* %l0
  %t28 = load i8*, i8** %l1
  %t29 = load i8*, i8** %l2
  %t30 = load double, double* %l3
  %t31 = load double, double* %l4
  %t32 = load double, double* %l5
  br i1 %t26, label %then8, label %merge9
then8:
  br label %afterloop5
merge9:
  %t33 = load double, double* %l5
  %t34 = fcmp olt double %t33, %min_precedence
  %t35 = load %ExpressionParseResult, %ExpressionParseResult* %l0
  %t36 = load i8*, i8** %l1
  %t37 = load i8*, i8** %l2
  %t38 = load double, double* %l3
  %t39 = load double, double* %l4
  %t40 = load double, double* %l5
  br i1 %t34, label %then10, label %merge11
then10:
  br label %afterloop5
merge11:
  %t41 = load i8*, i8** %l1
  %t42 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens zeroinitializer)
  store i8* null, i8** %l1
  %t43 = load i8*, i8** %l1
  %t44 = load double, double* %l5
  %t45 = sitofp i64 1 to double
  %t46 = fadd double %t44, %t45
  %t47 = call %ExpressionParseResult @parse_expression_bp(%ExpressionTokens zeroinitializer, double %t46)
  store %ExpressionParseResult %t47, %ExpressionParseResult* %l6
  %t48 = load %ExpressionParseResult, %ExpressionParseResult* %l6
  %t49 = extractvalue %ExpressionParseResult %t48, 2
  %t50 = xor i1 %t49, 1
  %t51 = load %ExpressionParseResult, %ExpressionParseResult* %l0
  %t52 = load i8*, i8** %l1
  %t53 = load i8*, i8** %l2
  %t54 = load double, double* %l3
  %t55 = load double, double* %l4
  %t56 = load double, double* %l5
  %t57 = load %ExpressionParseResult, %ExpressionParseResult* %l6
  br i1 %t50, label %then12, label %merge13
then12:
  %t58 = call %ExpressionParseResult @expression_parse_failure(%ExpressionTokens %state)
  ret %ExpressionParseResult %t58
merge13:
  %t59 = load %ExpressionParseResult, %ExpressionParseResult* %l6
  %t60 = extractvalue %ExpressionParseResult %t59, 0
  store i8* %t60, i8** %l1
  %t61 = load double, double* %l4
  %s62 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.62, i32 0, i32 0
  br label %loop.latch4
loop.latch4:
  %t63 = load i8*, i8** %l1
  br label %loop.header2
afterloop5:
  %t65 = load i8*, i8** %l1
  %t66 = insertvalue %ExpressionParseResult undef, i8* %t65, 0
  %t67 = load i8*, i8** %l2
  %t68 = insertvalue %ExpressionParseResult %t66, i8* %t67, 1
  %t69 = insertvalue %ExpressionParseResult %t68, i1 1, 2
  ret %ExpressionParseResult %t69
}

define %ExpressionParseResult @parse_prefix_expression(%ExpressionTokens %state) {
entry:
  %l0 = alloca double
  %l1 = alloca %ExpressionParseResult
  %t0 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %state)
  br i1 %t0, label %then0, label %merge1
then0:
  %t1 = call %ExpressionParseResult @expression_parse_failure(%ExpressionTokens %state)
  ret %ExpressionParseResult %t1
merge1:
  %t2 = call double @expression_tokens_peek(%ExpressionTokens %state)
  store double %t2, double* %l0
  %t3 = load double, double* %l0
  %t5 = load double, double* %l0
  %t6 = call %ExpressionParseResult @parse_primary_expression(%ExpressionTokens %state)
  store %ExpressionParseResult %t6, %ExpressionParseResult* %l1
  %t7 = load %ExpressionParseResult, %ExpressionParseResult* %l1
  %t8 = extractvalue %ExpressionParseResult %t7, 2
  %t9 = xor i1 %t8, 1
  %t10 = load double, double* %l0
  %t11 = load %ExpressionParseResult, %ExpressionParseResult* %l1
  br i1 %t9, label %then2, label %merge3
then2:
  %t12 = load %ExpressionParseResult, %ExpressionParseResult* %l1
  ret %ExpressionParseResult %t12
merge3:
  %t13 = load %ExpressionParseResult, %ExpressionParseResult* %l1
  %t14 = extractvalue %ExpressionParseResult %t13, 0
  %t15 = load %ExpressionParseResult, %ExpressionParseResult* %l1
  %t16 = extractvalue %ExpressionParseResult %t15, 1
  %t17 = call %ExpressionParseResult @parse_postfix_chain(%ExpressionTokens zeroinitializer, i8* %t16)
  ret %ExpressionParseResult %t17
}

define %ExpressionParseResult @parse_primary_expression(%ExpressionTokens %state) {
entry:
  %l0 = alloca double
  %t0 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %state)
  br i1 %t0, label %then0, label %merge1
then0:
  %t1 = call %ExpressionParseResult @expression_parse_failure(%ExpressionTokens %state)
  ret %ExpressionParseResult %t1
merge1:
  %t2 = call double @expression_tokens_peek(%ExpressionTokens %state)
  store double %t2, double* %l0
  %t3 = load double, double* %l0
  %t4 = load double, double* %l0
  %t5 = load double, double* %l0
  %t6 = load double, double* %l0
  %t8 = load double, double* %l0
  %t10 = load double, double* %l0
  %t12 = load double, double* %l0
  %t13 = call %ExpressionParseResult @expression_parse_failure(%ExpressionTokens %state)
  ret %ExpressionParseResult %t13
}

define %ExpressionParseResult @parse_postfix_chain(%ExpressionTokens %state, i8* %expression) {
entry:
  %l0 = alloca %ExpressionTokens
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  store %ExpressionTokens %state, %ExpressionTokens* %l0
  store i8* %expression, i8** %l1
  %t0 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t1 = load i8*, i8** %l1
  br label %loop.header0
loop.header0:
  br label %loop.body1
loop.body1:
  %t2 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t3 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t2)
  %t4 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t5 = load i8*, i8** %l1
  br i1 %t3, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t6 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t7 = call double @expression_tokens_peek(%ExpressionTokens %t6)
  store double %t7, double* %l2
  %t8 = load double, double* %l2
  %t9 = load double, double* %l2
  store double 0.0, double* %l3
  %t10 = load double, double* %l3
  %s11 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.11, i32 0, i32 0
  %t12 = load double, double* %l3
  %s13 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.13, i32 0, i32 0
  %t14 = load double, double* %l3
  %s15 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.15, i32 0, i32 0
  %t16 = load double, double* %l3
  %s17 = getelementptr inbounds [2 x i8], [2 x i8]* @.str.17, i32 0, i32 0
  br label %afterloop3
loop.latch2:
  br label %loop.header0
afterloop3:
  %t18 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t19 = insertvalue %ExpressionParseResult undef, i8* null, 0
  %t20 = load i8*, i8** %l1
  %t21 = insertvalue %ExpressionParseResult %t19, i8* %t20, 1
  %t22 = insertvalue %ExpressionParseResult %t21, i1 1, 2
  ret %ExpressionParseResult %t22
}

define %CallArgumentsParseResult @parse_call_arguments(%ExpressionTokens %state) {
entry:
  %l0 = alloca %ExpressionTokens
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca %ExpressionParseResult
  %l3 = alloca double
  %t0 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %state)
  store %ExpressionTokens %t0, %ExpressionTokens* %l0
  %t1 = alloca [0 x double]
  %t2 = getelementptr [0 x double], [0 x double]* %t1, i32 0, i32 0
  %t3 = alloca { double*, i64 }
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 0
  store double* %t2, double** %t4
  %t5 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t6 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t7 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t6)
  %t8 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t7, label %then0, label %merge1
then0:
  %t10 = insertvalue %CallArgumentsParseResult undef, i8* null, 0
  %t11 = alloca [0 x double]
  %t12 = getelementptr [0 x double], [0 x double]* %t11, i32 0, i32 0
  %t13 = alloca { double*, i64 }
  %t14 = getelementptr { double*, i64 }, { double*, i64 }* %t13, i32 0, i32 0
  store double* %t12, double** %t14
  %t15 = getelementptr { double*, i64 }, { double*, i64 }* %t13, i32 0, i32 1
  store i64 0, i64* %t15
  %t16 = insertvalue %CallArgumentsParseResult %t10, { i8**, i64 }* null, 1
  %t17 = insertvalue %CallArgumentsParseResult %t16, i1 0, 2
  ret %CallArgumentsParseResult %t17
merge1:
  %t18 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t19 = call double @expression_tokens_peek(%ExpressionTokens %t18)
  %t20 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %loop.header2
loop.header2:
  %t73 = phi { i8**, i64 }* [ %t21, %entry ], [ %t71, %loop.latch4 ]
  %t74 = phi %ExpressionTokens [ %t20, %entry ], [ %t72, %loop.latch4 ]
  store { i8**, i64 }* %t73, { i8**, i64 }** %l1
  store %ExpressionTokens %t74, %ExpressionTokens* %l0
  br label %loop.body3
loop.body3:
  %t22 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t23 = sitofp i64 0 to double
  %t24 = call %ExpressionParseResult @parse_expression_bp(%ExpressionTokens %t22, double %t23)
  store %ExpressionParseResult %t24, %ExpressionParseResult* %l2
  %t25 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  %t26 = extractvalue %ExpressionParseResult %t25, 2
  %t27 = xor i1 %t26, 1
  %t28 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t30 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  br i1 %t27, label %then6, label %merge7
then6:
  %t31 = insertvalue %CallArgumentsParseResult undef, i8* null, 0
  %t32 = alloca [0 x double]
  %t33 = getelementptr [0 x double], [0 x double]* %t32, i32 0, i32 0
  %t34 = alloca { double*, i64 }
  %t35 = getelementptr { double*, i64 }, { double*, i64 }* %t34, i32 0, i32 0
  store double* %t33, double** %t35
  %t36 = getelementptr { double*, i64 }, { double*, i64 }* %t34, i32 0, i32 1
  store i64 0, i64* %t36
  %t37 = insertvalue %CallArgumentsParseResult %t31, { i8**, i64 }* null, 1
  %t38 = insertvalue %CallArgumentsParseResult %t37, i1 0, 2
  ret %CallArgumentsParseResult %t38
merge7:
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t40 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  %t41 = extractvalue %ExpressionParseResult %t40, 1
  %t42 = call { i8**, i64 }* @append_expression({ i8**, i64 }* %t39, i8* %t41)
  store { i8**, i64 }* %t42, { i8**, i64 }** %l1
  %t43 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  %t44 = extractvalue %ExpressionParseResult %t43, 0
  store %ExpressionTokens zeroinitializer, %ExpressionTokens* %l0
  %t45 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t46 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t45)
  %t47 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t49 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  br i1 %t46, label %then8, label %merge9
then8:
  %t50 = insertvalue %CallArgumentsParseResult undef, i8* null, 0
  %t51 = alloca [0 x double]
  %t52 = getelementptr [0 x double], [0 x double]* %t51, i32 0, i32 0
  %t53 = alloca { double*, i64 }
  %t54 = getelementptr { double*, i64 }, { double*, i64 }* %t53, i32 0, i32 0
  store double* %t52, double** %t54
  %t55 = getelementptr { double*, i64 }, { double*, i64 }* %t53, i32 0, i32 1
  store i64 0, i64* %t55
  %t56 = insertvalue %CallArgumentsParseResult %t50, { i8**, i64 }* null, 1
  %t57 = insertvalue %CallArgumentsParseResult %t56, i1 0, 2
  ret %CallArgumentsParseResult %t57
merge9:
  %t58 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t59 = call double @expression_tokens_peek(%ExpressionTokens %t58)
  store double %t59, double* %l3
  %t61 = load double, double* %l3
  %t62 = load double, double* %l3
  %t63 = insertvalue %CallArgumentsParseResult undef, i8* null, 0
  %t64 = alloca [0 x double]
  %t65 = getelementptr [0 x double], [0 x double]* %t64, i32 0, i32 0
  %t66 = alloca { double*, i64 }
  %t67 = getelementptr { double*, i64 }, { double*, i64 }* %t66, i32 0, i32 0
  store double* %t65, double** %t67
  %t68 = getelementptr { double*, i64 }, { double*, i64 }* %t66, i32 0, i32 1
  store i64 0, i64* %t68
  %t69 = insertvalue %CallArgumentsParseResult %t63, { i8**, i64 }* null, 1
  %t70 = insertvalue %CallArgumentsParseResult %t69, i1 0, 2
  ret %CallArgumentsParseResult %t70
loop.latch4:
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t72 = load %ExpressionTokens, %ExpressionTokens* %l0
  br label %loop.header2
afterloop5:
  %t75 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t76 = insertvalue %CallArgumentsParseResult undef, i8* null, 0
  %t77 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t78 = insertvalue %CallArgumentsParseResult %t76, { i8**, i64 }* %t77, 1
  %t79 = insertvalue %CallArgumentsParseResult %t78, i1 1, 2
  ret %CallArgumentsParseResult %t79
}

define %ArrayLiteralParseResult @parse_array_literal(%ExpressionTokens %state) {
entry:
  %l0 = alloca %ExpressionTokens
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca %ExpressionParseResult
  %l3 = alloca double
  store %ExpressionTokens %state, %ExpressionTokens* %l0
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t5 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t6 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t5)
  %t7 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t8 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t6, label %then0, label %merge1
then0:
  %t9 = insertvalue %ArrayLiteralParseResult undef, i8* null, 0
  %t10 = alloca [0 x double]
  %t11 = getelementptr [0 x double], [0 x double]* %t10, i32 0, i32 0
  %t12 = alloca { double*, i64 }
  %t13 = getelementptr { double*, i64 }, { double*, i64 }* %t12, i32 0, i32 0
  store double* %t11, double** %t13
  %t14 = getelementptr { double*, i64 }, { double*, i64 }* %t12, i32 0, i32 1
  store i64 0, i64* %t14
  %t15 = insertvalue %ArrayLiteralParseResult %t9, { i8**, i64 }* null, 1
  %t16 = insertvalue %ArrayLiteralParseResult %t15, i1 0, 2
  ret %ArrayLiteralParseResult %t16
merge1:
  %t18 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t19 = call double @expression_tokens_peek(%ExpressionTokens %t18)
  %t20 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %loop.header2
loop.header2:
  %t74 = phi { i8**, i64 }* [ %t21, %entry ], [ %t72, %loop.latch4 ]
  %t75 = phi %ExpressionTokens [ %t20, %entry ], [ %t73, %loop.latch4 ]
  store { i8**, i64 }* %t74, { i8**, i64 }** %l1
  store %ExpressionTokens %t75, %ExpressionTokens* %l0
  br label %loop.body3
loop.body3:
  %t22 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t23 = sitofp i64 0 to double
  %t24 = call %ExpressionParseResult @parse_expression_bp(%ExpressionTokens %t22, double %t23)
  store %ExpressionParseResult %t24, %ExpressionParseResult* %l2
  %t25 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  %t26 = extractvalue %ExpressionParseResult %t25, 2
  %t27 = xor i1 %t26, 1
  %t28 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t30 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  br i1 %t27, label %then6, label %merge7
then6:
  %t31 = insertvalue %ArrayLiteralParseResult undef, i8* null, 0
  %t32 = alloca [0 x double]
  %t33 = getelementptr [0 x double], [0 x double]* %t32, i32 0, i32 0
  %t34 = alloca { double*, i64 }
  %t35 = getelementptr { double*, i64 }, { double*, i64 }* %t34, i32 0, i32 0
  store double* %t33, double** %t35
  %t36 = getelementptr { double*, i64 }, { double*, i64 }* %t34, i32 0, i32 1
  store i64 0, i64* %t36
  %t37 = insertvalue %ArrayLiteralParseResult %t31, { i8**, i64 }* null, 1
  %t38 = insertvalue %ArrayLiteralParseResult %t37, i1 0, 2
  ret %ArrayLiteralParseResult %t38
merge7:
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t40 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  %t41 = extractvalue %ExpressionParseResult %t40, 1
  %t42 = call { i8**, i64 }* @append_expression({ i8**, i64 }* %t39, i8* %t41)
  store { i8**, i64 }* %t42, { i8**, i64 }** %l1
  %t43 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  %t44 = extractvalue %ExpressionParseResult %t43, 0
  store %ExpressionTokens zeroinitializer, %ExpressionTokens* %l0
  %t45 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t46 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t45)
  %t47 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t49 = load %ExpressionParseResult, %ExpressionParseResult* %l2
  br i1 %t46, label %then8, label %merge9
then8:
  %t50 = insertvalue %ArrayLiteralParseResult undef, i8* null, 0
  %t51 = alloca [0 x double]
  %t52 = getelementptr [0 x double], [0 x double]* %t51, i32 0, i32 0
  %t53 = alloca { double*, i64 }
  %t54 = getelementptr { double*, i64 }, { double*, i64 }* %t53, i32 0, i32 0
  store double* %t52, double** %t54
  %t55 = getelementptr { double*, i64 }, { double*, i64 }* %t53, i32 0, i32 1
  store i64 0, i64* %t55
  %t56 = insertvalue %ArrayLiteralParseResult %t50, { i8**, i64 }* null, 1
  %t57 = insertvalue %ArrayLiteralParseResult %t56, i1 0, 2
  ret %ArrayLiteralParseResult %t57
merge9:
  %t58 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t59 = call double @expression_tokens_peek(%ExpressionTokens %t58)
  store double %t59, double* %l3
  %t61 = load double, double* %l3
  %t63 = load double, double* %l3
  %t64 = insertvalue %ArrayLiteralParseResult undef, i8* null, 0
  %t65 = alloca [0 x double]
  %t66 = getelementptr [0 x double], [0 x double]* %t65, i32 0, i32 0
  %t67 = alloca { double*, i64 }
  %t68 = getelementptr { double*, i64 }, { double*, i64 }* %t67, i32 0, i32 0
  store double* %t66, double** %t68
  %t69 = getelementptr { double*, i64 }, { double*, i64 }* %t67, i32 0, i32 1
  store i64 0, i64* %t69
  %t70 = insertvalue %ArrayLiteralParseResult %t64, { i8**, i64 }* null, 1
  %t71 = insertvalue %ArrayLiteralParseResult %t70, i1 0, 2
  ret %ArrayLiteralParseResult %t71
loop.latch4:
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t73 = load %ExpressionTokens, %ExpressionTokens* %l0
  br label %loop.header2
afterloop5:
  %t76 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t77 = insertvalue %ArrayLiteralParseResult undef, i8* null, 0
  %t78 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t79 = insertvalue %ArrayLiteralParseResult %t77, { i8**, i64 }* %t78, 1
  %t80 = insertvalue %ArrayLiteralParseResult %t79, i1 1, 2
  ret %ArrayLiteralParseResult %t80
}

define %ObjectLiteralParseResult @parse_object_literal(%ExpressionTokens %state) {
entry:
  %l0 = alloca %ExpressionTokens
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca i8*
  %l4 = alloca double
  %l5 = alloca %ExpressionParseResult
  %l6 = alloca double
  store %ExpressionTokens %state, %ExpressionTokens* %l0
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t5 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t6 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t5)
  %t7 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t8 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t6, label %then0, label %merge1
then0:
  %t9 = insertvalue %ObjectLiteralParseResult undef, i8* null, 0
  %t10 = alloca [0 x double]
  %t11 = getelementptr [0 x double], [0 x double]* %t10, i32 0, i32 0
  %t12 = alloca { double*, i64 }
  %t13 = getelementptr { double*, i64 }, { double*, i64 }* %t12, i32 0, i32 0
  store double* %t11, double** %t13
  %t14 = getelementptr { double*, i64 }, { double*, i64 }* %t12, i32 0, i32 1
  store i64 0, i64* %t14
  %t15 = insertvalue %ObjectLiteralParseResult %t9, { i8**, i64 }* null, 1
  %t16 = insertvalue %ObjectLiteralParseResult %t15, i1 0, 2
  ret %ObjectLiteralParseResult %t16
merge1:
  %t18 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t19 = call double @expression_tokens_peek(%ExpressionTokens %t18)
  %t20 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %loop.header2
loop.header2:
  %t116 = phi %ExpressionTokens [ %t20, %entry ], [ %t114, %loop.latch4 ]
  %t117 = phi { i8**, i64 }* [ %t21, %entry ], [ %t115, %loop.latch4 ]
  store %ExpressionTokens %t116, %ExpressionTokens* %l0
  store { i8**, i64 }* %t117, { i8**, i64 }** %l1
  br label %loop.body3
loop.body3:
  %t22 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t23 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t22)
  %t24 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t23, label %then6, label %merge7
then6:
  %t26 = insertvalue %ObjectLiteralParseResult undef, i8* null, 0
  %t27 = alloca [0 x double]
  %t28 = getelementptr [0 x double], [0 x double]* %t27, i32 0, i32 0
  %t29 = alloca { double*, i64 }
  %t30 = getelementptr { double*, i64 }, { double*, i64 }* %t29, i32 0, i32 0
  store double* %t28, double** %t30
  %t31 = getelementptr { double*, i64 }, { double*, i64 }* %t29, i32 0, i32 1
  store i64 0, i64* %t31
  %t32 = insertvalue %ObjectLiteralParseResult %t26, { i8**, i64 }* null, 1
  %t33 = insertvalue %ObjectLiteralParseResult %t32, i1 0, 2
  ret %ObjectLiteralParseResult %t33
merge7:
  %t34 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t35 = call double @expression_tokens_peek(%ExpressionTokens %t34)
  store double %t35, double* %l2
  %t36 = load double, double* %l2
  %t37 = load double, double* %l2
  %t38 = call i8* @identifier_text(i8* null)
  store i8* %t38, i8** %l3
  %t39 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t40 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %t39)
  store %ExpressionTokens %t40, %ExpressionTokens* %l0
  %t41 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t42 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t41)
  %t43 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t45 = load double, double* %l2
  %t46 = load i8*, i8** %l3
  br i1 %t42, label %then8, label %merge9
then8:
  %t47 = insertvalue %ObjectLiteralParseResult undef, i8* null, 0
  %t48 = alloca [0 x double]
  %t49 = getelementptr [0 x double], [0 x double]* %t48, i32 0, i32 0
  %t50 = alloca { double*, i64 }
  %t51 = getelementptr { double*, i64 }, { double*, i64 }* %t50, i32 0, i32 0
  store double* %t49, double** %t51
  %t52 = getelementptr { double*, i64 }, { double*, i64 }* %t50, i32 0, i32 1
  store i64 0, i64* %t52
  %t53 = insertvalue %ObjectLiteralParseResult %t47, { i8**, i64 }* null, 1
  %t54 = insertvalue %ObjectLiteralParseResult %t53, i1 0, 2
  ret %ObjectLiteralParseResult %t54
merge9:
  %t55 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t56 = call double @expression_tokens_peek(%ExpressionTokens %t55)
  store double %t56, double* %l4
  %t58 = load double, double* %l4
  %t59 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t60 = call %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %t59)
  store %ExpressionTokens %t60, %ExpressionTokens* %l0
  %t61 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t62 = sitofp i64 0 to double
  %t63 = call %ExpressionParseResult @parse_expression_bp(%ExpressionTokens %t61, double %t62)
  store %ExpressionParseResult %t63, %ExpressionParseResult* %l5
  %t64 = load %ExpressionParseResult, %ExpressionParseResult* %l5
  %t65 = extractvalue %ExpressionParseResult %t64, 2
  %t66 = xor i1 %t65, 1
  %t67 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t69 = load double, double* %l2
  %t70 = load i8*, i8** %l3
  %t71 = load double, double* %l4
  %t72 = load %ExpressionParseResult, %ExpressionParseResult* %l5
  br i1 %t66, label %then10, label %merge11
then10:
  %t73 = insertvalue %ObjectLiteralParseResult undef, i8* null, 0
  %t74 = alloca [0 x double]
  %t75 = getelementptr [0 x double], [0 x double]* %t74, i32 0, i32 0
  %t76 = alloca { double*, i64 }
  %t77 = getelementptr { double*, i64 }, { double*, i64 }* %t76, i32 0, i32 0
  store double* %t75, double** %t77
  %t78 = getelementptr { double*, i64 }, { double*, i64 }* %t76, i32 0, i32 1
  store i64 0, i64* %t78
  %t79 = insertvalue %ObjectLiteralParseResult %t73, { i8**, i64 }* null, 1
  %t80 = insertvalue %ObjectLiteralParseResult %t79, i1 0, 2
  ret %ObjectLiteralParseResult %t80
merge11:
  %t81 = load %ExpressionParseResult, %ExpressionParseResult* %l5
  %t82 = extractvalue %ExpressionParseResult %t81, 0
  store %ExpressionTokens zeroinitializer, %ExpressionTokens* %l0
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t84 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t85 = call i1 @expression_tokens_is_at_end(%ExpressionTokens %t84)
  %t86 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t87 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t88 = load double, double* %l2
  %t89 = load i8*, i8** %l3
  %t90 = load double, double* %l4
  %t91 = load %ExpressionParseResult, %ExpressionParseResult* %l5
  br i1 %t85, label %then12, label %merge13
then12:
  %t92 = insertvalue %ObjectLiteralParseResult undef, i8* null, 0
  %t93 = alloca [0 x double]
  %t94 = getelementptr [0 x double], [0 x double]* %t93, i32 0, i32 0
  %t95 = alloca { double*, i64 }
  %t96 = getelementptr { double*, i64 }, { double*, i64 }* %t95, i32 0, i32 0
  store double* %t94, double** %t96
  %t97 = getelementptr { double*, i64 }, { double*, i64 }* %t95, i32 0, i32 1
  store i64 0, i64* %t97
  %t98 = insertvalue %ObjectLiteralParseResult %t92, { i8**, i64 }* null, 1
  %t99 = insertvalue %ObjectLiteralParseResult %t98, i1 0, 2
  ret %ObjectLiteralParseResult %t99
merge13:
  %t100 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t101 = call double @expression_tokens_peek(%ExpressionTokens %t100)
  store double %t101, double* %l6
  %t103 = load double, double* %l6
  %t105 = load double, double* %l6
  %t106 = insertvalue %ObjectLiteralParseResult undef, i8* null, 0
  %t107 = alloca [0 x double]
  %t108 = getelementptr [0 x double], [0 x double]* %t107, i32 0, i32 0
  %t109 = alloca { double*, i64 }
  %t110 = getelementptr { double*, i64 }, { double*, i64 }* %t109, i32 0, i32 0
  store double* %t108, double** %t110
  %t111 = getelementptr { double*, i64 }, { double*, i64 }* %t109, i32 0, i32 1
  store i64 0, i64* %t111
  %t112 = insertvalue %ObjectLiteralParseResult %t106, { i8**, i64 }* null, 1
  %t113 = insertvalue %ObjectLiteralParseResult %t112, i1 0, 2
  ret %ObjectLiteralParseResult %t113
loop.latch4:
  %t114 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t115 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %loop.header2
afterloop5:
  %t118 = load %ExpressionTokens, %ExpressionTokens* %l0
  %t119 = insertvalue %ObjectLiteralParseResult undef, i8* null, 0
  %t120 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t121 = insertvalue %ObjectLiteralParseResult %t119, { i8**, i64 }* %t120, 1
  %t122 = insertvalue %ObjectLiteralParseResult %t121, i1 1, 2
  ret %ObjectLiteralParseResult %t122
}

define %ExpressionParseResult @parse_struct_literal(%ExpressionTokens %state, i8* %target) {
entry:
  %l0 = alloca %StructTypeNameResult
  %l1 = alloca %ObjectLiteralParseResult
  %t0 = call %StructTypeNameResult @collect_struct_type_name(i8* %target)
  store %StructTypeNameResult %t0, %StructTypeNameResult* %l0
  %t1 = load %StructTypeNameResult, %StructTypeNameResult* %l0
  %t2 = extractvalue %StructTypeNameResult %t1, 1
  %t3 = xor i1 %t2, 1
  %t4 = load %StructTypeNameResult, %StructTypeNameResult* %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = call %ExpressionParseResult @expression_parse_failure(%ExpressionTokens %state)
  ret %ExpressionParseResult %t5
merge1:
  %t6 = call %ObjectLiteralParseResult @parse_object_literal(%ExpressionTokens %state)
  store %ObjectLiteralParseResult %t6, %ObjectLiteralParseResult* %l1
  %t7 = load %ObjectLiteralParseResult, %ObjectLiteralParseResult* %l1
  %t8 = extractvalue %ObjectLiteralParseResult %t7, 2
  %t9 = xor i1 %t8, 1
  %t10 = load %StructTypeNameResult, %StructTypeNameResult* %l0
  %t11 = load %ObjectLiteralParseResult, %ObjectLiteralParseResult* %l1
  br i1 %t9, label %then2, label %merge3
then2:
  %t12 = call %ExpressionParseResult @expression_parse_failure(%ExpressionTokens %state)
  ret %ExpressionParseResult %t12
merge3:
  %t13 = load %ObjectLiteralParseResult, %ObjectLiteralParseResult* %l1
  %t14 = extractvalue %ObjectLiteralParseResult %t13, 0
  %t15 = insertvalue %ExpressionParseResult undef, i8* %t14, 0
  %t16 = insertvalue %ExpressionParseResult %t15, i8* null, 1
  %t17 = insertvalue %ExpressionParseResult %t16, i1 1, 2
  ret %ExpressionParseResult %t17
}

define %ExpressionParseResult @expression_parse_failure(%ExpressionTokens %state) {
entry:
  %t0 = insertvalue %ExpressionParseResult undef, i8* null, 0
  %t1 = insertvalue %ExpressionParseResult %t0, i8* null, 1
  %t2 = insertvalue %ExpressionParseResult %t1, i1 0, 2
  ret %ExpressionParseResult %t2
}

define i1 @expression_tokens_is_at_end(%ExpressionTokens %state) {
entry:
  %t0 = extractvalue %ExpressionTokens %state, 1
  %t1 = extractvalue %ExpressionTokens %state, 0
  %t2 = load { i8**, i64 }, { i8**, i64 }* %t1
  %t3 = extractvalue { i8**, i64 } %t2, 1
  %t4 = sitofp i64 %t3 to double
  %t5 = fcmp oge double %t0, %t4
  ret i1 %t5
}

define %ExpressionTokens @expression_tokens_advance(%ExpressionTokens %state) {
entry:
  %t0 = extractvalue %ExpressionTokens %state, 1
  %t1 = extractvalue %ExpressionTokens %state, 0
  %t2 = load { i8**, i64 }, { i8**, i64 }* %t1
  %t3 = extractvalue { i8**, i64 } %t2, 1
  %t4 = sitofp i64 %t3 to double
  %t5 = fcmp oge double %t0, %t4
  br i1 %t5, label %then0, label %merge1
then0:
  ret %ExpressionTokens %state
merge1:
  ret %ExpressionTokens zeroinitializer
}

define i1 @expression_is_struct_target(i8* %expression) {
entry:
  ret i1 0
}

define %StructTypeNameResult @collect_struct_type_name(i8* %expression) {
entry:
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  %t5 = insertvalue %StructTypeNameResult undef, { i8**, i64 }* null, 0
  %t6 = insertvalue %StructTypeNameResult %t5, i1 0, 1
  ret %StructTypeNameResult %t6
}

define double @binary_precedence(i8* %op) {
entry:
  %s0 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.0, i32 0, i32 0
  %t1 = icmp eq i8* %op, %s0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = sitofp i64 0 to double
  ret double %t2
merge1:
  %t12 = sitofp i64 -1 to double
  ret double %t12
}

define double @unary_precedence() {
entry:
  %t0 = sitofp i64 7 to double
  ret double %t0
}

define { i8**, i64 }* @filter_trivia({ i8**, i64 }* %tokens) {
entry:
  %l0 = alloca double
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca i8*
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = alloca [0 x double]
  %t2 = getelementptr [0 x double], [0 x double]* %t1, i32 0, i32 0
  %t3 = alloca { double*, i64 }
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 0
  store double* %t2, double** %t4
  %t5 = getelementptr { double*, i64 }, { double*, i64 }* %t3, i32 0, i32 1
  store i64 0, i64* %t5
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t6 = load double, double* %l0
  %t7 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %loop.header0
loop.header0:
  %t29 = phi double [ %t6, %entry ], [ %t28, %loop.latch2 ]
  store double %t29, double* %l0
  br label %loop.body1
loop.body1:
  %t8 = load double, double* %l0
  %t9 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t10 = extractvalue { i8**, i64 } %t9, 1
  %t11 = sitofp i64 %t10 to double
  %t12 = fcmp oge double %t8, %t11
  %t13 = load double, double* %l0
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t12, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t15 = load double, double* %l0
  %t16 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t17 = extractvalue { i8**, i64 } %t16, 0
  %t18 = extractvalue { i8**, i64 } %t16, 1
  %t19 = icmp uge i64 %t15, %t18
  ; bounds check: %t19 (if true, out of bounds)
  %t20 = getelementptr i8*, i8** %t17, i64 %t15
  %t21 = load i8*, i8** %t20
  store i8* %t21, i8** %l2
  %t24 = load i8*, i8** %l2
  %t25 = load double, double* %l0
  %t26 = sitofp i64 1 to double
  %t27 = fadd double %t25, %t26
  store double %t27, double* %l0
  br label %loop.latch2
loop.latch2:
  %t28 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l1
  ret { i8**, i64 }* %t30
}

define i8* @tokens_to_text({ i8**, i64 }* %tokens) {
entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.0, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = load i8*, i8** %l0
  %t3 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t24 = phi i8* [ %t2, %entry ], [ %t22, %loop.latch2 ]
  %t25 = phi double [ %t3, %entry ], [ %t23, %loop.latch2 ]
  store i8* %t24, i8** %l0
  store double %t25, double* %l1
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  %t5 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t6 = extractvalue { i8**, i64 } %t5, 1
  %t7 = sitofp i64 %t6 to double
  %t8 = fcmp oge double %t4, %t7
  %t9 = load i8*, i8** %l0
  %t10 = load double, double* %l1
  br i1 %t8, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t11 = load i8*, i8** %l0
  %t12 = load double, double* %l1
  %t13 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t14 = extractvalue { i8**, i64 } %t13, 0
  %t15 = extractvalue { i8**, i64 } %t13, 1
  %t16 = icmp uge i64 %t12, %t15
  ; bounds check: %t16 (if true, out of bounds)
  %t17 = getelementptr i8*, i8** %t14, i64 %t12
  %t18 = load i8*, i8** %t17
  %t19 = load double, double* %l1
  %t20 = sitofp i64 1 to double
  %t21 = fadd double %t19, %t20
  store double %t21, double* %l1
  br label %loop.latch2
loop.latch2:
  %t22 = load i8*, i8** %l0
  %t23 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t26 = load i8*, i8** %l0
  ret i8* %t26
}

define i8* @trim_text(i8* %value) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i8
  %l3 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  store double 0.0, double* %l1
  %t1 = load double, double* %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t20 = phi double [ %t1, %entry ], [ %t19, %loop.latch2 ]
  store double %t20, double* %l0
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l0
  %t4 = load double, double* %l1
  %t5 = fcmp oge double %t3, %t4
  %t6 = load double, double* %l0
  %t7 = load double, double* %l1
  br i1 %t5, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t8 = load double, double* %l0
  %t9 = getelementptr i8, i8* %value, i64 %t8
  %t10 = load i8, i8* %t9
  store i8 %t10, i8* %l2
  %t11 = load i8, i8* %l2
  %t12 = call i1 @is_trim_whitespace(i8* null)
  %t13 = load double, double* %l0
  %t14 = load double, double* %l1
  %t15 = load i8, i8* %l2
  br i1 %t12, label %then6, label %merge7
then6:
  %t16 = load double, double* %l0
  %t17 = sitofp i64 1 to double
  %t18 = fadd double %t16, %t17
  store double %t18, double* %l0
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  %t19 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t21 = load double, double* %l0
  %t22 = load double, double* %l1
  br label %loop.header8
loop.header8:
  %t37 = phi double [ %t22, %entry ], [ %t36, %loop.latch10 ]
  store double %t37, double* %l1
  br label %loop.body9
loop.body9:
  %t23 = load double, double* %l1
  %t24 = load double, double* %l0
  %t25 = fcmp ole double %t23, %t24
  %t26 = load double, double* %l0
  %t27 = load double, double* %l1
  br i1 %t25, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  store double 0.0, double* %l3
  %t28 = load double, double* %l3
  %t29 = call i1 @is_trim_whitespace(i8* null)
  %t30 = load double, double* %l0
  %t31 = load double, double* %l1
  %t32 = load double, double* %l3
  br i1 %t29, label %then14, label %merge15
then14:
  %t33 = load double, double* %l1
  %t34 = sitofp i64 1 to double
  %t35 = fsub double %t33, %t34
  store double %t35, double* %l1
  br label %loop.latch10
merge15:
  br label %afterloop11
loop.latch10:
  %t36 = load double, double* %l1
  br label %loop.header8
afterloop11:
  %t38 = load double, double* %l0
  %t39 = load double, double* %l1
  %t40 = call double @substring(i8* %value, double %t38, double %t39)
  ret i8* null
}

define i1 @is_trim_whitespace(i8* %ch) {
entry:
  %l0 = alloca double
  %t0 = call double @char_code(i8* %ch)
  store double %t0, double* %l0
  %t4 = load double, double* %l0
  %t5 = sitofp i64 32 to double
  %t6 = fcmp oeq double %t4, %t5
  br label %logical_or_entry_3

logical_or_entry_3:
  br i1 %t6, label %logical_or_merge_3, label %logical_or_right_3

logical_or_right_3:
  %t7 = load double, double* %l0
  %t8 = sitofp i64 10 to double
  %t9 = fcmp oeq double %t7, %t8
  br label %logical_or_right_end_3

logical_or_right_end_3:
  br label %logical_or_merge_3

logical_or_merge_3:
  %t10 = phi i1 [ true, %logical_or_entry_3 ], [ %t9, %logical_or_right_end_3 ]
  br label %logical_or_entry_2

logical_or_entry_2:
  br i1 %t10, label %logical_or_merge_2, label %logical_or_right_2

logical_or_right_2:
  %t11 = load double, double* %l0
  %t12 = sitofp i64 9 to double
  %t13 = fcmp oeq double %t11, %t12
  br label %logical_or_right_end_2

logical_or_right_end_2:
  br label %logical_or_merge_2

logical_or_merge_2:
  %t14 = phi i1 [ true, %logical_or_entry_2 ], [ %t13, %logical_or_right_end_2 ]
  br label %logical_or_entry_1

logical_or_entry_1:
  br i1 %t14, label %logical_or_merge_1, label %logical_or_right_1

logical_or_right_1:
  %t15 = load double, double* %l0
  %t16 = sitofp i64 13 to double
  %t17 = fcmp oeq double %t15, %t16
  br label %logical_or_right_end_1

logical_or_right_end_1:
  br label %logical_or_merge_1

logical_or_merge_1:
  %t18 = phi i1 [ true, %logical_or_entry_1 ], [ %t17, %logical_or_right_end_1 ]
  ret i1 %t18
}

define i1 @string_array_contains({ i8**, i64 }* %values, i8* %target) {
entry:
  %l0 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t21 = phi double [ %t1, %entry ], [ %t20, %loop.latch2 ]
  store double %t21, double* %l0
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  %t3 = load { i8**, i64 }, { i8**, i64 }* %values
  %t4 = extractvalue { i8**, i64 } %t3, 1
  %t5 = sitofp i64 %t4 to double
  %t6 = fcmp oge double %t2, %t5
  %t7 = load double, double* %l0
  br i1 %t6, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t8 = load double, double* %l0
  %t9 = load { i8**, i64 }, { i8**, i64 }* %values
  %t10 = extractvalue { i8**, i64 } %t9, 0
  %t11 = extractvalue { i8**, i64 } %t9, 1
  %t12 = icmp uge i64 %t8, %t11
  ; bounds check: %t12 (if true, out of bounds)
  %t13 = getelementptr i8*, i8** %t10, i64 %t8
  %t14 = load i8*, i8** %t13
  %t15 = icmp eq i8* %t14, %target
  %t16 = load double, double* %l0
  br i1 %t15, label %then6, label %merge7
then6:
  ret i1 1
merge7:
  %t17 = load double, double* %l0
  %t18 = sitofp i64 1 to double
  %t19 = fadd double %t17, %t18
  store double %t19, double* %l0
  br label %loop.latch2
loop.latch2:
  %t20 = load double, double* %l0
  br label %loop.header0
afterloop3:
  ret i1 0
}

define i1 @is_trivia_token(i8* %token) {
entry:
  ret i1 0
}

define i1 @is_whitespace_lexeme(i8* %text) {
entry:
  %l0 = alloca double
  %l1 = alloca i8
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t15 = phi double [ %t1, %entry ], [ %t14, %loop.latch2 ]
  store double %t15, double* %l0
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  %t3 = load double, double* %l0
  %t4 = getelementptr i8, i8* %text, i64 %t3
  %t5 = load i8, i8* %t4
  store i8 %t5, i8* %l1
  %t6 = load i8, i8* %l1
  %t7 = call i1 @is_trim_whitespace(i8* null)
  %t8 = xor i1 %t7, 1
  %t9 = load double, double* %l0
  %t10 = load i8, i8* %l1
  br i1 %t8, label %then4, label %merge5
then4:
  ret i1 0
merge5:
  %t11 = load double, double* %l0
  %t12 = sitofp i64 1 to double
  %t13 = fadd double %t11, %t12
  store double %t13, double* %l0
  br label %loop.latch2
loop.latch2:
  %t14 = load double, double* %l0
  br label %loop.header0
afterloop3:
  ret i1 1
}

define %Parser @advance_to_symbol(%Parser %parser, i8* %symbol) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca double
  %l2 = alloca %Parser
  store %Parser %parser, %Parser* %l0
  %t0 = load %Parser, %Parser* %l0
  br label %loop.header0
loop.header0:
  %t21 = phi %Parser [ %t0, %entry ], [ %t20, %loop.latch2 ]
  store %Parser %t21, %Parser* %l0
  br label %loop.body1
loop.body1:
  %t1 = load %Parser, %Parser* %l0
  %t2 = call %Parser @skip_trivia(%Parser %t1)
  store %Parser %t2, %Parser* %l0
  %t3 = load %Parser, %Parser* %l0
  %t4 = call double @parser_peek_raw(%Parser %t3)
  store double %t4, double* %l1
  %t6 = load double, double* %l1
  %t7 = load double, double* %l1
  %t8 = load %Parser, %Parser* %l0
  %t9 = call %Parser @parser_advance_raw(%Parser %t8)
  store %Parser %t9, %Parser* %l2
  %t10 = load %Parser, %Parser* %l2
  %t11 = extractvalue %Parser %t10, 1
  %t12 = load %Parser, %Parser* %l0
  %t13 = extractvalue %Parser %t12, 1
  %t14 = fcmp oeq double %t11, %t13
  %t15 = load %Parser, %Parser* %l0
  %t16 = load double, double* %l1
  %t17 = load %Parser, %Parser* %l2
  br i1 %t14, label %then4, label %merge5
then4:
  %t18 = load %Parser, %Parser* %l0
  ret %Parser %t18
merge5:
  %t19 = load %Parser, %Parser* %l2
  store %Parser %t19, %Parser* %l0
  br label %loop.latch2
loop.latch2:
  %t20 = load %Parser, %Parser* %l0
  br label %loop.header0
afterloop3:
  ret %Parser zeroinitializer
}

define %Parser @skip_struct_member(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca double
  store %Parser %parser, %Parser* %l0
  %t0 = load %Parser, %Parser* %l0
  br label %loop.header0
loop.header0:
  %t17 = phi %Parser [ %t0, %entry ], [ %t16, %loop.latch2 ]
  store %Parser %t17, %Parser* %l0
  br label %loop.body1
loop.body1:
  %t1 = load %Parser, %Parser* %l0
  %t2 = call %Parser @parser_advance_raw(%Parser %t1)
  store %Parser %t2, %Parser* %l1
  %t3 = load %Parser, %Parser* %l1
  %t4 = extractvalue %Parser %t3, 1
  %t5 = load %Parser, %Parser* %l0
  %t6 = extractvalue %Parser %t5, 1
  %t7 = fcmp oeq double %t4, %t6
  %t8 = load %Parser, %Parser* %l0
  %t9 = load %Parser, %Parser* %l1
  br i1 %t7, label %then4, label %merge5
then4:
  %t10 = load %Parser, %Parser* %l0
  ret %Parser %t10
merge5:
  %t11 = load %Parser, %Parser* %l1
  store %Parser %t11, %Parser* %l0
  %t12 = load %Parser, %Parser* %l0
  %t13 = call double @parser_peek_raw(%Parser %t12)
  store double %t13, double* %l2
  %t14 = load double, double* %l2
  %t15 = load double, double* %l2
  br label %loop.latch2
loop.latch2:
  %t16 = load %Parser, %Parser* %l0
  br label %loop.header0
afterloop3:
  ret %Parser zeroinitializer
}

define %Parser @skip_enum_variant_entry(%Parser %parser) {
entry:
  %l0 = alloca %Parser
  %l1 = alloca %Parser
  %l2 = alloca double
  store %Parser %parser, %Parser* %l0
  %t0 = load %Parser, %Parser* %l0
  br label %loop.header0
loop.header0:
  %t17 = phi %Parser [ %t0, %entry ], [ %t16, %loop.latch2 ]
  store %Parser %t17, %Parser* %l0
  br label %loop.body1
loop.body1:
  %t1 = load %Parser, %Parser* %l0
  %t2 = call %Parser @parser_advance_raw(%Parser %t1)
  store %Parser %t2, %Parser* %l1
  %t3 = load %Parser, %Parser* %l1
  %t4 = extractvalue %Parser %t3, 1
  %t5 = load %Parser, %Parser* %l0
  %t6 = extractvalue %Parser %t5, 1
  %t7 = fcmp oeq double %t4, %t6
  %t8 = load %Parser, %Parser* %l0
  %t9 = load %Parser, %Parser* %l1
  br i1 %t7, label %then4, label %merge5
then4:
  %t10 = load %Parser, %Parser* %l0
  ret %Parser %t10
merge5:
  %t11 = load %Parser, %Parser* %l1
  store %Parser %t11, %Parser* %l0
  %t12 = load %Parser, %Parser* %l0
  %t13 = call double @parser_peek_raw(%Parser %t12)
  store double %t13, double* %l2
  %t14 = load double, double* %l2
  %t15 = load double, double* %l2
  br label %loop.latch2
loop.latch2:
  %t16 = load %Parser, %Parser* %l0
  br label %loop.header0
afterloop3:
  ret %Parser zeroinitializer
}

define i8* @strip_surrounding_quotes(i8* %text) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %t0 = getelementptr i8, i8* %text, i64 0
  %t1 = load i8, i8* %t0
  %t2 = call double @char_code(i8 %t1)
  store double %t2, double* %l0
  store double 0.0, double* %l1
  %t4 = load double, double* %l0
  %t5 = sitofp i64 34 to double
  %t6 = fcmp oeq double %t4, %t5
  br label %logical_and_entry_3

logical_and_entry_3:
  br i1 %t6, label %logical_and_right_3, label %logical_and_merge_3

logical_and_right_3:
  %t7 = load double, double* %l1
  %t8 = sitofp i64 34 to double
  %t9 = fcmp oeq double %t7, %t8
  br label %logical_and_right_end_3

logical_and_right_end_3:
  br label %logical_and_merge_3

logical_and_merge_3:
  %t10 = phi i1 [ false, %logical_and_entry_3 ], [ %t9, %logical_and_right_end_3 ]
  %t11 = load double, double* %l0
  %t12 = load double, double* %l1
  br i1 %t10, label %then0, label %merge1
then0:
  ret i8* null
merge1:
  ret i8* %text
}

define i8* @normalize_test_name(i8* %text) {
entry:
  %l0 = alloca i8*
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = load i8*, i8** %l0
  ret i8* %t2
}

define { i8**, i64 }* @split_tokens_by_comma({ i8**, i64 }* %tokens) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca i8*
  %l8 = alloca i8*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %s5 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.5, i32 0, i32 0
  store i8* %s5, i8** %l1
  %t6 = sitofp i64 0 to double
  store double %t6, double* %l2
  %t7 = sitofp i64 0 to double
  store double %t7, double* %l3
  %t8 = sitofp i64 0 to double
  store double %t8, double* %l4
  %t9 = sitofp i64 0 to double
  store double %t9, double* %l5
  %t10 = sitofp i64 0 to double
  store double %t10, double* %l6
  %t11 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t12 = load i8*, i8** %l1
  %t13 = load double, double* %l2
  %t14 = load double, double* %l3
  %t15 = load double, double* %l4
  %t16 = load double, double* %l5
  %t17 = load double, double* %l6
  br label %loop.header0
loop.header0:
  %t45 = phi i8* [ %t12, %entry ], [ %t43, %loop.latch2 ]
  %t46 = phi double [ %t17, %entry ], [ %t44, %loop.latch2 ]
  store i8* %t45, i8** %l1
  store double %t46, double* %l6
  br label %loop.body1
loop.body1:
  %t18 = load double, double* %l6
  %t19 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t20 = extractvalue { i8**, i64 } %t19, 1
  %t21 = sitofp i64 %t20 to double
  %t22 = fcmp oge double %t18, %t21
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t24 = load i8*, i8** %l1
  %t25 = load double, double* %l2
  %t26 = load double, double* %l3
  %t27 = load double, double* %l4
  %t28 = load double, double* %l5
  %t29 = load double, double* %l6
  br i1 %t22, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t30 = load double, double* %l6
  %t31 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t32 = extractvalue { i8**, i64 } %t31, 0
  %t33 = extractvalue { i8**, i64 } %t31, 1
  %t34 = icmp uge i64 %t30, %t33
  ; bounds check: %t34 (if true, out of bounds)
  %t35 = getelementptr i8*, i8** %t32, i64 %t30
  %t36 = load i8*, i8** %t35
  store i8* %t36, i8** %l7
  %t37 = load i8*, i8** %l7
  %t38 = load i8*, i8** %l1
  %t39 = load i8*, i8** %l7
  %t40 = load double, double* %l6
  %t41 = sitofp i64 1 to double
  %t42 = fadd double %t40, %t41
  store double %t42, double* %l6
  br label %loop.latch2
loop.latch2:
  %t43 = load i8*, i8** %l1
  %t44 = load double, double* %l6
  br label %loop.header0
afterloop3:
  %t47 = load i8*, i8** %l1
  %t48 = call i8* @trim_text(i8* %t47)
  store i8* %t48, i8** %l8
  %t49 = load i8*, i8** %l8
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t50
}

define { i8**, i64 }* @split_token_slices_by_comma({ i8**, i64 }* %tokens) {
entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca i8*
  %t0 = alloca [0 x double]
  %t1 = getelementptr [0 x double], [0 x double]* %t0, i32 0, i32 0
  %t2 = alloca { double*, i64 }
  %t3 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 0
  store double* %t1, double** %t3
  %t4 = getelementptr { double*, i64 }, { double*, i64 }* %t2, i32 0, i32 1
  store i64 0, i64* %t4
  store { i8**, i64 }* null, { i8**, i64 }** %l0
  %t5 = alloca [0 x double]
  %t6 = getelementptr [0 x double], [0 x double]* %t5, i32 0, i32 0
  %t7 = alloca { double*, i64 }
  %t8 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 0
  store double* %t6, double** %t8
  %t9 = getelementptr { double*, i64 }, { double*, i64 }* %t7, i32 0, i32 1
  store i64 0, i64* %t9
  store { i8**, i64 }* null, { i8**, i64 }** %l1
  %t10 = sitofp i64 0 to double
  store double %t10, double* %l2
  %t11 = sitofp i64 0 to double
  store double %t11, double* %l3
  %t12 = sitofp i64 0 to double
  store double %t12, double* %l4
  %t13 = sitofp i64 0 to double
  store double %t13, double* %l5
  %t14 = sitofp i64 0 to double
  store double %t14, double* %l6
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t17 = load double, double* %l2
  %t18 = load double, double* %l3
  %t19 = load double, double* %l4
  %t20 = load double, double* %l5
  %t21 = load double, double* %l6
  br label %loop.header0
loop.header0:
  %t50 = phi { i8**, i64 }* [ %t16, %entry ], [ %t48, %loop.latch2 ]
  %t51 = phi double [ %t21, %entry ], [ %t49, %loop.latch2 ]
  store { i8**, i64 }* %t50, { i8**, i64 }** %l1
  store double %t51, double* %l6
  br label %loop.body1
loop.body1:
  %t22 = load double, double* %l6
  %t23 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t24 = extractvalue { i8**, i64 } %t23, 1
  %t25 = sitofp i64 %t24 to double
  %t26 = fcmp oge double %t22, %t25
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t29 = load double, double* %l2
  %t30 = load double, double* %l3
  %t31 = load double, double* %l4
  %t32 = load double, double* %l5
  %t33 = load double, double* %l6
  br i1 %t26, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t34 = load double, double* %l6
  %t35 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t36 = extractvalue { i8**, i64 } %t35, 0
  %t37 = extractvalue { i8**, i64 } %t35, 1
  %t38 = icmp uge i64 %t34, %t37
  ; bounds check: %t38 (if true, out of bounds)
  %t39 = getelementptr i8*, i8** %t36, i64 %t34
  %t40 = load i8*, i8** %t39
  store i8* %t40, i8** %l7
  %t41 = load i8*, i8** %l7
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t43 = load i8*, i8** %l7
  %t44 = call { i8**, i64 }* @append_token({ i8**, i64 }* %t42, i8* %t43)
  store { i8**, i64 }* %t44, { i8**, i64 }** %l1
  %t45 = load double, double* %l6
  %t46 = sitofp i64 1 to double
  %t47 = fadd double %t45, %t46
  store double %t47, double* %l6
  br label %loop.latch2
loop.latch2:
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t49 = load double, double* %l6
  br label %loop.header0
afterloop3:
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t53 = load { i8**, i64 }, { i8**, i64 }* %t52
  %t54 = extractvalue { i8**, i64 } %t53, 1
  %t55 = icmp sgt i64 %t54, 0
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t58 = load double, double* %l2
  %t59 = load double, double* %l3
  %t60 = load double, double* %l4
  %t61 = load double, double* %l5
  %t62 = load double, double* %l6
  br i1 %t55, label %then6, label %merge7
then6:
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t65 = call { i8**, i64 }* @append_token_array({ i8**, i64 }* %t63, { i8**, i64 }* %t64)
  store { i8**, i64 }* %t65, { i8**, i64 }** %l0
  br label %merge7
merge7:
  %t66 = phi { i8**, i64 }* [ %t65, %then6 ], [ %t56, %entry ]
  store { i8**, i64 }* %t66, { i8**, i64 }** %l0
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t67
}

define double @find_top_level_symbol({ i8**, i64 }* %tokens, i8* %symbol) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca i8*
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = sitofp i64 0 to double
  store double %t2, double* %l2
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l3
  %t4 = sitofp i64 0 to double
  store double %t4, double* %l4
  %t5 = load double, double* %l0
  %t6 = load double, double* %l1
  %t7 = load double, double* %l2
  %t8 = load double, double* %l3
  %t9 = load double, double* %l4
  br label %loop.header0
loop.header0:
  %t32 = phi double [ %t9, %entry ], [ %t31, %loop.latch2 ]
  store double %t32, double* %l4
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l4
  %t11 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t12 = extractvalue { i8**, i64 } %t11, 1
  %t13 = sitofp i64 %t12 to double
  %t14 = fcmp oge double %t10, %t13
  %t15 = load double, double* %l0
  %t16 = load double, double* %l1
  %t17 = load double, double* %l2
  %t18 = load double, double* %l3
  %t19 = load double, double* %l4
  br i1 %t14, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t20 = load double, double* %l4
  %t21 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t22 = extractvalue { i8**, i64 } %t21, 0
  %t23 = extractvalue { i8**, i64 } %t21, 1
  %t24 = icmp uge i64 %t20, %t23
  ; bounds check: %t24 (if true, out of bounds)
  %t25 = getelementptr i8*, i8** %t22, i64 %t20
  %t26 = load i8*, i8** %t25
  store i8* %t26, i8** %l5
  %t27 = load i8*, i8** %l5
  %t28 = load double, double* %l4
  %t29 = sitofp i64 1 to double
  %t30 = fadd double %t28, %t29
  store double %t30, double* %l4
  br label %loop.latch2
loop.latch2:
  %t31 = load double, double* %l4
  br label %loop.header0
afterloop3:
  %t33 = sitofp i64 -1 to double
  ret double %t33
}

define double @find_top_level_identifier({ i8**, i64 }* %tokens, i8* %keyword) {
entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca i8*
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = sitofp i64 0 to double
  store double %t2, double* %l2
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l3
  %t4 = sitofp i64 0 to double
  store double %t4, double* %l4
  %t5 = load double, double* %l0
  %t6 = load double, double* %l1
  %t7 = load double, double* %l2
  %t8 = load double, double* %l3
  %t9 = load double, double* %l4
  br label %loop.header0
loop.header0:
  %t33 = phi double [ %t9, %entry ], [ %t32, %loop.latch2 ]
  store double %t33, double* %l4
  br label %loop.body1
loop.body1:
  %t10 = load double, double* %l4
  %t11 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t12 = extractvalue { i8**, i64 } %t11, 1
  %t13 = sitofp i64 %t12 to double
  %t14 = fcmp oge double %t10, %t13
  %t15 = load double, double* %l0
  %t16 = load double, double* %l1
  %t17 = load double, double* %l2
  %t18 = load double, double* %l3
  %t19 = load double, double* %l4
  br i1 %t14, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t20 = load double, double* %l4
  %t21 = load { i8**, i64 }, { i8**, i64 }* %tokens
  %t22 = extractvalue { i8**, i64 } %t21, 0
  %t23 = extractvalue { i8**, i64 } %t21, 1
  %t24 = icmp uge i64 %t20, %t23
  ; bounds check: %t24 (if true, out of bounds)
  %t25 = getelementptr i8*, i8** %t22, i64 %t20
  %t26 = load i8*, i8** %t25
  store i8* %t26, i8** %l5
  %t27 = load i8*, i8** %l5
  %t28 = load i8*, i8** %l5
  %t29 = load double, double* %l4
  %t30 = sitofp i64 1 to double
  %t31 = fadd double %t29, %t30
  store double %t31, double* %l4
  br label %loop.latch2
loop.latch2:
  %t32 = load double, double* %l4
  br label %loop.header0
afterloop3:
  %t34 = sitofp i64 -1 to double
  ret double %t34
}

define { i8**, i64 }* @append_statement({ i8**, i64 }* %statements, i8* %statement) {
entry:
  %t0 = alloca [1 x i8*]
  %t1 = getelementptr [1 x i8*], [1 x i8*]* %t0, i32 0, i32 0
  %t2 = getelementptr i8*, i8** %t1, i64 0
  store i8* %statement, i8** %t2
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t1, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @statementsconcat({ i8**, i64 }* %t3)
  ret { i8**, i64 }* null
}

define { i8**, i64 }* @append_string({ i8**, i64 }* %values, i8* %value) {
entry:
  %t0 = alloca [1 x i8*]
  %t1 = getelementptr [1 x i8*], [1 x i8*]* %t0, i32 0, i32 0
  %t2 = getelementptr i8*, i8** %t1, i64 0
  store i8* %value, i8** %t2
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t1, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @valuesconcat({ i8**, i64 }* %t3)
  ret { i8**, i64 }* null
}

define { i8**, i64 }* @append_parameter({ i8**, i64 }* %parameters, i8* %parameter) {
entry:
  %t0 = alloca [1 x i8*]
  %t1 = getelementptr [1 x i8*], [1 x i8*]* %t0, i32 0, i32 0
  %t2 = getelementptr i8*, i8** %t1, i64 0
  store i8* %parameter, i8** %t2
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t1, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @parametersconcat({ i8**, i64 }* %t3)
  ret { i8**, i64 }* null
}

define { i8**, i64 }* @append_model_property({ i8**, i64 }* %properties, i8* %property) {
entry:
  %t0 = alloca [1 x i8*]
  %t1 = getelementptr [1 x i8*], [1 x i8*]* %t0, i32 0, i32 0
  %t2 = getelementptr i8*, i8** %t1, i64 0
  store i8* %property, i8** %t2
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t1, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @propertiesconcat({ i8**, i64 }* %t3)
  ret { i8**, i64 }* null
}

define { i8**, i64 }* @append_field({ i8**, i64 }* %fields, i8* %field) {
entry:
  %t0 = alloca [1 x i8*]
  %t1 = getelementptr [1 x i8*], [1 x i8*]* %t0, i32 0, i32 0
  %t2 = getelementptr i8*, i8** %t1, i64 0
  store i8* %field, i8** %t2
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t1, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @fieldsconcat({ i8**, i64 }* %t3)
  ret { i8**, i64 }* null
}

define { i8**, i64 }* @append_method({ i8**, i64 }* %methods, i8* %method) {
entry:
  %t0 = alloca [1 x i8*]
  %t1 = getelementptr [1 x i8*], [1 x i8*]* %t0, i32 0, i32 0
  %t2 = getelementptr i8*, i8** %t1, i64 0
  store i8* %method, i8** %t2
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t1, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @methodsconcat({ i8**, i64 }* %t3)
  ret { i8**, i64 }* null
}

define { i8**, i64 }* @append_signature({ i8**, i64 }* %signatures, i8* %signature) {
entry:
  %t0 = alloca [1 x i8*]
  %t1 = getelementptr [1 x i8*], [1 x i8*]* %t0, i32 0, i32 0
  %t2 = getelementptr i8*, i8** %t1, i64 0
  store i8* %signature, i8** %t2
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t1, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @signaturesconcat({ i8**, i64 }* %t3)
  ret { i8**, i64 }* null
}

define { i8**, i64 }* @append_enum_variant({ i8**, i64 }* %variants, i8* %variant) {
entry:
  %t0 = alloca [1 x i8*]
  %t1 = getelementptr [1 x i8*], [1 x i8*]* %t0, i32 0, i32 0
  %t2 = getelementptr i8*, i8** %t1, i64 0
  store i8* %variant, i8** %t2
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t1, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @variantsconcat({ i8**, i64 }* %t3)
  ret { i8**, i64 }* null
}

define { i8**, i64 }* @append_type_annotation({ i8**, i64 }* %types, i8* %item) {
entry:
  %t0 = alloca [1 x i8*]
  %t1 = getelementptr [1 x i8*], [1 x i8*]* %t0, i32 0, i32 0
  %t2 = getelementptr i8*, i8** %t1, i64 0
  store i8* %item, i8** %t2
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t1, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @typesconcat({ i8**, i64 }* %t3)
  ret { i8**, i64 }* null
}

define { i8**, i64 }* @append_type_parameter({ i8**, i64 }* %parameters, i8* %parameter) {
entry:
  %t0 = alloca [1 x i8*]
  %t1 = getelementptr [1 x i8*], [1 x i8*]* %t0, i32 0, i32 0
  %t2 = getelementptr i8*, i8** %t1, i64 0
  store i8* %parameter, i8** %t2
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t1, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @parametersconcat({ i8**, i64 }* %t3)
  ret { i8**, i64 }* null
}

define { i8**, i64 }* @append_decorator({ i8**, i64 }* %decorators, i8* %decorator) {
entry:
  %t0 = alloca [1 x i8*]
  %t1 = getelementptr [1 x i8*], [1 x i8*]* %t0, i32 0, i32 0
  %t2 = getelementptr i8*, i8** %t1, i64 0
  store i8* %decorator, i8** %t2
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t1, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @decoratorsconcat({ i8**, i64 }* %t3)
  ret { i8**, i64 }* null
}

define { i8**, i64 }* @append_decorator_argument({ i8**, i64 }* %arguments, i8* %argument) {
entry:
  %t0 = alloca [1 x i8*]
  %t1 = getelementptr [1 x i8*], [1 x i8*]* %t0, i32 0, i32 0
  %t2 = getelementptr i8*, i8** %t1, i64 0
  store i8* %argument, i8** %t2
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t1, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @argumentsconcat({ i8**, i64 }* %t3)
  ret { i8**, i64 }* null
}

define { i8**, i64 }* @append_with_clause({ i8**, i64 }* %clauses, i8* %clause) {
entry:
  %t0 = alloca [1 x i8*]
  %t1 = getelementptr [1 x i8*], [1 x i8*]* %t0, i32 0, i32 0
  %t2 = getelementptr i8*, i8** %t1, i64 0
  store i8* %clause, i8** %t2
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t1, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @clausesconcat({ i8**, i64 }* %t3)
  ret { i8**, i64 }* null
}

define { i8**, i64 }* @append_match_case({ i8**, i64 }* %cases, i8* %case) {
entry:
  %t0 = alloca [1 x i8*]
  %t1 = getelementptr [1 x i8*], [1 x i8*]* %t0, i32 0, i32 0
  %t2 = getelementptr i8*, i8** %t1, i64 0
  store i8* %case, i8** %t2
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t1, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @casesconcat({ i8**, i64 }* %t3)
  ret { i8**, i64 }* null
}

define { i8**, i64 }* @append_expression({ i8**, i64 }* %expressions, i8* %expression) {
entry:
  %t0 = alloca [1 x i8*]
  %t1 = getelementptr [1 x i8*], [1 x i8*]* %t0, i32 0, i32 0
  %t2 = getelementptr i8*, i8** %t1, i64 0
  store i8* %expression, i8** %t2
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t1, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @expressionsconcat({ i8**, i64 }* %t3)
  ret { i8**, i64 }* null
}

define { i8**, i64 }* @append_object_field({ i8**, i64 }* %fields, i8* %field) {
entry:
  %t0 = alloca [1 x i8*]
  %t1 = getelementptr [1 x i8*], [1 x i8*]* %t0, i32 0, i32 0
  %t2 = getelementptr i8*, i8** %t1, i64 0
  store i8* %field, i8** %t2
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t1, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @fieldsconcat({ i8**, i64 }* %t3)
  ret { i8**, i64 }* null
}

define { i8**, i64 }* @append_token({ i8**, i64 }* %tokens, i8* %token) {
entry:
  %t0 = alloca [1 x i8*]
  %t1 = getelementptr [1 x i8*], [1 x i8*]* %t0, i32 0, i32 0
  %t2 = getelementptr i8*, i8** %t1, i64 0
  store i8* %token, i8** %t2
  %t3 = alloca { i8**, i64 }
  %t4 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 0
  store i8** %t1, i8*** %t4
  %t5 = getelementptr { i8**, i64 }, { i8**, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @tokensconcat({ i8**, i64 }* %t3)
  ret { i8**, i64 }* null
}

define { i8**, i64 }* @append_token_array({ i8**, i64 }* %collection, { i8**, i64 }* %tokens) {
entry:
  %t0 = alloca [1 x { i8**, i64 }*]
  %t1 = getelementptr [1 x { i8**, i64 }*], [1 x { i8**, i64 }*]* %t0, i32 0, i32 0
  %t2 = getelementptr { i8**, i64 }*, { i8**, i64 }** %t1, i64 0
  store { i8**, i64 }* %tokens, { i8**, i64 }** %t2
  %t3 = alloca { { i8**, i64 }**, i64 }
  %t4 = getelementptr { { i8**, i64 }**, i64 }, { { i8**, i64 }**, i64 }* %t3, i32 0, i32 0
  store { i8**, i64 }** %t1, { i8**, i64 }*** %t4
  %t5 = getelementptr { { i8**, i64 }**, i64 }, { { i8**, i64 }**, i64 }* %t3, i32 0, i32 1
  store i64 1, i64* %t5
  %t6 = call double @collectionconcat({ { i8**, i64 }**, i64 }* %t3)
  ret { i8**, i64 }* null
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
