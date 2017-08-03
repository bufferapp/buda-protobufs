#!/usr/bin/env sh
protoc --plugin=protoc-gen-custom=$COMMAND.py --custom_out=/build/ -I=. buda/**/*.proto
