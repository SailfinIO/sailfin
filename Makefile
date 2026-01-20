# Sailfin project automation

# Silence noisy clang warning when compiling embedded-IR modules that carry a
# different target triple than the host.
CLANG_WARN_SUPPRESS ?= -Wno-override-module

CLANG ?= clang

# Optimization level for building the native compiler binary.
# CI may override this to speed up builds.
NATIVE_OPT ?= -O2

# Extra flags used when compiling LLVM IR (.ll) with clang.
# Some distros ship clang builds that default to typed pointers, but the native
# compiler emits
# opaque-pointer IR using the `ptr` keyword. In that case, pass:
#   CLANG_LL_FLAGS=-mllvm -opaque-pointers
CLANG_LL_FLAGS ?=

# Parallelism for the compiler build orchestrator's per-module emit + clang compile.
# Keep conservative by default: this can increase peak memory.
BUILD_JOBS ?= 1

# Extra args passed through to the build orchestrator script.
BUILD_ARGS ?=

UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
TIMEOUT_CMD ?=
else
TIMEOUT_CMD ?= timeout
endif

# Bound clang when compiling LLVM IR modules in CI.
# GitHub Actions can cancel jobs that emit no output for long stretches;
# a single stuck clang process can otherwise stall the whole build.
NATIVE_LL_TIMEOUT_SECONDS ?= 600

CLANG_LL_COMPILE := $(CLANG)
ifneq ($(strip $(TIMEOUT_CMD)),)
CLANG_LL_COMPILE := $(TIMEOUT_CMD) --kill-after=10 $(NATIVE_LL_TIMEOUT_SECONDS) $(CLANG)
endif

NATIVE_OBJ_DIR ?= build/native/obj
NATIVE_OUT ?= build/native/sailfin
NATIVE_LINK_EXTRA ?=

# Preferred local path for the native compiler binary.
NATIVE_BIN ?= build/native/sailfin

# Which compiler binary to use for running Sailfin-native tests.
# Default: the native compiler alias produced by `make compile`.

.PHONY: help env install fetch-seed test test-unit test-integration test-e2e compile check package clean

.PHONY: ci-prepare-test-artifacts ci-package-native ci-package-installer

.PHONY: rebuild rebuild-asan smoke

# Back-compat aliases (deprecated; will be removed).
.PHONY: selfhost-native selfhost-native-asan selfhost-smoke-native

ifeq ($(origin CONDA_EXE), undefined)
# `conda` is often a shell function (e.g. in zsh/bash init). We need the actual
# executable path for Makefile recipes.
CONDA_EXE := $(shell { type -P conda 2>/dev/null || /usr/bin/which conda 2>/dev/null; } | head -n 1)
endif
ifneq ($(strip $(CONDA_EXE)),)
CONDA ?= $(CONDA_EXE)
endif
CONDA_ENV ?= sailfin
CONDA_ENV_FILE ?= environment.yml

help:
	@echo "Common Sailfin tasks"
	@echo "  make env          # Create or update the Conda env used for the compiler"
	@echo "  make install      # Install the built compiler binary into PREFIX/bin"
	@echo "  make fetch-seed   # Download the latest released seed into build/seed/ (requires GITHUB_TOKEN)"
	@echo "  make test         # Run Sailfin-native unit + integration tests"
	@echo "  make test-unit    # Run Sailfin-native unit tests (self-hosted compiler)"
	@echo "  make test-integration # Run Sailfin-native integration tests"
	@echo "  make test-e2e     # Run Sailfin-native end-to-end tests"
	@echo "  make compile      # Build the compiler by self-hosting from a released seed"
	@echo "  make package      # Build + package native artifacts into dist/"
	@echo "  make check        # Compile (if needed) then run the full test suite"
	@echo "  make rebuild      # Force rebuild the compiler from a released seed"
	@echo "  make rebuild-asan # Force rebuild with AddressSanitizer (diagnostic)"
	@echo "  make smoke        # Rebuild + run smoke tests"
	@echo "  make clean        # Remove packaged artifacts (dist/)"

PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin
INSTALL_NAME ?= sailfin

.PHONY: check-conda env install
check-conda:
	@if [ -z "$(CONDA)" ]; then \
		echo "[conda] conda executable not found. Export CONDA_EXE or install Conda."; \
		exit 1; \
	fi

env: check-conda
	$(CONDA) env update --file $(CONDA_ENV_FILE) --name $(CONDA_ENV)

install:
	@if [ ! -x "$(NATIVE_BIN)" ]; then \
		echo "[install] missing $(NATIVE_BIN); run 'make compile' first"; \
		exit 1; \
	fi
	@mkdir -p "$(DESTDIR)$(BINDIR)"
	@install -m 755 "$(NATIVE_BIN)" "$(DESTDIR)$(BINDIR)/$(INSTALL_NAME)"
	@echo "[install] installed $(DESTDIR)$(BINDIR)/$(INSTALL_NAME)"

test: test-unit test-integration test-e2e

# =============================================================================
# Seed management (download a released compiler)
# =============================================================================

# Install a released seed compiler into the workspace.
# Requires a GitHub token in GITHUB_TOKEN.
SEED_REPO ?= SailfinIO/sailfin
SEED_VERSION ?= latest
SEED_EXCLUDE_TAG ?=
SEED_INSTALL_BASE ?= build/seed/versions
SEED_GLOBAL_BIN_DIR ?= build/seed/bin

# Default seed compiler used for self-hosting (can be a command on PATH).
# Override with a full path if needed, e.g. SEED=build/seed/bin/sailfin.
SEED ?= sfn

FETCHED_SEED ?= $(SEED_GLOBAL_BIN_DIR)/sailfin

fetch-seed:
	@echo "[fetch-seed] installing seed into $(SEED_INSTALL_BASE)"
	@mkdir -p build/seed
	@REPO="$(SEED_REPO)" VERSION="$(SEED_VERSION)" EXCLUDE_TAG="$(SEED_EXCLUDE_TAG)" \
		GLOBAL_BIN_DIR="$(SEED_GLOBAL_BIN_DIR)" INSTALL_BASE="$(SEED_INSTALL_BASE)" \
		BINARY="sailfin" ./install.sh
	@if [ ! -x "$(FETCHED_SEED)" ]; then \
		echo "[fetch-seed][error] missing fetched seed compiler: $(FETCHED_SEED)" >&2; \
		exit 1; \
	fi
	@"$(FETCHED_SEED)" version
	@echo "[fetch-seed] hint: make compile SEED=$(FETCHED_SEED)"

test-unit:
	@if [ ! -x $(NATIVE_BIN) ]; then \
		echo "[test-unit] missing $(NATIVE_BIN); running make compile"; \
		$(MAKE) compile; \
	fi
	@set -e; \
	files=$$(find compiler/tests/unit -name '*_test.sfn' -print | sort); \
	if [ -z "$$files" ]; then \
		echo "[test-unit] no *_test.sfn files found under compiler/tests/unit"; \
		exit 1; \
	fi; \
	for f in $$files; do \
		$(NATIVE_BIN) test "$$f"; \
	done

test-integration:
	@if [ ! -x $(NATIVE_BIN) ]; then \
		echo "[test-integration] missing $(NATIVE_BIN); running make compile"; \
		$(MAKE) compile; \
	fi
	@set -e; \
	files=$$(find compiler/tests/integration -name '*_test.sfn' -print | sort); \
	if [ -z "$$files" ]; then \
		echo "[test-integration] no *_test.sfn files found under compiler/tests/integration"; \
		exit 1; \
	fi; \
	for f in $$files; do \
		$(NATIVE_BIN) test "$$f"; \
	done

test-e2e:
	@if [ ! -x $(NATIVE_BIN) ]; then \
		echo "[test-e2e] missing $(NATIVE_BIN); running make compile"; \
		$(MAKE) compile; \
	fi
	@set -e; \
	files=$$(find compiler/tests/e2e -name '*_test.sfn' -print | sort); \
	if [ -z "$$files" ]; then \
		echo "[test-e2e] no *_test.sfn files found under compiler/tests/e2e"; \
		exit 1; \
	fi; \
	for f in $$files; do \
		$(NATIVE_BIN) test "$$f"; \
	done

# Run the full Sailfin-native test suite using the *self-hosted* compiler.
# This ensures tests cover the same binary we intend to ship for 1.0.
.PHONY: test-selfhost
test-selfhost:
	@$(MAKE) test

clean:
	rm -rf dist

# Remove local build artifacts (keeps downloaded seed by default).
# Use KEEP_SEED=0 to also delete build/seed.
.PHONY: clean-build clean-all
clean-build:
	@mkdir -p build
	@for d in build/*; do \
		base="$$(basename "$$d")"; \
		if [ "$$base" = "seed" ] && [ "${KEEP_SEED:-1}" != "0" ]; then \
			continue; \
		fi; \
		rm -rf "$$d"; \
	done

# Full cleanup for a CI-like fresh start.
clean-all: clean clean-build

compile:
	@if [ -x "$(NATIVE_BIN)" ] && \
		[ -z "$$(find compiler/src runtime -type f \( -name '*.sfn' -o -name '*.py' \) -newer "$(NATIVE_BIN)" -print -quit 2>/dev/null)" ]; then \
		echo "[compile] $(NATIVE_BIN) up-to-date"; \
	else \
		$(MAKE) rebuild; \
		echo "[compile] built $(NATIVE_OUT)"; \
	fi

check: compile test

# =============================================================================
# Packaging (release artifacts)
# =============================================================================

package: check-conda
	@echo "[package] building + packaging native artifacts into dist/";
	$(CONDA) run --no-capture-output -n $(CONDA_ENV) python -u tools/package_native.py \
		--out dist \
		--compiler-bin "$(NATIVE_BIN)"

# =============================================================================
# CI helpers (used by .github/workflows/ci.yml)
# =============================================================================

# Prepare build artifacts in the locations expected by the Sailfin-native test
# runner (import context + runtime prelude object). CI builds via
# scripts/selfhost_native.py, which stages outputs under build/selfhost/native/.
ci-prepare-test-artifacts:
	@set -eu; \
	SRC="build/selfhost/native/seed_cwd/build/import-context"; \
	if [ ! -d "$$SRC" ]; then SRC="build/selfhost/native/seed_cwd/build/stage2"; fi; \
	if [ ! -d "$$SRC" ]; then \
		echo "[ci-prepare-test-artifacts][error] missing $$SRC (selfhost did not stage import artifacts?)" >&2; \
		find build/selfhost -maxdepth 5 -type d -name import-context -o -name stage2 -print || true; \
		exit 1; \
	fi; \
	rm -rf build/native/import-context; \
	mkdir -p build/native/import-context; \
	cp -a "$$SRC/." build/native/import-context/; \
	rm -rf build/stage2 2>/dev/null || true; \
	ln -s build/native/import-context build/stage2 2>/dev/null || { \
		mkdir -p build/stage2; \
		cp -a build/native/import-context/. build/stage2/; \
	}; \
	if [ ! -f build/selfhost/native/obj/runtime/prelude.o ]; then \
		echo "[ci-prepare-test-artifacts][error] missing build/selfhost/native/obj/runtime/prelude.o" >&2; \
		find build/selfhost -maxdepth 4 -type f -name 'prelude.o' -print || true; \
		exit 1; \
	fi; \
	mkdir -p build/native/obj/runtime; \
	cp -f build/selfhost/native/obj/runtime/prelude.o build/native/obj/runtime/prelude.o; \
	true

# Package native compiler artifacts for a given target label.
# Usage:
#   make ci-package-native TARGET=linux-x86_64
# Notes:
# - Requires the compiler already built at $(NATIVE_BIN).
# - Exposes the staged import context to the packager.
ci-package-native: check-conda
	@if [ -z "$(TARGET)" ]; then \
		echo "[ci-package-native][error] missing TARGET (e.g. linux-x86_64, macos-arm64)" >&2; \
		exit 1; \
	fi
	$(CONDA) run --no-capture-output -n $(CONDA_ENV) python -u tools/package_native.py \
		--skip-build \
		--target "$(TARGET)" \
		--out dist \
		--native-out build/native/import-context

# Create an installer payload (compiler + runtime bits) for a given target label.
# Produces: dist/installer-$(TARGET).tar.gz
ci-package-installer:
	@if [ -z "$(TARGET)" ]; then \
		echo "[ci-package-installer][error] missing TARGET (e.g. linux-x86_64, macos-arm64)" >&2; \
		exit 1; \
	fi
	@set -eu; \
	INSTALLER_DIR="dist/installer-$(TARGET)"; \
	rm -rf "$$INSTALLER_DIR"; \
	mkdir -p "$$INSTALLER_DIR/bin"; \
	cp -f "$(NATIVE_BIN)" "$$INSTALLER_DIR/bin/sailfin"; \
	cp -f "$(NATIVE_BIN)" "$$INSTALLER_DIR/bin/sfn"; \
	mkdir -p "$$INSTALLER_DIR/runtime"; \
	cp -R runtime/native "$$INSTALLER_DIR/runtime/native"; \
	mkdir -p "$$INSTALLER_DIR/runtime/native/obj"; \
	# prelude.o comes from selfhost build outputs; ensure ci-prepare-test-artifacts ran.
	if [ ! -f build/selfhost/native/obj/runtime/prelude.o ]; then \
		echo "[ci-package-installer][error] missing build/selfhost/native/obj/runtime/prelude.o" >&2; \
		exit 1; \
	fi; \
	cp -f build/selfhost/native/obj/runtime/prelude.o "$$INSTALLER_DIR/runtime/native/obj/prelude.o"; \
	tar -czf "dist/installer-$(TARGET).tar.gz" -C "$$INSTALLER_DIR" .

# Usage:
#   make rebuild
#   make rebuild SEED_NATIVE=path/to/sailfin
# Output:
#   build/native/sailfin
#
# Notes:
# - Defaults to a non-ASAN seed for speed.
# - Use `make rebuild-asan` for a slower-but-more-diagnostic ASAN build.
# - Always runs the orchestrator script via the Conda env Python.
# - Pass extra flags via BUILD_ARGS (e.g. BUILD_ARGS="--seed-timeout 300").
# - Parallelize module building via BUILD_JOBS (e.g. BUILD_JOBS=2).
rebuild: check-conda
	@seed="$${SEED_NATIVE:-$(SEED)}"; \
	resolved_seed="$$seed"; \
	if command -v "$$seed" >/dev/null 2>&1; then \
		resolved_seed="$$(command -v "$$seed")"; \
	fi; \
	seed="$$resolved_seed"; \
	if [ ! -x "$$seed" ]; then \
		echo "[rebuild] missing seed compiler: $$seed"; \
		echo "[rebuild] fetching seed with: make fetch-seed"; \
		$(MAKE) fetch-seed; \
		seed="$(FETCHED_SEED)"; \
	fi; \
	if [ ! -x "$$seed" ]; then \
		echo "[rebuild] missing seed compiler: $$seed"; \
		exit 1; \
	fi; \
	if ! "$$seed" emit native compiler/src/version.sfn >/dev/null 2>&1; then \
		echo "[rebuild][error] seed compiler does not support 'emit native'" >&2; \
		echo "[rebuild][error] install a newer seed (>= 0.1.1-alpha.115) or run: make fetch-seed" >&2; \
		exit 1; \
	fi; \
	if [ -d build/native/import-context ]; then \
		find build/native/import-context -type f \( -name '*.sfn-asm' -o -name '*.layout-manifest' \) -delete; \
	fi; \
	echo "[rebuild] running build script (seed=$$seed)..."; \
	$(CONDA) run --no-capture-output -n $(CONDA_ENV) python -u scripts/selfhost_native.py --seed "$$seed" --no-prefer-asan-seed --jobs $(BUILD_JOBS) $(BUILD_ARGS) --out $(NATIVE_OUT)
	@SRC="build/selfhost/native/seed_cwd/build/import-context"; \
	if [ ! -d "$$SRC" ]; then \
		echo "[rebuild][error] missing import-context output at $$SRC" >&2; \
		echo "[rebuild][error] ensure you're using a modern seed (or run: make fetch-seed)" >&2; \
		exit 1; \
	fi; \
	rm -rf build/native/import-context; \
	mkdir -p build/native/import-context; \
	cp -a "$$SRC/." build/native/import-context/
	@if [ -f build/selfhost/native/obj/runtime/prelude.o ]; then \
		mkdir -p build/native/obj/runtime; \
		cp -f build/selfhost/native/obj/runtime/prelude.o build/native/obj/runtime/prelude.o; \
	fi
	@mkdir -p build/native
	@echo "[rebuild] built $(NATIVE_OUT)"

# Smoke: selfhost native and run hello-world + emit-llvm-file.
# Usage:
#   make smoke
#   make smoke SEED_NATIVE=path/to/sailfin
#   make smoke SMOKE_ARGS="--keep-work-dir"
SMOKE_OUT ?= $(NATIVE_OUT)
SMOKE_ARGS ?=
smoke: check-conda
	@seed="$${SEED_NATIVE:-$(SEED)}"; \
	resolved_seed="$$seed"; \
	if command -v "$$seed" >/dev/null 2>&1; then \
		resolved_seed="$$(command -v "$$seed")"; \
	fi; \
	seed="$$resolved_seed"; \
	if [ ! -x "$$seed" ]; then \
		echo "[smoke] missing seed compiler: $$seed"; \
		echo "[smoke] fetching seed with: make fetch-seed"; \
		$(MAKE) fetch-seed; \
		seed="$(FETCHED_SEED)"; \
	fi; \
	if [ ! -x "$$seed" ]; then \
		echo "[smoke] missing seed compiler: $$seed"; \
		exit 1; \
	fi; \
	if ! "$$seed" emit native compiler/src/version.sfn >/dev/null 2>&1; then \
		echo "[smoke][error] seed compiler does not support 'emit native'" >&2; \
		echo "[smoke][error] install a newer seed (>= 0.1.1-alpha.115) or run: make fetch-seed" >&2; \
		exit 1; \
	fi; \
	echo "[smoke] running smoke harness..."; \
	$(CONDA) run --no-capture-output -n $(CONDA_ENV) python -u scripts/selfhost_smoke_native.py \
		--seed "$$seed" \
		--out $(SMOKE_OUT) \
		--jobs $(BUILD_JOBS) \
		--import-context-jobs 1 \
		$(SMOKE_ARGS)
	@echo "[smoke] OK"

rebuild-asan: check-conda
	@seed="$${SEED_NATIVE:-$(SEED)}"; \
	resolved_seed="$$seed"; \
	if command -v "$$seed" >/dev/null 2>&1; then \
		resolved_seed="$$(command -v "$$seed")"; \
	fi; \
	seed="$$resolved_seed"; \
	if [ ! -x "$$seed" ]; then \
		echo "[rebuild-asan] missing seed compiler: $$seed"; \
		echo "[rebuild-asan] fetching seed with: make fetch-seed"; \
		$(MAKE) fetch-seed; \
		seed="$(FETCHED_SEED)"; \
	fi; \
	if [ ! -x "$$seed" ]; then \
		echo "[rebuild-asan] missing seed compiler: $$seed"; \
		exit 1; \
	fi; \
	echo "[rebuild-asan] running build script (ASAN output; seed=$$seed)..."; \
	$(CONDA) run --no-capture-output -n $(CONDA_ENV) python -u scripts/selfhost_native.py --asan --seed "$$seed" --no-prefer-asan-seed --jobs $(BUILD_JOBS) $(BUILD_ARGS) --out build/native/sailfin-selfhost
	@echo "[rebuild-asan] built build/native/sailfin-selfhost"

# Deprecated aliases.
selfhost-native: rebuild
selfhost-smoke-native: smoke
selfhost-native-asan: rebuild-asan
