import hashlib
import json

import pytest

from tools.package_stage2 import (
    Stage2PackageError,
    _compute_sha256,
    _gather_artifact_inventory,
    _write_manifest_sidecar,
    _write_sha256_sidecar,
    target_label_for_host,
)


@pytest.mark.unit
def test_target_label_mac_arm() -> None:
    assert target_label_for_host(
        system="Darwin", machine="arm64") == "macos-arm64"


@pytest.mark.unit
def test_target_label_mac_x86() -> None:
    assert target_label_for_host(
        system="Darwin", machine="x86_64") == "macos-x86_64"


@pytest.mark.unit
def test_target_label_linux_variants() -> None:
    assert target_label_for_host(
        system="Linux", machine="x86_64") == "linux-x86_64"
    assert target_label_for_host(
        system="Linux", machine="aarch64") == "linux-arm64"


@pytest.mark.unit
def test_target_label_unknown_system() -> None:
    with pytest.raises(Stage2PackageError):
        target_label_for_host(system="Windows", machine="x86_64")


@pytest.mark.unit
def test_target_label_unknown_arch() -> None:
    with pytest.raises(Stage2PackageError):
        target_label_for_host(system="Linux", machine="mips64")


@pytest.mark.unit
def test_compute_sha256(tmp_path) -> None:
    sample = tmp_path / "payload.bin"
    sample.write_bytes(b"stage2")
    expected = hashlib.sha256(b"stage2").hexdigest()
    assert _compute_sha256(sample) == expected


@pytest.mark.unit
def test_gather_artifact_inventory(tmp_path) -> None:
    artifacts_dir = tmp_path / "artifacts"
    nested = artifacts_dir / "compiler"
    nested.mkdir(parents=True)
    file_path = nested / "module.ll"
    file_path.write_text(
        "define void @main() { ret void }\n", encoding="utf-8")

    inventory = _gather_artifact_inventory(artifacts_dir)
    assert len(inventory) == 1
    entry = inventory[0]
    assert entry["path"] == "artifacts/compiler/module.ll"
    assert entry["size"] == file_path.stat().st_size
    assert entry["sha256"] == hashlib.sha256(
        file_path.read_bytes()).hexdigest()


@pytest.mark.unit
def test_write_sha256_sidecar(tmp_path) -> None:
    archive = tmp_path / "sailfin-stage2.tar.gz"
    archive.write_bytes(b"artifact")
    digest = hashlib.sha256(b"artifact").hexdigest()
    sidecar = _write_sha256_sidecar(archive, digest)
    assert sidecar.exists()
    assert sidecar.read_text(encoding="utf-8") == f"{digest}  {archive.name}\n"


@pytest.mark.unit
def test_write_manifest_sidecar(tmp_path) -> None:
    metadata = {
        "version": "0.0.1",
        "target": "macos-arm64",
        "artifacts": [
            {"path": "artifacts/module.ll", "size": 12, "sha256": "abc"}
        ],
        "diagnostics": {"total": 10, "fatal": 0},
    }
    manifest_path = _write_manifest_sidecar(
        tmp_path,
        "sailfin-stage2-macos-arm64-0.0.1",
        "sailfin-stage2-macos-arm64-0.0.1.tar.gz",
        "deadbeef",
        metadata,
    )
    payload = json.loads(manifest_path.read_text(encoding="utf-8"))
    assert payload["sha256"] == "deadbeef"
    assert payload["archive"] == "sailfin-stage2-macos-arm64-0.0.1.tar.gz"
    assert payload["artifacts"] == metadata["artifacts"]
