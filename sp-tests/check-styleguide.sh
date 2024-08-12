#!/bin/bash
set -ex

source sp-tests/get-installation-directory.sh

# Test the documentation
cd testdir/$install_directory
make vale
