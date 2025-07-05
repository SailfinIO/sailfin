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
            tokens.append(Token("NUMBER", numberText, lineno))
            continue
        if (isLetter(c) or (c == "_")):
            start: float = pos
            while ((pos < len(source)) and ((isLetter(source[pos]) or isDigit(source[pos])) or (source[pos] == "_"))):
                pos = (pos + 1)
                None
            idText: str = source[start:pos]
            tokenType: str = lookupReserved(idText)
            tokens.append(Token(tokenType, idText, lineno))
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
            tokens.append(Token("STRING", strText, lineno))
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
                tokens.append(Token("PLUS_ASSIGN", "+=", lineno))
                pos = (pos + 2)
                None
            else:
                tokens.append(Token("PLUS", "+", lineno))
                pos = (pos + 1)
                None
            continue
        if (c == "-"):
            if (((pos + 1) < len(source)) and (source[(pos + 1)] == "=")):
                tokens.append(Token("MINUS_ASSIGN", "-=", lineno))
                pos = (pos + 2)
                None
                continue
            if (((pos + 1) < len(source)) and (source[(pos + 1)] == ">")):
                tokens.append(Token("ARROW", "->", lineno))
                pos = (pos + 2)
                None
                continue
            tokens.append(Token("MINUS", "-", lineno))
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
