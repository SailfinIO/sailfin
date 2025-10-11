# Sailfin project automation

.PHONY: help install test compile clean

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
	@echo "  make compile      # Emit Python modules from compiler/src via stage0/compile_stage1.py"
	@echo "  make clean        # Remove generated artifacts"

install:
	$(CONDA) env update --file $(CONDA_ENV_FILE) --name $(CONDA_ENV)

test:
	$(CONDA) run -n $(CONDA_ENV) pytest $(PYTEST_ARGS)

clean:
	rm -rf compiler/build

compile: clean
	$(CONDA) run -n $(CONDA_ENV) python stage0/compile_stage1.py
