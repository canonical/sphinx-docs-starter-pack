#!/bin/bash
set -ex

source tests/get-installation-directory.sh

# Copy the custom wordlist
cp tests/testfiles/.custom_wordlist.txt testdir/$install_directory/

# Test the documentation
cd testdir/$install_directory
make spelling CONFIRM_SUDO=y
