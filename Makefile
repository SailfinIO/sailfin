# Sailfin project automation

.PHONY: help bootstrap-install bootstrap-test bootstrap-test-unit bootstrap-test-integration test clean

ifeq ($(origin CONDA_EXE), undefined)
CONDA_EXE := $(shell command -v conda 2>/dev/null)
endif
ifeq ($(strip $(CONDA_EXE)),)
$(error "conda" executable not found. Export CONDA_EXE or install Conda.)
endif
CONDA ?= $(CONDA_EXE)
CONDA_ENV ?= sailfin-bootstrap
CONDA_ENV_FILE ?= bootstrap/environment.yml
PYTEST_ARGS ?=

help:
	@echo "Common Sailfin tasks"
	@echo "  make bootstrap-install      # Create or update the Conda env used for the bootstrap compiler"
	@echo "  make bootstrap-test         # Run the full pytest suite (pass PYTEST_ARGS=... to filter)"
	@echo "  make bootstrap-compile      # Emit Python modules from compiler/src using the bootstrap compiler"
	@echo "  make compiler-clean         # Remove generated files from the bootstrap compiler"	
	@echo "  make test                   # Alias for bootstrap-test"

bootstrap-install:
	$(CONDA) env update --file $(CONDA_ENV_FILE) --name $(CONDA_ENV)

bootstrap-test:
	$(CONDA) run -n $(CONDA_ENV) pytest $(PYTEST_ARGS)

bootstrap-compile:
	$(CONDA) run -n $(CONDA_ENV) python -m bootstrap.compile_self_host

compiler-clean:
	rm -rf compiler/build

test: bootstrap-test

clean:
	rm -rf bootstrap/.venv bootstrap/.pytest_cache bootstrap/.coverage bootstrap/htmlcov
