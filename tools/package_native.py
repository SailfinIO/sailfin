#!/usr/bin/env python3
"""Package native compiler artifacts for distribution."""

from __future__ import annotations

import argparse
import datetime as _dt
import hashlib
import json
import os
import pathlib
import platform
import re
import shutil
import sys
import tempfile
import subprocess
from typing import Dict, Iterable, List, Optional, Tuple

REPO_ROOT = pathlib.Path(__file__).resolve().parents[1]

if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

"""NOTE: this tool is intentionally selfhost-only.

CI produces native artifacts via the selfhost pipeline, then packages them via
`--skip-build --native-out <dir>`.
"""


class NativePackageError(RuntimeError):
    """Raised when native packaging fails."""


def target_label_for_host(system: str | None = None, machine: str | None = None) -> str:
    """Return an OS/arch label for the current host.

    Args:
        system: Optional override for ``platform.system()``.
        machine: Optional override for ``platform.machine()``.

    Returns:
        Label of the form ``"macos-arm64"`` or ``"linux-x86_64"``.

    Raises:
        NativePackageError: If the host combination is unsupported.
    """

    sys_name = (system or platform.system() or "").strip().lower()
    mach = (machine or platform.machine() or "").strip().lower()

    if not sys_name:
        raise NativePackageError("unable to detect host operating system")

    if sys_name == "darwin":
        os_label = "macos"
        if mach in {"arm64", "aarch64"}:
            arch_label = "arm64"
        elif mach in {"x86_64", "amd64"}:
            arch_label = "x86_64"
        else:
            raise NativePackageError(
                f"unsupported macOS architecture '{mach}'")
    elif sys_name == "linux":
        os_label = "linux"
        if mach in {"x86_64", "amd64"}:
            arch_label = "x86_64"
        elif mach in {"aarch64", "arm64"}:
            arch_label = "arm64"
        else:
            raise NativePackageError(
                f"unsupported Linux architecture '{mach}'")
    else:
        raise NativePackageError(f"unsupported operating system '{sys_name}'")

    return f"{os_label}-{arch_label}"


def _infer_version() -> str:
    try:
        version_path = REPO_ROOT / "compiler" / "src" / "version.sfn"
        text = version_path.read_text(encoding="utf-8")
        match = re.search(r'\b__version__\s*=\s*"(?P<version>[^"]+)"', text)
        if match:
            return match.group("version")
    except Exception:
        pass

    try:
        import subprocess

        output = subprocess.check_output(
            ["git", "describe", "--tags", "--always", "--dirty"],
            cwd=REPO_ROOT,
            text=True,
        )
        return output.strip().replace("/", "-")
    except Exception:
        return "dev"


def _infer_commit_hash() -> str:
    try:
        import subprocess

        output = subprocess.check_output(
            ["git", "rev-parse", "HEAD"],
            cwd=REPO_ROOT,
            text=True,
        )
        return output.strip()
    except Exception:
        return "unknown"


def _run_make_target(target: str) -> None:
    try:
        subprocess.run(["make", target], cwd=REPO_ROOT, check=True)
    except subprocess.CalledProcessError as exc:
        raise NativePackageError(
            f"failed to run 'make {target}' (rc={exc.returncode})"
        ) from exc


def _compute_sha256(path: pathlib.Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as handle:
        for chunk in iter(lambda: handle.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def _gather_artifact_inventory(artifacts_dir: pathlib.Path) -> List[Dict[str, object]]:
    entries: List[Dict[str, object]] = []
    for file_path in sorted(artifacts_dir.rglob("*")):
        if not file_path.is_file():
            continue
        relative = file_path.relative_to(artifacts_dir).as_posix()
        entries.append(
            {
                "path": f"artifacts/{relative}",
                "size": file_path.stat().st_size,
                "sha256": _compute_sha256(file_path),
            }
        )
    return entries


def _write_metadata(
    destination: pathlib.Path,
    *,
    version: str,
    target_label: str,
    artifacts: Optional[List[Dict[str, object]]] = None,
) -> Dict[str, object]:
    metadata: dict[str, object] = {
        "version": version,
        "target": target_label,
        "commit": _infer_commit_hash(),
        "generated_at": _dt.datetime.now(_dt.UTC).replace(microsecond=0).isoformat(),
    }

    if artifacts:
        metadata["artifacts"] = artifacts

    destination.write_text(json.dumps(
        metadata, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    return metadata


def _write_sha256_sidecar(archive_path: pathlib.Path, sha256: str) -> pathlib.Path:
    sidecar = archive_path.with_name(f"{archive_path.name}.sha256")
    sidecar.write_text(f"{sha256}  {archive_path.name}\n", encoding="utf-8")
    return sidecar


def _write_manifest_sidecar(
    output_dir: pathlib.Path,
    archive_stem: str,
    archive_name: str,
    sha256: str,
    metadata: Dict[str, object],
) -> pathlib.Path:
    manifest = {
        "version": metadata.get("version"),
        "target": metadata.get("target"),
        "archive": archive_name,
        "sha256": sha256,
        "diagnostics": metadata.get("diagnostics", {}),
        "artifacts": metadata.get("artifacts", []),
    }
    manifest_path = output_dir / f"{archive_stem}.manifest.json"
    manifest_path.write_text(json.dumps(
        manifest, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    return manifest_path


def _write_readme(destination: pathlib.Path, *, target_label: str) -> None:
    contents = f"""# Sailfin Native LLVM Artifacts ({target_label})

This archive contains the raw native LLVM outputs generated from the Sailfin
compiler sources. The bundle includes:

- `artifacts/` – `.ll`, `.sfn-asm`, and `.layout-manifest` files for each compiled module.
- `bin/` – optional native compiler binary (when included via `--compiler-bin`).
- `metadata.json` – build metadata (version, commit, timestamp).
- `runtime/native/` – runtime sources plus the prelude object used for native linking.

This bundle also ships the native runtime sources plus a compiled prelude
object so the compiler CLI can link standalone executables without a repo
checkout. A native runtime shim is still required to execute the resulting
modules.
"""
    destination.write_text(contents, encoding="utf-8")


def _copy_runtime_bundle(archive_root: pathlib.Path) -> None:
    runtime_src = REPO_ROOT / "runtime" / "native"
    if not runtime_src.exists():
        raise NativePackageError(
            f"runtime bundle not found at {runtime_src}")

    runtime_dst = archive_root / "runtime" / "native"
    shutil.copytree(runtime_src, runtime_dst)

    prelude_obj = REPO_ROOT / "build" / "native" / "obj" / "runtime" / "prelude.o"
    if not prelude_obj.exists():
        raise NativePackageError(
            "missing prelude object; expected "
            f"{prelude_obj}"
        )
    obj_dir = runtime_dst / "obj"
    obj_dir.mkdir(parents=True, exist_ok=True)
    shutil.copy2(prelude_obj, obj_dir / "prelude.o")


def _create_archive(source_dir: pathlib.Path, output_path: pathlib.Path) -> pathlib.Path:
    output_path = output_path.resolve()
    name = output_path.name

    # `Path.with_suffix()` only understands the last suffix, which breaks for
    # version strings containing dots (e.g. `0.1.1-alpha.tar.gz` would be
    # treated as having suffix `.gz`, then `.tar`, then `.1-alpha`). We want to
    # strip ONLY the trailing `.tar.gz`.
    if name.endswith(".tar.gz"):
        base = output_path.with_name(name[: -len(".tar.gz")])
    else:
        base = output_path.with_suffix("")

    if output_path.exists() or base.exists():
        raise NativePackageError(f"output path already exists: {output_path}")

    output_path.parent.mkdir(parents=True, exist_ok=True)

    shutil.make_archive(
        str(base),
        "gztar",
        root_dir=source_dir.parent,
        base_dir=source_dir.name,
    )
    return output_path


def package_native(
    *,
    output_dir: pathlib.Path,
    native_output: pathlib.Path,
    compiler_bin: Optional[pathlib.Path],
    version: str,
    target_label: str,
    skip_build: bool,
) -> pathlib.Path:
    if not skip_build:
        _run_make_target("rebuild")

    if not native_output.exists():
        raise NativePackageError(
            f"native output directory does not exist: {native_output}"
        )

    staging_root = pathlib.Path(tempfile.mkdtemp(prefix="sailfin-native-"))
    try:
        archive_root = staging_root / f"sailfin-native-{target_label}"
        artifacts_dir = archive_root / "artifacts"
        artifacts_dir.parent.mkdir(parents=True, exist_ok=True)
        shutil.copytree(native_output, artifacts_dir)

        inventory = _gather_artifact_inventory(artifacts_dir)
        metadata_path = archive_root / "metadata.json"
        metadata = _write_metadata(
            metadata_path,
            version=version,
            target_label=target_label,
            artifacts=inventory,
        )
        _write_readme(archive_root / "README.md", target_label=target_label)
        _copy_runtime_bundle(archive_root)

        if compiler_bin is not None:
            compiler_bin = compiler_bin.resolve()
            if not compiler_bin.exists():
                raise NativePackageError(
                    f"compiler binary does not exist: {compiler_bin}"
                )
            if not os.access(compiler_bin, os.X_OK):
                raise NativePackageError(
                    f"compiler binary is not executable: {compiler_bin}"
                )
            bin_dir = archive_root / "bin"
            bin_dir.mkdir(parents=True, exist_ok=True)
            shutil.copy2(compiler_bin, bin_dir / "sailfin")

        output_dir = output_dir.resolve()
        output_dir.mkdir(parents=True, exist_ok=True)
        archive_name = f"sailfin-native-{target_label}-{version}.tar.gz"
        archive_path = _create_archive(archive_root, output_dir / archive_name)
        archive_sha = _compute_sha256(archive_path)
        _write_sha256_sidecar(archive_path, archive_sha)
        archive_stem = archive_name[:-len(".tar.gz")] if archive_name.endswith(
            ".tar.gz") else archive_path.stem
        _write_manifest_sidecar(output_dir, archive_stem,
                                archive_name, archive_sha, metadata)
        return archive_path
    finally:
        shutil.rmtree(staging_root, ignore_errors=True)


def _parse_args(argv: Iterable[str] | None = None) -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Package Sailfin native compiler artifacts")
    parser.add_argument("--out", dest="out", type=pathlib.Path, default=REPO_ROOT / "dist",
                        help="Directory to receive the packaged archive (default: dist/)")
    parser.add_argument("--native-out", dest="native_out", type=pathlib.Path,
                        default=REPO_ROOT / "build" / "native" / "import-context",
                        help="Directory containing native artifacts to package (default: build/native/import-context)")
    parser.add_argument("--version", dest="version",
                        help="Override the version string for the archive name")
    parser.add_argument("--target", dest="target",
                        help="Override the target label (default: auto-detected)")
    parser.add_argument(
        "--compiler-bin",
        dest="compiler_bin",
        type=pathlib.Path,
        default=None,
        help="Optional compiler binary to include in the archive (e.g. build/native/sailfin)",
    )
    parser.add_argument("--skip-build", dest="skip_build", action="store_true",
                        help="Skip rebuilding and package existing artifacts")
    return parser.parse_args(list(argv) if argv is not None else None)


def main(argv: Iterable[str] | None = None) -> int:
    args = _parse_args(argv)

    version = args.version or _infer_version()
    try:
        target_label = args.target or target_label_for_host()
        archive_path = package_native(
            output_dir=args.out,
            native_output=args.native_out,
            compiler_bin=args.compiler_bin,
            version=version,
            target_label=target_label,
            skip_build=args.skip_build,
        )
    except NativePackageError as exc:
        print(f"[package-native][error] {exc}", file=sys.stderr)
        return 1

    print(f"[package-native] wrote {archive_path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
