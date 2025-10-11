from __future__ import annotations

import importlib
import pathlib
import sys
from typing import Iterator

import pytest

from bootstrap import compile_self_host

REPO_ROOT = pathlib.Path(__file__).resolve().parents[2]
COMPILER_SRC_ROOT = REPO_ROOT / "compiler" / "src"


@pytest.fixture()
def stage1_environment(tmp_path_factory: pytest.TempPathFactory) -> Iterator[pathlib.Path]:
    """Compile the Stage1 toolchain into an isolated directory."""

    temp_root = tmp_path_factory.mktemp("stage1_build")
    output_dir = temp_root / "compiler" / "build"
    compile_self_host.main(["--out", str(output_dir)])

    sys.path.insert(0, str(temp_root))
    try:
        yield temp_root
    finally:
        sys.path.remove(str(temp_root))
        _clear_stage1_modules()


def _clear_stage1_modules() -> None:
    for name in list(sys.modules):
        if name == "compiler.build" or name.startswith("compiler.build."):
            sys.modules.pop(name, None)
    importlib.invalidate_caches()


def _collect_compiler_sources() -> list[str]:
    return sorted(str(path.resolve()) for path in COMPILER_SRC_ROOT.glob("*.sfn"))


def _format_diagnostics(entries: list[object]) -> list[str]:
    formatted: list[str] = []
    for entry in entries:
        source_path = getattr(entry, "source_path", "<unknown>")
        messages = getattr(entry, "messages", [])
        for message in messages:
            formatted.append(f"{source_path}: {message}")
    return formatted


def test_stage1_compiles_all_sources(stage1_environment: pathlib.Path) -> None:
    _clear_stage1_modules()
    self_host_checks = importlib.import_module("compiler.build.self_host_checks")

    sources = _collect_compiler_sources()
    result = self_host_checks.run_self_host_check(sources)

    fatal_messages = _format_diagnostics(list(result.fatal_diagnostics))
    missing_sources = list(result.missing_sources)

    assert result.compiled_count == result.expected_count, (
        "stage1 compiled a different number of modules than expected; "
        f"compiled={result.compiled_count}, expected={result.expected_count}, "
        f"missing={missing_sources}"
    )
    assert not fatal_messages, "\n".join(["stage1 reported fatal diagnostics:"] + fatal_messages)
    assert not missing_sources, "stage1 did not produce modules for: " + ", ".join(missing_sources)
    assert result.success, "stage1 self-host check reported failure"
