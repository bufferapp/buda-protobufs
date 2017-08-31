#!/usr/bin/env sh

set -eo pipefail

# Grab the version number
VERSION=$(cat VERSION)

cd packages/python

python setup.py sdist

twine upload dist//buda-$VERSION.tar.gz
