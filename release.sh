#!/usr/bin/env bash

stubgen ./dataclassconfig -o .
python setup.py sdist bdist_wheel
twine upload --repository pypi dist/*
find dataclassconfig -name "*.pyi" -type f -delete
rm -r dist build
