#!/bin/bash
set -ex

source tests/get-installation-directory.sh

# Test the documentation
cd testdir/$install_directory
make linkcheck
