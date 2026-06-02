# Sailfin project automation

# Force bash so recipes can rely on bash-isms (`<()` process substitution,
# `[[ ]]` test syntax, etc.) and so the Sailfin compiler's `process.run`
# invocations don't hit a `/bin/sh`-specific quirk that makes the seed
# segfault during `sfn build -p compiler`. Plain dash on Ubuntu has been
# observed to crash the seed reproducibly via Make even though direct
# bash invocations of the same command succeed; switching the recipe
# shell to bash sidesteps the issue.
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
# compile.
#
# Default: auto-detected from CPU count and total RAM via
# scripts/detect_build_jobs.sh, with a per-job budget of 5 GB (heaviest module
# ~4.7 GB peak RSS under the arena allocator, plus headroom). macOS additionally
# caps at 2 because the M1 GitHub runner has only 7 GB total RAM. Windows / hosts
# we cannot probe fall back to 1.
#
# Override explicitly with `BUILD_JOBS=N`; empty / unset uses auto-detect. The
# driver (`sfn build -p compiler`) parallelises subprocess emits internally —
# `BUILD_JOBS` only affects callers that still spawn module compiles directly.
# See docs/build-performance.md → Phase 6 for the rollout history and the
# per-job budget rationale.
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

.PHONY: help install fetch-seed test test-unit test-integration test-e2e test-capsules compile check check-fast package clean bench test-arena

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
	@echo "  make test-capsules  # Run per-capsule tests under capsules/"
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

# Issue #848 (epic #840 Phase 1.2): the four suite shell loops
# collapsed into one `sfn test` invocation that walks every path,
# tallies per-suite, and emits the per-suite `═══ <name>: N/M ═══`
# banners directly. `test-unit` / `test-integration` / `test-e2e` /
# `test-capsules` keep their names as aliases over the same runner
# with different paths. The legacy e2e `test_*.sh` scripts still
# run from `make test` / `make test-e2e` via `test-e2e-sh` — Phase
# 3.1 migrates them and retires the .sh branch.
test:
	@if [ ! -x $(NATIVE_BIN) ]; then \
		echo "[test] missing $(NATIVE_BIN); running make compile"; \
		$(MAKE) compile; \
	fi
	@# Run the unified runner, then the legacy e2e .sh scripts, and
	@# surface a non-zero status if *either* failed. The `.sh` scripts
	@# must still run even when a `.sfn` suite fails — matches the
	@# pre-#848 `test-e2e` loop, which ran its `.sh` branch after the
	@# `.sfn` branch regardless of `.sfn` failures.
	@rc=0; \
	$(NATIVE_BIN) test compiler/tests/unit compiler/tests/integration compiler/tests/e2e capsules || rc=$$?; \
	$(MAKE) test-e2e-sh || rc=$$?; \
	exit $$rc

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

# Aliases over the unified runner (issue #848). Each suite still
# runs as one `sfn test` invocation; the per-suite banner the
# Makefile loops used to emit now comes from `_emit_suite_banners`
# in `handle_test_command`.
test-unit:
	@if [ ! -x $(NATIVE_BIN) ]; then \
		echo "[test-unit] missing $(NATIVE_BIN); running make compile"; \
		$(MAKE) compile; \
	fi
	@$(NATIVE_BIN) test compiler/tests/unit

test-integration:
	@if [ ! -x $(NATIVE_BIN) ]; then \
		echo "[test-integration] missing $(NATIVE_BIN); running make compile"; \
		$(MAKE) compile; \
	fi
	@$(NATIVE_BIN) test compiler/tests/integration

# The legacy e2e `test_*.sh` scripts still run alongside the `.sfn`
# tests until Phase 3.1 migrates them (see
# `docs/proposals/test-infra-epic/02-phases.md` Phase 3.1). Until
# then `test-e2e-sh` keeps the bash-driven scripts on the same
# `make test-e2e` / `make test` paths they were on before #848.
test-e2e:
	@if [ ! -x $(NATIVE_BIN) ]; then \
		echo "[test-e2e] missing $(NATIVE_BIN); running make compile"; \
		$(MAKE) compile; \
	fi
	@rc=0; \
	$(NATIVE_BIN) test compiler/tests/e2e || rc=$$?; \
	$(MAKE) test-e2e-sh || rc=$$?; \
	exit $$rc

# Per-capsule tests live alongside each capsule under
# `capsules/<scope>/<name>/tests/*_test.sfn`. The unified runner's
# directory BFS walks every nested `tests/` dir from `capsules/`,
# so passing just `capsules` matches the prior
# `find capsules -path '*/tests/*_test.sfn'` discovery.
test-capsules:
	@if [ ! -x $(NATIVE_BIN) ]; then \
		echo "[test-capsules] missing $(NATIVE_BIN); running make compile"; \
		$(MAKE) compile; \
	fi
	@$(NATIVE_BIN) test capsules

# Internal: the legacy e2e `.sh` script loop. Phase 3.1 (parent
# epic #840) ports each `test_*.sh` to a `_test.sfn` peer and
# deletes both this target and the source scripts. Until then it
# emits a `═══ e2e-sh: N/M passed ═══` banner shaped like the
# runner's own per-suite banners so log scrubbers see one format
# across the suite.
.PHONY: test-e2e-sh
test-e2e-sh:
	@pass=0; fail=0; failed_files=""; \
	files=$$(find compiler/tests/e2e -name 'test_*.sh' -print | sort); \
	if [ -z "$$files" ]; then \
		echo "[test-e2e-sh] no test_*.sh scripts found under compiler/tests/e2e"; \
		echo ""; \
		echo "═══ e2e-sh: 0/0 passed, 0 failed ═══"; \
		exit 0; \
	fi; \
	for f in $$files; do \
		if bash "$$f" $(NATIVE_BIN); then \
			pass=$$((pass + 1)); \
		else \
			fail=$$((fail + 1)); \
			failed_files="$$failed_files  $$(basename $$f)\n"; \
		fi; \
	done; \
	total=$$((pass + fail)); \
	echo ""; \
	echo "═══ e2e-sh: $$pass/$$total passed, $$fail failed ═══"; \
	if [ $$fail -gt 0 ]; then \
		echo ""; \
		printf '%b' "$$failed_files"; \
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
	@# Stage2 routes through `sfn build -p compiler --work-dir <DIR>`
	@# (the same path `make rebuild` uses for the first-pass binary).
	@# The driver virtualises `<DIR>/native/import-context/` and the
	@# default `<DIR>/native/sailfin` output, but the per-module `.ll`
	@# scratch root is still the legacy `build/sailfin/capsules/`
	@# unless `SAILFIN_TEST_SCRATCH` is set (see `_cr_scratch_root`
	@# in `compiler/src/capsule_resolver.sfn`); without that override
	@# stage3 would clobber stage2's `.ll` files and the fixed-point
	@# hash-diff below would be vacuous. `--no-cache` keeps stage2
	@# and stage3 truly independent (they're built by different
	@# compiler binaries with potentially identical version stamps,
	@# so a shared cache would let one stage's IR satisfy the
	@# other's lookup and silently bypass the fresh emit). The driver
	@# hardcodes `-O2` for the link step, so CI overrides of
	@# `NATIVE_OPT` that lower the opt level for stage2/stage3 are
	@# silently ignored until the driver grows an `--opt` flag.
	@mkdir -p build/selfhost/native-seedcheck
	@if [ -d build/selfhost/native-seedcheck/scratch/capsules ]; then \
		find build/selfhost/native-seedcheck/scratch/capsules -type f -name '*.ll' -delete; \
	fi
	@SAILFIN_TEST_SCRATCH="build/selfhost/native-seedcheck/scratch" \
		build/native/sailfin build --no-cache -p compiler \
			--work-dir build/selfhost/native-seedcheck \
			-o build/native/sailfin-seedcheck
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
	@# Same shape as stage2 — driver `--work-dir` with
	@# `SAILFIN_TEST_SCRATCH` per-stage isolation and `--no-cache`
	@# so stage3's IR is freshly emitted by the stage2 binary
	@# rather than served from a cache that stage2 (or
	@# `make compile`) populated. See the stage2 block above for
	@# the rationale.
	@mkdir -p build/selfhost/native-stage3
	@if [ -d build/selfhost/native-stage3/scratch/capsules ]; then \
		find build/selfhost/native-stage3/scratch/capsules -type f -name '*.ll' -delete; \
	fi
	@SAILFIN_TEST_SCRATCH="build/selfhost/native-stage3/scratch" \
		build/native/sailfin-seedcheck build --no-cache -p compiler \
			--work-dir build/selfhost/native-stage3 \
			-o build/native/sailfin-stage3
	@echo "[check] comparing stage2 vs stage3 LLVM IR (fixed-point check)..."
	@s2="build/selfhost/native-seedcheck/scratch/capsules"; \
	s3="build/selfhost/native-stage3/scratch/capsules"; \
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

# Verify the build artifacts the Sailfin-native test runner expects
# (import-context) are present at their canonical location.
#
# `make rebuild` is the only path to producing `build/native/sailfin`,
# so `build/native/import-context/` is guaranteed to land directly.
# #941: the former `build/native/obj/runtime/prelude.o` check was
# dropped — post-#940 the test runner links the runtime through the
# declarative runtime-capsule path (emit-from-source + per-work-dir
# cache), so no pre-staged `prelude.o` exists or is needed.
ci-prepare-test-artifacts:
	@set -eu; \
	if [ ! -d build/native/import-context ] || [ -z "$$(find build/native/import-context -name '*.sfn-asm' -print -quit 2>/dev/null)" ]; then \
		echo "[ci-prepare-test-artifacts][error] missing build/native/import-context — run 'make rebuild' first" >&2; \
		exit 1; \
	fi; \
	echo "[ci-prepare-test-artifacts] build/native/import-context present"

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
# Routes through `<seed> build -p compiler` as the only path. The
# pinned seed (`.seed-version`) ships the cumulative source-side
# fixes that keep cold builds of the 138-module compiler inside
# the 8 GB virtual-memory cap that CI runners and
# `compiler-safety.md` enforce: binary-capsule `src/` walker +
# subprocess-per-module compile, entry `.sfn-asm` staging + a
# `llvm-as` / `clang -c -emit-llvm` validator cascade, and
# subprocess-stage import-context.
#
# Notes:
# - Pass extra flags via BUILD_ARGS (driver-level, e.g.
#   BUILD_ARGS="--no-cache --cache-trace").
# - The driver parallelises subprocess emits internally; BUILD_JOBS
#   no longer plumbs through.
# - NATIVE_OPT / SELFHOST1_OPT are no longer honoured here — the
#   driver hardcodes `-O2` for the link step.
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
	@# #812: pre-stage the runtime/sfn/platform extern modules with the
	@# SEED *before* `sfn build -p compiler`. `runtime/sfn/io.sfn` calls
	@# `write` (from `./platform/libc`) and `runtime/sfn/clock.sfn` calls
	@# `nanosleep` (from `./platform/posix`); their cold emit during the
	@# build must read those `.sfn-asm` to resolve the extern return
	@# types. On a true cold build (no `.ll` cache — e.g. CI `make
	@# rebuild`) the resolver's staging order is not guaranteed to stage
	@# these before io.sfn/clock.sfn emit, so the build fails with
	@# "cannot resolve return type for call to `write`". The seed-emitted
	@# signatures are good enough for the in-build resolution; the
	@# post-build block below re-stages them with NATIVE_OUT for the
	@# canonical (proper-pointee) form. Mirrors the post-stage loop.
	@mkdir -p build/native/import-context/runtime/sfn/platform
	@seed=$$(cat build/.seed-resolved); \
	for mod in libc posix pthread net; do \
		asm_path="build/native/import-context/runtime/sfn/platform/$$mod.sfn-asm"; \
		manifest_path="build/native/import-context/runtime/sfn/platform/$$mod.layout-manifest"; \
		if [ ! -f "$$asm_path" ]; then \
			echo "[rebuild] pre-staging runtime/sfn/platform/$$mod.sfn-asm (seed)..."; \
			if ! "$$seed" emit --module-name "runtime/sfn/platform/$$mod" -o "$$asm_path" native "runtime/sfn/platform/$$mod.sfn" >/dev/null 2>&1; then \
				echo "[rebuild][warn] seed pre-stage failed for platform/$$mod.sfn; post-stage will retry with NATIVE_OUT" >&2; \
				rm -f "$$asm_path"; \
			fi; \
		fi; \
		if [ -f "$$asm_path" ] && [ ! -f "$$manifest_path" ]; then \
			grep '^\.layout' "$$asm_path" > "$$manifest_path" 2>/dev/null || :; \
			[ -f "$$manifest_path" ] || touch "$$manifest_path"; \
		fi; \
	done
	@# Wipe stale `build/sailfin/program` so the existence check
	@# below can't be fooled by an old binary surviving a failed
	@# seed run. The `set -o pipefail` + bash wrapper captures
	@# the seed's real exit status (otherwise `| cat` always
	@# returns 0); the `|| build_rc=$$?` pattern tolerates the
	@# bail so we can surface targeted diagnostics from the
	@# error block instead of failing fast on the unguarded
	@# recipe line. The `&&` chain ensures every diagnostic
	@# message reaches the user before we exit.
	@rm -f build/sailfin/program build/sailfin/program.ll
	@seed=$$(cat build/.seed-resolved); \
	echo "[rebuild] running sfn build -p compiler (seed=$$seed)..."; \
	build_rc=0; \
	{ cd $(CURDIR) && bash -c "set -o pipefail; \"$$seed\" build $(BUILD_ARGS) -p compiler 2>&1 | cat"; } \
		|| build_rc=$$?; \
	if [ "$$build_rc" -ne 0 ] || [ ! -f build/sailfin/program ]; then \
		echo "[rebuild][error] sfn build failed (exit=$$build_rc) or did not produce build/sailfin/program" >&2; \
		echo "[rebuild][error] expected the alpha.6+ seed's subprocess-stage path to keep the cold build under the 8 GB ulimit" >&2; \
		echo "[rebuild][error] if this is a regression, rerun with BUILD_ARGS='--cache-trace' to bisect, or fall back to the prior seed via .seed-version" >&2; \
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
	@# Runtime-object staging removed (#941). Post-#940 the freshly-built
	@# compiler resolves the runtime via runtime/native/capsule.toml (the
	@# declarative runtime capsule), emitting prelude + each sfn-source from
	@# source on demand and caching the .o under the per-work-dir build cache.
	@# No link path reads the old build/native/obj/runtime/*.o, so the per-module
	@# .ll+.o staging that used to live here is gone. ci-cross-windows now emits
	@# the Windows-target runtime IR itself (self-contained loop below), and the
	@# installer bundles the runtime .sfn sources (see _package_installer).
	@# Stage import-context for `runtime/sfn/platform/*.sfn` extern-fn
	@# modules. `runtime/sfn/clock.sfn` imports `nanosleep` from
	@# `./platform/posix`, and `runtime/sfn/io.sfn` imports `write`
	@# from `./platform/libc`; without these `.sfn-asm` artifacts on
	@# disk, `collect_imported_module_context_for_module`
	@# (compiler/src/llvm/imports.sfn) falls back to empty native text
	@# and `render_imported_function_declarations` cannot emit the
	@# extern's source-of-truth signature. Today's fallback is the
	@# `seed_default_runtime_helpers` workaround (a forced `nanosleep`
	@# entry in the helper preamble emits `declare i32 @nanosleep(i8*,
	@# i8*)` with opaque-pointee types); staging here lets the import
	@# path emit the proper `declare i32 @nanosleep(%Timespec*,
	@# %Timespec*)` from posix.sfn instead. Issue #414 closes that
	@# arc; the workaround entry retires in the same PR. Layout
	@# manifests are extern-fn-only (no structs/enums), so the
	@# companion file is intentionally empty — stage_capsule_imports
	@# does the same when `_cr_extract_layout_manifest` finds no
	@# `.layout` lines in the emitted asm.
	@# #812: drop the seed pre-staged platform asm (staged before the
	@# build for cold-emit resolution) so the loop below re-emits them
	@# with NATIVE_OUT — the canonical proper-pointee signatures, matching
	@# the pre-#812 final state.
	@rm -f build/native/import-context/runtime/sfn/platform/*.sfn-asm build/native/import-context/runtime/sfn/platform/*.layout-manifest
	@mkdir -p build/native/import-context/runtime/sfn/platform
	@set -e; \
	for mod in libc posix pthread net; do \
		asm_path="build/native/import-context/runtime/sfn/platform/$$mod.sfn-asm"; \
		manifest_path="build/native/import-context/runtime/sfn/platform/$$mod.layout-manifest"; \
		if [ ! -f "$$asm_path" ]; then \
			echo "[rebuild] staging runtime/sfn/platform/$$mod.sfn-asm..."; \
			if ! $(NATIVE_OUT) emit --module-name "runtime/sfn/platform/$$mod" -o "$$asm_path" native "runtime/sfn/platform/$$mod.sfn" >/dev/null; then \
				echo "[rebuild][error] emit native failed for runtime/sfn/platform/$$mod.sfn" >&2; \
				rm -f "$$asm_path"; \
				exit 1; \
			fi; \
			if [ ! -s "$$asm_path" ]; then \
				echo "[rebuild][error] emit native produced empty $$asm_path" >&2; \
				rm -f "$$asm_path"; \
				exit 1; \
			fi; \
		fi; \
		if [ ! -f "$$manifest_path" ]; then \
			grep '^\.layout' "$$asm_path" > "$$manifest_path" 2>/dev/null || :; \
			[ -f "$$manifest_path" ] || touch "$$manifest_path"; \
		fi; \
	done
	@echo "[rebuild] built $(NATIVE_OUT)"

# =============================================================================
# Cross-compile for Windows (from Linux, using MinGW-w64)
# =============================================================================
# Requires: x86_64-w64-mingw32-gcc, llvm-link (or llvm-link-18)
# Reuses the LLVM IR (.ll files) from the Linux selfhost build.
# Produces: build/windows/sailfin.exe + dist/ packaging artifacts.
#
# Stage E PR4: reads exclusively from the saved sfn-build IR
# layout at `build/native/raw/*.ll` (mirrored by `make rebuild`
# so the test suite can't clobber the originals at
# `build/sailfin/capsules/`). The legacy `build/selfhost/native/raw`
# fallback that survived through PR3 retired here — `make
# rebuild` is the only path producing IR for cross-compile, and
# it always populates `build/native/raw/`. The future
# `sfn build --target=x86_64-w64-mingw32` retires this target
# wholesale.

MINGW_CC ?= x86_64-w64-mingw32-gcc
MINGW_TARGET := windows-x86_64

.PHONY: ci-cross-windows
ci-cross-windows:
	@set -eu; \
	echo "[cross-windows] cross-compiling for Windows from Linux LLVM IR..."; \
	SAVED_DIR="build/native/raw"; \
	if [ ! -d "$$SAVED_DIR" ] || [ ! -f "$$SAVED_DIR/program.ll" ]; then \
		echo "[cross-windows][error] missing $$SAVED_DIR/*.ll + program.ll — run 'make rebuild' first" >&2; \
		exit 1; \
	fi; \
	echo "[cross-windows] using saved sfn build IR layout ($$SAVED_DIR)"; \
	PROGRAM_LL="$$SAVED_DIR/program.ll"; \
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
	PROGRAM_REAL="$$(readlink -f "$$PROGRAM_LL" 2>/dev/null || echo "$$PROGRAM_LL")"; \
	for f in "$$SAVED_DIR"/*.ll; do \
		[ -f "$$f" ] || continue; \
		f_real="$$(readlink -f "$$f" 2>/dev/null || echo "$$f")"; \
		if [ "$$f_real" = "$$PROGRAM_REAL" ]; then continue; fi; \
		LL_FILES="$$LL_FILES $$f"; \
	done; \
	LL_FILES="$$LL_FILES $$PROGRAM_LL"; \
	\
	echo "[cross-windows] linking IR modules..."; \
	$$LLVM_LINK -o "$$WIN_OBJ/sailfin.linked.bc" $$LL_FILES 2>&1 || \
		$$LLVM_LINK --opaque-pointers -o "$$WIN_OBJ/sailfin.linked.bc" $$LL_FILES; \
	\
	echo "[cross-windows] compiling linked bitcode -> .o"; \
	$(CLANG) -target x86_64-w64-mingw32 $(NATIVE_OPT) -fno-delete-null-pointer-checks \
		-c "$$WIN_OBJ/sailfin.linked.bc" -o "$$WIN_OBJ/native.linked.o"; \
	\
	echo "[cross-windows] emitting + compiling runtime modules..."; \
	\
	: "#941: the runtime IR this target consumes is now emitted by"; \
	: "ci-cross-windows itself (was staged by 'make rebuild', deleted"; \
	: "in #941). RUNTIME_MODS is this bridge's copy of"; \
	: "runtime/native/capsule.toml's sfn-sources (+ the prelude-entry),"; \
	: "MINUS process.sfn — Windows resolves @sfn_process_run from the"; \
	: "_WIN32 C wrapper in sailfin_runtime.c, so linking the Sailfin"; \
	: "object too would duplicate the symbol. A guard test"; \
	: "(compiler/tests/e2e/test_cross_windows_runtime_modules.sh) asserts"; \
	: "this list stays in sync with the manifest (Risk R4). clock is"; \
	: "re-emitted with SAILFIN_TARGET_OS=Windows for the errno->_errno"; \
	: "fix (#877); the rest are target-independent IR compiled for"; \
	: "mingw. Each <module>:<source> pair is space-separated."; \
	RUNTIME_MODS="prelude:runtime/prelude.sfn arena:runtime/sfn/memory/arena.sfn rc:runtime/sfn/memory/rc.sfn mem:runtime/sfn/memory/mem.sfn string:runtime/sfn/string.sfn array:runtime/sfn/array.sfn clock:runtime/sfn/clock.sfn io:runtime/sfn/io.sfn exception:runtime/sfn/exception.sfn type_meta:runtime/sfn/type_meta.sfn exec:runtime/sfn/platform/exec.sfn filesystem:runtime/sfn/adapters/filesystem.sfn http:runtime/sfn/adapters/http.sfn"; \
	RUNTIME_OBJS=""; \
	for pair in $$RUNTIME_MODS; do \
		mod="$${pair%%:*}"; \
		src="$${pair#*:}"; \
		ll="$$WIN_OBJ/runtime/$$mod.ll"; \
		obj="$$WIN_OBJ/runtime/$$mod.o"; \
		echo "[cross-windows] emitting + compiling $$mod ($$src)..."; \
		: "#515: the emit retry + llvm-as/clang validator cascade now"; \
		: "lives in the compiler (emit_helpers.sfn). 'emit --validate llvm'"; \
		: "runs up to 3 in-compiler attempts, each round-tripped through"; \
		: "the same cascade the resolver uses, so a seed-emit flake can no"; \
		: "longer escape into the mingw clang. This replaces the hand-"; \
		: "inlined shell retry loop that mirrored the resolver."; \
		rm -f "$$ll"; \
		if [ "$$mod" = "clock" ]; then \
			SAILFIN_TARGET_OS=Windows $(NATIVE_OUT) emit --validate -o "$$ll" llvm "$$src" >/dev/null || { \
				echo "[cross-windows][error] failed to emit valid $$mod IR" >&2; exit 1; }; \
		else \
			$(NATIVE_OUT) emit --validate -o "$$ll" llvm "$$src" >/dev/null || { \
				echo "[cross-windows][error] failed to emit valid $$mod IR" >&2; exit 1; }; \
		fi; \
		$(CLANG) -target x86_64-w64-mingw32 $(NATIVE_OPT) -fno-delete-null-pointer-checks \
			-c "$$ll" -o "$$obj"; \
		RUNTIME_OBJS="$$RUNTIME_OBJS $$obj"; \
	done; \
	\
	echo "[cross-windows] compiling C runtime..."; \
	$(MINGW_CC) -O2 -I runtime/native/include -c runtime/native/src/sailfin_arena.c \
		-o "$$WIN_OBJ/sailfin_arena.o"; \
	$(MINGW_CC) -O2 -I runtime/native/include -c runtime/native/src/sailfin_runtime.c \
		-o "$$WIN_OBJ/sailfin_runtime.o"; \
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
		"$$WIN_OBJ/runtime_globals.o" \
		"$$WIN_OBJ/native.linked.o" \
		$$RUNTIME_OBJS \
		$$SHIM_O \
		-lm -lpthread -lws2_32; \
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
	mkdir -p "$$INSTALLER_DIR/runtime"; \
	cp -R runtime/native "$$INSTALLER_DIR/runtime/native"; \
	: "#941: bundle the runtime Sailfin sources. A fresh Windows install"; \
	: "relinks user programs against the runtime via the capsule"; \
	: "emit-from-source path (assemble_runtime_capsule_link_inputs in"; \
	: "cli_main.sfn), which reads <root>/runtime/prelude.sfn +"; \
	: "<root>/runtime/sfn/** relative to the bundled capsule.toml;"; \
	: "without them a fresh install cannot link any runtime-touching"; \
	: "program. The former per-.o bundle copies are gone — those"; \
	: "objects were never consumed by the post-#940 link path. Mirrors"; \
	: "_package_installer (the Linux/host installer)."; \
	cp -f runtime/prelude.sfn "$$INSTALLER_DIR/runtime/prelude.sfn"; \
	cp -R runtime/sfn "$$INSTALLER_DIR/runtime/sfn"; \
	tar -czf "dist/installer-$(MINGW_TARGET).tar.gz" -C "$$INSTALLER_DIR" .; \
	echo "[cross-windows] done: dist/installer-$(MINGW_TARGET).tar.gz"
