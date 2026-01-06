#!/usr/bin/env python3
"""Download a released Stage2 binary to use as a self-host seed.

This is intended for CI:
- Release workflow: download the *previous* release asset as the seed, then
  rebuild the compiler self-hosted and publish that output.
- Build workflow: optionally validate that HEAD can selfhost from the latest
  released seed, without relying on the stage1/bootstrap pipeline.

Asset naming convention (see README):
  sailfin-stage2_<version>_<os>_<arch>.tar.gz

The archive is expected to contain:
  bin/sailfin-stage2 (or .exe)

Usage examples:
  python tools/download_stage2_seed.py --os linux --arch x86_64 --out build/seed
  python tools/download_stage2_seed.py --previous-of v0.1.1-alpha.88 --os macos --arch arm64 --out build/seed
"""

from __future__ import annotations

import argparse
import json
import os
import pathlib
import sys
import tarfile
import urllib.request
from typing import Any, Dict, List, Optional, Tuple


def _github_api_json(url: str, *, token: str | None) -> Any:
    headers = {
        "Accept": "application/vnd.github+json",
        "User-Agent": "sailfin-ci-seed-fetcher",
    }
    if token:
        headers["Authorization"] = f"Bearer {token}"
    req = urllib.request.Request(url, headers=headers)
    with urllib.request.urlopen(req, timeout=60) as resp:
        data = resp.read().decode("utf-8")
    return json.loads(data)


def _download_file(url: str, dest: pathlib.Path, *, token: str | None) -> None:
    headers = {
        "Accept": "application/octet-stream",
        "User-Agent": "sailfin-ci-seed-fetcher",
    }
    if token:
        headers["Authorization"] = f"Bearer {token}"
    req = urllib.request.Request(url, headers=headers)
    dest.parent.mkdir(parents=True, exist_ok=True)
    with urllib.request.urlopen(req, timeout=300) as resp:
        with dest.open("wb") as out:
            while True:
                chunk = resp.read(1024 * 1024)
                if not chunk:
                    break
                out.write(chunk)


def _resolve_repo(repo: str | None) -> str:
    if repo:
        return repo
    env_repo = os.environ.get("GITHUB_REPOSITORY")
    if env_repo:
        return env_repo
    raise SystemExit("missing --repo (or set GITHUB_REPOSITORY)")


def _pick_release_tag(
    *,
    repo: str,
    token: str | None,
    tag: str | None,
    previous_of: str | None,
) -> Tuple[str, str]:
    """Return (tag_name, version_without_v_prefix)."""

    if tag and previous_of:
        raise SystemExit("use only one of --tag or --previous-of")

    if tag:
        tag_name = tag
    elif previous_of:
        # List releases and choose the first one not equal to `previous_of`.
        releases: List[Dict[str, Any]] = _github_api_json(
            f"https://api.github.com/repos/{repo}/releases?per_page=50",
            token=token,
        )
        target = previous_of
        for rel in releases:
            rel_tag = rel.get("tag_name")
            if rel_tag and rel_tag != target:
                tag_name = str(rel_tag)
                break
        else:
            raise SystemExit(
                f"no previous release found for repo {repo} (excluding {target})"
            )
    else:
        latest = _github_api_json(
            f"https://api.github.com/repos/{repo}/releases/latest",
            token=token,
        )
        tag_name = str(latest.get("tag_name") or "")
        if not tag_name:
            raise SystemExit(
                f"could not resolve latest release tag for {repo}")

    version = tag_name[1:] if tag_name.startswith("v") else tag_name
    if not version:
        raise SystemExit(f"invalid tag: {tag_name!r}")
    return tag_name, version


def _find_asset(
    *,
    repo: str,
    token: str | None,
    tag: str,
    expected_name: str,
) -> Dict[str, Any]:
    rel = _github_api_json(
        f"https://api.github.com/repos/{repo}/releases/tags/{tag}",
        token=token,
    )
    assets = rel.get("assets") or []
    for asset in assets:
        if asset.get("name") == expected_name:
            return asset
    available = [a.get("name") for a in assets if a.get("name")]
    raise SystemExit(
        "seed asset not found\n"
        f"  repo: {repo}\n"
        f"  tag: {tag}\n"
        f"  expected: {expected_name}\n"
        f"  available: {available}\n"
    )


def _extract_tar_gz(archive: pathlib.Path, out_dir: pathlib.Path) -> None:
    out_dir.mkdir(parents=True, exist_ok=True)
    with tarfile.open(archive, mode="r:gz") as tf:
        tf.extractall(path=out_dir)


def main(argv: Optional[List[str]] = None) -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--repo", help="owner/repo (default: GITHUB_REPOSITORY)")
    parser.add_argument(
        "--tag", help="release tag to download (e.g. v0.1.1-alpha.88)")
    parser.add_argument(
        "--previous-of",
        help="download the most recent release not equal to this tag",
    )
    parser.add_argument("--os", required=True,
                        help="asset os label (e.g. linux, macos)")
    parser.add_argument("--arch", required=True,
                        help="asset arch label (e.g. x86_64, arm64)")
    parser.add_argument(
        "--out",
        type=pathlib.Path,
        required=True,
        help="output directory to extract the seed archive into",
    )
    parser.add_argument(
        "--token",
        default=os.environ.get("GITHUB_TOKEN") or os.environ.get("GH_TOKEN"),
        help="GitHub token (default: GITHUB_TOKEN/GH_TOKEN)",
    )

    args = parser.parse_args(argv)

    repo = _resolve_repo(args.repo)
    tag_name, version = _pick_release_tag(
        repo=repo,
        token=args.token,
        tag=args.tag,
        previous_of=args.previous_of,
    )

    archive_name = f"sailfin-stage2_{version}_{args.os}_{args.arch}.tar.gz"
    asset = _find_asset(repo=repo, token=args.token,
                        tag=tag_name, expected_name=archive_name)
    url = str(asset.get("browser_download_url") or "")
    if not url:
        raise SystemExit(
            f"missing browser_download_url for asset {archive_name}")

    out_dir = args.out.resolve()
    out_dir.mkdir(parents=True, exist_ok=True)
    archive_path = out_dir / archive_name

    print(f"[seed] repo={repo} tag={tag_name} asset={archive_name}")
    _download_file(url, archive_path, token=args.token)
    _extract_tar_gz(archive_path, out_dir)

    exe = "sailfin-stage2.exe" if args.os == "windows" else "sailfin-stage2"
    seed_bin = out_dir / "bin" / exe
    if not seed_bin.exists():
        raise SystemExit(f"seed binary not found after extract: {seed_bin}")

    # Emit a single line that bash can parse if needed.
    print(str(seed_bin))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
