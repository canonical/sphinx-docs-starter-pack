#!/bin/bash
set -ex

# Test the documentation
make -C docs woke CONFIRM_SUDO=y
