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
# other. See docs/proposals/0006-build-architecture.md → Phase 6 follow-ups.
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

# Clang shim (macOS). Homebrew's llvm clang (e.g. `llvm@17`) commonly shadows
# Apple's clang on PATH, but it cannot drive Apple's `ld` to the macOS SDK
# system libs — linking the self-hosted compiler then fails with
# `ld: library 'm' not found`. Only Apple's `/usr/bin/clang` links system libs
# here. The seed and the built compiler invoke a bare `clang` via PATH
# (`process.run(["clang", ...])`), so a make variable cannot steer them;
# instead expose a one-symlink dir that redirects ONLY `clang` to the chosen
# compiler and put it first on PATH for every recipe. Minimal blast radius: no
# other tool is shadowed. Override the target with `SAILFIN_CC=/path/to/clang`;
# no-ops (empty dir, harmless PATH prefix) if the target does not exist.
SAILFIN_CC ?= /usr/bin/clang
CLANG_SHIM_DIR := $(CURDIR)/build/.toolchain-shim
$(shell mkdir -p $(CLANG_SHIM_DIR) >/dev/null 2>&1; [ -x "$(SAILFIN_CC)" ] && ln -sf "$(SAILFIN_CC)" "$(CLANG_SHIM_DIR)/clang" 2>/dev/null)
export PATH := $(CLANG_SHIM_DIR):$(PATH)
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
# See docs/proposals/0006-build-architecture.md → Phase 6 for the rollout history and the
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

.PHONY: help install fetch-seed test test-unit test-integration test-e2e test-capsules compile check check-fast package clean bench bench-runtime test-arena

.PHONY: ci-prepare-test-artifacts ci-package ci-package-installer

.PHONY: rebuild mcp-server

# Agent-facing targets (#1059) wrap their real `<target>-impl` body in the
# verdict-block emitter so a single greppable `===SAILFIN-RESULT===` block is
# always the last output, on success and failure alike. The wrapper also
# carries the SAILFIN_INNER guard so a `make check` that calls `make test`
# internally emits only the outer verdict. See scripts/agent_report.sh and
# docs/reference/make-result-schema.md.
.PHONY: compile-impl rebuild-impl check-impl check-fast-impl
.PHONY: test-impl test-unit-impl test-integration-impl test-e2e-impl test-capsules-impl
#
# Report-file gate (#1119). `JSON=1 make <target>` (or SAILFIN_AGENT_REPORT=1 in
# the environment) activates a per-target full report file at
# build/agent-report.<target>.json and points the verdict block's `report`
# field at it. The gate is off by default: no file is written and `report`
# stays null. The flag is exported (not threaded through each callsite) so
# agent_report.sh reads it from the environment; nested SAILFIN_INNER runs still
# emit no sentinel and write no file.
JSON ?=
ifeq ($(JSON),1)
SAILFIN_AGENT_REPORT := 1
endif
export SAILFIN_AGENT_REPORT
AGENT_REPORT := bash scripts/agent_report.sh

# Extra flags appended to every `$(NATIVE_BIN) test ...` invocation
# (#1230). Empty by default so the local `make test` inner loop uses the
# per-test binary cache and gets fast incremental reruns. The `make
# check` full-suite gate overrides this to `--no-test-cache` so the
# merge/seedcheck gate always cold-builds every test binary — the cache
# can never mask a test-compile regression.
TEST_BIN_CACHE_FLAGS ?=

# Parallel test execution (#843 / #1236). The unified runner accepts
# `--jobs N` (per-file child processes run N at a time); every
# `$(NATIVE_BIN) test ...` invocation below threads this knob. The
# default stays 1 because each child carries its own RAM footprint
# under the 8GB per-process cap — callers pick N for their RAM budget
# (e.g. `make test TEST_JOBS=4` on a 4-core/16GB box, smaller on
# 7GB CI runners). CI sharding (`make test-shard`) is unaffected.
TEST_JOBS ?= 1
TEST_JOBS_FLAG = --jobs $(TEST_JOBS)

# Test parallelism for `make check` specifically. `make check` runs the full
# suite TWICE (once on the first-pass binary as an early gate, once on the
# seedcheck binary), so a serial `TEST_JOBS=1` doubles down on the slowest part
# of the gate. Unlike a bare `make test`, `make check` already pins peak build
# concurrency via the RAM-budgeted `BUILD_JOBS` auto-detect, so it can safely
# reuse that same per-job budget for its suite runs. An explicit `TEST_JOBS=N`
# (command line or environment) always wins — set it to dial the suite down on
# a tighter RAM budget, or to 1 to restore the old serial behaviour.
ifeq ($(filter command line environment,$(origin TEST_JOBS)),)
CHECK_TEST_JOBS ?= $(BUILD_JOBS)
else
CHECK_TEST_JOBS ?= $(TEST_JOBS)
endif

help:
	@echo "Common Sailfin tasks"
	@echo ""
	@echo "  make compile        # Build the compiler from a released seed"
	@echo "  make rebuild        # Force rebuild from seed via 'sfn build -p compiler'"
	@echo "  make install        # Install the built compiler binary into PREFIX/bin"
	@echo "  make check          # Compile (if needed) then run the full test suite"
	@echo "  make check-fast     # Run sfn check on compiler/src/ + runtime/ (no codegen, fast PR gate)"
	@echo "  make test           # Run Sailfin-native unit + integration + e2e tests"
	@echo "  make test TEST_JOBS=4 # Same, with 4 parallel test children (pick N for your RAM budget)"
	@echo "  make test-unit      # Run Sailfin-native unit tests"
	@echo "  make test-integration # Run Sailfin-native integration tests"
	@echo "  make test-e2e       # Run Sailfin-native end-to-end tests"
	@echo "  make test-capsules  # Run per-capsule tests under capsules/"
	@echo "  make package        # Build + package native artifacts into dist/"
	@echo "  make fetch-seed     # Download the latest released seed"
	@echo "  make bench          # Benchmark per-module compile time and memory"
	@echo "  make bench-runtime  # Benchmark compiled-program runtime execution"
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
# with different paths. The legacy e2e `test_*.sh` scripts were
# fully migrated to `*_test.sfn` peers (Phase 3.1, epic #840), so the
# bash branch and its allowlist/ratchet are gone.
test:
	@$(AGENT_REPORT) --target test -- $(MAKE) test-impl

test-impl:
	@if [ ! -x $(NATIVE_BIN) ]; then \
		echo "[test] missing $(NATIVE_BIN); running make compile"; \
		$(MAKE) compile; \
	fi
	@# JSON=1 gate (#1121): the `.sfn` runner gets `--json` + tee for the
	@# report composer; pipefail preserves the runner's real exit code
	@# across the tee. (The legacy `.sh` e2e branch is gone — epic #840.)
	@rc=0; \
	if [ "$${SAILFIN_AGENT_REPORT:-}" = "1" ]; then \
		mkdir -p build; \
		set -o pipefail; \
		$(NATIVE_BIN) test compiler/tests/unit compiler/tests/integration compiler/tests/e2e capsules $(TEST_BIN_CACHE_FLAGS) $(TEST_JOBS_FLAG) --json | tee build/agent-test.test.jsonl || rc=$$?; \
	else \
		$(NATIVE_BIN) test compiler/tests/unit compiler/tests/integration compiler/tests/e2e capsules $(TEST_BIN_CACHE_FLAGS) $(TEST_JOBS_FLAG) || rc=$$?; \
	fi; \
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
	@$(AGENT_REPORT) --target test-unit -- $(MAKE) test-unit-impl

test-unit-impl:
	@if [ ! -x $(NATIVE_BIN) ]; then \
		echo "[test-unit] missing $(NATIVE_BIN); running make compile"; \
		$(MAKE) compile; \
	fi
	@# JSON=1 / SAILFIN_AGENT_REPORT=1 gate (#1121): append `--json` so the
	@# runner emits its jsonl event stream and tee it to a stable per-target
	@# path for the report composer (#1056 Phase 2). pipefail preserves the
	@# runner's real exit code across the tee. Default (gate off) keeps the
	@# original invocation byte-for-byte and writes no file.
	@if [ "$${SAILFIN_AGENT_REPORT:-}" = "1" ]; then \
		mkdir -p build; \
		set -o pipefail; \
		$(NATIVE_BIN) test compiler/tests/unit $(TEST_JOBS_FLAG) --json | tee build/agent-test.test-unit.jsonl; \
	else \
		$(NATIVE_BIN) test compiler/tests/unit $(TEST_JOBS_FLAG); \
	fi

test-integration:
	@$(AGENT_REPORT) --target test-integration -- $(MAKE) test-integration-impl

test-integration-impl:
	@if [ ! -x $(NATIVE_BIN) ]; then \
		echo "[test-integration] missing $(NATIVE_BIN); running make compile"; \
		$(MAKE) compile; \
	fi
	@# JSON=1 gate (#1121) — see test-unit-impl for the rationale.
	@if [ "$${SAILFIN_AGENT_REPORT:-}" = "1" ]; then \
		mkdir -p build; \
		set -o pipefail; \
		$(NATIVE_BIN) test compiler/tests/integration $(TEST_JOBS_FLAG) --json | tee build/agent-test.test-integration.jsonl; \
	else \
		$(NATIVE_BIN) test compiler/tests/integration $(TEST_JOBS_FLAG); \
	fi

# The e2e suite is now entirely `*_test.sfn` (the legacy `test_*.sh`
# scripts were migrated and deleted — Phase 3.1, epic #840), so this
# is a plain alias over the unified runner on `compiler/tests/e2e`.
test-e2e:
	@$(AGENT_REPORT) --target test-e2e -- $(MAKE) test-e2e-impl

test-e2e-impl:
	@if [ ! -x $(NATIVE_BIN) ]; then \
		echo "[test-e2e] missing $(NATIVE_BIN); running make compile"; \
		$(MAKE) compile; \
	fi
	@# JSON=1 gate (#1121): append `--json` + tee for the report composer;
	@# pipefail preserves the runner's real exit code across the tee.
	@if [ "$${SAILFIN_AGENT_REPORT:-}" = "1" ]; then \
		mkdir -p build; \
		set -o pipefail; \
		$(NATIVE_BIN) test compiler/tests/e2e $(TEST_JOBS_FLAG) --json | tee build/agent-test.test-e2e.jsonl; \
	else \
		$(NATIVE_BIN) test compiler/tests/e2e $(TEST_JOBS_FLAG); \
	fi

# Per-capsule tests live alongside each capsule under
# `capsules/<scope>/<name>/tests/*_test.sfn`. The unified runner's
# directory BFS walks every nested `tests/` dir from `capsules/`,
# so passing just `capsules` matches the prior
# `find capsules -path '*/tests/*_test.sfn'` discovery.
test-capsules:
	@$(AGENT_REPORT) --target test-capsules -- $(MAKE) test-capsules-impl

test-capsules-impl:
	@if [ ! -x $(NATIVE_BIN) ]; then \
		echo "[test-capsules] missing $(NATIVE_BIN); running make compile"; \
		$(MAKE) compile; \
	fi
	@# JSON=1 gate (#1121) — see test-unit-impl for the rationale.
	@if [ "$${SAILFIN_AGENT_REPORT:-}" = "1" ]; then \
		mkdir -p build; \
		set -o pipefail; \
		$(NATIVE_BIN) test capsules $(TEST_JOBS_FLAG) --json | tee build/agent-test.test-capsules.jsonl; \
	else \
		$(NATIVE_BIN) test capsules $(TEST_JOBS_FLAG); \
	fi

# Sharded test execution for parallel CI legs. Phase 1 of
# docs/proposals/0011-ci-test-speed.md (#843 Track A): the test suite is
# ~90% of PR CI wall time and runs serially, so we fan it across
# concurrent CI legs. `scripts/test_shards.sh` owns the shard -> file
# mapping (single source of truth); `test-shard-cover` asserts the union
# of all shards equals `make test`'s surface so a rebalance can never
# silently drop coverage. Shard names: unit-a unit-b unit-c int-caps
# e2e-a e2e-b e2e-c e2e-d (see scripts/test_shards.sh for the map).
#   make test-shard SHARD=unit-a
.PHONY: test-shard test-shard-cover
SHARD ?=
test-shard:
	@if [ -z "$(SHARD)" ]; then \
		echo "[test-shard] SHARD required: unit-a|unit-b|unit-c|int-caps|e2e-a|e2e-b|e2e-c|e2e-d" >&2; \
		exit 1; \
	fi
	@if [ ! -x $(NATIVE_BIN) ]; then \
		echo "[test-shard] missing $(NATIVE_BIN); running make compile"; \
		$(MAKE) compile; \
	fi
	@# Every shard is a disjoint slice of the unified `*_test.sfn` runner
	@# (the legacy e2e `.sh` shards were retired with the bash suite — #840).
	@# JSON=1 gate (#1235): `JSON=1 make test-shard` (or SAILFIN_AGENT_REPORT=1
	@# in the env, as the macOS measurement legs set) makes test_shards.sh
	@# forward `--json` and tee build/agent-test.shard-<shard>.jsonl, whose
	@# `summary` event carries cache.test_bin_hit_rate (#1230). Default
	@# (gate off) keeps the byte-identical human run — see scripts/test_shards.sh.
	@bash scripts/test_shards.sh run "$(SHARD)" "$(NATIVE_BIN)"

# Coverage guard: fail if the shard map drops or double-counts any test
# file relative to `make test`. Needs no compiler — pure file-tree check.
test-shard-cover:
	@bash scripts/test_shards.sh cover

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

# Benchmark compiled-program runtime execution (the counterpart to `bench`,
# which measures compile time). Builds each workload under
# benchmarks/runtime/ once, then times the binary's hot loop.
# Usage:
#   make bench-runtime                                           # all workloads
#   make bench-runtime BENCH_RUNTIME_ARGS="--iterations 10"      # 10 timed runs each
#   make bench-runtime BENCH_RUNTIME_ARGS="--workload arena_alloc"
#   make bench-runtime BENCH_RUNTIME_ARGS="--csv build/runtime.csv"
#   make bench-runtime BENCH_RUNTIME_ARGS="--budget-time 1000 --budget-mem 1048576"
BENCH_RUNTIME_ARGS ?=
bench-runtime:
	@if [ ! -x "$(NATIVE_BIN)" ]; then \
		echo "[bench-runtime] missing $(NATIVE_BIN); run 'make compile' first"; \
		exit 1; \
	fi
	@bash scripts/bench_runtime.sh \
		--seed "$(NATIVE_BIN)" \
		$(BENCH_RUNTIME_ARGS)

# =============================================================================
# Arena correctness gate (Phase 0 / M0.5 prerequisite)
# =============================================================================
# Compiles a module twice (with and without SAILFIN_USE_ARENA=1) and diffs
# the emitted LLVM IR. Until the arena allocator lands, the env var is a
# no-op and the diff is trivially identical — the harness still validates.
# Once M0.5 lands (see docs/proposals/0025-native-runtime-architecture.md #321-arenas), this becomes the
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
	@$(AGENT_REPORT) --target compile -- $(MAKE) compile-impl

compile-impl:
	@if [ "$${FORCE:-0}" = "0" ] && [ -x "$(NATIVE_BIN)" ] && \
		[ -z "$$(find compiler/src runtime -type f -name '*.sfn' -newer "$(NATIVE_BIN)" -print -quit 2>/dev/null)" ]; then \
		echo "[compile] $(NATIVE_BIN) up-to-date"; \
	else \
		: "#1192: chain rebuild -> echo with && (not ;) so a failed cold"; \
		: "rebuild propagates its non-zero exit instead of being masked by"; \
		: "the trailing echo. With ; the if-compound returned the echo's 0,"; \
		: "so make compile exited 0 / status:pass on a broken self-host and"; \
		: "silently kept the stale build/native/sailfin."; \
		$(MAKE) rebuild && \
		echo "[compile] built $(NATIVE_OUT)"; \
	fi

check:
	@$(AGENT_REPORT) --target check -- $(MAKE) check-impl

check-impl:
	@$(MAKE) compile NATIVE_OPT="$(SELFHOST1_OPT)"
	@seed="build/native/sailfin"; \
	if [ ! -x "$$seed" ]; then \
		echo "[check][error] missing $$seed (run: make compile)"; \
		exit 1; \
	fi
	@echo "[check] running test suite on first-pass binary (early gate, jobs=$(CHECK_TEST_JOBS))..."
	@$(MAKE) test NATIVE_BIN=build/native/sailfin TEST_BIN_CACHE_FLAGS=--no-test-cache TEST_JOBS=$(CHECK_TEST_JOBS)
	@echo "[check] first-pass tests passed — validating self-host (stage2/stage3 fixed point)..."
	@# #1502 (epic #513 Phase 1): the stage2/stage3 builds, per-stage `.ll`
	@# scratch isolation (`SAILFIN_TEST_SCRATCH` so stage3 can't clobber
	@# stage2's IR), `--no-cache` independence, the hello-world smoke gate,
	@# the fixed-point IR hash-diff, and the seedcheck→canonical promotion
	@# are now owned by the compiler (`sfn selfhost`,
	@# compiler/src/cli_selfhost.sfn) instead of ~90 lines of shell. The
	@# verb is internal — absent from `sfn --help`; `make check` and CI are
	@# its only callers (Go keeps this in `cmd/dist`, Rust in `x.py`). A
	@# non-fixed-point result warns and still promotes (parity with the
	@# former shell, which exited 0 on `.ll` divergence); add `--strict` to
	@# make a mismatch fatal. The driver hardcodes `-O2` for the link step,
	@# so `NATIVE_OPT` overrides for stage2/stage3 are still ignored (no
	@# regression — the prior shell had the same gap). The suite legs and
	@# the first-pass `make compile` stay Make-driven (issue `Out:` scope).
	@build/native/sailfin selfhost \
		--work-dir build/selfhost \
		--first-pass build/native/sailfin \
		--seedcheck-out build/native/sailfin-seedcheck \
		--stage3-out build/native/sailfin-stage3 \
		--promote-to $(NATIVE_BIN) \
		--smoke-timeout 10
	@echo "[check] running test suite with seedcheck binary (no fallbacks, jobs=$(CHECK_TEST_JOBS))..."
	@$(MAKE) test NATIVE_BIN=build/native/sailfin-seedcheck TEST_BIN_CACHE_FLAGS=--no-test-cache TEST_JOBS=$(CHECK_TEST_JOBS)

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
	@$(AGENT_REPORT) --target check-fast -- $(MAKE) check-fast-impl

check-fast-impl:
	@if [ ! -x "$(NATIVE_BIN)" ] && [ ! -f "$(NATIVE_BIN)" ]; then \
		echo "[check-fast] missing $(NATIVE_BIN); run: make compile"; \
		exit 1; \
	fi
	@echo "[check-fast] running sfn check on compiler/src/ runtime/"
	@# JSON=1 / SAILFIN_AGENT_REPORT=1 gate (#1122): run `sfn check --json` and
	@# tee the `sailfin-check/1` envelope to build/agent-check-fast.json for the
	@# report composer (issue E). PIPESTATUS[0] preserves the check exit-code
	@# contract (0 clean / 1 diagnostics / 2 setup) across the tee, so a
	@# diagnostics run still fails the target instead of being masked by tee.
	@# Because producing the envelope IS the point of this mode, a failure to
	@# create build/ or write the file (read-only FS, disk full) is a setup
	@# error (exit 2) rather than a silent OK — check's own exit code still wins
	@# when it is non-zero. Default (no JSON=1) runs stay human-only, no file.
	@if [ "$${SAILFIN_AGENT_REPORT:-}" = "1" ]; then \
		if ! mkdir -p build; then \
			echo "[check-fast] cannot create build/ for JSON envelope" >&2; \
			exit 2; \
		fi; \
		$(NATIVE_BIN) check --json compiler/src/ runtime/ | tee build/agent-check-fast.json; \
		pipe_rc=("$${PIPESTATUS[@]}"); \
		if [ "$${pipe_rc[0]}" -ne 0 ]; then exit "$${pipe_rc[0]}"; fi; \
		if [ "$${pipe_rc[1]}" -ne 0 ]; then \
			echo "[check-fast] failed to write build/agent-check-fast.json" >&2; \
			exit 2; \
		fi; \
	else \
		$(NATIVE_BIN) check compiler/src/ runtime/; \
	fi
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
	@$(AGENT_REPORT) --target rebuild -- $(MAKE) rebuild-impl

rebuild-impl:
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
	@# #1120: under the JSON=1 / SAILFIN_AGENT_REPORT=1 gate, append
	@# `--json` so the seed emits its single-line BuildReport on stdout,
	@# and tee that to build/native/.build-report.json for the report
	@# composer (#1056 Phase 2). Human progress stays on stderr (still
	@# inherited to the terminal); pipefail keeps the seed's real exit
	@# code across the tee. On failure the seed can still emit non-JSON
	@# to stdout in `--json` mode (e.g. cli_main.sfn's "failed to compile
	@# LLVM ..." is not json-gated), so the bail block below removes the
	@# half-written report — the contract for consumers is "file exists =>
	@# valid BuildReport". Default (gate off) keeps the original
	@# `2>&1 | cat` form byte-for-byte.
	@seed=$$(cat build/.seed-resolved); \
	echo "[rebuild] running sfn build -p compiler (seed=$$seed)..."; \
	build_rc=0; \
	if [ "$${SAILFIN_AGENT_REPORT:-}" = "1" ]; then \
		mkdir -p build/native; \
		{ cd $(CURDIR) && bash -c "set -o pipefail; \"$$seed\" build $(BUILD_ARGS) --json -p compiler | tee build/native/.build-report.json"; } \
			|| build_rc=$$?; \
	else \
		{ cd $(CURDIR) && bash -c "set -o pipefail; \"$$seed\" build $(BUILD_ARGS) -p compiler 2>&1 | cat"; } \
			|| build_rc=$$?; \
	fi; \
	if [ "$$build_rc" -ne 0 ] || [ ! -f build/sailfin/program ]; then \
		echo "[rebuild][error] sfn build failed (exit=$$build_rc) or did not produce build/sailfin/program" >&2; \
		echo "[rebuild][error] expected the seed's subprocess-stage path to keep the cold build under the 8 GiB memory budget" >&2; \
		echo "[rebuild][error] if this is a regression, rerun with BUILD_ARGS='--cache-trace' to bisect, or fall back to the prior seed via .seed-version" >&2; \
		if [ "$${SAILFIN_AGENT_REPORT:-}" = "1" ]; then rm -f build/native/.build-report.json; fi; \
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
	@# #1159: the legacy flat copy above only catches modules routed to
	@# `build/sailfin/capsules/` — i.e. the compiler's own modules (its
	@# `[capsule].name = "sailfin"` is single-segment, so Stage C2b2 keeps
	@# them on the legacy path). Scope/name SOURCE-capsule deps (the first
	@# being `sfn/cli`, a compiler dependency since #1159) route instead to
	@# `build/capsules/<scope>/<name>/ir/*.ll`. The native self-host link
	@# pulls from BOTH trees, so the cross-windows IR snapshot must too —
	@# otherwise `make ci-cross-windows` link-fails with an undefined
	@# reference to the dep's symbols (e.g. `bold__sfn__cli__mod`). Flatten
	@# each `<scope>/<name>/ir/<rel>.ll` to `<scope>__<name>__ir__<rel>.ll`
	@# so the flat `build/native/raw` layout stays collision-free across
	@# capsules; the .ll filename is link-irrelevant (symbols are already
	@# mangled), it only needs to be unique. In the cross-windows CI flow
	@# this runs on a clean build whose `build/capsules/` holds exactly the
	@# compiler's source-capsule deps.
	@if [ -d build/capsules ]; then \
		find build/capsules -path '*/ir/*.ll' 2>/dev/null | while IFS= read -r f; do \
			rel="$${f#build/capsules/}"; \
			flat="$$(printf '%s' "$$rel" | sed 's#/#__#g')"; \
			cp -f "$$f" "build/native/raw/$$flat" 2>/dev/null || true; \
		done; \
	fi
	@# Runtime-object staging removed (#941). Post-#940 the freshly-built
	@# compiler resolves the runtime via runtime/capsule.toml (the
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
	@# #1289 (#1283 Gap 1): runtime/sfn/string.sfn imports OwnedBuf /
	@# owned_buf_new / owned_buf_append from ./memory/ownedbuf. The
	@# hand-rolled cross-windows RUNTIME_MODS loop (ci-cross-windows)
	@# emits string.sfn standalone and, unlike #1288's
	@# _compile_runtime_sfn_sources path, stages no sibling context of
	@# its own — so without ownedbuf's `.sfn-asm` + layout-manifest staged
	@# here the cold emit dies with "cannot resolve return type for call
	@# to owned_buf_new". owned_buf_new returns OwnedBuf BY VALUE, so the
	@# layout-manifest (the struct layout) is required alongside the fn
	@# signature, not just the signature. Same staging shape as the
	@# platform loop above; the rm forces a canonical NATIVE_OUT re-emit.
	@rm -f build/native/import-context/runtime/sfn/memory/ownedbuf.sfn-asm build/native/import-context/runtime/sfn/memory/ownedbuf.layout-manifest
	@mkdir -p build/native/import-context/runtime/sfn/memory
	@set -e; \
	ob_asm="build/native/import-context/runtime/sfn/memory/ownedbuf.sfn-asm"; \
	ob_manifest="build/native/import-context/runtime/sfn/memory/ownedbuf.layout-manifest"; \
	if [ ! -f "$$ob_asm" ]; then \
		echo "[rebuild] staging runtime/sfn/memory/ownedbuf.sfn-asm..."; \
		if ! $(NATIVE_OUT) emit --module-name "runtime/sfn/memory/ownedbuf" -o "$$ob_asm" native "runtime/sfn/memory/ownedbuf.sfn" >/dev/null; then \
			echo "[rebuild][error] emit native failed for runtime/sfn/memory/ownedbuf.sfn" >&2; \
			rm -f "$$ob_asm"; \
			exit 1; \
		fi; \
		if [ ! -s "$$ob_asm" ]; then \
			echo "[rebuild][error] emit native produced empty $$ob_asm" >&2; \
			rm -f "$$ob_asm"; \
			exit 1; \
		fi; \
	fi; \
	if [ ! -f "$$ob_manifest" ]; then \
		grep '^\.layout' "$$ob_asm" > "$$ob_manifest" 2>/dev/null || :; \
		[ -f "$$ob_manifest" ] || touch "$$ob_manifest"; \
	fi
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
	$(CLANG) -target x86_64-w64-mingw32 $(NATIVE_OPT) -fno-delete-null-pointer-checks -femulated-tls \
		-c "$$WIN_OBJ/sailfin.linked.bc" -o "$$WIN_OBJ/native.linked.o"; \
	\
	echo "[cross-windows] emitting + compiling runtime modules..."; \
	\
	: "#941: the runtime IR this target consumes is now emitted by"; \
	: "ci-cross-windows itself (was staged by 'make rebuild', deleted"; \
	: "in #941). RUNTIME_MODS is this bridge's copy of"; \
	: "runtime/capsule.toml's sfn-sources (+ the prelude-entry),"; \
	: "MINUS process.sfn (its posix_spawnp/waitpid libc externs do not"; \
	: "exist under mingw) PLUS process_windows.sfn in its place — the"; \
	: "module split (#822/#1308) that owns the Windows @sfn_process_*"; \
	: "family (real CreateProcessA run/exit, degraded rest) now that the"; \
	: "_WIN32 C wrapper in sailfin_runtime.c is DELETED — and MINUS"; \
	: "platform/rlimit.sfn, whose getrlimit/setrlimit libc externs do"; \
	: "not exist under mingw; Windows resolves @apply_default_mem_limit"; \
	: "from the strong no-op stub in runtime/ir/windows_stubs.ll"; \
	: "instead. A guard test"; \
	: "(compiler/tests/e2e/test_cross_windows_runtime_modules.sh) asserts"; \
	: "this list stays in sync with the manifest (Risk R4). clock is"; \
	: "re-emitted with SAILFIN_TARGET_OS=Windows for the errno->_errno"; \
	: "fix (#877), and exec for the exe-path intrinsic leg (#967/#971):"; \
	: "without the target override exe_path_locator() probes 'uname -s'"; \
	: "on the Linux host and emits the readlink leg, leaving an undefined"; \
	: "readlink reference once the MinGW stub is gone; Windows selects the"; \
	: "GetModuleFileNameA leg instead. The rest are target-independent IR"; \
	: "compiled for mingw. Each <module>:<source> pair is space-separated."; \
	RUNTIME_MODS="prelude:runtime/prelude.sfn runtime_globals:runtime/sfn/runtime_globals.sfn arena:runtime/sfn/memory/arena.sfn rc:runtime/sfn/memory/rc.sfn mem:runtime/sfn/memory/mem.sfn ownedbuf:runtime/sfn/memory/ownedbuf.sfn string:runtime/sfn/string.sfn array:runtime/sfn/array.sfn clock:runtime/sfn/clock.sfn io:runtime/sfn/io.sfn exception:runtime/sfn/exception.sfn type_meta:runtime/sfn/type_meta.sfn exec:runtime/sfn/platform/exec.sfn filesystem:runtime/sfn/adapters/filesystem.sfn http:runtime/sfn/adapters/http.sfn process_windows:runtime/sfn/platform/process_windows.sfn"; \
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
		: "inlined shell retry loop that mirrored the resolver. clock + exec"; \
		: "+ filesystem re-emit with SAILFIN_TARGET_OS=Windows: clock/exec for"; \
		: "the errno/exe_path sentinels, filesystem for the #1308 fs sentinels"; \
		: "(symlink/mkdtemp/get_perms/exists) whose Windows leg is a bare stub"; \
		: "so the MinGW-absent symbols never enter the IR. See the RUNTIME_MODS"; \
		: "comment above for the per-module target-override rationale."; \
		rm -f "$$ll"; \
		if [ "$$mod" = "clock" ] || [ "$$mod" = "exec" ] || [ "$$mod" = "filesystem" ]; then \
			SAILFIN_TARGET_OS=Windows $(NATIVE_OUT) emit --attempts 3 --validate -o "$$ll" llvm "$$src" >/dev/null || { \
				echo "[cross-windows][error] failed to emit valid $$mod IR" >&2; exit 1; }; \
		else \
			$(NATIVE_OUT) emit --attempts 3 --validate -o "$$ll" llvm "$$src" >/dev/null || { \
				echo "[cross-windows][error] failed to emit valid $$mod IR" >&2; exit 1; }; \
		fi; \
		$(CLANG) -target x86_64-w64-mingw32 $(NATIVE_OPT) -fno-delete-null-pointer-checks -femulated-tls \
			-c "$$ll" -o "$$obj"; \
		RUNTIME_OBJS="$$RUNTIME_OBJS $$obj"; \
	done; \
	\
	echo "[cross-windows] compiling Windows link stubs..."; \
	: "#822 / #1308: sailfin_runtime.c is DELETED — the runtime is fully"; \
	: "Sailfin-owned. The Windows @sfn_process_* family now comes from"; \
	: "process_windows.sfn (in RUNTIME_MODS above); shell_capture from io.sfn."; \
	: "@runtime (#1436) now comes from runtime_globals.sfn (in RUNTIME_MODS)."; \
	: "#823: runtime/native/ deleted; runtime_globals.ll (definition-less"; \
	: "after @runtime/@sfn_default_arena retired) is gone, and windows_stubs.ll"; \
	: "moved up to runtime/ir/. Windows-only strong stubs for symbols whose"; \
	: "Sailfin modules are excluded from RUNTIME_MODS (see"; \
	: "runtime/ir/windows_stubs.ll for the per-symbol rationale and the"; \
	: "weak-vs-strong COFF note)."; \
	$(CLANG) -target x86_64-w64-mingw32 $(NATIVE_OPT) -c runtime/ir/windows_stubs.ll \
		-o "$$WIN_OBJ/windows_stubs.o"; \
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
		"$$WIN_OBJ/windows_stubs.o" \
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
	cp -f runtime/capsule.toml "$$INSTALLER_DIR/runtime/capsule.toml"; \
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
