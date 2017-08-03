IMAGE_NAME:=bufferapp/budapest

.PHONY: all
all: run

.PHONY: run
run:
	docker run -it -v $(PWD):/work -w /work $(IMAGE_NAME) protoc --plugin=protoc-gen-custom=custom_gen.py --custom_out=./build buda/*.proto
	cat build/buda.proto


.PHONY: build
build:
	docker build . -t $(IMAGE_NAME)
