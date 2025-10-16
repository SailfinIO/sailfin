from __future__ import annotations

import importlib
import textwrap

import pytest


@pytest.mark.usefixtures("stage1_environment")
def test_missing_effect_diagnostic_includes_source_snippet() -> None:
    stage1_main = importlib.import_module("compiler.build.main")

    source = textwrap.dedent(
        """
        fn report() -> number {
          print.info("ok");
          return 1;
        }
        """
    )

    result = stage1_main.compile_to_native(source)
    snippet = next(
        (message for message in result.diagnostics if "missing effect 'io'" in message),
        None,
    )
    assert snippet is not None, "expected missing effect diagnostic"
    expected_line = next(
        index for index, line in enumerate(source.splitlines(), start=1) if 'print.info("ok");' in line
    )
    assert f"line {expected_line}" in snippet
    assert 'print.info("ok");' in snippet
    assert "^" in snippet
