define %Program @parse_program(i8* %source) {
block.entry:
  call void @stage2_debug_marker(i64 12001)
  %l0 = alloca { %Token*, i64 }*
  %t0 = call { %Token*, i64 }* @lex(i8* %source)
  store { %Token*, i64 }* %t0, { %Token*, i64 }** %l0
  %t1 = load { %Token*, i64 }*, { %Token*, i64 }** %l0
  call void @stage2_debug_marker(i64 12005)
  %t2 = call %Program @parse_tokens({ %Token*, i64 }* %t1)
  ret %Program %t2
}