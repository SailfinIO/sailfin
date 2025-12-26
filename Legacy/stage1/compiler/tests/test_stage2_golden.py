from __future__ import annotations

import pathlib

import pytest

pytestmark = [pytest.mark.stage2, pytest.mark.usefixtures("stage1_environment")]

DATA_DIR = pathlib.Path(__file__).resolve().parent / "data" / "stage2"
METADATA_SOURCE = DATA_DIR / "metadata.sfn"
METADATA_ASM = DATA_DIR / "metadata.sfn-asm"
METADATA_LLVM = DATA_DIR / "metadata.ll"


def _read_text(path: pathlib.Path) -> str:
    return path.read_text(encoding="utf-8").strip()


def _extract_artifact(result, name: str) -> str:
    module = getattr(result, "module", None)
    if module is None:
        return ""
    for artifact in getattr(module, "artifacts", []):
        if getattr(artifact, "name", "") == name:
            return getattr(artifact, "contents", "")
    return ""


def test_stage2_metadata_native_snapshot(stage2_environment) -> None:
    compiled = stage2_environment.compile_to_native_from_path(METADATA_SOURCE)
    artifact = _extract_artifact(compiled, "module.sfn-asm").strip()
    expected = _read_text(METADATA_ASM)
    assert artifact == expected, "native .sfn-asm snapshot drifted"


def test_stage2_metadata_llvm_snapshot(stage2_environment) -> None:
    lowered = stage2_environment.compile_to_native_llvm_from_path(METADATA_SOURCE)
    expected = _read_text(METADATA_LLVM)
    assert lowered.ir.strip() == expected, "LLVM snapshot drifted"


def test_stage2_metadata_diagnostics_align(stage2_environment) -> None:
    native = stage2_environment.compile_to_native_from_path(METADATA_SOURCE)
    llvm = stage2_environment.compile_to_native_llvm_from_path(METADATA_SOURCE)
    assert llvm.diagnostics == native.diagnostics == [], "expected clean Stage2 diagnostics"
