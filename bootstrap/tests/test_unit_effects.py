from __future__ import annotations

import pytest

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
