#!/usr/bin/env bash

VERSION=$(cat VERSION)
ARG="$1"
PACKAGE_DIR="$PWD/packages/node/"
NPMRC_PATH="$HOME/.npmrc"

# The runtime is either node (local) or docker
RUNTIME="node"

REQUIRED_NODE_MAJOR_VERSION="8"

# Check for a valid local version of node
if output=$(which node); then
    NODE_VERSION=$(node -v)
    echo "Local node $NODE_VERSION install detected. Checking version..."

    NODE_MAJOR_VERSION=${NODE_VERSION:1:1}
    if [ $NODE_MAJOR_VERSION != $REQUIRED_NODE_MAJOR_VERSION ]; then
        echo "Version does not match required major version $REQUIRED_NODE_MAJOR_VERSION"
        RUNTIME="docker"
    fi
else
    echo "No local node install detected"
    RUNTIME="docker"
fi

# For beta release: ./scripts/publish-node.sh beta
if [ "$ARG" == "beta" ]; then
    COMMAND="npm publish --tag beta"
else
    COMMAND="npm publish"
fi

echo "Publishing @bufferapp/buda@$VERSION using $RUNTIME runtime"
echo "$COMMAND"

if [ "$RUNTIME" == "node" ]; then
    cd $PACKAGE_DIR
    $COMMAND
else
    if [ ! -f $NPMRC_PATH ]; then
        NPMRC_PATH="$PWD/.npmrc"
        if [ ! -f $NPMRC_PATH ]; then
            echo ".npmrc file not found, please run ./scripts/npm-login.sh"
            exit 1
        fi
    fi

    docker run -it --rm \
        -v $NPMRC_PATH:/root/.npmrc \
        -v $PWD/packages/node:/app \
        -w /app \
        node:8-alpine \
        $COMMAND
fi
