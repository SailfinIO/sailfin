#!/usr/bin/env python3
"""Build, validate, and Ed25519-sign Sailfin's canonical toolchain index."""

from __future__ import annotations

import argparse
import datetime as dt
import hashlib
import json
import os
from pathlib import Path
import re
import subprocess
import sys
import tempfile
from typing import Any


INDEX_SCHEMA = "sailfin-toolchain-index/1"
STATE_SCHEMA = "sailfin-toolchain-index-state/1"
TRANSITION_SCHEMA = "sailfin-toolchain-key-transition/1"
CHANNELS = ("stable", "rc", "beta", "alpha")
HOST_ASSETS = {
    "aarch64-apple-darwin": "macos_arm64",
    "aarch64-unknown-linux-gnu": "linux_arm64",
    "x86_64-pc-windows-msvc": "windows_x86_64-msvc",
    "x86_64-unknown-linux-gnu": "linux_x86_64",
    "x86_64-w64-mingw32": "windows_x86_64",
}
HEX64 = re.compile(r"^[0-9a-f]{64}$")
HEX128 = re.compile(r"^[0-9a-f]{128}$")
SEMVER = re.compile(
    r"^(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)\.(0|[1-9][0-9]*)"
    r"(?:-(alpha|beta|rc)\.(0|[1-9][0-9]*))?$"
)
RFC3339 = re.compile(r"^[0-9]{4}-[0-9]{2}-[0-9]{2}T[0-9]{2}:[0-9]{2}:[0-9]{2}Z$")
RANGE_TERM = re.compile(r"^(?:<=|>=|<|>|=)?(?:0|[1-9][0-9]*)\.(?:0|[1-9][0-9]*)\.(?:0|[1-9][0-9]*)(?:-(?:alpha|beta|rc)\.(?:0|[1-9][0-9]*))?$")
SPKI_ED25519_PREFIX = bytes.fromhex("302a300506032b6570032100")


class IndexError(ValueError):
    pass


def fail(message: str) -> None:
    raise IndexError(message)


def reject_duplicate_keys(pairs: list[tuple[str, Any]]) -> dict[str, Any]:
    result: dict[str, Any] = {}
    for key, value in pairs:
        if key in result:
            fail(f"JSON contains duplicate object key {key!r}")
        result[key] = value
    return result


def parse_json_bytes(raw: bytes, label: str) -> Any:
    try:
        text = raw.decode("utf-8")
        return json.loads(text, object_pairs_hook=reject_duplicate_keys)
    except (UnicodeDecodeError, json.JSONDecodeError) as exc:
        fail(f"{label} is not readable JSON: {exc}")


def load_bytes(path: Path, label: str) -> bytes:
    try:
        return path.read_bytes()
    except OSError as exc:
        fail(f"{label} is unreadable: {exc}")


def load_json(path: Path, label: str) -> Any:
    return parse_json_bytes(load_bytes(path, label), label)


def require_object(value: Any, label: str) -> dict[str, Any]:
    if not isinstance(value, dict):
        fail(f"{label} must be an object")
    return value


def require_keys(
    value: dict[str, Any], label: str, required: set[str], allowed: set[str]
) -> None:
    missing = sorted(required - value.keys())
    unknown = sorted(value.keys() - allowed)
    if missing:
        fail(f"{label} is missing required fields: {', '.join(missing)}")
    if unknown:
        fail(f"{label} has unknown fields: {', '.join(unknown)}")


def require_string(value: Any, label: str) -> str:
    if not isinstance(value, str) or not value:
        fail(f"{label} must be a non-empty string")
    return value


def parse_timestamp(value: Any, label: str) -> dt.datetime:
    text = require_string(value, label)
    if not RFC3339.fullmatch(text):
        fail(f"{label} must be RFC3339 UTC with whole seconds")
    try:
        return dt.datetime.strptime(text, "%Y-%m-%dT%H:%M:%SZ").replace(
            tzinfo=dt.timezone.utc
        )
    except ValueError as exc:
        fail(f"{label} is invalid: {exc}")


def validate_version(value: Any, label: str) -> str:
    text = require_string(value, label)
    if not SEMVER.fullmatch(text):
        fail(f"{label} must be an exact Sailfin release semver without build metadata")
    return text


def version_channel(version: str) -> str:
    match = SEMVER.fullmatch(version)
    assert match is not None
    return match.group(4) or "stable"


def version_sort_key(version: str) -> tuple[int, int, int, int, int]:
    match = SEMVER.fullmatch(version)
    assert match is not None
    rank = {"alpha": 0, "beta": 1, "rc": 2, None: 3}[match.group(4)]
    number = int(match.group(5) or 0)
    return (int(match.group(1)), int(match.group(2)), int(match.group(3)), rank, number)


def validate_public_key(public_key: Any, label: str) -> str:
    text = require_string(public_key, label)
    if not HEX64.fullmatch(text):
        fail(f"{label} must be 64 lowercase hexadecimal characters")
    return text


def key_id_for(public_key: str) -> str:
    return "ed25519:" + public_key


def validate_key_record(value: Any, label: str) -> dict[str, str]:
    record = require_object(value, label)
    require_keys(record, label, {"key_id", "public_key"}, {"key_id", "public_key"})
    public_key = validate_public_key(record["public_key"], f"{label}.public_key")
    key_id = require_string(record["key_id"], f"{label}.key_id")
    if key_id != key_id_for(public_key):
        fail(f"{label}.key_id does not identify its public key")
    return {"key_id": key_id, "public_key": public_key}


def canonical_bytes(value: Any) -> bytes:
    return (
        json.dumps(value, ensure_ascii=False, separators=(",", ":"), sort_keys=True)
        + "\n"
    ).encode("utf-8")


def transition_message(record: dict[str, Any]) -> bytes:
    return canonical_bytes(
        {
            "effective_sequence": record["effective_sequence"],
            "from_key_id": record["from_key_id"],
            "schema_version": TRANSITION_SCHEMA,
            "to_key_id": record["to_key_id"],
            "to_public_key": record["to_public_key"],
        }
    )


def openssl_verify(public_key: str, payload: bytes, signature_hex: str) -> bool:
    if not HEX128.fullmatch(signature_hex):
        return False
    with tempfile.TemporaryDirectory(prefix="sailfin-index-verify-") as temp:
        root = Path(temp)
        public_der = root / "public.der"
        message = root / "message"
        signature = root / "signature"
        public_der.write_bytes(SPKI_ED25519_PREFIX + bytes.fromhex(public_key))
        message.write_bytes(payload)
        signature.write_bytes(bytes.fromhex(signature_hex))
        result = subprocess.run(
            [
                "openssl",
                "pkeyutl",
                "-verify",
                "-pubin",
                "-keyform",
                "DER",
                "-inkey",
                str(public_der),
                "-rawin",
                "-in",
                str(message),
                "-sigfile",
                str(signature),
            ],
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
            check=False,
        )
        return result.returncode == 0


def openssl_sign(private_key: Path, payload: bytes) -> str:
    with tempfile.TemporaryDirectory(prefix="sailfin-index-sign-") as temp:
        root = Path(temp)
        message = root / "message"
        signature = root / "signature"
        message.write_bytes(payload)
        result = subprocess.run(
            [
                "openssl",
                "pkeyutl",
                "-sign",
                "-inkey",
                str(private_key),
                "-rawin",
                "-in",
                str(message),
                "-out",
                str(signature),
            ],
            capture_output=True,
            text=True,
            check=False,
        )
        if result.returncode != 0:
            fail(f"openssl could not sign the toolchain index: {result.stderr.strip()}")
        raw = signature.read_bytes()
        if len(raw) != 64:
            fail(f"openssl produced an invalid Ed25519 signature length: {len(raw)}")
        return raw.hex()


def validate_transition(
    value: Any, label: str, known_keys: dict[str, str]
) -> dict[str, Any]:
    record = require_object(value, label)
    required = {
        "effective_sequence",
        "from_key_id",
        "signature",
        "to_key_id",
        "to_public_key",
    }
    require_keys(record, label, required, required)
    sequence = record["effective_sequence"]
    if not isinstance(sequence, int) or isinstance(sequence, bool) or sequence < 1:
        fail(f"{label}.effective_sequence must be a positive integer")
    from_key_id = require_string(record["from_key_id"], f"{label}.from_key_id")
    to_public_key = validate_public_key(record["to_public_key"], f"{label}.to_public_key")
    to_key_id = require_string(record["to_key_id"], f"{label}.to_key_id")
    if to_key_id != key_id_for(to_public_key):
        fail(f"{label}.to_key_id does not identify to_public_key")
    if from_key_id == to_key_id:
        fail(f"{label} cannot transition a key to itself")
    signature = require_string(record["signature"], f"{label}.signature")
    if not HEX128.fullmatch(signature):
        fail(f"{label}.signature must be 128 lowercase hexadecimal characters")
    from_public_key = known_keys.get(from_key_id)
    if from_public_key is None:
        fail(f"{label}.from_key_id is not a trusted root or earlier transition")
    normalized = {
        "effective_sequence": sequence,
        "from_key_id": from_key_id,
        "signature": signature,
        "to_key_id": to_key_id,
        "to_public_key": to_public_key,
    }
    if not openssl_verify(from_public_key, transition_message(normalized), signature):
        fail(f"{label}.signature does not authenticate the key transition")
    if to_key_id in known_keys and known_keys[to_key_id] != to_public_key:
        fail(f"{label}.to_key_id collides with another public key")
    known_keys[to_key_id] = to_public_key
    return normalized


def validate_state(value: Any) -> tuple[dict[str, Any], dict[str, str]]:
    state = require_object(value, "state")
    required = {
        "advisories",
        "key_transitions",
        "revocations",
        "schema_version",
        "signing_key",
        "trusted_root_keys",
        "yanks",
    }
    require_keys(state, "state", required, required)
    if state["schema_version"] != STATE_SCHEMA:
        fail(f"state.schema_version must be {STATE_SCHEMA}")
    roots = state["trusted_root_keys"]
    if not isinstance(roots, list) or not roots:
        fail("state.trusted_root_keys must be a non-empty array")
    known_keys: dict[str, str] = {}
    normalized_roots: list[dict[str, str]] = []
    for index, raw in enumerate(roots):
        record = validate_key_record(raw, f"state.trusted_root_keys[{index}]")
        if record["key_id"] in known_keys:
            fail("state.trusted_root_keys contains a duplicate key_id")
        known_keys[record["key_id"]] = record["public_key"]
        normalized_roots.append(record)
    transitions = state["key_transitions"]
    if not isinstance(transitions, list):
        fail("state.key_transitions must be an array")
    normalized_transitions: list[dict[str, Any]] = []
    last_sequence = 0
    active_transition_key: str | None = None
    for index, raw in enumerate(transitions):
        record = validate_transition(raw, f"state.key_transitions[{index}]", known_keys)
        if record["effective_sequence"] <= last_sequence:
            fail("state.key_transitions effective_sequence values must increase")
        if active_transition_key is not None and record["from_key_id"] != active_transition_key:
            fail("state.key_transitions must form one contiguous signing-key chain")
        last_sequence = record["effective_sequence"]
        active_transition_key = record["to_key_id"]
        normalized_transitions.append(record)
    signing_key = validate_key_record(state["signing_key"], "state.signing_key")
    if known_keys.get(signing_key["key_id"]) != signing_key["public_key"]:
        fail("state.signing_key is not authenticated by a trusted root/transition chain")
    if active_transition_key is not None and signing_key["key_id"] != active_transition_key:
        fail("state.signing_key must be the final authenticated transition key")

    normalized = {
        "advisories": validate_advisories(state["advisories"]),
        "key_transitions": normalized_transitions,
        "revocations": validate_revocations(state["revocations"]),
        "schema_version": STATE_SCHEMA,
        "signing_key": signing_key,
        "trusted_root_keys": sorted(normalized_roots, key=lambda item: item["key_id"]),
        "yanks": validate_yanks(state["yanks"]),
    }
    return normalized, known_keys


def validate_yanks(value: Any) -> list[dict[str, str]]:
    if not isinstance(value, list):
        fail("state.yanks must be an array")
    result: list[dict[str, str]] = []
    seen: set[str] = set()
    for index, raw in enumerate(value):
        label = f"state.yanks[{index}]"
        record = require_object(raw, label)
        fields = {"reason", "recorded_at", "version"}
        require_keys(record, label, fields, fields)
        version = validate_version(record["version"], f"{label}.version")
        if version in seen:
            fail(f"state.yanks repeats {version}")
        seen.add(version)
        parse_timestamp(record["recorded_at"], f"{label}.recorded_at")
        result.append(
            {
                "reason": require_string(record["reason"], f"{label}.reason"),
                "recorded_at": record["recorded_at"],
                "version": version,
            }
        )
    return sorted(result, key=lambda item: item["version"])


def validate_revocations(value: Any) -> list[dict[str, str]]:
    if not isinstance(value, list):
        fail("state.revocations must be an array")
    result: list[dict[str, str]] = []
    seen: set[tuple[str, str]] = set()
    for index, raw in enumerate(value):
        label = f"state.revocations[{index}]"
        record = require_object(raw, label)
        required = {"kind", "reason", "recorded_at", "subject"}
        require_keys(record, label, required, required)
        kind = require_string(record["kind"], f"{label}.kind")
        subject = require_string(record["subject"], f"{label}.subject")
        if kind == "release":
            validate_version(subject, f"{label}.subject")
        elif kind == "signing-key":
            if not subject.startswith("ed25519:") or not HEX64.fullmatch(subject[8:]):
                fail(f"{label}.subject must be an Ed25519 key identifier")
        else:
            fail(f"{label}.kind must be release or signing-key")
        identity = (kind, subject)
        if identity in seen:
            fail(f"state.revocations repeats {kind} {subject}")
        seen.add(identity)
        parse_timestamp(record["recorded_at"], f"{label}.recorded_at")
        result.append(
            {
                "kind": kind,
                "reason": require_string(record["reason"], f"{label}.reason"),
                "recorded_at": record["recorded_at"],
                "subject": subject,
            }
        )
    return sorted(result, key=lambda item: (item["kind"], item["subject"]))


def validate_advisories(value: Any) -> list[dict[str, Any]]:
    if not isinstance(value, list):
        fail("state.advisories must be an array")
    result: list[dict[str, Any]] = []
    seen: set[str] = set()
    for index, raw in enumerate(value):
        label = f"state.advisories[{index}]"
        record = require_object(raw, label)
        required = {
            "affected",
            "fixed_version",
            "id",
            "severity",
            "summary",
            "url",
        }
        require_keys(record, label, required, required)
        advisory_id = require_string(record["id"], f"{label}.id")
        if advisory_id in seen:
            fail(f"state.advisories repeats {advisory_id}")
        seen.add(advisory_id)
        severity = require_string(record["severity"], f"{label}.severity")
        if severity not in {"low", "moderate", "high", "critical"}:
            fail(f"{label}.severity is invalid")
        affected = require_string(record["affected"], f"{label}.affected")
        affected_terms = affected.split()
        if not affected_terms or not all(
            RANGE_TERM.fullmatch(term) for term in affected_terms
        ):
            fail(f"{label}.affected must be a space-separated exact/comparator range")
        fixed_version = record["fixed_version"]
        if fixed_version is not None:
            fixed_version = validate_version(fixed_version, f"{label}.fixed_version")
        url = require_string(record["url"], f"{label}.url")
        if not url.startswith("https://"):
            fail(f"{label}.url must use https")
        result.append(
            {
                "affected": affected,
                "fixed_version": fixed_version,
                "id": advisory_id,
                "severity": severity,
                "summary": require_string(record["summary"], f"{label}.summary"),
                "url": url,
            }
        )
    return sorted(result, key=lambda item: item["id"])


def parse_manifest(
    path: Path, version: str, signing_public_key: str
) -> tuple[dict[str, dict[str, str]], str]:
    try:
        raw = path.read_bytes()
    except OSError as exc:
        fail(f"release manifest is unreadable: {exc}")
    signature_path = path.with_name(path.name + ".sig")
    try:
        signature = signature_path.read_text(encoding="ascii")
    except OSError as exc:
        fail(f"release manifest signature is unreadable: {exc}")
    if signature != signature.strip() or not HEX128.fullmatch(signature):
        fail("release manifest signature must be 128 lowercase hex characters without whitespace")
    if not openssl_verify(signing_public_key, raw, signature):
        fail("release manifest signature does not verify against the active signing key")
    try:
        text = raw.decode("utf-8")
    except UnicodeDecodeError as exc:
        fail(f"release manifest is not UTF-8: {exc}")
    entries: dict[str, str] = {}
    for number, line in enumerate(text.splitlines(), start=1):
        match = re.fullmatch(r"([0-9a-f]{64}) [ *]([^/\\]+)", line)
        if match is None:
            fail(f"release manifest line {number} is malformed")
        digest, name = match.groups()
        if name in entries:
            fail(f"release manifest repeats asset {name}")
        entries[name] = digest

    host_assets: dict[str, dict[str, str]] = {}
    expected_names = {
        host: f"sailfin_{version}_{suffix}.tar.gz"
        for host, suffix in HOST_ASSETS.items()
    }
    known_names = set(expected_names.values())
    prefix = f"sailfin_{version}_"
    for name in entries:
        if name.startswith(prefix) and name.endswith(".tar.gz") and name not in known_names:
            fail(f"release manifest contains malformed/unsupported host asset {name}")
    for host, name in expected_names.items():
        digest = entries.get(name)
        if digest is None:
            fail(f"release manifest is missing supported host asset {name}")
        if not HEX64.fullmatch(digest):
            fail(f"release manifest has an invalid digest for {name}")
        asset_path = path.parent / name
        try:
            actual = hashlib.sha256(asset_path.read_bytes()).hexdigest()
        except OSError as exc:
            fail(f"supported host asset is unreadable: {asset_path}: {exc}")
        if actual != digest:
            fail(f"release manifest digest does not match asset {name}")
        host_assets[host] = {
            "asset": name,
            "sha256": digest,
        }
    return host_assets, hashlib.sha256(raw).hexdigest()


def validate_previous_index(value: Any) -> dict[str, Any]:
    index = require_object(value, "previous index")
    required = {
        "advisories",
        "channels",
        "expires_at",
        "generated_at",
        "key_transitions",
        "releases",
        "revocations",
        "schema_version",
        "sequence",
        "signing",
        "yanks",
    }
    require_keys(index, "previous index", required, required)
    if index["schema_version"] != INDEX_SCHEMA:
        fail(f"previous index schema_version must be {INDEX_SCHEMA}")
    sequence = index["sequence"]
    if not isinstance(sequence, int) or isinstance(sequence, bool) or sequence < 1:
        fail("previous index sequence must be a positive integer")
    parse_timestamp(index["generated_at"], "previous index.generated_at")
    parse_timestamp(index["expires_at"], "previous index.expires_at")
    if not isinstance(index["releases"], dict):
        fail("previous index.releases must be an object")
    if not isinstance(index["channels"], dict):
        fail("previous index.channels must be an object")
    signing = validate_key_record(index["signing"], "previous index.signing")
    if not isinstance(index["key_transitions"], list):
        fail("previous index.key_transitions must be an array")
    if not isinstance(index["yanks"], list) or not isinstance(index["revocations"], list):
        fail("previous index yank/revocation records must be arrays")
    if not isinstance(index["advisories"], list):
        fail("previous index.advisories must be an array")
    index["yanks"] = validate_yanks(index["yanks"])
    index["revocations"] = validate_revocations(index["revocations"])
    index["advisories"] = validate_advisories(index["advisories"])
    for version, raw_release in index["releases"].items():
        validate_version(version, f"previous index release key {version!r}")
        release = require_object(raw_release, f"previous index.releases[{version}]")
        release_fields = {
            "channel",
            "hosts",
            "manifest_key_id",
            "release_manifest",
            "version",
        }
        require_keys(
            release,
            f"previous index.releases[{version}]",
            release_fields,
            release_fields,
        )
        if release["version"] != version:
            fail(f"previous index release key {version} does not match its version field")
        if release["channel"] != version_channel(version):
            fail(f"previous index release {version} has the wrong channel")
        hosts = require_object(release["hosts"], f"previous index release {version}.hosts")
        if not hosts:
            fail(f"previous index release {version} has no supported hosts")
        for host, raw_asset in hosts.items():
            if host not in HOST_ASSETS:
                fail(f"previous index release {version} has unsupported host {host}")
            asset = require_object(raw_asset, f"previous index release {version} host {host}")
            require_keys(asset, "previous host asset", {"asset", "sha256"}, {"asset", "sha256"})
            expected = f"sailfin_{version}_{HOST_ASSETS[host]}.tar.gz"
            if asset["asset"] != expected:
                fail(f"previous index release {version} has malformed host asset {asset['asset']}")
            if not isinstance(asset["sha256"], str) or not HEX64.fullmatch(asset["sha256"]):
                fail(f"previous index release {version} has an invalid host digest")
        manifest = require_object(
            release["release_manifest"], f"previous index release {version}.release_manifest"
        )
        require_keys(manifest, "previous release manifest", {"path", "sha256"}, {"path", "sha256"})
        if manifest["path"] != f"v{version}/SHA256SUMS":
            fail(f"previous index release {version} has an invalid manifest location")
        if not isinstance(manifest["sha256"], str) or not HEX64.fullmatch(manifest["sha256"]):
            fail(f"previous index release {version} has an invalid manifest digest")
        key_id = require_string(
            release["manifest_key_id"], f"previous index release {version}.manifest_key_id"
        )
        if not key_id.startswith("ed25519:") or not HEX64.fullmatch(key_id[8:]):
            fail(f"previous index release {version} has an invalid manifest key identifier")
    if set(index["channels"]) != set(CHANNELS):
        fail("previous index.channels must contain exactly stable, rc, beta, and alpha")
    for channel, raw_hosts in index["channels"].items():
        hosts = require_object(raw_hosts, f"previous index.channels.{channel}")
        if set(hosts) != set(HOST_ASSETS):
            fail(f"previous index.channels.{channel} must contain every supported host")
        for host, candidate in hosts.items():
            if candidate is None:
                continue
            version = validate_version(candidate, f"previous index.channels.{channel}.{host}")
            release = index["releases"].get(version)
            if release is None or release["channel"] != channel or host not in release["hosts"]:
                fail(f"previous index channel {channel}/{host} does not identify one exact host release")
    index["signing"] = signing
    return index


def validate_previous_signature(
    index: dict[str, Any],
    payload: bytes,
    signature_path: Path,
    known_keys: dict[str, str],
) -> None:
    try:
        signature = signature_path.read_text(encoding="ascii")
    except OSError as exc:
        fail(f"previous index signature is unreadable: {exc}")
    if signature != signature.strip():
        fail("previous index signature must not contain whitespace")
    key_id = index["signing"]["key_id"]
    public_key = known_keys.get(key_id)
    if public_key is None:
        fail("previous index signing key is not trusted by producer state")
    if index["signing"]["public_key"] != public_key:
        fail("previous index signing public key does not match trusted producer state")
    if not openssl_verify(public_key, payload, signature):
        fail("previous index signature verification failed")


def rejected_release_versions(state: dict[str, Any]) -> set[str]:
    rejected = {record["version"] for record in state["yanks"]}
    revoked_keys = {
        record["subject"]
        for record in state["revocations"]
        if record["kind"] == "signing-key"
    }
    rejected.update(
        record["subject"]
        for record in state["revocations"]
        if record["kind"] == "release"
    )
    for version, release in state["releases"].items():
        if release.get("manifest_key_id") in revoked_keys:
            rejected.add(version)
    return rejected


def rebuild_channels(index: dict[str, Any]) -> dict[str, dict[str, str | None]]:
    rejected = rejected_release_versions(index)
    releases = index["releases"]
    channels: dict[str, dict[str, str | None]] = {}
    for channel in CHANNELS:
        by_host: dict[str, str | None] = {}
        for host in sorted(HOST_ASSETS):
            candidates = [
                version
                for version, release in releases.items()
                if release.get("channel") == channel
                and host in release.get("hosts", {})
                and version not in rejected
            ]
            by_host[host] = max(candidates, key=version_sort_key) if candidates else None
        channels[channel] = by_host
    return channels


def validate_record_versions(index: dict[str, Any]) -> None:
    releases = index["releases"]
    for record in index["yanks"]:
        if record["version"] not in releases:
            fail(f"yank references unknown release {record['version']}")
    for record in index["revocations"]:
        if record["kind"] == "release" and record["subject"] not in releases:
            fail(f"revocation references unknown release {record['subject']}")


def build_index(
    args: argparse.Namespace,
) -> tuple[dict[str, Any], dict[str, str], tuple[Path, Path] | None]:
    state, known_keys = validate_state(load_json(args.state, "state"))
    version = validate_version(args.version, "--version")
    if args.channel not in CHANNELS:
        fail("--channel must be stable, rc, beta, or alpha")
    if version_channel(version) != args.channel:
        fail(f"--channel {args.channel} does not match release version {version}")
    generated_at = parse_timestamp(args.generated_at, "--generated-at")
    expires_at = parse_timestamp(args.expires_at, "--expires-at")
    now = parse_timestamp(args.now, "--now") if args.now else dt.datetime.now(dt.timezone.utc)
    if expires_at <= generated_at:
        fail("--expires-at must be later than --generated-at")
    if expires_at <= now:
        fail("toolchain index would already be expired")
    if generated_at > now + dt.timedelta(minutes=5):
        fail("--generated-at is implausibly far in the future")
    signing_key = state["signing_key"]
    revoked_signing_keys = {
        record["subject"]
        for record in state["revocations"]
        if record["kind"] == "signing-key"
    }
    if signing_key["key_id"] in revoked_signing_keys:
        fail("state.signing_key is revoked and cannot authenticate a new index")
    host_assets, manifest_digest = parse_manifest(
        args.manifest, version, signing_key["public_key"]
    )

    previous: dict[str, Any] | None = None
    authenticated_previous: tuple[Path, Path] | None = None
    fallback_present = (
        args.fallback_previous_index is not None
        or args.fallback_previous_signature is not None
    )
    if fallback_present and (
        args.fallback_previous_index is None
        or args.fallback_previous_signature is None
    ):
        fail(
            "--fallback-previous-index and --fallback-previous-signature "
            "must be provided together"
        )
    primary_present = (
        args.previous_index is not None or args.previous_signature is not None
    )
    if primary_present and (
        args.previous_index is None or args.previous_signature is None
    ):
        fail("--previous-index and --previous-signature must be provided together")
    requested_pairs: list[tuple[str, Path, Path]] = []
    if primary_present:
        requested_pairs.append(
            ("primary previous", args.previous_index, args.previous_signature)
        )
    if fallback_present:
        requested_pairs.append(
            (
                "fallback previous",
                args.fallback_previous_index,
                args.fallback_previous_signature,
            )
        )
    for index, pair in enumerate(args.candidate_previous or []):
        requested_pairs.append((f"candidate previous {index}", pair[0], pair[1]))
    if requested_pairs and args.allow_bootstrap:
        fail("--allow-bootstrap cannot be combined with previous index candidates")

    if requested_pairs:
        authenticated: list[tuple[dict[str, Any], bytes, Path, Path, str]] = []
        rejected: list[str] = []
        for label, index_path, signature_path in requested_pairs:
            try:
                raw_candidate = load_bytes(index_path, f"{label} index")
                structural_candidate = validate_previous_index(
                    parse_json_bytes(raw_candidate, f"{label} index")
                )
                if raw_candidate != canonical_bytes(structural_candidate):
                    fail(f"{label} index must use exact canonical JSON bytes")
                validate_previous_signature(
                    structural_candidate,
                    raw_candidate,
                    signature_path,
                    known_keys,
                )
                authenticated.append(
                    (
                        structural_candidate,
                        raw_candidate,
                        index_path,
                        signature_path,
                        label,
                    )
                )
            except IndexError as candidate_error:
                rejected.append(f"{label}: {candidate_error}")
        if not authenticated:
            fail("no previous candidate authenticates: " + "; ".join(rejected))

        highest_sequence = max(item[0]["sequence"] for item in authenticated)
        highest = [
            item for item in authenticated if item[0]["sequence"] == highest_sequence
        ]
        expected_bytes = highest[0][1]
        for item in highest[1:]:
            if item[1] != expected_bytes:
                fail(
                    "authenticated previous candidates disagree at sequence "
                    f"{highest_sequence}"
                )
        previous, _selected_bytes, selected_index, selected_signature, selected_label = highest[0]
        authenticated_previous = (selected_index, selected_signature)
        if rejected:
            print(
                "[toolchain-index] ignored unauthenticated previous candidates: "
                + "; ".join(rejected),
                file=sys.stderr,
            )
        if selected_label != requested_pairs[0][0]:
            print(
                f"[toolchain-index] selected {selected_label} at highest "
                f"authenticated sequence {highest_sequence}",
                file=sys.stderr,
            )

        transitions = state["key_transitions"]
        if previous["key_transitions"] != transitions[: len(previous["key_transitions"])]:
            fail("producer state removed or rewrote authenticated key-transition history")
        previous_transition_count = len(previous["key_transitions"])
        new_transitions = transitions[previous_transition_count:]
        previous_signer = previous["signing"]["key_id"]
        current_signer = signing_key["key_id"]
        if previous_signer == current_signer:
            if new_transitions:
                fail("producer state added a key transition without changing signer")
        elif (
            len(new_transitions) != 1
            or new_transitions[0]["from_key_id"] != previous_signer
            or new_transitions[0]["to_key_id"] != current_signer
        ):
            fail(
                "signer change must be authenticated by exactly one new transition "
                "from the previous signer"
            )
        current_revocations = {
            (record["kind"], record["subject"]): record
            for record in state["revocations"]
        }
        for record in previous["revocations"]:
            identity = (record.get("kind"), record.get("subject"))
            if current_revocations.get(identity) != record:
                fail("producer state removed or rewrote a signed revocation record")
    elif not args.allow_bootstrap:
        fail("no previous signed index supplied (use --allow-bootstrap only for first publication)")

    releases = dict(previous["releases"]) if previous is not None else {}
    release = {
        "channel": args.channel,
        "hosts": host_assets,
        "manifest_key_id": signing_key["key_id"],
        "release_manifest": {
            "path": f"v{version}/SHA256SUMS",
            "sha256": manifest_digest,
        },
        "version": version,
    }
    existing = releases.get(version)
    if existing is not None and existing != release:
        fail(f"release {version} already exists with different authenticated metadata")
    releases[version] = release

    candidate: dict[str, Any] = {
        "advisories": state["advisories"],
        "channels": {},
        "expires_at": args.expires_at,
        "generated_at": args.generated_at,
        "key_transitions": state["key_transitions"],
        "releases": releases,
        "revocations": state["revocations"],
        "schema_version": INDEX_SCHEMA,
        "sequence": 1,
        "signing": signing_key,
        "yanks": state["yanks"],
    }
    validate_record_versions(candidate)
    candidate["channels"] = rebuild_channels(candidate)

    desired_sequence = 1
    if previous is not None:
        semantic_candidate = dict(candidate)
        semantic_previous = dict(previous)
        for temporal_field in ("expires_at", "generated_at", "sequence"):
            semantic_candidate.pop(temporal_field)
            semantic_previous.pop(temporal_field)
        previous_expiry = parse_timestamp(previous["expires_at"], "previous index.expires_at")
        if canonical_bytes(semantic_candidate) == canonical_bytes(semantic_previous) and previous_expiry > now:
            candidate["generated_at"] = previous["generated_at"]
            candidate["expires_at"] = previous["expires_at"]
            desired_sequence = previous["sequence"]
        else:
            desired_sequence = previous["sequence"] + 1
    if args.sequence is not None and args.sequence != desired_sequence:
        fail(
            f"requested sequence {args.sequence} would violate monotonic sequence; "
            f"producer requires {desired_sequence}"
        )
    candidate["sequence"] = desired_sequence
    previous_transition_count = len(previous["key_transitions"]) if previous is not None else 0
    new_transition_count = len(candidate["key_transitions"]) - previous_transition_count
    if new_transition_count > 1:
        fail("one index sequence cannot activate more than one signing-key transition")
    for index, transition in enumerate(candidate["key_transitions"]):
        if transition["effective_sequence"] > desired_sequence:
            fail(
                f"key transition {index} becomes effective after output sequence "
                f"{desired_sequence}"
            )
        if index >= previous_transition_count and transition["effective_sequence"] != desired_sequence:
            fail("a new key transition must become effective at the output sequence")
    return candidate, known_keys, authenticated_previous


def private_key_path() -> tuple[Path, tempfile.TemporaryDirectory[str] | None]:
    inline = os.environ.get("SAILFIN_RELEASE_SIGNING_KEY", "")
    configured = os.environ.get("SAILFIN_RELEASE_SIGNING_KEY_FILE", "")
    if inline and configured:
        fail("set only one of SAILFIN_RELEASE_SIGNING_KEY and SAILFIN_RELEASE_SIGNING_KEY_FILE")
    if configured:
        path = Path(configured)
        if not path.is_file():
            fail(f"signing key file not found: {path}")
        return path, None
    if not inline:
        fail("SAILFIN_RELEASE_SIGNING_KEY[_FILE] is required for signed-index publication")
    temp = tempfile.TemporaryDirectory(prefix="sailfin-index-key-")
    path = Path(temp.name) / "private.pem"
    path.write_text(inline, encoding="utf-8")
    path.chmod(0o600)
    return path, temp


def parse_args(argv: list[str]) -> argparse.Namespace:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--state", type=Path, required=True)
    parser.add_argument("--manifest", type=Path, required=True)
    parser.add_argument("--version", required=True)
    parser.add_argument("--channel", required=True)
    parser.add_argument("--generated-at", required=True)
    parser.add_argument("--expires-at", required=True)
    parser.add_argument("--now")
    parser.add_argument("--previous-index", type=Path)
    parser.add_argument("--previous-signature", type=Path)
    parser.add_argument("--fallback-previous-index", type=Path)
    parser.add_argument("--fallback-previous-signature", type=Path)
    parser.add_argument(
        "--candidate-previous",
        action="append",
        nargs=2,
        type=Path,
        metavar=("INDEX", "SIGNATURE"),
    )
    parser.add_argument("--authenticated-previous-output", type=Path)
    parser.add_argument("--authenticated-previous-signature-output", type=Path)
    parser.add_argument("--sequence", type=int)
    parser.add_argument("--allow-bootstrap", action="store_true")
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--signature-output", type=Path, required=True)
    return parser.parse_args(argv)


def main(argv: list[str]) -> int:
    args = parse_args(argv)
    try:
        if (args.authenticated_previous_output is None) != (
            args.authenticated_previous_signature_output is None
        ):
            fail(
                "--authenticated-previous-output and "
                "--authenticated-previous-signature-output must be provided together"
            )
        index, _known_keys, authenticated_previous = build_index(args)
        payload = canonical_bytes(index)
        key_path, temp = private_key_path()
        try:
            signature = openssl_sign(key_path, payload)
        finally:
            if temp is not None:
                temp.cleanup()
        public_key = index["signing"]["public_key"]
        if not openssl_verify(public_key, payload, signature):
            fail("fresh index signature does not verify against state.signing_key")
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.signature_output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_bytes(payload)
        args.signature_output.write_text(signature, encoding="ascii")
        if authenticated_previous is not None and args.authenticated_previous_output:
            args.authenticated_previous_output.parent.mkdir(parents=True, exist_ok=True)
            args.authenticated_previous_signature_output.parent.mkdir(
                parents=True, exist_ok=True
            )
            args.authenticated_previous_output.write_bytes(
                authenticated_previous[0].read_bytes()
            )
            args.authenticated_previous_signature_output.write_bytes(
                authenticated_previous[1].read_bytes()
            )
        print(
            f"[toolchain-index] wrote {args.output} sequence={index['sequence']} "
            f"releases={len(index['releases'])}"
        )
        print(f"[toolchain-index] wrote {args.signature_output} (detached Ed25519)")
        return 0
    except IndexError as exc:
        print(f"[toolchain-index][error] {exc}", file=sys.stderr)
        return 1


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
