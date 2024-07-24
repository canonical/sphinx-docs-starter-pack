#!/bin/bash
set -ex

source sp-tests/get-installation-directory.sh

# Copy the test files
cp sp-tests/testfiles/test-md.md testdir/$install_directory/
cp sp-tests/testfiles/test-rst.rst testdir/$install_directory/

# Include the files in the toctree
if ! grep -Fxq "   test-md" testdir/$install_directory/index.rst
then
   echo "   test-md" >> testdir/$install_directory/index.rst
   echo "   test-rst" >> testdir/$install_directory/index.rst
fi

# Build the documentation
cd testdir/$install_directory
make html

# Test the output
if ! grep -Fq "A documentation starter-pack" _build/test-md/index.html || \
        ! grep -Fq "A documentation starter-pack" _build/test-rst/index.html
then
    echo "Related links don't work (in RST or Markdown)"
    exit 1
fi

if ! grep -Fq "Open Documentation Hour" _build/test-md/index.html || \
        ! grep -Fq "Open Documentation Hour" _build/test-rst/index.html
then
    echo "Discourse links don't work (in RST or Markdown)"
    exit 1
fi
