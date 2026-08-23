#!/usr/bin/env python3
"""Offline fixture contract for scripts/publish-toolchain-index.py."""

from __future__ import annotations

import hashlib
import json
import os
from pathlib import Path
import shutil
import subprocess
import sys
import tempfile


ROOT = Path(__file__).resolve().parents[1]
PUBLISHER = ROOT / "scripts" / "publish-toolchain-index.py"
FIXTURES = ROOT / "compiler" / "tests" / "e2e" / "fixtures" / "toolchain-index"
HOST_SUFFIXES = (
    "linux_x86_64",
    "linux_arm64",
    "macos_arm64",
    "windows_x86_64-msvc",
    "windows_x86_64",
)
NATIVE_SUFFIXES = ("linux-x86_64", "linux-arm64", "macos-arm64")
SPKI_ED25519_PREFIX = bytes.fromhex("302a300506032b6570032100")


def fixture(name: str) -> dict[str, object]:
    return json.loads((FIXTURES / name).read_text(encoding="utf-8"))


def canonical_bytes(value: object) -> bytes:
    return (
        json.dumps(value, ensure_ascii=False, separators=(",", ":"), sort_keys=True)
        + "\n"
    ).encode("utf-8")


def generate_key(root: Path, label: str) -> tuple[Path, str, str]:
    private = root / f"{label}.pem"
    public_der = root / f"{label}.der"
    subprocess.run(
        ["openssl", "genpkey", "-algorithm", "ed25519", "-out", str(private)],
        check=True,
        capture_output=True,
    )
    subprocess.run(
        [
            "openssl",
            "pkey",
            "-in",
            str(private),
            "-pubout",
            "-outform",
            "DER",
            "-out",
            str(public_der),
        ],
        check=True,
        capture_output=True,
    )
    encoded = public_der.read_bytes()
    if not encoded.startswith(SPKI_ED25519_PREFIX) or len(encoded) != 44:
        raise AssertionError("openssl emitted an unexpected Ed25519 SPKI")
    public = encoded[-32:].hex()
    return private, public, "ed25519:" + public


def sign(private: Path, payload: bytes, output: Path) -> str:
    message = output.with_suffix(".message")
    message.write_bytes(payload)
    subprocess.run(
        [
            "openssl",
            "pkeyutl",
            "-sign",
            "-inkey",
            str(private),
            "-rawin",
            "-in",
            str(message),
            "-out",
            str(output),
        ],
        check=True,
        capture_output=True,
    )
    return output.read_bytes().hex()


def verify(public: str, payload: Path, signature_hex: str, root: Path) -> None:
    public_der = root / "verify.der"
    signature = root / "verify.sig"
    public_der.write_bytes(SPKI_ED25519_PREFIX + bytes.fromhex(public))
    signature.write_bytes(bytes.fromhex(signature_hex))
    subprocess.run(
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
            str(payload),
            "-sigfile",
            str(signature),
        ],
        check=True,
        capture_output=True,
    )


def write_state(
    path: Path,
    root_public: str,
    signing_public: str | None = None,
    transitions: list[dict[str, object]] | None = None,
    yanks: list[dict[str, object]] | None = None,
    revocations: list[dict[str, object]] | None = None,
    advisories: list[dict[str, object]] | None = None,
    extra_roots: list[str] | None = None,
) -> None:
    signing_public = signing_public or root_public
    state = {
        "advisories": advisories or [],
        "key_transitions": transitions or [],
        "revocations": revocations or [],
        "schema_version": "sailfin-toolchain-index-state/1",
        "signing_key": {
            "key_id": "ed25519:" + signing_public,
            "public_key": signing_public,
        },
        "trusted_root_keys": [
            {"key_id": "ed25519:" + public, "public_key": public}
            for public in [root_public, *(extra_roots or [])]
        ],
        "yanks": yanks or [],
    }
    path.write_text(json.dumps(state, indent=2) + "\n", encoding="utf-8")


def write_release(
    root: Path,
    version: str,
    private: Path,
    malformed: str | None = None,
    label: str | None = None,
) -> Path:
    release = root / (label or version)
    release.mkdir(parents=True)
    lines: list[str] = []
    for suffix in HOST_SUFFIXES:
        name = f"sailfin_{version}_{suffix}.tar.gz"
        content = f"fixture asset {version} {suffix}\n".encode()
        (release / name).write_bytes(content)
        lines.append(f"{hashlib.sha256(content).hexdigest()}  {name}")
    for suffix in NATIVE_SUFFIXES:
        name = f"sailfin-native-{suffix}-{version}.tar.gz"
        content = f"fixture native asset {version} {suffix}\n".encode()
        (release / name).write_bytes(content)
        lines.append(f"{hashlib.sha256(content).hexdigest()}  {name}")
    if malformed is not None:
        content = b"unsupported host fixture\n"
        (release / malformed).write_bytes(content)
        lines.append(f"{hashlib.sha256(content).hexdigest()}  {malformed}")
    manifest = release / "SHA256SUMS"
    manifest.write_text("\n".join(sorted(lines)) + "\n", encoding="utf-8")
    signature_hex = sign(private, manifest.read_bytes(), release / "manifest-signature.raw")
    (release / "SHA256SUMS.sig").write_text(signature_hex, encoding="ascii")
    return manifest


def run_publisher(
    root: Path,
    state: Path,
    private: Path,
    manifest: Path,
    version: str,
    channel: str,
    stem: str,
    *,
    generated_at: str = "2026-08-23T00:00:00Z",
    expires_at: str = "2026-09-27T00:00:00Z",
    now: str = "2026-08-23T00:00:00Z",
    previous: tuple[Path, Path] | None = None,
    fallback_previous: tuple[Path, Path] | None = None,
    candidate_previous: list[tuple[Path, Path]] | None = None,
    authenticated_previous: tuple[Path, Path] | None = None,
    sequence: int | None = None,
    bootstrap: bool = False,
) -> tuple[subprocess.CompletedProcess[str], Path, Path]:
    output = root / f"{stem}.json"
    signature = root / f"{stem}.json.sig"
    command = [
        sys.executable,
        str(PUBLISHER),
        "--state",
        str(state),
        "--manifest",
        str(manifest),
        "--version",
        version,
        "--channel",
        channel,
        "--generated-at",
        generated_at,
        "--expires-at",
        expires_at,
        "--now",
        now,
        "--output",
        str(output),
        "--signature-output",
        str(signature),
    ]
    if previous is not None:
        command.extend(
            [
                "--previous-index",
                str(previous[0]),
                "--previous-signature",
                str(previous[1]),
            ]
        )
    if fallback_previous is not None:
        command.extend(
            [
                "--fallback-previous-index",
                str(fallback_previous[0]),
                "--fallback-previous-signature",
                str(fallback_previous[1]),
            ]
        )
    for candidate in candidate_previous or []:
        command.extend(
            [
                "--candidate-previous",
                str(candidate[0]),
                str(candidate[1]),
            ]
        )
    if authenticated_previous is not None:
        command.extend(
            [
                "--authenticated-previous-output",
                str(authenticated_previous[0]),
                "--authenticated-previous-signature-output",
                str(authenticated_previous[1]),
            ]
        )
    if sequence is not None:
        command.extend(["--sequence", str(sequence)])
    if bootstrap:
        command.append("--allow-bootstrap")
    environment = dict(os.environ)
    environment.pop("SAILFIN_RELEASE_SIGNING_KEY", None)
    environment["SAILFIN_RELEASE_SIGNING_KEY_FILE"] = str(private)
    result = subprocess.run(command, env=environment, capture_output=True, text=True)
    return result, output, signature


def expect_success(result: subprocess.CompletedProcess[str], label: str) -> None:
    if result.returncode != 0:
        raise AssertionError(f"{label} failed:\n{result.stdout}\n{result.stderr}")


def expect_failure(
    result: subprocess.CompletedProcess[str], pattern: str, label: str
) -> None:
    if result.returncode == 0 or pattern not in result.stderr:
        raise AssertionError(
            f"{label} did not fail with {pattern!r}:\n{result.stdout}\n{result.stderr}"
        )


def main() -> int:
    if shutil.which("openssl") is None:
        print("fixture error: openssl is required", file=sys.stderr)
        return 1
    with tempfile.TemporaryDirectory(prefix="sailfin-toolchain-index-test-") as temp:
        root = Path(temp)
        old_private, old_public, old_id = generate_key(root, "old")
        new_private, new_public, new_id = generate_key(root, "new")
        normal_fixture = fixture("normal.json")
        normal_state = root / "normal-state.json"
        write_state(
            normal_state,
            old_public,
            yanks=normal_fixture["yanks"],
            revocations=normal_fixture["revocations"],
            advisories=normal_fixture["advisories"],
        )
        manifest_123 = write_release(root, "1.2.3", old_private)
        payload_gate = subprocess.run(
            [
                "bash",
                str(ROOT / "scripts" / "verify-release-payloads.sh"),
                str(manifest_123.parent),
                "1.2.3",
            ],
            capture_output=True,
            text=True,
        )
        expect_success(payload_gate, "release payload presence gate")

        normal, index_1, signature_1 = run_publisher(
            root,
            normal_state,
            old_private,
            manifest_123,
            "1.2.3",
            "stable",
            "normal",
            bootstrap=True,
        )
        expect_success(normal, "normal fixture")
        payload_1 = json.loads(index_1.read_text(encoding="utf-8"))
        if payload_1["sequence"] != 1:
            raise AssertionError("bootstrap sequence is not 1")
        if "latest" in index_1.read_text(encoding="utf-8"):
            raise AssertionError("canonical index stored a latest alias")
        for host, candidate in payload_1["channels"]["stable"].items():
            if candidate != "1.2.3" or host not in payload_1["releases"]["1.2.3"]["hosts"]:
                raise AssertionError("stable fixture did not resolve one exact release per host")
        verify(old_public, index_1, signature_1.read_text(encoding="ascii"), root)

        noncanonical_index = root / "noncanonical.json"
        noncanonical_index.write_text(
            json.dumps(payload_1, indent=2) + "\n", encoding="utf-8"
        )
        noncanonical_signature = root / "noncanonical.json.sig"
        noncanonical_signature.write_text(
            sign(
                old_private,
                noncanonical_index.read_bytes(),
                root / "noncanonical-signature.raw",
            ),
            encoding="ascii",
        )
        noncanonical, _, _ = run_publisher(
            root,
            normal_state,
            old_private,
            manifest_123,
            "1.2.3",
            "stable",
            "noncanonical-output",
            previous=(noncanonical_index, noncanonical_signature),
        )
        expect_failure(
            noncanonical,
            "must use exact canonical JSON bytes",
            "noncanonical signed index fixture",
        )

        duplicate_index = root / "duplicate-key.json"
        duplicate_index.write_text(
            index_1.read_text(encoding="utf-8").replace(
                '"advisories":', '"sequence":999,"advisories":', 1
            ),
            encoding="utf-8",
        )
        duplicate_signature = root / "duplicate-key.json.sig"
        duplicate_signature.write_text(
            sign(
                old_private,
                duplicate_index.read_bytes(),
                root / "duplicate-key-signature.raw",
            ),
            encoding="ascii",
        )
        duplicate, _, _ = run_publisher(
            root,
            normal_state,
            old_private,
            manifest_123,
            "1.2.3",
            "stable",
            "duplicate-key-output",
            previous=(duplicate_index, duplicate_signature),
        )
        expect_failure(
            duplicate,
            "duplicate object key 'sequence'",
            "duplicate-key signed index fixture",
        )

        repeat, repeat_index, repeat_signature = run_publisher(
            root,
            normal_state,
            old_private,
            manifest_123,
            "1.2.3",
            "stable",
            "normal-repeat",
            generated_at="2026-08-24T00:00:00Z",
            expires_at="2026-09-28T00:00:00Z",
            now="2026-08-24T00:00:00Z",
            previous=(index_1, signature_1),
        )
        expect_success(repeat, "canonical rerun fixture")
        if repeat_index.read_bytes() != index_1.read_bytes():
            raise AssertionError("identical release state changed canonical payload bytes")
        if repeat_signature.read_bytes() != signature_1.read_bytes():
            raise AssertionError("deterministic Ed25519 signing changed detached signature")

        malformed = fixture("malformed-host.json")
        malformed_manifest = write_release(
            root, "1.2.3", old_private, str(malformed["asset"]), "malformed-host"
        )
        malformed_result, _, _ = run_publisher(
            root,
            normal_state,
            old_private,
            malformed_manifest,
            "1.2.3",
            "stable",
            "malformed-host",
            bootstrap=True,
        )
        expect_failure(malformed_result, "malformed/unsupported host asset", "malformed host fixture")

        digest_fixture = fixture("invalid-manifest-digest.json")
        digest_manifest = write_release(
            root, "1.2.3", old_private, label="invalid-digest"
        )
        digest_lines = digest_manifest.read_text(encoding="utf-8").splitlines()
        digest_manifest.write_text(
            "\n".join(
                f"{digest_fixture['digest']}  {digest_fixture['asset']}"
                if line.endswith("  " + str(digest_fixture["asset"]))
                else line
                for line in digest_lines
            )
            + "\n",
            encoding="utf-8",
        )
        digest_signature = sign(
            old_private, digest_manifest.read_bytes(), root / "bad-digest-manifest.sig.raw"
        )
        digest_manifest.with_name("SHA256SUMS.sig").write_text(
            digest_signature, encoding="ascii"
        )
        digest_result, _, _ = run_publisher(
            root,
            normal_state,
            old_private,
            digest_manifest,
            "1.2.3",
            "stable",
            "bad-digest",
            bootstrap=True,
        )
        expect_failure(digest_result, "digest does not match asset", "manifest digest fixture")

        bad_manifest_signature = write_release(
            root, "1.2.3", old_private, label="bad-manifest-signature"
        )
        bad_manifest_signature_path = bad_manifest_signature.with_name("SHA256SUMS.sig")
        manifest_signature_text = bad_manifest_signature_path.read_text(encoding="ascii")
        bad_manifest_signature_path.write_text(
            ("0" if manifest_signature_text[0] != "0" else "1")
            + manifest_signature_text[1:],
            encoding="ascii",
        )
        manifest_signature_result, _, _ = run_publisher(
            root,
            normal_state,
            old_private,
            bad_manifest_signature,
            "1.2.3",
            "stable",
            "bad-manifest-signature",
            bootstrap=True,
        )
        expect_failure(
            manifest_signature_result,
            "release manifest signature does not verify",
            "release manifest signature fixture",
        )

        expired = fixture("expired.json")
        expired_result, _, _ = run_publisher(
            root,
            normal_state,
            old_private,
            manifest_123,
            "1.2.3",
            "stable",
            "expired",
            generated_at=str(expired["generated_at"]),
            expires_at=str(expired["expires_at"]),
            now=str(expired["now"]),
            bootstrap=True,
        )
        expect_failure(expired_result, "already be expired", "expired fixture")

        manifest_124 = write_release(root, "1.2.4", old_private)
        rollback = fixture("rollback.json")
        rollback_result, _, _ = run_publisher(
            root,
            normal_state,
            old_private,
            manifest_124,
            "1.2.4",
            "stable",
            "rollback",
            generated_at="2026-08-24T00:00:00Z",
            expires_at="2026-09-28T00:00:00Z",
            now="2026-08-24T00:00:00Z",
            previous=(index_1, signature_1),
            sequence=int(rollback["requested_sequence"]),
        )
        if int(rollback["previous_sequence"]) != payload_1["sequence"]:
            raise AssertionError("rollback fixture does not match previous sequence")
        expect_failure(rollback_result, "violate monotonic sequence", "rollback fixture")

        bad_previous_signature = root / "bad-previous.sig"
        sig_text = signature_1.read_text(encoding="ascii")
        bad_previous_signature.write_text(
            ("0" if sig_text[0] != "0" else "1") + sig_text[1:], encoding="ascii"
        )
        wrong_signature, _, _ = run_publisher(
            root,
            normal_state,
            old_private,
            manifest_124,
            "1.2.4",
            "stable",
            "wrong-signature",
            generated_at="2026-08-24T00:00:00Z",
            expires_at="2026-09-28T00:00:00Z",
            now="2026-08-24T00:00:00Z",
            previous=(index_1, bad_previous_signature),
        )
        expect_failure(wrong_signature, "signature verification failed", "wrong signature fixture")

        advanced, index_2, signature_2 = run_publisher(
            root,
            normal_state,
            old_private,
            manifest_124,
            "1.2.4",
            "stable",
            "advanced",
            generated_at="2026-08-24T00:00:00Z",
            expires_at="2026-09-28T00:00:00Z",
            now="2026-08-24T00:00:00Z",
            previous=(index_1, signature_1),
        )
        expect_success(advanced, "advanced release fixture")

        highest_selection, highest_index, highest_signature = run_publisher(
            root,
            normal_state,
            old_private,
            manifest_124,
            "1.2.4",
            "stable",
            "highest-selection",
            generated_at="2026-08-25T00:00:00Z",
            expires_at="2026-09-29T00:00:00Z",
            now="2026-08-25T00:00:00Z",
            previous=(index_1, signature_1),
            candidate_previous=[(index_2, signature_2)],
        )
        expect_success(highest_selection, "highest authenticated sequence fixture")
        if highest_index.read_bytes() != index_2.read_bytes():
            raise AssertionError("producer did not reuse the highest authenticated payload")
        if highest_signature.read_bytes() != signature_2.read_bytes():
            raise AssertionError("highest authenticated rerun changed the signature")

        divergent, divergent_index, divergent_signature = run_publisher(
            root,
            normal_state,
            old_private,
            manifest_124,
            "1.2.4",
            "stable",
            "divergent-sequence-two",
            generated_at="2026-08-25T00:00:00Z",
            expires_at="2026-09-29T00:00:00Z",
            now="2026-08-25T00:00:00Z",
            previous=(index_1, signature_1),
        )
        expect_success(divergent, "divergent sequence fixture setup")
        if divergent_index.read_bytes() == index_2.read_bytes():
            raise AssertionError("divergent sequence fixture did not change canonical bytes")
        equal_sequence_conflict, _, _ = run_publisher(
            root,
            normal_state,
            old_private,
            manifest_124,
            "1.2.4",
            "stable",
            "equal-sequence-conflict",
            generated_at="2026-08-25T00:00:00Z",
            expires_at="2026-09-29T00:00:00Z",
            now="2026-08-25T00:00:00Z",
            candidate_previous=[
                (index_2, signature_2),
                (divergent_index, divergent_signature),
            ],
        )
        expect_failure(
            equal_sequence_conflict,
            "disagree at sequence 2",
            "equal-sequence conflict fixture",
        )

        mixed_signature = root / "mixed-primary.json.sig"
        mixed_signature.write_bytes(signature_1.read_bytes())
        recovered_index = root / "recovered-previous.json"
        recovered_signature = root / "recovered-previous.json.sig"
        fallback_recovery, fallback_index, _ = run_publisher(
            root,
            normal_state,
            old_private,
            manifest_124,
            "1.2.4",
            "stable",
            "fallback-recovery",
            generated_at="2026-08-24T00:00:00Z",
            expires_at="2026-09-28T00:00:00Z",
            now="2026-08-24T00:00:00Z",
            previous=(index_2, mixed_signature),
            fallback_previous=(index_2, signature_2),
            authenticated_previous=(recovered_index, recovered_signature),
        )
        expect_success(fallback_recovery, "preserved fallback fixture")
        if json.loads(fallback_index.read_text(encoding="utf-8"))["sequence"] != 2:
            raise AssertionError("fallback recovery did not advance the preserved sequence")
        if fallback_index.read_bytes() != index_2.read_bytes():
            raise AssertionError("fallback recovery changed canonical sequence-2 bytes")
        if recovered_index.read_bytes() != index_2.read_bytes():
            raise AssertionError("producer did not preserve the authenticated fallback index")
        if recovered_signature.read_bytes() != signature_2.read_bytes():
            raise AssertionError("producer did not preserve the authenticated fallback signature")

        unsigned_partial_recovery, recovered_partial_index, _ = run_publisher(
            root,
            normal_state,
            old_private,
            manifest_124,
            "1.2.4",
            "stable",
            "unsigned-partial-recovery",
            generated_at="2026-08-25T00:00:00Z",
            expires_at="2026-09-29T00:00:00Z",
            now="2026-08-25T00:00:00Z",
            previous=(index_2, mixed_signature),
            fallback_previous=(index_1, signature_1),
        )
        expect_success(unsigned_partial_recovery, "unsigned partial-upload recovery fixture")
        if json.loads(recovered_partial_index.read_text(encoding="utf-8"))["sequence"] != 2:
            raise AssertionError("unsigned partial recovery did not restore sequence 2")

        yank_state = root / "yank-state.json"
        write_state(yank_state, old_public, yanks=[fixture("yank.json")])
        yank_result, yank_index, _ = run_publisher(
            root,
            yank_state,
            old_private,
            manifest_123,
            "1.2.3",
            "stable",
            "yank",
            bootstrap=True,
        )
        expect_success(yank_result, "yank fixture")
        yank_payload = json.loads(yank_index.read_text(encoding="utf-8"))
        if not yank_payload["yanks"] or any(yank_payload["channels"]["stable"].values()):
            raise AssertionError("yank record was not distinct from channel eligibility")

        revoke_state = root / "revoke-state.json"
        write_state(revoke_state, old_public, revocations=[fixture("revocation.json")])
        revoke_result, revoke_index, _ = run_publisher(
            root,
            revoke_state,
            old_private,
            manifest_123,
            "1.2.3",
            "stable",
            "revocation",
            bootstrap=True,
        )
        expect_success(revoke_result, "revocation fixture")
        revoke_payload = json.loads(revoke_index.read_text(encoding="utf-8"))
        if not revoke_payload["revocations"] or revoke_payload["yanks"]:
            raise AssertionError("revocation record was not distinct from yank state")

        revoked_signer_state = root / "revoked-signer-state.json"
        write_state(
            revoked_signer_state,
            old_public,
            revocations=[
                {
                    "kind": "signing-key",
                    "reason": "fixture key compromise",
                    "recorded_at": "2026-08-23T00:00:00Z",
                    "subject": old_id,
                }
            ],
        )
        revoked_signer, _, _ = run_publisher(
            root,
            revoked_signer_state,
            old_private,
            manifest_123,
            "1.2.3",
            "stable",
            "revoked-signer",
            bootstrap=True,
        )
        expect_failure(
            revoked_signer,
            "signing_key is revoked",
            "signing-key revocation fixture",
        )

        advisory_state = root / "advisory-state.json"
        write_state(advisory_state, old_public, advisories=[fixture("advisory.json")])
        advisory_result, advisory_index, _ = run_publisher(
            root,
            advisory_state,
            old_private,
            manifest_123,
            "1.2.3",
            "stable",
            "advisory",
            bootstrap=True,
        )
        expect_success(advisory_result, "advisory fixture")
        advisory_payload = json.loads(advisory_index.read_text(encoding="utf-8"))
        if not advisory_payload["advisories"] or not all(advisory_payload["channels"]["stable"].values()):
            raise AssertionError("advisory incorrectly removed an eligible release")

        empty_range_advisory = fixture("advisory.json")
        empty_range_advisory["affected"] = " "
        empty_range_state = root / "empty-range-state.json"
        write_state(
            empty_range_state,
            old_public,
            advisories=[empty_range_advisory],
        )
        empty_range, _, _ = run_publisher(
            root,
            empty_range_state,
            old_private,
            manifest_123,
            "1.2.3",
            "stable",
            "empty-advisory-range",
            bootstrap=True,
        )
        expect_failure(
            empty_range,
            "affected must be a space-separated exact/comparator range",
            "empty advisory range fixture",
        )

        transition = fixture("key-transition.json")
        transition.update(
            {
                "from_key_id": old_id,
                "to_key_id": new_id,
                "to_public_key": new_public,
            }
        )
        transition_message = canonical_bytes(
            {
                "effective_sequence": transition["effective_sequence"],
                "from_key_id": transition["from_key_id"],
                "schema_version": "sailfin-toolchain-key-transition/1",
                "to_key_id": transition["to_key_id"],
                "to_public_key": transition["to_public_key"],
            }
        )
        transition["signature"] = sign(old_private, transition_message, root / "transition.sig")
        transition_state = root / "transition-state.json"
        write_state(transition_state, old_public, new_public, [transition])
        manifest_124_new = write_release(
            root, "1.2.4", new_private, label="transition-release"
        )
        transition_result, transition_index, transition_signature = run_publisher(
            root,
            transition_state,
            new_private,
            manifest_124_new,
            "1.2.4",
            "stable",
            "transition",
            generated_at="2026-08-24T00:00:00Z",
            expires_at="2026-09-28T00:00:00Z",
            now="2026-08-24T00:00:00Z",
            previous=(index_1, signature_1),
        )
        expect_success(transition_result, "key transition fixture")
        transition_payload = json.loads(transition_index.read_text(encoding="utf-8"))
        if transition_payload["sequence"] != 2 or transition_payload["signing"]["key_id"] != new_id:
            raise AssertionError("authenticated key transition did not activate at sequence 2")
        verify(new_public, transition_index, transition_signature.read_text(encoding="ascii"), root)

        unauthenticated_switch_state = root / "unauthenticated-switch-state.json"
        write_state(
            unauthenticated_switch_state,
            old_public,
            new_public,
            extra_roots=[new_public],
        )
        unauthenticated_switch, _, _ = run_publisher(
            root,
            unauthenticated_switch_state,
            new_private,
            manifest_124_new,
            "1.2.4",
            "stable",
            "unauthenticated-switch",
            generated_at="2026-08-24T00:00:00Z",
            expires_at="2026-09-28T00:00:00Z",
            now="2026-08-24T00:00:00Z",
            previous=(index_1, signature_1),
        )
        expect_failure(
            unauthenticated_switch,
            "signer change must be authenticated",
            "unauthenticated signer switch fixture",
        )

        transition["signature"] = "0" * 128
        invalid_transition_state = root / "invalid-transition-state.json"
        write_state(invalid_transition_state, old_public, new_public, [transition])
        invalid_transition, _, _ = run_publisher(
            root,
            invalid_transition_state,
            new_private,
            manifest_124_new,
            "1.2.4",
            "stable",
            "invalid-transition",
            generated_at="2026-08-24T00:00:00Z",
            expires_at="2026-09-28T00:00:00Z",
            now="2026-08-24T00:00:00Z",
            previous=(index_1, signature_1),
        )
        expect_failure(invalid_transition, "does not authenticate", "invalid key transition fixture")

    print("[toolchain-index-test] all offline producer fixtures passed")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
