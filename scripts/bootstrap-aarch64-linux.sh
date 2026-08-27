#!/usr/bin/env bash
set -euo pipefail

# Bootstrap the first native aarch64-Linux compiler from the pinned x86_64
# seed. See docs/build-aarch64-linux.md and SFEP-0056 section 3.4.

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
WORK_DIR="${SAILFIN_AARCH64_BOOTSTRAP_DIR:-$ROOT/build/aarch64-bootstrap}"
SEED_X86_64="${SEED_X86_64:-${1:-}}"
QEMU_X86_64="${QEMU_X86_64:-qemu-x86_64}"
NATIVE_CC="${SAILFIN_NATIVE_CC:-clang}"
BINFMT_DIR="${SAILFIN_BINFMT_DIR-/proc/sys/fs/binfmt_misc}"

fail() {
	printf '[bootstrap-aarch64][error] %s\n' "$*" >&2
	exit 1
}

# Set-but-empty must not silently fall back to the host mount: a caller that
# meant to redirect the probe would instead assert against the real machine.
[ -n "$BINFMT_DIR" ] || fail "SAILFIN_BINFMT_DIR is set but empty"

need() {
	command -v "$1" >/dev/null 2>&1 || fail "required command not found: $1"
}

# Probe the registration entries by name and never read the two control nodes.
# `register` is created write-only (S_IWUSR, no read handler), so reading it
# always fails: EACCES for an unprivileged runner, EINVAL for root. A probe
# that hands the whole directory to one `grep` therefore inherits grep's exit
# status 2 no matter what it matched, and under `pipefail` that turns a
# successful match into "not registered" — which rejected every host where
# qemu-x86_64 was already enabled in the kernel.
x86_64_binfmt_registered() {
	local entry name

	# binfmt_misc can be mounted with dispatch globally disabled, in which
	# case an enabled entry still never fires.
	if [ -r "$BINFMT_DIR/status" ] && ! grep -qx enabled "$BINFMT_DIR/status"; then
		return 1
	fi

	for entry in "$BINFMT_DIR"/*; do
		[ -f "$entry" ] && [ -r "$entry" ] || continue
		name="${entry##*/}"
		case "$name" in
			register | status) continue ;;
		esac
		grep -qx enabled "$entry" || continue
		case "$name" in
			*x86_64* | *x86-64*) return 0 ;;
		esac
		if grep -Eq '^interpreter[[:space:]].*(x86_64|x86-64)' "$entry"; then
			return 0
		fi
		# Ground truth, for a handler whose name and interpreter path carry
		# no arch string: the ELF magic ends in e_machine EM_X86_64 (0x3e,
		# little-endian) after e_type.
		if grep -Eq '^magic [0-9a-f]*02003e00' "$entry"; then
			return 0
		fi
	done
	return 1
}

binfmt_entries() {
	ls "$BINFMT_DIR" 2>/dev/null | tr '\n' ' '
}

# Regression seam: run only the probe, against SAILFIN_BINFMT_DIR, and report
# the verdict as the exit status. The gate itself is reachable on an aarch64
# host with a live binfmt_misc mount; this keeps its logic coverable from a
# test on any Linux host.
if [ "${SAILFIN_BINFMT_PROBE_ONLY:-0}" = "1" ]; then
	if x86_64_binfmt_registered; then
		printf '[bootstrap-aarch64] x86_64 binfmt registration detected in %s\n' "$BINFMT_DIR"
		exit 0
	fi
	printf '[bootstrap-aarch64] no usable x86_64 binfmt registration in %s (entries: %s)\n' \
		"$BINFMT_DIR" "$(binfmt_entries)"
	exit 1
fi

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
[ -d "$BINFMT_DIR" ] || fail "binfmt_misc is not mounted at $BINFMT_DIR"

# Global dispatch is a different knob from per-entry state, and
# `update-binfmts --enable` cannot reach it — remediating below would fail a
# second time and blame the entry. Diagnose it here with its own remedy.
if [ -r "$BINFMT_DIR/status" ] && ! grep -qx enabled "$BINFMT_DIR/status"; then
	fail "binfmt_misc dispatch is globally disabled; run: echo 1 | sudo tee $BINFMT_DIR/status"
fi

if ! x86_64_binfmt_registered; then
	printf '[bootstrap-aarch64] enabling qemu-x86_64 binfmt registration\n'
	if [ "$(id -u)" -eq 0 ] && command -v update-binfmts >/dev/null 2>&1; then
		update-binfmts --enable qemu-x86_64
	elif command -v sudo >/dev/null 2>&1 && sudo -n true 2>/dev/null && command -v update-binfmts >/dev/null 2>&1; then
		sudo -n update-binfmts --enable qemu-x86_64
	else
		fail "cannot register x86_64 binfmt non-interactively; install qemu-user-binfmt and run: sudo update-binfmts --enable qemu-x86_64"
	fi
	x86_64_binfmt_registered \
		|| fail "x86_64 binfmt registration is still unavailable after update-binfmts (entries: $(binfmt_entries))"
fi

rm -rf "$WORK_DIR"
mkdir -p "$WORK_DIR/bin" "$WORK_DIR/compiler-a" "$WORK_DIR/pass-1" "$WORK_DIR/pass-2"

# Read an ELF's machine name without a pipeline: `readelf … | grep -q` reports
# the *pipeline's* status under `pipefail`, so a readelf that fails — or is
# killed by SIGPIPE when grep exits on first match — makes a correct binary
# look wrong. That is the same failure shape that made the binfmt probe reject
# hosts where the registration was already live.
elf_machine() {
	readelf -h "$1" 2>/dev/null | sed -n 's/^[[:space:]]*Machine:[[:space:]]*//p'
}

# The seed resolves its C compiler by looking up the bare name `clang` on PATH
# (`process.run(["clang", …])`) and emits target-neutral IR carrying no target
# triple, so whichever `clang` PATH finds decides the output architecture.
# `SAILFIN_CC` cannot steer the seed here — the macOS clang shim, which moved
# from the retired Makefile into `.github/actions/sailfin-build/action.yml`
# (SFN-60), works precisely by shadowing `clang` on PATH instead. Stage 1 previously set
# `SAILFIN_CC` to a wrapper named `clang-x86_64`, which nothing ever invoked,
# so the emulated x86_64 seed built compiler A with the host's native aarch64
# clang and the readelf gate correctly rejected the result.
#
# Shadow `clang` itself, in a directory prepended to PATH for stage 1 only:
# stages 2 and 3 target aarch64 and want the native compiler.
CROSS_BIN="$WORK_DIR/bin/x86_64"
mkdir -p "$CROSS_BIN"

# Bake an absolute path into the wrapper. The wrapper is itself named `clang`
# and runs with its own directory first on PATH, so a bare name here re-resolves
# to the wrapper and forks until the machine dies — which is what `NATIVE_CC`
# defaults to when SAILFIN_NATIVE_CC is unset, as it is for a local run.
NATIVE_CC_PATH="$(command -v "$NATIVE_CC")" \
	|| fail "cannot resolve the native C compiler: $NATIVE_CC"

cat >"$CROSS_BIN/clang" <<EOF
#!/usr/bin/env bash
# The host linker is an aarch64 GNU ld and cannot link x86_64 objects. Use
# LLVM's architecture-neutral linker for this cross stage explicitly.
exec "$NATIVE_CC_PATH" --target=x86_64-linux-gnu -fuse-ld=lld "\$@"
EOF
chmod +x "$CROSS_BIN/clang"

# Prove the cross toolchain works before spending ~30 minutes of emulated
# build on it. This catches both ways stage 1 can be misconfigured: the
# shadowing not taking effect (object comes out aarch64) and a missing x86_64
# CRT/libgcc sysroot (compiles but cannot link).
printf '[bootstrap-aarch64] verifying the x86_64 cross toolchain\n'
printf 'int main(void) { return 0; }\n' >"$WORK_DIR/cross-probe.c"
PATH="$CROSS_BIN:$PATH" clang -c "$WORK_DIR/cross-probe.c" -o "$WORK_DIR/cross-probe.o" \
	|| fail "the shadowed x86_64 clang cannot compile an object"
case "$(elf_machine "$WORK_DIR/cross-probe.o")" in
	"Advanced Micro Devices X86-64" | "AMD x86-64") ;;
	*) fail "PATH shadowing is not taking effect: the probe object is $(elf_machine "$WORK_DIR/cross-probe.o"), not x86_64" ;;
esac
PATH="$CROSS_BIN:$PATH" clang "$WORK_DIR/cross-probe.c" -o "$WORK_DIR/cross-probe" \
	|| fail "x86_64 cross link with LLD failed; verify lld and the amd64 CRT/libgcc development packages (libc6-dev:amd64 and libgcc-*-dev:amd64)"

run_x86() {
	local binary="$1"
	shift
	"$QEMU_X86_64" "$binary" "$@"
}

printf '[bootstrap-aarch64] building arch-aware x86_64 compiler A\n'
(
	cd "$ROOT"
	PATH="$CROSS_BIN:$PATH" SAILFIN_TARGET_ARCH=x86_64 \
		run_x86 "$SEED_X86_64" build --no-cache -p compiler \
		--work-dir "$WORK_DIR/compiler-a" -o "$WORK_DIR/compiler-a/sfn"
)
case "$(elf_machine "$WORK_DIR/compiler-a/sfn")" in
	"Advanced Micro Devices X86-64" | "AMD x86-64") ;;
	*) fail "compiler A is not an x86_64 ELF executable (machine: $(elf_machine "$WORK_DIR/compiler-a/sfn"))" ;;
esac

printf '[bootstrap-aarch64] building native pass-1 with compiler A\n'
(
	cd "$ROOT"
	# SFEP-0056 section 3.4 makes compiler A the vehicle for this pass;
	# redispatching to a host-native pinned seed would undo the bootstrap.
	SAILFIN_BOOTSTRAP=off SAILFIN_TARGET_ARCH=aarch64 \
		run_x86 "$WORK_DIR/compiler-a/sfn" build --no-cache -p compiler \
		--work-dir "$WORK_DIR/pass-1" -o "$WORK_DIR/pass-1/sfn"
)
case "$(elf_machine "$WORK_DIR/pass-1/sfn")" in
	AArch64) ;;
	*) fail "pass-1 is not an AArch64 ELF executable (machine: $(elf_machine "$WORK_DIR/pass-1/sfn"))" ;;
esac

printf '[bootstrap-aarch64] checking native pass-1\n'
"$WORK_DIR/pass-1/sfn" --version
"$WORK_DIR/pass-1/sfn" check "$ROOT/examples/basics/hello-world.sfn"

printf '[bootstrap-aarch64] building native pass-2\n'
(
	cd "$ROOT"
	# Pass-1 is now the self-hosting vehicle; keep the same SFEP-0056 chain.
	SAILFIN_BOOTSTRAP=off SAILFIN_TARGET_ARCH=aarch64 \
		"$WORK_DIR/pass-1/sfn" build --no-cache -p compiler \
		--work-dir "$WORK_DIR/pass-2" -o "$WORK_DIR/pass-2/sfn"
)
cmp "$WORK_DIR/pass-1/sfn" "$WORK_DIR/pass-2/sfn" \
	|| fail "pass-1 and pass-2 differ; native compiler is not a binary fixed point"

"$WORK_DIR/pass-1/sfn" run "$ROOT/examples/basics/hello-world.sfn"
SAILFIN_BOOTSTRAP_PROBE_PATH="$WORK_DIR/aarch64-probe" \
	"$WORK_DIR/pass-1/sfn" run "$ROOT/compiler/tests/e2e/fixtures/aarch64_bootstrap_probe.sfn"

printf '[bootstrap-aarch64] fixed point: %s\n' "$(sha256sum "$WORK_DIR/pass-1/sfn" | awk '{print $1}')"
