#!/bin/bash
set -ex

source sp-tests/get-installation-directory.sh

if [ -f "testdir/$install_directory/index.md" ];
then
    cp sp-tests/testfiles/test-md.md "testdir/$install_directory/"
    sed -i 's/contributing/test-md/g' "testdir/$install_directory/index.md"

    cd testdir/$install_directory
    make html

    grep -Fq "A documentation starter-pack" _build/test-md/index.html
    grep -Fq "Open Documentation Hour" _build/test-md/index.html

elif [ -f "testdir/$install_directory/index.rst" ];
then
    cp sp-tests/testfiles/test-rst.rst "testdir/$install_directory/"
    sed -i 's/contributing/test-rst/g' "testdir/$install_directory/index.rst"

    cd testdir/$install_directory
    make html

    grep -Fq "A documentation starter-pack" _build/test-rst/index.html
    grep -Fq "Open Documentation Hour" _build/test-rst/index.html
fi

