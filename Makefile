# Sailfin project automation

# Silence noisy clang warning when compiling embedded-IR modules that carry a
# different target triple than the host.
CLANG_WARN_SUPPRESS ?= -Wno-override-module

CLANG ?= clang

UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
STAGE2_NATIVE_LIBS ?=
else
STAGE2_NATIVE_LIBS ?= -lm
endif

.PHONY: help install test test-unit test-integration compile clean package native-stage2-debug native-stage2-asan

ifeq ($(origin CONDA_EXE), undefined)
CONDA_EXE := $(shell command -v conda 2>/dev/null)
endif
ifeq ($(strip $(CONDA_EXE)),)
$(error "conda" executable not found. Export CONDA_EXE or install Conda.)
endif
CONDA ?= $(CONDA_EXE)
CONDA_ENV ?= sailfin
CONDA_ENV_FILE ?= environment.yml
PYTEST_ARGS ?=

help:
	@echo "Common Sailfin tasks"
	@echo "  make install      # Create or update the Conda env used for the compiler"
	@echo "  make test         # Run Sailfin-native unit + integration tests"
	@echo "  make test-unit    # Run Stage2 self-hosted Sailfin unit tests"
	@echo "  make test-integration # Run Sailfin-native integration tests"
	@echo "  make compile      # Build the native sailfin-stage2 compiler (full pipeline)"
	@echo "  make clean        # Remove packaged artifacts (dist/)"
	@echo "  make native-stage2-debug # Build native stage2 with -O0/-g for lldb"
	@echo "  make native-stage2-asan # Build native stage2 with AddressSanitizer"

install:
	$(CONDA) env update --file $(CONDA_ENV_FILE) --name $(CONDA_ENV)

test: test-unit test-integration

test-unit:
	@if [ ! -x build/native/sailfin-stage2 ]; then \
		echo "[test-unit] missing build/native/sailfin-stage2; running make compile"; \
		$(MAKE) compile; \
	fi
	build/native/sailfin-stage2 test compiler/tests

test-integration:
	@if [ ! -x build/native/sailfin-stage2 ]; then \
		echo "[test-integration] missing build/native/sailfin-stage2; running make compile"; \
		$(MAKE) compile; \
	fi
	build/native/sailfin-stage2 test compiler/integration_tests

clean:
	rm -rf dist

compile:
	$(CONDA) run -n $(CONDA_ENV) python tools/compile_with_stage1.py
	$(CONDA) run -n $(CONDA_ENV) python scripts/bootstrap_stage2.py --no-validate
	@mkdir -p build/native/obj
	@rm -f build/native/obj/*.o
	$(CLANG) -O2 $(CLANG_WARN_SUPPRESS) -I runtime/native/include -c runtime/native/src/sailfin_runtime.c -o build/native/obj/sailfin_runtime.o
	$(CLANG) -O2 $(CLANG_WARN_SUPPRESS) -I runtime/native/include -c runtime/native/src/stage2_driver.c -o build/native/obj/stage2_driver.o
	$(CLANG) -O2 $(CLANG_WARN_SUPPRESS) -c runtime/native/ir/runtime_globals.ll -o build/native/obj/runtime_globals.o
	@while IFS= read -r m ; do \
	  [ -z "$$m" ] && continue; \
	  $(CLANG) -O2 $(CLANG_WARN_SUPPRESS) -fPIC -c build/stage2/aot/$$m.ll -o build/native/obj/$$m.o; \
	done < build/stage2/aot/modules.txt
	$(CLANG) -O2 $(CLANG_WARN_SUPPRESS) -o build/native/sailfin-stage2 build/native/obj/sailfin_runtime.o build/native/obj/stage2_driver.o build/native/obj/runtime_globals.o $$(sed 's|^|build/native/obj/|; s|$$|.o|' build/stage2/aot/modules.txt | tr '\n' ' ') $(STAGE2_NATIVE_LIBS)
	@echo "[compile] built build/native/sailfin-stage2"

native-stage2-debug: compile
	@mkdir -p build/native/debug-obj
	@rm -f build/native/debug-obj/*.o
	$(CLANG) -O0 -g -fno-omit-frame-pointer $(CLANG_WARN_SUPPRESS) -I runtime/native/include -c runtime/native/src/sailfin_runtime.c -o build/native/debug-obj/sailfin_runtime.o
	$(CLANG) -O0 -g -fno-omit-frame-pointer $(CLANG_WARN_SUPPRESS) -I runtime/native/include -c runtime/native/src/stage2_driver.c -o build/native/debug-obj/stage2_driver.o
	$(CLANG) -O0 -g -fno-omit-frame-pointer $(CLANG_WARN_SUPPRESS) -c runtime/native/ir/runtime_globals.ll -o build/native/debug-obj/runtime_globals.o
	@while IFS= read -r m ; do \
	  [ -z "$$m" ] && continue; \
	  $(CLANG) -O0 -g -fno-omit-frame-pointer $(CLANG_WARN_SUPPRESS) -fPIC -c build/stage2/aot/$$m.ll -o build/native/debug-obj/$$m.o; \
	done < build/stage2/aot/modules.txt
	$(CLANG) -O0 -g -fno-omit-frame-pointer $(CLANG_WARN_SUPPRESS) -o build/native/sailfin-stage2-debug build/native/debug-obj/sailfin_runtime.o build/native/debug-obj/stage2_driver.o build/native/debug-obj/runtime_globals.o $$(sed 's|^|build/native/debug-obj/|; s|$$|.o|' build/stage2/aot/modules.txt | tr '\n' ' ') $(STAGE2_NATIVE_LIBS)

native-stage2-asan: compile
	@mkdir -p build/native/asan-obj
	@rm -f build/native/asan-obj/*.o
	$(CLANG) -O1 -g -fno-omit-frame-pointer -fsanitize=address $(CLANG_WARN_SUPPRESS) -I runtime/native/include -c runtime/native/src/sailfin_runtime.c -o build/native/asan-obj/sailfin_runtime.o
	$(CLANG) -O1 -g -fno-omit-frame-pointer -fsanitize=address $(CLANG_WARN_SUPPRESS) -I runtime/native/include -c runtime/native/src/stage2_driver.c -o build/native/asan-obj/stage2_driver.o
	$(CLANG) -O1 -g -fno-omit-frame-pointer -fsanitize=address $(CLANG_WARN_SUPPRESS) -c runtime/native/ir/runtime_globals.ll -o build/native/asan-obj/runtime_globals.o
	@while IFS= read -r m ; do \
	  [ -z "$$m" ] && continue; \
	  $(CLANG) -O1 -g -fno-omit-frame-pointer -fsanitize=address $(CLANG_WARN_SUPPRESS) -fPIC -c build/stage2/aot/$$m.ll -o build/native/asan-obj/$$m.o; \
	done < build/stage2/aot/modules.txt
	$(CLANG) -O1 -g -fno-omit-frame-pointer -fsanitize=address $(CLANG_WARN_SUPPRESS) -o build/native/sailfin-stage2-asan build/native/asan-obj/sailfin_runtime.o build/native/asan-obj/stage2_driver.o build/native/asan-obj/runtime_globals.o $$(sed 's|^|build/native/asan-obj/|; s|$$|.o|' build/stage2/aot/modules.txt | tr '\n' ' ') $(STAGE2_NATIVE_LIBS)
