from __future__ import annotations

# Module Lexer loaded from ../../lexer.sfn
# Import module Lexer from ../../lexer.sfn
_module_globals_before_Lexer = set(globals().keys())
_module_code_Lexer = '''
from __future__ import annotations
from dataclasses import dataclass
from typing import List

@dataclass
class Token:
    type: str
    value: str
    lineno: float

class Reserved:
    Fn = "Fn"
    Struct = "Struct"
    Interface = "Interface"
    Let = "Let"
    Mut = "Mut"
    If = "If"
    Else = "Else"
    While = "While"
    For = "For"
    Return = "Return"
    Print = "Print"
    Implements = "Implements"
    Import = "Import"
    Export = "Export"
    Module = "Module"

def lookupReserved(word: str) -> str:
    if (word == "fn"):
        return Reserved.Fn
    else:
        if (word == "struct"):
            return Reserved.Struct
        else:
            if (word == "interface"):
                return Reserved.Interface
            else:
                if (word == "let"):
                    return Reserved.Let
                else:
                    if (word == "mut"):
                        return Reserved.Mut
                    else:
                        if (word == "if"):
                            return Reserved.If
                        else:
                            if (word == "else"):
                                return Reserved.Else
                            else:
                                if (word == "while"):
                                    return Reserved.While
                                else:
                                    if (word == "for"):
                                        return Reserved.For
                                    else:
                                        if (word == "return"):
                                            return Reserved.Return
                                        else:
                                            if (word == "print"):
                                                return Reserved.Print
                                            else:
                                                if (word == "implements"):
                                                    return Reserved.Implements
                                                else:
                                                    if (word == "import"):
                                                        return Reserved.Import
                                                    else:
                                                        if (word == "export"):
                                                            return Reserved.Export
                                                        else:
                                                            if (word == "module"):
                                                                return Reserved.Module
                                                            else:
                                                                return "IDENTIFIER"

def lex(source: str) -> List[Token]:
    tokens: List[Token] = []
    pos: float = 0
    lineno: float = 1
    def isDigit(c: str) -> bool:
        return ((c >= "0") and (c <= "9"))

    def isLetter(c: str) -> bool:
        return (((c >= "a") and (c <= "z")) or ((c >= "A") and (c <= "Z")))

    def isWhitespace(c: str) -> bool:
        return (((c == " ") or (c == "\t")) or (c == "\r"))

    while (pos < len(source)):
        c: str = source[pos]
        if (c == "\n"):
            lineno = (lineno + 1)
            None
            pos = (pos + 1)
            None
            continue
        if isWhitespace(c):
            pos = (pos + 1)
            None
            continue
        if isDigit(c):
            start: float = pos
            while ((pos < len(source)) and isDigit(source[pos])):
                pos = (pos + 1)
                None
            if ((pos < len(source)) and (source[pos] == ".")):
                pos = (pos + 1)
                None
                while ((pos < len(source)) and isDigit(source[pos])):
                    pos = (pos + 1)
                    None
            numberText: str = source[start:pos]
            tokens.append(Token(type="NUMBER", value=numberText, lineno=lineno))
            continue
        if (isLetter(c) or (c == "_")):
            start: float = pos
            while ((pos < len(source)) and ((isLetter(source[pos]) or isDigit(source[pos])) or (source[pos] == "_"))):
                pos = (pos + 1)
                None
            idText: str = source[start:pos]
            tokenType: str = lookupReserved(idText)
            tokens.append(Token(type=tokenType, value=idText, lineno=lineno))
            continue
        if (c == "\""):
            pos = (pos + 1)
            None
            start: float = pos
            while ((pos < len(source)) and (source[pos] != "\"")):
                pos = (pos + 1)
                None
            if (pos >= len(source)):
                raise RuntimeError(f"Unterminated string literal at line {lineno}")
            strText: str = source[start:pos]
            pos = (pos + 1)
            None
            tokens.append(Token(type="STRING", value=strText, lineno=lineno))
            continue
        if (((((c == "/") and pos) + 1) < len(source)) and (source[(pos + 1)] == "/")):
            pos = (pos + 2)
            None
            while ((pos < len(source)) and (source[pos] != "\n")):
                pos = (pos + 1)
                None
            continue
        if (((((c == "/") and pos) + 1) < len(source)) and (source[(pos + 1)] == "*")):
            pos = (pos + 2)
            None
            while (((pos + 1) < len(source)) and not(((source[pos] == "*") and (source[(pos + 1)] == "/")))):
                if (source[pos] == "\n"):
                    lineno = (lineno + 1)
                    None
                pos = (pos + 1)
                None
            pos = (pos + 2)
            None
            continue
        if (c == "+"):
            if (((pos + 1) < len(source)) and (source[(pos + 1)] == "=")):
                tokens.append(Token(type="PLUS_ASSIGN", value="+=", lineno=lineno))
                pos = (pos + 2)
                None
            else:
                tokens.append(Token(type="PLUS", value="+", lineno=lineno))
                pos = (pos + 1)
                None
            continue
        if (c == "-"):
            if (((pos + 1) < len(source)) and (source[(pos + 1)] == "=")):
                tokens.append(Token(type="MINUS_ASSIGN", value="-=", lineno=lineno))
                pos = (pos + 2)
                None
                continue
            if (((pos + 1) < len(source)) and (source[(pos + 1)] == ">")):
                tokens.append(Token(type="ARROW", value="->", lineno=lineno))
                pos = (pos + 2)
                None
                continue
            tokens.append(Token(type="MINUS", value="-", lineno=lineno))
            pos = (pos + 1)
            None
            continue
        if (c == "*"):
            if (((pos + 1) < len(source)) and (source[(pos + 1)] == "=")):
                tokens.append(Token("MULTIPLY_ASSIGN", "*=", lineno))
                pos = (pos + 2)
                None
            else:
                tokens.append(Token("MULTIPLY", "*", lineno))
                pos = (pos + 1)
                None
            continue
        if (c == "/"):
            if (((pos + 1) < len(source)) and (source[(pos + 1)] == "=")):
                tokens.append(Token("DIVIDE_ASSIGN", "/=", lineno))
                pos = (pos + 2)
                None
            else:
                tokens.append(Token("DIVIDE", "/", lineno))
                pos = (pos + 1)
                None
            continue
        if (c == "="):
            if (((pos + 1) < len(source)) and (source[(pos + 1)] == "=")):
                tokens.append(Token("EQ", "==", lineno))
                pos = (pos + 2)
                None
            else:
                if (((pos + 1) < len(source)) and (source[(pos + 1)] == ">")):
                    tokens.append(Token("FAT_ARROW", "=>", lineno))
                    pos = (pos + 2)
                    None
                else:
                    tokens.append(Token("ASSIGN", "=", lineno))
                    pos = (pos + 1)
                    None
            continue
        if (c == "!"):
            if (((pos + 1) < len(source)) and (source[(pos + 1)] == "=")):
                tokens.append(Token("NEQ", "!=", lineno))
                pos = (pos + 2)
                None
            else:
                tokens.append(Token("NOT", "!", lineno))
                pos = (pos + 1)
                None
            continue
        if (c == "<"):
            if (((pos + 1) < len(source)) and (source[(pos + 1)] == "=")):
                tokens.append(Token("LEQ", "<=", lineno))
                pos = (pos + 2)
                None
            else:
                tokens.append(Token("LT", "<", lineno))
                pos = (pos + 1)
                None
            continue
        if (c == ">"):
            if (((pos + 1) < len(source)) and (source[(pos + 1)] == "=")):
                tokens.append(Token("GEQ", ">=", lineno))
                pos = (pos + 2)
                None
            else:
                tokens.append(Token("GT", ">", lineno))
                pos = (pos + 1)
                None
            continue
        if (c == "("):
            tokens.append(Token("LPAREN", "(", lineno))
            pos = (pos + 1)
            None
            continue
        if (c == ")"):
            tokens.append(Token("RPAREN", ")", lineno))
            pos = (pos + 1)
            None
            continue
        if (c == "{"):
            tokens.append(Token("LBRACE", "{", lineno))
            pos = (pos + 1)
            None
            continue
        if (c == "}"):
            tokens.append(Token("RBRACE", "}", lineno))
            pos = (pos + 1)
            None
            continue
        if (c == "["):
            tokens.append(Token("LBRACKET", "[", lineno))
            pos = (pos + 1)
            None
            continue
        if (c == "]"):
            tokens.append(Token("RBRACKET", "]", lineno))
            pos = (pos + 1)
            None
            continue
        if (c == ";"):
            tokens.append(Token("SEMICOLON", ";", lineno))
            pos = (pos + 1)
            None
            continue
        if (c == ","):
            tokens.append(Token("COMMA", ",", lineno))
            pos = (pos + 1)
            None
            continue
        if (c == "."):
            tokens.append(Token("DOT", ".", lineno))
            pos = (pos + 1)
            None
            continue
        if (c == ":"):
            tokens.append(Token("COLON", ":", lineno))
            pos = (pos + 1)
            None
            continue
        if (c == "@"):
            tokens.append(Token("AT", "@", lineno))
            pos = (pos + 1)
            None
            continue
        raise RuntimeError(f"Illegal character \"{c}\" at line {lineno}")
    return tokens

'''
exec(compile(_module_code_Lexer, '<module_Lexer>', 'exec'), globals())
_module_globals_after_Lexer = set(globals().keys())
_module_exports_Lexer = {k: globals()[k] for k in _module_globals_after_Lexer - _module_globals_before_Lexer if not k.startswith('_')}
class Lexer:
    pass
for _k, _v in _module_exports_Lexer.items():
    setattr(Lexer, _k, _v)
del _module_code_Lexer  # Clean up the embedded code
def main() -> None:
    print("Testing import...")
    print("Import test complete")


if __name__ == "__main__":
    main()