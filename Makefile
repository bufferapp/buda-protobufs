PYTHON_DIR:=gen/python
BASE_DIR:=buda

entities = $(sort $(wildcard $(BASE_DIR)/entities/*.proto))
services = $(sort $(wildcard $(BASE_DIR)/services/*.proto))

python:
	mkdir -p $(PYTHON_DIR)
	docker run --rm -v $(PWD):$(PWD) -u 1000 -w $(PWD) znly/protoc --python_out=$(PYTHON_DIR) -I. $(entities)

	docker run --rm -v $(PWD):$(PWD) -u 1000 -w $(PWD) davidgasquez/python-grpc-tools:latest \
		python -m grpc_tools.protoc --proto_path . \
								--python_out $(PYTHON_DIR) \
								--grpc_python_out $(PYTHON_DIR) \
								$(services)

	touch $(PYTHON_DIR)/$(BASE_DIR)/__init__.py \
		  $(PYTHON_DIR)/$(BASE_DIR)/entities/__init__.py \
		  $(PYTHON_DIR)/$(BASE_DIR)/services/__init__.py

clean:
	@rm -rf $(PYTHON_DIR)
