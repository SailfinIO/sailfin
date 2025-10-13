from __future__ import annotations

import importlib

import pytest

MISSING_EFFECT_SOURCE = """
fn launch() {
  let worker = fn() {
    prompt "chat" {
      let answer = 42;
      let _ = answer;
    }
  };
  spawn(worker);
}
"""


@pytest.mark.usefixtures("stage1_environment")
def test_typecheck_reports_missing_effects_with_spans() -> None:
    parser_module = importlib.import_module("compiler.build.parser")
    typecheck_module = importlib.import_module("compiler.build.typecheck")

    parse_program = getattr(parser_module, "parse_program")
    typecheck_program = getattr(typecheck_module, "typecheck_program")

    program = parse_program(MISSING_EFFECT_SOURCE)
    result = typecheck_program(program)

    effect_diagnostics = [
        diagnostic for diagnostic in result.diagnostics if diagnostic.code == "effects.missing"
    ]
    assert len(effect_diagnostics) == 2

    messages = {diagnostic.message for diagnostic in effect_diagnostics}
    assert any("launch is missing effect 'io'" in message for message in messages)
    assert any("launch is missing effect 'model'" in message for message in messages)
    assert any("![io]" in message for message in messages)
    assert any("![model]" in message for message in messages)
    assert any("CLI fix prompt" in message for message in messages)

    spawn_diag = _select_diagnostic(effect_diagnostics, "io")
    assert spawn_diag.primary is not None
    assert spawn_diag.primary.lexeme == "spawn"
    assert "required by" in spawn_diag.message

    prompt_diag = _select_diagnostic(effect_diagnostics, "model")
    assert prompt_diag.primary is not None
    assert prompt_diag.primary.lexeme == "prompt"
    assert "required by" in prompt_diag.message


def _select_diagnostic(diagnostics, effect: str):
    for diagnostic in diagnostics:
        if f"'{effect}'" in diagnostic.message:
            return diagnostic
    raise AssertionError(f"missing diagnostic for effect: {effect}")
