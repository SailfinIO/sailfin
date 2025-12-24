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

.PHONY: help install test test-unit test-integration test-stage2 compile clean package native-stage2-debug native-stage2-asan stage2-native-roundtrip stage2-native-fixed-point stage2-native-sanity

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
	@echo "  make test         # Run the full pytest suite (pass PYTEST_ARGS=... to filter)"
	@echo "  make test-unit    # Run fast Sailfin-focused unit coverage"
	@echo "  make test-integration # Run integration tests (stage1 artifact, self-host checks, etc.)"
	@echo "  make test-stage2  # Run LLVM/native backend coverage"
	@echo "  make compile      # Build the native sailfin-stage2 compiler (full pipeline)"
	@echo "  make clean        # Remove packaged artifacts (dist/)"
	@echo "  make clean-stage1 # Remove compiler/build (requires stage1 to rebuild)"
	@echo "  make native-stage2-debug # Build native stage2 with -O0/-g for lldb"
	@echo "  make native-stage2-asan # Build native stage2 with AddressSanitizer"
	@echo "  make stage2-native-sanity # Build + compile hello-world as smoke test"
	@echo "  make stage2-native-roundtrip # Build + run on compiler/src/main.sfn"
	@echo "  make stage2-native-fixed-point # Ensure Stage3→Stage4 is a stable fixed-point"

install:
	$(CONDA) env update --file $(CONDA_ENV_FILE) --name $(CONDA_ENV)

test:
	$(CONDA) run -n $(CONDA_ENV) pytest $(PYTEST_ARGS)

test-unit:
	$(CONDA) run -n $(CONDA_ENV) pytest -m "unit and not stage2" $(PYTEST_ARGS)

test-integration:
	$(CONDA) run -n $(CONDA_ENV) pytest -m integration $(PYTEST_ARGS)

test-stage2:
	$(CONDA) run -n $(CONDA_ENV) pytest -m stage2 $(PYTEST_ARGS)

clean:
	rm -rf dist

# Full compilation pipeline: Stage1 (sfn→Python) → Stage2 bootstrap (→LLVM IR) → native binary
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
	@mkdir -p build/stage2/aot build/native/debug-obj
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
	@mkdir -p build/stage2/aot build/native/asan-obj
	@rm -f build/native/asan-obj/*.o
	$(CLANG) -O1 -g -fno-omit-frame-pointer -fsanitize=address $(CLANG_WARN_SUPPRESS) -I runtime/native/include -c runtime/native/src/sailfin_runtime.c -o build/native/asan-obj/sailfin_runtime.o
	$(CLANG) -O1 -g -fno-omit-frame-pointer -fsanitize=address $(CLANG_WARN_SUPPRESS) -I runtime/native/include -c runtime/native/src/stage2_driver.c -o build/native/asan-obj/stage2_driver.o
	$(CLANG) -O1 -g -fno-omit-frame-pointer -fsanitize=address $(CLANG_WARN_SUPPRESS) -c runtime/native/ir/runtime_globals.ll -o build/native/asan-obj/runtime_globals.o
	@while IFS= read -r m ; do \
	  [ -z "$$m" ] && continue; \
	  $(CLANG) -O1 -g -fno-omit-frame-pointer -fsanitize=address $(CLANG_WARN_SUPPRESS) -fPIC -c build/stage2/aot/$$m.ll -o build/native/asan-obj/$$m.o; \
	done < build/stage2/aot/modules.txt
	$(CLANG) -O1 -g -fno-omit-frame-pointer -fsanitize=address $(CLANG_WARN_SUPPRESS) -o build/native/sailfin-stage2-asan build/native/asan-obj/sailfin_runtime.o build/native/asan-obj/stage2_driver.o build/native/asan-obj/runtime_globals.o $$(sed 's|^|build/native/asan-obj/|; s|$$|.o|' build/stage2/aot/modules.txt | tr '\n' ' ') $(STAGE2_NATIVE_LIBS)

stage2-native-sanity: compile
	build/native/sailfin-stage2 --emit sailfin examples/basics/hello-world.sfn > /dev/null
	@echo "[stage2-native] sanity ok"

stage2-native-roundtrip: compile
	@mkdir -p build/stage3
	build/native/sailfin-stage2 --emit sailfin compiler/src/main.sfn > build/stage3/compiler-from-stage2.sfn
	@echo "[stage2-native] wrote build/stage3/compiler-from-stage2.sfn"

stage2-native-fixed-point: stage2-native-roundtrip
	@mkdir -p build/stage4
	build/native/sailfin-stage2 --emit sailfin build/stage3/compiler-from-stage2.sfn > build/stage4/compiler-from-stage3.sfn
	@diff -q build/stage3/compiler-from-stage2.sfn build/stage4/compiler-from-stage3.sfn > /dev/null
	@echo "[stage2-native] fixed-point ok (Stage3 == Stage4)"