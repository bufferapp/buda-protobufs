#!/usr/bin/env python

from setuptools import setup
from setuptools import find_packages

requirements = [
    'grpcio',
    'protobuf'
]

setup(
    name="buda",
    version='0.2.0',
    packages=find_packages(),
    install_requires=requirements,
)
