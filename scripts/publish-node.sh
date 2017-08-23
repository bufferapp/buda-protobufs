#!/usr/bin/env sh

docker run -it --rm -v $PWD/.npmrc:/root/.npmrc -v $PWD/packages/node:/app -w /app node:8 npm publish --tag beta 
