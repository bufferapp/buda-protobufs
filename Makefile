.DEFAULT_GOAL := help

.PHONY: help
help:
	@echo -e "Usage: \tmake [TARGET]\n"
	@echo -e "Targets:"
	@echo -e "  package-python            Creates a tar file with the required Python code"
	@echo -e "  publish-python            Publishes the Python package to PyPI"
	@echo -e "  clean-python              Remove Python autogenerated code"
	@echo -e "  setup-node                Installs Node.js package dependencies"
	@echo -e "  package-node              Creates the Node.js package in the packages/node directory"
	@echo -e "  test-node                 Tests the Node.js package"
	@echo -e "  publish-node              Publishes the Nodejs package to npm"
	@echo -e "  packages                  Create Python and Node.js packages"

.PHONY: package-python
package-python: clean-python
	@./scripts/package-python.sh

.PHONY: publish-python
publish-python:
	@./scripts/publish-python.sh

.PHONY: clean-python
clean-python:
	@rm -rf packages/python/buda/**/*pb2*.py

.PHONY: setup-node
setup-node:
	@./scripts/setup-node.sh

.PHONY: package-node
package-node:
	@./scripts/package-node.sh

.PHONY: test-node
test-node:
	@./scripts/test-node.sh

.PHONY: publish-node
publish-node:
	@./scripts/publish-node.sh

.PHONY: packages
packages: package-node package-python
