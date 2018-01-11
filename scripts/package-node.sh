#!/usr/bin/env bash
budapest/run -c concat -i $PWD/buda -o $PWD/packages/node/

# Update the version in the package.json
VERSION=$(<VERSION)
cd $PWD/packages/node/
npm version $VERSION --allow-same-version
