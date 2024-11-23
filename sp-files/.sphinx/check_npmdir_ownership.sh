#!/bin/bash
#
# Some builds give a permission problem that $HOME/.npm is owned by root.
# This script rectifies that and sets $HOME/.npm to the current user
# See https://stackoverflow.com/questions/59437833/error-your-cache-folder-contains-root-owned-files-due-to-a-bug-in-previous-ver
#

dir=$HOME/.npm

#Check if directory exists
if [ ! -d "$dir" ]; then
    exit 0
fi

owner=`stat -c "%U" $dir`

if [ "$owner" = "$USER" ]; then
    exit 0
fi

echo "Changing user of $dir to $USER"
sudo chown -R $USER $dir

