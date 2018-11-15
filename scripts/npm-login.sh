#!/usr/bin/env sh
touch .npmrc
docker run -it --rm -v $PWD:/root -w /app node:10-alpine npm login
