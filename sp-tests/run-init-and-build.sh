#!/bin/bash
set -ex

source sp-tests/get-installation-directory.sh

# Save current directory
cwd=$(pwd)

# Check if the testdir folder must be deleted first
if test -d "testdir"; then
    read -p "The \"testdir\" folder already exists. Delete the folder? (y/n) " deletefolder
    if [ $deletefolder = "y" ]; then
        rm -rf testdir
    fi
fi

# Create a folder for testing
mkdir testdir
cd testdir
git init

# Copy the init script
cp ../init.sh .
chmod u+x init.sh

# Run the init script
./init.sh $install_directory

# Make a first commit
git add .
git config user.email "you@example.com"
git config user.name "Dummy user"
git commit -m 'adding all files'

# Build the documentation
cd $install_directory
make html
