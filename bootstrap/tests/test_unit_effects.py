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


def test_runtime_spawn_requires_io_effect():
    ast = parse(
        dedent(
            """
            fn worker() {}

            fn demo() {
                runtime.spawn(worker);
            }
            """
        )
    )
    with pytest.raises(EffectValidationError):
        validate_effects(ast)


def test_runtime_spawn_with_declared_io_effect():
    ast = parse(
        dedent(
            """
            fn worker() {}

            fn demo() ![io] {
                runtime.spawn(worker);
            }
            """
        )
    )
    validate_effects(ast)


def test_runtime_serve_requires_net_effect():
    ast = parse(
        dedent(
            """
            fn handler(req, res) {}

            fn demo() {
                runtime.serve(handler);
            }
            """
        )
    )
    with pytest.raises(EffectValidationError):
        validate_effects(ast)


def test_runtime_serve_with_declared_net_effect():
    ast = parse(
        dedent(
            """
            fn handler(req, res) {}

            fn demo() ![net] {
                runtime.serve(handler);
            }
            """
        )
    )
    validate_effects(ast)


def test_print_info_requires_io_effect():
    ast = parse('fn demo() { print.info("hi"); }')
    with pytest.raises(EffectValidationError):
        validate_effects(ast)


def test_print_info_with_declared_io_effect():
    ast = parse('fn demo() ![io] { print.info("hi"); }')
    validate_effects(ast)


def test_runtime_console_info_requires_io_effect():
    ast = parse('fn demo() { runtime.console.info("hi"); }')
    with pytest.raises(EffectValidationError):
        validate_effects(ast)


def test_runtime_console_info_with_declared_io_effect():
    ast = parse('fn demo() ![io] { runtime.console.info("hi"); }')
    validate_effects(ast)


def test_sleep_requires_clock_effect():
    ast = parse('fn demo() { sleep(42); }')
    with pytest.raises(EffectValidationError):
        validate_effects(ast)


def test_sleep_with_declared_clock_effect():
    ast = parse('fn demo() ![clock] { sleep(42); }')
    validate_effects(ast)


def test_runtime_sleep_requires_clock_effect():
    ast = parse('fn demo() { runtime.sleep(42); }')
    with pytest.raises(EffectValidationError):
        validate_effects(ast)


def test_runtime_sleep_with_declared_clock_effect():
    ast = parse('fn demo() ![clock] { runtime.sleep(42); }')
    validate_effects(ast)


def test_runtime_http_requires_net_effect():
    ast = parse('fn demo() { runtime.http.get("https://example.com"); }')
    with pytest.raises(EffectValidationError):
        validate_effects(ast)


def test_runtime_http_with_declared_net_effect():
    ast = parse('fn demo() ![net] { runtime.http.get("https://example.com"); }')
    validate_effects(ast)


def test_runtime_websocket_requires_net_effect():
    ast = parse('fn demo() { runtime.websocket.connect("wss://example.com"); }')
    with pytest.raises(EffectValidationError):
        validate_effects(ast)


def test_runtime_websocket_with_declared_net_effect():
    ast = parse('fn demo() ![net] { runtime.websocket.connect("wss://example.com"); }')
    validate_effects(ast)


def test_runtime_fs_requires_io_effect():
    ast = parse('fn demo() { runtime.fs.read("/tmp/data"); }')
    with pytest.raises(EffectValidationError):
        validate_effects(ast)


def test_runtime_fs_with_declared_io_effect():
    ast = parse('fn demo() ![io] { runtime.fs.read("/tmp/data"); }')
    validate_effects(ast)


def test_decorator_requires_io_effect():
    ast = parse(
        dedent(
            """
            @logExecution
            fn compute() {}
            """
        )
    )
    with pytest.raises(EffectValidationError):
        validate_effects(ast)


def test_decorator_with_declared_io_effect():
    ast = parse(
        dedent(
            """
            @logExecution
            fn compute() ![io] {}
            """
        )
    )
    validate_effects(ast)
