#!/usr/bin/env sh

set -eo pipefail

# Grab the version number
VERSION=$(cat VERSION)

# Initialize general variables
PYTHON_DIR="packages/python"
PROTO_DIR="buda"

# List all proto files
ENTITIES="$PROTO_DIR/entities/*.proto"
SERVICES="$PROTO_DIR/services/*.proto"

echo "Compiling entities"
# Compile entities
docker run --rm -i -v $PWD:$PWD -u 1000 -w $PWD \
    znly/protoc \
    --python_out=$PYTHON_DIR \
    -I. $ENTITIES

echo "Compiling services"
# Compile services
docker run --rm -v $PWD:$PWD -u 1000 -w $PWD \
    grpc/python:1.4 \
    python -m grpc_tools.protoc \
    --proto_path . \
		--python_out $PYTHON_DIR \
		--grpc_python_out $PYTHON_DIR \
		$SERVICES

# Replace version
if [ "$(uname)" == "Darwin" ]; then #on a mac
  sed -i '' "s/.*version.*/    version='$VERSION',/" $PYTHON_DIR/setup.py
else
  sed -i "s/.*version.*/    version='$VERSION',/" $PYTHON_DIR/setup.py
fi

# Compress the Python package
tar -zcvf buda-python-$VERSION.tar.gz -C packages/python/ buda setup.py
