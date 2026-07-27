#!/usr/bin/env bash
set -euo pipefail

# Bootstrap the first native aarch64-Linux compiler from the pinned x86_64
# seed. See docs/build-aarch64-linux.md and SFEP-0056 section 3.4.

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WORK_DIR="${SAILFIN_AARCH64_BOOTSTRAP_DIR:-$ROOT/build/aarch64-bootstrap}"
SEED_X86_64="${SEED_X86_64:-${1:-}}"
QEMU_X86_64="${QEMU_X86_64:-qemu-x86_64}"
NATIVE_CC="${SAILFIN_NATIVE_CC:-clang}"

fail() {
	printf '[bootstrap-aarch64][error] %s\n' "$*" >&2
	exit 1
}

need() {
	command -v "$1" >/dev/null 2>&1 || fail "required command not found: $1"
}

[ "$(uname -s)" = "Linux" ] || fail "this bootstrap must run on Linux"
case "$(uname -m)" in
	aarch64 | arm64) ;;
	*) fail "this bootstrap must run on an aarch64 host (found $(uname -m))" ;;
esac

[ -n "$SEED_X86_64" ] || fail "pass the pinned x86_64 seed path as SEED_X86_64 or argument 1"
[ -x "$SEED_X86_64" ] || fail "x86_64 seed is not executable: $SEED_X86_64"
need "$QEMU_X86_64"
need "$NATIVE_CC"
need readelf
need sha256sum

SEED_VERSION="$(awk '/^\[[^]]+\]/ { section=$0 } section == "[seed]" && /^version[[:space:]]*=/ { gsub(/"/, "", $3); print $3; exit }' "$ROOT/bootstrap.toml")"
"$QEMU_X86_64" "$SEED_X86_64" --version | grep -F "$SEED_VERSION" >/dev/null \
	|| fail "seed does not report bootstrap.toml version $SEED_VERSION"

# Compiler builds recursively execute their current compiler. The seed and
# compiler A are x86_64 executables, so binfmt_misc must cover those child
# invocations even though the top-level commands below name qemu explicitly.
[ -d /proc/sys/fs/binfmt_misc ] || fail "binfmt_misc is not mounted"
binfmt_runs_seed() {
	"$SEED_X86_64" --version >/dev/null 2>&1
}
if ! binfmt_runs_seed; then
	printf '[bootstrap-aarch64] enabling qemu-x86_64 binfmt registration\n'
	if [ "$(id -u)" -eq 0 ] && command -v update-binfmts >/dev/null 2>&1; then
		update-binfmts --enable qemu-x86_64
	elif command -v sudo >/dev/null 2>&1 && sudo -n true 2>/dev/null && command -v update-binfmts >/dev/null 2>&1; then
		sudo -n update-binfmts --enable qemu-x86_64
	else
		fail "cannot register x86_64 binfmt non-interactively; install qemu-user-binfmt and run: sudo update-binfmts --enable qemu-x86_64"
	fi
fi
if ! binfmt_runs_seed; then
	fail "x86_64 binfmt registration is still unavailable after update-binfmts"
fi

rm -rf "$WORK_DIR"
mkdir -p "$WORK_DIR/bin" "$WORK_DIR/compiler-a" "$WORK_DIR/pass-1" "$WORK_DIR/pass-2"

cat >"$WORK_DIR/bin/clang-x86_64" <<EOF
#!/usr/bin/env bash
exec "$NATIVE_CC" --target=x86_64-linux-gnu "\$@"
EOF
chmod +x "$WORK_DIR/bin/clang-x86_64"

run_x86() {
	local binary="$1"
	shift
	"$QEMU_X86_64" "$binary" "$@"
}

printf '[bootstrap-aarch64] building arch-aware x86_64 compiler A\n'
(
	cd "$ROOT"
	SAILFIN_CC="$WORK_DIR/bin/clang-x86_64" SAILFIN_TARGET_ARCH=x86_64 \
		run_x86 "$SEED_X86_64" build --no-cache -p compiler \
		--work-dir "$WORK_DIR/compiler-a" -o "$WORK_DIR/compiler-a/sfn"
)
readelf -h "$WORK_DIR/compiler-a/sfn" | grep -Eq 'Machine:[[:space:]]+(Advanced Micro Devices X86-64|AMD x86-64)' \
	|| fail "compiler A is not an x86_64 ELF executable"

printf '[bootstrap-aarch64] building native pass-1 with compiler A\n'
(
	cd "$ROOT"
	SAILFIN_CC="$NATIVE_CC" SAILFIN_TARGET_ARCH=aarch64 \
		run_x86 "$WORK_DIR/compiler-a/sfn" build --no-cache -p compiler \
		--work-dir "$WORK_DIR/pass-1" -o "$WORK_DIR/pass-1/sfn"
)
readelf -h "$WORK_DIR/pass-1/sfn" | grep -Eq 'Machine:[[:space:]]+AArch64' \
	|| fail "pass-1 is not an AArch64 ELF executable"

printf '[bootstrap-aarch64] checking native pass-1\n'
"$WORK_DIR/pass-1/sfn" --version
"$WORK_DIR/pass-1/sfn" check "$ROOT/examples/basics/hello-world.sfn"

printf '[bootstrap-aarch64] building native pass-2\n'
(
	cd "$ROOT"
	SAILFIN_CC="$NATIVE_CC" SAILFIN_TARGET_ARCH=aarch64 \
		"$WORK_DIR/pass-1/sfn" build --no-cache -p compiler \
		--work-dir "$WORK_DIR/pass-2" -o "$WORK_DIR/pass-2/sfn"
)
cmp "$WORK_DIR/pass-1/sfn" "$WORK_DIR/pass-2/sfn" \
	|| fail "pass-1 and pass-2 differ; native compiler is not a binary fixed point"

"$WORK_DIR/pass-1/sfn" run "$ROOT/examples/basics/hello-world.sfn"
SAILFIN_BOOTSTRAP_PROBE_PATH="$WORK_DIR/aarch64-probe" \
	"$WORK_DIR/pass-1/sfn" run "$ROOT/compiler/tests/e2e/fixtures/aarch64_bootstrap_probe.sfn"

printf '[bootstrap-aarch64] fixed point: %s\n' "$(sha256sum "$WORK_DIR/pass-1/sfn" | awk '{print $1}')"
