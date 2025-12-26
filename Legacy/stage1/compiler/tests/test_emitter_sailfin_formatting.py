from __future__ import annotations

import importlib
import pathlib

import pytest

pytestmark = pytest.mark.unit


def _repo_root() -> pathlib.Path:
    return pathlib.Path(__file__).resolve().parents[2]


def _extract_top_level_import_block(lines: list[str]) -> tuple[int, int]:
    """Return (start, end_exclusive) indices for the contiguous import/export block.

    Assumes a canonical emitter header comment may appear before imports.
    """

    index = 0
    while index < len(lines) and (not lines[index].strip()):
        index += 1

    # Skip generated header comment if present.
    if index < len(lines) and lines[index].lstrip().startswith("//"):
        index += 1
        while index < len(lines) and (not lines[index].strip()):
            index += 1

    start = index
    while index < len(lines):
        stripped = lines[index].lstrip()
        # Accept both modern brace imports (`import { ... } from`) and the
        # historical paren imports (`import(...) from`) so this test focuses on
        # spacing/structure rather than import-syntax evolution.
        if stripped.startswith("import") or stripped.startswith("export"):
            index += 1
            continue
        break

    return start, index


@pytest.mark.usefixtures("stage1_environment")
def test_emit_program_matches_project_spacing_conventions() -> None:
    repo_root = _repo_root()
    source = (repo_root / "compiler" / "src" /
              "main.sfn").read_text(encoding="utf-8")

    stage1_main = importlib.import_module("compiler.build.main")
    emitted = stage1_main.compile_to_sailfin(source)

    assert emitted.strip(), "compile_to_sailfin returned empty output"

    # 1) Braces should be K&R style for declarations/blocks.
    assert "\nstruct CompiledModule {" in emitted
    assert "\nstruct CompiledModule\n{" not in emitted
    assert "\nfn compile_to_sailfin(source -> string) -> string ![io] {" in emitted
    assert "\nfn compile_to_sailfin(source -> string) -> string ![io]\n{" not in emitted

    # 2) Imports should be a compact block (no blank lines between import/export lines)
    #    and there should be exactly one blank line after the import block.
    lines = emitted.splitlines()
    start, end = _extract_top_level_import_block(lines)
    assert end > start, "expected an import block near the top of emitted output"

    for i in range(start, end - 1):
        assert lines[i].strip(), "unexpected blank line within import block"
        assert lines[i + 1].strip(), "unexpected blank line within import block"

    assert end < len(lines), "expected non-import content after import block"
    assert lines[end].strip(
    ) == "", "expected a blank line after the import block"
    assert end + 1 < len(lines)
    assert lines[end +
                 1].strip(), "expected content after the post-import blank line"

    # 3) Top-level declarations should be separated by a blank line.
    assert "}\n\nstruct ModuleDiagnostics" in emitted
    assert "}\n\nfn compile_to_sailfin" in emitted
    assert "}\nstruct ModuleDiagnostics" not in emitted
    assert "}\nfn compile_to_sailfin" not in emitted
