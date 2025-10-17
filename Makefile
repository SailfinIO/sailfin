# Sailfin project automation

.PHONY: help install test test-unit test-integration test-stage2 warm-stage1-cache compile clean clean-stage1 package

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

clean-stage1:
	rm -rf compiler/build

compile:
	$(CONDA) run -n $(CONDA_ENV) python tools/compile_with_stage1.py

package:
	$(CONDA) run -n $(CONDA_ENV) python tools/package_stage1.py
