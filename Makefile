# Sailfin project automation

# Silence noisy clang warning when compiling embedded-IR modules that carry a
# different target triple than the host.
CLANG_WARN_SUPPRESS ?= -Wno-override-module

.PHONY: help install test test-unit test-integration test-stage2 warm-stage1-cache compile clean clean-stage1 package bootstrap-stage2 native-stage2 native-stage2-debug native-stage2-asan stage2-native-roundtrip stage2-native-fixed-point stage2-native-emit-llvm stage2-native-sanity stage2-native-run-examples

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
	@echo "  make warm-stage1-cache # Pre-populate the pytest stage1 build cache"
	@echo "  make compile      # Emit Python modules from compiler/src via the stage1 pipeline"
	@echo "  make clean        # Remove packaged artifacts (dist/)"
	@echo "  make clean-stage1 # Remove compiler/build (requires installed stage1 to rebuild)"
	@echo "  make bootstrap-stage2 # Bootstrap Stage2 self-hosted compiler (compile to LLVM)"
	@echo "  make native-stage2 # Build a native Stage2 driver from rewritten LLVM IR (WIP)"
	@echo "  make native-stage2-debug # Same, but with -O0/-g for lldb"
	@echo "  make native-stage2-asan # Same, but with AddressSanitizer for memory bugs"
	@echo "  make stage2-native-sanity # Bootstrap + build native stage2 + compile hello-world"
	@echo "  make stage2-native-roundtrip # Bootstrap + build native stage2 + run it on compiler/src/main.sfn"
	@echo "  make stage2-native-fixed-point # Ensure Stage3→Stage4 is a stable fixed-point"
	@echo "  make stage2-native-emit-llvm # Emit LLVM IR for compiler/src/main.sfn via stage2-native"

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

warm-stage1-cache:
	$(CONDA) run -n $(CONDA_ENV) python tools/compile_with_stage1.py --warm-cache

clean:
	rm -rf dist

compile:
	$(CONDA) run -n $(CONDA_ENV) python tools/compile_with_stage1.py

package:
	$(CONDA) run -n $(CONDA_ENV) python tools/package_stage1.py


# Stage2 bootstrap requires the latest stage1-generated Python modules.
bootstrap-stage2: compile
	$(CONDA) run -n $(CONDA_ENV) python scripts/bootstrap_stage2.py --no-validate

native-stage2: bootstrap-stage2
	@mkdir -p build/stage2/aot build/native/obj
	@rm -f build/native/obj/*.o
	$(CONDA) run -n $(CONDA_ENV) python tools/prepare_stage2_aot_text.py --input build/stage2 --output build/stage2/aot
	clang -O2 $(CLANG_WARN_SUPPRESS) -I runtime/native/include -c runtime/native/src/sailfin_runtime.c -o build/native/obj/sailfin_runtime.o
	clang -O2 $(CLANG_WARN_SUPPRESS) -c runtime/native/src/stage2_driver.c -o build/native/obj/stage2_driver.o
	clang -O2 $(CLANG_WARN_SUPPRESS) -c runtime/native/ir/runtime_globals.ll -o build/native/obj/runtime_globals.o
	@while IFS= read -r m ; do \
	  [ -z "$$m" ] && continue; \
	  clang -O2 $(CLANG_WARN_SUPPRESS) -fPIC -c build/stage2/aot/$$m.ll -o build/native/obj/$$m.o; \
	done < build/stage2/aot/modules.txt
	clang -O2 $(CLANG_WARN_SUPPRESS) -o build/native/sailfin-stage2 build/native/obj/sailfin_runtime.o build/native/obj/stage2_driver.o build/native/obj/runtime_globals.o $$(sed 's|^|build/native/obj/|; s|$$|.o|' build/stage2/aot/modules.txt | tr '\n' ' ')

native-stage2-debug: bootstrap-stage2
	@mkdir -p build/stage2/aot build/native/debug-obj
	@rm -f build/native/debug-obj/*.o
	$(CONDA) run -n $(CONDA_ENV) python tools/prepare_stage2_aot_text.py --input build/stage2 --output build/stage2/aot
	clang -O0 -g -fno-omit-frame-pointer $(CLANG_WARN_SUPPRESS) -I runtime/native/include -c runtime/native/src/sailfin_runtime.c -o build/native/debug-obj/sailfin_runtime.o
	clang -O0 -g -fno-omit-frame-pointer $(CLANG_WARN_SUPPRESS) -c runtime/native/src/stage2_driver.c -o build/native/debug-obj/stage2_driver.o
	clang -O0 -g -fno-omit-frame-pointer $(CLANG_WARN_SUPPRESS) -c runtime/native/ir/runtime_globals.ll -o build/native/debug-obj/runtime_globals.o
	@while IFS= read -r m ; do \
	  [ -z "$$m" ] && continue; \
	  clang -O0 -g -fno-omit-frame-pointer $(CLANG_WARN_SUPPRESS) -fPIC -c build/stage2/aot/$$m.ll -o build/native/debug-obj/$$m.o; \
	done < build/stage2/aot/modules.txt
	clang -O0 -g -fno-omit-frame-pointer $(CLANG_WARN_SUPPRESS) -o build/native/sailfin-stage2-debug build/native/debug-obj/sailfin_runtime.o build/native/debug-obj/stage2_driver.o build/native/debug-obj/runtime_globals.o $$(sed 's|^|build/native/debug-obj/|; s|$$|.o|' build/stage2/aot/modules.txt | tr '\n' ' ')

native-stage2-asan: bootstrap-stage2
	@mkdir -p build/stage2/aot build/native/asan-obj
	@rm -f build/native/asan-obj/*.o
	$(CONDA) run -n $(CONDA_ENV) python tools/prepare_stage2_aot_text.py --input build/stage2 --output build/stage2/aot
	clang -O1 -g -fno-omit-frame-pointer -fsanitize=address $(CLANG_WARN_SUPPRESS) -I runtime/native/include -c runtime/native/src/sailfin_runtime.c -o build/native/asan-obj/sailfin_runtime.o
	clang -O1 -g -fno-omit-frame-pointer -fsanitize=address $(CLANG_WARN_SUPPRESS) -c runtime/native/src/stage2_driver.c -o build/native/asan-obj/stage2_driver.o
	clang -O1 -g -fno-omit-frame-pointer -fsanitize=address $(CLANG_WARN_SUPPRESS) -c runtime/native/ir/runtime_globals.ll -o build/native/asan-obj/runtime_globals.o
	@while IFS= read -r m ; do \
	  [ -z "$$m" ] && continue; \
	  clang -O1 -g -fno-omit-frame-pointer -fsanitize=address $(CLANG_WARN_SUPPRESS) -fPIC -c build/stage2/aot/$$m.ll -o build/native/asan-obj/$$m.o; \
	done < build/stage2/aot/modules.txt
	clang -O1 -g -fno-omit-frame-pointer -fsanitize=address $(CLANG_WARN_SUPPRESS) -o build/native/sailfin-stage2-asan build/native/asan-obj/sailfin_runtime.o build/native/asan-obj/stage2_driver.o build/native/asan-obj/runtime_globals.o $$(sed 's|^|build/native/asan-obj/|; s|$$|.o|' build/stage2/aot/modules.txt | tr '\n' ' ')

stage2-native-sanity: native-stage2
	build/native/sailfin-stage2 --emit sailfin examples/basics/hello-world.sfn > /dev/null
	@echo "[stage2-native] sanity ok"

stage2-native-roundtrip: native-stage2
	@mkdir -p build/stage3
	build/native/sailfin-stage2 --emit sailfin compiler/src/main.sfn > build/stage3/compiler-from-stage2.sfn
	@echo "[stage2-native] wrote build/stage3/compiler-from-stage2.sfn"

stage2-native-fixed-point: stage2-native-roundtrip
	@mkdir -p build/stage4
	build/native/sailfin-stage2 --emit sailfin build/stage3/compiler-from-stage2.sfn > build/stage4/compiler-from-stage3.sfn
	@diff -q build/stage3/compiler-from-stage2.sfn build/stage4/compiler-from-stage3.sfn > /dev/null
	@echo "[stage2-native] fixed-point ok (Stage3 == Stage4)"

stage2-native-emit-llvm: native-stage2
	@mkdir -p build/stage3
	build/native/sailfin-stage2 --emit llvm compiler/src/main.sfn > build/stage3/main-from-stage2.ll
	@echo "[stage2-native] wrote build/stage3/main-from-stage2.ll"

stage2-native-run-examples: native-stage2
	@mkdir -p scratch/native-examples build/native/examples
	@for ex in \
		examples/basics/hello-world.sfn \
		examples/basics/conditionals.sfn \
		examples/basics/native-if.sfn ; do \
		name=$$(basename $$ex .sfn); \
		out_ll=scratch/native-examples/$$name.ll; \
		out_bin=build/native/examples/$$name; \
		echo "[stage2-native] llvm $$ex -> $$out_bin"; \
		build/native/sailfin-stage2 --emit llvm $$ex > $$out_ll; \
		clang -O2 $(CLANG_WARN_SUPPRESS) -I runtime/native/include runtime/native/src/sailfin_runtime.c runtime/native/ir/runtime_globals.ll $$out_ll -o $$out_bin; \
		$$out_bin; \
	done
