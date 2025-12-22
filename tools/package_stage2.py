#!/usr/bin/env python3
"""Package Stage2 LLVM artifacts for distribution."""

from __future__ import annotations

import argparse
import datetime as _dt
import hashlib
import json
import os
import pathlib
import platform
import shutil
import sys
import tempfile
from typing import Dict, Iterable, List, Optional, Tuple

REPO_ROOT = pathlib.Path(__file__).resolve().parents[1]

if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

from tools.compile_with_stage1 import (  # noqa: E402
    Stage1CompileError,
    compile_stage1,
    link_stage2_binary,
)
from scripts import bootstrap_stage2  # noqa: E402


class Stage2PackageError(RuntimeError):
    """Raised when Stage2 packaging fails."""


def target_label_for_host(system: str | None = None, machine: str | None = None) -> str:
    """Return an OS/arch label for the current host.

    Args:
        system: Optional override for ``platform.system()``.
        machine: Optional override for ``platform.machine()``.

    Returns:
        Label of the form ``"macos-arm64"`` or ``"linux-x86_64"``.

    Raises:
        Stage2PackageError: If the host combination is unsupported.
    """

    sys_name = (system or platform.system() or "").strip().lower()
    mach = (machine or platform.machine() or "").strip().lower()

    if not sys_name:
        raise Stage2PackageError("unable to detect host operating system")

    if sys_name == "darwin":
        os_label = "macos"
        if mach in {"arm64", "aarch64"}:
            arch_label = "arm64"
        elif mach in {"x86_64", "amd64"}:
            arch_label = "x86_64"
        else:
            raise Stage2PackageError(
                f"unsupported macOS architecture '{mach}'")
    elif sys_name == "linux":
        os_label = "linux"
        if mach in {"x86_64", "amd64"}:
            arch_label = "x86_64"
        elif mach in {"aarch64", "arm64"}:
            arch_label = "arm64"
        else:
            raise Stage2PackageError(
                f"unsupported Linux architecture '{mach}'")
    else:
        raise Stage2PackageError(f"unsupported operating system '{sys_name}'")

    return f"{os_label}-{arch_label}"


def _infer_version() -> str:
    try:
        import importlib

        runtime = importlib.import_module("runtime")
        version = getattr(runtime, "__version__", None)
        if version:
            return str(version)
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


def _resolve_stage1_sources() -> Iterable[pathlib.Path]:
    compiler_src = (REPO_ROOT / "compiler" / "src").resolve()
    runtime_src = (REPO_ROOT / "runtime").resolve()
    yield compiler_src
    yield runtime_src


def _run_stage1_compile(output_dir: pathlib.Path) -> None:
    compile_stage1(_resolve_stage1_sources(), output_dir)


def _run_stage2_bootstrap(
    output_dir: pathlib.Path,
    *,
    quiet: bool = False,
    validate: bool = True,
) -> Tuple[List[pathlib.Path], Optional[bootstrap_stage2.DiagnosticAggregator]]:
    result = bootstrap_stage2.compile_compiler_to_stage2(
        output_dir,
        debug=not quiet,
        quiet=quiet,
    )

    modules: List[pathlib.Path]
    aggregator: Optional[bootstrap_stage2.DiagnosticAggregator]

    if len(result) == 3:
        modules, aggregator, _lowered = result
    else:
        modules, aggregator = result

    if validate:
        bootstrap_stage2.validate_stage2_artifacts(modules, debug=False)

    return modules, aggregator


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
    aggregator: Optional[bootstrap_stage2.DiagnosticAggregator],
    artifacts: Optional[List[Dict[str, object]]] = None,
) -> Dict[str, object]:
    metadata: dict[str, object] = {
        "version": version,
        "target": target_label,
        "commit": _infer_commit_hash(),
        "generated_at": _dt.datetime.now(_dt.UTC).replace(microsecond=0).isoformat(),
    }

    if aggregator is not None:
        categories = sorted(
            aggregator.categories.items(),
            key=lambda item: item[1],
            reverse=True,
        )
        metadata["diagnostics"] = {
            "total": aggregator.total_count,
            "fatal": aggregator.fatal_count,
            "top_categories": categories[:20],
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
    manifest_path.write_text(json.dumps(manifest, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    return manifest_path


def _write_readme(destination: pathlib.Path, *, target_label: str) -> None:
    contents = f"""# Sailfin Stage2 LLVM Artifacts ({target_label})

This archive contains the raw Stage2 LLVM outputs generated from the Sailfin
compiler sources. The bundle includes:

- `artifacts/` – `.ll`, `.sfn-asm`, and `.layout-manifest` files for each compiled module.
- `metadata.json` – build metadata (version, commit, timestamp, diagnostics summary).

These artifacts are intended for downstream packaging and validation workflows
while the Sailfin runtime finishes its migration away from Python. A native
runtime shim is still required to execute the resulting modules.
"""
    destination.write_text(contents, encoding="utf-8")


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
        raise Stage2PackageError(f"output path already exists: {output_path}")

    output_path.parent.mkdir(parents=True, exist_ok=True)

    shutil.make_archive(
        str(base),
        "gztar",
        root_dir=source_dir.parent,
        base_dir=source_dir.name,
    )
    return output_path


def package_stage2(
    *,
    output_dir: pathlib.Path,
    stage1_output: pathlib.Path,
    stage2_output: pathlib.Path,
    version: str,
    target_label: str,
    quiet: bool,
    skip_build: bool,
    link_binary: bool,
    clang: str,
    linker_flags: Optional[List[str]],
) -> pathlib.Path:
    stage2_modules: List[pathlib.Path] = []
    aggregator: Optional[bootstrap_stage2.DiagnosticAggregator] = None

    if not skip_build:
        _run_stage1_compile(stage1_output)
        stage2_modules, aggregator = _run_stage2_bootstrap(
            stage2_output, quiet=quiet, validate=True)
    else:
        if not stage2_output.exists():
            raise Stage2PackageError(
                "Stage2 output directory does not exist; run the bootstrap first")

    staging_root = pathlib.Path(tempfile.mkdtemp(prefix="sailfin-stage2-"))
    try:
        archive_root = staging_root / f"sailfin-stage2-{target_label}"
        artifacts_dir = archive_root / "artifacts"
        artifacts_dir.parent.mkdir(parents=True, exist_ok=True)
        shutil.copytree(stage2_output, artifacts_dir)

        inventory = _gather_artifact_inventory(artifacts_dir)
        metadata_path = archive_root / "metadata.json"
        metadata = _write_metadata(
            metadata_path,
            version=version,
            target_label=target_label,
            aggregator=aggregator,
            artifacts=inventory,
        )
        _write_readme(archive_root / "README.md", target_label=target_label)

        if link_binary:
            if not stage2_modules:
                inferred_modules = sorted(stage2_output.glob("*.ll"))
                if not inferred_modules:
                    raise Stage2PackageError(
                        "no LLVM modules found to link into a binary")
                stage2_modules = inferred_modules

            bin_dir = archive_root / "bin"
            bin_dir.mkdir(parents=True, exist_ok=True)
            output_binary = bin_dir / "sailfin-stage2"
            try:
                link_stage2_binary(stage2_modules, output_binary,
                                   clang=clang, extra_flags=linker_flags)
            except Stage1CompileError as exc:
                raise Stage2PackageError(str(exc)) from exc

        output_dir = output_dir.resolve()
        output_dir.mkdir(parents=True, exist_ok=True)
        archive_name = f"sailfin-stage2-{target_label}-{version}.tar.gz"
        archive_path = _create_archive(archive_root, output_dir / archive_name)
        archive_sha = _compute_sha256(archive_path)
        _write_sha256_sidecar(archive_path, archive_sha)
        archive_stem = archive_name[:-len(".tar.gz")] if archive_name.endswith(".tar.gz") else archive_path.stem
        _write_manifest_sidecar(output_dir, archive_stem,
                                archive_name, archive_sha, metadata)
        return archive_path
    finally:
        shutil.rmtree(staging_root, ignore_errors=True)


def _parse_args(argv: Iterable[str] | None = None) -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Package Sailfin Stage2 LLVM artifacts")
    parser.add_argument("--out", dest="out", type=pathlib.Path, default=REPO_ROOT / "dist",
                        help="Directory to receive the packaged archive (default: dist/)")
    parser.add_argument("--stage1-out", dest="stage1_out", type=pathlib.Path,
                        default=REPO_ROOT / "compiler" / "build",
                        help="Directory for Stage1 Python outputs (default: compiler/build)")
    parser.add_argument("--stage2-out", dest="stage2_out", type=pathlib.Path,
                        default=REPO_ROOT / "build" / "stage2",
                        help="Directory containing Stage2 LLVM outputs (default: build/stage2)")
    parser.add_argument("--version", dest="version",
                        help="Override the version string for the archive name")
    parser.add_argument("--target", dest="target",
                        help="Override the target label (default: auto-detected)")
    parser.add_argument("--clang", dest="clang", default=os.environ.get("SAILFIN_STAGE2_CLANG", "clang"),
                        help="clang executable to use when linking a Stage2 binary (default: clang)")
    parser.add_argument("--ldflag", dest="ldflags", action="append",
                        help="Additional linker flags when producing the Stage2 binary (repeatable)")
    parser.add_argument("--quiet", action="store_true",
                        help="Suppress verbose Stage2 bootstrap output")
    parser.add_argument("--skip-build", dest="skip_build", action="store_true",
                        help="Skip rebuilding Stage1/Stage2 and package existing artifacts")
    parser.add_argument("--link-binary", dest="link_binary", action="store_true",
                        help="Attempt to link a Stage2 binary into the archive (experimental)")
    return parser.parse_args(list(argv) if argv is not None else None)


def main(argv: Iterable[str] | None = None) -> int:
    args = _parse_args(argv)

    version = args.version or _infer_version()
    try:
        target_label = args.target or target_label_for_host()
        archive_path = package_stage2(
            output_dir=args.out,
            stage1_output=args.stage1_out,
            stage2_output=args.stage2_out,
            version=version,
            target_label=target_label,
            quiet=args.quiet,
            skip_build=args.skip_build,
            link_binary=args.link_binary,
            clang=args.clang,
            linker_flags=args.ldflags,
        )
    except (Stage1CompileError, Stage2PackageError) as exc:
        print(f"[stage2-package][error] {exc}", file=sys.stderr)
        return 1

    print(f"[stage2-package] wrote {archive_path}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
