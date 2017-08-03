.DEFAULT_GOAL := help

.PHONY: help
help:
	@echo -e "Usage: \tmake [TARGET]\n"
	@echo -e "Targets:"
	@echo -e "  package-python            Creates a tar file with the required Python code"
	@echo -e "  clean-python              Remove Python autogenerated code"
	@echo -e "  package-js                Creates the Node.js package in the packages/node directory"

.PHONY: package-python
package-python: clean-python
	./scripts/package-python.sh

.PHONY: clean-python
clean-python:
	@rm -rf packages/python/buda/**/*pb2*.py

.PHONY: package-node
package-node:
	./scripts/package-node.sh
