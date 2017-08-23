#!/usr/bin/env sh
touch .npmrc
docker run -it --rm -v $PWD:/root -w /app node:8 npm login
