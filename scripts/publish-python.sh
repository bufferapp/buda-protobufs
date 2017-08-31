#!/usr/bin/env bash

set -eo pipefail

# Grab the version number
VERSION=$(cat VERSION)

# Upload package to Pypi
cd packages/python
python setup.py sdist
twine upload dist//buda-$VERSION.tar.gz
