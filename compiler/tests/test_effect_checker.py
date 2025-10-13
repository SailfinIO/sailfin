from __future__ import annotations

import importlib

import pytest

NESTED_PROMPT_SOURCE = """
fn outer() {
  let worker = fn() {
    prompt "chat" {
      let value = 1;
      let _ = value;
    }
  };
  worker();
}
"""

SPAWN_PROMPT_SOURCE = """
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

SPAWN_PROMPT_WITH_EFFECTS_SOURCE = """
fn launch() ![io, model] {
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
def test_effect_checker_propagates_model_from_nested_lambda() -> None:
    parser_module = importlib.import_module("compiler.build.parser")
    effect_checker = importlib.import_module("compiler.build.effect_checker")

    program = parser_module.parse_program(NESTED_PROMPT_SOURCE)
    violations = effect_checker.validate_effects(program)

    assert len(violations) == 1
    violation = violations[0]
    assert violation.routine_name == "outer"
    assert set(violation.missing_effects) == {"model"}
    assert violation.requirements
    requirement = violation.requirements[0]
    assert requirement.effect == "model"
    assert requirement.description.startswith("prompt")
    assert requirement.origin.lexeme == "prompt"


@pytest.mark.usefixtures("stage1_environment")
def test_spawn_prompt_requires_io_and_model() -> None:
    parser_module = importlib.import_module("compiler.build.parser")
    effect_checker = importlib.import_module("compiler.build.effect_checker")

    program = parser_module.parse_program(SPAWN_PROMPT_SOURCE)
    violations = effect_checker.validate_effects(program)

    assert len(violations) == 1
    violation = violations[0]
    assert violation.routine_name == "launch"
    assert set(violation.missing_effects) == {"io", "model"}
    assert violation.requirements
    effects = {req.effect for req in violation.requirements}
    assert effects == {"io", "model"}
    spawn_requirement = _select_requirement(violation.requirements, "io")
    assert spawn_requirement.description == "spawn call"
    assert spawn_requirement.origin.lexeme == "spawn"
    prompt_requirement = _select_requirement(violation.requirements, "model")
    assert prompt_requirement.description.startswith("prompt")
    assert prompt_requirement.origin.lexeme == "prompt"


@pytest.mark.usefixtures("stage1_environment")
def test_effect_checker_respects_declared_effects_for_spawn_prompt() -> None:
    parser_module = importlib.import_module("compiler.build.parser")
    effect_checker = importlib.import_module("compiler.build.effect_checker")

    program = parser_module.parse_program(SPAWN_PROMPT_WITH_EFFECTS_SOURCE)
    violations = effect_checker.validate_effects(program)

    assert not violations


def _select_requirement(requirements, effect: str):
    for requirement in requirements:
        if requirement.effect == effect:
            return requirement
    raise AssertionError(f"missing requirement for effect: {effect}")
