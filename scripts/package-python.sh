#!/bin/env bash

set -eo pipefail

# Grab the version number
VERSION=$(cat VERSION)

# Initialize general variables
PYTHON_DIR="packages/python"
PROTO_DIR="buda"

# List all proto files
ENTITIES="$PROTO_DIR/entities/*.proto"
SERVICES="$PROTO_DIR/services/*.proto"

# Compile entities
docker run --rm -v $PWD:$PWD -u 1000 -w $PWD \
    znly/protoc \
    --python_out=$PYTHON_DIR \
    -I. $ENTITIES

# Compile services
docker run --rm -v $PWD:$PWD -u 1000 -w $PWD \
    bufferapp/grpc-docker-python:latest \
	python -m grpc_tools.protoc \
        --proto_path . \
		--python_out $PYTHON_DIR \
		--grpc_python_out $PYTHON_DIR \
		$SERVICES

# Replace version
sed -i "s/.*version.*/    version='$VERSION',/" $PYTHON_DIR/setup.py

# Compress the Python package
tar -zcvf buda-python-$VERSION.tar.gz -C packages/python/ buda setup.py
