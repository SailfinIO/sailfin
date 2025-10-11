#!/usr/bin/env python3
"""Download and install the latest Sailfin stage1 compiler artifact.

This script fetches the stage1 release asset from the Sailfin repository and
extracts it into a local installation directory.  It optionally creates a
symlink in a user bin directory so the `sailfin-stage1` command is on PATH.
"""

from __future__ import annotations

import argparse
import json
import os
import pathlib
import shutil
import sys
import tempfile
import urllib.error
import urllib.request
import zipfile
from typing import Optional

REPO_SLUG = "SailfinIO/sailfin"
ARTIFACT_PREFIX = "sailfin-stage1-"
ARTIFACT_SUFFIX = ".zip"
DEFAULT_INSTALL_ROOT = pathlib.Path("~/.local/share/sailfin-stage1").expanduser()
DEFAULT_BIN_DIR = pathlib.Path("~/.local/bin").expanduser()
API_VERSION = "2022-11-28"
USER_AGENT = "sailfin-stage1-installer/1.0"


class InstallerError(RuntimeError):
    pass


def parse_args(argv: Optional[list[str]] = None) -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description="Install the Sailfin stage1 compiler from the latest GitHub release",
    )
    parser.add_argument(
        "--version",
        help="Install a specific release version (for example 0.3.1)."
        " If omitted, the latest release is used.",
    )
    parser.add_argument(
        "--tag",
        help="Install a specific release tag (overrides --version).",
    )
    parser.add_argument(
        "--repo",
        default=REPO_SLUG,
        help=f"GitHub repository slug to pull from (default: {REPO_SLUG}).",
    )
    parser.add_argument(
        "--install-dir",
        type=pathlib.Path,
        default=DEFAULT_INSTALL_ROOT,
        help=f"Directory where releases should be unpacked (default: {DEFAULT_INSTALL_ROOT}).",
    )
    parser.add_argument(
        "--bin-dir",
        type=pathlib.Path,
        default=DEFAULT_BIN_DIR,
        help=f"Directory that should receive/point to the sailfin-stage1 launcher (default: {DEFAULT_BIN_DIR}).",
    )
    parser.add_argument(
        "--token",
        default=os.getenv("GITHUB_TOKEN"),
        help="GitHub personal access token. Defaults to the GITHUB_TOKEN environment variable.",
    )
    parser.add_argument(
        "--force",
        action="store_true",
        help="Overwrite any existing installation and launcher symlink.",
    )
    parser.add_argument(
        "--no-link",
        action="store_true",
        help="Skip creating the symlink in --bin-dir.",
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Fetch release metadata without downloading or installing the archive.",
    )
    return parser.parse_args(argv)


def normalize_tag(args: argparse.Namespace) -> Optional[str]:
    if args.tag and args.version:
        raise InstallerError("Specify either --tag or --version, not both.")
    if args.tag:
        return args.tag
    if args.version:
        version = args.version
        return version if version.startswith("v") else f"v{version}"
    return None


def build_headers(token: Optional[str], accept: str) -> dict[str, str]:
    headers = {
        "Accept": accept,
        "User-Agent": USER_AGENT,
        "X-GitHub-Api-Version": API_VERSION,
    }
    if token:
        headers["Authorization"] = f"Bearer {token}"
    return headers


def github_request(url: str, token: Optional[str], *, accept: str = "application/vnd.github+json") -> bytes:
    request = urllib.request.Request(url, headers=build_headers(token, accept))
    try:
        with urllib.request.urlopen(request) as response:
            return response.read()
    except urllib.error.HTTPError as exc:  # pragma: no cover - network specific
        message = exc.read().decode("utf-8", errors="replace")
        raise InstallerError(f"GitHub API request failed: {exc.code} {exc.reason}: {message}") from exc
    except urllib.error.URLError as exc:  # pragma: no cover - network specific
        raise InstallerError(f"Network error contacting GitHub: {exc}") from exc


def resolve_release(repo: str, token: Optional[str], tag: Optional[str]) -> dict[str, object]:
    base = f"https://api.github.com/repos/{repo}/releases"
    if tag:
        url = f"{base}/tags/{tag}"
    else:
        url = f"{base}/latest"
    payload = github_request(url, token)
    return json.loads(payload)


def find_stage1_asset(release: dict[str, object]) -> dict[str, object]:
    assets = release.get("assets", []) or []
    for asset in assets:
        name = asset.get("name", "")
        if name.startswith(ARTIFACT_PREFIX) and name.endswith(ARTIFACT_SUFFIX):
            return asset
    tag_name = release.get("tag_name", "<unknown>")
    raise InstallerError(f"No stage1 artifact found in release {tag_name!r}.")


def download_asset(asset: dict[str, object], token: Optional[str]) -> pathlib.Path:
    asset_url = asset.get("url")
    if not asset_url:
        raise InstallerError("Release asset is missing a download URL.")

    tmp_dir = pathlib.Path(tempfile.mkdtemp(prefix="sailfin-stage1-download-"))
    tmp_path = tmp_dir / asset.get("name", "stage1.zip")

    # The asset API requires the octet-stream accept header.
    data = github_request(asset_url, token, accept="application/octet-stream")
    tmp_path.write_bytes(data)
    return tmp_path


def extract_archive(archive_path: pathlib.Path, target_dir: pathlib.Path, *, force: bool) -> None:
    if target_dir.exists():
        if not force:
            raise InstallerError(f"Install directory {target_dir} already exists. Use --force to overwrite.")
        shutil.rmtree(target_dir)
    target_dir.mkdir(parents=True, exist_ok=True)

    with zipfile.ZipFile(archive_path) as zf:
        zf.extractall(target_dir)
        for member in zf.infolist():
            permissions = member.external_attr >> 16
            if not permissions:
                continue
            out_path = target_dir / member.filename
            if out_path.exists():
                out_path.chmod(permissions)


def ensure_symlink(bin_dir: pathlib.Path, target_launcher: pathlib.Path, *, force: bool) -> pathlib.Path:
    bin_dir.mkdir(parents=True, exist_ok=True)
    link_path = bin_dir / target_launcher.name
    if link_path.exists() or link_path.is_symlink():
        if not force:
            raise InstallerError(f"Launcher already exists at {link_path}. Use --force to replace it.")
        link_path.unlink()
    link_path.symlink_to(target_launcher)
    return link_path


def install(args: argparse.Namespace) -> None:
    token = args.token
    if not token:
        raise InstallerError("A GitHub token is required for this private repository. Set GITHUB_TOKEN or pass --token.")

    tag = normalize_tag(args)
    release = resolve_release(args.repo, token, tag)
    tag_name = release.get("tag_name")
    print(f"[sailfin] Selected release: {tag_name}")

    if args.dry_run:
        asset = find_stage1_asset(release)
        print("[sailfin] Available artifact:", asset.get("name"))
        return

    asset = find_stage1_asset(release)
    archive_path = download_asset(asset, token)
    try:
        install_root = args.install_dir.expanduser().resolve()
        target_dir = install_root / str(tag_name)
        extract_archive(archive_path, target_dir, force=args.force)
        print(f"[sailfin] Installed stage1 to {target_dir}")

        launcher = target_dir / "bin" / "sailfin-stage1"
        if not launcher.exists():
            raise InstallerError(f"Launcher missing from install at {launcher}")

        link_path: Optional[pathlib.Path] = None
        if not args.no_link:
            bin_dir = args.bin_dir.expanduser().resolve()
            link_path = ensure_symlink(bin_dir, launcher, force=args.force)
            print(f"[sailfin] Symlinked launcher to {link_path}")
        else:
            print("[sailfin] Skipped symlink creation (--no-link).")

        path_hint = link_path.parent if link_path else launcher.parent
        print("[sailfin] Done. Ensure your PATH includes:")
        print(f"  - {path_hint}")

    finally:
        try:
            archive_path.unlink()
            archive_path.parent.rmdir()
        except Exception:
            pass


def main(argv: Optional[list[str]] = None) -> int:
    args = parse_args(argv)
    try:
        install(args)
    except InstallerError as exc:
        print(f"[sailfin][error] {exc}", file=sys.stderr)
        return 1
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
