# Sailfin project automation

.PHONY: help bootstrap-install bootstrap-test bootstrap-test-unit bootstrap-test-integration test clean

POETRY ?= poetry
POETRY_DIR_FLAG ?= --directory bootstrap
POETRY_ENV ?= POETRY_VIRTUALENVS_IN_PROJECT=1
PYTEST_ARGS ?=

help:
	@echo "Common Sailfin tasks"
	@echo "  make bootstrap-install      # Install bootstrap/toolchain dependencies via Poetry"
	@echo "  make bootstrap-test         # Run the full pytest suite (pass PYTEST_ARGS=... to filter)"
	@echo "  make bootstrap-test-unit    # Run unit tests only"
	@echo "  make bootstrap-test-integration # Run integration tests only"
	@echo "  make test                   # Alias for bootstrap-test"

bootstrap-install:
	$(POETRY_ENV) $(POETRY) $(POETRY_DIR_FLAG) install

bootstrap-test:
	$(POETRY_ENV) $(POETRY) $(POETRY_DIR_FLAG) run pytest $(PYTEST_ARGS)

bootstrap-test-unit:
	$(MAKE) bootstrap-test PYTEST_ARGS=-m\ unit

bootstrap-test-integration:
	$(MAKE) bootstrap-test PYTEST_ARGS=-m\ integration

test: bootstrap-test

clean:
	rm -rf bootstrap/.venv bootstrap/.pytest_cache bootstrap/.coverage bootstrap/htmlcov
