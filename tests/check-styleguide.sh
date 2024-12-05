#!/bin/bash
set -ex

# Test the documentation
make -C docs vale
