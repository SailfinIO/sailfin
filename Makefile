# Sailfin project automation

# Force bash so recipes can rely on bash-isms (`<()` process substitution,
# `[[ ]]` test syntax, etc.) and so the Sailfin compiler's `process.run`
# invocations don't hit a `/bin/sh`-specific quirk that makes the seed
# segfault during `sfn build -p compiler`. Plain dash on Ubuntu has been
# observed to crash the seed reproducibly via Make even though direct
# bash invocations of the same command succeed; switching the recipe
# shell to bash sidesteps the issue and matches what `scripts/build.sh`
# (`#!/usr/bin/env bash`) already assumed.
SHELL := /bin/bash

# Silence noisy clang warning when compiling embedded-IR modules that carry a
# different target triple than the host.
CLANG_WARN_SUPPRESS ?= -Wno-override-module

CLANG ?= clang

# Optimization level for building the native compiler binary.
# CI may override this to speed up builds.
NATIVE_OPT ?= -O2

# Optimization level for `make check`'s first-pass binary. The first-pass
# binary only has to be correct enough to compile itself one more time; it is
# never shipped, so the clang -O2 cost on its 121-module .ll → .o stage is
# pure waste in the validation flow. Seedcheck and stage3 keep $(NATIVE_OPT)
# because *they* are the ones that have to byte-fixed-point against each
# other. See docs/build-performance.md → Phase 6 follow-ups.
SELFHOST1_OPT ?= -O0

# Extra flags used when compiling LLVM IR (.ll) with clang.
# Some distros ship clang builds that default to typed pointers, but the native
# compiler emits
# opaque-pointer IR using the `ptr` keyword. In that case, pass:
#   CLANG_LL_FLAGS=-mllvm -opaque-pointers
CLANG_LL_FLAGS ?=

# Extra args passed through to the build orchestrator script.
BUILD_ARGS ?=

UNAME_S := $(shell uname -s)

# Detect Windows (MSYS2/Git Bash/Cygwin on GitHub Actions runners).
IS_WINDOWS := $(if $(filter MINGW% MSYS% CYGWIN%,$(UNAME_S)),1,)

# Executable extension (.exe on Windows, empty elsewhere).
EXE_EXT := $(if $(IS_WINDOWS),.exe,)

ifeq ($(UNAME_S),Darwin)
# macOS ships no GNU `timeout`; pick up `gtimeout` from homebrew coreutils if present.
# Empty is an acceptable fallback — callers must guard on non-empty before invoking.
TIMEOUT_CMD ?= $(shell command -v gtimeout 2>/dev/null)
else ifeq ($(IS_WINDOWS),1)
TIMEOUT_CMD ?=
else
TIMEOUT_CMD ?= timeout
endif

# Parallelism for the compiler build orchestrator's per-module emit + clang
# compile (passed through to scripts/build.sh as JOBS).
#
# Default: auto-detected from CPU count and total RAM via
# scripts/detect_build_jobs.sh, with a per-job budget of 5 GB (heaviest module
# ~4.7 GB peak RSS under the arena allocator, plus headroom). macOS additionally
# caps at 2 because the M1 GitHub runner has only 7 GB total RAM. Windows / hosts
# we cannot probe fall back to 1.
#
# Override explicitly with `BUILD_JOBS=N` (or the legacy `make rebuild
# BUILD_JOBS=4`); empty / unset uses auto-detect. See docs/build-performance.md
# → Phase 6 for the rollout plan and the per-job budget rationale.
ifeq ($(strip $(BUILD_JOBS)),)
BUILD_JOBS := $(shell bash scripts/detect_build_jobs.sh 2>/dev/null || echo 1)
endif

# Portable SHA-256 hasher. `shasum -a 256` ships with Perl on both macOS and
# every Linux distro we run on; `sha256sum` is GNU coreutils and not on macOS
# by default. Using `shasum` keeps the fixed-point comparison in `check`
# portable without adding a brew dep to CI.
HASH_CMD ?= shasum -a 256

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

.PHONY: help install fetch-seed test test-unit test-integration test-e2e compile check check-fast package clean bench test-arena

.PHONY: ci-prepare-test-artifacts ci-package ci-package-installer

.PHONY: rebuild mcp-server

help:
	@echo "Common Sailfin tasks"
	@echo ""
	@echo "  make compile        # Build the compiler from a released seed"
	@echo "  make rebuild        # Force rebuild from seed via 'sfn build -p compiler'"
	@echo "  make install        # Install the built compiler binary into PREFIX/bin"
	@echo "  make check          # Compile (if needed) then run the full test suite"
	@echo "  make check-fast     # Run sfn check on compiler/src/ + runtime/ (no codegen, fast PR gate)"
	@echo "  make test           # Run Sailfin-native unit + integration + e2e tests"
	@echo "  make test-unit      # Run Sailfin-native unit tests"
	@echo "  make test-integration # Run Sailfin-native integration tests"
	@echo "  make test-e2e       # Run Sailfin-native end-to-end tests"
	@echo "  make package        # Build + package native artifacts into dist/"
	@echo "  make fetch-seed     # Download the latest released seed"
	@echo "  make bench          # Benchmark per-module compile time and memory"
	@echo "  make mcp-server     # Build the Sailfin MCP server (tools/mcp-server)"
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
#
# The canonical seed version lives in `.seed-version` at the repo root —
# every CI workflow reads that same file via a setup step so the four
# pins (Makefile + 4 workflows) never drift again. See the header of
# `.github/workflows/ci.yml` for the workflow-side plumbing.
SEED_REPO ?= SailfinIO/sailfin
SEED_VERSION ?= $(strip $(shell cat .seed-version 2>/dev/null))
SEED_EXCLUDE_TAG ?=
SEED_INSTALL_BASE ?= build/seed/versions
SEED_GLOBAL_BIN_DIR ?= build/seed/bin

# Default seed compiler used for self-hosting.
# Points to the fetched seed binary (0.5.7+ — the first release whose
# binary image does not carry the re-export miscompilation documented
# in docs/rca/2026-04-18-reexport-diagnostic-gep.md).
SEED ?= build/seed/bin/sailfin

FETCHED_SEED ?= $(SEED_GLOBAL_BIN_DIR)/sailfin$(EXE_EXT)

fetch-seed:
	@if [ -z "$(SEED_VERSION)" ]; then \
		echo "[fetch-seed][error] SEED_VERSION is empty." >&2; \
		echo "[fetch-seed][error] The pin lives in .seed-version at the repo root." >&2; \
		if [ ! -f .seed-version ]; then \
			echo "[fetch-seed][error] .seed-version is missing — restore it or pass SEED_VERSION=... explicitly." >&2; \
		else \
			echo "[fetch-seed][error] .seed-version is present but empty — write a version (e.g. 0.5.9) to it." >&2; \
		fi; \
		exit 1; \
	fi
	@echo "[fetch-seed] installing seed $(SEED_VERSION) into $(SEED_INSTALL_BASE)"
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

# =============================================================================
# Arena correctness gate (Phase 0 / M0.5 prerequisite)
# =============================================================================
# Compiles a module twice (with and without SAILFIN_USE_ARENA=1) and diffs
# the emitted LLVM IR. Until the arena allocator lands, the env var is a
# no-op and the diff is trivially identical — the harness still validates.
# Once M0.5 lands (see docs/runtime_architecture.md §4.4), this becomes the
# correctness gate: any divergence means the arena is corrupting output.
#
# Usage:
#   make test-arena                         # default: examples/basics/hello-world.sfn
#   make test-arena ARENA_ARGS="--all"      # all examples/basics/*.sfn
#   make test-arena ARENA_ARGS="examples/basics/functions.sfn"
ARENA_ARGS ?=
test-arena:
	@if [ ! -x "$(NATIVE_BIN)" ]; then \
		echo "[test-arena] missing $(NATIVE_BIN); run 'make compile' first"; \
		exit 1; \
	fi
	@if [ ! -d build/native/import-context ]; then \
		echo "[test-arena] missing import-context; run 'make compile' first"; \
		exit 1; \
	fi
	@SEED="$(NATIVE_BIN)" \
		IMPORT_CONTEXT=build/native/import-context \
		bash scripts/test_arena.sh $(ARENA_ARGS)

clean:
	rm -rf dist

# Build the Sailfin MCP server so agentic clients (Claude Code, Claude Desktop,
# Inspector) can reach the compiler as tool calls. `.mcp.json` at the repo root
# points at tools/mcp-server/dist/index.js, which this target produces.
mcp-server:
	cd tools/mcp-server && npm ci --no-audit --no-fund && npm run build

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
	@$(MAKE) compile NATIVE_OPT="$(SELFHOST1_OPT)"
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
	to="$(TIMEOUT_CMD)"; \
	if [ -n "$$to" ]; then \
		output=$$("$$to" 10 $$sc run examples/basics/hello-world.sfn 2>&1) || true; \
	else \
		output=$$($$sc run examples/basics/hello-world.sfn 2>&1) || true; \
	fi; \
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
	s2_hashes=$$(find "$$s2" -name '*.ll' -exec $(HASH_CMD) {} + 2>/dev/null | awk '{print $$1}' | LC_ALL=C sort | $(HASH_CMD) | awk '{print $$1}'); \
	s3_hashes=$$(find "$$s3" -name '*.ll' -exec $(HASH_CMD) {} + 2>/dev/null | awk '{print $$1}' | LC_ALL=C sort | $(HASH_CMD) | awk '{print $$1}'); \
	if [ "$$s2_hashes" = "$$s3_hashes" ]; then \
		echo "[check] stage2 == stage3: compiler is a fixed point ✓"; \
	else \
		echo "[check][WARN] stage2 != stage3: compiler output is not yet a fixed point"; \
		echo "[check][WARN] differing modules:"; \
		for f in $$s2/*.ll; do \
			base=$$(basename "$$f"); \
			s3f="$$s3/$$base"; \
			if [ -f "$$s3f" ]; then \
				h2=$$($(HASH_CMD) "$$f" | awk '{print $$1}'); \
				h3=$$($(HASH_CMD) "$$s3f" | awk '{print $$1}'); \
				if [ "$$h2" != "$$h3" ]; then \
					echo "[check][WARN]   $$base (stage2=$$(printf '%.12s' "$$h2")... stage3=$$(printf '%.12s' "$$h3")...)"; \
				fi; \
			else \
				echo "[check][WARN]   $$base (missing in stage3)"; \
			fi; \
		done; \
		echo "[check][WARN] this may indicate intermittent IR corruption — rerun or investigate"; \
	fi
	@# Promote the fully-validated, $(NATIVE_OPT)-built seedcheck binary back
	@# over the canonical $(NATIVE_BIN) path. The first-pass binary is built
	@# with $(SELFHOST1_OPT) (default -O0) for speed; without this promotion
	@# step a subsequent `make compile` would see a stale -O0 binary as
	@# "up-to-date" and skip the rebuild.
	@if [ -x "build/native/sailfin-seedcheck$(EXE_EXT)" ]; then \
		cp -f "build/native/sailfin-seedcheck$(EXE_EXT)" "$(NATIVE_BIN)"; \
		echo "[check] promoted seedcheck → $(NATIVE_BIN)"; \
	fi

# Fast PR-feedback gate: run `sfn check` against the compiler tree and
# the runtime prelude. No codegen, no clang, just parse + typecheck +
# effect-check. Phase 5a's arena mark/rewind keeps the in-process
# multi-module loop from blowing up; the arena default-on flip means
# this works without env-var setup.
#
# Targeted at CI as a pre-`make compile` filter so PRs that introduce
# obvious type/effect regressions fail in seconds rather than ~3 min
# into the full build. Local developers can run it as a sub-30s
# sanity check between edits — much faster than `make compile` (~3
# min serial / ~2 min parallel).
#
# Note: this is `sfn check` over the compiler tree, not `make check`
# (the triple-pass selfhost validator). Naming mirrors what end users
# of the language will eventually run on their own capsules.
check-fast:
	@if [ ! -x "$(NATIVE_BIN)" ] && [ ! -f "$(NATIVE_BIN)" ]; then \
		echo "[check-fast] missing $(NATIVE_BIN); run: make compile"; \
		exit 1; \
	fi
	@echo "[check-fast] running sfn check on compiler/src/ runtime/"
	@$(NATIVE_BIN) check compiler/src/ runtime/
	@echo "[check-fast] OK"

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

package: compile
	@echo "[package] building + packaging native artifacts into dist/"
	@$(NATIVE_BIN) package --out dist --compiler-bin $(NATIVE_BIN)
	@$(NATIVE_BIN) package --installer --out dist --compiler-bin $(NATIVE_BIN)

# =============================================================================
# CI helpers (used by .github/workflows/ci.yml)
# =============================================================================

# Prepare build artifacts in the locations expected by the Sailfin-native test
# runner (import context + runtime prelude object).
#
# Stage D PR4: `make rebuild` now routes through `sfn build -p compiler`,
# which writes import-context to `build/native/import-context/` and prelude.o
# to `build/native/obj/runtime/prelude.o` directly — both already at the
# canonical paths the test runner expects. The legacy build.sh staging
# layout (`build/selfhost/native/...`) is only present when the consumer
# explicitly invokes `bash scripts/build.sh` (e.g. `make check` for the
# stage2/stage3 fixed-point comparison). Detect which layout produced the
# build and copy only when the legacy paths are present AND the canonical
# paths are missing.
ci-prepare-test-artifacts:
	@set -eu; \
	SRC="build/selfhost/native/seed_cwd/build/native/import-context"; \
	if [ -d build/native/import-context ] && [ -n "$$(find build/native/import-context -name '*.sfn-asm' -print -quit 2>/dev/null)" ]; then \
		echo "[ci-prepare-test-artifacts] build/native/import-context already populated (sfn build path); skipping copy"; \
	elif [ -d "$$SRC" ]; then \
		rm -rf build/native/import-context; \
		mkdir -p build/native/import-context; \
		cp -a "$$SRC/." build/native/import-context/; \
		echo "[ci-prepare-test-artifacts] staged import-context from $$SRC"; \
	else \
		echo "[ci-prepare-test-artifacts][error] no import-context source found" >&2; \
		echo "[ci-prepare-test-artifacts][error] expected either build/native/import-context (sfn build)" >&2; \
		echo "[ci-prepare-test-artifacts][error] or $$SRC (build.sh)" >&2; \
		find build/selfhost -maxdepth 5 -type d -name import-context -print 2>/dev/null || true; \
		exit 1; \
	fi; \
	if [ -f build/native/obj/runtime/prelude.o ]; then \
		echo "[ci-prepare-test-artifacts] build/native/obj/runtime/prelude.o already present"; \
	elif [ -f build/selfhost/native/obj/runtime/prelude.o ]; then \
		mkdir -p build/native/obj/runtime; \
		cp -f build/selfhost/native/obj/runtime/prelude.o build/native/obj/runtime/prelude.o; \
		echo "[ci-prepare-test-artifacts] staged prelude.o from build/selfhost/"; \
	else \
		echo "[ci-prepare-test-artifacts][error] missing prelude.o" >&2; \
		echo "[ci-prepare-test-artifacts][error] expected either build/native/obj/runtime/prelude.o (sfn build path)" >&2; \
		echo "[ci-prepare-test-artifacts][error] or build/selfhost/native/obj/runtime/prelude.o (build.sh)" >&2; \
		find build/selfhost -maxdepth 4 -type f -name 'prelude.o' -print 2>/dev/null || true; \
		exit 1; \
	fi; \
	true

# Package native compiler + installer artifacts for a given target label.
# Stage C4 migration: this target now delegates to `sfn package`
# (Sailfin-native; replaces the retired `tools/package.sh`).
# Produces: dist/sailfin-native-<target>-<version>.tar.gz (+.sha256, +.manifest.json)
#           dist/installer-<target>.tar.gz (+.sha256, +.manifest.json)
ci-package:
	@if [ -z "$(TARGET)" ]; then \
		echo "[ci-package][error] missing TARGET (e.g. linux-x86_64, macos-arm64)" >&2; \
		exit 1; \
	fi
	@if [ ! -x "$(NATIVE_BIN)" ]; then \
		echo "[ci-package][error] missing native compiler '$(NATIVE_BIN)'; run 'make rebuild' or 'make compile' first" >&2; \
		exit 1; \
	fi
	@$(NATIVE_BIN) package --target "$(TARGET)" --out dist --compiler-bin "$(NATIVE_BIN)"
	@$(NATIVE_BIN) package --installer --target "$(TARGET)" --out dist --compiler-bin "$(NATIVE_BIN)"

# Create an installer payload (compiler + runtime bits) for a given target label.
# Stage C4 migration: now delegates to `sfn package --installer`.
# Produces: dist/installer-$(TARGET).tar.gz (+.sha256, +.manifest.json)
ci-package-installer:
	@if [ -z "$(TARGET)" ]; then \
		echo "[ci-package-installer][error] missing TARGET (e.g. linux-x86_64, macos-arm64)" >&2; \
		exit 1; \
	fi
	@if [ ! -x "$(NATIVE_BIN)" ]; then \
		echo "[ci-package-installer][error] missing native compiler '$(NATIVE_BIN)'; run 'make rebuild' or 'make compile' first" >&2; \
		exit 1; \
	fi
	@$(NATIVE_BIN) package --installer --target "$(TARGET)" --out dist --compiler-bin "$(NATIVE_BIN)"

# Usage:
#   make rebuild
#   make rebuild SEED_NATIVE=path/to/sailfin
# Output:
#   build/native/sailfin
#
# Stage D PR4 (cutover) → PR5 (cleanup) → Stage E PR2 (this PR,
# fallback retirement): routes through `<seed> build -p compiler`
# as the only path. The 0.5.10-alpha.6 seed pinned in
# `.seed-version` ships the cumulative source-side fixes:
#   - PR3: binary-capsule `src/` walker + subprocess-per-module
#     compile (each compile gets a fresh arena);
#   - PR4: entry `.sfn-asm` staging + `llvm-as`/`clang -c
#     -emit-llvm` validator cascade;
#   - PR1 of Stage E: subprocess-stage import-context (each
#     `write_native_text_file_with_module` runs in a fresh
#     subprocess too).
# The cumulative effect: cold builds of the 138-module compiler
# fit in the 8 GB virtual-memory cap that CI runners and
# `compiler-safety.md` enforce, no `bash scripts/build.sh`
# fallback needed. The fallback that survived through PR5
# retires here.
#
# `scripts/build.sh` itself stays in-tree for `make check`'s
# stage2/stage3 fixed-point comparison (which still needs
# `WORK_DIR` control the driver doesn't expose) and for emergency
# manual seed bootstrapping. Stage E PR3+ retires the script
# outright once `make check` migrates.
#
# Notes:
# - Pass extra flags via BUILD_ARGS (driver-level, e.g.
#   BUILD_ARGS="--no-cache --cache-trace").
# - The driver parallelises subprocess emits internally; BUILD_JOBS
#   no longer plumbs through.
# - NATIVE_OPT / SELFHOST1_OPT are no longer honoured here — the
#   driver hardcodes `-O2` for the link step. `make check`'s
#   stage2/stage3 invocations still go through `bash scripts/build.sh`
#   directly until the fixed-point comparison machinery moves into
#   the driver.
rebuild:
	@mkdir -p build
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
	if ! "$$seed" --version >/dev/null 2>&1; then \
		echo "[rebuild][error] seed compiler $$seed is not invokable" >&2; \
		echo "[rebuild][error] expected pinned seed (see .seed-version); run: make fetch-seed" >&2; \
		exit 1; \
	fi; \
	echo "$$seed" > build/.seed-resolved
	@# Wipe stale import-context so a "force rebuild" actually
	@# re-stages every module instead of reusing whatever the
	@# previous build left on disk. `stage_capsule_imports`
	@# treats existing `.sfn-asm` + `.layout-manifest` pairs as
	@# authoritative cache hits with no mtime/content check.
	@mkdir -p build/native/import-context
	@if [ -d build/native/import-context ]; then \
		find build/native/import-context -type f \( -name '*.sfn-asm' -o -name '*.layout-manifest' \) -delete; \
	fi
	@# Wipe stale `build/sailfin/program` so the fallback's
	@# existence-based success check below can't be fooled by an
	@# old binary surviving a failed seed run. The `set -o
	@# pipefail` + bash wrapper captures the seed's real exit
	@# status (otherwise `| cat` always returns 0) and lets us
	@# log it for diagnostics. The `|| true` after the wrapper
	@# tolerates the seed bailing — the fallback then takes
	@# over.
	@rm -f build/sailfin/program build/sailfin/program.ll
	@seed=$$(cat build/.seed-resolved); \
	echo "[rebuild] running sfn build -p compiler (seed=$$seed)..."; \
	cd $(CURDIR) && bash -c "set -o pipefail; \"$$seed\" build $(BUILD_ARGS) -p compiler 2>&1 | cat"
	@if [ ! -f build/sailfin/program ]; then \
		echo "[rebuild][error] sfn build did not produce build/sailfin/program" >&2; \
		echo "[rebuild][error] expected the alpha.6+ seed's subprocess-stage path to keep the cold build under the 8 GB ulimit" >&2; \
		echo "[rebuild][error] if this is a regression, run 'bash scripts/build.sh' manually to bisect" >&2; \
		exit 1; \
	fi
	@mkdir -p build/native
	@cp -f build/sailfin/program $(NATIVE_OUT)
	@chmod +x $(NATIVE_OUT)
	@# Save .ll files to a location `make test` won't clobber. Each
	@# integration / e2e test's own `sfn build` overwrites
	@# `build/sailfin/capsules/*.ll` and `build/sailfin/program.ll`
	@# — by the time `make ci-cross-windows` runs (after the test
	@# suite), the rebuild's IR set is gone. Mirror to
	@# `build/native/raw/` which the test suite never touches;
	@# cross-windows reads from there. Cheap (`cp -a`, ~140 small
	@# files), survives `make test` cleanly.
	@mkdir -p build/native/raw
	@cp -a build/sailfin/capsules/. build/native/raw/ 2>/dev/null || true
	@cp -f build/sailfin/program.ll build/native/raw/program.ll 2>/dev/null || true
	@# Stage prelude.o for the freshly-built compiler. End-user
	@# `sfn build` / `sfn run` invocations from this binary check
	@# `_runtime_bundle_exists("runtime")` which requires a
	@# prebuilt `prelude.o` somewhere under the runtime tree (see
	@# `_runtime_prelude_path` in cli_main.sfn for the search
	@# list). The fresh-clone repo's `runtime/` has no `obj/`, so
	@# without this step the in-tree compiler would fail to link
	@# any user program with "runtime bundle missing expected
	@# files." Replicate via the new compiler emitting prelude.ll
	@# + clang compiling it to an object. The .ll stays on disk
	@# so `ci-cross-windows` can reuse it as the Windows-target
	@# prelude IR.
	@mkdir -p build/native/obj/runtime
	@if [ ! -f build/native/obj/runtime/prelude.o ]; then \
		echo "[rebuild] staging prelude.o..."; \
		$(NATIVE_OUT) emit -o build/native/obj/runtime/prelude.ll llvm runtime/prelude.sfn >/dev/null; \
		$(CLANG) -O2 -Wno-override-module -c build/native/obj/runtime/prelude.ll -o build/native/obj/runtime/prelude.o; \
	fi
	@# Write build stamp (version + git hash for dev builds).
	@# `version.sfn::resolve_compiler_version` reads this file
	@# first, so without it the binary would report whatever stale
	@# stamp the previous build left on disk.
	@cap_version=$$(sed -n 's/^version *= *"\([^"]*\)"/\1/p' compiler/capsule.toml); \
	if [ -z "$$cap_version" ]; then \
		echo "[rebuild][warn] could not extract version from compiler/capsule.toml; skipping build stamp" >&2; \
	else \
		git_tag=$$(git describe --exact-match --tags HEAD 2>/dev/null || true); \
		if [ -n "$$git_tag" ]; then \
			build_version="$$cap_version"; \
		else \
			git_hash=$$(git rev-parse --short HEAD 2>/dev/null || true); \
			git_dirty=""; \
			if [ -n "$$git_hash" ]; then \
				if ! git diff --quiet HEAD -- 2>/dev/null; then \
					git_dirty=".dirty"; \
				fi; \
				build_version="$${cap_version}+dev.$${git_hash}$${git_dirty}"; \
			else \
				build_version="$${cap_version}+dev"; \
			fi; \
		fi; \
		echo "$$build_version" > build/native/.build-stamp; \
		echo "[rebuild] build stamp: $$build_version"; \
	fi
	@echo "[rebuild] built $(NATIVE_OUT)"

# =============================================================================
# Cross-compile for Windows (from Linux, using MinGW-w64)
# =============================================================================
# Requires: x86_64-w64-mingw32-gcc, llvm-link (or llvm-link-18)
# Reuses the LLVM IR (.ll files) from the Linux selfhost build.
# Produces: build/windows/sailfin.exe + dist/ packaging artifacts.
#
# Stage D PR4: now reads from `build/sailfin/capsules/*.ll` +
# `build/sailfin/program.ll` (sfn build layout) instead of
# `build/selfhost/native/raw/*.ll` (build.sh layout). The legacy
# path is preserved as a fallback for as long as `make check`'s
# stage2/stage3 invocations still produce it. PR5 retires this
# target entirely once `sfn build --target=x86_64-w64-mingw32`
# ships.

MINGW_CC ?= x86_64-w64-mingw32-gcc
MINGW_TARGET := windows-x86_64

.PHONY: ci-cross-windows
ci-cross-windows:
	@set -eu; \
	echo "[cross-windows] cross-compiling for Windows from Linux LLVM IR..."; \
	SAVED_DIR="build/native/raw"; \
	CAPSULE_DIR="build/sailfin/capsules"; \
	PROGRAM_LL=""; \
	PRELUDE_LL="build/native/obj/runtime/prelude.ll"; \
	LEGACY_RAW_DIR="build/selfhost/native/raw"; \
	USE_SFN_BUILD=0; \
	if [ -d "$$SAVED_DIR" ] && [ -f "$$SAVED_DIR/program.ll" ]; then \
		USE_SFN_BUILD=1; \
		CAPSULE_DIR="$$SAVED_DIR"; \
		PROGRAM_LL="$$SAVED_DIR/program.ll"; \
		echo "[cross-windows] using saved sfn build IR layout ($$SAVED_DIR)"; \
	elif [ -d "$$CAPSULE_DIR" ] && [ -f "build/sailfin/program.ll" ]; then \
		USE_SFN_BUILD=1; \
		PROGRAM_LL="build/sailfin/program.ll"; \
		echo "[cross-windows] using sfn build IR layout (build/sailfin/capsules + program.ll)"; \
	elif [ -d "$$LEGACY_RAW_DIR" ]; then \
		echo "[cross-windows] using legacy build.sh IR layout ($$LEGACY_RAW_DIR)"; \
	else \
		echo "[cross-windows][error] no IR source found" >&2; \
		echo "[cross-windows][error] expected one of:" >&2; \
		echo "[cross-windows][error]   $$SAVED_DIR/*.ll + program.ll (sfn build, persisted)" >&2; \
		echo "[cross-windows][error]   $$CAPSULE_DIR + build/sailfin/program.ll (sfn build, fresh)" >&2; \
		echo "[cross-windows][error]   $$LEGACY_RAW_DIR (build.sh) — run 'make rebuild' first" >&2; \
		exit 1; \
	fi; \
	if [ "$$USE_SFN_BUILD" = "1" ] && [ ! -f "$$PRELUDE_LL" ]; then \
		echo "[cross-windows][error] missing $$PRELUDE_LL — \`make rebuild\` should have emitted it" >&2; \
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
	if [ "$$USE_SFN_BUILD" = "1" ]; then \
		PROGRAM_BASENAME="$$(basename "$$PROGRAM_LL")"; \
		PROGRAM_REAL="$$(readlink -f "$$PROGRAM_LL" 2>/dev/null || echo "$$PROGRAM_LL")"; \
		for f in "$$CAPSULE_DIR"/*.ll; do \
			[ -f "$$f" ] || continue; \
			f_real="$$(readlink -f "$$f" 2>/dev/null || echo "$$f")"; \
			if [ "$$f_real" = "$$PROGRAM_REAL" ]; then continue; fi; \
			LL_FILES="$$LL_FILES $$f"; \
		done; \
		LL_FILES="$$LL_FILES $$PROGRAM_LL"; \
	else \
		for f in "$$LEGACY_RAW_DIR"/*.ll; do \
			base="$$(basename "$$f")"; \
			case "$$base" in \
				*.attempt*|*.clean*) continue ;; \
				runtime__prelude.ll) PRELUDE_LL="$$f"; continue ;; \
			esac; \
			LL_FILES="$$LL_FILES $$f"; \
		done; \
	fi; \
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
	$(MINGW_CC) -O2 -I runtime/native/include -c runtime/native/src/sailfin_arena.c \
		-o "$$WIN_OBJ/sailfin_arena.o"; \
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
		"$$WIN_OBJ/sailfin_arena.o" \
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
