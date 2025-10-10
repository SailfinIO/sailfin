from __future__ import annotations

import pytest

from textwrap import dedent

from bootstrap.lexer import lexer as base_lexer
from bootstrap.parser import parser
from bootstrap.effect_checker import validate_effects, EffectValidationError


def parse(src: str):
    return parser.parse(src, lexer=base_lexer.clone())


def test_prompt_requires_model_effect():
    ast = parse("fn demo() { prompt system { \"hi\"; }; }")
    with pytest.raises(EffectValidationError):
        validate_effects(ast)


def test_declared_effect_satisfies_requirement():
    ast = parse("fn demo() ![model] { prompt user { \"hi\"; }; }")
    # Should not raise
    validate_effects(ast)


def test_spawn_requires_io_effect():
    ast = parse(
        dedent(
            """
            fn worker() {}

            fn demo() {
                spawn(worker);
            }
            """
        )
    )
    with pytest.raises(EffectValidationError):
        validate_effects(ast)


def test_spawn_with_declared_io_effect():
    ast = parse(
        dedent(
            """
            fn worker() {}

            fn demo() ![io] {
                spawn(worker);
            }
            """
        )
    )
    validate_effects(ast)


def test_serve_requires_net_effect():
    ast = parse(
        dedent(
            """
            fn handler(req, res) {}

            fn demo() {
                serve(handler);
            }
            """
        )
    )
    with pytest.raises(EffectValidationError):
        validate_effects(ast)


def test_serve_with_declared_net_effect():
    ast = parse(
        dedent(
            """
            fn handler(req, res) {}

            fn demo() ![net] {
                serve(handler);
            }
            """
        )
    )
    validate_effects(ast)
