from __future__ import annotations

import importlib
import pathlib
from typing import Iterable

import pytest

pytestmark = pytest.mark.integration

REPO_ROOT = pathlib.Path(__file__).resolve().parents[2]
COMPILER_SRC_ROOT = REPO_ROOT / "compiler" / "src"


def _collect_compiler_sources() -> list[str]:
    return sorted(str(path.resolve()) for path in COMPILER_SRC_ROOT.glob("*.sfn"))


def _format_diagnostics(entries: Iterable[object]) -> list[str]:
    formatted: list[str] = []
    for entry in entries:
        source_path = getattr(entry, "source_path", "<unknown>")
        messages = getattr(entry, "messages", [])
        for message in messages:
            formatted.append(f"{source_path}: {message}")
    return formatted


@pytest.mark.usefixtures("stage1_environment")
def test_stage1_compiles_all_sources() -> None:
    importlib.invalidate_caches()
    self_host_checks = importlib.import_module("compiler.build.self_host_checks")

    sources = _collect_compiler_sources()
    result = self_host_checks.run_self_host_check(sources)

    fatal_messages = _format_diagnostics(result.fatal_diagnostics)
    missing_sources = list(result.missing_sources)

    assert result.compiled_count == result.expected_count, (
        "stage1 compiled a different number of modules than expected; "
        f"compiled={result.compiled_count}, expected={result.expected_count}, "
        f"missing={missing_sources}"
    )
    assert not fatal_messages, "\n".join(["stage1 reported fatal diagnostics:"] + fatal_messages)
    assert not missing_sources, "stage1 did not produce modules for: " + ", ".join(missing_sources)
    assert result.success, "stage1 self-host check reported failure"
