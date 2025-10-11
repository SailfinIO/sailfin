from __future__ import annotations

from bootstrap.lexer import lexer as base_lexer


def lex(text: str):
    lx = base_lexer.clone()
    lx.input(text)
    toks = []
    t = lx.token()
    while t is not None:
        toks.append((t.type, t.value))
        t = lx.token()
    return toks


def test_identifiers_and_keywords():
    tokens = lex("let mut x = 42;")
    types = [t[0] for t in tokens]
    assert types[:5] == ["LET", "MUT", "IDENTIFIER", "ASSIGN", "NUMBER"]


def test_string_and_comments_are_ignored():
    tokens = lex('print("hi") // comment')
    # ensure comment isn\'t tokenized; last token should be RPAREN or SEMICOLON if present
    assert tokens[-1][0] in {"RPAREN", "SEMICOLON"}
