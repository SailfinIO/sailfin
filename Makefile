# Sailfin project automation

# Silence noisy clang warning when compiling embedded-IR modules that carry a
# different target triple than the host.
CLANG_WARN_SUPPRESS ?= -Wno-override-module

CLANG ?= clang

# Optimization level for building the native compiler binary.
# Note: many legacy targets/artifacts still use the historical "stage2" naming.
# CI may override to speed up the legacy stage1/bootstrap fallback targets.
NATIVE_OPT ?= -O2

# Extra flags used when compiling LLVM IR (.ll) with clang.
# Some distros ship clang builds that default to typed pointers, but the native
# compiler emits
# opaque-pointer IR using the `ptr` keyword. In that case, pass:
#   CLANG_LL_FLAGS=-mllvm -opaque-pointers
CLANG_LL_FLAGS ?=

# Parallelism for compiling many native AOT LLVM modules.
# Override in CI as needed (e.g. NATIVE_JOBS=2 for smaller runners).
NATIVE_JOBS ?= $(shell (sysctl -n hw.ncpu 2>/dev/null || nproc 2>/dev/null || echo 4) | head -n 1)

# Parallelism for the selfhost orchestrator's per-module seed emit + clang compile.
# Keep conservative by default: this can increase peak memory.
SELFHOST_JOBS ?= 1

UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
STAGE2_NATIVE_LIBS ?=
NATIVE_LINK_DETERMINISTIC_FLAGS ?= -Wl,-no_uuid
TIMEOUT_CMD ?=
else
STAGE2_NATIVE_LIBS ?= -lm -pthread
NATIVE_LINK_DETERMINISTIC_FLAGS ?= -Wl,--build-id=none
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

STAGE2_AOT_DIR ?= build/stage2/aot
STAGE2_AOT_MODULES_FILE ?= $(STAGE2_AOT_DIR)/modules.txt

NATIVE_OBJ_DIR ?= build/native/obj
NATIVE_OUT ?= build/native/sailfin
NATIVE_LINK_EXTRA ?=

# Preferred local path for the native compiler binary.
# We keep the legacy artifact name (sailfin-stage2) for now, but expose a stable
# alias path so we can transition away from "stage2" naming without breaking CI.
NATIVE_BIN ?= build/native/sailfin

# Which compiler binary to use for running Sailfin-native tests.
# Default: the native compiler alias produced by `make compile`.

.PHONY: help install fetch-seed test test-unit test-integration test-e2e compile bootstrap-legacy clean package native-stage2-debug native-stage2-asan check-stage2-determinism check-native-stage2-determinism check-seed-llvm-emission

.PHONY: selfhost-native selfhost-smoke-native check-native-determinism native-debug native-asan native-ubsan

ifeq ($(origin CONDA_EXE), undefined)
# `conda` is often a shell function (e.g. in zsh/bash init). We need the actual
# executable path for Makefile recipes.
CONDA_EXE := $(shell { type -P conda 2>/dev/null || /usr/bin/which conda 2>/dev/null; } | head -n 1)
endif
ifeq ($(strip $(CONDA_EXE)),)
$(error "conda" executable not found. Export CONDA_EXE or install Conda.)
endif
CONDA ?= $(CONDA_EXE)
CONDA_ENV ?= sailfin
CONDA_ENV_FILE ?= environment.yml

help:
	@echo "Common Sailfin tasks"
	@echo "  make install      # Create or update the Conda env used for the compiler"
	@echo "  make fetch-seed   # Download the latest released seed into build/seed/ (requires GITHUB_TOKEN)"
	@echo "  make test         # Run Sailfin-native unit + integration tests"
	@echo "  make test-unit    # Run Sailfin-native unit tests (self-hosted compiler)"
	@echo "  make test-integration # Run Sailfin-native integration tests"
	@echo "  make test-e2e     # Run Sailfin-native end-to-end tests"
	@echo "  make compile      # Build the compiler by self-hosting from a released seed"
	@echo "  make selfhost-native # Rebuild the compiler from a seed"
	@echo "  make selfhost-smoke-native # Selfhost + run smoke tests"
	@echo "  make bootstrap-legacy # Legacy stage1/bootstrap pipeline (deprecated; emergency recovery only)"
	@echo "  make legacy-bootstrap # Alias for bootstrap-legacy"
	@echo "  make check-stage2-determinism # Bootstrap stage2 twice and diff outputs"
	@echo "  make check-native-stage2-determinism # Rebuild native compiler twice and diff the binaries (legacy name: stage2)"
	@echo "  make check-native-determinism # Alias for check-native-stage2-determinism"
	@echo "  make clean        # Remove packaged artifacts (dist/)"
	@echo "  make native-stage2-debug # Build native compiler (legacy: stage2) with -O0/-g for lldb (bootstrap-built)"
	@echo "  make native-debug  # Alias for native-stage2-debug"
	@echo "  make native-stage2-asan # Build native compiler (legacy: stage2) with AddressSanitizer (bootstrap-built)"
	@echo "  make native-asan   # Alias for native-stage2-asan"

install:
	$(CONDA) env update --file $(CONDA_ENV_FILE) --name $(CONDA_ENV)

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
# Override with a full path if needed, e.g. SEED_STAGE2=build/seed/bin/sailfin-stage2.
SEED_STAGE2 ?= sfn

FETCHED_SEED_STAGE2 ?= $(SEED_GLOBAL_BIN_DIR)/sailfin

fetch-seed:
	@echo "[fetch-seed] installing seed into $(SEED_INSTALL_BASE)"
	@mkdir -p build/seed
	@REPO="$(SEED_REPO)" VERSION="$(SEED_VERSION)" EXCLUDE_TAG="$(SEED_EXCLUDE_TAG)" \
		GLOBAL_BIN_DIR="$(SEED_GLOBAL_BIN_DIR)" INSTALL_BASE="$(SEED_INSTALL_BASE)" \
		BINARY="sailfin" ./install.sh
	@if [ ! -x "$(FETCHED_SEED_STAGE2)" ]; then \
		echo "[fetch-seed][error] missing fetched seed compiler: $(FETCHED_SEED_STAGE2)" >&2; \
		exit 1; \
	fi
	@"$(FETCHED_SEED_STAGE2)" version
	@echo "[fetch-seed] hint: make compile SEED_STAGE2=$(FETCHED_SEED_STAGE2)"

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
	@$(MAKE) selfhost-native
	@echo "[compile] built $(NATIVE_OUT)"

# Naming aliases: prefer "native compiler" terminology.
native-ubsan: native-stage2-ubsan

# Explicit legacy alias to make the fallback nature obvious.
legacy-bootstrap: bootstrap-legacy

# Deprecated: legacy stage1/bootstrap pipeline.
# Kept for debugging and emergency recovery only.
bootstrap-legacy:
	$(CONDA) run -n $(CONDA_ENV) python tools/compile_with_stage1.py
	$(CONDA) run --no-capture-output -n $(CONDA_ENV) python scripts/bootstrap_native.py --no-validate
	$(MAKE) _build-native-stage2
	@mkdir -p build/native
	@rm -rf build/native/import-context
	@if [ -d build/stage2 ]; then \
		mkdir -p build/native/import-context; \
		cp -a build/stage2/. build/native/import-context/; \
	fi
	@rm -rf build/native/aot
	@if [ -f build/stage2/aot/modules.txt ]; then \
		mkdir -p build/native/aot; \
		cp -f build/stage2/aot/modules.txt build/native/aot/modules.txt; \
	fi
	@echo "[bootstrap-legacy] built $(NATIVE_OUT)"

# Usage:
#   make selfhost-native
#   make selfhost-native SEED_NATIVE=path/to/sailfin
# Output:
#   build/native/sailfin
#
# Notes:
# - Defaults to a non-ASAN seed for speed.
# - Use `make selfhost-native-asan` for the slower-but-more-diagnostic ASAN seed.
# - Always runs the orchestrator script via the Conda env Python.
# - Pass extra flags via SELFHOST_ARGS (e.g. SELFHOST_ARGS="--seed-timeout 300").
# - Parallelize module building via SELFHOST_JOBS (e.g. SELFHOST_JOBS=2).
selfhost-native:
	@seed="$${SEED_NATIVE:-$${SEED_STAGE2:-$(SEED_STAGE2)}}"; \
	resolved_seed="$$seed"; \
	if command -v "$$seed" >/dev/null 2>&1; then \
		resolved_seed="$$(command -v "$$seed")"; \
	fi; \
	seed="$$resolved_seed"; \
	if [ ! -x "$$seed" ]; then \
		echo "[selfhost-native] missing seed compiler: $$seed"; \
		echo "[selfhost-native] fetching seed with: make fetch-seed"; \
		$(MAKE) fetch-seed; \
		seed="$(FETCHED_SEED_STAGE2)"; \
	fi; \
	if [ ! -x "$$seed" ]; then \
		echo "[selfhost-native] missing seed compiler: $$seed"; \
		exit 1; \
	fi; \
	if ! "$$seed" emit native compiler/src/version.sfn >/dev/null 2>&1; then \
		echo "[selfhost-native][error] seed compiler does not support 'emit native'" >&2; \
		echo "[selfhost-native][error] install a newer seed (>= 0.1.1-alpha.115) or run: make fetch-seed" >&2; \
		exit 1; \
	fi; \
	if [ -d build/native/import-context ]; then \
		find build/native/import-context -type f \( -name '*.sfn-asm' -o -name '*.layout-manifest' \) -delete; \
	fi; \
	echo "[selfhost-native] running selfhost script (seed=$$seed)..."; \
	$(CONDA) run --no-capture-output -n $(CONDA_ENV) python -u scripts/selfhost_native.py --seed "$$seed" --no-prefer-asan-seed --jobs $(SELFHOST_JOBS) $(SELFHOST_ARGS) --out $(NATIVE_OUT)
	@SRC="build/selfhost/native/seed_cwd/build/import-context"; \
	if [ ! -d "$$SRC" ]; then \
		SRC="build/selfhost/native/seed_cwd/build/stage2"; \
	fi; \
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
	@echo "[selfhost-native] built $(NATIVE_OUT)"

# Smoke: selfhost native and run hello-world + emit-llvm-file.
# Usage:
#   make selfhost-smoke-native
#   make selfhost-smoke-native SEED_NATIVE=path/to/sailfin
#   make selfhost-smoke-native SELFHOST_SMOKE_ARGS="--keep-work-dir"
SELFHOST_SMOKE_OUT ?= $(NATIVE_OUT)
SELFHOST_SMOKE_ARGS ?=
selfhost-smoke-native:
	@seed="$${SEED_NATIVE:-$${SEED_STAGE2:-$(SEED_STAGE2)}}"; \
	resolved_seed="$$seed"; \
	if command -v "$$seed" >/dev/null 2>&1; then \
		resolved_seed="$$(command -v "$$seed")"; \
	fi; \
	seed="$$resolved_seed"; \
	if [ ! -x "$$seed" ]; then \
		echo "[selfhost-smoke-native] missing seed compiler: $$seed"; \
		echo "[selfhost-smoke-native] fetching seed with: make fetch-seed"; \
		$(MAKE) fetch-seed; \
		seed="$(FETCHED_SEED_STAGE2)"; \
	fi; \
	if [ ! -x "$$seed" ]; then \
		echo "[selfhost-smoke-native] missing seed compiler: $$seed"; \
		exit 1; \
	fi; \
	if ! "$$seed" emit native compiler/src/version.sfn >/dev/null 2>&1; then \
		echo "[selfhost-smoke-native][error] seed compiler does not support 'emit native'" >&2; \
		echo "[selfhost-smoke-native][error] install a newer seed (>= 0.1.1-alpha.115) or run: make fetch-seed" >&2; \
		exit 1; \
	fi; \
	echo "[selfhost-smoke-native] running smoke harness..."; \
	$(CONDA) run --no-capture-output -n $(CONDA_ENV) python -u scripts/selfhost_smoke_native.py \
		--seed "$$seed" \
		--out $(SELFHOST_SMOKE_OUT) \
		--jobs $(SELFHOST_JOBS) \
		--import-context-jobs 1 \
		$(SELFHOST_SMOKE_ARGS)
	@echo "[selfhost-smoke-native] OK"

selfhost-native-asan: native-stage2-asan
	@seed=$${SEED_STAGE2:-build/native/sailfin-asan}; \
	if [ ! -x "$$seed" ]; then \
		echo "[selfhost-native-asan] missing seed compiler: $$seed"; \
		echo "[selfhost-native-asan] (hint) build one with: make native-stage2-asan"; \
		exit 1; \
	fi; \
	echo "[selfhost-native-asan] running selfhost script (ASAN output)..."; \
	$(CONDA) run --no-capture-output -n $(CONDA_ENV) python -u scripts/selfhost_native.py --asan --seed "$$seed" --no-prefer-asan-seed --jobs $(SELFHOST_JOBS) $(SELFHOST_ARGS) --out build/native/sailfin-selfhost
	@echo "[selfhost-native-asan] built build/native/sailfin-selfhost"


_build-native-stage2:
	@if [ ! -f $(STAGE2_AOT_MODULES_FILE) ]; then \
		echo "[_build-native-stage2] missing $(STAGE2_AOT_MODULES_FILE); run make bootstrap-legacy first"; \
		exit 1; \
	fi
	@mkdir -p $(NATIVE_OBJ_DIR)
	@rm -rf $(NATIVE_OBJ_DIR)/*
	$(CLANG) $(NATIVE_OPT) -fno-delete-null-pointer-checks $(CLANG_WARN_SUPPRESS) -I runtime/native/include -c runtime/native/src/sailfin_runtime.c -o $(NATIVE_OBJ_DIR)/sailfin_runtime.o
	$(CLANG) $(NATIVE_OPT) $(CLANG_WARN_SUPPRESS) -I runtime/native/include -c runtime/native/src/native_driver.c -o $(NATIVE_OBJ_DIR)/native_driver.o
	@echo "[_build-native-stage2] compile runtime IR: runtime_globals.ll"
	$(CLANG_LL_COMPILE) $(NATIVE_OPT) $(CLANG_WARN_SUPPRESS) -c runtime/native/ir/runtime_globals.ll -o $(NATIVE_OBJ_DIR)/runtime_globals.o
	@echo "[_build-native-stage2] compile AOT LLVM modules (jobs=$(NATIVE_JOBS))"
	@if [ "$(NATIVE_JOBS)" = "1" ]; then \
	  set -e; \
	  while IFS= read -r m; do \
	    [ -z "$$m" ] && continue; \
	    echo "[_build-native-stage2][aot] $$m"; \
	    mkdir -p "$$(dirname "$(NATIVE_OBJ_DIR)/$$m.o")"; \
	    $(CLANG_LL_COMPILE) $(NATIVE_OPT) $(CLANG_WARN_SUPPRESS) $(CLANG_LL_FLAGS) -fPIC -c "$(STAGE2_AOT_DIR)/$$m.ll" -o "$(NATIVE_OBJ_DIR)/$$m.o"; \
	    rc=$$?; \
	    if [ $$rc -ne 0 ]; then \
	      echo "[_build-native-stage2][error] module $$m failed (rc=$$rc)" >&2; \
	      exit $$rc; \
	    fi; \
	  done < $(STAGE2_AOT_MODULES_FILE); \
	else \
	  awk 'NF' $(STAGE2_AOT_MODULES_FILE) | \
	    xargs -I {} -P $(NATIVE_JOBS) sh -c 'm="{}"; \
	      echo "[_build-native-stage2][aot] $$m"; \
	      mkdir -p "$$(dirname "$(NATIVE_OBJ_DIR)/$$m.o")"; \
	      $(CLANG_LL_COMPILE) $(NATIVE_OPT) $(CLANG_WARN_SUPPRESS) $(CLANG_LL_FLAGS) -fPIC -c "$(STAGE2_AOT_DIR)/$$m.ll" -o "$(NATIVE_OBJ_DIR)/$$m.o"; \
	      rc=$$?; \
	      if [ $$rc -ne 0 ]; then \
	        echo "[_build-native-stage2][error] module $$m failed (rc=$$rc)" >&2; \
	        exit $$rc; \
	      fi'; \
	fi
	$(CLANG) $(NATIVE_OPT) $(CLANG_WARN_SUPPRESS) -o $(NATIVE_OUT) \
		$(NATIVE_OBJ_DIR)/sailfin_runtime.o \
		$(NATIVE_OBJ_DIR)/native_driver.o \
		$(NATIVE_OBJ_DIR)/runtime_globals.o \
		$$(sed 's|^|$(NATIVE_OBJ_DIR)/|; s|$$|.o|' $(STAGE2_AOT_MODULES_FILE) | tr '\n' ' ') \
		$(NATIVE_LINK_EXTRA) $(STAGE2_NATIVE_LIBS)

check-stage2-determinism:
	@echo "[check-stage2-determinism] bootstrapping twice and diffing outputs"
	$(CONDA) run -n $(CONDA_ENV) python tools/compile_with_stage1.py
	@rm -rf build/stage2-diff-a build/stage2-diff-b build/stage2-diff.patch
	$(CONDA) run -n $(CONDA_ENV) python scripts/bootstrap_stage2.py --no-validate --out build/stage2-diff-a
	$(CONDA) run -n $(CONDA_ENV) python scripts/bootstrap_stage2.py --no-validate --out build/stage2-diff-b
	@diff -ru build/stage2-diff-a build/stage2-diff-b > build/stage2-diff.patch || (\
		echo "[check-stage2-determinism] NON-DETERMINISTIC output; showing first 200 diff lines"; \
		head -n 200 build/stage2-diff.patch; \
		echo "[check-stage2-determinism] full diff: build/stage2-diff.patch"; \
		exit 1)
	@echo "[check-stage2-determinism] OK (no diffs)"

check-native-stage2-determinism:
	@if [ ! -f $(STAGE2_AOT_MODULES_FILE) ]; then \
		echo "[check-native-stage2-determinism] missing $(STAGE2_AOT_MODULES_FILE); run make bootstrap-legacy first"; \
		exit 1; \
	fi
	@echo "[check-native-stage2-determinism] rebuilding native stage2 twice and comparing binaries"
	@rm -rf build/native-diff-a build/native-diff-b
	@mkdir -p build/native-diff-a build/native-diff-b
	$(MAKE) _build-native-stage2 \
		NATIVE_OBJ_DIR=build/native-diff-a/obj \
		NATIVE_OUT=build/native-diff-a/sailfin-stage2 \
		NATIVE_LINK_EXTRA='$(NATIVE_LINK_DETERMINISTIC_FLAGS)'
	$(MAKE) _build-native-stage2 \
		NATIVE_OBJ_DIR=build/native-diff-b/obj \
		NATIVE_OUT=build/native-diff-b/sailfin-stage2 \
		NATIVE_LINK_EXTRA='$(NATIVE_LINK_DETERMINISTIC_FLAGS)'
	@cmp -s build/native-diff-a/sailfin-stage2 build/native-diff-b/sailfin-stage2 || (\
		echo "[check-native-stage2-determinism] NON-DETERMINISTIC binary output"; \
		echo "[check-native-stage2-determinism] sha256:"; \
		shasum -a 256 build/native-diff-a/sailfin-stage2 build/native-diff-b/sailfin-stage2; \
		exit 1)
	@echo "[check-native-stage2-determinism] OK (byte-identical)"

native-stage2-o1: bootstrap-legacy
	@mkdir -p build/native/o1-obj
	@rm -rf build/native/o1-obj/*
	$(CLANG) -O1 -g -fno-omit-frame-pointer -fno-delete-null-pointer-checks $(CLANG_WARN_SUPPRESS) -I runtime/native/include -c runtime/native/src/sailfin_runtime.c -o build/native/o1-obj/sailfin_runtime.o
	$(CLANG) -O1 -g -fno-omit-frame-pointer $(CLANG_WARN_SUPPRESS) -I runtime/native/include -c runtime/native/src/native_driver.c -o build/native/o1-obj/native_driver.o
	$(CLANG) -O1 -g -fno-omit-frame-pointer $(CLANG_WARN_SUPPRESS) -c runtime/native/ir/runtime_globals.ll -o build/native/o1-obj/runtime_globals.o
	@while IFS= read -r m ; do \
	  [ -z "$$m" ] && continue; \
	  mkdir -p "$$(dirname build/native/o1-obj/$$m.o)"; \
	  $(CLANG) -O1 -g -fno-omit-frame-pointer $(CLANG_WARN_SUPPRESS) $(CLANG_LL_FLAGS) -fPIC -c build/stage2/aot/$$m.ll -o build/native/o1-obj/$$m.o; \
	done < build/stage2/aot/modules.txt
	$(CLANG) -O1 -g -fno-omit-frame-pointer $(CLANG_WARN_SUPPRESS) -o build/native/sailfin-stage2-o1 build/native/o1-obj/sailfin_runtime.o build/native/o1-obj/native_driver.o build/native/o1-obj/runtime_globals.o $$(sed 's|^|build/native/o1-obj/|; s|$$|.o|' build/stage2/aot/modules.txt | tr '\n' ' ') $(STAGE2_NATIVE_LIBS)

native-stage2-debug: bootstrap-legacy
	@mkdir -p build/native/debug-obj
	@rm -rf build/native/debug-obj/*
	$(CLANG) -O0 -g -fno-omit-frame-pointer -fno-delete-null-pointer-checks $(CLANG_WARN_SUPPRESS) -I runtime/native/include -c runtime/native/src/sailfin_runtime.c -o build/native/debug-obj/sailfin_runtime.o
	$(CLANG) -O0 -g -fno-omit-frame-pointer $(CLANG_WARN_SUPPRESS) -I runtime/native/include -c runtime/native/src/native_driver.c -o build/native/debug-obj/native_driver.o
	$(CLANG) -O0 -g -fno-omit-frame-pointer $(CLANG_WARN_SUPPRESS) -c runtime/native/ir/runtime_globals.ll -o build/native/debug-obj/runtime_globals.o
	@while IFS= read -r m ; do \
	  [ -z "$$m" ] && continue; \
	  mkdir -p "$$(dirname build/native/debug-obj/$$m.o)"; \
	  $(CLANG) -O0 -g -fno-omit-frame-pointer $(CLANG_WARN_SUPPRESS) $(CLANG_LL_FLAGS) -fPIC -c build/stage2/aot/$$m.ll -o build/native/debug-obj/$$m.o; \
	done < build/stage2/aot/modules.txt
	$(CLANG) -O0 -g -fno-omit-frame-pointer $(CLANG_WARN_SUPPRESS) -o build/native/sailfin-stage2-debug build/native/debug-obj/sailfin_runtime.o build/native/debug-obj/native_driver.o build/native/debug-obj/runtime_globals.o $$(sed 's|^|build/native/debug-obj/|; s|$$|.o|' build/stage2/aot/modules.txt | tr '\n' ' ') $(STAGE2_NATIVE_LIBS)

native-stage2-asan: bootstrap-legacy
	@mkdir -p build/native/asan-obj
	@rm -rf build/native/asan-obj/*
	$(CLANG) -O1 -g -fno-omit-frame-pointer -fno-delete-null-pointer-checks -fsanitize=address $(CLANG_WARN_SUPPRESS) -I runtime/native/include -c runtime/native/src/sailfin_runtime.c -o build/native/asan-obj/sailfin_runtime.o
	$(CLANG) -O1 -g -fno-omit-frame-pointer -fsanitize=address $(CLANG_WARN_SUPPRESS) -I runtime/native/include -c runtime/native/src/native_driver.c -o build/native/asan-obj/native_driver.o
	$(CLANG) -O1 -g -fno-omit-frame-pointer -fsanitize=address $(CLANG_WARN_SUPPRESS) -c runtime/native/ir/runtime_globals.ll -o build/native/asan-obj/runtime_globals.o
	@while IFS= read -r m ; do \
	  [ -z "$$m" ] && continue; \
	  mkdir -p "$$(dirname build/native/asan-obj/$$m.o)"; \
	  $(CLANG) -O1 -g -fno-omit-frame-pointer -fsanitize=address $(CLANG_WARN_SUPPRESS) $(CLANG_LL_FLAGS) -fPIC -c build/stage2/aot/$$m.ll -o build/native/asan-obj/$$m.o; \
	done < build/stage2/aot/modules.txt
	$(CLANG) -O1 -g -fno-omit-frame-pointer -fsanitize=address $(CLANG_WARN_SUPPRESS) -o build/native/sailfin-stage2-asan build/native/asan-obj/sailfin_runtime.o build/native/asan-obj/native_driver.o build/native/asan-obj/runtime_globals.o $$(sed 's|^|build/native/asan-obj/|; s|$$|.o|' build/stage2/aot/modules.txt | tr '\n' ' ') $(STAGE2_NATIVE_LIBS)

native-stage2-ubsan: bootstrap-legacy
	@mkdir -p build/native/ubsan-obj
	@rm -rf build/native/ubsan-obj/*
	$(CLANG) -O1 -g -fno-omit-frame-pointer -fno-delete-null-pointer-checks -fsanitize=undefined -fno-sanitize-recover=undefined $(CLANG_WARN_SUPPRESS) -I runtime/native/include -c runtime/native/src/sailfin_runtime.c -o build/native/ubsan-obj/sailfin_runtime.o
	$(CLANG) -O1 -g -fno-omit-frame-pointer -fsanitize=undefined -fno-sanitize-recover=undefined $(CLANG_WARN_SUPPRESS) -I runtime/native/include -c runtime/native/src/native_driver.c -o build/native/ubsan-obj/native_driver.o
	$(CLANG) -O1 -g -fno-omit-frame-pointer -fsanitize=undefined -fno-sanitize-recover=undefined $(CLANG_WARN_SUPPRESS) -c runtime/native/ir/runtime_globals.ll -o build/native/ubsan-obj/runtime_globals.o
	@while IFS= read -r m ; do \
	  [ -z "$$m" ] && continue; \
	  mkdir -p "$$(dirname build/native/ubsan-obj/$$m.o)"; \
	  $(CLANG) -O1 -g -fno-omit-frame-pointer -fsanitize=undefined -fno-sanitize-recover=undefined $(CLANG_WARN_SUPPRESS) $(CLANG_LL_FLAGS) -fPIC -c build/stage2/aot/$$m.ll -o build/native/ubsan-obj/$$m.o; \
	done < build/stage2/aot/modules.txt
	$(CLANG) -O1 -g -fno-omit-frame-pointer -fsanitize=undefined -fno-sanitize-recover=undefined $(CLANG_WARN_SUPPRESS) -o build/native/sailfin-stage2-ubsan build/native/ubsan-obj/sailfin_runtime.o build/native/ubsan-obj/native_driver.o build/native/ubsan-obj/runtime_globals.o $$(sed 's|^|build/native/ubsan-obj/|; s|$$|.o|' build/stage2/aot/modules.txt | tr '\n' ' ') $(STAGE2_NATIVE_LIBS)
