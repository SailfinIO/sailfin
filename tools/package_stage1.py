"""Build a distributable archive of the Sailfin stage1 compiler."""

from __future__ import annotations

import argparse
import datetime as _dt
import json
import pathlib
import shutil
import stat
import subprocess
import sys
import tempfile
import textwrap
import zipfile
from typing import Iterable, List

REPO_ROOT = pathlib.Path(__file__).resolve().parents[1]
if str(REPO_ROOT) not in sys.path:
    sys.path.insert(0, str(REPO_ROOT))

from tools.compile_with_stage1 import Stage1CompileError, compile_stage1

DEFAULT_DIST_DIR = REPO_ROOT / "dist"


def build_stage1_artifact(output_dir: pathlib.Path, *, version: str | None = None,
                          archive_name: str | None = None) -> pathlib.Path:
    """Compile stage1 and package the runtime into a zip archive.

    Args:
        output_dir: Directory that will receive the zip file.
        version: Optional explicit version string for the artifact name/metadata.
        archive_name: Optional exact filename (should end in .zip). Overrides the
            default naming convention derived from *version*.

    Returns:
        Path to the generated zip archive.
    """

    output_dir = output_dir.resolve()
    output_dir.mkdir(parents=True, exist_ok=True)

    resolved_version = version or _infer_version()
    timestamp = _dt.datetime.now(_dt.UTC).replace(microsecond=0).isoformat()
    archive_filename = archive_name
    if archive_filename is None:
        archive_filename = f"sailfin-stage1-{resolved_version}.zip"
    archive_path = output_dir / archive_filename

    with tempfile.TemporaryDirectory(prefix="sailfin-stage1-") as tmp_dir:
        tmp_root = pathlib.Path(tmp_dir)
        stage1_output = tmp_root / "compiler" / "build"
        stage1_output.parent.mkdir(parents=True, exist_ok=True)

        _run_stage1_compile(stage1_output)

        staging_root = tmp_root / "package"
        staging_root.mkdir(parents=True, exist_ok=True)

        target_build_dir = staging_root / "compiler" / "build"
        target_build_dir.parent.mkdir(parents=True, exist_ok=True)
        shutil.copytree(stage1_output, target_build_dir)

        runtime_src = REPO_ROOT / "runtime"
        if not runtime_src.exists():
            raise FileNotFoundError(f"Runtime package not found at {runtime_src}")
        shutil.copytree(runtime_src, staging_root / "runtime")

        _write_metadata(staging_root, version=resolved_version, generated_at=timestamp)
        _write_stage1_driver(staging_root)
        launcher_path = _write_cli_launcher(staging_root)
        _write_readme(staging_root, resolved_version)

        with zipfile.ZipFile(archive_path, mode="w", compression=zipfile.ZIP_DEFLATED) as zf:
            for path in sorted(staging_root.rglob("*")):
                if path.is_dir():
                    continue
                relative = path.relative_to(staging_root)
                info = zipfile.ZipInfo.from_file(path, relative.as_posix())
                if path == launcher_path:
                    info.external_attr = (stat.S_IFREG | 0o755) << 16
                with path.open("rb") as handle:
                    zf.writestr(info, handle.read())

    return archive_path


def _run_stage1_compile(output_dir: pathlib.Path) -> None:
    try:
        compile_stage1([REPO_ROOT / "compiler" / "src", REPO_ROOT / "runtime"], output_dir)
    except Stage1CompileError as exc:  # pragma: no cover - exercised via tests
        raise RuntimeError(f"stage1 compile failed: {exc}") from exc


def _write_metadata(staging_root: pathlib.Path, *, version: str, generated_at: str) -> None:
    metadata = {
        "version": version,
        "commit": _infer_commit_hash(),
        "generated_at": generated_at,
    }
    (staging_root / "metadata.json").write_text(
        json.dumps(metadata, indent=2, sort_keys=True) + "\n",
        encoding="utf-8",
    )


def _write_stage1_driver(staging_root: pathlib.Path) -> None:
    driver_path = staging_root / "stage1_compile.py"
    driver_source = textwrap.dedent("""\
        #!/usr/bin/env python3
        # Compile Sailfin sources using the packaged stage1 compiler.

        from __future__ import annotations

        import argparse
        import pathlib
        import sys
        from typing import Iterable, List

        PACKAGE_ROOT = pathlib.Path(__file__).resolve().parent
        if str(PACKAGE_ROOT) not in sys.path:
            sys.path.insert(0, str(PACKAGE_ROOT))

        from compiler.build import main as stage1_main


        def _iter_sources(values: Iterable[str]) -> List[pathlib.Path]:
            resolved: List[pathlib.Path] = []
            for value in values:
                path = pathlib.Path(value)
                if path.is_dir():
                    resolved.extend(sorted(path.rglob("*.sfn")))
                else:
                    resolved.append(path)
            return [item.resolve() for item in resolved]


        def main(argv: Iterable[str] | None = None) -> int:
            parser = argparse.ArgumentParser(description="Compile Sailfin .sfn sources using the stage1 pipeline")
            parser.add_argument("paths", nargs="+", help="Files or directories of .sfn inputs")
            parser.add_argument(
                "--out",
                dest="output",
                type=pathlib.Path,
                required=True,
                help="Directory to receive generated Python modules",
            )
            args = parser.parse_args(list(argv) if argv is not None else None)

            sources = _iter_sources(args.paths)
            if not sources:
                raise SystemExit("No sources matched the provided arguments")

            args.output.mkdir(parents=True, exist_ok=True)

            result = stage1_main.compile_project([str(source) for source in sources])
            diagnostics = getattr(result, "diagnostics", [])
            fatal = [entry for entry in diagnostics if getattr(entry, "fatal", False)]
            if fatal:
                for entry in fatal:
                    source_path = getattr(entry, "source_path", "<unknown>")
                    for message in getattr(entry, "messages", []):
                        print(f"[stage1][error] {source_path}: {message}")
                raise SystemExit("Compilation aborted due to fatal diagnostics")

            modules = getattr(result, "modules", [])
            for module in modules:
                source_path = pathlib.Path(getattr(module, "source_path"))
                python_source = getattr(module, "python_source", None)
                if python_source is None:
                    raise SystemExit(f"Missing python_source for module {module}")
                destination = args.output / source_path.with_suffix(".py").name
                destination.write_text(python_source, encoding="utf-8")

            for entry in diagnostics:
                if getattr(entry, "fatal", False):
                    continue
                source_path = getattr(entry, "source_path", "<unknown>")
                for message in getattr(entry, "messages", []):
                    print(f"[stage1][warn] {source_path}: {message}")

            return 0


        if __name__ == "__main__":
            raise SystemExit(main())
    """)
    driver_path.write_text(driver_source, encoding="utf-8")
    driver_path.chmod(0o755)


def _write_cli_launcher(staging_root: pathlib.Path) -> pathlib.Path:
    bin_dir = staging_root / "bin"
    bin_dir.mkdir(parents=True, exist_ok=True)
    launcher_path = bin_dir / "sailfin-stage1"
    launcher_source = textwrap.dedent("""\
        #!/usr/bin/env python3
        \"\"\"CLI entry point for the Sailfin stage1 compiler.\"\"\"

        from __future__ import annotations

        import pathlib
        import sys

        ARTIFACT_ROOT = pathlib.Path(__file__).resolve().parents[1]
        if str(ARTIFACT_ROOT) not in sys.path:
            sys.path.insert(0, str(ARTIFACT_ROOT))

        from stage1_compile import main as driver_main


        def _run() -> int:
            return driver_main(sys.argv[1:])


        if __name__ == "__main__":
            raise SystemExit(_run())
    """)
    launcher_path.write_text(launcher_source, encoding="utf-8")
    launcher_path.chmod(0o755)
    return launcher_path


def _write_readme(staging_root: pathlib.Path, version: str) -> None:
    readme_path = staging_root / "README.md"
    readme_contents = f"""# Sailfin Stage1 Compiler ({version})

This archive contains the Python modules emitted by the Sailfin stage1
self-hosting compiler along with the runtime helpers required to execute the
pipeline.

## Contents

- `compiler/build/` – Generated Python modules comprising the stage1 compiler.
- `runtime/` – Python runtime helpers used by stage1-generated programs.
- `stage1_compile.py` – Convenience CLI to compile Sailfin `.sfn` sources with this
  bundle.
- `bin/sailfin-stage1` – Executable launcher that adds this bundle to `PYTHONPATH`
    automatically.
- `metadata.json` – Build metadata (version, commit hash, timestamp).

## Usage

1. Extract the archive: `unzip sailfin-stage1-{version}.zip`.
2. (Optional) Add the `bin/` directory to your `PATH` to get the `sailfin-stage1`
     command.
3. Run the compiler, either via the launcher (`sailfin-stage1 compiler/src --out out_dir`)
     or directly (`python stage1_compile.py compiler/src --out out_dir`).

## Support

This artifact is intended for experimentation while the Sailfin compiler
completes its self-hosting transition. Report issues at
https://github.com/SailfinIO/sailfin/issues.
"""
    readme_path.write_text(readme_contents, encoding="utf-8")


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
        output = subprocess.check_output(
            [
                "git",
                "describe",
                "--tags",
                "--always",
                "--dirty",
            ],
            cwd=REPO_ROOT,
            text=True,
        )
        return output.strip().replace("/", "-")
    except Exception:
        return "dev"


def _infer_commit_hash() -> str:
    try:
        output = subprocess.check_output(["git", "rev-parse", "HEAD"], cwd=REPO_ROOT, text=True)
        return output.strip()
    except Exception:
        return "unknown"


def _parse_args(argv: Iterable[str] | None = None) -> argparse.Namespace:
    parser = argparse.ArgumentParser(description="Package the Sailfin stage1 compiler into a zip archive")
    parser.add_argument("--out", dest="out", type=pathlib.Path, default=DEFAULT_DIST_DIR,
                        help="Directory to receive the packaged artifact (default: dist/)")
    parser.add_argument("--version", dest="version", help="Override the version string for the artifact")
    parser.add_argument("--name", dest="name", help="Override the zip filename (should end with .zip)")
    return parser.parse_args(list(argv) if argv is not None else None)


def main(argv: Iterable[str] | None = None) -> int:
    args = _parse_args(argv)
    archive_path = build_stage1_artifact(args.out, version=args.version, archive_name=args.name)
    print(f"[package] wrote {archive_path}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
