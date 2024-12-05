#!/bin/bash
set -ex

# Test the documentation
make -C docs spelling CONFIRM_SUDO=y
