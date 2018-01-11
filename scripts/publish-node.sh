#!/usr/bin/env sh

VERSION=$(cat VERSION)
ARG="$1"
NPMRC_PATH="$HOME/.npmrc"

# For beta release: ./scripts/publish-node.sh beta
if [ $ARG == "beta" ]; then
    COMMAND="npm publish --tag beta"
else
    COMMAND="npm publish"
fi

if [ ! -f $NPMRC_PATH ]; then
    NPMRC_PATH="$PWD/.npmrc"
    if [ ! -f $NPMRC_PATH ]; then
        echo ".npmrc file not found, please run ./scripts/npm-login.sh"
        exit 1
    fi
fi

echo "Publishing @bufferapp/buda@$VERSION"
echo "$COMMAND"

docker run -it --rm \
    -v $NPMRC_PATH:/root/.npmrc \
    -v $PWD/packages/node:/app \
    -w /app \
    node:8-alpine \
    $COMMAND
