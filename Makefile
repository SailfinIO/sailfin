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

# Detect Windows (MSYS2/Git Bash/Cygwin on GitHub Actions runners).
IS_WINDOWS := $(if $(filter MINGW% MSYS% CYGWIN%,$(UNAME_S)),1,)

# Executable extension (.exe on Windows, empty elsewhere).
EXE_EXT := $(if $(IS_WINDOWS),.exe,)

ifeq ($(UNAME_S),Darwin)
TIMEOUT_CMD ?=
else ifeq ($(IS_WINDOWS),1)
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
NATIVE_OUT ?= build/native/sailfin$(EXE_EXT)
NATIVE_LINK_EXTRA ?=

# Preferred local path for the native compiler binary.
NATIVE_BIN ?= build/native/sailfin$(EXE_EXT)

# Which compiler binary to use for running Sailfin-native tests.
# Default: the native compiler alias produced by `make compile`.

.PHONY: help install fetch-seed test test-unit test-integration test-e2e compile check package clean bench

.PHONY: ci-prepare-test-artifacts ci-package ci-package-installer

.PHONY: rebuild

help:
	@echo "Common Sailfin tasks"
	@echo ""
	@echo "  make compile        # Build the compiler from a released seed"
	@echo "  make rebuild        # Force rebuild from seed (uses scripts/build.sh)"
	@echo "  make install        # Install the built compiler binary into PREFIX/bin"
	@echo "  make check          # Compile (if needed) then run the full test suite"
	@echo "  make test           # Run Sailfin-native unit + integration + e2e tests"
	@echo "  make test-unit      # Run Sailfin-native unit tests"
	@echo "  make test-integration # Run Sailfin-native integration tests"
	@echo "  make test-e2e       # Run Sailfin-native end-to-end tests"
	@echo "  make package        # Build + package native artifacts into dist/"
	@echo "  make fetch-seed     # Download the latest released seed"
	@echo "  make bench          # Benchmark per-module compile time and memory"
	@echo "  make clean          # Remove packaged artifacts (dist/)"
	@echo ""

PREFIX ?= $(HOME)/.local
BINDIR ?= $(PREFIX)/bin
INSTALL_NAME ?= sfn

install:
	@if [ ! -x "$(NATIVE_BIN)" ] && [ ! -f "$(NATIVE_BIN)" ]; then \
		echo "[install] missing $(NATIVE_BIN); run 'make compile' first"; \
		exit 1; \
	fi
	@mkdir -p "$(DESTDIR)$(BINDIR)"
ifeq ($(IS_WINDOWS),1)
	@cp -f "$(NATIVE_BIN)" "$(DESTDIR)$(BINDIR)/$(INSTALL_NAME)$(EXE_EXT)"
else
	@install -m 755 "$(NATIVE_BIN)" "$(DESTDIR)$(BINDIR)/$(INSTALL_NAME)"
endif
	@echo "[install] installed $(DESTDIR)$(BINDIR)/$(INSTALL_NAME)$(EXE_EXT)"

test: test-unit test-integration test-e2e

# =============================================================================
# Seed management (download a released compiler)
# =============================================================================

# Install a released seed compiler into the workspace.
# Requires a GitHub token in GITHUB_TOKEN.
SEED_REPO ?= SailfinIO/sailfin
SEED_VERSION ?= 0.5.2-alpha.1
SEED_EXCLUDE_TAG ?=
SEED_INSTALL_BASE ?= build/seed/versions
SEED_GLOBAL_BIN_DIR ?= build/seed/bin

# Default seed compiler used for self-hosting.
# Points to the fetched seed binary (0.5.2-alpha.1+).
SEED ?= build/seed/bin/sailfin

FETCHED_SEED ?= $(SEED_GLOBAL_BIN_DIR)/sailfin$(EXE_EXT)

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
	@pass=0; fail=0; failed_files=""; \
	files=$$(find compiler/tests/unit -name '*_test.sfn' -print | sort); \
	if [ -z "$$files" ]; then \
		echo "[test-unit] no *_test.sfn files found under compiler/tests/unit"; \
		exit 1; \
	fi; \
	for f in $$files; do \
		if bash scripts/run_native_test.sh $(NATIVE_BIN) "$$f"; then \
			pass=$$((pass + 1)); \
		else \
			fail=$$((fail + 1)); \
			failed_files="$$failed_files  $$(basename $$f)\n"; \
		fi; \
	done; \
	total=$$((pass + fail)); \
	echo ""; \
	echo "═══ unit: $$pass/$$total passed, $$fail failed ═══"; \
	if [ $$fail -gt 0 ]; then \
		echo ""; \
		printf "$$failed_files"; \
		exit 1; \
	fi

test-integration:
	@if [ ! -x $(NATIVE_BIN) ]; then \
		echo "[test-integration] missing $(NATIVE_BIN); running make compile"; \
		$(MAKE) compile; \
	fi
	@pass=0; fail=0; failed_files=""; \
	files=$$(find compiler/tests/integration -name '*_test.sfn' -print | sort); \
	if [ -z "$$files" ]; then \
		echo "[test-integration] no *_test.sfn files found under compiler/tests/integration"; \
		exit 1; \
	fi; \
	for f in $$files; do \
		if bash scripts/run_native_test.sh $(NATIVE_BIN) "$$f"; then \
			pass=$$((pass + 1)); \
		else \
			fail=$$((fail + 1)); \
			failed_files="$$failed_files  $$(basename $$f)\n"; \
		fi; \
	done; \
	total=$$((pass + fail)); \
	echo ""; \
	echo "═══ integration: $$pass/$$total passed, $$fail failed ═══"; \
	if [ $$fail -gt 0 ]; then \
		echo ""; \
		printf "$$failed_files"; \
		exit 1; \
	fi

test-e2e:
	@if [ ! -x $(NATIVE_BIN) ]; then \
		echo "[test-e2e] missing $(NATIVE_BIN); running make compile"; \
		$(MAKE) compile; \
	fi
	@pass=0; fail=0; failed_files=""; \
	files=$$(find compiler/tests/e2e -name '*_test.sfn' -print | sort); \
	if [ -z "$$files" ]; then \
		echo "[test-e2e] no *_test.sfn files found under compiler/tests/e2e"; \
		exit 1; \
	fi; \
	for f in $$files; do \
		if bash scripts/run_native_test.sh $(NATIVE_BIN) "$$f"; then \
			pass=$$((pass + 1)); \
		else \
			fail=$$((fail + 1)); \
			failed_files="$$failed_files  $$(basename $$f)\n"; \
		fi; \
	done; \
	for f in $$(find compiler/tests/e2e -name 'test_*.sh' -print | sort); do \
		if bash "$$f" $(NATIVE_BIN); then \
			pass=$$((pass + 1)); \
		else \
			fail=$$((fail + 1)); \
			failed_files="$$failed_files  $$(basename $$f)\n"; \
		fi; \
	done; \
	total=$$((pass + fail)); \
	echo ""; \
	echo "═══ e2e: $$pass/$$total passed, $$fail failed ═══"; \
	if [ $$fail -gt 0 ]; then \
		echo ""; \
		printf "$$failed_files"; \
		exit 1; \
	fi

# Run the full Sailfin-native test suite using the *self-hosted* compiler.
# This ensures tests cover the same binary we intend to ship for 1.0.
.PHONY: test-selfhost
test-selfhost:
	@$(MAKE) test

# Benchmark per-module compile time and peak memory.
# Usage:
#   make bench                           # all modules
#   make bench BENCH_ARGS="--top 10"     # top 10 slowest
#   make bench BENCH_ARGS="--csv build/bench.csv"
#   make bench BENCH_ARGS="--budget-time 60 --budget-mem 512000"
BENCH_ARGS ?=
bench:
	@if [ ! -x "$(NATIVE_BIN)" ]; then \
		echo "[bench] missing $(NATIVE_BIN); run 'make compile' first"; \
		exit 1; \
	fi
	@if [ ! -d build/native/import-context ]; then \
		echo "[bench] missing import-context; run 'make compile' first"; \
		exit 1; \
	fi
	@bash scripts/bench_compile.sh \
		--seed "$(NATIVE_BIN)" \
		--import-context build/native/import-context \
		$(BENCH_ARGS)

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
	@if [ "$${FORCE:-0}" = "0" ] && [ -x "$(NATIVE_BIN)" ] && \
		[ -z "$$(find compiler/src runtime -type f -name '*.sfn' -newer "$(NATIVE_BIN)" -print -quit 2>/dev/null)" ]; then \
		echo "[compile] $(NATIVE_BIN) up-to-date"; \
	else \
		$(MAKE) rebuild; \
		echo "[compile] built $(NATIVE_OUT)"; \
	fi

check:
	@$(MAKE) compile
	@seed="build/native/sailfin"; \
	if [ ! -x "$$seed" ]; then \
		echo "[check][error] missing $$seed (run: make compile)"; \
		exit 1; \
	fi
	@echo "[check] running test suite on first-pass binary (early gate)..."
	@$(MAKE) test NATIVE_BIN=build/native/sailfin
	@echo "[check] first-pass tests passed — proceeding to seedcheck build..."
	@echo "[check] verifying seed selfhost (stage2)..."
	@SEED="build/native/sailfin" OUT="build/native/sailfin-seedcheck" OPT="$(NATIVE_OPT)" JOBS="$(BUILD_JOBS)" CLANG="$(CLANG)" MAX_TOTAL=3600 \
		WORK_DIR="build/selfhost/native-seedcheck" \
		bash scripts/build.sh
	@echo "[check] validating seedcheck binary can run programs..."
	@sc="build/native/sailfin-seedcheck"; \
	output=$$(timeout 10 $$sc run examples/basics/hello-world.sfn 2>&1) || true; \
	if ! echo "$$output" | grep -q "Hello, Sailfin!"; then \
		echo "[check][FAIL] seedcheck binary cannot run hello-world.sfn (expected 'Hello, Sailfin!' in output)"; \
		echo "[check][FAIL] got: $$output"; \
		echo "[check][FAIL] the seedcheck compiler is NOT viable — fix the compiler, not the build script"; \
		exit 1; \
	fi; \
	echo "[check] seedcheck binary runs hello-world.sfn OK"
	@echo "[check] running test suite with seedcheck binary (no fallbacks)..."
	@$(MAKE) test NATIVE_BIN=build/native/sailfin-seedcheck
	@echo ""
	@echo "[check] stage2 tests passed — building stage3 for fixed-point comparison..."
	@SEED="build/native/sailfin-seedcheck" OUT="build/native/sailfin-stage3" OPT="$(NATIVE_OPT)" JOBS="$(BUILD_JOBS)" CLANG="$(CLANG)" MAX_TOTAL=3600 \
		WORK_DIR="build/selfhost/native-stage3" \
		bash scripts/build.sh
	@echo "[check] comparing stage2 vs stage3 LLVM IR (fixed-point check)..."
	@s2="build/selfhost/native-seedcheck/raw"; \
	s3="build/selfhost/native-stage3/raw"; \
	s2_hashes=$$(find "$$s2" -name '*.ll' -exec sha256sum {} + 2>/dev/null | awk '{print $$1}' | LC_ALL=C sort | sha256sum | awk '{print $$1}'); \
	s3_hashes=$$(find "$$s3" -name '*.ll' -exec sha256sum {} + 2>/dev/null | awk '{print $$1}' | LC_ALL=C sort | sha256sum | awk '{print $$1}'); \
	if [ "$$s2_hashes" = "$$s3_hashes" ]; then \
		echo "[check] stage2 == stage3: compiler is a fixed point ✓"; \
	else \
		echo "[check][WARN] stage2 != stage3: compiler output is not yet a fixed point"; \
		echo "[check][WARN] differing modules:"; \
		for f in $$s2/*.ll; do \
			base=$$(basename "$$f"); \
			s3f="$$s3/$$base"; \
			if [ -f "$$s3f" ]; then \
				h2=$$(sha256sum "$$f" | awk '{print $$1}'); \
				h3=$$(sha256sum "$$s3f" | awk '{print $$1}'); \
				if [ "$$h2" != "$$h3" ]; then \
					echo "[check][WARN]   $$base (stage2=$$(printf '%.12s' "$$h2")... stage3=$$(printf '%.12s' "$$h3")...)"; \
				fi; \
			else \
				echo "[check][WARN]   $$base (missing in stage3)"; \
			fi; \
		done; \
		echo "[check][WARN] this may indicate intermittent IR corruption — rerun or investigate"; \
	fi

# Pre-release determinism gate. Runs the emit harness at parallel load to
# detect intermittent IR corruption. Use before cutting a seed release.
# Override iteration count via CHECK_DET_ITERS (default 10).
CHECK_DET_ITERS ?= 10
CHECK_DET_JOBS ?= 4
check-determinism:
	@if [ ! -x "$(NATIVE_BIN)" ]; then \
		echo "[check-determinism] missing $(NATIVE_BIN) (run: make compile)"; \
		exit 1; \
	fi
	@echo "[check-determinism] running determinism sweep (jobs=$(CHECK_DET_JOBS) iters=$(CHECK_DET_ITERS))..."
	@bash scripts/diag_determinism_sweep.sh --seed "$(NATIVE_BIN)" --jobs $(CHECK_DET_JOBS) --iters $(CHECK_DET_ITERS)

# =============================================================================
# Packaging (release artifacts)
# =============================================================================

package:
	@echo "[package] building + packaging native artifacts into dist/"
	COMPILER_BIN="$(NATIVE_BIN)" OUT_DIR=dist bash tools/package.sh

# =============================================================================
# CI helpers (used by .github/workflows/ci.yml)
# =============================================================================

# Prepare build artifacts in the locations expected by the Sailfin-native test
# runner (import context + runtime prelude object). CI builds via
# scripts/build.sh, which stages outputs under build/selfhost/native/.
ci-prepare-test-artifacts:
	@set -eu; \
	SRC="build/selfhost/native/seed_cwd/build/native/import-context"; \
	if [ ! -d "$$SRC" ]; then \
		echo "[ci-prepare-test-artifacts][error] missing $$SRC (selfhost did not stage import artifacts?)" >&2; \
		find build/selfhost -maxdepth 5 -type d -name import-context -print || true; \
		exit 1; \
	fi; \
	rm -rf build/native/import-context; \
	mkdir -p build/native/import-context; \
	cp -a "$$SRC/." build/native/import-context/; \
	if [ ! -f build/selfhost/native/obj/runtime/prelude.o ]; then \
		echo "[ci-prepare-test-artifacts][error] missing build/selfhost/native/obj/runtime/prelude.o" >&2; \
		find build/selfhost -maxdepth 4 -type f -name 'prelude.o' -print || true; \
		exit 1; \
	fi; \
	mkdir -p build/native/obj/runtime; \
	cp -f build/selfhost/native/obj/runtime/prelude.o build/native/obj/runtime/prelude.o; \
	true

# Package native compiler + installer artifacts for a given target label.
# Uses tools/package.sh (pure bash, no Python dependency).
# Produces: dist/sailfin-native-<target>-<version>.tar.gz (+.sha256, +.manifest.json)
#           dist/installer-<target>.tar.gz
ci-package:
	@if [ -z "$(TARGET)" ]; then \
		echo "[ci-package][error] missing TARGET (e.g. linux-x86_64, macos-arm64)" >&2; \
		exit 1; \
	fi
	TARGET="$(TARGET)" COMPILER_BIN="$(NATIVE_BIN)" OUT_DIR=dist \
		bash tools/package.sh --skip-build

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
	cp -f "$(NATIVE_BIN)" "$$INSTALLER_DIR/bin/sailfin$(EXE_EXT)"; \
	cp -f "$(NATIVE_BIN)" "$$INSTALLER_DIR/bin/sfn$(EXE_EXT)"; \
	mkdir -p "$$INSTALLER_DIR/runtime"; \
	cp -R runtime/native "$$INSTALLER_DIR/runtime/native"; \
	mkdir -p "$$INSTALLER_DIR/runtime/native/obj"; \
	: "prelude.o comes from selfhost build outputs; ensure ci-prepare-test-artifacts ran."; \
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
# - Pass extra flags via BUILD_ARGS (e.g. BUILD_ARGS="--seed-timeout 300").
# - Parallelize module building via BUILD_JOBS (e.g. BUILD_JOBS=2).
rebuild:
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
	echo "[rebuild] running build (seed=$$seed)..."; \
	SEED="$$seed" OUT="$(NATIVE_OUT)" OPT="$(NATIVE_OPT)" JOBS="$(BUILD_JOBS)" CLANG="$(CLANG)" SEED_TIMEOUT=600 MAX_TOTAL=7200 \
		bash scripts/build.sh
	@SRC="build/selfhost/native/seed_cwd/build/native/import-context"; \
	if [ -d "$$SRC" ]; then \
		rm -rf build/native/import-context; \
		mkdir -p build/native/import-context; \
		cp -a "$$SRC/." build/native/import-context/; \
	fi
	@if [ -f build/selfhost/native/obj/runtime/prelude.o ]; then \
		mkdir -p build/native/obj/runtime; \
		cp -f build/selfhost/native/obj/runtime/prelude.o build/native/obj/runtime/prelude.o; \
	fi
	@mkdir -p build/native
	@echo "[rebuild] built $(NATIVE_OUT)"

# =============================================================================
# Cross-compile for Windows (from Linux, using MinGW-w64)
# =============================================================================
# Requires: x86_64-w64-mingw32-gcc, llvm-link (or llvm-link-18)
# Reuses the LLVM IR (.ll files) from the Linux selfhost build.
# Produces: build/windows/sailfin.exe + dist/ packaging artifacts.

MINGW_CC ?= x86_64-w64-mingw32-gcc
MINGW_TARGET := windows-x86_64

.PHONY: ci-cross-windows
ci-cross-windows:
	@set -eu; \
	echo "[cross-windows] cross-compiling for Windows from Linux LLVM IR..."; \
	RAW_DIR="build/selfhost/native/raw"; \
	if [ ! -d "$$RAW_DIR" ]; then \
		echo "[cross-windows][error] missing $$RAW_DIR (run 'make rebuild' first)" >&2; \
		exit 1; \
	fi; \
	WIN_OBJ="build/windows/obj"; \
	WIN_OUT="build/windows/sailfin.exe"; \
	rm -rf build/windows; \
	mkdir -p "$$WIN_OBJ/runtime"; \
	\
	echo "[cross-windows] finding llvm-link..."; \
	LLVM_LINK=""; \
	for cand in llvm-link llvm-link-18 llvm-link-17 llvm-link-16; do \
		if command -v "$$cand" >/dev/null 2>&1; then \
			LLVM_LINK="$$cand"; \
			break; \
		fi; \
	done; \
	if [ -z "$$LLVM_LINK" ]; then \
		echo "[cross-windows][error] llvm-link not found" >&2; \
		exit 1; \
	fi; \
	echo "[cross-windows] using $$LLVM_LINK"; \
	\
	echo "[cross-windows] collecting .ll modules..."; \
	LL_FILES=""; \
	PRELUDE_LL=""; \
	for f in "$$RAW_DIR"/*.ll; do \
		base="$$(basename "$$f")"; \
		case "$$base" in \
			*.attempt*|*.clean*) continue ;; \
			runtime__prelude.ll) PRELUDE_LL="$$f"; continue ;; \
		esac; \
		LL_FILES="$$LL_FILES $$f"; \
	done; \
	\
	echo "[cross-windows] linking IR modules..."; \
	$$LLVM_LINK -o "$$WIN_OBJ/sailfin.linked.bc" $$LL_FILES 2>&1 || \
		$$LLVM_LINK --opaque-pointers -o "$$WIN_OBJ/sailfin.linked.bc" $$LL_FILES; \
	\
	echo "[cross-windows] compiling linked bitcode -> .o"; \
	$(CLANG) -target x86_64-w64-mingw32 $(NATIVE_OPT) -fno-delete-null-pointer-checks \
		-c "$$WIN_OBJ/sailfin.linked.bc" -o "$$WIN_OBJ/native.linked.o"; \
	\
	echo "[cross-windows] compiling prelude..."; \
	if [ -n "$$PRELUDE_LL" ]; then \
		$(CLANG) -target x86_64-w64-mingw32 $(NATIVE_OPT) -fno-delete-null-pointer-checks \
			-c "$$PRELUDE_LL" -o "$$WIN_OBJ/runtime/prelude.o"; \
	fi; \
	\
	echo "[cross-windows] compiling C runtime..."; \
	$(MINGW_CC) -O2 -I runtime/native/include -c runtime/native/src/sailfin_runtime.c \
		-o "$$WIN_OBJ/sailfin_runtime.o"; \
	$(MINGW_CC) -O2 -I runtime/native/include -c runtime/native/src/sailfin_sha256.c \
		-o "$$WIN_OBJ/sailfin_sha256.o"; \
	$(MINGW_CC) -O2 -I runtime/native/include -c runtime/native/src/sailfin_base64.c \
		-o "$$WIN_OBJ/sailfin_base64.o"; \
	$(MINGW_CC) -O2 -I runtime/native/include -c runtime/native/src/native_driver.c \
		-o "$$WIN_OBJ/native_driver.o"; \
	$(CLANG) -target x86_64-w64-mingw32 $(NATIVE_OPT) -c runtime/native/ir/runtime_globals.ll \
		-o "$$WIN_OBJ/runtime_globals.o"; \
	\
	echo "[cross-windows] compiling cross-module shim (if present)..."; \
	SHIM_O=""; \
	SHIM_C="build/selfhost/native/obj/cross_module_shim.c"; \
	if [ -f "$$SHIM_C" ]; then \
		cp "$$SHIM_C" "$$WIN_OBJ/cross_module_shim.c"; \
		$(MINGW_CC) -O2 -c "$$WIN_OBJ/cross_module_shim.c" -o "$$WIN_OBJ/cross_module_shim.o"; \
		SHIM_O="$$WIN_OBJ/cross_module_shim.o"; \
	fi; \
	\
	echo "[cross-windows] linking sailfin.exe..."; \
	$(MINGW_CC) -static -o "$$WIN_OUT" \
		"$$WIN_OBJ/sailfin_runtime.o" \
		"$$WIN_OBJ/sailfin_sha256.o" \
		"$$WIN_OBJ/sailfin_base64.o" \
		"$$WIN_OBJ/native_driver.o" \
		"$$WIN_OBJ/runtime_globals.o" \
		"$$WIN_OBJ/native.linked.o" \
		"$$WIN_OBJ/runtime/prelude.o" \
		$$SHIM_O \
		-lm -lpthread; \
	\
	echo "[cross-windows] built $$WIN_OUT"; \
	ls -lh "$$WIN_OUT"; \
	(file "$$WIN_OUT" || true); \
	\
	echo "[cross-windows] packaging..."; \
	INSTALLER_DIR="dist/installer-$(MINGW_TARGET)"; \
	rm -rf "$$INSTALLER_DIR"; \
	mkdir -p "$$INSTALLER_DIR/bin"; \
	cp -f "$$WIN_OUT" "$$INSTALLER_DIR/bin/sailfin.exe"; \
	cp -f "$$WIN_OUT" "$$INSTALLER_DIR/bin/sfn.exe"; \
	mkdir -p "$$INSTALLER_DIR/runtime/native/obj"; \
	cp -R runtime/native "$$INSTALLER_DIR/runtime/native"; \
	if [ -f "$$WIN_OBJ/runtime/prelude.o" ]; then \
		mkdir -p "$$INSTALLER_DIR/runtime/native/obj"; \
		cp -f "$$WIN_OBJ/runtime/prelude.o" "$$INSTALLER_DIR/runtime/native/obj/prelude.o"; \
	fi; \
	tar -czf "dist/installer-$(MINGW_TARGET).tar.gz" -C "$$INSTALLER_DIR" .; \
	echo "[cross-windows] done: dist/installer-$(MINGW_TARGET).tar.gz"
