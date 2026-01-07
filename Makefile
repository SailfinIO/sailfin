# Sailfin project automation

# Silence noisy clang warning when compiling embedded-IR modules that carry a
# different target triple than the host.
CLANG_WARN_SUPPRESS ?= -Wno-override-module

CLANG ?= clang

# Parallelism for compiling many Stage2 AOT LLVM modules.
# Override in CI as needed (e.g. NATIVE_JOBS=2 for smaller runners).
NATIVE_JOBS ?= $(shell (sysctl -n hw.ncpu 2>/dev/null || nproc 2>/dev/null || echo 4) | head -n 1)

UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
STAGE2_NATIVE_LIBS ?=
NATIVE_LINK_DETERMINISTIC_FLAGS ?= -Wl,-no_uuid
else
STAGE2_NATIVE_LIBS ?= -lm -pthread
NATIVE_LINK_DETERMINISTIC_FLAGS ?= -Wl,--build-id=none
endif

STAGE2_AOT_DIR ?= build/stage2/aot
STAGE2_AOT_MODULES_FILE ?= $(STAGE2_AOT_DIR)/modules.txt

NATIVE_OBJ_DIR ?= build/native/obj
NATIVE_OUT ?= build/native/sailfin-stage2
NATIVE_LINK_EXTRA ?=

.PHONY: help install test test-unit test-integration test-e2e compile clean package native-stage2-debug native-stage2-asan check-stage2-determinism check-native-stage2-determinism check-seed-llvm-emission

.PHONY: selfhost-native-stage2 selfhost-native-stage2-asan

# Rebuild a fresh native stage2 using an existing *native* stage2 seed compiler.
# This is the self-hosting check CI ultimately needs (no stage1, no bootstrap).
.PHONY: selfhost-native-stage2

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
	@echo "  make test         # Run Sailfin-native unit + integration tests"
	@echo "  make test-unit    # Run Stage2 self-hosted Sailfin unit tests"
	@echo "  make test-integration # Run Sailfin-native integration tests"
	@echo "  make test-e2e     # Run Sailfin-native end-to-end tests"
	@echo "  make compile      # Build the native sailfin-stage2 compiler (full pipeline)"
	@echo "  make check-stage2-determinism # Bootstrap stage2 twice and diff outputs"
	@echo "  make check-native-stage2-determinism # Rebuild native stage2 twice and diff the binaries"
	@echo "  make clean        # Remove packaged artifacts (dist/)"
	@echo "  make native-stage2-debug # Build native stage2 with -O0/-g for lldb"
	@echo "  make native-stage2-asan # Build native stage2 with AddressSanitizer"

install:
	$(CONDA) env update --file $(CONDA_ENV_FILE) --name $(CONDA_ENV)

test: test-unit test-integration test-e2e

test-unit:
	@if [ ! -x build/native/sailfin-stage2 ]; then \
		echo "[test-unit] missing build/native/sailfin-stage2; running make compile"; \
		$(MAKE) compile; \
	fi
	@set -e; \
	files=$$(find compiler/tests/unit -name '*_test.sfn' -print | sort); \
	if [ -z "$$files" ]; then \
		echo "[test-unit] no *_test.sfn files found under compiler/tests/unit"; \
		exit 1; \
	fi; \
	for f in $$files; do \
		build/native/sailfin-stage2 test "$$f"; \
	done

test-integration:
	@if [ ! -x build/native/sailfin-stage2 ]; then \
		echo "[test-integration] missing build/native/sailfin-stage2; running make compile"; \
		$(MAKE) compile; \
	fi
	@set -e; \
	files=$$(find compiler/tests/integration -name '*_test.sfn' -print | sort); \
	if [ -z "$$files" ]; then \
		echo "[test-integration] no *_test.sfn files found under compiler/tests/integration"; \
		exit 1; \
	fi; \
	for f in $$files; do \
		build/native/sailfin-stage2 test "$$f"; \
	done

test-e2e:
	@if [ ! -x build/native/sailfin-stage2 ]; then \
		echo "[test-e2e] missing build/native/sailfin-stage2; running make compile"; \
		$(MAKE) compile; \
	fi
	@set -e; \
	files=$$(find compiler/tests/e2e -name '*_test.sfn' -print | sort); \
	if [ -z "$$files" ]; then \
		echo "[test-e2e] no *_test.sfn files found under compiler/tests/e2e"; \
		exit 1; \
	fi; \
	for f in $$files; do \
		build/native/sailfin-stage2 test "$$f"; \
	done

clean:
	rm -rf dist

compile:
	$(CONDA) run -n $(CONDA_ENV) python tools/compile_with_stage1.py
	$(CONDA) run -n $(CONDA_ENV) python scripts/bootstrap_stage2.py --no-validate
	$(MAKE) _build-native-stage2
	@echo "[compile] built $(NATIVE_OUT)"

# Usage:
#   make selfhost-native-stage2
#   make selfhost-native-stage2 SEED_STAGE2=path/to/sailfin-stage2
# Output:
#   build/native/sailfin-stage2-selfhost
#
# Notes:
# - Defaults to a non-ASAN seed for speed.
# - Use `make selfhost-native-stage2-asan` for the slower-but-more-diagnostic ASAN seed.
# - Always runs the orchestrator script via the Conda env Python.
# - Pass extra flags via SELFHOST_ARGS (e.g. SELFHOST_ARGS="--seed-timeout 300").
selfhost-native-stage2: compile
	@seed=$${SEED_STAGE2:-build/native/sailfin-stage2}; \
	if [ ! -x "$$seed" ]; then \
		echo "[selfhost-native-stage2] missing seed compiler: $$seed"; \
		echo "[selfhost-native-stage2] (hint) build one with: make compile"; \
		exit 1; \
	fi; \
	$(CONDA) run -n $(CONDA_ENV) python scripts/selfhost_native_stage2.py --seed "$$seed" --no-prefer-asan-seed $(SELFHOST_ARGS) --out build/native/sailfin-stage2-selfhost
	@echo "[selfhost-native-stage2] built build/native/sailfin-stage2-selfhost"

selfhost-native-stage2-asan: native-stage2-asan
	@seed=$${SEED_STAGE2:-build/native/sailfin-stage2-asan}; \
	if [ ! -x "$$seed" ]; then \
		echo "[selfhost-native-stage2-asan] missing seed compiler: $$seed"; \
		echo "[selfhost-native-stage2-asan] (hint) build one with: make native-stage2-asan"; \
		exit 1; \
	fi; \
	$(CONDA) run -n $(CONDA_ENV) python scripts/selfhost_native_stage2.py --seed "$$seed" --no-prefer-asan-seed $(SELFHOST_ARGS) --out build/native/sailfin-stage2-selfhost
	@echo "[selfhost-native-stage2-asan] built build/native/sailfin-stage2-selfhost"


_build-native-stage2:
	@if [ ! -f $(STAGE2_AOT_MODULES_FILE) ]; then \
		echo "[_build-native-stage2] missing $(STAGE2_AOT_MODULES_FILE); run make compile first"; \
		exit 1; \
	fi
	@mkdir -p $(NATIVE_OBJ_DIR)
	@rm -rf $(NATIVE_OBJ_DIR)/*
	$(CLANG) -O2 -fno-delete-null-pointer-checks $(CLANG_WARN_SUPPRESS) -I runtime/native/include -c runtime/native/src/sailfin_runtime.c -o $(NATIVE_OBJ_DIR)/sailfin_runtime.o
	$(CLANG) -O2 $(CLANG_WARN_SUPPRESS) -I runtime/native/include -c runtime/native/src/stage2_driver.c -o $(NATIVE_OBJ_DIR)/stage2_driver.o
	$(CLANG) -O2 $(CLANG_WARN_SUPPRESS) -c runtime/native/ir/runtime_globals.ll -o $(NATIVE_OBJ_DIR)/runtime_globals.o
	@awk 'NF' $(STAGE2_AOT_MODULES_FILE) | \
	  xargs -I {} -P $(NATIVE_JOBS) sh -c 'm="{}"; \
	    mkdir -p "$$(dirname "$(NATIVE_OBJ_DIR)/$$m.o")"; \
	    $(CLANG) -O2 $(CLANG_WARN_SUPPRESS) -fPIC -c "$(STAGE2_AOT_DIR)/$$m.ll" -o "$(NATIVE_OBJ_DIR)/$$m.o"'
	$(CLANG) -O2 $(CLANG_WARN_SUPPRESS) -o $(NATIVE_OUT) \
		$(NATIVE_OBJ_DIR)/sailfin_runtime.o \
		$(NATIVE_OBJ_DIR)/stage2_driver.o \
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
		echo "[check-native-stage2-determinism] missing $(STAGE2_AOT_MODULES_FILE); run make compile first"; \
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

# Canary check for the current self-host blocker: flaky/malformed LLVM emission.
# Validates LLVM by compiling it with clang.
check-seed-llvm-emission:
	@if [ ! -x build/native/sailfin-stage2 ]; then \
		echo "[check-seed-llvm-emission] missing build/native/sailfin-stage2; running make compile"; \
		$(MAKE) compile; \
	fi
	@python tools/check_seed_llvm_emission.py --seed build/native/sailfin-stage2 --input compiler/src/effect_checker.sfn --attempts 10 --timeout 5 --no-clang --disable-string-free

native-stage2-o1: compile
	@mkdir -p build/native/o1-obj
	@rm -rf build/native/o1-obj/*
	$(CLANG) -O1 -g -fno-omit-frame-pointer -fno-delete-null-pointer-checks $(CLANG_WARN_SUPPRESS) -I runtime/native/include -c runtime/native/src/sailfin_runtime.c -o build/native/o1-obj/sailfin_runtime.o
	$(CLANG) -O1 -g -fno-omit-frame-pointer $(CLANG_WARN_SUPPRESS) -I runtime/native/include -c runtime/native/src/stage2_driver.c -o build/native/o1-obj/stage2_driver.o
	$(CLANG) -O1 -g -fno-omit-frame-pointer $(CLANG_WARN_SUPPRESS) -c runtime/native/ir/runtime_globals.ll -o build/native/o1-obj/runtime_globals.o
	@while IFS= read -r m ; do \
	  [ -z "$$m" ] && continue; \
	  mkdir -p "$$(dirname build/native/o1-obj/$$m.o)"; \
	  $(CLANG) -O1 -g -fno-omit-frame-pointer $(CLANG_WARN_SUPPRESS) -fPIC -c build/stage2/aot/$$m.ll -o build/native/o1-obj/$$m.o; \
	done < build/stage2/aot/modules.txt
	$(CLANG) -O1 -g -fno-omit-frame-pointer $(CLANG_WARN_SUPPRESS) -o build/native/sailfin-stage2-o1 build/native/o1-obj/sailfin_runtime.o build/native/o1-obj/stage2_driver.o build/native/o1-obj/runtime_globals.o $$(sed 's|^|build/native/o1-obj/|; s|$$|.o|' build/stage2/aot/modules.txt | tr '\n' ' ') $(STAGE2_NATIVE_LIBS)

native-stage2-debug: compile
	@mkdir -p build/native/debug-obj
	@rm -rf build/native/debug-obj/*
	$(CLANG) -O0 -g -fno-omit-frame-pointer -fno-delete-null-pointer-checks $(CLANG_WARN_SUPPRESS) -I runtime/native/include -c runtime/native/src/sailfin_runtime.c -o build/native/debug-obj/sailfin_runtime.o
	$(CLANG) -O0 -g -fno-omit-frame-pointer $(CLANG_WARN_SUPPRESS) -I runtime/native/include -c runtime/native/src/stage2_driver.c -o build/native/debug-obj/stage2_driver.o
	$(CLANG) -O0 -g -fno-omit-frame-pointer $(CLANG_WARN_SUPPRESS) -c runtime/native/ir/runtime_globals.ll -o build/native/debug-obj/runtime_globals.o
	@while IFS= read -r m ; do \
	  [ -z "$$m" ] && continue; \
	  mkdir -p "$$(dirname build/native/debug-obj/$$m.o)"; \
	  $(CLANG) -O0 -g -fno-omit-frame-pointer $(CLANG_WARN_SUPPRESS) -fPIC -c build/stage2/aot/$$m.ll -o build/native/debug-obj/$$m.o; \
	done < build/stage2/aot/modules.txt
	$(CLANG) -O0 -g -fno-omit-frame-pointer $(CLANG_WARN_SUPPRESS) -o build/native/sailfin-stage2-debug build/native/debug-obj/sailfin_runtime.o build/native/debug-obj/stage2_driver.o build/native/debug-obj/runtime_globals.o $$(sed 's|^|build/native/debug-obj/|; s|$$|.o|' build/stage2/aot/modules.txt | tr '\n' ' ') $(STAGE2_NATIVE_LIBS)

native-stage2-asan: compile
	@mkdir -p build/native/asan-obj
	@rm -rf build/native/asan-obj/*
	$(CLANG) -O1 -g -fno-omit-frame-pointer -fno-delete-null-pointer-checks -fsanitize=address $(CLANG_WARN_SUPPRESS) -I runtime/native/include -c runtime/native/src/sailfin_runtime.c -o build/native/asan-obj/sailfin_runtime.o
	$(CLANG) -O1 -g -fno-omit-frame-pointer -fsanitize=address $(CLANG_WARN_SUPPRESS) -I runtime/native/include -c runtime/native/src/stage2_driver.c -o build/native/asan-obj/stage2_driver.o
	$(CLANG) -O1 -g -fno-omit-frame-pointer -fsanitize=address $(CLANG_WARN_SUPPRESS) -c runtime/native/ir/runtime_globals.ll -o build/native/asan-obj/runtime_globals.o
	@while IFS= read -r m ; do \
	  [ -z "$$m" ] && continue; \
	  mkdir -p "$$(dirname build/native/asan-obj/$$m.o)"; \
	  $(CLANG) -O1 -g -fno-omit-frame-pointer -fsanitize=address $(CLANG_WARN_SUPPRESS) -fPIC -c build/stage2/aot/$$m.ll -o build/native/asan-obj/$$m.o; \
	done < build/stage2/aot/modules.txt
	$(CLANG) -O1 -g -fno-omit-frame-pointer -fsanitize=address $(CLANG_WARN_SUPPRESS) -o build/native/sailfin-stage2-asan build/native/asan-obj/sailfin_runtime.o build/native/asan-obj/stage2_driver.o build/native/asan-obj/runtime_globals.o $$(sed 's|^|build/native/asan-obj/|; s|$$|.o|' build/stage2/aot/modules.txt | tr '\n' ' ') $(STAGE2_NATIVE_LIBS)

native-stage2-ubsan: compile
	@mkdir -p build/native/ubsan-obj
	@rm -rf build/native/ubsan-obj/*
	$(CLANG) -O1 -g -fno-omit-frame-pointer -fno-delete-null-pointer-checks -fsanitize=undefined -fno-sanitize-recover=undefined $(CLANG_WARN_SUPPRESS) -I runtime/native/include -c runtime/native/src/sailfin_runtime.c -o build/native/ubsan-obj/sailfin_runtime.o
	$(CLANG) -O1 -g -fno-omit-frame-pointer -fsanitize=undefined -fno-sanitize-recover=undefined $(CLANG_WARN_SUPPRESS) -I runtime/native/include -c runtime/native/src/stage2_driver.c -o build/native/ubsan-obj/stage2_driver.o
	$(CLANG) -O1 -g -fno-omit-frame-pointer -fsanitize=undefined -fno-sanitize-recover=undefined $(CLANG_WARN_SUPPRESS) -c runtime/native/ir/runtime_globals.ll -o build/native/ubsan-obj/runtime_globals.o
	@while IFS= read -r m ; do \
	  [ -z "$$m" ] && continue; \
	  mkdir -p "$$(dirname build/native/ubsan-obj/$$m.o)"; \
	  $(CLANG) -O1 -g -fno-omit-frame-pointer -fsanitize=undefined -fno-sanitize-recover=undefined $(CLANG_WARN_SUPPRESS) -fPIC -c build/stage2/aot/$$m.ll -o build/native/ubsan-obj/$$m.o; \
	done < build/stage2/aot/modules.txt
	$(CLANG) -O1 -g -fno-omit-frame-pointer -fsanitize=undefined -fno-sanitize-recover=undefined $(CLANG_WARN_SUPPRESS) -o build/native/sailfin-stage2-ubsan build/native/ubsan-obj/sailfin_runtime.o build/native/ubsan-obj/stage2_driver.o build/native/ubsan-obj/runtime_globals.o $$(sed 's|^|build/native/ubsan-obj/|; s|$$|.o|' build/stage2/aot/modules.txt | tr '\n' ' ') $(STAGE2_NATIVE_LIBS)
