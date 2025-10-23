import pytest

from tools.package_stage2 import Stage2PackageError, target_label_for_host


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
