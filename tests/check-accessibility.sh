#!/bin/bash
set -ex

# Test the documentation
make -C docs pa11y
